
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
   40173:	e8 4a 19 00 00       	call   41ac2 <hardware_init>
    pageinfo_init();
   40178:	e8 5b 0f 00 00       	call   410d8 <pageinfo_init>
    console_clear();
   4017d:	e8 80 43 00 00       	call   44502 <console_clear>
    timer_init(HZ);
   40182:	bf 64 00 00 00       	mov    $0x64,%edi
   40187:	e8 22 1e 00 00       	call   41fae <timer_init>

    // use virtual_memory_map to remove user permissions for kernel memory
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   4018c:	48 8b 05 6d 4e 01 00 	mov    0x14e6d(%rip),%rax        # 55000 <kernel_pagetable>
   40193:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   40199:	b9 00 00 10 00       	mov    $0x100000,%ecx
   4019e:	ba 00 00 00 00       	mov    $0x0,%edx
   401a3:	be 00 00 00 00       	mov    $0x0,%esi
   401a8:	48 89 c7             	mov    %rax,%rdi
   401ab:	e8 5c 2b 00 00       	call   42d0c <virtual_memory_map>
					   PROC_START_ADDR, PTE_P | PTE_W);
   
    // return user permissions to console
    virtual_memory_map(kernel_pagetable, (uintptr_t) CONSOLE_ADDR, (uintptr_t) CONSOLE_ADDR,
   401b0:	ba 00 80 0b 00       	mov    $0xb8000,%edx
   401b5:	be 00 80 0b 00       	mov    $0xb8000,%esi
   401ba:	48 8b 05 3f 4e 01 00 	mov    0x14e3f(%rip),%rax        # 55000 <kernel_pagetable>
   401c1:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   401c7:	b9 00 10 00 00       	mov    $0x1000,%ecx
   401cc:	48 89 c7             	mov    %rax,%rdi
   401cf:	e8 38 2b 00 00       	call   42d0c <virtual_memory_map>
	// to all memory before the start of ANY processes. This means that 
	// the assign_page function is never capable of assigning this memory
	// to a process.

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   401d4:	ba 00 0e 00 00       	mov    $0xe00,%edx
   401d9:	be 00 00 00 00       	mov    $0x0,%esi
   401de:	bf 20 20 05 00       	mov    $0x52020,%edi
   401e3:	e8 00 34 00 00       	call   435e8 <memset>
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
   40246:	be 40 45 04 00       	mov    $0x44540,%esi
   4024b:	48 89 c7             	mov    %rax,%rdi
   4024e:	e8 8e 34 00 00       	call   436e1 <strcmp>
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
   40276:	be 45 45 04 00       	mov    $0x44545,%esi
   4027b:	48 89 c7             	mov    %rax,%rdi
   4027e:	e8 5e 34 00 00       	call   436e1 <strcmp>
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
   402a6:	be 4e 45 04 00       	mov    $0x4454e,%esi
   402ab:	48 89 c7             	mov    %rax,%rdi
   402ae:	e8 2e 34 00 00       	call   436e1 <strcmp>
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
   402d3:	be 53 45 04 00       	mov    $0x44553,%esi
   402d8:	48 89 c7             	mov    %rax,%rdi
   402db:	e8 01 34 00 00       	call   436e1 <strcmp>
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
   40332:	e8 44 0d 00 00       	call   4107b <run>

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
   40414:	e8 cf 31 00 00       	call   435e8 <memset>
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
   4047f:	e8 66 30 00 00       	call   434ea <memcpy>
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
   404df:	e8 5b 1d 00 00       	call   4223f <process_init>
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
   40516:	e8 ae 2c 00 00       	call   431c9 <program_load>
   4051b:	89 45 fc             	mov    %eax,-0x4(%rbp)
    assert(r >= 0);
   4051e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   40522:	79 14                	jns    40538 <process_setup+0x89>
   40524:	ba 59 45 04 00       	mov    $0x44559,%edx
   40529:	be ce 00 00 00       	mov    $0xce,%esi
   4052e:	bf 60 45 04 00       	mov    $0x44560,%edi
   40533:	e8 d5 24 00 00       	call   42a0d <assert_fail>

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
   405d6:	e8 31 27 00 00       	call   42d0c <virtual_memory_map>
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
   406af:	e8 1e 2a 00 00       	call   430d2 <virtual_memory_lookup>

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
   406e7:	e8 e6 29 00 00       	call   430d2 <virtual_memory_lookup>
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
   40713:	e8 ba 29 00 00       	call   430d2 <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   40718:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4071c:	48 89 c1             	mov    %rax,%rcx
   4071f:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40723:	ba 18 00 00 00       	mov    $0x18,%edx
   40728:	48 89 c6             	mov    %rax,%rsi
   4072b:	48 89 cf             	mov    %rcx,%rdi
   4072e:	e8 b7 2d 00 00       	call   434ea <memcpy>
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
   40821:	e8 ac 28 00 00       	call   430d2 <virtual_memory_lookup>
		
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
   40894:	e8 73 24 00 00       	call   42d0c <virtual_memory_map>
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
   408e7:	e8 20 24 00 00       	call   42d0c <virtual_memory_map>
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
   4090d:	e8 d8 2b 00 00       	call   434ea <memcpy>
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
   409e5:	e8 e8 26 00 00       	call   430d2 <virtual_memory_lookup>
		
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
   40aa9:	e8 2d 21 00 00       	call   42bdb <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   40aae:	8b 05 48 85 07 00    	mov    0x78548(%rip),%eax        # b8ffc <cursorpos>
   40ab4:	89 c7                	mov    %eax,%edi
   40ab6:	e8 4e 18 00 00       	call   42309 <console_show_cursor>
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
   40af9:	e8 bf 09 00 00       	call   414bd <check_virtual_memory>
        if(disp_global){
   40afe:	0f b6 05 fb 54 00 00 	movzbl 0x54fb(%rip),%eax        # 46000 <disp_global>
   40b05:	84 c0                	test   %al,%al
   40b07:	74 0a                	je     40b13 <exception+0xa9>
            memshow_physical();
   40b09:	e8 27 0b 00 00       	call   41635 <memshow_physical>
            memshow_virtual_animate();
   40b0e:	e8 51 0e 00 00       	call   41964 <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   40b13:	e8 d4 1c 00 00       	call   427ec <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   40b18:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40b1f:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40b26:	48 83 e8 0e          	sub    $0xe,%rax
   40b2a:	48 83 f8 2a          	cmp    $0x2a,%rax
   40b2e:	0f 87 98 04 00 00    	ja     40fcc <exception+0x562>
   40b34:	48 8b 04 c5 38 46 04 	mov    0x44638(,%rax,8),%rax
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
   40b5e:	e8 ca 1d 00 00       	call   4292d <panic>
		vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   40b63:	48 8b 05 96 14 01 00 	mov    0x11496(%rip),%rax        # 52000 <current>
   40b6a:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40b71:	48 8d 45 90          	lea    -0x70(%rbp),%rax
   40b75:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   40b79:	48 89 ce             	mov    %rcx,%rsi
   40b7c:	48 89 c7             	mov    %rax,%rdi
   40b7f:	e8 4e 25 00 00       	call   430d2 <virtual_memory_lookup>
		memcpy(msg, (void *)map.pa, 160);
   40b84:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40b88:	48 89 c1             	mov    %rax,%rcx
   40b8b:	48 8d 85 e8 fe ff ff 	lea    -0x118(%rbp),%rax
   40b92:	ba a0 00 00 00       	mov    $0xa0,%edx
   40b97:	48 89 ce             	mov    %rcx,%rsi
   40b9a:	48 89 c7             	mov    %rax,%rdi
   40b9d:	e8 48 29 00 00       	call   434ea <memcpy>
		panic(msg);
   40ba2:	48 8d 85 e8 fe ff ff 	lea    -0x118(%rbp),%rax
   40ba9:	48 89 c7             	mov    %rax,%rdi
   40bac:	b8 00 00 00 00       	mov    $0x0,%eax
   40bb1:	e8 77 1d 00 00       	call   4292d <panic>
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
   40bcd:	e9 0a 04 00 00       	jmp    40fdc <exception+0x572>

    case INT_SYS_YIELD:
        schedule();
   40bd2:	e8 2e 04 00 00       	call   41005 <schedule>
        break;                  /* will not be reached */
   40bd7:	e9 00 04 00 00       	jmp    40fdc <exception+0x572>

    case INT_SYS_PAGE_ALLOC: 
	{
        uintptr_t va = current->p_registers.reg_rdi; 
   40bdc:	48 8b 05 1d 14 01 00 	mov    0x1141d(%rip),%rax        # 52000 <current>
   40be3:	48 8b 40 38          	mov    0x38(%rax),%rax
   40be7:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
		uintptr_t pa;
		int r = 0;
   40beb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
		if (virtual_memory_lookup(current->p_pagetable, va).pn != -1) {
   40bf2:	48 8b 05 07 14 01 00 	mov    0x11407(%rip),%rax        # 52000 <current>
   40bf9:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40c00:	48 8d 45 a8          	lea    -0x58(%rbp),%rax
   40c04:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   40c08:	48 89 ce             	mov    %rcx,%rsi
   40c0b:	48 89 c7             	mov    %rax,%rdi
   40c0e:	e8 bf 24 00 00       	call   430d2 <virtual_memory_lookup>
   40c13:	8b 45 a8             	mov    -0x58(%rbp),%eax
   40c16:	83 f8 ff             	cmp    $0xffffffff,%eax
   40c19:	74 0c                	je     40c27 <exception+0x1bd>
			r = -1;
   40c1b:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
   40c22:	e9 84 00 00 00       	jmp    40cab <exception+0x241>
		}
		else if (next_free_page(&pa) || assign_physical_page(pa, current->p_pid)) {
   40c27:	48 8d 45 88          	lea    -0x78(%rbp),%rax
   40c2b:	48 89 c7             	mov    %rax,%rdi
   40c2e:	e8 04 f7 ff ff       	call   40337 <next_free_page>
   40c33:	85 c0                	test   %eax,%eax
   40c35:	75 1e                	jne    40c55 <exception+0x1eb>
   40c37:	48 8b 05 c2 13 01 00 	mov    0x113c2(%rip),%rax        # 52000 <current>
   40c3e:	8b 00                	mov    (%rax),%eax
   40c40:	0f be d0             	movsbl %al,%edx
   40c43:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   40c47:	89 d6                	mov    %edx,%esi
   40c49:	48 89 c7             	mov    %rax,%rdi
   40c4c:	e8 ad f9 ff ff       	call   405fe <assign_physical_page>
   40c51:	85 c0                	test   %eax,%eax
   40c53:	74 22                	je     40c77 <exception+0x20d>
			console_printf(CPOS(23, 0), 0x0400, "Out of physical memory!\n");	
   40c55:	ba 70 45 04 00       	mov    $0x44570,%edx
   40c5a:	be 00 04 00 00       	mov    $0x400,%esi
   40c5f:	bf 30 07 00 00       	mov    $0x730,%edi
   40c64:	b8 00 00 00 00       	mov    $0x0,%eax
   40c69:	e8 31 37 00 00       	call   4439f <console_printf>
			r = -1;
   40c6e:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
   40c75:	eb 34                	jmp    40cab <exception+0x241>
		}
		else if (virtual_memory_map(current->p_pagetable, va, pa, PAGESIZE, PTE_P | PTE_W | PTE_U)) {
   40c77:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   40c7b:	48 8b 05 7e 13 01 00 	mov    0x1137e(%rip),%rax        # 52000 <current>
   40c82:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40c89:	48 8b 75 e8          	mov    -0x18(%rbp),%rsi
   40c8d:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40c93:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40c98:	48 89 c7             	mov    %rax,%rdi
   40c9b:	e8 6c 20 00 00       	call   42d0c <virtual_memory_map>
   40ca0:	85 c0                	test   %eax,%eax
   40ca2:	74 07                	je     40cab <exception+0x241>
			r = -1;
   40ca4:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
		}

        current->p_registers.reg_rax = r;
   40cab:	48 8b 05 4e 13 01 00 	mov    0x1134e(%rip),%rax        # 52000 <current>
   40cb2:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40cb5:	48 63 d2             	movslq %edx,%rdx
   40cb8:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   40cbc:	e9 1b 03 00 00       	jmp    40fdc <exception+0x572>
    }

    case INT_SYS_MAPPING:
    {
	    syscall_mapping(current);
   40cc1:	48 8b 05 38 13 01 00 	mov    0x11338(%rip),%rax        # 52000 <current>
   40cc8:	48 89 c7             	mov    %rax,%rdi
   40ccb:	e8 a2 f9 ff ff       	call   40672 <syscall_mapping>
            break;
   40cd0:	e9 07 03 00 00       	jmp    40fdc <exception+0x572>
    }

    case INT_SYS_MEM_TOG:
	{
	    syscall_mem_tog(current);
   40cd5:	48 8b 05 24 13 01 00 	mov    0x11324(%rip),%rax        # 52000 <current>
   40cdc:	48 89 c7             	mov    %rax,%rdi
   40cdf:	e8 57 fa ff ff       	call   4073b <syscall_mem_tog>
	    break;
   40ce4:	e9 f3 02 00 00       	jmp    40fdc <exception+0x572>
	}

    case INT_TIMER:
        ++ticks;
   40ce9:	8b 05 31 21 01 00    	mov    0x12131(%rip),%eax        # 52e20 <ticks>
   40cef:	83 c0 01             	add    $0x1,%eax
   40cf2:	89 05 28 21 01 00    	mov    %eax,0x12128(%rip)        # 52e20 <ticks>
        schedule();
   40cf8:	e8 08 03 00 00       	call   41005 <schedule>
        break;                  /* will not be reached */
   40cfd:	e9 da 02 00 00       	jmp    40fdc <exception+0x572>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   40d02:	0f 20 d0             	mov    %cr2,%rax
   40d05:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    return val;
   40d09:	48 8b 45 c0          	mov    -0x40(%rbp),%rax

    case INT_PAGEFAULT: {
        // Analyze faulting address and access type.
        uintptr_t addr = rcr2();
   40d0d:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        const char* operation = reg->reg_err & PFERR_WRITE
   40d11:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40d18:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40d1f:	83 e0 02             	and    $0x2,%eax
                ? "write" : "read";
   40d22:	48 85 c0             	test   %rax,%rax
   40d25:	74 07                	je     40d2e <exception+0x2c4>
   40d27:	b8 89 45 04 00       	mov    $0x44589,%eax
   40d2c:	eb 05                	jmp    40d33 <exception+0x2c9>
   40d2e:	b8 8f 45 04 00       	mov    $0x4458f,%eax
        const char* operation = reg->reg_err & PFERR_WRITE
   40d33:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        const char* problem = reg->reg_err & PFERR_PRESENT
   40d37:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40d3e:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40d45:	83 e0 01             	and    $0x1,%eax
                ? "protection problem" : "missing page";
   40d48:	48 85 c0             	test   %rax,%rax
   40d4b:	74 07                	je     40d54 <exception+0x2ea>
   40d4d:	b8 94 45 04 00       	mov    $0x44594,%eax
   40d52:	eb 05                	jmp    40d59 <exception+0x2ef>
   40d54:	b8 a7 45 04 00       	mov    $0x445a7,%eax
        const char* problem = reg->reg_err & PFERR_PRESENT
   40d59:	48 89 45 c8          	mov    %rax,-0x38(%rbp)

        if (!(reg->reg_err & PFERR_USER)) {
   40d5d:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40d64:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40d6b:	83 e0 04             	and    $0x4,%eax
   40d6e:	48 85 c0             	test   %rax,%rax
   40d71:	75 2f                	jne    40da2 <exception+0x338>
            panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   40d73:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40d7a:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   40d81:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   40d85:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   40d89:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40d8d:	49 89 f0             	mov    %rsi,%r8
   40d90:	48 89 c6             	mov    %rax,%rsi
   40d93:	bf b8 45 04 00       	mov    $0x445b8,%edi
   40d98:	b8 00 00 00 00       	mov    $0x0,%eax
   40d9d:	e8 8b 1b 00 00       	call   4292d <panic>
                  addr, operation, problem, reg->reg_rip);
        }
        console_printf(CPOS(24, 0), 0x0C00,
   40da2:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40da9:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                       "Process %d page fault for %p (%s %s, rip=%p)!\n",
                       current->p_pid, addr, operation, problem, reg->reg_rip);
   40db0:	48 8b 05 49 12 01 00 	mov    0x11249(%rip),%rax        # 52000 <current>
        console_printf(CPOS(24, 0), 0x0C00,
   40db7:	8b 00                	mov    (%rax),%eax
   40db9:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
   40dbd:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   40dc1:	52                   	push   %rdx
   40dc2:	ff 75 c8             	push   -0x38(%rbp)
   40dc5:	49 89 f1             	mov    %rsi,%r9
   40dc8:	49 89 c8             	mov    %rcx,%r8
   40dcb:	89 c1                	mov    %eax,%ecx
   40dcd:	ba e8 45 04 00       	mov    $0x445e8,%edx
   40dd2:	be 00 0c 00 00       	mov    $0xc00,%esi
   40dd7:	bf 80 07 00 00       	mov    $0x780,%edi
   40ddc:	b8 00 00 00 00       	mov    $0x0,%eax
   40de1:	e8 b9 35 00 00       	call   4439f <console_printf>
   40de6:	48 83 c4 10          	add    $0x10,%rsp
        current->p_state = P_BROKEN;
   40dea:	48 8b 05 0f 12 01 00 	mov    0x1120f(%rip),%rax        # 52000 <current>
   40df1:	c7 80 c8 00 00 00 03 	movl   $0x3,0xc8(%rax)
   40df8:	00 00 00 
        break;
   40dfb:	e9 dc 01 00 00       	jmp    40fdc <exception+0x572>
    }

	case INT_SYS_FORK:
		// find free pid
		pid_t child_pid;
		if ((child_pid = next_free_pid()) == -1) {
   40e00:	e8 9f f9 ff ff       	call   407a4 <next_free_pid>
   40e05:	89 45 f8             	mov    %eax,-0x8(%rbp)
   40e08:	83 7d f8 ff          	cmpl   $0xffffffff,-0x8(%rbp)
   40e0c:	75 32                	jne    40e40 <exception+0x3d6>
			console_printf(CPOS(23, 0), 0x0400, "Max processes (%d) reached!\n", NPROC);	
   40e0e:	b9 10 00 00 00       	mov    $0x10,%ecx
   40e13:	ba 17 46 04 00       	mov    $0x44617,%edx
   40e18:	be 00 04 00 00       	mov    $0x400,%esi
   40e1d:	bf 30 07 00 00       	mov    $0x730,%edi
   40e22:	b8 00 00 00 00       	mov    $0x0,%eax
   40e27:	e8 73 35 00 00       	call   4439f <console_printf>
			current->p_registers.reg_rax = -1;
   40e2c:	48 8b 05 cd 11 01 00 	mov    0x111cd(%rip),%rax        # 52000 <current>
   40e33:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40e3a:	ff 
			break;
   40e3b:	e9 9c 01 00 00       	jmp    40fdc <exception+0x572>
		}

		proc *child_proc = &processes[child_pid];
   40e40:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40e43:	48 63 d0             	movslq %eax,%rdx
   40e46:	48 89 d0             	mov    %rdx,%rax
   40e49:	48 c1 e0 03          	shl    $0x3,%rax
   40e4d:	48 29 d0             	sub    %rdx,%rax
   40e50:	48 c1 e0 05          	shl    $0x5,%rax
   40e54:	48 05 20 20 05 00    	add    $0x52020,%rax
   40e5a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

		// copy the state of parent into child
		*child_proc = processes[current->p_pid];
   40e5e:	48 8b 05 9b 11 01 00 	mov    0x1119b(%rip),%rax        # 52000 <current>
   40e65:	8b 00                	mov    (%rax),%eax
   40e67:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
   40e6b:	48 63 d0             	movslq %eax,%rdx
   40e6e:	48 89 d0             	mov    %rdx,%rax
   40e71:	48 c1 e0 03          	shl    $0x3,%rax
   40e75:	48 29 d0             	sub    %rdx,%rax
   40e78:	48 c1 e0 05          	shl    $0x5,%rax
   40e7c:	48 05 20 20 05 00    	add    $0x52020,%rax
   40e82:	48 89 ca             	mov    %rcx,%rdx
   40e85:	48 89 c6             	mov    %rax,%rsi
   40e88:	b8 1c 00 00 00       	mov    $0x1c,%eax
   40e8d:	48 89 d7             	mov    %rdx,%rdi
   40e90:	48 89 c1             	mov    %rax,%rcx
   40e93:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
		child_proc->p_pid = child_pid;
   40e96:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40e9a:	8b 55 f8             	mov    -0x8(%rbp),%edx
   40e9d:	89 10                	mov    %edx,(%rax)

		
		// setup and copy the pagetable
		if (pagetable_setup(child_proc->p_pid)) {
   40e9f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40ea3:	8b 00                	mov    (%rax),%eax
   40ea5:	89 c7                	mov    %eax,%edi
   40ea7:	e8 f8 f4 ff ff       	call   403a4 <pagetable_setup>
   40eac:	85 c0                	test   %eax,%eax
   40eae:	74 36                	je     40ee6 <exception+0x47c>
			free_pages_pa(child_proc); // goes through all pa and frees ones that belong to child_proc
   40eb0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40eb4:	48 89 c7             	mov    %rax,%rdi
   40eb7:	e8 76 fa ff ff       	call   40932 <free_pages_pa>
			memset(child_proc, 0, sizeof(*child_proc));
   40ebc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40ec0:	ba e0 00 00 00       	mov    $0xe0,%edx
   40ec5:	be 00 00 00 00       	mov    $0x0,%esi
   40eca:	48 89 c7             	mov    %rax,%rdi
   40ecd:	e8 16 27 00 00       	call   435e8 <memset>

			current->p_registers.reg_rax = -1;
   40ed2:	48 8b 05 27 11 01 00 	mov    0x11127(%rip),%rax        # 52000 <current>
   40ed9:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40ee0:	ff 
			break;
   40ee1:	e9 f6 00 00 00       	jmp    40fdc <exception+0x572>
		}
		else if (copy_pagetable(child_proc, current)) {
   40ee6:	48 8b 15 13 11 01 00 	mov    0x11113(%rip),%rdx        # 52000 <current>
   40eed:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40ef1:	48 89 d6             	mov    %rdx,%rsi
   40ef4:	48 89 c7             	mov    %rax,%rdi
   40ef7:	e8 ef f8 ff ff       	call   407eb <copy_pagetable>
   40efc:	85 c0                	test   %eax,%eax
   40efe:	74 42                	je     40f42 <exception+0x4d8>
			free_pages_va(child_proc); // goes through all va and frees corresponding physical page
   40f00:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40f04:	48 89 c7             	mov    %rax,%rdi
   40f07:	e8 a7 fa ff ff       	call   409b3 <free_pages_va>
			free_pages_pa(child_proc); // goes through all pa and frees ones that belong to child_proc
   40f0c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40f10:	48 89 c7             	mov    %rax,%rdi
   40f13:	e8 1a fa ff ff       	call   40932 <free_pages_pa>

			memset(child_proc, 0, sizeof(*child_proc));
   40f18:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40f1c:	ba e0 00 00 00       	mov    $0xe0,%edx
   40f21:	be 00 00 00 00       	mov    $0x0,%esi
   40f26:	48 89 c7             	mov    %rax,%rdi
   40f29:	e8 ba 26 00 00       	call   435e8 <memset>
			current->p_registers.reg_rax = -1;
   40f2e:	48 8b 05 cb 10 01 00 	mov    0x110cb(%rip),%rax        # 52000 <current>
   40f35:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40f3c:	ff 
			break;
   40f3d:	e9 9a 00 00 00       	jmp    40fdc <exception+0x572>
		}


		// successful fork! set return registers
                console_printf(CPOS(24, 0), 0, "\n");
   40f42:	ba 34 46 04 00       	mov    $0x44634,%edx
   40f47:	be 00 00 00 00       	mov    $0x0,%esi
   40f4c:	bf 80 07 00 00       	mov    $0x780,%edi
   40f51:	b8 00 00 00 00       	mov    $0x0,%eax
   40f56:	e8 44 34 00 00       	call   4439f <console_printf>

		child_proc->p_registers.reg_rax = 0;
   40f5b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40f5f:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
   40f66:	00 
		current->p_registers.reg_rax = child_pid;
   40f67:	48 8b 05 92 10 01 00 	mov    0x11092(%rip),%rax        # 52000 <current>
   40f6e:	8b 55 f8             	mov    -0x8(%rbp),%edx
   40f71:	48 63 d2             	movslq %edx,%rdx
   40f74:	48 89 50 08          	mov    %rdx,0x8(%rax)
		break;
   40f78:	eb 62                	jmp    40fdc <exception+0x572>

	case INT_SYS_EXIT:
		free_pages_va(current); // goes through all va and frees corresponding physical page
   40f7a:	48 8b 05 7f 10 01 00 	mov    0x1107f(%rip),%rax        # 52000 <current>
   40f81:	48 89 c7             	mov    %rax,%rdi
   40f84:	e8 2a fa ff ff       	call   409b3 <free_pages_va>
		free_pages_pa(current); // goes through all pa and frees ones that belong to child_proc
   40f89:	48 8b 05 70 10 01 00 	mov    0x11070(%rip),%rax        # 52000 <current>
   40f90:	48 89 c7             	mov    %rax,%rdi
   40f93:	e8 9a f9 ff ff       	call   40932 <free_pages_pa>
		memset(&processes[current->p_pid], 0, sizeof(*current));
   40f98:	48 8b 05 61 10 01 00 	mov    0x11061(%rip),%rax        # 52000 <current>
   40f9f:	8b 00                	mov    (%rax),%eax
   40fa1:	48 63 d0             	movslq %eax,%rdx
   40fa4:	48 89 d0             	mov    %rdx,%rax
   40fa7:	48 c1 e0 03          	shl    $0x3,%rax
   40fab:	48 29 d0             	sub    %rdx,%rax
   40fae:	48 c1 e0 05          	shl    $0x5,%rax
   40fb2:	48 05 20 20 05 00    	add    $0x52020,%rax
   40fb8:	ba e0 00 00 00       	mov    $0xe0,%edx
   40fbd:	be 00 00 00 00       	mov    $0x0,%esi
   40fc2:	48 89 c7             	mov    %rax,%rdi
   40fc5:	e8 1e 26 00 00       	call   435e8 <memset>
		break;
   40fca:	eb 10                	jmp    40fdc <exception+0x572>

    default:
        default_exception(current);
   40fcc:	48 8b 05 2d 10 01 00 	mov    0x1102d(%rip),%rax        # 52000 <current>
   40fd3:	48 89 c7             	mov    %rax,%rdi
   40fd6:	e8 62 1a 00 00       	call   42a3d <default_exception>
        break;                  /* will not be reached */
   40fdb:	90                   	nop

    }


    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   40fdc:	48 8b 05 1d 10 01 00 	mov    0x1101d(%rip),%rax        # 52000 <current>
   40fe3:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   40fe9:	83 f8 01             	cmp    $0x1,%eax
   40fec:	75 0f                	jne    40ffd <exception+0x593>
        run(current);
   40fee:	48 8b 05 0b 10 01 00 	mov    0x1100b(%rip),%rax        # 52000 <current>
   40ff5:	48 89 c7             	mov    %rax,%rdi
   40ff8:	e8 7e 00 00 00       	call   4107b <run>
    } else {
        schedule();
   40ffd:	e8 03 00 00 00       	call   41005 <schedule>
    }
}
   41002:	90                   	nop
   41003:	c9                   	leave  
   41004:	c3                   	ret    

