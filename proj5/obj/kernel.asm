
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
   400be:	e8 a7 09 00 00       	call   40a6a <exception>

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
   40173:	e8 64 19 00 00       	call   41adc <hardware_init>
    pageinfo_init();
   40178:	e8 75 0f 00 00       	call   410f2 <pageinfo_init>
    console_clear();
   4017d:	e8 9a 43 00 00       	call   4451c <console_clear>
    timer_init(HZ);
   40182:	bf 64 00 00 00       	mov    $0x64,%edi
   40187:	e8 3c 1e 00 00       	call   41fc8 <timer_init>

    // use virtual_memory_map to remove user permissions for kernel memory
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   4018c:	48 8b 05 6d 4e 01 00 	mov    0x14e6d(%rip),%rax        # 55000 <kernel_pagetable>
   40193:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   40199:	b9 00 00 10 00       	mov    $0x100000,%ecx
   4019e:	ba 00 00 00 00       	mov    $0x0,%edx
   401a3:	be 00 00 00 00       	mov    $0x0,%esi
   401a8:	48 89 c7             	mov    %rax,%rdi
   401ab:	e8 76 2b 00 00       	call   42d26 <virtual_memory_map>
					   PROC_START_ADDR, PTE_P | PTE_W);
   
    // return user permissions to console
    virtual_memory_map(kernel_pagetable, (uintptr_t) CONSOLE_ADDR, (uintptr_t) CONSOLE_ADDR,
   401b0:	ba 00 80 0b 00       	mov    $0xb8000,%edx
   401b5:	be 00 80 0b 00       	mov    $0xb8000,%esi
   401ba:	48 8b 05 3f 4e 01 00 	mov    0x14e3f(%rip),%rax        # 55000 <kernel_pagetable>
   401c1:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   401c7:	b9 00 10 00 00       	mov    $0x1000,%ecx
   401cc:	48 89 c7             	mov    %rax,%rdi
   401cf:	e8 52 2b 00 00       	call   42d26 <virtual_memory_map>
	// to all memory before the start of ANY processes. This means that 
	// the assign_page function is never capable of assigning this memory
	// to a process.

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   401d4:	ba 00 0e 00 00       	mov    $0xe00,%edx
   401d9:	be 00 00 00 00       	mov    $0x0,%esi
   401de:	bf 20 20 05 00       	mov    $0x52020,%edi
   401e3:	e8 1a 34 00 00       	call   43602 <memset>
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
   40246:	be 60 45 04 00       	mov    $0x44560,%esi
   4024b:	48 89 c7             	mov    %rax,%rdi
   4024e:	e8 a8 34 00 00       	call   436fb <strcmp>
   40253:	85 c0                	test   %eax,%eax
   40255:	75 14                	jne    4026b <kernel+0x104>
        process_setup(1, 4);
   40257:	be 04 00 00 00       	mov    $0x4,%esi
   4025c:	bf 01 00 00 00       	mov    $0x1,%edi
   40261:	e8 49 02 00 00       	call   404af <process_setup>
   40266:	e9 c2 00 00 00       	jmp    4032d <kernel+0x1c6>
    } else if (command && strcmp(command, "forkexit") == 0) {
   4026b:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40270:	74 29                	je     4029b <kernel+0x134>
   40272:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40276:	be 65 45 04 00       	mov    $0x44565,%esi
   4027b:	48 89 c7             	mov    %rax,%rdi
   4027e:	e8 78 34 00 00       	call   436fb <strcmp>
   40283:	85 c0                	test   %eax,%eax
   40285:	75 14                	jne    4029b <kernel+0x134>
        process_setup(1, 5);
   40287:	be 05 00 00 00       	mov    $0x5,%esi
   4028c:	bf 01 00 00 00       	mov    $0x1,%edi
   40291:	e8 19 02 00 00       	call   404af <process_setup>
   40296:	e9 92 00 00 00       	jmp    4032d <kernel+0x1c6>
    } else if (command && strcmp(command, "test") == 0) {
   4029b:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   402a0:	74 26                	je     402c8 <kernel+0x161>
   402a2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   402a6:	be 6e 45 04 00       	mov    $0x4456e,%esi
   402ab:	48 89 c7             	mov    %rax,%rdi
   402ae:	e8 48 34 00 00       	call   436fb <strcmp>
   402b3:	85 c0                	test   %eax,%eax
   402b5:	75 11                	jne    402c8 <kernel+0x161>
        process_setup(1, 6);
   402b7:	be 06 00 00 00       	mov    $0x6,%esi
   402bc:	bf 01 00 00 00       	mov    $0x1,%edi
   402c1:	e8 e9 01 00 00       	call   404af <process_setup>
   402c6:	eb 65                	jmp    4032d <kernel+0x1c6>
    } else if (command && strcmp(command, "test2") == 0) {
   402c8:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   402cd:	74 39                	je     40308 <kernel+0x1a1>
   402cf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   402d3:	be 73 45 04 00       	mov    $0x44573,%esi
   402d8:	48 89 c7             	mov    %rax,%rdi
   402db:	e8 1b 34 00 00       	call   436fb <strcmp>
   402e0:	85 c0                	test   %eax,%eax
   402e2:	75 24                	jne    40308 <kernel+0x1a1>
        for (pid_t i = 1; i <= 2; ++i) {
   402e4:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   402eb:	eb 13                	jmp    40300 <kernel+0x199>
            process_setup(i, 6);
   402ed:	8b 45 f8             	mov    -0x8(%rbp),%eax
   402f0:	be 06 00 00 00       	mov    $0x6,%esi
   402f5:	89 c7                	mov    %eax,%edi
   402f7:	e8 b3 01 00 00       	call   404af <process_setup>
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
   4031e:	e8 8c 01 00 00       	call   404af <process_setup>
        for (pid_t i = 1; i <= 4; ++i) {
   40323:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   40327:	83 7d f4 04          	cmpl   $0x4,-0xc(%rbp)
   4032b:	7e e4                	jle    40311 <kernel+0x1aa>
        }
    }


    // Switch to the first process using run()
    run(&processes[1]);
   4032d:	bf 00 21 05 00       	mov    $0x52100,%edi
   40332:	e8 5e 0d 00 00       	call   41095 <run>

0000000000040337 <next_free_page>:

// next_free_page(uintptr_t *)
//    loads uintptr_t * with the address of the next free page in the kernel
//    returns 0 on success, -1 on failure

int next_free_page(uintptr_t *fill) {
   40337:	55                   	push   %rbp
   40338:	48 89 e5             	mov    %rsp,%rbp
   4033b:	48 83 ec 18          	sub    $0x18,%rsp
   4033f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
	for (uintptr_t pa = 0; pa < MEMSIZE_PHYSICAL; pa += PAGESIZE) {
   40343:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   4034a:	00 
   4034b:	eb 46                	jmp    40393 <next_free_page+0x5c>
		if (pageinfo[PAGENUMBER(pa)].owner == PO_FREE 
   4034d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40351:	48 c1 e8 0c          	shr    $0xc,%rax
   40355:	48 98                	cltq   
   40357:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   4035e:	00 
   4035f:	84 c0                	test   %al,%al
   40361:	75 28                	jne    4038b <next_free_page+0x54>
			&& pageinfo[PAGENUMBER(pa)].refcount == 0) {
   40363:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40367:	48 c1 e8 0c          	shr    $0xc,%rax
   4036b:	48 98                	cltq   
   4036d:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   40374:	00 
   40375:	84 c0                	test   %al,%al
   40377:	75 12                	jne    4038b <next_free_page+0x54>
			*fill = pa;
   40379:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4037d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40381:	48 89 10             	mov    %rdx,(%rax)
		    return 0;
   40384:	b8 00 00 00 00       	mov    $0x0,%eax
   40389:	eb 17                	jmp    403a2 <next_free_page+0x6b>
	for (uintptr_t pa = 0; pa < MEMSIZE_PHYSICAL; pa += PAGESIZE) {
   4038b:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40392:	00 
   40393:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
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
   403b6:	eb 65                	jmp    4041d <pagetable_setup+0x79>
		if (next_free_page(&pagetable_pages[i])
   403b8:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   403bc:	8b 55 fc             	mov    -0x4(%rbp),%edx
   403bf:	48 63 d2             	movslq %edx,%rdx
   403c2:	48 c1 e2 03          	shl    $0x3,%rdx
   403c6:	48 01 d0             	add    %rdx,%rax
   403c9:	48 89 c7             	mov    %rax,%rdi
   403cc:	e8 66 ff ff ff       	call   40337 <next_free_page>
   403d1:	85 c0                	test   %eax,%eax
   403d3:	75 1e                	jne    403f3 <pagetable_setup+0x4f>
		    || assign_physical_page(pagetable_pages[i], pid)) {
   403d5:	8b 45 cc             	mov    -0x34(%rbp),%eax
   403d8:	0f be d0             	movsbl %al,%edx
   403db:	8b 45 fc             	mov    -0x4(%rbp),%eax
   403de:	48 98                	cltq   
   403e0:	48 8b 44 c5 d0       	mov    -0x30(%rbp,%rax,8),%rax
   403e5:	89 d6                	mov    %edx,%esi
   403e7:	48 89 c7             	mov    %rax,%rdi
   403ea:	e8 0f 02 00 00       	call   405fe <assign_physical_page>
   403ef:	85 c0                	test   %eax,%eax
   403f1:	74 0a                	je     403fd <pagetable_setup+0x59>
			return -1;
   403f3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   403f8:	e9 b0 00 00 00       	jmp    404ad <pagetable_setup+0x109>
		}
		else {
			memset((void *) pagetable_pages[i], 0, PAGESIZE);
   403fd:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40400:	48 98                	cltq   
   40402:	48 8b 44 c5 d0       	mov    -0x30(%rbp,%rax,8),%rax
   40407:	ba 00 10 00 00       	mov    $0x1000,%edx
   4040c:	be 00 00 00 00       	mov    $0x0,%esi
   40411:	48 89 c7             	mov    %rax,%rdi
   40414:	e8 e9 31 00 00       	call   43602 <memset>
    for (int i = 0; i< 5; i++) {
   40419:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4041d:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
   40421:	7e 95                	jle    403b8 <pagetable_setup+0x14>
		}
    }

    ((x86_64_pagetable *) pagetable_pages[0])->entry[0] =
        (x86_64_pageentry_t) pagetable_pages[1] | PTE_P | PTE_W | PTE_U;
   40423:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    ((x86_64_pagetable *) pagetable_pages[0])->entry[0] =
   40427:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
        (x86_64_pageentry_t) pagetable_pages[1] | PTE_P | PTE_W | PTE_U;
   4042b:	48 83 c8 07          	or     $0x7,%rax
    ((x86_64_pagetable *) pagetable_pages[0])->entry[0] =
   4042f:	48 89 02             	mov    %rax,(%rdx)
    
    ((x86_64_pagetable *) pagetable_pages[1])->entry[0] =
        (x86_64_pageentry_t) pagetable_pages[2] | PTE_P | PTE_W | PTE_U;
   40432:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    ((x86_64_pagetable *) pagetable_pages[1])->entry[0] =
   40436:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
        (x86_64_pageentry_t) pagetable_pages[2] | PTE_P | PTE_W | PTE_U;
   4043a:	48 83 c8 07          	or     $0x7,%rax
    ((x86_64_pagetable *) pagetable_pages[1])->entry[0] =
   4043e:	48 89 02             	mov    %rax,(%rdx)

    ((x86_64_pagetable *) pagetable_pages[2])->entry[0] =
        (x86_64_pageentry_t) pagetable_pages[3] | PTE_P | PTE_W | PTE_U;
   40441:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    ((x86_64_pagetable *) pagetable_pages[2])->entry[0] =
   40445:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
        (x86_64_pageentry_t) pagetable_pages[3] | PTE_P | PTE_W | PTE_U;
   40449:	48 83 c8 07          	or     $0x7,%rax
    ((x86_64_pagetable *) pagetable_pages[2])->entry[0] =
   4044d:	48 89 02             	mov    %rax,(%rdx)

    ((x86_64_pagetable *) pagetable_pages[2])->entry[1] =
        (x86_64_pageentry_t) pagetable_pages[4] | PTE_P | PTE_W | PTE_U;
   40450:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    ((x86_64_pagetable *) pagetable_pages[2])->entry[1] =
   40454:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
        (x86_64_pageentry_t) pagetable_pages[4] | PTE_P | PTE_W | PTE_U;
   40458:	48 83 c8 07          	or     $0x7,%rax
    ((x86_64_pagetable *) pagetable_pages[2])->entry[1] =
   4045c:	48 89 42 08          	mov    %rax,0x8(%rdx)

   
    memcpy((void *)pagetable_pages[3], &kernel_pagetable[3], 
   40460:	48 8b 05 99 4b 01 00 	mov    0x14b99(%rip),%rax        # 55000 <kernel_pagetable>
   40467:	48 05 00 30 00 00    	add    $0x3000,%rax
   4046d:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   40471:	48 89 d1             	mov    %rdx,%rcx
   40474:	ba 00 08 00 00       	mov    $0x800,%edx
   40479:	48 89 c6             	mov    %rax,%rsi
   4047c:	48 89 cf             	mov    %rcx,%rdi
   4047f:	e8 80 30 00 00       	call   43504 <memcpy>
	   sizeof(x86_64_pageentry_t) * PAGENUMBER(PROC_START_ADDR));

    processes[pid].p_pagetable = (x86_64_pagetable *) pagetable_pages[0];
   40484:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   40488:	48 89 c1             	mov    %rax,%rcx
   4048b:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4048e:	48 63 d0             	movslq %eax,%rdx
   40491:	48 89 d0             	mov    %rdx,%rax
   40494:	48 c1 e0 03          	shl    $0x3,%rax
   40498:	48 29 d0             	sub    %rdx,%rax
   4049b:	48 c1 e0 05          	shl    $0x5,%rax
   4049f:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   404a5:	48 89 08             	mov    %rcx,(%rax)

    return 0;
   404a8:	b8 00 00 00 00       	mov    $0x0,%eax
}
   404ad:	c9                   	leave  
   404ae:	c3                   	ret    

00000000000404af <process_setup>:
// process_setup(pid, program_number)
//    Load application program `program_number` as process number `pid`.
//    This loads the application's code and data into memory, sets its
//    %rip and %rsp, gives it a stack page, and marks it as runnable.

void process_setup(pid_t pid, int program_number) {
   404af:	55                   	push   %rbp
   404b0:	48 89 e5             	mov    %rsp,%rbp
   404b3:	48 83 ec 30          	sub    $0x30,%rsp
   404b7:	89 7d dc             	mov    %edi,-0x24(%rbp)
   404ba:	89 75 d8             	mov    %esi,-0x28(%rbp)
    process_init(&processes[pid], 0);
   404bd:	8b 45 dc             	mov    -0x24(%rbp),%eax
   404c0:	48 63 d0             	movslq %eax,%rdx
   404c3:	48 89 d0             	mov    %rdx,%rax
   404c6:	48 c1 e0 03          	shl    $0x3,%rax
   404ca:	48 29 d0             	sub    %rdx,%rax
   404cd:	48 c1 e0 05          	shl    $0x5,%rax
   404d1:	48 05 20 20 05 00    	add    $0x52020,%rax
   404d7:	be 00 00 00 00       	mov    $0x0,%esi
   404dc:	48 89 c7             	mov    %rax,%rdi
   404df:	e8 75 1d 00 00       	call   42259 <process_init>
    //processes[pid].p_pagetable = kernel_pagetable;
    //++pageinfo[PAGENUMBER(kernel_pagetable)].refcount; //increase refcount since kernel_pagetable was used

    pagetable_setup(pid);
   404e4:	8b 45 dc             	mov    -0x24(%rbp),%eax
   404e7:	89 c7                	mov    %eax,%edi
   404e9:	e8 b6 fe ff ff       	call   403a4 <pagetable_setup>

    int r = program_load(&processes[pid], program_number, NULL);
   404ee:	8b 45 dc             	mov    -0x24(%rbp),%eax
   404f1:	48 63 d0             	movslq %eax,%rdx
   404f4:	48 89 d0             	mov    %rdx,%rax
   404f7:	48 c1 e0 03          	shl    $0x3,%rax
   404fb:	48 29 d0             	sub    %rdx,%rax
   404fe:	48 c1 e0 05          	shl    $0x5,%rax
   40502:	48 8d 88 20 20 05 00 	lea    0x52020(%rax),%rcx
   40509:	8b 45 d8             	mov    -0x28(%rbp),%eax
   4050c:	ba 00 00 00 00       	mov    $0x0,%edx
   40511:	89 c6                	mov    %eax,%esi
   40513:	48 89 cf             	mov    %rcx,%rdi
   40516:	e8 c8 2c 00 00       	call   431e3 <program_load>
   4051b:	89 45 fc             	mov    %eax,-0x4(%rbp)
    assert(r >= 0);
   4051e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   40522:	79 14                	jns    40538 <process_setup+0x89>
   40524:	ba 79 45 04 00       	mov    $0x44579,%edx
   40529:	be ce 00 00 00       	mov    $0xce,%esi
   4052e:	bf 80 45 04 00       	mov    $0x44580,%edi
   40533:	e8 ef 24 00 00       	call   42a27 <assert_fail>

    processes[pid].p_registers.reg_rsp = MEMSIZE_VIRTUAL; 
   40538:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4053b:	48 63 d0             	movslq %eax,%rdx
   4053e:	48 89 d0             	mov    %rdx,%rax
   40541:	48 c1 e0 03          	shl    $0x3,%rax
   40545:	48 29 d0             	sub    %rdx,%rax
   40548:	48 c1 e0 05          	shl    $0x5,%rax
   4054c:	48 05 d8 20 05 00    	add    $0x520d8,%rax
   40552:	48 c7 00 00 00 30 00 	movq   $0x300000,(%rax)
    uintptr_t stack_page_va = processes[pid].p_registers.reg_rsp - PAGESIZE;
   40559:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4055c:	48 63 d0             	movslq %eax,%rdx
   4055f:	48 89 d0             	mov    %rdx,%rax
   40562:	48 c1 e0 03          	shl    $0x3,%rax
   40566:	48 29 d0             	sub    %rdx,%rax
   40569:	48 c1 e0 05          	shl    $0x5,%rax
   4056d:	48 05 d8 20 05 00    	add    $0x520d8,%rax
   40573:	48 8b 00             	mov    (%rax),%rax
   40576:	48 2d 00 10 00 00    	sub    $0x1000,%rax
   4057c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    uintptr_t stack_page_pa;
    next_free_page(&stack_page_pa);
   40580:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   40584:	48 89 c7             	mov    %rax,%rdi
   40587:	e8 ab fd ff ff       	call   40337 <next_free_page>
    assign_physical_page(stack_page_pa, pid);
   4058c:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4058f:	0f be d0             	movsbl %al,%edx
   40592:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40596:	89 d6                	mov    %edx,%esi
   40598:	48 89 c7             	mov    %rax,%rdi
   4059b:	e8 5e 00 00 00       	call   405fe <assign_physical_page>
    virtual_memory_map(processes[pid].p_pagetable, stack_page_va, stack_page_pa,
   405a0:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
   405a4:	8b 45 dc             	mov    -0x24(%rbp),%eax
   405a7:	48 63 d0             	movslq %eax,%rdx
   405aa:	48 89 d0             	mov    %rdx,%rax
   405ad:	48 c1 e0 03          	shl    $0x3,%rax
   405b1:	48 29 d0             	sub    %rdx,%rax
   405b4:	48 c1 e0 05          	shl    $0x5,%rax
   405b8:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   405be:	48 8b 00             	mov    (%rax),%rax
   405c1:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   405c5:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   405cb:	b9 00 10 00 00       	mov    $0x1000,%ecx
   405d0:	48 89 fa             	mov    %rdi,%rdx
   405d3:	48 89 c7             	mov    %rax,%rdi
   405d6:	e8 4b 27 00 00       	call   42d26 <virtual_memory_map>
                       PAGESIZE, PTE_P | PTE_W | PTE_U);
    processes[pid].p_state = P_RUNNABLE;
   405db:	8b 45 dc             	mov    -0x24(%rbp),%eax
   405de:	48 63 d0             	movslq %eax,%rdx
   405e1:	48 89 d0             	mov    %rdx,%rax
   405e4:	48 c1 e0 03          	shl    $0x3,%rax
   405e8:	48 29 d0             	sub    %rdx,%rax
   405eb:	48 c1 e0 05          	shl    $0x5,%rax
   405ef:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   405f5:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
}
   405fb:	90                   	nop
   405fc:	c9                   	leave  
   405fd:	c3                   	ret    

00000000000405fe <assign_physical_page>:
// assign_physical_page(addr, owner)
//    Allocates the page with physical address `addr` to the given owner.
//    Fails if physical page `addr` was already allocated. Returns 0 on
//    success and -1 on failure. Used by the program loader.

int assign_physical_page(uintptr_t addr, int8_t owner) {
   405fe:	55                   	push   %rbp
   405ff:	48 89 e5             	mov    %rsp,%rbp
   40602:	48 83 ec 10          	sub    $0x10,%rsp
   40606:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4060a:	89 f0                	mov    %esi,%eax
   4060c:	88 45 f4             	mov    %al,-0xc(%rbp)
    if ((addr & 0xFFF) != 0								 // this check is that the permission bits are 0
   4060f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40613:	25 ff 0f 00 00       	and    $0xfff,%eax
   40618:	48 85 c0             	test   %rax,%rax
   4061b:	75 20                	jne    4063d <assign_physical_page+0x3f>
        || addr >= MEMSIZE_PHYSICAL
   4061d:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40624:	00 
   40625:	77 16                	ja     4063d <assign_physical_page+0x3f>
        || pageinfo[PAGENUMBER(addr)].refcount != 0) {
   40627:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4062b:	48 c1 e8 0c          	shr    $0xc,%rax
   4062f:	48 98                	cltq   
   40631:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   40638:	00 
   40639:	84 c0                	test   %al,%al
   4063b:	74 07                	je     40644 <assign_physical_page+0x46>
        return -1;
   4063d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40642:	eb 2c                	jmp    40670 <assign_physical_page+0x72>
    } else {
        pageinfo[PAGENUMBER(addr)].refcount = 1;
   40644:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40648:	48 c1 e8 0c          	shr    $0xc,%rax
   4064c:	48 98                	cltq   
   4064e:	c6 84 00 41 2e 05 00 	movb   $0x1,0x52e41(%rax,%rax,1)
   40655:	01 
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40656:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4065a:	48 c1 e8 0c          	shr    $0xc,%rax
   4065e:	48 98                	cltq   
   40660:	0f b6 55 f4          	movzbl -0xc(%rbp),%edx
   40664:	88 94 00 40 2e 05 00 	mov    %dl,0x52e40(%rax,%rax,1)
        return 0;
   4066b:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   40670:	c9                   	leave  
   40671:	c3                   	ret    

0000000000040672 <syscall_mapping>:

void syscall_mapping(proc* p){
   40672:	55                   	push   %rbp
   40673:	48 89 e5             	mov    %rsp,%rbp
   40676:	48 83 ec 70          	sub    $0x70,%rsp
   4067a:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)

    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
   4067e:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40682:	48 8b 40 38          	mov    0x38(%rax),%rax
   40686:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t ptr = p->p_registers.reg_rsi;
   4068a:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4068e:	48 8b 40 30          	mov    0x30(%rax),%rax
   40692:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    //convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);
   40696:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4069a:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   406a1:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   406a5:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   406a9:	48 89 ce             	mov    %rcx,%rsi
   406ac:	48 89 c7             	mov    %rax,%rdi
   406af:	e8 38 2a 00 00       	call   430ec <virtual_memory_lookup>

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
   406b4:	8b 45 e0             	mov    -0x20(%rbp),%eax
   406b7:	48 98                	cltq   
   406b9:	83 e0 06             	and    $0x6,%eax
   406bc:	48 83 f8 06          	cmp    $0x6,%rax
   406c0:	75 73                	jne    40735 <syscall_mapping+0xc3>
	return;
    uintptr_t endaddr = map.pa + sizeof(vamapping) - 1;
   406c2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   406c6:	48 83 c0 17          	add    $0x17,%rax
   406ca:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    // check for write access for end address
    vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
   406ce:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   406d2:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   406d9:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   406dd:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   406e1:	48 89 ce             	mov    %rcx,%rsi
   406e4:	48 89 c7             	mov    %rax,%rdi
   406e7:	e8 00 2a 00 00       	call   430ec <virtual_memory_lookup>
    if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
   406ec:	8b 45 c8             	mov    -0x38(%rbp),%eax
   406ef:	48 98                	cltq   
   406f1:	83 e0 03             	and    $0x3,%eax
   406f4:	48 83 f8 03          	cmp    $0x3,%rax
   406f8:	75 3e                	jne    40738 <syscall_mapping+0xc6>
	return;
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
   406fa:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   406fe:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40705:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40709:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4070d:	48 89 ce             	mov    %rcx,%rsi
   40710:	48 89 c7             	mov    %rax,%rdi
   40713:	e8 d4 29 00 00       	call   430ec <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   40718:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4071c:	48 89 c1             	mov    %rax,%rcx
   4071f:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40723:	ba 18 00 00 00       	mov    $0x18,%edx
   40728:	48 89 c6             	mov    %rax,%rsi
   4072b:	48 89 cf             	mov    %rcx,%rdi
   4072e:	e8 d1 2d 00 00       	call   43504 <memcpy>
   40733:	eb 04                	jmp    40739 <syscall_mapping+0xc7>
	return;
   40735:	90                   	nop
   40736:	eb 01                	jmp    40739 <syscall_mapping+0xc7>
	return;
   40738:	90                   	nop
}
   40739:	c9                   	leave  
   4073a:	c3                   	ret    

000000000004073b <syscall_mem_tog>:

void syscall_mem_tog(proc* process){
   4073b:	55                   	push   %rbp
   4073c:	48 89 e5             	mov    %rsp,%rbp
   4073f:	48 83 ec 18          	sub    $0x18,%rsp
   40743:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)

    pid_t p = process->p_registers.reg_rdi;
   40747:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4074b:	48 8b 40 38          	mov    0x38(%rax),%rax
   4074f:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(p == 0) {
   40752:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   40756:	75 14                	jne    4076c <syscall_mem_tog+0x31>
        disp_global = !disp_global;
   40758:	0f b6 05 a1 58 00 00 	movzbl 0x58a1(%rip),%eax        # 46000 <disp_global>
   4075f:	84 c0                	test   %al,%al
   40761:	0f 94 c0             	sete   %al
   40764:	88 05 96 58 00 00    	mov    %al,0x5896(%rip)        # 46000 <disp_global>
   4076a:	eb 36                	jmp    407a2 <syscall_mem_tog+0x67>
    }
    else {
        if(p < 0 || p > NPROC || p != process->p_pid)
   4076c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   40770:	78 2f                	js     407a1 <syscall_mem_tog+0x66>
   40772:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   40776:	7f 29                	jg     407a1 <syscall_mem_tog+0x66>
   40778:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4077c:	8b 00                	mov    (%rax),%eax
   4077e:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   40781:	75 1e                	jne    407a1 <syscall_mem_tog+0x66>
            return;
        process->display_status = !(process->display_status);
   40783:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40787:	0f b6 80 d8 00 00 00 	movzbl 0xd8(%rax),%eax
   4078e:	84 c0                	test   %al,%al
   40790:	0f 94 c0             	sete   %al
   40793:	89 c2                	mov    %eax,%edx
   40795:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40799:	88 90 d8 00 00 00    	mov    %dl,0xd8(%rax)
   4079f:	eb 01                	jmp    407a2 <syscall_mem_tog+0x67>
            return;
   407a1:	90                   	nop
    }
}
   407a2:	c9                   	leave  
   407a3:	c3                   	ret    

00000000000407a4 <next_free_pid>:
// ---------- FORK HELPERS ----------

// next_free_process(void)
//    returns the next free pid, -1 if there aren't any

pid_t next_free_pid(void) {
   407a4:	55                   	push   %rbp
   407a5:	48 89 e5             	mov    %rsp,%rbp
   407a8:	48 83 ec 10          	sub    $0x10,%rsp
	for (pid_t pid = 1; pid < NPROC; pid++)
   407ac:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
   407b3:	eb 29                	jmp    407de <next_free_pid+0x3a>
		if (processes[pid].p_state == P_FREE)
   407b5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   407b8:	48 63 d0             	movslq %eax,%rdx
   407bb:	48 89 d0             	mov    %rdx,%rax
   407be:	48 c1 e0 03          	shl    $0x3,%rax
   407c2:	48 29 d0             	sub    %rdx,%rax
   407c5:	48 c1 e0 05          	shl    $0x5,%rax
   407c9:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   407cf:	8b 00                	mov    (%rax),%eax
   407d1:	85 c0                	test   %eax,%eax
   407d3:	75 05                	jne    407da <next_free_pid+0x36>
			return pid;
   407d5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   407d8:	eb 0f                	jmp    407e9 <next_free_pid+0x45>
	for (pid_t pid = 1; pid < NPROC; pid++)
   407da:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   407de:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   407e2:	7e d1                	jle    407b5 <next_free_pid+0x11>
	return -1;
   407e4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   407e9:	c9                   	leave  
   407ea:	c3                   	ret    

00000000000407eb <copy_pagetable>:
//		address is readonly, updates page ref
//		otherwise, copies contents to a new physical page
//
//		returns 0 on success, -1 on failure

int copy_pagetable(proc *dest, proc *src) {
   407eb:	55                   	push   %rbp
   407ec:	48 89 e5             	mov    %rsp,%rbp
   407ef:	48 83 ec 40          	sub    $0x40,%rsp
   407f3:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   407f7:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
	for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   407fb:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   40802:	00 
   40803:	e9 15 01 00 00       	jmp    4091d <copy_pagetable+0x132>
		vamapping map = virtual_memory_lookup(src->p_pagetable, va); // examining addr page by page
   40808:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4080c:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40813:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   40817:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4081b:	48 89 ce             	mov    %rcx,%rsi
   4081e:	48 89 c7             	mov    %rax,%rdi
   40821:	e8 c6 28 00 00       	call   430ec <virtual_memory_lookup>
		
		if (map.pn == -1) { // unused va
   40826:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40829:	83 f8 ff             	cmp    $0xffffffff,%eax
   4082c:	0f 84 e2 00 00 00    	je     40914 <copy_pagetable+0x129>
			continue;
		}
		else if ((map.perm & PTE_P) && !(map.perm & PTE_W) && (map.perm & PTE_U)) { // how to detect readonly memory?
   40832:	8b 45 f0             	mov    -0x10(%rbp),%eax
   40835:	48 98                	cltq   
   40837:	83 e0 01             	and    $0x1,%eax
   4083a:	48 85 c0             	test   %rax,%rax
   4083d:	74 5c                	je     4089b <copy_pagetable+0xb0>
   4083f:	8b 45 f0             	mov    -0x10(%rbp),%eax
   40842:	48 98                	cltq   
   40844:	83 e0 02             	and    $0x2,%eax
   40847:	48 85 c0             	test   %rax,%rax
   4084a:	75 4f                	jne    4089b <copy_pagetable+0xb0>
   4084c:	8b 45 f0             	mov    -0x10(%rbp),%eax
   4084f:	48 98                	cltq   
   40851:	83 e0 04             	and    $0x4,%eax
   40854:	48 85 c0             	test   %rax,%rax
   40857:	74 42                	je     4089b <copy_pagetable+0xb0>
			pageinfo[map.pn].refcount++;	
   40859:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4085c:	48 63 d0             	movslq %eax,%rdx
   4085f:	0f b6 94 12 41 2e 05 	movzbl 0x52e41(%rdx,%rdx,1),%edx
   40866:	00 
   40867:	83 c2 01             	add    $0x1,%edx
   4086a:	48 98                	cltq   
   4086c:	88 94 00 41 2e 05 00 	mov    %dl,0x52e41(%rax,%rax,1)
			virtual_memory_map(dest->p_pagetable, va, map.pa, PAGESIZE, map.perm);
   40873:	8b 4d f0             	mov    -0x10(%rbp),%ecx
   40876:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   4087a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4087e:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40885:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   40889:	41 89 c8             	mov    %ecx,%r8d
   4088c:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40891:	48 89 c7             	mov    %rax,%rdi
   40894:	e8 8d 24 00 00       	call   42d26 <virtual_memory_map>
   40899:	eb 7a                	jmp    40915 <copy_pagetable+0x12a>
			//	console_printf(CPOS(23, 0), 0x1100, "proc 1 code page owner: %d, proc 1 code page refcount: %d\n", pageinfo[PAGENUMBER(0x7000)].owner, pageinfo[PAGENUMBER(0x7000)].refcount); 
			//}
		}
		else {
			uintptr_t free_page;
			if (next_free_page(&free_page)
   4089b:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   4089f:	48 89 c7             	mov    %rax,%rdi
   408a2:	e8 90 fa ff ff       	call   40337 <next_free_page>
   408a7:	85 c0                	test   %eax,%eax
   408a9:	75 45                	jne    408f0 <copy_pagetable+0x105>
				|| assign_physical_page(free_page, dest->p_pid)
   408ab:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   408af:	8b 00                	mov    (%rax),%eax
   408b1:	0f be d0             	movsbl %al,%edx
   408b4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   408b8:	89 d6                	mov    %edx,%esi
   408ba:	48 89 c7             	mov    %rax,%rdi
   408bd:	e8 3c fd ff ff       	call   405fe <assign_physical_page>
   408c2:	85 c0                	test   %eax,%eax
   408c4:	75 2a                	jne    408f0 <copy_pagetable+0x105>
				|| virtual_memory_map(dest->p_pagetable, va, free_page, PAGESIZE, map.perm)) {
   408c6:	8b 4d f0             	mov    -0x10(%rbp),%ecx
   408c9:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   408cd:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   408d1:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   408d8:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   408dc:	41 89 c8             	mov    %ecx,%r8d
   408df:	b9 00 10 00 00       	mov    $0x1000,%ecx
   408e4:	48 89 c7             	mov    %rax,%rdi
   408e7:	e8 3a 24 00 00       	call   42d26 <virtual_memory_map>
   408ec:	85 c0                	test   %eax,%eax
   408ee:	74 07                	je     408f7 <copy_pagetable+0x10c>

				// failure conditions are 
				//  no free page, 
				//  no allocated l1 pagetable <-- i don't think we'll ever actually run into this 

				return -1;
   408f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   408f5:	eb 39                	jmp    40930 <copy_pagetable+0x145>
			}
			else {
				memcpy((void *) free_page, (void *) map.pa, PAGESIZE);
   408f7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   408fb:	48 89 c1             	mov    %rax,%rcx
   408fe:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40902:	ba 00 10 00 00       	mov    $0x1000,%edx
   40907:	48 89 ce             	mov    %rcx,%rsi
   4090a:	48 89 c7             	mov    %rax,%rdi
   4090d:	e8 f2 2b 00 00       	call   43504 <memcpy>
   40912:	eb 01                	jmp    40915 <copy_pagetable+0x12a>
			continue;
   40914:	90                   	nop
	for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   40915:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4091c:	00 
   4091d:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   40924:	00 
   40925:	0f 86 dd fe ff ff    	jbe    40808 <copy_pagetable+0x1d>
			}
		}
	}

	return 0;
   4092b:	b8 00 00 00 00       	mov    $0x0,%eax
}
   40930:	c9                   	leave  
   40931:	c3                   	ret    

0000000000040932 <free_pages_pa>:
//		pages!
//
//		in practice, this function frees pagetable pages


void free_pages_pa(proc *p) {
   40932:	55                   	push   %rbp
   40933:	48 89 e5             	mov    %rsp,%rbp
   40936:	48 83 ec 18          	sub    $0x18,%rsp
   4093a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
	for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   4093e:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40945:	00 
   40946:	eb 5d                	jmp    409a5 <free_pages_pa+0x73>
		if (pageinfo[PAGENUMBER(addr)].owner == p->p_pid) {
   40948:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4094c:	48 c1 e8 0c          	shr    $0xc,%rax
   40950:	48 98                	cltq   
   40952:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   40959:	00 
   4095a:	0f be d0             	movsbl %al,%edx
   4095d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40961:	8b 00                	mov    (%rax),%eax
   40963:	39 c2                	cmp    %eax,%edx
   40965:	75 36                	jne    4099d <free_pages_pa+0x6b>
			pageinfo[PAGENUMBER(addr)].owner = PO_FREE;
   40967:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4096b:	48 c1 e8 0c          	shr    $0xc,%rax
   4096f:	48 98                	cltq   
   40971:	c6 84 00 40 2e 05 00 	movb   $0x0,0x52e40(%rax,%rax,1)
   40978:	00 
			--pageinfo[PAGENUMBER(addr)].refcount;
   40979:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4097d:	48 c1 e8 0c          	shr    $0xc,%rax
   40981:	89 c2                	mov    %eax,%edx
   40983:	48 63 c2             	movslq %edx,%rax
   40986:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   4098d:	00 
   4098e:	83 e8 01             	sub    $0x1,%eax
   40991:	89 c1                	mov    %eax,%ecx
   40993:	48 63 c2             	movslq %edx,%rax
   40996:	88 8c 00 41 2e 05 00 	mov    %cl,0x52e41(%rax,%rax,1)
	for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   4099d:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   409a4:	00 
   409a5:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   409ac:	00 
   409ad:	76 99                	jbe    40948 <free_pages_pa+0x16>
		}
	}
}
   409af:	90                   	nop
   409b0:	90                   	nop
   409b1:	c9                   	leave  
   409b2:	c3                   	ret    

00000000000409b3 <free_pages_va>:

// free_process_pages(pid_t pid)
//		frees physical pages allocated to the process with pid

void free_pages_va(proc *p) {
   409b3:	55                   	push   %rbp
   409b4:	48 89 e5             	mov    %rsp,%rbp
   409b7:	48 83 ec 30          	sub    $0x30,%rsp
   409bb:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
	for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   409bf:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   409c6:	00 
   409c7:	e9 8c 00 00 00       	jmp    40a58 <free_pages_va+0xa5>
		vamapping map = virtual_memory_lookup(p->p_pagetable, va); // examining addr page by page
   409cc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   409d0:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   409d7:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   409db:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   409df:	48 89 ce             	mov    %rcx,%rsi
   409e2:	48 89 c7             	mov    %rax,%rdi
   409e5:	e8 02 27 00 00       	call   430ec <virtual_memory_lookup>
		
		if (map.pn == -1) { // unused va
   409ea:	8b 45 e0             	mov    -0x20(%rbp),%eax
   409ed:	83 f8 ff             	cmp    $0xffffffff,%eax
   409f0:	74 5d                	je     40a4f <free_pages_va+0x9c>
			continue;
		}
		else if ((map.perm & PTE_P) && (map.perm & PTE_U)) {
   409f2:	8b 45 f0             	mov    -0x10(%rbp),%eax
   409f5:	48 98                	cltq   
   409f7:	83 e0 01             	and    $0x1,%eax
   409fa:	48 85 c0             	test   %rax,%rax
   409fd:	74 51                	je     40a50 <free_pages_va+0x9d>
   409ff:	8b 45 f0             	mov    -0x10(%rbp),%eax
   40a02:	48 98                	cltq   
   40a04:	83 e0 04             	and    $0x4,%eax
   40a07:	48 85 c0             	test   %rax,%rax
   40a0a:	74 44                	je     40a50 <free_pages_va+0x9d>
			if (pageinfo[map.pn].owner == p->p_pid)
   40a0c:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40a0f:	48 98                	cltq   
   40a11:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   40a18:	00 
   40a19:	0f be d0             	movsbl %al,%edx
   40a1c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40a20:	8b 00                	mov    (%rax),%eax
   40a22:	39 c2                	cmp    %eax,%edx
   40a24:	75 0d                	jne    40a33 <free_pages_va+0x80>
				pageinfo[map.pn].owner = PO_FREE;
   40a26:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40a29:	48 98                	cltq   
   40a2b:	c6 84 00 40 2e 05 00 	movb   $0x0,0x52e40(%rax,%rax,1)
   40a32:	00 
			--pageinfo[map.pn].refcount;	
   40a33:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40a36:	48 63 d0             	movslq %eax,%rdx
   40a39:	0f b6 94 12 41 2e 05 	movzbl 0x52e41(%rdx,%rdx,1),%edx
   40a40:	00 
   40a41:	83 ea 01             	sub    $0x1,%edx
   40a44:	48 98                	cltq   
   40a46:	88 94 00 41 2e 05 00 	mov    %dl,0x52e41(%rax,%rax,1)
   40a4d:	eb 01                	jmp    40a50 <free_pages_va+0x9d>
			continue;
   40a4f:	90                   	nop
	for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   40a50:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40a57:	00 
   40a58:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   40a5f:	00 
   40a60:	0f 86 66 ff ff ff    	jbe    409cc <free_pages_va+0x19>
			//	console_printf(CPOS(23, 0), 0x0, 0);	
			//	console_printf(CPOS(23, 0), 0x1100, "proc 1 code page owner: %d, proc 1 code page refcount: %d\n", pageinfo[PAGENUMBER(0x7000)].owner, pageinfo[PAGENUMBER(0x7000)].refcount); 
			//}
		}
	}
}
   40a66:	90                   	nop
   40a67:	90                   	nop
   40a68:	c9                   	leave  
   40a69:	c3                   	ret    

0000000000040a6a <exception>:
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_64_registers* reg) {
   40a6a:	55                   	push   %rbp
   40a6b:	48 89 e5             	mov    %rsp,%rbp
   40a6e:	48 81 ec 30 01 00 00 	sub    $0x130,%rsp
   40a75:	48 89 bd d8 fe ff ff 	mov    %rdi,-0x128(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   40a7c:	48 8b 05 7d 15 01 00 	mov    0x1157d(%rip),%rax        # 52000 <current>
   40a83:	48 8b 95 d8 fe ff ff 	mov    -0x128(%rbp),%rdx
   40a8a:	48 83 c0 08          	add    $0x8,%rax
   40a8e:	48 89 d6             	mov    %rdx,%rsi
   40a91:	ba 18 00 00 00       	mov    $0x18,%edx
   40a96:	48 89 c7             	mov    %rax,%rdi
   40a99:	48 89 d1             	mov    %rdx,%rcx
   40a9c:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   40a9f:	48 8b 05 5a 45 01 00 	mov    0x1455a(%rip),%rax        # 55000 <kernel_pagetable>
   40aa6:	48 89 c7             	mov    %rax,%rdi
   40aa9:	e8 47 21 00 00       	call   42bf5 <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   40aae:	8b 05 48 85 07 00    	mov    0x78548(%rip),%eax        # b8ffc <cursorpos>
   40ab4:	89 c7                	mov    %eax,%edi
   40ab6:	e8 68 18 00 00       	call   42323 <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT && reg->reg_intno != INT_GPF) // no error due to pagefault or general fault
   40abb:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40ac2:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40ac9:	48 83 f8 0e          	cmp    $0xe,%rax
   40acd:	74 14                	je     40ae3 <exception+0x79>
   40acf:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40ad6:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40add:	48 83 f8 0d          	cmp    $0xd,%rax
   40ae1:	75 16                	jne    40af9 <exception+0x8f>
            || (reg->reg_err & PFERR_USER)) // pagefault error in user mode 
   40ae3:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40aea:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40af1:	83 e0 04             	and    $0x4,%eax
   40af4:	48 85 c0             	test   %rax,%rax
   40af7:	74 1a                	je     40b13 <exception+0xa9>
    {
        check_virtual_memory();
   40af9:	e8 d9 09 00 00       	call   414d7 <check_virtual_memory>
        if(disp_global){
   40afe:	0f b6 05 fb 54 00 00 	movzbl 0x54fb(%rip),%eax        # 46000 <disp_global>
   40b05:	84 c0                	test   %al,%al
   40b07:	74 0a                	je     40b13 <exception+0xa9>
            memshow_physical();
   40b09:	e8 41 0b 00 00       	call   4164f <memshow_physical>
            memshow_virtual_animate();
   40b0e:	e8 6b 0e 00 00       	call   4197e <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   40b13:	e8 ee 1c 00 00       	call   42806 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   40b18:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40b1f:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40b26:	48 83 e8 0e          	sub    $0xe,%rax
   40b2a:	48 83 f8 2a          	cmp    $0x2a,%rax
   40b2e:	0f 87 b2 04 00 00    	ja     40fe6 <exception+0x57c>
   40b34:	48 8b 04 c5 58 46 04 	mov    0x44658(,%rax,8),%rax
   40b3b:	00 
   40b3c:	ff e0                	jmp    *%rax

    case INT_SYS_PANIC:
	    // rdi stores pointer for msg string
	    {
		char msg[160];
		uintptr_t addr = current->p_registers.reg_rdi;
   40b3e:	48 8b 05 bb 14 01 00 	mov    0x114bb(%rip),%rax        # 52000 <current>
   40b45:	48 8b 40 38          	mov    0x38(%rax),%rax
   40b49:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
		if((void *)addr == NULL)
   40b4d:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   40b52:	75 0f                	jne    40b63 <exception+0xf9>
		    panic(NULL);
   40b54:	bf 00 00 00 00       	mov    $0x0,%edi
   40b59:	b8 00 00 00 00       	mov    $0x0,%eax
   40b5e:	e8 e4 1d 00 00       	call   42947 <panic>
		vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   40b63:	48 8b 05 96 14 01 00 	mov    0x11496(%rip),%rax        # 52000 <current>
   40b6a:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40b71:	48 8d 45 90          	lea    -0x70(%rbp),%rax
   40b75:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   40b79:	48 89 ce             	mov    %rcx,%rsi
   40b7c:	48 89 c7             	mov    %rax,%rdi
   40b7f:	e8 68 25 00 00       	call   430ec <virtual_memory_lookup>
		memcpy(msg, (void *)map.pa, 160);
   40b84:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40b88:	48 89 c1             	mov    %rax,%rcx
   40b8b:	48 8d 85 e8 fe ff ff 	lea    -0x118(%rbp),%rax
   40b92:	ba a0 00 00 00       	mov    $0xa0,%edx
   40b97:	48 89 ce             	mov    %rcx,%rsi
   40b9a:	48 89 c7             	mov    %rax,%rdi
   40b9d:	e8 62 29 00 00       	call   43504 <memcpy>
		panic(msg);
   40ba2:	48 8d 85 e8 fe ff ff 	lea    -0x118(%rbp),%rax
   40ba9:	48 89 c7             	mov    %rax,%rdi
   40bac:	b8 00 00 00 00       	mov    $0x0,%eax
   40bb1:	e8 91 1d 00 00       	call   42947 <panic>
	    }
	    panic(NULL);
	    break;                  // will not be reached

    case INT_SYS_GETPID:
        current->p_registers.reg_rax = current->p_pid;
   40bb6:	48 8b 05 43 14 01 00 	mov    0x11443(%rip),%rax        # 52000 <current>
   40bbd:	8b 10                	mov    (%rax),%edx
   40bbf:	48 8b 05 3a 14 01 00 	mov    0x1143a(%rip),%rax        # 52000 <current>
   40bc6:	48 63 d2             	movslq %edx,%rdx
   40bc9:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   40bcd:	e9 24 04 00 00       	jmp    40ff6 <exception+0x58c>

    case INT_SYS_YIELD:
        schedule();
   40bd2:	e8 48 04 00 00       	call   4101f <schedule>
        break;                  /* will not be reached */
   40bd7:	e9 1a 04 00 00       	jmp    40ff6 <exception+0x58c>

    case INT_SYS_PAGE_ALLOC: 
	{
        uintptr_t va = current->p_registers.reg_rdi; 
   40bdc:	48 8b 05 1d 14 01 00 	mov    0x1141d(%rip),%rax        # 52000 <current>
   40be3:	48 8b 40 38          	mov    0x38(%rax),%rax
   40be7:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
		uintptr_t pa;
		int r = 0;
   40beb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
		if (va % PAGESIZE != 0) {
   40bf2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40bf6:	25 ff 0f 00 00       	and    $0xfff,%eax
   40bfb:	48 85 c0             	test   %rax,%rax
   40bfe:	74 0c                	je     40c0c <exception+0x1a2>
			r = -1;
   40c00:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
   40c07:	e9 b9 00 00 00       	jmp    40cc5 <exception+0x25b>
		}
		else if (virtual_memory_lookup(current->p_pagetable, va).pn != -1) {
   40c0c:	48 8b 05 ed 13 01 00 	mov    0x113ed(%rip),%rax        # 52000 <current>
   40c13:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40c1a:	48 8d 45 a8          	lea    -0x58(%rbp),%rax
   40c1e:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   40c22:	48 89 ce             	mov    %rcx,%rsi
   40c25:	48 89 c7             	mov    %rax,%rdi
   40c28:	e8 bf 24 00 00       	call   430ec <virtual_memory_lookup>
   40c2d:	8b 45 a8             	mov    -0x58(%rbp),%eax
   40c30:	83 f8 ff             	cmp    $0xffffffff,%eax
   40c33:	74 0c                	je     40c41 <exception+0x1d7>
			r = -1;
   40c35:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
   40c3c:	e9 84 00 00 00       	jmp    40cc5 <exception+0x25b>
		}
		else if (next_free_page(&pa) || assign_physical_page(pa, current->p_pid)) {
   40c41:	48 8d 45 88          	lea    -0x78(%rbp),%rax
   40c45:	48 89 c7             	mov    %rax,%rdi
   40c48:	e8 ea f6 ff ff       	call   40337 <next_free_page>
   40c4d:	85 c0                	test   %eax,%eax
   40c4f:	75 1e                	jne    40c6f <exception+0x205>
   40c51:	48 8b 05 a8 13 01 00 	mov    0x113a8(%rip),%rax        # 52000 <current>
   40c58:	8b 00                	mov    (%rax),%eax
   40c5a:	0f be d0             	movsbl %al,%edx
   40c5d:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   40c61:	89 d6                	mov    %edx,%esi
   40c63:	48 89 c7             	mov    %rax,%rdi
   40c66:	e8 93 f9 ff ff       	call   405fe <assign_physical_page>
   40c6b:	85 c0                	test   %eax,%eax
   40c6d:	74 22                	je     40c91 <exception+0x227>
			console_printf(CPOS(23, 0), 0x0400, "Out of physical memory!\n");	
   40c6f:	ba 90 45 04 00       	mov    $0x44590,%edx
   40c74:	be 00 04 00 00       	mov    $0x400,%esi
   40c79:	bf 30 07 00 00       	mov    $0x730,%edi
   40c7e:	b8 00 00 00 00       	mov    $0x0,%eax
   40c83:	e8 31 37 00 00       	call   443b9 <console_printf>
			r = -1;
   40c88:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
   40c8f:	eb 34                	jmp    40cc5 <exception+0x25b>
		}
		else if (virtual_memory_map(current->p_pagetable, va, pa, PAGESIZE, PTE_P | PTE_W | PTE_U)) {
   40c91:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   40c95:	48 8b 05 64 13 01 00 	mov    0x11364(%rip),%rax        # 52000 <current>
   40c9c:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40ca3:	48 8b 75 e8          	mov    -0x18(%rbp),%rsi
   40ca7:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40cad:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40cb2:	48 89 c7             	mov    %rax,%rdi
   40cb5:	e8 6c 20 00 00       	call   42d26 <virtual_memory_map>
   40cba:	85 c0                	test   %eax,%eax
   40cbc:	74 07                	je     40cc5 <exception+0x25b>
			r = -1;
   40cbe:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
		}

        current->p_registers.reg_rax = r;
   40cc5:	48 8b 05 34 13 01 00 	mov    0x11334(%rip),%rax        # 52000 <current>
   40ccc:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40ccf:	48 63 d2             	movslq %edx,%rdx
   40cd2:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   40cd6:	e9 1b 03 00 00       	jmp    40ff6 <exception+0x58c>
    }

    case INT_SYS_MAPPING:
    {
	    syscall_mapping(current);
   40cdb:	48 8b 05 1e 13 01 00 	mov    0x1131e(%rip),%rax        # 52000 <current>
   40ce2:	48 89 c7             	mov    %rax,%rdi
   40ce5:	e8 88 f9 ff ff       	call   40672 <syscall_mapping>
            break;
   40cea:	e9 07 03 00 00       	jmp    40ff6 <exception+0x58c>
    }

    case INT_SYS_MEM_TOG:
	{
	    syscall_mem_tog(current);
   40cef:	48 8b 05 0a 13 01 00 	mov    0x1130a(%rip),%rax        # 52000 <current>
   40cf6:	48 89 c7             	mov    %rax,%rdi
   40cf9:	e8 3d fa ff ff       	call   4073b <syscall_mem_tog>
	    break;
   40cfe:	e9 f3 02 00 00       	jmp    40ff6 <exception+0x58c>
	}

    case INT_TIMER:
        ++ticks;
   40d03:	8b 05 17 21 01 00    	mov    0x12117(%rip),%eax        # 52e20 <ticks>
   40d09:	83 c0 01             	add    $0x1,%eax
   40d0c:	89 05 0e 21 01 00    	mov    %eax,0x1210e(%rip)        # 52e20 <ticks>
        schedule();
   40d12:	e8 08 03 00 00       	call   4101f <schedule>
        break;                  /* will not be reached */
   40d17:	e9 da 02 00 00       	jmp    40ff6 <exception+0x58c>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   40d1c:	0f 20 d0             	mov    %cr2,%rax
   40d1f:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    return val;
   40d23:	48 8b 45 c0          	mov    -0x40(%rbp),%rax

    case INT_PAGEFAULT: {
        // Analyze faulting address and access type.
        uintptr_t addr = rcr2();
   40d27:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        const char* operation = reg->reg_err & PFERR_WRITE
   40d2b:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40d32:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40d39:	83 e0 02             	and    $0x2,%eax
                ? "write" : "read";
   40d3c:	48 85 c0             	test   %rax,%rax
   40d3f:	74 07                	je     40d48 <exception+0x2de>
   40d41:	b8 a9 45 04 00       	mov    $0x445a9,%eax
   40d46:	eb 05                	jmp    40d4d <exception+0x2e3>
   40d48:	b8 af 45 04 00       	mov    $0x445af,%eax
        const char* operation = reg->reg_err & PFERR_WRITE
   40d4d:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        const char* problem = reg->reg_err & PFERR_PRESENT
   40d51:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40d58:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40d5f:	83 e0 01             	and    $0x1,%eax
                ? "protection problem" : "missing page";
   40d62:	48 85 c0             	test   %rax,%rax
   40d65:	74 07                	je     40d6e <exception+0x304>
   40d67:	b8 b4 45 04 00       	mov    $0x445b4,%eax
   40d6c:	eb 05                	jmp    40d73 <exception+0x309>
   40d6e:	b8 c7 45 04 00       	mov    $0x445c7,%eax
        const char* problem = reg->reg_err & PFERR_PRESENT
   40d73:	48 89 45 c8          	mov    %rax,-0x38(%rbp)

        if (!(reg->reg_err & PFERR_USER)) {
   40d77:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40d7e:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40d85:	83 e0 04             	and    $0x4,%eax
   40d88:	48 85 c0             	test   %rax,%rax
   40d8b:	75 2f                	jne    40dbc <exception+0x352>
            panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   40d8d:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40d94:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   40d9b:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   40d9f:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   40da3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40da7:	49 89 f0             	mov    %rsi,%r8
   40daa:	48 89 c6             	mov    %rax,%rsi
   40dad:	bf d8 45 04 00       	mov    $0x445d8,%edi
   40db2:	b8 00 00 00 00       	mov    $0x0,%eax
   40db7:	e8 8b 1b 00 00       	call   42947 <panic>
                  addr, operation, problem, reg->reg_rip);
        }
        console_printf(CPOS(24, 0), 0x0C00,
   40dbc:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40dc3:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                       "Process %d page fault for %p (%s %s, rip=%p)!\n",
                       current->p_pid, addr, operation, problem, reg->reg_rip);
   40dca:	48 8b 05 2f 12 01 00 	mov    0x1122f(%rip),%rax        # 52000 <current>
        console_printf(CPOS(24, 0), 0x0C00,
   40dd1:	8b 00                	mov    (%rax),%eax
   40dd3:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
   40dd7:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   40ddb:	52                   	push   %rdx
   40ddc:	ff 75 c8             	push   -0x38(%rbp)
   40ddf:	49 89 f1             	mov    %rsi,%r9
   40de2:	49 89 c8             	mov    %rcx,%r8
   40de5:	89 c1                	mov    %eax,%ecx
   40de7:	ba 08 46 04 00       	mov    $0x44608,%edx
   40dec:	be 00 0c 00 00       	mov    $0xc00,%esi
   40df1:	bf 80 07 00 00       	mov    $0x780,%edi
   40df6:	b8 00 00 00 00       	mov    $0x0,%eax
   40dfb:	e8 b9 35 00 00       	call   443b9 <console_printf>
   40e00:	48 83 c4 10          	add    $0x10,%rsp
        current->p_state = P_BROKEN;
   40e04:	48 8b 05 f5 11 01 00 	mov    0x111f5(%rip),%rax        # 52000 <current>
   40e0b:	c7 80 c8 00 00 00 03 	movl   $0x3,0xc8(%rax)
   40e12:	00 00 00 
        break;
   40e15:	e9 dc 01 00 00       	jmp    40ff6 <exception+0x58c>
    }

	case INT_SYS_FORK:
		// find free pid
		pid_t child_pid;
		if ((child_pid = next_free_pid()) == -1) {
   40e1a:	e8 85 f9 ff ff       	call   407a4 <next_free_pid>
   40e1f:	89 45 f8             	mov    %eax,-0x8(%rbp)
   40e22:	83 7d f8 ff          	cmpl   $0xffffffff,-0x8(%rbp)
   40e26:	75 32                	jne    40e5a <exception+0x3f0>
			console_printf(CPOS(23, 0), 0x0400, "Max processes (%d) reached!\n", NPROC);	
   40e28:	b9 10 00 00 00       	mov    $0x10,%ecx
   40e2d:	ba 37 46 04 00       	mov    $0x44637,%edx
   40e32:	be 00 04 00 00       	mov    $0x400,%esi
   40e37:	bf 30 07 00 00       	mov    $0x730,%edi
   40e3c:	b8 00 00 00 00       	mov    $0x0,%eax
   40e41:	e8 73 35 00 00       	call   443b9 <console_printf>
			current->p_registers.reg_rax = -1;
   40e46:	48 8b 05 b3 11 01 00 	mov    0x111b3(%rip),%rax        # 52000 <current>
   40e4d:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40e54:	ff 
			break;
   40e55:	e9 9c 01 00 00       	jmp    40ff6 <exception+0x58c>
		}

		proc *child_proc = &processes[child_pid];
   40e5a:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40e5d:	48 63 d0             	movslq %eax,%rdx
   40e60:	48 89 d0             	mov    %rdx,%rax
   40e63:	48 c1 e0 03          	shl    $0x3,%rax
   40e67:	48 29 d0             	sub    %rdx,%rax
   40e6a:	48 c1 e0 05          	shl    $0x5,%rax
   40e6e:	48 05 20 20 05 00    	add    $0x52020,%rax
   40e74:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

		// copy the state of parent into child
		*child_proc = processes[current->p_pid];
   40e78:	48 8b 05 81 11 01 00 	mov    0x11181(%rip),%rax        # 52000 <current>
   40e7f:	8b 00                	mov    (%rax),%eax
   40e81:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
   40e85:	48 63 d0             	movslq %eax,%rdx
   40e88:	48 89 d0             	mov    %rdx,%rax
   40e8b:	48 c1 e0 03          	shl    $0x3,%rax
   40e8f:	48 29 d0             	sub    %rdx,%rax
   40e92:	48 c1 e0 05          	shl    $0x5,%rax
   40e96:	48 05 20 20 05 00    	add    $0x52020,%rax
   40e9c:	48 89 ca             	mov    %rcx,%rdx
   40e9f:	48 89 c6             	mov    %rax,%rsi
   40ea2:	b8 1c 00 00 00       	mov    $0x1c,%eax
   40ea7:	48 89 d7             	mov    %rdx,%rdi
   40eaa:	48 89 c1             	mov    %rax,%rcx
   40ead:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
		child_proc->p_pid = child_pid;
   40eb0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40eb4:	8b 55 f8             	mov    -0x8(%rbp),%edx
   40eb7:	89 10                	mov    %edx,(%rax)

		
		// setup and copy the pagetable
		if (pagetable_setup(child_proc->p_pid)) {
   40eb9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40ebd:	8b 00                	mov    (%rax),%eax
   40ebf:	89 c7                	mov    %eax,%edi
   40ec1:	e8 de f4 ff ff       	call   403a4 <pagetable_setup>
   40ec6:	85 c0                	test   %eax,%eax
   40ec8:	74 36                	je     40f00 <exception+0x496>
			free_pages_pa(child_proc); // goes through all pa and frees ones that belong to child_proc
   40eca:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40ece:	48 89 c7             	mov    %rax,%rdi
   40ed1:	e8 5c fa ff ff       	call   40932 <free_pages_pa>
			memset(child_proc, 0, sizeof(*child_proc));
   40ed6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40eda:	ba e0 00 00 00       	mov    $0xe0,%edx
   40edf:	be 00 00 00 00       	mov    $0x0,%esi
   40ee4:	48 89 c7             	mov    %rax,%rdi
   40ee7:	e8 16 27 00 00       	call   43602 <memset>

			current->p_registers.reg_rax = -1;
   40eec:	48 8b 05 0d 11 01 00 	mov    0x1110d(%rip),%rax        # 52000 <current>
   40ef3:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40efa:	ff 
			break;
   40efb:	e9 f6 00 00 00       	jmp    40ff6 <exception+0x58c>
		}
		else if (copy_pagetable(child_proc, current)) {
   40f00:	48 8b 15 f9 10 01 00 	mov    0x110f9(%rip),%rdx        # 52000 <current>
   40f07:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40f0b:	48 89 d6             	mov    %rdx,%rsi
   40f0e:	48 89 c7             	mov    %rax,%rdi
   40f11:	e8 d5 f8 ff ff       	call   407eb <copy_pagetable>
   40f16:	85 c0                	test   %eax,%eax
   40f18:	74 42                	je     40f5c <exception+0x4f2>
			free_pages_va(child_proc); // goes through all va and frees corresponding physical page
   40f1a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40f1e:	48 89 c7             	mov    %rax,%rdi
   40f21:	e8 8d fa ff ff       	call   409b3 <free_pages_va>
			free_pages_pa(child_proc); // goes through all pa and frees ones that belong to child_proc
   40f26:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40f2a:	48 89 c7             	mov    %rax,%rdi
   40f2d:	e8 00 fa ff ff       	call   40932 <free_pages_pa>

			memset(child_proc, 0, sizeof(*child_proc));
   40f32:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40f36:	ba e0 00 00 00       	mov    $0xe0,%edx
   40f3b:	be 00 00 00 00       	mov    $0x0,%esi
   40f40:	48 89 c7             	mov    %rax,%rdi
   40f43:	e8 ba 26 00 00       	call   43602 <memset>
			current->p_registers.reg_rax = -1;
   40f48:	48 8b 05 b1 10 01 00 	mov    0x110b1(%rip),%rax        # 52000 <current>
   40f4f:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40f56:	ff 
			break;
   40f57:	e9 9a 00 00 00       	jmp    40ff6 <exception+0x58c>
		}


		// successful fork! set return registers
                console_printf(CPOS(24, 0), 0, "\n");
   40f5c:	ba 54 46 04 00       	mov    $0x44654,%edx
   40f61:	be 00 00 00 00       	mov    $0x0,%esi
   40f66:	bf 80 07 00 00       	mov    $0x780,%edi
   40f6b:	b8 00 00 00 00       	mov    $0x0,%eax
   40f70:	e8 44 34 00 00       	call   443b9 <console_printf>

		child_proc->p_registers.reg_rax = 0;
   40f75:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40f79:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
   40f80:	00 
		current->p_registers.reg_rax = child_pid;
   40f81:	48 8b 05 78 10 01 00 	mov    0x11078(%rip),%rax        # 52000 <current>
   40f88:	8b 55 f8             	mov    -0x8(%rbp),%edx
   40f8b:	48 63 d2             	movslq %edx,%rdx
   40f8e:	48 89 50 08          	mov    %rdx,0x8(%rax)
		break;
   40f92:	eb 62                	jmp    40ff6 <exception+0x58c>

	case INT_SYS_EXIT:
		free_pages_va(current); // goes through all va and frees corresponding physical page
   40f94:	48 8b 05 65 10 01 00 	mov    0x11065(%rip),%rax        # 52000 <current>
   40f9b:	48 89 c7             	mov    %rax,%rdi
   40f9e:	e8 10 fa ff ff       	call   409b3 <free_pages_va>
		free_pages_pa(current); // goes through all pa and frees ones that belong to child_proc
   40fa3:	48 8b 05 56 10 01 00 	mov    0x11056(%rip),%rax        # 52000 <current>
   40faa:	48 89 c7             	mov    %rax,%rdi
   40fad:	e8 80 f9 ff ff       	call   40932 <free_pages_pa>
		memset(&processes[current->p_pid], 0, sizeof(*current));
   40fb2:	48 8b 05 47 10 01 00 	mov    0x11047(%rip),%rax        # 52000 <current>
   40fb9:	8b 00                	mov    (%rax),%eax
   40fbb:	48 63 d0             	movslq %eax,%rdx
   40fbe:	48 89 d0             	mov    %rdx,%rax
   40fc1:	48 c1 e0 03          	shl    $0x3,%rax
   40fc5:	48 29 d0             	sub    %rdx,%rax
   40fc8:	48 c1 e0 05          	shl    $0x5,%rax
   40fcc:	48 05 20 20 05 00    	add    $0x52020,%rax
   40fd2:	ba e0 00 00 00       	mov    $0xe0,%edx
   40fd7:	be 00 00 00 00       	mov    $0x0,%esi
   40fdc:	48 89 c7             	mov    %rax,%rdi
   40fdf:	e8 1e 26 00 00       	call   43602 <memset>
		break;
   40fe4:	eb 10                	jmp    40ff6 <exception+0x58c>

    default:
        default_exception(current);
   40fe6:	48 8b 05 13 10 01 00 	mov    0x11013(%rip),%rax        # 52000 <current>
   40fed:	48 89 c7             	mov    %rax,%rdi
   40ff0:	e8 62 1a 00 00       	call   42a57 <default_exception>
        break;                  /* will not be reached */
   40ff5:	90                   	nop

    }


    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   40ff6:	48 8b 05 03 10 01 00 	mov    0x11003(%rip),%rax        # 52000 <current>
   40ffd:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   41003:	83 f8 01             	cmp    $0x1,%eax
   41006:	75 0f                	jne    41017 <exception+0x5ad>
        run(current);
   41008:	48 8b 05 f1 0f 01 00 	mov    0x10ff1(%rip),%rax        # 52000 <current>
   4100f:	48 89 c7             	mov    %rax,%rdi
   41012:	e8 7e 00 00 00       	call   41095 <run>
    } else {
        schedule();
   41017:	e8 03 00 00 00       	call   4101f <schedule>
    }
}
   4101c:	90                   	nop
   4101d:	c9                   	leave  
   4101e:	c3                   	ret    

