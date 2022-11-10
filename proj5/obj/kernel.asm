
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
   400be:	e8 7f 05 00 00       	call   40642 <exception>

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
   40173:	e8 91 12 00 00       	call   41409 <hardware_init>
    pageinfo_init();
   40178:	e8 f0 08 00 00       	call   40a6d <pageinfo_init>
    console_clear();
   4017d:	e8 38 3c 00 00       	call   43dba <console_clear>
    timer_init(HZ);
   40182:	bf 64 00 00 00       	mov    $0x64,%edi
   40187:	e8 69 17 00 00       	call   418f5 <timer_init>

    // use virtual_memory_map to remove user permissions for kernel memory
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   4018c:	48 8b 05 6d 3e 01 00 	mov    0x13e6d(%rip),%rax        # 54000 <kernel_pagetable>
   40193:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   40199:	b9 00 00 10 00       	mov    $0x100000,%ecx
   4019e:	ba 00 00 00 00       	mov    $0x0,%edx
   401a3:	be 00 00 00 00       	mov    $0x0,%esi
   401a8:	48 89 c7             	mov    %rax,%rdi
   401ab:	e8 a3 24 00 00       	call   42653 <virtual_memory_map>
		       PROC_START_ADDR, PTE_P | PTE_W);

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   401b0:	ba 00 0e 00 00       	mov    $0xe00,%edx
   401b5:	be 00 00 00 00       	mov    $0x0,%esi
   401ba:	bf 20 10 05 00       	mov    $0x51020,%edi
   401bf:	e8 dc 2c 00 00       	call   42ea0 <memset>
    for (pid_t i = 0; i < NPROC; i++) {
   401c4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   401cb:	eb 44                	jmp    40211 <kernel+0xaa>
        processes[i].p_pid = i;
   401cd:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401d0:	48 63 d0             	movslq %eax,%rdx
   401d3:	48 89 d0             	mov    %rdx,%rax
   401d6:	48 c1 e0 03          	shl    $0x3,%rax
   401da:	48 29 d0             	sub    %rdx,%rax
   401dd:	48 c1 e0 05          	shl    $0x5,%rax
   401e1:	48 8d 90 20 10 05 00 	lea    0x51020(%rax),%rdx
   401e8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401eb:	89 02                	mov    %eax,(%rdx)
        processes[i].p_state = P_FREE;
   401ed:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401f0:	48 63 d0             	movslq %eax,%rdx
   401f3:	48 89 d0             	mov    %rdx,%rax
   401f6:	48 c1 e0 03          	shl    $0x3,%rax
   401fa:	48 29 d0             	sub    %rdx,%rax
   401fd:	48 c1 e0 05          	shl    $0x5,%rax
   40201:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   40207:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
    for (pid_t i = 0; i < NPROC; i++) {
   4020d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   40211:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   40215:	7e b6                	jle    401cd <kernel+0x66>
    }

    if (command && strcmp(command, "fork") == 0) {
   40217:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4021c:	74 29                	je     40247 <kernel+0xe0>
   4021e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40222:	be 00 3e 04 00       	mov    $0x43e00,%esi
   40227:	48 89 c7             	mov    %rax,%rdi
   4022a:	e8 6a 2d 00 00       	call   42f99 <strcmp>
   4022f:	85 c0                	test   %eax,%eax
   40231:	75 14                	jne    40247 <kernel+0xe0>
        process_setup(1, 4);
   40233:	be 04 00 00 00       	mov    $0x4,%esi
   40238:	bf 01 00 00 00       	mov    $0x1,%edi
   4023d:	e8 d1 00 00 00       	call   40313 <process_setup>
   40242:	e9 c2 00 00 00       	jmp    40309 <kernel+0x1a2>
    } else if (command && strcmp(command, "forkexit") == 0) {
   40247:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4024c:	74 29                	je     40277 <kernel+0x110>
   4024e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40252:	be 05 3e 04 00       	mov    $0x43e05,%esi
   40257:	48 89 c7             	mov    %rax,%rdi
   4025a:	e8 3a 2d 00 00       	call   42f99 <strcmp>
   4025f:	85 c0                	test   %eax,%eax
   40261:	75 14                	jne    40277 <kernel+0x110>
        process_setup(1, 5);
   40263:	be 05 00 00 00       	mov    $0x5,%esi
   40268:	bf 01 00 00 00       	mov    $0x1,%edi
   4026d:	e8 a1 00 00 00       	call   40313 <process_setup>
   40272:	e9 92 00 00 00       	jmp    40309 <kernel+0x1a2>
    } else if (command && strcmp(command, "test") == 0) {
   40277:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4027c:	74 26                	je     402a4 <kernel+0x13d>
   4027e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40282:	be 0e 3e 04 00       	mov    $0x43e0e,%esi
   40287:	48 89 c7             	mov    %rax,%rdi
   4028a:	e8 0a 2d 00 00       	call   42f99 <strcmp>
   4028f:	85 c0                	test   %eax,%eax
   40291:	75 11                	jne    402a4 <kernel+0x13d>
        process_setup(1, 6);
   40293:	be 06 00 00 00       	mov    $0x6,%esi
   40298:	bf 01 00 00 00       	mov    $0x1,%edi
   4029d:	e8 71 00 00 00       	call   40313 <process_setup>
   402a2:	eb 65                	jmp    40309 <kernel+0x1a2>
    } else if (command && strcmp(command, "test2") == 0) {
   402a4:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   402a9:	74 39                	je     402e4 <kernel+0x17d>
   402ab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   402af:	be 13 3e 04 00       	mov    $0x43e13,%esi
   402b4:	48 89 c7             	mov    %rax,%rdi
   402b7:	e8 dd 2c 00 00       	call   42f99 <strcmp>
   402bc:	85 c0                	test   %eax,%eax
   402be:	75 24                	jne    402e4 <kernel+0x17d>
        for (pid_t i = 1; i <= 2; ++i) {
   402c0:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   402c7:	eb 13                	jmp    402dc <kernel+0x175>
            process_setup(i, 6);
   402c9:	8b 45 f8             	mov    -0x8(%rbp),%eax
   402cc:	be 06 00 00 00       	mov    $0x6,%esi
   402d1:	89 c7                	mov    %eax,%edi
   402d3:	e8 3b 00 00 00       	call   40313 <process_setup>
        for (pid_t i = 1; i <= 2; ++i) {
   402d8:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   402dc:	83 7d f8 02          	cmpl   $0x2,-0x8(%rbp)
   402e0:	7e e7                	jle    402c9 <kernel+0x162>
   402e2:	eb 25                	jmp    40309 <kernel+0x1a2>
        }
    } else {
        for (pid_t i = 1; i <= 4; ++i) {
   402e4:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%rbp)
   402eb:	eb 16                	jmp    40303 <kernel+0x19c>
            process_setup(i, i - 1);
   402ed:	8b 45 f4             	mov    -0xc(%rbp),%eax
   402f0:	8d 50 ff             	lea    -0x1(%rax),%edx
   402f3:	8b 45 f4             	mov    -0xc(%rbp),%eax
   402f6:	89 d6                	mov    %edx,%esi
   402f8:	89 c7                	mov    %eax,%edi
   402fa:	e8 14 00 00 00       	call   40313 <process_setup>
        for (pid_t i = 1; i <= 4; ++i) {
   402ff:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   40303:	83 7d f4 04          	cmpl   $0x4,-0xc(%rbp)
   40307:	7e e4                	jle    402ed <kernel+0x186>
        }
    }


    // Switch to the first process using run()
    run(&processes[1]);
   40309:	bf 00 11 05 00       	mov    $0x51100,%edi
   4030e:	e8 fd 06 00 00       	call   40a10 <run>

0000000000040313 <process_setup>:
// process_setup(pid, program_number)
//    Load application program `program_number` as process number `pid`.
//    This loads the application's code and data into memory, sets its
//    %rip and %rsp, gives it a stack page, and marks it as runnable.

void process_setup(pid_t pid, int program_number) {
   40313:	55                   	push   %rbp
   40314:	48 89 e5             	mov    %rsp,%rbp
   40317:	48 83 ec 20          	sub    $0x20,%rsp
   4031b:	89 7d ec             	mov    %edi,-0x14(%rbp)
   4031e:	89 75 e8             	mov    %esi,-0x18(%rbp)
    process_init(&processes[pid], 0);
   40321:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40324:	48 63 d0             	movslq %eax,%rdx
   40327:	48 89 d0             	mov    %rdx,%rax
   4032a:	48 c1 e0 03          	shl    $0x3,%rax
   4032e:	48 29 d0             	sub    %rdx,%rax
   40331:	48 c1 e0 05          	shl    $0x5,%rax
   40335:	48 05 20 10 05 00    	add    $0x51020,%rax
   4033b:	be 00 00 00 00       	mov    $0x0,%esi
   40340:	48 89 c7             	mov    %rax,%rdi
   40343:	e8 3e 18 00 00       	call   41b86 <process_init>
    processes[pid].p_pagetable = kernel_pagetable;
   40348:	48 8b 0d b1 3c 01 00 	mov    0x13cb1(%rip),%rcx        # 54000 <kernel_pagetable>
   4034f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40352:	48 63 d0             	movslq %eax,%rdx
   40355:	48 89 d0             	mov    %rdx,%rax
   40358:	48 c1 e0 03          	shl    $0x3,%rax
   4035c:	48 29 d0             	sub    %rdx,%rax
   4035f:	48 c1 e0 05          	shl    $0x5,%rax
   40363:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   40369:	48 89 08             	mov    %rcx,(%rax)
    ++pageinfo[PAGENUMBER(kernel_pagetable)].refcount; //increase refcount since kernel_pagetable was used
   4036c:	48 8b 05 8d 3c 01 00 	mov    0x13c8d(%rip),%rax        # 54000 <kernel_pagetable>
   40373:	48 c1 e8 0c          	shr    $0xc,%rax
   40377:	89 c2                	mov    %eax,%edx
   40379:	48 63 c2             	movslq %edx,%rax
   4037c:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   40383:	00 
   40384:	83 c0 01             	add    $0x1,%eax
   40387:	89 c1                	mov    %eax,%ecx
   40389:	48 63 c2             	movslq %edx,%rax
   4038c:	88 8c 00 41 1e 05 00 	mov    %cl,0x51e41(%rax,%rax,1)

    int r = program_load(&processes[pid], program_number, NULL);
   40393:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40396:	48 63 d0             	movslq %eax,%rdx
   40399:	48 89 d0             	mov    %rdx,%rax
   4039c:	48 c1 e0 03          	shl    $0x3,%rax
   403a0:	48 29 d0             	sub    %rdx,%rax
   403a3:	48 c1 e0 05          	shl    $0x5,%rax
   403a7:	48 8d 88 20 10 05 00 	lea    0x51020(%rax),%rcx
   403ae:	8b 45 e8             	mov    -0x18(%rbp),%eax
   403b1:	ba 00 00 00 00       	mov    $0x0,%edx
   403b6:	89 c6                	mov    %eax,%esi
   403b8:	48 89 cf             	mov    %rcx,%rdi
   403bb:	e8 45 27 00 00       	call   42b05 <program_load>
   403c0:	89 45 fc             	mov    %eax,-0x4(%rbp)
    assert(r >= 0);
   403c3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   403c7:	79 14                	jns    403dd <process_setup+0xca>
   403c9:	ba 19 3e 04 00       	mov    $0x43e19,%edx
   403ce:	be 86 00 00 00       	mov    $0x86,%esi
   403d3:	bf 20 3e 04 00       	mov    $0x43e20,%edi
   403d8:	e8 77 1f 00 00       	call   42354 <assert_fail>

    processes[pid].p_registers.reg_rsp = PROC_START_ADDR + PROC_SIZE * pid;
   403dd:	8b 45 ec             	mov    -0x14(%rbp),%eax
   403e0:	83 c0 04             	add    $0x4,%eax
   403e3:	c1 e0 12             	shl    $0x12,%eax
   403e6:	48 63 c8             	movslq %eax,%rcx
   403e9:	8b 45 ec             	mov    -0x14(%rbp),%eax
   403ec:	48 63 d0             	movslq %eax,%rdx
   403ef:	48 89 d0             	mov    %rdx,%rax
   403f2:	48 c1 e0 03          	shl    $0x3,%rax
   403f6:	48 29 d0             	sub    %rdx,%rax
   403f9:	48 c1 e0 05          	shl    $0x5,%rax
   403fd:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   40403:	48 89 08             	mov    %rcx,(%rax)
    uintptr_t stack_page = processes[pid].p_registers.reg_rsp - PAGESIZE;
   40406:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40409:	48 63 d0             	movslq %eax,%rdx
   4040c:	48 89 d0             	mov    %rdx,%rax
   4040f:	48 c1 e0 03          	shl    $0x3,%rax
   40413:	48 29 d0             	sub    %rdx,%rax
   40416:	48 c1 e0 05          	shl    $0x5,%rax
   4041a:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   40420:	48 8b 00             	mov    (%rax),%rax
   40423:	48 2d 00 10 00 00    	sub    $0x1000,%rax
   40429:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assign_physical_page(stack_page, pid);
   4042d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40430:	0f be d0             	movsbl %al,%edx
   40433:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40437:	89 d6                	mov    %edx,%esi
   40439:	48 89 c7             	mov    %rax,%rdi
   4043c:	e8 5b 00 00 00       	call   4049c <assign_physical_page>
    virtual_memory_map(processes[pid].p_pagetable, stack_page, stack_page,
   40441:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40444:	48 63 d0             	movslq %eax,%rdx
   40447:	48 89 d0             	mov    %rdx,%rax
   4044a:	48 c1 e0 03          	shl    $0x3,%rax
   4044e:	48 29 d0             	sub    %rdx,%rax
   40451:	48 c1 e0 05          	shl    $0x5,%rax
   40455:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   4045b:	48 8b 00             	mov    (%rax),%rax
   4045e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40462:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   40466:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4046c:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40471:	48 89 c7             	mov    %rax,%rdi
   40474:	e8 da 21 00 00       	call   42653 <virtual_memory_map>
                       PAGESIZE, PTE_P | PTE_W | PTE_U);
    processes[pid].p_state = P_RUNNABLE;
   40479:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4047c:	48 63 d0             	movslq %eax,%rdx
   4047f:	48 89 d0             	mov    %rdx,%rax
   40482:	48 c1 e0 03          	shl    $0x3,%rax
   40486:	48 29 d0             	sub    %rdx,%rax
   40489:	48 c1 e0 05          	shl    $0x5,%rax
   4048d:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   40493:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
}
   40499:	90                   	nop
   4049a:	c9                   	leave  
   4049b:	c3                   	ret    

000000000004049c <assign_physical_page>:
// assign_physical_page(addr, owner)
//    Allocates the page with physical address `addr` to the given owner.
//    Fails if physical page `addr` was already allocated. Returns 0 on
//    success and -1 on failure. Used by the program loader.

int assign_physical_page(uintptr_t addr, int8_t owner) {
   4049c:	55                   	push   %rbp
   4049d:	48 89 e5             	mov    %rsp,%rbp
   404a0:	48 83 ec 10          	sub    $0x10,%rsp
   404a4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   404a8:	89 f0                	mov    %esi,%eax
   404aa:	88 45 f4             	mov    %al,-0xc(%rbp)
    if ((addr & 0xFFF) != 0
   404ad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   404b1:	25 ff 0f 00 00       	and    $0xfff,%eax
   404b6:	48 85 c0             	test   %rax,%rax
   404b9:	75 20                	jne    404db <assign_physical_page+0x3f>
        || addr >= MEMSIZE_PHYSICAL
   404bb:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   404c2:	00 
   404c3:	77 16                	ja     404db <assign_physical_page+0x3f>
        || pageinfo[PAGENUMBER(addr)].refcount != 0) {
   404c5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   404c9:	48 c1 e8 0c          	shr    $0xc,%rax
   404cd:	48 98                	cltq   
   404cf:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   404d6:	00 
   404d7:	84 c0                	test   %al,%al
   404d9:	74 07                	je     404e2 <assign_physical_page+0x46>
        return -1;
   404db:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   404e0:	eb 2c                	jmp    4050e <assign_physical_page+0x72>
    } else {
        pageinfo[PAGENUMBER(addr)].refcount = 1;
   404e2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   404e6:	48 c1 e8 0c          	shr    $0xc,%rax
   404ea:	48 98                	cltq   
   404ec:	c6 84 00 41 1e 05 00 	movb   $0x1,0x51e41(%rax,%rax,1)
   404f3:	01 
        pageinfo[PAGENUMBER(addr)].owner = owner;
   404f4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   404f8:	48 c1 e8 0c          	shr    $0xc,%rax
   404fc:	48 98                	cltq   
   404fe:	0f b6 55 f4          	movzbl -0xc(%rbp),%edx
   40502:	88 94 00 40 1e 05 00 	mov    %dl,0x51e40(%rax,%rax,1)
        return 0;
   40509:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   4050e:	c9                   	leave  
   4050f:	c3                   	ret    

0000000000040510 <syscall_mapping>:

void syscall_mapping(proc* p){
   40510:	55                   	push   %rbp
   40511:	48 89 e5             	mov    %rsp,%rbp
   40514:	48 83 ec 70          	sub    $0x70,%rsp
   40518:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)

    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
   4051c:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40520:	48 8b 40 38          	mov    0x38(%rax),%rax
   40524:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t ptr = p->p_registers.reg_rsi;
   40528:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4052c:	48 8b 40 30          	mov    0x30(%rax),%rax
   40530:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    //convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);
   40534:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40538:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   4053f:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   40543:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40547:	48 89 ce             	mov    %rcx,%rsi
   4054a:	48 89 c7             	mov    %rax,%rdi
   4054d:	e8 bc 24 00 00       	call   42a0e <virtual_memory_lookup>

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
   40552:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40555:	48 98                	cltq   
   40557:	83 e0 06             	and    $0x6,%eax
   4055a:	48 83 f8 06          	cmp    $0x6,%rax
   4055e:	75 73                	jne    405d3 <syscall_mapping+0xc3>
	return;
    uintptr_t endaddr = map.pa + sizeof(vamapping) - 1;
   40560:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40564:	48 83 c0 17          	add    $0x17,%rax
   40568:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    // check for write access for end address
    vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
   4056c:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40570:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40577:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   4057b:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   4057f:	48 89 ce             	mov    %rcx,%rsi
   40582:	48 89 c7             	mov    %rax,%rdi
   40585:	e8 84 24 00 00       	call   42a0e <virtual_memory_lookup>
    if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
   4058a:	8b 45 c8             	mov    -0x38(%rbp),%eax
   4058d:	48 98                	cltq   
   4058f:	83 e0 03             	and    $0x3,%eax
   40592:	48 83 f8 03          	cmp    $0x3,%rax
   40596:	75 3e                	jne    405d6 <syscall_mapping+0xc6>
	return;
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
   40598:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4059c:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   405a3:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   405a7:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   405ab:	48 89 ce             	mov    %rcx,%rsi
   405ae:	48 89 c7             	mov    %rax,%rdi
   405b1:	e8 58 24 00 00       	call   42a0e <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   405b6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   405ba:	48 89 c1             	mov    %rax,%rcx
   405bd:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   405c1:	ba 18 00 00 00       	mov    $0x18,%edx
   405c6:	48 89 c6             	mov    %rax,%rsi
   405c9:	48 89 cf             	mov    %rcx,%rdi
   405cc:	e8 d1 27 00 00       	call   42da2 <memcpy>
   405d1:	eb 04                	jmp    405d7 <syscall_mapping+0xc7>
	return;
   405d3:	90                   	nop
   405d4:	eb 01                	jmp    405d7 <syscall_mapping+0xc7>
	return;
   405d6:	90                   	nop
}
   405d7:	c9                   	leave  
   405d8:	c3                   	ret    

00000000000405d9 <syscall_mem_tog>:

void syscall_mem_tog(proc* process){
   405d9:	55                   	push   %rbp
   405da:	48 89 e5             	mov    %rsp,%rbp
   405dd:	48 83 ec 18          	sub    $0x18,%rsp
   405e1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)

    pid_t p = process->p_registers.reg_rdi;
   405e5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   405e9:	48 8b 40 38          	mov    0x38(%rax),%rax
   405ed:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(p == 0) {
   405f0:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   405f4:	75 14                	jne    4060a <syscall_mem_tog+0x31>
        disp_global = !disp_global;
   405f6:	0f b6 05 03 4a 00 00 	movzbl 0x4a03(%rip),%eax        # 45000 <disp_global>
   405fd:	84 c0                	test   %al,%al
   405ff:	0f 94 c0             	sete   %al
   40602:	88 05 f8 49 00 00    	mov    %al,0x49f8(%rip)        # 45000 <disp_global>
   40608:	eb 36                	jmp    40640 <syscall_mem_tog+0x67>
    }
    else {
        if(p < 0 || p > NPROC || p != process->p_pid)
   4060a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4060e:	78 2f                	js     4063f <syscall_mem_tog+0x66>
   40610:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   40614:	7f 29                	jg     4063f <syscall_mem_tog+0x66>
   40616:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4061a:	8b 00                	mov    (%rax),%eax
   4061c:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   4061f:	75 1e                	jne    4063f <syscall_mem_tog+0x66>
            return;
        process->display_status = !(process->display_status);
   40621:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40625:	0f b6 80 d8 00 00 00 	movzbl 0xd8(%rax),%eax
   4062c:	84 c0                	test   %al,%al
   4062e:	0f 94 c0             	sete   %al
   40631:	89 c2                	mov    %eax,%edx
   40633:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40637:	88 90 d8 00 00 00    	mov    %dl,0xd8(%rax)
   4063d:	eb 01                	jmp    40640 <syscall_mem_tog+0x67>
            return;
   4063f:	90                   	nop
    }
}
   40640:	c9                   	leave  
   40641:	c3                   	ret    

0000000000040642 <exception>:
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_64_registers* reg) {
   40642:	55                   	push   %rbp
   40643:	48 89 e5             	mov    %rsp,%rbp
   40646:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
   4064d:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   40654:	48 8b 05 a5 09 01 00 	mov    0x109a5(%rip),%rax        # 51000 <current>
   4065b:	48 8b 95 08 ff ff ff 	mov    -0xf8(%rbp),%rdx
   40662:	48 83 c0 08          	add    $0x8,%rax
   40666:	48 89 d6             	mov    %rdx,%rsi
   40669:	ba 18 00 00 00       	mov    $0x18,%edx
   4066e:	48 89 c7             	mov    %rax,%rdi
   40671:	48 89 d1             	mov    %rdx,%rcx
   40674:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   40677:	48 8b 05 82 39 01 00 	mov    0x13982(%rip),%rax        # 54000 <kernel_pagetable>
   4067e:	48 89 c7             	mov    %rax,%rdi
   40681:	e8 9c 1e 00 00       	call   42522 <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   40686:	8b 05 70 89 07 00    	mov    0x78970(%rip),%eax        # b8ffc <cursorpos>
   4068c:	89 c7                	mov    %eax,%edi
   4068e:	e8 bd 15 00 00       	call   41c50 <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT && reg->reg_intno != INT_GPF) // no error due to pagefault or general fault
   40693:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   4069a:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   406a1:	48 83 f8 0e          	cmp    $0xe,%rax
   406a5:	74 14                	je     406bb <exception+0x79>
   406a7:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   406ae:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   406b5:	48 83 f8 0d          	cmp    $0xd,%rax
   406b9:	75 16                	jne    406d1 <exception+0x8f>
            || (reg->reg_err & PFERR_USER)) // pagefault error in user mode 
   406bb:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   406c2:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   406c9:	83 e0 04             	and    $0x4,%eax
   406cc:	48 85 c0             	test   %rax,%rax
   406cf:	74 1a                	je     406eb <exception+0xa9>
    {
        check_virtual_memory();
   406d1:	e8 2e 07 00 00       	call   40e04 <check_virtual_memory>
        if(disp_global){
   406d6:	0f b6 05 23 49 00 00 	movzbl 0x4923(%rip),%eax        # 45000 <disp_global>
   406dd:	84 c0                	test   %al,%al
   406df:	74 0a                	je     406eb <exception+0xa9>
            memshow_physical();
   406e1:	e8 96 08 00 00       	call   40f7c <memshow_physical>
            memshow_virtual_animate();
   406e6:	e8 c0 0b 00 00       	call   412ab <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   406eb:	e8 43 1a 00 00       	call   42133 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   406f0:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   406f7:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   406fe:	48 83 e8 0e          	sub    $0xe,%rax
   40702:	48 83 f8 2a          	cmp    $0x2a,%rax
   40706:	0f 87 55 02 00 00    	ja     40961 <exception+0x31f>
   4070c:	48 8b 04 c5 c0 3e 04 	mov    0x43ec0(,%rax,8),%rax
   40713:	00 
   40714:	ff e0                	jmp    *%rax

    case INT_SYS_PANIC:
	    // rdi stores pointer for msg string
	    {
		char msg[160];
		uintptr_t addr = current->p_registers.reg_rdi;
   40716:	48 8b 05 e3 08 01 00 	mov    0x108e3(%rip),%rax        # 51000 <current>
   4071d:	48 8b 40 38          	mov    0x38(%rax),%rax
   40721:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
		if((void *)addr == NULL)
   40725:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4072a:	75 0f                	jne    4073b <exception+0xf9>
		    panic(NULL);
   4072c:	bf 00 00 00 00       	mov    $0x0,%edi
   40731:	b8 00 00 00 00       	mov    $0x0,%eax
   40736:	e8 39 1b 00 00       	call   42274 <panic>
		vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   4073b:	48 8b 05 be 08 01 00 	mov    0x108be(%rip),%rax        # 51000 <current>
   40742:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40749:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   4074d:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   40751:	48 89 ce             	mov    %rcx,%rsi
   40754:	48 89 c7             	mov    %rax,%rdi
   40757:	e8 b2 22 00 00       	call   42a0e <virtual_memory_lookup>
		memcpy(msg, (void *)map.pa, 160);
   4075c:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40760:	48 89 c1             	mov    %rax,%rcx
   40763:	48 8d 85 10 ff ff ff 	lea    -0xf0(%rbp),%rax
   4076a:	ba a0 00 00 00       	mov    $0xa0,%edx
   4076f:	48 89 ce             	mov    %rcx,%rsi
   40772:	48 89 c7             	mov    %rax,%rdi
   40775:	e8 28 26 00 00       	call   42da2 <memcpy>
		panic(msg);
   4077a:	48 8d 85 10 ff ff ff 	lea    -0xf0(%rbp),%rax
   40781:	48 89 c7             	mov    %rax,%rdi
   40784:	b8 00 00 00 00       	mov    $0x0,%eax
   40789:	e8 e6 1a 00 00       	call   42274 <panic>
	    }
	    panic(NULL);
	    break;                  // will not be reached

    case INT_SYS_GETPID:
        current->p_registers.reg_rax = current->p_pid;
   4078e:	48 8b 05 6b 08 01 00 	mov    0x1086b(%rip),%rax        # 51000 <current>
   40795:	8b 10                	mov    (%rax),%edx
   40797:	48 8b 05 62 08 01 00 	mov    0x10862(%rip),%rax        # 51000 <current>
   4079e:	48 63 d2             	movslq %edx,%rdx
   407a1:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   407a5:	e9 c7 01 00 00       	jmp    40971 <exception+0x32f>

    case INT_SYS_YIELD:
        schedule();
   407aa:	e8 eb 01 00 00       	call   4099a <schedule>
        break;                  /* will not be reached */
   407af:	e9 bd 01 00 00       	jmp    40971 <exception+0x32f>

    case INT_SYS_PAGE_ALLOC: {
        uintptr_t addr = current->p_registers.reg_rdi;
   407b4:	48 8b 05 45 08 01 00 	mov    0x10845(%rip),%rax        # 51000 <current>
   407bb:	48 8b 40 38          	mov    0x38(%rax),%rax
   407bf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        int r = assign_physical_page(addr, current->p_pid);
   407c3:	48 8b 05 36 08 01 00 	mov    0x10836(%rip),%rax        # 51000 <current>
   407ca:	8b 00                	mov    (%rax),%eax
   407cc:	0f be d0             	movsbl %al,%edx
   407cf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   407d3:	89 d6                	mov    %edx,%esi
   407d5:	48 89 c7             	mov    %rax,%rdi
   407d8:	e8 bf fc ff ff       	call   4049c <assign_physical_page>
   407dd:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (r >= 0) {
   407e0:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   407e4:	78 29                	js     4080f <exception+0x1cd>
            virtual_memory_map(current->p_pagetable, addr, addr,
   407e6:	48 8b 05 13 08 01 00 	mov    0x10813(%rip),%rax        # 51000 <current>
   407ed:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   407f4:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   407f8:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   407fc:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40802:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40807:	48 89 c7             	mov    %rax,%rdi
   4080a:	e8 44 1e 00 00       	call   42653 <virtual_memory_map>
                               PAGESIZE, PTE_P | PTE_W | PTE_U);
        }
        current->p_registers.reg_rax = r;
   4080f:	48 8b 05 ea 07 01 00 	mov    0x107ea(%rip),%rax        # 51000 <current>
   40816:	8b 55 f4             	mov    -0xc(%rbp),%edx
   40819:	48 63 d2             	movslq %edx,%rdx
   4081c:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   40820:	e9 4c 01 00 00       	jmp    40971 <exception+0x32f>
    }

    case INT_SYS_MAPPING:
    {
	    syscall_mapping(current);
   40825:	48 8b 05 d4 07 01 00 	mov    0x107d4(%rip),%rax        # 51000 <current>
   4082c:	48 89 c7             	mov    %rax,%rdi
   4082f:	e8 dc fc ff ff       	call   40510 <syscall_mapping>
            break;
   40834:	e9 38 01 00 00       	jmp    40971 <exception+0x32f>
    }

    case INT_SYS_MEM_TOG:
	{
	    syscall_mem_tog(current);
   40839:	48 8b 05 c0 07 01 00 	mov    0x107c0(%rip),%rax        # 51000 <current>
   40840:	48 89 c7             	mov    %rax,%rdi
   40843:	e8 91 fd ff ff       	call   405d9 <syscall_mem_tog>
	    break;
   40848:	e9 24 01 00 00       	jmp    40971 <exception+0x32f>
	}

    case INT_TIMER:
        ++ticks;
   4084d:	8b 05 cd 15 01 00    	mov    0x115cd(%rip),%eax        # 51e20 <ticks>
   40853:	83 c0 01             	add    $0x1,%eax
   40856:	89 05 c4 15 01 00    	mov    %eax,0x115c4(%rip)        # 51e20 <ticks>
        schedule();
   4085c:	e8 39 01 00 00       	call   4099a <schedule>
        break;                  /* will not be reached */
   40861:	e9 0b 01 00 00       	jmp    40971 <exception+0x32f>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   40866:	0f 20 d0             	mov    %cr2,%rax
   40869:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    return val;
   4086d:	48 8b 45 c8          	mov    -0x38(%rbp),%rax

    case INT_PAGEFAULT: {
        // Analyze faulting address and access type.
        uintptr_t addr = rcr2();
   40871:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
        const char* operation = reg->reg_err & PFERR_WRITE
   40875:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   4087c:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40883:	83 e0 02             	and    $0x2,%eax
                ? "write" : "read";
   40886:	48 85 c0             	test   %rax,%rax
   40889:	74 07                	je     40892 <exception+0x250>
   4088b:	b8 30 3e 04 00       	mov    $0x43e30,%eax
   40890:	eb 05                	jmp    40897 <exception+0x255>
   40892:	b8 36 3e 04 00       	mov    $0x43e36,%eax
        const char* operation = reg->reg_err & PFERR_WRITE
   40897:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        const char* problem = reg->reg_err & PFERR_PRESENT
   4089b:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   408a2:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   408a9:	83 e0 01             	and    $0x1,%eax
                ? "protection problem" : "missing page";
   408ac:	48 85 c0             	test   %rax,%rax
   408af:	74 07                	je     408b8 <exception+0x276>
   408b1:	b8 3b 3e 04 00       	mov    $0x43e3b,%eax
   408b6:	eb 05                	jmp    408bd <exception+0x27b>
   408b8:	b8 4e 3e 04 00       	mov    $0x43e4e,%eax
        const char* problem = reg->reg_err & PFERR_PRESENT
   408bd:	48 89 45 d0          	mov    %rax,-0x30(%rbp)

        if (!(reg->reg_err & PFERR_USER)) {
   408c1:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   408c8:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   408cf:	83 e0 04             	and    $0x4,%eax
   408d2:	48 85 c0             	test   %rax,%rax
   408d5:	75 2f                	jne    40906 <exception+0x2c4>
            panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   408d7:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   408de:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   408e5:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
   408e9:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   408ed:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   408f1:	49 89 f0             	mov    %rsi,%r8
   408f4:	48 89 c6             	mov    %rax,%rsi
   408f7:	bf 60 3e 04 00       	mov    $0x43e60,%edi
   408fc:	b8 00 00 00 00       	mov    $0x0,%eax
   40901:	e8 6e 19 00 00       	call   42274 <panic>
                  addr, operation, problem, reg->reg_rip);
        }
        console_printf(CPOS(24, 0), 0x0C00,
   40906:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   4090d:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                       "Process %d page fault for %p (%s %s, rip=%p)!\n",
                       current->p_pid, addr, operation, problem, reg->reg_rip);
   40914:	48 8b 05 e5 06 01 00 	mov    0x106e5(%rip),%rax        # 51000 <current>
        console_printf(CPOS(24, 0), 0x0C00,
   4091b:	8b 00                	mov    (%rax),%eax
   4091d:	48 8b 75 d8          	mov    -0x28(%rbp),%rsi
   40921:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   40925:	52                   	push   %rdx
   40926:	ff 75 d0             	push   -0x30(%rbp)
   40929:	49 89 f1             	mov    %rsi,%r9
   4092c:	49 89 c8             	mov    %rcx,%r8
   4092f:	89 c1                	mov    %eax,%ecx
   40931:	ba 90 3e 04 00       	mov    $0x43e90,%edx
   40936:	be 00 0c 00 00       	mov    $0xc00,%esi
   4093b:	bf 80 07 00 00       	mov    $0x780,%edi
   40940:	b8 00 00 00 00       	mov    $0x0,%eax
   40945:	e8 0d 33 00 00       	call   43c57 <console_printf>
   4094a:	48 83 c4 10          	add    $0x10,%rsp
        current->p_state = P_BROKEN;
   4094e:	48 8b 05 ab 06 01 00 	mov    0x106ab(%rip),%rax        # 51000 <current>
   40955:	c7 80 c8 00 00 00 03 	movl   $0x3,0xc8(%rax)
   4095c:	00 00 00 
        break;
   4095f:	eb 10                	jmp    40971 <exception+0x32f>
    }

    default:
        default_exception(current);
   40961:	48 8b 05 98 06 01 00 	mov    0x10698(%rip),%rax        # 51000 <current>
   40968:	48 89 c7             	mov    %rax,%rdi
   4096b:	e8 14 1a 00 00       	call   42384 <default_exception>
        break;                  /* will not be reached */
   40970:	90                   	nop

    }


    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   40971:	48 8b 05 88 06 01 00 	mov    0x10688(%rip),%rax        # 51000 <current>
   40978:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   4097e:	83 f8 01             	cmp    $0x1,%eax
   40981:	75 0f                	jne    40992 <exception+0x350>
        run(current);
   40983:	48 8b 05 76 06 01 00 	mov    0x10676(%rip),%rax        # 51000 <current>
   4098a:	48 89 c7             	mov    %rax,%rdi
   4098d:	e8 7e 00 00 00       	call   40a10 <run>
    } else {
        schedule();
   40992:	e8 03 00 00 00       	call   4099a <schedule>
    }
}
   40997:	90                   	nop
   40998:	c9                   	leave  
   40999:	c3                   	ret    

