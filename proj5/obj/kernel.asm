
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
   40173:	e8 11 16 00 00       	call   41789 <hardware_init>
    pageinfo_init();
   40178:	e8 70 0c 00 00       	call   40ded <pageinfo_init>
    console_clear();
   4017d:	e8 c3 3f 00 00       	call   44145 <console_clear>
    timer_init(HZ);
   40182:	bf 64 00 00 00       	mov    $0x64,%edi
   40187:	e8 e9 1a 00 00       	call   41c75 <timer_init>

    // use virtual_memory_map to remove user permissions for kernel memory
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   4018c:	48 8b 05 6d 4e 01 00 	mov    0x14e6d(%rip),%rax        # 55000 <kernel_pagetable>
   40193:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   40199:	b9 00 00 10 00       	mov    $0x100000,%ecx
   4019e:	ba 00 00 00 00       	mov    $0x0,%edx
   401a3:	be 00 00 00 00       	mov    $0x0,%esi
   401a8:	48 89 c7             	mov    %rax,%rdi
   401ab:	e8 23 28 00 00       	call   429d3 <virtual_memory_map>
					   PROC_START_ADDR, PTE_P | PTE_W);
   
    // return user permissions to console
    virtual_memory_map(kernel_pagetable, (uintptr_t) CONSOLE_ADDR, (uintptr_t) CONSOLE_ADDR,
   401b0:	ba 00 80 0b 00       	mov    $0xb8000,%edx
   401b5:	be 00 80 0b 00       	mov    $0xb8000,%esi
   401ba:	48 8b 05 3f 4e 01 00 	mov    0x14e3f(%rip),%rax        # 55000 <kernel_pagetable>
   401c1:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   401c7:	b9 00 10 00 00       	mov    $0x1000,%ecx
   401cc:	48 89 c7             	mov    %rax,%rdi
   401cf:	e8 ff 27 00 00       	call   429d3 <virtual_memory_map>
	// to all memory before the start of ANY processes. This means that 
	// the assign_page function is never capable of assigning this memory
	// to a process.

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   401d4:	ba 00 0e 00 00       	mov    $0xe00,%edx
   401d9:	be 00 00 00 00       	mov    $0x0,%esi
   401de:	bf 20 20 05 00       	mov    $0x52020,%edi
   401e3:	e8 43 30 00 00       	call   4322b <memset>
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
   40246:	be 80 41 04 00       	mov    $0x44180,%esi
   4024b:	48 89 c7             	mov    %rax,%rdi
   4024e:	e8 d1 30 00 00       	call   43324 <strcmp>
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
   40276:	be 85 41 04 00       	mov    $0x44185,%esi
   4027b:	48 89 c7             	mov    %rax,%rdi
   4027e:	e8 a1 30 00 00       	call   43324 <strcmp>
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
   402a6:	be 8e 41 04 00       	mov    $0x4418e,%esi
   402ab:	48 89 c7             	mov    %rax,%rdi
   402ae:	e8 71 30 00 00       	call   43324 <strcmp>
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
   402d3:	be 93 41 04 00       	mov    $0x44193,%esi
   402d8:	48 89 c7             	mov    %rax,%rdi
   402db:	e8 44 30 00 00       	call   43324 <strcmp>
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
   4032d:	bf 00 21 05 00       	mov    $0x52100,%edi
   40332:	e8 59 0a 00 00       	call   40d90 <run>

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
   40357:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   4035e:	00 
   4035f:	84 c0                	test   %al,%al
   40361:	75 28                	jne    4038b <next_free_page+0x54>
		    pageinfo[PAGENUMBER(pa)].refcount == 0) {
   40363:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40367:	48 c1 e8 0c          	shr    $0xc,%rax
   4036b:	48 98                	cltq   
   4036d:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
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
   403ea:	88 94 00 40 2e 05 00 	mov    %dl,0x52e40(%rax,%rax,1)
			pageinfo[PAGENUMBER(pagetable_pages[i])].refcount = 1;
   403f1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   403f4:	48 98                	cltq   
   403f6:	48 8b 44 c5 d0       	mov    -0x30(%rbp,%rax,8),%rax
   403fb:	48 c1 e8 0c          	shr    $0xc,%rax
   403ff:	48 98                	cltq   
   40401:	c6 84 00 41 2e 05 00 	movb   $0x1,0x52e41(%rax,%rax,1)
   40408:	01 
			memset((void *) pagetable_pages[i], 0, PAGESIZE);
   40409:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4040c:	48 98                	cltq   
   4040e:	48 8b 44 c5 d0       	mov    -0x30(%rbp,%rax,8),%rax
   40413:	ba 00 10 00 00       	mov    $0x1000,%edx
   40418:	be 00 00 00 00       	mov    $0x0,%esi
   4041d:	48 89 c7             	mov    %rax,%rdi
   40420:	e8 06 2e 00 00       	call   4322b <memset>
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
   4046c:	48 8b 05 8d 4b 01 00 	mov    0x14b8d(%rip),%rax        # 55000 <kernel_pagetable>
   40473:	48 05 00 30 00 00    	add    $0x3000,%rax
   40479:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   4047d:	48 89 d1             	mov    %rdx,%rcx
   40480:	ba 00 08 00 00       	mov    $0x800,%edx
   40485:	48 89 c6             	mov    %rax,%rsi
   40488:	48 89 cf             	mov    %rcx,%rdi
   4048b:	e8 9d 2c 00 00       	call   4312d <memcpy>
	   sizeof(x86_64_pageentry_t)*PAGENUMBER(PROC_START_ADDR));

    processes[pid].p_pagetable = (x86_64_pagetable *) pagetable_pages[0];
   40490:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40494:	48 89 c1             	mov    %rax,%rcx
   40497:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4049a:	48 63 d0             	movslq %eax,%rdx
   4049d:	48 89 d0             	mov    %rdx,%rax
   404a0:	48 c1 e0 03          	shl    $0x3,%rax
   404a4:	48 29 d0             	sub    %rdx,%rax
   404a7:	48 c1 e0 05          	shl    $0x5,%rax
   404ab:	48 05 f0 20 05 00    	add    $0x520f0,%rax
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
   404d9:	48 05 20 20 05 00    	add    $0x52020,%rax
   404df:	be 00 00 00 00       	mov    $0x0,%esi
   404e4:	48 89 c7             	mov    %rax,%rdi
   404e7:	e8 1a 1a 00 00       	call   41f06 <process_init>
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
   4050a:	48 8d 88 20 20 05 00 	lea    0x52020(%rax),%rcx
   40511:	8b 45 d8             	mov    -0x28(%rbp),%eax
   40514:	ba 00 00 00 00       	mov    $0x0,%edx
   40519:	89 c6                	mov    %eax,%esi
   4051b:	48 89 cf             	mov    %rcx,%rdi
   4051e:	e8 6d 29 00 00       	call   42e90 <program_load>
   40523:	89 45 fc             	mov    %eax,-0x4(%rbp)
    assert(r >= 0);
   40526:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4052a:	79 14                	jns    40540 <process_setup+0x89>
   4052c:	ba 99 41 04 00       	mov    $0x44199,%edx
   40531:	be c2 00 00 00       	mov    $0xc2,%esi
   40536:	bf a0 41 04 00       	mov    $0x441a0,%edi
   4053b:	e8 94 21 00 00       	call   426d4 <assert_fail>

    processes[pid].p_registers.reg_rsp = MEMSIZE_VIRTUAL; 
   40540:	8b 45 dc             	mov    -0x24(%rbp),%eax
   40543:	48 63 d0             	movslq %eax,%rdx
   40546:	48 89 d0             	mov    %rdx,%rax
   40549:	48 c1 e0 03          	shl    $0x3,%rax
   4054d:	48 29 d0             	sub    %rdx,%rax
   40550:	48 c1 e0 05          	shl    $0x5,%rax
   40554:	48 05 d8 20 05 00    	add    $0x520d8,%rax
   4055a:	48 c7 00 00 00 30 00 	movq   $0x300000,(%rax)
    uintptr_t stack_page_va = processes[pid].p_registers.reg_rsp - PAGESIZE;
   40561:	8b 45 dc             	mov    -0x24(%rbp),%eax
   40564:	48 63 d0             	movslq %eax,%rdx
   40567:	48 89 d0             	mov    %rdx,%rax
   4056a:	48 c1 e0 03          	shl    $0x3,%rax
   4056e:	48 29 d0             	sub    %rdx,%rax
   40571:	48 c1 e0 05          	shl    $0x5,%rax
   40575:	48 05 d8 20 05 00    	add    $0x520d8,%rax
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
   405c0:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   405c6:	48 8b 00             	mov    (%rax),%rax
   405c9:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   405cd:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   405d3:	b9 00 10 00 00       	mov    $0x1000,%ecx
   405d8:	48 89 fa             	mov    %rdi,%rdx
   405db:	48 89 c7             	mov    %rax,%rdi
   405de:	e8 f0 23 00 00       	call   429d3 <virtual_memory_map>
                       PAGESIZE, PTE_P | PTE_W | PTE_U);
    processes[pid].p_state = P_RUNNABLE;
   405e3:	8b 45 dc             	mov    -0x24(%rbp),%eax
   405e6:	48 63 d0             	movslq %eax,%rdx
   405e9:	48 89 d0             	mov    %rdx,%rax
   405ec:	48 c1 e0 03          	shl    $0x3,%rax
   405f0:	48 29 d0             	sub    %rdx,%rax
   405f3:	48 c1 e0 05          	shl    $0x5,%rax
   405f7:	48 05 e8 20 05 00    	add    $0x520e8,%rax
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
   40639:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
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
   40656:	c6 84 00 41 2e 05 00 	movb   $0x1,0x52e41(%rax,%rax,1)
   4065d:	01 
        pageinfo[PAGENUMBER(addr)].owner = owner;
   4065e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40662:	48 c1 e8 0c          	shr    $0xc,%rax
   40666:	48 98                	cltq   
   40668:	0f b6 55 f4          	movzbl -0xc(%rbp),%edx
   4066c:	88 94 00 40 2e 05 00 	mov    %dl,0x52e40(%rax,%rax,1)
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
   406b7:	e8 dd 26 00 00       	call   42d99 <virtual_memory_lookup>

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
   406ef:	e8 a5 26 00 00       	call   42d99 <virtual_memory_lookup>
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
   4071b:	e8 79 26 00 00       	call   42d99 <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   40720:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40724:	48 89 c1             	mov    %rax,%rcx
   40727:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   4072b:	ba 18 00 00 00       	mov    $0x18,%edx
   40730:	48 89 c6             	mov    %rax,%rsi
   40733:	48 89 cf             	mov    %rcx,%rdi
   40736:	e8 f2 29 00 00       	call   4312d <memcpy>
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
   407d1:	48 05 e8 20 05 00    	add    $0x520e8,%rax
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
   40805:	48 8b 05 f4 17 01 00 	mov    0x117f4(%rip),%rax        # 52000 <current>
   4080c:	48 8b 95 c8 fe ff ff 	mov    -0x138(%rbp),%rdx
   40813:	48 83 c0 08          	add    $0x8,%rax
   40817:	48 89 d6             	mov    %rdx,%rsi
   4081a:	ba 18 00 00 00       	mov    $0x18,%edx
   4081f:	48 89 c7             	mov    %rax,%rdi
   40822:	48 89 d1             	mov    %rdx,%rcx
   40825:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   40828:	48 8b 05 d1 47 01 00 	mov    0x147d1(%rip),%rax        # 55000 <kernel_pagetable>
   4082f:	48 89 c7             	mov    %rax,%rdi
   40832:	e8 6b 20 00 00       	call   428a2 <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   40837:	8b 05 bf 87 07 00    	mov    0x787bf(%rip),%eax        # b8ffc <cursorpos>
   4083d:	89 c7                	mov    %eax,%edi
   4083f:	e8 8c 17 00 00       	call   41fd0 <console_show_cursor>
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
   40882:	e8 fd 08 00 00       	call   41184 <check_virtual_memory>
        if(disp_global){
   40887:	0f b6 05 72 47 00 00 	movzbl 0x4772(%rip),%eax        # 45000 <disp_global>
   4088e:	84 c0                	test   %al,%al
   40890:	74 0a                	je     4089c <exception+0xa9>
            memshow_physical();
   40892:	e8 65 0a 00 00       	call   412fc <memshow_physical>
            memshow_virtual_animate();
   40897:	e8 8f 0d 00 00       	call   4162b <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   4089c:	e8 12 1c 00 00       	call   424b3 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   408a1:	48 8b 85 c8 fe ff ff 	mov    -0x138(%rbp),%rax
   408a8:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   408af:	48 83 e8 0e          	sub    $0xe,%rax
   408b3:	48 83 f8 2a          	cmp    $0x2a,%rax
   408b7:	0f 87 24 04 00 00    	ja     40ce1 <exception+0x4ee>
   408bd:	48 8b 04 c5 58 42 04 	mov    0x44258(,%rax,8),%rax
   408c4:	00 
   408c5:	ff e0                	jmp    *%rax

    case INT_SYS_PANIC:
	    // rdi stores pointer for msg string
	    {
		char msg[160];
		uintptr_t addr = current->p_registers.reg_rdi;
   408c7:	48 8b 05 32 17 01 00 	mov    0x11732(%rip),%rax        # 52000 <current>
   408ce:	48 8b 40 38          	mov    0x38(%rax),%rax
   408d2:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
		if((void *)addr == NULL)
   408d6:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   408db:	75 0f                	jne    408ec <exception+0xf9>
		    panic(NULL);
   408dd:	bf 00 00 00 00       	mov    $0x0,%edi
   408e2:	b8 00 00 00 00       	mov    $0x0,%eax
   408e7:	e8 08 1d 00 00       	call   425f4 <panic>
		vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   408ec:	48 8b 05 0d 17 01 00 	mov    0x1170d(%rip),%rax        # 52000 <current>
   408f3:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   408fa:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   408fe:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   40902:	48 89 ce             	mov    %rcx,%rsi
   40905:	48 89 c7             	mov    %rax,%rdi
   40908:	e8 8c 24 00 00       	call   42d99 <virtual_memory_lookup>
		memcpy(msg, (void *)map.pa, 160);
   4090d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   40911:	48 89 c1             	mov    %rax,%rcx
   40914:	48 8d 85 d8 fe ff ff 	lea    -0x128(%rbp),%rax
   4091b:	ba a0 00 00 00       	mov    $0xa0,%edx
   40920:	48 89 ce             	mov    %rcx,%rsi
   40923:	48 89 c7             	mov    %rax,%rdi
   40926:	e8 02 28 00 00       	call   4312d <memcpy>
		panic(msg);
   4092b:	48 8d 85 d8 fe ff ff 	lea    -0x128(%rbp),%rax
   40932:	48 89 c7             	mov    %rax,%rdi
   40935:	b8 00 00 00 00       	mov    $0x0,%eax
   4093a:	e8 b5 1c 00 00       	call   425f4 <panic>
	    }
	    panic(NULL);
	    break;                  // will not be reached

    case INT_SYS_GETPID:
        current->p_registers.reg_rax = current->p_pid;
   4093f:	48 8b 05 ba 16 01 00 	mov    0x116ba(%rip),%rax        # 52000 <current>
   40946:	8b 10                	mov    (%rax),%edx
   40948:	48 8b 05 b1 16 01 00 	mov    0x116b1(%rip),%rax        # 52000 <current>
   4094f:	48 63 d2             	movslq %edx,%rdx
   40952:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   40956:	e9 96 03 00 00       	jmp    40cf1 <exception+0x4fe>

    case INT_SYS_YIELD:
        schedule();
   4095b:	e8 ba 03 00 00       	call   40d1a <schedule>
        break;                  /* will not be reached */
   40960:	e9 8c 03 00 00       	jmp    40cf1 <exception+0x4fe>

    case INT_SYS_PAGE_ALLOC: {
        uintptr_t va = current->p_registers.reg_rdi;
   40965:	48 8b 05 94 16 01 00 	mov    0x11694(%rip),%rax        # 52000 <current>
   4096c:	48 8b 40 38          	mov    0x38(%rax),%rax
   40970:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
		uintptr_t pa;
		next_free_page(&pa);
   40974:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   40978:	48 89 c7             	mov    %rax,%rdi
   4097b:	e8 b7 f9 ff ff       	call   40337 <next_free_page>
        int r = assign_physical_page(pa, current->p_pid); 
   40980:	48 8b 05 79 16 01 00 	mov    0x11679(%rip),%rax        # 52000 <current>
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
   409a7:	48 8b 05 52 16 01 00 	mov    0x11652(%rip),%rax        # 52000 <current>
   409ae:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   409b5:	48 8b 75 e8          	mov    -0x18(%rbp),%rsi
   409b9:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   409bf:	b9 00 10 00 00       	mov    $0x1000,%ecx
   409c4:	48 89 c7             	mov    %rax,%rdi
   409c7:	e8 07 20 00 00       	call   429d3 <virtual_memory_map>
   409cc:	eb 19                	jmp    409e7 <exception+0x1f4>
                               PAGESIZE, PTE_P | PTE_W | PTE_U);
        }
	else
		console_printf(CPOS(23, 0), 0x0400, "Out of physical memory!\n");	
   409ce:	ba b0 41 04 00       	mov    $0x441b0,%edx
   409d3:	be 00 04 00 00       	mov    $0x400,%esi
   409d8:	bf 30 07 00 00       	mov    $0x730,%edi
   409dd:	b8 00 00 00 00       	mov    $0x0,%eax
   409e2:	e8 fb 35 00 00       	call   43fe2 <console_printf>
        current->p_registers.reg_rax = r;
   409e7:	48 8b 05 12 16 01 00 	mov    0x11612(%rip),%rax        # 52000 <current>
   409ee:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   409f1:	48 63 d2             	movslq %edx,%rdx
   409f4:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   409f8:	e9 f4 02 00 00       	jmp    40cf1 <exception+0x4fe>
    }

    case INT_SYS_MAPPING:
    {
	    syscall_mapping(current);
   409fd:	48 8b 05 fc 15 01 00 	mov    0x115fc(%rip),%rax        # 52000 <current>
   40a04:	48 89 c7             	mov    %rax,%rdi
   40a07:	e8 6e fc ff ff       	call   4067a <syscall_mapping>
            break;
   40a0c:	e9 e0 02 00 00       	jmp    40cf1 <exception+0x4fe>
    }

    case INT_SYS_MEM_TOG:
	{
	    syscall_mem_tog(current);
   40a11:	48 8b 05 e8 15 01 00 	mov    0x115e8(%rip),%rax        # 52000 <current>
   40a18:	48 89 c7             	mov    %rax,%rdi
   40a1b:	e8 23 fd ff ff       	call   40743 <syscall_mem_tog>
	    break;
   40a20:	e9 cc 02 00 00       	jmp    40cf1 <exception+0x4fe>
	}

    case INT_TIMER:
        ++ticks;
   40a25:	8b 05 f5 23 01 00    	mov    0x123f5(%rip),%eax        # 52e20 <ticks>
   40a2b:	83 c0 01             	add    $0x1,%eax
   40a2e:	89 05 ec 23 01 00    	mov    %eax,0x123ec(%rip)        # 52e20 <ticks>
        schedule();
   40a34:	e8 e1 02 00 00       	call   40d1a <schedule>
        break;                  /* will not be reached */
   40a39:	e9 b3 02 00 00       	jmp    40cf1 <exception+0x4fe>
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
   40a63:	b8 c9 41 04 00       	mov    $0x441c9,%eax
   40a68:	eb 05                	jmp    40a6f <exception+0x27c>
   40a6a:	b8 cf 41 04 00       	mov    $0x441cf,%eax
        const char* operation = reg->reg_err & PFERR_WRITE
   40a6f:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        const char* problem = reg->reg_err & PFERR_PRESENT
   40a73:	48 8b 85 c8 fe ff ff 	mov    -0x138(%rbp),%rax
   40a7a:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40a81:	83 e0 01             	and    $0x1,%eax
                ? "protection problem" : "missing page";
   40a84:	48 85 c0             	test   %rax,%rax
   40a87:	74 07                	je     40a90 <exception+0x29d>
   40a89:	b8 d4 41 04 00       	mov    $0x441d4,%eax
   40a8e:	eb 05                	jmp    40a95 <exception+0x2a2>
   40a90:	b8 e7 41 04 00       	mov    $0x441e7,%eax
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
   40acf:	bf f8 41 04 00       	mov    $0x441f8,%edi
   40ad4:	b8 00 00 00 00       	mov    $0x0,%eax
   40ad9:	e8 16 1b 00 00       	call   425f4 <panic>
                  addr, operation, problem, reg->reg_rip);
        }
        console_printf(CPOS(24, 0), 0x0C00,
   40ade:	48 8b 85 c8 fe ff ff 	mov    -0x138(%rbp),%rax
   40ae5:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                       "Process %d page fault for %p (%s %s, rip=%p)!\n",
                       current->p_pid, addr, operation, problem, reg->reg_rip);
   40aec:	48 8b 05 0d 15 01 00 	mov    0x1150d(%rip),%rax        # 52000 <current>
        console_printf(CPOS(24, 0), 0x0C00,
   40af3:	8b 00                	mov    (%rax),%eax
   40af5:	48 8b 75 c8          	mov    -0x38(%rbp),%rsi
   40af9:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
   40afd:	52                   	push   %rdx
   40afe:	ff 75 c0             	push   -0x40(%rbp)
   40b01:	49 89 f1             	mov    %rsi,%r9
   40b04:	49 89 c8             	mov    %rcx,%r8
   40b07:	89 c1                	mov    %eax,%ecx
   40b09:	ba 28 42 04 00       	mov    $0x44228,%edx
   40b0e:	be 00 0c 00 00       	mov    $0xc00,%esi
   40b13:	bf 80 07 00 00       	mov    $0x780,%edi
   40b18:	b8 00 00 00 00       	mov    $0x0,%eax
   40b1d:	e8 c0 34 00 00       	call   43fe2 <console_printf>
   40b22:	48 83 c4 10          	add    $0x10,%rsp
        current->p_state = P_BROKEN;
   40b26:	48 8b 05 d3 14 01 00 	mov    0x114d3(%rip),%rax        # 52000 <current>
   40b2d:	c7 80 c8 00 00 00 03 	movl   $0x3,0xc8(%rax)
   40b34:	00 00 00 
        break;
   40b37:	e9 b5 01 00 00       	jmp    40cf1 <exception+0x4fe>
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
   40b4a:	48 8b 05 af 14 01 00 	mov    0x114af(%rip),%rax        # 52000 <current>
   40b51:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40b58:	ff 
			break;
   40b59:	e9 93 01 00 00       	jmp    40cf1 <exception+0x4fe>
		}

		// copy the state of parent into child
		processes[child_pid] = processes[current->p_pid];
   40b5e:	48 8b 05 9b 14 01 00 	mov    0x1149b(%rip),%rax        # 52000 <current>
   40b65:	8b 08                	mov    (%rax),%ecx
   40b67:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40b6a:	48 63 d0             	movslq %eax,%rdx
   40b6d:	48 89 d0             	mov    %rdx,%rax
   40b70:	48 c1 e0 03          	shl    $0x3,%rax
   40b74:	48 29 d0             	sub    %rdx,%rax
   40b77:	48 c1 e0 05          	shl    $0x5,%rax
   40b7b:	48 8d b0 20 20 05 00 	lea    0x52020(%rax),%rsi
   40b82:	48 63 d1             	movslq %ecx,%rdx
   40b85:	48 89 d0             	mov    %rdx,%rax
   40b88:	48 c1 e0 03          	shl    $0x3,%rax
   40b8c:	48 29 d0             	sub    %rdx,%rax
   40b8f:	48 c1 e0 05          	shl    $0x5,%rax
   40b93:	48 05 20 20 05 00    	add    $0x52020,%rax
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
   40bc1:	48 8d 90 20 20 05 00 	lea    0x52020(%rax),%rdx
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
   40bdf:	e9 bb 00 00 00       	jmp    40c9f <exception+0x4ac>
			vamapping map = virtual_memory_lookup(current->p_pagetable, va); // examining addr page by page
   40be4:	48 8b 05 15 14 01 00 	mov    0x11415(%rip),%rax        # 52000 <current>
   40beb:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40bf2:	48 8d 45 80          	lea    -0x80(%rbp),%rax
   40bf6:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40bfa:	48 89 ce             	mov    %rcx,%rsi
   40bfd:	48 89 c7             	mov    %rax,%rdi
   40c00:	e8 94 21 00 00       	call   42d99 <virtual_memory_lookup>
			if (map.pn != -1) {
   40c05:	8b 45 80             	mov    -0x80(%rbp),%eax
   40c08:	83 f8 ff             	cmp    $0xffffffff,%eax
   40c0b:	0f 84 86 00 00 00    	je     40c97 <exception+0x4a4>
				uintptr_t pa;
				if (next_free_page(&pa) == 0) {
   40c11:	48 8d 85 78 ff ff ff 	lea    -0x88(%rbp),%rax
   40c18:	48 89 c7             	mov    %rax,%rdi
   40c1b:	e8 17 f7 ff ff       	call   40337 <next_free_page>
   40c20:	85 c0                	test   %eax,%eax
   40c22:	75 73                	jne    40c97 <exception+0x4a4>
					assign_physical_page(pa, child_pid);
   40c24:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40c27:	0f be d0             	movsbl %al,%edx
   40c2a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   40c31:	89 d6                	mov    %edx,%esi
   40c33:	48 89 c7             	mov    %rax,%rdi
   40c36:	e8 cb f9 ff ff       	call   40606 <assign_physical_page>
					virtual_memory_map(processes[child_pid].p_pagetable, va, pa, PAGESIZE, map.perm);
   40c3b:	8b 4d 90             	mov    -0x70(%rbp),%ecx
   40c3e:	48 8b bd 78 ff ff ff 	mov    -0x88(%rbp),%rdi
   40c45:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40c48:	48 63 d0             	movslq %eax,%rdx
   40c4b:	48 89 d0             	mov    %rdx,%rax
   40c4e:	48 c1 e0 03          	shl    $0x3,%rax
   40c52:	48 29 d0             	sub    %rdx,%rax
   40c55:	48 c1 e0 05          	shl    $0x5,%rax
   40c59:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   40c5f:	48 8b 00             	mov    (%rax),%rax
   40c62:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   40c66:	41 89 c8             	mov    %ecx,%r8d
   40c69:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40c6e:	48 89 fa             	mov    %rdi,%rdx
   40c71:	48 89 c7             	mov    %rax,%rdi
   40c74:	e8 5a 1d 00 00       	call   429d3 <virtual_memory_map>
					memcpy((void *) pa, (void *) map.pa, PAGESIZE);
   40c79:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   40c7d:	48 89 c1             	mov    %rax,%rcx
   40c80:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   40c87:	ba 00 10 00 00       	mov    $0x1000,%edx
   40c8c:	48 89 ce             	mov    %rcx,%rsi
   40c8f:	48 89 c7             	mov    %rax,%rdi
   40c92:	e8 96 24 00 00       	call   4312d <memcpy>
		for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   40c97:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40c9e:	00 
   40c9f:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   40ca6:	00 
   40ca7:	0f 86 37 ff ff ff    	jbe    40be4 <exception+0x3f1>
				}
			}
		}

		// set return values
		processes[child_pid].p_registers.reg_rax = 0;
   40cad:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40cb0:	48 63 d0             	movslq %eax,%rdx
   40cb3:	48 89 d0             	mov    %rdx,%rax
   40cb6:	48 c1 e0 03          	shl    $0x3,%rax
   40cba:	48 29 d0             	sub    %rdx,%rax
   40cbd:	48 c1 e0 05          	shl    $0x5,%rax
   40cc1:	48 05 28 20 05 00    	add    $0x52028,%rax
   40cc7:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
		current->p_registers.reg_rax = child_pid;
   40cce:	48 8b 05 2b 13 01 00 	mov    0x1132b(%rip),%rax        # 52000 <current>
   40cd5:	8b 55 f4             	mov    -0xc(%rbp),%edx
   40cd8:	48 63 d2             	movslq %edx,%rdx
   40cdb:	48 89 50 08          	mov    %rdx,0x8(%rax)
		break;
   40cdf:	eb 10                	jmp    40cf1 <exception+0x4fe>

    default:
        default_exception(current);
   40ce1:	48 8b 05 18 13 01 00 	mov    0x11318(%rip),%rax        # 52000 <current>
   40ce8:	48 89 c7             	mov    %rax,%rdi
   40ceb:	e8 14 1a 00 00       	call   42704 <default_exception>
        break;                  /* will not be reached */
   40cf0:	90                   	nop

    }


    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   40cf1:	48 8b 05 08 13 01 00 	mov    0x11308(%rip),%rax        # 52000 <current>
   40cf8:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   40cfe:	83 f8 01             	cmp    $0x1,%eax
   40d01:	75 0f                	jne    40d12 <exception+0x51f>
        run(current);
   40d03:	48 8b 05 f6 12 01 00 	mov    0x112f6(%rip),%rax        # 52000 <current>
   40d0a:	48 89 c7             	mov    %rax,%rdi
   40d0d:	e8 7e 00 00 00       	call   40d90 <run>
    } else {
        schedule();
   40d12:	e8 03 00 00 00       	call   40d1a <schedule>
    }
}
   40d17:	90                   	nop
   40d18:	c9                   	leave  
   40d19:	c3                   	ret    

