
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
   400be:	e8 f2 09 00 00       	call   40ab5 <exception>

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
   40173:	e8 a3 19 00 00       	call   41b1b <hardware_init>
    pageinfo_init();
   40178:	e8 b4 0f 00 00       	call   41131 <pageinfo_init>
    console_clear();
   4017d:	e8 d9 43 00 00       	call   4455b <console_clear>
    timer_init(HZ);
   40182:	bf 64 00 00 00       	mov    $0x64,%edi
   40187:	e8 7b 1e 00 00       	call   42007 <timer_init>

    // use virtual_memory_map to remove user permissions for kernel memory
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   4018c:	48 8b 05 6d 4e 01 00 	mov    0x14e6d(%rip),%rax        # 55000 <kernel_pagetable>
   40193:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   40199:	b9 00 00 10 00       	mov    $0x100000,%ecx
   4019e:	ba 00 00 00 00       	mov    $0x0,%edx
   401a3:	be 00 00 00 00       	mov    $0x0,%esi
   401a8:	48 89 c7             	mov    %rax,%rdi
   401ab:	e8 b5 2b 00 00       	call   42d65 <virtual_memory_map>
					   PROC_START_ADDR, PTE_P | PTE_W);
   
    // return user permissions to console
    virtual_memory_map(kernel_pagetable, (uintptr_t) CONSOLE_ADDR, (uintptr_t) CONSOLE_ADDR,
   401b0:	ba 00 80 0b 00       	mov    $0xb8000,%edx
   401b5:	be 00 80 0b 00       	mov    $0xb8000,%esi
   401ba:	48 8b 05 3f 4e 01 00 	mov    0x14e3f(%rip),%rax        # 55000 <kernel_pagetable>
   401c1:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   401c7:	b9 00 10 00 00       	mov    $0x1000,%ecx
   401cc:	48 89 c7             	mov    %rax,%rdi
   401cf:	e8 91 2b 00 00       	call   42d65 <virtual_memory_map>
	// to all memory before the start of ANY processes. This means that 
	// the assign_page function is never capable of assigning this memory
	// to a process.

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   401d4:	ba 00 0e 00 00       	mov    $0xe00,%edx
   401d9:	be 00 00 00 00       	mov    $0x0,%esi
   401de:	bf 20 20 05 00       	mov    $0x52020,%edi
   401e3:	e8 59 34 00 00       	call   43641 <memset>
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
   40246:	be a0 45 04 00       	mov    $0x445a0,%esi
   4024b:	48 89 c7             	mov    %rax,%rdi
   4024e:	e8 e7 34 00 00       	call   4373a <strcmp>
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
   40276:	be a5 45 04 00       	mov    $0x445a5,%esi
   4027b:	48 89 c7             	mov    %rax,%rdi
   4027e:	e8 b7 34 00 00       	call   4373a <strcmp>
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
   402a6:	be ae 45 04 00       	mov    $0x445ae,%esi
   402ab:	48 89 c7             	mov    %rax,%rdi
   402ae:	e8 87 34 00 00       	call   4373a <strcmp>
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
   402d3:	be b3 45 04 00       	mov    $0x445b3,%esi
   402d8:	48 89 c7             	mov    %rax,%rdi
   402db:	e8 5a 34 00 00       	call   4373a <strcmp>
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
   40332:	e8 9d 0d 00 00       	call   410d4 <run>

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
   4044d:	e8 ef 31 00 00       	call   43641 <memset>
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
   404b8:	e8 86 30 00 00       	call   43543 <memcpy>
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
   40518:	e8 7b 1d 00 00       	call   42298 <process_init>
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
   4054f:	e8 ce 2c 00 00       	call   43222 <program_load>
   40554:	89 45 fc             	mov    %eax,-0x4(%rbp)
    assert(r >= 0);
   40557:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4055b:	79 14                	jns    40571 <process_setup+0x89>
   4055d:	ba b9 45 04 00       	mov    $0x445b9,%edx
   40562:	be d7 00 00 00       	mov    $0xd7,%esi
   40567:	bf c0 45 04 00       	mov    $0x445c0,%edi
   4056c:	e8 f5 24 00 00       	call   42a66 <assert_fail>

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
   4060f:	e8 51 27 00 00       	call   42d65 <virtual_memory_map>
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
   406e8:	e8 3e 2a 00 00       	call   4312b <virtual_memory_lookup>

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
   40720:	e8 06 2a 00 00       	call   4312b <virtual_memory_lookup>
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
   4074c:	e8 da 29 00 00       	call   4312b <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   40751:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40755:	48 89 c1             	mov    %rax,%rcx
   40758:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   4075c:	ba 18 00 00 00       	mov    $0x18,%edx
   40761:	48 89 c6             	mov    %rax,%rsi
   40764:	48 89 cf             	mov    %rcx,%rdi
   40767:	e8 d7 2d 00 00       	call   43543 <memcpy>
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
   4085a:	e8 cc 28 00 00       	call   4312b <virtual_memory_lookup>
		
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
   408cd:	e8 93 24 00 00       	call   42d65 <virtual_memory_map>
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
   40920:	e8 40 24 00 00       	call   42d65 <virtual_memory_map>
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
   40946:	e8 f8 2b 00 00       	call   43543 <memcpy>
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
	int c = 0;
   40977:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
	for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   4097e:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
   40985:	00 
   40986:	eb 67                	jmp    409ef <free_pagetable_pages+0x84>
		if (pageinfo[PAGENUMBER(addr)].owner == p->p_pid) {
   40988:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4098c:	48 c1 e8 0c          	shr    $0xc,%rax
   40990:	48 98                	cltq   
   40992:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   40999:	00 
   4099a:	0f be d0             	movsbl %al,%edx
   4099d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   409a1:	8b 00                	mov    (%rax),%eax
   409a3:	39 c2                	cmp    %eax,%edx
   409a5:	75 40                	jne    409e7 <free_pagetable_pages+0x7c>
			pageinfo[PAGENUMBER(addr)].owner = PO_FREE;
   409a7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   409ab:	48 c1 e8 0c          	shr    $0xc,%rax
   409af:	48 98                	cltq   
   409b1:	c6 84 00 40 2e 05 00 	movb   $0x0,0x52e40(%rax,%rax,1)
   409b8:	00 
			--pageinfo[PAGENUMBER(addr)].refcount;
   409b9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   409bd:	48 c1 e8 0c          	shr    $0xc,%rax
   409c1:	89 c2                	mov    %eax,%edx
   409c3:	48 63 c2             	movslq %edx,%rax
   409c6:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   409cd:	00 
   409ce:	83 e8 01             	sub    $0x1,%eax
   409d1:	89 c1                	mov    %eax,%ecx
   409d3:	48 63 c2             	movslq %edx,%rax
   409d6:	88 8c 00 41 2e 05 00 	mov    %cl,0x52e41(%rax,%rax,1)
			c++;
   409dd:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
			if (c == 5)
   409e1:	83 7d fc 05          	cmpl   $0x5,-0x4(%rbp)
   409e5:	74 14                	je     409fb <free_pagetable_pages+0x90>
	for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   409e7:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   409ee:	00 
   409ef:	48 81 7d f0 ff ff 1f 	cmpq   $0x1fffff,-0x10(%rbp)
   409f6:	00 
   409f7:	76 8f                	jbe    40988 <free_pagetable_pages+0x1d>
   409f9:	eb 01                	jmp    409fc <free_pagetable_pages+0x91>
				return;
   409fb:	90                   	nop
		}
	}
}
   409fc:	c9                   	leave  
   409fd:	c3                   	ret    

00000000000409fe <free_pages_va>:

// free_process_pages(pid_t pid)
//		frees physical pages allocated to the process with pid

void free_pages_va(proc *p) {
   409fe:	55                   	push   %rbp
   409ff:	48 89 e5             	mov    %rsp,%rbp
   40a02:	48 83 ec 30          	sub    $0x30,%rsp
   40a06:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
	for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   40a0a:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   40a11:	00 
   40a12:	e9 8c 00 00 00       	jmp    40aa3 <free_pages_va+0xa5>
		vamapping map = virtual_memory_lookup(p->p_pagetable, va); // examining addr page by page
   40a17:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40a1b:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40a22:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   40a26:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40a2a:	48 89 ce             	mov    %rcx,%rsi
   40a2d:	48 89 c7             	mov    %rax,%rdi
   40a30:	e8 f6 26 00 00       	call   4312b <virtual_memory_lookup>
		
		if (map.pn == -1) { // unused va
   40a35:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40a38:	83 f8 ff             	cmp    $0xffffffff,%eax
   40a3b:	74 5d                	je     40a9a <free_pages_va+0x9c>
			continue;
		}
		else if ((map.perm & PTE_P) && (map.perm & PTE_U)) {
   40a3d:	8b 45 f0             	mov    -0x10(%rbp),%eax
   40a40:	48 98                	cltq   
   40a42:	83 e0 01             	and    $0x1,%eax
   40a45:	48 85 c0             	test   %rax,%rax
   40a48:	74 51                	je     40a9b <free_pages_va+0x9d>
   40a4a:	8b 45 f0             	mov    -0x10(%rbp),%eax
   40a4d:	48 98                	cltq   
   40a4f:	83 e0 04             	and    $0x4,%eax
   40a52:	48 85 c0             	test   %rax,%rax
   40a55:	74 44                	je     40a9b <free_pages_va+0x9d>
			if (pageinfo[map.pn].owner == p->p_pid)
   40a57:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40a5a:	48 98                	cltq   
   40a5c:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   40a63:	00 
   40a64:	0f be d0             	movsbl %al,%edx
   40a67:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40a6b:	8b 00                	mov    (%rax),%eax
   40a6d:	39 c2                	cmp    %eax,%edx
   40a6f:	75 0d                	jne    40a7e <free_pages_va+0x80>
				pageinfo[map.pn].owner = PO_FREE;
   40a71:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40a74:	48 98                	cltq   
   40a76:	c6 84 00 40 2e 05 00 	movb   $0x0,0x52e40(%rax,%rax,1)
   40a7d:	00 
			--pageinfo[map.pn].refcount;	
   40a7e:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40a81:	48 63 d0             	movslq %eax,%rdx
   40a84:	0f b6 94 12 41 2e 05 	movzbl 0x52e41(%rdx,%rdx,1),%edx
   40a8b:	00 
   40a8c:	83 ea 01             	sub    $0x1,%edx
   40a8f:	48 98                	cltq   
   40a91:	88 94 00 41 2e 05 00 	mov    %dl,0x52e41(%rax,%rax,1)
   40a98:	eb 01                	jmp    40a9b <free_pages_va+0x9d>
			continue;
   40a9a:	90                   	nop
	for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   40a9b:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40aa2:	00 
   40aa3:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   40aaa:	00 
   40aab:	0f 86 66 ff ff ff    	jbe    40a17 <free_pages_va+0x19>
			//	console_printf(CPOS(23, 0), 0x0, 0);	
			//	console_printf(CPOS(23, 0), 0x1100, "proc 1 code page owner: %d, proc 1 code page refcount: %d\n", pageinfo[PAGENUMBER(0x7000)].owner, pageinfo[PAGENUMBER(0x7000)].refcount); 
			//}
		}
	}
}
   40ab1:	90                   	nop
   40ab2:	90                   	nop
   40ab3:	c9                   	leave  
   40ab4:	c3                   	ret    

0000000000040ab5 <exception>:
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_64_registers* reg) {
   40ab5:	55                   	push   %rbp
   40ab6:	48 89 e5             	mov    %rsp,%rbp
   40ab9:	48 81 ec 30 01 00 00 	sub    $0x130,%rsp
   40ac0:	48 89 bd d8 fe ff ff 	mov    %rdi,-0x128(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   40ac7:	48 8b 05 32 15 01 00 	mov    0x11532(%rip),%rax        # 52000 <current>
   40ace:	48 8b 95 d8 fe ff ff 	mov    -0x128(%rbp),%rdx
   40ad5:	48 83 c0 08          	add    $0x8,%rax
   40ad9:	48 89 d6             	mov    %rdx,%rsi
   40adc:	ba 18 00 00 00       	mov    $0x18,%edx
   40ae1:	48 89 c7             	mov    %rax,%rdi
   40ae4:	48 89 d1             	mov    %rdx,%rcx
   40ae7:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   40aea:	48 8b 05 0f 45 01 00 	mov    0x1450f(%rip),%rax        # 55000 <kernel_pagetable>
   40af1:	48 89 c7             	mov    %rax,%rdi
   40af4:	e8 3b 21 00 00       	call   42c34 <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   40af9:	8b 05 fd 84 07 00    	mov    0x784fd(%rip),%eax        # b8ffc <cursorpos>
   40aff:	89 c7                	mov    %eax,%edi
   40b01:	e8 5c 18 00 00       	call   42362 <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT && reg->reg_intno != INT_GPF) // no error due to pagefault or general fault
   40b06:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40b0d:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40b14:	48 83 f8 0e          	cmp    $0xe,%rax
   40b18:	74 14                	je     40b2e <exception+0x79>
   40b1a:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40b21:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40b28:	48 83 f8 0d          	cmp    $0xd,%rax
   40b2c:	75 16                	jne    40b44 <exception+0x8f>
            || (reg->reg_err & PFERR_USER)) // pagefault error in user mode 
   40b2e:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40b35:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40b3c:	83 e0 04             	and    $0x4,%eax
   40b3f:	48 85 c0             	test   %rax,%rax
   40b42:	74 1a                	je     40b5e <exception+0xa9>
    {
        check_virtual_memory();
   40b44:	e8 cd 09 00 00       	call   41516 <check_virtual_memory>
        if(disp_global){
   40b49:	0f b6 05 b0 54 00 00 	movzbl 0x54b0(%rip),%eax        # 46000 <disp_global>
   40b50:	84 c0                	test   %al,%al
   40b52:	74 0a                	je     40b5e <exception+0xa9>
            memshow_physical();
   40b54:	e8 35 0b 00 00       	call   4168e <memshow_physical>
            memshow_virtual_animate();
   40b59:	e8 5f 0e 00 00       	call   419bd <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   40b5e:	e8 e2 1c 00 00       	call   42845 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   40b63:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40b6a:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40b71:	48 83 e8 0e          	sub    $0xe,%rax
   40b75:	48 83 f8 2a          	cmp    $0x2a,%rax
   40b79:	0f 87 a6 04 00 00    	ja     41025 <exception+0x570>
   40b7f:	48 8b 04 c5 98 46 04 	mov    0x44698(,%rax,8),%rax
   40b86:	00 
   40b87:	ff e0                	jmp    *%rax

    case INT_SYS_PANIC:
	    // rdi stores pointer for msg string
	    {
		char msg[160];
		uintptr_t addr = current->p_registers.reg_rdi;
   40b89:	48 8b 05 70 14 01 00 	mov    0x11470(%rip),%rax        # 52000 <current>
   40b90:	48 8b 40 38          	mov    0x38(%rax),%rax
   40b94:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
		if((void *)addr == NULL)
   40b98:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   40b9d:	75 0f                	jne    40bae <exception+0xf9>
		    panic(NULL);
   40b9f:	bf 00 00 00 00       	mov    $0x0,%edi
   40ba4:	b8 00 00 00 00       	mov    $0x0,%eax
   40ba9:	e8 d8 1d 00 00       	call   42986 <panic>
		vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   40bae:	48 8b 05 4b 14 01 00 	mov    0x1144b(%rip),%rax        # 52000 <current>
   40bb5:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40bbc:	48 8d 45 90          	lea    -0x70(%rbp),%rax
   40bc0:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   40bc4:	48 89 ce             	mov    %rcx,%rsi
   40bc7:	48 89 c7             	mov    %rax,%rdi
   40bca:	e8 5c 25 00 00       	call   4312b <virtual_memory_lookup>
		memcpy(msg, (void *)map.pa, 160);
   40bcf:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40bd3:	48 89 c1             	mov    %rax,%rcx
   40bd6:	48 8d 85 e8 fe ff ff 	lea    -0x118(%rbp),%rax
   40bdd:	ba a0 00 00 00       	mov    $0xa0,%edx
   40be2:	48 89 ce             	mov    %rcx,%rsi
   40be5:	48 89 c7             	mov    %rax,%rdi
   40be8:	e8 56 29 00 00       	call   43543 <memcpy>
		panic(msg);
   40bed:	48 8d 85 e8 fe ff ff 	lea    -0x118(%rbp),%rax
   40bf4:	48 89 c7             	mov    %rax,%rdi
   40bf7:	b8 00 00 00 00       	mov    $0x0,%eax
   40bfc:	e8 85 1d 00 00       	call   42986 <panic>
	    }
	    panic(NULL);
	    break;                  // will not be reached

    case INT_SYS_GETPID:
        current->p_registers.reg_rax = current->p_pid;
   40c01:	48 8b 05 f8 13 01 00 	mov    0x113f8(%rip),%rax        # 52000 <current>
   40c08:	8b 10                	mov    (%rax),%edx
   40c0a:	48 8b 05 ef 13 01 00 	mov    0x113ef(%rip),%rax        # 52000 <current>
   40c11:	48 63 d2             	movslq %edx,%rdx
   40c14:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   40c18:	e9 18 04 00 00       	jmp    41035 <exception+0x580>

    case INT_SYS_YIELD:
        schedule();
   40c1d:	e8 3c 04 00 00       	call   4105e <schedule>
        break;                  /* will not be reached */
   40c22:	e9 0e 04 00 00       	jmp    41035 <exception+0x580>

    case INT_SYS_PAGE_ALLOC: 
	{
        uintptr_t va = current->p_registers.reg_rdi; 
   40c27:	48 8b 05 d2 13 01 00 	mov    0x113d2(%rip),%rax        # 52000 <current>
   40c2e:	48 8b 40 38          	mov    0x38(%rax),%rax
   40c32:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
		uintptr_t pa;
		int r = 0;
   40c36:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
		if (va % PAGESIZE != 0) {
   40c3d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40c41:	25 ff 0f 00 00       	and    $0xfff,%eax
   40c46:	48 85 c0             	test   %rax,%rax
   40c49:	74 0c                	je     40c57 <exception+0x1a2>
			r = -1;
   40c4b:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
   40c52:	e9 b9 00 00 00       	jmp    40d10 <exception+0x25b>
		}
		else if (virtual_memory_lookup(current->p_pagetable, va).pn != -1) {
   40c57:	48 8b 05 a2 13 01 00 	mov    0x113a2(%rip),%rax        # 52000 <current>
   40c5e:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40c65:	48 8d 45 a8          	lea    -0x58(%rbp),%rax
   40c69:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   40c6d:	48 89 ce             	mov    %rcx,%rsi
   40c70:	48 89 c7             	mov    %rax,%rdi
   40c73:	e8 b3 24 00 00       	call   4312b <virtual_memory_lookup>
   40c78:	8b 45 a8             	mov    -0x58(%rbp),%eax
   40c7b:	83 f8 ff             	cmp    $0xffffffff,%eax
   40c7e:	74 0c                	je     40c8c <exception+0x1d7>
			r = -1;
   40c80:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
   40c87:	e9 84 00 00 00       	jmp    40d10 <exception+0x25b>
		}
		else if (next_free_page(&pa) || assign_physical_page(pa, current->p_pid)) {
   40c8c:	48 8d 45 88          	lea    -0x78(%rbp),%rax
   40c90:	48 89 c7             	mov    %rax,%rdi
   40c93:	e8 32 f7 ff ff       	call   403ca <next_free_page>
   40c98:	85 c0                	test   %eax,%eax
   40c9a:	75 1e                	jne    40cba <exception+0x205>
   40c9c:	48 8b 05 5d 13 01 00 	mov    0x1135d(%rip),%rax        # 52000 <current>
   40ca3:	8b 00                	mov    (%rax),%eax
   40ca5:	0f be d0             	movsbl %al,%edx
   40ca8:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   40cac:	89 d6                	mov    %edx,%esi
   40cae:	48 89 c7             	mov    %rax,%rdi
   40cb1:	e8 81 f9 ff ff       	call   40637 <assign_physical_page>
   40cb6:	85 c0                	test   %eax,%eax
   40cb8:	74 22                	je     40cdc <exception+0x227>
			console_printf(CPOS(23, 0), 0x0400, "Out of physical memory!\n");	
   40cba:	ba d0 45 04 00       	mov    $0x445d0,%edx
   40cbf:	be 00 04 00 00       	mov    $0x400,%esi
   40cc4:	bf 30 07 00 00       	mov    $0x730,%edi
   40cc9:	b8 00 00 00 00       	mov    $0x0,%eax
   40cce:	e8 25 37 00 00       	call   443f8 <console_printf>
			r = -1;
   40cd3:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
   40cda:	eb 34                	jmp    40d10 <exception+0x25b>
		}
		else if (virtual_memory_map(current->p_pagetable, va, pa, PAGESIZE, PTE_P | PTE_W | PTE_U)) {
   40cdc:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   40ce0:	48 8b 05 19 13 01 00 	mov    0x11319(%rip),%rax        # 52000 <current>
   40ce7:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40cee:	48 8b 75 e8          	mov    -0x18(%rbp),%rsi
   40cf2:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40cf8:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40cfd:	48 89 c7             	mov    %rax,%rdi
   40d00:	e8 60 20 00 00       	call   42d65 <virtual_memory_map>
   40d05:	85 c0                	test   %eax,%eax
   40d07:	74 07                	je     40d10 <exception+0x25b>
			r = -1;
   40d09:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
		}

        current->p_registers.reg_rax = r;
   40d10:	48 8b 05 e9 12 01 00 	mov    0x112e9(%rip),%rax        # 52000 <current>
   40d17:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40d1a:	48 63 d2             	movslq %edx,%rdx
   40d1d:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   40d21:	e9 0f 03 00 00       	jmp    41035 <exception+0x580>
    }

    case INT_SYS_MAPPING:
    {
	    syscall_mapping(current);
   40d26:	48 8b 05 d3 12 01 00 	mov    0x112d3(%rip),%rax        # 52000 <current>
   40d2d:	48 89 c7             	mov    %rax,%rdi
   40d30:	e8 76 f9 ff ff       	call   406ab <syscall_mapping>
            break;
   40d35:	e9 fb 02 00 00       	jmp    41035 <exception+0x580>
    }

    case INT_SYS_MEM_TOG:
	{
	    syscall_mem_tog(current);
   40d3a:	48 8b 05 bf 12 01 00 	mov    0x112bf(%rip),%rax        # 52000 <current>
   40d41:	48 89 c7             	mov    %rax,%rdi
   40d44:	e8 2b fa ff ff       	call   40774 <syscall_mem_tog>
	    break;
   40d49:	e9 e7 02 00 00       	jmp    41035 <exception+0x580>
	}

    case INT_TIMER:
        ++ticks;
   40d4e:	8b 05 cc 20 01 00    	mov    0x120cc(%rip),%eax        # 52e20 <ticks>
   40d54:	83 c0 01             	add    $0x1,%eax
   40d57:	89 05 c3 20 01 00    	mov    %eax,0x120c3(%rip)        # 52e20 <ticks>
        schedule();
   40d5d:	e8 fc 02 00 00       	call   4105e <schedule>
        break;                  /* will not be reached */
   40d62:	e9 ce 02 00 00       	jmp    41035 <exception+0x580>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   40d67:	0f 20 d0             	mov    %cr2,%rax
   40d6a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    return val;
   40d6e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax

    case INT_PAGEFAULT: {
        // Analyze faulting address and access type.
        uintptr_t addr = rcr2();
   40d72:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        const char* operation = reg->reg_err & PFERR_WRITE
   40d76:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40d7d:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40d84:	83 e0 02             	and    $0x2,%eax
                ? "write" : "read";
   40d87:	48 85 c0             	test   %rax,%rax
   40d8a:	74 07                	je     40d93 <exception+0x2de>
   40d8c:	b8 e9 45 04 00       	mov    $0x445e9,%eax
   40d91:	eb 05                	jmp    40d98 <exception+0x2e3>
   40d93:	b8 ef 45 04 00       	mov    $0x445ef,%eax
        const char* operation = reg->reg_err & PFERR_WRITE
   40d98:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        const char* problem = reg->reg_err & PFERR_PRESENT
   40d9c:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40da3:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40daa:	83 e0 01             	and    $0x1,%eax
                ? "protection problem" : "missing page";
   40dad:	48 85 c0             	test   %rax,%rax
   40db0:	74 07                	je     40db9 <exception+0x304>
   40db2:	b8 f4 45 04 00       	mov    $0x445f4,%eax
   40db7:	eb 05                	jmp    40dbe <exception+0x309>
   40db9:	b8 07 46 04 00       	mov    $0x44607,%eax
        const char* problem = reg->reg_err & PFERR_PRESENT
   40dbe:	48 89 45 c8          	mov    %rax,-0x38(%rbp)

        if (!(reg->reg_err & PFERR_USER)) {
   40dc2:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40dc9:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40dd0:	83 e0 04             	and    $0x4,%eax
   40dd3:	48 85 c0             	test   %rax,%rax
   40dd6:	75 2f                	jne    40e07 <exception+0x352>
            panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   40dd8:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40ddf:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   40de6:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   40dea:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   40dee:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40df2:	49 89 f0             	mov    %rsi,%r8
   40df5:	48 89 c6             	mov    %rax,%rsi
   40df8:	bf 18 46 04 00       	mov    $0x44618,%edi
   40dfd:	b8 00 00 00 00       	mov    $0x0,%eax
   40e02:	e8 7f 1b 00 00       	call   42986 <panic>
                  addr, operation, problem, reg->reg_rip);
        }
        console_printf(CPOS(24, 0), 0x0C00,
   40e07:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40e0e:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                       "Process %d page fault for %p (%s %s, rip=%p)!\n",
                       current->p_pid, addr, operation, problem, reg->reg_rip);
   40e15:	48 8b 05 e4 11 01 00 	mov    0x111e4(%rip),%rax        # 52000 <current>
        console_printf(CPOS(24, 0), 0x0C00,
   40e1c:	8b 00                	mov    (%rax),%eax
   40e1e:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
   40e22:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   40e26:	52                   	push   %rdx
   40e27:	ff 75 c8             	push   -0x38(%rbp)
   40e2a:	49 89 f1             	mov    %rsi,%r9
   40e2d:	49 89 c8             	mov    %rcx,%r8
   40e30:	89 c1                	mov    %eax,%ecx
   40e32:	ba 48 46 04 00       	mov    $0x44648,%edx
   40e37:	be 00 0c 00 00       	mov    $0xc00,%esi
   40e3c:	bf 80 07 00 00       	mov    $0x780,%edi
   40e41:	b8 00 00 00 00       	mov    $0x0,%eax
   40e46:	e8 ad 35 00 00       	call   443f8 <console_printf>
   40e4b:	48 83 c4 10          	add    $0x10,%rsp
        current->p_state = P_BROKEN;
   40e4f:	48 8b 05 aa 11 01 00 	mov    0x111aa(%rip),%rax        # 52000 <current>
   40e56:	c7 80 c8 00 00 00 03 	movl   $0x3,0xc8(%rax)
   40e5d:	00 00 00 
        break;
   40e60:	e9 d0 01 00 00       	jmp    41035 <exception+0x580>
    }

	case INT_SYS_FORK:
		// find free pid
		pid_t child_pid;
		if ((child_pid = next_free_pid()) == -1) {
   40e65:	e8 73 f9 ff ff       	call   407dd <next_free_pid>
   40e6a:	89 45 f8             	mov    %eax,-0x8(%rbp)
   40e6d:	83 7d f8 ff          	cmpl   $0xffffffff,-0x8(%rbp)
   40e71:	75 32                	jne    40ea5 <exception+0x3f0>
			console_printf(CPOS(23, 0), 0x0400, "Max processes (%d) reached!\n", NPROC);	
   40e73:	b9 10 00 00 00       	mov    $0x10,%ecx
   40e78:	ba 77 46 04 00       	mov    $0x44677,%edx
   40e7d:	be 00 04 00 00       	mov    $0x400,%esi
   40e82:	bf 30 07 00 00       	mov    $0x730,%edi
   40e87:	b8 00 00 00 00       	mov    $0x0,%eax
   40e8c:	e8 67 35 00 00       	call   443f8 <console_printf>
			current->p_registers.reg_rax = -1;
   40e91:	48 8b 05 68 11 01 00 	mov    0x11168(%rip),%rax        # 52000 <current>
   40e98:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40e9f:	ff 
			break;
   40ea0:	e9 90 01 00 00       	jmp    41035 <exception+0x580>
		}

		proc *child_proc = &processes[child_pid];
   40ea5:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40ea8:	48 63 d0             	movslq %eax,%rdx
   40eab:	48 89 d0             	mov    %rdx,%rax
   40eae:	48 c1 e0 03          	shl    $0x3,%rax
   40eb2:	48 29 d0             	sub    %rdx,%rax
   40eb5:	48 c1 e0 05          	shl    $0x5,%rax
   40eb9:	48 05 20 20 05 00    	add    $0x52020,%rax
   40ebf:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

		// copy the state of parent into child
		*child_proc = processes[current->p_pid];
   40ec3:	48 8b 05 36 11 01 00 	mov    0x11136(%rip),%rax        # 52000 <current>
   40eca:	8b 00                	mov    (%rax),%eax
   40ecc:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
   40ed0:	48 63 d0             	movslq %eax,%rdx
   40ed3:	48 89 d0             	mov    %rdx,%rax
   40ed6:	48 c1 e0 03          	shl    $0x3,%rax
   40eda:	48 29 d0             	sub    %rdx,%rax
   40edd:	48 c1 e0 05          	shl    $0x5,%rax
   40ee1:	48 05 20 20 05 00    	add    $0x52020,%rax
   40ee7:	48 89 ca             	mov    %rcx,%rdx
   40eea:	48 89 c6             	mov    %rax,%rsi
   40eed:	b8 1c 00 00 00       	mov    $0x1c,%eax
   40ef2:	48 89 d7             	mov    %rdx,%rdi
   40ef5:	48 89 c1             	mov    %rax,%rcx
   40ef8:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
		child_proc->p_pid = child_pid;
   40efb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40eff:	8b 55 f8             	mov    -0x8(%rbp),%edx
   40f02:	89 10                	mov    %edx,(%rax)

		
		// setup and copy the pagetable
		if (pagetable_setup(child_proc->p_pid)) {
   40f04:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40f08:	8b 00                	mov    (%rax),%eax
   40f0a:	89 c7                	mov    %eax,%edi
   40f0c:	e8 d8 f4 ff ff       	call   403e9 <pagetable_setup>
   40f11:	85 c0                	test   %eax,%eax
   40f13:	74 2a                	je     40f3f <exception+0x48a>
			memset(child_proc, 0, sizeof(*child_proc));
   40f15:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40f19:	ba e0 00 00 00       	mov    $0xe0,%edx
   40f1e:	be 00 00 00 00       	mov    $0x0,%esi
   40f23:	48 89 c7             	mov    %rax,%rdi
   40f26:	e8 16 27 00 00       	call   43641 <memset>
			current->p_registers.reg_rax = -1;
   40f2b:	48 8b 05 ce 10 01 00 	mov    0x110ce(%rip),%rax        # 52000 <current>
   40f32:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40f39:	ff 
			break;
   40f3a:	e9 f6 00 00 00       	jmp    41035 <exception+0x580>
		}
		else if (copy_pagetable(child_proc, current)) {
   40f3f:	48 8b 15 ba 10 01 00 	mov    0x110ba(%rip),%rdx        # 52000 <current>
   40f46:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40f4a:	48 89 d6             	mov    %rdx,%rsi
   40f4d:	48 89 c7             	mov    %rax,%rdi
   40f50:	e8 cf f8 ff ff       	call   40824 <copy_pagetable>
   40f55:	85 c0                	test   %eax,%eax
   40f57:	74 42                	je     40f9b <exception+0x4e6>
			free_pages_va(child_proc);		    // goes through all va and frees corresponding physical page
   40f59:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40f5d:	48 89 c7             	mov    %rax,%rdi
   40f60:	e8 99 fa ff ff       	call   409fe <free_pages_va>
			free_pagetable_pages(child_proc);	    // goes through all pa and frees ones that belong to child_proc
   40f65:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40f69:	48 89 c7             	mov    %rax,%rdi
   40f6c:	e8 fa f9 ff ff       	call   4096b <free_pagetable_pages>

			memset(child_proc, 0, sizeof(*child_proc));
   40f71:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40f75:	ba e0 00 00 00       	mov    $0xe0,%edx
   40f7a:	be 00 00 00 00       	mov    $0x0,%esi
   40f7f:	48 89 c7             	mov    %rax,%rdi
   40f82:	e8 ba 26 00 00       	call   43641 <memset>
			current->p_registers.reg_rax = -1;
   40f87:	48 8b 05 72 10 01 00 	mov    0x11072(%rip),%rax        # 52000 <current>
   40f8e:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40f95:	ff 
			break;
   40f96:	e9 9a 00 00 00       	jmp    41035 <exception+0x580>
		}


		// successful fork! set return registers
                console_printf(CPOS(24, 0), 0, "\n");
   40f9b:	ba 94 46 04 00       	mov    $0x44694,%edx
   40fa0:	be 00 00 00 00       	mov    $0x0,%esi
   40fa5:	bf 80 07 00 00       	mov    $0x780,%edi
   40faa:	b8 00 00 00 00       	mov    $0x0,%eax
   40faf:	e8 44 34 00 00       	call   443f8 <console_printf>

		child_proc->p_registers.reg_rax = 0;
   40fb4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40fb8:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
   40fbf:	00 
		current->p_registers.reg_rax = child_pid;
   40fc0:	48 8b 05 39 10 01 00 	mov    0x11039(%rip),%rax        # 52000 <current>
   40fc7:	8b 55 f8             	mov    -0x8(%rbp),%edx
   40fca:	48 63 d2             	movslq %edx,%rdx
   40fcd:	48 89 50 08          	mov    %rdx,0x8(%rax)
		break;
   40fd1:	eb 62                	jmp    41035 <exception+0x580>

	case INT_SYS_EXIT:
		free_pages_va(current);			// goes through all va and frees corresponding physical page
   40fd3:	48 8b 05 26 10 01 00 	mov    0x11026(%rip),%rax        # 52000 <current>
   40fda:	48 89 c7             	mov    %rax,%rdi
   40fdd:	e8 1c fa ff ff       	call   409fe <free_pages_va>
		free_pagetable_pages(current);	// goes through all pa and frees ones that belong to child_proc
   40fe2:	48 8b 05 17 10 01 00 	mov    0x11017(%rip),%rax        # 52000 <current>
   40fe9:	48 89 c7             	mov    %rax,%rdi
   40fec:	e8 7a f9 ff ff       	call   4096b <free_pagetable_pages>
		memset(&processes[current->p_pid], 0, sizeof(*current));
   40ff1:	48 8b 05 08 10 01 00 	mov    0x11008(%rip),%rax        # 52000 <current>
   40ff8:	8b 00                	mov    (%rax),%eax
   40ffa:	48 63 d0             	movslq %eax,%rdx
   40ffd:	48 89 d0             	mov    %rdx,%rax
   41000:	48 c1 e0 03          	shl    $0x3,%rax
   41004:	48 29 d0             	sub    %rdx,%rax
   41007:	48 c1 e0 05          	shl    $0x5,%rax
   4100b:	48 05 20 20 05 00    	add    $0x52020,%rax
   41011:	ba e0 00 00 00       	mov    $0xe0,%edx
   41016:	be 00 00 00 00       	mov    $0x0,%esi
   4101b:	48 89 c7             	mov    %rax,%rdi
   4101e:	e8 1e 26 00 00       	call   43641 <memset>
		break;
   41023:	eb 10                	jmp    41035 <exception+0x580>

    default:
        default_exception(current);
   41025:	48 8b 05 d4 0f 01 00 	mov    0x10fd4(%rip),%rax        # 52000 <current>
   4102c:	48 89 c7             	mov    %rax,%rdi
   4102f:	e8 62 1a 00 00       	call   42a96 <default_exception>
        break;                  /* will not be reached */
   41034:	90                   	nop

    }


    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   41035:	48 8b 05 c4 0f 01 00 	mov    0x10fc4(%rip),%rax        # 52000 <current>
   4103c:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   41042:	83 f8 01             	cmp    $0x1,%eax
   41045:	75 0f                	jne    41056 <exception+0x5a1>
        run(current);
   41047:	48 8b 05 b2 0f 01 00 	mov    0x10fb2(%rip),%rax        # 52000 <current>
   4104e:	48 89 c7             	mov    %rax,%rdi
   41051:	e8 7e 00 00 00       	call   410d4 <run>
    } else {
        schedule();
   41056:	e8 03 00 00 00       	call   4105e <schedule>
    }
}
   4105b:	90                   	nop
   4105c:	c9                   	leave  
   4105d:	c3                   	ret    

