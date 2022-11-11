
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
   400be:	e8 e9 06 00 00       	call   407ac <exception>

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
   40173:	e8 22 14 00 00       	call   4159a <hardware_init>
    pageinfo_init();
   40178:	e8 81 0a 00 00       	call   40bfe <pageinfo_init>
    console_clear();
   4017d:	e8 d4 3d 00 00       	call   43f56 <console_clear>
    timer_init(HZ);
   40182:	bf 64 00 00 00       	mov    $0x64,%edi
   40187:	e8 fa 18 00 00       	call   41a86 <timer_init>

    // use virtual_memory_map to remove user permissions for kernel memory
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   4018c:	48 8b 05 6d 3e 01 00 	mov    0x13e6d(%rip),%rax        # 54000 <kernel_pagetable>
   40193:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   40199:	b9 00 00 10 00       	mov    $0x100000,%ecx
   4019e:	ba 00 00 00 00       	mov    $0x0,%edx
   401a3:	be 00 00 00 00       	mov    $0x0,%esi
   401a8:	48 89 c7             	mov    %rax,%rdi
   401ab:	e8 34 26 00 00       	call   427e4 <virtual_memory_map>
					   PROC_START_ADDR, PTE_P | PTE_W);
   
    // return user permissions to console
    virtual_memory_map(kernel_pagetable, (uintptr_t) CONSOLE_ADDR, (uintptr_t) CONSOLE_ADDR,
   401b0:	ba 00 80 0b 00       	mov    $0xb8000,%edx
   401b5:	be 00 80 0b 00       	mov    $0xb8000,%esi
   401ba:	48 8b 05 3f 3e 01 00 	mov    0x13e3f(%rip),%rax        # 54000 <kernel_pagetable>
   401c1:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   401c7:	b9 00 10 00 00       	mov    $0x1000,%ecx
   401cc:	48 89 c7             	mov    %rax,%rdi
   401cf:	e8 10 26 00 00       	call   427e4 <virtual_memory_map>
	// to all memory before the start of ANY processes. This means that 
	// the assign_page function is never capable of assigning this memory
	// to a process.

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   401d4:	ba 00 0e 00 00       	mov    $0xe00,%edx
   401d9:	be 00 00 00 00       	mov    $0x0,%esi
   401de:	bf 20 10 05 00       	mov    $0x51020,%edi
   401e3:	e8 54 2e 00 00       	call   4303c <memset>
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
   40246:	be a0 3f 04 00       	mov    $0x43fa0,%esi
   4024b:	48 89 c7             	mov    %rax,%rdi
   4024e:	e8 e2 2e 00 00       	call   43135 <strcmp>
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
   40276:	be a5 3f 04 00       	mov    $0x43fa5,%esi
   4027b:	48 89 c7             	mov    %rax,%rdi
   4027e:	e8 b2 2e 00 00       	call   43135 <strcmp>
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
   402a6:	be ae 3f 04 00       	mov    $0x43fae,%esi
   402ab:	48 89 c7             	mov    %rax,%rdi
   402ae:	e8 82 2e 00 00       	call   43135 <strcmp>
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
   402d3:	be b3 3f 04 00       	mov    $0x43fb3,%esi
   402d8:	48 89 c7             	mov    %rax,%rdi
   402db:	e8 55 2e 00 00       	call   43135 <strcmp>
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
   40332:	e8 6a 08 00 00       	call   40ba1 <run>

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
   40420:	e8 17 2c 00 00       	call   4303c <memset>
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
   404af:	e8 8a 2a 00 00       	call   42f3e <memcpy>
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
   404d9:	48 05 20 10 05 00    	add    $0x51020,%rax
   404df:	be 00 00 00 00       	mov    $0x0,%esi
   404e4:	48 89 c7             	mov    %rax,%rdi
   404e7:	e8 2b 18 00 00       	call   41d17 <process_init>
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
   4050a:	48 8d 88 20 10 05 00 	lea    0x51020(%rax),%rcx
   40511:	8b 45 d8             	mov    -0x28(%rbp),%eax
   40514:	ba 00 00 00 00       	mov    $0x0,%edx
   40519:	89 c6                	mov    %eax,%esi
   4051b:	48 89 cf             	mov    %rcx,%rdi
   4051e:	e8 7e 27 00 00       	call   42ca1 <program_load>
   40523:	89 45 fc             	mov    %eax,-0x4(%rbp)
    assert(r >= 0);
   40526:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4052a:	79 14                	jns    40540 <process_setup+0x89>
   4052c:	ba b9 3f 04 00       	mov    $0x43fb9,%edx
   40531:	be c2 00 00 00       	mov    $0xc2,%esi
   40536:	bf c0 3f 04 00       	mov    $0x43fc0,%edi
   4053b:	e8 a5 1f 00 00       	call   424e5 <assert_fail>

    processes[pid].p_registers.reg_rsp = MEMSIZE_VIRTUAL; 
   40540:	8b 45 dc             	mov    -0x24(%rbp),%eax
   40543:	48 63 d0             	movslq %eax,%rdx
   40546:	48 89 d0             	mov    %rdx,%rax
   40549:	48 c1 e0 03          	shl    $0x3,%rax
   4054d:	48 29 d0             	sub    %rdx,%rax
   40550:	48 c1 e0 05          	shl    $0x5,%rax
   40554:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   4055a:	48 c7 00 00 00 30 00 	movq   $0x300000,(%rax)
    uintptr_t stack_page_va = processes[pid].p_registers.reg_rsp - PAGESIZE;
   40561:	8b 45 dc             	mov    -0x24(%rbp),%eax
   40564:	48 63 d0             	movslq %eax,%rdx
   40567:	48 89 d0             	mov    %rdx,%rax
   4056a:	48 c1 e0 03          	shl    $0x3,%rax
   4056e:	48 29 d0             	sub    %rdx,%rax
   40571:	48 c1 e0 05          	shl    $0x5,%rax
   40575:	48 05 d8 10 05 00    	add    $0x510d8,%rax
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
   405c0:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   405c6:	48 8b 00             	mov    (%rax),%rax
   405c9:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   405cd:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   405d3:	b9 00 10 00 00       	mov    $0x1000,%ecx
   405d8:	48 89 fa             	mov    %rdi,%rdx
   405db:	48 89 c7             	mov    %rax,%rdi
   405de:	e8 01 22 00 00       	call   427e4 <virtual_memory_map>
                       PAGESIZE, PTE_P | PTE_W | PTE_U);
    processes[pid].p_state = P_RUNNABLE;
   405e3:	8b 45 dc             	mov    -0x24(%rbp),%eax
   405e6:	48 63 d0             	movslq %eax,%rdx
   405e9:	48 89 d0             	mov    %rdx,%rax
   405ec:	48 c1 e0 03          	shl    $0x3,%rax
   405f0:	48 29 d0             	sub    %rdx,%rax
   405f3:	48 c1 e0 05          	shl    $0x5,%rax
   405f7:	48 05 e8 10 05 00    	add    $0x510e8,%rax
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
   40639:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
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
   40656:	c6 84 00 41 1e 05 00 	movb   $0x1,0x51e41(%rax,%rax,1)
   4065d:	01 
        pageinfo[PAGENUMBER(addr)].owner = owner;
   4065e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40662:	48 c1 e8 0c          	shr    $0xc,%rax
   40666:	48 98                	cltq   
   40668:	0f b6 55 f4          	movzbl -0xc(%rbp),%edx
   4066c:	88 94 00 40 1e 05 00 	mov    %dl,0x51e40(%rax,%rax,1)
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
   406b7:	e8 ee 24 00 00       	call   42baa <virtual_memory_lookup>

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
   406ef:	e8 b6 24 00 00       	call   42baa <virtual_memory_lookup>
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
   4071b:	e8 8a 24 00 00       	call   42baa <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   40720:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40724:	48 89 c1             	mov    %rax,%rcx
   40727:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   4072b:	ba 18 00 00 00       	mov    $0x18,%edx
   40730:	48 89 c6             	mov    %rax,%rsi
   40733:	48 89 cf             	mov    %rcx,%rdi
   40736:	e8 03 28 00 00       	call   42f3e <memcpy>
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

00000000000407ac <exception>:
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_64_registers* reg) {
   407ac:	55                   	push   %rbp
   407ad:	48 89 e5             	mov    %rsp,%rbp
   407b0:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
   407b7:	48 89 bd f8 fe ff ff 	mov    %rdi,-0x108(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   407be:	48 8b 05 3b 08 01 00 	mov    0x1083b(%rip),%rax        # 51000 <current>
   407c5:	48 8b 95 f8 fe ff ff 	mov    -0x108(%rbp),%rdx
   407cc:	48 83 c0 08          	add    $0x8,%rax
   407d0:	48 89 d6             	mov    %rdx,%rsi
   407d3:	ba 18 00 00 00       	mov    $0x18,%edx
   407d8:	48 89 c7             	mov    %rax,%rdi
   407db:	48 89 d1             	mov    %rdx,%rcx
   407de:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   407e1:	48 8b 05 18 38 01 00 	mov    0x13818(%rip),%rax        # 54000 <kernel_pagetable>
   407e8:	48 89 c7             	mov    %rax,%rdi
   407eb:	e8 c3 1e 00 00       	call   426b3 <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   407f0:	8b 05 06 88 07 00    	mov    0x78806(%rip),%eax        # b8ffc <cursorpos>
   407f6:	89 c7                	mov    %eax,%edi
   407f8:	e8 e4 15 00 00       	call   41de1 <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT && reg->reg_intno != INT_GPF) // no error due to pagefault or general fault
   407fd:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40804:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   4080b:	48 83 f8 0e          	cmp    $0xe,%rax
   4080f:	74 14                	je     40825 <exception+0x79>
   40811:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40818:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   4081f:	48 83 f8 0d          	cmp    $0xd,%rax
   40823:	75 16                	jne    4083b <exception+0x8f>
            || (reg->reg_err & PFERR_USER)) // pagefault error in user mode 
   40825:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   4082c:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40833:	83 e0 04             	and    $0x4,%eax
   40836:	48 85 c0             	test   %rax,%rax
   40839:	74 1a                	je     40855 <exception+0xa9>
    {
        check_virtual_memory();
   4083b:	e8 55 07 00 00       	call   40f95 <check_virtual_memory>
        if(disp_global){
   40840:	0f b6 05 b9 47 00 00 	movzbl 0x47b9(%rip),%eax        # 45000 <disp_global>
   40847:	84 c0                	test   %al,%al
   40849:	74 0a                	je     40855 <exception+0xa9>
            memshow_physical();
   4084b:	e8 bd 08 00 00       	call   4110d <memshow_physical>
            memshow_virtual_animate();
   40850:	e8 e7 0b 00 00       	call   4143c <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   40855:	e8 6a 1a 00 00       	call   422c4 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   4085a:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40861:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40868:	48 83 e8 0e          	sub    $0xe,%rax
   4086c:	48 83 f8 2a          	cmp    $0x2a,%rax
   40870:	0f 87 7c 02 00 00    	ja     40af2 <exception+0x346>
   40876:	48 8b 04 c5 78 40 04 	mov    0x44078(,%rax,8),%rax
   4087d:	00 
   4087e:	ff e0                	jmp    *%rax

    case INT_SYS_PANIC:
	    // rdi stores pointer for msg string
	    {
		char msg[160];
		uintptr_t addr = current->p_registers.reg_rdi;
   40880:	48 8b 05 79 07 01 00 	mov    0x10779(%rip),%rax        # 51000 <current>
   40887:	48 8b 40 38          	mov    0x38(%rax),%rax
   4088b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
		if((void *)addr == NULL)
   4088f:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40894:	75 0f                	jne    408a5 <exception+0xf9>
		    panic(NULL);
   40896:	bf 00 00 00 00       	mov    $0x0,%edi
   4089b:	b8 00 00 00 00       	mov    $0x0,%eax
   408a0:	e8 60 1b 00 00       	call   42405 <panic>
		vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   408a5:	48 8b 05 54 07 01 00 	mov    0x10754(%rip),%rax        # 51000 <current>
   408ac:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   408b3:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   408b7:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   408bb:	48 89 ce             	mov    %rcx,%rsi
   408be:	48 89 c7             	mov    %rax,%rdi
   408c1:	e8 e4 22 00 00       	call   42baa <virtual_memory_lookup>
		memcpy(msg, (void *)map.pa, 160);
   408c6:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   408ca:	48 89 c1             	mov    %rax,%rcx
   408cd:	48 8d 85 08 ff ff ff 	lea    -0xf8(%rbp),%rax
   408d4:	ba a0 00 00 00       	mov    $0xa0,%edx
   408d9:	48 89 ce             	mov    %rcx,%rsi
   408dc:	48 89 c7             	mov    %rax,%rdi
   408df:	e8 5a 26 00 00       	call   42f3e <memcpy>
		panic(msg);
   408e4:	48 8d 85 08 ff ff ff 	lea    -0xf8(%rbp),%rax
   408eb:	48 89 c7             	mov    %rax,%rdi
   408ee:	b8 00 00 00 00       	mov    $0x0,%eax
   408f3:	e8 0d 1b 00 00       	call   42405 <panic>
	    }
	    panic(NULL);
	    break;                  // will not be reached

    case INT_SYS_GETPID:
        current->p_registers.reg_rax = current->p_pid;
   408f8:	48 8b 05 01 07 01 00 	mov    0x10701(%rip),%rax        # 51000 <current>
   408ff:	8b 10                	mov    (%rax),%edx
   40901:	48 8b 05 f8 06 01 00 	mov    0x106f8(%rip),%rax        # 51000 <current>
   40908:	48 63 d2             	movslq %edx,%rdx
   4090b:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   4090f:	e9 ee 01 00 00       	jmp    40b02 <exception+0x356>

    case INT_SYS_YIELD:
        schedule();
   40914:	e8 12 02 00 00       	call   40b2b <schedule>
        break;                  /* will not be reached */
   40919:	e9 e4 01 00 00       	jmp    40b02 <exception+0x356>

    case INT_SYS_PAGE_ALLOC: {
        uintptr_t va = current->p_registers.reg_rdi;
   4091e:	48 8b 05 db 06 01 00 	mov    0x106db(%rip),%rax        # 51000 <current>
   40925:	48 8b 40 38          	mov    0x38(%rax),%rax
   40929:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
	uintptr_t pa;
	next_free_page(&pa);
   4092d:	48 8d 45 a8          	lea    -0x58(%rbp),%rax
   40931:	48 89 c7             	mov    %rax,%rdi
   40934:	e8 fe f9 ff ff       	call   40337 <next_free_page>
        int r = assign_physical_page(pa, current->p_pid); 
   40939:	48 8b 05 c0 06 01 00 	mov    0x106c0(%rip),%rax        # 51000 <current>
   40940:	8b 00                	mov    (%rax),%eax
   40942:	0f be d0             	movsbl %al,%edx
   40945:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   40949:	89 d6                	mov    %edx,%esi
   4094b:	48 89 c7             	mov    %rax,%rdi
   4094e:	e8 b3 fc ff ff       	call   40606 <assign_physical_page>
   40953:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (r >= 0) {
   40956:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   4095a:	78 2b                	js     40987 <exception+0x1db>
            virtual_memory_map(current->p_pagetable, va, pa,
   4095c:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   40960:	48 8b 05 99 06 01 00 	mov    0x10699(%rip),%rax        # 51000 <current>
   40967:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   4096e:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   40972:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40978:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4097d:	48 89 c7             	mov    %rax,%rdi
   40980:	e8 5f 1e 00 00       	call   427e4 <virtual_memory_map>
   40985:	eb 19                	jmp    409a0 <exception+0x1f4>
                               PAGESIZE, PTE_P | PTE_W | PTE_U);
        }
	else
		console_printf(CPOS(23, 0), 0x0400, "Out of physical memory!\n");	
   40987:	ba d0 3f 04 00       	mov    $0x43fd0,%edx
   4098c:	be 00 04 00 00       	mov    $0x400,%esi
   40991:	bf 30 07 00 00       	mov    $0x730,%edi
   40996:	b8 00 00 00 00       	mov    $0x0,%eax
   4099b:	e8 53 34 00 00       	call   43df3 <console_printf>
        current->p_registers.reg_rax = r;
   409a0:	48 8b 05 59 06 01 00 	mov    0x10659(%rip),%rax        # 51000 <current>
   409a7:	8b 55 f4             	mov    -0xc(%rbp),%edx
   409aa:	48 63 d2             	movslq %edx,%rdx
   409ad:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   409b1:	e9 4c 01 00 00       	jmp    40b02 <exception+0x356>
    }

    case INT_SYS_MAPPING:
    {
	    syscall_mapping(current);
   409b6:	48 8b 05 43 06 01 00 	mov    0x10643(%rip),%rax        # 51000 <current>
   409bd:	48 89 c7             	mov    %rax,%rdi
   409c0:	e8 b5 fc ff ff       	call   4067a <syscall_mapping>
            break;
   409c5:	e9 38 01 00 00       	jmp    40b02 <exception+0x356>
    }

    case INT_SYS_MEM_TOG:
	{
	    syscall_mem_tog(current);
   409ca:	48 8b 05 2f 06 01 00 	mov    0x1062f(%rip),%rax        # 51000 <current>
   409d1:	48 89 c7             	mov    %rax,%rdi
   409d4:	e8 6a fd ff ff       	call   40743 <syscall_mem_tog>
	    break;
   409d9:	e9 24 01 00 00       	jmp    40b02 <exception+0x356>
	}

    case INT_TIMER:
        ++ticks;
   409de:	8b 05 3c 14 01 00    	mov    0x1143c(%rip),%eax        # 51e20 <ticks>
   409e4:	83 c0 01             	add    $0x1,%eax
   409e7:	89 05 33 14 01 00    	mov    %eax,0x11433(%rip)        # 51e20 <ticks>
        schedule();
   409ed:	e8 39 01 00 00       	call   40b2b <schedule>
        break;                  /* will not be reached */
   409f2:	e9 0b 01 00 00       	jmp    40b02 <exception+0x356>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   409f7:	0f 20 d0             	mov    %cr2,%rax
   409fa:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    return val;
   409fe:	48 8b 45 c8          	mov    -0x38(%rbp),%rax

    case INT_PAGEFAULT: {
        // Analyze faulting address and access type.
        uintptr_t addr = rcr2();
   40a02:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
        const char* operation = reg->reg_err & PFERR_WRITE
   40a06:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40a0d:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40a14:	83 e0 02             	and    $0x2,%eax
                ? "write" : "read";
   40a17:	48 85 c0             	test   %rax,%rax
   40a1a:	74 07                	je     40a23 <exception+0x277>
   40a1c:	b8 e9 3f 04 00       	mov    $0x43fe9,%eax
   40a21:	eb 05                	jmp    40a28 <exception+0x27c>
   40a23:	b8 ef 3f 04 00       	mov    $0x43fef,%eax
        const char* operation = reg->reg_err & PFERR_WRITE
   40a28:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        const char* problem = reg->reg_err & PFERR_PRESENT
   40a2c:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40a33:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40a3a:	83 e0 01             	and    $0x1,%eax
                ? "protection problem" : "missing page";
   40a3d:	48 85 c0             	test   %rax,%rax
   40a40:	74 07                	je     40a49 <exception+0x29d>
   40a42:	b8 f4 3f 04 00       	mov    $0x43ff4,%eax
   40a47:	eb 05                	jmp    40a4e <exception+0x2a2>
   40a49:	b8 07 40 04 00       	mov    $0x44007,%eax
        const char* problem = reg->reg_err & PFERR_PRESENT
   40a4e:	48 89 45 d0          	mov    %rax,-0x30(%rbp)

        if (!(reg->reg_err & PFERR_USER)) {
   40a52:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40a59:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40a60:	83 e0 04             	and    $0x4,%eax
   40a63:	48 85 c0             	test   %rax,%rax
   40a66:	75 2f                	jne    40a97 <exception+0x2eb>
            panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   40a68:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40a6f:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   40a76:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
   40a7a:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   40a7e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40a82:	49 89 f0             	mov    %rsi,%r8
   40a85:	48 89 c6             	mov    %rax,%rsi
   40a88:	bf 18 40 04 00       	mov    $0x44018,%edi
   40a8d:	b8 00 00 00 00       	mov    $0x0,%eax
   40a92:	e8 6e 19 00 00       	call   42405 <panic>
                  addr, operation, problem, reg->reg_rip);
        }
        console_printf(CPOS(24, 0), 0x0C00,
   40a97:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40a9e:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                       "Process %d page fault for %p (%s %s, rip=%p)!\n",
                       current->p_pid, addr, operation, problem, reg->reg_rip);
   40aa5:	48 8b 05 54 05 01 00 	mov    0x10554(%rip),%rax        # 51000 <current>
        console_printf(CPOS(24, 0), 0x0C00,
   40aac:	8b 00                	mov    (%rax),%eax
   40aae:	48 8b 75 d8          	mov    -0x28(%rbp),%rsi
   40ab2:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   40ab6:	52                   	push   %rdx
   40ab7:	ff 75 d0             	push   -0x30(%rbp)
   40aba:	49 89 f1             	mov    %rsi,%r9
   40abd:	49 89 c8             	mov    %rcx,%r8
   40ac0:	89 c1                	mov    %eax,%ecx
   40ac2:	ba 48 40 04 00       	mov    $0x44048,%edx
   40ac7:	be 00 0c 00 00       	mov    $0xc00,%esi
   40acc:	bf 80 07 00 00       	mov    $0x780,%edi
   40ad1:	b8 00 00 00 00       	mov    $0x0,%eax
   40ad6:	e8 18 33 00 00       	call   43df3 <console_printf>
   40adb:	48 83 c4 10          	add    $0x10,%rsp
        current->p_state = P_BROKEN;
   40adf:	48 8b 05 1a 05 01 00 	mov    0x1051a(%rip),%rax        # 51000 <current>
   40ae6:	c7 80 c8 00 00 00 03 	movl   $0x3,0xc8(%rax)
   40aed:	00 00 00 
        break;
   40af0:	eb 10                	jmp    40b02 <exception+0x356>
    }

    default:
        default_exception(current);
   40af2:	48 8b 05 07 05 01 00 	mov    0x10507(%rip),%rax        # 51000 <current>
   40af9:	48 89 c7             	mov    %rax,%rdi
   40afc:	e8 14 1a 00 00       	call   42515 <default_exception>
        break;                  /* will not be reached */
   40b01:	90                   	nop

    }


    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   40b02:	48 8b 05 f7 04 01 00 	mov    0x104f7(%rip),%rax        # 51000 <current>
   40b09:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   40b0f:	83 f8 01             	cmp    $0x1,%eax
   40b12:	75 0f                	jne    40b23 <exception+0x377>
        run(current);
   40b14:	48 8b 05 e5 04 01 00 	mov    0x104e5(%rip),%rax        # 51000 <current>
   40b1b:	48 89 c7             	mov    %rax,%rdi
   40b1e:	e8 7e 00 00 00       	call   40ba1 <run>
    } else {
        schedule();
   40b23:	e8 03 00 00 00       	call   40b2b <schedule>
    }
}
   40b28:	90                   	nop
   40b29:	c9                   	leave  
   40b2a:	c3                   	ret    

0000000000040b2b <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   40b2b:	55                   	push   %rbp
   40b2c:	48 89 e5             	mov    %rsp,%rbp
   40b2f:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   40b33:	48 8b 05 c6 04 01 00 	mov    0x104c6(%rip),%rax        # 51000 <current>
   40b3a:	8b 00                	mov    (%rax),%eax
   40b3c:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   40b3f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40b42:	8d 50 01             	lea    0x1(%rax),%edx
   40b45:	89 d0                	mov    %edx,%eax
   40b47:	c1 f8 1f             	sar    $0x1f,%eax
   40b4a:	c1 e8 1c             	shr    $0x1c,%eax
   40b4d:	01 c2                	add    %eax,%edx
   40b4f:	83 e2 0f             	and    $0xf,%edx
   40b52:	29 c2                	sub    %eax,%edx
   40b54:	89 55 fc             	mov    %edx,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   40b57:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40b5a:	48 63 d0             	movslq %eax,%rdx
   40b5d:	48 89 d0             	mov    %rdx,%rax
   40b60:	48 c1 e0 03          	shl    $0x3,%rax
   40b64:	48 29 d0             	sub    %rdx,%rax
   40b67:	48 c1 e0 05          	shl    $0x5,%rax
   40b6b:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   40b71:	8b 00                	mov    (%rax),%eax
   40b73:	83 f8 01             	cmp    $0x1,%eax
   40b76:	75 22                	jne    40b9a <schedule+0x6f>
            run(&processes[pid]);
   40b78:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40b7b:	48 63 d0             	movslq %eax,%rdx
   40b7e:	48 89 d0             	mov    %rdx,%rax
   40b81:	48 c1 e0 03          	shl    $0x3,%rax
   40b85:	48 29 d0             	sub    %rdx,%rax
   40b88:	48 c1 e0 05          	shl    $0x5,%rax
   40b8c:	48 05 20 10 05 00    	add    $0x51020,%rax
   40b92:	48 89 c7             	mov    %rax,%rdi
   40b95:	e8 07 00 00 00       	call   40ba1 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   40b9a:	e8 25 17 00 00       	call   422c4 <check_keyboard>
        pid = (pid + 1) % NPROC;
   40b9f:	eb 9e                	jmp    40b3f <schedule+0x14>

