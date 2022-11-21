
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
   400be:	e8 91 08 00 00       	call   40954 <exception>

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
   40173:	e8 07 17 00 00       	call   4187f <hardware_init>
    pageinfo_init();
   40178:	e8 66 0d 00 00       	call   40ee3 <pageinfo_init>
    console_clear();
   4017d:	e8 3d 41 00 00       	call   442bf <console_clear>
    timer_init(HZ);
   40182:	bf 64 00 00 00       	mov    $0x64,%edi
   40187:	e8 df 1b 00 00       	call   41d6b <timer_init>

    // use virtual_memory_map to remove user permissions for kernel memory
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   4018c:	48 8b 05 6d 4e 01 00 	mov    0x14e6d(%rip),%rax        # 55000 <kernel_pagetable>
   40193:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   40199:	b9 00 00 10 00       	mov    $0x100000,%ecx
   4019e:	ba 00 00 00 00       	mov    $0x0,%edx
   401a3:	be 00 00 00 00       	mov    $0x0,%esi
   401a8:	48 89 c7             	mov    %rax,%rdi
   401ab:	e8 19 29 00 00       	call   42ac9 <virtual_memory_map>
					   PROC_START_ADDR, PTE_P | PTE_W);
   
    // return user permissions to console
    virtual_memory_map(kernel_pagetable, (uintptr_t) CONSOLE_ADDR, (uintptr_t) CONSOLE_ADDR,
   401b0:	ba 00 80 0b 00       	mov    $0xb8000,%edx
   401b5:	be 00 80 0b 00       	mov    $0xb8000,%esi
   401ba:	48 8b 05 3f 4e 01 00 	mov    0x14e3f(%rip),%rax        # 55000 <kernel_pagetable>
   401c1:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   401c7:	b9 00 10 00 00       	mov    $0x1000,%ecx
   401cc:	48 89 c7             	mov    %rax,%rdi
   401cf:	e8 f5 28 00 00       	call   42ac9 <virtual_memory_map>
	// to all memory before the start of ANY processes. This means that 
	// the assign_page function is never capable of assigning this memory
	// to a process.

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   401d4:	ba 00 0e 00 00       	mov    $0xe00,%edx
   401d9:	be 00 00 00 00       	mov    $0x0,%esi
   401de:	bf 20 20 05 00       	mov    $0x52020,%edi
   401e3:	e8 bd 31 00 00       	call   433a5 <memset>
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
   40246:	be 00 43 04 00       	mov    $0x44300,%esi
   4024b:	48 89 c7             	mov    %rax,%rdi
   4024e:	e8 4b 32 00 00       	call   4349e <strcmp>
   40253:	85 c0                	test   %eax,%eax
   40255:	75 14                	jne    4026b <kernel+0x104>
        process_setup(1, 4);
   40257:	be 04 00 00 00       	mov    $0x4,%esi
   4025c:	bf 01 00 00 00       	mov    $0x1,%edi
   40261:	e8 6b 02 00 00       	call   404d1 <process_setup>
   40266:	e9 c2 00 00 00       	jmp    4032d <kernel+0x1c6>
    } else if (command && strcmp(command, "forkexit") == 0) {
   4026b:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40270:	74 29                	je     4029b <kernel+0x134>
   40272:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40276:	be 05 43 04 00       	mov    $0x44305,%esi
   4027b:	48 89 c7             	mov    %rax,%rdi
   4027e:	e8 1b 32 00 00       	call   4349e <strcmp>
   40283:	85 c0                	test   %eax,%eax
   40285:	75 14                	jne    4029b <kernel+0x134>
        process_setup(1, 5);
   40287:	be 05 00 00 00       	mov    $0x5,%esi
   4028c:	bf 01 00 00 00       	mov    $0x1,%edi
   40291:	e8 3b 02 00 00       	call   404d1 <process_setup>
   40296:	e9 92 00 00 00       	jmp    4032d <kernel+0x1c6>
    } else if (command && strcmp(command, "test") == 0) {
   4029b:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   402a0:	74 26                	je     402c8 <kernel+0x161>
   402a2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   402a6:	be 0e 43 04 00       	mov    $0x4430e,%esi
   402ab:	48 89 c7             	mov    %rax,%rdi
   402ae:	e8 eb 31 00 00       	call   4349e <strcmp>
   402b3:	85 c0                	test   %eax,%eax
   402b5:	75 11                	jne    402c8 <kernel+0x161>
        process_setup(1, 6);
   402b7:	be 06 00 00 00       	mov    $0x6,%esi
   402bc:	bf 01 00 00 00       	mov    $0x1,%edi
   402c1:	e8 0b 02 00 00       	call   404d1 <process_setup>
   402c6:	eb 65                	jmp    4032d <kernel+0x1c6>
    } else if (command && strcmp(command, "test2") == 0) {
   402c8:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   402cd:	74 39                	je     40308 <kernel+0x1a1>
   402cf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   402d3:	be 13 43 04 00       	mov    $0x44313,%esi
   402d8:	48 89 c7             	mov    %rax,%rdi
   402db:	e8 be 31 00 00       	call   4349e <strcmp>
   402e0:	85 c0                	test   %eax,%eax
   402e2:	75 24                	jne    40308 <kernel+0x1a1>
        for (pid_t i = 1; i <= 2; ++i) {
   402e4:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   402eb:	eb 13                	jmp    40300 <kernel+0x199>
            process_setup(i, 6);
   402ed:	8b 45 f8             	mov    -0x8(%rbp),%eax
   402f0:	be 06 00 00 00       	mov    $0x6,%esi
   402f5:	89 c7                	mov    %eax,%edi
   402f7:	e8 d5 01 00 00       	call   404d1 <process_setup>
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
   4031e:	e8 ae 01 00 00       	call   404d1 <process_setup>
        for (pid_t i = 1; i <= 4; ++i) {
   40323:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   40327:	83 7d f4 04          	cmpl   $0x4,-0xc(%rbp)
   4032b:	7e e4                	jle    40311 <kernel+0x1aa>
        }
    }


    // Switch to the first process using run()
    run(&processes[1]);
   4032d:	bf 00 21 05 00       	mov    $0x52100,%edi
   40332:	e8 4f 0b 00 00       	call   40e86 <run>

0000000000040337 <next_free_page>:

// next_free_page(uintptr_t *)
//    loads uintptr_t * with the address of the next free page in the kernel
//    returns 0 on success, -1 on failure

int next_free_page(uintptr_t *fill) {
   40337:	55                   	push   %rbp
   40338:	48 89 e5             	mov    %rsp,%rbp
   4033b:	48 83 ec 18          	sub    $0x18,%rsp
   4033f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
	for (uintptr_t pa = 0; pa < PROC_START_ADDR; pa += PAGESIZE) {
   40343:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   4034a:	00 
   4034b:	eb 46                	jmp    40393 <next_free_page+0x5c>
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
   40389:	eb 17                	jmp    403a2 <next_free_page+0x6b>
	for (uintptr_t pa = 0; pa < PROC_START_ADDR; pa += PAGESIZE) {
   4038b:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40392:	00 
   40393:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   4039a:	00 
   4039b:	76 b0                	jbe    4034d <next_free_page+0x16>
		}
	}
	return -1;
   4039d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   403a2:	c9                   	leave  
   403a3:	c3                   	ret    

00000000000403a4 <pagetable_setup>:
// pagetable_setup(pid)
//    given a process, sets up pagetable in the kernel space
//
//    returns 0 on success, -1 on failure

int pagetable_setup(pid_t pid) {
   403a4:	55                   	push   %rbp
   403a5:	48 89 e5             	mov    %rsp,%rbp
   403a8:	48 83 ec 40          	sub    $0x40,%rsp
   403ac:	89 7d cc             	mov    %edi,-0x34(%rbp)
    uintptr_t pagetable_pages[5];

    for (int i = 0; i< 5; i++) {
   403af:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   403b6:	e9 80 00 00 00       	jmp    4043b <pagetable_setup+0x97>
		if (next_free_page(&pagetable_pages[i]) == 0) {
   403bb:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   403bf:	8b 55 fc             	mov    -0x4(%rbp),%edx
   403c2:	48 63 d2             	movslq %edx,%rdx
   403c5:	48 c1 e2 03          	shl    $0x3,%rdx
   403c9:	48 01 d0             	add    %rdx,%rax
   403cc:	48 89 c7             	mov    %rax,%rdi
   403cf:	e8 63 ff ff ff       	call   40337 <next_free_page>
   403d4:	85 c0                	test   %eax,%eax
   403d6:	75 55                	jne    4042d <pagetable_setup+0x89>
			pageinfo[PAGENUMBER(pagetable_pages[i])].owner = pid;
   403d8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   403db:	48 98                	cltq   
   403dd:	48 8b 44 c5 d0       	mov    -0x30(%rbp,%rax,8),%rax
   403e2:	48 c1 e8 0c          	shr    $0xc,%rax
   403e6:	89 c1                	mov    %eax,%ecx
   403e8:	8b 45 cc             	mov    -0x34(%rbp),%eax
   403eb:	89 c2                	mov    %eax,%edx
   403ed:	48 63 c1             	movslq %ecx,%rax
   403f0:	88 94 00 40 2e 05 00 	mov    %dl,0x52e40(%rax,%rax,1)
			pageinfo[PAGENUMBER(pagetable_pages[i])].refcount = 1;
   403f7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   403fa:	48 98                	cltq   
   403fc:	48 8b 44 c5 d0       	mov    -0x30(%rbp,%rax,8),%rax
   40401:	48 c1 e8 0c          	shr    $0xc,%rax
   40405:	48 98                	cltq   
   40407:	c6 84 00 41 2e 05 00 	movb   $0x1,0x52e41(%rax,%rax,1)
   4040e:	01 
			memset((void *) pagetable_pages[i], 0, PAGESIZE);
   4040f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40412:	48 98                	cltq   
   40414:	48 8b 44 c5 d0       	mov    -0x30(%rbp,%rax,8),%rax
   40419:	ba 00 10 00 00       	mov    $0x1000,%edx
   4041e:	be 00 00 00 00       	mov    $0x0,%esi
   40423:	48 89 c7             	mov    %rax,%rdi
   40426:	e8 7a 2f 00 00       	call   433a5 <memset>
   4042b:	eb 0a                	jmp    40437 <pagetable_setup+0x93>
		}
		else {
			return -1;
   4042d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40432:	e9 98 00 00 00       	jmp    404cf <pagetable_setup+0x12b>
    for (int i = 0; i< 5; i++) {
   40437:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4043b:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
   4043f:	0f 8e 76 ff ff ff    	jle    403bb <pagetable_setup+0x17>
		}
    }

    ((x86_64_pagetable *) pagetable_pages[0])->entry[0] =
        (x86_64_pageentry_t) pagetable_pages[1] | PTE_P | PTE_W | PTE_U;
   40445:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    ((x86_64_pagetable *) pagetable_pages[0])->entry[0] =
   40449:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
        (x86_64_pageentry_t) pagetable_pages[1] | PTE_P | PTE_W | PTE_U;
   4044d:	48 83 c8 07          	or     $0x7,%rax
    ((x86_64_pagetable *) pagetable_pages[0])->entry[0] =
   40451:	48 89 02             	mov    %rax,(%rdx)
    
    ((x86_64_pagetable *) pagetable_pages[1])->entry[0] =
        (x86_64_pageentry_t) pagetable_pages[2] | PTE_P | PTE_W | PTE_U;
   40454:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    ((x86_64_pagetable *) pagetable_pages[1])->entry[0] =
   40458:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
        (x86_64_pageentry_t) pagetable_pages[2] | PTE_P | PTE_W | PTE_U;
   4045c:	48 83 c8 07          	or     $0x7,%rax
    ((x86_64_pagetable *) pagetable_pages[1])->entry[0] =
   40460:	48 89 02             	mov    %rax,(%rdx)

    ((x86_64_pagetable *) pagetable_pages[2])->entry[0] =
        (x86_64_pageentry_t) pagetable_pages[3] | PTE_P | PTE_W | PTE_U;
   40463:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    ((x86_64_pagetable *) pagetable_pages[2])->entry[0] =
   40467:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
        (x86_64_pageentry_t) pagetable_pages[3] | PTE_P | PTE_W | PTE_U;
   4046b:	48 83 c8 07          	or     $0x7,%rax
    ((x86_64_pagetable *) pagetable_pages[2])->entry[0] =
   4046f:	48 89 02             	mov    %rax,(%rdx)

    ((x86_64_pagetable *) pagetable_pages[2])->entry[1] =
        (x86_64_pageentry_t) pagetable_pages[4] | PTE_P | PTE_W | PTE_U;
   40472:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    ((x86_64_pagetable *) pagetable_pages[2])->entry[1] =
   40476:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
        (x86_64_pageentry_t) pagetable_pages[4] | PTE_P | PTE_W | PTE_U;
   4047a:	48 83 c8 07          	or     $0x7,%rax
    ((x86_64_pagetable *) pagetable_pages[2])->entry[1] =
   4047e:	48 89 42 08          	mov    %rax,0x8(%rdx)

   
    memcpy((void *)pagetable_pages[3], &kernel_pagetable[3], 
   40482:	48 8b 05 77 4b 01 00 	mov    0x14b77(%rip),%rax        # 55000 <kernel_pagetable>
   40489:	48 05 00 30 00 00    	add    $0x3000,%rax
   4048f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   40493:	48 89 d1             	mov    %rdx,%rcx
   40496:	ba 00 08 00 00       	mov    $0x800,%edx
   4049b:	48 89 c6             	mov    %rax,%rsi
   4049e:	48 89 cf             	mov    %rcx,%rdi
   404a1:	e8 01 2e 00 00       	call   432a7 <memcpy>
	   sizeof(x86_64_pageentry_t) * PAGENUMBER(PROC_START_ADDR));

    processes[pid].p_pagetable = (x86_64_pagetable *) pagetable_pages[0];
   404a6:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   404aa:	48 89 c1             	mov    %rax,%rcx
   404ad:	8b 45 cc             	mov    -0x34(%rbp),%eax
   404b0:	48 63 d0             	movslq %eax,%rdx
   404b3:	48 89 d0             	mov    %rdx,%rax
   404b6:	48 c1 e0 03          	shl    $0x3,%rax
   404ba:	48 29 d0             	sub    %rdx,%rax
   404bd:	48 c1 e0 05          	shl    $0x5,%rax
   404c1:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   404c7:	48 89 08             	mov    %rcx,(%rax)

    return 0;
   404ca:	b8 00 00 00 00       	mov    $0x0,%eax
}
   404cf:	c9                   	leave  
   404d0:	c3                   	ret    

00000000000404d1 <process_setup>:
// process_setup(pid, program_number)
//    Load application program `program_number` as process number `pid`.
//    This loads the application's code and data into memory, sets its
//    %rip and %rsp, gives it a stack page, and marks it as runnable.

void process_setup(pid_t pid, int program_number) {
   404d1:	55                   	push   %rbp
   404d2:	48 89 e5             	mov    %rsp,%rbp
   404d5:	48 83 ec 30          	sub    $0x30,%rsp
   404d9:	89 7d dc             	mov    %edi,-0x24(%rbp)
   404dc:	89 75 d8             	mov    %esi,-0x28(%rbp)
    process_init(&processes[pid], 0);
   404df:	8b 45 dc             	mov    -0x24(%rbp),%eax
   404e2:	48 63 d0             	movslq %eax,%rdx
   404e5:	48 89 d0             	mov    %rdx,%rax
   404e8:	48 c1 e0 03          	shl    $0x3,%rax
   404ec:	48 29 d0             	sub    %rdx,%rax
   404ef:	48 c1 e0 05          	shl    $0x5,%rax
   404f3:	48 05 20 20 05 00    	add    $0x52020,%rax
   404f9:	be 00 00 00 00       	mov    $0x0,%esi
   404fe:	48 89 c7             	mov    %rax,%rdi
   40501:	e8 f6 1a 00 00       	call   41ffc <process_init>
    //processes[pid].p_pagetable = kernel_pagetable;
    //++pageinfo[PAGENUMBER(kernel_pagetable)].refcount; //increase refcount since kernel_pagetable was used

    pagetable_setup(pid);
   40506:	8b 45 dc             	mov    -0x24(%rbp),%eax
   40509:	89 c7                	mov    %eax,%edi
   4050b:	e8 94 fe ff ff       	call   403a4 <pagetable_setup>

    int r = program_load(&processes[pid], program_number, NULL);
   40510:	8b 45 dc             	mov    -0x24(%rbp),%eax
   40513:	48 63 d0             	movslq %eax,%rdx
   40516:	48 89 d0             	mov    %rdx,%rax
   40519:	48 c1 e0 03          	shl    $0x3,%rax
   4051d:	48 29 d0             	sub    %rdx,%rax
   40520:	48 c1 e0 05          	shl    $0x5,%rax
   40524:	48 8d 88 20 20 05 00 	lea    0x52020(%rax),%rcx
   4052b:	8b 45 d8             	mov    -0x28(%rbp),%eax
   4052e:	ba 00 00 00 00       	mov    $0x0,%edx
   40533:	89 c6                	mov    %eax,%esi
   40535:	48 89 cf             	mov    %rcx,%rdi
   40538:	e8 49 2a 00 00       	call   42f86 <program_load>
   4053d:	89 45 fc             	mov    %eax,-0x4(%rbp)
    assert(r >= 0);
   40540:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   40544:	79 14                	jns    4055a <process_setup+0x89>
   40546:	ba 19 43 04 00       	mov    $0x44319,%edx
   4054b:	be c9 00 00 00       	mov    $0xc9,%esi
   40550:	bf 20 43 04 00       	mov    $0x44320,%edi
   40555:	e8 70 22 00 00       	call   427ca <assert_fail>

    processes[pid].p_registers.reg_rsp = MEMSIZE_VIRTUAL; 
   4055a:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4055d:	48 63 d0             	movslq %eax,%rdx
   40560:	48 89 d0             	mov    %rdx,%rax
   40563:	48 c1 e0 03          	shl    $0x3,%rax
   40567:	48 29 d0             	sub    %rdx,%rax
   4056a:	48 c1 e0 05          	shl    $0x5,%rax
   4056e:	48 05 d8 20 05 00    	add    $0x520d8,%rax
   40574:	48 c7 00 00 00 30 00 	movq   $0x300000,(%rax)
    uintptr_t stack_page_va = processes[pid].p_registers.reg_rsp - PAGESIZE;
   4057b:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4057e:	48 63 d0             	movslq %eax,%rdx
   40581:	48 89 d0             	mov    %rdx,%rax
   40584:	48 c1 e0 03          	shl    $0x3,%rax
   40588:	48 29 d0             	sub    %rdx,%rax
   4058b:	48 c1 e0 05          	shl    $0x5,%rax
   4058f:	48 05 d8 20 05 00    	add    $0x520d8,%rax
   40595:	48 8b 00             	mov    (%rax),%rax
   40598:	48 2d 00 10 00 00    	sub    $0x1000,%rax
   4059e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    uintptr_t stack_page_pa;
    next_free_page(&stack_page_pa);
   405a2:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   405a6:	48 89 c7             	mov    %rax,%rdi
   405a9:	e8 89 fd ff ff       	call   40337 <next_free_page>
    assign_physical_page(stack_page_pa, pid);
   405ae:	8b 45 dc             	mov    -0x24(%rbp),%eax
   405b1:	0f be d0             	movsbl %al,%edx
   405b4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   405b8:	89 d6                	mov    %edx,%esi
   405ba:	48 89 c7             	mov    %rax,%rdi
   405bd:	e8 5e 00 00 00       	call   40620 <assign_physical_page>
    virtual_memory_map(processes[pid].p_pagetable, stack_page_va, stack_page_pa,
   405c2:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
   405c6:	8b 45 dc             	mov    -0x24(%rbp),%eax
   405c9:	48 63 d0             	movslq %eax,%rdx
   405cc:	48 89 d0             	mov    %rdx,%rax
   405cf:	48 c1 e0 03          	shl    $0x3,%rax
   405d3:	48 29 d0             	sub    %rdx,%rax
   405d6:	48 c1 e0 05          	shl    $0x5,%rax
   405da:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   405e0:	48 8b 00             	mov    (%rax),%rax
   405e3:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   405e7:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   405ed:	b9 00 10 00 00       	mov    $0x1000,%ecx
   405f2:	48 89 fa             	mov    %rdi,%rdx
   405f5:	48 89 c7             	mov    %rax,%rdi
   405f8:	e8 cc 24 00 00       	call   42ac9 <virtual_memory_map>
                       PAGESIZE, PTE_P | PTE_W | PTE_U);
    processes[pid].p_state = P_RUNNABLE;
   405fd:	8b 45 dc             	mov    -0x24(%rbp),%eax
   40600:	48 63 d0             	movslq %eax,%rdx
   40603:	48 89 d0             	mov    %rdx,%rax
   40606:	48 c1 e0 03          	shl    $0x3,%rax
   4060a:	48 29 d0             	sub    %rdx,%rax
   4060d:	48 c1 e0 05          	shl    $0x5,%rax
   40611:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   40617:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
}
   4061d:	90                   	nop
   4061e:	c9                   	leave  
   4061f:	c3                   	ret    

0000000000040620 <assign_physical_page>:
// assign_physical_page(addr, owner)
//    Allocates the page with physical address `addr` to the given owner.
//    Fails if physical page `addr` was already allocated. Returns 0 on
//    success and -1 on failure. Used by the program loader.

int assign_physical_page(uintptr_t addr, int8_t owner) {
   40620:	55                   	push   %rbp
   40621:	48 89 e5             	mov    %rsp,%rbp
   40624:	48 83 ec 10          	sub    $0x10,%rsp
   40628:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4062c:	89 f0                	mov    %esi,%eax
   4062e:	88 45 f4             	mov    %al,-0xc(%rbp)
    if ((addr & 0xFFF) != 0								 // this check is that the permission bits are 0
   40631:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40635:	25 ff 0f 00 00       	and    $0xfff,%eax
   4063a:	48 85 c0             	test   %rax,%rax
   4063d:	75 20                	jne    4065f <assign_physical_page+0x3f>
        || addr >= MEMSIZE_PHYSICAL
   4063f:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40646:	00 
   40647:	77 16                	ja     4065f <assign_physical_page+0x3f>
        || pageinfo[PAGENUMBER(addr)].refcount != 0) {
   40649:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4064d:	48 c1 e8 0c          	shr    $0xc,%rax
   40651:	48 98                	cltq   
   40653:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   4065a:	00 
   4065b:	84 c0                	test   %al,%al
   4065d:	74 07                	je     40666 <assign_physical_page+0x46>
        return -1;
   4065f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40664:	eb 2c                	jmp    40692 <assign_physical_page+0x72>
    } else {
        pageinfo[PAGENUMBER(addr)].refcount = 1;
   40666:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4066a:	48 c1 e8 0c          	shr    $0xc,%rax
   4066e:	48 98                	cltq   
   40670:	c6 84 00 41 2e 05 00 	movb   $0x1,0x52e41(%rax,%rax,1)
   40677:	01 
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40678:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4067c:	48 c1 e8 0c          	shr    $0xc,%rax
   40680:	48 98                	cltq   
   40682:	0f b6 55 f4          	movzbl -0xc(%rbp),%edx
   40686:	88 94 00 40 2e 05 00 	mov    %dl,0x52e40(%rax,%rax,1)
        return 0;
   4068d:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   40692:	c9                   	leave  
   40693:	c3                   	ret    

0000000000040694 <syscall_mapping>:

void syscall_mapping(proc* p){
   40694:	55                   	push   %rbp
   40695:	48 89 e5             	mov    %rsp,%rbp
   40698:	48 83 ec 70          	sub    $0x70,%rsp
   4069c:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)

    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
   406a0:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   406a4:	48 8b 40 38          	mov    0x38(%rax),%rax
   406a8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t ptr = p->p_registers.reg_rsi;
   406ac:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   406b0:	48 8b 40 30          	mov    0x30(%rax),%rax
   406b4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    //convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);
   406b8:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   406bc:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   406c3:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   406c7:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   406cb:	48 89 ce             	mov    %rcx,%rsi
   406ce:	48 89 c7             	mov    %rax,%rdi
   406d1:	e8 b9 27 00 00       	call   42e8f <virtual_memory_lookup>

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
   406d6:	8b 45 e0             	mov    -0x20(%rbp),%eax
   406d9:	48 98                	cltq   
   406db:	83 e0 06             	and    $0x6,%eax
   406de:	48 83 f8 06          	cmp    $0x6,%rax
   406e2:	75 73                	jne    40757 <syscall_mapping+0xc3>
	return;
    uintptr_t endaddr = map.pa + sizeof(vamapping) - 1;
   406e4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   406e8:	48 83 c0 17          	add    $0x17,%rax
   406ec:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    // check for write access for end address
    vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
   406f0:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   406f4:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   406fb:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   406ff:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   40703:	48 89 ce             	mov    %rcx,%rsi
   40706:	48 89 c7             	mov    %rax,%rdi
   40709:	e8 81 27 00 00       	call   42e8f <virtual_memory_lookup>
    if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
   4070e:	8b 45 c8             	mov    -0x38(%rbp),%eax
   40711:	48 98                	cltq   
   40713:	83 e0 03             	and    $0x3,%eax
   40716:	48 83 f8 03          	cmp    $0x3,%rax
   4071a:	75 3e                	jne    4075a <syscall_mapping+0xc6>
	return;
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
   4071c:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40720:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40727:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   4072b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4072f:	48 89 ce             	mov    %rcx,%rsi
   40732:	48 89 c7             	mov    %rax,%rdi
   40735:	e8 55 27 00 00       	call   42e8f <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   4073a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4073e:	48 89 c1             	mov    %rax,%rcx
   40741:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40745:	ba 18 00 00 00       	mov    $0x18,%edx
   4074a:	48 89 c6             	mov    %rax,%rsi
   4074d:	48 89 cf             	mov    %rcx,%rdi
   40750:	e8 52 2b 00 00       	call   432a7 <memcpy>
   40755:	eb 04                	jmp    4075b <syscall_mapping+0xc7>
	return;
   40757:	90                   	nop
   40758:	eb 01                	jmp    4075b <syscall_mapping+0xc7>
	return;
   4075a:	90                   	nop
}
   4075b:	c9                   	leave  
   4075c:	c3                   	ret    

000000000004075d <syscall_mem_tog>:

void syscall_mem_tog(proc* process){
   4075d:	55                   	push   %rbp
   4075e:	48 89 e5             	mov    %rsp,%rbp
   40761:	48 83 ec 18          	sub    $0x18,%rsp
   40765:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)

    pid_t p = process->p_registers.reg_rdi;
   40769:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4076d:	48 8b 40 38          	mov    0x38(%rax),%rax
   40771:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(p == 0) {
   40774:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   40778:	75 14                	jne    4078e <syscall_mem_tog+0x31>
        disp_global = !disp_global;
   4077a:	0f b6 05 7f 58 00 00 	movzbl 0x587f(%rip),%eax        # 46000 <disp_global>
   40781:	84 c0                	test   %al,%al
   40783:	0f 94 c0             	sete   %al
   40786:	88 05 74 58 00 00    	mov    %al,0x5874(%rip)        # 46000 <disp_global>
   4078c:	eb 36                	jmp    407c4 <syscall_mem_tog+0x67>
    }
    else {
        if(p < 0 || p > NPROC || p != process->p_pid)
   4078e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   40792:	78 2f                	js     407c3 <syscall_mem_tog+0x66>
   40794:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   40798:	7f 29                	jg     407c3 <syscall_mem_tog+0x66>
   4079a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4079e:	8b 00                	mov    (%rax),%eax
   407a0:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   407a3:	75 1e                	jne    407c3 <syscall_mem_tog+0x66>
            return;
        process->display_status = !(process->display_status);
   407a5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   407a9:	0f b6 80 d8 00 00 00 	movzbl 0xd8(%rax),%eax
   407b0:	84 c0                	test   %al,%al
   407b2:	0f 94 c0             	sete   %al
   407b5:	89 c2                	mov    %eax,%edx
   407b7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   407bb:	88 90 d8 00 00 00    	mov    %dl,0xd8(%rax)
   407c1:	eb 01                	jmp    407c4 <syscall_mem_tog+0x67>
            return;
   407c3:	90                   	nop
    }
}
   407c4:	c9                   	leave  
   407c5:	c3                   	ret    

00000000000407c6 <next_free_pid>:
// ---------- FORK HELPERS ----------

// next_free_process(void)
//    returns the next free pid, -1 if there aren't any

pid_t next_free_pid(void) {
   407c6:	55                   	push   %rbp
   407c7:	48 89 e5             	mov    %rsp,%rbp
   407ca:	48 83 ec 10          	sub    $0x10,%rsp
	for (pid_t pid = 1; pid < NPROC; pid++)
   407ce:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
   407d5:	eb 29                	jmp    40800 <next_free_pid+0x3a>
		if (processes[pid].p_state == P_FREE)
   407d7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   407da:	48 63 d0             	movslq %eax,%rdx
   407dd:	48 89 d0             	mov    %rdx,%rax
   407e0:	48 c1 e0 03          	shl    $0x3,%rax
   407e4:	48 29 d0             	sub    %rdx,%rax
   407e7:	48 c1 e0 05          	shl    $0x5,%rax
   407eb:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   407f1:	8b 00                	mov    (%rax),%eax
   407f3:	85 c0                	test   %eax,%eax
   407f5:	75 05                	jne    407fc <next_free_pid+0x36>
			return pid;
   407f7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   407fa:	eb 0f                	jmp    4080b <next_free_pid+0x45>
	for (pid_t pid = 1; pid < NPROC; pid++)
   407fc:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   40800:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   40804:	7e d1                	jle    407d7 <next_free_pid+0x11>
	return -1;
   40806:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   4080b:	c9                   	leave  
   4080c:	c3                   	ret    

000000000004080d <copy_pagetable>:
//		address is readonly, updates page ref
//		otherwise, copies contents to a new physical page
//
//		returns 0 on success, -1 on failure

int copy_pagetable(proc *dest, proc *src) {
   4080d:	55                   	push   %rbp
   4080e:	48 89 e5             	mov    %rsp,%rbp
   40811:	48 83 ec 40          	sub    $0x40,%rsp
   40815:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   40819:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
	for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   4081d:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   40824:	00 
   40825:	e9 15 01 00 00       	jmp    4093f <copy_pagetable+0x132>
		vamapping map = virtual_memory_lookup(src->p_pagetable, va); // examining addr page by page
   4082a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4082e:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40835:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   40839:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4083d:	48 89 ce             	mov    %rcx,%rsi
   40840:	48 89 c7             	mov    %rax,%rdi
   40843:	e8 47 26 00 00       	call   42e8f <virtual_memory_lookup>
		
		if (map.pn == -1) { // unused va
   40848:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4084b:	83 f8 ff             	cmp    $0xffffffff,%eax
   4084e:	0f 84 e2 00 00 00    	je     40936 <copy_pagetable+0x129>
			continue;
		}
		else if ((map.perm & PTE_P) && !(map.perm & PTE_W) && (map.perm & PTE_U)) { // how to detect readonly memory?
   40854:	8b 45 f0             	mov    -0x10(%rbp),%eax
   40857:	48 98                	cltq   
   40859:	83 e0 01             	and    $0x1,%eax
   4085c:	48 85 c0             	test   %rax,%rax
   4085f:	74 5c                	je     408bd <copy_pagetable+0xb0>
   40861:	8b 45 f0             	mov    -0x10(%rbp),%eax
   40864:	48 98                	cltq   
   40866:	83 e0 02             	and    $0x2,%eax
   40869:	48 85 c0             	test   %rax,%rax
   4086c:	75 4f                	jne    408bd <copy_pagetable+0xb0>
   4086e:	8b 45 f0             	mov    -0x10(%rbp),%eax
   40871:	48 98                	cltq   
   40873:	83 e0 04             	and    $0x4,%eax
   40876:	48 85 c0             	test   %rax,%rax
   40879:	74 42                	je     408bd <copy_pagetable+0xb0>
			pageinfo[map.pn].refcount++;	
   4087b:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4087e:	48 63 d0             	movslq %eax,%rdx
   40881:	0f b6 94 12 41 2e 05 	movzbl 0x52e41(%rdx,%rdx,1),%edx
   40888:	00 
   40889:	83 c2 01             	add    $0x1,%edx
   4088c:	48 98                	cltq   
   4088e:	88 94 00 41 2e 05 00 	mov    %dl,0x52e41(%rax,%rax,1)
			virtual_memory_map(dest->p_pagetable, va, map.pa, PAGESIZE, map.perm);
   40895:	8b 4d f0             	mov    -0x10(%rbp),%ecx
   40898:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   4089c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   408a0:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   408a7:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   408ab:	41 89 c8             	mov    %ecx,%r8d
   408ae:	b9 00 10 00 00       	mov    $0x1000,%ecx
   408b3:	48 89 c7             	mov    %rax,%rdi
   408b6:	e8 0e 22 00 00       	call   42ac9 <virtual_memory_map>
   408bb:	eb 7a                	jmp    40937 <copy_pagetable+0x12a>
		}
		else {
			uintptr_t free_page;
			if (next_free_page(&free_page)
   408bd:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   408c1:	48 89 c7             	mov    %rax,%rdi
   408c4:	e8 6e fa ff ff       	call   40337 <next_free_page>
   408c9:	85 c0                	test   %eax,%eax
   408cb:	75 45                	jne    40912 <copy_pagetable+0x105>
				|| assign_physical_page(free_page, dest->p_pid)
   408cd:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   408d1:	8b 00                	mov    (%rax),%eax
   408d3:	0f be d0             	movsbl %al,%edx
   408d6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   408da:	89 d6                	mov    %edx,%esi
   408dc:	48 89 c7             	mov    %rax,%rdi
   408df:	e8 3c fd ff ff       	call   40620 <assign_physical_page>
   408e4:	85 c0                	test   %eax,%eax
   408e6:	75 2a                	jne    40912 <copy_pagetable+0x105>
				|| virtual_memory_map(dest->p_pagetable, va, free_page, PAGESIZE, map.perm)) {
   408e8:	8b 4d f0             	mov    -0x10(%rbp),%ecx
   408eb:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   408ef:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   408f3:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   408fa:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   408fe:	41 89 c8             	mov    %ecx,%r8d
   40901:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40906:	48 89 c7             	mov    %rax,%rdi
   40909:	e8 bb 21 00 00       	call   42ac9 <virtual_memory_map>
   4090e:	85 c0                	test   %eax,%eax
   40910:	74 07                	je     40919 <copy_pagetable+0x10c>

				// failure conditions are - no free page, no allocated l1 pagetable

				return -1;
   40912:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40917:	eb 39                	jmp    40952 <copy_pagetable+0x145>
			}
			else {
				memcpy((void *) free_page, (void *) map.pa, PAGESIZE);
   40919:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4091d:	48 89 c1             	mov    %rax,%rcx
   40920:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40924:	ba 00 10 00 00       	mov    $0x1000,%edx
   40929:	48 89 ce             	mov    %rcx,%rsi
   4092c:	48 89 c7             	mov    %rax,%rdi
   4092f:	e8 73 29 00 00       	call   432a7 <memcpy>
   40934:	eb 01                	jmp    40937 <copy_pagetable+0x12a>
			continue;
   40936:	90                   	nop
	for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   40937:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4093e:	00 
   4093f:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   40946:	00 
   40947:	0f 86 dd fe ff ff    	jbe    4082a <copy_pagetable+0x1d>
			}
		}
	}

	return 0;
   4094d:	b8 00 00 00 00       	mov    $0x0,%eax
}
   40952:	c9                   	leave  
   40953:	c3                   	ret    

0000000000040954 <exception>:
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_64_registers* reg) {
   40954:	55                   	push   %rbp
   40955:	48 89 e5             	mov    %rsp,%rbp
   40958:	48 81 ec 20 01 00 00 	sub    $0x120,%rsp
   4095f:	48 89 bd e8 fe ff ff 	mov    %rdi,-0x118(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   40966:	48 8b 05 93 16 01 00 	mov    0x11693(%rip),%rax        # 52000 <current>
   4096d:	48 8b 95 e8 fe ff ff 	mov    -0x118(%rbp),%rdx
   40974:	48 83 c0 08          	add    $0x8,%rax
   40978:	48 89 d6             	mov    %rdx,%rsi
   4097b:	ba 18 00 00 00       	mov    $0x18,%edx
   40980:	48 89 c7             	mov    %rax,%rdi
   40983:	48 89 d1             	mov    %rdx,%rcx
   40986:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   40989:	48 8b 05 70 46 01 00 	mov    0x14670(%rip),%rax        # 55000 <kernel_pagetable>
   40990:	48 89 c7             	mov    %rax,%rdi
   40993:	e8 00 20 00 00       	call   42998 <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   40998:	8b 05 5e 86 07 00    	mov    0x7865e(%rip),%eax        # b8ffc <cursorpos>
   4099e:	89 c7                	mov    %eax,%edi
   409a0:	e8 21 17 00 00       	call   420c6 <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT && reg->reg_intno != INT_GPF) // no error due to pagefault or general fault
   409a5:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   409ac:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   409b3:	48 83 f8 0e          	cmp    $0xe,%rax
   409b7:	74 14                	je     409cd <exception+0x79>
   409b9:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   409c0:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   409c7:	48 83 f8 0d          	cmp    $0xd,%rax
   409cb:	75 16                	jne    409e3 <exception+0x8f>
            || (reg->reg_err & PFERR_USER)) // pagefault error in user mode 
   409cd:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   409d4:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   409db:	83 e0 04             	and    $0x4,%eax
   409de:	48 85 c0             	test   %rax,%rax
   409e1:	74 1a                	je     409fd <exception+0xa9>
    {
        check_virtual_memory();
   409e3:	e8 92 08 00 00       	call   4127a <check_virtual_memory>
        if(disp_global){
   409e8:	0f b6 05 11 56 00 00 	movzbl 0x5611(%rip),%eax        # 46000 <disp_global>
   409ef:	84 c0                	test   %al,%al
   409f1:	74 0a                	je     409fd <exception+0xa9>
            memshow_physical();
   409f3:	e8 fa 09 00 00       	call   413f2 <memshow_physical>
            memshow_virtual_animate();
   409f8:	e8 24 0d 00 00       	call   41721 <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   409fd:	e8 a7 1b 00 00       	call   425a9 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   40a02:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40a09:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40a10:	48 83 e8 0e          	sub    $0xe,%rax
   40a14:	48 83 f8 2a          	cmp    $0x2a,%rax
   40a18:	0f 87 b9 03 00 00    	ja     40dd7 <exception+0x483>
   40a1e:	48 8b 04 c5 f8 43 04 	mov    0x443f8(,%rax,8),%rax
   40a25:	00 
   40a26:	ff e0                	jmp    *%rax

    case INT_SYS_PANIC:
	    // rdi stores pointer for msg string
	    {
		char msg[160];
		uintptr_t addr = current->p_registers.reg_rdi;
   40a28:	48 8b 05 d1 15 01 00 	mov    0x115d1(%rip),%rax        # 52000 <current>
   40a2f:	48 8b 40 38          	mov    0x38(%rax),%rax
   40a33:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
		if((void *)addr == NULL)
   40a37:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40a3c:	75 0f                	jne    40a4d <exception+0xf9>
		    panic(NULL);
   40a3e:	bf 00 00 00 00       	mov    $0x0,%edi
   40a43:	b8 00 00 00 00       	mov    $0x0,%eax
   40a48:	e8 9d 1c 00 00       	call   426ea <panic>
		vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   40a4d:	48 8b 05 ac 15 01 00 	mov    0x115ac(%rip),%rax        # 52000 <current>
   40a54:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40a5b:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   40a5f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   40a63:	48 89 ce             	mov    %rcx,%rsi
   40a66:	48 89 c7             	mov    %rax,%rdi
   40a69:	e8 21 24 00 00       	call   42e8f <virtual_memory_lookup>
		memcpy(msg, (void *)map.pa, 160);
   40a6e:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   40a72:	48 89 c1             	mov    %rax,%rcx
   40a75:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
   40a7c:	ba a0 00 00 00       	mov    $0xa0,%edx
   40a81:	48 89 ce             	mov    %rcx,%rsi
   40a84:	48 89 c7             	mov    %rax,%rdi
   40a87:	e8 1b 28 00 00       	call   432a7 <memcpy>
		panic(msg);
   40a8c:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
   40a93:	48 89 c7             	mov    %rax,%rdi
   40a96:	b8 00 00 00 00       	mov    $0x0,%eax
   40a9b:	e8 4a 1c 00 00       	call   426ea <panic>
	    }
	    panic(NULL);
	    break;                  // will not be reached

    case INT_SYS_GETPID:
        current->p_registers.reg_rax = current->p_pid;
   40aa0:	48 8b 05 59 15 01 00 	mov    0x11559(%rip),%rax        # 52000 <current>
   40aa7:	8b 10                	mov    (%rax),%edx
   40aa9:	48 8b 05 50 15 01 00 	mov    0x11550(%rip),%rax        # 52000 <current>
   40ab0:	48 63 d2             	movslq %edx,%rdx
   40ab3:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   40ab7:	e9 2b 03 00 00       	jmp    40de7 <exception+0x493>

    case INT_SYS_YIELD:
        schedule();
   40abc:	e8 4f 03 00 00       	call   40e10 <schedule>
        break;                  /* will not be reached */
   40ac1:	e9 21 03 00 00       	jmp    40de7 <exception+0x493>

    case INT_SYS_PAGE_ALLOC: 
	{
        uintptr_t va = current->p_registers.reg_rdi; 
   40ac6:	48 8b 05 33 15 01 00 	mov    0x11533(%rip),%rax        # 52000 <current>
   40acd:	48 8b 40 38          	mov    0x38(%rax),%rax
   40ad1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
		uintptr_t pa;
		int r = 0;
   40ad5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
		if (virtual_memory_lookup(current->p_pagetable, va).pn != -1) {
   40adc:	48 8b 05 1d 15 01 00 	mov    0x1151d(%rip),%rax        # 52000 <current>
   40ae3:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40aea:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   40aee:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40af2:	48 89 ce             	mov    %rcx,%rsi
   40af5:	48 89 c7             	mov    %rax,%rdi
   40af8:	e8 92 23 00 00       	call   42e8f <virtual_memory_lookup>
   40afd:	8b 45 b0             	mov    -0x50(%rbp),%eax
   40b00:	83 f8 ff             	cmp    $0xffffffff,%eax
   40b03:	74 0c                	je     40b11 <exception+0x1bd>
			r = -1;
   40b05:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
   40b0c:	e9 84 00 00 00       	jmp    40b95 <exception+0x241>
		}
		else if (next_free_page(&pa) || assign_physical_page(pa, current->p_pid)) {
   40b11:	48 8d 45 90          	lea    -0x70(%rbp),%rax
   40b15:	48 89 c7             	mov    %rax,%rdi
   40b18:	e8 1a f8 ff ff       	call   40337 <next_free_page>
   40b1d:	85 c0                	test   %eax,%eax
   40b1f:	75 1e                	jne    40b3f <exception+0x1eb>
   40b21:	48 8b 05 d8 14 01 00 	mov    0x114d8(%rip),%rax        # 52000 <current>
   40b28:	8b 00                	mov    (%rax),%eax
   40b2a:	0f be d0             	movsbl %al,%edx
   40b2d:	48 8b 45 90          	mov    -0x70(%rbp),%rax
   40b31:	89 d6                	mov    %edx,%esi
   40b33:	48 89 c7             	mov    %rax,%rdi
   40b36:	e8 e5 fa ff ff       	call   40620 <assign_physical_page>
   40b3b:	85 c0                	test   %eax,%eax
   40b3d:	74 22                	je     40b61 <exception+0x20d>
			console_printf(CPOS(23, 0), 0x0400, "Out of physical memory!\n");	
   40b3f:	ba 30 43 04 00       	mov    $0x44330,%edx
   40b44:	be 00 04 00 00       	mov    $0x400,%esi
   40b49:	bf 30 07 00 00       	mov    $0x730,%edi
   40b4e:	b8 00 00 00 00       	mov    $0x0,%eax
   40b53:	e8 04 36 00 00       	call   4415c <console_printf>
			r = -1;
   40b58:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
   40b5f:	eb 34                	jmp    40b95 <exception+0x241>
		}
		else if (virtual_memory_map(current->p_pagetable, va, pa, PAGESIZE, PTE_P | PTE_W | PTE_U)) {
   40b61:	48 8b 55 90          	mov    -0x70(%rbp),%rdx
   40b65:	48 8b 05 94 14 01 00 	mov    0x11494(%rip),%rax        # 52000 <current>
   40b6c:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40b73:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   40b77:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40b7d:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40b82:	48 89 c7             	mov    %rax,%rdi
   40b85:	e8 3f 1f 00 00       	call   42ac9 <virtual_memory_map>
   40b8a:	85 c0                	test   %eax,%eax
   40b8c:	74 07                	je     40b95 <exception+0x241>
			r = -1;
   40b8e:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
		}

        current->p_registers.reg_rax = r;
   40b95:	48 8b 05 64 14 01 00 	mov    0x11464(%rip),%rax        # 52000 <current>
   40b9c:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40b9f:	48 63 d2             	movslq %edx,%rdx
   40ba2:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   40ba6:	e9 3c 02 00 00       	jmp    40de7 <exception+0x493>
    }

    case INT_SYS_MAPPING:
    {
	    syscall_mapping(current);
   40bab:	48 8b 05 4e 14 01 00 	mov    0x1144e(%rip),%rax        # 52000 <current>
   40bb2:	48 89 c7             	mov    %rax,%rdi
   40bb5:	e8 da fa ff ff       	call   40694 <syscall_mapping>
            break;
   40bba:	e9 28 02 00 00       	jmp    40de7 <exception+0x493>
    }

    case INT_SYS_MEM_TOG:
	{
	    syscall_mem_tog(current);
   40bbf:	48 8b 05 3a 14 01 00 	mov    0x1143a(%rip),%rax        # 52000 <current>
   40bc6:	48 89 c7             	mov    %rax,%rdi
   40bc9:	e8 8f fb ff ff       	call   4075d <syscall_mem_tog>
	    break;
   40bce:	e9 14 02 00 00       	jmp    40de7 <exception+0x493>
	}

    case INT_TIMER:
        ++ticks;
   40bd3:	8b 05 47 22 01 00    	mov    0x12247(%rip),%eax        # 52e20 <ticks>
   40bd9:	83 c0 01             	add    $0x1,%eax
   40bdc:	89 05 3e 22 01 00    	mov    %eax,0x1223e(%rip)        # 52e20 <ticks>
        schedule();
   40be2:	e8 29 02 00 00       	call   40e10 <schedule>
        break;                  /* will not be reached */
   40be7:	e9 fb 01 00 00       	jmp    40de7 <exception+0x493>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   40bec:	0f 20 d0             	mov    %cr2,%rax
   40bef:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    return val;
   40bf3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax

    case INT_PAGEFAULT: {
        // Analyze faulting address and access type.
        uintptr_t addr = rcr2();
   40bf7:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
        const char* operation = reg->reg_err & PFERR_WRITE
   40bfb:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40c02:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40c09:	83 e0 02             	and    $0x2,%eax
                ? "write" : "read";
   40c0c:	48 85 c0             	test   %rax,%rax
   40c0f:	74 07                	je     40c18 <exception+0x2c4>
   40c11:	b8 49 43 04 00       	mov    $0x44349,%eax
   40c16:	eb 05                	jmp    40c1d <exception+0x2c9>
   40c18:	b8 4f 43 04 00       	mov    $0x4434f,%eax
        const char* operation = reg->reg_err & PFERR_WRITE
   40c1d:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        const char* problem = reg->reg_err & PFERR_PRESENT
   40c21:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40c28:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40c2f:	83 e0 01             	and    $0x1,%eax
                ? "protection problem" : "missing page";
   40c32:	48 85 c0             	test   %rax,%rax
   40c35:	74 07                	je     40c3e <exception+0x2ea>
   40c37:	b8 54 43 04 00       	mov    $0x44354,%eax
   40c3c:	eb 05                	jmp    40c43 <exception+0x2ef>
   40c3e:	b8 67 43 04 00       	mov    $0x44367,%eax
        const char* problem = reg->reg_err & PFERR_PRESENT
   40c43:	48 89 45 d0          	mov    %rax,-0x30(%rbp)

        if (!(reg->reg_err & PFERR_USER)) {
   40c47:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40c4e:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40c55:	83 e0 04             	and    $0x4,%eax
   40c58:	48 85 c0             	test   %rax,%rax
   40c5b:	75 2f                	jne    40c8c <exception+0x338>
            panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   40c5d:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40c64:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   40c6b:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
   40c6f:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   40c73:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40c77:	49 89 f0             	mov    %rsi,%r8
   40c7a:	48 89 c6             	mov    %rax,%rsi
   40c7d:	bf 78 43 04 00       	mov    $0x44378,%edi
   40c82:	b8 00 00 00 00       	mov    $0x0,%eax
   40c87:	e8 5e 1a 00 00       	call   426ea <panic>
                  addr, operation, problem, reg->reg_rip);
        }
        console_printf(CPOS(24, 0), 0x0C00,
   40c8c:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40c93:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                       "Process %d page fault for %p (%s %s, rip=%p)!\n",
                       current->p_pid, addr, operation, problem, reg->reg_rip);
   40c9a:	48 8b 05 5f 13 01 00 	mov    0x1135f(%rip),%rax        # 52000 <current>
        console_printf(CPOS(24, 0), 0x0C00,
   40ca1:	8b 00                	mov    (%rax),%eax
   40ca3:	48 8b 75 d8          	mov    -0x28(%rbp),%rsi
   40ca7:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   40cab:	52                   	push   %rdx
   40cac:	ff 75 d0             	push   -0x30(%rbp)
   40caf:	49 89 f1             	mov    %rsi,%r9
   40cb2:	49 89 c8             	mov    %rcx,%r8
   40cb5:	89 c1                	mov    %eax,%ecx
   40cb7:	ba a8 43 04 00       	mov    $0x443a8,%edx
   40cbc:	be 00 0c 00 00       	mov    $0xc00,%esi
   40cc1:	bf 80 07 00 00       	mov    $0x780,%edi
   40cc6:	b8 00 00 00 00       	mov    $0x0,%eax
   40ccb:	e8 8c 34 00 00       	call   4415c <console_printf>
   40cd0:	48 83 c4 10          	add    $0x10,%rsp
        current->p_state = P_BROKEN;
   40cd4:	48 8b 05 25 13 01 00 	mov    0x11325(%rip),%rax        # 52000 <current>
   40cdb:	c7 80 c8 00 00 00 03 	movl   $0x3,0xc8(%rax)
   40ce2:	00 00 00 
        break;
   40ce5:	e9 fd 00 00 00       	jmp    40de7 <exception+0x493>
    }

	case INT_SYS_FORK:
		// find free pid
		pid_t child_pid;
		if ((child_pid = next_free_pid()) == -1) {
   40cea:	e8 d7 fa ff ff       	call   407c6 <next_free_pid>
   40cef:	89 45 f8             	mov    %eax,-0x8(%rbp)
   40cf2:	83 7d f8 ff          	cmpl   $0xffffffff,-0x8(%rbp)
   40cf6:	75 32                	jne    40d2a <exception+0x3d6>
			console_printf(CPOS(23, 0), 0x0400, "Max processes (%d) reached!\n", NPROC);	
   40cf8:	b9 10 00 00 00       	mov    $0x10,%ecx
   40cfd:	ba d7 43 04 00       	mov    $0x443d7,%edx
   40d02:	be 00 04 00 00       	mov    $0x400,%esi
   40d07:	bf 30 07 00 00       	mov    $0x730,%edi
   40d0c:	b8 00 00 00 00       	mov    $0x0,%eax
   40d11:	e8 46 34 00 00       	call   4415c <console_printf>
			current->p_registers.reg_rax = -1;
   40d16:	48 8b 05 e3 12 01 00 	mov    0x112e3(%rip),%rax        # 52000 <current>
   40d1d:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40d24:	ff 
			break;
   40d25:	e9 bd 00 00 00       	jmp    40de7 <exception+0x493>
		}

		// copy the state of parent into child
		processes[child_pid] = processes[current->p_pid];
   40d2a:	48 8b 05 cf 12 01 00 	mov    0x112cf(%rip),%rax        # 52000 <current>
   40d31:	8b 08                	mov    (%rax),%ecx
   40d33:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40d36:	48 63 d0             	movslq %eax,%rdx
   40d39:	48 89 d0             	mov    %rdx,%rax
   40d3c:	48 c1 e0 03          	shl    $0x3,%rax
   40d40:	48 29 d0             	sub    %rdx,%rax
   40d43:	48 c1 e0 05          	shl    $0x5,%rax
   40d47:	48 8d b0 20 20 05 00 	lea    0x52020(%rax),%rsi
   40d4e:	48 63 d1             	movslq %ecx,%rdx
   40d51:	48 89 d0             	mov    %rdx,%rax
   40d54:	48 c1 e0 03          	shl    $0x3,%rax
   40d58:	48 29 d0             	sub    %rdx,%rax
   40d5b:	48 c1 e0 05          	shl    $0x5,%rax
   40d5f:	48 05 20 20 05 00    	add    $0x52020,%rax
   40d65:	48 89 f2             	mov    %rsi,%rdx
   40d68:	48 89 c6             	mov    %rax,%rsi
   40d6b:	b8 1c 00 00 00       	mov    $0x1c,%eax
   40d70:	48 89 d7             	mov    %rdx,%rdi
   40d73:	48 89 c1             	mov    %rax,%rcx
   40d76:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
		processes[child_pid].p_pid = child_pid;
   40d79:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40d7c:	48 63 d0             	movslq %eax,%rdx
   40d7f:	48 89 d0             	mov    %rdx,%rax
   40d82:	48 c1 e0 03          	shl    $0x3,%rax
   40d86:	48 29 d0             	sub    %rdx,%rax
   40d89:	48 c1 e0 05          	shl    $0x5,%rax
   40d8d:	48 8d 90 20 20 05 00 	lea    0x52020(%rax),%rdx
   40d94:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40d97:	89 02                	mov    %eax,(%rdx)

		// copy old pagetable into new pagetable
		pagetable_setup(child_pid);
   40d99:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40d9c:	89 c7                	mov    %eax,%edi
   40d9e:	e8 01 f6 ff ff       	call   403a4 <pagetable_setup>

		// set return values
		processes[child_pid].p_registers.reg_rax = 0;
   40da3:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40da6:	48 63 d0             	movslq %eax,%rdx
   40da9:	48 89 d0             	mov    %rdx,%rax
   40dac:	48 c1 e0 03          	shl    $0x3,%rax
   40db0:	48 29 d0             	sub    %rdx,%rax
   40db3:	48 c1 e0 05          	shl    $0x5,%rax
   40db7:	48 05 28 20 05 00    	add    $0x52028,%rax
   40dbd:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
		current->p_registers.reg_rax = child_pid;
   40dc4:	48 8b 05 35 12 01 00 	mov    0x11235(%rip),%rax        # 52000 <current>
   40dcb:	8b 55 f8             	mov    -0x8(%rbp),%edx
   40dce:	48 63 d2             	movslq %edx,%rdx
   40dd1:	48 89 50 08          	mov    %rdx,0x8(%rax)
		break;
   40dd5:	eb 10                	jmp    40de7 <exception+0x493>

    default:
        default_exception(current);
   40dd7:	48 8b 05 22 12 01 00 	mov    0x11222(%rip),%rax        # 52000 <current>
   40dde:	48 89 c7             	mov    %rax,%rdi
   40de1:	e8 14 1a 00 00       	call   427fa <default_exception>
        break;                  /* will not be reached */
   40de6:	90                   	nop

    }


    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   40de7:	48 8b 05 12 12 01 00 	mov    0x11212(%rip),%rax        # 52000 <current>
   40dee:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   40df4:	83 f8 01             	cmp    $0x1,%eax
   40df7:	75 0f                	jne    40e08 <exception+0x4b4>
        run(current);
   40df9:	48 8b 05 00 12 01 00 	mov    0x11200(%rip),%rax        # 52000 <current>
   40e00:	48 89 c7             	mov    %rax,%rdi
   40e03:	e8 7e 00 00 00       	call   40e86 <run>
    } else {
        schedule();
   40e08:	e8 03 00 00 00       	call   40e10 <schedule>
    }
}
   40e0d:	90                   	nop
   40e0e:	c9                   	leave  
   40e0f:	c3                   	ret    

0000000000040e10 <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   40e10:	55                   	push   %rbp
   40e11:	48 89 e5             	mov    %rsp,%rbp
   40e14:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   40e18:	48 8b 05 e1 11 01 00 	mov    0x111e1(%rip),%rax        # 52000 <current>
   40e1f:	8b 00                	mov    (%rax),%eax
   40e21:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   40e24:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40e27:	8d 50 01             	lea    0x1(%rax),%edx
   40e2a:	89 d0                	mov    %edx,%eax
   40e2c:	c1 f8 1f             	sar    $0x1f,%eax
   40e2f:	c1 e8 1c             	shr    $0x1c,%eax
   40e32:	01 c2                	add    %eax,%edx
   40e34:	83 e2 0f             	and    $0xf,%edx
   40e37:	29 c2                	sub    %eax,%edx
   40e39:	89 55 fc             	mov    %edx,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   40e3c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40e3f:	48 63 d0             	movslq %eax,%rdx
   40e42:	48 89 d0             	mov    %rdx,%rax
   40e45:	48 c1 e0 03          	shl    $0x3,%rax
   40e49:	48 29 d0             	sub    %rdx,%rax
   40e4c:	48 c1 e0 05          	shl    $0x5,%rax
   40e50:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   40e56:	8b 00                	mov    (%rax),%eax
   40e58:	83 f8 01             	cmp    $0x1,%eax
   40e5b:	75 22                	jne    40e7f <schedule+0x6f>
            run(&processes[pid]);
   40e5d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40e60:	48 63 d0             	movslq %eax,%rdx
   40e63:	48 89 d0             	mov    %rdx,%rax
   40e66:	48 c1 e0 03          	shl    $0x3,%rax
   40e6a:	48 29 d0             	sub    %rdx,%rax
   40e6d:	48 c1 e0 05          	shl    $0x5,%rax
   40e71:	48 05 20 20 05 00    	add    $0x52020,%rax
   40e77:	48 89 c7             	mov    %rax,%rdi
   40e7a:	e8 07 00 00 00       	call   40e86 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   40e7f:	e8 25 17 00 00       	call   425a9 <check_keyboard>
        pid = (pid + 1) % NPROC;
   40e84:	eb 9e                	jmp    40e24 <schedule+0x14>

0000000000040e86 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   40e86:	55                   	push   %rbp
   40e87:	48 89 e5             	mov    %rsp,%rbp
   40e8a:	48 83 ec 10          	sub    $0x10,%rsp
   40e8e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   40e92:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e96:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   40e9c:	83 f8 01             	cmp    $0x1,%eax
   40e9f:	74 14                	je     40eb5 <run+0x2f>
   40ea1:	ba 50 45 04 00       	mov    $0x44550,%edx
   40ea6:	be f4 01 00 00       	mov    $0x1f4,%esi
   40eab:	bf 20 43 04 00       	mov    $0x44320,%edi
   40eb0:	e8 15 19 00 00       	call   427ca <assert_fail>
    current = p;
   40eb5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40eb9:	48 89 05 40 11 01 00 	mov    %rax,0x11140(%rip)        # 52000 <current>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   40ec0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40ec4:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40ecb:	48 89 c7             	mov    %rax,%rdi
   40ece:	e8 c5 1a 00 00       	call   42998 <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   40ed3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40ed7:	48 83 c0 08          	add    $0x8,%rax
   40edb:	48 89 c7             	mov    %rax,%rdi
   40ede:	e8 e0 f1 ff ff       	call   400c3 <exception_return>

0000000000040ee3 <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   40ee3:	55                   	push   %rbp
   40ee4:	48 89 e5             	mov    %rsp,%rbp
   40ee7:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40eeb:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40ef2:	00 
   40ef3:	e9 81 00 00 00       	jmp    40f79 <pageinfo_init+0x96>
        int owner;
        if (physical_memory_isreserved(addr)) {
   40ef8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40efc:	48 89 c7             	mov    %rax,%rdi
   40eff:	e8 33 0f 00 00       	call   41e37 <physical_memory_isreserved>
   40f04:	85 c0                	test   %eax,%eax
   40f06:	74 09                	je     40f11 <pageinfo_init+0x2e>
            owner = PO_RESERVED;
   40f08:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   40f0f:	eb 2f                	jmp    40f40 <pageinfo_init+0x5d>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   40f11:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   40f18:	00 
   40f19:	76 0b                	jbe    40f26 <pageinfo_init+0x43>
   40f1b:	b8 08 b0 05 00       	mov    $0x5b008,%eax
   40f20:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40f24:	72 0a                	jb     40f30 <pageinfo_init+0x4d>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   40f26:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   40f2d:	00 
   40f2e:	75 09                	jne    40f39 <pageinfo_init+0x56>
            owner = PO_KERNEL;
   40f30:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   40f37:	eb 07                	jmp    40f40 <pageinfo_init+0x5d>
        } else {
            owner = PO_FREE;
   40f39:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40f40:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40f44:	48 c1 e8 0c          	shr    $0xc,%rax
   40f48:	89 c1                	mov    %eax,%ecx
   40f4a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40f4d:	89 c2                	mov    %eax,%edx
   40f4f:	48 63 c1             	movslq %ecx,%rax
   40f52:	88 94 00 40 2e 05 00 	mov    %dl,0x52e40(%rax,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   40f59:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40f5d:	0f 95 c2             	setne  %dl
   40f60:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40f64:	48 c1 e8 0c          	shr    $0xc,%rax
   40f68:	48 98                	cltq   
   40f6a:	88 94 00 41 2e 05 00 	mov    %dl,0x52e41(%rax,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40f71:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40f78:	00 
   40f79:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40f80:	00 
   40f81:	0f 86 71 ff ff ff    	jbe    40ef8 <pageinfo_init+0x15>
    }
}
   40f87:	90                   	nop
   40f88:	90                   	nop
   40f89:	c9                   	leave  
   40f8a:	c3                   	ret    

0000000000040f8b <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   40f8b:	55                   	push   %rbp
   40f8c:	48 89 e5             	mov    %rsp,%rbp
   40f8f:	48 83 ec 50          	sub    $0x50,%rsp
   40f93:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   40f97:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40f9b:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40fa1:	48 89 c2             	mov    %rax,%rdx
   40fa4:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40fa8:	48 39 c2             	cmp    %rax,%rdx
   40fab:	74 14                	je     40fc1 <check_page_table_mappings+0x36>
   40fad:	ba 70 45 04 00       	mov    $0x44570,%edx
   40fb2:	be 1e 02 00 00       	mov    $0x21e,%esi
   40fb7:	bf 20 43 04 00       	mov    $0x44320,%edi
   40fbc:	e8 09 18 00 00       	call   427ca <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40fc1:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   40fc8:	00 
   40fc9:	e9 9a 00 00 00       	jmp    41068 <check_page_table_mappings+0xdd>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   40fce:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   40fd2:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40fd6:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40fda:	48 89 ce             	mov    %rcx,%rsi
   40fdd:	48 89 c7             	mov    %rax,%rdi
   40fe0:	e8 aa 1e 00 00       	call   42e8f <virtual_memory_lookup>
        if (vam.pa != va) {
   40fe5:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40fe9:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40fed:	74 27                	je     41016 <check_page_table_mappings+0x8b>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   40fef:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40ff3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40ff7:	49 89 d0             	mov    %rdx,%r8
   40ffa:	48 89 c1             	mov    %rax,%rcx
   40ffd:	ba 8f 45 04 00       	mov    $0x4458f,%edx
   41002:	be 00 c0 00 00       	mov    $0xc000,%esi
   41007:	bf e0 06 00 00       	mov    $0x6e0,%edi
   4100c:	b8 00 00 00 00       	mov    $0x0,%eax
   41011:	e8 46 31 00 00       	call   4415c <console_printf>
        }
        assert(vam.pa == va);
   41016:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4101a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4101e:	74 14                	je     41034 <check_page_table_mappings+0xa9>
   41020:	ba 99 45 04 00       	mov    $0x44599,%edx
   41025:	be 27 02 00 00       	mov    $0x227,%esi
   4102a:	bf 20 43 04 00       	mov    $0x44320,%edi
   4102f:	e8 96 17 00 00       	call   427ca <assert_fail>
        if (va >= (uintptr_t) start_data) {
   41034:	b8 00 60 04 00       	mov    $0x46000,%eax
   41039:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4103d:	72 21                	jb     41060 <check_page_table_mappings+0xd5>
            assert(vam.perm & PTE_W);
   4103f:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41042:	48 98                	cltq   
   41044:	83 e0 02             	and    $0x2,%eax
   41047:	48 85 c0             	test   %rax,%rax
   4104a:	75 14                	jne    41060 <check_page_table_mappings+0xd5>
   4104c:	ba a6 45 04 00       	mov    $0x445a6,%edx
   41051:	be 29 02 00 00       	mov    $0x229,%esi
   41056:	bf 20 43 04 00       	mov    $0x44320,%edi
   4105b:	e8 6a 17 00 00       	call   427ca <assert_fail>
         va += PAGESIZE) {
   41060:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41067:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   41068:	b8 08 b0 05 00       	mov    $0x5b008,%eax
   4106d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41071:	0f 82 57 ff ff ff    	jb     40fce <check_page_table_mappings+0x43>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   41077:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   4107e:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   4107f:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   41083:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   41087:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   4108b:	48 89 ce             	mov    %rcx,%rsi
   4108e:	48 89 c7             	mov    %rax,%rdi
   41091:	e8 f9 1d 00 00       	call   42e8f <virtual_memory_lookup>
    assert(vam.pa == kstack);
   41096:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4109a:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   4109e:	74 14                	je     410b4 <check_page_table_mappings+0x129>
   410a0:	ba b7 45 04 00       	mov    $0x445b7,%edx
   410a5:	be 30 02 00 00       	mov    $0x230,%esi
   410aa:	bf 20 43 04 00       	mov    $0x44320,%edi
   410af:	e8 16 17 00 00       	call   427ca <assert_fail>
    assert(vam.perm & PTE_W);
   410b4:	8b 45 e8             	mov    -0x18(%rbp),%eax
   410b7:	48 98                	cltq   
   410b9:	83 e0 02             	and    $0x2,%eax
   410bc:	48 85 c0             	test   %rax,%rax
   410bf:	75 14                	jne    410d5 <check_page_table_mappings+0x14a>
   410c1:	ba a6 45 04 00       	mov    $0x445a6,%edx
   410c6:	be 31 02 00 00       	mov    $0x231,%esi
   410cb:	bf 20 43 04 00       	mov    $0x44320,%edi
   410d0:	e8 f5 16 00 00       	call   427ca <assert_fail>
}
   410d5:	90                   	nop
   410d6:	c9                   	leave  
   410d7:	c3                   	ret    

00000000000410d8 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   410d8:	55                   	push   %rbp
   410d9:	48 89 e5             	mov    %rsp,%rbp
   410dc:	48 83 ec 20          	sub    $0x20,%rsp
   410e0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   410e4:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   410e7:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   410ea:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   410ed:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   410f4:	48 8b 05 05 3f 01 00 	mov    0x13f05(%rip),%rax        # 55000 <kernel_pagetable>
   410fb:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   410ff:	75 67                	jne    41168 <check_page_table_ownership+0x90>
        owner = PO_KERNEL;
   41101:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   41108:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   4110f:	eb 51                	jmp    41162 <check_page_table_ownership+0x8a>
            if (processes[xpid].p_state != P_FREE
   41111:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41114:	48 63 d0             	movslq %eax,%rdx
   41117:	48 89 d0             	mov    %rdx,%rax
   4111a:	48 c1 e0 03          	shl    $0x3,%rax
   4111e:	48 29 d0             	sub    %rdx,%rax
   41121:	48 c1 e0 05          	shl    $0x5,%rax
   41125:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   4112b:	8b 00                	mov    (%rax),%eax
   4112d:	85 c0                	test   %eax,%eax
   4112f:	74 2d                	je     4115e <check_page_table_ownership+0x86>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   41131:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41134:	48 63 d0             	movslq %eax,%rdx
   41137:	48 89 d0             	mov    %rdx,%rax
   4113a:	48 c1 e0 03          	shl    $0x3,%rax
   4113e:	48 29 d0             	sub    %rdx,%rax
   41141:	48 c1 e0 05          	shl    $0x5,%rax
   41145:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   4114b:	48 8b 10             	mov    (%rax),%rdx
   4114e:	48 8b 05 ab 3e 01 00 	mov    0x13eab(%rip),%rax        # 55000 <kernel_pagetable>
   41155:	48 39 c2             	cmp    %rax,%rdx
   41158:	75 04                	jne    4115e <check_page_table_ownership+0x86>
                ++expected_refcount;
   4115a:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   4115e:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41162:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   41166:	7e a9                	jle    41111 <check_page_table_ownership+0x39>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   41168:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   4116b:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4116e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41172:	be 00 00 00 00       	mov    $0x0,%esi
   41177:	48 89 c7             	mov    %rax,%rdi
   4117a:	e8 03 00 00 00       	call   41182 <check_page_table_ownership_level>
}
   4117f:	90                   	nop
   41180:	c9                   	leave  
   41181:	c3                   	ret    

0000000000041182 <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   41182:	55                   	push   %rbp
   41183:	48 89 e5             	mov    %rsp,%rbp
   41186:	48 83 ec 30          	sub    $0x30,%rsp
   4118a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4118e:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   41191:	89 55 e0             	mov    %edx,-0x20(%rbp)
   41194:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   41197:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4119b:	48 c1 e8 0c          	shr    $0xc,%rax
   4119f:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   411a4:	7e 14                	jle    411ba <check_page_table_ownership_level+0x38>
   411a6:	ba c8 45 04 00       	mov    $0x445c8,%edx
   411ab:	be 4e 02 00 00       	mov    $0x24e,%esi
   411b0:	bf 20 43 04 00       	mov    $0x44320,%edi
   411b5:	e8 10 16 00 00       	call   427ca <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   411ba:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   411be:	48 c1 e8 0c          	shr    $0xc,%rax
   411c2:	48 98                	cltq   
   411c4:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   411cb:	00 
   411cc:	0f be c0             	movsbl %al,%eax
   411cf:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   411d2:	74 14                	je     411e8 <check_page_table_ownership_level+0x66>
   411d4:	ba e0 45 04 00       	mov    $0x445e0,%edx
   411d9:	be 4f 02 00 00       	mov    $0x24f,%esi
   411de:	bf 20 43 04 00       	mov    $0x44320,%edi
   411e3:	e8 e2 15 00 00       	call   427ca <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   411e8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   411ec:	48 c1 e8 0c          	shr    $0xc,%rax
   411f0:	48 98                	cltq   
   411f2:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   411f9:	00 
   411fa:	0f be c0             	movsbl %al,%eax
   411fd:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   41200:	74 14                	je     41216 <check_page_table_ownership_level+0x94>
   41202:	ba 08 46 04 00       	mov    $0x44608,%edx
   41207:	be 50 02 00 00       	mov    $0x250,%esi
   4120c:	bf 20 43 04 00       	mov    $0x44320,%edi
   41211:	e8 b4 15 00 00       	call   427ca <assert_fail>
    if (level < 3) {
   41216:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   4121a:	7f 5b                	jg     41277 <check_page_table_ownership_level+0xf5>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   4121c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41223:	eb 49                	jmp    4126e <check_page_table_ownership_level+0xec>
            if (pt->entry[index]) {
   41225:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41229:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4122c:	48 63 d2             	movslq %edx,%rdx
   4122f:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41233:	48 85 c0             	test   %rax,%rax
   41236:	74 32                	je     4126a <check_page_table_ownership_level+0xe8>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   41238:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4123c:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4123f:	48 63 d2             	movslq %edx,%rdx
   41242:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41246:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   4124c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   41250:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   41253:	8d 70 01             	lea    0x1(%rax),%esi
   41256:	8b 55 e0             	mov    -0x20(%rbp),%edx
   41259:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4125d:	b9 01 00 00 00       	mov    $0x1,%ecx
   41262:	48 89 c7             	mov    %rax,%rdi
   41265:	e8 18 ff ff ff       	call   41182 <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   4126a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4126e:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41275:	7e ae                	jle    41225 <check_page_table_ownership_level+0xa3>
            }
        }
    }
}
   41277:	90                   	nop
   41278:	c9                   	leave  
   41279:	c3                   	ret    