0000000000041005 <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   41005:	55                   	push   %rbp
   41006:	48 89 e5             	mov    %rsp,%rbp
   41009:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   4100d:	48 8b 05 ec 0f 01 00 	mov    0x10fec(%rip),%rax        # 52000 <current>
   41014:	8b 00                	mov    (%rax),%eax
   41016:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   41019:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4101c:	8d 50 01             	lea    0x1(%rax),%edx
   4101f:	89 d0                	mov    %edx,%eax
   41021:	c1 f8 1f             	sar    $0x1f,%eax
   41024:	c1 e8 1c             	shr    $0x1c,%eax
   41027:	01 c2                	add    %eax,%edx
   41029:	83 e2 0f             	and    $0xf,%edx
   4102c:	29 c2                	sub    %eax,%edx
   4102e:	89 55 fc             	mov    %edx,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   41031:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41034:	48 63 d0             	movslq %eax,%rdx
   41037:	48 89 d0             	mov    %rdx,%rax
   4103a:	48 c1 e0 03          	shl    $0x3,%rax
   4103e:	48 29 d0             	sub    %rdx,%rax
   41041:	48 c1 e0 05          	shl    $0x5,%rax
   41045:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   4104b:	8b 00                	mov    (%rax),%eax
   4104d:	83 f8 01             	cmp    $0x1,%eax
   41050:	75 22                	jne    41074 <schedule+0x6f>
            run(&processes[pid]);
   41052:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41055:	48 63 d0             	movslq %eax,%rdx
   41058:	48 89 d0             	mov    %rdx,%rax
   4105b:	48 c1 e0 03          	shl    $0x3,%rax
   4105f:	48 29 d0             	sub    %rdx,%rax
   41062:	48 c1 e0 05          	shl    $0x5,%rax
   41066:	48 05 20 20 05 00    	add    $0x52020,%rax
   4106c:	48 89 c7             	mov    %rax,%rdi
   4106f:	e8 07 00 00 00       	call   4107b <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   41074:	e8 73 17 00 00       	call   427ec <check_keyboard>
        pid = (pid + 1) % NPROC;
   41079:	eb 9e                	jmp    41019 <schedule+0x14>

000000000004107b <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   4107b:	55                   	push   %rbp
   4107c:	48 89 e5             	mov    %rsp,%rbp
   4107f:	48 83 ec 10          	sub    $0x10,%rsp
   41083:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   41087:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4108b:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   41091:	83 f8 01             	cmp    $0x1,%eax
   41094:	74 14                	je     410aa <run+0x2f>
   41096:	ba 90 47 04 00       	mov    $0x44790,%edx
   4109b:	be 44 02 00 00       	mov    $0x244,%esi
   410a0:	bf 60 45 04 00       	mov    $0x44560,%edi
   410a5:	e8 63 19 00 00       	call   42a0d <assert_fail>
    current = p;
   410aa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   410ae:	48 89 05 4b 0f 01 00 	mov    %rax,0x10f4b(%rip)        # 52000 <current>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   410b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   410b9:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   410c0:	48 89 c7             	mov    %rax,%rdi
   410c3:	e8 13 1b 00 00       	call   42bdb <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   410c8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   410cc:	48 83 c0 08          	add    $0x8,%rax
   410d0:	48 89 c7             	mov    %rax,%rdi
   410d3:	e8 eb ef ff ff       	call   400c3 <exception_return>

00000000000410d8 <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   410d8:	55                   	push   %rbp
   410d9:	48 89 e5             	mov    %rsp,%rbp
   410dc:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   410e0:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   410e7:	00 
   410e8:	e9 81 00 00 00       	jmp    4116e <pageinfo_init+0x96>
        int owner;
        if (physical_memory_isreserved(addr)) {
   410ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   410f1:	48 89 c7             	mov    %rax,%rdi
   410f4:	e8 81 0f 00 00       	call   4207a <physical_memory_isreserved>
   410f9:	85 c0                	test   %eax,%eax
   410fb:	74 09                	je     41106 <pageinfo_init+0x2e>
            owner = PO_RESERVED;
   410fd:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   41104:	eb 2f                	jmp    41135 <pageinfo_init+0x5d>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   41106:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   4110d:	00 
   4110e:	76 0b                	jbe    4111b <pageinfo_init+0x43>
   41110:	b8 08 b0 05 00       	mov    $0x5b008,%eax
   41115:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41119:	72 0a                	jb     41125 <pageinfo_init+0x4d>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   4111b:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   41122:	00 
   41123:	75 09                	jne    4112e <pageinfo_init+0x56>
            owner = PO_KERNEL;
   41125:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   4112c:	eb 07                	jmp    41135 <pageinfo_init+0x5d>
        } else {
            owner = PO_FREE;
   4112e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   41135:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41139:	48 c1 e8 0c          	shr    $0xc,%rax
   4113d:	89 c1                	mov    %eax,%ecx
   4113f:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41142:	89 c2                	mov    %eax,%edx
   41144:	48 63 c1             	movslq %ecx,%rax
   41147:	88 94 00 40 2e 05 00 	mov    %dl,0x52e40(%rax,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   4114e:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41152:	0f 95 c2             	setne  %dl
   41155:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41159:	48 c1 e8 0c          	shr    $0xc,%rax
   4115d:	48 98                	cltq   
   4115f:	88 94 00 41 2e 05 00 	mov    %dl,0x52e41(%rax,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   41166:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4116d:	00 
   4116e:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   41175:	00 
   41176:	0f 86 71 ff ff ff    	jbe    410ed <pageinfo_init+0x15>
    }
}
   4117c:	90                   	nop
   4117d:	90                   	nop
   4117e:	c9                   	leave  
   4117f:	c3                   	ret    

0000000000041180 <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   41180:	55                   	push   %rbp
   41181:	48 89 e5             	mov    %rsp,%rbp
   41184:	48 83 ec 50          	sub    $0x50,%rsp
   41188:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   4118c:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   41190:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   41196:	48 89 c2             	mov    %rax,%rdx
   41199:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4119d:	48 39 c2             	cmp    %rax,%rdx
   411a0:	74 14                	je     411b6 <check_page_table_mappings+0x36>
   411a2:	ba b0 47 04 00       	mov    $0x447b0,%edx
   411a7:	be 6e 02 00 00       	mov    $0x26e,%esi
   411ac:	bf 60 45 04 00       	mov    $0x44560,%edi
   411b1:	e8 57 18 00 00       	call   42a0d <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   411b6:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   411bd:	00 
   411be:	e9 9a 00 00 00       	jmp    4125d <check_page_table_mappings+0xdd>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   411c3:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   411c7:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   411cb:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   411cf:	48 89 ce             	mov    %rcx,%rsi
   411d2:	48 89 c7             	mov    %rax,%rdi
   411d5:	e8 f8 1e 00 00       	call   430d2 <virtual_memory_lookup>
        if (vam.pa != va) {
   411da:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   411de:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   411e2:	74 27                	je     4120b <check_page_table_mappings+0x8b>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   411e4:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   411e8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   411ec:	49 89 d0             	mov    %rdx,%r8
   411ef:	48 89 c1             	mov    %rax,%rcx
   411f2:	ba cf 47 04 00       	mov    $0x447cf,%edx
   411f7:	be 00 c0 00 00       	mov    $0xc000,%esi
   411fc:	bf e0 06 00 00       	mov    $0x6e0,%edi
   41201:	b8 00 00 00 00       	mov    $0x0,%eax
   41206:	e8 94 31 00 00       	call   4439f <console_printf>
        }
        assert(vam.pa == va);
   4120b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4120f:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41213:	74 14                	je     41229 <check_page_table_mappings+0xa9>
   41215:	ba d9 47 04 00       	mov    $0x447d9,%edx
   4121a:	be 77 02 00 00       	mov    $0x277,%esi
   4121f:	bf 60 45 04 00       	mov    $0x44560,%edi
   41224:	e8 e4 17 00 00       	call   42a0d <assert_fail>
        if (va >= (uintptr_t) start_data) {
   41229:	b8 00 60 04 00       	mov    $0x46000,%eax
   4122e:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41232:	72 21                	jb     41255 <check_page_table_mappings+0xd5>
            assert(vam.perm & PTE_W);
   41234:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41237:	48 98                	cltq   
   41239:	83 e0 02             	and    $0x2,%eax
   4123c:	48 85 c0             	test   %rax,%rax
   4123f:	75 14                	jne    41255 <check_page_table_mappings+0xd5>
   41241:	ba e6 47 04 00       	mov    $0x447e6,%edx
   41246:	be 79 02 00 00       	mov    $0x279,%esi
   4124b:	bf 60 45 04 00       	mov    $0x44560,%edi
   41250:	e8 b8 17 00 00       	call   42a0d <assert_fail>
         va += PAGESIZE) {
   41255:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4125c:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   4125d:	b8 08 b0 05 00       	mov    $0x5b008,%eax
   41262:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41266:	0f 82 57 ff ff ff    	jb     411c3 <check_page_table_mappings+0x43>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   4126c:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   41273:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   41274:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   41278:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4127c:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   41280:	48 89 ce             	mov    %rcx,%rsi
   41283:	48 89 c7             	mov    %rax,%rdi
   41286:	e8 47 1e 00 00       	call   430d2 <virtual_memory_lookup>
    assert(vam.pa == kstack);
   4128b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4128f:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   41293:	74 14                	je     412a9 <check_page_table_mappings+0x129>
   41295:	ba f7 47 04 00       	mov    $0x447f7,%edx
   4129a:	be 80 02 00 00       	mov    $0x280,%esi
   4129f:	bf 60 45 04 00       	mov    $0x44560,%edi
   412a4:	e8 64 17 00 00       	call   42a0d <assert_fail>
    assert(vam.perm & PTE_W);
   412a9:	8b 45 e8             	mov    -0x18(%rbp),%eax
   412ac:	48 98                	cltq   
   412ae:	83 e0 02             	and    $0x2,%eax
   412b1:	48 85 c0             	test   %rax,%rax
   412b4:	75 14                	jne    412ca <check_page_table_mappings+0x14a>
   412b6:	ba e6 47 04 00       	mov    $0x447e6,%edx
   412bb:	be 81 02 00 00       	mov    $0x281,%esi
   412c0:	bf 60 45 04 00       	mov    $0x44560,%edi
   412c5:	e8 43 17 00 00       	call   42a0d <assert_fail>
}
   412ca:	90                   	nop
   412cb:	c9                   	leave  
   412cc:	c3                   	ret    

00000000000412cd <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   412cd:	55                   	push   %rbp
   412ce:	48 89 e5             	mov    %rsp,%rbp
   412d1:	48 83 ec 20          	sub    $0x20,%rsp
   412d5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   412d9:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   412dc:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   412df:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   412e2:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   412e9:	48 8b 05 10 3d 01 00 	mov    0x13d10(%rip),%rax        # 55000 <kernel_pagetable>
   412f0:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   412f4:	75 67                	jne    4135d <check_page_table_ownership+0x90>
        owner = PO_KERNEL;
   412f6:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   412fd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41304:	eb 51                	jmp    41357 <check_page_table_ownership+0x8a>
            if (processes[xpid].p_state != P_FREE
   41306:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41309:	48 63 d0             	movslq %eax,%rdx
   4130c:	48 89 d0             	mov    %rdx,%rax
   4130f:	48 c1 e0 03          	shl    $0x3,%rax
   41313:	48 29 d0             	sub    %rdx,%rax
   41316:	48 c1 e0 05          	shl    $0x5,%rax
   4131a:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   41320:	8b 00                	mov    (%rax),%eax
   41322:	85 c0                	test   %eax,%eax
   41324:	74 2d                	je     41353 <check_page_table_ownership+0x86>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   41326:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41329:	48 63 d0             	movslq %eax,%rdx
   4132c:	48 89 d0             	mov    %rdx,%rax
   4132f:	48 c1 e0 03          	shl    $0x3,%rax
   41333:	48 29 d0             	sub    %rdx,%rax
   41336:	48 c1 e0 05          	shl    $0x5,%rax
   4133a:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   41340:	48 8b 10             	mov    (%rax),%rdx
   41343:	48 8b 05 b6 3c 01 00 	mov    0x13cb6(%rip),%rax        # 55000 <kernel_pagetable>
   4134a:	48 39 c2             	cmp    %rax,%rdx
   4134d:	75 04                	jne    41353 <check_page_table_ownership+0x86>
                ++expected_refcount;
   4134f:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   41353:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41357:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   4135b:	7e a9                	jle    41306 <check_page_table_ownership+0x39>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   4135d:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41360:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41363:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41367:	be 00 00 00 00       	mov    $0x0,%esi
   4136c:	48 89 c7             	mov    %rax,%rdi
   4136f:	e8 03 00 00 00       	call   41377 <check_page_table_ownership_level>
}
   41374:	90                   	nop
   41375:	c9                   	leave  
   41376:	c3                   	ret    

0000000000041377 <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   41377:	55                   	push   %rbp
   41378:	48 89 e5             	mov    %rsp,%rbp
   4137b:	48 83 ec 30          	sub    $0x30,%rsp
   4137f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   41383:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   41386:	89 55 e0             	mov    %edx,-0x20(%rbp)
   41389:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   4138c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41390:	48 c1 e8 0c          	shr    $0xc,%rax
   41394:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   41399:	7e 14                	jle    413af <check_page_table_ownership_level+0x38>
   4139b:	ba 08 48 04 00       	mov    $0x44808,%edx
   413a0:	be 9e 02 00 00       	mov    $0x29e,%esi
   413a5:	bf 60 45 04 00       	mov    $0x44560,%edi
   413aa:	e8 5e 16 00 00       	call   42a0d <assert_fail>
    if (pageinfo[PAGENUMBER(pt)].owner != owner) {
   413af:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   413b3:	48 c1 e8 0c          	shr    $0xc,%rax
   413b7:	48 98                	cltq   
   413b9:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   413c0:	00 
   413c1:	0f be c0             	movsbl %al,%eax
   413c4:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   413c7:	74 34                	je     413fd <check_page_table_ownership_level+0x86>
	panic("pt addr: %p, supposed owner of pt: %d, actual owner of pt: %d, refcount: %d", pt, owner, pageinfo[PAGENUMBER(pt)].owner,
   413c9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   413cd:	48 c1 e8 0c          	shr    $0xc,%rax
   413d1:	48 98                	cltq   
   413d3:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   413da:	00 
   413db:	0f be c8             	movsbl %al,%ecx
   413de:	8b 75 dc             	mov    -0x24(%rbp),%esi
   413e1:	8b 55 e0             	mov    -0x20(%rbp),%edx
   413e4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   413e8:	41 89 f0             	mov    %esi,%r8d
   413eb:	48 89 c6             	mov    %rax,%rsi
   413ee:	bf 20 48 04 00       	mov    $0x44820,%edi
   413f3:	b8 00 00 00 00       	mov    $0x0,%eax
   413f8:	e8 30 15 00 00       	call   4292d <panic>
			refcount);
    }
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   413fd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41401:	48 c1 e8 0c          	shr    $0xc,%rax
   41405:	48 98                	cltq   
   41407:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   4140e:	00 
   4140f:	0f be c0             	movsbl %al,%eax
   41412:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   41415:	74 14                	je     4142b <check_page_table_ownership_level+0xb4>
   41417:	ba 70 48 04 00       	mov    $0x44870,%edx
   4141c:	be a3 02 00 00       	mov    $0x2a3,%esi
   41421:	bf 60 45 04 00       	mov    $0x44560,%edi
   41426:	e8 e2 15 00 00       	call   42a0d <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   4142b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4142f:	48 c1 e8 0c          	shr    $0xc,%rax
   41433:	48 98                	cltq   
   41435:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   4143c:	00 
   4143d:	0f be c0             	movsbl %al,%eax
   41440:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   41443:	74 14                	je     41459 <check_page_table_ownership_level+0xe2>
   41445:	ba 98 48 04 00       	mov    $0x44898,%edx
   4144a:	be a4 02 00 00       	mov    $0x2a4,%esi
   4144f:	bf 60 45 04 00       	mov    $0x44560,%edi
   41454:	e8 b4 15 00 00       	call   42a0d <assert_fail>
    if (level < 3) {
   41459:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   4145d:	7f 5b                	jg     414ba <check_page_table_ownership_level+0x143>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   4145f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41466:	eb 49                	jmp    414b1 <check_page_table_ownership_level+0x13a>
            if (pt->entry[index]) {
   41468:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4146c:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4146f:	48 63 d2             	movslq %edx,%rdx
   41472:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41476:	48 85 c0             	test   %rax,%rax
   41479:	74 32                	je     414ad <check_page_table_ownership_level+0x136>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   4147b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4147f:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41482:	48 63 d2             	movslq %edx,%rdx
   41485:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41489:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   4148f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   41493:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   41496:	8d 70 01             	lea    0x1(%rax),%esi
   41499:	8b 55 e0             	mov    -0x20(%rbp),%edx
   4149c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   414a0:	b9 01 00 00 00       	mov    $0x1,%ecx
   414a5:	48 89 c7             	mov    %rax,%rdi
   414a8:	e8 ca fe ff ff       	call   41377 <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   414ad:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   414b1:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   414b8:	7e ae                	jle    41468 <check_page_table_ownership_level+0xf1>
            }
        }
    }
}
   414ba:	90                   	nop
   414bb:	c9                   	leave  
   414bc:	c3                   	ret    

00000000000414bd <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   414bd:	55                   	push   %rbp
   414be:	48 89 e5             	mov    %rsp,%rbp
   414c1:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   414c5:	8b 05 1d 0c 01 00    	mov    0x10c1d(%rip),%eax        # 520e8 <processes+0xc8>
   414cb:	85 c0                	test   %eax,%eax
   414cd:	74 14                	je     414e3 <check_virtual_memory+0x26>
   414cf:	ba c8 48 04 00       	mov    $0x448c8,%edx
   414d4:	be b7 02 00 00       	mov    $0x2b7,%esi
   414d9:	bf 60 45 04 00       	mov    $0x44560,%edi
   414de:	e8 2a 15 00 00       	call   42a0d <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   414e3:	48 8b 05 16 3b 01 00 	mov    0x13b16(%rip),%rax        # 55000 <kernel_pagetable>
   414ea:	48 89 c7             	mov    %rax,%rdi
   414ed:	e8 8e fc ff ff       	call   41180 <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   414f2:	48 8b 05 07 3b 01 00 	mov    0x13b07(%rip),%rax        # 55000 <kernel_pagetable>
   414f9:	be ff ff ff ff       	mov    $0xffffffff,%esi
   414fe:	48 89 c7             	mov    %rax,%rdi
   41501:	e8 c7 fd ff ff       	call   412cd <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   41506:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4150d:	e9 9c 00 00 00       	jmp    415ae <check_virtual_memory+0xf1>
        if (processes[pid].p_state != P_FREE
   41512:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41515:	48 63 d0             	movslq %eax,%rdx
   41518:	48 89 d0             	mov    %rdx,%rax
   4151b:	48 c1 e0 03          	shl    $0x3,%rax
   4151f:	48 29 d0             	sub    %rdx,%rax
   41522:	48 c1 e0 05          	shl    $0x5,%rax
   41526:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   4152c:	8b 00                	mov    (%rax),%eax
   4152e:	85 c0                	test   %eax,%eax
   41530:	74 78                	je     415aa <check_virtual_memory+0xed>
            && processes[pid].p_pagetable != kernel_pagetable) {
   41532:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41535:	48 63 d0             	movslq %eax,%rdx
   41538:	48 89 d0             	mov    %rdx,%rax
   4153b:	48 c1 e0 03          	shl    $0x3,%rax
   4153f:	48 29 d0             	sub    %rdx,%rax
   41542:	48 c1 e0 05          	shl    $0x5,%rax
   41546:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   4154c:	48 8b 10             	mov    (%rax),%rdx
   4154f:	48 8b 05 aa 3a 01 00 	mov    0x13aaa(%rip),%rax        # 55000 <kernel_pagetable>
   41556:	48 39 c2             	cmp    %rax,%rdx
   41559:	74 4f                	je     415aa <check_virtual_memory+0xed>
            check_page_table_mappings(processes[pid].p_pagetable);
   4155b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4155e:	48 63 d0             	movslq %eax,%rdx
   41561:	48 89 d0             	mov    %rdx,%rax
   41564:	48 c1 e0 03          	shl    $0x3,%rax
   41568:	48 29 d0             	sub    %rdx,%rax
   4156b:	48 c1 e0 05          	shl    $0x5,%rax
   4156f:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   41575:	48 8b 00             	mov    (%rax),%rax
   41578:	48 89 c7             	mov    %rax,%rdi
   4157b:	e8 00 fc ff ff       	call   41180 <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   41580:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41583:	48 63 d0             	movslq %eax,%rdx
   41586:	48 89 d0             	mov    %rdx,%rax
   41589:	48 c1 e0 03          	shl    $0x3,%rax
   4158d:	48 29 d0             	sub    %rdx,%rax
   41590:	48 c1 e0 05          	shl    $0x5,%rax
   41594:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   4159a:	48 8b 00             	mov    (%rax),%rax
   4159d:	8b 55 fc             	mov    -0x4(%rbp),%edx
   415a0:	89 d6                	mov    %edx,%esi
   415a2:	48 89 c7             	mov    %rax,%rdi
   415a5:	e8 23 fd ff ff       	call   412cd <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   415aa:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   415ae:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   415b2:	0f 8e 5a ff ff ff    	jle    41512 <check_virtual_memory+0x55>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   415b8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   415bf:	eb 67                	jmp    41628 <check_virtual_memory+0x16b>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   415c1:	8b 45 f8             	mov    -0x8(%rbp),%eax
   415c4:	48 98                	cltq   
   415c6:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   415cd:	00 
   415ce:	84 c0                	test   %al,%al
   415d0:	7e 52                	jle    41624 <check_virtual_memory+0x167>
   415d2:	8b 45 f8             	mov    -0x8(%rbp),%eax
   415d5:	48 98                	cltq   
   415d7:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   415de:	00 
   415df:	84 c0                	test   %al,%al
   415e1:	78 41                	js     41624 <check_virtual_memory+0x167>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   415e3:	8b 45 f8             	mov    -0x8(%rbp),%eax
   415e6:	48 98                	cltq   
   415e8:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   415ef:	00 
   415f0:	0f be c0             	movsbl %al,%eax
   415f3:	48 63 d0             	movslq %eax,%rdx
   415f6:	48 89 d0             	mov    %rdx,%rax
   415f9:	48 c1 e0 03          	shl    $0x3,%rax
   415fd:	48 29 d0             	sub    %rdx,%rax
   41600:	48 c1 e0 05          	shl    $0x5,%rax
   41604:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   4160a:	8b 00                	mov    (%rax),%eax
   4160c:	85 c0                	test   %eax,%eax
   4160e:	75 14                	jne    41624 <check_virtual_memory+0x167>
   41610:	ba e8 48 04 00       	mov    $0x448e8,%edx
   41615:	be ce 02 00 00       	mov    $0x2ce,%esi
   4161a:	bf 60 45 04 00       	mov    $0x44560,%edi
   4161f:	e8 e9 13 00 00       	call   42a0d <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41624:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41628:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   4162f:	7e 90                	jle    415c1 <check_virtual_memory+0x104>
        }
    }
}
   41631:	90                   	nop
   41632:	90                   	nop
   41633:	c9                   	leave  
   41634:	c3                   	ret    

0000000000041635 <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   41635:	55                   	push   %rbp
   41636:	48 89 e5             	mov    %rsp,%rbp
   41639:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   4163d:	ba 46 49 04 00       	mov    $0x44946,%edx
   41642:	be 00 0f 00 00       	mov    $0xf00,%esi
   41647:	bf 20 00 00 00       	mov    $0x20,%edi
   4164c:	b8 00 00 00 00       	mov    $0x0,%eax
   41651:	e8 49 2d 00 00       	call   4439f <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41656:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4165d:	e9 f8 00 00 00       	jmp    4175a <memshow_physical+0x125>
        if (pn % 64 == 0) {
   41662:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41665:	83 e0 3f             	and    $0x3f,%eax
   41668:	85 c0                	test   %eax,%eax
   4166a:	75 3c                	jne    416a8 <memshow_physical+0x73>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   4166c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4166f:	c1 e0 0c             	shl    $0xc,%eax
   41672:	89 c1                	mov    %eax,%ecx
   41674:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41677:	8d 50 3f             	lea    0x3f(%rax),%edx
   4167a:	85 c0                	test   %eax,%eax
   4167c:	0f 48 c2             	cmovs  %edx,%eax
   4167f:	c1 f8 06             	sar    $0x6,%eax
   41682:	8d 50 01             	lea    0x1(%rax),%edx
   41685:	89 d0                	mov    %edx,%eax
   41687:	c1 e0 02             	shl    $0x2,%eax
   4168a:	01 d0                	add    %edx,%eax
   4168c:	c1 e0 04             	shl    $0x4,%eax
   4168f:	83 c0 03             	add    $0x3,%eax
   41692:	ba 56 49 04 00       	mov    $0x44956,%edx
   41697:	be 00 0f 00 00       	mov    $0xf00,%esi
   4169c:	89 c7                	mov    %eax,%edi
   4169e:	b8 00 00 00 00       	mov    $0x0,%eax
   416a3:	e8 f7 2c 00 00       	call   4439f <console_printf>
        }

        int owner = pageinfo[pn].owner;
   416a8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   416ab:	48 98                	cltq   
   416ad:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   416b4:	00 
   416b5:	0f be c0             	movsbl %al,%eax
   416b8:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   416bb:	8b 45 fc             	mov    -0x4(%rbp),%eax
   416be:	48 98                	cltq   
   416c0:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   416c7:	00 
   416c8:	84 c0                	test   %al,%al
   416ca:	75 07                	jne    416d3 <memshow_physical+0x9e>
            owner = PO_FREE;
   416cc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   416d3:	8b 45 f8             	mov    -0x8(%rbp),%eax
   416d6:	83 c0 02             	add    $0x2,%eax
   416d9:	48 98                	cltq   
   416db:	0f b7 84 00 20 49 04 	movzwl 0x44920(%rax,%rax,1),%eax
   416e2:	00 
   416e3:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   416e7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   416ea:	48 98                	cltq   
   416ec:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   416f3:	00 
   416f4:	3c 01                	cmp    $0x1,%al
   416f6:	7e 1a                	jle    41712 <memshow_physical+0xdd>
   416f8:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   416fd:	48 c1 e8 0c          	shr    $0xc,%rax
   41701:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   41704:	74 0c                	je     41712 <memshow_physical+0xdd>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   41706:	b8 53 00 00 00       	mov    $0x53,%eax
   4170b:	80 cc 0f             	or     $0xf,%ah
   4170e:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   41712:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41715:	8d 50 3f             	lea    0x3f(%rax),%edx
   41718:	85 c0                	test   %eax,%eax
   4171a:	0f 48 c2             	cmovs  %edx,%eax
   4171d:	c1 f8 06             	sar    $0x6,%eax
   41720:	8d 50 01             	lea    0x1(%rax),%edx
   41723:	89 d0                	mov    %edx,%eax
   41725:	c1 e0 02             	shl    $0x2,%eax
   41728:	01 d0                	add    %edx,%eax
   4172a:	c1 e0 04             	shl    $0x4,%eax
   4172d:	89 c1                	mov    %eax,%ecx
   4172f:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41732:	89 d0                	mov    %edx,%eax
   41734:	c1 f8 1f             	sar    $0x1f,%eax
   41737:	c1 e8 1a             	shr    $0x1a,%eax
   4173a:	01 c2                	add    %eax,%edx
   4173c:	83 e2 3f             	and    $0x3f,%edx
   4173f:	29 c2                	sub    %eax,%edx
   41741:	89 d0                	mov    %edx,%eax
   41743:	83 c0 0c             	add    $0xc,%eax
   41746:	01 c8                	add    %ecx,%eax
   41748:	48 98                	cltq   
   4174a:	0f b7 55 f6          	movzwl -0xa(%rbp),%edx
   4174e:	66 89 94 00 00 80 0b 	mov    %dx,0xb8000(%rax,%rax,1)
   41755:	00 
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41756:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4175a:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41761:	0f 8e fb fe ff ff    	jle    41662 <memshow_physical+0x2d>
    }
}
   41767:	90                   	nop
   41768:	90                   	nop
   41769:	c9                   	leave  
   4176a:	c3                   	ret    