000000000004105e <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   4105e:	55                   	push   %rbp
   4105f:	48 89 e5             	mov    %rsp,%rbp
   41062:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   41066:	48 8b 05 93 0f 01 00 	mov    0x10f93(%rip),%rax        # 52000 <current>
   4106d:	8b 00                	mov    (%rax),%eax
   4106f:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   41072:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41075:	8d 50 01             	lea    0x1(%rax),%edx
   41078:	89 d0                	mov    %edx,%eax
   4107a:	c1 f8 1f             	sar    $0x1f,%eax
   4107d:	c1 e8 1c             	shr    $0x1c,%eax
   41080:	01 c2                	add    %eax,%edx
   41082:	83 e2 0f             	and    $0xf,%edx
   41085:	29 c2                	sub    %eax,%edx
   41087:	89 55 fc             	mov    %edx,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   4108a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4108d:	48 63 d0             	movslq %eax,%rdx
   41090:	48 89 d0             	mov    %rdx,%rax
   41093:	48 c1 e0 03          	shl    $0x3,%rax
   41097:	48 29 d0             	sub    %rdx,%rax
   4109a:	48 c1 e0 05          	shl    $0x5,%rax
   4109e:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   410a4:	8b 00                	mov    (%rax),%eax
   410a6:	83 f8 01             	cmp    $0x1,%eax
   410a9:	75 22                	jne    410cd <schedule+0x6f>
            run(&processes[pid]);
   410ab:	8b 45 fc             	mov    -0x4(%rbp),%eax
   410ae:	48 63 d0             	movslq %eax,%rdx
   410b1:	48 89 d0             	mov    %rdx,%rax
   410b4:	48 c1 e0 03          	shl    $0x3,%rax
   410b8:	48 29 d0             	sub    %rdx,%rax
   410bb:	48 c1 e0 05          	shl    $0x5,%rax
   410bf:	48 05 20 20 05 00    	add    $0x52020,%rax
   410c5:	48 89 c7             	mov    %rax,%rdi
   410c8:	e8 07 00 00 00       	call   410d4 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   410cd:	e8 73 17 00 00       	call   42845 <check_keyboard>
        pid = (pid + 1) % NPROC;
   410d2:	eb 9e                	jmp    41072 <schedule+0x14>

00000000000410d4 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   410d4:	55                   	push   %rbp
   410d5:	48 89 e5             	mov    %rsp,%rbp
   410d8:	48 83 ec 10          	sub    $0x10,%rsp
   410dc:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   410e0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   410e4:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   410ea:	83 f8 01             	cmp    $0x1,%eax
   410ed:	74 14                	je     41103 <run+0x2f>
   410ef:	ba f0 47 04 00       	mov    $0x447f0,%edx
   410f4:	be 52 02 00 00       	mov    $0x252,%esi
   410f9:	bf c0 45 04 00       	mov    $0x445c0,%edi
   410fe:	e8 63 19 00 00       	call   42a66 <assert_fail>
    current = p;
   41103:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41107:	48 89 05 f2 0e 01 00 	mov    %rax,0x10ef2(%rip)        # 52000 <current>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   4110e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41112:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   41119:	48 89 c7             	mov    %rax,%rdi
   4111c:	e8 13 1b 00 00       	call   42c34 <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   41121:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41125:	48 83 c0 08          	add    $0x8,%rax
   41129:	48 89 c7             	mov    %rax,%rdi
   4112c:	e8 92 ef ff ff       	call   400c3 <exception_return>

0000000000041131 <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   41131:	55                   	push   %rbp
   41132:	48 89 e5             	mov    %rsp,%rbp
   41135:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   41139:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   41140:	00 
   41141:	e9 81 00 00 00       	jmp    411c7 <pageinfo_init+0x96>
        int owner;
        if (physical_memory_isreserved(addr)) {
   41146:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4114a:	48 89 c7             	mov    %rax,%rdi
   4114d:	e8 81 0f 00 00       	call   420d3 <physical_memory_isreserved>
   41152:	85 c0                	test   %eax,%eax
   41154:	74 09                	je     4115f <pageinfo_init+0x2e>
            owner = PO_RESERVED;
   41156:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   4115d:	eb 2f                	jmp    4118e <pageinfo_init+0x5d>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   4115f:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   41166:	00 
   41167:	76 0b                	jbe    41174 <pageinfo_init+0x43>
   41169:	b8 08 b0 05 00       	mov    $0x5b008,%eax
   4116e:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41172:	72 0a                	jb     4117e <pageinfo_init+0x4d>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   41174:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   4117b:	00 
   4117c:	75 09                	jne    41187 <pageinfo_init+0x56>
            owner = PO_KERNEL;
   4117e:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   41185:	eb 07                	jmp    4118e <pageinfo_init+0x5d>
        } else {
            owner = PO_FREE;
   41187:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   4118e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41192:	48 c1 e8 0c          	shr    $0xc,%rax
   41196:	89 c1                	mov    %eax,%ecx
   41198:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4119b:	89 c2                	mov    %eax,%edx
   4119d:	48 63 c1             	movslq %ecx,%rax
   411a0:	88 94 00 40 2e 05 00 	mov    %dl,0x52e40(%rax,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   411a7:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   411ab:	0f 95 c2             	setne  %dl
   411ae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   411b2:	48 c1 e8 0c          	shr    $0xc,%rax
   411b6:	48 98                	cltq   
   411b8:	88 94 00 41 2e 05 00 	mov    %dl,0x52e41(%rax,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   411bf:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   411c6:	00 
   411c7:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   411ce:	00 
   411cf:	0f 86 71 ff ff ff    	jbe    41146 <pageinfo_init+0x15>
    }
}
   411d5:	90                   	nop
   411d6:	90                   	nop
   411d7:	c9                   	leave  
   411d8:	c3                   	ret    

00000000000411d9 <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   411d9:	55                   	push   %rbp
   411da:	48 89 e5             	mov    %rsp,%rbp
   411dd:	48 83 ec 50          	sub    $0x50,%rsp
   411e1:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   411e5:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   411e9:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   411ef:	48 89 c2             	mov    %rax,%rdx
   411f2:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   411f6:	48 39 c2             	cmp    %rax,%rdx
   411f9:	74 14                	je     4120f <check_page_table_mappings+0x36>
   411fb:	ba 10 48 04 00       	mov    $0x44810,%edx
   41200:	be 7c 02 00 00       	mov    $0x27c,%esi
   41205:	bf c0 45 04 00       	mov    $0x445c0,%edi
   4120a:	e8 57 18 00 00       	call   42a66 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   4120f:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   41216:	00 
   41217:	e9 9a 00 00 00       	jmp    412b6 <check_page_table_mappings+0xdd>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   4121c:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   41220:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   41224:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   41228:	48 89 ce             	mov    %rcx,%rsi
   4122b:	48 89 c7             	mov    %rax,%rdi
   4122e:	e8 f8 1e 00 00       	call   4312b <virtual_memory_lookup>
        if (vam.pa != va) {
   41233:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41237:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4123b:	74 27                	je     41264 <check_page_table_mappings+0x8b>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   4123d:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   41241:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41245:	49 89 d0             	mov    %rdx,%r8
   41248:	48 89 c1             	mov    %rax,%rcx
   4124b:	ba 2f 48 04 00       	mov    $0x4482f,%edx
   41250:	be 00 c0 00 00       	mov    $0xc000,%esi
   41255:	bf e0 06 00 00       	mov    $0x6e0,%edi
   4125a:	b8 00 00 00 00       	mov    $0x0,%eax
   4125f:	e8 94 31 00 00       	call   443f8 <console_printf>
        }
        assert(vam.pa == va);
   41264:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41268:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4126c:	74 14                	je     41282 <check_page_table_mappings+0xa9>
   4126e:	ba 39 48 04 00       	mov    $0x44839,%edx
   41273:	be 85 02 00 00       	mov    $0x285,%esi
   41278:	bf c0 45 04 00       	mov    $0x445c0,%edi
   4127d:	e8 e4 17 00 00       	call   42a66 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   41282:	b8 00 60 04 00       	mov    $0x46000,%eax
   41287:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4128b:	72 21                	jb     412ae <check_page_table_mappings+0xd5>
            assert(vam.perm & PTE_W);
   4128d:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41290:	48 98                	cltq   
   41292:	83 e0 02             	and    $0x2,%eax
   41295:	48 85 c0             	test   %rax,%rax
   41298:	75 14                	jne    412ae <check_page_table_mappings+0xd5>
   4129a:	ba 46 48 04 00       	mov    $0x44846,%edx
   4129f:	be 87 02 00 00       	mov    $0x287,%esi
   412a4:	bf c0 45 04 00       	mov    $0x445c0,%edi
   412a9:	e8 b8 17 00 00       	call   42a66 <assert_fail>
         va += PAGESIZE) {
   412ae:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   412b5:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   412b6:	b8 08 b0 05 00       	mov    $0x5b008,%eax
   412bb:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   412bf:	0f 82 57 ff ff ff    	jb     4121c <check_page_table_mappings+0x43>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   412c5:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   412cc:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   412cd:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   412d1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   412d5:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   412d9:	48 89 ce             	mov    %rcx,%rsi
   412dc:	48 89 c7             	mov    %rax,%rdi
   412df:	e8 47 1e 00 00       	call   4312b <virtual_memory_lookup>
    assert(vam.pa == kstack);
   412e4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   412e8:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   412ec:	74 14                	je     41302 <check_page_table_mappings+0x129>
   412ee:	ba 57 48 04 00       	mov    $0x44857,%edx
   412f3:	be 8e 02 00 00       	mov    $0x28e,%esi
   412f8:	bf c0 45 04 00       	mov    $0x445c0,%edi
   412fd:	e8 64 17 00 00       	call   42a66 <assert_fail>
    assert(vam.perm & PTE_W);
   41302:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41305:	48 98                	cltq   
   41307:	83 e0 02             	and    $0x2,%eax
   4130a:	48 85 c0             	test   %rax,%rax
   4130d:	75 14                	jne    41323 <check_page_table_mappings+0x14a>
   4130f:	ba 46 48 04 00       	mov    $0x44846,%edx
   41314:	be 8f 02 00 00       	mov    $0x28f,%esi
   41319:	bf c0 45 04 00       	mov    $0x445c0,%edi
   4131e:	e8 43 17 00 00       	call   42a66 <assert_fail>
}
   41323:	90                   	nop
   41324:	c9                   	leave  
   41325:	c3                   	ret    

0000000000041326 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   41326:	55                   	push   %rbp
   41327:	48 89 e5             	mov    %rsp,%rbp
   4132a:	48 83 ec 20          	sub    $0x20,%rsp
   4132e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   41332:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   41335:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   41338:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   4133b:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   41342:	48 8b 05 b7 3c 01 00 	mov    0x13cb7(%rip),%rax        # 55000 <kernel_pagetable>
   41349:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   4134d:	75 67                	jne    413b6 <check_page_table_ownership+0x90>
        owner = PO_KERNEL;
   4134f:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   41356:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   4135d:	eb 51                	jmp    413b0 <check_page_table_ownership+0x8a>
            if (processes[xpid].p_state != P_FREE
   4135f:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41362:	48 63 d0             	movslq %eax,%rdx
   41365:	48 89 d0             	mov    %rdx,%rax
   41368:	48 c1 e0 03          	shl    $0x3,%rax
   4136c:	48 29 d0             	sub    %rdx,%rax
   4136f:	48 c1 e0 05          	shl    $0x5,%rax
   41373:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   41379:	8b 00                	mov    (%rax),%eax
   4137b:	85 c0                	test   %eax,%eax
   4137d:	74 2d                	je     413ac <check_page_table_ownership+0x86>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   4137f:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41382:	48 63 d0             	movslq %eax,%rdx
   41385:	48 89 d0             	mov    %rdx,%rax
   41388:	48 c1 e0 03          	shl    $0x3,%rax
   4138c:	48 29 d0             	sub    %rdx,%rax
   4138f:	48 c1 e0 05          	shl    $0x5,%rax
   41393:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   41399:	48 8b 10             	mov    (%rax),%rdx
   4139c:	48 8b 05 5d 3c 01 00 	mov    0x13c5d(%rip),%rax        # 55000 <kernel_pagetable>
   413a3:	48 39 c2             	cmp    %rax,%rdx
   413a6:	75 04                	jne    413ac <check_page_table_ownership+0x86>
                ++expected_refcount;
   413a8:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   413ac:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   413b0:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   413b4:	7e a9                	jle    4135f <check_page_table_ownership+0x39>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   413b6:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   413b9:	8b 55 fc             	mov    -0x4(%rbp),%edx
   413bc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   413c0:	be 00 00 00 00       	mov    $0x0,%esi
   413c5:	48 89 c7             	mov    %rax,%rdi
   413c8:	e8 03 00 00 00       	call   413d0 <check_page_table_ownership_level>
}
   413cd:	90                   	nop
   413ce:	c9                   	leave  
   413cf:	c3                   	ret    

00000000000413d0 <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   413d0:	55                   	push   %rbp
   413d1:	48 89 e5             	mov    %rsp,%rbp
   413d4:	48 83 ec 30          	sub    $0x30,%rsp
   413d8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   413dc:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   413df:	89 55 e0             	mov    %edx,-0x20(%rbp)
   413e2:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   413e5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   413e9:	48 c1 e8 0c          	shr    $0xc,%rax
   413ed:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   413f2:	7e 14                	jle    41408 <check_page_table_ownership_level+0x38>
   413f4:	ba 68 48 04 00       	mov    $0x44868,%edx
   413f9:	be ac 02 00 00       	mov    $0x2ac,%esi
   413fe:	bf c0 45 04 00       	mov    $0x445c0,%edi
   41403:	e8 5e 16 00 00       	call   42a66 <assert_fail>
    if (pageinfo[PAGENUMBER(pt)].owner != owner) {
   41408:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4140c:	48 c1 e8 0c          	shr    $0xc,%rax
   41410:	48 98                	cltq   
   41412:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   41419:	00 
   4141a:	0f be c0             	movsbl %al,%eax
   4141d:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   41420:	74 34                	je     41456 <check_page_table_ownership_level+0x86>
	panic("pt addr: %p, supposed owner of pt: %d, actual owner of pt: %d, refcount: %d", pt, owner, pageinfo[PAGENUMBER(pt)].owner,
   41422:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41426:	48 c1 e8 0c          	shr    $0xc,%rax
   4142a:	48 98                	cltq   
   4142c:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   41433:	00 
   41434:	0f be c8             	movsbl %al,%ecx
   41437:	8b 75 dc             	mov    -0x24(%rbp),%esi
   4143a:	8b 55 e0             	mov    -0x20(%rbp),%edx
   4143d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41441:	41 89 f0             	mov    %esi,%r8d
   41444:	48 89 c6             	mov    %rax,%rsi
   41447:	bf 80 48 04 00       	mov    $0x44880,%edi
   4144c:	b8 00 00 00 00       	mov    $0x0,%eax
   41451:	e8 30 15 00 00       	call   42986 <panic>
			refcount);
    }
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   41456:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4145a:	48 c1 e8 0c          	shr    $0xc,%rax
   4145e:	48 98                	cltq   
   41460:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   41467:	00 
   41468:	0f be c0             	movsbl %al,%eax
   4146b:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   4146e:	74 14                	je     41484 <check_page_table_ownership_level+0xb4>
   41470:	ba d0 48 04 00       	mov    $0x448d0,%edx
   41475:	be b1 02 00 00       	mov    $0x2b1,%esi
   4147a:	bf c0 45 04 00       	mov    $0x445c0,%edi
   4147f:	e8 e2 15 00 00       	call   42a66 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   41484:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41488:	48 c1 e8 0c          	shr    $0xc,%rax
   4148c:	48 98                	cltq   
   4148e:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   41495:	00 
   41496:	0f be c0             	movsbl %al,%eax
   41499:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   4149c:	74 14                	je     414b2 <check_page_table_ownership_level+0xe2>
   4149e:	ba f8 48 04 00       	mov    $0x448f8,%edx
   414a3:	be b2 02 00 00       	mov    $0x2b2,%esi
   414a8:	bf c0 45 04 00       	mov    $0x445c0,%edi
   414ad:	e8 b4 15 00 00       	call   42a66 <assert_fail>
    if (level < 3) {
   414b2:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   414b6:	7f 5b                	jg     41513 <check_page_table_ownership_level+0x143>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   414b8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   414bf:	eb 49                	jmp    4150a <check_page_table_ownership_level+0x13a>
            if (pt->entry[index]) {
   414c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   414c5:	8b 55 fc             	mov    -0x4(%rbp),%edx
   414c8:	48 63 d2             	movslq %edx,%rdx
   414cb:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   414cf:	48 85 c0             	test   %rax,%rax
   414d2:	74 32                	je     41506 <check_page_table_ownership_level+0x136>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   414d4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   414d8:	8b 55 fc             	mov    -0x4(%rbp),%edx
   414db:	48 63 d2             	movslq %edx,%rdx
   414de:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   414e2:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   414e8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   414ec:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   414ef:	8d 70 01             	lea    0x1(%rax),%esi
   414f2:	8b 55 e0             	mov    -0x20(%rbp),%edx
   414f5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   414f9:	b9 01 00 00 00       	mov    $0x1,%ecx
   414fe:	48 89 c7             	mov    %rax,%rdi
   41501:	e8 ca fe ff ff       	call   413d0 <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   41506:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4150a:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41511:	7e ae                	jle    414c1 <check_page_table_ownership_level+0xf1>
            }
        }
    }
}
   41513:	90                   	nop
   41514:	c9                   	leave  
   41515:	c3                   	ret    