0000000000040d1a <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   40d1a:	55                   	push   %rbp
   40d1b:	48 89 e5             	mov    %rsp,%rbp
   40d1e:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   40d22:	48 8b 05 d7 12 01 00 	mov    0x112d7(%rip),%rax        # 52000 <current>
   40d29:	8b 00                	mov    (%rax),%eax
   40d2b:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   40d2e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40d31:	8d 50 01             	lea    0x1(%rax),%edx
   40d34:	89 d0                	mov    %edx,%eax
   40d36:	c1 f8 1f             	sar    $0x1f,%eax
   40d39:	c1 e8 1c             	shr    $0x1c,%eax
   40d3c:	01 c2                	add    %eax,%edx
   40d3e:	83 e2 0f             	and    $0xf,%edx
   40d41:	29 c2                	sub    %eax,%edx
   40d43:	89 55 fc             	mov    %edx,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   40d46:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40d49:	48 63 d0             	movslq %eax,%rdx
   40d4c:	48 89 d0             	mov    %rdx,%rax
   40d4f:	48 c1 e0 03          	shl    $0x3,%rax
   40d53:	48 29 d0             	sub    %rdx,%rax
   40d56:	48 c1 e0 05          	shl    $0x5,%rax
   40d5a:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   40d60:	8b 00                	mov    (%rax),%eax
   40d62:	83 f8 01             	cmp    $0x1,%eax
   40d65:	75 22                	jne    40d89 <schedule+0x6f>
            run(&processes[pid]);
   40d67:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40d6a:	48 63 d0             	movslq %eax,%rdx
   40d6d:	48 89 d0             	mov    %rdx,%rax
   40d70:	48 c1 e0 03          	shl    $0x3,%rax
   40d74:	48 29 d0             	sub    %rdx,%rax
   40d77:	48 c1 e0 05          	shl    $0x5,%rax
   40d7b:	48 05 20 20 05 00    	add    $0x52020,%rax
   40d81:	48 89 c7             	mov    %rax,%rdi
   40d84:	e8 07 00 00 00       	call   40d90 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   40d89:	e8 25 17 00 00       	call   424b3 <check_keyboard>
        pid = (pid + 1) % NPROC;
   40d8e:	eb 9e                	jmp    40d2e <schedule+0x14>

0000000000040d90 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   40d90:	55                   	push   %rbp
   40d91:	48 89 e5             	mov    %rsp,%rbp
   40d94:	48 83 ec 10          	sub    $0x10,%rsp
   40d98:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   40d9c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40da0:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   40da6:	83 f8 01             	cmp    $0x1,%eax
   40da9:	74 14                	je     40dbf <run+0x2f>
   40dab:	ba b0 43 04 00       	mov    $0x443b0,%edx
   40db0:	be c9 01 00 00       	mov    $0x1c9,%esi
   40db5:	bf a0 41 04 00       	mov    $0x441a0,%edi
   40dba:	e8 15 19 00 00       	call   426d4 <assert_fail>
    current = p;
   40dbf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40dc3:	48 89 05 36 12 01 00 	mov    %rax,0x11236(%rip)        # 52000 <current>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   40dca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40dce:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40dd5:	48 89 c7             	mov    %rax,%rdi
   40dd8:	e8 c5 1a 00 00       	call   428a2 <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   40ddd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40de1:	48 83 c0 08          	add    $0x8,%rax
   40de5:	48 89 c7             	mov    %rax,%rdi
   40de8:	e8 d6 f2 ff ff       	call   400c3 <exception_return>

0000000000040ded <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   40ded:	55                   	push   %rbp
   40dee:	48 89 e5             	mov    %rsp,%rbp
   40df1:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40df5:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40dfc:	00 
   40dfd:	e9 81 00 00 00       	jmp    40e83 <pageinfo_init+0x96>
        int owner;
        if (physical_memory_isreserved(addr)) {
   40e02:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e06:	48 89 c7             	mov    %rax,%rdi
   40e09:	e8 33 0f 00 00       	call   41d41 <physical_memory_isreserved>
   40e0e:	85 c0                	test   %eax,%eax
   40e10:	74 09                	je     40e1b <pageinfo_init+0x2e>
            owner = PO_RESERVED;
   40e12:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   40e19:	eb 2f                	jmp    40e4a <pageinfo_init+0x5d>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   40e1b:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   40e22:	00 
   40e23:	76 0b                	jbe    40e30 <pageinfo_init+0x43>
   40e25:	b8 08 b0 05 00       	mov    $0x5b008,%eax
   40e2a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40e2e:	72 0a                	jb     40e3a <pageinfo_init+0x4d>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   40e30:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   40e37:	00 
   40e38:	75 09                	jne    40e43 <pageinfo_init+0x56>
            owner = PO_KERNEL;
   40e3a:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   40e41:	eb 07                	jmp    40e4a <pageinfo_init+0x5d>
        } else {
            owner = PO_FREE;
   40e43:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40e4a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e4e:	48 c1 e8 0c          	shr    $0xc,%rax
   40e52:	89 c1                	mov    %eax,%ecx
   40e54:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40e57:	89 c2                	mov    %eax,%edx
   40e59:	48 63 c1             	movslq %ecx,%rax
   40e5c:	88 94 00 40 2e 05 00 	mov    %dl,0x52e40(%rax,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   40e63:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40e67:	0f 95 c2             	setne  %dl
   40e6a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e6e:	48 c1 e8 0c          	shr    $0xc,%rax
   40e72:	48 98                	cltq   
   40e74:	88 94 00 41 2e 05 00 	mov    %dl,0x52e41(%rax,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40e7b:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40e82:	00 
   40e83:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40e8a:	00 
   40e8b:	0f 86 71 ff ff ff    	jbe    40e02 <pageinfo_init+0x15>
    }
}
   40e91:	90                   	nop
   40e92:	90                   	nop
   40e93:	c9                   	leave  
   40e94:	c3                   	ret    

0000000000040e95 <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   40e95:	55                   	push   %rbp
   40e96:	48 89 e5             	mov    %rsp,%rbp
   40e99:	48 83 ec 50          	sub    $0x50,%rsp
   40e9d:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   40ea1:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40ea5:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40eab:	48 89 c2             	mov    %rax,%rdx
   40eae:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40eb2:	48 39 c2             	cmp    %rax,%rdx
   40eb5:	74 14                	je     40ecb <check_page_table_mappings+0x36>
   40eb7:	ba d0 43 04 00       	mov    $0x443d0,%edx
   40ebc:	be f3 01 00 00       	mov    $0x1f3,%esi
   40ec1:	bf a0 41 04 00       	mov    $0x441a0,%edi
   40ec6:	e8 09 18 00 00       	call   426d4 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40ecb:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   40ed2:	00 
   40ed3:	e9 9a 00 00 00       	jmp    40f72 <check_page_table_mappings+0xdd>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   40ed8:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   40edc:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40ee0:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40ee4:	48 89 ce             	mov    %rcx,%rsi
   40ee7:	48 89 c7             	mov    %rax,%rdi
   40eea:	e8 aa 1e 00 00       	call   42d99 <virtual_memory_lookup>
        if (vam.pa != va) {
   40eef:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40ef3:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40ef7:	74 27                	je     40f20 <check_page_table_mappings+0x8b>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   40ef9:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40efd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40f01:	49 89 d0             	mov    %rdx,%r8
   40f04:	48 89 c1             	mov    %rax,%rcx
   40f07:	ba ef 43 04 00       	mov    $0x443ef,%edx
   40f0c:	be 00 c0 00 00       	mov    $0xc000,%esi
   40f11:	bf e0 06 00 00       	mov    $0x6e0,%edi
   40f16:	b8 00 00 00 00       	mov    $0x0,%eax
   40f1b:	e8 c2 30 00 00       	call   43fe2 <console_printf>
        }
        assert(vam.pa == va);
   40f20:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40f24:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40f28:	74 14                	je     40f3e <check_page_table_mappings+0xa9>
   40f2a:	ba f9 43 04 00       	mov    $0x443f9,%edx
   40f2f:	be fc 01 00 00       	mov    $0x1fc,%esi
   40f34:	bf a0 41 04 00       	mov    $0x441a0,%edi
   40f39:	e8 96 17 00 00       	call   426d4 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   40f3e:	b8 00 50 04 00       	mov    $0x45000,%eax
   40f43:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40f47:	72 21                	jb     40f6a <check_page_table_mappings+0xd5>
            assert(vam.perm & PTE_W);
   40f49:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40f4c:	48 98                	cltq   
   40f4e:	83 e0 02             	and    $0x2,%eax
   40f51:	48 85 c0             	test   %rax,%rax
   40f54:	75 14                	jne    40f6a <check_page_table_mappings+0xd5>
   40f56:	ba 06 44 04 00       	mov    $0x44406,%edx
   40f5b:	be fe 01 00 00       	mov    $0x1fe,%esi
   40f60:	bf a0 41 04 00       	mov    $0x441a0,%edi
   40f65:	e8 6a 17 00 00       	call   426d4 <assert_fail>
         va += PAGESIZE) {
   40f6a:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40f71:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40f72:	b8 08 b0 05 00       	mov    $0x5b008,%eax
   40f77:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40f7b:	0f 82 57 ff ff ff    	jb     40ed8 <check_page_table_mappings+0x43>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   40f81:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   40f88:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   40f89:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   40f8d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40f91:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40f95:	48 89 ce             	mov    %rcx,%rsi
   40f98:	48 89 c7             	mov    %rax,%rdi
   40f9b:	e8 f9 1d 00 00       	call   42d99 <virtual_memory_lookup>
    assert(vam.pa == kstack);
   40fa0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40fa4:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   40fa8:	74 14                	je     40fbe <check_page_table_mappings+0x129>
   40faa:	ba 17 44 04 00       	mov    $0x44417,%edx
   40faf:	be 05 02 00 00       	mov    $0x205,%esi
   40fb4:	bf a0 41 04 00       	mov    $0x441a0,%edi
   40fb9:	e8 16 17 00 00       	call   426d4 <assert_fail>
    assert(vam.perm & PTE_W);
   40fbe:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40fc1:	48 98                	cltq   
   40fc3:	83 e0 02             	and    $0x2,%eax
   40fc6:	48 85 c0             	test   %rax,%rax
   40fc9:	75 14                	jne    40fdf <check_page_table_mappings+0x14a>
   40fcb:	ba 06 44 04 00       	mov    $0x44406,%edx
   40fd0:	be 06 02 00 00       	mov    $0x206,%esi
   40fd5:	bf a0 41 04 00       	mov    $0x441a0,%edi
   40fda:	e8 f5 16 00 00       	call   426d4 <assert_fail>
}
   40fdf:	90                   	nop
   40fe0:	c9                   	leave  
   40fe1:	c3                   	ret    

0000000000040fe2 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   40fe2:	55                   	push   %rbp
   40fe3:	48 89 e5             	mov    %rsp,%rbp
   40fe6:	48 83 ec 20          	sub    $0x20,%rsp
   40fea:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40fee:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   40ff1:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40ff4:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   40ff7:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   40ffe:	48 8b 05 fb 3f 01 00 	mov    0x13ffb(%rip),%rax        # 55000 <kernel_pagetable>
   41005:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   41009:	75 67                	jne    41072 <check_page_table_ownership+0x90>
        owner = PO_KERNEL;
   4100b:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   41012:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41019:	eb 51                	jmp    4106c <check_page_table_ownership+0x8a>
            if (processes[xpid].p_state != P_FREE
   4101b:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4101e:	48 63 d0             	movslq %eax,%rdx
   41021:	48 89 d0             	mov    %rdx,%rax
   41024:	48 c1 e0 03          	shl    $0x3,%rax
   41028:	48 29 d0             	sub    %rdx,%rax
   4102b:	48 c1 e0 05          	shl    $0x5,%rax
   4102f:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   41035:	8b 00                	mov    (%rax),%eax
   41037:	85 c0                	test   %eax,%eax
   41039:	74 2d                	je     41068 <check_page_table_ownership+0x86>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   4103b:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4103e:	48 63 d0             	movslq %eax,%rdx
   41041:	48 89 d0             	mov    %rdx,%rax
   41044:	48 c1 e0 03          	shl    $0x3,%rax
   41048:	48 29 d0             	sub    %rdx,%rax
   4104b:	48 c1 e0 05          	shl    $0x5,%rax
   4104f:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   41055:	48 8b 10             	mov    (%rax),%rdx
   41058:	48 8b 05 a1 3f 01 00 	mov    0x13fa1(%rip),%rax        # 55000 <kernel_pagetable>
   4105f:	48 39 c2             	cmp    %rax,%rdx
   41062:	75 04                	jne    41068 <check_page_table_ownership+0x86>
                ++expected_refcount;
   41064:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   41068:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   4106c:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   41070:	7e a9                	jle    4101b <check_page_table_ownership+0x39>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   41072:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41075:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41078:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4107c:	be 00 00 00 00       	mov    $0x0,%esi
   41081:	48 89 c7             	mov    %rax,%rdi
   41084:	e8 03 00 00 00       	call   4108c <check_page_table_ownership_level>
}
   41089:	90                   	nop
   4108a:	c9                   	leave  
   4108b:	c3                   	ret    

000000000004108c <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   4108c:	55                   	push   %rbp
   4108d:	48 89 e5             	mov    %rsp,%rbp
   41090:	48 83 ec 30          	sub    $0x30,%rsp
   41094:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   41098:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   4109b:	89 55 e0             	mov    %edx,-0x20(%rbp)
   4109e:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   410a1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   410a5:	48 c1 e8 0c          	shr    $0xc,%rax
   410a9:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   410ae:	7e 14                	jle    410c4 <check_page_table_ownership_level+0x38>
   410b0:	ba 28 44 04 00       	mov    $0x44428,%edx
   410b5:	be 23 02 00 00       	mov    $0x223,%esi
   410ba:	bf a0 41 04 00       	mov    $0x441a0,%edi
   410bf:	e8 10 16 00 00       	call   426d4 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   410c4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   410c8:	48 c1 e8 0c          	shr    $0xc,%rax
   410cc:	48 98                	cltq   
   410ce:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   410d5:	00 
   410d6:	0f be c0             	movsbl %al,%eax
   410d9:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   410dc:	74 14                	je     410f2 <check_page_table_ownership_level+0x66>
   410de:	ba 40 44 04 00       	mov    $0x44440,%edx
   410e3:	be 24 02 00 00       	mov    $0x224,%esi
   410e8:	bf a0 41 04 00       	mov    $0x441a0,%edi
   410ed:	e8 e2 15 00 00       	call   426d4 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   410f2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   410f6:	48 c1 e8 0c          	shr    $0xc,%rax
   410fa:	48 98                	cltq   
   410fc:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   41103:	00 
   41104:	0f be c0             	movsbl %al,%eax
   41107:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   4110a:	74 14                	je     41120 <check_page_table_ownership_level+0x94>
   4110c:	ba 68 44 04 00       	mov    $0x44468,%edx
   41111:	be 25 02 00 00       	mov    $0x225,%esi
   41116:	bf a0 41 04 00       	mov    $0x441a0,%edi
   4111b:	e8 b4 15 00 00       	call   426d4 <assert_fail>
    if (level < 3) {
   41120:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   41124:	7f 5b                	jg     41181 <check_page_table_ownership_level+0xf5>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   41126:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4112d:	eb 49                	jmp    41178 <check_page_table_ownership_level+0xec>
            if (pt->entry[index]) {
   4112f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41133:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41136:	48 63 d2             	movslq %edx,%rdx
   41139:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   4113d:	48 85 c0             	test   %rax,%rax
   41140:	74 32                	je     41174 <check_page_table_ownership_level+0xe8>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   41142:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41146:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41149:	48 63 d2             	movslq %edx,%rdx
   4114c:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41150:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   41156:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   4115a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4115d:	8d 70 01             	lea    0x1(%rax),%esi
   41160:	8b 55 e0             	mov    -0x20(%rbp),%edx
   41163:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   41167:	b9 01 00 00 00       	mov    $0x1,%ecx
   4116c:	48 89 c7             	mov    %rax,%rdi
   4116f:	e8 18 ff ff ff       	call   4108c <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   41174:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41178:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   4117f:	7e ae                	jle    4112f <check_page_table_ownership_level+0xa3>
            }
        }
    }
}
   41181:	90                   	nop
   41182:	c9                   	leave  
   41183:	c3                   	ret    

0000000000041184 <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   41184:	55                   	push   %rbp
   41185:	48 89 e5             	mov    %rsp,%rbp
   41188:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   4118c:	8b 05 56 0f 01 00    	mov    0x10f56(%rip),%eax        # 520e8 <processes+0xc8>
   41192:	85 c0                	test   %eax,%eax
   41194:	74 14                	je     411aa <check_virtual_memory+0x26>
   41196:	ba 98 44 04 00       	mov    $0x44498,%edx
   4119b:	be 38 02 00 00       	mov    $0x238,%esi
   411a0:	bf a0 41 04 00       	mov    $0x441a0,%edi
   411a5:	e8 2a 15 00 00       	call   426d4 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   411aa:	48 8b 05 4f 3e 01 00 	mov    0x13e4f(%rip),%rax        # 55000 <kernel_pagetable>
   411b1:	48 89 c7             	mov    %rax,%rdi
   411b4:	e8 dc fc ff ff       	call   40e95 <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   411b9:	48 8b 05 40 3e 01 00 	mov    0x13e40(%rip),%rax        # 55000 <kernel_pagetable>
   411c0:	be ff ff ff ff       	mov    $0xffffffff,%esi
   411c5:	48 89 c7             	mov    %rax,%rdi
   411c8:	e8 15 fe ff ff       	call   40fe2 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   411cd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   411d4:	e9 9c 00 00 00       	jmp    41275 <check_virtual_memory+0xf1>
        if (processes[pid].p_state != P_FREE
   411d9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411dc:	48 63 d0             	movslq %eax,%rdx
   411df:	48 89 d0             	mov    %rdx,%rax
   411e2:	48 c1 e0 03          	shl    $0x3,%rax
   411e6:	48 29 d0             	sub    %rdx,%rax
   411e9:	48 c1 e0 05          	shl    $0x5,%rax
   411ed:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   411f3:	8b 00                	mov    (%rax),%eax
   411f5:	85 c0                	test   %eax,%eax
   411f7:	74 78                	je     41271 <check_virtual_memory+0xed>
            && processes[pid].p_pagetable != kernel_pagetable) {
   411f9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411fc:	48 63 d0             	movslq %eax,%rdx
   411ff:	48 89 d0             	mov    %rdx,%rax
   41202:	48 c1 e0 03          	shl    $0x3,%rax
   41206:	48 29 d0             	sub    %rdx,%rax
   41209:	48 c1 e0 05          	shl    $0x5,%rax
   4120d:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   41213:	48 8b 10             	mov    (%rax),%rdx
   41216:	48 8b 05 e3 3d 01 00 	mov    0x13de3(%rip),%rax        # 55000 <kernel_pagetable>
   4121d:	48 39 c2             	cmp    %rax,%rdx
   41220:	74 4f                	je     41271 <check_virtual_memory+0xed>
            check_page_table_mappings(processes[pid].p_pagetable);
   41222:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41225:	48 63 d0             	movslq %eax,%rdx
   41228:	48 89 d0             	mov    %rdx,%rax
   4122b:	48 c1 e0 03          	shl    $0x3,%rax
   4122f:	48 29 d0             	sub    %rdx,%rax
   41232:	48 c1 e0 05          	shl    $0x5,%rax
   41236:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   4123c:	48 8b 00             	mov    (%rax),%rax
   4123f:	48 89 c7             	mov    %rax,%rdi
   41242:	e8 4e fc ff ff       	call   40e95 <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   41247:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4124a:	48 63 d0             	movslq %eax,%rdx
   4124d:	48 89 d0             	mov    %rdx,%rax
   41250:	48 c1 e0 03          	shl    $0x3,%rax
   41254:	48 29 d0             	sub    %rdx,%rax
   41257:	48 c1 e0 05          	shl    $0x5,%rax
   4125b:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   41261:	48 8b 00             	mov    (%rax),%rax
   41264:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41267:	89 d6                	mov    %edx,%esi
   41269:	48 89 c7             	mov    %rax,%rdi
   4126c:	e8 71 fd ff ff       	call   40fe2 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   41271:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41275:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   41279:	0f 8e 5a ff ff ff    	jle    411d9 <check_virtual_memory+0x55>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4127f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41286:	eb 67                	jmp    412ef <check_virtual_memory+0x16b>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   41288:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4128b:	48 98                	cltq   
   4128d:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   41294:	00 
   41295:	84 c0                	test   %al,%al
   41297:	7e 52                	jle    412eb <check_virtual_memory+0x167>
   41299:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4129c:	48 98                	cltq   
   4129e:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   412a5:	00 
   412a6:	84 c0                	test   %al,%al
   412a8:	78 41                	js     412eb <check_virtual_memory+0x167>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   412aa:	8b 45 f8             	mov    -0x8(%rbp),%eax
   412ad:	48 98                	cltq   
   412af:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   412b6:	00 
   412b7:	0f be c0             	movsbl %al,%eax
   412ba:	48 63 d0             	movslq %eax,%rdx
   412bd:	48 89 d0             	mov    %rdx,%rax
   412c0:	48 c1 e0 03          	shl    $0x3,%rax
   412c4:	48 29 d0             	sub    %rdx,%rax
   412c7:	48 c1 e0 05          	shl    $0x5,%rax
   412cb:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   412d1:	8b 00                	mov    (%rax),%eax
   412d3:	85 c0                	test   %eax,%eax
   412d5:	75 14                	jne    412eb <check_virtual_memory+0x167>
   412d7:	ba b8 44 04 00       	mov    $0x444b8,%edx
   412dc:	be 4f 02 00 00       	mov    $0x24f,%esi
   412e1:	bf a0 41 04 00       	mov    $0x441a0,%edi
   412e6:	e8 e9 13 00 00       	call   426d4 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   412eb:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   412ef:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   412f6:	7e 90                	jle    41288 <check_virtual_memory+0x104>
        }
    }
}
   412f8:	90                   	nop
   412f9:	90                   	nop
   412fa:	c9                   	leave  
   412fb:	c3                   	ret    