0000000000040ba1 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   40ba1:	55                   	push   %rbp
   40ba2:	48 89 e5             	mov    %rsp,%rbp
   40ba5:	48 83 ec 10          	sub    $0x10,%rsp
   40ba9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   40bad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40bb1:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   40bb7:	83 f8 01             	cmp    $0x1,%eax
   40bba:	74 14                	je     40bd0 <run+0x2f>
   40bbc:	ba d0 41 04 00       	mov    $0x441d0,%edx
   40bc1:	be 9d 01 00 00       	mov    $0x19d,%esi
   40bc6:	bf c0 3f 04 00       	mov    $0x43fc0,%edi
   40bcb:	e8 15 19 00 00       	call   424e5 <assert_fail>
    current = p;
   40bd0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40bd4:	48 89 05 25 04 01 00 	mov    %rax,0x10425(%rip)        # 51000 <current>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   40bdb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40bdf:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40be6:	48 89 c7             	mov    %rax,%rdi
   40be9:	e8 c5 1a 00 00       	call   426b3 <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   40bee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40bf2:	48 83 c0 08          	add    $0x8,%rax
   40bf6:	48 89 c7             	mov    %rax,%rdi
   40bf9:	e8 c5 f4 ff ff       	call   400c3 <exception_return>

0000000000040bfe <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   40bfe:	55                   	push   %rbp
   40bff:	48 89 e5             	mov    %rsp,%rbp
   40c02:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40c06:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40c0d:	00 
   40c0e:	e9 81 00 00 00       	jmp    40c94 <pageinfo_init+0x96>
        int owner;
        if (physical_memory_isreserved(addr)) {
   40c13:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c17:	48 89 c7             	mov    %rax,%rdi
   40c1a:	e8 33 0f 00 00       	call   41b52 <physical_memory_isreserved>
   40c1f:	85 c0                	test   %eax,%eax
   40c21:	74 09                	je     40c2c <pageinfo_init+0x2e>
            owner = PO_RESERVED;
   40c23:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   40c2a:	eb 2f                	jmp    40c5b <pageinfo_init+0x5d>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   40c2c:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   40c33:	00 
   40c34:	76 0b                	jbe    40c41 <pageinfo_init+0x43>
   40c36:	b8 08 a0 05 00       	mov    $0x5a008,%eax
   40c3b:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40c3f:	72 0a                	jb     40c4b <pageinfo_init+0x4d>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   40c41:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   40c48:	00 
   40c49:	75 09                	jne    40c54 <pageinfo_init+0x56>
            owner = PO_KERNEL;
   40c4b:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   40c52:	eb 07                	jmp    40c5b <pageinfo_init+0x5d>
        } else {
            owner = PO_FREE;
   40c54:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40c5b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c5f:	48 c1 e8 0c          	shr    $0xc,%rax
   40c63:	89 c1                	mov    %eax,%ecx
   40c65:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40c68:	89 c2                	mov    %eax,%edx
   40c6a:	48 63 c1             	movslq %ecx,%rax
   40c6d:	88 94 00 40 1e 05 00 	mov    %dl,0x51e40(%rax,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   40c74:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40c78:	0f 95 c2             	setne  %dl
   40c7b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c7f:	48 c1 e8 0c          	shr    $0xc,%rax
   40c83:	48 98                	cltq   
   40c85:	88 94 00 41 1e 05 00 	mov    %dl,0x51e41(%rax,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40c8c:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40c93:	00 
   40c94:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40c9b:	00 
   40c9c:	0f 86 71 ff ff ff    	jbe    40c13 <pageinfo_init+0x15>
    }
}
   40ca2:	90                   	nop
   40ca3:	90                   	nop
   40ca4:	c9                   	leave  
   40ca5:	c3                   	ret    

0000000000040ca6 <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   40ca6:	55                   	push   %rbp
   40ca7:	48 89 e5             	mov    %rsp,%rbp
   40caa:	48 83 ec 50          	sub    $0x50,%rsp
   40cae:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   40cb2:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40cb6:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40cbc:	48 89 c2             	mov    %rax,%rdx
   40cbf:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40cc3:	48 39 c2             	cmp    %rax,%rdx
   40cc6:	74 14                	je     40cdc <check_page_table_mappings+0x36>
   40cc8:	ba f0 41 04 00       	mov    $0x441f0,%edx
   40ccd:	be c7 01 00 00       	mov    $0x1c7,%esi
   40cd2:	bf c0 3f 04 00       	mov    $0x43fc0,%edi
   40cd7:	e8 09 18 00 00       	call   424e5 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40cdc:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   40ce3:	00 
   40ce4:	e9 9a 00 00 00       	jmp    40d83 <check_page_table_mappings+0xdd>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   40ce9:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   40ced:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40cf1:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40cf5:	48 89 ce             	mov    %rcx,%rsi
   40cf8:	48 89 c7             	mov    %rax,%rdi
   40cfb:	e8 aa 1e 00 00       	call   42baa <virtual_memory_lookup>
        if (vam.pa != va) {
   40d00:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40d04:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40d08:	74 27                	je     40d31 <check_page_table_mappings+0x8b>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   40d0a:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40d0e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d12:	49 89 d0             	mov    %rdx,%r8
   40d15:	48 89 c1             	mov    %rax,%rcx
   40d18:	ba 0f 42 04 00       	mov    $0x4420f,%edx
   40d1d:	be 00 c0 00 00       	mov    $0xc000,%esi
   40d22:	bf e0 06 00 00       	mov    $0x6e0,%edi
   40d27:	b8 00 00 00 00       	mov    $0x0,%eax
   40d2c:	e8 c2 30 00 00       	call   43df3 <console_printf>
        }
        assert(vam.pa == va);
   40d31:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40d35:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40d39:	74 14                	je     40d4f <check_page_table_mappings+0xa9>
   40d3b:	ba 19 42 04 00       	mov    $0x44219,%edx
   40d40:	be d0 01 00 00       	mov    $0x1d0,%esi
   40d45:	bf c0 3f 04 00       	mov    $0x43fc0,%edi
   40d4a:	e8 96 17 00 00       	call   424e5 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   40d4f:	b8 00 50 04 00       	mov    $0x45000,%eax
   40d54:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40d58:	72 21                	jb     40d7b <check_page_table_mappings+0xd5>
            assert(vam.perm & PTE_W);
   40d5a:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40d5d:	48 98                	cltq   
   40d5f:	83 e0 02             	and    $0x2,%eax
   40d62:	48 85 c0             	test   %rax,%rax
   40d65:	75 14                	jne    40d7b <check_page_table_mappings+0xd5>
   40d67:	ba 26 42 04 00       	mov    $0x44226,%edx
   40d6c:	be d2 01 00 00       	mov    $0x1d2,%esi
   40d71:	bf c0 3f 04 00       	mov    $0x43fc0,%edi
   40d76:	e8 6a 17 00 00       	call   424e5 <assert_fail>
         va += PAGESIZE) {
   40d7b:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40d82:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40d83:	b8 08 a0 05 00       	mov    $0x5a008,%eax
   40d88:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40d8c:	0f 82 57 ff ff ff    	jb     40ce9 <check_page_table_mappings+0x43>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   40d92:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   40d99:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   40d9a:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   40d9e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40da2:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40da6:	48 89 ce             	mov    %rcx,%rsi
   40da9:	48 89 c7             	mov    %rax,%rdi
   40dac:	e8 f9 1d 00 00       	call   42baa <virtual_memory_lookup>
    assert(vam.pa == kstack);
   40db1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40db5:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   40db9:	74 14                	je     40dcf <check_page_table_mappings+0x129>
   40dbb:	ba 37 42 04 00       	mov    $0x44237,%edx
   40dc0:	be d9 01 00 00       	mov    $0x1d9,%esi
   40dc5:	bf c0 3f 04 00       	mov    $0x43fc0,%edi
   40dca:	e8 16 17 00 00       	call   424e5 <assert_fail>
    assert(vam.perm & PTE_W);
   40dcf:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40dd2:	48 98                	cltq   
   40dd4:	83 e0 02             	and    $0x2,%eax
   40dd7:	48 85 c0             	test   %rax,%rax
   40dda:	75 14                	jne    40df0 <check_page_table_mappings+0x14a>
   40ddc:	ba 26 42 04 00       	mov    $0x44226,%edx
   40de1:	be da 01 00 00       	mov    $0x1da,%esi
   40de6:	bf c0 3f 04 00       	mov    $0x43fc0,%edi
   40deb:	e8 f5 16 00 00       	call   424e5 <assert_fail>
}
   40df0:	90                   	nop
   40df1:	c9                   	leave  
   40df2:	c3                   	ret    

0000000000040df3 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   40df3:	55                   	push   %rbp
   40df4:	48 89 e5             	mov    %rsp,%rbp
   40df7:	48 83 ec 20          	sub    $0x20,%rsp
   40dfb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40dff:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   40e02:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40e05:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   40e08:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   40e0f:	48 8b 05 ea 31 01 00 	mov    0x131ea(%rip),%rax        # 54000 <kernel_pagetable>
   40e16:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40e1a:	75 67                	jne    40e83 <check_page_table_ownership+0x90>
        owner = PO_KERNEL;
   40e1c:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40e23:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   40e2a:	eb 51                	jmp    40e7d <check_page_table_ownership+0x8a>
            if (processes[xpid].p_state != P_FREE
   40e2c:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40e2f:	48 63 d0             	movslq %eax,%rdx
   40e32:	48 89 d0             	mov    %rdx,%rax
   40e35:	48 c1 e0 03          	shl    $0x3,%rax
   40e39:	48 29 d0             	sub    %rdx,%rax
   40e3c:	48 c1 e0 05          	shl    $0x5,%rax
   40e40:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   40e46:	8b 00                	mov    (%rax),%eax
   40e48:	85 c0                	test   %eax,%eax
   40e4a:	74 2d                	je     40e79 <check_page_table_ownership+0x86>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   40e4c:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40e4f:	48 63 d0             	movslq %eax,%rdx
   40e52:	48 89 d0             	mov    %rdx,%rax
   40e55:	48 c1 e0 03          	shl    $0x3,%rax
   40e59:	48 29 d0             	sub    %rdx,%rax
   40e5c:	48 c1 e0 05          	shl    $0x5,%rax
   40e60:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   40e66:	48 8b 10             	mov    (%rax),%rdx
   40e69:	48 8b 05 90 31 01 00 	mov    0x13190(%rip),%rax        # 54000 <kernel_pagetable>
   40e70:	48 39 c2             	cmp    %rax,%rdx
   40e73:	75 04                	jne    40e79 <check_page_table_ownership+0x86>
                ++expected_refcount;
   40e75:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40e79:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   40e7d:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   40e81:	7e a9                	jle    40e2c <check_page_table_ownership+0x39>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   40e83:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   40e86:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40e89:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40e8d:	be 00 00 00 00       	mov    $0x0,%esi
   40e92:	48 89 c7             	mov    %rax,%rdi
   40e95:	e8 03 00 00 00       	call   40e9d <check_page_table_ownership_level>
}
   40e9a:	90                   	nop
   40e9b:	c9                   	leave  
   40e9c:	c3                   	ret    

0000000000040e9d <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   40e9d:	55                   	push   %rbp
   40e9e:	48 89 e5             	mov    %rsp,%rbp
   40ea1:	48 83 ec 30          	sub    $0x30,%rsp
   40ea5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40ea9:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   40eac:	89 55 e0             	mov    %edx,-0x20(%rbp)
   40eaf:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   40eb2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40eb6:	48 c1 e8 0c          	shr    $0xc,%rax
   40eba:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   40ebf:	7e 14                	jle    40ed5 <check_page_table_ownership_level+0x38>
   40ec1:	ba 48 42 04 00       	mov    $0x44248,%edx
   40ec6:	be f7 01 00 00       	mov    $0x1f7,%esi
   40ecb:	bf c0 3f 04 00       	mov    $0x43fc0,%edi
   40ed0:	e8 10 16 00 00       	call   424e5 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   40ed5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40ed9:	48 c1 e8 0c          	shr    $0xc,%rax
   40edd:	48 98                	cltq   
   40edf:	0f b6 84 00 40 1e 05 	movzbl 0x51e40(%rax,%rax,1),%eax
   40ee6:	00 
   40ee7:	0f be c0             	movsbl %al,%eax
   40eea:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   40eed:	74 14                	je     40f03 <check_page_table_ownership_level+0x66>
   40eef:	ba 60 42 04 00       	mov    $0x44260,%edx
   40ef4:	be f8 01 00 00       	mov    $0x1f8,%esi
   40ef9:	bf c0 3f 04 00       	mov    $0x43fc0,%edi
   40efe:	e8 e2 15 00 00       	call   424e5 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   40f03:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40f07:	48 c1 e8 0c          	shr    $0xc,%rax
   40f0b:	48 98                	cltq   
   40f0d:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   40f14:	00 
   40f15:	0f be c0             	movsbl %al,%eax
   40f18:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   40f1b:	74 14                	je     40f31 <check_page_table_ownership_level+0x94>
   40f1d:	ba 88 42 04 00       	mov    $0x44288,%edx
   40f22:	be f9 01 00 00       	mov    $0x1f9,%esi
   40f27:	bf c0 3f 04 00       	mov    $0x43fc0,%edi
   40f2c:	e8 b4 15 00 00       	call   424e5 <assert_fail>
    if (level < 3) {
   40f31:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   40f35:	7f 5b                	jg     40f92 <check_page_table_ownership_level+0xf5>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   40f37:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   40f3e:	eb 49                	jmp    40f89 <check_page_table_ownership_level+0xec>
            if (pt->entry[index]) {
   40f40:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40f44:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40f47:	48 63 d2             	movslq %edx,%rdx
   40f4a:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   40f4e:	48 85 c0             	test   %rax,%rax
   40f51:	74 32                	je     40f85 <check_page_table_ownership_level+0xe8>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   40f53:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40f57:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40f5a:	48 63 d2             	movslq %edx,%rdx
   40f5d:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   40f61:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   40f67:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   40f6b:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40f6e:	8d 70 01             	lea    0x1(%rax),%esi
   40f71:	8b 55 e0             	mov    -0x20(%rbp),%edx
   40f74:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40f78:	b9 01 00 00 00       	mov    $0x1,%ecx
   40f7d:	48 89 c7             	mov    %rax,%rdi
   40f80:	e8 18 ff ff ff       	call   40e9d <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   40f85:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   40f89:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   40f90:	7e ae                	jle    40f40 <check_page_table_ownership_level+0xa3>
            }
        }
    }
}
   40f92:	90                   	nop
   40f93:	c9                   	leave  
   40f94:	c3                   	ret    

0000000000040f95 <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   40f95:	55                   	push   %rbp
   40f96:	48 89 e5             	mov    %rsp,%rbp
   40f99:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   40f9d:	8b 05 45 01 01 00    	mov    0x10145(%rip),%eax        # 510e8 <processes+0xc8>
   40fa3:	85 c0                	test   %eax,%eax
   40fa5:	74 14                	je     40fbb <check_virtual_memory+0x26>
   40fa7:	ba b8 42 04 00       	mov    $0x442b8,%edx
   40fac:	be 0c 02 00 00       	mov    $0x20c,%esi
   40fb1:	bf c0 3f 04 00       	mov    $0x43fc0,%edi
   40fb6:	e8 2a 15 00 00       	call   424e5 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   40fbb:	48 8b 05 3e 30 01 00 	mov    0x1303e(%rip),%rax        # 54000 <kernel_pagetable>
   40fc2:	48 89 c7             	mov    %rax,%rdi
   40fc5:	e8 dc fc ff ff       	call   40ca6 <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   40fca:	48 8b 05 2f 30 01 00 	mov    0x1302f(%rip),%rax        # 54000 <kernel_pagetable>
   40fd1:	be ff ff ff ff       	mov    $0xffffffff,%esi
   40fd6:	48 89 c7             	mov    %rax,%rdi
   40fd9:	e8 15 fe ff ff       	call   40df3 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   40fde:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   40fe5:	e9 9c 00 00 00       	jmp    41086 <check_virtual_memory+0xf1>
        if (processes[pid].p_state != P_FREE
   40fea:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40fed:	48 63 d0             	movslq %eax,%rdx
   40ff0:	48 89 d0             	mov    %rdx,%rax
   40ff3:	48 c1 e0 03          	shl    $0x3,%rax
   40ff7:	48 29 d0             	sub    %rdx,%rax
   40ffa:	48 c1 e0 05          	shl    $0x5,%rax
   40ffe:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   41004:	8b 00                	mov    (%rax),%eax
   41006:	85 c0                	test   %eax,%eax
   41008:	74 78                	je     41082 <check_virtual_memory+0xed>
            && processes[pid].p_pagetable != kernel_pagetable) {
   4100a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4100d:	48 63 d0             	movslq %eax,%rdx
   41010:	48 89 d0             	mov    %rdx,%rax
   41013:	48 c1 e0 03          	shl    $0x3,%rax
   41017:	48 29 d0             	sub    %rdx,%rax
   4101a:	48 c1 e0 05          	shl    $0x5,%rax
   4101e:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   41024:	48 8b 10             	mov    (%rax),%rdx
   41027:	48 8b 05 d2 2f 01 00 	mov    0x12fd2(%rip),%rax        # 54000 <kernel_pagetable>
   4102e:	48 39 c2             	cmp    %rax,%rdx
   41031:	74 4f                	je     41082 <check_virtual_memory+0xed>
            check_page_table_mappings(processes[pid].p_pagetable);
   41033:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41036:	48 63 d0             	movslq %eax,%rdx
   41039:	48 89 d0             	mov    %rdx,%rax
   4103c:	48 c1 e0 03          	shl    $0x3,%rax
   41040:	48 29 d0             	sub    %rdx,%rax
   41043:	48 c1 e0 05          	shl    $0x5,%rax
   41047:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   4104d:	48 8b 00             	mov    (%rax),%rax
   41050:	48 89 c7             	mov    %rax,%rdi
   41053:	e8 4e fc ff ff       	call   40ca6 <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   41058:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4105b:	48 63 d0             	movslq %eax,%rdx
   4105e:	48 89 d0             	mov    %rdx,%rax
   41061:	48 c1 e0 03          	shl    $0x3,%rax
   41065:	48 29 d0             	sub    %rdx,%rax
   41068:	48 c1 e0 05          	shl    $0x5,%rax
   4106c:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   41072:	48 8b 00             	mov    (%rax),%rax
   41075:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41078:	89 d6                	mov    %edx,%esi
   4107a:	48 89 c7             	mov    %rax,%rdi
   4107d:	e8 71 fd ff ff       	call   40df3 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   41082:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41086:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   4108a:	0f 8e 5a ff ff ff    	jle    40fea <check_virtual_memory+0x55>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41090:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41097:	eb 67                	jmp    41100 <check_virtual_memory+0x16b>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   41099:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4109c:	48 98                	cltq   
   4109e:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   410a5:	00 
   410a6:	84 c0                	test   %al,%al
   410a8:	7e 52                	jle    410fc <check_virtual_memory+0x167>
   410aa:	8b 45 f8             	mov    -0x8(%rbp),%eax
   410ad:	48 98                	cltq   
   410af:	0f b6 84 00 40 1e 05 	movzbl 0x51e40(%rax,%rax,1),%eax
   410b6:	00 
   410b7:	84 c0                	test   %al,%al
   410b9:	78 41                	js     410fc <check_virtual_memory+0x167>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   410bb:	8b 45 f8             	mov    -0x8(%rbp),%eax
   410be:	48 98                	cltq   
   410c0:	0f b6 84 00 40 1e 05 	movzbl 0x51e40(%rax,%rax,1),%eax
   410c7:	00 
   410c8:	0f be c0             	movsbl %al,%eax
   410cb:	48 63 d0             	movslq %eax,%rdx
   410ce:	48 89 d0             	mov    %rdx,%rax
   410d1:	48 c1 e0 03          	shl    $0x3,%rax
   410d5:	48 29 d0             	sub    %rdx,%rax
   410d8:	48 c1 e0 05          	shl    $0x5,%rax
   410dc:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   410e2:	8b 00                	mov    (%rax),%eax
   410e4:	85 c0                	test   %eax,%eax
   410e6:	75 14                	jne    410fc <check_virtual_memory+0x167>
   410e8:	ba d8 42 04 00       	mov    $0x442d8,%edx
   410ed:	be 23 02 00 00       	mov    $0x223,%esi
   410f2:	bf c0 3f 04 00       	mov    $0x43fc0,%edi
   410f7:	e8 e9 13 00 00       	call   424e5 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   410fc:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41100:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   41107:	7e 90                	jle    41099 <check_virtual_memory+0x104>
        }
    }
}
   41109:	90                   	nop
   4110a:	90                   	nop
   4110b:	c9                   	leave  
   4110c:	c3                   	ret    

000000000004110d <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   4110d:	55                   	push   %rbp
   4110e:	48 89 e5             	mov    %rsp,%rbp
   41111:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   41115:	ba 46 43 04 00       	mov    $0x44346,%edx
   4111a:	be 00 0f 00 00       	mov    $0xf00,%esi
   4111f:	bf 20 00 00 00       	mov    $0x20,%edi
   41124:	b8 00 00 00 00       	mov    $0x0,%eax
   41129:	e8 c5 2c 00 00       	call   43df3 <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4112e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41135:	e9 f8 00 00 00       	jmp    41232 <memshow_physical+0x125>
        if (pn % 64 == 0) {
   4113a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4113d:	83 e0 3f             	and    $0x3f,%eax
   41140:	85 c0                	test   %eax,%eax
   41142:	75 3c                	jne    41180 <memshow_physical+0x73>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   41144:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41147:	c1 e0 0c             	shl    $0xc,%eax
   4114a:	89 c1                	mov    %eax,%ecx
   4114c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4114f:	8d 50 3f             	lea    0x3f(%rax),%edx
   41152:	85 c0                	test   %eax,%eax
   41154:	0f 48 c2             	cmovs  %edx,%eax
   41157:	c1 f8 06             	sar    $0x6,%eax
   4115a:	8d 50 01             	lea    0x1(%rax),%edx
   4115d:	89 d0                	mov    %edx,%eax
   4115f:	c1 e0 02             	shl    $0x2,%eax
   41162:	01 d0                	add    %edx,%eax
   41164:	c1 e0 04             	shl    $0x4,%eax
   41167:	83 c0 03             	add    $0x3,%eax
   4116a:	ba 56 43 04 00       	mov    $0x44356,%edx
   4116f:	be 00 0f 00 00       	mov    $0xf00,%esi
   41174:	89 c7                	mov    %eax,%edi
   41176:	b8 00 00 00 00       	mov    $0x0,%eax
   4117b:	e8 73 2c 00 00       	call   43df3 <console_printf>
        }

        int owner = pageinfo[pn].owner;
   41180:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41183:	48 98                	cltq   
   41185:	0f b6 84 00 40 1e 05 	movzbl 0x51e40(%rax,%rax,1),%eax
   4118c:	00 
   4118d:	0f be c0             	movsbl %al,%eax
   41190:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   41193:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41196:	48 98                	cltq   
   41198:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   4119f:	00 
   411a0:	84 c0                	test   %al,%al
   411a2:	75 07                	jne    411ab <memshow_physical+0x9e>
            owner = PO_FREE;
   411a4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   411ab:	8b 45 f8             	mov    -0x8(%rbp),%eax
   411ae:	83 c0 02             	add    $0x2,%eax
   411b1:	48 98                	cltq   
   411b3:	0f b7 84 00 20 43 04 	movzwl 0x44320(%rax,%rax,1),%eax
   411ba:	00 
   411bb:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   411bf:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411c2:	48 98                	cltq   
   411c4:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   411cb:	00 
   411cc:	3c 01                	cmp    $0x1,%al
   411ce:	7e 1a                	jle    411ea <memshow_physical+0xdd>
   411d0:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   411d5:	48 c1 e8 0c          	shr    $0xc,%rax
   411d9:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   411dc:	74 0c                	je     411ea <memshow_physical+0xdd>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   411de:	b8 53 00 00 00       	mov    $0x53,%eax
   411e3:	80 cc 0f             	or     $0xf,%ah
   411e6:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   411ea:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411ed:	8d 50 3f             	lea    0x3f(%rax),%edx
   411f0:	85 c0                	test   %eax,%eax
   411f2:	0f 48 c2             	cmovs  %edx,%eax
   411f5:	c1 f8 06             	sar    $0x6,%eax
   411f8:	8d 50 01             	lea    0x1(%rax),%edx
   411fb:	89 d0                	mov    %edx,%eax
   411fd:	c1 e0 02             	shl    $0x2,%eax
   41200:	01 d0                	add    %edx,%eax
   41202:	c1 e0 04             	shl    $0x4,%eax
   41205:	89 c1                	mov    %eax,%ecx
   41207:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4120a:	89 d0                	mov    %edx,%eax
   4120c:	c1 f8 1f             	sar    $0x1f,%eax
   4120f:	c1 e8 1a             	shr    $0x1a,%eax
   41212:	01 c2                	add    %eax,%edx
   41214:	83 e2 3f             	and    $0x3f,%edx
   41217:	29 c2                	sub    %eax,%edx
   41219:	89 d0                	mov    %edx,%eax
   4121b:	83 c0 0c             	add    $0xc,%eax
   4121e:	01 c8                	add    %ecx,%eax
   41220:	48 98                	cltq   
   41222:	0f b7 55 f6          	movzwl -0xa(%rbp),%edx
   41226:	66 89 94 00 00 80 0b 	mov    %dx,0xb8000(%rax,%rax,1)
   4122d:	00 
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4122e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41232:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41239:	0f 8e fb fe ff ff    	jle    4113a <memshow_physical+0x2d>
    }
}
   4123f:	90                   	nop
   41240:	90                   	nop
   41241:	c9                   	leave  
   41242:	c3                   	ret    