000000000004099a <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   4099a:	55                   	push   %rbp
   4099b:	48 89 e5             	mov    %rsp,%rbp
   4099e:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   409a2:	48 8b 05 57 06 01 00 	mov    0x10657(%rip),%rax        # 51000 <current>
   409a9:	8b 00                	mov    (%rax),%eax
   409ab:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   409ae:	8b 45 fc             	mov    -0x4(%rbp),%eax
   409b1:	8d 50 01             	lea    0x1(%rax),%edx
   409b4:	89 d0                	mov    %edx,%eax
   409b6:	c1 f8 1f             	sar    $0x1f,%eax
   409b9:	c1 e8 1c             	shr    $0x1c,%eax
   409bc:	01 c2                	add    %eax,%edx
   409be:	83 e2 0f             	and    $0xf,%edx
   409c1:	29 c2                	sub    %eax,%edx
   409c3:	89 55 fc             	mov    %edx,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   409c6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   409c9:	48 63 d0             	movslq %eax,%rdx
   409cc:	48 89 d0             	mov    %rdx,%rax
   409cf:	48 c1 e0 03          	shl    $0x3,%rax
   409d3:	48 29 d0             	sub    %rdx,%rax
   409d6:	48 c1 e0 05          	shl    $0x5,%rax
   409da:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   409e0:	8b 00                	mov    (%rax),%eax
   409e2:	83 f8 01             	cmp    $0x1,%eax
   409e5:	75 22                	jne    40a09 <schedule+0x6f>
            run(&processes[pid]);
   409e7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   409ea:	48 63 d0             	movslq %eax,%rdx
   409ed:	48 89 d0             	mov    %rdx,%rax
   409f0:	48 c1 e0 03          	shl    $0x3,%rax
   409f4:	48 29 d0             	sub    %rdx,%rax
   409f7:	48 c1 e0 05          	shl    $0x5,%rax
   409fb:	48 05 20 10 05 00    	add    $0x51020,%rax
   40a01:	48 89 c7             	mov    %rax,%rdi
   40a04:	e8 07 00 00 00       	call   40a10 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   40a09:	e8 25 17 00 00       	call   42133 <check_keyboard>
        pid = (pid + 1) % NPROC;
   40a0e:	eb 9e                	jmp    409ae <schedule+0x14>

0000000000040a10 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   40a10:	55                   	push   %rbp
   40a11:	48 89 e5             	mov    %rsp,%rbp
   40a14:	48 83 ec 10          	sub    $0x10,%rsp
   40a18:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   40a1c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a20:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   40a26:	83 f8 01             	cmp    $0x1,%eax
   40a29:	74 14                	je     40a3f <run+0x2f>
   40a2b:	ba 18 40 04 00       	mov    $0x44018,%edx
   40a30:	be 5b 01 00 00       	mov    $0x15b,%esi
   40a35:	bf 20 3e 04 00       	mov    $0x43e20,%edi
   40a3a:	e8 15 19 00 00       	call   42354 <assert_fail>
    current = p;
   40a3f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a43:	48 89 05 b6 05 01 00 	mov    %rax,0x105b6(%rip)        # 51000 <current>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   40a4a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a4e:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40a55:	48 89 c7             	mov    %rax,%rdi
   40a58:	e8 c5 1a 00 00       	call   42522 <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   40a5d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a61:	48 83 c0 08          	add    $0x8,%rax
   40a65:	48 89 c7             	mov    %rax,%rdi
   40a68:	e8 56 f6 ff ff       	call   400c3 <exception_return>

0000000000040a6d <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   40a6d:	55                   	push   %rbp
   40a6e:	48 89 e5             	mov    %rsp,%rbp
   40a71:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40a75:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40a7c:	00 
   40a7d:	e9 81 00 00 00       	jmp    40b03 <pageinfo_init+0x96>
        int owner;
        if (physical_memory_isreserved(addr)) {
   40a82:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a86:	48 89 c7             	mov    %rax,%rdi
   40a89:	e8 33 0f 00 00       	call   419c1 <physical_memory_isreserved>
   40a8e:	85 c0                	test   %eax,%eax
   40a90:	74 09                	je     40a9b <pageinfo_init+0x2e>
            owner = PO_RESERVED;
   40a92:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   40a99:	eb 2f                	jmp    40aca <pageinfo_init+0x5d>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   40a9b:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   40aa2:	00 
   40aa3:	76 0b                	jbe    40ab0 <pageinfo_init+0x43>
   40aa5:	b8 08 a0 05 00       	mov    $0x5a008,%eax
   40aaa:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40aae:	72 0a                	jb     40aba <pageinfo_init+0x4d>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   40ab0:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   40ab7:	00 
   40ab8:	75 09                	jne    40ac3 <pageinfo_init+0x56>
            owner = PO_KERNEL;
   40aba:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   40ac1:	eb 07                	jmp    40aca <pageinfo_init+0x5d>
        } else {
            owner = PO_FREE;
   40ac3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40aca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40ace:	48 c1 e8 0c          	shr    $0xc,%rax
   40ad2:	89 c1                	mov    %eax,%ecx
   40ad4:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40ad7:	89 c2                	mov    %eax,%edx
   40ad9:	48 63 c1             	movslq %ecx,%rax
   40adc:	88 94 00 40 1e 05 00 	mov    %dl,0x51e40(%rax,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   40ae3:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40ae7:	0f 95 c2             	setne  %dl
   40aea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40aee:	48 c1 e8 0c          	shr    $0xc,%rax
   40af2:	48 98                	cltq   
   40af4:	88 94 00 41 1e 05 00 	mov    %dl,0x51e41(%rax,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40afb:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40b02:	00 
   40b03:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40b0a:	00 
   40b0b:	0f 86 71 ff ff ff    	jbe    40a82 <pageinfo_init+0x15>
    }
}
   40b11:	90                   	nop
   40b12:	90                   	nop
   40b13:	c9                   	leave  
   40b14:	c3                   	ret    

0000000000040b15 <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   40b15:	55                   	push   %rbp
   40b16:	48 89 e5             	mov    %rsp,%rbp
   40b19:	48 83 ec 50          	sub    $0x50,%rsp
   40b1d:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   40b21:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40b25:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40b2b:	48 89 c2             	mov    %rax,%rdx
   40b2e:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40b32:	48 39 c2             	cmp    %rax,%rdx
   40b35:	74 14                	je     40b4b <check_page_table_mappings+0x36>
   40b37:	ba 38 40 04 00       	mov    $0x44038,%edx
   40b3c:	be 85 01 00 00       	mov    $0x185,%esi
   40b41:	bf 20 3e 04 00       	mov    $0x43e20,%edi
   40b46:	e8 09 18 00 00       	call   42354 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40b4b:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   40b52:	00 
   40b53:	e9 9a 00 00 00       	jmp    40bf2 <check_page_table_mappings+0xdd>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   40b58:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   40b5c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40b60:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40b64:	48 89 ce             	mov    %rcx,%rsi
   40b67:	48 89 c7             	mov    %rax,%rdi
   40b6a:	e8 9f 1e 00 00       	call   42a0e <virtual_memory_lookup>
        if (vam.pa != va) {
   40b6f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40b73:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40b77:	74 27                	je     40ba0 <check_page_table_mappings+0x8b>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   40b79:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40b7d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40b81:	49 89 d0             	mov    %rdx,%r8
   40b84:	48 89 c1             	mov    %rax,%rcx
   40b87:	ba 57 40 04 00       	mov    $0x44057,%edx
   40b8c:	be 00 c0 00 00       	mov    $0xc000,%esi
   40b91:	bf e0 06 00 00       	mov    $0x6e0,%edi
   40b96:	b8 00 00 00 00       	mov    $0x0,%eax
   40b9b:	e8 b7 30 00 00       	call   43c57 <console_printf>
        }
        assert(vam.pa == va);
   40ba0:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40ba4:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40ba8:	74 14                	je     40bbe <check_page_table_mappings+0xa9>
   40baa:	ba 61 40 04 00       	mov    $0x44061,%edx
   40baf:	be 8e 01 00 00       	mov    $0x18e,%esi
   40bb4:	bf 20 3e 04 00       	mov    $0x43e20,%edi
   40bb9:	e8 96 17 00 00       	call   42354 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   40bbe:	b8 00 50 04 00       	mov    $0x45000,%eax
   40bc3:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40bc7:	72 21                	jb     40bea <check_page_table_mappings+0xd5>
            assert(vam.perm & PTE_W);
   40bc9:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40bcc:	48 98                	cltq   
   40bce:	83 e0 02             	and    $0x2,%eax
   40bd1:	48 85 c0             	test   %rax,%rax
   40bd4:	75 14                	jne    40bea <check_page_table_mappings+0xd5>
   40bd6:	ba 6e 40 04 00       	mov    $0x4406e,%edx
   40bdb:	be 90 01 00 00       	mov    $0x190,%esi
   40be0:	bf 20 3e 04 00       	mov    $0x43e20,%edi
   40be5:	e8 6a 17 00 00       	call   42354 <assert_fail>
         va += PAGESIZE) {
   40bea:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40bf1:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40bf2:	b8 08 a0 05 00       	mov    $0x5a008,%eax
   40bf7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40bfb:	0f 82 57 ff ff ff    	jb     40b58 <check_page_table_mappings+0x43>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   40c01:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   40c08:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   40c09:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   40c0d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40c11:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40c15:	48 89 ce             	mov    %rcx,%rsi
   40c18:	48 89 c7             	mov    %rax,%rdi
   40c1b:	e8 ee 1d 00 00       	call   42a0e <virtual_memory_lookup>
    assert(vam.pa == kstack);
   40c20:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40c24:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   40c28:	74 14                	je     40c3e <check_page_table_mappings+0x129>
   40c2a:	ba 7f 40 04 00       	mov    $0x4407f,%edx
   40c2f:	be 97 01 00 00       	mov    $0x197,%esi
   40c34:	bf 20 3e 04 00       	mov    $0x43e20,%edi
   40c39:	e8 16 17 00 00       	call   42354 <assert_fail>
    assert(vam.perm & PTE_W);
   40c3e:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40c41:	48 98                	cltq   
   40c43:	83 e0 02             	and    $0x2,%eax
   40c46:	48 85 c0             	test   %rax,%rax
   40c49:	75 14                	jne    40c5f <check_page_table_mappings+0x14a>
   40c4b:	ba 6e 40 04 00       	mov    $0x4406e,%edx
   40c50:	be 98 01 00 00       	mov    $0x198,%esi
   40c55:	bf 20 3e 04 00       	mov    $0x43e20,%edi
   40c5a:	e8 f5 16 00 00       	call   42354 <assert_fail>
}
   40c5f:	90                   	nop
   40c60:	c9                   	leave  
   40c61:	c3                   	ret    

0000000000040c62 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   40c62:	55                   	push   %rbp
   40c63:	48 89 e5             	mov    %rsp,%rbp
   40c66:	48 83 ec 20          	sub    $0x20,%rsp
   40c6a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40c6e:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   40c71:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40c74:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   40c77:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   40c7e:	48 8b 05 7b 33 01 00 	mov    0x1337b(%rip),%rax        # 54000 <kernel_pagetable>
   40c85:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40c89:	75 67                	jne    40cf2 <check_page_table_ownership+0x90>
        owner = PO_KERNEL;
   40c8b:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40c92:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   40c99:	eb 51                	jmp    40cec <check_page_table_ownership+0x8a>
            if (processes[xpid].p_state != P_FREE
   40c9b:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40c9e:	48 63 d0             	movslq %eax,%rdx
   40ca1:	48 89 d0             	mov    %rdx,%rax
   40ca4:	48 c1 e0 03          	shl    $0x3,%rax
   40ca8:	48 29 d0             	sub    %rdx,%rax
   40cab:	48 c1 e0 05          	shl    $0x5,%rax
   40caf:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   40cb5:	8b 00                	mov    (%rax),%eax
   40cb7:	85 c0                	test   %eax,%eax
   40cb9:	74 2d                	je     40ce8 <check_page_table_ownership+0x86>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   40cbb:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40cbe:	48 63 d0             	movslq %eax,%rdx
   40cc1:	48 89 d0             	mov    %rdx,%rax
   40cc4:	48 c1 e0 03          	shl    $0x3,%rax
   40cc8:	48 29 d0             	sub    %rdx,%rax
   40ccb:	48 c1 e0 05          	shl    $0x5,%rax
   40ccf:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   40cd5:	48 8b 10             	mov    (%rax),%rdx
   40cd8:	48 8b 05 21 33 01 00 	mov    0x13321(%rip),%rax        # 54000 <kernel_pagetable>
   40cdf:	48 39 c2             	cmp    %rax,%rdx
   40ce2:	75 04                	jne    40ce8 <check_page_table_ownership+0x86>
                ++expected_refcount;
   40ce4:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40ce8:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   40cec:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   40cf0:	7e a9                	jle    40c9b <check_page_table_ownership+0x39>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   40cf2:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   40cf5:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40cf8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40cfc:	be 00 00 00 00       	mov    $0x0,%esi
   40d01:	48 89 c7             	mov    %rax,%rdi
   40d04:	e8 03 00 00 00       	call   40d0c <check_page_table_ownership_level>
}
   40d09:	90                   	nop
   40d0a:	c9                   	leave  
   40d0b:	c3                   	ret    

0000000000040d0c <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   40d0c:	55                   	push   %rbp
   40d0d:	48 89 e5             	mov    %rsp,%rbp
   40d10:	48 83 ec 30          	sub    $0x30,%rsp
   40d14:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40d18:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   40d1b:	89 55 e0             	mov    %edx,-0x20(%rbp)
   40d1e:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   40d21:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40d25:	48 c1 e8 0c          	shr    $0xc,%rax
   40d29:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   40d2e:	7e 14                	jle    40d44 <check_page_table_ownership_level+0x38>
   40d30:	ba 90 40 04 00       	mov    $0x44090,%edx
   40d35:	be b5 01 00 00       	mov    $0x1b5,%esi
   40d3a:	bf 20 3e 04 00       	mov    $0x43e20,%edi
   40d3f:	e8 10 16 00 00       	call   42354 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   40d44:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40d48:	48 c1 e8 0c          	shr    $0xc,%rax
   40d4c:	48 98                	cltq   
   40d4e:	0f b6 84 00 40 1e 05 	movzbl 0x51e40(%rax,%rax,1),%eax
   40d55:	00 
   40d56:	0f be c0             	movsbl %al,%eax
   40d59:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   40d5c:	74 14                	je     40d72 <check_page_table_ownership_level+0x66>
   40d5e:	ba a8 40 04 00       	mov    $0x440a8,%edx
   40d63:	be b6 01 00 00       	mov    $0x1b6,%esi
   40d68:	bf 20 3e 04 00       	mov    $0x43e20,%edi
   40d6d:	e8 e2 15 00 00       	call   42354 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   40d72:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40d76:	48 c1 e8 0c          	shr    $0xc,%rax
   40d7a:	48 98                	cltq   
   40d7c:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   40d83:	00 
   40d84:	0f be c0             	movsbl %al,%eax
   40d87:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   40d8a:	74 14                	je     40da0 <check_page_table_ownership_level+0x94>
   40d8c:	ba d0 40 04 00       	mov    $0x440d0,%edx
   40d91:	be b7 01 00 00       	mov    $0x1b7,%esi
   40d96:	bf 20 3e 04 00       	mov    $0x43e20,%edi
   40d9b:	e8 b4 15 00 00       	call   42354 <assert_fail>
    if (level < 3) {
   40da0:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   40da4:	7f 5b                	jg     40e01 <check_page_table_ownership_level+0xf5>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   40da6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   40dad:	eb 49                	jmp    40df8 <check_page_table_ownership_level+0xec>
            if (pt->entry[index]) {
   40daf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40db3:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40db6:	48 63 d2             	movslq %edx,%rdx
   40db9:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   40dbd:	48 85 c0             	test   %rax,%rax
   40dc0:	74 32                	je     40df4 <check_page_table_ownership_level+0xe8>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   40dc2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40dc6:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40dc9:	48 63 d2             	movslq %edx,%rdx
   40dcc:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   40dd0:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   40dd6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   40dda:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40ddd:	8d 70 01             	lea    0x1(%rax),%esi
   40de0:	8b 55 e0             	mov    -0x20(%rbp),%edx
   40de3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40de7:	b9 01 00 00 00       	mov    $0x1,%ecx
   40dec:	48 89 c7             	mov    %rax,%rdi
   40def:	e8 18 ff ff ff       	call   40d0c <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   40df4:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   40df8:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   40dff:	7e ae                	jle    40daf <check_page_table_ownership_level+0xa3>
            }
        }
    }
}
   40e01:	90                   	nop
   40e02:	c9                   	leave  
   40e03:	c3                   	ret    

