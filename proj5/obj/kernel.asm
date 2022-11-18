
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
   40173:	e8 76 16 00 00       	call   417ee <hardware_init>
    pageinfo_init();
   40178:	e8 d5 0c 00 00       	call   40e52 <pageinfo_init>
    console_clear();
   4017d:	e8 fc 40 00 00       	call   4427e <console_clear>
    timer_init(HZ);
   40182:	bf 64 00 00 00       	mov    $0x64,%edi
   40187:	e8 4e 1b 00 00       	call   41cda <timer_init>

    // use virtual_memory_map to remove user permissions for kernel memory
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   4018c:	48 8b 05 6d 4e 01 00 	mov    0x14e6d(%rip),%rax        # 55000 <kernel_pagetable>
   40193:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   40199:	b9 00 00 10 00       	mov    $0x100000,%ecx
   4019e:	ba 00 00 00 00       	mov    $0x0,%edx
   401a3:	be 00 00 00 00       	mov    $0x0,%esi
   401a8:	48 89 c7             	mov    %rax,%rdi
   401ab:	e8 88 28 00 00       	call   42a38 <virtual_memory_map>
					   PROC_START_ADDR, PTE_P | PTE_W);
   
    // return user permissions to console
    virtual_memory_map(kernel_pagetable, (uintptr_t) CONSOLE_ADDR, (uintptr_t) CONSOLE_ADDR,
   401b0:	ba 00 80 0b 00       	mov    $0xb8000,%edx
   401b5:	be 00 80 0b 00       	mov    $0xb8000,%esi
   401ba:	48 8b 05 3f 4e 01 00 	mov    0x14e3f(%rip),%rax        # 55000 <kernel_pagetable>
   401c1:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   401c7:	b9 00 10 00 00       	mov    $0x1000,%ecx
   401cc:	48 89 c7             	mov    %rax,%rdi
   401cf:	e8 64 28 00 00       	call   42a38 <virtual_memory_map>
	// to all memory before the start of ANY processes. This means that 
	// the assign_page function is never capable of assigning this memory
	// to a process.

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   401d4:	ba 00 0e 00 00       	mov    $0xe00,%edx
   401d9:	be 00 00 00 00       	mov    $0x0,%esi
   401de:	bf 20 20 05 00       	mov    $0x52020,%edi
   401e3:	e8 7c 31 00 00       	call   43364 <memset>
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
   40246:	be c0 42 04 00       	mov    $0x442c0,%esi
   4024b:	48 89 c7             	mov    %rax,%rdi
   4024e:	e8 0a 32 00 00       	call   4345d <strcmp>
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
   40276:	be c5 42 04 00       	mov    $0x442c5,%esi
   4027b:	48 89 c7             	mov    %rax,%rdi
   4027e:	e8 da 31 00 00       	call   4345d <strcmp>
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
   402a6:	be ce 42 04 00       	mov    $0x442ce,%esi
   402ab:	48 89 c7             	mov    %rax,%rdi
   402ae:	e8 aa 31 00 00       	call   4345d <strcmp>
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
   402d3:	be d3 42 04 00       	mov    $0x442d3,%esi
   402d8:	48 89 c7             	mov    %rax,%rdi
   402db:	e8 7d 31 00 00       	call   4345d <strcmp>
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
   40332:	e8 be 0a 00 00       	call   40df5 <run>

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
   40420:	e8 3f 2f 00 00       	call   43364 <memset>
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
   4048b:	e8 d6 2d 00 00       	call   43266 <memcpy>
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
   404e7:	e8 7f 1a 00 00       	call   41f6b <process_init>
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
   4051e:	e8 d2 29 00 00       	call   42ef5 <program_load>
   40523:	89 45 fc             	mov    %eax,-0x4(%rbp)
    assert(r >= 0);
   40526:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4052a:	79 14                	jns    40540 <process_setup+0x89>
   4052c:	ba d9 42 04 00       	mov    $0x442d9,%edx
   40531:	be c2 00 00 00       	mov    $0xc2,%esi
   40536:	bf e0 42 04 00       	mov    $0x442e0,%edi
   4053b:	e8 f9 21 00 00       	call   42739 <assert_fail>

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
   405de:	e8 55 24 00 00       	call   42a38 <virtual_memory_map>
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
   406b7:	e8 42 27 00 00       	call   42dfe <virtual_memory_lookup>

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
   406ef:	e8 0a 27 00 00       	call   42dfe <virtual_memory_lookup>
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
   4071b:	e8 de 26 00 00       	call   42dfe <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   40720:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40724:	48 89 c1             	mov    %rax,%rcx
   40727:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   4072b:	ba 18 00 00 00       	mov    $0x18,%edx
   40730:	48 89 c6             	mov    %rax,%rsi
   40733:	48 89 cf             	mov    %rcx,%rdi
   40736:	e8 2b 2b 00 00       	call   43266 <memcpy>
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
   40832:	e8 d0 20 00 00       	call   42907 <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   40837:	8b 05 bf 87 07 00    	mov    0x787bf(%rip),%eax        # b8ffc <cursorpos>
   4083d:	89 c7                	mov    %eax,%edi
   4083f:	e8 f1 17 00 00       	call   42035 <console_show_cursor>
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
   40882:	e8 62 09 00 00       	call   411e9 <check_virtual_memory>
        if(disp_global){
   40887:	0f b6 05 72 47 00 00 	movzbl 0x4772(%rip),%eax        # 45000 <disp_global>
   4088e:	84 c0                	test   %al,%al
   40890:	74 0a                	je     4089c <exception+0xa9>
            memshow_physical();
   40892:	e8 ca 0a 00 00       	call   41361 <memshow_physical>
            memshow_virtual_animate();
   40897:	e8 f4 0d 00 00       	call   41690 <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   4089c:	e8 77 1c 00 00       	call   42518 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   408a1:	48 8b 85 c8 fe ff ff 	mov    -0x138(%rbp),%rax
   408a8:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   408af:	48 83 e8 0e          	sub    $0xe,%rax
   408b3:	48 83 f8 2a          	cmp    $0x2a,%rax
   408b7:	0f 87 89 04 00 00    	ja     40d46 <exception+0x553>
   408bd:	48 8b 04 c5 98 43 04 	mov    0x44398(,%rax,8),%rax
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
   408e7:	e8 6d 1d 00 00       	call   42659 <panic>
		vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   408ec:	48 8b 05 0d 17 01 00 	mov    0x1170d(%rip),%rax        # 52000 <current>
   408f3:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   408fa:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   408fe:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   40902:	48 89 ce             	mov    %rcx,%rsi
   40905:	48 89 c7             	mov    %rax,%rdi
   40908:	e8 f1 24 00 00       	call   42dfe <virtual_memory_lookup>
		memcpy(msg, (void *)map.pa, 160);
   4090d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   40911:	48 89 c1             	mov    %rax,%rcx
   40914:	48 8d 85 d8 fe ff ff 	lea    -0x128(%rbp),%rax
   4091b:	ba a0 00 00 00       	mov    $0xa0,%edx
   40920:	48 89 ce             	mov    %rcx,%rsi
   40923:	48 89 c7             	mov    %rax,%rdi
   40926:	e8 3b 29 00 00       	call   43266 <memcpy>
		panic(msg);
   4092b:	48 8d 85 d8 fe ff ff 	lea    -0x128(%rbp),%rax
   40932:	48 89 c7             	mov    %rax,%rdi
   40935:	b8 00 00 00 00       	mov    $0x0,%eax
   4093a:	e8 1a 1d 00 00       	call   42659 <panic>
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
   40956:	e9 fb 03 00 00       	jmp    40d56 <exception+0x563>

    case INT_SYS_YIELD:
        schedule();
   4095b:	e8 1f 04 00 00       	call   40d7f <schedule>
        break;                  /* will not be reached */
   40960:	e9 f1 03 00 00       	jmp    40d56 <exception+0x563>

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
   409c7:	e8 6c 20 00 00       	call   42a38 <virtual_memory_map>
   409cc:	eb 19                	jmp    409e7 <exception+0x1f4>
                               PAGESIZE, PTE_P | PTE_W | PTE_U);
        }
	else
		console_printf(CPOS(23, 0), 0x0400, "Out of physical memory!\n");	
   409ce:	ba f0 42 04 00       	mov    $0x442f0,%edx
   409d3:	be 00 04 00 00       	mov    $0x400,%esi
   409d8:	bf 30 07 00 00       	mov    $0x730,%edi
   409dd:	b8 00 00 00 00       	mov    $0x0,%eax
   409e2:	e8 34 37 00 00       	call   4411b <console_printf>
        current->p_registers.reg_rax = r;
   409e7:	48 8b 05 12 16 01 00 	mov    0x11612(%rip),%rax        # 52000 <current>
   409ee:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   409f1:	48 63 d2             	movslq %edx,%rdx
   409f4:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   409f8:	e9 59 03 00 00       	jmp    40d56 <exception+0x563>
    }

    case INT_SYS_MAPPING:
    {
	    syscall_mapping(current);
   409fd:	48 8b 05 fc 15 01 00 	mov    0x115fc(%rip),%rax        # 52000 <current>
   40a04:	48 89 c7             	mov    %rax,%rdi
   40a07:	e8 6e fc ff ff       	call   4067a <syscall_mapping>
            break;
   40a0c:	e9 45 03 00 00       	jmp    40d56 <exception+0x563>
    }

    case INT_SYS_MEM_TOG:
	{
	    syscall_mem_tog(current);
   40a11:	48 8b 05 e8 15 01 00 	mov    0x115e8(%rip),%rax        # 52000 <current>
   40a18:	48 89 c7             	mov    %rax,%rdi
   40a1b:	e8 23 fd ff ff       	call   40743 <syscall_mem_tog>
	    break;
   40a20:	e9 31 03 00 00       	jmp    40d56 <exception+0x563>
	}

    case INT_TIMER:
        ++ticks;
   40a25:	8b 05 f5 23 01 00    	mov    0x123f5(%rip),%eax        # 52e20 <ticks>
   40a2b:	83 c0 01             	add    $0x1,%eax
   40a2e:	89 05 ec 23 01 00    	mov    %eax,0x123ec(%rip)        # 52e20 <ticks>
        schedule();
   40a34:	e8 46 03 00 00       	call   40d7f <schedule>
        break;                  /* will not be reached */
   40a39:	e9 18 03 00 00       	jmp    40d56 <exception+0x563>
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
   40a63:	b8 09 43 04 00       	mov    $0x44309,%eax
   40a68:	eb 05                	jmp    40a6f <exception+0x27c>
   40a6a:	b8 0f 43 04 00       	mov    $0x4430f,%eax
        const char* operation = reg->reg_err & PFERR_WRITE
   40a6f:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        const char* problem = reg->reg_err & PFERR_PRESENT
   40a73:	48 8b 85 c8 fe ff ff 	mov    -0x138(%rbp),%rax
   40a7a:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40a81:	83 e0 01             	and    $0x1,%eax
                ? "protection problem" : "missing page";
   40a84:	48 85 c0             	test   %rax,%rax
   40a87:	74 07                	je     40a90 <exception+0x29d>
   40a89:	b8 14 43 04 00       	mov    $0x44314,%eax
   40a8e:	eb 05                	jmp    40a95 <exception+0x2a2>
   40a90:	b8 27 43 04 00       	mov    $0x44327,%eax
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
   40acf:	bf 38 43 04 00       	mov    $0x44338,%edi
   40ad4:	b8 00 00 00 00       	mov    $0x0,%eax
   40ad9:	e8 7b 1b 00 00       	call   42659 <panic>
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
   40b09:	ba 68 43 04 00       	mov    $0x44368,%edx
   40b0e:	be 00 0c 00 00       	mov    $0xc00,%esi
   40b13:	bf 80 07 00 00       	mov    $0x780,%edi
   40b18:	b8 00 00 00 00       	mov    $0x0,%eax
   40b1d:	e8 f9 35 00 00       	call   4411b <console_printf>
   40b22:	48 83 c4 10          	add    $0x10,%rsp
        current->p_state = P_BROKEN;
   40b26:	48 8b 05 d3 14 01 00 	mov    0x114d3(%rip),%rax        # 52000 <current>
   40b2d:	c7 80 c8 00 00 00 03 	movl   $0x3,0xc8(%rax)
   40b34:	00 00 00 
        break;
   40b37:	e9 1a 02 00 00       	jmp    40d56 <exception+0x563>
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
   40b59:	e9 f8 01 00 00       	jmp    40d56 <exception+0x563>
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
   40bdf:	e9 20 01 00 00       	jmp    40d04 <exception+0x511>
			vamapping map = virtual_memory_lookup(current->p_pagetable, va); // examining addr page by page
   40be4:	48 8b 05 15 14 01 00 	mov    0x11415(%rip),%rax        # 52000 <current>
   40beb:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40bf2:	48 8d 45 80          	lea    -0x80(%rbp),%rax
   40bf6:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40bfa:	48 89 ce             	mov    %rcx,%rsi
   40bfd:	48 89 c7             	mov    %rax,%rdi
   40c00:	e8 f9 21 00 00       	call   42dfe <virtual_memory_lookup>
			
			if (map.pn == -1) { // unused va
   40c05:	8b 45 80             	mov    -0x80(%rbp),%eax
   40c08:	83 f8 ff             	cmp    $0xffffffff,%eax
   40c0b:	0f 84 ea 00 00 00    	je     40cfb <exception+0x508>
				continue;
			}
			else if (map.perm == (PTE_P | PTE_U)) { // readonly permissions -- map but don't copy
   40c11:	8b 45 90             	mov    -0x70(%rbp),%eax
   40c14:	83 f8 05             	cmp    $0x5,%eax
   40c17:	75 5a                	jne    40c73 <exception+0x480>
				pageinfo[map.pn].refcount++;	
   40c19:	8b 45 80             	mov    -0x80(%rbp),%eax
   40c1c:	48 63 d0             	movslq %eax,%rdx
   40c1f:	0f b6 94 12 41 2e 05 	movzbl 0x52e41(%rdx,%rdx,1),%edx
   40c26:	00 
   40c27:	83 c2 01             	add    $0x1,%edx
   40c2a:	48 98                	cltq   
   40c2c:	88 94 00 41 2e 05 00 	mov    %dl,0x52e41(%rax,%rax,1)
				virtual_memory_map(processes[child_pid].p_pagetable, va, map.pa, PAGESIZE, map.perm);
   40c33:	8b 4d 90             	mov    -0x70(%rbp),%ecx
   40c36:	48 8b 7d 88          	mov    -0x78(%rbp),%rdi
   40c3a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40c3d:	48 63 d0             	movslq %eax,%rdx
   40c40:	48 89 d0             	mov    %rdx,%rax
   40c43:	48 c1 e0 03          	shl    $0x3,%rax
   40c47:	48 29 d0             	sub    %rdx,%rax
   40c4a:	48 c1 e0 05          	shl    $0x5,%rax
   40c4e:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   40c54:	48 8b 00             	mov    (%rax),%rax
   40c57:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   40c5b:	41 89 c8             	mov    %ecx,%r8d
   40c5e:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40c63:	48 89 fa             	mov    %rdi,%rdx
   40c66:	48 89 c7             	mov    %rax,%rdi
   40c69:	e8 ca 1d 00 00       	call   42a38 <virtual_memory_map>
   40c6e:	e9 89 00 00 00       	jmp    40cfc <exception+0x509>
			}
			else {
				uintptr_t free_page;
				if (next_free_page(&free_page) == 0) {
   40c73:	48 8d 85 78 ff ff ff 	lea    -0x88(%rbp),%rax
   40c7a:	48 89 c7             	mov    %rax,%rdi
   40c7d:	e8 b5 f6 ff ff       	call   40337 <next_free_page>
   40c82:	85 c0                	test   %eax,%eax
   40c84:	75 76                	jne    40cfc <exception+0x509>
					assign_physical_page(free_page, child_pid);
   40c86:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40c89:	0f be d0             	movsbl %al,%edx
   40c8c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   40c93:	89 d6                	mov    %edx,%esi
   40c95:	48 89 c7             	mov    %rax,%rdi
   40c98:	e8 69 f9 ff ff       	call   40606 <assign_physical_page>
					virtual_memory_map(processes[child_pid].p_pagetable, va, free_page, PAGESIZE, map.perm);
   40c9d:	8b 4d 90             	mov    -0x70(%rbp),%ecx
   40ca0:	48 8b bd 78 ff ff ff 	mov    -0x88(%rbp),%rdi
   40ca7:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40caa:	48 63 d0             	movslq %eax,%rdx
   40cad:	48 89 d0             	mov    %rdx,%rax
   40cb0:	48 c1 e0 03          	shl    $0x3,%rax
   40cb4:	48 29 d0             	sub    %rdx,%rax
   40cb7:	48 c1 e0 05          	shl    $0x5,%rax
   40cbb:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   40cc1:	48 8b 00             	mov    (%rax),%rax
   40cc4:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   40cc8:	41 89 c8             	mov    %ecx,%r8d
   40ccb:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40cd0:	48 89 fa             	mov    %rdi,%rdx
   40cd3:	48 89 c7             	mov    %rax,%rdi
   40cd6:	e8 5d 1d 00 00       	call   42a38 <virtual_memory_map>
					memcpy((void *) free_page, (void *) map.pa, PAGESIZE);
   40cdb:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   40cdf:	48 89 c1             	mov    %rax,%rcx
   40ce2:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   40ce9:	ba 00 10 00 00       	mov    $0x1000,%edx
   40cee:	48 89 ce             	mov    %rcx,%rsi
   40cf1:	48 89 c7             	mov    %rax,%rdi
   40cf4:	e8 6d 25 00 00       	call   43266 <memcpy>
   40cf9:	eb 01                	jmp    40cfc <exception+0x509>
				continue;
   40cfb:	90                   	nop
		for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   40cfc:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40d03:	00 
   40d04:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   40d0b:	00 
   40d0c:	0f 86 d2 fe ff ff    	jbe    40be4 <exception+0x3f1>
			//	}
			//}
		}

		// set return values
		processes[child_pid].p_registers.reg_rax = 0;
   40d12:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40d15:	48 63 d0             	movslq %eax,%rdx
   40d18:	48 89 d0             	mov    %rdx,%rax
   40d1b:	48 c1 e0 03          	shl    $0x3,%rax
   40d1f:	48 29 d0             	sub    %rdx,%rax
   40d22:	48 c1 e0 05          	shl    $0x5,%rax
   40d26:	48 05 28 20 05 00    	add    $0x52028,%rax
   40d2c:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
		current->p_registers.reg_rax = child_pid;
   40d33:	48 8b 05 c6 12 01 00 	mov    0x112c6(%rip),%rax        # 52000 <current>
   40d3a:	8b 55 f4             	mov    -0xc(%rbp),%edx
   40d3d:	48 63 d2             	movslq %edx,%rdx
   40d40:	48 89 50 08          	mov    %rdx,0x8(%rax)
		break;
   40d44:	eb 10                	jmp    40d56 <exception+0x563>

    default:
        default_exception(current);
   40d46:	48 8b 05 b3 12 01 00 	mov    0x112b3(%rip),%rax        # 52000 <current>
   40d4d:	48 89 c7             	mov    %rax,%rdi
   40d50:	e8 14 1a 00 00       	call   42769 <default_exception>
        break;                  /* will not be reached */
   40d55:	90                   	nop

    }


    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   40d56:	48 8b 05 a3 12 01 00 	mov    0x112a3(%rip),%rax        # 52000 <current>
   40d5d:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   40d63:	83 f8 01             	cmp    $0x1,%eax
   40d66:	75 0f                	jne    40d77 <exception+0x584>
        run(current);
   40d68:	48 8b 05 91 12 01 00 	mov    0x11291(%rip),%rax        # 52000 <current>
   40d6f:	48 89 c7             	mov    %rax,%rdi
   40d72:	e8 7e 00 00 00       	call   40df5 <run>
    } else {
        schedule();
   40d77:	e8 03 00 00 00       	call   40d7f <schedule>
    }
}
   40d7c:	90                   	nop
   40d7d:	c9                   	leave  
   40d7e:	c3                   	ret    

0000000000040d7f <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   40d7f:	55                   	push   %rbp
   40d80:	48 89 e5             	mov    %rsp,%rbp
   40d83:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   40d87:	48 8b 05 72 12 01 00 	mov    0x11272(%rip),%rax        # 52000 <current>
   40d8e:	8b 00                	mov    (%rax),%eax
   40d90:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   40d93:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40d96:	8d 50 01             	lea    0x1(%rax),%edx
   40d99:	89 d0                	mov    %edx,%eax
   40d9b:	c1 f8 1f             	sar    $0x1f,%eax
   40d9e:	c1 e8 1c             	shr    $0x1c,%eax
   40da1:	01 c2                	add    %eax,%edx
   40da3:	83 e2 0f             	and    $0xf,%edx
   40da6:	29 c2                	sub    %eax,%edx
   40da8:	89 55 fc             	mov    %edx,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   40dab:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40dae:	48 63 d0             	movslq %eax,%rdx
   40db1:	48 89 d0             	mov    %rdx,%rax
   40db4:	48 c1 e0 03          	shl    $0x3,%rax
   40db8:	48 29 d0             	sub    %rdx,%rax
   40dbb:	48 c1 e0 05          	shl    $0x5,%rax
   40dbf:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   40dc5:	8b 00                	mov    (%rax),%eax
   40dc7:	83 f8 01             	cmp    $0x1,%eax
   40dca:	75 22                	jne    40dee <schedule+0x6f>
            run(&processes[pid]);
   40dcc:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40dcf:	48 63 d0             	movslq %eax,%rdx
   40dd2:	48 89 d0             	mov    %rdx,%rax
   40dd5:	48 c1 e0 03          	shl    $0x3,%rax
   40dd9:	48 29 d0             	sub    %rdx,%rax
   40ddc:	48 c1 e0 05          	shl    $0x5,%rax
   40de0:	48 05 20 20 05 00    	add    $0x52020,%rax
   40de6:	48 89 c7             	mov    %rax,%rdi
   40de9:	e8 07 00 00 00       	call   40df5 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   40dee:	e8 25 17 00 00       	call   42518 <check_keyboard>
        pid = (pid + 1) % NPROC;
   40df3:	eb 9e                	jmp    40d93 <schedule+0x14>

0000000000040df5 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   40df5:	55                   	push   %rbp
   40df6:	48 89 e5             	mov    %rsp,%rbp
   40df9:	48 83 ec 10          	sub    $0x10,%rsp
   40dfd:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   40e01:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e05:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   40e0b:	83 f8 01             	cmp    $0x1,%eax
   40e0e:	74 14                	je     40e24 <run+0x2f>
   40e10:	ba f0 44 04 00       	mov    $0x444f0,%edx
   40e15:	be dc 01 00 00       	mov    $0x1dc,%esi
   40e1a:	bf e0 42 04 00       	mov    $0x442e0,%edi
   40e1f:	e8 15 19 00 00       	call   42739 <assert_fail>
    current = p;
   40e24:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e28:	48 89 05 d1 11 01 00 	mov    %rax,0x111d1(%rip)        # 52000 <current>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   40e2f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e33:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40e3a:	48 89 c7             	mov    %rax,%rdi
   40e3d:	e8 c5 1a 00 00       	call   42907 <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   40e42:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e46:	48 83 c0 08          	add    $0x8,%rax
   40e4a:	48 89 c7             	mov    %rax,%rdi
   40e4d:	e8 71 f2 ff ff       	call   400c3 <exception_return>

