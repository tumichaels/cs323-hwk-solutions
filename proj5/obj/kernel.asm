
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
   400be:	e8 a3 05 00 00       	call   40666 <exception>

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
   40173:	e8 b5 12 00 00       	call   4142d <hardware_init>
    pageinfo_init();
   40178:	e8 14 09 00 00       	call   40a91 <pageinfo_init>
    console_clear();
   4017d:	e8 67 3c 00 00       	call   43de9 <console_clear>
    timer_init(HZ);
   40182:	bf 64 00 00 00       	mov    $0x64,%edi
   40187:	e8 8d 17 00 00       	call   41919 <timer_init>

    // use virtual_memory_map to remove user permissions for kernel memory
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   4018c:	48 8b 05 6d 3e 01 00 	mov    0x13e6d(%rip),%rax        # 54000 <kernel_pagetable>
   40193:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   40199:	b9 00 00 10 00       	mov    $0x100000,%ecx
   4019e:	ba 00 00 00 00       	mov    $0x0,%edx
   401a3:	be 00 00 00 00       	mov    $0x0,%esi
   401a8:	48 89 c7             	mov    %rax,%rdi
   401ab:	e8 c7 24 00 00       	call   42677 <virtual_memory_map>
					   PROC_START_ADDR, PTE_P | PTE_W);
   
    // return user permissions to console
    virtual_memory_map(kernel_pagetable, (uintptr_t) CONSOLE_ADDR, (uintptr_t) CONSOLE_ADDR,
   401b0:	ba 00 80 0b 00       	mov    $0xb8000,%edx
   401b5:	be 00 80 0b 00       	mov    $0xb8000,%esi
   401ba:	48 8b 05 3f 3e 01 00 	mov    0x13e3f(%rip),%rax        # 54000 <kernel_pagetable>
   401c1:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   401c7:	b9 00 10 00 00       	mov    $0x1000,%ecx
   401cc:	48 89 c7             	mov    %rax,%rdi
   401cf:	e8 a3 24 00 00       	call   42677 <virtual_memory_map>
	// to all memory before the start of ANY processes. This means that 
	// the assign_page function is never capable of assigning this memory
	// to a process.

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   401d4:	ba 00 0e 00 00       	mov    $0xe00,%edx
   401d9:	be 00 00 00 00       	mov    $0x0,%esi
   401de:	bf 20 10 05 00       	mov    $0x51020,%edi
   401e3:	e8 e7 2c 00 00       	call   42ecf <memset>
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
   40246:	be 40 3e 04 00       	mov    $0x43e40,%esi
   4024b:	48 89 c7             	mov    %rax,%rdi
   4024e:	e8 75 2d 00 00       	call   42fc8 <strcmp>
   40253:	85 c0                	test   %eax,%eax
   40255:	75 14                	jne    4026b <kernel+0x104>
        process_setup(1, 4);
   40257:	be 04 00 00 00       	mov    $0x4,%esi
   4025c:	bf 01 00 00 00       	mov    $0x1,%edi
   40261:	e8 d1 00 00 00       	call   40337 <process_setup>
   40266:	e9 c2 00 00 00       	jmp    4032d <kernel+0x1c6>
    } else if (command && strcmp(command, "forkexit") == 0) {
   4026b:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40270:	74 29                	je     4029b <kernel+0x134>
   40272:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40276:	be 45 3e 04 00       	mov    $0x43e45,%esi
   4027b:	48 89 c7             	mov    %rax,%rdi
   4027e:	e8 45 2d 00 00       	call   42fc8 <strcmp>
   40283:	85 c0                	test   %eax,%eax
   40285:	75 14                	jne    4029b <kernel+0x134>
        process_setup(1, 5);
   40287:	be 05 00 00 00       	mov    $0x5,%esi
   4028c:	bf 01 00 00 00       	mov    $0x1,%edi
   40291:	e8 a1 00 00 00       	call   40337 <process_setup>
   40296:	e9 92 00 00 00       	jmp    4032d <kernel+0x1c6>
    } else if (command && strcmp(command, "test") == 0) {
   4029b:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   402a0:	74 26                	je     402c8 <kernel+0x161>
   402a2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   402a6:	be 4e 3e 04 00       	mov    $0x43e4e,%esi
   402ab:	48 89 c7             	mov    %rax,%rdi
   402ae:	e8 15 2d 00 00       	call   42fc8 <strcmp>
   402b3:	85 c0                	test   %eax,%eax
   402b5:	75 11                	jne    402c8 <kernel+0x161>
        process_setup(1, 6);
   402b7:	be 06 00 00 00       	mov    $0x6,%esi
   402bc:	bf 01 00 00 00       	mov    $0x1,%edi
   402c1:	e8 71 00 00 00       	call   40337 <process_setup>
   402c6:	eb 65                	jmp    4032d <kernel+0x1c6>
    } else if (command && strcmp(command, "test2") == 0) {
   402c8:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   402cd:	74 39                	je     40308 <kernel+0x1a1>
   402cf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   402d3:	be 53 3e 04 00       	mov    $0x43e53,%esi
   402d8:	48 89 c7             	mov    %rax,%rdi
   402db:	e8 e8 2c 00 00       	call   42fc8 <strcmp>
   402e0:	85 c0                	test   %eax,%eax
   402e2:	75 24                	jne    40308 <kernel+0x1a1>
        for (pid_t i = 1; i <= 2; ++i) {
   402e4:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   402eb:	eb 13                	jmp    40300 <kernel+0x199>
            process_setup(i, 6);
   402ed:	8b 45 f8             	mov    -0x8(%rbp),%eax
   402f0:	be 06 00 00 00       	mov    $0x6,%esi
   402f5:	89 c7                	mov    %eax,%edi
   402f7:	e8 3b 00 00 00       	call   40337 <process_setup>
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
   4031e:	e8 14 00 00 00       	call   40337 <process_setup>
        for (pid_t i = 1; i <= 4; ++i) {
   40323:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   40327:	83 7d f4 04          	cmpl   $0x4,-0xc(%rbp)
   4032b:	7e e4                	jle    40311 <kernel+0x1aa>
        }
    }


    // Switch to the first process using run()
    run(&processes[1]);
   4032d:	bf 00 11 05 00       	mov    $0x51100,%edi
   40332:	e8 fd 06 00 00       	call   40a34 <run>

0000000000040337 <process_setup>:
// process_setup(pid, program_number)
//    Load application program `program_number` as process number `pid`.
//    This loads the application's code and data into memory, sets its
//    %rip and %rsp, gives it a stack page, and marks it as runnable.

void process_setup(pid_t pid, int program_number) {
   40337:	55                   	push   %rbp
   40338:	48 89 e5             	mov    %rsp,%rbp
   4033b:	48 83 ec 20          	sub    $0x20,%rsp
   4033f:	89 7d ec             	mov    %edi,-0x14(%rbp)
   40342:	89 75 e8             	mov    %esi,-0x18(%rbp)
    process_init(&processes[pid], 0);
   40345:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40348:	48 63 d0             	movslq %eax,%rdx
   4034b:	48 89 d0             	mov    %rdx,%rax
   4034e:	48 c1 e0 03          	shl    $0x3,%rax
   40352:	48 29 d0             	sub    %rdx,%rax
   40355:	48 c1 e0 05          	shl    $0x5,%rax
   40359:	48 05 20 10 05 00    	add    $0x51020,%rax
   4035f:	be 00 00 00 00       	mov    $0x0,%esi
   40364:	48 89 c7             	mov    %rax,%rdi
   40367:	e8 3e 18 00 00       	call   41baa <process_init>
    processes[pid].p_pagetable = kernel_pagetable;
   4036c:	48 8b 0d 8d 3c 01 00 	mov    0x13c8d(%rip),%rcx        # 54000 <kernel_pagetable>
   40373:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40376:	48 63 d0             	movslq %eax,%rdx
   40379:	48 89 d0             	mov    %rdx,%rax
   4037c:	48 c1 e0 03          	shl    $0x3,%rax
   40380:	48 29 d0             	sub    %rdx,%rax
   40383:	48 c1 e0 05          	shl    $0x5,%rax
   40387:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   4038d:	48 89 08             	mov    %rcx,(%rax)
    ++pageinfo[PAGENUMBER(kernel_pagetable)].refcount; //increase refcount since kernel_pagetable was used
   40390:	48 8b 05 69 3c 01 00 	mov    0x13c69(%rip),%rax        # 54000 <kernel_pagetable>
   40397:	48 c1 e8 0c          	shr    $0xc,%rax
   4039b:	89 c2                	mov    %eax,%edx
   4039d:	48 63 c2             	movslq %edx,%rax
   403a0:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   403a7:	00 
   403a8:	83 c0 01             	add    $0x1,%eax
   403ab:	89 c1                	mov    %eax,%ecx
   403ad:	48 63 c2             	movslq %edx,%rax
   403b0:	88 8c 00 41 1e 05 00 	mov    %cl,0x51e41(%rax,%rax,1)

    int r = program_load(&processes[pid], program_number, NULL);
   403b7:	8b 45 ec             	mov    -0x14(%rbp),%eax
   403ba:	48 63 d0             	movslq %eax,%rdx
   403bd:	48 89 d0             	mov    %rdx,%rax
   403c0:	48 c1 e0 03          	shl    $0x3,%rax
   403c4:	48 29 d0             	sub    %rdx,%rax
   403c7:	48 c1 e0 05          	shl    $0x5,%rax
   403cb:	48 8d 88 20 10 05 00 	lea    0x51020(%rax),%rcx
   403d2:	8b 45 e8             	mov    -0x18(%rbp),%eax
   403d5:	ba 00 00 00 00       	mov    $0x0,%edx
   403da:	89 c6                	mov    %eax,%esi
   403dc:	48 89 cf             	mov    %rcx,%rdi
   403df:	e8 50 27 00 00       	call   42b34 <program_load>
   403e4:	89 45 fc             	mov    %eax,-0x4(%rbp)
    assert(r >= 0);
   403e7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   403eb:	79 14                	jns    40401 <process_setup+0xca>
   403ed:	ba 59 3e 04 00       	mov    $0x43e59,%edx
   403f2:	be 8f 00 00 00       	mov    $0x8f,%esi
   403f7:	bf 60 3e 04 00       	mov    $0x43e60,%edi
   403fc:	e8 77 1f 00 00       	call   42378 <assert_fail>

    processes[pid].p_registers.reg_rsp = PROC_START_ADDR + PROC_SIZE * pid;
   40401:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40404:	83 c0 04             	add    $0x4,%eax
   40407:	c1 e0 12             	shl    $0x12,%eax
   4040a:	48 63 c8             	movslq %eax,%rcx
   4040d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40410:	48 63 d0             	movslq %eax,%rdx
   40413:	48 89 d0             	mov    %rdx,%rax
   40416:	48 c1 e0 03          	shl    $0x3,%rax
   4041a:	48 29 d0             	sub    %rdx,%rax
   4041d:	48 c1 e0 05          	shl    $0x5,%rax
   40421:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   40427:	48 89 08             	mov    %rcx,(%rax)
    uintptr_t stack_page = processes[pid].p_registers.reg_rsp - PAGESIZE;
   4042a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4042d:	48 63 d0             	movslq %eax,%rdx
   40430:	48 89 d0             	mov    %rdx,%rax
   40433:	48 c1 e0 03          	shl    $0x3,%rax
   40437:	48 29 d0             	sub    %rdx,%rax
   4043a:	48 c1 e0 05          	shl    $0x5,%rax
   4043e:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   40444:	48 8b 00             	mov    (%rax),%rax
   40447:	48 2d 00 10 00 00    	sub    $0x1000,%rax
   4044d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assign_physical_page(stack_page, pid);
   40451:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40454:	0f be d0             	movsbl %al,%edx
   40457:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4045b:	89 d6                	mov    %edx,%esi
   4045d:	48 89 c7             	mov    %rax,%rdi
   40460:	e8 5b 00 00 00       	call   404c0 <assign_physical_page>
    virtual_memory_map(processes[pid].p_pagetable, stack_page, stack_page,
   40465:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40468:	48 63 d0             	movslq %eax,%rdx
   4046b:	48 89 d0             	mov    %rdx,%rax
   4046e:	48 c1 e0 03          	shl    $0x3,%rax
   40472:	48 29 d0             	sub    %rdx,%rax
   40475:	48 c1 e0 05          	shl    $0x5,%rax
   40479:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   4047f:	48 8b 00             	mov    (%rax),%rax
   40482:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40486:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   4048a:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40490:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40495:	48 89 c7             	mov    %rax,%rdi
   40498:	e8 da 21 00 00       	call   42677 <virtual_memory_map>
                       PAGESIZE, PTE_P | PTE_W | PTE_U);
    processes[pid].p_state = P_RUNNABLE;
   4049d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   404a0:	48 63 d0             	movslq %eax,%rdx
   404a3:	48 89 d0             	mov    %rdx,%rax
   404a6:	48 c1 e0 03          	shl    $0x3,%rax
   404aa:	48 29 d0             	sub    %rdx,%rax
   404ad:	48 c1 e0 05          	shl    $0x5,%rax
   404b1:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   404b7:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
}
   404bd:	90                   	nop
   404be:	c9                   	leave  
   404bf:	c3                   	ret    

00000000000404c0 <assign_physical_page>:
// assign_physical_page(addr, owner)
//    Allocates the page with physical address `addr` to the given owner.
//    Fails if physical page `addr` was already allocated. Returns 0 on
//    success and -1 on failure. Used by the program loader.

int assign_physical_page(uintptr_t addr, int8_t owner) {
   404c0:	55                   	push   %rbp
   404c1:	48 89 e5             	mov    %rsp,%rbp
   404c4:	48 83 ec 10          	sub    $0x10,%rsp
   404c8:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   404cc:	89 f0                	mov    %esi,%eax
   404ce:	88 45 f4             	mov    %al,-0xc(%rbp)
    if ((addr & 0xFFF) != 0								 // this check is that the permission bits are 0
   404d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   404d5:	25 ff 0f 00 00       	and    $0xfff,%eax
   404da:	48 85 c0             	test   %rax,%rax
   404dd:	75 20                	jne    404ff <assign_physical_page+0x3f>
        || addr >= MEMSIZE_PHYSICAL
   404df:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   404e6:	00 
   404e7:	77 16                	ja     404ff <assign_physical_page+0x3f>
        || pageinfo[PAGENUMBER(addr)].refcount != 0) {
   404e9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   404ed:	48 c1 e8 0c          	shr    $0xc,%rax
   404f1:	48 98                	cltq   
   404f3:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   404fa:	00 
   404fb:	84 c0                	test   %al,%al
   404fd:	74 07                	je     40506 <assign_physical_page+0x46>
        return -1;
   404ff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40504:	eb 2c                	jmp    40532 <assign_physical_page+0x72>
    } else {
        pageinfo[PAGENUMBER(addr)].refcount = 1;
   40506:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4050a:	48 c1 e8 0c          	shr    $0xc,%rax
   4050e:	48 98                	cltq   
   40510:	c6 84 00 41 1e 05 00 	movb   $0x1,0x51e41(%rax,%rax,1)
   40517:	01 
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40518:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4051c:	48 c1 e8 0c          	shr    $0xc,%rax
   40520:	48 98                	cltq   
   40522:	0f b6 55 f4          	movzbl -0xc(%rbp),%edx
   40526:	88 94 00 40 1e 05 00 	mov    %dl,0x51e40(%rax,%rax,1)
        return 0;
   4052d:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   40532:	c9                   	leave  
   40533:	c3                   	ret    

0000000000040534 <syscall_mapping>:

void syscall_mapping(proc* p){
   40534:	55                   	push   %rbp
   40535:	48 89 e5             	mov    %rsp,%rbp
   40538:	48 83 ec 70          	sub    $0x70,%rsp
   4053c:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)

    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
   40540:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40544:	48 8b 40 38          	mov    0x38(%rax),%rax
   40548:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t ptr = p->p_registers.reg_rsi;
   4054c:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40550:	48 8b 40 30          	mov    0x30(%rax),%rax
   40554:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    //convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);
   40558:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4055c:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40563:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   40567:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4056b:	48 89 ce             	mov    %rcx,%rsi
   4056e:	48 89 c7             	mov    %rax,%rdi
   40571:	e8 c7 24 00 00       	call   42a3d <virtual_memory_lookup>

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
   40576:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40579:	48 98                	cltq   
   4057b:	83 e0 06             	and    $0x6,%eax
   4057e:	48 83 f8 06          	cmp    $0x6,%rax
   40582:	75 73                	jne    405f7 <syscall_mapping+0xc3>
	return;
    uintptr_t endaddr = map.pa + sizeof(vamapping) - 1;
   40584:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40588:	48 83 c0 17          	add    $0x17,%rax
   4058c:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    // check for write access for end address
    vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
   40590:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40594:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   4059b:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   4059f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   405a3:	48 89 ce             	mov    %rcx,%rsi
   405a6:	48 89 c7             	mov    %rax,%rdi
   405a9:	e8 8f 24 00 00       	call   42a3d <virtual_memory_lookup>
    if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
   405ae:	8b 45 c8             	mov    -0x38(%rbp),%eax
   405b1:	48 98                	cltq   
   405b3:	83 e0 03             	and    $0x3,%eax
   405b6:	48 83 f8 03          	cmp    $0x3,%rax
   405ba:	75 3e                	jne    405fa <syscall_mapping+0xc6>
	return;
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
   405bc:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   405c0:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   405c7:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   405cb:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   405cf:	48 89 ce             	mov    %rcx,%rsi
   405d2:	48 89 c7             	mov    %rax,%rdi
   405d5:	e8 63 24 00 00       	call   42a3d <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   405da:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   405de:	48 89 c1             	mov    %rax,%rcx
   405e1:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   405e5:	ba 18 00 00 00       	mov    $0x18,%edx
   405ea:	48 89 c6             	mov    %rax,%rsi
   405ed:	48 89 cf             	mov    %rcx,%rdi
   405f0:	e8 dc 27 00 00       	call   42dd1 <memcpy>
   405f5:	eb 04                	jmp    405fb <syscall_mapping+0xc7>
	return;
   405f7:	90                   	nop
   405f8:	eb 01                	jmp    405fb <syscall_mapping+0xc7>
	return;
   405fa:	90                   	nop
}
   405fb:	c9                   	leave  
   405fc:	c3                   	ret    

00000000000405fd <syscall_mem_tog>:

void syscall_mem_tog(proc* process){
   405fd:	55                   	push   %rbp
   405fe:	48 89 e5             	mov    %rsp,%rbp
   40601:	48 83 ec 18          	sub    $0x18,%rsp
   40605:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)

    pid_t p = process->p_registers.reg_rdi;
   40609:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4060d:	48 8b 40 38          	mov    0x38(%rax),%rax
   40611:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(p == 0) {
   40614:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   40618:	75 14                	jne    4062e <syscall_mem_tog+0x31>
        disp_global = !disp_global;
   4061a:	0f b6 05 df 49 00 00 	movzbl 0x49df(%rip),%eax        # 45000 <disp_global>
   40621:	84 c0                	test   %al,%al
   40623:	0f 94 c0             	sete   %al
   40626:	88 05 d4 49 00 00    	mov    %al,0x49d4(%rip)        # 45000 <disp_global>
   4062c:	eb 36                	jmp    40664 <syscall_mem_tog+0x67>
    }
    else {
        if(p < 0 || p > NPROC || p != process->p_pid)
   4062e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   40632:	78 2f                	js     40663 <syscall_mem_tog+0x66>
   40634:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   40638:	7f 29                	jg     40663 <syscall_mem_tog+0x66>
   4063a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4063e:	8b 00                	mov    (%rax),%eax
   40640:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   40643:	75 1e                	jne    40663 <syscall_mem_tog+0x66>
            return;
        process->display_status = !(process->display_status);
   40645:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40649:	0f b6 80 d8 00 00 00 	movzbl 0xd8(%rax),%eax
   40650:	84 c0                	test   %al,%al
   40652:	0f 94 c0             	sete   %al
   40655:	89 c2                	mov    %eax,%edx
   40657:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4065b:	88 90 d8 00 00 00    	mov    %dl,0xd8(%rax)
   40661:	eb 01                	jmp    40664 <syscall_mem_tog+0x67>
            return;
   40663:	90                   	nop
    }
}
   40664:	c9                   	leave  
   40665:	c3                   	ret    

0000000000040666 <exception>:
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_64_registers* reg) {
   40666:	55                   	push   %rbp
   40667:	48 89 e5             	mov    %rsp,%rbp
   4066a:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
   40671:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   40678:	48 8b 05 81 09 01 00 	mov    0x10981(%rip),%rax        # 51000 <current>
   4067f:	48 8b 95 08 ff ff ff 	mov    -0xf8(%rbp),%rdx
   40686:	48 83 c0 08          	add    $0x8,%rax
   4068a:	48 89 d6             	mov    %rdx,%rsi
   4068d:	ba 18 00 00 00       	mov    $0x18,%edx
   40692:	48 89 c7             	mov    %rax,%rdi
   40695:	48 89 d1             	mov    %rdx,%rcx
   40698:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   4069b:	48 8b 05 5e 39 01 00 	mov    0x1395e(%rip),%rax        # 54000 <kernel_pagetable>
   406a2:	48 89 c7             	mov    %rax,%rdi
   406a5:	e8 9c 1e 00 00       	call   42546 <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   406aa:	8b 05 4c 89 07 00    	mov    0x7894c(%rip),%eax        # b8ffc <cursorpos>
   406b0:	89 c7                	mov    %eax,%edi
   406b2:	e8 bd 15 00 00       	call   41c74 <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT && reg->reg_intno != INT_GPF) // no error due to pagefault or general fault
   406b7:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   406be:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   406c5:	48 83 f8 0e          	cmp    $0xe,%rax
   406c9:	74 14                	je     406df <exception+0x79>
   406cb:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   406d2:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   406d9:	48 83 f8 0d          	cmp    $0xd,%rax
   406dd:	75 16                	jne    406f5 <exception+0x8f>
            || (reg->reg_err & PFERR_USER)) // pagefault error in user mode 
   406df:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   406e6:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   406ed:	83 e0 04             	and    $0x4,%eax
   406f0:	48 85 c0             	test   %rax,%rax
   406f3:	74 1a                	je     4070f <exception+0xa9>
    {
        check_virtual_memory();
   406f5:	e8 2e 07 00 00       	call   40e28 <check_virtual_memory>
        if(disp_global){
   406fa:	0f b6 05 ff 48 00 00 	movzbl 0x48ff(%rip),%eax        # 45000 <disp_global>
   40701:	84 c0                	test   %al,%al
   40703:	74 0a                	je     4070f <exception+0xa9>
            memshow_physical();
   40705:	e8 96 08 00 00       	call   40fa0 <memshow_physical>
            memshow_virtual_animate();
   4070a:	e8 c0 0b 00 00       	call   412cf <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   4070f:	e8 43 1a 00 00       	call   42157 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   40714:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   4071b:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40722:	48 83 e8 0e          	sub    $0xe,%rax
   40726:	48 83 f8 2a          	cmp    $0x2a,%rax
   4072a:	0f 87 55 02 00 00    	ja     40985 <exception+0x31f>
   40730:	48 8b 04 c5 00 3f 04 	mov    0x43f00(,%rax,8),%rax
   40737:	00 
   40738:	ff e0                	jmp    *%rax

    case INT_SYS_PANIC:
	    // rdi stores pointer for msg string
	    {
		char msg[160];
		uintptr_t addr = current->p_registers.reg_rdi;
   4073a:	48 8b 05 bf 08 01 00 	mov    0x108bf(%rip),%rax        # 51000 <current>
   40741:	48 8b 40 38          	mov    0x38(%rax),%rax
   40745:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
		if((void *)addr == NULL)
   40749:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4074e:	75 0f                	jne    4075f <exception+0xf9>
		    panic(NULL);
   40750:	bf 00 00 00 00       	mov    $0x0,%edi
   40755:	b8 00 00 00 00       	mov    $0x0,%eax
   4075a:	e8 39 1b 00 00       	call   42298 <panic>
		vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   4075f:	48 8b 05 9a 08 01 00 	mov    0x1089a(%rip),%rax        # 51000 <current>
   40766:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   4076d:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   40771:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   40775:	48 89 ce             	mov    %rcx,%rsi
   40778:	48 89 c7             	mov    %rax,%rdi
   4077b:	e8 bd 22 00 00       	call   42a3d <virtual_memory_lookup>
		memcpy(msg, (void *)map.pa, 160);
   40780:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40784:	48 89 c1             	mov    %rax,%rcx
   40787:	48 8d 85 10 ff ff ff 	lea    -0xf0(%rbp),%rax
   4078e:	ba a0 00 00 00       	mov    $0xa0,%edx
   40793:	48 89 ce             	mov    %rcx,%rsi
   40796:	48 89 c7             	mov    %rax,%rdi
   40799:	e8 33 26 00 00       	call   42dd1 <memcpy>
		panic(msg);
   4079e:	48 8d 85 10 ff ff ff 	lea    -0xf0(%rbp),%rax
   407a5:	48 89 c7             	mov    %rax,%rdi
   407a8:	b8 00 00 00 00       	mov    $0x0,%eax
   407ad:	e8 e6 1a 00 00       	call   42298 <panic>
	    }
	    panic(NULL);
	    break;                  // will not be reached

    case INT_SYS_GETPID:
        current->p_registers.reg_rax = current->p_pid;
   407b2:	48 8b 05 47 08 01 00 	mov    0x10847(%rip),%rax        # 51000 <current>
   407b9:	8b 10                	mov    (%rax),%edx
   407bb:	48 8b 05 3e 08 01 00 	mov    0x1083e(%rip),%rax        # 51000 <current>
   407c2:	48 63 d2             	movslq %edx,%rdx
   407c5:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   407c9:	e9 c7 01 00 00       	jmp    40995 <exception+0x32f>

    case INT_SYS_YIELD:
        schedule();
   407ce:	e8 eb 01 00 00       	call   409be <schedule>
        break;                  /* will not be reached */
   407d3:	e9 bd 01 00 00       	jmp    40995 <exception+0x32f>

    case INT_SYS_PAGE_ALLOC: {
        uintptr_t addr = current->p_registers.reg_rdi;
   407d8:	48 8b 05 21 08 01 00 	mov    0x10821(%rip),%rax        # 51000 <current>
   407df:	48 8b 40 38          	mov    0x38(%rax),%rax
   407e3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
		// changes the owner of addr to the given process,
		// i'm still unsure what the security risk is?
        int r = assign_physical_page(addr, current->p_pid); 
   407e7:	48 8b 05 12 08 01 00 	mov    0x10812(%rip),%rax        # 51000 <current>
   407ee:	8b 00                	mov    (%rax),%eax
   407f0:	0f be d0             	movsbl %al,%edx
   407f3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   407f7:	89 d6                	mov    %edx,%esi
   407f9:	48 89 c7             	mov    %rax,%rdi
   407fc:	e8 bf fc ff ff       	call   404c0 <assign_physical_page>
   40801:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (r >= 0) {
   40804:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40808:	78 29                	js     40833 <exception+0x1cd>
            virtual_memory_map(current->p_pagetable, addr, addr,
   4080a:	48 8b 05 ef 07 01 00 	mov    0x107ef(%rip),%rax        # 51000 <current>
   40811:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40818:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4081c:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   40820:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40826:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4082b:	48 89 c7             	mov    %rax,%rdi
   4082e:	e8 44 1e 00 00       	call   42677 <virtual_memory_map>
                               PAGESIZE, PTE_P | PTE_W | PTE_U);
        }
        current->p_registers.reg_rax = r;
   40833:	48 8b 05 c6 07 01 00 	mov    0x107c6(%rip),%rax        # 51000 <current>
   4083a:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4083d:	48 63 d2             	movslq %edx,%rdx
   40840:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   40844:	e9 4c 01 00 00       	jmp    40995 <exception+0x32f>
    }

    case INT_SYS_MAPPING:
    {
	    syscall_mapping(current);
   40849:	48 8b 05 b0 07 01 00 	mov    0x107b0(%rip),%rax        # 51000 <current>
   40850:	48 89 c7             	mov    %rax,%rdi
   40853:	e8 dc fc ff ff       	call   40534 <syscall_mapping>
            break;
   40858:	e9 38 01 00 00       	jmp    40995 <exception+0x32f>
    }

    case INT_SYS_MEM_TOG:
	{
	    syscall_mem_tog(current);
   4085d:	48 8b 05 9c 07 01 00 	mov    0x1079c(%rip),%rax        # 51000 <current>
   40864:	48 89 c7             	mov    %rax,%rdi
   40867:	e8 91 fd ff ff       	call   405fd <syscall_mem_tog>
	    break;
   4086c:	e9 24 01 00 00       	jmp    40995 <exception+0x32f>
	}

    case INT_TIMER:
        ++ticks;
   40871:	8b 05 a9 15 01 00    	mov    0x115a9(%rip),%eax        # 51e20 <ticks>
   40877:	83 c0 01             	add    $0x1,%eax
   4087a:	89 05 a0 15 01 00    	mov    %eax,0x115a0(%rip)        # 51e20 <ticks>
        schedule();
   40880:	e8 39 01 00 00       	call   409be <schedule>
        break;                  /* will not be reached */
   40885:	e9 0b 01 00 00       	jmp    40995 <exception+0x32f>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   4088a:	0f 20 d0             	mov    %cr2,%rax
   4088d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    return val;
   40891:	48 8b 45 c8          	mov    -0x38(%rbp),%rax

    case INT_PAGEFAULT: {
        // Analyze faulting address and access type.
        uintptr_t addr = rcr2();
   40895:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
        const char* operation = reg->reg_err & PFERR_WRITE
   40899:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   408a0:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   408a7:	83 e0 02             	and    $0x2,%eax
                ? "write" : "read";
   408aa:	48 85 c0             	test   %rax,%rax
   408ad:	74 07                	je     408b6 <exception+0x250>
   408af:	b8 70 3e 04 00       	mov    $0x43e70,%eax
   408b4:	eb 05                	jmp    408bb <exception+0x255>
   408b6:	b8 76 3e 04 00       	mov    $0x43e76,%eax
        const char* operation = reg->reg_err & PFERR_WRITE
   408bb:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        const char* problem = reg->reg_err & PFERR_PRESENT
   408bf:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   408c6:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   408cd:	83 e0 01             	and    $0x1,%eax
                ? "protection problem" : "missing page";
   408d0:	48 85 c0             	test   %rax,%rax
   408d3:	74 07                	je     408dc <exception+0x276>
   408d5:	b8 7b 3e 04 00       	mov    $0x43e7b,%eax
   408da:	eb 05                	jmp    408e1 <exception+0x27b>
   408dc:	b8 8e 3e 04 00       	mov    $0x43e8e,%eax
        const char* problem = reg->reg_err & PFERR_PRESENT
   408e1:	48 89 45 d0          	mov    %rax,-0x30(%rbp)

        if (!(reg->reg_err & PFERR_USER)) {
   408e5:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   408ec:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   408f3:	83 e0 04             	and    $0x4,%eax
   408f6:	48 85 c0             	test   %rax,%rax
   408f9:	75 2f                	jne    4092a <exception+0x2c4>
            panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   408fb:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40902:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   40909:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
   4090d:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   40911:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40915:	49 89 f0             	mov    %rsi,%r8
   40918:	48 89 c6             	mov    %rax,%rsi
   4091b:	bf a0 3e 04 00       	mov    $0x43ea0,%edi
   40920:	b8 00 00 00 00       	mov    $0x0,%eax
   40925:	e8 6e 19 00 00       	call   42298 <panic>
                  addr, operation, problem, reg->reg_rip);
        }
        console_printf(CPOS(24, 0), 0x0C00,
   4092a:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40931:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                       "Process %d page fault for %p (%s %s, rip=%p)!\n",
                       current->p_pid, addr, operation, problem, reg->reg_rip);
   40938:	48 8b 05 c1 06 01 00 	mov    0x106c1(%rip),%rax        # 51000 <current>
        console_printf(CPOS(24, 0), 0x0C00,
   4093f:	8b 00                	mov    (%rax),%eax
   40941:	48 8b 75 d8          	mov    -0x28(%rbp),%rsi
   40945:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   40949:	52                   	push   %rdx
   4094a:	ff 75 d0             	push   -0x30(%rbp)
   4094d:	49 89 f1             	mov    %rsi,%r9
   40950:	49 89 c8             	mov    %rcx,%r8
   40953:	89 c1                	mov    %eax,%ecx
   40955:	ba d0 3e 04 00       	mov    $0x43ed0,%edx
   4095a:	be 00 0c 00 00       	mov    $0xc00,%esi
   4095f:	bf 80 07 00 00       	mov    $0x780,%edi
   40964:	b8 00 00 00 00       	mov    $0x0,%eax
   40969:	e8 18 33 00 00       	call   43c86 <console_printf>
   4096e:	48 83 c4 10          	add    $0x10,%rsp
        current->p_state = P_BROKEN;
   40972:	48 8b 05 87 06 01 00 	mov    0x10687(%rip),%rax        # 51000 <current>
   40979:	c7 80 c8 00 00 00 03 	movl   $0x3,0xc8(%rax)
   40980:	00 00 00 
        break;
   40983:	eb 10                	jmp    40995 <exception+0x32f>
    }

    default:
        default_exception(current);
   40985:	48 8b 05 74 06 01 00 	mov    0x10674(%rip),%rax        # 51000 <current>
   4098c:	48 89 c7             	mov    %rax,%rdi
   4098f:	e8 14 1a 00 00       	call   423a8 <default_exception>
        break;                  /* will not be reached */
   40994:	90                   	nop

    }


    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   40995:	48 8b 05 64 06 01 00 	mov    0x10664(%rip),%rax        # 51000 <current>
   4099c:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   409a2:	83 f8 01             	cmp    $0x1,%eax
   409a5:	75 0f                	jne    409b6 <exception+0x350>
        run(current);
   409a7:	48 8b 05 52 06 01 00 	mov    0x10652(%rip),%rax        # 51000 <current>
   409ae:	48 89 c7             	mov    %rax,%rdi
   409b1:	e8 7e 00 00 00       	call   40a34 <run>
    } else {
        schedule();
   409b6:	e8 03 00 00 00       	call   409be <schedule>
    }
}
   409bb:	90                   	nop
   409bc:	c9                   	leave  
   409bd:	c3                   	ret    