000000000004176b <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   4176b:	55                   	push   %rbp
   4176c:	48 89 e5             	mov    %rsp,%rbp
   4176f:	48 83 ec 40          	sub    $0x40,%rsp
   41773:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   41777:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   4177b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4177f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   41785:	48 89 c2             	mov    %rax,%rdx
   41788:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4178c:	48 39 c2             	cmp    %rax,%rdx
   4178f:	74 14                	je     417a5 <memshow_virtual+0x3a>
   41791:	ba 60 49 04 00       	mov    $0x44960,%edx
   41796:	be ff 02 00 00       	mov    $0x2ff,%esi
   4179b:	bf 60 45 04 00       	mov    $0x44560,%edi
   417a0:	e8 68 12 00 00       	call   42a0d <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   417a5:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   417a9:	48 89 c1             	mov    %rax,%rcx
   417ac:	ba 8d 49 04 00       	mov    $0x4498d,%edx
   417b1:	be 00 0f 00 00       	mov    $0xf00,%esi
   417b6:	bf 3a 03 00 00       	mov    $0x33a,%edi
   417bb:	b8 00 00 00 00       	mov    $0x0,%eax
   417c0:	e8 da 2b 00 00       	call   4439f <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   417c5:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   417cc:	00 
   417cd:	e9 80 01 00 00       	jmp    41952 <memshow_virtual+0x1e7>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   417d2:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   417d6:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   417da:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   417de:	48 89 ce             	mov    %rcx,%rsi
   417e1:	48 89 c7             	mov    %rax,%rdi
   417e4:	e8 e9 18 00 00       	call   430d2 <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   417e9:	8b 45 d0             	mov    -0x30(%rbp),%eax
   417ec:	85 c0                	test   %eax,%eax
   417ee:	79 0b                	jns    417fb <memshow_virtual+0x90>
            color = ' ';
   417f0:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   417f6:	e9 d7 00 00 00       	jmp    418d2 <memshow_virtual+0x167>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   417fb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   417ff:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   41805:	76 14                	jbe    4181b <memshow_virtual+0xb0>
   41807:	ba aa 49 04 00       	mov    $0x449aa,%edx
   4180c:	be 08 03 00 00       	mov    $0x308,%esi
   41811:	bf 60 45 04 00       	mov    $0x44560,%edi
   41816:	e8 f2 11 00 00       	call   42a0d <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   4181b:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4181e:	48 98                	cltq   
   41820:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   41827:	00 
   41828:	0f be c0             	movsbl %al,%eax
   4182b:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   4182e:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41831:	48 98                	cltq   
   41833:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   4183a:	00 
   4183b:	84 c0                	test   %al,%al
   4183d:	75 07                	jne    41846 <memshow_virtual+0xdb>
                owner = PO_FREE;
   4183f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   41846:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41849:	83 c0 02             	add    $0x2,%eax
   4184c:	48 98                	cltq   
   4184e:	0f b7 84 00 20 49 04 	movzwl 0x44920(%rax,%rax,1),%eax
   41855:	00 
   41856:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   4185a:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4185d:	48 98                	cltq   
   4185f:	83 e0 04             	and    $0x4,%eax
   41862:	48 85 c0             	test   %rax,%rax
   41865:	74 27                	je     4188e <memshow_virtual+0x123>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41867:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4186b:	c1 e0 04             	shl    $0x4,%eax
   4186e:	66 25 00 f0          	and    $0xf000,%ax
   41872:	89 c2                	mov    %eax,%edx
   41874:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41878:	c1 f8 04             	sar    $0x4,%eax
   4187b:	66 25 00 0f          	and    $0xf00,%ax
   4187f:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   41881:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41885:	0f b6 c0             	movzbl %al,%eax
   41888:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   4188a:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   4188e:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41891:	48 98                	cltq   
   41893:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   4189a:	00 
   4189b:	3c 01                	cmp    $0x1,%al
   4189d:	7e 33                	jle    418d2 <memshow_virtual+0x167>
   4189f:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   418a4:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   418a8:	74 28                	je     418d2 <memshow_virtual+0x167>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   418aa:	b8 53 00 00 00       	mov    $0x53,%eax
   418af:	89 c2                	mov    %eax,%edx
   418b1:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   418b5:	66 25 00 f0          	and    $0xf000,%ax
   418b9:	09 d0                	or     %edx,%eax
   418bb:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   418bf:	8b 45 e0             	mov    -0x20(%rbp),%eax
   418c2:	48 98                	cltq   
   418c4:	83 e0 04             	and    $0x4,%eax
   418c7:	48 85 c0             	test   %rax,%rax
   418ca:	75 06                	jne    418d2 <memshow_virtual+0x167>
                    color = color | 0x0F00;
   418cc:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   418d2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   418d6:	48 c1 e8 0c          	shr    $0xc,%rax
   418da:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   418dd:	8b 45 ec             	mov    -0x14(%rbp),%eax
   418e0:	83 e0 3f             	and    $0x3f,%eax
   418e3:	85 c0                	test   %eax,%eax
   418e5:	75 34                	jne    4191b <memshow_virtual+0x1b0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   418e7:	8b 45 ec             	mov    -0x14(%rbp),%eax
   418ea:	c1 e8 06             	shr    $0x6,%eax
   418ed:	89 c2                	mov    %eax,%edx
   418ef:	89 d0                	mov    %edx,%eax
   418f1:	c1 e0 02             	shl    $0x2,%eax
   418f4:	01 d0                	add    %edx,%eax
   418f6:	c1 e0 04             	shl    $0x4,%eax
   418f9:	05 73 03 00 00       	add    $0x373,%eax
   418fe:	89 c7                	mov    %eax,%edi
   41900:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41904:	48 89 c1             	mov    %rax,%rcx
   41907:	ba 56 49 04 00       	mov    $0x44956,%edx
   4190c:	be 00 0f 00 00       	mov    $0xf00,%esi
   41911:	b8 00 00 00 00       	mov    $0x0,%eax
   41916:	e8 84 2a 00 00       	call   4439f <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   4191b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4191e:	c1 e8 06             	shr    $0x6,%eax
   41921:	89 c2                	mov    %eax,%edx
   41923:	89 d0                	mov    %edx,%eax
   41925:	c1 e0 02             	shl    $0x2,%eax
   41928:	01 d0                	add    %edx,%eax
   4192a:	c1 e0 04             	shl    $0x4,%eax
   4192d:	89 c2                	mov    %eax,%edx
   4192f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41932:	83 e0 3f             	and    $0x3f,%eax
   41935:	01 d0                	add    %edx,%eax
   41937:	05 7c 03 00 00       	add    $0x37c,%eax
   4193c:	89 c2                	mov    %eax,%edx
   4193e:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41942:	66 89 84 12 00 80 0b 	mov    %ax,0xb8000(%rdx,%rdx,1)
   41949:	00 
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   4194a:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41951:	00 
   41952:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   41959:	00 
   4195a:	0f 86 72 fe ff ff    	jbe    417d2 <memshow_virtual+0x67>
    }
}
   41960:	90                   	nop
   41961:	90                   	nop
   41962:	c9                   	leave  
   41963:	c3                   	ret    

0000000000041964 <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   41964:	55                   	push   %rbp
   41965:	48 89 e5             	mov    %rsp,%rbp
   41968:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   4196c:	8b 05 ce 18 01 00    	mov    0x118ce(%rip),%eax        # 53240 <last_ticks.1>
   41972:	85 c0                	test   %eax,%eax
   41974:	74 13                	je     41989 <memshow_virtual_animate+0x25>
   41976:	8b 15 a4 14 01 00    	mov    0x114a4(%rip),%edx        # 52e20 <ticks>
   4197c:	8b 05 be 18 01 00    	mov    0x118be(%rip),%eax        # 53240 <last_ticks.1>
   41982:	29 c2                	sub    %eax,%edx
   41984:	83 fa 31             	cmp    $0x31,%edx
   41987:	76 2c                	jbe    419b5 <memshow_virtual_animate+0x51>
        last_ticks = ticks;
   41989:	8b 05 91 14 01 00    	mov    0x11491(%rip),%eax        # 52e20 <ticks>
   4198f:	89 05 ab 18 01 00    	mov    %eax,0x118ab(%rip)        # 53240 <last_ticks.1>
        ++showing;
   41995:	8b 05 69 46 00 00    	mov    0x4669(%rip),%eax        # 46004 <showing.0>
   4199b:	83 c0 01             	add    $0x1,%eax
   4199e:	89 05 60 46 00 00    	mov    %eax,0x4660(%rip)        # 46004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   419a4:	eb 0f                	jmp    419b5 <memshow_virtual_animate+0x51>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
        ++showing;
   419a6:	8b 05 58 46 00 00    	mov    0x4658(%rip),%eax        # 46004 <showing.0>
   419ac:	83 c0 01             	add    $0x1,%eax
   419af:	89 05 4f 46 00 00    	mov    %eax,0x464f(%rip)        # 46004 <showing.0>
    while (showing <= 2*NPROC
   419b5:	8b 05 49 46 00 00    	mov    0x4649(%rip),%eax        # 46004 <showing.0>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
   419bb:	83 f8 20             	cmp    $0x20,%eax
   419be:	7f 6d                	jg     41a2d <memshow_virtual_animate+0xc9>
   419c0:	8b 15 3e 46 00 00    	mov    0x463e(%rip),%edx        # 46004 <showing.0>
   419c6:	89 d0                	mov    %edx,%eax
   419c8:	c1 f8 1f             	sar    $0x1f,%eax
   419cb:	c1 e8 1c             	shr    $0x1c,%eax
   419ce:	01 c2                	add    %eax,%edx
   419d0:	83 e2 0f             	and    $0xf,%edx
   419d3:	29 c2                	sub    %eax,%edx
   419d5:	89 d0                	mov    %edx,%eax
   419d7:	48 63 d0             	movslq %eax,%rdx
   419da:	48 89 d0             	mov    %rdx,%rax
   419dd:	48 c1 e0 03          	shl    $0x3,%rax
   419e1:	48 29 d0             	sub    %rdx,%rax
   419e4:	48 c1 e0 05          	shl    $0x5,%rax
   419e8:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   419ee:	8b 00                	mov    (%rax),%eax
   419f0:	85 c0                	test   %eax,%eax
   419f2:	74 b2                	je     419a6 <memshow_virtual_animate+0x42>
   419f4:	8b 15 0a 46 00 00    	mov    0x460a(%rip),%edx        # 46004 <showing.0>
   419fa:	89 d0                	mov    %edx,%eax
   419fc:	c1 f8 1f             	sar    $0x1f,%eax
   419ff:	c1 e8 1c             	shr    $0x1c,%eax
   41a02:	01 c2                	add    %eax,%edx
   41a04:	83 e2 0f             	and    $0xf,%edx
   41a07:	29 c2                	sub    %eax,%edx
   41a09:	89 d0                	mov    %edx,%eax
   41a0b:	48 63 d0             	movslq %eax,%rdx
   41a0e:	48 89 d0             	mov    %rdx,%rax
   41a11:	48 c1 e0 03          	shl    $0x3,%rax
   41a15:	48 29 d0             	sub    %rdx,%rax
   41a18:	48 c1 e0 05          	shl    $0x5,%rax
   41a1c:	48 05 f8 20 05 00    	add    $0x520f8,%rax
   41a22:	0f b6 00             	movzbl (%rax),%eax
   41a25:	84 c0                	test   %al,%al
   41a27:	0f 84 79 ff ff ff    	je     419a6 <memshow_virtual_animate+0x42>
    }
    showing = showing % NPROC;
   41a2d:	8b 15 d1 45 00 00    	mov    0x45d1(%rip),%edx        # 46004 <showing.0>
   41a33:	89 d0                	mov    %edx,%eax
   41a35:	c1 f8 1f             	sar    $0x1f,%eax
   41a38:	c1 e8 1c             	shr    $0x1c,%eax
   41a3b:	01 c2                	add    %eax,%edx
   41a3d:	83 e2 0f             	and    $0xf,%edx
   41a40:	29 c2                	sub    %eax,%edx
   41a42:	89 d0                	mov    %edx,%eax
   41a44:	89 05 ba 45 00 00    	mov    %eax,0x45ba(%rip)        # 46004 <showing.0>

    if (processes[showing].p_state != P_FREE) {
   41a4a:	8b 05 b4 45 00 00    	mov    0x45b4(%rip),%eax        # 46004 <showing.0>
   41a50:	48 63 d0             	movslq %eax,%rdx
   41a53:	48 89 d0             	mov    %rdx,%rax
   41a56:	48 c1 e0 03          	shl    $0x3,%rax
   41a5a:	48 29 d0             	sub    %rdx,%rax
   41a5d:	48 c1 e0 05          	shl    $0x5,%rax
   41a61:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   41a67:	8b 00                	mov    (%rax),%eax
   41a69:	85 c0                	test   %eax,%eax
   41a6b:	74 52                	je     41abf <memshow_virtual_animate+0x15b>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   41a6d:	8b 15 91 45 00 00    	mov    0x4591(%rip),%edx        # 46004 <showing.0>
   41a73:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   41a77:	89 d1                	mov    %edx,%ecx
   41a79:	ba c4 49 04 00       	mov    $0x449c4,%edx
   41a7e:	be 04 00 00 00       	mov    $0x4,%esi
   41a83:	48 89 c7             	mov    %rax,%rdi
   41a86:	b8 00 00 00 00       	mov    $0x0,%eax
   41a8b:	e8 1b 2a 00 00       	call   444ab <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   41a90:	8b 05 6e 45 00 00    	mov    0x456e(%rip),%eax        # 46004 <showing.0>
   41a96:	48 63 d0             	movslq %eax,%rdx
   41a99:	48 89 d0             	mov    %rdx,%rax
   41a9c:	48 c1 e0 03          	shl    $0x3,%rax
   41aa0:	48 29 d0             	sub    %rdx,%rax
   41aa3:	48 c1 e0 05          	shl    $0x5,%rax
   41aa7:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   41aad:	48 8b 00             	mov    (%rax),%rax
   41ab0:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   41ab4:	48 89 d6             	mov    %rdx,%rsi
   41ab7:	48 89 c7             	mov    %rax,%rdi
   41aba:	e8 ac fc ff ff       	call   4176b <memshow_virtual>
    }
}
   41abf:	90                   	nop
   41ac0:	c9                   	leave  
   41ac1:	c3                   	ret    

0000000000041ac2 <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   41ac2:	55                   	push   %rbp
   41ac3:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   41ac6:	e8 4f 01 00 00       	call   41c1a <segments_init>
    interrupt_init();
   41acb:	e8 d0 03 00 00       	call   41ea0 <interrupt_init>
    virtual_memory_init();
   41ad0:	e8 f3 0f 00 00       	call   42ac8 <virtual_memory_init>
}
   41ad5:	90                   	nop
   41ad6:	5d                   	pop    %rbp
   41ad7:	c3                   	ret    

0000000000041ad8 <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   41ad8:	55                   	push   %rbp
   41ad9:	48 89 e5             	mov    %rsp,%rbp
   41adc:	48 83 ec 18          	sub    $0x18,%rsp
   41ae0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41ae4:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41ae8:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   41aeb:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41aee:	48 98                	cltq   
   41af0:	48 c1 e0 2d          	shl    $0x2d,%rax
   41af4:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   41af8:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   41aff:	90 00 00 
   41b02:	48 09 c2             	or     %rax,%rdx
    *segment = type
   41b05:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41b09:	48 89 10             	mov    %rdx,(%rax)
}
   41b0c:	90                   	nop
   41b0d:	c9                   	leave  
   41b0e:	c3                   	ret    

0000000000041b0f <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   41b0f:	55                   	push   %rbp
   41b10:	48 89 e5             	mov    %rsp,%rbp
   41b13:	48 83 ec 28          	sub    $0x28,%rsp
   41b17:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41b1b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41b1f:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41b22:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   41b26:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41b2a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41b2e:	48 c1 e0 10          	shl    $0x10,%rax
   41b32:	48 89 c2             	mov    %rax,%rdx
   41b35:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   41b3c:	00 00 00 
   41b3f:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   41b42:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41b46:	48 c1 e0 20          	shl    $0x20,%rax
   41b4a:	48 89 c1             	mov    %rax,%rcx
   41b4d:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   41b54:	00 00 ff 
   41b57:	48 21 c8             	and    %rcx,%rax
   41b5a:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   41b5d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41b61:	48 83 e8 01          	sub    $0x1,%rax
   41b65:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   41b68:	48 09 d0             	or     %rdx,%rax
        | type
   41b6b:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   41b6f:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41b72:	48 63 d2             	movslq %edx,%rdx
   41b75:	48 c1 e2 2d          	shl    $0x2d,%rdx
   41b79:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   41b7c:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   41b83:	80 00 00 
   41b86:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41b89:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41b8d:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   41b90:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41b94:	48 83 c0 08          	add    $0x8,%rax
   41b98:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   41b9c:	48 c1 ea 20          	shr    $0x20,%rdx
   41ba0:	48 89 10             	mov    %rdx,(%rax)
}
   41ba3:	90                   	nop
   41ba4:	c9                   	leave  
   41ba5:	c3                   	ret    

0000000000041ba6 <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   41ba6:	55                   	push   %rbp
   41ba7:	48 89 e5             	mov    %rsp,%rbp
   41baa:	48 83 ec 20          	sub    $0x20,%rsp
   41bae:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41bb2:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41bb6:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41bb9:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41bbd:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41bc1:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   41bc4:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   41bc8:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41bcb:	48 63 d2             	movslq %edx,%rdx
   41bce:	48 c1 e2 2d          	shl    $0x2d,%rdx
   41bd2:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   41bd5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41bd9:	48 c1 e0 20          	shl    $0x20,%rax
   41bdd:	48 89 c1             	mov    %rax,%rcx
   41be0:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   41be7:	00 ff ff 
   41bea:	48 21 c8             	and    %rcx,%rax
   41bed:	48 09 c2             	or     %rax,%rdx
   41bf0:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   41bf7:	80 00 00 
   41bfa:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41bfd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41c01:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   41c04:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41c08:	48 c1 e8 20          	shr    $0x20,%rax
   41c0c:	48 89 c2             	mov    %rax,%rdx
   41c0f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41c13:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   41c17:	90                   	nop
   41c18:	c9                   	leave  
   41c19:	c3                   	ret    

0000000000041c1a <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   41c1a:	55                   	push   %rbp
   41c1b:	48 89 e5             	mov    %rsp,%rbp
   41c1e:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   41c22:	48 c7 05 33 16 01 00 	movq   $0x0,0x11633(%rip)        # 53260 <segments>
   41c29:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   41c2d:	ba 00 00 00 00       	mov    $0x0,%edx
   41c32:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41c39:	08 20 00 
   41c3c:	48 89 c6             	mov    %rax,%rsi
   41c3f:	bf 68 32 05 00       	mov    $0x53268,%edi
   41c44:	e8 8f fe ff ff       	call   41ad8 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   41c49:	ba 03 00 00 00       	mov    $0x3,%edx
   41c4e:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41c55:	08 20 00 
   41c58:	48 89 c6             	mov    %rax,%rsi
   41c5b:	bf 70 32 05 00       	mov    $0x53270,%edi
   41c60:	e8 73 fe ff ff       	call   41ad8 <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   41c65:	ba 00 00 00 00       	mov    $0x0,%edx
   41c6a:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41c71:	02 00 00 
   41c74:	48 89 c6             	mov    %rax,%rsi
   41c77:	bf 78 32 05 00       	mov    $0x53278,%edi
   41c7c:	e8 57 fe ff ff       	call   41ad8 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   41c81:	ba 03 00 00 00       	mov    $0x3,%edx
   41c86:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41c8d:	02 00 00 
   41c90:	48 89 c6             	mov    %rax,%rsi
   41c93:	bf 80 32 05 00       	mov    $0x53280,%edi
   41c98:	e8 3b fe ff ff       	call   41ad8 <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   41c9d:	b8 a0 42 05 00       	mov    $0x542a0,%eax
   41ca2:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   41ca8:	48 89 c1             	mov    %rax,%rcx
   41cab:	ba 00 00 00 00       	mov    $0x0,%edx
   41cb0:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   41cb7:	09 00 00 
   41cba:	48 89 c6             	mov    %rax,%rsi
   41cbd:	bf 88 32 05 00       	mov    $0x53288,%edi
   41cc2:	e8 48 fe ff ff       	call   41b0f <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   41cc7:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   41ccd:	b8 60 32 05 00       	mov    $0x53260,%eax
   41cd2:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   41cd6:	ba 60 00 00 00       	mov    $0x60,%edx
   41cdb:	be 00 00 00 00       	mov    $0x0,%esi
   41ce0:	bf a0 42 05 00       	mov    $0x542a0,%edi
   41ce5:	e8 fe 18 00 00       	call   435e8 <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   41cea:	48 c7 05 af 25 01 00 	movq   $0x80000,0x125af(%rip)        # 542a4 <kernel_task_descriptor+0x4>
   41cf1:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   41cf5:	ba 00 10 00 00       	mov    $0x1000,%edx
   41cfa:	be 00 00 00 00       	mov    $0x0,%esi
   41cff:	bf a0 32 05 00       	mov    $0x532a0,%edi
   41d04:	e8 df 18 00 00       	call   435e8 <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41d09:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   41d10:	eb 30                	jmp    41d42 <segments_init+0x128>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   41d12:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   41d17:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41d1a:	48 c1 e0 04          	shl    $0x4,%rax
   41d1e:	48 05 a0 32 05 00    	add    $0x532a0,%rax
   41d24:	48 89 d1             	mov    %rdx,%rcx
   41d27:	ba 00 00 00 00       	mov    $0x0,%edx
   41d2c:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41d33:	0e 00 00 
   41d36:	48 89 c7             	mov    %rax,%rdi
   41d39:	e8 68 fe ff ff       	call   41ba6 <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41d3e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41d42:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   41d49:	76 c7                	jbe    41d12 <segments_init+0xf8>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   41d4b:	b8 36 00 04 00       	mov    $0x40036,%eax
   41d50:	48 89 c1             	mov    %rax,%rcx
   41d53:	ba 00 00 00 00       	mov    $0x0,%edx
   41d58:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41d5f:	0e 00 00 
   41d62:	48 89 c6             	mov    %rax,%rsi
   41d65:	bf a0 34 05 00       	mov    $0x534a0,%edi
   41d6a:	e8 37 fe ff ff       	call   41ba6 <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   41d6f:	b8 2e 00 04 00       	mov    $0x4002e,%eax
   41d74:	48 89 c1             	mov    %rax,%rcx
   41d77:	ba 00 00 00 00       	mov    $0x0,%edx
   41d7c:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41d83:	0e 00 00 
   41d86:	48 89 c6             	mov    %rax,%rsi
   41d89:	bf 70 33 05 00       	mov    $0x53370,%edi
   41d8e:	e8 13 fe ff ff       	call   41ba6 <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   41d93:	b8 32 00 04 00       	mov    $0x40032,%eax
   41d98:	48 89 c1             	mov    %rax,%rcx
   41d9b:	ba 00 00 00 00       	mov    $0x0,%edx
   41da0:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41da7:	0e 00 00 
   41daa:	48 89 c6             	mov    %rax,%rsi
   41dad:	bf 80 33 05 00       	mov    $0x53380,%edi
   41db2:	e8 ef fd ff ff       	call   41ba6 <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41db7:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   41dbe:	eb 3e                	jmp    41dfe <segments_init+0x1e4>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   41dc0:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41dc3:	83 e8 30             	sub    $0x30,%eax
   41dc6:	89 c0                	mov    %eax,%eax
   41dc8:	48 8b 04 c5 e7 00 04 	mov    0x400e7(,%rax,8),%rax
   41dcf:	00 
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   41dd0:	48 89 c2             	mov    %rax,%rdx
   41dd3:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41dd6:	48 c1 e0 04          	shl    $0x4,%rax
   41dda:	48 05 a0 32 05 00    	add    $0x532a0,%rax
   41de0:	48 89 d1             	mov    %rdx,%rcx
   41de3:	ba 03 00 00 00       	mov    $0x3,%edx
   41de8:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41def:	0e 00 00 
   41df2:	48 89 c7             	mov    %rax,%rdi
   41df5:	e8 ac fd ff ff       	call   41ba6 <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41dfa:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41dfe:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   41e02:	76 bc                	jbe    41dc0 <segments_init+0x1a6>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   41e04:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   41e0a:	b8 a0 32 05 00       	mov    $0x532a0,%eax
   41e0f:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   41e13:	b8 28 00 00 00       	mov    $0x28,%eax
   41e18:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   41e1c:	0f 00 d8             	ltr    %ax
   41e1f:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   41e23:	0f 20 c0             	mov    %cr0,%rax
   41e26:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   41e2a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   41e2e:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   41e31:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   41e38:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41e3b:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   41e3e:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41e41:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   41e45:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41e49:	0f 22 c0             	mov    %rax,%cr0
}
   41e4c:	90                   	nop
    lcr0(cr0);
}
   41e4d:	90                   	nop
   41e4e:	c9                   	leave  
   41e4f:	c3                   	ret    

