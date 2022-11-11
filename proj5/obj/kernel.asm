
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
   40173:	e8 00 14 00 00       	call   41578 <hardware_init>
    pageinfo_init();
   40178:	e8 5f 0a 00 00       	call   40bdc <pageinfo_init>
    console_clear();
   4017d:	e8 b2 3d 00 00       	call   43f34 <console_clear>
    timer_init(HZ);
   40182:	bf 64 00 00 00       	mov    $0x64,%edi
   40187:	e8 d8 18 00 00       	call   41a64 <timer_init>

    // use virtual_memory_map to remove user permissions for kernel memory
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   4018c:	48 8b 05 6d 3e 01 00 	mov    0x13e6d(%rip),%rax        # 54000 <kernel_pagetable>
   40193:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   40199:	b9 00 00 10 00       	mov    $0x100000,%ecx
   4019e:	ba 00 00 00 00       	mov    $0x0,%edx
   401a3:	be 00 00 00 00       	mov    $0x0,%esi
   401a8:	48 89 c7             	mov    %rax,%rdi
   401ab:	e8 12 26 00 00       	call   427c2 <virtual_memory_map>
					   PROC_START_ADDR, PTE_P | PTE_W);
   
    // return user permissions to console
    virtual_memory_map(kernel_pagetable, (uintptr_t) CONSOLE_ADDR, (uintptr_t) CONSOLE_ADDR,
   401b0:	ba 00 80 0b 00       	mov    $0xb8000,%edx
   401b5:	be 00 80 0b 00       	mov    $0xb8000,%esi
   401ba:	48 8b 05 3f 3e 01 00 	mov    0x13e3f(%rip),%rax        # 54000 <kernel_pagetable>
   401c1:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   401c7:	b9 00 10 00 00       	mov    $0x1000,%ecx
   401cc:	48 89 c7             	mov    %rax,%rdi
   401cf:	e8 ee 25 00 00       	call   427c2 <virtual_memory_map>
	// to all memory before the start of ANY processes. This means that 
	// the assign_page function is never capable of assigning this memory
	// to a process.

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   401d4:	ba 00 0e 00 00       	mov    $0xe00,%edx
   401d9:	be 00 00 00 00       	mov    $0x0,%esi
   401de:	bf 20 10 05 00       	mov    $0x51020,%edi
   401e3:	e8 32 2e 00 00       	call   4301a <memset>
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
   4024e:	e8 c0 2e 00 00       	call   43113 <strcmp>
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
   4027e:	e8 90 2e 00 00       	call   43113 <strcmp>
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
   402ae:	e8 60 2e 00 00       	call   43113 <strcmp>
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
   402db:	e8 33 2e 00 00       	call   43113 <strcmp>
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
   40332:	e8 48 08 00 00       	call   40b7f <run>

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
   40420:	e8 f5 2b 00 00       	call   4301a <memset>
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
   404af:	e8 68 2a 00 00       	call   42f1c <memcpy>
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
   404e7:	e8 09 18 00 00       	call   41cf5 <process_init>
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
   4051e:	e8 5c 27 00 00       	call   42c7f <program_load>
   40523:	89 45 fc             	mov    %eax,-0x4(%rbp)
    assert(r >= 0);
   40526:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4052a:	79 14                	jns    40540 <process_setup+0x89>
   4052c:	ba 99 3f 04 00       	mov    $0x43f99,%edx
   40531:	be c2 00 00 00       	mov    $0xc2,%esi
   40536:	bf a0 3f 04 00       	mov    $0x43fa0,%edi
   4053b:	e8 83 1f 00 00       	call   424c3 <assert_fail>

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
   405d7:	e8 e6 21 00 00       	call   427c2 <virtual_memory_map>
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
   406b0:	e8 d3 24 00 00       	call   42b88 <virtual_memory_lookup>

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
   406e8:	e8 9b 24 00 00       	call   42b88 <virtual_memory_lookup>
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
   40714:	e8 6f 24 00 00       	call   42b88 <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   40719:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4071d:	48 89 c1             	mov    %rax,%rcx
   40720:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40724:	ba 18 00 00 00       	mov    $0x18,%edx
   40729:	48 89 c6             	mov    %rax,%rsi
   4072c:	48 89 cf             	mov    %rcx,%rdi
   4072f:	e8 e8 27 00 00       	call   42f1c <memcpy>
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
   407a9:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
   407b0:	48 89 bd f8 fe ff ff 	mov    %rdi,-0x108(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   407b7:	48 8b 05 42 08 01 00 	mov    0x10842(%rip),%rax        # 51000 <current>
   407be:	48 8b 95 f8 fe ff ff 	mov    -0x108(%rbp),%rdx
   407c5:	48 83 c0 08          	add    $0x8,%rax
   407c9:	48 89 d6             	mov    %rdx,%rsi
   407cc:	ba 18 00 00 00       	mov    $0x18,%edx
   407d1:	48 89 c7             	mov    %rax,%rdi
   407d4:	48 89 d1             	mov    %rdx,%rcx
   407d7:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   407da:	48 8b 05 1f 38 01 00 	mov    0x1381f(%rip),%rax        # 54000 <kernel_pagetable>
   407e1:	48 89 c7             	mov    %rax,%rdi
   407e4:	e8 a8 1e 00 00       	call   42691 <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   407e9:	8b 05 0d 88 07 00    	mov    0x7880d(%rip),%eax        # b8ffc <cursorpos>
   407ef:	89 c7                	mov    %eax,%edi
   407f1:	e8 c9 15 00 00       	call   41dbf <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT && reg->reg_intno != INT_GPF) // no error due to pagefault or general fault
   407f6:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   407fd:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40804:	48 83 f8 0e          	cmp    $0xe,%rax
   40808:	74 14                	je     4081e <exception+0x79>
   4080a:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40811:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40818:	48 83 f8 0d          	cmp    $0xd,%rax
   4081c:	75 16                	jne    40834 <exception+0x8f>
            || (reg->reg_err & PFERR_USER)) // pagefault error in user mode 
   4081e:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40825:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   4082c:	83 e0 04             	and    $0x4,%eax
   4082f:	48 85 c0             	test   %rax,%rax
   40832:	74 1a                	je     4084e <exception+0xa9>
    {
        check_virtual_memory();
   40834:	e8 3a 07 00 00       	call   40f73 <check_virtual_memory>
        if(disp_global){
   40839:	0f b6 05 c0 47 00 00 	movzbl 0x47c0(%rip),%eax        # 45000 <disp_global>
   40840:	84 c0                	test   %al,%al
   40842:	74 0a                	je     4084e <exception+0xa9>
            memshow_physical();
   40844:	e8 a2 08 00 00       	call   410eb <memshow_physical>
            memshow_virtual_animate();
   40849:	e8 cc 0b 00 00       	call   4141a <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   4084e:	e8 4f 1a 00 00       	call   422a2 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   40853:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   4085a:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40861:	48 83 e8 0e          	sub    $0xe,%rax
   40865:	48 83 f8 2a          	cmp    $0x2a,%rax
   40869:	0f 87 61 02 00 00    	ja     40ad0 <exception+0x32b>
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
   40899:	e8 45 1b 00 00       	call   423e3 <panic>
		vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   4089e:	48 8b 05 5b 07 01 00 	mov    0x1075b(%rip),%rax        # 51000 <current>
   408a5:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   408ac:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   408b0:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   408b4:	48 89 ce             	mov    %rcx,%rsi
   408b7:	48 89 c7             	mov    %rax,%rdi
   408ba:	e8 c9 22 00 00       	call   42b88 <virtual_memory_lookup>
		memcpy(msg, (void *)map.pa, 160);
   408bf:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   408c3:	48 89 c1             	mov    %rax,%rcx
   408c6:	48 8d 85 08 ff ff ff 	lea    -0xf8(%rbp),%rax
   408cd:	ba a0 00 00 00       	mov    $0xa0,%edx
   408d2:	48 89 ce             	mov    %rcx,%rsi
   408d5:	48 89 c7             	mov    %rax,%rdi
   408d8:	e8 3f 26 00 00       	call   42f1c <memcpy>
		panic(msg);
   408dd:	48 8d 85 08 ff ff ff 	lea    -0xf8(%rbp),%rax
   408e4:	48 89 c7             	mov    %rax,%rdi
   408e7:	b8 00 00 00 00       	mov    $0x0,%eax
   408ec:	e8 f2 1a 00 00       	call   423e3 <panic>
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
   40908:	e9 d3 01 00 00       	jmp    40ae0 <exception+0x33b>

    case INT_SYS_YIELD:
        schedule();
   4090d:	e8 f7 01 00 00       	call   40b09 <schedule>
        break;                  /* will not be reached */
   40912:	e9 c9 01 00 00       	jmp    40ae0 <exception+0x33b>

    case INT_SYS_PAGE_ALLOC: {
        uintptr_t va = current->p_registers.reg_rdi;
   40917:	48 8b 05 e2 06 01 00 	mov    0x106e2(%rip),%rax        # 51000 <current>
   4091e:	48 8b 40 38          	mov    0x38(%rax),%rax
   40922:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
		uintptr_t pa;
		next_free_page(&pa);
   40926:	48 8d 45 a8          	lea    -0x58(%rbp),%rax
   4092a:	48 89 c7             	mov    %rax,%rdi
   4092d:	e8 05 fa ff ff       	call   40337 <next_free_page>
        int r = assign_physical_page(pa, current->p_pid); 
   40932:	48 8b 05 c7 06 01 00 	mov    0x106c7(%rip),%rax        # 51000 <current>
   40939:	8b 00                	mov    (%rax),%eax
   4093b:	0f be d0             	movsbl %al,%edx
   4093e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   40942:	89 d6                	mov    %edx,%esi
   40944:	48 89 c7             	mov    %rax,%rdi
   40947:	e8 b3 fc ff ff       	call   405ff <assign_physical_page>
   4094c:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (r >= 0) {
   4094f:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40953:	78 29                	js     4097e <exception+0x1d9>
            virtual_memory_map(current->p_pagetable, va, pa,
   40955:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   40959:	48 8b 05 a0 06 01 00 	mov    0x106a0(%rip),%rax        # 51000 <current>
   40960:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40967:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   4096b:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40971:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40976:	48 89 c7             	mov    %rax,%rdi
   40979:	e8 44 1e 00 00       	call   427c2 <virtual_memory_map>
                               PAGESIZE, PTE_P | PTE_W | PTE_U);
        }
        current->p_registers.reg_rax = r;
   4097e:	48 8b 05 7b 06 01 00 	mov    0x1067b(%rip),%rax        # 51000 <current>
   40985:	8b 55 f4             	mov    -0xc(%rbp),%edx
   40988:	48 63 d2             	movslq %edx,%rdx
   4098b:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   4098f:	e9 4c 01 00 00       	jmp    40ae0 <exception+0x33b>
    }

    case INT_SYS_MAPPING:
    {
	    syscall_mapping(current);
   40994:	48 8b 05 65 06 01 00 	mov    0x10665(%rip),%rax        # 51000 <current>
   4099b:	48 89 c7             	mov    %rax,%rdi
   4099e:	e8 d0 fc ff ff       	call   40673 <syscall_mapping>
            break;
   409a3:	e9 38 01 00 00       	jmp    40ae0 <exception+0x33b>
    }

    case INT_SYS_MEM_TOG:
	{
	    syscall_mem_tog(current);
   409a8:	48 8b 05 51 06 01 00 	mov    0x10651(%rip),%rax        # 51000 <current>
   409af:	48 89 c7             	mov    %rax,%rdi
   409b2:	e8 85 fd ff ff       	call   4073c <syscall_mem_tog>
	    break;
   409b7:	e9 24 01 00 00       	jmp    40ae0 <exception+0x33b>
	}

    case INT_TIMER:
        ++ticks;
   409bc:	8b 05 5e 14 01 00    	mov    0x1145e(%rip),%eax        # 51e20 <ticks>
   409c2:	83 c0 01             	add    $0x1,%eax
   409c5:	89 05 55 14 01 00    	mov    %eax,0x11455(%rip)        # 51e20 <ticks>
        schedule();
   409cb:	e8 39 01 00 00       	call   40b09 <schedule>
        break;                  /* will not be reached */
   409d0:	e9 0b 01 00 00       	jmp    40ae0 <exception+0x33b>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   409d5:	0f 20 d0             	mov    %cr2,%rax
   409d8:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    return val;
   409dc:	48 8b 45 c8          	mov    -0x38(%rbp),%rax

    case INT_PAGEFAULT: {
        // Analyze faulting address and access type.
        uintptr_t addr = rcr2();
   409e0:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
        const char* operation = reg->reg_err & PFERR_WRITE
   409e4:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   409eb:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   409f2:	83 e0 02             	and    $0x2,%eax
                ? "write" : "read";
   409f5:	48 85 c0             	test   %rax,%rax
   409f8:	74 07                	je     40a01 <exception+0x25c>
   409fa:	b8 b0 3f 04 00       	mov    $0x43fb0,%eax
   409ff:	eb 05                	jmp    40a06 <exception+0x261>
   40a01:	b8 b6 3f 04 00       	mov    $0x43fb6,%eax
        const char* operation = reg->reg_err & PFERR_WRITE
   40a06:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        const char* problem = reg->reg_err & PFERR_PRESENT
   40a0a:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40a11:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40a18:	83 e0 01             	and    $0x1,%eax
                ? "protection problem" : "missing page";
   40a1b:	48 85 c0             	test   %rax,%rax
   40a1e:	74 07                	je     40a27 <exception+0x282>
   40a20:	b8 bb 3f 04 00       	mov    $0x43fbb,%eax
   40a25:	eb 05                	jmp    40a2c <exception+0x287>
   40a27:	b8 ce 3f 04 00       	mov    $0x43fce,%eax
        const char* problem = reg->reg_err & PFERR_PRESENT
   40a2c:	48 89 45 d0          	mov    %rax,-0x30(%rbp)

        if (!(reg->reg_err & PFERR_USER)) {
   40a30:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40a37:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40a3e:	83 e0 04             	and    $0x4,%eax
   40a41:	48 85 c0             	test   %rax,%rax
   40a44:	75 2f                	jne    40a75 <exception+0x2d0>
            panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   40a46:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40a4d:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   40a54:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
   40a58:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   40a5c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40a60:	49 89 f0             	mov    %rsi,%r8
   40a63:	48 89 c6             	mov    %rax,%rsi
   40a66:	bf e0 3f 04 00       	mov    $0x43fe0,%edi
   40a6b:	b8 00 00 00 00       	mov    $0x0,%eax
   40a70:	e8 6e 19 00 00       	call   423e3 <panic>
                  addr, operation, problem, reg->reg_rip);
        }
        console_printf(CPOS(24, 0), 0x0C00,
   40a75:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40a7c:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                       "Process %d page fault for %p (%s %s, rip=%p)!\n",
                       current->p_pid, addr, operation, problem, reg->reg_rip);
   40a83:	48 8b 05 76 05 01 00 	mov    0x10576(%rip),%rax        # 51000 <current>
        console_printf(CPOS(24, 0), 0x0C00,
   40a8a:	8b 00                	mov    (%rax),%eax
   40a8c:	48 8b 75 d8          	mov    -0x28(%rbp),%rsi
   40a90:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   40a94:	52                   	push   %rdx
   40a95:	ff 75 d0             	push   -0x30(%rbp)
   40a98:	49 89 f1             	mov    %rsi,%r9
   40a9b:	49 89 c8             	mov    %rcx,%r8
   40a9e:	89 c1                	mov    %eax,%ecx
   40aa0:	ba 10 40 04 00       	mov    $0x44010,%edx
   40aa5:	be 00 0c 00 00       	mov    $0xc00,%esi
   40aaa:	bf 80 07 00 00       	mov    $0x780,%edi
   40aaf:	b8 00 00 00 00       	mov    $0x0,%eax
   40ab4:	e8 18 33 00 00       	call   43dd1 <console_printf>
   40ab9:	48 83 c4 10          	add    $0x10,%rsp
        current->p_state = P_BROKEN;
   40abd:	48 8b 05 3c 05 01 00 	mov    0x1053c(%rip),%rax        # 51000 <current>
   40ac4:	c7 80 c8 00 00 00 03 	movl   $0x3,0xc8(%rax)
   40acb:	00 00 00 
        break;
   40ace:	eb 10                	jmp    40ae0 <exception+0x33b>
    }

    default:
        default_exception(current);
   40ad0:	48 8b 05 29 05 01 00 	mov    0x10529(%rip),%rax        # 51000 <current>
   40ad7:	48 89 c7             	mov    %rax,%rdi
   40ada:	e8 14 1a 00 00       	call   424f3 <default_exception>
        break;                  /* will not be reached */
   40adf:	90                   	nop

    }


    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   40ae0:	48 8b 05 19 05 01 00 	mov    0x10519(%rip),%rax        # 51000 <current>
   40ae7:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   40aed:	83 f8 01             	cmp    $0x1,%eax
   40af0:	75 0f                	jne    40b01 <exception+0x35c>
        run(current);
   40af2:	48 8b 05 07 05 01 00 	mov    0x10507(%rip),%rax        # 51000 <current>
   40af9:	48 89 c7             	mov    %rax,%rdi
   40afc:	e8 7e 00 00 00       	call   40b7f <run>
    } else {
        schedule();
   40b01:	e8 03 00 00 00       	call   40b09 <schedule>
    }
}
   40b06:	90                   	nop
   40b07:	c9                   	leave  
   40b08:	c3                   	ret    

0000000000040b09 <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   40b09:	55                   	push   %rbp
   40b0a:	48 89 e5             	mov    %rsp,%rbp
   40b0d:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   40b11:	48 8b 05 e8 04 01 00 	mov    0x104e8(%rip),%rax        # 51000 <current>
   40b18:	8b 00                	mov    (%rax),%eax
   40b1a:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   40b1d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40b20:	8d 50 01             	lea    0x1(%rax),%edx
   40b23:	89 d0                	mov    %edx,%eax
   40b25:	c1 f8 1f             	sar    $0x1f,%eax
   40b28:	c1 e8 1c             	shr    $0x1c,%eax
   40b2b:	01 c2                	add    %eax,%edx
   40b2d:	83 e2 0f             	and    $0xf,%edx
   40b30:	29 c2                	sub    %eax,%edx
   40b32:	89 55 fc             	mov    %edx,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   40b35:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40b38:	48 63 d0             	movslq %eax,%rdx
   40b3b:	48 89 d0             	mov    %rdx,%rax
   40b3e:	48 c1 e0 03          	shl    $0x3,%rax
   40b42:	48 29 d0             	sub    %rdx,%rax
   40b45:	48 c1 e0 05          	shl    $0x5,%rax
   40b49:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   40b4f:	8b 00                	mov    (%rax),%eax
   40b51:	83 f8 01             	cmp    $0x1,%eax
   40b54:	75 22                	jne    40b78 <schedule+0x6f>
            run(&processes[pid]);
   40b56:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40b59:	48 63 d0             	movslq %eax,%rdx
   40b5c:	48 89 d0             	mov    %rdx,%rax
   40b5f:	48 c1 e0 03          	shl    $0x3,%rax
   40b63:	48 29 d0             	sub    %rdx,%rax
   40b66:	48 c1 e0 05          	shl    $0x5,%rax
   40b6a:	48 05 20 10 05 00    	add    $0x51020,%rax
   40b70:	48 89 c7             	mov    %rax,%rdi
   40b73:	e8 07 00 00 00       	call   40b7f <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   40b78:	e8 25 17 00 00       	call   422a2 <check_keyboard>
        pid = (pid + 1) % NPROC;
   40b7d:	eb 9e                	jmp    40b1d <schedule+0x14>

0000000000040b7f <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   40b7f:	55                   	push   %rbp
   40b80:	48 89 e5             	mov    %rsp,%rbp
   40b83:	48 83 ec 10          	sub    $0x10,%rsp
   40b87:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   40b8b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40b8f:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   40b95:	83 f8 01             	cmp    $0x1,%eax
   40b98:	74 14                	je     40bae <run+0x2f>
   40b9a:	ba 98 41 04 00       	mov    $0x44198,%edx
   40b9f:	be 99 01 00 00       	mov    $0x199,%esi
   40ba4:	bf a0 3f 04 00       	mov    $0x43fa0,%edi
   40ba9:	e8 15 19 00 00       	call   424c3 <assert_fail>
    current = p;
   40bae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40bb2:	48 89 05 47 04 01 00 	mov    %rax,0x10447(%rip)        # 51000 <current>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   40bb9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40bbd:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40bc4:	48 89 c7             	mov    %rax,%rdi
   40bc7:	e8 c5 1a 00 00       	call   42691 <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   40bcc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40bd0:	48 83 c0 08          	add    $0x8,%rax
   40bd4:	48 89 c7             	mov    %rax,%rdi
   40bd7:	e8 e7 f4 ff ff       	call   400c3 <exception_return>

0000000000040bdc <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   40bdc:	55                   	push   %rbp
   40bdd:	48 89 e5             	mov    %rsp,%rbp
   40be0:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40be4:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40beb:	00 
   40bec:	e9 81 00 00 00       	jmp    40c72 <pageinfo_init+0x96>
        int owner;
        if (physical_memory_isreserved(addr)) {
   40bf1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40bf5:	48 89 c7             	mov    %rax,%rdi
   40bf8:	e8 33 0f 00 00       	call   41b30 <physical_memory_isreserved>
   40bfd:	85 c0                	test   %eax,%eax
   40bff:	74 09                	je     40c0a <pageinfo_init+0x2e>
            owner = PO_RESERVED;
   40c01:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   40c08:	eb 2f                	jmp    40c39 <pageinfo_init+0x5d>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   40c0a:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   40c11:	00 
   40c12:	76 0b                	jbe    40c1f <pageinfo_init+0x43>
   40c14:	b8 08 a0 05 00       	mov    $0x5a008,%eax
   40c19:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40c1d:	72 0a                	jb     40c29 <pageinfo_init+0x4d>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   40c1f:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   40c26:	00 
   40c27:	75 09                	jne    40c32 <pageinfo_init+0x56>
            owner = PO_KERNEL;
   40c29:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   40c30:	eb 07                	jmp    40c39 <pageinfo_init+0x5d>
        } else {
            owner = PO_FREE;
   40c32:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40c39:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c3d:	48 c1 e8 0c          	shr    $0xc,%rax
   40c41:	89 c1                	mov    %eax,%ecx
   40c43:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40c46:	89 c2                	mov    %eax,%edx
   40c48:	48 63 c1             	movslq %ecx,%rax
   40c4b:	88 94 00 40 1e 05 00 	mov    %dl,0x51e40(%rax,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   40c52:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40c56:	0f 95 c2             	setne  %dl
   40c59:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c5d:	48 c1 e8 0c          	shr    $0xc,%rax
   40c61:	48 98                	cltq   
   40c63:	88 94 00 41 1e 05 00 	mov    %dl,0x51e41(%rax,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40c6a:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40c71:	00 
   40c72:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40c79:	00 
   40c7a:	0f 86 71 ff ff ff    	jbe    40bf1 <pageinfo_init+0x15>
    }
}
   40c80:	90                   	nop
   40c81:	90                   	nop
   40c82:	c9                   	leave  
   40c83:	c3                   	ret    

0000000000040c84 <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   40c84:	55                   	push   %rbp
   40c85:	48 89 e5             	mov    %rsp,%rbp
   40c88:	48 83 ec 50          	sub    $0x50,%rsp
   40c8c:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   40c90:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40c94:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40c9a:	48 89 c2             	mov    %rax,%rdx
   40c9d:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40ca1:	48 39 c2             	cmp    %rax,%rdx
   40ca4:	74 14                	je     40cba <check_page_table_mappings+0x36>
   40ca6:	ba b8 41 04 00       	mov    $0x441b8,%edx
   40cab:	be c3 01 00 00       	mov    $0x1c3,%esi
   40cb0:	bf a0 3f 04 00       	mov    $0x43fa0,%edi
   40cb5:	e8 09 18 00 00       	call   424c3 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40cba:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   40cc1:	00 
   40cc2:	e9 9a 00 00 00       	jmp    40d61 <check_page_table_mappings+0xdd>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   40cc7:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   40ccb:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40ccf:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40cd3:	48 89 ce             	mov    %rcx,%rsi
   40cd6:	48 89 c7             	mov    %rax,%rdi
   40cd9:	e8 aa 1e 00 00       	call   42b88 <virtual_memory_lookup>
        if (vam.pa != va) {
   40cde:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40ce2:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40ce6:	74 27                	je     40d0f <check_page_table_mappings+0x8b>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   40ce8:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40cec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40cf0:	49 89 d0             	mov    %rdx,%r8
   40cf3:	48 89 c1             	mov    %rax,%rcx
   40cf6:	ba d7 41 04 00       	mov    $0x441d7,%edx
   40cfb:	be 00 c0 00 00       	mov    $0xc000,%esi
   40d00:	bf e0 06 00 00       	mov    $0x6e0,%edi
   40d05:	b8 00 00 00 00       	mov    $0x0,%eax
   40d0a:	e8 c2 30 00 00       	call   43dd1 <console_printf>
        }
        assert(vam.pa == va);
   40d0f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40d13:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40d17:	74 14                	je     40d2d <check_page_table_mappings+0xa9>
   40d19:	ba e1 41 04 00       	mov    $0x441e1,%edx
   40d1e:	be cc 01 00 00       	mov    $0x1cc,%esi
   40d23:	bf a0 3f 04 00       	mov    $0x43fa0,%edi
   40d28:	e8 96 17 00 00       	call   424c3 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   40d2d:	b8 00 50 04 00       	mov    $0x45000,%eax
   40d32:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40d36:	72 21                	jb     40d59 <check_page_table_mappings+0xd5>
            assert(vam.perm & PTE_W);
   40d38:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40d3b:	48 98                	cltq   
   40d3d:	83 e0 02             	and    $0x2,%eax
   40d40:	48 85 c0             	test   %rax,%rax
   40d43:	75 14                	jne    40d59 <check_page_table_mappings+0xd5>
   40d45:	ba ee 41 04 00       	mov    $0x441ee,%edx
   40d4a:	be ce 01 00 00       	mov    $0x1ce,%esi
   40d4f:	bf a0 3f 04 00       	mov    $0x43fa0,%edi
   40d54:	e8 6a 17 00 00       	call   424c3 <assert_fail>
         va += PAGESIZE) {
   40d59:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40d60:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40d61:	b8 08 a0 05 00       	mov    $0x5a008,%eax
   40d66:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40d6a:	0f 82 57 ff ff ff    	jb     40cc7 <check_page_table_mappings+0x43>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   40d70:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   40d77:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   40d78:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   40d7c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40d80:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40d84:	48 89 ce             	mov    %rcx,%rsi
   40d87:	48 89 c7             	mov    %rax,%rdi
   40d8a:	e8 f9 1d 00 00       	call   42b88 <virtual_memory_lookup>
    assert(vam.pa == kstack);
   40d8f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40d93:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   40d97:	74 14                	je     40dad <check_page_table_mappings+0x129>
   40d99:	ba ff 41 04 00       	mov    $0x441ff,%edx
   40d9e:	be d5 01 00 00       	mov    $0x1d5,%esi
   40da3:	bf a0 3f 04 00       	mov    $0x43fa0,%edi
   40da8:	e8 16 17 00 00       	call   424c3 <assert_fail>
    assert(vam.perm & PTE_W);
   40dad:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40db0:	48 98                	cltq   
   40db2:	83 e0 02             	and    $0x2,%eax
   40db5:	48 85 c0             	test   %rax,%rax
   40db8:	75 14                	jne    40dce <check_page_table_mappings+0x14a>
   40dba:	ba ee 41 04 00       	mov    $0x441ee,%edx
   40dbf:	be d6 01 00 00       	mov    $0x1d6,%esi
   40dc4:	bf a0 3f 04 00       	mov    $0x43fa0,%edi
   40dc9:	e8 f5 16 00 00       	call   424c3 <assert_fail>
}
   40dce:	90                   	nop
   40dcf:	c9                   	leave  
   40dd0:	c3                   	ret    