00000000000409be <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   409be:	55                   	push   %rbp
   409bf:	48 89 e5             	mov    %rsp,%rbp
   409c2:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   409c6:	48 8b 05 33 06 01 00 	mov    0x10633(%rip),%rax        # 51000 <current>
   409cd:	8b 00                	mov    (%rax),%eax
   409cf:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   409d2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   409d5:	8d 50 01             	lea    0x1(%rax),%edx
   409d8:	89 d0                	mov    %edx,%eax
   409da:	c1 f8 1f             	sar    $0x1f,%eax
   409dd:	c1 e8 1c             	shr    $0x1c,%eax
   409e0:	01 c2                	add    %eax,%edx
   409e2:	83 e2 0f             	and    $0xf,%edx
   409e5:	29 c2                	sub    %eax,%edx
   409e7:	89 55 fc             	mov    %edx,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   409ea:	8b 45 fc             	mov    -0x4(%rbp),%eax
   409ed:	48 63 d0             	movslq %eax,%rdx
   409f0:	48 89 d0             	mov    %rdx,%rax
   409f3:	48 c1 e0 03          	shl    $0x3,%rax
   409f7:	48 29 d0             	sub    %rdx,%rax
   409fa:	48 c1 e0 05          	shl    $0x5,%rax
   409fe:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   40a04:	8b 00                	mov    (%rax),%eax
   40a06:	83 f8 01             	cmp    $0x1,%eax
   40a09:	75 22                	jne    40a2d <schedule+0x6f>
            run(&processes[pid]);
   40a0b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40a0e:	48 63 d0             	movslq %eax,%rdx
   40a11:	48 89 d0             	mov    %rdx,%rax
   40a14:	48 c1 e0 03          	shl    $0x3,%rax
   40a18:	48 29 d0             	sub    %rdx,%rax
   40a1b:	48 c1 e0 05          	shl    $0x5,%rax
   40a1f:	48 05 20 10 05 00    	add    $0x51020,%rax
   40a25:	48 89 c7             	mov    %rax,%rdi
   40a28:	e8 07 00 00 00       	call   40a34 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   40a2d:	e8 25 17 00 00       	call   42157 <check_keyboard>
        pid = (pid + 1) % NPROC;
   40a32:	eb 9e                	jmp    409d2 <schedule+0x14>

0000000000040a34 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   40a34:	55                   	push   %rbp
   40a35:	48 89 e5             	mov    %rsp,%rbp
   40a38:	48 83 ec 10          	sub    $0x10,%rsp
   40a3c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   40a40:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a44:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   40a4a:	83 f8 01             	cmp    $0x1,%eax
   40a4d:	74 14                	je     40a63 <run+0x2f>
   40a4f:	ba 58 40 04 00       	mov    $0x44058,%edx
   40a54:	be 66 01 00 00       	mov    $0x166,%esi
   40a59:	bf 60 3e 04 00       	mov    $0x43e60,%edi
   40a5e:	e8 15 19 00 00       	call   42378 <assert_fail>
    current = p;
   40a63:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a67:	48 89 05 92 05 01 00 	mov    %rax,0x10592(%rip)        # 51000 <current>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   40a6e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a72:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40a79:	48 89 c7             	mov    %rax,%rdi
   40a7c:	e8 c5 1a 00 00       	call   42546 <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   40a81:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a85:	48 83 c0 08          	add    $0x8,%rax
   40a89:	48 89 c7             	mov    %rax,%rdi
   40a8c:	e8 32 f6 ff ff       	call   400c3 <exception_return>

0000000000040a91 <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   40a91:	55                   	push   %rbp
   40a92:	48 89 e5             	mov    %rsp,%rbp
   40a95:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40a99:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40aa0:	00 
   40aa1:	e9 81 00 00 00       	jmp    40b27 <pageinfo_init+0x96>
        int owner;
        if (physical_memory_isreserved(addr)) {
   40aa6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40aaa:	48 89 c7             	mov    %rax,%rdi
   40aad:	e8 33 0f 00 00       	call   419e5 <physical_memory_isreserved>
   40ab2:	85 c0                	test   %eax,%eax
   40ab4:	74 09                	je     40abf <pageinfo_init+0x2e>
            owner = PO_RESERVED;
   40ab6:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   40abd:	eb 2f                	jmp    40aee <pageinfo_init+0x5d>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   40abf:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   40ac6:	00 
   40ac7:	76 0b                	jbe    40ad4 <pageinfo_init+0x43>
   40ac9:	b8 08 a0 05 00       	mov    $0x5a008,%eax
   40ace:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40ad2:	72 0a                	jb     40ade <pageinfo_init+0x4d>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   40ad4:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   40adb:	00 
   40adc:	75 09                	jne    40ae7 <pageinfo_init+0x56>
            owner = PO_KERNEL;
   40ade:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   40ae5:	eb 07                	jmp    40aee <pageinfo_init+0x5d>
        } else {
            owner = PO_FREE;
   40ae7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40aee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40af2:	48 c1 e8 0c          	shr    $0xc,%rax
   40af6:	89 c1                	mov    %eax,%ecx
   40af8:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40afb:	89 c2                	mov    %eax,%edx
   40afd:	48 63 c1             	movslq %ecx,%rax
   40b00:	88 94 00 40 1e 05 00 	mov    %dl,0x51e40(%rax,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   40b07:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40b0b:	0f 95 c2             	setne  %dl
   40b0e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40b12:	48 c1 e8 0c          	shr    $0xc,%rax
   40b16:	48 98                	cltq   
   40b18:	88 94 00 41 1e 05 00 	mov    %dl,0x51e41(%rax,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40b1f:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40b26:	00 
   40b27:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40b2e:	00 
   40b2f:	0f 86 71 ff ff ff    	jbe    40aa6 <pageinfo_init+0x15>
    }
}
   40b35:	90                   	nop
   40b36:	90                   	nop
   40b37:	c9                   	leave  
   40b38:	c3                   	ret    

0000000000040b39 <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   40b39:	55                   	push   %rbp
   40b3a:	48 89 e5             	mov    %rsp,%rbp
   40b3d:	48 83 ec 50          	sub    $0x50,%rsp
   40b41:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   40b45:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40b49:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40b4f:	48 89 c2             	mov    %rax,%rdx
   40b52:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40b56:	48 39 c2             	cmp    %rax,%rdx
   40b59:	74 14                	je     40b6f <check_page_table_mappings+0x36>
   40b5b:	ba 78 40 04 00       	mov    $0x44078,%edx
   40b60:	be 90 01 00 00       	mov    $0x190,%esi
   40b65:	bf 60 3e 04 00       	mov    $0x43e60,%edi
   40b6a:	e8 09 18 00 00       	call   42378 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40b6f:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   40b76:	00 
   40b77:	e9 9a 00 00 00       	jmp    40c16 <check_page_table_mappings+0xdd>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   40b7c:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   40b80:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40b84:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40b88:	48 89 ce             	mov    %rcx,%rsi
   40b8b:	48 89 c7             	mov    %rax,%rdi
   40b8e:	e8 aa 1e 00 00       	call   42a3d <virtual_memory_lookup>
        if (vam.pa != va) {
   40b93:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40b97:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40b9b:	74 27                	je     40bc4 <check_page_table_mappings+0x8b>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   40b9d:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40ba1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40ba5:	49 89 d0             	mov    %rdx,%r8
   40ba8:	48 89 c1             	mov    %rax,%rcx
   40bab:	ba 97 40 04 00       	mov    $0x44097,%edx
   40bb0:	be 00 c0 00 00       	mov    $0xc000,%esi
   40bb5:	bf e0 06 00 00       	mov    $0x6e0,%edi
   40bba:	b8 00 00 00 00       	mov    $0x0,%eax
   40bbf:	e8 c2 30 00 00       	call   43c86 <console_printf>
        }
        assert(vam.pa == va);
   40bc4:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40bc8:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40bcc:	74 14                	je     40be2 <check_page_table_mappings+0xa9>
   40bce:	ba a1 40 04 00       	mov    $0x440a1,%edx
   40bd3:	be 99 01 00 00       	mov    $0x199,%esi
   40bd8:	bf 60 3e 04 00       	mov    $0x43e60,%edi
   40bdd:	e8 96 17 00 00       	call   42378 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   40be2:	b8 00 50 04 00       	mov    $0x45000,%eax
   40be7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40beb:	72 21                	jb     40c0e <check_page_table_mappings+0xd5>
            assert(vam.perm & PTE_W);
   40bed:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40bf0:	48 98                	cltq   
   40bf2:	83 e0 02             	and    $0x2,%eax
   40bf5:	48 85 c0             	test   %rax,%rax
   40bf8:	75 14                	jne    40c0e <check_page_table_mappings+0xd5>
   40bfa:	ba ae 40 04 00       	mov    $0x440ae,%edx
   40bff:	be 9b 01 00 00       	mov    $0x19b,%esi
   40c04:	bf 60 3e 04 00       	mov    $0x43e60,%edi
   40c09:	e8 6a 17 00 00       	call   42378 <assert_fail>
         va += PAGESIZE) {
   40c0e:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40c15:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40c16:	b8 08 a0 05 00       	mov    $0x5a008,%eax
   40c1b:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40c1f:	0f 82 57 ff ff ff    	jb     40b7c <check_page_table_mappings+0x43>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   40c25:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   40c2c:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   40c2d:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   40c31:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40c35:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40c39:	48 89 ce             	mov    %rcx,%rsi
   40c3c:	48 89 c7             	mov    %rax,%rdi
   40c3f:	e8 f9 1d 00 00       	call   42a3d <virtual_memory_lookup>
    assert(vam.pa == kstack);
   40c44:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40c48:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   40c4c:	74 14                	je     40c62 <check_page_table_mappings+0x129>
   40c4e:	ba bf 40 04 00       	mov    $0x440bf,%edx
   40c53:	be a2 01 00 00       	mov    $0x1a2,%esi
   40c58:	bf 60 3e 04 00       	mov    $0x43e60,%edi
   40c5d:	e8 16 17 00 00       	call   42378 <assert_fail>
    assert(vam.perm & PTE_W);
   40c62:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40c65:	48 98                	cltq   
   40c67:	83 e0 02             	and    $0x2,%eax
   40c6a:	48 85 c0             	test   %rax,%rax
   40c6d:	75 14                	jne    40c83 <check_page_table_mappings+0x14a>
   40c6f:	ba ae 40 04 00       	mov    $0x440ae,%edx
   40c74:	be a3 01 00 00       	mov    $0x1a3,%esi
   40c79:	bf 60 3e 04 00       	mov    $0x43e60,%edi
   40c7e:	e8 f5 16 00 00       	call   42378 <assert_fail>
}
   40c83:	90                   	nop
   40c84:	c9                   	leave  
   40c85:	c3                   	ret    

0000000000040c86 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   40c86:	55                   	push   %rbp
   40c87:	48 89 e5             	mov    %rsp,%rbp
   40c8a:	48 83 ec 20          	sub    $0x20,%rsp
   40c8e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40c92:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   40c95:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40c98:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   40c9b:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   40ca2:	48 8b 05 57 33 01 00 	mov    0x13357(%rip),%rax        # 54000 <kernel_pagetable>
   40ca9:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40cad:	75 67                	jne    40d16 <check_page_table_ownership+0x90>
        owner = PO_KERNEL;
   40caf:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40cb6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   40cbd:	eb 51                	jmp    40d10 <check_page_table_ownership+0x8a>
            if (processes[xpid].p_state != P_FREE
   40cbf:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40cc2:	48 63 d0             	movslq %eax,%rdx
   40cc5:	48 89 d0             	mov    %rdx,%rax
   40cc8:	48 c1 e0 03          	shl    $0x3,%rax
   40ccc:	48 29 d0             	sub    %rdx,%rax
   40ccf:	48 c1 e0 05          	shl    $0x5,%rax
   40cd3:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   40cd9:	8b 00                	mov    (%rax),%eax
   40cdb:	85 c0                	test   %eax,%eax
   40cdd:	74 2d                	je     40d0c <check_page_table_ownership+0x86>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   40cdf:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40ce2:	48 63 d0             	movslq %eax,%rdx
   40ce5:	48 89 d0             	mov    %rdx,%rax
   40ce8:	48 c1 e0 03          	shl    $0x3,%rax
   40cec:	48 29 d0             	sub    %rdx,%rax
   40cef:	48 c1 e0 05          	shl    $0x5,%rax
   40cf3:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   40cf9:	48 8b 10             	mov    (%rax),%rdx
   40cfc:	48 8b 05 fd 32 01 00 	mov    0x132fd(%rip),%rax        # 54000 <kernel_pagetable>
   40d03:	48 39 c2             	cmp    %rax,%rdx
   40d06:	75 04                	jne    40d0c <check_page_table_ownership+0x86>
                ++expected_refcount;
   40d08:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40d0c:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   40d10:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   40d14:	7e a9                	jle    40cbf <check_page_table_ownership+0x39>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   40d16:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   40d19:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40d1c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40d20:	be 00 00 00 00       	mov    $0x0,%esi
   40d25:	48 89 c7             	mov    %rax,%rdi
   40d28:	e8 03 00 00 00       	call   40d30 <check_page_table_ownership_level>
}
   40d2d:	90                   	nop
   40d2e:	c9                   	leave  
   40d2f:	c3                   	ret    

0000000000040d30 <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   40d30:	55                   	push   %rbp
   40d31:	48 89 e5             	mov    %rsp,%rbp
   40d34:	48 83 ec 30          	sub    $0x30,%rsp
   40d38:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40d3c:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   40d3f:	89 55 e0             	mov    %edx,-0x20(%rbp)
   40d42:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   40d45:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40d49:	48 c1 e8 0c          	shr    $0xc,%rax
   40d4d:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   40d52:	7e 14                	jle    40d68 <check_page_table_ownership_level+0x38>
   40d54:	ba d0 40 04 00       	mov    $0x440d0,%edx
   40d59:	be c0 01 00 00       	mov    $0x1c0,%esi
   40d5e:	bf 60 3e 04 00       	mov    $0x43e60,%edi
   40d63:	e8 10 16 00 00       	call   42378 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   40d68:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40d6c:	48 c1 e8 0c          	shr    $0xc,%rax
   40d70:	48 98                	cltq   
   40d72:	0f b6 84 00 40 1e 05 	movzbl 0x51e40(%rax,%rax,1),%eax
   40d79:	00 
   40d7a:	0f be c0             	movsbl %al,%eax
   40d7d:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   40d80:	74 14                	je     40d96 <check_page_table_ownership_level+0x66>
   40d82:	ba e8 40 04 00       	mov    $0x440e8,%edx
   40d87:	be c1 01 00 00       	mov    $0x1c1,%esi
   40d8c:	bf 60 3e 04 00       	mov    $0x43e60,%edi
   40d91:	e8 e2 15 00 00       	call   42378 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   40d96:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40d9a:	48 c1 e8 0c          	shr    $0xc,%rax
   40d9e:	48 98                	cltq   
   40da0:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   40da7:	00 
   40da8:	0f be c0             	movsbl %al,%eax
   40dab:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   40dae:	74 14                	je     40dc4 <check_page_table_ownership_level+0x94>
   40db0:	ba 10 41 04 00       	mov    $0x44110,%edx
   40db5:	be c2 01 00 00       	mov    $0x1c2,%esi
   40dba:	bf 60 3e 04 00       	mov    $0x43e60,%edi
   40dbf:	e8 b4 15 00 00       	call   42378 <assert_fail>
    if (level < 3) {
   40dc4:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   40dc8:	7f 5b                	jg     40e25 <check_page_table_ownership_level+0xf5>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   40dca:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   40dd1:	eb 49                	jmp    40e1c <check_page_table_ownership_level+0xec>
            if (pt->entry[index]) {
   40dd3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40dd7:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40dda:	48 63 d2             	movslq %edx,%rdx
   40ddd:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   40de1:	48 85 c0             	test   %rax,%rax
   40de4:	74 32                	je     40e18 <check_page_table_ownership_level+0xe8>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   40de6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40dea:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40ded:	48 63 d2             	movslq %edx,%rdx
   40df0:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   40df4:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   40dfa:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   40dfe:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40e01:	8d 70 01             	lea    0x1(%rax),%esi
   40e04:	8b 55 e0             	mov    -0x20(%rbp),%edx
   40e07:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40e0b:	b9 01 00 00 00       	mov    $0x1,%ecx
   40e10:	48 89 c7             	mov    %rax,%rdi
   40e13:	e8 18 ff ff ff       	call   40d30 <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   40e18:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   40e1c:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   40e23:	7e ae                	jle    40dd3 <check_page_table_ownership_level+0xa3>
            }
        }
    }
}
   40e25:	90                   	nop
   40e26:	c9                   	leave  
   40e27:	c3                   	ret    

0000000000040e28 <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   40e28:	55                   	push   %rbp
   40e29:	48 89 e5             	mov    %rsp,%rbp
   40e2c:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   40e30:	8b 05 b2 02 01 00    	mov    0x102b2(%rip),%eax        # 510e8 <processes+0xc8>
   40e36:	85 c0                	test   %eax,%eax
   40e38:	74 14                	je     40e4e <check_virtual_memory+0x26>
   40e3a:	ba 40 41 04 00       	mov    $0x44140,%edx
   40e3f:	be d5 01 00 00       	mov    $0x1d5,%esi
   40e44:	bf 60 3e 04 00       	mov    $0x43e60,%edi
   40e49:	e8 2a 15 00 00       	call   42378 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   40e4e:	48 8b 05 ab 31 01 00 	mov    0x131ab(%rip),%rax        # 54000 <kernel_pagetable>
   40e55:	48 89 c7             	mov    %rax,%rdi
   40e58:	e8 dc fc ff ff       	call   40b39 <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   40e5d:	48 8b 05 9c 31 01 00 	mov    0x1319c(%rip),%rax        # 54000 <kernel_pagetable>
   40e64:	be ff ff ff ff       	mov    $0xffffffff,%esi
   40e69:	48 89 c7             	mov    %rax,%rdi
   40e6c:	e8 15 fe ff ff       	call   40c86 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   40e71:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   40e78:	e9 9c 00 00 00       	jmp    40f19 <check_virtual_memory+0xf1>
        if (processes[pid].p_state != P_FREE
   40e7d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40e80:	48 63 d0             	movslq %eax,%rdx
   40e83:	48 89 d0             	mov    %rdx,%rax
   40e86:	48 c1 e0 03          	shl    $0x3,%rax
   40e8a:	48 29 d0             	sub    %rdx,%rax
   40e8d:	48 c1 e0 05          	shl    $0x5,%rax
   40e91:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   40e97:	8b 00                	mov    (%rax),%eax
   40e99:	85 c0                	test   %eax,%eax
   40e9b:	74 78                	je     40f15 <check_virtual_memory+0xed>
            && processes[pid].p_pagetable != kernel_pagetable) {
   40e9d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40ea0:	48 63 d0             	movslq %eax,%rdx
   40ea3:	48 89 d0             	mov    %rdx,%rax
   40ea6:	48 c1 e0 03          	shl    $0x3,%rax
   40eaa:	48 29 d0             	sub    %rdx,%rax
   40ead:	48 c1 e0 05          	shl    $0x5,%rax
   40eb1:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   40eb7:	48 8b 10             	mov    (%rax),%rdx
   40eba:	48 8b 05 3f 31 01 00 	mov    0x1313f(%rip),%rax        # 54000 <kernel_pagetable>
   40ec1:	48 39 c2             	cmp    %rax,%rdx
   40ec4:	74 4f                	je     40f15 <check_virtual_memory+0xed>
            check_page_table_mappings(processes[pid].p_pagetable);
   40ec6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40ec9:	48 63 d0             	movslq %eax,%rdx
   40ecc:	48 89 d0             	mov    %rdx,%rax
   40ecf:	48 c1 e0 03          	shl    $0x3,%rax
   40ed3:	48 29 d0             	sub    %rdx,%rax
   40ed6:	48 c1 e0 05          	shl    $0x5,%rax
   40eda:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   40ee0:	48 8b 00             	mov    (%rax),%rax
   40ee3:	48 89 c7             	mov    %rax,%rdi
   40ee6:	e8 4e fc ff ff       	call   40b39 <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   40eeb:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40eee:	48 63 d0             	movslq %eax,%rdx
   40ef1:	48 89 d0             	mov    %rdx,%rax
   40ef4:	48 c1 e0 03          	shl    $0x3,%rax
   40ef8:	48 29 d0             	sub    %rdx,%rax
   40efb:	48 c1 e0 05          	shl    $0x5,%rax
   40eff:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   40f05:	48 8b 00             	mov    (%rax),%rax
   40f08:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40f0b:	89 d6                	mov    %edx,%esi
   40f0d:	48 89 c7             	mov    %rax,%rdi
   40f10:	e8 71 fd ff ff       	call   40c86 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   40f15:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   40f19:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   40f1d:	0f 8e 5a ff ff ff    	jle    40e7d <check_virtual_memory+0x55>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   40f23:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   40f2a:	eb 67                	jmp    40f93 <check_virtual_memory+0x16b>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   40f2c:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40f2f:	48 98                	cltq   
   40f31:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   40f38:	00 
   40f39:	84 c0                	test   %al,%al
   40f3b:	7e 52                	jle    40f8f <check_virtual_memory+0x167>
   40f3d:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40f40:	48 98                	cltq   
   40f42:	0f b6 84 00 40 1e 05 	movzbl 0x51e40(%rax,%rax,1),%eax
   40f49:	00 
   40f4a:	84 c0                	test   %al,%al
   40f4c:	78 41                	js     40f8f <check_virtual_memory+0x167>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   40f4e:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40f51:	48 98                	cltq   
   40f53:	0f b6 84 00 40 1e 05 	movzbl 0x51e40(%rax,%rax,1),%eax
   40f5a:	00 
   40f5b:	0f be c0             	movsbl %al,%eax
   40f5e:	48 63 d0             	movslq %eax,%rdx
   40f61:	48 89 d0             	mov    %rdx,%rax
   40f64:	48 c1 e0 03          	shl    $0x3,%rax
   40f68:	48 29 d0             	sub    %rdx,%rax
   40f6b:	48 c1 e0 05          	shl    $0x5,%rax
   40f6f:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   40f75:	8b 00                	mov    (%rax),%eax
   40f77:	85 c0                	test   %eax,%eax
   40f79:	75 14                	jne    40f8f <check_virtual_memory+0x167>
   40f7b:	ba 60 41 04 00       	mov    $0x44160,%edx
   40f80:	be ec 01 00 00       	mov    $0x1ec,%esi
   40f85:	bf 60 3e 04 00       	mov    $0x43e60,%edi
   40f8a:	e8 e9 13 00 00       	call   42378 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   40f8f:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   40f93:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   40f9a:	7e 90                	jle    40f2c <check_virtual_memory+0x104>
        }
    }
}
   40f9c:	90                   	nop
   40f9d:	90                   	nop
   40f9e:	c9                   	leave  
   40f9f:	c3                   	ret    