000000000004127a <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   4127a:	55                   	push   %rbp
   4127b:	48 89 e5             	mov    %rsp,%rbp
   4127e:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   41282:	8b 05 60 0e 01 00    	mov    0x10e60(%rip),%eax        # 520e8 <processes+0xc8>
   41288:	85 c0                	test   %eax,%eax
   4128a:	74 14                	je     412a0 <check_virtual_memory+0x26>
   4128c:	ba 38 46 04 00       	mov    $0x44638,%edx
   41291:	be 63 02 00 00       	mov    $0x263,%esi
   41296:	bf 20 43 04 00       	mov    $0x44320,%edi
   4129b:	e8 2a 15 00 00       	call   427ca <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   412a0:	48 8b 05 59 3d 01 00 	mov    0x13d59(%rip),%rax        # 55000 <kernel_pagetable>
   412a7:	48 89 c7             	mov    %rax,%rdi
   412aa:	e8 dc fc ff ff       	call   40f8b <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   412af:	48 8b 05 4a 3d 01 00 	mov    0x13d4a(%rip),%rax        # 55000 <kernel_pagetable>
   412b6:	be ff ff ff ff       	mov    $0xffffffff,%esi
   412bb:	48 89 c7             	mov    %rax,%rdi
   412be:	e8 15 fe ff ff       	call   410d8 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   412c3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   412ca:	e9 9c 00 00 00       	jmp    4136b <check_virtual_memory+0xf1>
        if (processes[pid].p_state != P_FREE
   412cf:	8b 45 fc             	mov    -0x4(%rbp),%eax
   412d2:	48 63 d0             	movslq %eax,%rdx
   412d5:	48 89 d0             	mov    %rdx,%rax
   412d8:	48 c1 e0 03          	shl    $0x3,%rax
   412dc:	48 29 d0             	sub    %rdx,%rax
   412df:	48 c1 e0 05          	shl    $0x5,%rax
   412e3:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   412e9:	8b 00                	mov    (%rax),%eax
   412eb:	85 c0                	test   %eax,%eax
   412ed:	74 78                	je     41367 <check_virtual_memory+0xed>
            && processes[pid].p_pagetable != kernel_pagetable) {
   412ef:	8b 45 fc             	mov    -0x4(%rbp),%eax
   412f2:	48 63 d0             	movslq %eax,%rdx
   412f5:	48 89 d0             	mov    %rdx,%rax
   412f8:	48 c1 e0 03          	shl    $0x3,%rax
   412fc:	48 29 d0             	sub    %rdx,%rax
   412ff:	48 c1 e0 05          	shl    $0x5,%rax
   41303:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   41309:	48 8b 10             	mov    (%rax),%rdx
   4130c:	48 8b 05 ed 3c 01 00 	mov    0x13ced(%rip),%rax        # 55000 <kernel_pagetable>
   41313:	48 39 c2             	cmp    %rax,%rdx
   41316:	74 4f                	je     41367 <check_virtual_memory+0xed>
            check_page_table_mappings(processes[pid].p_pagetable);
   41318:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4131b:	48 63 d0             	movslq %eax,%rdx
   4131e:	48 89 d0             	mov    %rdx,%rax
   41321:	48 c1 e0 03          	shl    $0x3,%rax
   41325:	48 29 d0             	sub    %rdx,%rax
   41328:	48 c1 e0 05          	shl    $0x5,%rax
   4132c:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   41332:	48 8b 00             	mov    (%rax),%rax
   41335:	48 89 c7             	mov    %rax,%rdi
   41338:	e8 4e fc ff ff       	call   40f8b <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   4133d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41340:	48 63 d0             	movslq %eax,%rdx
   41343:	48 89 d0             	mov    %rdx,%rax
   41346:	48 c1 e0 03          	shl    $0x3,%rax
   4134a:	48 29 d0             	sub    %rdx,%rax
   4134d:	48 c1 e0 05          	shl    $0x5,%rax
   41351:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   41357:	48 8b 00             	mov    (%rax),%rax
   4135a:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4135d:	89 d6                	mov    %edx,%esi
   4135f:	48 89 c7             	mov    %rax,%rdi
   41362:	e8 71 fd ff ff       	call   410d8 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   41367:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4136b:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   4136f:	0f 8e 5a ff ff ff    	jle    412cf <check_virtual_memory+0x55>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41375:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   4137c:	eb 67                	jmp    413e5 <check_virtual_memory+0x16b>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   4137e:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41381:	48 98                	cltq   
   41383:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   4138a:	00 
   4138b:	84 c0                	test   %al,%al
   4138d:	7e 52                	jle    413e1 <check_virtual_memory+0x167>
   4138f:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41392:	48 98                	cltq   
   41394:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   4139b:	00 
   4139c:	84 c0                	test   %al,%al
   4139e:	78 41                	js     413e1 <check_virtual_memory+0x167>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   413a0:	8b 45 f8             	mov    -0x8(%rbp),%eax
   413a3:	48 98                	cltq   
   413a5:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   413ac:	00 
   413ad:	0f be c0             	movsbl %al,%eax
   413b0:	48 63 d0             	movslq %eax,%rdx
   413b3:	48 89 d0             	mov    %rdx,%rax
   413b6:	48 c1 e0 03          	shl    $0x3,%rax
   413ba:	48 29 d0             	sub    %rdx,%rax
   413bd:	48 c1 e0 05          	shl    $0x5,%rax
   413c1:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   413c7:	8b 00                	mov    (%rax),%eax
   413c9:	85 c0                	test   %eax,%eax
   413cb:	75 14                	jne    413e1 <check_virtual_memory+0x167>
   413cd:	ba 58 46 04 00       	mov    $0x44658,%edx
   413d2:	be 7a 02 00 00       	mov    $0x27a,%esi
   413d7:	bf 20 43 04 00       	mov    $0x44320,%edi
   413dc:	e8 e9 13 00 00       	call   427ca <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   413e1:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   413e5:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   413ec:	7e 90                	jle    4137e <check_virtual_memory+0x104>
        }
    }
}
   413ee:	90                   	nop
   413ef:	90                   	nop
   413f0:	c9                   	leave  
   413f1:	c3                   	ret    