000000000004101f <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   4101f:	55                   	push   %rbp
   41020:	48 89 e5             	mov    %rsp,%rbp
   41023:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   41027:	48 8b 05 d2 0f 01 00 	mov    0x10fd2(%rip),%rax        # 52000 <current>
   4102e:	8b 00                	mov    (%rax),%eax
   41030:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   41033:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41036:	8d 50 01             	lea    0x1(%rax),%edx
   41039:	89 d0                	mov    %edx,%eax
   4103b:	c1 f8 1f             	sar    $0x1f,%eax
   4103e:	c1 e8 1c             	shr    $0x1c,%eax
   41041:	01 c2                	add    %eax,%edx
   41043:	83 e2 0f             	and    $0xf,%edx
   41046:	29 c2                	sub    %eax,%edx
   41048:	89 55 fc             	mov    %edx,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   4104b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4104e:	48 63 d0             	movslq %eax,%rdx
   41051:	48 89 d0             	mov    %rdx,%rax
   41054:	48 c1 e0 03          	shl    $0x3,%rax
   41058:	48 29 d0             	sub    %rdx,%rax
   4105b:	48 c1 e0 05          	shl    $0x5,%rax
   4105f:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   41065:	8b 00                	mov    (%rax),%eax
   41067:	83 f8 01             	cmp    $0x1,%eax
   4106a:	75 22                	jne    4108e <schedule+0x6f>
            run(&processes[pid]);
   4106c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4106f:	48 63 d0             	movslq %eax,%rdx
   41072:	48 89 d0             	mov    %rdx,%rax
   41075:	48 c1 e0 03          	shl    $0x3,%rax
   41079:	48 29 d0             	sub    %rdx,%rax
   4107c:	48 c1 e0 05          	shl    $0x5,%rax
   41080:	48 05 20 20 05 00    	add    $0x52020,%rax
   41086:	48 89 c7             	mov    %rax,%rdi
   41089:	e8 07 00 00 00       	call   41095 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   4108e:	e8 73 17 00 00       	call   42806 <check_keyboard>
        pid = (pid + 1) % NPROC;
   41093:	eb 9e                	jmp    41033 <schedule+0x14>