0000000000040fa0 <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   40fa0:	55                   	push   %rbp
   40fa1:	48 89 e5             	mov    %rsp,%rbp
   40fa4:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   40fa8:	ba c6 41 04 00       	mov    $0x441c6,%edx
   40fad:	be 00 0f 00 00       	mov    $0xf00,%esi
   40fb2:	bf 20 00 00 00       	mov    $0x20,%edi
   40fb7:	b8 00 00 00 00       	mov    $0x0,%eax
   40fbc:	e8 c5 2c 00 00       	call   43c86 <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   40fc1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   40fc8:	e9 f8 00 00 00       	jmp    410c5 <memshow_physical+0x125>
        if (pn % 64 == 0) {
   40fcd:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40fd0:	83 e0 3f             	and    $0x3f,%eax
   40fd3:	85 c0                	test   %eax,%eax
   40fd5:	75 3c                	jne    41013 <memshow_physical+0x73>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   40fd7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40fda:	c1 e0 0c             	shl    $0xc,%eax
   40fdd:	89 c1                	mov    %eax,%ecx
   40fdf:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40fe2:	8d 50 3f             	lea    0x3f(%rax),%edx
   40fe5:	85 c0                	test   %eax,%eax
   40fe7:	0f 48 c2             	cmovs  %edx,%eax
   40fea:	c1 f8 06             	sar    $0x6,%eax
   40fed:	8d 50 01             	lea    0x1(%rax),%edx
   40ff0:	89 d0                	mov    %edx,%eax
   40ff2:	c1 e0 02             	shl    $0x2,%eax
   40ff5:	01 d0                	add    %edx,%eax
   40ff7:	c1 e0 04             	shl    $0x4,%eax
   40ffa:	83 c0 03             	add    $0x3,%eax
   40ffd:	ba d6 41 04 00       	mov    $0x441d6,%edx
   41002:	be 00 0f 00 00       	mov    $0xf00,%esi
   41007:	89 c7                	mov    %eax,%edi
   41009:	b8 00 00 00 00       	mov    $0x0,%eax
   4100e:	e8 73 2c 00 00       	call   43c86 <console_printf>
        }

        int owner = pageinfo[pn].owner;
   41013:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41016:	48 98                	cltq   
   41018:	0f b6 84 00 40 1e 05 	movzbl 0x51e40(%rax,%rax,1),%eax
   4101f:	00 
   41020:	0f be c0             	movsbl %al,%eax
   41023:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   41026:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41029:	48 98                	cltq   
   4102b:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   41032:	00 
   41033:	84 c0                	test   %al,%al
   41035:	75 07                	jne    4103e <memshow_physical+0x9e>
            owner = PO_FREE;
   41037:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   4103e:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41041:	83 c0 02             	add    $0x2,%eax
   41044:	48 98                	cltq   
   41046:	0f b7 84 00 a0 41 04 	movzwl 0x441a0(%rax,%rax,1),%eax
   4104d:	00 
   4104e:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   41052:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41055:	48 98                	cltq   
   41057:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   4105e:	00 
   4105f:	3c 01                	cmp    $0x1,%al
   41061:	7e 1a                	jle    4107d <memshow_physical+0xdd>
   41063:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   41068:	48 c1 e8 0c          	shr    $0xc,%rax
   4106c:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   4106f:	74 0c                	je     4107d <memshow_physical+0xdd>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   41071:	b8 53 00 00 00       	mov    $0x53,%eax
   41076:	80 cc 0f             	or     $0xf,%ah
   41079:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   4107d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41080:	8d 50 3f             	lea    0x3f(%rax),%edx
   41083:	85 c0                	test   %eax,%eax
   41085:	0f 48 c2             	cmovs  %edx,%eax
   41088:	c1 f8 06             	sar    $0x6,%eax
   4108b:	8d 50 01             	lea    0x1(%rax),%edx
   4108e:	89 d0                	mov    %edx,%eax
   41090:	c1 e0 02             	shl    $0x2,%eax
   41093:	01 d0                	add    %edx,%eax
   41095:	c1 e0 04             	shl    $0x4,%eax
   41098:	89 c1                	mov    %eax,%ecx
   4109a:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4109d:	89 d0                	mov    %edx,%eax
   4109f:	c1 f8 1f             	sar    $0x1f,%eax
   410a2:	c1 e8 1a             	shr    $0x1a,%eax
   410a5:	01 c2                	add    %eax,%edx
   410a7:	83 e2 3f             	and    $0x3f,%edx
   410aa:	29 c2                	sub    %eax,%edx
   410ac:	89 d0                	mov    %edx,%eax
   410ae:	83 c0 0c             	add    $0xc,%eax
   410b1:	01 c8                	add    %ecx,%eax
   410b3:	48 98                	cltq   
   410b5:	0f b7 55 f6          	movzwl -0xa(%rbp),%edx
   410b9:	66 89 94 00 00 80 0b 	mov    %dx,0xb8000(%rax,%rax,1)
   410c0:	00 
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   410c1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   410c5:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   410cc:	0f 8e fb fe ff ff    	jle    40fcd <memshow_physical+0x2d>
    }
}
   410d2:	90                   	nop
   410d3:	90                   	nop
   410d4:	c9                   	leave  
   410d5:	c3                   	ret    

00000000000410d6 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   410d6:	55                   	push   %rbp
   410d7:	48 89 e5             	mov    %rsp,%rbp
   410da:	48 83 ec 40          	sub    $0x40,%rsp
   410de:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   410e2:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   410e6:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   410ea:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   410f0:	48 89 c2             	mov    %rax,%rdx
   410f3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   410f7:	48 39 c2             	cmp    %rax,%rdx
   410fa:	74 14                	je     41110 <memshow_virtual+0x3a>
   410fc:	ba e0 41 04 00       	mov    $0x441e0,%edx
   41101:	be 1d 02 00 00       	mov    $0x21d,%esi
   41106:	bf 60 3e 04 00       	mov    $0x43e60,%edi
   4110b:	e8 68 12 00 00       	call   42378 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   41110:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   41114:	48 89 c1             	mov    %rax,%rcx
   41117:	ba 0d 42 04 00       	mov    $0x4420d,%edx
   4111c:	be 00 0f 00 00       	mov    $0xf00,%esi
   41121:	bf 3a 03 00 00       	mov    $0x33a,%edi
   41126:	b8 00 00 00 00       	mov    $0x0,%eax
   4112b:	e8 56 2b 00 00       	call   43c86 <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41130:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   41137:	00 
   41138:	e9 80 01 00 00       	jmp    412bd <memshow_virtual+0x1e7>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   4113d:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   41141:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   41145:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   41149:	48 89 ce             	mov    %rcx,%rsi
   4114c:	48 89 c7             	mov    %rax,%rdi
   4114f:	e8 e9 18 00 00       	call   42a3d <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   41154:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41157:	85 c0                	test   %eax,%eax
   41159:	79 0b                	jns    41166 <memshow_virtual+0x90>
            color = ' ';
   4115b:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   41161:	e9 d7 00 00 00       	jmp    4123d <memshow_virtual+0x167>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   41166:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4116a:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   41170:	76 14                	jbe    41186 <memshow_virtual+0xb0>
   41172:	ba 2a 42 04 00       	mov    $0x4422a,%edx
   41177:	be 26 02 00 00       	mov    $0x226,%esi
   4117c:	bf 60 3e 04 00       	mov    $0x43e60,%edi
   41181:	e8 f2 11 00 00       	call   42378 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   41186:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41189:	48 98                	cltq   
   4118b:	0f b6 84 00 40 1e 05 	movzbl 0x51e40(%rax,%rax,1),%eax
   41192:	00 
   41193:	0f be c0             	movsbl %al,%eax
   41196:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   41199:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4119c:	48 98                	cltq   
   4119e:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   411a5:	00 
   411a6:	84 c0                	test   %al,%al
   411a8:	75 07                	jne    411b1 <memshow_virtual+0xdb>
                owner = PO_FREE;
   411aa:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   411b1:	8b 45 f0             	mov    -0x10(%rbp),%eax
   411b4:	83 c0 02             	add    $0x2,%eax
   411b7:	48 98                	cltq   
   411b9:	0f b7 84 00 a0 41 04 	movzwl 0x441a0(%rax,%rax,1),%eax
   411c0:	00 
   411c1:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   411c5:	8b 45 e0             	mov    -0x20(%rbp),%eax
   411c8:	48 98                	cltq   
   411ca:	83 e0 04             	and    $0x4,%eax
   411cd:	48 85 c0             	test   %rax,%rax
   411d0:	74 27                	je     411f9 <memshow_virtual+0x123>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   411d2:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   411d6:	c1 e0 04             	shl    $0x4,%eax
   411d9:	66 25 00 f0          	and    $0xf000,%ax
   411dd:	89 c2                	mov    %eax,%edx
   411df:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   411e3:	c1 f8 04             	sar    $0x4,%eax
   411e6:	66 25 00 0f          	and    $0xf00,%ax
   411ea:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   411ec:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   411f0:	0f b6 c0             	movzbl %al,%eax
   411f3:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   411f5:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   411f9:	8b 45 d0             	mov    -0x30(%rbp),%eax
   411fc:	48 98                	cltq   
   411fe:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   41205:	00 
   41206:	3c 01                	cmp    $0x1,%al
   41208:	7e 33                	jle    4123d <memshow_virtual+0x167>
   4120a:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   4120f:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41213:	74 28                	je     4123d <memshow_virtual+0x167>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   41215:	b8 53 00 00 00       	mov    $0x53,%eax
   4121a:	89 c2                	mov    %eax,%edx
   4121c:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41220:	66 25 00 f0          	and    $0xf000,%ax
   41224:	09 d0                	or     %edx,%eax
   41226:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   4122a:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4122d:	48 98                	cltq   
   4122f:	83 e0 04             	and    $0x4,%eax
   41232:	48 85 c0             	test   %rax,%rax
   41235:	75 06                	jne    4123d <memshow_virtual+0x167>
                    color = color | 0x0F00;
   41237:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   4123d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41241:	48 c1 e8 0c          	shr    $0xc,%rax
   41245:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   41248:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4124b:	83 e0 3f             	and    $0x3f,%eax
   4124e:	85 c0                	test   %eax,%eax
   41250:	75 34                	jne    41286 <memshow_virtual+0x1b0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   41252:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41255:	c1 e8 06             	shr    $0x6,%eax
   41258:	89 c2                	mov    %eax,%edx
   4125a:	89 d0                	mov    %edx,%eax
   4125c:	c1 e0 02             	shl    $0x2,%eax
   4125f:	01 d0                	add    %edx,%eax
   41261:	c1 e0 04             	shl    $0x4,%eax
   41264:	05 73 03 00 00       	add    $0x373,%eax
   41269:	89 c7                	mov    %eax,%edi
   4126b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4126f:	48 89 c1             	mov    %rax,%rcx
   41272:	ba d6 41 04 00       	mov    $0x441d6,%edx
   41277:	be 00 0f 00 00       	mov    $0xf00,%esi
   4127c:	b8 00 00 00 00       	mov    $0x0,%eax
   41281:	e8 00 2a 00 00       	call   43c86 <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   41286:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41289:	c1 e8 06             	shr    $0x6,%eax
   4128c:	89 c2                	mov    %eax,%edx
   4128e:	89 d0                	mov    %edx,%eax
   41290:	c1 e0 02             	shl    $0x2,%eax
   41293:	01 d0                	add    %edx,%eax
   41295:	c1 e0 04             	shl    $0x4,%eax
   41298:	89 c2                	mov    %eax,%edx
   4129a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4129d:	83 e0 3f             	and    $0x3f,%eax
   412a0:	01 d0                	add    %edx,%eax
   412a2:	05 7c 03 00 00       	add    $0x37c,%eax
   412a7:	89 c2                	mov    %eax,%edx
   412a9:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   412ad:	66 89 84 12 00 80 0b 	mov    %ax,0xb8000(%rdx,%rdx,1)
   412b4:	00 
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   412b5:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   412bc:	00 
   412bd:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   412c4:	00 
   412c5:	0f 86 72 fe ff ff    	jbe    4113d <memshow_virtual+0x67>
    }
}
   412cb:	90                   	nop
   412cc:	90                   	nop
   412cd:	c9                   	leave  
   412ce:	c3                   	ret    

00000000000412cf <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   412cf:	55                   	push   %rbp
   412d0:	48 89 e5             	mov    %rsp,%rbp
   412d3:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   412d7:	8b 05 63 0f 01 00    	mov    0x10f63(%rip),%eax        # 52240 <last_ticks.1>
   412dd:	85 c0                	test   %eax,%eax
   412df:	74 13                	je     412f4 <memshow_virtual_animate+0x25>
   412e1:	8b 15 39 0b 01 00    	mov    0x10b39(%rip),%edx        # 51e20 <ticks>
   412e7:	8b 05 53 0f 01 00    	mov    0x10f53(%rip),%eax        # 52240 <last_ticks.1>
   412ed:	29 c2                	sub    %eax,%edx
   412ef:	83 fa 31             	cmp    $0x31,%edx
   412f2:	76 2c                	jbe    41320 <memshow_virtual_animate+0x51>
        last_ticks = ticks;
   412f4:	8b 05 26 0b 01 00    	mov    0x10b26(%rip),%eax        # 51e20 <ticks>
   412fa:	89 05 40 0f 01 00    	mov    %eax,0x10f40(%rip)        # 52240 <last_ticks.1>
        ++showing;
   41300:	8b 05 fe 3c 00 00    	mov    0x3cfe(%rip),%eax        # 45004 <showing.0>
   41306:	83 c0 01             	add    $0x1,%eax
   41309:	89 05 f5 3c 00 00    	mov    %eax,0x3cf5(%rip)        # 45004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   4130f:	eb 0f                	jmp    41320 <memshow_virtual_animate+0x51>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
        ++showing;
   41311:	8b 05 ed 3c 00 00    	mov    0x3ced(%rip),%eax        # 45004 <showing.0>
   41317:	83 c0 01             	add    $0x1,%eax
   4131a:	89 05 e4 3c 00 00    	mov    %eax,0x3ce4(%rip)        # 45004 <showing.0>
    while (showing <= 2*NPROC
   41320:	8b 05 de 3c 00 00    	mov    0x3cde(%rip),%eax        # 45004 <showing.0>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
   41326:	83 f8 20             	cmp    $0x20,%eax
   41329:	7f 6d                	jg     41398 <memshow_virtual_animate+0xc9>
   4132b:	8b 15 d3 3c 00 00    	mov    0x3cd3(%rip),%edx        # 45004 <showing.0>
   41331:	89 d0                	mov    %edx,%eax
   41333:	c1 f8 1f             	sar    $0x1f,%eax
   41336:	c1 e8 1c             	shr    $0x1c,%eax
   41339:	01 c2                	add    %eax,%edx
   4133b:	83 e2 0f             	and    $0xf,%edx
   4133e:	29 c2                	sub    %eax,%edx
   41340:	89 d0                	mov    %edx,%eax
   41342:	48 63 d0             	movslq %eax,%rdx
   41345:	48 89 d0             	mov    %rdx,%rax
   41348:	48 c1 e0 03          	shl    $0x3,%rax
   4134c:	48 29 d0             	sub    %rdx,%rax
   4134f:	48 c1 e0 05          	shl    $0x5,%rax
   41353:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   41359:	8b 00                	mov    (%rax),%eax
   4135b:	85 c0                	test   %eax,%eax
   4135d:	74 b2                	je     41311 <memshow_virtual_animate+0x42>
   4135f:	8b 15 9f 3c 00 00    	mov    0x3c9f(%rip),%edx        # 45004 <showing.0>
   41365:	89 d0                	mov    %edx,%eax
   41367:	c1 f8 1f             	sar    $0x1f,%eax
   4136a:	c1 e8 1c             	shr    $0x1c,%eax
   4136d:	01 c2                	add    %eax,%edx
   4136f:	83 e2 0f             	and    $0xf,%edx
   41372:	29 c2                	sub    %eax,%edx
   41374:	89 d0                	mov    %edx,%eax
   41376:	48 63 d0             	movslq %eax,%rdx
   41379:	48 89 d0             	mov    %rdx,%rax
   4137c:	48 c1 e0 03          	shl    $0x3,%rax
   41380:	48 29 d0             	sub    %rdx,%rax
   41383:	48 c1 e0 05          	shl    $0x5,%rax
   41387:	48 05 f8 10 05 00    	add    $0x510f8,%rax
   4138d:	0f b6 00             	movzbl (%rax),%eax
   41390:	84 c0                	test   %al,%al
   41392:	0f 84 79 ff ff ff    	je     41311 <memshow_virtual_animate+0x42>
    }
    showing = showing % NPROC;
   41398:	8b 15 66 3c 00 00    	mov    0x3c66(%rip),%edx        # 45004 <showing.0>
   4139e:	89 d0                	mov    %edx,%eax
   413a0:	c1 f8 1f             	sar    $0x1f,%eax
   413a3:	c1 e8 1c             	shr    $0x1c,%eax
   413a6:	01 c2                	add    %eax,%edx
   413a8:	83 e2 0f             	and    $0xf,%edx
   413ab:	29 c2                	sub    %eax,%edx
   413ad:	89 d0                	mov    %edx,%eax
   413af:	89 05 4f 3c 00 00    	mov    %eax,0x3c4f(%rip)        # 45004 <showing.0>

    if (processes[showing].p_state != P_FREE) {
   413b5:	8b 05 49 3c 00 00    	mov    0x3c49(%rip),%eax        # 45004 <showing.0>
   413bb:	48 63 d0             	movslq %eax,%rdx
   413be:	48 89 d0             	mov    %rdx,%rax
   413c1:	48 c1 e0 03          	shl    $0x3,%rax
   413c5:	48 29 d0             	sub    %rdx,%rax
   413c8:	48 c1 e0 05          	shl    $0x5,%rax
   413cc:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   413d2:	8b 00                	mov    (%rax),%eax
   413d4:	85 c0                	test   %eax,%eax
   413d6:	74 52                	je     4142a <memshow_virtual_animate+0x15b>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   413d8:	8b 15 26 3c 00 00    	mov    0x3c26(%rip),%edx        # 45004 <showing.0>
   413de:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   413e2:	89 d1                	mov    %edx,%ecx
   413e4:	ba 44 42 04 00       	mov    $0x44244,%edx
   413e9:	be 04 00 00 00       	mov    $0x4,%esi
   413ee:	48 89 c7             	mov    %rax,%rdi
   413f1:	b8 00 00 00 00       	mov    $0x0,%eax
   413f6:	e8 97 29 00 00       	call   43d92 <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   413fb:	8b 05 03 3c 00 00    	mov    0x3c03(%rip),%eax        # 45004 <showing.0>
   41401:	48 63 d0             	movslq %eax,%rdx
   41404:	48 89 d0             	mov    %rdx,%rax
   41407:	48 c1 e0 03          	shl    $0x3,%rax
   4140b:	48 29 d0             	sub    %rdx,%rax
   4140e:	48 c1 e0 05          	shl    $0x5,%rax
   41412:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   41418:	48 8b 00             	mov    (%rax),%rax
   4141b:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   4141f:	48 89 d6             	mov    %rdx,%rsi
   41422:	48 89 c7             	mov    %rax,%rdi
   41425:	e8 ac fc ff ff       	call   410d6 <memshow_virtual>
    }
}
   4142a:	90                   	nop
   4142b:	c9                   	leave  
   4142c:	c3                   	ret    

000000000004142d <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   4142d:	55                   	push   %rbp
   4142e:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   41431:	e8 4f 01 00 00       	call   41585 <segments_init>
    interrupt_init();
   41436:	e8 d0 03 00 00       	call   4180b <interrupt_init>
    virtual_memory_init();
   4143b:	e8 f3 0f 00 00       	call   42433 <virtual_memory_init>
}
   41440:	90                   	nop
   41441:	5d                   	pop    %rbp
   41442:	c3                   	ret    

0000000000041443 <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   41443:	55                   	push   %rbp
   41444:	48 89 e5             	mov    %rsp,%rbp
   41447:	48 83 ec 18          	sub    $0x18,%rsp
   4144b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4144f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41453:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   41456:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41459:	48 98                	cltq   
   4145b:	48 c1 e0 2d          	shl    $0x2d,%rax
   4145f:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   41463:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   4146a:	90 00 00 
   4146d:	48 09 c2             	or     %rax,%rdx
    *segment = type
   41470:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41474:	48 89 10             	mov    %rdx,(%rax)
}
   41477:	90                   	nop
   41478:	c9                   	leave  
   41479:	c3                   	ret    

000000000004147a <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   4147a:	55                   	push   %rbp
   4147b:	48 89 e5             	mov    %rsp,%rbp
   4147e:	48 83 ec 28          	sub    $0x28,%rsp
   41482:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41486:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   4148a:	89 55 ec             	mov    %edx,-0x14(%rbp)
   4148d:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   41491:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41495:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41499:	48 c1 e0 10          	shl    $0x10,%rax
   4149d:	48 89 c2             	mov    %rax,%rdx
   414a0:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   414a7:	00 00 00 
   414aa:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   414ad:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   414b1:	48 c1 e0 20          	shl    $0x20,%rax
   414b5:	48 89 c1             	mov    %rax,%rcx
   414b8:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   414bf:	00 00 ff 
   414c2:	48 21 c8             	and    %rcx,%rax
   414c5:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   414c8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   414cc:	48 83 e8 01          	sub    $0x1,%rax
   414d0:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   414d3:	48 09 d0             	or     %rdx,%rax
        | type
   414d6:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   414da:	8b 55 ec             	mov    -0x14(%rbp),%edx
   414dd:	48 63 d2             	movslq %edx,%rdx
   414e0:	48 c1 e2 2d          	shl    $0x2d,%rdx
   414e4:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   414e7:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   414ee:	80 00 00 
   414f1:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   414f4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   414f8:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   414fb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   414ff:	48 83 c0 08          	add    $0x8,%rax
   41503:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   41507:	48 c1 ea 20          	shr    $0x20,%rdx
   4150b:	48 89 10             	mov    %rdx,(%rax)
}
   4150e:	90                   	nop
   4150f:	c9                   	leave  
   41510:	c3                   	ret    

0000000000041511 <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   41511:	55                   	push   %rbp
   41512:	48 89 e5             	mov    %rsp,%rbp
   41515:	48 83 ec 20          	sub    $0x20,%rsp
   41519:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4151d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41521:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41524:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41528:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4152c:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   4152f:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   41533:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41536:	48 63 d2             	movslq %edx,%rdx
   41539:	48 c1 e2 2d          	shl    $0x2d,%rdx
   4153d:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   41540:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41544:	48 c1 e0 20          	shl    $0x20,%rax
   41548:	48 89 c1             	mov    %rax,%rcx
   4154b:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   41552:	00 ff ff 
   41555:	48 21 c8             	and    %rcx,%rax
   41558:	48 09 c2             	or     %rax,%rdx
   4155b:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   41562:	80 00 00 
   41565:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41568:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4156c:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   4156f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41573:	48 c1 e8 20          	shr    $0x20,%rax
   41577:	48 89 c2             	mov    %rax,%rdx
   4157a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4157e:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   41582:	90                   	nop
   41583:	c9                   	leave  
   41584:	c3                   	ret    