0000000000041243 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   41243:	55                   	push   %rbp
   41244:	48 89 e5             	mov    %rsp,%rbp
   41247:	48 83 ec 40          	sub    $0x40,%rsp
   4124b:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   4124f:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   41253:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41257:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4125d:	48 89 c2             	mov    %rax,%rdx
   41260:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41264:	48 39 c2             	cmp    %rax,%rdx
   41267:	74 14                	je     4127d <memshow_virtual+0x3a>
   41269:	ba 60 43 04 00       	mov    $0x44360,%edx
   4126e:	be 54 02 00 00       	mov    $0x254,%esi
   41273:	bf c0 3f 04 00       	mov    $0x43fc0,%edi
   41278:	e8 68 12 00 00       	call   424e5 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   4127d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   41281:	48 89 c1             	mov    %rax,%rcx
   41284:	ba 8d 43 04 00       	mov    $0x4438d,%edx
   41289:	be 00 0f 00 00       	mov    $0xf00,%esi
   4128e:	bf 3a 03 00 00       	mov    $0x33a,%edi
   41293:	b8 00 00 00 00       	mov    $0x0,%eax
   41298:	e8 56 2b 00 00       	call   43df3 <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   4129d:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   412a4:	00 
   412a5:	e9 80 01 00 00       	jmp    4142a <memshow_virtual+0x1e7>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   412aa:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   412ae:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   412b2:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   412b6:	48 89 ce             	mov    %rcx,%rsi
   412b9:	48 89 c7             	mov    %rax,%rdi
   412bc:	e8 e9 18 00 00       	call   42baa <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   412c1:	8b 45 d0             	mov    -0x30(%rbp),%eax
   412c4:	85 c0                	test   %eax,%eax
   412c6:	79 0b                	jns    412d3 <memshow_virtual+0x90>
            color = ' ';
   412c8:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   412ce:	e9 d7 00 00 00       	jmp    413aa <memshow_virtual+0x167>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   412d3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   412d7:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   412dd:	76 14                	jbe    412f3 <memshow_virtual+0xb0>
   412df:	ba aa 43 04 00       	mov    $0x443aa,%edx
   412e4:	be 5d 02 00 00       	mov    $0x25d,%esi
   412e9:	bf c0 3f 04 00       	mov    $0x43fc0,%edi
   412ee:	e8 f2 11 00 00       	call   424e5 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   412f3:	8b 45 d0             	mov    -0x30(%rbp),%eax
   412f6:	48 98                	cltq   
   412f8:	0f b6 84 00 40 1e 05 	movzbl 0x51e40(%rax,%rax,1),%eax
   412ff:	00 
   41300:	0f be c0             	movsbl %al,%eax
   41303:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   41306:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41309:	48 98                	cltq   
   4130b:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   41312:	00 
   41313:	84 c0                	test   %al,%al
   41315:	75 07                	jne    4131e <memshow_virtual+0xdb>
                owner = PO_FREE;
   41317:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   4131e:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41321:	83 c0 02             	add    $0x2,%eax
   41324:	48 98                	cltq   
   41326:	0f b7 84 00 20 43 04 	movzwl 0x44320(%rax,%rax,1),%eax
   4132d:	00 
   4132e:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   41332:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41335:	48 98                	cltq   
   41337:	83 e0 04             	and    $0x4,%eax
   4133a:	48 85 c0             	test   %rax,%rax
   4133d:	74 27                	je     41366 <memshow_virtual+0x123>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   4133f:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41343:	c1 e0 04             	shl    $0x4,%eax
   41346:	66 25 00 f0          	and    $0xf000,%ax
   4134a:	89 c2                	mov    %eax,%edx
   4134c:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41350:	c1 f8 04             	sar    $0x4,%eax
   41353:	66 25 00 0f          	and    $0xf00,%ax
   41357:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   41359:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4135d:	0f b6 c0             	movzbl %al,%eax
   41360:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41362:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   41366:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41369:	48 98                	cltq   
   4136b:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   41372:	00 
   41373:	3c 01                	cmp    $0x1,%al
   41375:	7e 33                	jle    413aa <memshow_virtual+0x167>
   41377:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   4137c:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41380:	74 28                	je     413aa <memshow_virtual+0x167>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   41382:	b8 53 00 00 00       	mov    $0x53,%eax
   41387:	89 c2                	mov    %eax,%edx
   41389:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4138d:	66 25 00 f0          	and    $0xf000,%ax
   41391:	09 d0                	or     %edx,%eax
   41393:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   41397:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4139a:	48 98                	cltq   
   4139c:	83 e0 04             	and    $0x4,%eax
   4139f:	48 85 c0             	test   %rax,%rax
   413a2:	75 06                	jne    413aa <memshow_virtual+0x167>
                    color = color | 0x0F00;
   413a4:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   413aa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   413ae:	48 c1 e8 0c          	shr    $0xc,%rax
   413b2:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   413b5:	8b 45 ec             	mov    -0x14(%rbp),%eax
   413b8:	83 e0 3f             	and    $0x3f,%eax
   413bb:	85 c0                	test   %eax,%eax
   413bd:	75 34                	jne    413f3 <memshow_virtual+0x1b0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   413bf:	8b 45 ec             	mov    -0x14(%rbp),%eax
   413c2:	c1 e8 06             	shr    $0x6,%eax
   413c5:	89 c2                	mov    %eax,%edx
   413c7:	89 d0                	mov    %edx,%eax
   413c9:	c1 e0 02             	shl    $0x2,%eax
   413cc:	01 d0                	add    %edx,%eax
   413ce:	c1 e0 04             	shl    $0x4,%eax
   413d1:	05 73 03 00 00       	add    $0x373,%eax
   413d6:	89 c7                	mov    %eax,%edi
   413d8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   413dc:	48 89 c1             	mov    %rax,%rcx
   413df:	ba 56 43 04 00       	mov    $0x44356,%edx
   413e4:	be 00 0f 00 00       	mov    $0xf00,%esi
   413e9:	b8 00 00 00 00       	mov    $0x0,%eax
   413ee:	e8 00 2a 00 00       	call   43df3 <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   413f3:	8b 45 ec             	mov    -0x14(%rbp),%eax
   413f6:	c1 e8 06             	shr    $0x6,%eax
   413f9:	89 c2                	mov    %eax,%edx
   413fb:	89 d0                	mov    %edx,%eax
   413fd:	c1 e0 02             	shl    $0x2,%eax
   41400:	01 d0                	add    %edx,%eax
   41402:	c1 e0 04             	shl    $0x4,%eax
   41405:	89 c2                	mov    %eax,%edx
   41407:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4140a:	83 e0 3f             	and    $0x3f,%eax
   4140d:	01 d0                	add    %edx,%eax
   4140f:	05 7c 03 00 00       	add    $0x37c,%eax
   41414:	89 c2                	mov    %eax,%edx
   41416:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4141a:	66 89 84 12 00 80 0b 	mov    %ax,0xb8000(%rdx,%rdx,1)
   41421:	00 
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41422:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41429:	00 
   4142a:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   41431:	00 
   41432:	0f 86 72 fe ff ff    	jbe    412aa <memshow_virtual+0x67>
    }
}
   41438:	90                   	nop
   41439:	90                   	nop
   4143a:	c9                   	leave  
   4143b:	c3                   	ret    

000000000004143c <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   4143c:	55                   	push   %rbp
   4143d:	48 89 e5             	mov    %rsp,%rbp
   41440:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   41444:	8b 05 f6 0d 01 00    	mov    0x10df6(%rip),%eax        # 52240 <last_ticks.1>
   4144a:	85 c0                	test   %eax,%eax
   4144c:	74 13                	je     41461 <memshow_virtual_animate+0x25>
   4144e:	8b 15 cc 09 01 00    	mov    0x109cc(%rip),%edx        # 51e20 <ticks>
   41454:	8b 05 e6 0d 01 00    	mov    0x10de6(%rip),%eax        # 52240 <last_ticks.1>
   4145a:	29 c2                	sub    %eax,%edx
   4145c:	83 fa 31             	cmp    $0x31,%edx
   4145f:	76 2c                	jbe    4148d <memshow_virtual_animate+0x51>
        last_ticks = ticks;
   41461:	8b 05 b9 09 01 00    	mov    0x109b9(%rip),%eax        # 51e20 <ticks>
   41467:	89 05 d3 0d 01 00    	mov    %eax,0x10dd3(%rip)        # 52240 <last_ticks.1>
        ++showing;
   4146d:	8b 05 91 3b 00 00    	mov    0x3b91(%rip),%eax        # 45004 <showing.0>
   41473:	83 c0 01             	add    $0x1,%eax
   41476:	89 05 88 3b 00 00    	mov    %eax,0x3b88(%rip)        # 45004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   4147c:	eb 0f                	jmp    4148d <memshow_virtual_animate+0x51>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
        ++showing;
   4147e:	8b 05 80 3b 00 00    	mov    0x3b80(%rip),%eax        # 45004 <showing.0>
   41484:	83 c0 01             	add    $0x1,%eax
   41487:	89 05 77 3b 00 00    	mov    %eax,0x3b77(%rip)        # 45004 <showing.0>
    while (showing <= 2*NPROC
   4148d:	8b 05 71 3b 00 00    	mov    0x3b71(%rip),%eax        # 45004 <showing.0>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
   41493:	83 f8 20             	cmp    $0x20,%eax
   41496:	7f 6d                	jg     41505 <memshow_virtual_animate+0xc9>
   41498:	8b 15 66 3b 00 00    	mov    0x3b66(%rip),%edx        # 45004 <showing.0>
   4149e:	89 d0                	mov    %edx,%eax
   414a0:	c1 f8 1f             	sar    $0x1f,%eax
   414a3:	c1 e8 1c             	shr    $0x1c,%eax
   414a6:	01 c2                	add    %eax,%edx
   414a8:	83 e2 0f             	and    $0xf,%edx
   414ab:	29 c2                	sub    %eax,%edx
   414ad:	89 d0                	mov    %edx,%eax
   414af:	48 63 d0             	movslq %eax,%rdx
   414b2:	48 89 d0             	mov    %rdx,%rax
   414b5:	48 c1 e0 03          	shl    $0x3,%rax
   414b9:	48 29 d0             	sub    %rdx,%rax
   414bc:	48 c1 e0 05          	shl    $0x5,%rax
   414c0:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   414c6:	8b 00                	mov    (%rax),%eax
   414c8:	85 c0                	test   %eax,%eax
   414ca:	74 b2                	je     4147e <memshow_virtual_animate+0x42>
   414cc:	8b 15 32 3b 00 00    	mov    0x3b32(%rip),%edx        # 45004 <showing.0>
   414d2:	89 d0                	mov    %edx,%eax
   414d4:	c1 f8 1f             	sar    $0x1f,%eax
   414d7:	c1 e8 1c             	shr    $0x1c,%eax
   414da:	01 c2                	add    %eax,%edx
   414dc:	83 e2 0f             	and    $0xf,%edx
   414df:	29 c2                	sub    %eax,%edx
   414e1:	89 d0                	mov    %edx,%eax
   414e3:	48 63 d0             	movslq %eax,%rdx
   414e6:	48 89 d0             	mov    %rdx,%rax
   414e9:	48 c1 e0 03          	shl    $0x3,%rax
   414ed:	48 29 d0             	sub    %rdx,%rax
   414f0:	48 c1 e0 05          	shl    $0x5,%rax
   414f4:	48 05 f8 10 05 00    	add    $0x510f8,%rax
   414fa:	0f b6 00             	movzbl (%rax),%eax
   414fd:	84 c0                	test   %al,%al
   414ff:	0f 84 79 ff ff ff    	je     4147e <memshow_virtual_animate+0x42>
    }
    showing = showing % NPROC;
   41505:	8b 15 f9 3a 00 00    	mov    0x3af9(%rip),%edx        # 45004 <showing.0>
   4150b:	89 d0                	mov    %edx,%eax
   4150d:	c1 f8 1f             	sar    $0x1f,%eax
   41510:	c1 e8 1c             	shr    $0x1c,%eax
   41513:	01 c2                	add    %eax,%edx
   41515:	83 e2 0f             	and    $0xf,%edx
   41518:	29 c2                	sub    %eax,%edx
   4151a:	89 d0                	mov    %edx,%eax
   4151c:	89 05 e2 3a 00 00    	mov    %eax,0x3ae2(%rip)        # 45004 <showing.0>

    if (processes[showing].p_state != P_FREE) {
   41522:	8b 05 dc 3a 00 00    	mov    0x3adc(%rip),%eax        # 45004 <showing.0>
   41528:	48 63 d0             	movslq %eax,%rdx
   4152b:	48 89 d0             	mov    %rdx,%rax
   4152e:	48 c1 e0 03          	shl    $0x3,%rax
   41532:	48 29 d0             	sub    %rdx,%rax
   41535:	48 c1 e0 05          	shl    $0x5,%rax
   41539:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   4153f:	8b 00                	mov    (%rax),%eax
   41541:	85 c0                	test   %eax,%eax
   41543:	74 52                	je     41597 <memshow_virtual_animate+0x15b>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   41545:	8b 15 b9 3a 00 00    	mov    0x3ab9(%rip),%edx        # 45004 <showing.0>
   4154b:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   4154f:	89 d1                	mov    %edx,%ecx
   41551:	ba c4 43 04 00       	mov    $0x443c4,%edx
   41556:	be 04 00 00 00       	mov    $0x4,%esi
   4155b:	48 89 c7             	mov    %rax,%rdi
   4155e:	b8 00 00 00 00       	mov    $0x0,%eax
   41563:	e8 97 29 00 00       	call   43eff <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   41568:	8b 05 96 3a 00 00    	mov    0x3a96(%rip),%eax        # 45004 <showing.0>
   4156e:	48 63 d0             	movslq %eax,%rdx
   41571:	48 89 d0             	mov    %rdx,%rax
   41574:	48 c1 e0 03          	shl    $0x3,%rax
   41578:	48 29 d0             	sub    %rdx,%rax
   4157b:	48 c1 e0 05          	shl    $0x5,%rax
   4157f:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   41585:	48 8b 00             	mov    (%rax),%rax
   41588:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   4158c:	48 89 d6             	mov    %rdx,%rsi
   4158f:	48 89 c7             	mov    %rax,%rdi
   41592:	e8 ac fc ff ff       	call   41243 <memshow_virtual>
    }
}
   41597:	90                   	nop
   41598:	c9                   	leave  
   41599:	c3                   	ret    

000000000004159a <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   4159a:	55                   	push   %rbp
   4159b:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   4159e:	e8 4f 01 00 00       	call   416f2 <segments_init>
    interrupt_init();
   415a3:	e8 d0 03 00 00       	call   41978 <interrupt_init>
    virtual_memory_init();
   415a8:	e8 f3 0f 00 00       	call   425a0 <virtual_memory_init>
}
   415ad:	90                   	nop
   415ae:	5d                   	pop    %rbp
   415af:	c3                   	ret    

00000000000415b0 <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   415b0:	55                   	push   %rbp
   415b1:	48 89 e5             	mov    %rsp,%rbp
   415b4:	48 83 ec 18          	sub    $0x18,%rsp
   415b8:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   415bc:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   415c0:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   415c3:	8b 45 ec             	mov    -0x14(%rbp),%eax
   415c6:	48 98                	cltq   
   415c8:	48 c1 e0 2d          	shl    $0x2d,%rax
   415cc:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   415d0:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   415d7:	90 00 00 
   415da:	48 09 c2             	or     %rax,%rdx
    *segment = type
   415dd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   415e1:	48 89 10             	mov    %rdx,(%rax)
}
   415e4:	90                   	nop
   415e5:	c9                   	leave  
   415e6:	c3                   	ret    

00000000000415e7 <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   415e7:	55                   	push   %rbp
   415e8:	48 89 e5             	mov    %rsp,%rbp
   415eb:	48 83 ec 28          	sub    $0x28,%rsp
   415ef:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   415f3:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   415f7:	89 55 ec             	mov    %edx,-0x14(%rbp)
   415fa:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   415fe:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41602:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41606:	48 c1 e0 10          	shl    $0x10,%rax
   4160a:	48 89 c2             	mov    %rax,%rdx
   4160d:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   41614:	00 00 00 
   41617:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   4161a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4161e:	48 c1 e0 20          	shl    $0x20,%rax
   41622:	48 89 c1             	mov    %rax,%rcx
   41625:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   4162c:	00 00 ff 
   4162f:	48 21 c8             	and    %rcx,%rax
   41632:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   41635:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41639:	48 83 e8 01          	sub    $0x1,%rax
   4163d:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   41640:	48 09 d0             	or     %rdx,%rax
        | type
   41643:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   41647:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4164a:	48 63 d2             	movslq %edx,%rdx
   4164d:	48 c1 e2 2d          	shl    $0x2d,%rdx
   41651:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   41654:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   4165b:	80 00 00 
   4165e:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41661:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41665:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   41668:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4166c:	48 83 c0 08          	add    $0x8,%rax
   41670:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   41674:	48 c1 ea 20          	shr    $0x20,%rdx
   41678:	48 89 10             	mov    %rdx,(%rax)
}
   4167b:	90                   	nop
   4167c:	c9                   	leave  
   4167d:	c3                   	ret    

000000000004167e <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   4167e:	55                   	push   %rbp
   4167f:	48 89 e5             	mov    %rsp,%rbp
   41682:	48 83 ec 20          	sub    $0x20,%rsp
   41686:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4168a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   4168e:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41691:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41695:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41699:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   4169c:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   416a0:	8b 55 ec             	mov    -0x14(%rbp),%edx
   416a3:	48 63 d2             	movslq %edx,%rdx
   416a6:	48 c1 e2 2d          	shl    $0x2d,%rdx
   416aa:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   416ad:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   416b1:	48 c1 e0 20          	shl    $0x20,%rax
   416b5:	48 89 c1             	mov    %rax,%rcx
   416b8:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   416bf:	00 ff ff 
   416c2:	48 21 c8             	and    %rcx,%rax
   416c5:	48 09 c2             	or     %rax,%rdx
   416c8:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   416cf:	80 00 00 
   416d2:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   416d5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   416d9:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   416dc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   416e0:	48 c1 e8 20          	shr    $0x20,%rax
   416e4:	48 89 c2             	mov    %rax,%rdx
   416e7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   416eb:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   416ef:	90                   	nop
   416f0:	c9                   	leave  
   416f1:	c3                   	ret    

00000000000416f2 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   416f2:	55                   	push   %rbp
   416f3:	48 89 e5             	mov    %rsp,%rbp
   416f6:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   416fa:	48 c7 05 5b 0b 01 00 	movq   $0x0,0x10b5b(%rip)        # 52260 <segments>
   41701:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   41705:	ba 00 00 00 00       	mov    $0x0,%edx
   4170a:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41711:	08 20 00 
   41714:	48 89 c6             	mov    %rax,%rsi
   41717:	bf 68 22 05 00       	mov    $0x52268,%edi
   4171c:	e8 8f fe ff ff       	call   415b0 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   41721:	ba 03 00 00 00       	mov    $0x3,%edx
   41726:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   4172d:	08 20 00 
   41730:	48 89 c6             	mov    %rax,%rsi
   41733:	bf 70 22 05 00       	mov    $0x52270,%edi
   41738:	e8 73 fe ff ff       	call   415b0 <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   4173d:	ba 00 00 00 00       	mov    $0x0,%edx
   41742:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41749:	02 00 00 
   4174c:	48 89 c6             	mov    %rax,%rsi
   4174f:	bf 78 22 05 00       	mov    $0x52278,%edi
   41754:	e8 57 fe ff ff       	call   415b0 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   41759:	ba 03 00 00 00       	mov    $0x3,%edx
   4175e:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41765:	02 00 00 
   41768:	48 89 c6             	mov    %rax,%rsi
   4176b:	bf 80 22 05 00       	mov    $0x52280,%edi
   41770:	e8 3b fe ff ff       	call   415b0 <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   41775:	b8 a0 32 05 00       	mov    $0x532a0,%eax
   4177a:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   41780:	48 89 c1             	mov    %rax,%rcx
   41783:	ba 00 00 00 00       	mov    $0x0,%edx
   41788:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   4178f:	09 00 00 
   41792:	48 89 c6             	mov    %rax,%rsi
   41795:	bf 88 22 05 00       	mov    $0x52288,%edi
   4179a:	e8 48 fe ff ff       	call   415e7 <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   4179f:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   417a5:	b8 60 22 05 00       	mov    $0x52260,%eax
   417aa:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   417ae:	ba 60 00 00 00       	mov    $0x60,%edx
   417b3:	be 00 00 00 00       	mov    $0x0,%esi
   417b8:	bf a0 32 05 00       	mov    $0x532a0,%edi
   417bd:	e8 7a 18 00 00       	call   4303c <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   417c2:	48 c7 05 d7 1a 01 00 	movq   $0x80000,0x11ad7(%rip)        # 532a4 <kernel_task_descriptor+0x4>
   417c9:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   417cd:	ba 00 10 00 00       	mov    $0x1000,%edx
   417d2:	be 00 00 00 00       	mov    $0x0,%esi
   417d7:	bf a0 22 05 00       	mov    $0x522a0,%edi
   417dc:	e8 5b 18 00 00       	call   4303c <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   417e1:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   417e8:	eb 30                	jmp    4181a <segments_init+0x128>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   417ea:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   417ef:	8b 45 fc             	mov    -0x4(%rbp),%eax
   417f2:	48 c1 e0 04          	shl    $0x4,%rax
   417f6:	48 05 a0 22 05 00    	add    $0x522a0,%rax
   417fc:	48 89 d1             	mov    %rdx,%rcx
   417ff:	ba 00 00 00 00       	mov    $0x0,%edx
   41804:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   4180b:	0e 00 00 
   4180e:	48 89 c7             	mov    %rax,%rdi
   41811:	e8 68 fe ff ff       	call   4167e <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41816:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4181a:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   41821:	76 c7                	jbe    417ea <segments_init+0xf8>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   41823:	b8 36 00 04 00       	mov    $0x40036,%eax
   41828:	48 89 c1             	mov    %rax,%rcx
   4182b:	ba 00 00 00 00       	mov    $0x0,%edx
   41830:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41837:	0e 00 00 
   4183a:	48 89 c6             	mov    %rax,%rsi
   4183d:	bf a0 24 05 00       	mov    $0x524a0,%edi
   41842:	e8 37 fe ff ff       	call   4167e <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   41847:	b8 2e 00 04 00       	mov    $0x4002e,%eax
   4184c:	48 89 c1             	mov    %rax,%rcx
   4184f:	ba 00 00 00 00       	mov    $0x0,%edx
   41854:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   4185b:	0e 00 00 
   4185e:	48 89 c6             	mov    %rax,%rsi
   41861:	bf 70 23 05 00       	mov    $0x52370,%edi
   41866:	e8 13 fe ff ff       	call   4167e <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   4186b:	b8 32 00 04 00       	mov    $0x40032,%eax
   41870:	48 89 c1             	mov    %rax,%rcx
   41873:	ba 00 00 00 00       	mov    $0x0,%edx
   41878:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   4187f:	0e 00 00 
   41882:	48 89 c6             	mov    %rax,%rsi
   41885:	bf 80 23 05 00       	mov    $0x52380,%edi
   4188a:	e8 ef fd ff ff       	call   4167e <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   4188f:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   41896:	eb 3e                	jmp    418d6 <segments_init+0x1e4>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   41898:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4189b:	83 e8 30             	sub    $0x30,%eax
   4189e:	89 c0                	mov    %eax,%eax
   418a0:	48 8b 04 c5 e7 00 04 	mov    0x400e7(,%rax,8),%rax
   418a7:	00 
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   418a8:	48 89 c2             	mov    %rax,%rdx
   418ab:	8b 45 f8             	mov    -0x8(%rbp),%eax
   418ae:	48 c1 e0 04          	shl    $0x4,%rax
   418b2:	48 05 a0 22 05 00    	add    $0x522a0,%rax
   418b8:	48 89 d1             	mov    %rdx,%rcx
   418bb:	ba 03 00 00 00       	mov    $0x3,%edx
   418c0:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   418c7:	0e 00 00 
   418ca:	48 89 c7             	mov    %rax,%rdi
   418cd:	e8 ac fd ff ff       	call   4167e <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   418d2:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   418d6:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   418da:	76 bc                	jbe    41898 <segments_init+0x1a6>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   418dc:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   418e2:	b8 a0 22 05 00       	mov    $0x522a0,%eax
   418e7:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   418eb:	b8 28 00 00 00       	mov    $0x28,%eax
   418f0:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   418f4:	0f 00 d8             	ltr    %ax
   418f7:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   418fb:	0f 20 c0             	mov    %cr0,%rax
   418fe:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   41902:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   41906:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   41909:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   41910:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41913:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   41916:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41919:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   4191d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41921:	0f 22 c0             	mov    %rax,%cr0
}
   41924:	90                   	nop
    lcr0(cr0);
}
   41925:	90                   	nop
   41926:	c9                   	leave  
   41927:	c3                   	ret    

0000000000041928 <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   41928:	55                   	push   %rbp
   41929:	48 89 e5             	mov    %rsp,%rbp
   4192c:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   41930:	0f b7 05 c9 19 01 00 	movzwl 0x119c9(%rip),%eax        # 53300 <interrupts_enabled>
   41937:	f7 d0                	not    %eax
   41939:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   4193d:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41941:	0f b6 c0             	movzbl %al,%eax
   41944:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   4194b:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4194e:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   41952:	8b 55 f0             	mov    -0x10(%rbp),%edx
   41955:	ee                   	out    %al,(%dx)
}
   41956:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   41957:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   4195b:	66 c1 e8 08          	shr    $0x8,%ax
   4195f:	0f b6 c0             	movzbl %al,%eax
   41962:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   41969:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4196c:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   41970:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41973:	ee                   	out    %al,(%dx)
}
   41974:	90                   	nop
}
   41975:	90                   	nop
   41976:	c9                   	leave  
   41977:	c3                   	ret    

0000000000041978 <interrupt_init>:

void interrupt_init(void) {
   41978:	55                   	push   %rbp
   41979:	48 89 e5             	mov    %rsp,%rbp
   4197c:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   41980:	66 c7 05 77 19 01 00 	movw   $0x0,0x11977(%rip)        # 53300 <interrupts_enabled>
   41987:	00 00 
    interrupt_mask();
   41989:	e8 9a ff ff ff       	call   41928 <interrupt_mask>
   4198e:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   41995:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41999:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   4199d:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   419a0:	ee                   	out    %al,(%dx)
}
   419a1:	90                   	nop
   419a2:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   419a9:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   419ad:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   419b1:	8b 55 ac             	mov    -0x54(%rbp),%edx
   419b4:	ee                   	out    %al,(%dx)
}
   419b5:	90                   	nop
   419b6:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   419bd:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   419c1:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   419c5:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   419c8:	ee                   	out    %al,(%dx)
}
   419c9:	90                   	nop
   419ca:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   419d1:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   419d5:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   419d9:	8b 55 bc             	mov    -0x44(%rbp),%edx
   419dc:	ee                   	out    %al,(%dx)
}
   419dd:	90                   	nop
   419de:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   419e5:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   419e9:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   419ed:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   419f0:	ee                   	out    %al,(%dx)
}
   419f1:	90                   	nop
   419f2:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   419f9:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   419fd:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   41a01:	8b 55 cc             	mov    -0x34(%rbp),%edx
   41a04:	ee                   	out    %al,(%dx)
}
   41a05:	90                   	nop
   41a06:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   41a0d:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a11:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   41a15:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   41a18:	ee                   	out    %al,(%dx)
}
   41a19:	90                   	nop
   41a1a:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   41a21:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a25:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   41a29:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41a2c:	ee                   	out    %al,(%dx)
}
   41a2d:	90                   	nop
   41a2e:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   41a35:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a39:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41a3d:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41a40:	ee                   	out    %al,(%dx)
}
   41a41:	90                   	nop
   41a42:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   41a49:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a4d:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41a51:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41a54:	ee                   	out    %al,(%dx)
}
   41a55:	90                   	nop
   41a56:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   41a5d:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a61:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41a65:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41a68:	ee                   	out    %al,(%dx)
}
   41a69:	90                   	nop
   41a6a:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   41a71:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a75:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41a79:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41a7c:	ee                   	out    %al,(%dx)
}
   41a7d:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   41a7e:	e8 a5 fe ff ff       	call   41928 <interrupt_mask>
}
   41a83:	90                   	nop
   41a84:	c9                   	leave  
   41a85:	c3                   	ret    

0000000000041a86 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   41a86:	55                   	push   %rbp
   41a87:	48 89 e5             	mov    %rsp,%rbp
   41a8a:	48 83 ec 28          	sub    $0x28,%rsp
   41a8e:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   41a91:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41a95:	0f 8e 9e 00 00 00    	jle    41b39 <timer_init+0xb3>
   41a9b:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   41aa2:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41aa6:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41aaa:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41aad:	ee                   	out    %al,(%dx)
}
   41aae:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   41aaf:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41ab2:	89 c2                	mov    %eax,%edx
   41ab4:	c1 ea 1f             	shr    $0x1f,%edx
   41ab7:	01 d0                	add    %edx,%eax
   41ab9:	d1 f8                	sar    %eax
   41abb:	05 de 34 12 00       	add    $0x1234de,%eax
   41ac0:	99                   	cltd   
   41ac1:	f7 7d dc             	idivl  -0x24(%rbp)
   41ac4:	89 c2                	mov    %eax,%edx
   41ac6:	89 d0                	mov    %edx,%eax
   41ac8:	c1 f8 1f             	sar    $0x1f,%eax
   41acb:	c1 e8 18             	shr    $0x18,%eax
   41ace:	01 c2                	add    %eax,%edx
   41ad0:	0f b6 d2             	movzbl %dl,%edx
   41ad3:	29 c2                	sub    %eax,%edx
   41ad5:	89 d0                	mov    %edx,%eax
   41ad7:	0f b6 c0             	movzbl %al,%eax
   41ada:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   41ae1:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ae4:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41ae8:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41aeb:	ee                   	out    %al,(%dx)
}
   41aec:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   41aed:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41af0:	89 c2                	mov    %eax,%edx
   41af2:	c1 ea 1f             	shr    $0x1f,%edx
   41af5:	01 d0                	add    %edx,%eax
   41af7:	d1 f8                	sar    %eax
   41af9:	05 de 34 12 00       	add    $0x1234de,%eax
   41afe:	99                   	cltd   
   41aff:	f7 7d dc             	idivl  -0x24(%rbp)
   41b02:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41b08:	85 c0                	test   %eax,%eax
   41b0a:	0f 48 c2             	cmovs  %edx,%eax
   41b0d:	c1 f8 08             	sar    $0x8,%eax
   41b10:	0f b6 c0             	movzbl %al,%eax
   41b13:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   41b1a:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b1d:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41b21:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41b24:	ee                   	out    %al,(%dx)
}
   41b25:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   41b26:	0f b7 05 d3 17 01 00 	movzwl 0x117d3(%rip),%eax        # 53300 <interrupts_enabled>
   41b2d:	83 c8 01             	or     $0x1,%eax
   41b30:	66 89 05 c9 17 01 00 	mov    %ax,0x117c9(%rip)        # 53300 <interrupts_enabled>
   41b37:	eb 11                	jmp    41b4a <timer_init+0xc4>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   41b39:	0f b7 05 c0 17 01 00 	movzwl 0x117c0(%rip),%eax        # 53300 <interrupts_enabled>
   41b40:	83 e0 fe             	and    $0xfffffffe,%eax
   41b43:	66 89 05 b6 17 01 00 	mov    %ax,0x117b6(%rip)        # 53300 <interrupts_enabled>
    }
    interrupt_mask();
   41b4a:	e8 d9 fd ff ff       	call   41928 <interrupt_mask>
}
   41b4f:	90                   	nop
   41b50:	c9                   	leave  
   41b51:	c3                   	ret    

0000000000041b52 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   41b52:	55                   	push   %rbp
   41b53:	48 89 e5             	mov    %rsp,%rbp
   41b56:	48 83 ec 08          	sub    $0x8,%rsp
   41b5a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   41b5e:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   41b63:	74 14                	je     41b79 <physical_memory_isreserved+0x27>
   41b65:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   41b6c:	00 
   41b6d:	76 11                	jbe    41b80 <physical_memory_isreserved+0x2e>
   41b6f:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   41b76:	00 
   41b77:	77 07                	ja     41b80 <physical_memory_isreserved+0x2e>
   41b79:	b8 01 00 00 00       	mov    $0x1,%eax
   41b7e:	eb 05                	jmp    41b85 <physical_memory_isreserved+0x33>
   41b80:	b8 00 00 00 00       	mov    $0x0,%eax
}
   41b85:	c9                   	leave  
   41b86:	c3                   	ret    

0000000000041b87 <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   41b87:	55                   	push   %rbp
   41b88:	48 89 e5             	mov    %rsp,%rbp
   41b8b:	48 83 ec 10          	sub    $0x10,%rsp
   41b8f:	89 7d fc             	mov    %edi,-0x4(%rbp)
   41b92:	89 75 f8             	mov    %esi,-0x8(%rbp)
   41b95:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   41b98:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41b9b:	c1 e0 10             	shl    $0x10,%eax
   41b9e:	89 c2                	mov    %eax,%edx
   41ba0:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41ba3:	c1 e0 0b             	shl    $0xb,%eax
   41ba6:	09 c2                	or     %eax,%edx
   41ba8:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41bab:	c1 e0 08             	shl    $0x8,%eax
   41bae:	09 d0                	or     %edx,%eax
}
   41bb0:	c9                   	leave  
   41bb1:	c3                   	ret    

0000000000041bb2 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   41bb2:	55                   	push   %rbp
   41bb3:	48 89 e5             	mov    %rsp,%rbp
   41bb6:	48 83 ec 18          	sub    $0x18,%rsp
   41bba:	89 7d ec             	mov    %edi,-0x14(%rbp)
   41bbd:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   41bc0:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41bc3:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41bc6:	09 d0                	or     %edx,%eax
   41bc8:	0d 00 00 00 80       	or     $0x80000000,%eax
   41bcd:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   41bd4:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   41bd7:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41bda:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41bdd:	ef                   	out    %eax,(%dx)
}
   41bde:	90                   	nop
   41bdf:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   41be6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41be9:	89 c2                	mov    %eax,%edx
   41beb:	ed                   	in     (%dx),%eax
   41bec:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   41bef:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   41bf2:	c9                   	leave  
   41bf3:	c3                   	ret    

0000000000041bf4 <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   41bf4:	55                   	push   %rbp
   41bf5:	48 89 e5             	mov    %rsp,%rbp
   41bf8:	48 83 ec 28          	sub    $0x28,%rsp
   41bfc:	89 7d dc             	mov    %edi,-0x24(%rbp)
   41bff:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   41c02:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41c09:	eb 73                	jmp    41c7e <pci_find_device+0x8a>
        for (int slot = 0; slot != 32; ++slot) {
   41c0b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41c12:	eb 60                	jmp    41c74 <pci_find_device+0x80>
            for (int func = 0; func != 8; ++func) {
   41c14:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41c1b:	eb 4a                	jmp    41c67 <pci_find_device+0x73>
                int configaddr = pci_make_configaddr(bus, slot, func);
   41c1d:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41c20:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41c23:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41c26:	89 ce                	mov    %ecx,%esi
   41c28:	89 c7                	mov    %eax,%edi
   41c2a:	e8 58 ff ff ff       	call   41b87 <pci_make_configaddr>
   41c2f:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   41c32:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41c35:	be 00 00 00 00       	mov    $0x0,%esi
   41c3a:	89 c7                	mov    %eax,%edi
   41c3c:	e8 71 ff ff ff       	call   41bb2 <pci_config_readl>
   41c41:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   41c44:	8b 45 d8             	mov    -0x28(%rbp),%eax
   41c47:	c1 e0 10             	shl    $0x10,%eax
   41c4a:	0b 45 dc             	or     -0x24(%rbp),%eax
   41c4d:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   41c50:	75 05                	jne    41c57 <pci_find_device+0x63>
                    return configaddr;
   41c52:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41c55:	eb 35                	jmp    41c8c <pci_find_device+0x98>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   41c57:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   41c5b:	75 06                	jne    41c63 <pci_find_device+0x6f>
   41c5d:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41c61:	74 0c                	je     41c6f <pci_find_device+0x7b>
            for (int func = 0; func != 8; ++func) {
   41c63:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41c67:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   41c6b:	75 b0                	jne    41c1d <pci_find_device+0x29>
   41c6d:	eb 01                	jmp    41c70 <pci_find_device+0x7c>
                    break;
   41c6f:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   41c70:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41c74:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   41c78:	75 9a                	jne    41c14 <pci_find_device+0x20>
    for (int bus = 0; bus != 256; ++bus) {
   41c7a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41c7e:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   41c85:	75 84                	jne    41c0b <pci_find_device+0x17>
                }
            }
        }
    }
    return -1;
   41c87:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   41c8c:	c9                   	leave  
   41c8d:	c3                   	ret    

0000000000041c8e <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   41c8e:	55                   	push   %rbp
   41c8f:	48 89 e5             	mov    %rsp,%rbp
   41c92:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   41c96:	be 13 71 00 00       	mov    $0x7113,%esi
   41c9b:	bf 86 80 00 00       	mov    $0x8086,%edi
   41ca0:	e8 4f ff ff ff       	call   41bf4 <pci_find_device>
   41ca5:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   41ca8:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   41cac:	78 30                	js     41cde <poweroff+0x50>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   41cae:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41cb1:	be 40 00 00 00       	mov    $0x40,%esi
   41cb6:	89 c7                	mov    %eax,%edi
   41cb8:	e8 f5 fe ff ff       	call   41bb2 <pci_config_readl>
   41cbd:	25 c0 ff 00 00       	and    $0xffc0,%eax
   41cc2:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   41cc5:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41cc8:	83 c0 04             	add    $0x4,%eax
   41ccb:	89 45 f4             	mov    %eax,-0xc(%rbp)
   41cce:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   41cd4:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   41cd8:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41cdb:	66 ef                	out    %ax,(%dx)
}
   41cdd:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   41cde:	ba e0 43 04 00       	mov    $0x443e0,%edx
   41ce3:	be 00 c0 00 00       	mov    $0xc000,%esi
   41ce8:	bf 80 07 00 00       	mov    $0x780,%edi
   41ced:	b8 00 00 00 00       	mov    $0x0,%eax
   41cf2:	e8 fc 20 00 00       	call   43df3 <console_printf>
 spinloop: goto spinloop;
   41cf7:	eb fe                	jmp    41cf7 <poweroff+0x69>

0000000000041cf9 <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   41cf9:	55                   	push   %rbp
   41cfa:	48 89 e5             	mov    %rsp,%rbp
   41cfd:	48 83 ec 10          	sub    $0x10,%rsp
   41d01:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   41d08:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d0c:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41d10:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41d13:	ee                   	out    %al,(%dx)
}
   41d14:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   41d15:	eb fe                	jmp    41d15 <reboot+0x1c>

0000000000041d17 <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   41d17:	55                   	push   %rbp
   41d18:	48 89 e5             	mov    %rsp,%rbp
   41d1b:	48 83 ec 10          	sub    $0x10,%rsp
   41d1f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41d23:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   41d26:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d2a:	48 83 c0 08          	add    $0x8,%rax
   41d2e:	ba c0 00 00 00       	mov    $0xc0,%edx
   41d33:	be 00 00 00 00       	mov    $0x0,%esi
   41d38:	48 89 c7             	mov    %rax,%rdi
   41d3b:	e8 fc 12 00 00       	call   4303c <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   41d40:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d44:	66 c7 80 a8 00 00 00 	movw   $0x13,0xa8(%rax)
   41d4b:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   41d4d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d51:	48 c7 80 80 00 00 00 	movq   $0x23,0x80(%rax)
   41d58:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   41d5c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d60:	48 c7 80 88 00 00 00 	movq   $0x23,0x88(%rax)
   41d67:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   41d6b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d6f:	66 c7 80 c0 00 00 00 	movw   $0x23,0xc0(%rax)
   41d76:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   41d78:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d7c:	48 c7 80 b0 00 00 00 	movq   $0x200,0xb0(%rax)
   41d83:	00 02 00 00 
    p->display_status = 1;
   41d87:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d8b:	c6 80 d8 00 00 00 01 	movb   $0x1,0xd8(%rax)

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   41d92:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41d95:	83 e0 01             	and    $0x1,%eax
   41d98:	85 c0                	test   %eax,%eax
   41d9a:	74 1c                	je     41db8 <process_init+0xa1>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   41d9c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41da0:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   41da7:	80 cc 30             	or     $0x30,%ah
   41daa:	48 89 c2             	mov    %rax,%rdx
   41dad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41db1:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   41db8:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41dbb:	83 e0 02             	and    $0x2,%eax
   41dbe:	85 c0                	test   %eax,%eax
   41dc0:	74 1c                	je     41dde <process_init+0xc7>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   41dc2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41dc6:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   41dcd:	80 e4 fd             	and    $0xfd,%ah
   41dd0:	48 89 c2             	mov    %rax,%rdx
   41dd3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41dd7:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
}
   41dde:	90                   	nop
   41ddf:	c9                   	leave  
   41de0:	c3                   	ret    

0000000000041de1 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   41de1:	55                   	push   %rbp
   41de2:	48 89 e5             	mov    %rsp,%rbp
   41de5:	48 83 ec 28          	sub    $0x28,%rsp
   41de9:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   41dec:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41df0:	78 09                	js     41dfb <console_show_cursor+0x1a>
   41df2:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   41df9:	7e 07                	jle    41e02 <console_show_cursor+0x21>
        cpos = 0;
   41dfb:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   41e02:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   41e09:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e0d:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41e11:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41e14:	ee                   	out    %al,(%dx)
}
   41e15:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   41e16:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41e19:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41e1f:	85 c0                	test   %eax,%eax
   41e21:	0f 48 c2             	cmovs  %edx,%eax
   41e24:	c1 f8 08             	sar    $0x8,%eax
   41e27:	0f b6 c0             	movzbl %al,%eax
   41e2a:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   41e31:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e34:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41e38:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41e3b:	ee                   	out    %al,(%dx)
}
   41e3c:	90                   	nop
   41e3d:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   41e44:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e48:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41e4c:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41e4f:	ee                   	out    %al,(%dx)
}
   41e50:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   41e51:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41e54:	89 d0                	mov    %edx,%eax
   41e56:	c1 f8 1f             	sar    $0x1f,%eax
   41e59:	c1 e8 18             	shr    $0x18,%eax
   41e5c:	01 c2                	add    %eax,%edx
   41e5e:	0f b6 d2             	movzbl %dl,%edx
   41e61:	29 c2                	sub    %eax,%edx
   41e63:	89 d0                	mov    %edx,%eax
   41e65:	0f b6 c0             	movzbl %al,%eax
   41e68:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   41e6f:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e72:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41e76:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41e79:	ee                   	out    %al,(%dx)
}
   41e7a:	90                   	nop
}
   41e7b:	90                   	nop
   41e7c:	c9                   	leave  
   41e7d:	c3                   	ret    

0000000000041e7e <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   41e7e:	55                   	push   %rbp
   41e7f:	48 89 e5             	mov    %rsp,%rbp
   41e82:	48 83 ec 20          	sub    $0x20,%rsp
   41e86:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41e8d:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41e90:	89 c2                	mov    %eax,%edx
   41e92:	ec                   	in     (%dx),%al
   41e93:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   41e96:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   41e9a:	0f b6 c0             	movzbl %al,%eax
   41e9d:	83 e0 01             	and    $0x1,%eax
   41ea0:	85 c0                	test   %eax,%eax
   41ea2:	75 0a                	jne    41eae <keyboard_readc+0x30>
        return -1;
   41ea4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   41ea9:	e9 e7 01 00 00       	jmp    42095 <keyboard_readc+0x217>
   41eae:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41eb5:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41eb8:	89 c2                	mov    %eax,%edx
   41eba:	ec                   	in     (%dx),%al
   41ebb:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   41ebe:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   41ec2:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   41ec5:	0f b6 05 36 14 01 00 	movzbl 0x11436(%rip),%eax        # 53302 <last_escape.2>
   41ecc:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   41ecf:	c6 05 2c 14 01 00 00 	movb   $0x0,0x1142c(%rip)        # 53302 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   41ed6:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   41eda:	75 11                	jne    41eed <keyboard_readc+0x6f>
        last_escape = 0x80;
   41edc:	c6 05 1f 14 01 00 80 	movb   $0x80,0x1141f(%rip)        # 53302 <last_escape.2>
        return 0;
   41ee3:	b8 00 00 00 00       	mov    $0x0,%eax
   41ee8:	e9 a8 01 00 00       	jmp    42095 <keyboard_readc+0x217>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   41eed:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41ef1:	84 c0                	test   %al,%al
   41ef3:	79 60                	jns    41f55 <keyboard_readc+0xd7>
        int ch = keymap[(data & 0x7F) | escape];
   41ef5:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41ef9:	83 e0 7f             	and    $0x7f,%eax
   41efc:	89 c2                	mov    %eax,%edx
   41efe:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   41f02:	09 d0                	or     %edx,%eax
   41f04:	48 98                	cltq   
   41f06:	0f b6 80 00 44 04 00 	movzbl 0x44400(%rax),%eax
   41f0d:	0f b6 c0             	movzbl %al,%eax
   41f10:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   41f13:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   41f1a:	7e 2f                	jle    41f4b <keyboard_readc+0xcd>
   41f1c:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   41f23:	7f 26                	jg     41f4b <keyboard_readc+0xcd>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   41f25:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41f28:	2d fa 00 00 00       	sub    $0xfa,%eax
   41f2d:	ba 01 00 00 00       	mov    $0x1,%edx
   41f32:	89 c1                	mov    %eax,%ecx
   41f34:	d3 e2                	shl    %cl,%edx
   41f36:	89 d0                	mov    %edx,%eax
   41f38:	f7 d0                	not    %eax
   41f3a:	89 c2                	mov    %eax,%edx
   41f3c:	0f b6 05 c0 13 01 00 	movzbl 0x113c0(%rip),%eax        # 53303 <modifiers.1>
   41f43:	21 d0                	and    %edx,%eax
   41f45:	88 05 b8 13 01 00    	mov    %al,0x113b8(%rip)        # 53303 <modifiers.1>
        }
        return 0;
   41f4b:	b8 00 00 00 00       	mov    $0x0,%eax
   41f50:	e9 40 01 00 00       	jmp    42095 <keyboard_readc+0x217>
    }

    int ch = (unsigned char) keymap[data | escape];
   41f55:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41f59:	0a 45 fa             	or     -0x6(%rbp),%al
   41f5c:	0f b6 c0             	movzbl %al,%eax
   41f5f:	48 98                	cltq   
   41f61:	0f b6 80 00 44 04 00 	movzbl 0x44400(%rax),%eax
   41f68:	0f b6 c0             	movzbl %al,%eax
   41f6b:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   41f6e:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   41f72:	7e 57                	jle    41fcb <keyboard_readc+0x14d>
   41f74:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   41f78:	7f 51                	jg     41fcb <keyboard_readc+0x14d>
        if (modifiers & MOD_CONTROL) {
   41f7a:	0f b6 05 82 13 01 00 	movzbl 0x11382(%rip),%eax        # 53303 <modifiers.1>
   41f81:	0f b6 c0             	movzbl %al,%eax
   41f84:	83 e0 02             	and    $0x2,%eax
   41f87:	85 c0                	test   %eax,%eax
   41f89:	74 09                	je     41f94 <keyboard_readc+0x116>
            ch -= 0x60;
   41f8b:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   41f8f:	e9 fd 00 00 00       	jmp    42091 <keyboard_readc+0x213>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   41f94:	0f b6 05 68 13 01 00 	movzbl 0x11368(%rip),%eax        # 53303 <modifiers.1>
   41f9b:	0f b6 c0             	movzbl %al,%eax
   41f9e:	83 e0 01             	and    $0x1,%eax
   41fa1:	85 c0                	test   %eax,%eax
   41fa3:	0f 94 c2             	sete   %dl
   41fa6:	0f b6 05 56 13 01 00 	movzbl 0x11356(%rip),%eax        # 53303 <modifiers.1>
   41fad:	0f b6 c0             	movzbl %al,%eax
   41fb0:	83 e0 08             	and    $0x8,%eax
   41fb3:	85 c0                	test   %eax,%eax
   41fb5:	0f 94 c0             	sete   %al
   41fb8:	31 d0                	xor    %edx,%eax
   41fba:	84 c0                	test   %al,%al
   41fbc:	0f 84 cf 00 00 00    	je     42091 <keyboard_readc+0x213>
            ch -= 0x20;
   41fc2:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   41fc6:	e9 c6 00 00 00       	jmp    42091 <keyboard_readc+0x213>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   41fcb:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   41fd2:	7e 30                	jle    42004 <keyboard_readc+0x186>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   41fd4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41fd7:	2d fa 00 00 00       	sub    $0xfa,%eax
   41fdc:	ba 01 00 00 00       	mov    $0x1,%edx
   41fe1:	89 c1                	mov    %eax,%ecx
   41fe3:	d3 e2                	shl    %cl,%edx
   41fe5:	89 d0                	mov    %edx,%eax
   41fe7:	89 c2                	mov    %eax,%edx
   41fe9:	0f b6 05 13 13 01 00 	movzbl 0x11313(%rip),%eax        # 53303 <modifiers.1>
   41ff0:	31 d0                	xor    %edx,%eax
   41ff2:	88 05 0b 13 01 00    	mov    %al,0x1130b(%rip)        # 53303 <modifiers.1>
        ch = 0;
   41ff8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41fff:	e9 8e 00 00 00       	jmp    42092 <keyboard_readc+0x214>
    } else if (ch >= KEY_SHIFT) {
   42004:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   4200b:	7e 2d                	jle    4203a <keyboard_readc+0x1bc>
        modifiers |= 1 << (ch - KEY_SHIFT);
   4200d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42010:	2d fa 00 00 00       	sub    $0xfa,%eax
   42015:	ba 01 00 00 00       	mov    $0x1,%edx
   4201a:	89 c1                	mov    %eax,%ecx
   4201c:	d3 e2                	shl    %cl,%edx
   4201e:	89 d0                	mov    %edx,%eax
   42020:	89 c2                	mov    %eax,%edx
   42022:	0f b6 05 da 12 01 00 	movzbl 0x112da(%rip),%eax        # 53303 <modifiers.1>
   42029:	09 d0                	or     %edx,%eax
   4202b:	88 05 d2 12 01 00    	mov    %al,0x112d2(%rip)        # 53303 <modifiers.1>
        ch = 0;
   42031:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42038:	eb 58                	jmp    42092 <keyboard_readc+0x214>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   4203a:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   4203e:	7e 31                	jle    42071 <keyboard_readc+0x1f3>
   42040:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   42047:	7f 28                	jg     42071 <keyboard_readc+0x1f3>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   42049:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4204c:	8d 50 80             	lea    -0x80(%rax),%edx
   4204f:	0f b6 05 ad 12 01 00 	movzbl 0x112ad(%rip),%eax        # 53303 <modifiers.1>
   42056:	0f b6 c0             	movzbl %al,%eax
   42059:	83 e0 03             	and    $0x3,%eax
   4205c:	48 98                	cltq   
   4205e:	48 63 d2             	movslq %edx,%rdx
   42061:	0f b6 84 90 00 45 04 	movzbl 0x44500(%rax,%rdx,4),%eax
   42068:	00 
   42069:	0f b6 c0             	movzbl %al,%eax
   4206c:	89 45 fc             	mov    %eax,-0x4(%rbp)
   4206f:	eb 21                	jmp    42092 <keyboard_readc+0x214>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   42071:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   42075:	7f 1b                	jg     42092 <keyboard_readc+0x214>
   42077:	0f b6 05 85 12 01 00 	movzbl 0x11285(%rip),%eax        # 53303 <modifiers.1>
   4207e:	0f b6 c0             	movzbl %al,%eax
   42081:	83 e0 02             	and    $0x2,%eax
   42084:	85 c0                	test   %eax,%eax
   42086:	74 0a                	je     42092 <keyboard_readc+0x214>
        ch = 0;
   42088:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4208f:	eb 01                	jmp    42092 <keyboard_readc+0x214>
        if (modifiers & MOD_CONTROL) {
   42091:	90                   	nop
    }

    return ch;
   42092:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   42095:	c9                   	leave  
   42096:	c3                   	ret    

0000000000042097 <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   42097:	55                   	push   %rbp
   42098:	48 89 e5             	mov    %rsp,%rbp
   4209b:	48 83 ec 20          	sub    $0x20,%rsp
   4209f:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   420a6:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   420a9:	89 c2                	mov    %eax,%edx
   420ab:	ec                   	in     (%dx),%al
   420ac:	88 45 e3             	mov    %al,-0x1d(%rbp)
   420af:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   420b6:	8b 45 ec             	mov    -0x14(%rbp),%eax
   420b9:	89 c2                	mov    %eax,%edx
   420bb:	ec                   	in     (%dx),%al
   420bc:	88 45 eb             	mov    %al,-0x15(%rbp)
   420bf:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   420c6:	8b 45 f4             	mov    -0xc(%rbp),%eax
   420c9:	89 c2                	mov    %eax,%edx
   420cb:	ec                   	in     (%dx),%al
   420cc:	88 45 f3             	mov    %al,-0xd(%rbp)
   420cf:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   420d6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   420d9:	89 c2                	mov    %eax,%edx
   420db:	ec                   	in     (%dx),%al
   420dc:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   420df:	90                   	nop
   420e0:	c9                   	leave  
   420e1:	c3                   	ret    

00000000000420e2 <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   420e2:	55                   	push   %rbp
   420e3:	48 89 e5             	mov    %rsp,%rbp
   420e6:	48 83 ec 40          	sub    $0x40,%rsp
   420ea:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   420ee:	89 f0                	mov    %esi,%eax
   420f0:	89 55 c0             	mov    %edx,-0x40(%rbp)
   420f3:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   420f6:	8b 05 08 12 01 00    	mov    0x11208(%rip),%eax        # 53304 <initialized.0>
   420fc:	85 c0                	test   %eax,%eax
   420fe:	75 1e                	jne    4211e <parallel_port_putc+0x3c>
   42100:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   42107:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4210b:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   4210f:	8b 55 f8             	mov    -0x8(%rbp),%edx
   42112:	ee                   	out    %al,(%dx)
}
   42113:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   42114:	c7 05 e6 11 01 00 01 	movl   $0x1,0x111e6(%rip)        # 53304 <initialized.0>
   4211b:	00 00 00 
    }

    for (int i = 0;
   4211e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42125:	eb 09                	jmp    42130 <parallel_port_putc+0x4e>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   42127:	e8 6b ff ff ff       	call   42097 <delay>
         ++i) {
   4212c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   42130:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   42137:	7f 18                	jg     42151 <parallel_port_putc+0x6f>
   42139:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42140:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42143:	89 c2                	mov    %eax,%edx
   42145:	ec                   	in     (%dx),%al
   42146:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   42149:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   4214d:	84 c0                	test   %al,%al
   4214f:	79 d6                	jns    42127 <parallel_port_putc+0x45>
    }
    outb(IO_PARALLEL1_DATA, c);
   42151:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   42155:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   4215c:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4215f:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   42163:	8b 55 d8             	mov    -0x28(%rbp),%edx
   42166:	ee                   	out    %al,(%dx)
}
   42167:	90                   	nop
   42168:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   4216f:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42173:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   42177:	8b 55 e0             	mov    -0x20(%rbp),%edx
   4217a:	ee                   	out    %al,(%dx)
}
   4217b:	90                   	nop
   4217c:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   42183:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42187:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   4218b:	8b 55 e8             	mov    -0x18(%rbp),%edx
   4218e:	ee                   	out    %al,(%dx)
}
   4218f:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   42190:	90                   	nop
   42191:	c9                   	leave  
   42192:	c3                   	ret    