00000000000413f2 <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   413f2:	55                   	push   %rbp
   413f3:	48 89 e5             	mov    %rsp,%rbp
   413f6:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   413fa:	ba c6 46 04 00       	mov    $0x446c6,%edx
   413ff:	be 00 0f 00 00       	mov    $0xf00,%esi
   41404:	bf 20 00 00 00       	mov    $0x20,%edi
   41409:	b8 00 00 00 00       	mov    $0x0,%eax
   4140e:	e8 49 2d 00 00       	call   4415c <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41413:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4141a:	e9 f8 00 00 00       	jmp    41517 <memshow_physical+0x125>
        if (pn % 64 == 0) {
   4141f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41422:	83 e0 3f             	and    $0x3f,%eax
   41425:	85 c0                	test   %eax,%eax
   41427:	75 3c                	jne    41465 <memshow_physical+0x73>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   41429:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4142c:	c1 e0 0c             	shl    $0xc,%eax
   4142f:	89 c1                	mov    %eax,%ecx
   41431:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41434:	8d 50 3f             	lea    0x3f(%rax),%edx
   41437:	85 c0                	test   %eax,%eax
   41439:	0f 48 c2             	cmovs  %edx,%eax
   4143c:	c1 f8 06             	sar    $0x6,%eax
   4143f:	8d 50 01             	lea    0x1(%rax),%edx
   41442:	89 d0                	mov    %edx,%eax
   41444:	c1 e0 02             	shl    $0x2,%eax
   41447:	01 d0                	add    %edx,%eax
   41449:	c1 e0 04             	shl    $0x4,%eax
   4144c:	83 c0 03             	add    $0x3,%eax
   4144f:	ba d6 46 04 00       	mov    $0x446d6,%edx
   41454:	be 00 0f 00 00       	mov    $0xf00,%esi
   41459:	89 c7                	mov    %eax,%edi
   4145b:	b8 00 00 00 00       	mov    $0x0,%eax
   41460:	e8 f7 2c 00 00       	call   4415c <console_printf>
        }

        int owner = pageinfo[pn].owner;
   41465:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41468:	48 98                	cltq   
   4146a:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   41471:	00 
   41472:	0f be c0             	movsbl %al,%eax
   41475:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   41478:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4147b:	48 98                	cltq   
   4147d:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   41484:	00 
   41485:	84 c0                	test   %al,%al
   41487:	75 07                	jne    41490 <memshow_physical+0x9e>
            owner = PO_FREE;
   41489:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   41490:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41493:	83 c0 02             	add    $0x2,%eax
   41496:	48 98                	cltq   
   41498:	0f b7 84 00 a0 46 04 	movzwl 0x446a0(%rax,%rax,1),%eax
   4149f:	00 
   414a0:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   414a4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   414a7:	48 98                	cltq   
   414a9:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   414b0:	00 
   414b1:	3c 01                	cmp    $0x1,%al
   414b3:	7e 1a                	jle    414cf <memshow_physical+0xdd>
   414b5:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   414ba:	48 c1 e8 0c          	shr    $0xc,%rax
   414be:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   414c1:	74 0c                	je     414cf <memshow_physical+0xdd>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   414c3:	b8 53 00 00 00       	mov    $0x53,%eax
   414c8:	80 cc 0f             	or     $0xf,%ah
   414cb:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   414cf:	8b 45 fc             	mov    -0x4(%rbp),%eax
   414d2:	8d 50 3f             	lea    0x3f(%rax),%edx
   414d5:	85 c0                	test   %eax,%eax
   414d7:	0f 48 c2             	cmovs  %edx,%eax
   414da:	c1 f8 06             	sar    $0x6,%eax
   414dd:	8d 50 01             	lea    0x1(%rax),%edx
   414e0:	89 d0                	mov    %edx,%eax
   414e2:	c1 e0 02             	shl    $0x2,%eax
   414e5:	01 d0                	add    %edx,%eax
   414e7:	c1 e0 04             	shl    $0x4,%eax
   414ea:	89 c1                	mov    %eax,%ecx
   414ec:	8b 55 fc             	mov    -0x4(%rbp),%edx
   414ef:	89 d0                	mov    %edx,%eax
   414f1:	c1 f8 1f             	sar    $0x1f,%eax
   414f4:	c1 e8 1a             	shr    $0x1a,%eax
   414f7:	01 c2                	add    %eax,%edx
   414f9:	83 e2 3f             	and    $0x3f,%edx
   414fc:	29 c2                	sub    %eax,%edx
   414fe:	89 d0                	mov    %edx,%eax
   41500:	83 c0 0c             	add    $0xc,%eax
   41503:	01 c8                	add    %ecx,%eax
   41505:	48 98                	cltq   
   41507:	0f b7 55 f6          	movzwl -0xa(%rbp),%edx
   4150b:	66 89 94 00 00 80 0b 	mov    %dx,0xb8000(%rax,%rax,1)
   41512:	00 
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41513:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41517:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   4151e:	0f 8e fb fe ff ff    	jle    4141f <memshow_physical+0x2d>
    }
}
   41524:	90                   	nop
   41525:	90                   	nop
   41526:	c9                   	leave  
   41527:	c3                   	ret    

0000000000041528 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   41528:	55                   	push   %rbp
   41529:	48 89 e5             	mov    %rsp,%rbp
   4152c:	48 83 ec 40          	sub    $0x40,%rsp
   41530:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   41534:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   41538:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4153c:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   41542:	48 89 c2             	mov    %rax,%rdx
   41545:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41549:	48 39 c2             	cmp    %rax,%rdx
   4154c:	74 14                	je     41562 <memshow_virtual+0x3a>
   4154e:	ba e0 46 04 00       	mov    $0x446e0,%edx
   41553:	be ab 02 00 00       	mov    $0x2ab,%esi
   41558:	bf 20 43 04 00       	mov    $0x44320,%edi
   4155d:	e8 68 12 00 00       	call   427ca <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   41562:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   41566:	48 89 c1             	mov    %rax,%rcx
   41569:	ba 0d 47 04 00       	mov    $0x4470d,%edx
   4156e:	be 00 0f 00 00       	mov    $0xf00,%esi
   41573:	bf 3a 03 00 00       	mov    $0x33a,%edi
   41578:	b8 00 00 00 00       	mov    $0x0,%eax
   4157d:	e8 da 2b 00 00       	call   4415c <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41582:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   41589:	00 
   4158a:	e9 80 01 00 00       	jmp    4170f <memshow_virtual+0x1e7>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   4158f:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   41593:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   41597:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   4159b:	48 89 ce             	mov    %rcx,%rsi
   4159e:	48 89 c7             	mov    %rax,%rdi
   415a1:	e8 e9 18 00 00       	call   42e8f <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   415a6:	8b 45 d0             	mov    -0x30(%rbp),%eax
   415a9:	85 c0                	test   %eax,%eax
   415ab:	79 0b                	jns    415b8 <memshow_virtual+0x90>
            color = ' ';
   415ad:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   415b3:	e9 d7 00 00 00       	jmp    4168f <memshow_virtual+0x167>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   415b8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   415bc:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   415c2:	76 14                	jbe    415d8 <memshow_virtual+0xb0>
   415c4:	ba 2a 47 04 00       	mov    $0x4472a,%edx
   415c9:	be b4 02 00 00       	mov    $0x2b4,%esi
   415ce:	bf 20 43 04 00       	mov    $0x44320,%edi
   415d3:	e8 f2 11 00 00       	call   427ca <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   415d8:	8b 45 d0             	mov    -0x30(%rbp),%eax
   415db:	48 98                	cltq   
   415dd:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   415e4:	00 
   415e5:	0f be c0             	movsbl %al,%eax
   415e8:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   415eb:	8b 45 d0             	mov    -0x30(%rbp),%eax
   415ee:	48 98                	cltq   
   415f0:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   415f7:	00 
   415f8:	84 c0                	test   %al,%al
   415fa:	75 07                	jne    41603 <memshow_virtual+0xdb>
                owner = PO_FREE;
   415fc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   41603:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41606:	83 c0 02             	add    $0x2,%eax
   41609:	48 98                	cltq   
   4160b:	0f b7 84 00 a0 46 04 	movzwl 0x446a0(%rax,%rax,1),%eax
   41612:	00 
   41613:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   41617:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4161a:	48 98                	cltq   
   4161c:	83 e0 04             	and    $0x4,%eax
   4161f:	48 85 c0             	test   %rax,%rax
   41622:	74 27                	je     4164b <memshow_virtual+0x123>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41624:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41628:	c1 e0 04             	shl    $0x4,%eax
   4162b:	66 25 00 f0          	and    $0xf000,%ax
   4162f:	89 c2                	mov    %eax,%edx
   41631:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41635:	c1 f8 04             	sar    $0x4,%eax
   41638:	66 25 00 0f          	and    $0xf00,%ax
   4163c:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   4163e:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41642:	0f b6 c0             	movzbl %al,%eax
   41645:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41647:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   4164b:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4164e:	48 98                	cltq   
   41650:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   41657:	00 
   41658:	3c 01                	cmp    $0x1,%al
   4165a:	7e 33                	jle    4168f <memshow_virtual+0x167>
   4165c:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   41661:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41665:	74 28                	je     4168f <memshow_virtual+0x167>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   41667:	b8 53 00 00 00       	mov    $0x53,%eax
   4166c:	89 c2                	mov    %eax,%edx
   4166e:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41672:	66 25 00 f0          	and    $0xf000,%ax
   41676:	09 d0                	or     %edx,%eax
   41678:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   4167c:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4167f:	48 98                	cltq   
   41681:	83 e0 04             	and    $0x4,%eax
   41684:	48 85 c0             	test   %rax,%rax
   41687:	75 06                	jne    4168f <memshow_virtual+0x167>
                    color = color | 0x0F00;
   41689:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   4168f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41693:	48 c1 e8 0c          	shr    $0xc,%rax
   41697:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   4169a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4169d:	83 e0 3f             	and    $0x3f,%eax
   416a0:	85 c0                	test   %eax,%eax
   416a2:	75 34                	jne    416d8 <memshow_virtual+0x1b0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   416a4:	8b 45 ec             	mov    -0x14(%rbp),%eax
   416a7:	c1 e8 06             	shr    $0x6,%eax
   416aa:	89 c2                	mov    %eax,%edx
   416ac:	89 d0                	mov    %edx,%eax
   416ae:	c1 e0 02             	shl    $0x2,%eax
   416b1:	01 d0                	add    %edx,%eax
   416b3:	c1 e0 04             	shl    $0x4,%eax
   416b6:	05 73 03 00 00       	add    $0x373,%eax
   416bb:	89 c7                	mov    %eax,%edi
   416bd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   416c1:	48 89 c1             	mov    %rax,%rcx
   416c4:	ba d6 46 04 00       	mov    $0x446d6,%edx
   416c9:	be 00 0f 00 00       	mov    $0xf00,%esi
   416ce:	b8 00 00 00 00       	mov    $0x0,%eax
   416d3:	e8 84 2a 00 00       	call   4415c <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   416d8:	8b 45 ec             	mov    -0x14(%rbp),%eax
   416db:	c1 e8 06             	shr    $0x6,%eax
   416de:	89 c2                	mov    %eax,%edx
   416e0:	89 d0                	mov    %edx,%eax
   416e2:	c1 e0 02             	shl    $0x2,%eax
   416e5:	01 d0                	add    %edx,%eax
   416e7:	c1 e0 04             	shl    $0x4,%eax
   416ea:	89 c2                	mov    %eax,%edx
   416ec:	8b 45 ec             	mov    -0x14(%rbp),%eax
   416ef:	83 e0 3f             	and    $0x3f,%eax
   416f2:	01 d0                	add    %edx,%eax
   416f4:	05 7c 03 00 00       	add    $0x37c,%eax
   416f9:	89 c2                	mov    %eax,%edx
   416fb:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   416ff:	66 89 84 12 00 80 0b 	mov    %ax,0xb8000(%rdx,%rdx,1)
   41706:	00 
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41707:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4170e:	00 
   4170f:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   41716:	00 
   41717:	0f 86 72 fe ff ff    	jbe    4158f <memshow_virtual+0x67>
    }
}
   4171d:	90                   	nop
   4171e:	90                   	nop
   4171f:	c9                   	leave  
   41720:	c3                   	ret    