0000000000040dd1 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   40dd1:	55                   	push   %rbp
   40dd2:	48 89 e5             	mov    %rsp,%rbp
   40dd5:	48 83 ec 20          	sub    $0x20,%rsp
   40dd9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40ddd:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   40de0:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40de3:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   40de6:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   40ded:	48 8b 05 0c 32 01 00 	mov    0x1320c(%rip),%rax        # 54000 <kernel_pagetable>
   40df4:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40df8:	75 67                	jne    40e61 <check_page_table_ownership+0x90>
        owner = PO_KERNEL;
   40dfa:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40e01:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   40e08:	eb 51                	jmp    40e5b <check_page_table_ownership+0x8a>
            if (processes[xpid].p_state != P_FREE
   40e0a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40e0d:	48 63 d0             	movslq %eax,%rdx
   40e10:	48 89 d0             	mov    %rdx,%rax
   40e13:	48 c1 e0 03          	shl    $0x3,%rax
   40e17:	48 29 d0             	sub    %rdx,%rax
   40e1a:	48 c1 e0 05          	shl    $0x5,%rax
   40e1e:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   40e24:	8b 00                	mov    (%rax),%eax
   40e26:	85 c0                	test   %eax,%eax
   40e28:	74 2d                	je     40e57 <check_page_table_ownership+0x86>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   40e2a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40e2d:	48 63 d0             	movslq %eax,%rdx
   40e30:	48 89 d0             	mov    %rdx,%rax
   40e33:	48 c1 e0 03          	shl    $0x3,%rax
   40e37:	48 29 d0             	sub    %rdx,%rax
   40e3a:	48 c1 e0 05          	shl    $0x5,%rax
   40e3e:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   40e44:	48 8b 10             	mov    (%rax),%rdx
   40e47:	48 8b 05 b2 31 01 00 	mov    0x131b2(%rip),%rax        # 54000 <kernel_pagetable>
   40e4e:	48 39 c2             	cmp    %rax,%rdx
   40e51:	75 04                	jne    40e57 <check_page_table_ownership+0x86>
                ++expected_refcount;
   40e53:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40e57:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   40e5b:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   40e5f:	7e a9                	jle    40e0a <check_page_table_ownership+0x39>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   40e61:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   40e64:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40e67:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40e6b:	be 00 00 00 00       	mov    $0x0,%esi
   40e70:	48 89 c7             	mov    %rax,%rdi
   40e73:	e8 03 00 00 00       	call   40e7b <check_page_table_ownership_level>
}
   40e78:	90                   	nop
   40e79:	c9                   	leave  
   40e7a:	c3                   	ret    

0000000000040e7b <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   40e7b:	55                   	push   %rbp
   40e7c:	48 89 e5             	mov    %rsp,%rbp
   40e7f:	48 83 ec 30          	sub    $0x30,%rsp
   40e83:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40e87:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   40e8a:	89 55 e0             	mov    %edx,-0x20(%rbp)
   40e8d:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   40e90:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40e94:	48 c1 e8 0c          	shr    $0xc,%rax
   40e98:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   40e9d:	7e 14                	jle    40eb3 <check_page_table_ownership_level+0x38>
   40e9f:	ba 10 42 04 00       	mov    $0x44210,%edx
   40ea4:	be f3 01 00 00       	mov    $0x1f3,%esi
   40ea9:	bf a0 3f 04 00       	mov    $0x43fa0,%edi
   40eae:	e8 10 16 00 00       	call   424c3 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   40eb3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40eb7:	48 c1 e8 0c          	shr    $0xc,%rax
   40ebb:	48 98                	cltq   
   40ebd:	0f b6 84 00 40 1e 05 	movzbl 0x51e40(%rax,%rax,1),%eax
   40ec4:	00 
   40ec5:	0f be c0             	movsbl %al,%eax
   40ec8:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   40ecb:	74 14                	je     40ee1 <check_page_table_ownership_level+0x66>
   40ecd:	ba 28 42 04 00       	mov    $0x44228,%edx
   40ed2:	be f4 01 00 00       	mov    $0x1f4,%esi
   40ed7:	bf a0 3f 04 00       	mov    $0x43fa0,%edi
   40edc:	e8 e2 15 00 00       	call   424c3 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   40ee1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40ee5:	48 c1 e8 0c          	shr    $0xc,%rax
   40ee9:	48 98                	cltq   
   40eeb:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   40ef2:	00 
   40ef3:	0f be c0             	movsbl %al,%eax
   40ef6:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   40ef9:	74 14                	je     40f0f <check_page_table_ownership_level+0x94>
   40efb:	ba 50 42 04 00       	mov    $0x44250,%edx
   40f00:	be f5 01 00 00       	mov    $0x1f5,%esi
   40f05:	bf a0 3f 04 00       	mov    $0x43fa0,%edi
   40f0a:	e8 b4 15 00 00       	call   424c3 <assert_fail>
    if (level < 3) {
   40f0f:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   40f13:	7f 5b                	jg     40f70 <check_page_table_ownership_level+0xf5>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   40f15:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   40f1c:	eb 49                	jmp    40f67 <check_page_table_ownership_level+0xec>
            if (pt->entry[index]) {
   40f1e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40f22:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40f25:	48 63 d2             	movslq %edx,%rdx
   40f28:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   40f2c:	48 85 c0             	test   %rax,%rax
   40f2f:	74 32                	je     40f63 <check_page_table_ownership_level+0xe8>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   40f31:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40f35:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40f38:	48 63 d2             	movslq %edx,%rdx
   40f3b:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   40f3f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   40f45:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   40f49:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40f4c:	8d 70 01             	lea    0x1(%rax),%esi
   40f4f:	8b 55 e0             	mov    -0x20(%rbp),%edx
   40f52:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40f56:	b9 01 00 00 00       	mov    $0x1,%ecx
   40f5b:	48 89 c7             	mov    %rax,%rdi
   40f5e:	e8 18 ff ff ff       	call   40e7b <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   40f63:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   40f67:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   40f6e:	7e ae                	jle    40f1e <check_page_table_ownership_level+0xa3>
            }
        }
    }
}
   40f70:	90                   	nop
   40f71:	c9                   	leave  
   40f72:	c3                   	ret    

0000000000040f73 <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   40f73:	55                   	push   %rbp
   40f74:	48 89 e5             	mov    %rsp,%rbp
   40f77:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   40f7b:	8b 05 67 01 01 00    	mov    0x10167(%rip),%eax        # 510e8 <processes+0xc8>
   40f81:	85 c0                	test   %eax,%eax
   40f83:	74 14                	je     40f99 <check_virtual_memory+0x26>
   40f85:	ba 80 42 04 00       	mov    $0x44280,%edx
   40f8a:	be 08 02 00 00       	mov    $0x208,%esi
   40f8f:	bf a0 3f 04 00       	mov    $0x43fa0,%edi
   40f94:	e8 2a 15 00 00       	call   424c3 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   40f99:	48 8b 05 60 30 01 00 	mov    0x13060(%rip),%rax        # 54000 <kernel_pagetable>
   40fa0:	48 89 c7             	mov    %rax,%rdi
   40fa3:	e8 dc fc ff ff       	call   40c84 <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   40fa8:	48 8b 05 51 30 01 00 	mov    0x13051(%rip),%rax        # 54000 <kernel_pagetable>
   40faf:	be ff ff ff ff       	mov    $0xffffffff,%esi
   40fb4:	48 89 c7             	mov    %rax,%rdi
   40fb7:	e8 15 fe ff ff       	call   40dd1 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   40fbc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   40fc3:	e9 9c 00 00 00       	jmp    41064 <check_virtual_memory+0xf1>
        if (processes[pid].p_state != P_FREE
   40fc8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40fcb:	48 63 d0             	movslq %eax,%rdx
   40fce:	48 89 d0             	mov    %rdx,%rax
   40fd1:	48 c1 e0 03          	shl    $0x3,%rax
   40fd5:	48 29 d0             	sub    %rdx,%rax
   40fd8:	48 c1 e0 05          	shl    $0x5,%rax
   40fdc:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   40fe2:	8b 00                	mov    (%rax),%eax
   40fe4:	85 c0                	test   %eax,%eax
   40fe6:	74 78                	je     41060 <check_virtual_memory+0xed>
            && processes[pid].p_pagetable != kernel_pagetable) {
   40fe8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40feb:	48 63 d0             	movslq %eax,%rdx
   40fee:	48 89 d0             	mov    %rdx,%rax
   40ff1:	48 c1 e0 03          	shl    $0x3,%rax
   40ff5:	48 29 d0             	sub    %rdx,%rax
   40ff8:	48 c1 e0 05          	shl    $0x5,%rax
   40ffc:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   41002:	48 8b 10             	mov    (%rax),%rdx
   41005:	48 8b 05 f4 2f 01 00 	mov    0x12ff4(%rip),%rax        # 54000 <kernel_pagetable>
   4100c:	48 39 c2             	cmp    %rax,%rdx
   4100f:	74 4f                	je     41060 <check_virtual_memory+0xed>
            check_page_table_mappings(processes[pid].p_pagetable);
   41011:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41014:	48 63 d0             	movslq %eax,%rdx
   41017:	48 89 d0             	mov    %rdx,%rax
   4101a:	48 c1 e0 03          	shl    $0x3,%rax
   4101e:	48 29 d0             	sub    %rdx,%rax
   41021:	48 c1 e0 05          	shl    $0x5,%rax
   41025:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   4102b:	48 8b 00             	mov    (%rax),%rax
   4102e:	48 89 c7             	mov    %rax,%rdi
   41031:	e8 4e fc ff ff       	call   40c84 <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   41036:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41039:	48 63 d0             	movslq %eax,%rdx
   4103c:	48 89 d0             	mov    %rdx,%rax
   4103f:	48 c1 e0 03          	shl    $0x3,%rax
   41043:	48 29 d0             	sub    %rdx,%rax
   41046:	48 c1 e0 05          	shl    $0x5,%rax
   4104a:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   41050:	48 8b 00             	mov    (%rax),%rax
   41053:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41056:	89 d6                	mov    %edx,%esi
   41058:	48 89 c7             	mov    %rax,%rdi
   4105b:	e8 71 fd ff ff       	call   40dd1 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   41060:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41064:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   41068:	0f 8e 5a ff ff ff    	jle    40fc8 <check_virtual_memory+0x55>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4106e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41075:	eb 67                	jmp    410de <check_virtual_memory+0x16b>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   41077:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4107a:	48 98                	cltq   
   4107c:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   41083:	00 
   41084:	84 c0                	test   %al,%al
   41086:	7e 52                	jle    410da <check_virtual_memory+0x167>
   41088:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4108b:	48 98                	cltq   
   4108d:	0f b6 84 00 40 1e 05 	movzbl 0x51e40(%rax,%rax,1),%eax
   41094:	00 
   41095:	84 c0                	test   %al,%al
   41097:	78 41                	js     410da <check_virtual_memory+0x167>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   41099:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4109c:	48 98                	cltq   
   4109e:	0f b6 84 00 40 1e 05 	movzbl 0x51e40(%rax,%rax,1),%eax
   410a5:	00 
   410a6:	0f be c0             	movsbl %al,%eax
   410a9:	48 63 d0             	movslq %eax,%rdx
   410ac:	48 89 d0             	mov    %rdx,%rax
   410af:	48 c1 e0 03          	shl    $0x3,%rax
   410b3:	48 29 d0             	sub    %rdx,%rax
   410b6:	48 c1 e0 05          	shl    $0x5,%rax
   410ba:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   410c0:	8b 00                	mov    (%rax),%eax
   410c2:	85 c0                	test   %eax,%eax
   410c4:	75 14                	jne    410da <check_virtual_memory+0x167>
   410c6:	ba a0 42 04 00       	mov    $0x442a0,%edx
   410cb:	be 1f 02 00 00       	mov    $0x21f,%esi
   410d0:	bf a0 3f 04 00       	mov    $0x43fa0,%edi
   410d5:	e8 e9 13 00 00       	call   424c3 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   410da:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   410de:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   410e5:	7e 90                	jle    41077 <check_virtual_memory+0x104>
        }
    }
}
   410e7:	90                   	nop
   410e8:	90                   	nop
   410e9:	c9                   	leave  
   410ea:	c3                   	ret    

00000000000410eb <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   410eb:	55                   	push   %rbp
   410ec:	48 89 e5             	mov    %rsp,%rbp
   410ef:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   410f3:	ba 06 43 04 00       	mov    $0x44306,%edx
   410f8:	be 00 0f 00 00       	mov    $0xf00,%esi
   410fd:	bf 20 00 00 00       	mov    $0x20,%edi
   41102:	b8 00 00 00 00       	mov    $0x0,%eax
   41107:	e8 c5 2c 00 00       	call   43dd1 <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4110c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41113:	e9 f8 00 00 00       	jmp    41210 <memshow_physical+0x125>
        if (pn % 64 == 0) {
   41118:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4111b:	83 e0 3f             	and    $0x3f,%eax
   4111e:	85 c0                	test   %eax,%eax
   41120:	75 3c                	jne    4115e <memshow_physical+0x73>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   41122:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41125:	c1 e0 0c             	shl    $0xc,%eax
   41128:	89 c1                	mov    %eax,%ecx
   4112a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4112d:	8d 50 3f             	lea    0x3f(%rax),%edx
   41130:	85 c0                	test   %eax,%eax
   41132:	0f 48 c2             	cmovs  %edx,%eax
   41135:	c1 f8 06             	sar    $0x6,%eax
   41138:	8d 50 01             	lea    0x1(%rax),%edx
   4113b:	89 d0                	mov    %edx,%eax
   4113d:	c1 e0 02             	shl    $0x2,%eax
   41140:	01 d0                	add    %edx,%eax
   41142:	c1 e0 04             	shl    $0x4,%eax
   41145:	83 c0 03             	add    $0x3,%eax
   41148:	ba 16 43 04 00       	mov    $0x44316,%edx
   4114d:	be 00 0f 00 00       	mov    $0xf00,%esi
   41152:	89 c7                	mov    %eax,%edi
   41154:	b8 00 00 00 00       	mov    $0x0,%eax
   41159:	e8 73 2c 00 00       	call   43dd1 <console_printf>
        }

        int owner = pageinfo[pn].owner;
   4115e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41161:	48 98                	cltq   
   41163:	0f b6 84 00 40 1e 05 	movzbl 0x51e40(%rax,%rax,1),%eax
   4116a:	00 
   4116b:	0f be c0             	movsbl %al,%eax
   4116e:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   41171:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41174:	48 98                	cltq   
   41176:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   4117d:	00 
   4117e:	84 c0                	test   %al,%al
   41180:	75 07                	jne    41189 <memshow_physical+0x9e>
            owner = PO_FREE;
   41182:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   41189:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4118c:	83 c0 02             	add    $0x2,%eax
   4118f:	48 98                	cltq   
   41191:	0f b7 84 00 e0 42 04 	movzwl 0x442e0(%rax,%rax,1),%eax
   41198:	00 
   41199:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   4119d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411a0:	48 98                	cltq   
   411a2:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   411a9:	00 
   411aa:	3c 01                	cmp    $0x1,%al
   411ac:	7e 1a                	jle    411c8 <memshow_physical+0xdd>
   411ae:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   411b3:	48 c1 e8 0c          	shr    $0xc,%rax
   411b7:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   411ba:	74 0c                	je     411c8 <memshow_physical+0xdd>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   411bc:	b8 53 00 00 00       	mov    $0x53,%eax
   411c1:	80 cc 0f             	or     $0xf,%ah
   411c4:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   411c8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411cb:	8d 50 3f             	lea    0x3f(%rax),%edx
   411ce:	85 c0                	test   %eax,%eax
   411d0:	0f 48 c2             	cmovs  %edx,%eax
   411d3:	c1 f8 06             	sar    $0x6,%eax
   411d6:	8d 50 01             	lea    0x1(%rax),%edx
   411d9:	89 d0                	mov    %edx,%eax
   411db:	c1 e0 02             	shl    $0x2,%eax
   411de:	01 d0                	add    %edx,%eax
   411e0:	c1 e0 04             	shl    $0x4,%eax
   411e3:	89 c1                	mov    %eax,%ecx
   411e5:	8b 55 fc             	mov    -0x4(%rbp),%edx
   411e8:	89 d0                	mov    %edx,%eax
   411ea:	c1 f8 1f             	sar    $0x1f,%eax
   411ed:	c1 e8 1a             	shr    $0x1a,%eax
   411f0:	01 c2                	add    %eax,%edx
   411f2:	83 e2 3f             	and    $0x3f,%edx
   411f5:	29 c2                	sub    %eax,%edx
   411f7:	89 d0                	mov    %edx,%eax
   411f9:	83 c0 0c             	add    $0xc,%eax
   411fc:	01 c8                	add    %ecx,%eax
   411fe:	48 98                	cltq   
   41200:	0f b7 55 f6          	movzwl -0xa(%rbp),%edx
   41204:	66 89 94 00 00 80 0b 	mov    %dx,0xb8000(%rax,%rax,1)
   4120b:	00 
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4120c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41210:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41217:	0f 8e fb fe ff ff    	jle    41118 <memshow_physical+0x2d>
    }
}
   4121d:	90                   	nop
   4121e:	90                   	nop
   4121f:	c9                   	leave  
   41220:	c3                   	ret    

0000000000041221 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   41221:	55                   	push   %rbp
   41222:	48 89 e5             	mov    %rsp,%rbp
   41225:	48 83 ec 40          	sub    $0x40,%rsp
   41229:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   4122d:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   41231:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41235:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4123b:	48 89 c2             	mov    %rax,%rdx
   4123e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41242:	48 39 c2             	cmp    %rax,%rdx
   41245:	74 14                	je     4125b <memshow_virtual+0x3a>
   41247:	ba 20 43 04 00       	mov    $0x44320,%edx
   4124c:	be 50 02 00 00       	mov    $0x250,%esi
   41251:	bf a0 3f 04 00       	mov    $0x43fa0,%edi
   41256:	e8 68 12 00 00       	call   424c3 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   4125b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4125f:	48 89 c1             	mov    %rax,%rcx
   41262:	ba 4d 43 04 00       	mov    $0x4434d,%edx
   41267:	be 00 0f 00 00       	mov    $0xf00,%esi
   4126c:	bf 3a 03 00 00       	mov    $0x33a,%edi
   41271:	b8 00 00 00 00       	mov    $0x0,%eax
   41276:	e8 56 2b 00 00       	call   43dd1 <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   4127b:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   41282:	00 
   41283:	e9 80 01 00 00       	jmp    41408 <memshow_virtual+0x1e7>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   41288:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4128c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   41290:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   41294:	48 89 ce             	mov    %rcx,%rsi
   41297:	48 89 c7             	mov    %rax,%rdi
   4129a:	e8 e9 18 00 00       	call   42b88 <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   4129f:	8b 45 d0             	mov    -0x30(%rbp),%eax
   412a2:	85 c0                	test   %eax,%eax
   412a4:	79 0b                	jns    412b1 <memshow_virtual+0x90>
            color = ' ';
   412a6:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   412ac:	e9 d7 00 00 00       	jmp    41388 <memshow_virtual+0x167>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   412b1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   412b5:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   412bb:	76 14                	jbe    412d1 <memshow_virtual+0xb0>
   412bd:	ba 6a 43 04 00       	mov    $0x4436a,%edx
   412c2:	be 59 02 00 00       	mov    $0x259,%esi
   412c7:	bf a0 3f 04 00       	mov    $0x43fa0,%edi
   412cc:	e8 f2 11 00 00       	call   424c3 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   412d1:	8b 45 d0             	mov    -0x30(%rbp),%eax
   412d4:	48 98                	cltq   
   412d6:	0f b6 84 00 40 1e 05 	movzbl 0x51e40(%rax,%rax,1),%eax
   412dd:	00 
   412de:	0f be c0             	movsbl %al,%eax
   412e1:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   412e4:	8b 45 d0             	mov    -0x30(%rbp),%eax
   412e7:	48 98                	cltq   
   412e9:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   412f0:	00 
   412f1:	84 c0                	test   %al,%al
   412f3:	75 07                	jne    412fc <memshow_virtual+0xdb>
                owner = PO_FREE;
   412f5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   412fc:	8b 45 f0             	mov    -0x10(%rbp),%eax
   412ff:	83 c0 02             	add    $0x2,%eax
   41302:	48 98                	cltq   
   41304:	0f b7 84 00 e0 42 04 	movzwl 0x442e0(%rax,%rax,1),%eax
   4130b:	00 
   4130c:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   41310:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41313:	48 98                	cltq   
   41315:	83 e0 04             	and    $0x4,%eax
   41318:	48 85 c0             	test   %rax,%rax
   4131b:	74 27                	je     41344 <memshow_virtual+0x123>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   4131d:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41321:	c1 e0 04             	shl    $0x4,%eax
   41324:	66 25 00 f0          	and    $0xf000,%ax
   41328:	89 c2                	mov    %eax,%edx
   4132a:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4132e:	c1 f8 04             	sar    $0x4,%eax
   41331:	66 25 00 0f          	and    $0xf00,%ax
   41335:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   41337:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4133b:	0f b6 c0             	movzbl %al,%eax
   4133e:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41340:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   41344:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41347:	48 98                	cltq   
   41349:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   41350:	00 
   41351:	3c 01                	cmp    $0x1,%al
   41353:	7e 33                	jle    41388 <memshow_virtual+0x167>
   41355:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   4135a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4135e:	74 28                	je     41388 <memshow_virtual+0x167>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   41360:	b8 53 00 00 00       	mov    $0x53,%eax
   41365:	89 c2                	mov    %eax,%edx
   41367:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4136b:	66 25 00 f0          	and    $0xf000,%ax
   4136f:	09 d0                	or     %edx,%eax
   41371:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   41375:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41378:	48 98                	cltq   
   4137a:	83 e0 04             	and    $0x4,%eax
   4137d:	48 85 c0             	test   %rax,%rax
   41380:	75 06                	jne    41388 <memshow_virtual+0x167>
                    color = color | 0x0F00;
   41382:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   41388:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4138c:	48 c1 e8 0c          	shr    $0xc,%rax
   41390:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   41393:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41396:	83 e0 3f             	and    $0x3f,%eax
   41399:	85 c0                	test   %eax,%eax
   4139b:	75 34                	jne    413d1 <memshow_virtual+0x1b0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   4139d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   413a0:	c1 e8 06             	shr    $0x6,%eax
   413a3:	89 c2                	mov    %eax,%edx
   413a5:	89 d0                	mov    %edx,%eax
   413a7:	c1 e0 02             	shl    $0x2,%eax
   413aa:	01 d0                	add    %edx,%eax
   413ac:	c1 e0 04             	shl    $0x4,%eax
   413af:	05 73 03 00 00       	add    $0x373,%eax
   413b4:	89 c7                	mov    %eax,%edi
   413b6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   413ba:	48 89 c1             	mov    %rax,%rcx
   413bd:	ba 16 43 04 00       	mov    $0x44316,%edx
   413c2:	be 00 0f 00 00       	mov    $0xf00,%esi
   413c7:	b8 00 00 00 00       	mov    $0x0,%eax
   413cc:	e8 00 2a 00 00       	call   43dd1 <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   413d1:	8b 45 ec             	mov    -0x14(%rbp),%eax
   413d4:	c1 e8 06             	shr    $0x6,%eax
   413d7:	89 c2                	mov    %eax,%edx
   413d9:	89 d0                	mov    %edx,%eax
   413db:	c1 e0 02             	shl    $0x2,%eax
   413de:	01 d0                	add    %edx,%eax
   413e0:	c1 e0 04             	shl    $0x4,%eax
   413e3:	89 c2                	mov    %eax,%edx
   413e5:	8b 45 ec             	mov    -0x14(%rbp),%eax
   413e8:	83 e0 3f             	and    $0x3f,%eax
   413eb:	01 d0                	add    %edx,%eax
   413ed:	05 7c 03 00 00       	add    $0x37c,%eax
   413f2:	89 c2                	mov    %eax,%edx
   413f4:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   413f8:	66 89 84 12 00 80 0b 	mov    %ax,0xb8000(%rdx,%rdx,1)
   413ff:	00 
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41400:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41407:	00 
   41408:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   4140f:	00 
   41410:	0f 86 72 fe ff ff    	jbe    41288 <memshow_virtual+0x67>
    }
}
   41416:	90                   	nop
   41417:	90                   	nop
   41418:	c9                   	leave  
   41419:	c3                   	ret    