0000000000041516 <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   41516:	55                   	push   %rbp
   41517:	48 89 e5             	mov    %rsp,%rbp
   4151a:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   4151e:	8b 05 c4 0b 01 00    	mov    0x10bc4(%rip),%eax        # 520e8 <processes+0xc8>
   41524:	85 c0                	test   %eax,%eax
   41526:	74 14                	je     4153c <check_virtual_memory+0x26>
   41528:	ba 28 49 04 00       	mov    $0x44928,%edx
   4152d:	be c5 02 00 00       	mov    $0x2c5,%esi
   41532:	bf c0 45 04 00       	mov    $0x445c0,%edi
   41537:	e8 2a 15 00 00       	call   42a66 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   4153c:	48 8b 05 bd 3a 01 00 	mov    0x13abd(%rip),%rax        # 55000 <kernel_pagetable>
   41543:	48 89 c7             	mov    %rax,%rdi
   41546:	e8 8e fc ff ff       	call   411d9 <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   4154b:	48 8b 05 ae 3a 01 00 	mov    0x13aae(%rip),%rax        # 55000 <kernel_pagetable>
   41552:	be ff ff ff ff       	mov    $0xffffffff,%esi
   41557:	48 89 c7             	mov    %rax,%rdi
   4155a:	e8 c7 fd ff ff       	call   41326 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   4155f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41566:	e9 9c 00 00 00       	jmp    41607 <check_virtual_memory+0xf1>
        if (processes[pid].p_state != P_FREE
   4156b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4156e:	48 63 d0             	movslq %eax,%rdx
   41571:	48 89 d0             	mov    %rdx,%rax
   41574:	48 c1 e0 03          	shl    $0x3,%rax
   41578:	48 29 d0             	sub    %rdx,%rax
   4157b:	48 c1 e0 05          	shl    $0x5,%rax
   4157f:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   41585:	8b 00                	mov    (%rax),%eax
   41587:	85 c0                	test   %eax,%eax
   41589:	74 78                	je     41603 <check_virtual_memory+0xed>
            && processes[pid].p_pagetable != kernel_pagetable) {
   4158b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4158e:	48 63 d0             	movslq %eax,%rdx
   41591:	48 89 d0             	mov    %rdx,%rax
   41594:	48 c1 e0 03          	shl    $0x3,%rax
   41598:	48 29 d0             	sub    %rdx,%rax
   4159b:	48 c1 e0 05          	shl    $0x5,%rax
   4159f:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   415a5:	48 8b 10             	mov    (%rax),%rdx
   415a8:	48 8b 05 51 3a 01 00 	mov    0x13a51(%rip),%rax        # 55000 <kernel_pagetable>
   415af:	48 39 c2             	cmp    %rax,%rdx
   415b2:	74 4f                	je     41603 <check_virtual_memory+0xed>
            check_page_table_mappings(processes[pid].p_pagetable);
   415b4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   415b7:	48 63 d0             	movslq %eax,%rdx
   415ba:	48 89 d0             	mov    %rdx,%rax
   415bd:	48 c1 e0 03          	shl    $0x3,%rax
   415c1:	48 29 d0             	sub    %rdx,%rax
   415c4:	48 c1 e0 05          	shl    $0x5,%rax
   415c8:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   415ce:	48 8b 00             	mov    (%rax),%rax
   415d1:	48 89 c7             	mov    %rax,%rdi
   415d4:	e8 00 fc ff ff       	call   411d9 <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   415d9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   415dc:	48 63 d0             	movslq %eax,%rdx
   415df:	48 89 d0             	mov    %rdx,%rax
   415e2:	48 c1 e0 03          	shl    $0x3,%rax
   415e6:	48 29 d0             	sub    %rdx,%rax
   415e9:	48 c1 e0 05          	shl    $0x5,%rax
   415ed:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   415f3:	48 8b 00             	mov    (%rax),%rax
   415f6:	8b 55 fc             	mov    -0x4(%rbp),%edx
   415f9:	89 d6                	mov    %edx,%esi
   415fb:	48 89 c7             	mov    %rax,%rdi
   415fe:	e8 23 fd ff ff       	call   41326 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   41603:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41607:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   4160b:	0f 8e 5a ff ff ff    	jle    4156b <check_virtual_memory+0x55>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41611:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41618:	eb 67                	jmp    41681 <check_virtual_memory+0x16b>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   4161a:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4161d:	48 98                	cltq   
   4161f:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   41626:	00 
   41627:	84 c0                	test   %al,%al
   41629:	7e 52                	jle    4167d <check_virtual_memory+0x167>
   4162b:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4162e:	48 98                	cltq   
   41630:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   41637:	00 
   41638:	84 c0                	test   %al,%al
   4163a:	78 41                	js     4167d <check_virtual_memory+0x167>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   4163c:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4163f:	48 98                	cltq   
   41641:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   41648:	00 
   41649:	0f be c0             	movsbl %al,%eax
   4164c:	48 63 d0             	movslq %eax,%rdx
   4164f:	48 89 d0             	mov    %rdx,%rax
   41652:	48 c1 e0 03          	shl    $0x3,%rax
   41656:	48 29 d0             	sub    %rdx,%rax
   41659:	48 c1 e0 05          	shl    $0x5,%rax
   4165d:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   41663:	8b 00                	mov    (%rax),%eax
   41665:	85 c0                	test   %eax,%eax
   41667:	75 14                	jne    4167d <check_virtual_memory+0x167>
   41669:	ba 48 49 04 00       	mov    $0x44948,%edx
   4166e:	be dc 02 00 00       	mov    $0x2dc,%esi
   41673:	bf c0 45 04 00       	mov    $0x445c0,%edi
   41678:	e8 e9 13 00 00       	call   42a66 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4167d:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41681:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   41688:	7e 90                	jle    4161a <check_virtual_memory+0x104>
        }
    }
}
   4168a:	90                   	nop
   4168b:	90                   	nop
   4168c:	c9                   	leave  
   4168d:	c3                   	ret    

000000000004168e <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   4168e:	55                   	push   %rbp
   4168f:	48 89 e5             	mov    %rsp,%rbp
   41692:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   41696:	ba a6 49 04 00       	mov    $0x449a6,%edx
   4169b:	be 00 0f 00 00       	mov    $0xf00,%esi
   416a0:	bf 20 00 00 00       	mov    $0x20,%edi
   416a5:	b8 00 00 00 00       	mov    $0x0,%eax
   416aa:	e8 49 2d 00 00       	call   443f8 <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   416af:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   416b6:	e9 f8 00 00 00       	jmp    417b3 <memshow_physical+0x125>
        if (pn % 64 == 0) {
   416bb:	8b 45 fc             	mov    -0x4(%rbp),%eax
   416be:	83 e0 3f             	and    $0x3f,%eax
   416c1:	85 c0                	test   %eax,%eax
   416c3:	75 3c                	jne    41701 <memshow_physical+0x73>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   416c5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   416c8:	c1 e0 0c             	shl    $0xc,%eax
   416cb:	89 c1                	mov    %eax,%ecx
   416cd:	8b 45 fc             	mov    -0x4(%rbp),%eax
   416d0:	8d 50 3f             	lea    0x3f(%rax),%edx
   416d3:	85 c0                	test   %eax,%eax
   416d5:	0f 48 c2             	cmovs  %edx,%eax
   416d8:	c1 f8 06             	sar    $0x6,%eax
   416db:	8d 50 01             	lea    0x1(%rax),%edx
   416de:	89 d0                	mov    %edx,%eax
   416e0:	c1 e0 02             	shl    $0x2,%eax
   416e3:	01 d0                	add    %edx,%eax
   416e5:	c1 e0 04             	shl    $0x4,%eax
   416e8:	83 c0 03             	add    $0x3,%eax
   416eb:	ba b6 49 04 00       	mov    $0x449b6,%edx
   416f0:	be 00 0f 00 00       	mov    $0xf00,%esi
   416f5:	89 c7                	mov    %eax,%edi
   416f7:	b8 00 00 00 00       	mov    $0x0,%eax
   416fc:	e8 f7 2c 00 00       	call   443f8 <console_printf>
        }

        int owner = pageinfo[pn].owner;
   41701:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41704:	48 98                	cltq   
   41706:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   4170d:	00 
   4170e:	0f be c0             	movsbl %al,%eax
   41711:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   41714:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41717:	48 98                	cltq   
   41719:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   41720:	00 
   41721:	84 c0                	test   %al,%al
   41723:	75 07                	jne    4172c <memshow_physical+0x9e>
            owner = PO_FREE;
   41725:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   4172c:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4172f:	83 c0 02             	add    $0x2,%eax
   41732:	48 98                	cltq   
   41734:	0f b7 84 00 80 49 04 	movzwl 0x44980(%rax,%rax,1),%eax
   4173b:	00 
   4173c:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   41740:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41743:	48 98                	cltq   
   41745:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   4174c:	00 
   4174d:	3c 01                	cmp    $0x1,%al
   4174f:	7e 1a                	jle    4176b <memshow_physical+0xdd>
   41751:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   41756:	48 c1 e8 0c          	shr    $0xc,%rax
   4175a:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   4175d:	74 0c                	je     4176b <memshow_physical+0xdd>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   4175f:	b8 53 00 00 00       	mov    $0x53,%eax
   41764:	80 cc 0f             	or     $0xf,%ah
   41767:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   4176b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4176e:	8d 50 3f             	lea    0x3f(%rax),%edx
   41771:	85 c0                	test   %eax,%eax
   41773:	0f 48 c2             	cmovs  %edx,%eax
   41776:	c1 f8 06             	sar    $0x6,%eax
   41779:	8d 50 01             	lea    0x1(%rax),%edx
   4177c:	89 d0                	mov    %edx,%eax
   4177e:	c1 e0 02             	shl    $0x2,%eax
   41781:	01 d0                	add    %edx,%eax
   41783:	c1 e0 04             	shl    $0x4,%eax
   41786:	89 c1                	mov    %eax,%ecx
   41788:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4178b:	89 d0                	mov    %edx,%eax
   4178d:	c1 f8 1f             	sar    $0x1f,%eax
   41790:	c1 e8 1a             	shr    $0x1a,%eax
   41793:	01 c2                	add    %eax,%edx
   41795:	83 e2 3f             	and    $0x3f,%edx
   41798:	29 c2                	sub    %eax,%edx
   4179a:	89 d0                	mov    %edx,%eax
   4179c:	83 c0 0c             	add    $0xc,%eax
   4179f:	01 c8                	add    %ecx,%eax
   417a1:	48 98                	cltq   
   417a3:	0f b7 55 f6          	movzwl -0xa(%rbp),%edx
   417a7:	66 89 94 00 00 80 0b 	mov    %dx,0xb8000(%rax,%rax,1)
   417ae:	00 
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   417af:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   417b3:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   417ba:	0f 8e fb fe ff ff    	jle    416bb <memshow_physical+0x2d>
    }
}
   417c0:	90                   	nop
   417c1:	90                   	nop
   417c2:	c9                   	leave  
   417c3:	c3                   	ret    

00000000000417c4 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   417c4:	55                   	push   %rbp
   417c5:	48 89 e5             	mov    %rsp,%rbp
   417c8:	48 83 ec 40          	sub    $0x40,%rsp
   417cc:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   417d0:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   417d4:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   417d8:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   417de:	48 89 c2             	mov    %rax,%rdx
   417e1:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   417e5:	48 39 c2             	cmp    %rax,%rdx
   417e8:	74 14                	je     417fe <memshow_virtual+0x3a>
   417ea:	ba c0 49 04 00       	mov    $0x449c0,%edx
   417ef:	be 0d 03 00 00       	mov    $0x30d,%esi
   417f4:	bf c0 45 04 00       	mov    $0x445c0,%edi
   417f9:	e8 68 12 00 00       	call   42a66 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   417fe:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   41802:	48 89 c1             	mov    %rax,%rcx
   41805:	ba ed 49 04 00       	mov    $0x449ed,%edx
   4180a:	be 00 0f 00 00       	mov    $0xf00,%esi
   4180f:	bf 3a 03 00 00       	mov    $0x33a,%edi
   41814:	b8 00 00 00 00       	mov    $0x0,%eax
   41819:	e8 da 2b 00 00       	call   443f8 <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   4181e:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   41825:	00 
   41826:	e9 80 01 00 00       	jmp    419ab <memshow_virtual+0x1e7>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   4182b:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4182f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   41833:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   41837:	48 89 ce             	mov    %rcx,%rsi
   4183a:	48 89 c7             	mov    %rax,%rdi
   4183d:	e8 e9 18 00 00       	call   4312b <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   41842:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41845:	85 c0                	test   %eax,%eax
   41847:	79 0b                	jns    41854 <memshow_virtual+0x90>
            color = ' ';
   41849:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   4184f:	e9 d7 00 00 00       	jmp    4192b <memshow_virtual+0x167>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   41854:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41858:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   4185e:	76 14                	jbe    41874 <memshow_virtual+0xb0>
   41860:	ba 0a 4a 04 00       	mov    $0x44a0a,%edx
   41865:	be 16 03 00 00       	mov    $0x316,%esi
   4186a:	bf c0 45 04 00       	mov    $0x445c0,%edi
   4186f:	e8 f2 11 00 00       	call   42a66 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   41874:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41877:	48 98                	cltq   
   41879:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   41880:	00 
   41881:	0f be c0             	movsbl %al,%eax
   41884:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   41887:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4188a:	48 98                	cltq   
   4188c:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   41893:	00 
   41894:	84 c0                	test   %al,%al
   41896:	75 07                	jne    4189f <memshow_virtual+0xdb>
                owner = PO_FREE;
   41898:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   4189f:	8b 45 f0             	mov    -0x10(%rbp),%eax
   418a2:	83 c0 02             	add    $0x2,%eax
   418a5:	48 98                	cltq   
   418a7:	0f b7 84 00 80 49 04 	movzwl 0x44980(%rax,%rax,1),%eax
   418ae:	00 
   418af:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   418b3:	8b 45 e0             	mov    -0x20(%rbp),%eax
   418b6:	48 98                	cltq   
   418b8:	83 e0 04             	and    $0x4,%eax
   418bb:	48 85 c0             	test   %rax,%rax
   418be:	74 27                	je     418e7 <memshow_virtual+0x123>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   418c0:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   418c4:	c1 e0 04             	shl    $0x4,%eax
   418c7:	66 25 00 f0          	and    $0xf000,%ax
   418cb:	89 c2                	mov    %eax,%edx
   418cd:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   418d1:	c1 f8 04             	sar    $0x4,%eax
   418d4:	66 25 00 0f          	and    $0xf00,%ax
   418d8:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   418da:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   418de:	0f b6 c0             	movzbl %al,%eax
   418e1:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   418e3:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   418e7:	8b 45 d0             	mov    -0x30(%rbp),%eax
   418ea:	48 98                	cltq   
   418ec:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   418f3:	00 
   418f4:	3c 01                	cmp    $0x1,%al
   418f6:	7e 33                	jle    4192b <memshow_virtual+0x167>
   418f8:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   418fd:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41901:	74 28                	je     4192b <memshow_virtual+0x167>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   41903:	b8 53 00 00 00       	mov    $0x53,%eax
   41908:	89 c2                	mov    %eax,%edx
   4190a:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4190e:	66 25 00 f0          	and    $0xf000,%ax
   41912:	09 d0                	or     %edx,%eax
   41914:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   41918:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4191b:	48 98                	cltq   
   4191d:	83 e0 04             	and    $0x4,%eax
   41920:	48 85 c0             	test   %rax,%rax
   41923:	75 06                	jne    4192b <memshow_virtual+0x167>
                    color = color | 0x0F00;
   41925:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   4192b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4192f:	48 c1 e8 0c          	shr    $0xc,%rax
   41933:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   41936:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41939:	83 e0 3f             	and    $0x3f,%eax
   4193c:	85 c0                	test   %eax,%eax
   4193e:	75 34                	jne    41974 <memshow_virtual+0x1b0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   41940:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41943:	c1 e8 06             	shr    $0x6,%eax
   41946:	89 c2                	mov    %eax,%edx
   41948:	89 d0                	mov    %edx,%eax
   4194a:	c1 e0 02             	shl    $0x2,%eax
   4194d:	01 d0                	add    %edx,%eax
   4194f:	c1 e0 04             	shl    $0x4,%eax
   41952:	05 73 03 00 00       	add    $0x373,%eax
   41957:	89 c7                	mov    %eax,%edi
   41959:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4195d:	48 89 c1             	mov    %rax,%rcx
   41960:	ba b6 49 04 00       	mov    $0x449b6,%edx
   41965:	be 00 0f 00 00       	mov    $0xf00,%esi
   4196a:	b8 00 00 00 00       	mov    $0x0,%eax
   4196f:	e8 84 2a 00 00       	call   443f8 <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   41974:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41977:	c1 e8 06             	shr    $0x6,%eax
   4197a:	89 c2                	mov    %eax,%edx
   4197c:	89 d0                	mov    %edx,%eax
   4197e:	c1 e0 02             	shl    $0x2,%eax
   41981:	01 d0                	add    %edx,%eax
   41983:	c1 e0 04             	shl    $0x4,%eax
   41986:	89 c2                	mov    %eax,%edx
   41988:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4198b:	83 e0 3f             	and    $0x3f,%eax
   4198e:	01 d0                	add    %edx,%eax
   41990:	05 7c 03 00 00       	add    $0x37c,%eax
   41995:	89 c2                	mov    %eax,%edx
   41997:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4199b:	66 89 84 12 00 80 0b 	mov    %ax,0xb8000(%rdx,%rdx,1)
   419a2:	00 
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   419a3:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   419aa:	00 
   419ab:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   419b2:	00 
   419b3:	0f 86 72 fe ff ff    	jbe    4182b <memshow_virtual+0x67>
    }
}
   419b9:	90                   	nop
   419ba:	90                   	nop
   419bb:	c9                   	leave  
   419bc:	c3                   	ret    

00000000000419bd <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   419bd:	55                   	push   %rbp
   419be:	48 89 e5             	mov    %rsp,%rbp
   419c1:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   419c5:	8b 05 75 18 01 00    	mov    0x11875(%rip),%eax        # 53240 <last_ticks.1>
   419cb:	85 c0                	test   %eax,%eax
   419cd:	74 13                	je     419e2 <memshow_virtual_animate+0x25>
   419cf:	8b 15 4b 14 01 00    	mov    0x1144b(%rip),%edx        # 52e20 <ticks>
   419d5:	8b 05 65 18 01 00    	mov    0x11865(%rip),%eax        # 53240 <last_ticks.1>
   419db:	29 c2                	sub    %eax,%edx
   419dd:	83 fa 31             	cmp    $0x31,%edx
   419e0:	76 2c                	jbe    41a0e <memshow_virtual_animate+0x51>
        last_ticks = ticks;
   419e2:	8b 05 38 14 01 00    	mov    0x11438(%rip),%eax        # 52e20 <ticks>
   419e8:	89 05 52 18 01 00    	mov    %eax,0x11852(%rip)        # 53240 <last_ticks.1>
        ++showing;
   419ee:	8b 05 10 46 00 00    	mov    0x4610(%rip),%eax        # 46004 <showing.0>
   419f4:	83 c0 01             	add    $0x1,%eax
   419f7:	89 05 07 46 00 00    	mov    %eax,0x4607(%rip)        # 46004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   419fd:	eb 0f                	jmp    41a0e <memshow_virtual_animate+0x51>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
        ++showing;
   419ff:	8b 05 ff 45 00 00    	mov    0x45ff(%rip),%eax        # 46004 <showing.0>
   41a05:	83 c0 01             	add    $0x1,%eax
   41a08:	89 05 f6 45 00 00    	mov    %eax,0x45f6(%rip)        # 46004 <showing.0>
    while (showing <= 2*NPROC
   41a0e:	8b 05 f0 45 00 00    	mov    0x45f0(%rip),%eax        # 46004 <showing.0>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
   41a14:	83 f8 20             	cmp    $0x20,%eax
   41a17:	7f 6d                	jg     41a86 <memshow_virtual_animate+0xc9>
   41a19:	8b 15 e5 45 00 00    	mov    0x45e5(%rip),%edx        # 46004 <showing.0>
   41a1f:	89 d0                	mov    %edx,%eax
   41a21:	c1 f8 1f             	sar    $0x1f,%eax
   41a24:	c1 e8 1c             	shr    $0x1c,%eax
   41a27:	01 c2                	add    %eax,%edx
   41a29:	83 e2 0f             	and    $0xf,%edx
   41a2c:	29 c2                	sub    %eax,%edx
   41a2e:	89 d0                	mov    %edx,%eax
   41a30:	48 63 d0             	movslq %eax,%rdx
   41a33:	48 89 d0             	mov    %rdx,%rax
   41a36:	48 c1 e0 03          	shl    $0x3,%rax
   41a3a:	48 29 d0             	sub    %rdx,%rax
   41a3d:	48 c1 e0 05          	shl    $0x5,%rax
   41a41:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   41a47:	8b 00                	mov    (%rax),%eax
   41a49:	85 c0                	test   %eax,%eax
   41a4b:	74 b2                	je     419ff <memshow_virtual_animate+0x42>
   41a4d:	8b 15 b1 45 00 00    	mov    0x45b1(%rip),%edx        # 46004 <showing.0>
   41a53:	89 d0                	mov    %edx,%eax
   41a55:	c1 f8 1f             	sar    $0x1f,%eax
   41a58:	c1 e8 1c             	shr    $0x1c,%eax
   41a5b:	01 c2                	add    %eax,%edx
   41a5d:	83 e2 0f             	and    $0xf,%edx
   41a60:	29 c2                	sub    %eax,%edx
   41a62:	89 d0                	mov    %edx,%eax
   41a64:	48 63 d0             	movslq %eax,%rdx
   41a67:	48 89 d0             	mov    %rdx,%rax
   41a6a:	48 c1 e0 03          	shl    $0x3,%rax
   41a6e:	48 29 d0             	sub    %rdx,%rax
   41a71:	48 c1 e0 05          	shl    $0x5,%rax
   41a75:	48 05 f8 20 05 00    	add    $0x520f8,%rax
   41a7b:	0f b6 00             	movzbl (%rax),%eax
   41a7e:	84 c0                	test   %al,%al
   41a80:	0f 84 79 ff ff ff    	je     419ff <memshow_virtual_animate+0x42>
    }
    showing = showing % NPROC;
   41a86:	8b 15 78 45 00 00    	mov    0x4578(%rip),%edx        # 46004 <showing.0>
   41a8c:	89 d0                	mov    %edx,%eax
   41a8e:	c1 f8 1f             	sar    $0x1f,%eax
   41a91:	c1 e8 1c             	shr    $0x1c,%eax
   41a94:	01 c2                	add    %eax,%edx
   41a96:	83 e2 0f             	and    $0xf,%edx
   41a99:	29 c2                	sub    %eax,%edx
   41a9b:	89 d0                	mov    %edx,%eax
   41a9d:	89 05 61 45 00 00    	mov    %eax,0x4561(%rip)        # 46004 <showing.0>

    if (processes[showing].p_state != P_FREE) {
   41aa3:	8b 05 5b 45 00 00    	mov    0x455b(%rip),%eax        # 46004 <showing.0>
   41aa9:	48 63 d0             	movslq %eax,%rdx
   41aac:	48 89 d0             	mov    %rdx,%rax
   41aaf:	48 c1 e0 03          	shl    $0x3,%rax
   41ab3:	48 29 d0             	sub    %rdx,%rax
   41ab6:	48 c1 e0 05          	shl    $0x5,%rax
   41aba:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   41ac0:	8b 00                	mov    (%rax),%eax
   41ac2:	85 c0                	test   %eax,%eax
   41ac4:	74 52                	je     41b18 <memshow_virtual_animate+0x15b>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   41ac6:	8b 15 38 45 00 00    	mov    0x4538(%rip),%edx        # 46004 <showing.0>
   41acc:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   41ad0:	89 d1                	mov    %edx,%ecx
   41ad2:	ba 24 4a 04 00       	mov    $0x44a24,%edx
   41ad7:	be 04 00 00 00       	mov    $0x4,%esi
   41adc:	48 89 c7             	mov    %rax,%rdi
   41adf:	b8 00 00 00 00       	mov    $0x0,%eax
   41ae4:	e8 1b 2a 00 00       	call   44504 <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   41ae9:	8b 05 15 45 00 00    	mov    0x4515(%rip),%eax        # 46004 <showing.0>
   41aef:	48 63 d0             	movslq %eax,%rdx
   41af2:	48 89 d0             	mov    %rdx,%rax
   41af5:	48 c1 e0 03          	shl    $0x3,%rax
   41af9:	48 29 d0             	sub    %rdx,%rax
   41afc:	48 c1 e0 05          	shl    $0x5,%rax
   41b00:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   41b06:	48 8b 00             	mov    (%rax),%rax
   41b09:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   41b0d:	48 89 d6             	mov    %rdx,%rsi
   41b10:	48 89 c7             	mov    %rax,%rdi
   41b13:	e8 ac fc ff ff       	call   417c4 <memshow_virtual>
    }
}
   41b18:	90                   	nop
   41b19:	c9                   	leave  
   41b1a:	c3                   	ret    

0000000000041b1b <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   41b1b:	55                   	push   %rbp
   41b1c:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   41b1f:	e8 4f 01 00 00       	call   41c73 <segments_init>
    interrupt_init();
   41b24:	e8 d0 03 00 00       	call   41ef9 <interrupt_init>
    virtual_memory_init();
   41b29:	e8 f3 0f 00 00       	call   42b21 <virtual_memory_init>
}
   41b2e:	90                   	nop
   41b2f:	5d                   	pop    %rbp
   41b30:	c3                   	ret    

0000000000041b31 <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   41b31:	55                   	push   %rbp
   41b32:	48 89 e5             	mov    %rsp,%rbp
   41b35:	48 83 ec 18          	sub    $0x18,%rsp
   41b39:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41b3d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41b41:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   41b44:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41b47:	48 98                	cltq   
   41b49:	48 c1 e0 2d          	shl    $0x2d,%rax
   41b4d:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   41b51:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   41b58:	90 00 00 
   41b5b:	48 09 c2             	or     %rax,%rdx
    *segment = type
   41b5e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41b62:	48 89 10             	mov    %rdx,(%rax)
}
   41b65:	90                   	nop
   41b66:	c9                   	leave  
   41b67:	c3                   	ret    

0000000000041b68 <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   41b68:	55                   	push   %rbp
   41b69:	48 89 e5             	mov    %rsp,%rbp
   41b6c:	48 83 ec 28          	sub    $0x28,%rsp
   41b70:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41b74:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41b78:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41b7b:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   41b7f:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41b83:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41b87:	48 c1 e0 10          	shl    $0x10,%rax
   41b8b:	48 89 c2             	mov    %rax,%rdx
   41b8e:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   41b95:	00 00 00 
   41b98:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   41b9b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41b9f:	48 c1 e0 20          	shl    $0x20,%rax
   41ba3:	48 89 c1             	mov    %rax,%rcx
   41ba6:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   41bad:	00 00 ff 
   41bb0:	48 21 c8             	and    %rcx,%rax
   41bb3:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   41bb6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41bba:	48 83 e8 01          	sub    $0x1,%rax
   41bbe:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   41bc1:	48 09 d0             	or     %rdx,%rax
        | type
   41bc4:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   41bc8:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41bcb:	48 63 d2             	movslq %edx,%rdx
   41bce:	48 c1 e2 2d          	shl    $0x2d,%rdx
   41bd2:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   41bd5:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   41bdc:	80 00 00 
   41bdf:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41be2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41be6:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   41be9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41bed:	48 83 c0 08          	add    $0x8,%rax
   41bf1:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   41bf5:	48 c1 ea 20          	shr    $0x20,%rdx
   41bf9:	48 89 10             	mov    %rdx,(%rax)
}
   41bfc:	90                   	nop
   41bfd:	c9                   	leave  
   41bfe:	c3                   	ret    

0000000000041bff <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   41bff:	55                   	push   %rbp
   41c00:	48 89 e5             	mov    %rsp,%rbp
   41c03:	48 83 ec 20          	sub    $0x20,%rsp
   41c07:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41c0b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41c0f:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41c12:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41c16:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41c1a:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   41c1d:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   41c21:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41c24:	48 63 d2             	movslq %edx,%rdx
   41c27:	48 c1 e2 2d          	shl    $0x2d,%rdx
   41c2b:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   41c2e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41c32:	48 c1 e0 20          	shl    $0x20,%rax
   41c36:	48 89 c1             	mov    %rax,%rcx
   41c39:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   41c40:	00 ff ff 
   41c43:	48 21 c8             	and    %rcx,%rax
   41c46:	48 09 c2             	or     %rax,%rdx
   41c49:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   41c50:	80 00 00 
   41c53:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41c56:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41c5a:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   41c5d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41c61:	48 c1 e8 20          	shr    $0x20,%rax
   41c65:	48 89 c2             	mov    %rax,%rdx
   41c68:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41c6c:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   41c70:	90                   	nop
   41c71:	c9                   	leave  
   41c72:	c3                   	ret    