0000000000042193 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   42193:	55                   	push   %rbp
   42194:	48 89 e5             	mov    %rsp,%rbp
   42197:	48 83 ec 20          	sub    $0x20,%rsp
   4219b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4219f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   421a3:	48 c7 45 f8 e2 20 04 	movq   $0x420e2,-0x8(%rbp)
   421aa:	00 
    printer_vprintf(&p, 0, format, val);
   421ab:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   421af:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   421b3:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   421b7:	be 00 00 00 00       	mov    $0x0,%esi
   421bc:	48 89 c7             	mov    %rax,%rdi
   421bf:	e8 14 11 00 00       	call   432d8 <printer_vprintf>
}
   421c4:	90                   	nop
   421c5:	c9                   	leave  
   421c6:	c3                   	ret    

00000000000421c7 <log_printf>:

void log_printf(const char* format, ...) {
   421c7:	55                   	push   %rbp
   421c8:	48 89 e5             	mov    %rsp,%rbp
   421cb:	48 83 ec 60          	sub    $0x60,%rsp
   421cf:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   421d3:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   421d7:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   421db:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   421df:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   421e3:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   421e7:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   421ee:	48 8d 45 10          	lea    0x10(%rbp),%rax
   421f2:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   421f6:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   421fa:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   421fe:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   42202:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42206:	48 89 d6             	mov    %rdx,%rsi
   42209:	48 89 c7             	mov    %rax,%rdi
   4220c:	e8 82 ff ff ff       	call   42193 <log_vprintf>
    va_end(val);
}
   42211:	90                   	nop
   42212:	c9                   	leave  
   42213:	c3                   	ret    

0000000000042214 <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   42214:	55                   	push   %rbp
   42215:	48 89 e5             	mov    %rsp,%rbp
   42218:	48 83 ec 40          	sub    $0x40,%rsp
   4221c:	89 7d dc             	mov    %edi,-0x24(%rbp)
   4221f:	89 75 d8             	mov    %esi,-0x28(%rbp)
   42222:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   42226:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   4222a:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   4222e:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42232:	48 8b 0a             	mov    (%rdx),%rcx
   42235:	48 89 08             	mov    %rcx,(%rax)
   42238:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   4223c:	48 89 48 08          	mov    %rcx,0x8(%rax)
   42240:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   42244:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   42248:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   4224c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42250:	48 89 d6             	mov    %rdx,%rsi
   42253:	48 89 c7             	mov    %rax,%rdi
   42256:	e8 38 ff ff ff       	call   42193 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   4225b:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   4225f:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42263:	8b 75 d8             	mov    -0x28(%rbp),%esi
   42266:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42269:	89 c7                	mov    %eax,%edi
   4226b:	e8 17 1b 00 00       	call   43d87 <console_vprintf>
}
   42270:	c9                   	leave  
   42271:	c3                   	ret    

0000000000042272 <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   42272:	55                   	push   %rbp
   42273:	48 89 e5             	mov    %rsp,%rbp
   42276:	48 83 ec 60          	sub    $0x60,%rsp
   4227a:	89 7d ac             	mov    %edi,-0x54(%rbp)
   4227d:	89 75 a8             	mov    %esi,-0x58(%rbp)
   42280:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   42284:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42288:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4228c:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42290:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   42297:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4229b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   4229f:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   422a3:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   422a7:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   422ab:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   422af:	8b 75 a8             	mov    -0x58(%rbp),%esi
   422b2:	8b 45 ac             	mov    -0x54(%rbp),%eax
   422b5:	89 c7                	mov    %eax,%edi
   422b7:	e8 58 ff ff ff       	call   42214 <error_vprintf>
   422bc:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   422bf:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   422c2:	c9                   	leave  
   422c3:	c3                   	ret    

00000000000422c4 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'f', and 'e' cause a soft
//    reboot where the kernel runs the allocator programs, "fork", or
//    "forkexit", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   422c4:	55                   	push   %rbp
   422c5:	48 89 e5             	mov    %rsp,%rbp
   422c8:	53                   	push   %rbx
   422c9:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   422cd:	e8 ac fb ff ff       	call   41e7e <keyboard_readc>
   422d2:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   422d5:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   422d9:	74 1c                	je     422f7 <check_keyboard+0x33>
   422db:	83 7d e4 66          	cmpl   $0x66,-0x1c(%rbp)
   422df:	74 16                	je     422f7 <check_keyboard+0x33>
   422e1:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   422e5:	74 10                	je     422f7 <check_keyboard+0x33>
   422e7:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   422eb:	74 0a                	je     422f7 <check_keyboard+0x33>
   422ed:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   422f1:	0f 85 e9 00 00 00    	jne    423e0 <check_keyboard+0x11c>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   422f7:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   422fe:	00 
        memset(pt, 0, PAGESIZE * 3);
   422ff:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42303:	ba 00 30 00 00       	mov    $0x3000,%edx
   42308:	be 00 00 00 00       	mov    $0x0,%esi
   4230d:	48 89 c7             	mov    %rax,%rdi
   42310:	e8 27 0d 00 00       	call   4303c <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   42315:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42319:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   42320:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42324:	48 05 00 10 00 00    	add    $0x1000,%rax
   4232a:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   42331:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42335:	48 05 00 20 00 00    	add    $0x2000,%rax
   4233b:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   42342:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42346:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   4234a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4234e:	0f 22 d8             	mov    %rax,%cr3
}
   42351:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   42352:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "fork";
   42359:	48 c7 45 e8 58 45 04 	movq   $0x44558,-0x18(%rbp)
   42360:	00 
        if (c == 'a') {
   42361:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42365:	75 0a                	jne    42371 <check_keyboard+0xad>
            argument = "allocator";
   42367:	48 c7 45 e8 5d 45 04 	movq   $0x4455d,-0x18(%rbp)
   4236e:	00 
   4236f:	eb 2e                	jmp    4239f <check_keyboard+0xdb>
        } else if (c == 'e') {
   42371:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42375:	75 0a                	jne    42381 <check_keyboard+0xbd>
            argument = "forkexit";
   42377:	48 c7 45 e8 67 45 04 	movq   $0x44567,-0x18(%rbp)
   4237e:	00 
   4237f:	eb 1e                	jmp    4239f <check_keyboard+0xdb>
        }
        else if (c == 't'){
   42381:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42385:	75 0a                	jne    42391 <check_keyboard+0xcd>
            argument = "test";
   42387:	48 c7 45 e8 70 45 04 	movq   $0x44570,-0x18(%rbp)
   4238e:	00 
   4238f:	eb 0e                	jmp    4239f <check_keyboard+0xdb>
        }
        else if(c == '2'){
   42391:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42395:	75 08                	jne    4239f <check_keyboard+0xdb>
            argument = "test2";
   42397:	48 c7 45 e8 75 45 04 	movq   $0x44575,-0x18(%rbp)
   4239e:	00 
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   4239f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   423a3:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   423a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   423ac:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   423b0:	73 14                	jae    423c6 <check_keyboard+0x102>
   423b2:	ba 7b 45 04 00       	mov    $0x4457b,%edx
   423b7:	be 5d 02 00 00       	mov    $0x25d,%esi
   423bc:	bf 97 45 04 00       	mov    $0x44597,%edi
   423c1:	e8 1f 01 00 00       	call   424e5 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   423c6:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   423ca:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   423cd:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   423d1:	48 89 c3             	mov    %rax,%rbx
   423d4:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   423d9:	e9 22 dc ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   423de:	eb 11                	jmp    423f1 <check_keyboard+0x12d>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   423e0:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   423e4:	74 06                	je     423ec <check_keyboard+0x128>
   423e6:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   423ea:	75 05                	jne    423f1 <check_keyboard+0x12d>
        poweroff();
   423ec:	e8 9d f8 ff ff       	call   41c8e <poweroff>
    }
    return c;
   423f1:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   423f4:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   423f8:	c9                   	leave  
   423f9:	c3                   	ret    

00000000000423fa <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   423fa:	55                   	push   %rbp
   423fb:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   423fe:	e8 c1 fe ff ff       	call   422c4 <check_keyboard>
   42403:	eb f9                	jmp    423fe <fail+0x4>

0000000000042405 <panic>:

// panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void panic(const char* format, ...) {
   42405:	55                   	push   %rbp
   42406:	48 89 e5             	mov    %rsp,%rbp
   42409:	48 83 ec 60          	sub    $0x60,%rsp
   4240d:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42411:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42415:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42419:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4241d:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42421:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42425:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   4242c:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42430:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   42434:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42438:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   4243c:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   42441:	0f 84 80 00 00 00    	je     424c7 <panic+0xc2>
        // Print panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   42447:	ba ab 45 04 00       	mov    $0x445ab,%edx
   4244c:	be 00 c0 00 00       	mov    $0xc000,%esi
   42451:	bf 30 07 00 00       	mov    $0x730,%edi
   42456:	b8 00 00 00 00       	mov    $0x0,%eax
   4245b:	e8 12 fe ff ff       	call   42272 <error_printf>
   42460:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   42463:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   42467:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   4246b:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4246e:	be 00 c0 00 00       	mov    $0xc000,%esi
   42473:	89 c7                	mov    %eax,%edi
   42475:	e8 9a fd ff ff       	call   42214 <error_vprintf>
   4247a:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   4247d:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   42480:	48 63 c1             	movslq %ecx,%rax
   42483:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   4248a:	48 c1 e8 20          	shr    $0x20,%rax
   4248e:	89 c2                	mov    %eax,%edx
   42490:	c1 fa 05             	sar    $0x5,%edx
   42493:	89 c8                	mov    %ecx,%eax
   42495:	c1 f8 1f             	sar    $0x1f,%eax
   42498:	29 c2                	sub    %eax,%edx
   4249a:	89 d0                	mov    %edx,%eax
   4249c:	c1 e0 02             	shl    $0x2,%eax
   4249f:	01 d0                	add    %edx,%eax
   424a1:	c1 e0 04             	shl    $0x4,%eax
   424a4:	29 c1                	sub    %eax,%ecx
   424a6:	89 ca                	mov    %ecx,%edx
   424a8:	85 d2                	test   %edx,%edx
   424aa:	74 34                	je     424e0 <panic+0xdb>
            error_printf(cpos, 0xC000, "\n");
   424ac:	8b 45 cc             	mov    -0x34(%rbp),%eax
   424af:	ba b3 45 04 00       	mov    $0x445b3,%edx
   424b4:	be 00 c0 00 00       	mov    $0xc000,%esi
   424b9:	89 c7                	mov    %eax,%edi
   424bb:	b8 00 00 00 00       	mov    $0x0,%eax
   424c0:	e8 ad fd ff ff       	call   42272 <error_printf>
   424c5:	eb 19                	jmp    424e0 <panic+0xdb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   424c7:	ba b5 45 04 00       	mov    $0x445b5,%edx
   424cc:	be 00 c0 00 00       	mov    $0xc000,%esi
   424d1:	bf 30 07 00 00       	mov    $0x730,%edi
   424d6:	b8 00 00 00 00       	mov    $0x0,%eax
   424db:	e8 92 fd ff ff       	call   42272 <error_printf>
    }

    va_end(val);
    fail();
   424e0:	e8 15 ff ff ff       	call   423fa <fail>

00000000000424e5 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   424e5:	55                   	push   %rbp
   424e6:	48 89 e5             	mov    %rsp,%rbp
   424e9:	48 83 ec 20          	sub    $0x20,%rsp
   424ed:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   424f1:	89 75 f4             	mov    %esi,-0xc(%rbp)
   424f4:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   424f8:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   424fc:	8b 55 f4             	mov    -0xc(%rbp),%edx
   424ff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42503:	48 89 c6             	mov    %rax,%rsi
   42506:	bf bb 45 04 00       	mov    $0x445bb,%edi
   4250b:	b8 00 00 00 00       	mov    $0x0,%eax
   42510:	e8 f0 fe ff ff       	call   42405 <panic>

0000000000042515 <default_exception>:
}

void default_exception(proc* p){
   42515:	55                   	push   %rbp
   42516:	48 89 e5             	mov    %rsp,%rbp
   42519:	48 83 ec 20          	sub    $0x20,%rsp
   4251d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   42521:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42525:	48 83 c0 08          	add    $0x8,%rax
   42529:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    panic("Unexpected exception %d!\n", reg->reg_intno);
   4252d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42531:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   42538:	48 89 c6             	mov    %rax,%rsi
   4253b:	bf d9 45 04 00       	mov    $0x445d9,%edi
   42540:	b8 00 00 00 00       	mov    $0x0,%eax
   42545:	e8 bb fe ff ff       	call   42405 <panic>

000000000004254a <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   4254a:	55                   	push   %rbp
   4254b:	48 89 e5             	mov    %rsp,%rbp
   4254e:	48 83 ec 10          	sub    $0x10,%rsp
   42552:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42556:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   42559:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   4255d:	78 06                	js     42565 <pageindex+0x1b>
   4255f:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   42563:	7e 14                	jle    42579 <pageindex+0x2f>
   42565:	ba f8 45 04 00       	mov    $0x445f8,%edx
   4256a:	be 1e 00 00 00       	mov    $0x1e,%esi
   4256f:	bf 11 46 04 00       	mov    $0x44611,%edi
   42574:	e8 6c ff ff ff       	call   424e5 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   42579:	b8 03 00 00 00       	mov    $0x3,%eax
   4257e:	2b 45 f4             	sub    -0xc(%rbp),%eax
   42581:	89 c2                	mov    %eax,%edx
   42583:	89 d0                	mov    %edx,%eax
   42585:	c1 e0 03             	shl    $0x3,%eax
   42588:	01 d0                	add    %edx,%eax
   4258a:	83 c0 0c             	add    $0xc,%eax
   4258d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42591:	89 c1                	mov    %eax,%ecx
   42593:	48 d3 ea             	shr    %cl,%rdx
   42596:	48 89 d0             	mov    %rdx,%rax
   42599:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   4259e:	c9                   	leave  
   4259f:	c3                   	ret    

00000000000425a0 <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   425a0:	55                   	push   %rbp
   425a1:	48 89 e5             	mov    %rsp,%rbp
   425a4:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   425a8:	48 c7 05 4d 1a 01 00 	movq   $0x55000,0x11a4d(%rip)        # 54000 <kernel_pagetable>
   425af:	00 50 05 00 
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   425b3:	ba 00 50 00 00       	mov    $0x5000,%edx
   425b8:	be 00 00 00 00       	mov    $0x0,%esi
   425bd:	bf 00 50 05 00       	mov    $0x55000,%edi
   425c2:	e8 75 0a 00 00       	call   4303c <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   425c7:	b8 00 60 05 00       	mov    $0x56000,%eax
   425cc:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   425d0:	48 89 05 29 2a 01 00 	mov    %rax,0x12a29(%rip)        # 55000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   425d7:	b8 00 70 05 00       	mov    $0x57000,%eax
   425dc:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   425e0:	48 89 05 19 3a 01 00 	mov    %rax,0x13a19(%rip)        # 56000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   425e7:	b8 00 80 05 00       	mov    $0x58000,%eax
   425ec:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   425f0:	48 89 05 09 4a 01 00 	mov    %rax,0x14a09(%rip)        # 57000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   425f7:	b8 00 90 05 00       	mov    $0x59000,%eax
   425fc:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   42600:	48 89 05 01 4a 01 00 	mov    %rax,0x14a01(%rip)        # 57008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   42607:	48 8b 05 f2 19 01 00 	mov    0x119f2(%rip),%rax        # 54000 <kernel_pagetable>
   4260e:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42614:	b9 00 00 20 00       	mov    $0x200000,%ecx
   42619:	ba 00 00 00 00       	mov    $0x0,%edx
   4261e:	be 00 00 00 00       	mov    $0x0,%esi
   42623:	48 89 c7             	mov    %rax,%rdi
   42626:	e8 b9 01 00 00       	call   427e4 <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   4262b:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42632:	00 
   42633:	eb 62                	jmp    42697 <virtual_memory_init+0xf7>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   42635:	48 8b 0d c4 19 01 00 	mov    0x119c4(%rip),%rcx        # 54000 <kernel_pagetable>
   4263c:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42640:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42644:	48 89 ce             	mov    %rcx,%rsi
   42647:	48 89 c7             	mov    %rax,%rdi
   4264a:	e8 5b 05 00 00       	call   42baa <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l1pagetable ?
        assert(vmap.pa == addr);
   4264f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42653:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   42657:	74 14                	je     4266d <virtual_memory_init+0xcd>
   42659:	ba 25 46 04 00       	mov    $0x44625,%edx
   4265e:	be 2d 00 00 00       	mov    $0x2d,%esi
   42663:	bf 35 46 04 00       	mov    $0x44635,%edi
   42668:	e8 78 fe ff ff       	call   424e5 <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   4266d:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42670:	48 98                	cltq   
   42672:	83 e0 03             	and    $0x3,%eax
   42675:	48 83 f8 03          	cmp    $0x3,%rax
   42679:	74 14                	je     4268f <virtual_memory_init+0xef>
   4267b:	ba 48 46 04 00       	mov    $0x44648,%edx
   42680:	be 2e 00 00 00       	mov    $0x2e,%esi
   42685:	bf 35 46 04 00       	mov    $0x44635,%edi
   4268a:	e8 56 fe ff ff       	call   424e5 <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   4268f:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42696:	00 
   42697:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   4269e:	00 
   4269f:	76 94                	jbe    42635 <virtual_memory_init+0x95>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   426a1:	48 8b 05 58 19 01 00 	mov    0x11958(%rip),%rax        # 54000 <kernel_pagetable>
   426a8:	48 89 c7             	mov    %rax,%rdi
   426ab:	e8 03 00 00 00       	call   426b3 <set_pagetable>
}
   426b0:	90                   	nop
   426b1:	c9                   	leave  
   426b2:	c3                   	ret    

00000000000426b3 <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   426b3:	55                   	push   %rbp
   426b4:	48 89 e5             	mov    %rsp,%rbp
   426b7:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   426bb:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   426bf:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   426c3:	25 ff 0f 00 00       	and    $0xfff,%eax
   426c8:	48 85 c0             	test   %rax,%rax
   426cb:	74 14                	je     426e1 <set_pagetable+0x2e>
   426cd:	ba 75 46 04 00       	mov    $0x44675,%edx
   426d2:	be 3d 00 00 00       	mov    $0x3d,%esi
   426d7:	bf 35 46 04 00       	mov    $0x44635,%edi
   426dc:	e8 04 fe ff ff       	call   424e5 <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   426e1:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   426e6:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   426ea:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   426ee:	48 89 ce             	mov    %rcx,%rsi
   426f1:	48 89 c7             	mov    %rax,%rdi
   426f4:	e8 b1 04 00 00       	call   42baa <virtual_memory_lookup>
   426f9:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   426fd:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42702:	48 39 d0             	cmp    %rdx,%rax
   42705:	74 14                	je     4271b <set_pagetable+0x68>
   42707:	ba 90 46 04 00       	mov    $0x44690,%edx
   4270c:	be 3f 00 00 00       	mov    $0x3f,%esi
   42711:	bf 35 46 04 00       	mov    $0x44635,%edi
   42716:	e8 ca fd ff ff       	call   424e5 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   4271b:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   4271f:	48 8b 0d da 18 01 00 	mov    0x118da(%rip),%rcx        # 54000 <kernel_pagetable>
   42726:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   4272a:	48 89 ce             	mov    %rcx,%rsi
   4272d:	48 89 c7             	mov    %rax,%rdi
   42730:	e8 75 04 00 00       	call   42baa <virtual_memory_lookup>
   42735:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42739:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   4273d:	48 39 c2             	cmp    %rax,%rdx
   42740:	74 14                	je     42756 <set_pagetable+0xa3>
   42742:	ba f8 46 04 00       	mov    $0x446f8,%edx
   42747:	be 41 00 00 00       	mov    $0x41,%esi
   4274c:	bf 35 46 04 00       	mov    $0x44635,%edi
   42751:	e8 8f fd ff ff       	call   424e5 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   42756:	48 8b 05 a3 18 01 00 	mov    0x118a3(%rip),%rax        # 54000 <kernel_pagetable>
   4275d:	48 89 c2             	mov    %rax,%rdx
   42760:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   42764:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42768:	48 89 ce             	mov    %rcx,%rsi
   4276b:	48 89 c7             	mov    %rax,%rdi
   4276e:	e8 37 04 00 00       	call   42baa <virtual_memory_lookup>
   42773:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42777:	48 8b 15 82 18 01 00 	mov    0x11882(%rip),%rdx        # 54000 <kernel_pagetable>
   4277e:	48 39 d0             	cmp    %rdx,%rax
   42781:	74 14                	je     42797 <set_pagetable+0xe4>
   42783:	ba 58 47 04 00       	mov    $0x44758,%edx
   42788:	be 43 00 00 00       	mov    $0x43,%esi
   4278d:	bf 35 46 04 00       	mov    $0x44635,%edi
   42792:	e8 4e fd ff ff       	call   424e5 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   42797:	ba e4 27 04 00       	mov    $0x427e4,%edx
   4279c:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   427a0:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   427a4:	48 89 ce             	mov    %rcx,%rsi
   427a7:	48 89 c7             	mov    %rax,%rdi
   427aa:	e8 fb 03 00 00       	call   42baa <virtual_memory_lookup>
   427af:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   427b3:	ba e4 27 04 00       	mov    $0x427e4,%edx
   427b8:	48 39 d0             	cmp    %rdx,%rax
   427bb:	74 14                	je     427d1 <set_pagetable+0x11e>
   427bd:	ba c0 47 04 00       	mov    $0x447c0,%edx
   427c2:	be 45 00 00 00       	mov    $0x45,%esi
   427c7:	bf 35 46 04 00       	mov    $0x44635,%edi
   427cc:	e8 14 fd ff ff       	call   424e5 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   427d1:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   427d5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   427d9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   427dd:	0f 22 d8             	mov    %rax,%cr3
}
   427e0:	90                   	nop
}
   427e1:	90                   	nop
   427e2:	c9                   	leave  
   427e3:	c3                   	ret    