000000000004141a <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   4141a:	55                   	push   %rbp
   4141b:	48 89 e5             	mov    %rsp,%rbp
   4141e:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   41422:	8b 05 18 0e 01 00    	mov    0x10e18(%rip),%eax        # 52240 <last_ticks.1>
   41428:	85 c0                	test   %eax,%eax
   4142a:	74 13                	je     4143f <memshow_virtual_animate+0x25>
   4142c:	8b 15 ee 09 01 00    	mov    0x109ee(%rip),%edx        # 51e20 <ticks>
   41432:	8b 05 08 0e 01 00    	mov    0x10e08(%rip),%eax        # 52240 <last_ticks.1>
   41438:	29 c2                	sub    %eax,%edx
   4143a:	83 fa 31             	cmp    $0x31,%edx
   4143d:	76 2c                	jbe    4146b <memshow_virtual_animate+0x51>
        last_ticks = ticks;
   4143f:	8b 05 db 09 01 00    	mov    0x109db(%rip),%eax        # 51e20 <ticks>
   41445:	89 05 f5 0d 01 00    	mov    %eax,0x10df5(%rip)        # 52240 <last_ticks.1>
        ++showing;
   4144b:	8b 05 b3 3b 00 00    	mov    0x3bb3(%rip),%eax        # 45004 <showing.0>
   41451:	83 c0 01             	add    $0x1,%eax
   41454:	89 05 aa 3b 00 00    	mov    %eax,0x3baa(%rip)        # 45004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   4145a:	eb 0f                	jmp    4146b <memshow_virtual_animate+0x51>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
        ++showing;
   4145c:	8b 05 a2 3b 00 00    	mov    0x3ba2(%rip),%eax        # 45004 <showing.0>
   41462:	83 c0 01             	add    $0x1,%eax
   41465:	89 05 99 3b 00 00    	mov    %eax,0x3b99(%rip)        # 45004 <showing.0>
    while (showing <= 2*NPROC
   4146b:	8b 05 93 3b 00 00    	mov    0x3b93(%rip),%eax        # 45004 <showing.0>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
   41471:	83 f8 20             	cmp    $0x20,%eax
   41474:	7f 6d                	jg     414e3 <memshow_virtual_animate+0xc9>
   41476:	8b 15 88 3b 00 00    	mov    0x3b88(%rip),%edx        # 45004 <showing.0>
   4147c:	89 d0                	mov    %edx,%eax
   4147e:	c1 f8 1f             	sar    $0x1f,%eax
   41481:	c1 e8 1c             	shr    $0x1c,%eax
   41484:	01 c2                	add    %eax,%edx
   41486:	83 e2 0f             	and    $0xf,%edx
   41489:	29 c2                	sub    %eax,%edx
   4148b:	89 d0                	mov    %edx,%eax
   4148d:	48 63 d0             	movslq %eax,%rdx
   41490:	48 89 d0             	mov    %rdx,%rax
   41493:	48 c1 e0 03          	shl    $0x3,%rax
   41497:	48 29 d0             	sub    %rdx,%rax
   4149a:	48 c1 e0 05          	shl    $0x5,%rax
   4149e:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   414a4:	8b 00                	mov    (%rax),%eax
   414a6:	85 c0                	test   %eax,%eax
   414a8:	74 b2                	je     4145c <memshow_virtual_animate+0x42>
   414aa:	8b 15 54 3b 00 00    	mov    0x3b54(%rip),%edx        # 45004 <showing.0>
   414b0:	89 d0                	mov    %edx,%eax
   414b2:	c1 f8 1f             	sar    $0x1f,%eax
   414b5:	c1 e8 1c             	shr    $0x1c,%eax
   414b8:	01 c2                	add    %eax,%edx
   414ba:	83 e2 0f             	and    $0xf,%edx
   414bd:	29 c2                	sub    %eax,%edx
   414bf:	89 d0                	mov    %edx,%eax
   414c1:	48 63 d0             	movslq %eax,%rdx
   414c4:	48 89 d0             	mov    %rdx,%rax
   414c7:	48 c1 e0 03          	shl    $0x3,%rax
   414cb:	48 29 d0             	sub    %rdx,%rax
   414ce:	48 c1 e0 05          	shl    $0x5,%rax
   414d2:	48 05 f8 10 05 00    	add    $0x510f8,%rax
   414d8:	0f b6 00             	movzbl (%rax),%eax
   414db:	84 c0                	test   %al,%al
   414dd:	0f 84 79 ff ff ff    	je     4145c <memshow_virtual_animate+0x42>
    }
    showing = showing % NPROC;
   414e3:	8b 15 1b 3b 00 00    	mov    0x3b1b(%rip),%edx        # 45004 <showing.0>
   414e9:	89 d0                	mov    %edx,%eax
   414eb:	c1 f8 1f             	sar    $0x1f,%eax
   414ee:	c1 e8 1c             	shr    $0x1c,%eax
   414f1:	01 c2                	add    %eax,%edx
   414f3:	83 e2 0f             	and    $0xf,%edx
   414f6:	29 c2                	sub    %eax,%edx
   414f8:	89 d0                	mov    %edx,%eax
   414fa:	89 05 04 3b 00 00    	mov    %eax,0x3b04(%rip)        # 45004 <showing.0>

    if (processes[showing].p_state != P_FREE) {
   41500:	8b 05 fe 3a 00 00    	mov    0x3afe(%rip),%eax        # 45004 <showing.0>
   41506:	48 63 d0             	movslq %eax,%rdx
   41509:	48 89 d0             	mov    %rdx,%rax
   4150c:	48 c1 e0 03          	shl    $0x3,%rax
   41510:	48 29 d0             	sub    %rdx,%rax
   41513:	48 c1 e0 05          	shl    $0x5,%rax
   41517:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   4151d:	8b 00                	mov    (%rax),%eax
   4151f:	85 c0                	test   %eax,%eax
   41521:	74 52                	je     41575 <memshow_virtual_animate+0x15b>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   41523:	8b 15 db 3a 00 00    	mov    0x3adb(%rip),%edx        # 45004 <showing.0>
   41529:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   4152d:	89 d1                	mov    %edx,%ecx
   4152f:	ba 84 43 04 00       	mov    $0x44384,%edx
   41534:	be 04 00 00 00       	mov    $0x4,%esi
   41539:	48 89 c7             	mov    %rax,%rdi
   4153c:	b8 00 00 00 00       	mov    $0x0,%eax
   41541:	e8 97 29 00 00       	call   43edd <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   41546:	8b 05 b8 3a 00 00    	mov    0x3ab8(%rip),%eax        # 45004 <showing.0>
   4154c:	48 63 d0             	movslq %eax,%rdx
   4154f:	48 89 d0             	mov    %rdx,%rax
   41552:	48 c1 e0 03          	shl    $0x3,%rax
   41556:	48 29 d0             	sub    %rdx,%rax
   41559:	48 c1 e0 05          	shl    $0x5,%rax
   4155d:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   41563:	48 8b 00             	mov    (%rax),%rax
   41566:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   4156a:	48 89 d6             	mov    %rdx,%rsi
   4156d:	48 89 c7             	mov    %rax,%rdi
   41570:	e8 ac fc ff ff       	call   41221 <memshow_virtual>
    }
}
   41575:	90                   	nop
   41576:	c9                   	leave  
   41577:	c3                   	ret    

0000000000041578 <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   41578:	55                   	push   %rbp
   41579:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   4157c:	e8 4f 01 00 00       	call   416d0 <segments_init>
    interrupt_init();
   41581:	e8 d0 03 00 00       	call   41956 <interrupt_init>
    virtual_memory_init();
   41586:	e8 f3 0f 00 00       	call   4257e <virtual_memory_init>
}
   4158b:	90                   	nop
   4158c:	5d                   	pop    %rbp
   4158d:	c3                   	ret    

000000000004158e <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   4158e:	55                   	push   %rbp
   4158f:	48 89 e5             	mov    %rsp,%rbp
   41592:	48 83 ec 18          	sub    $0x18,%rsp
   41596:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4159a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   4159e:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   415a1:	8b 45 ec             	mov    -0x14(%rbp),%eax
   415a4:	48 98                	cltq   
   415a6:	48 c1 e0 2d          	shl    $0x2d,%rax
   415aa:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   415ae:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   415b5:	90 00 00 
   415b8:	48 09 c2             	or     %rax,%rdx
    *segment = type
   415bb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   415bf:	48 89 10             	mov    %rdx,(%rax)
}
   415c2:	90                   	nop
   415c3:	c9                   	leave  
   415c4:	c3                   	ret    

00000000000415c5 <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   415c5:	55                   	push   %rbp
   415c6:	48 89 e5             	mov    %rsp,%rbp
   415c9:	48 83 ec 28          	sub    $0x28,%rsp
   415cd:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   415d1:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   415d5:	89 55 ec             	mov    %edx,-0x14(%rbp)
   415d8:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   415dc:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   415e0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   415e4:	48 c1 e0 10          	shl    $0x10,%rax
   415e8:	48 89 c2             	mov    %rax,%rdx
   415eb:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   415f2:	00 00 00 
   415f5:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   415f8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   415fc:	48 c1 e0 20          	shl    $0x20,%rax
   41600:	48 89 c1             	mov    %rax,%rcx
   41603:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   4160a:	00 00 ff 
   4160d:	48 21 c8             	and    %rcx,%rax
   41610:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   41613:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41617:	48 83 e8 01          	sub    $0x1,%rax
   4161b:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   4161e:	48 09 d0             	or     %rdx,%rax
        | type
   41621:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   41625:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41628:	48 63 d2             	movslq %edx,%rdx
   4162b:	48 c1 e2 2d          	shl    $0x2d,%rdx
   4162f:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   41632:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   41639:	80 00 00 
   4163c:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   4163f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41643:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   41646:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4164a:	48 83 c0 08          	add    $0x8,%rax
   4164e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   41652:	48 c1 ea 20          	shr    $0x20,%rdx
   41656:	48 89 10             	mov    %rdx,(%rax)
}
   41659:	90                   	nop
   4165a:	c9                   	leave  
   4165b:	c3                   	ret    

000000000004165c <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   4165c:	55                   	push   %rbp
   4165d:	48 89 e5             	mov    %rsp,%rbp
   41660:	48 83 ec 20          	sub    $0x20,%rsp
   41664:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41668:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   4166c:	89 55 ec             	mov    %edx,-0x14(%rbp)
   4166f:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41673:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41677:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   4167a:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   4167e:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41681:	48 63 d2             	movslq %edx,%rdx
   41684:	48 c1 e2 2d          	shl    $0x2d,%rdx
   41688:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   4168b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4168f:	48 c1 e0 20          	shl    $0x20,%rax
   41693:	48 89 c1             	mov    %rax,%rcx
   41696:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   4169d:	00 ff ff 
   416a0:	48 21 c8             	and    %rcx,%rax
   416a3:	48 09 c2             	or     %rax,%rdx
   416a6:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   416ad:	80 00 00 
   416b0:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   416b3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   416b7:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   416ba:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   416be:	48 c1 e8 20          	shr    $0x20,%rax
   416c2:	48 89 c2             	mov    %rax,%rdx
   416c5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   416c9:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   416cd:	90                   	nop
   416ce:	c9                   	leave  
   416cf:	c3                   	ret    

00000000000416d0 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   416d0:	55                   	push   %rbp
   416d1:	48 89 e5             	mov    %rsp,%rbp
   416d4:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   416d8:	48 c7 05 7d 0b 01 00 	movq   $0x0,0x10b7d(%rip)        # 52260 <segments>
   416df:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   416e3:	ba 00 00 00 00       	mov    $0x0,%edx
   416e8:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   416ef:	08 20 00 
   416f2:	48 89 c6             	mov    %rax,%rsi
   416f5:	bf 68 22 05 00       	mov    $0x52268,%edi
   416fa:	e8 8f fe ff ff       	call   4158e <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   416ff:	ba 03 00 00 00       	mov    $0x3,%edx
   41704:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   4170b:	08 20 00 
   4170e:	48 89 c6             	mov    %rax,%rsi
   41711:	bf 70 22 05 00       	mov    $0x52270,%edi
   41716:	e8 73 fe ff ff       	call   4158e <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   4171b:	ba 00 00 00 00       	mov    $0x0,%edx
   41720:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41727:	02 00 00 
   4172a:	48 89 c6             	mov    %rax,%rsi
   4172d:	bf 78 22 05 00       	mov    $0x52278,%edi
   41732:	e8 57 fe ff ff       	call   4158e <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   41737:	ba 03 00 00 00       	mov    $0x3,%edx
   4173c:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41743:	02 00 00 
   41746:	48 89 c6             	mov    %rax,%rsi
   41749:	bf 80 22 05 00       	mov    $0x52280,%edi
   4174e:	e8 3b fe ff ff       	call   4158e <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   41753:	b8 a0 32 05 00       	mov    $0x532a0,%eax
   41758:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   4175e:	48 89 c1             	mov    %rax,%rcx
   41761:	ba 00 00 00 00       	mov    $0x0,%edx
   41766:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   4176d:	09 00 00 
   41770:	48 89 c6             	mov    %rax,%rsi
   41773:	bf 88 22 05 00       	mov    $0x52288,%edi
   41778:	e8 48 fe ff ff       	call   415c5 <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   4177d:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   41783:	b8 60 22 05 00       	mov    $0x52260,%eax
   41788:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   4178c:	ba 60 00 00 00       	mov    $0x60,%edx
   41791:	be 00 00 00 00       	mov    $0x0,%esi
   41796:	bf a0 32 05 00       	mov    $0x532a0,%edi
   4179b:	e8 7a 18 00 00       	call   4301a <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   417a0:	48 c7 05 f9 1a 01 00 	movq   $0x80000,0x11af9(%rip)        # 532a4 <kernel_task_descriptor+0x4>
   417a7:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   417ab:	ba 00 10 00 00       	mov    $0x1000,%edx
   417b0:	be 00 00 00 00       	mov    $0x0,%esi
   417b5:	bf a0 22 05 00       	mov    $0x522a0,%edi
   417ba:	e8 5b 18 00 00       	call   4301a <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   417bf:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   417c6:	eb 30                	jmp    417f8 <segments_init+0x128>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   417c8:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   417cd:	8b 45 fc             	mov    -0x4(%rbp),%eax
   417d0:	48 c1 e0 04          	shl    $0x4,%rax
   417d4:	48 05 a0 22 05 00    	add    $0x522a0,%rax
   417da:	48 89 d1             	mov    %rdx,%rcx
   417dd:	ba 00 00 00 00       	mov    $0x0,%edx
   417e2:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   417e9:	0e 00 00 
   417ec:	48 89 c7             	mov    %rax,%rdi
   417ef:	e8 68 fe ff ff       	call   4165c <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   417f4:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   417f8:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   417ff:	76 c7                	jbe    417c8 <segments_init+0xf8>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   41801:	b8 36 00 04 00       	mov    $0x40036,%eax
   41806:	48 89 c1             	mov    %rax,%rcx
   41809:	ba 00 00 00 00       	mov    $0x0,%edx
   4180e:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41815:	0e 00 00 
   41818:	48 89 c6             	mov    %rax,%rsi
   4181b:	bf a0 24 05 00       	mov    $0x524a0,%edi
   41820:	e8 37 fe ff ff       	call   4165c <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   41825:	b8 2e 00 04 00       	mov    $0x4002e,%eax
   4182a:	48 89 c1             	mov    %rax,%rcx
   4182d:	ba 00 00 00 00       	mov    $0x0,%edx
   41832:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41839:	0e 00 00 
   4183c:	48 89 c6             	mov    %rax,%rsi
   4183f:	bf 70 23 05 00       	mov    $0x52370,%edi
   41844:	e8 13 fe ff ff       	call   4165c <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   41849:	b8 32 00 04 00       	mov    $0x40032,%eax
   4184e:	48 89 c1             	mov    %rax,%rcx
   41851:	ba 00 00 00 00       	mov    $0x0,%edx
   41856:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   4185d:	0e 00 00 
   41860:	48 89 c6             	mov    %rax,%rsi
   41863:	bf 80 23 05 00       	mov    $0x52380,%edi
   41868:	e8 ef fd ff ff       	call   4165c <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   4186d:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   41874:	eb 3e                	jmp    418b4 <segments_init+0x1e4>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   41876:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41879:	83 e8 30             	sub    $0x30,%eax
   4187c:	89 c0                	mov    %eax,%eax
   4187e:	48 8b 04 c5 e7 00 04 	mov    0x400e7(,%rax,8),%rax
   41885:	00 
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   41886:	48 89 c2             	mov    %rax,%rdx
   41889:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4188c:	48 c1 e0 04          	shl    $0x4,%rax
   41890:	48 05 a0 22 05 00    	add    $0x522a0,%rax
   41896:	48 89 d1             	mov    %rdx,%rcx
   41899:	ba 03 00 00 00       	mov    $0x3,%edx
   4189e:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   418a5:	0e 00 00 
   418a8:	48 89 c7             	mov    %rax,%rdi
   418ab:	e8 ac fd ff ff       	call   4165c <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   418b0:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   418b4:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   418b8:	76 bc                	jbe    41876 <segments_init+0x1a6>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   418ba:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   418c0:	b8 a0 22 05 00       	mov    $0x522a0,%eax
   418c5:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   418c9:	b8 28 00 00 00       	mov    $0x28,%eax
   418ce:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   418d2:	0f 00 d8             	ltr    %ax
   418d5:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   418d9:	0f 20 c0             	mov    %cr0,%rax
   418dc:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   418e0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   418e4:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   418e7:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   418ee:	8b 45 f4             	mov    -0xc(%rbp),%eax
   418f1:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   418f4:	8b 45 f0             	mov    -0x10(%rbp),%eax
   418f7:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   418fb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   418ff:	0f 22 c0             	mov    %rax,%cr0
}
   41902:	90                   	nop
    lcr0(cr0);
}
   41903:	90                   	nop
   41904:	c9                   	leave  
   41905:	c3                   	ret    

0000000000041906 <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   41906:	55                   	push   %rbp
   41907:	48 89 e5             	mov    %rsp,%rbp
   4190a:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   4190e:	0f b7 05 eb 19 01 00 	movzwl 0x119eb(%rip),%eax        # 53300 <interrupts_enabled>
   41915:	f7 d0                	not    %eax
   41917:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   4191b:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   4191f:	0f b6 c0             	movzbl %al,%eax
   41922:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   41929:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4192c:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   41930:	8b 55 f0             	mov    -0x10(%rbp),%edx
   41933:	ee                   	out    %al,(%dx)
}
   41934:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   41935:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41939:	66 c1 e8 08          	shr    $0x8,%ax
   4193d:	0f b6 c0             	movzbl %al,%eax
   41940:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   41947:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4194a:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   4194e:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41951:	ee                   	out    %al,(%dx)
}
   41952:	90                   	nop
}
   41953:	90                   	nop
   41954:	c9                   	leave  
   41955:	c3                   	ret    

0000000000041956 <interrupt_init>:

void interrupt_init(void) {
   41956:	55                   	push   %rbp
   41957:	48 89 e5             	mov    %rsp,%rbp
   4195a:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   4195e:	66 c7 05 99 19 01 00 	movw   $0x0,0x11999(%rip)        # 53300 <interrupts_enabled>
   41965:	00 00 
    interrupt_mask();
   41967:	e8 9a ff ff ff       	call   41906 <interrupt_mask>
   4196c:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   41973:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41977:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   4197b:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   4197e:	ee                   	out    %al,(%dx)
}
   4197f:	90                   	nop
   41980:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   41987:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4198b:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   4198f:	8b 55 ac             	mov    -0x54(%rbp),%edx
   41992:	ee                   	out    %al,(%dx)
}
   41993:	90                   	nop
   41994:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   4199b:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4199f:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   419a3:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   419a6:	ee                   	out    %al,(%dx)
}
   419a7:	90                   	nop
   419a8:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   419af:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   419b3:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   419b7:	8b 55 bc             	mov    -0x44(%rbp),%edx
   419ba:	ee                   	out    %al,(%dx)
}
   419bb:	90                   	nop
   419bc:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   419c3:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   419c7:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   419cb:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   419ce:	ee                   	out    %al,(%dx)
}
   419cf:	90                   	nop
   419d0:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   419d7:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   419db:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   419df:	8b 55 cc             	mov    -0x34(%rbp),%edx
   419e2:	ee                   	out    %al,(%dx)
}
   419e3:	90                   	nop
   419e4:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   419eb:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   419ef:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   419f3:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   419f6:	ee                   	out    %al,(%dx)
}
   419f7:	90                   	nop
   419f8:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   419ff:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a03:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   41a07:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41a0a:	ee                   	out    %al,(%dx)
}
   41a0b:	90                   	nop
   41a0c:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   41a13:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a17:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41a1b:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41a1e:	ee                   	out    %al,(%dx)
}
   41a1f:	90                   	nop
   41a20:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   41a27:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a2b:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41a2f:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41a32:	ee                   	out    %al,(%dx)
}
   41a33:	90                   	nop
   41a34:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   41a3b:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a3f:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41a43:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41a46:	ee                   	out    %al,(%dx)
}
   41a47:	90                   	nop
   41a48:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   41a4f:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a53:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41a57:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41a5a:	ee                   	out    %al,(%dx)
}
   41a5b:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   41a5c:	e8 a5 fe ff ff       	call   41906 <interrupt_mask>
}
   41a61:	90                   	nop
   41a62:	c9                   	leave  
   41a63:	c3                   	ret    