0000000000041585 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   41585:	55                   	push   %rbp
   41586:	48 89 e5             	mov    %rsp,%rbp
   41589:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   4158d:	48 c7 05 c8 0c 01 00 	movq   $0x0,0x10cc8(%rip)        # 52260 <segments>
   41594:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   41598:	ba 00 00 00 00       	mov    $0x0,%edx
   4159d:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   415a4:	08 20 00 
   415a7:	48 89 c6             	mov    %rax,%rsi
   415aa:	bf 68 22 05 00       	mov    $0x52268,%edi
   415af:	e8 8f fe ff ff       	call   41443 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   415b4:	ba 03 00 00 00       	mov    $0x3,%edx
   415b9:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   415c0:	08 20 00 
   415c3:	48 89 c6             	mov    %rax,%rsi
   415c6:	bf 70 22 05 00       	mov    $0x52270,%edi
   415cb:	e8 73 fe ff ff       	call   41443 <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   415d0:	ba 00 00 00 00       	mov    $0x0,%edx
   415d5:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   415dc:	02 00 00 
   415df:	48 89 c6             	mov    %rax,%rsi
   415e2:	bf 78 22 05 00       	mov    $0x52278,%edi
   415e7:	e8 57 fe ff ff       	call   41443 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   415ec:	ba 03 00 00 00       	mov    $0x3,%edx
   415f1:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   415f8:	02 00 00 
   415fb:	48 89 c6             	mov    %rax,%rsi
   415fe:	bf 80 22 05 00       	mov    $0x52280,%edi
   41603:	e8 3b fe ff ff       	call   41443 <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   41608:	b8 a0 32 05 00       	mov    $0x532a0,%eax
   4160d:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   41613:	48 89 c1             	mov    %rax,%rcx
   41616:	ba 00 00 00 00       	mov    $0x0,%edx
   4161b:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   41622:	09 00 00 
   41625:	48 89 c6             	mov    %rax,%rsi
   41628:	bf 88 22 05 00       	mov    $0x52288,%edi
   4162d:	e8 48 fe ff ff       	call   4147a <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   41632:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   41638:	b8 60 22 05 00       	mov    $0x52260,%eax
   4163d:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   41641:	ba 60 00 00 00       	mov    $0x60,%edx
   41646:	be 00 00 00 00       	mov    $0x0,%esi
   4164b:	bf a0 32 05 00       	mov    $0x532a0,%edi
   41650:	e8 7a 18 00 00       	call   42ecf <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   41655:	48 c7 05 44 1c 01 00 	movq   $0x80000,0x11c44(%rip)        # 532a4 <kernel_task_descriptor+0x4>
   4165c:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   41660:	ba 00 10 00 00       	mov    $0x1000,%edx
   41665:	be 00 00 00 00       	mov    $0x0,%esi
   4166a:	bf a0 22 05 00       	mov    $0x522a0,%edi
   4166f:	e8 5b 18 00 00       	call   42ecf <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41674:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   4167b:	eb 30                	jmp    416ad <segments_init+0x128>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   4167d:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   41682:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41685:	48 c1 e0 04          	shl    $0x4,%rax
   41689:	48 05 a0 22 05 00    	add    $0x522a0,%rax
   4168f:	48 89 d1             	mov    %rdx,%rcx
   41692:	ba 00 00 00 00       	mov    $0x0,%edx
   41697:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   4169e:	0e 00 00 
   416a1:	48 89 c7             	mov    %rax,%rdi
   416a4:	e8 68 fe ff ff       	call   41511 <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   416a9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   416ad:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   416b4:	76 c7                	jbe    4167d <segments_init+0xf8>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   416b6:	b8 36 00 04 00       	mov    $0x40036,%eax
   416bb:	48 89 c1             	mov    %rax,%rcx
   416be:	ba 00 00 00 00       	mov    $0x0,%edx
   416c3:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   416ca:	0e 00 00 
   416cd:	48 89 c6             	mov    %rax,%rsi
   416d0:	bf a0 24 05 00       	mov    $0x524a0,%edi
   416d5:	e8 37 fe ff ff       	call   41511 <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   416da:	b8 2e 00 04 00       	mov    $0x4002e,%eax
   416df:	48 89 c1             	mov    %rax,%rcx
   416e2:	ba 00 00 00 00       	mov    $0x0,%edx
   416e7:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   416ee:	0e 00 00 
   416f1:	48 89 c6             	mov    %rax,%rsi
   416f4:	bf 70 23 05 00       	mov    $0x52370,%edi
   416f9:	e8 13 fe ff ff       	call   41511 <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   416fe:	b8 32 00 04 00       	mov    $0x40032,%eax
   41703:	48 89 c1             	mov    %rax,%rcx
   41706:	ba 00 00 00 00       	mov    $0x0,%edx
   4170b:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41712:	0e 00 00 
   41715:	48 89 c6             	mov    %rax,%rsi
   41718:	bf 80 23 05 00       	mov    $0x52380,%edi
   4171d:	e8 ef fd ff ff       	call   41511 <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41722:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   41729:	eb 3e                	jmp    41769 <segments_init+0x1e4>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   4172b:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4172e:	83 e8 30             	sub    $0x30,%eax
   41731:	89 c0                	mov    %eax,%eax
   41733:	48 8b 04 c5 e7 00 04 	mov    0x400e7(,%rax,8),%rax
   4173a:	00 
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   4173b:	48 89 c2             	mov    %rax,%rdx
   4173e:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41741:	48 c1 e0 04          	shl    $0x4,%rax
   41745:	48 05 a0 22 05 00    	add    $0x522a0,%rax
   4174b:	48 89 d1             	mov    %rdx,%rcx
   4174e:	ba 03 00 00 00       	mov    $0x3,%edx
   41753:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   4175a:	0e 00 00 
   4175d:	48 89 c7             	mov    %rax,%rdi
   41760:	e8 ac fd ff ff       	call   41511 <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41765:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41769:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   4176d:	76 bc                	jbe    4172b <segments_init+0x1a6>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   4176f:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   41775:	b8 a0 22 05 00       	mov    $0x522a0,%eax
   4177a:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   4177e:	b8 28 00 00 00       	mov    $0x28,%eax
   41783:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   41787:	0f 00 d8             	ltr    %ax
   4178a:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   4178e:	0f 20 c0             	mov    %cr0,%rax
   41791:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   41795:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   41799:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   4179c:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   417a3:	8b 45 f4             	mov    -0xc(%rbp),%eax
   417a6:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   417a9:	8b 45 f0             	mov    -0x10(%rbp),%eax
   417ac:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   417b0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   417b4:	0f 22 c0             	mov    %rax,%cr0
}
   417b7:	90                   	nop
    lcr0(cr0);
}
   417b8:	90                   	nop
   417b9:	c9                   	leave  
   417ba:	c3                   	ret    

00000000000417bb <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   417bb:	55                   	push   %rbp
   417bc:	48 89 e5             	mov    %rsp,%rbp
   417bf:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   417c3:	0f b7 05 36 1b 01 00 	movzwl 0x11b36(%rip),%eax        # 53300 <interrupts_enabled>
   417ca:	f7 d0                	not    %eax
   417cc:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   417d0:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   417d4:	0f b6 c0             	movzbl %al,%eax
   417d7:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   417de:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   417e1:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   417e5:	8b 55 f0             	mov    -0x10(%rbp),%edx
   417e8:	ee                   	out    %al,(%dx)
}
   417e9:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   417ea:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   417ee:	66 c1 e8 08          	shr    $0x8,%ax
   417f2:	0f b6 c0             	movzbl %al,%eax
   417f5:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   417fc:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   417ff:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   41803:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41806:	ee                   	out    %al,(%dx)
}
   41807:	90                   	nop
}
   41808:	90                   	nop
   41809:	c9                   	leave  
   4180a:	c3                   	ret    

000000000004180b <interrupt_init>:

void interrupt_init(void) {
   4180b:	55                   	push   %rbp
   4180c:	48 89 e5             	mov    %rsp,%rbp
   4180f:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   41813:	66 c7 05 e4 1a 01 00 	movw   $0x0,0x11ae4(%rip)        # 53300 <interrupts_enabled>
   4181a:	00 00 
    interrupt_mask();
   4181c:	e8 9a ff ff ff       	call   417bb <interrupt_mask>
   41821:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   41828:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4182c:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   41830:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   41833:	ee                   	out    %al,(%dx)
}
   41834:	90                   	nop
   41835:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   4183c:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41840:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   41844:	8b 55 ac             	mov    -0x54(%rbp),%edx
   41847:	ee                   	out    %al,(%dx)
}
   41848:	90                   	nop
   41849:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   41850:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41854:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   41858:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   4185b:	ee                   	out    %al,(%dx)
}
   4185c:	90                   	nop
   4185d:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   41864:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41868:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   4186c:	8b 55 bc             	mov    -0x44(%rbp),%edx
   4186f:	ee                   	out    %al,(%dx)
}
   41870:	90                   	nop
   41871:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   41878:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4187c:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   41880:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   41883:	ee                   	out    %al,(%dx)
}
   41884:	90                   	nop
   41885:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   4188c:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41890:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   41894:	8b 55 cc             	mov    -0x34(%rbp),%edx
   41897:	ee                   	out    %al,(%dx)
}
   41898:	90                   	nop
   41899:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   418a0:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   418a4:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   418a8:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   418ab:	ee                   	out    %al,(%dx)
}
   418ac:	90                   	nop
   418ad:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   418b4:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   418b8:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   418bc:	8b 55 dc             	mov    -0x24(%rbp),%edx
   418bf:	ee                   	out    %al,(%dx)
}
   418c0:	90                   	nop
   418c1:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   418c8:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   418cc:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   418d0:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   418d3:	ee                   	out    %al,(%dx)
}
   418d4:	90                   	nop
   418d5:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   418dc:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   418e0:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   418e4:	8b 55 ec             	mov    -0x14(%rbp),%edx
   418e7:	ee                   	out    %al,(%dx)
}
   418e8:	90                   	nop
   418e9:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   418f0:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   418f4:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   418f8:	8b 55 f4             	mov    -0xc(%rbp),%edx
   418fb:	ee                   	out    %al,(%dx)
}
   418fc:	90                   	nop
   418fd:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   41904:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41908:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4190c:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4190f:	ee                   	out    %al,(%dx)
}
   41910:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   41911:	e8 a5 fe ff ff       	call   417bb <interrupt_mask>
}
   41916:	90                   	nop
   41917:	c9                   	leave  
   41918:	c3                   	ret    

0000000000041919 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   41919:	55                   	push   %rbp
   4191a:	48 89 e5             	mov    %rsp,%rbp
   4191d:	48 83 ec 28          	sub    $0x28,%rsp
   41921:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   41924:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41928:	0f 8e 9e 00 00 00    	jle    419cc <timer_init+0xb3>
   4192e:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   41935:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41939:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   4193d:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41940:	ee                   	out    %al,(%dx)
}
   41941:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   41942:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41945:	89 c2                	mov    %eax,%edx
   41947:	c1 ea 1f             	shr    $0x1f,%edx
   4194a:	01 d0                	add    %edx,%eax
   4194c:	d1 f8                	sar    %eax
   4194e:	05 de 34 12 00       	add    $0x1234de,%eax
   41953:	99                   	cltd   
   41954:	f7 7d dc             	idivl  -0x24(%rbp)
   41957:	89 c2                	mov    %eax,%edx
   41959:	89 d0                	mov    %edx,%eax
   4195b:	c1 f8 1f             	sar    $0x1f,%eax
   4195e:	c1 e8 18             	shr    $0x18,%eax
   41961:	01 c2                	add    %eax,%edx
   41963:	0f b6 d2             	movzbl %dl,%edx
   41966:	29 c2                	sub    %eax,%edx
   41968:	89 d0                	mov    %edx,%eax
   4196a:	0f b6 c0             	movzbl %al,%eax
   4196d:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   41974:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41977:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   4197b:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4197e:	ee                   	out    %al,(%dx)
}
   4197f:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   41980:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41983:	89 c2                	mov    %eax,%edx
   41985:	c1 ea 1f             	shr    $0x1f,%edx
   41988:	01 d0                	add    %edx,%eax
   4198a:	d1 f8                	sar    %eax
   4198c:	05 de 34 12 00       	add    $0x1234de,%eax
   41991:	99                   	cltd   
   41992:	f7 7d dc             	idivl  -0x24(%rbp)
   41995:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   4199b:	85 c0                	test   %eax,%eax
   4199d:	0f 48 c2             	cmovs  %edx,%eax
   419a0:	c1 f8 08             	sar    $0x8,%eax
   419a3:	0f b6 c0             	movzbl %al,%eax
   419a6:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   419ad:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   419b0:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   419b4:	8b 55 fc             	mov    -0x4(%rbp),%edx
   419b7:	ee                   	out    %al,(%dx)
}
   419b8:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   419b9:	0f b7 05 40 19 01 00 	movzwl 0x11940(%rip),%eax        # 53300 <interrupts_enabled>
   419c0:	83 c8 01             	or     $0x1,%eax
   419c3:	66 89 05 36 19 01 00 	mov    %ax,0x11936(%rip)        # 53300 <interrupts_enabled>
   419ca:	eb 11                	jmp    419dd <timer_init+0xc4>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   419cc:	0f b7 05 2d 19 01 00 	movzwl 0x1192d(%rip),%eax        # 53300 <interrupts_enabled>
   419d3:	83 e0 fe             	and    $0xfffffffe,%eax
   419d6:	66 89 05 23 19 01 00 	mov    %ax,0x11923(%rip)        # 53300 <interrupts_enabled>
    }
    interrupt_mask();
   419dd:	e8 d9 fd ff ff       	call   417bb <interrupt_mask>
}
   419e2:	90                   	nop
   419e3:	c9                   	leave  
   419e4:	c3                   	ret    

00000000000419e5 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   419e5:	55                   	push   %rbp
   419e6:	48 89 e5             	mov    %rsp,%rbp
   419e9:	48 83 ec 08          	sub    $0x8,%rsp
   419ed:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   419f1:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   419f6:	74 14                	je     41a0c <physical_memory_isreserved+0x27>
   419f8:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   419ff:	00 
   41a00:	76 11                	jbe    41a13 <physical_memory_isreserved+0x2e>
   41a02:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   41a09:	00 
   41a0a:	77 07                	ja     41a13 <physical_memory_isreserved+0x2e>
   41a0c:	b8 01 00 00 00       	mov    $0x1,%eax
   41a11:	eb 05                	jmp    41a18 <physical_memory_isreserved+0x33>
   41a13:	b8 00 00 00 00       	mov    $0x0,%eax
}
   41a18:	c9                   	leave  
   41a19:	c3                   	ret    

0000000000041a1a <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   41a1a:	55                   	push   %rbp
   41a1b:	48 89 e5             	mov    %rsp,%rbp
   41a1e:	48 83 ec 10          	sub    $0x10,%rsp
   41a22:	89 7d fc             	mov    %edi,-0x4(%rbp)
   41a25:	89 75 f8             	mov    %esi,-0x8(%rbp)
   41a28:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   41a2b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41a2e:	c1 e0 10             	shl    $0x10,%eax
   41a31:	89 c2                	mov    %eax,%edx
   41a33:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41a36:	c1 e0 0b             	shl    $0xb,%eax
   41a39:	09 c2                	or     %eax,%edx
   41a3b:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41a3e:	c1 e0 08             	shl    $0x8,%eax
   41a41:	09 d0                	or     %edx,%eax
}
   41a43:	c9                   	leave  
   41a44:	c3                   	ret    

0000000000041a45 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   41a45:	55                   	push   %rbp
   41a46:	48 89 e5             	mov    %rsp,%rbp
   41a49:	48 83 ec 18          	sub    $0x18,%rsp
   41a4d:	89 7d ec             	mov    %edi,-0x14(%rbp)
   41a50:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   41a53:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41a56:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41a59:	09 d0                	or     %edx,%eax
   41a5b:	0d 00 00 00 80       	or     $0x80000000,%eax
   41a60:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   41a67:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   41a6a:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41a6d:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41a70:	ef                   	out    %eax,(%dx)
}
   41a71:	90                   	nop
   41a72:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   41a79:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41a7c:	89 c2                	mov    %eax,%edx
   41a7e:	ed                   	in     (%dx),%eax
   41a7f:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   41a82:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   41a85:	c9                   	leave  
   41a86:	c3                   	ret    

0000000000041a87 <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   41a87:	55                   	push   %rbp
   41a88:	48 89 e5             	mov    %rsp,%rbp
   41a8b:	48 83 ec 28          	sub    $0x28,%rsp
   41a8f:	89 7d dc             	mov    %edi,-0x24(%rbp)
   41a92:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   41a95:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41a9c:	eb 73                	jmp    41b11 <pci_find_device+0x8a>
        for (int slot = 0; slot != 32; ++slot) {
   41a9e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41aa5:	eb 60                	jmp    41b07 <pci_find_device+0x80>
            for (int func = 0; func != 8; ++func) {
   41aa7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41aae:	eb 4a                	jmp    41afa <pci_find_device+0x73>
                int configaddr = pci_make_configaddr(bus, slot, func);
   41ab0:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41ab3:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41ab6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41ab9:	89 ce                	mov    %ecx,%esi
   41abb:	89 c7                	mov    %eax,%edi
   41abd:	e8 58 ff ff ff       	call   41a1a <pci_make_configaddr>
   41ac2:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   41ac5:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41ac8:	be 00 00 00 00       	mov    $0x0,%esi
   41acd:	89 c7                	mov    %eax,%edi
   41acf:	e8 71 ff ff ff       	call   41a45 <pci_config_readl>
   41ad4:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   41ad7:	8b 45 d8             	mov    -0x28(%rbp),%eax
   41ada:	c1 e0 10             	shl    $0x10,%eax
   41add:	0b 45 dc             	or     -0x24(%rbp),%eax
   41ae0:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   41ae3:	75 05                	jne    41aea <pci_find_device+0x63>
                    return configaddr;
   41ae5:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41ae8:	eb 35                	jmp    41b1f <pci_find_device+0x98>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   41aea:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   41aee:	75 06                	jne    41af6 <pci_find_device+0x6f>
   41af0:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41af4:	74 0c                	je     41b02 <pci_find_device+0x7b>
            for (int func = 0; func != 8; ++func) {
   41af6:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41afa:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   41afe:	75 b0                	jne    41ab0 <pci_find_device+0x29>
   41b00:	eb 01                	jmp    41b03 <pci_find_device+0x7c>
                    break;
   41b02:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   41b03:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41b07:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   41b0b:	75 9a                	jne    41aa7 <pci_find_device+0x20>
    for (int bus = 0; bus != 256; ++bus) {
   41b0d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41b11:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   41b18:	75 84                	jne    41a9e <pci_find_device+0x17>
                }
            }
        }
    }
    return -1;
   41b1a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   41b1f:	c9                   	leave  
   41b20:	c3                   	ret    

0000000000041b21 <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   41b21:	55                   	push   %rbp
   41b22:	48 89 e5             	mov    %rsp,%rbp
   41b25:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   41b29:	be 13 71 00 00       	mov    $0x7113,%esi
   41b2e:	bf 86 80 00 00       	mov    $0x8086,%edi
   41b33:	e8 4f ff ff ff       	call   41a87 <pci_find_device>
   41b38:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   41b3b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   41b3f:	78 30                	js     41b71 <poweroff+0x50>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   41b41:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41b44:	be 40 00 00 00       	mov    $0x40,%esi
   41b49:	89 c7                	mov    %eax,%edi
   41b4b:	e8 f5 fe ff ff       	call   41a45 <pci_config_readl>
   41b50:	25 c0 ff 00 00       	and    $0xffc0,%eax
   41b55:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   41b58:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41b5b:	83 c0 04             	add    $0x4,%eax
   41b5e:	89 45 f4             	mov    %eax,-0xc(%rbp)
   41b61:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   41b67:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   41b6b:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41b6e:	66 ef                	out    %ax,(%dx)
}
   41b70:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   41b71:	ba 60 42 04 00       	mov    $0x44260,%edx
   41b76:	be 00 c0 00 00       	mov    $0xc000,%esi
   41b7b:	bf 80 07 00 00       	mov    $0x780,%edi
   41b80:	b8 00 00 00 00       	mov    $0x0,%eax
   41b85:	e8 fc 20 00 00       	call   43c86 <console_printf>
 spinloop: goto spinloop;
   41b8a:	eb fe                	jmp    41b8a <poweroff+0x69>

0000000000041b8c <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   41b8c:	55                   	push   %rbp
   41b8d:	48 89 e5             	mov    %rsp,%rbp
   41b90:	48 83 ec 10          	sub    $0x10,%rsp
   41b94:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   41b9b:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b9f:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41ba3:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41ba6:	ee                   	out    %al,(%dx)
}
   41ba7:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   41ba8:	eb fe                	jmp    41ba8 <reboot+0x1c>

0000000000041baa <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   41baa:	55                   	push   %rbp
   41bab:	48 89 e5             	mov    %rsp,%rbp
   41bae:	48 83 ec 10          	sub    $0x10,%rsp
   41bb2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41bb6:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   41bb9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41bbd:	48 83 c0 08          	add    $0x8,%rax
   41bc1:	ba c0 00 00 00       	mov    $0xc0,%edx
   41bc6:	be 00 00 00 00       	mov    $0x0,%esi
   41bcb:	48 89 c7             	mov    %rax,%rdi
   41bce:	e8 fc 12 00 00       	call   42ecf <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   41bd3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41bd7:	66 c7 80 a8 00 00 00 	movw   $0x13,0xa8(%rax)
   41bde:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   41be0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41be4:	48 c7 80 80 00 00 00 	movq   $0x23,0x80(%rax)
   41beb:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   41bef:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41bf3:	48 c7 80 88 00 00 00 	movq   $0x23,0x88(%rax)
   41bfa:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   41bfe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41c02:	66 c7 80 c0 00 00 00 	movw   $0x23,0xc0(%rax)
   41c09:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   41c0b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41c0f:	48 c7 80 b0 00 00 00 	movq   $0x200,0xb0(%rax)
   41c16:	00 02 00 00 
    p->display_status = 1;
   41c1a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41c1e:	c6 80 d8 00 00 00 01 	movb   $0x1,0xd8(%rax)

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   41c25:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41c28:	83 e0 01             	and    $0x1,%eax
   41c2b:	85 c0                	test   %eax,%eax
   41c2d:	74 1c                	je     41c4b <process_init+0xa1>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   41c2f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41c33:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   41c3a:	80 cc 30             	or     $0x30,%ah
   41c3d:	48 89 c2             	mov    %rax,%rdx
   41c40:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41c44:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   41c4b:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41c4e:	83 e0 02             	and    $0x2,%eax
   41c51:	85 c0                	test   %eax,%eax
   41c53:	74 1c                	je     41c71 <process_init+0xc7>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   41c55:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41c59:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   41c60:	80 e4 fd             	and    $0xfd,%ah
   41c63:	48 89 c2             	mov    %rax,%rdx
   41c66:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41c6a:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
}
   41c71:	90                   	nop
   41c72:	c9                   	leave  
   41c73:	c3                   	ret    

0000000000041c74 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   41c74:	55                   	push   %rbp
   41c75:	48 89 e5             	mov    %rsp,%rbp
   41c78:	48 83 ec 28          	sub    $0x28,%rsp
   41c7c:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   41c7f:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41c83:	78 09                	js     41c8e <console_show_cursor+0x1a>
   41c85:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   41c8c:	7e 07                	jle    41c95 <console_show_cursor+0x21>
        cpos = 0;
   41c8e:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   41c95:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   41c9c:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ca0:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41ca4:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41ca7:	ee                   	out    %al,(%dx)
}
   41ca8:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   41ca9:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41cac:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41cb2:	85 c0                	test   %eax,%eax
   41cb4:	0f 48 c2             	cmovs  %edx,%eax
   41cb7:	c1 f8 08             	sar    $0x8,%eax
   41cba:	0f b6 c0             	movzbl %al,%eax
   41cbd:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   41cc4:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41cc7:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41ccb:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41cce:	ee                   	out    %al,(%dx)
}
   41ccf:	90                   	nop
   41cd0:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   41cd7:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41cdb:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41cdf:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41ce2:	ee                   	out    %al,(%dx)
}
   41ce3:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   41ce4:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41ce7:	89 d0                	mov    %edx,%eax
   41ce9:	c1 f8 1f             	sar    $0x1f,%eax
   41cec:	c1 e8 18             	shr    $0x18,%eax
   41cef:	01 c2                	add    %eax,%edx
   41cf1:	0f b6 d2             	movzbl %dl,%edx
   41cf4:	29 c2                	sub    %eax,%edx
   41cf6:	89 d0                	mov    %edx,%eax
   41cf8:	0f b6 c0             	movzbl %al,%eax
   41cfb:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   41d02:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d05:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41d09:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41d0c:	ee                   	out    %al,(%dx)
}
   41d0d:	90                   	nop
}
   41d0e:	90                   	nop
   41d0f:	c9                   	leave  
   41d10:	c3                   	ret    