00000000000412fc <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   412fc:	55                   	push   %rbp
   412fd:	48 89 e5             	mov    %rsp,%rbp
   41300:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   41304:	ba 26 45 04 00       	mov    $0x44526,%edx
   41309:	be 00 0f 00 00       	mov    $0xf00,%esi
   4130e:	bf 20 00 00 00       	mov    $0x20,%edi
   41313:	b8 00 00 00 00       	mov    $0x0,%eax
   41318:	e8 c5 2c 00 00       	call   43fe2 <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4131d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41324:	e9 f8 00 00 00       	jmp    41421 <memshow_physical+0x125>
        if (pn % 64 == 0) {
   41329:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4132c:	83 e0 3f             	and    $0x3f,%eax
   4132f:	85 c0                	test   %eax,%eax
   41331:	75 3c                	jne    4136f <memshow_physical+0x73>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   41333:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41336:	c1 e0 0c             	shl    $0xc,%eax
   41339:	89 c1                	mov    %eax,%ecx
   4133b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4133e:	8d 50 3f             	lea    0x3f(%rax),%edx
   41341:	85 c0                	test   %eax,%eax
   41343:	0f 48 c2             	cmovs  %edx,%eax
   41346:	c1 f8 06             	sar    $0x6,%eax
   41349:	8d 50 01             	lea    0x1(%rax),%edx
   4134c:	89 d0                	mov    %edx,%eax
   4134e:	c1 e0 02             	shl    $0x2,%eax
   41351:	01 d0                	add    %edx,%eax
   41353:	c1 e0 04             	shl    $0x4,%eax
   41356:	83 c0 03             	add    $0x3,%eax
   41359:	ba 36 45 04 00       	mov    $0x44536,%edx
   4135e:	be 00 0f 00 00       	mov    $0xf00,%esi
   41363:	89 c7                	mov    %eax,%edi
   41365:	b8 00 00 00 00       	mov    $0x0,%eax
   4136a:	e8 73 2c 00 00       	call   43fe2 <console_printf>
        }

        int owner = pageinfo[pn].owner;
   4136f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41372:	48 98                	cltq   
   41374:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   4137b:	00 
   4137c:	0f be c0             	movsbl %al,%eax
   4137f:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   41382:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41385:	48 98                	cltq   
   41387:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   4138e:	00 
   4138f:	84 c0                	test   %al,%al
   41391:	75 07                	jne    4139a <memshow_physical+0x9e>
            owner = PO_FREE;
   41393:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   4139a:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4139d:	83 c0 02             	add    $0x2,%eax
   413a0:	48 98                	cltq   
   413a2:	0f b7 84 00 00 45 04 	movzwl 0x44500(%rax,%rax,1),%eax
   413a9:	00 
   413aa:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   413ae:	8b 45 fc             	mov    -0x4(%rbp),%eax
   413b1:	48 98                	cltq   
   413b3:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   413ba:	00 
   413bb:	3c 01                	cmp    $0x1,%al
   413bd:	7e 1a                	jle    413d9 <memshow_physical+0xdd>
   413bf:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   413c4:	48 c1 e8 0c          	shr    $0xc,%rax
   413c8:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   413cb:	74 0c                	je     413d9 <memshow_physical+0xdd>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   413cd:	b8 53 00 00 00       	mov    $0x53,%eax
   413d2:	80 cc 0f             	or     $0xf,%ah
   413d5:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   413d9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   413dc:	8d 50 3f             	lea    0x3f(%rax),%edx
   413df:	85 c0                	test   %eax,%eax
   413e1:	0f 48 c2             	cmovs  %edx,%eax
   413e4:	c1 f8 06             	sar    $0x6,%eax
   413e7:	8d 50 01             	lea    0x1(%rax),%edx
   413ea:	89 d0                	mov    %edx,%eax
   413ec:	c1 e0 02             	shl    $0x2,%eax
   413ef:	01 d0                	add    %edx,%eax
   413f1:	c1 e0 04             	shl    $0x4,%eax
   413f4:	89 c1                	mov    %eax,%ecx
   413f6:	8b 55 fc             	mov    -0x4(%rbp),%edx
   413f9:	89 d0                	mov    %edx,%eax
   413fb:	c1 f8 1f             	sar    $0x1f,%eax
   413fe:	c1 e8 1a             	shr    $0x1a,%eax
   41401:	01 c2                	add    %eax,%edx
   41403:	83 e2 3f             	and    $0x3f,%edx
   41406:	29 c2                	sub    %eax,%edx
   41408:	89 d0                	mov    %edx,%eax
   4140a:	83 c0 0c             	add    $0xc,%eax
   4140d:	01 c8                	add    %ecx,%eax
   4140f:	48 98                	cltq   
   41411:	0f b7 55 f6          	movzwl -0xa(%rbp),%edx
   41415:	66 89 94 00 00 80 0b 	mov    %dx,0xb8000(%rax,%rax,1)
   4141c:	00 
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4141d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41421:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41428:	0f 8e fb fe ff ff    	jle    41329 <memshow_physical+0x2d>
    }
}
   4142e:	90                   	nop
   4142f:	90                   	nop
   41430:	c9                   	leave  
   41431:	c3                   	ret    

0000000000041432 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   41432:	55                   	push   %rbp
   41433:	48 89 e5             	mov    %rsp,%rbp
   41436:	48 83 ec 40          	sub    $0x40,%rsp
   4143a:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   4143e:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   41442:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41446:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4144c:	48 89 c2             	mov    %rax,%rdx
   4144f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41453:	48 39 c2             	cmp    %rax,%rdx
   41456:	74 14                	je     4146c <memshow_virtual+0x3a>
   41458:	ba 40 45 04 00       	mov    $0x44540,%edx
   4145d:	be 80 02 00 00       	mov    $0x280,%esi
   41462:	bf a0 41 04 00       	mov    $0x441a0,%edi
   41467:	e8 68 12 00 00       	call   426d4 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   4146c:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   41470:	48 89 c1             	mov    %rax,%rcx
   41473:	ba 6d 45 04 00       	mov    $0x4456d,%edx
   41478:	be 00 0f 00 00       	mov    $0xf00,%esi
   4147d:	bf 3a 03 00 00       	mov    $0x33a,%edi
   41482:	b8 00 00 00 00       	mov    $0x0,%eax
   41487:	e8 56 2b 00 00       	call   43fe2 <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   4148c:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   41493:	00 
   41494:	e9 80 01 00 00       	jmp    41619 <memshow_virtual+0x1e7>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   41499:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4149d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   414a1:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   414a5:	48 89 ce             	mov    %rcx,%rsi
   414a8:	48 89 c7             	mov    %rax,%rdi
   414ab:	e8 e9 18 00 00       	call   42d99 <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   414b0:	8b 45 d0             	mov    -0x30(%rbp),%eax
   414b3:	85 c0                	test   %eax,%eax
   414b5:	79 0b                	jns    414c2 <memshow_virtual+0x90>
            color = ' ';
   414b7:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   414bd:	e9 d7 00 00 00       	jmp    41599 <memshow_virtual+0x167>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   414c2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   414c6:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   414cc:	76 14                	jbe    414e2 <memshow_virtual+0xb0>
   414ce:	ba 8a 45 04 00       	mov    $0x4458a,%edx
   414d3:	be 89 02 00 00       	mov    $0x289,%esi
   414d8:	bf a0 41 04 00       	mov    $0x441a0,%edi
   414dd:	e8 f2 11 00 00       	call   426d4 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   414e2:	8b 45 d0             	mov    -0x30(%rbp),%eax
   414e5:	48 98                	cltq   
   414e7:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   414ee:	00 
   414ef:	0f be c0             	movsbl %al,%eax
   414f2:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   414f5:	8b 45 d0             	mov    -0x30(%rbp),%eax
   414f8:	48 98                	cltq   
   414fa:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   41501:	00 
   41502:	84 c0                	test   %al,%al
   41504:	75 07                	jne    4150d <memshow_virtual+0xdb>
                owner = PO_FREE;
   41506:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   4150d:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41510:	83 c0 02             	add    $0x2,%eax
   41513:	48 98                	cltq   
   41515:	0f b7 84 00 00 45 04 	movzwl 0x44500(%rax,%rax,1),%eax
   4151c:	00 
   4151d:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   41521:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41524:	48 98                	cltq   
   41526:	83 e0 04             	and    $0x4,%eax
   41529:	48 85 c0             	test   %rax,%rax
   4152c:	74 27                	je     41555 <memshow_virtual+0x123>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   4152e:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41532:	c1 e0 04             	shl    $0x4,%eax
   41535:	66 25 00 f0          	and    $0xf000,%ax
   41539:	89 c2                	mov    %eax,%edx
   4153b:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4153f:	c1 f8 04             	sar    $0x4,%eax
   41542:	66 25 00 0f          	and    $0xf00,%ax
   41546:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   41548:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4154c:	0f b6 c0             	movzbl %al,%eax
   4154f:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41551:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   41555:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41558:	48 98                	cltq   
   4155a:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   41561:	00 
   41562:	3c 01                	cmp    $0x1,%al
   41564:	7e 33                	jle    41599 <memshow_virtual+0x167>
   41566:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   4156b:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4156f:	74 28                	je     41599 <memshow_virtual+0x167>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   41571:	b8 53 00 00 00       	mov    $0x53,%eax
   41576:	89 c2                	mov    %eax,%edx
   41578:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4157c:	66 25 00 f0          	and    $0xf000,%ax
   41580:	09 d0                	or     %edx,%eax
   41582:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   41586:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41589:	48 98                	cltq   
   4158b:	83 e0 04             	and    $0x4,%eax
   4158e:	48 85 c0             	test   %rax,%rax
   41591:	75 06                	jne    41599 <memshow_virtual+0x167>
                    color = color | 0x0F00;
   41593:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   41599:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4159d:	48 c1 e8 0c          	shr    $0xc,%rax
   415a1:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   415a4:	8b 45 ec             	mov    -0x14(%rbp),%eax
   415a7:	83 e0 3f             	and    $0x3f,%eax
   415aa:	85 c0                	test   %eax,%eax
   415ac:	75 34                	jne    415e2 <memshow_virtual+0x1b0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   415ae:	8b 45 ec             	mov    -0x14(%rbp),%eax
   415b1:	c1 e8 06             	shr    $0x6,%eax
   415b4:	89 c2                	mov    %eax,%edx
   415b6:	89 d0                	mov    %edx,%eax
   415b8:	c1 e0 02             	shl    $0x2,%eax
   415bb:	01 d0                	add    %edx,%eax
   415bd:	c1 e0 04             	shl    $0x4,%eax
   415c0:	05 73 03 00 00       	add    $0x373,%eax
   415c5:	89 c7                	mov    %eax,%edi
   415c7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   415cb:	48 89 c1             	mov    %rax,%rcx
   415ce:	ba 36 45 04 00       	mov    $0x44536,%edx
   415d3:	be 00 0f 00 00       	mov    $0xf00,%esi
   415d8:	b8 00 00 00 00       	mov    $0x0,%eax
   415dd:	e8 00 2a 00 00       	call   43fe2 <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   415e2:	8b 45 ec             	mov    -0x14(%rbp),%eax
   415e5:	c1 e8 06             	shr    $0x6,%eax
   415e8:	89 c2                	mov    %eax,%edx
   415ea:	89 d0                	mov    %edx,%eax
   415ec:	c1 e0 02             	shl    $0x2,%eax
   415ef:	01 d0                	add    %edx,%eax
   415f1:	c1 e0 04             	shl    $0x4,%eax
   415f4:	89 c2                	mov    %eax,%edx
   415f6:	8b 45 ec             	mov    -0x14(%rbp),%eax
   415f9:	83 e0 3f             	and    $0x3f,%eax
   415fc:	01 d0                	add    %edx,%eax
   415fe:	05 7c 03 00 00       	add    $0x37c,%eax
   41603:	89 c2                	mov    %eax,%edx
   41605:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41609:	66 89 84 12 00 80 0b 	mov    %ax,0xb8000(%rdx,%rdx,1)
   41610:	00 
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41611:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41618:	00 
   41619:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   41620:	00 
   41621:	0f 86 72 fe ff ff    	jbe    41499 <memshow_virtual+0x67>
    }
}
   41627:	90                   	nop
   41628:	90                   	nop
   41629:	c9                   	leave  
   4162a:	c3                   	ret    

000000000004162b <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   4162b:	55                   	push   %rbp
   4162c:	48 89 e5             	mov    %rsp,%rbp
   4162f:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   41633:	8b 05 07 1c 01 00    	mov    0x11c07(%rip),%eax        # 53240 <last_ticks.1>
   41639:	85 c0                	test   %eax,%eax
   4163b:	74 13                	je     41650 <memshow_virtual_animate+0x25>
   4163d:	8b 15 dd 17 01 00    	mov    0x117dd(%rip),%edx        # 52e20 <ticks>
   41643:	8b 05 f7 1b 01 00    	mov    0x11bf7(%rip),%eax        # 53240 <last_ticks.1>
   41649:	29 c2                	sub    %eax,%edx
   4164b:	83 fa 31             	cmp    $0x31,%edx
   4164e:	76 2c                	jbe    4167c <memshow_virtual_animate+0x51>
        last_ticks = ticks;
   41650:	8b 05 ca 17 01 00    	mov    0x117ca(%rip),%eax        # 52e20 <ticks>
   41656:	89 05 e4 1b 01 00    	mov    %eax,0x11be4(%rip)        # 53240 <last_ticks.1>
        ++showing;
   4165c:	8b 05 a2 39 00 00    	mov    0x39a2(%rip),%eax        # 45004 <showing.0>
   41662:	83 c0 01             	add    $0x1,%eax
   41665:	89 05 99 39 00 00    	mov    %eax,0x3999(%rip)        # 45004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   4166b:	eb 0f                	jmp    4167c <memshow_virtual_animate+0x51>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
        ++showing;
   4166d:	8b 05 91 39 00 00    	mov    0x3991(%rip),%eax        # 45004 <showing.0>
   41673:	83 c0 01             	add    $0x1,%eax
   41676:	89 05 88 39 00 00    	mov    %eax,0x3988(%rip)        # 45004 <showing.0>
    while (showing <= 2*NPROC
   4167c:	8b 05 82 39 00 00    	mov    0x3982(%rip),%eax        # 45004 <showing.0>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
   41682:	83 f8 20             	cmp    $0x20,%eax
   41685:	7f 6d                	jg     416f4 <memshow_virtual_animate+0xc9>
   41687:	8b 15 77 39 00 00    	mov    0x3977(%rip),%edx        # 45004 <showing.0>
   4168d:	89 d0                	mov    %edx,%eax
   4168f:	c1 f8 1f             	sar    $0x1f,%eax
   41692:	c1 e8 1c             	shr    $0x1c,%eax
   41695:	01 c2                	add    %eax,%edx
   41697:	83 e2 0f             	and    $0xf,%edx
   4169a:	29 c2                	sub    %eax,%edx
   4169c:	89 d0                	mov    %edx,%eax
   4169e:	48 63 d0             	movslq %eax,%rdx
   416a1:	48 89 d0             	mov    %rdx,%rax
   416a4:	48 c1 e0 03          	shl    $0x3,%rax
   416a8:	48 29 d0             	sub    %rdx,%rax
   416ab:	48 c1 e0 05          	shl    $0x5,%rax
   416af:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   416b5:	8b 00                	mov    (%rax),%eax
   416b7:	85 c0                	test   %eax,%eax
   416b9:	74 b2                	je     4166d <memshow_virtual_animate+0x42>
   416bb:	8b 15 43 39 00 00    	mov    0x3943(%rip),%edx        # 45004 <showing.0>
   416c1:	89 d0                	mov    %edx,%eax
   416c3:	c1 f8 1f             	sar    $0x1f,%eax
   416c6:	c1 e8 1c             	shr    $0x1c,%eax
   416c9:	01 c2                	add    %eax,%edx
   416cb:	83 e2 0f             	and    $0xf,%edx
   416ce:	29 c2                	sub    %eax,%edx
   416d0:	89 d0                	mov    %edx,%eax
   416d2:	48 63 d0             	movslq %eax,%rdx
   416d5:	48 89 d0             	mov    %rdx,%rax
   416d8:	48 c1 e0 03          	shl    $0x3,%rax
   416dc:	48 29 d0             	sub    %rdx,%rax
   416df:	48 c1 e0 05          	shl    $0x5,%rax
   416e3:	48 05 f8 20 05 00    	add    $0x520f8,%rax
   416e9:	0f b6 00             	movzbl (%rax),%eax
   416ec:	84 c0                	test   %al,%al
   416ee:	0f 84 79 ff ff ff    	je     4166d <memshow_virtual_animate+0x42>
    }
    showing = showing % NPROC;
   416f4:	8b 15 0a 39 00 00    	mov    0x390a(%rip),%edx        # 45004 <showing.0>
   416fa:	89 d0                	mov    %edx,%eax
   416fc:	c1 f8 1f             	sar    $0x1f,%eax
   416ff:	c1 e8 1c             	shr    $0x1c,%eax
   41702:	01 c2                	add    %eax,%edx
   41704:	83 e2 0f             	and    $0xf,%edx
   41707:	29 c2                	sub    %eax,%edx
   41709:	89 d0                	mov    %edx,%eax
   4170b:	89 05 f3 38 00 00    	mov    %eax,0x38f3(%rip)        # 45004 <showing.0>

    if (processes[showing].p_state != P_FREE) {
   41711:	8b 05 ed 38 00 00    	mov    0x38ed(%rip),%eax        # 45004 <showing.0>
   41717:	48 63 d0             	movslq %eax,%rdx
   4171a:	48 89 d0             	mov    %rdx,%rax
   4171d:	48 c1 e0 03          	shl    $0x3,%rax
   41721:	48 29 d0             	sub    %rdx,%rax
   41724:	48 c1 e0 05          	shl    $0x5,%rax
   41728:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   4172e:	8b 00                	mov    (%rax),%eax
   41730:	85 c0                	test   %eax,%eax
   41732:	74 52                	je     41786 <memshow_virtual_animate+0x15b>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   41734:	8b 15 ca 38 00 00    	mov    0x38ca(%rip),%edx        # 45004 <showing.0>
   4173a:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   4173e:	89 d1                	mov    %edx,%ecx
   41740:	ba a4 45 04 00       	mov    $0x445a4,%edx
   41745:	be 04 00 00 00       	mov    $0x4,%esi
   4174a:	48 89 c7             	mov    %rax,%rdi
   4174d:	b8 00 00 00 00       	mov    $0x0,%eax
   41752:	e8 97 29 00 00       	call   440ee <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   41757:	8b 05 a7 38 00 00    	mov    0x38a7(%rip),%eax        # 45004 <showing.0>
   4175d:	48 63 d0             	movslq %eax,%rdx
   41760:	48 89 d0             	mov    %rdx,%rax
   41763:	48 c1 e0 03          	shl    $0x3,%rax
   41767:	48 29 d0             	sub    %rdx,%rax
   4176a:	48 c1 e0 05          	shl    $0x5,%rax
   4176e:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   41774:	48 8b 00             	mov    (%rax),%rax
   41777:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   4177b:	48 89 d6             	mov    %rdx,%rsi
   4177e:	48 89 c7             	mov    %rax,%rdi
   41781:	e8 ac fc ff ff       	call   41432 <memshow_virtual>
    }
}
   41786:	90                   	nop
   41787:	c9                   	leave  
   41788:	c3                   	ret    

0000000000041789 <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   41789:	55                   	push   %rbp
   4178a:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   4178d:	e8 4f 01 00 00       	call   418e1 <segments_init>
    interrupt_init();
   41792:	e8 d0 03 00 00       	call   41b67 <interrupt_init>
    virtual_memory_init();
   41797:	e8 f3 0f 00 00       	call   4278f <virtual_memory_init>
}
   4179c:	90                   	nop
   4179d:	5d                   	pop    %rbp
   4179e:	c3                   	ret    

000000000004179f <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   4179f:	55                   	push   %rbp
   417a0:	48 89 e5             	mov    %rsp,%rbp
   417a3:	48 83 ec 18          	sub    $0x18,%rsp
   417a7:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   417ab:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   417af:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   417b2:	8b 45 ec             	mov    -0x14(%rbp),%eax
   417b5:	48 98                	cltq   
   417b7:	48 c1 e0 2d          	shl    $0x2d,%rax
   417bb:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   417bf:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   417c6:	90 00 00 
   417c9:	48 09 c2             	or     %rax,%rdx
    *segment = type
   417cc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   417d0:	48 89 10             	mov    %rdx,(%rax)
}
   417d3:	90                   	nop
   417d4:	c9                   	leave  
   417d5:	c3                   	ret    

00000000000417d6 <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   417d6:	55                   	push   %rbp
   417d7:	48 89 e5             	mov    %rsp,%rbp
   417da:	48 83 ec 28          	sub    $0x28,%rsp
   417de:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   417e2:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   417e6:	89 55 ec             	mov    %edx,-0x14(%rbp)
   417e9:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   417ed:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   417f1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   417f5:	48 c1 e0 10          	shl    $0x10,%rax
   417f9:	48 89 c2             	mov    %rax,%rdx
   417fc:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   41803:	00 00 00 
   41806:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   41809:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4180d:	48 c1 e0 20          	shl    $0x20,%rax
   41811:	48 89 c1             	mov    %rax,%rcx
   41814:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   4181b:	00 00 ff 
   4181e:	48 21 c8             	and    %rcx,%rax
   41821:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   41824:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41828:	48 83 e8 01          	sub    $0x1,%rax
   4182c:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   4182f:	48 09 d0             	or     %rdx,%rax
        | type
   41832:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   41836:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41839:	48 63 d2             	movslq %edx,%rdx
   4183c:	48 c1 e2 2d          	shl    $0x2d,%rdx
   41840:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   41843:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   4184a:	80 00 00 
   4184d:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41850:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41854:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   41857:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4185b:	48 83 c0 08          	add    $0x8,%rax
   4185f:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   41863:	48 c1 ea 20          	shr    $0x20,%rdx
   41867:	48 89 10             	mov    %rdx,(%rax)
}
   4186a:	90                   	nop
   4186b:	c9                   	leave  
   4186c:	c3                   	ret    

000000000004186d <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   4186d:	55                   	push   %rbp
   4186e:	48 89 e5             	mov    %rsp,%rbp
   41871:	48 83 ec 20          	sub    $0x20,%rsp
   41875:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41879:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   4187d:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41880:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41884:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41888:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   4188b:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   4188f:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41892:	48 63 d2             	movslq %edx,%rdx
   41895:	48 c1 e2 2d          	shl    $0x2d,%rdx
   41899:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   4189c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   418a0:	48 c1 e0 20          	shl    $0x20,%rax
   418a4:	48 89 c1             	mov    %rax,%rcx
   418a7:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   418ae:	00 ff ff 
   418b1:	48 21 c8             	and    %rcx,%rax
   418b4:	48 09 c2             	or     %rax,%rdx
   418b7:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   418be:	80 00 00 
   418c1:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   418c4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   418c8:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   418cb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   418cf:	48 c1 e8 20          	shr    $0x20,%rax
   418d3:	48 89 c2             	mov    %rax,%rdx
   418d6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   418da:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   418de:	90                   	nop
   418df:	c9                   	leave  
   418e0:	c3                   	ret    

00000000000418e1 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   418e1:	55                   	push   %rbp
   418e2:	48 89 e5             	mov    %rsp,%rbp
   418e5:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   418e9:	48 c7 05 6c 19 01 00 	movq   $0x0,0x1196c(%rip)        # 53260 <segments>
   418f0:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   418f4:	ba 00 00 00 00       	mov    $0x0,%edx
   418f9:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41900:	08 20 00 
   41903:	48 89 c6             	mov    %rax,%rsi
   41906:	bf 68 32 05 00       	mov    $0x53268,%edi
   4190b:	e8 8f fe ff ff       	call   4179f <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   41910:	ba 03 00 00 00       	mov    $0x3,%edx
   41915:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   4191c:	08 20 00 
   4191f:	48 89 c6             	mov    %rax,%rsi
   41922:	bf 70 32 05 00       	mov    $0x53270,%edi
   41927:	e8 73 fe ff ff       	call   4179f <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   4192c:	ba 00 00 00 00       	mov    $0x0,%edx
   41931:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41938:	02 00 00 
   4193b:	48 89 c6             	mov    %rax,%rsi
   4193e:	bf 78 32 05 00       	mov    $0x53278,%edi
   41943:	e8 57 fe ff ff       	call   4179f <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   41948:	ba 03 00 00 00       	mov    $0x3,%edx
   4194d:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41954:	02 00 00 
   41957:	48 89 c6             	mov    %rax,%rsi
   4195a:	bf 80 32 05 00       	mov    $0x53280,%edi
   4195f:	e8 3b fe ff ff       	call   4179f <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   41964:	b8 a0 42 05 00       	mov    $0x542a0,%eax
   41969:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   4196f:	48 89 c1             	mov    %rax,%rcx
   41972:	ba 00 00 00 00       	mov    $0x0,%edx
   41977:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   4197e:	09 00 00 
   41981:	48 89 c6             	mov    %rax,%rsi
   41984:	bf 88 32 05 00       	mov    $0x53288,%edi
   41989:	e8 48 fe ff ff       	call   417d6 <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   4198e:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   41994:	b8 60 32 05 00       	mov    $0x53260,%eax
   41999:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   4199d:	ba 60 00 00 00       	mov    $0x60,%edx
   419a2:	be 00 00 00 00       	mov    $0x0,%esi
   419a7:	bf a0 42 05 00       	mov    $0x542a0,%edi
   419ac:	e8 7a 18 00 00       	call   4322b <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   419b1:	48 c7 05 e8 28 01 00 	movq   $0x80000,0x128e8(%rip)        # 542a4 <kernel_task_descriptor+0x4>
   419b8:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   419bc:	ba 00 10 00 00       	mov    $0x1000,%edx
   419c1:	be 00 00 00 00       	mov    $0x0,%esi
   419c6:	bf a0 32 05 00       	mov    $0x532a0,%edi
   419cb:	e8 5b 18 00 00       	call   4322b <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   419d0:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   419d7:	eb 30                	jmp    41a09 <segments_init+0x128>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   419d9:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   419de:	8b 45 fc             	mov    -0x4(%rbp),%eax
   419e1:	48 c1 e0 04          	shl    $0x4,%rax
   419e5:	48 05 a0 32 05 00    	add    $0x532a0,%rax
   419eb:	48 89 d1             	mov    %rdx,%rcx
   419ee:	ba 00 00 00 00       	mov    $0x0,%edx
   419f3:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   419fa:	0e 00 00 
   419fd:	48 89 c7             	mov    %rax,%rdi
   41a00:	e8 68 fe ff ff       	call   4186d <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41a05:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41a09:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   41a10:	76 c7                	jbe    419d9 <segments_init+0xf8>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   41a12:	b8 36 00 04 00       	mov    $0x40036,%eax
   41a17:	48 89 c1             	mov    %rax,%rcx
   41a1a:	ba 00 00 00 00       	mov    $0x0,%edx
   41a1f:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41a26:	0e 00 00 
   41a29:	48 89 c6             	mov    %rax,%rsi
   41a2c:	bf a0 34 05 00       	mov    $0x534a0,%edi
   41a31:	e8 37 fe ff ff       	call   4186d <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   41a36:	b8 2e 00 04 00       	mov    $0x4002e,%eax
   41a3b:	48 89 c1             	mov    %rax,%rcx
   41a3e:	ba 00 00 00 00       	mov    $0x0,%edx
   41a43:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41a4a:	0e 00 00 
   41a4d:	48 89 c6             	mov    %rax,%rsi
   41a50:	bf 70 33 05 00       	mov    $0x53370,%edi
   41a55:	e8 13 fe ff ff       	call   4186d <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   41a5a:	b8 32 00 04 00       	mov    $0x40032,%eax
   41a5f:	48 89 c1             	mov    %rax,%rcx
   41a62:	ba 00 00 00 00       	mov    $0x0,%edx
   41a67:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41a6e:	0e 00 00 
   41a71:	48 89 c6             	mov    %rax,%rsi
   41a74:	bf 80 33 05 00       	mov    $0x53380,%edi
   41a79:	e8 ef fd ff ff       	call   4186d <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41a7e:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   41a85:	eb 3e                	jmp    41ac5 <segments_init+0x1e4>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   41a87:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41a8a:	83 e8 30             	sub    $0x30,%eax
   41a8d:	89 c0                	mov    %eax,%eax
   41a8f:	48 8b 04 c5 e7 00 04 	mov    0x400e7(,%rax,8),%rax
   41a96:	00 
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   41a97:	48 89 c2             	mov    %rax,%rdx
   41a9a:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41a9d:	48 c1 e0 04          	shl    $0x4,%rax
   41aa1:	48 05 a0 32 05 00    	add    $0x532a0,%rax
   41aa7:	48 89 d1             	mov    %rdx,%rcx
   41aaa:	ba 03 00 00 00       	mov    $0x3,%edx
   41aaf:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41ab6:	0e 00 00 
   41ab9:	48 89 c7             	mov    %rax,%rdi
   41abc:	e8 ac fd ff ff       	call   4186d <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41ac1:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41ac5:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   41ac9:	76 bc                	jbe    41a87 <segments_init+0x1a6>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   41acb:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   41ad1:	b8 a0 32 05 00       	mov    $0x532a0,%eax
   41ad6:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   41ada:	b8 28 00 00 00       	mov    $0x28,%eax
   41adf:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   41ae3:	0f 00 d8             	ltr    %ax
   41ae6:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   41aea:	0f 20 c0             	mov    %cr0,%rax
   41aed:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   41af1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   41af5:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   41af8:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   41aff:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41b02:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   41b05:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41b08:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   41b0c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41b10:	0f 22 c0             	mov    %rax,%cr0
}
   41b13:	90                   	nop
    lcr0(cr0);
}
   41b14:	90                   	nop
   41b15:	c9                   	leave  
   41b16:	c3                   	ret    