0000000000040e52 <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   40e52:	55                   	push   %rbp
   40e53:	48 89 e5             	mov    %rsp,%rbp
   40e56:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40e5a:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40e61:	00 
   40e62:	e9 81 00 00 00       	jmp    40ee8 <pageinfo_init+0x96>
        int owner;
        if (physical_memory_isreserved(addr)) {
   40e67:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e6b:	48 89 c7             	mov    %rax,%rdi
   40e6e:	e8 33 0f 00 00       	call   41da6 <physical_memory_isreserved>
   40e73:	85 c0                	test   %eax,%eax
   40e75:	74 09                	je     40e80 <pageinfo_init+0x2e>
            owner = PO_RESERVED;
   40e77:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   40e7e:	eb 2f                	jmp    40eaf <pageinfo_init+0x5d>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   40e80:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   40e87:	00 
   40e88:	76 0b                	jbe    40e95 <pageinfo_init+0x43>
   40e8a:	b8 08 b0 05 00       	mov    $0x5b008,%eax
   40e8f:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40e93:	72 0a                	jb     40e9f <pageinfo_init+0x4d>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   40e95:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   40e9c:	00 
   40e9d:	75 09                	jne    40ea8 <pageinfo_init+0x56>
            owner = PO_KERNEL;
   40e9f:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   40ea6:	eb 07                	jmp    40eaf <pageinfo_init+0x5d>
        } else {
            owner = PO_FREE;
   40ea8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40eaf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40eb3:	48 c1 e8 0c          	shr    $0xc,%rax
   40eb7:	89 c1                	mov    %eax,%ecx
   40eb9:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40ebc:	89 c2                	mov    %eax,%edx
   40ebe:	48 63 c1             	movslq %ecx,%rax
   40ec1:	88 94 00 40 2e 05 00 	mov    %dl,0x52e40(%rax,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   40ec8:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40ecc:	0f 95 c2             	setne  %dl
   40ecf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40ed3:	48 c1 e8 0c          	shr    $0xc,%rax
   40ed7:	48 98                	cltq   
   40ed9:	88 94 00 41 2e 05 00 	mov    %dl,0x52e41(%rax,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40ee0:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40ee7:	00 
   40ee8:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40eef:	00 
   40ef0:	0f 86 71 ff ff ff    	jbe    40e67 <pageinfo_init+0x15>
    }
}
   40ef6:	90                   	nop
   40ef7:	90                   	nop
   40ef8:	c9                   	leave  
   40ef9:	c3                   	ret    

0000000000040efa <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   40efa:	55                   	push   %rbp
   40efb:	48 89 e5             	mov    %rsp,%rbp
   40efe:	48 83 ec 50          	sub    $0x50,%rsp
   40f02:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   40f06:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40f0a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40f10:	48 89 c2             	mov    %rax,%rdx
   40f13:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40f17:	48 39 c2             	cmp    %rax,%rdx
   40f1a:	74 14                	je     40f30 <check_page_table_mappings+0x36>
   40f1c:	ba 10 45 04 00       	mov    $0x44510,%edx
   40f21:	be 06 02 00 00       	mov    $0x206,%esi
   40f26:	bf e0 42 04 00       	mov    $0x442e0,%edi
   40f2b:	e8 09 18 00 00       	call   42739 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40f30:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   40f37:	00 
   40f38:	e9 9a 00 00 00       	jmp    40fd7 <check_page_table_mappings+0xdd>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   40f3d:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   40f41:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40f45:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40f49:	48 89 ce             	mov    %rcx,%rsi
   40f4c:	48 89 c7             	mov    %rax,%rdi
   40f4f:	e8 aa 1e 00 00       	call   42dfe <virtual_memory_lookup>
        if (vam.pa != va) {
   40f54:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40f58:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40f5c:	74 27                	je     40f85 <check_page_table_mappings+0x8b>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   40f5e:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40f62:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40f66:	49 89 d0             	mov    %rdx,%r8
   40f69:	48 89 c1             	mov    %rax,%rcx
   40f6c:	ba 2f 45 04 00       	mov    $0x4452f,%edx
   40f71:	be 00 c0 00 00       	mov    $0xc000,%esi
   40f76:	bf e0 06 00 00       	mov    $0x6e0,%edi
   40f7b:	b8 00 00 00 00       	mov    $0x0,%eax
   40f80:	e8 96 31 00 00       	call   4411b <console_printf>
        }
        assert(vam.pa == va);
   40f85:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40f89:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40f8d:	74 14                	je     40fa3 <check_page_table_mappings+0xa9>
   40f8f:	ba 39 45 04 00       	mov    $0x44539,%edx
   40f94:	be 0f 02 00 00       	mov    $0x20f,%esi
   40f99:	bf e0 42 04 00       	mov    $0x442e0,%edi
   40f9e:	e8 96 17 00 00       	call   42739 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   40fa3:	b8 00 50 04 00       	mov    $0x45000,%eax
   40fa8:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40fac:	72 21                	jb     40fcf <check_page_table_mappings+0xd5>
            assert(vam.perm & PTE_W);
   40fae:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40fb1:	48 98                	cltq   
   40fb3:	83 e0 02             	and    $0x2,%eax
   40fb6:	48 85 c0             	test   %rax,%rax
   40fb9:	75 14                	jne    40fcf <check_page_table_mappings+0xd5>
   40fbb:	ba 46 45 04 00       	mov    $0x44546,%edx
   40fc0:	be 11 02 00 00       	mov    $0x211,%esi
   40fc5:	bf e0 42 04 00       	mov    $0x442e0,%edi
   40fca:	e8 6a 17 00 00       	call   42739 <assert_fail>
         va += PAGESIZE) {
   40fcf:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40fd6:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40fd7:	b8 08 b0 05 00       	mov    $0x5b008,%eax
   40fdc:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40fe0:	0f 82 57 ff ff ff    	jb     40f3d <check_page_table_mappings+0x43>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   40fe6:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   40fed:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   40fee:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   40ff2:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40ff6:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40ffa:	48 89 ce             	mov    %rcx,%rsi
   40ffd:	48 89 c7             	mov    %rax,%rdi
   41000:	e8 f9 1d 00 00       	call   42dfe <virtual_memory_lookup>
    assert(vam.pa == kstack);
   41005:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41009:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   4100d:	74 14                	je     41023 <check_page_table_mappings+0x129>
   4100f:	ba 57 45 04 00       	mov    $0x44557,%edx
   41014:	be 18 02 00 00       	mov    $0x218,%esi
   41019:	bf e0 42 04 00       	mov    $0x442e0,%edi
   4101e:	e8 16 17 00 00       	call   42739 <assert_fail>
    assert(vam.perm & PTE_W);
   41023:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41026:	48 98                	cltq   
   41028:	83 e0 02             	and    $0x2,%eax
   4102b:	48 85 c0             	test   %rax,%rax
   4102e:	75 14                	jne    41044 <check_page_table_mappings+0x14a>
   41030:	ba 46 45 04 00       	mov    $0x44546,%edx
   41035:	be 19 02 00 00       	mov    $0x219,%esi
   4103a:	bf e0 42 04 00       	mov    $0x442e0,%edi
   4103f:	e8 f5 16 00 00       	call   42739 <assert_fail>
}
   41044:	90                   	nop
   41045:	c9                   	leave  
   41046:	c3                   	ret    

0000000000041047 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   41047:	55                   	push   %rbp
   41048:	48 89 e5             	mov    %rsp,%rbp
   4104b:	48 83 ec 20          	sub    $0x20,%rsp
   4104f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   41053:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   41056:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   41059:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   4105c:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   41063:	48 8b 05 96 3f 01 00 	mov    0x13f96(%rip),%rax        # 55000 <kernel_pagetable>
   4106a:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   4106e:	75 67                	jne    410d7 <check_page_table_ownership+0x90>
        owner = PO_KERNEL;
   41070:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   41077:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   4107e:	eb 51                	jmp    410d1 <check_page_table_ownership+0x8a>
            if (processes[xpid].p_state != P_FREE
   41080:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41083:	48 63 d0             	movslq %eax,%rdx
   41086:	48 89 d0             	mov    %rdx,%rax
   41089:	48 c1 e0 03          	shl    $0x3,%rax
   4108d:	48 29 d0             	sub    %rdx,%rax
   41090:	48 c1 e0 05          	shl    $0x5,%rax
   41094:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   4109a:	8b 00                	mov    (%rax),%eax
   4109c:	85 c0                	test   %eax,%eax
   4109e:	74 2d                	je     410cd <check_page_table_ownership+0x86>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   410a0:	8b 45 f4             	mov    -0xc(%rbp),%eax
   410a3:	48 63 d0             	movslq %eax,%rdx
   410a6:	48 89 d0             	mov    %rdx,%rax
   410a9:	48 c1 e0 03          	shl    $0x3,%rax
   410ad:	48 29 d0             	sub    %rdx,%rax
   410b0:	48 c1 e0 05          	shl    $0x5,%rax
   410b4:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   410ba:	48 8b 10             	mov    (%rax),%rdx
   410bd:	48 8b 05 3c 3f 01 00 	mov    0x13f3c(%rip),%rax        # 55000 <kernel_pagetable>
   410c4:	48 39 c2             	cmp    %rax,%rdx
   410c7:	75 04                	jne    410cd <check_page_table_ownership+0x86>
                ++expected_refcount;
   410c9:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   410cd:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   410d1:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   410d5:	7e a9                	jle    41080 <check_page_table_ownership+0x39>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   410d7:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   410da:	8b 55 fc             	mov    -0x4(%rbp),%edx
   410dd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   410e1:	be 00 00 00 00       	mov    $0x0,%esi
   410e6:	48 89 c7             	mov    %rax,%rdi
   410e9:	e8 03 00 00 00       	call   410f1 <check_page_table_ownership_level>
}
   410ee:	90                   	nop
   410ef:	c9                   	leave  
   410f0:	c3                   	ret    

00000000000410f1 <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   410f1:	55                   	push   %rbp
   410f2:	48 89 e5             	mov    %rsp,%rbp
   410f5:	48 83 ec 30          	sub    $0x30,%rsp
   410f9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   410fd:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   41100:	89 55 e0             	mov    %edx,-0x20(%rbp)
   41103:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   41106:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4110a:	48 c1 e8 0c          	shr    $0xc,%rax
   4110e:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   41113:	7e 14                	jle    41129 <check_page_table_ownership_level+0x38>
   41115:	ba 68 45 04 00       	mov    $0x44568,%edx
   4111a:	be 36 02 00 00       	mov    $0x236,%esi
   4111f:	bf e0 42 04 00       	mov    $0x442e0,%edi
   41124:	e8 10 16 00 00       	call   42739 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   41129:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4112d:	48 c1 e8 0c          	shr    $0xc,%rax
   41131:	48 98                	cltq   
   41133:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   4113a:	00 
   4113b:	0f be c0             	movsbl %al,%eax
   4113e:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   41141:	74 14                	je     41157 <check_page_table_ownership_level+0x66>
   41143:	ba 80 45 04 00       	mov    $0x44580,%edx
   41148:	be 37 02 00 00       	mov    $0x237,%esi
   4114d:	bf e0 42 04 00       	mov    $0x442e0,%edi
   41152:	e8 e2 15 00 00       	call   42739 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   41157:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4115b:	48 c1 e8 0c          	shr    $0xc,%rax
   4115f:	48 98                	cltq   
   41161:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   41168:	00 
   41169:	0f be c0             	movsbl %al,%eax
   4116c:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   4116f:	74 14                	je     41185 <check_page_table_ownership_level+0x94>
   41171:	ba a8 45 04 00       	mov    $0x445a8,%edx
   41176:	be 38 02 00 00       	mov    $0x238,%esi
   4117b:	bf e0 42 04 00       	mov    $0x442e0,%edi
   41180:	e8 b4 15 00 00       	call   42739 <assert_fail>
    if (level < 3) {
   41185:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   41189:	7f 5b                	jg     411e6 <check_page_table_ownership_level+0xf5>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   4118b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41192:	eb 49                	jmp    411dd <check_page_table_ownership_level+0xec>
            if (pt->entry[index]) {
   41194:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41198:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4119b:	48 63 d2             	movslq %edx,%rdx
   4119e:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   411a2:	48 85 c0             	test   %rax,%rax
   411a5:	74 32                	je     411d9 <check_page_table_ownership_level+0xe8>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   411a7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   411ab:	8b 55 fc             	mov    -0x4(%rbp),%edx
   411ae:	48 63 d2             	movslq %edx,%rdx
   411b1:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   411b5:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   411bb:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   411bf:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   411c2:	8d 70 01             	lea    0x1(%rax),%esi
   411c5:	8b 55 e0             	mov    -0x20(%rbp),%edx
   411c8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   411cc:	b9 01 00 00 00       	mov    $0x1,%ecx
   411d1:	48 89 c7             	mov    %rax,%rdi
   411d4:	e8 18 ff ff ff       	call   410f1 <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   411d9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   411dd:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   411e4:	7e ae                	jle    41194 <check_page_table_ownership_level+0xa3>
            }
        }
    }
}
   411e6:	90                   	nop
   411e7:	c9                   	leave  
   411e8:	c3                   	ret    

00000000000411e9 <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   411e9:	55                   	push   %rbp
   411ea:	48 89 e5             	mov    %rsp,%rbp
   411ed:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   411f1:	8b 05 f1 0e 01 00    	mov    0x10ef1(%rip),%eax        # 520e8 <processes+0xc8>
   411f7:	85 c0                	test   %eax,%eax
   411f9:	74 14                	je     4120f <check_virtual_memory+0x26>
   411fb:	ba d8 45 04 00       	mov    $0x445d8,%edx
   41200:	be 4b 02 00 00       	mov    $0x24b,%esi
   41205:	bf e0 42 04 00       	mov    $0x442e0,%edi
   4120a:	e8 2a 15 00 00       	call   42739 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   4120f:	48 8b 05 ea 3d 01 00 	mov    0x13dea(%rip),%rax        # 55000 <kernel_pagetable>
   41216:	48 89 c7             	mov    %rax,%rdi
   41219:	e8 dc fc ff ff       	call   40efa <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   4121e:	48 8b 05 db 3d 01 00 	mov    0x13ddb(%rip),%rax        # 55000 <kernel_pagetable>
   41225:	be ff ff ff ff       	mov    $0xffffffff,%esi
   4122a:	48 89 c7             	mov    %rax,%rdi
   4122d:	e8 15 fe ff ff       	call   41047 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   41232:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41239:	e9 9c 00 00 00       	jmp    412da <check_virtual_memory+0xf1>
        if (processes[pid].p_state != P_FREE
   4123e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41241:	48 63 d0             	movslq %eax,%rdx
   41244:	48 89 d0             	mov    %rdx,%rax
   41247:	48 c1 e0 03          	shl    $0x3,%rax
   4124b:	48 29 d0             	sub    %rdx,%rax
   4124e:	48 c1 e0 05          	shl    $0x5,%rax
   41252:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   41258:	8b 00                	mov    (%rax),%eax
   4125a:	85 c0                	test   %eax,%eax
   4125c:	74 78                	je     412d6 <check_virtual_memory+0xed>
            && processes[pid].p_pagetable != kernel_pagetable) {
   4125e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41261:	48 63 d0             	movslq %eax,%rdx
   41264:	48 89 d0             	mov    %rdx,%rax
   41267:	48 c1 e0 03          	shl    $0x3,%rax
   4126b:	48 29 d0             	sub    %rdx,%rax
   4126e:	48 c1 e0 05          	shl    $0x5,%rax
   41272:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   41278:	48 8b 10             	mov    (%rax),%rdx
   4127b:	48 8b 05 7e 3d 01 00 	mov    0x13d7e(%rip),%rax        # 55000 <kernel_pagetable>
   41282:	48 39 c2             	cmp    %rax,%rdx
   41285:	74 4f                	je     412d6 <check_virtual_memory+0xed>
            check_page_table_mappings(processes[pid].p_pagetable);
   41287:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4128a:	48 63 d0             	movslq %eax,%rdx
   4128d:	48 89 d0             	mov    %rdx,%rax
   41290:	48 c1 e0 03          	shl    $0x3,%rax
   41294:	48 29 d0             	sub    %rdx,%rax
   41297:	48 c1 e0 05          	shl    $0x5,%rax
   4129b:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   412a1:	48 8b 00             	mov    (%rax),%rax
   412a4:	48 89 c7             	mov    %rax,%rdi
   412a7:	e8 4e fc ff ff       	call   40efa <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   412ac:	8b 45 fc             	mov    -0x4(%rbp),%eax
   412af:	48 63 d0             	movslq %eax,%rdx
   412b2:	48 89 d0             	mov    %rdx,%rax
   412b5:	48 c1 e0 03          	shl    $0x3,%rax
   412b9:	48 29 d0             	sub    %rdx,%rax
   412bc:	48 c1 e0 05          	shl    $0x5,%rax
   412c0:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   412c6:	48 8b 00             	mov    (%rax),%rax
   412c9:	8b 55 fc             	mov    -0x4(%rbp),%edx
   412cc:	89 d6                	mov    %edx,%esi
   412ce:	48 89 c7             	mov    %rax,%rdi
   412d1:	e8 71 fd ff ff       	call   41047 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   412d6:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   412da:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   412de:	0f 8e 5a ff ff ff    	jle    4123e <check_virtual_memory+0x55>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   412e4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   412eb:	eb 67                	jmp    41354 <check_virtual_memory+0x16b>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   412ed:	8b 45 f8             	mov    -0x8(%rbp),%eax
   412f0:	48 98                	cltq   
   412f2:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   412f9:	00 
   412fa:	84 c0                	test   %al,%al
   412fc:	7e 52                	jle    41350 <check_virtual_memory+0x167>
   412fe:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41301:	48 98                	cltq   
   41303:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   4130a:	00 
   4130b:	84 c0                	test   %al,%al
   4130d:	78 41                	js     41350 <check_virtual_memory+0x167>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   4130f:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41312:	48 98                	cltq   
   41314:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   4131b:	00 
   4131c:	0f be c0             	movsbl %al,%eax
   4131f:	48 63 d0             	movslq %eax,%rdx
   41322:	48 89 d0             	mov    %rdx,%rax
   41325:	48 c1 e0 03          	shl    $0x3,%rax
   41329:	48 29 d0             	sub    %rdx,%rax
   4132c:	48 c1 e0 05          	shl    $0x5,%rax
   41330:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   41336:	8b 00                	mov    (%rax),%eax
   41338:	85 c0                	test   %eax,%eax
   4133a:	75 14                	jne    41350 <check_virtual_memory+0x167>
   4133c:	ba f8 45 04 00       	mov    $0x445f8,%edx
   41341:	be 62 02 00 00       	mov    $0x262,%esi
   41346:	bf e0 42 04 00       	mov    $0x442e0,%edi
   4134b:	e8 e9 13 00 00       	call   42739 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41350:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41354:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   4135b:	7e 90                	jle    412ed <check_virtual_memory+0x104>
        }
    }
}
   4135d:	90                   	nop
   4135e:	90                   	nop
   4135f:	c9                   	leave  
   41360:	c3                   	ret    

0000000000041361 <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   41361:	55                   	push   %rbp
   41362:	48 89 e5             	mov    %rsp,%rbp
   41365:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   41369:	ba 66 46 04 00       	mov    $0x44666,%edx
   4136e:	be 00 0f 00 00       	mov    $0xf00,%esi
   41373:	bf 20 00 00 00       	mov    $0x20,%edi
   41378:	b8 00 00 00 00       	mov    $0x0,%eax
   4137d:	e8 99 2d 00 00       	call   4411b <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41382:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41389:	e9 f8 00 00 00       	jmp    41486 <memshow_physical+0x125>
        if (pn % 64 == 0) {
   4138e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41391:	83 e0 3f             	and    $0x3f,%eax
   41394:	85 c0                	test   %eax,%eax
   41396:	75 3c                	jne    413d4 <memshow_physical+0x73>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   41398:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4139b:	c1 e0 0c             	shl    $0xc,%eax
   4139e:	89 c1                	mov    %eax,%ecx
   413a0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   413a3:	8d 50 3f             	lea    0x3f(%rax),%edx
   413a6:	85 c0                	test   %eax,%eax
   413a8:	0f 48 c2             	cmovs  %edx,%eax
   413ab:	c1 f8 06             	sar    $0x6,%eax
   413ae:	8d 50 01             	lea    0x1(%rax),%edx
   413b1:	89 d0                	mov    %edx,%eax
   413b3:	c1 e0 02             	shl    $0x2,%eax
   413b6:	01 d0                	add    %edx,%eax
   413b8:	c1 e0 04             	shl    $0x4,%eax
   413bb:	83 c0 03             	add    $0x3,%eax
   413be:	ba 76 46 04 00       	mov    $0x44676,%edx
   413c3:	be 00 0f 00 00       	mov    $0xf00,%esi
   413c8:	89 c7                	mov    %eax,%edi
   413ca:	b8 00 00 00 00       	mov    $0x0,%eax
   413cf:	e8 47 2d 00 00       	call   4411b <console_printf>
        }

        int owner = pageinfo[pn].owner;
   413d4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   413d7:	48 98                	cltq   
   413d9:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   413e0:	00 
   413e1:	0f be c0             	movsbl %al,%eax
   413e4:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   413e7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   413ea:	48 98                	cltq   
   413ec:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   413f3:	00 
   413f4:	84 c0                	test   %al,%al
   413f6:	75 07                	jne    413ff <memshow_physical+0x9e>
            owner = PO_FREE;
   413f8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   413ff:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41402:	83 c0 02             	add    $0x2,%eax
   41405:	48 98                	cltq   
   41407:	0f b7 84 00 40 46 04 	movzwl 0x44640(%rax,%rax,1),%eax
   4140e:	00 
   4140f:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   41413:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41416:	48 98                	cltq   
   41418:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   4141f:	00 
   41420:	3c 01                	cmp    $0x1,%al
   41422:	7e 1a                	jle    4143e <memshow_physical+0xdd>
   41424:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   41429:	48 c1 e8 0c          	shr    $0xc,%rax
   4142d:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   41430:	74 0c                	je     4143e <memshow_physical+0xdd>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   41432:	b8 53 00 00 00       	mov    $0x53,%eax
   41437:	80 cc 0f             	or     $0xf,%ah
   4143a:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   4143e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41441:	8d 50 3f             	lea    0x3f(%rax),%edx
   41444:	85 c0                	test   %eax,%eax
   41446:	0f 48 c2             	cmovs  %edx,%eax
   41449:	c1 f8 06             	sar    $0x6,%eax
   4144c:	8d 50 01             	lea    0x1(%rax),%edx
   4144f:	89 d0                	mov    %edx,%eax
   41451:	c1 e0 02             	shl    $0x2,%eax
   41454:	01 d0                	add    %edx,%eax
   41456:	c1 e0 04             	shl    $0x4,%eax
   41459:	89 c1                	mov    %eax,%ecx
   4145b:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4145e:	89 d0                	mov    %edx,%eax
   41460:	c1 f8 1f             	sar    $0x1f,%eax
   41463:	c1 e8 1a             	shr    $0x1a,%eax
   41466:	01 c2                	add    %eax,%edx
   41468:	83 e2 3f             	and    $0x3f,%edx
   4146b:	29 c2                	sub    %eax,%edx
   4146d:	89 d0                	mov    %edx,%eax
   4146f:	83 c0 0c             	add    $0xc,%eax
   41472:	01 c8                	add    %ecx,%eax
   41474:	48 98                	cltq   
   41476:	0f b7 55 f6          	movzwl -0xa(%rbp),%edx
   4147a:	66 89 94 00 00 80 0b 	mov    %dx,0xb8000(%rax,%rax,1)
   41481:	00 
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41482:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41486:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   4148d:	0f 8e fb fe ff ff    	jle    4138e <memshow_physical+0x2d>
    }
}
   41493:	90                   	nop
   41494:	90                   	nop
   41495:	c9                   	leave  
   41496:	c3                   	ret    

0000000000041497 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   41497:	55                   	push   %rbp
   41498:	48 89 e5             	mov    %rsp,%rbp
   4149b:	48 83 ec 40          	sub    $0x40,%rsp
   4149f:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   414a3:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   414a7:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   414ab:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   414b1:	48 89 c2             	mov    %rax,%rdx
   414b4:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   414b8:	48 39 c2             	cmp    %rax,%rdx
   414bb:	74 14                	je     414d1 <memshow_virtual+0x3a>
   414bd:	ba 80 46 04 00       	mov    $0x44680,%edx
   414c2:	be 93 02 00 00       	mov    $0x293,%esi
   414c7:	bf e0 42 04 00       	mov    $0x442e0,%edi
   414cc:	e8 68 12 00 00       	call   42739 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   414d1:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   414d5:	48 89 c1             	mov    %rax,%rcx
   414d8:	ba ad 46 04 00       	mov    $0x446ad,%edx
   414dd:	be 00 0f 00 00       	mov    $0xf00,%esi
   414e2:	bf 3a 03 00 00       	mov    $0x33a,%edi
   414e7:	b8 00 00 00 00       	mov    $0x0,%eax
   414ec:	e8 2a 2c 00 00       	call   4411b <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   414f1:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   414f8:	00 
   414f9:	e9 80 01 00 00       	jmp    4167e <memshow_virtual+0x1e7>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   414fe:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   41502:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   41506:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   4150a:	48 89 ce             	mov    %rcx,%rsi
   4150d:	48 89 c7             	mov    %rax,%rdi
   41510:	e8 e9 18 00 00       	call   42dfe <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   41515:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41518:	85 c0                	test   %eax,%eax
   4151a:	79 0b                	jns    41527 <memshow_virtual+0x90>
            color = ' ';
   4151c:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   41522:	e9 d7 00 00 00       	jmp    415fe <memshow_virtual+0x167>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   41527:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4152b:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   41531:	76 14                	jbe    41547 <memshow_virtual+0xb0>
   41533:	ba ca 46 04 00       	mov    $0x446ca,%edx
   41538:	be 9c 02 00 00       	mov    $0x29c,%esi
   4153d:	bf e0 42 04 00       	mov    $0x442e0,%edi
   41542:	e8 f2 11 00 00       	call   42739 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   41547:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4154a:	48 98                	cltq   
   4154c:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   41553:	00 
   41554:	0f be c0             	movsbl %al,%eax
   41557:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   4155a:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4155d:	48 98                	cltq   
   4155f:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   41566:	00 
   41567:	84 c0                	test   %al,%al
   41569:	75 07                	jne    41572 <memshow_virtual+0xdb>
                owner = PO_FREE;
   4156b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   41572:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41575:	83 c0 02             	add    $0x2,%eax
   41578:	48 98                	cltq   
   4157a:	0f b7 84 00 40 46 04 	movzwl 0x44640(%rax,%rax,1),%eax
   41581:	00 
   41582:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   41586:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41589:	48 98                	cltq   
   4158b:	83 e0 04             	and    $0x4,%eax
   4158e:	48 85 c0             	test   %rax,%rax
   41591:	74 27                	je     415ba <memshow_virtual+0x123>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41593:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41597:	c1 e0 04             	shl    $0x4,%eax
   4159a:	66 25 00 f0          	and    $0xf000,%ax
   4159e:	89 c2                	mov    %eax,%edx
   415a0:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   415a4:	c1 f8 04             	sar    $0x4,%eax
   415a7:	66 25 00 0f          	and    $0xf00,%ax
   415ab:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   415ad:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   415b1:	0f b6 c0             	movzbl %al,%eax
   415b4:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   415b6:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   415ba:	8b 45 d0             	mov    -0x30(%rbp),%eax
   415bd:	48 98                	cltq   
   415bf:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   415c6:	00 
   415c7:	3c 01                	cmp    $0x1,%al
   415c9:	7e 33                	jle    415fe <memshow_virtual+0x167>
   415cb:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   415d0:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   415d4:	74 28                	je     415fe <memshow_virtual+0x167>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   415d6:	b8 53 00 00 00       	mov    $0x53,%eax
   415db:	89 c2                	mov    %eax,%edx
   415dd:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   415e1:	66 25 00 f0          	and    $0xf000,%ax
   415e5:	09 d0                	or     %edx,%eax
   415e7:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   415eb:	8b 45 e0             	mov    -0x20(%rbp),%eax
   415ee:	48 98                	cltq   
   415f0:	83 e0 04             	and    $0x4,%eax
   415f3:	48 85 c0             	test   %rax,%rax
   415f6:	75 06                	jne    415fe <memshow_virtual+0x167>
                    color = color | 0x0F00;
   415f8:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   415fe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41602:	48 c1 e8 0c          	shr    $0xc,%rax
   41606:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   41609:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4160c:	83 e0 3f             	and    $0x3f,%eax
   4160f:	85 c0                	test   %eax,%eax
   41611:	75 34                	jne    41647 <memshow_virtual+0x1b0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   41613:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41616:	c1 e8 06             	shr    $0x6,%eax
   41619:	89 c2                	mov    %eax,%edx
   4161b:	89 d0                	mov    %edx,%eax
   4161d:	c1 e0 02             	shl    $0x2,%eax
   41620:	01 d0                	add    %edx,%eax
   41622:	c1 e0 04             	shl    $0x4,%eax
   41625:	05 73 03 00 00       	add    $0x373,%eax
   4162a:	89 c7                	mov    %eax,%edi
   4162c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41630:	48 89 c1             	mov    %rax,%rcx
   41633:	ba 76 46 04 00       	mov    $0x44676,%edx
   41638:	be 00 0f 00 00       	mov    $0xf00,%esi
   4163d:	b8 00 00 00 00       	mov    $0x0,%eax
   41642:	e8 d4 2a 00 00       	call   4411b <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   41647:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4164a:	c1 e8 06             	shr    $0x6,%eax
   4164d:	89 c2                	mov    %eax,%edx
   4164f:	89 d0                	mov    %edx,%eax
   41651:	c1 e0 02             	shl    $0x2,%eax
   41654:	01 d0                	add    %edx,%eax
   41656:	c1 e0 04             	shl    $0x4,%eax
   41659:	89 c2                	mov    %eax,%edx
   4165b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4165e:	83 e0 3f             	and    $0x3f,%eax
   41661:	01 d0                	add    %edx,%eax
   41663:	05 7c 03 00 00       	add    $0x37c,%eax
   41668:	89 c2                	mov    %eax,%edx
   4166a:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4166e:	66 89 84 12 00 80 0b 	mov    %ax,0xb8000(%rdx,%rdx,1)
   41675:	00 
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41676:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4167d:	00 
   4167e:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   41685:	00 
   41686:	0f 86 72 fe ff ff    	jbe    414fe <memshow_virtual+0x67>
    }
}
   4168c:	90                   	nop
   4168d:	90                   	nop
   4168e:	c9                   	leave  
   4168f:	c3                   	ret    