00000000000427e4 <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   427e4:	55                   	push   %rbp
   427e5:	48 89 e5             	mov    %rsp,%rbp
   427e8:	41 54                	push   %r12
   427ea:	53                   	push   %rbx
   427eb:	48 83 ec 50          	sub    $0x50,%rsp
   427ef:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   427f3:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   427f7:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   427fb:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
   427ff:	44 89 45 ac          	mov    %r8d,-0x54(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   42803:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42807:	25 ff 0f 00 00       	and    $0xfff,%eax
   4280c:	48 85 c0             	test   %rax,%rax
   4280f:	74 14                	je     42825 <virtual_memory_map+0x41>
   42811:	ba 26 48 04 00       	mov    $0x44826,%edx
   42816:	be 66 00 00 00       	mov    $0x66,%esi
   4281b:	bf 35 46 04 00       	mov    $0x44635,%edi
   42820:	e8 c0 fc ff ff       	call   424e5 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   42825:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42829:	25 ff 0f 00 00       	and    $0xfff,%eax
   4282e:	48 85 c0             	test   %rax,%rax
   42831:	74 14                	je     42847 <virtual_memory_map+0x63>
   42833:	ba 39 48 04 00       	mov    $0x44839,%edx
   42838:	be 67 00 00 00       	mov    $0x67,%esi
   4283d:	bf 35 46 04 00       	mov    $0x44635,%edi
   42842:	e8 9e fc ff ff       	call   424e5 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   42847:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   4284b:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   4284f:	48 01 d0             	add    %rdx,%rax
   42852:	48 3b 45 c0          	cmp    -0x40(%rbp),%rax
   42856:	73 24                	jae    4287c <virtual_memory_map+0x98>
   42858:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   4285c:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42860:	48 01 d0             	add    %rdx,%rax
   42863:	48 85 c0             	test   %rax,%rax
   42866:	74 14                	je     4287c <virtual_memory_map+0x98>
   42868:	ba 4c 48 04 00       	mov    $0x4484c,%edx
   4286d:	be 68 00 00 00       	mov    $0x68,%esi
   42872:	bf 35 46 04 00       	mov    $0x44635,%edi
   42877:	e8 69 fc ff ff       	call   424e5 <assert_fail>
    if (perm & PTE_P) {
   4287c:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4287f:	48 98                	cltq   
   42881:	83 e0 01             	and    $0x1,%eax
   42884:	48 85 c0             	test   %rax,%rax
   42887:	74 6e                	je     428f7 <virtual_memory_map+0x113>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   42889:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4288d:	25 ff 0f 00 00       	and    $0xfff,%eax
   42892:	48 85 c0             	test   %rax,%rax
   42895:	74 14                	je     428ab <virtual_memory_map+0xc7>
   42897:	ba 6a 48 04 00       	mov    $0x4486a,%edx
   4289c:	be 6a 00 00 00       	mov    $0x6a,%esi
   428a1:	bf 35 46 04 00       	mov    $0x44635,%edi
   428a6:	e8 3a fc ff ff       	call   424e5 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   428ab:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   428af:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   428b3:	48 01 d0             	add    %rdx,%rax
   428b6:	48 3b 45 b8          	cmp    -0x48(%rbp),%rax
   428ba:	73 14                	jae    428d0 <virtual_memory_map+0xec>
   428bc:	ba 7d 48 04 00       	mov    $0x4487d,%edx
   428c1:	be 6b 00 00 00       	mov    $0x6b,%esi
   428c6:	bf 35 46 04 00       	mov    $0x44635,%edi
   428cb:	e8 15 fc ff ff       	call   424e5 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   428d0:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   428d4:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   428d8:	48 01 d0             	add    %rdx,%rax
   428db:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   428e1:	76 14                	jbe    428f7 <virtual_memory_map+0x113>
   428e3:	ba 8b 48 04 00       	mov    $0x4488b,%edx
   428e8:	be 6c 00 00 00       	mov    $0x6c,%esi
   428ed:	bf 35 46 04 00       	mov    $0x44635,%edi
   428f2:	e8 ee fb ff ff       	call   424e5 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   428f7:	83 7d ac 00          	cmpl   $0x0,-0x54(%rbp)
   428fb:	78 09                	js     42906 <virtual_memory_map+0x122>
   428fd:	81 7d ac ff 0f 00 00 	cmpl   $0xfff,-0x54(%rbp)
   42904:	7e 14                	jle    4291a <virtual_memory_map+0x136>
   42906:	ba a7 48 04 00       	mov    $0x448a7,%edx
   4290b:	be 6e 00 00 00       	mov    $0x6e,%esi
   42910:	bf 35 46 04 00       	mov    $0x44635,%edi
   42915:	e8 cb fb ff ff       	call   424e5 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   4291a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4291e:	25 ff 0f 00 00       	and    $0xfff,%eax
   42923:	48 85 c0             	test   %rax,%rax
   42926:	74 14                	je     4293c <virtual_memory_map+0x158>
   42928:	ba c8 48 04 00       	mov    $0x448c8,%edx
   4292d:	be 6f 00 00 00       	mov    $0x6f,%esi
   42932:	bf 35 46 04 00       	mov    $0x44635,%edi
   42937:	e8 a9 fb ff ff       	call   424e5 <assert_fail>

    int last_index123 = -1;
   4293c:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%rbp)
    x86_64_pagetable* l1pagetable = NULL;
   42943:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
   4294a:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   4294b:	e9 e7 00 00 00       	jmp    42a37 <virtual_memory_map+0x253>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   42950:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42954:	48 c1 e8 15          	shr    $0x15,%rax
   42958:	89 45 dc             	mov    %eax,-0x24(%rbp)
        if (cur_index123 != last_index123) {
   4295b:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4295e:	3b 45 ec             	cmp    -0x14(%rbp),%eax
   42961:	74 20                	je     42983 <virtual_memory_map+0x19f>
            // TODO --> done
            // find pointer to last level pagetable for current va

			l1pagetable = lookup_l1pagetable(pagetable, va, perm);	
   42963:	8b 55 ac             	mov    -0x54(%rbp),%edx
   42966:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   4296a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4296e:	48 89 ce             	mov    %rcx,%rsi
   42971:	48 89 c7             	mov    %rax,%rdi
   42974:	e8 d7 00 00 00       	call   42a50 <lookup_l1pagetable>
   42979:	48 89 45 e0          	mov    %rax,-0x20(%rbp)

            last_index123 = cur_index123;
   4297d:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42980:	89 45 ec             	mov    %eax,-0x14(%rbp)
        }
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   42983:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42986:	48 98                	cltq   
   42988:	83 e0 01             	and    $0x1,%eax
   4298b:	48 85 c0             	test   %rax,%rax
   4298e:	74 3a                	je     429ca <virtual_memory_map+0x1e6>
   42990:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42995:	74 33                	je     429ca <virtual_memory_map+0x1e6>
            // TODO --> done
            // map `pa` at appropriate entry with permissions `perm`
			l1pagetable->entry[L1PAGEINDEX(va)] =  (0x00000000FFFFFFFF & pa) | perm;
   42997:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4299b:	41 89 c4             	mov    %eax,%r12d
   4299e:	8b 45 ac             	mov    -0x54(%rbp),%eax
   429a1:	48 63 d8             	movslq %eax,%rbx
   429a4:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   429a8:	be 03 00 00 00       	mov    $0x3,%esi
   429ad:	48 89 c7             	mov    %rax,%rdi
   429b0:	e8 95 fb ff ff       	call   4254a <pageindex>
   429b5:	89 c2                	mov    %eax,%edx
   429b7:	4c 89 e1             	mov    %r12,%rcx
   429ba:	48 09 d9             	or     %rbx,%rcx
   429bd:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   429c1:	48 63 d2             	movslq %edx,%rdx
   429c4:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   429c8:	eb 55                	jmp    42a1f <virtual_memory_map+0x23b>

        } else if (l1pagetable) { // if page is NOT marked present
   429ca:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   429cf:	74 26                	je     429f7 <virtual_memory_map+0x213>
            // TODO --> done
            // map to address 0 with `perm`
			l1pagetable->entry[L1PAGEINDEX(va)] = 0 | perm;
   429d1:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   429d5:	be 03 00 00 00       	mov    $0x3,%esi
   429da:	48 89 c7             	mov    %rax,%rdi
   429dd:	e8 68 fb ff ff       	call   4254a <pageindex>
   429e2:	89 c2                	mov    %eax,%edx
   429e4:	8b 45 ac             	mov    -0x54(%rbp),%eax
   429e7:	48 63 c8             	movslq %eax,%rcx
   429ea:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   429ee:	48 63 d2             	movslq %edx,%rdx
   429f1:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   429f5:	eb 28                	jmp    42a1f <virtual_memory_map+0x23b>

        } else if (perm & PTE_P) {
   429f7:	8b 45 ac             	mov    -0x54(%rbp),%eax
   429fa:	48 98                	cltq   
   429fc:	83 e0 01             	and    $0x1,%eax
   429ff:	48 85 c0             	test   %rax,%rax
   42a02:	74 1b                	je     42a1f <virtual_memory_map+0x23b>
            // error, no allocated l1 page found for va
            log_printf("[Kern Info] failed to find l1pagetable address at " __FILE__ ": %d\n", __LINE__);
   42a04:	be 8b 00 00 00       	mov    $0x8b,%esi
   42a09:	bf f0 48 04 00       	mov    $0x448f0,%edi
   42a0e:	b8 00 00 00 00       	mov    $0x0,%eax
   42a13:	e8 af f7 ff ff       	call   421c7 <log_printf>
            return -1;
   42a18:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42a1d:	eb 28                	jmp    42a47 <virtual_memory_map+0x263>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42a1f:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
   42a26:	00 
   42a27:	48 81 45 b8 00 10 00 	addq   $0x1000,-0x48(%rbp)
   42a2e:	00 
   42a2f:	48 81 6d b0 00 10 00 	subq   $0x1000,-0x50(%rbp)
   42a36:	00 
   42a37:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   42a3c:	0f 85 0e ff ff ff    	jne    42950 <virtual_memory_map+0x16c>
        }
    }
    return 0;
   42a42:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42a47:	48 83 c4 50          	add    $0x50,%rsp
   42a4b:	5b                   	pop    %rbx
   42a4c:	41 5c                	pop    %r12
   42a4e:	5d                   	pop    %rbp
   42a4f:	c3                   	ret    

0000000000042a50 <lookup_l1pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   42a50:	55                   	push   %rbp
   42a51:	48 89 e5             	mov    %rsp,%rbp
   42a54:	48 83 ec 40          	sub    $0x40,%rsp
   42a58:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42a5c:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42a60:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   42a63:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42a67:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l1 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   42a6b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   42a72:	e9 23 01 00 00       	jmp    42b9a <lookup_l1pagetable+0x14a>
        // TODO --> done
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        x86_64_pageentry_t pe = pt->entry[PAGEINDEX(va, i)]; // replace this
   42a77:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42a7a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42a7e:	89 d6                	mov    %edx,%esi
   42a80:	48 89 c7             	mov    %rax,%rdi
   42a83:	e8 c2 fa ff ff       	call   4254a <pageindex>
   42a88:	89 c2                	mov    %eax,%edx
   42a8a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42a8e:	48 63 d2             	movslq %edx,%rdx
   42a91:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   42a95:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   42a99:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42a9d:	83 e0 01             	and    $0x1,%eax
   42aa0:	48 85 c0             	test   %rax,%rax
   42aa3:	75 63                	jne    42b08 <lookup_l1pagetable+0xb8>
            log_printf("[Kern Info] Error looking up l1pagetable: Pagetable address: 0x%x perm: 0x%x."
   42aa5:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42aa8:	8d 48 02             	lea    0x2(%rax),%ecx
   42aab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42aaf:	25 ff 0f 00 00       	and    $0xfff,%eax
   42ab4:	48 89 c2             	mov    %rax,%rdx
   42ab7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42abb:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42ac1:	48 89 c6             	mov    %rax,%rsi
   42ac4:	bf 38 49 04 00       	mov    $0x44938,%edi
   42ac9:	b8 00 00 00 00       	mov    $0x0,%eax
   42ace:	e8 f4 f6 ff ff       	call   421c7 <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   42ad3:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42ad6:	48 98                	cltq   
   42ad8:	83 e0 01             	and    $0x1,%eax
   42adb:	48 85 c0             	test   %rax,%rax
   42ade:	75 0a                	jne    42aea <lookup_l1pagetable+0x9a>
                return NULL;
   42ae0:	b8 00 00 00 00       	mov    $0x0,%eax
   42ae5:	e9 be 00 00 00       	jmp    42ba8 <lookup_l1pagetable+0x158>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   42aea:	be af 00 00 00       	mov    $0xaf,%esi
   42aef:	bf a0 49 04 00       	mov    $0x449a0,%edi
   42af4:	b8 00 00 00 00       	mov    $0x0,%eax
   42af9:	e8 c9 f6 ff ff       	call   421c7 <log_printf>
            return NULL;
   42afe:	b8 00 00 00 00       	mov    $0x0,%eax
   42b03:	e9 a0 00 00 00       	jmp    42ba8 <lookup_l1pagetable+0x158>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   42b08:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b0c:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42b12:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   42b18:	76 14                	jbe    42b2e <lookup_l1pagetable+0xde>
   42b1a:	ba e8 49 04 00       	mov    $0x449e8,%edx
   42b1f:	be b4 00 00 00       	mov    $0xb4,%esi
   42b24:	bf 35 46 04 00       	mov    $0x44635,%edi
   42b29:	e8 b7 f9 ff ff       	call   424e5 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   42b2e:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42b31:	48 98                	cltq   
   42b33:	83 e0 02             	and    $0x2,%eax
   42b36:	48 85 c0             	test   %rax,%rax
   42b39:	74 20                	je     42b5b <lookup_l1pagetable+0x10b>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   42b3b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b3f:	83 e0 02             	and    $0x2,%eax
   42b42:	48 85 c0             	test   %rax,%rax
   42b45:	75 14                	jne    42b5b <lookup_l1pagetable+0x10b>
   42b47:	ba 08 4a 04 00       	mov    $0x44a08,%edx
   42b4c:	be b6 00 00 00       	mov    $0xb6,%esi
   42b51:	bf 35 46 04 00       	mov    $0x44635,%edi
   42b56:	e8 8a f9 ff ff       	call   424e5 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   42b5b:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42b5e:	48 98                	cltq   
   42b60:	83 e0 04             	and    $0x4,%eax
   42b63:	48 85 c0             	test   %rax,%rax
   42b66:	74 20                	je     42b88 <lookup_l1pagetable+0x138>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   42b68:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b6c:	83 e0 04             	and    $0x4,%eax
   42b6f:	48 85 c0             	test   %rax,%rax
   42b72:	75 14                	jne    42b88 <lookup_l1pagetable+0x138>
   42b74:	ba 13 4a 04 00       	mov    $0x44a13,%edx
   42b79:	be b9 00 00 00       	mov    $0xb9,%esi
   42b7e:	bf 35 46 04 00       	mov    $0x44635,%edi
   42b83:	e8 5d f9 ff ff       	call   424e5 <assert_fail>
        }

        // TODO --> done
        // set pt to physical address to next pagetable using `pe`
        pt = (x86_64_pagetable *) PTE_ADDR(pe); // replace this
   42b88:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b8c:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42b92:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   42b96:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   42b9a:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   42b9e:	0f 8e d3 fe ff ff    	jle    42a77 <lookup_l1pagetable+0x27>
    }
    return pt;
   42ba4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   42ba8:	c9                   	leave  
   42ba9:	c3                   	ret    

0000000000042baa <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   42baa:	55                   	push   %rbp
   42bab:	48 89 e5             	mov    %rsp,%rbp
   42bae:	48 83 ec 50          	sub    $0x50,%rsp
   42bb2:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42bb6:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42bba:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   42bbe:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42bc2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   42bc6:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   42bcd:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42bce:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   42bd5:	eb 41                	jmp    42c18 <virtual_memory_lookup+0x6e>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   42bd7:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42bda:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42bde:	89 d6                	mov    %edx,%esi
   42be0:	48 89 c7             	mov    %rax,%rdi
   42be3:	e8 62 f9 ff ff       	call   4254a <pageindex>
   42be8:	89 c2                	mov    %eax,%edx
   42bea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42bee:	48 63 d2             	movslq %edx,%rdx
   42bf1:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   42bf5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42bf9:	83 e0 06             	and    $0x6,%eax
   42bfc:	48 f7 d0             	not    %rax
   42bff:	48 21 d0             	and    %rdx,%rax
   42c02:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42c06:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c0a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42c10:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42c14:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   42c18:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   42c1c:	7f 0c                	jg     42c2a <virtual_memory_lookup+0x80>
   42c1e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c22:	83 e0 01             	and    $0x1,%eax
   42c25:	48 85 c0             	test   %rax,%rax
   42c28:	75 ad                	jne    42bd7 <virtual_memory_lookup+0x2d>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   42c2a:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   42c31:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   42c38:	ff 
   42c39:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   42c40:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c44:	83 e0 01             	and    $0x1,%eax
   42c47:	48 85 c0             	test   %rax,%rax
   42c4a:	74 34                	je     42c80 <virtual_memory_lookup+0xd6>
        vam.pn = PAGENUMBER(pe);
   42c4c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c50:	48 c1 e8 0c          	shr    $0xc,%rax
   42c54:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   42c57:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c5b:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42c61:	48 89 c2             	mov    %rax,%rdx
   42c64:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42c68:	25 ff 0f 00 00       	and    $0xfff,%eax
   42c6d:	48 09 d0             	or     %rdx,%rax
   42c70:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   42c74:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c78:	25 ff 0f 00 00       	and    $0xfff,%eax
   42c7d:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   42c80:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42c84:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42c88:	48 89 10             	mov    %rdx,(%rax)
   42c8b:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   42c8f:	48 89 50 08          	mov    %rdx,0x8(%rax)
   42c93:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42c97:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   42c9b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42c9f:	c9                   	leave  
   42ca0:	c3                   	ret    

0000000000042ca1 <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   42ca1:	55                   	push   %rbp
   42ca2:	48 89 e5             	mov    %rsp,%rbp
   42ca5:	48 83 ec 40          	sub    $0x40,%rsp
   42ca9:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42cad:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   42cb0:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   42cb4:	c7 45 f8 07 00 00 00 	movl   $0x7,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   42cbb:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   42cbf:	78 08                	js     42cc9 <program_load+0x28>
   42cc1:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42cc4:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   42cc7:	7c 14                	jl     42cdd <program_load+0x3c>
   42cc9:	ba 20 4a 04 00       	mov    $0x44a20,%edx
   42cce:	be 37 00 00 00       	mov    $0x37,%esi
   42cd3:	bf 50 4a 04 00       	mov    $0x44a50,%edi
   42cd8:	e8 08 f8 ff ff       	call   424e5 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   42cdd:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42ce0:	48 98                	cltq   
   42ce2:	48 c1 e0 04          	shl    $0x4,%rax
   42ce6:	48 05 20 50 04 00    	add    $0x45020,%rax
   42cec:	48 8b 00             	mov    (%rax),%rax
   42cef:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   42cf3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42cf7:	8b 00                	mov    (%rax),%eax
   42cf9:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   42cfe:	74 14                	je     42d14 <program_load+0x73>
   42d00:	ba 62 4a 04 00       	mov    $0x44a62,%edx
   42d05:	be 39 00 00 00       	mov    $0x39,%esi
   42d0a:	bf 50 4a 04 00       	mov    $0x44a50,%edi
   42d0f:	e8 d1 f7 ff ff       	call   424e5 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   42d14:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d18:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42d1c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d20:	48 01 d0             	add    %rdx,%rax
   42d23:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   42d27:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42d2e:	e9 94 00 00 00       	jmp    42dc7 <program_load+0x126>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   42d33:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42d36:	48 63 d0             	movslq %eax,%rdx
   42d39:	48 89 d0             	mov    %rdx,%rax
   42d3c:	48 c1 e0 03          	shl    $0x3,%rax
   42d40:	48 29 d0             	sub    %rdx,%rax
   42d43:	48 c1 e0 03          	shl    $0x3,%rax
   42d47:	48 89 c2             	mov    %rax,%rdx
   42d4a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d4e:	48 01 d0             	add    %rdx,%rax
   42d51:	8b 00                	mov    (%rax),%eax
   42d53:	83 f8 01             	cmp    $0x1,%eax
   42d56:	75 6b                	jne    42dc3 <program_load+0x122>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   42d58:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42d5b:	48 63 d0             	movslq %eax,%rdx
   42d5e:	48 89 d0             	mov    %rdx,%rax
   42d61:	48 c1 e0 03          	shl    $0x3,%rax
   42d65:	48 29 d0             	sub    %rdx,%rax
   42d68:	48 c1 e0 03          	shl    $0x3,%rax
   42d6c:	48 89 c2             	mov    %rax,%rdx
   42d6f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d73:	48 01 d0             	add    %rdx,%rax
   42d76:	48 8b 50 08          	mov    0x8(%rax),%rdx
   42d7a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d7e:	48 01 d0             	add    %rdx,%rax
   42d81:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   42d85:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42d88:	48 63 d0             	movslq %eax,%rdx
   42d8b:	48 89 d0             	mov    %rdx,%rax
   42d8e:	48 c1 e0 03          	shl    $0x3,%rax
   42d92:	48 29 d0             	sub    %rdx,%rax
   42d95:	48 c1 e0 03          	shl    $0x3,%rax
   42d99:	48 89 c2             	mov    %rax,%rdx
   42d9c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42da0:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   42da4:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42da8:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42dac:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42db0:	48 89 c7             	mov    %rax,%rdi
   42db3:	e8 3d 00 00 00       	call   42df5 <program_load_segment>
   42db8:	85 c0                	test   %eax,%eax
   42dba:	79 07                	jns    42dc3 <program_load+0x122>
                return -1;
   42dbc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42dc1:	eb 30                	jmp    42df3 <program_load+0x152>
    for (int i = 0; i < eh->e_phnum; ++i) {
   42dc3:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   42dc7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42dcb:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   42dcf:	0f b7 c0             	movzwl %ax,%eax
   42dd2:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   42dd5:	0f 8c 58 ff ff ff    	jl     42d33 <program_load+0x92>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   42ddb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ddf:	48 8b 50 18          	mov    0x18(%rax),%rdx
   42de3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42de7:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    return 0;
   42dee:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42df3:	c9                   	leave  
   42df4:	c3                   	ret    

0000000000042df5 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   42df5:	55                   	push   %rbp
   42df6:	48 89 e5             	mov    %rsp,%rbp
   42df9:	48 83 ec 40          	sub    $0x40,%rsp
   42dfd:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42e01:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42e05:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   42e09:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   42e0d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42e11:	48 8b 40 10          	mov    0x10(%rax),%rax
   42e15:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   42e19:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42e1d:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42e21:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e25:	48 01 d0             	add    %rdx,%rax
   42e28:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42e2c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42e30:	48 8b 50 28          	mov    0x28(%rax),%rdx
   42e34:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e38:	48 01 d0             	add    %rdx,%rax
   42e3b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   42e3f:	48 81 65 f0 00 f0 ff 	andq   $0xfffffffffffff000,-0x10(%rbp)
   42e46:	ff 

    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42e47:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e4b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   42e4f:	eb 7c                	jmp    42ecd <program_load_segment+0xd8>
        if (assign_physical_page(addr, p->p_pid) < 0
   42e51:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e55:	8b 00                	mov    (%rax),%eax
   42e57:	0f be d0             	movsbl %al,%edx
   42e5a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42e5e:	89 d6                	mov    %edx,%esi
   42e60:	48 89 c7             	mov    %rax,%rdi
   42e63:	e8 9e d7 ff ff       	call   40606 <assign_physical_page>
   42e68:	85 c0                	test   %eax,%eax
   42e6a:	78 2a                	js     42e96 <program_load_segment+0xa1>
            || virtual_memory_map(p->p_pagetable, addr, addr, PAGESIZE,
   42e6c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e70:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   42e77:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42e7b:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   42e7f:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42e85:	b9 00 10 00 00       	mov    $0x1000,%ecx
   42e8a:	48 89 c7             	mov    %rax,%rdi
   42e8d:	e8 52 f9 ff ff       	call   427e4 <virtual_memory_map>
   42e92:	85 c0                	test   %eax,%eax
   42e94:	79 2f                	jns    42ec5 <program_load_segment+0xd0>
                                  PTE_P | PTE_W | PTE_U) < 0) {
            console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   42e96:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e9a:	8b 00                	mov    (%rax),%eax
   42e9c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42ea0:	49 89 d0             	mov    %rdx,%r8
   42ea3:	89 c1                	mov    %eax,%ecx
   42ea5:	ba 80 4a 04 00       	mov    $0x44a80,%edx
   42eaa:	be 00 c0 00 00       	mov    $0xc000,%esi
   42eaf:	bf e0 06 00 00       	mov    $0x6e0,%edi
   42eb4:	b8 00 00 00 00       	mov    $0x0,%eax
   42eb9:	e8 35 0f 00 00       	call   43df3 <console_printf>
            return -1;
   42ebe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42ec3:	eb 77                	jmp    42f3c <program_load_segment+0x147>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42ec5:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42ecc:	00 
   42ecd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42ed1:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   42ed5:	0f 82 76 ff ff ff    	jb     42e51 <program_load_segment+0x5c>
        }
    }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   42edb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42edf:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   42ee6:	48 89 c7             	mov    %rax,%rdi
   42ee9:	e8 c5 f7 ff ff       	call   426b3 <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   42eee:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ef2:	48 2b 45 f0          	sub    -0x10(%rbp),%rax
   42ef6:	48 89 c2             	mov    %rax,%rdx
   42ef9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42efd:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42f01:	48 89 ce             	mov    %rcx,%rsi
   42f04:	48 89 c7             	mov    %rax,%rdi
   42f07:	e8 32 00 00 00       	call   42f3e <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   42f0c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42f10:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   42f14:	48 89 c2             	mov    %rax,%rdx
   42f17:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f1b:	be 00 00 00 00       	mov    $0x0,%esi
   42f20:	48 89 c7             	mov    %rax,%rdi
   42f23:	e8 14 01 00 00       	call   4303c <memset>

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   42f28:	48 8b 05 d1 10 01 00 	mov    0x110d1(%rip),%rax        # 54000 <kernel_pagetable>
   42f2f:	48 89 c7             	mov    %rax,%rdi
   42f32:	e8 7c f7 ff ff       	call   426b3 <set_pagetable>
    return 0;
   42f37:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42f3c:	c9                   	leave  
   42f3d:	c3                   	ret    