0000000000041b17 <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   41b17:	55                   	push   %rbp
   41b18:	48 89 e5             	mov    %rsp,%rbp
   41b1b:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   41b1f:	0f b7 05 da 27 01 00 	movzwl 0x127da(%rip),%eax        # 54300 <interrupts_enabled>
   41b26:	f7 d0                	not    %eax
   41b28:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   41b2c:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41b30:	0f b6 c0             	movzbl %al,%eax
   41b33:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   41b3a:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b3d:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   41b41:	8b 55 f0             	mov    -0x10(%rbp),%edx
   41b44:	ee                   	out    %al,(%dx)
}
   41b45:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   41b46:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41b4a:	66 c1 e8 08          	shr    $0x8,%ax
   41b4e:	0f b6 c0             	movzbl %al,%eax
   41b51:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   41b58:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b5b:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   41b5f:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41b62:	ee                   	out    %al,(%dx)
}
   41b63:	90                   	nop
}
   41b64:	90                   	nop
   41b65:	c9                   	leave  
   41b66:	c3                   	ret    

0000000000041b67 <interrupt_init>:

void interrupt_init(void) {
   41b67:	55                   	push   %rbp
   41b68:	48 89 e5             	mov    %rsp,%rbp
   41b6b:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   41b6f:	66 c7 05 88 27 01 00 	movw   $0x0,0x12788(%rip)        # 54300 <interrupts_enabled>
   41b76:	00 00 
    interrupt_mask();
   41b78:	e8 9a ff ff ff       	call   41b17 <interrupt_mask>
   41b7d:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   41b84:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b88:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   41b8c:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   41b8f:	ee                   	out    %al,(%dx)
}
   41b90:	90                   	nop
   41b91:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   41b98:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b9c:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   41ba0:	8b 55 ac             	mov    -0x54(%rbp),%edx
   41ba3:	ee                   	out    %al,(%dx)
}
   41ba4:	90                   	nop
   41ba5:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   41bac:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41bb0:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   41bb4:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   41bb7:	ee                   	out    %al,(%dx)
}
   41bb8:	90                   	nop
   41bb9:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   41bc0:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41bc4:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   41bc8:	8b 55 bc             	mov    -0x44(%rbp),%edx
   41bcb:	ee                   	out    %al,(%dx)
}
   41bcc:	90                   	nop
   41bcd:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   41bd4:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41bd8:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   41bdc:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   41bdf:	ee                   	out    %al,(%dx)
}
   41be0:	90                   	nop
   41be1:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   41be8:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41bec:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   41bf0:	8b 55 cc             	mov    -0x34(%rbp),%edx
   41bf3:	ee                   	out    %al,(%dx)
}
   41bf4:	90                   	nop
   41bf5:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   41bfc:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c00:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   41c04:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   41c07:	ee                   	out    %al,(%dx)
}
   41c08:	90                   	nop
   41c09:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   41c10:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c14:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   41c18:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41c1b:	ee                   	out    %al,(%dx)
}
   41c1c:	90                   	nop
   41c1d:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   41c24:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c28:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41c2c:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41c2f:	ee                   	out    %al,(%dx)
}
   41c30:	90                   	nop
   41c31:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   41c38:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c3c:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41c40:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41c43:	ee                   	out    %al,(%dx)
}
   41c44:	90                   	nop
   41c45:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   41c4c:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c50:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41c54:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41c57:	ee                   	out    %al,(%dx)
}
   41c58:	90                   	nop
   41c59:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   41c60:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c64:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41c68:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41c6b:	ee                   	out    %al,(%dx)
}
   41c6c:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   41c6d:	e8 a5 fe ff ff       	call   41b17 <interrupt_mask>
}
   41c72:	90                   	nop
   41c73:	c9                   	leave  
   41c74:	c3                   	ret    

0000000000041c75 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   41c75:	55                   	push   %rbp
   41c76:	48 89 e5             	mov    %rsp,%rbp
   41c79:	48 83 ec 28          	sub    $0x28,%rsp
   41c7d:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   41c80:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41c84:	0f 8e 9e 00 00 00    	jle    41d28 <timer_init+0xb3>
   41c8a:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   41c91:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c95:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41c99:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41c9c:	ee                   	out    %al,(%dx)
}
   41c9d:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   41c9e:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41ca1:	89 c2                	mov    %eax,%edx
   41ca3:	c1 ea 1f             	shr    $0x1f,%edx
   41ca6:	01 d0                	add    %edx,%eax
   41ca8:	d1 f8                	sar    %eax
   41caa:	05 de 34 12 00       	add    $0x1234de,%eax
   41caf:	99                   	cltd   
   41cb0:	f7 7d dc             	idivl  -0x24(%rbp)
   41cb3:	89 c2                	mov    %eax,%edx
   41cb5:	89 d0                	mov    %edx,%eax
   41cb7:	c1 f8 1f             	sar    $0x1f,%eax
   41cba:	c1 e8 18             	shr    $0x18,%eax
   41cbd:	01 c2                	add    %eax,%edx
   41cbf:	0f b6 d2             	movzbl %dl,%edx
   41cc2:	29 c2                	sub    %eax,%edx
   41cc4:	89 d0                	mov    %edx,%eax
   41cc6:	0f b6 c0             	movzbl %al,%eax
   41cc9:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   41cd0:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41cd3:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41cd7:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41cda:	ee                   	out    %al,(%dx)
}
   41cdb:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   41cdc:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41cdf:	89 c2                	mov    %eax,%edx
   41ce1:	c1 ea 1f             	shr    $0x1f,%edx
   41ce4:	01 d0                	add    %edx,%eax
   41ce6:	d1 f8                	sar    %eax
   41ce8:	05 de 34 12 00       	add    $0x1234de,%eax
   41ced:	99                   	cltd   
   41cee:	f7 7d dc             	idivl  -0x24(%rbp)
   41cf1:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41cf7:	85 c0                	test   %eax,%eax
   41cf9:	0f 48 c2             	cmovs  %edx,%eax
   41cfc:	c1 f8 08             	sar    $0x8,%eax
   41cff:	0f b6 c0             	movzbl %al,%eax
   41d02:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   41d09:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d0c:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41d10:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41d13:	ee                   	out    %al,(%dx)
}
   41d14:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   41d15:	0f b7 05 e4 25 01 00 	movzwl 0x125e4(%rip),%eax        # 54300 <interrupts_enabled>
   41d1c:	83 c8 01             	or     $0x1,%eax
   41d1f:	66 89 05 da 25 01 00 	mov    %ax,0x125da(%rip)        # 54300 <interrupts_enabled>
   41d26:	eb 11                	jmp    41d39 <timer_init+0xc4>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   41d28:	0f b7 05 d1 25 01 00 	movzwl 0x125d1(%rip),%eax        # 54300 <interrupts_enabled>
   41d2f:	83 e0 fe             	and    $0xfffffffe,%eax
   41d32:	66 89 05 c7 25 01 00 	mov    %ax,0x125c7(%rip)        # 54300 <interrupts_enabled>
    }
    interrupt_mask();
   41d39:	e8 d9 fd ff ff       	call   41b17 <interrupt_mask>
}
   41d3e:	90                   	nop
   41d3f:	c9                   	leave  
   41d40:	c3                   	ret    

0000000000041d41 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   41d41:	55                   	push   %rbp
   41d42:	48 89 e5             	mov    %rsp,%rbp
   41d45:	48 83 ec 08          	sub    $0x8,%rsp
   41d49:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   41d4d:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   41d52:	74 14                	je     41d68 <physical_memory_isreserved+0x27>
   41d54:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   41d5b:	00 
   41d5c:	76 11                	jbe    41d6f <physical_memory_isreserved+0x2e>
   41d5e:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   41d65:	00 
   41d66:	77 07                	ja     41d6f <physical_memory_isreserved+0x2e>
   41d68:	b8 01 00 00 00       	mov    $0x1,%eax
   41d6d:	eb 05                	jmp    41d74 <physical_memory_isreserved+0x33>
   41d6f:	b8 00 00 00 00       	mov    $0x0,%eax
}
   41d74:	c9                   	leave  
   41d75:	c3                   	ret    

0000000000041d76 <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   41d76:	55                   	push   %rbp
   41d77:	48 89 e5             	mov    %rsp,%rbp
   41d7a:	48 83 ec 10          	sub    $0x10,%rsp
   41d7e:	89 7d fc             	mov    %edi,-0x4(%rbp)
   41d81:	89 75 f8             	mov    %esi,-0x8(%rbp)
   41d84:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   41d87:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41d8a:	c1 e0 10             	shl    $0x10,%eax
   41d8d:	89 c2                	mov    %eax,%edx
   41d8f:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41d92:	c1 e0 0b             	shl    $0xb,%eax
   41d95:	09 c2                	or     %eax,%edx
   41d97:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41d9a:	c1 e0 08             	shl    $0x8,%eax
   41d9d:	09 d0                	or     %edx,%eax
}
   41d9f:	c9                   	leave  
   41da0:	c3                   	ret    

0000000000041da1 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   41da1:	55                   	push   %rbp
   41da2:	48 89 e5             	mov    %rsp,%rbp
   41da5:	48 83 ec 18          	sub    $0x18,%rsp
   41da9:	89 7d ec             	mov    %edi,-0x14(%rbp)
   41dac:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   41daf:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41db2:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41db5:	09 d0                	or     %edx,%eax
   41db7:	0d 00 00 00 80       	or     $0x80000000,%eax
   41dbc:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   41dc3:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   41dc6:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41dc9:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41dcc:	ef                   	out    %eax,(%dx)
}
   41dcd:	90                   	nop
   41dce:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   41dd5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41dd8:	89 c2                	mov    %eax,%edx
   41dda:	ed                   	in     (%dx),%eax
   41ddb:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   41dde:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   41de1:	c9                   	leave  
   41de2:	c3                   	ret    

0000000000041de3 <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   41de3:	55                   	push   %rbp
   41de4:	48 89 e5             	mov    %rsp,%rbp
   41de7:	48 83 ec 28          	sub    $0x28,%rsp
   41deb:	89 7d dc             	mov    %edi,-0x24(%rbp)
   41dee:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   41df1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41df8:	eb 73                	jmp    41e6d <pci_find_device+0x8a>
        for (int slot = 0; slot != 32; ++slot) {
   41dfa:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41e01:	eb 60                	jmp    41e63 <pci_find_device+0x80>
            for (int func = 0; func != 8; ++func) {
   41e03:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41e0a:	eb 4a                	jmp    41e56 <pci_find_device+0x73>
                int configaddr = pci_make_configaddr(bus, slot, func);
   41e0c:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41e0f:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41e12:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41e15:	89 ce                	mov    %ecx,%esi
   41e17:	89 c7                	mov    %eax,%edi
   41e19:	e8 58 ff ff ff       	call   41d76 <pci_make_configaddr>
   41e1e:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   41e21:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41e24:	be 00 00 00 00       	mov    $0x0,%esi
   41e29:	89 c7                	mov    %eax,%edi
   41e2b:	e8 71 ff ff ff       	call   41da1 <pci_config_readl>
   41e30:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   41e33:	8b 45 d8             	mov    -0x28(%rbp),%eax
   41e36:	c1 e0 10             	shl    $0x10,%eax
   41e39:	0b 45 dc             	or     -0x24(%rbp),%eax
   41e3c:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   41e3f:	75 05                	jne    41e46 <pci_find_device+0x63>
                    return configaddr;
   41e41:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41e44:	eb 35                	jmp    41e7b <pci_find_device+0x98>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   41e46:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   41e4a:	75 06                	jne    41e52 <pci_find_device+0x6f>
   41e4c:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41e50:	74 0c                	je     41e5e <pci_find_device+0x7b>
            for (int func = 0; func != 8; ++func) {
   41e52:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41e56:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   41e5a:	75 b0                	jne    41e0c <pci_find_device+0x29>
   41e5c:	eb 01                	jmp    41e5f <pci_find_device+0x7c>
                    break;
   41e5e:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   41e5f:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41e63:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   41e67:	75 9a                	jne    41e03 <pci_find_device+0x20>
    for (int bus = 0; bus != 256; ++bus) {
   41e69:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41e6d:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   41e74:	75 84                	jne    41dfa <pci_find_device+0x17>
                }
            }
        }
    }
    return -1;
   41e76:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   41e7b:	c9                   	leave  
   41e7c:	c3                   	ret    

0000000000041e7d <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   41e7d:	55                   	push   %rbp
   41e7e:	48 89 e5             	mov    %rsp,%rbp
   41e81:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   41e85:	be 13 71 00 00       	mov    $0x7113,%esi
   41e8a:	bf 86 80 00 00       	mov    $0x8086,%edi
   41e8f:	e8 4f ff ff ff       	call   41de3 <pci_find_device>
   41e94:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   41e97:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   41e9b:	78 30                	js     41ecd <poweroff+0x50>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   41e9d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41ea0:	be 40 00 00 00       	mov    $0x40,%esi
   41ea5:	89 c7                	mov    %eax,%edi
   41ea7:	e8 f5 fe ff ff       	call   41da1 <pci_config_readl>
   41eac:	25 c0 ff 00 00       	and    $0xffc0,%eax
   41eb1:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   41eb4:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41eb7:	83 c0 04             	add    $0x4,%eax
   41eba:	89 45 f4             	mov    %eax,-0xc(%rbp)
   41ebd:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   41ec3:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   41ec7:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41eca:	66 ef                	out    %ax,(%dx)
}
   41ecc:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   41ecd:	ba c0 45 04 00       	mov    $0x445c0,%edx
   41ed2:	be 00 c0 00 00       	mov    $0xc000,%esi
   41ed7:	bf 80 07 00 00       	mov    $0x780,%edi
   41edc:	b8 00 00 00 00       	mov    $0x0,%eax
   41ee1:	e8 fc 20 00 00       	call   43fe2 <console_printf>
 spinloop: goto spinloop;
   41ee6:	eb fe                	jmp    41ee6 <poweroff+0x69>

0000000000041ee8 <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   41ee8:	55                   	push   %rbp
   41ee9:	48 89 e5             	mov    %rsp,%rbp
   41eec:	48 83 ec 10          	sub    $0x10,%rsp
   41ef0:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   41ef7:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41efb:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41eff:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41f02:	ee                   	out    %al,(%dx)
}
   41f03:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   41f04:	eb fe                	jmp    41f04 <reboot+0x1c>

0000000000041f06 <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   41f06:	55                   	push   %rbp
   41f07:	48 89 e5             	mov    %rsp,%rbp
   41f0a:	48 83 ec 10          	sub    $0x10,%rsp
   41f0e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41f12:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   41f15:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41f19:	48 83 c0 08          	add    $0x8,%rax
   41f1d:	ba c0 00 00 00       	mov    $0xc0,%edx
   41f22:	be 00 00 00 00       	mov    $0x0,%esi
   41f27:	48 89 c7             	mov    %rax,%rdi
   41f2a:	e8 fc 12 00 00       	call   4322b <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   41f2f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41f33:	66 c7 80 a8 00 00 00 	movw   $0x13,0xa8(%rax)
   41f3a:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   41f3c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41f40:	48 c7 80 80 00 00 00 	movq   $0x23,0x80(%rax)
   41f47:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   41f4b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41f4f:	48 c7 80 88 00 00 00 	movq   $0x23,0x88(%rax)
   41f56:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   41f5a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41f5e:	66 c7 80 c0 00 00 00 	movw   $0x23,0xc0(%rax)
   41f65:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   41f67:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41f6b:	48 c7 80 b0 00 00 00 	movq   $0x200,0xb0(%rax)
   41f72:	00 02 00 00 
    p->display_status = 1;
   41f76:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41f7a:	c6 80 d8 00 00 00 01 	movb   $0x1,0xd8(%rax)

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   41f81:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41f84:	83 e0 01             	and    $0x1,%eax
   41f87:	85 c0                	test   %eax,%eax
   41f89:	74 1c                	je     41fa7 <process_init+0xa1>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   41f8b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41f8f:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   41f96:	80 cc 30             	or     $0x30,%ah
   41f99:	48 89 c2             	mov    %rax,%rdx
   41f9c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41fa0:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   41fa7:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41faa:	83 e0 02             	and    $0x2,%eax
   41fad:	85 c0                	test   %eax,%eax
   41faf:	74 1c                	je     41fcd <process_init+0xc7>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   41fb1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41fb5:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   41fbc:	80 e4 fd             	and    $0xfd,%ah
   41fbf:	48 89 c2             	mov    %rax,%rdx
   41fc2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41fc6:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
}
   41fcd:	90                   	nop
   41fce:	c9                   	leave  
   41fcf:	c3                   	ret    

0000000000041fd0 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   41fd0:	55                   	push   %rbp
   41fd1:	48 89 e5             	mov    %rsp,%rbp
   41fd4:	48 83 ec 28          	sub    $0x28,%rsp
   41fd8:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   41fdb:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41fdf:	78 09                	js     41fea <console_show_cursor+0x1a>
   41fe1:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   41fe8:	7e 07                	jle    41ff1 <console_show_cursor+0x21>
        cpos = 0;
   41fea:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   41ff1:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   41ff8:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ffc:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   42000:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   42003:	ee                   	out    %al,(%dx)
}
   42004:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   42005:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42008:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   4200e:	85 c0                	test   %eax,%eax
   42010:	0f 48 c2             	cmovs  %edx,%eax
   42013:	c1 f8 08             	sar    $0x8,%eax
   42016:	0f b6 c0             	movzbl %al,%eax
   42019:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   42020:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42023:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   42027:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4202a:	ee                   	out    %al,(%dx)
}
   4202b:	90                   	nop
   4202c:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   42033:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42037:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   4203b:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4203e:	ee                   	out    %al,(%dx)
}
   4203f:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   42040:	8b 55 dc             	mov    -0x24(%rbp),%edx
   42043:	89 d0                	mov    %edx,%eax
   42045:	c1 f8 1f             	sar    $0x1f,%eax
   42048:	c1 e8 18             	shr    $0x18,%eax
   4204b:	01 c2                	add    %eax,%edx
   4204d:	0f b6 d2             	movzbl %dl,%edx
   42050:	29 c2                	sub    %eax,%edx
   42052:	89 d0                	mov    %edx,%eax
   42054:	0f b6 c0             	movzbl %al,%eax
   42057:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   4205e:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42061:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42065:	8b 55 fc             	mov    -0x4(%rbp),%edx
   42068:	ee                   	out    %al,(%dx)
}
   42069:	90                   	nop
}
   4206a:	90                   	nop
   4206b:	c9                   	leave  
   4206c:	c3                   	ret    