0000000000041690 <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   41690:	55                   	push   %rbp
   41691:	48 89 e5             	mov    %rsp,%rbp
   41694:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   41698:	8b 05 a2 1b 01 00    	mov    0x11ba2(%rip),%eax        # 53240 <last_ticks.1>
   4169e:	85 c0                	test   %eax,%eax
   416a0:	74 13                	je     416b5 <memshow_virtual_animate+0x25>
   416a2:	8b 15 78 17 01 00    	mov    0x11778(%rip),%edx        # 52e20 <ticks>
   416a8:	8b 05 92 1b 01 00    	mov    0x11b92(%rip),%eax        # 53240 <last_ticks.1>
   416ae:	29 c2                	sub    %eax,%edx
   416b0:	83 fa 31             	cmp    $0x31,%edx
   416b3:	76 2c                	jbe    416e1 <memshow_virtual_animate+0x51>
        last_ticks = ticks;
   416b5:	8b 05 65 17 01 00    	mov    0x11765(%rip),%eax        # 52e20 <ticks>
   416bb:	89 05 7f 1b 01 00    	mov    %eax,0x11b7f(%rip)        # 53240 <last_ticks.1>
        ++showing;
   416c1:	8b 05 3d 39 00 00    	mov    0x393d(%rip),%eax        # 45004 <showing.0>
   416c7:	83 c0 01             	add    $0x1,%eax
   416ca:	89 05 34 39 00 00    	mov    %eax,0x3934(%rip)        # 45004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   416d0:	eb 0f                	jmp    416e1 <memshow_virtual_animate+0x51>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
        ++showing;
   416d2:	8b 05 2c 39 00 00    	mov    0x392c(%rip),%eax        # 45004 <showing.0>
   416d8:	83 c0 01             	add    $0x1,%eax
   416db:	89 05 23 39 00 00    	mov    %eax,0x3923(%rip)        # 45004 <showing.0>
    while (showing <= 2*NPROC
   416e1:	8b 05 1d 39 00 00    	mov    0x391d(%rip),%eax        # 45004 <showing.0>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
   416e7:	83 f8 20             	cmp    $0x20,%eax
   416ea:	7f 6d                	jg     41759 <memshow_virtual_animate+0xc9>
   416ec:	8b 15 12 39 00 00    	mov    0x3912(%rip),%edx        # 45004 <showing.0>
   416f2:	89 d0                	mov    %edx,%eax
   416f4:	c1 f8 1f             	sar    $0x1f,%eax
   416f7:	c1 e8 1c             	shr    $0x1c,%eax
   416fa:	01 c2                	add    %eax,%edx
   416fc:	83 e2 0f             	and    $0xf,%edx
   416ff:	29 c2                	sub    %eax,%edx
   41701:	89 d0                	mov    %edx,%eax
   41703:	48 63 d0             	movslq %eax,%rdx
   41706:	48 89 d0             	mov    %rdx,%rax
   41709:	48 c1 e0 03          	shl    $0x3,%rax
   4170d:	48 29 d0             	sub    %rdx,%rax
   41710:	48 c1 e0 05          	shl    $0x5,%rax
   41714:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   4171a:	8b 00                	mov    (%rax),%eax
   4171c:	85 c0                	test   %eax,%eax
   4171e:	74 b2                	je     416d2 <memshow_virtual_animate+0x42>
   41720:	8b 15 de 38 00 00    	mov    0x38de(%rip),%edx        # 45004 <showing.0>
   41726:	89 d0                	mov    %edx,%eax
   41728:	c1 f8 1f             	sar    $0x1f,%eax
   4172b:	c1 e8 1c             	shr    $0x1c,%eax
   4172e:	01 c2                	add    %eax,%edx
   41730:	83 e2 0f             	and    $0xf,%edx
   41733:	29 c2                	sub    %eax,%edx
   41735:	89 d0                	mov    %edx,%eax
   41737:	48 63 d0             	movslq %eax,%rdx
   4173a:	48 89 d0             	mov    %rdx,%rax
   4173d:	48 c1 e0 03          	shl    $0x3,%rax
   41741:	48 29 d0             	sub    %rdx,%rax
   41744:	48 c1 e0 05          	shl    $0x5,%rax
   41748:	48 05 f8 20 05 00    	add    $0x520f8,%rax
   4174e:	0f b6 00             	movzbl (%rax),%eax
   41751:	84 c0                	test   %al,%al
   41753:	0f 84 79 ff ff ff    	je     416d2 <memshow_virtual_animate+0x42>
    }
    showing = showing % NPROC;
   41759:	8b 15 a5 38 00 00    	mov    0x38a5(%rip),%edx        # 45004 <showing.0>
   4175f:	89 d0                	mov    %edx,%eax
   41761:	c1 f8 1f             	sar    $0x1f,%eax
   41764:	c1 e8 1c             	shr    $0x1c,%eax
   41767:	01 c2                	add    %eax,%edx
   41769:	83 e2 0f             	and    $0xf,%edx
   4176c:	29 c2                	sub    %eax,%edx
   4176e:	89 d0                	mov    %edx,%eax
   41770:	89 05 8e 38 00 00    	mov    %eax,0x388e(%rip)        # 45004 <showing.0>

    if (processes[showing].p_state != P_FREE) {
   41776:	8b 05 88 38 00 00    	mov    0x3888(%rip),%eax        # 45004 <showing.0>
   4177c:	48 63 d0             	movslq %eax,%rdx
   4177f:	48 89 d0             	mov    %rdx,%rax
   41782:	48 c1 e0 03          	shl    $0x3,%rax
   41786:	48 29 d0             	sub    %rdx,%rax
   41789:	48 c1 e0 05          	shl    $0x5,%rax
   4178d:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   41793:	8b 00                	mov    (%rax),%eax
   41795:	85 c0                	test   %eax,%eax
   41797:	74 52                	je     417eb <memshow_virtual_animate+0x15b>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   41799:	8b 15 65 38 00 00    	mov    0x3865(%rip),%edx        # 45004 <showing.0>
   4179f:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   417a3:	89 d1                	mov    %edx,%ecx
   417a5:	ba e4 46 04 00       	mov    $0x446e4,%edx
   417aa:	be 04 00 00 00       	mov    $0x4,%esi
   417af:	48 89 c7             	mov    %rax,%rdi
   417b2:	b8 00 00 00 00       	mov    $0x0,%eax
   417b7:	e8 6b 2a 00 00       	call   44227 <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   417bc:	8b 05 42 38 00 00    	mov    0x3842(%rip),%eax        # 45004 <showing.0>
   417c2:	48 63 d0             	movslq %eax,%rdx
   417c5:	48 89 d0             	mov    %rdx,%rax
   417c8:	48 c1 e0 03          	shl    $0x3,%rax
   417cc:	48 29 d0             	sub    %rdx,%rax
   417cf:	48 c1 e0 05          	shl    $0x5,%rax
   417d3:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   417d9:	48 8b 00             	mov    (%rax),%rax
   417dc:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   417e0:	48 89 d6             	mov    %rdx,%rsi
   417e3:	48 89 c7             	mov    %rax,%rdi
   417e6:	e8 ac fc ff ff       	call   41497 <memshow_virtual>
    }
}
   417eb:	90                   	nop
   417ec:	c9                   	leave  
   417ed:	c3                   	ret    

00000000000417ee <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   417ee:	55                   	push   %rbp
   417ef:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   417f2:	e8 4f 01 00 00       	call   41946 <segments_init>
    interrupt_init();
   417f7:	e8 d0 03 00 00       	call   41bcc <interrupt_init>
    virtual_memory_init();
   417fc:	e8 f3 0f 00 00       	call   427f4 <virtual_memory_init>
}
   41801:	90                   	nop
   41802:	5d                   	pop    %rbp
   41803:	c3                   	ret    

0000000000041804 <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   41804:	55                   	push   %rbp
   41805:	48 89 e5             	mov    %rsp,%rbp
   41808:	48 83 ec 18          	sub    $0x18,%rsp
   4180c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41810:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41814:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   41817:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4181a:	48 98                	cltq   
   4181c:	48 c1 e0 2d          	shl    $0x2d,%rax
   41820:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   41824:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   4182b:	90 00 00 
   4182e:	48 09 c2             	or     %rax,%rdx
    *segment = type
   41831:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41835:	48 89 10             	mov    %rdx,(%rax)
}
   41838:	90                   	nop
   41839:	c9                   	leave  
   4183a:	c3                   	ret    

000000000004183b <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   4183b:	55                   	push   %rbp
   4183c:	48 89 e5             	mov    %rsp,%rbp
   4183f:	48 83 ec 28          	sub    $0x28,%rsp
   41843:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41847:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   4184b:	89 55 ec             	mov    %edx,-0x14(%rbp)
   4184e:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   41852:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41856:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4185a:	48 c1 e0 10          	shl    $0x10,%rax
   4185e:	48 89 c2             	mov    %rax,%rdx
   41861:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   41868:	00 00 00 
   4186b:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   4186e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41872:	48 c1 e0 20          	shl    $0x20,%rax
   41876:	48 89 c1             	mov    %rax,%rcx
   41879:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   41880:	00 00 ff 
   41883:	48 21 c8             	and    %rcx,%rax
   41886:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   41889:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4188d:	48 83 e8 01          	sub    $0x1,%rax
   41891:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   41894:	48 09 d0             	or     %rdx,%rax
        | type
   41897:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   4189b:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4189e:	48 63 d2             	movslq %edx,%rdx
   418a1:	48 c1 e2 2d          	shl    $0x2d,%rdx
   418a5:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   418a8:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   418af:	80 00 00 
   418b2:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   418b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   418b9:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   418bc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   418c0:	48 83 c0 08          	add    $0x8,%rax
   418c4:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   418c8:	48 c1 ea 20          	shr    $0x20,%rdx
   418cc:	48 89 10             	mov    %rdx,(%rax)
}
   418cf:	90                   	nop
   418d0:	c9                   	leave  
   418d1:	c3                   	ret    

00000000000418d2 <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   418d2:	55                   	push   %rbp
   418d3:	48 89 e5             	mov    %rsp,%rbp
   418d6:	48 83 ec 20          	sub    $0x20,%rsp
   418da:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   418de:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   418e2:	89 55 ec             	mov    %edx,-0x14(%rbp)
   418e5:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   418e9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   418ed:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   418f0:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   418f4:	8b 55 ec             	mov    -0x14(%rbp),%edx
   418f7:	48 63 d2             	movslq %edx,%rdx
   418fa:	48 c1 e2 2d          	shl    $0x2d,%rdx
   418fe:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   41901:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41905:	48 c1 e0 20          	shl    $0x20,%rax
   41909:	48 89 c1             	mov    %rax,%rcx
   4190c:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   41913:	00 ff ff 
   41916:	48 21 c8             	and    %rcx,%rax
   41919:	48 09 c2             	or     %rax,%rdx
   4191c:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   41923:	80 00 00 
   41926:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41929:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4192d:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   41930:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41934:	48 c1 e8 20          	shr    $0x20,%rax
   41938:	48 89 c2             	mov    %rax,%rdx
   4193b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4193f:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   41943:	90                   	nop
   41944:	c9                   	leave  
   41945:	c3                   	ret    

0000000000041946 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   41946:	55                   	push   %rbp
   41947:	48 89 e5             	mov    %rsp,%rbp
   4194a:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   4194e:	48 c7 05 07 19 01 00 	movq   $0x0,0x11907(%rip)        # 53260 <segments>
   41955:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   41959:	ba 00 00 00 00       	mov    $0x0,%edx
   4195e:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41965:	08 20 00 
   41968:	48 89 c6             	mov    %rax,%rsi
   4196b:	bf 68 32 05 00       	mov    $0x53268,%edi
   41970:	e8 8f fe ff ff       	call   41804 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   41975:	ba 03 00 00 00       	mov    $0x3,%edx
   4197a:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41981:	08 20 00 
   41984:	48 89 c6             	mov    %rax,%rsi
   41987:	bf 70 32 05 00       	mov    $0x53270,%edi
   4198c:	e8 73 fe ff ff       	call   41804 <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   41991:	ba 00 00 00 00       	mov    $0x0,%edx
   41996:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   4199d:	02 00 00 
   419a0:	48 89 c6             	mov    %rax,%rsi
   419a3:	bf 78 32 05 00       	mov    $0x53278,%edi
   419a8:	e8 57 fe ff ff       	call   41804 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   419ad:	ba 03 00 00 00       	mov    $0x3,%edx
   419b2:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   419b9:	02 00 00 
   419bc:	48 89 c6             	mov    %rax,%rsi
   419bf:	bf 80 32 05 00       	mov    $0x53280,%edi
   419c4:	e8 3b fe ff ff       	call   41804 <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   419c9:	b8 a0 42 05 00       	mov    $0x542a0,%eax
   419ce:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   419d4:	48 89 c1             	mov    %rax,%rcx
   419d7:	ba 00 00 00 00       	mov    $0x0,%edx
   419dc:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   419e3:	09 00 00 
   419e6:	48 89 c6             	mov    %rax,%rsi
   419e9:	bf 88 32 05 00       	mov    $0x53288,%edi
   419ee:	e8 48 fe ff ff       	call   4183b <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   419f3:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   419f9:	b8 60 32 05 00       	mov    $0x53260,%eax
   419fe:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   41a02:	ba 60 00 00 00       	mov    $0x60,%edx
   41a07:	be 00 00 00 00       	mov    $0x0,%esi
   41a0c:	bf a0 42 05 00       	mov    $0x542a0,%edi
   41a11:	e8 4e 19 00 00       	call   43364 <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   41a16:	48 c7 05 83 28 01 00 	movq   $0x80000,0x12883(%rip)        # 542a4 <kernel_task_descriptor+0x4>
   41a1d:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   41a21:	ba 00 10 00 00       	mov    $0x1000,%edx
   41a26:	be 00 00 00 00       	mov    $0x0,%esi
   41a2b:	bf a0 32 05 00       	mov    $0x532a0,%edi
   41a30:	e8 2f 19 00 00       	call   43364 <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41a35:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   41a3c:	eb 30                	jmp    41a6e <segments_init+0x128>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   41a3e:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   41a43:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41a46:	48 c1 e0 04          	shl    $0x4,%rax
   41a4a:	48 05 a0 32 05 00    	add    $0x532a0,%rax
   41a50:	48 89 d1             	mov    %rdx,%rcx
   41a53:	ba 00 00 00 00       	mov    $0x0,%edx
   41a58:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41a5f:	0e 00 00 
   41a62:	48 89 c7             	mov    %rax,%rdi
   41a65:	e8 68 fe ff ff       	call   418d2 <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41a6a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41a6e:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   41a75:	76 c7                	jbe    41a3e <segments_init+0xf8>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   41a77:	b8 36 00 04 00       	mov    $0x40036,%eax
   41a7c:	48 89 c1             	mov    %rax,%rcx
   41a7f:	ba 00 00 00 00       	mov    $0x0,%edx
   41a84:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41a8b:	0e 00 00 
   41a8e:	48 89 c6             	mov    %rax,%rsi
   41a91:	bf a0 34 05 00       	mov    $0x534a0,%edi
   41a96:	e8 37 fe ff ff       	call   418d2 <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   41a9b:	b8 2e 00 04 00       	mov    $0x4002e,%eax
   41aa0:	48 89 c1             	mov    %rax,%rcx
   41aa3:	ba 00 00 00 00       	mov    $0x0,%edx
   41aa8:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41aaf:	0e 00 00 
   41ab2:	48 89 c6             	mov    %rax,%rsi
   41ab5:	bf 70 33 05 00       	mov    $0x53370,%edi
   41aba:	e8 13 fe ff ff       	call   418d2 <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   41abf:	b8 32 00 04 00       	mov    $0x40032,%eax
   41ac4:	48 89 c1             	mov    %rax,%rcx
   41ac7:	ba 00 00 00 00       	mov    $0x0,%edx
   41acc:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41ad3:	0e 00 00 
   41ad6:	48 89 c6             	mov    %rax,%rsi
   41ad9:	bf 80 33 05 00       	mov    $0x53380,%edi
   41ade:	e8 ef fd ff ff       	call   418d2 <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41ae3:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   41aea:	eb 3e                	jmp    41b2a <segments_init+0x1e4>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   41aec:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41aef:	83 e8 30             	sub    $0x30,%eax
   41af2:	89 c0                	mov    %eax,%eax
   41af4:	48 8b 04 c5 e7 00 04 	mov    0x400e7(,%rax,8),%rax
   41afb:	00 
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   41afc:	48 89 c2             	mov    %rax,%rdx
   41aff:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41b02:	48 c1 e0 04          	shl    $0x4,%rax
   41b06:	48 05 a0 32 05 00    	add    $0x532a0,%rax
   41b0c:	48 89 d1             	mov    %rdx,%rcx
   41b0f:	ba 03 00 00 00       	mov    $0x3,%edx
   41b14:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41b1b:	0e 00 00 
   41b1e:	48 89 c7             	mov    %rax,%rdi
   41b21:	e8 ac fd ff ff       	call   418d2 <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41b26:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41b2a:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   41b2e:	76 bc                	jbe    41aec <segments_init+0x1a6>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   41b30:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   41b36:	b8 a0 32 05 00       	mov    $0x532a0,%eax
   41b3b:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   41b3f:	b8 28 00 00 00       	mov    $0x28,%eax
   41b44:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   41b48:	0f 00 d8             	ltr    %ax
   41b4b:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   41b4f:	0f 20 c0             	mov    %cr0,%rax
   41b52:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   41b56:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   41b5a:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   41b5d:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   41b64:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41b67:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   41b6a:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41b6d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   41b71:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41b75:	0f 22 c0             	mov    %rax,%cr0
}
   41b78:	90                   	nop
    lcr0(cr0);
}
   41b79:	90                   	nop
   41b7a:	c9                   	leave  
   41b7b:	c3                   	ret    

0000000000041b7c <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   41b7c:	55                   	push   %rbp
   41b7d:	48 89 e5             	mov    %rsp,%rbp
   41b80:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   41b84:	0f b7 05 75 27 01 00 	movzwl 0x12775(%rip),%eax        # 54300 <interrupts_enabled>
   41b8b:	f7 d0                	not    %eax
   41b8d:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   41b91:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41b95:	0f b6 c0             	movzbl %al,%eax
   41b98:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   41b9f:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ba2:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   41ba6:	8b 55 f0             	mov    -0x10(%rbp),%edx
   41ba9:	ee                   	out    %al,(%dx)
}
   41baa:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   41bab:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41baf:	66 c1 e8 08          	shr    $0x8,%ax
   41bb3:	0f b6 c0             	movzbl %al,%eax
   41bb6:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   41bbd:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41bc0:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   41bc4:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41bc7:	ee                   	out    %al,(%dx)
}
   41bc8:	90                   	nop
}
   41bc9:	90                   	nop
   41bca:	c9                   	leave  
   41bcb:	c3                   	ret    

0000000000041bcc <interrupt_init>:

void interrupt_init(void) {
   41bcc:	55                   	push   %rbp
   41bcd:	48 89 e5             	mov    %rsp,%rbp
   41bd0:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   41bd4:	66 c7 05 23 27 01 00 	movw   $0x0,0x12723(%rip)        # 54300 <interrupts_enabled>
   41bdb:	00 00 
    interrupt_mask();
   41bdd:	e8 9a ff ff ff       	call   41b7c <interrupt_mask>
   41be2:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   41be9:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41bed:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   41bf1:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   41bf4:	ee                   	out    %al,(%dx)
}
   41bf5:	90                   	nop
   41bf6:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   41bfd:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c01:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   41c05:	8b 55 ac             	mov    -0x54(%rbp),%edx
   41c08:	ee                   	out    %al,(%dx)
}
   41c09:	90                   	nop
   41c0a:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   41c11:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c15:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   41c19:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   41c1c:	ee                   	out    %al,(%dx)
}
   41c1d:	90                   	nop
   41c1e:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   41c25:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c29:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   41c2d:	8b 55 bc             	mov    -0x44(%rbp),%edx
   41c30:	ee                   	out    %al,(%dx)
}
   41c31:	90                   	nop
   41c32:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   41c39:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c3d:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   41c41:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   41c44:	ee                   	out    %al,(%dx)
}
   41c45:	90                   	nop
   41c46:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   41c4d:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c51:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   41c55:	8b 55 cc             	mov    -0x34(%rbp),%edx
   41c58:	ee                   	out    %al,(%dx)
}
   41c59:	90                   	nop
   41c5a:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   41c61:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c65:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   41c69:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   41c6c:	ee                   	out    %al,(%dx)
}
   41c6d:	90                   	nop
   41c6e:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   41c75:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c79:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   41c7d:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41c80:	ee                   	out    %al,(%dx)
}
   41c81:	90                   	nop
   41c82:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   41c89:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c8d:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41c91:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41c94:	ee                   	out    %al,(%dx)
}
   41c95:	90                   	nop
   41c96:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   41c9d:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ca1:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41ca5:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41ca8:	ee                   	out    %al,(%dx)
}
   41ca9:	90                   	nop
   41caa:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   41cb1:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41cb5:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41cb9:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41cbc:	ee                   	out    %al,(%dx)
}
   41cbd:	90                   	nop
   41cbe:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   41cc5:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41cc9:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41ccd:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41cd0:	ee                   	out    %al,(%dx)
}
   41cd1:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   41cd2:	e8 a5 fe ff ff       	call   41b7c <interrupt_mask>
}
   41cd7:	90                   	nop
   41cd8:	c9                   	leave  
   41cd9:	c3                   	ret    