0000000000041a64 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   41a64:	55                   	push   %rbp
   41a65:	48 89 e5             	mov    %rsp,%rbp
   41a68:	48 83 ec 28          	sub    $0x28,%rsp
   41a6c:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   41a6f:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41a73:	0f 8e 9e 00 00 00    	jle    41b17 <timer_init+0xb3>
   41a79:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   41a80:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a84:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41a88:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41a8b:	ee                   	out    %al,(%dx)
}
   41a8c:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   41a8d:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41a90:	89 c2                	mov    %eax,%edx
   41a92:	c1 ea 1f             	shr    $0x1f,%edx
   41a95:	01 d0                	add    %edx,%eax
   41a97:	d1 f8                	sar    %eax
   41a99:	05 de 34 12 00       	add    $0x1234de,%eax
   41a9e:	99                   	cltd   
   41a9f:	f7 7d dc             	idivl  -0x24(%rbp)
   41aa2:	89 c2                	mov    %eax,%edx
   41aa4:	89 d0                	mov    %edx,%eax
   41aa6:	c1 f8 1f             	sar    $0x1f,%eax
   41aa9:	c1 e8 18             	shr    $0x18,%eax
   41aac:	01 c2                	add    %eax,%edx
   41aae:	0f b6 d2             	movzbl %dl,%edx
   41ab1:	29 c2                	sub    %eax,%edx
   41ab3:	89 d0                	mov    %edx,%eax
   41ab5:	0f b6 c0             	movzbl %al,%eax
   41ab8:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   41abf:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ac2:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41ac6:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41ac9:	ee                   	out    %al,(%dx)
}
   41aca:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   41acb:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41ace:	89 c2                	mov    %eax,%edx
   41ad0:	c1 ea 1f             	shr    $0x1f,%edx
   41ad3:	01 d0                	add    %edx,%eax
   41ad5:	d1 f8                	sar    %eax
   41ad7:	05 de 34 12 00       	add    $0x1234de,%eax
   41adc:	99                   	cltd   
   41add:	f7 7d dc             	idivl  -0x24(%rbp)
   41ae0:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41ae6:	85 c0                	test   %eax,%eax
   41ae8:	0f 48 c2             	cmovs  %edx,%eax
   41aeb:	c1 f8 08             	sar    $0x8,%eax
   41aee:	0f b6 c0             	movzbl %al,%eax
   41af1:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   41af8:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41afb:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41aff:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41b02:	ee                   	out    %al,(%dx)
}
   41b03:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   41b04:	0f b7 05 f5 17 01 00 	movzwl 0x117f5(%rip),%eax        # 53300 <interrupts_enabled>
   41b0b:	83 c8 01             	or     $0x1,%eax
   41b0e:	66 89 05 eb 17 01 00 	mov    %ax,0x117eb(%rip)        # 53300 <interrupts_enabled>
   41b15:	eb 11                	jmp    41b28 <timer_init+0xc4>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   41b17:	0f b7 05 e2 17 01 00 	movzwl 0x117e2(%rip),%eax        # 53300 <interrupts_enabled>
   41b1e:	83 e0 fe             	and    $0xfffffffe,%eax
   41b21:	66 89 05 d8 17 01 00 	mov    %ax,0x117d8(%rip)        # 53300 <interrupts_enabled>
    }
    interrupt_mask();
   41b28:	e8 d9 fd ff ff       	call   41906 <interrupt_mask>
}
   41b2d:	90                   	nop
   41b2e:	c9                   	leave  
   41b2f:	c3                   	ret    

0000000000041b30 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   41b30:	55                   	push   %rbp
   41b31:	48 89 e5             	mov    %rsp,%rbp
   41b34:	48 83 ec 08          	sub    $0x8,%rsp
   41b38:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   41b3c:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   41b41:	74 14                	je     41b57 <physical_memory_isreserved+0x27>
   41b43:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   41b4a:	00 
   41b4b:	76 11                	jbe    41b5e <physical_memory_isreserved+0x2e>
   41b4d:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   41b54:	00 
   41b55:	77 07                	ja     41b5e <physical_memory_isreserved+0x2e>
   41b57:	b8 01 00 00 00       	mov    $0x1,%eax
   41b5c:	eb 05                	jmp    41b63 <physical_memory_isreserved+0x33>
   41b5e:	b8 00 00 00 00       	mov    $0x0,%eax
}
   41b63:	c9                   	leave  
   41b64:	c3                   	ret    

0000000000041b65 <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   41b65:	55                   	push   %rbp
   41b66:	48 89 e5             	mov    %rsp,%rbp
   41b69:	48 83 ec 10          	sub    $0x10,%rsp
   41b6d:	89 7d fc             	mov    %edi,-0x4(%rbp)
   41b70:	89 75 f8             	mov    %esi,-0x8(%rbp)
   41b73:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   41b76:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41b79:	c1 e0 10             	shl    $0x10,%eax
   41b7c:	89 c2                	mov    %eax,%edx
   41b7e:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41b81:	c1 e0 0b             	shl    $0xb,%eax
   41b84:	09 c2                	or     %eax,%edx
   41b86:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41b89:	c1 e0 08             	shl    $0x8,%eax
   41b8c:	09 d0                	or     %edx,%eax
}
   41b8e:	c9                   	leave  
   41b8f:	c3                   	ret    

0000000000041b90 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   41b90:	55                   	push   %rbp
   41b91:	48 89 e5             	mov    %rsp,%rbp
   41b94:	48 83 ec 18          	sub    $0x18,%rsp
   41b98:	89 7d ec             	mov    %edi,-0x14(%rbp)
   41b9b:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   41b9e:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41ba1:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41ba4:	09 d0                	or     %edx,%eax
   41ba6:	0d 00 00 00 80       	or     $0x80000000,%eax
   41bab:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   41bb2:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   41bb5:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41bb8:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41bbb:	ef                   	out    %eax,(%dx)
}
   41bbc:	90                   	nop
   41bbd:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   41bc4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41bc7:	89 c2                	mov    %eax,%edx
   41bc9:	ed                   	in     (%dx),%eax
   41bca:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   41bcd:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   41bd0:	c9                   	leave  
   41bd1:	c3                   	ret    

0000000000041bd2 <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   41bd2:	55                   	push   %rbp
   41bd3:	48 89 e5             	mov    %rsp,%rbp
   41bd6:	48 83 ec 28          	sub    $0x28,%rsp
   41bda:	89 7d dc             	mov    %edi,-0x24(%rbp)
   41bdd:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   41be0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41be7:	eb 73                	jmp    41c5c <pci_find_device+0x8a>
        for (int slot = 0; slot != 32; ++slot) {
   41be9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41bf0:	eb 60                	jmp    41c52 <pci_find_device+0x80>
            for (int func = 0; func != 8; ++func) {
   41bf2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41bf9:	eb 4a                	jmp    41c45 <pci_find_device+0x73>
                int configaddr = pci_make_configaddr(bus, slot, func);
   41bfb:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41bfe:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41c01:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41c04:	89 ce                	mov    %ecx,%esi
   41c06:	89 c7                	mov    %eax,%edi
   41c08:	e8 58 ff ff ff       	call   41b65 <pci_make_configaddr>
   41c0d:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   41c10:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41c13:	be 00 00 00 00       	mov    $0x0,%esi
   41c18:	89 c7                	mov    %eax,%edi
   41c1a:	e8 71 ff ff ff       	call   41b90 <pci_config_readl>
   41c1f:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   41c22:	8b 45 d8             	mov    -0x28(%rbp),%eax
   41c25:	c1 e0 10             	shl    $0x10,%eax
   41c28:	0b 45 dc             	or     -0x24(%rbp),%eax
   41c2b:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   41c2e:	75 05                	jne    41c35 <pci_find_device+0x63>
                    return configaddr;
   41c30:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41c33:	eb 35                	jmp    41c6a <pci_find_device+0x98>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   41c35:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   41c39:	75 06                	jne    41c41 <pci_find_device+0x6f>
   41c3b:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41c3f:	74 0c                	je     41c4d <pci_find_device+0x7b>
            for (int func = 0; func != 8; ++func) {
   41c41:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41c45:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   41c49:	75 b0                	jne    41bfb <pci_find_device+0x29>
   41c4b:	eb 01                	jmp    41c4e <pci_find_device+0x7c>
                    break;
   41c4d:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   41c4e:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41c52:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   41c56:	75 9a                	jne    41bf2 <pci_find_device+0x20>
    for (int bus = 0; bus != 256; ++bus) {
   41c58:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41c5c:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   41c63:	75 84                	jne    41be9 <pci_find_device+0x17>
                }
            }
        }
    }
    return -1;
   41c65:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   41c6a:	c9                   	leave  
   41c6b:	c3                   	ret    

0000000000041c6c <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   41c6c:	55                   	push   %rbp
   41c6d:	48 89 e5             	mov    %rsp,%rbp
   41c70:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   41c74:	be 13 71 00 00       	mov    $0x7113,%esi
   41c79:	bf 86 80 00 00       	mov    $0x8086,%edi
   41c7e:	e8 4f ff ff ff       	call   41bd2 <pci_find_device>
   41c83:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   41c86:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   41c8a:	78 30                	js     41cbc <poweroff+0x50>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   41c8c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41c8f:	be 40 00 00 00       	mov    $0x40,%esi
   41c94:	89 c7                	mov    %eax,%edi
   41c96:	e8 f5 fe ff ff       	call   41b90 <pci_config_readl>
   41c9b:	25 c0 ff 00 00       	and    $0xffc0,%eax
   41ca0:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   41ca3:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41ca6:	83 c0 04             	add    $0x4,%eax
   41ca9:	89 45 f4             	mov    %eax,-0xc(%rbp)
   41cac:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   41cb2:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   41cb6:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41cb9:	66 ef                	out    %ax,(%dx)
}
   41cbb:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   41cbc:	ba a0 43 04 00       	mov    $0x443a0,%edx
   41cc1:	be 00 c0 00 00       	mov    $0xc000,%esi
   41cc6:	bf 80 07 00 00       	mov    $0x780,%edi
   41ccb:	b8 00 00 00 00       	mov    $0x0,%eax
   41cd0:	e8 fc 20 00 00       	call   43dd1 <console_printf>
 spinloop: goto spinloop;
   41cd5:	eb fe                	jmp    41cd5 <poweroff+0x69>

0000000000041cd7 <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   41cd7:	55                   	push   %rbp
   41cd8:	48 89 e5             	mov    %rsp,%rbp
   41cdb:	48 83 ec 10          	sub    $0x10,%rsp
   41cdf:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   41ce6:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41cea:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41cee:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41cf1:	ee                   	out    %al,(%dx)
}
   41cf2:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   41cf3:	eb fe                	jmp    41cf3 <reboot+0x1c>

0000000000041cf5 <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   41cf5:	55                   	push   %rbp
   41cf6:	48 89 e5             	mov    %rsp,%rbp
   41cf9:	48 83 ec 10          	sub    $0x10,%rsp
   41cfd:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41d01:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   41d04:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d08:	48 83 c0 08          	add    $0x8,%rax
   41d0c:	ba c0 00 00 00       	mov    $0xc0,%edx
   41d11:	be 00 00 00 00       	mov    $0x0,%esi
   41d16:	48 89 c7             	mov    %rax,%rdi
   41d19:	e8 fc 12 00 00       	call   4301a <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   41d1e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d22:	66 c7 80 a8 00 00 00 	movw   $0x13,0xa8(%rax)
   41d29:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   41d2b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d2f:	48 c7 80 80 00 00 00 	movq   $0x23,0x80(%rax)
   41d36:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   41d3a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d3e:	48 c7 80 88 00 00 00 	movq   $0x23,0x88(%rax)
   41d45:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   41d49:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d4d:	66 c7 80 c0 00 00 00 	movw   $0x23,0xc0(%rax)
   41d54:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   41d56:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d5a:	48 c7 80 b0 00 00 00 	movq   $0x200,0xb0(%rax)
   41d61:	00 02 00 00 
    p->display_status = 1;
   41d65:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d69:	c6 80 d8 00 00 00 01 	movb   $0x1,0xd8(%rax)

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   41d70:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41d73:	83 e0 01             	and    $0x1,%eax
   41d76:	85 c0                	test   %eax,%eax
   41d78:	74 1c                	je     41d96 <process_init+0xa1>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   41d7a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d7e:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   41d85:	80 cc 30             	or     $0x30,%ah
   41d88:	48 89 c2             	mov    %rax,%rdx
   41d8b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d8f:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   41d96:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41d99:	83 e0 02             	and    $0x2,%eax
   41d9c:	85 c0                	test   %eax,%eax
   41d9e:	74 1c                	je     41dbc <process_init+0xc7>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   41da0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41da4:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   41dab:	80 e4 fd             	and    $0xfd,%ah
   41dae:	48 89 c2             	mov    %rax,%rdx
   41db1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41db5:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
}
   41dbc:	90                   	nop
   41dbd:	c9                   	leave  
   41dbe:	c3                   	ret    

0000000000041dbf <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   41dbf:	55                   	push   %rbp
   41dc0:	48 89 e5             	mov    %rsp,%rbp
   41dc3:	48 83 ec 28          	sub    $0x28,%rsp
   41dc7:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   41dca:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41dce:	78 09                	js     41dd9 <console_show_cursor+0x1a>
   41dd0:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   41dd7:	7e 07                	jle    41de0 <console_show_cursor+0x21>
        cpos = 0;
   41dd9:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   41de0:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   41de7:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41deb:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41def:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41df2:	ee                   	out    %al,(%dx)
}
   41df3:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   41df4:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41df7:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41dfd:	85 c0                	test   %eax,%eax
   41dff:	0f 48 c2             	cmovs  %edx,%eax
   41e02:	c1 f8 08             	sar    $0x8,%eax
   41e05:	0f b6 c0             	movzbl %al,%eax
   41e08:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   41e0f:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e12:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41e16:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41e19:	ee                   	out    %al,(%dx)
}
   41e1a:	90                   	nop
   41e1b:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   41e22:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e26:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41e2a:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41e2d:	ee                   	out    %al,(%dx)
}
   41e2e:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   41e2f:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41e32:	89 d0                	mov    %edx,%eax
   41e34:	c1 f8 1f             	sar    $0x1f,%eax
   41e37:	c1 e8 18             	shr    $0x18,%eax
   41e3a:	01 c2                	add    %eax,%edx
   41e3c:	0f b6 d2             	movzbl %dl,%edx
   41e3f:	29 c2                	sub    %eax,%edx
   41e41:	89 d0                	mov    %edx,%eax
   41e43:	0f b6 c0             	movzbl %al,%eax
   41e46:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   41e4d:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e50:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41e54:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41e57:	ee                   	out    %al,(%dx)
}
   41e58:	90                   	nop
}
   41e59:	90                   	nop
   41e5a:	c9                   	leave  
   41e5b:	c3                   	ret    

0000000000041e5c <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   41e5c:	55                   	push   %rbp
   41e5d:	48 89 e5             	mov    %rsp,%rbp
   41e60:	48 83 ec 20          	sub    $0x20,%rsp
   41e64:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41e6b:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41e6e:	89 c2                	mov    %eax,%edx
   41e70:	ec                   	in     (%dx),%al
   41e71:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   41e74:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   41e78:	0f b6 c0             	movzbl %al,%eax
   41e7b:	83 e0 01             	and    $0x1,%eax
   41e7e:	85 c0                	test   %eax,%eax
   41e80:	75 0a                	jne    41e8c <keyboard_readc+0x30>
        return -1;
   41e82:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   41e87:	e9 e7 01 00 00       	jmp    42073 <keyboard_readc+0x217>
   41e8c:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41e93:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41e96:	89 c2                	mov    %eax,%edx
   41e98:	ec                   	in     (%dx),%al
   41e99:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   41e9c:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   41ea0:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   41ea3:	0f b6 05 58 14 01 00 	movzbl 0x11458(%rip),%eax        # 53302 <last_escape.2>
   41eaa:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   41ead:	c6 05 4e 14 01 00 00 	movb   $0x0,0x1144e(%rip)        # 53302 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   41eb4:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   41eb8:	75 11                	jne    41ecb <keyboard_readc+0x6f>
        last_escape = 0x80;
   41eba:	c6 05 41 14 01 00 80 	movb   $0x80,0x11441(%rip)        # 53302 <last_escape.2>
        return 0;
   41ec1:	b8 00 00 00 00       	mov    $0x0,%eax
   41ec6:	e9 a8 01 00 00       	jmp    42073 <keyboard_readc+0x217>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   41ecb:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41ecf:	84 c0                	test   %al,%al
   41ed1:	79 60                	jns    41f33 <keyboard_readc+0xd7>
        int ch = keymap[(data & 0x7F) | escape];
   41ed3:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41ed7:	83 e0 7f             	and    $0x7f,%eax
   41eda:	89 c2                	mov    %eax,%edx
   41edc:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   41ee0:	09 d0                	or     %edx,%eax
   41ee2:	48 98                	cltq   
   41ee4:	0f b6 80 c0 43 04 00 	movzbl 0x443c0(%rax),%eax
   41eeb:	0f b6 c0             	movzbl %al,%eax
   41eee:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   41ef1:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   41ef8:	7e 2f                	jle    41f29 <keyboard_readc+0xcd>
   41efa:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   41f01:	7f 26                	jg     41f29 <keyboard_readc+0xcd>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   41f03:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41f06:	2d fa 00 00 00       	sub    $0xfa,%eax
   41f0b:	ba 01 00 00 00       	mov    $0x1,%edx
   41f10:	89 c1                	mov    %eax,%ecx
   41f12:	d3 e2                	shl    %cl,%edx
   41f14:	89 d0                	mov    %edx,%eax
   41f16:	f7 d0                	not    %eax
   41f18:	89 c2                	mov    %eax,%edx
   41f1a:	0f b6 05 e2 13 01 00 	movzbl 0x113e2(%rip),%eax        # 53303 <modifiers.1>
   41f21:	21 d0                	and    %edx,%eax
   41f23:	88 05 da 13 01 00    	mov    %al,0x113da(%rip)        # 53303 <modifiers.1>
        }
        return 0;
   41f29:	b8 00 00 00 00       	mov    $0x0,%eax
   41f2e:	e9 40 01 00 00       	jmp    42073 <keyboard_readc+0x217>
    }

    int ch = (unsigned char) keymap[data | escape];
   41f33:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41f37:	0a 45 fa             	or     -0x6(%rbp),%al
   41f3a:	0f b6 c0             	movzbl %al,%eax
   41f3d:	48 98                	cltq   
   41f3f:	0f b6 80 c0 43 04 00 	movzbl 0x443c0(%rax),%eax
   41f46:	0f b6 c0             	movzbl %al,%eax
   41f49:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   41f4c:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   41f50:	7e 57                	jle    41fa9 <keyboard_readc+0x14d>
   41f52:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   41f56:	7f 51                	jg     41fa9 <keyboard_readc+0x14d>
        if (modifiers & MOD_CONTROL) {
   41f58:	0f b6 05 a4 13 01 00 	movzbl 0x113a4(%rip),%eax        # 53303 <modifiers.1>
   41f5f:	0f b6 c0             	movzbl %al,%eax
   41f62:	83 e0 02             	and    $0x2,%eax
   41f65:	85 c0                	test   %eax,%eax
   41f67:	74 09                	je     41f72 <keyboard_readc+0x116>
            ch -= 0x60;
   41f69:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   41f6d:	e9 fd 00 00 00       	jmp    4206f <keyboard_readc+0x213>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   41f72:	0f b6 05 8a 13 01 00 	movzbl 0x1138a(%rip),%eax        # 53303 <modifiers.1>
   41f79:	0f b6 c0             	movzbl %al,%eax
   41f7c:	83 e0 01             	and    $0x1,%eax
   41f7f:	85 c0                	test   %eax,%eax
   41f81:	0f 94 c2             	sete   %dl
   41f84:	0f b6 05 78 13 01 00 	movzbl 0x11378(%rip),%eax        # 53303 <modifiers.1>
   41f8b:	0f b6 c0             	movzbl %al,%eax
   41f8e:	83 e0 08             	and    $0x8,%eax
   41f91:	85 c0                	test   %eax,%eax
   41f93:	0f 94 c0             	sete   %al
   41f96:	31 d0                	xor    %edx,%eax
   41f98:	84 c0                	test   %al,%al
   41f9a:	0f 84 cf 00 00 00    	je     4206f <keyboard_readc+0x213>
            ch -= 0x20;
   41fa0:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   41fa4:	e9 c6 00 00 00       	jmp    4206f <keyboard_readc+0x213>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   41fa9:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   41fb0:	7e 30                	jle    41fe2 <keyboard_readc+0x186>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   41fb2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41fb5:	2d fa 00 00 00       	sub    $0xfa,%eax
   41fba:	ba 01 00 00 00       	mov    $0x1,%edx
   41fbf:	89 c1                	mov    %eax,%ecx
   41fc1:	d3 e2                	shl    %cl,%edx
   41fc3:	89 d0                	mov    %edx,%eax
   41fc5:	89 c2                	mov    %eax,%edx
   41fc7:	0f b6 05 35 13 01 00 	movzbl 0x11335(%rip),%eax        # 53303 <modifiers.1>
   41fce:	31 d0                	xor    %edx,%eax
   41fd0:	88 05 2d 13 01 00    	mov    %al,0x1132d(%rip)        # 53303 <modifiers.1>
        ch = 0;
   41fd6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41fdd:	e9 8e 00 00 00       	jmp    42070 <keyboard_readc+0x214>
    } else if (ch >= KEY_SHIFT) {
   41fe2:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   41fe9:	7e 2d                	jle    42018 <keyboard_readc+0x1bc>
        modifiers |= 1 << (ch - KEY_SHIFT);
   41feb:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41fee:	2d fa 00 00 00       	sub    $0xfa,%eax
   41ff3:	ba 01 00 00 00       	mov    $0x1,%edx
   41ff8:	89 c1                	mov    %eax,%ecx
   41ffa:	d3 e2                	shl    %cl,%edx
   41ffc:	89 d0                	mov    %edx,%eax
   41ffe:	89 c2                	mov    %eax,%edx
   42000:	0f b6 05 fc 12 01 00 	movzbl 0x112fc(%rip),%eax        # 53303 <modifiers.1>
   42007:	09 d0                	or     %edx,%eax
   42009:	88 05 f4 12 01 00    	mov    %al,0x112f4(%rip)        # 53303 <modifiers.1>
        ch = 0;
   4200f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42016:	eb 58                	jmp    42070 <keyboard_readc+0x214>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   42018:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   4201c:	7e 31                	jle    4204f <keyboard_readc+0x1f3>
   4201e:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   42025:	7f 28                	jg     4204f <keyboard_readc+0x1f3>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   42027:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4202a:	8d 50 80             	lea    -0x80(%rax),%edx
   4202d:	0f b6 05 cf 12 01 00 	movzbl 0x112cf(%rip),%eax        # 53303 <modifiers.1>
   42034:	0f b6 c0             	movzbl %al,%eax
   42037:	83 e0 03             	and    $0x3,%eax
   4203a:	48 98                	cltq   
   4203c:	48 63 d2             	movslq %edx,%rdx
   4203f:	0f b6 84 90 c0 44 04 	movzbl 0x444c0(%rax,%rdx,4),%eax
   42046:	00 
   42047:	0f b6 c0             	movzbl %al,%eax
   4204a:	89 45 fc             	mov    %eax,-0x4(%rbp)
   4204d:	eb 21                	jmp    42070 <keyboard_readc+0x214>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   4204f:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   42053:	7f 1b                	jg     42070 <keyboard_readc+0x214>
   42055:	0f b6 05 a7 12 01 00 	movzbl 0x112a7(%rip),%eax        # 53303 <modifiers.1>
   4205c:	0f b6 c0             	movzbl %al,%eax
   4205f:	83 e0 02             	and    $0x2,%eax
   42062:	85 c0                	test   %eax,%eax
   42064:	74 0a                	je     42070 <keyboard_readc+0x214>
        ch = 0;
   42066:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4206d:	eb 01                	jmp    42070 <keyboard_readc+0x214>
        if (modifiers & MOD_CONTROL) {
   4206f:	90                   	nop
    }

    return ch;
   42070:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   42073:	c9                   	leave  
   42074:	c3                   	ret    

0000000000042075 <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   42075:	55                   	push   %rbp
   42076:	48 89 e5             	mov    %rsp,%rbp
   42079:	48 83 ec 20          	sub    $0x20,%rsp
   4207d:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42084:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   42087:	89 c2                	mov    %eax,%edx
   42089:	ec                   	in     (%dx),%al
   4208a:	88 45 e3             	mov    %al,-0x1d(%rbp)
   4208d:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   42094:	8b 45 ec             	mov    -0x14(%rbp),%eax
   42097:	89 c2                	mov    %eax,%edx
   42099:	ec                   	in     (%dx),%al
   4209a:	88 45 eb             	mov    %al,-0x15(%rbp)
   4209d:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   420a4:	8b 45 f4             	mov    -0xc(%rbp),%eax
   420a7:	89 c2                	mov    %eax,%edx
   420a9:	ec                   	in     (%dx),%al
   420aa:	88 45 f3             	mov    %al,-0xd(%rbp)
   420ad:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   420b4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   420b7:	89 c2                	mov    %eax,%edx
   420b9:	ec                   	in     (%dx),%al
   420ba:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   420bd:	90                   	nop
   420be:	c9                   	leave  
   420bf:	c3                   	ret    

00000000000420c0 <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   420c0:	55                   	push   %rbp
   420c1:	48 89 e5             	mov    %rsp,%rbp
   420c4:	48 83 ec 40          	sub    $0x40,%rsp
   420c8:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   420cc:	89 f0                	mov    %esi,%eax
   420ce:	89 55 c0             	mov    %edx,-0x40(%rbp)
   420d1:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   420d4:	8b 05 2a 12 01 00    	mov    0x1122a(%rip),%eax        # 53304 <initialized.0>
   420da:	85 c0                	test   %eax,%eax
   420dc:	75 1e                	jne    420fc <parallel_port_putc+0x3c>
   420de:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   420e5:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   420e9:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   420ed:	8b 55 f8             	mov    -0x8(%rbp),%edx
   420f0:	ee                   	out    %al,(%dx)
}
   420f1:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   420f2:	c7 05 08 12 01 00 01 	movl   $0x1,0x11208(%rip)        # 53304 <initialized.0>
   420f9:	00 00 00 
    }

    for (int i = 0;
   420fc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42103:	eb 09                	jmp    4210e <parallel_port_putc+0x4e>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   42105:	e8 6b ff ff ff       	call   42075 <delay>
         ++i) {
   4210a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   4210e:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   42115:	7f 18                	jg     4212f <parallel_port_putc+0x6f>
   42117:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   4211e:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42121:	89 c2                	mov    %eax,%edx
   42123:	ec                   	in     (%dx),%al
   42124:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   42127:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   4212b:	84 c0                	test   %al,%al
   4212d:	79 d6                	jns    42105 <parallel_port_putc+0x45>
    }
    outb(IO_PARALLEL1_DATA, c);
   4212f:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   42133:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   4213a:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4213d:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   42141:	8b 55 d8             	mov    -0x28(%rbp),%edx
   42144:	ee                   	out    %al,(%dx)
}
   42145:	90                   	nop
   42146:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   4214d:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42151:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   42155:	8b 55 e0             	mov    -0x20(%rbp),%edx
   42158:	ee                   	out    %al,(%dx)
}
   42159:	90                   	nop
   4215a:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   42161:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42165:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   42169:	8b 55 e8             	mov    -0x18(%rbp),%edx
   4216c:	ee                   	out    %al,(%dx)
}
   4216d:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   4216e:	90                   	nop
   4216f:	c9                   	leave  
   42170:	c3                   	ret    