0000000000041c73 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   41c73:	55                   	push   %rbp
   41c74:	48 89 e5             	mov    %rsp,%rbp
   41c77:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   41c7b:	48 c7 05 da 15 01 00 	movq   $0x0,0x115da(%rip)        # 53260 <segments>
   41c82:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   41c86:	ba 00 00 00 00       	mov    $0x0,%edx
   41c8b:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41c92:	08 20 00 
   41c95:	48 89 c6             	mov    %rax,%rsi
   41c98:	bf 68 32 05 00       	mov    $0x53268,%edi
   41c9d:	e8 8f fe ff ff       	call   41b31 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   41ca2:	ba 03 00 00 00       	mov    $0x3,%edx
   41ca7:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41cae:	08 20 00 
   41cb1:	48 89 c6             	mov    %rax,%rsi
   41cb4:	bf 70 32 05 00       	mov    $0x53270,%edi
   41cb9:	e8 73 fe ff ff       	call   41b31 <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   41cbe:	ba 00 00 00 00       	mov    $0x0,%edx
   41cc3:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41cca:	02 00 00 
   41ccd:	48 89 c6             	mov    %rax,%rsi
   41cd0:	bf 78 32 05 00       	mov    $0x53278,%edi
   41cd5:	e8 57 fe ff ff       	call   41b31 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   41cda:	ba 03 00 00 00       	mov    $0x3,%edx
   41cdf:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41ce6:	02 00 00 
   41ce9:	48 89 c6             	mov    %rax,%rsi
   41cec:	bf 80 32 05 00       	mov    $0x53280,%edi
   41cf1:	e8 3b fe ff ff       	call   41b31 <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   41cf6:	b8 a0 42 05 00       	mov    $0x542a0,%eax
   41cfb:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   41d01:	48 89 c1             	mov    %rax,%rcx
   41d04:	ba 00 00 00 00       	mov    $0x0,%edx
   41d09:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   41d10:	09 00 00 
   41d13:	48 89 c6             	mov    %rax,%rsi
   41d16:	bf 88 32 05 00       	mov    $0x53288,%edi
   41d1b:	e8 48 fe ff ff       	call   41b68 <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   41d20:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   41d26:	b8 60 32 05 00       	mov    $0x53260,%eax
   41d2b:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   41d2f:	ba 60 00 00 00       	mov    $0x60,%edx
   41d34:	be 00 00 00 00       	mov    $0x0,%esi
   41d39:	bf a0 42 05 00       	mov    $0x542a0,%edi
   41d3e:	e8 fe 18 00 00       	call   43641 <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   41d43:	48 c7 05 56 25 01 00 	movq   $0x80000,0x12556(%rip)        # 542a4 <kernel_task_descriptor+0x4>
   41d4a:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   41d4e:	ba 00 10 00 00       	mov    $0x1000,%edx
   41d53:	be 00 00 00 00       	mov    $0x0,%esi
   41d58:	bf a0 32 05 00       	mov    $0x532a0,%edi
   41d5d:	e8 df 18 00 00       	call   43641 <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41d62:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   41d69:	eb 30                	jmp    41d9b <segments_init+0x128>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   41d6b:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   41d70:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41d73:	48 c1 e0 04          	shl    $0x4,%rax
   41d77:	48 05 a0 32 05 00    	add    $0x532a0,%rax
   41d7d:	48 89 d1             	mov    %rdx,%rcx
   41d80:	ba 00 00 00 00       	mov    $0x0,%edx
   41d85:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41d8c:	0e 00 00 
   41d8f:	48 89 c7             	mov    %rax,%rdi
   41d92:	e8 68 fe ff ff       	call   41bff <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41d97:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41d9b:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   41da2:	76 c7                	jbe    41d6b <segments_init+0xf8>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   41da4:	b8 36 00 04 00       	mov    $0x40036,%eax
   41da9:	48 89 c1             	mov    %rax,%rcx
   41dac:	ba 00 00 00 00       	mov    $0x0,%edx
   41db1:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41db8:	0e 00 00 
   41dbb:	48 89 c6             	mov    %rax,%rsi
   41dbe:	bf a0 34 05 00       	mov    $0x534a0,%edi
   41dc3:	e8 37 fe ff ff       	call   41bff <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   41dc8:	b8 2e 00 04 00       	mov    $0x4002e,%eax
   41dcd:	48 89 c1             	mov    %rax,%rcx
   41dd0:	ba 00 00 00 00       	mov    $0x0,%edx
   41dd5:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41ddc:	0e 00 00 
   41ddf:	48 89 c6             	mov    %rax,%rsi
   41de2:	bf 70 33 05 00       	mov    $0x53370,%edi
   41de7:	e8 13 fe ff ff       	call   41bff <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   41dec:	b8 32 00 04 00       	mov    $0x40032,%eax
   41df1:	48 89 c1             	mov    %rax,%rcx
   41df4:	ba 00 00 00 00       	mov    $0x0,%edx
   41df9:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41e00:	0e 00 00 
   41e03:	48 89 c6             	mov    %rax,%rsi
   41e06:	bf 80 33 05 00       	mov    $0x53380,%edi
   41e0b:	e8 ef fd ff ff       	call   41bff <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41e10:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   41e17:	eb 3e                	jmp    41e57 <segments_init+0x1e4>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   41e19:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41e1c:	83 e8 30             	sub    $0x30,%eax
   41e1f:	89 c0                	mov    %eax,%eax
   41e21:	48 8b 04 c5 e7 00 04 	mov    0x400e7(,%rax,8),%rax
   41e28:	00 
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   41e29:	48 89 c2             	mov    %rax,%rdx
   41e2c:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41e2f:	48 c1 e0 04          	shl    $0x4,%rax
   41e33:	48 05 a0 32 05 00    	add    $0x532a0,%rax
   41e39:	48 89 d1             	mov    %rdx,%rcx
   41e3c:	ba 03 00 00 00       	mov    $0x3,%edx
   41e41:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41e48:	0e 00 00 
   41e4b:	48 89 c7             	mov    %rax,%rdi
   41e4e:	e8 ac fd ff ff       	call   41bff <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41e53:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41e57:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   41e5b:	76 bc                	jbe    41e19 <segments_init+0x1a6>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   41e5d:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   41e63:	b8 a0 32 05 00       	mov    $0x532a0,%eax
   41e68:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   41e6c:	b8 28 00 00 00       	mov    $0x28,%eax
   41e71:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   41e75:	0f 00 d8             	ltr    %ax
   41e78:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   41e7c:	0f 20 c0             	mov    %cr0,%rax
   41e7f:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   41e83:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   41e87:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   41e8a:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   41e91:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41e94:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   41e97:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41e9a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   41e9e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41ea2:	0f 22 c0             	mov    %rax,%cr0
}
   41ea5:	90                   	nop
    lcr0(cr0);
}
   41ea6:	90                   	nop
   41ea7:	c9                   	leave  
   41ea8:	c3                   	ret    

0000000000041ea9 <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   41ea9:	55                   	push   %rbp
   41eaa:	48 89 e5             	mov    %rsp,%rbp
   41ead:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   41eb1:	0f b7 05 48 24 01 00 	movzwl 0x12448(%rip),%eax        # 54300 <interrupts_enabled>
   41eb8:	f7 d0                	not    %eax
   41eba:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   41ebe:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41ec2:	0f b6 c0             	movzbl %al,%eax
   41ec5:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   41ecc:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ecf:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   41ed3:	8b 55 f0             	mov    -0x10(%rbp),%edx
   41ed6:	ee                   	out    %al,(%dx)
}
   41ed7:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   41ed8:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41edc:	66 c1 e8 08          	shr    $0x8,%ax
   41ee0:	0f b6 c0             	movzbl %al,%eax
   41ee3:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   41eea:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41eed:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   41ef1:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41ef4:	ee                   	out    %al,(%dx)
}
   41ef5:	90                   	nop
}
   41ef6:	90                   	nop
   41ef7:	c9                   	leave  
   41ef8:	c3                   	ret    

0000000000041ef9 <interrupt_init>:

void interrupt_init(void) {
   41ef9:	55                   	push   %rbp
   41efa:	48 89 e5             	mov    %rsp,%rbp
   41efd:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   41f01:	66 c7 05 f6 23 01 00 	movw   $0x0,0x123f6(%rip)        # 54300 <interrupts_enabled>
   41f08:	00 00 
    interrupt_mask();
   41f0a:	e8 9a ff ff ff       	call   41ea9 <interrupt_mask>
   41f0f:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   41f16:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f1a:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   41f1e:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   41f21:	ee                   	out    %al,(%dx)
}
   41f22:	90                   	nop
   41f23:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   41f2a:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f2e:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   41f32:	8b 55 ac             	mov    -0x54(%rbp),%edx
   41f35:	ee                   	out    %al,(%dx)
}
   41f36:	90                   	nop
   41f37:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   41f3e:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f42:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   41f46:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   41f49:	ee                   	out    %al,(%dx)
}
   41f4a:	90                   	nop
   41f4b:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   41f52:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f56:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   41f5a:	8b 55 bc             	mov    -0x44(%rbp),%edx
   41f5d:	ee                   	out    %al,(%dx)
}
   41f5e:	90                   	nop
   41f5f:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   41f66:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f6a:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   41f6e:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   41f71:	ee                   	out    %al,(%dx)
}
   41f72:	90                   	nop
   41f73:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   41f7a:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f7e:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   41f82:	8b 55 cc             	mov    -0x34(%rbp),%edx
   41f85:	ee                   	out    %al,(%dx)
}
   41f86:	90                   	nop
   41f87:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   41f8e:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f92:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   41f96:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   41f99:	ee                   	out    %al,(%dx)
}
   41f9a:	90                   	nop
   41f9b:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   41fa2:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41fa6:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   41faa:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41fad:	ee                   	out    %al,(%dx)
}
   41fae:	90                   	nop
   41faf:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   41fb6:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41fba:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41fbe:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41fc1:	ee                   	out    %al,(%dx)
}
   41fc2:	90                   	nop
   41fc3:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   41fca:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41fce:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41fd2:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41fd5:	ee                   	out    %al,(%dx)
}
   41fd6:	90                   	nop
   41fd7:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   41fde:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41fe2:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41fe6:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41fe9:	ee                   	out    %al,(%dx)
}
   41fea:	90                   	nop
   41feb:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   41ff2:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ff6:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41ffa:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41ffd:	ee                   	out    %al,(%dx)
}
   41ffe:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   41fff:	e8 a5 fe ff ff       	call   41ea9 <interrupt_mask>
}
   42004:	90                   	nop
   42005:	c9                   	leave  
   42006:	c3                   	ret    

0000000000042007 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   42007:	55                   	push   %rbp
   42008:	48 89 e5             	mov    %rsp,%rbp
   4200b:	48 83 ec 28          	sub    $0x28,%rsp
   4200f:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   42012:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   42016:	0f 8e 9e 00 00 00    	jle    420ba <timer_init+0xb3>
   4201c:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   42023:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42027:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   4202b:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4202e:	ee                   	out    %al,(%dx)
}
   4202f:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   42030:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42033:	89 c2                	mov    %eax,%edx
   42035:	c1 ea 1f             	shr    $0x1f,%edx
   42038:	01 d0                	add    %edx,%eax
   4203a:	d1 f8                	sar    %eax
   4203c:	05 de 34 12 00       	add    $0x1234de,%eax
   42041:	99                   	cltd   
   42042:	f7 7d dc             	idivl  -0x24(%rbp)
   42045:	89 c2                	mov    %eax,%edx
   42047:	89 d0                	mov    %edx,%eax
   42049:	c1 f8 1f             	sar    $0x1f,%eax
   4204c:	c1 e8 18             	shr    $0x18,%eax
   4204f:	01 c2                	add    %eax,%edx
   42051:	0f b6 d2             	movzbl %dl,%edx
   42054:	29 c2                	sub    %eax,%edx
   42056:	89 d0                	mov    %edx,%eax
   42058:	0f b6 c0             	movzbl %al,%eax
   4205b:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   42062:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42065:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   42069:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4206c:	ee                   	out    %al,(%dx)
}
   4206d:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   4206e:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42071:	89 c2                	mov    %eax,%edx
   42073:	c1 ea 1f             	shr    $0x1f,%edx
   42076:	01 d0                	add    %edx,%eax
   42078:	d1 f8                	sar    %eax
   4207a:	05 de 34 12 00       	add    $0x1234de,%eax
   4207f:	99                   	cltd   
   42080:	f7 7d dc             	idivl  -0x24(%rbp)
   42083:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   42089:	85 c0                	test   %eax,%eax
   4208b:	0f 48 c2             	cmovs  %edx,%eax
   4208e:	c1 f8 08             	sar    $0x8,%eax
   42091:	0f b6 c0             	movzbl %al,%eax
   42094:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   4209b:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4209e:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   420a2:	8b 55 fc             	mov    -0x4(%rbp),%edx
   420a5:	ee                   	out    %al,(%dx)
}
   420a6:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   420a7:	0f b7 05 52 22 01 00 	movzwl 0x12252(%rip),%eax        # 54300 <interrupts_enabled>
   420ae:	83 c8 01             	or     $0x1,%eax
   420b1:	66 89 05 48 22 01 00 	mov    %ax,0x12248(%rip)        # 54300 <interrupts_enabled>
   420b8:	eb 11                	jmp    420cb <timer_init+0xc4>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   420ba:	0f b7 05 3f 22 01 00 	movzwl 0x1223f(%rip),%eax        # 54300 <interrupts_enabled>
   420c1:	83 e0 fe             	and    $0xfffffffe,%eax
   420c4:	66 89 05 35 22 01 00 	mov    %ax,0x12235(%rip)        # 54300 <interrupts_enabled>
    }
    interrupt_mask();
   420cb:	e8 d9 fd ff ff       	call   41ea9 <interrupt_mask>
}
   420d0:	90                   	nop
   420d1:	c9                   	leave  
   420d2:	c3                   	ret    

00000000000420d3 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   420d3:	55                   	push   %rbp
   420d4:	48 89 e5             	mov    %rsp,%rbp
   420d7:	48 83 ec 08          	sub    $0x8,%rsp
   420db:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   420df:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   420e4:	74 14                	je     420fa <physical_memory_isreserved+0x27>
   420e6:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   420ed:	00 
   420ee:	76 11                	jbe    42101 <physical_memory_isreserved+0x2e>
   420f0:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   420f7:	00 
   420f8:	77 07                	ja     42101 <physical_memory_isreserved+0x2e>
   420fa:	b8 01 00 00 00       	mov    $0x1,%eax
   420ff:	eb 05                	jmp    42106 <physical_memory_isreserved+0x33>
   42101:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42106:	c9                   	leave  
   42107:	c3                   	ret    

0000000000042108 <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   42108:	55                   	push   %rbp
   42109:	48 89 e5             	mov    %rsp,%rbp
   4210c:	48 83 ec 10          	sub    $0x10,%rsp
   42110:	89 7d fc             	mov    %edi,-0x4(%rbp)
   42113:	89 75 f8             	mov    %esi,-0x8(%rbp)
   42116:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   42119:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4211c:	c1 e0 10             	shl    $0x10,%eax
   4211f:	89 c2                	mov    %eax,%edx
   42121:	8b 45 f8             	mov    -0x8(%rbp),%eax
   42124:	c1 e0 0b             	shl    $0xb,%eax
   42127:	09 c2                	or     %eax,%edx
   42129:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4212c:	c1 e0 08             	shl    $0x8,%eax
   4212f:	09 d0                	or     %edx,%eax
}
   42131:	c9                   	leave  
   42132:	c3                   	ret    

0000000000042133 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   42133:	55                   	push   %rbp
   42134:	48 89 e5             	mov    %rsp,%rbp
   42137:	48 83 ec 18          	sub    $0x18,%rsp
   4213b:	89 7d ec             	mov    %edi,-0x14(%rbp)
   4213e:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   42141:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42144:	8b 45 e8             	mov    -0x18(%rbp),%eax
   42147:	09 d0                	or     %edx,%eax
   42149:	0d 00 00 00 80       	or     $0x80000000,%eax
   4214e:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   42155:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   42158:	8b 45 f0             	mov    -0x10(%rbp),%eax
   4215b:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4215e:	ef                   	out    %eax,(%dx)
}
   4215f:	90                   	nop
   42160:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   42167:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4216a:	89 c2                	mov    %eax,%edx
   4216c:	ed                   	in     (%dx),%eax
   4216d:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   42170:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   42173:	c9                   	leave  
   42174:	c3                   	ret    

0000000000042175 <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   42175:	55                   	push   %rbp
   42176:	48 89 e5             	mov    %rsp,%rbp
   42179:	48 83 ec 28          	sub    $0x28,%rsp
   4217d:	89 7d dc             	mov    %edi,-0x24(%rbp)
   42180:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   42183:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4218a:	eb 73                	jmp    421ff <pci_find_device+0x8a>
        for (int slot = 0; slot != 32; ++slot) {
   4218c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   42193:	eb 60                	jmp    421f5 <pci_find_device+0x80>
            for (int func = 0; func != 8; ++func) {
   42195:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   4219c:	eb 4a                	jmp    421e8 <pci_find_device+0x73>
                int configaddr = pci_make_configaddr(bus, slot, func);
   4219e:	8b 55 f4             	mov    -0xc(%rbp),%edx
   421a1:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   421a4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   421a7:	89 ce                	mov    %ecx,%esi
   421a9:	89 c7                	mov    %eax,%edi
   421ab:	e8 58 ff ff ff       	call   42108 <pci_make_configaddr>
   421b0:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   421b3:	8b 45 f0             	mov    -0x10(%rbp),%eax
   421b6:	be 00 00 00 00       	mov    $0x0,%esi
   421bb:	89 c7                	mov    %eax,%edi
   421bd:	e8 71 ff ff ff       	call   42133 <pci_config_readl>
   421c2:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   421c5:	8b 45 d8             	mov    -0x28(%rbp),%eax
   421c8:	c1 e0 10             	shl    $0x10,%eax
   421cb:	0b 45 dc             	or     -0x24(%rbp),%eax
   421ce:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   421d1:	75 05                	jne    421d8 <pci_find_device+0x63>
                    return configaddr;
   421d3:	8b 45 f0             	mov    -0x10(%rbp),%eax
   421d6:	eb 35                	jmp    4220d <pci_find_device+0x98>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   421d8:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   421dc:	75 06                	jne    421e4 <pci_find_device+0x6f>
   421de:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   421e2:	74 0c                	je     421f0 <pci_find_device+0x7b>
            for (int func = 0; func != 8; ++func) {
   421e4:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   421e8:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   421ec:	75 b0                	jne    4219e <pci_find_device+0x29>
   421ee:	eb 01                	jmp    421f1 <pci_find_device+0x7c>
                    break;
   421f0:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   421f1:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   421f5:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   421f9:	75 9a                	jne    42195 <pci_find_device+0x20>
    for (int bus = 0; bus != 256; ++bus) {
   421fb:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   421ff:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   42206:	75 84                	jne    4218c <pci_find_device+0x17>
                }
            }
        }
    }
    return -1;
   42208:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   4220d:	c9                   	leave  
   4220e:	c3                   	ret    

000000000004220f <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   4220f:	55                   	push   %rbp
   42210:	48 89 e5             	mov    %rsp,%rbp
   42213:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   42217:	be 13 71 00 00       	mov    $0x7113,%esi
   4221c:	bf 86 80 00 00       	mov    $0x8086,%edi
   42221:	e8 4f ff ff ff       	call   42175 <pci_find_device>
   42226:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   42229:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4222d:	78 30                	js     4225f <poweroff+0x50>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   4222f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42232:	be 40 00 00 00       	mov    $0x40,%esi
   42237:	89 c7                	mov    %eax,%edi
   42239:	e8 f5 fe ff ff       	call   42133 <pci_config_readl>
   4223e:	25 c0 ff 00 00       	and    $0xffc0,%eax
   42243:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   42246:	8b 45 f8             	mov    -0x8(%rbp),%eax
   42249:	83 c0 04             	add    $0x4,%eax
   4224c:	89 45 f4             	mov    %eax,-0xc(%rbp)
   4224f:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   42255:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   42259:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4225c:	66 ef                	out    %ax,(%dx)
}
   4225e:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   4225f:	ba 40 4a 04 00       	mov    $0x44a40,%edx
   42264:	be 00 c0 00 00       	mov    $0xc000,%esi
   42269:	bf 80 07 00 00       	mov    $0x780,%edi
   4226e:	b8 00 00 00 00       	mov    $0x0,%eax
   42273:	e8 80 21 00 00       	call   443f8 <console_printf>
 spinloop: goto spinloop;
   42278:	eb fe                	jmp    42278 <poweroff+0x69>

000000000004227a <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   4227a:	55                   	push   %rbp
   4227b:	48 89 e5             	mov    %rsp,%rbp
   4227e:	48 83 ec 10          	sub    $0x10,%rsp
   42282:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   42289:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4228d:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42291:	8b 55 fc             	mov    -0x4(%rbp),%edx
   42294:	ee                   	out    %al,(%dx)
}
   42295:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   42296:	eb fe                	jmp    42296 <reboot+0x1c>

0000000000042298 <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   42298:	55                   	push   %rbp
   42299:	48 89 e5             	mov    %rsp,%rbp
   4229c:	48 83 ec 10          	sub    $0x10,%rsp
   422a0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   422a4:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   422a7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   422ab:	48 83 c0 08          	add    $0x8,%rax
   422af:	ba c0 00 00 00       	mov    $0xc0,%edx
   422b4:	be 00 00 00 00       	mov    $0x0,%esi
   422b9:	48 89 c7             	mov    %rax,%rdi
   422bc:	e8 80 13 00 00       	call   43641 <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   422c1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   422c5:	66 c7 80 a8 00 00 00 	movw   $0x13,0xa8(%rax)
   422cc:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   422ce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   422d2:	48 c7 80 80 00 00 00 	movq   $0x23,0x80(%rax)
   422d9:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   422dd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   422e1:	48 c7 80 88 00 00 00 	movq   $0x23,0x88(%rax)
   422e8:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   422ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   422f0:	66 c7 80 c0 00 00 00 	movw   $0x23,0xc0(%rax)
   422f7:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   422f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   422fd:	48 c7 80 b0 00 00 00 	movq   $0x200,0xb0(%rax)
   42304:	00 02 00 00 
    p->display_status = 1;
   42308:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4230c:	c6 80 d8 00 00 00 01 	movb   $0x1,0xd8(%rax)

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   42313:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42316:	83 e0 01             	and    $0x1,%eax
   42319:	85 c0                	test   %eax,%eax
   4231b:	74 1c                	je     42339 <process_init+0xa1>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   4231d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42321:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   42328:	80 cc 30             	or     $0x30,%ah
   4232b:	48 89 c2             	mov    %rax,%rdx
   4232e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42332:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   42339:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4233c:	83 e0 02             	and    $0x2,%eax
   4233f:	85 c0                	test   %eax,%eax
   42341:	74 1c                	je     4235f <process_init+0xc7>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   42343:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42347:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   4234e:	80 e4 fd             	and    $0xfd,%ah
   42351:	48 89 c2             	mov    %rax,%rdx
   42354:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42358:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
}
   4235f:	90                   	nop
   42360:	c9                   	leave  
   42361:	c3                   	ret    

0000000000042362 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   42362:	55                   	push   %rbp
   42363:	48 89 e5             	mov    %rsp,%rbp
   42366:	48 83 ec 28          	sub    $0x28,%rsp
   4236a:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   4236d:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   42371:	78 09                	js     4237c <console_show_cursor+0x1a>
   42373:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   4237a:	7e 07                	jle    42383 <console_show_cursor+0x21>
        cpos = 0;
   4237c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   42383:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   4238a:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4238e:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   42392:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   42395:	ee                   	out    %al,(%dx)
}
   42396:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   42397:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4239a:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   423a0:	85 c0                	test   %eax,%eax
   423a2:	0f 48 c2             	cmovs  %edx,%eax
   423a5:	c1 f8 08             	sar    $0x8,%eax
   423a8:	0f b6 c0             	movzbl %al,%eax
   423ab:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   423b2:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   423b5:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   423b9:	8b 55 ec             	mov    -0x14(%rbp),%edx
   423bc:	ee                   	out    %al,(%dx)
}
   423bd:	90                   	nop
   423be:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   423c5:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   423c9:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   423cd:	8b 55 f4             	mov    -0xc(%rbp),%edx
   423d0:	ee                   	out    %al,(%dx)
}
   423d1:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   423d2:	8b 55 dc             	mov    -0x24(%rbp),%edx
   423d5:	89 d0                	mov    %edx,%eax
   423d7:	c1 f8 1f             	sar    $0x1f,%eax
   423da:	c1 e8 18             	shr    $0x18,%eax
   423dd:	01 c2                	add    %eax,%edx
   423df:	0f b6 d2             	movzbl %dl,%edx
   423e2:	29 c2                	sub    %eax,%edx
   423e4:	89 d0                	mov    %edx,%eax
   423e6:	0f b6 c0             	movzbl %al,%eax
   423e9:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   423f0:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   423f3:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   423f7:	8b 55 fc             	mov    -0x4(%rbp),%edx
   423fa:	ee                   	out    %al,(%dx)
}
   423fb:	90                   	nop
}
   423fc:	90                   	nop
   423fd:	c9                   	leave  
   423fe:	c3                   	ret    