0000000000041cda <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   41cda:	55                   	push   %rbp
   41cdb:	48 89 e5             	mov    %rsp,%rbp
   41cde:	48 83 ec 28          	sub    $0x28,%rsp
   41ce2:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   41ce5:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41ce9:	0f 8e 9e 00 00 00    	jle    41d8d <timer_init+0xb3>
   41cef:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   41cf6:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41cfa:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41cfe:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41d01:	ee                   	out    %al,(%dx)
}
   41d02:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   41d03:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41d06:	89 c2                	mov    %eax,%edx
   41d08:	c1 ea 1f             	shr    $0x1f,%edx
   41d0b:	01 d0                	add    %edx,%eax
   41d0d:	d1 f8                	sar    %eax
   41d0f:	05 de 34 12 00       	add    $0x1234de,%eax
   41d14:	99                   	cltd   
   41d15:	f7 7d dc             	idivl  -0x24(%rbp)
   41d18:	89 c2                	mov    %eax,%edx
   41d1a:	89 d0                	mov    %edx,%eax
   41d1c:	c1 f8 1f             	sar    $0x1f,%eax
   41d1f:	c1 e8 18             	shr    $0x18,%eax
   41d22:	01 c2                	add    %eax,%edx
   41d24:	0f b6 d2             	movzbl %dl,%edx
   41d27:	29 c2                	sub    %eax,%edx
   41d29:	89 d0                	mov    %edx,%eax
   41d2b:	0f b6 c0             	movzbl %al,%eax
   41d2e:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   41d35:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d38:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41d3c:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41d3f:	ee                   	out    %al,(%dx)
}
   41d40:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   41d41:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41d44:	89 c2                	mov    %eax,%edx
   41d46:	c1 ea 1f             	shr    $0x1f,%edx
   41d49:	01 d0                	add    %edx,%eax
   41d4b:	d1 f8                	sar    %eax
   41d4d:	05 de 34 12 00       	add    $0x1234de,%eax
   41d52:	99                   	cltd   
   41d53:	f7 7d dc             	idivl  -0x24(%rbp)
   41d56:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41d5c:	85 c0                	test   %eax,%eax
   41d5e:	0f 48 c2             	cmovs  %edx,%eax
   41d61:	c1 f8 08             	sar    $0x8,%eax
   41d64:	0f b6 c0             	movzbl %al,%eax
   41d67:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   41d6e:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d71:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41d75:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41d78:	ee                   	out    %al,(%dx)
}
   41d79:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   41d7a:	0f b7 05 7f 25 01 00 	movzwl 0x1257f(%rip),%eax        # 54300 <interrupts_enabled>
   41d81:	83 c8 01             	or     $0x1,%eax
   41d84:	66 89 05 75 25 01 00 	mov    %ax,0x12575(%rip)        # 54300 <interrupts_enabled>
   41d8b:	eb 11                	jmp    41d9e <timer_init+0xc4>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   41d8d:	0f b7 05 6c 25 01 00 	movzwl 0x1256c(%rip),%eax        # 54300 <interrupts_enabled>
   41d94:	83 e0 fe             	and    $0xfffffffe,%eax
   41d97:	66 89 05 62 25 01 00 	mov    %ax,0x12562(%rip)        # 54300 <interrupts_enabled>
    }
    interrupt_mask();
   41d9e:	e8 d9 fd ff ff       	call   41b7c <interrupt_mask>
}
   41da3:	90                   	nop
   41da4:	c9                   	leave  
   41da5:	c3                   	ret    

0000000000041da6 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   41da6:	55                   	push   %rbp
   41da7:	48 89 e5             	mov    %rsp,%rbp
   41daa:	48 83 ec 08          	sub    $0x8,%rsp
   41dae:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   41db2:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   41db7:	74 14                	je     41dcd <physical_memory_isreserved+0x27>
   41db9:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   41dc0:	00 
   41dc1:	76 11                	jbe    41dd4 <physical_memory_isreserved+0x2e>
   41dc3:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   41dca:	00 
   41dcb:	77 07                	ja     41dd4 <physical_memory_isreserved+0x2e>
   41dcd:	b8 01 00 00 00       	mov    $0x1,%eax
   41dd2:	eb 05                	jmp    41dd9 <physical_memory_isreserved+0x33>
   41dd4:	b8 00 00 00 00       	mov    $0x0,%eax
}
   41dd9:	c9                   	leave  
   41dda:	c3                   	ret    

0000000000041ddb <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   41ddb:	55                   	push   %rbp
   41ddc:	48 89 e5             	mov    %rsp,%rbp
   41ddf:	48 83 ec 10          	sub    $0x10,%rsp
   41de3:	89 7d fc             	mov    %edi,-0x4(%rbp)
   41de6:	89 75 f8             	mov    %esi,-0x8(%rbp)
   41de9:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   41dec:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41def:	c1 e0 10             	shl    $0x10,%eax
   41df2:	89 c2                	mov    %eax,%edx
   41df4:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41df7:	c1 e0 0b             	shl    $0xb,%eax
   41dfa:	09 c2                	or     %eax,%edx
   41dfc:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41dff:	c1 e0 08             	shl    $0x8,%eax
   41e02:	09 d0                	or     %edx,%eax
}
   41e04:	c9                   	leave  
   41e05:	c3                   	ret    

0000000000041e06 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   41e06:	55                   	push   %rbp
   41e07:	48 89 e5             	mov    %rsp,%rbp
   41e0a:	48 83 ec 18          	sub    $0x18,%rsp
   41e0e:	89 7d ec             	mov    %edi,-0x14(%rbp)
   41e11:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   41e14:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41e17:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41e1a:	09 d0                	or     %edx,%eax
   41e1c:	0d 00 00 00 80       	or     $0x80000000,%eax
   41e21:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   41e28:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   41e2b:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41e2e:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41e31:	ef                   	out    %eax,(%dx)
}
   41e32:	90                   	nop
   41e33:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   41e3a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41e3d:	89 c2                	mov    %eax,%edx
   41e3f:	ed                   	in     (%dx),%eax
   41e40:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   41e43:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   41e46:	c9                   	leave  
   41e47:	c3                   	ret    

0000000000041e48 <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   41e48:	55                   	push   %rbp
   41e49:	48 89 e5             	mov    %rsp,%rbp
   41e4c:	48 83 ec 28          	sub    $0x28,%rsp
   41e50:	89 7d dc             	mov    %edi,-0x24(%rbp)
   41e53:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   41e56:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41e5d:	eb 73                	jmp    41ed2 <pci_find_device+0x8a>
        for (int slot = 0; slot != 32; ++slot) {
   41e5f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41e66:	eb 60                	jmp    41ec8 <pci_find_device+0x80>
            for (int func = 0; func != 8; ++func) {
   41e68:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41e6f:	eb 4a                	jmp    41ebb <pci_find_device+0x73>
                int configaddr = pci_make_configaddr(bus, slot, func);
   41e71:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41e74:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41e77:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41e7a:	89 ce                	mov    %ecx,%esi
   41e7c:	89 c7                	mov    %eax,%edi
   41e7e:	e8 58 ff ff ff       	call   41ddb <pci_make_configaddr>
   41e83:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   41e86:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41e89:	be 00 00 00 00       	mov    $0x0,%esi
   41e8e:	89 c7                	mov    %eax,%edi
   41e90:	e8 71 ff ff ff       	call   41e06 <pci_config_readl>
   41e95:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   41e98:	8b 45 d8             	mov    -0x28(%rbp),%eax
   41e9b:	c1 e0 10             	shl    $0x10,%eax
   41e9e:	0b 45 dc             	or     -0x24(%rbp),%eax
   41ea1:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   41ea4:	75 05                	jne    41eab <pci_find_device+0x63>
                    return configaddr;
   41ea6:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41ea9:	eb 35                	jmp    41ee0 <pci_find_device+0x98>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   41eab:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   41eaf:	75 06                	jne    41eb7 <pci_find_device+0x6f>
   41eb1:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41eb5:	74 0c                	je     41ec3 <pci_find_device+0x7b>
            for (int func = 0; func != 8; ++func) {
   41eb7:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41ebb:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   41ebf:	75 b0                	jne    41e71 <pci_find_device+0x29>
   41ec1:	eb 01                	jmp    41ec4 <pci_find_device+0x7c>
                    break;
   41ec3:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   41ec4:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41ec8:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   41ecc:	75 9a                	jne    41e68 <pci_find_device+0x20>
    for (int bus = 0; bus != 256; ++bus) {
   41ece:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41ed2:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   41ed9:	75 84                	jne    41e5f <pci_find_device+0x17>
                }
            }
        }
    }
    return -1;
   41edb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   41ee0:	c9                   	leave  
   41ee1:	c3                   	ret    

0000000000041ee2 <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   41ee2:	55                   	push   %rbp
   41ee3:	48 89 e5             	mov    %rsp,%rbp
   41ee6:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   41eea:	be 13 71 00 00       	mov    $0x7113,%esi
   41eef:	bf 86 80 00 00       	mov    $0x8086,%edi
   41ef4:	e8 4f ff ff ff       	call   41e48 <pci_find_device>
   41ef9:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   41efc:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   41f00:	78 30                	js     41f32 <poweroff+0x50>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   41f02:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41f05:	be 40 00 00 00       	mov    $0x40,%esi
   41f0a:	89 c7                	mov    %eax,%edi
   41f0c:	e8 f5 fe ff ff       	call   41e06 <pci_config_readl>
   41f11:	25 c0 ff 00 00       	and    $0xffc0,%eax
   41f16:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   41f19:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41f1c:	83 c0 04             	add    $0x4,%eax
   41f1f:	89 45 f4             	mov    %eax,-0xc(%rbp)
   41f22:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   41f28:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   41f2c:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41f2f:	66 ef                	out    %ax,(%dx)
}
   41f31:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   41f32:	ba 00 47 04 00       	mov    $0x44700,%edx
   41f37:	be 00 c0 00 00       	mov    $0xc000,%esi
   41f3c:	bf 80 07 00 00       	mov    $0x780,%edi
   41f41:	b8 00 00 00 00       	mov    $0x0,%eax
   41f46:	e8 d0 21 00 00       	call   4411b <console_printf>
 spinloop: goto spinloop;
   41f4b:	eb fe                	jmp    41f4b <poweroff+0x69>

0000000000041f4d <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   41f4d:	55                   	push   %rbp
   41f4e:	48 89 e5             	mov    %rsp,%rbp
   41f51:	48 83 ec 10          	sub    $0x10,%rsp
   41f55:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   41f5c:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f60:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41f64:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41f67:	ee                   	out    %al,(%dx)
}
   41f68:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   41f69:	eb fe                	jmp    41f69 <reboot+0x1c>

0000000000041f6b <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   41f6b:	55                   	push   %rbp
   41f6c:	48 89 e5             	mov    %rsp,%rbp
   41f6f:	48 83 ec 10          	sub    $0x10,%rsp
   41f73:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41f77:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   41f7a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41f7e:	48 83 c0 08          	add    $0x8,%rax
   41f82:	ba c0 00 00 00       	mov    $0xc0,%edx
   41f87:	be 00 00 00 00       	mov    $0x0,%esi
   41f8c:	48 89 c7             	mov    %rax,%rdi
   41f8f:	e8 d0 13 00 00       	call   43364 <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   41f94:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41f98:	66 c7 80 a8 00 00 00 	movw   $0x13,0xa8(%rax)
   41f9f:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   41fa1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41fa5:	48 c7 80 80 00 00 00 	movq   $0x23,0x80(%rax)
   41fac:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   41fb0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41fb4:	48 c7 80 88 00 00 00 	movq   $0x23,0x88(%rax)
   41fbb:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   41fbf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41fc3:	66 c7 80 c0 00 00 00 	movw   $0x23,0xc0(%rax)
   41fca:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   41fcc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41fd0:	48 c7 80 b0 00 00 00 	movq   $0x200,0xb0(%rax)
   41fd7:	00 02 00 00 
    p->display_status = 1;
   41fdb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41fdf:	c6 80 d8 00 00 00 01 	movb   $0x1,0xd8(%rax)

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   41fe6:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41fe9:	83 e0 01             	and    $0x1,%eax
   41fec:	85 c0                	test   %eax,%eax
   41fee:	74 1c                	je     4200c <process_init+0xa1>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   41ff0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ff4:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   41ffb:	80 cc 30             	or     $0x30,%ah
   41ffe:	48 89 c2             	mov    %rax,%rdx
   42001:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42005:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   4200c:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4200f:	83 e0 02             	and    $0x2,%eax
   42012:	85 c0                	test   %eax,%eax
   42014:	74 1c                	je     42032 <process_init+0xc7>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   42016:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4201a:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   42021:	80 e4 fd             	and    $0xfd,%ah
   42024:	48 89 c2             	mov    %rax,%rdx
   42027:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4202b:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
}
   42032:	90                   	nop
   42033:	c9                   	leave  
   42034:	c3                   	ret    

0000000000042035 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   42035:	55                   	push   %rbp
   42036:	48 89 e5             	mov    %rsp,%rbp
   42039:	48 83 ec 28          	sub    $0x28,%rsp
   4203d:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   42040:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   42044:	78 09                	js     4204f <console_show_cursor+0x1a>
   42046:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   4204d:	7e 07                	jle    42056 <console_show_cursor+0x21>
        cpos = 0;
   4204f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   42056:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   4205d:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42061:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   42065:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   42068:	ee                   	out    %al,(%dx)
}
   42069:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   4206a:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4206d:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   42073:	85 c0                	test   %eax,%eax
   42075:	0f 48 c2             	cmovs  %edx,%eax
   42078:	c1 f8 08             	sar    $0x8,%eax
   4207b:	0f b6 c0             	movzbl %al,%eax
   4207e:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   42085:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42088:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   4208c:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4208f:	ee                   	out    %al,(%dx)
}
   42090:	90                   	nop
   42091:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   42098:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4209c:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   420a0:	8b 55 f4             	mov    -0xc(%rbp),%edx
   420a3:	ee                   	out    %al,(%dx)
}
   420a4:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   420a5:	8b 55 dc             	mov    -0x24(%rbp),%edx
   420a8:	89 d0                	mov    %edx,%eax
   420aa:	c1 f8 1f             	sar    $0x1f,%eax
   420ad:	c1 e8 18             	shr    $0x18,%eax
   420b0:	01 c2                	add    %eax,%edx
   420b2:	0f b6 d2             	movzbl %dl,%edx
   420b5:	29 c2                	sub    %eax,%edx
   420b7:	89 d0                	mov    %edx,%eax
   420b9:	0f b6 c0             	movzbl %al,%eax
   420bc:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   420c3:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   420c6:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   420ca:	8b 55 fc             	mov    -0x4(%rbp),%edx
   420cd:	ee                   	out    %al,(%dx)
}
   420ce:	90                   	nop
}
   420cf:	90                   	nop
   420d0:	c9                   	leave  
   420d1:	c3                   	ret    

00000000000420d2 <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   420d2:	55                   	push   %rbp
   420d3:	48 89 e5             	mov    %rsp,%rbp
   420d6:	48 83 ec 20          	sub    $0x20,%rsp
   420da:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   420e1:	8b 45 f0             	mov    -0x10(%rbp),%eax
   420e4:	89 c2                	mov    %eax,%edx
   420e6:	ec                   	in     (%dx),%al
   420e7:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   420ea:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   420ee:	0f b6 c0             	movzbl %al,%eax
   420f1:	83 e0 01             	and    $0x1,%eax
   420f4:	85 c0                	test   %eax,%eax
   420f6:	75 0a                	jne    42102 <keyboard_readc+0x30>
        return -1;
   420f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   420fd:	e9 e7 01 00 00       	jmp    422e9 <keyboard_readc+0x217>
   42102:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42109:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4210c:	89 c2                	mov    %eax,%edx
   4210e:	ec                   	in     (%dx),%al
   4210f:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   42112:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   42116:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   42119:	0f b6 05 e2 21 01 00 	movzbl 0x121e2(%rip),%eax        # 54302 <last_escape.2>
   42120:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   42123:	c6 05 d8 21 01 00 00 	movb   $0x0,0x121d8(%rip)        # 54302 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   4212a:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   4212e:	75 11                	jne    42141 <keyboard_readc+0x6f>
        last_escape = 0x80;
   42130:	c6 05 cb 21 01 00 80 	movb   $0x80,0x121cb(%rip)        # 54302 <last_escape.2>
        return 0;
   42137:	b8 00 00 00 00       	mov    $0x0,%eax
   4213c:	e9 a8 01 00 00       	jmp    422e9 <keyboard_readc+0x217>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   42141:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42145:	84 c0                	test   %al,%al
   42147:	79 60                	jns    421a9 <keyboard_readc+0xd7>
        int ch = keymap[(data & 0x7F) | escape];
   42149:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4214d:	83 e0 7f             	and    $0x7f,%eax
   42150:	89 c2                	mov    %eax,%edx
   42152:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   42156:	09 d0                	or     %edx,%eax
   42158:	48 98                	cltq   
   4215a:	0f b6 80 20 47 04 00 	movzbl 0x44720(%rax),%eax
   42161:	0f b6 c0             	movzbl %al,%eax
   42164:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   42167:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   4216e:	7e 2f                	jle    4219f <keyboard_readc+0xcd>
   42170:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   42177:	7f 26                	jg     4219f <keyboard_readc+0xcd>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   42179:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4217c:	2d fa 00 00 00       	sub    $0xfa,%eax
   42181:	ba 01 00 00 00       	mov    $0x1,%edx
   42186:	89 c1                	mov    %eax,%ecx
   42188:	d3 e2                	shl    %cl,%edx
   4218a:	89 d0                	mov    %edx,%eax
   4218c:	f7 d0                	not    %eax
   4218e:	89 c2                	mov    %eax,%edx
   42190:	0f b6 05 6c 21 01 00 	movzbl 0x1216c(%rip),%eax        # 54303 <modifiers.1>
   42197:	21 d0                	and    %edx,%eax
   42199:	88 05 64 21 01 00    	mov    %al,0x12164(%rip)        # 54303 <modifiers.1>
        }
        return 0;
   4219f:	b8 00 00 00 00       	mov    $0x0,%eax
   421a4:	e9 40 01 00 00       	jmp    422e9 <keyboard_readc+0x217>
    }

    int ch = (unsigned char) keymap[data | escape];
   421a9:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   421ad:	0a 45 fa             	or     -0x6(%rbp),%al
   421b0:	0f b6 c0             	movzbl %al,%eax
   421b3:	48 98                	cltq   
   421b5:	0f b6 80 20 47 04 00 	movzbl 0x44720(%rax),%eax
   421bc:	0f b6 c0             	movzbl %al,%eax
   421bf:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   421c2:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   421c6:	7e 57                	jle    4221f <keyboard_readc+0x14d>
   421c8:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   421cc:	7f 51                	jg     4221f <keyboard_readc+0x14d>
        if (modifiers & MOD_CONTROL) {
   421ce:	0f b6 05 2e 21 01 00 	movzbl 0x1212e(%rip),%eax        # 54303 <modifiers.1>
   421d5:	0f b6 c0             	movzbl %al,%eax
   421d8:	83 e0 02             	and    $0x2,%eax
   421db:	85 c0                	test   %eax,%eax
   421dd:	74 09                	je     421e8 <keyboard_readc+0x116>
            ch -= 0x60;
   421df:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   421e3:	e9 fd 00 00 00       	jmp    422e5 <keyboard_readc+0x213>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   421e8:	0f b6 05 14 21 01 00 	movzbl 0x12114(%rip),%eax        # 54303 <modifiers.1>
   421ef:	0f b6 c0             	movzbl %al,%eax
   421f2:	83 e0 01             	and    $0x1,%eax
   421f5:	85 c0                	test   %eax,%eax
   421f7:	0f 94 c2             	sete   %dl
   421fa:	0f b6 05 02 21 01 00 	movzbl 0x12102(%rip),%eax        # 54303 <modifiers.1>
   42201:	0f b6 c0             	movzbl %al,%eax
   42204:	83 e0 08             	and    $0x8,%eax
   42207:	85 c0                	test   %eax,%eax
   42209:	0f 94 c0             	sete   %al
   4220c:	31 d0                	xor    %edx,%eax
   4220e:	84 c0                	test   %al,%al
   42210:	0f 84 cf 00 00 00    	je     422e5 <keyboard_readc+0x213>
            ch -= 0x20;
   42216:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   4221a:	e9 c6 00 00 00       	jmp    422e5 <keyboard_readc+0x213>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   4221f:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   42226:	7e 30                	jle    42258 <keyboard_readc+0x186>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   42228:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4222b:	2d fa 00 00 00       	sub    $0xfa,%eax
   42230:	ba 01 00 00 00       	mov    $0x1,%edx
   42235:	89 c1                	mov    %eax,%ecx
   42237:	d3 e2                	shl    %cl,%edx
   42239:	89 d0                	mov    %edx,%eax
   4223b:	89 c2                	mov    %eax,%edx
   4223d:	0f b6 05 bf 20 01 00 	movzbl 0x120bf(%rip),%eax        # 54303 <modifiers.1>
   42244:	31 d0                	xor    %edx,%eax
   42246:	88 05 b7 20 01 00    	mov    %al,0x120b7(%rip)        # 54303 <modifiers.1>
        ch = 0;
   4224c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42253:	e9 8e 00 00 00       	jmp    422e6 <keyboard_readc+0x214>
    } else if (ch >= KEY_SHIFT) {
   42258:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   4225f:	7e 2d                	jle    4228e <keyboard_readc+0x1bc>
        modifiers |= 1 << (ch - KEY_SHIFT);
   42261:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42264:	2d fa 00 00 00       	sub    $0xfa,%eax
   42269:	ba 01 00 00 00       	mov    $0x1,%edx
   4226e:	89 c1                	mov    %eax,%ecx
   42270:	d3 e2                	shl    %cl,%edx
   42272:	89 d0                	mov    %edx,%eax
   42274:	89 c2                	mov    %eax,%edx
   42276:	0f b6 05 86 20 01 00 	movzbl 0x12086(%rip),%eax        # 54303 <modifiers.1>
   4227d:	09 d0                	or     %edx,%eax
   4227f:	88 05 7e 20 01 00    	mov    %al,0x1207e(%rip)        # 54303 <modifiers.1>
        ch = 0;
   42285:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4228c:	eb 58                	jmp    422e6 <keyboard_readc+0x214>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   4228e:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   42292:	7e 31                	jle    422c5 <keyboard_readc+0x1f3>
   42294:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   4229b:	7f 28                	jg     422c5 <keyboard_readc+0x1f3>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   4229d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   422a0:	8d 50 80             	lea    -0x80(%rax),%edx
   422a3:	0f b6 05 59 20 01 00 	movzbl 0x12059(%rip),%eax        # 54303 <modifiers.1>
   422aa:	0f b6 c0             	movzbl %al,%eax
   422ad:	83 e0 03             	and    $0x3,%eax
   422b0:	48 98                	cltq   
   422b2:	48 63 d2             	movslq %edx,%rdx
   422b5:	0f b6 84 90 20 48 04 	movzbl 0x44820(%rax,%rdx,4),%eax
   422bc:	00 
   422bd:	0f b6 c0             	movzbl %al,%eax
   422c0:	89 45 fc             	mov    %eax,-0x4(%rbp)
   422c3:	eb 21                	jmp    422e6 <keyboard_readc+0x214>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   422c5:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   422c9:	7f 1b                	jg     422e6 <keyboard_readc+0x214>
   422cb:	0f b6 05 31 20 01 00 	movzbl 0x12031(%rip),%eax        # 54303 <modifiers.1>
   422d2:	0f b6 c0             	movzbl %al,%eax
   422d5:	83 e0 02             	and    $0x2,%eax
   422d8:	85 c0                	test   %eax,%eax
   422da:	74 0a                	je     422e6 <keyboard_readc+0x214>
        ch = 0;
   422dc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   422e3:	eb 01                	jmp    422e6 <keyboard_readc+0x214>
        if (modifiers & MOD_CONTROL) {
   422e5:	90                   	nop
    }

    return ch;
   422e6:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   422e9:	c9                   	leave  
   422ea:	c3                   	ret    

00000000000422eb <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   422eb:	55                   	push   %rbp
   422ec:	48 89 e5             	mov    %rsp,%rbp
   422ef:	48 83 ec 20          	sub    $0x20,%rsp
   422f3:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   422fa:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   422fd:	89 c2                	mov    %eax,%edx
   422ff:	ec                   	in     (%dx),%al
   42300:	88 45 e3             	mov    %al,-0x1d(%rbp)
   42303:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   4230a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4230d:	89 c2                	mov    %eax,%edx
   4230f:	ec                   	in     (%dx),%al
   42310:	88 45 eb             	mov    %al,-0x15(%rbp)
   42313:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   4231a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4231d:	89 c2                	mov    %eax,%edx
   4231f:	ec                   	in     (%dx),%al
   42320:	88 45 f3             	mov    %al,-0xd(%rbp)
   42323:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   4232a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4232d:	89 c2                	mov    %eax,%edx
   4232f:	ec                   	in     (%dx),%al
   42330:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   42333:	90                   	nop
   42334:	c9                   	leave  
   42335:	c3                   	ret    

0000000000042336 <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   42336:	55                   	push   %rbp
   42337:	48 89 e5             	mov    %rsp,%rbp
   4233a:	48 83 ec 40          	sub    $0x40,%rsp
   4233e:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42342:	89 f0                	mov    %esi,%eax
   42344:	89 55 c0             	mov    %edx,-0x40(%rbp)
   42347:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   4234a:	8b 05 b4 1f 01 00    	mov    0x11fb4(%rip),%eax        # 54304 <initialized.0>
   42350:	85 c0                	test   %eax,%eax
   42352:	75 1e                	jne    42372 <parallel_port_putc+0x3c>
   42354:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   4235b:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4235f:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   42363:	8b 55 f8             	mov    -0x8(%rbp),%edx
   42366:	ee                   	out    %al,(%dx)
}
   42367:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   42368:	c7 05 92 1f 01 00 01 	movl   $0x1,0x11f92(%rip)        # 54304 <initialized.0>
   4236f:	00 00 00 
    }

    for (int i = 0;
   42372:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42379:	eb 09                	jmp    42384 <parallel_port_putc+0x4e>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   4237b:	e8 6b ff ff ff       	call   422eb <delay>
         ++i) {
   42380:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   42384:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   4238b:	7f 18                	jg     423a5 <parallel_port_putc+0x6f>
   4238d:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42394:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42397:	89 c2                	mov    %eax,%edx
   42399:	ec                   	in     (%dx),%al
   4239a:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   4239d:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   423a1:	84 c0                	test   %al,%al
   423a3:	79 d6                	jns    4237b <parallel_port_putc+0x45>
    }
    outb(IO_PARALLEL1_DATA, c);
   423a5:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   423a9:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   423b0:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   423b3:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   423b7:	8b 55 d8             	mov    -0x28(%rbp),%edx
   423ba:	ee                   	out    %al,(%dx)
}
   423bb:	90                   	nop
   423bc:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   423c3:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   423c7:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   423cb:	8b 55 e0             	mov    -0x20(%rbp),%edx
   423ce:	ee                   	out    %al,(%dx)
}
   423cf:	90                   	nop
   423d0:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   423d7:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   423db:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   423df:	8b 55 e8             	mov    -0x18(%rbp),%edx
   423e2:	ee                   	out    %al,(%dx)
}
   423e3:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   423e4:	90                   	nop
   423e5:	c9                   	leave  
   423e6:	c3                   	ret    