0000000000041e50 <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   41e50:	55                   	push   %rbp
   41e51:	48 89 e5             	mov    %rsp,%rbp
   41e54:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   41e58:	0f b7 05 a1 24 01 00 	movzwl 0x124a1(%rip),%eax        # 54300 <interrupts_enabled>
   41e5f:	f7 d0                	not    %eax
   41e61:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   41e65:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41e69:	0f b6 c0             	movzbl %al,%eax
   41e6c:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   41e73:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e76:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   41e7a:	8b 55 f0             	mov    -0x10(%rbp),%edx
   41e7d:	ee                   	out    %al,(%dx)
}
   41e7e:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   41e7f:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41e83:	66 c1 e8 08          	shr    $0x8,%ax
   41e87:	0f b6 c0             	movzbl %al,%eax
   41e8a:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   41e91:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e94:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   41e98:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41e9b:	ee                   	out    %al,(%dx)
}
   41e9c:	90                   	nop
}
   41e9d:	90                   	nop
   41e9e:	c9                   	leave  
   41e9f:	c3                   	ret    

0000000000041ea0 <interrupt_init>:

void interrupt_init(void) {
   41ea0:	55                   	push   %rbp
   41ea1:	48 89 e5             	mov    %rsp,%rbp
   41ea4:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   41ea8:	66 c7 05 4f 24 01 00 	movw   $0x0,0x1244f(%rip)        # 54300 <interrupts_enabled>
   41eaf:	00 00 
    interrupt_mask();
   41eb1:	e8 9a ff ff ff       	call   41e50 <interrupt_mask>
   41eb6:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   41ebd:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ec1:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   41ec5:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   41ec8:	ee                   	out    %al,(%dx)
}
   41ec9:	90                   	nop
   41eca:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   41ed1:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ed5:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   41ed9:	8b 55 ac             	mov    -0x54(%rbp),%edx
   41edc:	ee                   	out    %al,(%dx)
}
   41edd:	90                   	nop
   41ede:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   41ee5:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ee9:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   41eed:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   41ef0:	ee                   	out    %al,(%dx)
}
   41ef1:	90                   	nop
   41ef2:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   41ef9:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41efd:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   41f01:	8b 55 bc             	mov    -0x44(%rbp),%edx
   41f04:	ee                   	out    %al,(%dx)
}
   41f05:	90                   	nop
   41f06:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   41f0d:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f11:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   41f15:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   41f18:	ee                   	out    %al,(%dx)
}
   41f19:	90                   	nop
   41f1a:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   41f21:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f25:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   41f29:	8b 55 cc             	mov    -0x34(%rbp),%edx
   41f2c:	ee                   	out    %al,(%dx)
}
   41f2d:	90                   	nop
   41f2e:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   41f35:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f39:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   41f3d:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   41f40:	ee                   	out    %al,(%dx)
}
   41f41:	90                   	nop
   41f42:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   41f49:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f4d:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   41f51:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41f54:	ee                   	out    %al,(%dx)
}
   41f55:	90                   	nop
   41f56:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   41f5d:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f61:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41f65:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41f68:	ee                   	out    %al,(%dx)
}
   41f69:	90                   	nop
   41f6a:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   41f71:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f75:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41f79:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41f7c:	ee                   	out    %al,(%dx)
}
   41f7d:	90                   	nop
   41f7e:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   41f85:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f89:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41f8d:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41f90:	ee                   	out    %al,(%dx)
}
   41f91:	90                   	nop
   41f92:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   41f99:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f9d:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41fa1:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41fa4:	ee                   	out    %al,(%dx)
}
   41fa5:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   41fa6:	e8 a5 fe ff ff       	call   41e50 <interrupt_mask>
}
   41fab:	90                   	nop
   41fac:	c9                   	leave  
   41fad:	c3                   	ret    

0000000000041fae <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   41fae:	55                   	push   %rbp
   41faf:	48 89 e5             	mov    %rsp,%rbp
   41fb2:	48 83 ec 28          	sub    $0x28,%rsp
   41fb6:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   41fb9:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41fbd:	0f 8e 9e 00 00 00    	jle    42061 <timer_init+0xb3>
   41fc3:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   41fca:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41fce:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41fd2:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41fd5:	ee                   	out    %al,(%dx)
}
   41fd6:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   41fd7:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41fda:	89 c2                	mov    %eax,%edx
   41fdc:	c1 ea 1f             	shr    $0x1f,%edx
   41fdf:	01 d0                	add    %edx,%eax
   41fe1:	d1 f8                	sar    %eax
   41fe3:	05 de 34 12 00       	add    $0x1234de,%eax
   41fe8:	99                   	cltd   
   41fe9:	f7 7d dc             	idivl  -0x24(%rbp)
   41fec:	89 c2                	mov    %eax,%edx
   41fee:	89 d0                	mov    %edx,%eax
   41ff0:	c1 f8 1f             	sar    $0x1f,%eax
   41ff3:	c1 e8 18             	shr    $0x18,%eax
   41ff6:	01 c2                	add    %eax,%edx
   41ff8:	0f b6 d2             	movzbl %dl,%edx
   41ffb:	29 c2                	sub    %eax,%edx
   41ffd:	89 d0                	mov    %edx,%eax
   41fff:	0f b6 c0             	movzbl %al,%eax
   42002:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   42009:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4200c:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   42010:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42013:	ee                   	out    %al,(%dx)
}
   42014:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   42015:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42018:	89 c2                	mov    %eax,%edx
   4201a:	c1 ea 1f             	shr    $0x1f,%edx
   4201d:	01 d0                	add    %edx,%eax
   4201f:	d1 f8                	sar    %eax
   42021:	05 de 34 12 00       	add    $0x1234de,%eax
   42026:	99                   	cltd   
   42027:	f7 7d dc             	idivl  -0x24(%rbp)
   4202a:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   42030:	85 c0                	test   %eax,%eax
   42032:	0f 48 c2             	cmovs  %edx,%eax
   42035:	c1 f8 08             	sar    $0x8,%eax
   42038:	0f b6 c0             	movzbl %al,%eax
   4203b:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   42042:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42045:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42049:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4204c:	ee                   	out    %al,(%dx)
}
   4204d:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   4204e:	0f b7 05 ab 22 01 00 	movzwl 0x122ab(%rip),%eax        # 54300 <interrupts_enabled>
   42055:	83 c8 01             	or     $0x1,%eax
   42058:	66 89 05 a1 22 01 00 	mov    %ax,0x122a1(%rip)        # 54300 <interrupts_enabled>
   4205f:	eb 11                	jmp    42072 <timer_init+0xc4>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   42061:	0f b7 05 98 22 01 00 	movzwl 0x12298(%rip),%eax        # 54300 <interrupts_enabled>
   42068:	83 e0 fe             	and    $0xfffffffe,%eax
   4206b:	66 89 05 8e 22 01 00 	mov    %ax,0x1228e(%rip)        # 54300 <interrupts_enabled>
    }
    interrupt_mask();
   42072:	e8 d9 fd ff ff       	call   41e50 <interrupt_mask>
}
   42077:	90                   	nop
   42078:	c9                   	leave  
   42079:	c3                   	ret    

000000000004207a <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   4207a:	55                   	push   %rbp
   4207b:	48 89 e5             	mov    %rsp,%rbp
   4207e:	48 83 ec 08          	sub    $0x8,%rsp
   42082:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   42086:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   4208b:	74 14                	je     420a1 <physical_memory_isreserved+0x27>
   4208d:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   42094:	00 
   42095:	76 11                	jbe    420a8 <physical_memory_isreserved+0x2e>
   42097:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   4209e:	00 
   4209f:	77 07                	ja     420a8 <physical_memory_isreserved+0x2e>
   420a1:	b8 01 00 00 00       	mov    $0x1,%eax
   420a6:	eb 05                	jmp    420ad <physical_memory_isreserved+0x33>
   420a8:	b8 00 00 00 00       	mov    $0x0,%eax
}
   420ad:	c9                   	leave  
   420ae:	c3                   	ret    

00000000000420af <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   420af:	55                   	push   %rbp
   420b0:	48 89 e5             	mov    %rsp,%rbp
   420b3:	48 83 ec 10          	sub    $0x10,%rsp
   420b7:	89 7d fc             	mov    %edi,-0x4(%rbp)
   420ba:	89 75 f8             	mov    %esi,-0x8(%rbp)
   420bd:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   420c0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   420c3:	c1 e0 10             	shl    $0x10,%eax
   420c6:	89 c2                	mov    %eax,%edx
   420c8:	8b 45 f8             	mov    -0x8(%rbp),%eax
   420cb:	c1 e0 0b             	shl    $0xb,%eax
   420ce:	09 c2                	or     %eax,%edx
   420d0:	8b 45 f4             	mov    -0xc(%rbp),%eax
   420d3:	c1 e0 08             	shl    $0x8,%eax
   420d6:	09 d0                	or     %edx,%eax
}
   420d8:	c9                   	leave  
   420d9:	c3                   	ret    

00000000000420da <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   420da:	55                   	push   %rbp
   420db:	48 89 e5             	mov    %rsp,%rbp
   420de:	48 83 ec 18          	sub    $0x18,%rsp
   420e2:	89 7d ec             	mov    %edi,-0x14(%rbp)
   420e5:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   420e8:	8b 55 ec             	mov    -0x14(%rbp),%edx
   420eb:	8b 45 e8             	mov    -0x18(%rbp),%eax
   420ee:	09 d0                	or     %edx,%eax
   420f0:	0d 00 00 00 80       	or     $0x80000000,%eax
   420f5:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   420fc:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   420ff:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42102:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42105:	ef                   	out    %eax,(%dx)
}
   42106:	90                   	nop
   42107:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   4210e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42111:	89 c2                	mov    %eax,%edx
   42113:	ed                   	in     (%dx),%eax
   42114:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   42117:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   4211a:	c9                   	leave  
   4211b:	c3                   	ret    

000000000004211c <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   4211c:	55                   	push   %rbp
   4211d:	48 89 e5             	mov    %rsp,%rbp
   42120:	48 83 ec 28          	sub    $0x28,%rsp
   42124:	89 7d dc             	mov    %edi,-0x24(%rbp)
   42127:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   4212a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42131:	eb 73                	jmp    421a6 <pci_find_device+0x8a>
        for (int slot = 0; slot != 32; ++slot) {
   42133:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   4213a:	eb 60                	jmp    4219c <pci_find_device+0x80>
            for (int func = 0; func != 8; ++func) {
   4213c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   42143:	eb 4a                	jmp    4218f <pci_find_device+0x73>
                int configaddr = pci_make_configaddr(bus, slot, func);
   42145:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42148:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   4214b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4214e:	89 ce                	mov    %ecx,%esi
   42150:	89 c7                	mov    %eax,%edi
   42152:	e8 58 ff ff ff       	call   420af <pci_make_configaddr>
   42157:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   4215a:	8b 45 f0             	mov    -0x10(%rbp),%eax
   4215d:	be 00 00 00 00       	mov    $0x0,%esi
   42162:	89 c7                	mov    %eax,%edi
   42164:	e8 71 ff ff ff       	call   420da <pci_config_readl>
   42169:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   4216c:	8b 45 d8             	mov    -0x28(%rbp),%eax
   4216f:	c1 e0 10             	shl    $0x10,%eax
   42172:	0b 45 dc             	or     -0x24(%rbp),%eax
   42175:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   42178:	75 05                	jne    4217f <pci_find_device+0x63>
                    return configaddr;
   4217a:	8b 45 f0             	mov    -0x10(%rbp),%eax
   4217d:	eb 35                	jmp    421b4 <pci_find_device+0x98>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   4217f:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   42183:	75 06                	jne    4218b <pci_find_device+0x6f>
   42185:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   42189:	74 0c                	je     42197 <pci_find_device+0x7b>
            for (int func = 0; func != 8; ++func) {
   4218b:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   4218f:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   42193:	75 b0                	jne    42145 <pci_find_device+0x29>
   42195:	eb 01                	jmp    42198 <pci_find_device+0x7c>
                    break;
   42197:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   42198:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   4219c:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   421a0:	75 9a                	jne    4213c <pci_find_device+0x20>
    for (int bus = 0; bus != 256; ++bus) {
   421a2:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   421a6:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   421ad:	75 84                	jne    42133 <pci_find_device+0x17>
                }
            }
        }
    }
    return -1;
   421af:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   421b4:	c9                   	leave  
   421b5:	c3                   	ret    

00000000000421b6 <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   421b6:	55                   	push   %rbp
   421b7:	48 89 e5             	mov    %rsp,%rbp
   421ba:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   421be:	be 13 71 00 00       	mov    $0x7113,%esi
   421c3:	bf 86 80 00 00       	mov    $0x8086,%edi
   421c8:	e8 4f ff ff ff       	call   4211c <pci_find_device>
   421cd:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   421d0:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   421d4:	78 30                	js     42206 <poweroff+0x50>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   421d6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   421d9:	be 40 00 00 00       	mov    $0x40,%esi
   421de:	89 c7                	mov    %eax,%edi
   421e0:	e8 f5 fe ff ff       	call   420da <pci_config_readl>
   421e5:	25 c0 ff 00 00       	and    $0xffc0,%eax
   421ea:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   421ed:	8b 45 f8             	mov    -0x8(%rbp),%eax
   421f0:	83 c0 04             	add    $0x4,%eax
   421f3:	89 45 f4             	mov    %eax,-0xc(%rbp)
   421f6:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   421fc:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   42200:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42203:	66 ef                	out    %ax,(%dx)
}
   42205:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   42206:	ba e0 49 04 00       	mov    $0x449e0,%edx
   4220b:	be 00 c0 00 00       	mov    $0xc000,%esi
   42210:	bf 80 07 00 00       	mov    $0x780,%edi
   42215:	b8 00 00 00 00       	mov    $0x0,%eax
   4221a:	e8 80 21 00 00       	call   4439f <console_printf>
 spinloop: goto spinloop;
   4221f:	eb fe                	jmp    4221f <poweroff+0x69>

0000000000042221 <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   42221:	55                   	push   %rbp
   42222:	48 89 e5             	mov    %rsp,%rbp
   42225:	48 83 ec 10          	sub    $0x10,%rsp
   42229:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   42230:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42234:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42238:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4223b:	ee                   	out    %al,(%dx)
}
   4223c:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   4223d:	eb fe                	jmp    4223d <reboot+0x1c>

000000000004223f <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   4223f:	55                   	push   %rbp
   42240:	48 89 e5             	mov    %rsp,%rbp
   42243:	48 83 ec 10          	sub    $0x10,%rsp
   42247:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4224b:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   4224e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42252:	48 83 c0 08          	add    $0x8,%rax
   42256:	ba c0 00 00 00       	mov    $0xc0,%edx
   4225b:	be 00 00 00 00       	mov    $0x0,%esi
   42260:	48 89 c7             	mov    %rax,%rdi
   42263:	e8 80 13 00 00       	call   435e8 <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   42268:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4226c:	66 c7 80 a8 00 00 00 	movw   $0x13,0xa8(%rax)
   42273:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   42275:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42279:	48 c7 80 80 00 00 00 	movq   $0x23,0x80(%rax)
   42280:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   42284:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42288:	48 c7 80 88 00 00 00 	movq   $0x23,0x88(%rax)
   4228f:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   42293:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42297:	66 c7 80 c0 00 00 00 	movw   $0x23,0xc0(%rax)
   4229e:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   422a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   422a4:	48 c7 80 b0 00 00 00 	movq   $0x200,0xb0(%rax)
   422ab:	00 02 00 00 
    p->display_status = 1;
   422af:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   422b3:	c6 80 d8 00 00 00 01 	movb   $0x1,0xd8(%rax)

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   422ba:	8b 45 f4             	mov    -0xc(%rbp),%eax
   422bd:	83 e0 01             	and    $0x1,%eax
   422c0:	85 c0                	test   %eax,%eax
   422c2:	74 1c                	je     422e0 <process_init+0xa1>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   422c4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   422c8:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   422cf:	80 cc 30             	or     $0x30,%ah
   422d2:	48 89 c2             	mov    %rax,%rdx
   422d5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   422d9:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   422e0:	8b 45 f4             	mov    -0xc(%rbp),%eax
   422e3:	83 e0 02             	and    $0x2,%eax
   422e6:	85 c0                	test   %eax,%eax
   422e8:	74 1c                	je     42306 <process_init+0xc7>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   422ea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   422ee:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   422f5:	80 e4 fd             	and    $0xfd,%ah
   422f8:	48 89 c2             	mov    %rax,%rdx
   422fb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   422ff:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
}
   42306:	90                   	nop
   42307:	c9                   	leave  
   42308:	c3                   	ret    

0000000000042309 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   42309:	55                   	push   %rbp
   4230a:	48 89 e5             	mov    %rsp,%rbp
   4230d:	48 83 ec 28          	sub    $0x28,%rsp
   42311:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   42314:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   42318:	78 09                	js     42323 <console_show_cursor+0x1a>
   4231a:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   42321:	7e 07                	jle    4232a <console_show_cursor+0x21>
        cpos = 0;
   42323:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   4232a:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   42331:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42335:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   42339:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   4233c:	ee                   	out    %al,(%dx)
}
   4233d:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   4233e:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42341:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   42347:	85 c0                	test   %eax,%eax
   42349:	0f 48 c2             	cmovs  %edx,%eax
   4234c:	c1 f8 08             	sar    $0x8,%eax
   4234f:	0f b6 c0             	movzbl %al,%eax
   42352:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   42359:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4235c:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   42360:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42363:	ee                   	out    %al,(%dx)
}
   42364:	90                   	nop
   42365:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   4236c:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42370:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   42374:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42377:	ee                   	out    %al,(%dx)
}
   42378:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   42379:	8b 55 dc             	mov    -0x24(%rbp),%edx
   4237c:	89 d0                	mov    %edx,%eax
   4237e:	c1 f8 1f             	sar    $0x1f,%eax
   42381:	c1 e8 18             	shr    $0x18,%eax
   42384:	01 c2                	add    %eax,%edx
   42386:	0f b6 d2             	movzbl %dl,%edx
   42389:	29 c2                	sub    %eax,%edx
   4238b:	89 d0                	mov    %edx,%eax
   4238d:	0f b6 c0             	movzbl %al,%eax
   42390:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   42397:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4239a:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4239e:	8b 55 fc             	mov    -0x4(%rbp),%edx
   423a1:	ee                   	out    %al,(%dx)
}
   423a2:	90                   	nop
}
   423a3:	90                   	nop
   423a4:	c9                   	leave  
   423a5:	c3                   	ret    

00000000000423a6 <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   423a6:	55                   	push   %rbp
   423a7:	48 89 e5             	mov    %rsp,%rbp
   423aa:	48 83 ec 20          	sub    $0x20,%rsp
   423ae:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   423b5:	8b 45 f0             	mov    -0x10(%rbp),%eax
   423b8:	89 c2                	mov    %eax,%edx
   423ba:	ec                   	in     (%dx),%al
   423bb:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   423be:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   423c2:	0f b6 c0             	movzbl %al,%eax
   423c5:	83 e0 01             	and    $0x1,%eax
   423c8:	85 c0                	test   %eax,%eax
   423ca:	75 0a                	jne    423d6 <keyboard_readc+0x30>
        return -1;
   423cc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   423d1:	e9 e7 01 00 00       	jmp    425bd <keyboard_readc+0x217>
   423d6:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   423dd:	8b 45 e8             	mov    -0x18(%rbp),%eax
   423e0:	89 c2                	mov    %eax,%edx
   423e2:	ec                   	in     (%dx),%al
   423e3:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   423e6:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   423ea:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   423ed:	0f b6 05 0e 1f 01 00 	movzbl 0x11f0e(%rip),%eax        # 54302 <last_escape.2>
   423f4:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   423f7:	c6 05 04 1f 01 00 00 	movb   $0x0,0x11f04(%rip)        # 54302 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   423fe:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   42402:	75 11                	jne    42415 <keyboard_readc+0x6f>
        last_escape = 0x80;
   42404:	c6 05 f7 1e 01 00 80 	movb   $0x80,0x11ef7(%rip)        # 54302 <last_escape.2>
        return 0;
   4240b:	b8 00 00 00 00       	mov    $0x0,%eax
   42410:	e9 a8 01 00 00       	jmp    425bd <keyboard_readc+0x217>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   42415:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42419:	84 c0                	test   %al,%al
   4241b:	79 60                	jns    4247d <keyboard_readc+0xd7>
        int ch = keymap[(data & 0x7F) | escape];
   4241d:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42421:	83 e0 7f             	and    $0x7f,%eax
   42424:	89 c2                	mov    %eax,%edx
   42426:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   4242a:	09 d0                	or     %edx,%eax
   4242c:	48 98                	cltq   
   4242e:	0f b6 80 00 4a 04 00 	movzbl 0x44a00(%rax),%eax
   42435:	0f b6 c0             	movzbl %al,%eax
   42438:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   4243b:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   42442:	7e 2f                	jle    42473 <keyboard_readc+0xcd>
   42444:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   4244b:	7f 26                	jg     42473 <keyboard_readc+0xcd>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   4244d:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42450:	2d fa 00 00 00       	sub    $0xfa,%eax
   42455:	ba 01 00 00 00       	mov    $0x1,%edx
   4245a:	89 c1                	mov    %eax,%ecx
   4245c:	d3 e2                	shl    %cl,%edx
   4245e:	89 d0                	mov    %edx,%eax
   42460:	f7 d0                	not    %eax
   42462:	89 c2                	mov    %eax,%edx
   42464:	0f b6 05 98 1e 01 00 	movzbl 0x11e98(%rip),%eax        # 54303 <modifiers.1>
   4246b:	21 d0                	and    %edx,%eax
   4246d:	88 05 90 1e 01 00    	mov    %al,0x11e90(%rip)        # 54303 <modifiers.1>
        }
        return 0;
   42473:	b8 00 00 00 00       	mov    $0x0,%eax
   42478:	e9 40 01 00 00       	jmp    425bd <keyboard_readc+0x217>
    }

    int ch = (unsigned char) keymap[data | escape];
   4247d:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42481:	0a 45 fa             	or     -0x6(%rbp),%al
   42484:	0f b6 c0             	movzbl %al,%eax
   42487:	48 98                	cltq   
   42489:	0f b6 80 00 4a 04 00 	movzbl 0x44a00(%rax),%eax
   42490:	0f b6 c0             	movzbl %al,%eax
   42493:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   42496:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   4249a:	7e 57                	jle    424f3 <keyboard_readc+0x14d>
   4249c:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   424a0:	7f 51                	jg     424f3 <keyboard_readc+0x14d>
        if (modifiers & MOD_CONTROL) {
   424a2:	0f b6 05 5a 1e 01 00 	movzbl 0x11e5a(%rip),%eax        # 54303 <modifiers.1>
   424a9:	0f b6 c0             	movzbl %al,%eax
   424ac:	83 e0 02             	and    $0x2,%eax
   424af:	85 c0                	test   %eax,%eax
   424b1:	74 09                	je     424bc <keyboard_readc+0x116>
            ch -= 0x60;
   424b3:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   424b7:	e9 fd 00 00 00       	jmp    425b9 <keyboard_readc+0x213>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   424bc:	0f b6 05 40 1e 01 00 	movzbl 0x11e40(%rip),%eax        # 54303 <modifiers.1>
   424c3:	0f b6 c0             	movzbl %al,%eax
   424c6:	83 e0 01             	and    $0x1,%eax
   424c9:	85 c0                	test   %eax,%eax
   424cb:	0f 94 c2             	sete   %dl
   424ce:	0f b6 05 2e 1e 01 00 	movzbl 0x11e2e(%rip),%eax        # 54303 <modifiers.1>
   424d5:	0f b6 c0             	movzbl %al,%eax
   424d8:	83 e0 08             	and    $0x8,%eax
   424db:	85 c0                	test   %eax,%eax
   424dd:	0f 94 c0             	sete   %al
   424e0:	31 d0                	xor    %edx,%eax
   424e2:	84 c0                	test   %al,%al
   424e4:	0f 84 cf 00 00 00    	je     425b9 <keyboard_readc+0x213>
            ch -= 0x20;
   424ea:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   424ee:	e9 c6 00 00 00       	jmp    425b9 <keyboard_readc+0x213>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   424f3:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   424fa:	7e 30                	jle    4252c <keyboard_readc+0x186>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   424fc:	8b 45 fc             	mov    -0x4(%rbp),%eax
   424ff:	2d fa 00 00 00       	sub    $0xfa,%eax
   42504:	ba 01 00 00 00       	mov    $0x1,%edx
   42509:	89 c1                	mov    %eax,%ecx
   4250b:	d3 e2                	shl    %cl,%edx
   4250d:	89 d0                	mov    %edx,%eax
   4250f:	89 c2                	mov    %eax,%edx
   42511:	0f b6 05 eb 1d 01 00 	movzbl 0x11deb(%rip),%eax        # 54303 <modifiers.1>
   42518:	31 d0                	xor    %edx,%eax
   4251a:	88 05 e3 1d 01 00    	mov    %al,0x11de3(%rip)        # 54303 <modifiers.1>
        ch = 0;
   42520:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42527:	e9 8e 00 00 00       	jmp    425ba <keyboard_readc+0x214>
    } else if (ch >= KEY_SHIFT) {
   4252c:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   42533:	7e 2d                	jle    42562 <keyboard_readc+0x1bc>
        modifiers |= 1 << (ch - KEY_SHIFT);
   42535:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42538:	2d fa 00 00 00       	sub    $0xfa,%eax
   4253d:	ba 01 00 00 00       	mov    $0x1,%edx
   42542:	89 c1                	mov    %eax,%ecx
   42544:	d3 e2                	shl    %cl,%edx
   42546:	89 d0                	mov    %edx,%eax
   42548:	89 c2                	mov    %eax,%edx
   4254a:	0f b6 05 b2 1d 01 00 	movzbl 0x11db2(%rip),%eax        # 54303 <modifiers.1>
   42551:	09 d0                	or     %edx,%eax
   42553:	88 05 aa 1d 01 00    	mov    %al,0x11daa(%rip)        # 54303 <modifiers.1>
        ch = 0;
   42559:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42560:	eb 58                	jmp    425ba <keyboard_readc+0x214>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   42562:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   42566:	7e 31                	jle    42599 <keyboard_readc+0x1f3>
   42568:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   4256f:	7f 28                	jg     42599 <keyboard_readc+0x1f3>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   42571:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42574:	8d 50 80             	lea    -0x80(%rax),%edx
   42577:	0f b6 05 85 1d 01 00 	movzbl 0x11d85(%rip),%eax        # 54303 <modifiers.1>
   4257e:	0f b6 c0             	movzbl %al,%eax
   42581:	83 e0 03             	and    $0x3,%eax
   42584:	48 98                	cltq   
   42586:	48 63 d2             	movslq %edx,%rdx
   42589:	0f b6 84 90 00 4b 04 	movzbl 0x44b00(%rax,%rdx,4),%eax
   42590:	00 
   42591:	0f b6 c0             	movzbl %al,%eax
   42594:	89 45 fc             	mov    %eax,-0x4(%rbp)
   42597:	eb 21                	jmp    425ba <keyboard_readc+0x214>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   42599:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   4259d:	7f 1b                	jg     425ba <keyboard_readc+0x214>
   4259f:	0f b6 05 5d 1d 01 00 	movzbl 0x11d5d(%rip),%eax        # 54303 <modifiers.1>
   425a6:	0f b6 c0             	movzbl %al,%eax
   425a9:	83 e0 02             	and    $0x2,%eax
   425ac:	85 c0                	test   %eax,%eax
   425ae:	74 0a                	je     425ba <keyboard_readc+0x214>
        ch = 0;
   425b0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   425b7:	eb 01                	jmp    425ba <keyboard_readc+0x214>
        if (modifiers & MOD_CONTROL) {
   425b9:	90                   	nop
    }

    return ch;
   425ba:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   425bd:	c9                   	leave  
   425be:	c3                   	ret    

00000000000425bf <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   425bf:	55                   	push   %rbp
   425c0:	48 89 e5             	mov    %rsp,%rbp
   425c3:	48 83 ec 20          	sub    $0x20,%rsp
   425c7:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   425ce:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   425d1:	89 c2                	mov    %eax,%edx
   425d3:	ec                   	in     (%dx),%al
   425d4:	88 45 e3             	mov    %al,-0x1d(%rbp)
   425d7:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   425de:	8b 45 ec             	mov    -0x14(%rbp),%eax
   425e1:	89 c2                	mov    %eax,%edx
   425e3:	ec                   	in     (%dx),%al
   425e4:	88 45 eb             	mov    %al,-0x15(%rbp)
   425e7:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   425ee:	8b 45 f4             	mov    -0xc(%rbp),%eax
   425f1:	89 c2                	mov    %eax,%edx
   425f3:	ec                   	in     (%dx),%al
   425f4:	88 45 f3             	mov    %al,-0xd(%rbp)
   425f7:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   425fe:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42601:	89 c2                	mov    %eax,%edx
   42603:	ec                   	in     (%dx),%al
   42604:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   42607:	90                   	nop
   42608:	c9                   	leave  
   42609:	c3                   	ret    

000000000004260a <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   4260a:	55                   	push   %rbp
   4260b:	48 89 e5             	mov    %rsp,%rbp
   4260e:	48 83 ec 40          	sub    $0x40,%rsp
   42612:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42616:	89 f0                	mov    %esi,%eax
   42618:	89 55 c0             	mov    %edx,-0x40(%rbp)
   4261b:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   4261e:	8b 05 e0 1c 01 00    	mov    0x11ce0(%rip),%eax        # 54304 <initialized.0>
   42624:	85 c0                	test   %eax,%eax
   42626:	75 1e                	jne    42646 <parallel_port_putc+0x3c>
   42628:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   4262f:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42633:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   42637:	8b 55 f8             	mov    -0x8(%rbp),%edx
   4263a:	ee                   	out    %al,(%dx)
}
   4263b:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   4263c:	c7 05 be 1c 01 00 01 	movl   $0x1,0x11cbe(%rip)        # 54304 <initialized.0>
   42643:	00 00 00 
    }

    for (int i = 0;
   42646:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4264d:	eb 09                	jmp    42658 <parallel_port_putc+0x4e>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   4264f:	e8 6b ff ff ff       	call   425bf <delay>
         ++i) {
   42654:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   42658:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   4265f:	7f 18                	jg     42679 <parallel_port_putc+0x6f>
   42661:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42668:	8b 45 f0             	mov    -0x10(%rbp),%eax
   4266b:	89 c2                	mov    %eax,%edx
   4266d:	ec                   	in     (%dx),%al
   4266e:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   42671:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   42675:	84 c0                	test   %al,%al
   42677:	79 d6                	jns    4264f <parallel_port_putc+0x45>
    }
    outb(IO_PARALLEL1_DATA, c);
   42679:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   4267d:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   42684:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42687:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   4268b:	8b 55 d8             	mov    -0x28(%rbp),%edx
   4268e:	ee                   	out    %al,(%dx)
}
   4268f:	90                   	nop
   42690:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   42697:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4269b:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   4269f:	8b 55 e0             	mov    -0x20(%rbp),%edx
   426a2:	ee                   	out    %al,(%dx)
}
   426a3:	90                   	nop
   426a4:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   426ab:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   426af:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   426b3:	8b 55 e8             	mov    -0x18(%rbp),%edx
   426b6:	ee                   	out    %al,(%dx)
}
   426b7:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   426b8:	90                   	nop
   426b9:	c9                   	leave  
   426ba:	c3                   	ret    