0000000000041095 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   41095:	55                   	push   %rbp
   41096:	48 89 e5             	mov    %rsp,%rbp
   41099:	48 83 ec 10          	sub    $0x10,%rsp
   4109d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   410a1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   410a5:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   410ab:	83 f8 01             	cmp    $0x1,%eax
   410ae:	74 14                	je     410c4 <run+0x2f>
   410b0:	ba b0 47 04 00       	mov    $0x447b0,%edx
   410b5:	be 47 02 00 00       	mov    $0x247,%esi
   410ba:	bf 80 45 04 00       	mov    $0x44580,%edi
   410bf:	e8 63 19 00 00       	call   42a27 <assert_fail>
    current = p;
   410c4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   410c8:	48 89 05 31 0f 01 00 	mov    %rax,0x10f31(%rip)        # 52000 <current>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   410cf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   410d3:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   410da:	48 89 c7             	mov    %rax,%rdi
   410dd:	e8 13 1b 00 00       	call   42bf5 <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   410e2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   410e6:	48 83 c0 08          	add    $0x8,%rax
   410ea:	48 89 c7             	mov    %rax,%rdi
   410ed:	e8 d1 ef ff ff       	call   400c3 <exception_return>

00000000000410f2 <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   410f2:	55                   	push   %rbp
   410f3:	48 89 e5             	mov    %rsp,%rbp
   410f6:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   410fa:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   41101:	00 
   41102:	e9 81 00 00 00       	jmp    41188 <pageinfo_init+0x96>
        int owner;
        if (physical_memory_isreserved(addr)) {
   41107:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4110b:	48 89 c7             	mov    %rax,%rdi
   4110e:	e8 81 0f 00 00       	call   42094 <physical_memory_isreserved>
   41113:	85 c0                	test   %eax,%eax
   41115:	74 09                	je     41120 <pageinfo_init+0x2e>
            owner = PO_RESERVED;
   41117:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   4111e:	eb 2f                	jmp    4114f <pageinfo_init+0x5d>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   41120:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   41127:	00 
   41128:	76 0b                	jbe    41135 <pageinfo_init+0x43>
   4112a:	b8 08 b0 05 00       	mov    $0x5b008,%eax
   4112f:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41133:	72 0a                	jb     4113f <pageinfo_init+0x4d>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   41135:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   4113c:	00 
   4113d:	75 09                	jne    41148 <pageinfo_init+0x56>
            owner = PO_KERNEL;
   4113f:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   41146:	eb 07                	jmp    4114f <pageinfo_init+0x5d>
        } else {
            owner = PO_FREE;
   41148:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   4114f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41153:	48 c1 e8 0c          	shr    $0xc,%rax
   41157:	89 c1                	mov    %eax,%ecx
   41159:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4115c:	89 c2                	mov    %eax,%edx
   4115e:	48 63 c1             	movslq %ecx,%rax
   41161:	88 94 00 40 2e 05 00 	mov    %dl,0x52e40(%rax,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   41168:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   4116c:	0f 95 c2             	setne  %dl
   4116f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41173:	48 c1 e8 0c          	shr    $0xc,%rax
   41177:	48 98                	cltq   
   41179:	88 94 00 41 2e 05 00 	mov    %dl,0x52e41(%rax,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   41180:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41187:	00 
   41188:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   4118f:	00 
   41190:	0f 86 71 ff ff ff    	jbe    41107 <pageinfo_init+0x15>
    }
}
   41196:	90                   	nop
   41197:	90                   	nop
   41198:	c9                   	leave  
   41199:	c3                   	ret    

000000000004119a <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   4119a:	55                   	push   %rbp
   4119b:	48 89 e5             	mov    %rsp,%rbp
   4119e:	48 83 ec 50          	sub    $0x50,%rsp
   411a2:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   411a6:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   411aa:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   411b0:	48 89 c2             	mov    %rax,%rdx
   411b3:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   411b7:	48 39 c2             	cmp    %rax,%rdx
   411ba:	74 14                	je     411d0 <check_page_table_mappings+0x36>
   411bc:	ba d0 47 04 00       	mov    $0x447d0,%edx
   411c1:	be 71 02 00 00       	mov    $0x271,%esi
   411c6:	bf 80 45 04 00       	mov    $0x44580,%edi
   411cb:	e8 57 18 00 00       	call   42a27 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   411d0:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   411d7:	00 
   411d8:	e9 9a 00 00 00       	jmp    41277 <check_page_table_mappings+0xdd>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   411dd:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   411e1:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   411e5:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   411e9:	48 89 ce             	mov    %rcx,%rsi
   411ec:	48 89 c7             	mov    %rax,%rdi
   411ef:	e8 f8 1e 00 00       	call   430ec <virtual_memory_lookup>
        if (vam.pa != va) {
   411f4:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   411f8:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   411fc:	74 27                	je     41225 <check_page_table_mappings+0x8b>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   411fe:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   41202:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41206:	49 89 d0             	mov    %rdx,%r8
   41209:	48 89 c1             	mov    %rax,%rcx
   4120c:	ba ef 47 04 00       	mov    $0x447ef,%edx
   41211:	be 00 c0 00 00       	mov    $0xc000,%esi
   41216:	bf e0 06 00 00       	mov    $0x6e0,%edi
   4121b:	b8 00 00 00 00       	mov    $0x0,%eax
   41220:	e8 94 31 00 00       	call   443b9 <console_printf>
        }
        assert(vam.pa == va);
   41225:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41229:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4122d:	74 14                	je     41243 <check_page_table_mappings+0xa9>
   4122f:	ba f9 47 04 00       	mov    $0x447f9,%edx
   41234:	be 7a 02 00 00       	mov    $0x27a,%esi
   41239:	bf 80 45 04 00       	mov    $0x44580,%edi
   4123e:	e8 e4 17 00 00       	call   42a27 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   41243:	b8 00 60 04 00       	mov    $0x46000,%eax
   41248:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4124c:	72 21                	jb     4126f <check_page_table_mappings+0xd5>
            assert(vam.perm & PTE_W);
   4124e:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41251:	48 98                	cltq   
   41253:	83 e0 02             	and    $0x2,%eax
   41256:	48 85 c0             	test   %rax,%rax
   41259:	75 14                	jne    4126f <check_page_table_mappings+0xd5>
   4125b:	ba 06 48 04 00       	mov    $0x44806,%edx
   41260:	be 7c 02 00 00       	mov    $0x27c,%esi
   41265:	bf 80 45 04 00       	mov    $0x44580,%edi
   4126a:	e8 b8 17 00 00       	call   42a27 <assert_fail>
         va += PAGESIZE) {
   4126f:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41276:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   41277:	b8 08 b0 05 00       	mov    $0x5b008,%eax
   4127c:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41280:	0f 82 57 ff ff ff    	jb     411dd <check_page_table_mappings+0x43>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   41286:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   4128d:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   4128e:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   41292:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   41296:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   4129a:	48 89 ce             	mov    %rcx,%rsi
   4129d:	48 89 c7             	mov    %rax,%rdi
   412a0:	e8 47 1e 00 00       	call   430ec <virtual_memory_lookup>
    assert(vam.pa == kstack);
   412a5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   412a9:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   412ad:	74 14                	je     412c3 <check_page_table_mappings+0x129>
   412af:	ba 17 48 04 00       	mov    $0x44817,%edx
   412b4:	be 83 02 00 00       	mov    $0x283,%esi
   412b9:	bf 80 45 04 00       	mov    $0x44580,%edi
   412be:	e8 64 17 00 00       	call   42a27 <assert_fail>
    assert(vam.perm & PTE_W);
   412c3:	8b 45 e8             	mov    -0x18(%rbp),%eax
   412c6:	48 98                	cltq   
   412c8:	83 e0 02             	and    $0x2,%eax
   412cb:	48 85 c0             	test   %rax,%rax
   412ce:	75 14                	jne    412e4 <check_page_table_mappings+0x14a>
   412d0:	ba 06 48 04 00       	mov    $0x44806,%edx
   412d5:	be 84 02 00 00       	mov    $0x284,%esi
   412da:	bf 80 45 04 00       	mov    $0x44580,%edi
   412df:	e8 43 17 00 00       	call   42a27 <assert_fail>
}
   412e4:	90                   	nop
   412e5:	c9                   	leave  
   412e6:	c3                   	ret    

00000000000412e7 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   412e7:	55                   	push   %rbp
   412e8:	48 89 e5             	mov    %rsp,%rbp
   412eb:	48 83 ec 20          	sub    $0x20,%rsp
   412ef:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   412f3:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   412f6:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   412f9:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   412fc:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   41303:	48 8b 05 f6 3c 01 00 	mov    0x13cf6(%rip),%rax        # 55000 <kernel_pagetable>
   4130a:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   4130e:	75 67                	jne    41377 <check_page_table_ownership+0x90>
        owner = PO_KERNEL;
   41310:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   41317:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   4131e:	eb 51                	jmp    41371 <check_page_table_ownership+0x8a>
            if (processes[xpid].p_state != P_FREE
   41320:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41323:	48 63 d0             	movslq %eax,%rdx
   41326:	48 89 d0             	mov    %rdx,%rax
   41329:	48 c1 e0 03          	shl    $0x3,%rax
   4132d:	48 29 d0             	sub    %rdx,%rax
   41330:	48 c1 e0 05          	shl    $0x5,%rax
   41334:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   4133a:	8b 00                	mov    (%rax),%eax
   4133c:	85 c0                	test   %eax,%eax
   4133e:	74 2d                	je     4136d <check_page_table_ownership+0x86>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   41340:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41343:	48 63 d0             	movslq %eax,%rdx
   41346:	48 89 d0             	mov    %rdx,%rax
   41349:	48 c1 e0 03          	shl    $0x3,%rax
   4134d:	48 29 d0             	sub    %rdx,%rax
   41350:	48 c1 e0 05          	shl    $0x5,%rax
   41354:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   4135a:	48 8b 10             	mov    (%rax),%rdx
   4135d:	48 8b 05 9c 3c 01 00 	mov    0x13c9c(%rip),%rax        # 55000 <kernel_pagetable>
   41364:	48 39 c2             	cmp    %rax,%rdx
   41367:	75 04                	jne    4136d <check_page_table_ownership+0x86>
                ++expected_refcount;
   41369:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   4136d:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41371:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   41375:	7e a9                	jle    41320 <check_page_table_ownership+0x39>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   41377:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   4137a:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4137d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41381:	be 00 00 00 00       	mov    $0x0,%esi
   41386:	48 89 c7             	mov    %rax,%rdi
   41389:	e8 03 00 00 00       	call   41391 <check_page_table_ownership_level>
}
   4138e:	90                   	nop
   4138f:	c9                   	leave  
   41390:	c3                   	ret    

0000000000041391 <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   41391:	55                   	push   %rbp
   41392:	48 89 e5             	mov    %rsp,%rbp
   41395:	48 83 ec 30          	sub    $0x30,%rsp
   41399:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4139d:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   413a0:	89 55 e0             	mov    %edx,-0x20(%rbp)
   413a3:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   413a6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   413aa:	48 c1 e8 0c          	shr    $0xc,%rax
   413ae:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   413b3:	7e 14                	jle    413c9 <check_page_table_ownership_level+0x38>
   413b5:	ba 28 48 04 00       	mov    $0x44828,%edx
   413ba:	be a1 02 00 00       	mov    $0x2a1,%esi
   413bf:	bf 80 45 04 00       	mov    $0x44580,%edi
   413c4:	e8 5e 16 00 00       	call   42a27 <assert_fail>
    if (pageinfo[PAGENUMBER(pt)].owner != owner) {
   413c9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   413cd:	48 c1 e8 0c          	shr    $0xc,%rax
   413d1:	48 98                	cltq   
   413d3:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   413da:	00 
   413db:	0f be c0             	movsbl %al,%eax
   413de:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   413e1:	74 34                	je     41417 <check_page_table_ownership_level+0x86>
	panic("pt addr: %p, supposed owner of pt: %d, actual owner of pt: %d, refcount: %d", pt, owner, pageinfo[PAGENUMBER(pt)].owner,
   413e3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   413e7:	48 c1 e8 0c          	shr    $0xc,%rax
   413eb:	48 98                	cltq   
   413ed:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   413f4:	00 
   413f5:	0f be c8             	movsbl %al,%ecx
   413f8:	8b 75 dc             	mov    -0x24(%rbp),%esi
   413fb:	8b 55 e0             	mov    -0x20(%rbp),%edx
   413fe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41402:	41 89 f0             	mov    %esi,%r8d
   41405:	48 89 c6             	mov    %rax,%rsi
   41408:	bf 40 48 04 00       	mov    $0x44840,%edi
   4140d:	b8 00 00 00 00       	mov    $0x0,%eax
   41412:	e8 30 15 00 00       	call   42947 <panic>
			refcount);
    }
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   41417:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4141b:	48 c1 e8 0c          	shr    $0xc,%rax
   4141f:	48 98                	cltq   
   41421:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   41428:	00 
   41429:	0f be c0             	movsbl %al,%eax
   4142c:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   4142f:	74 14                	je     41445 <check_page_table_ownership_level+0xb4>
   41431:	ba 90 48 04 00       	mov    $0x44890,%edx
   41436:	be a6 02 00 00       	mov    $0x2a6,%esi
   4143b:	bf 80 45 04 00       	mov    $0x44580,%edi
   41440:	e8 e2 15 00 00       	call   42a27 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   41445:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41449:	48 c1 e8 0c          	shr    $0xc,%rax
   4144d:	48 98                	cltq   
   4144f:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   41456:	00 
   41457:	0f be c0             	movsbl %al,%eax
   4145a:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   4145d:	74 14                	je     41473 <check_page_table_ownership_level+0xe2>
   4145f:	ba b8 48 04 00       	mov    $0x448b8,%edx
   41464:	be a7 02 00 00       	mov    $0x2a7,%esi
   41469:	bf 80 45 04 00       	mov    $0x44580,%edi
   4146e:	e8 b4 15 00 00       	call   42a27 <assert_fail>
    if (level < 3) {
   41473:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   41477:	7f 5b                	jg     414d4 <check_page_table_ownership_level+0x143>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   41479:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41480:	eb 49                	jmp    414cb <check_page_table_ownership_level+0x13a>
            if (pt->entry[index]) {
   41482:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41486:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41489:	48 63 d2             	movslq %edx,%rdx
   4148c:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41490:	48 85 c0             	test   %rax,%rax
   41493:	74 32                	je     414c7 <check_page_table_ownership_level+0x136>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   41495:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41499:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4149c:	48 63 d2             	movslq %edx,%rdx
   4149f:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   414a3:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   414a9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   414ad:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   414b0:	8d 70 01             	lea    0x1(%rax),%esi
   414b3:	8b 55 e0             	mov    -0x20(%rbp),%edx
   414b6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   414ba:	b9 01 00 00 00       	mov    $0x1,%ecx
   414bf:	48 89 c7             	mov    %rax,%rdi
   414c2:	e8 ca fe ff ff       	call   41391 <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   414c7:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   414cb:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   414d2:	7e ae                	jle    41482 <check_page_table_ownership_level+0xf1>
            }
        }
    }
}
   414d4:	90                   	nop
   414d5:	c9                   	leave  
   414d6:	c3                   	ret    

00000000000414d7 <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   414d7:	55                   	push   %rbp
   414d8:	48 89 e5             	mov    %rsp,%rbp
   414db:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   414df:	8b 05 03 0c 01 00    	mov    0x10c03(%rip),%eax        # 520e8 <processes+0xc8>
   414e5:	85 c0                	test   %eax,%eax
   414e7:	74 14                	je     414fd <check_virtual_memory+0x26>
   414e9:	ba e8 48 04 00       	mov    $0x448e8,%edx
   414ee:	be ba 02 00 00       	mov    $0x2ba,%esi
   414f3:	bf 80 45 04 00       	mov    $0x44580,%edi
   414f8:	e8 2a 15 00 00       	call   42a27 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   414fd:	48 8b 05 fc 3a 01 00 	mov    0x13afc(%rip),%rax        # 55000 <kernel_pagetable>
   41504:	48 89 c7             	mov    %rax,%rdi
   41507:	e8 8e fc ff ff       	call   4119a <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   4150c:	48 8b 05 ed 3a 01 00 	mov    0x13aed(%rip),%rax        # 55000 <kernel_pagetable>
   41513:	be ff ff ff ff       	mov    $0xffffffff,%esi
   41518:	48 89 c7             	mov    %rax,%rdi
   4151b:	e8 c7 fd ff ff       	call   412e7 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   41520:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41527:	e9 9c 00 00 00       	jmp    415c8 <check_virtual_memory+0xf1>
        if (processes[pid].p_state != P_FREE
   4152c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4152f:	48 63 d0             	movslq %eax,%rdx
   41532:	48 89 d0             	mov    %rdx,%rax
   41535:	48 c1 e0 03          	shl    $0x3,%rax
   41539:	48 29 d0             	sub    %rdx,%rax
   4153c:	48 c1 e0 05          	shl    $0x5,%rax
   41540:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   41546:	8b 00                	mov    (%rax),%eax
   41548:	85 c0                	test   %eax,%eax
   4154a:	74 78                	je     415c4 <check_virtual_memory+0xed>
            && processes[pid].p_pagetable != kernel_pagetable) {
   4154c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4154f:	48 63 d0             	movslq %eax,%rdx
   41552:	48 89 d0             	mov    %rdx,%rax
   41555:	48 c1 e0 03          	shl    $0x3,%rax
   41559:	48 29 d0             	sub    %rdx,%rax
   4155c:	48 c1 e0 05          	shl    $0x5,%rax
   41560:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   41566:	48 8b 10             	mov    (%rax),%rdx
   41569:	48 8b 05 90 3a 01 00 	mov    0x13a90(%rip),%rax        # 55000 <kernel_pagetable>
   41570:	48 39 c2             	cmp    %rax,%rdx
   41573:	74 4f                	je     415c4 <check_virtual_memory+0xed>
            check_page_table_mappings(processes[pid].p_pagetable);
   41575:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41578:	48 63 d0             	movslq %eax,%rdx
   4157b:	48 89 d0             	mov    %rdx,%rax
   4157e:	48 c1 e0 03          	shl    $0x3,%rax
   41582:	48 29 d0             	sub    %rdx,%rax
   41585:	48 c1 e0 05          	shl    $0x5,%rax
   41589:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   4158f:	48 8b 00             	mov    (%rax),%rax
   41592:	48 89 c7             	mov    %rax,%rdi
   41595:	e8 00 fc ff ff       	call   4119a <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   4159a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4159d:	48 63 d0             	movslq %eax,%rdx
   415a0:	48 89 d0             	mov    %rdx,%rax
   415a3:	48 c1 e0 03          	shl    $0x3,%rax
   415a7:	48 29 d0             	sub    %rdx,%rax
   415aa:	48 c1 e0 05          	shl    $0x5,%rax
   415ae:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   415b4:	48 8b 00             	mov    (%rax),%rax
   415b7:	8b 55 fc             	mov    -0x4(%rbp),%edx
   415ba:	89 d6                	mov    %edx,%esi
   415bc:	48 89 c7             	mov    %rax,%rdi
   415bf:	e8 23 fd ff ff       	call   412e7 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   415c4:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   415c8:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   415cc:	0f 8e 5a ff ff ff    	jle    4152c <check_virtual_memory+0x55>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   415d2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   415d9:	eb 67                	jmp    41642 <check_virtual_memory+0x16b>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   415db:	8b 45 f8             	mov    -0x8(%rbp),%eax
   415de:	48 98                	cltq   
   415e0:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   415e7:	00 
   415e8:	84 c0                	test   %al,%al
   415ea:	7e 52                	jle    4163e <check_virtual_memory+0x167>
   415ec:	8b 45 f8             	mov    -0x8(%rbp),%eax
   415ef:	48 98                	cltq   
   415f1:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   415f8:	00 
   415f9:	84 c0                	test   %al,%al
   415fb:	78 41                	js     4163e <check_virtual_memory+0x167>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   415fd:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41600:	48 98                	cltq   
   41602:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   41609:	00 
   4160a:	0f be c0             	movsbl %al,%eax
   4160d:	48 63 d0             	movslq %eax,%rdx
   41610:	48 89 d0             	mov    %rdx,%rax
   41613:	48 c1 e0 03          	shl    $0x3,%rax
   41617:	48 29 d0             	sub    %rdx,%rax
   4161a:	48 c1 e0 05          	shl    $0x5,%rax
   4161e:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   41624:	8b 00                	mov    (%rax),%eax
   41626:	85 c0                	test   %eax,%eax
   41628:	75 14                	jne    4163e <check_virtual_memory+0x167>
   4162a:	ba 08 49 04 00       	mov    $0x44908,%edx
   4162f:	be d1 02 00 00       	mov    $0x2d1,%esi
   41634:	bf 80 45 04 00       	mov    $0x44580,%edi
   41639:	e8 e9 13 00 00       	call   42a27 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4163e:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41642:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   41649:	7e 90                	jle    415db <check_virtual_memory+0x104>
        }
    }
}
   4164b:	90                   	nop
   4164c:	90                   	nop
   4164d:	c9                   	leave  
   4164e:	c3                   	ret    

000000000004164f <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   4164f:	55                   	push   %rbp
   41650:	48 89 e5             	mov    %rsp,%rbp
   41653:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   41657:	ba 66 49 04 00       	mov    $0x44966,%edx
   4165c:	be 00 0f 00 00       	mov    $0xf00,%esi
   41661:	bf 20 00 00 00       	mov    $0x20,%edi
   41666:	b8 00 00 00 00       	mov    $0x0,%eax
   4166b:	e8 49 2d 00 00       	call   443b9 <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41670:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41677:	e9 f8 00 00 00       	jmp    41774 <memshow_physical+0x125>
        if (pn % 64 == 0) {
   4167c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4167f:	83 e0 3f             	and    $0x3f,%eax
   41682:	85 c0                	test   %eax,%eax
   41684:	75 3c                	jne    416c2 <memshow_physical+0x73>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   41686:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41689:	c1 e0 0c             	shl    $0xc,%eax
   4168c:	89 c1                	mov    %eax,%ecx
   4168e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41691:	8d 50 3f             	lea    0x3f(%rax),%edx
   41694:	85 c0                	test   %eax,%eax
   41696:	0f 48 c2             	cmovs  %edx,%eax
   41699:	c1 f8 06             	sar    $0x6,%eax
   4169c:	8d 50 01             	lea    0x1(%rax),%edx
   4169f:	89 d0                	mov    %edx,%eax
   416a1:	c1 e0 02             	shl    $0x2,%eax
   416a4:	01 d0                	add    %edx,%eax
   416a6:	c1 e0 04             	shl    $0x4,%eax
   416a9:	83 c0 03             	add    $0x3,%eax
   416ac:	ba 76 49 04 00       	mov    $0x44976,%edx
   416b1:	be 00 0f 00 00       	mov    $0xf00,%esi
   416b6:	89 c7                	mov    %eax,%edi
   416b8:	b8 00 00 00 00       	mov    $0x0,%eax
   416bd:	e8 f7 2c 00 00       	call   443b9 <console_printf>
        }

        int owner = pageinfo[pn].owner;
   416c2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   416c5:	48 98                	cltq   
   416c7:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   416ce:	00 
   416cf:	0f be c0             	movsbl %al,%eax
   416d2:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   416d5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   416d8:	48 98                	cltq   
   416da:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   416e1:	00 
   416e2:	84 c0                	test   %al,%al
   416e4:	75 07                	jne    416ed <memshow_physical+0x9e>
            owner = PO_FREE;
   416e6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   416ed:	8b 45 f8             	mov    -0x8(%rbp),%eax
   416f0:	83 c0 02             	add    $0x2,%eax
   416f3:	48 98                	cltq   
   416f5:	0f b7 84 00 40 49 04 	movzwl 0x44940(%rax,%rax,1),%eax
   416fc:	00 
   416fd:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   41701:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41704:	48 98                	cltq   
   41706:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   4170d:	00 
   4170e:	3c 01                	cmp    $0x1,%al
   41710:	7e 1a                	jle    4172c <memshow_physical+0xdd>
   41712:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   41717:	48 c1 e8 0c          	shr    $0xc,%rax
   4171b:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   4171e:	74 0c                	je     4172c <memshow_physical+0xdd>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   41720:	b8 53 00 00 00       	mov    $0x53,%eax
   41725:	80 cc 0f             	or     $0xf,%ah
   41728:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   4172c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4172f:	8d 50 3f             	lea    0x3f(%rax),%edx
   41732:	85 c0                	test   %eax,%eax
   41734:	0f 48 c2             	cmovs  %edx,%eax
   41737:	c1 f8 06             	sar    $0x6,%eax
   4173a:	8d 50 01             	lea    0x1(%rax),%edx
   4173d:	89 d0                	mov    %edx,%eax
   4173f:	c1 e0 02             	shl    $0x2,%eax
   41742:	01 d0                	add    %edx,%eax
   41744:	c1 e0 04             	shl    $0x4,%eax
   41747:	89 c1                	mov    %eax,%ecx
   41749:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4174c:	89 d0                	mov    %edx,%eax
   4174e:	c1 f8 1f             	sar    $0x1f,%eax
   41751:	c1 e8 1a             	shr    $0x1a,%eax
   41754:	01 c2                	add    %eax,%edx
   41756:	83 e2 3f             	and    $0x3f,%edx
   41759:	29 c2                	sub    %eax,%edx
   4175b:	89 d0                	mov    %edx,%eax
   4175d:	83 c0 0c             	add    $0xc,%eax
   41760:	01 c8                	add    %ecx,%eax
   41762:	48 98                	cltq   
   41764:	0f b7 55 f6          	movzwl -0xa(%rbp),%edx
   41768:	66 89 94 00 00 80 0b 	mov    %dx,0xb8000(%rax,%rax,1)
   4176f:	00 
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41770:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41774:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   4177b:	0f 8e fb fe ff ff    	jle    4167c <memshow_physical+0x2d>
    }
}
   41781:	90                   	nop
   41782:	90                   	nop
   41783:	c9                   	leave  
   41784:	c3                   	ret    