0000000000042171 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   42171:	55                   	push   %rbp
   42172:	48 89 e5             	mov    %rsp,%rbp
   42175:	48 83 ec 20          	sub    $0x20,%rsp
   42179:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4217d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   42181:	48 c7 45 f8 c0 20 04 	movq   $0x420c0,-0x8(%rbp)
   42188:	00 
    printer_vprintf(&p, 0, format, val);
   42189:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   4218d:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   42191:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   42195:	be 00 00 00 00       	mov    $0x0,%esi
   4219a:	48 89 c7             	mov    %rax,%rdi
   4219d:	e8 14 11 00 00       	call   432b6 <printer_vprintf>
}
   421a2:	90                   	nop
   421a3:	c9                   	leave  
   421a4:	c3                   	ret    

00000000000421a5 <log_printf>:

void log_printf(const char* format, ...) {
   421a5:	55                   	push   %rbp
   421a6:	48 89 e5             	mov    %rsp,%rbp
   421a9:	48 83 ec 60          	sub    $0x60,%rsp
   421ad:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   421b1:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   421b5:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   421b9:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   421bd:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   421c1:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   421c5:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   421cc:	48 8d 45 10          	lea    0x10(%rbp),%rax
   421d0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   421d4:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   421d8:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   421dc:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   421e0:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   421e4:	48 89 d6             	mov    %rdx,%rsi
   421e7:	48 89 c7             	mov    %rax,%rdi
   421ea:	e8 82 ff ff ff       	call   42171 <log_vprintf>
    va_end(val);
}
   421ef:	90                   	nop
   421f0:	c9                   	leave  
   421f1:	c3                   	ret    

00000000000421f2 <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   421f2:	55                   	push   %rbp
   421f3:	48 89 e5             	mov    %rsp,%rbp
   421f6:	48 83 ec 40          	sub    $0x40,%rsp
   421fa:	89 7d dc             	mov    %edi,-0x24(%rbp)
   421fd:	89 75 d8             	mov    %esi,-0x28(%rbp)
   42200:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   42204:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   42208:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   4220c:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42210:	48 8b 0a             	mov    (%rdx),%rcx
   42213:	48 89 08             	mov    %rcx,(%rax)
   42216:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   4221a:	48 89 48 08          	mov    %rcx,0x8(%rax)
   4221e:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   42222:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   42226:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   4222a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4222e:	48 89 d6             	mov    %rdx,%rsi
   42231:	48 89 c7             	mov    %rax,%rdi
   42234:	e8 38 ff ff ff       	call   42171 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   42239:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   4223d:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42241:	8b 75 d8             	mov    -0x28(%rbp),%esi
   42244:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42247:	89 c7                	mov    %eax,%edi
   42249:	e8 17 1b 00 00       	call   43d65 <console_vprintf>
}
   4224e:	c9                   	leave  
   4224f:	c3                   	ret    

0000000000042250 <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   42250:	55                   	push   %rbp
   42251:	48 89 e5             	mov    %rsp,%rbp
   42254:	48 83 ec 60          	sub    $0x60,%rsp
   42258:	89 7d ac             	mov    %edi,-0x54(%rbp)
   4225b:	89 75 a8             	mov    %esi,-0x58(%rbp)
   4225e:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   42262:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42266:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4226a:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   4226e:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   42275:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42279:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   4227d:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42281:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   42285:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   42289:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   4228d:	8b 75 a8             	mov    -0x58(%rbp),%esi
   42290:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42293:	89 c7                	mov    %eax,%edi
   42295:	e8 58 ff ff ff       	call   421f2 <error_vprintf>
   4229a:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   4229d:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   422a0:	c9                   	leave  
   422a1:	c3                   	ret    

00000000000422a2 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'f', and 'e' cause a soft
//    reboot where the kernel runs the allocator programs, "fork", or
//    "forkexit", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   422a2:	55                   	push   %rbp
   422a3:	48 89 e5             	mov    %rsp,%rbp
   422a6:	53                   	push   %rbx
   422a7:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   422ab:	e8 ac fb ff ff       	call   41e5c <keyboard_readc>
   422b0:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   422b3:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   422b7:	74 1c                	je     422d5 <check_keyboard+0x33>
   422b9:	83 7d e4 66          	cmpl   $0x66,-0x1c(%rbp)
   422bd:	74 16                	je     422d5 <check_keyboard+0x33>
   422bf:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   422c3:	74 10                	je     422d5 <check_keyboard+0x33>
   422c5:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   422c9:	74 0a                	je     422d5 <check_keyboard+0x33>
   422cb:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   422cf:	0f 85 e9 00 00 00    	jne    423be <check_keyboard+0x11c>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   422d5:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   422dc:	00 
        memset(pt, 0, PAGESIZE * 3);
   422dd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   422e1:	ba 00 30 00 00       	mov    $0x3000,%edx
   422e6:	be 00 00 00 00       	mov    $0x0,%esi
   422eb:	48 89 c7             	mov    %rax,%rdi
   422ee:	e8 27 0d 00 00       	call   4301a <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   422f3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   422f7:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   422fe:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42302:	48 05 00 10 00 00    	add    $0x1000,%rax
   42308:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   4230f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42313:	48 05 00 20 00 00    	add    $0x2000,%rax
   42319:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   42320:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42324:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42328:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4232c:	0f 22 d8             	mov    %rax,%cr3
}
   4232f:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   42330:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "fork";
   42337:	48 c7 45 e8 18 45 04 	movq   $0x44518,-0x18(%rbp)
   4233e:	00 
        if (c == 'a') {
   4233f:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42343:	75 0a                	jne    4234f <check_keyboard+0xad>
            argument = "allocator";
   42345:	48 c7 45 e8 1d 45 04 	movq   $0x4451d,-0x18(%rbp)
   4234c:	00 
   4234d:	eb 2e                	jmp    4237d <check_keyboard+0xdb>
        } else if (c == 'e') {
   4234f:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42353:	75 0a                	jne    4235f <check_keyboard+0xbd>
            argument = "forkexit";
   42355:	48 c7 45 e8 27 45 04 	movq   $0x44527,-0x18(%rbp)
   4235c:	00 
   4235d:	eb 1e                	jmp    4237d <check_keyboard+0xdb>
        }
        else if (c == 't'){
   4235f:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42363:	75 0a                	jne    4236f <check_keyboard+0xcd>
            argument = "test";
   42365:	48 c7 45 e8 30 45 04 	movq   $0x44530,-0x18(%rbp)
   4236c:	00 
   4236d:	eb 0e                	jmp    4237d <check_keyboard+0xdb>
        }
        else if(c == '2'){
   4236f:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42373:	75 08                	jne    4237d <check_keyboard+0xdb>
            argument = "test2";
   42375:	48 c7 45 e8 35 45 04 	movq   $0x44535,-0x18(%rbp)
   4237c:	00 
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   4237d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42381:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   42385:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4238a:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   4238e:	73 14                	jae    423a4 <check_keyboard+0x102>
   42390:	ba 3b 45 04 00       	mov    $0x4453b,%edx
   42395:	be 5d 02 00 00       	mov    $0x25d,%esi
   4239a:	bf 57 45 04 00       	mov    $0x44557,%edi
   4239f:	e8 1f 01 00 00       	call   424c3 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   423a4:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   423a8:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   423ab:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   423af:	48 89 c3             	mov    %rax,%rbx
   423b2:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   423b7:	e9 44 dc ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   423bc:	eb 11                	jmp    423cf <check_keyboard+0x12d>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   423be:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   423c2:	74 06                	je     423ca <check_keyboard+0x128>
   423c4:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   423c8:	75 05                	jne    423cf <check_keyboard+0x12d>
        poweroff();
   423ca:	e8 9d f8 ff ff       	call   41c6c <poweroff>
    }
    return c;
   423cf:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   423d2:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   423d6:	c9                   	leave  
   423d7:	c3                   	ret    

00000000000423d8 <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   423d8:	55                   	push   %rbp
   423d9:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   423dc:	e8 c1 fe ff ff       	call   422a2 <check_keyboard>
   423e1:	eb f9                	jmp    423dc <fail+0x4>

00000000000423e3 <panic>:

// panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void panic(const char* format, ...) {
   423e3:	55                   	push   %rbp
   423e4:	48 89 e5             	mov    %rsp,%rbp
   423e7:	48 83 ec 60          	sub    $0x60,%rsp
   423eb:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   423ef:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   423f3:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   423f7:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   423fb:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   423ff:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42403:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   4240a:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4240e:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   42412:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42416:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   4241a:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   4241f:	0f 84 80 00 00 00    	je     424a5 <panic+0xc2>
        // Print panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   42425:	ba 6b 45 04 00       	mov    $0x4456b,%edx
   4242a:	be 00 c0 00 00       	mov    $0xc000,%esi
   4242f:	bf 30 07 00 00       	mov    $0x730,%edi
   42434:	b8 00 00 00 00       	mov    $0x0,%eax
   42439:	e8 12 fe ff ff       	call   42250 <error_printf>
   4243e:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   42441:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   42445:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   42449:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4244c:	be 00 c0 00 00       	mov    $0xc000,%esi
   42451:	89 c7                	mov    %eax,%edi
   42453:	e8 9a fd ff ff       	call   421f2 <error_vprintf>
   42458:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   4245b:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   4245e:	48 63 c1             	movslq %ecx,%rax
   42461:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   42468:	48 c1 e8 20          	shr    $0x20,%rax
   4246c:	89 c2                	mov    %eax,%edx
   4246e:	c1 fa 05             	sar    $0x5,%edx
   42471:	89 c8                	mov    %ecx,%eax
   42473:	c1 f8 1f             	sar    $0x1f,%eax
   42476:	29 c2                	sub    %eax,%edx
   42478:	89 d0                	mov    %edx,%eax
   4247a:	c1 e0 02             	shl    $0x2,%eax
   4247d:	01 d0                	add    %edx,%eax
   4247f:	c1 e0 04             	shl    $0x4,%eax
   42482:	29 c1                	sub    %eax,%ecx
   42484:	89 ca                	mov    %ecx,%edx
   42486:	85 d2                	test   %edx,%edx
   42488:	74 34                	je     424be <panic+0xdb>
            error_printf(cpos, 0xC000, "\n");
   4248a:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4248d:	ba 73 45 04 00       	mov    $0x44573,%edx
   42492:	be 00 c0 00 00       	mov    $0xc000,%esi
   42497:	89 c7                	mov    %eax,%edi
   42499:	b8 00 00 00 00       	mov    $0x0,%eax
   4249e:	e8 ad fd ff ff       	call   42250 <error_printf>
   424a3:	eb 19                	jmp    424be <panic+0xdb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   424a5:	ba 75 45 04 00       	mov    $0x44575,%edx
   424aa:	be 00 c0 00 00       	mov    $0xc000,%esi
   424af:	bf 30 07 00 00       	mov    $0x730,%edi
   424b4:	b8 00 00 00 00       	mov    $0x0,%eax
   424b9:	e8 92 fd ff ff       	call   42250 <error_printf>
    }

    va_end(val);
    fail();
   424be:	e8 15 ff ff ff       	call   423d8 <fail>

00000000000424c3 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   424c3:	55                   	push   %rbp
   424c4:	48 89 e5             	mov    %rsp,%rbp
   424c7:	48 83 ec 20          	sub    $0x20,%rsp
   424cb:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   424cf:	89 75 f4             	mov    %esi,-0xc(%rbp)
   424d2:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   424d6:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   424da:	8b 55 f4             	mov    -0xc(%rbp),%edx
   424dd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   424e1:	48 89 c6             	mov    %rax,%rsi
   424e4:	bf 7b 45 04 00       	mov    $0x4457b,%edi
   424e9:	b8 00 00 00 00       	mov    $0x0,%eax
   424ee:	e8 f0 fe ff ff       	call   423e3 <panic>

00000000000424f3 <default_exception>:
}

void default_exception(proc* p){
   424f3:	55                   	push   %rbp
   424f4:	48 89 e5             	mov    %rsp,%rbp
   424f7:	48 83 ec 20          	sub    $0x20,%rsp
   424fb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   424ff:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42503:	48 83 c0 08          	add    $0x8,%rax
   42507:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    panic("Unexpected exception %d!\n", reg->reg_intno);
   4250b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4250f:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   42516:	48 89 c6             	mov    %rax,%rsi
   42519:	bf 99 45 04 00       	mov    $0x44599,%edi
   4251e:	b8 00 00 00 00       	mov    $0x0,%eax
   42523:	e8 bb fe ff ff       	call   423e3 <panic>

0000000000042528 <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   42528:	55                   	push   %rbp
   42529:	48 89 e5             	mov    %rsp,%rbp
   4252c:	48 83 ec 10          	sub    $0x10,%rsp
   42530:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42534:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   42537:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   4253b:	78 06                	js     42543 <pageindex+0x1b>
   4253d:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   42541:	7e 14                	jle    42557 <pageindex+0x2f>
   42543:	ba b8 45 04 00       	mov    $0x445b8,%edx
   42548:	be 1e 00 00 00       	mov    $0x1e,%esi
   4254d:	bf d1 45 04 00       	mov    $0x445d1,%edi
   42552:	e8 6c ff ff ff       	call   424c3 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   42557:	b8 03 00 00 00       	mov    $0x3,%eax
   4255c:	2b 45 f4             	sub    -0xc(%rbp),%eax
   4255f:	89 c2                	mov    %eax,%edx
   42561:	89 d0                	mov    %edx,%eax
   42563:	c1 e0 03             	shl    $0x3,%eax
   42566:	01 d0                	add    %edx,%eax
   42568:	83 c0 0c             	add    $0xc,%eax
   4256b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4256f:	89 c1                	mov    %eax,%ecx
   42571:	48 d3 ea             	shr    %cl,%rdx
   42574:	48 89 d0             	mov    %rdx,%rax
   42577:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   4257c:	c9                   	leave  
   4257d:	c3                   	ret    

000000000004257e <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   4257e:	55                   	push   %rbp
   4257f:	48 89 e5             	mov    %rsp,%rbp
   42582:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   42586:	48 c7 05 6f 1a 01 00 	movq   $0x55000,0x11a6f(%rip)        # 54000 <kernel_pagetable>
   4258d:	00 50 05 00 
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   42591:	ba 00 50 00 00       	mov    $0x5000,%edx
   42596:	be 00 00 00 00       	mov    $0x0,%esi
   4259b:	bf 00 50 05 00       	mov    $0x55000,%edi
   425a0:	e8 75 0a 00 00       	call   4301a <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   425a5:	b8 00 60 05 00       	mov    $0x56000,%eax
   425aa:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   425ae:	48 89 05 4b 2a 01 00 	mov    %rax,0x12a4b(%rip)        # 55000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   425b5:	b8 00 70 05 00       	mov    $0x57000,%eax
   425ba:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   425be:	48 89 05 3b 3a 01 00 	mov    %rax,0x13a3b(%rip)        # 56000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   425c5:	b8 00 80 05 00       	mov    $0x58000,%eax
   425ca:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   425ce:	48 89 05 2b 4a 01 00 	mov    %rax,0x14a2b(%rip)        # 57000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   425d5:	b8 00 90 05 00       	mov    $0x59000,%eax
   425da:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   425de:	48 89 05 23 4a 01 00 	mov    %rax,0x14a23(%rip)        # 57008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   425e5:	48 8b 05 14 1a 01 00 	mov    0x11a14(%rip),%rax        # 54000 <kernel_pagetable>
   425ec:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   425f2:	b9 00 00 20 00       	mov    $0x200000,%ecx
   425f7:	ba 00 00 00 00       	mov    $0x0,%edx
   425fc:	be 00 00 00 00       	mov    $0x0,%esi
   42601:	48 89 c7             	mov    %rax,%rdi
   42604:	e8 b9 01 00 00       	call   427c2 <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42609:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42610:	00 
   42611:	eb 62                	jmp    42675 <virtual_memory_init+0xf7>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   42613:	48 8b 0d e6 19 01 00 	mov    0x119e6(%rip),%rcx        # 54000 <kernel_pagetable>
   4261a:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   4261e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42622:	48 89 ce             	mov    %rcx,%rsi
   42625:	48 89 c7             	mov    %rax,%rdi
   42628:	e8 5b 05 00 00       	call   42b88 <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l1pagetable ?
        assert(vmap.pa == addr);
   4262d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42631:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   42635:	74 14                	je     4264b <virtual_memory_init+0xcd>
   42637:	ba e5 45 04 00       	mov    $0x445e5,%edx
   4263c:	be 2d 00 00 00       	mov    $0x2d,%esi
   42641:	bf f5 45 04 00       	mov    $0x445f5,%edi
   42646:	e8 78 fe ff ff       	call   424c3 <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   4264b:	8b 45 f0             	mov    -0x10(%rbp),%eax
   4264e:	48 98                	cltq   
   42650:	83 e0 03             	and    $0x3,%eax
   42653:	48 83 f8 03          	cmp    $0x3,%rax
   42657:	74 14                	je     4266d <virtual_memory_init+0xef>
   42659:	ba 08 46 04 00       	mov    $0x44608,%edx
   4265e:	be 2e 00 00 00       	mov    $0x2e,%esi
   42663:	bf f5 45 04 00       	mov    $0x445f5,%edi
   42668:	e8 56 fe ff ff       	call   424c3 <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   4266d:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42674:	00 
   42675:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   4267c:	00 
   4267d:	76 94                	jbe    42613 <virtual_memory_init+0x95>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   4267f:	48 8b 05 7a 19 01 00 	mov    0x1197a(%rip),%rax        # 54000 <kernel_pagetable>
   42686:	48 89 c7             	mov    %rax,%rdi
   42689:	e8 03 00 00 00       	call   42691 <set_pagetable>
}
   4268e:	90                   	nop
   4268f:	c9                   	leave  
   42690:	c3                   	ret    

0000000000042691 <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   42691:	55                   	push   %rbp
   42692:	48 89 e5             	mov    %rsp,%rbp
   42695:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   42699:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   4269d:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   426a1:	25 ff 0f 00 00       	and    $0xfff,%eax
   426a6:	48 85 c0             	test   %rax,%rax
   426a9:	74 14                	je     426bf <set_pagetable+0x2e>
   426ab:	ba 35 46 04 00       	mov    $0x44635,%edx
   426b0:	be 3d 00 00 00       	mov    $0x3d,%esi
   426b5:	bf f5 45 04 00       	mov    $0x445f5,%edi
   426ba:	e8 04 fe ff ff       	call   424c3 <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   426bf:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   426c4:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   426c8:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   426cc:	48 89 ce             	mov    %rcx,%rsi
   426cf:	48 89 c7             	mov    %rax,%rdi
   426d2:	e8 b1 04 00 00       	call   42b88 <virtual_memory_lookup>
   426d7:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   426db:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   426e0:	48 39 d0             	cmp    %rdx,%rax
   426e3:	74 14                	je     426f9 <set_pagetable+0x68>
   426e5:	ba 50 46 04 00       	mov    $0x44650,%edx
   426ea:	be 3f 00 00 00       	mov    $0x3f,%esi
   426ef:	bf f5 45 04 00       	mov    $0x445f5,%edi
   426f4:	e8 ca fd ff ff       	call   424c3 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   426f9:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   426fd:	48 8b 0d fc 18 01 00 	mov    0x118fc(%rip),%rcx        # 54000 <kernel_pagetable>
   42704:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   42708:	48 89 ce             	mov    %rcx,%rsi
   4270b:	48 89 c7             	mov    %rax,%rdi
   4270e:	e8 75 04 00 00       	call   42b88 <virtual_memory_lookup>
   42713:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42717:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   4271b:	48 39 c2             	cmp    %rax,%rdx
   4271e:	74 14                	je     42734 <set_pagetable+0xa3>
   42720:	ba b8 46 04 00       	mov    $0x446b8,%edx
   42725:	be 41 00 00 00       	mov    $0x41,%esi
   4272a:	bf f5 45 04 00       	mov    $0x445f5,%edi
   4272f:	e8 8f fd ff ff       	call   424c3 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   42734:	48 8b 05 c5 18 01 00 	mov    0x118c5(%rip),%rax        # 54000 <kernel_pagetable>
   4273b:	48 89 c2             	mov    %rax,%rdx
   4273e:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   42742:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42746:	48 89 ce             	mov    %rcx,%rsi
   42749:	48 89 c7             	mov    %rax,%rdi
   4274c:	e8 37 04 00 00       	call   42b88 <virtual_memory_lookup>
   42751:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42755:	48 8b 15 a4 18 01 00 	mov    0x118a4(%rip),%rdx        # 54000 <kernel_pagetable>
   4275c:	48 39 d0             	cmp    %rdx,%rax
   4275f:	74 14                	je     42775 <set_pagetable+0xe4>
   42761:	ba 18 47 04 00       	mov    $0x44718,%edx
   42766:	be 43 00 00 00       	mov    $0x43,%esi
   4276b:	bf f5 45 04 00       	mov    $0x445f5,%edi
   42770:	e8 4e fd ff ff       	call   424c3 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   42775:	ba c2 27 04 00       	mov    $0x427c2,%edx
   4277a:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   4277e:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42782:	48 89 ce             	mov    %rcx,%rsi
   42785:	48 89 c7             	mov    %rax,%rdi
   42788:	e8 fb 03 00 00       	call   42b88 <virtual_memory_lookup>
   4278d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42791:	ba c2 27 04 00       	mov    $0x427c2,%edx
   42796:	48 39 d0             	cmp    %rdx,%rax
   42799:	74 14                	je     427af <set_pagetable+0x11e>
   4279b:	ba 80 47 04 00       	mov    $0x44780,%edx
   427a0:	be 45 00 00 00       	mov    $0x45,%esi
   427a5:	bf f5 45 04 00       	mov    $0x445f5,%edi
   427aa:	e8 14 fd ff ff       	call   424c3 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   427af:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   427b3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   427b7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   427bb:	0f 22 d8             	mov    %rax,%cr3
}
   427be:	90                   	nop
}
   427bf:	90                   	nop
   427c0:	c9                   	leave  
   427c1:	c3                   	ret    