0000000000040e04 <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   40e04:	55                   	push   %rbp
   40e05:	48 89 e5             	mov    %rsp,%rbp
   40e08:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   40e0c:	8b 05 d6 02 01 00    	mov    0x102d6(%rip),%eax        # 510e8 <processes+0xc8>
   40e12:	85 c0                	test   %eax,%eax
   40e14:	74 14                	je     40e2a <check_virtual_memory+0x26>
   40e16:	ba 00 41 04 00       	mov    $0x44100,%edx
   40e1b:	be ca 01 00 00       	mov    $0x1ca,%esi
   40e20:	bf 20 3e 04 00       	mov    $0x43e20,%edi
   40e25:	e8 2a 15 00 00       	call   42354 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   40e2a:	48 8b 05 cf 31 01 00 	mov    0x131cf(%rip),%rax        # 54000 <kernel_pagetable>
   40e31:	48 89 c7             	mov    %rax,%rdi
   40e34:	e8 dc fc ff ff       	call   40b15 <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   40e39:	48 8b 05 c0 31 01 00 	mov    0x131c0(%rip),%rax        # 54000 <kernel_pagetable>
   40e40:	be ff ff ff ff       	mov    $0xffffffff,%esi
   40e45:	48 89 c7             	mov    %rax,%rdi
   40e48:	e8 15 fe ff ff       	call   40c62 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   40e4d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   40e54:	e9 9c 00 00 00       	jmp    40ef5 <check_virtual_memory+0xf1>
        if (processes[pid].p_state != P_FREE
   40e59:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40e5c:	48 63 d0             	movslq %eax,%rdx
   40e5f:	48 89 d0             	mov    %rdx,%rax
   40e62:	48 c1 e0 03          	shl    $0x3,%rax
   40e66:	48 29 d0             	sub    %rdx,%rax
   40e69:	48 c1 e0 05          	shl    $0x5,%rax
   40e6d:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   40e73:	8b 00                	mov    (%rax),%eax
   40e75:	85 c0                	test   %eax,%eax
   40e77:	74 78                	je     40ef1 <check_virtual_memory+0xed>
            && processes[pid].p_pagetable != kernel_pagetable) {
   40e79:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40e7c:	48 63 d0             	movslq %eax,%rdx
   40e7f:	48 89 d0             	mov    %rdx,%rax
   40e82:	48 c1 e0 03          	shl    $0x3,%rax
   40e86:	48 29 d0             	sub    %rdx,%rax
   40e89:	48 c1 e0 05          	shl    $0x5,%rax
   40e8d:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   40e93:	48 8b 10             	mov    (%rax),%rdx
   40e96:	48 8b 05 63 31 01 00 	mov    0x13163(%rip),%rax        # 54000 <kernel_pagetable>
   40e9d:	48 39 c2             	cmp    %rax,%rdx
   40ea0:	74 4f                	je     40ef1 <check_virtual_memory+0xed>
            check_page_table_mappings(processes[pid].p_pagetable);
   40ea2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40ea5:	48 63 d0             	movslq %eax,%rdx
   40ea8:	48 89 d0             	mov    %rdx,%rax
   40eab:	48 c1 e0 03          	shl    $0x3,%rax
   40eaf:	48 29 d0             	sub    %rdx,%rax
   40eb2:	48 c1 e0 05          	shl    $0x5,%rax
   40eb6:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   40ebc:	48 8b 00             	mov    (%rax),%rax
   40ebf:	48 89 c7             	mov    %rax,%rdi
   40ec2:	e8 4e fc ff ff       	call   40b15 <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   40ec7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40eca:	48 63 d0             	movslq %eax,%rdx
   40ecd:	48 89 d0             	mov    %rdx,%rax
   40ed0:	48 c1 e0 03          	shl    $0x3,%rax
   40ed4:	48 29 d0             	sub    %rdx,%rax
   40ed7:	48 c1 e0 05          	shl    $0x5,%rax
   40edb:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   40ee1:	48 8b 00             	mov    (%rax),%rax
   40ee4:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40ee7:	89 d6                	mov    %edx,%esi
   40ee9:	48 89 c7             	mov    %rax,%rdi
   40eec:	e8 71 fd ff ff       	call   40c62 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   40ef1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   40ef5:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   40ef9:	0f 8e 5a ff ff ff    	jle    40e59 <check_virtual_memory+0x55>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   40eff:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   40f06:	eb 67                	jmp    40f6f <check_virtual_memory+0x16b>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   40f08:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40f0b:	48 98                	cltq   
   40f0d:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   40f14:	00 
   40f15:	84 c0                	test   %al,%al
   40f17:	7e 52                	jle    40f6b <check_virtual_memory+0x167>
   40f19:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40f1c:	48 98                	cltq   
   40f1e:	0f b6 84 00 40 1e 05 	movzbl 0x51e40(%rax,%rax,1),%eax
   40f25:	00 
   40f26:	84 c0                	test   %al,%al
   40f28:	78 41                	js     40f6b <check_virtual_memory+0x167>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   40f2a:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40f2d:	48 98                	cltq   
   40f2f:	0f b6 84 00 40 1e 05 	movzbl 0x51e40(%rax,%rax,1),%eax
   40f36:	00 
   40f37:	0f be c0             	movsbl %al,%eax
   40f3a:	48 63 d0             	movslq %eax,%rdx
   40f3d:	48 89 d0             	mov    %rdx,%rax
   40f40:	48 c1 e0 03          	shl    $0x3,%rax
   40f44:	48 29 d0             	sub    %rdx,%rax
   40f47:	48 c1 e0 05          	shl    $0x5,%rax
   40f4b:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   40f51:	8b 00                	mov    (%rax),%eax
   40f53:	85 c0                	test   %eax,%eax
   40f55:	75 14                	jne    40f6b <check_virtual_memory+0x167>
   40f57:	ba 20 41 04 00       	mov    $0x44120,%edx
   40f5c:	be e1 01 00 00       	mov    $0x1e1,%esi
   40f61:	bf 20 3e 04 00       	mov    $0x43e20,%edi
   40f66:	e8 e9 13 00 00       	call   42354 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   40f6b:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   40f6f:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   40f76:	7e 90                	jle    40f08 <check_virtual_memory+0x104>
        }
    }
}
   40f78:	90                   	nop
   40f79:	90                   	nop
   40f7a:	c9                   	leave  
   40f7b:	c3                   	ret    

0000000000040f7c <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   40f7c:	55                   	push   %rbp
   40f7d:	48 89 e5             	mov    %rsp,%rbp
   40f80:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   40f84:	ba 86 41 04 00       	mov    $0x44186,%edx
   40f89:	be 00 0f 00 00       	mov    $0xf00,%esi
   40f8e:	bf 20 00 00 00       	mov    $0x20,%edi
   40f93:	b8 00 00 00 00       	mov    $0x0,%eax
   40f98:	e8 ba 2c 00 00       	call   43c57 <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   40f9d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   40fa4:	e9 f8 00 00 00       	jmp    410a1 <memshow_physical+0x125>
        if (pn % 64 == 0) {
   40fa9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40fac:	83 e0 3f             	and    $0x3f,%eax
   40faf:	85 c0                	test   %eax,%eax
   40fb1:	75 3c                	jne    40fef <memshow_physical+0x73>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   40fb3:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40fb6:	c1 e0 0c             	shl    $0xc,%eax
   40fb9:	89 c1                	mov    %eax,%ecx
   40fbb:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40fbe:	8d 50 3f             	lea    0x3f(%rax),%edx
   40fc1:	85 c0                	test   %eax,%eax
   40fc3:	0f 48 c2             	cmovs  %edx,%eax
   40fc6:	c1 f8 06             	sar    $0x6,%eax
   40fc9:	8d 50 01             	lea    0x1(%rax),%edx
   40fcc:	89 d0                	mov    %edx,%eax
   40fce:	c1 e0 02             	shl    $0x2,%eax
   40fd1:	01 d0                	add    %edx,%eax
   40fd3:	c1 e0 04             	shl    $0x4,%eax
   40fd6:	83 c0 03             	add    $0x3,%eax
   40fd9:	ba 96 41 04 00       	mov    $0x44196,%edx
   40fde:	be 00 0f 00 00       	mov    $0xf00,%esi
   40fe3:	89 c7                	mov    %eax,%edi
   40fe5:	b8 00 00 00 00       	mov    $0x0,%eax
   40fea:	e8 68 2c 00 00       	call   43c57 <console_printf>
        }

        int owner = pageinfo[pn].owner;
   40fef:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40ff2:	48 98                	cltq   
   40ff4:	0f b6 84 00 40 1e 05 	movzbl 0x51e40(%rax,%rax,1),%eax
   40ffb:	00 
   40ffc:	0f be c0             	movsbl %al,%eax
   40fff:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   41002:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41005:	48 98                	cltq   
   41007:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   4100e:	00 
   4100f:	84 c0                	test   %al,%al
   41011:	75 07                	jne    4101a <memshow_physical+0x9e>
            owner = PO_FREE;
   41013:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   4101a:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4101d:	83 c0 02             	add    $0x2,%eax
   41020:	48 98                	cltq   
   41022:	0f b7 84 00 60 41 04 	movzwl 0x44160(%rax,%rax,1),%eax
   41029:	00 
   4102a:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   4102e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41031:	48 98                	cltq   
   41033:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   4103a:	00 
   4103b:	3c 01                	cmp    $0x1,%al
   4103d:	7e 1a                	jle    41059 <memshow_physical+0xdd>
   4103f:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   41044:	48 c1 e8 0c          	shr    $0xc,%rax
   41048:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   4104b:	74 0c                	je     41059 <memshow_physical+0xdd>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   4104d:	b8 53 00 00 00       	mov    $0x53,%eax
   41052:	80 cc 0f             	or     $0xf,%ah
   41055:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   41059:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4105c:	8d 50 3f             	lea    0x3f(%rax),%edx
   4105f:	85 c0                	test   %eax,%eax
   41061:	0f 48 c2             	cmovs  %edx,%eax
   41064:	c1 f8 06             	sar    $0x6,%eax
   41067:	8d 50 01             	lea    0x1(%rax),%edx
   4106a:	89 d0                	mov    %edx,%eax
   4106c:	c1 e0 02             	shl    $0x2,%eax
   4106f:	01 d0                	add    %edx,%eax
   41071:	c1 e0 04             	shl    $0x4,%eax
   41074:	89 c1                	mov    %eax,%ecx
   41076:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41079:	89 d0                	mov    %edx,%eax
   4107b:	c1 f8 1f             	sar    $0x1f,%eax
   4107e:	c1 e8 1a             	shr    $0x1a,%eax
   41081:	01 c2                	add    %eax,%edx
   41083:	83 e2 3f             	and    $0x3f,%edx
   41086:	29 c2                	sub    %eax,%edx
   41088:	89 d0                	mov    %edx,%eax
   4108a:	83 c0 0c             	add    $0xc,%eax
   4108d:	01 c8                	add    %ecx,%eax
   4108f:	48 98                	cltq   
   41091:	0f b7 55 f6          	movzwl -0xa(%rbp),%edx
   41095:	66 89 94 00 00 80 0b 	mov    %dx,0xb8000(%rax,%rax,1)
   4109c:	00 
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4109d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   410a1:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   410a8:	0f 8e fb fe ff ff    	jle    40fa9 <memshow_physical+0x2d>
    }
}
   410ae:	90                   	nop
   410af:	90                   	nop
   410b0:	c9                   	leave  
   410b1:	c3                   	ret    

00000000000410b2 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   410b2:	55                   	push   %rbp
   410b3:	48 89 e5             	mov    %rsp,%rbp
   410b6:	48 83 ec 40          	sub    $0x40,%rsp
   410ba:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   410be:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   410c2:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   410c6:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   410cc:	48 89 c2             	mov    %rax,%rdx
   410cf:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   410d3:	48 39 c2             	cmp    %rax,%rdx
   410d6:	74 14                	je     410ec <memshow_virtual+0x3a>
   410d8:	ba a0 41 04 00       	mov    $0x441a0,%edx
   410dd:	be 12 02 00 00       	mov    $0x212,%esi
   410e2:	bf 20 3e 04 00       	mov    $0x43e20,%edi
   410e7:	e8 68 12 00 00       	call   42354 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   410ec:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   410f0:	48 89 c1             	mov    %rax,%rcx
   410f3:	ba cd 41 04 00       	mov    $0x441cd,%edx
   410f8:	be 00 0f 00 00       	mov    $0xf00,%esi
   410fd:	bf 3a 03 00 00       	mov    $0x33a,%edi
   41102:	b8 00 00 00 00       	mov    $0x0,%eax
   41107:	e8 4b 2b 00 00       	call   43c57 <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   4110c:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   41113:	00 
   41114:	e9 80 01 00 00       	jmp    41299 <memshow_virtual+0x1e7>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   41119:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4111d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   41121:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   41125:	48 89 ce             	mov    %rcx,%rsi
   41128:	48 89 c7             	mov    %rax,%rdi
   4112b:	e8 de 18 00 00       	call   42a0e <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   41130:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41133:	85 c0                	test   %eax,%eax
   41135:	79 0b                	jns    41142 <memshow_virtual+0x90>
            color = ' ';
   41137:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   4113d:	e9 d7 00 00 00       	jmp    41219 <memshow_virtual+0x167>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   41142:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41146:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   4114c:	76 14                	jbe    41162 <memshow_virtual+0xb0>
   4114e:	ba ea 41 04 00       	mov    $0x441ea,%edx
   41153:	be 1b 02 00 00       	mov    $0x21b,%esi
   41158:	bf 20 3e 04 00       	mov    $0x43e20,%edi
   4115d:	e8 f2 11 00 00       	call   42354 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   41162:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41165:	48 98                	cltq   
   41167:	0f b6 84 00 40 1e 05 	movzbl 0x51e40(%rax,%rax,1),%eax
   4116e:	00 
   4116f:	0f be c0             	movsbl %al,%eax
   41172:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   41175:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41178:	48 98                	cltq   
   4117a:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   41181:	00 
   41182:	84 c0                	test   %al,%al
   41184:	75 07                	jne    4118d <memshow_virtual+0xdb>
                owner = PO_FREE;
   41186:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   4118d:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41190:	83 c0 02             	add    $0x2,%eax
   41193:	48 98                	cltq   
   41195:	0f b7 84 00 60 41 04 	movzwl 0x44160(%rax,%rax,1),%eax
   4119c:	00 
   4119d:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   411a1:	8b 45 e0             	mov    -0x20(%rbp),%eax
   411a4:	48 98                	cltq   
   411a6:	83 e0 04             	and    $0x4,%eax
   411a9:	48 85 c0             	test   %rax,%rax
   411ac:	74 27                	je     411d5 <memshow_virtual+0x123>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   411ae:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   411b2:	c1 e0 04             	shl    $0x4,%eax
   411b5:	66 25 00 f0          	and    $0xf000,%ax
   411b9:	89 c2                	mov    %eax,%edx
   411bb:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   411bf:	c1 f8 04             	sar    $0x4,%eax
   411c2:	66 25 00 0f          	and    $0xf00,%ax
   411c6:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   411c8:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   411cc:	0f b6 c0             	movzbl %al,%eax
   411cf:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   411d1:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   411d5:	8b 45 d0             	mov    -0x30(%rbp),%eax
   411d8:	48 98                	cltq   
   411da:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   411e1:	00 
   411e2:	3c 01                	cmp    $0x1,%al
   411e4:	7e 33                	jle    41219 <memshow_virtual+0x167>
   411e6:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   411eb:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   411ef:	74 28                	je     41219 <memshow_virtual+0x167>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   411f1:	b8 53 00 00 00       	mov    $0x53,%eax
   411f6:	89 c2                	mov    %eax,%edx
   411f8:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   411fc:	66 25 00 f0          	and    $0xf000,%ax
   41200:	09 d0                	or     %edx,%eax
   41202:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   41206:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41209:	48 98                	cltq   
   4120b:	83 e0 04             	and    $0x4,%eax
   4120e:	48 85 c0             	test   %rax,%rax
   41211:	75 06                	jne    41219 <memshow_virtual+0x167>
                    color = color | 0x0F00;
   41213:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   41219:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4121d:	48 c1 e8 0c          	shr    $0xc,%rax
   41221:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   41224:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41227:	83 e0 3f             	and    $0x3f,%eax
   4122a:	85 c0                	test   %eax,%eax
   4122c:	75 34                	jne    41262 <memshow_virtual+0x1b0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   4122e:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41231:	c1 e8 06             	shr    $0x6,%eax
   41234:	89 c2                	mov    %eax,%edx
   41236:	89 d0                	mov    %edx,%eax
   41238:	c1 e0 02             	shl    $0x2,%eax
   4123b:	01 d0                	add    %edx,%eax
   4123d:	c1 e0 04             	shl    $0x4,%eax
   41240:	05 73 03 00 00       	add    $0x373,%eax
   41245:	89 c7                	mov    %eax,%edi
   41247:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4124b:	48 89 c1             	mov    %rax,%rcx
   4124e:	ba 96 41 04 00       	mov    $0x44196,%edx
   41253:	be 00 0f 00 00       	mov    $0xf00,%esi
   41258:	b8 00 00 00 00       	mov    $0x0,%eax
   4125d:	e8 f5 29 00 00       	call   43c57 <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   41262:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41265:	c1 e8 06             	shr    $0x6,%eax
   41268:	89 c2                	mov    %eax,%edx
   4126a:	89 d0                	mov    %edx,%eax
   4126c:	c1 e0 02             	shl    $0x2,%eax
   4126f:	01 d0                	add    %edx,%eax
   41271:	c1 e0 04             	shl    $0x4,%eax
   41274:	89 c2                	mov    %eax,%edx
   41276:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41279:	83 e0 3f             	and    $0x3f,%eax
   4127c:	01 d0                	add    %edx,%eax
   4127e:	05 7c 03 00 00       	add    $0x37c,%eax
   41283:	89 c2                	mov    %eax,%edx
   41285:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41289:	66 89 84 12 00 80 0b 	mov    %ax,0xb8000(%rdx,%rdx,1)
   41290:	00 
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41291:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41298:	00 
   41299:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   412a0:	00 
   412a1:	0f 86 72 fe ff ff    	jbe    41119 <memshow_virtual+0x67>
    }
}
   412a7:	90                   	nop
   412a8:	90                   	nop
   412a9:	c9                   	leave  
   412aa:	c3                   	ret    

00000000000412ab <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   412ab:	55                   	push   %rbp
   412ac:	48 89 e5             	mov    %rsp,%rbp
   412af:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   412b3:	8b 05 87 0f 01 00    	mov    0x10f87(%rip),%eax        # 52240 <last_ticks.1>
   412b9:	85 c0                	test   %eax,%eax
   412bb:	74 13                	je     412d0 <memshow_virtual_animate+0x25>
   412bd:	8b 15 5d 0b 01 00    	mov    0x10b5d(%rip),%edx        # 51e20 <ticks>
   412c3:	8b 05 77 0f 01 00    	mov    0x10f77(%rip),%eax        # 52240 <last_ticks.1>
   412c9:	29 c2                	sub    %eax,%edx
   412cb:	83 fa 31             	cmp    $0x31,%edx
   412ce:	76 2c                	jbe    412fc <memshow_virtual_animate+0x51>
        last_ticks = ticks;
   412d0:	8b 05 4a 0b 01 00    	mov    0x10b4a(%rip),%eax        # 51e20 <ticks>
   412d6:	89 05 64 0f 01 00    	mov    %eax,0x10f64(%rip)        # 52240 <last_ticks.1>
        ++showing;
   412dc:	8b 05 22 3d 00 00    	mov    0x3d22(%rip),%eax        # 45004 <showing.0>
   412e2:	83 c0 01             	add    $0x1,%eax
   412e5:	89 05 19 3d 00 00    	mov    %eax,0x3d19(%rip)        # 45004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   412eb:	eb 0f                	jmp    412fc <memshow_virtual_animate+0x51>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
        ++showing;
   412ed:	8b 05 11 3d 00 00    	mov    0x3d11(%rip),%eax        # 45004 <showing.0>
   412f3:	83 c0 01             	add    $0x1,%eax
   412f6:	89 05 08 3d 00 00    	mov    %eax,0x3d08(%rip)        # 45004 <showing.0>
    while (showing <= 2*NPROC
   412fc:	8b 05 02 3d 00 00    	mov    0x3d02(%rip),%eax        # 45004 <showing.0>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
   41302:	83 f8 20             	cmp    $0x20,%eax
   41305:	7f 6d                	jg     41374 <memshow_virtual_animate+0xc9>
   41307:	8b 15 f7 3c 00 00    	mov    0x3cf7(%rip),%edx        # 45004 <showing.0>
   4130d:	89 d0                	mov    %edx,%eax
   4130f:	c1 f8 1f             	sar    $0x1f,%eax
   41312:	c1 e8 1c             	shr    $0x1c,%eax
   41315:	01 c2                	add    %eax,%edx
   41317:	83 e2 0f             	and    $0xf,%edx
   4131a:	29 c2                	sub    %eax,%edx
   4131c:	89 d0                	mov    %edx,%eax
   4131e:	48 63 d0             	movslq %eax,%rdx
   41321:	48 89 d0             	mov    %rdx,%rax
   41324:	48 c1 e0 03          	shl    $0x3,%rax
   41328:	48 29 d0             	sub    %rdx,%rax
   4132b:	48 c1 e0 05          	shl    $0x5,%rax
   4132f:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   41335:	8b 00                	mov    (%rax),%eax
   41337:	85 c0                	test   %eax,%eax
   41339:	74 b2                	je     412ed <memshow_virtual_animate+0x42>
   4133b:	8b 15 c3 3c 00 00    	mov    0x3cc3(%rip),%edx        # 45004 <showing.0>
   41341:	89 d0                	mov    %edx,%eax
   41343:	c1 f8 1f             	sar    $0x1f,%eax
   41346:	c1 e8 1c             	shr    $0x1c,%eax
   41349:	01 c2                	add    %eax,%edx
   4134b:	83 e2 0f             	and    $0xf,%edx
   4134e:	29 c2                	sub    %eax,%edx
   41350:	89 d0                	mov    %edx,%eax
   41352:	48 63 d0             	movslq %eax,%rdx
   41355:	48 89 d0             	mov    %rdx,%rax
   41358:	48 c1 e0 03          	shl    $0x3,%rax
   4135c:	48 29 d0             	sub    %rdx,%rax
   4135f:	48 c1 e0 05          	shl    $0x5,%rax
   41363:	48 05 f8 10 05 00    	add    $0x510f8,%rax
   41369:	0f b6 00             	movzbl (%rax),%eax
   4136c:	84 c0                	test   %al,%al
   4136e:	0f 84 79 ff ff ff    	je     412ed <memshow_virtual_animate+0x42>
    }
    showing = showing % NPROC;
   41374:	8b 15 8a 3c 00 00    	mov    0x3c8a(%rip),%edx        # 45004 <showing.0>
   4137a:	89 d0                	mov    %edx,%eax
   4137c:	c1 f8 1f             	sar    $0x1f,%eax
   4137f:	c1 e8 1c             	shr    $0x1c,%eax
   41382:	01 c2                	add    %eax,%edx
   41384:	83 e2 0f             	and    $0xf,%edx
   41387:	29 c2                	sub    %eax,%edx
   41389:	89 d0                	mov    %edx,%eax
   4138b:	89 05 73 3c 00 00    	mov    %eax,0x3c73(%rip)        # 45004 <showing.0>

    if (processes[showing].p_state != P_FREE) {
   41391:	8b 05 6d 3c 00 00    	mov    0x3c6d(%rip),%eax        # 45004 <showing.0>
   41397:	48 63 d0             	movslq %eax,%rdx
   4139a:	48 89 d0             	mov    %rdx,%rax
   4139d:	48 c1 e0 03          	shl    $0x3,%rax
   413a1:	48 29 d0             	sub    %rdx,%rax
   413a4:	48 c1 e0 05          	shl    $0x5,%rax
   413a8:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   413ae:	8b 00                	mov    (%rax),%eax
   413b0:	85 c0                	test   %eax,%eax
   413b2:	74 52                	je     41406 <memshow_virtual_animate+0x15b>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   413b4:	8b 15 4a 3c 00 00    	mov    0x3c4a(%rip),%edx        # 45004 <showing.0>
   413ba:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   413be:	89 d1                	mov    %edx,%ecx
   413c0:	ba 04 42 04 00       	mov    $0x44204,%edx
   413c5:	be 04 00 00 00       	mov    $0x4,%esi
   413ca:	48 89 c7             	mov    %rax,%rdi
   413cd:	b8 00 00 00 00       	mov    $0x0,%eax
   413d2:	e8 8c 29 00 00       	call   43d63 <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   413d7:	8b 05 27 3c 00 00    	mov    0x3c27(%rip),%eax        # 45004 <showing.0>
   413dd:	48 63 d0             	movslq %eax,%rdx
   413e0:	48 89 d0             	mov    %rdx,%rax
   413e3:	48 c1 e0 03          	shl    $0x3,%rax
   413e7:	48 29 d0             	sub    %rdx,%rax
   413ea:	48 c1 e0 05          	shl    $0x5,%rax
   413ee:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   413f4:	48 8b 00             	mov    (%rax),%rax
   413f7:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   413fb:	48 89 d6             	mov    %rdx,%rsi
   413fe:	48 89 c7             	mov    %rax,%rdi
   41401:	e8 ac fc ff ff       	call   410b2 <memshow_virtual>
    }
}
   41406:	90                   	nop
   41407:	c9                   	leave  
   41408:	c3                   	ret    

0000000000041409 <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   41409:	55                   	push   %rbp
   4140a:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   4140d:	e8 4f 01 00 00       	call   41561 <segments_init>
    interrupt_init();
   41412:	e8 d0 03 00 00       	call   417e7 <interrupt_init>
    virtual_memory_init();
   41417:	e8 f3 0f 00 00       	call   4240f <virtual_memory_init>
}
   4141c:	90                   	nop
   4141d:	5d                   	pop    %rbp
   4141e:	c3                   	ret    

000000000004141f <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   4141f:	55                   	push   %rbp
   41420:	48 89 e5             	mov    %rsp,%rbp
   41423:	48 83 ec 18          	sub    $0x18,%rsp
   41427:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4142b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   4142f:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   41432:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41435:	48 98                	cltq   
   41437:	48 c1 e0 2d          	shl    $0x2d,%rax
   4143b:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   4143f:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   41446:	90 00 00 
   41449:	48 09 c2             	or     %rax,%rdx
    *segment = type
   4144c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41450:	48 89 10             	mov    %rdx,(%rax)
}
   41453:	90                   	nop
   41454:	c9                   	leave  
   41455:	c3                   	ret    

0000000000041456 <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   41456:	55                   	push   %rbp
   41457:	48 89 e5             	mov    %rsp,%rbp
   4145a:	48 83 ec 28          	sub    $0x28,%rsp
   4145e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41462:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41466:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41469:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   4146d:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41471:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41475:	48 c1 e0 10          	shl    $0x10,%rax
   41479:	48 89 c2             	mov    %rax,%rdx
   4147c:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   41483:	00 00 00 
   41486:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   41489:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4148d:	48 c1 e0 20          	shl    $0x20,%rax
   41491:	48 89 c1             	mov    %rax,%rcx
   41494:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   4149b:	00 00 ff 
   4149e:	48 21 c8             	and    %rcx,%rax
   414a1:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   414a4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   414a8:	48 83 e8 01          	sub    $0x1,%rax
   414ac:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   414af:	48 09 d0             	or     %rdx,%rax
        | type
   414b2:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   414b6:	8b 55 ec             	mov    -0x14(%rbp),%edx
   414b9:	48 63 d2             	movslq %edx,%rdx
   414bc:	48 c1 e2 2d          	shl    $0x2d,%rdx
   414c0:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   414c3:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   414ca:	80 00 00 
   414cd:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   414d0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   414d4:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   414d7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   414db:	48 83 c0 08          	add    $0x8,%rax
   414df:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   414e3:	48 c1 ea 20          	shr    $0x20,%rdx
   414e7:	48 89 10             	mov    %rdx,(%rax)
}
   414ea:	90                   	nop
   414eb:	c9                   	leave  
   414ec:	c3                   	ret    

00000000000414ed <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   414ed:	55                   	push   %rbp
   414ee:	48 89 e5             	mov    %rsp,%rbp
   414f1:	48 83 ec 20          	sub    $0x20,%rsp
   414f5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   414f9:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   414fd:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41500:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41504:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41508:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   4150b:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   4150f:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41512:	48 63 d2             	movslq %edx,%rdx
   41515:	48 c1 e2 2d          	shl    $0x2d,%rdx
   41519:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   4151c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41520:	48 c1 e0 20          	shl    $0x20,%rax
   41524:	48 89 c1             	mov    %rax,%rcx
   41527:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   4152e:	00 ff ff 
   41531:	48 21 c8             	and    %rcx,%rax
   41534:	48 09 c2             	or     %rax,%rdx
   41537:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   4153e:	80 00 00 
   41541:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41544:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41548:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   4154b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4154f:	48 c1 e8 20          	shr    $0x20,%rax
   41553:	48 89 c2             	mov    %rax,%rdx
   41556:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4155a:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   4155e:	90                   	nop
   4155f:	c9                   	leave  
   41560:	c3                   	ret    