0000000000041721 <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   41721:	55                   	push   %rbp
   41722:	48 89 e5             	mov    %rsp,%rbp
   41725:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   41729:	8b 05 11 1b 01 00    	mov    0x11b11(%rip),%eax        # 53240 <last_ticks.1>
   4172f:	85 c0                	test   %eax,%eax
   41731:	74 13                	je     41746 <memshow_virtual_animate+0x25>
   41733:	8b 15 e7 16 01 00    	mov    0x116e7(%rip),%edx        # 52e20 <ticks>
   41739:	8b 05 01 1b 01 00    	mov    0x11b01(%rip),%eax        # 53240 <last_ticks.1>
   4173f:	29 c2                	sub    %eax,%edx
   41741:	83 fa 31             	cmp    $0x31,%edx
   41744:	76 2c                	jbe    41772 <memshow_virtual_animate+0x51>
        last_ticks = ticks;
   41746:	8b 05 d4 16 01 00    	mov    0x116d4(%rip),%eax        # 52e20 <ticks>
   4174c:	89 05 ee 1a 01 00    	mov    %eax,0x11aee(%rip)        # 53240 <last_ticks.1>
        ++showing;
   41752:	8b 05 ac 48 00 00    	mov    0x48ac(%rip),%eax        # 46004 <showing.0>
   41758:	83 c0 01             	add    $0x1,%eax
   4175b:	89 05 a3 48 00 00    	mov    %eax,0x48a3(%rip)        # 46004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   41761:	eb 0f                	jmp    41772 <memshow_virtual_animate+0x51>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
        ++showing;
   41763:	8b 05 9b 48 00 00    	mov    0x489b(%rip),%eax        # 46004 <showing.0>
   41769:	83 c0 01             	add    $0x1,%eax
   4176c:	89 05 92 48 00 00    	mov    %eax,0x4892(%rip)        # 46004 <showing.0>
    while (showing <= 2*NPROC
   41772:	8b 05 8c 48 00 00    	mov    0x488c(%rip),%eax        # 46004 <showing.0>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
   41778:	83 f8 20             	cmp    $0x20,%eax
   4177b:	7f 6d                	jg     417ea <memshow_virtual_animate+0xc9>
   4177d:	8b 15 81 48 00 00    	mov    0x4881(%rip),%edx        # 46004 <showing.0>
   41783:	89 d0                	mov    %edx,%eax
   41785:	c1 f8 1f             	sar    $0x1f,%eax
   41788:	c1 e8 1c             	shr    $0x1c,%eax
   4178b:	01 c2                	add    %eax,%edx
   4178d:	83 e2 0f             	and    $0xf,%edx
   41790:	29 c2                	sub    %eax,%edx
   41792:	89 d0                	mov    %edx,%eax
   41794:	48 63 d0             	movslq %eax,%rdx
   41797:	48 89 d0             	mov    %rdx,%rax
   4179a:	48 c1 e0 03          	shl    $0x3,%rax
   4179e:	48 29 d0             	sub    %rdx,%rax
   417a1:	48 c1 e0 05          	shl    $0x5,%rax
   417a5:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   417ab:	8b 00                	mov    (%rax),%eax
   417ad:	85 c0                	test   %eax,%eax
   417af:	74 b2                	je     41763 <memshow_virtual_animate+0x42>
   417b1:	8b 15 4d 48 00 00    	mov    0x484d(%rip),%edx        # 46004 <showing.0>
   417b7:	89 d0                	mov    %edx,%eax
   417b9:	c1 f8 1f             	sar    $0x1f,%eax
   417bc:	c1 e8 1c             	shr    $0x1c,%eax
   417bf:	01 c2                	add    %eax,%edx
   417c1:	83 e2 0f             	and    $0xf,%edx
   417c4:	29 c2                	sub    %eax,%edx
   417c6:	89 d0                	mov    %edx,%eax
   417c8:	48 63 d0             	movslq %eax,%rdx
   417cb:	48 89 d0             	mov    %rdx,%rax
   417ce:	48 c1 e0 03          	shl    $0x3,%rax
   417d2:	48 29 d0             	sub    %rdx,%rax
   417d5:	48 c1 e0 05          	shl    $0x5,%rax
   417d9:	48 05 f8 20 05 00    	add    $0x520f8,%rax
   417df:	0f b6 00             	movzbl (%rax),%eax
   417e2:	84 c0                	test   %al,%al
   417e4:	0f 84 79 ff ff ff    	je     41763 <memshow_virtual_animate+0x42>
    }
    showing = showing % NPROC;
   417ea:	8b 15 14 48 00 00    	mov    0x4814(%rip),%edx        # 46004 <showing.0>
   417f0:	89 d0                	mov    %edx,%eax
   417f2:	c1 f8 1f             	sar    $0x1f,%eax
   417f5:	c1 e8 1c             	shr    $0x1c,%eax
   417f8:	01 c2                	add    %eax,%edx
   417fa:	83 e2 0f             	and    $0xf,%edx
   417fd:	29 c2                	sub    %eax,%edx
   417ff:	89 d0                	mov    %edx,%eax
   41801:	89 05 fd 47 00 00    	mov    %eax,0x47fd(%rip)        # 46004 <showing.0>

    if (processes[showing].p_state != P_FREE) {
   41807:	8b 05 f7 47 00 00    	mov    0x47f7(%rip),%eax        # 46004 <showing.0>
   4180d:	48 63 d0             	movslq %eax,%rdx
   41810:	48 89 d0             	mov    %rdx,%rax
   41813:	48 c1 e0 03          	shl    $0x3,%rax
   41817:	48 29 d0             	sub    %rdx,%rax
   4181a:	48 c1 e0 05          	shl    $0x5,%rax
   4181e:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   41824:	8b 00                	mov    (%rax),%eax
   41826:	85 c0                	test   %eax,%eax
   41828:	74 52                	je     4187c <memshow_virtual_animate+0x15b>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   4182a:	8b 15 d4 47 00 00    	mov    0x47d4(%rip),%edx        # 46004 <showing.0>
   41830:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   41834:	89 d1                	mov    %edx,%ecx
   41836:	ba 44 47 04 00       	mov    $0x44744,%edx
   4183b:	be 04 00 00 00       	mov    $0x4,%esi
   41840:	48 89 c7             	mov    %rax,%rdi
   41843:	b8 00 00 00 00       	mov    $0x0,%eax
   41848:	e8 1b 2a 00 00       	call   44268 <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   4184d:	8b 05 b1 47 00 00    	mov    0x47b1(%rip),%eax        # 46004 <showing.0>
   41853:	48 63 d0             	movslq %eax,%rdx
   41856:	48 89 d0             	mov    %rdx,%rax
   41859:	48 c1 e0 03          	shl    $0x3,%rax
   4185d:	48 29 d0             	sub    %rdx,%rax
   41860:	48 c1 e0 05          	shl    $0x5,%rax
   41864:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   4186a:	48 8b 00             	mov    (%rax),%rax
   4186d:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   41871:	48 89 d6             	mov    %rdx,%rsi
   41874:	48 89 c7             	mov    %rax,%rdi
   41877:	e8 ac fc ff ff       	call   41528 <memshow_virtual>
    }
}
   4187c:	90                   	nop
   4187d:	c9                   	leave  
   4187e:	c3                   	ret    

000000000004187f <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   4187f:	55                   	push   %rbp
   41880:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   41883:	e8 4f 01 00 00       	call   419d7 <segments_init>
    interrupt_init();
   41888:	e8 d0 03 00 00       	call   41c5d <interrupt_init>
    virtual_memory_init();
   4188d:	e8 f3 0f 00 00       	call   42885 <virtual_memory_init>
}
   41892:	90                   	nop
   41893:	5d                   	pop    %rbp
   41894:	c3                   	ret    

0000000000041895 <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   41895:	55                   	push   %rbp
   41896:	48 89 e5             	mov    %rsp,%rbp
   41899:	48 83 ec 18          	sub    $0x18,%rsp
   4189d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   418a1:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   418a5:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   418a8:	8b 45 ec             	mov    -0x14(%rbp),%eax
   418ab:	48 98                	cltq   
   418ad:	48 c1 e0 2d          	shl    $0x2d,%rax
   418b1:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   418b5:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   418bc:	90 00 00 
   418bf:	48 09 c2             	or     %rax,%rdx
    *segment = type
   418c2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   418c6:	48 89 10             	mov    %rdx,(%rax)
}
   418c9:	90                   	nop
   418ca:	c9                   	leave  
   418cb:	c3                   	ret    

00000000000418cc <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   418cc:	55                   	push   %rbp
   418cd:	48 89 e5             	mov    %rsp,%rbp
   418d0:	48 83 ec 28          	sub    $0x28,%rsp
   418d4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   418d8:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   418dc:	89 55 ec             	mov    %edx,-0x14(%rbp)
   418df:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   418e3:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   418e7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   418eb:	48 c1 e0 10          	shl    $0x10,%rax
   418ef:	48 89 c2             	mov    %rax,%rdx
   418f2:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   418f9:	00 00 00 
   418fc:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   418ff:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41903:	48 c1 e0 20          	shl    $0x20,%rax
   41907:	48 89 c1             	mov    %rax,%rcx
   4190a:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   41911:	00 00 ff 
   41914:	48 21 c8             	and    %rcx,%rax
   41917:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   4191a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4191e:	48 83 e8 01          	sub    $0x1,%rax
   41922:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   41925:	48 09 d0             	or     %rdx,%rax
        | type
   41928:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   4192c:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4192f:	48 63 d2             	movslq %edx,%rdx
   41932:	48 c1 e2 2d          	shl    $0x2d,%rdx
   41936:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   41939:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   41940:	80 00 00 
   41943:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41946:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4194a:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   4194d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41951:	48 83 c0 08          	add    $0x8,%rax
   41955:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   41959:	48 c1 ea 20          	shr    $0x20,%rdx
   4195d:	48 89 10             	mov    %rdx,(%rax)
}
   41960:	90                   	nop
   41961:	c9                   	leave  
   41962:	c3                   	ret    

0000000000041963 <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   41963:	55                   	push   %rbp
   41964:	48 89 e5             	mov    %rsp,%rbp
   41967:	48 83 ec 20          	sub    $0x20,%rsp
   4196b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4196f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41973:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41976:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   4197a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4197e:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   41981:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   41985:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41988:	48 63 d2             	movslq %edx,%rdx
   4198b:	48 c1 e2 2d          	shl    $0x2d,%rdx
   4198f:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   41992:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41996:	48 c1 e0 20          	shl    $0x20,%rax
   4199a:	48 89 c1             	mov    %rax,%rcx
   4199d:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   419a4:	00 ff ff 
   419a7:	48 21 c8             	and    %rcx,%rax
   419aa:	48 09 c2             	or     %rax,%rdx
   419ad:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   419b4:	80 00 00 
   419b7:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   419ba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   419be:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   419c1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   419c5:	48 c1 e8 20          	shr    $0x20,%rax
   419c9:	48 89 c2             	mov    %rax,%rdx
   419cc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   419d0:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   419d4:	90                   	nop
   419d5:	c9                   	leave  
   419d6:	c3                   	ret    

00000000000419d7 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   419d7:	55                   	push   %rbp
   419d8:	48 89 e5             	mov    %rsp,%rbp
   419db:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   419df:	48 c7 05 76 18 01 00 	movq   $0x0,0x11876(%rip)        # 53260 <segments>
   419e6:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   419ea:	ba 00 00 00 00       	mov    $0x0,%edx
   419ef:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   419f6:	08 20 00 
   419f9:	48 89 c6             	mov    %rax,%rsi
   419fc:	bf 68 32 05 00       	mov    $0x53268,%edi
   41a01:	e8 8f fe ff ff       	call   41895 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   41a06:	ba 03 00 00 00       	mov    $0x3,%edx
   41a0b:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41a12:	08 20 00 
   41a15:	48 89 c6             	mov    %rax,%rsi
   41a18:	bf 70 32 05 00       	mov    $0x53270,%edi
   41a1d:	e8 73 fe ff ff       	call   41895 <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   41a22:	ba 00 00 00 00       	mov    $0x0,%edx
   41a27:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41a2e:	02 00 00 
   41a31:	48 89 c6             	mov    %rax,%rsi
   41a34:	bf 78 32 05 00       	mov    $0x53278,%edi
   41a39:	e8 57 fe ff ff       	call   41895 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   41a3e:	ba 03 00 00 00       	mov    $0x3,%edx
   41a43:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41a4a:	02 00 00 
   41a4d:	48 89 c6             	mov    %rax,%rsi
   41a50:	bf 80 32 05 00       	mov    $0x53280,%edi
   41a55:	e8 3b fe ff ff       	call   41895 <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   41a5a:	b8 a0 42 05 00       	mov    $0x542a0,%eax
   41a5f:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   41a65:	48 89 c1             	mov    %rax,%rcx
   41a68:	ba 00 00 00 00       	mov    $0x0,%edx
   41a6d:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   41a74:	09 00 00 
   41a77:	48 89 c6             	mov    %rax,%rsi
   41a7a:	bf 88 32 05 00       	mov    $0x53288,%edi
   41a7f:	e8 48 fe ff ff       	call   418cc <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   41a84:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   41a8a:	b8 60 32 05 00       	mov    $0x53260,%eax
   41a8f:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   41a93:	ba 60 00 00 00       	mov    $0x60,%edx
   41a98:	be 00 00 00 00       	mov    $0x0,%esi
   41a9d:	bf a0 42 05 00       	mov    $0x542a0,%edi
   41aa2:	e8 fe 18 00 00       	call   433a5 <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   41aa7:	48 c7 05 f2 27 01 00 	movq   $0x80000,0x127f2(%rip)        # 542a4 <kernel_task_descriptor+0x4>
   41aae:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   41ab2:	ba 00 10 00 00       	mov    $0x1000,%edx
   41ab7:	be 00 00 00 00       	mov    $0x0,%esi
   41abc:	bf a0 32 05 00       	mov    $0x532a0,%edi
   41ac1:	e8 df 18 00 00       	call   433a5 <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41ac6:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   41acd:	eb 30                	jmp    41aff <segments_init+0x128>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   41acf:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   41ad4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41ad7:	48 c1 e0 04          	shl    $0x4,%rax
   41adb:	48 05 a0 32 05 00    	add    $0x532a0,%rax
   41ae1:	48 89 d1             	mov    %rdx,%rcx
   41ae4:	ba 00 00 00 00       	mov    $0x0,%edx
   41ae9:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41af0:	0e 00 00 
   41af3:	48 89 c7             	mov    %rax,%rdi
   41af6:	e8 68 fe ff ff       	call   41963 <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41afb:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41aff:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   41b06:	76 c7                	jbe    41acf <segments_init+0xf8>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   41b08:	b8 36 00 04 00       	mov    $0x40036,%eax
   41b0d:	48 89 c1             	mov    %rax,%rcx
   41b10:	ba 00 00 00 00       	mov    $0x0,%edx
   41b15:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41b1c:	0e 00 00 
   41b1f:	48 89 c6             	mov    %rax,%rsi
   41b22:	bf a0 34 05 00       	mov    $0x534a0,%edi
   41b27:	e8 37 fe ff ff       	call   41963 <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   41b2c:	b8 2e 00 04 00       	mov    $0x4002e,%eax
   41b31:	48 89 c1             	mov    %rax,%rcx
   41b34:	ba 00 00 00 00       	mov    $0x0,%edx
   41b39:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41b40:	0e 00 00 
   41b43:	48 89 c6             	mov    %rax,%rsi
   41b46:	bf 70 33 05 00       	mov    $0x53370,%edi
   41b4b:	e8 13 fe ff ff       	call   41963 <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   41b50:	b8 32 00 04 00       	mov    $0x40032,%eax
   41b55:	48 89 c1             	mov    %rax,%rcx
   41b58:	ba 00 00 00 00       	mov    $0x0,%edx
   41b5d:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41b64:	0e 00 00 
   41b67:	48 89 c6             	mov    %rax,%rsi
   41b6a:	bf 80 33 05 00       	mov    $0x53380,%edi
   41b6f:	e8 ef fd ff ff       	call   41963 <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41b74:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   41b7b:	eb 3e                	jmp    41bbb <segments_init+0x1e4>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   41b7d:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41b80:	83 e8 30             	sub    $0x30,%eax
   41b83:	89 c0                	mov    %eax,%eax
   41b85:	48 8b 04 c5 e7 00 04 	mov    0x400e7(,%rax,8),%rax
   41b8c:	00 
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   41b8d:	48 89 c2             	mov    %rax,%rdx
   41b90:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41b93:	48 c1 e0 04          	shl    $0x4,%rax
   41b97:	48 05 a0 32 05 00    	add    $0x532a0,%rax
   41b9d:	48 89 d1             	mov    %rdx,%rcx
   41ba0:	ba 03 00 00 00       	mov    $0x3,%edx
   41ba5:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41bac:	0e 00 00 
   41baf:	48 89 c7             	mov    %rax,%rdi
   41bb2:	e8 ac fd ff ff       	call   41963 <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41bb7:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41bbb:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   41bbf:	76 bc                	jbe    41b7d <segments_init+0x1a6>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   41bc1:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   41bc7:	b8 a0 32 05 00       	mov    $0x532a0,%eax
   41bcc:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   41bd0:	b8 28 00 00 00       	mov    $0x28,%eax
   41bd5:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   41bd9:	0f 00 d8             	ltr    %ax
   41bdc:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   41be0:	0f 20 c0             	mov    %cr0,%rax
   41be3:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   41be7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   41beb:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   41bee:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   41bf5:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41bf8:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   41bfb:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41bfe:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   41c02:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41c06:	0f 22 c0             	mov    %rax,%cr0
}
   41c09:	90                   	nop
    lcr0(cr0);
}
   41c0a:	90                   	nop
   41c0b:	c9                   	leave  
   41c0c:	c3                   	ret    

0000000000041c0d <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   41c0d:	55                   	push   %rbp
   41c0e:	48 89 e5             	mov    %rsp,%rbp
   41c11:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   41c15:	0f b7 05 e4 26 01 00 	movzwl 0x126e4(%rip),%eax        # 54300 <interrupts_enabled>
   41c1c:	f7 d0                	not    %eax
   41c1e:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   41c22:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41c26:	0f b6 c0             	movzbl %al,%eax
   41c29:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   41c30:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c33:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   41c37:	8b 55 f0             	mov    -0x10(%rbp),%edx
   41c3a:	ee                   	out    %al,(%dx)
}
   41c3b:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   41c3c:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41c40:	66 c1 e8 08          	shr    $0x8,%ax
   41c44:	0f b6 c0             	movzbl %al,%eax
   41c47:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   41c4e:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c51:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   41c55:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41c58:	ee                   	out    %al,(%dx)
}
   41c59:	90                   	nop
}
   41c5a:	90                   	nop
   41c5b:	c9                   	leave  
   41c5c:	c3                   	ret    

0000000000041c5d <interrupt_init>:

void interrupt_init(void) {
   41c5d:	55                   	push   %rbp
   41c5e:	48 89 e5             	mov    %rsp,%rbp
   41c61:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   41c65:	66 c7 05 92 26 01 00 	movw   $0x0,0x12692(%rip)        # 54300 <interrupts_enabled>
   41c6c:	00 00 
    interrupt_mask();
   41c6e:	e8 9a ff ff ff       	call   41c0d <interrupt_mask>
   41c73:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   41c7a:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c7e:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   41c82:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   41c85:	ee                   	out    %al,(%dx)
}
   41c86:	90                   	nop
   41c87:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   41c8e:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c92:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   41c96:	8b 55 ac             	mov    -0x54(%rbp),%edx
   41c99:	ee                   	out    %al,(%dx)
}
   41c9a:	90                   	nop
   41c9b:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   41ca2:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ca6:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   41caa:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   41cad:	ee                   	out    %al,(%dx)
}
   41cae:	90                   	nop
   41caf:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   41cb6:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41cba:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   41cbe:	8b 55 bc             	mov    -0x44(%rbp),%edx
   41cc1:	ee                   	out    %al,(%dx)
}
   41cc2:	90                   	nop
   41cc3:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   41cca:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41cce:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   41cd2:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   41cd5:	ee                   	out    %al,(%dx)
}
   41cd6:	90                   	nop
   41cd7:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   41cde:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ce2:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   41ce6:	8b 55 cc             	mov    -0x34(%rbp),%edx
   41ce9:	ee                   	out    %al,(%dx)
}
   41cea:	90                   	nop
   41ceb:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   41cf2:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41cf6:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   41cfa:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   41cfd:	ee                   	out    %al,(%dx)
}
   41cfe:	90                   	nop
   41cff:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   41d06:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d0a:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   41d0e:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41d11:	ee                   	out    %al,(%dx)
}
   41d12:	90                   	nop
   41d13:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   41d1a:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d1e:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41d22:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41d25:	ee                   	out    %al,(%dx)
}
   41d26:	90                   	nop
   41d27:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   41d2e:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d32:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41d36:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41d39:	ee                   	out    %al,(%dx)
}
   41d3a:	90                   	nop
   41d3b:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   41d42:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d46:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41d4a:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41d4d:	ee                   	out    %al,(%dx)
}
   41d4e:	90                   	nop
   41d4f:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   41d56:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d5a:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41d5e:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41d61:	ee                   	out    %al,(%dx)
}
   41d62:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   41d63:	e8 a5 fe ff ff       	call   41c0d <interrupt_mask>
}
   41d68:	90                   	nop
   41d69:	c9                   	leave  
   41d6a:	c3                   	ret    

0000000000041d6b <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   41d6b:	55                   	push   %rbp
   41d6c:	48 89 e5             	mov    %rsp,%rbp
   41d6f:	48 83 ec 28          	sub    $0x28,%rsp
   41d73:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   41d76:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41d7a:	0f 8e 9e 00 00 00    	jle    41e1e <timer_init+0xb3>
   41d80:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   41d87:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d8b:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41d8f:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41d92:	ee                   	out    %al,(%dx)
}
   41d93:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   41d94:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41d97:	89 c2                	mov    %eax,%edx
   41d99:	c1 ea 1f             	shr    $0x1f,%edx
   41d9c:	01 d0                	add    %edx,%eax
   41d9e:	d1 f8                	sar    %eax
   41da0:	05 de 34 12 00       	add    $0x1234de,%eax
   41da5:	99                   	cltd   
   41da6:	f7 7d dc             	idivl  -0x24(%rbp)
   41da9:	89 c2                	mov    %eax,%edx
   41dab:	89 d0                	mov    %edx,%eax
   41dad:	c1 f8 1f             	sar    $0x1f,%eax
   41db0:	c1 e8 18             	shr    $0x18,%eax
   41db3:	01 c2                	add    %eax,%edx
   41db5:	0f b6 d2             	movzbl %dl,%edx
   41db8:	29 c2                	sub    %eax,%edx
   41dba:	89 d0                	mov    %edx,%eax
   41dbc:	0f b6 c0             	movzbl %al,%eax
   41dbf:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   41dc6:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41dc9:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41dcd:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41dd0:	ee                   	out    %al,(%dx)
}
   41dd1:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   41dd2:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41dd5:	89 c2                	mov    %eax,%edx
   41dd7:	c1 ea 1f             	shr    $0x1f,%edx
   41dda:	01 d0                	add    %edx,%eax
   41ddc:	d1 f8                	sar    %eax
   41dde:	05 de 34 12 00       	add    $0x1234de,%eax
   41de3:	99                   	cltd   
   41de4:	f7 7d dc             	idivl  -0x24(%rbp)
   41de7:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41ded:	85 c0                	test   %eax,%eax
   41def:	0f 48 c2             	cmovs  %edx,%eax
   41df2:	c1 f8 08             	sar    $0x8,%eax
   41df5:	0f b6 c0             	movzbl %al,%eax
   41df8:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   41dff:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e02:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41e06:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41e09:	ee                   	out    %al,(%dx)
}
   41e0a:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   41e0b:	0f b7 05 ee 24 01 00 	movzwl 0x124ee(%rip),%eax        # 54300 <interrupts_enabled>
   41e12:	83 c8 01             	or     $0x1,%eax
   41e15:	66 89 05 e4 24 01 00 	mov    %ax,0x124e4(%rip)        # 54300 <interrupts_enabled>
   41e1c:	eb 11                	jmp    41e2f <timer_init+0xc4>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   41e1e:	0f b7 05 db 24 01 00 	movzwl 0x124db(%rip),%eax        # 54300 <interrupts_enabled>
   41e25:	83 e0 fe             	and    $0xfffffffe,%eax
   41e28:	66 89 05 d1 24 01 00 	mov    %ax,0x124d1(%rip)        # 54300 <interrupts_enabled>
    }
    interrupt_mask();
   41e2f:	e8 d9 fd ff ff       	call   41c0d <interrupt_mask>
}
   41e34:	90                   	nop
   41e35:	c9                   	leave  
   41e36:	c3                   	ret    

0000000000041e37 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   41e37:	55                   	push   %rbp
   41e38:	48 89 e5             	mov    %rsp,%rbp
   41e3b:	48 83 ec 08          	sub    $0x8,%rsp
   41e3f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   41e43:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   41e48:	74 14                	je     41e5e <physical_memory_isreserved+0x27>
   41e4a:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   41e51:	00 
   41e52:	76 11                	jbe    41e65 <physical_memory_isreserved+0x2e>
   41e54:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   41e5b:	00 
   41e5c:	77 07                	ja     41e65 <physical_memory_isreserved+0x2e>
   41e5e:	b8 01 00 00 00       	mov    $0x1,%eax
   41e63:	eb 05                	jmp    41e6a <physical_memory_isreserved+0x33>
   41e65:	b8 00 00 00 00       	mov    $0x0,%eax
}
   41e6a:	c9                   	leave  
   41e6b:	c3                   	ret    

0000000000041e6c <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   41e6c:	55                   	push   %rbp
   41e6d:	48 89 e5             	mov    %rsp,%rbp
   41e70:	48 83 ec 10          	sub    $0x10,%rsp
   41e74:	89 7d fc             	mov    %edi,-0x4(%rbp)
   41e77:	89 75 f8             	mov    %esi,-0x8(%rbp)
   41e7a:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   41e7d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41e80:	c1 e0 10             	shl    $0x10,%eax
   41e83:	89 c2                	mov    %eax,%edx
   41e85:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41e88:	c1 e0 0b             	shl    $0xb,%eax
   41e8b:	09 c2                	or     %eax,%edx
   41e8d:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41e90:	c1 e0 08             	shl    $0x8,%eax
   41e93:	09 d0                	or     %edx,%eax
}
   41e95:	c9                   	leave  
   41e96:	c3                   	ret    

0000000000041e97 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   41e97:	55                   	push   %rbp
   41e98:	48 89 e5             	mov    %rsp,%rbp
   41e9b:	48 83 ec 18          	sub    $0x18,%rsp
   41e9f:	89 7d ec             	mov    %edi,-0x14(%rbp)
   41ea2:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   41ea5:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41ea8:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41eab:	09 d0                	or     %edx,%eax
   41ead:	0d 00 00 00 80       	or     $0x80000000,%eax
   41eb2:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   41eb9:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   41ebc:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41ebf:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41ec2:	ef                   	out    %eax,(%dx)
}
   41ec3:	90                   	nop
   41ec4:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   41ecb:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41ece:	89 c2                	mov    %eax,%edx
   41ed0:	ed                   	in     (%dx),%eax
   41ed1:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   41ed4:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   41ed7:	c9                   	leave  
   41ed8:	c3                   	ret    

0000000000041ed9 <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   41ed9:	55                   	push   %rbp
   41eda:	48 89 e5             	mov    %rsp,%rbp
   41edd:	48 83 ec 28          	sub    $0x28,%rsp
   41ee1:	89 7d dc             	mov    %edi,-0x24(%rbp)
   41ee4:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   41ee7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41eee:	eb 73                	jmp    41f63 <pci_find_device+0x8a>
        for (int slot = 0; slot != 32; ++slot) {
   41ef0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41ef7:	eb 60                	jmp    41f59 <pci_find_device+0x80>
            for (int func = 0; func != 8; ++func) {
   41ef9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41f00:	eb 4a                	jmp    41f4c <pci_find_device+0x73>
                int configaddr = pci_make_configaddr(bus, slot, func);
   41f02:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41f05:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41f08:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41f0b:	89 ce                	mov    %ecx,%esi
   41f0d:	89 c7                	mov    %eax,%edi
   41f0f:	e8 58 ff ff ff       	call   41e6c <pci_make_configaddr>
   41f14:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   41f17:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41f1a:	be 00 00 00 00       	mov    $0x0,%esi
   41f1f:	89 c7                	mov    %eax,%edi
   41f21:	e8 71 ff ff ff       	call   41e97 <pci_config_readl>
   41f26:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   41f29:	8b 45 d8             	mov    -0x28(%rbp),%eax
   41f2c:	c1 e0 10             	shl    $0x10,%eax
   41f2f:	0b 45 dc             	or     -0x24(%rbp),%eax
   41f32:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   41f35:	75 05                	jne    41f3c <pci_find_device+0x63>
                    return configaddr;
   41f37:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41f3a:	eb 35                	jmp    41f71 <pci_find_device+0x98>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   41f3c:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   41f40:	75 06                	jne    41f48 <pci_find_device+0x6f>
   41f42:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41f46:	74 0c                	je     41f54 <pci_find_device+0x7b>
            for (int func = 0; func != 8; ++func) {
   41f48:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41f4c:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   41f50:	75 b0                	jne    41f02 <pci_find_device+0x29>
   41f52:	eb 01                	jmp    41f55 <pci_find_device+0x7c>
                    break;
   41f54:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   41f55:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41f59:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   41f5d:	75 9a                	jne    41ef9 <pci_find_device+0x20>
    for (int bus = 0; bus != 256; ++bus) {
   41f5f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41f63:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   41f6a:	75 84                	jne    41ef0 <pci_find_device+0x17>
                }
            }
        }
    }
    return -1;
   41f6c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   41f71:	c9                   	leave  
   41f72:	c3                   	ret    