00000000000423e7 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   423e7:	55                   	push   %rbp
   423e8:	48 89 e5             	mov    %rsp,%rbp
   423eb:	48 83 ec 20          	sub    $0x20,%rsp
   423ef:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   423f3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   423f7:	48 c7 45 f8 36 23 04 	movq   $0x42336,-0x8(%rbp)
   423fe:	00 
    printer_vprintf(&p, 0, format, val);
   423ff:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   42403:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   42407:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   4240b:	be 00 00 00 00       	mov    $0x0,%esi
   42410:	48 89 c7             	mov    %rax,%rdi
   42413:	e8 e8 11 00 00       	call   43600 <printer_vprintf>
}
   42418:	90                   	nop
   42419:	c9                   	leave  
   4241a:	c3                   	ret    

000000000004241b <log_printf>:

void log_printf(const char* format, ...) {
   4241b:	55                   	push   %rbp
   4241c:	48 89 e5             	mov    %rsp,%rbp
   4241f:	48 83 ec 60          	sub    $0x60,%rsp
   42423:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42427:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   4242b:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   4242f:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42433:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42437:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   4243b:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   42442:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42446:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   4244a:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4244e:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   42452:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   42456:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4245a:	48 89 d6             	mov    %rdx,%rsi
   4245d:	48 89 c7             	mov    %rax,%rdi
   42460:	e8 82 ff ff ff       	call   423e7 <log_vprintf>
    va_end(val);
}
   42465:	90                   	nop
   42466:	c9                   	leave  
   42467:	c3                   	ret    

0000000000042468 <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   42468:	55                   	push   %rbp
   42469:	48 89 e5             	mov    %rsp,%rbp
   4246c:	48 83 ec 40          	sub    $0x40,%rsp
   42470:	89 7d dc             	mov    %edi,-0x24(%rbp)
   42473:	89 75 d8             	mov    %esi,-0x28(%rbp)
   42476:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   4247a:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   4247e:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   42482:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42486:	48 8b 0a             	mov    (%rdx),%rcx
   42489:	48 89 08             	mov    %rcx,(%rax)
   4248c:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   42490:	48 89 48 08          	mov    %rcx,0x8(%rax)
   42494:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   42498:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   4249c:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   424a0:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   424a4:	48 89 d6             	mov    %rdx,%rsi
   424a7:	48 89 c7             	mov    %rax,%rdi
   424aa:	e8 38 ff ff ff       	call   423e7 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   424af:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   424b3:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   424b7:	8b 75 d8             	mov    -0x28(%rbp),%esi
   424ba:	8b 45 dc             	mov    -0x24(%rbp),%eax
   424bd:	89 c7                	mov    %eax,%edi
   424bf:	e8 eb 1b 00 00       	call   440af <console_vprintf>
}
   424c4:	c9                   	leave  
   424c5:	c3                   	ret    

00000000000424c6 <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   424c6:	55                   	push   %rbp
   424c7:	48 89 e5             	mov    %rsp,%rbp
   424ca:	48 83 ec 60          	sub    $0x60,%rsp
   424ce:	89 7d ac             	mov    %edi,-0x54(%rbp)
   424d1:	89 75 a8             	mov    %esi,-0x58(%rbp)
   424d4:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   424d8:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   424dc:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   424e0:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   424e4:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   424eb:	48 8d 45 10          	lea    0x10(%rbp),%rax
   424ef:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   424f3:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   424f7:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   424fb:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   424ff:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   42503:	8b 75 a8             	mov    -0x58(%rbp),%esi
   42506:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42509:	89 c7                	mov    %eax,%edi
   4250b:	e8 58 ff ff ff       	call   42468 <error_vprintf>
   42510:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   42513:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   42516:	c9                   	leave  
   42517:	c3                   	ret    

0000000000042518 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'f', and 'e' cause a soft
//    reboot where the kernel runs the allocator programs, "fork", or
//    "forkexit", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   42518:	55                   	push   %rbp
   42519:	48 89 e5             	mov    %rsp,%rbp
   4251c:	53                   	push   %rbx
   4251d:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   42521:	e8 ac fb ff ff       	call   420d2 <keyboard_readc>
   42526:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   42529:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   4252d:	74 1c                	je     4254b <check_keyboard+0x33>
   4252f:	83 7d e4 66          	cmpl   $0x66,-0x1c(%rbp)
   42533:	74 16                	je     4254b <check_keyboard+0x33>
   42535:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42539:	74 10                	je     4254b <check_keyboard+0x33>
   4253b:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   4253f:	74 0a                	je     4254b <check_keyboard+0x33>
   42541:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42545:	0f 85 e9 00 00 00    	jne    42634 <check_keyboard+0x11c>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   4254b:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   42552:	00 
        memset(pt, 0, PAGESIZE * 3);
   42553:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42557:	ba 00 30 00 00       	mov    $0x3000,%edx
   4255c:	be 00 00 00 00       	mov    $0x0,%esi
   42561:	48 89 c7             	mov    %rax,%rdi
   42564:	e8 fb 0d 00 00       	call   43364 <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   42569:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4256d:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   42574:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42578:	48 05 00 10 00 00    	add    $0x1000,%rax
   4257e:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   42585:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42589:	48 05 00 20 00 00    	add    $0x2000,%rax
   4258f:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   42596:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4259a:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   4259e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   425a2:	0f 22 d8             	mov    %rax,%cr3
}
   425a5:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   425a6:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "fork";
   425ad:	48 c7 45 e8 78 48 04 	movq   $0x44878,-0x18(%rbp)
   425b4:	00 
        if (c == 'a') {
   425b5:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   425b9:	75 0a                	jne    425c5 <check_keyboard+0xad>
            argument = "allocator";
   425bb:	48 c7 45 e8 7d 48 04 	movq   $0x4487d,-0x18(%rbp)
   425c2:	00 
   425c3:	eb 2e                	jmp    425f3 <check_keyboard+0xdb>
        } else if (c == 'e') {
   425c5:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   425c9:	75 0a                	jne    425d5 <check_keyboard+0xbd>
            argument = "forkexit";
   425cb:	48 c7 45 e8 87 48 04 	movq   $0x44887,-0x18(%rbp)
   425d2:	00 
   425d3:	eb 1e                	jmp    425f3 <check_keyboard+0xdb>
        }
        else if (c == 't'){
   425d5:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   425d9:	75 0a                	jne    425e5 <check_keyboard+0xcd>
            argument = "test";
   425db:	48 c7 45 e8 90 48 04 	movq   $0x44890,-0x18(%rbp)
   425e2:	00 
   425e3:	eb 0e                	jmp    425f3 <check_keyboard+0xdb>
        }
        else if(c == '2'){
   425e5:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   425e9:	75 08                	jne    425f3 <check_keyboard+0xdb>
            argument = "test2";
   425eb:	48 c7 45 e8 95 48 04 	movq   $0x44895,-0x18(%rbp)
   425f2:	00 
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   425f3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   425f7:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   425fb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42600:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   42604:	73 14                	jae    4261a <check_keyboard+0x102>
   42606:	ba 9b 48 04 00       	mov    $0x4489b,%edx
   4260b:	be 5d 02 00 00       	mov    $0x25d,%esi
   42610:	bf b7 48 04 00       	mov    $0x448b7,%edi
   42615:	e8 1f 01 00 00       	call   42739 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   4261a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4261e:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   42621:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   42625:	48 89 c3             	mov    %rax,%rbx
   42628:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   4262d:	e9 ce d9 ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   42632:	eb 11                	jmp    42645 <check_keyboard+0x12d>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   42634:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   42638:	74 06                	je     42640 <check_keyboard+0x128>
   4263a:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   4263e:	75 05                	jne    42645 <check_keyboard+0x12d>
        poweroff();
   42640:	e8 9d f8 ff ff       	call   41ee2 <poweroff>
    }
    return c;
   42645:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   42648:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   4264c:	c9                   	leave  
   4264d:	c3                   	ret    

000000000004264e <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   4264e:	55                   	push   %rbp
   4264f:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   42652:	e8 c1 fe ff ff       	call   42518 <check_keyboard>
   42657:	eb f9                	jmp    42652 <fail+0x4>

0000000000042659 <panic>:

// panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void panic(const char* format, ...) {
   42659:	55                   	push   %rbp
   4265a:	48 89 e5             	mov    %rsp,%rbp
   4265d:	48 83 ec 60          	sub    $0x60,%rsp
   42661:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42665:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42669:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   4266d:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42671:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42675:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42679:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   42680:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42684:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   42688:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4268c:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   42690:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   42695:	0f 84 80 00 00 00    	je     4271b <panic+0xc2>
        // Print panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   4269b:	ba cb 48 04 00       	mov    $0x448cb,%edx
   426a0:	be 00 c0 00 00       	mov    $0xc000,%esi
   426a5:	bf 30 07 00 00       	mov    $0x730,%edi
   426aa:	b8 00 00 00 00       	mov    $0x0,%eax
   426af:	e8 12 fe ff ff       	call   424c6 <error_printf>
   426b4:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   426b7:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   426bb:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   426bf:	8b 45 cc             	mov    -0x34(%rbp),%eax
   426c2:	be 00 c0 00 00       	mov    $0xc000,%esi
   426c7:	89 c7                	mov    %eax,%edi
   426c9:	e8 9a fd ff ff       	call   42468 <error_vprintf>
   426ce:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   426d1:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   426d4:	48 63 c1             	movslq %ecx,%rax
   426d7:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   426de:	48 c1 e8 20          	shr    $0x20,%rax
   426e2:	89 c2                	mov    %eax,%edx
   426e4:	c1 fa 05             	sar    $0x5,%edx
   426e7:	89 c8                	mov    %ecx,%eax
   426e9:	c1 f8 1f             	sar    $0x1f,%eax
   426ec:	29 c2                	sub    %eax,%edx
   426ee:	89 d0                	mov    %edx,%eax
   426f0:	c1 e0 02             	shl    $0x2,%eax
   426f3:	01 d0                	add    %edx,%eax
   426f5:	c1 e0 04             	shl    $0x4,%eax
   426f8:	29 c1                	sub    %eax,%ecx
   426fa:	89 ca                	mov    %ecx,%edx
   426fc:	85 d2                	test   %edx,%edx
   426fe:	74 34                	je     42734 <panic+0xdb>
            error_printf(cpos, 0xC000, "\n");
   42700:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42703:	ba d3 48 04 00       	mov    $0x448d3,%edx
   42708:	be 00 c0 00 00       	mov    $0xc000,%esi
   4270d:	89 c7                	mov    %eax,%edi
   4270f:	b8 00 00 00 00       	mov    $0x0,%eax
   42714:	e8 ad fd ff ff       	call   424c6 <error_printf>
   42719:	eb 19                	jmp    42734 <panic+0xdb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   4271b:	ba d5 48 04 00       	mov    $0x448d5,%edx
   42720:	be 00 c0 00 00       	mov    $0xc000,%esi
   42725:	bf 30 07 00 00       	mov    $0x730,%edi
   4272a:	b8 00 00 00 00       	mov    $0x0,%eax
   4272f:	e8 92 fd ff ff       	call   424c6 <error_printf>
    }

    va_end(val);
    fail();
   42734:	e8 15 ff ff ff       	call   4264e <fail>

0000000000042739 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   42739:	55                   	push   %rbp
   4273a:	48 89 e5             	mov    %rsp,%rbp
   4273d:	48 83 ec 20          	sub    $0x20,%rsp
   42741:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42745:	89 75 f4             	mov    %esi,-0xc(%rbp)
   42748:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   4274c:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   42750:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42753:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42757:	48 89 c6             	mov    %rax,%rsi
   4275a:	bf db 48 04 00       	mov    $0x448db,%edi
   4275f:	b8 00 00 00 00       	mov    $0x0,%eax
   42764:	e8 f0 fe ff ff       	call   42659 <panic>

0000000000042769 <default_exception>:
}

void default_exception(proc* p){
   42769:	55                   	push   %rbp
   4276a:	48 89 e5             	mov    %rsp,%rbp
   4276d:	48 83 ec 20          	sub    $0x20,%rsp
   42771:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   42775:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42779:	48 83 c0 08          	add    $0x8,%rax
   4277d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    panic("Unexpected exception %d!\n", reg->reg_intno);
   42781:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42785:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   4278c:	48 89 c6             	mov    %rax,%rsi
   4278f:	bf f9 48 04 00       	mov    $0x448f9,%edi
   42794:	b8 00 00 00 00       	mov    $0x0,%eax
   42799:	e8 bb fe ff ff       	call   42659 <panic>

000000000004279e <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   4279e:	55                   	push   %rbp
   4279f:	48 89 e5             	mov    %rsp,%rbp
   427a2:	48 83 ec 10          	sub    $0x10,%rsp
   427a6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   427aa:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   427ad:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   427b1:	78 06                	js     427b9 <pageindex+0x1b>
   427b3:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   427b7:	7e 14                	jle    427cd <pageindex+0x2f>
   427b9:	ba 18 49 04 00       	mov    $0x44918,%edx
   427be:	be 1e 00 00 00       	mov    $0x1e,%esi
   427c3:	bf 31 49 04 00       	mov    $0x44931,%edi
   427c8:	e8 6c ff ff ff       	call   42739 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   427cd:	b8 03 00 00 00       	mov    $0x3,%eax
   427d2:	2b 45 f4             	sub    -0xc(%rbp),%eax
   427d5:	89 c2                	mov    %eax,%edx
   427d7:	89 d0                	mov    %edx,%eax
   427d9:	c1 e0 03             	shl    $0x3,%eax
   427dc:	01 d0                	add    %edx,%eax
   427de:	83 c0 0c             	add    $0xc,%eax
   427e1:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   427e5:	89 c1                	mov    %eax,%ecx
   427e7:	48 d3 ea             	shr    %cl,%rdx
   427ea:	48 89 d0             	mov    %rdx,%rax
   427ed:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   427f2:	c9                   	leave  
   427f3:	c3                   	ret    

00000000000427f4 <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   427f4:	55                   	push   %rbp
   427f5:	48 89 e5             	mov    %rsp,%rbp
   427f8:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   427fc:	48 c7 05 f9 27 01 00 	movq   $0x56000,0x127f9(%rip)        # 55000 <kernel_pagetable>
   42803:	00 60 05 00 
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   42807:	ba 00 50 00 00       	mov    $0x5000,%edx
   4280c:	be 00 00 00 00       	mov    $0x0,%esi
   42811:	bf 00 60 05 00       	mov    $0x56000,%edi
   42816:	e8 49 0b 00 00       	call   43364 <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   4281b:	b8 00 70 05 00       	mov    $0x57000,%eax
   42820:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   42824:	48 89 05 d5 37 01 00 	mov    %rax,0x137d5(%rip)        # 56000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   4282b:	b8 00 80 05 00       	mov    $0x58000,%eax
   42830:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   42834:	48 89 05 c5 47 01 00 	mov    %rax,0x147c5(%rip)        # 57000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   4283b:	b8 00 90 05 00       	mov    $0x59000,%eax
   42840:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   42844:	48 89 05 b5 57 01 00 	mov    %rax,0x157b5(%rip)        # 58000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   4284b:	b8 00 a0 05 00       	mov    $0x5a000,%eax
   42850:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   42854:	48 89 05 ad 57 01 00 	mov    %rax,0x157ad(%rip)        # 58008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   4285b:	48 8b 05 9e 27 01 00 	mov    0x1279e(%rip),%rax        # 55000 <kernel_pagetable>
   42862:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42868:	b9 00 00 20 00       	mov    $0x200000,%ecx
   4286d:	ba 00 00 00 00       	mov    $0x0,%edx
   42872:	be 00 00 00 00       	mov    $0x0,%esi
   42877:	48 89 c7             	mov    %rax,%rdi
   4287a:	e8 b9 01 00 00       	call   42a38 <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   4287f:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42886:	00 
   42887:	eb 62                	jmp    428eb <virtual_memory_init+0xf7>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   42889:	48 8b 0d 70 27 01 00 	mov    0x12770(%rip),%rcx        # 55000 <kernel_pagetable>
   42890:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42894:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42898:	48 89 ce             	mov    %rcx,%rsi
   4289b:	48 89 c7             	mov    %rax,%rdi
   4289e:	e8 5b 05 00 00       	call   42dfe <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l1pagetable ?
        assert(vmap.pa == addr);
   428a3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   428a7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   428ab:	74 14                	je     428c1 <virtual_memory_init+0xcd>
   428ad:	ba 45 49 04 00       	mov    $0x44945,%edx
   428b2:	be 2d 00 00 00       	mov    $0x2d,%esi
   428b7:	bf 55 49 04 00       	mov    $0x44955,%edi
   428bc:	e8 78 fe ff ff       	call   42739 <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   428c1:	8b 45 f0             	mov    -0x10(%rbp),%eax
   428c4:	48 98                	cltq   
   428c6:	83 e0 03             	and    $0x3,%eax
   428c9:	48 83 f8 03          	cmp    $0x3,%rax
   428cd:	74 14                	je     428e3 <virtual_memory_init+0xef>
   428cf:	ba 68 49 04 00       	mov    $0x44968,%edx
   428d4:	be 2e 00 00 00       	mov    $0x2e,%esi
   428d9:	bf 55 49 04 00       	mov    $0x44955,%edi
   428de:	e8 56 fe ff ff       	call   42739 <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   428e3:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   428ea:	00 
   428eb:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   428f2:	00 
   428f3:	76 94                	jbe    42889 <virtual_memory_init+0x95>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   428f5:	48 8b 05 04 27 01 00 	mov    0x12704(%rip),%rax        # 55000 <kernel_pagetable>
   428fc:	48 89 c7             	mov    %rax,%rdi
   428ff:	e8 03 00 00 00       	call   42907 <set_pagetable>
}
   42904:	90                   	nop
   42905:	c9                   	leave  
   42906:	c3                   	ret    

0000000000042907 <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   42907:	55                   	push   %rbp
   42908:	48 89 e5             	mov    %rsp,%rbp
   4290b:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   4290f:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   42913:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42917:	25 ff 0f 00 00       	and    $0xfff,%eax
   4291c:	48 85 c0             	test   %rax,%rax
   4291f:	74 14                	je     42935 <set_pagetable+0x2e>
   42921:	ba 95 49 04 00       	mov    $0x44995,%edx
   42926:	be 3d 00 00 00       	mov    $0x3d,%esi
   4292b:	bf 55 49 04 00       	mov    $0x44955,%edi
   42930:	e8 04 fe ff ff       	call   42739 <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   42935:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   4293a:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   4293e:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42942:	48 89 ce             	mov    %rcx,%rsi
   42945:	48 89 c7             	mov    %rax,%rdi
   42948:	e8 b1 04 00 00       	call   42dfe <virtual_memory_lookup>
   4294d:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42951:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42956:	48 39 d0             	cmp    %rdx,%rax
   42959:	74 14                	je     4296f <set_pagetable+0x68>
   4295b:	ba b0 49 04 00       	mov    $0x449b0,%edx
   42960:	be 3f 00 00 00       	mov    $0x3f,%esi
   42965:	bf 55 49 04 00       	mov    $0x44955,%edi
   4296a:	e8 ca fd ff ff       	call   42739 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   4296f:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   42973:	48 8b 0d 86 26 01 00 	mov    0x12686(%rip),%rcx        # 55000 <kernel_pagetable>
   4297a:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   4297e:	48 89 ce             	mov    %rcx,%rsi
   42981:	48 89 c7             	mov    %rax,%rdi
   42984:	e8 75 04 00 00       	call   42dfe <virtual_memory_lookup>
   42989:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   4298d:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42991:	48 39 c2             	cmp    %rax,%rdx
   42994:	74 14                	je     429aa <set_pagetable+0xa3>
   42996:	ba 18 4a 04 00       	mov    $0x44a18,%edx
   4299b:	be 41 00 00 00       	mov    $0x41,%esi
   429a0:	bf 55 49 04 00       	mov    $0x44955,%edi
   429a5:	e8 8f fd ff ff       	call   42739 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   429aa:	48 8b 05 4f 26 01 00 	mov    0x1264f(%rip),%rax        # 55000 <kernel_pagetable>
   429b1:	48 89 c2             	mov    %rax,%rdx
   429b4:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   429b8:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   429bc:	48 89 ce             	mov    %rcx,%rsi
   429bf:	48 89 c7             	mov    %rax,%rdi
   429c2:	e8 37 04 00 00       	call   42dfe <virtual_memory_lookup>
   429c7:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   429cb:	48 8b 15 2e 26 01 00 	mov    0x1262e(%rip),%rdx        # 55000 <kernel_pagetable>
   429d2:	48 39 d0             	cmp    %rdx,%rax
   429d5:	74 14                	je     429eb <set_pagetable+0xe4>
   429d7:	ba 78 4a 04 00       	mov    $0x44a78,%edx
   429dc:	be 43 00 00 00       	mov    $0x43,%esi
   429e1:	bf 55 49 04 00       	mov    $0x44955,%edi
   429e6:	e8 4e fd ff ff       	call   42739 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   429eb:	ba 38 2a 04 00       	mov    $0x42a38,%edx
   429f0:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   429f4:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   429f8:	48 89 ce             	mov    %rcx,%rsi
   429fb:	48 89 c7             	mov    %rax,%rdi
   429fe:	e8 fb 03 00 00       	call   42dfe <virtual_memory_lookup>
   42a03:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42a07:	ba 38 2a 04 00       	mov    $0x42a38,%edx
   42a0c:	48 39 d0             	cmp    %rdx,%rax
   42a0f:	74 14                	je     42a25 <set_pagetable+0x11e>
   42a11:	ba e0 4a 04 00       	mov    $0x44ae0,%edx
   42a16:	be 45 00 00 00       	mov    $0x45,%esi
   42a1b:	bf 55 49 04 00       	mov    $0x44955,%edi
   42a20:	e8 14 fd ff ff       	call   42739 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   42a25:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42a29:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42a2d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42a31:	0f 22 d8             	mov    %rax,%cr3
}
   42a34:	90                   	nop
}
   42a35:	90                   	nop
   42a36:	c9                   	leave  
   42a37:	c3                   	ret    