0000000000041785 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   41785:	55                   	push   %rbp
   41786:	48 89 e5             	mov    %rsp,%rbp
   41789:	48 83 ec 40          	sub    $0x40,%rsp
   4178d:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   41791:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   41795:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41799:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4179f:	48 89 c2             	mov    %rax,%rdx
   417a2:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   417a6:	48 39 c2             	cmp    %rax,%rdx
   417a9:	74 14                	je     417bf <memshow_virtual+0x3a>
   417ab:	ba 80 49 04 00       	mov    $0x44980,%edx
   417b0:	be 02 03 00 00       	mov    $0x302,%esi
   417b5:	bf 80 45 04 00       	mov    $0x44580,%edi
   417ba:	e8 68 12 00 00       	call   42a27 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   417bf:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   417c3:	48 89 c1             	mov    %rax,%rcx
   417c6:	ba ad 49 04 00       	mov    $0x449ad,%edx
   417cb:	be 00 0f 00 00       	mov    $0xf00,%esi
   417d0:	bf 3a 03 00 00       	mov    $0x33a,%edi
   417d5:	b8 00 00 00 00       	mov    $0x0,%eax
   417da:	e8 da 2b 00 00       	call   443b9 <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   417df:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   417e6:	00 
   417e7:	e9 80 01 00 00       	jmp    4196c <memshow_virtual+0x1e7>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   417ec:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   417f0:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   417f4:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   417f8:	48 89 ce             	mov    %rcx,%rsi
   417fb:	48 89 c7             	mov    %rax,%rdi
   417fe:	e8 e9 18 00 00       	call   430ec <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   41803:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41806:	85 c0                	test   %eax,%eax
   41808:	79 0b                	jns    41815 <memshow_virtual+0x90>
            color = ' ';
   4180a:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   41810:	e9 d7 00 00 00       	jmp    418ec <memshow_virtual+0x167>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   41815:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41819:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   4181f:	76 14                	jbe    41835 <memshow_virtual+0xb0>
   41821:	ba ca 49 04 00       	mov    $0x449ca,%edx
   41826:	be 0b 03 00 00       	mov    $0x30b,%esi
   4182b:	bf 80 45 04 00       	mov    $0x44580,%edi
   41830:	e8 f2 11 00 00       	call   42a27 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   41835:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41838:	48 98                	cltq   
   4183a:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   41841:	00 
   41842:	0f be c0             	movsbl %al,%eax
   41845:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   41848:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4184b:	48 98                	cltq   
   4184d:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   41854:	00 
   41855:	84 c0                	test   %al,%al
   41857:	75 07                	jne    41860 <memshow_virtual+0xdb>
                owner = PO_FREE;
   41859:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   41860:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41863:	83 c0 02             	add    $0x2,%eax
   41866:	48 98                	cltq   
   41868:	0f b7 84 00 40 49 04 	movzwl 0x44940(%rax,%rax,1),%eax
   4186f:	00 
   41870:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   41874:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41877:	48 98                	cltq   
   41879:	83 e0 04             	and    $0x4,%eax
   4187c:	48 85 c0             	test   %rax,%rax
   4187f:	74 27                	je     418a8 <memshow_virtual+0x123>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41881:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41885:	c1 e0 04             	shl    $0x4,%eax
   41888:	66 25 00 f0          	and    $0xf000,%ax
   4188c:	89 c2                	mov    %eax,%edx
   4188e:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41892:	c1 f8 04             	sar    $0x4,%eax
   41895:	66 25 00 0f          	and    $0xf00,%ax
   41899:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   4189b:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4189f:	0f b6 c0             	movzbl %al,%eax
   418a2:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   418a4:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   418a8:	8b 45 d0             	mov    -0x30(%rbp),%eax
   418ab:	48 98                	cltq   
   418ad:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   418b4:	00 
   418b5:	3c 01                	cmp    $0x1,%al
   418b7:	7e 33                	jle    418ec <memshow_virtual+0x167>
   418b9:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   418be:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   418c2:	74 28                	je     418ec <memshow_virtual+0x167>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   418c4:	b8 53 00 00 00       	mov    $0x53,%eax
   418c9:	89 c2                	mov    %eax,%edx
   418cb:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   418cf:	66 25 00 f0          	and    $0xf000,%ax
   418d3:	09 d0                	or     %edx,%eax
   418d5:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   418d9:	8b 45 e0             	mov    -0x20(%rbp),%eax
   418dc:	48 98                	cltq   
   418de:	83 e0 04             	and    $0x4,%eax
   418e1:	48 85 c0             	test   %rax,%rax
   418e4:	75 06                	jne    418ec <memshow_virtual+0x167>
                    color = color | 0x0F00;
   418e6:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   418ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   418f0:	48 c1 e8 0c          	shr    $0xc,%rax
   418f4:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   418f7:	8b 45 ec             	mov    -0x14(%rbp),%eax
   418fa:	83 e0 3f             	and    $0x3f,%eax
   418fd:	85 c0                	test   %eax,%eax
   418ff:	75 34                	jne    41935 <memshow_virtual+0x1b0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   41901:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41904:	c1 e8 06             	shr    $0x6,%eax
   41907:	89 c2                	mov    %eax,%edx
   41909:	89 d0                	mov    %edx,%eax
   4190b:	c1 e0 02             	shl    $0x2,%eax
   4190e:	01 d0                	add    %edx,%eax
   41910:	c1 e0 04             	shl    $0x4,%eax
   41913:	05 73 03 00 00       	add    $0x373,%eax
   41918:	89 c7                	mov    %eax,%edi
   4191a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4191e:	48 89 c1             	mov    %rax,%rcx
   41921:	ba 76 49 04 00       	mov    $0x44976,%edx
   41926:	be 00 0f 00 00       	mov    $0xf00,%esi
   4192b:	b8 00 00 00 00       	mov    $0x0,%eax
   41930:	e8 84 2a 00 00       	call   443b9 <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   41935:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41938:	c1 e8 06             	shr    $0x6,%eax
   4193b:	89 c2                	mov    %eax,%edx
   4193d:	89 d0                	mov    %edx,%eax
   4193f:	c1 e0 02             	shl    $0x2,%eax
   41942:	01 d0                	add    %edx,%eax
   41944:	c1 e0 04             	shl    $0x4,%eax
   41947:	89 c2                	mov    %eax,%edx
   41949:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4194c:	83 e0 3f             	and    $0x3f,%eax
   4194f:	01 d0                	add    %edx,%eax
   41951:	05 7c 03 00 00       	add    $0x37c,%eax
   41956:	89 c2                	mov    %eax,%edx
   41958:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4195c:	66 89 84 12 00 80 0b 	mov    %ax,0xb8000(%rdx,%rdx,1)
   41963:	00 
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41964:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4196b:	00 
   4196c:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   41973:	00 
   41974:	0f 86 72 fe ff ff    	jbe    417ec <memshow_virtual+0x67>
    }
}
   4197a:	90                   	nop
   4197b:	90                   	nop
   4197c:	c9                   	leave  
   4197d:	c3                   	ret    

000000000004197e <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   4197e:	55                   	push   %rbp
   4197f:	48 89 e5             	mov    %rsp,%rbp
   41982:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   41986:	8b 05 b4 18 01 00    	mov    0x118b4(%rip),%eax        # 53240 <last_ticks.1>
   4198c:	85 c0                	test   %eax,%eax
   4198e:	74 13                	je     419a3 <memshow_virtual_animate+0x25>
   41990:	8b 15 8a 14 01 00    	mov    0x1148a(%rip),%edx        # 52e20 <ticks>
   41996:	8b 05 a4 18 01 00    	mov    0x118a4(%rip),%eax        # 53240 <last_ticks.1>
   4199c:	29 c2                	sub    %eax,%edx
   4199e:	83 fa 31             	cmp    $0x31,%edx
   419a1:	76 2c                	jbe    419cf <memshow_virtual_animate+0x51>
        last_ticks = ticks;
   419a3:	8b 05 77 14 01 00    	mov    0x11477(%rip),%eax        # 52e20 <ticks>
   419a9:	89 05 91 18 01 00    	mov    %eax,0x11891(%rip)        # 53240 <last_ticks.1>
        ++showing;
   419af:	8b 05 4f 46 00 00    	mov    0x464f(%rip),%eax        # 46004 <showing.0>
   419b5:	83 c0 01             	add    $0x1,%eax
   419b8:	89 05 46 46 00 00    	mov    %eax,0x4646(%rip)        # 46004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   419be:	eb 0f                	jmp    419cf <memshow_virtual_animate+0x51>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
        ++showing;
   419c0:	8b 05 3e 46 00 00    	mov    0x463e(%rip),%eax        # 46004 <showing.0>
   419c6:	83 c0 01             	add    $0x1,%eax
   419c9:	89 05 35 46 00 00    	mov    %eax,0x4635(%rip)        # 46004 <showing.0>
    while (showing <= 2*NPROC
   419cf:	8b 05 2f 46 00 00    	mov    0x462f(%rip),%eax        # 46004 <showing.0>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
   419d5:	83 f8 20             	cmp    $0x20,%eax
   419d8:	7f 6d                	jg     41a47 <memshow_virtual_animate+0xc9>
   419da:	8b 15 24 46 00 00    	mov    0x4624(%rip),%edx        # 46004 <showing.0>
   419e0:	89 d0                	mov    %edx,%eax
   419e2:	c1 f8 1f             	sar    $0x1f,%eax
   419e5:	c1 e8 1c             	shr    $0x1c,%eax
   419e8:	01 c2                	add    %eax,%edx
   419ea:	83 e2 0f             	and    $0xf,%edx
   419ed:	29 c2                	sub    %eax,%edx
   419ef:	89 d0                	mov    %edx,%eax
   419f1:	48 63 d0             	movslq %eax,%rdx
   419f4:	48 89 d0             	mov    %rdx,%rax
   419f7:	48 c1 e0 03          	shl    $0x3,%rax
   419fb:	48 29 d0             	sub    %rdx,%rax
   419fe:	48 c1 e0 05          	shl    $0x5,%rax
   41a02:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   41a08:	8b 00                	mov    (%rax),%eax
   41a0a:	85 c0                	test   %eax,%eax
   41a0c:	74 b2                	je     419c0 <memshow_virtual_animate+0x42>
   41a0e:	8b 15 f0 45 00 00    	mov    0x45f0(%rip),%edx        # 46004 <showing.0>
   41a14:	89 d0                	mov    %edx,%eax
   41a16:	c1 f8 1f             	sar    $0x1f,%eax
   41a19:	c1 e8 1c             	shr    $0x1c,%eax
   41a1c:	01 c2                	add    %eax,%edx
   41a1e:	83 e2 0f             	and    $0xf,%edx
   41a21:	29 c2                	sub    %eax,%edx
   41a23:	89 d0                	mov    %edx,%eax
   41a25:	48 63 d0             	movslq %eax,%rdx
   41a28:	48 89 d0             	mov    %rdx,%rax
   41a2b:	48 c1 e0 03          	shl    $0x3,%rax
   41a2f:	48 29 d0             	sub    %rdx,%rax
   41a32:	48 c1 e0 05          	shl    $0x5,%rax
   41a36:	48 05 f8 20 05 00    	add    $0x520f8,%rax
   41a3c:	0f b6 00             	movzbl (%rax),%eax
   41a3f:	84 c0                	test   %al,%al
   41a41:	0f 84 79 ff ff ff    	je     419c0 <memshow_virtual_animate+0x42>
    }
    showing = showing % NPROC;
   41a47:	8b 15 b7 45 00 00    	mov    0x45b7(%rip),%edx        # 46004 <showing.0>
   41a4d:	89 d0                	mov    %edx,%eax
   41a4f:	c1 f8 1f             	sar    $0x1f,%eax
   41a52:	c1 e8 1c             	shr    $0x1c,%eax
   41a55:	01 c2                	add    %eax,%edx
   41a57:	83 e2 0f             	and    $0xf,%edx
   41a5a:	29 c2                	sub    %eax,%edx
   41a5c:	89 d0                	mov    %edx,%eax
   41a5e:	89 05 a0 45 00 00    	mov    %eax,0x45a0(%rip)        # 46004 <showing.0>

    if (processes[showing].p_state != P_FREE) {
   41a64:	8b 05 9a 45 00 00    	mov    0x459a(%rip),%eax        # 46004 <showing.0>
   41a6a:	48 63 d0             	movslq %eax,%rdx
   41a6d:	48 89 d0             	mov    %rdx,%rax
   41a70:	48 c1 e0 03          	shl    $0x3,%rax
   41a74:	48 29 d0             	sub    %rdx,%rax
   41a77:	48 c1 e0 05          	shl    $0x5,%rax
   41a7b:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   41a81:	8b 00                	mov    (%rax),%eax
   41a83:	85 c0                	test   %eax,%eax
   41a85:	74 52                	je     41ad9 <memshow_virtual_animate+0x15b>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   41a87:	8b 15 77 45 00 00    	mov    0x4577(%rip),%edx        # 46004 <showing.0>
   41a8d:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   41a91:	89 d1                	mov    %edx,%ecx
   41a93:	ba e4 49 04 00       	mov    $0x449e4,%edx
   41a98:	be 04 00 00 00       	mov    $0x4,%esi
   41a9d:	48 89 c7             	mov    %rax,%rdi
   41aa0:	b8 00 00 00 00       	mov    $0x0,%eax
   41aa5:	e8 1b 2a 00 00       	call   444c5 <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   41aaa:	8b 05 54 45 00 00    	mov    0x4554(%rip),%eax        # 46004 <showing.0>
   41ab0:	48 63 d0             	movslq %eax,%rdx
   41ab3:	48 89 d0             	mov    %rdx,%rax
   41ab6:	48 c1 e0 03          	shl    $0x3,%rax
   41aba:	48 29 d0             	sub    %rdx,%rax
   41abd:	48 c1 e0 05          	shl    $0x5,%rax
   41ac1:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   41ac7:	48 8b 00             	mov    (%rax),%rax
   41aca:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   41ace:	48 89 d6             	mov    %rdx,%rsi
   41ad1:	48 89 c7             	mov    %rax,%rdi
   41ad4:	e8 ac fc ff ff       	call   41785 <memshow_virtual>
    }
}
   41ad9:	90                   	nop
   41ada:	c9                   	leave  
   41adb:	c3                   	ret    

0000000000041adc <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   41adc:	55                   	push   %rbp
   41add:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   41ae0:	e8 4f 01 00 00       	call   41c34 <segments_init>
    interrupt_init();
   41ae5:	e8 d0 03 00 00       	call   41eba <interrupt_init>
    virtual_memory_init();
   41aea:	e8 f3 0f 00 00       	call   42ae2 <virtual_memory_init>
}
   41aef:	90                   	nop
   41af0:	5d                   	pop    %rbp
   41af1:	c3                   	ret    

0000000000041af2 <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   41af2:	55                   	push   %rbp
   41af3:	48 89 e5             	mov    %rsp,%rbp
   41af6:	48 83 ec 18          	sub    $0x18,%rsp
   41afa:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41afe:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41b02:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   41b05:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41b08:	48 98                	cltq   
   41b0a:	48 c1 e0 2d          	shl    $0x2d,%rax
   41b0e:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   41b12:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   41b19:	90 00 00 
   41b1c:	48 09 c2             	or     %rax,%rdx
    *segment = type
   41b1f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41b23:	48 89 10             	mov    %rdx,(%rax)
}
   41b26:	90                   	nop
   41b27:	c9                   	leave  
   41b28:	c3                   	ret    

0000000000041b29 <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   41b29:	55                   	push   %rbp
   41b2a:	48 89 e5             	mov    %rsp,%rbp
   41b2d:	48 83 ec 28          	sub    $0x28,%rsp
   41b31:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41b35:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41b39:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41b3c:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   41b40:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41b44:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41b48:	48 c1 e0 10          	shl    $0x10,%rax
   41b4c:	48 89 c2             	mov    %rax,%rdx
   41b4f:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   41b56:	00 00 00 
   41b59:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   41b5c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41b60:	48 c1 e0 20          	shl    $0x20,%rax
   41b64:	48 89 c1             	mov    %rax,%rcx
   41b67:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   41b6e:	00 00 ff 
   41b71:	48 21 c8             	and    %rcx,%rax
   41b74:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   41b77:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41b7b:	48 83 e8 01          	sub    $0x1,%rax
   41b7f:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   41b82:	48 09 d0             	or     %rdx,%rax
        | type
   41b85:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   41b89:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41b8c:	48 63 d2             	movslq %edx,%rdx
   41b8f:	48 c1 e2 2d          	shl    $0x2d,%rdx
   41b93:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   41b96:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   41b9d:	80 00 00 
   41ba0:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41ba3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ba7:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   41baa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41bae:	48 83 c0 08          	add    $0x8,%rax
   41bb2:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   41bb6:	48 c1 ea 20          	shr    $0x20,%rdx
   41bba:	48 89 10             	mov    %rdx,(%rax)
}
   41bbd:	90                   	nop
   41bbe:	c9                   	leave  
   41bbf:	c3                   	ret    

0000000000041bc0 <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   41bc0:	55                   	push   %rbp
   41bc1:	48 89 e5             	mov    %rsp,%rbp
   41bc4:	48 83 ec 20          	sub    $0x20,%rsp
   41bc8:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41bcc:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41bd0:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41bd3:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41bd7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41bdb:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   41bde:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   41be2:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41be5:	48 63 d2             	movslq %edx,%rdx
   41be8:	48 c1 e2 2d          	shl    $0x2d,%rdx
   41bec:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   41bef:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41bf3:	48 c1 e0 20          	shl    $0x20,%rax
   41bf7:	48 89 c1             	mov    %rax,%rcx
   41bfa:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   41c01:	00 ff ff 
   41c04:	48 21 c8             	and    %rcx,%rax
   41c07:	48 09 c2             	or     %rax,%rdx
   41c0a:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   41c11:	80 00 00 
   41c14:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41c17:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41c1b:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   41c1e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41c22:	48 c1 e8 20          	shr    $0x20,%rax
   41c26:	48 89 c2             	mov    %rax,%rdx
   41c29:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41c2d:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   41c31:	90                   	nop
   41c32:	c9                   	leave  
   41c33:	c3                   	ret    

0000000000041c34 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   41c34:	55                   	push   %rbp
   41c35:	48 89 e5             	mov    %rsp,%rbp
   41c38:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   41c3c:	48 c7 05 19 16 01 00 	movq   $0x0,0x11619(%rip)        # 53260 <segments>
   41c43:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   41c47:	ba 00 00 00 00       	mov    $0x0,%edx
   41c4c:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41c53:	08 20 00 
   41c56:	48 89 c6             	mov    %rax,%rsi
   41c59:	bf 68 32 05 00       	mov    $0x53268,%edi
   41c5e:	e8 8f fe ff ff       	call   41af2 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   41c63:	ba 03 00 00 00       	mov    $0x3,%edx
   41c68:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41c6f:	08 20 00 
   41c72:	48 89 c6             	mov    %rax,%rsi
   41c75:	bf 70 32 05 00       	mov    $0x53270,%edi
   41c7a:	e8 73 fe ff ff       	call   41af2 <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   41c7f:	ba 00 00 00 00       	mov    $0x0,%edx
   41c84:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41c8b:	02 00 00 
   41c8e:	48 89 c6             	mov    %rax,%rsi
   41c91:	bf 78 32 05 00       	mov    $0x53278,%edi
   41c96:	e8 57 fe ff ff       	call   41af2 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   41c9b:	ba 03 00 00 00       	mov    $0x3,%edx
   41ca0:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41ca7:	02 00 00 
   41caa:	48 89 c6             	mov    %rax,%rsi
   41cad:	bf 80 32 05 00       	mov    $0x53280,%edi
   41cb2:	e8 3b fe ff ff       	call   41af2 <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   41cb7:	b8 a0 42 05 00       	mov    $0x542a0,%eax
   41cbc:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   41cc2:	48 89 c1             	mov    %rax,%rcx
   41cc5:	ba 00 00 00 00       	mov    $0x0,%edx
   41cca:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   41cd1:	09 00 00 
   41cd4:	48 89 c6             	mov    %rax,%rsi
   41cd7:	bf 88 32 05 00       	mov    $0x53288,%edi
   41cdc:	e8 48 fe ff ff       	call   41b29 <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   41ce1:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   41ce7:	b8 60 32 05 00       	mov    $0x53260,%eax
   41cec:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   41cf0:	ba 60 00 00 00       	mov    $0x60,%edx
   41cf5:	be 00 00 00 00       	mov    $0x0,%esi
   41cfa:	bf a0 42 05 00       	mov    $0x542a0,%edi
   41cff:	e8 fe 18 00 00       	call   43602 <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   41d04:	48 c7 05 95 25 01 00 	movq   $0x80000,0x12595(%rip)        # 542a4 <kernel_task_descriptor+0x4>
   41d0b:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   41d0f:	ba 00 10 00 00       	mov    $0x1000,%edx
   41d14:	be 00 00 00 00       	mov    $0x0,%esi
   41d19:	bf a0 32 05 00       	mov    $0x532a0,%edi
   41d1e:	e8 df 18 00 00       	call   43602 <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41d23:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   41d2a:	eb 30                	jmp    41d5c <segments_init+0x128>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   41d2c:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   41d31:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41d34:	48 c1 e0 04          	shl    $0x4,%rax
   41d38:	48 05 a0 32 05 00    	add    $0x532a0,%rax
   41d3e:	48 89 d1             	mov    %rdx,%rcx
   41d41:	ba 00 00 00 00       	mov    $0x0,%edx
   41d46:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41d4d:	0e 00 00 
   41d50:	48 89 c7             	mov    %rax,%rdi
   41d53:	e8 68 fe ff ff       	call   41bc0 <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41d58:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41d5c:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   41d63:	76 c7                	jbe    41d2c <segments_init+0xf8>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   41d65:	b8 36 00 04 00       	mov    $0x40036,%eax
   41d6a:	48 89 c1             	mov    %rax,%rcx
   41d6d:	ba 00 00 00 00       	mov    $0x0,%edx
   41d72:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41d79:	0e 00 00 
   41d7c:	48 89 c6             	mov    %rax,%rsi
   41d7f:	bf a0 34 05 00       	mov    $0x534a0,%edi
   41d84:	e8 37 fe ff ff       	call   41bc0 <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   41d89:	b8 2e 00 04 00       	mov    $0x4002e,%eax
   41d8e:	48 89 c1             	mov    %rax,%rcx
   41d91:	ba 00 00 00 00       	mov    $0x0,%edx
   41d96:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41d9d:	0e 00 00 
   41da0:	48 89 c6             	mov    %rax,%rsi
   41da3:	bf 70 33 05 00       	mov    $0x53370,%edi
   41da8:	e8 13 fe ff ff       	call   41bc0 <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   41dad:	b8 32 00 04 00       	mov    $0x40032,%eax
   41db2:	48 89 c1             	mov    %rax,%rcx
   41db5:	ba 00 00 00 00       	mov    $0x0,%edx
   41dba:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41dc1:	0e 00 00 
   41dc4:	48 89 c6             	mov    %rax,%rsi
   41dc7:	bf 80 33 05 00       	mov    $0x53380,%edi
   41dcc:	e8 ef fd ff ff       	call   41bc0 <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41dd1:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   41dd8:	eb 3e                	jmp    41e18 <segments_init+0x1e4>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   41dda:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41ddd:	83 e8 30             	sub    $0x30,%eax
   41de0:	89 c0                	mov    %eax,%eax
   41de2:	48 8b 04 c5 e7 00 04 	mov    0x400e7(,%rax,8),%rax
   41de9:	00 
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   41dea:	48 89 c2             	mov    %rax,%rdx
   41ded:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41df0:	48 c1 e0 04          	shl    $0x4,%rax
   41df4:	48 05 a0 32 05 00    	add    $0x532a0,%rax
   41dfa:	48 89 d1             	mov    %rdx,%rcx
   41dfd:	ba 03 00 00 00       	mov    $0x3,%edx
   41e02:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41e09:	0e 00 00 
   41e0c:	48 89 c7             	mov    %rax,%rdi
   41e0f:	e8 ac fd ff ff       	call   41bc0 <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41e14:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41e18:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   41e1c:	76 bc                	jbe    41dda <segments_init+0x1a6>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   41e1e:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   41e24:	b8 a0 32 05 00       	mov    $0x532a0,%eax
   41e29:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   41e2d:	b8 28 00 00 00       	mov    $0x28,%eax
   41e32:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   41e36:	0f 00 d8             	ltr    %ax
   41e39:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   41e3d:	0f 20 c0             	mov    %cr0,%rax
   41e40:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   41e44:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   41e48:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   41e4b:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   41e52:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41e55:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   41e58:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41e5b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   41e5f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41e63:	0f 22 c0             	mov    %rax,%cr0
}
   41e66:	90                   	nop
    lcr0(cr0);
}
   41e67:	90                   	nop
   41e68:	c9                   	leave  
   41e69:	c3                   	ret    

0000000000041e6a <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   41e6a:	55                   	push   %rbp
   41e6b:	48 89 e5             	mov    %rsp,%rbp
   41e6e:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   41e72:	0f b7 05 87 24 01 00 	movzwl 0x12487(%rip),%eax        # 54300 <interrupts_enabled>
   41e79:	f7 d0                	not    %eax
   41e7b:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   41e7f:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41e83:	0f b6 c0             	movzbl %al,%eax
   41e86:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   41e8d:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e90:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   41e94:	8b 55 f0             	mov    -0x10(%rbp),%edx
   41e97:	ee                   	out    %al,(%dx)
}
   41e98:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   41e99:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41e9d:	66 c1 e8 08          	shr    $0x8,%ax
   41ea1:	0f b6 c0             	movzbl %al,%eax
   41ea4:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   41eab:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41eae:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   41eb2:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41eb5:	ee                   	out    %al,(%dx)
}
   41eb6:	90                   	nop
}
   41eb7:	90                   	nop
   41eb8:	c9                   	leave  
   41eb9:	c3                   	ret    

0000000000041eba <interrupt_init>:

void interrupt_init(void) {
   41eba:	55                   	push   %rbp
   41ebb:	48 89 e5             	mov    %rsp,%rbp
   41ebe:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   41ec2:	66 c7 05 35 24 01 00 	movw   $0x0,0x12435(%rip)        # 54300 <interrupts_enabled>
   41ec9:	00 00 
    interrupt_mask();
   41ecb:	e8 9a ff ff ff       	call   41e6a <interrupt_mask>
   41ed0:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   41ed7:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41edb:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   41edf:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   41ee2:	ee                   	out    %al,(%dx)
}
   41ee3:	90                   	nop
   41ee4:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   41eeb:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41eef:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   41ef3:	8b 55 ac             	mov    -0x54(%rbp),%edx
   41ef6:	ee                   	out    %al,(%dx)
}
   41ef7:	90                   	nop
   41ef8:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   41eff:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f03:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   41f07:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   41f0a:	ee                   	out    %al,(%dx)
}
   41f0b:	90                   	nop
   41f0c:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   41f13:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f17:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   41f1b:	8b 55 bc             	mov    -0x44(%rbp),%edx
   41f1e:	ee                   	out    %al,(%dx)
}
   41f1f:	90                   	nop
   41f20:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   41f27:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f2b:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   41f2f:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   41f32:	ee                   	out    %al,(%dx)
}
   41f33:	90                   	nop
   41f34:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   41f3b:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f3f:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   41f43:	8b 55 cc             	mov    -0x34(%rbp),%edx
   41f46:	ee                   	out    %al,(%dx)
}
   41f47:	90                   	nop
   41f48:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   41f4f:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f53:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   41f57:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   41f5a:	ee                   	out    %al,(%dx)
}
   41f5b:	90                   	nop
   41f5c:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   41f63:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f67:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   41f6b:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41f6e:	ee                   	out    %al,(%dx)
}
   41f6f:	90                   	nop
   41f70:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   41f77:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f7b:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41f7f:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41f82:	ee                   	out    %al,(%dx)
}
   41f83:	90                   	nop
   41f84:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   41f8b:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f8f:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41f93:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41f96:	ee                   	out    %al,(%dx)
}
   41f97:	90                   	nop
   41f98:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   41f9f:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41fa3:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41fa7:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41faa:	ee                   	out    %al,(%dx)
}
   41fab:	90                   	nop
   41fac:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   41fb3:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41fb7:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41fbb:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41fbe:	ee                   	out    %al,(%dx)
}
   41fbf:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   41fc0:	e8 a5 fe ff ff       	call   41e6a <interrupt_mask>
}
   41fc5:	90                   	nop
   41fc6:	c9                   	leave  
   41fc7:	c3                   	ret    

0000000000041fc8 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   41fc8:	55                   	push   %rbp
   41fc9:	48 89 e5             	mov    %rsp,%rbp
   41fcc:	48 83 ec 28          	sub    $0x28,%rsp
   41fd0:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   41fd3:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41fd7:	0f 8e 9e 00 00 00    	jle    4207b <timer_init+0xb3>
   41fdd:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   41fe4:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41fe8:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41fec:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41fef:	ee                   	out    %al,(%dx)
}
   41ff0:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   41ff1:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41ff4:	89 c2                	mov    %eax,%edx
   41ff6:	c1 ea 1f             	shr    $0x1f,%edx
   41ff9:	01 d0                	add    %edx,%eax
   41ffb:	d1 f8                	sar    %eax
   41ffd:	05 de 34 12 00       	add    $0x1234de,%eax
   42002:	99                   	cltd   
   42003:	f7 7d dc             	idivl  -0x24(%rbp)
   42006:	89 c2                	mov    %eax,%edx
   42008:	89 d0                	mov    %edx,%eax
   4200a:	c1 f8 1f             	sar    $0x1f,%eax
   4200d:	c1 e8 18             	shr    $0x18,%eax
   42010:	01 c2                	add    %eax,%edx
   42012:	0f b6 d2             	movzbl %dl,%edx
   42015:	29 c2                	sub    %eax,%edx
   42017:	89 d0                	mov    %edx,%eax
   42019:	0f b6 c0             	movzbl %al,%eax
   4201c:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   42023:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42026:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   4202a:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4202d:	ee                   	out    %al,(%dx)
}
   4202e:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   4202f:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42032:	89 c2                	mov    %eax,%edx
   42034:	c1 ea 1f             	shr    $0x1f,%edx
   42037:	01 d0                	add    %edx,%eax
   42039:	d1 f8                	sar    %eax
   4203b:	05 de 34 12 00       	add    $0x1234de,%eax
   42040:	99                   	cltd   
   42041:	f7 7d dc             	idivl  -0x24(%rbp)
   42044:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   4204a:	85 c0                	test   %eax,%eax
   4204c:	0f 48 c2             	cmovs  %edx,%eax
   4204f:	c1 f8 08             	sar    $0x8,%eax
   42052:	0f b6 c0             	movzbl %al,%eax
   42055:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   4205c:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4205f:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42063:	8b 55 fc             	mov    -0x4(%rbp),%edx
   42066:	ee                   	out    %al,(%dx)
}
   42067:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   42068:	0f b7 05 91 22 01 00 	movzwl 0x12291(%rip),%eax        # 54300 <interrupts_enabled>
   4206f:	83 c8 01             	or     $0x1,%eax
   42072:	66 89 05 87 22 01 00 	mov    %ax,0x12287(%rip)        # 54300 <interrupts_enabled>
   42079:	eb 11                	jmp    4208c <timer_init+0xc4>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   4207b:	0f b7 05 7e 22 01 00 	movzwl 0x1227e(%rip),%eax        # 54300 <interrupts_enabled>
   42082:	83 e0 fe             	and    $0xfffffffe,%eax
   42085:	66 89 05 74 22 01 00 	mov    %ax,0x12274(%rip)        # 54300 <interrupts_enabled>
    }
    interrupt_mask();
   4208c:	e8 d9 fd ff ff       	call   41e6a <interrupt_mask>
}
   42091:	90                   	nop
   42092:	c9                   	leave  
   42093:	c3                   	ret    