00000000000423ff <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   423ff:	55                   	push   %rbp
   42400:	48 89 e5             	mov    %rsp,%rbp
   42403:	48 83 ec 20          	sub    $0x20,%rsp
   42407:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   4240e:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42411:	89 c2                	mov    %eax,%edx
   42413:	ec                   	in     (%dx),%al
   42414:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   42417:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   4241b:	0f b6 c0             	movzbl %al,%eax
   4241e:	83 e0 01             	and    $0x1,%eax
   42421:	85 c0                	test   %eax,%eax
   42423:	75 0a                	jne    4242f <keyboard_readc+0x30>
        return -1;
   42425:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4242a:	e9 e7 01 00 00       	jmp    42616 <keyboard_readc+0x217>
   4242f:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42436:	8b 45 e8             	mov    -0x18(%rbp),%eax
   42439:	89 c2                	mov    %eax,%edx
   4243b:	ec                   	in     (%dx),%al
   4243c:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   4243f:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   42443:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   42446:	0f b6 05 b5 1e 01 00 	movzbl 0x11eb5(%rip),%eax        # 54302 <last_escape.2>
   4244d:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   42450:	c6 05 ab 1e 01 00 00 	movb   $0x0,0x11eab(%rip)        # 54302 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   42457:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   4245b:	75 11                	jne    4246e <keyboard_readc+0x6f>
        last_escape = 0x80;
   4245d:	c6 05 9e 1e 01 00 80 	movb   $0x80,0x11e9e(%rip)        # 54302 <last_escape.2>
        return 0;
   42464:	b8 00 00 00 00       	mov    $0x0,%eax
   42469:	e9 a8 01 00 00       	jmp    42616 <keyboard_readc+0x217>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   4246e:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42472:	84 c0                	test   %al,%al
   42474:	79 60                	jns    424d6 <keyboard_readc+0xd7>
        int ch = keymap[(data & 0x7F) | escape];
   42476:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4247a:	83 e0 7f             	and    $0x7f,%eax
   4247d:	89 c2                	mov    %eax,%edx
   4247f:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   42483:	09 d0                	or     %edx,%eax
   42485:	48 98                	cltq   
   42487:	0f b6 80 60 4a 04 00 	movzbl 0x44a60(%rax),%eax
   4248e:	0f b6 c0             	movzbl %al,%eax
   42491:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   42494:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   4249b:	7e 2f                	jle    424cc <keyboard_readc+0xcd>
   4249d:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   424a4:	7f 26                	jg     424cc <keyboard_readc+0xcd>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   424a6:	8b 45 f4             	mov    -0xc(%rbp),%eax
   424a9:	2d fa 00 00 00       	sub    $0xfa,%eax
   424ae:	ba 01 00 00 00       	mov    $0x1,%edx
   424b3:	89 c1                	mov    %eax,%ecx
   424b5:	d3 e2                	shl    %cl,%edx
   424b7:	89 d0                	mov    %edx,%eax
   424b9:	f7 d0                	not    %eax
   424bb:	89 c2                	mov    %eax,%edx
   424bd:	0f b6 05 3f 1e 01 00 	movzbl 0x11e3f(%rip),%eax        # 54303 <modifiers.1>
   424c4:	21 d0                	and    %edx,%eax
   424c6:	88 05 37 1e 01 00    	mov    %al,0x11e37(%rip)        # 54303 <modifiers.1>
        }
        return 0;
   424cc:	b8 00 00 00 00       	mov    $0x0,%eax
   424d1:	e9 40 01 00 00       	jmp    42616 <keyboard_readc+0x217>
    }

    int ch = (unsigned char) keymap[data | escape];
   424d6:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   424da:	0a 45 fa             	or     -0x6(%rbp),%al
   424dd:	0f b6 c0             	movzbl %al,%eax
   424e0:	48 98                	cltq   
   424e2:	0f b6 80 60 4a 04 00 	movzbl 0x44a60(%rax),%eax
   424e9:	0f b6 c0             	movzbl %al,%eax
   424ec:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   424ef:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   424f3:	7e 57                	jle    4254c <keyboard_readc+0x14d>
   424f5:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   424f9:	7f 51                	jg     4254c <keyboard_readc+0x14d>
        if (modifiers & MOD_CONTROL) {
   424fb:	0f b6 05 01 1e 01 00 	movzbl 0x11e01(%rip),%eax        # 54303 <modifiers.1>
   42502:	0f b6 c0             	movzbl %al,%eax
   42505:	83 e0 02             	and    $0x2,%eax
   42508:	85 c0                	test   %eax,%eax
   4250a:	74 09                	je     42515 <keyboard_readc+0x116>
            ch -= 0x60;
   4250c:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   42510:	e9 fd 00 00 00       	jmp    42612 <keyboard_readc+0x213>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   42515:	0f b6 05 e7 1d 01 00 	movzbl 0x11de7(%rip),%eax        # 54303 <modifiers.1>
   4251c:	0f b6 c0             	movzbl %al,%eax
   4251f:	83 e0 01             	and    $0x1,%eax
   42522:	85 c0                	test   %eax,%eax
   42524:	0f 94 c2             	sete   %dl
   42527:	0f b6 05 d5 1d 01 00 	movzbl 0x11dd5(%rip),%eax        # 54303 <modifiers.1>
   4252e:	0f b6 c0             	movzbl %al,%eax
   42531:	83 e0 08             	and    $0x8,%eax
   42534:	85 c0                	test   %eax,%eax
   42536:	0f 94 c0             	sete   %al
   42539:	31 d0                	xor    %edx,%eax
   4253b:	84 c0                	test   %al,%al
   4253d:	0f 84 cf 00 00 00    	je     42612 <keyboard_readc+0x213>
            ch -= 0x20;
   42543:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   42547:	e9 c6 00 00 00       	jmp    42612 <keyboard_readc+0x213>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   4254c:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   42553:	7e 30                	jle    42585 <keyboard_readc+0x186>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   42555:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42558:	2d fa 00 00 00       	sub    $0xfa,%eax
   4255d:	ba 01 00 00 00       	mov    $0x1,%edx
   42562:	89 c1                	mov    %eax,%ecx
   42564:	d3 e2                	shl    %cl,%edx
   42566:	89 d0                	mov    %edx,%eax
   42568:	89 c2                	mov    %eax,%edx
   4256a:	0f b6 05 92 1d 01 00 	movzbl 0x11d92(%rip),%eax        # 54303 <modifiers.1>
   42571:	31 d0                	xor    %edx,%eax
   42573:	88 05 8a 1d 01 00    	mov    %al,0x11d8a(%rip)        # 54303 <modifiers.1>
        ch = 0;
   42579:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42580:	e9 8e 00 00 00       	jmp    42613 <keyboard_readc+0x214>
    } else if (ch >= KEY_SHIFT) {
   42585:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   4258c:	7e 2d                	jle    425bb <keyboard_readc+0x1bc>
        modifiers |= 1 << (ch - KEY_SHIFT);
   4258e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42591:	2d fa 00 00 00       	sub    $0xfa,%eax
   42596:	ba 01 00 00 00       	mov    $0x1,%edx
   4259b:	89 c1                	mov    %eax,%ecx
   4259d:	d3 e2                	shl    %cl,%edx
   4259f:	89 d0                	mov    %edx,%eax
   425a1:	89 c2                	mov    %eax,%edx
   425a3:	0f b6 05 59 1d 01 00 	movzbl 0x11d59(%rip),%eax        # 54303 <modifiers.1>
   425aa:	09 d0                	or     %edx,%eax
   425ac:	88 05 51 1d 01 00    	mov    %al,0x11d51(%rip)        # 54303 <modifiers.1>
        ch = 0;
   425b2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   425b9:	eb 58                	jmp    42613 <keyboard_readc+0x214>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   425bb:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   425bf:	7e 31                	jle    425f2 <keyboard_readc+0x1f3>
   425c1:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   425c8:	7f 28                	jg     425f2 <keyboard_readc+0x1f3>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   425ca:	8b 45 fc             	mov    -0x4(%rbp),%eax
   425cd:	8d 50 80             	lea    -0x80(%rax),%edx
   425d0:	0f b6 05 2c 1d 01 00 	movzbl 0x11d2c(%rip),%eax        # 54303 <modifiers.1>
   425d7:	0f b6 c0             	movzbl %al,%eax
   425da:	83 e0 03             	and    $0x3,%eax
   425dd:	48 98                	cltq   
   425df:	48 63 d2             	movslq %edx,%rdx
   425e2:	0f b6 84 90 60 4b 04 	movzbl 0x44b60(%rax,%rdx,4),%eax
   425e9:	00 
   425ea:	0f b6 c0             	movzbl %al,%eax
   425ed:	89 45 fc             	mov    %eax,-0x4(%rbp)
   425f0:	eb 21                	jmp    42613 <keyboard_readc+0x214>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   425f2:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   425f6:	7f 1b                	jg     42613 <keyboard_readc+0x214>
   425f8:	0f b6 05 04 1d 01 00 	movzbl 0x11d04(%rip),%eax        # 54303 <modifiers.1>
   425ff:	0f b6 c0             	movzbl %al,%eax
   42602:	83 e0 02             	and    $0x2,%eax
   42605:	85 c0                	test   %eax,%eax
   42607:	74 0a                	je     42613 <keyboard_readc+0x214>
        ch = 0;
   42609:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42610:	eb 01                	jmp    42613 <keyboard_readc+0x214>
        if (modifiers & MOD_CONTROL) {
   42612:	90                   	nop
    }

    return ch;
   42613:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   42616:	c9                   	leave  
   42617:	c3                   	ret    

0000000000042618 <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   42618:	55                   	push   %rbp
   42619:	48 89 e5             	mov    %rsp,%rbp
   4261c:	48 83 ec 20          	sub    $0x20,%rsp
   42620:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42627:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4262a:	89 c2                	mov    %eax,%edx
   4262c:	ec                   	in     (%dx),%al
   4262d:	88 45 e3             	mov    %al,-0x1d(%rbp)
   42630:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   42637:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4263a:	89 c2                	mov    %eax,%edx
   4263c:	ec                   	in     (%dx),%al
   4263d:	88 45 eb             	mov    %al,-0x15(%rbp)
   42640:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   42647:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4264a:	89 c2                	mov    %eax,%edx
   4264c:	ec                   	in     (%dx),%al
   4264d:	88 45 f3             	mov    %al,-0xd(%rbp)
   42650:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   42657:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4265a:	89 c2                	mov    %eax,%edx
   4265c:	ec                   	in     (%dx),%al
   4265d:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   42660:	90                   	nop
   42661:	c9                   	leave  
   42662:	c3                   	ret    

0000000000042663 <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   42663:	55                   	push   %rbp
   42664:	48 89 e5             	mov    %rsp,%rbp
   42667:	48 83 ec 40          	sub    $0x40,%rsp
   4266b:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   4266f:	89 f0                	mov    %esi,%eax
   42671:	89 55 c0             	mov    %edx,-0x40(%rbp)
   42674:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   42677:	8b 05 87 1c 01 00    	mov    0x11c87(%rip),%eax        # 54304 <initialized.0>
   4267d:	85 c0                	test   %eax,%eax
   4267f:	75 1e                	jne    4269f <parallel_port_putc+0x3c>
   42681:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   42688:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4268c:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   42690:	8b 55 f8             	mov    -0x8(%rbp),%edx
   42693:	ee                   	out    %al,(%dx)
}
   42694:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   42695:	c7 05 65 1c 01 00 01 	movl   $0x1,0x11c65(%rip)        # 54304 <initialized.0>
   4269c:	00 00 00 
    }

    for (int i = 0;
   4269f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   426a6:	eb 09                	jmp    426b1 <parallel_port_putc+0x4e>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   426a8:	e8 6b ff ff ff       	call   42618 <delay>
         ++i) {
   426ad:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   426b1:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   426b8:	7f 18                	jg     426d2 <parallel_port_putc+0x6f>
   426ba:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   426c1:	8b 45 f0             	mov    -0x10(%rbp),%eax
   426c4:	89 c2                	mov    %eax,%edx
   426c6:	ec                   	in     (%dx),%al
   426c7:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   426ca:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   426ce:	84 c0                	test   %al,%al
   426d0:	79 d6                	jns    426a8 <parallel_port_putc+0x45>
    }
    outb(IO_PARALLEL1_DATA, c);
   426d2:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   426d6:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   426dd:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   426e0:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   426e4:	8b 55 d8             	mov    -0x28(%rbp),%edx
   426e7:	ee                   	out    %al,(%dx)
}
   426e8:	90                   	nop
   426e9:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   426f0:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   426f4:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   426f8:	8b 55 e0             	mov    -0x20(%rbp),%edx
   426fb:	ee                   	out    %al,(%dx)
}
   426fc:	90                   	nop
   426fd:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   42704:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42708:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   4270c:	8b 55 e8             	mov    -0x18(%rbp),%edx
   4270f:	ee                   	out    %al,(%dx)
}
   42710:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   42711:	90                   	nop
   42712:	c9                   	leave  
   42713:	c3                   	ret    

0000000000042714 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   42714:	55                   	push   %rbp
   42715:	48 89 e5             	mov    %rsp,%rbp
   42718:	48 83 ec 20          	sub    $0x20,%rsp
   4271c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42720:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   42724:	48 c7 45 f8 63 26 04 	movq   $0x42663,-0x8(%rbp)
   4272b:	00 
    printer_vprintf(&p, 0, format, val);
   4272c:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   42730:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   42734:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   42738:	be 00 00 00 00       	mov    $0x0,%esi
   4273d:	48 89 c7             	mov    %rax,%rdi
   42740:	e8 98 11 00 00       	call   438dd <printer_vprintf>
}
   42745:	90                   	nop
   42746:	c9                   	leave  
   42747:	c3                   	ret    

0000000000042748 <log_printf>:

void log_printf(const char* format, ...) {
   42748:	55                   	push   %rbp
   42749:	48 89 e5             	mov    %rsp,%rbp
   4274c:	48 83 ec 60          	sub    $0x60,%rsp
   42750:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42754:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42758:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   4275c:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42760:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42764:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42768:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   4276f:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42773:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42777:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4277b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   4277f:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   42783:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42787:	48 89 d6             	mov    %rdx,%rsi
   4278a:	48 89 c7             	mov    %rax,%rdi
   4278d:	e8 82 ff ff ff       	call   42714 <log_vprintf>
    va_end(val);
}
   42792:	90                   	nop
   42793:	c9                   	leave  
   42794:	c3                   	ret    

0000000000042795 <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   42795:	55                   	push   %rbp
   42796:	48 89 e5             	mov    %rsp,%rbp
   42799:	48 83 ec 40          	sub    $0x40,%rsp
   4279d:	89 7d dc             	mov    %edi,-0x24(%rbp)
   427a0:	89 75 d8             	mov    %esi,-0x28(%rbp)
   427a3:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   427a7:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   427ab:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   427af:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   427b3:	48 8b 0a             	mov    (%rdx),%rcx
   427b6:	48 89 08             	mov    %rcx,(%rax)
   427b9:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   427bd:	48 89 48 08          	mov    %rcx,0x8(%rax)
   427c1:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   427c5:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   427c9:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   427cd:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   427d1:	48 89 d6             	mov    %rdx,%rsi
   427d4:	48 89 c7             	mov    %rax,%rdi
   427d7:	e8 38 ff ff ff       	call   42714 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   427dc:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   427e0:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   427e4:	8b 75 d8             	mov    -0x28(%rbp),%esi
   427e7:	8b 45 dc             	mov    -0x24(%rbp),%eax
   427ea:	89 c7                	mov    %eax,%edi
   427ec:	e8 9b 1b 00 00       	call   4438c <console_vprintf>
}
   427f1:	c9                   	leave  
   427f2:	c3                   	ret    

00000000000427f3 <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   427f3:	55                   	push   %rbp
   427f4:	48 89 e5             	mov    %rsp,%rbp
   427f7:	48 83 ec 60          	sub    $0x60,%rsp
   427fb:	89 7d ac             	mov    %edi,-0x54(%rbp)
   427fe:	89 75 a8             	mov    %esi,-0x58(%rbp)
   42801:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   42805:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42809:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4280d:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42811:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   42818:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4281c:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42820:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42824:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   42828:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   4282c:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   42830:	8b 75 a8             	mov    -0x58(%rbp),%esi
   42833:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42836:	89 c7                	mov    %eax,%edi
   42838:	e8 58 ff ff ff       	call   42795 <error_vprintf>
   4283d:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   42840:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   42843:	c9                   	leave  
   42844:	c3                   	ret    

0000000000042845 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'f', and 'e' cause a soft
//    reboot where the kernel runs the allocator programs, "fork", or
//    "forkexit", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   42845:	55                   	push   %rbp
   42846:	48 89 e5             	mov    %rsp,%rbp
   42849:	53                   	push   %rbx
   4284a:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   4284e:	e8 ac fb ff ff       	call   423ff <keyboard_readc>
   42853:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   42856:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   4285a:	74 1c                	je     42878 <check_keyboard+0x33>
   4285c:	83 7d e4 66          	cmpl   $0x66,-0x1c(%rbp)
   42860:	74 16                	je     42878 <check_keyboard+0x33>
   42862:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42866:	74 10                	je     42878 <check_keyboard+0x33>
   42868:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   4286c:	74 0a                	je     42878 <check_keyboard+0x33>
   4286e:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42872:	0f 85 e9 00 00 00    	jne    42961 <check_keyboard+0x11c>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   42878:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   4287f:	00 
        memset(pt, 0, PAGESIZE * 3);
   42880:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42884:	ba 00 30 00 00       	mov    $0x3000,%edx
   42889:	be 00 00 00 00       	mov    $0x0,%esi
   4288e:	48 89 c7             	mov    %rax,%rdi
   42891:	e8 ab 0d 00 00       	call   43641 <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   42896:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4289a:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   428a1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   428a5:	48 05 00 10 00 00    	add    $0x1000,%rax
   428ab:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   428b2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   428b6:	48 05 00 20 00 00    	add    $0x2000,%rax
   428bc:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   428c3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   428c7:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   428cb:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   428cf:	0f 22 d8             	mov    %rax,%cr3
}
   428d2:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   428d3:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "fork";
   428da:	48 c7 45 e8 b8 4b 04 	movq   $0x44bb8,-0x18(%rbp)
   428e1:	00 
        if (c == 'a') {
   428e2:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   428e6:	75 0a                	jne    428f2 <check_keyboard+0xad>
            argument = "allocator";
   428e8:	48 c7 45 e8 bd 4b 04 	movq   $0x44bbd,-0x18(%rbp)
   428ef:	00 
   428f0:	eb 2e                	jmp    42920 <check_keyboard+0xdb>
        } else if (c == 'e') {
   428f2:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   428f6:	75 0a                	jne    42902 <check_keyboard+0xbd>
            argument = "forkexit";
   428f8:	48 c7 45 e8 c7 4b 04 	movq   $0x44bc7,-0x18(%rbp)
   428ff:	00 
   42900:	eb 1e                	jmp    42920 <check_keyboard+0xdb>
        }
        else if (c == 't'){
   42902:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42906:	75 0a                	jne    42912 <check_keyboard+0xcd>
            argument = "test";
   42908:	48 c7 45 e8 d0 4b 04 	movq   $0x44bd0,-0x18(%rbp)
   4290f:	00 
   42910:	eb 0e                	jmp    42920 <check_keyboard+0xdb>
        }
        else if(c == '2'){
   42912:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42916:	75 08                	jne    42920 <check_keyboard+0xdb>
            argument = "test2";
   42918:	48 c7 45 e8 d5 4b 04 	movq   $0x44bd5,-0x18(%rbp)
   4291f:	00 
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   42920:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42924:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   42928:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4292d:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   42931:	73 14                	jae    42947 <check_keyboard+0x102>
   42933:	ba db 4b 04 00       	mov    $0x44bdb,%edx
   42938:	be 5d 02 00 00       	mov    $0x25d,%esi
   4293d:	bf f7 4b 04 00       	mov    $0x44bf7,%edi
   42942:	e8 1f 01 00 00       	call   42a66 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   42947:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4294b:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   4294e:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   42952:	48 89 c3             	mov    %rax,%rbx
   42955:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   4295a:	e9 a1 d6 ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   4295f:	eb 11                	jmp    42972 <check_keyboard+0x12d>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   42961:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   42965:	74 06                	je     4296d <check_keyboard+0x128>
   42967:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   4296b:	75 05                	jne    42972 <check_keyboard+0x12d>
        poweroff();
   4296d:	e8 9d f8 ff ff       	call   4220f <poweroff>
    }
    return c;
   42972:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   42975:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42979:	c9                   	leave  
   4297a:	c3                   	ret    

000000000004297b <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   4297b:	55                   	push   %rbp
   4297c:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   4297f:	e8 c1 fe ff ff       	call   42845 <check_keyboard>
   42984:	eb f9                	jmp    4297f <fail+0x4>

0000000000042986 <panic>:

// panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void panic(const char* format, ...) {
   42986:	55                   	push   %rbp
   42987:	48 89 e5             	mov    %rsp,%rbp
   4298a:	48 83 ec 60          	sub    $0x60,%rsp
   4298e:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42992:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42996:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   4299a:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4299e:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   429a2:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   429a6:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   429ad:	48 8d 45 10          	lea    0x10(%rbp),%rax
   429b1:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   429b5:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   429b9:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   429bd:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   429c2:	0f 84 80 00 00 00    	je     42a48 <panic+0xc2>
        // Print panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   429c8:	ba 0b 4c 04 00       	mov    $0x44c0b,%edx
   429cd:	be 00 c0 00 00       	mov    $0xc000,%esi
   429d2:	bf 30 07 00 00       	mov    $0x730,%edi
   429d7:	b8 00 00 00 00       	mov    $0x0,%eax
   429dc:	e8 12 fe ff ff       	call   427f3 <error_printf>
   429e1:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   429e4:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   429e8:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   429ec:	8b 45 cc             	mov    -0x34(%rbp),%eax
   429ef:	be 00 c0 00 00       	mov    $0xc000,%esi
   429f4:	89 c7                	mov    %eax,%edi
   429f6:	e8 9a fd ff ff       	call   42795 <error_vprintf>
   429fb:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   429fe:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   42a01:	48 63 c1             	movslq %ecx,%rax
   42a04:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   42a0b:	48 c1 e8 20          	shr    $0x20,%rax
   42a0f:	89 c2                	mov    %eax,%edx
   42a11:	c1 fa 05             	sar    $0x5,%edx
   42a14:	89 c8                	mov    %ecx,%eax
   42a16:	c1 f8 1f             	sar    $0x1f,%eax
   42a19:	29 c2                	sub    %eax,%edx
   42a1b:	89 d0                	mov    %edx,%eax
   42a1d:	c1 e0 02             	shl    $0x2,%eax
   42a20:	01 d0                	add    %edx,%eax
   42a22:	c1 e0 04             	shl    $0x4,%eax
   42a25:	29 c1                	sub    %eax,%ecx
   42a27:	89 ca                	mov    %ecx,%edx
   42a29:	85 d2                	test   %edx,%edx
   42a2b:	74 34                	je     42a61 <panic+0xdb>
            error_printf(cpos, 0xC000, "\n");
   42a2d:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42a30:	ba 13 4c 04 00       	mov    $0x44c13,%edx
   42a35:	be 00 c0 00 00       	mov    $0xc000,%esi
   42a3a:	89 c7                	mov    %eax,%edi
   42a3c:	b8 00 00 00 00       	mov    $0x0,%eax
   42a41:	e8 ad fd ff ff       	call   427f3 <error_printf>
   42a46:	eb 19                	jmp    42a61 <panic+0xdb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   42a48:	ba 15 4c 04 00       	mov    $0x44c15,%edx
   42a4d:	be 00 c0 00 00       	mov    $0xc000,%esi
   42a52:	bf 30 07 00 00       	mov    $0x730,%edi
   42a57:	b8 00 00 00 00       	mov    $0x0,%eax
   42a5c:	e8 92 fd ff ff       	call   427f3 <error_printf>
    }

    va_end(val);
    fail();
   42a61:	e8 15 ff ff ff       	call   4297b <fail>

0000000000042a66 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   42a66:	55                   	push   %rbp
   42a67:	48 89 e5             	mov    %rsp,%rbp
   42a6a:	48 83 ec 20          	sub    $0x20,%rsp
   42a6e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42a72:	89 75 f4             	mov    %esi,-0xc(%rbp)
   42a75:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   42a79:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   42a7d:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42a80:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42a84:	48 89 c6             	mov    %rax,%rsi
   42a87:	bf 1b 4c 04 00       	mov    $0x44c1b,%edi
   42a8c:	b8 00 00 00 00       	mov    $0x0,%eax
   42a91:	e8 f0 fe ff ff       	call   42986 <panic>

0000000000042a96 <default_exception>:
}

void default_exception(proc* p){
   42a96:	55                   	push   %rbp
   42a97:	48 89 e5             	mov    %rsp,%rbp
   42a9a:	48 83 ec 20          	sub    $0x20,%rsp
   42a9e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   42aa2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42aa6:	48 83 c0 08          	add    $0x8,%rax
   42aaa:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    panic("Unexpected exception %d!\n", reg->reg_intno);
   42aae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42ab2:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   42ab9:	48 89 c6             	mov    %rax,%rsi
   42abc:	bf 39 4c 04 00       	mov    $0x44c39,%edi
   42ac1:	b8 00 00 00 00       	mov    $0x0,%eax
   42ac6:	e8 bb fe ff ff       	call   42986 <panic>

0000000000042acb <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   42acb:	55                   	push   %rbp
   42acc:	48 89 e5             	mov    %rsp,%rbp
   42acf:	48 83 ec 10          	sub    $0x10,%rsp
   42ad3:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42ad7:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   42ada:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   42ade:	78 06                	js     42ae6 <pageindex+0x1b>
   42ae0:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   42ae4:	7e 14                	jle    42afa <pageindex+0x2f>
   42ae6:	ba 58 4c 04 00       	mov    $0x44c58,%edx
   42aeb:	be 1e 00 00 00       	mov    $0x1e,%esi
   42af0:	bf 71 4c 04 00       	mov    $0x44c71,%edi
   42af5:	e8 6c ff ff ff       	call   42a66 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   42afa:	b8 03 00 00 00       	mov    $0x3,%eax
   42aff:	2b 45 f4             	sub    -0xc(%rbp),%eax
   42b02:	89 c2                	mov    %eax,%edx
   42b04:	89 d0                	mov    %edx,%eax
   42b06:	c1 e0 03             	shl    $0x3,%eax
   42b09:	01 d0                	add    %edx,%eax
   42b0b:	83 c0 0c             	add    $0xc,%eax
   42b0e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42b12:	89 c1                	mov    %eax,%ecx
   42b14:	48 d3 ea             	shr    %cl,%rdx
   42b17:	48 89 d0             	mov    %rdx,%rax
   42b1a:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   42b1f:	c9                   	leave  
   42b20:	c3                   	ret    

0000000000042b21 <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   42b21:	55                   	push   %rbp
   42b22:	48 89 e5             	mov    %rsp,%rbp
   42b25:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   42b29:	48 c7 05 cc 24 01 00 	movq   $0x56000,0x124cc(%rip)        # 55000 <kernel_pagetable>
   42b30:	00 60 05 00 
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   42b34:	ba 00 50 00 00       	mov    $0x5000,%edx
   42b39:	be 00 00 00 00       	mov    $0x0,%esi
   42b3e:	bf 00 60 05 00       	mov    $0x56000,%edi
   42b43:	e8 f9 0a 00 00       	call   43641 <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   42b48:	b8 00 70 05 00       	mov    $0x57000,%eax
   42b4d:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   42b51:	48 89 05 a8 34 01 00 	mov    %rax,0x134a8(%rip)        # 56000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   42b58:	b8 00 80 05 00       	mov    $0x58000,%eax
   42b5d:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   42b61:	48 89 05 98 44 01 00 	mov    %rax,0x14498(%rip)        # 57000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   42b68:	b8 00 90 05 00       	mov    $0x59000,%eax
   42b6d:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   42b71:	48 89 05 88 54 01 00 	mov    %rax,0x15488(%rip)        # 58000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   42b78:	b8 00 a0 05 00       	mov    $0x5a000,%eax
   42b7d:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   42b81:	48 89 05 80 54 01 00 	mov    %rax,0x15480(%rip)        # 58008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   42b88:	48 8b 05 71 24 01 00 	mov    0x12471(%rip),%rax        # 55000 <kernel_pagetable>
   42b8f:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42b95:	b9 00 00 20 00       	mov    $0x200000,%ecx
   42b9a:	ba 00 00 00 00       	mov    $0x0,%edx
   42b9f:	be 00 00 00 00       	mov    $0x0,%esi
   42ba4:	48 89 c7             	mov    %rax,%rdi
   42ba7:	e8 b9 01 00 00       	call   42d65 <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42bac:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42bb3:	00 
   42bb4:	eb 62                	jmp    42c18 <virtual_memory_init+0xf7>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   42bb6:	48 8b 0d 43 24 01 00 	mov    0x12443(%rip),%rcx        # 55000 <kernel_pagetable>
   42bbd:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42bc1:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42bc5:	48 89 ce             	mov    %rcx,%rsi
   42bc8:	48 89 c7             	mov    %rax,%rdi
   42bcb:	e8 5b 05 00 00       	call   4312b <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l1pagetable ?
        assert(vmap.pa == addr);
   42bd0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42bd4:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   42bd8:	74 14                	je     42bee <virtual_memory_init+0xcd>
   42bda:	ba 85 4c 04 00       	mov    $0x44c85,%edx
   42bdf:	be 2d 00 00 00       	mov    $0x2d,%esi
   42be4:	bf 95 4c 04 00       	mov    $0x44c95,%edi
   42be9:	e8 78 fe ff ff       	call   42a66 <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   42bee:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42bf1:	48 98                	cltq   
   42bf3:	83 e0 03             	and    $0x3,%eax
   42bf6:	48 83 f8 03          	cmp    $0x3,%rax
   42bfa:	74 14                	je     42c10 <virtual_memory_init+0xef>
   42bfc:	ba a8 4c 04 00       	mov    $0x44ca8,%edx
   42c01:	be 2e 00 00 00       	mov    $0x2e,%esi
   42c06:	bf 95 4c 04 00       	mov    $0x44c95,%edi
   42c0b:	e8 56 fe ff ff       	call   42a66 <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42c10:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42c17:	00 
   42c18:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   42c1f:	00 
   42c20:	76 94                	jbe    42bb6 <virtual_memory_init+0x95>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   42c22:	48 8b 05 d7 23 01 00 	mov    0x123d7(%rip),%rax        # 55000 <kernel_pagetable>
   42c29:	48 89 c7             	mov    %rax,%rdi
   42c2c:	e8 03 00 00 00       	call   42c34 <set_pagetable>
}
   42c31:	90                   	nop
   42c32:	c9                   	leave  
   42c33:	c3                   	ret    