0000000000041561 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   41561:	55                   	push   %rbp
   41562:	48 89 e5             	mov    %rsp,%rbp
   41565:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   41569:	48 c7 05 ec 0c 01 00 	movq   $0x0,0x10cec(%rip)        # 52260 <segments>
   41570:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   41574:	ba 00 00 00 00       	mov    $0x0,%edx
   41579:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41580:	08 20 00 
   41583:	48 89 c6             	mov    %rax,%rsi
   41586:	bf 68 22 05 00       	mov    $0x52268,%edi
   4158b:	e8 8f fe ff ff       	call   4141f <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   41590:	ba 03 00 00 00       	mov    $0x3,%edx
   41595:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   4159c:	08 20 00 
   4159f:	48 89 c6             	mov    %rax,%rsi
   415a2:	bf 70 22 05 00       	mov    $0x52270,%edi
   415a7:	e8 73 fe ff ff       	call   4141f <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   415ac:	ba 00 00 00 00       	mov    $0x0,%edx
   415b1:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   415b8:	02 00 00 
   415bb:	48 89 c6             	mov    %rax,%rsi
   415be:	bf 78 22 05 00       	mov    $0x52278,%edi
   415c3:	e8 57 fe ff ff       	call   4141f <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   415c8:	ba 03 00 00 00       	mov    $0x3,%edx
   415cd:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   415d4:	02 00 00 
   415d7:	48 89 c6             	mov    %rax,%rsi
   415da:	bf 80 22 05 00       	mov    $0x52280,%edi
   415df:	e8 3b fe ff ff       	call   4141f <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   415e4:	b8 a0 32 05 00       	mov    $0x532a0,%eax
   415e9:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   415ef:	48 89 c1             	mov    %rax,%rcx
   415f2:	ba 00 00 00 00       	mov    $0x0,%edx
   415f7:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   415fe:	09 00 00 
   41601:	48 89 c6             	mov    %rax,%rsi
   41604:	bf 88 22 05 00       	mov    $0x52288,%edi
   41609:	e8 48 fe ff ff       	call   41456 <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   4160e:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   41614:	b8 60 22 05 00       	mov    $0x52260,%eax
   41619:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   4161d:	ba 60 00 00 00       	mov    $0x60,%edx
   41622:	be 00 00 00 00       	mov    $0x0,%esi
   41627:	bf a0 32 05 00       	mov    $0x532a0,%edi
   4162c:	e8 6f 18 00 00       	call   42ea0 <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   41631:	48 c7 05 68 1c 01 00 	movq   $0x80000,0x11c68(%rip)        # 532a4 <kernel_task_descriptor+0x4>
   41638:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   4163c:	ba 00 10 00 00       	mov    $0x1000,%edx
   41641:	be 00 00 00 00       	mov    $0x0,%esi
   41646:	bf a0 22 05 00       	mov    $0x522a0,%edi
   4164b:	e8 50 18 00 00       	call   42ea0 <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41650:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   41657:	eb 30                	jmp    41689 <segments_init+0x128>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   41659:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   4165e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41661:	48 c1 e0 04          	shl    $0x4,%rax
   41665:	48 05 a0 22 05 00    	add    $0x522a0,%rax
   4166b:	48 89 d1             	mov    %rdx,%rcx
   4166e:	ba 00 00 00 00       	mov    $0x0,%edx
   41673:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   4167a:	0e 00 00 
   4167d:	48 89 c7             	mov    %rax,%rdi
   41680:	e8 68 fe ff ff       	call   414ed <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41685:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41689:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   41690:	76 c7                	jbe    41659 <segments_init+0xf8>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   41692:	b8 36 00 04 00       	mov    $0x40036,%eax
   41697:	48 89 c1             	mov    %rax,%rcx
   4169a:	ba 00 00 00 00       	mov    $0x0,%edx
   4169f:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   416a6:	0e 00 00 
   416a9:	48 89 c6             	mov    %rax,%rsi
   416ac:	bf a0 24 05 00       	mov    $0x524a0,%edi
   416b1:	e8 37 fe ff ff       	call   414ed <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   416b6:	b8 2e 00 04 00       	mov    $0x4002e,%eax
   416bb:	48 89 c1             	mov    %rax,%rcx
   416be:	ba 00 00 00 00       	mov    $0x0,%edx
   416c3:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   416ca:	0e 00 00 
   416cd:	48 89 c6             	mov    %rax,%rsi
   416d0:	bf 70 23 05 00       	mov    $0x52370,%edi
   416d5:	e8 13 fe ff ff       	call   414ed <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   416da:	b8 32 00 04 00       	mov    $0x40032,%eax
   416df:	48 89 c1             	mov    %rax,%rcx
   416e2:	ba 00 00 00 00       	mov    $0x0,%edx
   416e7:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   416ee:	0e 00 00 
   416f1:	48 89 c6             	mov    %rax,%rsi
   416f4:	bf 80 23 05 00       	mov    $0x52380,%edi
   416f9:	e8 ef fd ff ff       	call   414ed <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   416fe:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   41705:	eb 3e                	jmp    41745 <segments_init+0x1e4>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   41707:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4170a:	83 e8 30             	sub    $0x30,%eax
   4170d:	89 c0                	mov    %eax,%eax
   4170f:	48 8b 04 c5 e7 00 04 	mov    0x400e7(,%rax,8),%rax
   41716:	00 
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   41717:	48 89 c2             	mov    %rax,%rdx
   4171a:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4171d:	48 c1 e0 04          	shl    $0x4,%rax
   41721:	48 05 a0 22 05 00    	add    $0x522a0,%rax
   41727:	48 89 d1             	mov    %rdx,%rcx
   4172a:	ba 03 00 00 00       	mov    $0x3,%edx
   4172f:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41736:	0e 00 00 
   41739:	48 89 c7             	mov    %rax,%rdi
   4173c:	e8 ac fd ff ff       	call   414ed <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41741:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41745:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   41749:	76 bc                	jbe    41707 <segments_init+0x1a6>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   4174b:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   41751:	b8 a0 22 05 00       	mov    $0x522a0,%eax
   41756:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   4175a:	b8 28 00 00 00       	mov    $0x28,%eax
   4175f:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   41763:	0f 00 d8             	ltr    %ax
   41766:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   4176a:	0f 20 c0             	mov    %cr0,%rax
   4176d:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   41771:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   41775:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   41778:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   4177f:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41782:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   41785:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41788:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   4178c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41790:	0f 22 c0             	mov    %rax,%cr0
}
   41793:	90                   	nop
    lcr0(cr0);
}
   41794:	90                   	nop
   41795:	c9                   	leave  
   41796:	c3                   	ret    

0000000000041797 <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   41797:	55                   	push   %rbp
   41798:	48 89 e5             	mov    %rsp,%rbp
   4179b:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   4179f:	0f b7 05 5a 1b 01 00 	movzwl 0x11b5a(%rip),%eax        # 53300 <interrupts_enabled>
   417a6:	f7 d0                	not    %eax
   417a8:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   417ac:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   417b0:	0f b6 c0             	movzbl %al,%eax
   417b3:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   417ba:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   417bd:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   417c1:	8b 55 f0             	mov    -0x10(%rbp),%edx
   417c4:	ee                   	out    %al,(%dx)
}
   417c5:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   417c6:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   417ca:	66 c1 e8 08          	shr    $0x8,%ax
   417ce:	0f b6 c0             	movzbl %al,%eax
   417d1:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   417d8:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   417db:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   417df:	8b 55 f8             	mov    -0x8(%rbp),%edx
   417e2:	ee                   	out    %al,(%dx)
}
   417e3:	90                   	nop
}
   417e4:	90                   	nop
   417e5:	c9                   	leave  
   417e6:	c3                   	ret    

00000000000417e7 <interrupt_init>:

void interrupt_init(void) {
   417e7:	55                   	push   %rbp
   417e8:	48 89 e5             	mov    %rsp,%rbp
   417eb:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   417ef:	66 c7 05 08 1b 01 00 	movw   $0x0,0x11b08(%rip)        # 53300 <interrupts_enabled>
   417f6:	00 00 
    interrupt_mask();
   417f8:	e8 9a ff ff ff       	call   41797 <interrupt_mask>
   417fd:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   41804:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41808:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   4180c:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   4180f:	ee                   	out    %al,(%dx)
}
   41810:	90                   	nop
   41811:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   41818:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4181c:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   41820:	8b 55 ac             	mov    -0x54(%rbp),%edx
   41823:	ee                   	out    %al,(%dx)
}
   41824:	90                   	nop
   41825:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   4182c:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41830:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   41834:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   41837:	ee                   	out    %al,(%dx)
}
   41838:	90                   	nop
   41839:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   41840:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41844:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   41848:	8b 55 bc             	mov    -0x44(%rbp),%edx
   4184b:	ee                   	out    %al,(%dx)
}
   4184c:	90                   	nop
   4184d:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   41854:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41858:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   4185c:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   4185f:	ee                   	out    %al,(%dx)
}
   41860:	90                   	nop
   41861:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   41868:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4186c:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   41870:	8b 55 cc             	mov    -0x34(%rbp),%edx
   41873:	ee                   	out    %al,(%dx)
}
   41874:	90                   	nop
   41875:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   4187c:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41880:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   41884:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   41887:	ee                   	out    %al,(%dx)
}
   41888:	90                   	nop
   41889:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   41890:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41894:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   41898:	8b 55 dc             	mov    -0x24(%rbp),%edx
   4189b:	ee                   	out    %al,(%dx)
}
   4189c:	90                   	nop
   4189d:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   418a4:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   418a8:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   418ac:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   418af:	ee                   	out    %al,(%dx)
}
   418b0:	90                   	nop
   418b1:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   418b8:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   418bc:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   418c0:	8b 55 ec             	mov    -0x14(%rbp),%edx
   418c3:	ee                   	out    %al,(%dx)
}
   418c4:	90                   	nop
   418c5:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   418cc:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   418d0:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   418d4:	8b 55 f4             	mov    -0xc(%rbp),%edx
   418d7:	ee                   	out    %al,(%dx)
}
   418d8:	90                   	nop
   418d9:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   418e0:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   418e4:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   418e8:	8b 55 fc             	mov    -0x4(%rbp),%edx
   418eb:	ee                   	out    %al,(%dx)
}
   418ec:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   418ed:	e8 a5 fe ff ff       	call   41797 <interrupt_mask>
}
   418f2:	90                   	nop
   418f3:	c9                   	leave  
   418f4:	c3                   	ret    

00000000000418f5 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   418f5:	55                   	push   %rbp
   418f6:	48 89 e5             	mov    %rsp,%rbp
   418f9:	48 83 ec 28          	sub    $0x28,%rsp
   418fd:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   41900:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41904:	0f 8e 9e 00 00 00    	jle    419a8 <timer_init+0xb3>
   4190a:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   41911:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41915:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41919:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4191c:	ee                   	out    %al,(%dx)
}
   4191d:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   4191e:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41921:	89 c2                	mov    %eax,%edx
   41923:	c1 ea 1f             	shr    $0x1f,%edx
   41926:	01 d0                	add    %edx,%eax
   41928:	d1 f8                	sar    %eax
   4192a:	05 de 34 12 00       	add    $0x1234de,%eax
   4192f:	99                   	cltd   
   41930:	f7 7d dc             	idivl  -0x24(%rbp)
   41933:	89 c2                	mov    %eax,%edx
   41935:	89 d0                	mov    %edx,%eax
   41937:	c1 f8 1f             	sar    $0x1f,%eax
   4193a:	c1 e8 18             	shr    $0x18,%eax
   4193d:	01 c2                	add    %eax,%edx
   4193f:	0f b6 d2             	movzbl %dl,%edx
   41942:	29 c2                	sub    %eax,%edx
   41944:	89 d0                	mov    %edx,%eax
   41946:	0f b6 c0             	movzbl %al,%eax
   41949:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   41950:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41953:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41957:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4195a:	ee                   	out    %al,(%dx)
}
   4195b:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   4195c:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4195f:	89 c2                	mov    %eax,%edx
   41961:	c1 ea 1f             	shr    $0x1f,%edx
   41964:	01 d0                	add    %edx,%eax
   41966:	d1 f8                	sar    %eax
   41968:	05 de 34 12 00       	add    $0x1234de,%eax
   4196d:	99                   	cltd   
   4196e:	f7 7d dc             	idivl  -0x24(%rbp)
   41971:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41977:	85 c0                	test   %eax,%eax
   41979:	0f 48 c2             	cmovs  %edx,%eax
   4197c:	c1 f8 08             	sar    $0x8,%eax
   4197f:	0f b6 c0             	movzbl %al,%eax
   41982:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   41989:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4198c:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41990:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41993:	ee                   	out    %al,(%dx)
}
   41994:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   41995:	0f b7 05 64 19 01 00 	movzwl 0x11964(%rip),%eax        # 53300 <interrupts_enabled>
   4199c:	83 c8 01             	or     $0x1,%eax
   4199f:	66 89 05 5a 19 01 00 	mov    %ax,0x1195a(%rip)        # 53300 <interrupts_enabled>
   419a6:	eb 11                	jmp    419b9 <timer_init+0xc4>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   419a8:	0f b7 05 51 19 01 00 	movzwl 0x11951(%rip),%eax        # 53300 <interrupts_enabled>
   419af:	83 e0 fe             	and    $0xfffffffe,%eax
   419b2:	66 89 05 47 19 01 00 	mov    %ax,0x11947(%rip)        # 53300 <interrupts_enabled>
    }
    interrupt_mask();
   419b9:	e8 d9 fd ff ff       	call   41797 <interrupt_mask>
}
   419be:	90                   	nop
   419bf:	c9                   	leave  
   419c0:	c3                   	ret    

00000000000419c1 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   419c1:	55                   	push   %rbp
   419c2:	48 89 e5             	mov    %rsp,%rbp
   419c5:	48 83 ec 08          	sub    $0x8,%rsp
   419c9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   419cd:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   419d2:	74 14                	je     419e8 <physical_memory_isreserved+0x27>
   419d4:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   419db:	00 
   419dc:	76 11                	jbe    419ef <physical_memory_isreserved+0x2e>
   419de:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   419e5:	00 
   419e6:	77 07                	ja     419ef <physical_memory_isreserved+0x2e>
   419e8:	b8 01 00 00 00       	mov    $0x1,%eax
   419ed:	eb 05                	jmp    419f4 <physical_memory_isreserved+0x33>
   419ef:	b8 00 00 00 00       	mov    $0x0,%eax
}
   419f4:	c9                   	leave  
   419f5:	c3                   	ret    

00000000000419f6 <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   419f6:	55                   	push   %rbp
   419f7:	48 89 e5             	mov    %rsp,%rbp
   419fa:	48 83 ec 10          	sub    $0x10,%rsp
   419fe:	89 7d fc             	mov    %edi,-0x4(%rbp)
   41a01:	89 75 f8             	mov    %esi,-0x8(%rbp)
   41a04:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   41a07:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41a0a:	c1 e0 10             	shl    $0x10,%eax
   41a0d:	89 c2                	mov    %eax,%edx
   41a0f:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41a12:	c1 e0 0b             	shl    $0xb,%eax
   41a15:	09 c2                	or     %eax,%edx
   41a17:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41a1a:	c1 e0 08             	shl    $0x8,%eax
   41a1d:	09 d0                	or     %edx,%eax
}
   41a1f:	c9                   	leave  
   41a20:	c3                   	ret    

0000000000041a21 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   41a21:	55                   	push   %rbp
   41a22:	48 89 e5             	mov    %rsp,%rbp
   41a25:	48 83 ec 18          	sub    $0x18,%rsp
   41a29:	89 7d ec             	mov    %edi,-0x14(%rbp)
   41a2c:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   41a2f:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41a32:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41a35:	09 d0                	or     %edx,%eax
   41a37:	0d 00 00 00 80       	or     $0x80000000,%eax
   41a3c:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   41a43:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   41a46:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41a49:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41a4c:	ef                   	out    %eax,(%dx)
}
   41a4d:	90                   	nop
   41a4e:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   41a55:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41a58:	89 c2                	mov    %eax,%edx
   41a5a:	ed                   	in     (%dx),%eax
   41a5b:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   41a5e:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   41a61:	c9                   	leave  
   41a62:	c3                   	ret    

0000000000041a63 <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   41a63:	55                   	push   %rbp
   41a64:	48 89 e5             	mov    %rsp,%rbp
   41a67:	48 83 ec 28          	sub    $0x28,%rsp
   41a6b:	89 7d dc             	mov    %edi,-0x24(%rbp)
   41a6e:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   41a71:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41a78:	eb 73                	jmp    41aed <pci_find_device+0x8a>
        for (int slot = 0; slot != 32; ++slot) {
   41a7a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41a81:	eb 60                	jmp    41ae3 <pci_find_device+0x80>
            for (int func = 0; func != 8; ++func) {
   41a83:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41a8a:	eb 4a                	jmp    41ad6 <pci_find_device+0x73>
                int configaddr = pci_make_configaddr(bus, slot, func);
   41a8c:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41a8f:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41a92:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41a95:	89 ce                	mov    %ecx,%esi
   41a97:	89 c7                	mov    %eax,%edi
   41a99:	e8 58 ff ff ff       	call   419f6 <pci_make_configaddr>
   41a9e:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   41aa1:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41aa4:	be 00 00 00 00       	mov    $0x0,%esi
   41aa9:	89 c7                	mov    %eax,%edi
   41aab:	e8 71 ff ff ff       	call   41a21 <pci_config_readl>
   41ab0:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   41ab3:	8b 45 d8             	mov    -0x28(%rbp),%eax
   41ab6:	c1 e0 10             	shl    $0x10,%eax
   41ab9:	0b 45 dc             	or     -0x24(%rbp),%eax
   41abc:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   41abf:	75 05                	jne    41ac6 <pci_find_device+0x63>
                    return configaddr;
   41ac1:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41ac4:	eb 35                	jmp    41afb <pci_find_device+0x98>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   41ac6:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   41aca:	75 06                	jne    41ad2 <pci_find_device+0x6f>
   41acc:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41ad0:	74 0c                	je     41ade <pci_find_device+0x7b>
            for (int func = 0; func != 8; ++func) {
   41ad2:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41ad6:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   41ada:	75 b0                	jne    41a8c <pci_find_device+0x29>
   41adc:	eb 01                	jmp    41adf <pci_find_device+0x7c>
                    break;
   41ade:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   41adf:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41ae3:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   41ae7:	75 9a                	jne    41a83 <pci_find_device+0x20>
    for (int bus = 0; bus != 256; ++bus) {
   41ae9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41aed:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   41af4:	75 84                	jne    41a7a <pci_find_device+0x17>
                }
            }
        }
    }
    return -1;
   41af6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   41afb:	c9                   	leave  
   41afc:	c3                   	ret    

0000000000041afd <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   41afd:	55                   	push   %rbp
   41afe:	48 89 e5             	mov    %rsp,%rbp
   41b01:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   41b05:	be 13 71 00 00       	mov    $0x7113,%esi
   41b0a:	bf 86 80 00 00       	mov    $0x8086,%edi
   41b0f:	e8 4f ff ff ff       	call   41a63 <pci_find_device>
   41b14:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   41b17:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   41b1b:	78 30                	js     41b4d <poweroff+0x50>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   41b1d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41b20:	be 40 00 00 00       	mov    $0x40,%esi
   41b25:	89 c7                	mov    %eax,%edi
   41b27:	e8 f5 fe ff ff       	call   41a21 <pci_config_readl>
   41b2c:	25 c0 ff 00 00       	and    $0xffc0,%eax
   41b31:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   41b34:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41b37:	83 c0 04             	add    $0x4,%eax
   41b3a:	89 45 f4             	mov    %eax,-0xc(%rbp)
   41b3d:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   41b43:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   41b47:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41b4a:	66 ef                	out    %ax,(%dx)
}
   41b4c:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   41b4d:	ba 20 42 04 00       	mov    $0x44220,%edx
   41b52:	be 00 c0 00 00       	mov    $0xc000,%esi
   41b57:	bf 80 07 00 00       	mov    $0x780,%edi
   41b5c:	b8 00 00 00 00       	mov    $0x0,%eax
   41b61:	e8 f1 20 00 00       	call   43c57 <console_printf>
 spinloop: goto spinloop;
   41b66:	eb fe                	jmp    41b66 <poweroff+0x69>

0000000000041b68 <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   41b68:	55                   	push   %rbp
   41b69:	48 89 e5             	mov    %rsp,%rbp
   41b6c:	48 83 ec 10          	sub    $0x10,%rsp
   41b70:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   41b77:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b7b:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41b7f:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41b82:	ee                   	out    %al,(%dx)
}
   41b83:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   41b84:	eb fe                	jmp    41b84 <reboot+0x1c>

0000000000041b86 <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   41b86:	55                   	push   %rbp
   41b87:	48 89 e5             	mov    %rsp,%rbp
   41b8a:	48 83 ec 10          	sub    $0x10,%rsp
   41b8e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41b92:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   41b95:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41b99:	48 83 c0 08          	add    $0x8,%rax
   41b9d:	ba c0 00 00 00       	mov    $0xc0,%edx
   41ba2:	be 00 00 00 00       	mov    $0x0,%esi
   41ba7:	48 89 c7             	mov    %rax,%rdi
   41baa:	e8 f1 12 00 00       	call   42ea0 <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   41baf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41bb3:	66 c7 80 a8 00 00 00 	movw   $0x13,0xa8(%rax)
   41bba:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   41bbc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41bc0:	48 c7 80 80 00 00 00 	movq   $0x23,0x80(%rax)
   41bc7:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   41bcb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41bcf:	48 c7 80 88 00 00 00 	movq   $0x23,0x88(%rax)
   41bd6:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   41bda:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41bde:	66 c7 80 c0 00 00 00 	movw   $0x23,0xc0(%rax)
   41be5:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   41be7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41beb:	48 c7 80 b0 00 00 00 	movq   $0x200,0xb0(%rax)
   41bf2:	00 02 00 00 
    p->display_status = 1;
   41bf6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41bfa:	c6 80 d8 00 00 00 01 	movb   $0x1,0xd8(%rax)

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   41c01:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41c04:	83 e0 01             	and    $0x1,%eax
   41c07:	85 c0                	test   %eax,%eax
   41c09:	74 1c                	je     41c27 <process_init+0xa1>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   41c0b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41c0f:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   41c16:	80 cc 30             	or     $0x30,%ah
   41c19:	48 89 c2             	mov    %rax,%rdx
   41c1c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41c20:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   41c27:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41c2a:	83 e0 02             	and    $0x2,%eax
   41c2d:	85 c0                	test   %eax,%eax
   41c2f:	74 1c                	je     41c4d <process_init+0xc7>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   41c31:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41c35:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   41c3c:	80 e4 fd             	and    $0xfd,%ah
   41c3f:	48 89 c2             	mov    %rax,%rdx
   41c42:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41c46:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
}
   41c4d:	90                   	nop
   41c4e:	c9                   	leave  
   41c4f:	c3                   	ret    

0000000000041c50 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   41c50:	55                   	push   %rbp
   41c51:	48 89 e5             	mov    %rsp,%rbp
   41c54:	48 83 ec 28          	sub    $0x28,%rsp
   41c58:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   41c5b:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41c5f:	78 09                	js     41c6a <console_show_cursor+0x1a>
   41c61:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   41c68:	7e 07                	jle    41c71 <console_show_cursor+0x21>
        cpos = 0;
   41c6a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   41c71:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   41c78:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c7c:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41c80:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41c83:	ee                   	out    %al,(%dx)
}
   41c84:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   41c85:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41c88:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41c8e:	85 c0                	test   %eax,%eax
   41c90:	0f 48 c2             	cmovs  %edx,%eax
   41c93:	c1 f8 08             	sar    $0x8,%eax
   41c96:	0f b6 c0             	movzbl %al,%eax
   41c99:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   41ca0:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ca3:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41ca7:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41caa:	ee                   	out    %al,(%dx)
}
   41cab:	90                   	nop
   41cac:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   41cb3:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41cb7:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41cbb:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41cbe:	ee                   	out    %al,(%dx)
}
   41cbf:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   41cc0:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41cc3:	89 d0                	mov    %edx,%eax
   41cc5:	c1 f8 1f             	sar    $0x1f,%eax
   41cc8:	c1 e8 18             	shr    $0x18,%eax
   41ccb:	01 c2                	add    %eax,%edx
   41ccd:	0f b6 d2             	movzbl %dl,%edx
   41cd0:	29 c2                	sub    %eax,%edx
   41cd2:	89 d0                	mov    %edx,%eax
   41cd4:	0f b6 c0             	movzbl %al,%eax
   41cd7:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   41cde:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ce1:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41ce5:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41ce8:	ee                   	out    %al,(%dx)
}
   41ce9:	90                   	nop
}
   41cea:	90                   	nop
   41ceb:	c9                   	leave  
   41cec:	c3                   	ret    