0000000000042094 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   42094:	55                   	push   %rbp
   42095:	48 89 e5             	mov    %rsp,%rbp
   42098:	48 83 ec 08          	sub    $0x8,%rsp
   4209c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   420a0:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   420a5:	74 14                	je     420bb <physical_memory_isreserved+0x27>
   420a7:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   420ae:	00 
   420af:	76 11                	jbe    420c2 <physical_memory_isreserved+0x2e>
   420b1:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   420b8:	00 
   420b9:	77 07                	ja     420c2 <physical_memory_isreserved+0x2e>
   420bb:	b8 01 00 00 00       	mov    $0x1,%eax
   420c0:	eb 05                	jmp    420c7 <physical_memory_isreserved+0x33>
   420c2:	b8 00 00 00 00       	mov    $0x0,%eax
}
   420c7:	c9                   	leave  
   420c8:	c3                   	ret    

00000000000420c9 <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   420c9:	55                   	push   %rbp
   420ca:	48 89 e5             	mov    %rsp,%rbp
   420cd:	48 83 ec 10          	sub    $0x10,%rsp
   420d1:	89 7d fc             	mov    %edi,-0x4(%rbp)
   420d4:	89 75 f8             	mov    %esi,-0x8(%rbp)
   420d7:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   420da:	8b 45 fc             	mov    -0x4(%rbp),%eax
   420dd:	c1 e0 10             	shl    $0x10,%eax
   420e0:	89 c2                	mov    %eax,%edx
   420e2:	8b 45 f8             	mov    -0x8(%rbp),%eax
   420e5:	c1 e0 0b             	shl    $0xb,%eax
   420e8:	09 c2                	or     %eax,%edx
   420ea:	8b 45 f4             	mov    -0xc(%rbp),%eax
   420ed:	c1 e0 08             	shl    $0x8,%eax
   420f0:	09 d0                	or     %edx,%eax
}
   420f2:	c9                   	leave  
   420f3:	c3                   	ret    

00000000000420f4 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   420f4:	55                   	push   %rbp
   420f5:	48 89 e5             	mov    %rsp,%rbp
   420f8:	48 83 ec 18          	sub    $0x18,%rsp
   420fc:	89 7d ec             	mov    %edi,-0x14(%rbp)
   420ff:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   42102:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42105:	8b 45 e8             	mov    -0x18(%rbp),%eax
   42108:	09 d0                	or     %edx,%eax
   4210a:	0d 00 00 00 80       	or     $0x80000000,%eax
   4210f:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   42116:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   42119:	8b 45 f0             	mov    -0x10(%rbp),%eax
   4211c:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4211f:	ef                   	out    %eax,(%dx)
}
   42120:	90                   	nop
   42121:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   42128:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4212b:	89 c2                	mov    %eax,%edx
   4212d:	ed                   	in     (%dx),%eax
   4212e:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   42131:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   42134:	c9                   	leave  
   42135:	c3                   	ret    

0000000000042136 <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   42136:	55                   	push   %rbp
   42137:	48 89 e5             	mov    %rsp,%rbp
   4213a:	48 83 ec 28          	sub    $0x28,%rsp
   4213e:	89 7d dc             	mov    %edi,-0x24(%rbp)
   42141:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   42144:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4214b:	eb 73                	jmp    421c0 <pci_find_device+0x8a>
        for (int slot = 0; slot != 32; ++slot) {
   4214d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   42154:	eb 60                	jmp    421b6 <pci_find_device+0x80>
            for (int func = 0; func != 8; ++func) {
   42156:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   4215d:	eb 4a                	jmp    421a9 <pci_find_device+0x73>
                int configaddr = pci_make_configaddr(bus, slot, func);
   4215f:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42162:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   42165:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42168:	89 ce                	mov    %ecx,%esi
   4216a:	89 c7                	mov    %eax,%edi
   4216c:	e8 58 ff ff ff       	call   420c9 <pci_make_configaddr>
   42171:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   42174:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42177:	be 00 00 00 00       	mov    $0x0,%esi
   4217c:	89 c7                	mov    %eax,%edi
   4217e:	e8 71 ff ff ff       	call   420f4 <pci_config_readl>
   42183:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   42186:	8b 45 d8             	mov    -0x28(%rbp),%eax
   42189:	c1 e0 10             	shl    $0x10,%eax
   4218c:	0b 45 dc             	or     -0x24(%rbp),%eax
   4218f:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   42192:	75 05                	jne    42199 <pci_find_device+0x63>
                    return configaddr;
   42194:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42197:	eb 35                	jmp    421ce <pci_find_device+0x98>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   42199:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   4219d:	75 06                	jne    421a5 <pci_find_device+0x6f>
   4219f:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   421a3:	74 0c                	je     421b1 <pci_find_device+0x7b>
            for (int func = 0; func != 8; ++func) {
   421a5:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   421a9:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   421ad:	75 b0                	jne    4215f <pci_find_device+0x29>
   421af:	eb 01                	jmp    421b2 <pci_find_device+0x7c>
                    break;
   421b1:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   421b2:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   421b6:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   421ba:	75 9a                	jne    42156 <pci_find_device+0x20>
    for (int bus = 0; bus != 256; ++bus) {
   421bc:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   421c0:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   421c7:	75 84                	jne    4214d <pci_find_device+0x17>
                }
            }
        }
    }
    return -1;
   421c9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   421ce:	c9                   	leave  
   421cf:	c3                   	ret    

00000000000421d0 <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   421d0:	55                   	push   %rbp
   421d1:	48 89 e5             	mov    %rsp,%rbp
   421d4:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   421d8:	be 13 71 00 00       	mov    $0x7113,%esi
   421dd:	bf 86 80 00 00       	mov    $0x8086,%edi
   421e2:	e8 4f ff ff ff       	call   42136 <pci_find_device>
   421e7:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   421ea:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   421ee:	78 30                	js     42220 <poweroff+0x50>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   421f0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   421f3:	be 40 00 00 00       	mov    $0x40,%esi
   421f8:	89 c7                	mov    %eax,%edi
   421fa:	e8 f5 fe ff ff       	call   420f4 <pci_config_readl>
   421ff:	25 c0 ff 00 00       	and    $0xffc0,%eax
   42204:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   42207:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4220a:	83 c0 04             	add    $0x4,%eax
   4220d:	89 45 f4             	mov    %eax,-0xc(%rbp)
   42210:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   42216:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   4221a:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4221d:	66 ef                	out    %ax,(%dx)
}
   4221f:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   42220:	ba 00 4a 04 00       	mov    $0x44a00,%edx
   42225:	be 00 c0 00 00       	mov    $0xc000,%esi
   4222a:	bf 80 07 00 00       	mov    $0x780,%edi
   4222f:	b8 00 00 00 00       	mov    $0x0,%eax
   42234:	e8 80 21 00 00       	call   443b9 <console_printf>
 spinloop: goto spinloop;
   42239:	eb fe                	jmp    42239 <poweroff+0x69>

000000000004223b <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   4223b:	55                   	push   %rbp
   4223c:	48 89 e5             	mov    %rsp,%rbp
   4223f:	48 83 ec 10          	sub    $0x10,%rsp
   42243:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   4224a:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4224e:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42252:	8b 55 fc             	mov    -0x4(%rbp),%edx
   42255:	ee                   	out    %al,(%dx)
}
   42256:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   42257:	eb fe                	jmp    42257 <reboot+0x1c>

0000000000042259 <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   42259:	55                   	push   %rbp
   4225a:	48 89 e5             	mov    %rsp,%rbp
   4225d:	48 83 ec 10          	sub    $0x10,%rsp
   42261:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42265:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   42268:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4226c:	48 83 c0 08          	add    $0x8,%rax
   42270:	ba c0 00 00 00       	mov    $0xc0,%edx
   42275:	be 00 00 00 00       	mov    $0x0,%esi
   4227a:	48 89 c7             	mov    %rax,%rdi
   4227d:	e8 80 13 00 00       	call   43602 <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   42282:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42286:	66 c7 80 a8 00 00 00 	movw   $0x13,0xa8(%rax)
   4228d:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   4228f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42293:	48 c7 80 80 00 00 00 	movq   $0x23,0x80(%rax)
   4229a:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   4229e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   422a2:	48 c7 80 88 00 00 00 	movq   $0x23,0x88(%rax)
   422a9:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   422ad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   422b1:	66 c7 80 c0 00 00 00 	movw   $0x23,0xc0(%rax)
   422b8:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   422ba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   422be:	48 c7 80 b0 00 00 00 	movq   $0x200,0xb0(%rax)
   422c5:	00 02 00 00 
    p->display_status = 1;
   422c9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   422cd:	c6 80 d8 00 00 00 01 	movb   $0x1,0xd8(%rax)

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   422d4:	8b 45 f4             	mov    -0xc(%rbp),%eax
   422d7:	83 e0 01             	and    $0x1,%eax
   422da:	85 c0                	test   %eax,%eax
   422dc:	74 1c                	je     422fa <process_init+0xa1>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   422de:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   422e2:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   422e9:	80 cc 30             	or     $0x30,%ah
   422ec:	48 89 c2             	mov    %rax,%rdx
   422ef:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   422f3:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   422fa:	8b 45 f4             	mov    -0xc(%rbp),%eax
   422fd:	83 e0 02             	and    $0x2,%eax
   42300:	85 c0                	test   %eax,%eax
   42302:	74 1c                	je     42320 <process_init+0xc7>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   42304:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42308:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   4230f:	80 e4 fd             	and    $0xfd,%ah
   42312:	48 89 c2             	mov    %rax,%rdx
   42315:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42319:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
}
   42320:	90                   	nop
   42321:	c9                   	leave  
   42322:	c3                   	ret    

0000000000042323 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   42323:	55                   	push   %rbp
   42324:	48 89 e5             	mov    %rsp,%rbp
   42327:	48 83 ec 28          	sub    $0x28,%rsp
   4232b:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   4232e:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   42332:	78 09                	js     4233d <console_show_cursor+0x1a>
   42334:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   4233b:	7e 07                	jle    42344 <console_show_cursor+0x21>
        cpos = 0;
   4233d:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   42344:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   4234b:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4234f:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   42353:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   42356:	ee                   	out    %al,(%dx)
}
   42357:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   42358:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4235b:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   42361:	85 c0                	test   %eax,%eax
   42363:	0f 48 c2             	cmovs  %edx,%eax
   42366:	c1 f8 08             	sar    $0x8,%eax
   42369:	0f b6 c0             	movzbl %al,%eax
   4236c:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   42373:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42376:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   4237a:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4237d:	ee                   	out    %al,(%dx)
}
   4237e:	90                   	nop
   4237f:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   42386:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4238a:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   4238e:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42391:	ee                   	out    %al,(%dx)
}
   42392:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   42393:	8b 55 dc             	mov    -0x24(%rbp),%edx
   42396:	89 d0                	mov    %edx,%eax
   42398:	c1 f8 1f             	sar    $0x1f,%eax
   4239b:	c1 e8 18             	shr    $0x18,%eax
   4239e:	01 c2                	add    %eax,%edx
   423a0:	0f b6 d2             	movzbl %dl,%edx
   423a3:	29 c2                	sub    %eax,%edx
   423a5:	89 d0                	mov    %edx,%eax
   423a7:	0f b6 c0             	movzbl %al,%eax
   423aa:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   423b1:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   423b4:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   423b8:	8b 55 fc             	mov    -0x4(%rbp),%edx
   423bb:	ee                   	out    %al,(%dx)
}
   423bc:	90                   	nop
}
   423bd:	90                   	nop
   423be:	c9                   	leave  
   423bf:	c3                   	ret    

00000000000423c0 <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   423c0:	55                   	push   %rbp
   423c1:	48 89 e5             	mov    %rsp,%rbp
   423c4:	48 83 ec 20          	sub    $0x20,%rsp
   423c8:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   423cf:	8b 45 f0             	mov    -0x10(%rbp),%eax
   423d2:	89 c2                	mov    %eax,%edx
   423d4:	ec                   	in     (%dx),%al
   423d5:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   423d8:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   423dc:	0f b6 c0             	movzbl %al,%eax
   423df:	83 e0 01             	and    $0x1,%eax
   423e2:	85 c0                	test   %eax,%eax
   423e4:	75 0a                	jne    423f0 <keyboard_readc+0x30>
        return -1;
   423e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   423eb:	e9 e7 01 00 00       	jmp    425d7 <keyboard_readc+0x217>
   423f0:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   423f7:	8b 45 e8             	mov    -0x18(%rbp),%eax
   423fa:	89 c2                	mov    %eax,%edx
   423fc:	ec                   	in     (%dx),%al
   423fd:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   42400:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   42404:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   42407:	0f b6 05 f4 1e 01 00 	movzbl 0x11ef4(%rip),%eax        # 54302 <last_escape.2>
   4240e:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   42411:	c6 05 ea 1e 01 00 00 	movb   $0x0,0x11eea(%rip)        # 54302 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   42418:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   4241c:	75 11                	jne    4242f <keyboard_readc+0x6f>
        last_escape = 0x80;
   4241e:	c6 05 dd 1e 01 00 80 	movb   $0x80,0x11edd(%rip)        # 54302 <last_escape.2>
        return 0;
   42425:	b8 00 00 00 00       	mov    $0x0,%eax
   4242a:	e9 a8 01 00 00       	jmp    425d7 <keyboard_readc+0x217>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   4242f:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42433:	84 c0                	test   %al,%al
   42435:	79 60                	jns    42497 <keyboard_readc+0xd7>
        int ch = keymap[(data & 0x7F) | escape];
   42437:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4243b:	83 e0 7f             	and    $0x7f,%eax
   4243e:	89 c2                	mov    %eax,%edx
   42440:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   42444:	09 d0                	or     %edx,%eax
   42446:	48 98                	cltq   
   42448:	0f b6 80 20 4a 04 00 	movzbl 0x44a20(%rax),%eax
   4244f:	0f b6 c0             	movzbl %al,%eax
   42452:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   42455:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   4245c:	7e 2f                	jle    4248d <keyboard_readc+0xcd>
   4245e:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   42465:	7f 26                	jg     4248d <keyboard_readc+0xcd>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   42467:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4246a:	2d fa 00 00 00       	sub    $0xfa,%eax
   4246f:	ba 01 00 00 00       	mov    $0x1,%edx
   42474:	89 c1                	mov    %eax,%ecx
   42476:	d3 e2                	shl    %cl,%edx
   42478:	89 d0                	mov    %edx,%eax
   4247a:	f7 d0                	not    %eax
   4247c:	89 c2                	mov    %eax,%edx
   4247e:	0f b6 05 7e 1e 01 00 	movzbl 0x11e7e(%rip),%eax        # 54303 <modifiers.1>
   42485:	21 d0                	and    %edx,%eax
   42487:	88 05 76 1e 01 00    	mov    %al,0x11e76(%rip)        # 54303 <modifiers.1>
        }
        return 0;
   4248d:	b8 00 00 00 00       	mov    $0x0,%eax
   42492:	e9 40 01 00 00       	jmp    425d7 <keyboard_readc+0x217>
    }

    int ch = (unsigned char) keymap[data | escape];
   42497:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4249b:	0a 45 fa             	or     -0x6(%rbp),%al
   4249e:	0f b6 c0             	movzbl %al,%eax
   424a1:	48 98                	cltq   
   424a3:	0f b6 80 20 4a 04 00 	movzbl 0x44a20(%rax),%eax
   424aa:	0f b6 c0             	movzbl %al,%eax
   424ad:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   424b0:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   424b4:	7e 57                	jle    4250d <keyboard_readc+0x14d>
   424b6:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   424ba:	7f 51                	jg     4250d <keyboard_readc+0x14d>
        if (modifiers & MOD_CONTROL) {
   424bc:	0f b6 05 40 1e 01 00 	movzbl 0x11e40(%rip),%eax        # 54303 <modifiers.1>
   424c3:	0f b6 c0             	movzbl %al,%eax
   424c6:	83 e0 02             	and    $0x2,%eax
   424c9:	85 c0                	test   %eax,%eax
   424cb:	74 09                	je     424d6 <keyboard_readc+0x116>
            ch -= 0x60;
   424cd:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   424d1:	e9 fd 00 00 00       	jmp    425d3 <keyboard_readc+0x213>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   424d6:	0f b6 05 26 1e 01 00 	movzbl 0x11e26(%rip),%eax        # 54303 <modifiers.1>
   424dd:	0f b6 c0             	movzbl %al,%eax
   424e0:	83 e0 01             	and    $0x1,%eax
   424e3:	85 c0                	test   %eax,%eax
   424e5:	0f 94 c2             	sete   %dl
   424e8:	0f b6 05 14 1e 01 00 	movzbl 0x11e14(%rip),%eax        # 54303 <modifiers.1>
   424ef:	0f b6 c0             	movzbl %al,%eax
   424f2:	83 e0 08             	and    $0x8,%eax
   424f5:	85 c0                	test   %eax,%eax
   424f7:	0f 94 c0             	sete   %al
   424fa:	31 d0                	xor    %edx,%eax
   424fc:	84 c0                	test   %al,%al
   424fe:	0f 84 cf 00 00 00    	je     425d3 <keyboard_readc+0x213>
            ch -= 0x20;
   42504:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   42508:	e9 c6 00 00 00       	jmp    425d3 <keyboard_readc+0x213>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   4250d:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   42514:	7e 30                	jle    42546 <keyboard_readc+0x186>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   42516:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42519:	2d fa 00 00 00       	sub    $0xfa,%eax
   4251e:	ba 01 00 00 00       	mov    $0x1,%edx
   42523:	89 c1                	mov    %eax,%ecx
   42525:	d3 e2                	shl    %cl,%edx
   42527:	89 d0                	mov    %edx,%eax
   42529:	89 c2                	mov    %eax,%edx
   4252b:	0f b6 05 d1 1d 01 00 	movzbl 0x11dd1(%rip),%eax        # 54303 <modifiers.1>
   42532:	31 d0                	xor    %edx,%eax
   42534:	88 05 c9 1d 01 00    	mov    %al,0x11dc9(%rip)        # 54303 <modifiers.1>
        ch = 0;
   4253a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42541:	e9 8e 00 00 00       	jmp    425d4 <keyboard_readc+0x214>
    } else if (ch >= KEY_SHIFT) {
   42546:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   4254d:	7e 2d                	jle    4257c <keyboard_readc+0x1bc>
        modifiers |= 1 << (ch - KEY_SHIFT);
   4254f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42552:	2d fa 00 00 00       	sub    $0xfa,%eax
   42557:	ba 01 00 00 00       	mov    $0x1,%edx
   4255c:	89 c1                	mov    %eax,%ecx
   4255e:	d3 e2                	shl    %cl,%edx
   42560:	89 d0                	mov    %edx,%eax
   42562:	89 c2                	mov    %eax,%edx
   42564:	0f b6 05 98 1d 01 00 	movzbl 0x11d98(%rip),%eax        # 54303 <modifiers.1>
   4256b:	09 d0                	or     %edx,%eax
   4256d:	88 05 90 1d 01 00    	mov    %al,0x11d90(%rip)        # 54303 <modifiers.1>
        ch = 0;
   42573:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4257a:	eb 58                	jmp    425d4 <keyboard_readc+0x214>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   4257c:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   42580:	7e 31                	jle    425b3 <keyboard_readc+0x1f3>
   42582:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   42589:	7f 28                	jg     425b3 <keyboard_readc+0x1f3>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   4258b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4258e:	8d 50 80             	lea    -0x80(%rax),%edx
   42591:	0f b6 05 6b 1d 01 00 	movzbl 0x11d6b(%rip),%eax        # 54303 <modifiers.1>
   42598:	0f b6 c0             	movzbl %al,%eax
   4259b:	83 e0 03             	and    $0x3,%eax
   4259e:	48 98                	cltq   
   425a0:	48 63 d2             	movslq %edx,%rdx
   425a3:	0f b6 84 90 20 4b 04 	movzbl 0x44b20(%rax,%rdx,4),%eax
   425aa:	00 
   425ab:	0f b6 c0             	movzbl %al,%eax
   425ae:	89 45 fc             	mov    %eax,-0x4(%rbp)
   425b1:	eb 21                	jmp    425d4 <keyboard_readc+0x214>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   425b3:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   425b7:	7f 1b                	jg     425d4 <keyboard_readc+0x214>
   425b9:	0f b6 05 43 1d 01 00 	movzbl 0x11d43(%rip),%eax        # 54303 <modifiers.1>
   425c0:	0f b6 c0             	movzbl %al,%eax
   425c3:	83 e0 02             	and    $0x2,%eax
   425c6:	85 c0                	test   %eax,%eax
   425c8:	74 0a                	je     425d4 <keyboard_readc+0x214>
        ch = 0;
   425ca:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   425d1:	eb 01                	jmp    425d4 <keyboard_readc+0x214>
        if (modifiers & MOD_CONTROL) {
   425d3:	90                   	nop
    }

    return ch;
   425d4:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   425d7:	c9                   	leave  
   425d8:	c3                   	ret    

00000000000425d9 <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   425d9:	55                   	push   %rbp
   425da:	48 89 e5             	mov    %rsp,%rbp
   425dd:	48 83 ec 20          	sub    $0x20,%rsp
   425e1:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   425e8:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   425eb:	89 c2                	mov    %eax,%edx
   425ed:	ec                   	in     (%dx),%al
   425ee:	88 45 e3             	mov    %al,-0x1d(%rbp)
   425f1:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   425f8:	8b 45 ec             	mov    -0x14(%rbp),%eax
   425fb:	89 c2                	mov    %eax,%edx
   425fd:	ec                   	in     (%dx),%al
   425fe:	88 45 eb             	mov    %al,-0x15(%rbp)
   42601:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   42608:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4260b:	89 c2                	mov    %eax,%edx
   4260d:	ec                   	in     (%dx),%al
   4260e:	88 45 f3             	mov    %al,-0xd(%rbp)
   42611:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   42618:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4261b:	89 c2                	mov    %eax,%edx
   4261d:	ec                   	in     (%dx),%al
   4261e:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   42621:	90                   	nop
   42622:	c9                   	leave  
   42623:	c3                   	ret    

0000000000042624 <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   42624:	55                   	push   %rbp
   42625:	48 89 e5             	mov    %rsp,%rbp
   42628:	48 83 ec 40          	sub    $0x40,%rsp
   4262c:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42630:	89 f0                	mov    %esi,%eax
   42632:	89 55 c0             	mov    %edx,-0x40(%rbp)
   42635:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   42638:	8b 05 c6 1c 01 00    	mov    0x11cc6(%rip),%eax        # 54304 <initialized.0>
   4263e:	85 c0                	test   %eax,%eax
   42640:	75 1e                	jne    42660 <parallel_port_putc+0x3c>
   42642:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   42649:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4264d:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   42651:	8b 55 f8             	mov    -0x8(%rbp),%edx
   42654:	ee                   	out    %al,(%dx)
}
   42655:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   42656:	c7 05 a4 1c 01 00 01 	movl   $0x1,0x11ca4(%rip)        # 54304 <initialized.0>
   4265d:	00 00 00 
    }

    for (int i = 0;
   42660:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42667:	eb 09                	jmp    42672 <parallel_port_putc+0x4e>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   42669:	e8 6b ff ff ff       	call   425d9 <delay>
         ++i) {
   4266e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   42672:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   42679:	7f 18                	jg     42693 <parallel_port_putc+0x6f>
   4267b:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42682:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42685:	89 c2                	mov    %eax,%edx
   42687:	ec                   	in     (%dx),%al
   42688:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   4268b:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   4268f:	84 c0                	test   %al,%al
   42691:	79 d6                	jns    42669 <parallel_port_putc+0x45>
    }
    outb(IO_PARALLEL1_DATA, c);
   42693:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   42697:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   4269e:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   426a1:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   426a5:	8b 55 d8             	mov    -0x28(%rbp),%edx
   426a8:	ee                   	out    %al,(%dx)
}
   426a9:	90                   	nop
   426aa:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   426b1:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   426b5:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   426b9:	8b 55 e0             	mov    -0x20(%rbp),%edx
   426bc:	ee                   	out    %al,(%dx)
}
   426bd:	90                   	nop
   426be:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   426c5:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   426c9:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   426cd:	8b 55 e8             	mov    -0x18(%rbp),%edx
   426d0:	ee                   	out    %al,(%dx)
}
   426d1:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   426d2:	90                   	nop
   426d3:	c9                   	leave  
   426d4:	c3                   	ret    

00000000000426d5 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   426d5:	55                   	push   %rbp
   426d6:	48 89 e5             	mov    %rsp,%rbp
   426d9:	48 83 ec 20          	sub    $0x20,%rsp
   426dd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   426e1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   426e5:	48 c7 45 f8 24 26 04 	movq   $0x42624,-0x8(%rbp)
   426ec:	00 
    printer_vprintf(&p, 0, format, val);
   426ed:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   426f1:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   426f5:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   426f9:	be 00 00 00 00       	mov    $0x0,%esi
   426fe:	48 89 c7             	mov    %rax,%rdi
   42701:	e8 98 11 00 00       	call   4389e <printer_vprintf>
}
   42706:	90                   	nop
   42707:	c9                   	leave  
   42708:	c3                   	ret    

0000000000042709 <log_printf>:

void log_printf(const char* format, ...) {
   42709:	55                   	push   %rbp
   4270a:	48 89 e5             	mov    %rsp,%rbp
   4270d:	48 83 ec 60          	sub    $0x60,%rsp
   42711:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42715:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42719:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   4271d:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42721:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42725:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42729:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   42730:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42734:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42738:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4273c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   42740:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   42744:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42748:	48 89 d6             	mov    %rdx,%rsi
   4274b:	48 89 c7             	mov    %rax,%rdi
   4274e:	e8 82 ff ff ff       	call   426d5 <log_vprintf>
    va_end(val);
}
   42753:	90                   	nop
   42754:	c9                   	leave  
   42755:	c3                   	ret    

0000000000042756 <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   42756:	55                   	push   %rbp
   42757:	48 89 e5             	mov    %rsp,%rbp
   4275a:	48 83 ec 40          	sub    $0x40,%rsp
   4275e:	89 7d dc             	mov    %edi,-0x24(%rbp)
   42761:	89 75 d8             	mov    %esi,-0x28(%rbp)
   42764:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   42768:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   4276c:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   42770:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42774:	48 8b 0a             	mov    (%rdx),%rcx
   42777:	48 89 08             	mov    %rcx,(%rax)
   4277a:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   4277e:	48 89 48 08          	mov    %rcx,0x8(%rax)
   42782:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   42786:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   4278a:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   4278e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42792:	48 89 d6             	mov    %rdx,%rsi
   42795:	48 89 c7             	mov    %rax,%rdi
   42798:	e8 38 ff ff ff       	call   426d5 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   4279d:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   427a1:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   427a5:	8b 75 d8             	mov    -0x28(%rbp),%esi
   427a8:	8b 45 dc             	mov    -0x24(%rbp),%eax
   427ab:	89 c7                	mov    %eax,%edi
   427ad:	e8 9b 1b 00 00       	call   4434d <console_vprintf>
}
   427b2:	c9                   	leave  
   427b3:	c3                   	ret    

00000000000427b4 <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   427b4:	55                   	push   %rbp
   427b5:	48 89 e5             	mov    %rsp,%rbp
   427b8:	48 83 ec 60          	sub    $0x60,%rsp
   427bc:	89 7d ac             	mov    %edi,-0x54(%rbp)
   427bf:	89 75 a8             	mov    %esi,-0x58(%rbp)
   427c2:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   427c6:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   427ca:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   427ce:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   427d2:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   427d9:	48 8d 45 10          	lea    0x10(%rbp),%rax
   427dd:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   427e1:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   427e5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   427e9:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   427ed:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   427f1:	8b 75 a8             	mov    -0x58(%rbp),%esi
   427f4:	8b 45 ac             	mov    -0x54(%rbp),%eax
   427f7:	89 c7                	mov    %eax,%edi
   427f9:	e8 58 ff ff ff       	call   42756 <error_vprintf>
   427fe:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   42801:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   42804:	c9                   	leave  
   42805:	c3                   	ret    

0000000000042806 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'f', and 'e' cause a soft
//    reboot where the kernel runs the allocator programs, "fork", or
//    "forkexit", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   42806:	55                   	push   %rbp
   42807:	48 89 e5             	mov    %rsp,%rbp
   4280a:	53                   	push   %rbx
   4280b:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   4280f:	e8 ac fb ff ff       	call   423c0 <keyboard_readc>
   42814:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   42817:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   4281b:	74 1c                	je     42839 <check_keyboard+0x33>
   4281d:	83 7d e4 66          	cmpl   $0x66,-0x1c(%rbp)
   42821:	74 16                	je     42839 <check_keyboard+0x33>
   42823:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42827:	74 10                	je     42839 <check_keyboard+0x33>
   42829:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   4282d:	74 0a                	je     42839 <check_keyboard+0x33>
   4282f:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42833:	0f 85 e9 00 00 00    	jne    42922 <check_keyboard+0x11c>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   42839:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   42840:	00 
        memset(pt, 0, PAGESIZE * 3);
   42841:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42845:	ba 00 30 00 00       	mov    $0x3000,%edx
   4284a:	be 00 00 00 00       	mov    $0x0,%esi
   4284f:	48 89 c7             	mov    %rax,%rdi
   42852:	e8 ab 0d 00 00       	call   43602 <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   42857:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4285b:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   42862:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42866:	48 05 00 10 00 00    	add    $0x1000,%rax
   4286c:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   42873:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42877:	48 05 00 20 00 00    	add    $0x2000,%rax
   4287d:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   42884:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42888:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   4288c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42890:	0f 22 d8             	mov    %rax,%cr3
}
   42893:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   42894:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "fork";
   4289b:	48 c7 45 e8 78 4b 04 	movq   $0x44b78,-0x18(%rbp)
   428a2:	00 
        if (c == 'a') {
   428a3:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   428a7:	75 0a                	jne    428b3 <check_keyboard+0xad>
            argument = "allocator";
   428a9:	48 c7 45 e8 7d 4b 04 	movq   $0x44b7d,-0x18(%rbp)
   428b0:	00 
   428b1:	eb 2e                	jmp    428e1 <check_keyboard+0xdb>
        } else if (c == 'e') {
   428b3:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   428b7:	75 0a                	jne    428c3 <check_keyboard+0xbd>
            argument = "forkexit";
   428b9:	48 c7 45 e8 87 4b 04 	movq   $0x44b87,-0x18(%rbp)
   428c0:	00 
   428c1:	eb 1e                	jmp    428e1 <check_keyboard+0xdb>
        }
        else if (c == 't'){
   428c3:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   428c7:	75 0a                	jne    428d3 <check_keyboard+0xcd>
            argument = "test";
   428c9:	48 c7 45 e8 90 4b 04 	movq   $0x44b90,-0x18(%rbp)
   428d0:	00 
   428d1:	eb 0e                	jmp    428e1 <check_keyboard+0xdb>
        }
        else if(c == '2'){
   428d3:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   428d7:	75 08                	jne    428e1 <check_keyboard+0xdb>
            argument = "test2";
   428d9:	48 c7 45 e8 95 4b 04 	movq   $0x44b95,-0x18(%rbp)
   428e0:	00 
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   428e1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   428e5:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   428e9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   428ee:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   428f2:	73 14                	jae    42908 <check_keyboard+0x102>
   428f4:	ba 9b 4b 04 00       	mov    $0x44b9b,%edx
   428f9:	be 5d 02 00 00       	mov    $0x25d,%esi
   428fe:	bf b7 4b 04 00       	mov    $0x44bb7,%edi
   42903:	e8 1f 01 00 00       	call   42a27 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   42908:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4290c:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   4290f:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   42913:	48 89 c3             	mov    %rax,%rbx
   42916:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   4291b:	e9 e0 d6 ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   42920:	eb 11                	jmp    42933 <check_keyboard+0x12d>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   42922:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   42926:	74 06                	je     4292e <check_keyboard+0x128>
   42928:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   4292c:	75 05                	jne    42933 <check_keyboard+0x12d>
        poweroff();
   4292e:	e8 9d f8 ff ff       	call   421d0 <poweroff>
    }
    return c;
   42933:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   42936:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   4293a:	c9                   	leave  
   4293b:	c3                   	ret    