000000000004206d <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   4206d:	55                   	push   %rbp
   4206e:	48 89 e5             	mov    %rsp,%rbp
   42071:	48 83 ec 20          	sub    $0x20,%rsp
   42075:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   4207c:	8b 45 f0             	mov    -0x10(%rbp),%eax
   4207f:	89 c2                	mov    %eax,%edx
   42081:	ec                   	in     (%dx),%al
   42082:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   42085:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   42089:	0f b6 c0             	movzbl %al,%eax
   4208c:	83 e0 01             	and    $0x1,%eax
   4208f:	85 c0                	test   %eax,%eax
   42091:	75 0a                	jne    4209d <keyboard_readc+0x30>
        return -1;
   42093:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42098:	e9 e7 01 00 00       	jmp    42284 <keyboard_readc+0x217>
   4209d:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   420a4:	8b 45 e8             	mov    -0x18(%rbp),%eax
   420a7:	89 c2                	mov    %eax,%edx
   420a9:	ec                   	in     (%dx),%al
   420aa:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   420ad:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   420b1:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   420b4:	0f b6 05 47 22 01 00 	movzbl 0x12247(%rip),%eax        # 54302 <last_escape.2>
   420bb:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   420be:	c6 05 3d 22 01 00 00 	movb   $0x0,0x1223d(%rip)        # 54302 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   420c5:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   420c9:	75 11                	jne    420dc <keyboard_readc+0x6f>
        last_escape = 0x80;
   420cb:	c6 05 30 22 01 00 80 	movb   $0x80,0x12230(%rip)        # 54302 <last_escape.2>
        return 0;
   420d2:	b8 00 00 00 00       	mov    $0x0,%eax
   420d7:	e9 a8 01 00 00       	jmp    42284 <keyboard_readc+0x217>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   420dc:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   420e0:	84 c0                	test   %al,%al
   420e2:	79 60                	jns    42144 <keyboard_readc+0xd7>
        int ch = keymap[(data & 0x7F) | escape];
   420e4:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   420e8:	83 e0 7f             	and    $0x7f,%eax
   420eb:	89 c2                	mov    %eax,%edx
   420ed:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   420f1:	09 d0                	or     %edx,%eax
   420f3:	48 98                	cltq   
   420f5:	0f b6 80 e0 45 04 00 	movzbl 0x445e0(%rax),%eax
   420fc:	0f b6 c0             	movzbl %al,%eax
   420ff:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   42102:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   42109:	7e 2f                	jle    4213a <keyboard_readc+0xcd>
   4210b:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   42112:	7f 26                	jg     4213a <keyboard_readc+0xcd>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   42114:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42117:	2d fa 00 00 00       	sub    $0xfa,%eax
   4211c:	ba 01 00 00 00       	mov    $0x1,%edx
   42121:	89 c1                	mov    %eax,%ecx
   42123:	d3 e2                	shl    %cl,%edx
   42125:	89 d0                	mov    %edx,%eax
   42127:	f7 d0                	not    %eax
   42129:	89 c2                	mov    %eax,%edx
   4212b:	0f b6 05 d1 21 01 00 	movzbl 0x121d1(%rip),%eax        # 54303 <modifiers.1>
   42132:	21 d0                	and    %edx,%eax
   42134:	88 05 c9 21 01 00    	mov    %al,0x121c9(%rip)        # 54303 <modifiers.1>
        }
        return 0;
   4213a:	b8 00 00 00 00       	mov    $0x0,%eax
   4213f:	e9 40 01 00 00       	jmp    42284 <keyboard_readc+0x217>
    }

    int ch = (unsigned char) keymap[data | escape];
   42144:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42148:	0a 45 fa             	or     -0x6(%rbp),%al
   4214b:	0f b6 c0             	movzbl %al,%eax
   4214e:	48 98                	cltq   
   42150:	0f b6 80 e0 45 04 00 	movzbl 0x445e0(%rax),%eax
   42157:	0f b6 c0             	movzbl %al,%eax
   4215a:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   4215d:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   42161:	7e 57                	jle    421ba <keyboard_readc+0x14d>
   42163:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   42167:	7f 51                	jg     421ba <keyboard_readc+0x14d>
        if (modifiers & MOD_CONTROL) {
   42169:	0f b6 05 93 21 01 00 	movzbl 0x12193(%rip),%eax        # 54303 <modifiers.1>
   42170:	0f b6 c0             	movzbl %al,%eax
   42173:	83 e0 02             	and    $0x2,%eax
   42176:	85 c0                	test   %eax,%eax
   42178:	74 09                	je     42183 <keyboard_readc+0x116>
            ch -= 0x60;
   4217a:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   4217e:	e9 fd 00 00 00       	jmp    42280 <keyboard_readc+0x213>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   42183:	0f b6 05 79 21 01 00 	movzbl 0x12179(%rip),%eax        # 54303 <modifiers.1>
   4218a:	0f b6 c0             	movzbl %al,%eax
   4218d:	83 e0 01             	and    $0x1,%eax
   42190:	85 c0                	test   %eax,%eax
   42192:	0f 94 c2             	sete   %dl
   42195:	0f b6 05 67 21 01 00 	movzbl 0x12167(%rip),%eax        # 54303 <modifiers.1>
   4219c:	0f b6 c0             	movzbl %al,%eax
   4219f:	83 e0 08             	and    $0x8,%eax
   421a2:	85 c0                	test   %eax,%eax
   421a4:	0f 94 c0             	sete   %al
   421a7:	31 d0                	xor    %edx,%eax
   421a9:	84 c0                	test   %al,%al
   421ab:	0f 84 cf 00 00 00    	je     42280 <keyboard_readc+0x213>
            ch -= 0x20;
   421b1:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   421b5:	e9 c6 00 00 00       	jmp    42280 <keyboard_readc+0x213>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   421ba:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   421c1:	7e 30                	jle    421f3 <keyboard_readc+0x186>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   421c3:	8b 45 fc             	mov    -0x4(%rbp),%eax
   421c6:	2d fa 00 00 00       	sub    $0xfa,%eax
   421cb:	ba 01 00 00 00       	mov    $0x1,%edx
   421d0:	89 c1                	mov    %eax,%ecx
   421d2:	d3 e2                	shl    %cl,%edx
   421d4:	89 d0                	mov    %edx,%eax
   421d6:	89 c2                	mov    %eax,%edx
   421d8:	0f b6 05 24 21 01 00 	movzbl 0x12124(%rip),%eax        # 54303 <modifiers.1>
   421df:	31 d0                	xor    %edx,%eax
   421e1:	88 05 1c 21 01 00    	mov    %al,0x1211c(%rip)        # 54303 <modifiers.1>
        ch = 0;
   421e7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   421ee:	e9 8e 00 00 00       	jmp    42281 <keyboard_readc+0x214>
    } else if (ch >= KEY_SHIFT) {
   421f3:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   421fa:	7e 2d                	jle    42229 <keyboard_readc+0x1bc>
        modifiers |= 1 << (ch - KEY_SHIFT);
   421fc:	8b 45 fc             	mov    -0x4(%rbp),%eax
   421ff:	2d fa 00 00 00       	sub    $0xfa,%eax
   42204:	ba 01 00 00 00       	mov    $0x1,%edx
   42209:	89 c1                	mov    %eax,%ecx
   4220b:	d3 e2                	shl    %cl,%edx
   4220d:	89 d0                	mov    %edx,%eax
   4220f:	89 c2                	mov    %eax,%edx
   42211:	0f b6 05 eb 20 01 00 	movzbl 0x120eb(%rip),%eax        # 54303 <modifiers.1>
   42218:	09 d0                	or     %edx,%eax
   4221a:	88 05 e3 20 01 00    	mov    %al,0x120e3(%rip)        # 54303 <modifiers.1>
        ch = 0;
   42220:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42227:	eb 58                	jmp    42281 <keyboard_readc+0x214>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   42229:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   4222d:	7e 31                	jle    42260 <keyboard_readc+0x1f3>
   4222f:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   42236:	7f 28                	jg     42260 <keyboard_readc+0x1f3>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   42238:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4223b:	8d 50 80             	lea    -0x80(%rax),%edx
   4223e:	0f b6 05 be 20 01 00 	movzbl 0x120be(%rip),%eax        # 54303 <modifiers.1>
   42245:	0f b6 c0             	movzbl %al,%eax
   42248:	83 e0 03             	and    $0x3,%eax
   4224b:	48 98                	cltq   
   4224d:	48 63 d2             	movslq %edx,%rdx
   42250:	0f b6 84 90 e0 46 04 	movzbl 0x446e0(%rax,%rdx,4),%eax
   42257:	00 
   42258:	0f b6 c0             	movzbl %al,%eax
   4225b:	89 45 fc             	mov    %eax,-0x4(%rbp)
   4225e:	eb 21                	jmp    42281 <keyboard_readc+0x214>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   42260:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   42264:	7f 1b                	jg     42281 <keyboard_readc+0x214>
   42266:	0f b6 05 96 20 01 00 	movzbl 0x12096(%rip),%eax        # 54303 <modifiers.1>
   4226d:	0f b6 c0             	movzbl %al,%eax
   42270:	83 e0 02             	and    $0x2,%eax
   42273:	85 c0                	test   %eax,%eax
   42275:	74 0a                	je     42281 <keyboard_readc+0x214>
        ch = 0;
   42277:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4227e:	eb 01                	jmp    42281 <keyboard_readc+0x214>
        if (modifiers & MOD_CONTROL) {
   42280:	90                   	nop
    }

    return ch;
   42281:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   42284:	c9                   	leave  
   42285:	c3                   	ret    

0000000000042286 <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   42286:	55                   	push   %rbp
   42287:	48 89 e5             	mov    %rsp,%rbp
   4228a:	48 83 ec 20          	sub    $0x20,%rsp
   4228e:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42295:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   42298:	89 c2                	mov    %eax,%edx
   4229a:	ec                   	in     (%dx),%al
   4229b:	88 45 e3             	mov    %al,-0x1d(%rbp)
   4229e:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   422a5:	8b 45 ec             	mov    -0x14(%rbp),%eax
   422a8:	89 c2                	mov    %eax,%edx
   422aa:	ec                   	in     (%dx),%al
   422ab:	88 45 eb             	mov    %al,-0x15(%rbp)
   422ae:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   422b5:	8b 45 f4             	mov    -0xc(%rbp),%eax
   422b8:	89 c2                	mov    %eax,%edx
   422ba:	ec                   	in     (%dx),%al
   422bb:	88 45 f3             	mov    %al,-0xd(%rbp)
   422be:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   422c5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   422c8:	89 c2                	mov    %eax,%edx
   422ca:	ec                   	in     (%dx),%al
   422cb:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   422ce:	90                   	nop
   422cf:	c9                   	leave  
   422d0:	c3                   	ret    

00000000000422d1 <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   422d1:	55                   	push   %rbp
   422d2:	48 89 e5             	mov    %rsp,%rbp
   422d5:	48 83 ec 40          	sub    $0x40,%rsp
   422d9:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   422dd:	89 f0                	mov    %esi,%eax
   422df:	89 55 c0             	mov    %edx,-0x40(%rbp)
   422e2:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   422e5:	8b 05 19 20 01 00    	mov    0x12019(%rip),%eax        # 54304 <initialized.0>
   422eb:	85 c0                	test   %eax,%eax
   422ed:	75 1e                	jne    4230d <parallel_port_putc+0x3c>
   422ef:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   422f6:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   422fa:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   422fe:	8b 55 f8             	mov    -0x8(%rbp),%edx
   42301:	ee                   	out    %al,(%dx)
}
   42302:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   42303:	c7 05 f7 1f 01 00 01 	movl   $0x1,0x11ff7(%rip)        # 54304 <initialized.0>
   4230a:	00 00 00 
    }

    for (int i = 0;
   4230d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42314:	eb 09                	jmp    4231f <parallel_port_putc+0x4e>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   42316:	e8 6b ff ff ff       	call   42286 <delay>
         ++i) {
   4231b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   4231f:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   42326:	7f 18                	jg     42340 <parallel_port_putc+0x6f>
   42328:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   4232f:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42332:	89 c2                	mov    %eax,%edx
   42334:	ec                   	in     (%dx),%al
   42335:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   42338:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   4233c:	84 c0                	test   %al,%al
   4233e:	79 d6                	jns    42316 <parallel_port_putc+0x45>
    }
    outb(IO_PARALLEL1_DATA, c);
   42340:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   42344:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   4234b:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4234e:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   42352:	8b 55 d8             	mov    -0x28(%rbp),%edx
   42355:	ee                   	out    %al,(%dx)
}
   42356:	90                   	nop
   42357:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   4235e:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42362:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   42366:	8b 55 e0             	mov    -0x20(%rbp),%edx
   42369:	ee                   	out    %al,(%dx)
}
   4236a:	90                   	nop
   4236b:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   42372:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42376:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   4237a:	8b 55 e8             	mov    -0x18(%rbp),%edx
   4237d:	ee                   	out    %al,(%dx)
}
   4237e:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   4237f:	90                   	nop
   42380:	c9                   	leave  
   42381:	c3                   	ret    

0000000000042382 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   42382:	55                   	push   %rbp
   42383:	48 89 e5             	mov    %rsp,%rbp
   42386:	48 83 ec 20          	sub    $0x20,%rsp
   4238a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4238e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   42392:	48 c7 45 f8 d1 22 04 	movq   $0x422d1,-0x8(%rbp)
   42399:	00 
    printer_vprintf(&p, 0, format, val);
   4239a:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   4239e:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   423a2:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   423a6:	be 00 00 00 00       	mov    $0x0,%esi
   423ab:	48 89 c7             	mov    %rax,%rdi
   423ae:	e8 14 11 00 00       	call   434c7 <printer_vprintf>
}
   423b3:	90                   	nop
   423b4:	c9                   	leave  
   423b5:	c3                   	ret    

00000000000423b6 <log_printf>:

void log_printf(const char* format, ...) {
   423b6:	55                   	push   %rbp
   423b7:	48 89 e5             	mov    %rsp,%rbp
   423ba:	48 83 ec 60          	sub    $0x60,%rsp
   423be:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   423c2:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   423c6:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   423ca:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   423ce:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   423d2:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   423d6:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   423dd:	48 8d 45 10          	lea    0x10(%rbp),%rax
   423e1:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   423e5:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   423e9:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   423ed:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   423f1:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   423f5:	48 89 d6             	mov    %rdx,%rsi
   423f8:	48 89 c7             	mov    %rax,%rdi
   423fb:	e8 82 ff ff ff       	call   42382 <log_vprintf>
    va_end(val);
}
   42400:	90                   	nop
   42401:	c9                   	leave  
   42402:	c3                   	ret    

0000000000042403 <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   42403:	55                   	push   %rbp
   42404:	48 89 e5             	mov    %rsp,%rbp
   42407:	48 83 ec 40          	sub    $0x40,%rsp
   4240b:	89 7d dc             	mov    %edi,-0x24(%rbp)
   4240e:	89 75 d8             	mov    %esi,-0x28(%rbp)
   42411:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   42415:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   42419:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   4241d:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42421:	48 8b 0a             	mov    (%rdx),%rcx
   42424:	48 89 08             	mov    %rcx,(%rax)
   42427:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   4242b:	48 89 48 08          	mov    %rcx,0x8(%rax)
   4242f:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   42433:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   42437:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   4243b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4243f:	48 89 d6             	mov    %rdx,%rsi
   42442:	48 89 c7             	mov    %rax,%rdi
   42445:	e8 38 ff ff ff       	call   42382 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   4244a:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   4244e:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42452:	8b 75 d8             	mov    -0x28(%rbp),%esi
   42455:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42458:	89 c7                	mov    %eax,%edi
   4245a:	e8 17 1b 00 00       	call   43f76 <console_vprintf>
}
   4245f:	c9                   	leave  
   42460:	c3                   	ret    

0000000000042461 <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   42461:	55                   	push   %rbp
   42462:	48 89 e5             	mov    %rsp,%rbp
   42465:	48 83 ec 60          	sub    $0x60,%rsp
   42469:	89 7d ac             	mov    %edi,-0x54(%rbp)
   4246c:	89 75 a8             	mov    %esi,-0x58(%rbp)
   4246f:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   42473:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42477:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4247b:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   4247f:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   42486:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4248a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   4248e:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42492:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   42496:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   4249a:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   4249e:	8b 75 a8             	mov    -0x58(%rbp),%esi
   424a1:	8b 45 ac             	mov    -0x54(%rbp),%eax
   424a4:	89 c7                	mov    %eax,%edi
   424a6:	e8 58 ff ff ff       	call   42403 <error_vprintf>
   424ab:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   424ae:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   424b1:	c9                   	leave  
   424b2:	c3                   	ret    

00000000000424b3 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'f', and 'e' cause a soft
//    reboot where the kernel runs the allocator programs, "fork", or
//    "forkexit", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   424b3:	55                   	push   %rbp
   424b4:	48 89 e5             	mov    %rsp,%rbp
   424b7:	53                   	push   %rbx
   424b8:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   424bc:	e8 ac fb ff ff       	call   4206d <keyboard_readc>
   424c1:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   424c4:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   424c8:	74 1c                	je     424e6 <check_keyboard+0x33>
   424ca:	83 7d e4 66          	cmpl   $0x66,-0x1c(%rbp)
   424ce:	74 16                	je     424e6 <check_keyboard+0x33>
   424d0:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   424d4:	74 10                	je     424e6 <check_keyboard+0x33>
   424d6:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   424da:	74 0a                	je     424e6 <check_keyboard+0x33>
   424dc:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   424e0:	0f 85 e9 00 00 00    	jne    425cf <check_keyboard+0x11c>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   424e6:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   424ed:	00 
        memset(pt, 0, PAGESIZE * 3);
   424ee:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   424f2:	ba 00 30 00 00       	mov    $0x3000,%edx
   424f7:	be 00 00 00 00       	mov    $0x0,%esi
   424fc:	48 89 c7             	mov    %rax,%rdi
   424ff:	e8 27 0d 00 00       	call   4322b <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   42504:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42508:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   4250f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42513:	48 05 00 10 00 00    	add    $0x1000,%rax
   42519:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   42520:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42524:	48 05 00 20 00 00    	add    $0x2000,%rax
   4252a:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   42531:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42535:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42539:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4253d:	0f 22 d8             	mov    %rax,%cr3
}
   42540:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   42541:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "fork";
   42548:	48 c7 45 e8 38 47 04 	movq   $0x44738,-0x18(%rbp)
   4254f:	00 
        if (c == 'a') {
   42550:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42554:	75 0a                	jne    42560 <check_keyboard+0xad>
            argument = "allocator";
   42556:	48 c7 45 e8 3d 47 04 	movq   $0x4473d,-0x18(%rbp)
   4255d:	00 
   4255e:	eb 2e                	jmp    4258e <check_keyboard+0xdb>
        } else if (c == 'e') {
   42560:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42564:	75 0a                	jne    42570 <check_keyboard+0xbd>
            argument = "forkexit";
   42566:	48 c7 45 e8 47 47 04 	movq   $0x44747,-0x18(%rbp)
   4256d:	00 
   4256e:	eb 1e                	jmp    4258e <check_keyboard+0xdb>
        }
        else if (c == 't'){
   42570:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42574:	75 0a                	jne    42580 <check_keyboard+0xcd>
            argument = "test";
   42576:	48 c7 45 e8 50 47 04 	movq   $0x44750,-0x18(%rbp)
   4257d:	00 
   4257e:	eb 0e                	jmp    4258e <check_keyboard+0xdb>
        }
        else if(c == '2'){
   42580:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42584:	75 08                	jne    4258e <check_keyboard+0xdb>
            argument = "test2";
   42586:	48 c7 45 e8 55 47 04 	movq   $0x44755,-0x18(%rbp)
   4258d:	00 
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   4258e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42592:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   42596:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4259b:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   4259f:	73 14                	jae    425b5 <check_keyboard+0x102>
   425a1:	ba 5b 47 04 00       	mov    $0x4475b,%edx
   425a6:	be 5d 02 00 00       	mov    $0x25d,%esi
   425ab:	bf 77 47 04 00       	mov    $0x44777,%edi
   425b0:	e8 1f 01 00 00       	call   426d4 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   425b5:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   425b9:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   425bc:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   425c0:	48 89 c3             	mov    %rax,%rbx
   425c3:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   425c8:	e9 33 da ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   425cd:	eb 11                	jmp    425e0 <check_keyboard+0x12d>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   425cf:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   425d3:	74 06                	je     425db <check_keyboard+0x128>
   425d5:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   425d9:	75 05                	jne    425e0 <check_keyboard+0x12d>
        poweroff();
   425db:	e8 9d f8 ff ff       	call   41e7d <poweroff>
    }
    return c;
   425e0:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   425e3:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   425e7:	c9                   	leave  
   425e8:	c3                   	ret    

00000000000425e9 <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   425e9:	55                   	push   %rbp
   425ea:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   425ed:	e8 c1 fe ff ff       	call   424b3 <check_keyboard>
   425f2:	eb f9                	jmp    425ed <fail+0x4>

00000000000425f4 <panic>:

// panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void panic(const char* format, ...) {
   425f4:	55                   	push   %rbp
   425f5:	48 89 e5             	mov    %rsp,%rbp
   425f8:	48 83 ec 60          	sub    $0x60,%rsp
   425fc:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42600:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42604:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42608:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4260c:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42610:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42614:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   4261b:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4261f:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   42623:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42627:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   4262b:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   42630:	0f 84 80 00 00 00    	je     426b6 <panic+0xc2>
        // Print panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   42636:	ba 8b 47 04 00       	mov    $0x4478b,%edx
   4263b:	be 00 c0 00 00       	mov    $0xc000,%esi
   42640:	bf 30 07 00 00       	mov    $0x730,%edi
   42645:	b8 00 00 00 00       	mov    $0x0,%eax
   4264a:	e8 12 fe ff ff       	call   42461 <error_printf>
   4264f:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   42652:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   42656:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   4265a:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4265d:	be 00 c0 00 00       	mov    $0xc000,%esi
   42662:	89 c7                	mov    %eax,%edi
   42664:	e8 9a fd ff ff       	call   42403 <error_vprintf>
   42669:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   4266c:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   4266f:	48 63 c1             	movslq %ecx,%rax
   42672:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   42679:	48 c1 e8 20          	shr    $0x20,%rax
   4267d:	89 c2                	mov    %eax,%edx
   4267f:	c1 fa 05             	sar    $0x5,%edx
   42682:	89 c8                	mov    %ecx,%eax
   42684:	c1 f8 1f             	sar    $0x1f,%eax
   42687:	29 c2                	sub    %eax,%edx
   42689:	89 d0                	mov    %edx,%eax
   4268b:	c1 e0 02             	shl    $0x2,%eax
   4268e:	01 d0                	add    %edx,%eax
   42690:	c1 e0 04             	shl    $0x4,%eax
   42693:	29 c1                	sub    %eax,%ecx
   42695:	89 ca                	mov    %ecx,%edx
   42697:	85 d2                	test   %edx,%edx
   42699:	74 34                	je     426cf <panic+0xdb>
            error_printf(cpos, 0xC000, "\n");
   4269b:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4269e:	ba 93 47 04 00       	mov    $0x44793,%edx
   426a3:	be 00 c0 00 00       	mov    $0xc000,%esi
   426a8:	89 c7                	mov    %eax,%edi
   426aa:	b8 00 00 00 00       	mov    $0x0,%eax
   426af:	e8 ad fd ff ff       	call   42461 <error_printf>
   426b4:	eb 19                	jmp    426cf <panic+0xdb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   426b6:	ba 95 47 04 00       	mov    $0x44795,%edx
   426bb:	be 00 c0 00 00       	mov    $0xc000,%esi
   426c0:	bf 30 07 00 00       	mov    $0x730,%edi
   426c5:	b8 00 00 00 00       	mov    $0x0,%eax
   426ca:	e8 92 fd ff ff       	call   42461 <error_printf>
    }

    va_end(val);
    fail();
   426cf:	e8 15 ff ff ff       	call   425e9 <fail>

00000000000426d4 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   426d4:	55                   	push   %rbp
   426d5:	48 89 e5             	mov    %rsp,%rbp
   426d8:	48 83 ec 20          	sub    $0x20,%rsp
   426dc:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   426e0:	89 75 f4             	mov    %esi,-0xc(%rbp)
   426e3:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   426e7:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   426eb:	8b 55 f4             	mov    -0xc(%rbp),%edx
   426ee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   426f2:	48 89 c6             	mov    %rax,%rsi
   426f5:	bf 9b 47 04 00       	mov    $0x4479b,%edi
   426fa:	b8 00 00 00 00       	mov    $0x0,%eax
   426ff:	e8 f0 fe ff ff       	call   425f4 <panic>

0000000000042704 <default_exception>:
}

void default_exception(proc* p){
   42704:	55                   	push   %rbp
   42705:	48 89 e5             	mov    %rsp,%rbp
   42708:	48 83 ec 20          	sub    $0x20,%rsp
   4270c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   42710:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42714:	48 83 c0 08          	add    $0x8,%rax
   42718:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    panic("Unexpected exception %d!\n", reg->reg_intno);
   4271c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42720:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   42727:	48 89 c6             	mov    %rax,%rsi
   4272a:	bf b9 47 04 00       	mov    $0x447b9,%edi
   4272f:	b8 00 00 00 00       	mov    $0x0,%eax
   42734:	e8 bb fe ff ff       	call   425f4 <panic>

0000000000042739 <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   42739:	55                   	push   %rbp
   4273a:	48 89 e5             	mov    %rsp,%rbp
   4273d:	48 83 ec 10          	sub    $0x10,%rsp
   42741:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42745:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   42748:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   4274c:	78 06                	js     42754 <pageindex+0x1b>
   4274e:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   42752:	7e 14                	jle    42768 <pageindex+0x2f>
   42754:	ba d8 47 04 00       	mov    $0x447d8,%edx
   42759:	be 1e 00 00 00       	mov    $0x1e,%esi
   4275e:	bf f1 47 04 00       	mov    $0x447f1,%edi
   42763:	e8 6c ff ff ff       	call   426d4 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   42768:	b8 03 00 00 00       	mov    $0x3,%eax
   4276d:	2b 45 f4             	sub    -0xc(%rbp),%eax
   42770:	89 c2                	mov    %eax,%edx
   42772:	89 d0                	mov    %edx,%eax
   42774:	c1 e0 03             	shl    $0x3,%eax
   42777:	01 d0                	add    %edx,%eax
   42779:	83 c0 0c             	add    $0xc,%eax
   4277c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42780:	89 c1                	mov    %eax,%ecx
   42782:	48 d3 ea             	shr    %cl,%rdx
   42785:	48 89 d0             	mov    %rdx,%rax
   42788:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   4278d:	c9                   	leave  
   4278e:	c3                   	ret    

000000000004278f <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   4278f:	55                   	push   %rbp
   42790:	48 89 e5             	mov    %rsp,%rbp
   42793:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   42797:	48 c7 05 5e 28 01 00 	movq   $0x56000,0x1285e(%rip)        # 55000 <kernel_pagetable>
   4279e:	00 60 05 00 
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   427a2:	ba 00 50 00 00       	mov    $0x5000,%edx
   427a7:	be 00 00 00 00       	mov    $0x0,%esi
   427ac:	bf 00 60 05 00       	mov    $0x56000,%edi
   427b1:	e8 75 0a 00 00       	call   4322b <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   427b6:	b8 00 70 05 00       	mov    $0x57000,%eax
   427bb:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   427bf:	48 89 05 3a 38 01 00 	mov    %rax,0x1383a(%rip)        # 56000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   427c6:	b8 00 80 05 00       	mov    $0x58000,%eax
   427cb:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   427cf:	48 89 05 2a 48 01 00 	mov    %rax,0x1482a(%rip)        # 57000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   427d6:	b8 00 90 05 00       	mov    $0x59000,%eax
   427db:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   427df:	48 89 05 1a 58 01 00 	mov    %rax,0x1581a(%rip)        # 58000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   427e6:	b8 00 a0 05 00       	mov    $0x5a000,%eax
   427eb:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   427ef:	48 89 05 12 58 01 00 	mov    %rax,0x15812(%rip)        # 58008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   427f6:	48 8b 05 03 28 01 00 	mov    0x12803(%rip),%rax        # 55000 <kernel_pagetable>
   427fd:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42803:	b9 00 00 20 00       	mov    $0x200000,%ecx
   42808:	ba 00 00 00 00       	mov    $0x0,%edx
   4280d:	be 00 00 00 00       	mov    $0x0,%esi
   42812:	48 89 c7             	mov    %rax,%rdi
   42815:	e8 b9 01 00 00       	call   429d3 <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   4281a:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42821:	00 
   42822:	eb 62                	jmp    42886 <virtual_memory_init+0xf7>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   42824:	48 8b 0d d5 27 01 00 	mov    0x127d5(%rip),%rcx        # 55000 <kernel_pagetable>
   4282b:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   4282f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42833:	48 89 ce             	mov    %rcx,%rsi
   42836:	48 89 c7             	mov    %rax,%rdi
   42839:	e8 5b 05 00 00       	call   42d99 <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l1pagetable ?
        assert(vmap.pa == addr);
   4283e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42842:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   42846:	74 14                	je     4285c <virtual_memory_init+0xcd>
   42848:	ba 05 48 04 00       	mov    $0x44805,%edx
   4284d:	be 2d 00 00 00       	mov    $0x2d,%esi
   42852:	bf 15 48 04 00       	mov    $0x44815,%edi
   42857:	e8 78 fe ff ff       	call   426d4 <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   4285c:	8b 45 f0             	mov    -0x10(%rbp),%eax
   4285f:	48 98                	cltq   
   42861:	83 e0 03             	and    $0x3,%eax
   42864:	48 83 f8 03          	cmp    $0x3,%rax
   42868:	74 14                	je     4287e <virtual_memory_init+0xef>
   4286a:	ba 28 48 04 00       	mov    $0x44828,%edx
   4286f:	be 2e 00 00 00       	mov    $0x2e,%esi
   42874:	bf 15 48 04 00       	mov    $0x44815,%edi
   42879:	e8 56 fe ff ff       	call   426d4 <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   4287e:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42885:	00 
   42886:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   4288d:	00 
   4288e:	76 94                	jbe    42824 <virtual_memory_init+0x95>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   42890:	48 8b 05 69 27 01 00 	mov    0x12769(%rip),%rax        # 55000 <kernel_pagetable>
   42897:	48 89 c7             	mov    %rax,%rdi
   4289a:	e8 03 00 00 00       	call   428a2 <set_pagetable>
}
   4289f:	90                   	nop
   428a0:	c9                   	leave  
   428a1:	c3                   	ret    

00000000000428a2 <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   428a2:	55                   	push   %rbp
   428a3:	48 89 e5             	mov    %rsp,%rbp
   428a6:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   428aa:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   428ae:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   428b2:	25 ff 0f 00 00       	and    $0xfff,%eax
   428b7:	48 85 c0             	test   %rax,%rax
   428ba:	74 14                	je     428d0 <set_pagetable+0x2e>
   428bc:	ba 55 48 04 00       	mov    $0x44855,%edx
   428c1:	be 3d 00 00 00       	mov    $0x3d,%esi
   428c6:	bf 15 48 04 00       	mov    $0x44815,%edi
   428cb:	e8 04 fe ff ff       	call   426d4 <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   428d0:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   428d5:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   428d9:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   428dd:	48 89 ce             	mov    %rcx,%rsi
   428e0:	48 89 c7             	mov    %rax,%rdi
   428e3:	e8 b1 04 00 00       	call   42d99 <virtual_memory_lookup>
   428e8:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   428ec:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   428f1:	48 39 d0             	cmp    %rdx,%rax
   428f4:	74 14                	je     4290a <set_pagetable+0x68>
   428f6:	ba 70 48 04 00       	mov    $0x44870,%edx
   428fb:	be 3f 00 00 00       	mov    $0x3f,%esi
   42900:	bf 15 48 04 00       	mov    $0x44815,%edi
   42905:	e8 ca fd ff ff       	call   426d4 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   4290a:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   4290e:	48 8b 0d eb 26 01 00 	mov    0x126eb(%rip),%rcx        # 55000 <kernel_pagetable>
   42915:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   42919:	48 89 ce             	mov    %rcx,%rsi
   4291c:	48 89 c7             	mov    %rax,%rdi
   4291f:	e8 75 04 00 00       	call   42d99 <virtual_memory_lookup>
   42924:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42928:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   4292c:	48 39 c2             	cmp    %rax,%rdx
   4292f:	74 14                	je     42945 <set_pagetable+0xa3>
   42931:	ba d8 48 04 00       	mov    $0x448d8,%edx
   42936:	be 41 00 00 00       	mov    $0x41,%esi
   4293b:	bf 15 48 04 00       	mov    $0x44815,%edi
   42940:	e8 8f fd ff ff       	call   426d4 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   42945:	48 8b 05 b4 26 01 00 	mov    0x126b4(%rip),%rax        # 55000 <kernel_pagetable>
   4294c:	48 89 c2             	mov    %rax,%rdx
   4294f:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   42953:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42957:	48 89 ce             	mov    %rcx,%rsi
   4295a:	48 89 c7             	mov    %rax,%rdi
   4295d:	e8 37 04 00 00       	call   42d99 <virtual_memory_lookup>
   42962:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42966:	48 8b 15 93 26 01 00 	mov    0x12693(%rip),%rdx        # 55000 <kernel_pagetable>
   4296d:	48 39 d0             	cmp    %rdx,%rax
   42970:	74 14                	je     42986 <set_pagetable+0xe4>
   42972:	ba 38 49 04 00       	mov    $0x44938,%edx
   42977:	be 43 00 00 00       	mov    $0x43,%esi
   4297c:	bf 15 48 04 00       	mov    $0x44815,%edi
   42981:	e8 4e fd ff ff       	call   426d4 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   42986:	ba d3 29 04 00       	mov    $0x429d3,%edx
   4298b:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   4298f:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42993:	48 89 ce             	mov    %rcx,%rsi
   42996:	48 89 c7             	mov    %rax,%rdi
   42999:	e8 fb 03 00 00       	call   42d99 <virtual_memory_lookup>
   4299e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   429a2:	ba d3 29 04 00       	mov    $0x429d3,%edx
   429a7:	48 39 d0             	cmp    %rdx,%rax
   429aa:	74 14                	je     429c0 <set_pagetable+0x11e>
   429ac:	ba a0 49 04 00       	mov    $0x449a0,%edx
   429b1:	be 45 00 00 00       	mov    $0x45,%esi
   429b6:	bf 15 48 04 00       	mov    $0x44815,%edi
   429bb:	e8 14 fd ff ff       	call   426d4 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   429c0:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   429c4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   429c8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   429cc:	0f 22 d8             	mov    %rax,%cr3
}
   429cf:	90                   	nop
}
   429d0:	90                   	nop
   429d1:	c9                   	leave  
   429d2:	c3                   	ret    