0000000000041d11 <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   41d11:	55                   	push   %rbp
   41d12:	48 89 e5             	mov    %rsp,%rbp
   41d15:	48 83 ec 20          	sub    $0x20,%rsp
   41d19:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41d20:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41d23:	89 c2                	mov    %eax,%edx
   41d25:	ec                   	in     (%dx),%al
   41d26:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   41d29:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   41d2d:	0f b6 c0             	movzbl %al,%eax
   41d30:	83 e0 01             	and    $0x1,%eax
   41d33:	85 c0                	test   %eax,%eax
   41d35:	75 0a                	jne    41d41 <keyboard_readc+0x30>
        return -1;
   41d37:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   41d3c:	e9 e7 01 00 00       	jmp    41f28 <keyboard_readc+0x217>
   41d41:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41d48:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41d4b:	89 c2                	mov    %eax,%edx
   41d4d:	ec                   	in     (%dx),%al
   41d4e:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   41d51:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   41d55:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   41d58:	0f b6 05 a3 15 01 00 	movzbl 0x115a3(%rip),%eax        # 53302 <last_escape.2>
   41d5f:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   41d62:	c6 05 99 15 01 00 00 	movb   $0x0,0x11599(%rip)        # 53302 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   41d69:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   41d6d:	75 11                	jne    41d80 <keyboard_readc+0x6f>
        last_escape = 0x80;
   41d6f:	c6 05 8c 15 01 00 80 	movb   $0x80,0x1158c(%rip)        # 53302 <last_escape.2>
        return 0;
   41d76:	b8 00 00 00 00       	mov    $0x0,%eax
   41d7b:	e9 a8 01 00 00       	jmp    41f28 <keyboard_readc+0x217>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   41d80:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41d84:	84 c0                	test   %al,%al
   41d86:	79 60                	jns    41de8 <keyboard_readc+0xd7>
        int ch = keymap[(data & 0x7F) | escape];
   41d88:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41d8c:	83 e0 7f             	and    $0x7f,%eax
   41d8f:	89 c2                	mov    %eax,%edx
   41d91:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   41d95:	09 d0                	or     %edx,%eax
   41d97:	48 98                	cltq   
   41d99:	0f b6 80 80 42 04 00 	movzbl 0x44280(%rax),%eax
   41da0:	0f b6 c0             	movzbl %al,%eax
   41da3:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   41da6:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   41dad:	7e 2f                	jle    41dde <keyboard_readc+0xcd>
   41daf:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   41db6:	7f 26                	jg     41dde <keyboard_readc+0xcd>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   41db8:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41dbb:	2d fa 00 00 00       	sub    $0xfa,%eax
   41dc0:	ba 01 00 00 00       	mov    $0x1,%edx
   41dc5:	89 c1                	mov    %eax,%ecx
   41dc7:	d3 e2                	shl    %cl,%edx
   41dc9:	89 d0                	mov    %edx,%eax
   41dcb:	f7 d0                	not    %eax
   41dcd:	89 c2                	mov    %eax,%edx
   41dcf:	0f b6 05 2d 15 01 00 	movzbl 0x1152d(%rip),%eax        # 53303 <modifiers.1>
   41dd6:	21 d0                	and    %edx,%eax
   41dd8:	88 05 25 15 01 00    	mov    %al,0x11525(%rip)        # 53303 <modifiers.1>
        }
        return 0;
   41dde:	b8 00 00 00 00       	mov    $0x0,%eax
   41de3:	e9 40 01 00 00       	jmp    41f28 <keyboard_readc+0x217>
    }

    int ch = (unsigned char) keymap[data | escape];
   41de8:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41dec:	0a 45 fa             	or     -0x6(%rbp),%al
   41def:	0f b6 c0             	movzbl %al,%eax
   41df2:	48 98                	cltq   
   41df4:	0f b6 80 80 42 04 00 	movzbl 0x44280(%rax),%eax
   41dfb:	0f b6 c0             	movzbl %al,%eax
   41dfe:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   41e01:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   41e05:	7e 57                	jle    41e5e <keyboard_readc+0x14d>
   41e07:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   41e0b:	7f 51                	jg     41e5e <keyboard_readc+0x14d>
        if (modifiers & MOD_CONTROL) {
   41e0d:	0f b6 05 ef 14 01 00 	movzbl 0x114ef(%rip),%eax        # 53303 <modifiers.1>
   41e14:	0f b6 c0             	movzbl %al,%eax
   41e17:	83 e0 02             	and    $0x2,%eax
   41e1a:	85 c0                	test   %eax,%eax
   41e1c:	74 09                	je     41e27 <keyboard_readc+0x116>
            ch -= 0x60;
   41e1e:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   41e22:	e9 fd 00 00 00       	jmp    41f24 <keyboard_readc+0x213>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   41e27:	0f b6 05 d5 14 01 00 	movzbl 0x114d5(%rip),%eax        # 53303 <modifiers.1>
   41e2e:	0f b6 c0             	movzbl %al,%eax
   41e31:	83 e0 01             	and    $0x1,%eax
   41e34:	85 c0                	test   %eax,%eax
   41e36:	0f 94 c2             	sete   %dl
   41e39:	0f b6 05 c3 14 01 00 	movzbl 0x114c3(%rip),%eax        # 53303 <modifiers.1>
   41e40:	0f b6 c0             	movzbl %al,%eax
   41e43:	83 e0 08             	and    $0x8,%eax
   41e46:	85 c0                	test   %eax,%eax
   41e48:	0f 94 c0             	sete   %al
   41e4b:	31 d0                	xor    %edx,%eax
   41e4d:	84 c0                	test   %al,%al
   41e4f:	0f 84 cf 00 00 00    	je     41f24 <keyboard_readc+0x213>
            ch -= 0x20;
   41e55:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   41e59:	e9 c6 00 00 00       	jmp    41f24 <keyboard_readc+0x213>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   41e5e:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   41e65:	7e 30                	jle    41e97 <keyboard_readc+0x186>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   41e67:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41e6a:	2d fa 00 00 00       	sub    $0xfa,%eax
   41e6f:	ba 01 00 00 00       	mov    $0x1,%edx
   41e74:	89 c1                	mov    %eax,%ecx
   41e76:	d3 e2                	shl    %cl,%edx
   41e78:	89 d0                	mov    %edx,%eax
   41e7a:	89 c2                	mov    %eax,%edx
   41e7c:	0f b6 05 80 14 01 00 	movzbl 0x11480(%rip),%eax        # 53303 <modifiers.1>
   41e83:	31 d0                	xor    %edx,%eax
   41e85:	88 05 78 14 01 00    	mov    %al,0x11478(%rip)        # 53303 <modifiers.1>
        ch = 0;
   41e8b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41e92:	e9 8e 00 00 00       	jmp    41f25 <keyboard_readc+0x214>
    } else if (ch >= KEY_SHIFT) {
   41e97:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   41e9e:	7e 2d                	jle    41ecd <keyboard_readc+0x1bc>
        modifiers |= 1 << (ch - KEY_SHIFT);
   41ea0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41ea3:	2d fa 00 00 00       	sub    $0xfa,%eax
   41ea8:	ba 01 00 00 00       	mov    $0x1,%edx
   41ead:	89 c1                	mov    %eax,%ecx
   41eaf:	d3 e2                	shl    %cl,%edx
   41eb1:	89 d0                	mov    %edx,%eax
   41eb3:	89 c2                	mov    %eax,%edx
   41eb5:	0f b6 05 47 14 01 00 	movzbl 0x11447(%rip),%eax        # 53303 <modifiers.1>
   41ebc:	09 d0                	or     %edx,%eax
   41ebe:	88 05 3f 14 01 00    	mov    %al,0x1143f(%rip)        # 53303 <modifiers.1>
        ch = 0;
   41ec4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41ecb:	eb 58                	jmp    41f25 <keyboard_readc+0x214>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   41ecd:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   41ed1:	7e 31                	jle    41f04 <keyboard_readc+0x1f3>
   41ed3:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   41eda:	7f 28                	jg     41f04 <keyboard_readc+0x1f3>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   41edc:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41edf:	8d 50 80             	lea    -0x80(%rax),%edx
   41ee2:	0f b6 05 1a 14 01 00 	movzbl 0x1141a(%rip),%eax        # 53303 <modifiers.1>
   41ee9:	0f b6 c0             	movzbl %al,%eax
   41eec:	83 e0 03             	and    $0x3,%eax
   41eef:	48 98                	cltq   
   41ef1:	48 63 d2             	movslq %edx,%rdx
   41ef4:	0f b6 84 90 80 43 04 	movzbl 0x44380(%rax,%rdx,4),%eax
   41efb:	00 
   41efc:	0f b6 c0             	movzbl %al,%eax
   41eff:	89 45 fc             	mov    %eax,-0x4(%rbp)
   41f02:	eb 21                	jmp    41f25 <keyboard_readc+0x214>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   41f04:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   41f08:	7f 1b                	jg     41f25 <keyboard_readc+0x214>
   41f0a:	0f b6 05 f2 13 01 00 	movzbl 0x113f2(%rip),%eax        # 53303 <modifiers.1>
   41f11:	0f b6 c0             	movzbl %al,%eax
   41f14:	83 e0 02             	and    $0x2,%eax
   41f17:	85 c0                	test   %eax,%eax
   41f19:	74 0a                	je     41f25 <keyboard_readc+0x214>
        ch = 0;
   41f1b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41f22:	eb 01                	jmp    41f25 <keyboard_readc+0x214>
        if (modifiers & MOD_CONTROL) {
   41f24:	90                   	nop
    }

    return ch;
   41f25:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   41f28:	c9                   	leave  
   41f29:	c3                   	ret    

0000000000041f2a <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   41f2a:	55                   	push   %rbp
   41f2b:	48 89 e5             	mov    %rsp,%rbp
   41f2e:	48 83 ec 20          	sub    $0x20,%rsp
   41f32:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41f39:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   41f3c:	89 c2                	mov    %eax,%edx
   41f3e:	ec                   	in     (%dx),%al
   41f3f:	88 45 e3             	mov    %al,-0x1d(%rbp)
   41f42:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   41f49:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41f4c:	89 c2                	mov    %eax,%edx
   41f4e:	ec                   	in     (%dx),%al
   41f4f:	88 45 eb             	mov    %al,-0x15(%rbp)
   41f52:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   41f59:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41f5c:	89 c2                	mov    %eax,%edx
   41f5e:	ec                   	in     (%dx),%al
   41f5f:	88 45 f3             	mov    %al,-0xd(%rbp)
   41f62:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   41f69:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41f6c:	89 c2                	mov    %eax,%edx
   41f6e:	ec                   	in     (%dx),%al
   41f6f:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   41f72:	90                   	nop
   41f73:	c9                   	leave  
   41f74:	c3                   	ret    

0000000000041f75 <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   41f75:	55                   	push   %rbp
   41f76:	48 89 e5             	mov    %rsp,%rbp
   41f79:	48 83 ec 40          	sub    $0x40,%rsp
   41f7d:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   41f81:	89 f0                	mov    %esi,%eax
   41f83:	89 55 c0             	mov    %edx,-0x40(%rbp)
   41f86:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   41f89:	8b 05 75 13 01 00    	mov    0x11375(%rip),%eax        # 53304 <initialized.0>
   41f8f:	85 c0                	test   %eax,%eax
   41f91:	75 1e                	jne    41fb1 <parallel_port_putc+0x3c>
   41f93:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   41f9a:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f9e:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   41fa2:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41fa5:	ee                   	out    %al,(%dx)
}
   41fa6:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   41fa7:	c7 05 53 13 01 00 01 	movl   $0x1,0x11353(%rip)        # 53304 <initialized.0>
   41fae:	00 00 00 
    }

    for (int i = 0;
   41fb1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41fb8:	eb 09                	jmp    41fc3 <parallel_port_putc+0x4e>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   41fba:	e8 6b ff ff ff       	call   41f2a <delay>
         ++i) {
   41fbf:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   41fc3:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   41fca:	7f 18                	jg     41fe4 <parallel_port_putc+0x6f>
   41fcc:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41fd3:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41fd6:	89 c2                	mov    %eax,%edx
   41fd8:	ec                   	in     (%dx),%al
   41fd9:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   41fdc:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   41fe0:	84 c0                	test   %al,%al
   41fe2:	79 d6                	jns    41fba <parallel_port_putc+0x45>
    }
    outb(IO_PARALLEL1_DATA, c);
   41fe4:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   41fe8:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   41fef:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ff2:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   41ff6:	8b 55 d8             	mov    -0x28(%rbp),%edx
   41ff9:	ee                   	out    %al,(%dx)
}
   41ffa:	90                   	nop
   41ffb:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   42002:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42006:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   4200a:	8b 55 e0             	mov    -0x20(%rbp),%edx
   4200d:	ee                   	out    %al,(%dx)
}
   4200e:	90                   	nop
   4200f:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   42016:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4201a:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   4201e:	8b 55 e8             	mov    -0x18(%rbp),%edx
   42021:	ee                   	out    %al,(%dx)
}
   42022:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   42023:	90                   	nop
   42024:	c9                   	leave  
   42025:	c3                   	ret    

0000000000042026 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   42026:	55                   	push   %rbp
   42027:	48 89 e5             	mov    %rsp,%rbp
   4202a:	48 83 ec 20          	sub    $0x20,%rsp
   4202e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42032:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   42036:	48 c7 45 f8 75 1f 04 	movq   $0x41f75,-0x8(%rbp)
   4203d:	00 
    printer_vprintf(&p, 0, format, val);
   4203e:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   42042:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   42046:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   4204a:	be 00 00 00 00       	mov    $0x0,%esi
   4204f:	48 89 c7             	mov    %rax,%rdi
   42052:	e8 14 11 00 00       	call   4316b <printer_vprintf>
}
   42057:	90                   	nop
   42058:	c9                   	leave  
   42059:	c3                   	ret    

000000000004205a <log_printf>:

void log_printf(const char* format, ...) {
   4205a:	55                   	push   %rbp
   4205b:	48 89 e5             	mov    %rsp,%rbp
   4205e:	48 83 ec 60          	sub    $0x60,%rsp
   42062:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42066:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   4206a:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   4206e:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42072:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42076:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   4207a:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   42081:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42085:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42089:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4208d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   42091:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   42095:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42099:	48 89 d6             	mov    %rdx,%rsi
   4209c:	48 89 c7             	mov    %rax,%rdi
   4209f:	e8 82 ff ff ff       	call   42026 <log_vprintf>
    va_end(val);
}
   420a4:	90                   	nop
   420a5:	c9                   	leave  
   420a6:	c3                   	ret    

00000000000420a7 <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   420a7:	55                   	push   %rbp
   420a8:	48 89 e5             	mov    %rsp,%rbp
   420ab:	48 83 ec 40          	sub    $0x40,%rsp
   420af:	89 7d dc             	mov    %edi,-0x24(%rbp)
   420b2:	89 75 d8             	mov    %esi,-0x28(%rbp)
   420b5:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   420b9:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   420bd:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   420c1:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   420c5:	48 8b 0a             	mov    (%rdx),%rcx
   420c8:	48 89 08             	mov    %rcx,(%rax)
   420cb:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   420cf:	48 89 48 08          	mov    %rcx,0x8(%rax)
   420d3:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   420d7:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   420db:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   420df:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   420e3:	48 89 d6             	mov    %rdx,%rsi
   420e6:	48 89 c7             	mov    %rax,%rdi
   420e9:	e8 38 ff ff ff       	call   42026 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   420ee:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   420f2:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   420f6:	8b 75 d8             	mov    -0x28(%rbp),%esi
   420f9:	8b 45 dc             	mov    -0x24(%rbp),%eax
   420fc:	89 c7                	mov    %eax,%edi
   420fe:	e8 17 1b 00 00       	call   43c1a <console_vprintf>
}
   42103:	c9                   	leave  
   42104:	c3                   	ret    

0000000000042105 <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   42105:	55                   	push   %rbp
   42106:	48 89 e5             	mov    %rsp,%rbp
   42109:	48 83 ec 60          	sub    $0x60,%rsp
   4210d:	89 7d ac             	mov    %edi,-0x54(%rbp)
   42110:	89 75 a8             	mov    %esi,-0x58(%rbp)
   42113:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   42117:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4211b:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4211f:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42123:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   4212a:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4212e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42132:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42136:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   4213a:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   4213e:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   42142:	8b 75 a8             	mov    -0x58(%rbp),%esi
   42145:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42148:	89 c7                	mov    %eax,%edi
   4214a:	e8 58 ff ff ff       	call   420a7 <error_vprintf>
   4214f:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   42152:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   42155:	c9                   	leave  
   42156:	c3                   	ret    

0000000000042157 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'f', and 'e' cause a soft
//    reboot where the kernel runs the allocator programs, "fork", or
//    "forkexit", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   42157:	55                   	push   %rbp
   42158:	48 89 e5             	mov    %rsp,%rbp
   4215b:	53                   	push   %rbx
   4215c:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   42160:	e8 ac fb ff ff       	call   41d11 <keyboard_readc>
   42165:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   42168:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   4216c:	74 1c                	je     4218a <check_keyboard+0x33>
   4216e:	83 7d e4 66          	cmpl   $0x66,-0x1c(%rbp)
   42172:	74 16                	je     4218a <check_keyboard+0x33>
   42174:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42178:	74 10                	je     4218a <check_keyboard+0x33>
   4217a:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   4217e:	74 0a                	je     4218a <check_keyboard+0x33>
   42180:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42184:	0f 85 e9 00 00 00    	jne    42273 <check_keyboard+0x11c>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   4218a:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   42191:	00 
        memset(pt, 0, PAGESIZE * 3);
   42192:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42196:	ba 00 30 00 00       	mov    $0x3000,%edx
   4219b:	be 00 00 00 00       	mov    $0x0,%esi
   421a0:	48 89 c7             	mov    %rax,%rdi
   421a3:	e8 27 0d 00 00       	call   42ecf <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   421a8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   421ac:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   421b3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   421b7:	48 05 00 10 00 00    	add    $0x1000,%rax
   421bd:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   421c4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   421c8:	48 05 00 20 00 00    	add    $0x2000,%rax
   421ce:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   421d5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   421d9:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   421dd:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   421e1:	0f 22 d8             	mov    %rax,%cr3
}
   421e4:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   421e5:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "fork";
   421ec:	48 c7 45 e8 d8 43 04 	movq   $0x443d8,-0x18(%rbp)
   421f3:	00 
        if (c == 'a') {
   421f4:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   421f8:	75 0a                	jne    42204 <check_keyboard+0xad>
            argument = "allocator";
   421fa:	48 c7 45 e8 dd 43 04 	movq   $0x443dd,-0x18(%rbp)
   42201:	00 
   42202:	eb 2e                	jmp    42232 <check_keyboard+0xdb>
        } else if (c == 'e') {
   42204:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42208:	75 0a                	jne    42214 <check_keyboard+0xbd>
            argument = "forkexit";
   4220a:	48 c7 45 e8 e7 43 04 	movq   $0x443e7,-0x18(%rbp)
   42211:	00 
   42212:	eb 1e                	jmp    42232 <check_keyboard+0xdb>
        }
        else if (c == 't'){
   42214:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42218:	75 0a                	jne    42224 <check_keyboard+0xcd>
            argument = "test";
   4221a:	48 c7 45 e8 f0 43 04 	movq   $0x443f0,-0x18(%rbp)
   42221:	00 
   42222:	eb 0e                	jmp    42232 <check_keyboard+0xdb>
        }
        else if(c == '2'){
   42224:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42228:	75 08                	jne    42232 <check_keyboard+0xdb>
            argument = "test2";
   4222a:	48 c7 45 e8 f5 43 04 	movq   $0x443f5,-0x18(%rbp)
   42231:	00 
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   42232:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42236:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   4223a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4223f:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   42243:	73 14                	jae    42259 <check_keyboard+0x102>
   42245:	ba fb 43 04 00       	mov    $0x443fb,%edx
   4224a:	be 5d 02 00 00       	mov    $0x25d,%esi
   4224f:	bf 17 44 04 00       	mov    $0x44417,%edi
   42254:	e8 1f 01 00 00       	call   42378 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   42259:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4225d:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   42260:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   42264:	48 89 c3             	mov    %rax,%rbx
   42267:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   4226c:	e9 8f dd ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   42271:	eb 11                	jmp    42284 <check_keyboard+0x12d>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   42273:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   42277:	74 06                	je     4227f <check_keyboard+0x128>
   42279:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   4227d:	75 05                	jne    42284 <check_keyboard+0x12d>
        poweroff();
   4227f:	e8 9d f8 ff ff       	call   41b21 <poweroff>
    }
    return c;
   42284:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   42287:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   4228b:	c9                   	leave  
   4228c:	c3                   	ret    

000000000004228d <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   4228d:	55                   	push   %rbp
   4228e:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   42291:	e8 c1 fe ff ff       	call   42157 <check_keyboard>
   42296:	eb f9                	jmp    42291 <fail+0x4>

0000000000042298 <panic>:

// panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void panic(const char* format, ...) {
   42298:	55                   	push   %rbp
   42299:	48 89 e5             	mov    %rsp,%rbp
   4229c:	48 83 ec 60          	sub    $0x60,%rsp
   422a0:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   422a4:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   422a8:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   422ac:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   422b0:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   422b4:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   422b8:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   422bf:	48 8d 45 10          	lea    0x10(%rbp),%rax
   422c3:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   422c7:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   422cb:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   422cf:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   422d4:	0f 84 80 00 00 00    	je     4235a <panic+0xc2>
        // Print panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   422da:	ba 2b 44 04 00       	mov    $0x4442b,%edx
   422df:	be 00 c0 00 00       	mov    $0xc000,%esi
   422e4:	bf 30 07 00 00       	mov    $0x730,%edi
   422e9:	b8 00 00 00 00       	mov    $0x0,%eax
   422ee:	e8 12 fe ff ff       	call   42105 <error_printf>
   422f3:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   422f6:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   422fa:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   422fe:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42301:	be 00 c0 00 00       	mov    $0xc000,%esi
   42306:	89 c7                	mov    %eax,%edi
   42308:	e8 9a fd ff ff       	call   420a7 <error_vprintf>
   4230d:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   42310:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   42313:	48 63 c1             	movslq %ecx,%rax
   42316:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   4231d:	48 c1 e8 20          	shr    $0x20,%rax
   42321:	89 c2                	mov    %eax,%edx
   42323:	c1 fa 05             	sar    $0x5,%edx
   42326:	89 c8                	mov    %ecx,%eax
   42328:	c1 f8 1f             	sar    $0x1f,%eax
   4232b:	29 c2                	sub    %eax,%edx
   4232d:	89 d0                	mov    %edx,%eax
   4232f:	c1 e0 02             	shl    $0x2,%eax
   42332:	01 d0                	add    %edx,%eax
   42334:	c1 e0 04             	shl    $0x4,%eax
   42337:	29 c1                	sub    %eax,%ecx
   42339:	89 ca                	mov    %ecx,%edx
   4233b:	85 d2                	test   %edx,%edx
   4233d:	74 34                	je     42373 <panic+0xdb>
            error_printf(cpos, 0xC000, "\n");
   4233f:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42342:	ba 33 44 04 00       	mov    $0x44433,%edx
   42347:	be 00 c0 00 00       	mov    $0xc000,%esi
   4234c:	89 c7                	mov    %eax,%edi
   4234e:	b8 00 00 00 00       	mov    $0x0,%eax
   42353:	e8 ad fd ff ff       	call   42105 <error_printf>
   42358:	eb 19                	jmp    42373 <panic+0xdb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   4235a:	ba 35 44 04 00       	mov    $0x44435,%edx
   4235f:	be 00 c0 00 00       	mov    $0xc000,%esi
   42364:	bf 30 07 00 00       	mov    $0x730,%edi
   42369:	b8 00 00 00 00       	mov    $0x0,%eax
   4236e:	e8 92 fd ff ff       	call   42105 <error_printf>
    }

    va_end(val);
    fail();
   42373:	e8 15 ff ff ff       	call   4228d <fail>

0000000000042378 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   42378:	55                   	push   %rbp
   42379:	48 89 e5             	mov    %rsp,%rbp
   4237c:	48 83 ec 20          	sub    $0x20,%rsp
   42380:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42384:	89 75 f4             	mov    %esi,-0xc(%rbp)
   42387:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   4238b:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   4238f:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42392:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42396:	48 89 c6             	mov    %rax,%rsi
   42399:	bf 3b 44 04 00       	mov    $0x4443b,%edi
   4239e:	b8 00 00 00 00       	mov    $0x0,%eax
   423a3:	e8 f0 fe ff ff       	call   42298 <panic>

00000000000423a8 <default_exception>:
}

void default_exception(proc* p){
   423a8:	55                   	push   %rbp
   423a9:	48 89 e5             	mov    %rsp,%rbp
   423ac:	48 83 ec 20          	sub    $0x20,%rsp
   423b0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   423b4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   423b8:	48 83 c0 08          	add    $0x8,%rax
   423bc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    panic("Unexpected exception %d!\n", reg->reg_intno);
   423c0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   423c4:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   423cb:	48 89 c6             	mov    %rax,%rsi
   423ce:	bf 59 44 04 00       	mov    $0x44459,%edi
   423d3:	b8 00 00 00 00       	mov    $0x0,%eax
   423d8:	e8 bb fe ff ff       	call   42298 <panic>

00000000000423dd <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   423dd:	55                   	push   %rbp
   423de:	48 89 e5             	mov    %rsp,%rbp
   423e1:	48 83 ec 10          	sub    $0x10,%rsp
   423e5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   423e9:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   423ec:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   423f0:	78 06                	js     423f8 <pageindex+0x1b>
   423f2:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   423f6:	7e 14                	jle    4240c <pageindex+0x2f>
   423f8:	ba 78 44 04 00       	mov    $0x44478,%edx
   423fd:	be 1e 00 00 00       	mov    $0x1e,%esi
   42402:	bf 91 44 04 00       	mov    $0x44491,%edi
   42407:	e8 6c ff ff ff       	call   42378 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   4240c:	b8 03 00 00 00       	mov    $0x3,%eax
   42411:	2b 45 f4             	sub    -0xc(%rbp),%eax
   42414:	89 c2                	mov    %eax,%edx
   42416:	89 d0                	mov    %edx,%eax
   42418:	c1 e0 03             	shl    $0x3,%eax
   4241b:	01 d0                	add    %edx,%eax
   4241d:	83 c0 0c             	add    $0xc,%eax
   42420:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42424:	89 c1                	mov    %eax,%ecx
   42426:	48 d3 ea             	shr    %cl,%rdx
   42429:	48 89 d0             	mov    %rdx,%rax
   4242c:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   42431:	c9                   	leave  
   42432:	c3                   	ret    

0000000000042433 <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   42433:	55                   	push   %rbp
   42434:	48 89 e5             	mov    %rsp,%rbp
   42437:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   4243b:	48 c7 05 ba 1b 01 00 	movq   $0x55000,0x11bba(%rip)        # 54000 <kernel_pagetable>
   42442:	00 50 05 00 
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   42446:	ba 00 50 00 00       	mov    $0x5000,%edx
   4244b:	be 00 00 00 00       	mov    $0x0,%esi
   42450:	bf 00 50 05 00       	mov    $0x55000,%edi
   42455:	e8 75 0a 00 00       	call   42ecf <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   4245a:	b8 00 60 05 00       	mov    $0x56000,%eax
   4245f:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   42463:	48 89 05 96 2b 01 00 	mov    %rax,0x12b96(%rip)        # 55000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   4246a:	b8 00 70 05 00       	mov    $0x57000,%eax
   4246f:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   42473:	48 89 05 86 3b 01 00 	mov    %rax,0x13b86(%rip)        # 56000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   4247a:	b8 00 80 05 00       	mov    $0x58000,%eax
   4247f:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   42483:	48 89 05 76 4b 01 00 	mov    %rax,0x14b76(%rip)        # 57000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   4248a:	b8 00 90 05 00       	mov    $0x59000,%eax
   4248f:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   42493:	48 89 05 6e 4b 01 00 	mov    %rax,0x14b6e(%rip)        # 57008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   4249a:	48 8b 05 5f 1b 01 00 	mov    0x11b5f(%rip),%rax        # 54000 <kernel_pagetable>
   424a1:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   424a7:	b9 00 00 20 00       	mov    $0x200000,%ecx
   424ac:	ba 00 00 00 00       	mov    $0x0,%edx
   424b1:	be 00 00 00 00       	mov    $0x0,%esi
   424b6:	48 89 c7             	mov    %rax,%rdi
   424b9:	e8 b9 01 00 00       	call   42677 <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   424be:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   424c5:	00 
   424c6:	eb 62                	jmp    4252a <virtual_memory_init+0xf7>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   424c8:	48 8b 0d 31 1b 01 00 	mov    0x11b31(%rip),%rcx        # 54000 <kernel_pagetable>
   424cf:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   424d3:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   424d7:	48 89 ce             	mov    %rcx,%rsi
   424da:	48 89 c7             	mov    %rax,%rdi
   424dd:	e8 5b 05 00 00       	call   42a3d <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l1pagetable ?
        assert(vmap.pa == addr);
   424e2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   424e6:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   424ea:	74 14                	je     42500 <virtual_memory_init+0xcd>
   424ec:	ba a5 44 04 00       	mov    $0x444a5,%edx
   424f1:	be 2d 00 00 00       	mov    $0x2d,%esi
   424f6:	bf b5 44 04 00       	mov    $0x444b5,%edi
   424fb:	e8 78 fe ff ff       	call   42378 <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   42500:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42503:	48 98                	cltq   
   42505:	83 e0 03             	and    $0x3,%eax
   42508:	48 83 f8 03          	cmp    $0x3,%rax
   4250c:	74 14                	je     42522 <virtual_memory_init+0xef>
   4250e:	ba c8 44 04 00       	mov    $0x444c8,%edx
   42513:	be 2e 00 00 00       	mov    $0x2e,%esi
   42518:	bf b5 44 04 00       	mov    $0x444b5,%edi
   4251d:	e8 56 fe ff ff       	call   42378 <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42522:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42529:	00 
   4252a:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   42531:	00 
   42532:	76 94                	jbe    424c8 <virtual_memory_init+0x95>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   42534:	48 8b 05 c5 1a 01 00 	mov    0x11ac5(%rip),%rax        # 54000 <kernel_pagetable>
   4253b:	48 89 c7             	mov    %rax,%rdi
   4253e:	e8 03 00 00 00       	call   42546 <set_pagetable>
}
   42543:	90                   	nop
   42544:	c9                   	leave  
   42545:	c3                   	ret    