00000000000426bb <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   426bb:	55                   	push   %rbp
   426bc:	48 89 e5             	mov    %rsp,%rbp
   426bf:	48 83 ec 20          	sub    $0x20,%rsp
   426c3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   426c7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   426cb:	48 c7 45 f8 0a 26 04 	movq   $0x4260a,-0x8(%rbp)
   426d2:	00 
    printer_vprintf(&p, 0, format, val);
   426d3:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   426d7:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   426db:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   426df:	be 00 00 00 00       	mov    $0x0,%esi
   426e4:	48 89 c7             	mov    %rax,%rdi
   426e7:	e8 98 11 00 00       	call   43884 <printer_vprintf>
}
   426ec:	90                   	nop
   426ed:	c9                   	leave  
   426ee:	c3                   	ret    

00000000000426ef <log_printf>:

void log_printf(const char* format, ...) {
   426ef:	55                   	push   %rbp
   426f0:	48 89 e5             	mov    %rsp,%rbp
   426f3:	48 83 ec 60          	sub    $0x60,%rsp
   426f7:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   426fb:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   426ff:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42703:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42707:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4270b:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   4270f:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   42716:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4271a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   4271e:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42722:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   42726:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   4272a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4272e:	48 89 d6             	mov    %rdx,%rsi
   42731:	48 89 c7             	mov    %rax,%rdi
   42734:	e8 82 ff ff ff       	call   426bb <log_vprintf>
    va_end(val);
}
   42739:	90                   	nop
   4273a:	c9                   	leave  
   4273b:	c3                   	ret    

000000000004273c <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   4273c:	55                   	push   %rbp
   4273d:	48 89 e5             	mov    %rsp,%rbp
   42740:	48 83 ec 40          	sub    $0x40,%rsp
   42744:	89 7d dc             	mov    %edi,-0x24(%rbp)
   42747:	89 75 d8             	mov    %esi,-0x28(%rbp)
   4274a:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   4274e:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   42752:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   42756:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   4275a:	48 8b 0a             	mov    (%rdx),%rcx
   4275d:	48 89 08             	mov    %rcx,(%rax)
   42760:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   42764:	48 89 48 08          	mov    %rcx,0x8(%rax)
   42768:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   4276c:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   42770:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   42774:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42778:	48 89 d6             	mov    %rdx,%rsi
   4277b:	48 89 c7             	mov    %rax,%rdi
   4277e:	e8 38 ff ff ff       	call   426bb <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   42783:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42787:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   4278b:	8b 75 d8             	mov    -0x28(%rbp),%esi
   4278e:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42791:	89 c7                	mov    %eax,%edi
   42793:	e8 9b 1b 00 00       	call   44333 <console_vprintf>
}
   42798:	c9                   	leave  
   42799:	c3                   	ret    

000000000004279a <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   4279a:	55                   	push   %rbp
   4279b:	48 89 e5             	mov    %rsp,%rbp
   4279e:	48 83 ec 60          	sub    $0x60,%rsp
   427a2:	89 7d ac             	mov    %edi,-0x54(%rbp)
   427a5:	89 75 a8             	mov    %esi,-0x58(%rbp)
   427a8:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   427ac:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   427b0:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   427b4:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   427b8:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   427bf:	48 8d 45 10          	lea    0x10(%rbp),%rax
   427c3:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   427c7:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   427cb:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   427cf:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   427d3:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   427d7:	8b 75 a8             	mov    -0x58(%rbp),%esi
   427da:	8b 45 ac             	mov    -0x54(%rbp),%eax
   427dd:	89 c7                	mov    %eax,%edi
   427df:	e8 58 ff ff ff       	call   4273c <error_vprintf>
   427e4:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   427e7:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   427ea:	c9                   	leave  
   427eb:	c3                   	ret    

00000000000427ec <check_keyboard>:
//    Check for the user typing a control key. 'a', 'f', and 'e' cause a soft
//    reboot where the kernel runs the allocator programs, "fork", or
//    "forkexit", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   427ec:	55                   	push   %rbp
   427ed:	48 89 e5             	mov    %rsp,%rbp
   427f0:	53                   	push   %rbx
   427f1:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   427f5:	e8 ac fb ff ff       	call   423a6 <keyboard_readc>
   427fa:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   427fd:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42801:	74 1c                	je     4281f <check_keyboard+0x33>
   42803:	83 7d e4 66          	cmpl   $0x66,-0x1c(%rbp)
   42807:	74 16                	je     4281f <check_keyboard+0x33>
   42809:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   4280d:	74 10                	je     4281f <check_keyboard+0x33>
   4280f:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42813:	74 0a                	je     4281f <check_keyboard+0x33>
   42815:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42819:	0f 85 e9 00 00 00    	jne    42908 <check_keyboard+0x11c>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   4281f:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   42826:	00 
        memset(pt, 0, PAGESIZE * 3);
   42827:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4282b:	ba 00 30 00 00       	mov    $0x3000,%edx
   42830:	be 00 00 00 00       	mov    $0x0,%esi
   42835:	48 89 c7             	mov    %rax,%rdi
   42838:	e8 ab 0d 00 00       	call   435e8 <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   4283d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42841:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   42848:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4284c:	48 05 00 10 00 00    	add    $0x1000,%rax
   42852:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   42859:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4285d:	48 05 00 20 00 00    	add    $0x2000,%rax
   42863:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   4286a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4286e:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42872:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42876:	0f 22 d8             	mov    %rax,%cr3
}
   42879:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   4287a:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "fork";
   42881:	48 c7 45 e8 58 4b 04 	movq   $0x44b58,-0x18(%rbp)
   42888:	00 
        if (c == 'a') {
   42889:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   4288d:	75 0a                	jne    42899 <check_keyboard+0xad>
            argument = "allocator";
   4288f:	48 c7 45 e8 5d 4b 04 	movq   $0x44b5d,-0x18(%rbp)
   42896:	00 
   42897:	eb 2e                	jmp    428c7 <check_keyboard+0xdb>
        } else if (c == 'e') {
   42899:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   4289d:	75 0a                	jne    428a9 <check_keyboard+0xbd>
            argument = "forkexit";
   4289f:	48 c7 45 e8 67 4b 04 	movq   $0x44b67,-0x18(%rbp)
   428a6:	00 
   428a7:	eb 1e                	jmp    428c7 <check_keyboard+0xdb>
        }
        else if (c == 't'){
   428a9:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   428ad:	75 0a                	jne    428b9 <check_keyboard+0xcd>
            argument = "test";
   428af:	48 c7 45 e8 70 4b 04 	movq   $0x44b70,-0x18(%rbp)
   428b6:	00 
   428b7:	eb 0e                	jmp    428c7 <check_keyboard+0xdb>
        }
        else if(c == '2'){
   428b9:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   428bd:	75 08                	jne    428c7 <check_keyboard+0xdb>
            argument = "test2";
   428bf:	48 c7 45 e8 75 4b 04 	movq   $0x44b75,-0x18(%rbp)
   428c6:	00 
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   428c7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   428cb:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   428cf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   428d4:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   428d8:	73 14                	jae    428ee <check_keyboard+0x102>
   428da:	ba 7b 4b 04 00       	mov    $0x44b7b,%edx
   428df:	be 5d 02 00 00       	mov    $0x25d,%esi
   428e4:	bf 97 4b 04 00       	mov    $0x44b97,%edi
   428e9:	e8 1f 01 00 00       	call   42a0d <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   428ee:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   428f2:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   428f5:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   428f9:	48 89 c3             	mov    %rax,%rbx
   428fc:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   42901:	e9 fa d6 ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   42906:	eb 11                	jmp    42919 <check_keyboard+0x12d>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   42908:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   4290c:	74 06                	je     42914 <check_keyboard+0x128>
   4290e:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   42912:	75 05                	jne    42919 <check_keyboard+0x12d>
        poweroff();
   42914:	e8 9d f8 ff ff       	call   421b6 <poweroff>
    }
    return c;
   42919:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   4291c:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42920:	c9                   	leave  
   42921:	c3                   	ret    

0000000000042922 <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   42922:	55                   	push   %rbp
   42923:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   42926:	e8 c1 fe ff ff       	call   427ec <check_keyboard>
   4292b:	eb f9                	jmp    42926 <fail+0x4>

000000000004292d <panic>:

// panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void panic(const char* format, ...) {
   4292d:	55                   	push   %rbp
   4292e:	48 89 e5             	mov    %rsp,%rbp
   42931:	48 83 ec 60          	sub    $0x60,%rsp
   42935:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42939:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   4293d:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42941:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42945:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42949:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   4294d:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   42954:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42958:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   4295c:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42960:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   42964:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   42969:	0f 84 80 00 00 00    	je     429ef <panic+0xc2>
        // Print panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   4296f:	ba ab 4b 04 00       	mov    $0x44bab,%edx
   42974:	be 00 c0 00 00       	mov    $0xc000,%esi
   42979:	bf 30 07 00 00       	mov    $0x730,%edi
   4297e:	b8 00 00 00 00       	mov    $0x0,%eax
   42983:	e8 12 fe ff ff       	call   4279a <error_printf>
   42988:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   4298b:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   4298f:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   42993:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42996:	be 00 c0 00 00       	mov    $0xc000,%esi
   4299b:	89 c7                	mov    %eax,%edi
   4299d:	e8 9a fd ff ff       	call   4273c <error_vprintf>
   429a2:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   429a5:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   429a8:	48 63 c1             	movslq %ecx,%rax
   429ab:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   429b2:	48 c1 e8 20          	shr    $0x20,%rax
   429b6:	89 c2                	mov    %eax,%edx
   429b8:	c1 fa 05             	sar    $0x5,%edx
   429bb:	89 c8                	mov    %ecx,%eax
   429bd:	c1 f8 1f             	sar    $0x1f,%eax
   429c0:	29 c2                	sub    %eax,%edx
   429c2:	89 d0                	mov    %edx,%eax
   429c4:	c1 e0 02             	shl    $0x2,%eax
   429c7:	01 d0                	add    %edx,%eax
   429c9:	c1 e0 04             	shl    $0x4,%eax
   429cc:	29 c1                	sub    %eax,%ecx
   429ce:	89 ca                	mov    %ecx,%edx
   429d0:	85 d2                	test   %edx,%edx
   429d2:	74 34                	je     42a08 <panic+0xdb>
            error_printf(cpos, 0xC000, "\n");
   429d4:	8b 45 cc             	mov    -0x34(%rbp),%eax
   429d7:	ba b3 4b 04 00       	mov    $0x44bb3,%edx
   429dc:	be 00 c0 00 00       	mov    $0xc000,%esi
   429e1:	89 c7                	mov    %eax,%edi
   429e3:	b8 00 00 00 00       	mov    $0x0,%eax
   429e8:	e8 ad fd ff ff       	call   4279a <error_printf>
   429ed:	eb 19                	jmp    42a08 <panic+0xdb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   429ef:	ba b5 4b 04 00       	mov    $0x44bb5,%edx
   429f4:	be 00 c0 00 00       	mov    $0xc000,%esi
   429f9:	bf 30 07 00 00       	mov    $0x730,%edi
   429fe:	b8 00 00 00 00       	mov    $0x0,%eax
   42a03:	e8 92 fd ff ff       	call   4279a <error_printf>
    }

    va_end(val);
    fail();
   42a08:	e8 15 ff ff ff       	call   42922 <fail>

0000000000042a0d <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   42a0d:	55                   	push   %rbp
   42a0e:	48 89 e5             	mov    %rsp,%rbp
   42a11:	48 83 ec 20          	sub    $0x20,%rsp
   42a15:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42a19:	89 75 f4             	mov    %esi,-0xc(%rbp)
   42a1c:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   42a20:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   42a24:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42a27:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42a2b:	48 89 c6             	mov    %rax,%rsi
   42a2e:	bf bb 4b 04 00       	mov    $0x44bbb,%edi
   42a33:	b8 00 00 00 00       	mov    $0x0,%eax
   42a38:	e8 f0 fe ff ff       	call   4292d <panic>

0000000000042a3d <default_exception>:
}

void default_exception(proc* p){
   42a3d:	55                   	push   %rbp
   42a3e:	48 89 e5             	mov    %rsp,%rbp
   42a41:	48 83 ec 20          	sub    $0x20,%rsp
   42a45:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   42a49:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42a4d:	48 83 c0 08          	add    $0x8,%rax
   42a51:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    panic("Unexpected exception %d!\n", reg->reg_intno);
   42a55:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42a59:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   42a60:	48 89 c6             	mov    %rax,%rsi
   42a63:	bf d9 4b 04 00       	mov    $0x44bd9,%edi
   42a68:	b8 00 00 00 00       	mov    $0x0,%eax
   42a6d:	e8 bb fe ff ff       	call   4292d <panic>

0000000000042a72 <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   42a72:	55                   	push   %rbp
   42a73:	48 89 e5             	mov    %rsp,%rbp
   42a76:	48 83 ec 10          	sub    $0x10,%rsp
   42a7a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42a7e:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   42a81:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   42a85:	78 06                	js     42a8d <pageindex+0x1b>
   42a87:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   42a8b:	7e 14                	jle    42aa1 <pageindex+0x2f>
   42a8d:	ba f8 4b 04 00       	mov    $0x44bf8,%edx
   42a92:	be 1e 00 00 00       	mov    $0x1e,%esi
   42a97:	bf 11 4c 04 00       	mov    $0x44c11,%edi
   42a9c:	e8 6c ff ff ff       	call   42a0d <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   42aa1:	b8 03 00 00 00       	mov    $0x3,%eax
   42aa6:	2b 45 f4             	sub    -0xc(%rbp),%eax
   42aa9:	89 c2                	mov    %eax,%edx
   42aab:	89 d0                	mov    %edx,%eax
   42aad:	c1 e0 03             	shl    $0x3,%eax
   42ab0:	01 d0                	add    %edx,%eax
   42ab2:	83 c0 0c             	add    $0xc,%eax
   42ab5:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42ab9:	89 c1                	mov    %eax,%ecx
   42abb:	48 d3 ea             	shr    %cl,%rdx
   42abe:	48 89 d0             	mov    %rdx,%rax
   42ac1:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   42ac6:	c9                   	leave  
   42ac7:	c3                   	ret    

0000000000042ac8 <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   42ac8:	55                   	push   %rbp
   42ac9:	48 89 e5             	mov    %rsp,%rbp
   42acc:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   42ad0:	48 c7 05 25 25 01 00 	movq   $0x56000,0x12525(%rip)        # 55000 <kernel_pagetable>
   42ad7:	00 60 05 00 
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   42adb:	ba 00 50 00 00       	mov    $0x5000,%edx
   42ae0:	be 00 00 00 00       	mov    $0x0,%esi
   42ae5:	bf 00 60 05 00       	mov    $0x56000,%edi
   42aea:	e8 f9 0a 00 00       	call   435e8 <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   42aef:	b8 00 70 05 00       	mov    $0x57000,%eax
   42af4:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   42af8:	48 89 05 01 35 01 00 	mov    %rax,0x13501(%rip)        # 56000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   42aff:	b8 00 80 05 00       	mov    $0x58000,%eax
   42b04:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   42b08:	48 89 05 f1 44 01 00 	mov    %rax,0x144f1(%rip)        # 57000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   42b0f:	b8 00 90 05 00       	mov    $0x59000,%eax
   42b14:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   42b18:	48 89 05 e1 54 01 00 	mov    %rax,0x154e1(%rip)        # 58000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   42b1f:	b8 00 a0 05 00       	mov    $0x5a000,%eax
   42b24:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   42b28:	48 89 05 d9 54 01 00 	mov    %rax,0x154d9(%rip)        # 58008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   42b2f:	48 8b 05 ca 24 01 00 	mov    0x124ca(%rip),%rax        # 55000 <kernel_pagetable>
   42b36:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42b3c:	b9 00 00 20 00       	mov    $0x200000,%ecx
   42b41:	ba 00 00 00 00       	mov    $0x0,%edx
   42b46:	be 00 00 00 00       	mov    $0x0,%esi
   42b4b:	48 89 c7             	mov    %rax,%rdi
   42b4e:	e8 b9 01 00 00       	call   42d0c <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42b53:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42b5a:	00 
   42b5b:	eb 62                	jmp    42bbf <virtual_memory_init+0xf7>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   42b5d:	48 8b 0d 9c 24 01 00 	mov    0x1249c(%rip),%rcx        # 55000 <kernel_pagetable>
   42b64:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42b68:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42b6c:	48 89 ce             	mov    %rcx,%rsi
   42b6f:	48 89 c7             	mov    %rax,%rdi
   42b72:	e8 5b 05 00 00       	call   430d2 <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l1pagetable ?
        assert(vmap.pa == addr);
   42b77:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b7b:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   42b7f:	74 14                	je     42b95 <virtual_memory_init+0xcd>
   42b81:	ba 25 4c 04 00       	mov    $0x44c25,%edx
   42b86:	be 2d 00 00 00       	mov    $0x2d,%esi
   42b8b:	bf 35 4c 04 00       	mov    $0x44c35,%edi
   42b90:	e8 78 fe ff ff       	call   42a0d <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   42b95:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42b98:	48 98                	cltq   
   42b9a:	83 e0 03             	and    $0x3,%eax
   42b9d:	48 83 f8 03          	cmp    $0x3,%rax
   42ba1:	74 14                	je     42bb7 <virtual_memory_init+0xef>
   42ba3:	ba 48 4c 04 00       	mov    $0x44c48,%edx
   42ba8:	be 2e 00 00 00       	mov    $0x2e,%esi
   42bad:	bf 35 4c 04 00       	mov    $0x44c35,%edi
   42bb2:	e8 56 fe ff ff       	call   42a0d <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42bb7:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42bbe:	00 
   42bbf:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   42bc6:	00 
   42bc7:	76 94                	jbe    42b5d <virtual_memory_init+0x95>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   42bc9:	48 8b 05 30 24 01 00 	mov    0x12430(%rip),%rax        # 55000 <kernel_pagetable>
   42bd0:	48 89 c7             	mov    %rax,%rdi
   42bd3:	e8 03 00 00 00       	call   42bdb <set_pagetable>
}
   42bd8:	90                   	nop
   42bd9:	c9                   	leave  
   42bda:	c3                   	ret    

0000000000042bdb <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   42bdb:	55                   	push   %rbp
   42bdc:	48 89 e5             	mov    %rsp,%rbp
   42bdf:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   42be3:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   42be7:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42beb:	25 ff 0f 00 00       	and    $0xfff,%eax
   42bf0:	48 85 c0             	test   %rax,%rax
   42bf3:	74 14                	je     42c09 <set_pagetable+0x2e>
   42bf5:	ba 75 4c 04 00       	mov    $0x44c75,%edx
   42bfa:	be 3d 00 00 00       	mov    $0x3d,%esi
   42bff:	bf 35 4c 04 00       	mov    $0x44c35,%edi
   42c04:	e8 04 fe ff ff       	call   42a0d <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   42c09:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42c0e:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   42c12:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42c16:	48 89 ce             	mov    %rcx,%rsi
   42c19:	48 89 c7             	mov    %rax,%rdi
   42c1c:	e8 b1 04 00 00       	call   430d2 <virtual_memory_lookup>
   42c21:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42c25:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42c2a:	48 39 d0             	cmp    %rdx,%rax
   42c2d:	74 14                	je     42c43 <set_pagetable+0x68>
   42c2f:	ba 90 4c 04 00       	mov    $0x44c90,%edx
   42c34:	be 3f 00 00 00       	mov    $0x3f,%esi
   42c39:	bf 35 4c 04 00       	mov    $0x44c35,%edi
   42c3e:	e8 ca fd ff ff       	call   42a0d <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   42c43:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   42c47:	48 8b 0d b2 23 01 00 	mov    0x123b2(%rip),%rcx        # 55000 <kernel_pagetable>
   42c4e:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   42c52:	48 89 ce             	mov    %rcx,%rsi
   42c55:	48 89 c7             	mov    %rax,%rdi
   42c58:	e8 75 04 00 00       	call   430d2 <virtual_memory_lookup>
   42c5d:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42c61:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42c65:	48 39 c2             	cmp    %rax,%rdx
   42c68:	74 14                	je     42c7e <set_pagetable+0xa3>
   42c6a:	ba f8 4c 04 00       	mov    $0x44cf8,%edx
   42c6f:	be 41 00 00 00       	mov    $0x41,%esi
   42c74:	bf 35 4c 04 00       	mov    $0x44c35,%edi
   42c79:	e8 8f fd ff ff       	call   42a0d <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   42c7e:	48 8b 05 7b 23 01 00 	mov    0x1237b(%rip),%rax        # 55000 <kernel_pagetable>
   42c85:	48 89 c2             	mov    %rax,%rdx
   42c88:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   42c8c:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42c90:	48 89 ce             	mov    %rcx,%rsi
   42c93:	48 89 c7             	mov    %rax,%rdi
   42c96:	e8 37 04 00 00       	call   430d2 <virtual_memory_lookup>
   42c9b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42c9f:	48 8b 15 5a 23 01 00 	mov    0x1235a(%rip),%rdx        # 55000 <kernel_pagetable>
   42ca6:	48 39 d0             	cmp    %rdx,%rax
   42ca9:	74 14                	je     42cbf <set_pagetable+0xe4>
   42cab:	ba 58 4d 04 00       	mov    $0x44d58,%edx
   42cb0:	be 43 00 00 00       	mov    $0x43,%esi
   42cb5:	bf 35 4c 04 00       	mov    $0x44c35,%edi
   42cba:	e8 4e fd ff ff       	call   42a0d <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   42cbf:	ba 0c 2d 04 00       	mov    $0x42d0c,%edx
   42cc4:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42cc8:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42ccc:	48 89 ce             	mov    %rcx,%rsi
   42ccf:	48 89 c7             	mov    %rax,%rdi
   42cd2:	e8 fb 03 00 00       	call   430d2 <virtual_memory_lookup>
   42cd7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42cdb:	ba 0c 2d 04 00       	mov    $0x42d0c,%edx
   42ce0:	48 39 d0             	cmp    %rdx,%rax
   42ce3:	74 14                	je     42cf9 <set_pagetable+0x11e>
   42ce5:	ba c0 4d 04 00       	mov    $0x44dc0,%edx
   42cea:	be 45 00 00 00       	mov    $0x45,%esi
   42cef:	bf 35 4c 04 00       	mov    $0x44c35,%edi
   42cf4:	e8 14 fd ff ff       	call   42a0d <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   42cf9:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42cfd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42d01:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42d05:	0f 22 d8             	mov    %rax,%cr3
}
   42d08:	90                   	nop
}
   42d09:	90                   	nop
   42d0a:	c9                   	leave  
   42d0b:	c3                   	ret    