00000000000429d3 <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   429d3:	55                   	push   %rbp
   429d4:	48 89 e5             	mov    %rsp,%rbp
   429d7:	41 54                	push   %r12
   429d9:	53                   	push   %rbx
   429da:	48 83 ec 50          	sub    $0x50,%rsp
   429de:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   429e2:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   429e6:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   429ea:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
   429ee:	44 89 45 ac          	mov    %r8d,-0x54(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   429f2:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   429f6:	25 ff 0f 00 00       	and    $0xfff,%eax
   429fb:	48 85 c0             	test   %rax,%rax
   429fe:	74 14                	je     42a14 <virtual_memory_map+0x41>
   42a00:	ba 06 4a 04 00       	mov    $0x44a06,%edx
   42a05:	be 66 00 00 00       	mov    $0x66,%esi
   42a0a:	bf 15 48 04 00       	mov    $0x44815,%edi
   42a0f:	e8 c0 fc ff ff       	call   426d4 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   42a14:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42a18:	25 ff 0f 00 00       	and    $0xfff,%eax
   42a1d:	48 85 c0             	test   %rax,%rax
   42a20:	74 14                	je     42a36 <virtual_memory_map+0x63>
   42a22:	ba 19 4a 04 00       	mov    $0x44a19,%edx
   42a27:	be 67 00 00 00       	mov    $0x67,%esi
   42a2c:	bf 15 48 04 00       	mov    $0x44815,%edi
   42a31:	e8 9e fc ff ff       	call   426d4 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   42a36:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42a3a:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42a3e:	48 01 d0             	add    %rdx,%rax
   42a41:	48 3b 45 c0          	cmp    -0x40(%rbp),%rax
   42a45:	73 24                	jae    42a6b <virtual_memory_map+0x98>
   42a47:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42a4b:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42a4f:	48 01 d0             	add    %rdx,%rax
   42a52:	48 85 c0             	test   %rax,%rax
   42a55:	74 14                	je     42a6b <virtual_memory_map+0x98>
   42a57:	ba 2c 4a 04 00       	mov    $0x44a2c,%edx
   42a5c:	be 68 00 00 00       	mov    $0x68,%esi
   42a61:	bf 15 48 04 00       	mov    $0x44815,%edi
   42a66:	e8 69 fc ff ff       	call   426d4 <assert_fail>
    if (perm & PTE_P) {
   42a6b:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42a6e:	48 98                	cltq   
   42a70:	83 e0 01             	and    $0x1,%eax
   42a73:	48 85 c0             	test   %rax,%rax
   42a76:	74 6e                	je     42ae6 <virtual_memory_map+0x113>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   42a78:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42a7c:	25 ff 0f 00 00       	and    $0xfff,%eax
   42a81:	48 85 c0             	test   %rax,%rax
   42a84:	74 14                	je     42a9a <virtual_memory_map+0xc7>
   42a86:	ba 4a 4a 04 00       	mov    $0x44a4a,%edx
   42a8b:	be 6a 00 00 00       	mov    $0x6a,%esi
   42a90:	bf 15 48 04 00       	mov    $0x44815,%edi
   42a95:	e8 3a fc ff ff       	call   426d4 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   42a9a:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42a9e:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42aa2:	48 01 d0             	add    %rdx,%rax
   42aa5:	48 3b 45 b8          	cmp    -0x48(%rbp),%rax
   42aa9:	73 14                	jae    42abf <virtual_memory_map+0xec>
   42aab:	ba 5d 4a 04 00       	mov    $0x44a5d,%edx
   42ab0:	be 6b 00 00 00       	mov    $0x6b,%esi
   42ab5:	bf 15 48 04 00       	mov    $0x44815,%edi
   42aba:	e8 15 fc ff ff       	call   426d4 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   42abf:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42ac3:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42ac7:	48 01 d0             	add    %rdx,%rax
   42aca:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   42ad0:	76 14                	jbe    42ae6 <virtual_memory_map+0x113>
   42ad2:	ba 6b 4a 04 00       	mov    $0x44a6b,%edx
   42ad7:	be 6c 00 00 00       	mov    $0x6c,%esi
   42adc:	bf 15 48 04 00       	mov    $0x44815,%edi
   42ae1:	e8 ee fb ff ff       	call   426d4 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   42ae6:	83 7d ac 00          	cmpl   $0x0,-0x54(%rbp)
   42aea:	78 09                	js     42af5 <virtual_memory_map+0x122>
   42aec:	81 7d ac ff 0f 00 00 	cmpl   $0xfff,-0x54(%rbp)
   42af3:	7e 14                	jle    42b09 <virtual_memory_map+0x136>
   42af5:	ba 87 4a 04 00       	mov    $0x44a87,%edx
   42afa:	be 6e 00 00 00       	mov    $0x6e,%esi
   42aff:	bf 15 48 04 00       	mov    $0x44815,%edi
   42b04:	e8 cb fb ff ff       	call   426d4 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   42b09:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42b0d:	25 ff 0f 00 00       	and    $0xfff,%eax
   42b12:	48 85 c0             	test   %rax,%rax
   42b15:	74 14                	je     42b2b <virtual_memory_map+0x158>
   42b17:	ba a8 4a 04 00       	mov    $0x44aa8,%edx
   42b1c:	be 6f 00 00 00       	mov    $0x6f,%esi
   42b21:	bf 15 48 04 00       	mov    $0x44815,%edi
   42b26:	e8 a9 fb ff ff       	call   426d4 <assert_fail>

    int last_index123 = -1;
   42b2b:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%rbp)
    x86_64_pagetable* l1pagetable = NULL;
   42b32:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
   42b39:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42b3a:	e9 e7 00 00 00       	jmp    42c26 <virtual_memory_map+0x253>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   42b3f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42b43:	48 c1 e8 15          	shr    $0x15,%rax
   42b47:	89 45 dc             	mov    %eax,-0x24(%rbp)
        if (cur_index123 != last_index123) {
   42b4a:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42b4d:	3b 45 ec             	cmp    -0x14(%rbp),%eax
   42b50:	74 20                	je     42b72 <virtual_memory_map+0x19f>
            // TODO --> done
            // find pointer to last level pagetable for current va

			l1pagetable = lookup_l1pagetable(pagetable, va, perm);	
   42b52:	8b 55 ac             	mov    -0x54(%rbp),%edx
   42b55:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   42b59:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42b5d:	48 89 ce             	mov    %rcx,%rsi
   42b60:	48 89 c7             	mov    %rax,%rdi
   42b63:	e8 d7 00 00 00       	call   42c3f <lookup_l1pagetable>
   42b68:	48 89 45 e0          	mov    %rax,-0x20(%rbp)

            last_index123 = cur_index123;
   42b6c:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42b6f:	89 45 ec             	mov    %eax,-0x14(%rbp)
        }
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   42b72:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42b75:	48 98                	cltq   
   42b77:	83 e0 01             	and    $0x1,%eax
   42b7a:	48 85 c0             	test   %rax,%rax
   42b7d:	74 3a                	je     42bb9 <virtual_memory_map+0x1e6>
   42b7f:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42b84:	74 33                	je     42bb9 <virtual_memory_map+0x1e6>
            // TODO --> done
            // map `pa` at appropriate entry with permissions `perm`
			l1pagetable->entry[L1PAGEINDEX(va)] =  (0x00000000FFFFFFFF & pa) | perm;
   42b86:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42b8a:	41 89 c4             	mov    %eax,%r12d
   42b8d:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42b90:	48 63 d8             	movslq %eax,%rbx
   42b93:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42b97:	be 03 00 00 00       	mov    $0x3,%esi
   42b9c:	48 89 c7             	mov    %rax,%rdi
   42b9f:	e8 95 fb ff ff       	call   42739 <pageindex>
   42ba4:	89 c2                	mov    %eax,%edx
   42ba6:	4c 89 e1             	mov    %r12,%rcx
   42ba9:	48 09 d9             	or     %rbx,%rcx
   42bac:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42bb0:	48 63 d2             	movslq %edx,%rdx
   42bb3:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42bb7:	eb 55                	jmp    42c0e <virtual_memory_map+0x23b>

        } else if (l1pagetable) { // if page is NOT marked present
   42bb9:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42bbe:	74 26                	je     42be6 <virtual_memory_map+0x213>
            // TODO --> done
            // map to address 0 with `perm`
			l1pagetable->entry[L1PAGEINDEX(va)] = 0 | perm;
   42bc0:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42bc4:	be 03 00 00 00       	mov    $0x3,%esi
   42bc9:	48 89 c7             	mov    %rax,%rdi
   42bcc:	e8 68 fb ff ff       	call   42739 <pageindex>
   42bd1:	89 c2                	mov    %eax,%edx
   42bd3:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42bd6:	48 63 c8             	movslq %eax,%rcx
   42bd9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42bdd:	48 63 d2             	movslq %edx,%rdx
   42be0:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42be4:	eb 28                	jmp    42c0e <virtual_memory_map+0x23b>

        } else if (perm & PTE_P) {
   42be6:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42be9:	48 98                	cltq   
   42beb:	83 e0 01             	and    $0x1,%eax
   42bee:	48 85 c0             	test   %rax,%rax
   42bf1:	74 1b                	je     42c0e <virtual_memory_map+0x23b>
            // error, no allocated l1 page found for va
            log_printf("[Kern Info] failed to find l1pagetable address at " __FILE__ ": %d\n", __LINE__);
   42bf3:	be 8b 00 00 00       	mov    $0x8b,%esi
   42bf8:	bf d0 4a 04 00       	mov    $0x44ad0,%edi
   42bfd:	b8 00 00 00 00       	mov    $0x0,%eax
   42c02:	e8 af f7 ff ff       	call   423b6 <log_printf>
            return -1;
   42c07:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42c0c:	eb 28                	jmp    42c36 <virtual_memory_map+0x263>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42c0e:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
   42c15:	00 
   42c16:	48 81 45 b8 00 10 00 	addq   $0x1000,-0x48(%rbp)
   42c1d:	00 
   42c1e:	48 81 6d b0 00 10 00 	subq   $0x1000,-0x50(%rbp)
   42c25:	00 
   42c26:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   42c2b:	0f 85 0e ff ff ff    	jne    42b3f <virtual_memory_map+0x16c>
        }
    }
    return 0;
   42c31:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42c36:	48 83 c4 50          	add    $0x50,%rsp
   42c3a:	5b                   	pop    %rbx
   42c3b:	41 5c                	pop    %r12
   42c3d:	5d                   	pop    %rbp
   42c3e:	c3                   	ret    

0000000000042c3f <lookup_l1pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   42c3f:	55                   	push   %rbp
   42c40:	48 89 e5             	mov    %rsp,%rbp
   42c43:	48 83 ec 40          	sub    $0x40,%rsp
   42c47:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42c4b:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42c4f:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   42c52:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42c56:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l1 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   42c5a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   42c61:	e9 23 01 00 00       	jmp    42d89 <lookup_l1pagetable+0x14a>
        // TODO --> done
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        x86_64_pageentry_t pe = pt->entry[PAGEINDEX(va, i)]; // replace this
   42c66:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42c69:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42c6d:	89 d6                	mov    %edx,%esi
   42c6f:	48 89 c7             	mov    %rax,%rdi
   42c72:	e8 c2 fa ff ff       	call   42739 <pageindex>
   42c77:	89 c2                	mov    %eax,%edx
   42c79:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42c7d:	48 63 d2             	movslq %edx,%rdx
   42c80:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   42c84:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   42c88:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c8c:	83 e0 01             	and    $0x1,%eax
   42c8f:	48 85 c0             	test   %rax,%rax
   42c92:	75 63                	jne    42cf7 <lookup_l1pagetable+0xb8>
            log_printf("[Kern Info] Error looking up l1pagetable: Pagetable address: 0x%x perm: 0x%x."
   42c94:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42c97:	8d 48 02             	lea    0x2(%rax),%ecx
   42c9a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c9e:	25 ff 0f 00 00       	and    $0xfff,%eax
   42ca3:	48 89 c2             	mov    %rax,%rdx
   42ca6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42caa:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42cb0:	48 89 c6             	mov    %rax,%rsi
   42cb3:	bf 18 4b 04 00       	mov    $0x44b18,%edi
   42cb8:	b8 00 00 00 00       	mov    $0x0,%eax
   42cbd:	e8 f4 f6 ff ff       	call   423b6 <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   42cc2:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42cc5:	48 98                	cltq   
   42cc7:	83 e0 01             	and    $0x1,%eax
   42cca:	48 85 c0             	test   %rax,%rax
   42ccd:	75 0a                	jne    42cd9 <lookup_l1pagetable+0x9a>
                return NULL;
   42ccf:	b8 00 00 00 00       	mov    $0x0,%eax
   42cd4:	e9 be 00 00 00       	jmp    42d97 <lookup_l1pagetable+0x158>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   42cd9:	be af 00 00 00       	mov    $0xaf,%esi
   42cde:	bf 80 4b 04 00       	mov    $0x44b80,%edi
   42ce3:	b8 00 00 00 00       	mov    $0x0,%eax
   42ce8:	e8 c9 f6 ff ff       	call   423b6 <log_printf>
            return NULL;
   42ced:	b8 00 00 00 00       	mov    $0x0,%eax
   42cf2:	e9 a0 00 00 00       	jmp    42d97 <lookup_l1pagetable+0x158>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   42cf7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42cfb:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42d01:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   42d07:	76 14                	jbe    42d1d <lookup_l1pagetable+0xde>
   42d09:	ba c8 4b 04 00       	mov    $0x44bc8,%edx
   42d0e:	be b4 00 00 00       	mov    $0xb4,%esi
   42d13:	bf 15 48 04 00       	mov    $0x44815,%edi
   42d18:	e8 b7 f9 ff ff       	call   426d4 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   42d1d:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42d20:	48 98                	cltq   
   42d22:	83 e0 02             	and    $0x2,%eax
   42d25:	48 85 c0             	test   %rax,%rax
   42d28:	74 20                	je     42d4a <lookup_l1pagetable+0x10b>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   42d2a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d2e:	83 e0 02             	and    $0x2,%eax
   42d31:	48 85 c0             	test   %rax,%rax
   42d34:	75 14                	jne    42d4a <lookup_l1pagetable+0x10b>
   42d36:	ba e8 4b 04 00       	mov    $0x44be8,%edx
   42d3b:	be b6 00 00 00       	mov    $0xb6,%esi
   42d40:	bf 15 48 04 00       	mov    $0x44815,%edi
   42d45:	e8 8a f9 ff ff       	call   426d4 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   42d4a:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42d4d:	48 98                	cltq   
   42d4f:	83 e0 04             	and    $0x4,%eax
   42d52:	48 85 c0             	test   %rax,%rax
   42d55:	74 20                	je     42d77 <lookup_l1pagetable+0x138>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   42d57:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d5b:	83 e0 04             	and    $0x4,%eax
   42d5e:	48 85 c0             	test   %rax,%rax
   42d61:	75 14                	jne    42d77 <lookup_l1pagetable+0x138>
   42d63:	ba f3 4b 04 00       	mov    $0x44bf3,%edx
   42d68:	be b9 00 00 00       	mov    $0xb9,%esi
   42d6d:	bf 15 48 04 00       	mov    $0x44815,%edi
   42d72:	e8 5d f9 ff ff       	call   426d4 <assert_fail>
        }

        // TODO --> done
        // set pt to physical address to next pagetable using `pe`
        pt = (x86_64_pagetable *) PTE_ADDR(pe); // replace this
   42d77:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d7b:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42d81:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   42d85:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   42d89:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   42d8d:	0f 8e d3 fe ff ff    	jle    42c66 <lookup_l1pagetable+0x27>
    }
    return pt;
   42d93:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   42d97:	c9                   	leave  
   42d98:	c3                   	ret    

0000000000042d99 <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   42d99:	55                   	push   %rbp
   42d9a:	48 89 e5             	mov    %rsp,%rbp
   42d9d:	48 83 ec 50          	sub    $0x50,%rsp
   42da1:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42da5:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42da9:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   42dad:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42db1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   42db5:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   42dbc:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42dbd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   42dc4:	eb 41                	jmp    42e07 <virtual_memory_lookup+0x6e>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   42dc6:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42dc9:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42dcd:	89 d6                	mov    %edx,%esi
   42dcf:	48 89 c7             	mov    %rax,%rdi
   42dd2:	e8 62 f9 ff ff       	call   42739 <pageindex>
   42dd7:	89 c2                	mov    %eax,%edx
   42dd9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42ddd:	48 63 d2             	movslq %edx,%rdx
   42de0:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   42de4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42de8:	83 e0 06             	and    $0x6,%eax
   42deb:	48 f7 d0             	not    %rax
   42dee:	48 21 d0             	and    %rdx,%rax
   42df1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42df5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42df9:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42dff:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42e03:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   42e07:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   42e0b:	7f 0c                	jg     42e19 <virtual_memory_lookup+0x80>
   42e0d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e11:	83 e0 01             	and    $0x1,%eax
   42e14:	48 85 c0             	test   %rax,%rax
   42e17:	75 ad                	jne    42dc6 <virtual_memory_lookup+0x2d>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   42e19:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   42e20:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   42e27:	ff 
   42e28:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   42e2f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e33:	83 e0 01             	and    $0x1,%eax
   42e36:	48 85 c0             	test   %rax,%rax
   42e39:	74 34                	je     42e6f <virtual_memory_lookup+0xd6>
        vam.pn = PAGENUMBER(pe);
   42e3b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e3f:	48 c1 e8 0c          	shr    $0xc,%rax
   42e43:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   42e46:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e4a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42e50:	48 89 c2             	mov    %rax,%rdx
   42e53:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42e57:	25 ff 0f 00 00       	and    $0xfff,%eax
   42e5c:	48 09 d0             	or     %rdx,%rax
   42e5f:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   42e63:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e67:	25 ff 0f 00 00       	and    $0xfff,%eax
   42e6c:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   42e6f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42e73:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42e77:	48 89 10             	mov    %rdx,(%rax)
   42e7a:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   42e7e:	48 89 50 08          	mov    %rdx,0x8(%rax)
   42e82:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42e86:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   42e8a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42e8e:	c9                   	leave  
   42e8f:	c3                   	ret    

0000000000042e90 <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   42e90:	55                   	push   %rbp
   42e91:	48 89 e5             	mov    %rsp,%rbp
   42e94:	48 83 ec 40          	sub    $0x40,%rsp
   42e98:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42e9c:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   42e9f:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   42ea3:	c7 45 f8 07 00 00 00 	movl   $0x7,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   42eaa:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   42eae:	78 08                	js     42eb8 <program_load+0x28>
   42eb0:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42eb3:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   42eb6:	7c 14                	jl     42ecc <program_load+0x3c>
   42eb8:	ba 00 4c 04 00       	mov    $0x44c00,%edx
   42ebd:	be 37 00 00 00       	mov    $0x37,%esi
   42ec2:	bf 30 4c 04 00       	mov    $0x44c30,%edi
   42ec7:	e8 08 f8 ff ff       	call   426d4 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   42ecc:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42ecf:	48 98                	cltq   
   42ed1:	48 c1 e0 04          	shl    $0x4,%rax
   42ed5:	48 05 20 50 04 00    	add    $0x45020,%rax
   42edb:	48 8b 00             	mov    (%rax),%rax
   42ede:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   42ee2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ee6:	8b 00                	mov    (%rax),%eax
   42ee8:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   42eed:	74 14                	je     42f03 <program_load+0x73>
   42eef:	ba 42 4c 04 00       	mov    $0x44c42,%edx
   42ef4:	be 39 00 00 00       	mov    $0x39,%esi
   42ef9:	bf 30 4c 04 00       	mov    $0x44c30,%edi
   42efe:	e8 d1 f7 ff ff       	call   426d4 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   42f03:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42f07:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42f0b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42f0f:	48 01 d0             	add    %rdx,%rax
   42f12:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   42f16:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42f1d:	e9 94 00 00 00       	jmp    42fb6 <program_load+0x126>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   42f22:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42f25:	48 63 d0             	movslq %eax,%rdx
   42f28:	48 89 d0             	mov    %rdx,%rax
   42f2b:	48 c1 e0 03          	shl    $0x3,%rax
   42f2f:	48 29 d0             	sub    %rdx,%rax
   42f32:	48 c1 e0 03          	shl    $0x3,%rax
   42f36:	48 89 c2             	mov    %rax,%rdx
   42f39:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f3d:	48 01 d0             	add    %rdx,%rax
   42f40:	8b 00                	mov    (%rax),%eax
   42f42:	83 f8 01             	cmp    $0x1,%eax
   42f45:	75 6b                	jne    42fb2 <program_load+0x122>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   42f47:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42f4a:	48 63 d0             	movslq %eax,%rdx
   42f4d:	48 89 d0             	mov    %rdx,%rax
   42f50:	48 c1 e0 03          	shl    $0x3,%rax
   42f54:	48 29 d0             	sub    %rdx,%rax
   42f57:	48 c1 e0 03          	shl    $0x3,%rax
   42f5b:	48 89 c2             	mov    %rax,%rdx
   42f5e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f62:	48 01 d0             	add    %rdx,%rax
   42f65:	48 8b 50 08          	mov    0x8(%rax),%rdx
   42f69:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42f6d:	48 01 d0             	add    %rdx,%rax
   42f70:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   42f74:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42f77:	48 63 d0             	movslq %eax,%rdx
   42f7a:	48 89 d0             	mov    %rdx,%rax
   42f7d:	48 c1 e0 03          	shl    $0x3,%rax
   42f81:	48 29 d0             	sub    %rdx,%rax
   42f84:	48 c1 e0 03          	shl    $0x3,%rax
   42f88:	48 89 c2             	mov    %rax,%rdx
   42f8b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f8f:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   42f93:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42f97:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42f9b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42f9f:	48 89 c7             	mov    %rax,%rdi
   42fa2:	e8 3d 00 00 00       	call   42fe4 <program_load_segment>
   42fa7:	85 c0                	test   %eax,%eax
   42fa9:	79 07                	jns    42fb2 <program_load+0x122>
                return -1;
   42fab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42fb0:	eb 30                	jmp    42fe2 <program_load+0x152>
    for (int i = 0; i < eh->e_phnum; ++i) {
   42fb2:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   42fb6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42fba:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   42fbe:	0f b7 c0             	movzwl %ax,%eax
   42fc1:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   42fc4:	0f 8c 58 ff ff ff    	jl     42f22 <program_load+0x92>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   42fca:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42fce:	48 8b 50 18          	mov    0x18(%rax),%rdx
   42fd2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42fd6:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    return 0;
   42fdd:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42fe2:	c9                   	leave  
   42fe3:	c3                   	ret    

0000000000042fe4 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   42fe4:	55                   	push   %rbp
   42fe5:	48 89 e5             	mov    %rsp,%rbp
   42fe8:	48 83 ec 40          	sub    $0x40,%rsp
   42fec:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42ff0:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42ff4:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   42ff8:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   42ffc:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43000:	48 8b 40 10          	mov    0x10(%rax),%rax
   43004:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   43008:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4300c:	48 8b 50 20          	mov    0x20(%rax),%rdx
   43010:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43014:	48 01 d0             	add    %rdx,%rax
   43017:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   4301b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4301f:	48 8b 50 28          	mov    0x28(%rax),%rdx
   43023:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43027:	48 01 d0             	add    %rdx,%rax
   4302a:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   4302e:	48 81 65 f0 00 f0 ff 	andq   $0xfffffffffffff000,-0x10(%rbp)
   43035:	ff 

    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   43036:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4303a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   4303e:	eb 7c                	jmp    430bc <program_load_segment+0xd8>
        if (assign_physical_page(addr, p->p_pid) < 0
   43040:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43044:	8b 00                	mov    (%rax),%eax
   43046:	0f be d0             	movsbl %al,%edx
   43049:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4304d:	89 d6                	mov    %edx,%esi
   4304f:	48 89 c7             	mov    %rax,%rdi
   43052:	e8 af d5 ff ff       	call   40606 <assign_physical_page>
   43057:	85 c0                	test   %eax,%eax
   43059:	78 2a                	js     43085 <program_load_segment+0xa1>
            || virtual_memory_map(p->p_pagetable, addr, addr, PAGESIZE,
   4305b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4305f:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   43066:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4306a:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   4306e:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43074:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43079:	48 89 c7             	mov    %rax,%rdi
   4307c:	e8 52 f9 ff ff       	call   429d3 <virtual_memory_map>
   43081:	85 c0                	test   %eax,%eax
   43083:	79 2f                	jns    430b4 <program_load_segment+0xd0>
                                  PTE_P | PTE_W | PTE_U) < 0) {
            console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   43085:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43089:	8b 00                	mov    (%rax),%eax
   4308b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4308f:	49 89 d0             	mov    %rdx,%r8
   43092:	89 c1                	mov    %eax,%ecx
   43094:	ba 60 4c 04 00       	mov    $0x44c60,%edx
   43099:	be 00 c0 00 00       	mov    $0xc000,%esi
   4309e:	bf e0 06 00 00       	mov    $0x6e0,%edi
   430a3:	b8 00 00 00 00       	mov    $0x0,%eax
   430a8:	e8 35 0f 00 00       	call   43fe2 <console_printf>
            return -1;
   430ad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   430b2:	eb 77                	jmp    4312b <program_load_segment+0x147>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   430b4:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   430bb:	00 
   430bc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   430c0:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   430c4:	0f 82 76 ff ff ff    	jb     43040 <program_load_segment+0x5c>
        }
    }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   430ca:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   430ce:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   430d5:	48 89 c7             	mov    %rax,%rdi
   430d8:	e8 c5 f7 ff ff       	call   428a2 <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   430dd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   430e1:	48 2b 45 f0          	sub    -0x10(%rbp),%rax
   430e5:	48 89 c2             	mov    %rax,%rdx
   430e8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   430ec:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   430f0:	48 89 ce             	mov    %rcx,%rsi
   430f3:	48 89 c7             	mov    %rax,%rdi
   430f6:	e8 32 00 00 00       	call   4312d <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   430fb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   430ff:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   43103:	48 89 c2             	mov    %rax,%rdx
   43106:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4310a:	be 00 00 00 00       	mov    $0x0,%esi
   4310f:	48 89 c7             	mov    %rax,%rdi
   43112:	e8 14 01 00 00       	call   4322b <memset>

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   43117:	48 8b 05 e2 1e 01 00 	mov    0x11ee2(%rip),%rax        # 55000 <kernel_pagetable>
   4311e:	48 89 c7             	mov    %rax,%rdi
   43121:	e8 7c f7 ff ff       	call   428a2 <set_pagetable>
    return 0;
   43126:	b8 00 00 00 00       	mov    $0x0,%eax
}
   4312b:	c9                   	leave  
   4312c:	c3                   	ret    