00000000000427c2 <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   427c2:	55                   	push   %rbp
   427c3:	48 89 e5             	mov    %rsp,%rbp
   427c6:	41 54                	push   %r12
   427c8:	53                   	push   %rbx
   427c9:	48 83 ec 50          	sub    $0x50,%rsp
   427cd:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   427d1:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   427d5:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   427d9:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
   427dd:	44 89 45 ac          	mov    %r8d,-0x54(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   427e1:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   427e5:	25 ff 0f 00 00       	and    $0xfff,%eax
   427ea:	48 85 c0             	test   %rax,%rax
   427ed:	74 14                	je     42803 <virtual_memory_map+0x41>
   427ef:	ba e6 47 04 00       	mov    $0x447e6,%edx
   427f4:	be 66 00 00 00       	mov    $0x66,%esi
   427f9:	bf f5 45 04 00       	mov    $0x445f5,%edi
   427fe:	e8 c0 fc ff ff       	call   424c3 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   42803:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42807:	25 ff 0f 00 00       	and    $0xfff,%eax
   4280c:	48 85 c0             	test   %rax,%rax
   4280f:	74 14                	je     42825 <virtual_memory_map+0x63>
   42811:	ba f9 47 04 00       	mov    $0x447f9,%edx
   42816:	be 67 00 00 00       	mov    $0x67,%esi
   4281b:	bf f5 45 04 00       	mov    $0x445f5,%edi
   42820:	e8 9e fc ff ff       	call   424c3 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   42825:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42829:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   4282d:	48 01 d0             	add    %rdx,%rax
   42830:	48 3b 45 c0          	cmp    -0x40(%rbp),%rax
   42834:	73 24                	jae    4285a <virtual_memory_map+0x98>
   42836:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   4283a:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   4283e:	48 01 d0             	add    %rdx,%rax
   42841:	48 85 c0             	test   %rax,%rax
   42844:	74 14                	je     4285a <virtual_memory_map+0x98>
   42846:	ba 0c 48 04 00       	mov    $0x4480c,%edx
   4284b:	be 68 00 00 00       	mov    $0x68,%esi
   42850:	bf f5 45 04 00       	mov    $0x445f5,%edi
   42855:	e8 69 fc ff ff       	call   424c3 <assert_fail>
    if (perm & PTE_P) {
   4285a:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4285d:	48 98                	cltq   
   4285f:	83 e0 01             	and    $0x1,%eax
   42862:	48 85 c0             	test   %rax,%rax
   42865:	74 6e                	je     428d5 <virtual_memory_map+0x113>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   42867:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4286b:	25 ff 0f 00 00       	and    $0xfff,%eax
   42870:	48 85 c0             	test   %rax,%rax
   42873:	74 14                	je     42889 <virtual_memory_map+0xc7>
   42875:	ba 2a 48 04 00       	mov    $0x4482a,%edx
   4287a:	be 6a 00 00 00       	mov    $0x6a,%esi
   4287f:	bf f5 45 04 00       	mov    $0x445f5,%edi
   42884:	e8 3a fc ff ff       	call   424c3 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   42889:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   4288d:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42891:	48 01 d0             	add    %rdx,%rax
   42894:	48 3b 45 b8          	cmp    -0x48(%rbp),%rax
   42898:	73 14                	jae    428ae <virtual_memory_map+0xec>
   4289a:	ba 3d 48 04 00       	mov    $0x4483d,%edx
   4289f:	be 6b 00 00 00       	mov    $0x6b,%esi
   428a4:	bf f5 45 04 00       	mov    $0x445f5,%edi
   428a9:	e8 15 fc ff ff       	call   424c3 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   428ae:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   428b2:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   428b6:	48 01 d0             	add    %rdx,%rax
   428b9:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   428bf:	76 14                	jbe    428d5 <virtual_memory_map+0x113>
   428c1:	ba 4b 48 04 00       	mov    $0x4484b,%edx
   428c6:	be 6c 00 00 00       	mov    $0x6c,%esi
   428cb:	bf f5 45 04 00       	mov    $0x445f5,%edi
   428d0:	e8 ee fb ff ff       	call   424c3 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   428d5:	83 7d ac 00          	cmpl   $0x0,-0x54(%rbp)
   428d9:	78 09                	js     428e4 <virtual_memory_map+0x122>
   428db:	81 7d ac ff 0f 00 00 	cmpl   $0xfff,-0x54(%rbp)
   428e2:	7e 14                	jle    428f8 <virtual_memory_map+0x136>
   428e4:	ba 67 48 04 00       	mov    $0x44867,%edx
   428e9:	be 6e 00 00 00       	mov    $0x6e,%esi
   428ee:	bf f5 45 04 00       	mov    $0x445f5,%edi
   428f3:	e8 cb fb ff ff       	call   424c3 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   428f8:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   428fc:	25 ff 0f 00 00       	and    $0xfff,%eax
   42901:	48 85 c0             	test   %rax,%rax
   42904:	74 14                	je     4291a <virtual_memory_map+0x158>
   42906:	ba 88 48 04 00       	mov    $0x44888,%edx
   4290b:	be 6f 00 00 00       	mov    $0x6f,%esi
   42910:	bf f5 45 04 00       	mov    $0x445f5,%edi
   42915:	e8 a9 fb ff ff       	call   424c3 <assert_fail>

    int last_index123 = -1;
   4291a:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%rbp)
    x86_64_pagetable* l1pagetable = NULL;
   42921:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
   42928:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42929:	e9 e7 00 00 00       	jmp    42a15 <virtual_memory_map+0x253>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   4292e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42932:	48 c1 e8 15          	shr    $0x15,%rax
   42936:	89 45 dc             	mov    %eax,-0x24(%rbp)
        if (cur_index123 != last_index123) {
   42939:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4293c:	3b 45 ec             	cmp    -0x14(%rbp),%eax
   4293f:	74 20                	je     42961 <virtual_memory_map+0x19f>
            // TODO --> done
            // find pointer to last level pagetable for current va

			l1pagetable = lookup_l1pagetable(pagetable, va, perm);	
   42941:	8b 55 ac             	mov    -0x54(%rbp),%edx
   42944:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   42948:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4294c:	48 89 ce             	mov    %rcx,%rsi
   4294f:	48 89 c7             	mov    %rax,%rdi
   42952:	e8 d7 00 00 00       	call   42a2e <lookup_l1pagetable>
   42957:	48 89 45 e0          	mov    %rax,-0x20(%rbp)

            last_index123 = cur_index123;
   4295b:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4295e:	89 45 ec             	mov    %eax,-0x14(%rbp)
        }
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   42961:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42964:	48 98                	cltq   
   42966:	83 e0 01             	and    $0x1,%eax
   42969:	48 85 c0             	test   %rax,%rax
   4296c:	74 3a                	je     429a8 <virtual_memory_map+0x1e6>
   4296e:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42973:	74 33                	je     429a8 <virtual_memory_map+0x1e6>
            // TODO --> done
            // map `pa` at appropriate entry with permissions `perm`
			l1pagetable->entry[L1PAGEINDEX(va)] =  (0x00000000FFFFFFFF & pa) | perm;
   42975:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42979:	41 89 c4             	mov    %eax,%r12d
   4297c:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4297f:	48 63 d8             	movslq %eax,%rbx
   42982:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42986:	be 03 00 00 00       	mov    $0x3,%esi
   4298b:	48 89 c7             	mov    %rax,%rdi
   4298e:	e8 95 fb ff ff       	call   42528 <pageindex>
   42993:	89 c2                	mov    %eax,%edx
   42995:	4c 89 e1             	mov    %r12,%rcx
   42998:	48 09 d9             	or     %rbx,%rcx
   4299b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4299f:	48 63 d2             	movslq %edx,%rdx
   429a2:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   429a6:	eb 55                	jmp    429fd <virtual_memory_map+0x23b>

        } else if (l1pagetable) { // if page is NOT marked present
   429a8:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   429ad:	74 26                	je     429d5 <virtual_memory_map+0x213>
            // TODO --> done
            // map to address 0 with `perm`
			l1pagetable->entry[L1PAGEINDEX(va)] = 0 | perm;
   429af:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   429b3:	be 03 00 00 00       	mov    $0x3,%esi
   429b8:	48 89 c7             	mov    %rax,%rdi
   429bb:	e8 68 fb ff ff       	call   42528 <pageindex>
   429c0:	89 c2                	mov    %eax,%edx
   429c2:	8b 45 ac             	mov    -0x54(%rbp),%eax
   429c5:	48 63 c8             	movslq %eax,%rcx
   429c8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   429cc:	48 63 d2             	movslq %edx,%rdx
   429cf:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   429d3:	eb 28                	jmp    429fd <virtual_memory_map+0x23b>

        } else if (perm & PTE_P) {
   429d5:	8b 45 ac             	mov    -0x54(%rbp),%eax
   429d8:	48 98                	cltq   
   429da:	83 e0 01             	and    $0x1,%eax
   429dd:	48 85 c0             	test   %rax,%rax
   429e0:	74 1b                	je     429fd <virtual_memory_map+0x23b>
            // error, no allocated l1 page found for va
            log_printf("[Kern Info] failed to find l1pagetable address at " __FILE__ ": %d\n", __LINE__);
   429e2:	be 8b 00 00 00       	mov    $0x8b,%esi
   429e7:	bf b0 48 04 00       	mov    $0x448b0,%edi
   429ec:	b8 00 00 00 00       	mov    $0x0,%eax
   429f1:	e8 af f7 ff ff       	call   421a5 <log_printf>
            return -1;
   429f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   429fb:	eb 28                	jmp    42a25 <virtual_memory_map+0x263>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   429fd:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
   42a04:	00 
   42a05:	48 81 45 b8 00 10 00 	addq   $0x1000,-0x48(%rbp)
   42a0c:	00 
   42a0d:	48 81 6d b0 00 10 00 	subq   $0x1000,-0x50(%rbp)
   42a14:	00 
   42a15:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   42a1a:	0f 85 0e ff ff ff    	jne    4292e <virtual_memory_map+0x16c>
        }
    }
    return 0;
   42a20:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42a25:	48 83 c4 50          	add    $0x50,%rsp
   42a29:	5b                   	pop    %rbx
   42a2a:	41 5c                	pop    %r12
   42a2c:	5d                   	pop    %rbp
   42a2d:	c3                   	ret    

0000000000042a2e <lookup_l1pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   42a2e:	55                   	push   %rbp
   42a2f:	48 89 e5             	mov    %rsp,%rbp
   42a32:	48 83 ec 40          	sub    $0x40,%rsp
   42a36:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42a3a:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42a3e:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   42a41:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42a45:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l1 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   42a49:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   42a50:	e9 23 01 00 00       	jmp    42b78 <lookup_l1pagetable+0x14a>
        // TODO --> done
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        x86_64_pageentry_t pe = pt->entry[PAGEINDEX(va, i)]; // replace this
   42a55:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42a58:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42a5c:	89 d6                	mov    %edx,%esi
   42a5e:	48 89 c7             	mov    %rax,%rdi
   42a61:	e8 c2 fa ff ff       	call   42528 <pageindex>
   42a66:	89 c2                	mov    %eax,%edx
   42a68:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42a6c:	48 63 d2             	movslq %edx,%rdx
   42a6f:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   42a73:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   42a77:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42a7b:	83 e0 01             	and    $0x1,%eax
   42a7e:	48 85 c0             	test   %rax,%rax
   42a81:	75 63                	jne    42ae6 <lookup_l1pagetable+0xb8>
            log_printf("[Kern Info] Error looking up l1pagetable: Pagetable address: 0x%x perm: 0x%x."
   42a83:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42a86:	8d 48 02             	lea    0x2(%rax),%ecx
   42a89:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42a8d:	25 ff 0f 00 00       	and    $0xfff,%eax
   42a92:	48 89 c2             	mov    %rax,%rdx
   42a95:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42a99:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42a9f:	48 89 c6             	mov    %rax,%rsi
   42aa2:	bf f8 48 04 00       	mov    $0x448f8,%edi
   42aa7:	b8 00 00 00 00       	mov    $0x0,%eax
   42aac:	e8 f4 f6 ff ff       	call   421a5 <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   42ab1:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42ab4:	48 98                	cltq   
   42ab6:	83 e0 01             	and    $0x1,%eax
   42ab9:	48 85 c0             	test   %rax,%rax
   42abc:	75 0a                	jne    42ac8 <lookup_l1pagetable+0x9a>
                return NULL;
   42abe:	b8 00 00 00 00       	mov    $0x0,%eax
   42ac3:	e9 be 00 00 00       	jmp    42b86 <lookup_l1pagetable+0x158>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   42ac8:	be af 00 00 00       	mov    $0xaf,%esi
   42acd:	bf 60 49 04 00       	mov    $0x44960,%edi
   42ad2:	b8 00 00 00 00       	mov    $0x0,%eax
   42ad7:	e8 c9 f6 ff ff       	call   421a5 <log_printf>
            return NULL;
   42adc:	b8 00 00 00 00       	mov    $0x0,%eax
   42ae1:	e9 a0 00 00 00       	jmp    42b86 <lookup_l1pagetable+0x158>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   42ae6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42aea:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42af0:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   42af6:	76 14                	jbe    42b0c <lookup_l1pagetable+0xde>
   42af8:	ba a8 49 04 00       	mov    $0x449a8,%edx
   42afd:	be b4 00 00 00       	mov    $0xb4,%esi
   42b02:	bf f5 45 04 00       	mov    $0x445f5,%edi
   42b07:	e8 b7 f9 ff ff       	call   424c3 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   42b0c:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42b0f:	48 98                	cltq   
   42b11:	83 e0 02             	and    $0x2,%eax
   42b14:	48 85 c0             	test   %rax,%rax
   42b17:	74 20                	je     42b39 <lookup_l1pagetable+0x10b>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   42b19:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b1d:	83 e0 02             	and    $0x2,%eax
   42b20:	48 85 c0             	test   %rax,%rax
   42b23:	75 14                	jne    42b39 <lookup_l1pagetable+0x10b>
   42b25:	ba c8 49 04 00       	mov    $0x449c8,%edx
   42b2a:	be b6 00 00 00       	mov    $0xb6,%esi
   42b2f:	bf f5 45 04 00       	mov    $0x445f5,%edi
   42b34:	e8 8a f9 ff ff       	call   424c3 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   42b39:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42b3c:	48 98                	cltq   
   42b3e:	83 e0 04             	and    $0x4,%eax
   42b41:	48 85 c0             	test   %rax,%rax
   42b44:	74 20                	je     42b66 <lookup_l1pagetable+0x138>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   42b46:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b4a:	83 e0 04             	and    $0x4,%eax
   42b4d:	48 85 c0             	test   %rax,%rax
   42b50:	75 14                	jne    42b66 <lookup_l1pagetable+0x138>
   42b52:	ba d3 49 04 00       	mov    $0x449d3,%edx
   42b57:	be b9 00 00 00       	mov    $0xb9,%esi
   42b5c:	bf f5 45 04 00       	mov    $0x445f5,%edi
   42b61:	e8 5d f9 ff ff       	call   424c3 <assert_fail>
        }

        // TODO --> done
        // set pt to physical address to next pagetable using `pe`
        pt = (x86_64_pagetable *) PTE_ADDR(pe); // replace this
   42b66:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b6a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42b70:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   42b74:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   42b78:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   42b7c:	0f 8e d3 fe ff ff    	jle    42a55 <lookup_l1pagetable+0x27>
    }
    return pt;
   42b82:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   42b86:	c9                   	leave  
   42b87:	c3                   	ret    

0000000000042b88 <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   42b88:	55                   	push   %rbp
   42b89:	48 89 e5             	mov    %rsp,%rbp
   42b8c:	48 83 ec 50          	sub    $0x50,%rsp
   42b90:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42b94:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42b98:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   42b9c:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42ba0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   42ba4:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   42bab:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42bac:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   42bb3:	eb 41                	jmp    42bf6 <virtual_memory_lookup+0x6e>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   42bb5:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42bb8:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42bbc:	89 d6                	mov    %edx,%esi
   42bbe:	48 89 c7             	mov    %rax,%rdi
   42bc1:	e8 62 f9 ff ff       	call   42528 <pageindex>
   42bc6:	89 c2                	mov    %eax,%edx
   42bc8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42bcc:	48 63 d2             	movslq %edx,%rdx
   42bcf:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   42bd3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42bd7:	83 e0 06             	and    $0x6,%eax
   42bda:	48 f7 d0             	not    %rax
   42bdd:	48 21 d0             	and    %rdx,%rax
   42be0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42be4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42be8:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42bee:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42bf2:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   42bf6:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   42bfa:	7f 0c                	jg     42c08 <virtual_memory_lookup+0x80>
   42bfc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c00:	83 e0 01             	and    $0x1,%eax
   42c03:	48 85 c0             	test   %rax,%rax
   42c06:	75 ad                	jne    42bb5 <virtual_memory_lookup+0x2d>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   42c08:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   42c0f:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   42c16:	ff 
   42c17:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   42c1e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c22:	83 e0 01             	and    $0x1,%eax
   42c25:	48 85 c0             	test   %rax,%rax
   42c28:	74 34                	je     42c5e <virtual_memory_lookup+0xd6>
        vam.pn = PAGENUMBER(pe);
   42c2a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c2e:	48 c1 e8 0c          	shr    $0xc,%rax
   42c32:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   42c35:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c39:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42c3f:	48 89 c2             	mov    %rax,%rdx
   42c42:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42c46:	25 ff 0f 00 00       	and    $0xfff,%eax
   42c4b:	48 09 d0             	or     %rdx,%rax
   42c4e:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   42c52:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c56:	25 ff 0f 00 00       	and    $0xfff,%eax
   42c5b:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   42c5e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42c62:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42c66:	48 89 10             	mov    %rdx,(%rax)
   42c69:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   42c6d:	48 89 50 08          	mov    %rdx,0x8(%rax)
   42c71:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42c75:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   42c79:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42c7d:	c9                   	leave  
   42c7e:	c3                   	ret    

0000000000042c7f <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   42c7f:	55                   	push   %rbp
   42c80:	48 89 e5             	mov    %rsp,%rbp
   42c83:	48 83 ec 40          	sub    $0x40,%rsp
   42c87:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42c8b:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   42c8e:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   42c92:	c7 45 f8 07 00 00 00 	movl   $0x7,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   42c99:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   42c9d:	78 08                	js     42ca7 <program_load+0x28>
   42c9f:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42ca2:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   42ca5:	7c 14                	jl     42cbb <program_load+0x3c>
   42ca7:	ba e0 49 04 00       	mov    $0x449e0,%edx
   42cac:	be 37 00 00 00       	mov    $0x37,%esi
   42cb1:	bf 10 4a 04 00       	mov    $0x44a10,%edi
   42cb6:	e8 08 f8 ff ff       	call   424c3 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   42cbb:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42cbe:	48 98                	cltq   
   42cc0:	48 c1 e0 04          	shl    $0x4,%rax
   42cc4:	48 05 20 50 04 00    	add    $0x45020,%rax
   42cca:	48 8b 00             	mov    (%rax),%rax
   42ccd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   42cd1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42cd5:	8b 00                	mov    (%rax),%eax
   42cd7:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   42cdc:	74 14                	je     42cf2 <program_load+0x73>
   42cde:	ba 22 4a 04 00       	mov    $0x44a22,%edx
   42ce3:	be 39 00 00 00       	mov    $0x39,%esi
   42ce8:	bf 10 4a 04 00       	mov    $0x44a10,%edi
   42ced:	e8 d1 f7 ff ff       	call   424c3 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   42cf2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42cf6:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42cfa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42cfe:	48 01 d0             	add    %rdx,%rax
   42d01:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   42d05:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42d0c:	e9 94 00 00 00       	jmp    42da5 <program_load+0x126>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   42d11:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42d14:	48 63 d0             	movslq %eax,%rdx
   42d17:	48 89 d0             	mov    %rdx,%rax
   42d1a:	48 c1 e0 03          	shl    $0x3,%rax
   42d1e:	48 29 d0             	sub    %rdx,%rax
   42d21:	48 c1 e0 03          	shl    $0x3,%rax
   42d25:	48 89 c2             	mov    %rax,%rdx
   42d28:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d2c:	48 01 d0             	add    %rdx,%rax
   42d2f:	8b 00                	mov    (%rax),%eax
   42d31:	83 f8 01             	cmp    $0x1,%eax
   42d34:	75 6b                	jne    42da1 <program_load+0x122>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   42d36:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42d39:	48 63 d0             	movslq %eax,%rdx
   42d3c:	48 89 d0             	mov    %rdx,%rax
   42d3f:	48 c1 e0 03          	shl    $0x3,%rax
   42d43:	48 29 d0             	sub    %rdx,%rax
   42d46:	48 c1 e0 03          	shl    $0x3,%rax
   42d4a:	48 89 c2             	mov    %rax,%rdx
   42d4d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d51:	48 01 d0             	add    %rdx,%rax
   42d54:	48 8b 50 08          	mov    0x8(%rax),%rdx
   42d58:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d5c:	48 01 d0             	add    %rdx,%rax
   42d5f:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   42d63:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42d66:	48 63 d0             	movslq %eax,%rdx
   42d69:	48 89 d0             	mov    %rdx,%rax
   42d6c:	48 c1 e0 03          	shl    $0x3,%rax
   42d70:	48 29 d0             	sub    %rdx,%rax
   42d73:	48 c1 e0 03          	shl    $0x3,%rax
   42d77:	48 89 c2             	mov    %rax,%rdx
   42d7a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d7e:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   42d82:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42d86:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42d8a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42d8e:	48 89 c7             	mov    %rax,%rdi
   42d91:	e8 3d 00 00 00       	call   42dd3 <program_load_segment>
   42d96:	85 c0                	test   %eax,%eax
   42d98:	79 07                	jns    42da1 <program_load+0x122>
                return -1;
   42d9a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42d9f:	eb 30                	jmp    42dd1 <program_load+0x152>
    for (int i = 0; i < eh->e_phnum; ++i) {
   42da1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   42da5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42da9:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   42dad:	0f b7 c0             	movzwl %ax,%eax
   42db0:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   42db3:	0f 8c 58 ff ff ff    	jl     42d11 <program_load+0x92>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   42db9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42dbd:	48 8b 50 18          	mov    0x18(%rax),%rdx
   42dc1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42dc5:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    return 0;
   42dcc:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42dd1:	c9                   	leave  
   42dd2:	c3                   	ret    

0000000000042dd3 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   42dd3:	55                   	push   %rbp
   42dd4:	48 89 e5             	mov    %rsp,%rbp
   42dd7:	48 83 ec 40          	sub    $0x40,%rsp
   42ddb:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42ddf:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42de3:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   42de7:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   42deb:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42def:	48 8b 40 10          	mov    0x10(%rax),%rax
   42df3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   42df7:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42dfb:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42dff:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e03:	48 01 d0             	add    %rdx,%rax
   42e06:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42e0a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42e0e:	48 8b 50 28          	mov    0x28(%rax),%rdx
   42e12:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e16:	48 01 d0             	add    %rdx,%rax
   42e19:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   42e1d:	48 81 65 f0 00 f0 ff 	andq   $0xfffffffffffff000,-0x10(%rbp)
   42e24:	ff 

    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42e25:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e29:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   42e2d:	eb 7c                	jmp    42eab <program_load_segment+0xd8>
        if (assign_physical_page(addr, p->p_pid) < 0
   42e2f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e33:	8b 00                	mov    (%rax),%eax
   42e35:	0f be d0             	movsbl %al,%edx
   42e38:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42e3c:	89 d6                	mov    %edx,%esi
   42e3e:	48 89 c7             	mov    %rax,%rdi
   42e41:	e8 b9 d7 ff ff       	call   405ff <assign_physical_page>
   42e46:	85 c0                	test   %eax,%eax
   42e48:	78 2a                	js     42e74 <program_load_segment+0xa1>
            || virtual_memory_map(p->p_pagetable, addr, addr, PAGESIZE,
   42e4a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e4e:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   42e55:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42e59:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   42e5d:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42e63:	b9 00 10 00 00       	mov    $0x1000,%ecx
   42e68:	48 89 c7             	mov    %rax,%rdi
   42e6b:	e8 52 f9 ff ff       	call   427c2 <virtual_memory_map>
   42e70:	85 c0                	test   %eax,%eax
   42e72:	79 2f                	jns    42ea3 <program_load_segment+0xd0>
                                  PTE_P | PTE_W | PTE_U) < 0) {
            console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   42e74:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e78:	8b 00                	mov    (%rax),%eax
   42e7a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42e7e:	49 89 d0             	mov    %rdx,%r8
   42e81:	89 c1                	mov    %eax,%ecx
   42e83:	ba 40 4a 04 00       	mov    $0x44a40,%edx
   42e88:	be 00 c0 00 00       	mov    $0xc000,%esi
   42e8d:	bf e0 06 00 00       	mov    $0x6e0,%edi
   42e92:	b8 00 00 00 00       	mov    $0x0,%eax
   42e97:	e8 35 0f 00 00       	call   43dd1 <console_printf>
            return -1;
   42e9c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42ea1:	eb 77                	jmp    42f1a <program_load_segment+0x147>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42ea3:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42eaa:	00 
   42eab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42eaf:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   42eb3:	0f 82 76 ff ff ff    	jb     42e2f <program_load_segment+0x5c>
        }
    }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   42eb9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42ebd:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   42ec4:	48 89 c7             	mov    %rax,%rdi
   42ec7:	e8 c5 f7 ff ff       	call   42691 <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   42ecc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ed0:	48 2b 45 f0          	sub    -0x10(%rbp),%rax
   42ed4:	48 89 c2             	mov    %rax,%rdx
   42ed7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42edb:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42edf:	48 89 ce             	mov    %rcx,%rsi
   42ee2:	48 89 c7             	mov    %rax,%rdi
   42ee5:	e8 32 00 00 00       	call   42f1c <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   42eea:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42eee:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   42ef2:	48 89 c2             	mov    %rax,%rdx
   42ef5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ef9:	be 00 00 00 00       	mov    $0x0,%esi
   42efe:	48 89 c7             	mov    %rax,%rdi
   42f01:	e8 14 01 00 00       	call   4301a <memset>

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   42f06:	48 8b 05 f3 10 01 00 	mov    0x110f3(%rip),%rax        # 54000 <kernel_pagetable>
   42f0d:	48 89 c7             	mov    %rax,%rdi
   42f10:	e8 7c f7 ff ff       	call   42691 <set_pagetable>
    return 0;
   42f15:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42f1a:	c9                   	leave  
   42f1b:	c3                   	ret    

0000000000042f1c <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   42f1c:	55                   	push   %rbp
   42f1d:	48 89 e5             	mov    %rsp,%rbp
   42f20:	48 83 ec 28          	sub    $0x28,%rsp
   42f24:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42f28:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   42f2c:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   42f30:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42f34:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   42f38:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f3c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   42f40:	eb 1c                	jmp    42f5e <memcpy+0x42>
        *d = *s;
   42f42:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42f46:	0f b6 10             	movzbl (%rax),%edx
   42f49:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42f4d:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   42f4f:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   42f54:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   42f59:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   42f5e:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   42f63:	75 dd                	jne    42f42 <memcpy+0x26>
    }
    return dst;
   42f65:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   42f69:	c9                   	leave  
   42f6a:	c3                   	ret    