0000000000041ced <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   41ced:	55                   	push   %rbp
   41cee:	48 89 e5             	mov    %rsp,%rbp
   41cf1:	48 83 ec 20          	sub    $0x20,%rsp
   41cf5:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41cfc:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41cff:	89 c2                	mov    %eax,%edx
   41d01:	ec                   	in     (%dx),%al
   41d02:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   41d05:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   41d09:	0f b6 c0             	movzbl %al,%eax
   41d0c:	83 e0 01             	and    $0x1,%eax
   41d0f:	85 c0                	test   %eax,%eax
   41d11:	75 0a                	jne    41d1d <keyboard_readc+0x30>
        return -1;
   41d13:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   41d18:	e9 e7 01 00 00       	jmp    41f04 <keyboard_readc+0x217>
   41d1d:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41d24:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41d27:	89 c2                	mov    %eax,%edx
   41d29:	ec                   	in     (%dx),%al
   41d2a:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   41d2d:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   41d31:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   41d34:	0f b6 05 c7 15 01 00 	movzbl 0x115c7(%rip),%eax        # 53302 <last_escape.2>
   41d3b:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   41d3e:	c6 05 bd 15 01 00 00 	movb   $0x0,0x115bd(%rip)        # 53302 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   41d45:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   41d49:	75 11                	jne    41d5c <keyboard_readc+0x6f>
        last_escape = 0x80;
   41d4b:	c6 05 b0 15 01 00 80 	movb   $0x80,0x115b0(%rip)        # 53302 <last_escape.2>
        return 0;
   41d52:	b8 00 00 00 00       	mov    $0x0,%eax
   41d57:	e9 a8 01 00 00       	jmp    41f04 <keyboard_readc+0x217>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   41d5c:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41d60:	84 c0                	test   %al,%al
   41d62:	79 60                	jns    41dc4 <keyboard_readc+0xd7>
        int ch = keymap[(data & 0x7F) | escape];
   41d64:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41d68:	83 e0 7f             	and    $0x7f,%eax
   41d6b:	89 c2                	mov    %eax,%edx
   41d6d:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   41d71:	09 d0                	or     %edx,%eax
   41d73:	48 98                	cltq   
   41d75:	0f b6 80 40 42 04 00 	movzbl 0x44240(%rax),%eax
   41d7c:	0f b6 c0             	movzbl %al,%eax
   41d7f:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   41d82:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   41d89:	7e 2f                	jle    41dba <keyboard_readc+0xcd>
   41d8b:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   41d92:	7f 26                	jg     41dba <keyboard_readc+0xcd>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   41d94:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41d97:	2d fa 00 00 00       	sub    $0xfa,%eax
   41d9c:	ba 01 00 00 00       	mov    $0x1,%edx
   41da1:	89 c1                	mov    %eax,%ecx
   41da3:	d3 e2                	shl    %cl,%edx
   41da5:	89 d0                	mov    %edx,%eax
   41da7:	f7 d0                	not    %eax
   41da9:	89 c2                	mov    %eax,%edx
   41dab:	0f b6 05 51 15 01 00 	movzbl 0x11551(%rip),%eax        # 53303 <modifiers.1>
   41db2:	21 d0                	and    %edx,%eax
   41db4:	88 05 49 15 01 00    	mov    %al,0x11549(%rip)        # 53303 <modifiers.1>
        }
        return 0;
   41dba:	b8 00 00 00 00       	mov    $0x0,%eax
   41dbf:	e9 40 01 00 00       	jmp    41f04 <keyboard_readc+0x217>
    }

    int ch = (unsigned char) keymap[data | escape];
   41dc4:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41dc8:	0a 45 fa             	or     -0x6(%rbp),%al
   41dcb:	0f b6 c0             	movzbl %al,%eax
   41dce:	48 98                	cltq   
   41dd0:	0f b6 80 40 42 04 00 	movzbl 0x44240(%rax),%eax
   41dd7:	0f b6 c0             	movzbl %al,%eax
   41dda:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   41ddd:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   41de1:	7e 57                	jle    41e3a <keyboard_readc+0x14d>
   41de3:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   41de7:	7f 51                	jg     41e3a <keyboard_readc+0x14d>
        if (modifiers & MOD_CONTROL) {
   41de9:	0f b6 05 13 15 01 00 	movzbl 0x11513(%rip),%eax        # 53303 <modifiers.1>
   41df0:	0f b6 c0             	movzbl %al,%eax
   41df3:	83 e0 02             	and    $0x2,%eax
   41df6:	85 c0                	test   %eax,%eax
   41df8:	74 09                	je     41e03 <keyboard_readc+0x116>
            ch -= 0x60;
   41dfa:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   41dfe:	e9 fd 00 00 00       	jmp    41f00 <keyboard_readc+0x213>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   41e03:	0f b6 05 f9 14 01 00 	movzbl 0x114f9(%rip),%eax        # 53303 <modifiers.1>
   41e0a:	0f b6 c0             	movzbl %al,%eax
   41e0d:	83 e0 01             	and    $0x1,%eax
   41e10:	85 c0                	test   %eax,%eax
   41e12:	0f 94 c2             	sete   %dl
   41e15:	0f b6 05 e7 14 01 00 	movzbl 0x114e7(%rip),%eax        # 53303 <modifiers.1>
   41e1c:	0f b6 c0             	movzbl %al,%eax
   41e1f:	83 e0 08             	and    $0x8,%eax
   41e22:	85 c0                	test   %eax,%eax
   41e24:	0f 94 c0             	sete   %al
   41e27:	31 d0                	xor    %edx,%eax
   41e29:	84 c0                	test   %al,%al
   41e2b:	0f 84 cf 00 00 00    	je     41f00 <keyboard_readc+0x213>
            ch -= 0x20;
   41e31:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   41e35:	e9 c6 00 00 00       	jmp    41f00 <keyboard_readc+0x213>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   41e3a:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   41e41:	7e 30                	jle    41e73 <keyboard_readc+0x186>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   41e43:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41e46:	2d fa 00 00 00       	sub    $0xfa,%eax
   41e4b:	ba 01 00 00 00       	mov    $0x1,%edx
   41e50:	89 c1                	mov    %eax,%ecx
   41e52:	d3 e2                	shl    %cl,%edx
   41e54:	89 d0                	mov    %edx,%eax
   41e56:	89 c2                	mov    %eax,%edx
   41e58:	0f b6 05 a4 14 01 00 	movzbl 0x114a4(%rip),%eax        # 53303 <modifiers.1>
   41e5f:	31 d0                	xor    %edx,%eax
   41e61:	88 05 9c 14 01 00    	mov    %al,0x1149c(%rip)        # 53303 <modifiers.1>
        ch = 0;
   41e67:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41e6e:	e9 8e 00 00 00       	jmp    41f01 <keyboard_readc+0x214>
    } else if (ch >= KEY_SHIFT) {
   41e73:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   41e7a:	7e 2d                	jle    41ea9 <keyboard_readc+0x1bc>
        modifiers |= 1 << (ch - KEY_SHIFT);
   41e7c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41e7f:	2d fa 00 00 00       	sub    $0xfa,%eax
   41e84:	ba 01 00 00 00       	mov    $0x1,%edx
   41e89:	89 c1                	mov    %eax,%ecx
   41e8b:	d3 e2                	shl    %cl,%edx
   41e8d:	89 d0                	mov    %edx,%eax
   41e8f:	89 c2                	mov    %eax,%edx
   41e91:	0f b6 05 6b 14 01 00 	movzbl 0x1146b(%rip),%eax        # 53303 <modifiers.1>
   41e98:	09 d0                	or     %edx,%eax
   41e9a:	88 05 63 14 01 00    	mov    %al,0x11463(%rip)        # 53303 <modifiers.1>
        ch = 0;
   41ea0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41ea7:	eb 58                	jmp    41f01 <keyboard_readc+0x214>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   41ea9:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   41ead:	7e 31                	jle    41ee0 <keyboard_readc+0x1f3>
   41eaf:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   41eb6:	7f 28                	jg     41ee0 <keyboard_readc+0x1f3>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   41eb8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41ebb:	8d 50 80             	lea    -0x80(%rax),%edx
   41ebe:	0f b6 05 3e 14 01 00 	movzbl 0x1143e(%rip),%eax        # 53303 <modifiers.1>
   41ec5:	0f b6 c0             	movzbl %al,%eax
   41ec8:	83 e0 03             	and    $0x3,%eax
   41ecb:	48 98                	cltq   
   41ecd:	48 63 d2             	movslq %edx,%rdx
   41ed0:	0f b6 84 90 40 43 04 	movzbl 0x44340(%rax,%rdx,4),%eax
   41ed7:	00 
   41ed8:	0f b6 c0             	movzbl %al,%eax
   41edb:	89 45 fc             	mov    %eax,-0x4(%rbp)
   41ede:	eb 21                	jmp    41f01 <keyboard_readc+0x214>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   41ee0:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   41ee4:	7f 1b                	jg     41f01 <keyboard_readc+0x214>
   41ee6:	0f b6 05 16 14 01 00 	movzbl 0x11416(%rip),%eax        # 53303 <modifiers.1>
   41eed:	0f b6 c0             	movzbl %al,%eax
   41ef0:	83 e0 02             	and    $0x2,%eax
   41ef3:	85 c0                	test   %eax,%eax
   41ef5:	74 0a                	je     41f01 <keyboard_readc+0x214>
        ch = 0;
   41ef7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41efe:	eb 01                	jmp    41f01 <keyboard_readc+0x214>
        if (modifiers & MOD_CONTROL) {
   41f00:	90                   	nop
    }

    return ch;
   41f01:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   41f04:	c9                   	leave  
   41f05:	c3                   	ret    

0000000000041f06 <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   41f06:	55                   	push   %rbp
   41f07:	48 89 e5             	mov    %rsp,%rbp
   41f0a:	48 83 ec 20          	sub    $0x20,%rsp
   41f0e:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41f15:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   41f18:	89 c2                	mov    %eax,%edx
   41f1a:	ec                   	in     (%dx),%al
   41f1b:	88 45 e3             	mov    %al,-0x1d(%rbp)
   41f1e:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   41f25:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41f28:	89 c2                	mov    %eax,%edx
   41f2a:	ec                   	in     (%dx),%al
   41f2b:	88 45 eb             	mov    %al,-0x15(%rbp)
   41f2e:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   41f35:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41f38:	89 c2                	mov    %eax,%edx
   41f3a:	ec                   	in     (%dx),%al
   41f3b:	88 45 f3             	mov    %al,-0xd(%rbp)
   41f3e:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   41f45:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41f48:	89 c2                	mov    %eax,%edx
   41f4a:	ec                   	in     (%dx),%al
   41f4b:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   41f4e:	90                   	nop
   41f4f:	c9                   	leave  
   41f50:	c3                   	ret    

0000000000041f51 <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   41f51:	55                   	push   %rbp
   41f52:	48 89 e5             	mov    %rsp,%rbp
   41f55:	48 83 ec 40          	sub    $0x40,%rsp
   41f59:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   41f5d:	89 f0                	mov    %esi,%eax
   41f5f:	89 55 c0             	mov    %edx,-0x40(%rbp)
   41f62:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   41f65:	8b 05 99 13 01 00    	mov    0x11399(%rip),%eax        # 53304 <initialized.0>
   41f6b:	85 c0                	test   %eax,%eax
   41f6d:	75 1e                	jne    41f8d <parallel_port_putc+0x3c>
   41f6f:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   41f76:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f7a:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   41f7e:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41f81:	ee                   	out    %al,(%dx)
}
   41f82:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   41f83:	c7 05 77 13 01 00 01 	movl   $0x1,0x11377(%rip)        # 53304 <initialized.0>
   41f8a:	00 00 00 
    }

    for (int i = 0;
   41f8d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41f94:	eb 09                	jmp    41f9f <parallel_port_putc+0x4e>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   41f96:	e8 6b ff ff ff       	call   41f06 <delay>
         ++i) {
   41f9b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   41f9f:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   41fa6:	7f 18                	jg     41fc0 <parallel_port_putc+0x6f>
   41fa8:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41faf:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41fb2:	89 c2                	mov    %eax,%edx
   41fb4:	ec                   	in     (%dx),%al
   41fb5:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   41fb8:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   41fbc:	84 c0                	test   %al,%al
   41fbe:	79 d6                	jns    41f96 <parallel_port_putc+0x45>
    }
    outb(IO_PARALLEL1_DATA, c);
   41fc0:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   41fc4:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   41fcb:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41fce:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   41fd2:	8b 55 d8             	mov    -0x28(%rbp),%edx
   41fd5:	ee                   	out    %al,(%dx)
}
   41fd6:	90                   	nop
   41fd7:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   41fde:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41fe2:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   41fe6:	8b 55 e0             	mov    -0x20(%rbp),%edx
   41fe9:	ee                   	out    %al,(%dx)
}
   41fea:	90                   	nop
   41feb:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   41ff2:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ff6:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   41ffa:	8b 55 e8             	mov    -0x18(%rbp),%edx
   41ffd:	ee                   	out    %al,(%dx)
}
   41ffe:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   41fff:	90                   	nop
   42000:	c9                   	leave  
   42001:	c3                   	ret    

0000000000042002 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   42002:	55                   	push   %rbp
   42003:	48 89 e5             	mov    %rsp,%rbp
   42006:	48 83 ec 20          	sub    $0x20,%rsp
   4200a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4200e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   42012:	48 c7 45 f8 51 1f 04 	movq   $0x41f51,-0x8(%rbp)
   42019:	00 
    printer_vprintf(&p, 0, format, val);
   4201a:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   4201e:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   42022:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   42026:	be 00 00 00 00       	mov    $0x0,%esi
   4202b:	48 89 c7             	mov    %rax,%rdi
   4202e:	e8 09 11 00 00       	call   4313c <printer_vprintf>
}
   42033:	90                   	nop
   42034:	c9                   	leave  
   42035:	c3                   	ret    

0000000000042036 <log_printf>:

void log_printf(const char* format, ...) {
   42036:	55                   	push   %rbp
   42037:	48 89 e5             	mov    %rsp,%rbp
   4203a:	48 83 ec 60          	sub    $0x60,%rsp
   4203e:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42042:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42046:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   4204a:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4204e:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42052:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42056:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   4205d:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42061:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42065:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42069:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   4206d:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   42071:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42075:	48 89 d6             	mov    %rdx,%rsi
   42078:	48 89 c7             	mov    %rax,%rdi
   4207b:	e8 82 ff ff ff       	call   42002 <log_vprintf>
    va_end(val);
}
   42080:	90                   	nop
   42081:	c9                   	leave  
   42082:	c3                   	ret    

0000000000042083 <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   42083:	55                   	push   %rbp
   42084:	48 89 e5             	mov    %rsp,%rbp
   42087:	48 83 ec 40          	sub    $0x40,%rsp
   4208b:	89 7d dc             	mov    %edi,-0x24(%rbp)
   4208e:	89 75 d8             	mov    %esi,-0x28(%rbp)
   42091:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   42095:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   42099:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   4209d:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   420a1:	48 8b 0a             	mov    (%rdx),%rcx
   420a4:	48 89 08             	mov    %rcx,(%rax)
   420a7:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   420ab:	48 89 48 08          	mov    %rcx,0x8(%rax)
   420af:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   420b3:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   420b7:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   420bb:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   420bf:	48 89 d6             	mov    %rdx,%rsi
   420c2:	48 89 c7             	mov    %rax,%rdi
   420c5:	e8 38 ff ff ff       	call   42002 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   420ca:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   420ce:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   420d2:	8b 75 d8             	mov    -0x28(%rbp),%esi
   420d5:	8b 45 dc             	mov    -0x24(%rbp),%eax
   420d8:	89 c7                	mov    %eax,%edi
   420da:	e8 0c 1b 00 00       	call   43beb <console_vprintf>
}
   420df:	c9                   	leave  
   420e0:	c3                   	ret    

00000000000420e1 <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   420e1:	55                   	push   %rbp
   420e2:	48 89 e5             	mov    %rsp,%rbp
   420e5:	48 83 ec 60          	sub    $0x60,%rsp
   420e9:	89 7d ac             	mov    %edi,-0x54(%rbp)
   420ec:	89 75 a8             	mov    %esi,-0x58(%rbp)
   420ef:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   420f3:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   420f7:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   420fb:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   420ff:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   42106:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4210a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   4210e:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42112:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   42116:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   4211a:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   4211e:	8b 75 a8             	mov    -0x58(%rbp),%esi
   42121:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42124:	89 c7                	mov    %eax,%edi
   42126:	e8 58 ff ff ff       	call   42083 <error_vprintf>
   4212b:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   4212e:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   42131:	c9                   	leave  
   42132:	c3                   	ret    

0000000000042133 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'f', and 'e' cause a soft
//    reboot where the kernel runs the allocator programs, "fork", or
//    "forkexit", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   42133:	55                   	push   %rbp
   42134:	48 89 e5             	mov    %rsp,%rbp
   42137:	53                   	push   %rbx
   42138:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   4213c:	e8 ac fb ff ff       	call   41ced <keyboard_readc>
   42141:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   42144:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42148:	74 1c                	je     42166 <check_keyboard+0x33>
   4214a:	83 7d e4 66          	cmpl   $0x66,-0x1c(%rbp)
   4214e:	74 16                	je     42166 <check_keyboard+0x33>
   42150:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42154:	74 10                	je     42166 <check_keyboard+0x33>
   42156:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   4215a:	74 0a                	je     42166 <check_keyboard+0x33>
   4215c:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42160:	0f 85 e9 00 00 00    	jne    4224f <check_keyboard+0x11c>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   42166:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   4216d:	00 
        memset(pt, 0, PAGESIZE * 3);
   4216e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42172:	ba 00 30 00 00       	mov    $0x3000,%edx
   42177:	be 00 00 00 00       	mov    $0x0,%esi
   4217c:	48 89 c7             	mov    %rax,%rdi
   4217f:	e8 1c 0d 00 00       	call   42ea0 <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   42184:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42188:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   4218f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42193:	48 05 00 10 00 00    	add    $0x1000,%rax
   42199:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   421a0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   421a4:	48 05 00 20 00 00    	add    $0x2000,%rax
   421aa:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   421b1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   421b5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   421b9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   421bd:	0f 22 d8             	mov    %rax,%cr3
}
   421c0:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   421c1:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "fork";
   421c8:	48 c7 45 e8 98 43 04 	movq   $0x44398,-0x18(%rbp)
   421cf:	00 
        if (c == 'a') {
   421d0:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   421d4:	75 0a                	jne    421e0 <check_keyboard+0xad>
            argument = "allocator";
   421d6:	48 c7 45 e8 9d 43 04 	movq   $0x4439d,-0x18(%rbp)
   421dd:	00 
   421de:	eb 2e                	jmp    4220e <check_keyboard+0xdb>
        } else if (c == 'e') {
   421e0:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   421e4:	75 0a                	jne    421f0 <check_keyboard+0xbd>
            argument = "forkexit";
   421e6:	48 c7 45 e8 a7 43 04 	movq   $0x443a7,-0x18(%rbp)
   421ed:	00 
   421ee:	eb 1e                	jmp    4220e <check_keyboard+0xdb>
        }
        else if (c == 't'){
   421f0:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   421f4:	75 0a                	jne    42200 <check_keyboard+0xcd>
            argument = "test";
   421f6:	48 c7 45 e8 b0 43 04 	movq   $0x443b0,-0x18(%rbp)
   421fd:	00 
   421fe:	eb 0e                	jmp    4220e <check_keyboard+0xdb>
        }
        else if(c == '2'){
   42200:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42204:	75 08                	jne    4220e <check_keyboard+0xdb>
            argument = "test2";
   42206:	48 c7 45 e8 b5 43 04 	movq   $0x443b5,-0x18(%rbp)
   4220d:	00 
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   4220e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42212:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   42216:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4221b:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   4221f:	73 14                	jae    42235 <check_keyboard+0x102>
   42221:	ba bb 43 04 00       	mov    $0x443bb,%edx
   42226:	be 5d 02 00 00       	mov    $0x25d,%esi
   4222b:	bf d7 43 04 00       	mov    $0x443d7,%edi
   42230:	e8 1f 01 00 00       	call   42354 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   42235:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42239:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   4223c:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   42240:	48 89 c3             	mov    %rax,%rbx
   42243:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   42248:	e9 b3 dd ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   4224d:	eb 11                	jmp    42260 <check_keyboard+0x12d>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   4224f:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   42253:	74 06                	je     4225b <check_keyboard+0x128>
   42255:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   42259:	75 05                	jne    42260 <check_keyboard+0x12d>
        poweroff();
   4225b:	e8 9d f8 ff ff       	call   41afd <poweroff>
    }
    return c;
   42260:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   42263:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42267:	c9                   	leave  
   42268:	c3                   	ret    

0000000000042269 <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   42269:	55                   	push   %rbp
   4226a:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   4226d:	e8 c1 fe ff ff       	call   42133 <check_keyboard>
   42272:	eb f9                	jmp    4226d <fail+0x4>

0000000000042274 <panic>:

// panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void panic(const char* format, ...) {
   42274:	55                   	push   %rbp
   42275:	48 89 e5             	mov    %rsp,%rbp
   42278:	48 83 ec 60          	sub    $0x60,%rsp
   4227c:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42280:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42284:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42288:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4228c:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42290:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42294:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   4229b:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4229f:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   422a3:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   422a7:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   422ab:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   422b0:	0f 84 80 00 00 00    	je     42336 <panic+0xc2>
        // Print panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   422b6:	ba eb 43 04 00       	mov    $0x443eb,%edx
   422bb:	be 00 c0 00 00       	mov    $0xc000,%esi
   422c0:	bf 30 07 00 00       	mov    $0x730,%edi
   422c5:	b8 00 00 00 00       	mov    $0x0,%eax
   422ca:	e8 12 fe ff ff       	call   420e1 <error_printf>
   422cf:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   422d2:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   422d6:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   422da:	8b 45 cc             	mov    -0x34(%rbp),%eax
   422dd:	be 00 c0 00 00       	mov    $0xc000,%esi
   422e2:	89 c7                	mov    %eax,%edi
   422e4:	e8 9a fd ff ff       	call   42083 <error_vprintf>
   422e9:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   422ec:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   422ef:	48 63 c1             	movslq %ecx,%rax
   422f2:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   422f9:	48 c1 e8 20          	shr    $0x20,%rax
   422fd:	89 c2                	mov    %eax,%edx
   422ff:	c1 fa 05             	sar    $0x5,%edx
   42302:	89 c8                	mov    %ecx,%eax
   42304:	c1 f8 1f             	sar    $0x1f,%eax
   42307:	29 c2                	sub    %eax,%edx
   42309:	89 d0                	mov    %edx,%eax
   4230b:	c1 e0 02             	shl    $0x2,%eax
   4230e:	01 d0                	add    %edx,%eax
   42310:	c1 e0 04             	shl    $0x4,%eax
   42313:	29 c1                	sub    %eax,%ecx
   42315:	89 ca                	mov    %ecx,%edx
   42317:	85 d2                	test   %edx,%edx
   42319:	74 34                	je     4234f <panic+0xdb>
            error_printf(cpos, 0xC000, "\n");
   4231b:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4231e:	ba f3 43 04 00       	mov    $0x443f3,%edx
   42323:	be 00 c0 00 00       	mov    $0xc000,%esi
   42328:	89 c7                	mov    %eax,%edi
   4232a:	b8 00 00 00 00       	mov    $0x0,%eax
   4232f:	e8 ad fd ff ff       	call   420e1 <error_printf>
   42334:	eb 19                	jmp    4234f <panic+0xdb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   42336:	ba f5 43 04 00       	mov    $0x443f5,%edx
   4233b:	be 00 c0 00 00       	mov    $0xc000,%esi
   42340:	bf 30 07 00 00       	mov    $0x730,%edi
   42345:	b8 00 00 00 00       	mov    $0x0,%eax
   4234a:	e8 92 fd ff ff       	call   420e1 <error_printf>
    }

    va_end(val);
    fail();
   4234f:	e8 15 ff ff ff       	call   42269 <fail>

0000000000042354 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   42354:	55                   	push   %rbp
   42355:	48 89 e5             	mov    %rsp,%rbp
   42358:	48 83 ec 20          	sub    $0x20,%rsp
   4235c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42360:	89 75 f4             	mov    %esi,-0xc(%rbp)
   42363:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   42367:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   4236b:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4236e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42372:	48 89 c6             	mov    %rax,%rsi
   42375:	bf fb 43 04 00       	mov    $0x443fb,%edi
   4237a:	b8 00 00 00 00       	mov    $0x0,%eax
   4237f:	e8 f0 fe ff ff       	call   42274 <panic>

0000000000042384 <default_exception>:
}

void default_exception(proc* p){
   42384:	55                   	push   %rbp
   42385:	48 89 e5             	mov    %rsp,%rbp
   42388:	48 83 ec 20          	sub    $0x20,%rsp
   4238c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   42390:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42394:	48 83 c0 08          	add    $0x8,%rax
   42398:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    panic("Unexpected exception %d!\n", reg->reg_intno);
   4239c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   423a0:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   423a7:	48 89 c6             	mov    %rax,%rsi
   423aa:	bf 19 44 04 00       	mov    $0x44419,%edi
   423af:	b8 00 00 00 00       	mov    $0x0,%eax
   423b4:	e8 bb fe ff ff       	call   42274 <panic>

00000000000423b9 <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   423b9:	55                   	push   %rbp
   423ba:	48 89 e5             	mov    %rsp,%rbp
   423bd:	48 83 ec 10          	sub    $0x10,%rsp
   423c1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   423c5:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   423c8:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   423cc:	78 06                	js     423d4 <pageindex+0x1b>
   423ce:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   423d2:	7e 14                	jle    423e8 <pageindex+0x2f>
   423d4:	ba 38 44 04 00       	mov    $0x44438,%edx
   423d9:	be 1e 00 00 00       	mov    $0x1e,%esi
   423de:	bf 51 44 04 00       	mov    $0x44451,%edi
   423e3:	e8 6c ff ff ff       	call   42354 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   423e8:	b8 03 00 00 00       	mov    $0x3,%eax
   423ed:	2b 45 f4             	sub    -0xc(%rbp),%eax
   423f0:	89 c2                	mov    %eax,%edx
   423f2:	89 d0                	mov    %edx,%eax
   423f4:	c1 e0 03             	shl    $0x3,%eax
   423f7:	01 d0                	add    %edx,%eax
   423f9:	83 c0 0c             	add    $0xc,%eax
   423fc:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42400:	89 c1                	mov    %eax,%ecx
   42402:	48 d3 ea             	shr    %cl,%rdx
   42405:	48 89 d0             	mov    %rdx,%rax
   42408:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   4240d:	c9                   	leave  
   4240e:	c3                   	ret    

000000000004240f <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   4240f:	55                   	push   %rbp
   42410:	48 89 e5             	mov    %rsp,%rbp
   42413:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   42417:	48 c7 05 de 1b 01 00 	movq   $0x55000,0x11bde(%rip)        # 54000 <kernel_pagetable>
   4241e:	00 50 05 00 
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   42422:	ba 00 50 00 00       	mov    $0x5000,%edx
   42427:	be 00 00 00 00       	mov    $0x0,%esi
   4242c:	bf 00 50 05 00       	mov    $0x55000,%edi
   42431:	e8 6a 0a 00 00       	call   42ea0 <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   42436:	b8 00 60 05 00       	mov    $0x56000,%eax
   4243b:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   4243f:	48 89 05 ba 2b 01 00 	mov    %rax,0x12bba(%rip)        # 55000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   42446:	b8 00 70 05 00       	mov    $0x57000,%eax
   4244b:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   4244f:	48 89 05 aa 3b 01 00 	mov    %rax,0x13baa(%rip)        # 56000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   42456:	b8 00 80 05 00       	mov    $0x58000,%eax
   4245b:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   4245f:	48 89 05 9a 4b 01 00 	mov    %rax,0x14b9a(%rip)        # 57000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   42466:	b8 00 90 05 00       	mov    $0x59000,%eax
   4246b:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   4246f:	48 89 05 92 4b 01 00 	mov    %rax,0x14b92(%rip)        # 57008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   42476:	48 8b 05 83 1b 01 00 	mov    0x11b83(%rip),%rax        # 54000 <kernel_pagetable>
   4247d:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42483:	b9 00 00 20 00       	mov    $0x200000,%ecx
   42488:	ba 00 00 00 00       	mov    $0x0,%edx
   4248d:	be 00 00 00 00       	mov    $0x0,%esi
   42492:	48 89 c7             	mov    %rax,%rdi
   42495:	e8 b9 01 00 00       	call   42653 <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   4249a:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   424a1:	00 
   424a2:	eb 62                	jmp    42506 <virtual_memory_init+0xf7>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   424a4:	48 8b 0d 55 1b 01 00 	mov    0x11b55(%rip),%rcx        # 54000 <kernel_pagetable>
   424ab:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   424af:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   424b3:	48 89 ce             	mov    %rcx,%rsi
   424b6:	48 89 c7             	mov    %rax,%rdi
   424b9:	e8 50 05 00 00       	call   42a0e <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l1pagetable ?
        assert(vmap.pa == addr);
   424be:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   424c2:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   424c6:	74 14                	je     424dc <virtual_memory_init+0xcd>
   424c8:	ba 65 44 04 00       	mov    $0x44465,%edx
   424cd:	be 2d 00 00 00       	mov    $0x2d,%esi
   424d2:	bf 75 44 04 00       	mov    $0x44475,%edi
   424d7:	e8 78 fe ff ff       	call   42354 <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   424dc:	8b 45 f0             	mov    -0x10(%rbp),%eax
   424df:	48 98                	cltq   
   424e1:	83 e0 03             	and    $0x3,%eax
   424e4:	48 83 f8 03          	cmp    $0x3,%rax
   424e8:	74 14                	je     424fe <virtual_memory_init+0xef>
   424ea:	ba 88 44 04 00       	mov    $0x44488,%edx
   424ef:	be 2e 00 00 00       	mov    $0x2e,%esi
   424f4:	bf 75 44 04 00       	mov    $0x44475,%edi
   424f9:	e8 56 fe ff ff       	call   42354 <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   424fe:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42505:	00 
   42506:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   4250d:	00 
   4250e:	76 94                	jbe    424a4 <virtual_memory_init+0x95>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   42510:	48 8b 05 e9 1a 01 00 	mov    0x11ae9(%rip),%rax        # 54000 <kernel_pagetable>
   42517:	48 89 c7             	mov    %rax,%rdi
   4251a:	e8 03 00 00 00       	call   42522 <set_pagetable>
}
   4251f:	90                   	nop
   42520:	c9                   	leave  
   42521:	c3                   	ret    