000000000004293c <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   4293c:	55                   	push   %rbp
   4293d:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   42940:	e8 c1 fe ff ff       	call   42806 <check_keyboard>
   42945:	eb f9                	jmp    42940 <fail+0x4>

0000000000042947 <panic>:

// panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void panic(const char* format, ...) {
   42947:	55                   	push   %rbp
   42948:	48 89 e5             	mov    %rsp,%rbp
   4294b:	48 83 ec 60          	sub    $0x60,%rsp
   4294f:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42953:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42957:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   4295b:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4295f:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42963:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42967:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   4296e:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42972:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   42976:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4297a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   4297e:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   42983:	0f 84 80 00 00 00    	je     42a09 <panic+0xc2>
        // Print panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   42989:	ba cb 4b 04 00       	mov    $0x44bcb,%edx
   4298e:	be 00 c0 00 00       	mov    $0xc000,%esi
   42993:	bf 30 07 00 00       	mov    $0x730,%edi
   42998:	b8 00 00 00 00       	mov    $0x0,%eax
   4299d:	e8 12 fe ff ff       	call   427b4 <error_printf>
   429a2:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   429a5:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   429a9:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   429ad:	8b 45 cc             	mov    -0x34(%rbp),%eax
   429b0:	be 00 c0 00 00       	mov    $0xc000,%esi
   429b5:	89 c7                	mov    %eax,%edi
   429b7:	e8 9a fd ff ff       	call   42756 <error_vprintf>
   429bc:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   429bf:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   429c2:	48 63 c1             	movslq %ecx,%rax
   429c5:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   429cc:	48 c1 e8 20          	shr    $0x20,%rax
   429d0:	89 c2                	mov    %eax,%edx
   429d2:	c1 fa 05             	sar    $0x5,%edx
   429d5:	89 c8                	mov    %ecx,%eax
   429d7:	c1 f8 1f             	sar    $0x1f,%eax
   429da:	29 c2                	sub    %eax,%edx
   429dc:	89 d0                	mov    %edx,%eax
   429de:	c1 e0 02             	shl    $0x2,%eax
   429e1:	01 d0                	add    %edx,%eax
   429e3:	c1 e0 04             	shl    $0x4,%eax
   429e6:	29 c1                	sub    %eax,%ecx
   429e8:	89 ca                	mov    %ecx,%edx
   429ea:	85 d2                	test   %edx,%edx
   429ec:	74 34                	je     42a22 <panic+0xdb>
            error_printf(cpos, 0xC000, "\n");
   429ee:	8b 45 cc             	mov    -0x34(%rbp),%eax
   429f1:	ba d3 4b 04 00       	mov    $0x44bd3,%edx
   429f6:	be 00 c0 00 00       	mov    $0xc000,%esi
   429fb:	89 c7                	mov    %eax,%edi
   429fd:	b8 00 00 00 00       	mov    $0x0,%eax
   42a02:	e8 ad fd ff ff       	call   427b4 <error_printf>
   42a07:	eb 19                	jmp    42a22 <panic+0xdb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   42a09:	ba d5 4b 04 00       	mov    $0x44bd5,%edx
   42a0e:	be 00 c0 00 00       	mov    $0xc000,%esi
   42a13:	bf 30 07 00 00       	mov    $0x730,%edi
   42a18:	b8 00 00 00 00       	mov    $0x0,%eax
   42a1d:	e8 92 fd ff ff       	call   427b4 <error_printf>
    }

    va_end(val);
    fail();
   42a22:	e8 15 ff ff ff       	call   4293c <fail>

0000000000042a27 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   42a27:	55                   	push   %rbp
   42a28:	48 89 e5             	mov    %rsp,%rbp
   42a2b:	48 83 ec 20          	sub    $0x20,%rsp
   42a2f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42a33:	89 75 f4             	mov    %esi,-0xc(%rbp)
   42a36:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   42a3a:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   42a3e:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42a41:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42a45:	48 89 c6             	mov    %rax,%rsi
   42a48:	bf db 4b 04 00       	mov    $0x44bdb,%edi
   42a4d:	b8 00 00 00 00       	mov    $0x0,%eax
   42a52:	e8 f0 fe ff ff       	call   42947 <panic>

0000000000042a57 <default_exception>:
}

void default_exception(proc* p){
   42a57:	55                   	push   %rbp
   42a58:	48 89 e5             	mov    %rsp,%rbp
   42a5b:	48 83 ec 20          	sub    $0x20,%rsp
   42a5f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   42a63:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42a67:	48 83 c0 08          	add    $0x8,%rax
   42a6b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    panic("Unexpected exception %d!\n", reg->reg_intno);
   42a6f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42a73:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   42a7a:	48 89 c6             	mov    %rax,%rsi
   42a7d:	bf f9 4b 04 00       	mov    $0x44bf9,%edi
   42a82:	b8 00 00 00 00       	mov    $0x0,%eax
   42a87:	e8 bb fe ff ff       	call   42947 <panic>

0000000000042a8c <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   42a8c:	55                   	push   %rbp
   42a8d:	48 89 e5             	mov    %rsp,%rbp
   42a90:	48 83 ec 10          	sub    $0x10,%rsp
   42a94:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42a98:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   42a9b:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   42a9f:	78 06                	js     42aa7 <pageindex+0x1b>
   42aa1:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   42aa5:	7e 14                	jle    42abb <pageindex+0x2f>
   42aa7:	ba 18 4c 04 00       	mov    $0x44c18,%edx
   42aac:	be 1e 00 00 00       	mov    $0x1e,%esi
   42ab1:	bf 31 4c 04 00       	mov    $0x44c31,%edi
   42ab6:	e8 6c ff ff ff       	call   42a27 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   42abb:	b8 03 00 00 00       	mov    $0x3,%eax
   42ac0:	2b 45 f4             	sub    -0xc(%rbp),%eax
   42ac3:	89 c2                	mov    %eax,%edx
   42ac5:	89 d0                	mov    %edx,%eax
   42ac7:	c1 e0 03             	shl    $0x3,%eax
   42aca:	01 d0                	add    %edx,%eax
   42acc:	83 c0 0c             	add    $0xc,%eax
   42acf:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42ad3:	89 c1                	mov    %eax,%ecx
   42ad5:	48 d3 ea             	shr    %cl,%rdx
   42ad8:	48 89 d0             	mov    %rdx,%rax
   42adb:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   42ae0:	c9                   	leave  
   42ae1:	c3                   	ret    

0000000000042ae2 <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   42ae2:	55                   	push   %rbp
   42ae3:	48 89 e5             	mov    %rsp,%rbp
   42ae6:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   42aea:	48 c7 05 0b 25 01 00 	movq   $0x56000,0x1250b(%rip)        # 55000 <kernel_pagetable>
   42af1:	00 60 05 00 
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   42af5:	ba 00 50 00 00       	mov    $0x5000,%edx
   42afa:	be 00 00 00 00       	mov    $0x0,%esi
   42aff:	bf 00 60 05 00       	mov    $0x56000,%edi
   42b04:	e8 f9 0a 00 00       	call   43602 <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   42b09:	b8 00 70 05 00       	mov    $0x57000,%eax
   42b0e:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   42b12:	48 89 05 e7 34 01 00 	mov    %rax,0x134e7(%rip)        # 56000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   42b19:	b8 00 80 05 00       	mov    $0x58000,%eax
   42b1e:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   42b22:	48 89 05 d7 44 01 00 	mov    %rax,0x144d7(%rip)        # 57000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   42b29:	b8 00 90 05 00       	mov    $0x59000,%eax
   42b2e:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   42b32:	48 89 05 c7 54 01 00 	mov    %rax,0x154c7(%rip)        # 58000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   42b39:	b8 00 a0 05 00       	mov    $0x5a000,%eax
   42b3e:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   42b42:	48 89 05 bf 54 01 00 	mov    %rax,0x154bf(%rip)        # 58008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   42b49:	48 8b 05 b0 24 01 00 	mov    0x124b0(%rip),%rax        # 55000 <kernel_pagetable>
   42b50:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42b56:	b9 00 00 20 00       	mov    $0x200000,%ecx
   42b5b:	ba 00 00 00 00       	mov    $0x0,%edx
   42b60:	be 00 00 00 00       	mov    $0x0,%esi
   42b65:	48 89 c7             	mov    %rax,%rdi
   42b68:	e8 b9 01 00 00       	call   42d26 <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42b6d:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42b74:	00 
   42b75:	eb 62                	jmp    42bd9 <virtual_memory_init+0xf7>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   42b77:	48 8b 0d 82 24 01 00 	mov    0x12482(%rip),%rcx        # 55000 <kernel_pagetable>
   42b7e:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42b82:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42b86:	48 89 ce             	mov    %rcx,%rsi
   42b89:	48 89 c7             	mov    %rax,%rdi
   42b8c:	e8 5b 05 00 00       	call   430ec <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l1pagetable ?
        assert(vmap.pa == addr);
   42b91:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b95:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   42b99:	74 14                	je     42baf <virtual_memory_init+0xcd>
   42b9b:	ba 45 4c 04 00       	mov    $0x44c45,%edx
   42ba0:	be 2d 00 00 00       	mov    $0x2d,%esi
   42ba5:	bf 55 4c 04 00       	mov    $0x44c55,%edi
   42baa:	e8 78 fe ff ff       	call   42a27 <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   42baf:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42bb2:	48 98                	cltq   
   42bb4:	83 e0 03             	and    $0x3,%eax
   42bb7:	48 83 f8 03          	cmp    $0x3,%rax
   42bbb:	74 14                	je     42bd1 <virtual_memory_init+0xef>
   42bbd:	ba 68 4c 04 00       	mov    $0x44c68,%edx
   42bc2:	be 2e 00 00 00       	mov    $0x2e,%esi
   42bc7:	bf 55 4c 04 00       	mov    $0x44c55,%edi
   42bcc:	e8 56 fe ff ff       	call   42a27 <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42bd1:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42bd8:	00 
   42bd9:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   42be0:	00 
   42be1:	76 94                	jbe    42b77 <virtual_memory_init+0x95>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   42be3:	48 8b 05 16 24 01 00 	mov    0x12416(%rip),%rax        # 55000 <kernel_pagetable>
   42bea:	48 89 c7             	mov    %rax,%rdi
   42bed:	e8 03 00 00 00       	call   42bf5 <set_pagetable>
}
   42bf2:	90                   	nop
   42bf3:	c9                   	leave  
   42bf4:	c3                   	ret    

0000000000042bf5 <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   42bf5:	55                   	push   %rbp
   42bf6:	48 89 e5             	mov    %rsp,%rbp
   42bf9:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   42bfd:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   42c01:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42c05:	25 ff 0f 00 00       	and    $0xfff,%eax
   42c0a:	48 85 c0             	test   %rax,%rax
   42c0d:	74 14                	je     42c23 <set_pagetable+0x2e>
   42c0f:	ba 95 4c 04 00       	mov    $0x44c95,%edx
   42c14:	be 3d 00 00 00       	mov    $0x3d,%esi
   42c19:	bf 55 4c 04 00       	mov    $0x44c55,%edi
   42c1e:	e8 04 fe ff ff       	call   42a27 <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   42c23:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42c28:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   42c2c:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42c30:	48 89 ce             	mov    %rcx,%rsi
   42c33:	48 89 c7             	mov    %rax,%rdi
   42c36:	e8 b1 04 00 00       	call   430ec <virtual_memory_lookup>
   42c3b:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42c3f:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42c44:	48 39 d0             	cmp    %rdx,%rax
   42c47:	74 14                	je     42c5d <set_pagetable+0x68>
   42c49:	ba b0 4c 04 00       	mov    $0x44cb0,%edx
   42c4e:	be 3f 00 00 00       	mov    $0x3f,%esi
   42c53:	bf 55 4c 04 00       	mov    $0x44c55,%edi
   42c58:	e8 ca fd ff ff       	call   42a27 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   42c5d:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   42c61:	48 8b 0d 98 23 01 00 	mov    0x12398(%rip),%rcx        # 55000 <kernel_pagetable>
   42c68:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   42c6c:	48 89 ce             	mov    %rcx,%rsi
   42c6f:	48 89 c7             	mov    %rax,%rdi
   42c72:	e8 75 04 00 00       	call   430ec <virtual_memory_lookup>
   42c77:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42c7b:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42c7f:	48 39 c2             	cmp    %rax,%rdx
   42c82:	74 14                	je     42c98 <set_pagetable+0xa3>
   42c84:	ba 18 4d 04 00       	mov    $0x44d18,%edx
   42c89:	be 41 00 00 00       	mov    $0x41,%esi
   42c8e:	bf 55 4c 04 00       	mov    $0x44c55,%edi
   42c93:	e8 8f fd ff ff       	call   42a27 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   42c98:	48 8b 05 61 23 01 00 	mov    0x12361(%rip),%rax        # 55000 <kernel_pagetable>
   42c9f:	48 89 c2             	mov    %rax,%rdx
   42ca2:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   42ca6:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42caa:	48 89 ce             	mov    %rcx,%rsi
   42cad:	48 89 c7             	mov    %rax,%rdi
   42cb0:	e8 37 04 00 00       	call   430ec <virtual_memory_lookup>
   42cb5:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42cb9:	48 8b 15 40 23 01 00 	mov    0x12340(%rip),%rdx        # 55000 <kernel_pagetable>
   42cc0:	48 39 d0             	cmp    %rdx,%rax
   42cc3:	74 14                	je     42cd9 <set_pagetable+0xe4>
   42cc5:	ba 78 4d 04 00       	mov    $0x44d78,%edx
   42cca:	be 43 00 00 00       	mov    $0x43,%esi
   42ccf:	bf 55 4c 04 00       	mov    $0x44c55,%edi
   42cd4:	e8 4e fd ff ff       	call   42a27 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   42cd9:	ba 26 2d 04 00       	mov    $0x42d26,%edx
   42cde:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42ce2:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42ce6:	48 89 ce             	mov    %rcx,%rsi
   42ce9:	48 89 c7             	mov    %rax,%rdi
   42cec:	e8 fb 03 00 00       	call   430ec <virtual_memory_lookup>
   42cf1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42cf5:	ba 26 2d 04 00       	mov    $0x42d26,%edx
   42cfa:	48 39 d0             	cmp    %rdx,%rax
   42cfd:	74 14                	je     42d13 <set_pagetable+0x11e>
   42cff:	ba e0 4d 04 00       	mov    $0x44de0,%edx
   42d04:	be 45 00 00 00       	mov    $0x45,%esi
   42d09:	bf 55 4c 04 00       	mov    $0x44c55,%edi
   42d0e:	e8 14 fd ff ff       	call   42a27 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   42d13:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42d17:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42d1b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42d1f:	0f 22 d8             	mov    %rax,%cr3
}
   42d22:	90                   	nop
}
   42d23:	90                   	nop
   42d24:	c9                   	leave  
   42d25:	c3                   	ret    

0000000000042d26 <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   42d26:	55                   	push   %rbp
   42d27:	48 89 e5             	mov    %rsp,%rbp
   42d2a:	41 54                	push   %r12
   42d2c:	53                   	push   %rbx
   42d2d:	48 83 ec 50          	sub    $0x50,%rsp
   42d31:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42d35:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42d39:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   42d3d:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
   42d41:	44 89 45 ac          	mov    %r8d,-0x54(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   42d45:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42d49:	25 ff 0f 00 00       	and    $0xfff,%eax
   42d4e:	48 85 c0             	test   %rax,%rax
   42d51:	74 14                	je     42d67 <virtual_memory_map+0x41>
   42d53:	ba 46 4e 04 00       	mov    $0x44e46,%edx
   42d58:	be 66 00 00 00       	mov    $0x66,%esi
   42d5d:	bf 55 4c 04 00       	mov    $0x44c55,%edi
   42d62:	e8 c0 fc ff ff       	call   42a27 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   42d67:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42d6b:	25 ff 0f 00 00       	and    $0xfff,%eax
   42d70:	48 85 c0             	test   %rax,%rax
   42d73:	74 14                	je     42d89 <virtual_memory_map+0x63>
   42d75:	ba 59 4e 04 00       	mov    $0x44e59,%edx
   42d7a:	be 67 00 00 00       	mov    $0x67,%esi
   42d7f:	bf 55 4c 04 00       	mov    $0x44c55,%edi
   42d84:	e8 9e fc ff ff       	call   42a27 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   42d89:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42d8d:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42d91:	48 01 d0             	add    %rdx,%rax
   42d94:	48 3b 45 c0          	cmp    -0x40(%rbp),%rax
   42d98:	73 24                	jae    42dbe <virtual_memory_map+0x98>
   42d9a:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42d9e:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42da2:	48 01 d0             	add    %rdx,%rax
   42da5:	48 85 c0             	test   %rax,%rax
   42da8:	74 14                	je     42dbe <virtual_memory_map+0x98>
   42daa:	ba 6c 4e 04 00       	mov    $0x44e6c,%edx
   42daf:	be 68 00 00 00       	mov    $0x68,%esi
   42db4:	bf 55 4c 04 00       	mov    $0x44c55,%edi
   42db9:	e8 69 fc ff ff       	call   42a27 <assert_fail>
    if (perm & PTE_P) {
   42dbe:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42dc1:	48 98                	cltq   
   42dc3:	83 e0 01             	and    $0x1,%eax
   42dc6:	48 85 c0             	test   %rax,%rax
   42dc9:	74 6e                	je     42e39 <virtual_memory_map+0x113>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   42dcb:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42dcf:	25 ff 0f 00 00       	and    $0xfff,%eax
   42dd4:	48 85 c0             	test   %rax,%rax
   42dd7:	74 14                	je     42ded <virtual_memory_map+0xc7>
   42dd9:	ba 8a 4e 04 00       	mov    $0x44e8a,%edx
   42dde:	be 6a 00 00 00       	mov    $0x6a,%esi
   42de3:	bf 55 4c 04 00       	mov    $0x44c55,%edi
   42de8:	e8 3a fc ff ff       	call   42a27 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   42ded:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42df1:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42df5:	48 01 d0             	add    %rdx,%rax
   42df8:	48 3b 45 b8          	cmp    -0x48(%rbp),%rax
   42dfc:	73 14                	jae    42e12 <virtual_memory_map+0xec>
   42dfe:	ba 9d 4e 04 00       	mov    $0x44e9d,%edx
   42e03:	be 6b 00 00 00       	mov    $0x6b,%esi
   42e08:	bf 55 4c 04 00       	mov    $0x44c55,%edi
   42e0d:	e8 15 fc ff ff       	call   42a27 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   42e12:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42e16:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42e1a:	48 01 d0             	add    %rdx,%rax
   42e1d:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   42e23:	76 14                	jbe    42e39 <virtual_memory_map+0x113>
   42e25:	ba ab 4e 04 00       	mov    $0x44eab,%edx
   42e2a:	be 6c 00 00 00       	mov    $0x6c,%esi
   42e2f:	bf 55 4c 04 00       	mov    $0x44c55,%edi
   42e34:	e8 ee fb ff ff       	call   42a27 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   42e39:	83 7d ac 00          	cmpl   $0x0,-0x54(%rbp)
   42e3d:	78 09                	js     42e48 <virtual_memory_map+0x122>
   42e3f:	81 7d ac ff 0f 00 00 	cmpl   $0xfff,-0x54(%rbp)
   42e46:	7e 14                	jle    42e5c <virtual_memory_map+0x136>
   42e48:	ba c7 4e 04 00       	mov    $0x44ec7,%edx
   42e4d:	be 6e 00 00 00       	mov    $0x6e,%esi
   42e52:	bf 55 4c 04 00       	mov    $0x44c55,%edi
   42e57:	e8 cb fb ff ff       	call   42a27 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   42e5c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42e60:	25 ff 0f 00 00       	and    $0xfff,%eax
   42e65:	48 85 c0             	test   %rax,%rax
   42e68:	74 14                	je     42e7e <virtual_memory_map+0x158>
   42e6a:	ba e8 4e 04 00       	mov    $0x44ee8,%edx
   42e6f:	be 6f 00 00 00       	mov    $0x6f,%esi
   42e74:	bf 55 4c 04 00       	mov    $0x44c55,%edi
   42e79:	e8 a9 fb ff ff       	call   42a27 <assert_fail>

    int last_index123 = -1;
   42e7e:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%rbp)
    x86_64_pagetable* l1pagetable = NULL;
   42e85:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
   42e8c:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42e8d:	e9 e7 00 00 00       	jmp    42f79 <virtual_memory_map+0x253>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   42e92:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42e96:	48 c1 e8 15          	shr    $0x15,%rax
   42e9a:	89 45 dc             	mov    %eax,-0x24(%rbp)
        if (cur_index123 != last_index123) {
   42e9d:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42ea0:	3b 45 ec             	cmp    -0x14(%rbp),%eax
   42ea3:	74 20                	je     42ec5 <virtual_memory_map+0x19f>
            // TODO --> done
            // find pointer to last level pagetable for current va

			l1pagetable = lookup_l1pagetable(pagetable, va, perm);	
   42ea5:	8b 55 ac             	mov    -0x54(%rbp),%edx
   42ea8:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   42eac:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42eb0:	48 89 ce             	mov    %rcx,%rsi
   42eb3:	48 89 c7             	mov    %rax,%rdi
   42eb6:	e8 d7 00 00 00       	call   42f92 <lookup_l1pagetable>
   42ebb:	48 89 45 e0          	mov    %rax,-0x20(%rbp)

            last_index123 = cur_index123;
   42ebf:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42ec2:	89 45 ec             	mov    %eax,-0x14(%rbp)
        }
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   42ec5:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42ec8:	48 98                	cltq   
   42eca:	83 e0 01             	and    $0x1,%eax
   42ecd:	48 85 c0             	test   %rax,%rax
   42ed0:	74 3a                	je     42f0c <virtual_memory_map+0x1e6>
   42ed2:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42ed7:	74 33                	je     42f0c <virtual_memory_map+0x1e6>
            // TODO --> done
            // map `pa` at appropriate entry with permissions `perm`
			l1pagetable->entry[L1PAGEINDEX(va)] =  (0x00000000FFFFFFFF & pa) | perm;
   42ed9:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42edd:	41 89 c4             	mov    %eax,%r12d
   42ee0:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42ee3:	48 63 d8             	movslq %eax,%rbx
   42ee6:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42eea:	be 03 00 00 00       	mov    $0x3,%esi
   42eef:	48 89 c7             	mov    %rax,%rdi
   42ef2:	e8 95 fb ff ff       	call   42a8c <pageindex>
   42ef7:	89 c2                	mov    %eax,%edx
   42ef9:	4c 89 e1             	mov    %r12,%rcx
   42efc:	48 09 d9             	or     %rbx,%rcx
   42eff:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42f03:	48 63 d2             	movslq %edx,%rdx
   42f06:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42f0a:	eb 55                	jmp    42f61 <virtual_memory_map+0x23b>

        } else if (l1pagetable) { // if page is NOT marked present
   42f0c:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42f11:	74 26                	je     42f39 <virtual_memory_map+0x213>
            // TODO --> done
            // map to address 0 with `perm`
			l1pagetable->entry[L1PAGEINDEX(va)] = 0 | perm;
   42f13:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42f17:	be 03 00 00 00       	mov    $0x3,%esi
   42f1c:	48 89 c7             	mov    %rax,%rdi
   42f1f:	e8 68 fb ff ff       	call   42a8c <pageindex>
   42f24:	89 c2                	mov    %eax,%edx
   42f26:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42f29:	48 63 c8             	movslq %eax,%rcx
   42f2c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42f30:	48 63 d2             	movslq %edx,%rdx
   42f33:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42f37:	eb 28                	jmp    42f61 <virtual_memory_map+0x23b>

        } else if (perm & PTE_P) {
   42f39:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42f3c:	48 98                	cltq   
   42f3e:	83 e0 01             	and    $0x1,%eax
   42f41:	48 85 c0             	test   %rax,%rax
   42f44:	74 1b                	je     42f61 <virtual_memory_map+0x23b>
            // error, no allocated l1 page found for va
            log_printf("[Kern Info] failed to find l1pagetable address at " __FILE__ ": %d\n", __LINE__);
   42f46:	be 8b 00 00 00       	mov    $0x8b,%esi
   42f4b:	bf 10 4f 04 00       	mov    $0x44f10,%edi
   42f50:	b8 00 00 00 00       	mov    $0x0,%eax
   42f55:	e8 af f7 ff ff       	call   42709 <log_printf>
            return -1;
   42f5a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42f5f:	eb 28                	jmp    42f89 <virtual_memory_map+0x263>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42f61:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
   42f68:	00 
   42f69:	48 81 45 b8 00 10 00 	addq   $0x1000,-0x48(%rbp)
   42f70:	00 
   42f71:	48 81 6d b0 00 10 00 	subq   $0x1000,-0x50(%rbp)
   42f78:	00 
   42f79:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   42f7e:	0f 85 0e ff ff ff    	jne    42e92 <virtual_memory_map+0x16c>
        }
    }
    return 0;
   42f84:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42f89:	48 83 c4 50          	add    $0x50,%rsp
   42f8d:	5b                   	pop    %rbx
   42f8e:	41 5c                	pop    %r12
   42f90:	5d                   	pop    %rbp
   42f91:	c3                   	ret    

0000000000042f92 <lookup_l1pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   42f92:	55                   	push   %rbp
   42f93:	48 89 e5             	mov    %rsp,%rbp
   42f96:	48 83 ec 40          	sub    $0x40,%rsp
   42f9a:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42f9e:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42fa2:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   42fa5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42fa9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l1 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   42fad:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   42fb4:	e9 23 01 00 00       	jmp    430dc <lookup_l1pagetable+0x14a>
        // TODO --> done
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        x86_64_pageentry_t pe = pt->entry[PAGEINDEX(va, i)]; // replace this
   42fb9:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42fbc:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42fc0:	89 d6                	mov    %edx,%esi
   42fc2:	48 89 c7             	mov    %rax,%rdi
   42fc5:	e8 c2 fa ff ff       	call   42a8c <pageindex>
   42fca:	89 c2                	mov    %eax,%edx
   42fcc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42fd0:	48 63 d2             	movslq %edx,%rdx
   42fd3:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   42fd7:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   42fdb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42fdf:	83 e0 01             	and    $0x1,%eax
   42fe2:	48 85 c0             	test   %rax,%rax
   42fe5:	75 63                	jne    4304a <lookup_l1pagetable+0xb8>
            log_printf("[Kern Info] Error looking up l1pagetable: Pagetable address: 0x%x perm: 0x%x."
   42fe7:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42fea:	8d 48 02             	lea    0x2(%rax),%ecx
   42fed:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ff1:	25 ff 0f 00 00       	and    $0xfff,%eax
   42ff6:	48 89 c2             	mov    %rax,%rdx
   42ff9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ffd:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43003:	48 89 c6             	mov    %rax,%rsi
   43006:	bf 58 4f 04 00       	mov    $0x44f58,%edi
   4300b:	b8 00 00 00 00       	mov    $0x0,%eax
   43010:	e8 f4 f6 ff ff       	call   42709 <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   43015:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43018:	48 98                	cltq   
   4301a:	83 e0 01             	and    $0x1,%eax
   4301d:	48 85 c0             	test   %rax,%rax
   43020:	75 0a                	jne    4302c <lookup_l1pagetable+0x9a>
                return NULL;
   43022:	b8 00 00 00 00       	mov    $0x0,%eax
   43027:	e9 be 00 00 00       	jmp    430ea <lookup_l1pagetable+0x158>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   4302c:	be af 00 00 00       	mov    $0xaf,%esi
   43031:	bf c0 4f 04 00       	mov    $0x44fc0,%edi
   43036:	b8 00 00 00 00       	mov    $0x0,%eax
   4303b:	e8 c9 f6 ff ff       	call   42709 <log_printf>
            return NULL;
   43040:	b8 00 00 00 00       	mov    $0x0,%eax
   43045:	e9 a0 00 00 00       	jmp    430ea <lookup_l1pagetable+0x158>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   4304a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4304e:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43054:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   4305a:	76 14                	jbe    43070 <lookup_l1pagetable+0xde>
   4305c:	ba 08 50 04 00       	mov    $0x45008,%edx
   43061:	be b4 00 00 00       	mov    $0xb4,%esi
   43066:	bf 55 4c 04 00       	mov    $0x44c55,%edi
   4306b:	e8 b7 f9 ff ff       	call   42a27 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   43070:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43073:	48 98                	cltq   
   43075:	83 e0 02             	and    $0x2,%eax
   43078:	48 85 c0             	test   %rax,%rax
   4307b:	74 20                	je     4309d <lookup_l1pagetable+0x10b>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   4307d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43081:	83 e0 02             	and    $0x2,%eax
   43084:	48 85 c0             	test   %rax,%rax
   43087:	75 14                	jne    4309d <lookup_l1pagetable+0x10b>
   43089:	ba 28 50 04 00       	mov    $0x45028,%edx
   4308e:	be b6 00 00 00       	mov    $0xb6,%esi
   43093:	bf 55 4c 04 00       	mov    $0x44c55,%edi
   43098:	e8 8a f9 ff ff       	call   42a27 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   4309d:	8b 45 cc             	mov    -0x34(%rbp),%eax
   430a0:	48 98                	cltq   
   430a2:	83 e0 04             	and    $0x4,%eax
   430a5:	48 85 c0             	test   %rax,%rax
   430a8:	74 20                	je     430ca <lookup_l1pagetable+0x138>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   430aa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   430ae:	83 e0 04             	and    $0x4,%eax
   430b1:	48 85 c0             	test   %rax,%rax
   430b4:	75 14                	jne    430ca <lookup_l1pagetable+0x138>
   430b6:	ba 33 50 04 00       	mov    $0x45033,%edx
   430bb:	be b9 00 00 00       	mov    $0xb9,%esi
   430c0:	bf 55 4c 04 00       	mov    $0x44c55,%edi
   430c5:	e8 5d f9 ff ff       	call   42a27 <assert_fail>
        }

        // TODO --> done
        // set pt to physical address to next pagetable using `pe`
        pt = (x86_64_pagetable *) PTE_ADDR(pe); // replace this
   430ca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   430ce:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   430d4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   430d8:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   430dc:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   430e0:	0f 8e d3 fe ff ff    	jle    42fb9 <lookup_l1pagetable+0x27>
    }
    return pt;
   430e6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   430ea:	c9                   	leave  
   430eb:	c3                   	ret    