0000000000042a38 <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   42a38:	55                   	push   %rbp
   42a39:	48 89 e5             	mov    %rsp,%rbp
   42a3c:	41 54                	push   %r12
   42a3e:	53                   	push   %rbx
   42a3f:	48 83 ec 50          	sub    $0x50,%rsp
   42a43:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42a47:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42a4b:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   42a4f:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
   42a53:	44 89 45 ac          	mov    %r8d,-0x54(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   42a57:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42a5b:	25 ff 0f 00 00       	and    $0xfff,%eax
   42a60:	48 85 c0             	test   %rax,%rax
   42a63:	74 14                	je     42a79 <virtual_memory_map+0x41>
   42a65:	ba 46 4b 04 00       	mov    $0x44b46,%edx
   42a6a:	be 66 00 00 00       	mov    $0x66,%esi
   42a6f:	bf 55 49 04 00       	mov    $0x44955,%edi
   42a74:	e8 c0 fc ff ff       	call   42739 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   42a79:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42a7d:	25 ff 0f 00 00       	and    $0xfff,%eax
   42a82:	48 85 c0             	test   %rax,%rax
   42a85:	74 14                	je     42a9b <virtual_memory_map+0x63>
   42a87:	ba 59 4b 04 00       	mov    $0x44b59,%edx
   42a8c:	be 67 00 00 00       	mov    $0x67,%esi
   42a91:	bf 55 49 04 00       	mov    $0x44955,%edi
   42a96:	e8 9e fc ff ff       	call   42739 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   42a9b:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42a9f:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42aa3:	48 01 d0             	add    %rdx,%rax
   42aa6:	48 3b 45 c0          	cmp    -0x40(%rbp),%rax
   42aaa:	73 24                	jae    42ad0 <virtual_memory_map+0x98>
   42aac:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42ab0:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42ab4:	48 01 d0             	add    %rdx,%rax
   42ab7:	48 85 c0             	test   %rax,%rax
   42aba:	74 14                	je     42ad0 <virtual_memory_map+0x98>
   42abc:	ba 6c 4b 04 00       	mov    $0x44b6c,%edx
   42ac1:	be 68 00 00 00       	mov    $0x68,%esi
   42ac6:	bf 55 49 04 00       	mov    $0x44955,%edi
   42acb:	e8 69 fc ff ff       	call   42739 <assert_fail>
    if (perm & PTE_P) {
   42ad0:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42ad3:	48 98                	cltq   
   42ad5:	83 e0 01             	and    $0x1,%eax
   42ad8:	48 85 c0             	test   %rax,%rax
   42adb:	74 6e                	je     42b4b <virtual_memory_map+0x113>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   42add:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42ae1:	25 ff 0f 00 00       	and    $0xfff,%eax
   42ae6:	48 85 c0             	test   %rax,%rax
   42ae9:	74 14                	je     42aff <virtual_memory_map+0xc7>
   42aeb:	ba 8a 4b 04 00       	mov    $0x44b8a,%edx
   42af0:	be 6a 00 00 00       	mov    $0x6a,%esi
   42af5:	bf 55 49 04 00       	mov    $0x44955,%edi
   42afa:	e8 3a fc ff ff       	call   42739 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   42aff:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42b03:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42b07:	48 01 d0             	add    %rdx,%rax
   42b0a:	48 3b 45 b8          	cmp    -0x48(%rbp),%rax
   42b0e:	73 14                	jae    42b24 <virtual_memory_map+0xec>
   42b10:	ba 9d 4b 04 00       	mov    $0x44b9d,%edx
   42b15:	be 6b 00 00 00       	mov    $0x6b,%esi
   42b1a:	bf 55 49 04 00       	mov    $0x44955,%edi
   42b1f:	e8 15 fc ff ff       	call   42739 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   42b24:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42b28:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42b2c:	48 01 d0             	add    %rdx,%rax
   42b2f:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   42b35:	76 14                	jbe    42b4b <virtual_memory_map+0x113>
   42b37:	ba ab 4b 04 00       	mov    $0x44bab,%edx
   42b3c:	be 6c 00 00 00       	mov    $0x6c,%esi
   42b41:	bf 55 49 04 00       	mov    $0x44955,%edi
   42b46:	e8 ee fb ff ff       	call   42739 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   42b4b:	83 7d ac 00          	cmpl   $0x0,-0x54(%rbp)
   42b4f:	78 09                	js     42b5a <virtual_memory_map+0x122>
   42b51:	81 7d ac ff 0f 00 00 	cmpl   $0xfff,-0x54(%rbp)
   42b58:	7e 14                	jle    42b6e <virtual_memory_map+0x136>
   42b5a:	ba c7 4b 04 00       	mov    $0x44bc7,%edx
   42b5f:	be 6e 00 00 00       	mov    $0x6e,%esi
   42b64:	bf 55 49 04 00       	mov    $0x44955,%edi
   42b69:	e8 cb fb ff ff       	call   42739 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   42b6e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42b72:	25 ff 0f 00 00       	and    $0xfff,%eax
   42b77:	48 85 c0             	test   %rax,%rax
   42b7a:	74 14                	je     42b90 <virtual_memory_map+0x158>
   42b7c:	ba e8 4b 04 00       	mov    $0x44be8,%edx
   42b81:	be 6f 00 00 00       	mov    $0x6f,%esi
   42b86:	bf 55 49 04 00       	mov    $0x44955,%edi
   42b8b:	e8 a9 fb ff ff       	call   42739 <assert_fail>

    int last_index123 = -1;
   42b90:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%rbp)
    x86_64_pagetable* l1pagetable = NULL;
   42b97:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
   42b9e:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42b9f:	e9 e7 00 00 00       	jmp    42c8b <virtual_memory_map+0x253>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   42ba4:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42ba8:	48 c1 e8 15          	shr    $0x15,%rax
   42bac:	89 45 dc             	mov    %eax,-0x24(%rbp)
        if (cur_index123 != last_index123) {
   42baf:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42bb2:	3b 45 ec             	cmp    -0x14(%rbp),%eax
   42bb5:	74 20                	je     42bd7 <virtual_memory_map+0x19f>
            // TODO --> done
            // find pointer to last level pagetable for current va

			l1pagetable = lookup_l1pagetable(pagetable, va, perm);	
   42bb7:	8b 55 ac             	mov    -0x54(%rbp),%edx
   42bba:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   42bbe:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42bc2:	48 89 ce             	mov    %rcx,%rsi
   42bc5:	48 89 c7             	mov    %rax,%rdi
   42bc8:	e8 d7 00 00 00       	call   42ca4 <lookup_l1pagetable>
   42bcd:	48 89 45 e0          	mov    %rax,-0x20(%rbp)

            last_index123 = cur_index123;
   42bd1:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42bd4:	89 45 ec             	mov    %eax,-0x14(%rbp)
        }
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   42bd7:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42bda:	48 98                	cltq   
   42bdc:	83 e0 01             	and    $0x1,%eax
   42bdf:	48 85 c0             	test   %rax,%rax
   42be2:	74 3a                	je     42c1e <virtual_memory_map+0x1e6>
   42be4:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42be9:	74 33                	je     42c1e <virtual_memory_map+0x1e6>
            // TODO --> done
            // map `pa` at appropriate entry with permissions `perm`
			l1pagetable->entry[L1PAGEINDEX(va)] =  (0x00000000FFFFFFFF & pa) | perm;
   42beb:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42bef:	41 89 c4             	mov    %eax,%r12d
   42bf2:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42bf5:	48 63 d8             	movslq %eax,%rbx
   42bf8:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42bfc:	be 03 00 00 00       	mov    $0x3,%esi
   42c01:	48 89 c7             	mov    %rax,%rdi
   42c04:	e8 95 fb ff ff       	call   4279e <pageindex>
   42c09:	89 c2                	mov    %eax,%edx
   42c0b:	4c 89 e1             	mov    %r12,%rcx
   42c0e:	48 09 d9             	or     %rbx,%rcx
   42c11:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42c15:	48 63 d2             	movslq %edx,%rdx
   42c18:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42c1c:	eb 55                	jmp    42c73 <virtual_memory_map+0x23b>

        } else if (l1pagetable) { // if page is NOT marked present
   42c1e:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42c23:	74 26                	je     42c4b <virtual_memory_map+0x213>
            // TODO --> done
            // map to address 0 with `perm`
			l1pagetable->entry[L1PAGEINDEX(va)] = 0 | perm;
   42c25:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42c29:	be 03 00 00 00       	mov    $0x3,%esi
   42c2e:	48 89 c7             	mov    %rax,%rdi
   42c31:	e8 68 fb ff ff       	call   4279e <pageindex>
   42c36:	89 c2                	mov    %eax,%edx
   42c38:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42c3b:	48 63 c8             	movslq %eax,%rcx
   42c3e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42c42:	48 63 d2             	movslq %edx,%rdx
   42c45:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42c49:	eb 28                	jmp    42c73 <virtual_memory_map+0x23b>

        } else if (perm & PTE_P) {
   42c4b:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42c4e:	48 98                	cltq   
   42c50:	83 e0 01             	and    $0x1,%eax
   42c53:	48 85 c0             	test   %rax,%rax
   42c56:	74 1b                	je     42c73 <virtual_memory_map+0x23b>
            // error, no allocated l1 page found for va
            log_printf("[Kern Info] failed to find l1pagetable address at " __FILE__ ": %d\n", __LINE__);
   42c58:	be 8b 00 00 00       	mov    $0x8b,%esi
   42c5d:	bf 10 4c 04 00       	mov    $0x44c10,%edi
   42c62:	b8 00 00 00 00       	mov    $0x0,%eax
   42c67:	e8 af f7 ff ff       	call   4241b <log_printf>
            return -1;
   42c6c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42c71:	eb 28                	jmp    42c9b <virtual_memory_map+0x263>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42c73:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
   42c7a:	00 
   42c7b:	48 81 45 b8 00 10 00 	addq   $0x1000,-0x48(%rbp)
   42c82:	00 
   42c83:	48 81 6d b0 00 10 00 	subq   $0x1000,-0x50(%rbp)
   42c8a:	00 
   42c8b:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   42c90:	0f 85 0e ff ff ff    	jne    42ba4 <virtual_memory_map+0x16c>
        }
    }
    return 0;
   42c96:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42c9b:	48 83 c4 50          	add    $0x50,%rsp
   42c9f:	5b                   	pop    %rbx
   42ca0:	41 5c                	pop    %r12
   42ca2:	5d                   	pop    %rbp
   42ca3:	c3                   	ret    

0000000000042ca4 <lookup_l1pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   42ca4:	55                   	push   %rbp
   42ca5:	48 89 e5             	mov    %rsp,%rbp
   42ca8:	48 83 ec 40          	sub    $0x40,%rsp
   42cac:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42cb0:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42cb4:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   42cb7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42cbb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l1 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   42cbf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   42cc6:	e9 23 01 00 00       	jmp    42dee <lookup_l1pagetable+0x14a>
        // TODO --> done
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        x86_64_pageentry_t pe = pt->entry[PAGEINDEX(va, i)]; // replace this
   42ccb:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42cce:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42cd2:	89 d6                	mov    %edx,%esi
   42cd4:	48 89 c7             	mov    %rax,%rdi
   42cd7:	e8 c2 fa ff ff       	call   4279e <pageindex>
   42cdc:	89 c2                	mov    %eax,%edx
   42cde:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42ce2:	48 63 d2             	movslq %edx,%rdx
   42ce5:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   42ce9:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   42ced:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42cf1:	83 e0 01             	and    $0x1,%eax
   42cf4:	48 85 c0             	test   %rax,%rax
   42cf7:	75 63                	jne    42d5c <lookup_l1pagetable+0xb8>
            log_printf("[Kern Info] Error looking up l1pagetable: Pagetable address: 0x%x perm: 0x%x."
   42cf9:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42cfc:	8d 48 02             	lea    0x2(%rax),%ecx
   42cff:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d03:	25 ff 0f 00 00       	and    $0xfff,%eax
   42d08:	48 89 c2             	mov    %rax,%rdx
   42d0b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d0f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42d15:	48 89 c6             	mov    %rax,%rsi
   42d18:	bf 58 4c 04 00       	mov    $0x44c58,%edi
   42d1d:	b8 00 00 00 00       	mov    $0x0,%eax
   42d22:	e8 f4 f6 ff ff       	call   4241b <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   42d27:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42d2a:	48 98                	cltq   
   42d2c:	83 e0 01             	and    $0x1,%eax
   42d2f:	48 85 c0             	test   %rax,%rax
   42d32:	75 0a                	jne    42d3e <lookup_l1pagetable+0x9a>
                return NULL;
   42d34:	b8 00 00 00 00       	mov    $0x0,%eax
   42d39:	e9 be 00 00 00       	jmp    42dfc <lookup_l1pagetable+0x158>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   42d3e:	be af 00 00 00       	mov    $0xaf,%esi
   42d43:	bf c0 4c 04 00       	mov    $0x44cc0,%edi
   42d48:	b8 00 00 00 00       	mov    $0x0,%eax
   42d4d:	e8 c9 f6 ff ff       	call   4241b <log_printf>
            return NULL;
   42d52:	b8 00 00 00 00       	mov    $0x0,%eax
   42d57:	e9 a0 00 00 00       	jmp    42dfc <lookup_l1pagetable+0x158>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   42d5c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d60:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42d66:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   42d6c:	76 14                	jbe    42d82 <lookup_l1pagetable+0xde>
   42d6e:	ba 08 4d 04 00       	mov    $0x44d08,%edx
   42d73:	be b4 00 00 00       	mov    $0xb4,%esi
   42d78:	bf 55 49 04 00       	mov    $0x44955,%edi
   42d7d:	e8 b7 f9 ff ff       	call   42739 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   42d82:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42d85:	48 98                	cltq   
   42d87:	83 e0 02             	and    $0x2,%eax
   42d8a:	48 85 c0             	test   %rax,%rax
   42d8d:	74 20                	je     42daf <lookup_l1pagetable+0x10b>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   42d8f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d93:	83 e0 02             	and    $0x2,%eax
   42d96:	48 85 c0             	test   %rax,%rax
   42d99:	75 14                	jne    42daf <lookup_l1pagetable+0x10b>
   42d9b:	ba 28 4d 04 00       	mov    $0x44d28,%edx
   42da0:	be b6 00 00 00       	mov    $0xb6,%esi
   42da5:	bf 55 49 04 00       	mov    $0x44955,%edi
   42daa:	e8 8a f9 ff ff       	call   42739 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   42daf:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42db2:	48 98                	cltq   
   42db4:	83 e0 04             	and    $0x4,%eax
   42db7:	48 85 c0             	test   %rax,%rax
   42dba:	74 20                	je     42ddc <lookup_l1pagetable+0x138>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   42dbc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42dc0:	83 e0 04             	and    $0x4,%eax
   42dc3:	48 85 c0             	test   %rax,%rax
   42dc6:	75 14                	jne    42ddc <lookup_l1pagetable+0x138>
   42dc8:	ba 33 4d 04 00       	mov    $0x44d33,%edx
   42dcd:	be b9 00 00 00       	mov    $0xb9,%esi
   42dd2:	bf 55 49 04 00       	mov    $0x44955,%edi
   42dd7:	e8 5d f9 ff ff       	call   42739 <assert_fail>
        }

        // TODO --> done
        // set pt to physical address to next pagetable using `pe`
        pt = (x86_64_pagetable *) PTE_ADDR(pe); // replace this
   42ddc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42de0:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42de6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   42dea:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   42dee:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   42df2:	0f 8e d3 fe ff ff    	jle    42ccb <lookup_l1pagetable+0x27>
    }
    return pt;
   42df8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   42dfc:	c9                   	leave  
   42dfd:	c3                   	ret    

0000000000042dfe <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   42dfe:	55                   	push   %rbp
   42dff:	48 89 e5             	mov    %rsp,%rbp
   42e02:	48 83 ec 50          	sub    $0x50,%rsp
   42e06:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42e0a:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42e0e:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   42e12:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42e16:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   42e1a:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   42e21:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42e22:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   42e29:	eb 41                	jmp    42e6c <virtual_memory_lookup+0x6e>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   42e2b:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42e2e:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42e32:	89 d6                	mov    %edx,%esi
   42e34:	48 89 c7             	mov    %rax,%rdi
   42e37:	e8 62 f9 ff ff       	call   4279e <pageindex>
   42e3c:	89 c2                	mov    %eax,%edx
   42e3e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42e42:	48 63 d2             	movslq %edx,%rdx
   42e45:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   42e49:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e4d:	83 e0 06             	and    $0x6,%eax
   42e50:	48 f7 d0             	not    %rax
   42e53:	48 21 d0             	and    %rdx,%rax
   42e56:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42e5a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e5e:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42e64:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42e68:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   42e6c:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   42e70:	7f 0c                	jg     42e7e <virtual_memory_lookup+0x80>
   42e72:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e76:	83 e0 01             	and    $0x1,%eax
   42e79:	48 85 c0             	test   %rax,%rax
   42e7c:	75 ad                	jne    42e2b <virtual_memory_lookup+0x2d>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   42e7e:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   42e85:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   42e8c:	ff 
   42e8d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   42e94:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e98:	83 e0 01             	and    $0x1,%eax
   42e9b:	48 85 c0             	test   %rax,%rax
   42e9e:	74 34                	je     42ed4 <virtual_memory_lookup+0xd6>
        vam.pn = PAGENUMBER(pe);
   42ea0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ea4:	48 c1 e8 0c          	shr    $0xc,%rax
   42ea8:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   42eab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42eaf:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42eb5:	48 89 c2             	mov    %rax,%rdx
   42eb8:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42ebc:	25 ff 0f 00 00       	and    $0xfff,%eax
   42ec1:	48 09 d0             	or     %rdx,%rax
   42ec4:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   42ec8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ecc:	25 ff 0f 00 00       	and    $0xfff,%eax
   42ed1:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   42ed4:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42ed8:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42edc:	48 89 10             	mov    %rdx,(%rax)
   42edf:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   42ee3:	48 89 50 08          	mov    %rdx,0x8(%rax)
   42ee7:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42eeb:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   42eef:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42ef3:	c9                   	leave  
   42ef4:	c3                   	ret    

0000000000042ef5 <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   42ef5:	55                   	push   %rbp
   42ef6:	48 89 e5             	mov    %rsp,%rbp
   42ef9:	48 83 ec 40          	sub    $0x40,%rsp
   42efd:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42f01:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   42f04:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   42f08:	c7 45 f8 07 00 00 00 	movl   $0x7,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   42f0f:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   42f13:	78 08                	js     42f1d <program_load+0x28>
   42f15:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42f18:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   42f1b:	7c 14                	jl     42f31 <program_load+0x3c>
   42f1d:	ba 40 4d 04 00       	mov    $0x44d40,%edx
   42f22:	be 37 00 00 00       	mov    $0x37,%esi
   42f27:	bf 70 4d 04 00       	mov    $0x44d70,%edi
   42f2c:	e8 08 f8 ff ff       	call   42739 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   42f31:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42f34:	48 98                	cltq   
   42f36:	48 c1 e0 04          	shl    $0x4,%rax
   42f3a:	48 05 20 50 04 00    	add    $0x45020,%rax
   42f40:	48 8b 00             	mov    (%rax),%rax
   42f43:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   42f47:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42f4b:	8b 00                	mov    (%rax),%eax
   42f4d:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   42f52:	74 14                	je     42f68 <program_load+0x73>
   42f54:	ba 82 4d 04 00       	mov    $0x44d82,%edx
   42f59:	be 39 00 00 00       	mov    $0x39,%esi
   42f5e:	bf 70 4d 04 00       	mov    $0x44d70,%edi
   42f63:	e8 d1 f7 ff ff       	call   42739 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   42f68:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42f6c:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42f70:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42f74:	48 01 d0             	add    %rdx,%rax
   42f77:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   42f7b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42f82:	e9 94 00 00 00       	jmp    4301b <program_load+0x126>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   42f87:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42f8a:	48 63 d0             	movslq %eax,%rdx
   42f8d:	48 89 d0             	mov    %rdx,%rax
   42f90:	48 c1 e0 03          	shl    $0x3,%rax
   42f94:	48 29 d0             	sub    %rdx,%rax
   42f97:	48 c1 e0 03          	shl    $0x3,%rax
   42f9b:	48 89 c2             	mov    %rax,%rdx
   42f9e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42fa2:	48 01 d0             	add    %rdx,%rax
   42fa5:	8b 00                	mov    (%rax),%eax
   42fa7:	83 f8 01             	cmp    $0x1,%eax
   42faa:	75 6b                	jne    43017 <program_load+0x122>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   42fac:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42faf:	48 63 d0             	movslq %eax,%rdx
   42fb2:	48 89 d0             	mov    %rdx,%rax
   42fb5:	48 c1 e0 03          	shl    $0x3,%rax
   42fb9:	48 29 d0             	sub    %rdx,%rax
   42fbc:	48 c1 e0 03          	shl    $0x3,%rax
   42fc0:	48 89 c2             	mov    %rax,%rdx
   42fc3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42fc7:	48 01 d0             	add    %rdx,%rax
   42fca:	48 8b 50 08          	mov    0x8(%rax),%rdx
   42fce:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42fd2:	48 01 d0             	add    %rdx,%rax
   42fd5:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   42fd9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42fdc:	48 63 d0             	movslq %eax,%rdx
   42fdf:	48 89 d0             	mov    %rdx,%rax
   42fe2:	48 c1 e0 03          	shl    $0x3,%rax
   42fe6:	48 29 d0             	sub    %rdx,%rax
   42fe9:	48 c1 e0 03          	shl    $0x3,%rax
   42fed:	48 89 c2             	mov    %rax,%rdx
   42ff0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ff4:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   42ff8:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42ffc:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43000:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43004:	48 89 c7             	mov    %rax,%rdi
   43007:	e8 3d 00 00 00       	call   43049 <program_load_segment>
   4300c:	85 c0                	test   %eax,%eax
   4300e:	79 07                	jns    43017 <program_load+0x122>
                return -1;
   43010:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43015:	eb 30                	jmp    43047 <program_load+0x152>
    for (int i = 0; i < eh->e_phnum; ++i) {
   43017:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4301b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4301f:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   43023:	0f b7 c0             	movzwl %ax,%eax
   43026:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   43029:	0f 8c 58 ff ff ff    	jl     42f87 <program_load+0x92>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   4302f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43033:	48 8b 50 18          	mov    0x18(%rax),%rdx
   43037:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4303b:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    return 0;
   43042:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43047:	c9                   	leave  
   43048:	c3                   	ret    

0000000000043049 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   43049:	55                   	push   %rbp
   4304a:	48 89 e5             	mov    %rsp,%rbp
   4304d:	48 83 ec 60          	sub    $0x60,%rsp
   43051:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
   43055:	48 89 75 b0          	mov    %rsi,-0x50(%rbp)
   43059:	48 89 55 a8          	mov    %rdx,-0x58(%rbp)
   4305d:	48 89 4d a0          	mov    %rcx,-0x60(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   43061:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   43065:	48 8b 40 10          	mov    0x10(%rax),%rax
   43069:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   4306d:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   43071:	48 8b 50 20          	mov    0x20(%rax),%rdx
   43075:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43079:	48 01 d0             	add    %rdx,%rax
   4307c:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43080:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   43084:	48 8b 50 28          	mov    0x28(%rax),%rdx
   43088:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4308c:	48 01 d0             	add    %rdx,%rax
   4308f:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   43093:	48 81 65 e8 00 f0 ff 	andq   $0xfffffffffffff000,-0x18(%rbp)
   4309a:	ff 


	if ((ph->p_flags & ELF_PFLAG_WRITE) == 0) {
   4309b:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   4309f:	8b 40 04             	mov    0x4(%rax),%eax
   430a2:	83 e0 02             	and    $0x2,%eax
   430a5:	85 c0                	test   %eax,%eax
   430a7:	0f 85 af 00 00 00    	jne    4315c <program_load_segment+0x113>
		for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   430ad:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   430b1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   430b5:	e9 8f 00 00 00       	jmp    43149 <program_load_segment+0x100>
			uintptr_t pa;
			if (next_free_page(&pa) < 0
   430ba:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   430be:	48 89 c7             	mov    %rax,%rdi
   430c1:	e8 71 d2 ff ff       	call   40337 <next_free_page>
   430c6:	85 c0                	test   %eax,%eax
   430c8:	78 45                	js     4310f <program_load_segment+0xc6>
				|| assign_physical_page(pa, p->p_pid) < 0
   430ca:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   430ce:	8b 00                	mov    (%rax),%eax
   430d0:	0f be d0             	movsbl %al,%edx
   430d3:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   430d7:	89 d6                	mov    %edx,%esi
   430d9:	48 89 c7             	mov    %rax,%rdi
   430dc:	e8 25 d5 ff ff       	call   40606 <assign_physical_page>
   430e1:	85 c0                	test   %eax,%eax
   430e3:	78 2a                	js     4310f <program_load_segment+0xc6>
				|| virtual_memory_map(p->p_pagetable, addr, pa, PAGESIZE, PTE_P | PTE_W | PTE_U) < 0) {
   430e5:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   430e9:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   430ed:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   430f4:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   430f8:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   430fe:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43103:	48 89 c7             	mov    %rax,%rdi
   43106:	e8 2d f9 ff ff       	call   42a38 <virtual_memory_map>
   4310b:	85 c0                	test   %eax,%eax
   4310d:	79 32                	jns    43141 <program_load_segment+0xf8>

				console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   4310f:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   43113:	8b 00                	mov    (%rax),%eax
   43115:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43119:	49 89 d0             	mov    %rdx,%r8
   4311c:	89 c1                	mov    %eax,%ecx
   4311e:	ba a0 4d 04 00       	mov    $0x44da0,%edx
   43123:	be 00 c0 00 00       	mov    $0xc000,%esi
   43128:	bf e0 06 00 00       	mov    $0x6e0,%edi
   4312d:	b8 00 00 00 00       	mov    $0x0,%eax
   43132:	e8 e4 0f 00 00       	call   4411b <console_printf>
				return -1;
   43137:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4313c:	e9 23 01 00 00       	jmp    43264 <program_load_segment+0x21b>
		for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   43141:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43148:	00 
   43149:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4314d:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   43151:	0f 82 63 ff ff ff    	jb     430ba <program_load_segment+0x71>
   43157:	e9 a7 00 00 00       	jmp    43203 <program_load_segment+0x1ba>
			}
		}	
	}
	else {
		for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   4315c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43160:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43164:	e9 8c 00 00 00       	jmp    431f5 <program_load_segment+0x1ac>
			uintptr_t pa;
			if (next_free_page(&pa) < 0
   43169:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   4316d:	48 89 c7             	mov    %rax,%rdi
   43170:	e8 c2 d1 ff ff       	call   40337 <next_free_page>
   43175:	85 c0                	test   %eax,%eax
   43177:	78 45                	js     431be <program_load_segment+0x175>
				|| assign_physical_page(pa, p->p_pid) < 0
   43179:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4317d:	8b 00                	mov    (%rax),%eax
   4317f:	0f be d0             	movsbl %al,%edx
   43182:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43186:	89 d6                	mov    %edx,%esi
   43188:	48 89 c7             	mov    %rax,%rdi
   4318b:	e8 76 d4 ff ff       	call   40606 <assign_physical_page>
   43190:	85 c0                	test   %eax,%eax
   43192:	78 2a                	js     431be <program_load_segment+0x175>
				|| virtual_memory_map(p->p_pagetable, addr, pa, PAGESIZE, PTE_P | PTE_W | PTE_U) < 0) {
   43194:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   43198:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4319c:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   431a3:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   431a7:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   431ad:	b9 00 10 00 00       	mov    $0x1000,%ecx
   431b2:	48 89 c7             	mov    %rax,%rdi
   431b5:	e8 7e f8 ff ff       	call   42a38 <virtual_memory_map>
   431ba:	85 c0                	test   %eax,%eax
   431bc:	79 2f                	jns    431ed <program_load_segment+0x1a4>

				console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   431be:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   431c2:	8b 00                	mov    (%rax),%eax
   431c4:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   431c8:	49 89 d0             	mov    %rdx,%r8
   431cb:	89 c1                	mov    %eax,%ecx
   431cd:	ba a0 4d 04 00       	mov    $0x44da0,%edx
   431d2:	be 00 c0 00 00       	mov    $0xc000,%esi
   431d7:	bf e0 06 00 00       	mov    $0x6e0,%edi
   431dc:	b8 00 00 00 00       	mov    $0x0,%eax
   431e1:	e8 35 0f 00 00       	call   4411b <console_printf>
				return -1;
   431e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   431eb:	eb 77                	jmp    43264 <program_load_segment+0x21b>
		for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   431ed:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   431f4:	00 
   431f5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   431f9:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   431fd:	0f 82 66 ff ff ff    	jb     43169 <program_load_segment+0x120>
    //         return -1;
    //     }
    // }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   43203:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   43207:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   4320e:	48 89 c7             	mov    %rax,%rdi
   43211:	e8 f1 f6 ff ff       	call   42907 <set_pagetable>

    // copy data from executable image into process memory
    //
    // this part is causing me issues because its using an
    // identity map
    memcpy((uint8_t*) va, src, end_file - va);
   43216:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4321a:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   4321e:	48 89 c2             	mov    %rax,%rdx
   43221:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43225:	48 8b 4d a8          	mov    -0x58(%rbp),%rcx
   43229:	48 89 ce             	mov    %rcx,%rsi
   4322c:	48 89 c7             	mov    %rax,%rdi
   4322f:	e8 32 00 00 00       	call   43266 <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   43234:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43238:	48 2b 45 e0          	sub    -0x20(%rbp),%rax
   4323c:	48 89 c2             	mov    %rax,%rdx
   4323f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43243:	be 00 00 00 00       	mov    $0x0,%esi
   43248:	48 89 c7             	mov    %rax,%rdi
   4324b:	e8 14 01 00 00       	call   43364 <memset>

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   43250:	48 8b 05 a9 1d 01 00 	mov    0x11da9(%rip),%rax        # 55000 <kernel_pagetable>
   43257:	48 89 c7             	mov    %rax,%rdi
   4325a:	e8 a8 f6 ff ff       	call   42907 <set_pagetable>
    return 0;
   4325f:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43264:	c9                   	leave  
   43265:	c3                   	ret    

0000000000043266 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   43266:	55                   	push   %rbp
   43267:	48 89 e5             	mov    %rsp,%rbp
   4326a:	48 83 ec 28          	sub    $0x28,%rsp
   4326e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43272:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43276:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   4327a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4327e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43282:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43286:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   4328a:	eb 1c                	jmp    432a8 <memcpy+0x42>
        *d = *s;
   4328c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43290:	0f b6 10             	movzbl (%rax),%edx
   43293:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43297:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43299:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   4329e:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   432a3:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   432a8:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   432ad:	75 dd                	jne    4328c <memcpy+0x26>
    }
    return dst;
   432af:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   432b3:	c9                   	leave  
   432b4:	c3                   	ret    

00000000000432b5 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   432b5:	55                   	push   %rbp
   432b6:	48 89 e5             	mov    %rsp,%rbp
   432b9:	48 83 ec 28          	sub    $0x28,%rsp
   432bd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   432c1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   432c5:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   432c9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   432cd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   432d1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   432d5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   432d9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   432dd:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   432e1:	73 6a                	jae    4334d <memmove+0x98>
   432e3:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   432e7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   432eb:	48 01 d0             	add    %rdx,%rax
   432ee:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   432f2:	73 59                	jae    4334d <memmove+0x98>
        s += n, d += n;
   432f4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   432f8:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   432fc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43300:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   43304:	eb 17                	jmp    4331d <memmove+0x68>
            *--d = *--s;
   43306:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   4330b:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   43310:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43314:	0f b6 10             	movzbl (%rax),%edx
   43317:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4331b:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   4331d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43321:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43325:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43329:	48 85 c0             	test   %rax,%rax
   4332c:	75 d8                	jne    43306 <memmove+0x51>
    if (s < d && s + n > d) {
   4332e:	eb 2e                	jmp    4335e <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   43330:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43334:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43338:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   4333c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43340:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43344:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   43348:	0f b6 12             	movzbl (%rdx),%edx
   4334b:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   4334d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43351:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43355:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43359:	48 85 c0             	test   %rax,%rax
   4335c:	75 d2                	jne    43330 <memmove+0x7b>
        }
    }
    return dst;
   4335e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43362:	c9                   	leave  
   43363:	c3                   	ret    

0000000000043364 <memset>:

void* memset(void* v, int c, size_t n) {
   43364:	55                   	push   %rbp
   43365:	48 89 e5             	mov    %rsp,%rbp
   43368:	48 83 ec 28          	sub    $0x28,%rsp
   4336c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43370:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   43373:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43377:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4337b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   4337f:	eb 15                	jmp    43396 <memset+0x32>
        *p = c;
   43381:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43384:	89 c2                	mov    %eax,%edx
   43386:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4338a:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   4338c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43391:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43396:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   4339b:	75 e4                	jne    43381 <memset+0x1d>
    }
    return v;
   4339d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   433a1:	c9                   	leave  
   433a2:	c3                   	ret    

00000000000433a3 <strlen>:

size_t strlen(const char* s) {
   433a3:	55                   	push   %rbp
   433a4:	48 89 e5             	mov    %rsp,%rbp
   433a7:	48 83 ec 18          	sub    $0x18,%rsp
   433ab:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   433af:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   433b6:	00 
   433b7:	eb 0a                	jmp    433c3 <strlen+0x20>
        ++n;
   433b9:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   433be:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   433c3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   433c7:	0f b6 00             	movzbl (%rax),%eax
   433ca:	84 c0                	test   %al,%al
   433cc:	75 eb                	jne    433b9 <strlen+0x16>
    }
    return n;
   433ce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   433d2:	c9                   	leave  
   433d3:	c3                   	ret    

00000000000433d4 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   433d4:	55                   	push   %rbp
   433d5:	48 89 e5             	mov    %rsp,%rbp
   433d8:	48 83 ec 20          	sub    $0x20,%rsp
   433dc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   433e0:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   433e4:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   433eb:	00 
   433ec:	eb 0a                	jmp    433f8 <strnlen+0x24>
        ++n;
   433ee:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   433f3:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   433f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   433fc:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   43400:	74 0b                	je     4340d <strnlen+0x39>
   43402:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43406:	0f b6 00             	movzbl (%rax),%eax
   43409:	84 c0                	test   %al,%al
   4340b:	75 e1                	jne    433ee <strnlen+0x1a>
    }
    return n;
   4340d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43411:	c9                   	leave  
   43412:	c3                   	ret    