0000000000042522 <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   42522:	55                   	push   %rbp
   42523:	48 89 e5             	mov    %rsp,%rbp
   42526:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   4252a:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   4252e:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42532:	25 ff 0f 00 00       	and    $0xfff,%eax
   42537:	48 85 c0             	test   %rax,%rax
   4253a:	74 14                	je     42550 <set_pagetable+0x2e>
   4253c:	ba b5 44 04 00       	mov    $0x444b5,%edx
   42541:	be 3d 00 00 00       	mov    $0x3d,%esi
   42546:	bf 75 44 04 00       	mov    $0x44475,%edi
   4254b:	e8 04 fe ff ff       	call   42354 <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   42550:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42555:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   42559:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   4255d:	48 89 ce             	mov    %rcx,%rsi
   42560:	48 89 c7             	mov    %rax,%rdi
   42563:	e8 a6 04 00 00       	call   42a0e <virtual_memory_lookup>
   42568:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   4256c:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42571:	48 39 d0             	cmp    %rdx,%rax
   42574:	74 14                	je     4258a <set_pagetable+0x68>
   42576:	ba d0 44 04 00       	mov    $0x444d0,%edx
   4257b:	be 3f 00 00 00       	mov    $0x3f,%esi
   42580:	bf 75 44 04 00       	mov    $0x44475,%edi
   42585:	e8 ca fd ff ff       	call   42354 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   4258a:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   4258e:	48 8b 0d 6b 1a 01 00 	mov    0x11a6b(%rip),%rcx        # 54000 <kernel_pagetable>
   42595:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   42599:	48 89 ce             	mov    %rcx,%rsi
   4259c:	48 89 c7             	mov    %rax,%rdi
   4259f:	e8 6a 04 00 00       	call   42a0e <virtual_memory_lookup>
   425a4:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   425a8:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   425ac:	48 39 c2             	cmp    %rax,%rdx
   425af:	74 14                	je     425c5 <set_pagetable+0xa3>
   425b1:	ba 38 45 04 00       	mov    $0x44538,%edx
   425b6:	be 41 00 00 00       	mov    $0x41,%esi
   425bb:	bf 75 44 04 00       	mov    $0x44475,%edi
   425c0:	e8 8f fd ff ff       	call   42354 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   425c5:	48 8b 05 34 1a 01 00 	mov    0x11a34(%rip),%rax        # 54000 <kernel_pagetable>
   425cc:	48 89 c2             	mov    %rax,%rdx
   425cf:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   425d3:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   425d7:	48 89 ce             	mov    %rcx,%rsi
   425da:	48 89 c7             	mov    %rax,%rdi
   425dd:	e8 2c 04 00 00       	call   42a0e <virtual_memory_lookup>
   425e2:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   425e6:	48 8b 15 13 1a 01 00 	mov    0x11a13(%rip),%rdx        # 54000 <kernel_pagetable>
   425ed:	48 39 d0             	cmp    %rdx,%rax
   425f0:	74 14                	je     42606 <set_pagetable+0xe4>
   425f2:	ba 98 45 04 00       	mov    $0x44598,%edx
   425f7:	be 43 00 00 00       	mov    $0x43,%esi
   425fc:	bf 75 44 04 00       	mov    $0x44475,%edi
   42601:	e8 4e fd ff ff       	call   42354 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   42606:	ba 53 26 04 00       	mov    $0x42653,%edx
   4260b:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   4260f:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42613:	48 89 ce             	mov    %rcx,%rsi
   42616:	48 89 c7             	mov    %rax,%rdi
   42619:	e8 f0 03 00 00       	call   42a0e <virtual_memory_lookup>
   4261e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42622:	ba 53 26 04 00       	mov    $0x42653,%edx
   42627:	48 39 d0             	cmp    %rdx,%rax
   4262a:	74 14                	je     42640 <set_pagetable+0x11e>
   4262c:	ba 00 46 04 00       	mov    $0x44600,%edx
   42631:	be 45 00 00 00       	mov    $0x45,%esi
   42636:	bf 75 44 04 00       	mov    $0x44475,%edi
   4263b:	e8 14 fd ff ff       	call   42354 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   42640:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42644:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42648:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4264c:	0f 22 d8             	mov    %rax,%cr3
}
   4264f:	90                   	nop
}
   42650:	90                   	nop
   42651:	c9                   	leave  
   42652:	c3                   	ret    

0000000000042653 <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   42653:	55                   	push   %rbp
   42654:	48 89 e5             	mov    %rsp,%rbp
   42657:	53                   	push   %rbx
   42658:	48 83 ec 58          	sub    $0x58,%rsp
   4265c:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42660:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42664:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   42668:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
   4266c:	44 89 45 ac          	mov    %r8d,-0x54(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   42670:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42674:	25 ff 0f 00 00       	and    $0xfff,%eax
   42679:	48 85 c0             	test   %rax,%rax
   4267c:	74 14                	je     42692 <virtual_memory_map+0x3f>
   4267e:	ba 66 46 04 00       	mov    $0x44666,%edx
   42683:	be 66 00 00 00       	mov    $0x66,%esi
   42688:	bf 75 44 04 00       	mov    $0x44475,%edi
   4268d:	e8 c2 fc ff ff       	call   42354 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   42692:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42696:	25 ff 0f 00 00       	and    $0xfff,%eax
   4269b:	48 85 c0             	test   %rax,%rax
   4269e:	74 14                	je     426b4 <virtual_memory_map+0x61>
   426a0:	ba 79 46 04 00       	mov    $0x44679,%edx
   426a5:	be 67 00 00 00       	mov    $0x67,%esi
   426aa:	bf 75 44 04 00       	mov    $0x44475,%edi
   426af:	e8 a0 fc ff ff       	call   42354 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   426b4:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   426b8:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   426bc:	48 01 d0             	add    %rdx,%rax
   426bf:	48 3b 45 c0          	cmp    -0x40(%rbp),%rax
   426c3:	73 24                	jae    426e9 <virtual_memory_map+0x96>
   426c5:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   426c9:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   426cd:	48 01 d0             	add    %rdx,%rax
   426d0:	48 85 c0             	test   %rax,%rax
   426d3:	74 14                	je     426e9 <virtual_memory_map+0x96>
   426d5:	ba 8c 46 04 00       	mov    $0x4468c,%edx
   426da:	be 68 00 00 00       	mov    $0x68,%esi
   426df:	bf 75 44 04 00       	mov    $0x44475,%edi
   426e4:	e8 6b fc ff ff       	call   42354 <assert_fail>
    if (perm & PTE_P) {
   426e9:	8b 45 ac             	mov    -0x54(%rbp),%eax
   426ec:	48 98                	cltq   
   426ee:	83 e0 01             	and    $0x1,%eax
   426f1:	48 85 c0             	test   %rax,%rax
   426f4:	74 6e                	je     42764 <virtual_memory_map+0x111>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   426f6:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   426fa:	25 ff 0f 00 00       	and    $0xfff,%eax
   426ff:	48 85 c0             	test   %rax,%rax
   42702:	74 14                	je     42718 <virtual_memory_map+0xc5>
   42704:	ba aa 46 04 00       	mov    $0x446aa,%edx
   42709:	be 6a 00 00 00       	mov    $0x6a,%esi
   4270e:	bf 75 44 04 00       	mov    $0x44475,%edi
   42713:	e8 3c fc ff ff       	call   42354 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   42718:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   4271c:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42720:	48 01 d0             	add    %rdx,%rax
   42723:	48 3b 45 b8          	cmp    -0x48(%rbp),%rax
   42727:	73 14                	jae    4273d <virtual_memory_map+0xea>
   42729:	ba bd 46 04 00       	mov    $0x446bd,%edx
   4272e:	be 6b 00 00 00       	mov    $0x6b,%esi
   42733:	bf 75 44 04 00       	mov    $0x44475,%edi
   42738:	e8 17 fc ff ff       	call   42354 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   4273d:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42741:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42745:	48 01 d0             	add    %rdx,%rax
   42748:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   4274e:	76 14                	jbe    42764 <virtual_memory_map+0x111>
   42750:	ba cb 46 04 00       	mov    $0x446cb,%edx
   42755:	be 6c 00 00 00       	mov    $0x6c,%esi
   4275a:	bf 75 44 04 00       	mov    $0x44475,%edi
   4275f:	e8 f0 fb ff ff       	call   42354 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   42764:	83 7d ac 00          	cmpl   $0x0,-0x54(%rbp)
   42768:	78 09                	js     42773 <virtual_memory_map+0x120>
   4276a:	81 7d ac ff 0f 00 00 	cmpl   $0xfff,-0x54(%rbp)
   42771:	7e 14                	jle    42787 <virtual_memory_map+0x134>
   42773:	ba e7 46 04 00       	mov    $0x446e7,%edx
   42778:	be 6e 00 00 00       	mov    $0x6e,%esi
   4277d:	bf 75 44 04 00       	mov    $0x44475,%edi
   42782:	e8 cd fb ff ff       	call   42354 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   42787:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4278b:	25 ff 0f 00 00       	and    $0xfff,%eax
   42790:	48 85 c0             	test   %rax,%rax
   42793:	74 14                	je     427a9 <virtual_memory_map+0x156>
   42795:	ba 08 47 04 00       	mov    $0x44708,%edx
   4279a:	be 6f 00 00 00       	mov    $0x6f,%esi
   4279f:	bf 75 44 04 00       	mov    $0x44475,%edi
   427a4:	e8 ab fb ff ff       	call   42354 <assert_fail>

    int last_index123 = -1;
   427a9:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%rbp)
    x86_64_pagetable* l1pagetable = NULL;
   427b0:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
   427b7:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   427b8:	e9 e1 00 00 00       	jmp    4289e <virtual_memory_map+0x24b>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   427bd:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   427c1:	48 c1 e8 15          	shr    $0x15,%rax
   427c5:	89 45 dc             	mov    %eax,-0x24(%rbp)
        if (cur_index123 != last_index123) {
   427c8:	8b 45 dc             	mov    -0x24(%rbp),%eax
   427cb:	3b 45 ec             	cmp    -0x14(%rbp),%eax
   427ce:	74 20                	je     427f0 <virtual_memory_map+0x19d>
            // TODO --> done
            // find pointer to last level pagetable for current va

			l1pagetable = lookup_l1pagetable(pagetable, va, perm);	
   427d0:	8b 55 ac             	mov    -0x54(%rbp),%edx
   427d3:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   427d7:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   427db:	48 89 ce             	mov    %rcx,%rsi
   427de:	48 89 c7             	mov    %rax,%rdi
   427e1:	e8 ce 00 00 00       	call   428b4 <lookup_l1pagetable>
   427e6:	48 89 45 e0          	mov    %rax,-0x20(%rbp)

            last_index123 = cur_index123;
   427ea:	8b 45 dc             	mov    -0x24(%rbp),%eax
   427ed:	89 45 ec             	mov    %eax,-0x14(%rbp)
        }
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   427f0:	8b 45 ac             	mov    -0x54(%rbp),%eax
   427f3:	48 98                	cltq   
   427f5:	83 e0 01             	and    $0x1,%eax
   427f8:	48 85 c0             	test   %rax,%rax
   427fb:	74 34                	je     42831 <virtual_memory_map+0x1de>
   427fd:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42802:	74 2d                	je     42831 <virtual_memory_map+0x1de>
            // TODO --> done
            // map `pa` at appropriate entry with permissions `perm`
			l1pagetable->entry[L1PAGEINDEX(va)] =  pa | perm;
   42804:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42807:	48 63 d8             	movslq %eax,%rbx
   4280a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4280e:	be 03 00 00 00       	mov    $0x3,%esi
   42813:	48 89 c7             	mov    %rax,%rdi
   42816:	e8 9e fb ff ff       	call   423b9 <pageindex>
   4281b:	89 c2                	mov    %eax,%edx
   4281d:	48 0b 5d b8          	or     -0x48(%rbp),%rbx
   42821:	48 89 d9             	mov    %rbx,%rcx
   42824:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42828:	48 63 d2             	movslq %edx,%rdx
   4282b:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   4282f:	eb 55                	jmp    42886 <virtual_memory_map+0x233>

        } else if (l1pagetable) { // if page is NOT marked present
   42831:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42836:	74 26                	je     4285e <virtual_memory_map+0x20b>
            // TODO --> done
            // map to address 0 with `perm`
			l1pagetable->entry[L1PAGEINDEX(va)] = 0 | perm;
   42838:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4283c:	be 03 00 00 00       	mov    $0x3,%esi
   42841:	48 89 c7             	mov    %rax,%rdi
   42844:	e8 70 fb ff ff       	call   423b9 <pageindex>
   42849:	89 c2                	mov    %eax,%edx
   4284b:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4284e:	48 63 c8             	movslq %eax,%rcx
   42851:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42855:	48 63 d2             	movslq %edx,%rdx
   42858:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   4285c:	eb 28                	jmp    42886 <virtual_memory_map+0x233>

        } else if (perm & PTE_P) {
   4285e:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42861:	48 98                	cltq   
   42863:	83 e0 01             	and    $0x1,%eax
   42866:	48 85 c0             	test   %rax,%rax
   42869:	74 1b                	je     42886 <virtual_memory_map+0x233>
            // error, no allocated l1 page found for va
            log_printf("[Kern Info] failed to find l1pagetable address at " __FILE__ ": %d\n", __LINE__);
   4286b:	be 8b 00 00 00       	mov    $0x8b,%esi
   42870:	bf 30 47 04 00       	mov    $0x44730,%edi
   42875:	b8 00 00 00 00       	mov    $0x0,%eax
   4287a:	e8 b7 f7 ff ff       	call   42036 <log_printf>
            return -1;
   4287f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42884:	eb 28                	jmp    428ae <virtual_memory_map+0x25b>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42886:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
   4288d:	00 
   4288e:	48 81 45 b8 00 10 00 	addq   $0x1000,-0x48(%rbp)
   42895:	00 
   42896:	48 81 6d b0 00 10 00 	subq   $0x1000,-0x50(%rbp)
   4289d:	00 
   4289e:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   428a3:	0f 85 14 ff ff ff    	jne    427bd <virtual_memory_map+0x16a>
        }
    }
    return 0;
   428a9:	b8 00 00 00 00       	mov    $0x0,%eax
}
   428ae:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   428b2:	c9                   	leave  
   428b3:	c3                   	ret    

00000000000428b4 <lookup_l1pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   428b4:	55                   	push   %rbp
   428b5:	48 89 e5             	mov    %rsp,%rbp
   428b8:	48 83 ec 40          	sub    $0x40,%rsp
   428bc:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   428c0:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   428c4:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   428c7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   428cb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l1 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   428cf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   428d6:	e9 23 01 00 00       	jmp    429fe <lookup_l1pagetable+0x14a>
        // TODO --> done
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        x86_64_pageentry_t pe = pt->entry[PAGEINDEX(va, i)]; // replace this
   428db:	8b 55 f4             	mov    -0xc(%rbp),%edx
   428de:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   428e2:	89 d6                	mov    %edx,%esi
   428e4:	48 89 c7             	mov    %rax,%rdi
   428e7:	e8 cd fa ff ff       	call   423b9 <pageindex>
   428ec:	89 c2                	mov    %eax,%edx
   428ee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   428f2:	48 63 d2             	movslq %edx,%rdx
   428f5:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   428f9:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   428fd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42901:	83 e0 01             	and    $0x1,%eax
   42904:	48 85 c0             	test   %rax,%rax
   42907:	75 63                	jne    4296c <lookup_l1pagetable+0xb8>
            log_printf("[Kern Info] Error looking up l1pagetable: Pagetable address: 0x%x perm: 0x%x."
   42909:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4290c:	8d 48 02             	lea    0x2(%rax),%ecx
   4290f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42913:	25 ff 0f 00 00       	and    $0xfff,%eax
   42918:	48 89 c2             	mov    %rax,%rdx
   4291b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4291f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42925:	48 89 c6             	mov    %rax,%rsi
   42928:	bf 78 47 04 00       	mov    $0x44778,%edi
   4292d:	b8 00 00 00 00       	mov    $0x0,%eax
   42932:	e8 ff f6 ff ff       	call   42036 <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   42937:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4293a:	48 98                	cltq   
   4293c:	83 e0 01             	and    $0x1,%eax
   4293f:	48 85 c0             	test   %rax,%rax
   42942:	75 0a                	jne    4294e <lookup_l1pagetable+0x9a>
                return NULL;
   42944:	b8 00 00 00 00       	mov    $0x0,%eax
   42949:	e9 be 00 00 00       	jmp    42a0c <lookup_l1pagetable+0x158>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   4294e:	be af 00 00 00       	mov    $0xaf,%esi
   42953:	bf e0 47 04 00       	mov    $0x447e0,%edi
   42958:	b8 00 00 00 00       	mov    $0x0,%eax
   4295d:	e8 d4 f6 ff ff       	call   42036 <log_printf>
            return NULL;
   42962:	b8 00 00 00 00       	mov    $0x0,%eax
   42967:	e9 a0 00 00 00       	jmp    42a0c <lookup_l1pagetable+0x158>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   4296c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42970:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42976:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   4297c:	76 14                	jbe    42992 <lookup_l1pagetable+0xde>
   4297e:	ba 28 48 04 00       	mov    $0x44828,%edx
   42983:	be b4 00 00 00       	mov    $0xb4,%esi
   42988:	bf 75 44 04 00       	mov    $0x44475,%edi
   4298d:	e8 c2 f9 ff ff       	call   42354 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   42992:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42995:	48 98                	cltq   
   42997:	83 e0 02             	and    $0x2,%eax
   4299a:	48 85 c0             	test   %rax,%rax
   4299d:	74 20                	je     429bf <lookup_l1pagetable+0x10b>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   4299f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   429a3:	83 e0 02             	and    $0x2,%eax
   429a6:	48 85 c0             	test   %rax,%rax
   429a9:	75 14                	jne    429bf <lookup_l1pagetable+0x10b>
   429ab:	ba 48 48 04 00       	mov    $0x44848,%edx
   429b0:	be b6 00 00 00       	mov    $0xb6,%esi
   429b5:	bf 75 44 04 00       	mov    $0x44475,%edi
   429ba:	e8 95 f9 ff ff       	call   42354 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   429bf:	8b 45 cc             	mov    -0x34(%rbp),%eax
   429c2:	48 98                	cltq   
   429c4:	83 e0 04             	and    $0x4,%eax
   429c7:	48 85 c0             	test   %rax,%rax
   429ca:	74 20                	je     429ec <lookup_l1pagetable+0x138>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   429cc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   429d0:	83 e0 04             	and    $0x4,%eax
   429d3:	48 85 c0             	test   %rax,%rax
   429d6:	75 14                	jne    429ec <lookup_l1pagetable+0x138>
   429d8:	ba 53 48 04 00       	mov    $0x44853,%edx
   429dd:	be b9 00 00 00       	mov    $0xb9,%esi
   429e2:	bf 75 44 04 00       	mov    $0x44475,%edi
   429e7:	e8 68 f9 ff ff       	call   42354 <assert_fail>
        }

        // TODO --> done
        // set pt to physical address to next pagetable using `pe`
        pt = (x86_64_pagetable *) PTE_ADDR(pe); // replace this
   429ec:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   429f0:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   429f6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   429fa:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   429fe:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   42a02:	0f 8e d3 fe ff ff    	jle    428db <lookup_l1pagetable+0x27>
    }
    return pt;
   42a08:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   42a0c:	c9                   	leave  
   42a0d:	c3                   	ret    

0000000000042a0e <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   42a0e:	55                   	push   %rbp
   42a0f:	48 89 e5             	mov    %rsp,%rbp
   42a12:	48 83 ec 50          	sub    $0x50,%rsp
   42a16:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42a1a:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42a1e:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   42a22:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42a26:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   42a2a:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   42a31:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42a32:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   42a39:	eb 41                	jmp    42a7c <virtual_memory_lookup+0x6e>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   42a3b:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42a3e:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42a42:	89 d6                	mov    %edx,%esi
   42a44:	48 89 c7             	mov    %rax,%rdi
   42a47:	e8 6d f9 ff ff       	call   423b9 <pageindex>
   42a4c:	89 c2                	mov    %eax,%edx
   42a4e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42a52:	48 63 d2             	movslq %edx,%rdx
   42a55:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   42a59:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42a5d:	83 e0 06             	and    $0x6,%eax
   42a60:	48 f7 d0             	not    %rax
   42a63:	48 21 d0             	and    %rdx,%rax
   42a66:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42a6a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42a6e:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42a74:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42a78:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   42a7c:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   42a80:	7f 0c                	jg     42a8e <virtual_memory_lookup+0x80>
   42a82:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42a86:	83 e0 01             	and    $0x1,%eax
   42a89:	48 85 c0             	test   %rax,%rax
   42a8c:	75 ad                	jne    42a3b <virtual_memory_lookup+0x2d>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   42a8e:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   42a95:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   42a9c:	ff 
   42a9d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   42aa4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42aa8:	83 e0 01             	and    $0x1,%eax
   42aab:	48 85 c0             	test   %rax,%rax
   42aae:	74 34                	je     42ae4 <virtual_memory_lookup+0xd6>
        vam.pn = PAGENUMBER(pe);
   42ab0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ab4:	48 c1 e8 0c          	shr    $0xc,%rax
   42ab8:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   42abb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42abf:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42ac5:	48 89 c2             	mov    %rax,%rdx
   42ac8:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42acc:	25 ff 0f 00 00       	and    $0xfff,%eax
   42ad1:	48 09 d0             	or     %rdx,%rax
   42ad4:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   42ad8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42adc:	25 ff 0f 00 00       	and    $0xfff,%eax
   42ae1:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   42ae4:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42ae8:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42aec:	48 89 10             	mov    %rdx,(%rax)
   42aef:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   42af3:	48 89 50 08          	mov    %rdx,0x8(%rax)
   42af7:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42afb:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   42aff:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42b03:	c9                   	leave  
   42b04:	c3                   	ret    

0000000000042b05 <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   42b05:	55                   	push   %rbp
   42b06:	48 89 e5             	mov    %rsp,%rbp
   42b09:	48 83 ec 40          	sub    $0x40,%rsp
   42b0d:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42b11:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   42b14:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   42b18:	c7 45 f8 07 00 00 00 	movl   $0x7,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   42b1f:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   42b23:	78 08                	js     42b2d <program_load+0x28>
   42b25:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42b28:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   42b2b:	7c 14                	jl     42b41 <program_load+0x3c>
   42b2d:	ba 60 48 04 00       	mov    $0x44860,%edx
   42b32:	be 37 00 00 00       	mov    $0x37,%esi
   42b37:	bf 90 48 04 00       	mov    $0x44890,%edi
   42b3c:	e8 13 f8 ff ff       	call   42354 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   42b41:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42b44:	48 98                	cltq   
   42b46:	48 c1 e0 04          	shl    $0x4,%rax
   42b4a:	48 05 20 50 04 00    	add    $0x45020,%rax
   42b50:	48 8b 00             	mov    (%rax),%rax
   42b53:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   42b57:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42b5b:	8b 00                	mov    (%rax),%eax
   42b5d:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   42b62:	74 14                	je     42b78 <program_load+0x73>
   42b64:	ba a2 48 04 00       	mov    $0x448a2,%edx
   42b69:	be 39 00 00 00       	mov    $0x39,%esi
   42b6e:	bf 90 48 04 00       	mov    $0x44890,%edi
   42b73:	e8 dc f7 ff ff       	call   42354 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   42b78:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42b7c:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42b80:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42b84:	48 01 d0             	add    %rdx,%rax
   42b87:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   42b8b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42b92:	e9 94 00 00 00       	jmp    42c2b <program_load+0x126>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   42b97:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42b9a:	48 63 d0             	movslq %eax,%rdx
   42b9d:	48 89 d0             	mov    %rdx,%rax
   42ba0:	48 c1 e0 03          	shl    $0x3,%rax
   42ba4:	48 29 d0             	sub    %rdx,%rax
   42ba7:	48 c1 e0 03          	shl    $0x3,%rax
   42bab:	48 89 c2             	mov    %rax,%rdx
   42bae:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42bb2:	48 01 d0             	add    %rdx,%rax
   42bb5:	8b 00                	mov    (%rax),%eax
   42bb7:	83 f8 01             	cmp    $0x1,%eax
   42bba:	75 6b                	jne    42c27 <program_load+0x122>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   42bbc:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42bbf:	48 63 d0             	movslq %eax,%rdx
   42bc2:	48 89 d0             	mov    %rdx,%rax
   42bc5:	48 c1 e0 03          	shl    $0x3,%rax
   42bc9:	48 29 d0             	sub    %rdx,%rax
   42bcc:	48 c1 e0 03          	shl    $0x3,%rax
   42bd0:	48 89 c2             	mov    %rax,%rdx
   42bd3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42bd7:	48 01 d0             	add    %rdx,%rax
   42bda:	48 8b 50 08          	mov    0x8(%rax),%rdx
   42bde:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42be2:	48 01 d0             	add    %rdx,%rax
   42be5:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   42be9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42bec:	48 63 d0             	movslq %eax,%rdx
   42bef:	48 89 d0             	mov    %rdx,%rax
   42bf2:	48 c1 e0 03          	shl    $0x3,%rax
   42bf6:	48 29 d0             	sub    %rdx,%rax
   42bf9:	48 c1 e0 03          	shl    $0x3,%rax
   42bfd:	48 89 c2             	mov    %rax,%rdx
   42c00:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c04:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   42c08:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42c0c:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42c10:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42c14:	48 89 c7             	mov    %rax,%rdi
   42c17:	e8 3d 00 00 00       	call   42c59 <program_load_segment>
   42c1c:	85 c0                	test   %eax,%eax
   42c1e:	79 07                	jns    42c27 <program_load+0x122>
                return -1;
   42c20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42c25:	eb 30                	jmp    42c57 <program_load+0x152>
    for (int i = 0; i < eh->e_phnum; ++i) {
   42c27:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   42c2b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c2f:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   42c33:	0f b7 c0             	movzwl %ax,%eax
   42c36:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   42c39:	0f 8c 58 ff ff ff    	jl     42b97 <program_load+0x92>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   42c3f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c43:	48 8b 50 18          	mov    0x18(%rax),%rdx
   42c47:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42c4b:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    return 0;
   42c52:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42c57:	c9                   	leave  
   42c58:	c3                   	ret    

0000000000042c59 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   42c59:	55                   	push   %rbp
   42c5a:	48 89 e5             	mov    %rsp,%rbp
   42c5d:	48 83 ec 40          	sub    $0x40,%rsp
   42c61:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42c65:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42c69:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   42c6d:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   42c71:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42c75:	48 8b 40 10          	mov    0x10(%rax),%rax
   42c79:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   42c7d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42c81:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42c85:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c89:	48 01 d0             	add    %rdx,%rax
   42c8c:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42c90:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42c94:	48 8b 50 28          	mov    0x28(%rax),%rdx
   42c98:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c9c:	48 01 d0             	add    %rdx,%rax
   42c9f:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   42ca3:	48 81 65 f0 00 f0 ff 	andq   $0xfffffffffffff000,-0x10(%rbp)
   42caa:	ff 

    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42cab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42caf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   42cb3:	eb 7c                	jmp    42d31 <program_load_segment+0xd8>
        if (assign_physical_page(addr, p->p_pid) < 0
   42cb5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42cb9:	8b 00                	mov    (%rax),%eax
   42cbb:	0f be d0             	movsbl %al,%edx
   42cbe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42cc2:	89 d6                	mov    %edx,%esi
   42cc4:	48 89 c7             	mov    %rax,%rdi
   42cc7:	e8 d0 d7 ff ff       	call   4049c <assign_physical_page>
   42ccc:	85 c0                	test   %eax,%eax
   42cce:	78 2a                	js     42cfa <program_load_segment+0xa1>
            || virtual_memory_map(p->p_pagetable, addr, addr, PAGESIZE,
   42cd0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42cd4:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   42cdb:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42cdf:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   42ce3:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42ce9:	b9 00 10 00 00       	mov    $0x1000,%ecx
   42cee:	48 89 c7             	mov    %rax,%rdi
   42cf1:	e8 5d f9 ff ff       	call   42653 <virtual_memory_map>
   42cf6:	85 c0                	test   %eax,%eax
   42cf8:	79 2f                	jns    42d29 <program_load_segment+0xd0>
                                  PTE_P | PTE_W | PTE_U) < 0) {
            console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   42cfa:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42cfe:	8b 00                	mov    (%rax),%eax
   42d00:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42d04:	49 89 d0             	mov    %rdx,%r8
   42d07:	89 c1                	mov    %eax,%ecx
   42d09:	ba c0 48 04 00       	mov    $0x448c0,%edx
   42d0e:	be 00 c0 00 00       	mov    $0xc000,%esi
   42d13:	bf e0 06 00 00       	mov    $0x6e0,%edi
   42d18:	b8 00 00 00 00       	mov    $0x0,%eax
   42d1d:	e8 35 0f 00 00       	call   43c57 <console_printf>
            return -1;
   42d22:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42d27:	eb 77                	jmp    42da0 <program_load_segment+0x147>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42d29:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42d30:	00 
   42d31:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42d35:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   42d39:	0f 82 76 ff ff ff    	jb     42cb5 <program_load_segment+0x5c>
        }
    }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   42d3f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42d43:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   42d4a:	48 89 c7             	mov    %rax,%rdi
   42d4d:	e8 d0 f7 ff ff       	call   42522 <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   42d52:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d56:	48 2b 45 f0          	sub    -0x10(%rbp),%rax
   42d5a:	48 89 c2             	mov    %rax,%rdx
   42d5d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d61:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42d65:	48 89 ce             	mov    %rcx,%rsi
   42d68:	48 89 c7             	mov    %rax,%rdi
   42d6b:	e8 32 00 00 00       	call   42da2 <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   42d70:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42d74:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   42d78:	48 89 c2             	mov    %rax,%rdx
   42d7b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d7f:	be 00 00 00 00       	mov    $0x0,%esi
   42d84:	48 89 c7             	mov    %rax,%rdi
   42d87:	e8 14 01 00 00       	call   42ea0 <memset>

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   42d8c:	48 8b 05 6d 12 01 00 	mov    0x1126d(%rip),%rax        # 54000 <kernel_pagetable>
   42d93:	48 89 c7             	mov    %rax,%rdi
   42d96:	e8 87 f7 ff ff       	call   42522 <set_pagetable>
    return 0;
   42d9b:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42da0:	c9                   	leave  
   42da1:	c3                   	ret    