0000000000042546 <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   42546:	55                   	push   %rbp
   42547:	48 89 e5             	mov    %rsp,%rbp
   4254a:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   4254e:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   42552:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42556:	25 ff 0f 00 00       	and    $0xfff,%eax
   4255b:	48 85 c0             	test   %rax,%rax
   4255e:	74 14                	je     42574 <set_pagetable+0x2e>
   42560:	ba f5 44 04 00       	mov    $0x444f5,%edx
   42565:	be 3d 00 00 00       	mov    $0x3d,%esi
   4256a:	bf b5 44 04 00       	mov    $0x444b5,%edi
   4256f:	e8 04 fe ff ff       	call   42378 <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   42574:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42579:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   4257d:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42581:	48 89 ce             	mov    %rcx,%rsi
   42584:	48 89 c7             	mov    %rax,%rdi
   42587:	e8 b1 04 00 00       	call   42a3d <virtual_memory_lookup>
   4258c:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42590:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42595:	48 39 d0             	cmp    %rdx,%rax
   42598:	74 14                	je     425ae <set_pagetable+0x68>
   4259a:	ba 10 45 04 00       	mov    $0x44510,%edx
   4259f:	be 3f 00 00 00       	mov    $0x3f,%esi
   425a4:	bf b5 44 04 00       	mov    $0x444b5,%edi
   425a9:	e8 ca fd ff ff       	call   42378 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   425ae:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   425b2:	48 8b 0d 47 1a 01 00 	mov    0x11a47(%rip),%rcx        # 54000 <kernel_pagetable>
   425b9:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   425bd:	48 89 ce             	mov    %rcx,%rsi
   425c0:	48 89 c7             	mov    %rax,%rdi
   425c3:	e8 75 04 00 00       	call   42a3d <virtual_memory_lookup>
   425c8:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   425cc:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   425d0:	48 39 c2             	cmp    %rax,%rdx
   425d3:	74 14                	je     425e9 <set_pagetable+0xa3>
   425d5:	ba 78 45 04 00       	mov    $0x44578,%edx
   425da:	be 41 00 00 00       	mov    $0x41,%esi
   425df:	bf b5 44 04 00       	mov    $0x444b5,%edi
   425e4:	e8 8f fd ff ff       	call   42378 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   425e9:	48 8b 05 10 1a 01 00 	mov    0x11a10(%rip),%rax        # 54000 <kernel_pagetable>
   425f0:	48 89 c2             	mov    %rax,%rdx
   425f3:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   425f7:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   425fb:	48 89 ce             	mov    %rcx,%rsi
   425fe:	48 89 c7             	mov    %rax,%rdi
   42601:	e8 37 04 00 00       	call   42a3d <virtual_memory_lookup>
   42606:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4260a:	48 8b 15 ef 19 01 00 	mov    0x119ef(%rip),%rdx        # 54000 <kernel_pagetable>
   42611:	48 39 d0             	cmp    %rdx,%rax
   42614:	74 14                	je     4262a <set_pagetable+0xe4>
   42616:	ba d8 45 04 00       	mov    $0x445d8,%edx
   4261b:	be 43 00 00 00       	mov    $0x43,%esi
   42620:	bf b5 44 04 00       	mov    $0x444b5,%edi
   42625:	e8 4e fd ff ff       	call   42378 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   4262a:	ba 77 26 04 00       	mov    $0x42677,%edx
   4262f:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42633:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42637:	48 89 ce             	mov    %rcx,%rsi
   4263a:	48 89 c7             	mov    %rax,%rdi
   4263d:	e8 fb 03 00 00       	call   42a3d <virtual_memory_lookup>
   42642:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42646:	ba 77 26 04 00       	mov    $0x42677,%edx
   4264b:	48 39 d0             	cmp    %rdx,%rax
   4264e:	74 14                	je     42664 <set_pagetable+0x11e>
   42650:	ba 40 46 04 00       	mov    $0x44640,%edx
   42655:	be 45 00 00 00       	mov    $0x45,%esi
   4265a:	bf b5 44 04 00       	mov    $0x444b5,%edi
   4265f:	e8 14 fd ff ff       	call   42378 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   42664:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42668:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   4266c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42670:	0f 22 d8             	mov    %rax,%cr3
}
   42673:	90                   	nop
}
   42674:	90                   	nop
   42675:	c9                   	leave  
   42676:	c3                   	ret    

0000000000042677 <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   42677:	55                   	push   %rbp
   42678:	48 89 e5             	mov    %rsp,%rbp
   4267b:	41 54                	push   %r12
   4267d:	53                   	push   %rbx
   4267e:	48 83 ec 50          	sub    $0x50,%rsp
   42682:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42686:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   4268a:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   4268e:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
   42692:	44 89 45 ac          	mov    %r8d,-0x54(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   42696:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4269a:	25 ff 0f 00 00       	and    $0xfff,%eax
   4269f:	48 85 c0             	test   %rax,%rax
   426a2:	74 14                	je     426b8 <virtual_memory_map+0x41>
   426a4:	ba a6 46 04 00       	mov    $0x446a6,%edx
   426a9:	be 66 00 00 00       	mov    $0x66,%esi
   426ae:	bf b5 44 04 00       	mov    $0x444b5,%edi
   426b3:	e8 c0 fc ff ff       	call   42378 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   426b8:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   426bc:	25 ff 0f 00 00       	and    $0xfff,%eax
   426c1:	48 85 c0             	test   %rax,%rax
   426c4:	74 14                	je     426da <virtual_memory_map+0x63>
   426c6:	ba b9 46 04 00       	mov    $0x446b9,%edx
   426cb:	be 67 00 00 00       	mov    $0x67,%esi
   426d0:	bf b5 44 04 00       	mov    $0x444b5,%edi
   426d5:	e8 9e fc ff ff       	call   42378 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   426da:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   426de:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   426e2:	48 01 d0             	add    %rdx,%rax
   426e5:	48 3b 45 c0          	cmp    -0x40(%rbp),%rax
   426e9:	73 24                	jae    4270f <virtual_memory_map+0x98>
   426eb:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   426ef:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   426f3:	48 01 d0             	add    %rdx,%rax
   426f6:	48 85 c0             	test   %rax,%rax
   426f9:	74 14                	je     4270f <virtual_memory_map+0x98>
   426fb:	ba cc 46 04 00       	mov    $0x446cc,%edx
   42700:	be 68 00 00 00       	mov    $0x68,%esi
   42705:	bf b5 44 04 00       	mov    $0x444b5,%edi
   4270a:	e8 69 fc ff ff       	call   42378 <assert_fail>
    if (perm & PTE_P) {
   4270f:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42712:	48 98                	cltq   
   42714:	83 e0 01             	and    $0x1,%eax
   42717:	48 85 c0             	test   %rax,%rax
   4271a:	74 6e                	je     4278a <virtual_memory_map+0x113>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   4271c:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42720:	25 ff 0f 00 00       	and    $0xfff,%eax
   42725:	48 85 c0             	test   %rax,%rax
   42728:	74 14                	je     4273e <virtual_memory_map+0xc7>
   4272a:	ba ea 46 04 00       	mov    $0x446ea,%edx
   4272f:	be 6a 00 00 00       	mov    $0x6a,%esi
   42734:	bf b5 44 04 00       	mov    $0x444b5,%edi
   42739:	e8 3a fc ff ff       	call   42378 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   4273e:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42742:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42746:	48 01 d0             	add    %rdx,%rax
   42749:	48 3b 45 b8          	cmp    -0x48(%rbp),%rax
   4274d:	73 14                	jae    42763 <virtual_memory_map+0xec>
   4274f:	ba fd 46 04 00       	mov    $0x446fd,%edx
   42754:	be 6b 00 00 00       	mov    $0x6b,%esi
   42759:	bf b5 44 04 00       	mov    $0x444b5,%edi
   4275e:	e8 15 fc ff ff       	call   42378 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   42763:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42767:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   4276b:	48 01 d0             	add    %rdx,%rax
   4276e:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   42774:	76 14                	jbe    4278a <virtual_memory_map+0x113>
   42776:	ba 0b 47 04 00       	mov    $0x4470b,%edx
   4277b:	be 6c 00 00 00       	mov    $0x6c,%esi
   42780:	bf b5 44 04 00       	mov    $0x444b5,%edi
   42785:	e8 ee fb ff ff       	call   42378 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   4278a:	83 7d ac 00          	cmpl   $0x0,-0x54(%rbp)
   4278e:	78 09                	js     42799 <virtual_memory_map+0x122>
   42790:	81 7d ac ff 0f 00 00 	cmpl   $0xfff,-0x54(%rbp)
   42797:	7e 14                	jle    427ad <virtual_memory_map+0x136>
   42799:	ba 27 47 04 00       	mov    $0x44727,%edx
   4279e:	be 6e 00 00 00       	mov    $0x6e,%esi
   427a3:	bf b5 44 04 00       	mov    $0x444b5,%edi
   427a8:	e8 cb fb ff ff       	call   42378 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   427ad:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   427b1:	25 ff 0f 00 00       	and    $0xfff,%eax
   427b6:	48 85 c0             	test   %rax,%rax
   427b9:	74 14                	je     427cf <virtual_memory_map+0x158>
   427bb:	ba 48 47 04 00       	mov    $0x44748,%edx
   427c0:	be 6f 00 00 00       	mov    $0x6f,%esi
   427c5:	bf b5 44 04 00       	mov    $0x444b5,%edi
   427ca:	e8 a9 fb ff ff       	call   42378 <assert_fail>

    int last_index123 = -1;
   427cf:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%rbp)
    x86_64_pagetable* l1pagetable = NULL;
   427d6:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
   427dd:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   427de:	e9 e7 00 00 00       	jmp    428ca <virtual_memory_map+0x253>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   427e3:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   427e7:	48 c1 e8 15          	shr    $0x15,%rax
   427eb:	89 45 dc             	mov    %eax,-0x24(%rbp)
        if (cur_index123 != last_index123) {
   427ee:	8b 45 dc             	mov    -0x24(%rbp),%eax
   427f1:	3b 45 ec             	cmp    -0x14(%rbp),%eax
   427f4:	74 20                	je     42816 <virtual_memory_map+0x19f>
            // TODO --> done
            // find pointer to last level pagetable for current va

			l1pagetable = lookup_l1pagetable(pagetable, va, perm);	
   427f6:	8b 55 ac             	mov    -0x54(%rbp),%edx
   427f9:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   427fd:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42801:	48 89 ce             	mov    %rcx,%rsi
   42804:	48 89 c7             	mov    %rax,%rdi
   42807:	e8 d7 00 00 00       	call   428e3 <lookup_l1pagetable>
   4280c:	48 89 45 e0          	mov    %rax,-0x20(%rbp)

            last_index123 = cur_index123;
   42810:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42813:	89 45 ec             	mov    %eax,-0x14(%rbp)
        }
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   42816:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42819:	48 98                	cltq   
   4281b:	83 e0 01             	and    $0x1,%eax
   4281e:	48 85 c0             	test   %rax,%rax
   42821:	74 3a                	je     4285d <virtual_memory_map+0x1e6>
   42823:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42828:	74 33                	je     4285d <virtual_memory_map+0x1e6>
            // TODO --> done
            // map `pa` at appropriate entry with permissions `perm`
			l1pagetable->entry[L1PAGEINDEX(va)] =  (0x00000000FFFFFFFF & pa) | perm;
   4282a:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4282e:	41 89 c4             	mov    %eax,%r12d
   42831:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42834:	48 63 d8             	movslq %eax,%rbx
   42837:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4283b:	be 03 00 00 00       	mov    $0x3,%esi
   42840:	48 89 c7             	mov    %rax,%rdi
   42843:	e8 95 fb ff ff       	call   423dd <pageindex>
   42848:	89 c2                	mov    %eax,%edx
   4284a:	4c 89 e1             	mov    %r12,%rcx
   4284d:	48 09 d9             	or     %rbx,%rcx
   42850:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42854:	48 63 d2             	movslq %edx,%rdx
   42857:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   4285b:	eb 55                	jmp    428b2 <virtual_memory_map+0x23b>

        } else if (l1pagetable) { // if page is NOT marked present
   4285d:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42862:	74 26                	je     4288a <virtual_memory_map+0x213>
            // TODO --> done
            // map to address 0 with `perm`
			l1pagetable->entry[L1PAGEINDEX(va)] = 0 | perm;
   42864:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42868:	be 03 00 00 00       	mov    $0x3,%esi
   4286d:	48 89 c7             	mov    %rax,%rdi
   42870:	e8 68 fb ff ff       	call   423dd <pageindex>
   42875:	89 c2                	mov    %eax,%edx
   42877:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4287a:	48 63 c8             	movslq %eax,%rcx
   4287d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42881:	48 63 d2             	movslq %edx,%rdx
   42884:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42888:	eb 28                	jmp    428b2 <virtual_memory_map+0x23b>

        } else if (perm & PTE_P) {
   4288a:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4288d:	48 98                	cltq   
   4288f:	83 e0 01             	and    $0x1,%eax
   42892:	48 85 c0             	test   %rax,%rax
   42895:	74 1b                	je     428b2 <virtual_memory_map+0x23b>
            // error, no allocated l1 page found for va
            log_printf("[Kern Info] failed to find l1pagetable address at " __FILE__ ": %d\n", __LINE__);
   42897:	be 8b 00 00 00       	mov    $0x8b,%esi
   4289c:	bf 70 47 04 00       	mov    $0x44770,%edi
   428a1:	b8 00 00 00 00       	mov    $0x0,%eax
   428a6:	e8 af f7 ff ff       	call   4205a <log_printf>
            return -1;
   428ab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   428b0:	eb 28                	jmp    428da <virtual_memory_map+0x263>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   428b2:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
   428b9:	00 
   428ba:	48 81 45 b8 00 10 00 	addq   $0x1000,-0x48(%rbp)
   428c1:	00 
   428c2:	48 81 6d b0 00 10 00 	subq   $0x1000,-0x50(%rbp)
   428c9:	00 
   428ca:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   428cf:	0f 85 0e ff ff ff    	jne    427e3 <virtual_memory_map+0x16c>
        }
    }
    return 0;
   428d5:	b8 00 00 00 00       	mov    $0x0,%eax
}
   428da:	48 83 c4 50          	add    $0x50,%rsp
   428de:	5b                   	pop    %rbx
   428df:	41 5c                	pop    %r12
   428e1:	5d                   	pop    %rbp
   428e2:	c3                   	ret    

00000000000428e3 <lookup_l1pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   428e3:	55                   	push   %rbp
   428e4:	48 89 e5             	mov    %rsp,%rbp
   428e7:	48 83 ec 40          	sub    $0x40,%rsp
   428eb:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   428ef:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   428f3:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   428f6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   428fa:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l1 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   428fe:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   42905:	e9 23 01 00 00       	jmp    42a2d <lookup_l1pagetable+0x14a>
        // TODO --> done
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        x86_64_pageentry_t pe = pt->entry[PAGEINDEX(va, i)]; // replace this
   4290a:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4290d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42911:	89 d6                	mov    %edx,%esi
   42913:	48 89 c7             	mov    %rax,%rdi
   42916:	e8 c2 fa ff ff       	call   423dd <pageindex>
   4291b:	89 c2                	mov    %eax,%edx
   4291d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42921:	48 63 d2             	movslq %edx,%rdx
   42924:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   42928:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   4292c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42930:	83 e0 01             	and    $0x1,%eax
   42933:	48 85 c0             	test   %rax,%rax
   42936:	75 63                	jne    4299b <lookup_l1pagetable+0xb8>
            log_printf("[Kern Info] Error looking up l1pagetable: Pagetable address: 0x%x perm: 0x%x."
   42938:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4293b:	8d 48 02             	lea    0x2(%rax),%ecx
   4293e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42942:	25 ff 0f 00 00       	and    $0xfff,%eax
   42947:	48 89 c2             	mov    %rax,%rdx
   4294a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4294e:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42954:	48 89 c6             	mov    %rax,%rsi
   42957:	bf b8 47 04 00       	mov    $0x447b8,%edi
   4295c:	b8 00 00 00 00       	mov    $0x0,%eax
   42961:	e8 f4 f6 ff ff       	call   4205a <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   42966:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42969:	48 98                	cltq   
   4296b:	83 e0 01             	and    $0x1,%eax
   4296e:	48 85 c0             	test   %rax,%rax
   42971:	75 0a                	jne    4297d <lookup_l1pagetable+0x9a>
                return NULL;
   42973:	b8 00 00 00 00       	mov    $0x0,%eax
   42978:	e9 be 00 00 00       	jmp    42a3b <lookup_l1pagetable+0x158>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   4297d:	be af 00 00 00       	mov    $0xaf,%esi
   42982:	bf 20 48 04 00       	mov    $0x44820,%edi
   42987:	b8 00 00 00 00       	mov    $0x0,%eax
   4298c:	e8 c9 f6 ff ff       	call   4205a <log_printf>
            return NULL;
   42991:	b8 00 00 00 00       	mov    $0x0,%eax
   42996:	e9 a0 00 00 00       	jmp    42a3b <lookup_l1pagetable+0x158>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   4299b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4299f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   429a5:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   429ab:	76 14                	jbe    429c1 <lookup_l1pagetable+0xde>
   429ad:	ba 68 48 04 00       	mov    $0x44868,%edx
   429b2:	be b4 00 00 00       	mov    $0xb4,%esi
   429b7:	bf b5 44 04 00       	mov    $0x444b5,%edi
   429bc:	e8 b7 f9 ff ff       	call   42378 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   429c1:	8b 45 cc             	mov    -0x34(%rbp),%eax
   429c4:	48 98                	cltq   
   429c6:	83 e0 02             	and    $0x2,%eax
   429c9:	48 85 c0             	test   %rax,%rax
   429cc:	74 20                	je     429ee <lookup_l1pagetable+0x10b>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   429ce:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   429d2:	83 e0 02             	and    $0x2,%eax
   429d5:	48 85 c0             	test   %rax,%rax
   429d8:	75 14                	jne    429ee <lookup_l1pagetable+0x10b>
   429da:	ba 88 48 04 00       	mov    $0x44888,%edx
   429df:	be b6 00 00 00       	mov    $0xb6,%esi
   429e4:	bf b5 44 04 00       	mov    $0x444b5,%edi
   429e9:	e8 8a f9 ff ff       	call   42378 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   429ee:	8b 45 cc             	mov    -0x34(%rbp),%eax
   429f1:	48 98                	cltq   
   429f3:	83 e0 04             	and    $0x4,%eax
   429f6:	48 85 c0             	test   %rax,%rax
   429f9:	74 20                	je     42a1b <lookup_l1pagetable+0x138>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   429fb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   429ff:	83 e0 04             	and    $0x4,%eax
   42a02:	48 85 c0             	test   %rax,%rax
   42a05:	75 14                	jne    42a1b <lookup_l1pagetable+0x138>
   42a07:	ba 93 48 04 00       	mov    $0x44893,%edx
   42a0c:	be b9 00 00 00       	mov    $0xb9,%esi
   42a11:	bf b5 44 04 00       	mov    $0x444b5,%edi
   42a16:	e8 5d f9 ff ff       	call   42378 <assert_fail>
        }

        // TODO --> done
        // set pt to physical address to next pagetable using `pe`
        pt = (x86_64_pagetable *) PTE_ADDR(pe); // replace this
   42a1b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42a1f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42a25:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   42a29:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   42a2d:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   42a31:	0f 8e d3 fe ff ff    	jle    4290a <lookup_l1pagetable+0x27>
    }
    return pt;
   42a37:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   42a3b:	c9                   	leave  
   42a3c:	c3                   	ret    

0000000000042a3d <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   42a3d:	55                   	push   %rbp
   42a3e:	48 89 e5             	mov    %rsp,%rbp
   42a41:	48 83 ec 50          	sub    $0x50,%rsp
   42a45:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42a49:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42a4d:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   42a51:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42a55:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   42a59:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   42a60:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42a61:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   42a68:	eb 41                	jmp    42aab <virtual_memory_lookup+0x6e>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   42a6a:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42a6d:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42a71:	89 d6                	mov    %edx,%esi
   42a73:	48 89 c7             	mov    %rax,%rdi
   42a76:	e8 62 f9 ff ff       	call   423dd <pageindex>
   42a7b:	89 c2                	mov    %eax,%edx
   42a7d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42a81:	48 63 d2             	movslq %edx,%rdx
   42a84:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   42a88:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42a8c:	83 e0 06             	and    $0x6,%eax
   42a8f:	48 f7 d0             	not    %rax
   42a92:	48 21 d0             	and    %rdx,%rax
   42a95:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42a99:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42a9d:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42aa3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42aa7:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   42aab:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   42aaf:	7f 0c                	jg     42abd <virtual_memory_lookup+0x80>
   42ab1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ab5:	83 e0 01             	and    $0x1,%eax
   42ab8:	48 85 c0             	test   %rax,%rax
   42abb:	75 ad                	jne    42a6a <virtual_memory_lookup+0x2d>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   42abd:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   42ac4:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   42acb:	ff 
   42acc:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   42ad3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ad7:	83 e0 01             	and    $0x1,%eax
   42ada:	48 85 c0             	test   %rax,%rax
   42add:	74 34                	je     42b13 <virtual_memory_lookup+0xd6>
        vam.pn = PAGENUMBER(pe);
   42adf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ae3:	48 c1 e8 0c          	shr    $0xc,%rax
   42ae7:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   42aea:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42aee:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42af4:	48 89 c2             	mov    %rax,%rdx
   42af7:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42afb:	25 ff 0f 00 00       	and    $0xfff,%eax
   42b00:	48 09 d0             	or     %rdx,%rax
   42b03:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   42b07:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42b0b:	25 ff 0f 00 00       	and    $0xfff,%eax
   42b10:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   42b13:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42b17:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42b1b:	48 89 10             	mov    %rdx,(%rax)
   42b1e:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   42b22:	48 89 50 08          	mov    %rdx,0x8(%rax)
   42b26:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42b2a:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   42b2e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42b32:	c9                   	leave  
   42b33:	c3                   	ret    

0000000000042b34 <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   42b34:	55                   	push   %rbp
   42b35:	48 89 e5             	mov    %rsp,%rbp
   42b38:	48 83 ec 40          	sub    $0x40,%rsp
   42b3c:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42b40:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   42b43:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   42b47:	c7 45 f8 07 00 00 00 	movl   $0x7,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   42b4e:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   42b52:	78 08                	js     42b5c <program_load+0x28>
   42b54:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42b57:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   42b5a:	7c 14                	jl     42b70 <program_load+0x3c>
   42b5c:	ba a0 48 04 00       	mov    $0x448a0,%edx
   42b61:	be 37 00 00 00       	mov    $0x37,%esi
   42b66:	bf d0 48 04 00       	mov    $0x448d0,%edi
   42b6b:	e8 08 f8 ff ff       	call   42378 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   42b70:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42b73:	48 98                	cltq   
   42b75:	48 c1 e0 04          	shl    $0x4,%rax
   42b79:	48 05 20 50 04 00    	add    $0x45020,%rax
   42b7f:	48 8b 00             	mov    (%rax),%rax
   42b82:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   42b86:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42b8a:	8b 00                	mov    (%rax),%eax
   42b8c:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   42b91:	74 14                	je     42ba7 <program_load+0x73>
   42b93:	ba e2 48 04 00       	mov    $0x448e2,%edx
   42b98:	be 39 00 00 00       	mov    $0x39,%esi
   42b9d:	bf d0 48 04 00       	mov    $0x448d0,%edi
   42ba2:	e8 d1 f7 ff ff       	call   42378 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   42ba7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42bab:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42baf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42bb3:	48 01 d0             	add    %rdx,%rax
   42bb6:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   42bba:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42bc1:	e9 94 00 00 00       	jmp    42c5a <program_load+0x126>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   42bc6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42bc9:	48 63 d0             	movslq %eax,%rdx
   42bcc:	48 89 d0             	mov    %rdx,%rax
   42bcf:	48 c1 e0 03          	shl    $0x3,%rax
   42bd3:	48 29 d0             	sub    %rdx,%rax
   42bd6:	48 c1 e0 03          	shl    $0x3,%rax
   42bda:	48 89 c2             	mov    %rax,%rdx
   42bdd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42be1:	48 01 d0             	add    %rdx,%rax
   42be4:	8b 00                	mov    (%rax),%eax
   42be6:	83 f8 01             	cmp    $0x1,%eax
   42be9:	75 6b                	jne    42c56 <program_load+0x122>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   42beb:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42bee:	48 63 d0             	movslq %eax,%rdx
   42bf1:	48 89 d0             	mov    %rdx,%rax
   42bf4:	48 c1 e0 03          	shl    $0x3,%rax
   42bf8:	48 29 d0             	sub    %rdx,%rax
   42bfb:	48 c1 e0 03          	shl    $0x3,%rax
   42bff:	48 89 c2             	mov    %rax,%rdx
   42c02:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c06:	48 01 d0             	add    %rdx,%rax
   42c09:	48 8b 50 08          	mov    0x8(%rax),%rdx
   42c0d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c11:	48 01 d0             	add    %rdx,%rax
   42c14:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   42c18:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42c1b:	48 63 d0             	movslq %eax,%rdx
   42c1e:	48 89 d0             	mov    %rdx,%rax
   42c21:	48 c1 e0 03          	shl    $0x3,%rax
   42c25:	48 29 d0             	sub    %rdx,%rax
   42c28:	48 c1 e0 03          	shl    $0x3,%rax
   42c2c:	48 89 c2             	mov    %rax,%rdx
   42c2f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c33:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   42c37:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42c3b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42c3f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42c43:	48 89 c7             	mov    %rax,%rdi
   42c46:	e8 3d 00 00 00       	call   42c88 <program_load_segment>
   42c4b:	85 c0                	test   %eax,%eax
   42c4d:	79 07                	jns    42c56 <program_load+0x122>
                return -1;
   42c4f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42c54:	eb 30                	jmp    42c86 <program_load+0x152>
    for (int i = 0; i < eh->e_phnum; ++i) {
   42c56:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   42c5a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c5e:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   42c62:	0f b7 c0             	movzwl %ax,%eax
   42c65:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   42c68:	0f 8c 58 ff ff ff    	jl     42bc6 <program_load+0x92>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   42c6e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c72:	48 8b 50 18          	mov    0x18(%rax),%rdx
   42c76:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42c7a:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    return 0;
   42c81:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42c86:	c9                   	leave  
   42c87:	c3                   	ret    

0000000000042c88 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   42c88:	55                   	push   %rbp
   42c89:	48 89 e5             	mov    %rsp,%rbp
   42c8c:	48 83 ec 40          	sub    $0x40,%rsp
   42c90:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42c94:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42c98:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   42c9c:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   42ca0:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42ca4:	48 8b 40 10          	mov    0x10(%rax),%rax
   42ca8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   42cac:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42cb0:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42cb4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42cb8:	48 01 d0             	add    %rdx,%rax
   42cbb:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42cbf:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42cc3:	48 8b 50 28          	mov    0x28(%rax),%rdx
   42cc7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ccb:	48 01 d0             	add    %rdx,%rax
   42cce:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   42cd2:	48 81 65 f0 00 f0 ff 	andq   $0xfffffffffffff000,-0x10(%rbp)
   42cd9:	ff 

    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42cda:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42cde:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   42ce2:	eb 7c                	jmp    42d60 <program_load_segment+0xd8>
        if (assign_physical_page(addr, p->p_pid) < 0
   42ce4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42ce8:	8b 00                	mov    (%rax),%eax
   42cea:	0f be d0             	movsbl %al,%edx
   42ced:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42cf1:	89 d6                	mov    %edx,%esi
   42cf3:	48 89 c7             	mov    %rax,%rdi
   42cf6:	e8 c5 d7 ff ff       	call   404c0 <assign_physical_page>
   42cfb:	85 c0                	test   %eax,%eax
   42cfd:	78 2a                	js     42d29 <program_load_segment+0xa1>
            || virtual_memory_map(p->p_pagetable, addr, addr, PAGESIZE,
   42cff:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42d03:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   42d0a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42d0e:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   42d12:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42d18:	b9 00 10 00 00       	mov    $0x1000,%ecx
   42d1d:	48 89 c7             	mov    %rax,%rdi
   42d20:	e8 52 f9 ff ff       	call   42677 <virtual_memory_map>
   42d25:	85 c0                	test   %eax,%eax
   42d27:	79 2f                	jns    42d58 <program_load_segment+0xd0>
                                  PTE_P | PTE_W | PTE_U) < 0) {
            console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   42d29:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42d2d:	8b 00                	mov    (%rax),%eax
   42d2f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42d33:	49 89 d0             	mov    %rdx,%r8
   42d36:	89 c1                	mov    %eax,%ecx
   42d38:	ba 00 49 04 00       	mov    $0x44900,%edx
   42d3d:	be 00 c0 00 00       	mov    $0xc000,%esi
   42d42:	bf e0 06 00 00       	mov    $0x6e0,%edi
   42d47:	b8 00 00 00 00       	mov    $0x0,%eax
   42d4c:	e8 35 0f 00 00       	call   43c86 <console_printf>
            return -1;
   42d51:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42d56:	eb 77                	jmp    42dcf <program_load_segment+0x147>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42d58:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42d5f:	00 
   42d60:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42d64:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   42d68:	0f 82 76 ff ff ff    	jb     42ce4 <program_load_segment+0x5c>
        }
    }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   42d6e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42d72:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   42d79:	48 89 c7             	mov    %rax,%rdi
   42d7c:	e8 c5 f7 ff ff       	call   42546 <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   42d81:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d85:	48 2b 45 f0          	sub    -0x10(%rbp),%rax
   42d89:	48 89 c2             	mov    %rax,%rdx
   42d8c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d90:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42d94:	48 89 ce             	mov    %rcx,%rsi
   42d97:	48 89 c7             	mov    %rax,%rdi
   42d9a:	e8 32 00 00 00       	call   42dd1 <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   42d9f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42da3:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   42da7:	48 89 c2             	mov    %rax,%rdx
   42daa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42dae:	be 00 00 00 00       	mov    $0x0,%esi
   42db3:	48 89 c7             	mov    %rax,%rdi
   42db6:	e8 14 01 00 00       	call   42ecf <memset>

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   42dbb:	48 8b 05 3e 12 01 00 	mov    0x1123e(%rip),%rax        # 54000 <kernel_pagetable>
   42dc2:	48 89 c7             	mov    %rax,%rdi
   42dc5:	e8 7c f7 ff ff       	call   42546 <set_pagetable>
    return 0;
   42dca:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42dcf:	c9                   	leave  
   42dd0:	c3                   	ret    