0000000000041f73 <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   41f73:	55                   	push   %rbp
   41f74:	48 89 e5             	mov    %rsp,%rbp
   41f77:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   41f7b:	be 13 71 00 00       	mov    $0x7113,%esi
   41f80:	bf 86 80 00 00       	mov    $0x8086,%edi
   41f85:	e8 4f ff ff ff       	call   41ed9 <pci_find_device>
   41f8a:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   41f8d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   41f91:	78 30                	js     41fc3 <poweroff+0x50>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   41f93:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41f96:	be 40 00 00 00       	mov    $0x40,%esi
   41f9b:	89 c7                	mov    %eax,%edi
   41f9d:	e8 f5 fe ff ff       	call   41e97 <pci_config_readl>
   41fa2:	25 c0 ff 00 00       	and    $0xffc0,%eax
   41fa7:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   41faa:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41fad:	83 c0 04             	add    $0x4,%eax
   41fb0:	89 45 f4             	mov    %eax,-0xc(%rbp)
   41fb3:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   41fb9:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   41fbd:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41fc0:	66 ef                	out    %ax,(%dx)
}
   41fc2:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   41fc3:	ba 60 47 04 00       	mov    $0x44760,%edx
   41fc8:	be 00 c0 00 00       	mov    $0xc000,%esi
   41fcd:	bf 80 07 00 00       	mov    $0x780,%edi
   41fd2:	b8 00 00 00 00       	mov    $0x0,%eax
   41fd7:	e8 80 21 00 00       	call   4415c <console_printf>
 spinloop: goto spinloop;
   41fdc:	eb fe                	jmp    41fdc <poweroff+0x69>

0000000000041fde <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   41fde:	55                   	push   %rbp
   41fdf:	48 89 e5             	mov    %rsp,%rbp
   41fe2:	48 83 ec 10          	sub    $0x10,%rsp
   41fe6:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   41fed:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ff1:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41ff5:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41ff8:	ee                   	out    %al,(%dx)
}
   41ff9:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   41ffa:	eb fe                	jmp    41ffa <reboot+0x1c>

0000000000041ffc <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   41ffc:	55                   	push   %rbp
   41ffd:	48 89 e5             	mov    %rsp,%rbp
   42000:	48 83 ec 10          	sub    $0x10,%rsp
   42004:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42008:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   4200b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4200f:	48 83 c0 08          	add    $0x8,%rax
   42013:	ba c0 00 00 00       	mov    $0xc0,%edx
   42018:	be 00 00 00 00       	mov    $0x0,%esi
   4201d:	48 89 c7             	mov    %rax,%rdi
   42020:	e8 80 13 00 00       	call   433a5 <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   42025:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42029:	66 c7 80 a8 00 00 00 	movw   $0x13,0xa8(%rax)
   42030:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   42032:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42036:	48 c7 80 80 00 00 00 	movq   $0x23,0x80(%rax)
   4203d:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   42041:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42045:	48 c7 80 88 00 00 00 	movq   $0x23,0x88(%rax)
   4204c:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   42050:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42054:	66 c7 80 c0 00 00 00 	movw   $0x23,0xc0(%rax)
   4205b:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   4205d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42061:	48 c7 80 b0 00 00 00 	movq   $0x200,0xb0(%rax)
   42068:	00 02 00 00 
    p->display_status = 1;
   4206c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42070:	c6 80 d8 00 00 00 01 	movb   $0x1,0xd8(%rax)

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   42077:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4207a:	83 e0 01             	and    $0x1,%eax
   4207d:	85 c0                	test   %eax,%eax
   4207f:	74 1c                	je     4209d <process_init+0xa1>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   42081:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42085:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   4208c:	80 cc 30             	or     $0x30,%ah
   4208f:	48 89 c2             	mov    %rax,%rdx
   42092:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42096:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   4209d:	8b 45 f4             	mov    -0xc(%rbp),%eax
   420a0:	83 e0 02             	and    $0x2,%eax
   420a3:	85 c0                	test   %eax,%eax
   420a5:	74 1c                	je     420c3 <process_init+0xc7>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   420a7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   420ab:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   420b2:	80 e4 fd             	and    $0xfd,%ah
   420b5:	48 89 c2             	mov    %rax,%rdx
   420b8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   420bc:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
}
   420c3:	90                   	nop
   420c4:	c9                   	leave  
   420c5:	c3                   	ret    

00000000000420c6 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   420c6:	55                   	push   %rbp
   420c7:	48 89 e5             	mov    %rsp,%rbp
   420ca:	48 83 ec 28          	sub    $0x28,%rsp
   420ce:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   420d1:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   420d5:	78 09                	js     420e0 <console_show_cursor+0x1a>
   420d7:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   420de:	7e 07                	jle    420e7 <console_show_cursor+0x21>
        cpos = 0;
   420e0:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   420e7:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   420ee:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   420f2:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   420f6:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   420f9:	ee                   	out    %al,(%dx)
}
   420fa:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   420fb:	8b 45 dc             	mov    -0x24(%rbp),%eax
   420fe:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   42104:	85 c0                	test   %eax,%eax
   42106:	0f 48 c2             	cmovs  %edx,%eax
   42109:	c1 f8 08             	sar    $0x8,%eax
   4210c:	0f b6 c0             	movzbl %al,%eax
   4210f:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   42116:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42119:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   4211d:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42120:	ee                   	out    %al,(%dx)
}
   42121:	90                   	nop
   42122:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   42129:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4212d:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   42131:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42134:	ee                   	out    %al,(%dx)
}
   42135:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   42136:	8b 55 dc             	mov    -0x24(%rbp),%edx
   42139:	89 d0                	mov    %edx,%eax
   4213b:	c1 f8 1f             	sar    $0x1f,%eax
   4213e:	c1 e8 18             	shr    $0x18,%eax
   42141:	01 c2                	add    %eax,%edx
   42143:	0f b6 d2             	movzbl %dl,%edx
   42146:	29 c2                	sub    %eax,%edx
   42148:	89 d0                	mov    %edx,%eax
   4214a:	0f b6 c0             	movzbl %al,%eax
   4214d:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   42154:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42157:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4215b:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4215e:	ee                   	out    %al,(%dx)
}
   4215f:	90                   	nop
}
   42160:	90                   	nop
   42161:	c9                   	leave  
   42162:	c3                   	ret    

0000000000042163 <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   42163:	55                   	push   %rbp
   42164:	48 89 e5             	mov    %rsp,%rbp
   42167:	48 83 ec 20          	sub    $0x20,%rsp
   4216b:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42172:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42175:	89 c2                	mov    %eax,%edx
   42177:	ec                   	in     (%dx),%al
   42178:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   4217b:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   4217f:	0f b6 c0             	movzbl %al,%eax
   42182:	83 e0 01             	and    $0x1,%eax
   42185:	85 c0                	test   %eax,%eax
   42187:	75 0a                	jne    42193 <keyboard_readc+0x30>
        return -1;
   42189:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4218e:	e9 e7 01 00 00       	jmp    4237a <keyboard_readc+0x217>
   42193:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   4219a:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4219d:	89 c2                	mov    %eax,%edx
   4219f:	ec                   	in     (%dx),%al
   421a0:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   421a3:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   421a7:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   421aa:	0f b6 05 51 21 01 00 	movzbl 0x12151(%rip),%eax        # 54302 <last_escape.2>
   421b1:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   421b4:	c6 05 47 21 01 00 00 	movb   $0x0,0x12147(%rip)        # 54302 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   421bb:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   421bf:	75 11                	jne    421d2 <keyboard_readc+0x6f>
        last_escape = 0x80;
   421c1:	c6 05 3a 21 01 00 80 	movb   $0x80,0x1213a(%rip)        # 54302 <last_escape.2>
        return 0;
   421c8:	b8 00 00 00 00       	mov    $0x0,%eax
   421cd:	e9 a8 01 00 00       	jmp    4237a <keyboard_readc+0x217>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   421d2:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   421d6:	84 c0                	test   %al,%al
   421d8:	79 60                	jns    4223a <keyboard_readc+0xd7>
        int ch = keymap[(data & 0x7F) | escape];
   421da:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   421de:	83 e0 7f             	and    $0x7f,%eax
   421e1:	89 c2                	mov    %eax,%edx
   421e3:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   421e7:	09 d0                	or     %edx,%eax
   421e9:	48 98                	cltq   
   421eb:	0f b6 80 80 47 04 00 	movzbl 0x44780(%rax),%eax
   421f2:	0f b6 c0             	movzbl %al,%eax
   421f5:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   421f8:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   421ff:	7e 2f                	jle    42230 <keyboard_readc+0xcd>
   42201:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   42208:	7f 26                	jg     42230 <keyboard_readc+0xcd>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   4220a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4220d:	2d fa 00 00 00       	sub    $0xfa,%eax
   42212:	ba 01 00 00 00       	mov    $0x1,%edx
   42217:	89 c1                	mov    %eax,%ecx
   42219:	d3 e2                	shl    %cl,%edx
   4221b:	89 d0                	mov    %edx,%eax
   4221d:	f7 d0                	not    %eax
   4221f:	89 c2                	mov    %eax,%edx
   42221:	0f b6 05 db 20 01 00 	movzbl 0x120db(%rip),%eax        # 54303 <modifiers.1>
   42228:	21 d0                	and    %edx,%eax
   4222a:	88 05 d3 20 01 00    	mov    %al,0x120d3(%rip)        # 54303 <modifiers.1>
        }
        return 0;
   42230:	b8 00 00 00 00       	mov    $0x0,%eax
   42235:	e9 40 01 00 00       	jmp    4237a <keyboard_readc+0x217>
    }

    int ch = (unsigned char) keymap[data | escape];
   4223a:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4223e:	0a 45 fa             	or     -0x6(%rbp),%al
   42241:	0f b6 c0             	movzbl %al,%eax
   42244:	48 98                	cltq   
   42246:	0f b6 80 80 47 04 00 	movzbl 0x44780(%rax),%eax
   4224d:	0f b6 c0             	movzbl %al,%eax
   42250:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   42253:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   42257:	7e 57                	jle    422b0 <keyboard_readc+0x14d>
   42259:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   4225d:	7f 51                	jg     422b0 <keyboard_readc+0x14d>
        if (modifiers & MOD_CONTROL) {
   4225f:	0f b6 05 9d 20 01 00 	movzbl 0x1209d(%rip),%eax        # 54303 <modifiers.1>
   42266:	0f b6 c0             	movzbl %al,%eax
   42269:	83 e0 02             	and    $0x2,%eax
   4226c:	85 c0                	test   %eax,%eax
   4226e:	74 09                	je     42279 <keyboard_readc+0x116>
            ch -= 0x60;
   42270:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   42274:	e9 fd 00 00 00       	jmp    42376 <keyboard_readc+0x213>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   42279:	0f b6 05 83 20 01 00 	movzbl 0x12083(%rip),%eax        # 54303 <modifiers.1>
   42280:	0f b6 c0             	movzbl %al,%eax
   42283:	83 e0 01             	and    $0x1,%eax
   42286:	85 c0                	test   %eax,%eax
   42288:	0f 94 c2             	sete   %dl
   4228b:	0f b6 05 71 20 01 00 	movzbl 0x12071(%rip),%eax        # 54303 <modifiers.1>
   42292:	0f b6 c0             	movzbl %al,%eax
   42295:	83 e0 08             	and    $0x8,%eax
   42298:	85 c0                	test   %eax,%eax
   4229a:	0f 94 c0             	sete   %al
   4229d:	31 d0                	xor    %edx,%eax
   4229f:	84 c0                	test   %al,%al
   422a1:	0f 84 cf 00 00 00    	je     42376 <keyboard_readc+0x213>
            ch -= 0x20;
   422a7:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   422ab:	e9 c6 00 00 00       	jmp    42376 <keyboard_readc+0x213>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   422b0:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   422b7:	7e 30                	jle    422e9 <keyboard_readc+0x186>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   422b9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   422bc:	2d fa 00 00 00       	sub    $0xfa,%eax
   422c1:	ba 01 00 00 00       	mov    $0x1,%edx
   422c6:	89 c1                	mov    %eax,%ecx
   422c8:	d3 e2                	shl    %cl,%edx
   422ca:	89 d0                	mov    %edx,%eax
   422cc:	89 c2                	mov    %eax,%edx
   422ce:	0f b6 05 2e 20 01 00 	movzbl 0x1202e(%rip),%eax        # 54303 <modifiers.1>
   422d5:	31 d0                	xor    %edx,%eax
   422d7:	88 05 26 20 01 00    	mov    %al,0x12026(%rip)        # 54303 <modifiers.1>
        ch = 0;
   422dd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   422e4:	e9 8e 00 00 00       	jmp    42377 <keyboard_readc+0x214>
    } else if (ch >= KEY_SHIFT) {
   422e9:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   422f0:	7e 2d                	jle    4231f <keyboard_readc+0x1bc>
        modifiers |= 1 << (ch - KEY_SHIFT);
   422f2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   422f5:	2d fa 00 00 00       	sub    $0xfa,%eax
   422fa:	ba 01 00 00 00       	mov    $0x1,%edx
   422ff:	89 c1                	mov    %eax,%ecx
   42301:	d3 e2                	shl    %cl,%edx
   42303:	89 d0                	mov    %edx,%eax
   42305:	89 c2                	mov    %eax,%edx
   42307:	0f b6 05 f5 1f 01 00 	movzbl 0x11ff5(%rip),%eax        # 54303 <modifiers.1>
   4230e:	09 d0                	or     %edx,%eax
   42310:	88 05 ed 1f 01 00    	mov    %al,0x11fed(%rip)        # 54303 <modifiers.1>
        ch = 0;
   42316:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4231d:	eb 58                	jmp    42377 <keyboard_readc+0x214>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   4231f:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   42323:	7e 31                	jle    42356 <keyboard_readc+0x1f3>
   42325:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   4232c:	7f 28                	jg     42356 <keyboard_readc+0x1f3>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   4232e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42331:	8d 50 80             	lea    -0x80(%rax),%edx
   42334:	0f b6 05 c8 1f 01 00 	movzbl 0x11fc8(%rip),%eax        # 54303 <modifiers.1>
   4233b:	0f b6 c0             	movzbl %al,%eax
   4233e:	83 e0 03             	and    $0x3,%eax
   42341:	48 98                	cltq   
   42343:	48 63 d2             	movslq %edx,%rdx
   42346:	0f b6 84 90 80 48 04 	movzbl 0x44880(%rax,%rdx,4),%eax
   4234d:	00 
   4234e:	0f b6 c0             	movzbl %al,%eax
   42351:	89 45 fc             	mov    %eax,-0x4(%rbp)
   42354:	eb 21                	jmp    42377 <keyboard_readc+0x214>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   42356:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   4235a:	7f 1b                	jg     42377 <keyboard_readc+0x214>
   4235c:	0f b6 05 a0 1f 01 00 	movzbl 0x11fa0(%rip),%eax        # 54303 <modifiers.1>
   42363:	0f b6 c0             	movzbl %al,%eax
   42366:	83 e0 02             	and    $0x2,%eax
   42369:	85 c0                	test   %eax,%eax
   4236b:	74 0a                	je     42377 <keyboard_readc+0x214>
        ch = 0;
   4236d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42374:	eb 01                	jmp    42377 <keyboard_readc+0x214>
        if (modifiers & MOD_CONTROL) {
   42376:	90                   	nop
    }

    return ch;
   42377:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   4237a:	c9                   	leave  
   4237b:	c3                   	ret    

000000000004237c <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   4237c:	55                   	push   %rbp
   4237d:	48 89 e5             	mov    %rsp,%rbp
   42380:	48 83 ec 20          	sub    $0x20,%rsp
   42384:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   4238b:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4238e:	89 c2                	mov    %eax,%edx
   42390:	ec                   	in     (%dx),%al
   42391:	88 45 e3             	mov    %al,-0x1d(%rbp)
   42394:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   4239b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4239e:	89 c2                	mov    %eax,%edx
   423a0:	ec                   	in     (%dx),%al
   423a1:	88 45 eb             	mov    %al,-0x15(%rbp)
   423a4:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   423ab:	8b 45 f4             	mov    -0xc(%rbp),%eax
   423ae:	89 c2                	mov    %eax,%edx
   423b0:	ec                   	in     (%dx),%al
   423b1:	88 45 f3             	mov    %al,-0xd(%rbp)
   423b4:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   423bb:	8b 45 fc             	mov    -0x4(%rbp),%eax
   423be:	89 c2                	mov    %eax,%edx
   423c0:	ec                   	in     (%dx),%al
   423c1:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   423c4:	90                   	nop
   423c5:	c9                   	leave  
   423c6:	c3                   	ret    

00000000000423c7 <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   423c7:	55                   	push   %rbp
   423c8:	48 89 e5             	mov    %rsp,%rbp
   423cb:	48 83 ec 40          	sub    $0x40,%rsp
   423cf:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   423d3:	89 f0                	mov    %esi,%eax
   423d5:	89 55 c0             	mov    %edx,-0x40(%rbp)
   423d8:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   423db:	8b 05 23 1f 01 00    	mov    0x11f23(%rip),%eax        # 54304 <initialized.0>
   423e1:	85 c0                	test   %eax,%eax
   423e3:	75 1e                	jne    42403 <parallel_port_putc+0x3c>
   423e5:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   423ec:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   423f0:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   423f4:	8b 55 f8             	mov    -0x8(%rbp),%edx
   423f7:	ee                   	out    %al,(%dx)
}
   423f8:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   423f9:	c7 05 01 1f 01 00 01 	movl   $0x1,0x11f01(%rip)        # 54304 <initialized.0>
   42400:	00 00 00 
    }

    for (int i = 0;
   42403:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4240a:	eb 09                	jmp    42415 <parallel_port_putc+0x4e>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   4240c:	e8 6b ff ff ff       	call   4237c <delay>
         ++i) {
   42411:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   42415:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   4241c:	7f 18                	jg     42436 <parallel_port_putc+0x6f>
   4241e:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42425:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42428:	89 c2                	mov    %eax,%edx
   4242a:	ec                   	in     (%dx),%al
   4242b:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   4242e:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   42432:	84 c0                	test   %al,%al
   42434:	79 d6                	jns    4240c <parallel_port_putc+0x45>
    }
    outb(IO_PARALLEL1_DATA, c);
   42436:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   4243a:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   42441:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42444:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   42448:	8b 55 d8             	mov    -0x28(%rbp),%edx
   4244b:	ee                   	out    %al,(%dx)
}
   4244c:	90                   	nop
   4244d:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   42454:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42458:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   4245c:	8b 55 e0             	mov    -0x20(%rbp),%edx
   4245f:	ee                   	out    %al,(%dx)
}
   42460:	90                   	nop
   42461:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   42468:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4246c:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   42470:	8b 55 e8             	mov    -0x18(%rbp),%edx
   42473:	ee                   	out    %al,(%dx)
}
   42474:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   42475:	90                   	nop
   42476:	c9                   	leave  
   42477:	c3                   	ret    

0000000000042478 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   42478:	55                   	push   %rbp
   42479:	48 89 e5             	mov    %rsp,%rbp
   4247c:	48 83 ec 20          	sub    $0x20,%rsp
   42480:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42484:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   42488:	48 c7 45 f8 c7 23 04 	movq   $0x423c7,-0x8(%rbp)
   4248f:	00 
    printer_vprintf(&p, 0, format, val);
   42490:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   42494:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   42498:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   4249c:	be 00 00 00 00       	mov    $0x0,%esi
   424a1:	48 89 c7             	mov    %rax,%rdi
   424a4:	e8 98 11 00 00       	call   43641 <printer_vprintf>
}
   424a9:	90                   	nop
   424aa:	c9                   	leave  
   424ab:	c3                   	ret    

00000000000424ac <log_printf>:

void log_printf(const char* format, ...) {
   424ac:	55                   	push   %rbp
   424ad:	48 89 e5             	mov    %rsp,%rbp
   424b0:	48 83 ec 60          	sub    $0x60,%rsp
   424b4:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   424b8:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   424bc:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   424c0:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   424c4:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   424c8:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   424cc:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   424d3:	48 8d 45 10          	lea    0x10(%rbp),%rax
   424d7:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   424db:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   424df:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   424e3:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   424e7:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   424eb:	48 89 d6             	mov    %rdx,%rsi
   424ee:	48 89 c7             	mov    %rax,%rdi
   424f1:	e8 82 ff ff ff       	call   42478 <log_vprintf>
    va_end(val);
}
   424f6:	90                   	nop
   424f7:	c9                   	leave  
   424f8:	c3                   	ret    

00000000000424f9 <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   424f9:	55                   	push   %rbp
   424fa:	48 89 e5             	mov    %rsp,%rbp
   424fd:	48 83 ec 40          	sub    $0x40,%rsp
   42501:	89 7d dc             	mov    %edi,-0x24(%rbp)
   42504:	89 75 d8             	mov    %esi,-0x28(%rbp)
   42507:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   4250b:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   4250f:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   42513:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42517:	48 8b 0a             	mov    (%rdx),%rcx
   4251a:	48 89 08             	mov    %rcx,(%rax)
   4251d:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   42521:	48 89 48 08          	mov    %rcx,0x8(%rax)
   42525:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   42529:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   4252d:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   42531:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42535:	48 89 d6             	mov    %rdx,%rsi
   42538:	48 89 c7             	mov    %rax,%rdi
   4253b:	e8 38 ff ff ff       	call   42478 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   42540:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42544:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42548:	8b 75 d8             	mov    -0x28(%rbp),%esi
   4254b:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4254e:	89 c7                	mov    %eax,%edi
   42550:	e8 9b 1b 00 00       	call   440f0 <console_vprintf>
}
   42555:	c9                   	leave  
   42556:	c3                   	ret    

0000000000042557 <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   42557:	55                   	push   %rbp
   42558:	48 89 e5             	mov    %rsp,%rbp
   4255b:	48 83 ec 60          	sub    $0x60,%rsp
   4255f:	89 7d ac             	mov    %edi,-0x54(%rbp)
   42562:	89 75 a8             	mov    %esi,-0x58(%rbp)
   42565:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   42569:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4256d:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42571:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42575:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   4257c:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42580:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42584:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42588:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   4258c:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   42590:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   42594:	8b 75 a8             	mov    -0x58(%rbp),%esi
   42597:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4259a:	89 c7                	mov    %eax,%edi
   4259c:	e8 58 ff ff ff       	call   424f9 <error_vprintf>
   425a1:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   425a4:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   425a7:	c9                   	leave  
   425a8:	c3                   	ret    

00000000000425a9 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'f', and 'e' cause a soft
//    reboot where the kernel runs the allocator programs, "fork", or
//    "forkexit", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   425a9:	55                   	push   %rbp
   425aa:	48 89 e5             	mov    %rsp,%rbp
   425ad:	53                   	push   %rbx
   425ae:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   425b2:	e8 ac fb ff ff       	call   42163 <keyboard_readc>
   425b7:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   425ba:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   425be:	74 1c                	je     425dc <check_keyboard+0x33>
   425c0:	83 7d e4 66          	cmpl   $0x66,-0x1c(%rbp)
   425c4:	74 16                	je     425dc <check_keyboard+0x33>
   425c6:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   425ca:	74 10                	je     425dc <check_keyboard+0x33>
   425cc:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   425d0:	74 0a                	je     425dc <check_keyboard+0x33>
   425d2:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   425d6:	0f 85 e9 00 00 00    	jne    426c5 <check_keyboard+0x11c>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   425dc:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   425e3:	00 
        memset(pt, 0, PAGESIZE * 3);
   425e4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   425e8:	ba 00 30 00 00       	mov    $0x3000,%edx
   425ed:	be 00 00 00 00       	mov    $0x0,%esi
   425f2:	48 89 c7             	mov    %rax,%rdi
   425f5:	e8 ab 0d 00 00       	call   433a5 <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   425fa:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   425fe:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   42605:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42609:	48 05 00 10 00 00    	add    $0x1000,%rax
   4260f:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   42616:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4261a:	48 05 00 20 00 00    	add    $0x2000,%rax
   42620:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   42627:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4262b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   4262f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42633:	0f 22 d8             	mov    %rax,%cr3
}
   42636:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   42637:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "fork";
   4263e:	48 c7 45 e8 d8 48 04 	movq   $0x448d8,-0x18(%rbp)
   42645:	00 
        if (c == 'a') {
   42646:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   4264a:	75 0a                	jne    42656 <check_keyboard+0xad>
            argument = "allocator";
   4264c:	48 c7 45 e8 dd 48 04 	movq   $0x448dd,-0x18(%rbp)
   42653:	00 
   42654:	eb 2e                	jmp    42684 <check_keyboard+0xdb>
        } else if (c == 'e') {
   42656:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   4265a:	75 0a                	jne    42666 <check_keyboard+0xbd>
            argument = "forkexit";
   4265c:	48 c7 45 e8 e7 48 04 	movq   $0x448e7,-0x18(%rbp)
   42663:	00 
   42664:	eb 1e                	jmp    42684 <check_keyboard+0xdb>
        }
        else if (c == 't'){
   42666:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   4266a:	75 0a                	jne    42676 <check_keyboard+0xcd>
            argument = "test";
   4266c:	48 c7 45 e8 f0 48 04 	movq   $0x448f0,-0x18(%rbp)
   42673:	00 
   42674:	eb 0e                	jmp    42684 <check_keyboard+0xdb>
        }
        else if(c == '2'){
   42676:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   4267a:	75 08                	jne    42684 <check_keyboard+0xdb>
            argument = "test2";
   4267c:	48 c7 45 e8 f5 48 04 	movq   $0x448f5,-0x18(%rbp)
   42683:	00 
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   42684:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42688:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   4268c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42691:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   42695:	73 14                	jae    426ab <check_keyboard+0x102>
   42697:	ba fb 48 04 00       	mov    $0x448fb,%edx
   4269c:	be 5d 02 00 00       	mov    $0x25d,%esi
   426a1:	bf 17 49 04 00       	mov    $0x44917,%edi
   426a6:	e8 1f 01 00 00       	call   427ca <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   426ab:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   426af:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   426b2:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   426b6:	48 89 c3             	mov    %rax,%rbx
   426b9:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   426be:	e9 3d d9 ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   426c3:	eb 11                	jmp    426d6 <check_keyboard+0x12d>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   426c5:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   426c9:	74 06                	je     426d1 <check_keyboard+0x128>
   426cb:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   426cf:	75 05                	jne    426d6 <check_keyboard+0x12d>
        poweroff();
   426d1:	e8 9d f8 ff ff       	call   41f73 <poweroff>
    }
    return c;
   426d6:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   426d9:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   426dd:	c9                   	leave  
   426de:	c3                   	ret    

00000000000426df <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   426df:	55                   	push   %rbp
   426e0:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   426e3:	e8 c1 fe ff ff       	call   425a9 <check_keyboard>
   426e8:	eb f9                	jmp    426e3 <fail+0x4>

00000000000426ea <panic>:

// panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void panic(const char* format, ...) {
   426ea:	55                   	push   %rbp
   426eb:	48 89 e5             	mov    %rsp,%rbp
   426ee:	48 83 ec 60          	sub    $0x60,%rsp
   426f2:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   426f6:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   426fa:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   426fe:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42702:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42706:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   4270a:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   42711:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42715:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   42719:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4271d:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   42721:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   42726:	0f 84 80 00 00 00    	je     427ac <panic+0xc2>
        // Print panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   4272c:	ba 2b 49 04 00       	mov    $0x4492b,%edx
   42731:	be 00 c0 00 00       	mov    $0xc000,%esi
   42736:	bf 30 07 00 00       	mov    $0x730,%edi
   4273b:	b8 00 00 00 00       	mov    $0x0,%eax
   42740:	e8 12 fe ff ff       	call   42557 <error_printf>
   42745:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   42748:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   4274c:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   42750:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42753:	be 00 c0 00 00       	mov    $0xc000,%esi
   42758:	89 c7                	mov    %eax,%edi
   4275a:	e8 9a fd ff ff       	call   424f9 <error_vprintf>
   4275f:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   42762:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   42765:	48 63 c1             	movslq %ecx,%rax
   42768:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   4276f:	48 c1 e8 20          	shr    $0x20,%rax
   42773:	89 c2                	mov    %eax,%edx
   42775:	c1 fa 05             	sar    $0x5,%edx
   42778:	89 c8                	mov    %ecx,%eax
   4277a:	c1 f8 1f             	sar    $0x1f,%eax
   4277d:	29 c2                	sub    %eax,%edx
   4277f:	89 d0                	mov    %edx,%eax
   42781:	c1 e0 02             	shl    $0x2,%eax
   42784:	01 d0                	add    %edx,%eax
   42786:	c1 e0 04             	shl    $0x4,%eax
   42789:	29 c1                	sub    %eax,%ecx
   4278b:	89 ca                	mov    %ecx,%edx
   4278d:	85 d2                	test   %edx,%edx
   4278f:	74 34                	je     427c5 <panic+0xdb>
            error_printf(cpos, 0xC000, "\n");
   42791:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42794:	ba 33 49 04 00       	mov    $0x44933,%edx
   42799:	be 00 c0 00 00       	mov    $0xc000,%esi
   4279e:	89 c7                	mov    %eax,%edi
   427a0:	b8 00 00 00 00       	mov    $0x0,%eax
   427a5:	e8 ad fd ff ff       	call   42557 <error_printf>
   427aa:	eb 19                	jmp    427c5 <panic+0xdb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   427ac:	ba 35 49 04 00       	mov    $0x44935,%edx
   427b1:	be 00 c0 00 00       	mov    $0xc000,%esi
   427b6:	bf 30 07 00 00       	mov    $0x730,%edi
   427bb:	b8 00 00 00 00       	mov    $0x0,%eax
   427c0:	e8 92 fd ff ff       	call   42557 <error_printf>
    }

    va_end(val);
    fail();
   427c5:	e8 15 ff ff ff       	call   426df <fail>