0000000000042f6b <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   42f6b:	55                   	push   %rbp
   42f6c:	48 89 e5             	mov    %rsp,%rbp
   42f6f:	48 83 ec 28          	sub    $0x28,%rsp
   42f73:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42f77:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   42f7b:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   42f7f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42f83:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   42f87:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f8b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   42f8f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42f93:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   42f97:	73 6a                	jae    43003 <memmove+0x98>
   42f99:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42f9d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42fa1:	48 01 d0             	add    %rdx,%rax
   42fa4:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   42fa8:	73 59                	jae    43003 <memmove+0x98>
        s += n, d += n;
   42faa:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42fae:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   42fb2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42fb6:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   42fba:	eb 17                	jmp    42fd3 <memmove+0x68>
            *--d = *--s;
   42fbc:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   42fc1:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   42fc6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42fca:	0f b6 10             	movzbl (%rax),%edx
   42fcd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42fd1:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   42fd3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42fd7:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   42fdb:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   42fdf:	48 85 c0             	test   %rax,%rax
   42fe2:	75 d8                	jne    42fbc <memmove+0x51>
    if (s < d && s + n > d) {
   42fe4:	eb 2e                	jmp    43014 <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   42fe6:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42fea:	48 8d 42 01          	lea    0x1(%rdx),%rax
   42fee:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   42ff2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ff6:	48 8d 48 01          	lea    0x1(%rax),%rcx
   42ffa:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   42ffe:	0f b6 12             	movzbl (%rdx),%edx
   43001:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43003:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43007:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   4300b:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   4300f:	48 85 c0             	test   %rax,%rax
   43012:	75 d2                	jne    42fe6 <memmove+0x7b>
        }
    }
    return dst;
   43014:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43018:	c9                   	leave  
   43019:	c3                   	ret    

000000000004301a <memset>:

void* memset(void* v, int c, size_t n) {
   4301a:	55                   	push   %rbp
   4301b:	48 89 e5             	mov    %rsp,%rbp
   4301e:	48 83 ec 28          	sub    $0x28,%rsp
   43022:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43026:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   43029:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   4302d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43031:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43035:	eb 15                	jmp    4304c <memset+0x32>
        *p = c;
   43037:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4303a:	89 c2                	mov    %eax,%edx
   4303c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43040:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43042:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43047:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   4304c:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43051:	75 e4                	jne    43037 <memset+0x1d>
    }
    return v;
   43053:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43057:	c9                   	leave  
   43058:	c3                   	ret    

0000000000043059 <strlen>:

size_t strlen(const char* s) {
   43059:	55                   	push   %rbp
   4305a:	48 89 e5             	mov    %rsp,%rbp
   4305d:	48 83 ec 18          	sub    $0x18,%rsp
   43061:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   43065:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   4306c:	00 
   4306d:	eb 0a                	jmp    43079 <strlen+0x20>
        ++n;
   4306f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   43074:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43079:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4307d:	0f b6 00             	movzbl (%rax),%eax
   43080:	84 c0                	test   %al,%al
   43082:	75 eb                	jne    4306f <strlen+0x16>
    }
    return n;
   43084:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43088:	c9                   	leave  
   43089:	c3                   	ret    

000000000004308a <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   4308a:	55                   	push   %rbp
   4308b:	48 89 e5             	mov    %rsp,%rbp
   4308e:	48 83 ec 20          	sub    $0x20,%rsp
   43092:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43096:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   4309a:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   430a1:	00 
   430a2:	eb 0a                	jmp    430ae <strnlen+0x24>
        ++n;
   430a4:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   430a9:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   430ae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   430b2:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   430b6:	74 0b                	je     430c3 <strnlen+0x39>
   430b8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   430bc:	0f b6 00             	movzbl (%rax),%eax
   430bf:	84 c0                	test   %al,%al
   430c1:	75 e1                	jne    430a4 <strnlen+0x1a>
    }
    return n;
   430c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   430c7:	c9                   	leave  
   430c8:	c3                   	ret    

00000000000430c9 <strcpy>:

char* strcpy(char* dst, const char* src) {
   430c9:	55                   	push   %rbp
   430ca:	48 89 e5             	mov    %rsp,%rbp
   430cd:	48 83 ec 20          	sub    $0x20,%rsp
   430d1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   430d5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   430d9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   430dd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   430e1:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   430e5:	48 8d 42 01          	lea    0x1(%rdx),%rax
   430e9:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   430ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   430f1:	48 8d 48 01          	lea    0x1(%rax),%rcx
   430f5:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   430f9:	0f b6 12             	movzbl (%rdx),%edx
   430fc:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   430fe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43102:	48 83 e8 01          	sub    $0x1,%rax
   43106:	0f b6 00             	movzbl (%rax),%eax
   43109:	84 c0                	test   %al,%al
   4310b:	75 d4                	jne    430e1 <strcpy+0x18>
    return dst;
   4310d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43111:	c9                   	leave  
   43112:	c3                   	ret    

0000000000043113 <strcmp>:

int strcmp(const char* a, const char* b) {
   43113:	55                   	push   %rbp
   43114:	48 89 e5             	mov    %rsp,%rbp
   43117:	48 83 ec 10          	sub    $0x10,%rsp
   4311b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4311f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43123:	eb 0a                	jmp    4312f <strcmp+0x1c>
        ++a, ++b;
   43125:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   4312a:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   4312f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43133:	0f b6 00             	movzbl (%rax),%eax
   43136:	84 c0                	test   %al,%al
   43138:	74 1d                	je     43157 <strcmp+0x44>
   4313a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4313e:	0f b6 00             	movzbl (%rax),%eax
   43141:	84 c0                	test   %al,%al
   43143:	74 12                	je     43157 <strcmp+0x44>
   43145:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43149:	0f b6 10             	movzbl (%rax),%edx
   4314c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43150:	0f b6 00             	movzbl (%rax),%eax
   43153:	38 c2                	cmp    %al,%dl
   43155:	74 ce                	je     43125 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   43157:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4315b:	0f b6 00             	movzbl (%rax),%eax
   4315e:	89 c2                	mov    %eax,%edx
   43160:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43164:	0f b6 00             	movzbl (%rax),%eax
   43167:	38 d0                	cmp    %dl,%al
   43169:	0f 92 c0             	setb   %al
   4316c:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   4316f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43173:	0f b6 00             	movzbl (%rax),%eax
   43176:	89 c1                	mov    %eax,%ecx
   43178:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4317c:	0f b6 00             	movzbl (%rax),%eax
   4317f:	38 c1                	cmp    %al,%cl
   43181:	0f 92 c0             	setb   %al
   43184:	0f b6 c0             	movzbl %al,%eax
   43187:	29 c2                	sub    %eax,%edx
   43189:	89 d0                	mov    %edx,%eax
}
   4318b:	c9                   	leave  
   4318c:	c3                   	ret    

000000000004318d <strchr>:

char* strchr(const char* s, int c) {
   4318d:	55                   	push   %rbp
   4318e:	48 89 e5             	mov    %rsp,%rbp
   43191:	48 83 ec 10          	sub    $0x10,%rsp
   43195:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43199:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   4319c:	eb 05                	jmp    431a3 <strchr+0x16>
        ++s;
   4319e:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   431a3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   431a7:	0f b6 00             	movzbl (%rax),%eax
   431aa:	84 c0                	test   %al,%al
   431ac:	74 0e                	je     431bc <strchr+0x2f>
   431ae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   431b2:	0f b6 00             	movzbl (%rax),%eax
   431b5:	8b 55 f4             	mov    -0xc(%rbp),%edx
   431b8:	38 d0                	cmp    %dl,%al
   431ba:	75 e2                	jne    4319e <strchr+0x11>
    }
    if (*s == (char) c) {
   431bc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   431c0:	0f b6 00             	movzbl (%rax),%eax
   431c3:	8b 55 f4             	mov    -0xc(%rbp),%edx
   431c6:	38 d0                	cmp    %dl,%al
   431c8:	75 06                	jne    431d0 <strchr+0x43>
        return (char*) s;
   431ca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   431ce:	eb 05                	jmp    431d5 <strchr+0x48>
    } else {
        return NULL;
   431d0:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   431d5:	c9                   	leave  
   431d6:	c3                   	ret    

00000000000431d7 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   431d7:	55                   	push   %rbp
   431d8:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   431db:	8b 05 1f 6e 01 00    	mov    0x16e1f(%rip),%eax        # 5a000 <rand_seed_set>
   431e1:	85 c0                	test   %eax,%eax
   431e3:	75 0a                	jne    431ef <rand+0x18>
        srand(819234718U);
   431e5:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   431ea:	e8 24 00 00 00       	call   43213 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   431ef:	8b 05 0f 6e 01 00    	mov    0x16e0f(%rip),%eax        # 5a004 <rand_seed>
   431f5:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   431fb:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   43200:	89 05 fe 6d 01 00    	mov    %eax,0x16dfe(%rip)        # 5a004 <rand_seed>
    return rand_seed & RAND_MAX;
   43206:	8b 05 f8 6d 01 00    	mov    0x16df8(%rip),%eax        # 5a004 <rand_seed>
   4320c:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   43211:	5d                   	pop    %rbp
   43212:	c3                   	ret    

0000000000043213 <srand>:

void srand(unsigned seed) {
   43213:	55                   	push   %rbp
   43214:	48 89 e5             	mov    %rsp,%rbp
   43217:	48 83 ec 08          	sub    $0x8,%rsp
   4321b:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   4321e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43221:	89 05 dd 6d 01 00    	mov    %eax,0x16ddd(%rip)        # 5a004 <rand_seed>
    rand_seed_set = 1;
   43227:	c7 05 cf 6d 01 00 01 	movl   $0x1,0x16dcf(%rip)        # 5a000 <rand_seed_set>
   4322e:	00 00 00 
}
   43231:	90                   	nop
   43232:	c9                   	leave  
   43233:	c3                   	ret    

0000000000043234 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   43234:	55                   	push   %rbp
   43235:	48 89 e5             	mov    %rsp,%rbp
   43238:	48 83 ec 28          	sub    $0x28,%rsp
   4323c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43240:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43244:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   43247:	48 c7 45 f8 60 4c 04 	movq   $0x44c60,-0x8(%rbp)
   4324e:	00 
    if (base < 0) {
   4324f:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   43253:	79 0b                	jns    43260 <fill_numbuf+0x2c>
        digits = lower_digits;
   43255:	48 c7 45 f8 80 4c 04 	movq   $0x44c80,-0x8(%rbp)
   4325c:	00 
        base = -base;
   4325d:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   43260:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43265:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43269:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   4326c:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4326f:	48 63 c8             	movslq %eax,%rcx
   43272:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43276:	ba 00 00 00 00       	mov    $0x0,%edx
   4327b:	48 f7 f1             	div    %rcx
   4327e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43282:	48 01 d0             	add    %rdx,%rax
   43285:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   4328a:	0f b6 10             	movzbl (%rax),%edx
   4328d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43291:	88 10                	mov    %dl,(%rax)
        val /= base;
   43293:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43296:	48 63 f0             	movslq %eax,%rsi
   43299:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4329d:	ba 00 00 00 00       	mov    $0x0,%edx
   432a2:	48 f7 f6             	div    %rsi
   432a5:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   432a9:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   432ae:	75 bc                	jne    4326c <fill_numbuf+0x38>
    return numbuf_end;
   432b0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   432b4:	c9                   	leave  
   432b5:	c3                   	ret    

00000000000432b6 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   432b6:	55                   	push   %rbp
   432b7:	48 89 e5             	mov    %rsp,%rbp
   432ba:	53                   	push   %rbx
   432bb:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   432c2:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   432c9:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   432cf:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   432d6:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   432dd:	e9 8a 09 00 00       	jmp    43c6c <printer_vprintf+0x9b6>
        if (*format != '%') {
   432e2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   432e9:	0f b6 00             	movzbl (%rax),%eax
   432ec:	3c 25                	cmp    $0x25,%al
   432ee:	74 31                	je     43321 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
   432f0:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   432f7:	4c 8b 00             	mov    (%rax),%r8
   432fa:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43301:	0f b6 00             	movzbl (%rax),%eax
   43304:	0f b6 c8             	movzbl %al,%ecx
   43307:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   4330d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43314:	89 ce                	mov    %ecx,%esi
   43316:	48 89 c7             	mov    %rax,%rdi
   43319:	41 ff d0             	call   *%r8
            continue;
   4331c:	e9 43 09 00 00       	jmp    43c64 <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
   43321:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   43328:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4332f:	01 
   43330:	eb 44                	jmp    43376 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
   43332:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43339:	0f b6 00             	movzbl (%rax),%eax
   4333c:	0f be c0             	movsbl %al,%eax
   4333f:	89 c6                	mov    %eax,%esi
   43341:	bf 80 4a 04 00       	mov    $0x44a80,%edi
   43346:	e8 42 fe ff ff       	call   4318d <strchr>
   4334b:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   4334f:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   43354:	74 30                	je     43386 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
   43356:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   4335a:	48 2d 80 4a 04 00    	sub    $0x44a80,%rax
   43360:	ba 01 00 00 00       	mov    $0x1,%edx
   43365:	89 c1                	mov    %eax,%ecx
   43367:	d3 e2                	shl    %cl,%edx
   43369:	89 d0                	mov    %edx,%eax
   4336b:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   4336e:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43375:	01 
   43376:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4337d:	0f b6 00             	movzbl (%rax),%eax
   43380:	84 c0                	test   %al,%al
   43382:	75 ae                	jne    43332 <printer_vprintf+0x7c>
   43384:	eb 01                	jmp    43387 <printer_vprintf+0xd1>
            } else {
                break;
   43386:	90                   	nop
            }
        }

        // process width
        int width = -1;
   43387:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   4338e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43395:	0f b6 00             	movzbl (%rax),%eax
   43398:	3c 30                	cmp    $0x30,%al
   4339a:	7e 67                	jle    43403 <printer_vprintf+0x14d>
   4339c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   433a3:	0f b6 00             	movzbl (%rax),%eax
   433a6:	3c 39                	cmp    $0x39,%al
   433a8:	7f 59                	jg     43403 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   433aa:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   433b1:	eb 2e                	jmp    433e1 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
   433b3:	8b 55 e8             	mov    -0x18(%rbp),%edx
   433b6:	89 d0                	mov    %edx,%eax
   433b8:	c1 e0 02             	shl    $0x2,%eax
   433bb:	01 d0                	add    %edx,%eax
   433bd:	01 c0                	add    %eax,%eax
   433bf:	89 c1                	mov    %eax,%ecx
   433c1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   433c8:	48 8d 50 01          	lea    0x1(%rax),%rdx
   433cc:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   433d3:	0f b6 00             	movzbl (%rax),%eax
   433d6:	0f be c0             	movsbl %al,%eax
   433d9:	01 c8                	add    %ecx,%eax
   433db:	83 e8 30             	sub    $0x30,%eax
   433de:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   433e1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   433e8:	0f b6 00             	movzbl (%rax),%eax
   433eb:	3c 2f                	cmp    $0x2f,%al
   433ed:	0f 8e 85 00 00 00    	jle    43478 <printer_vprintf+0x1c2>
   433f3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   433fa:	0f b6 00             	movzbl (%rax),%eax
   433fd:	3c 39                	cmp    $0x39,%al
   433ff:	7e b2                	jle    433b3 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
   43401:	eb 75                	jmp    43478 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
   43403:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4340a:	0f b6 00             	movzbl (%rax),%eax
   4340d:	3c 2a                	cmp    $0x2a,%al
   4340f:	75 68                	jne    43479 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
   43411:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43418:	8b 00                	mov    (%rax),%eax
   4341a:	83 f8 2f             	cmp    $0x2f,%eax
   4341d:	77 30                	ja     4344f <printer_vprintf+0x199>
   4341f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43426:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4342a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43431:	8b 00                	mov    (%rax),%eax
   43433:	89 c0                	mov    %eax,%eax
   43435:	48 01 d0             	add    %rdx,%rax
   43438:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4343f:	8b 12                	mov    (%rdx),%edx
   43441:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43444:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4344b:	89 0a                	mov    %ecx,(%rdx)
   4344d:	eb 1a                	jmp    43469 <printer_vprintf+0x1b3>
   4344f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43456:	48 8b 40 08          	mov    0x8(%rax),%rax
   4345a:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4345e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43465:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43469:	8b 00                	mov    (%rax),%eax
   4346b:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   4346e:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43475:	01 
   43476:	eb 01                	jmp    43479 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
   43478:	90                   	nop
        }

        // process precision
        int precision = -1;
   43479:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   43480:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43487:	0f b6 00             	movzbl (%rax),%eax
   4348a:	3c 2e                	cmp    $0x2e,%al
   4348c:	0f 85 00 01 00 00    	jne    43592 <printer_vprintf+0x2dc>
            ++format;
   43492:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43499:	01 
            if (*format >= '0' && *format <= '9') {
   4349a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   434a1:	0f b6 00             	movzbl (%rax),%eax
   434a4:	3c 2f                	cmp    $0x2f,%al
   434a6:	7e 67                	jle    4350f <printer_vprintf+0x259>
   434a8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   434af:	0f b6 00             	movzbl (%rax),%eax
   434b2:	3c 39                	cmp    $0x39,%al
   434b4:	7f 59                	jg     4350f <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   434b6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   434bd:	eb 2e                	jmp    434ed <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
   434bf:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   434c2:	89 d0                	mov    %edx,%eax
   434c4:	c1 e0 02             	shl    $0x2,%eax
   434c7:	01 d0                	add    %edx,%eax
   434c9:	01 c0                	add    %eax,%eax
   434cb:	89 c1                	mov    %eax,%ecx
   434cd:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   434d4:	48 8d 50 01          	lea    0x1(%rax),%rdx
   434d8:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   434df:	0f b6 00             	movzbl (%rax),%eax
   434e2:	0f be c0             	movsbl %al,%eax
   434e5:	01 c8                	add    %ecx,%eax
   434e7:	83 e8 30             	sub    $0x30,%eax
   434ea:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   434ed:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   434f4:	0f b6 00             	movzbl (%rax),%eax
   434f7:	3c 2f                	cmp    $0x2f,%al
   434f9:	0f 8e 85 00 00 00    	jle    43584 <printer_vprintf+0x2ce>
   434ff:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43506:	0f b6 00             	movzbl (%rax),%eax
   43509:	3c 39                	cmp    $0x39,%al
   4350b:	7e b2                	jle    434bf <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
   4350d:	eb 75                	jmp    43584 <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
   4350f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43516:	0f b6 00             	movzbl (%rax),%eax
   43519:	3c 2a                	cmp    $0x2a,%al
   4351b:	75 68                	jne    43585 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
   4351d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43524:	8b 00                	mov    (%rax),%eax
   43526:	83 f8 2f             	cmp    $0x2f,%eax
   43529:	77 30                	ja     4355b <printer_vprintf+0x2a5>
   4352b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43532:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43536:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4353d:	8b 00                	mov    (%rax),%eax
   4353f:	89 c0                	mov    %eax,%eax
   43541:	48 01 d0             	add    %rdx,%rax
   43544:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4354b:	8b 12                	mov    (%rdx),%edx
   4354d:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43550:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43557:	89 0a                	mov    %ecx,(%rdx)
   43559:	eb 1a                	jmp    43575 <printer_vprintf+0x2bf>
   4355b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43562:	48 8b 40 08          	mov    0x8(%rax),%rax
   43566:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4356a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43571:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43575:	8b 00                	mov    (%rax),%eax
   43577:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   4357a:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43581:	01 
   43582:	eb 01                	jmp    43585 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
   43584:	90                   	nop
            }
            if (precision < 0) {
   43585:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   43589:	79 07                	jns    43592 <printer_vprintf+0x2dc>
                precision = 0;
   4358b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   43592:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   43599:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   435a0:	00 
        int length = 0;
   435a1:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   435a8:	48 c7 45 c8 86 4a 04 	movq   $0x44a86,-0x38(%rbp)
   435af:	00 
    again:
        switch (*format) {
   435b0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   435b7:	0f b6 00             	movzbl (%rax),%eax
   435ba:	0f be c0             	movsbl %al,%eax
   435bd:	83 e8 43             	sub    $0x43,%eax
   435c0:	83 f8 37             	cmp    $0x37,%eax
   435c3:	0f 87 9f 03 00 00    	ja     43968 <printer_vprintf+0x6b2>
   435c9:	89 c0                	mov    %eax,%eax
   435cb:	48 8b 04 c5 98 4a 04 	mov    0x44a98(,%rax,8),%rax
   435d2:	00 
   435d3:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
   435d5:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   435dc:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   435e3:	01 
            goto again;
   435e4:	eb ca                	jmp    435b0 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   435e6:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   435ea:	74 5d                	je     43649 <printer_vprintf+0x393>
   435ec:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   435f3:	8b 00                	mov    (%rax),%eax
   435f5:	83 f8 2f             	cmp    $0x2f,%eax
   435f8:	77 30                	ja     4362a <printer_vprintf+0x374>
   435fa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43601:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43605:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4360c:	8b 00                	mov    (%rax),%eax
   4360e:	89 c0                	mov    %eax,%eax
   43610:	48 01 d0             	add    %rdx,%rax
   43613:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4361a:	8b 12                	mov    (%rdx),%edx
   4361c:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4361f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43626:	89 0a                	mov    %ecx,(%rdx)
   43628:	eb 1a                	jmp    43644 <printer_vprintf+0x38e>
   4362a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43631:	48 8b 40 08          	mov    0x8(%rax),%rax
   43635:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43639:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43640:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43644:	48 8b 00             	mov    (%rax),%rax
   43647:	eb 5c                	jmp    436a5 <printer_vprintf+0x3ef>
   43649:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43650:	8b 00                	mov    (%rax),%eax
   43652:	83 f8 2f             	cmp    $0x2f,%eax
   43655:	77 30                	ja     43687 <printer_vprintf+0x3d1>
   43657:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4365e:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43662:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43669:	8b 00                	mov    (%rax),%eax
   4366b:	89 c0                	mov    %eax,%eax
   4366d:	48 01 d0             	add    %rdx,%rax
   43670:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43677:	8b 12                	mov    (%rdx),%edx
   43679:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4367c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43683:	89 0a                	mov    %ecx,(%rdx)
   43685:	eb 1a                	jmp    436a1 <printer_vprintf+0x3eb>
   43687:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4368e:	48 8b 40 08          	mov    0x8(%rax),%rax
   43692:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43696:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4369d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   436a1:	8b 00                	mov    (%rax),%eax
   436a3:	48 98                	cltq   
   436a5:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   436a9:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   436ad:	48 c1 f8 38          	sar    $0x38,%rax
   436b1:	25 80 00 00 00       	and    $0x80,%eax
   436b6:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   436b9:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   436bd:	74 09                	je     436c8 <printer_vprintf+0x412>
   436bf:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   436c3:	48 f7 d8             	neg    %rax
   436c6:	eb 04                	jmp    436cc <printer_vprintf+0x416>
   436c8:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   436cc:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   436d0:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   436d3:	83 c8 60             	or     $0x60,%eax
   436d6:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   436d9:	e9 cf 02 00 00       	jmp    439ad <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   436de:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   436e2:	74 5d                	je     43741 <printer_vprintf+0x48b>
   436e4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   436eb:	8b 00                	mov    (%rax),%eax
   436ed:	83 f8 2f             	cmp    $0x2f,%eax
   436f0:	77 30                	ja     43722 <printer_vprintf+0x46c>
   436f2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   436f9:	48 8b 50 10          	mov    0x10(%rax),%rdx
   436fd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43704:	8b 00                	mov    (%rax),%eax
   43706:	89 c0                	mov    %eax,%eax
   43708:	48 01 d0             	add    %rdx,%rax
   4370b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43712:	8b 12                	mov    (%rdx),%edx
   43714:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43717:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4371e:	89 0a                	mov    %ecx,(%rdx)
   43720:	eb 1a                	jmp    4373c <printer_vprintf+0x486>
   43722:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43729:	48 8b 40 08          	mov    0x8(%rax),%rax
   4372d:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43731:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43738:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4373c:	48 8b 00             	mov    (%rax),%rax
   4373f:	eb 5c                	jmp    4379d <printer_vprintf+0x4e7>
   43741:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43748:	8b 00                	mov    (%rax),%eax
   4374a:	83 f8 2f             	cmp    $0x2f,%eax
   4374d:	77 30                	ja     4377f <printer_vprintf+0x4c9>
   4374f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43756:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4375a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43761:	8b 00                	mov    (%rax),%eax
   43763:	89 c0                	mov    %eax,%eax
   43765:	48 01 d0             	add    %rdx,%rax
   43768:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4376f:	8b 12                	mov    (%rdx),%edx
   43771:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43774:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4377b:	89 0a                	mov    %ecx,(%rdx)
   4377d:	eb 1a                	jmp    43799 <printer_vprintf+0x4e3>
   4377f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43786:	48 8b 40 08          	mov    0x8(%rax),%rax
   4378a:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4378e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43795:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43799:	8b 00                	mov    (%rax),%eax
   4379b:	89 c0                	mov    %eax,%eax
   4379d:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   437a1:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   437a5:	e9 03 02 00 00       	jmp    439ad <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
   437aa:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   437b1:	e9 28 ff ff ff       	jmp    436de <printer_vprintf+0x428>
        case 'X':
            base = 16;
   437b6:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   437bd:	e9 1c ff ff ff       	jmp    436de <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   437c2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   437c9:	8b 00                	mov    (%rax),%eax
   437cb:	83 f8 2f             	cmp    $0x2f,%eax
   437ce:	77 30                	ja     43800 <printer_vprintf+0x54a>
   437d0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   437d7:	48 8b 50 10          	mov    0x10(%rax),%rdx
   437db:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   437e2:	8b 00                	mov    (%rax),%eax
   437e4:	89 c0                	mov    %eax,%eax
   437e6:	48 01 d0             	add    %rdx,%rax
   437e9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   437f0:	8b 12                	mov    (%rdx),%edx
   437f2:	8d 4a 08             	lea    0x8(%rdx),%ecx
   437f5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   437fc:	89 0a                	mov    %ecx,(%rdx)
   437fe:	eb 1a                	jmp    4381a <printer_vprintf+0x564>
   43800:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43807:	48 8b 40 08          	mov    0x8(%rax),%rax
   4380b:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4380f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43816:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4381a:	48 8b 00             	mov    (%rax),%rax
   4381d:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   43821:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   43828:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   4382f:	e9 79 01 00 00       	jmp    439ad <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
   43834:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4383b:	8b 00                	mov    (%rax),%eax
   4383d:	83 f8 2f             	cmp    $0x2f,%eax
   43840:	77 30                	ja     43872 <printer_vprintf+0x5bc>
   43842:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43849:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4384d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43854:	8b 00                	mov    (%rax),%eax
   43856:	89 c0                	mov    %eax,%eax
   43858:	48 01 d0             	add    %rdx,%rax
   4385b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43862:	8b 12                	mov    (%rdx),%edx
   43864:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43867:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4386e:	89 0a                	mov    %ecx,(%rdx)
   43870:	eb 1a                	jmp    4388c <printer_vprintf+0x5d6>
   43872:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43879:	48 8b 40 08          	mov    0x8(%rax),%rax
   4387d:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43881:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43888:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4388c:	48 8b 00             	mov    (%rax),%rax
   4388f:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   43893:	e9 15 01 00 00       	jmp    439ad <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
   43898:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4389f:	8b 00                	mov    (%rax),%eax
   438a1:	83 f8 2f             	cmp    $0x2f,%eax
   438a4:	77 30                	ja     438d6 <printer_vprintf+0x620>
   438a6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   438ad:	48 8b 50 10          	mov    0x10(%rax),%rdx
   438b1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   438b8:	8b 00                	mov    (%rax),%eax
   438ba:	89 c0                	mov    %eax,%eax
   438bc:	48 01 d0             	add    %rdx,%rax
   438bf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   438c6:	8b 12                	mov    (%rdx),%edx
   438c8:	8d 4a 08             	lea    0x8(%rdx),%ecx
   438cb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   438d2:	89 0a                	mov    %ecx,(%rdx)
   438d4:	eb 1a                	jmp    438f0 <printer_vprintf+0x63a>
   438d6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   438dd:	48 8b 40 08          	mov    0x8(%rax),%rax
   438e1:	48 8d 48 08          	lea    0x8(%rax),%rcx
   438e5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   438ec:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   438f0:	8b 00                	mov    (%rax),%eax
   438f2:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   438f8:	e9 67 03 00 00       	jmp    43c64 <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
   438fd:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43901:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   43905:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4390c:	8b 00                	mov    (%rax),%eax
   4390e:	83 f8 2f             	cmp    $0x2f,%eax
   43911:	77 30                	ja     43943 <printer_vprintf+0x68d>
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
   43941:	eb 1a                	jmp    4395d <printer_vprintf+0x6a7>
   43943:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4394a:	48 8b 40 08          	mov    0x8(%rax),%rax
   4394e:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43952:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43959:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4395d:	8b 00                	mov    (%rax),%eax
   4395f:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   43962:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   43966:	eb 45                	jmp    439ad <printer_vprintf+0x6f7>
        default:
            data = numbuf;
   43968:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   4396c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   43970:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43977:	0f b6 00             	movzbl (%rax),%eax
   4397a:	84 c0                	test   %al,%al
   4397c:	74 0c                	je     4398a <printer_vprintf+0x6d4>
   4397e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43985:	0f b6 00             	movzbl (%rax),%eax
   43988:	eb 05                	jmp    4398f <printer_vprintf+0x6d9>
   4398a:	b8 25 00 00 00       	mov    $0x25,%eax
   4398f:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   43992:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   43996:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4399d:	0f b6 00             	movzbl (%rax),%eax
   439a0:	84 c0                	test   %al,%al
   439a2:	75 08                	jne    439ac <printer_vprintf+0x6f6>
                format--;
   439a4:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   439ab:	01 
            }
            break;
   439ac:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   439ad:	8b 45 ec             	mov    -0x14(%rbp),%eax
   439b0:	83 e0 20             	and    $0x20,%eax
   439b3:	85 c0                	test   %eax,%eax
   439b5:	74 1e                	je     439d5 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   439b7:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   439bb:	48 83 c0 18          	add    $0x18,%rax
   439bf:	8b 55 e0             	mov    -0x20(%rbp),%edx
   439c2:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   439c6:	48 89 ce             	mov    %rcx,%rsi
   439c9:	48 89 c7             	mov    %rax,%rdi
   439cc:	e8 63 f8 ff ff       	call   43234 <fill_numbuf>
   439d1:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   439d5:	48 c7 45 c0 86 4a 04 	movq   $0x44a86,-0x40(%rbp)
   439dc:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   439dd:	8b 45 ec             	mov    -0x14(%rbp),%eax
   439e0:	83 e0 20             	and    $0x20,%eax
   439e3:	85 c0                	test   %eax,%eax
   439e5:	74 48                	je     43a2f <printer_vprintf+0x779>
   439e7:	8b 45 ec             	mov    -0x14(%rbp),%eax
   439ea:	83 e0 40             	and    $0x40,%eax
   439ed:	85 c0                	test   %eax,%eax
   439ef:	74 3e                	je     43a2f <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
   439f1:	8b 45 ec             	mov    -0x14(%rbp),%eax
   439f4:	25 80 00 00 00       	and    $0x80,%eax
   439f9:	85 c0                	test   %eax,%eax
   439fb:	74 0a                	je     43a07 <printer_vprintf+0x751>
                prefix = "-";
   439fd:	48 c7 45 c0 87 4a 04 	movq   $0x44a87,-0x40(%rbp)
   43a04:	00 
            if (flags & FLAG_NEGATIVE) {
   43a05:	eb 73                	jmp    43a7a <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   43a07:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43a0a:	83 e0 10             	and    $0x10,%eax
   43a0d:	85 c0                	test   %eax,%eax
   43a0f:	74 0a                	je     43a1b <printer_vprintf+0x765>
                prefix = "+";
   43a11:	48 c7 45 c0 89 4a 04 	movq   $0x44a89,-0x40(%rbp)
   43a18:	00 
            if (flags & FLAG_NEGATIVE) {
   43a19:	eb 5f                	jmp    43a7a <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   43a1b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43a1e:	83 e0 08             	and    $0x8,%eax
   43a21:	85 c0                	test   %eax,%eax
   43a23:	74 55                	je     43a7a <printer_vprintf+0x7c4>
                prefix = " ";
   43a25:	48 c7 45 c0 8b 4a 04 	movq   $0x44a8b,-0x40(%rbp)
   43a2c:	00 
            if (flags & FLAG_NEGATIVE) {
   43a2d:	eb 4b                	jmp    43a7a <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   43a2f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43a32:	83 e0 20             	and    $0x20,%eax
   43a35:	85 c0                	test   %eax,%eax
   43a37:	74 42                	je     43a7b <printer_vprintf+0x7c5>
   43a39:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43a3c:	83 e0 01             	and    $0x1,%eax
   43a3f:	85 c0                	test   %eax,%eax
   43a41:	74 38                	je     43a7b <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
   43a43:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   43a47:	74 06                	je     43a4f <printer_vprintf+0x799>
   43a49:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   43a4d:	75 2c                	jne    43a7b <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
   43a4f:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43a54:	75 0c                	jne    43a62 <printer_vprintf+0x7ac>
   43a56:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43a59:	25 00 01 00 00       	and    $0x100,%eax
   43a5e:	85 c0                	test   %eax,%eax
   43a60:	74 19                	je     43a7b <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
   43a62:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   43a66:	75 07                	jne    43a6f <printer_vprintf+0x7b9>
   43a68:	b8 8d 4a 04 00       	mov    $0x44a8d,%eax
   43a6d:	eb 05                	jmp    43a74 <printer_vprintf+0x7be>
   43a6f:	b8 90 4a 04 00       	mov    $0x44a90,%eax
   43a74:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   43a78:	eb 01                	jmp    43a7b <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
   43a7a:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   43a7b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   43a7f:	78 24                	js     43aa5 <printer_vprintf+0x7ef>
   43a81:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43a84:	83 e0 20             	and    $0x20,%eax
   43a87:	85 c0                	test   %eax,%eax
   43a89:	75 1a                	jne    43aa5 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
   43a8b:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43a8e:	48 63 d0             	movslq %eax,%rdx
   43a91:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43a95:	48 89 d6             	mov    %rdx,%rsi
   43a98:	48 89 c7             	mov    %rax,%rdi
   43a9b:	e8 ea f5 ff ff       	call   4308a <strnlen>
   43aa0:	89 45 bc             	mov    %eax,-0x44(%rbp)
   43aa3:	eb 0f                	jmp    43ab4 <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
   43aa5:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43aa9:	48 89 c7             	mov    %rax,%rdi
   43aac:	e8 a8 f5 ff ff       	call   43059 <strlen>
   43ab1:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   43ab4:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43ab7:	83 e0 20             	and    $0x20,%eax
   43aba:	85 c0                	test   %eax,%eax
   43abc:	74 20                	je     43ade <printer_vprintf+0x828>
   43abe:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   43ac2:	78 1a                	js     43ade <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
   43ac4:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43ac7:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   43aca:	7e 08                	jle    43ad4 <printer_vprintf+0x81e>
   43acc:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43acf:	2b 45 bc             	sub    -0x44(%rbp),%eax
   43ad2:	eb 05                	jmp    43ad9 <printer_vprintf+0x823>
   43ad4:	b8 00 00 00 00       	mov    $0x0,%eax
   43ad9:	89 45 b8             	mov    %eax,-0x48(%rbp)
   43adc:	eb 5c                	jmp    43b3a <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   43ade:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43ae1:	83 e0 20             	and    $0x20,%eax
   43ae4:	85 c0                	test   %eax,%eax
   43ae6:	74 4b                	je     43b33 <printer_vprintf+0x87d>
   43ae8:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43aeb:	83 e0 02             	and    $0x2,%eax
   43aee:	85 c0                	test   %eax,%eax
   43af0:	74 41                	je     43b33 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
   43af2:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43af5:	83 e0 04             	and    $0x4,%eax
   43af8:	85 c0                	test   %eax,%eax
   43afa:	75 37                	jne    43b33 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
   43afc:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43b00:	48 89 c7             	mov    %rax,%rdi
   43b03:	e8 51 f5 ff ff       	call   43059 <strlen>
   43b08:	89 c2                	mov    %eax,%edx
   43b0a:	8b 45 bc             	mov    -0x44(%rbp),%eax
   43b0d:	01 d0                	add    %edx,%eax
   43b0f:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   43b12:	7e 1f                	jle    43b33 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
   43b14:	8b 45 e8             	mov    -0x18(%rbp),%eax
   43b17:	2b 45 bc             	sub    -0x44(%rbp),%eax
   43b1a:	89 c3                	mov    %eax,%ebx
   43b1c:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43b20:	48 89 c7             	mov    %rax,%rdi
   43b23:	e8 31 f5 ff ff       	call   43059 <strlen>
   43b28:	89 c2                	mov    %eax,%edx
   43b2a:	89 d8                	mov    %ebx,%eax
   43b2c:	29 d0                	sub    %edx,%eax
   43b2e:	89 45 b8             	mov    %eax,-0x48(%rbp)
   43b31:	eb 07                	jmp    43b3a <printer_vprintf+0x884>
        } else {
            zeros = 0;
   43b33:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   43b3a:	8b 55 bc             	mov    -0x44(%rbp),%edx
   43b3d:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43b40:	01 d0                	add    %edx,%eax
   43b42:	48 63 d8             	movslq %eax,%rbx
   43b45:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43b49:	48 89 c7             	mov    %rax,%rdi
   43b4c:	e8 08 f5 ff ff       	call   43059 <strlen>
   43b51:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   43b55:	8b 45 e8             	mov    -0x18(%rbp),%eax
   43b58:	29 d0                	sub    %edx,%eax
   43b5a:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   43b5d:	eb 25                	jmp    43b84 <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
   43b5f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43b66:	48 8b 08             	mov    (%rax),%rcx
   43b69:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43b6f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43b76:	be 20 00 00 00       	mov    $0x20,%esi
   43b7b:	48 89 c7             	mov    %rax,%rdi
   43b7e:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   43b80:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   43b84:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43b87:	83 e0 04             	and    $0x4,%eax
   43b8a:	85 c0                	test   %eax,%eax
   43b8c:	75 36                	jne    43bc4 <printer_vprintf+0x90e>
   43b8e:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   43b92:	7f cb                	jg     43b5f <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
   43b94:	eb 2e                	jmp    43bc4 <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
   43b96:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43b9d:	4c 8b 00             	mov    (%rax),%r8
   43ba0:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43ba4:	0f b6 00             	movzbl (%rax),%eax
   43ba7:	0f b6 c8             	movzbl %al,%ecx
   43baa:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43bb0:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43bb7:	89 ce                	mov    %ecx,%esi
   43bb9:	48 89 c7             	mov    %rax,%rdi
   43bbc:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   43bbf:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   43bc4:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43bc8:	0f b6 00             	movzbl (%rax),%eax
   43bcb:	84 c0                	test   %al,%al
   43bcd:	75 c7                	jne    43b96 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
   43bcf:	eb 25                	jmp    43bf6 <printer_vprintf+0x940>
            p->putc(p, '0', color);
   43bd1:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43bd8:	48 8b 08             	mov    (%rax),%rcx
   43bdb:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43be1:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43be8:	be 30 00 00 00       	mov    $0x30,%esi
   43bed:	48 89 c7             	mov    %rax,%rdi
   43bf0:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   43bf2:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   43bf6:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   43bfa:	7f d5                	jg     43bd1 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
   43bfc:	eb 32                	jmp    43c30 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
   43bfe:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43c05:	4c 8b 00             	mov    (%rax),%r8
   43c08:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43c0c:	0f b6 00             	movzbl (%rax),%eax
   43c0f:	0f b6 c8             	movzbl %al,%ecx
   43c12:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43c18:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43c1f:	89 ce                	mov    %ecx,%esi
   43c21:	48 89 c7             	mov    %rax,%rdi
   43c24:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   43c27:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   43c2c:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   43c30:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   43c34:	7f c8                	jg     43bfe <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
   43c36:	eb 25                	jmp    43c5d <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
   43c38:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43c3f:	48 8b 08             	mov    (%rax),%rcx
   43c42:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43c48:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43c4f:	be 20 00 00 00       	mov    $0x20,%esi
   43c54:	48 89 c7             	mov    %rax,%rdi
   43c57:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   43c59:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   43c5d:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   43c61:	7f d5                	jg     43c38 <printer_vprintf+0x982>
        }
    done: ;
   43c63:	90                   	nop
    for (; *format; ++format) {
   43c64:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43c6b:	01 
   43c6c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43c73:	0f b6 00             	movzbl (%rax),%eax
   43c76:	84 c0                	test   %al,%al
   43c78:	0f 85 64 f6 ff ff    	jne    432e2 <printer_vprintf+0x2c>
    }
}
   43c7e:	90                   	nop
   43c7f:	90                   	nop
   43c80:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   43c84:	c9                   	leave  
   43c85:	c3                   	ret    

0000000000043c86 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   43c86:	55                   	push   %rbp
   43c87:	48 89 e5             	mov    %rsp,%rbp
   43c8a:	48 83 ec 20          	sub    $0x20,%rsp
   43c8e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43c92:	89 f0                	mov    %esi,%eax
   43c94:	89 55 e0             	mov    %edx,-0x20(%rbp)
   43c97:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   43c9a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43c9e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   43ca2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43ca6:	48 8b 40 08          	mov    0x8(%rax),%rax
   43caa:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
   43caf:	48 39 d0             	cmp    %rdx,%rax
   43cb2:	72 0c                	jb     43cc0 <console_putc+0x3a>
        cp->cursor = console;
   43cb4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43cb8:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
   43cbf:	00 
    }
    if (c == '\n') {
   43cc0:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   43cc4:	75 78                	jne    43d3e <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
   43cc6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43cca:	48 8b 40 08          	mov    0x8(%rax),%rax
   43cce:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   43cd4:	48 d1 f8             	sar    %rax
   43cd7:	48 89 c1             	mov    %rax,%rcx
   43cda:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   43ce1:	66 66 66 
   43ce4:	48 89 c8             	mov    %rcx,%rax
   43ce7:	48 f7 ea             	imul   %rdx
   43cea:	48 c1 fa 05          	sar    $0x5,%rdx
   43cee:	48 89 c8             	mov    %rcx,%rax
   43cf1:	48 c1 f8 3f          	sar    $0x3f,%rax
   43cf5:	48 29 c2             	sub    %rax,%rdx
   43cf8:	48 89 d0             	mov    %rdx,%rax
   43cfb:	48 c1 e0 02          	shl    $0x2,%rax
   43cff:	48 01 d0             	add    %rdx,%rax
   43d02:	48 c1 e0 04          	shl    $0x4,%rax
   43d06:	48 29 c1             	sub    %rax,%rcx
   43d09:	48 89 ca             	mov    %rcx,%rdx
   43d0c:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   43d0f:	eb 25                	jmp    43d36 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
   43d11:	8b 45 e0             	mov    -0x20(%rbp),%eax
   43d14:	83 c8 20             	or     $0x20,%eax
   43d17:	89 c6                	mov    %eax,%esi
   43d19:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43d1d:	48 8b 40 08          	mov    0x8(%rax),%rax
   43d21:	48 8d 48 02          	lea    0x2(%rax),%rcx
   43d25:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   43d29:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43d2d:	89 f2                	mov    %esi,%edx
   43d2f:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   43d32:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   43d36:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   43d3a:	75 d5                	jne    43d11 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   43d3c:	eb 24                	jmp    43d62 <console_putc+0xdc>
        *cp->cursor++ = c | color;
   43d3e:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
   43d42:	8b 55 e0             	mov    -0x20(%rbp),%edx
   43d45:	09 d0                	or     %edx,%eax
   43d47:	89 c6                	mov    %eax,%esi
   43d49:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43d4d:	48 8b 40 08          	mov    0x8(%rax),%rax
   43d51:	48 8d 48 02          	lea    0x2(%rax),%rcx
   43d55:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   43d59:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43d5d:	89 f2                	mov    %esi,%edx
   43d5f:	66 89 10             	mov    %dx,(%rax)
}
   43d62:	90                   	nop
   43d63:	c9                   	leave  
   43d64:	c3                   	ret    

0000000000043d65 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   43d65:	55                   	push   %rbp
   43d66:	48 89 e5             	mov    %rsp,%rbp
   43d69:	48 83 ec 30          	sub    $0x30,%rsp
   43d6d:	89 7d ec             	mov    %edi,-0x14(%rbp)
   43d70:	89 75 e8             	mov    %esi,-0x18(%rbp)
   43d73:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   43d77:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   43d7b:	48 c7 45 f0 86 3c 04 	movq   $0x43c86,-0x10(%rbp)
   43d82:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   43d83:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   43d87:	78 09                	js     43d92 <console_vprintf+0x2d>
   43d89:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   43d90:	7e 07                	jle    43d99 <console_vprintf+0x34>
        cpos = 0;
   43d92:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   43d99:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43d9c:	48 98                	cltq   
   43d9e:	48 01 c0             	add    %rax,%rax
   43da1:	48 05 00 80 0b 00    	add    $0xb8000,%rax
   43da7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   43dab:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   43daf:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43db3:	8b 75 e8             	mov    -0x18(%rbp),%esi
   43db6:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   43dba:	48 89 c7             	mov    %rax,%rdi
   43dbd:	e8 f4 f4 ff ff       	call   432b6 <printer_vprintf>
    return cp.cursor - console;
   43dc2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43dc6:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   43dcc:	48 d1 f8             	sar    %rax
}
   43dcf:	c9                   	leave  
   43dd0:	c3                   	ret    

0000000000043dd1 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   43dd1:	55                   	push   %rbp
   43dd2:	48 89 e5             	mov    %rsp,%rbp
   43dd5:	48 83 ec 60          	sub    $0x60,%rsp
   43dd9:	89 7d ac             	mov    %edi,-0x54(%rbp)
   43ddc:	89 75 a8             	mov    %esi,-0x58(%rbp)
   43ddf:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   43de3:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   43de7:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   43deb:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   43def:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   43df6:	48 8d 45 10          	lea    0x10(%rbp),%rax
   43dfa:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   43dfe:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   43e02:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   43e06:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   43e0a:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   43e0e:	8b 75 a8             	mov    -0x58(%rbp),%esi
   43e11:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43e14:	89 c7                	mov    %eax,%edi
   43e16:	e8 4a ff ff ff       	call   43d65 <console_vprintf>
   43e1b:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   43e1e:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   43e21:	c9                   	leave  
   43e22:	c3                   	ret    

0000000000043e23 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   43e23:	55                   	push   %rbp
   43e24:	48 89 e5             	mov    %rsp,%rbp
   43e27:	48 83 ec 20          	sub    $0x20,%rsp
   43e2b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43e2f:	89 f0                	mov    %esi,%eax
   43e31:	89 55 e0             	mov    %edx,-0x20(%rbp)
   43e34:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   43e37:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43e3b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   43e3f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e43:	48 8b 50 08          	mov    0x8(%rax),%rdx
   43e47:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e4b:	48 8b 40 10          	mov    0x10(%rax),%rax
   43e4f:	48 39 c2             	cmp    %rax,%rdx
   43e52:	73 1a                	jae    43e6e <string_putc+0x4b>
        *sp->s++ = c;
   43e54:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e58:	48 8b 40 08          	mov    0x8(%rax),%rax
   43e5c:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43e60:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43e64:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43e68:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   43e6c:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   43e6e:	90                   	nop
   43e6f:	c9                   	leave  
   43e70:	c3                   	ret    

0000000000043e71 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   43e71:	55                   	push   %rbp
   43e72:	48 89 e5             	mov    %rsp,%rbp
   43e75:	48 83 ec 40          	sub    $0x40,%rsp
   43e79:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   43e7d:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   43e81:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   43e85:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   43e89:	48 c7 45 e8 23 3e 04 	movq   $0x43e23,-0x18(%rbp)
   43e90:	00 
    sp.s = s;
   43e91:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43e95:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   43e99:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   43e9e:	74 33                	je     43ed3 <vsnprintf+0x62>
        sp.end = s + size - 1;
   43ea0:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43ea4:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43ea8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43eac:	48 01 d0             	add    %rdx,%rax
   43eaf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   43eb3:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   43eb7:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   43ebb:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   43ebf:	be 00 00 00 00       	mov    $0x0,%esi
   43ec4:	48 89 c7             	mov    %rax,%rdi
   43ec7:	e8 ea f3 ff ff       	call   432b6 <printer_vprintf>
        *sp.s = 0;
   43ecc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43ed0:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   43ed3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43ed7:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   43edb:	c9                   	leave  
   43edc:	c3                   	ret    

0000000000043edd <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   43edd:	55                   	push   %rbp
   43ede:	48 89 e5             	mov    %rsp,%rbp
   43ee1:	48 83 ec 70          	sub    $0x70,%rsp
   43ee5:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   43ee9:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   43eed:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   43ef1:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   43ef5:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   43ef9:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   43efd:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   43f04:	48 8d 45 10          	lea    0x10(%rbp),%rax
   43f08:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   43f0c:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   43f10:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   43f14:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   43f18:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   43f1c:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   43f20:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43f24:	48 89 c7             	mov    %rax,%rdi
   43f27:	e8 45 ff ff ff       	call   43e71 <vsnprintf>
   43f2c:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   43f2f:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   43f32:	c9                   	leave  
   43f33:	c3                   	ret    

0000000000043f34 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   43f34:	55                   	push   %rbp
   43f35:	48 89 e5             	mov    %rsp,%rbp
   43f38:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   43f3c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   43f43:	eb 13                	jmp    43f58 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
   43f45:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43f48:	48 98                	cltq   
   43f4a:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
   43f51:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   43f54:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   43f58:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   43f5f:	7e e4                	jle    43f45 <console_clear+0x11>
    }
    cursorpos = 0;
   43f61:	c7 05 91 50 07 00 00 	movl   $0x0,0x75091(%rip)        # b8ffc <cursorpos>
   43f68:	00 00 00 
}
   43f6b:	90                   	nop
   43f6c:	c9                   	leave  
   43f6d:	c3                   	ret    