0000000000042dd1 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   42dd1:	55                   	push   %rbp
   42dd2:	48 89 e5             	mov    %rsp,%rbp
   42dd5:	48 83 ec 28          	sub    $0x28,%rsp
   42dd9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42ddd:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   42de1:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   42de5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42de9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   42ded:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42df1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   42df5:	eb 1c                	jmp    42e13 <memcpy+0x42>
        *d = *s;
   42df7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42dfb:	0f b6 10             	movzbl (%rax),%edx
   42dfe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e02:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   42e04:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   42e09:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   42e0e:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   42e13:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   42e18:	75 dd                	jne    42df7 <memcpy+0x26>
    }
    return dst;
   42e1a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   42e1e:	c9                   	leave  
   42e1f:	c3                   	ret    

0000000000042e20 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   42e20:	55                   	push   %rbp
   42e21:	48 89 e5             	mov    %rsp,%rbp
   42e24:	48 83 ec 28          	sub    $0x28,%rsp
   42e28:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42e2c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   42e30:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   42e34:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42e38:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   42e3c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42e40:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   42e44:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42e48:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   42e4c:	73 6a                	jae    42eb8 <memmove+0x98>
   42e4e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42e52:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e56:	48 01 d0             	add    %rdx,%rax
   42e59:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   42e5d:	73 59                	jae    42eb8 <memmove+0x98>
        s += n, d += n;
   42e5f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e63:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   42e67:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e6b:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   42e6f:	eb 17                	jmp    42e88 <memmove+0x68>
            *--d = *--s;
   42e71:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   42e76:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   42e7b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42e7f:	0f b6 10             	movzbl (%rax),%edx
   42e82:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e86:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   42e88:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e8c:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   42e90:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   42e94:	48 85 c0             	test   %rax,%rax
   42e97:	75 d8                	jne    42e71 <memmove+0x51>
    if (s < d && s + n > d) {
   42e99:	eb 2e                	jmp    42ec9 <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   42e9b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42e9f:	48 8d 42 01          	lea    0x1(%rdx),%rax
   42ea3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   42ea7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42eab:	48 8d 48 01          	lea    0x1(%rax),%rcx
   42eaf:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   42eb3:	0f b6 12             	movzbl (%rdx),%edx
   42eb6:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   42eb8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42ebc:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   42ec0:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   42ec4:	48 85 c0             	test   %rax,%rax
   42ec7:	75 d2                	jne    42e9b <memmove+0x7b>
        }
    }
    return dst;
   42ec9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   42ecd:	c9                   	leave  
   42ece:	c3                   	ret    

0000000000042ecf <memset>:

void* memset(void* v, int c, size_t n) {
   42ecf:	55                   	push   %rbp
   42ed0:	48 89 e5             	mov    %rsp,%rbp
   42ed3:	48 83 ec 28          	sub    $0x28,%rsp
   42ed7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42edb:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   42ede:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   42ee2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ee6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   42eea:	eb 15                	jmp    42f01 <memset+0x32>
        *p = c;
   42eec:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   42eef:	89 c2                	mov    %eax,%edx
   42ef1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42ef5:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   42ef7:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   42efc:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   42f01:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   42f06:	75 e4                	jne    42eec <memset+0x1d>
    }
    return v;
   42f08:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   42f0c:	c9                   	leave  
   42f0d:	c3                   	ret    

0000000000042f0e <strlen>:

size_t strlen(const char* s) {
   42f0e:	55                   	push   %rbp
   42f0f:	48 89 e5             	mov    %rsp,%rbp
   42f12:	48 83 ec 18          	sub    $0x18,%rsp
   42f16:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   42f1a:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42f21:	00 
   42f22:	eb 0a                	jmp    42f2e <strlen+0x20>
        ++n;
   42f24:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   42f29:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   42f2e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f32:	0f b6 00             	movzbl (%rax),%eax
   42f35:	84 c0                	test   %al,%al
   42f37:	75 eb                	jne    42f24 <strlen+0x16>
    }
    return n;
   42f39:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   42f3d:	c9                   	leave  
   42f3e:	c3                   	ret    

0000000000042f3f <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   42f3f:	55                   	push   %rbp
   42f40:	48 89 e5             	mov    %rsp,%rbp
   42f43:	48 83 ec 20          	sub    $0x20,%rsp
   42f47:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42f4b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   42f4f:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42f56:	00 
   42f57:	eb 0a                	jmp    42f63 <strnlen+0x24>
        ++n;
   42f59:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   42f5e:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   42f63:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42f67:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   42f6b:	74 0b                	je     42f78 <strnlen+0x39>
   42f6d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f71:	0f b6 00             	movzbl (%rax),%eax
   42f74:	84 c0                	test   %al,%al
   42f76:	75 e1                	jne    42f59 <strnlen+0x1a>
    }
    return n;
   42f78:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   42f7c:	c9                   	leave  
   42f7d:	c3                   	ret    

0000000000042f7e <strcpy>:

char* strcpy(char* dst, const char* src) {
   42f7e:	55                   	push   %rbp
   42f7f:	48 89 e5             	mov    %rsp,%rbp
   42f82:	48 83 ec 20          	sub    $0x20,%rsp
   42f86:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42f8a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   42f8e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f92:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   42f96:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42f9a:	48 8d 42 01          	lea    0x1(%rdx),%rax
   42f9e:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   42fa2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42fa6:	48 8d 48 01          	lea    0x1(%rax),%rcx
   42faa:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   42fae:	0f b6 12             	movzbl (%rdx),%edx
   42fb1:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   42fb3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42fb7:	48 83 e8 01          	sub    $0x1,%rax
   42fbb:	0f b6 00             	movzbl (%rax),%eax
   42fbe:	84 c0                	test   %al,%al
   42fc0:	75 d4                	jne    42f96 <strcpy+0x18>
    return dst;
   42fc2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   42fc6:	c9                   	leave  
   42fc7:	c3                   	ret    

0000000000042fc8 <strcmp>:

int strcmp(const char* a, const char* b) {
   42fc8:	55                   	push   %rbp
   42fc9:	48 89 e5             	mov    %rsp,%rbp
   42fcc:	48 83 ec 10          	sub    $0x10,%rsp
   42fd0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42fd4:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   42fd8:	eb 0a                	jmp    42fe4 <strcmp+0x1c>
        ++a, ++b;
   42fda:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   42fdf:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   42fe4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42fe8:	0f b6 00             	movzbl (%rax),%eax
   42feb:	84 c0                	test   %al,%al
   42fed:	74 1d                	je     4300c <strcmp+0x44>
   42fef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ff3:	0f b6 00             	movzbl (%rax),%eax
   42ff6:	84 c0                	test   %al,%al
   42ff8:	74 12                	je     4300c <strcmp+0x44>
   42ffa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42ffe:	0f b6 10             	movzbl (%rax),%edx
   43001:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43005:	0f b6 00             	movzbl (%rax),%eax
   43008:	38 c2                	cmp    %al,%dl
   4300a:	74 ce                	je     42fda <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   4300c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43010:	0f b6 00             	movzbl (%rax),%eax
   43013:	89 c2                	mov    %eax,%edx
   43015:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43019:	0f b6 00             	movzbl (%rax),%eax
   4301c:	38 d0                	cmp    %dl,%al
   4301e:	0f 92 c0             	setb   %al
   43021:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   43024:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43028:	0f b6 00             	movzbl (%rax),%eax
   4302b:	89 c1                	mov    %eax,%ecx
   4302d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43031:	0f b6 00             	movzbl (%rax),%eax
   43034:	38 c1                	cmp    %al,%cl
   43036:	0f 92 c0             	setb   %al
   43039:	0f b6 c0             	movzbl %al,%eax
   4303c:	29 c2                	sub    %eax,%edx
   4303e:	89 d0                	mov    %edx,%eax
}
   43040:	c9                   	leave  
   43041:	c3                   	ret    

0000000000043042 <strchr>:

char* strchr(const char* s, int c) {
   43042:	55                   	push   %rbp
   43043:	48 89 e5             	mov    %rsp,%rbp
   43046:	48 83 ec 10          	sub    $0x10,%rsp
   4304a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4304e:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   43051:	eb 05                	jmp    43058 <strchr+0x16>
        ++s;
   43053:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   43058:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4305c:	0f b6 00             	movzbl (%rax),%eax
   4305f:	84 c0                	test   %al,%al
   43061:	74 0e                	je     43071 <strchr+0x2f>
   43063:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43067:	0f b6 00             	movzbl (%rax),%eax
   4306a:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4306d:	38 d0                	cmp    %dl,%al
   4306f:	75 e2                	jne    43053 <strchr+0x11>
    }
    if (*s == (char) c) {
   43071:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43075:	0f b6 00             	movzbl (%rax),%eax
   43078:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4307b:	38 d0                	cmp    %dl,%al
   4307d:	75 06                	jne    43085 <strchr+0x43>
        return (char*) s;
   4307f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43083:	eb 05                	jmp    4308a <strchr+0x48>
    } else {
        return NULL;
   43085:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   4308a:	c9                   	leave  
   4308b:	c3                   	ret    

000000000004308c <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   4308c:	55                   	push   %rbp
   4308d:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   43090:	8b 05 6a 6f 01 00    	mov    0x16f6a(%rip),%eax        # 5a000 <rand_seed_set>
   43096:	85 c0                	test   %eax,%eax
   43098:	75 0a                	jne    430a4 <rand+0x18>
        srand(819234718U);
   4309a:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   4309f:	e8 24 00 00 00       	call   430c8 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   430a4:	8b 05 5a 6f 01 00    	mov    0x16f5a(%rip),%eax        # 5a004 <rand_seed>
   430aa:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   430b0:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   430b5:	89 05 49 6f 01 00    	mov    %eax,0x16f49(%rip)        # 5a004 <rand_seed>
    return rand_seed & RAND_MAX;
   430bb:	8b 05 43 6f 01 00    	mov    0x16f43(%rip),%eax        # 5a004 <rand_seed>
   430c1:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   430c6:	5d                   	pop    %rbp
   430c7:	c3                   	ret    

00000000000430c8 <srand>:

void srand(unsigned seed) {
   430c8:	55                   	push   %rbp
   430c9:	48 89 e5             	mov    %rsp,%rbp
   430cc:	48 83 ec 08          	sub    $0x8,%rsp
   430d0:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   430d3:	8b 45 fc             	mov    -0x4(%rbp),%eax
   430d6:	89 05 28 6f 01 00    	mov    %eax,0x16f28(%rip)        # 5a004 <rand_seed>
    rand_seed_set = 1;
   430dc:	c7 05 1a 6f 01 00 01 	movl   $0x1,0x16f1a(%rip)        # 5a000 <rand_seed_set>
   430e3:	00 00 00 
}
   430e6:	90                   	nop
   430e7:	c9                   	leave  
   430e8:	c3                   	ret    

00000000000430e9 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   430e9:	55                   	push   %rbp
   430ea:	48 89 e5             	mov    %rsp,%rbp
   430ed:	48 83 ec 28          	sub    $0x28,%rsp
   430f1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   430f5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   430f9:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   430fc:	48 c7 45 f8 20 4b 04 	movq   $0x44b20,-0x8(%rbp)
   43103:	00 
    if (base < 0) {
   43104:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   43108:	79 0b                	jns    43115 <fill_numbuf+0x2c>
        digits = lower_digits;
   4310a:	48 c7 45 f8 40 4b 04 	movq   $0x44b40,-0x8(%rbp)
   43111:	00 
        base = -base;
   43112:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   43115:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   4311a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4311e:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   43121:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43124:	48 63 c8             	movslq %eax,%rcx
   43127:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4312b:	ba 00 00 00 00       	mov    $0x0,%edx
   43130:	48 f7 f1             	div    %rcx
   43133:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43137:	48 01 d0             	add    %rdx,%rax
   4313a:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   4313f:	0f b6 10             	movzbl (%rax),%edx
   43142:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43146:	88 10                	mov    %dl,(%rax)
        val /= base;
   43148:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4314b:	48 63 f0             	movslq %eax,%rsi
   4314e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43152:	ba 00 00 00 00       	mov    $0x0,%edx
   43157:	48 f7 f6             	div    %rsi
   4315a:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   4315e:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43163:	75 bc                	jne    43121 <fill_numbuf+0x38>
    return numbuf_end;
   43165:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43169:	c9                   	leave  
   4316a:	c3                   	ret    

000000000004316b <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   4316b:	55                   	push   %rbp
   4316c:	48 89 e5             	mov    %rsp,%rbp
   4316f:	53                   	push   %rbx
   43170:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   43177:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   4317e:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   43184:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   4318b:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   43192:	e9 8a 09 00 00       	jmp    43b21 <printer_vprintf+0x9b6>
        if (*format != '%') {
   43197:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4319e:	0f b6 00             	movzbl (%rax),%eax
   431a1:	3c 25                	cmp    $0x25,%al
   431a3:	74 31                	je     431d6 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
   431a5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   431ac:	4c 8b 00             	mov    (%rax),%r8
   431af:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   431b6:	0f b6 00             	movzbl (%rax),%eax
   431b9:	0f b6 c8             	movzbl %al,%ecx
   431bc:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   431c2:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   431c9:	89 ce                	mov    %ecx,%esi
   431cb:	48 89 c7             	mov    %rax,%rdi
   431ce:	41 ff d0             	call   *%r8
            continue;
   431d1:	e9 43 09 00 00       	jmp    43b19 <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
   431d6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   431dd:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   431e4:	01 
   431e5:	eb 44                	jmp    4322b <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
   431e7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   431ee:	0f b6 00             	movzbl (%rax),%eax
   431f1:	0f be c0             	movsbl %al,%eax
   431f4:	89 c6                	mov    %eax,%esi
   431f6:	bf 40 49 04 00       	mov    $0x44940,%edi
   431fb:	e8 42 fe ff ff       	call   43042 <strchr>
   43200:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   43204:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   43209:	74 30                	je     4323b <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
   4320b:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   4320f:	48 2d 40 49 04 00    	sub    $0x44940,%rax
   43215:	ba 01 00 00 00       	mov    $0x1,%edx
   4321a:	89 c1                	mov    %eax,%ecx
   4321c:	d3 e2                	shl    %cl,%edx
   4321e:	89 d0                	mov    %edx,%eax
   43220:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   43223:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4322a:	01 
   4322b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43232:	0f b6 00             	movzbl (%rax),%eax
   43235:	84 c0                	test   %al,%al
   43237:	75 ae                	jne    431e7 <printer_vprintf+0x7c>
   43239:	eb 01                	jmp    4323c <printer_vprintf+0xd1>
            } else {
                break;
   4323b:	90                   	nop
            }
        }

        // process width
        int width = -1;
   4323c:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   43243:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4324a:	0f b6 00             	movzbl (%rax),%eax
   4324d:	3c 30                	cmp    $0x30,%al
   4324f:	7e 67                	jle    432b8 <printer_vprintf+0x14d>
   43251:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43258:	0f b6 00             	movzbl (%rax),%eax
   4325b:	3c 39                	cmp    $0x39,%al
   4325d:	7f 59                	jg     432b8 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   4325f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   43266:	eb 2e                	jmp    43296 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
   43268:	8b 55 e8             	mov    -0x18(%rbp),%edx
   4326b:	89 d0                	mov    %edx,%eax
   4326d:	c1 e0 02             	shl    $0x2,%eax
   43270:	01 d0                	add    %edx,%eax
   43272:	01 c0                	add    %eax,%eax
   43274:	89 c1                	mov    %eax,%ecx
   43276:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4327d:	48 8d 50 01          	lea    0x1(%rax),%rdx
   43281:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43288:	0f b6 00             	movzbl (%rax),%eax
   4328b:	0f be c0             	movsbl %al,%eax
   4328e:	01 c8                	add    %ecx,%eax
   43290:	83 e8 30             	sub    $0x30,%eax
   43293:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43296:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4329d:	0f b6 00             	movzbl (%rax),%eax
   432a0:	3c 2f                	cmp    $0x2f,%al
   432a2:	0f 8e 85 00 00 00    	jle    4332d <printer_vprintf+0x1c2>
   432a8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   432af:	0f b6 00             	movzbl (%rax),%eax
   432b2:	3c 39                	cmp    $0x39,%al
   432b4:	7e b2                	jle    43268 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
   432b6:	eb 75                	jmp    4332d <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
   432b8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   432bf:	0f b6 00             	movzbl (%rax),%eax
   432c2:	3c 2a                	cmp    $0x2a,%al
   432c4:	75 68                	jne    4332e <printer_vprintf+0x1c3>
            width = va_arg(val, int);
   432c6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   432cd:	8b 00                	mov    (%rax),%eax
   432cf:	83 f8 2f             	cmp    $0x2f,%eax
   432d2:	77 30                	ja     43304 <printer_vprintf+0x199>
   432d4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   432db:	48 8b 50 10          	mov    0x10(%rax),%rdx
   432df:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   432e6:	8b 00                	mov    (%rax),%eax
   432e8:	89 c0                	mov    %eax,%eax
   432ea:	48 01 d0             	add    %rdx,%rax
   432ed:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   432f4:	8b 12                	mov    (%rdx),%edx
   432f6:	8d 4a 08             	lea    0x8(%rdx),%ecx
   432f9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43300:	89 0a                	mov    %ecx,(%rdx)
   43302:	eb 1a                	jmp    4331e <printer_vprintf+0x1b3>
   43304:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4330b:	48 8b 40 08          	mov    0x8(%rax),%rax
   4330f:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43313:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4331a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4331e:	8b 00                	mov    (%rax),%eax
   43320:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   43323:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4332a:	01 
   4332b:	eb 01                	jmp    4332e <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
   4332d:	90                   	nop
        }

        // process precision
        int precision = -1;
   4332e:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   43335:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4333c:	0f b6 00             	movzbl (%rax),%eax
   4333f:	3c 2e                	cmp    $0x2e,%al
   43341:	0f 85 00 01 00 00    	jne    43447 <printer_vprintf+0x2dc>
            ++format;
   43347:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4334e:	01 
            if (*format >= '0' && *format <= '9') {
   4334f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43356:	0f b6 00             	movzbl (%rax),%eax
   43359:	3c 2f                	cmp    $0x2f,%al
   4335b:	7e 67                	jle    433c4 <printer_vprintf+0x259>
   4335d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43364:	0f b6 00             	movzbl (%rax),%eax
   43367:	3c 39                	cmp    $0x39,%al
   43369:	7f 59                	jg     433c4 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   4336b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   43372:	eb 2e                	jmp    433a2 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
   43374:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   43377:	89 d0                	mov    %edx,%eax
   43379:	c1 e0 02             	shl    $0x2,%eax
   4337c:	01 d0                	add    %edx,%eax
   4337e:	01 c0                	add    %eax,%eax
   43380:	89 c1                	mov    %eax,%ecx
   43382:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43389:	48 8d 50 01          	lea    0x1(%rax),%rdx
   4338d:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43394:	0f b6 00             	movzbl (%rax),%eax
   43397:	0f be c0             	movsbl %al,%eax
   4339a:	01 c8                	add    %ecx,%eax
   4339c:	83 e8 30             	sub    $0x30,%eax
   4339f:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   433a2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   433a9:	0f b6 00             	movzbl (%rax),%eax
   433ac:	3c 2f                	cmp    $0x2f,%al
   433ae:	0f 8e 85 00 00 00    	jle    43439 <printer_vprintf+0x2ce>
   433b4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   433bb:	0f b6 00             	movzbl (%rax),%eax
   433be:	3c 39                	cmp    $0x39,%al
   433c0:	7e b2                	jle    43374 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
   433c2:	eb 75                	jmp    43439 <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
   433c4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   433cb:	0f b6 00             	movzbl (%rax),%eax
   433ce:	3c 2a                	cmp    $0x2a,%al
   433d0:	75 68                	jne    4343a <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
   433d2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   433d9:	8b 00                	mov    (%rax),%eax
   433db:	83 f8 2f             	cmp    $0x2f,%eax
   433de:	77 30                	ja     43410 <printer_vprintf+0x2a5>
   433e0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   433e7:	48 8b 50 10          	mov    0x10(%rax),%rdx
   433eb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   433f2:	8b 00                	mov    (%rax),%eax
   433f4:	89 c0                	mov    %eax,%eax
   433f6:	48 01 d0             	add    %rdx,%rax
   433f9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43400:	8b 12                	mov    (%rdx),%edx
   43402:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43405:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4340c:	89 0a                	mov    %ecx,(%rdx)
   4340e:	eb 1a                	jmp    4342a <printer_vprintf+0x2bf>
   43410:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43417:	48 8b 40 08          	mov    0x8(%rax),%rax
   4341b:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4341f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43426:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4342a:	8b 00                	mov    (%rax),%eax
   4342c:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   4342f:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43436:	01 
   43437:	eb 01                	jmp    4343a <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
   43439:	90                   	nop
            }
            if (precision < 0) {
   4343a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   4343e:	79 07                	jns    43447 <printer_vprintf+0x2dc>
                precision = 0;
   43440:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   43447:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   4344e:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   43455:	00 
        int length = 0;
   43456:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   4345d:	48 c7 45 c8 46 49 04 	movq   $0x44946,-0x38(%rbp)
   43464:	00 
    again:
        switch (*format) {
   43465:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4346c:	0f b6 00             	movzbl (%rax),%eax
   4346f:	0f be c0             	movsbl %al,%eax
   43472:	83 e8 43             	sub    $0x43,%eax
   43475:	83 f8 37             	cmp    $0x37,%eax
   43478:	0f 87 9f 03 00 00    	ja     4381d <printer_vprintf+0x6b2>
   4347e:	89 c0                	mov    %eax,%eax
   43480:	48 8b 04 c5 58 49 04 	mov    0x44958(,%rax,8),%rax
   43487:	00 
   43488:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
   4348a:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   43491:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43498:	01 
            goto again;
   43499:	eb ca                	jmp    43465 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   4349b:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   4349f:	74 5d                	je     434fe <printer_vprintf+0x393>
   434a1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   434a8:	8b 00                	mov    (%rax),%eax
   434aa:	83 f8 2f             	cmp    $0x2f,%eax
   434ad:	77 30                	ja     434df <printer_vprintf+0x374>
   434af:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   434b6:	48 8b 50 10          	mov    0x10(%rax),%rdx
   434ba:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   434c1:	8b 00                	mov    (%rax),%eax
   434c3:	89 c0                	mov    %eax,%eax
   434c5:	48 01 d0             	add    %rdx,%rax
   434c8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   434cf:	8b 12                	mov    (%rdx),%edx
   434d1:	8d 4a 08             	lea    0x8(%rdx),%ecx
   434d4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   434db:	89 0a                	mov    %ecx,(%rdx)
   434dd:	eb 1a                	jmp    434f9 <printer_vprintf+0x38e>
   434df:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   434e6:	48 8b 40 08          	mov    0x8(%rax),%rax
   434ea:	48 8d 48 08          	lea    0x8(%rax),%rcx
   434ee:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   434f5:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   434f9:	48 8b 00             	mov    (%rax),%rax
   434fc:	eb 5c                	jmp    4355a <printer_vprintf+0x3ef>
   434fe:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43505:	8b 00                	mov    (%rax),%eax
   43507:	83 f8 2f             	cmp    $0x2f,%eax
   4350a:	77 30                	ja     4353c <printer_vprintf+0x3d1>
   4350c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43513:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43517:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4351e:	8b 00                	mov    (%rax),%eax
   43520:	89 c0                	mov    %eax,%eax
   43522:	48 01 d0             	add    %rdx,%rax
   43525:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4352c:	8b 12                	mov    (%rdx),%edx
   4352e:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43531:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43538:	89 0a                	mov    %ecx,(%rdx)
   4353a:	eb 1a                	jmp    43556 <printer_vprintf+0x3eb>
   4353c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43543:	48 8b 40 08          	mov    0x8(%rax),%rax
   43547:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4354b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43552:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43556:	8b 00                	mov    (%rax),%eax
   43558:	48 98                	cltq   
   4355a:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   4355e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43562:	48 c1 f8 38          	sar    $0x38,%rax
   43566:	25 80 00 00 00       	and    $0x80,%eax
   4356b:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   4356e:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   43572:	74 09                	je     4357d <printer_vprintf+0x412>
   43574:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43578:	48 f7 d8             	neg    %rax
   4357b:	eb 04                	jmp    43581 <printer_vprintf+0x416>
   4357d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43581:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   43585:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   43588:	83 c8 60             	or     $0x60,%eax
   4358b:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   4358e:	e9 cf 02 00 00       	jmp    43862 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   43593:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43597:	74 5d                	je     435f6 <printer_vprintf+0x48b>
   43599:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   435a0:	8b 00                	mov    (%rax),%eax
   435a2:	83 f8 2f             	cmp    $0x2f,%eax
   435a5:	77 30                	ja     435d7 <printer_vprintf+0x46c>
   435a7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   435ae:	48 8b 50 10          	mov    0x10(%rax),%rdx
   435b2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   435b9:	8b 00                	mov    (%rax),%eax
   435bb:	89 c0                	mov    %eax,%eax
   435bd:	48 01 d0             	add    %rdx,%rax
   435c0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   435c7:	8b 12                	mov    (%rdx),%edx
   435c9:	8d 4a 08             	lea    0x8(%rdx),%ecx
   435cc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   435d3:	89 0a                	mov    %ecx,(%rdx)
   435d5:	eb 1a                	jmp    435f1 <printer_vprintf+0x486>
   435d7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   435de:	48 8b 40 08          	mov    0x8(%rax),%rax
   435e2:	48 8d 48 08          	lea    0x8(%rax),%rcx
   435e6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   435ed:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   435f1:	48 8b 00             	mov    (%rax),%rax
   435f4:	eb 5c                	jmp    43652 <printer_vprintf+0x4e7>
   435f6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   435fd:	8b 00                	mov    (%rax),%eax
   435ff:	83 f8 2f             	cmp    $0x2f,%eax
   43602:	77 30                	ja     43634 <printer_vprintf+0x4c9>
   43604:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4360b:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4360f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43616:	8b 00                	mov    (%rax),%eax
   43618:	89 c0                	mov    %eax,%eax
   4361a:	48 01 d0             	add    %rdx,%rax
   4361d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43624:	8b 12                	mov    (%rdx),%edx
   43626:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43629:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43630:	89 0a                	mov    %ecx,(%rdx)
   43632:	eb 1a                	jmp    4364e <printer_vprintf+0x4e3>
   43634:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4363b:	48 8b 40 08          	mov    0x8(%rax),%rax
   4363f:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43643:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4364a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4364e:	8b 00                	mov    (%rax),%eax
   43650:	89 c0                	mov    %eax,%eax
   43652:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   43656:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   4365a:	e9 03 02 00 00       	jmp    43862 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
   4365f:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   43666:	e9 28 ff ff ff       	jmp    43593 <printer_vprintf+0x428>
        case 'X':
            base = 16;
   4366b:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   43672:	e9 1c ff ff ff       	jmp    43593 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   43677:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4367e:	8b 00                	mov    (%rax),%eax
   43680:	83 f8 2f             	cmp    $0x2f,%eax
   43683:	77 30                	ja     436b5 <printer_vprintf+0x54a>
   43685:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4368c:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43690:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43697:	8b 00                	mov    (%rax),%eax
   43699:	89 c0                	mov    %eax,%eax
   4369b:	48 01 d0             	add    %rdx,%rax
   4369e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   436a5:	8b 12                	mov    (%rdx),%edx
   436a7:	8d 4a 08             	lea    0x8(%rdx),%ecx
   436aa:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   436b1:	89 0a                	mov    %ecx,(%rdx)
   436b3:	eb 1a                	jmp    436cf <printer_vprintf+0x564>
   436b5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   436bc:	48 8b 40 08          	mov    0x8(%rax),%rax
   436c0:	48 8d 48 08          	lea    0x8(%rax),%rcx
   436c4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   436cb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   436cf:	48 8b 00             	mov    (%rax),%rax
   436d2:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   436d6:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   436dd:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   436e4:	e9 79 01 00 00       	jmp    43862 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
   436e9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   436f0:	8b 00                	mov    (%rax),%eax
   436f2:	83 f8 2f             	cmp    $0x2f,%eax
   436f5:	77 30                	ja     43727 <printer_vprintf+0x5bc>
   436f7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   436fe:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43702:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43709:	8b 00                	mov    (%rax),%eax
   4370b:	89 c0                	mov    %eax,%eax
   4370d:	48 01 d0             	add    %rdx,%rax
   43710:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43717:	8b 12                	mov    (%rdx),%edx
   43719:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4371c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43723:	89 0a                	mov    %ecx,(%rdx)
   43725:	eb 1a                	jmp    43741 <printer_vprintf+0x5d6>
   43727:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4372e:	48 8b 40 08          	mov    0x8(%rax),%rax
   43732:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43736:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4373d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43741:	48 8b 00             	mov    (%rax),%rax
   43744:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   43748:	e9 15 01 00 00       	jmp    43862 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
   4374d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43754:	8b 00                	mov    (%rax),%eax
   43756:	83 f8 2f             	cmp    $0x2f,%eax
   43759:	77 30                	ja     4378b <printer_vprintf+0x620>
   4375b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43762:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43766:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4376d:	8b 00                	mov    (%rax),%eax
   4376f:	89 c0                	mov    %eax,%eax
   43771:	48 01 d0             	add    %rdx,%rax
   43774:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4377b:	8b 12                	mov    (%rdx),%edx
   4377d:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43780:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43787:	89 0a                	mov    %ecx,(%rdx)
   43789:	eb 1a                	jmp    437a5 <printer_vprintf+0x63a>
   4378b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43792:	48 8b 40 08          	mov    0x8(%rax),%rax
   43796:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4379a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   437a1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   437a5:	8b 00                	mov    (%rax),%eax
   437a7:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   437ad:	e9 67 03 00 00       	jmp    43b19 <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
   437b2:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   437b6:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   437ba:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   437c1:	8b 00                	mov    (%rax),%eax
   437c3:	83 f8 2f             	cmp    $0x2f,%eax
   437c6:	77 30                	ja     437f8 <printer_vprintf+0x68d>
   437c8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   437cf:	48 8b 50 10          	mov    0x10(%rax),%rdx
   437d3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   437da:	8b 00                	mov    (%rax),%eax
   437dc:	89 c0                	mov    %eax,%eax
   437de:	48 01 d0             	add    %rdx,%rax
   437e1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   437e8:	8b 12                	mov    (%rdx),%edx
   437ea:	8d 4a 08             	lea    0x8(%rdx),%ecx
   437ed:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   437f4:	89 0a                	mov    %ecx,(%rdx)
   437f6:	eb 1a                	jmp    43812 <printer_vprintf+0x6a7>
   437f8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   437ff:	48 8b 40 08          	mov    0x8(%rax),%rax
   43803:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43807:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4380e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43812:	8b 00                	mov    (%rax),%eax
   43814:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   43817:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   4381b:	eb 45                	jmp    43862 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
   4381d:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43821:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   43825:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4382c:	0f b6 00             	movzbl (%rax),%eax
   4382f:	84 c0                	test   %al,%al
   43831:	74 0c                	je     4383f <printer_vprintf+0x6d4>
   43833:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4383a:	0f b6 00             	movzbl (%rax),%eax
   4383d:	eb 05                	jmp    43844 <printer_vprintf+0x6d9>
   4383f:	b8 25 00 00 00       	mov    $0x25,%eax
   43844:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   43847:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   4384b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43852:	0f b6 00             	movzbl (%rax),%eax
   43855:	84 c0                	test   %al,%al
   43857:	75 08                	jne    43861 <printer_vprintf+0x6f6>
                format--;
   43859:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   43860:	01 
            }
            break;
   43861:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   43862:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43865:	83 e0 20             	and    $0x20,%eax
   43868:	85 c0                	test   %eax,%eax
   4386a:	74 1e                	je     4388a <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   4386c:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43870:	48 83 c0 18          	add    $0x18,%rax
   43874:	8b 55 e0             	mov    -0x20(%rbp),%edx
   43877:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   4387b:	48 89 ce             	mov    %rcx,%rsi
   4387e:	48 89 c7             	mov    %rax,%rdi
   43881:	e8 63 f8 ff ff       	call   430e9 <fill_numbuf>
   43886:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   4388a:	48 c7 45 c0 46 49 04 	movq   $0x44946,-0x40(%rbp)
   43891:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   43892:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43895:	83 e0 20             	and    $0x20,%eax
   43898:	85 c0                	test   %eax,%eax
   4389a:	74 48                	je     438e4 <printer_vprintf+0x779>
   4389c:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4389f:	83 e0 40             	and    $0x40,%eax
   438a2:	85 c0                	test   %eax,%eax
   438a4:	74 3e                	je     438e4 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
   438a6:	8b 45 ec             	mov    -0x14(%rbp),%eax
   438a9:	25 80 00 00 00       	and    $0x80,%eax
   438ae:	85 c0                	test   %eax,%eax
   438b0:	74 0a                	je     438bc <printer_vprintf+0x751>
                prefix = "-";
   438b2:	48 c7 45 c0 47 49 04 	movq   $0x44947,-0x40(%rbp)
   438b9:	00 
            if (flags & FLAG_NEGATIVE) {
   438ba:	eb 73                	jmp    4392f <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   438bc:	8b 45 ec             	mov    -0x14(%rbp),%eax
   438bf:	83 e0 10             	and    $0x10,%eax
   438c2:	85 c0                	test   %eax,%eax
   438c4:	74 0a                	je     438d0 <printer_vprintf+0x765>
                prefix = "+";
   438c6:	48 c7 45 c0 49 49 04 	movq   $0x44949,-0x40(%rbp)
   438cd:	00 
            if (flags & FLAG_NEGATIVE) {
   438ce:	eb 5f                	jmp    4392f <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   438d0:	8b 45 ec             	mov    -0x14(%rbp),%eax
   438d3:	83 e0 08             	and    $0x8,%eax
   438d6:	85 c0                	test   %eax,%eax
   438d8:	74 55                	je     4392f <printer_vprintf+0x7c4>
                prefix = " ";
   438da:	48 c7 45 c0 4b 49 04 	movq   $0x4494b,-0x40(%rbp)
   438e1:	00 
            if (flags & FLAG_NEGATIVE) {
   438e2:	eb 4b                	jmp    4392f <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   438e4:	8b 45 ec             	mov    -0x14(%rbp),%eax
   438e7:	83 e0 20             	and    $0x20,%eax
   438ea:	85 c0                	test   %eax,%eax
   438ec:	74 42                	je     43930 <printer_vprintf+0x7c5>
   438ee:	8b 45 ec             	mov    -0x14(%rbp),%eax
   438f1:	83 e0 01             	and    $0x1,%eax
   438f4:	85 c0                	test   %eax,%eax
   438f6:	74 38                	je     43930 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
   438f8:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   438fc:	74 06                	je     43904 <printer_vprintf+0x799>
   438fe:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   43902:	75 2c                	jne    43930 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
   43904:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43909:	75 0c                	jne    43917 <printer_vprintf+0x7ac>
   4390b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4390e:	25 00 01 00 00       	and    $0x100,%eax
   43913:	85 c0                	test   %eax,%eax
   43915:	74 19                	je     43930 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
   43917:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   4391b:	75 07                	jne    43924 <printer_vprintf+0x7b9>
   4391d:	b8 4d 49 04 00       	mov    $0x4494d,%eax
   43922:	eb 05                	jmp    43929 <printer_vprintf+0x7be>
   43924:	b8 50 49 04 00       	mov    $0x44950,%eax
   43929:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   4392d:	eb 01                	jmp    43930 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
   4392f:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   43930:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   43934:	78 24                	js     4395a <printer_vprintf+0x7ef>
   43936:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43939:	83 e0 20             	and    $0x20,%eax
   4393c:	85 c0                	test   %eax,%eax
   4393e:	75 1a                	jne    4395a <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
   43940:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43943:	48 63 d0             	movslq %eax,%rdx
   43946:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4394a:	48 89 d6             	mov    %rdx,%rsi
   4394d:	48 89 c7             	mov    %rax,%rdi
   43950:	e8 ea f5 ff ff       	call   42f3f <strnlen>
   43955:	89 45 bc             	mov    %eax,-0x44(%rbp)
   43958:	eb 0f                	jmp    43969 <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
   4395a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4395e:	48 89 c7             	mov    %rax,%rdi
   43961:	e8 a8 f5 ff ff       	call   42f0e <strlen>
   43966:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   43969:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4396c:	83 e0 20             	and    $0x20,%eax
   4396f:	85 c0                	test   %eax,%eax
   43971:	74 20                	je     43993 <printer_vprintf+0x828>
   43973:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   43977:	78 1a                	js     43993 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
   43979:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4397c:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   4397f:	7e 08                	jle    43989 <printer_vprintf+0x81e>
   43981:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43984:	2b 45 bc             	sub    -0x44(%rbp),%eax
   43987:	eb 05                	jmp    4398e <printer_vprintf+0x823>
   43989:	b8 00 00 00 00       	mov    $0x0,%eax
   4398e:	89 45 b8             	mov    %eax,-0x48(%rbp)
   43991:	eb 5c                	jmp    439ef <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   43993:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43996:	83 e0 20             	and    $0x20,%eax
   43999:	85 c0                	test   %eax,%eax
   4399b:	74 4b                	je     439e8 <printer_vprintf+0x87d>
   4399d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   439a0:	83 e0 02             	and    $0x2,%eax
   439a3:	85 c0                	test   %eax,%eax
   439a5:	74 41                	je     439e8 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
   439a7:	8b 45 ec             	mov    -0x14(%rbp),%eax
   439aa:	83 e0 04             	and    $0x4,%eax
   439ad:	85 c0                	test   %eax,%eax
   439af:	75 37                	jne    439e8 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
   439b1:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   439b5:	48 89 c7             	mov    %rax,%rdi
   439b8:	e8 51 f5 ff ff       	call   42f0e <strlen>
   439bd:	89 c2                	mov    %eax,%edx
   439bf:	8b 45 bc             	mov    -0x44(%rbp),%eax
   439c2:	01 d0                	add    %edx,%eax
   439c4:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   439c7:	7e 1f                	jle    439e8 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
   439c9:	8b 45 e8             	mov    -0x18(%rbp),%eax
   439cc:	2b 45 bc             	sub    -0x44(%rbp),%eax
   439cf:	89 c3                	mov    %eax,%ebx
   439d1:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   439d5:	48 89 c7             	mov    %rax,%rdi
   439d8:	e8 31 f5 ff ff       	call   42f0e <strlen>
   439dd:	89 c2                	mov    %eax,%edx
   439df:	89 d8                	mov    %ebx,%eax
   439e1:	29 d0                	sub    %edx,%eax
   439e3:	89 45 b8             	mov    %eax,-0x48(%rbp)
   439e6:	eb 07                	jmp    439ef <printer_vprintf+0x884>
        } else {
            zeros = 0;
   439e8:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   439ef:	8b 55 bc             	mov    -0x44(%rbp),%edx
   439f2:	8b 45 b8             	mov    -0x48(%rbp),%eax
   439f5:	01 d0                	add    %edx,%eax
   439f7:	48 63 d8             	movslq %eax,%rbx
   439fa:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   439fe:	48 89 c7             	mov    %rax,%rdi
   43a01:	e8 08 f5 ff ff       	call   42f0e <strlen>
   43a06:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   43a0a:	8b 45 e8             	mov    -0x18(%rbp),%eax
   43a0d:	29 d0                	sub    %edx,%eax
   43a0f:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   43a12:	eb 25                	jmp    43a39 <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
   43a14:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43a1b:	48 8b 08             	mov    (%rax),%rcx
   43a1e:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43a24:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43a2b:	be 20 00 00 00       	mov    $0x20,%esi
   43a30:	48 89 c7             	mov    %rax,%rdi
   43a33:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   43a35:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   43a39:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43a3c:	83 e0 04             	and    $0x4,%eax
   43a3f:	85 c0                	test   %eax,%eax
   43a41:	75 36                	jne    43a79 <printer_vprintf+0x90e>
   43a43:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   43a47:	7f cb                	jg     43a14 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
   43a49:	eb 2e                	jmp    43a79 <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
   43a4b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43a52:	4c 8b 00             	mov    (%rax),%r8
   43a55:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43a59:	0f b6 00             	movzbl (%rax),%eax
   43a5c:	0f b6 c8             	movzbl %al,%ecx
   43a5f:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43a65:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43a6c:	89 ce                	mov    %ecx,%esi
   43a6e:	48 89 c7             	mov    %rax,%rdi
   43a71:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   43a74:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   43a79:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43a7d:	0f b6 00             	movzbl (%rax),%eax
   43a80:	84 c0                	test   %al,%al
   43a82:	75 c7                	jne    43a4b <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
   43a84:	eb 25                	jmp    43aab <printer_vprintf+0x940>
            p->putc(p, '0', color);
   43a86:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43a8d:	48 8b 08             	mov    (%rax),%rcx
   43a90:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43a96:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43a9d:	be 30 00 00 00       	mov    $0x30,%esi
   43aa2:	48 89 c7             	mov    %rax,%rdi
   43aa5:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   43aa7:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   43aab:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   43aaf:	7f d5                	jg     43a86 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
   43ab1:	eb 32                	jmp    43ae5 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
   43ab3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43aba:	4c 8b 00             	mov    (%rax),%r8
   43abd:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43ac1:	0f b6 00             	movzbl (%rax),%eax
   43ac4:	0f b6 c8             	movzbl %al,%ecx
   43ac7:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43acd:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43ad4:	89 ce                	mov    %ecx,%esi
   43ad6:	48 89 c7             	mov    %rax,%rdi
   43ad9:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   43adc:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   43ae1:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   43ae5:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   43ae9:	7f c8                	jg     43ab3 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
   43aeb:	eb 25                	jmp    43b12 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
   43aed:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43af4:	48 8b 08             	mov    (%rax),%rcx
   43af7:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43afd:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43b04:	be 20 00 00 00       	mov    $0x20,%esi
   43b09:	48 89 c7             	mov    %rax,%rdi
   43b0c:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   43b0e:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   43b12:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   43b16:	7f d5                	jg     43aed <printer_vprintf+0x982>
        }
    done: ;
   43b18:	90                   	nop
    for (; *format; ++format) {
   43b19:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43b20:	01 
   43b21:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43b28:	0f b6 00             	movzbl (%rax),%eax
   43b2b:	84 c0                	test   %al,%al
   43b2d:	0f 85 64 f6 ff ff    	jne    43197 <printer_vprintf+0x2c>
    }
}
   43b33:	90                   	nop
   43b34:	90                   	nop
   43b35:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   43b39:	c9                   	leave  
   43b3a:	c3                   	ret    

0000000000043b3b <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   43b3b:	55                   	push   %rbp
   43b3c:	48 89 e5             	mov    %rsp,%rbp
   43b3f:	48 83 ec 20          	sub    $0x20,%rsp
   43b43:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43b47:	89 f0                	mov    %esi,%eax
   43b49:	89 55 e0             	mov    %edx,-0x20(%rbp)
   43b4c:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   43b4f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43b53:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   43b57:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43b5b:	48 8b 40 08          	mov    0x8(%rax),%rax
   43b5f:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
   43b64:	48 39 d0             	cmp    %rdx,%rax
   43b67:	72 0c                	jb     43b75 <console_putc+0x3a>
        cp->cursor = console;
   43b69:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43b6d:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
   43b74:	00 
    }
    if (c == '\n') {
   43b75:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   43b79:	75 78                	jne    43bf3 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
   43b7b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43b7f:	48 8b 40 08          	mov    0x8(%rax),%rax
   43b83:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   43b89:	48 d1 f8             	sar    %rax
   43b8c:	48 89 c1             	mov    %rax,%rcx
   43b8f:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   43b96:	66 66 66 
   43b99:	48 89 c8             	mov    %rcx,%rax
   43b9c:	48 f7 ea             	imul   %rdx
   43b9f:	48 c1 fa 05          	sar    $0x5,%rdx
   43ba3:	48 89 c8             	mov    %rcx,%rax
   43ba6:	48 c1 f8 3f          	sar    $0x3f,%rax
   43baa:	48 29 c2             	sub    %rax,%rdx
   43bad:	48 89 d0             	mov    %rdx,%rax
   43bb0:	48 c1 e0 02          	shl    $0x2,%rax
   43bb4:	48 01 d0             	add    %rdx,%rax
   43bb7:	48 c1 e0 04          	shl    $0x4,%rax
   43bbb:	48 29 c1             	sub    %rax,%rcx
   43bbe:	48 89 ca             	mov    %rcx,%rdx
   43bc1:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   43bc4:	eb 25                	jmp    43beb <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
   43bc6:	8b 45 e0             	mov    -0x20(%rbp),%eax
   43bc9:	83 c8 20             	or     $0x20,%eax
   43bcc:	89 c6                	mov    %eax,%esi
   43bce:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43bd2:	48 8b 40 08          	mov    0x8(%rax),%rax
   43bd6:	48 8d 48 02          	lea    0x2(%rax),%rcx
   43bda:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   43bde:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43be2:	89 f2                	mov    %esi,%edx
   43be4:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   43be7:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   43beb:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   43bef:	75 d5                	jne    43bc6 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   43bf1:	eb 24                	jmp    43c17 <console_putc+0xdc>
        *cp->cursor++ = c | color;
   43bf3:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
   43bf7:	8b 55 e0             	mov    -0x20(%rbp),%edx
   43bfa:	09 d0                	or     %edx,%eax
   43bfc:	89 c6                	mov    %eax,%esi
   43bfe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43c02:	48 8b 40 08          	mov    0x8(%rax),%rax
   43c06:	48 8d 48 02          	lea    0x2(%rax),%rcx
   43c0a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   43c0e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43c12:	89 f2                	mov    %esi,%edx
   43c14:	66 89 10             	mov    %dx,(%rax)
}
   43c17:	90                   	nop
   43c18:	c9                   	leave  
   43c19:	c3                   	ret    

0000000000043c1a <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   43c1a:	55                   	push   %rbp
   43c1b:	48 89 e5             	mov    %rsp,%rbp
   43c1e:	48 83 ec 30          	sub    $0x30,%rsp
   43c22:	89 7d ec             	mov    %edi,-0x14(%rbp)
   43c25:	89 75 e8             	mov    %esi,-0x18(%rbp)
   43c28:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   43c2c:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   43c30:	48 c7 45 f0 3b 3b 04 	movq   $0x43b3b,-0x10(%rbp)
   43c37:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   43c38:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   43c3c:	78 09                	js     43c47 <console_vprintf+0x2d>
   43c3e:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   43c45:	7e 07                	jle    43c4e <console_vprintf+0x34>
        cpos = 0;
   43c47:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   43c4e:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43c51:	48 98                	cltq   
   43c53:	48 01 c0             	add    %rax,%rax
   43c56:	48 05 00 80 0b 00    	add    $0xb8000,%rax
   43c5c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   43c60:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   43c64:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43c68:	8b 75 e8             	mov    -0x18(%rbp),%esi
   43c6b:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   43c6f:	48 89 c7             	mov    %rax,%rdi
   43c72:	e8 f4 f4 ff ff       	call   4316b <printer_vprintf>
    return cp.cursor - console;
   43c77:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c7b:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   43c81:	48 d1 f8             	sar    %rax
}
   43c84:	c9                   	leave  
   43c85:	c3                   	ret    

0000000000043c86 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   43c86:	55                   	push   %rbp
   43c87:	48 89 e5             	mov    %rsp,%rbp
   43c8a:	48 83 ec 60          	sub    $0x60,%rsp
   43c8e:	89 7d ac             	mov    %edi,-0x54(%rbp)
   43c91:	89 75 a8             	mov    %esi,-0x58(%rbp)
   43c94:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   43c98:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   43c9c:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   43ca0:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   43ca4:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   43cab:	48 8d 45 10          	lea    0x10(%rbp),%rax
   43caf:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   43cb3:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   43cb7:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   43cbb:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   43cbf:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   43cc3:	8b 75 a8             	mov    -0x58(%rbp),%esi
   43cc6:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43cc9:	89 c7                	mov    %eax,%edi
   43ccb:	e8 4a ff ff ff       	call   43c1a <console_vprintf>
   43cd0:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   43cd3:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   43cd6:	c9                   	leave  
   43cd7:	c3                   	ret    

0000000000043cd8 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   43cd8:	55                   	push   %rbp
   43cd9:	48 89 e5             	mov    %rsp,%rbp
   43cdc:	48 83 ec 20          	sub    $0x20,%rsp
   43ce0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43ce4:	89 f0                	mov    %esi,%eax
   43ce6:	89 55 e0             	mov    %edx,-0x20(%rbp)
   43ce9:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   43cec:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43cf0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   43cf4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43cf8:	48 8b 50 08          	mov    0x8(%rax),%rdx
   43cfc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43d00:	48 8b 40 10          	mov    0x10(%rax),%rax
   43d04:	48 39 c2             	cmp    %rax,%rdx
   43d07:	73 1a                	jae    43d23 <string_putc+0x4b>
        *sp->s++ = c;
   43d09:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43d0d:	48 8b 40 08          	mov    0x8(%rax),%rax
   43d11:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43d15:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43d19:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43d1d:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   43d21:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   43d23:	90                   	nop
   43d24:	c9                   	leave  
   43d25:	c3                   	ret    

0000000000043d26 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   43d26:	55                   	push   %rbp
   43d27:	48 89 e5             	mov    %rsp,%rbp
   43d2a:	48 83 ec 40          	sub    $0x40,%rsp
   43d2e:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   43d32:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   43d36:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   43d3a:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   43d3e:	48 c7 45 e8 d8 3c 04 	movq   $0x43cd8,-0x18(%rbp)
   43d45:	00 
    sp.s = s;
   43d46:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43d4a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   43d4e:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   43d53:	74 33                	je     43d88 <vsnprintf+0x62>
        sp.end = s + size - 1;
   43d55:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43d59:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43d5d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43d61:	48 01 d0             	add    %rdx,%rax
   43d64:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   43d68:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   43d6c:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   43d70:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   43d74:	be 00 00 00 00       	mov    $0x0,%esi
   43d79:	48 89 c7             	mov    %rax,%rdi
   43d7c:	e8 ea f3 ff ff       	call   4316b <printer_vprintf>
        *sp.s = 0;
   43d81:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43d85:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   43d88:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43d8c:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   43d90:	c9                   	leave  
   43d91:	c3                   	ret    

0000000000043d92 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   43d92:	55                   	push   %rbp
   43d93:	48 89 e5             	mov    %rsp,%rbp
   43d96:	48 83 ec 70          	sub    $0x70,%rsp
   43d9a:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   43d9e:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   43da2:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   43da6:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   43daa:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   43dae:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   43db2:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   43db9:	48 8d 45 10          	lea    0x10(%rbp),%rax
   43dbd:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   43dc1:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   43dc5:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   43dc9:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   43dcd:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   43dd1:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   43dd5:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43dd9:	48 89 c7             	mov    %rax,%rdi
   43ddc:	e8 45 ff ff ff       	call   43d26 <vsnprintf>
   43de1:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   43de4:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   43de7:	c9                   	leave  
   43de8:	c3                   	ret    

0000000000043de9 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   43de9:	55                   	push   %rbp
   43dea:	48 89 e5             	mov    %rsp,%rbp
   43ded:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   43df1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   43df8:	eb 13                	jmp    43e0d <console_clear+0x24>
        console[i] = ' ' | 0x0700;
   43dfa:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43dfd:	48 98                	cltq   
   43dff:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
   43e06:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   43e09:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   43e0d:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   43e14:	7e e4                	jle    43dfa <console_clear+0x11>
    }
    cursorpos = 0;
   43e16:	c7 05 dc 51 07 00 00 	movl   $0x0,0x751dc(%rip)        # b8ffc <cursorpos>
   43e1d:	00 00 00 
}
   43e20:	90                   	nop
   43e21:	c9                   	leave  
   43e22:	c3                   	ret    