000000000004312d <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   4312d:	55                   	push   %rbp
   4312e:	48 89 e5             	mov    %rsp,%rbp
   43131:	48 83 ec 28          	sub    $0x28,%rsp
   43135:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43139:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   4313d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43141:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43145:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43149:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4314d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43151:	eb 1c                	jmp    4316f <memcpy+0x42>
        *d = *s;
   43153:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43157:	0f b6 10             	movzbl (%rax),%edx
   4315a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4315e:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43160:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43165:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   4316a:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   4316f:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43174:	75 dd                	jne    43153 <memcpy+0x26>
    }
    return dst;
   43176:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   4317a:	c9                   	leave  
   4317b:	c3                   	ret    

000000000004317c <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   4317c:	55                   	push   %rbp
   4317d:	48 89 e5             	mov    %rsp,%rbp
   43180:	48 83 ec 28          	sub    $0x28,%rsp
   43184:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43188:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   4318c:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43190:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43194:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   43198:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4319c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   431a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   431a4:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   431a8:	73 6a                	jae    43214 <memmove+0x98>
   431aa:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   431ae:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   431b2:	48 01 d0             	add    %rdx,%rax
   431b5:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   431b9:	73 59                	jae    43214 <memmove+0x98>
        s += n, d += n;
   431bb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   431bf:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   431c3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   431c7:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   431cb:	eb 17                	jmp    431e4 <memmove+0x68>
            *--d = *--s;
   431cd:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   431d2:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   431d7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   431db:	0f b6 10             	movzbl (%rax),%edx
   431de:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   431e2:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   431e4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   431e8:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   431ec:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   431f0:	48 85 c0             	test   %rax,%rax
   431f3:	75 d8                	jne    431cd <memmove+0x51>
    if (s < d && s + n > d) {
   431f5:	eb 2e                	jmp    43225 <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   431f7:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   431fb:	48 8d 42 01          	lea    0x1(%rdx),%rax
   431ff:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43203:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43207:	48 8d 48 01          	lea    0x1(%rax),%rcx
   4320b:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   4320f:	0f b6 12             	movzbl (%rdx),%edx
   43212:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43214:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43218:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   4321c:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43220:	48 85 c0             	test   %rax,%rax
   43223:	75 d2                	jne    431f7 <memmove+0x7b>
        }
    }
    return dst;
   43225:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43229:	c9                   	leave  
   4322a:	c3                   	ret    

000000000004322b <memset>:

void* memset(void* v, int c, size_t n) {
   4322b:	55                   	push   %rbp
   4322c:	48 89 e5             	mov    %rsp,%rbp
   4322f:	48 83 ec 28          	sub    $0x28,%rsp
   43233:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43237:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   4323a:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   4323e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43242:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43246:	eb 15                	jmp    4325d <memset+0x32>
        *p = c;
   43248:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4324b:	89 c2                	mov    %eax,%edx
   4324d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43251:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43253:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43258:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   4325d:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43262:	75 e4                	jne    43248 <memset+0x1d>
    }
    return v;
   43264:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43268:	c9                   	leave  
   43269:	c3                   	ret    

000000000004326a <strlen>:

size_t strlen(const char* s) {
   4326a:	55                   	push   %rbp
   4326b:	48 89 e5             	mov    %rsp,%rbp
   4326e:	48 83 ec 18          	sub    $0x18,%rsp
   43272:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   43276:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   4327d:	00 
   4327e:	eb 0a                	jmp    4328a <strlen+0x20>
        ++n;
   43280:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   43285:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   4328a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4328e:	0f b6 00             	movzbl (%rax),%eax
   43291:	84 c0                	test   %al,%al
   43293:	75 eb                	jne    43280 <strlen+0x16>
    }
    return n;
   43295:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43299:	c9                   	leave  
   4329a:	c3                   	ret    

000000000004329b <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   4329b:	55                   	push   %rbp
   4329c:	48 89 e5             	mov    %rsp,%rbp
   4329f:	48 83 ec 20          	sub    $0x20,%rsp
   432a3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   432a7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   432ab:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   432b2:	00 
   432b3:	eb 0a                	jmp    432bf <strnlen+0x24>
        ++n;
   432b5:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   432ba:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   432bf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   432c3:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   432c7:	74 0b                	je     432d4 <strnlen+0x39>
   432c9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   432cd:	0f b6 00             	movzbl (%rax),%eax
   432d0:	84 c0                	test   %al,%al
   432d2:	75 e1                	jne    432b5 <strnlen+0x1a>
    }
    return n;
   432d4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   432d8:	c9                   	leave  
   432d9:	c3                   	ret    

00000000000432da <strcpy>:

char* strcpy(char* dst, const char* src) {
   432da:	55                   	push   %rbp
   432db:	48 89 e5             	mov    %rsp,%rbp
   432de:	48 83 ec 20          	sub    $0x20,%rsp
   432e2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   432e6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   432ea:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   432ee:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   432f2:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   432f6:	48 8d 42 01          	lea    0x1(%rdx),%rax
   432fa:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   432fe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43302:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43306:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   4330a:	0f b6 12             	movzbl (%rdx),%edx
   4330d:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   4330f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43313:	48 83 e8 01          	sub    $0x1,%rax
   43317:	0f b6 00             	movzbl (%rax),%eax
   4331a:	84 c0                	test   %al,%al
   4331c:	75 d4                	jne    432f2 <strcpy+0x18>
    return dst;
   4331e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43322:	c9                   	leave  
   43323:	c3                   	ret    

0000000000043324 <strcmp>:

int strcmp(const char* a, const char* b) {
   43324:	55                   	push   %rbp
   43325:	48 89 e5             	mov    %rsp,%rbp
   43328:	48 83 ec 10          	sub    $0x10,%rsp
   4332c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43330:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43334:	eb 0a                	jmp    43340 <strcmp+0x1c>
        ++a, ++b;
   43336:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   4333b:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43340:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43344:	0f b6 00             	movzbl (%rax),%eax
   43347:	84 c0                	test   %al,%al
   43349:	74 1d                	je     43368 <strcmp+0x44>
   4334b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4334f:	0f b6 00             	movzbl (%rax),%eax
   43352:	84 c0                	test   %al,%al
   43354:	74 12                	je     43368 <strcmp+0x44>
   43356:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4335a:	0f b6 10             	movzbl (%rax),%edx
   4335d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43361:	0f b6 00             	movzbl (%rax),%eax
   43364:	38 c2                	cmp    %al,%dl
   43366:	74 ce                	je     43336 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   43368:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4336c:	0f b6 00             	movzbl (%rax),%eax
   4336f:	89 c2                	mov    %eax,%edx
   43371:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43375:	0f b6 00             	movzbl (%rax),%eax
   43378:	38 d0                	cmp    %dl,%al
   4337a:	0f 92 c0             	setb   %al
   4337d:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   43380:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43384:	0f b6 00             	movzbl (%rax),%eax
   43387:	89 c1                	mov    %eax,%ecx
   43389:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4338d:	0f b6 00             	movzbl (%rax),%eax
   43390:	38 c1                	cmp    %al,%cl
   43392:	0f 92 c0             	setb   %al
   43395:	0f b6 c0             	movzbl %al,%eax
   43398:	29 c2                	sub    %eax,%edx
   4339a:	89 d0                	mov    %edx,%eax
}
   4339c:	c9                   	leave  
   4339d:	c3                   	ret    

000000000004339e <strchr>:

char* strchr(const char* s, int c) {
   4339e:	55                   	push   %rbp
   4339f:	48 89 e5             	mov    %rsp,%rbp
   433a2:	48 83 ec 10          	sub    $0x10,%rsp
   433a6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   433aa:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   433ad:	eb 05                	jmp    433b4 <strchr+0x16>
        ++s;
   433af:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   433b4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   433b8:	0f b6 00             	movzbl (%rax),%eax
   433bb:	84 c0                	test   %al,%al
   433bd:	74 0e                	je     433cd <strchr+0x2f>
   433bf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   433c3:	0f b6 00             	movzbl (%rax),%eax
   433c6:	8b 55 f4             	mov    -0xc(%rbp),%edx
   433c9:	38 d0                	cmp    %dl,%al
   433cb:	75 e2                	jne    433af <strchr+0x11>
    }
    if (*s == (char) c) {
   433cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   433d1:	0f b6 00             	movzbl (%rax),%eax
   433d4:	8b 55 f4             	mov    -0xc(%rbp),%edx
   433d7:	38 d0                	cmp    %dl,%al
   433d9:	75 06                	jne    433e1 <strchr+0x43>
        return (char*) s;
   433db:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   433df:	eb 05                	jmp    433e6 <strchr+0x48>
    } else {
        return NULL;
   433e1:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   433e6:	c9                   	leave  
   433e7:	c3                   	ret    

00000000000433e8 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   433e8:	55                   	push   %rbp
   433e9:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   433ec:	8b 05 0e 7c 01 00    	mov    0x17c0e(%rip),%eax        # 5b000 <rand_seed_set>
   433f2:	85 c0                	test   %eax,%eax
   433f4:	75 0a                	jne    43400 <rand+0x18>
        srand(819234718U);
   433f6:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   433fb:	e8 24 00 00 00       	call   43424 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   43400:	8b 05 fe 7b 01 00    	mov    0x17bfe(%rip),%eax        # 5b004 <rand_seed>
   43406:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   4340c:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   43411:	89 05 ed 7b 01 00    	mov    %eax,0x17bed(%rip)        # 5b004 <rand_seed>
    return rand_seed & RAND_MAX;
   43417:	8b 05 e7 7b 01 00    	mov    0x17be7(%rip),%eax        # 5b004 <rand_seed>
   4341d:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   43422:	5d                   	pop    %rbp
   43423:	c3                   	ret    

0000000000043424 <srand>:

void srand(unsigned seed) {
   43424:	55                   	push   %rbp
   43425:	48 89 e5             	mov    %rsp,%rbp
   43428:	48 83 ec 08          	sub    $0x8,%rsp
   4342c:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   4342f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43432:	89 05 cc 7b 01 00    	mov    %eax,0x17bcc(%rip)        # 5b004 <rand_seed>
    rand_seed_set = 1;
   43438:	c7 05 be 7b 01 00 01 	movl   $0x1,0x17bbe(%rip)        # 5b000 <rand_seed_set>
   4343f:	00 00 00 
}
   43442:	90                   	nop
   43443:	c9                   	leave  
   43444:	c3                   	ret    

0000000000043445 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   43445:	55                   	push   %rbp
   43446:	48 89 e5             	mov    %rsp,%rbp
   43449:	48 83 ec 28          	sub    $0x28,%rsp
   4344d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43451:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43455:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   43458:	48 c7 45 f8 80 4e 04 	movq   $0x44e80,-0x8(%rbp)
   4345f:	00 
    if (base < 0) {
   43460:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   43464:	79 0b                	jns    43471 <fill_numbuf+0x2c>
        digits = lower_digits;
   43466:	48 c7 45 f8 a0 4e 04 	movq   $0x44ea0,-0x8(%rbp)
   4346d:	00 
        base = -base;
   4346e:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   43471:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43476:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4347a:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   4347d:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43480:	48 63 c8             	movslq %eax,%rcx
   43483:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43487:	ba 00 00 00 00       	mov    $0x0,%edx
   4348c:	48 f7 f1             	div    %rcx
   4348f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43493:	48 01 d0             	add    %rdx,%rax
   43496:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   4349b:	0f b6 10             	movzbl (%rax),%edx
   4349e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   434a2:	88 10                	mov    %dl,(%rax)
        val /= base;
   434a4:	8b 45 dc             	mov    -0x24(%rbp),%eax
   434a7:	48 63 f0             	movslq %eax,%rsi
   434aa:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   434ae:	ba 00 00 00 00       	mov    $0x0,%edx
   434b3:	48 f7 f6             	div    %rsi
   434b6:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   434ba:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   434bf:	75 bc                	jne    4347d <fill_numbuf+0x38>
    return numbuf_end;
   434c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   434c5:	c9                   	leave  
   434c6:	c3                   	ret    

00000000000434c7 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   434c7:	55                   	push   %rbp
   434c8:	48 89 e5             	mov    %rsp,%rbp
   434cb:	53                   	push   %rbx
   434cc:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   434d3:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   434da:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   434e0:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   434e7:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   434ee:	e9 8a 09 00 00       	jmp    43e7d <printer_vprintf+0x9b6>
        if (*format != '%') {
   434f3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   434fa:	0f b6 00             	movzbl (%rax),%eax
   434fd:	3c 25                	cmp    $0x25,%al
   434ff:	74 31                	je     43532 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
   43501:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43508:	4c 8b 00             	mov    (%rax),%r8
   4350b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43512:	0f b6 00             	movzbl (%rax),%eax
   43515:	0f b6 c8             	movzbl %al,%ecx
   43518:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   4351e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43525:	89 ce                	mov    %ecx,%esi
   43527:	48 89 c7             	mov    %rax,%rdi
   4352a:	41 ff d0             	call   *%r8
            continue;
   4352d:	e9 43 09 00 00       	jmp    43e75 <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
   43532:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   43539:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43540:	01 
   43541:	eb 44                	jmp    43587 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
   43543:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4354a:	0f b6 00             	movzbl (%rax),%eax
   4354d:	0f be c0             	movsbl %al,%eax
   43550:	89 c6                	mov    %eax,%esi
   43552:	bf a0 4c 04 00       	mov    $0x44ca0,%edi
   43557:	e8 42 fe ff ff       	call   4339e <strchr>
   4355c:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   43560:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   43565:	74 30                	je     43597 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
   43567:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   4356b:	48 2d a0 4c 04 00    	sub    $0x44ca0,%rax
   43571:	ba 01 00 00 00       	mov    $0x1,%edx
   43576:	89 c1                	mov    %eax,%ecx
   43578:	d3 e2                	shl    %cl,%edx
   4357a:	89 d0                	mov    %edx,%eax
   4357c:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   4357f:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43586:	01 
   43587:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4358e:	0f b6 00             	movzbl (%rax),%eax
   43591:	84 c0                	test   %al,%al
   43593:	75 ae                	jne    43543 <printer_vprintf+0x7c>
   43595:	eb 01                	jmp    43598 <printer_vprintf+0xd1>
            } else {
                break;
   43597:	90                   	nop
            }
        }

        // process width
        int width = -1;
   43598:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   4359f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   435a6:	0f b6 00             	movzbl (%rax),%eax
   435a9:	3c 30                	cmp    $0x30,%al
   435ab:	7e 67                	jle    43614 <printer_vprintf+0x14d>
   435ad:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   435b4:	0f b6 00             	movzbl (%rax),%eax
   435b7:	3c 39                	cmp    $0x39,%al
   435b9:	7f 59                	jg     43614 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   435bb:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   435c2:	eb 2e                	jmp    435f2 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
   435c4:	8b 55 e8             	mov    -0x18(%rbp),%edx
   435c7:	89 d0                	mov    %edx,%eax
   435c9:	c1 e0 02             	shl    $0x2,%eax
   435cc:	01 d0                	add    %edx,%eax
   435ce:	01 c0                	add    %eax,%eax
   435d0:	89 c1                	mov    %eax,%ecx
   435d2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   435d9:	48 8d 50 01          	lea    0x1(%rax),%rdx
   435dd:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   435e4:	0f b6 00             	movzbl (%rax),%eax
   435e7:	0f be c0             	movsbl %al,%eax
   435ea:	01 c8                	add    %ecx,%eax
   435ec:	83 e8 30             	sub    $0x30,%eax
   435ef:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   435f2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   435f9:	0f b6 00             	movzbl (%rax),%eax
   435fc:	3c 2f                	cmp    $0x2f,%al
   435fe:	0f 8e 85 00 00 00    	jle    43689 <printer_vprintf+0x1c2>
   43604:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4360b:	0f b6 00             	movzbl (%rax),%eax
   4360e:	3c 39                	cmp    $0x39,%al
   43610:	7e b2                	jle    435c4 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
   43612:	eb 75                	jmp    43689 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
   43614:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4361b:	0f b6 00             	movzbl (%rax),%eax
   4361e:	3c 2a                	cmp    $0x2a,%al
   43620:	75 68                	jne    4368a <printer_vprintf+0x1c3>
            width = va_arg(val, int);
   43622:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43629:	8b 00                	mov    (%rax),%eax
   4362b:	83 f8 2f             	cmp    $0x2f,%eax
   4362e:	77 30                	ja     43660 <printer_vprintf+0x199>
   43630:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43637:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4363b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43642:	8b 00                	mov    (%rax),%eax
   43644:	89 c0                	mov    %eax,%eax
   43646:	48 01 d0             	add    %rdx,%rax
   43649:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43650:	8b 12                	mov    (%rdx),%edx
   43652:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43655:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4365c:	89 0a                	mov    %ecx,(%rdx)
   4365e:	eb 1a                	jmp    4367a <printer_vprintf+0x1b3>
   43660:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43667:	48 8b 40 08          	mov    0x8(%rax),%rax
   4366b:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4366f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43676:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4367a:	8b 00                	mov    (%rax),%eax
   4367c:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   4367f:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43686:	01 
   43687:	eb 01                	jmp    4368a <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
   43689:	90                   	nop
        }

        // process precision
        int precision = -1;
   4368a:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   43691:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43698:	0f b6 00             	movzbl (%rax),%eax
   4369b:	3c 2e                	cmp    $0x2e,%al
   4369d:	0f 85 00 01 00 00    	jne    437a3 <printer_vprintf+0x2dc>
            ++format;
   436a3:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   436aa:	01 
            if (*format >= '0' && *format <= '9') {
   436ab:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   436b2:	0f b6 00             	movzbl (%rax),%eax
   436b5:	3c 2f                	cmp    $0x2f,%al
   436b7:	7e 67                	jle    43720 <printer_vprintf+0x259>
   436b9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   436c0:	0f b6 00             	movzbl (%rax),%eax
   436c3:	3c 39                	cmp    $0x39,%al
   436c5:	7f 59                	jg     43720 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   436c7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   436ce:	eb 2e                	jmp    436fe <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
   436d0:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   436d3:	89 d0                	mov    %edx,%eax
   436d5:	c1 e0 02             	shl    $0x2,%eax
   436d8:	01 d0                	add    %edx,%eax
   436da:	01 c0                	add    %eax,%eax
   436dc:	89 c1                	mov    %eax,%ecx
   436de:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   436e5:	48 8d 50 01          	lea    0x1(%rax),%rdx
   436e9:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   436f0:	0f b6 00             	movzbl (%rax),%eax
   436f3:	0f be c0             	movsbl %al,%eax
   436f6:	01 c8                	add    %ecx,%eax
   436f8:	83 e8 30             	sub    $0x30,%eax
   436fb:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   436fe:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43705:	0f b6 00             	movzbl (%rax),%eax
   43708:	3c 2f                	cmp    $0x2f,%al
   4370a:	0f 8e 85 00 00 00    	jle    43795 <printer_vprintf+0x2ce>
   43710:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43717:	0f b6 00             	movzbl (%rax),%eax
   4371a:	3c 39                	cmp    $0x39,%al
   4371c:	7e b2                	jle    436d0 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
   4371e:	eb 75                	jmp    43795 <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
   43720:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43727:	0f b6 00             	movzbl (%rax),%eax
   4372a:	3c 2a                	cmp    $0x2a,%al
   4372c:	75 68                	jne    43796 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
   4372e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43735:	8b 00                	mov    (%rax),%eax
   43737:	83 f8 2f             	cmp    $0x2f,%eax
   4373a:	77 30                	ja     4376c <printer_vprintf+0x2a5>
   4373c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43743:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43747:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4374e:	8b 00                	mov    (%rax),%eax
   43750:	89 c0                	mov    %eax,%eax
   43752:	48 01 d0             	add    %rdx,%rax
   43755:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4375c:	8b 12                	mov    (%rdx),%edx
   4375e:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43761:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43768:	89 0a                	mov    %ecx,(%rdx)
   4376a:	eb 1a                	jmp    43786 <printer_vprintf+0x2bf>
   4376c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43773:	48 8b 40 08          	mov    0x8(%rax),%rax
   43777:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4377b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43782:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43786:	8b 00                	mov    (%rax),%eax
   43788:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   4378b:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43792:	01 
   43793:	eb 01                	jmp    43796 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
   43795:	90                   	nop
            }
            if (precision < 0) {
   43796:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   4379a:	79 07                	jns    437a3 <printer_vprintf+0x2dc>
                precision = 0;
   4379c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   437a3:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   437aa:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   437b1:	00 
        int length = 0;
   437b2:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   437b9:	48 c7 45 c8 a6 4c 04 	movq   $0x44ca6,-0x38(%rbp)
   437c0:	00 
    again:
        switch (*format) {
   437c1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   437c8:	0f b6 00             	movzbl (%rax),%eax
   437cb:	0f be c0             	movsbl %al,%eax
   437ce:	83 e8 43             	sub    $0x43,%eax
   437d1:	83 f8 37             	cmp    $0x37,%eax
   437d4:	0f 87 9f 03 00 00    	ja     43b79 <printer_vprintf+0x6b2>
   437da:	89 c0                	mov    %eax,%eax
   437dc:	48 8b 04 c5 b8 4c 04 	mov    0x44cb8(,%rax,8),%rax
   437e3:	00 
   437e4:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
   437e6:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   437ed:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   437f4:	01 
            goto again;
   437f5:	eb ca                	jmp    437c1 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   437f7:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   437fb:	74 5d                	je     4385a <printer_vprintf+0x393>
   437fd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43804:	8b 00                	mov    (%rax),%eax
   43806:	83 f8 2f             	cmp    $0x2f,%eax
   43809:	77 30                	ja     4383b <printer_vprintf+0x374>
   4380b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43812:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43816:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4381d:	8b 00                	mov    (%rax),%eax
   4381f:	89 c0                	mov    %eax,%eax
   43821:	48 01 d0             	add    %rdx,%rax
   43824:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4382b:	8b 12                	mov    (%rdx),%edx
   4382d:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43830:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43837:	89 0a                	mov    %ecx,(%rdx)
   43839:	eb 1a                	jmp    43855 <printer_vprintf+0x38e>
   4383b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43842:	48 8b 40 08          	mov    0x8(%rax),%rax
   43846:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4384a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43851:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43855:	48 8b 00             	mov    (%rax),%rax
   43858:	eb 5c                	jmp    438b6 <printer_vprintf+0x3ef>
   4385a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43861:	8b 00                	mov    (%rax),%eax
   43863:	83 f8 2f             	cmp    $0x2f,%eax
   43866:	77 30                	ja     43898 <printer_vprintf+0x3d1>
   43868:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4386f:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43873:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4387a:	8b 00                	mov    (%rax),%eax
   4387c:	89 c0                	mov    %eax,%eax
   4387e:	48 01 d0             	add    %rdx,%rax
   43881:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43888:	8b 12                	mov    (%rdx),%edx
   4388a:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4388d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43894:	89 0a                	mov    %ecx,(%rdx)
   43896:	eb 1a                	jmp    438b2 <printer_vprintf+0x3eb>
   43898:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4389f:	48 8b 40 08          	mov    0x8(%rax),%rax
   438a3:	48 8d 48 08          	lea    0x8(%rax),%rcx
   438a7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   438ae:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   438b2:	8b 00                	mov    (%rax),%eax
   438b4:	48 98                	cltq   
   438b6:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   438ba:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   438be:	48 c1 f8 38          	sar    $0x38,%rax
   438c2:	25 80 00 00 00       	and    $0x80,%eax
   438c7:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   438ca:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   438ce:	74 09                	je     438d9 <printer_vprintf+0x412>
   438d0:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   438d4:	48 f7 d8             	neg    %rax
   438d7:	eb 04                	jmp    438dd <printer_vprintf+0x416>
   438d9:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   438dd:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   438e1:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   438e4:	83 c8 60             	or     $0x60,%eax
   438e7:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   438ea:	e9 cf 02 00 00       	jmp    43bbe <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   438ef:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   438f3:	74 5d                	je     43952 <printer_vprintf+0x48b>
   438f5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   438fc:	8b 00                	mov    (%rax),%eax
   438fe:	83 f8 2f             	cmp    $0x2f,%eax
   43901:	77 30                	ja     43933 <printer_vprintf+0x46c>
   43903:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4390a:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4390e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43915:	8b 00                	mov    (%rax),%eax
   43917:	89 c0                	mov    %eax,%eax
   43919:	48 01 d0             	add    %rdx,%rax
   4391c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43923:	8b 12                	mov    (%rdx),%edx
   43925:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43928:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4392f:	89 0a                	mov    %ecx,(%rdx)
   43931:	eb 1a                	jmp    4394d <printer_vprintf+0x486>
   43933:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4393a:	48 8b 40 08          	mov    0x8(%rax),%rax
   4393e:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43942:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43949:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4394d:	48 8b 00             	mov    (%rax),%rax
   43950:	eb 5c                	jmp    439ae <printer_vprintf+0x4e7>
   43952:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43959:	8b 00                	mov    (%rax),%eax
   4395b:	83 f8 2f             	cmp    $0x2f,%eax
   4395e:	77 30                	ja     43990 <printer_vprintf+0x4c9>
   43960:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43967:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4396b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43972:	8b 00                	mov    (%rax),%eax
   43974:	89 c0                	mov    %eax,%eax
   43976:	48 01 d0             	add    %rdx,%rax
   43979:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43980:	8b 12                	mov    (%rdx),%edx
   43982:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43985:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4398c:	89 0a                	mov    %ecx,(%rdx)
   4398e:	eb 1a                	jmp    439aa <printer_vprintf+0x4e3>
   43990:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43997:	48 8b 40 08          	mov    0x8(%rax),%rax
   4399b:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4399f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   439a6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   439aa:	8b 00                	mov    (%rax),%eax
   439ac:	89 c0                	mov    %eax,%eax
   439ae:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   439b2:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   439b6:	e9 03 02 00 00       	jmp    43bbe <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
   439bb:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   439c2:	e9 28 ff ff ff       	jmp    438ef <printer_vprintf+0x428>
        case 'X':
            base = 16;
   439c7:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   439ce:	e9 1c ff ff ff       	jmp    438ef <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   439d3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   439da:	8b 00                	mov    (%rax),%eax
   439dc:	83 f8 2f             	cmp    $0x2f,%eax
   439df:	77 30                	ja     43a11 <printer_vprintf+0x54a>
   439e1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   439e8:	48 8b 50 10          	mov    0x10(%rax),%rdx
   439ec:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   439f3:	8b 00                	mov    (%rax),%eax
   439f5:	89 c0                	mov    %eax,%eax
   439f7:	48 01 d0             	add    %rdx,%rax
   439fa:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43a01:	8b 12                	mov    (%rdx),%edx
   43a03:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43a06:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43a0d:	89 0a                	mov    %ecx,(%rdx)
   43a0f:	eb 1a                	jmp    43a2b <printer_vprintf+0x564>
   43a11:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a18:	48 8b 40 08          	mov    0x8(%rax),%rax
   43a1c:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43a20:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43a27:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43a2b:	48 8b 00             	mov    (%rax),%rax
   43a2e:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   43a32:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   43a39:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   43a40:	e9 79 01 00 00       	jmp    43bbe <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
   43a45:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a4c:	8b 00                	mov    (%rax),%eax
   43a4e:	83 f8 2f             	cmp    $0x2f,%eax
   43a51:	77 30                	ja     43a83 <printer_vprintf+0x5bc>
   43a53:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a5a:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43a5e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a65:	8b 00                	mov    (%rax),%eax
   43a67:	89 c0                	mov    %eax,%eax
   43a69:	48 01 d0             	add    %rdx,%rax
   43a6c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43a73:	8b 12                	mov    (%rdx),%edx
   43a75:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43a78:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43a7f:	89 0a                	mov    %ecx,(%rdx)
   43a81:	eb 1a                	jmp    43a9d <printer_vprintf+0x5d6>
   43a83:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a8a:	48 8b 40 08          	mov    0x8(%rax),%rax
   43a8e:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43a92:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43a99:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43a9d:	48 8b 00             	mov    (%rax),%rax
   43aa0:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   43aa4:	e9 15 01 00 00       	jmp    43bbe <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
   43aa9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ab0:	8b 00                	mov    (%rax),%eax
   43ab2:	83 f8 2f             	cmp    $0x2f,%eax
   43ab5:	77 30                	ja     43ae7 <printer_vprintf+0x620>
   43ab7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43abe:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43ac2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ac9:	8b 00                	mov    (%rax),%eax
   43acb:	89 c0                	mov    %eax,%eax
   43acd:	48 01 d0             	add    %rdx,%rax
   43ad0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43ad7:	8b 12                	mov    (%rdx),%edx
   43ad9:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43adc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43ae3:	89 0a                	mov    %ecx,(%rdx)
   43ae5:	eb 1a                	jmp    43b01 <printer_vprintf+0x63a>
   43ae7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43aee:	48 8b 40 08          	mov    0x8(%rax),%rax
   43af2:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43af6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43afd:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43b01:	8b 00                	mov    (%rax),%eax
   43b03:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   43b09:	e9 67 03 00 00       	jmp    43e75 <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
   43b0e:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43b12:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   43b16:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b1d:	8b 00                	mov    (%rax),%eax
   43b1f:	83 f8 2f             	cmp    $0x2f,%eax
   43b22:	77 30                	ja     43b54 <printer_vprintf+0x68d>
   43b24:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b2b:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43b2f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b36:	8b 00                	mov    (%rax),%eax
   43b38:	89 c0                	mov    %eax,%eax
   43b3a:	48 01 d0             	add    %rdx,%rax
   43b3d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43b44:	8b 12                	mov    (%rdx),%edx
   43b46:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43b49:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43b50:	89 0a                	mov    %ecx,(%rdx)
   43b52:	eb 1a                	jmp    43b6e <printer_vprintf+0x6a7>
   43b54:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b5b:	48 8b 40 08          	mov    0x8(%rax),%rax
   43b5f:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43b63:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43b6a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43b6e:	8b 00                	mov    (%rax),%eax
   43b70:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   43b73:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   43b77:	eb 45                	jmp    43bbe <printer_vprintf+0x6f7>
        default:
            data = numbuf;
   43b79:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43b7d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   43b81:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43b88:	0f b6 00             	movzbl (%rax),%eax
   43b8b:	84 c0                	test   %al,%al
   43b8d:	74 0c                	je     43b9b <printer_vprintf+0x6d4>
   43b8f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43b96:	0f b6 00             	movzbl (%rax),%eax
   43b99:	eb 05                	jmp    43ba0 <printer_vprintf+0x6d9>
   43b9b:	b8 25 00 00 00       	mov    $0x25,%eax
   43ba0:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   43ba3:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   43ba7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43bae:	0f b6 00             	movzbl (%rax),%eax
   43bb1:	84 c0                	test   %al,%al
   43bb3:	75 08                	jne    43bbd <printer_vprintf+0x6f6>
                format--;
   43bb5:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   43bbc:	01 
            }
            break;
   43bbd:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   43bbe:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43bc1:	83 e0 20             	and    $0x20,%eax
   43bc4:	85 c0                	test   %eax,%eax
   43bc6:	74 1e                	je     43be6 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   43bc8:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43bcc:	48 83 c0 18          	add    $0x18,%rax
   43bd0:	8b 55 e0             	mov    -0x20(%rbp),%edx
   43bd3:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   43bd7:	48 89 ce             	mov    %rcx,%rsi
   43bda:	48 89 c7             	mov    %rax,%rdi
   43bdd:	e8 63 f8 ff ff       	call   43445 <fill_numbuf>
   43be2:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   43be6:	48 c7 45 c0 a6 4c 04 	movq   $0x44ca6,-0x40(%rbp)
   43bed:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   43bee:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43bf1:	83 e0 20             	and    $0x20,%eax
   43bf4:	85 c0                	test   %eax,%eax
   43bf6:	74 48                	je     43c40 <printer_vprintf+0x779>
   43bf8:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43bfb:	83 e0 40             	and    $0x40,%eax
   43bfe:	85 c0                	test   %eax,%eax
   43c00:	74 3e                	je     43c40 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
   43c02:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43c05:	25 80 00 00 00       	and    $0x80,%eax
   43c0a:	85 c0                	test   %eax,%eax
   43c0c:	74 0a                	je     43c18 <printer_vprintf+0x751>
                prefix = "-";
   43c0e:	48 c7 45 c0 a7 4c 04 	movq   $0x44ca7,-0x40(%rbp)
   43c15:	00 
            if (flags & FLAG_NEGATIVE) {
   43c16:	eb 73                	jmp    43c8b <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   43c18:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43c1b:	83 e0 10             	and    $0x10,%eax
   43c1e:	85 c0                	test   %eax,%eax
   43c20:	74 0a                	je     43c2c <printer_vprintf+0x765>
                prefix = "+";
   43c22:	48 c7 45 c0 a9 4c 04 	movq   $0x44ca9,-0x40(%rbp)
   43c29:	00 
            if (flags & FLAG_NEGATIVE) {
   43c2a:	eb 5f                	jmp    43c8b <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   43c2c:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43c2f:	83 e0 08             	and    $0x8,%eax
   43c32:	85 c0                	test   %eax,%eax
   43c34:	74 55                	je     43c8b <printer_vprintf+0x7c4>
                prefix = " ";
   43c36:	48 c7 45 c0 ab 4c 04 	movq   $0x44cab,-0x40(%rbp)
   43c3d:	00 
            if (flags & FLAG_NEGATIVE) {
   43c3e:	eb 4b                	jmp    43c8b <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   43c40:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43c43:	83 e0 20             	and    $0x20,%eax
   43c46:	85 c0                	test   %eax,%eax
   43c48:	74 42                	je     43c8c <printer_vprintf+0x7c5>
   43c4a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43c4d:	83 e0 01             	and    $0x1,%eax
   43c50:	85 c0                	test   %eax,%eax
   43c52:	74 38                	je     43c8c <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
   43c54:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   43c58:	74 06                	je     43c60 <printer_vprintf+0x799>
   43c5a:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   43c5e:	75 2c                	jne    43c8c <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
   43c60:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43c65:	75 0c                	jne    43c73 <printer_vprintf+0x7ac>
   43c67:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43c6a:	25 00 01 00 00       	and    $0x100,%eax
   43c6f:	85 c0                	test   %eax,%eax
   43c71:	74 19                	je     43c8c <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
   43c73:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   43c77:	75 07                	jne    43c80 <printer_vprintf+0x7b9>
   43c79:	b8 ad 4c 04 00       	mov    $0x44cad,%eax
   43c7e:	eb 05                	jmp    43c85 <printer_vprintf+0x7be>
   43c80:	b8 b0 4c 04 00       	mov    $0x44cb0,%eax
   43c85:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   43c89:	eb 01                	jmp    43c8c <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
   43c8b:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   43c8c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   43c90:	78 24                	js     43cb6 <printer_vprintf+0x7ef>
   43c92:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43c95:	83 e0 20             	and    $0x20,%eax
   43c98:	85 c0                	test   %eax,%eax
   43c9a:	75 1a                	jne    43cb6 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
   43c9c:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43c9f:	48 63 d0             	movslq %eax,%rdx
   43ca2:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43ca6:	48 89 d6             	mov    %rdx,%rsi
   43ca9:	48 89 c7             	mov    %rax,%rdi
   43cac:	e8 ea f5 ff ff       	call   4329b <strnlen>
   43cb1:	89 45 bc             	mov    %eax,-0x44(%rbp)
   43cb4:	eb 0f                	jmp    43cc5 <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
   43cb6:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43cba:	48 89 c7             	mov    %rax,%rdi
   43cbd:	e8 a8 f5 ff ff       	call   4326a <strlen>
   43cc2:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   43cc5:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43cc8:	83 e0 20             	and    $0x20,%eax
   43ccb:	85 c0                	test   %eax,%eax
   43ccd:	74 20                	je     43cef <printer_vprintf+0x828>
   43ccf:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   43cd3:	78 1a                	js     43cef <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
   43cd5:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43cd8:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   43cdb:	7e 08                	jle    43ce5 <printer_vprintf+0x81e>
   43cdd:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43ce0:	2b 45 bc             	sub    -0x44(%rbp),%eax
   43ce3:	eb 05                	jmp    43cea <printer_vprintf+0x823>
   43ce5:	b8 00 00 00 00       	mov    $0x0,%eax
   43cea:	89 45 b8             	mov    %eax,-0x48(%rbp)
   43ced:	eb 5c                	jmp    43d4b <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   43cef:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43cf2:	83 e0 20             	and    $0x20,%eax
   43cf5:	85 c0                	test   %eax,%eax
   43cf7:	74 4b                	je     43d44 <printer_vprintf+0x87d>
   43cf9:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43cfc:	83 e0 02             	and    $0x2,%eax
   43cff:	85 c0                	test   %eax,%eax
   43d01:	74 41                	je     43d44 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
   43d03:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43d06:	83 e0 04             	and    $0x4,%eax
   43d09:	85 c0                	test   %eax,%eax
   43d0b:	75 37                	jne    43d44 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
   43d0d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43d11:	48 89 c7             	mov    %rax,%rdi
   43d14:	e8 51 f5 ff ff       	call   4326a <strlen>
   43d19:	89 c2                	mov    %eax,%edx
   43d1b:	8b 45 bc             	mov    -0x44(%rbp),%eax
   43d1e:	01 d0                	add    %edx,%eax
   43d20:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   43d23:	7e 1f                	jle    43d44 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
   43d25:	8b 45 e8             	mov    -0x18(%rbp),%eax
   43d28:	2b 45 bc             	sub    -0x44(%rbp),%eax
   43d2b:	89 c3                	mov    %eax,%ebx
   43d2d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43d31:	48 89 c7             	mov    %rax,%rdi
   43d34:	e8 31 f5 ff ff       	call   4326a <strlen>
   43d39:	89 c2                	mov    %eax,%edx
   43d3b:	89 d8                	mov    %ebx,%eax
   43d3d:	29 d0                	sub    %edx,%eax
   43d3f:	89 45 b8             	mov    %eax,-0x48(%rbp)
   43d42:	eb 07                	jmp    43d4b <printer_vprintf+0x884>
        } else {
            zeros = 0;
   43d44:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   43d4b:	8b 55 bc             	mov    -0x44(%rbp),%edx
   43d4e:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43d51:	01 d0                	add    %edx,%eax
   43d53:	48 63 d8             	movslq %eax,%rbx
   43d56:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43d5a:	48 89 c7             	mov    %rax,%rdi
   43d5d:	e8 08 f5 ff ff       	call   4326a <strlen>
   43d62:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   43d66:	8b 45 e8             	mov    -0x18(%rbp),%eax
   43d69:	29 d0                	sub    %edx,%eax
   43d6b:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   43d6e:	eb 25                	jmp    43d95 <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
   43d70:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43d77:	48 8b 08             	mov    (%rax),%rcx
   43d7a:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43d80:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43d87:	be 20 00 00 00       	mov    $0x20,%esi
   43d8c:	48 89 c7             	mov    %rax,%rdi
   43d8f:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   43d91:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   43d95:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43d98:	83 e0 04             	and    $0x4,%eax
   43d9b:	85 c0                	test   %eax,%eax
   43d9d:	75 36                	jne    43dd5 <printer_vprintf+0x90e>
   43d9f:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   43da3:	7f cb                	jg     43d70 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
   43da5:	eb 2e                	jmp    43dd5 <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
   43da7:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43dae:	4c 8b 00             	mov    (%rax),%r8
   43db1:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43db5:	0f b6 00             	movzbl (%rax),%eax
   43db8:	0f b6 c8             	movzbl %al,%ecx
   43dbb:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43dc1:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43dc8:	89 ce                	mov    %ecx,%esi
   43dca:	48 89 c7             	mov    %rax,%rdi
   43dcd:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   43dd0:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   43dd5:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43dd9:	0f b6 00             	movzbl (%rax),%eax
   43ddc:	84 c0                	test   %al,%al
   43dde:	75 c7                	jne    43da7 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
   43de0:	eb 25                	jmp    43e07 <printer_vprintf+0x940>
            p->putc(p, '0', color);
   43de2:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43de9:	48 8b 08             	mov    (%rax),%rcx
   43dec:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43df2:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43df9:	be 30 00 00 00       	mov    $0x30,%esi
   43dfe:	48 89 c7             	mov    %rax,%rdi
   43e01:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   43e03:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   43e07:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   43e0b:	7f d5                	jg     43de2 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
   43e0d:	eb 32                	jmp    43e41 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
   43e0f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43e16:	4c 8b 00             	mov    (%rax),%r8
   43e19:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43e1d:	0f b6 00             	movzbl (%rax),%eax
   43e20:	0f b6 c8             	movzbl %al,%ecx
   43e23:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43e29:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43e30:	89 ce                	mov    %ecx,%esi
   43e32:	48 89 c7             	mov    %rax,%rdi
   43e35:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   43e38:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   43e3d:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   43e41:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   43e45:	7f c8                	jg     43e0f <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
   43e47:	eb 25                	jmp    43e6e <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
   43e49:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43e50:	48 8b 08             	mov    (%rax),%rcx
   43e53:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43e59:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43e60:	be 20 00 00 00       	mov    $0x20,%esi
   43e65:	48 89 c7             	mov    %rax,%rdi
   43e68:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   43e6a:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   43e6e:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   43e72:	7f d5                	jg     43e49 <printer_vprintf+0x982>
        }
    done: ;
   43e74:	90                   	nop
    for (; *format; ++format) {
   43e75:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43e7c:	01 
   43e7d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43e84:	0f b6 00             	movzbl (%rax),%eax
   43e87:	84 c0                	test   %al,%al
   43e89:	0f 85 64 f6 ff ff    	jne    434f3 <printer_vprintf+0x2c>
    }
}
   43e8f:	90                   	nop
   43e90:	90                   	nop
   43e91:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   43e95:	c9                   	leave  
   43e96:	c3                   	ret    

0000000000043e97 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   43e97:	55                   	push   %rbp
   43e98:	48 89 e5             	mov    %rsp,%rbp
   43e9b:	48 83 ec 20          	sub    $0x20,%rsp
   43e9f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43ea3:	89 f0                	mov    %esi,%eax
   43ea5:	89 55 e0             	mov    %edx,-0x20(%rbp)
   43ea8:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   43eab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43eaf:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   43eb3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43eb7:	48 8b 40 08          	mov    0x8(%rax),%rax
   43ebb:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
   43ec0:	48 39 d0             	cmp    %rdx,%rax
   43ec3:	72 0c                	jb     43ed1 <console_putc+0x3a>
        cp->cursor = console;
   43ec5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43ec9:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
   43ed0:	00 
    }
    if (c == '\n') {
   43ed1:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   43ed5:	75 78                	jne    43f4f <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
   43ed7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43edb:	48 8b 40 08          	mov    0x8(%rax),%rax
   43edf:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   43ee5:	48 d1 f8             	sar    %rax
   43ee8:	48 89 c1             	mov    %rax,%rcx
   43eeb:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   43ef2:	66 66 66 
   43ef5:	48 89 c8             	mov    %rcx,%rax
   43ef8:	48 f7 ea             	imul   %rdx
   43efb:	48 c1 fa 05          	sar    $0x5,%rdx
   43eff:	48 89 c8             	mov    %rcx,%rax
   43f02:	48 c1 f8 3f          	sar    $0x3f,%rax
   43f06:	48 29 c2             	sub    %rax,%rdx
   43f09:	48 89 d0             	mov    %rdx,%rax
   43f0c:	48 c1 e0 02          	shl    $0x2,%rax
   43f10:	48 01 d0             	add    %rdx,%rax
   43f13:	48 c1 e0 04          	shl    $0x4,%rax
   43f17:	48 29 c1             	sub    %rax,%rcx
   43f1a:	48 89 ca             	mov    %rcx,%rdx
   43f1d:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   43f20:	eb 25                	jmp    43f47 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
   43f22:	8b 45 e0             	mov    -0x20(%rbp),%eax
   43f25:	83 c8 20             	or     $0x20,%eax
   43f28:	89 c6                	mov    %eax,%esi
   43f2a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43f2e:	48 8b 40 08          	mov    0x8(%rax),%rax
   43f32:	48 8d 48 02          	lea    0x2(%rax),%rcx
   43f36:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   43f3a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43f3e:	89 f2                	mov    %esi,%edx
   43f40:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   43f43:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   43f47:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   43f4b:	75 d5                	jne    43f22 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   43f4d:	eb 24                	jmp    43f73 <console_putc+0xdc>
        *cp->cursor++ = c | color;
   43f4f:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
   43f53:	8b 55 e0             	mov    -0x20(%rbp),%edx
   43f56:	09 d0                	or     %edx,%eax
   43f58:	89 c6                	mov    %eax,%esi
   43f5a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43f5e:	48 8b 40 08          	mov    0x8(%rax),%rax
   43f62:	48 8d 48 02          	lea    0x2(%rax),%rcx
   43f66:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   43f6a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43f6e:	89 f2                	mov    %esi,%edx
   43f70:	66 89 10             	mov    %dx,(%rax)
}
   43f73:	90                   	nop
   43f74:	c9                   	leave  
   43f75:	c3                   	ret    

0000000000043f76 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   43f76:	55                   	push   %rbp
   43f77:	48 89 e5             	mov    %rsp,%rbp
   43f7a:	48 83 ec 30          	sub    $0x30,%rsp
   43f7e:	89 7d ec             	mov    %edi,-0x14(%rbp)
   43f81:	89 75 e8             	mov    %esi,-0x18(%rbp)
   43f84:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   43f88:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   43f8c:	48 c7 45 f0 97 3e 04 	movq   $0x43e97,-0x10(%rbp)
   43f93:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   43f94:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   43f98:	78 09                	js     43fa3 <console_vprintf+0x2d>
   43f9a:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   43fa1:	7e 07                	jle    43faa <console_vprintf+0x34>
        cpos = 0;
   43fa3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   43faa:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43fad:	48 98                	cltq   
   43faf:	48 01 c0             	add    %rax,%rax
   43fb2:	48 05 00 80 0b 00    	add    $0xb8000,%rax
   43fb8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   43fbc:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   43fc0:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43fc4:	8b 75 e8             	mov    -0x18(%rbp),%esi
   43fc7:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   43fcb:	48 89 c7             	mov    %rax,%rdi
   43fce:	e8 f4 f4 ff ff       	call   434c7 <printer_vprintf>
    return cp.cursor - console;
   43fd3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43fd7:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   43fdd:	48 d1 f8             	sar    %rax
}
   43fe0:	c9                   	leave  
   43fe1:	c3                   	ret    

0000000000043fe2 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   43fe2:	55                   	push   %rbp
   43fe3:	48 89 e5             	mov    %rsp,%rbp
   43fe6:	48 83 ec 60          	sub    $0x60,%rsp
   43fea:	89 7d ac             	mov    %edi,-0x54(%rbp)
   43fed:	89 75 a8             	mov    %esi,-0x58(%rbp)
   43ff0:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   43ff4:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   43ff8:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   43ffc:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44000:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   44007:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4400b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   4400f:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44013:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   44017:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   4401b:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   4401f:	8b 75 a8             	mov    -0x58(%rbp),%esi
   44022:	8b 45 ac             	mov    -0x54(%rbp),%eax
   44025:	89 c7                	mov    %eax,%edi
   44027:	e8 4a ff ff ff       	call   43f76 <console_vprintf>
   4402c:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   4402f:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   44032:	c9                   	leave  
   44033:	c3                   	ret    

0000000000044034 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   44034:	55                   	push   %rbp
   44035:	48 89 e5             	mov    %rsp,%rbp
   44038:	48 83 ec 20          	sub    $0x20,%rsp
   4403c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44040:	89 f0                	mov    %esi,%eax
   44042:	89 55 e0             	mov    %edx,-0x20(%rbp)
   44045:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   44048:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4404c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   44050:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44054:	48 8b 50 08          	mov    0x8(%rax),%rdx
   44058:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4405c:	48 8b 40 10          	mov    0x10(%rax),%rax
   44060:	48 39 c2             	cmp    %rax,%rdx
   44063:	73 1a                	jae    4407f <string_putc+0x4b>
        *sp->s++ = c;
   44065:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44069:	48 8b 40 08          	mov    0x8(%rax),%rax
   4406d:	48 8d 48 01          	lea    0x1(%rax),%rcx
   44071:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   44075:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44079:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   4407d:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   4407f:	90                   	nop
   44080:	c9                   	leave  
   44081:	c3                   	ret    

0000000000044082 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   44082:	55                   	push   %rbp
   44083:	48 89 e5             	mov    %rsp,%rbp
   44086:	48 83 ec 40          	sub    $0x40,%rsp
   4408a:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   4408e:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   44092:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   44096:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   4409a:	48 c7 45 e8 34 40 04 	movq   $0x44034,-0x18(%rbp)
   440a1:	00 
    sp.s = s;
   440a2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   440a6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   440aa:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   440af:	74 33                	je     440e4 <vsnprintf+0x62>
        sp.end = s + size - 1;
   440b1:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   440b5:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   440b9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   440bd:	48 01 d0             	add    %rdx,%rax
   440c0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   440c4:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   440c8:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   440cc:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   440d0:	be 00 00 00 00       	mov    $0x0,%esi
   440d5:	48 89 c7             	mov    %rax,%rdi
   440d8:	e8 ea f3 ff ff       	call   434c7 <printer_vprintf>
        *sp.s = 0;
   440dd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   440e1:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   440e4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   440e8:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   440ec:	c9                   	leave  
   440ed:	c3                   	ret    

00000000000440ee <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   440ee:	55                   	push   %rbp
   440ef:	48 89 e5             	mov    %rsp,%rbp
   440f2:	48 83 ec 70          	sub    $0x70,%rsp
   440f6:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   440fa:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   440fe:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   44102:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44106:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4410a:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   4410e:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   44115:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44119:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   4411d:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44121:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   44125:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   44129:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   4412d:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   44131:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44135:	48 89 c7             	mov    %rax,%rdi
   44138:	e8 45 ff ff ff       	call   44082 <vsnprintf>
   4413d:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   44140:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   44143:	c9                   	leave  
   44144:	c3                   	ret    

0000000000044145 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   44145:	55                   	push   %rbp
   44146:	48 89 e5             	mov    %rsp,%rbp
   44149:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   4414d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   44154:	eb 13                	jmp    44169 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
   44156:	8b 45 fc             	mov    -0x4(%rbp),%eax
   44159:	48 98                	cltq   
   4415b:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
   44162:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44165:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44169:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   44170:	7e e4                	jle    44156 <console_clear+0x11>
    }
    cursorpos = 0;
   44172:	c7 05 80 4e 07 00 00 	movl   $0x0,0x74e80(%rip)        # b8ffc <cursorpos>
   44179:	00 00 00 
}
   4417c:	90                   	nop
   4417d:	c9                   	leave  
   4417e:	c3                   	ret    