0000000000042da2 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   42da2:	55                   	push   %rbp
   42da3:	48 89 e5             	mov    %rsp,%rbp
   42da6:	48 83 ec 28          	sub    $0x28,%rsp
   42daa:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42dae:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   42db2:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   42db6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42dba:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   42dbe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42dc2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   42dc6:	eb 1c                	jmp    42de4 <memcpy+0x42>
        *d = *s;
   42dc8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42dcc:	0f b6 10             	movzbl (%rax),%edx
   42dcf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42dd3:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   42dd5:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   42dda:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   42ddf:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   42de4:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   42de9:	75 dd                	jne    42dc8 <memcpy+0x26>
    }
    return dst;
   42deb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   42def:	c9                   	leave  
   42df0:	c3                   	ret    

0000000000042df1 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   42df1:	55                   	push   %rbp
   42df2:	48 89 e5             	mov    %rsp,%rbp
   42df5:	48 83 ec 28          	sub    $0x28,%rsp
   42df9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42dfd:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   42e01:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   42e05:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42e09:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   42e0d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42e11:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   42e15:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42e19:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   42e1d:	73 6a                	jae    42e89 <memmove+0x98>
   42e1f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42e23:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e27:	48 01 d0             	add    %rdx,%rax
   42e2a:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   42e2e:	73 59                	jae    42e89 <memmove+0x98>
        s += n, d += n;
   42e30:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e34:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   42e38:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e3c:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   42e40:	eb 17                	jmp    42e59 <memmove+0x68>
            *--d = *--s;
   42e42:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   42e47:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   42e4c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42e50:	0f b6 10             	movzbl (%rax),%edx
   42e53:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e57:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   42e59:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e5d:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   42e61:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   42e65:	48 85 c0             	test   %rax,%rax
   42e68:	75 d8                	jne    42e42 <memmove+0x51>
    if (s < d && s + n > d) {
   42e6a:	eb 2e                	jmp    42e9a <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   42e6c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42e70:	48 8d 42 01          	lea    0x1(%rdx),%rax
   42e74:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   42e78:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e7c:	48 8d 48 01          	lea    0x1(%rax),%rcx
   42e80:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   42e84:	0f b6 12             	movzbl (%rdx),%edx
   42e87:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   42e89:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e8d:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   42e91:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   42e95:	48 85 c0             	test   %rax,%rax
   42e98:	75 d2                	jne    42e6c <memmove+0x7b>
        }
    }
    return dst;
   42e9a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   42e9e:	c9                   	leave  
   42e9f:	c3                   	ret    

0000000000042ea0 <memset>:

void* memset(void* v, int c, size_t n) {
   42ea0:	55                   	push   %rbp
   42ea1:	48 89 e5             	mov    %rsp,%rbp
   42ea4:	48 83 ec 28          	sub    $0x28,%rsp
   42ea8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42eac:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   42eaf:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   42eb3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42eb7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   42ebb:	eb 15                	jmp    42ed2 <memset+0x32>
        *p = c;
   42ebd:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   42ec0:	89 c2                	mov    %eax,%edx
   42ec2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42ec6:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   42ec8:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   42ecd:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   42ed2:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   42ed7:	75 e4                	jne    42ebd <memset+0x1d>
    }
    return v;
   42ed9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   42edd:	c9                   	leave  
   42ede:	c3                   	ret    

0000000000042edf <strlen>:

size_t strlen(const char* s) {
   42edf:	55                   	push   %rbp
   42ee0:	48 89 e5             	mov    %rsp,%rbp
   42ee3:	48 83 ec 18          	sub    $0x18,%rsp
   42ee7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   42eeb:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42ef2:	00 
   42ef3:	eb 0a                	jmp    42eff <strlen+0x20>
        ++n;
   42ef5:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   42efa:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   42eff:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f03:	0f b6 00             	movzbl (%rax),%eax
   42f06:	84 c0                	test   %al,%al
   42f08:	75 eb                	jne    42ef5 <strlen+0x16>
    }
    return n;
   42f0a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   42f0e:	c9                   	leave  
   42f0f:	c3                   	ret    

0000000000042f10 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   42f10:	55                   	push   %rbp
   42f11:	48 89 e5             	mov    %rsp,%rbp
   42f14:	48 83 ec 20          	sub    $0x20,%rsp
   42f18:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42f1c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   42f20:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42f27:	00 
   42f28:	eb 0a                	jmp    42f34 <strnlen+0x24>
        ++n;
   42f2a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   42f2f:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   42f34:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42f38:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   42f3c:	74 0b                	je     42f49 <strnlen+0x39>
   42f3e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f42:	0f b6 00             	movzbl (%rax),%eax
   42f45:	84 c0                	test   %al,%al
   42f47:	75 e1                	jne    42f2a <strnlen+0x1a>
    }
    return n;
   42f49:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   42f4d:	c9                   	leave  
   42f4e:	c3                   	ret    

0000000000042f4f <strcpy>:

char* strcpy(char* dst, const char* src) {
   42f4f:	55                   	push   %rbp
   42f50:	48 89 e5             	mov    %rsp,%rbp
   42f53:	48 83 ec 20          	sub    $0x20,%rsp
   42f57:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42f5b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   42f5f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f63:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   42f67:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42f6b:	48 8d 42 01          	lea    0x1(%rdx),%rax
   42f6f:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   42f73:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42f77:	48 8d 48 01          	lea    0x1(%rax),%rcx
   42f7b:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   42f7f:	0f b6 12             	movzbl (%rdx),%edx
   42f82:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   42f84:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42f88:	48 83 e8 01          	sub    $0x1,%rax
   42f8c:	0f b6 00             	movzbl (%rax),%eax
   42f8f:	84 c0                	test   %al,%al
   42f91:	75 d4                	jne    42f67 <strcpy+0x18>
    return dst;
   42f93:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   42f97:	c9                   	leave  
   42f98:	c3                   	ret    

0000000000042f99 <strcmp>:

int strcmp(const char* a, const char* b) {
   42f99:	55                   	push   %rbp
   42f9a:	48 89 e5             	mov    %rsp,%rbp
   42f9d:	48 83 ec 10          	sub    $0x10,%rsp
   42fa1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42fa5:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   42fa9:	eb 0a                	jmp    42fb5 <strcmp+0x1c>
        ++a, ++b;
   42fab:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   42fb0:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   42fb5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42fb9:	0f b6 00             	movzbl (%rax),%eax
   42fbc:	84 c0                	test   %al,%al
   42fbe:	74 1d                	je     42fdd <strcmp+0x44>
   42fc0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42fc4:	0f b6 00             	movzbl (%rax),%eax
   42fc7:	84 c0                	test   %al,%al
   42fc9:	74 12                	je     42fdd <strcmp+0x44>
   42fcb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42fcf:	0f b6 10             	movzbl (%rax),%edx
   42fd2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42fd6:	0f b6 00             	movzbl (%rax),%eax
   42fd9:	38 c2                	cmp    %al,%dl
   42fdb:	74 ce                	je     42fab <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   42fdd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42fe1:	0f b6 00             	movzbl (%rax),%eax
   42fe4:	89 c2                	mov    %eax,%edx
   42fe6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42fea:	0f b6 00             	movzbl (%rax),%eax
   42fed:	38 d0                	cmp    %dl,%al
   42fef:	0f 92 c0             	setb   %al
   42ff2:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   42ff5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42ff9:	0f b6 00             	movzbl (%rax),%eax
   42ffc:	89 c1                	mov    %eax,%ecx
   42ffe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43002:	0f b6 00             	movzbl (%rax),%eax
   43005:	38 c1                	cmp    %al,%cl
   43007:	0f 92 c0             	setb   %al
   4300a:	0f b6 c0             	movzbl %al,%eax
   4300d:	29 c2                	sub    %eax,%edx
   4300f:	89 d0                	mov    %edx,%eax
}
   43011:	c9                   	leave  
   43012:	c3                   	ret    

0000000000043013 <strchr>:

char* strchr(const char* s, int c) {
   43013:	55                   	push   %rbp
   43014:	48 89 e5             	mov    %rsp,%rbp
   43017:	48 83 ec 10          	sub    $0x10,%rsp
   4301b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4301f:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   43022:	eb 05                	jmp    43029 <strchr+0x16>
        ++s;
   43024:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   43029:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4302d:	0f b6 00             	movzbl (%rax),%eax
   43030:	84 c0                	test   %al,%al
   43032:	74 0e                	je     43042 <strchr+0x2f>
   43034:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43038:	0f b6 00             	movzbl (%rax),%eax
   4303b:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4303e:	38 d0                	cmp    %dl,%al
   43040:	75 e2                	jne    43024 <strchr+0x11>
    }
    if (*s == (char) c) {
   43042:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43046:	0f b6 00             	movzbl (%rax),%eax
   43049:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4304c:	38 d0                	cmp    %dl,%al
   4304e:	75 06                	jne    43056 <strchr+0x43>
        return (char*) s;
   43050:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43054:	eb 05                	jmp    4305b <strchr+0x48>
    } else {
        return NULL;
   43056:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   4305b:	c9                   	leave  
   4305c:	c3                   	ret    

000000000004305d <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   4305d:	55                   	push   %rbp
   4305e:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   43061:	8b 05 99 6f 01 00    	mov    0x16f99(%rip),%eax        # 5a000 <rand_seed_set>
   43067:	85 c0                	test   %eax,%eax
   43069:	75 0a                	jne    43075 <rand+0x18>
        srand(819234718U);
   4306b:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   43070:	e8 24 00 00 00       	call   43099 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   43075:	8b 05 89 6f 01 00    	mov    0x16f89(%rip),%eax        # 5a004 <rand_seed>
   4307b:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   43081:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   43086:	89 05 78 6f 01 00    	mov    %eax,0x16f78(%rip)        # 5a004 <rand_seed>
    return rand_seed & RAND_MAX;
   4308c:	8b 05 72 6f 01 00    	mov    0x16f72(%rip),%eax        # 5a004 <rand_seed>
   43092:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   43097:	5d                   	pop    %rbp
   43098:	c3                   	ret    

0000000000043099 <srand>:

void srand(unsigned seed) {
   43099:	55                   	push   %rbp
   4309a:	48 89 e5             	mov    %rsp,%rbp
   4309d:	48 83 ec 08          	sub    $0x8,%rsp
   430a1:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   430a4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   430a7:	89 05 57 6f 01 00    	mov    %eax,0x16f57(%rip)        # 5a004 <rand_seed>
    rand_seed_set = 1;
   430ad:	c7 05 49 6f 01 00 01 	movl   $0x1,0x16f49(%rip)        # 5a000 <rand_seed_set>
   430b4:	00 00 00 
}
   430b7:	90                   	nop
   430b8:	c9                   	leave  
   430b9:	c3                   	ret    

00000000000430ba <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   430ba:	55                   	push   %rbp
   430bb:	48 89 e5             	mov    %rsp,%rbp
   430be:	48 83 ec 28          	sub    $0x28,%rsp
   430c2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   430c6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   430ca:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   430cd:	48 c7 45 f8 e0 4a 04 	movq   $0x44ae0,-0x8(%rbp)
   430d4:	00 
    if (base < 0) {
   430d5:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   430d9:	79 0b                	jns    430e6 <fill_numbuf+0x2c>
        digits = lower_digits;
   430db:	48 c7 45 f8 00 4b 04 	movq   $0x44b00,-0x8(%rbp)
   430e2:	00 
        base = -base;
   430e3:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   430e6:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   430eb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   430ef:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   430f2:	8b 45 dc             	mov    -0x24(%rbp),%eax
   430f5:	48 63 c8             	movslq %eax,%rcx
   430f8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   430fc:	ba 00 00 00 00       	mov    $0x0,%edx
   43101:	48 f7 f1             	div    %rcx
   43104:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43108:	48 01 d0             	add    %rdx,%rax
   4310b:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43110:	0f b6 10             	movzbl (%rax),%edx
   43113:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43117:	88 10                	mov    %dl,(%rax)
        val /= base;
   43119:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4311c:	48 63 f0             	movslq %eax,%rsi
   4311f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43123:	ba 00 00 00 00       	mov    $0x0,%edx
   43128:	48 f7 f6             	div    %rsi
   4312b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   4312f:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43134:	75 bc                	jne    430f2 <fill_numbuf+0x38>
    return numbuf_end;
   43136:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   4313a:	c9                   	leave  
   4313b:	c3                   	ret    

000000000004313c <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   4313c:	55                   	push   %rbp
   4313d:	48 89 e5             	mov    %rsp,%rbp
   43140:	53                   	push   %rbx
   43141:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   43148:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   4314f:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   43155:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   4315c:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   43163:	e9 8a 09 00 00       	jmp    43af2 <printer_vprintf+0x9b6>
        if (*format != '%') {
   43168:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4316f:	0f b6 00             	movzbl (%rax),%eax
   43172:	3c 25                	cmp    $0x25,%al
   43174:	74 31                	je     431a7 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
   43176:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4317d:	4c 8b 00             	mov    (%rax),%r8
   43180:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43187:	0f b6 00             	movzbl (%rax),%eax
   4318a:	0f b6 c8             	movzbl %al,%ecx
   4318d:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43193:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4319a:	89 ce                	mov    %ecx,%esi
   4319c:	48 89 c7             	mov    %rax,%rdi
   4319f:	41 ff d0             	call   *%r8
            continue;
   431a2:	e9 43 09 00 00       	jmp    43aea <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
   431a7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   431ae:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   431b5:	01 
   431b6:	eb 44                	jmp    431fc <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
   431b8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   431bf:	0f b6 00             	movzbl (%rax),%eax
   431c2:	0f be c0             	movsbl %al,%eax
   431c5:	89 c6                	mov    %eax,%esi
   431c7:	bf 00 49 04 00       	mov    $0x44900,%edi
   431cc:	e8 42 fe ff ff       	call   43013 <strchr>
   431d1:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   431d5:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   431da:	74 30                	je     4320c <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
   431dc:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   431e0:	48 2d 00 49 04 00    	sub    $0x44900,%rax
   431e6:	ba 01 00 00 00       	mov    $0x1,%edx
   431eb:	89 c1                	mov    %eax,%ecx
   431ed:	d3 e2                	shl    %cl,%edx
   431ef:	89 d0                	mov    %edx,%eax
   431f1:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   431f4:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   431fb:	01 
   431fc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43203:	0f b6 00             	movzbl (%rax),%eax
   43206:	84 c0                	test   %al,%al
   43208:	75 ae                	jne    431b8 <printer_vprintf+0x7c>
   4320a:	eb 01                	jmp    4320d <printer_vprintf+0xd1>
            } else {
                break;
   4320c:	90                   	nop
            }
        }

        // process width
        int width = -1;
   4320d:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   43214:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4321b:	0f b6 00             	movzbl (%rax),%eax
   4321e:	3c 30                	cmp    $0x30,%al
   43220:	7e 67                	jle    43289 <printer_vprintf+0x14d>
   43222:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43229:	0f b6 00             	movzbl (%rax),%eax
   4322c:	3c 39                	cmp    $0x39,%al
   4322e:	7f 59                	jg     43289 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43230:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   43237:	eb 2e                	jmp    43267 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
   43239:	8b 55 e8             	mov    -0x18(%rbp),%edx
   4323c:	89 d0                	mov    %edx,%eax
   4323e:	c1 e0 02             	shl    $0x2,%eax
   43241:	01 d0                	add    %edx,%eax
   43243:	01 c0                	add    %eax,%eax
   43245:	89 c1                	mov    %eax,%ecx
   43247:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4324e:	48 8d 50 01          	lea    0x1(%rax),%rdx
   43252:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43259:	0f b6 00             	movzbl (%rax),%eax
   4325c:	0f be c0             	movsbl %al,%eax
   4325f:	01 c8                	add    %ecx,%eax
   43261:	83 e8 30             	sub    $0x30,%eax
   43264:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43267:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4326e:	0f b6 00             	movzbl (%rax),%eax
   43271:	3c 2f                	cmp    $0x2f,%al
   43273:	0f 8e 85 00 00 00    	jle    432fe <printer_vprintf+0x1c2>
   43279:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43280:	0f b6 00             	movzbl (%rax),%eax
   43283:	3c 39                	cmp    $0x39,%al
   43285:	7e b2                	jle    43239 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
   43287:	eb 75                	jmp    432fe <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
   43289:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43290:	0f b6 00             	movzbl (%rax),%eax
   43293:	3c 2a                	cmp    $0x2a,%al
   43295:	75 68                	jne    432ff <printer_vprintf+0x1c3>
            width = va_arg(val, int);
   43297:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4329e:	8b 00                	mov    (%rax),%eax
   432a0:	83 f8 2f             	cmp    $0x2f,%eax
   432a3:	77 30                	ja     432d5 <printer_vprintf+0x199>
   432a5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   432ac:	48 8b 50 10          	mov    0x10(%rax),%rdx
   432b0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   432b7:	8b 00                	mov    (%rax),%eax
   432b9:	89 c0                	mov    %eax,%eax
   432bb:	48 01 d0             	add    %rdx,%rax
   432be:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   432c5:	8b 12                	mov    (%rdx),%edx
   432c7:	8d 4a 08             	lea    0x8(%rdx),%ecx
   432ca:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   432d1:	89 0a                	mov    %ecx,(%rdx)
   432d3:	eb 1a                	jmp    432ef <printer_vprintf+0x1b3>
   432d5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   432dc:	48 8b 40 08          	mov    0x8(%rax),%rax
   432e0:	48 8d 48 08          	lea    0x8(%rax),%rcx
   432e4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   432eb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   432ef:	8b 00                	mov    (%rax),%eax
   432f1:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   432f4:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   432fb:	01 
   432fc:	eb 01                	jmp    432ff <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
   432fe:	90                   	nop
        }

        // process precision
        int precision = -1;
   432ff:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   43306:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4330d:	0f b6 00             	movzbl (%rax),%eax
   43310:	3c 2e                	cmp    $0x2e,%al
   43312:	0f 85 00 01 00 00    	jne    43418 <printer_vprintf+0x2dc>
            ++format;
   43318:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4331f:	01 
            if (*format >= '0' && *format <= '9') {
   43320:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43327:	0f b6 00             	movzbl (%rax),%eax
   4332a:	3c 2f                	cmp    $0x2f,%al
   4332c:	7e 67                	jle    43395 <printer_vprintf+0x259>
   4332e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43335:	0f b6 00             	movzbl (%rax),%eax
   43338:	3c 39                	cmp    $0x39,%al
   4333a:	7f 59                	jg     43395 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   4333c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   43343:	eb 2e                	jmp    43373 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
   43345:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   43348:	89 d0                	mov    %edx,%eax
   4334a:	c1 e0 02             	shl    $0x2,%eax
   4334d:	01 d0                	add    %edx,%eax
   4334f:	01 c0                	add    %eax,%eax
   43351:	89 c1                	mov    %eax,%ecx
   43353:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4335a:	48 8d 50 01          	lea    0x1(%rax),%rdx
   4335e:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43365:	0f b6 00             	movzbl (%rax),%eax
   43368:	0f be c0             	movsbl %al,%eax
   4336b:	01 c8                	add    %ecx,%eax
   4336d:	83 e8 30             	sub    $0x30,%eax
   43370:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43373:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4337a:	0f b6 00             	movzbl (%rax),%eax
   4337d:	3c 2f                	cmp    $0x2f,%al
   4337f:	0f 8e 85 00 00 00    	jle    4340a <printer_vprintf+0x2ce>
   43385:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4338c:	0f b6 00             	movzbl (%rax),%eax
   4338f:	3c 39                	cmp    $0x39,%al
   43391:	7e b2                	jle    43345 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
   43393:	eb 75                	jmp    4340a <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
   43395:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4339c:	0f b6 00             	movzbl (%rax),%eax
   4339f:	3c 2a                	cmp    $0x2a,%al
   433a1:	75 68                	jne    4340b <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
   433a3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   433aa:	8b 00                	mov    (%rax),%eax
   433ac:	83 f8 2f             	cmp    $0x2f,%eax
   433af:	77 30                	ja     433e1 <printer_vprintf+0x2a5>
   433b1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   433b8:	48 8b 50 10          	mov    0x10(%rax),%rdx
   433bc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   433c3:	8b 00                	mov    (%rax),%eax
   433c5:	89 c0                	mov    %eax,%eax
   433c7:	48 01 d0             	add    %rdx,%rax
   433ca:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   433d1:	8b 12                	mov    (%rdx),%edx
   433d3:	8d 4a 08             	lea    0x8(%rdx),%ecx
   433d6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   433dd:	89 0a                	mov    %ecx,(%rdx)
   433df:	eb 1a                	jmp    433fb <printer_vprintf+0x2bf>
   433e1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   433e8:	48 8b 40 08          	mov    0x8(%rax),%rax
   433ec:	48 8d 48 08          	lea    0x8(%rax),%rcx
   433f0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   433f7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   433fb:	8b 00                	mov    (%rax),%eax
   433fd:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   43400:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43407:	01 
   43408:	eb 01                	jmp    4340b <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
   4340a:	90                   	nop
            }
            if (precision < 0) {
   4340b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   4340f:	79 07                	jns    43418 <printer_vprintf+0x2dc>
                precision = 0;
   43411:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   43418:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   4341f:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   43426:	00 
        int length = 0;
   43427:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   4342e:	48 c7 45 c8 06 49 04 	movq   $0x44906,-0x38(%rbp)
   43435:	00 
    again:
        switch (*format) {
   43436:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4343d:	0f b6 00             	movzbl (%rax),%eax
   43440:	0f be c0             	movsbl %al,%eax
   43443:	83 e8 43             	sub    $0x43,%eax
   43446:	83 f8 37             	cmp    $0x37,%eax
   43449:	0f 87 9f 03 00 00    	ja     437ee <printer_vprintf+0x6b2>
   4344f:	89 c0                	mov    %eax,%eax
   43451:	48 8b 04 c5 18 49 04 	mov    0x44918(,%rax,8),%rax
   43458:	00 
   43459:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
   4345b:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   43462:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43469:	01 
            goto again;
   4346a:	eb ca                	jmp    43436 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   4346c:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43470:	74 5d                	je     434cf <printer_vprintf+0x393>
   43472:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43479:	8b 00                	mov    (%rax),%eax
   4347b:	83 f8 2f             	cmp    $0x2f,%eax
   4347e:	77 30                	ja     434b0 <printer_vprintf+0x374>
   43480:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43487:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4348b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43492:	8b 00                	mov    (%rax),%eax
   43494:	89 c0                	mov    %eax,%eax
   43496:	48 01 d0             	add    %rdx,%rax
   43499:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   434a0:	8b 12                	mov    (%rdx),%edx
   434a2:	8d 4a 08             	lea    0x8(%rdx),%ecx
   434a5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   434ac:	89 0a                	mov    %ecx,(%rdx)
   434ae:	eb 1a                	jmp    434ca <printer_vprintf+0x38e>
   434b0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   434b7:	48 8b 40 08          	mov    0x8(%rax),%rax
   434bb:	48 8d 48 08          	lea    0x8(%rax),%rcx
   434bf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   434c6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   434ca:	48 8b 00             	mov    (%rax),%rax
   434cd:	eb 5c                	jmp    4352b <printer_vprintf+0x3ef>
   434cf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   434d6:	8b 00                	mov    (%rax),%eax
   434d8:	83 f8 2f             	cmp    $0x2f,%eax
   434db:	77 30                	ja     4350d <printer_vprintf+0x3d1>
   434dd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   434e4:	48 8b 50 10          	mov    0x10(%rax),%rdx
   434e8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   434ef:	8b 00                	mov    (%rax),%eax
   434f1:	89 c0                	mov    %eax,%eax
   434f3:	48 01 d0             	add    %rdx,%rax
   434f6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   434fd:	8b 12                	mov    (%rdx),%edx
   434ff:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43502:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43509:	89 0a                	mov    %ecx,(%rdx)
   4350b:	eb 1a                	jmp    43527 <printer_vprintf+0x3eb>
   4350d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43514:	48 8b 40 08          	mov    0x8(%rax),%rax
   43518:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4351c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43523:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43527:	8b 00                	mov    (%rax),%eax
   43529:	48 98                	cltq   
   4352b:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   4352f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43533:	48 c1 f8 38          	sar    $0x38,%rax
   43537:	25 80 00 00 00       	and    $0x80,%eax
   4353c:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   4353f:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   43543:	74 09                	je     4354e <printer_vprintf+0x412>
   43545:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43549:	48 f7 d8             	neg    %rax
   4354c:	eb 04                	jmp    43552 <printer_vprintf+0x416>
   4354e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43552:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   43556:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   43559:	83 c8 60             	or     $0x60,%eax
   4355c:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   4355f:	e9 cf 02 00 00       	jmp    43833 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   43564:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43568:	74 5d                	je     435c7 <printer_vprintf+0x48b>
   4356a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43571:	8b 00                	mov    (%rax),%eax
   43573:	83 f8 2f             	cmp    $0x2f,%eax
   43576:	77 30                	ja     435a8 <printer_vprintf+0x46c>
   43578:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4357f:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43583:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4358a:	8b 00                	mov    (%rax),%eax
   4358c:	89 c0                	mov    %eax,%eax
   4358e:	48 01 d0             	add    %rdx,%rax
   43591:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43598:	8b 12                	mov    (%rdx),%edx
   4359a:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4359d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   435a4:	89 0a                	mov    %ecx,(%rdx)
   435a6:	eb 1a                	jmp    435c2 <printer_vprintf+0x486>
   435a8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   435af:	48 8b 40 08          	mov    0x8(%rax),%rax
   435b3:	48 8d 48 08          	lea    0x8(%rax),%rcx
   435b7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   435be:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   435c2:	48 8b 00             	mov    (%rax),%rax
   435c5:	eb 5c                	jmp    43623 <printer_vprintf+0x4e7>
   435c7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   435ce:	8b 00                	mov    (%rax),%eax
   435d0:	83 f8 2f             	cmp    $0x2f,%eax
   435d3:	77 30                	ja     43605 <printer_vprintf+0x4c9>
   435d5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   435dc:	48 8b 50 10          	mov    0x10(%rax),%rdx
   435e0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   435e7:	8b 00                	mov    (%rax),%eax
   435e9:	89 c0                	mov    %eax,%eax
   435eb:	48 01 d0             	add    %rdx,%rax
   435ee:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   435f5:	8b 12                	mov    (%rdx),%edx
   435f7:	8d 4a 08             	lea    0x8(%rdx),%ecx
   435fa:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43601:	89 0a                	mov    %ecx,(%rdx)
   43603:	eb 1a                	jmp    4361f <printer_vprintf+0x4e3>
   43605:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4360c:	48 8b 40 08          	mov    0x8(%rax),%rax
   43610:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43614:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4361b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4361f:	8b 00                	mov    (%rax),%eax
   43621:	89 c0                	mov    %eax,%eax
   43623:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   43627:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   4362b:	e9 03 02 00 00       	jmp    43833 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
   43630:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   43637:	e9 28 ff ff ff       	jmp    43564 <printer_vprintf+0x428>
        case 'X':
            base = 16;
   4363c:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   43643:	e9 1c ff ff ff       	jmp    43564 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   43648:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4364f:	8b 00                	mov    (%rax),%eax
   43651:	83 f8 2f             	cmp    $0x2f,%eax
   43654:	77 30                	ja     43686 <printer_vprintf+0x54a>
   43656:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4365d:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43661:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43668:	8b 00                	mov    (%rax),%eax
   4366a:	89 c0                	mov    %eax,%eax
   4366c:	48 01 d0             	add    %rdx,%rax
   4366f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43676:	8b 12                	mov    (%rdx),%edx
   43678:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4367b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43682:	89 0a                	mov    %ecx,(%rdx)
   43684:	eb 1a                	jmp    436a0 <printer_vprintf+0x564>
   43686:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4368d:	48 8b 40 08          	mov    0x8(%rax),%rax
   43691:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43695:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4369c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   436a0:	48 8b 00             	mov    (%rax),%rax
   436a3:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   436a7:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   436ae:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   436b5:	e9 79 01 00 00       	jmp    43833 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
   436ba:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   436c1:	8b 00                	mov    (%rax),%eax
   436c3:	83 f8 2f             	cmp    $0x2f,%eax
   436c6:	77 30                	ja     436f8 <printer_vprintf+0x5bc>
   436c8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   436cf:	48 8b 50 10          	mov    0x10(%rax),%rdx
   436d3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   436da:	8b 00                	mov    (%rax),%eax
   436dc:	89 c0                	mov    %eax,%eax
   436de:	48 01 d0             	add    %rdx,%rax
   436e1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   436e8:	8b 12                	mov    (%rdx),%edx
   436ea:	8d 4a 08             	lea    0x8(%rdx),%ecx
   436ed:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   436f4:	89 0a                	mov    %ecx,(%rdx)
   436f6:	eb 1a                	jmp    43712 <printer_vprintf+0x5d6>
   436f8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   436ff:	48 8b 40 08          	mov    0x8(%rax),%rax
   43703:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43707:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4370e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43712:	48 8b 00             	mov    (%rax),%rax
   43715:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   43719:	e9 15 01 00 00       	jmp    43833 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
   4371e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43725:	8b 00                	mov    (%rax),%eax
   43727:	83 f8 2f             	cmp    $0x2f,%eax
   4372a:	77 30                	ja     4375c <printer_vprintf+0x620>
   4372c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43733:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43737:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4373e:	8b 00                	mov    (%rax),%eax
   43740:	89 c0                	mov    %eax,%eax
   43742:	48 01 d0             	add    %rdx,%rax
   43745:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4374c:	8b 12                	mov    (%rdx),%edx
   4374e:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43751:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43758:	89 0a                	mov    %ecx,(%rdx)
   4375a:	eb 1a                	jmp    43776 <printer_vprintf+0x63a>
   4375c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43763:	48 8b 40 08          	mov    0x8(%rax),%rax
   43767:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4376b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43772:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43776:	8b 00                	mov    (%rax),%eax
   43778:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   4377e:	e9 67 03 00 00       	jmp    43aea <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
   43783:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43787:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   4378b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43792:	8b 00                	mov    (%rax),%eax
   43794:	83 f8 2f             	cmp    $0x2f,%eax
   43797:	77 30                	ja     437c9 <printer_vprintf+0x68d>
   43799:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   437a0:	48 8b 50 10          	mov    0x10(%rax),%rdx
   437a4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   437ab:	8b 00                	mov    (%rax),%eax
   437ad:	89 c0                	mov    %eax,%eax
   437af:	48 01 d0             	add    %rdx,%rax
   437b2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   437b9:	8b 12                	mov    (%rdx),%edx
   437bb:	8d 4a 08             	lea    0x8(%rdx),%ecx
   437be:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   437c5:	89 0a                	mov    %ecx,(%rdx)
   437c7:	eb 1a                	jmp    437e3 <printer_vprintf+0x6a7>
   437c9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   437d0:	48 8b 40 08          	mov    0x8(%rax),%rax
   437d4:	48 8d 48 08          	lea    0x8(%rax),%rcx
   437d8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   437df:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   437e3:	8b 00                	mov    (%rax),%eax
   437e5:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   437e8:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   437ec:	eb 45                	jmp    43833 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
   437ee:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   437f2:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   437f6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   437fd:	0f b6 00             	movzbl (%rax),%eax
   43800:	84 c0                	test   %al,%al
   43802:	74 0c                	je     43810 <printer_vprintf+0x6d4>
   43804:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4380b:	0f b6 00             	movzbl (%rax),%eax
   4380e:	eb 05                	jmp    43815 <printer_vprintf+0x6d9>
   43810:	b8 25 00 00 00       	mov    $0x25,%eax
   43815:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   43818:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   4381c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43823:	0f b6 00             	movzbl (%rax),%eax
   43826:	84 c0                	test   %al,%al
   43828:	75 08                	jne    43832 <printer_vprintf+0x6f6>
                format--;
   4382a:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   43831:	01 
            }
            break;
   43832:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   43833:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43836:	83 e0 20             	and    $0x20,%eax
   43839:	85 c0                	test   %eax,%eax
   4383b:	74 1e                	je     4385b <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   4383d:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43841:	48 83 c0 18          	add    $0x18,%rax
   43845:	8b 55 e0             	mov    -0x20(%rbp),%edx
   43848:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   4384c:	48 89 ce             	mov    %rcx,%rsi
   4384f:	48 89 c7             	mov    %rax,%rdi
   43852:	e8 63 f8 ff ff       	call   430ba <fill_numbuf>
   43857:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   4385b:	48 c7 45 c0 06 49 04 	movq   $0x44906,-0x40(%rbp)
   43862:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   43863:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43866:	83 e0 20             	and    $0x20,%eax
   43869:	85 c0                	test   %eax,%eax
   4386b:	74 48                	je     438b5 <printer_vprintf+0x779>
   4386d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43870:	83 e0 40             	and    $0x40,%eax
   43873:	85 c0                	test   %eax,%eax
   43875:	74 3e                	je     438b5 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
   43877:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4387a:	25 80 00 00 00       	and    $0x80,%eax
   4387f:	85 c0                	test   %eax,%eax
   43881:	74 0a                	je     4388d <printer_vprintf+0x751>
                prefix = "-";
   43883:	48 c7 45 c0 07 49 04 	movq   $0x44907,-0x40(%rbp)
   4388a:	00 
            if (flags & FLAG_NEGATIVE) {
   4388b:	eb 73                	jmp    43900 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   4388d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43890:	83 e0 10             	and    $0x10,%eax
   43893:	85 c0                	test   %eax,%eax
   43895:	74 0a                	je     438a1 <printer_vprintf+0x765>
                prefix = "+";
   43897:	48 c7 45 c0 09 49 04 	movq   $0x44909,-0x40(%rbp)
   4389e:	00 
            if (flags & FLAG_NEGATIVE) {
   4389f:	eb 5f                	jmp    43900 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   438a1:	8b 45 ec             	mov    -0x14(%rbp),%eax
   438a4:	83 e0 08             	and    $0x8,%eax
   438a7:	85 c0                	test   %eax,%eax
   438a9:	74 55                	je     43900 <printer_vprintf+0x7c4>
                prefix = " ";
   438ab:	48 c7 45 c0 0b 49 04 	movq   $0x4490b,-0x40(%rbp)
   438b2:	00 
            if (flags & FLAG_NEGATIVE) {
   438b3:	eb 4b                	jmp    43900 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   438b5:	8b 45 ec             	mov    -0x14(%rbp),%eax
   438b8:	83 e0 20             	and    $0x20,%eax
   438bb:	85 c0                	test   %eax,%eax
   438bd:	74 42                	je     43901 <printer_vprintf+0x7c5>
   438bf:	8b 45 ec             	mov    -0x14(%rbp),%eax
   438c2:	83 e0 01             	and    $0x1,%eax
   438c5:	85 c0                	test   %eax,%eax
   438c7:	74 38                	je     43901 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
   438c9:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   438cd:	74 06                	je     438d5 <printer_vprintf+0x799>
   438cf:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   438d3:	75 2c                	jne    43901 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
   438d5:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   438da:	75 0c                	jne    438e8 <printer_vprintf+0x7ac>
   438dc:	8b 45 ec             	mov    -0x14(%rbp),%eax
   438df:	25 00 01 00 00       	and    $0x100,%eax
   438e4:	85 c0                	test   %eax,%eax
   438e6:	74 19                	je     43901 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
   438e8:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   438ec:	75 07                	jne    438f5 <printer_vprintf+0x7b9>
   438ee:	b8 0d 49 04 00       	mov    $0x4490d,%eax
   438f3:	eb 05                	jmp    438fa <printer_vprintf+0x7be>
   438f5:	b8 10 49 04 00       	mov    $0x44910,%eax
   438fa:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   438fe:	eb 01                	jmp    43901 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
   43900:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   43901:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   43905:	78 24                	js     4392b <printer_vprintf+0x7ef>
   43907:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4390a:	83 e0 20             	and    $0x20,%eax
   4390d:	85 c0                	test   %eax,%eax
   4390f:	75 1a                	jne    4392b <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
   43911:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43914:	48 63 d0             	movslq %eax,%rdx
   43917:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4391b:	48 89 d6             	mov    %rdx,%rsi
   4391e:	48 89 c7             	mov    %rax,%rdi
   43921:	e8 ea f5 ff ff       	call   42f10 <strnlen>
   43926:	89 45 bc             	mov    %eax,-0x44(%rbp)
   43929:	eb 0f                	jmp    4393a <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
   4392b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4392f:	48 89 c7             	mov    %rax,%rdi
   43932:	e8 a8 f5 ff ff       	call   42edf <strlen>
   43937:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   4393a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4393d:	83 e0 20             	and    $0x20,%eax
   43940:	85 c0                	test   %eax,%eax
   43942:	74 20                	je     43964 <printer_vprintf+0x828>
   43944:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   43948:	78 1a                	js     43964 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
   4394a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4394d:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   43950:	7e 08                	jle    4395a <printer_vprintf+0x81e>
   43952:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43955:	2b 45 bc             	sub    -0x44(%rbp),%eax
   43958:	eb 05                	jmp    4395f <printer_vprintf+0x823>
   4395a:	b8 00 00 00 00       	mov    $0x0,%eax
   4395f:	89 45 b8             	mov    %eax,-0x48(%rbp)
   43962:	eb 5c                	jmp    439c0 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   43964:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43967:	83 e0 20             	and    $0x20,%eax
   4396a:	85 c0                	test   %eax,%eax
   4396c:	74 4b                	je     439b9 <printer_vprintf+0x87d>
   4396e:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43971:	83 e0 02             	and    $0x2,%eax
   43974:	85 c0                	test   %eax,%eax
   43976:	74 41                	je     439b9 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
   43978:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4397b:	83 e0 04             	and    $0x4,%eax
   4397e:	85 c0                	test   %eax,%eax
   43980:	75 37                	jne    439b9 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
   43982:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43986:	48 89 c7             	mov    %rax,%rdi
   43989:	e8 51 f5 ff ff       	call   42edf <strlen>
   4398e:	89 c2                	mov    %eax,%edx
   43990:	8b 45 bc             	mov    -0x44(%rbp),%eax
   43993:	01 d0                	add    %edx,%eax
   43995:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   43998:	7e 1f                	jle    439b9 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
   4399a:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4399d:	2b 45 bc             	sub    -0x44(%rbp),%eax
   439a0:	89 c3                	mov    %eax,%ebx
   439a2:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   439a6:	48 89 c7             	mov    %rax,%rdi
   439a9:	e8 31 f5 ff ff       	call   42edf <strlen>
   439ae:	89 c2                	mov    %eax,%edx
   439b0:	89 d8                	mov    %ebx,%eax
   439b2:	29 d0                	sub    %edx,%eax
   439b4:	89 45 b8             	mov    %eax,-0x48(%rbp)
   439b7:	eb 07                	jmp    439c0 <printer_vprintf+0x884>
        } else {
            zeros = 0;
   439b9:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   439c0:	8b 55 bc             	mov    -0x44(%rbp),%edx
   439c3:	8b 45 b8             	mov    -0x48(%rbp),%eax
   439c6:	01 d0                	add    %edx,%eax
   439c8:	48 63 d8             	movslq %eax,%rbx
   439cb:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   439cf:	48 89 c7             	mov    %rax,%rdi
   439d2:	e8 08 f5 ff ff       	call   42edf <strlen>
   439d7:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   439db:	8b 45 e8             	mov    -0x18(%rbp),%eax
   439de:	29 d0                	sub    %edx,%eax
   439e0:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   439e3:	eb 25                	jmp    43a0a <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
   439e5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   439ec:	48 8b 08             	mov    (%rax),%rcx
   439ef:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   439f5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   439fc:	be 20 00 00 00       	mov    $0x20,%esi
   43a01:	48 89 c7             	mov    %rax,%rdi
   43a04:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   43a06:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   43a0a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43a0d:	83 e0 04             	and    $0x4,%eax
   43a10:	85 c0                	test   %eax,%eax
   43a12:	75 36                	jne    43a4a <printer_vprintf+0x90e>
   43a14:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   43a18:	7f cb                	jg     439e5 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
   43a1a:	eb 2e                	jmp    43a4a <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
   43a1c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43a23:	4c 8b 00             	mov    (%rax),%r8
   43a26:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43a2a:	0f b6 00             	movzbl (%rax),%eax
   43a2d:	0f b6 c8             	movzbl %al,%ecx
   43a30:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43a36:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43a3d:	89 ce                	mov    %ecx,%esi
   43a3f:	48 89 c7             	mov    %rax,%rdi
   43a42:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   43a45:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   43a4a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43a4e:	0f b6 00             	movzbl (%rax),%eax
   43a51:	84 c0                	test   %al,%al
   43a53:	75 c7                	jne    43a1c <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
   43a55:	eb 25                	jmp    43a7c <printer_vprintf+0x940>
            p->putc(p, '0', color);
   43a57:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43a5e:	48 8b 08             	mov    (%rax),%rcx
   43a61:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43a67:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43a6e:	be 30 00 00 00       	mov    $0x30,%esi
   43a73:	48 89 c7             	mov    %rax,%rdi
   43a76:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   43a78:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   43a7c:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   43a80:	7f d5                	jg     43a57 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
   43a82:	eb 32                	jmp    43ab6 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
   43a84:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43a8b:	4c 8b 00             	mov    (%rax),%r8
   43a8e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43a92:	0f b6 00             	movzbl (%rax),%eax
   43a95:	0f b6 c8             	movzbl %al,%ecx
   43a98:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43a9e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43aa5:	89 ce                	mov    %ecx,%esi
   43aa7:	48 89 c7             	mov    %rax,%rdi
   43aaa:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   43aad:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   43ab2:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   43ab6:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   43aba:	7f c8                	jg     43a84 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
   43abc:	eb 25                	jmp    43ae3 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
   43abe:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43ac5:	48 8b 08             	mov    (%rax),%rcx
   43ac8:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43ace:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43ad5:	be 20 00 00 00       	mov    $0x20,%esi
   43ada:	48 89 c7             	mov    %rax,%rdi
   43add:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   43adf:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   43ae3:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   43ae7:	7f d5                	jg     43abe <printer_vprintf+0x982>
        }
    done: ;
   43ae9:	90                   	nop
    for (; *format; ++format) {
   43aea:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43af1:	01 
   43af2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43af9:	0f b6 00             	movzbl (%rax),%eax
   43afc:	84 c0                	test   %al,%al
   43afe:	0f 85 64 f6 ff ff    	jne    43168 <printer_vprintf+0x2c>
    }
}
   43b04:	90                   	nop
   43b05:	90                   	nop
   43b06:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   43b0a:	c9                   	leave  
   43b0b:	c3                   	ret    

0000000000043b0c <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   43b0c:	55                   	push   %rbp
   43b0d:	48 89 e5             	mov    %rsp,%rbp
   43b10:	48 83 ec 20          	sub    $0x20,%rsp
   43b14:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43b18:	89 f0                	mov    %esi,%eax
   43b1a:	89 55 e0             	mov    %edx,-0x20(%rbp)
   43b1d:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   43b20:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43b24:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   43b28:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43b2c:	48 8b 40 08          	mov    0x8(%rax),%rax
   43b30:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
   43b35:	48 39 d0             	cmp    %rdx,%rax
   43b38:	72 0c                	jb     43b46 <console_putc+0x3a>
        cp->cursor = console;
   43b3a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43b3e:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
   43b45:	00 
    }
    if (c == '\n') {
   43b46:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   43b4a:	75 78                	jne    43bc4 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
   43b4c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43b50:	48 8b 40 08          	mov    0x8(%rax),%rax
   43b54:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   43b5a:	48 d1 f8             	sar    %rax
   43b5d:	48 89 c1             	mov    %rax,%rcx
   43b60:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   43b67:	66 66 66 
   43b6a:	48 89 c8             	mov    %rcx,%rax
   43b6d:	48 f7 ea             	imul   %rdx
   43b70:	48 c1 fa 05          	sar    $0x5,%rdx
   43b74:	48 89 c8             	mov    %rcx,%rax
   43b77:	48 c1 f8 3f          	sar    $0x3f,%rax
   43b7b:	48 29 c2             	sub    %rax,%rdx
   43b7e:	48 89 d0             	mov    %rdx,%rax
   43b81:	48 c1 e0 02          	shl    $0x2,%rax
   43b85:	48 01 d0             	add    %rdx,%rax
   43b88:	48 c1 e0 04          	shl    $0x4,%rax
   43b8c:	48 29 c1             	sub    %rax,%rcx
   43b8f:	48 89 ca             	mov    %rcx,%rdx
   43b92:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   43b95:	eb 25                	jmp    43bbc <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
   43b97:	8b 45 e0             	mov    -0x20(%rbp),%eax
   43b9a:	83 c8 20             	or     $0x20,%eax
   43b9d:	89 c6                	mov    %eax,%esi
   43b9f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43ba3:	48 8b 40 08          	mov    0x8(%rax),%rax
   43ba7:	48 8d 48 02          	lea    0x2(%rax),%rcx
   43bab:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   43baf:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43bb3:	89 f2                	mov    %esi,%edx
   43bb5:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   43bb8:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   43bbc:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   43bc0:	75 d5                	jne    43b97 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   43bc2:	eb 24                	jmp    43be8 <console_putc+0xdc>
        *cp->cursor++ = c | color;
   43bc4:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
   43bc8:	8b 55 e0             	mov    -0x20(%rbp),%edx
   43bcb:	09 d0                	or     %edx,%eax
   43bcd:	89 c6                	mov    %eax,%esi
   43bcf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43bd3:	48 8b 40 08          	mov    0x8(%rax),%rax
   43bd7:	48 8d 48 02          	lea    0x2(%rax),%rcx
   43bdb:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   43bdf:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43be3:	89 f2                	mov    %esi,%edx
   43be5:	66 89 10             	mov    %dx,(%rax)
}
   43be8:	90                   	nop
   43be9:	c9                   	leave  
   43bea:	c3                   	ret    

0000000000043beb <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   43beb:	55                   	push   %rbp
   43bec:	48 89 e5             	mov    %rsp,%rbp
   43bef:	48 83 ec 30          	sub    $0x30,%rsp
   43bf3:	89 7d ec             	mov    %edi,-0x14(%rbp)
   43bf6:	89 75 e8             	mov    %esi,-0x18(%rbp)
   43bf9:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   43bfd:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   43c01:	48 c7 45 f0 0c 3b 04 	movq   $0x43b0c,-0x10(%rbp)
   43c08:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   43c09:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   43c0d:	78 09                	js     43c18 <console_vprintf+0x2d>
   43c0f:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   43c16:	7e 07                	jle    43c1f <console_vprintf+0x34>
        cpos = 0;
   43c18:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   43c1f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43c22:	48 98                	cltq   
   43c24:	48 01 c0             	add    %rax,%rax
   43c27:	48 05 00 80 0b 00    	add    $0xb8000,%rax
   43c2d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   43c31:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   43c35:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43c39:	8b 75 e8             	mov    -0x18(%rbp),%esi
   43c3c:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   43c40:	48 89 c7             	mov    %rax,%rdi
   43c43:	e8 f4 f4 ff ff       	call   4313c <printer_vprintf>
    return cp.cursor - console;
   43c48:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c4c:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   43c52:	48 d1 f8             	sar    %rax
}
   43c55:	c9                   	leave  
   43c56:	c3                   	ret    

0000000000043c57 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   43c57:	55                   	push   %rbp
   43c58:	48 89 e5             	mov    %rsp,%rbp
   43c5b:	48 83 ec 60          	sub    $0x60,%rsp
   43c5f:	89 7d ac             	mov    %edi,-0x54(%rbp)
   43c62:	89 75 a8             	mov    %esi,-0x58(%rbp)
   43c65:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   43c69:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   43c6d:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   43c71:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   43c75:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   43c7c:	48 8d 45 10          	lea    0x10(%rbp),%rax
   43c80:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   43c84:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   43c88:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   43c8c:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   43c90:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   43c94:	8b 75 a8             	mov    -0x58(%rbp),%esi
   43c97:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43c9a:	89 c7                	mov    %eax,%edi
   43c9c:	e8 4a ff ff ff       	call   43beb <console_vprintf>
   43ca1:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   43ca4:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   43ca7:	c9                   	leave  
   43ca8:	c3                   	ret    

0000000000043ca9 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   43ca9:	55                   	push   %rbp
   43caa:	48 89 e5             	mov    %rsp,%rbp
   43cad:	48 83 ec 20          	sub    $0x20,%rsp
   43cb1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43cb5:	89 f0                	mov    %esi,%eax
   43cb7:	89 55 e0             	mov    %edx,-0x20(%rbp)
   43cba:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   43cbd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43cc1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   43cc5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43cc9:	48 8b 50 08          	mov    0x8(%rax),%rdx
   43ccd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43cd1:	48 8b 40 10          	mov    0x10(%rax),%rax
   43cd5:	48 39 c2             	cmp    %rax,%rdx
   43cd8:	73 1a                	jae    43cf4 <string_putc+0x4b>
        *sp->s++ = c;
   43cda:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43cde:	48 8b 40 08          	mov    0x8(%rax),%rax
   43ce2:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43ce6:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43cea:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43cee:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   43cf2:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   43cf4:	90                   	nop
   43cf5:	c9                   	leave  
   43cf6:	c3                   	ret    

0000000000043cf7 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   43cf7:	55                   	push   %rbp
   43cf8:	48 89 e5             	mov    %rsp,%rbp
   43cfb:	48 83 ec 40          	sub    $0x40,%rsp
   43cff:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   43d03:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   43d07:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   43d0b:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   43d0f:	48 c7 45 e8 a9 3c 04 	movq   $0x43ca9,-0x18(%rbp)
   43d16:	00 
    sp.s = s;
   43d17:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43d1b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   43d1f:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   43d24:	74 33                	je     43d59 <vsnprintf+0x62>
        sp.end = s + size - 1;
   43d26:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43d2a:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43d2e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43d32:	48 01 d0             	add    %rdx,%rax
   43d35:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   43d39:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   43d3d:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   43d41:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   43d45:	be 00 00 00 00       	mov    $0x0,%esi
   43d4a:	48 89 c7             	mov    %rax,%rdi
   43d4d:	e8 ea f3 ff ff       	call   4313c <printer_vprintf>
        *sp.s = 0;
   43d52:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43d56:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   43d59:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43d5d:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   43d61:	c9                   	leave  
   43d62:	c3                   	ret    

0000000000043d63 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   43d63:	55                   	push   %rbp
   43d64:	48 89 e5             	mov    %rsp,%rbp
   43d67:	48 83 ec 70          	sub    $0x70,%rsp
   43d6b:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   43d6f:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   43d73:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   43d77:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   43d7b:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   43d7f:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   43d83:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   43d8a:	48 8d 45 10          	lea    0x10(%rbp),%rax
   43d8e:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   43d92:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   43d96:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   43d9a:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   43d9e:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   43da2:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   43da6:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43daa:	48 89 c7             	mov    %rax,%rdi
   43dad:	e8 45 ff ff ff       	call   43cf7 <vsnprintf>
   43db2:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   43db5:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   43db8:	c9                   	leave  
   43db9:	c3                   	ret    

0000000000043dba <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   43dba:	55                   	push   %rbp
   43dbb:	48 89 e5             	mov    %rsp,%rbp
   43dbe:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   43dc2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   43dc9:	eb 13                	jmp    43dde <console_clear+0x24>
        console[i] = ' ' | 0x0700;
   43dcb:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43dce:	48 98                	cltq   
   43dd0:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
   43dd7:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   43dda:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   43dde:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   43de5:	7e e4                	jle    43dcb <console_clear+0x11>
    }
    cursorpos = 0;
   43de7:	c7 05 0b 52 07 00 00 	movl   $0x0,0x7520b(%rip)        # b8ffc <cursorpos>
   43dee:	00 00 00 
}
   43df1:	90                   	nop
   43df2:	c9                   	leave  
   43df3:	c3                   	ret    