0000000000042d0c <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   42d0c:	55                   	push   %rbp
   42d0d:	48 89 e5             	mov    %rsp,%rbp
   42d10:	41 54                	push   %r12
   42d12:	53                   	push   %rbx
   42d13:	48 83 ec 50          	sub    $0x50,%rsp
   42d17:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42d1b:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42d1f:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   42d23:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
   42d27:	44 89 45 ac          	mov    %r8d,-0x54(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   42d2b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42d2f:	25 ff 0f 00 00       	and    $0xfff,%eax
   42d34:	48 85 c0             	test   %rax,%rax
   42d37:	74 14                	je     42d4d <virtual_memory_map+0x41>
   42d39:	ba 26 4e 04 00       	mov    $0x44e26,%edx
   42d3e:	be 66 00 00 00       	mov    $0x66,%esi
   42d43:	bf 35 4c 04 00       	mov    $0x44c35,%edi
   42d48:	e8 c0 fc ff ff       	call   42a0d <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   42d4d:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42d51:	25 ff 0f 00 00       	and    $0xfff,%eax
   42d56:	48 85 c0             	test   %rax,%rax
   42d59:	74 14                	je     42d6f <virtual_memory_map+0x63>
   42d5b:	ba 39 4e 04 00       	mov    $0x44e39,%edx
   42d60:	be 67 00 00 00       	mov    $0x67,%esi
   42d65:	bf 35 4c 04 00       	mov    $0x44c35,%edi
   42d6a:	e8 9e fc ff ff       	call   42a0d <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   42d6f:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42d73:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42d77:	48 01 d0             	add    %rdx,%rax
   42d7a:	48 3b 45 c0          	cmp    -0x40(%rbp),%rax
   42d7e:	73 24                	jae    42da4 <virtual_memory_map+0x98>
   42d80:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42d84:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42d88:	48 01 d0             	add    %rdx,%rax
   42d8b:	48 85 c0             	test   %rax,%rax
   42d8e:	74 14                	je     42da4 <virtual_memory_map+0x98>
   42d90:	ba 4c 4e 04 00       	mov    $0x44e4c,%edx
   42d95:	be 68 00 00 00       	mov    $0x68,%esi
   42d9a:	bf 35 4c 04 00       	mov    $0x44c35,%edi
   42d9f:	e8 69 fc ff ff       	call   42a0d <assert_fail>
    if (perm & PTE_P) {
   42da4:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42da7:	48 98                	cltq   
   42da9:	83 e0 01             	and    $0x1,%eax
   42dac:	48 85 c0             	test   %rax,%rax
   42daf:	74 6e                	je     42e1f <virtual_memory_map+0x113>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   42db1:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42db5:	25 ff 0f 00 00       	and    $0xfff,%eax
   42dba:	48 85 c0             	test   %rax,%rax
   42dbd:	74 14                	je     42dd3 <virtual_memory_map+0xc7>
   42dbf:	ba 6a 4e 04 00       	mov    $0x44e6a,%edx
   42dc4:	be 6a 00 00 00       	mov    $0x6a,%esi
   42dc9:	bf 35 4c 04 00       	mov    $0x44c35,%edi
   42dce:	e8 3a fc ff ff       	call   42a0d <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   42dd3:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42dd7:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42ddb:	48 01 d0             	add    %rdx,%rax
   42dde:	48 3b 45 b8          	cmp    -0x48(%rbp),%rax
   42de2:	73 14                	jae    42df8 <virtual_memory_map+0xec>
   42de4:	ba 7d 4e 04 00       	mov    $0x44e7d,%edx
   42de9:	be 6b 00 00 00       	mov    $0x6b,%esi
   42dee:	bf 35 4c 04 00       	mov    $0x44c35,%edi
   42df3:	e8 15 fc ff ff       	call   42a0d <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   42df8:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42dfc:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42e00:	48 01 d0             	add    %rdx,%rax
   42e03:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   42e09:	76 14                	jbe    42e1f <virtual_memory_map+0x113>
   42e0b:	ba 8b 4e 04 00       	mov    $0x44e8b,%edx
   42e10:	be 6c 00 00 00       	mov    $0x6c,%esi
   42e15:	bf 35 4c 04 00       	mov    $0x44c35,%edi
   42e1a:	e8 ee fb ff ff       	call   42a0d <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   42e1f:	83 7d ac 00          	cmpl   $0x0,-0x54(%rbp)
   42e23:	78 09                	js     42e2e <virtual_memory_map+0x122>
   42e25:	81 7d ac ff 0f 00 00 	cmpl   $0xfff,-0x54(%rbp)
   42e2c:	7e 14                	jle    42e42 <virtual_memory_map+0x136>
   42e2e:	ba a7 4e 04 00       	mov    $0x44ea7,%edx
   42e33:	be 6e 00 00 00       	mov    $0x6e,%esi
   42e38:	bf 35 4c 04 00       	mov    $0x44c35,%edi
   42e3d:	e8 cb fb ff ff       	call   42a0d <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   42e42:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42e46:	25 ff 0f 00 00       	and    $0xfff,%eax
   42e4b:	48 85 c0             	test   %rax,%rax
   42e4e:	74 14                	je     42e64 <virtual_memory_map+0x158>
   42e50:	ba c8 4e 04 00       	mov    $0x44ec8,%edx
   42e55:	be 6f 00 00 00       	mov    $0x6f,%esi
   42e5a:	bf 35 4c 04 00       	mov    $0x44c35,%edi
   42e5f:	e8 a9 fb ff ff       	call   42a0d <assert_fail>

    int last_index123 = -1;
   42e64:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%rbp)
    x86_64_pagetable* l1pagetable = NULL;
   42e6b:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
   42e72:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42e73:	e9 e7 00 00 00       	jmp    42f5f <virtual_memory_map+0x253>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   42e78:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42e7c:	48 c1 e8 15          	shr    $0x15,%rax
   42e80:	89 45 dc             	mov    %eax,-0x24(%rbp)
        if (cur_index123 != last_index123) {
   42e83:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42e86:	3b 45 ec             	cmp    -0x14(%rbp),%eax
   42e89:	74 20                	je     42eab <virtual_memory_map+0x19f>
            // TODO --> done
            // find pointer to last level pagetable for current va

			l1pagetable = lookup_l1pagetable(pagetable, va, perm);	
   42e8b:	8b 55 ac             	mov    -0x54(%rbp),%edx
   42e8e:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   42e92:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42e96:	48 89 ce             	mov    %rcx,%rsi
   42e99:	48 89 c7             	mov    %rax,%rdi
   42e9c:	e8 d7 00 00 00       	call   42f78 <lookup_l1pagetable>
   42ea1:	48 89 45 e0          	mov    %rax,-0x20(%rbp)

            last_index123 = cur_index123;
   42ea5:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42ea8:	89 45 ec             	mov    %eax,-0x14(%rbp)
        }
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   42eab:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42eae:	48 98                	cltq   
   42eb0:	83 e0 01             	and    $0x1,%eax
   42eb3:	48 85 c0             	test   %rax,%rax
   42eb6:	74 3a                	je     42ef2 <virtual_memory_map+0x1e6>
   42eb8:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42ebd:	74 33                	je     42ef2 <virtual_memory_map+0x1e6>
            // TODO --> done
            // map `pa` at appropriate entry with permissions `perm`
			l1pagetable->entry[L1PAGEINDEX(va)] =  (0x00000000FFFFFFFF & pa) | perm;
   42ebf:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42ec3:	41 89 c4             	mov    %eax,%r12d
   42ec6:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42ec9:	48 63 d8             	movslq %eax,%rbx
   42ecc:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42ed0:	be 03 00 00 00       	mov    $0x3,%esi
   42ed5:	48 89 c7             	mov    %rax,%rdi
   42ed8:	e8 95 fb ff ff       	call   42a72 <pageindex>
   42edd:	89 c2                	mov    %eax,%edx
   42edf:	4c 89 e1             	mov    %r12,%rcx
   42ee2:	48 09 d9             	or     %rbx,%rcx
   42ee5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42ee9:	48 63 d2             	movslq %edx,%rdx
   42eec:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42ef0:	eb 55                	jmp    42f47 <virtual_memory_map+0x23b>

        } else if (l1pagetable) { // if page is NOT marked present
   42ef2:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42ef7:	74 26                	je     42f1f <virtual_memory_map+0x213>
            // TODO --> done
            // map to address 0 with `perm`
			l1pagetable->entry[L1PAGEINDEX(va)] = 0 | perm;
   42ef9:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42efd:	be 03 00 00 00       	mov    $0x3,%esi
   42f02:	48 89 c7             	mov    %rax,%rdi
   42f05:	e8 68 fb ff ff       	call   42a72 <pageindex>
   42f0a:	89 c2                	mov    %eax,%edx
   42f0c:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42f0f:	48 63 c8             	movslq %eax,%rcx
   42f12:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42f16:	48 63 d2             	movslq %edx,%rdx
   42f19:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42f1d:	eb 28                	jmp    42f47 <virtual_memory_map+0x23b>

        } else if (perm & PTE_P) {
   42f1f:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42f22:	48 98                	cltq   
   42f24:	83 e0 01             	and    $0x1,%eax
   42f27:	48 85 c0             	test   %rax,%rax
   42f2a:	74 1b                	je     42f47 <virtual_memory_map+0x23b>
            // error, no allocated l1 page found for va
            log_printf("[Kern Info] failed to find l1pagetable address at " __FILE__ ": %d\n", __LINE__);
   42f2c:	be 8b 00 00 00       	mov    $0x8b,%esi
   42f31:	bf f0 4e 04 00       	mov    $0x44ef0,%edi
   42f36:	b8 00 00 00 00       	mov    $0x0,%eax
   42f3b:	e8 af f7 ff ff       	call   426ef <log_printf>
            return -1;
   42f40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42f45:	eb 28                	jmp    42f6f <virtual_memory_map+0x263>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42f47:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
   42f4e:	00 
   42f4f:	48 81 45 b8 00 10 00 	addq   $0x1000,-0x48(%rbp)
   42f56:	00 
   42f57:	48 81 6d b0 00 10 00 	subq   $0x1000,-0x50(%rbp)
   42f5e:	00 
   42f5f:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   42f64:	0f 85 0e ff ff ff    	jne    42e78 <virtual_memory_map+0x16c>
        }
    }
    return 0;
   42f6a:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42f6f:	48 83 c4 50          	add    $0x50,%rsp
   42f73:	5b                   	pop    %rbx
   42f74:	41 5c                	pop    %r12
   42f76:	5d                   	pop    %rbp
   42f77:	c3                   	ret    

0000000000042f78 <lookup_l1pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   42f78:	55                   	push   %rbp
   42f79:	48 89 e5             	mov    %rsp,%rbp
   42f7c:	48 83 ec 40          	sub    $0x40,%rsp
   42f80:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42f84:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42f88:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   42f8b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42f8f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l1 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   42f93:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   42f9a:	e9 23 01 00 00       	jmp    430c2 <lookup_l1pagetable+0x14a>
        // TODO --> done
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        x86_64_pageentry_t pe = pt->entry[PAGEINDEX(va, i)]; // replace this
   42f9f:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42fa2:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42fa6:	89 d6                	mov    %edx,%esi
   42fa8:	48 89 c7             	mov    %rax,%rdi
   42fab:	e8 c2 fa ff ff       	call   42a72 <pageindex>
   42fb0:	89 c2                	mov    %eax,%edx
   42fb2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42fb6:	48 63 d2             	movslq %edx,%rdx
   42fb9:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   42fbd:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   42fc1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42fc5:	83 e0 01             	and    $0x1,%eax
   42fc8:	48 85 c0             	test   %rax,%rax
   42fcb:	75 63                	jne    43030 <lookup_l1pagetable+0xb8>
            log_printf("[Kern Info] Error looking up l1pagetable: Pagetable address: 0x%x perm: 0x%x."
   42fcd:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42fd0:	8d 48 02             	lea    0x2(%rax),%ecx
   42fd3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42fd7:	25 ff 0f 00 00       	and    $0xfff,%eax
   42fdc:	48 89 c2             	mov    %rax,%rdx
   42fdf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42fe3:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42fe9:	48 89 c6             	mov    %rax,%rsi
   42fec:	bf 38 4f 04 00       	mov    $0x44f38,%edi
   42ff1:	b8 00 00 00 00       	mov    $0x0,%eax
   42ff6:	e8 f4 f6 ff ff       	call   426ef <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   42ffb:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42ffe:	48 98                	cltq   
   43000:	83 e0 01             	and    $0x1,%eax
   43003:	48 85 c0             	test   %rax,%rax
   43006:	75 0a                	jne    43012 <lookup_l1pagetable+0x9a>
                return NULL;
   43008:	b8 00 00 00 00       	mov    $0x0,%eax
   4300d:	e9 be 00 00 00       	jmp    430d0 <lookup_l1pagetable+0x158>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   43012:	be af 00 00 00       	mov    $0xaf,%esi
   43017:	bf a0 4f 04 00       	mov    $0x44fa0,%edi
   4301c:	b8 00 00 00 00       	mov    $0x0,%eax
   43021:	e8 c9 f6 ff ff       	call   426ef <log_printf>
            return NULL;
   43026:	b8 00 00 00 00       	mov    $0x0,%eax
   4302b:	e9 a0 00 00 00       	jmp    430d0 <lookup_l1pagetable+0x158>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   43030:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43034:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4303a:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   43040:	76 14                	jbe    43056 <lookup_l1pagetable+0xde>
   43042:	ba e8 4f 04 00       	mov    $0x44fe8,%edx
   43047:	be b4 00 00 00       	mov    $0xb4,%esi
   4304c:	bf 35 4c 04 00       	mov    $0x44c35,%edi
   43051:	e8 b7 f9 ff ff       	call   42a0d <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   43056:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43059:	48 98                	cltq   
   4305b:	83 e0 02             	and    $0x2,%eax
   4305e:	48 85 c0             	test   %rax,%rax
   43061:	74 20                	je     43083 <lookup_l1pagetable+0x10b>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   43063:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43067:	83 e0 02             	and    $0x2,%eax
   4306a:	48 85 c0             	test   %rax,%rax
   4306d:	75 14                	jne    43083 <lookup_l1pagetable+0x10b>
   4306f:	ba 08 50 04 00       	mov    $0x45008,%edx
   43074:	be b6 00 00 00       	mov    $0xb6,%esi
   43079:	bf 35 4c 04 00       	mov    $0x44c35,%edi
   4307e:	e8 8a f9 ff ff       	call   42a0d <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   43083:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43086:	48 98                	cltq   
   43088:	83 e0 04             	and    $0x4,%eax
   4308b:	48 85 c0             	test   %rax,%rax
   4308e:	74 20                	je     430b0 <lookup_l1pagetable+0x138>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   43090:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43094:	83 e0 04             	and    $0x4,%eax
   43097:	48 85 c0             	test   %rax,%rax
   4309a:	75 14                	jne    430b0 <lookup_l1pagetable+0x138>
   4309c:	ba 13 50 04 00       	mov    $0x45013,%edx
   430a1:	be b9 00 00 00       	mov    $0xb9,%esi
   430a6:	bf 35 4c 04 00       	mov    $0x44c35,%edi
   430ab:	e8 5d f9 ff ff       	call   42a0d <assert_fail>
        }

        // TODO --> done
        // set pt to physical address to next pagetable using `pe`
        pt = (x86_64_pagetable *) PTE_ADDR(pe); // replace this
   430b0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   430b4:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   430ba:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   430be:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   430c2:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   430c6:	0f 8e d3 fe ff ff    	jle    42f9f <lookup_l1pagetable+0x27>
    }
    return pt;
   430cc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   430d0:	c9                   	leave  
   430d1:	c3                   	ret    

00000000000430d2 <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   430d2:	55                   	push   %rbp
   430d3:	48 89 e5             	mov    %rsp,%rbp
   430d6:	48 83 ec 50          	sub    $0x50,%rsp
   430da:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   430de:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   430e2:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   430e6:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   430ea:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   430ee:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   430f5:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   430f6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   430fd:	eb 41                	jmp    43140 <virtual_memory_lookup+0x6e>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   430ff:	8b 55 ec             	mov    -0x14(%rbp),%edx
   43102:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   43106:	89 d6                	mov    %edx,%esi
   43108:	48 89 c7             	mov    %rax,%rdi
   4310b:	e8 62 f9 ff ff       	call   42a72 <pageindex>
   43110:	89 c2                	mov    %eax,%edx
   43112:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43116:	48 63 d2             	movslq %edx,%rdx
   43119:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   4311d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43121:	83 e0 06             	and    $0x6,%eax
   43124:	48 f7 d0             	not    %rax
   43127:	48 21 d0             	and    %rdx,%rax
   4312a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   4312e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43132:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43138:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   4313c:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   43140:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   43144:	7f 0c                	jg     43152 <virtual_memory_lookup+0x80>
   43146:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4314a:	83 e0 01             	and    $0x1,%eax
   4314d:	48 85 c0             	test   %rax,%rax
   43150:	75 ad                	jne    430ff <virtual_memory_lookup+0x2d>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   43152:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   43159:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   43160:	ff 
   43161:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   43168:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4316c:	83 e0 01             	and    $0x1,%eax
   4316f:	48 85 c0             	test   %rax,%rax
   43172:	74 34                	je     431a8 <virtual_memory_lookup+0xd6>
        vam.pn = PAGENUMBER(pe);
   43174:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43178:	48 c1 e8 0c          	shr    $0xc,%rax
   4317c:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   4317f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43183:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43189:	48 89 c2             	mov    %rax,%rdx
   4318c:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   43190:	25 ff 0f 00 00       	and    $0xfff,%eax
   43195:	48 09 d0             	or     %rdx,%rax
   43198:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   4319c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   431a0:	25 ff 0f 00 00       	and    $0xfff,%eax
   431a5:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   431a8:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   431ac:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   431b0:	48 89 10             	mov    %rdx,(%rax)
   431b3:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   431b7:	48 89 50 08          	mov    %rdx,0x8(%rax)
   431bb:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   431bf:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   431c3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   431c7:	c9                   	leave  
   431c8:	c3                   	ret    

00000000000431c9 <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   431c9:	55                   	push   %rbp
   431ca:	48 89 e5             	mov    %rsp,%rbp
   431cd:	48 83 ec 40          	sub    $0x40,%rsp
   431d1:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   431d5:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   431d8:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   431dc:	c7 45 f8 07 00 00 00 	movl   $0x7,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   431e3:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   431e7:	78 08                	js     431f1 <program_load+0x28>
   431e9:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   431ec:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   431ef:	7c 14                	jl     43205 <program_load+0x3c>
   431f1:	ba 20 50 04 00       	mov    $0x45020,%edx
   431f6:	be 37 00 00 00       	mov    $0x37,%esi
   431fb:	bf 50 50 04 00       	mov    $0x45050,%edi
   43200:	e8 08 f8 ff ff       	call   42a0d <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   43205:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   43208:	48 98                	cltq   
   4320a:	48 c1 e0 04          	shl    $0x4,%rax
   4320e:	48 05 20 60 04 00    	add    $0x46020,%rax
   43214:	48 8b 00             	mov    (%rax),%rax
   43217:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   4321b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4321f:	8b 00                	mov    (%rax),%eax
   43221:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   43226:	74 14                	je     4323c <program_load+0x73>
   43228:	ba 62 50 04 00       	mov    $0x45062,%edx
   4322d:	be 39 00 00 00       	mov    $0x39,%esi
   43232:	bf 50 50 04 00       	mov    $0x45050,%edi
   43237:	e8 d1 f7 ff ff       	call   42a0d <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   4323c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43240:	48 8b 50 20          	mov    0x20(%rax),%rdx
   43244:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43248:	48 01 d0             	add    %rdx,%rax
   4324b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   4324f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   43256:	e9 94 00 00 00       	jmp    432ef <program_load+0x126>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   4325b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4325e:	48 63 d0             	movslq %eax,%rdx
   43261:	48 89 d0             	mov    %rdx,%rax
   43264:	48 c1 e0 03          	shl    $0x3,%rax
   43268:	48 29 d0             	sub    %rdx,%rax
   4326b:	48 c1 e0 03          	shl    $0x3,%rax
   4326f:	48 89 c2             	mov    %rax,%rdx
   43272:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43276:	48 01 d0             	add    %rdx,%rax
   43279:	8b 00                	mov    (%rax),%eax
   4327b:	83 f8 01             	cmp    $0x1,%eax
   4327e:	75 6b                	jne    432eb <program_load+0x122>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   43280:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43283:	48 63 d0             	movslq %eax,%rdx
   43286:	48 89 d0             	mov    %rdx,%rax
   43289:	48 c1 e0 03          	shl    $0x3,%rax
   4328d:	48 29 d0             	sub    %rdx,%rax
   43290:	48 c1 e0 03          	shl    $0x3,%rax
   43294:	48 89 c2             	mov    %rax,%rdx
   43297:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4329b:	48 01 d0             	add    %rdx,%rax
   4329e:	48 8b 50 08          	mov    0x8(%rax),%rdx
   432a2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432a6:	48 01 d0             	add    %rdx,%rax
   432a9:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   432ad:	8b 45 fc             	mov    -0x4(%rbp),%eax
   432b0:	48 63 d0             	movslq %eax,%rdx
   432b3:	48 89 d0             	mov    %rdx,%rax
   432b6:	48 c1 e0 03          	shl    $0x3,%rax
   432ba:	48 29 d0             	sub    %rdx,%rax
   432bd:	48 c1 e0 03          	shl    $0x3,%rax
   432c1:	48 89 c2             	mov    %rax,%rdx
   432c4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   432c8:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   432cc:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   432d0:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   432d4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   432d8:	48 89 c7             	mov    %rax,%rdi
   432db:	e8 3d 00 00 00       	call   4331d <program_load_segment>
   432e0:	85 c0                	test   %eax,%eax
   432e2:	79 07                	jns    432eb <program_load+0x122>
                return -1;
   432e4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   432e9:	eb 30                	jmp    4331b <program_load+0x152>
    for (int i = 0; i < eh->e_phnum; ++i) {
   432eb:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   432ef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432f3:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   432f7:	0f b7 c0             	movzwl %ax,%eax
   432fa:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   432fd:	0f 8c 58 ff ff ff    	jl     4325b <program_load+0x92>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   43303:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43307:	48 8b 50 18          	mov    0x18(%rax),%rdx
   4330b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4330f:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    return 0;
   43316:	b8 00 00 00 00       	mov    $0x0,%eax
}
   4331b:	c9                   	leave  
   4331c:	c3                   	ret    

000000000004331d <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   4331d:	55                   	push   %rbp
   4331e:	48 89 e5             	mov    %rsp,%rbp
   43321:	48 83 ec 70          	sub    $0x70,%rsp
   43325:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   43329:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   4332d:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   43331:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   43335:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   43339:	48 8b 40 10          	mov    0x10(%rax),%rax
   4333d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   43341:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   43345:	48 8b 50 20          	mov    0x20(%rax),%rdx
   43349:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4334d:	48 01 d0             	add    %rdx,%rax
   43350:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43354:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   43358:	48 8b 50 28          	mov    0x28(%rax),%rdx
   4335c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43360:	48 01 d0             	add    %rdx,%rax
   43363:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   43367:	48 81 65 e8 00 f0 ff 	andq   $0xfffffffffffff000,-0x18(%rbp)
   4336e:	ff 

	// virtual addressing
	for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   4336f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43373:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43377:	e9 8f 00 00 00       	jmp    4340b <program_load_segment+0xee>
		uintptr_t pa;
		if (next_free_page(&pa) < 0
   4337c:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   43380:	48 89 c7             	mov    %rax,%rdi
   43383:	e8 af cf ff ff       	call   40337 <next_free_page>
   43388:	85 c0                	test   %eax,%eax
   4338a:	78 45                	js     433d1 <program_load_segment+0xb4>
			|| assign_physical_page(pa, p->p_pid) < 0
   4338c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43390:	8b 00                	mov    (%rax),%eax
   43392:	0f be d0             	movsbl %al,%edx
   43395:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43399:	89 d6                	mov    %edx,%esi
   4339b:	48 89 c7             	mov    %rax,%rdi
   4339e:	e8 5b d2 ff ff       	call   405fe <assign_physical_page>
   433a3:	85 c0                	test   %eax,%eax
   433a5:	78 2a                	js     433d1 <program_load_segment+0xb4>
			|| virtual_memory_map(p->p_pagetable, addr, pa, PAGESIZE, PTE_P | PTE_W | PTE_U) < 0) {
   433a7:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   433ab:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   433af:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   433b6:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   433ba:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   433c0:	b9 00 10 00 00       	mov    $0x1000,%ecx
   433c5:	48 89 c7             	mov    %rax,%rdi
   433c8:	e8 3f f9 ff ff       	call   42d0c <virtual_memory_map>
   433cd:	85 c0                	test   %eax,%eax
   433cf:	79 32                	jns    43403 <program_load_segment+0xe6>

			console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   433d1:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   433d5:	8b 00                	mov    (%rax),%eax
   433d7:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   433db:	49 89 d0             	mov    %rdx,%r8
   433de:	89 c1                	mov    %eax,%ecx
   433e0:	ba 80 50 04 00       	mov    $0x45080,%edx
   433e5:	be 00 c0 00 00       	mov    $0xc000,%esi
   433ea:	bf e0 06 00 00       	mov    $0x6e0,%edi
   433ef:	b8 00 00 00 00       	mov    $0x0,%eax
   433f4:	e8 a6 0f 00 00       	call   4439f <console_printf>
			return -1;
   433f9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   433fe:	e9 e5 00 00 00       	jmp    434e8 <program_load_segment+0x1cb>
	for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   43403:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4340a:	00 
   4340b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4340f:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   43413:	0f 82 63 ff ff ff    	jb     4337c <program_load_segment+0x5f>
    *     }
    * }
	*/

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   43419:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4341d:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   43424:	48 89 c7             	mov    %rax,%rdi
   43427:	e8 af f7 ff ff       	call   42bdb <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   4342c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43430:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   43434:	48 89 c2             	mov    %rax,%rdx
   43437:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4343b:	48 8b 4d 98          	mov    -0x68(%rbp),%rcx
   4343f:	48 89 ce             	mov    %rcx,%rsi
   43442:	48 89 c7             	mov    %rax,%rdi
   43445:	e8 a0 00 00 00       	call   434ea <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   4344a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4344e:	48 2b 45 e0          	sub    -0x20(%rbp),%rax
   43452:	48 89 c2             	mov    %rax,%rdx
   43455:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43459:	be 00 00 00 00       	mov    $0x0,%esi
   4345e:	48 89 c7             	mov    %rax,%rdi
   43461:	e8 82 01 00 00       	call   435e8 <memset>

	// change to readonly permissions
	if ((ph->p_flags & ELF_PFLAG_WRITE) == 0) {
   43466:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   4346a:	8b 40 04             	mov    0x4(%rax),%eax
   4346d:	83 e0 02             	and    $0x2,%eax
   43470:	85 c0                	test   %eax,%eax
   43472:	75 60                	jne    434d4 <program_load_segment+0x1b7>
		for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   43474:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43478:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   4347c:	eb 4c                	jmp    434ca <program_load_segment+0x1ad>
			vamapping map = virtual_memory_lookup(p->p_pagetable, addr);
   4347e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43482:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   43489:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   4348d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   43491:	48 89 ce             	mov    %rcx,%rsi
   43494:	48 89 c7             	mov    %rax,%rdi
   43497:	e8 36 fc ff ff       	call   430d2 <virtual_memory_lookup>
			virtual_memory_map(p->p_pagetable, addr, map.pa, PAGESIZE, PTE_P | PTE_U );
   4349c:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   434a0:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   434a4:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   434ab:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   434af:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   434b5:	b9 00 10 00 00       	mov    $0x1000,%ecx
   434ba:	48 89 c7             	mov    %rax,%rdi
   434bd:	e8 4a f8 ff ff       	call   42d0c <virtual_memory_map>
		for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   434c2:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   434c9:	00 
   434ca:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   434ce:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   434d2:	72 aa                	jb     4347e <program_load_segment+0x161>
		}
	}

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   434d4:	48 8b 05 25 1b 01 00 	mov    0x11b25(%rip),%rax        # 55000 <kernel_pagetable>
   434db:	48 89 c7             	mov    %rax,%rdi
   434de:	e8 f8 f6 ff ff       	call   42bdb <set_pagetable>
    return 0;
   434e3:	b8 00 00 00 00       	mov    $0x0,%eax
}
   434e8:	c9                   	leave  
   434e9:	c3                   	ret    