0000000000042c34 <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   42c34:	55                   	push   %rbp
   42c35:	48 89 e5             	mov    %rsp,%rbp
   42c38:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   42c3c:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   42c40:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42c44:	25 ff 0f 00 00       	and    $0xfff,%eax
   42c49:	48 85 c0             	test   %rax,%rax
   42c4c:	74 14                	je     42c62 <set_pagetable+0x2e>
   42c4e:	ba d5 4c 04 00       	mov    $0x44cd5,%edx
   42c53:	be 3d 00 00 00       	mov    $0x3d,%esi
   42c58:	bf 95 4c 04 00       	mov    $0x44c95,%edi
   42c5d:	e8 04 fe ff ff       	call   42a66 <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   42c62:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42c67:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   42c6b:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42c6f:	48 89 ce             	mov    %rcx,%rsi
   42c72:	48 89 c7             	mov    %rax,%rdi
   42c75:	e8 b1 04 00 00       	call   4312b <virtual_memory_lookup>
   42c7a:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42c7e:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42c83:	48 39 d0             	cmp    %rdx,%rax
   42c86:	74 14                	je     42c9c <set_pagetable+0x68>
   42c88:	ba f0 4c 04 00       	mov    $0x44cf0,%edx
   42c8d:	be 3f 00 00 00       	mov    $0x3f,%esi
   42c92:	bf 95 4c 04 00       	mov    $0x44c95,%edi
   42c97:	e8 ca fd ff ff       	call   42a66 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   42c9c:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   42ca0:	48 8b 0d 59 23 01 00 	mov    0x12359(%rip),%rcx        # 55000 <kernel_pagetable>
   42ca7:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   42cab:	48 89 ce             	mov    %rcx,%rsi
   42cae:	48 89 c7             	mov    %rax,%rdi
   42cb1:	e8 75 04 00 00       	call   4312b <virtual_memory_lookup>
   42cb6:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42cba:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42cbe:	48 39 c2             	cmp    %rax,%rdx
   42cc1:	74 14                	je     42cd7 <set_pagetable+0xa3>
   42cc3:	ba 58 4d 04 00       	mov    $0x44d58,%edx
   42cc8:	be 41 00 00 00       	mov    $0x41,%esi
   42ccd:	bf 95 4c 04 00       	mov    $0x44c95,%edi
   42cd2:	e8 8f fd ff ff       	call   42a66 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   42cd7:	48 8b 05 22 23 01 00 	mov    0x12322(%rip),%rax        # 55000 <kernel_pagetable>
   42cde:	48 89 c2             	mov    %rax,%rdx
   42ce1:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   42ce5:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42ce9:	48 89 ce             	mov    %rcx,%rsi
   42cec:	48 89 c7             	mov    %rax,%rdi
   42cef:	e8 37 04 00 00       	call   4312b <virtual_memory_lookup>
   42cf4:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42cf8:	48 8b 15 01 23 01 00 	mov    0x12301(%rip),%rdx        # 55000 <kernel_pagetable>
   42cff:	48 39 d0             	cmp    %rdx,%rax
   42d02:	74 14                	je     42d18 <set_pagetable+0xe4>
   42d04:	ba b8 4d 04 00       	mov    $0x44db8,%edx
   42d09:	be 43 00 00 00       	mov    $0x43,%esi
   42d0e:	bf 95 4c 04 00       	mov    $0x44c95,%edi
   42d13:	e8 4e fd ff ff       	call   42a66 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   42d18:	ba 65 2d 04 00       	mov    $0x42d65,%edx
   42d1d:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42d21:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42d25:	48 89 ce             	mov    %rcx,%rsi
   42d28:	48 89 c7             	mov    %rax,%rdi
   42d2b:	e8 fb 03 00 00       	call   4312b <virtual_memory_lookup>
   42d30:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d34:	ba 65 2d 04 00       	mov    $0x42d65,%edx
   42d39:	48 39 d0             	cmp    %rdx,%rax
   42d3c:	74 14                	je     42d52 <set_pagetable+0x11e>
   42d3e:	ba 20 4e 04 00       	mov    $0x44e20,%edx
   42d43:	be 45 00 00 00       	mov    $0x45,%esi
   42d48:	bf 95 4c 04 00       	mov    $0x44c95,%edi
   42d4d:	e8 14 fd ff ff       	call   42a66 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   42d52:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42d56:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42d5a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42d5e:	0f 22 d8             	mov    %rax,%cr3
}
   42d61:	90                   	nop
}
   42d62:	90                   	nop
   42d63:	c9                   	leave  
   42d64:	c3                   	ret    

0000000000042d65 <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   42d65:	55                   	push   %rbp
   42d66:	48 89 e5             	mov    %rsp,%rbp
   42d69:	41 54                	push   %r12
   42d6b:	53                   	push   %rbx
   42d6c:	48 83 ec 50          	sub    $0x50,%rsp
   42d70:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42d74:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42d78:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   42d7c:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
   42d80:	44 89 45 ac          	mov    %r8d,-0x54(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   42d84:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42d88:	25 ff 0f 00 00       	and    $0xfff,%eax
   42d8d:	48 85 c0             	test   %rax,%rax
   42d90:	74 14                	je     42da6 <virtual_memory_map+0x41>
   42d92:	ba 86 4e 04 00       	mov    $0x44e86,%edx
   42d97:	be 66 00 00 00       	mov    $0x66,%esi
   42d9c:	bf 95 4c 04 00       	mov    $0x44c95,%edi
   42da1:	e8 c0 fc ff ff       	call   42a66 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   42da6:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42daa:	25 ff 0f 00 00       	and    $0xfff,%eax
   42daf:	48 85 c0             	test   %rax,%rax
   42db2:	74 14                	je     42dc8 <virtual_memory_map+0x63>
   42db4:	ba 99 4e 04 00       	mov    $0x44e99,%edx
   42db9:	be 67 00 00 00       	mov    $0x67,%esi
   42dbe:	bf 95 4c 04 00       	mov    $0x44c95,%edi
   42dc3:	e8 9e fc ff ff       	call   42a66 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   42dc8:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42dcc:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42dd0:	48 01 d0             	add    %rdx,%rax
   42dd3:	48 3b 45 c0          	cmp    -0x40(%rbp),%rax
   42dd7:	73 24                	jae    42dfd <virtual_memory_map+0x98>
   42dd9:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42ddd:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42de1:	48 01 d0             	add    %rdx,%rax
   42de4:	48 85 c0             	test   %rax,%rax
   42de7:	74 14                	je     42dfd <virtual_memory_map+0x98>
   42de9:	ba ac 4e 04 00       	mov    $0x44eac,%edx
   42dee:	be 68 00 00 00       	mov    $0x68,%esi
   42df3:	bf 95 4c 04 00       	mov    $0x44c95,%edi
   42df8:	e8 69 fc ff ff       	call   42a66 <assert_fail>
    if (perm & PTE_P) {
   42dfd:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42e00:	48 98                	cltq   
   42e02:	83 e0 01             	and    $0x1,%eax
   42e05:	48 85 c0             	test   %rax,%rax
   42e08:	74 6e                	je     42e78 <virtual_memory_map+0x113>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   42e0a:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42e0e:	25 ff 0f 00 00       	and    $0xfff,%eax
   42e13:	48 85 c0             	test   %rax,%rax
   42e16:	74 14                	je     42e2c <virtual_memory_map+0xc7>
   42e18:	ba ca 4e 04 00       	mov    $0x44eca,%edx
   42e1d:	be 6a 00 00 00       	mov    $0x6a,%esi
   42e22:	bf 95 4c 04 00       	mov    $0x44c95,%edi
   42e27:	e8 3a fc ff ff       	call   42a66 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   42e2c:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42e30:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42e34:	48 01 d0             	add    %rdx,%rax
   42e37:	48 3b 45 b8          	cmp    -0x48(%rbp),%rax
   42e3b:	73 14                	jae    42e51 <virtual_memory_map+0xec>
   42e3d:	ba dd 4e 04 00       	mov    $0x44edd,%edx
   42e42:	be 6b 00 00 00       	mov    $0x6b,%esi
   42e47:	bf 95 4c 04 00       	mov    $0x44c95,%edi
   42e4c:	e8 15 fc ff ff       	call   42a66 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   42e51:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42e55:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42e59:	48 01 d0             	add    %rdx,%rax
   42e5c:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   42e62:	76 14                	jbe    42e78 <virtual_memory_map+0x113>
   42e64:	ba eb 4e 04 00       	mov    $0x44eeb,%edx
   42e69:	be 6c 00 00 00       	mov    $0x6c,%esi
   42e6e:	bf 95 4c 04 00       	mov    $0x44c95,%edi
   42e73:	e8 ee fb ff ff       	call   42a66 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   42e78:	83 7d ac 00          	cmpl   $0x0,-0x54(%rbp)
   42e7c:	78 09                	js     42e87 <virtual_memory_map+0x122>
   42e7e:	81 7d ac ff 0f 00 00 	cmpl   $0xfff,-0x54(%rbp)
   42e85:	7e 14                	jle    42e9b <virtual_memory_map+0x136>
   42e87:	ba 07 4f 04 00       	mov    $0x44f07,%edx
   42e8c:	be 6e 00 00 00       	mov    $0x6e,%esi
   42e91:	bf 95 4c 04 00       	mov    $0x44c95,%edi
   42e96:	e8 cb fb ff ff       	call   42a66 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   42e9b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42e9f:	25 ff 0f 00 00       	and    $0xfff,%eax
   42ea4:	48 85 c0             	test   %rax,%rax
   42ea7:	74 14                	je     42ebd <virtual_memory_map+0x158>
   42ea9:	ba 28 4f 04 00       	mov    $0x44f28,%edx
   42eae:	be 6f 00 00 00       	mov    $0x6f,%esi
   42eb3:	bf 95 4c 04 00       	mov    $0x44c95,%edi
   42eb8:	e8 a9 fb ff ff       	call   42a66 <assert_fail>

    int last_index123 = -1;
   42ebd:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%rbp)
    x86_64_pagetable* l1pagetable = NULL;
   42ec4:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
   42ecb:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42ecc:	e9 e7 00 00 00       	jmp    42fb8 <virtual_memory_map+0x253>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   42ed1:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42ed5:	48 c1 e8 15          	shr    $0x15,%rax
   42ed9:	89 45 dc             	mov    %eax,-0x24(%rbp)
        if (cur_index123 != last_index123) {
   42edc:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42edf:	3b 45 ec             	cmp    -0x14(%rbp),%eax
   42ee2:	74 20                	je     42f04 <virtual_memory_map+0x19f>
            // TODO --> done
            // find pointer to last level pagetable for current va

			l1pagetable = lookup_l1pagetable(pagetable, va, perm);	
   42ee4:	8b 55 ac             	mov    -0x54(%rbp),%edx
   42ee7:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   42eeb:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42eef:	48 89 ce             	mov    %rcx,%rsi
   42ef2:	48 89 c7             	mov    %rax,%rdi
   42ef5:	e8 d7 00 00 00       	call   42fd1 <lookup_l1pagetable>
   42efa:	48 89 45 e0          	mov    %rax,-0x20(%rbp)

            last_index123 = cur_index123;
   42efe:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42f01:	89 45 ec             	mov    %eax,-0x14(%rbp)
        }
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   42f04:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42f07:	48 98                	cltq   
   42f09:	83 e0 01             	and    $0x1,%eax
   42f0c:	48 85 c0             	test   %rax,%rax
   42f0f:	74 3a                	je     42f4b <virtual_memory_map+0x1e6>
   42f11:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42f16:	74 33                	je     42f4b <virtual_memory_map+0x1e6>
            // TODO --> done
            // map `pa` at appropriate entry with permissions `perm`
			l1pagetable->entry[L1PAGEINDEX(va)] =  (0x00000000FFFFFFFF & pa) | perm;
   42f18:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42f1c:	41 89 c4             	mov    %eax,%r12d
   42f1f:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42f22:	48 63 d8             	movslq %eax,%rbx
   42f25:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42f29:	be 03 00 00 00       	mov    $0x3,%esi
   42f2e:	48 89 c7             	mov    %rax,%rdi
   42f31:	e8 95 fb ff ff       	call   42acb <pageindex>
   42f36:	89 c2                	mov    %eax,%edx
   42f38:	4c 89 e1             	mov    %r12,%rcx
   42f3b:	48 09 d9             	or     %rbx,%rcx
   42f3e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42f42:	48 63 d2             	movslq %edx,%rdx
   42f45:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42f49:	eb 55                	jmp    42fa0 <virtual_memory_map+0x23b>

        } else if (l1pagetable) { // if page is NOT marked present
   42f4b:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42f50:	74 26                	je     42f78 <virtual_memory_map+0x213>
            // TODO --> done
            // map to address 0 with `perm`
			l1pagetable->entry[L1PAGEINDEX(va)] = 0 | perm;
   42f52:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42f56:	be 03 00 00 00       	mov    $0x3,%esi
   42f5b:	48 89 c7             	mov    %rax,%rdi
   42f5e:	e8 68 fb ff ff       	call   42acb <pageindex>
   42f63:	89 c2                	mov    %eax,%edx
   42f65:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42f68:	48 63 c8             	movslq %eax,%rcx
   42f6b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42f6f:	48 63 d2             	movslq %edx,%rdx
   42f72:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42f76:	eb 28                	jmp    42fa0 <virtual_memory_map+0x23b>

        } else if (perm & PTE_P) {
   42f78:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42f7b:	48 98                	cltq   
   42f7d:	83 e0 01             	and    $0x1,%eax
   42f80:	48 85 c0             	test   %rax,%rax
   42f83:	74 1b                	je     42fa0 <virtual_memory_map+0x23b>
            // error, no allocated l1 page found for va
            log_printf("[Kern Info] failed to find l1pagetable address at " __FILE__ ": %d\n", __LINE__);
   42f85:	be 8b 00 00 00       	mov    $0x8b,%esi
   42f8a:	bf 50 4f 04 00       	mov    $0x44f50,%edi
   42f8f:	b8 00 00 00 00       	mov    $0x0,%eax
   42f94:	e8 af f7 ff ff       	call   42748 <log_printf>
            return -1;
   42f99:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42f9e:	eb 28                	jmp    42fc8 <virtual_memory_map+0x263>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42fa0:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
   42fa7:	00 
   42fa8:	48 81 45 b8 00 10 00 	addq   $0x1000,-0x48(%rbp)
   42faf:	00 
   42fb0:	48 81 6d b0 00 10 00 	subq   $0x1000,-0x50(%rbp)
   42fb7:	00 
   42fb8:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   42fbd:	0f 85 0e ff ff ff    	jne    42ed1 <virtual_memory_map+0x16c>
        }
    }
    return 0;
   42fc3:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42fc8:	48 83 c4 50          	add    $0x50,%rsp
   42fcc:	5b                   	pop    %rbx
   42fcd:	41 5c                	pop    %r12
   42fcf:	5d                   	pop    %rbp
   42fd0:	c3                   	ret    

0000000000042fd1 <lookup_l1pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   42fd1:	55                   	push   %rbp
   42fd2:	48 89 e5             	mov    %rsp,%rbp
   42fd5:	48 83 ec 40          	sub    $0x40,%rsp
   42fd9:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42fdd:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42fe1:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   42fe4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42fe8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l1 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   42fec:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   42ff3:	e9 23 01 00 00       	jmp    4311b <lookup_l1pagetable+0x14a>
        // TODO --> done
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        x86_64_pageentry_t pe = pt->entry[PAGEINDEX(va, i)]; // replace this
   42ff8:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42ffb:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42fff:	89 d6                	mov    %edx,%esi
   43001:	48 89 c7             	mov    %rax,%rdi
   43004:	e8 c2 fa ff ff       	call   42acb <pageindex>
   43009:	89 c2                	mov    %eax,%edx
   4300b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4300f:	48 63 d2             	movslq %edx,%rdx
   43012:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   43016:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   4301a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4301e:	83 e0 01             	and    $0x1,%eax
   43021:	48 85 c0             	test   %rax,%rax
   43024:	75 63                	jne    43089 <lookup_l1pagetable+0xb8>
            log_printf("[Kern Info] Error looking up l1pagetable: Pagetable address: 0x%x perm: 0x%x."
   43026:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43029:	8d 48 02             	lea    0x2(%rax),%ecx
   4302c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43030:	25 ff 0f 00 00       	and    $0xfff,%eax
   43035:	48 89 c2             	mov    %rax,%rdx
   43038:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4303c:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43042:	48 89 c6             	mov    %rax,%rsi
   43045:	bf 98 4f 04 00       	mov    $0x44f98,%edi
   4304a:	b8 00 00 00 00       	mov    $0x0,%eax
   4304f:	e8 f4 f6 ff ff       	call   42748 <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   43054:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43057:	48 98                	cltq   
   43059:	83 e0 01             	and    $0x1,%eax
   4305c:	48 85 c0             	test   %rax,%rax
   4305f:	75 0a                	jne    4306b <lookup_l1pagetable+0x9a>
                return NULL;
   43061:	b8 00 00 00 00       	mov    $0x0,%eax
   43066:	e9 be 00 00 00       	jmp    43129 <lookup_l1pagetable+0x158>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   4306b:	be af 00 00 00       	mov    $0xaf,%esi
   43070:	bf 00 50 04 00       	mov    $0x45000,%edi
   43075:	b8 00 00 00 00       	mov    $0x0,%eax
   4307a:	e8 c9 f6 ff ff       	call   42748 <log_printf>
            return NULL;
   4307f:	b8 00 00 00 00       	mov    $0x0,%eax
   43084:	e9 a0 00 00 00       	jmp    43129 <lookup_l1pagetable+0x158>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   43089:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4308d:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43093:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   43099:	76 14                	jbe    430af <lookup_l1pagetable+0xde>
   4309b:	ba 48 50 04 00       	mov    $0x45048,%edx
   430a0:	be b4 00 00 00       	mov    $0xb4,%esi
   430a5:	bf 95 4c 04 00       	mov    $0x44c95,%edi
   430aa:	e8 b7 f9 ff ff       	call   42a66 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   430af:	8b 45 cc             	mov    -0x34(%rbp),%eax
   430b2:	48 98                	cltq   
   430b4:	83 e0 02             	and    $0x2,%eax
   430b7:	48 85 c0             	test   %rax,%rax
   430ba:	74 20                	je     430dc <lookup_l1pagetable+0x10b>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   430bc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   430c0:	83 e0 02             	and    $0x2,%eax
   430c3:	48 85 c0             	test   %rax,%rax
   430c6:	75 14                	jne    430dc <lookup_l1pagetable+0x10b>
   430c8:	ba 68 50 04 00       	mov    $0x45068,%edx
   430cd:	be b6 00 00 00       	mov    $0xb6,%esi
   430d2:	bf 95 4c 04 00       	mov    $0x44c95,%edi
   430d7:	e8 8a f9 ff ff       	call   42a66 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   430dc:	8b 45 cc             	mov    -0x34(%rbp),%eax
   430df:	48 98                	cltq   
   430e1:	83 e0 04             	and    $0x4,%eax
   430e4:	48 85 c0             	test   %rax,%rax
   430e7:	74 20                	je     43109 <lookup_l1pagetable+0x138>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   430e9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   430ed:	83 e0 04             	and    $0x4,%eax
   430f0:	48 85 c0             	test   %rax,%rax
   430f3:	75 14                	jne    43109 <lookup_l1pagetable+0x138>
   430f5:	ba 73 50 04 00       	mov    $0x45073,%edx
   430fa:	be b9 00 00 00       	mov    $0xb9,%esi
   430ff:	bf 95 4c 04 00       	mov    $0x44c95,%edi
   43104:	e8 5d f9 ff ff       	call   42a66 <assert_fail>
        }

        // TODO --> done
        // set pt to physical address to next pagetable using `pe`
        pt = (x86_64_pagetable *) PTE_ADDR(pe); // replace this
   43109:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4310d:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43113:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   43117:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   4311b:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   4311f:	0f 8e d3 fe ff ff    	jle    42ff8 <lookup_l1pagetable+0x27>
    }
    return pt;
   43125:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43129:	c9                   	leave  
   4312a:	c3                   	ret    

000000000004312b <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   4312b:	55                   	push   %rbp
   4312c:	48 89 e5             	mov    %rsp,%rbp
   4312f:	48 83 ec 50          	sub    $0x50,%rsp
   43133:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   43137:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   4313b:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   4313f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43143:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   43147:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   4314e:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   4314f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   43156:	eb 41                	jmp    43199 <virtual_memory_lookup+0x6e>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   43158:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4315b:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4315f:	89 d6                	mov    %edx,%esi
   43161:	48 89 c7             	mov    %rax,%rdi
   43164:	e8 62 f9 ff ff       	call   42acb <pageindex>
   43169:	89 c2                	mov    %eax,%edx
   4316b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4316f:	48 63 d2             	movslq %edx,%rdx
   43172:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   43176:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4317a:	83 e0 06             	and    $0x6,%eax
   4317d:	48 f7 d0             	not    %rax
   43180:	48 21 d0             	and    %rdx,%rax
   43183:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   43187:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4318b:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43191:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   43195:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   43199:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   4319d:	7f 0c                	jg     431ab <virtual_memory_lookup+0x80>
   4319f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   431a3:	83 e0 01             	and    $0x1,%eax
   431a6:	48 85 c0             	test   %rax,%rax
   431a9:	75 ad                	jne    43158 <virtual_memory_lookup+0x2d>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   431ab:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   431b2:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   431b9:	ff 
   431ba:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   431c1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   431c5:	83 e0 01             	and    $0x1,%eax
   431c8:	48 85 c0             	test   %rax,%rax
   431cb:	74 34                	je     43201 <virtual_memory_lookup+0xd6>
        vam.pn = PAGENUMBER(pe);
   431cd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   431d1:	48 c1 e8 0c          	shr    $0xc,%rax
   431d5:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   431d8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   431dc:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   431e2:	48 89 c2             	mov    %rax,%rdx
   431e5:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   431e9:	25 ff 0f 00 00       	and    $0xfff,%eax
   431ee:	48 09 d0             	or     %rdx,%rax
   431f1:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   431f5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   431f9:	25 ff 0f 00 00       	and    $0xfff,%eax
   431fe:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   43201:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43205:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   43209:	48 89 10             	mov    %rdx,(%rax)
   4320c:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   43210:	48 89 50 08          	mov    %rdx,0x8(%rax)
   43214:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43218:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   4321c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43220:	c9                   	leave  
   43221:	c3                   	ret    