0000000000042f3e <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   42f3e:	55                   	push   %rbp
   42f3f:	48 89 e5             	mov    %rsp,%rbp
   42f42:	48 83 ec 28          	sub    $0x28,%rsp
   42f46:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42f4a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   42f4e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   42f52:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42f56:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   42f5a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f5e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   42f62:	eb 1c                	jmp    42f80 <memcpy+0x42>
        *d = *s;
   42f64:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42f68:	0f b6 10             	movzbl (%rax),%edx
   42f6b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42f6f:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   42f71:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   42f76:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   42f7b:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   42f80:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   42f85:	75 dd                	jne    42f64 <memcpy+0x26>
    }
    return dst;
   42f87:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   42f8b:	c9                   	leave  
   42f8c:	c3                   	ret    

0000000000042f8d <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   42f8d:	55                   	push   %rbp
   42f8e:	48 89 e5             	mov    %rsp,%rbp
   42f91:	48 83 ec 28          	sub    $0x28,%rsp
   42f95:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42f99:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   42f9d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   42fa1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42fa5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   42fa9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42fad:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   42fb1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42fb5:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   42fb9:	73 6a                	jae    43025 <memmove+0x98>
   42fbb:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42fbf:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42fc3:	48 01 d0             	add    %rdx,%rax
   42fc6:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   42fca:	73 59                	jae    43025 <memmove+0x98>
        s += n, d += n;
   42fcc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42fd0:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   42fd4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42fd8:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   42fdc:	eb 17                	jmp    42ff5 <memmove+0x68>
            *--d = *--s;
   42fde:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   42fe3:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   42fe8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42fec:	0f b6 10             	movzbl (%rax),%edx
   42fef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ff3:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   42ff5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42ff9:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   42ffd:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43001:	48 85 c0             	test   %rax,%rax
   43004:	75 d8                	jne    42fde <memmove+0x51>
    if (s < d && s + n > d) {
   43006:	eb 2e                	jmp    43036 <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   43008:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4300c:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43010:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43014:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43018:	48 8d 48 01          	lea    0x1(%rax),%rcx
   4301c:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   43020:	0f b6 12             	movzbl (%rdx),%edx
   43023:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43025:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43029:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   4302d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43031:	48 85 c0             	test   %rax,%rax
   43034:	75 d2                	jne    43008 <memmove+0x7b>
        }
    }
    return dst;
   43036:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   4303a:	c9                   	leave  
   4303b:	c3                   	ret    

000000000004303c <memset>:

void* memset(void* v, int c, size_t n) {
   4303c:	55                   	push   %rbp
   4303d:	48 89 e5             	mov    %rsp,%rbp
   43040:	48 83 ec 28          	sub    $0x28,%rsp
   43044:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43048:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   4304b:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   4304f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43053:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43057:	eb 15                	jmp    4306e <memset+0x32>
        *p = c;
   43059:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4305c:	89 c2                	mov    %eax,%edx
   4305e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43062:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43064:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43069:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   4306e:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43073:	75 e4                	jne    43059 <memset+0x1d>
    }
    return v;
   43075:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43079:	c9                   	leave  
   4307a:	c3                   	ret    

000000000004307b <strlen>:

size_t strlen(const char* s) {
   4307b:	55                   	push   %rbp
   4307c:	48 89 e5             	mov    %rsp,%rbp
   4307f:	48 83 ec 18          	sub    $0x18,%rsp
   43083:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   43087:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   4308e:	00 
   4308f:	eb 0a                	jmp    4309b <strlen+0x20>
        ++n;
   43091:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   43096:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   4309b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4309f:	0f b6 00             	movzbl (%rax),%eax
   430a2:	84 c0                	test   %al,%al
   430a4:	75 eb                	jne    43091 <strlen+0x16>
    }
    return n;
   430a6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   430aa:	c9                   	leave  
   430ab:	c3                   	ret    

00000000000430ac <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   430ac:	55                   	push   %rbp
   430ad:	48 89 e5             	mov    %rsp,%rbp
   430b0:	48 83 ec 20          	sub    $0x20,%rsp
   430b4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   430b8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   430bc:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   430c3:	00 
   430c4:	eb 0a                	jmp    430d0 <strnlen+0x24>
        ++n;
   430c6:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   430cb:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   430d0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   430d4:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   430d8:	74 0b                	je     430e5 <strnlen+0x39>
   430da:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   430de:	0f b6 00             	movzbl (%rax),%eax
   430e1:	84 c0                	test   %al,%al
   430e3:	75 e1                	jne    430c6 <strnlen+0x1a>
    }
    return n;
   430e5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   430e9:	c9                   	leave  
   430ea:	c3                   	ret    

00000000000430eb <strcpy>:

char* strcpy(char* dst, const char* src) {
   430eb:	55                   	push   %rbp
   430ec:	48 89 e5             	mov    %rsp,%rbp
   430ef:	48 83 ec 20          	sub    $0x20,%rsp
   430f3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   430f7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   430fb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   430ff:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   43103:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43107:	48 8d 42 01          	lea    0x1(%rdx),%rax
   4310b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   4310f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43113:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43117:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   4311b:	0f b6 12             	movzbl (%rdx),%edx
   4311e:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   43120:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43124:	48 83 e8 01          	sub    $0x1,%rax
   43128:	0f b6 00             	movzbl (%rax),%eax
   4312b:	84 c0                	test   %al,%al
   4312d:	75 d4                	jne    43103 <strcpy+0x18>
    return dst;
   4312f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43133:	c9                   	leave  
   43134:	c3                   	ret    

0000000000043135 <strcmp>:

int strcmp(const char* a, const char* b) {
   43135:	55                   	push   %rbp
   43136:	48 89 e5             	mov    %rsp,%rbp
   43139:	48 83 ec 10          	sub    $0x10,%rsp
   4313d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43141:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43145:	eb 0a                	jmp    43151 <strcmp+0x1c>
        ++a, ++b;
   43147:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   4314c:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43151:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43155:	0f b6 00             	movzbl (%rax),%eax
   43158:	84 c0                	test   %al,%al
   4315a:	74 1d                	je     43179 <strcmp+0x44>
   4315c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43160:	0f b6 00             	movzbl (%rax),%eax
   43163:	84 c0                	test   %al,%al
   43165:	74 12                	je     43179 <strcmp+0x44>
   43167:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4316b:	0f b6 10             	movzbl (%rax),%edx
   4316e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43172:	0f b6 00             	movzbl (%rax),%eax
   43175:	38 c2                	cmp    %al,%dl
   43177:	74 ce                	je     43147 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   43179:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4317d:	0f b6 00             	movzbl (%rax),%eax
   43180:	89 c2                	mov    %eax,%edx
   43182:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43186:	0f b6 00             	movzbl (%rax),%eax
   43189:	38 d0                	cmp    %dl,%al
   4318b:	0f 92 c0             	setb   %al
   4318e:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   43191:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43195:	0f b6 00             	movzbl (%rax),%eax
   43198:	89 c1                	mov    %eax,%ecx
   4319a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4319e:	0f b6 00             	movzbl (%rax),%eax
   431a1:	38 c1                	cmp    %al,%cl
   431a3:	0f 92 c0             	setb   %al
   431a6:	0f b6 c0             	movzbl %al,%eax
   431a9:	29 c2                	sub    %eax,%edx
   431ab:	89 d0                	mov    %edx,%eax
}
   431ad:	c9                   	leave  
   431ae:	c3                   	ret    

00000000000431af <strchr>:

char* strchr(const char* s, int c) {
   431af:	55                   	push   %rbp
   431b0:	48 89 e5             	mov    %rsp,%rbp
   431b3:	48 83 ec 10          	sub    $0x10,%rsp
   431b7:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   431bb:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   431be:	eb 05                	jmp    431c5 <strchr+0x16>
        ++s;
   431c0:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   431c5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   431c9:	0f b6 00             	movzbl (%rax),%eax
   431cc:	84 c0                	test   %al,%al
   431ce:	74 0e                	je     431de <strchr+0x2f>
   431d0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   431d4:	0f b6 00             	movzbl (%rax),%eax
   431d7:	8b 55 f4             	mov    -0xc(%rbp),%edx
   431da:	38 d0                	cmp    %dl,%al
   431dc:	75 e2                	jne    431c0 <strchr+0x11>
    }
    if (*s == (char) c) {
   431de:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   431e2:	0f b6 00             	movzbl (%rax),%eax
   431e5:	8b 55 f4             	mov    -0xc(%rbp),%edx
   431e8:	38 d0                	cmp    %dl,%al
   431ea:	75 06                	jne    431f2 <strchr+0x43>
        return (char*) s;
   431ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   431f0:	eb 05                	jmp    431f7 <strchr+0x48>
    } else {
        return NULL;
   431f2:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   431f7:	c9                   	leave  
   431f8:	c3                   	ret    

00000000000431f9 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   431f9:	55                   	push   %rbp
   431fa:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   431fd:	8b 05 fd 6d 01 00    	mov    0x16dfd(%rip),%eax        # 5a000 <rand_seed_set>
   43203:	85 c0                	test   %eax,%eax
   43205:	75 0a                	jne    43211 <rand+0x18>
        srand(819234718U);
   43207:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   4320c:	e8 24 00 00 00       	call   43235 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   43211:	8b 05 ed 6d 01 00    	mov    0x16ded(%rip),%eax        # 5a004 <rand_seed>
   43217:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   4321d:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   43222:	89 05 dc 6d 01 00    	mov    %eax,0x16ddc(%rip)        # 5a004 <rand_seed>
    return rand_seed & RAND_MAX;
   43228:	8b 05 d6 6d 01 00    	mov    0x16dd6(%rip),%eax        # 5a004 <rand_seed>
   4322e:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   43233:	5d                   	pop    %rbp
   43234:	c3                   	ret    

0000000000043235 <srand>:

void srand(unsigned seed) {
   43235:	55                   	push   %rbp
   43236:	48 89 e5             	mov    %rsp,%rbp
   43239:	48 83 ec 08          	sub    $0x8,%rsp
   4323d:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   43240:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43243:	89 05 bb 6d 01 00    	mov    %eax,0x16dbb(%rip)        # 5a004 <rand_seed>
    rand_seed_set = 1;
   43249:	c7 05 ad 6d 01 00 01 	movl   $0x1,0x16dad(%rip)        # 5a000 <rand_seed_set>
   43250:	00 00 00 
}
   43253:	90                   	nop
   43254:	c9                   	leave  
   43255:	c3                   	ret    

0000000000043256 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   43256:	55                   	push   %rbp
   43257:	48 89 e5             	mov    %rsp,%rbp
   4325a:	48 83 ec 28          	sub    $0x28,%rsp
   4325e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43262:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43266:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   43269:	48 c7 45 f8 a0 4c 04 	movq   $0x44ca0,-0x8(%rbp)
   43270:	00 
    if (base < 0) {
   43271:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   43275:	79 0b                	jns    43282 <fill_numbuf+0x2c>
        digits = lower_digits;
   43277:	48 c7 45 f8 c0 4c 04 	movq   $0x44cc0,-0x8(%rbp)
   4327e:	00 
        base = -base;
   4327f:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   43282:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43287:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4328b:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   4328e:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43291:	48 63 c8             	movslq %eax,%rcx
   43294:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43298:	ba 00 00 00 00       	mov    $0x0,%edx
   4329d:	48 f7 f1             	div    %rcx
   432a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   432a4:	48 01 d0             	add    %rdx,%rax
   432a7:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   432ac:	0f b6 10             	movzbl (%rax),%edx
   432af:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   432b3:	88 10                	mov    %dl,(%rax)
        val /= base;
   432b5:	8b 45 dc             	mov    -0x24(%rbp),%eax
   432b8:	48 63 f0             	movslq %eax,%rsi
   432bb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   432bf:	ba 00 00 00 00       	mov    $0x0,%edx
   432c4:	48 f7 f6             	div    %rsi
   432c7:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   432cb:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   432d0:	75 bc                	jne    4328e <fill_numbuf+0x38>
    return numbuf_end;
   432d2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   432d6:	c9                   	leave  
   432d7:	c3                   	ret    

00000000000432d8 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   432d8:	55                   	push   %rbp
   432d9:	48 89 e5             	mov    %rsp,%rbp
   432dc:	53                   	push   %rbx
   432dd:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   432e4:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   432eb:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   432f1:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   432f8:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   432ff:	e9 8a 09 00 00       	jmp    43c8e <printer_vprintf+0x9b6>
        if (*format != '%') {
   43304:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4330b:	0f b6 00             	movzbl (%rax),%eax
   4330e:	3c 25                	cmp    $0x25,%al
   43310:	74 31                	je     43343 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
   43312:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43319:	4c 8b 00             	mov    (%rax),%r8
   4331c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43323:	0f b6 00             	movzbl (%rax),%eax
   43326:	0f b6 c8             	movzbl %al,%ecx
   43329:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   4332f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43336:	89 ce                	mov    %ecx,%esi
   43338:	48 89 c7             	mov    %rax,%rdi
   4333b:	41 ff d0             	call   *%r8
            continue;
   4333e:	e9 43 09 00 00       	jmp    43c86 <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
   43343:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   4334a:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43351:	01 
   43352:	eb 44                	jmp    43398 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
   43354:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4335b:	0f b6 00             	movzbl (%rax),%eax
   4335e:	0f be c0             	movsbl %al,%eax
   43361:	89 c6                	mov    %eax,%esi
   43363:	bf c0 4a 04 00       	mov    $0x44ac0,%edi
   43368:	e8 42 fe ff ff       	call   431af <strchr>
   4336d:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   43371:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   43376:	74 30                	je     433a8 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
   43378:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   4337c:	48 2d c0 4a 04 00    	sub    $0x44ac0,%rax
   43382:	ba 01 00 00 00       	mov    $0x1,%edx
   43387:	89 c1                	mov    %eax,%ecx
   43389:	d3 e2                	shl    %cl,%edx
   4338b:	89 d0                	mov    %edx,%eax
   4338d:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   43390:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43397:	01 
   43398:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4339f:	0f b6 00             	movzbl (%rax),%eax
   433a2:	84 c0                	test   %al,%al
   433a4:	75 ae                	jne    43354 <printer_vprintf+0x7c>
   433a6:	eb 01                	jmp    433a9 <printer_vprintf+0xd1>
            } else {
                break;
   433a8:	90                   	nop
            }
        }

        // process width
        int width = -1;
   433a9:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   433b0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   433b7:	0f b6 00             	movzbl (%rax),%eax
   433ba:	3c 30                	cmp    $0x30,%al
   433bc:	7e 67                	jle    43425 <printer_vprintf+0x14d>
   433be:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   433c5:	0f b6 00             	movzbl (%rax),%eax
   433c8:	3c 39                	cmp    $0x39,%al
   433ca:	7f 59                	jg     43425 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   433cc:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   433d3:	eb 2e                	jmp    43403 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
   433d5:	8b 55 e8             	mov    -0x18(%rbp),%edx
   433d8:	89 d0                	mov    %edx,%eax
   433da:	c1 e0 02             	shl    $0x2,%eax
   433dd:	01 d0                	add    %edx,%eax
   433df:	01 c0                	add    %eax,%eax
   433e1:	89 c1                	mov    %eax,%ecx
   433e3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   433ea:	48 8d 50 01          	lea    0x1(%rax),%rdx
   433ee:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   433f5:	0f b6 00             	movzbl (%rax),%eax
   433f8:	0f be c0             	movsbl %al,%eax
   433fb:	01 c8                	add    %ecx,%eax
   433fd:	83 e8 30             	sub    $0x30,%eax
   43400:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43403:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4340a:	0f b6 00             	movzbl (%rax),%eax
   4340d:	3c 2f                	cmp    $0x2f,%al
   4340f:	0f 8e 85 00 00 00    	jle    4349a <printer_vprintf+0x1c2>
   43415:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4341c:	0f b6 00             	movzbl (%rax),%eax
   4341f:	3c 39                	cmp    $0x39,%al
   43421:	7e b2                	jle    433d5 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
   43423:	eb 75                	jmp    4349a <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
   43425:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4342c:	0f b6 00             	movzbl (%rax),%eax
   4342f:	3c 2a                	cmp    $0x2a,%al
   43431:	75 68                	jne    4349b <printer_vprintf+0x1c3>
            width = va_arg(val, int);
   43433:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4343a:	8b 00                	mov    (%rax),%eax
   4343c:	83 f8 2f             	cmp    $0x2f,%eax
   4343f:	77 30                	ja     43471 <printer_vprintf+0x199>
   43441:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43448:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4344c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43453:	8b 00                	mov    (%rax),%eax
   43455:	89 c0                	mov    %eax,%eax
   43457:	48 01 d0             	add    %rdx,%rax
   4345a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43461:	8b 12                	mov    (%rdx),%edx
   43463:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43466:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4346d:	89 0a                	mov    %ecx,(%rdx)
   4346f:	eb 1a                	jmp    4348b <printer_vprintf+0x1b3>
   43471:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43478:	48 8b 40 08          	mov    0x8(%rax),%rax
   4347c:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43480:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43487:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4348b:	8b 00                	mov    (%rax),%eax
   4348d:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   43490:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43497:	01 
   43498:	eb 01                	jmp    4349b <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
   4349a:	90                   	nop
        }

        // process precision
        int precision = -1;
   4349b:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   434a2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   434a9:	0f b6 00             	movzbl (%rax),%eax
   434ac:	3c 2e                	cmp    $0x2e,%al
   434ae:	0f 85 00 01 00 00    	jne    435b4 <printer_vprintf+0x2dc>
            ++format;
   434b4:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   434bb:	01 
            if (*format >= '0' && *format <= '9') {
   434bc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   434c3:	0f b6 00             	movzbl (%rax),%eax
   434c6:	3c 2f                	cmp    $0x2f,%al
   434c8:	7e 67                	jle    43531 <printer_vprintf+0x259>
   434ca:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   434d1:	0f b6 00             	movzbl (%rax),%eax
   434d4:	3c 39                	cmp    $0x39,%al
   434d6:	7f 59                	jg     43531 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   434d8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   434df:	eb 2e                	jmp    4350f <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
   434e1:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   434e4:	89 d0                	mov    %edx,%eax
   434e6:	c1 e0 02             	shl    $0x2,%eax
   434e9:	01 d0                	add    %edx,%eax
   434eb:	01 c0                	add    %eax,%eax
   434ed:	89 c1                	mov    %eax,%ecx
   434ef:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   434f6:	48 8d 50 01          	lea    0x1(%rax),%rdx
   434fa:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43501:	0f b6 00             	movzbl (%rax),%eax
   43504:	0f be c0             	movsbl %al,%eax
   43507:	01 c8                	add    %ecx,%eax
   43509:	83 e8 30             	sub    $0x30,%eax
   4350c:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   4350f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43516:	0f b6 00             	movzbl (%rax),%eax
   43519:	3c 2f                	cmp    $0x2f,%al
   4351b:	0f 8e 85 00 00 00    	jle    435a6 <printer_vprintf+0x2ce>
   43521:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43528:	0f b6 00             	movzbl (%rax),%eax
   4352b:	3c 39                	cmp    $0x39,%al
   4352d:	7e b2                	jle    434e1 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
   4352f:	eb 75                	jmp    435a6 <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
   43531:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43538:	0f b6 00             	movzbl (%rax),%eax
   4353b:	3c 2a                	cmp    $0x2a,%al
   4353d:	75 68                	jne    435a7 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
   4353f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43546:	8b 00                	mov    (%rax),%eax
   43548:	83 f8 2f             	cmp    $0x2f,%eax
   4354b:	77 30                	ja     4357d <printer_vprintf+0x2a5>
   4354d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43554:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43558:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4355f:	8b 00                	mov    (%rax),%eax
   43561:	89 c0                	mov    %eax,%eax
   43563:	48 01 d0             	add    %rdx,%rax
   43566:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4356d:	8b 12                	mov    (%rdx),%edx
   4356f:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43572:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43579:	89 0a                	mov    %ecx,(%rdx)
   4357b:	eb 1a                	jmp    43597 <printer_vprintf+0x2bf>
   4357d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43584:	48 8b 40 08          	mov    0x8(%rax),%rax
   43588:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4358c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43593:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43597:	8b 00                	mov    (%rax),%eax
   43599:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   4359c:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   435a3:	01 
   435a4:	eb 01                	jmp    435a7 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
   435a6:	90                   	nop
            }
            if (precision < 0) {
   435a7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   435ab:	79 07                	jns    435b4 <printer_vprintf+0x2dc>
                precision = 0;
   435ad:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   435b4:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   435bb:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   435c2:	00 
        int length = 0;
   435c3:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   435ca:	48 c7 45 c8 c6 4a 04 	movq   $0x44ac6,-0x38(%rbp)
   435d1:	00 
    again:
        switch (*format) {
   435d2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   435d9:	0f b6 00             	movzbl (%rax),%eax
   435dc:	0f be c0             	movsbl %al,%eax
   435df:	83 e8 43             	sub    $0x43,%eax
   435e2:	83 f8 37             	cmp    $0x37,%eax
   435e5:	0f 87 9f 03 00 00    	ja     4398a <printer_vprintf+0x6b2>
   435eb:	89 c0                	mov    %eax,%eax
   435ed:	48 8b 04 c5 d8 4a 04 	mov    0x44ad8(,%rax,8),%rax
   435f4:	00 
   435f5:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
   435f7:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   435fe:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43605:	01 
            goto again;
   43606:	eb ca                	jmp    435d2 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   43608:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   4360c:	74 5d                	je     4366b <printer_vprintf+0x393>
   4360e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43615:	8b 00                	mov    (%rax),%eax
   43617:	83 f8 2f             	cmp    $0x2f,%eax
   4361a:	77 30                	ja     4364c <printer_vprintf+0x374>
   4361c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43623:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43627:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4362e:	8b 00                	mov    (%rax),%eax
   43630:	89 c0                	mov    %eax,%eax
   43632:	48 01 d0             	add    %rdx,%rax
   43635:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4363c:	8b 12                	mov    (%rdx),%edx
   4363e:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43641:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43648:	89 0a                	mov    %ecx,(%rdx)
   4364a:	eb 1a                	jmp    43666 <printer_vprintf+0x38e>
   4364c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43653:	48 8b 40 08          	mov    0x8(%rax),%rax
   43657:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4365b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43662:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43666:	48 8b 00             	mov    (%rax),%rax
   43669:	eb 5c                	jmp    436c7 <printer_vprintf+0x3ef>
   4366b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43672:	8b 00                	mov    (%rax),%eax
   43674:	83 f8 2f             	cmp    $0x2f,%eax
   43677:	77 30                	ja     436a9 <printer_vprintf+0x3d1>
   43679:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43680:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43684:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4368b:	8b 00                	mov    (%rax),%eax
   4368d:	89 c0                	mov    %eax,%eax
   4368f:	48 01 d0             	add    %rdx,%rax
   43692:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43699:	8b 12                	mov    (%rdx),%edx
   4369b:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4369e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   436a5:	89 0a                	mov    %ecx,(%rdx)
   436a7:	eb 1a                	jmp    436c3 <printer_vprintf+0x3eb>
   436a9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   436b0:	48 8b 40 08          	mov    0x8(%rax),%rax
   436b4:	48 8d 48 08          	lea    0x8(%rax),%rcx
   436b8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   436bf:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   436c3:	8b 00                	mov    (%rax),%eax
   436c5:	48 98                	cltq   
   436c7:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   436cb:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   436cf:	48 c1 f8 38          	sar    $0x38,%rax
   436d3:	25 80 00 00 00       	and    $0x80,%eax
   436d8:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   436db:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   436df:	74 09                	je     436ea <printer_vprintf+0x412>
   436e1:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   436e5:	48 f7 d8             	neg    %rax
   436e8:	eb 04                	jmp    436ee <printer_vprintf+0x416>
   436ea:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   436ee:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   436f2:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   436f5:	83 c8 60             	or     $0x60,%eax
   436f8:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   436fb:	e9 cf 02 00 00       	jmp    439cf <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   43700:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43704:	74 5d                	je     43763 <printer_vprintf+0x48b>
   43706:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4370d:	8b 00                	mov    (%rax),%eax
   4370f:	83 f8 2f             	cmp    $0x2f,%eax
   43712:	77 30                	ja     43744 <printer_vprintf+0x46c>
   43714:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4371b:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4371f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43726:	8b 00                	mov    (%rax),%eax
   43728:	89 c0                	mov    %eax,%eax
   4372a:	48 01 d0             	add    %rdx,%rax
   4372d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43734:	8b 12                	mov    (%rdx),%edx
   43736:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43739:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43740:	89 0a                	mov    %ecx,(%rdx)
   43742:	eb 1a                	jmp    4375e <printer_vprintf+0x486>
   43744:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4374b:	48 8b 40 08          	mov    0x8(%rax),%rax
   4374f:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43753:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4375a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4375e:	48 8b 00             	mov    (%rax),%rax
   43761:	eb 5c                	jmp    437bf <printer_vprintf+0x4e7>
   43763:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4376a:	8b 00                	mov    (%rax),%eax
   4376c:	83 f8 2f             	cmp    $0x2f,%eax
   4376f:	77 30                	ja     437a1 <printer_vprintf+0x4c9>
   43771:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43778:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4377c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43783:	8b 00                	mov    (%rax),%eax
   43785:	89 c0                	mov    %eax,%eax
   43787:	48 01 d0             	add    %rdx,%rax
   4378a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43791:	8b 12                	mov    (%rdx),%edx
   43793:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43796:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4379d:	89 0a                	mov    %ecx,(%rdx)
   4379f:	eb 1a                	jmp    437bb <printer_vprintf+0x4e3>
   437a1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   437a8:	48 8b 40 08          	mov    0x8(%rax),%rax
   437ac:	48 8d 48 08          	lea    0x8(%rax),%rcx
   437b0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   437b7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   437bb:	8b 00                	mov    (%rax),%eax
   437bd:	89 c0                	mov    %eax,%eax
   437bf:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   437c3:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   437c7:	e9 03 02 00 00       	jmp    439cf <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
   437cc:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   437d3:	e9 28 ff ff ff       	jmp    43700 <printer_vprintf+0x428>
        case 'X':
            base = 16;
   437d8:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   437df:	e9 1c ff ff ff       	jmp    43700 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   437e4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   437eb:	8b 00                	mov    (%rax),%eax
   437ed:	83 f8 2f             	cmp    $0x2f,%eax
   437f0:	77 30                	ja     43822 <printer_vprintf+0x54a>
   437f2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   437f9:	48 8b 50 10          	mov    0x10(%rax),%rdx
   437fd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43804:	8b 00                	mov    (%rax),%eax
   43806:	89 c0                	mov    %eax,%eax
   43808:	48 01 d0             	add    %rdx,%rax
   4380b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43812:	8b 12                	mov    (%rdx),%edx
   43814:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43817:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4381e:	89 0a                	mov    %ecx,(%rdx)
   43820:	eb 1a                	jmp    4383c <printer_vprintf+0x564>
   43822:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43829:	48 8b 40 08          	mov    0x8(%rax),%rax
   4382d:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43831:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43838:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4383c:	48 8b 00             	mov    (%rax),%rax
   4383f:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   43843:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   4384a:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   43851:	e9 79 01 00 00       	jmp    439cf <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
   43856:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4385d:	8b 00                	mov    (%rax),%eax
   4385f:	83 f8 2f             	cmp    $0x2f,%eax
   43862:	77 30                	ja     43894 <printer_vprintf+0x5bc>
   43864:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4386b:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4386f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43876:	8b 00                	mov    (%rax),%eax
   43878:	89 c0                	mov    %eax,%eax
   4387a:	48 01 d0             	add    %rdx,%rax
   4387d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43884:	8b 12                	mov    (%rdx),%edx
   43886:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43889:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43890:	89 0a                	mov    %ecx,(%rdx)
   43892:	eb 1a                	jmp    438ae <printer_vprintf+0x5d6>
   43894:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4389b:	48 8b 40 08          	mov    0x8(%rax),%rax
   4389f:	48 8d 48 08          	lea    0x8(%rax),%rcx
   438a3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   438aa:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   438ae:	48 8b 00             	mov    (%rax),%rax
   438b1:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   438b5:	e9 15 01 00 00       	jmp    439cf <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
   438ba:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   438c1:	8b 00                	mov    (%rax),%eax
   438c3:	83 f8 2f             	cmp    $0x2f,%eax
   438c6:	77 30                	ja     438f8 <printer_vprintf+0x620>
   438c8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   438cf:	48 8b 50 10          	mov    0x10(%rax),%rdx
   438d3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   438da:	8b 00                	mov    (%rax),%eax
   438dc:	89 c0                	mov    %eax,%eax
   438de:	48 01 d0             	add    %rdx,%rax
   438e1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   438e8:	8b 12                	mov    (%rdx),%edx
   438ea:	8d 4a 08             	lea    0x8(%rdx),%ecx
   438ed:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   438f4:	89 0a                	mov    %ecx,(%rdx)
   438f6:	eb 1a                	jmp    43912 <printer_vprintf+0x63a>
   438f8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   438ff:	48 8b 40 08          	mov    0x8(%rax),%rax
   43903:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43907:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4390e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43912:	8b 00                	mov    (%rax),%eax
   43914:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   4391a:	e9 67 03 00 00       	jmp    43c86 <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
   4391f:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43923:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   43927:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4392e:	8b 00                	mov    (%rax),%eax
   43930:	83 f8 2f             	cmp    $0x2f,%eax
   43933:	77 30                	ja     43965 <printer_vprintf+0x68d>
   43935:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4393c:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43940:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43947:	8b 00                	mov    (%rax),%eax
   43949:	89 c0                	mov    %eax,%eax
   4394b:	48 01 d0             	add    %rdx,%rax
   4394e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43955:	8b 12                	mov    (%rdx),%edx
   43957:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4395a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43961:	89 0a                	mov    %ecx,(%rdx)
   43963:	eb 1a                	jmp    4397f <printer_vprintf+0x6a7>
   43965:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4396c:	48 8b 40 08          	mov    0x8(%rax),%rax
   43970:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43974:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4397b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4397f:	8b 00                	mov    (%rax),%eax
   43981:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   43984:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   43988:	eb 45                	jmp    439cf <printer_vprintf+0x6f7>
        default:
            data = numbuf;
   4398a:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   4398e:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   43992:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43999:	0f b6 00             	movzbl (%rax),%eax
   4399c:	84 c0                	test   %al,%al
   4399e:	74 0c                	je     439ac <printer_vprintf+0x6d4>
   439a0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   439a7:	0f b6 00             	movzbl (%rax),%eax
   439aa:	eb 05                	jmp    439b1 <printer_vprintf+0x6d9>
   439ac:	b8 25 00 00 00       	mov    $0x25,%eax
   439b1:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   439b4:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   439b8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   439bf:	0f b6 00             	movzbl (%rax),%eax
   439c2:	84 c0                	test   %al,%al
   439c4:	75 08                	jne    439ce <printer_vprintf+0x6f6>
                format--;
   439c6:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   439cd:	01 
            }
            break;
   439ce:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   439cf:	8b 45 ec             	mov    -0x14(%rbp),%eax
   439d2:	83 e0 20             	and    $0x20,%eax
   439d5:	85 c0                	test   %eax,%eax
   439d7:	74 1e                	je     439f7 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   439d9:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   439dd:	48 83 c0 18          	add    $0x18,%rax
   439e1:	8b 55 e0             	mov    -0x20(%rbp),%edx
   439e4:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   439e8:	48 89 ce             	mov    %rcx,%rsi
   439eb:	48 89 c7             	mov    %rax,%rdi
   439ee:	e8 63 f8 ff ff       	call   43256 <fill_numbuf>
   439f3:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   439f7:	48 c7 45 c0 c6 4a 04 	movq   $0x44ac6,-0x40(%rbp)
   439fe:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   439ff:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43a02:	83 e0 20             	and    $0x20,%eax
   43a05:	85 c0                	test   %eax,%eax
   43a07:	74 48                	je     43a51 <printer_vprintf+0x779>
   43a09:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43a0c:	83 e0 40             	and    $0x40,%eax
   43a0f:	85 c0                	test   %eax,%eax
   43a11:	74 3e                	je     43a51 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
   43a13:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43a16:	25 80 00 00 00       	and    $0x80,%eax
   43a1b:	85 c0                	test   %eax,%eax
   43a1d:	74 0a                	je     43a29 <printer_vprintf+0x751>
                prefix = "-";
   43a1f:	48 c7 45 c0 c7 4a 04 	movq   $0x44ac7,-0x40(%rbp)
   43a26:	00 
            if (flags & FLAG_NEGATIVE) {
   43a27:	eb 73                	jmp    43a9c <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   43a29:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43a2c:	83 e0 10             	and    $0x10,%eax
   43a2f:	85 c0                	test   %eax,%eax
   43a31:	74 0a                	je     43a3d <printer_vprintf+0x765>
                prefix = "+";
   43a33:	48 c7 45 c0 c9 4a 04 	movq   $0x44ac9,-0x40(%rbp)
   43a3a:	00 
            if (flags & FLAG_NEGATIVE) {
   43a3b:	eb 5f                	jmp    43a9c <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   43a3d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43a40:	83 e0 08             	and    $0x8,%eax
   43a43:	85 c0                	test   %eax,%eax
   43a45:	74 55                	je     43a9c <printer_vprintf+0x7c4>
                prefix = " ";
   43a47:	48 c7 45 c0 cb 4a 04 	movq   $0x44acb,-0x40(%rbp)
   43a4e:	00 
            if (flags & FLAG_NEGATIVE) {
   43a4f:	eb 4b                	jmp    43a9c <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   43a51:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43a54:	83 e0 20             	and    $0x20,%eax
   43a57:	85 c0                	test   %eax,%eax
   43a59:	74 42                	je     43a9d <printer_vprintf+0x7c5>
   43a5b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43a5e:	83 e0 01             	and    $0x1,%eax
   43a61:	85 c0                	test   %eax,%eax
   43a63:	74 38                	je     43a9d <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
   43a65:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   43a69:	74 06                	je     43a71 <printer_vprintf+0x799>
   43a6b:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   43a6f:	75 2c                	jne    43a9d <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
   43a71:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43a76:	75 0c                	jne    43a84 <printer_vprintf+0x7ac>
   43a78:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43a7b:	25 00 01 00 00       	and    $0x100,%eax
   43a80:	85 c0                	test   %eax,%eax
   43a82:	74 19                	je     43a9d <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
   43a84:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   43a88:	75 07                	jne    43a91 <printer_vprintf+0x7b9>
   43a8a:	b8 cd 4a 04 00       	mov    $0x44acd,%eax
   43a8f:	eb 05                	jmp    43a96 <printer_vprintf+0x7be>
   43a91:	b8 d0 4a 04 00       	mov    $0x44ad0,%eax
   43a96:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   43a9a:	eb 01                	jmp    43a9d <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
   43a9c:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   43a9d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   43aa1:	78 24                	js     43ac7 <printer_vprintf+0x7ef>
   43aa3:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43aa6:	83 e0 20             	and    $0x20,%eax
   43aa9:	85 c0                	test   %eax,%eax
   43aab:	75 1a                	jne    43ac7 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
   43aad:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43ab0:	48 63 d0             	movslq %eax,%rdx
   43ab3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43ab7:	48 89 d6             	mov    %rdx,%rsi
   43aba:	48 89 c7             	mov    %rax,%rdi
   43abd:	e8 ea f5 ff ff       	call   430ac <strnlen>
   43ac2:	89 45 bc             	mov    %eax,-0x44(%rbp)
   43ac5:	eb 0f                	jmp    43ad6 <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
   43ac7:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43acb:	48 89 c7             	mov    %rax,%rdi
   43ace:	e8 a8 f5 ff ff       	call   4307b <strlen>
   43ad3:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   43ad6:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43ad9:	83 e0 20             	and    $0x20,%eax
   43adc:	85 c0                	test   %eax,%eax
   43ade:	74 20                	je     43b00 <printer_vprintf+0x828>
   43ae0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   43ae4:	78 1a                	js     43b00 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
   43ae6:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43ae9:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   43aec:	7e 08                	jle    43af6 <printer_vprintf+0x81e>
   43aee:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43af1:	2b 45 bc             	sub    -0x44(%rbp),%eax
   43af4:	eb 05                	jmp    43afb <printer_vprintf+0x823>
   43af6:	b8 00 00 00 00       	mov    $0x0,%eax
   43afb:	89 45 b8             	mov    %eax,-0x48(%rbp)
   43afe:	eb 5c                	jmp    43b5c <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   43b00:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43b03:	83 e0 20             	and    $0x20,%eax
   43b06:	85 c0                	test   %eax,%eax
   43b08:	74 4b                	je     43b55 <printer_vprintf+0x87d>
   43b0a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43b0d:	83 e0 02             	and    $0x2,%eax
   43b10:	85 c0                	test   %eax,%eax
   43b12:	74 41                	je     43b55 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
   43b14:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43b17:	83 e0 04             	and    $0x4,%eax
   43b1a:	85 c0                	test   %eax,%eax
   43b1c:	75 37                	jne    43b55 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
   43b1e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43b22:	48 89 c7             	mov    %rax,%rdi
   43b25:	e8 51 f5 ff ff       	call   4307b <strlen>
   43b2a:	89 c2                	mov    %eax,%edx
   43b2c:	8b 45 bc             	mov    -0x44(%rbp),%eax
   43b2f:	01 d0                	add    %edx,%eax
   43b31:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   43b34:	7e 1f                	jle    43b55 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
   43b36:	8b 45 e8             	mov    -0x18(%rbp),%eax
   43b39:	2b 45 bc             	sub    -0x44(%rbp),%eax
   43b3c:	89 c3                	mov    %eax,%ebx
   43b3e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43b42:	48 89 c7             	mov    %rax,%rdi
   43b45:	e8 31 f5 ff ff       	call   4307b <strlen>
   43b4a:	89 c2                	mov    %eax,%edx
   43b4c:	89 d8                	mov    %ebx,%eax
   43b4e:	29 d0                	sub    %edx,%eax
   43b50:	89 45 b8             	mov    %eax,-0x48(%rbp)
   43b53:	eb 07                	jmp    43b5c <printer_vprintf+0x884>
        } else {
            zeros = 0;
   43b55:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   43b5c:	8b 55 bc             	mov    -0x44(%rbp),%edx
   43b5f:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43b62:	01 d0                	add    %edx,%eax
   43b64:	48 63 d8             	movslq %eax,%rbx
   43b67:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43b6b:	48 89 c7             	mov    %rax,%rdi
   43b6e:	e8 08 f5 ff ff       	call   4307b <strlen>
   43b73:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   43b77:	8b 45 e8             	mov    -0x18(%rbp),%eax
   43b7a:	29 d0                	sub    %edx,%eax
   43b7c:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   43b7f:	eb 25                	jmp    43ba6 <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
   43b81:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43b88:	48 8b 08             	mov    (%rax),%rcx
   43b8b:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43b91:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43b98:	be 20 00 00 00       	mov    $0x20,%esi
   43b9d:	48 89 c7             	mov    %rax,%rdi
   43ba0:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   43ba2:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   43ba6:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43ba9:	83 e0 04             	and    $0x4,%eax
   43bac:	85 c0                	test   %eax,%eax
   43bae:	75 36                	jne    43be6 <printer_vprintf+0x90e>
   43bb0:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   43bb4:	7f cb                	jg     43b81 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
   43bb6:	eb 2e                	jmp    43be6 <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
   43bb8:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43bbf:	4c 8b 00             	mov    (%rax),%r8
   43bc2:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43bc6:	0f b6 00             	movzbl (%rax),%eax
   43bc9:	0f b6 c8             	movzbl %al,%ecx
   43bcc:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43bd2:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43bd9:	89 ce                	mov    %ecx,%esi
   43bdb:	48 89 c7             	mov    %rax,%rdi
   43bde:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   43be1:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   43be6:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43bea:	0f b6 00             	movzbl (%rax),%eax
   43bed:	84 c0                	test   %al,%al
   43bef:	75 c7                	jne    43bb8 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
   43bf1:	eb 25                	jmp    43c18 <printer_vprintf+0x940>
            p->putc(p, '0', color);
   43bf3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43bfa:	48 8b 08             	mov    (%rax),%rcx
   43bfd:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43c03:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43c0a:	be 30 00 00 00       	mov    $0x30,%esi
   43c0f:	48 89 c7             	mov    %rax,%rdi
   43c12:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   43c14:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   43c18:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   43c1c:	7f d5                	jg     43bf3 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
   43c1e:	eb 32                	jmp    43c52 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
   43c20:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43c27:	4c 8b 00             	mov    (%rax),%r8
   43c2a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43c2e:	0f b6 00             	movzbl (%rax),%eax
   43c31:	0f b6 c8             	movzbl %al,%ecx
   43c34:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43c3a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43c41:	89 ce                	mov    %ecx,%esi
   43c43:	48 89 c7             	mov    %rax,%rdi
   43c46:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   43c49:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   43c4e:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   43c52:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   43c56:	7f c8                	jg     43c20 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
   43c58:	eb 25                	jmp    43c7f <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
   43c5a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43c61:	48 8b 08             	mov    (%rax),%rcx
   43c64:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43c6a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43c71:	be 20 00 00 00       	mov    $0x20,%esi
   43c76:	48 89 c7             	mov    %rax,%rdi
   43c79:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   43c7b:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   43c7f:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   43c83:	7f d5                	jg     43c5a <printer_vprintf+0x982>
        }
    done: ;
   43c85:	90                   	nop
    for (; *format; ++format) {
   43c86:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43c8d:	01 
   43c8e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43c95:	0f b6 00             	movzbl (%rax),%eax
   43c98:	84 c0                	test   %al,%al
   43c9a:	0f 85 64 f6 ff ff    	jne    43304 <printer_vprintf+0x2c>
    }
}
   43ca0:	90                   	nop
   43ca1:	90                   	nop
   43ca2:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   43ca6:	c9                   	leave  
   43ca7:	c3                   	ret    

0000000000043ca8 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   43ca8:	55                   	push   %rbp
   43ca9:	48 89 e5             	mov    %rsp,%rbp
   43cac:	48 83 ec 20          	sub    $0x20,%rsp
   43cb0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43cb4:	89 f0                	mov    %esi,%eax
   43cb6:	89 55 e0             	mov    %edx,-0x20(%rbp)
   43cb9:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   43cbc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43cc0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   43cc4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43cc8:	48 8b 40 08          	mov    0x8(%rax),%rax
   43ccc:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
   43cd1:	48 39 d0             	cmp    %rdx,%rax
   43cd4:	72 0c                	jb     43ce2 <console_putc+0x3a>
        cp->cursor = console;
   43cd6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43cda:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
   43ce1:	00 
    }
    if (c == '\n') {
   43ce2:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   43ce6:	75 78                	jne    43d60 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
   43ce8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43cec:	48 8b 40 08          	mov    0x8(%rax),%rax
   43cf0:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   43cf6:	48 d1 f8             	sar    %rax
   43cf9:	48 89 c1             	mov    %rax,%rcx
   43cfc:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   43d03:	66 66 66 
   43d06:	48 89 c8             	mov    %rcx,%rax
   43d09:	48 f7 ea             	imul   %rdx
   43d0c:	48 c1 fa 05          	sar    $0x5,%rdx
   43d10:	48 89 c8             	mov    %rcx,%rax
   43d13:	48 c1 f8 3f          	sar    $0x3f,%rax
   43d17:	48 29 c2             	sub    %rax,%rdx
   43d1a:	48 89 d0             	mov    %rdx,%rax
   43d1d:	48 c1 e0 02          	shl    $0x2,%rax
   43d21:	48 01 d0             	add    %rdx,%rax
   43d24:	48 c1 e0 04          	shl    $0x4,%rax
   43d28:	48 29 c1             	sub    %rax,%rcx
   43d2b:	48 89 ca             	mov    %rcx,%rdx
   43d2e:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   43d31:	eb 25                	jmp    43d58 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
   43d33:	8b 45 e0             	mov    -0x20(%rbp),%eax
   43d36:	83 c8 20             	or     $0x20,%eax
   43d39:	89 c6                	mov    %eax,%esi
   43d3b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43d3f:	48 8b 40 08          	mov    0x8(%rax),%rax
   43d43:	48 8d 48 02          	lea    0x2(%rax),%rcx
   43d47:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   43d4b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43d4f:	89 f2                	mov    %esi,%edx
   43d51:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   43d54:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   43d58:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   43d5c:	75 d5                	jne    43d33 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   43d5e:	eb 24                	jmp    43d84 <console_putc+0xdc>
        *cp->cursor++ = c | color;
   43d60:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
   43d64:	8b 55 e0             	mov    -0x20(%rbp),%edx
   43d67:	09 d0                	or     %edx,%eax
   43d69:	89 c6                	mov    %eax,%esi
   43d6b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43d6f:	48 8b 40 08          	mov    0x8(%rax),%rax
   43d73:	48 8d 48 02          	lea    0x2(%rax),%rcx
   43d77:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   43d7b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43d7f:	89 f2                	mov    %esi,%edx
   43d81:	66 89 10             	mov    %dx,(%rax)
}
   43d84:	90                   	nop
   43d85:	c9                   	leave  
   43d86:	c3                   	ret    

0000000000043d87 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   43d87:	55                   	push   %rbp
   43d88:	48 89 e5             	mov    %rsp,%rbp
   43d8b:	48 83 ec 30          	sub    $0x30,%rsp
   43d8f:	89 7d ec             	mov    %edi,-0x14(%rbp)
   43d92:	89 75 e8             	mov    %esi,-0x18(%rbp)
   43d95:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   43d99:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   43d9d:	48 c7 45 f0 a8 3c 04 	movq   $0x43ca8,-0x10(%rbp)
   43da4:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   43da5:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   43da9:	78 09                	js     43db4 <console_vprintf+0x2d>
   43dab:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   43db2:	7e 07                	jle    43dbb <console_vprintf+0x34>
        cpos = 0;
   43db4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   43dbb:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43dbe:	48 98                	cltq   
   43dc0:	48 01 c0             	add    %rax,%rax
   43dc3:	48 05 00 80 0b 00    	add    $0xb8000,%rax
   43dc9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   43dcd:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   43dd1:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43dd5:	8b 75 e8             	mov    -0x18(%rbp),%esi
   43dd8:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   43ddc:	48 89 c7             	mov    %rax,%rdi
   43ddf:	e8 f4 f4 ff ff       	call   432d8 <printer_vprintf>
    return cp.cursor - console;
   43de4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43de8:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   43dee:	48 d1 f8             	sar    %rax
}
   43df1:	c9                   	leave  
   43df2:	c3                   	ret    

0000000000043df3 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   43df3:	55                   	push   %rbp
   43df4:	48 89 e5             	mov    %rsp,%rbp
   43df7:	48 83 ec 60          	sub    $0x60,%rsp
   43dfb:	89 7d ac             	mov    %edi,-0x54(%rbp)
   43dfe:	89 75 a8             	mov    %esi,-0x58(%rbp)
   43e01:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   43e05:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   43e09:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   43e0d:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   43e11:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   43e18:	48 8d 45 10          	lea    0x10(%rbp),%rax
   43e1c:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   43e20:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   43e24:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   43e28:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   43e2c:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   43e30:	8b 75 a8             	mov    -0x58(%rbp),%esi
   43e33:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43e36:	89 c7                	mov    %eax,%edi
   43e38:	e8 4a ff ff ff       	call   43d87 <console_vprintf>
   43e3d:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   43e40:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   43e43:	c9                   	leave  
   43e44:	c3                   	ret    

0000000000043e45 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   43e45:	55                   	push   %rbp
   43e46:	48 89 e5             	mov    %rsp,%rbp
   43e49:	48 83 ec 20          	sub    $0x20,%rsp
   43e4d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43e51:	89 f0                	mov    %esi,%eax
   43e53:	89 55 e0             	mov    %edx,-0x20(%rbp)
   43e56:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   43e59:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43e5d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   43e61:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e65:	48 8b 50 08          	mov    0x8(%rax),%rdx
   43e69:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e6d:	48 8b 40 10          	mov    0x10(%rax),%rax
   43e71:	48 39 c2             	cmp    %rax,%rdx
   43e74:	73 1a                	jae    43e90 <string_putc+0x4b>
        *sp->s++ = c;
   43e76:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e7a:	48 8b 40 08          	mov    0x8(%rax),%rax
   43e7e:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43e82:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43e86:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43e8a:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   43e8e:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   43e90:	90                   	nop
   43e91:	c9                   	leave  
   43e92:	c3                   	ret    

0000000000043e93 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   43e93:	55                   	push   %rbp
   43e94:	48 89 e5             	mov    %rsp,%rbp
   43e97:	48 83 ec 40          	sub    $0x40,%rsp
   43e9b:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   43e9f:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   43ea3:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   43ea7:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   43eab:	48 c7 45 e8 45 3e 04 	movq   $0x43e45,-0x18(%rbp)
   43eb2:	00 
    sp.s = s;
   43eb3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43eb7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   43ebb:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   43ec0:	74 33                	je     43ef5 <vsnprintf+0x62>
        sp.end = s + size - 1;
   43ec2:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43ec6:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43eca:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43ece:	48 01 d0             	add    %rdx,%rax
   43ed1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   43ed5:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   43ed9:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   43edd:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   43ee1:	be 00 00 00 00       	mov    $0x0,%esi
   43ee6:	48 89 c7             	mov    %rax,%rdi
   43ee9:	e8 ea f3 ff ff       	call   432d8 <printer_vprintf>
        *sp.s = 0;
   43eee:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43ef2:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   43ef5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43ef9:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   43efd:	c9                   	leave  
   43efe:	c3                   	ret    

0000000000043eff <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   43eff:	55                   	push   %rbp
   43f00:	48 89 e5             	mov    %rsp,%rbp
   43f03:	48 83 ec 70          	sub    $0x70,%rsp
   43f07:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   43f0b:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   43f0f:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   43f13:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   43f17:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   43f1b:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   43f1f:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   43f26:	48 8d 45 10          	lea    0x10(%rbp),%rax
   43f2a:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   43f2e:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   43f32:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   43f36:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   43f3a:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   43f3e:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   43f42:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43f46:	48 89 c7             	mov    %rax,%rdi
   43f49:	e8 45 ff ff ff       	call   43e93 <vsnprintf>
   43f4e:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   43f51:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   43f54:	c9                   	leave  
   43f55:	c3                   	ret    

0000000000043f56 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   43f56:	55                   	push   %rbp
   43f57:	48 89 e5             	mov    %rsp,%rbp
   43f5a:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   43f5e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   43f65:	eb 13                	jmp    43f7a <console_clear+0x24>
        console[i] = ' ' | 0x0700;
   43f67:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43f6a:	48 98                	cltq   
   43f6c:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
   43f73:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   43f76:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   43f7a:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   43f81:	7e e4                	jle    43f67 <console_clear+0x11>
    }
    cursorpos = 0;
   43f83:	c7 05 6f 50 07 00 00 	movl   $0x0,0x7506f(%rip)        # b8ffc <cursorpos>
   43f8a:	00 00 00 
}
   43f8d:	90                   	nop
   43f8e:	c9                   	leave  
   43f8f:	c3                   	ret    