00000000000434ea <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   434ea:	55                   	push   %rbp
   434eb:	48 89 e5             	mov    %rsp,%rbp
   434ee:	48 83 ec 28          	sub    $0x28,%rsp
   434f2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   434f6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   434fa:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   434fe:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43502:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43506:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4350a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   4350e:	eb 1c                	jmp    4352c <memcpy+0x42>
        *d = *s;
   43510:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43514:	0f b6 10             	movzbl (%rax),%edx
   43517:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4351b:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   4351d:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43522:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43527:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   4352c:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43531:	75 dd                	jne    43510 <memcpy+0x26>
    }
    return dst;
   43533:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43537:	c9                   	leave  
   43538:	c3                   	ret    

0000000000043539 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   43539:	55                   	push   %rbp
   4353a:	48 89 e5             	mov    %rsp,%rbp
   4353d:	48 83 ec 28          	sub    $0x28,%rsp
   43541:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43545:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43549:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   4354d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43551:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   43555:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43559:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   4355d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43561:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   43565:	73 6a                	jae    435d1 <memmove+0x98>
   43567:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4356b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4356f:	48 01 d0             	add    %rdx,%rax
   43572:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   43576:	73 59                	jae    435d1 <memmove+0x98>
        s += n, d += n;
   43578:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4357c:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   43580:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43584:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   43588:	eb 17                	jmp    435a1 <memmove+0x68>
            *--d = *--s;
   4358a:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   4358f:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   43594:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43598:	0f b6 10             	movzbl (%rax),%edx
   4359b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4359f:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   435a1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   435a5:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   435a9:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   435ad:	48 85 c0             	test   %rax,%rax
   435b0:	75 d8                	jne    4358a <memmove+0x51>
    if (s < d && s + n > d) {
   435b2:	eb 2e                	jmp    435e2 <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   435b4:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   435b8:	48 8d 42 01          	lea    0x1(%rdx),%rax
   435bc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   435c0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435c4:	48 8d 48 01          	lea    0x1(%rax),%rcx
   435c8:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   435cc:	0f b6 12             	movzbl (%rdx),%edx
   435cf:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   435d1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   435d5:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   435d9:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   435dd:	48 85 c0             	test   %rax,%rax
   435e0:	75 d2                	jne    435b4 <memmove+0x7b>
        }
    }
    return dst;
   435e2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   435e6:	c9                   	leave  
   435e7:	c3                   	ret    

00000000000435e8 <memset>:

void* memset(void* v, int c, size_t n) {
   435e8:	55                   	push   %rbp
   435e9:	48 89 e5             	mov    %rsp,%rbp
   435ec:	48 83 ec 28          	sub    $0x28,%rsp
   435f0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   435f4:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   435f7:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   435fb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   435ff:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43603:	eb 15                	jmp    4361a <memset+0x32>
        *p = c;
   43605:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43608:	89 c2                	mov    %eax,%edx
   4360a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4360e:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43610:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43615:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   4361a:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   4361f:	75 e4                	jne    43605 <memset+0x1d>
    }
    return v;
   43621:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43625:	c9                   	leave  
   43626:	c3                   	ret    

0000000000043627 <strlen>:

size_t strlen(const char* s) {
   43627:	55                   	push   %rbp
   43628:	48 89 e5             	mov    %rsp,%rbp
   4362b:	48 83 ec 18          	sub    $0x18,%rsp
   4362f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   43633:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   4363a:	00 
   4363b:	eb 0a                	jmp    43647 <strlen+0x20>
        ++n;
   4363d:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   43642:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43647:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4364b:	0f b6 00             	movzbl (%rax),%eax
   4364e:	84 c0                	test   %al,%al
   43650:	75 eb                	jne    4363d <strlen+0x16>
    }
    return n;
   43652:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43656:	c9                   	leave  
   43657:	c3                   	ret    

0000000000043658 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   43658:	55                   	push   %rbp
   43659:	48 89 e5             	mov    %rsp,%rbp
   4365c:	48 83 ec 20          	sub    $0x20,%rsp
   43660:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43664:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43668:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   4366f:	00 
   43670:	eb 0a                	jmp    4367c <strnlen+0x24>
        ++n;
   43672:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43677:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   4367c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43680:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   43684:	74 0b                	je     43691 <strnlen+0x39>
   43686:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4368a:	0f b6 00             	movzbl (%rax),%eax
   4368d:	84 c0                	test   %al,%al
   4368f:	75 e1                	jne    43672 <strnlen+0x1a>
    }
    return n;
   43691:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43695:	c9                   	leave  
   43696:	c3                   	ret    

0000000000043697 <strcpy>:

char* strcpy(char* dst, const char* src) {
   43697:	55                   	push   %rbp
   43698:	48 89 e5             	mov    %rsp,%rbp
   4369b:	48 83 ec 20          	sub    $0x20,%rsp
   4369f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   436a3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   436a7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   436ab:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   436af:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   436b3:	48 8d 42 01          	lea    0x1(%rdx),%rax
   436b7:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   436bb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   436bf:	48 8d 48 01          	lea    0x1(%rax),%rcx
   436c3:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   436c7:	0f b6 12             	movzbl (%rdx),%edx
   436ca:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   436cc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   436d0:	48 83 e8 01          	sub    $0x1,%rax
   436d4:	0f b6 00             	movzbl (%rax),%eax
   436d7:	84 c0                	test   %al,%al
   436d9:	75 d4                	jne    436af <strcpy+0x18>
    return dst;
   436db:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   436df:	c9                   	leave  
   436e0:	c3                   	ret    

00000000000436e1 <strcmp>:

int strcmp(const char* a, const char* b) {
   436e1:	55                   	push   %rbp
   436e2:	48 89 e5             	mov    %rsp,%rbp
   436e5:	48 83 ec 10          	sub    $0x10,%rsp
   436e9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   436ed:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   436f1:	eb 0a                	jmp    436fd <strcmp+0x1c>
        ++a, ++b;
   436f3:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   436f8:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   436fd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43701:	0f b6 00             	movzbl (%rax),%eax
   43704:	84 c0                	test   %al,%al
   43706:	74 1d                	je     43725 <strcmp+0x44>
   43708:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4370c:	0f b6 00             	movzbl (%rax),%eax
   4370f:	84 c0                	test   %al,%al
   43711:	74 12                	je     43725 <strcmp+0x44>
   43713:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43717:	0f b6 10             	movzbl (%rax),%edx
   4371a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4371e:	0f b6 00             	movzbl (%rax),%eax
   43721:	38 c2                	cmp    %al,%dl
   43723:	74 ce                	je     436f3 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   43725:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43729:	0f b6 00             	movzbl (%rax),%eax
   4372c:	89 c2                	mov    %eax,%edx
   4372e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43732:	0f b6 00             	movzbl (%rax),%eax
   43735:	38 d0                	cmp    %dl,%al
   43737:	0f 92 c0             	setb   %al
   4373a:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   4373d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43741:	0f b6 00             	movzbl (%rax),%eax
   43744:	89 c1                	mov    %eax,%ecx
   43746:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4374a:	0f b6 00             	movzbl (%rax),%eax
   4374d:	38 c1                	cmp    %al,%cl
   4374f:	0f 92 c0             	setb   %al
   43752:	0f b6 c0             	movzbl %al,%eax
   43755:	29 c2                	sub    %eax,%edx
   43757:	89 d0                	mov    %edx,%eax
}
   43759:	c9                   	leave  
   4375a:	c3                   	ret    

000000000004375b <strchr>:

char* strchr(const char* s, int c) {
   4375b:	55                   	push   %rbp
   4375c:	48 89 e5             	mov    %rsp,%rbp
   4375f:	48 83 ec 10          	sub    $0x10,%rsp
   43763:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43767:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   4376a:	eb 05                	jmp    43771 <strchr+0x16>
        ++s;
   4376c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   43771:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43775:	0f b6 00             	movzbl (%rax),%eax
   43778:	84 c0                	test   %al,%al
   4377a:	74 0e                	je     4378a <strchr+0x2f>
   4377c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43780:	0f b6 00             	movzbl (%rax),%eax
   43783:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43786:	38 d0                	cmp    %dl,%al
   43788:	75 e2                	jne    4376c <strchr+0x11>
    }
    if (*s == (char) c) {
   4378a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4378e:	0f b6 00             	movzbl (%rax),%eax
   43791:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43794:	38 d0                	cmp    %dl,%al
   43796:	75 06                	jne    4379e <strchr+0x43>
        return (char*) s;
   43798:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4379c:	eb 05                	jmp    437a3 <strchr+0x48>
    } else {
        return NULL;
   4379e:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   437a3:	c9                   	leave  
   437a4:	c3                   	ret    

00000000000437a5 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   437a5:	55                   	push   %rbp
   437a6:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   437a9:	8b 05 51 78 01 00    	mov    0x17851(%rip),%eax        # 5b000 <rand_seed_set>
   437af:	85 c0                	test   %eax,%eax
   437b1:	75 0a                	jne    437bd <rand+0x18>
        srand(819234718U);
   437b3:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   437b8:	e8 24 00 00 00       	call   437e1 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   437bd:	8b 05 41 78 01 00    	mov    0x17841(%rip),%eax        # 5b004 <rand_seed>
   437c3:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   437c9:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   437ce:	89 05 30 78 01 00    	mov    %eax,0x17830(%rip)        # 5b004 <rand_seed>
    return rand_seed & RAND_MAX;
   437d4:	8b 05 2a 78 01 00    	mov    0x1782a(%rip),%eax        # 5b004 <rand_seed>
   437da:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   437df:	5d                   	pop    %rbp
   437e0:	c3                   	ret    

00000000000437e1 <srand>:

void srand(unsigned seed) {
   437e1:	55                   	push   %rbp
   437e2:	48 89 e5             	mov    %rsp,%rbp
   437e5:	48 83 ec 08          	sub    $0x8,%rsp
   437e9:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   437ec:	8b 45 fc             	mov    -0x4(%rbp),%eax
   437ef:	89 05 0f 78 01 00    	mov    %eax,0x1780f(%rip)        # 5b004 <rand_seed>
    rand_seed_set = 1;
   437f5:	c7 05 01 78 01 00 01 	movl   $0x1,0x17801(%rip)        # 5b000 <rand_seed_set>
   437fc:	00 00 00 
}
   437ff:	90                   	nop
   43800:	c9                   	leave  
   43801:	c3                   	ret    

0000000000043802 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   43802:	55                   	push   %rbp
   43803:	48 89 e5             	mov    %rsp,%rbp
   43806:	48 83 ec 28          	sub    $0x28,%rsp
   4380a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4380e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43812:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   43815:	48 c7 45 f8 a0 52 04 	movq   $0x452a0,-0x8(%rbp)
   4381c:	00 
    if (base < 0) {
   4381d:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   43821:	79 0b                	jns    4382e <fill_numbuf+0x2c>
        digits = lower_digits;
   43823:	48 c7 45 f8 c0 52 04 	movq   $0x452c0,-0x8(%rbp)
   4382a:	00 
        base = -base;
   4382b:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   4382e:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43833:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43837:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   4383a:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4383d:	48 63 c8             	movslq %eax,%rcx
   43840:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43844:	ba 00 00 00 00       	mov    $0x0,%edx
   43849:	48 f7 f1             	div    %rcx
   4384c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43850:	48 01 d0             	add    %rdx,%rax
   43853:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43858:	0f b6 10             	movzbl (%rax),%edx
   4385b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4385f:	88 10                	mov    %dl,(%rax)
        val /= base;
   43861:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43864:	48 63 f0             	movslq %eax,%rsi
   43867:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4386b:	ba 00 00 00 00       	mov    $0x0,%edx
   43870:	48 f7 f6             	div    %rsi
   43873:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   43877:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   4387c:	75 bc                	jne    4383a <fill_numbuf+0x38>
    return numbuf_end;
   4387e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43882:	c9                   	leave  
   43883:	c3                   	ret    

0000000000043884 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   43884:	55                   	push   %rbp
   43885:	48 89 e5             	mov    %rsp,%rbp
   43888:	53                   	push   %rbx
   43889:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   43890:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   43897:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   4389d:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   438a4:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   438ab:	e9 8a 09 00 00       	jmp    4423a <printer_vprintf+0x9b6>
        if (*format != '%') {
   438b0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   438b7:	0f b6 00             	movzbl (%rax),%eax
   438ba:	3c 25                	cmp    $0x25,%al
   438bc:	74 31                	je     438ef <printer_vprintf+0x6b>
            p->putc(p, *format, color);
   438be:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   438c5:	4c 8b 00             	mov    (%rax),%r8
   438c8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   438cf:	0f b6 00             	movzbl (%rax),%eax
   438d2:	0f b6 c8             	movzbl %al,%ecx
   438d5:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   438db:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   438e2:	89 ce                	mov    %ecx,%esi
   438e4:	48 89 c7             	mov    %rax,%rdi
   438e7:	41 ff d0             	call   *%r8
            continue;
   438ea:	e9 43 09 00 00       	jmp    44232 <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
   438ef:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   438f6:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   438fd:	01 
   438fe:	eb 44                	jmp    43944 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
   43900:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43907:	0f b6 00             	movzbl (%rax),%eax
   4390a:	0f be c0             	movsbl %al,%eax
   4390d:	89 c6                	mov    %eax,%esi
   4390f:	bf c0 50 04 00       	mov    $0x450c0,%edi
   43914:	e8 42 fe ff ff       	call   4375b <strchr>
   43919:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   4391d:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   43922:	74 30                	je     43954 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
   43924:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   43928:	48 2d c0 50 04 00    	sub    $0x450c0,%rax
   4392e:	ba 01 00 00 00       	mov    $0x1,%edx
   43933:	89 c1                	mov    %eax,%ecx
   43935:	d3 e2                	shl    %cl,%edx
   43937:	89 d0                	mov    %edx,%eax
   43939:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   4393c:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43943:	01 
   43944:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4394b:	0f b6 00             	movzbl (%rax),%eax
   4394e:	84 c0                	test   %al,%al
   43950:	75 ae                	jne    43900 <printer_vprintf+0x7c>
   43952:	eb 01                	jmp    43955 <printer_vprintf+0xd1>
            } else {
                break;
   43954:	90                   	nop
            }
        }

        // process width
        int width = -1;
   43955:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   4395c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43963:	0f b6 00             	movzbl (%rax),%eax
   43966:	3c 30                	cmp    $0x30,%al
   43968:	7e 67                	jle    439d1 <printer_vprintf+0x14d>
   4396a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43971:	0f b6 00             	movzbl (%rax),%eax
   43974:	3c 39                	cmp    $0x39,%al
   43976:	7f 59                	jg     439d1 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43978:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   4397f:	eb 2e                	jmp    439af <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
   43981:	8b 55 e8             	mov    -0x18(%rbp),%edx
   43984:	89 d0                	mov    %edx,%eax
   43986:	c1 e0 02             	shl    $0x2,%eax
   43989:	01 d0                	add    %edx,%eax
   4398b:	01 c0                	add    %eax,%eax
   4398d:	89 c1                	mov    %eax,%ecx
   4398f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43996:	48 8d 50 01          	lea    0x1(%rax),%rdx
   4399a:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   439a1:	0f b6 00             	movzbl (%rax),%eax
   439a4:	0f be c0             	movsbl %al,%eax
   439a7:	01 c8                	add    %ecx,%eax
   439a9:	83 e8 30             	sub    $0x30,%eax
   439ac:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   439af:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   439b6:	0f b6 00             	movzbl (%rax),%eax
   439b9:	3c 2f                	cmp    $0x2f,%al
   439bb:	0f 8e 85 00 00 00    	jle    43a46 <printer_vprintf+0x1c2>
   439c1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   439c8:	0f b6 00             	movzbl (%rax),%eax
   439cb:	3c 39                	cmp    $0x39,%al
   439cd:	7e b2                	jle    43981 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
   439cf:	eb 75                	jmp    43a46 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
   439d1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   439d8:	0f b6 00             	movzbl (%rax),%eax
   439db:	3c 2a                	cmp    $0x2a,%al
   439dd:	75 68                	jne    43a47 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
   439df:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   439e6:	8b 00                	mov    (%rax),%eax
   439e8:	83 f8 2f             	cmp    $0x2f,%eax
   439eb:	77 30                	ja     43a1d <printer_vprintf+0x199>
   439ed:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   439f4:	48 8b 50 10          	mov    0x10(%rax),%rdx
   439f8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   439ff:	8b 00                	mov    (%rax),%eax
   43a01:	89 c0                	mov    %eax,%eax
   43a03:	48 01 d0             	add    %rdx,%rax
   43a06:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43a0d:	8b 12                	mov    (%rdx),%edx
   43a0f:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43a12:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43a19:	89 0a                	mov    %ecx,(%rdx)
   43a1b:	eb 1a                	jmp    43a37 <printer_vprintf+0x1b3>
   43a1d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43a24:	48 8b 40 08          	mov    0x8(%rax),%rax
   43a28:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43a2c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43a33:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43a37:	8b 00                	mov    (%rax),%eax
   43a39:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   43a3c:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43a43:	01 
   43a44:	eb 01                	jmp    43a47 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
   43a46:	90                   	nop
        }

        // process precision
        int precision = -1;
   43a47:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   43a4e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43a55:	0f b6 00             	movzbl (%rax),%eax
   43a58:	3c 2e                	cmp    $0x2e,%al
   43a5a:	0f 85 00 01 00 00    	jne    43b60 <printer_vprintf+0x2dc>
            ++format;
   43a60:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43a67:	01 
            if (*format >= '0' && *format <= '9') {
   43a68:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43a6f:	0f b6 00             	movzbl (%rax),%eax
   43a72:	3c 2f                	cmp    $0x2f,%al
   43a74:	7e 67                	jle    43add <printer_vprintf+0x259>
   43a76:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43a7d:	0f b6 00             	movzbl (%rax),%eax
   43a80:	3c 39                	cmp    $0x39,%al
   43a82:	7f 59                	jg     43add <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43a84:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   43a8b:	eb 2e                	jmp    43abb <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
   43a8d:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   43a90:	89 d0                	mov    %edx,%eax
   43a92:	c1 e0 02             	shl    $0x2,%eax
   43a95:	01 d0                	add    %edx,%eax
   43a97:	01 c0                	add    %eax,%eax
   43a99:	89 c1                	mov    %eax,%ecx
   43a9b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43aa2:	48 8d 50 01          	lea    0x1(%rax),%rdx
   43aa6:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43aad:	0f b6 00             	movzbl (%rax),%eax
   43ab0:	0f be c0             	movsbl %al,%eax
   43ab3:	01 c8                	add    %ecx,%eax
   43ab5:	83 e8 30             	sub    $0x30,%eax
   43ab8:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43abb:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43ac2:	0f b6 00             	movzbl (%rax),%eax
   43ac5:	3c 2f                	cmp    $0x2f,%al
   43ac7:	0f 8e 85 00 00 00    	jle    43b52 <printer_vprintf+0x2ce>
   43acd:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43ad4:	0f b6 00             	movzbl (%rax),%eax
   43ad7:	3c 39                	cmp    $0x39,%al
   43ad9:	7e b2                	jle    43a8d <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
   43adb:	eb 75                	jmp    43b52 <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
   43add:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43ae4:	0f b6 00             	movzbl (%rax),%eax
   43ae7:	3c 2a                	cmp    $0x2a,%al
   43ae9:	75 68                	jne    43b53 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
   43aeb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43af2:	8b 00                	mov    (%rax),%eax
   43af4:	83 f8 2f             	cmp    $0x2f,%eax
   43af7:	77 30                	ja     43b29 <printer_vprintf+0x2a5>
   43af9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b00:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43b04:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b0b:	8b 00                	mov    (%rax),%eax
   43b0d:	89 c0                	mov    %eax,%eax
   43b0f:	48 01 d0             	add    %rdx,%rax
   43b12:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43b19:	8b 12                	mov    (%rdx),%edx
   43b1b:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43b1e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43b25:	89 0a                	mov    %ecx,(%rdx)
   43b27:	eb 1a                	jmp    43b43 <printer_vprintf+0x2bf>
   43b29:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b30:	48 8b 40 08          	mov    0x8(%rax),%rax
   43b34:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43b38:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43b3f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43b43:	8b 00                	mov    (%rax),%eax
   43b45:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   43b48:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43b4f:	01 
   43b50:	eb 01                	jmp    43b53 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
   43b52:	90                   	nop
            }
            if (precision < 0) {
   43b53:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   43b57:	79 07                	jns    43b60 <printer_vprintf+0x2dc>
                precision = 0;
   43b59:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   43b60:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   43b67:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   43b6e:	00 
        int length = 0;
   43b6f:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   43b76:	48 c7 45 c8 c6 50 04 	movq   $0x450c6,-0x38(%rbp)
   43b7d:	00 
    again:
        switch (*format) {
   43b7e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43b85:	0f b6 00             	movzbl (%rax),%eax
   43b88:	0f be c0             	movsbl %al,%eax
   43b8b:	83 e8 43             	sub    $0x43,%eax
   43b8e:	83 f8 37             	cmp    $0x37,%eax
   43b91:	0f 87 9f 03 00 00    	ja     43f36 <printer_vprintf+0x6b2>
   43b97:	89 c0                	mov    %eax,%eax
   43b99:	48 8b 04 c5 d8 50 04 	mov    0x450d8(,%rax,8),%rax
   43ba0:	00 
   43ba1:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
   43ba3:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   43baa:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43bb1:	01 
            goto again;
   43bb2:	eb ca                	jmp    43b7e <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   43bb4:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43bb8:	74 5d                	je     43c17 <printer_vprintf+0x393>
   43bba:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43bc1:	8b 00                	mov    (%rax),%eax
   43bc3:	83 f8 2f             	cmp    $0x2f,%eax
   43bc6:	77 30                	ja     43bf8 <printer_vprintf+0x374>
   43bc8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43bcf:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43bd3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43bda:	8b 00                	mov    (%rax),%eax
   43bdc:	89 c0                	mov    %eax,%eax
   43bde:	48 01 d0             	add    %rdx,%rax
   43be1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43be8:	8b 12                	mov    (%rdx),%edx
   43bea:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43bed:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43bf4:	89 0a                	mov    %ecx,(%rdx)
   43bf6:	eb 1a                	jmp    43c12 <printer_vprintf+0x38e>
   43bf8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43bff:	48 8b 40 08          	mov    0x8(%rax),%rax
   43c03:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43c07:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c0e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43c12:	48 8b 00             	mov    (%rax),%rax
   43c15:	eb 5c                	jmp    43c73 <printer_vprintf+0x3ef>
   43c17:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c1e:	8b 00                	mov    (%rax),%eax
   43c20:	83 f8 2f             	cmp    $0x2f,%eax
   43c23:	77 30                	ja     43c55 <printer_vprintf+0x3d1>
   43c25:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c2c:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43c30:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c37:	8b 00                	mov    (%rax),%eax
   43c39:	89 c0                	mov    %eax,%eax
   43c3b:	48 01 d0             	add    %rdx,%rax
   43c3e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c45:	8b 12                	mov    (%rdx),%edx
   43c47:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43c4a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c51:	89 0a                	mov    %ecx,(%rdx)
   43c53:	eb 1a                	jmp    43c6f <printer_vprintf+0x3eb>
   43c55:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c5c:	48 8b 40 08          	mov    0x8(%rax),%rax
   43c60:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43c64:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c6b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43c6f:	8b 00                	mov    (%rax),%eax
   43c71:	48 98                	cltq   
   43c73:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   43c77:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43c7b:	48 c1 f8 38          	sar    $0x38,%rax
   43c7f:	25 80 00 00 00       	and    $0x80,%eax
   43c84:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   43c87:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   43c8b:	74 09                	je     43c96 <printer_vprintf+0x412>
   43c8d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43c91:	48 f7 d8             	neg    %rax
   43c94:	eb 04                	jmp    43c9a <printer_vprintf+0x416>
   43c96:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43c9a:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   43c9e:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   43ca1:	83 c8 60             	or     $0x60,%eax
   43ca4:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   43ca7:	e9 cf 02 00 00       	jmp    43f7b <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   43cac:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43cb0:	74 5d                	je     43d0f <printer_vprintf+0x48b>
   43cb2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43cb9:	8b 00                	mov    (%rax),%eax
   43cbb:	83 f8 2f             	cmp    $0x2f,%eax
   43cbe:	77 30                	ja     43cf0 <printer_vprintf+0x46c>
   43cc0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43cc7:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43ccb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43cd2:	8b 00                	mov    (%rax),%eax
   43cd4:	89 c0                	mov    %eax,%eax
   43cd6:	48 01 d0             	add    %rdx,%rax
   43cd9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43ce0:	8b 12                	mov    (%rdx),%edx
   43ce2:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43ce5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43cec:	89 0a                	mov    %ecx,(%rdx)
   43cee:	eb 1a                	jmp    43d0a <printer_vprintf+0x486>
   43cf0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43cf7:	48 8b 40 08          	mov    0x8(%rax),%rax
   43cfb:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43cff:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d06:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43d0a:	48 8b 00             	mov    (%rax),%rax
   43d0d:	eb 5c                	jmp    43d6b <printer_vprintf+0x4e7>
   43d0f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d16:	8b 00                	mov    (%rax),%eax
   43d18:	83 f8 2f             	cmp    $0x2f,%eax
   43d1b:	77 30                	ja     43d4d <printer_vprintf+0x4c9>
   43d1d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d24:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43d28:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d2f:	8b 00                	mov    (%rax),%eax
   43d31:	89 c0                	mov    %eax,%eax
   43d33:	48 01 d0             	add    %rdx,%rax
   43d36:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d3d:	8b 12                	mov    (%rdx),%edx
   43d3f:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43d42:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d49:	89 0a                	mov    %ecx,(%rdx)
   43d4b:	eb 1a                	jmp    43d67 <printer_vprintf+0x4e3>
   43d4d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d54:	48 8b 40 08          	mov    0x8(%rax),%rax
   43d58:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43d5c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d63:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43d67:	8b 00                	mov    (%rax),%eax
   43d69:	89 c0                	mov    %eax,%eax
   43d6b:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   43d6f:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   43d73:	e9 03 02 00 00       	jmp    43f7b <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
   43d78:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   43d7f:	e9 28 ff ff ff       	jmp    43cac <printer_vprintf+0x428>
        case 'X':
            base = 16;
   43d84:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   43d8b:	e9 1c ff ff ff       	jmp    43cac <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   43d90:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d97:	8b 00                	mov    (%rax),%eax
   43d99:	83 f8 2f             	cmp    $0x2f,%eax
   43d9c:	77 30                	ja     43dce <printer_vprintf+0x54a>
   43d9e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43da5:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43da9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43db0:	8b 00                	mov    (%rax),%eax
   43db2:	89 c0                	mov    %eax,%eax
   43db4:	48 01 d0             	add    %rdx,%rax
   43db7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43dbe:	8b 12                	mov    (%rdx),%edx
   43dc0:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43dc3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43dca:	89 0a                	mov    %ecx,(%rdx)
   43dcc:	eb 1a                	jmp    43de8 <printer_vprintf+0x564>
   43dce:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43dd5:	48 8b 40 08          	mov    0x8(%rax),%rax
   43dd9:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43ddd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43de4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43de8:	48 8b 00             	mov    (%rax),%rax
   43deb:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   43def:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   43df6:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   43dfd:	e9 79 01 00 00       	jmp    43f7b <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
   43e02:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e09:	8b 00                	mov    (%rax),%eax
   43e0b:	83 f8 2f             	cmp    $0x2f,%eax
   43e0e:	77 30                	ja     43e40 <printer_vprintf+0x5bc>
   43e10:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e17:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43e1b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e22:	8b 00                	mov    (%rax),%eax
   43e24:	89 c0                	mov    %eax,%eax
   43e26:	48 01 d0             	add    %rdx,%rax
   43e29:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e30:	8b 12                	mov    (%rdx),%edx
   43e32:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43e35:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e3c:	89 0a                	mov    %ecx,(%rdx)
   43e3e:	eb 1a                	jmp    43e5a <printer_vprintf+0x5d6>
   43e40:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e47:	48 8b 40 08          	mov    0x8(%rax),%rax
   43e4b:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43e4f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e56:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43e5a:	48 8b 00             	mov    (%rax),%rax
   43e5d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   43e61:	e9 15 01 00 00       	jmp    43f7b <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
   43e66:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e6d:	8b 00                	mov    (%rax),%eax
   43e6f:	83 f8 2f             	cmp    $0x2f,%eax
   43e72:	77 30                	ja     43ea4 <printer_vprintf+0x620>
   43e74:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e7b:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43e7f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e86:	8b 00                	mov    (%rax),%eax
   43e88:	89 c0                	mov    %eax,%eax
   43e8a:	48 01 d0             	add    %rdx,%rax
   43e8d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e94:	8b 12                	mov    (%rdx),%edx
   43e96:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43e99:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43ea0:	89 0a                	mov    %ecx,(%rdx)
   43ea2:	eb 1a                	jmp    43ebe <printer_vprintf+0x63a>
   43ea4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43eab:	48 8b 40 08          	mov    0x8(%rax),%rax
   43eaf:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43eb3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43eba:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43ebe:	8b 00                	mov    (%rax),%eax
   43ec0:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   43ec6:	e9 67 03 00 00       	jmp    44232 <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
   43ecb:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43ecf:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   43ed3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43eda:	8b 00                	mov    (%rax),%eax
   43edc:	83 f8 2f             	cmp    $0x2f,%eax
   43edf:	77 30                	ja     43f11 <printer_vprintf+0x68d>
   43ee1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ee8:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43eec:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ef3:	8b 00                	mov    (%rax),%eax
   43ef5:	89 c0                	mov    %eax,%eax
   43ef7:	48 01 d0             	add    %rdx,%rax
   43efa:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f01:	8b 12                	mov    (%rdx),%edx
   43f03:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43f06:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f0d:	89 0a                	mov    %ecx,(%rdx)
   43f0f:	eb 1a                	jmp    43f2b <printer_vprintf+0x6a7>
   43f11:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f18:	48 8b 40 08          	mov    0x8(%rax),%rax
   43f1c:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43f20:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f27:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43f2b:	8b 00                	mov    (%rax),%eax
   43f2d:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   43f30:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   43f34:	eb 45                	jmp    43f7b <printer_vprintf+0x6f7>
        default:
            data = numbuf;
   43f36:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43f3a:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   43f3e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f45:	0f b6 00             	movzbl (%rax),%eax
   43f48:	84 c0                	test   %al,%al
   43f4a:	74 0c                	je     43f58 <printer_vprintf+0x6d4>
   43f4c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f53:	0f b6 00             	movzbl (%rax),%eax
   43f56:	eb 05                	jmp    43f5d <printer_vprintf+0x6d9>
   43f58:	b8 25 00 00 00       	mov    $0x25,%eax
   43f5d:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   43f60:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   43f64:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f6b:	0f b6 00             	movzbl (%rax),%eax
   43f6e:	84 c0                	test   %al,%al
   43f70:	75 08                	jne    43f7a <printer_vprintf+0x6f6>
                format--;
   43f72:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   43f79:	01 
            }
            break;
   43f7a:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   43f7b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43f7e:	83 e0 20             	and    $0x20,%eax
   43f81:	85 c0                	test   %eax,%eax
   43f83:	74 1e                	je     43fa3 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   43f85:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43f89:	48 83 c0 18          	add    $0x18,%rax
   43f8d:	8b 55 e0             	mov    -0x20(%rbp),%edx
   43f90:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   43f94:	48 89 ce             	mov    %rcx,%rsi
   43f97:	48 89 c7             	mov    %rax,%rdi
   43f9a:	e8 63 f8 ff ff       	call   43802 <fill_numbuf>
   43f9f:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   43fa3:	48 c7 45 c0 c6 50 04 	movq   $0x450c6,-0x40(%rbp)
   43faa:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   43fab:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43fae:	83 e0 20             	and    $0x20,%eax
   43fb1:	85 c0                	test   %eax,%eax
   43fb3:	74 48                	je     43ffd <printer_vprintf+0x779>
   43fb5:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43fb8:	83 e0 40             	and    $0x40,%eax
   43fbb:	85 c0                	test   %eax,%eax
   43fbd:	74 3e                	je     43ffd <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
   43fbf:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43fc2:	25 80 00 00 00       	and    $0x80,%eax
   43fc7:	85 c0                	test   %eax,%eax
   43fc9:	74 0a                	je     43fd5 <printer_vprintf+0x751>
                prefix = "-";
   43fcb:	48 c7 45 c0 c7 50 04 	movq   $0x450c7,-0x40(%rbp)
   43fd2:	00 
            if (flags & FLAG_NEGATIVE) {
   43fd3:	eb 73                	jmp    44048 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   43fd5:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43fd8:	83 e0 10             	and    $0x10,%eax
   43fdb:	85 c0                	test   %eax,%eax
   43fdd:	74 0a                	je     43fe9 <printer_vprintf+0x765>
                prefix = "+";
   43fdf:	48 c7 45 c0 c9 50 04 	movq   $0x450c9,-0x40(%rbp)
   43fe6:	00 
            if (flags & FLAG_NEGATIVE) {
   43fe7:	eb 5f                	jmp    44048 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   43fe9:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43fec:	83 e0 08             	and    $0x8,%eax
   43fef:	85 c0                	test   %eax,%eax
   43ff1:	74 55                	je     44048 <printer_vprintf+0x7c4>
                prefix = " ";
   43ff3:	48 c7 45 c0 cb 50 04 	movq   $0x450cb,-0x40(%rbp)
   43ffa:	00 
            if (flags & FLAG_NEGATIVE) {
   43ffb:	eb 4b                	jmp    44048 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   43ffd:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44000:	83 e0 20             	and    $0x20,%eax
   44003:	85 c0                	test   %eax,%eax
   44005:	74 42                	je     44049 <printer_vprintf+0x7c5>
   44007:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4400a:	83 e0 01             	and    $0x1,%eax
   4400d:	85 c0                	test   %eax,%eax
   4400f:	74 38                	je     44049 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
   44011:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   44015:	74 06                	je     4401d <printer_vprintf+0x799>
   44017:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   4401b:	75 2c                	jne    44049 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
   4401d:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   44022:	75 0c                	jne    44030 <printer_vprintf+0x7ac>
   44024:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44027:	25 00 01 00 00       	and    $0x100,%eax
   4402c:	85 c0                	test   %eax,%eax
   4402e:	74 19                	je     44049 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
   44030:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   44034:	75 07                	jne    4403d <printer_vprintf+0x7b9>
   44036:	b8 cd 50 04 00       	mov    $0x450cd,%eax
   4403b:	eb 05                	jmp    44042 <printer_vprintf+0x7be>
   4403d:	b8 d0 50 04 00       	mov    $0x450d0,%eax
   44042:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   44046:	eb 01                	jmp    44049 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
   44048:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   44049:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   4404d:	78 24                	js     44073 <printer_vprintf+0x7ef>
   4404f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44052:	83 e0 20             	and    $0x20,%eax
   44055:	85 c0                	test   %eax,%eax
   44057:	75 1a                	jne    44073 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
   44059:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4405c:	48 63 d0             	movslq %eax,%rdx
   4405f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44063:	48 89 d6             	mov    %rdx,%rsi
   44066:	48 89 c7             	mov    %rax,%rdi
   44069:	e8 ea f5 ff ff       	call   43658 <strnlen>
   4406e:	89 45 bc             	mov    %eax,-0x44(%rbp)
   44071:	eb 0f                	jmp    44082 <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
   44073:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44077:	48 89 c7             	mov    %rax,%rdi
   4407a:	e8 a8 f5 ff ff       	call   43627 <strlen>
   4407f:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   44082:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44085:	83 e0 20             	and    $0x20,%eax
   44088:	85 c0                	test   %eax,%eax
   4408a:	74 20                	je     440ac <printer_vprintf+0x828>
   4408c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   44090:	78 1a                	js     440ac <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
   44092:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44095:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   44098:	7e 08                	jle    440a2 <printer_vprintf+0x81e>
   4409a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4409d:	2b 45 bc             	sub    -0x44(%rbp),%eax
   440a0:	eb 05                	jmp    440a7 <printer_vprintf+0x823>
   440a2:	b8 00 00 00 00       	mov    $0x0,%eax
   440a7:	89 45 b8             	mov    %eax,-0x48(%rbp)
   440aa:	eb 5c                	jmp    44108 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   440ac:	8b 45 ec             	mov    -0x14(%rbp),%eax
   440af:	83 e0 20             	and    $0x20,%eax
   440b2:	85 c0                	test   %eax,%eax
   440b4:	74 4b                	je     44101 <printer_vprintf+0x87d>
   440b6:	8b 45 ec             	mov    -0x14(%rbp),%eax
   440b9:	83 e0 02             	and    $0x2,%eax
   440bc:	85 c0                	test   %eax,%eax
   440be:	74 41                	je     44101 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
   440c0:	8b 45 ec             	mov    -0x14(%rbp),%eax
   440c3:	83 e0 04             	and    $0x4,%eax
   440c6:	85 c0                	test   %eax,%eax
   440c8:	75 37                	jne    44101 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
   440ca:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   440ce:	48 89 c7             	mov    %rax,%rdi
   440d1:	e8 51 f5 ff ff       	call   43627 <strlen>
   440d6:	89 c2                	mov    %eax,%edx
   440d8:	8b 45 bc             	mov    -0x44(%rbp),%eax
   440db:	01 d0                	add    %edx,%eax
   440dd:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   440e0:	7e 1f                	jle    44101 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
   440e2:	8b 45 e8             	mov    -0x18(%rbp),%eax
   440e5:	2b 45 bc             	sub    -0x44(%rbp),%eax
   440e8:	89 c3                	mov    %eax,%ebx
   440ea:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   440ee:	48 89 c7             	mov    %rax,%rdi
   440f1:	e8 31 f5 ff ff       	call   43627 <strlen>
   440f6:	89 c2                	mov    %eax,%edx
   440f8:	89 d8                	mov    %ebx,%eax
   440fa:	29 d0                	sub    %edx,%eax
   440fc:	89 45 b8             	mov    %eax,-0x48(%rbp)
   440ff:	eb 07                	jmp    44108 <printer_vprintf+0x884>
        } else {
            zeros = 0;
   44101:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   44108:	8b 55 bc             	mov    -0x44(%rbp),%edx
   4410b:	8b 45 b8             	mov    -0x48(%rbp),%eax
   4410e:	01 d0                	add    %edx,%eax
   44110:	48 63 d8             	movslq %eax,%rbx
   44113:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44117:	48 89 c7             	mov    %rax,%rdi
   4411a:	e8 08 f5 ff ff       	call   43627 <strlen>
   4411f:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   44123:	8b 45 e8             	mov    -0x18(%rbp),%eax
   44126:	29 d0                	sub    %edx,%eax
   44128:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   4412b:	eb 25                	jmp    44152 <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
   4412d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44134:	48 8b 08             	mov    (%rax),%rcx
   44137:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   4413d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44144:	be 20 00 00 00       	mov    $0x20,%esi
   44149:	48 89 c7             	mov    %rax,%rdi
   4414c:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   4414e:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   44152:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44155:	83 e0 04             	and    $0x4,%eax
   44158:	85 c0                	test   %eax,%eax
   4415a:	75 36                	jne    44192 <printer_vprintf+0x90e>
   4415c:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   44160:	7f cb                	jg     4412d <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
   44162:	eb 2e                	jmp    44192 <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
   44164:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4416b:	4c 8b 00             	mov    (%rax),%r8
   4416e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44172:	0f b6 00             	movzbl (%rax),%eax
   44175:	0f b6 c8             	movzbl %al,%ecx
   44178:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   4417e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44185:	89 ce                	mov    %ecx,%esi
   44187:	48 89 c7             	mov    %rax,%rdi
   4418a:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   4418d:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   44192:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44196:	0f b6 00             	movzbl (%rax),%eax
   44199:	84 c0                	test   %al,%al
   4419b:	75 c7                	jne    44164 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
   4419d:	eb 25                	jmp    441c4 <printer_vprintf+0x940>
            p->putc(p, '0', color);
   4419f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   441a6:	48 8b 08             	mov    (%rax),%rcx
   441a9:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   441af:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   441b6:	be 30 00 00 00       	mov    $0x30,%esi
   441bb:	48 89 c7             	mov    %rax,%rdi
   441be:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   441c0:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   441c4:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   441c8:	7f d5                	jg     4419f <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
   441ca:	eb 32                	jmp    441fe <printer_vprintf+0x97a>
            p->putc(p, *data, color);
   441cc:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   441d3:	4c 8b 00             	mov    (%rax),%r8
   441d6:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   441da:	0f b6 00             	movzbl (%rax),%eax
   441dd:	0f b6 c8             	movzbl %al,%ecx
   441e0:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   441e6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   441ed:	89 ce                	mov    %ecx,%esi
   441ef:	48 89 c7             	mov    %rax,%rdi
   441f2:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   441f5:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   441fa:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   441fe:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   44202:	7f c8                	jg     441cc <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
   44204:	eb 25                	jmp    4422b <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
   44206:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4420d:	48 8b 08             	mov    (%rax),%rcx
   44210:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44216:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4421d:	be 20 00 00 00       	mov    $0x20,%esi
   44222:	48 89 c7             	mov    %rax,%rdi
   44225:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   44227:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   4422b:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   4422f:	7f d5                	jg     44206 <printer_vprintf+0x982>
        }
    done: ;
   44231:	90                   	nop
    for (; *format; ++format) {
   44232:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44239:	01 
   4423a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44241:	0f b6 00             	movzbl (%rax),%eax
   44244:	84 c0                	test   %al,%al
   44246:	0f 85 64 f6 ff ff    	jne    438b0 <printer_vprintf+0x2c>
    }
}
   4424c:	90                   	nop
   4424d:	90                   	nop
   4424e:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   44252:	c9                   	leave  
   44253:	c3                   	ret    

0000000000044254 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   44254:	55                   	push   %rbp
   44255:	48 89 e5             	mov    %rsp,%rbp
   44258:	48 83 ec 20          	sub    $0x20,%rsp
   4425c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44260:	89 f0                	mov    %esi,%eax
   44262:	89 55 e0             	mov    %edx,-0x20(%rbp)
   44265:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   44268:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4426c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   44270:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44274:	48 8b 40 08          	mov    0x8(%rax),%rax
   44278:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
   4427d:	48 39 d0             	cmp    %rdx,%rax
   44280:	72 0c                	jb     4428e <console_putc+0x3a>
        cp->cursor = console;
   44282:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44286:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
   4428d:	00 
    }
    if (c == '\n') {
   4428e:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   44292:	75 78                	jne    4430c <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
   44294:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44298:	48 8b 40 08          	mov    0x8(%rax),%rax
   4429c:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   442a2:	48 d1 f8             	sar    %rax
   442a5:	48 89 c1             	mov    %rax,%rcx
   442a8:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   442af:	66 66 66 
   442b2:	48 89 c8             	mov    %rcx,%rax
   442b5:	48 f7 ea             	imul   %rdx
   442b8:	48 c1 fa 05          	sar    $0x5,%rdx
   442bc:	48 89 c8             	mov    %rcx,%rax
   442bf:	48 c1 f8 3f          	sar    $0x3f,%rax
   442c3:	48 29 c2             	sub    %rax,%rdx
   442c6:	48 89 d0             	mov    %rdx,%rax
   442c9:	48 c1 e0 02          	shl    $0x2,%rax
   442cd:	48 01 d0             	add    %rdx,%rax
   442d0:	48 c1 e0 04          	shl    $0x4,%rax
   442d4:	48 29 c1             	sub    %rax,%rcx
   442d7:	48 89 ca             	mov    %rcx,%rdx
   442da:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   442dd:	eb 25                	jmp    44304 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
   442df:	8b 45 e0             	mov    -0x20(%rbp),%eax
   442e2:	83 c8 20             	or     $0x20,%eax
   442e5:	89 c6                	mov    %eax,%esi
   442e7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   442eb:	48 8b 40 08          	mov    0x8(%rax),%rax
   442ef:	48 8d 48 02          	lea    0x2(%rax),%rcx
   442f3:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   442f7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   442fb:	89 f2                	mov    %esi,%edx
   442fd:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   44300:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44304:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   44308:	75 d5                	jne    442df <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   4430a:	eb 24                	jmp    44330 <console_putc+0xdc>
        *cp->cursor++ = c | color;
   4430c:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
   44310:	8b 55 e0             	mov    -0x20(%rbp),%edx
   44313:	09 d0                	or     %edx,%eax
   44315:	89 c6                	mov    %eax,%esi
   44317:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4431b:	48 8b 40 08          	mov    0x8(%rax),%rax
   4431f:	48 8d 48 02          	lea    0x2(%rax),%rcx
   44323:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   44327:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4432b:	89 f2                	mov    %esi,%edx
   4432d:	66 89 10             	mov    %dx,(%rax)
}
   44330:	90                   	nop
   44331:	c9                   	leave  
   44332:	c3                   	ret    

0000000000044333 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   44333:	55                   	push   %rbp
   44334:	48 89 e5             	mov    %rsp,%rbp
   44337:	48 83 ec 30          	sub    $0x30,%rsp
   4433b:	89 7d ec             	mov    %edi,-0x14(%rbp)
   4433e:	89 75 e8             	mov    %esi,-0x18(%rbp)
   44341:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   44345:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   44349:	48 c7 45 f0 54 42 04 	movq   $0x44254,-0x10(%rbp)
   44350:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   44351:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   44355:	78 09                	js     44360 <console_vprintf+0x2d>
   44357:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   4435e:	7e 07                	jle    44367 <console_vprintf+0x34>
        cpos = 0;
   44360:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   44367:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4436a:	48 98                	cltq   
   4436c:	48 01 c0             	add    %rax,%rax
   4436f:	48 05 00 80 0b 00    	add    $0xb8000,%rax
   44375:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   44379:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   4437d:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   44381:	8b 75 e8             	mov    -0x18(%rbp),%esi
   44384:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   44388:	48 89 c7             	mov    %rax,%rdi
   4438b:	e8 f4 f4 ff ff       	call   43884 <printer_vprintf>
    return cp.cursor - console;
   44390:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44394:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   4439a:	48 d1 f8             	sar    %rax
}
   4439d:	c9                   	leave  
   4439e:	c3                   	ret    

000000000004439f <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   4439f:	55                   	push   %rbp
   443a0:	48 89 e5             	mov    %rsp,%rbp
   443a3:	48 83 ec 60          	sub    $0x60,%rsp
   443a7:	89 7d ac             	mov    %edi,-0x54(%rbp)
   443aa:	89 75 a8             	mov    %esi,-0x58(%rbp)
   443ad:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   443b1:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   443b5:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   443b9:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   443bd:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   443c4:	48 8d 45 10          	lea    0x10(%rbp),%rax
   443c8:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   443cc:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   443d0:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   443d4:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   443d8:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   443dc:	8b 75 a8             	mov    -0x58(%rbp),%esi
   443df:	8b 45 ac             	mov    -0x54(%rbp),%eax
   443e2:	89 c7                	mov    %eax,%edi
   443e4:	e8 4a ff ff ff       	call   44333 <console_vprintf>
   443e9:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   443ec:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   443ef:	c9                   	leave  
   443f0:	c3                   	ret    

00000000000443f1 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   443f1:	55                   	push   %rbp
   443f2:	48 89 e5             	mov    %rsp,%rbp
   443f5:	48 83 ec 20          	sub    $0x20,%rsp
   443f9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   443fd:	89 f0                	mov    %esi,%eax
   443ff:	89 55 e0             	mov    %edx,-0x20(%rbp)
   44402:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   44405:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44409:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   4440d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44411:	48 8b 50 08          	mov    0x8(%rax),%rdx
   44415:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44419:	48 8b 40 10          	mov    0x10(%rax),%rax
   4441d:	48 39 c2             	cmp    %rax,%rdx
   44420:	73 1a                	jae    4443c <string_putc+0x4b>
        *sp->s++ = c;
   44422:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44426:	48 8b 40 08          	mov    0x8(%rax),%rax
   4442a:	48 8d 48 01          	lea    0x1(%rax),%rcx
   4442e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   44432:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44436:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   4443a:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   4443c:	90                   	nop
   4443d:	c9                   	leave  
   4443e:	c3                   	ret    

000000000004443f <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   4443f:	55                   	push   %rbp
   44440:	48 89 e5             	mov    %rsp,%rbp
   44443:	48 83 ec 40          	sub    $0x40,%rsp
   44447:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   4444b:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   4444f:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   44453:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   44457:	48 c7 45 e8 f1 43 04 	movq   $0x443f1,-0x18(%rbp)
   4445e:	00 
    sp.s = s;
   4445f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44463:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   44467:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   4446c:	74 33                	je     444a1 <vsnprintf+0x62>
        sp.end = s + size - 1;
   4446e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   44472:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   44476:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4447a:	48 01 d0             	add    %rdx,%rax
   4447d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   44481:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   44485:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   44489:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   4448d:	be 00 00 00 00       	mov    $0x0,%esi
   44492:	48 89 c7             	mov    %rax,%rdi
   44495:	e8 ea f3 ff ff       	call   43884 <printer_vprintf>
        *sp.s = 0;
   4449a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4449e:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   444a1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   444a5:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   444a9:	c9                   	leave  
   444aa:	c3                   	ret    

00000000000444ab <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   444ab:	55                   	push   %rbp
   444ac:	48 89 e5             	mov    %rsp,%rbp
   444af:	48 83 ec 70          	sub    $0x70,%rsp
   444b3:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   444b7:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   444bb:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   444bf:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   444c3:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   444c7:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   444cb:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   444d2:	48 8d 45 10          	lea    0x10(%rbp),%rax
   444d6:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   444da:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   444de:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   444e2:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   444e6:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   444ea:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   444ee:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   444f2:	48 89 c7             	mov    %rax,%rdi
   444f5:	e8 45 ff ff ff       	call   4443f <vsnprintf>
   444fa:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   444fd:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   44500:	c9                   	leave  
   44501:	c3                   	ret    

0000000000044502 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   44502:	55                   	push   %rbp
   44503:	48 89 e5             	mov    %rsp,%rbp
   44506:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   4450a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   44511:	eb 13                	jmp    44526 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
   44513:	8b 45 fc             	mov    -0x4(%rbp),%eax
   44516:	48 98                	cltq   
   44518:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
   4451f:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44522:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44526:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   4452d:	7e e4                	jle    44513 <console_clear+0x11>
    }
    cursorpos = 0;
   4452f:	c7 05 c3 4a 07 00 00 	movl   $0x0,0x74ac3(%rip)        # b8ffc <cursorpos>
   44536:	00 00 00 
}
   44539:	90                   	nop
   4453a:	c9                   	leave  
   4453b:	c3                   	ret    