00000000000427ca <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   427ca:	55                   	push   %rbp
   427cb:	48 89 e5             	mov    %rsp,%rbp
   427ce:	48 83 ec 20          	sub    $0x20,%rsp
   427d2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   427d6:	89 75 f4             	mov    %esi,-0xc(%rbp)
   427d9:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   427dd:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   427e1:	8b 55 f4             	mov    -0xc(%rbp),%edx
   427e4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   427e8:	48 89 c6             	mov    %rax,%rsi
   427eb:	bf 3b 49 04 00       	mov    $0x4493b,%edi
   427f0:	b8 00 00 00 00       	mov    $0x0,%eax
   427f5:	e8 f0 fe ff ff       	call   426ea <panic>

00000000000427fa <default_exception>:
}

void default_exception(proc* p){
   427fa:	55                   	push   %rbp
   427fb:	48 89 e5             	mov    %rsp,%rbp
   427fe:	48 83 ec 20          	sub    $0x20,%rsp
   42802:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   42806:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4280a:	48 83 c0 08          	add    $0x8,%rax
   4280e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    panic("Unexpected exception %d!\n", reg->reg_intno);
   42812:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42816:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   4281d:	48 89 c6             	mov    %rax,%rsi
   42820:	bf 59 49 04 00       	mov    $0x44959,%edi
   42825:	b8 00 00 00 00       	mov    $0x0,%eax
   4282a:	e8 bb fe ff ff       	call   426ea <panic>

000000000004282f <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   4282f:	55                   	push   %rbp
   42830:	48 89 e5             	mov    %rsp,%rbp
   42833:	48 83 ec 10          	sub    $0x10,%rsp
   42837:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4283b:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   4283e:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   42842:	78 06                	js     4284a <pageindex+0x1b>
   42844:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   42848:	7e 14                	jle    4285e <pageindex+0x2f>
   4284a:	ba 78 49 04 00       	mov    $0x44978,%edx
   4284f:	be 1e 00 00 00       	mov    $0x1e,%esi
   42854:	bf 91 49 04 00       	mov    $0x44991,%edi
   42859:	e8 6c ff ff ff       	call   427ca <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   4285e:	b8 03 00 00 00       	mov    $0x3,%eax
   42863:	2b 45 f4             	sub    -0xc(%rbp),%eax
   42866:	89 c2                	mov    %eax,%edx
   42868:	89 d0                	mov    %edx,%eax
   4286a:	c1 e0 03             	shl    $0x3,%eax
   4286d:	01 d0                	add    %edx,%eax
   4286f:	83 c0 0c             	add    $0xc,%eax
   42872:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42876:	89 c1                	mov    %eax,%ecx
   42878:	48 d3 ea             	shr    %cl,%rdx
   4287b:	48 89 d0             	mov    %rdx,%rax
   4287e:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   42883:	c9                   	leave  
   42884:	c3                   	ret    

0000000000042885 <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   42885:	55                   	push   %rbp
   42886:	48 89 e5             	mov    %rsp,%rbp
   42889:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   4288d:	48 c7 05 68 27 01 00 	movq   $0x56000,0x12768(%rip)        # 55000 <kernel_pagetable>
   42894:	00 60 05 00 
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   42898:	ba 00 50 00 00       	mov    $0x5000,%edx
   4289d:	be 00 00 00 00       	mov    $0x0,%esi
   428a2:	bf 00 60 05 00       	mov    $0x56000,%edi
   428a7:	e8 f9 0a 00 00       	call   433a5 <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   428ac:	b8 00 70 05 00       	mov    $0x57000,%eax
   428b1:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   428b5:	48 89 05 44 37 01 00 	mov    %rax,0x13744(%rip)        # 56000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   428bc:	b8 00 80 05 00       	mov    $0x58000,%eax
   428c1:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   428c5:	48 89 05 34 47 01 00 	mov    %rax,0x14734(%rip)        # 57000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   428cc:	b8 00 90 05 00       	mov    $0x59000,%eax
   428d1:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   428d5:	48 89 05 24 57 01 00 	mov    %rax,0x15724(%rip)        # 58000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   428dc:	b8 00 a0 05 00       	mov    $0x5a000,%eax
   428e1:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   428e5:	48 89 05 1c 57 01 00 	mov    %rax,0x1571c(%rip)        # 58008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   428ec:	48 8b 05 0d 27 01 00 	mov    0x1270d(%rip),%rax        # 55000 <kernel_pagetable>
   428f3:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   428f9:	b9 00 00 20 00       	mov    $0x200000,%ecx
   428fe:	ba 00 00 00 00       	mov    $0x0,%edx
   42903:	be 00 00 00 00       	mov    $0x0,%esi
   42908:	48 89 c7             	mov    %rax,%rdi
   4290b:	e8 b9 01 00 00       	call   42ac9 <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42910:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42917:	00 
   42918:	eb 62                	jmp    4297c <virtual_memory_init+0xf7>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   4291a:	48 8b 0d df 26 01 00 	mov    0x126df(%rip),%rcx        # 55000 <kernel_pagetable>
   42921:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42925:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42929:	48 89 ce             	mov    %rcx,%rsi
   4292c:	48 89 c7             	mov    %rax,%rdi
   4292f:	e8 5b 05 00 00       	call   42e8f <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l1pagetable ?
        assert(vmap.pa == addr);
   42934:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42938:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4293c:	74 14                	je     42952 <virtual_memory_init+0xcd>
   4293e:	ba a5 49 04 00       	mov    $0x449a5,%edx
   42943:	be 2d 00 00 00       	mov    $0x2d,%esi
   42948:	bf b5 49 04 00       	mov    $0x449b5,%edi
   4294d:	e8 78 fe ff ff       	call   427ca <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   42952:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42955:	48 98                	cltq   
   42957:	83 e0 03             	and    $0x3,%eax
   4295a:	48 83 f8 03          	cmp    $0x3,%rax
   4295e:	74 14                	je     42974 <virtual_memory_init+0xef>
   42960:	ba c8 49 04 00       	mov    $0x449c8,%edx
   42965:	be 2e 00 00 00       	mov    $0x2e,%esi
   4296a:	bf b5 49 04 00       	mov    $0x449b5,%edi
   4296f:	e8 56 fe ff ff       	call   427ca <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42974:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4297b:	00 
   4297c:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   42983:	00 
   42984:	76 94                	jbe    4291a <virtual_memory_init+0x95>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   42986:	48 8b 05 73 26 01 00 	mov    0x12673(%rip),%rax        # 55000 <kernel_pagetable>
   4298d:	48 89 c7             	mov    %rax,%rdi
   42990:	e8 03 00 00 00       	call   42998 <set_pagetable>
}
   42995:	90                   	nop
   42996:	c9                   	leave  
   42997:	c3                   	ret    

0000000000042998 <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   42998:	55                   	push   %rbp
   42999:	48 89 e5             	mov    %rsp,%rbp
   4299c:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   429a0:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   429a4:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   429a8:	25 ff 0f 00 00       	and    $0xfff,%eax
   429ad:	48 85 c0             	test   %rax,%rax
   429b0:	74 14                	je     429c6 <set_pagetable+0x2e>
   429b2:	ba f5 49 04 00       	mov    $0x449f5,%edx
   429b7:	be 3d 00 00 00       	mov    $0x3d,%esi
   429bc:	bf b5 49 04 00       	mov    $0x449b5,%edi
   429c1:	e8 04 fe ff ff       	call   427ca <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   429c6:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   429cb:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   429cf:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   429d3:	48 89 ce             	mov    %rcx,%rsi
   429d6:	48 89 c7             	mov    %rax,%rdi
   429d9:	e8 b1 04 00 00       	call   42e8f <virtual_memory_lookup>
   429de:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   429e2:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   429e7:	48 39 d0             	cmp    %rdx,%rax
   429ea:	74 14                	je     42a00 <set_pagetable+0x68>
   429ec:	ba 10 4a 04 00       	mov    $0x44a10,%edx
   429f1:	be 3f 00 00 00       	mov    $0x3f,%esi
   429f6:	bf b5 49 04 00       	mov    $0x449b5,%edi
   429fb:	e8 ca fd ff ff       	call   427ca <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   42a00:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   42a04:	48 8b 0d f5 25 01 00 	mov    0x125f5(%rip),%rcx        # 55000 <kernel_pagetable>
   42a0b:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   42a0f:	48 89 ce             	mov    %rcx,%rsi
   42a12:	48 89 c7             	mov    %rax,%rdi
   42a15:	e8 75 04 00 00       	call   42e8f <virtual_memory_lookup>
   42a1a:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42a1e:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42a22:	48 39 c2             	cmp    %rax,%rdx
   42a25:	74 14                	je     42a3b <set_pagetable+0xa3>
   42a27:	ba 78 4a 04 00       	mov    $0x44a78,%edx
   42a2c:	be 41 00 00 00       	mov    $0x41,%esi
   42a31:	bf b5 49 04 00       	mov    $0x449b5,%edi
   42a36:	e8 8f fd ff ff       	call   427ca <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   42a3b:	48 8b 05 be 25 01 00 	mov    0x125be(%rip),%rax        # 55000 <kernel_pagetable>
   42a42:	48 89 c2             	mov    %rax,%rdx
   42a45:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   42a49:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42a4d:	48 89 ce             	mov    %rcx,%rsi
   42a50:	48 89 c7             	mov    %rax,%rdi
   42a53:	e8 37 04 00 00       	call   42e8f <virtual_memory_lookup>
   42a58:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42a5c:	48 8b 15 9d 25 01 00 	mov    0x1259d(%rip),%rdx        # 55000 <kernel_pagetable>
   42a63:	48 39 d0             	cmp    %rdx,%rax
   42a66:	74 14                	je     42a7c <set_pagetable+0xe4>
   42a68:	ba d8 4a 04 00       	mov    $0x44ad8,%edx
   42a6d:	be 43 00 00 00       	mov    $0x43,%esi
   42a72:	bf b5 49 04 00       	mov    $0x449b5,%edi
   42a77:	e8 4e fd ff ff       	call   427ca <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   42a7c:	ba c9 2a 04 00       	mov    $0x42ac9,%edx
   42a81:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42a85:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42a89:	48 89 ce             	mov    %rcx,%rsi
   42a8c:	48 89 c7             	mov    %rax,%rdi
   42a8f:	e8 fb 03 00 00       	call   42e8f <virtual_memory_lookup>
   42a94:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42a98:	ba c9 2a 04 00       	mov    $0x42ac9,%edx
   42a9d:	48 39 d0             	cmp    %rdx,%rax
   42aa0:	74 14                	je     42ab6 <set_pagetable+0x11e>
   42aa2:	ba 40 4b 04 00       	mov    $0x44b40,%edx
   42aa7:	be 45 00 00 00       	mov    $0x45,%esi
   42aac:	bf b5 49 04 00       	mov    $0x449b5,%edi
   42ab1:	e8 14 fd ff ff       	call   427ca <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   42ab6:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42aba:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42abe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42ac2:	0f 22 d8             	mov    %rax,%cr3
}
   42ac5:	90                   	nop
}
   42ac6:	90                   	nop
   42ac7:	c9                   	leave  
   42ac8:	c3                   	ret    

0000000000042ac9 <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   42ac9:	55                   	push   %rbp
   42aca:	48 89 e5             	mov    %rsp,%rbp
   42acd:	41 54                	push   %r12
   42acf:	53                   	push   %rbx
   42ad0:	48 83 ec 50          	sub    $0x50,%rsp
   42ad4:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42ad8:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42adc:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   42ae0:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
   42ae4:	44 89 45 ac          	mov    %r8d,-0x54(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   42ae8:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42aec:	25 ff 0f 00 00       	and    $0xfff,%eax
   42af1:	48 85 c0             	test   %rax,%rax
   42af4:	74 14                	je     42b0a <virtual_memory_map+0x41>
   42af6:	ba a6 4b 04 00       	mov    $0x44ba6,%edx
   42afb:	be 66 00 00 00       	mov    $0x66,%esi
   42b00:	bf b5 49 04 00       	mov    $0x449b5,%edi
   42b05:	e8 c0 fc ff ff       	call   427ca <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   42b0a:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42b0e:	25 ff 0f 00 00       	and    $0xfff,%eax
   42b13:	48 85 c0             	test   %rax,%rax
   42b16:	74 14                	je     42b2c <virtual_memory_map+0x63>
   42b18:	ba b9 4b 04 00       	mov    $0x44bb9,%edx
   42b1d:	be 67 00 00 00       	mov    $0x67,%esi
   42b22:	bf b5 49 04 00       	mov    $0x449b5,%edi
   42b27:	e8 9e fc ff ff       	call   427ca <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   42b2c:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42b30:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42b34:	48 01 d0             	add    %rdx,%rax
   42b37:	48 3b 45 c0          	cmp    -0x40(%rbp),%rax
   42b3b:	73 24                	jae    42b61 <virtual_memory_map+0x98>
   42b3d:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42b41:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42b45:	48 01 d0             	add    %rdx,%rax
   42b48:	48 85 c0             	test   %rax,%rax
   42b4b:	74 14                	je     42b61 <virtual_memory_map+0x98>
   42b4d:	ba cc 4b 04 00       	mov    $0x44bcc,%edx
   42b52:	be 68 00 00 00       	mov    $0x68,%esi
   42b57:	bf b5 49 04 00       	mov    $0x449b5,%edi
   42b5c:	e8 69 fc ff ff       	call   427ca <assert_fail>
    if (perm & PTE_P) {
   42b61:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42b64:	48 98                	cltq   
   42b66:	83 e0 01             	and    $0x1,%eax
   42b69:	48 85 c0             	test   %rax,%rax
   42b6c:	74 6e                	je     42bdc <virtual_memory_map+0x113>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   42b6e:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42b72:	25 ff 0f 00 00       	and    $0xfff,%eax
   42b77:	48 85 c0             	test   %rax,%rax
   42b7a:	74 14                	je     42b90 <virtual_memory_map+0xc7>
   42b7c:	ba ea 4b 04 00       	mov    $0x44bea,%edx
   42b81:	be 6a 00 00 00       	mov    $0x6a,%esi
   42b86:	bf b5 49 04 00       	mov    $0x449b5,%edi
   42b8b:	e8 3a fc ff ff       	call   427ca <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   42b90:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42b94:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42b98:	48 01 d0             	add    %rdx,%rax
   42b9b:	48 3b 45 b8          	cmp    -0x48(%rbp),%rax
   42b9f:	73 14                	jae    42bb5 <virtual_memory_map+0xec>
   42ba1:	ba fd 4b 04 00       	mov    $0x44bfd,%edx
   42ba6:	be 6b 00 00 00       	mov    $0x6b,%esi
   42bab:	bf b5 49 04 00       	mov    $0x449b5,%edi
   42bb0:	e8 15 fc ff ff       	call   427ca <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   42bb5:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42bb9:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42bbd:	48 01 d0             	add    %rdx,%rax
   42bc0:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   42bc6:	76 14                	jbe    42bdc <virtual_memory_map+0x113>
   42bc8:	ba 0b 4c 04 00       	mov    $0x44c0b,%edx
   42bcd:	be 6c 00 00 00       	mov    $0x6c,%esi
   42bd2:	bf b5 49 04 00       	mov    $0x449b5,%edi
   42bd7:	e8 ee fb ff ff       	call   427ca <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   42bdc:	83 7d ac 00          	cmpl   $0x0,-0x54(%rbp)
   42be0:	78 09                	js     42beb <virtual_memory_map+0x122>
   42be2:	81 7d ac ff 0f 00 00 	cmpl   $0xfff,-0x54(%rbp)
   42be9:	7e 14                	jle    42bff <virtual_memory_map+0x136>
   42beb:	ba 27 4c 04 00       	mov    $0x44c27,%edx
   42bf0:	be 6e 00 00 00       	mov    $0x6e,%esi
   42bf5:	bf b5 49 04 00       	mov    $0x449b5,%edi
   42bfa:	e8 cb fb ff ff       	call   427ca <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   42bff:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42c03:	25 ff 0f 00 00       	and    $0xfff,%eax
   42c08:	48 85 c0             	test   %rax,%rax
   42c0b:	74 14                	je     42c21 <virtual_memory_map+0x158>
   42c0d:	ba 48 4c 04 00       	mov    $0x44c48,%edx
   42c12:	be 6f 00 00 00       	mov    $0x6f,%esi
   42c17:	bf b5 49 04 00       	mov    $0x449b5,%edi
   42c1c:	e8 a9 fb ff ff       	call   427ca <assert_fail>

    int last_index123 = -1;
   42c21:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%rbp)
    x86_64_pagetable* l1pagetable = NULL;
   42c28:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
   42c2f:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42c30:	e9 e7 00 00 00       	jmp    42d1c <virtual_memory_map+0x253>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   42c35:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42c39:	48 c1 e8 15          	shr    $0x15,%rax
   42c3d:	89 45 dc             	mov    %eax,-0x24(%rbp)
        if (cur_index123 != last_index123) {
   42c40:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42c43:	3b 45 ec             	cmp    -0x14(%rbp),%eax
   42c46:	74 20                	je     42c68 <virtual_memory_map+0x19f>
            // TODO --> done
            // find pointer to last level pagetable for current va

			l1pagetable = lookup_l1pagetable(pagetable, va, perm);	
   42c48:	8b 55 ac             	mov    -0x54(%rbp),%edx
   42c4b:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   42c4f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42c53:	48 89 ce             	mov    %rcx,%rsi
   42c56:	48 89 c7             	mov    %rax,%rdi
   42c59:	e8 d7 00 00 00       	call   42d35 <lookup_l1pagetable>
   42c5e:	48 89 45 e0          	mov    %rax,-0x20(%rbp)

            last_index123 = cur_index123;
   42c62:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42c65:	89 45 ec             	mov    %eax,-0x14(%rbp)
        }
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   42c68:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42c6b:	48 98                	cltq   
   42c6d:	83 e0 01             	and    $0x1,%eax
   42c70:	48 85 c0             	test   %rax,%rax
   42c73:	74 3a                	je     42caf <virtual_memory_map+0x1e6>
   42c75:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42c7a:	74 33                	je     42caf <virtual_memory_map+0x1e6>
            // TODO --> done
            // map `pa` at appropriate entry with permissions `perm`
			l1pagetable->entry[L1PAGEINDEX(va)] =  (0x00000000FFFFFFFF & pa) | perm;
   42c7c:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42c80:	41 89 c4             	mov    %eax,%r12d
   42c83:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42c86:	48 63 d8             	movslq %eax,%rbx
   42c89:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42c8d:	be 03 00 00 00       	mov    $0x3,%esi
   42c92:	48 89 c7             	mov    %rax,%rdi
   42c95:	e8 95 fb ff ff       	call   4282f <pageindex>
   42c9a:	89 c2                	mov    %eax,%edx
   42c9c:	4c 89 e1             	mov    %r12,%rcx
   42c9f:	48 09 d9             	or     %rbx,%rcx
   42ca2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42ca6:	48 63 d2             	movslq %edx,%rdx
   42ca9:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42cad:	eb 55                	jmp    42d04 <virtual_memory_map+0x23b>

        } else if (l1pagetable) { // if page is NOT marked present
   42caf:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42cb4:	74 26                	je     42cdc <virtual_memory_map+0x213>
            // TODO --> done
            // map to address 0 with `perm`
			l1pagetable->entry[L1PAGEINDEX(va)] = 0 | perm;
   42cb6:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42cba:	be 03 00 00 00       	mov    $0x3,%esi
   42cbf:	48 89 c7             	mov    %rax,%rdi
   42cc2:	e8 68 fb ff ff       	call   4282f <pageindex>
   42cc7:	89 c2                	mov    %eax,%edx
   42cc9:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42ccc:	48 63 c8             	movslq %eax,%rcx
   42ccf:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42cd3:	48 63 d2             	movslq %edx,%rdx
   42cd6:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42cda:	eb 28                	jmp    42d04 <virtual_memory_map+0x23b>

        } else if (perm & PTE_P) {
   42cdc:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42cdf:	48 98                	cltq   
   42ce1:	83 e0 01             	and    $0x1,%eax
   42ce4:	48 85 c0             	test   %rax,%rax
   42ce7:	74 1b                	je     42d04 <virtual_memory_map+0x23b>
            // error, no allocated l1 page found for va
            log_printf("[Kern Info] failed to find l1pagetable address at " __FILE__ ": %d\n", __LINE__);
   42ce9:	be 8b 00 00 00       	mov    $0x8b,%esi
   42cee:	bf 70 4c 04 00       	mov    $0x44c70,%edi
   42cf3:	b8 00 00 00 00       	mov    $0x0,%eax
   42cf8:	e8 af f7 ff ff       	call   424ac <log_printf>
            return -1;
   42cfd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42d02:	eb 28                	jmp    42d2c <virtual_memory_map+0x263>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42d04:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
   42d0b:	00 
   42d0c:	48 81 45 b8 00 10 00 	addq   $0x1000,-0x48(%rbp)
   42d13:	00 
   42d14:	48 81 6d b0 00 10 00 	subq   $0x1000,-0x50(%rbp)
   42d1b:	00 
   42d1c:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   42d21:	0f 85 0e ff ff ff    	jne    42c35 <virtual_memory_map+0x16c>
        }
    }
    return 0;
   42d27:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42d2c:	48 83 c4 50          	add    $0x50,%rsp
   42d30:	5b                   	pop    %rbx
   42d31:	41 5c                	pop    %r12
   42d33:	5d                   	pop    %rbp
   42d34:	c3                   	ret    

0000000000042d35 <lookup_l1pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   42d35:	55                   	push   %rbp
   42d36:	48 89 e5             	mov    %rsp,%rbp
   42d39:	48 83 ec 40          	sub    $0x40,%rsp
   42d3d:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42d41:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42d45:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   42d48:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42d4c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l1 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   42d50:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   42d57:	e9 23 01 00 00       	jmp    42e7f <lookup_l1pagetable+0x14a>
        // TODO --> done
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        x86_64_pageentry_t pe = pt->entry[PAGEINDEX(va, i)]; // replace this
   42d5c:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42d5f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42d63:	89 d6                	mov    %edx,%esi
   42d65:	48 89 c7             	mov    %rax,%rdi
   42d68:	e8 c2 fa ff ff       	call   4282f <pageindex>
   42d6d:	89 c2                	mov    %eax,%edx
   42d6f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42d73:	48 63 d2             	movslq %edx,%rdx
   42d76:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   42d7a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   42d7e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d82:	83 e0 01             	and    $0x1,%eax
   42d85:	48 85 c0             	test   %rax,%rax
   42d88:	75 63                	jne    42ded <lookup_l1pagetable+0xb8>
            log_printf("[Kern Info] Error looking up l1pagetable: Pagetable address: 0x%x perm: 0x%x."
   42d8a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42d8d:	8d 48 02             	lea    0x2(%rax),%ecx
   42d90:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d94:	25 ff 0f 00 00       	and    $0xfff,%eax
   42d99:	48 89 c2             	mov    %rax,%rdx
   42d9c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42da0:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42da6:	48 89 c6             	mov    %rax,%rsi
   42da9:	bf b8 4c 04 00       	mov    $0x44cb8,%edi
   42dae:	b8 00 00 00 00       	mov    $0x0,%eax
   42db3:	e8 f4 f6 ff ff       	call   424ac <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   42db8:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42dbb:	48 98                	cltq   
   42dbd:	83 e0 01             	and    $0x1,%eax
   42dc0:	48 85 c0             	test   %rax,%rax
   42dc3:	75 0a                	jne    42dcf <lookup_l1pagetable+0x9a>
                return NULL;
   42dc5:	b8 00 00 00 00       	mov    $0x0,%eax
   42dca:	e9 be 00 00 00       	jmp    42e8d <lookup_l1pagetable+0x158>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   42dcf:	be af 00 00 00       	mov    $0xaf,%esi
   42dd4:	bf 20 4d 04 00       	mov    $0x44d20,%edi
   42dd9:	b8 00 00 00 00       	mov    $0x0,%eax
   42dde:	e8 c9 f6 ff ff       	call   424ac <log_printf>
            return NULL;
   42de3:	b8 00 00 00 00       	mov    $0x0,%eax
   42de8:	e9 a0 00 00 00       	jmp    42e8d <lookup_l1pagetable+0x158>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   42ded:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42df1:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42df7:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   42dfd:	76 14                	jbe    42e13 <lookup_l1pagetable+0xde>
   42dff:	ba 68 4d 04 00       	mov    $0x44d68,%edx
   42e04:	be b4 00 00 00       	mov    $0xb4,%esi
   42e09:	bf b5 49 04 00       	mov    $0x449b5,%edi
   42e0e:	e8 b7 f9 ff ff       	call   427ca <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   42e13:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42e16:	48 98                	cltq   
   42e18:	83 e0 02             	and    $0x2,%eax
   42e1b:	48 85 c0             	test   %rax,%rax
   42e1e:	74 20                	je     42e40 <lookup_l1pagetable+0x10b>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   42e20:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42e24:	83 e0 02             	and    $0x2,%eax
   42e27:	48 85 c0             	test   %rax,%rax
   42e2a:	75 14                	jne    42e40 <lookup_l1pagetable+0x10b>
   42e2c:	ba 88 4d 04 00       	mov    $0x44d88,%edx
   42e31:	be b6 00 00 00       	mov    $0xb6,%esi
   42e36:	bf b5 49 04 00       	mov    $0x449b5,%edi
   42e3b:	e8 8a f9 ff ff       	call   427ca <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   42e40:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42e43:	48 98                	cltq   
   42e45:	83 e0 04             	and    $0x4,%eax
   42e48:	48 85 c0             	test   %rax,%rax
   42e4b:	74 20                	je     42e6d <lookup_l1pagetable+0x138>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   42e4d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42e51:	83 e0 04             	and    $0x4,%eax
   42e54:	48 85 c0             	test   %rax,%rax
   42e57:	75 14                	jne    42e6d <lookup_l1pagetable+0x138>
   42e59:	ba 93 4d 04 00       	mov    $0x44d93,%edx
   42e5e:	be b9 00 00 00       	mov    $0xb9,%esi
   42e63:	bf b5 49 04 00       	mov    $0x449b5,%edi
   42e68:	e8 5d f9 ff ff       	call   427ca <assert_fail>
        }

        // TODO --> done
        // set pt to physical address to next pagetable using `pe`
        pt = (x86_64_pagetable *) PTE_ADDR(pe); // replace this
   42e6d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42e71:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42e77:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   42e7b:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   42e7f:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   42e83:	0f 8e d3 fe ff ff    	jle    42d5c <lookup_l1pagetable+0x27>
    }
    return pt;
   42e89:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   42e8d:	c9                   	leave  
   42e8e:	c3                   	ret    

0000000000042e8f <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   42e8f:	55                   	push   %rbp
   42e90:	48 89 e5             	mov    %rsp,%rbp
   42e93:	48 83 ec 50          	sub    $0x50,%rsp
   42e97:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42e9b:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42e9f:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   42ea3:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42ea7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   42eab:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   42eb2:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42eb3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   42eba:	eb 41                	jmp    42efd <virtual_memory_lookup+0x6e>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   42ebc:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42ebf:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42ec3:	89 d6                	mov    %edx,%esi
   42ec5:	48 89 c7             	mov    %rax,%rdi
   42ec8:	e8 62 f9 ff ff       	call   4282f <pageindex>
   42ecd:	89 c2                	mov    %eax,%edx
   42ecf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42ed3:	48 63 d2             	movslq %edx,%rdx
   42ed6:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   42eda:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ede:	83 e0 06             	and    $0x6,%eax
   42ee1:	48 f7 d0             	not    %rax
   42ee4:	48 21 d0             	and    %rdx,%rax
   42ee7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42eeb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42eef:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42ef5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42ef9:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   42efd:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   42f01:	7f 0c                	jg     42f0f <virtual_memory_lookup+0x80>
   42f03:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42f07:	83 e0 01             	and    $0x1,%eax
   42f0a:	48 85 c0             	test   %rax,%rax
   42f0d:	75 ad                	jne    42ebc <virtual_memory_lookup+0x2d>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   42f0f:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   42f16:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   42f1d:	ff 
   42f1e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   42f25:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42f29:	83 e0 01             	and    $0x1,%eax
   42f2c:	48 85 c0             	test   %rax,%rax
   42f2f:	74 34                	je     42f65 <virtual_memory_lookup+0xd6>
        vam.pn = PAGENUMBER(pe);
   42f31:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42f35:	48 c1 e8 0c          	shr    $0xc,%rax
   42f39:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   42f3c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42f40:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42f46:	48 89 c2             	mov    %rax,%rdx
   42f49:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42f4d:	25 ff 0f 00 00       	and    $0xfff,%eax
   42f52:	48 09 d0             	or     %rdx,%rax
   42f55:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   42f59:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42f5d:	25 ff 0f 00 00       	and    $0xfff,%eax
   42f62:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   42f65:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42f69:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42f6d:	48 89 10             	mov    %rdx,(%rax)
   42f70:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   42f74:	48 89 50 08          	mov    %rdx,0x8(%rax)
   42f78:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42f7c:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   42f80:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42f84:	c9                   	leave  
   42f85:	c3                   	ret    