0000000000043413 <strcpy>:

char* strcpy(char* dst, const char* src) {
   43413:	55                   	push   %rbp
   43414:	48 89 e5             	mov    %rsp,%rbp
   43417:	48 83 ec 20          	sub    $0x20,%rsp
   4341b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4341f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   43423:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43427:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   4342b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   4342f:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43433:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43437:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4343b:	48 8d 48 01          	lea    0x1(%rax),%rcx
   4343f:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   43443:	0f b6 12             	movzbl (%rdx),%edx
   43446:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   43448:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4344c:	48 83 e8 01          	sub    $0x1,%rax
   43450:	0f b6 00             	movzbl (%rax),%eax
   43453:	84 c0                	test   %al,%al
   43455:	75 d4                	jne    4342b <strcpy+0x18>
    return dst;
   43457:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   4345b:	c9                   	leave  
   4345c:	c3                   	ret    

000000000004345d <strcmp>:

int strcmp(const char* a, const char* b) {
   4345d:	55                   	push   %rbp
   4345e:	48 89 e5             	mov    %rsp,%rbp
   43461:	48 83 ec 10          	sub    $0x10,%rsp
   43465:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43469:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   4346d:	eb 0a                	jmp    43479 <strcmp+0x1c>
        ++a, ++b;
   4346f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43474:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43479:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4347d:	0f b6 00             	movzbl (%rax),%eax
   43480:	84 c0                	test   %al,%al
   43482:	74 1d                	je     434a1 <strcmp+0x44>
   43484:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43488:	0f b6 00             	movzbl (%rax),%eax
   4348b:	84 c0                	test   %al,%al
   4348d:	74 12                	je     434a1 <strcmp+0x44>
   4348f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43493:	0f b6 10             	movzbl (%rax),%edx
   43496:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4349a:	0f b6 00             	movzbl (%rax),%eax
   4349d:	38 c2                	cmp    %al,%dl
   4349f:	74 ce                	je     4346f <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   434a1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   434a5:	0f b6 00             	movzbl (%rax),%eax
   434a8:	89 c2                	mov    %eax,%edx
   434aa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   434ae:	0f b6 00             	movzbl (%rax),%eax
   434b1:	38 d0                	cmp    %dl,%al
   434b3:	0f 92 c0             	setb   %al
   434b6:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   434b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   434bd:	0f b6 00             	movzbl (%rax),%eax
   434c0:	89 c1                	mov    %eax,%ecx
   434c2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   434c6:	0f b6 00             	movzbl (%rax),%eax
   434c9:	38 c1                	cmp    %al,%cl
   434cb:	0f 92 c0             	setb   %al
   434ce:	0f b6 c0             	movzbl %al,%eax
   434d1:	29 c2                	sub    %eax,%edx
   434d3:	89 d0                	mov    %edx,%eax
}
   434d5:	c9                   	leave  
   434d6:	c3                   	ret    

00000000000434d7 <strchr>:

char* strchr(const char* s, int c) {
   434d7:	55                   	push   %rbp
   434d8:	48 89 e5             	mov    %rsp,%rbp
   434db:	48 83 ec 10          	sub    $0x10,%rsp
   434df:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   434e3:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   434e6:	eb 05                	jmp    434ed <strchr+0x16>
        ++s;
   434e8:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   434ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   434f1:	0f b6 00             	movzbl (%rax),%eax
   434f4:	84 c0                	test   %al,%al
   434f6:	74 0e                	je     43506 <strchr+0x2f>
   434f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   434fc:	0f b6 00             	movzbl (%rax),%eax
   434ff:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43502:	38 d0                	cmp    %dl,%al
   43504:	75 e2                	jne    434e8 <strchr+0x11>
    }
    if (*s == (char) c) {
   43506:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4350a:	0f b6 00             	movzbl (%rax),%eax
   4350d:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43510:	38 d0                	cmp    %dl,%al
   43512:	75 06                	jne    4351a <strchr+0x43>
        return (char*) s;
   43514:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43518:	eb 05                	jmp    4351f <strchr+0x48>
    } else {
        return NULL;
   4351a:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   4351f:	c9                   	leave  
   43520:	c3                   	ret    

0000000000043521 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   43521:	55                   	push   %rbp
   43522:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   43525:	8b 05 d5 7a 01 00    	mov    0x17ad5(%rip),%eax        # 5b000 <rand_seed_set>
   4352b:	85 c0                	test   %eax,%eax
   4352d:	75 0a                	jne    43539 <rand+0x18>
        srand(819234718U);
   4352f:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   43534:	e8 24 00 00 00       	call   4355d <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   43539:	8b 05 c5 7a 01 00    	mov    0x17ac5(%rip),%eax        # 5b004 <rand_seed>
   4353f:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   43545:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   4354a:	89 05 b4 7a 01 00    	mov    %eax,0x17ab4(%rip)        # 5b004 <rand_seed>
    return rand_seed & RAND_MAX;
   43550:	8b 05 ae 7a 01 00    	mov    0x17aae(%rip),%eax        # 5b004 <rand_seed>
   43556:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   4355b:	5d                   	pop    %rbp
   4355c:	c3                   	ret    

000000000004355d <srand>:

void srand(unsigned seed) {
   4355d:	55                   	push   %rbp
   4355e:	48 89 e5             	mov    %rsp,%rbp
   43561:	48 83 ec 08          	sub    $0x8,%rsp
   43565:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   43568:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4356b:	89 05 93 7a 01 00    	mov    %eax,0x17a93(%rip)        # 5b004 <rand_seed>
    rand_seed_set = 1;
   43571:	c7 05 85 7a 01 00 01 	movl   $0x1,0x17a85(%rip)        # 5b000 <rand_seed_set>
   43578:	00 00 00 
}
   4357b:	90                   	nop
   4357c:	c9                   	leave  
   4357d:	c3                   	ret    

000000000004357e <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   4357e:	55                   	push   %rbp
   4357f:	48 89 e5             	mov    %rsp,%rbp
   43582:	48 83 ec 28          	sub    $0x28,%rsp
   43586:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4358a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   4358e:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   43591:	48 c7 45 f8 c0 4f 04 	movq   $0x44fc0,-0x8(%rbp)
   43598:	00 
    if (base < 0) {
   43599:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   4359d:	79 0b                	jns    435aa <fill_numbuf+0x2c>
        digits = lower_digits;
   4359f:	48 c7 45 f8 e0 4f 04 	movq   $0x44fe0,-0x8(%rbp)
   435a6:	00 
        base = -base;
   435a7:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   435aa:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   435af:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   435b3:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   435b6:	8b 45 dc             	mov    -0x24(%rbp),%eax
   435b9:	48 63 c8             	movslq %eax,%rcx
   435bc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   435c0:	ba 00 00 00 00       	mov    $0x0,%edx
   435c5:	48 f7 f1             	div    %rcx
   435c8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   435cc:	48 01 d0             	add    %rdx,%rax
   435cf:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   435d4:	0f b6 10             	movzbl (%rax),%edx
   435d7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   435db:	88 10                	mov    %dl,(%rax)
        val /= base;
   435dd:	8b 45 dc             	mov    -0x24(%rbp),%eax
   435e0:	48 63 f0             	movslq %eax,%rsi
   435e3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   435e7:	ba 00 00 00 00       	mov    $0x0,%edx
   435ec:	48 f7 f6             	div    %rsi
   435ef:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   435f3:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   435f8:	75 bc                	jne    435b6 <fill_numbuf+0x38>
    return numbuf_end;
   435fa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   435fe:	c9                   	leave  
   435ff:	c3                   	ret    

0000000000043600 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   43600:	55                   	push   %rbp
   43601:	48 89 e5             	mov    %rsp,%rbp
   43604:	53                   	push   %rbx
   43605:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   4360c:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   43613:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   43619:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43620:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   43627:	e9 8a 09 00 00       	jmp    43fb6 <printer_vprintf+0x9b6>
        if (*format != '%') {
   4362c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43633:	0f b6 00             	movzbl (%rax),%eax
   43636:	3c 25                	cmp    $0x25,%al
   43638:	74 31                	je     4366b <printer_vprintf+0x6b>
            p->putc(p, *format, color);
   4363a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43641:	4c 8b 00             	mov    (%rax),%r8
   43644:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4364b:	0f b6 00             	movzbl (%rax),%eax
   4364e:	0f b6 c8             	movzbl %al,%ecx
   43651:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43657:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4365e:	89 ce                	mov    %ecx,%esi
   43660:	48 89 c7             	mov    %rax,%rdi
   43663:	41 ff d0             	call   *%r8
            continue;
   43666:	e9 43 09 00 00       	jmp    43fae <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
   4366b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   43672:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43679:	01 
   4367a:	eb 44                	jmp    436c0 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
   4367c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43683:	0f b6 00             	movzbl (%rax),%eax
   43686:	0f be c0             	movsbl %al,%eax
   43689:	89 c6                	mov    %eax,%esi
   4368b:	bf e0 4d 04 00       	mov    $0x44de0,%edi
   43690:	e8 42 fe ff ff       	call   434d7 <strchr>
   43695:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   43699:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   4369e:	74 30                	je     436d0 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
   436a0:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   436a4:	48 2d e0 4d 04 00    	sub    $0x44de0,%rax
   436aa:	ba 01 00 00 00       	mov    $0x1,%edx
   436af:	89 c1                	mov    %eax,%ecx
   436b1:	d3 e2                	shl    %cl,%edx
   436b3:	89 d0                	mov    %edx,%eax
   436b5:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   436b8:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   436bf:	01 
   436c0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   436c7:	0f b6 00             	movzbl (%rax),%eax
   436ca:	84 c0                	test   %al,%al
   436cc:	75 ae                	jne    4367c <printer_vprintf+0x7c>
   436ce:	eb 01                	jmp    436d1 <printer_vprintf+0xd1>
            } else {
                break;
   436d0:	90                   	nop
            }
        }

        // process width
        int width = -1;
   436d1:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   436d8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   436df:	0f b6 00             	movzbl (%rax),%eax
   436e2:	3c 30                	cmp    $0x30,%al
   436e4:	7e 67                	jle    4374d <printer_vprintf+0x14d>
   436e6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   436ed:	0f b6 00             	movzbl (%rax),%eax
   436f0:	3c 39                	cmp    $0x39,%al
   436f2:	7f 59                	jg     4374d <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   436f4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   436fb:	eb 2e                	jmp    4372b <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
   436fd:	8b 55 e8             	mov    -0x18(%rbp),%edx
   43700:	89 d0                	mov    %edx,%eax
   43702:	c1 e0 02             	shl    $0x2,%eax
   43705:	01 d0                	add    %edx,%eax
   43707:	01 c0                	add    %eax,%eax
   43709:	89 c1                	mov    %eax,%ecx
   4370b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43712:	48 8d 50 01          	lea    0x1(%rax),%rdx
   43716:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   4371d:	0f b6 00             	movzbl (%rax),%eax
   43720:	0f be c0             	movsbl %al,%eax
   43723:	01 c8                	add    %ecx,%eax
   43725:	83 e8 30             	sub    $0x30,%eax
   43728:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   4372b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43732:	0f b6 00             	movzbl (%rax),%eax
   43735:	3c 2f                	cmp    $0x2f,%al
   43737:	0f 8e 85 00 00 00    	jle    437c2 <printer_vprintf+0x1c2>
   4373d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43744:	0f b6 00             	movzbl (%rax),%eax
   43747:	3c 39                	cmp    $0x39,%al
   43749:	7e b2                	jle    436fd <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
   4374b:	eb 75                	jmp    437c2 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
   4374d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43754:	0f b6 00             	movzbl (%rax),%eax
   43757:	3c 2a                	cmp    $0x2a,%al
   43759:	75 68                	jne    437c3 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
   4375b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43762:	8b 00                	mov    (%rax),%eax
   43764:	83 f8 2f             	cmp    $0x2f,%eax
   43767:	77 30                	ja     43799 <printer_vprintf+0x199>
   43769:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43770:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43774:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4377b:	8b 00                	mov    (%rax),%eax
   4377d:	89 c0                	mov    %eax,%eax
   4377f:	48 01 d0             	add    %rdx,%rax
   43782:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43789:	8b 12                	mov    (%rdx),%edx
   4378b:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4378e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43795:	89 0a                	mov    %ecx,(%rdx)
   43797:	eb 1a                	jmp    437b3 <printer_vprintf+0x1b3>
   43799:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   437a0:	48 8b 40 08          	mov    0x8(%rax),%rax
   437a4:	48 8d 48 08          	lea    0x8(%rax),%rcx
   437a8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   437af:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   437b3:	8b 00                	mov    (%rax),%eax
   437b5:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   437b8:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   437bf:	01 
   437c0:	eb 01                	jmp    437c3 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
   437c2:	90                   	nop
        }

        // process precision
        int precision = -1;
   437c3:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   437ca:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   437d1:	0f b6 00             	movzbl (%rax),%eax
   437d4:	3c 2e                	cmp    $0x2e,%al
   437d6:	0f 85 00 01 00 00    	jne    438dc <printer_vprintf+0x2dc>
            ++format;
   437dc:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   437e3:	01 
            if (*format >= '0' && *format <= '9') {
   437e4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   437eb:	0f b6 00             	movzbl (%rax),%eax
   437ee:	3c 2f                	cmp    $0x2f,%al
   437f0:	7e 67                	jle    43859 <printer_vprintf+0x259>
   437f2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   437f9:	0f b6 00             	movzbl (%rax),%eax
   437fc:	3c 39                	cmp    $0x39,%al
   437fe:	7f 59                	jg     43859 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43800:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   43807:	eb 2e                	jmp    43837 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
   43809:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   4380c:	89 d0                	mov    %edx,%eax
   4380e:	c1 e0 02             	shl    $0x2,%eax
   43811:	01 d0                	add    %edx,%eax
   43813:	01 c0                	add    %eax,%eax
   43815:	89 c1                	mov    %eax,%ecx
   43817:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4381e:	48 8d 50 01          	lea    0x1(%rax),%rdx
   43822:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43829:	0f b6 00             	movzbl (%rax),%eax
   4382c:	0f be c0             	movsbl %al,%eax
   4382f:	01 c8                	add    %ecx,%eax
   43831:	83 e8 30             	sub    $0x30,%eax
   43834:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43837:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4383e:	0f b6 00             	movzbl (%rax),%eax
   43841:	3c 2f                	cmp    $0x2f,%al
   43843:	0f 8e 85 00 00 00    	jle    438ce <printer_vprintf+0x2ce>
   43849:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43850:	0f b6 00             	movzbl (%rax),%eax
   43853:	3c 39                	cmp    $0x39,%al
   43855:	7e b2                	jle    43809 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
   43857:	eb 75                	jmp    438ce <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
   43859:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43860:	0f b6 00             	movzbl (%rax),%eax
   43863:	3c 2a                	cmp    $0x2a,%al
   43865:	75 68                	jne    438cf <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
   43867:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4386e:	8b 00                	mov    (%rax),%eax
   43870:	83 f8 2f             	cmp    $0x2f,%eax
   43873:	77 30                	ja     438a5 <printer_vprintf+0x2a5>
   43875:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4387c:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43880:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43887:	8b 00                	mov    (%rax),%eax
   43889:	89 c0                	mov    %eax,%eax
   4388b:	48 01 d0             	add    %rdx,%rax
   4388e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43895:	8b 12                	mov    (%rdx),%edx
   43897:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4389a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   438a1:	89 0a                	mov    %ecx,(%rdx)
   438a3:	eb 1a                	jmp    438bf <printer_vprintf+0x2bf>
   438a5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   438ac:	48 8b 40 08          	mov    0x8(%rax),%rax
   438b0:	48 8d 48 08          	lea    0x8(%rax),%rcx
   438b4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   438bb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   438bf:	8b 00                	mov    (%rax),%eax
   438c1:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   438c4:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   438cb:	01 
   438cc:	eb 01                	jmp    438cf <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
   438ce:	90                   	nop
            }
            if (precision < 0) {
   438cf:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   438d3:	79 07                	jns    438dc <printer_vprintf+0x2dc>
                precision = 0;
   438d5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   438dc:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   438e3:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   438ea:	00 
        int length = 0;
   438eb:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   438f2:	48 c7 45 c8 e6 4d 04 	movq   $0x44de6,-0x38(%rbp)
   438f9:	00 
    again:
        switch (*format) {
   438fa:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43901:	0f b6 00             	movzbl (%rax),%eax
   43904:	0f be c0             	movsbl %al,%eax
   43907:	83 e8 43             	sub    $0x43,%eax
   4390a:	83 f8 37             	cmp    $0x37,%eax
   4390d:	0f 87 9f 03 00 00    	ja     43cb2 <printer_vprintf+0x6b2>
   43913:	89 c0                	mov    %eax,%eax
   43915:	48 8b 04 c5 f8 4d 04 	mov    0x44df8(,%rax,8),%rax
   4391c:	00 
   4391d:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
   4391f:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   43926:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4392d:	01 
            goto again;
   4392e:	eb ca                	jmp    438fa <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   43930:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43934:	74 5d                	je     43993 <printer_vprintf+0x393>
   43936:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4393d:	8b 00                	mov    (%rax),%eax
   4393f:	83 f8 2f             	cmp    $0x2f,%eax
   43942:	77 30                	ja     43974 <printer_vprintf+0x374>
   43944:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4394b:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4394f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43956:	8b 00                	mov    (%rax),%eax
   43958:	89 c0                	mov    %eax,%eax
   4395a:	48 01 d0             	add    %rdx,%rax
   4395d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43964:	8b 12                	mov    (%rdx),%edx
   43966:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43969:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43970:	89 0a                	mov    %ecx,(%rdx)
   43972:	eb 1a                	jmp    4398e <printer_vprintf+0x38e>
   43974:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4397b:	48 8b 40 08          	mov    0x8(%rax),%rax
   4397f:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43983:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4398a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4398e:	48 8b 00             	mov    (%rax),%rax
   43991:	eb 5c                	jmp    439ef <printer_vprintf+0x3ef>
   43993:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4399a:	8b 00                	mov    (%rax),%eax
   4399c:	83 f8 2f             	cmp    $0x2f,%eax
   4399f:	77 30                	ja     439d1 <printer_vprintf+0x3d1>
   439a1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   439a8:	48 8b 50 10          	mov    0x10(%rax),%rdx
   439ac:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   439b3:	8b 00                	mov    (%rax),%eax
   439b5:	89 c0                	mov    %eax,%eax
   439b7:	48 01 d0             	add    %rdx,%rax
   439ba:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   439c1:	8b 12                	mov    (%rdx),%edx
   439c3:	8d 4a 08             	lea    0x8(%rdx),%ecx
   439c6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   439cd:	89 0a                	mov    %ecx,(%rdx)
   439cf:	eb 1a                	jmp    439eb <printer_vprintf+0x3eb>
   439d1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   439d8:	48 8b 40 08          	mov    0x8(%rax),%rax
   439dc:	48 8d 48 08          	lea    0x8(%rax),%rcx
   439e0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   439e7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   439eb:	8b 00                	mov    (%rax),%eax
   439ed:	48 98                	cltq   
   439ef:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   439f3:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   439f7:	48 c1 f8 38          	sar    $0x38,%rax
   439fb:	25 80 00 00 00       	and    $0x80,%eax
   43a00:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   43a03:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   43a07:	74 09                	je     43a12 <printer_vprintf+0x412>
   43a09:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43a0d:	48 f7 d8             	neg    %rax
   43a10:	eb 04                	jmp    43a16 <printer_vprintf+0x416>
   43a12:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43a16:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   43a1a:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   43a1d:	83 c8 60             	or     $0x60,%eax
   43a20:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   43a23:	e9 cf 02 00 00       	jmp    43cf7 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   43a28:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43a2c:	74 5d                	je     43a8b <printer_vprintf+0x48b>
   43a2e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a35:	8b 00                	mov    (%rax),%eax
   43a37:	83 f8 2f             	cmp    $0x2f,%eax
   43a3a:	77 30                	ja     43a6c <printer_vprintf+0x46c>
   43a3c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a43:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43a47:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a4e:	8b 00                	mov    (%rax),%eax
   43a50:	89 c0                	mov    %eax,%eax
   43a52:	48 01 d0             	add    %rdx,%rax
   43a55:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43a5c:	8b 12                	mov    (%rdx),%edx
   43a5e:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43a61:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43a68:	89 0a                	mov    %ecx,(%rdx)
   43a6a:	eb 1a                	jmp    43a86 <printer_vprintf+0x486>
   43a6c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a73:	48 8b 40 08          	mov    0x8(%rax),%rax
   43a77:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43a7b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43a82:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43a86:	48 8b 00             	mov    (%rax),%rax
   43a89:	eb 5c                	jmp    43ae7 <printer_vprintf+0x4e7>
   43a8b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a92:	8b 00                	mov    (%rax),%eax
   43a94:	83 f8 2f             	cmp    $0x2f,%eax
   43a97:	77 30                	ja     43ac9 <printer_vprintf+0x4c9>
   43a99:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43aa0:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43aa4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43aab:	8b 00                	mov    (%rax),%eax
   43aad:	89 c0                	mov    %eax,%eax
   43aaf:	48 01 d0             	add    %rdx,%rax
   43ab2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43ab9:	8b 12                	mov    (%rdx),%edx
   43abb:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43abe:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43ac5:	89 0a                	mov    %ecx,(%rdx)
   43ac7:	eb 1a                	jmp    43ae3 <printer_vprintf+0x4e3>
   43ac9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ad0:	48 8b 40 08          	mov    0x8(%rax),%rax
   43ad4:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43ad8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43adf:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43ae3:	8b 00                	mov    (%rax),%eax
   43ae5:	89 c0                	mov    %eax,%eax
   43ae7:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   43aeb:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   43aef:	e9 03 02 00 00       	jmp    43cf7 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
   43af4:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   43afb:	e9 28 ff ff ff       	jmp    43a28 <printer_vprintf+0x428>
        case 'X':
            base = 16;
   43b00:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   43b07:	e9 1c ff ff ff       	jmp    43a28 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   43b0c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b13:	8b 00                	mov    (%rax),%eax
   43b15:	83 f8 2f             	cmp    $0x2f,%eax
   43b18:	77 30                	ja     43b4a <printer_vprintf+0x54a>
   43b1a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b21:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43b25:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b2c:	8b 00                	mov    (%rax),%eax
   43b2e:	89 c0                	mov    %eax,%eax
   43b30:	48 01 d0             	add    %rdx,%rax
   43b33:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43b3a:	8b 12                	mov    (%rdx),%edx
   43b3c:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43b3f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43b46:	89 0a                	mov    %ecx,(%rdx)
   43b48:	eb 1a                	jmp    43b64 <printer_vprintf+0x564>
   43b4a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b51:	48 8b 40 08          	mov    0x8(%rax),%rax
   43b55:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43b59:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43b60:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43b64:	48 8b 00             	mov    (%rax),%rax
   43b67:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   43b6b:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   43b72:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   43b79:	e9 79 01 00 00       	jmp    43cf7 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
   43b7e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b85:	8b 00                	mov    (%rax),%eax
   43b87:	83 f8 2f             	cmp    $0x2f,%eax
   43b8a:	77 30                	ja     43bbc <printer_vprintf+0x5bc>
   43b8c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b93:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43b97:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b9e:	8b 00                	mov    (%rax),%eax
   43ba0:	89 c0                	mov    %eax,%eax
   43ba2:	48 01 d0             	add    %rdx,%rax
   43ba5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43bac:	8b 12                	mov    (%rdx),%edx
   43bae:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43bb1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43bb8:	89 0a                	mov    %ecx,(%rdx)
   43bba:	eb 1a                	jmp    43bd6 <printer_vprintf+0x5d6>
   43bbc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43bc3:	48 8b 40 08          	mov    0x8(%rax),%rax
   43bc7:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43bcb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43bd2:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43bd6:	48 8b 00             	mov    (%rax),%rax
   43bd9:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   43bdd:	e9 15 01 00 00       	jmp    43cf7 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
   43be2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43be9:	8b 00                	mov    (%rax),%eax
   43beb:	83 f8 2f             	cmp    $0x2f,%eax
   43bee:	77 30                	ja     43c20 <printer_vprintf+0x620>
   43bf0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43bf7:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43bfb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c02:	8b 00                	mov    (%rax),%eax
   43c04:	89 c0                	mov    %eax,%eax
   43c06:	48 01 d0             	add    %rdx,%rax
   43c09:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c10:	8b 12                	mov    (%rdx),%edx
   43c12:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43c15:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c1c:	89 0a                	mov    %ecx,(%rdx)
   43c1e:	eb 1a                	jmp    43c3a <printer_vprintf+0x63a>
   43c20:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c27:	48 8b 40 08          	mov    0x8(%rax),%rax
   43c2b:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43c2f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c36:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43c3a:	8b 00                	mov    (%rax),%eax
   43c3c:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   43c42:	e9 67 03 00 00       	jmp    43fae <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
   43c47:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43c4b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   43c4f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c56:	8b 00                	mov    (%rax),%eax
   43c58:	83 f8 2f             	cmp    $0x2f,%eax
   43c5b:	77 30                	ja     43c8d <printer_vprintf+0x68d>
   43c5d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c64:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43c68:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c6f:	8b 00                	mov    (%rax),%eax
   43c71:	89 c0                	mov    %eax,%eax
   43c73:	48 01 d0             	add    %rdx,%rax
   43c76:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c7d:	8b 12                	mov    (%rdx),%edx
   43c7f:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43c82:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c89:	89 0a                	mov    %ecx,(%rdx)
   43c8b:	eb 1a                	jmp    43ca7 <printer_vprintf+0x6a7>
   43c8d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c94:	48 8b 40 08          	mov    0x8(%rax),%rax
   43c98:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43c9c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43ca3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43ca7:	8b 00                	mov    (%rax),%eax
   43ca9:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   43cac:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   43cb0:	eb 45                	jmp    43cf7 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
   43cb2:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43cb6:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   43cba:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43cc1:	0f b6 00             	movzbl (%rax),%eax
   43cc4:	84 c0                	test   %al,%al
   43cc6:	74 0c                	je     43cd4 <printer_vprintf+0x6d4>
   43cc8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43ccf:	0f b6 00             	movzbl (%rax),%eax
   43cd2:	eb 05                	jmp    43cd9 <printer_vprintf+0x6d9>
   43cd4:	b8 25 00 00 00       	mov    $0x25,%eax
   43cd9:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   43cdc:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   43ce0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43ce7:	0f b6 00             	movzbl (%rax),%eax
   43cea:	84 c0                	test   %al,%al
   43cec:	75 08                	jne    43cf6 <printer_vprintf+0x6f6>
                format--;
   43cee:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   43cf5:	01 
            }
            break;
   43cf6:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   43cf7:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43cfa:	83 e0 20             	and    $0x20,%eax
   43cfd:	85 c0                	test   %eax,%eax
   43cff:	74 1e                	je     43d1f <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   43d01:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43d05:	48 83 c0 18          	add    $0x18,%rax
   43d09:	8b 55 e0             	mov    -0x20(%rbp),%edx
   43d0c:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   43d10:	48 89 ce             	mov    %rcx,%rsi
   43d13:	48 89 c7             	mov    %rax,%rdi
   43d16:	e8 63 f8 ff ff       	call   4357e <fill_numbuf>
   43d1b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   43d1f:	48 c7 45 c0 e6 4d 04 	movq   $0x44de6,-0x40(%rbp)
   43d26:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   43d27:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43d2a:	83 e0 20             	and    $0x20,%eax
   43d2d:	85 c0                	test   %eax,%eax
   43d2f:	74 48                	je     43d79 <printer_vprintf+0x779>
   43d31:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43d34:	83 e0 40             	and    $0x40,%eax
   43d37:	85 c0                	test   %eax,%eax
   43d39:	74 3e                	je     43d79 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
   43d3b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43d3e:	25 80 00 00 00       	and    $0x80,%eax
   43d43:	85 c0                	test   %eax,%eax
   43d45:	74 0a                	je     43d51 <printer_vprintf+0x751>
                prefix = "-";
   43d47:	48 c7 45 c0 e7 4d 04 	movq   $0x44de7,-0x40(%rbp)
   43d4e:	00 
            if (flags & FLAG_NEGATIVE) {
   43d4f:	eb 73                	jmp    43dc4 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   43d51:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43d54:	83 e0 10             	and    $0x10,%eax
   43d57:	85 c0                	test   %eax,%eax
   43d59:	74 0a                	je     43d65 <printer_vprintf+0x765>
                prefix = "+";
   43d5b:	48 c7 45 c0 e9 4d 04 	movq   $0x44de9,-0x40(%rbp)
   43d62:	00 
            if (flags & FLAG_NEGATIVE) {
   43d63:	eb 5f                	jmp    43dc4 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   43d65:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43d68:	83 e0 08             	and    $0x8,%eax
   43d6b:	85 c0                	test   %eax,%eax
   43d6d:	74 55                	je     43dc4 <printer_vprintf+0x7c4>
                prefix = " ";
   43d6f:	48 c7 45 c0 eb 4d 04 	movq   $0x44deb,-0x40(%rbp)
   43d76:	00 
            if (flags & FLAG_NEGATIVE) {
   43d77:	eb 4b                	jmp    43dc4 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   43d79:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43d7c:	83 e0 20             	and    $0x20,%eax
   43d7f:	85 c0                	test   %eax,%eax
   43d81:	74 42                	je     43dc5 <printer_vprintf+0x7c5>
   43d83:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43d86:	83 e0 01             	and    $0x1,%eax
   43d89:	85 c0                	test   %eax,%eax
   43d8b:	74 38                	je     43dc5 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
   43d8d:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   43d91:	74 06                	je     43d99 <printer_vprintf+0x799>
   43d93:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   43d97:	75 2c                	jne    43dc5 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
   43d99:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43d9e:	75 0c                	jne    43dac <printer_vprintf+0x7ac>
   43da0:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43da3:	25 00 01 00 00       	and    $0x100,%eax
   43da8:	85 c0                	test   %eax,%eax
   43daa:	74 19                	je     43dc5 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
   43dac:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   43db0:	75 07                	jne    43db9 <printer_vprintf+0x7b9>
   43db2:	b8 ed 4d 04 00       	mov    $0x44ded,%eax
   43db7:	eb 05                	jmp    43dbe <printer_vprintf+0x7be>
   43db9:	b8 f0 4d 04 00       	mov    $0x44df0,%eax
   43dbe:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   43dc2:	eb 01                	jmp    43dc5 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
   43dc4:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   43dc5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   43dc9:	78 24                	js     43def <printer_vprintf+0x7ef>
   43dcb:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43dce:	83 e0 20             	and    $0x20,%eax
   43dd1:	85 c0                	test   %eax,%eax
   43dd3:	75 1a                	jne    43def <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
   43dd5:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43dd8:	48 63 d0             	movslq %eax,%rdx
   43ddb:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43ddf:	48 89 d6             	mov    %rdx,%rsi
   43de2:	48 89 c7             	mov    %rax,%rdi
   43de5:	e8 ea f5 ff ff       	call   433d4 <strnlen>
   43dea:	89 45 bc             	mov    %eax,-0x44(%rbp)
   43ded:	eb 0f                	jmp    43dfe <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
   43def:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43df3:	48 89 c7             	mov    %rax,%rdi
   43df6:	e8 a8 f5 ff ff       	call   433a3 <strlen>
   43dfb:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   43dfe:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43e01:	83 e0 20             	and    $0x20,%eax
   43e04:	85 c0                	test   %eax,%eax
   43e06:	74 20                	je     43e28 <printer_vprintf+0x828>
   43e08:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   43e0c:	78 1a                	js     43e28 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
   43e0e:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43e11:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   43e14:	7e 08                	jle    43e1e <printer_vprintf+0x81e>
   43e16:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43e19:	2b 45 bc             	sub    -0x44(%rbp),%eax
   43e1c:	eb 05                	jmp    43e23 <printer_vprintf+0x823>
   43e1e:	b8 00 00 00 00       	mov    $0x0,%eax
   43e23:	89 45 b8             	mov    %eax,-0x48(%rbp)
   43e26:	eb 5c                	jmp    43e84 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   43e28:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43e2b:	83 e0 20             	and    $0x20,%eax
   43e2e:	85 c0                	test   %eax,%eax
   43e30:	74 4b                	je     43e7d <printer_vprintf+0x87d>
   43e32:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43e35:	83 e0 02             	and    $0x2,%eax
   43e38:	85 c0                	test   %eax,%eax
   43e3a:	74 41                	je     43e7d <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
   43e3c:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43e3f:	83 e0 04             	and    $0x4,%eax
   43e42:	85 c0                	test   %eax,%eax
   43e44:	75 37                	jne    43e7d <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
   43e46:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43e4a:	48 89 c7             	mov    %rax,%rdi
   43e4d:	e8 51 f5 ff ff       	call   433a3 <strlen>
   43e52:	89 c2                	mov    %eax,%edx
   43e54:	8b 45 bc             	mov    -0x44(%rbp),%eax
   43e57:	01 d0                	add    %edx,%eax
   43e59:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   43e5c:	7e 1f                	jle    43e7d <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
   43e5e:	8b 45 e8             	mov    -0x18(%rbp),%eax
   43e61:	2b 45 bc             	sub    -0x44(%rbp),%eax
   43e64:	89 c3                	mov    %eax,%ebx
   43e66:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43e6a:	48 89 c7             	mov    %rax,%rdi
   43e6d:	e8 31 f5 ff ff       	call   433a3 <strlen>
   43e72:	89 c2                	mov    %eax,%edx
   43e74:	89 d8                	mov    %ebx,%eax
   43e76:	29 d0                	sub    %edx,%eax
   43e78:	89 45 b8             	mov    %eax,-0x48(%rbp)
   43e7b:	eb 07                	jmp    43e84 <printer_vprintf+0x884>
        } else {
            zeros = 0;
   43e7d:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   43e84:	8b 55 bc             	mov    -0x44(%rbp),%edx
   43e87:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43e8a:	01 d0                	add    %edx,%eax
   43e8c:	48 63 d8             	movslq %eax,%rbx
   43e8f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43e93:	48 89 c7             	mov    %rax,%rdi
   43e96:	e8 08 f5 ff ff       	call   433a3 <strlen>
   43e9b:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   43e9f:	8b 45 e8             	mov    -0x18(%rbp),%eax
   43ea2:	29 d0                	sub    %edx,%eax
   43ea4:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   43ea7:	eb 25                	jmp    43ece <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
   43ea9:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43eb0:	48 8b 08             	mov    (%rax),%rcx
   43eb3:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43eb9:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43ec0:	be 20 00 00 00       	mov    $0x20,%esi
   43ec5:	48 89 c7             	mov    %rax,%rdi
   43ec8:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   43eca:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   43ece:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43ed1:	83 e0 04             	and    $0x4,%eax
   43ed4:	85 c0                	test   %eax,%eax
   43ed6:	75 36                	jne    43f0e <printer_vprintf+0x90e>
   43ed8:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   43edc:	7f cb                	jg     43ea9 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
   43ede:	eb 2e                	jmp    43f0e <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
   43ee0:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43ee7:	4c 8b 00             	mov    (%rax),%r8
   43eea:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43eee:	0f b6 00             	movzbl (%rax),%eax
   43ef1:	0f b6 c8             	movzbl %al,%ecx
   43ef4:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43efa:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43f01:	89 ce                	mov    %ecx,%esi
   43f03:	48 89 c7             	mov    %rax,%rdi
   43f06:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   43f09:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   43f0e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43f12:	0f b6 00             	movzbl (%rax),%eax
   43f15:	84 c0                	test   %al,%al
   43f17:	75 c7                	jne    43ee0 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
   43f19:	eb 25                	jmp    43f40 <printer_vprintf+0x940>
            p->putc(p, '0', color);
   43f1b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43f22:	48 8b 08             	mov    (%rax),%rcx
   43f25:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43f2b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43f32:	be 30 00 00 00       	mov    $0x30,%esi
   43f37:	48 89 c7             	mov    %rax,%rdi
   43f3a:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   43f3c:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   43f40:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   43f44:	7f d5                	jg     43f1b <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
   43f46:	eb 32                	jmp    43f7a <printer_vprintf+0x97a>
            p->putc(p, *data, color);
   43f48:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43f4f:	4c 8b 00             	mov    (%rax),%r8
   43f52:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43f56:	0f b6 00             	movzbl (%rax),%eax
   43f59:	0f b6 c8             	movzbl %al,%ecx
   43f5c:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43f62:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43f69:	89 ce                	mov    %ecx,%esi
   43f6b:	48 89 c7             	mov    %rax,%rdi
   43f6e:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   43f71:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   43f76:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   43f7a:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   43f7e:	7f c8                	jg     43f48 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
   43f80:	eb 25                	jmp    43fa7 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
   43f82:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43f89:	48 8b 08             	mov    (%rax),%rcx
   43f8c:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43f92:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43f99:	be 20 00 00 00       	mov    $0x20,%esi
   43f9e:	48 89 c7             	mov    %rax,%rdi
   43fa1:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   43fa3:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   43fa7:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   43fab:	7f d5                	jg     43f82 <printer_vprintf+0x982>
        }
    done: ;
   43fad:	90                   	nop
    for (; *format; ++format) {
   43fae:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43fb5:	01 
   43fb6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43fbd:	0f b6 00             	movzbl (%rax),%eax
   43fc0:	84 c0                	test   %al,%al
   43fc2:	0f 85 64 f6 ff ff    	jne    4362c <printer_vprintf+0x2c>
    }
}
   43fc8:	90                   	nop
   43fc9:	90                   	nop
   43fca:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   43fce:	c9                   	leave  
   43fcf:	c3                   	ret    

0000000000043fd0 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   43fd0:	55                   	push   %rbp
   43fd1:	48 89 e5             	mov    %rsp,%rbp
   43fd4:	48 83 ec 20          	sub    $0x20,%rsp
   43fd8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43fdc:	89 f0                	mov    %esi,%eax
   43fde:	89 55 e0             	mov    %edx,-0x20(%rbp)
   43fe1:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   43fe4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43fe8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   43fec:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43ff0:	48 8b 40 08          	mov    0x8(%rax),%rax
   43ff4:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
   43ff9:	48 39 d0             	cmp    %rdx,%rax
   43ffc:	72 0c                	jb     4400a <console_putc+0x3a>
        cp->cursor = console;
   43ffe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44002:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
   44009:	00 
    }
    if (c == '\n') {
   4400a:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   4400e:	75 78                	jne    44088 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
   44010:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44014:	48 8b 40 08          	mov    0x8(%rax),%rax
   44018:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   4401e:	48 d1 f8             	sar    %rax
   44021:	48 89 c1             	mov    %rax,%rcx
   44024:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   4402b:	66 66 66 
   4402e:	48 89 c8             	mov    %rcx,%rax
   44031:	48 f7 ea             	imul   %rdx
   44034:	48 c1 fa 05          	sar    $0x5,%rdx
   44038:	48 89 c8             	mov    %rcx,%rax
   4403b:	48 c1 f8 3f          	sar    $0x3f,%rax
   4403f:	48 29 c2             	sub    %rax,%rdx
   44042:	48 89 d0             	mov    %rdx,%rax
   44045:	48 c1 e0 02          	shl    $0x2,%rax
   44049:	48 01 d0             	add    %rdx,%rax
   4404c:	48 c1 e0 04          	shl    $0x4,%rax
   44050:	48 29 c1             	sub    %rax,%rcx
   44053:	48 89 ca             	mov    %rcx,%rdx
   44056:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   44059:	eb 25                	jmp    44080 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
   4405b:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4405e:	83 c8 20             	or     $0x20,%eax
   44061:	89 c6                	mov    %eax,%esi
   44063:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44067:	48 8b 40 08          	mov    0x8(%rax),%rax
   4406b:	48 8d 48 02          	lea    0x2(%rax),%rcx
   4406f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   44073:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44077:	89 f2                	mov    %esi,%edx
   44079:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   4407c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44080:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   44084:	75 d5                	jne    4405b <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   44086:	eb 24                	jmp    440ac <console_putc+0xdc>
        *cp->cursor++ = c | color;
   44088:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
   4408c:	8b 55 e0             	mov    -0x20(%rbp),%edx
   4408f:	09 d0                	or     %edx,%eax
   44091:	89 c6                	mov    %eax,%esi
   44093:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44097:	48 8b 40 08          	mov    0x8(%rax),%rax
   4409b:	48 8d 48 02          	lea    0x2(%rax),%rcx
   4409f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   440a3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   440a7:	89 f2                	mov    %esi,%edx
   440a9:	66 89 10             	mov    %dx,(%rax)
}
   440ac:	90                   	nop
   440ad:	c9                   	leave  
   440ae:	c3                   	ret    

00000000000440af <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   440af:	55                   	push   %rbp
   440b0:	48 89 e5             	mov    %rsp,%rbp
   440b3:	48 83 ec 30          	sub    $0x30,%rsp
   440b7:	89 7d ec             	mov    %edi,-0x14(%rbp)
   440ba:	89 75 e8             	mov    %esi,-0x18(%rbp)
   440bd:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   440c1:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   440c5:	48 c7 45 f0 d0 3f 04 	movq   $0x43fd0,-0x10(%rbp)
   440cc:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   440cd:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   440d1:	78 09                	js     440dc <console_vprintf+0x2d>
   440d3:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   440da:	7e 07                	jle    440e3 <console_vprintf+0x34>
        cpos = 0;
   440dc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   440e3:	8b 45 ec             	mov    -0x14(%rbp),%eax
   440e6:	48 98                	cltq   
   440e8:	48 01 c0             	add    %rax,%rax
   440eb:	48 05 00 80 0b 00    	add    $0xb8000,%rax
   440f1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   440f5:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   440f9:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   440fd:	8b 75 e8             	mov    -0x18(%rbp),%esi
   44100:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   44104:	48 89 c7             	mov    %rax,%rdi
   44107:	e8 f4 f4 ff ff       	call   43600 <printer_vprintf>
    return cp.cursor - console;
   4410c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44110:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   44116:	48 d1 f8             	sar    %rax
}
   44119:	c9                   	leave  
   4411a:	c3                   	ret    

000000000004411b <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   4411b:	55                   	push   %rbp
   4411c:	48 89 e5             	mov    %rsp,%rbp
   4411f:	48 83 ec 60          	sub    $0x60,%rsp
   44123:	89 7d ac             	mov    %edi,-0x54(%rbp)
   44126:	89 75 a8             	mov    %esi,-0x58(%rbp)
   44129:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   4412d:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44131:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44135:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44139:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   44140:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44144:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   44148:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4414c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   44150:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   44154:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   44158:	8b 75 a8             	mov    -0x58(%rbp),%esi
   4415b:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4415e:	89 c7                	mov    %eax,%edi
   44160:	e8 4a ff ff ff       	call   440af <console_vprintf>
   44165:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   44168:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   4416b:	c9                   	leave  
   4416c:	c3                   	ret    

000000000004416d <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   4416d:	55                   	push   %rbp
   4416e:	48 89 e5             	mov    %rsp,%rbp
   44171:	48 83 ec 20          	sub    $0x20,%rsp
   44175:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44179:	89 f0                	mov    %esi,%eax
   4417b:	89 55 e0             	mov    %edx,-0x20(%rbp)
   4417e:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   44181:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44185:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   44189:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4418d:	48 8b 50 08          	mov    0x8(%rax),%rdx
   44191:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44195:	48 8b 40 10          	mov    0x10(%rax),%rax
   44199:	48 39 c2             	cmp    %rax,%rdx
   4419c:	73 1a                	jae    441b8 <string_putc+0x4b>
        *sp->s++ = c;
   4419e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   441a2:	48 8b 40 08          	mov    0x8(%rax),%rax
   441a6:	48 8d 48 01          	lea    0x1(%rax),%rcx
   441aa:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   441ae:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   441b2:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   441b6:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   441b8:	90                   	nop
   441b9:	c9                   	leave  
   441ba:	c3                   	ret    

00000000000441bb <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   441bb:	55                   	push   %rbp
   441bc:	48 89 e5             	mov    %rsp,%rbp
   441bf:	48 83 ec 40          	sub    $0x40,%rsp
   441c3:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   441c7:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   441cb:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   441cf:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   441d3:	48 c7 45 e8 6d 41 04 	movq   $0x4416d,-0x18(%rbp)
   441da:	00 
    sp.s = s;
   441db:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   441df:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   441e3:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   441e8:	74 33                	je     4421d <vsnprintf+0x62>
        sp.end = s + size - 1;
   441ea:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   441ee:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   441f2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   441f6:	48 01 d0             	add    %rdx,%rax
   441f9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   441fd:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   44201:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   44205:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   44209:	be 00 00 00 00       	mov    $0x0,%esi
   4420e:	48 89 c7             	mov    %rax,%rdi
   44211:	e8 ea f3 ff ff       	call   43600 <printer_vprintf>
        *sp.s = 0;
   44216:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4421a:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   4421d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44221:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   44225:	c9                   	leave  
   44226:	c3                   	ret    

0000000000044227 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   44227:	55                   	push   %rbp
   44228:	48 89 e5             	mov    %rsp,%rbp
   4422b:	48 83 ec 70          	sub    $0x70,%rsp
   4422f:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   44233:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   44237:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   4423b:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4423f:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44243:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44247:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   4424e:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44252:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   44256:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4425a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   4425e:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   44262:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   44266:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   4426a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4426e:	48 89 c7             	mov    %rax,%rdi
   44271:	e8 45 ff ff ff       	call   441bb <vsnprintf>
   44276:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   44279:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   4427c:	c9                   	leave  
   4427d:	c3                   	ret    

000000000004427e <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   4427e:	55                   	push   %rbp
   4427f:	48 89 e5             	mov    %rsp,%rbp
   44282:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44286:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4428d:	eb 13                	jmp    442a2 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
   4428f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   44292:	48 98                	cltq   
   44294:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
   4429b:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   4429e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   442a2:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   442a9:	7e e4                	jle    4428f <console_clear+0x11>
    }
    cursorpos = 0;
   442ab:	c7 05 47 4d 07 00 00 	movl   $0x0,0x74d47(%rip)        # b8ffc <cursorpos>
   442b2:	00 00 00 
}
   442b5:	90                   	nop
   442b6:	c9                   	leave  
   442b7:	c3                   	ret    