00000000000430ec <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   430ec:	55                   	push   %rbp
   430ed:	48 89 e5             	mov    %rsp,%rbp
   430f0:	48 83 ec 50          	sub    $0x50,%rsp
   430f4:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   430f8:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   430fc:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   43100:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43104:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   43108:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   4310f:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   43110:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   43117:	eb 41                	jmp    4315a <virtual_memory_lookup+0x6e>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   43119:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4311c:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   43120:	89 d6                	mov    %edx,%esi
   43122:	48 89 c7             	mov    %rax,%rdi
   43125:	e8 62 f9 ff ff       	call   42a8c <pageindex>
   4312a:	89 c2                	mov    %eax,%edx
   4312c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43130:	48 63 d2             	movslq %edx,%rdx
   43133:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   43137:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4313b:	83 e0 06             	and    $0x6,%eax
   4313e:	48 f7 d0             	not    %rax
   43141:	48 21 d0             	and    %rdx,%rax
   43144:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   43148:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4314c:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43152:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   43156:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   4315a:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   4315e:	7f 0c                	jg     4316c <virtual_memory_lookup+0x80>
   43160:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43164:	83 e0 01             	and    $0x1,%eax
   43167:	48 85 c0             	test   %rax,%rax
   4316a:	75 ad                	jne    43119 <virtual_memory_lookup+0x2d>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   4316c:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   43173:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   4317a:	ff 
   4317b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   43182:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43186:	83 e0 01             	and    $0x1,%eax
   43189:	48 85 c0             	test   %rax,%rax
   4318c:	74 34                	je     431c2 <virtual_memory_lookup+0xd6>
        vam.pn = PAGENUMBER(pe);
   4318e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43192:	48 c1 e8 0c          	shr    $0xc,%rax
   43196:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   43199:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4319d:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   431a3:	48 89 c2             	mov    %rax,%rdx
   431a6:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   431aa:	25 ff 0f 00 00       	and    $0xfff,%eax
   431af:	48 09 d0             	or     %rdx,%rax
   431b2:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   431b6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   431ba:	25 ff 0f 00 00       	and    $0xfff,%eax
   431bf:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   431c2:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   431c6:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   431ca:	48 89 10             	mov    %rdx,(%rax)
   431cd:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   431d1:	48 89 50 08          	mov    %rdx,0x8(%rax)
   431d5:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   431d9:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   431dd:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   431e1:	c9                   	leave  
   431e2:	c3                   	ret    

00000000000431e3 <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   431e3:	55                   	push   %rbp
   431e4:	48 89 e5             	mov    %rsp,%rbp
   431e7:	48 83 ec 40          	sub    $0x40,%rsp
   431eb:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   431ef:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   431f2:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   431f6:	c7 45 f8 07 00 00 00 	movl   $0x7,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   431fd:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43201:	78 08                	js     4320b <program_load+0x28>
   43203:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   43206:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   43209:	7c 14                	jl     4321f <program_load+0x3c>
   4320b:	ba 40 50 04 00       	mov    $0x45040,%edx
   43210:	be 37 00 00 00       	mov    $0x37,%esi
   43215:	bf 70 50 04 00       	mov    $0x45070,%edi
   4321a:	e8 08 f8 ff ff       	call   42a27 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   4321f:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   43222:	48 98                	cltq   
   43224:	48 c1 e0 04          	shl    $0x4,%rax
   43228:	48 05 20 60 04 00    	add    $0x46020,%rax
   4322e:	48 8b 00             	mov    (%rax),%rax
   43231:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   43235:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43239:	8b 00                	mov    (%rax),%eax
   4323b:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   43240:	74 14                	je     43256 <program_load+0x73>
   43242:	ba 82 50 04 00       	mov    $0x45082,%edx
   43247:	be 39 00 00 00       	mov    $0x39,%esi
   4324c:	bf 70 50 04 00       	mov    $0x45070,%edi
   43251:	e8 d1 f7 ff ff       	call   42a27 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   43256:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4325a:	48 8b 50 20          	mov    0x20(%rax),%rdx
   4325e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43262:	48 01 d0             	add    %rdx,%rax
   43265:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   43269:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   43270:	e9 94 00 00 00       	jmp    43309 <program_load+0x126>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   43275:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43278:	48 63 d0             	movslq %eax,%rdx
   4327b:	48 89 d0             	mov    %rdx,%rax
   4327e:	48 c1 e0 03          	shl    $0x3,%rax
   43282:	48 29 d0             	sub    %rdx,%rax
   43285:	48 c1 e0 03          	shl    $0x3,%rax
   43289:	48 89 c2             	mov    %rax,%rdx
   4328c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43290:	48 01 d0             	add    %rdx,%rax
   43293:	8b 00                	mov    (%rax),%eax
   43295:	83 f8 01             	cmp    $0x1,%eax
   43298:	75 6b                	jne    43305 <program_load+0x122>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   4329a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4329d:	48 63 d0             	movslq %eax,%rdx
   432a0:	48 89 d0             	mov    %rdx,%rax
   432a3:	48 c1 e0 03          	shl    $0x3,%rax
   432a7:	48 29 d0             	sub    %rdx,%rax
   432aa:	48 c1 e0 03          	shl    $0x3,%rax
   432ae:	48 89 c2             	mov    %rax,%rdx
   432b1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   432b5:	48 01 d0             	add    %rdx,%rax
   432b8:	48 8b 50 08          	mov    0x8(%rax),%rdx
   432bc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432c0:	48 01 d0             	add    %rdx,%rax
   432c3:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   432c7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   432ca:	48 63 d0             	movslq %eax,%rdx
   432cd:	48 89 d0             	mov    %rdx,%rax
   432d0:	48 c1 e0 03          	shl    $0x3,%rax
   432d4:	48 29 d0             	sub    %rdx,%rax
   432d7:	48 c1 e0 03          	shl    $0x3,%rax
   432db:	48 89 c2             	mov    %rax,%rdx
   432de:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   432e2:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   432e6:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   432ea:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   432ee:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   432f2:	48 89 c7             	mov    %rax,%rdi
   432f5:	e8 3d 00 00 00       	call   43337 <program_load_segment>
   432fa:	85 c0                	test   %eax,%eax
   432fc:	79 07                	jns    43305 <program_load+0x122>
                return -1;
   432fe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43303:	eb 30                	jmp    43335 <program_load+0x152>
    for (int i = 0; i < eh->e_phnum; ++i) {
   43305:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   43309:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4330d:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   43311:	0f b7 c0             	movzwl %ax,%eax
   43314:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   43317:	0f 8c 58 ff ff ff    	jl     43275 <program_load+0x92>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   4331d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43321:	48 8b 50 18          	mov    0x18(%rax),%rdx
   43325:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43329:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    return 0;
   43330:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43335:	c9                   	leave  
   43336:	c3                   	ret    

0000000000043337 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   43337:	55                   	push   %rbp
   43338:	48 89 e5             	mov    %rsp,%rbp
   4333b:	48 83 ec 70          	sub    $0x70,%rsp
   4333f:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   43343:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   43347:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   4334b:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   4334f:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   43353:	48 8b 40 10          	mov    0x10(%rax),%rax
   43357:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   4335b:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   4335f:	48 8b 50 20          	mov    0x20(%rax),%rdx
   43363:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43367:	48 01 d0             	add    %rdx,%rax
   4336a:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   4336e:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   43372:	48 8b 50 28          	mov    0x28(%rax),%rdx
   43376:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4337a:	48 01 d0             	add    %rdx,%rax
   4337d:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   43381:	48 81 65 e8 00 f0 ff 	andq   $0xfffffffffffff000,-0x18(%rbp)
   43388:	ff 

	// virtual addressing
	for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   43389:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4338d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43391:	e9 8f 00 00 00       	jmp    43425 <program_load_segment+0xee>
		uintptr_t pa;
		if (next_free_page(&pa) < 0
   43396:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4339a:	48 89 c7             	mov    %rax,%rdi
   4339d:	e8 95 cf ff ff       	call   40337 <next_free_page>
   433a2:	85 c0                	test   %eax,%eax
   433a4:	78 45                	js     433eb <program_load_segment+0xb4>
			|| assign_physical_page(pa, p->p_pid) < 0
   433a6:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   433aa:	8b 00                	mov    (%rax),%eax
   433ac:	0f be d0             	movsbl %al,%edx
   433af:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   433b3:	89 d6                	mov    %edx,%esi
   433b5:	48 89 c7             	mov    %rax,%rdi
   433b8:	e8 41 d2 ff ff       	call   405fe <assign_physical_page>
   433bd:	85 c0                	test   %eax,%eax
   433bf:	78 2a                	js     433eb <program_load_segment+0xb4>
			|| virtual_memory_map(p->p_pagetable, addr, pa, PAGESIZE, PTE_P | PTE_W | PTE_U) < 0) {
   433c1:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   433c5:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   433c9:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   433d0:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   433d4:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   433da:	b9 00 10 00 00       	mov    $0x1000,%ecx
   433df:	48 89 c7             	mov    %rax,%rdi
   433e2:	e8 3f f9 ff ff       	call   42d26 <virtual_memory_map>
   433e7:	85 c0                	test   %eax,%eax
   433e9:	79 32                	jns    4341d <program_load_segment+0xe6>

			console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   433eb:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   433ef:	8b 00                	mov    (%rax),%eax
   433f1:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   433f5:	49 89 d0             	mov    %rdx,%r8
   433f8:	89 c1                	mov    %eax,%ecx
   433fa:	ba a0 50 04 00       	mov    $0x450a0,%edx
   433ff:	be 00 c0 00 00       	mov    $0xc000,%esi
   43404:	bf e0 06 00 00       	mov    $0x6e0,%edi
   43409:	b8 00 00 00 00       	mov    $0x0,%eax
   4340e:	e8 a6 0f 00 00       	call   443b9 <console_printf>
			return -1;
   43413:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43418:	e9 e5 00 00 00       	jmp    43502 <program_load_segment+0x1cb>
	for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   4341d:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43424:	00 
   43425:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43429:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   4342d:	0f 82 63 ff ff ff    	jb     43396 <program_load_segment+0x5f>
    *     }
    * }
	*/

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   43433:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43437:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   4343e:	48 89 c7             	mov    %rax,%rdi
   43441:	e8 af f7 ff ff       	call   42bf5 <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   43446:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4344a:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   4344e:	48 89 c2             	mov    %rax,%rdx
   43451:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43455:	48 8b 4d 98          	mov    -0x68(%rbp),%rcx
   43459:	48 89 ce             	mov    %rcx,%rsi
   4345c:	48 89 c7             	mov    %rax,%rdi
   4345f:	e8 a0 00 00 00       	call   43504 <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   43464:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43468:	48 2b 45 e0          	sub    -0x20(%rbp),%rax
   4346c:	48 89 c2             	mov    %rax,%rdx
   4346f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43473:	be 00 00 00 00       	mov    $0x0,%esi
   43478:	48 89 c7             	mov    %rax,%rdi
   4347b:	e8 82 01 00 00       	call   43602 <memset>

	// change to readonly permissions
	if ((ph->p_flags & ELF_PFLAG_WRITE) == 0) {
   43480:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   43484:	8b 40 04             	mov    0x4(%rax),%eax
   43487:	83 e0 02             	and    $0x2,%eax
   4348a:	85 c0                	test   %eax,%eax
   4348c:	75 60                	jne    434ee <program_load_segment+0x1b7>
		for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   4348e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43492:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43496:	eb 4c                	jmp    434e4 <program_load_segment+0x1ad>
			vamapping map = virtual_memory_lookup(p->p_pagetable, addr);
   43498:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4349c:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   434a3:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   434a7:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   434ab:	48 89 ce             	mov    %rcx,%rsi
   434ae:	48 89 c7             	mov    %rax,%rdi
   434b1:	e8 36 fc ff ff       	call   430ec <virtual_memory_lookup>
			virtual_memory_map(p->p_pagetable, addr, map.pa, PAGESIZE, PTE_P | PTE_U );
   434b6:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   434ba:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   434be:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   434c5:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   434c9:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   434cf:	b9 00 10 00 00       	mov    $0x1000,%ecx
   434d4:	48 89 c7             	mov    %rax,%rdi
   434d7:	e8 4a f8 ff ff       	call   42d26 <virtual_memory_map>
		for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   434dc:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   434e3:	00 
   434e4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   434e8:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   434ec:	72 aa                	jb     43498 <program_load_segment+0x161>
		}
	}

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   434ee:	48 8b 05 0b 1b 01 00 	mov    0x11b0b(%rip),%rax        # 55000 <kernel_pagetable>
   434f5:	48 89 c7             	mov    %rax,%rdi
   434f8:	e8 f8 f6 ff ff       	call   42bf5 <set_pagetable>
    return 0;
   434fd:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43502:	c9                   	leave  
   43503:	c3                   	ret    

0000000000043504 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   43504:	55                   	push   %rbp
   43505:	48 89 e5             	mov    %rsp,%rbp
   43508:	48 83 ec 28          	sub    $0x28,%rsp
   4350c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43510:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43514:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43518:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4351c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43520:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43524:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43528:	eb 1c                	jmp    43546 <memcpy+0x42>
        *d = *s;
   4352a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4352e:	0f b6 10             	movzbl (%rax),%edx
   43531:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43535:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43537:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   4353c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43541:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   43546:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   4354b:	75 dd                	jne    4352a <memcpy+0x26>
    }
    return dst;
   4354d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43551:	c9                   	leave  
   43552:	c3                   	ret    

0000000000043553 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   43553:	55                   	push   %rbp
   43554:	48 89 e5             	mov    %rsp,%rbp
   43557:	48 83 ec 28          	sub    $0x28,%rsp
   4355b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4355f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43563:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43567:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4356b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   4356f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43573:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   43577:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4357b:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   4357f:	73 6a                	jae    435eb <memmove+0x98>
   43581:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43585:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43589:	48 01 d0             	add    %rdx,%rax
   4358c:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   43590:	73 59                	jae    435eb <memmove+0x98>
        s += n, d += n;
   43592:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43596:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   4359a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4359e:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   435a2:	eb 17                	jmp    435bb <memmove+0x68>
            *--d = *--s;
   435a4:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   435a9:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   435ae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   435b2:	0f b6 10             	movzbl (%rax),%edx
   435b5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435b9:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   435bb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   435bf:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   435c3:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   435c7:	48 85 c0             	test   %rax,%rax
   435ca:	75 d8                	jne    435a4 <memmove+0x51>
    if (s < d && s + n > d) {
   435cc:	eb 2e                	jmp    435fc <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   435ce:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   435d2:	48 8d 42 01          	lea    0x1(%rdx),%rax
   435d6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   435da:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435de:	48 8d 48 01          	lea    0x1(%rax),%rcx
   435e2:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   435e6:	0f b6 12             	movzbl (%rdx),%edx
   435e9:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   435eb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   435ef:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   435f3:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   435f7:	48 85 c0             	test   %rax,%rax
   435fa:	75 d2                	jne    435ce <memmove+0x7b>
        }
    }
    return dst;
   435fc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43600:	c9                   	leave  
   43601:	c3                   	ret    

0000000000043602 <memset>:

void* memset(void* v, int c, size_t n) {
   43602:	55                   	push   %rbp
   43603:	48 89 e5             	mov    %rsp,%rbp
   43606:	48 83 ec 28          	sub    $0x28,%rsp
   4360a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4360e:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   43611:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43615:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43619:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   4361d:	eb 15                	jmp    43634 <memset+0x32>
        *p = c;
   4361f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43622:	89 c2                	mov    %eax,%edx
   43624:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43628:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   4362a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   4362f:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43634:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43639:	75 e4                	jne    4361f <memset+0x1d>
    }
    return v;
   4363b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   4363f:	c9                   	leave  
   43640:	c3                   	ret    

0000000000043641 <strlen>:

size_t strlen(const char* s) {
   43641:	55                   	push   %rbp
   43642:	48 89 e5             	mov    %rsp,%rbp
   43645:	48 83 ec 18          	sub    $0x18,%rsp
   43649:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   4364d:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43654:	00 
   43655:	eb 0a                	jmp    43661 <strlen+0x20>
        ++n;
   43657:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   4365c:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43661:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43665:	0f b6 00             	movzbl (%rax),%eax
   43668:	84 c0                	test   %al,%al
   4366a:	75 eb                	jne    43657 <strlen+0x16>
    }
    return n;
   4366c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43670:	c9                   	leave  
   43671:	c3                   	ret    

0000000000043672 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   43672:	55                   	push   %rbp
   43673:	48 89 e5             	mov    %rsp,%rbp
   43676:	48 83 ec 20          	sub    $0x20,%rsp
   4367a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4367e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43682:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43689:	00 
   4368a:	eb 0a                	jmp    43696 <strnlen+0x24>
        ++n;
   4368c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43691:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43696:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4369a:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   4369e:	74 0b                	je     436ab <strnlen+0x39>
   436a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   436a4:	0f b6 00             	movzbl (%rax),%eax
   436a7:	84 c0                	test   %al,%al
   436a9:	75 e1                	jne    4368c <strnlen+0x1a>
    }
    return n;
   436ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   436af:	c9                   	leave  
   436b0:	c3                   	ret    

00000000000436b1 <strcpy>:

char* strcpy(char* dst, const char* src) {
   436b1:	55                   	push   %rbp
   436b2:	48 89 e5             	mov    %rsp,%rbp
   436b5:	48 83 ec 20          	sub    $0x20,%rsp
   436b9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   436bd:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   436c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   436c5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   436c9:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   436cd:	48 8d 42 01          	lea    0x1(%rdx),%rax
   436d1:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   436d5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   436d9:	48 8d 48 01          	lea    0x1(%rax),%rcx
   436dd:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   436e1:	0f b6 12             	movzbl (%rdx),%edx
   436e4:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   436e6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   436ea:	48 83 e8 01          	sub    $0x1,%rax
   436ee:	0f b6 00             	movzbl (%rax),%eax
   436f1:	84 c0                	test   %al,%al
   436f3:	75 d4                	jne    436c9 <strcpy+0x18>
    return dst;
   436f5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   436f9:	c9                   	leave  
   436fa:	c3                   	ret    

00000000000436fb <strcmp>:

int strcmp(const char* a, const char* b) {
   436fb:	55                   	push   %rbp
   436fc:	48 89 e5             	mov    %rsp,%rbp
   436ff:	48 83 ec 10          	sub    $0x10,%rsp
   43703:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43707:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   4370b:	eb 0a                	jmp    43717 <strcmp+0x1c>
        ++a, ++b;
   4370d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43712:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43717:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4371b:	0f b6 00             	movzbl (%rax),%eax
   4371e:	84 c0                	test   %al,%al
   43720:	74 1d                	je     4373f <strcmp+0x44>
   43722:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43726:	0f b6 00             	movzbl (%rax),%eax
   43729:	84 c0                	test   %al,%al
   4372b:	74 12                	je     4373f <strcmp+0x44>
   4372d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43731:	0f b6 10             	movzbl (%rax),%edx
   43734:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43738:	0f b6 00             	movzbl (%rax),%eax
   4373b:	38 c2                	cmp    %al,%dl
   4373d:	74 ce                	je     4370d <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   4373f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43743:	0f b6 00             	movzbl (%rax),%eax
   43746:	89 c2                	mov    %eax,%edx
   43748:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4374c:	0f b6 00             	movzbl (%rax),%eax
   4374f:	38 d0                	cmp    %dl,%al
   43751:	0f 92 c0             	setb   %al
   43754:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   43757:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4375b:	0f b6 00             	movzbl (%rax),%eax
   4375e:	89 c1                	mov    %eax,%ecx
   43760:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43764:	0f b6 00             	movzbl (%rax),%eax
   43767:	38 c1                	cmp    %al,%cl
   43769:	0f 92 c0             	setb   %al
   4376c:	0f b6 c0             	movzbl %al,%eax
   4376f:	29 c2                	sub    %eax,%edx
   43771:	89 d0                	mov    %edx,%eax
}
   43773:	c9                   	leave  
   43774:	c3                   	ret    

0000000000043775 <strchr>:

char* strchr(const char* s, int c) {
   43775:	55                   	push   %rbp
   43776:	48 89 e5             	mov    %rsp,%rbp
   43779:	48 83 ec 10          	sub    $0x10,%rsp
   4377d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43781:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   43784:	eb 05                	jmp    4378b <strchr+0x16>
        ++s;
   43786:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   4378b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4378f:	0f b6 00             	movzbl (%rax),%eax
   43792:	84 c0                	test   %al,%al
   43794:	74 0e                	je     437a4 <strchr+0x2f>
   43796:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4379a:	0f b6 00             	movzbl (%rax),%eax
   4379d:	8b 55 f4             	mov    -0xc(%rbp),%edx
   437a0:	38 d0                	cmp    %dl,%al
   437a2:	75 e2                	jne    43786 <strchr+0x11>
    }
    if (*s == (char) c) {
   437a4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   437a8:	0f b6 00             	movzbl (%rax),%eax
   437ab:	8b 55 f4             	mov    -0xc(%rbp),%edx
   437ae:	38 d0                	cmp    %dl,%al
   437b0:	75 06                	jne    437b8 <strchr+0x43>
        return (char*) s;
   437b2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   437b6:	eb 05                	jmp    437bd <strchr+0x48>
    } else {
        return NULL;
   437b8:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   437bd:	c9                   	leave  
   437be:	c3                   	ret    

00000000000437bf <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   437bf:	55                   	push   %rbp
   437c0:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   437c3:	8b 05 37 78 01 00    	mov    0x17837(%rip),%eax        # 5b000 <rand_seed_set>
   437c9:	85 c0                	test   %eax,%eax
   437cb:	75 0a                	jne    437d7 <rand+0x18>
        srand(819234718U);
   437cd:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   437d2:	e8 24 00 00 00       	call   437fb <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   437d7:	8b 05 27 78 01 00    	mov    0x17827(%rip),%eax        # 5b004 <rand_seed>
   437dd:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   437e3:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   437e8:	89 05 16 78 01 00    	mov    %eax,0x17816(%rip)        # 5b004 <rand_seed>
    return rand_seed & RAND_MAX;
   437ee:	8b 05 10 78 01 00    	mov    0x17810(%rip),%eax        # 5b004 <rand_seed>
   437f4:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   437f9:	5d                   	pop    %rbp
   437fa:	c3                   	ret    

00000000000437fb <srand>:

void srand(unsigned seed) {
   437fb:	55                   	push   %rbp
   437fc:	48 89 e5             	mov    %rsp,%rbp
   437ff:	48 83 ec 08          	sub    $0x8,%rsp
   43803:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   43806:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43809:	89 05 f5 77 01 00    	mov    %eax,0x177f5(%rip)        # 5b004 <rand_seed>
    rand_seed_set = 1;
   4380f:	c7 05 e7 77 01 00 01 	movl   $0x1,0x177e7(%rip)        # 5b000 <rand_seed_set>
   43816:	00 00 00 
}
   43819:	90                   	nop
   4381a:	c9                   	leave  
   4381b:	c3                   	ret    

000000000004381c <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   4381c:	55                   	push   %rbp
   4381d:	48 89 e5             	mov    %rsp,%rbp
   43820:	48 83 ec 28          	sub    $0x28,%rsp
   43824:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43828:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   4382c:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   4382f:	48 c7 45 f8 c0 52 04 	movq   $0x452c0,-0x8(%rbp)
   43836:	00 
    if (base < 0) {
   43837:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   4383b:	79 0b                	jns    43848 <fill_numbuf+0x2c>
        digits = lower_digits;
   4383d:	48 c7 45 f8 e0 52 04 	movq   $0x452e0,-0x8(%rbp)
   43844:	00 
        base = -base;
   43845:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   43848:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   4384d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43851:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   43854:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43857:	48 63 c8             	movslq %eax,%rcx
   4385a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4385e:	ba 00 00 00 00       	mov    $0x0,%edx
   43863:	48 f7 f1             	div    %rcx
   43866:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4386a:	48 01 d0             	add    %rdx,%rax
   4386d:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43872:	0f b6 10             	movzbl (%rax),%edx
   43875:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43879:	88 10                	mov    %dl,(%rax)
        val /= base;
   4387b:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4387e:	48 63 f0             	movslq %eax,%rsi
   43881:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43885:	ba 00 00 00 00       	mov    $0x0,%edx
   4388a:	48 f7 f6             	div    %rsi
   4388d:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   43891:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43896:	75 bc                	jne    43854 <fill_numbuf+0x38>
    return numbuf_end;
   43898:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   4389c:	c9                   	leave  
   4389d:	c3                   	ret    

000000000004389e <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   4389e:	55                   	push   %rbp
   4389f:	48 89 e5             	mov    %rsp,%rbp
   438a2:	53                   	push   %rbx
   438a3:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   438aa:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   438b1:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   438b7:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   438be:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   438c5:	e9 8a 09 00 00       	jmp    44254 <printer_vprintf+0x9b6>
        if (*format != '%') {
   438ca:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   438d1:	0f b6 00             	movzbl (%rax),%eax
   438d4:	3c 25                	cmp    $0x25,%al
   438d6:	74 31                	je     43909 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
   438d8:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   438df:	4c 8b 00             	mov    (%rax),%r8
   438e2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   438e9:	0f b6 00             	movzbl (%rax),%eax
   438ec:	0f b6 c8             	movzbl %al,%ecx
   438ef:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   438f5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   438fc:	89 ce                	mov    %ecx,%esi
   438fe:	48 89 c7             	mov    %rax,%rdi
   43901:	41 ff d0             	call   *%r8
            continue;
   43904:	e9 43 09 00 00       	jmp    4424c <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
   43909:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   43910:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43917:	01 
   43918:	eb 44                	jmp    4395e <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
   4391a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43921:	0f b6 00             	movzbl (%rax),%eax
   43924:	0f be c0             	movsbl %al,%eax
   43927:	89 c6                	mov    %eax,%esi
   43929:	bf e0 50 04 00       	mov    $0x450e0,%edi
   4392e:	e8 42 fe ff ff       	call   43775 <strchr>
   43933:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   43937:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   4393c:	74 30                	je     4396e <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
   4393e:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   43942:	48 2d e0 50 04 00    	sub    $0x450e0,%rax
   43948:	ba 01 00 00 00       	mov    $0x1,%edx
   4394d:	89 c1                	mov    %eax,%ecx
   4394f:	d3 e2                	shl    %cl,%edx
   43951:	89 d0                	mov    %edx,%eax
   43953:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   43956:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4395d:	01 
   4395e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43965:	0f b6 00             	movzbl (%rax),%eax
   43968:	84 c0                	test   %al,%al
   4396a:	75 ae                	jne    4391a <printer_vprintf+0x7c>
   4396c:	eb 01                	jmp    4396f <printer_vprintf+0xd1>
            } else {
                break;
   4396e:	90                   	nop
            }
        }

        // process width
        int width = -1;
   4396f:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   43976:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4397d:	0f b6 00             	movzbl (%rax),%eax
   43980:	3c 30                	cmp    $0x30,%al
   43982:	7e 67                	jle    439eb <printer_vprintf+0x14d>
   43984:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4398b:	0f b6 00             	movzbl (%rax),%eax
   4398e:	3c 39                	cmp    $0x39,%al
   43990:	7f 59                	jg     439eb <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43992:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   43999:	eb 2e                	jmp    439c9 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
   4399b:	8b 55 e8             	mov    -0x18(%rbp),%edx
   4399e:	89 d0                	mov    %edx,%eax
   439a0:	c1 e0 02             	shl    $0x2,%eax
   439a3:	01 d0                	add    %edx,%eax
   439a5:	01 c0                	add    %eax,%eax
   439a7:	89 c1                	mov    %eax,%ecx
   439a9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   439b0:	48 8d 50 01          	lea    0x1(%rax),%rdx
   439b4:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   439bb:	0f b6 00             	movzbl (%rax),%eax
   439be:	0f be c0             	movsbl %al,%eax
   439c1:	01 c8                	add    %ecx,%eax
   439c3:	83 e8 30             	sub    $0x30,%eax
   439c6:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   439c9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   439d0:	0f b6 00             	movzbl (%rax),%eax
   439d3:	3c 2f                	cmp    $0x2f,%al
   439d5:	0f 8e 85 00 00 00    	jle    43a60 <printer_vprintf+0x1c2>
   439db:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   439e2:	0f b6 00             	movzbl (%rax),%eax
   439e5:	3c 39                	cmp    $0x39,%al
   439e7:	7e b2                	jle    4399b <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
   439e9:	eb 75                	jmp    43a60 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
   439eb:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   439f2:	0f b6 00             	movzbl (%rax),%eax
   439f5:	3c 2a                	cmp    $0x2a,%al
   439f7:	75 68                	jne    43a61 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
   439f9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a00:	8b 00                	mov    (%rax),%eax
   43a02:	83 f8 2f             	cmp    $0x2f,%eax
   43a05:	77 30                	ja     43a37 <printer_vprintf+0x199>
   43a07:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a0e:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43a12:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a19:	8b 00                	mov    (%rax),%eax
   43a1b:	89 c0                	mov    %eax,%eax
   43a1d:	48 01 d0             	add    %rdx,%rax
   43a20:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43a27:	8b 12                	mov    (%rdx),%edx
   43a29:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43a2c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43a33:	89 0a                	mov    %ecx,(%rdx)
   43a35:	eb 1a                	jmp    43a51 <printer_vprintf+0x1b3>
   43a37:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a3e:	48 8b 40 08          	mov    0x8(%rax),%rax
   43a42:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43a46:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43a4d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43a51:	8b 00                	mov    (%rax),%eax
   43a53:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   43a56:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43a5d:	01 
   43a5e:	eb 01                	jmp    43a61 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
   43a60:	90                   	nop
        }

        // process precision
        int precision = -1;
   43a61:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   43a68:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43a6f:	0f b6 00             	movzbl (%rax),%eax
   43a72:	3c 2e                	cmp    $0x2e,%al
   43a74:	0f 85 00 01 00 00    	jne    43b7a <printer_vprintf+0x2dc>
            ++format;
   43a7a:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43a81:	01 
            if (*format >= '0' && *format <= '9') {
   43a82:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43a89:	0f b6 00             	movzbl (%rax),%eax
   43a8c:	3c 2f                	cmp    $0x2f,%al
   43a8e:	7e 67                	jle    43af7 <printer_vprintf+0x259>
   43a90:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43a97:	0f b6 00             	movzbl (%rax),%eax
   43a9a:	3c 39                	cmp    $0x39,%al
   43a9c:	7f 59                	jg     43af7 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43a9e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   43aa5:	eb 2e                	jmp    43ad5 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
   43aa7:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   43aaa:	89 d0                	mov    %edx,%eax
   43aac:	c1 e0 02             	shl    $0x2,%eax
   43aaf:	01 d0                	add    %edx,%eax
   43ab1:	01 c0                	add    %eax,%eax
   43ab3:	89 c1                	mov    %eax,%ecx
   43ab5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43abc:	48 8d 50 01          	lea    0x1(%rax),%rdx
   43ac0:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43ac7:	0f b6 00             	movzbl (%rax),%eax
   43aca:	0f be c0             	movsbl %al,%eax
   43acd:	01 c8                	add    %ecx,%eax
   43acf:	83 e8 30             	sub    $0x30,%eax
   43ad2:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43ad5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43adc:	0f b6 00             	movzbl (%rax),%eax
   43adf:	3c 2f                	cmp    $0x2f,%al
   43ae1:	0f 8e 85 00 00 00    	jle    43b6c <printer_vprintf+0x2ce>
   43ae7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43aee:	0f b6 00             	movzbl (%rax),%eax
   43af1:	3c 39                	cmp    $0x39,%al
   43af3:	7e b2                	jle    43aa7 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
   43af5:	eb 75                	jmp    43b6c <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
   43af7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43afe:	0f b6 00             	movzbl (%rax),%eax
   43b01:	3c 2a                	cmp    $0x2a,%al
   43b03:	75 68                	jne    43b6d <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
   43b05:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b0c:	8b 00                	mov    (%rax),%eax
   43b0e:	83 f8 2f             	cmp    $0x2f,%eax
   43b11:	77 30                	ja     43b43 <printer_vprintf+0x2a5>
   43b13:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b1a:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43b1e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b25:	8b 00                	mov    (%rax),%eax
   43b27:	89 c0                	mov    %eax,%eax
   43b29:	48 01 d0             	add    %rdx,%rax
   43b2c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43b33:	8b 12                	mov    (%rdx),%edx
   43b35:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43b38:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43b3f:	89 0a                	mov    %ecx,(%rdx)
   43b41:	eb 1a                	jmp    43b5d <printer_vprintf+0x2bf>
   43b43:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b4a:	48 8b 40 08          	mov    0x8(%rax),%rax
   43b4e:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43b52:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43b59:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43b5d:	8b 00                	mov    (%rax),%eax
   43b5f:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   43b62:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43b69:	01 
   43b6a:	eb 01                	jmp    43b6d <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
   43b6c:	90                   	nop
            }
            if (precision < 0) {
   43b6d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   43b71:	79 07                	jns    43b7a <printer_vprintf+0x2dc>
                precision = 0;
   43b73:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   43b7a:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   43b81:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   43b88:	00 
        int length = 0;
   43b89:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   43b90:	48 c7 45 c8 e6 50 04 	movq   $0x450e6,-0x38(%rbp)
   43b97:	00 
    again:
        switch (*format) {
   43b98:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43b9f:	0f b6 00             	movzbl (%rax),%eax
   43ba2:	0f be c0             	movsbl %al,%eax
   43ba5:	83 e8 43             	sub    $0x43,%eax
   43ba8:	83 f8 37             	cmp    $0x37,%eax
   43bab:	0f 87 9f 03 00 00    	ja     43f50 <printer_vprintf+0x6b2>
   43bb1:	89 c0                	mov    %eax,%eax
   43bb3:	48 8b 04 c5 f8 50 04 	mov    0x450f8(,%rax,8),%rax
   43bba:	00 
   43bbb:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
   43bbd:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   43bc4:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43bcb:	01 
            goto again;
   43bcc:	eb ca                	jmp    43b98 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   43bce:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43bd2:	74 5d                	je     43c31 <printer_vprintf+0x393>
   43bd4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43bdb:	8b 00                	mov    (%rax),%eax
   43bdd:	83 f8 2f             	cmp    $0x2f,%eax
   43be0:	77 30                	ja     43c12 <printer_vprintf+0x374>
   43be2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43be9:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43bed:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43bf4:	8b 00                	mov    (%rax),%eax
   43bf6:	89 c0                	mov    %eax,%eax
   43bf8:	48 01 d0             	add    %rdx,%rax
   43bfb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c02:	8b 12                	mov    (%rdx),%edx
   43c04:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43c07:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c0e:	89 0a                	mov    %ecx,(%rdx)
   43c10:	eb 1a                	jmp    43c2c <printer_vprintf+0x38e>
   43c12:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c19:	48 8b 40 08          	mov    0x8(%rax),%rax
   43c1d:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43c21:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c28:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43c2c:	48 8b 00             	mov    (%rax),%rax
   43c2f:	eb 5c                	jmp    43c8d <printer_vprintf+0x3ef>
   43c31:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c38:	8b 00                	mov    (%rax),%eax
   43c3a:	83 f8 2f             	cmp    $0x2f,%eax
   43c3d:	77 30                	ja     43c6f <printer_vprintf+0x3d1>
   43c3f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c46:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43c4a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c51:	8b 00                	mov    (%rax),%eax
   43c53:	89 c0                	mov    %eax,%eax
   43c55:	48 01 d0             	add    %rdx,%rax
   43c58:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c5f:	8b 12                	mov    (%rdx),%edx
   43c61:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43c64:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c6b:	89 0a                	mov    %ecx,(%rdx)
   43c6d:	eb 1a                	jmp    43c89 <printer_vprintf+0x3eb>
   43c6f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c76:	48 8b 40 08          	mov    0x8(%rax),%rax
   43c7a:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43c7e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c85:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43c89:	8b 00                	mov    (%rax),%eax
   43c8b:	48 98                	cltq   
   43c8d:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   43c91:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43c95:	48 c1 f8 38          	sar    $0x38,%rax
   43c99:	25 80 00 00 00       	and    $0x80,%eax
   43c9e:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   43ca1:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   43ca5:	74 09                	je     43cb0 <printer_vprintf+0x412>
   43ca7:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43cab:	48 f7 d8             	neg    %rax
   43cae:	eb 04                	jmp    43cb4 <printer_vprintf+0x416>
   43cb0:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43cb4:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   43cb8:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   43cbb:	83 c8 60             	or     $0x60,%eax
   43cbe:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   43cc1:	e9 cf 02 00 00       	jmp    43f95 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   43cc6:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43cca:	74 5d                	je     43d29 <printer_vprintf+0x48b>
   43ccc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43cd3:	8b 00                	mov    (%rax),%eax
   43cd5:	83 f8 2f             	cmp    $0x2f,%eax
   43cd8:	77 30                	ja     43d0a <printer_vprintf+0x46c>
   43cda:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ce1:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43ce5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43cec:	8b 00                	mov    (%rax),%eax
   43cee:	89 c0                	mov    %eax,%eax
   43cf0:	48 01 d0             	add    %rdx,%rax
   43cf3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43cfa:	8b 12                	mov    (%rdx),%edx
   43cfc:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43cff:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d06:	89 0a                	mov    %ecx,(%rdx)
   43d08:	eb 1a                	jmp    43d24 <printer_vprintf+0x486>
   43d0a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d11:	48 8b 40 08          	mov    0x8(%rax),%rax
   43d15:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43d19:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d20:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43d24:	48 8b 00             	mov    (%rax),%rax
   43d27:	eb 5c                	jmp    43d85 <printer_vprintf+0x4e7>
   43d29:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d30:	8b 00                	mov    (%rax),%eax
   43d32:	83 f8 2f             	cmp    $0x2f,%eax
   43d35:	77 30                	ja     43d67 <printer_vprintf+0x4c9>
   43d37:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d3e:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43d42:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d49:	8b 00                	mov    (%rax),%eax
   43d4b:	89 c0                	mov    %eax,%eax
   43d4d:	48 01 d0             	add    %rdx,%rax
   43d50:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d57:	8b 12                	mov    (%rdx),%edx
   43d59:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43d5c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d63:	89 0a                	mov    %ecx,(%rdx)
   43d65:	eb 1a                	jmp    43d81 <printer_vprintf+0x4e3>
   43d67:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d6e:	48 8b 40 08          	mov    0x8(%rax),%rax
   43d72:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43d76:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d7d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43d81:	8b 00                	mov    (%rax),%eax
   43d83:	89 c0                	mov    %eax,%eax
   43d85:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   43d89:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   43d8d:	e9 03 02 00 00       	jmp    43f95 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
   43d92:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   43d99:	e9 28 ff ff ff       	jmp    43cc6 <printer_vprintf+0x428>
        case 'X':
            base = 16;
   43d9e:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   43da5:	e9 1c ff ff ff       	jmp    43cc6 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   43daa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43db1:	8b 00                	mov    (%rax),%eax
   43db3:	83 f8 2f             	cmp    $0x2f,%eax
   43db6:	77 30                	ja     43de8 <printer_vprintf+0x54a>
   43db8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43dbf:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43dc3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43dca:	8b 00                	mov    (%rax),%eax
   43dcc:	89 c0                	mov    %eax,%eax
   43dce:	48 01 d0             	add    %rdx,%rax
   43dd1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43dd8:	8b 12                	mov    (%rdx),%edx
   43dda:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43ddd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43de4:	89 0a                	mov    %ecx,(%rdx)
   43de6:	eb 1a                	jmp    43e02 <printer_vprintf+0x564>
   43de8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43def:	48 8b 40 08          	mov    0x8(%rax),%rax
   43df3:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43df7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43dfe:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43e02:	48 8b 00             	mov    (%rax),%rax
   43e05:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   43e09:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   43e10:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   43e17:	e9 79 01 00 00       	jmp    43f95 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
   43e1c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e23:	8b 00                	mov    (%rax),%eax
   43e25:	83 f8 2f             	cmp    $0x2f,%eax
   43e28:	77 30                	ja     43e5a <printer_vprintf+0x5bc>
   43e2a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e31:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43e35:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e3c:	8b 00                	mov    (%rax),%eax
   43e3e:	89 c0                	mov    %eax,%eax
   43e40:	48 01 d0             	add    %rdx,%rax
   43e43:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e4a:	8b 12                	mov    (%rdx),%edx
   43e4c:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43e4f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e56:	89 0a                	mov    %ecx,(%rdx)
   43e58:	eb 1a                	jmp    43e74 <printer_vprintf+0x5d6>
   43e5a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e61:	48 8b 40 08          	mov    0x8(%rax),%rax
   43e65:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43e69:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e70:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43e74:	48 8b 00             	mov    (%rax),%rax
   43e77:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   43e7b:	e9 15 01 00 00       	jmp    43f95 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
   43e80:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e87:	8b 00                	mov    (%rax),%eax
   43e89:	83 f8 2f             	cmp    $0x2f,%eax
   43e8c:	77 30                	ja     43ebe <printer_vprintf+0x620>
   43e8e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e95:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43e99:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ea0:	8b 00                	mov    (%rax),%eax
   43ea2:	89 c0                	mov    %eax,%eax
   43ea4:	48 01 d0             	add    %rdx,%rax
   43ea7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43eae:	8b 12                	mov    (%rdx),%edx
   43eb0:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43eb3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43eba:	89 0a                	mov    %ecx,(%rdx)
   43ebc:	eb 1a                	jmp    43ed8 <printer_vprintf+0x63a>
   43ebe:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ec5:	48 8b 40 08          	mov    0x8(%rax),%rax
   43ec9:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43ecd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43ed4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43ed8:	8b 00                	mov    (%rax),%eax
   43eda:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   43ee0:	e9 67 03 00 00       	jmp    4424c <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
   43ee5:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43ee9:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   43eed:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ef4:	8b 00                	mov    (%rax),%eax
   43ef6:	83 f8 2f             	cmp    $0x2f,%eax
   43ef9:	77 30                	ja     43f2b <printer_vprintf+0x68d>
   43efb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f02:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43f06:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f0d:	8b 00                	mov    (%rax),%eax
   43f0f:	89 c0                	mov    %eax,%eax
   43f11:	48 01 d0             	add    %rdx,%rax
   43f14:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f1b:	8b 12                	mov    (%rdx),%edx
   43f1d:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43f20:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f27:	89 0a                	mov    %ecx,(%rdx)
   43f29:	eb 1a                	jmp    43f45 <printer_vprintf+0x6a7>
   43f2b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f32:	48 8b 40 08          	mov    0x8(%rax),%rax
   43f36:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43f3a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f41:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43f45:	8b 00                	mov    (%rax),%eax
   43f47:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   43f4a:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   43f4e:	eb 45                	jmp    43f95 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
   43f50:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43f54:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   43f58:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f5f:	0f b6 00             	movzbl (%rax),%eax
   43f62:	84 c0                	test   %al,%al
   43f64:	74 0c                	je     43f72 <printer_vprintf+0x6d4>
   43f66:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f6d:	0f b6 00             	movzbl (%rax),%eax
   43f70:	eb 05                	jmp    43f77 <printer_vprintf+0x6d9>
   43f72:	b8 25 00 00 00       	mov    $0x25,%eax
   43f77:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   43f7a:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   43f7e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f85:	0f b6 00             	movzbl (%rax),%eax
   43f88:	84 c0                	test   %al,%al
   43f8a:	75 08                	jne    43f94 <printer_vprintf+0x6f6>
                format--;
   43f8c:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   43f93:	01 
            }
            break;
   43f94:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   43f95:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43f98:	83 e0 20             	and    $0x20,%eax
   43f9b:	85 c0                	test   %eax,%eax
   43f9d:	74 1e                	je     43fbd <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   43f9f:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43fa3:	48 83 c0 18          	add    $0x18,%rax
   43fa7:	8b 55 e0             	mov    -0x20(%rbp),%edx
   43faa:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   43fae:	48 89 ce             	mov    %rcx,%rsi
   43fb1:	48 89 c7             	mov    %rax,%rdi
   43fb4:	e8 63 f8 ff ff       	call   4381c <fill_numbuf>
   43fb9:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   43fbd:	48 c7 45 c0 e6 50 04 	movq   $0x450e6,-0x40(%rbp)
   43fc4:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   43fc5:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43fc8:	83 e0 20             	and    $0x20,%eax
   43fcb:	85 c0                	test   %eax,%eax
   43fcd:	74 48                	je     44017 <printer_vprintf+0x779>
   43fcf:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43fd2:	83 e0 40             	and    $0x40,%eax
   43fd5:	85 c0                	test   %eax,%eax
   43fd7:	74 3e                	je     44017 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
   43fd9:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43fdc:	25 80 00 00 00       	and    $0x80,%eax
   43fe1:	85 c0                	test   %eax,%eax
   43fe3:	74 0a                	je     43fef <printer_vprintf+0x751>
                prefix = "-";
   43fe5:	48 c7 45 c0 e7 50 04 	movq   $0x450e7,-0x40(%rbp)
   43fec:	00 
            if (flags & FLAG_NEGATIVE) {
   43fed:	eb 73                	jmp    44062 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   43fef:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43ff2:	83 e0 10             	and    $0x10,%eax
   43ff5:	85 c0                	test   %eax,%eax
   43ff7:	74 0a                	je     44003 <printer_vprintf+0x765>
                prefix = "+";
   43ff9:	48 c7 45 c0 e9 50 04 	movq   $0x450e9,-0x40(%rbp)
   44000:	00 
            if (flags & FLAG_NEGATIVE) {
   44001:	eb 5f                	jmp    44062 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   44003:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44006:	83 e0 08             	and    $0x8,%eax
   44009:	85 c0                	test   %eax,%eax
   4400b:	74 55                	je     44062 <printer_vprintf+0x7c4>
                prefix = " ";
   4400d:	48 c7 45 c0 eb 50 04 	movq   $0x450eb,-0x40(%rbp)
   44014:	00 
            if (flags & FLAG_NEGATIVE) {
   44015:	eb 4b                	jmp    44062 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   44017:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4401a:	83 e0 20             	and    $0x20,%eax
   4401d:	85 c0                	test   %eax,%eax
   4401f:	74 42                	je     44063 <printer_vprintf+0x7c5>
   44021:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44024:	83 e0 01             	and    $0x1,%eax
   44027:	85 c0                	test   %eax,%eax
   44029:	74 38                	je     44063 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
   4402b:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   4402f:	74 06                	je     44037 <printer_vprintf+0x799>
   44031:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   44035:	75 2c                	jne    44063 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
   44037:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   4403c:	75 0c                	jne    4404a <printer_vprintf+0x7ac>
   4403e:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44041:	25 00 01 00 00       	and    $0x100,%eax
   44046:	85 c0                	test   %eax,%eax
   44048:	74 19                	je     44063 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
   4404a:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   4404e:	75 07                	jne    44057 <printer_vprintf+0x7b9>
   44050:	b8 ed 50 04 00       	mov    $0x450ed,%eax
   44055:	eb 05                	jmp    4405c <printer_vprintf+0x7be>
   44057:	b8 f0 50 04 00       	mov    $0x450f0,%eax
   4405c:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   44060:	eb 01                	jmp    44063 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
   44062:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   44063:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   44067:	78 24                	js     4408d <printer_vprintf+0x7ef>
   44069:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4406c:	83 e0 20             	and    $0x20,%eax
   4406f:	85 c0                	test   %eax,%eax
   44071:	75 1a                	jne    4408d <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
   44073:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44076:	48 63 d0             	movslq %eax,%rdx
   44079:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4407d:	48 89 d6             	mov    %rdx,%rsi
   44080:	48 89 c7             	mov    %rax,%rdi
   44083:	e8 ea f5 ff ff       	call   43672 <strnlen>
   44088:	89 45 bc             	mov    %eax,-0x44(%rbp)
   4408b:	eb 0f                	jmp    4409c <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
   4408d:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44091:	48 89 c7             	mov    %rax,%rdi
   44094:	e8 a8 f5 ff ff       	call   43641 <strlen>
   44099:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   4409c:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4409f:	83 e0 20             	and    $0x20,%eax
   440a2:	85 c0                	test   %eax,%eax
   440a4:	74 20                	je     440c6 <printer_vprintf+0x828>
   440a6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   440aa:	78 1a                	js     440c6 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
   440ac:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   440af:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   440b2:	7e 08                	jle    440bc <printer_vprintf+0x81e>
   440b4:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   440b7:	2b 45 bc             	sub    -0x44(%rbp),%eax
   440ba:	eb 05                	jmp    440c1 <printer_vprintf+0x823>
   440bc:	b8 00 00 00 00       	mov    $0x0,%eax
   440c1:	89 45 b8             	mov    %eax,-0x48(%rbp)
   440c4:	eb 5c                	jmp    44122 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   440c6:	8b 45 ec             	mov    -0x14(%rbp),%eax
   440c9:	83 e0 20             	and    $0x20,%eax
   440cc:	85 c0                	test   %eax,%eax
   440ce:	74 4b                	je     4411b <printer_vprintf+0x87d>
   440d0:	8b 45 ec             	mov    -0x14(%rbp),%eax
   440d3:	83 e0 02             	and    $0x2,%eax
   440d6:	85 c0                	test   %eax,%eax
   440d8:	74 41                	je     4411b <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
   440da:	8b 45 ec             	mov    -0x14(%rbp),%eax
   440dd:	83 e0 04             	and    $0x4,%eax
   440e0:	85 c0                	test   %eax,%eax
   440e2:	75 37                	jne    4411b <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
   440e4:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   440e8:	48 89 c7             	mov    %rax,%rdi
   440eb:	e8 51 f5 ff ff       	call   43641 <strlen>
   440f0:	89 c2                	mov    %eax,%edx
   440f2:	8b 45 bc             	mov    -0x44(%rbp),%eax
   440f5:	01 d0                	add    %edx,%eax
   440f7:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   440fa:	7e 1f                	jle    4411b <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
   440fc:	8b 45 e8             	mov    -0x18(%rbp),%eax
   440ff:	2b 45 bc             	sub    -0x44(%rbp),%eax
   44102:	89 c3                	mov    %eax,%ebx
   44104:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44108:	48 89 c7             	mov    %rax,%rdi
   4410b:	e8 31 f5 ff ff       	call   43641 <strlen>
   44110:	89 c2                	mov    %eax,%edx
   44112:	89 d8                	mov    %ebx,%eax
   44114:	29 d0                	sub    %edx,%eax
   44116:	89 45 b8             	mov    %eax,-0x48(%rbp)
   44119:	eb 07                	jmp    44122 <printer_vprintf+0x884>
        } else {
            zeros = 0;
   4411b:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   44122:	8b 55 bc             	mov    -0x44(%rbp),%edx
   44125:	8b 45 b8             	mov    -0x48(%rbp),%eax
   44128:	01 d0                	add    %edx,%eax
   4412a:	48 63 d8             	movslq %eax,%rbx
   4412d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44131:	48 89 c7             	mov    %rax,%rdi
   44134:	e8 08 f5 ff ff       	call   43641 <strlen>
   44139:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   4413d:	8b 45 e8             	mov    -0x18(%rbp),%eax
   44140:	29 d0                	sub    %edx,%eax
   44142:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   44145:	eb 25                	jmp    4416c <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
   44147:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4414e:	48 8b 08             	mov    (%rax),%rcx
   44151:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44157:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4415e:	be 20 00 00 00       	mov    $0x20,%esi
   44163:	48 89 c7             	mov    %rax,%rdi
   44166:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   44168:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   4416c:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4416f:	83 e0 04             	and    $0x4,%eax
   44172:	85 c0                	test   %eax,%eax
   44174:	75 36                	jne    441ac <printer_vprintf+0x90e>
   44176:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   4417a:	7f cb                	jg     44147 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
   4417c:	eb 2e                	jmp    441ac <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
   4417e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44185:	4c 8b 00             	mov    (%rax),%r8
   44188:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4418c:	0f b6 00             	movzbl (%rax),%eax
   4418f:	0f b6 c8             	movzbl %al,%ecx
   44192:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44198:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4419f:	89 ce                	mov    %ecx,%esi
   441a1:	48 89 c7             	mov    %rax,%rdi
   441a4:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   441a7:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   441ac:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   441b0:	0f b6 00             	movzbl (%rax),%eax
   441b3:	84 c0                	test   %al,%al
   441b5:	75 c7                	jne    4417e <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
   441b7:	eb 25                	jmp    441de <printer_vprintf+0x940>
            p->putc(p, '0', color);
   441b9:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   441c0:	48 8b 08             	mov    (%rax),%rcx
   441c3:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   441c9:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   441d0:	be 30 00 00 00       	mov    $0x30,%esi
   441d5:	48 89 c7             	mov    %rax,%rdi
   441d8:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   441da:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   441de:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   441e2:	7f d5                	jg     441b9 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
   441e4:	eb 32                	jmp    44218 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
   441e6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   441ed:	4c 8b 00             	mov    (%rax),%r8
   441f0:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   441f4:	0f b6 00             	movzbl (%rax),%eax
   441f7:	0f b6 c8             	movzbl %al,%ecx
   441fa:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44200:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44207:	89 ce                	mov    %ecx,%esi
   44209:	48 89 c7             	mov    %rax,%rdi
   4420c:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   4420f:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   44214:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   44218:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   4421c:	7f c8                	jg     441e6 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
   4421e:	eb 25                	jmp    44245 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
   44220:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44227:	48 8b 08             	mov    (%rax),%rcx
   4422a:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44230:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44237:	be 20 00 00 00       	mov    $0x20,%esi
   4423c:	48 89 c7             	mov    %rax,%rdi
   4423f:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   44241:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   44245:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   44249:	7f d5                	jg     44220 <printer_vprintf+0x982>
        }
    done: ;
   4424b:	90                   	nop
    for (; *format; ++format) {
   4424c:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44253:	01 
   44254:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4425b:	0f b6 00             	movzbl (%rax),%eax
   4425e:	84 c0                	test   %al,%al
   44260:	0f 85 64 f6 ff ff    	jne    438ca <printer_vprintf+0x2c>
    }
}
   44266:	90                   	nop
   44267:	90                   	nop
   44268:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   4426c:	c9                   	leave  
   4426d:	c3                   	ret    

000000000004426e <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   4426e:	55                   	push   %rbp
   4426f:	48 89 e5             	mov    %rsp,%rbp
   44272:	48 83 ec 20          	sub    $0x20,%rsp
   44276:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4427a:	89 f0                	mov    %esi,%eax
   4427c:	89 55 e0             	mov    %edx,-0x20(%rbp)
   4427f:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   44282:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44286:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   4428a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4428e:	48 8b 40 08          	mov    0x8(%rax),%rax
   44292:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
   44297:	48 39 d0             	cmp    %rdx,%rax
   4429a:	72 0c                	jb     442a8 <console_putc+0x3a>
        cp->cursor = console;
   4429c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   442a0:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
   442a7:	00 
    }
    if (c == '\n') {
   442a8:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   442ac:	75 78                	jne    44326 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
   442ae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   442b2:	48 8b 40 08          	mov    0x8(%rax),%rax
   442b6:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   442bc:	48 d1 f8             	sar    %rax
   442bf:	48 89 c1             	mov    %rax,%rcx
   442c2:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   442c9:	66 66 66 
   442cc:	48 89 c8             	mov    %rcx,%rax
   442cf:	48 f7 ea             	imul   %rdx
   442d2:	48 c1 fa 05          	sar    $0x5,%rdx
   442d6:	48 89 c8             	mov    %rcx,%rax
   442d9:	48 c1 f8 3f          	sar    $0x3f,%rax
   442dd:	48 29 c2             	sub    %rax,%rdx
   442e0:	48 89 d0             	mov    %rdx,%rax
   442e3:	48 c1 e0 02          	shl    $0x2,%rax
   442e7:	48 01 d0             	add    %rdx,%rax
   442ea:	48 c1 e0 04          	shl    $0x4,%rax
   442ee:	48 29 c1             	sub    %rax,%rcx
   442f1:	48 89 ca             	mov    %rcx,%rdx
   442f4:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   442f7:	eb 25                	jmp    4431e <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
   442f9:	8b 45 e0             	mov    -0x20(%rbp),%eax
   442fc:	83 c8 20             	or     $0x20,%eax
   442ff:	89 c6                	mov    %eax,%esi
   44301:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44305:	48 8b 40 08          	mov    0x8(%rax),%rax
   44309:	48 8d 48 02          	lea    0x2(%rax),%rcx
   4430d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   44311:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44315:	89 f2                	mov    %esi,%edx
   44317:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   4431a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4431e:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   44322:	75 d5                	jne    442f9 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   44324:	eb 24                	jmp    4434a <console_putc+0xdc>
        *cp->cursor++ = c | color;
   44326:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
   4432a:	8b 55 e0             	mov    -0x20(%rbp),%edx
   4432d:	09 d0                	or     %edx,%eax
   4432f:	89 c6                	mov    %eax,%esi
   44331:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44335:	48 8b 40 08          	mov    0x8(%rax),%rax
   44339:	48 8d 48 02          	lea    0x2(%rax),%rcx
   4433d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   44341:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44345:	89 f2                	mov    %esi,%edx
   44347:	66 89 10             	mov    %dx,(%rax)
}
   4434a:	90                   	nop
   4434b:	c9                   	leave  
   4434c:	c3                   	ret    

000000000004434d <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   4434d:	55                   	push   %rbp
   4434e:	48 89 e5             	mov    %rsp,%rbp
   44351:	48 83 ec 30          	sub    $0x30,%rsp
   44355:	89 7d ec             	mov    %edi,-0x14(%rbp)
   44358:	89 75 e8             	mov    %esi,-0x18(%rbp)
   4435b:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   4435f:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   44363:	48 c7 45 f0 6e 42 04 	movq   $0x4426e,-0x10(%rbp)
   4436a:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   4436b:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   4436f:	78 09                	js     4437a <console_vprintf+0x2d>
   44371:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   44378:	7e 07                	jle    44381 <console_vprintf+0x34>
        cpos = 0;
   4437a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   44381:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44384:	48 98                	cltq   
   44386:	48 01 c0             	add    %rax,%rax
   44389:	48 05 00 80 0b 00    	add    $0xb8000,%rax
   4438f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   44393:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   44397:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   4439b:	8b 75 e8             	mov    -0x18(%rbp),%esi
   4439e:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   443a2:	48 89 c7             	mov    %rax,%rdi
   443a5:	e8 f4 f4 ff ff       	call   4389e <printer_vprintf>
    return cp.cursor - console;
   443aa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   443ae:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   443b4:	48 d1 f8             	sar    %rax
}
   443b7:	c9                   	leave  
   443b8:	c3                   	ret    

00000000000443b9 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   443b9:	55                   	push   %rbp
   443ba:	48 89 e5             	mov    %rsp,%rbp
   443bd:	48 83 ec 60          	sub    $0x60,%rsp
   443c1:	89 7d ac             	mov    %edi,-0x54(%rbp)
   443c4:	89 75 a8             	mov    %esi,-0x58(%rbp)
   443c7:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   443cb:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   443cf:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   443d3:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   443d7:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   443de:	48 8d 45 10          	lea    0x10(%rbp),%rax
   443e2:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   443e6:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   443ea:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   443ee:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   443f2:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   443f6:	8b 75 a8             	mov    -0x58(%rbp),%esi
   443f9:	8b 45 ac             	mov    -0x54(%rbp),%eax
   443fc:	89 c7                	mov    %eax,%edi
   443fe:	e8 4a ff ff ff       	call   4434d <console_vprintf>
   44403:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   44406:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   44409:	c9                   	leave  
   4440a:	c3                   	ret    

000000000004440b <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   4440b:	55                   	push   %rbp
   4440c:	48 89 e5             	mov    %rsp,%rbp
   4440f:	48 83 ec 20          	sub    $0x20,%rsp
   44413:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44417:	89 f0                	mov    %esi,%eax
   44419:	89 55 e0             	mov    %edx,-0x20(%rbp)
   4441c:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   4441f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44423:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   44427:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4442b:	48 8b 50 08          	mov    0x8(%rax),%rdx
   4442f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44433:	48 8b 40 10          	mov    0x10(%rax),%rax
   44437:	48 39 c2             	cmp    %rax,%rdx
   4443a:	73 1a                	jae    44456 <string_putc+0x4b>
        *sp->s++ = c;
   4443c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44440:	48 8b 40 08          	mov    0x8(%rax),%rax
   44444:	48 8d 48 01          	lea    0x1(%rax),%rcx
   44448:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4444c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44450:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   44454:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   44456:	90                   	nop
   44457:	c9                   	leave  
   44458:	c3                   	ret    

0000000000044459 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   44459:	55                   	push   %rbp
   4445a:	48 89 e5             	mov    %rsp,%rbp
   4445d:	48 83 ec 40          	sub    $0x40,%rsp
   44461:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   44465:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   44469:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   4446d:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   44471:	48 c7 45 e8 0b 44 04 	movq   $0x4440b,-0x18(%rbp)
   44478:	00 
    sp.s = s;
   44479:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4447d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   44481:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   44486:	74 33                	je     444bb <vsnprintf+0x62>
        sp.end = s + size - 1;
   44488:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4448c:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   44490:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44494:	48 01 d0             	add    %rdx,%rax
   44497:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   4449b:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   4449f:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   444a3:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   444a7:	be 00 00 00 00       	mov    $0x0,%esi
   444ac:	48 89 c7             	mov    %rax,%rdi
   444af:	e8 ea f3 ff ff       	call   4389e <printer_vprintf>
        *sp.s = 0;
   444b4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   444b8:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   444bb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   444bf:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   444c3:	c9                   	leave  
   444c4:	c3                   	ret    

00000000000444c5 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   444c5:	55                   	push   %rbp
   444c6:	48 89 e5             	mov    %rsp,%rbp
   444c9:	48 83 ec 70          	sub    $0x70,%rsp
   444cd:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   444d1:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   444d5:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   444d9:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   444dd:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   444e1:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   444e5:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   444ec:	48 8d 45 10          	lea    0x10(%rbp),%rax
   444f0:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   444f4:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   444f8:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   444fc:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   44500:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   44504:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   44508:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4450c:	48 89 c7             	mov    %rax,%rdi
   4450f:	e8 45 ff ff ff       	call   44459 <vsnprintf>
   44514:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   44517:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   4451a:	c9                   	leave  
   4451b:	c3                   	ret    

000000000004451c <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   4451c:	55                   	push   %rbp
   4451d:	48 89 e5             	mov    %rsp,%rbp
   44520:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44524:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4452b:	eb 13                	jmp    44540 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
   4452d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   44530:	48 98                	cltq   
   44532:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
   44539:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   4453c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44540:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   44547:	7e e4                	jle    4452d <console_clear+0x11>
    }
    cursorpos = 0;
   44549:	c7 05 a9 4a 07 00 00 	movl   $0x0,0x74aa9(%rip)        # b8ffc <cursorpos>
   44550:	00 00 00 
}
   44553:	90                   	nop
   44554:	c9                   	leave  
   44555:	c3                   	ret    