0000000000042f86 <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   42f86:	55                   	push   %rbp
   42f87:	48 89 e5             	mov    %rsp,%rbp
   42f8a:	48 83 ec 40          	sub    $0x40,%rsp
   42f8e:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42f92:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   42f95:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   42f99:	c7 45 f8 07 00 00 00 	movl   $0x7,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   42fa0:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   42fa4:	78 08                	js     42fae <program_load+0x28>
   42fa6:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42fa9:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   42fac:	7c 14                	jl     42fc2 <program_load+0x3c>
   42fae:	ba a0 4d 04 00       	mov    $0x44da0,%edx
   42fb3:	be 37 00 00 00       	mov    $0x37,%esi
   42fb8:	bf d0 4d 04 00       	mov    $0x44dd0,%edi
   42fbd:	e8 08 f8 ff ff       	call   427ca <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   42fc2:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42fc5:	48 98                	cltq   
   42fc7:	48 c1 e0 04          	shl    $0x4,%rax
   42fcb:	48 05 20 60 04 00    	add    $0x46020,%rax
   42fd1:	48 8b 00             	mov    (%rax),%rax
   42fd4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   42fd8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42fdc:	8b 00                	mov    (%rax),%eax
   42fde:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   42fe3:	74 14                	je     42ff9 <program_load+0x73>
   42fe5:	ba e2 4d 04 00       	mov    $0x44de2,%edx
   42fea:	be 39 00 00 00       	mov    $0x39,%esi
   42fef:	bf d0 4d 04 00       	mov    $0x44dd0,%edi
   42ff4:	e8 d1 f7 ff ff       	call   427ca <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   42ff9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ffd:	48 8b 50 20          	mov    0x20(%rax),%rdx
   43001:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43005:	48 01 d0             	add    %rdx,%rax
   43008:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   4300c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   43013:	e9 94 00 00 00       	jmp    430ac <program_load+0x126>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   43018:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4301b:	48 63 d0             	movslq %eax,%rdx
   4301e:	48 89 d0             	mov    %rdx,%rax
   43021:	48 c1 e0 03          	shl    $0x3,%rax
   43025:	48 29 d0             	sub    %rdx,%rax
   43028:	48 c1 e0 03          	shl    $0x3,%rax
   4302c:	48 89 c2             	mov    %rax,%rdx
   4302f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43033:	48 01 d0             	add    %rdx,%rax
   43036:	8b 00                	mov    (%rax),%eax
   43038:	83 f8 01             	cmp    $0x1,%eax
   4303b:	75 6b                	jne    430a8 <program_load+0x122>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   4303d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43040:	48 63 d0             	movslq %eax,%rdx
   43043:	48 89 d0             	mov    %rdx,%rax
   43046:	48 c1 e0 03          	shl    $0x3,%rax
   4304a:	48 29 d0             	sub    %rdx,%rax
   4304d:	48 c1 e0 03          	shl    $0x3,%rax
   43051:	48 89 c2             	mov    %rax,%rdx
   43054:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43058:	48 01 d0             	add    %rdx,%rax
   4305b:	48 8b 50 08          	mov    0x8(%rax),%rdx
   4305f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43063:	48 01 d0             	add    %rdx,%rax
   43066:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   4306a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4306d:	48 63 d0             	movslq %eax,%rdx
   43070:	48 89 d0             	mov    %rdx,%rax
   43073:	48 c1 e0 03          	shl    $0x3,%rax
   43077:	48 29 d0             	sub    %rdx,%rax
   4307a:	48 c1 e0 03          	shl    $0x3,%rax
   4307e:	48 89 c2             	mov    %rax,%rdx
   43081:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43085:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   43089:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   4308d:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43091:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43095:	48 89 c7             	mov    %rax,%rdi
   43098:	e8 3d 00 00 00       	call   430da <program_load_segment>
   4309d:	85 c0                	test   %eax,%eax
   4309f:	79 07                	jns    430a8 <program_load+0x122>
                return -1;
   430a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   430a6:	eb 30                	jmp    430d8 <program_load+0x152>
    for (int i = 0; i < eh->e_phnum; ++i) {
   430a8:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   430ac:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   430b0:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   430b4:	0f b7 c0             	movzwl %ax,%eax
   430b7:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   430ba:	0f 8c 58 ff ff ff    	jl     43018 <program_load+0x92>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   430c0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   430c4:	48 8b 50 18          	mov    0x18(%rax),%rdx
   430c8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   430cc:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    return 0;
   430d3:	b8 00 00 00 00       	mov    $0x0,%eax
}
   430d8:	c9                   	leave  
   430d9:	c3                   	ret    

00000000000430da <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   430da:	55                   	push   %rbp
   430db:	48 89 e5             	mov    %rsp,%rbp
   430de:	48 83 ec 70          	sub    $0x70,%rsp
   430e2:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   430e6:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   430ea:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   430ee:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   430f2:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   430f6:	48 8b 40 10          	mov    0x10(%rax),%rax
   430fa:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   430fe:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   43102:	48 8b 50 20          	mov    0x20(%rax),%rdx
   43106:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4310a:	48 01 d0             	add    %rdx,%rax
   4310d:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43111:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   43115:	48 8b 50 28          	mov    0x28(%rax),%rdx
   43119:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4311d:	48 01 d0             	add    %rdx,%rax
   43120:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   43124:	48 81 65 e8 00 f0 ff 	andq   $0xfffffffffffff000,-0x18(%rbp)
   4312b:	ff 

	// virtual addressing
	for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   4312c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43130:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43134:	e9 8f 00 00 00       	jmp    431c8 <program_load_segment+0xee>
		uintptr_t pa;
		if (next_free_page(&pa) < 0
   43139:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4313d:	48 89 c7             	mov    %rax,%rdi
   43140:	e8 f2 d1 ff ff       	call   40337 <next_free_page>
   43145:	85 c0                	test   %eax,%eax
   43147:	78 45                	js     4318e <program_load_segment+0xb4>
			|| assign_physical_page(pa, p->p_pid) < 0
   43149:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4314d:	8b 00                	mov    (%rax),%eax
   4314f:	0f be d0             	movsbl %al,%edx
   43152:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43156:	89 d6                	mov    %edx,%esi
   43158:	48 89 c7             	mov    %rax,%rdi
   4315b:	e8 c0 d4 ff ff       	call   40620 <assign_physical_page>
   43160:	85 c0                	test   %eax,%eax
   43162:	78 2a                	js     4318e <program_load_segment+0xb4>
			|| virtual_memory_map(p->p_pagetable, addr, pa, PAGESIZE, PTE_P | PTE_W | PTE_U) < 0) {
   43164:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   43168:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4316c:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   43173:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   43177:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4317d:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43182:	48 89 c7             	mov    %rax,%rdi
   43185:	e8 3f f9 ff ff       	call   42ac9 <virtual_memory_map>
   4318a:	85 c0                	test   %eax,%eax
   4318c:	79 32                	jns    431c0 <program_load_segment+0xe6>

			console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   4318e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43192:	8b 00                	mov    (%rax),%eax
   43194:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43198:	49 89 d0             	mov    %rdx,%r8
   4319b:	89 c1                	mov    %eax,%ecx
   4319d:	ba 00 4e 04 00       	mov    $0x44e00,%edx
   431a2:	be 00 c0 00 00       	mov    $0xc000,%esi
   431a7:	bf e0 06 00 00       	mov    $0x6e0,%edi
   431ac:	b8 00 00 00 00       	mov    $0x0,%eax
   431b1:	e8 a6 0f 00 00       	call   4415c <console_printf>
			return -1;
   431b6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   431bb:	e9 e5 00 00 00       	jmp    432a5 <program_load_segment+0x1cb>
	for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   431c0:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   431c7:	00 
   431c8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   431cc:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   431d0:	0f 82 63 ff ff ff    	jb     43139 <program_load_segment+0x5f>
    *     }
    * }
	*/

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   431d6:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   431da:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   431e1:	48 89 c7             	mov    %rax,%rdi
   431e4:	e8 af f7 ff ff       	call   42998 <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   431e9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   431ed:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   431f1:	48 89 c2             	mov    %rax,%rdx
   431f4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   431f8:	48 8b 4d 98          	mov    -0x68(%rbp),%rcx
   431fc:	48 89 ce             	mov    %rcx,%rsi
   431ff:	48 89 c7             	mov    %rax,%rdi
   43202:	e8 a0 00 00 00       	call   432a7 <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   43207:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4320b:	48 2b 45 e0          	sub    -0x20(%rbp),%rax
   4320f:	48 89 c2             	mov    %rax,%rdx
   43212:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43216:	be 00 00 00 00       	mov    $0x0,%esi
   4321b:	48 89 c7             	mov    %rax,%rdi
   4321e:	e8 82 01 00 00       	call   433a5 <memset>

	// change to readonly permissions
	if ((ph->p_flags & ELF_PFLAG_WRITE) == 0) {
   43223:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   43227:	8b 40 04             	mov    0x4(%rax),%eax
   4322a:	83 e0 02             	and    $0x2,%eax
   4322d:	85 c0                	test   %eax,%eax
   4322f:	75 60                	jne    43291 <program_load_segment+0x1b7>
		for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   43231:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43235:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43239:	eb 4c                	jmp    43287 <program_load_segment+0x1ad>
			vamapping map = virtual_memory_lookup(p->p_pagetable, addr);
   4323b:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4323f:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   43246:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   4324a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4324e:	48 89 ce             	mov    %rcx,%rsi
   43251:	48 89 c7             	mov    %rax,%rdi
   43254:	e8 36 fc ff ff       	call   42e8f <virtual_memory_lookup>
			virtual_memory_map(p->p_pagetable, addr, map.pa, PAGESIZE, PTE_P | PTE_U );
   43259:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   4325d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43261:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   43268:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   4326c:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   43272:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43277:	48 89 c7             	mov    %rax,%rdi
   4327a:	e8 4a f8 ff ff       	call   42ac9 <virtual_memory_map>
		for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   4327f:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   43286:	00 
   43287:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4328b:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   4328f:	72 aa                	jb     4323b <program_load_segment+0x161>
		}
	}

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   43291:	48 8b 05 68 1d 01 00 	mov    0x11d68(%rip),%rax        # 55000 <kernel_pagetable>
   43298:	48 89 c7             	mov    %rax,%rdi
   4329b:	e8 f8 f6 ff ff       	call   42998 <set_pagetable>
    return 0;
   432a0:	b8 00 00 00 00       	mov    $0x0,%eax
}
   432a5:	c9                   	leave  
   432a6:	c3                   	ret    

00000000000432a7 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   432a7:	55                   	push   %rbp
   432a8:	48 89 e5             	mov    %rsp,%rbp
   432ab:	48 83 ec 28          	sub    $0x28,%rsp
   432af:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   432b3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   432b7:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   432bb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   432bf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   432c3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   432c7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   432cb:	eb 1c                	jmp    432e9 <memcpy+0x42>
        *d = *s;
   432cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   432d1:	0f b6 10             	movzbl (%rax),%edx
   432d4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432d8:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   432da:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   432df:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   432e4:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   432e9:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   432ee:	75 dd                	jne    432cd <memcpy+0x26>
    }
    return dst;
   432f0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   432f4:	c9                   	leave  
   432f5:	c3                   	ret    

00000000000432f6 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   432f6:	55                   	push   %rbp
   432f7:	48 89 e5             	mov    %rsp,%rbp
   432fa:	48 83 ec 28          	sub    $0x28,%rsp
   432fe:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43302:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43306:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   4330a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4330e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   43312:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43316:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   4331a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4331e:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   43322:	73 6a                	jae    4338e <memmove+0x98>
   43324:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43328:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4332c:	48 01 d0             	add    %rdx,%rax
   4332f:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   43333:	73 59                	jae    4338e <memmove+0x98>
        s += n, d += n;
   43335:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43339:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   4333d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43341:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   43345:	eb 17                	jmp    4335e <memmove+0x68>
            *--d = *--s;
   43347:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   4334c:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   43351:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43355:	0f b6 10             	movzbl (%rax),%edx
   43358:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4335c:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   4335e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43362:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43366:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   4336a:	48 85 c0             	test   %rax,%rax
   4336d:	75 d8                	jne    43347 <memmove+0x51>
    if (s < d && s + n > d) {
   4336f:	eb 2e                	jmp    4339f <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   43371:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43375:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43379:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   4337d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43381:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43385:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   43389:	0f b6 12             	movzbl (%rdx),%edx
   4338c:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   4338e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43392:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43396:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   4339a:	48 85 c0             	test   %rax,%rax
   4339d:	75 d2                	jne    43371 <memmove+0x7b>
        }
    }
    return dst;
   4339f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   433a3:	c9                   	leave  
   433a4:	c3                   	ret    

00000000000433a5 <memset>:

void* memset(void* v, int c, size_t n) {
   433a5:	55                   	push   %rbp
   433a6:	48 89 e5             	mov    %rsp,%rbp
   433a9:	48 83 ec 28          	sub    $0x28,%rsp
   433ad:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   433b1:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   433b4:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   433b8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   433bc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   433c0:	eb 15                	jmp    433d7 <memset+0x32>
        *p = c;
   433c2:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   433c5:	89 c2                	mov    %eax,%edx
   433c7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   433cb:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   433cd:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   433d2:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   433d7:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   433dc:	75 e4                	jne    433c2 <memset+0x1d>
    }
    return v;
   433de:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   433e2:	c9                   	leave  
   433e3:	c3                   	ret    

00000000000433e4 <strlen>:

size_t strlen(const char* s) {
   433e4:	55                   	push   %rbp
   433e5:	48 89 e5             	mov    %rsp,%rbp
   433e8:	48 83 ec 18          	sub    $0x18,%rsp
   433ec:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   433f0:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   433f7:	00 
   433f8:	eb 0a                	jmp    43404 <strlen+0x20>
        ++n;
   433fa:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   433ff:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43404:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43408:	0f b6 00             	movzbl (%rax),%eax
   4340b:	84 c0                	test   %al,%al
   4340d:	75 eb                	jne    433fa <strlen+0x16>
    }
    return n;
   4340f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43413:	c9                   	leave  
   43414:	c3                   	ret    

0000000000043415 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   43415:	55                   	push   %rbp
   43416:	48 89 e5             	mov    %rsp,%rbp
   43419:	48 83 ec 20          	sub    $0x20,%rsp
   4341d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43421:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43425:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   4342c:	00 
   4342d:	eb 0a                	jmp    43439 <strnlen+0x24>
        ++n;
   4342f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43434:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43439:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4343d:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   43441:	74 0b                	je     4344e <strnlen+0x39>
   43443:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43447:	0f b6 00             	movzbl (%rax),%eax
   4344a:	84 c0                	test   %al,%al
   4344c:	75 e1                	jne    4342f <strnlen+0x1a>
    }
    return n;
   4344e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43452:	c9                   	leave  
   43453:	c3                   	ret    

0000000000043454 <strcpy>:

char* strcpy(char* dst, const char* src) {
   43454:	55                   	push   %rbp
   43455:	48 89 e5             	mov    %rsp,%rbp
   43458:	48 83 ec 20          	sub    $0x20,%rsp
   4345c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43460:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   43464:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43468:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   4346c:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43470:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43474:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43478:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4347c:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43480:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   43484:	0f b6 12             	movzbl (%rdx),%edx
   43487:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   43489:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4348d:	48 83 e8 01          	sub    $0x1,%rax
   43491:	0f b6 00             	movzbl (%rax),%eax
   43494:	84 c0                	test   %al,%al
   43496:	75 d4                	jne    4346c <strcpy+0x18>
    return dst;
   43498:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   4349c:	c9                   	leave  
   4349d:	c3                   	ret    

000000000004349e <strcmp>:

int strcmp(const char* a, const char* b) {
   4349e:	55                   	push   %rbp
   4349f:	48 89 e5             	mov    %rsp,%rbp
   434a2:	48 83 ec 10          	sub    $0x10,%rsp
   434a6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   434aa:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   434ae:	eb 0a                	jmp    434ba <strcmp+0x1c>
        ++a, ++b;
   434b0:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   434b5:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   434ba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   434be:	0f b6 00             	movzbl (%rax),%eax
   434c1:	84 c0                	test   %al,%al
   434c3:	74 1d                	je     434e2 <strcmp+0x44>
   434c5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   434c9:	0f b6 00             	movzbl (%rax),%eax
   434cc:	84 c0                	test   %al,%al
   434ce:	74 12                	je     434e2 <strcmp+0x44>
   434d0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   434d4:	0f b6 10             	movzbl (%rax),%edx
   434d7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   434db:	0f b6 00             	movzbl (%rax),%eax
   434de:	38 c2                	cmp    %al,%dl
   434e0:	74 ce                	je     434b0 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   434e2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   434e6:	0f b6 00             	movzbl (%rax),%eax
   434e9:	89 c2                	mov    %eax,%edx
   434eb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   434ef:	0f b6 00             	movzbl (%rax),%eax
   434f2:	38 d0                	cmp    %dl,%al
   434f4:	0f 92 c0             	setb   %al
   434f7:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   434fa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   434fe:	0f b6 00             	movzbl (%rax),%eax
   43501:	89 c1                	mov    %eax,%ecx
   43503:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43507:	0f b6 00             	movzbl (%rax),%eax
   4350a:	38 c1                	cmp    %al,%cl
   4350c:	0f 92 c0             	setb   %al
   4350f:	0f b6 c0             	movzbl %al,%eax
   43512:	29 c2                	sub    %eax,%edx
   43514:	89 d0                	mov    %edx,%eax
}
   43516:	c9                   	leave  
   43517:	c3                   	ret    

0000000000043518 <strchr>:

char* strchr(const char* s, int c) {
   43518:	55                   	push   %rbp
   43519:	48 89 e5             	mov    %rsp,%rbp
   4351c:	48 83 ec 10          	sub    $0x10,%rsp
   43520:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43524:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   43527:	eb 05                	jmp    4352e <strchr+0x16>
        ++s;
   43529:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   4352e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43532:	0f b6 00             	movzbl (%rax),%eax
   43535:	84 c0                	test   %al,%al
   43537:	74 0e                	je     43547 <strchr+0x2f>
   43539:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4353d:	0f b6 00             	movzbl (%rax),%eax
   43540:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43543:	38 d0                	cmp    %dl,%al
   43545:	75 e2                	jne    43529 <strchr+0x11>
    }
    if (*s == (char) c) {
   43547:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4354b:	0f b6 00             	movzbl (%rax),%eax
   4354e:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43551:	38 d0                	cmp    %dl,%al
   43553:	75 06                	jne    4355b <strchr+0x43>
        return (char*) s;
   43555:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43559:	eb 05                	jmp    43560 <strchr+0x48>
    } else {
        return NULL;
   4355b:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   43560:	c9                   	leave  
   43561:	c3                   	ret    

0000000000043562 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   43562:	55                   	push   %rbp
   43563:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   43566:	8b 05 94 7a 01 00    	mov    0x17a94(%rip),%eax        # 5b000 <rand_seed_set>
   4356c:	85 c0                	test   %eax,%eax
   4356e:	75 0a                	jne    4357a <rand+0x18>
        srand(819234718U);
   43570:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   43575:	e8 24 00 00 00       	call   4359e <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   4357a:	8b 05 84 7a 01 00    	mov    0x17a84(%rip),%eax        # 5b004 <rand_seed>
   43580:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   43586:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   4358b:	89 05 73 7a 01 00    	mov    %eax,0x17a73(%rip)        # 5b004 <rand_seed>
    return rand_seed & RAND_MAX;
   43591:	8b 05 6d 7a 01 00    	mov    0x17a6d(%rip),%eax        # 5b004 <rand_seed>
   43597:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   4359c:	5d                   	pop    %rbp
   4359d:	c3                   	ret    

000000000004359e <srand>:

void srand(unsigned seed) {
   4359e:	55                   	push   %rbp
   4359f:	48 89 e5             	mov    %rsp,%rbp
   435a2:	48 83 ec 08          	sub    $0x8,%rsp
   435a6:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   435a9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   435ac:	89 05 52 7a 01 00    	mov    %eax,0x17a52(%rip)        # 5b004 <rand_seed>
    rand_seed_set = 1;
   435b2:	c7 05 44 7a 01 00 01 	movl   $0x1,0x17a44(%rip)        # 5b000 <rand_seed_set>
   435b9:	00 00 00 
}
   435bc:	90                   	nop
   435bd:	c9                   	leave  
   435be:	c3                   	ret    

00000000000435bf <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   435bf:	55                   	push   %rbp
   435c0:	48 89 e5             	mov    %rsp,%rbp
   435c3:	48 83 ec 28          	sub    $0x28,%rsp
   435c7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   435cb:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   435cf:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   435d2:	48 c7 45 f8 20 50 04 	movq   $0x45020,-0x8(%rbp)
   435d9:	00 
    if (base < 0) {
   435da:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   435de:	79 0b                	jns    435eb <fill_numbuf+0x2c>
        digits = lower_digits;
   435e0:	48 c7 45 f8 40 50 04 	movq   $0x45040,-0x8(%rbp)
   435e7:	00 
        base = -base;
   435e8:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   435eb:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   435f0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   435f4:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   435f7:	8b 45 dc             	mov    -0x24(%rbp),%eax
   435fa:	48 63 c8             	movslq %eax,%rcx
   435fd:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43601:	ba 00 00 00 00       	mov    $0x0,%edx
   43606:	48 f7 f1             	div    %rcx
   43609:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4360d:	48 01 d0             	add    %rdx,%rax
   43610:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43615:	0f b6 10             	movzbl (%rax),%edx
   43618:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4361c:	88 10                	mov    %dl,(%rax)
        val /= base;
   4361e:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43621:	48 63 f0             	movslq %eax,%rsi
   43624:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43628:	ba 00 00 00 00       	mov    $0x0,%edx
   4362d:	48 f7 f6             	div    %rsi
   43630:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   43634:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43639:	75 bc                	jne    435f7 <fill_numbuf+0x38>
    return numbuf_end;
   4363b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   4363f:	c9                   	leave  
   43640:	c3                   	ret    

0000000000043641 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   43641:	55                   	push   %rbp
   43642:	48 89 e5             	mov    %rsp,%rbp
   43645:	53                   	push   %rbx
   43646:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   4364d:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   43654:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   4365a:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43661:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   43668:	e9 8a 09 00 00       	jmp    43ff7 <printer_vprintf+0x9b6>
        if (*format != '%') {
   4366d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43674:	0f b6 00             	movzbl (%rax),%eax
   43677:	3c 25                	cmp    $0x25,%al
   43679:	74 31                	je     436ac <printer_vprintf+0x6b>
            p->putc(p, *format, color);
   4367b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43682:	4c 8b 00             	mov    (%rax),%r8
   43685:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4368c:	0f b6 00             	movzbl (%rax),%eax
   4368f:	0f b6 c8             	movzbl %al,%ecx
   43692:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43698:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4369f:	89 ce                	mov    %ecx,%esi
   436a1:	48 89 c7             	mov    %rax,%rdi
   436a4:	41 ff d0             	call   *%r8
            continue;
   436a7:	e9 43 09 00 00       	jmp    43fef <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
   436ac:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   436b3:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   436ba:	01 
   436bb:	eb 44                	jmp    43701 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
   436bd:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   436c4:	0f b6 00             	movzbl (%rax),%eax
   436c7:	0f be c0             	movsbl %al,%eax
   436ca:	89 c6                	mov    %eax,%esi
   436cc:	bf 40 4e 04 00       	mov    $0x44e40,%edi
   436d1:	e8 42 fe ff ff       	call   43518 <strchr>
   436d6:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   436da:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   436df:	74 30                	je     43711 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
   436e1:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   436e5:	48 2d 40 4e 04 00    	sub    $0x44e40,%rax
   436eb:	ba 01 00 00 00       	mov    $0x1,%edx
   436f0:	89 c1                	mov    %eax,%ecx
   436f2:	d3 e2                	shl    %cl,%edx
   436f4:	89 d0                	mov    %edx,%eax
   436f6:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   436f9:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43700:	01 
   43701:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43708:	0f b6 00             	movzbl (%rax),%eax
   4370b:	84 c0                	test   %al,%al
   4370d:	75 ae                	jne    436bd <printer_vprintf+0x7c>
   4370f:	eb 01                	jmp    43712 <printer_vprintf+0xd1>
            } else {
                break;
   43711:	90                   	nop
            }
        }

        // process width
        int width = -1;
   43712:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   43719:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43720:	0f b6 00             	movzbl (%rax),%eax
   43723:	3c 30                	cmp    $0x30,%al
   43725:	7e 67                	jle    4378e <printer_vprintf+0x14d>
   43727:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4372e:	0f b6 00             	movzbl (%rax),%eax
   43731:	3c 39                	cmp    $0x39,%al
   43733:	7f 59                	jg     4378e <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43735:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   4373c:	eb 2e                	jmp    4376c <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
   4373e:	8b 55 e8             	mov    -0x18(%rbp),%edx
   43741:	89 d0                	mov    %edx,%eax
   43743:	c1 e0 02             	shl    $0x2,%eax
   43746:	01 d0                	add    %edx,%eax
   43748:	01 c0                	add    %eax,%eax
   4374a:	89 c1                	mov    %eax,%ecx
   4374c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43753:	48 8d 50 01          	lea    0x1(%rax),%rdx
   43757:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   4375e:	0f b6 00             	movzbl (%rax),%eax
   43761:	0f be c0             	movsbl %al,%eax
   43764:	01 c8                	add    %ecx,%eax
   43766:	83 e8 30             	sub    $0x30,%eax
   43769:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   4376c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43773:	0f b6 00             	movzbl (%rax),%eax
   43776:	3c 2f                	cmp    $0x2f,%al
   43778:	0f 8e 85 00 00 00    	jle    43803 <printer_vprintf+0x1c2>
   4377e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43785:	0f b6 00             	movzbl (%rax),%eax
   43788:	3c 39                	cmp    $0x39,%al
   4378a:	7e b2                	jle    4373e <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
   4378c:	eb 75                	jmp    43803 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
   4378e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43795:	0f b6 00             	movzbl (%rax),%eax
   43798:	3c 2a                	cmp    $0x2a,%al
   4379a:	75 68                	jne    43804 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
   4379c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   437a3:	8b 00                	mov    (%rax),%eax
   437a5:	83 f8 2f             	cmp    $0x2f,%eax
   437a8:	77 30                	ja     437da <printer_vprintf+0x199>
   437aa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   437b1:	48 8b 50 10          	mov    0x10(%rax),%rdx
   437b5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   437bc:	8b 00                	mov    (%rax),%eax
   437be:	89 c0                	mov    %eax,%eax
   437c0:	48 01 d0             	add    %rdx,%rax
   437c3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   437ca:	8b 12                	mov    (%rdx),%edx
   437cc:	8d 4a 08             	lea    0x8(%rdx),%ecx
   437cf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   437d6:	89 0a                	mov    %ecx,(%rdx)
   437d8:	eb 1a                	jmp    437f4 <printer_vprintf+0x1b3>
   437da:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   437e1:	48 8b 40 08          	mov    0x8(%rax),%rax
   437e5:	48 8d 48 08          	lea    0x8(%rax),%rcx
   437e9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   437f0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   437f4:	8b 00                	mov    (%rax),%eax
   437f6:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   437f9:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43800:	01 
   43801:	eb 01                	jmp    43804 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
   43803:	90                   	nop
        }

        // process precision
        int precision = -1;
   43804:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   4380b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43812:	0f b6 00             	movzbl (%rax),%eax
   43815:	3c 2e                	cmp    $0x2e,%al
   43817:	0f 85 00 01 00 00    	jne    4391d <printer_vprintf+0x2dc>
            ++format;
   4381d:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43824:	01 
            if (*format >= '0' && *format <= '9') {
   43825:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4382c:	0f b6 00             	movzbl (%rax),%eax
   4382f:	3c 2f                	cmp    $0x2f,%al
   43831:	7e 67                	jle    4389a <printer_vprintf+0x259>
   43833:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4383a:	0f b6 00             	movzbl (%rax),%eax
   4383d:	3c 39                	cmp    $0x39,%al
   4383f:	7f 59                	jg     4389a <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43841:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   43848:	eb 2e                	jmp    43878 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
   4384a:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   4384d:	89 d0                	mov    %edx,%eax
   4384f:	c1 e0 02             	shl    $0x2,%eax
   43852:	01 d0                	add    %edx,%eax
   43854:	01 c0                	add    %eax,%eax
   43856:	89 c1                	mov    %eax,%ecx
   43858:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4385f:	48 8d 50 01          	lea    0x1(%rax),%rdx
   43863:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   4386a:	0f b6 00             	movzbl (%rax),%eax
   4386d:	0f be c0             	movsbl %al,%eax
   43870:	01 c8                	add    %ecx,%eax
   43872:	83 e8 30             	sub    $0x30,%eax
   43875:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43878:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4387f:	0f b6 00             	movzbl (%rax),%eax
   43882:	3c 2f                	cmp    $0x2f,%al
   43884:	0f 8e 85 00 00 00    	jle    4390f <printer_vprintf+0x2ce>
   4388a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43891:	0f b6 00             	movzbl (%rax),%eax
   43894:	3c 39                	cmp    $0x39,%al
   43896:	7e b2                	jle    4384a <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
   43898:	eb 75                	jmp    4390f <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
   4389a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   438a1:	0f b6 00             	movzbl (%rax),%eax
   438a4:	3c 2a                	cmp    $0x2a,%al
   438a6:	75 68                	jne    43910 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
   438a8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   438af:	8b 00                	mov    (%rax),%eax
   438b1:	83 f8 2f             	cmp    $0x2f,%eax
   438b4:	77 30                	ja     438e6 <printer_vprintf+0x2a5>
   438b6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   438bd:	48 8b 50 10          	mov    0x10(%rax),%rdx
   438c1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   438c8:	8b 00                	mov    (%rax),%eax
   438ca:	89 c0                	mov    %eax,%eax
   438cc:	48 01 d0             	add    %rdx,%rax
   438cf:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   438d6:	8b 12                	mov    (%rdx),%edx
   438d8:	8d 4a 08             	lea    0x8(%rdx),%ecx
   438db:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   438e2:	89 0a                	mov    %ecx,(%rdx)
   438e4:	eb 1a                	jmp    43900 <printer_vprintf+0x2bf>
   438e6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   438ed:	48 8b 40 08          	mov    0x8(%rax),%rax
   438f1:	48 8d 48 08          	lea    0x8(%rax),%rcx
   438f5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   438fc:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43900:	8b 00                	mov    (%rax),%eax
   43902:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   43905:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4390c:	01 
   4390d:	eb 01                	jmp    43910 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
   4390f:	90                   	nop
            }
            if (precision < 0) {
   43910:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   43914:	79 07                	jns    4391d <printer_vprintf+0x2dc>
                precision = 0;
   43916:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   4391d:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   43924:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   4392b:	00 
        int length = 0;
   4392c:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   43933:	48 c7 45 c8 46 4e 04 	movq   $0x44e46,-0x38(%rbp)
   4393a:	00 
    again:
        switch (*format) {
   4393b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43942:	0f b6 00             	movzbl (%rax),%eax
   43945:	0f be c0             	movsbl %al,%eax
   43948:	83 e8 43             	sub    $0x43,%eax
   4394b:	83 f8 37             	cmp    $0x37,%eax
   4394e:	0f 87 9f 03 00 00    	ja     43cf3 <printer_vprintf+0x6b2>
   43954:	89 c0                	mov    %eax,%eax
   43956:	48 8b 04 c5 58 4e 04 	mov    0x44e58(,%rax,8),%rax
   4395d:	00 
   4395e:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
   43960:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   43967:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4396e:	01 
            goto again;
   4396f:	eb ca                	jmp    4393b <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   43971:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43975:	74 5d                	je     439d4 <printer_vprintf+0x393>
   43977:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4397e:	8b 00                	mov    (%rax),%eax
   43980:	83 f8 2f             	cmp    $0x2f,%eax
   43983:	77 30                	ja     439b5 <printer_vprintf+0x374>
   43985:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4398c:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43990:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43997:	8b 00                	mov    (%rax),%eax
   43999:	89 c0                	mov    %eax,%eax
   4399b:	48 01 d0             	add    %rdx,%rax
   4399e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   439a5:	8b 12                	mov    (%rdx),%edx
   439a7:	8d 4a 08             	lea    0x8(%rdx),%ecx
   439aa:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   439b1:	89 0a                	mov    %ecx,(%rdx)
   439b3:	eb 1a                	jmp    439cf <printer_vprintf+0x38e>
   439b5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   439bc:	48 8b 40 08          	mov    0x8(%rax),%rax
   439c0:	48 8d 48 08          	lea    0x8(%rax),%rcx
   439c4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   439cb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   439cf:	48 8b 00             	mov    (%rax),%rax
   439d2:	eb 5c                	jmp    43a30 <printer_vprintf+0x3ef>
   439d4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   439db:	8b 00                	mov    (%rax),%eax
   439dd:	83 f8 2f             	cmp    $0x2f,%eax
   439e0:	77 30                	ja     43a12 <printer_vprintf+0x3d1>
   439e2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   439e9:	48 8b 50 10          	mov    0x10(%rax),%rdx
   439ed:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   439f4:	8b 00                	mov    (%rax),%eax
   439f6:	89 c0                	mov    %eax,%eax
   439f8:	48 01 d0             	add    %rdx,%rax
   439fb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43a02:	8b 12                	mov    (%rdx),%edx
   43a04:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43a07:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43a0e:	89 0a                	mov    %ecx,(%rdx)
   43a10:	eb 1a                	jmp    43a2c <printer_vprintf+0x3eb>
   43a12:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a19:	48 8b 40 08          	mov    0x8(%rax),%rax
   43a1d:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43a21:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43a28:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43a2c:	8b 00                	mov    (%rax),%eax
   43a2e:	48 98                	cltq   
   43a30:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   43a34:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43a38:	48 c1 f8 38          	sar    $0x38,%rax
   43a3c:	25 80 00 00 00       	and    $0x80,%eax
   43a41:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   43a44:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   43a48:	74 09                	je     43a53 <printer_vprintf+0x412>
   43a4a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43a4e:	48 f7 d8             	neg    %rax
   43a51:	eb 04                	jmp    43a57 <printer_vprintf+0x416>
   43a53:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43a57:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   43a5b:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   43a5e:	83 c8 60             	or     $0x60,%eax
   43a61:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   43a64:	e9 cf 02 00 00       	jmp    43d38 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   43a69:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43a6d:	74 5d                	je     43acc <printer_vprintf+0x48b>
   43a6f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a76:	8b 00                	mov    (%rax),%eax
   43a78:	83 f8 2f             	cmp    $0x2f,%eax
   43a7b:	77 30                	ja     43aad <printer_vprintf+0x46c>
   43a7d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a84:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43a88:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a8f:	8b 00                	mov    (%rax),%eax
   43a91:	89 c0                	mov    %eax,%eax
   43a93:	48 01 d0             	add    %rdx,%rax
   43a96:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43a9d:	8b 12                	mov    (%rdx),%edx
   43a9f:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43aa2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43aa9:	89 0a                	mov    %ecx,(%rdx)
   43aab:	eb 1a                	jmp    43ac7 <printer_vprintf+0x486>
   43aad:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ab4:	48 8b 40 08          	mov    0x8(%rax),%rax
   43ab8:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43abc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43ac3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43ac7:	48 8b 00             	mov    (%rax),%rax
   43aca:	eb 5c                	jmp    43b28 <printer_vprintf+0x4e7>
   43acc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ad3:	8b 00                	mov    (%rax),%eax
   43ad5:	83 f8 2f             	cmp    $0x2f,%eax
   43ad8:	77 30                	ja     43b0a <printer_vprintf+0x4c9>
   43ada:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ae1:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43ae5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43aec:	8b 00                	mov    (%rax),%eax
   43aee:	89 c0                	mov    %eax,%eax
   43af0:	48 01 d0             	add    %rdx,%rax
   43af3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43afa:	8b 12                	mov    (%rdx),%edx
   43afc:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43aff:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43b06:	89 0a                	mov    %ecx,(%rdx)
   43b08:	eb 1a                	jmp    43b24 <printer_vprintf+0x4e3>
   43b0a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b11:	48 8b 40 08          	mov    0x8(%rax),%rax
   43b15:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43b19:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43b20:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43b24:	8b 00                	mov    (%rax),%eax
   43b26:	89 c0                	mov    %eax,%eax
   43b28:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   43b2c:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   43b30:	e9 03 02 00 00       	jmp    43d38 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
   43b35:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   43b3c:	e9 28 ff ff ff       	jmp    43a69 <printer_vprintf+0x428>
        case 'X':
            base = 16;
   43b41:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   43b48:	e9 1c ff ff ff       	jmp    43a69 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   43b4d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b54:	8b 00                	mov    (%rax),%eax
   43b56:	83 f8 2f             	cmp    $0x2f,%eax
   43b59:	77 30                	ja     43b8b <printer_vprintf+0x54a>
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
   43b89:	eb 1a                	jmp    43ba5 <printer_vprintf+0x564>
   43b8b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b92:	48 8b 40 08          	mov    0x8(%rax),%rax
   43b96:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43b9a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43ba1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43ba5:	48 8b 00             	mov    (%rax),%rax
   43ba8:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   43bac:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   43bb3:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   43bba:	e9 79 01 00 00       	jmp    43d38 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
   43bbf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43bc6:	8b 00                	mov    (%rax),%eax
   43bc8:	83 f8 2f             	cmp    $0x2f,%eax
   43bcb:	77 30                	ja     43bfd <printer_vprintf+0x5bc>
   43bcd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43bd4:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43bd8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43bdf:	8b 00                	mov    (%rax),%eax
   43be1:	89 c0                	mov    %eax,%eax
   43be3:	48 01 d0             	add    %rdx,%rax
   43be6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43bed:	8b 12                	mov    (%rdx),%edx
   43bef:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43bf2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43bf9:	89 0a                	mov    %ecx,(%rdx)
   43bfb:	eb 1a                	jmp    43c17 <printer_vprintf+0x5d6>
   43bfd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c04:	48 8b 40 08          	mov    0x8(%rax),%rax
   43c08:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43c0c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c13:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43c17:	48 8b 00             	mov    (%rax),%rax
   43c1a:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   43c1e:	e9 15 01 00 00       	jmp    43d38 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
   43c23:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c2a:	8b 00                	mov    (%rax),%eax
   43c2c:	83 f8 2f             	cmp    $0x2f,%eax
   43c2f:	77 30                	ja     43c61 <printer_vprintf+0x620>
   43c31:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c38:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43c3c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c43:	8b 00                	mov    (%rax),%eax
   43c45:	89 c0                	mov    %eax,%eax
   43c47:	48 01 d0             	add    %rdx,%rax
   43c4a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c51:	8b 12                	mov    (%rdx),%edx
   43c53:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43c56:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c5d:	89 0a                	mov    %ecx,(%rdx)
   43c5f:	eb 1a                	jmp    43c7b <printer_vprintf+0x63a>
   43c61:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c68:	48 8b 40 08          	mov    0x8(%rax),%rax
   43c6c:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43c70:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c77:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43c7b:	8b 00                	mov    (%rax),%eax
   43c7d:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   43c83:	e9 67 03 00 00       	jmp    43fef <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
   43c88:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43c8c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   43c90:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c97:	8b 00                	mov    (%rax),%eax
   43c99:	83 f8 2f             	cmp    $0x2f,%eax
   43c9c:	77 30                	ja     43cce <printer_vprintf+0x68d>
   43c9e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ca5:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43ca9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43cb0:	8b 00                	mov    (%rax),%eax
   43cb2:	89 c0                	mov    %eax,%eax
   43cb4:	48 01 d0             	add    %rdx,%rax
   43cb7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43cbe:	8b 12                	mov    (%rdx),%edx
   43cc0:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43cc3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43cca:	89 0a                	mov    %ecx,(%rdx)
   43ccc:	eb 1a                	jmp    43ce8 <printer_vprintf+0x6a7>
   43cce:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43cd5:	48 8b 40 08          	mov    0x8(%rax),%rax
   43cd9:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43cdd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43ce4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43ce8:	8b 00                	mov    (%rax),%eax
   43cea:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   43ced:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   43cf1:	eb 45                	jmp    43d38 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
   43cf3:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43cf7:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   43cfb:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43d02:	0f b6 00             	movzbl (%rax),%eax
   43d05:	84 c0                	test   %al,%al
   43d07:	74 0c                	je     43d15 <printer_vprintf+0x6d4>
   43d09:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43d10:	0f b6 00             	movzbl (%rax),%eax
   43d13:	eb 05                	jmp    43d1a <printer_vprintf+0x6d9>
   43d15:	b8 25 00 00 00       	mov    $0x25,%eax
   43d1a:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   43d1d:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   43d21:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43d28:	0f b6 00             	movzbl (%rax),%eax
   43d2b:	84 c0                	test   %al,%al
   43d2d:	75 08                	jne    43d37 <printer_vprintf+0x6f6>
                format--;
   43d2f:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   43d36:	01 
            }
            break;
   43d37:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   43d38:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43d3b:	83 e0 20             	and    $0x20,%eax
   43d3e:	85 c0                	test   %eax,%eax
   43d40:	74 1e                	je     43d60 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   43d42:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43d46:	48 83 c0 18          	add    $0x18,%rax
   43d4a:	8b 55 e0             	mov    -0x20(%rbp),%edx
   43d4d:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   43d51:	48 89 ce             	mov    %rcx,%rsi
   43d54:	48 89 c7             	mov    %rax,%rdi
   43d57:	e8 63 f8 ff ff       	call   435bf <fill_numbuf>
   43d5c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   43d60:	48 c7 45 c0 46 4e 04 	movq   $0x44e46,-0x40(%rbp)
   43d67:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   43d68:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43d6b:	83 e0 20             	and    $0x20,%eax
   43d6e:	85 c0                	test   %eax,%eax
   43d70:	74 48                	je     43dba <printer_vprintf+0x779>
   43d72:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43d75:	83 e0 40             	and    $0x40,%eax
   43d78:	85 c0                	test   %eax,%eax
   43d7a:	74 3e                	je     43dba <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
   43d7c:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43d7f:	25 80 00 00 00       	and    $0x80,%eax
   43d84:	85 c0                	test   %eax,%eax
   43d86:	74 0a                	je     43d92 <printer_vprintf+0x751>
                prefix = "-";
   43d88:	48 c7 45 c0 47 4e 04 	movq   $0x44e47,-0x40(%rbp)
   43d8f:	00 
            if (flags & FLAG_NEGATIVE) {
   43d90:	eb 73                	jmp    43e05 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   43d92:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43d95:	83 e0 10             	and    $0x10,%eax
   43d98:	85 c0                	test   %eax,%eax
   43d9a:	74 0a                	je     43da6 <printer_vprintf+0x765>
                prefix = "+";
   43d9c:	48 c7 45 c0 49 4e 04 	movq   $0x44e49,-0x40(%rbp)
   43da3:	00 
            if (flags & FLAG_NEGATIVE) {
   43da4:	eb 5f                	jmp    43e05 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   43da6:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43da9:	83 e0 08             	and    $0x8,%eax
   43dac:	85 c0                	test   %eax,%eax
   43dae:	74 55                	je     43e05 <printer_vprintf+0x7c4>
                prefix = " ";
   43db0:	48 c7 45 c0 4b 4e 04 	movq   $0x44e4b,-0x40(%rbp)
   43db7:	00 
            if (flags & FLAG_NEGATIVE) {
   43db8:	eb 4b                	jmp    43e05 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   43dba:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43dbd:	83 e0 20             	and    $0x20,%eax
   43dc0:	85 c0                	test   %eax,%eax
   43dc2:	74 42                	je     43e06 <printer_vprintf+0x7c5>
   43dc4:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43dc7:	83 e0 01             	and    $0x1,%eax
   43dca:	85 c0                	test   %eax,%eax
   43dcc:	74 38                	je     43e06 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
   43dce:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   43dd2:	74 06                	je     43dda <printer_vprintf+0x799>
   43dd4:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   43dd8:	75 2c                	jne    43e06 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
   43dda:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43ddf:	75 0c                	jne    43ded <printer_vprintf+0x7ac>
   43de1:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43de4:	25 00 01 00 00       	and    $0x100,%eax
   43de9:	85 c0                	test   %eax,%eax
   43deb:	74 19                	je     43e06 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
   43ded:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   43df1:	75 07                	jne    43dfa <printer_vprintf+0x7b9>
   43df3:	b8 4d 4e 04 00       	mov    $0x44e4d,%eax
   43df8:	eb 05                	jmp    43dff <printer_vprintf+0x7be>
   43dfa:	b8 50 4e 04 00       	mov    $0x44e50,%eax
   43dff:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   43e03:	eb 01                	jmp    43e06 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
   43e05:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   43e06:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   43e0a:	78 24                	js     43e30 <printer_vprintf+0x7ef>
   43e0c:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43e0f:	83 e0 20             	and    $0x20,%eax
   43e12:	85 c0                	test   %eax,%eax
   43e14:	75 1a                	jne    43e30 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
   43e16:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43e19:	48 63 d0             	movslq %eax,%rdx
   43e1c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43e20:	48 89 d6             	mov    %rdx,%rsi
   43e23:	48 89 c7             	mov    %rax,%rdi
   43e26:	e8 ea f5 ff ff       	call   43415 <strnlen>
   43e2b:	89 45 bc             	mov    %eax,-0x44(%rbp)
   43e2e:	eb 0f                	jmp    43e3f <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
   43e30:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43e34:	48 89 c7             	mov    %rax,%rdi
   43e37:	e8 a8 f5 ff ff       	call   433e4 <strlen>
   43e3c:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   43e3f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43e42:	83 e0 20             	and    $0x20,%eax
   43e45:	85 c0                	test   %eax,%eax
   43e47:	74 20                	je     43e69 <printer_vprintf+0x828>
   43e49:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   43e4d:	78 1a                	js     43e69 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
   43e4f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43e52:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   43e55:	7e 08                	jle    43e5f <printer_vprintf+0x81e>
   43e57:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43e5a:	2b 45 bc             	sub    -0x44(%rbp),%eax
   43e5d:	eb 05                	jmp    43e64 <printer_vprintf+0x823>
   43e5f:	b8 00 00 00 00       	mov    $0x0,%eax
   43e64:	89 45 b8             	mov    %eax,-0x48(%rbp)
   43e67:	eb 5c                	jmp    43ec5 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   43e69:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43e6c:	83 e0 20             	and    $0x20,%eax
   43e6f:	85 c0                	test   %eax,%eax
   43e71:	74 4b                	je     43ebe <printer_vprintf+0x87d>
   43e73:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43e76:	83 e0 02             	and    $0x2,%eax
   43e79:	85 c0                	test   %eax,%eax
   43e7b:	74 41                	je     43ebe <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
   43e7d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43e80:	83 e0 04             	and    $0x4,%eax
   43e83:	85 c0                	test   %eax,%eax
   43e85:	75 37                	jne    43ebe <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
   43e87:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43e8b:	48 89 c7             	mov    %rax,%rdi
   43e8e:	e8 51 f5 ff ff       	call   433e4 <strlen>
   43e93:	89 c2                	mov    %eax,%edx
   43e95:	8b 45 bc             	mov    -0x44(%rbp),%eax
   43e98:	01 d0                	add    %edx,%eax
   43e9a:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   43e9d:	7e 1f                	jle    43ebe <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
   43e9f:	8b 45 e8             	mov    -0x18(%rbp),%eax
   43ea2:	2b 45 bc             	sub    -0x44(%rbp),%eax
   43ea5:	89 c3                	mov    %eax,%ebx
   43ea7:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43eab:	48 89 c7             	mov    %rax,%rdi
   43eae:	e8 31 f5 ff ff       	call   433e4 <strlen>
   43eb3:	89 c2                	mov    %eax,%edx
   43eb5:	89 d8                	mov    %ebx,%eax
   43eb7:	29 d0                	sub    %edx,%eax
   43eb9:	89 45 b8             	mov    %eax,-0x48(%rbp)
   43ebc:	eb 07                	jmp    43ec5 <printer_vprintf+0x884>
        } else {
            zeros = 0;
   43ebe:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   43ec5:	8b 55 bc             	mov    -0x44(%rbp),%edx
   43ec8:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43ecb:	01 d0                	add    %edx,%eax
   43ecd:	48 63 d8             	movslq %eax,%rbx
   43ed0:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43ed4:	48 89 c7             	mov    %rax,%rdi
   43ed7:	e8 08 f5 ff ff       	call   433e4 <strlen>
   43edc:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   43ee0:	8b 45 e8             	mov    -0x18(%rbp),%eax
   43ee3:	29 d0                	sub    %edx,%eax
   43ee5:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   43ee8:	eb 25                	jmp    43f0f <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
   43eea:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43ef1:	48 8b 08             	mov    (%rax),%rcx
   43ef4:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43efa:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43f01:	be 20 00 00 00       	mov    $0x20,%esi
   43f06:	48 89 c7             	mov    %rax,%rdi
   43f09:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   43f0b:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   43f0f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43f12:	83 e0 04             	and    $0x4,%eax
   43f15:	85 c0                	test   %eax,%eax
   43f17:	75 36                	jne    43f4f <printer_vprintf+0x90e>
   43f19:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   43f1d:	7f cb                	jg     43eea <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
   43f1f:	eb 2e                	jmp    43f4f <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
   43f21:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43f28:	4c 8b 00             	mov    (%rax),%r8
   43f2b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43f2f:	0f b6 00             	movzbl (%rax),%eax
   43f32:	0f b6 c8             	movzbl %al,%ecx
   43f35:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43f3b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43f42:	89 ce                	mov    %ecx,%esi
   43f44:	48 89 c7             	mov    %rax,%rdi
   43f47:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   43f4a:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   43f4f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43f53:	0f b6 00             	movzbl (%rax),%eax
   43f56:	84 c0                	test   %al,%al
   43f58:	75 c7                	jne    43f21 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
   43f5a:	eb 25                	jmp    43f81 <printer_vprintf+0x940>
            p->putc(p, '0', color);
   43f5c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43f63:	48 8b 08             	mov    (%rax),%rcx
   43f66:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43f6c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43f73:	be 30 00 00 00       	mov    $0x30,%esi
   43f78:	48 89 c7             	mov    %rax,%rdi
   43f7b:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   43f7d:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   43f81:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   43f85:	7f d5                	jg     43f5c <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
   43f87:	eb 32                	jmp    43fbb <printer_vprintf+0x97a>
            p->putc(p, *data, color);
   43f89:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43f90:	4c 8b 00             	mov    (%rax),%r8
   43f93:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43f97:	0f b6 00             	movzbl (%rax),%eax
   43f9a:	0f b6 c8             	movzbl %al,%ecx
   43f9d:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43fa3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43faa:	89 ce                	mov    %ecx,%esi
   43fac:	48 89 c7             	mov    %rax,%rdi
   43faf:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   43fb2:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   43fb7:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   43fbb:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   43fbf:	7f c8                	jg     43f89 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
   43fc1:	eb 25                	jmp    43fe8 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
   43fc3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43fca:	48 8b 08             	mov    (%rax),%rcx
   43fcd:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43fd3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43fda:	be 20 00 00 00       	mov    $0x20,%esi
   43fdf:	48 89 c7             	mov    %rax,%rdi
   43fe2:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   43fe4:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   43fe8:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   43fec:	7f d5                	jg     43fc3 <printer_vprintf+0x982>
        }
    done: ;
   43fee:	90                   	nop
    for (; *format; ++format) {
   43fef:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43ff6:	01 
   43ff7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43ffe:	0f b6 00             	movzbl (%rax),%eax
   44001:	84 c0                	test   %al,%al
   44003:	0f 85 64 f6 ff ff    	jne    4366d <printer_vprintf+0x2c>
    }
}
   44009:	90                   	nop
   4400a:	90                   	nop
   4400b:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   4400f:	c9                   	leave  
   44010:	c3                   	ret    

0000000000044011 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   44011:	55                   	push   %rbp
   44012:	48 89 e5             	mov    %rsp,%rbp
   44015:	48 83 ec 20          	sub    $0x20,%rsp
   44019:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4401d:	89 f0                	mov    %esi,%eax
   4401f:	89 55 e0             	mov    %edx,-0x20(%rbp)
   44022:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   44025:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44029:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   4402d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44031:	48 8b 40 08          	mov    0x8(%rax),%rax
   44035:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
   4403a:	48 39 d0             	cmp    %rdx,%rax
   4403d:	72 0c                	jb     4404b <console_putc+0x3a>
        cp->cursor = console;
   4403f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44043:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
   4404a:	00 
    }
    if (c == '\n') {
   4404b:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   4404f:	75 78                	jne    440c9 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
   44051:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44055:	48 8b 40 08          	mov    0x8(%rax),%rax
   44059:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   4405f:	48 d1 f8             	sar    %rax
   44062:	48 89 c1             	mov    %rax,%rcx
   44065:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   4406c:	66 66 66 
   4406f:	48 89 c8             	mov    %rcx,%rax
   44072:	48 f7 ea             	imul   %rdx
   44075:	48 c1 fa 05          	sar    $0x5,%rdx
   44079:	48 89 c8             	mov    %rcx,%rax
   4407c:	48 c1 f8 3f          	sar    $0x3f,%rax
   44080:	48 29 c2             	sub    %rax,%rdx
   44083:	48 89 d0             	mov    %rdx,%rax
   44086:	48 c1 e0 02          	shl    $0x2,%rax
   4408a:	48 01 d0             	add    %rdx,%rax
   4408d:	48 c1 e0 04          	shl    $0x4,%rax
   44091:	48 29 c1             	sub    %rax,%rcx
   44094:	48 89 ca             	mov    %rcx,%rdx
   44097:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   4409a:	eb 25                	jmp    440c1 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
   4409c:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4409f:	83 c8 20             	or     $0x20,%eax
   440a2:	89 c6                	mov    %eax,%esi
   440a4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   440a8:	48 8b 40 08          	mov    0x8(%rax),%rax
   440ac:	48 8d 48 02          	lea    0x2(%rax),%rcx
   440b0:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   440b4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   440b8:	89 f2                	mov    %esi,%edx
   440ba:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   440bd:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   440c1:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   440c5:	75 d5                	jne    4409c <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   440c7:	eb 24                	jmp    440ed <console_putc+0xdc>
        *cp->cursor++ = c | color;
   440c9:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
   440cd:	8b 55 e0             	mov    -0x20(%rbp),%edx
   440d0:	09 d0                	or     %edx,%eax
   440d2:	89 c6                	mov    %eax,%esi
   440d4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   440d8:	48 8b 40 08          	mov    0x8(%rax),%rax
   440dc:	48 8d 48 02          	lea    0x2(%rax),%rcx
   440e0:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   440e4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   440e8:	89 f2                	mov    %esi,%edx
   440ea:	66 89 10             	mov    %dx,(%rax)
}
   440ed:	90                   	nop
   440ee:	c9                   	leave  
   440ef:	c3                   	ret    

00000000000440f0 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   440f0:	55                   	push   %rbp
   440f1:	48 89 e5             	mov    %rsp,%rbp
   440f4:	48 83 ec 30          	sub    $0x30,%rsp
   440f8:	89 7d ec             	mov    %edi,-0x14(%rbp)
   440fb:	89 75 e8             	mov    %esi,-0x18(%rbp)
   440fe:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   44102:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   44106:	48 c7 45 f0 11 40 04 	movq   $0x44011,-0x10(%rbp)
   4410d:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   4410e:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   44112:	78 09                	js     4411d <console_vprintf+0x2d>
   44114:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   4411b:	7e 07                	jle    44124 <console_vprintf+0x34>
        cpos = 0;
   4411d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   44124:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44127:	48 98                	cltq   
   44129:	48 01 c0             	add    %rax,%rax
   4412c:	48 05 00 80 0b 00    	add    $0xb8000,%rax
   44132:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   44136:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   4413a:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   4413e:	8b 75 e8             	mov    -0x18(%rbp),%esi
   44141:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   44145:	48 89 c7             	mov    %rax,%rdi
   44148:	e8 f4 f4 ff ff       	call   43641 <printer_vprintf>
    return cp.cursor - console;
   4414d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44151:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   44157:	48 d1 f8             	sar    %rax
}
   4415a:	c9                   	leave  
   4415b:	c3                   	ret    

000000000004415c <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   4415c:	55                   	push   %rbp
   4415d:	48 89 e5             	mov    %rsp,%rbp
   44160:	48 83 ec 60          	sub    $0x60,%rsp
   44164:	89 7d ac             	mov    %edi,-0x54(%rbp)
   44167:	89 75 a8             	mov    %esi,-0x58(%rbp)
   4416a:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   4416e:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44172:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44176:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   4417a:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   44181:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44185:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   44189:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4418d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   44191:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   44195:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   44199:	8b 75 a8             	mov    -0x58(%rbp),%esi
   4419c:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4419f:	89 c7                	mov    %eax,%edi
   441a1:	e8 4a ff ff ff       	call   440f0 <console_vprintf>
   441a6:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   441a9:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   441ac:	c9                   	leave  
   441ad:	c3                   	ret    

00000000000441ae <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   441ae:	55                   	push   %rbp
   441af:	48 89 e5             	mov    %rsp,%rbp
   441b2:	48 83 ec 20          	sub    $0x20,%rsp
   441b6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   441ba:	89 f0                	mov    %esi,%eax
   441bc:	89 55 e0             	mov    %edx,-0x20(%rbp)
   441bf:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   441c2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   441c6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   441ca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   441ce:	48 8b 50 08          	mov    0x8(%rax),%rdx
   441d2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   441d6:	48 8b 40 10          	mov    0x10(%rax),%rax
   441da:	48 39 c2             	cmp    %rax,%rdx
   441dd:	73 1a                	jae    441f9 <string_putc+0x4b>
        *sp->s++ = c;
   441df:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   441e3:	48 8b 40 08          	mov    0x8(%rax),%rax
   441e7:	48 8d 48 01          	lea    0x1(%rax),%rcx
   441eb:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   441ef:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   441f3:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   441f7:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   441f9:	90                   	nop
   441fa:	c9                   	leave  
   441fb:	c3                   	ret    

00000000000441fc <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   441fc:	55                   	push   %rbp
   441fd:	48 89 e5             	mov    %rsp,%rbp
   44200:	48 83 ec 40          	sub    $0x40,%rsp
   44204:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   44208:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   4420c:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   44210:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   44214:	48 c7 45 e8 ae 41 04 	movq   $0x441ae,-0x18(%rbp)
   4421b:	00 
    sp.s = s;
   4421c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44220:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   44224:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   44229:	74 33                	je     4425e <vsnprintf+0x62>
        sp.end = s + size - 1;
   4422b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4422f:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   44233:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44237:	48 01 d0             	add    %rdx,%rax
   4423a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   4423e:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   44242:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   44246:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   4424a:	be 00 00 00 00       	mov    $0x0,%esi
   4424f:	48 89 c7             	mov    %rax,%rdi
   44252:	e8 ea f3 ff ff       	call   43641 <printer_vprintf>
        *sp.s = 0;
   44257:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4425b:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   4425e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44262:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   44266:	c9                   	leave  
   44267:	c3                   	ret    

0000000000044268 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   44268:	55                   	push   %rbp
   44269:	48 89 e5             	mov    %rsp,%rbp
   4426c:	48 83 ec 70          	sub    $0x70,%rsp
   44270:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   44274:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   44278:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   4427c:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44280:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44284:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44288:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   4428f:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44293:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   44297:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4429b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   4429f:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   442a3:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   442a7:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   442ab:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   442af:	48 89 c7             	mov    %rax,%rdi
   442b2:	e8 45 ff ff ff       	call   441fc <vsnprintf>
   442b7:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   442ba:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   442bd:	c9                   	leave  
   442be:	c3                   	ret    

00000000000442bf <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   442bf:	55                   	push   %rbp
   442c0:	48 89 e5             	mov    %rsp,%rbp
   442c3:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   442c7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   442ce:	eb 13                	jmp    442e3 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
   442d0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   442d3:	48 98                	cltq   
   442d5:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
   442dc:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   442df:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   442e3:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   442ea:	7e e4                	jle    442d0 <console_clear+0x11>
    }
    cursorpos = 0;
   442ec:	c7 05 06 4d 07 00 00 	movl   $0x0,0x74d06(%rip)        # b8ffc <cursorpos>
   442f3:	00 00 00 
}
   442f6:	90                   	nop
   442f7:	c9                   	leave  
   442f8:	c3                   	ret    