0000000000043222 <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   43222:	55                   	push   %rbp
   43223:	48 89 e5             	mov    %rsp,%rbp
   43226:	48 83 ec 40          	sub    $0x40,%rsp
   4322a:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   4322e:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   43231:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   43235:	c7 45 f8 07 00 00 00 	movl   $0x7,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   4323c:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43240:	78 08                	js     4324a <program_load+0x28>
   43242:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   43245:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   43248:	7c 14                	jl     4325e <program_load+0x3c>
   4324a:	ba 80 50 04 00       	mov    $0x45080,%edx
   4324f:	be 37 00 00 00       	mov    $0x37,%esi
   43254:	bf b0 50 04 00       	mov    $0x450b0,%edi
   43259:	e8 08 f8 ff ff       	call   42a66 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   4325e:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   43261:	48 98                	cltq   
   43263:	48 c1 e0 04          	shl    $0x4,%rax
   43267:	48 05 20 60 04 00    	add    $0x46020,%rax
   4326d:	48 8b 00             	mov    (%rax),%rax
   43270:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   43274:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43278:	8b 00                	mov    (%rax),%eax
   4327a:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   4327f:	74 14                	je     43295 <program_load+0x73>
   43281:	ba c2 50 04 00       	mov    $0x450c2,%edx
   43286:	be 39 00 00 00       	mov    $0x39,%esi
   4328b:	bf b0 50 04 00       	mov    $0x450b0,%edi
   43290:	e8 d1 f7 ff ff       	call   42a66 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   43295:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43299:	48 8b 50 20          	mov    0x20(%rax),%rdx
   4329d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432a1:	48 01 d0             	add    %rdx,%rax
   432a4:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   432a8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   432af:	e9 94 00 00 00       	jmp    43348 <program_load+0x126>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   432b4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   432b7:	48 63 d0             	movslq %eax,%rdx
   432ba:	48 89 d0             	mov    %rdx,%rax
   432bd:	48 c1 e0 03          	shl    $0x3,%rax
   432c1:	48 29 d0             	sub    %rdx,%rax
   432c4:	48 c1 e0 03          	shl    $0x3,%rax
   432c8:	48 89 c2             	mov    %rax,%rdx
   432cb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   432cf:	48 01 d0             	add    %rdx,%rax
   432d2:	8b 00                	mov    (%rax),%eax
   432d4:	83 f8 01             	cmp    $0x1,%eax
   432d7:	75 6b                	jne    43344 <program_load+0x122>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   432d9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   432dc:	48 63 d0             	movslq %eax,%rdx
   432df:	48 89 d0             	mov    %rdx,%rax
   432e2:	48 c1 e0 03          	shl    $0x3,%rax
   432e6:	48 29 d0             	sub    %rdx,%rax
   432e9:	48 c1 e0 03          	shl    $0x3,%rax
   432ed:	48 89 c2             	mov    %rax,%rdx
   432f0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   432f4:	48 01 d0             	add    %rdx,%rax
   432f7:	48 8b 50 08          	mov    0x8(%rax),%rdx
   432fb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432ff:	48 01 d0             	add    %rdx,%rax
   43302:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   43306:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43309:	48 63 d0             	movslq %eax,%rdx
   4330c:	48 89 d0             	mov    %rdx,%rax
   4330f:	48 c1 e0 03          	shl    $0x3,%rax
   43313:	48 29 d0             	sub    %rdx,%rax
   43316:	48 c1 e0 03          	shl    $0x3,%rax
   4331a:	48 89 c2             	mov    %rax,%rdx
   4331d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43321:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   43325:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   43329:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   4332d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43331:	48 89 c7             	mov    %rax,%rdi
   43334:	e8 3d 00 00 00       	call   43376 <program_load_segment>
   43339:	85 c0                	test   %eax,%eax
   4333b:	79 07                	jns    43344 <program_load+0x122>
                return -1;
   4333d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43342:	eb 30                	jmp    43374 <program_load+0x152>
    for (int i = 0; i < eh->e_phnum; ++i) {
   43344:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   43348:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4334c:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   43350:	0f b7 c0             	movzwl %ax,%eax
   43353:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   43356:	0f 8c 58 ff ff ff    	jl     432b4 <program_load+0x92>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   4335c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43360:	48 8b 50 18          	mov    0x18(%rax),%rdx
   43364:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43368:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    return 0;
   4336f:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43374:	c9                   	leave  
   43375:	c3                   	ret    

0000000000043376 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   43376:	55                   	push   %rbp
   43377:	48 89 e5             	mov    %rsp,%rbp
   4337a:	48 83 ec 70          	sub    $0x70,%rsp
   4337e:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   43382:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   43386:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   4338a:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   4338e:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   43392:	48 8b 40 10          	mov    0x10(%rax),%rax
   43396:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   4339a:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   4339e:	48 8b 50 20          	mov    0x20(%rax),%rdx
   433a2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   433a6:	48 01 d0             	add    %rdx,%rax
   433a9:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   433ad:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   433b1:	48 8b 50 28          	mov    0x28(%rax),%rdx
   433b5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   433b9:	48 01 d0             	add    %rdx,%rax
   433bc:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   433c0:	48 81 65 e8 00 f0 ff 	andq   $0xfffffffffffff000,-0x18(%rbp)
   433c7:	ff 

	// virtual addressing
	for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   433c8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   433cc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   433d0:	e9 8f 00 00 00       	jmp    43464 <program_load_segment+0xee>
		uintptr_t pa;
		if (next_free_page(&pa) < 0
   433d5:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   433d9:	48 89 c7             	mov    %rax,%rdi
   433dc:	e8 e9 cf ff ff       	call   403ca <next_free_page>
   433e1:	85 c0                	test   %eax,%eax
   433e3:	78 45                	js     4342a <program_load_segment+0xb4>
			|| assign_physical_page(pa, p->p_pid) < 0
   433e5:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   433e9:	8b 00                	mov    (%rax),%eax
   433eb:	0f be d0             	movsbl %al,%edx
   433ee:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   433f2:	89 d6                	mov    %edx,%esi
   433f4:	48 89 c7             	mov    %rax,%rdi
   433f7:	e8 3b d2 ff ff       	call   40637 <assign_physical_page>
   433fc:	85 c0                	test   %eax,%eax
   433fe:	78 2a                	js     4342a <program_load_segment+0xb4>
			|| virtual_memory_map(p->p_pagetable, addr, pa, PAGESIZE, PTE_P | PTE_W | PTE_U) < 0) {
   43400:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   43404:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43408:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   4340f:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   43413:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43419:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4341e:	48 89 c7             	mov    %rax,%rdi
   43421:	e8 3f f9 ff ff       	call   42d65 <virtual_memory_map>
   43426:	85 c0                	test   %eax,%eax
   43428:	79 32                	jns    4345c <program_load_segment+0xe6>

			console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   4342a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4342e:	8b 00                	mov    (%rax),%eax
   43430:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43434:	49 89 d0             	mov    %rdx,%r8
   43437:	89 c1                	mov    %eax,%ecx
   43439:	ba e0 50 04 00       	mov    $0x450e0,%edx
   4343e:	be 00 c0 00 00       	mov    $0xc000,%esi
   43443:	bf e0 06 00 00       	mov    $0x6e0,%edi
   43448:	b8 00 00 00 00       	mov    $0x0,%eax
   4344d:	e8 a6 0f 00 00       	call   443f8 <console_printf>
			return -1;
   43452:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43457:	e9 e5 00 00 00       	jmp    43541 <program_load_segment+0x1cb>
	for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   4345c:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43463:	00 
   43464:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43468:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   4346c:	0f 82 63 ff ff ff    	jb     433d5 <program_load_segment+0x5f>
    *     }
    * }
	*/

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   43472:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43476:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   4347d:	48 89 c7             	mov    %rax,%rdi
   43480:	e8 af f7 ff ff       	call   42c34 <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   43485:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43489:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   4348d:	48 89 c2             	mov    %rax,%rdx
   43490:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43494:	48 8b 4d 98          	mov    -0x68(%rbp),%rcx
   43498:	48 89 ce             	mov    %rcx,%rsi
   4349b:	48 89 c7             	mov    %rax,%rdi
   4349e:	e8 a0 00 00 00       	call   43543 <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   434a3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   434a7:	48 2b 45 e0          	sub    -0x20(%rbp),%rax
   434ab:	48 89 c2             	mov    %rax,%rdx
   434ae:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   434b2:	be 00 00 00 00       	mov    $0x0,%esi
   434b7:	48 89 c7             	mov    %rax,%rdi
   434ba:	e8 82 01 00 00       	call   43641 <memset>

	// change to readonly permissions
	if ((ph->p_flags & ELF_PFLAG_WRITE) == 0) {
   434bf:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   434c3:	8b 40 04             	mov    0x4(%rax),%eax
   434c6:	83 e0 02             	and    $0x2,%eax
   434c9:	85 c0                	test   %eax,%eax
   434cb:	75 60                	jne    4352d <program_load_segment+0x1b7>
		for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   434cd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   434d1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   434d5:	eb 4c                	jmp    43523 <program_load_segment+0x1ad>
			vamapping map = virtual_memory_lookup(p->p_pagetable, addr);
   434d7:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   434db:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   434e2:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   434e6:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   434ea:	48 89 ce             	mov    %rcx,%rsi
   434ed:	48 89 c7             	mov    %rax,%rdi
   434f0:	e8 36 fc ff ff       	call   4312b <virtual_memory_lookup>
			virtual_memory_map(p->p_pagetable, addr, map.pa, PAGESIZE, PTE_P | PTE_U );
   434f5:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   434f9:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   434fd:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   43504:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   43508:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   4350e:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43513:	48 89 c7             	mov    %rax,%rdi
   43516:	e8 4a f8 ff ff       	call   42d65 <virtual_memory_map>
		for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   4351b:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   43522:	00 
   43523:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43527:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   4352b:	72 aa                	jb     434d7 <program_load_segment+0x161>
		}
	}

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   4352d:	48 8b 05 cc 1a 01 00 	mov    0x11acc(%rip),%rax        # 55000 <kernel_pagetable>
   43534:	48 89 c7             	mov    %rax,%rdi
   43537:	e8 f8 f6 ff ff       	call   42c34 <set_pagetable>
    return 0;
   4353c:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43541:	c9                   	leave  
   43542:	c3                   	ret    

0000000000043543 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   43543:	55                   	push   %rbp
   43544:	48 89 e5             	mov    %rsp,%rbp
   43547:	48 83 ec 28          	sub    $0x28,%rsp
   4354b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4354f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43553:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43557:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4355b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   4355f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43563:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43567:	eb 1c                	jmp    43585 <memcpy+0x42>
        *d = *s;
   43569:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4356d:	0f b6 10             	movzbl (%rax),%edx
   43570:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43574:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43576:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   4357b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43580:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   43585:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   4358a:	75 dd                	jne    43569 <memcpy+0x26>
    }
    return dst;
   4358c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43590:	c9                   	leave  
   43591:	c3                   	ret    

0000000000043592 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   43592:	55                   	push   %rbp
   43593:	48 89 e5             	mov    %rsp,%rbp
   43596:	48 83 ec 28          	sub    $0x28,%rsp
   4359a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4359e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   435a2:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   435a6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   435aa:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   435ae:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   435b2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   435b6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   435ba:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   435be:	73 6a                	jae    4362a <memmove+0x98>
   435c0:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   435c4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   435c8:	48 01 d0             	add    %rdx,%rax
   435cb:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   435cf:	73 59                	jae    4362a <memmove+0x98>
        s += n, d += n;
   435d1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   435d5:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   435d9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   435dd:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   435e1:	eb 17                	jmp    435fa <memmove+0x68>
            *--d = *--s;
   435e3:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   435e8:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   435ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   435f1:	0f b6 10             	movzbl (%rax),%edx
   435f4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435f8:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   435fa:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   435fe:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43602:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43606:	48 85 c0             	test   %rax,%rax
   43609:	75 d8                	jne    435e3 <memmove+0x51>
    if (s < d && s + n > d) {
   4360b:	eb 2e                	jmp    4363b <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   4360d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43611:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43615:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43619:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4361d:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43621:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   43625:	0f b6 12             	movzbl (%rdx),%edx
   43628:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   4362a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4362e:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43632:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43636:	48 85 c0             	test   %rax,%rax
   43639:	75 d2                	jne    4360d <memmove+0x7b>
        }
    }
    return dst;
   4363b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   4363f:	c9                   	leave  
   43640:	c3                   	ret    

0000000000043641 <memset>:

void* memset(void* v, int c, size_t n) {
   43641:	55                   	push   %rbp
   43642:	48 89 e5             	mov    %rsp,%rbp
   43645:	48 83 ec 28          	sub    $0x28,%rsp
   43649:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4364d:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   43650:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43654:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43658:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   4365c:	eb 15                	jmp    43673 <memset+0x32>
        *p = c;
   4365e:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43661:	89 c2                	mov    %eax,%edx
   43663:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43667:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43669:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   4366e:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43673:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43678:	75 e4                	jne    4365e <memset+0x1d>
    }
    return v;
   4367a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   4367e:	c9                   	leave  
   4367f:	c3                   	ret    

0000000000043680 <strlen>:

size_t strlen(const char* s) {
   43680:	55                   	push   %rbp
   43681:	48 89 e5             	mov    %rsp,%rbp
   43684:	48 83 ec 18          	sub    $0x18,%rsp
   43688:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   4368c:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43693:	00 
   43694:	eb 0a                	jmp    436a0 <strlen+0x20>
        ++n;
   43696:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   4369b:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   436a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   436a4:	0f b6 00             	movzbl (%rax),%eax
   436a7:	84 c0                	test   %al,%al
   436a9:	75 eb                	jne    43696 <strlen+0x16>
    }
    return n;
   436ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   436af:	c9                   	leave  
   436b0:	c3                   	ret    

00000000000436b1 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   436b1:	55                   	push   %rbp
   436b2:	48 89 e5             	mov    %rsp,%rbp
   436b5:	48 83 ec 20          	sub    $0x20,%rsp
   436b9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   436bd:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   436c1:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   436c8:	00 
   436c9:	eb 0a                	jmp    436d5 <strnlen+0x24>
        ++n;
   436cb:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   436d0:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   436d5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   436d9:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   436dd:	74 0b                	je     436ea <strnlen+0x39>
   436df:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   436e3:	0f b6 00             	movzbl (%rax),%eax
   436e6:	84 c0                	test   %al,%al
   436e8:	75 e1                	jne    436cb <strnlen+0x1a>
    }
    return n;
   436ea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   436ee:	c9                   	leave  
   436ef:	c3                   	ret    

00000000000436f0 <strcpy>:

char* strcpy(char* dst, const char* src) {
   436f0:	55                   	push   %rbp
   436f1:	48 89 e5             	mov    %rsp,%rbp
   436f4:	48 83 ec 20          	sub    $0x20,%rsp
   436f8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   436fc:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   43700:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43704:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   43708:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   4370c:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43710:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43714:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43718:	48 8d 48 01          	lea    0x1(%rax),%rcx
   4371c:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   43720:	0f b6 12             	movzbl (%rdx),%edx
   43723:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   43725:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43729:	48 83 e8 01          	sub    $0x1,%rax
   4372d:	0f b6 00             	movzbl (%rax),%eax
   43730:	84 c0                	test   %al,%al
   43732:	75 d4                	jne    43708 <strcpy+0x18>
    return dst;
   43734:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43738:	c9                   	leave  
   43739:	c3                   	ret    

000000000004373a <strcmp>:

int strcmp(const char* a, const char* b) {
   4373a:	55                   	push   %rbp
   4373b:	48 89 e5             	mov    %rsp,%rbp
   4373e:	48 83 ec 10          	sub    $0x10,%rsp
   43742:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43746:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   4374a:	eb 0a                	jmp    43756 <strcmp+0x1c>
        ++a, ++b;
   4374c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43751:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43756:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4375a:	0f b6 00             	movzbl (%rax),%eax
   4375d:	84 c0                	test   %al,%al
   4375f:	74 1d                	je     4377e <strcmp+0x44>
   43761:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43765:	0f b6 00             	movzbl (%rax),%eax
   43768:	84 c0                	test   %al,%al
   4376a:	74 12                	je     4377e <strcmp+0x44>
   4376c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43770:	0f b6 10             	movzbl (%rax),%edx
   43773:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43777:	0f b6 00             	movzbl (%rax),%eax
   4377a:	38 c2                	cmp    %al,%dl
   4377c:	74 ce                	je     4374c <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   4377e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43782:	0f b6 00             	movzbl (%rax),%eax
   43785:	89 c2                	mov    %eax,%edx
   43787:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4378b:	0f b6 00             	movzbl (%rax),%eax
   4378e:	38 d0                	cmp    %dl,%al
   43790:	0f 92 c0             	setb   %al
   43793:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   43796:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4379a:	0f b6 00             	movzbl (%rax),%eax
   4379d:	89 c1                	mov    %eax,%ecx
   4379f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   437a3:	0f b6 00             	movzbl (%rax),%eax
   437a6:	38 c1                	cmp    %al,%cl
   437a8:	0f 92 c0             	setb   %al
   437ab:	0f b6 c0             	movzbl %al,%eax
   437ae:	29 c2                	sub    %eax,%edx
   437b0:	89 d0                	mov    %edx,%eax
}
   437b2:	c9                   	leave  
   437b3:	c3                   	ret    

00000000000437b4 <strchr>:

char* strchr(const char* s, int c) {
   437b4:	55                   	push   %rbp
   437b5:	48 89 e5             	mov    %rsp,%rbp
   437b8:	48 83 ec 10          	sub    $0x10,%rsp
   437bc:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   437c0:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   437c3:	eb 05                	jmp    437ca <strchr+0x16>
        ++s;
   437c5:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   437ca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   437ce:	0f b6 00             	movzbl (%rax),%eax
   437d1:	84 c0                	test   %al,%al
   437d3:	74 0e                	je     437e3 <strchr+0x2f>
   437d5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   437d9:	0f b6 00             	movzbl (%rax),%eax
   437dc:	8b 55 f4             	mov    -0xc(%rbp),%edx
   437df:	38 d0                	cmp    %dl,%al
   437e1:	75 e2                	jne    437c5 <strchr+0x11>
    }
    if (*s == (char) c) {
   437e3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   437e7:	0f b6 00             	movzbl (%rax),%eax
   437ea:	8b 55 f4             	mov    -0xc(%rbp),%edx
   437ed:	38 d0                	cmp    %dl,%al
   437ef:	75 06                	jne    437f7 <strchr+0x43>
        return (char*) s;
   437f1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   437f5:	eb 05                	jmp    437fc <strchr+0x48>
    } else {
        return NULL;
   437f7:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   437fc:	c9                   	leave  
   437fd:	c3                   	ret    

00000000000437fe <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   437fe:	55                   	push   %rbp
   437ff:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   43802:	8b 05 f8 77 01 00    	mov    0x177f8(%rip),%eax        # 5b000 <rand_seed_set>
   43808:	85 c0                	test   %eax,%eax
   4380a:	75 0a                	jne    43816 <rand+0x18>
        srand(819234718U);
   4380c:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   43811:	e8 24 00 00 00       	call   4383a <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   43816:	8b 05 e8 77 01 00    	mov    0x177e8(%rip),%eax        # 5b004 <rand_seed>
   4381c:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   43822:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   43827:	89 05 d7 77 01 00    	mov    %eax,0x177d7(%rip)        # 5b004 <rand_seed>
    return rand_seed & RAND_MAX;
   4382d:	8b 05 d1 77 01 00    	mov    0x177d1(%rip),%eax        # 5b004 <rand_seed>
   43833:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   43838:	5d                   	pop    %rbp
   43839:	c3                   	ret    

000000000004383a <srand>:

void srand(unsigned seed) {
   4383a:	55                   	push   %rbp
   4383b:	48 89 e5             	mov    %rsp,%rbp
   4383e:	48 83 ec 08          	sub    $0x8,%rsp
   43842:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   43845:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43848:	89 05 b6 77 01 00    	mov    %eax,0x177b6(%rip)        # 5b004 <rand_seed>
    rand_seed_set = 1;
   4384e:	c7 05 a8 77 01 00 01 	movl   $0x1,0x177a8(%rip)        # 5b000 <rand_seed_set>
   43855:	00 00 00 
}
   43858:	90                   	nop
   43859:	c9                   	leave  
   4385a:	c3                   	ret    

000000000004385b <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   4385b:	55                   	push   %rbp
   4385c:	48 89 e5             	mov    %rsp,%rbp
   4385f:	48 83 ec 28          	sub    $0x28,%rsp
   43863:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43867:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   4386b:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   4386e:	48 c7 45 f8 00 53 04 	movq   $0x45300,-0x8(%rbp)
   43875:	00 
    if (base < 0) {
   43876:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   4387a:	79 0b                	jns    43887 <fill_numbuf+0x2c>
        digits = lower_digits;
   4387c:	48 c7 45 f8 20 53 04 	movq   $0x45320,-0x8(%rbp)
   43883:	00 
        base = -base;
   43884:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   43887:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   4388c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43890:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   43893:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43896:	48 63 c8             	movslq %eax,%rcx
   43899:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4389d:	ba 00 00 00 00       	mov    $0x0,%edx
   438a2:	48 f7 f1             	div    %rcx
   438a5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   438a9:	48 01 d0             	add    %rdx,%rax
   438ac:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   438b1:	0f b6 10             	movzbl (%rax),%edx
   438b4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   438b8:	88 10                	mov    %dl,(%rax)
        val /= base;
   438ba:	8b 45 dc             	mov    -0x24(%rbp),%eax
   438bd:	48 63 f0             	movslq %eax,%rsi
   438c0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   438c4:	ba 00 00 00 00       	mov    $0x0,%edx
   438c9:	48 f7 f6             	div    %rsi
   438cc:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   438d0:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   438d5:	75 bc                	jne    43893 <fill_numbuf+0x38>
    return numbuf_end;
   438d7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   438db:	c9                   	leave  
   438dc:	c3                   	ret    

00000000000438dd <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   438dd:	55                   	push   %rbp
   438de:	48 89 e5             	mov    %rsp,%rbp
   438e1:	53                   	push   %rbx
   438e2:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   438e9:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   438f0:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   438f6:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   438fd:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   43904:	e9 8a 09 00 00       	jmp    44293 <printer_vprintf+0x9b6>
        if (*format != '%') {
   43909:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43910:	0f b6 00             	movzbl (%rax),%eax
   43913:	3c 25                	cmp    $0x25,%al
   43915:	74 31                	je     43948 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
   43917:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4391e:	4c 8b 00             	mov    (%rax),%r8
   43921:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43928:	0f b6 00             	movzbl (%rax),%eax
   4392b:	0f b6 c8             	movzbl %al,%ecx
   4392e:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43934:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4393b:	89 ce                	mov    %ecx,%esi
   4393d:	48 89 c7             	mov    %rax,%rdi
   43940:	41 ff d0             	call   *%r8
            continue;
   43943:	e9 43 09 00 00       	jmp    4428b <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
   43948:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   4394f:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43956:	01 
   43957:	eb 44                	jmp    4399d <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
   43959:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43960:	0f b6 00             	movzbl (%rax),%eax
   43963:	0f be c0             	movsbl %al,%eax
   43966:	89 c6                	mov    %eax,%esi
   43968:	bf 20 51 04 00       	mov    $0x45120,%edi
   4396d:	e8 42 fe ff ff       	call   437b4 <strchr>
   43972:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   43976:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   4397b:	74 30                	je     439ad <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
   4397d:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   43981:	48 2d 20 51 04 00    	sub    $0x45120,%rax
   43987:	ba 01 00 00 00       	mov    $0x1,%edx
   4398c:	89 c1                	mov    %eax,%ecx
   4398e:	d3 e2                	shl    %cl,%edx
   43990:	89 d0                	mov    %edx,%eax
   43992:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   43995:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4399c:	01 
   4399d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   439a4:	0f b6 00             	movzbl (%rax),%eax
   439a7:	84 c0                	test   %al,%al
   439a9:	75 ae                	jne    43959 <printer_vprintf+0x7c>
   439ab:	eb 01                	jmp    439ae <printer_vprintf+0xd1>
            } else {
                break;
   439ad:	90                   	nop
            }
        }

        // process width
        int width = -1;
   439ae:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   439b5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   439bc:	0f b6 00             	movzbl (%rax),%eax
   439bf:	3c 30                	cmp    $0x30,%al
   439c1:	7e 67                	jle    43a2a <printer_vprintf+0x14d>
   439c3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   439ca:	0f b6 00             	movzbl (%rax),%eax
   439cd:	3c 39                	cmp    $0x39,%al
   439cf:	7f 59                	jg     43a2a <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   439d1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   439d8:	eb 2e                	jmp    43a08 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
   439da:	8b 55 e8             	mov    -0x18(%rbp),%edx
   439dd:	89 d0                	mov    %edx,%eax
   439df:	c1 e0 02             	shl    $0x2,%eax
   439e2:	01 d0                	add    %edx,%eax
   439e4:	01 c0                	add    %eax,%eax
   439e6:	89 c1                	mov    %eax,%ecx
   439e8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   439ef:	48 8d 50 01          	lea    0x1(%rax),%rdx
   439f3:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   439fa:	0f b6 00             	movzbl (%rax),%eax
   439fd:	0f be c0             	movsbl %al,%eax
   43a00:	01 c8                	add    %ecx,%eax
   43a02:	83 e8 30             	sub    $0x30,%eax
   43a05:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43a08:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43a0f:	0f b6 00             	movzbl (%rax),%eax
   43a12:	3c 2f                	cmp    $0x2f,%al
   43a14:	0f 8e 85 00 00 00    	jle    43a9f <printer_vprintf+0x1c2>
   43a1a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43a21:	0f b6 00             	movzbl (%rax),%eax
   43a24:	3c 39                	cmp    $0x39,%al
   43a26:	7e b2                	jle    439da <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
   43a28:	eb 75                	jmp    43a9f <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
   43a2a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43a31:	0f b6 00             	movzbl (%rax),%eax
   43a34:	3c 2a                	cmp    $0x2a,%al
   43a36:	75 68                	jne    43aa0 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
   43a38:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a3f:	8b 00                	mov    (%rax),%eax
   43a41:	83 f8 2f             	cmp    $0x2f,%eax
   43a44:	77 30                	ja     43a76 <printer_vprintf+0x199>
   43a46:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a4d:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43a51:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a58:	8b 00                	mov    (%rax),%eax
   43a5a:	89 c0                	mov    %eax,%eax
   43a5c:	48 01 d0             	add    %rdx,%rax
   43a5f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43a66:	8b 12                	mov    (%rdx),%edx
   43a68:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43a6b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43a72:	89 0a                	mov    %ecx,(%rdx)
   43a74:	eb 1a                	jmp    43a90 <printer_vprintf+0x1b3>
   43a76:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a7d:	48 8b 40 08          	mov    0x8(%rax),%rax
   43a81:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43a85:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43a8c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43a90:	8b 00                	mov    (%rax),%eax
   43a92:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   43a95:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43a9c:	01 
   43a9d:	eb 01                	jmp    43aa0 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
   43a9f:	90                   	nop
        }

        // process precision
        int precision = -1;
   43aa0:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   43aa7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43aae:	0f b6 00             	movzbl (%rax),%eax
   43ab1:	3c 2e                	cmp    $0x2e,%al
   43ab3:	0f 85 00 01 00 00    	jne    43bb9 <printer_vprintf+0x2dc>
            ++format;
   43ab9:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43ac0:	01 
            if (*format >= '0' && *format <= '9') {
   43ac1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43ac8:	0f b6 00             	movzbl (%rax),%eax
   43acb:	3c 2f                	cmp    $0x2f,%al
   43acd:	7e 67                	jle    43b36 <printer_vprintf+0x259>
   43acf:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43ad6:	0f b6 00             	movzbl (%rax),%eax
   43ad9:	3c 39                	cmp    $0x39,%al
   43adb:	7f 59                	jg     43b36 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43add:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   43ae4:	eb 2e                	jmp    43b14 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
   43ae6:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   43ae9:	89 d0                	mov    %edx,%eax
   43aeb:	c1 e0 02             	shl    $0x2,%eax
   43aee:	01 d0                	add    %edx,%eax
   43af0:	01 c0                	add    %eax,%eax
   43af2:	89 c1                	mov    %eax,%ecx
   43af4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43afb:	48 8d 50 01          	lea    0x1(%rax),%rdx
   43aff:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43b06:	0f b6 00             	movzbl (%rax),%eax
   43b09:	0f be c0             	movsbl %al,%eax
   43b0c:	01 c8                	add    %ecx,%eax
   43b0e:	83 e8 30             	sub    $0x30,%eax
   43b11:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43b14:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43b1b:	0f b6 00             	movzbl (%rax),%eax
   43b1e:	3c 2f                	cmp    $0x2f,%al
   43b20:	0f 8e 85 00 00 00    	jle    43bab <printer_vprintf+0x2ce>
   43b26:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43b2d:	0f b6 00             	movzbl (%rax),%eax
   43b30:	3c 39                	cmp    $0x39,%al
   43b32:	7e b2                	jle    43ae6 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
   43b34:	eb 75                	jmp    43bab <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
   43b36:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43b3d:	0f b6 00             	movzbl (%rax),%eax
   43b40:	3c 2a                	cmp    $0x2a,%al
   43b42:	75 68                	jne    43bac <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
   43b44:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b4b:	8b 00                	mov    (%rax),%eax
   43b4d:	83 f8 2f             	cmp    $0x2f,%eax
   43b50:	77 30                	ja     43b82 <printer_vprintf+0x2a5>
   43b52:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b59:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43b5d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b64:	8b 00                	mov    (%rax),%eax
   43b66:	89 c0                	mov    %eax,%eax
   43b68:	48 01 d0             	add    %rdx,%rax
   43b6b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43b72:	8b 12                	mov    (%rdx),%edx
   43b74:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43b77:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43b7e:	89 0a                	mov    %ecx,(%rdx)
   43b80:	eb 1a                	jmp    43b9c <printer_vprintf+0x2bf>
   43b82:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b89:	48 8b 40 08          	mov    0x8(%rax),%rax
   43b8d:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43b91:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43b98:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43b9c:	8b 00                	mov    (%rax),%eax
   43b9e:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   43ba1:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43ba8:	01 
   43ba9:	eb 01                	jmp    43bac <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
   43bab:	90                   	nop
            }
            if (precision < 0) {
   43bac:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   43bb0:	79 07                	jns    43bb9 <printer_vprintf+0x2dc>
                precision = 0;
   43bb2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   43bb9:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   43bc0:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   43bc7:	00 
        int length = 0;
   43bc8:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   43bcf:	48 c7 45 c8 26 51 04 	movq   $0x45126,-0x38(%rbp)
   43bd6:	00 
    again:
        switch (*format) {
   43bd7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43bde:	0f b6 00             	movzbl (%rax),%eax
   43be1:	0f be c0             	movsbl %al,%eax
   43be4:	83 e8 43             	sub    $0x43,%eax
   43be7:	83 f8 37             	cmp    $0x37,%eax
   43bea:	0f 87 9f 03 00 00    	ja     43f8f <printer_vprintf+0x6b2>
   43bf0:	89 c0                	mov    %eax,%eax
   43bf2:	48 8b 04 c5 38 51 04 	mov    0x45138(,%rax,8),%rax
   43bf9:	00 
   43bfa:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
   43bfc:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   43c03:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43c0a:	01 
            goto again;
   43c0b:	eb ca                	jmp    43bd7 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   43c0d:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43c11:	74 5d                	je     43c70 <printer_vprintf+0x393>
   43c13:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c1a:	8b 00                	mov    (%rax),%eax
   43c1c:	83 f8 2f             	cmp    $0x2f,%eax
   43c1f:	77 30                	ja     43c51 <printer_vprintf+0x374>
   43c21:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c28:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43c2c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c33:	8b 00                	mov    (%rax),%eax
   43c35:	89 c0                	mov    %eax,%eax
   43c37:	48 01 d0             	add    %rdx,%rax
   43c3a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c41:	8b 12                	mov    (%rdx),%edx
   43c43:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43c46:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c4d:	89 0a                	mov    %ecx,(%rdx)
   43c4f:	eb 1a                	jmp    43c6b <printer_vprintf+0x38e>
   43c51:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c58:	48 8b 40 08          	mov    0x8(%rax),%rax
   43c5c:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43c60:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c67:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43c6b:	48 8b 00             	mov    (%rax),%rax
   43c6e:	eb 5c                	jmp    43ccc <printer_vprintf+0x3ef>
   43c70:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c77:	8b 00                	mov    (%rax),%eax
   43c79:	83 f8 2f             	cmp    $0x2f,%eax
   43c7c:	77 30                	ja     43cae <printer_vprintf+0x3d1>
   43c7e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c85:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43c89:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c90:	8b 00                	mov    (%rax),%eax
   43c92:	89 c0                	mov    %eax,%eax
   43c94:	48 01 d0             	add    %rdx,%rax
   43c97:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c9e:	8b 12                	mov    (%rdx),%edx
   43ca0:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43ca3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43caa:	89 0a                	mov    %ecx,(%rdx)
   43cac:	eb 1a                	jmp    43cc8 <printer_vprintf+0x3eb>
   43cae:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43cb5:	48 8b 40 08          	mov    0x8(%rax),%rax
   43cb9:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43cbd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43cc4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43cc8:	8b 00                	mov    (%rax),%eax
   43cca:	48 98                	cltq   
   43ccc:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   43cd0:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43cd4:	48 c1 f8 38          	sar    $0x38,%rax
   43cd8:	25 80 00 00 00       	and    $0x80,%eax
   43cdd:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   43ce0:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   43ce4:	74 09                	je     43cef <printer_vprintf+0x412>
   43ce6:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43cea:	48 f7 d8             	neg    %rax
   43ced:	eb 04                	jmp    43cf3 <printer_vprintf+0x416>
   43cef:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43cf3:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   43cf7:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   43cfa:	83 c8 60             	or     $0x60,%eax
   43cfd:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   43d00:	e9 cf 02 00 00       	jmp    43fd4 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   43d05:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43d09:	74 5d                	je     43d68 <printer_vprintf+0x48b>
   43d0b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d12:	8b 00                	mov    (%rax),%eax
   43d14:	83 f8 2f             	cmp    $0x2f,%eax
   43d17:	77 30                	ja     43d49 <printer_vprintf+0x46c>
   43d19:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d20:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43d24:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d2b:	8b 00                	mov    (%rax),%eax
   43d2d:	89 c0                	mov    %eax,%eax
   43d2f:	48 01 d0             	add    %rdx,%rax
   43d32:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d39:	8b 12                	mov    (%rdx),%edx
   43d3b:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43d3e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d45:	89 0a                	mov    %ecx,(%rdx)
   43d47:	eb 1a                	jmp    43d63 <printer_vprintf+0x486>
   43d49:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d50:	48 8b 40 08          	mov    0x8(%rax),%rax
   43d54:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43d58:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d5f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43d63:	48 8b 00             	mov    (%rax),%rax
   43d66:	eb 5c                	jmp    43dc4 <printer_vprintf+0x4e7>
   43d68:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d6f:	8b 00                	mov    (%rax),%eax
   43d71:	83 f8 2f             	cmp    $0x2f,%eax
   43d74:	77 30                	ja     43da6 <printer_vprintf+0x4c9>
   43d76:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d7d:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43d81:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d88:	8b 00                	mov    (%rax),%eax
   43d8a:	89 c0                	mov    %eax,%eax
   43d8c:	48 01 d0             	add    %rdx,%rax
   43d8f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d96:	8b 12                	mov    (%rdx),%edx
   43d98:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43d9b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43da2:	89 0a                	mov    %ecx,(%rdx)
   43da4:	eb 1a                	jmp    43dc0 <printer_vprintf+0x4e3>
   43da6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43dad:	48 8b 40 08          	mov    0x8(%rax),%rax
   43db1:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43db5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43dbc:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43dc0:	8b 00                	mov    (%rax),%eax
   43dc2:	89 c0                	mov    %eax,%eax
   43dc4:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   43dc8:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   43dcc:	e9 03 02 00 00       	jmp    43fd4 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
   43dd1:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   43dd8:	e9 28 ff ff ff       	jmp    43d05 <printer_vprintf+0x428>
        case 'X':
            base = 16;
   43ddd:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   43de4:	e9 1c ff ff ff       	jmp    43d05 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   43de9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43df0:	8b 00                	mov    (%rax),%eax
   43df2:	83 f8 2f             	cmp    $0x2f,%eax
   43df5:	77 30                	ja     43e27 <printer_vprintf+0x54a>
   43df7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43dfe:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43e02:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e09:	8b 00                	mov    (%rax),%eax
   43e0b:	89 c0                	mov    %eax,%eax
   43e0d:	48 01 d0             	add    %rdx,%rax
   43e10:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e17:	8b 12                	mov    (%rdx),%edx
   43e19:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43e1c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e23:	89 0a                	mov    %ecx,(%rdx)
   43e25:	eb 1a                	jmp    43e41 <printer_vprintf+0x564>
   43e27:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e2e:	48 8b 40 08          	mov    0x8(%rax),%rax
   43e32:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43e36:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e3d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43e41:	48 8b 00             	mov    (%rax),%rax
   43e44:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   43e48:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   43e4f:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   43e56:	e9 79 01 00 00       	jmp    43fd4 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
   43e5b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e62:	8b 00                	mov    (%rax),%eax
   43e64:	83 f8 2f             	cmp    $0x2f,%eax
   43e67:	77 30                	ja     43e99 <printer_vprintf+0x5bc>
   43e69:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e70:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43e74:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e7b:	8b 00                	mov    (%rax),%eax
   43e7d:	89 c0                	mov    %eax,%eax
   43e7f:	48 01 d0             	add    %rdx,%rax
   43e82:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e89:	8b 12                	mov    (%rdx),%edx
   43e8b:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43e8e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e95:	89 0a                	mov    %ecx,(%rdx)
   43e97:	eb 1a                	jmp    43eb3 <printer_vprintf+0x5d6>
   43e99:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ea0:	48 8b 40 08          	mov    0x8(%rax),%rax
   43ea4:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43ea8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43eaf:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43eb3:	48 8b 00             	mov    (%rax),%rax
   43eb6:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   43eba:	e9 15 01 00 00       	jmp    43fd4 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
   43ebf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ec6:	8b 00                	mov    (%rax),%eax
   43ec8:	83 f8 2f             	cmp    $0x2f,%eax
   43ecb:	77 30                	ja     43efd <printer_vprintf+0x620>
   43ecd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ed4:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43ed8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43edf:	8b 00                	mov    (%rax),%eax
   43ee1:	89 c0                	mov    %eax,%eax
   43ee3:	48 01 d0             	add    %rdx,%rax
   43ee6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43eed:	8b 12                	mov    (%rdx),%edx
   43eef:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43ef2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43ef9:	89 0a                	mov    %ecx,(%rdx)
   43efb:	eb 1a                	jmp    43f17 <printer_vprintf+0x63a>
   43efd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f04:	48 8b 40 08          	mov    0x8(%rax),%rax
   43f08:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43f0c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f13:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43f17:	8b 00                	mov    (%rax),%eax
   43f19:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   43f1f:	e9 67 03 00 00       	jmp    4428b <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
   43f24:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43f28:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   43f2c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f33:	8b 00                	mov    (%rax),%eax
   43f35:	83 f8 2f             	cmp    $0x2f,%eax
   43f38:	77 30                	ja     43f6a <printer_vprintf+0x68d>
   43f3a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f41:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43f45:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f4c:	8b 00                	mov    (%rax),%eax
   43f4e:	89 c0                	mov    %eax,%eax
   43f50:	48 01 d0             	add    %rdx,%rax
   43f53:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f5a:	8b 12                	mov    (%rdx),%edx
   43f5c:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43f5f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f66:	89 0a                	mov    %ecx,(%rdx)
   43f68:	eb 1a                	jmp    43f84 <printer_vprintf+0x6a7>
   43f6a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f71:	48 8b 40 08          	mov    0x8(%rax),%rax
   43f75:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43f79:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f80:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43f84:	8b 00                	mov    (%rax),%eax
   43f86:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   43f89:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   43f8d:	eb 45                	jmp    43fd4 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
   43f8f:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43f93:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   43f97:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f9e:	0f b6 00             	movzbl (%rax),%eax
   43fa1:	84 c0                	test   %al,%al
   43fa3:	74 0c                	je     43fb1 <printer_vprintf+0x6d4>
   43fa5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43fac:	0f b6 00             	movzbl (%rax),%eax
   43faf:	eb 05                	jmp    43fb6 <printer_vprintf+0x6d9>
   43fb1:	b8 25 00 00 00       	mov    $0x25,%eax
   43fb6:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   43fb9:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   43fbd:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43fc4:	0f b6 00             	movzbl (%rax),%eax
   43fc7:	84 c0                	test   %al,%al
   43fc9:	75 08                	jne    43fd3 <printer_vprintf+0x6f6>
                format--;
   43fcb:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   43fd2:	01 
            }
            break;
   43fd3:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   43fd4:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43fd7:	83 e0 20             	and    $0x20,%eax
   43fda:	85 c0                	test   %eax,%eax
   43fdc:	74 1e                	je     43ffc <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   43fde:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43fe2:	48 83 c0 18          	add    $0x18,%rax
   43fe6:	8b 55 e0             	mov    -0x20(%rbp),%edx
   43fe9:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   43fed:	48 89 ce             	mov    %rcx,%rsi
   43ff0:	48 89 c7             	mov    %rax,%rdi
   43ff3:	e8 63 f8 ff ff       	call   4385b <fill_numbuf>
   43ff8:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   43ffc:	48 c7 45 c0 26 51 04 	movq   $0x45126,-0x40(%rbp)
   44003:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   44004:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44007:	83 e0 20             	and    $0x20,%eax
   4400a:	85 c0                	test   %eax,%eax
   4400c:	74 48                	je     44056 <printer_vprintf+0x779>
   4400e:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44011:	83 e0 40             	and    $0x40,%eax
   44014:	85 c0                	test   %eax,%eax
   44016:	74 3e                	je     44056 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
   44018:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4401b:	25 80 00 00 00       	and    $0x80,%eax
   44020:	85 c0                	test   %eax,%eax
   44022:	74 0a                	je     4402e <printer_vprintf+0x751>
                prefix = "-";
   44024:	48 c7 45 c0 27 51 04 	movq   $0x45127,-0x40(%rbp)
   4402b:	00 
            if (flags & FLAG_NEGATIVE) {
   4402c:	eb 73                	jmp    440a1 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   4402e:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44031:	83 e0 10             	and    $0x10,%eax
   44034:	85 c0                	test   %eax,%eax
   44036:	74 0a                	je     44042 <printer_vprintf+0x765>
                prefix = "+";
   44038:	48 c7 45 c0 29 51 04 	movq   $0x45129,-0x40(%rbp)
   4403f:	00 
            if (flags & FLAG_NEGATIVE) {
   44040:	eb 5f                	jmp    440a1 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   44042:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44045:	83 e0 08             	and    $0x8,%eax
   44048:	85 c0                	test   %eax,%eax
   4404a:	74 55                	je     440a1 <printer_vprintf+0x7c4>
                prefix = " ";
   4404c:	48 c7 45 c0 2b 51 04 	movq   $0x4512b,-0x40(%rbp)
   44053:	00 
            if (flags & FLAG_NEGATIVE) {
   44054:	eb 4b                	jmp    440a1 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   44056:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44059:	83 e0 20             	and    $0x20,%eax
   4405c:	85 c0                	test   %eax,%eax
   4405e:	74 42                	je     440a2 <printer_vprintf+0x7c5>
   44060:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44063:	83 e0 01             	and    $0x1,%eax
   44066:	85 c0                	test   %eax,%eax
   44068:	74 38                	je     440a2 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
   4406a:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   4406e:	74 06                	je     44076 <printer_vprintf+0x799>
   44070:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   44074:	75 2c                	jne    440a2 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
   44076:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   4407b:	75 0c                	jne    44089 <printer_vprintf+0x7ac>
   4407d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44080:	25 00 01 00 00       	and    $0x100,%eax
   44085:	85 c0                	test   %eax,%eax
   44087:	74 19                	je     440a2 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
   44089:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   4408d:	75 07                	jne    44096 <printer_vprintf+0x7b9>
   4408f:	b8 2d 51 04 00       	mov    $0x4512d,%eax
   44094:	eb 05                	jmp    4409b <printer_vprintf+0x7be>
   44096:	b8 30 51 04 00       	mov    $0x45130,%eax
   4409b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   4409f:	eb 01                	jmp    440a2 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
   440a1:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   440a2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   440a6:	78 24                	js     440cc <printer_vprintf+0x7ef>
   440a8:	8b 45 ec             	mov    -0x14(%rbp),%eax
   440ab:	83 e0 20             	and    $0x20,%eax
   440ae:	85 c0                	test   %eax,%eax
   440b0:	75 1a                	jne    440cc <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
   440b2:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   440b5:	48 63 d0             	movslq %eax,%rdx
   440b8:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   440bc:	48 89 d6             	mov    %rdx,%rsi
   440bf:	48 89 c7             	mov    %rax,%rdi
   440c2:	e8 ea f5 ff ff       	call   436b1 <strnlen>
   440c7:	89 45 bc             	mov    %eax,-0x44(%rbp)
   440ca:	eb 0f                	jmp    440db <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
   440cc:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   440d0:	48 89 c7             	mov    %rax,%rdi
   440d3:	e8 a8 f5 ff ff       	call   43680 <strlen>
   440d8:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   440db:	8b 45 ec             	mov    -0x14(%rbp),%eax
   440de:	83 e0 20             	and    $0x20,%eax
   440e1:	85 c0                	test   %eax,%eax
   440e3:	74 20                	je     44105 <printer_vprintf+0x828>
   440e5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   440e9:	78 1a                	js     44105 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
   440eb:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   440ee:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   440f1:	7e 08                	jle    440fb <printer_vprintf+0x81e>
   440f3:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   440f6:	2b 45 bc             	sub    -0x44(%rbp),%eax
   440f9:	eb 05                	jmp    44100 <printer_vprintf+0x823>
   440fb:	b8 00 00 00 00       	mov    $0x0,%eax
   44100:	89 45 b8             	mov    %eax,-0x48(%rbp)
   44103:	eb 5c                	jmp    44161 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   44105:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44108:	83 e0 20             	and    $0x20,%eax
   4410b:	85 c0                	test   %eax,%eax
   4410d:	74 4b                	je     4415a <printer_vprintf+0x87d>
   4410f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44112:	83 e0 02             	and    $0x2,%eax
   44115:	85 c0                	test   %eax,%eax
   44117:	74 41                	je     4415a <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
   44119:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4411c:	83 e0 04             	and    $0x4,%eax
   4411f:	85 c0                	test   %eax,%eax
   44121:	75 37                	jne    4415a <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
   44123:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44127:	48 89 c7             	mov    %rax,%rdi
   4412a:	e8 51 f5 ff ff       	call   43680 <strlen>
   4412f:	89 c2                	mov    %eax,%edx
   44131:	8b 45 bc             	mov    -0x44(%rbp),%eax
   44134:	01 d0                	add    %edx,%eax
   44136:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   44139:	7e 1f                	jle    4415a <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
   4413b:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4413e:	2b 45 bc             	sub    -0x44(%rbp),%eax
   44141:	89 c3                	mov    %eax,%ebx
   44143:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44147:	48 89 c7             	mov    %rax,%rdi
   4414a:	e8 31 f5 ff ff       	call   43680 <strlen>
   4414f:	89 c2                	mov    %eax,%edx
   44151:	89 d8                	mov    %ebx,%eax
   44153:	29 d0                	sub    %edx,%eax
   44155:	89 45 b8             	mov    %eax,-0x48(%rbp)
   44158:	eb 07                	jmp    44161 <printer_vprintf+0x884>
        } else {
            zeros = 0;
   4415a:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   44161:	8b 55 bc             	mov    -0x44(%rbp),%edx
   44164:	8b 45 b8             	mov    -0x48(%rbp),%eax
   44167:	01 d0                	add    %edx,%eax
   44169:	48 63 d8             	movslq %eax,%rbx
   4416c:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44170:	48 89 c7             	mov    %rax,%rdi
   44173:	e8 08 f5 ff ff       	call   43680 <strlen>
   44178:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   4417c:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4417f:	29 d0                	sub    %edx,%eax
   44181:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   44184:	eb 25                	jmp    441ab <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
   44186:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4418d:	48 8b 08             	mov    (%rax),%rcx
   44190:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44196:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4419d:	be 20 00 00 00       	mov    $0x20,%esi
   441a2:	48 89 c7             	mov    %rax,%rdi
   441a5:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   441a7:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   441ab:	8b 45 ec             	mov    -0x14(%rbp),%eax
   441ae:	83 e0 04             	and    $0x4,%eax
   441b1:	85 c0                	test   %eax,%eax
   441b3:	75 36                	jne    441eb <printer_vprintf+0x90e>
   441b5:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   441b9:	7f cb                	jg     44186 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
   441bb:	eb 2e                	jmp    441eb <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
   441bd:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   441c4:	4c 8b 00             	mov    (%rax),%r8
   441c7:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   441cb:	0f b6 00             	movzbl (%rax),%eax
   441ce:	0f b6 c8             	movzbl %al,%ecx
   441d1:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   441d7:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   441de:	89 ce                	mov    %ecx,%esi
   441e0:	48 89 c7             	mov    %rax,%rdi
   441e3:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   441e6:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   441eb:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   441ef:	0f b6 00             	movzbl (%rax),%eax
   441f2:	84 c0                	test   %al,%al
   441f4:	75 c7                	jne    441bd <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
   441f6:	eb 25                	jmp    4421d <printer_vprintf+0x940>
            p->putc(p, '0', color);
   441f8:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   441ff:	48 8b 08             	mov    (%rax),%rcx
   44202:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44208:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4420f:	be 30 00 00 00       	mov    $0x30,%esi
   44214:	48 89 c7             	mov    %rax,%rdi
   44217:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   44219:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   4421d:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   44221:	7f d5                	jg     441f8 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
   44223:	eb 32                	jmp    44257 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
   44225:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4422c:	4c 8b 00             	mov    (%rax),%r8
   4422f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44233:	0f b6 00             	movzbl (%rax),%eax
   44236:	0f b6 c8             	movzbl %al,%ecx
   44239:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   4423f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44246:	89 ce                	mov    %ecx,%esi
   44248:	48 89 c7             	mov    %rax,%rdi
   4424b:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   4424e:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   44253:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   44257:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   4425b:	7f c8                	jg     44225 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
   4425d:	eb 25                	jmp    44284 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
   4425f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44266:	48 8b 08             	mov    (%rax),%rcx
   44269:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   4426f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44276:	be 20 00 00 00       	mov    $0x20,%esi
   4427b:	48 89 c7             	mov    %rax,%rdi
   4427e:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   44280:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   44284:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   44288:	7f d5                	jg     4425f <printer_vprintf+0x982>
        }
    done: ;
   4428a:	90                   	nop
    for (; *format; ++format) {
   4428b:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44292:	01 
   44293:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4429a:	0f b6 00             	movzbl (%rax),%eax
   4429d:	84 c0                	test   %al,%al
   4429f:	0f 85 64 f6 ff ff    	jne    43909 <printer_vprintf+0x2c>
    }
}
   442a5:	90                   	nop
   442a6:	90                   	nop
   442a7:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   442ab:	c9                   	leave  
   442ac:	c3                   	ret    

00000000000442ad <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   442ad:	55                   	push   %rbp
   442ae:	48 89 e5             	mov    %rsp,%rbp
   442b1:	48 83 ec 20          	sub    $0x20,%rsp
   442b5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   442b9:	89 f0                	mov    %esi,%eax
   442bb:	89 55 e0             	mov    %edx,-0x20(%rbp)
   442be:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   442c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   442c5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   442c9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   442cd:	48 8b 40 08          	mov    0x8(%rax),%rax
   442d1:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
   442d6:	48 39 d0             	cmp    %rdx,%rax
   442d9:	72 0c                	jb     442e7 <console_putc+0x3a>
        cp->cursor = console;
   442db:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   442df:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
   442e6:	00 
    }
    if (c == '\n') {
   442e7:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   442eb:	75 78                	jne    44365 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
   442ed:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   442f1:	48 8b 40 08          	mov    0x8(%rax),%rax
   442f5:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   442fb:	48 d1 f8             	sar    %rax
   442fe:	48 89 c1             	mov    %rax,%rcx
   44301:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   44308:	66 66 66 
   4430b:	48 89 c8             	mov    %rcx,%rax
   4430e:	48 f7 ea             	imul   %rdx
   44311:	48 c1 fa 05          	sar    $0x5,%rdx
   44315:	48 89 c8             	mov    %rcx,%rax
   44318:	48 c1 f8 3f          	sar    $0x3f,%rax
   4431c:	48 29 c2             	sub    %rax,%rdx
   4431f:	48 89 d0             	mov    %rdx,%rax
   44322:	48 c1 e0 02          	shl    $0x2,%rax
   44326:	48 01 d0             	add    %rdx,%rax
   44329:	48 c1 e0 04          	shl    $0x4,%rax
   4432d:	48 29 c1             	sub    %rax,%rcx
   44330:	48 89 ca             	mov    %rcx,%rdx
   44333:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   44336:	eb 25                	jmp    4435d <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
   44338:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4433b:	83 c8 20             	or     $0x20,%eax
   4433e:	89 c6                	mov    %eax,%esi
   44340:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44344:	48 8b 40 08          	mov    0x8(%rax),%rax
   44348:	48 8d 48 02          	lea    0x2(%rax),%rcx
   4434c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   44350:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44354:	89 f2                	mov    %esi,%edx
   44356:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   44359:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4435d:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   44361:	75 d5                	jne    44338 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   44363:	eb 24                	jmp    44389 <console_putc+0xdc>
        *cp->cursor++ = c | color;
   44365:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
   44369:	8b 55 e0             	mov    -0x20(%rbp),%edx
   4436c:	09 d0                	or     %edx,%eax
   4436e:	89 c6                	mov    %eax,%esi
   44370:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44374:	48 8b 40 08          	mov    0x8(%rax),%rax
   44378:	48 8d 48 02          	lea    0x2(%rax),%rcx
   4437c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   44380:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44384:	89 f2                	mov    %esi,%edx
   44386:	66 89 10             	mov    %dx,(%rax)
}
   44389:	90                   	nop
   4438a:	c9                   	leave  
   4438b:	c3                   	ret    

000000000004438c <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   4438c:	55                   	push   %rbp
   4438d:	48 89 e5             	mov    %rsp,%rbp
   44390:	48 83 ec 30          	sub    $0x30,%rsp
   44394:	89 7d ec             	mov    %edi,-0x14(%rbp)
   44397:	89 75 e8             	mov    %esi,-0x18(%rbp)
   4439a:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   4439e:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   443a2:	48 c7 45 f0 ad 42 04 	movq   $0x442ad,-0x10(%rbp)
   443a9:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   443aa:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   443ae:	78 09                	js     443b9 <console_vprintf+0x2d>
   443b0:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   443b7:	7e 07                	jle    443c0 <console_vprintf+0x34>
        cpos = 0;
   443b9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   443c0:	8b 45 ec             	mov    -0x14(%rbp),%eax
   443c3:	48 98                	cltq   
   443c5:	48 01 c0             	add    %rax,%rax
   443c8:	48 05 00 80 0b 00    	add    $0xb8000,%rax
   443ce:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   443d2:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   443d6:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   443da:	8b 75 e8             	mov    -0x18(%rbp),%esi
   443dd:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   443e1:	48 89 c7             	mov    %rax,%rdi
   443e4:	e8 f4 f4 ff ff       	call   438dd <printer_vprintf>
    return cp.cursor - console;
   443e9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   443ed:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   443f3:	48 d1 f8             	sar    %rax
}
   443f6:	c9                   	leave  
   443f7:	c3                   	ret    

00000000000443f8 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   443f8:	55                   	push   %rbp
   443f9:	48 89 e5             	mov    %rsp,%rbp
   443fc:	48 83 ec 60          	sub    $0x60,%rsp
   44400:	89 7d ac             	mov    %edi,-0x54(%rbp)
   44403:	89 75 a8             	mov    %esi,-0x58(%rbp)
   44406:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   4440a:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4440e:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44412:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44416:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   4441d:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44421:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   44425:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44429:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   4442d:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   44431:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   44435:	8b 75 a8             	mov    -0x58(%rbp),%esi
   44438:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4443b:	89 c7                	mov    %eax,%edi
   4443d:	e8 4a ff ff ff       	call   4438c <console_vprintf>
   44442:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   44445:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   44448:	c9                   	leave  
   44449:	c3                   	ret    

000000000004444a <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   4444a:	55                   	push   %rbp
   4444b:	48 89 e5             	mov    %rsp,%rbp
   4444e:	48 83 ec 20          	sub    $0x20,%rsp
   44452:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44456:	89 f0                	mov    %esi,%eax
   44458:	89 55 e0             	mov    %edx,-0x20(%rbp)
   4445b:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   4445e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44462:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   44466:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4446a:	48 8b 50 08          	mov    0x8(%rax),%rdx
   4446e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44472:	48 8b 40 10          	mov    0x10(%rax),%rax
   44476:	48 39 c2             	cmp    %rax,%rdx
   44479:	73 1a                	jae    44495 <string_putc+0x4b>
        *sp->s++ = c;
   4447b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4447f:	48 8b 40 08          	mov    0x8(%rax),%rax
   44483:	48 8d 48 01          	lea    0x1(%rax),%rcx
   44487:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4448b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4448f:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   44493:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   44495:	90                   	nop
   44496:	c9                   	leave  
   44497:	c3                   	ret    

0000000000044498 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   44498:	55                   	push   %rbp
   44499:	48 89 e5             	mov    %rsp,%rbp
   4449c:	48 83 ec 40          	sub    $0x40,%rsp
   444a0:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   444a4:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   444a8:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   444ac:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   444b0:	48 c7 45 e8 4a 44 04 	movq   $0x4444a,-0x18(%rbp)
   444b7:	00 
    sp.s = s;
   444b8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   444bc:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   444c0:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   444c5:	74 33                	je     444fa <vsnprintf+0x62>
        sp.end = s + size - 1;
   444c7:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   444cb:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   444cf:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   444d3:	48 01 d0             	add    %rdx,%rax
   444d6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   444da:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   444de:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   444e2:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   444e6:	be 00 00 00 00       	mov    $0x0,%esi
   444eb:	48 89 c7             	mov    %rax,%rdi
   444ee:	e8 ea f3 ff ff       	call   438dd <printer_vprintf>
        *sp.s = 0;
   444f3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   444f7:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   444fa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   444fe:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   44502:	c9                   	leave  
   44503:	c3                   	ret    

0000000000044504 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   44504:	55                   	push   %rbp
   44505:	48 89 e5             	mov    %rsp,%rbp
   44508:	48 83 ec 70          	sub    $0x70,%rsp
   4450c:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   44510:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   44514:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   44518:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4451c:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44520:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44524:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   4452b:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4452f:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   44533:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44537:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   4453b:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   4453f:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   44543:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   44547:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4454b:	48 89 c7             	mov    %rax,%rdi
   4454e:	e8 45 ff ff ff       	call   44498 <vsnprintf>
   44553:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   44556:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   44559:	c9                   	leave  
   4455a:	c3                   	ret    

000000000004455b <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   4455b:	55                   	push   %rbp
   4455c:	48 89 e5             	mov    %rsp,%rbp
   4455f:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44563:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4456a:	eb 13                	jmp    4457f <console_clear+0x24>
        console[i] = ' ' | 0x0700;
   4456c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4456f:	48 98                	cltq   
   44571:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
   44578:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   4457b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4457f:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   44586:	7e e4                	jle    4456c <console_clear+0x11>
    }
    cursorpos = 0;
   44588:	c7 05 6a 4a 07 00 00 	movl   $0x0,0x74a6a(%rip)        # b8ffc <cursorpos>
   4458f:	00 00 00 
}
   44592:	90                   	nop
   44593:	c9                   	leave  
   44594:	c3                   	ret    
