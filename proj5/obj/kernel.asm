
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
   400be:	e8 d0 0a 00 00       	call   40b93 <exception>

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
   40173:	e8 81 1a 00 00       	call   41bf9 <hardware_init>
    pageinfo_init();
   40178:	e8 92 10 00 00       	call   4120f <pageinfo_init>
    console_clear();
   4017d:	e8 b7 44 00 00       	call   44639 <console_clear>
    timer_init(HZ);
   40182:	bf 64 00 00 00       	mov    $0x64,%edi
   40187:	e8 59 1f 00 00       	call   420e5 <timer_init>

    // use virtual_memory_map to remove user permissions for kernel memory
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   4018c:	48 8b 05 6d 4e 01 00 	mov    0x14e6d(%rip),%rax        # 55000 <kernel_pagetable>
   40193:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   40199:	b9 00 00 10 00       	mov    $0x100000,%ecx
   4019e:	ba 00 00 00 00       	mov    $0x0,%edx
   401a3:	be 00 00 00 00       	mov    $0x0,%esi
   401a8:	48 89 c7             	mov    %rax,%rdi
   401ab:	e8 93 2c 00 00       	call   42e43 <virtual_memory_map>
					   PROC_START_ADDR, PTE_P | PTE_W);
   
    // return user permissions to console
    virtual_memory_map(kernel_pagetable, (uintptr_t) CONSOLE_ADDR, (uintptr_t) CONSOLE_ADDR,
   401b0:	ba 00 80 0b 00       	mov    $0xb8000,%edx
   401b5:	be 00 80 0b 00       	mov    $0xb8000,%esi
   401ba:	48 8b 05 3f 4e 01 00 	mov    0x14e3f(%rip),%rax        # 55000 <kernel_pagetable>
   401c1:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   401c7:	b9 00 10 00 00       	mov    $0x1000,%ecx
   401cc:	48 89 c7             	mov    %rax,%rdi
   401cf:	e8 6f 2c 00 00       	call   42e43 <virtual_memory_map>
	// to all memory before the start of ANY processes. This means that 
	// the assign_page function is never capable of assigning this memory
	// to a process.

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   401d4:	ba 00 0e 00 00       	mov    $0xe00,%edx
   401d9:	be 00 00 00 00       	mov    $0x0,%esi
   401de:	bf 20 20 05 00       	mov    $0x52020,%edi
   401e3:	e8 37 35 00 00       	call   4371f <memset>
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
   40246:	be 80 46 04 00       	mov    $0x44680,%esi
   4024b:	48 89 c7             	mov    %rax,%rdi
   4024e:	e8 c5 35 00 00       	call   43818 <strcmp>
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
   40276:	be 85 46 04 00       	mov    $0x44685,%esi
   4027b:	48 89 c7             	mov    %rax,%rdi
   4027e:	e8 95 35 00 00       	call   43818 <strcmp>
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
   402a6:	be 8e 46 04 00       	mov    $0x4468e,%esi
   402ab:	48 89 c7             	mov    %rax,%rdi
   402ae:	e8 65 35 00 00       	call   43818 <strcmp>
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
   402d3:	be 93 46 04 00       	mov    $0x44693,%esi
   402d8:	48 89 c7             	mov    %rax,%rdi
   402db:	e8 38 35 00 00       	call   43818 <strcmp>
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
   40332:	e8 7b 0e 00 00       	call   411b2 <run>

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
   4044d:	e8 cd 32 00 00       	call   4371f <memset>
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
   404b8:	e8 64 31 00 00       	call   43621 <memcpy>
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
   40518:	e8 59 1e 00 00       	call   42376 <process_init>
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
   4054f:	e8 ac 2d 00 00       	call   43300 <program_load>
   40554:	89 45 fc             	mov    %eax,-0x4(%rbp)
    assert(r >= 0);
   40557:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4055b:	79 14                	jns    40571 <process_setup+0x89>
   4055d:	ba 99 46 04 00       	mov    $0x44699,%edx
   40562:	be d7 00 00 00       	mov    $0xd7,%esi
   40567:	bf a0 46 04 00       	mov    $0x446a0,%edi
   4056c:	e8 d3 25 00 00       	call   42b44 <assert_fail>

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
   4060f:	e8 2f 28 00 00       	call   42e43 <virtual_memory_map>
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
   406e8:	e8 1c 2b 00 00       	call   43209 <virtual_memory_lookup>

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
   40720:	e8 e4 2a 00 00       	call   43209 <virtual_memory_lookup>
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
   4074c:	e8 b8 2a 00 00       	call   43209 <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   40751:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40755:	48 89 c1             	mov    %rax,%rcx
   40758:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   4075c:	ba 18 00 00 00       	mov    $0x18,%edx
   40761:	48 89 c6             	mov    %rax,%rsi
   40764:	48 89 cf             	mov    %rcx,%rdi
   40767:	e8 b5 2e 00 00       	call   43621 <memcpy>
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
   4085a:	e8 aa 29 00 00       	call   43209 <virtual_memory_lookup>
		
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
   408cd:	e8 71 25 00 00       	call   42e43 <virtual_memory_map>
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
   40920:	e8 1e 25 00 00       	call   42e43 <virtual_memory_map>
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
   40946:	e8 d6 2c 00 00       	call   43621 <memcpy>
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
	x86_64_pagetable *page = p->p_pagetable;
   40977:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4097b:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40982:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

	// l4 pagetable	
	pageinfo[PAGENUMBER(page)].owner = PO_FREE;
   40986:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4098a:	48 c1 e8 0c          	shr    $0xc,%rax
   4098e:	48 98                	cltq   
   40990:	c6 84 00 40 2e 05 00 	movb   $0x0,0x52e40(%rax,%rax,1)
   40997:	00 
	--pageinfo[PAGENUMBER(page)].refcount;
   40998:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4099c:	48 c1 e8 0c          	shr    $0xc,%rax
   409a0:	89 c2                	mov    %eax,%edx
   409a2:	48 63 c2             	movslq %edx,%rax
   409a5:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   409ac:	00 
   409ad:	83 e8 01             	sub    $0x1,%eax
   409b0:	89 c1                	mov    %eax,%ecx
   409b2:	48 63 c2             	movslq %edx,%rax
   409b5:	88 8c 00 41 2e 05 00 	mov    %cl,0x52e41(%rax,%rax,1)

	// l3 pagetable
	page = (x86_64_pagetable *) PTE_ADDR(page->entry[0]);
   409bc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   409c0:	48 8b 00             	mov    (%rax),%rax
   409c3:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   409c9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
	pageinfo[PAGENUMBER(page)].owner = PO_FREE;
   409cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   409d1:	48 c1 e8 0c          	shr    $0xc,%rax
   409d5:	48 98                	cltq   
   409d7:	c6 84 00 40 2e 05 00 	movb   $0x0,0x52e40(%rax,%rax,1)
   409de:	00 
	--pageinfo[PAGENUMBER(page)].refcount;
   409df:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   409e3:	48 c1 e8 0c          	shr    $0xc,%rax
   409e7:	89 c2                	mov    %eax,%edx
   409e9:	48 63 c2             	movslq %edx,%rax
   409ec:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   409f3:	00 
   409f4:	83 e8 01             	sub    $0x1,%eax
   409f7:	89 c1                	mov    %eax,%ecx
   409f9:	48 63 c2             	movslq %edx,%rax
   409fc:	88 8c 00 41 2e 05 00 	mov    %cl,0x52e41(%rax,%rax,1)

	// l2 pagetable
	page = (x86_64_pagetable *) PTE_ADDR(page->entry[0]); 
   40a03:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a07:	48 8b 00             	mov    (%rax),%rax
   40a0a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40a10:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
	pageinfo[PAGENUMBER(page)].owner = PO_FREE;
   40a14:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a18:	48 c1 e8 0c          	shr    $0xc,%rax
   40a1c:	48 98                	cltq   
   40a1e:	c6 84 00 40 2e 05 00 	movb   $0x0,0x52e40(%rax,%rax,1)
   40a25:	00 
	--pageinfo[PAGENUMBER(page)].refcount;
   40a26:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a2a:	48 c1 e8 0c          	shr    $0xc,%rax
   40a2e:	89 c2                	mov    %eax,%edx
   40a30:	48 63 c2             	movslq %edx,%rax
   40a33:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   40a3a:	00 
   40a3b:	83 e8 01             	sub    $0x1,%eax
   40a3e:	89 c1                	mov    %eax,%ecx
   40a40:	48 63 c2             	movslq %edx,%rax
   40a43:	88 8c 00 41 2e 05 00 	mov    %cl,0x52e41(%rax,%rax,1)

	// l1 pagetables
	x86_64_pagetable *l1 = (x86_64_pagetable *) PTE_ADDR(page->entry[0]);
   40a4a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a4e:	48 8b 00             	mov    (%rax),%rax
   40a51:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40a57:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
	pageinfo[PAGENUMBER(l1)].owner = PO_FREE;
   40a5b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40a5f:	48 c1 e8 0c          	shr    $0xc,%rax
   40a63:	48 98                	cltq   
   40a65:	c6 84 00 40 2e 05 00 	movb   $0x0,0x52e40(%rax,%rax,1)
   40a6c:	00 
	--pageinfo[PAGENUMBER(l1)].refcount;
   40a6d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40a71:	48 c1 e8 0c          	shr    $0xc,%rax
   40a75:	89 c2                	mov    %eax,%edx
   40a77:	48 63 c2             	movslq %edx,%rax
   40a7a:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   40a81:	00 
   40a82:	83 e8 01             	sub    $0x1,%eax
   40a85:	89 c1                	mov    %eax,%ecx
   40a87:	48 63 c2             	movslq %edx,%rax
   40a8a:	88 8c 00 41 2e 05 00 	mov    %cl,0x52e41(%rax,%rax,1)
	
	l1 = (x86_64_pagetable *) PTE_ADDR(page->entry[1]);
   40a91:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a95:	48 8b 40 08          	mov    0x8(%rax),%rax
   40a99:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40a9f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
	pageinfo[PAGENUMBER(l1)].owner = PO_FREE;
   40aa3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40aa7:	48 c1 e8 0c          	shr    $0xc,%rax
   40aab:	48 98                	cltq   
   40aad:	c6 84 00 40 2e 05 00 	movb   $0x0,0x52e40(%rax,%rax,1)
   40ab4:	00 
	--pageinfo[PAGENUMBER(l1)].refcount;
   40ab5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40ab9:	48 c1 e8 0c          	shr    $0xc,%rax
   40abd:	89 c2                	mov    %eax,%edx
   40abf:	48 63 c2             	movslq %edx,%rax
   40ac2:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   40ac9:	00 
   40aca:	83 e8 01             	sub    $0x1,%eax
   40acd:	89 c1                	mov    %eax,%ecx
   40acf:	48 63 c2             	movslq %edx,%rax
   40ad2:	88 8c 00 41 2e 05 00 	mov    %cl,0x52e41(%rax,%rax,1)
}
   40ad9:	90                   	nop
   40ada:	c9                   	leave  
   40adb:	c3                   	ret    

0000000000040adc <free_pages_va>:

// free_process_pages(pid_t pid)
//		frees physical pages allocated to the process with pid

void free_pages_va(proc *p) {
   40adc:	55                   	push   %rbp
   40add:	48 89 e5             	mov    %rsp,%rbp
   40ae0:	48 83 ec 30          	sub    $0x30,%rsp
   40ae4:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
	for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   40ae8:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   40aef:	00 
   40af0:	e9 8c 00 00 00       	jmp    40b81 <free_pages_va+0xa5>
		vamapping map = virtual_memory_lookup(p->p_pagetable, va); // examining addr page by page
   40af5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40af9:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40b00:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   40b04:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40b08:	48 89 ce             	mov    %rcx,%rsi
   40b0b:	48 89 c7             	mov    %rax,%rdi
   40b0e:	e8 f6 26 00 00       	call   43209 <virtual_memory_lookup>
		
		if (map.pn == -1) { // unused va
   40b13:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40b16:	83 f8 ff             	cmp    $0xffffffff,%eax
   40b19:	74 5d                	je     40b78 <free_pages_va+0x9c>
			continue;
		}
		else if ((map.perm & PTE_P) && (map.perm & PTE_U)) {
   40b1b:	8b 45 f0             	mov    -0x10(%rbp),%eax
   40b1e:	48 98                	cltq   
   40b20:	83 e0 01             	and    $0x1,%eax
   40b23:	48 85 c0             	test   %rax,%rax
   40b26:	74 51                	je     40b79 <free_pages_va+0x9d>
   40b28:	8b 45 f0             	mov    -0x10(%rbp),%eax
   40b2b:	48 98                	cltq   
   40b2d:	83 e0 04             	and    $0x4,%eax
   40b30:	48 85 c0             	test   %rax,%rax
   40b33:	74 44                	je     40b79 <free_pages_va+0x9d>
			if (pageinfo[map.pn].owner == p->p_pid)
   40b35:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40b38:	48 98                	cltq   
   40b3a:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   40b41:	00 
   40b42:	0f be d0             	movsbl %al,%edx
   40b45:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40b49:	8b 00                	mov    (%rax),%eax
   40b4b:	39 c2                	cmp    %eax,%edx
   40b4d:	75 0d                	jne    40b5c <free_pages_va+0x80>
				pageinfo[map.pn].owner = PO_FREE;
   40b4f:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40b52:	48 98                	cltq   
   40b54:	c6 84 00 40 2e 05 00 	movb   $0x0,0x52e40(%rax,%rax,1)
   40b5b:	00 
			--pageinfo[map.pn].refcount;	
   40b5c:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40b5f:	48 63 d0             	movslq %eax,%rdx
   40b62:	0f b6 94 12 41 2e 05 	movzbl 0x52e41(%rdx,%rdx,1),%edx
   40b69:	00 
   40b6a:	83 ea 01             	sub    $0x1,%edx
   40b6d:	48 98                	cltq   
   40b6f:	88 94 00 41 2e 05 00 	mov    %dl,0x52e41(%rax,%rax,1)
   40b76:	eb 01                	jmp    40b79 <free_pages_va+0x9d>
			continue;
   40b78:	90                   	nop
	for (uintptr_t va = PROC_START_ADDR; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   40b79:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40b80:	00 
   40b81:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   40b88:	00 
   40b89:	0f 86 66 ff ff ff    	jbe    40af5 <free_pages_va+0x19>
			//	console_printf(CPOS(23, 0), 0x0, 0);	
			//	console_printf(CPOS(23, 0), 0x1100, "proc 1 code page owner: %d, proc 1 code page refcount: %d\n", pageinfo[PAGENUMBER(0x7000)].owner, pageinfo[PAGENUMBER(0x7000)].refcount); 
			//}
		}
	}
}
   40b8f:	90                   	nop
   40b90:	90                   	nop
   40b91:	c9                   	leave  
   40b92:	c3                   	ret    

0000000000040b93 <exception>:
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_64_registers* reg) {
   40b93:	55                   	push   %rbp
   40b94:	48 89 e5             	mov    %rsp,%rbp
   40b97:	48 81 ec 30 01 00 00 	sub    $0x130,%rsp
   40b9e:	48 89 bd d8 fe ff ff 	mov    %rdi,-0x128(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   40ba5:	48 8b 05 54 14 01 00 	mov    0x11454(%rip),%rax        # 52000 <current>
   40bac:	48 8b 95 d8 fe ff ff 	mov    -0x128(%rbp),%rdx
   40bb3:	48 83 c0 08          	add    $0x8,%rax
   40bb7:	48 89 d6             	mov    %rdx,%rsi
   40bba:	ba 18 00 00 00       	mov    $0x18,%edx
   40bbf:	48 89 c7             	mov    %rax,%rdi
   40bc2:	48 89 d1             	mov    %rdx,%rcx
   40bc5:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   40bc8:	48 8b 05 31 44 01 00 	mov    0x14431(%rip),%rax        # 55000 <kernel_pagetable>
   40bcf:	48 89 c7             	mov    %rax,%rdi
   40bd2:	e8 3b 21 00 00       	call   42d12 <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   40bd7:	8b 05 1f 84 07 00    	mov    0x7841f(%rip),%eax        # b8ffc <cursorpos>
   40bdd:	89 c7                	mov    %eax,%edi
   40bdf:	e8 5c 18 00 00       	call   42440 <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT && reg->reg_intno != INT_GPF) // no error due to pagefault or general fault
   40be4:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40beb:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40bf2:	48 83 f8 0e          	cmp    $0xe,%rax
   40bf6:	74 14                	je     40c0c <exception+0x79>
   40bf8:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40bff:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40c06:	48 83 f8 0d          	cmp    $0xd,%rax
   40c0a:	75 16                	jne    40c22 <exception+0x8f>
            || (reg->reg_err & PFERR_USER)) // pagefault error in user mode 
   40c0c:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40c13:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40c1a:	83 e0 04             	and    $0x4,%eax
   40c1d:	48 85 c0             	test   %rax,%rax
   40c20:	74 1a                	je     40c3c <exception+0xa9>
    {
        check_virtual_memory();
   40c22:	e8 cd 09 00 00       	call   415f4 <check_virtual_memory>
        if(disp_global){
   40c27:	0f b6 05 d2 53 00 00 	movzbl 0x53d2(%rip),%eax        # 46000 <disp_global>
   40c2e:	84 c0                	test   %al,%al
   40c30:	74 0a                	je     40c3c <exception+0xa9>
            memshow_physical();
   40c32:	e8 35 0b 00 00       	call   4176c <memshow_physical>
            memshow_virtual_animate();
   40c37:	e8 5f 0e 00 00       	call   41a9b <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   40c3c:	e8 e2 1c 00 00       	call   42923 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   40c41:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40c48:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40c4f:	48 83 e8 0e          	sub    $0xe,%rax
   40c53:	48 83 f8 2a          	cmp    $0x2a,%rax
   40c57:	0f 87 a6 04 00 00    	ja     41103 <exception+0x570>
   40c5d:	48 8b 04 c5 78 47 04 	mov    0x44778(,%rax,8),%rax
   40c64:	00 
   40c65:	ff e0                	jmp    *%rax

    case INT_SYS_PANIC:
	    // rdi stores pointer for msg string
	    {
		char msg[160];
		uintptr_t addr = current->p_registers.reg_rdi;
   40c67:	48 8b 05 92 13 01 00 	mov    0x11392(%rip),%rax        # 52000 <current>
   40c6e:	48 8b 40 38          	mov    0x38(%rax),%rax
   40c72:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
		if((void *)addr == NULL)
   40c76:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   40c7b:	75 0f                	jne    40c8c <exception+0xf9>
		    panic(NULL);
   40c7d:	bf 00 00 00 00       	mov    $0x0,%edi
   40c82:	b8 00 00 00 00       	mov    $0x0,%eax
   40c87:	e8 d8 1d 00 00       	call   42a64 <panic>
		vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   40c8c:	48 8b 05 6d 13 01 00 	mov    0x1136d(%rip),%rax        # 52000 <current>
   40c93:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40c9a:	48 8d 45 90          	lea    -0x70(%rbp),%rax
   40c9e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   40ca2:	48 89 ce             	mov    %rcx,%rsi
   40ca5:	48 89 c7             	mov    %rax,%rdi
   40ca8:	e8 5c 25 00 00       	call   43209 <virtual_memory_lookup>
		memcpy(msg, (void *)map.pa, 160);
   40cad:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40cb1:	48 89 c1             	mov    %rax,%rcx
   40cb4:	48 8d 85 e8 fe ff ff 	lea    -0x118(%rbp),%rax
   40cbb:	ba a0 00 00 00       	mov    $0xa0,%edx
   40cc0:	48 89 ce             	mov    %rcx,%rsi
   40cc3:	48 89 c7             	mov    %rax,%rdi
   40cc6:	e8 56 29 00 00       	call   43621 <memcpy>
		panic(msg);
   40ccb:	48 8d 85 e8 fe ff ff 	lea    -0x118(%rbp),%rax
   40cd2:	48 89 c7             	mov    %rax,%rdi
   40cd5:	b8 00 00 00 00       	mov    $0x0,%eax
   40cda:	e8 85 1d 00 00       	call   42a64 <panic>
	    }
	    panic(NULL);
	    break;                  // will not be reached

    case INT_SYS_GETPID:
        current->p_registers.reg_rax = current->p_pid;
   40cdf:	48 8b 05 1a 13 01 00 	mov    0x1131a(%rip),%rax        # 52000 <current>
   40ce6:	8b 10                	mov    (%rax),%edx
   40ce8:	48 8b 05 11 13 01 00 	mov    0x11311(%rip),%rax        # 52000 <current>
   40cef:	48 63 d2             	movslq %edx,%rdx
   40cf2:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   40cf6:	e9 18 04 00 00       	jmp    41113 <exception+0x580>

    case INT_SYS_YIELD:
        schedule();
   40cfb:	e8 3c 04 00 00       	call   4113c <schedule>
        break;                  /* will not be reached */
   40d00:	e9 0e 04 00 00       	jmp    41113 <exception+0x580>

    case INT_SYS_PAGE_ALLOC: 
	{
        uintptr_t va = current->p_registers.reg_rdi; 
   40d05:	48 8b 05 f4 12 01 00 	mov    0x112f4(%rip),%rax        # 52000 <current>
   40d0c:	48 8b 40 38          	mov    0x38(%rax),%rax
   40d10:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
		uintptr_t pa;
		int r = 0;
   40d14:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
		if (va % PAGESIZE != 0) {
   40d1b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40d1f:	25 ff 0f 00 00       	and    $0xfff,%eax
   40d24:	48 85 c0             	test   %rax,%rax
   40d27:	74 0c                	je     40d35 <exception+0x1a2>
			r = -1;
   40d29:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
   40d30:	e9 b9 00 00 00       	jmp    40dee <exception+0x25b>
		}
		else if (virtual_memory_lookup(current->p_pagetable, va).pn != -1) {
   40d35:	48 8b 05 c4 12 01 00 	mov    0x112c4(%rip),%rax        # 52000 <current>
   40d3c:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40d43:	48 8d 45 a8          	lea    -0x58(%rbp),%rax
   40d47:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   40d4b:	48 89 ce             	mov    %rcx,%rsi
   40d4e:	48 89 c7             	mov    %rax,%rdi
   40d51:	e8 b3 24 00 00       	call   43209 <virtual_memory_lookup>
   40d56:	8b 45 a8             	mov    -0x58(%rbp),%eax
   40d59:	83 f8 ff             	cmp    $0xffffffff,%eax
   40d5c:	74 0c                	je     40d6a <exception+0x1d7>
			r = -1;
   40d5e:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
   40d65:	e9 84 00 00 00       	jmp    40dee <exception+0x25b>
		}
		else if (next_free_page(&pa) || assign_physical_page(pa, current->p_pid)) {
   40d6a:	48 8d 45 88          	lea    -0x78(%rbp),%rax
   40d6e:	48 89 c7             	mov    %rax,%rdi
   40d71:	e8 54 f6 ff ff       	call   403ca <next_free_page>
   40d76:	85 c0                	test   %eax,%eax
   40d78:	75 1e                	jne    40d98 <exception+0x205>
   40d7a:	48 8b 05 7f 12 01 00 	mov    0x1127f(%rip),%rax        # 52000 <current>
   40d81:	8b 00                	mov    (%rax),%eax
   40d83:	0f be d0             	movsbl %al,%edx
   40d86:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   40d8a:	89 d6                	mov    %edx,%esi
   40d8c:	48 89 c7             	mov    %rax,%rdi
   40d8f:	e8 a3 f8 ff ff       	call   40637 <assign_physical_page>
   40d94:	85 c0                	test   %eax,%eax
   40d96:	74 22                	je     40dba <exception+0x227>
			console_printf(CPOS(23, 0), 0x0400, "Out of physical memory!\n");	
   40d98:	ba b0 46 04 00       	mov    $0x446b0,%edx
   40d9d:	be 00 04 00 00       	mov    $0x400,%esi
   40da2:	bf 30 07 00 00       	mov    $0x730,%edi
   40da7:	b8 00 00 00 00       	mov    $0x0,%eax
   40dac:	e8 25 37 00 00       	call   444d6 <console_printf>
			r = -1;
   40db1:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
   40db8:	eb 34                	jmp    40dee <exception+0x25b>
		}
		else if (virtual_memory_map(current->p_pagetable, va, pa, PAGESIZE, PTE_P | PTE_W | PTE_U)) {
   40dba:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   40dbe:	48 8b 05 3b 12 01 00 	mov    0x1123b(%rip),%rax        # 52000 <current>
   40dc5:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40dcc:	48 8b 75 e8          	mov    -0x18(%rbp),%rsi
   40dd0:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40dd6:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40ddb:	48 89 c7             	mov    %rax,%rdi
   40dde:	e8 60 20 00 00       	call   42e43 <virtual_memory_map>
   40de3:	85 c0                	test   %eax,%eax
   40de5:	74 07                	je     40dee <exception+0x25b>
			r = -1;
   40de7:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
		}

        current->p_registers.reg_rax = r;
   40dee:	48 8b 05 0b 12 01 00 	mov    0x1120b(%rip),%rax        # 52000 <current>
   40df5:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40df8:	48 63 d2             	movslq %edx,%rdx
   40dfb:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   40dff:	e9 0f 03 00 00       	jmp    41113 <exception+0x580>
    }

    case INT_SYS_MAPPING:
    {
	    syscall_mapping(current);
   40e04:	48 8b 05 f5 11 01 00 	mov    0x111f5(%rip),%rax        # 52000 <current>
   40e0b:	48 89 c7             	mov    %rax,%rdi
   40e0e:	e8 98 f8 ff ff       	call   406ab <syscall_mapping>
            break;
   40e13:	e9 fb 02 00 00       	jmp    41113 <exception+0x580>
    }

    case INT_SYS_MEM_TOG:
	{
	    syscall_mem_tog(current);
   40e18:	48 8b 05 e1 11 01 00 	mov    0x111e1(%rip),%rax        # 52000 <current>
   40e1f:	48 89 c7             	mov    %rax,%rdi
   40e22:	e8 4d f9 ff ff       	call   40774 <syscall_mem_tog>
	    break;
   40e27:	e9 e7 02 00 00       	jmp    41113 <exception+0x580>
	}

    case INT_TIMER:
        ++ticks;
   40e2c:	8b 05 ee 1f 01 00    	mov    0x11fee(%rip),%eax        # 52e20 <ticks>
   40e32:	83 c0 01             	add    $0x1,%eax
   40e35:	89 05 e5 1f 01 00    	mov    %eax,0x11fe5(%rip)        # 52e20 <ticks>
        schedule();
   40e3b:	e8 fc 02 00 00       	call   4113c <schedule>
        break;                  /* will not be reached */
   40e40:	e9 ce 02 00 00       	jmp    41113 <exception+0x580>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   40e45:	0f 20 d0             	mov    %cr2,%rax
   40e48:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    return val;
   40e4c:	48 8b 45 c0          	mov    -0x40(%rbp),%rax

    case INT_PAGEFAULT: {
        // Analyze faulting address and access type.
        uintptr_t addr = rcr2();
   40e50:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        const char* operation = reg->reg_err & PFERR_WRITE
   40e54:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40e5b:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40e62:	83 e0 02             	and    $0x2,%eax
                ? "write" : "read";
   40e65:	48 85 c0             	test   %rax,%rax
   40e68:	74 07                	je     40e71 <exception+0x2de>
   40e6a:	b8 c9 46 04 00       	mov    $0x446c9,%eax
   40e6f:	eb 05                	jmp    40e76 <exception+0x2e3>
   40e71:	b8 cf 46 04 00       	mov    $0x446cf,%eax
        const char* operation = reg->reg_err & PFERR_WRITE
   40e76:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        const char* problem = reg->reg_err & PFERR_PRESENT
   40e7a:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40e81:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40e88:	83 e0 01             	and    $0x1,%eax
                ? "protection problem" : "missing page";
   40e8b:	48 85 c0             	test   %rax,%rax
   40e8e:	74 07                	je     40e97 <exception+0x304>
   40e90:	b8 d4 46 04 00       	mov    $0x446d4,%eax
   40e95:	eb 05                	jmp    40e9c <exception+0x309>
   40e97:	b8 e7 46 04 00       	mov    $0x446e7,%eax
        const char* problem = reg->reg_err & PFERR_PRESENT
   40e9c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)

        if (!(reg->reg_err & PFERR_USER)) {
   40ea0:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40ea7:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40eae:	83 e0 04             	and    $0x4,%eax
   40eb1:	48 85 c0             	test   %rax,%rax
   40eb4:	75 2f                	jne    40ee5 <exception+0x352>
            panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   40eb6:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40ebd:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   40ec4:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   40ec8:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   40ecc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40ed0:	49 89 f0             	mov    %rsi,%r8
   40ed3:	48 89 c6             	mov    %rax,%rsi
   40ed6:	bf f8 46 04 00       	mov    $0x446f8,%edi
   40edb:	b8 00 00 00 00       	mov    $0x0,%eax
   40ee0:	e8 7f 1b 00 00       	call   42a64 <panic>
                  addr, operation, problem, reg->reg_rip);
        }
        console_printf(CPOS(24, 0), 0x0C00,
   40ee5:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
   40eec:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                       "Process %d page fault for %p (%s %s, rip=%p)!\n",
                       current->p_pid, addr, operation, problem, reg->reg_rip);
   40ef3:	48 8b 05 06 11 01 00 	mov    0x11106(%rip),%rax        # 52000 <current>
        console_printf(CPOS(24, 0), 0x0C00,
   40efa:	8b 00                	mov    (%rax),%eax
   40efc:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
   40f00:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   40f04:	52                   	push   %rdx
   40f05:	ff 75 c8             	push   -0x38(%rbp)
   40f08:	49 89 f1             	mov    %rsi,%r9
   40f0b:	49 89 c8             	mov    %rcx,%r8
   40f0e:	89 c1                	mov    %eax,%ecx
   40f10:	ba 28 47 04 00       	mov    $0x44728,%edx
   40f15:	be 00 0c 00 00       	mov    $0xc00,%esi
   40f1a:	bf 80 07 00 00       	mov    $0x780,%edi
   40f1f:	b8 00 00 00 00       	mov    $0x0,%eax
   40f24:	e8 ad 35 00 00       	call   444d6 <console_printf>
   40f29:	48 83 c4 10          	add    $0x10,%rsp
        current->p_state = P_BROKEN;
   40f2d:	48 8b 05 cc 10 01 00 	mov    0x110cc(%rip),%rax        # 52000 <current>
   40f34:	c7 80 c8 00 00 00 03 	movl   $0x3,0xc8(%rax)
   40f3b:	00 00 00 
        break;
   40f3e:	e9 d0 01 00 00       	jmp    41113 <exception+0x580>
    }

	case INT_SYS_FORK:
		// find free pid
		pid_t child_pid;
		if ((child_pid = next_free_pid()) == -1) {
   40f43:	e8 95 f8 ff ff       	call   407dd <next_free_pid>
   40f48:	89 45 f8             	mov    %eax,-0x8(%rbp)
   40f4b:	83 7d f8 ff          	cmpl   $0xffffffff,-0x8(%rbp)
   40f4f:	75 32                	jne    40f83 <exception+0x3f0>
			console_printf(CPOS(23, 0), 0x0400, "Max processes (%d) reached!\n", NPROC);	
   40f51:	b9 10 00 00 00       	mov    $0x10,%ecx
   40f56:	ba 57 47 04 00       	mov    $0x44757,%edx
   40f5b:	be 00 04 00 00       	mov    $0x400,%esi
   40f60:	bf 30 07 00 00       	mov    $0x730,%edi
   40f65:	b8 00 00 00 00       	mov    $0x0,%eax
   40f6a:	e8 67 35 00 00       	call   444d6 <console_printf>
			current->p_registers.reg_rax = -1;
   40f6f:	48 8b 05 8a 10 01 00 	mov    0x1108a(%rip),%rax        # 52000 <current>
   40f76:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40f7d:	ff 
			break;
   40f7e:	e9 90 01 00 00       	jmp    41113 <exception+0x580>
		}

		proc *child_proc = &processes[child_pid];
   40f83:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40f86:	48 63 d0             	movslq %eax,%rdx
   40f89:	48 89 d0             	mov    %rdx,%rax
   40f8c:	48 c1 e0 03          	shl    $0x3,%rax
   40f90:	48 29 d0             	sub    %rdx,%rax
   40f93:	48 c1 e0 05          	shl    $0x5,%rax
   40f97:	48 05 20 20 05 00    	add    $0x52020,%rax
   40f9d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

		// copy the state of parent into child
		*child_proc = processes[current->p_pid];
   40fa1:	48 8b 05 58 10 01 00 	mov    0x11058(%rip),%rax        # 52000 <current>
   40fa8:	8b 00                	mov    (%rax),%eax
   40faa:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
   40fae:	48 63 d0             	movslq %eax,%rdx
   40fb1:	48 89 d0             	mov    %rdx,%rax
   40fb4:	48 c1 e0 03          	shl    $0x3,%rax
   40fb8:	48 29 d0             	sub    %rdx,%rax
   40fbb:	48 c1 e0 05          	shl    $0x5,%rax
   40fbf:	48 05 20 20 05 00    	add    $0x52020,%rax
   40fc5:	48 89 ca             	mov    %rcx,%rdx
   40fc8:	48 89 c6             	mov    %rax,%rsi
   40fcb:	b8 1c 00 00 00       	mov    $0x1c,%eax
   40fd0:	48 89 d7             	mov    %rdx,%rdi
   40fd3:	48 89 c1             	mov    %rax,%rcx
   40fd6:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
		child_proc->p_pid = child_pid;
   40fd9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40fdd:	8b 55 f8             	mov    -0x8(%rbp),%edx
   40fe0:	89 10                	mov    %edx,(%rax)

		
		// setup and copy the pagetable
		if (pagetable_setup(child_proc->p_pid)) {
   40fe2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40fe6:	8b 00                	mov    (%rax),%eax
   40fe8:	89 c7                	mov    %eax,%edi
   40fea:	e8 fa f3 ff ff       	call   403e9 <pagetable_setup>
   40fef:	85 c0                	test   %eax,%eax
   40ff1:	74 2a                	je     4101d <exception+0x48a>
			memset(child_proc, 0, sizeof(*child_proc));
   40ff3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40ff7:	ba e0 00 00 00       	mov    $0xe0,%edx
   40ffc:	be 00 00 00 00       	mov    $0x0,%esi
   41001:	48 89 c7             	mov    %rax,%rdi
   41004:	e8 16 27 00 00       	call   4371f <memset>
			current->p_registers.reg_rax = -1;
   41009:	48 8b 05 f0 0f 01 00 	mov    0x10ff0(%rip),%rax        # 52000 <current>
   41010:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   41017:	ff 
			break;
   41018:	e9 f6 00 00 00       	jmp    41113 <exception+0x580>
		}
		else if (copy_pagetable(child_proc, current)) {
   4101d:	48 8b 15 dc 0f 01 00 	mov    0x10fdc(%rip),%rdx        # 52000 <current>
   41024:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   41028:	48 89 d6             	mov    %rdx,%rsi
   4102b:	48 89 c7             	mov    %rax,%rdi
   4102e:	e8 f1 f7 ff ff       	call   40824 <copy_pagetable>
   41033:	85 c0                	test   %eax,%eax
   41035:	74 42                	je     41079 <exception+0x4e6>
			free_pages_va(child_proc);		    // goes through all va and frees corresponding physical page
   41037:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4103b:	48 89 c7             	mov    %rax,%rdi
   4103e:	e8 99 fa ff ff       	call   40adc <free_pages_va>
			free_pagetable_pages(child_proc);	    // goes through all pa and frees ones that belong to child_proc
   41043:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   41047:	48 89 c7             	mov    %rax,%rdi
   4104a:	e8 1c f9 ff ff       	call   4096b <free_pagetable_pages>

			memset(child_proc, 0, sizeof(*child_proc));
   4104f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   41053:	ba e0 00 00 00       	mov    $0xe0,%edx
   41058:	be 00 00 00 00       	mov    $0x0,%esi
   4105d:	48 89 c7             	mov    %rax,%rdi
   41060:	e8 ba 26 00 00       	call   4371f <memset>
			current->p_registers.reg_rax = -1;
   41065:	48 8b 05 94 0f 01 00 	mov    0x10f94(%rip),%rax        # 52000 <current>
   4106c:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   41073:	ff 
			break;
   41074:	e9 9a 00 00 00       	jmp    41113 <exception+0x580>
		}


		// successful fork! set return registers
                console_printf(CPOS(24, 0), 0, "\n");
   41079:	ba 74 47 04 00       	mov    $0x44774,%edx
   4107e:	be 00 00 00 00       	mov    $0x0,%esi
   41083:	bf 80 07 00 00       	mov    $0x780,%edi
   41088:	b8 00 00 00 00       	mov    $0x0,%eax
   4108d:	e8 44 34 00 00       	call   444d6 <console_printf>

		child_proc->p_registers.reg_rax = 0;
   41092:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   41096:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
   4109d:	00 
		current->p_registers.reg_rax = child_pid;
   4109e:	48 8b 05 5b 0f 01 00 	mov    0x10f5b(%rip),%rax        # 52000 <current>
   410a5:	8b 55 f8             	mov    -0x8(%rbp),%edx
   410a8:	48 63 d2             	movslq %edx,%rdx
   410ab:	48 89 50 08          	mov    %rdx,0x8(%rax)
		break;
   410af:	eb 62                	jmp    41113 <exception+0x580>

	case INT_SYS_EXIT:
		free_pages_va(current);			// goes through all va and frees corresponding physical page
   410b1:	48 8b 05 48 0f 01 00 	mov    0x10f48(%rip),%rax        # 52000 <current>
   410b8:	48 89 c7             	mov    %rax,%rdi
   410bb:	e8 1c fa ff ff       	call   40adc <free_pages_va>
		free_pagetable_pages(current);	// goes through all pa and frees ones that belong to child_proc
   410c0:	48 8b 05 39 0f 01 00 	mov    0x10f39(%rip),%rax        # 52000 <current>
   410c7:	48 89 c7             	mov    %rax,%rdi
   410ca:	e8 9c f8 ff ff       	call   4096b <free_pagetable_pages>
		memset(&processes[current->p_pid], 0, sizeof(*current));
   410cf:	48 8b 05 2a 0f 01 00 	mov    0x10f2a(%rip),%rax        # 52000 <current>
   410d6:	8b 00                	mov    (%rax),%eax
   410d8:	48 63 d0             	movslq %eax,%rdx
   410db:	48 89 d0             	mov    %rdx,%rax
   410de:	48 c1 e0 03          	shl    $0x3,%rax
   410e2:	48 29 d0             	sub    %rdx,%rax
   410e5:	48 c1 e0 05          	shl    $0x5,%rax
   410e9:	48 05 20 20 05 00    	add    $0x52020,%rax
   410ef:	ba e0 00 00 00       	mov    $0xe0,%edx
   410f4:	be 00 00 00 00       	mov    $0x0,%esi
   410f9:	48 89 c7             	mov    %rax,%rdi
   410fc:	e8 1e 26 00 00       	call   4371f <memset>
		break;
   41101:	eb 10                	jmp    41113 <exception+0x580>

    default:
        default_exception(current);
   41103:	48 8b 05 f6 0e 01 00 	mov    0x10ef6(%rip),%rax        # 52000 <current>
   4110a:	48 89 c7             	mov    %rax,%rdi
   4110d:	e8 62 1a 00 00       	call   42b74 <default_exception>
        break;                  /* will not be reached */
   41112:	90                   	nop

    }


    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   41113:	48 8b 05 e6 0e 01 00 	mov    0x10ee6(%rip),%rax        # 52000 <current>
   4111a:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   41120:	83 f8 01             	cmp    $0x1,%eax
   41123:	75 0f                	jne    41134 <exception+0x5a1>
        run(current);
   41125:	48 8b 05 d4 0e 01 00 	mov    0x10ed4(%rip),%rax        # 52000 <current>
   4112c:	48 89 c7             	mov    %rax,%rdi
   4112f:	e8 7e 00 00 00       	call   411b2 <run>
    } else {
        schedule();
   41134:	e8 03 00 00 00       	call   4113c <schedule>
    }
}
   41139:	90                   	nop
   4113a:	c9                   	leave  
   4113b:	c3                   	ret    

000000000004113c <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   4113c:	55                   	push   %rbp
   4113d:	48 89 e5             	mov    %rsp,%rbp
   41140:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   41144:	48 8b 05 b5 0e 01 00 	mov    0x10eb5(%rip),%rax        # 52000 <current>
   4114b:	8b 00                	mov    (%rax),%eax
   4114d:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   41150:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41153:	8d 50 01             	lea    0x1(%rax),%edx
   41156:	89 d0                	mov    %edx,%eax
   41158:	c1 f8 1f             	sar    $0x1f,%eax
   4115b:	c1 e8 1c             	shr    $0x1c,%eax
   4115e:	01 c2                	add    %eax,%edx
   41160:	83 e2 0f             	and    $0xf,%edx
   41163:	29 c2                	sub    %eax,%edx
   41165:	89 55 fc             	mov    %edx,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   41168:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4116b:	48 63 d0             	movslq %eax,%rdx
   4116e:	48 89 d0             	mov    %rdx,%rax
   41171:	48 c1 e0 03          	shl    $0x3,%rax
   41175:	48 29 d0             	sub    %rdx,%rax
   41178:	48 c1 e0 05          	shl    $0x5,%rax
   4117c:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   41182:	8b 00                	mov    (%rax),%eax
   41184:	83 f8 01             	cmp    $0x1,%eax
   41187:	75 22                	jne    411ab <schedule+0x6f>
            run(&processes[pid]);
   41189:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4118c:	48 63 d0             	movslq %eax,%rdx
   4118f:	48 89 d0             	mov    %rdx,%rax
   41192:	48 c1 e0 03          	shl    $0x3,%rax
   41196:	48 29 d0             	sub    %rdx,%rax
   41199:	48 c1 e0 05          	shl    $0x5,%rax
   4119d:	48 05 20 20 05 00    	add    $0x52020,%rax
   411a3:	48 89 c7             	mov    %rax,%rdi
   411a6:	e8 07 00 00 00       	call   411b2 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   411ab:	e8 73 17 00 00       	call   42923 <check_keyboard>
        pid = (pid + 1) % NPROC;
   411b0:	eb 9e                	jmp    41150 <schedule+0x14>

00000000000411b2 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   411b2:	55                   	push   %rbp
   411b3:	48 89 e5             	mov    %rsp,%rbp
   411b6:	48 83 ec 10          	sub    $0x10,%rsp
   411ba:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   411be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   411c2:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   411c8:	83 f8 01             	cmp    $0x1,%eax
   411cb:	74 14                	je     411e1 <run+0x2f>
   411cd:	ba d0 48 04 00       	mov    $0x448d0,%edx
   411d2:	be 60 02 00 00       	mov    $0x260,%esi
   411d7:	bf a0 46 04 00       	mov    $0x446a0,%edi
   411dc:	e8 63 19 00 00       	call   42b44 <assert_fail>
    current = p;
   411e1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   411e5:	48 89 05 14 0e 01 00 	mov    %rax,0x10e14(%rip)        # 52000 <current>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   411ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   411f0:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   411f7:	48 89 c7             	mov    %rax,%rdi
   411fa:	e8 13 1b 00 00       	call   42d12 <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   411ff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41203:	48 83 c0 08          	add    $0x8,%rax
   41207:	48 89 c7             	mov    %rax,%rdi
   4120a:	e8 b4 ee ff ff       	call   400c3 <exception_return>

000000000004120f <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   4120f:	55                   	push   %rbp
   41210:	48 89 e5             	mov    %rsp,%rbp
   41213:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   41217:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   4121e:	00 
   4121f:	e9 81 00 00 00       	jmp    412a5 <pageinfo_init+0x96>
        int owner;
        if (physical_memory_isreserved(addr)) {
   41224:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41228:	48 89 c7             	mov    %rax,%rdi
   4122b:	e8 81 0f 00 00       	call   421b1 <physical_memory_isreserved>
   41230:	85 c0                	test   %eax,%eax
   41232:	74 09                	je     4123d <pageinfo_init+0x2e>
            owner = PO_RESERVED;
   41234:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   4123b:	eb 2f                	jmp    4126c <pageinfo_init+0x5d>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   4123d:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   41244:	00 
   41245:	76 0b                	jbe    41252 <pageinfo_init+0x43>
   41247:	b8 08 b0 05 00       	mov    $0x5b008,%eax
   4124c:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41250:	72 0a                	jb     4125c <pageinfo_init+0x4d>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   41252:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   41259:	00 
   4125a:	75 09                	jne    41265 <pageinfo_init+0x56>
            owner = PO_KERNEL;
   4125c:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   41263:	eb 07                	jmp    4126c <pageinfo_init+0x5d>
        } else {
            owner = PO_FREE;
   41265:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   4126c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41270:	48 c1 e8 0c          	shr    $0xc,%rax
   41274:	89 c1                	mov    %eax,%ecx
   41276:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41279:	89 c2                	mov    %eax,%edx
   4127b:	48 63 c1             	movslq %ecx,%rax
   4127e:	88 94 00 40 2e 05 00 	mov    %dl,0x52e40(%rax,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   41285:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41289:	0f 95 c2             	setne  %dl
   4128c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41290:	48 c1 e8 0c          	shr    $0xc,%rax
   41294:	48 98                	cltq   
   41296:	88 94 00 41 2e 05 00 	mov    %dl,0x52e41(%rax,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   4129d:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   412a4:	00 
   412a5:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   412ac:	00 
   412ad:	0f 86 71 ff ff ff    	jbe    41224 <pageinfo_init+0x15>
    }
}
   412b3:	90                   	nop
   412b4:	90                   	nop
   412b5:	c9                   	leave  
   412b6:	c3                   	ret    

00000000000412b7 <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   412b7:	55                   	push   %rbp
   412b8:	48 89 e5             	mov    %rsp,%rbp
   412bb:	48 83 ec 50          	sub    $0x50,%rsp
   412bf:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   412c3:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   412c7:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   412cd:	48 89 c2             	mov    %rax,%rdx
   412d0:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   412d4:	48 39 c2             	cmp    %rax,%rdx
   412d7:	74 14                	je     412ed <check_page_table_mappings+0x36>
   412d9:	ba f0 48 04 00       	mov    $0x448f0,%edx
   412de:	be 8a 02 00 00       	mov    $0x28a,%esi
   412e3:	bf a0 46 04 00       	mov    $0x446a0,%edi
   412e8:	e8 57 18 00 00       	call   42b44 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   412ed:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   412f4:	00 
   412f5:	e9 9a 00 00 00       	jmp    41394 <check_page_table_mappings+0xdd>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   412fa:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   412fe:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   41302:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   41306:	48 89 ce             	mov    %rcx,%rsi
   41309:	48 89 c7             	mov    %rax,%rdi
   4130c:	e8 f8 1e 00 00       	call   43209 <virtual_memory_lookup>
        if (vam.pa != va) {
   41311:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41315:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41319:	74 27                	je     41342 <check_page_table_mappings+0x8b>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   4131b:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   4131f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41323:	49 89 d0             	mov    %rdx,%r8
   41326:	48 89 c1             	mov    %rax,%rcx
   41329:	ba 0f 49 04 00       	mov    $0x4490f,%edx
   4132e:	be 00 c0 00 00       	mov    $0xc000,%esi
   41333:	bf e0 06 00 00       	mov    $0x6e0,%edi
   41338:	b8 00 00 00 00       	mov    $0x0,%eax
   4133d:	e8 94 31 00 00       	call   444d6 <console_printf>
        }
        assert(vam.pa == va);
   41342:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41346:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4134a:	74 14                	je     41360 <check_page_table_mappings+0xa9>
   4134c:	ba 19 49 04 00       	mov    $0x44919,%edx
   41351:	be 93 02 00 00       	mov    $0x293,%esi
   41356:	bf a0 46 04 00       	mov    $0x446a0,%edi
   4135b:	e8 e4 17 00 00       	call   42b44 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   41360:	b8 00 60 04 00       	mov    $0x46000,%eax
   41365:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41369:	72 21                	jb     4138c <check_page_table_mappings+0xd5>
            assert(vam.perm & PTE_W);
   4136b:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4136e:	48 98                	cltq   
   41370:	83 e0 02             	and    $0x2,%eax
   41373:	48 85 c0             	test   %rax,%rax
   41376:	75 14                	jne    4138c <check_page_table_mappings+0xd5>
   41378:	ba 26 49 04 00       	mov    $0x44926,%edx
   4137d:	be 95 02 00 00       	mov    $0x295,%esi
   41382:	bf a0 46 04 00       	mov    $0x446a0,%edi
   41387:	e8 b8 17 00 00       	call   42b44 <assert_fail>
         va += PAGESIZE) {
   4138c:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41393:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   41394:	b8 08 b0 05 00       	mov    $0x5b008,%eax
   41399:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4139d:	0f 82 57 ff ff ff    	jb     412fa <check_page_table_mappings+0x43>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   413a3:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   413aa:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   413ab:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   413af:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   413b3:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   413b7:	48 89 ce             	mov    %rcx,%rsi
   413ba:	48 89 c7             	mov    %rax,%rdi
   413bd:	e8 47 1e 00 00       	call   43209 <virtual_memory_lookup>
    assert(vam.pa == kstack);
   413c2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   413c6:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   413ca:	74 14                	je     413e0 <check_page_table_mappings+0x129>
   413cc:	ba 37 49 04 00       	mov    $0x44937,%edx
   413d1:	be 9c 02 00 00       	mov    $0x29c,%esi
   413d6:	bf a0 46 04 00       	mov    $0x446a0,%edi
   413db:	e8 64 17 00 00       	call   42b44 <assert_fail>
    assert(vam.perm & PTE_W);
   413e0:	8b 45 e8             	mov    -0x18(%rbp),%eax
   413e3:	48 98                	cltq   
   413e5:	83 e0 02             	and    $0x2,%eax
   413e8:	48 85 c0             	test   %rax,%rax
   413eb:	75 14                	jne    41401 <check_page_table_mappings+0x14a>
   413ed:	ba 26 49 04 00       	mov    $0x44926,%edx
   413f2:	be 9d 02 00 00       	mov    $0x29d,%esi
   413f7:	bf a0 46 04 00       	mov    $0x446a0,%edi
   413fc:	e8 43 17 00 00       	call   42b44 <assert_fail>
}
   41401:	90                   	nop
   41402:	c9                   	leave  
   41403:	c3                   	ret    

0000000000041404 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   41404:	55                   	push   %rbp
   41405:	48 89 e5             	mov    %rsp,%rbp
   41408:	48 83 ec 20          	sub    $0x20,%rsp
   4140c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   41410:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   41413:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   41416:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   41419:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   41420:	48 8b 05 d9 3b 01 00 	mov    0x13bd9(%rip),%rax        # 55000 <kernel_pagetable>
   41427:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   4142b:	75 67                	jne    41494 <check_page_table_ownership+0x90>
        owner = PO_KERNEL;
   4142d:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   41434:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   4143b:	eb 51                	jmp    4148e <check_page_table_ownership+0x8a>
            if (processes[xpid].p_state != P_FREE
   4143d:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41440:	48 63 d0             	movslq %eax,%rdx
   41443:	48 89 d0             	mov    %rdx,%rax
   41446:	48 c1 e0 03          	shl    $0x3,%rax
   4144a:	48 29 d0             	sub    %rdx,%rax
   4144d:	48 c1 e0 05          	shl    $0x5,%rax
   41451:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   41457:	8b 00                	mov    (%rax),%eax
   41459:	85 c0                	test   %eax,%eax
   4145b:	74 2d                	je     4148a <check_page_table_ownership+0x86>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   4145d:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41460:	48 63 d0             	movslq %eax,%rdx
   41463:	48 89 d0             	mov    %rdx,%rax
   41466:	48 c1 e0 03          	shl    $0x3,%rax
   4146a:	48 29 d0             	sub    %rdx,%rax
   4146d:	48 c1 e0 05          	shl    $0x5,%rax
   41471:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   41477:	48 8b 10             	mov    (%rax),%rdx
   4147a:	48 8b 05 7f 3b 01 00 	mov    0x13b7f(%rip),%rax        # 55000 <kernel_pagetable>
   41481:	48 39 c2             	cmp    %rax,%rdx
   41484:	75 04                	jne    4148a <check_page_table_ownership+0x86>
                ++expected_refcount;
   41486:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   4148a:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   4148e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   41492:	7e a9                	jle    4143d <check_page_table_ownership+0x39>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   41494:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41497:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4149a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4149e:	be 00 00 00 00       	mov    $0x0,%esi
   414a3:	48 89 c7             	mov    %rax,%rdi
   414a6:	e8 03 00 00 00       	call   414ae <check_page_table_ownership_level>
}
   414ab:	90                   	nop
   414ac:	c9                   	leave  
   414ad:	c3                   	ret    

00000000000414ae <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   414ae:	55                   	push   %rbp
   414af:	48 89 e5             	mov    %rsp,%rbp
   414b2:	48 83 ec 30          	sub    $0x30,%rsp
   414b6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   414ba:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   414bd:	89 55 e0             	mov    %edx,-0x20(%rbp)
   414c0:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   414c3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   414c7:	48 c1 e8 0c          	shr    $0xc,%rax
   414cb:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   414d0:	7e 14                	jle    414e6 <check_page_table_ownership_level+0x38>
   414d2:	ba 48 49 04 00       	mov    $0x44948,%edx
   414d7:	be ba 02 00 00       	mov    $0x2ba,%esi
   414dc:	bf a0 46 04 00       	mov    $0x446a0,%edi
   414e1:	e8 5e 16 00 00       	call   42b44 <assert_fail>
    if (pageinfo[PAGENUMBER(pt)].owner != owner) {
   414e6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   414ea:	48 c1 e8 0c          	shr    $0xc,%rax
   414ee:	48 98                	cltq   
   414f0:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   414f7:	00 
   414f8:	0f be c0             	movsbl %al,%eax
   414fb:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   414fe:	74 34                	je     41534 <check_page_table_ownership_level+0x86>
	panic("pt addr: %p, supposed owner of pt: %d, actual owner of pt: %d, refcount: %d", pt, owner, pageinfo[PAGENUMBER(pt)].owner,
   41500:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41504:	48 c1 e8 0c          	shr    $0xc,%rax
   41508:	48 98                	cltq   
   4150a:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   41511:	00 
   41512:	0f be c8             	movsbl %al,%ecx
   41515:	8b 75 dc             	mov    -0x24(%rbp),%esi
   41518:	8b 55 e0             	mov    -0x20(%rbp),%edx
   4151b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4151f:	41 89 f0             	mov    %esi,%r8d
   41522:	48 89 c6             	mov    %rax,%rsi
   41525:	bf 60 49 04 00       	mov    $0x44960,%edi
   4152a:	b8 00 00 00 00       	mov    $0x0,%eax
   4152f:	e8 30 15 00 00       	call   42a64 <panic>
			refcount);
    }
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   41534:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41538:	48 c1 e8 0c          	shr    $0xc,%rax
   4153c:	48 98                	cltq   
   4153e:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   41545:	00 
   41546:	0f be c0             	movsbl %al,%eax
   41549:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   4154c:	74 14                	je     41562 <check_page_table_ownership_level+0xb4>
   4154e:	ba b0 49 04 00       	mov    $0x449b0,%edx
   41553:	be bf 02 00 00       	mov    $0x2bf,%esi
   41558:	bf a0 46 04 00       	mov    $0x446a0,%edi
   4155d:	e8 e2 15 00 00       	call   42b44 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   41562:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41566:	48 c1 e8 0c          	shr    $0xc,%rax
   4156a:	48 98                	cltq   
   4156c:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   41573:	00 
   41574:	0f be c0             	movsbl %al,%eax
   41577:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   4157a:	74 14                	je     41590 <check_page_table_ownership_level+0xe2>
   4157c:	ba d8 49 04 00       	mov    $0x449d8,%edx
   41581:	be c0 02 00 00       	mov    $0x2c0,%esi
   41586:	bf a0 46 04 00       	mov    $0x446a0,%edi
   4158b:	e8 b4 15 00 00       	call   42b44 <assert_fail>
    if (level < 3) {
   41590:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   41594:	7f 5b                	jg     415f1 <check_page_table_ownership_level+0x143>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   41596:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4159d:	eb 49                	jmp    415e8 <check_page_table_ownership_level+0x13a>
            if (pt->entry[index]) {
   4159f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   415a3:	8b 55 fc             	mov    -0x4(%rbp),%edx
   415a6:	48 63 d2             	movslq %edx,%rdx
   415a9:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   415ad:	48 85 c0             	test   %rax,%rax
   415b0:	74 32                	je     415e4 <check_page_table_ownership_level+0x136>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   415b2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   415b6:	8b 55 fc             	mov    -0x4(%rbp),%edx
   415b9:	48 63 d2             	movslq %edx,%rdx
   415bc:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   415c0:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   415c6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   415ca:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   415cd:	8d 70 01             	lea    0x1(%rax),%esi
   415d0:	8b 55 e0             	mov    -0x20(%rbp),%edx
   415d3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   415d7:	b9 01 00 00 00       	mov    $0x1,%ecx
   415dc:	48 89 c7             	mov    %rax,%rdi
   415df:	e8 ca fe ff ff       	call   414ae <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   415e4:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   415e8:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   415ef:	7e ae                	jle    4159f <check_page_table_ownership_level+0xf1>
            }
        }
    }
}
   415f1:	90                   	nop
   415f2:	c9                   	leave  
   415f3:	c3                   	ret    

00000000000415f4 <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   415f4:	55                   	push   %rbp
   415f5:	48 89 e5             	mov    %rsp,%rbp
   415f8:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   415fc:	8b 05 e6 0a 01 00    	mov    0x10ae6(%rip),%eax        # 520e8 <processes+0xc8>
   41602:	85 c0                	test   %eax,%eax
   41604:	74 14                	je     4161a <check_virtual_memory+0x26>
   41606:	ba 08 4a 04 00       	mov    $0x44a08,%edx
   4160b:	be d3 02 00 00       	mov    $0x2d3,%esi
   41610:	bf a0 46 04 00       	mov    $0x446a0,%edi
   41615:	e8 2a 15 00 00       	call   42b44 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   4161a:	48 8b 05 df 39 01 00 	mov    0x139df(%rip),%rax        # 55000 <kernel_pagetable>
   41621:	48 89 c7             	mov    %rax,%rdi
   41624:	e8 8e fc ff ff       	call   412b7 <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   41629:	48 8b 05 d0 39 01 00 	mov    0x139d0(%rip),%rax        # 55000 <kernel_pagetable>
   41630:	be ff ff ff ff       	mov    $0xffffffff,%esi
   41635:	48 89 c7             	mov    %rax,%rdi
   41638:	e8 c7 fd ff ff       	call   41404 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   4163d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41644:	e9 9c 00 00 00       	jmp    416e5 <check_virtual_memory+0xf1>
        if (processes[pid].p_state != P_FREE
   41649:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4164c:	48 63 d0             	movslq %eax,%rdx
   4164f:	48 89 d0             	mov    %rdx,%rax
   41652:	48 c1 e0 03          	shl    $0x3,%rax
   41656:	48 29 d0             	sub    %rdx,%rax
   41659:	48 c1 e0 05          	shl    $0x5,%rax
   4165d:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   41663:	8b 00                	mov    (%rax),%eax
   41665:	85 c0                	test   %eax,%eax
   41667:	74 78                	je     416e1 <check_virtual_memory+0xed>
            && processes[pid].p_pagetable != kernel_pagetable) {
   41669:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4166c:	48 63 d0             	movslq %eax,%rdx
   4166f:	48 89 d0             	mov    %rdx,%rax
   41672:	48 c1 e0 03          	shl    $0x3,%rax
   41676:	48 29 d0             	sub    %rdx,%rax
   41679:	48 c1 e0 05          	shl    $0x5,%rax
   4167d:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   41683:	48 8b 10             	mov    (%rax),%rdx
   41686:	48 8b 05 73 39 01 00 	mov    0x13973(%rip),%rax        # 55000 <kernel_pagetable>
   4168d:	48 39 c2             	cmp    %rax,%rdx
   41690:	74 4f                	je     416e1 <check_virtual_memory+0xed>
            check_page_table_mappings(processes[pid].p_pagetable);
   41692:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41695:	48 63 d0             	movslq %eax,%rdx
   41698:	48 89 d0             	mov    %rdx,%rax
   4169b:	48 c1 e0 03          	shl    $0x3,%rax
   4169f:	48 29 d0             	sub    %rdx,%rax
   416a2:	48 c1 e0 05          	shl    $0x5,%rax
   416a6:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   416ac:	48 8b 00             	mov    (%rax),%rax
   416af:	48 89 c7             	mov    %rax,%rdi
   416b2:	e8 00 fc ff ff       	call   412b7 <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   416b7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   416ba:	48 63 d0             	movslq %eax,%rdx
   416bd:	48 89 d0             	mov    %rdx,%rax
   416c0:	48 c1 e0 03          	shl    $0x3,%rax
   416c4:	48 29 d0             	sub    %rdx,%rax
   416c7:	48 c1 e0 05          	shl    $0x5,%rax
   416cb:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   416d1:	48 8b 00             	mov    (%rax),%rax
   416d4:	8b 55 fc             	mov    -0x4(%rbp),%edx
   416d7:	89 d6                	mov    %edx,%esi
   416d9:	48 89 c7             	mov    %rax,%rdi
   416dc:	e8 23 fd ff ff       	call   41404 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   416e1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   416e5:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   416e9:	0f 8e 5a ff ff ff    	jle    41649 <check_virtual_memory+0x55>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   416ef:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   416f6:	eb 67                	jmp    4175f <check_virtual_memory+0x16b>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   416f8:	8b 45 f8             	mov    -0x8(%rbp),%eax
   416fb:	48 98                	cltq   
   416fd:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   41704:	00 
   41705:	84 c0                	test   %al,%al
   41707:	7e 52                	jle    4175b <check_virtual_memory+0x167>
   41709:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4170c:	48 98                	cltq   
   4170e:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   41715:	00 
   41716:	84 c0                	test   %al,%al
   41718:	78 41                	js     4175b <check_virtual_memory+0x167>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   4171a:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4171d:	48 98                	cltq   
   4171f:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   41726:	00 
   41727:	0f be c0             	movsbl %al,%eax
   4172a:	48 63 d0             	movslq %eax,%rdx
   4172d:	48 89 d0             	mov    %rdx,%rax
   41730:	48 c1 e0 03          	shl    $0x3,%rax
   41734:	48 29 d0             	sub    %rdx,%rax
   41737:	48 c1 e0 05          	shl    $0x5,%rax
   4173b:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   41741:	8b 00                	mov    (%rax),%eax
   41743:	85 c0                	test   %eax,%eax
   41745:	75 14                	jne    4175b <check_virtual_memory+0x167>
   41747:	ba 28 4a 04 00       	mov    $0x44a28,%edx
   4174c:	be ea 02 00 00       	mov    $0x2ea,%esi
   41751:	bf a0 46 04 00       	mov    $0x446a0,%edi
   41756:	e8 e9 13 00 00       	call   42b44 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4175b:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   4175f:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   41766:	7e 90                	jle    416f8 <check_virtual_memory+0x104>
        }
    }
}
   41768:	90                   	nop
   41769:	90                   	nop
   4176a:	c9                   	leave  
   4176b:	c3                   	ret    

000000000004176c <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   4176c:	55                   	push   %rbp
   4176d:	48 89 e5             	mov    %rsp,%rbp
   41770:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   41774:	ba 86 4a 04 00       	mov    $0x44a86,%edx
   41779:	be 00 0f 00 00       	mov    $0xf00,%esi
   4177e:	bf 20 00 00 00       	mov    $0x20,%edi
   41783:	b8 00 00 00 00       	mov    $0x0,%eax
   41788:	e8 49 2d 00 00       	call   444d6 <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4178d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41794:	e9 f8 00 00 00       	jmp    41891 <memshow_physical+0x125>
        if (pn % 64 == 0) {
   41799:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4179c:	83 e0 3f             	and    $0x3f,%eax
   4179f:	85 c0                	test   %eax,%eax
   417a1:	75 3c                	jne    417df <memshow_physical+0x73>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   417a3:	8b 45 fc             	mov    -0x4(%rbp),%eax
   417a6:	c1 e0 0c             	shl    $0xc,%eax
   417a9:	89 c1                	mov    %eax,%ecx
   417ab:	8b 45 fc             	mov    -0x4(%rbp),%eax
   417ae:	8d 50 3f             	lea    0x3f(%rax),%edx
   417b1:	85 c0                	test   %eax,%eax
   417b3:	0f 48 c2             	cmovs  %edx,%eax
   417b6:	c1 f8 06             	sar    $0x6,%eax
   417b9:	8d 50 01             	lea    0x1(%rax),%edx
   417bc:	89 d0                	mov    %edx,%eax
   417be:	c1 e0 02             	shl    $0x2,%eax
   417c1:	01 d0                	add    %edx,%eax
   417c3:	c1 e0 04             	shl    $0x4,%eax
   417c6:	83 c0 03             	add    $0x3,%eax
   417c9:	ba 96 4a 04 00       	mov    $0x44a96,%edx
   417ce:	be 00 0f 00 00       	mov    $0xf00,%esi
   417d3:	89 c7                	mov    %eax,%edi
   417d5:	b8 00 00 00 00       	mov    $0x0,%eax
   417da:	e8 f7 2c 00 00       	call   444d6 <console_printf>
        }

        int owner = pageinfo[pn].owner;
   417df:	8b 45 fc             	mov    -0x4(%rbp),%eax
   417e2:	48 98                	cltq   
   417e4:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   417eb:	00 
   417ec:	0f be c0             	movsbl %al,%eax
   417ef:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   417f2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   417f5:	48 98                	cltq   
   417f7:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   417fe:	00 
   417ff:	84 c0                	test   %al,%al
   41801:	75 07                	jne    4180a <memshow_physical+0x9e>
            owner = PO_FREE;
   41803:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   4180a:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4180d:	83 c0 02             	add    $0x2,%eax
   41810:	48 98                	cltq   
   41812:	0f b7 84 00 60 4a 04 	movzwl 0x44a60(%rax,%rax,1),%eax
   41819:	00 
   4181a:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   4181e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41821:	48 98                	cltq   
   41823:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   4182a:	00 
   4182b:	3c 01                	cmp    $0x1,%al
   4182d:	7e 1a                	jle    41849 <memshow_physical+0xdd>
   4182f:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   41834:	48 c1 e8 0c          	shr    $0xc,%rax
   41838:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   4183b:	74 0c                	je     41849 <memshow_physical+0xdd>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   4183d:	b8 53 00 00 00       	mov    $0x53,%eax
   41842:	80 cc 0f             	or     $0xf,%ah
   41845:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   41849:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4184c:	8d 50 3f             	lea    0x3f(%rax),%edx
   4184f:	85 c0                	test   %eax,%eax
   41851:	0f 48 c2             	cmovs  %edx,%eax
   41854:	c1 f8 06             	sar    $0x6,%eax
   41857:	8d 50 01             	lea    0x1(%rax),%edx
   4185a:	89 d0                	mov    %edx,%eax
   4185c:	c1 e0 02             	shl    $0x2,%eax
   4185f:	01 d0                	add    %edx,%eax
   41861:	c1 e0 04             	shl    $0x4,%eax
   41864:	89 c1                	mov    %eax,%ecx
   41866:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41869:	89 d0                	mov    %edx,%eax
   4186b:	c1 f8 1f             	sar    $0x1f,%eax
   4186e:	c1 e8 1a             	shr    $0x1a,%eax
   41871:	01 c2                	add    %eax,%edx
   41873:	83 e2 3f             	and    $0x3f,%edx
   41876:	29 c2                	sub    %eax,%edx
   41878:	89 d0                	mov    %edx,%eax
   4187a:	83 c0 0c             	add    $0xc,%eax
   4187d:	01 c8                	add    %ecx,%eax
   4187f:	48 98                	cltq   
   41881:	0f b7 55 f6          	movzwl -0xa(%rbp),%edx
   41885:	66 89 94 00 00 80 0b 	mov    %dx,0xb8000(%rax,%rax,1)
   4188c:	00 
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4188d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41891:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41898:	0f 8e fb fe ff ff    	jle    41799 <memshow_physical+0x2d>
    }
}
   4189e:	90                   	nop
   4189f:	90                   	nop
   418a0:	c9                   	leave  
   418a1:	c3                   	ret    

00000000000418a2 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   418a2:	55                   	push   %rbp
   418a3:	48 89 e5             	mov    %rsp,%rbp
   418a6:	48 83 ec 40          	sub    $0x40,%rsp
   418aa:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   418ae:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   418b2:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   418b6:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   418bc:	48 89 c2             	mov    %rax,%rdx
   418bf:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   418c3:	48 39 c2             	cmp    %rax,%rdx
   418c6:	74 14                	je     418dc <memshow_virtual+0x3a>
   418c8:	ba a0 4a 04 00       	mov    $0x44aa0,%edx
   418cd:	be 1b 03 00 00       	mov    $0x31b,%esi
   418d2:	bf a0 46 04 00       	mov    $0x446a0,%edi
   418d7:	e8 68 12 00 00       	call   42b44 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   418dc:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   418e0:	48 89 c1             	mov    %rax,%rcx
   418e3:	ba cd 4a 04 00       	mov    $0x44acd,%edx
   418e8:	be 00 0f 00 00       	mov    $0xf00,%esi
   418ed:	bf 3a 03 00 00       	mov    $0x33a,%edi
   418f2:	b8 00 00 00 00       	mov    $0x0,%eax
   418f7:	e8 da 2b 00 00       	call   444d6 <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   418fc:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   41903:	00 
   41904:	e9 80 01 00 00       	jmp    41a89 <memshow_virtual+0x1e7>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   41909:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4190d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   41911:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   41915:	48 89 ce             	mov    %rcx,%rsi
   41918:	48 89 c7             	mov    %rax,%rdi
   4191b:	e8 e9 18 00 00       	call   43209 <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   41920:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41923:	85 c0                	test   %eax,%eax
   41925:	79 0b                	jns    41932 <memshow_virtual+0x90>
            color = ' ';
   41927:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   4192d:	e9 d7 00 00 00       	jmp    41a09 <memshow_virtual+0x167>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   41932:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41936:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   4193c:	76 14                	jbe    41952 <memshow_virtual+0xb0>
   4193e:	ba ea 4a 04 00       	mov    $0x44aea,%edx
   41943:	be 24 03 00 00       	mov    $0x324,%esi
   41948:	bf a0 46 04 00       	mov    $0x446a0,%edi
   4194d:	e8 f2 11 00 00       	call   42b44 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   41952:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41955:	48 98                	cltq   
   41957:	0f b6 84 00 40 2e 05 	movzbl 0x52e40(%rax,%rax,1),%eax
   4195e:	00 
   4195f:	0f be c0             	movsbl %al,%eax
   41962:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   41965:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41968:	48 98                	cltq   
   4196a:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   41971:	00 
   41972:	84 c0                	test   %al,%al
   41974:	75 07                	jne    4197d <memshow_virtual+0xdb>
                owner = PO_FREE;
   41976:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   4197d:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41980:	83 c0 02             	add    $0x2,%eax
   41983:	48 98                	cltq   
   41985:	0f b7 84 00 60 4a 04 	movzwl 0x44a60(%rax,%rax,1),%eax
   4198c:	00 
   4198d:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   41991:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41994:	48 98                	cltq   
   41996:	83 e0 04             	and    $0x4,%eax
   41999:	48 85 c0             	test   %rax,%rax
   4199c:	74 27                	je     419c5 <memshow_virtual+0x123>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   4199e:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   419a2:	c1 e0 04             	shl    $0x4,%eax
   419a5:	66 25 00 f0          	and    $0xf000,%ax
   419a9:	89 c2                	mov    %eax,%edx
   419ab:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   419af:	c1 f8 04             	sar    $0x4,%eax
   419b2:	66 25 00 0f          	and    $0xf00,%ax
   419b6:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   419b8:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   419bc:	0f b6 c0             	movzbl %al,%eax
   419bf:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   419c1:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   419c5:	8b 45 d0             	mov    -0x30(%rbp),%eax
   419c8:	48 98                	cltq   
   419ca:	0f b6 84 00 41 2e 05 	movzbl 0x52e41(%rax,%rax,1),%eax
   419d1:	00 
   419d2:	3c 01                	cmp    $0x1,%al
   419d4:	7e 33                	jle    41a09 <memshow_virtual+0x167>
   419d6:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   419db:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   419df:	74 28                	je     41a09 <memshow_virtual+0x167>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   419e1:	b8 53 00 00 00       	mov    $0x53,%eax
   419e6:	89 c2                	mov    %eax,%edx
   419e8:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   419ec:	66 25 00 f0          	and    $0xf000,%ax
   419f0:	09 d0                	or     %edx,%eax
   419f2:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   419f6:	8b 45 e0             	mov    -0x20(%rbp),%eax
   419f9:	48 98                	cltq   
   419fb:	83 e0 04             	and    $0x4,%eax
   419fe:	48 85 c0             	test   %rax,%rax
   41a01:	75 06                	jne    41a09 <memshow_virtual+0x167>
                    color = color | 0x0F00;
   41a03:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   41a09:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41a0d:	48 c1 e8 0c          	shr    $0xc,%rax
   41a11:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   41a14:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41a17:	83 e0 3f             	and    $0x3f,%eax
   41a1a:	85 c0                	test   %eax,%eax
   41a1c:	75 34                	jne    41a52 <memshow_virtual+0x1b0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   41a1e:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41a21:	c1 e8 06             	shr    $0x6,%eax
   41a24:	89 c2                	mov    %eax,%edx
   41a26:	89 d0                	mov    %edx,%eax
   41a28:	c1 e0 02             	shl    $0x2,%eax
   41a2b:	01 d0                	add    %edx,%eax
   41a2d:	c1 e0 04             	shl    $0x4,%eax
   41a30:	05 73 03 00 00       	add    $0x373,%eax
   41a35:	89 c7                	mov    %eax,%edi
   41a37:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41a3b:	48 89 c1             	mov    %rax,%rcx
   41a3e:	ba 96 4a 04 00       	mov    $0x44a96,%edx
   41a43:	be 00 0f 00 00       	mov    $0xf00,%esi
   41a48:	b8 00 00 00 00       	mov    $0x0,%eax
   41a4d:	e8 84 2a 00 00       	call   444d6 <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   41a52:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41a55:	c1 e8 06             	shr    $0x6,%eax
   41a58:	89 c2                	mov    %eax,%edx
   41a5a:	89 d0                	mov    %edx,%eax
   41a5c:	c1 e0 02             	shl    $0x2,%eax
   41a5f:	01 d0                	add    %edx,%eax
   41a61:	c1 e0 04             	shl    $0x4,%eax
   41a64:	89 c2                	mov    %eax,%edx
   41a66:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41a69:	83 e0 3f             	and    $0x3f,%eax
   41a6c:	01 d0                	add    %edx,%eax
   41a6e:	05 7c 03 00 00       	add    $0x37c,%eax
   41a73:	89 c2                	mov    %eax,%edx
   41a75:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41a79:	66 89 84 12 00 80 0b 	mov    %ax,0xb8000(%rdx,%rdx,1)
   41a80:	00 
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41a81:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41a88:	00 
   41a89:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   41a90:	00 
   41a91:	0f 86 72 fe ff ff    	jbe    41909 <memshow_virtual+0x67>
    }
}
   41a97:	90                   	nop
   41a98:	90                   	nop
   41a99:	c9                   	leave  
   41a9a:	c3                   	ret    

0000000000041a9b <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   41a9b:	55                   	push   %rbp
   41a9c:	48 89 e5             	mov    %rsp,%rbp
   41a9f:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   41aa3:	8b 05 97 17 01 00    	mov    0x11797(%rip),%eax        # 53240 <last_ticks.1>
   41aa9:	85 c0                	test   %eax,%eax
   41aab:	74 13                	je     41ac0 <memshow_virtual_animate+0x25>
   41aad:	8b 15 6d 13 01 00    	mov    0x1136d(%rip),%edx        # 52e20 <ticks>
   41ab3:	8b 05 87 17 01 00    	mov    0x11787(%rip),%eax        # 53240 <last_ticks.1>
   41ab9:	29 c2                	sub    %eax,%edx
   41abb:	83 fa 31             	cmp    $0x31,%edx
   41abe:	76 2c                	jbe    41aec <memshow_virtual_animate+0x51>
        last_ticks = ticks;
   41ac0:	8b 05 5a 13 01 00    	mov    0x1135a(%rip),%eax        # 52e20 <ticks>
   41ac6:	89 05 74 17 01 00    	mov    %eax,0x11774(%rip)        # 53240 <last_ticks.1>
        ++showing;
   41acc:	8b 05 32 45 00 00    	mov    0x4532(%rip),%eax        # 46004 <showing.0>
   41ad2:	83 c0 01             	add    $0x1,%eax
   41ad5:	89 05 29 45 00 00    	mov    %eax,0x4529(%rip)        # 46004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   41adb:	eb 0f                	jmp    41aec <memshow_virtual_animate+0x51>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
        ++showing;
   41add:	8b 05 21 45 00 00    	mov    0x4521(%rip),%eax        # 46004 <showing.0>
   41ae3:	83 c0 01             	add    $0x1,%eax
   41ae6:	89 05 18 45 00 00    	mov    %eax,0x4518(%rip)        # 46004 <showing.0>
    while (showing <= 2*NPROC
   41aec:	8b 05 12 45 00 00    	mov    0x4512(%rip),%eax        # 46004 <showing.0>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
   41af2:	83 f8 20             	cmp    $0x20,%eax
   41af5:	7f 6d                	jg     41b64 <memshow_virtual_animate+0xc9>
   41af7:	8b 15 07 45 00 00    	mov    0x4507(%rip),%edx        # 46004 <showing.0>
   41afd:	89 d0                	mov    %edx,%eax
   41aff:	c1 f8 1f             	sar    $0x1f,%eax
   41b02:	c1 e8 1c             	shr    $0x1c,%eax
   41b05:	01 c2                	add    %eax,%edx
   41b07:	83 e2 0f             	and    $0xf,%edx
   41b0a:	29 c2                	sub    %eax,%edx
   41b0c:	89 d0                	mov    %edx,%eax
   41b0e:	48 63 d0             	movslq %eax,%rdx
   41b11:	48 89 d0             	mov    %rdx,%rax
   41b14:	48 c1 e0 03          	shl    $0x3,%rax
   41b18:	48 29 d0             	sub    %rdx,%rax
   41b1b:	48 c1 e0 05          	shl    $0x5,%rax
   41b1f:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   41b25:	8b 00                	mov    (%rax),%eax
   41b27:	85 c0                	test   %eax,%eax
   41b29:	74 b2                	je     41add <memshow_virtual_animate+0x42>
   41b2b:	8b 15 d3 44 00 00    	mov    0x44d3(%rip),%edx        # 46004 <showing.0>
   41b31:	89 d0                	mov    %edx,%eax
   41b33:	c1 f8 1f             	sar    $0x1f,%eax
   41b36:	c1 e8 1c             	shr    $0x1c,%eax
   41b39:	01 c2                	add    %eax,%edx
   41b3b:	83 e2 0f             	and    $0xf,%edx
   41b3e:	29 c2                	sub    %eax,%edx
   41b40:	89 d0                	mov    %edx,%eax
   41b42:	48 63 d0             	movslq %eax,%rdx
   41b45:	48 89 d0             	mov    %rdx,%rax
   41b48:	48 c1 e0 03          	shl    $0x3,%rax
   41b4c:	48 29 d0             	sub    %rdx,%rax
   41b4f:	48 c1 e0 05          	shl    $0x5,%rax
   41b53:	48 05 f8 20 05 00    	add    $0x520f8,%rax
   41b59:	0f b6 00             	movzbl (%rax),%eax
   41b5c:	84 c0                	test   %al,%al
   41b5e:	0f 84 79 ff ff ff    	je     41add <memshow_virtual_animate+0x42>
    }
    showing = showing % NPROC;
   41b64:	8b 15 9a 44 00 00    	mov    0x449a(%rip),%edx        # 46004 <showing.0>
   41b6a:	89 d0                	mov    %edx,%eax
   41b6c:	c1 f8 1f             	sar    $0x1f,%eax
   41b6f:	c1 e8 1c             	shr    $0x1c,%eax
   41b72:	01 c2                	add    %eax,%edx
   41b74:	83 e2 0f             	and    $0xf,%edx
   41b77:	29 c2                	sub    %eax,%edx
   41b79:	89 d0                	mov    %edx,%eax
   41b7b:	89 05 83 44 00 00    	mov    %eax,0x4483(%rip)        # 46004 <showing.0>

    if (processes[showing].p_state != P_FREE) {
   41b81:	8b 05 7d 44 00 00    	mov    0x447d(%rip),%eax        # 46004 <showing.0>
   41b87:	48 63 d0             	movslq %eax,%rdx
   41b8a:	48 89 d0             	mov    %rdx,%rax
   41b8d:	48 c1 e0 03          	shl    $0x3,%rax
   41b91:	48 29 d0             	sub    %rdx,%rax
   41b94:	48 c1 e0 05          	shl    $0x5,%rax
   41b98:	48 05 e8 20 05 00    	add    $0x520e8,%rax
   41b9e:	8b 00                	mov    (%rax),%eax
   41ba0:	85 c0                	test   %eax,%eax
   41ba2:	74 52                	je     41bf6 <memshow_virtual_animate+0x15b>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   41ba4:	8b 15 5a 44 00 00    	mov    0x445a(%rip),%edx        # 46004 <showing.0>
   41baa:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   41bae:	89 d1                	mov    %edx,%ecx
   41bb0:	ba 04 4b 04 00       	mov    $0x44b04,%edx
   41bb5:	be 04 00 00 00       	mov    $0x4,%esi
   41bba:	48 89 c7             	mov    %rax,%rdi
   41bbd:	b8 00 00 00 00       	mov    $0x0,%eax
   41bc2:	e8 1b 2a 00 00       	call   445e2 <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   41bc7:	8b 05 37 44 00 00    	mov    0x4437(%rip),%eax        # 46004 <showing.0>
   41bcd:	48 63 d0             	movslq %eax,%rdx
   41bd0:	48 89 d0             	mov    %rdx,%rax
   41bd3:	48 c1 e0 03          	shl    $0x3,%rax
   41bd7:	48 29 d0             	sub    %rdx,%rax
   41bda:	48 c1 e0 05          	shl    $0x5,%rax
   41bde:	48 05 f0 20 05 00    	add    $0x520f0,%rax
   41be4:	48 8b 00             	mov    (%rax),%rax
   41be7:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   41beb:	48 89 d6             	mov    %rdx,%rsi
   41bee:	48 89 c7             	mov    %rax,%rdi
   41bf1:	e8 ac fc ff ff       	call   418a2 <memshow_virtual>
    }
}
   41bf6:	90                   	nop
   41bf7:	c9                   	leave  
   41bf8:	c3                   	ret    

0000000000041bf9 <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   41bf9:	55                   	push   %rbp
   41bfa:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   41bfd:	e8 4f 01 00 00       	call   41d51 <segments_init>
    interrupt_init();
   41c02:	e8 d0 03 00 00       	call   41fd7 <interrupt_init>
    virtual_memory_init();
   41c07:	e8 f3 0f 00 00       	call   42bff <virtual_memory_init>
}
   41c0c:	90                   	nop
   41c0d:	5d                   	pop    %rbp
   41c0e:	c3                   	ret    

0000000000041c0f <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   41c0f:	55                   	push   %rbp
   41c10:	48 89 e5             	mov    %rsp,%rbp
   41c13:	48 83 ec 18          	sub    $0x18,%rsp
   41c17:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41c1b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41c1f:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   41c22:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41c25:	48 98                	cltq   
   41c27:	48 c1 e0 2d          	shl    $0x2d,%rax
   41c2b:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   41c2f:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   41c36:	90 00 00 
   41c39:	48 09 c2             	or     %rax,%rdx
    *segment = type
   41c3c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41c40:	48 89 10             	mov    %rdx,(%rax)
}
   41c43:	90                   	nop
   41c44:	c9                   	leave  
   41c45:	c3                   	ret    

0000000000041c46 <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   41c46:	55                   	push   %rbp
   41c47:	48 89 e5             	mov    %rsp,%rbp
   41c4a:	48 83 ec 28          	sub    $0x28,%rsp
   41c4e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41c52:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41c56:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41c59:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   41c5d:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41c61:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41c65:	48 c1 e0 10          	shl    $0x10,%rax
   41c69:	48 89 c2             	mov    %rax,%rdx
   41c6c:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   41c73:	00 00 00 
   41c76:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   41c79:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41c7d:	48 c1 e0 20          	shl    $0x20,%rax
   41c81:	48 89 c1             	mov    %rax,%rcx
   41c84:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   41c8b:	00 00 ff 
   41c8e:	48 21 c8             	and    %rcx,%rax
   41c91:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   41c94:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41c98:	48 83 e8 01          	sub    $0x1,%rax
   41c9c:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   41c9f:	48 09 d0             	or     %rdx,%rax
        | type
   41ca2:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   41ca6:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41ca9:	48 63 d2             	movslq %edx,%rdx
   41cac:	48 c1 e2 2d          	shl    $0x2d,%rdx
   41cb0:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   41cb3:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   41cba:	80 00 00 
   41cbd:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41cc0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41cc4:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   41cc7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ccb:	48 83 c0 08          	add    $0x8,%rax
   41ccf:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   41cd3:	48 c1 ea 20          	shr    $0x20,%rdx
   41cd7:	48 89 10             	mov    %rdx,(%rax)
}
   41cda:	90                   	nop
   41cdb:	c9                   	leave  
   41cdc:	c3                   	ret    

0000000000041cdd <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   41cdd:	55                   	push   %rbp
   41cde:	48 89 e5             	mov    %rsp,%rbp
   41ce1:	48 83 ec 20          	sub    $0x20,%rsp
   41ce5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41ce9:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41ced:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41cf0:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41cf4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41cf8:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   41cfb:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   41cff:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41d02:	48 63 d2             	movslq %edx,%rdx
   41d05:	48 c1 e2 2d          	shl    $0x2d,%rdx
   41d09:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   41d0c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41d10:	48 c1 e0 20          	shl    $0x20,%rax
   41d14:	48 89 c1             	mov    %rax,%rcx
   41d17:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   41d1e:	00 ff ff 
   41d21:	48 21 c8             	and    %rcx,%rax
   41d24:	48 09 c2             	or     %rax,%rdx
   41d27:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   41d2e:	80 00 00 
   41d31:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41d34:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d38:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   41d3b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41d3f:	48 c1 e8 20          	shr    $0x20,%rax
   41d43:	48 89 c2             	mov    %rax,%rdx
   41d46:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d4a:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   41d4e:	90                   	nop
   41d4f:	c9                   	leave  
   41d50:	c3                   	ret    

0000000000041d51 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   41d51:	55                   	push   %rbp
   41d52:	48 89 e5             	mov    %rsp,%rbp
   41d55:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   41d59:	48 c7 05 fc 14 01 00 	movq   $0x0,0x114fc(%rip)        # 53260 <segments>
   41d60:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   41d64:	ba 00 00 00 00       	mov    $0x0,%edx
   41d69:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41d70:	08 20 00 
   41d73:	48 89 c6             	mov    %rax,%rsi
   41d76:	bf 68 32 05 00       	mov    $0x53268,%edi
   41d7b:	e8 8f fe ff ff       	call   41c0f <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   41d80:	ba 03 00 00 00       	mov    $0x3,%edx
   41d85:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41d8c:	08 20 00 
   41d8f:	48 89 c6             	mov    %rax,%rsi
   41d92:	bf 70 32 05 00       	mov    $0x53270,%edi
   41d97:	e8 73 fe ff ff       	call   41c0f <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   41d9c:	ba 00 00 00 00       	mov    $0x0,%edx
   41da1:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41da8:	02 00 00 
   41dab:	48 89 c6             	mov    %rax,%rsi
   41dae:	bf 78 32 05 00       	mov    $0x53278,%edi
   41db3:	e8 57 fe ff ff       	call   41c0f <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   41db8:	ba 03 00 00 00       	mov    $0x3,%edx
   41dbd:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41dc4:	02 00 00 
   41dc7:	48 89 c6             	mov    %rax,%rsi
   41dca:	bf 80 32 05 00       	mov    $0x53280,%edi
   41dcf:	e8 3b fe ff ff       	call   41c0f <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   41dd4:	b8 a0 42 05 00       	mov    $0x542a0,%eax
   41dd9:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   41ddf:	48 89 c1             	mov    %rax,%rcx
   41de2:	ba 00 00 00 00       	mov    $0x0,%edx
   41de7:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   41dee:	09 00 00 
   41df1:	48 89 c6             	mov    %rax,%rsi
   41df4:	bf 88 32 05 00       	mov    $0x53288,%edi
   41df9:	e8 48 fe ff ff       	call   41c46 <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   41dfe:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   41e04:	b8 60 32 05 00       	mov    $0x53260,%eax
   41e09:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   41e0d:	ba 60 00 00 00       	mov    $0x60,%edx
   41e12:	be 00 00 00 00       	mov    $0x0,%esi
   41e17:	bf a0 42 05 00       	mov    $0x542a0,%edi
   41e1c:	e8 fe 18 00 00       	call   4371f <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   41e21:	48 c7 05 78 24 01 00 	movq   $0x80000,0x12478(%rip)        # 542a4 <kernel_task_descriptor+0x4>
   41e28:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   41e2c:	ba 00 10 00 00       	mov    $0x1000,%edx
   41e31:	be 00 00 00 00       	mov    $0x0,%esi
   41e36:	bf a0 32 05 00       	mov    $0x532a0,%edi
   41e3b:	e8 df 18 00 00       	call   4371f <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41e40:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   41e47:	eb 30                	jmp    41e79 <segments_init+0x128>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   41e49:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   41e4e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41e51:	48 c1 e0 04          	shl    $0x4,%rax
   41e55:	48 05 a0 32 05 00    	add    $0x532a0,%rax
   41e5b:	48 89 d1             	mov    %rdx,%rcx
   41e5e:	ba 00 00 00 00       	mov    $0x0,%edx
   41e63:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41e6a:	0e 00 00 
   41e6d:	48 89 c7             	mov    %rax,%rdi
   41e70:	e8 68 fe ff ff       	call   41cdd <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41e75:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41e79:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   41e80:	76 c7                	jbe    41e49 <segments_init+0xf8>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   41e82:	b8 36 00 04 00       	mov    $0x40036,%eax
   41e87:	48 89 c1             	mov    %rax,%rcx
   41e8a:	ba 00 00 00 00       	mov    $0x0,%edx
   41e8f:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41e96:	0e 00 00 
   41e99:	48 89 c6             	mov    %rax,%rsi
   41e9c:	bf a0 34 05 00       	mov    $0x534a0,%edi
   41ea1:	e8 37 fe ff ff       	call   41cdd <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   41ea6:	b8 2e 00 04 00       	mov    $0x4002e,%eax
   41eab:	48 89 c1             	mov    %rax,%rcx
   41eae:	ba 00 00 00 00       	mov    $0x0,%edx
   41eb3:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41eba:	0e 00 00 
   41ebd:	48 89 c6             	mov    %rax,%rsi
   41ec0:	bf 70 33 05 00       	mov    $0x53370,%edi
   41ec5:	e8 13 fe ff ff       	call   41cdd <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   41eca:	b8 32 00 04 00       	mov    $0x40032,%eax
   41ecf:	48 89 c1             	mov    %rax,%rcx
   41ed2:	ba 00 00 00 00       	mov    $0x0,%edx
   41ed7:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41ede:	0e 00 00 
   41ee1:	48 89 c6             	mov    %rax,%rsi
   41ee4:	bf 80 33 05 00       	mov    $0x53380,%edi
   41ee9:	e8 ef fd ff ff       	call   41cdd <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41eee:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   41ef5:	eb 3e                	jmp    41f35 <segments_init+0x1e4>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   41ef7:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41efa:	83 e8 30             	sub    $0x30,%eax
   41efd:	89 c0                	mov    %eax,%eax
   41eff:	48 8b 04 c5 e7 00 04 	mov    0x400e7(,%rax,8),%rax
   41f06:	00 
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   41f07:	48 89 c2             	mov    %rax,%rdx
   41f0a:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41f0d:	48 c1 e0 04          	shl    $0x4,%rax
   41f11:	48 05 a0 32 05 00    	add    $0x532a0,%rax
   41f17:	48 89 d1             	mov    %rdx,%rcx
   41f1a:	ba 03 00 00 00       	mov    $0x3,%edx
   41f1f:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41f26:	0e 00 00 
   41f29:	48 89 c7             	mov    %rax,%rdi
   41f2c:	e8 ac fd ff ff       	call   41cdd <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41f31:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41f35:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   41f39:	76 bc                	jbe    41ef7 <segments_init+0x1a6>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   41f3b:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   41f41:	b8 a0 32 05 00       	mov    $0x532a0,%eax
   41f46:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   41f4a:	b8 28 00 00 00       	mov    $0x28,%eax
   41f4f:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   41f53:	0f 00 d8             	ltr    %ax
   41f56:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   41f5a:	0f 20 c0             	mov    %cr0,%rax
   41f5d:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   41f61:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   41f65:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   41f68:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   41f6f:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41f72:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   41f75:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41f78:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   41f7c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41f80:	0f 22 c0             	mov    %rax,%cr0
}
   41f83:	90                   	nop
    lcr0(cr0);
}
   41f84:	90                   	nop
   41f85:	c9                   	leave  
   41f86:	c3                   	ret    

0000000000041f87 <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   41f87:	55                   	push   %rbp
   41f88:	48 89 e5             	mov    %rsp,%rbp
   41f8b:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   41f8f:	0f b7 05 6a 23 01 00 	movzwl 0x1236a(%rip),%eax        # 54300 <interrupts_enabled>
   41f96:	f7 d0                	not    %eax
   41f98:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   41f9c:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41fa0:	0f b6 c0             	movzbl %al,%eax
   41fa3:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   41faa:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41fad:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   41fb1:	8b 55 f0             	mov    -0x10(%rbp),%edx
   41fb4:	ee                   	out    %al,(%dx)
}
   41fb5:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   41fb6:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41fba:	66 c1 e8 08          	shr    $0x8,%ax
   41fbe:	0f b6 c0             	movzbl %al,%eax
   41fc1:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   41fc8:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41fcb:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   41fcf:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41fd2:	ee                   	out    %al,(%dx)
}
   41fd3:	90                   	nop
}
   41fd4:	90                   	nop
   41fd5:	c9                   	leave  
   41fd6:	c3                   	ret    

0000000000041fd7 <interrupt_init>:

void interrupt_init(void) {
   41fd7:	55                   	push   %rbp
   41fd8:	48 89 e5             	mov    %rsp,%rbp
   41fdb:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   41fdf:	66 c7 05 18 23 01 00 	movw   $0x0,0x12318(%rip)        # 54300 <interrupts_enabled>
   41fe6:	00 00 
    interrupt_mask();
   41fe8:	e8 9a ff ff ff       	call   41f87 <interrupt_mask>
   41fed:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   41ff4:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ff8:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   41ffc:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   41fff:	ee                   	out    %al,(%dx)
}
   42000:	90                   	nop
   42001:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   42008:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4200c:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   42010:	8b 55 ac             	mov    -0x54(%rbp),%edx
   42013:	ee                   	out    %al,(%dx)
}
   42014:	90                   	nop
   42015:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   4201c:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42020:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   42024:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   42027:	ee                   	out    %al,(%dx)
}
   42028:	90                   	nop
   42029:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   42030:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42034:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   42038:	8b 55 bc             	mov    -0x44(%rbp),%edx
   4203b:	ee                   	out    %al,(%dx)
}
   4203c:	90                   	nop
   4203d:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   42044:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42048:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   4204c:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   4204f:	ee                   	out    %al,(%dx)
}
   42050:	90                   	nop
   42051:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   42058:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4205c:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   42060:	8b 55 cc             	mov    -0x34(%rbp),%edx
   42063:	ee                   	out    %al,(%dx)
}
   42064:	90                   	nop
   42065:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   4206c:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42070:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   42074:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   42077:	ee                   	out    %al,(%dx)
}
   42078:	90                   	nop
   42079:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   42080:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42084:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   42088:	8b 55 dc             	mov    -0x24(%rbp),%edx
   4208b:	ee                   	out    %al,(%dx)
}
   4208c:	90                   	nop
   4208d:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   42094:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42098:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   4209c:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   4209f:	ee                   	out    %al,(%dx)
}
   420a0:	90                   	nop
   420a1:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   420a8:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   420ac:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   420b0:	8b 55 ec             	mov    -0x14(%rbp),%edx
   420b3:	ee                   	out    %al,(%dx)
}
   420b4:	90                   	nop
   420b5:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   420bc:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   420c0:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   420c4:	8b 55 f4             	mov    -0xc(%rbp),%edx
   420c7:	ee                   	out    %al,(%dx)
}
   420c8:	90                   	nop
   420c9:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   420d0:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   420d4:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   420d8:	8b 55 fc             	mov    -0x4(%rbp),%edx
   420db:	ee                   	out    %al,(%dx)
}
   420dc:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   420dd:	e8 a5 fe ff ff       	call   41f87 <interrupt_mask>
}
   420e2:	90                   	nop
   420e3:	c9                   	leave  
   420e4:	c3                   	ret    

00000000000420e5 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   420e5:	55                   	push   %rbp
   420e6:	48 89 e5             	mov    %rsp,%rbp
   420e9:	48 83 ec 28          	sub    $0x28,%rsp
   420ed:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   420f0:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   420f4:	0f 8e 9e 00 00 00    	jle    42198 <timer_init+0xb3>
   420fa:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   42101:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42105:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   42109:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4210c:	ee                   	out    %al,(%dx)
}
   4210d:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   4210e:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42111:	89 c2                	mov    %eax,%edx
   42113:	c1 ea 1f             	shr    $0x1f,%edx
   42116:	01 d0                	add    %edx,%eax
   42118:	d1 f8                	sar    %eax
   4211a:	05 de 34 12 00       	add    $0x1234de,%eax
   4211f:	99                   	cltd   
   42120:	f7 7d dc             	idivl  -0x24(%rbp)
   42123:	89 c2                	mov    %eax,%edx
   42125:	89 d0                	mov    %edx,%eax
   42127:	c1 f8 1f             	sar    $0x1f,%eax
   4212a:	c1 e8 18             	shr    $0x18,%eax
   4212d:	01 c2                	add    %eax,%edx
   4212f:	0f b6 d2             	movzbl %dl,%edx
   42132:	29 c2                	sub    %eax,%edx
   42134:	89 d0                	mov    %edx,%eax
   42136:	0f b6 c0             	movzbl %al,%eax
   42139:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   42140:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42143:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   42147:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4214a:	ee                   	out    %al,(%dx)
}
   4214b:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   4214c:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4214f:	89 c2                	mov    %eax,%edx
   42151:	c1 ea 1f             	shr    $0x1f,%edx
   42154:	01 d0                	add    %edx,%eax
   42156:	d1 f8                	sar    %eax
   42158:	05 de 34 12 00       	add    $0x1234de,%eax
   4215d:	99                   	cltd   
   4215e:	f7 7d dc             	idivl  -0x24(%rbp)
   42161:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   42167:	85 c0                	test   %eax,%eax
   42169:	0f 48 c2             	cmovs  %edx,%eax
   4216c:	c1 f8 08             	sar    $0x8,%eax
   4216f:	0f b6 c0             	movzbl %al,%eax
   42172:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   42179:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4217c:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42180:	8b 55 fc             	mov    -0x4(%rbp),%edx
   42183:	ee                   	out    %al,(%dx)
}
   42184:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   42185:	0f b7 05 74 21 01 00 	movzwl 0x12174(%rip),%eax        # 54300 <interrupts_enabled>
   4218c:	83 c8 01             	or     $0x1,%eax
   4218f:	66 89 05 6a 21 01 00 	mov    %ax,0x1216a(%rip)        # 54300 <interrupts_enabled>
   42196:	eb 11                	jmp    421a9 <timer_init+0xc4>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   42198:	0f b7 05 61 21 01 00 	movzwl 0x12161(%rip),%eax        # 54300 <interrupts_enabled>
   4219f:	83 e0 fe             	and    $0xfffffffe,%eax
   421a2:	66 89 05 57 21 01 00 	mov    %ax,0x12157(%rip)        # 54300 <interrupts_enabled>
    }
    interrupt_mask();
   421a9:	e8 d9 fd ff ff       	call   41f87 <interrupt_mask>
}
   421ae:	90                   	nop
   421af:	c9                   	leave  
   421b0:	c3                   	ret    

00000000000421b1 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   421b1:	55                   	push   %rbp
   421b2:	48 89 e5             	mov    %rsp,%rbp
   421b5:	48 83 ec 08          	sub    $0x8,%rsp
   421b9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   421bd:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   421c2:	74 14                	je     421d8 <physical_memory_isreserved+0x27>
   421c4:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   421cb:	00 
   421cc:	76 11                	jbe    421df <physical_memory_isreserved+0x2e>
   421ce:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   421d5:	00 
   421d6:	77 07                	ja     421df <physical_memory_isreserved+0x2e>
   421d8:	b8 01 00 00 00       	mov    $0x1,%eax
   421dd:	eb 05                	jmp    421e4 <physical_memory_isreserved+0x33>
   421df:	b8 00 00 00 00       	mov    $0x0,%eax
}
   421e4:	c9                   	leave  
   421e5:	c3                   	ret    

00000000000421e6 <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   421e6:	55                   	push   %rbp
   421e7:	48 89 e5             	mov    %rsp,%rbp
   421ea:	48 83 ec 10          	sub    $0x10,%rsp
   421ee:	89 7d fc             	mov    %edi,-0x4(%rbp)
   421f1:	89 75 f8             	mov    %esi,-0x8(%rbp)
   421f4:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   421f7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   421fa:	c1 e0 10             	shl    $0x10,%eax
   421fd:	89 c2                	mov    %eax,%edx
   421ff:	8b 45 f8             	mov    -0x8(%rbp),%eax
   42202:	c1 e0 0b             	shl    $0xb,%eax
   42205:	09 c2                	or     %eax,%edx
   42207:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4220a:	c1 e0 08             	shl    $0x8,%eax
   4220d:	09 d0                	or     %edx,%eax
}
   4220f:	c9                   	leave  
   42210:	c3                   	ret    

0000000000042211 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   42211:	55                   	push   %rbp
   42212:	48 89 e5             	mov    %rsp,%rbp
   42215:	48 83 ec 18          	sub    $0x18,%rsp
   42219:	89 7d ec             	mov    %edi,-0x14(%rbp)
   4221c:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   4221f:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42222:	8b 45 e8             	mov    -0x18(%rbp),%eax
   42225:	09 d0                	or     %edx,%eax
   42227:	0d 00 00 00 80       	or     $0x80000000,%eax
   4222c:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   42233:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   42236:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42239:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4223c:	ef                   	out    %eax,(%dx)
}
   4223d:	90                   	nop
   4223e:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   42245:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42248:	89 c2                	mov    %eax,%edx
   4224a:	ed                   	in     (%dx),%eax
   4224b:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   4224e:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   42251:	c9                   	leave  
   42252:	c3                   	ret    

0000000000042253 <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   42253:	55                   	push   %rbp
   42254:	48 89 e5             	mov    %rsp,%rbp
   42257:	48 83 ec 28          	sub    $0x28,%rsp
   4225b:	89 7d dc             	mov    %edi,-0x24(%rbp)
   4225e:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   42261:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42268:	eb 73                	jmp    422dd <pci_find_device+0x8a>
        for (int slot = 0; slot != 32; ++slot) {
   4226a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   42271:	eb 60                	jmp    422d3 <pci_find_device+0x80>
            for (int func = 0; func != 8; ++func) {
   42273:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   4227a:	eb 4a                	jmp    422c6 <pci_find_device+0x73>
                int configaddr = pci_make_configaddr(bus, slot, func);
   4227c:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4227f:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   42282:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42285:	89 ce                	mov    %ecx,%esi
   42287:	89 c7                	mov    %eax,%edi
   42289:	e8 58 ff ff ff       	call   421e6 <pci_make_configaddr>
   4228e:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   42291:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42294:	be 00 00 00 00       	mov    $0x0,%esi
   42299:	89 c7                	mov    %eax,%edi
   4229b:	e8 71 ff ff ff       	call   42211 <pci_config_readl>
   422a0:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   422a3:	8b 45 d8             	mov    -0x28(%rbp),%eax
   422a6:	c1 e0 10             	shl    $0x10,%eax
   422a9:	0b 45 dc             	or     -0x24(%rbp),%eax
   422ac:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   422af:	75 05                	jne    422b6 <pci_find_device+0x63>
                    return configaddr;
   422b1:	8b 45 f0             	mov    -0x10(%rbp),%eax
   422b4:	eb 35                	jmp    422eb <pci_find_device+0x98>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   422b6:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   422ba:	75 06                	jne    422c2 <pci_find_device+0x6f>
   422bc:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   422c0:	74 0c                	je     422ce <pci_find_device+0x7b>
            for (int func = 0; func != 8; ++func) {
   422c2:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   422c6:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   422ca:	75 b0                	jne    4227c <pci_find_device+0x29>
   422cc:	eb 01                	jmp    422cf <pci_find_device+0x7c>
                    break;
   422ce:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   422cf:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   422d3:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   422d7:	75 9a                	jne    42273 <pci_find_device+0x20>
    for (int bus = 0; bus != 256; ++bus) {
   422d9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   422dd:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   422e4:	75 84                	jne    4226a <pci_find_device+0x17>
                }
            }
        }
    }
    return -1;
   422e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   422eb:	c9                   	leave  
   422ec:	c3                   	ret    

00000000000422ed <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   422ed:	55                   	push   %rbp
   422ee:	48 89 e5             	mov    %rsp,%rbp
   422f1:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   422f5:	be 13 71 00 00       	mov    $0x7113,%esi
   422fa:	bf 86 80 00 00       	mov    $0x8086,%edi
   422ff:	e8 4f ff ff ff       	call   42253 <pci_find_device>
   42304:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   42307:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4230b:	78 30                	js     4233d <poweroff+0x50>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   4230d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42310:	be 40 00 00 00       	mov    $0x40,%esi
   42315:	89 c7                	mov    %eax,%edi
   42317:	e8 f5 fe ff ff       	call   42211 <pci_config_readl>
   4231c:	25 c0 ff 00 00       	and    $0xffc0,%eax
   42321:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   42324:	8b 45 f8             	mov    -0x8(%rbp),%eax
   42327:	83 c0 04             	add    $0x4,%eax
   4232a:	89 45 f4             	mov    %eax,-0xc(%rbp)
   4232d:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   42333:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   42337:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4233a:	66 ef                	out    %ax,(%dx)
}
   4233c:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   4233d:	ba 20 4b 04 00       	mov    $0x44b20,%edx
   42342:	be 00 c0 00 00       	mov    $0xc000,%esi
   42347:	bf 80 07 00 00       	mov    $0x780,%edi
   4234c:	b8 00 00 00 00       	mov    $0x0,%eax
   42351:	e8 80 21 00 00       	call   444d6 <console_printf>
 spinloop: goto spinloop;
   42356:	eb fe                	jmp    42356 <poweroff+0x69>

0000000000042358 <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   42358:	55                   	push   %rbp
   42359:	48 89 e5             	mov    %rsp,%rbp
   4235c:	48 83 ec 10          	sub    $0x10,%rsp
   42360:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   42367:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4236b:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4236f:	8b 55 fc             	mov    -0x4(%rbp),%edx
   42372:	ee                   	out    %al,(%dx)
}
   42373:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   42374:	eb fe                	jmp    42374 <reboot+0x1c>

0000000000042376 <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   42376:	55                   	push   %rbp
   42377:	48 89 e5             	mov    %rsp,%rbp
   4237a:	48 83 ec 10          	sub    $0x10,%rsp
   4237e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42382:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   42385:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42389:	48 83 c0 08          	add    $0x8,%rax
   4238d:	ba c0 00 00 00       	mov    $0xc0,%edx
   42392:	be 00 00 00 00       	mov    $0x0,%esi
   42397:	48 89 c7             	mov    %rax,%rdi
   4239a:	e8 80 13 00 00       	call   4371f <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   4239f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   423a3:	66 c7 80 a8 00 00 00 	movw   $0x13,0xa8(%rax)
   423aa:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   423ac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   423b0:	48 c7 80 80 00 00 00 	movq   $0x23,0x80(%rax)
   423b7:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   423bb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   423bf:	48 c7 80 88 00 00 00 	movq   $0x23,0x88(%rax)
   423c6:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   423ca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   423ce:	66 c7 80 c0 00 00 00 	movw   $0x23,0xc0(%rax)
   423d5:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   423d7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   423db:	48 c7 80 b0 00 00 00 	movq   $0x200,0xb0(%rax)
   423e2:	00 02 00 00 
    p->display_status = 1;
   423e6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   423ea:	c6 80 d8 00 00 00 01 	movb   $0x1,0xd8(%rax)

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   423f1:	8b 45 f4             	mov    -0xc(%rbp),%eax
   423f4:	83 e0 01             	and    $0x1,%eax
   423f7:	85 c0                	test   %eax,%eax
   423f9:	74 1c                	je     42417 <process_init+0xa1>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   423fb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   423ff:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   42406:	80 cc 30             	or     $0x30,%ah
   42409:	48 89 c2             	mov    %rax,%rdx
   4240c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42410:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   42417:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4241a:	83 e0 02             	and    $0x2,%eax
   4241d:	85 c0                	test   %eax,%eax
   4241f:	74 1c                	je     4243d <process_init+0xc7>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   42421:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42425:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   4242c:	80 e4 fd             	and    $0xfd,%ah
   4242f:	48 89 c2             	mov    %rax,%rdx
   42432:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42436:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
}
   4243d:	90                   	nop
   4243e:	c9                   	leave  
   4243f:	c3                   	ret    

0000000000042440 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   42440:	55                   	push   %rbp
   42441:	48 89 e5             	mov    %rsp,%rbp
   42444:	48 83 ec 28          	sub    $0x28,%rsp
   42448:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   4244b:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   4244f:	78 09                	js     4245a <console_show_cursor+0x1a>
   42451:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   42458:	7e 07                	jle    42461 <console_show_cursor+0x21>
        cpos = 0;
   4245a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   42461:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   42468:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4246c:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   42470:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   42473:	ee                   	out    %al,(%dx)
}
   42474:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   42475:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42478:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   4247e:	85 c0                	test   %eax,%eax
   42480:	0f 48 c2             	cmovs  %edx,%eax
   42483:	c1 f8 08             	sar    $0x8,%eax
   42486:	0f b6 c0             	movzbl %al,%eax
   42489:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   42490:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42493:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   42497:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4249a:	ee                   	out    %al,(%dx)
}
   4249b:	90                   	nop
   4249c:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   424a3:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   424a7:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   424ab:	8b 55 f4             	mov    -0xc(%rbp),%edx
   424ae:	ee                   	out    %al,(%dx)
}
   424af:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   424b0:	8b 55 dc             	mov    -0x24(%rbp),%edx
   424b3:	89 d0                	mov    %edx,%eax
   424b5:	c1 f8 1f             	sar    $0x1f,%eax
   424b8:	c1 e8 18             	shr    $0x18,%eax
   424bb:	01 c2                	add    %eax,%edx
   424bd:	0f b6 d2             	movzbl %dl,%edx
   424c0:	29 c2                	sub    %eax,%edx
   424c2:	89 d0                	mov    %edx,%eax
   424c4:	0f b6 c0             	movzbl %al,%eax
   424c7:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   424ce:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   424d1:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   424d5:	8b 55 fc             	mov    -0x4(%rbp),%edx
   424d8:	ee                   	out    %al,(%dx)
}
   424d9:	90                   	nop
}
   424da:	90                   	nop
   424db:	c9                   	leave  
   424dc:	c3                   	ret    

00000000000424dd <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   424dd:	55                   	push   %rbp
   424de:	48 89 e5             	mov    %rsp,%rbp
   424e1:	48 83 ec 20          	sub    $0x20,%rsp
   424e5:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   424ec:	8b 45 f0             	mov    -0x10(%rbp),%eax
   424ef:	89 c2                	mov    %eax,%edx
   424f1:	ec                   	in     (%dx),%al
   424f2:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   424f5:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   424f9:	0f b6 c0             	movzbl %al,%eax
   424fc:	83 e0 01             	and    $0x1,%eax
   424ff:	85 c0                	test   %eax,%eax
   42501:	75 0a                	jne    4250d <keyboard_readc+0x30>
        return -1;
   42503:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42508:	e9 e7 01 00 00       	jmp    426f4 <keyboard_readc+0x217>
   4250d:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42514:	8b 45 e8             	mov    -0x18(%rbp),%eax
   42517:	89 c2                	mov    %eax,%edx
   42519:	ec                   	in     (%dx),%al
   4251a:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   4251d:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   42521:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   42524:	0f b6 05 d7 1d 01 00 	movzbl 0x11dd7(%rip),%eax        # 54302 <last_escape.2>
   4252b:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   4252e:	c6 05 cd 1d 01 00 00 	movb   $0x0,0x11dcd(%rip)        # 54302 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   42535:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   42539:	75 11                	jne    4254c <keyboard_readc+0x6f>
        last_escape = 0x80;
   4253b:	c6 05 c0 1d 01 00 80 	movb   $0x80,0x11dc0(%rip)        # 54302 <last_escape.2>
        return 0;
   42542:	b8 00 00 00 00       	mov    $0x0,%eax
   42547:	e9 a8 01 00 00       	jmp    426f4 <keyboard_readc+0x217>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   4254c:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42550:	84 c0                	test   %al,%al
   42552:	79 60                	jns    425b4 <keyboard_readc+0xd7>
        int ch = keymap[(data & 0x7F) | escape];
   42554:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42558:	83 e0 7f             	and    $0x7f,%eax
   4255b:	89 c2                	mov    %eax,%edx
   4255d:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   42561:	09 d0                	or     %edx,%eax
   42563:	48 98                	cltq   
   42565:	0f b6 80 40 4b 04 00 	movzbl 0x44b40(%rax),%eax
   4256c:	0f b6 c0             	movzbl %al,%eax
   4256f:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   42572:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   42579:	7e 2f                	jle    425aa <keyboard_readc+0xcd>
   4257b:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   42582:	7f 26                	jg     425aa <keyboard_readc+0xcd>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   42584:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42587:	2d fa 00 00 00       	sub    $0xfa,%eax
   4258c:	ba 01 00 00 00       	mov    $0x1,%edx
   42591:	89 c1                	mov    %eax,%ecx
   42593:	d3 e2                	shl    %cl,%edx
   42595:	89 d0                	mov    %edx,%eax
   42597:	f7 d0                	not    %eax
   42599:	89 c2                	mov    %eax,%edx
   4259b:	0f b6 05 61 1d 01 00 	movzbl 0x11d61(%rip),%eax        # 54303 <modifiers.1>
   425a2:	21 d0                	and    %edx,%eax
   425a4:	88 05 59 1d 01 00    	mov    %al,0x11d59(%rip)        # 54303 <modifiers.1>
        }
        return 0;
   425aa:	b8 00 00 00 00       	mov    $0x0,%eax
   425af:	e9 40 01 00 00       	jmp    426f4 <keyboard_readc+0x217>
    }

    int ch = (unsigned char) keymap[data | escape];
   425b4:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   425b8:	0a 45 fa             	or     -0x6(%rbp),%al
   425bb:	0f b6 c0             	movzbl %al,%eax
   425be:	48 98                	cltq   
   425c0:	0f b6 80 40 4b 04 00 	movzbl 0x44b40(%rax),%eax
   425c7:	0f b6 c0             	movzbl %al,%eax
   425ca:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   425cd:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   425d1:	7e 57                	jle    4262a <keyboard_readc+0x14d>
   425d3:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   425d7:	7f 51                	jg     4262a <keyboard_readc+0x14d>
        if (modifiers & MOD_CONTROL) {
   425d9:	0f b6 05 23 1d 01 00 	movzbl 0x11d23(%rip),%eax        # 54303 <modifiers.1>
   425e0:	0f b6 c0             	movzbl %al,%eax
   425e3:	83 e0 02             	and    $0x2,%eax
   425e6:	85 c0                	test   %eax,%eax
   425e8:	74 09                	je     425f3 <keyboard_readc+0x116>
            ch -= 0x60;
   425ea:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   425ee:	e9 fd 00 00 00       	jmp    426f0 <keyboard_readc+0x213>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   425f3:	0f b6 05 09 1d 01 00 	movzbl 0x11d09(%rip),%eax        # 54303 <modifiers.1>
   425fa:	0f b6 c0             	movzbl %al,%eax
   425fd:	83 e0 01             	and    $0x1,%eax
   42600:	85 c0                	test   %eax,%eax
   42602:	0f 94 c2             	sete   %dl
   42605:	0f b6 05 f7 1c 01 00 	movzbl 0x11cf7(%rip),%eax        # 54303 <modifiers.1>
   4260c:	0f b6 c0             	movzbl %al,%eax
   4260f:	83 e0 08             	and    $0x8,%eax
   42612:	85 c0                	test   %eax,%eax
   42614:	0f 94 c0             	sete   %al
   42617:	31 d0                	xor    %edx,%eax
   42619:	84 c0                	test   %al,%al
   4261b:	0f 84 cf 00 00 00    	je     426f0 <keyboard_readc+0x213>
            ch -= 0x20;
   42621:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   42625:	e9 c6 00 00 00       	jmp    426f0 <keyboard_readc+0x213>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   4262a:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   42631:	7e 30                	jle    42663 <keyboard_readc+0x186>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   42633:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42636:	2d fa 00 00 00       	sub    $0xfa,%eax
   4263b:	ba 01 00 00 00       	mov    $0x1,%edx
   42640:	89 c1                	mov    %eax,%ecx
   42642:	d3 e2                	shl    %cl,%edx
   42644:	89 d0                	mov    %edx,%eax
   42646:	89 c2                	mov    %eax,%edx
   42648:	0f b6 05 b4 1c 01 00 	movzbl 0x11cb4(%rip),%eax        # 54303 <modifiers.1>
   4264f:	31 d0                	xor    %edx,%eax
   42651:	88 05 ac 1c 01 00    	mov    %al,0x11cac(%rip)        # 54303 <modifiers.1>
        ch = 0;
   42657:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4265e:	e9 8e 00 00 00       	jmp    426f1 <keyboard_readc+0x214>
    } else if (ch >= KEY_SHIFT) {
   42663:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   4266a:	7e 2d                	jle    42699 <keyboard_readc+0x1bc>
        modifiers |= 1 << (ch - KEY_SHIFT);
   4266c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4266f:	2d fa 00 00 00       	sub    $0xfa,%eax
   42674:	ba 01 00 00 00       	mov    $0x1,%edx
   42679:	89 c1                	mov    %eax,%ecx
   4267b:	d3 e2                	shl    %cl,%edx
   4267d:	89 d0                	mov    %edx,%eax
   4267f:	89 c2                	mov    %eax,%edx
   42681:	0f b6 05 7b 1c 01 00 	movzbl 0x11c7b(%rip),%eax        # 54303 <modifiers.1>
   42688:	09 d0                	or     %edx,%eax
   4268a:	88 05 73 1c 01 00    	mov    %al,0x11c73(%rip)        # 54303 <modifiers.1>
        ch = 0;
   42690:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42697:	eb 58                	jmp    426f1 <keyboard_readc+0x214>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   42699:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   4269d:	7e 31                	jle    426d0 <keyboard_readc+0x1f3>
   4269f:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   426a6:	7f 28                	jg     426d0 <keyboard_readc+0x1f3>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   426a8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   426ab:	8d 50 80             	lea    -0x80(%rax),%edx
   426ae:	0f b6 05 4e 1c 01 00 	movzbl 0x11c4e(%rip),%eax        # 54303 <modifiers.1>
   426b5:	0f b6 c0             	movzbl %al,%eax
   426b8:	83 e0 03             	and    $0x3,%eax
   426bb:	48 98                	cltq   
   426bd:	48 63 d2             	movslq %edx,%rdx
   426c0:	0f b6 84 90 40 4c 04 	movzbl 0x44c40(%rax,%rdx,4),%eax
   426c7:	00 
   426c8:	0f b6 c0             	movzbl %al,%eax
   426cb:	89 45 fc             	mov    %eax,-0x4(%rbp)
   426ce:	eb 21                	jmp    426f1 <keyboard_readc+0x214>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   426d0:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   426d4:	7f 1b                	jg     426f1 <keyboard_readc+0x214>
   426d6:	0f b6 05 26 1c 01 00 	movzbl 0x11c26(%rip),%eax        # 54303 <modifiers.1>
   426dd:	0f b6 c0             	movzbl %al,%eax
   426e0:	83 e0 02             	and    $0x2,%eax
   426e3:	85 c0                	test   %eax,%eax
   426e5:	74 0a                	je     426f1 <keyboard_readc+0x214>
        ch = 0;
   426e7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   426ee:	eb 01                	jmp    426f1 <keyboard_readc+0x214>
        if (modifiers & MOD_CONTROL) {
   426f0:	90                   	nop
    }

    return ch;
   426f1:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   426f4:	c9                   	leave  
   426f5:	c3                   	ret    

00000000000426f6 <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   426f6:	55                   	push   %rbp
   426f7:	48 89 e5             	mov    %rsp,%rbp
   426fa:	48 83 ec 20          	sub    $0x20,%rsp
   426fe:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42705:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   42708:	89 c2                	mov    %eax,%edx
   4270a:	ec                   	in     (%dx),%al
   4270b:	88 45 e3             	mov    %al,-0x1d(%rbp)
   4270e:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   42715:	8b 45 ec             	mov    -0x14(%rbp),%eax
   42718:	89 c2                	mov    %eax,%edx
   4271a:	ec                   	in     (%dx),%al
   4271b:	88 45 eb             	mov    %al,-0x15(%rbp)
   4271e:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   42725:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42728:	89 c2                	mov    %eax,%edx
   4272a:	ec                   	in     (%dx),%al
   4272b:	88 45 f3             	mov    %al,-0xd(%rbp)
   4272e:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   42735:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42738:	89 c2                	mov    %eax,%edx
   4273a:	ec                   	in     (%dx),%al
   4273b:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   4273e:	90                   	nop
   4273f:	c9                   	leave  
   42740:	c3                   	ret    

0000000000042741 <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   42741:	55                   	push   %rbp
   42742:	48 89 e5             	mov    %rsp,%rbp
   42745:	48 83 ec 40          	sub    $0x40,%rsp
   42749:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   4274d:	89 f0                	mov    %esi,%eax
   4274f:	89 55 c0             	mov    %edx,-0x40(%rbp)
   42752:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   42755:	8b 05 a9 1b 01 00    	mov    0x11ba9(%rip),%eax        # 54304 <initialized.0>
   4275b:	85 c0                	test   %eax,%eax
   4275d:	75 1e                	jne    4277d <parallel_port_putc+0x3c>
   4275f:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   42766:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4276a:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   4276e:	8b 55 f8             	mov    -0x8(%rbp),%edx
   42771:	ee                   	out    %al,(%dx)
}
   42772:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   42773:	c7 05 87 1b 01 00 01 	movl   $0x1,0x11b87(%rip)        # 54304 <initialized.0>
   4277a:	00 00 00 
    }

    for (int i = 0;
   4277d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42784:	eb 09                	jmp    4278f <parallel_port_putc+0x4e>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   42786:	e8 6b ff ff ff       	call   426f6 <delay>
         ++i) {
   4278b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   4278f:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   42796:	7f 18                	jg     427b0 <parallel_port_putc+0x6f>
   42798:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   4279f:	8b 45 f0             	mov    -0x10(%rbp),%eax
   427a2:	89 c2                	mov    %eax,%edx
   427a4:	ec                   	in     (%dx),%al
   427a5:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   427a8:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   427ac:	84 c0                	test   %al,%al
   427ae:	79 d6                	jns    42786 <parallel_port_putc+0x45>
    }
    outb(IO_PARALLEL1_DATA, c);
   427b0:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   427b4:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   427bb:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   427be:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   427c2:	8b 55 d8             	mov    -0x28(%rbp),%edx
   427c5:	ee                   	out    %al,(%dx)
}
   427c6:	90                   	nop
   427c7:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   427ce:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   427d2:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   427d6:	8b 55 e0             	mov    -0x20(%rbp),%edx
   427d9:	ee                   	out    %al,(%dx)
}
   427da:	90                   	nop
   427db:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   427e2:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   427e6:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   427ea:	8b 55 e8             	mov    -0x18(%rbp),%edx
   427ed:	ee                   	out    %al,(%dx)
}
   427ee:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   427ef:	90                   	nop
   427f0:	c9                   	leave  
   427f1:	c3                   	ret    

00000000000427f2 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   427f2:	55                   	push   %rbp
   427f3:	48 89 e5             	mov    %rsp,%rbp
   427f6:	48 83 ec 20          	sub    $0x20,%rsp
   427fa:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   427fe:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   42802:	48 c7 45 f8 41 27 04 	movq   $0x42741,-0x8(%rbp)
   42809:	00 
    printer_vprintf(&p, 0, format, val);
   4280a:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   4280e:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   42812:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   42816:	be 00 00 00 00       	mov    $0x0,%esi
   4281b:	48 89 c7             	mov    %rax,%rdi
   4281e:	e8 98 11 00 00       	call   439bb <printer_vprintf>
}
   42823:	90                   	nop
   42824:	c9                   	leave  
   42825:	c3                   	ret    

0000000000042826 <log_printf>:

void log_printf(const char* format, ...) {
   42826:	55                   	push   %rbp
   42827:	48 89 e5             	mov    %rsp,%rbp
   4282a:	48 83 ec 60          	sub    $0x60,%rsp
   4282e:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42832:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42836:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   4283a:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4283e:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42842:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42846:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   4284d:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42851:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42855:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42859:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   4285d:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   42861:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42865:	48 89 d6             	mov    %rdx,%rsi
   42868:	48 89 c7             	mov    %rax,%rdi
   4286b:	e8 82 ff ff ff       	call   427f2 <log_vprintf>
    va_end(val);
}
   42870:	90                   	nop
   42871:	c9                   	leave  
   42872:	c3                   	ret    

0000000000042873 <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   42873:	55                   	push   %rbp
   42874:	48 89 e5             	mov    %rsp,%rbp
   42877:	48 83 ec 40          	sub    $0x40,%rsp
   4287b:	89 7d dc             	mov    %edi,-0x24(%rbp)
   4287e:	89 75 d8             	mov    %esi,-0x28(%rbp)
   42881:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   42885:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   42889:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   4288d:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42891:	48 8b 0a             	mov    (%rdx),%rcx
   42894:	48 89 08             	mov    %rcx,(%rax)
   42897:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   4289b:	48 89 48 08          	mov    %rcx,0x8(%rax)
   4289f:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   428a3:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   428a7:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   428ab:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   428af:	48 89 d6             	mov    %rdx,%rsi
   428b2:	48 89 c7             	mov    %rax,%rdi
   428b5:	e8 38 ff ff ff       	call   427f2 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   428ba:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   428be:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   428c2:	8b 75 d8             	mov    -0x28(%rbp),%esi
   428c5:	8b 45 dc             	mov    -0x24(%rbp),%eax
   428c8:	89 c7                	mov    %eax,%edi
   428ca:	e8 9b 1b 00 00       	call   4446a <console_vprintf>
}
   428cf:	c9                   	leave  
   428d0:	c3                   	ret    

00000000000428d1 <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   428d1:	55                   	push   %rbp
   428d2:	48 89 e5             	mov    %rsp,%rbp
   428d5:	48 83 ec 60          	sub    $0x60,%rsp
   428d9:	89 7d ac             	mov    %edi,-0x54(%rbp)
   428dc:	89 75 a8             	mov    %esi,-0x58(%rbp)
   428df:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   428e3:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   428e7:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   428eb:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   428ef:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   428f6:	48 8d 45 10          	lea    0x10(%rbp),%rax
   428fa:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   428fe:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42902:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   42906:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   4290a:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   4290e:	8b 75 a8             	mov    -0x58(%rbp),%esi
   42911:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42914:	89 c7                	mov    %eax,%edi
   42916:	e8 58 ff ff ff       	call   42873 <error_vprintf>
   4291b:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   4291e:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   42921:	c9                   	leave  
   42922:	c3                   	ret    

0000000000042923 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'f', and 'e' cause a soft
//    reboot where the kernel runs the allocator programs, "fork", or
//    "forkexit", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   42923:	55                   	push   %rbp
   42924:	48 89 e5             	mov    %rsp,%rbp
   42927:	53                   	push   %rbx
   42928:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   4292c:	e8 ac fb ff ff       	call   424dd <keyboard_readc>
   42931:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   42934:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42938:	74 1c                	je     42956 <check_keyboard+0x33>
   4293a:	83 7d e4 66          	cmpl   $0x66,-0x1c(%rbp)
   4293e:	74 16                	je     42956 <check_keyboard+0x33>
   42940:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42944:	74 10                	je     42956 <check_keyboard+0x33>
   42946:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   4294a:	74 0a                	je     42956 <check_keyboard+0x33>
   4294c:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42950:	0f 85 e9 00 00 00    	jne    42a3f <check_keyboard+0x11c>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   42956:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   4295d:	00 
        memset(pt, 0, PAGESIZE * 3);
   4295e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42962:	ba 00 30 00 00       	mov    $0x3000,%edx
   42967:	be 00 00 00 00       	mov    $0x0,%esi
   4296c:	48 89 c7             	mov    %rax,%rdi
   4296f:	e8 ab 0d 00 00       	call   4371f <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   42974:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42978:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   4297f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42983:	48 05 00 10 00 00    	add    $0x1000,%rax
   42989:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   42990:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42994:	48 05 00 20 00 00    	add    $0x2000,%rax
   4299a:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   429a1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   429a5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   429a9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   429ad:	0f 22 d8             	mov    %rax,%cr3
}
   429b0:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   429b1:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "fork";
   429b8:	48 c7 45 e8 98 4c 04 	movq   $0x44c98,-0x18(%rbp)
   429bf:	00 
        if (c == 'a') {
   429c0:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   429c4:	75 0a                	jne    429d0 <check_keyboard+0xad>
            argument = "allocator";
   429c6:	48 c7 45 e8 9d 4c 04 	movq   $0x44c9d,-0x18(%rbp)
   429cd:	00 
   429ce:	eb 2e                	jmp    429fe <check_keyboard+0xdb>
        } else if (c == 'e') {
   429d0:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   429d4:	75 0a                	jne    429e0 <check_keyboard+0xbd>
            argument = "forkexit";
   429d6:	48 c7 45 e8 a7 4c 04 	movq   $0x44ca7,-0x18(%rbp)
   429dd:	00 
   429de:	eb 1e                	jmp    429fe <check_keyboard+0xdb>
        }
        else if (c == 't'){
   429e0:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   429e4:	75 0a                	jne    429f0 <check_keyboard+0xcd>
            argument = "test";
   429e6:	48 c7 45 e8 b0 4c 04 	movq   $0x44cb0,-0x18(%rbp)
   429ed:	00 
   429ee:	eb 0e                	jmp    429fe <check_keyboard+0xdb>
        }
        else if(c == '2'){
   429f0:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   429f4:	75 08                	jne    429fe <check_keyboard+0xdb>
            argument = "test2";
   429f6:	48 c7 45 e8 b5 4c 04 	movq   $0x44cb5,-0x18(%rbp)
   429fd:	00 
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   429fe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42a02:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   42a06:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42a0b:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   42a0f:	73 14                	jae    42a25 <check_keyboard+0x102>
   42a11:	ba bb 4c 04 00       	mov    $0x44cbb,%edx
   42a16:	be 5d 02 00 00       	mov    $0x25d,%esi
   42a1b:	bf d7 4c 04 00       	mov    $0x44cd7,%edi
   42a20:	e8 1f 01 00 00       	call   42b44 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   42a25:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42a29:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   42a2c:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   42a30:	48 89 c3             	mov    %rax,%rbx
   42a33:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   42a38:	e9 c3 d5 ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   42a3d:	eb 11                	jmp    42a50 <check_keyboard+0x12d>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   42a3f:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   42a43:	74 06                	je     42a4b <check_keyboard+0x128>
   42a45:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   42a49:	75 05                	jne    42a50 <check_keyboard+0x12d>
        poweroff();
   42a4b:	e8 9d f8 ff ff       	call   422ed <poweroff>
    }
    return c;
   42a50:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   42a53:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42a57:	c9                   	leave  
   42a58:	c3                   	ret    

0000000000042a59 <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   42a59:	55                   	push   %rbp
   42a5a:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   42a5d:	e8 c1 fe ff ff       	call   42923 <check_keyboard>
   42a62:	eb f9                	jmp    42a5d <fail+0x4>

0000000000042a64 <panic>:

// panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void panic(const char* format, ...) {
   42a64:	55                   	push   %rbp
   42a65:	48 89 e5             	mov    %rsp,%rbp
   42a68:	48 83 ec 60          	sub    $0x60,%rsp
   42a6c:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42a70:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42a74:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42a78:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42a7c:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42a80:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42a84:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   42a8b:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42a8f:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   42a93:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42a97:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   42a9b:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   42aa0:	0f 84 80 00 00 00    	je     42b26 <panic+0xc2>
        // Print panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   42aa6:	ba eb 4c 04 00       	mov    $0x44ceb,%edx
   42aab:	be 00 c0 00 00       	mov    $0xc000,%esi
   42ab0:	bf 30 07 00 00       	mov    $0x730,%edi
   42ab5:	b8 00 00 00 00       	mov    $0x0,%eax
   42aba:	e8 12 fe ff ff       	call   428d1 <error_printf>
   42abf:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   42ac2:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   42ac6:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   42aca:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42acd:	be 00 c0 00 00       	mov    $0xc000,%esi
   42ad2:	89 c7                	mov    %eax,%edi
   42ad4:	e8 9a fd ff ff       	call   42873 <error_vprintf>
   42ad9:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   42adc:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   42adf:	48 63 c1             	movslq %ecx,%rax
   42ae2:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   42ae9:	48 c1 e8 20          	shr    $0x20,%rax
   42aed:	89 c2                	mov    %eax,%edx
   42aef:	c1 fa 05             	sar    $0x5,%edx
   42af2:	89 c8                	mov    %ecx,%eax
   42af4:	c1 f8 1f             	sar    $0x1f,%eax
   42af7:	29 c2                	sub    %eax,%edx
   42af9:	89 d0                	mov    %edx,%eax
   42afb:	c1 e0 02             	shl    $0x2,%eax
   42afe:	01 d0                	add    %edx,%eax
   42b00:	c1 e0 04             	shl    $0x4,%eax
   42b03:	29 c1                	sub    %eax,%ecx
   42b05:	89 ca                	mov    %ecx,%edx
   42b07:	85 d2                	test   %edx,%edx
   42b09:	74 34                	je     42b3f <panic+0xdb>
            error_printf(cpos, 0xC000, "\n");
   42b0b:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42b0e:	ba f3 4c 04 00       	mov    $0x44cf3,%edx
   42b13:	be 00 c0 00 00       	mov    $0xc000,%esi
   42b18:	89 c7                	mov    %eax,%edi
   42b1a:	b8 00 00 00 00       	mov    $0x0,%eax
   42b1f:	e8 ad fd ff ff       	call   428d1 <error_printf>
   42b24:	eb 19                	jmp    42b3f <panic+0xdb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   42b26:	ba f5 4c 04 00       	mov    $0x44cf5,%edx
   42b2b:	be 00 c0 00 00       	mov    $0xc000,%esi
   42b30:	bf 30 07 00 00       	mov    $0x730,%edi
   42b35:	b8 00 00 00 00       	mov    $0x0,%eax
   42b3a:	e8 92 fd ff ff       	call   428d1 <error_printf>
    }

    va_end(val);
    fail();
   42b3f:	e8 15 ff ff ff       	call   42a59 <fail>

0000000000042b44 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   42b44:	55                   	push   %rbp
   42b45:	48 89 e5             	mov    %rsp,%rbp
   42b48:	48 83 ec 20          	sub    $0x20,%rsp
   42b4c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42b50:	89 75 f4             	mov    %esi,-0xc(%rbp)
   42b53:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   42b57:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   42b5b:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42b5e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42b62:	48 89 c6             	mov    %rax,%rsi
   42b65:	bf fb 4c 04 00       	mov    $0x44cfb,%edi
   42b6a:	b8 00 00 00 00       	mov    $0x0,%eax
   42b6f:	e8 f0 fe ff ff       	call   42a64 <panic>

0000000000042b74 <default_exception>:
}

void default_exception(proc* p){
   42b74:	55                   	push   %rbp
   42b75:	48 89 e5             	mov    %rsp,%rbp
   42b78:	48 83 ec 20          	sub    $0x20,%rsp
   42b7c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   42b80:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b84:	48 83 c0 08          	add    $0x8,%rax
   42b88:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    panic("Unexpected exception %d!\n", reg->reg_intno);
   42b8c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42b90:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   42b97:	48 89 c6             	mov    %rax,%rsi
   42b9a:	bf 19 4d 04 00       	mov    $0x44d19,%edi
   42b9f:	b8 00 00 00 00       	mov    $0x0,%eax
   42ba4:	e8 bb fe ff ff       	call   42a64 <panic>

0000000000042ba9 <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   42ba9:	55                   	push   %rbp
   42baa:	48 89 e5             	mov    %rsp,%rbp
   42bad:	48 83 ec 10          	sub    $0x10,%rsp
   42bb1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42bb5:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   42bb8:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   42bbc:	78 06                	js     42bc4 <pageindex+0x1b>
   42bbe:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   42bc2:	7e 14                	jle    42bd8 <pageindex+0x2f>
   42bc4:	ba 38 4d 04 00       	mov    $0x44d38,%edx
   42bc9:	be 1e 00 00 00       	mov    $0x1e,%esi
   42bce:	bf 51 4d 04 00       	mov    $0x44d51,%edi
   42bd3:	e8 6c ff ff ff       	call   42b44 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   42bd8:	b8 03 00 00 00       	mov    $0x3,%eax
   42bdd:	2b 45 f4             	sub    -0xc(%rbp),%eax
   42be0:	89 c2                	mov    %eax,%edx
   42be2:	89 d0                	mov    %edx,%eax
   42be4:	c1 e0 03             	shl    $0x3,%eax
   42be7:	01 d0                	add    %edx,%eax
   42be9:	83 c0 0c             	add    $0xc,%eax
   42bec:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42bf0:	89 c1                	mov    %eax,%ecx
   42bf2:	48 d3 ea             	shr    %cl,%rdx
   42bf5:	48 89 d0             	mov    %rdx,%rax
   42bf8:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   42bfd:	c9                   	leave  
   42bfe:	c3                   	ret    

0000000000042bff <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   42bff:	55                   	push   %rbp
   42c00:	48 89 e5             	mov    %rsp,%rbp
   42c03:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   42c07:	48 c7 05 ee 23 01 00 	movq   $0x56000,0x123ee(%rip)        # 55000 <kernel_pagetable>
   42c0e:	00 60 05 00 
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   42c12:	ba 00 50 00 00       	mov    $0x5000,%edx
   42c17:	be 00 00 00 00       	mov    $0x0,%esi
   42c1c:	bf 00 60 05 00       	mov    $0x56000,%edi
   42c21:	e8 f9 0a 00 00       	call   4371f <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   42c26:	b8 00 70 05 00       	mov    $0x57000,%eax
   42c2b:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   42c2f:	48 89 05 ca 33 01 00 	mov    %rax,0x133ca(%rip)        # 56000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   42c36:	b8 00 80 05 00       	mov    $0x58000,%eax
   42c3b:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   42c3f:	48 89 05 ba 43 01 00 	mov    %rax,0x143ba(%rip)        # 57000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   42c46:	b8 00 90 05 00       	mov    $0x59000,%eax
   42c4b:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   42c4f:	48 89 05 aa 53 01 00 	mov    %rax,0x153aa(%rip)        # 58000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   42c56:	b8 00 a0 05 00       	mov    $0x5a000,%eax
   42c5b:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   42c5f:	48 89 05 a2 53 01 00 	mov    %rax,0x153a2(%rip)        # 58008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   42c66:	48 8b 05 93 23 01 00 	mov    0x12393(%rip),%rax        # 55000 <kernel_pagetable>
   42c6d:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42c73:	b9 00 00 20 00       	mov    $0x200000,%ecx
   42c78:	ba 00 00 00 00       	mov    $0x0,%edx
   42c7d:	be 00 00 00 00       	mov    $0x0,%esi
   42c82:	48 89 c7             	mov    %rax,%rdi
   42c85:	e8 b9 01 00 00       	call   42e43 <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42c8a:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42c91:	00 
   42c92:	eb 62                	jmp    42cf6 <virtual_memory_init+0xf7>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   42c94:	48 8b 0d 65 23 01 00 	mov    0x12365(%rip),%rcx        # 55000 <kernel_pagetable>
   42c9b:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42c9f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42ca3:	48 89 ce             	mov    %rcx,%rsi
   42ca6:	48 89 c7             	mov    %rax,%rdi
   42ca9:	e8 5b 05 00 00       	call   43209 <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l1pagetable ?
        assert(vmap.pa == addr);
   42cae:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42cb2:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   42cb6:	74 14                	je     42ccc <virtual_memory_init+0xcd>
   42cb8:	ba 65 4d 04 00       	mov    $0x44d65,%edx
   42cbd:	be 2d 00 00 00       	mov    $0x2d,%esi
   42cc2:	bf 75 4d 04 00       	mov    $0x44d75,%edi
   42cc7:	e8 78 fe ff ff       	call   42b44 <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   42ccc:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42ccf:	48 98                	cltq   
   42cd1:	83 e0 03             	and    $0x3,%eax
   42cd4:	48 83 f8 03          	cmp    $0x3,%rax
   42cd8:	74 14                	je     42cee <virtual_memory_init+0xef>
   42cda:	ba 88 4d 04 00       	mov    $0x44d88,%edx
   42cdf:	be 2e 00 00 00       	mov    $0x2e,%esi
   42ce4:	bf 75 4d 04 00       	mov    $0x44d75,%edi
   42ce9:	e8 56 fe ff ff       	call   42b44 <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42cee:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42cf5:	00 
   42cf6:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   42cfd:	00 
   42cfe:	76 94                	jbe    42c94 <virtual_memory_init+0x95>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   42d00:	48 8b 05 f9 22 01 00 	mov    0x122f9(%rip),%rax        # 55000 <kernel_pagetable>
   42d07:	48 89 c7             	mov    %rax,%rdi
   42d0a:	e8 03 00 00 00       	call   42d12 <set_pagetable>
}
   42d0f:	90                   	nop
   42d10:	c9                   	leave  
   42d11:	c3                   	ret    

0000000000042d12 <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   42d12:	55                   	push   %rbp
   42d13:	48 89 e5             	mov    %rsp,%rbp
   42d16:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   42d1a:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   42d1e:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42d22:	25 ff 0f 00 00       	and    $0xfff,%eax
   42d27:	48 85 c0             	test   %rax,%rax
   42d2a:	74 14                	je     42d40 <set_pagetable+0x2e>
   42d2c:	ba b5 4d 04 00       	mov    $0x44db5,%edx
   42d31:	be 3d 00 00 00       	mov    $0x3d,%esi
   42d36:	bf 75 4d 04 00       	mov    $0x44d75,%edi
   42d3b:	e8 04 fe ff ff       	call   42b44 <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   42d40:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42d45:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   42d49:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42d4d:	48 89 ce             	mov    %rcx,%rsi
   42d50:	48 89 c7             	mov    %rax,%rdi
   42d53:	e8 b1 04 00 00       	call   43209 <virtual_memory_lookup>
   42d58:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42d5c:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42d61:	48 39 d0             	cmp    %rdx,%rax
   42d64:	74 14                	je     42d7a <set_pagetable+0x68>
   42d66:	ba d0 4d 04 00       	mov    $0x44dd0,%edx
   42d6b:	be 3f 00 00 00       	mov    $0x3f,%esi
   42d70:	bf 75 4d 04 00       	mov    $0x44d75,%edi
   42d75:	e8 ca fd ff ff       	call   42b44 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   42d7a:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   42d7e:	48 8b 0d 7b 22 01 00 	mov    0x1227b(%rip),%rcx        # 55000 <kernel_pagetable>
   42d85:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   42d89:	48 89 ce             	mov    %rcx,%rsi
   42d8c:	48 89 c7             	mov    %rax,%rdi
   42d8f:	e8 75 04 00 00       	call   43209 <virtual_memory_lookup>
   42d94:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42d98:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42d9c:	48 39 c2             	cmp    %rax,%rdx
   42d9f:	74 14                	je     42db5 <set_pagetable+0xa3>
   42da1:	ba 38 4e 04 00       	mov    $0x44e38,%edx
   42da6:	be 41 00 00 00       	mov    $0x41,%esi
   42dab:	bf 75 4d 04 00       	mov    $0x44d75,%edi
   42db0:	e8 8f fd ff ff       	call   42b44 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   42db5:	48 8b 05 44 22 01 00 	mov    0x12244(%rip),%rax        # 55000 <kernel_pagetable>
   42dbc:	48 89 c2             	mov    %rax,%rdx
   42dbf:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   42dc3:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42dc7:	48 89 ce             	mov    %rcx,%rsi
   42dca:	48 89 c7             	mov    %rax,%rdi
   42dcd:	e8 37 04 00 00       	call   43209 <virtual_memory_lookup>
   42dd2:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42dd6:	48 8b 15 23 22 01 00 	mov    0x12223(%rip),%rdx        # 55000 <kernel_pagetable>
   42ddd:	48 39 d0             	cmp    %rdx,%rax
   42de0:	74 14                	je     42df6 <set_pagetable+0xe4>
   42de2:	ba 98 4e 04 00       	mov    $0x44e98,%edx
   42de7:	be 43 00 00 00       	mov    $0x43,%esi
   42dec:	bf 75 4d 04 00       	mov    $0x44d75,%edi
   42df1:	e8 4e fd ff ff       	call   42b44 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   42df6:	ba 43 2e 04 00       	mov    $0x42e43,%edx
   42dfb:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42dff:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42e03:	48 89 ce             	mov    %rcx,%rsi
   42e06:	48 89 c7             	mov    %rax,%rdi
   42e09:	e8 fb 03 00 00       	call   43209 <virtual_memory_lookup>
   42e0e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42e12:	ba 43 2e 04 00       	mov    $0x42e43,%edx
   42e17:	48 39 d0             	cmp    %rdx,%rax
   42e1a:	74 14                	je     42e30 <set_pagetable+0x11e>
   42e1c:	ba 00 4f 04 00       	mov    $0x44f00,%edx
   42e21:	be 45 00 00 00       	mov    $0x45,%esi
   42e26:	bf 75 4d 04 00       	mov    $0x44d75,%edi
   42e2b:	e8 14 fd ff ff       	call   42b44 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   42e30:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42e34:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42e38:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42e3c:	0f 22 d8             	mov    %rax,%cr3
}
   42e3f:	90                   	nop
}
   42e40:	90                   	nop
   42e41:	c9                   	leave  
   42e42:	c3                   	ret    

0000000000042e43 <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   42e43:	55                   	push   %rbp
   42e44:	48 89 e5             	mov    %rsp,%rbp
   42e47:	41 54                	push   %r12
   42e49:	53                   	push   %rbx
   42e4a:	48 83 ec 50          	sub    $0x50,%rsp
   42e4e:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42e52:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42e56:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   42e5a:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
   42e5e:	44 89 45 ac          	mov    %r8d,-0x54(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   42e62:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42e66:	25 ff 0f 00 00       	and    $0xfff,%eax
   42e6b:	48 85 c0             	test   %rax,%rax
   42e6e:	74 14                	je     42e84 <virtual_memory_map+0x41>
   42e70:	ba 66 4f 04 00       	mov    $0x44f66,%edx
   42e75:	be 66 00 00 00       	mov    $0x66,%esi
   42e7a:	bf 75 4d 04 00       	mov    $0x44d75,%edi
   42e7f:	e8 c0 fc ff ff       	call   42b44 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   42e84:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42e88:	25 ff 0f 00 00       	and    $0xfff,%eax
   42e8d:	48 85 c0             	test   %rax,%rax
   42e90:	74 14                	je     42ea6 <virtual_memory_map+0x63>
   42e92:	ba 79 4f 04 00       	mov    $0x44f79,%edx
   42e97:	be 67 00 00 00       	mov    $0x67,%esi
   42e9c:	bf 75 4d 04 00       	mov    $0x44d75,%edi
   42ea1:	e8 9e fc ff ff       	call   42b44 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   42ea6:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42eaa:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42eae:	48 01 d0             	add    %rdx,%rax
   42eb1:	48 3b 45 c0          	cmp    -0x40(%rbp),%rax
   42eb5:	73 24                	jae    42edb <virtual_memory_map+0x98>
   42eb7:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42ebb:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42ebf:	48 01 d0             	add    %rdx,%rax
   42ec2:	48 85 c0             	test   %rax,%rax
   42ec5:	74 14                	je     42edb <virtual_memory_map+0x98>
   42ec7:	ba 8c 4f 04 00       	mov    $0x44f8c,%edx
   42ecc:	be 68 00 00 00       	mov    $0x68,%esi
   42ed1:	bf 75 4d 04 00       	mov    $0x44d75,%edi
   42ed6:	e8 69 fc ff ff       	call   42b44 <assert_fail>
    if (perm & PTE_P) {
   42edb:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42ede:	48 98                	cltq   
   42ee0:	83 e0 01             	and    $0x1,%eax
   42ee3:	48 85 c0             	test   %rax,%rax
   42ee6:	74 6e                	je     42f56 <virtual_memory_map+0x113>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   42ee8:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42eec:	25 ff 0f 00 00       	and    $0xfff,%eax
   42ef1:	48 85 c0             	test   %rax,%rax
   42ef4:	74 14                	je     42f0a <virtual_memory_map+0xc7>
   42ef6:	ba aa 4f 04 00       	mov    $0x44faa,%edx
   42efb:	be 6a 00 00 00       	mov    $0x6a,%esi
   42f00:	bf 75 4d 04 00       	mov    $0x44d75,%edi
   42f05:	e8 3a fc ff ff       	call   42b44 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   42f0a:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42f0e:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42f12:	48 01 d0             	add    %rdx,%rax
   42f15:	48 3b 45 b8          	cmp    -0x48(%rbp),%rax
   42f19:	73 14                	jae    42f2f <virtual_memory_map+0xec>
   42f1b:	ba bd 4f 04 00       	mov    $0x44fbd,%edx
   42f20:	be 6b 00 00 00       	mov    $0x6b,%esi
   42f25:	bf 75 4d 04 00       	mov    $0x44d75,%edi
   42f2a:	e8 15 fc ff ff       	call   42b44 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   42f2f:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42f33:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42f37:	48 01 d0             	add    %rdx,%rax
   42f3a:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   42f40:	76 14                	jbe    42f56 <virtual_memory_map+0x113>
   42f42:	ba cb 4f 04 00       	mov    $0x44fcb,%edx
   42f47:	be 6c 00 00 00       	mov    $0x6c,%esi
   42f4c:	bf 75 4d 04 00       	mov    $0x44d75,%edi
   42f51:	e8 ee fb ff ff       	call   42b44 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   42f56:	83 7d ac 00          	cmpl   $0x0,-0x54(%rbp)
   42f5a:	78 09                	js     42f65 <virtual_memory_map+0x122>
   42f5c:	81 7d ac ff 0f 00 00 	cmpl   $0xfff,-0x54(%rbp)
   42f63:	7e 14                	jle    42f79 <virtual_memory_map+0x136>
   42f65:	ba e7 4f 04 00       	mov    $0x44fe7,%edx
   42f6a:	be 6e 00 00 00       	mov    $0x6e,%esi
   42f6f:	bf 75 4d 04 00       	mov    $0x44d75,%edi
   42f74:	e8 cb fb ff ff       	call   42b44 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   42f79:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42f7d:	25 ff 0f 00 00       	and    $0xfff,%eax
   42f82:	48 85 c0             	test   %rax,%rax
   42f85:	74 14                	je     42f9b <virtual_memory_map+0x158>
   42f87:	ba 08 50 04 00       	mov    $0x45008,%edx
   42f8c:	be 6f 00 00 00       	mov    $0x6f,%esi
   42f91:	bf 75 4d 04 00       	mov    $0x44d75,%edi
   42f96:	e8 a9 fb ff ff       	call   42b44 <assert_fail>

    int last_index123 = -1;
   42f9b:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%rbp)
    x86_64_pagetable* l1pagetable = NULL;
   42fa2:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
   42fa9:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42faa:	e9 e7 00 00 00       	jmp    43096 <virtual_memory_map+0x253>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   42faf:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42fb3:	48 c1 e8 15          	shr    $0x15,%rax
   42fb7:	89 45 dc             	mov    %eax,-0x24(%rbp)
        if (cur_index123 != last_index123) {
   42fba:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42fbd:	3b 45 ec             	cmp    -0x14(%rbp),%eax
   42fc0:	74 20                	je     42fe2 <virtual_memory_map+0x19f>
            // TODO --> done
            // find pointer to last level pagetable for current va

			l1pagetable = lookup_l1pagetable(pagetable, va, perm);	
   42fc2:	8b 55 ac             	mov    -0x54(%rbp),%edx
   42fc5:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   42fc9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42fcd:	48 89 ce             	mov    %rcx,%rsi
   42fd0:	48 89 c7             	mov    %rax,%rdi
   42fd3:	e8 d7 00 00 00       	call   430af <lookup_l1pagetable>
   42fd8:	48 89 45 e0          	mov    %rax,-0x20(%rbp)

            last_index123 = cur_index123;
   42fdc:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42fdf:	89 45 ec             	mov    %eax,-0x14(%rbp)
        }
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   42fe2:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42fe5:	48 98                	cltq   
   42fe7:	83 e0 01             	and    $0x1,%eax
   42fea:	48 85 c0             	test   %rax,%rax
   42fed:	74 3a                	je     43029 <virtual_memory_map+0x1e6>
   42fef:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42ff4:	74 33                	je     43029 <virtual_memory_map+0x1e6>
            // TODO --> done
            // map `pa` at appropriate entry with permissions `perm`
			l1pagetable->entry[L1PAGEINDEX(va)] =  (0x00000000FFFFFFFF & pa) | perm;
   42ff6:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42ffa:	41 89 c4             	mov    %eax,%r12d
   42ffd:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43000:	48 63 d8             	movslq %eax,%rbx
   43003:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43007:	be 03 00 00 00       	mov    $0x3,%esi
   4300c:	48 89 c7             	mov    %rax,%rdi
   4300f:	e8 95 fb ff ff       	call   42ba9 <pageindex>
   43014:	89 c2                	mov    %eax,%edx
   43016:	4c 89 e1             	mov    %r12,%rcx
   43019:	48 09 d9             	or     %rbx,%rcx
   4301c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43020:	48 63 d2             	movslq %edx,%rdx
   43023:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   43027:	eb 55                	jmp    4307e <virtual_memory_map+0x23b>

        } else if (l1pagetable) { // if page is NOT marked present
   43029:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   4302e:	74 26                	je     43056 <virtual_memory_map+0x213>
            // TODO --> done
            // map to address 0 with `perm`
			l1pagetable->entry[L1PAGEINDEX(va)] = 0 | perm;
   43030:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43034:	be 03 00 00 00       	mov    $0x3,%esi
   43039:	48 89 c7             	mov    %rax,%rdi
   4303c:	e8 68 fb ff ff       	call   42ba9 <pageindex>
   43041:	89 c2                	mov    %eax,%edx
   43043:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43046:	48 63 c8             	movslq %eax,%rcx
   43049:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4304d:	48 63 d2             	movslq %edx,%rdx
   43050:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   43054:	eb 28                	jmp    4307e <virtual_memory_map+0x23b>

        } else if (perm & PTE_P) {
   43056:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43059:	48 98                	cltq   
   4305b:	83 e0 01             	and    $0x1,%eax
   4305e:	48 85 c0             	test   %rax,%rax
   43061:	74 1b                	je     4307e <virtual_memory_map+0x23b>
            // error, no allocated l1 page found for va
            log_printf("[Kern Info] failed to find l1pagetable address at " __FILE__ ": %d\n", __LINE__);
   43063:	be 8b 00 00 00       	mov    $0x8b,%esi
   43068:	bf 30 50 04 00       	mov    $0x45030,%edi
   4306d:	b8 00 00 00 00       	mov    $0x0,%eax
   43072:	e8 af f7 ff ff       	call   42826 <log_printf>
            return -1;
   43077:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4307c:	eb 28                	jmp    430a6 <virtual_memory_map+0x263>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   4307e:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
   43085:	00 
   43086:	48 81 45 b8 00 10 00 	addq   $0x1000,-0x48(%rbp)
   4308d:	00 
   4308e:	48 81 6d b0 00 10 00 	subq   $0x1000,-0x50(%rbp)
   43095:	00 
   43096:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   4309b:	0f 85 0e ff ff ff    	jne    42faf <virtual_memory_map+0x16c>
        }
    }
    return 0;
   430a1:	b8 00 00 00 00       	mov    $0x0,%eax
}
   430a6:	48 83 c4 50          	add    $0x50,%rsp
   430aa:	5b                   	pop    %rbx
   430ab:	41 5c                	pop    %r12
   430ad:	5d                   	pop    %rbp
   430ae:	c3                   	ret    

00000000000430af <lookup_l1pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   430af:	55                   	push   %rbp
   430b0:	48 89 e5             	mov    %rsp,%rbp
   430b3:	48 83 ec 40          	sub    $0x40,%rsp
   430b7:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   430bb:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   430bf:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   430c2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   430c6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l1 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   430ca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   430d1:	e9 23 01 00 00       	jmp    431f9 <lookup_l1pagetable+0x14a>
        // TODO --> done
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        x86_64_pageentry_t pe = pt->entry[PAGEINDEX(va, i)]; // replace this
   430d6:	8b 55 f4             	mov    -0xc(%rbp),%edx
   430d9:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   430dd:	89 d6                	mov    %edx,%esi
   430df:	48 89 c7             	mov    %rax,%rdi
   430e2:	e8 c2 fa ff ff       	call   42ba9 <pageindex>
   430e7:	89 c2                	mov    %eax,%edx
   430e9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   430ed:	48 63 d2             	movslq %edx,%rdx
   430f0:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   430f4:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   430f8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   430fc:	83 e0 01             	and    $0x1,%eax
   430ff:	48 85 c0             	test   %rax,%rax
   43102:	75 63                	jne    43167 <lookup_l1pagetable+0xb8>
            log_printf("[Kern Info] Error looking up l1pagetable: Pagetable address: 0x%x perm: 0x%x."
   43104:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43107:	8d 48 02             	lea    0x2(%rax),%ecx
   4310a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4310e:	25 ff 0f 00 00       	and    $0xfff,%eax
   43113:	48 89 c2             	mov    %rax,%rdx
   43116:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4311a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43120:	48 89 c6             	mov    %rax,%rsi
   43123:	bf 78 50 04 00       	mov    $0x45078,%edi
   43128:	b8 00 00 00 00       	mov    $0x0,%eax
   4312d:	e8 f4 f6 ff ff       	call   42826 <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   43132:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43135:	48 98                	cltq   
   43137:	83 e0 01             	and    $0x1,%eax
   4313a:	48 85 c0             	test   %rax,%rax
   4313d:	75 0a                	jne    43149 <lookup_l1pagetable+0x9a>
                return NULL;
   4313f:	b8 00 00 00 00       	mov    $0x0,%eax
   43144:	e9 be 00 00 00       	jmp    43207 <lookup_l1pagetable+0x158>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   43149:	be af 00 00 00       	mov    $0xaf,%esi
   4314e:	bf e0 50 04 00       	mov    $0x450e0,%edi
   43153:	b8 00 00 00 00       	mov    $0x0,%eax
   43158:	e8 c9 f6 ff ff       	call   42826 <log_printf>
            return NULL;
   4315d:	b8 00 00 00 00       	mov    $0x0,%eax
   43162:	e9 a0 00 00 00       	jmp    43207 <lookup_l1pagetable+0x158>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   43167:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4316b:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43171:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   43177:	76 14                	jbe    4318d <lookup_l1pagetable+0xde>
   43179:	ba 28 51 04 00       	mov    $0x45128,%edx
   4317e:	be b4 00 00 00       	mov    $0xb4,%esi
   43183:	bf 75 4d 04 00       	mov    $0x44d75,%edi
   43188:	e8 b7 f9 ff ff       	call   42b44 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   4318d:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43190:	48 98                	cltq   
   43192:	83 e0 02             	and    $0x2,%eax
   43195:	48 85 c0             	test   %rax,%rax
   43198:	74 20                	je     431ba <lookup_l1pagetable+0x10b>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   4319a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4319e:	83 e0 02             	and    $0x2,%eax
   431a1:	48 85 c0             	test   %rax,%rax
   431a4:	75 14                	jne    431ba <lookup_l1pagetable+0x10b>
   431a6:	ba 48 51 04 00       	mov    $0x45148,%edx
   431ab:	be b6 00 00 00       	mov    $0xb6,%esi
   431b0:	bf 75 4d 04 00       	mov    $0x44d75,%edi
   431b5:	e8 8a f9 ff ff       	call   42b44 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   431ba:	8b 45 cc             	mov    -0x34(%rbp),%eax
   431bd:	48 98                	cltq   
   431bf:	83 e0 04             	and    $0x4,%eax
   431c2:	48 85 c0             	test   %rax,%rax
   431c5:	74 20                	je     431e7 <lookup_l1pagetable+0x138>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   431c7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   431cb:	83 e0 04             	and    $0x4,%eax
   431ce:	48 85 c0             	test   %rax,%rax
   431d1:	75 14                	jne    431e7 <lookup_l1pagetable+0x138>
   431d3:	ba 53 51 04 00       	mov    $0x45153,%edx
   431d8:	be b9 00 00 00       	mov    $0xb9,%esi
   431dd:	bf 75 4d 04 00       	mov    $0x44d75,%edi
   431e2:	e8 5d f9 ff ff       	call   42b44 <assert_fail>
        }

        // TODO --> done
        // set pt to physical address to next pagetable using `pe`
        pt = (x86_64_pagetable *) PTE_ADDR(pe); // replace this
   431e7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   431eb:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   431f1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   431f5:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   431f9:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   431fd:	0f 8e d3 fe ff ff    	jle    430d6 <lookup_l1pagetable+0x27>
    }
    return pt;
   43203:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43207:	c9                   	leave  
   43208:	c3                   	ret    

0000000000043209 <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   43209:	55                   	push   %rbp
   4320a:	48 89 e5             	mov    %rsp,%rbp
   4320d:	48 83 ec 50          	sub    $0x50,%rsp
   43211:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   43215:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   43219:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   4321d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43221:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   43225:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   4322c:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   4322d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   43234:	eb 41                	jmp    43277 <virtual_memory_lookup+0x6e>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   43236:	8b 55 ec             	mov    -0x14(%rbp),%edx
   43239:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4323d:	89 d6                	mov    %edx,%esi
   4323f:	48 89 c7             	mov    %rax,%rdi
   43242:	e8 62 f9 ff ff       	call   42ba9 <pageindex>
   43247:	89 c2                	mov    %eax,%edx
   43249:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4324d:	48 63 d2             	movslq %edx,%rdx
   43250:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   43254:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43258:	83 e0 06             	and    $0x6,%eax
   4325b:	48 f7 d0             	not    %rax
   4325e:	48 21 d0             	and    %rdx,%rax
   43261:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   43265:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43269:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4326f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   43273:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   43277:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   4327b:	7f 0c                	jg     43289 <virtual_memory_lookup+0x80>
   4327d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43281:	83 e0 01             	and    $0x1,%eax
   43284:	48 85 c0             	test   %rax,%rax
   43287:	75 ad                	jne    43236 <virtual_memory_lookup+0x2d>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   43289:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   43290:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   43297:	ff 
   43298:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   4329f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432a3:	83 e0 01             	and    $0x1,%eax
   432a6:	48 85 c0             	test   %rax,%rax
   432a9:	74 34                	je     432df <virtual_memory_lookup+0xd6>
        vam.pn = PAGENUMBER(pe);
   432ab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432af:	48 c1 e8 0c          	shr    $0xc,%rax
   432b3:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   432b6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432ba:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   432c0:	48 89 c2             	mov    %rax,%rdx
   432c3:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   432c7:	25 ff 0f 00 00       	and    $0xfff,%eax
   432cc:	48 09 d0             	or     %rdx,%rax
   432cf:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   432d3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432d7:	25 ff 0f 00 00       	and    $0xfff,%eax
   432dc:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   432df:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   432e3:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   432e7:	48 89 10             	mov    %rdx,(%rax)
   432ea:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   432ee:	48 89 50 08          	mov    %rdx,0x8(%rax)
   432f2:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   432f6:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   432fa:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   432fe:	c9                   	leave  
   432ff:	c3                   	ret    

0000000000043300 <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   43300:	55                   	push   %rbp
   43301:	48 89 e5             	mov    %rsp,%rbp
   43304:	48 83 ec 40          	sub    $0x40,%rsp
   43308:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   4330c:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   4330f:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   43313:	c7 45 f8 07 00 00 00 	movl   $0x7,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   4331a:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   4331e:	78 08                	js     43328 <program_load+0x28>
   43320:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   43323:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   43326:	7c 14                	jl     4333c <program_load+0x3c>
   43328:	ba 60 51 04 00       	mov    $0x45160,%edx
   4332d:	be 37 00 00 00       	mov    $0x37,%esi
   43332:	bf 90 51 04 00       	mov    $0x45190,%edi
   43337:	e8 08 f8 ff ff       	call   42b44 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   4333c:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   4333f:	48 98                	cltq   
   43341:	48 c1 e0 04          	shl    $0x4,%rax
   43345:	48 05 20 60 04 00    	add    $0x46020,%rax
   4334b:	48 8b 00             	mov    (%rax),%rax
   4334e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   43352:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43356:	8b 00                	mov    (%rax),%eax
   43358:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   4335d:	74 14                	je     43373 <program_load+0x73>
   4335f:	ba a2 51 04 00       	mov    $0x451a2,%edx
   43364:	be 39 00 00 00       	mov    $0x39,%esi
   43369:	bf 90 51 04 00       	mov    $0x45190,%edi
   4336e:	e8 d1 f7 ff ff       	call   42b44 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   43373:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43377:	48 8b 50 20          	mov    0x20(%rax),%rdx
   4337b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4337f:	48 01 d0             	add    %rdx,%rax
   43382:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   43386:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4338d:	e9 94 00 00 00       	jmp    43426 <program_load+0x126>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   43392:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43395:	48 63 d0             	movslq %eax,%rdx
   43398:	48 89 d0             	mov    %rdx,%rax
   4339b:	48 c1 e0 03          	shl    $0x3,%rax
   4339f:	48 29 d0             	sub    %rdx,%rax
   433a2:	48 c1 e0 03          	shl    $0x3,%rax
   433a6:	48 89 c2             	mov    %rax,%rdx
   433a9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   433ad:	48 01 d0             	add    %rdx,%rax
   433b0:	8b 00                	mov    (%rax),%eax
   433b2:	83 f8 01             	cmp    $0x1,%eax
   433b5:	75 6b                	jne    43422 <program_load+0x122>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   433b7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   433ba:	48 63 d0             	movslq %eax,%rdx
   433bd:	48 89 d0             	mov    %rdx,%rax
   433c0:	48 c1 e0 03          	shl    $0x3,%rax
   433c4:	48 29 d0             	sub    %rdx,%rax
   433c7:	48 c1 e0 03          	shl    $0x3,%rax
   433cb:	48 89 c2             	mov    %rax,%rdx
   433ce:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   433d2:	48 01 d0             	add    %rdx,%rax
   433d5:	48 8b 50 08          	mov    0x8(%rax),%rdx
   433d9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   433dd:	48 01 d0             	add    %rdx,%rax
   433e0:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   433e4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   433e7:	48 63 d0             	movslq %eax,%rdx
   433ea:	48 89 d0             	mov    %rdx,%rax
   433ed:	48 c1 e0 03          	shl    $0x3,%rax
   433f1:	48 29 d0             	sub    %rdx,%rax
   433f4:	48 c1 e0 03          	shl    $0x3,%rax
   433f8:	48 89 c2             	mov    %rax,%rdx
   433fb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   433ff:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   43403:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   43407:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   4340b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4340f:	48 89 c7             	mov    %rax,%rdi
   43412:	e8 3d 00 00 00       	call   43454 <program_load_segment>
   43417:	85 c0                	test   %eax,%eax
   43419:	79 07                	jns    43422 <program_load+0x122>
                return -1;
   4341b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43420:	eb 30                	jmp    43452 <program_load+0x152>
    for (int i = 0; i < eh->e_phnum; ++i) {
   43422:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   43426:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4342a:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   4342e:	0f b7 c0             	movzwl %ax,%eax
   43431:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   43434:	0f 8c 58 ff ff ff    	jl     43392 <program_load+0x92>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   4343a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4343e:	48 8b 50 18          	mov    0x18(%rax),%rdx
   43442:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43446:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    return 0;
   4344d:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43452:	c9                   	leave  
   43453:	c3                   	ret    

0000000000043454 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   43454:	55                   	push   %rbp
   43455:	48 89 e5             	mov    %rsp,%rbp
   43458:	48 83 ec 70          	sub    $0x70,%rsp
   4345c:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   43460:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   43464:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   43468:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   4346c:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   43470:	48 8b 40 10          	mov    0x10(%rax),%rax
   43474:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   43478:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   4347c:	48 8b 50 20          	mov    0x20(%rax),%rdx
   43480:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43484:	48 01 d0             	add    %rdx,%rax
   43487:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   4348b:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   4348f:	48 8b 50 28          	mov    0x28(%rax),%rdx
   43493:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43497:	48 01 d0             	add    %rdx,%rax
   4349a:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   4349e:	48 81 65 e8 00 f0 ff 	andq   $0xfffffffffffff000,-0x18(%rbp)
   434a5:	ff 

	// virtual addressing
	for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   434a6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   434aa:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   434ae:	e9 8f 00 00 00       	jmp    43542 <program_load_segment+0xee>
		uintptr_t pa;
		if (next_free_page(&pa) < 0
   434b3:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   434b7:	48 89 c7             	mov    %rax,%rdi
   434ba:	e8 0b cf ff ff       	call   403ca <next_free_page>
   434bf:	85 c0                	test   %eax,%eax
   434c1:	78 45                	js     43508 <program_load_segment+0xb4>
			|| assign_physical_page(pa, p->p_pid) < 0
   434c3:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   434c7:	8b 00                	mov    (%rax),%eax
   434c9:	0f be d0             	movsbl %al,%edx
   434cc:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   434d0:	89 d6                	mov    %edx,%esi
   434d2:	48 89 c7             	mov    %rax,%rdi
   434d5:	e8 5d d1 ff ff       	call   40637 <assign_physical_page>
   434da:	85 c0                	test   %eax,%eax
   434dc:	78 2a                	js     43508 <program_load_segment+0xb4>
			|| virtual_memory_map(p->p_pagetable, addr, pa, PAGESIZE, PTE_P | PTE_W | PTE_U) < 0) {
   434de:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   434e2:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   434e6:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   434ed:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   434f1:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   434f7:	b9 00 10 00 00       	mov    $0x1000,%ecx
   434fc:	48 89 c7             	mov    %rax,%rdi
   434ff:	e8 3f f9 ff ff       	call   42e43 <virtual_memory_map>
   43504:	85 c0                	test   %eax,%eax
   43506:	79 32                	jns    4353a <program_load_segment+0xe6>

			console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   43508:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4350c:	8b 00                	mov    (%rax),%eax
   4350e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43512:	49 89 d0             	mov    %rdx,%r8
   43515:	89 c1                	mov    %eax,%ecx
   43517:	ba c0 51 04 00       	mov    $0x451c0,%edx
   4351c:	be 00 c0 00 00       	mov    $0xc000,%esi
   43521:	bf e0 06 00 00       	mov    $0x6e0,%edi
   43526:	b8 00 00 00 00       	mov    $0x0,%eax
   4352b:	e8 a6 0f 00 00       	call   444d6 <console_printf>
			return -1;
   43530:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43535:	e9 e5 00 00 00       	jmp    4361f <program_load_segment+0x1cb>
	for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   4353a:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43541:	00 
   43542:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43546:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   4354a:	0f 82 63 ff ff ff    	jb     434b3 <program_load_segment+0x5f>
    *     }
    * }
	*/

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   43550:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43554:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   4355b:	48 89 c7             	mov    %rax,%rdi
   4355e:	e8 af f7 ff ff       	call   42d12 <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   43563:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43567:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   4356b:	48 89 c2             	mov    %rax,%rdx
   4356e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43572:	48 8b 4d 98          	mov    -0x68(%rbp),%rcx
   43576:	48 89 ce             	mov    %rcx,%rsi
   43579:	48 89 c7             	mov    %rax,%rdi
   4357c:	e8 a0 00 00 00       	call   43621 <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   43581:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43585:	48 2b 45 e0          	sub    -0x20(%rbp),%rax
   43589:	48 89 c2             	mov    %rax,%rdx
   4358c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43590:	be 00 00 00 00       	mov    $0x0,%esi
   43595:	48 89 c7             	mov    %rax,%rdi
   43598:	e8 82 01 00 00       	call   4371f <memset>

	// change to readonly permissions
	if ((ph->p_flags & ELF_PFLAG_WRITE) == 0) {
   4359d:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   435a1:	8b 40 04             	mov    0x4(%rax),%eax
   435a4:	83 e0 02             	and    $0x2,%eax
   435a7:	85 c0                	test   %eax,%eax
   435a9:	75 60                	jne    4360b <program_load_segment+0x1b7>
		for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   435ab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   435af:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   435b3:	eb 4c                	jmp    43601 <program_load_segment+0x1ad>
			vamapping map = virtual_memory_lookup(p->p_pagetable, addr);
   435b5:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   435b9:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   435c0:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   435c4:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   435c8:	48 89 ce             	mov    %rcx,%rsi
   435cb:	48 89 c7             	mov    %rax,%rdi
   435ce:	e8 36 fc ff ff       	call   43209 <virtual_memory_lookup>
			virtual_memory_map(p->p_pagetable, addr, map.pa, PAGESIZE, PTE_P | PTE_U );
   435d3:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   435d7:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   435db:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   435e2:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   435e6:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   435ec:	b9 00 10 00 00       	mov    $0x1000,%ecx
   435f1:	48 89 c7             	mov    %rax,%rdi
   435f4:	e8 4a f8 ff ff       	call   42e43 <virtual_memory_map>
		for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   435f9:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   43600:	00 
   43601:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43605:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   43609:	72 aa                	jb     435b5 <program_load_segment+0x161>
		}
	}

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   4360b:	48 8b 05 ee 19 01 00 	mov    0x119ee(%rip),%rax        # 55000 <kernel_pagetable>
   43612:	48 89 c7             	mov    %rax,%rdi
   43615:	e8 f8 f6 ff ff       	call   42d12 <set_pagetable>
    return 0;
   4361a:	b8 00 00 00 00       	mov    $0x0,%eax
}
   4361f:	c9                   	leave  
   43620:	c3                   	ret    

0000000000043621 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   43621:	55                   	push   %rbp
   43622:	48 89 e5             	mov    %rsp,%rbp
   43625:	48 83 ec 28          	sub    $0x28,%rsp
   43629:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4362d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43631:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43635:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43639:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   4363d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43641:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43645:	eb 1c                	jmp    43663 <memcpy+0x42>
        *d = *s;
   43647:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4364b:	0f b6 10             	movzbl (%rax),%edx
   4364e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43652:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43654:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43659:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   4365e:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   43663:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43668:	75 dd                	jne    43647 <memcpy+0x26>
    }
    return dst;
   4366a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   4366e:	c9                   	leave  
   4366f:	c3                   	ret    

0000000000043670 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   43670:	55                   	push   %rbp
   43671:	48 89 e5             	mov    %rsp,%rbp
   43674:	48 83 ec 28          	sub    $0x28,%rsp
   43678:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4367c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43680:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43684:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43688:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   4368c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43690:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   43694:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43698:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   4369c:	73 6a                	jae    43708 <memmove+0x98>
   4369e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   436a2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   436a6:	48 01 d0             	add    %rdx,%rax
   436a9:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   436ad:	73 59                	jae    43708 <memmove+0x98>
        s += n, d += n;
   436af:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   436b3:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   436b7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   436bb:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   436bf:	eb 17                	jmp    436d8 <memmove+0x68>
            *--d = *--s;
   436c1:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   436c6:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   436cb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   436cf:	0f b6 10             	movzbl (%rax),%edx
   436d2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   436d6:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   436d8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   436dc:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   436e0:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   436e4:	48 85 c0             	test   %rax,%rax
   436e7:	75 d8                	jne    436c1 <memmove+0x51>
    if (s < d && s + n > d) {
   436e9:	eb 2e                	jmp    43719 <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   436eb:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   436ef:	48 8d 42 01          	lea    0x1(%rdx),%rax
   436f3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   436f7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   436fb:	48 8d 48 01          	lea    0x1(%rax),%rcx
   436ff:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   43703:	0f b6 12             	movzbl (%rdx),%edx
   43706:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43708:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4370c:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43710:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43714:	48 85 c0             	test   %rax,%rax
   43717:	75 d2                	jne    436eb <memmove+0x7b>
        }
    }
    return dst;
   43719:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   4371d:	c9                   	leave  
   4371e:	c3                   	ret    

000000000004371f <memset>:

void* memset(void* v, int c, size_t n) {
   4371f:	55                   	push   %rbp
   43720:	48 89 e5             	mov    %rsp,%rbp
   43723:	48 83 ec 28          	sub    $0x28,%rsp
   43727:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4372b:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   4372e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43732:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43736:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   4373a:	eb 15                	jmp    43751 <memset+0x32>
        *p = c;
   4373c:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4373f:	89 c2                	mov    %eax,%edx
   43741:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43745:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43747:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   4374c:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43751:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43756:	75 e4                	jne    4373c <memset+0x1d>
    }
    return v;
   43758:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   4375c:	c9                   	leave  
   4375d:	c3                   	ret    

000000000004375e <strlen>:

size_t strlen(const char* s) {
   4375e:	55                   	push   %rbp
   4375f:	48 89 e5             	mov    %rsp,%rbp
   43762:	48 83 ec 18          	sub    $0x18,%rsp
   43766:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   4376a:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43771:	00 
   43772:	eb 0a                	jmp    4377e <strlen+0x20>
        ++n;
   43774:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   43779:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   4377e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43782:	0f b6 00             	movzbl (%rax),%eax
   43785:	84 c0                	test   %al,%al
   43787:	75 eb                	jne    43774 <strlen+0x16>
    }
    return n;
   43789:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   4378d:	c9                   	leave  
   4378e:	c3                   	ret    

000000000004378f <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   4378f:	55                   	push   %rbp
   43790:	48 89 e5             	mov    %rsp,%rbp
   43793:	48 83 ec 20          	sub    $0x20,%rsp
   43797:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4379b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   4379f:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   437a6:	00 
   437a7:	eb 0a                	jmp    437b3 <strnlen+0x24>
        ++n;
   437a9:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   437ae:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   437b3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   437b7:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   437bb:	74 0b                	je     437c8 <strnlen+0x39>
   437bd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   437c1:	0f b6 00             	movzbl (%rax),%eax
   437c4:	84 c0                	test   %al,%al
   437c6:	75 e1                	jne    437a9 <strnlen+0x1a>
    }
    return n;
   437c8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   437cc:	c9                   	leave  
   437cd:	c3                   	ret    

00000000000437ce <strcpy>:

char* strcpy(char* dst, const char* src) {
   437ce:	55                   	push   %rbp
   437cf:	48 89 e5             	mov    %rsp,%rbp
   437d2:	48 83 ec 20          	sub    $0x20,%rsp
   437d6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   437da:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   437de:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   437e2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   437e6:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   437ea:	48 8d 42 01          	lea    0x1(%rdx),%rax
   437ee:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   437f2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   437f6:	48 8d 48 01          	lea    0x1(%rax),%rcx
   437fa:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   437fe:	0f b6 12             	movzbl (%rdx),%edx
   43801:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   43803:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43807:	48 83 e8 01          	sub    $0x1,%rax
   4380b:	0f b6 00             	movzbl (%rax),%eax
   4380e:	84 c0                	test   %al,%al
   43810:	75 d4                	jne    437e6 <strcpy+0x18>
    return dst;
   43812:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43816:	c9                   	leave  
   43817:	c3                   	ret    

0000000000043818 <strcmp>:

int strcmp(const char* a, const char* b) {
   43818:	55                   	push   %rbp
   43819:	48 89 e5             	mov    %rsp,%rbp
   4381c:	48 83 ec 10          	sub    $0x10,%rsp
   43820:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43824:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43828:	eb 0a                	jmp    43834 <strcmp+0x1c>
        ++a, ++b;
   4382a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   4382f:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43834:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43838:	0f b6 00             	movzbl (%rax),%eax
   4383b:	84 c0                	test   %al,%al
   4383d:	74 1d                	je     4385c <strcmp+0x44>
   4383f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43843:	0f b6 00             	movzbl (%rax),%eax
   43846:	84 c0                	test   %al,%al
   43848:	74 12                	je     4385c <strcmp+0x44>
   4384a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4384e:	0f b6 10             	movzbl (%rax),%edx
   43851:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43855:	0f b6 00             	movzbl (%rax),%eax
   43858:	38 c2                	cmp    %al,%dl
   4385a:	74 ce                	je     4382a <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   4385c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43860:	0f b6 00             	movzbl (%rax),%eax
   43863:	89 c2                	mov    %eax,%edx
   43865:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43869:	0f b6 00             	movzbl (%rax),%eax
   4386c:	38 d0                	cmp    %dl,%al
   4386e:	0f 92 c0             	setb   %al
   43871:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   43874:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43878:	0f b6 00             	movzbl (%rax),%eax
   4387b:	89 c1                	mov    %eax,%ecx
   4387d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43881:	0f b6 00             	movzbl (%rax),%eax
   43884:	38 c1                	cmp    %al,%cl
   43886:	0f 92 c0             	setb   %al
   43889:	0f b6 c0             	movzbl %al,%eax
   4388c:	29 c2                	sub    %eax,%edx
   4388e:	89 d0                	mov    %edx,%eax
}
   43890:	c9                   	leave  
   43891:	c3                   	ret    

0000000000043892 <strchr>:

char* strchr(const char* s, int c) {
   43892:	55                   	push   %rbp
   43893:	48 89 e5             	mov    %rsp,%rbp
   43896:	48 83 ec 10          	sub    $0x10,%rsp
   4389a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4389e:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   438a1:	eb 05                	jmp    438a8 <strchr+0x16>
        ++s;
   438a3:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   438a8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   438ac:	0f b6 00             	movzbl (%rax),%eax
   438af:	84 c0                	test   %al,%al
   438b1:	74 0e                	je     438c1 <strchr+0x2f>
   438b3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   438b7:	0f b6 00             	movzbl (%rax),%eax
   438ba:	8b 55 f4             	mov    -0xc(%rbp),%edx
   438bd:	38 d0                	cmp    %dl,%al
   438bf:	75 e2                	jne    438a3 <strchr+0x11>
    }
    if (*s == (char) c) {
   438c1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   438c5:	0f b6 00             	movzbl (%rax),%eax
   438c8:	8b 55 f4             	mov    -0xc(%rbp),%edx
   438cb:	38 d0                	cmp    %dl,%al
   438cd:	75 06                	jne    438d5 <strchr+0x43>
        return (char*) s;
   438cf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   438d3:	eb 05                	jmp    438da <strchr+0x48>
    } else {
        return NULL;
   438d5:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   438da:	c9                   	leave  
   438db:	c3                   	ret    

00000000000438dc <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   438dc:	55                   	push   %rbp
   438dd:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   438e0:	8b 05 1a 77 01 00    	mov    0x1771a(%rip),%eax        # 5b000 <rand_seed_set>
   438e6:	85 c0                	test   %eax,%eax
   438e8:	75 0a                	jne    438f4 <rand+0x18>
        srand(819234718U);
   438ea:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   438ef:	e8 24 00 00 00       	call   43918 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   438f4:	8b 05 0a 77 01 00    	mov    0x1770a(%rip),%eax        # 5b004 <rand_seed>
   438fa:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   43900:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   43905:	89 05 f9 76 01 00    	mov    %eax,0x176f9(%rip)        # 5b004 <rand_seed>
    return rand_seed & RAND_MAX;
   4390b:	8b 05 f3 76 01 00    	mov    0x176f3(%rip),%eax        # 5b004 <rand_seed>
   43911:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   43916:	5d                   	pop    %rbp
   43917:	c3                   	ret    

0000000000043918 <srand>:

void srand(unsigned seed) {
   43918:	55                   	push   %rbp
   43919:	48 89 e5             	mov    %rsp,%rbp
   4391c:	48 83 ec 08          	sub    $0x8,%rsp
   43920:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   43923:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43926:	89 05 d8 76 01 00    	mov    %eax,0x176d8(%rip)        # 5b004 <rand_seed>
    rand_seed_set = 1;
   4392c:	c7 05 ca 76 01 00 01 	movl   $0x1,0x176ca(%rip)        # 5b000 <rand_seed_set>
   43933:	00 00 00 
}
   43936:	90                   	nop
   43937:	c9                   	leave  
   43938:	c3                   	ret    

0000000000043939 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   43939:	55                   	push   %rbp
   4393a:	48 89 e5             	mov    %rsp,%rbp
   4393d:	48 83 ec 28          	sub    $0x28,%rsp
   43941:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43945:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43949:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   4394c:	48 c7 45 f8 e0 53 04 	movq   $0x453e0,-0x8(%rbp)
   43953:	00 
    if (base < 0) {
   43954:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   43958:	79 0b                	jns    43965 <fill_numbuf+0x2c>
        digits = lower_digits;
   4395a:	48 c7 45 f8 00 54 04 	movq   $0x45400,-0x8(%rbp)
   43961:	00 
        base = -base;
   43962:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   43965:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   4396a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4396e:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   43971:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43974:	48 63 c8             	movslq %eax,%rcx
   43977:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4397b:	ba 00 00 00 00       	mov    $0x0,%edx
   43980:	48 f7 f1             	div    %rcx
   43983:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43987:	48 01 d0             	add    %rdx,%rax
   4398a:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   4398f:	0f b6 10             	movzbl (%rax),%edx
   43992:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43996:	88 10                	mov    %dl,(%rax)
        val /= base;
   43998:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4399b:	48 63 f0             	movslq %eax,%rsi
   4399e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   439a2:	ba 00 00 00 00       	mov    $0x0,%edx
   439a7:	48 f7 f6             	div    %rsi
   439aa:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   439ae:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   439b3:	75 bc                	jne    43971 <fill_numbuf+0x38>
    return numbuf_end;
   439b5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   439b9:	c9                   	leave  
   439ba:	c3                   	ret    

00000000000439bb <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   439bb:	55                   	push   %rbp
   439bc:	48 89 e5             	mov    %rsp,%rbp
   439bf:	53                   	push   %rbx
   439c0:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   439c7:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   439ce:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   439d4:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   439db:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   439e2:	e9 8a 09 00 00       	jmp    44371 <printer_vprintf+0x9b6>
        if (*format != '%') {
   439e7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   439ee:	0f b6 00             	movzbl (%rax),%eax
   439f1:	3c 25                	cmp    $0x25,%al
   439f3:	74 31                	je     43a26 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
   439f5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   439fc:	4c 8b 00             	mov    (%rax),%r8
   439ff:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43a06:	0f b6 00             	movzbl (%rax),%eax
   43a09:	0f b6 c8             	movzbl %al,%ecx
   43a0c:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43a12:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43a19:	89 ce                	mov    %ecx,%esi
   43a1b:	48 89 c7             	mov    %rax,%rdi
   43a1e:	41 ff d0             	call   *%r8
            continue;
   43a21:	e9 43 09 00 00       	jmp    44369 <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
   43a26:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   43a2d:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43a34:	01 
   43a35:	eb 44                	jmp    43a7b <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
   43a37:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43a3e:	0f b6 00             	movzbl (%rax),%eax
   43a41:	0f be c0             	movsbl %al,%eax
   43a44:	89 c6                	mov    %eax,%esi
   43a46:	bf 00 52 04 00       	mov    $0x45200,%edi
   43a4b:	e8 42 fe ff ff       	call   43892 <strchr>
   43a50:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   43a54:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   43a59:	74 30                	je     43a8b <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
   43a5b:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   43a5f:	48 2d 00 52 04 00    	sub    $0x45200,%rax
   43a65:	ba 01 00 00 00       	mov    $0x1,%edx
   43a6a:	89 c1                	mov    %eax,%ecx
   43a6c:	d3 e2                	shl    %cl,%edx
   43a6e:	89 d0                	mov    %edx,%eax
   43a70:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   43a73:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43a7a:	01 
   43a7b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43a82:	0f b6 00             	movzbl (%rax),%eax
   43a85:	84 c0                	test   %al,%al
   43a87:	75 ae                	jne    43a37 <printer_vprintf+0x7c>
   43a89:	eb 01                	jmp    43a8c <printer_vprintf+0xd1>
            } else {
                break;
   43a8b:	90                   	nop
            }
        }

        // process width
        int width = -1;
   43a8c:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   43a93:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43a9a:	0f b6 00             	movzbl (%rax),%eax
   43a9d:	3c 30                	cmp    $0x30,%al
   43a9f:	7e 67                	jle    43b08 <printer_vprintf+0x14d>
   43aa1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43aa8:	0f b6 00             	movzbl (%rax),%eax
   43aab:	3c 39                	cmp    $0x39,%al
   43aad:	7f 59                	jg     43b08 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43aaf:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   43ab6:	eb 2e                	jmp    43ae6 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
   43ab8:	8b 55 e8             	mov    -0x18(%rbp),%edx
   43abb:	89 d0                	mov    %edx,%eax
   43abd:	c1 e0 02             	shl    $0x2,%eax
   43ac0:	01 d0                	add    %edx,%eax
   43ac2:	01 c0                	add    %eax,%eax
   43ac4:	89 c1                	mov    %eax,%ecx
   43ac6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43acd:	48 8d 50 01          	lea    0x1(%rax),%rdx
   43ad1:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43ad8:	0f b6 00             	movzbl (%rax),%eax
   43adb:	0f be c0             	movsbl %al,%eax
   43ade:	01 c8                	add    %ecx,%eax
   43ae0:	83 e8 30             	sub    $0x30,%eax
   43ae3:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43ae6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43aed:	0f b6 00             	movzbl (%rax),%eax
   43af0:	3c 2f                	cmp    $0x2f,%al
   43af2:	0f 8e 85 00 00 00    	jle    43b7d <printer_vprintf+0x1c2>
   43af8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43aff:	0f b6 00             	movzbl (%rax),%eax
   43b02:	3c 39                	cmp    $0x39,%al
   43b04:	7e b2                	jle    43ab8 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
   43b06:	eb 75                	jmp    43b7d <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
   43b08:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43b0f:	0f b6 00             	movzbl (%rax),%eax
   43b12:	3c 2a                	cmp    $0x2a,%al
   43b14:	75 68                	jne    43b7e <printer_vprintf+0x1c3>
            width = va_arg(val, int);
   43b16:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b1d:	8b 00                	mov    (%rax),%eax
   43b1f:	83 f8 2f             	cmp    $0x2f,%eax
   43b22:	77 30                	ja     43b54 <printer_vprintf+0x199>
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
   43b52:	eb 1a                	jmp    43b6e <printer_vprintf+0x1b3>
   43b54:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43b5b:	48 8b 40 08          	mov    0x8(%rax),%rax
   43b5f:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43b63:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43b6a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43b6e:	8b 00                	mov    (%rax),%eax
   43b70:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   43b73:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43b7a:	01 
   43b7b:	eb 01                	jmp    43b7e <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
   43b7d:	90                   	nop
        }

        // process precision
        int precision = -1;
   43b7e:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   43b85:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43b8c:	0f b6 00             	movzbl (%rax),%eax
   43b8f:	3c 2e                	cmp    $0x2e,%al
   43b91:	0f 85 00 01 00 00    	jne    43c97 <printer_vprintf+0x2dc>
            ++format;
   43b97:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43b9e:	01 
            if (*format >= '0' && *format <= '9') {
   43b9f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43ba6:	0f b6 00             	movzbl (%rax),%eax
   43ba9:	3c 2f                	cmp    $0x2f,%al
   43bab:	7e 67                	jle    43c14 <printer_vprintf+0x259>
   43bad:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43bb4:	0f b6 00             	movzbl (%rax),%eax
   43bb7:	3c 39                	cmp    $0x39,%al
   43bb9:	7f 59                	jg     43c14 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43bbb:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   43bc2:	eb 2e                	jmp    43bf2 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
   43bc4:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   43bc7:	89 d0                	mov    %edx,%eax
   43bc9:	c1 e0 02             	shl    $0x2,%eax
   43bcc:	01 d0                	add    %edx,%eax
   43bce:	01 c0                	add    %eax,%eax
   43bd0:	89 c1                	mov    %eax,%ecx
   43bd2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43bd9:	48 8d 50 01          	lea    0x1(%rax),%rdx
   43bdd:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43be4:	0f b6 00             	movzbl (%rax),%eax
   43be7:	0f be c0             	movsbl %al,%eax
   43bea:	01 c8                	add    %ecx,%eax
   43bec:	83 e8 30             	sub    $0x30,%eax
   43bef:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43bf2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43bf9:	0f b6 00             	movzbl (%rax),%eax
   43bfc:	3c 2f                	cmp    $0x2f,%al
   43bfe:	0f 8e 85 00 00 00    	jle    43c89 <printer_vprintf+0x2ce>
   43c04:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43c0b:	0f b6 00             	movzbl (%rax),%eax
   43c0e:	3c 39                	cmp    $0x39,%al
   43c10:	7e b2                	jle    43bc4 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
   43c12:	eb 75                	jmp    43c89 <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
   43c14:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43c1b:	0f b6 00             	movzbl (%rax),%eax
   43c1e:	3c 2a                	cmp    $0x2a,%al
   43c20:	75 68                	jne    43c8a <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
   43c22:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c29:	8b 00                	mov    (%rax),%eax
   43c2b:	83 f8 2f             	cmp    $0x2f,%eax
   43c2e:	77 30                	ja     43c60 <printer_vprintf+0x2a5>
   43c30:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c37:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43c3b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c42:	8b 00                	mov    (%rax),%eax
   43c44:	89 c0                	mov    %eax,%eax
   43c46:	48 01 d0             	add    %rdx,%rax
   43c49:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c50:	8b 12                	mov    (%rdx),%edx
   43c52:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43c55:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c5c:	89 0a                	mov    %ecx,(%rdx)
   43c5e:	eb 1a                	jmp    43c7a <printer_vprintf+0x2bf>
   43c60:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43c67:	48 8b 40 08          	mov    0x8(%rax),%rax
   43c6b:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43c6f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43c76:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43c7a:	8b 00                	mov    (%rax),%eax
   43c7c:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   43c7f:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43c86:	01 
   43c87:	eb 01                	jmp    43c8a <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
   43c89:	90                   	nop
            }
            if (precision < 0) {
   43c8a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   43c8e:	79 07                	jns    43c97 <printer_vprintf+0x2dc>
                precision = 0;
   43c90:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   43c97:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   43c9e:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   43ca5:	00 
        int length = 0;
   43ca6:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   43cad:	48 c7 45 c8 06 52 04 	movq   $0x45206,-0x38(%rbp)
   43cb4:	00 
    again:
        switch (*format) {
   43cb5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43cbc:	0f b6 00             	movzbl (%rax),%eax
   43cbf:	0f be c0             	movsbl %al,%eax
   43cc2:	83 e8 43             	sub    $0x43,%eax
   43cc5:	83 f8 37             	cmp    $0x37,%eax
   43cc8:	0f 87 9f 03 00 00    	ja     4406d <printer_vprintf+0x6b2>
   43cce:	89 c0                	mov    %eax,%eax
   43cd0:	48 8b 04 c5 18 52 04 	mov    0x45218(,%rax,8),%rax
   43cd7:	00 
   43cd8:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
   43cda:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   43ce1:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43ce8:	01 
            goto again;
   43ce9:	eb ca                	jmp    43cb5 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   43ceb:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43cef:	74 5d                	je     43d4e <printer_vprintf+0x393>
   43cf1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43cf8:	8b 00                	mov    (%rax),%eax
   43cfa:	83 f8 2f             	cmp    $0x2f,%eax
   43cfd:	77 30                	ja     43d2f <printer_vprintf+0x374>
   43cff:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d06:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43d0a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d11:	8b 00                	mov    (%rax),%eax
   43d13:	89 c0                	mov    %eax,%eax
   43d15:	48 01 d0             	add    %rdx,%rax
   43d18:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d1f:	8b 12                	mov    (%rdx),%edx
   43d21:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43d24:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d2b:	89 0a                	mov    %ecx,(%rdx)
   43d2d:	eb 1a                	jmp    43d49 <printer_vprintf+0x38e>
   43d2f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d36:	48 8b 40 08          	mov    0x8(%rax),%rax
   43d3a:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43d3e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d45:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43d49:	48 8b 00             	mov    (%rax),%rax
   43d4c:	eb 5c                	jmp    43daa <printer_vprintf+0x3ef>
   43d4e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d55:	8b 00                	mov    (%rax),%eax
   43d57:	83 f8 2f             	cmp    $0x2f,%eax
   43d5a:	77 30                	ja     43d8c <printer_vprintf+0x3d1>
   43d5c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d63:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43d67:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d6e:	8b 00                	mov    (%rax),%eax
   43d70:	89 c0                	mov    %eax,%eax
   43d72:	48 01 d0             	add    %rdx,%rax
   43d75:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d7c:	8b 12                	mov    (%rdx),%edx
   43d7e:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43d81:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43d88:	89 0a                	mov    %ecx,(%rdx)
   43d8a:	eb 1a                	jmp    43da6 <printer_vprintf+0x3eb>
   43d8c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43d93:	48 8b 40 08          	mov    0x8(%rax),%rax
   43d97:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43d9b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43da2:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43da6:	8b 00                	mov    (%rax),%eax
   43da8:	48 98                	cltq   
   43daa:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   43dae:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43db2:	48 c1 f8 38          	sar    $0x38,%rax
   43db6:	25 80 00 00 00       	and    $0x80,%eax
   43dbb:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   43dbe:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   43dc2:	74 09                	je     43dcd <printer_vprintf+0x412>
   43dc4:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43dc8:	48 f7 d8             	neg    %rax
   43dcb:	eb 04                	jmp    43dd1 <printer_vprintf+0x416>
   43dcd:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43dd1:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   43dd5:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   43dd8:	83 c8 60             	or     $0x60,%eax
   43ddb:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   43dde:	e9 cf 02 00 00       	jmp    440b2 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   43de3:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43de7:	74 5d                	je     43e46 <printer_vprintf+0x48b>
   43de9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43df0:	8b 00                	mov    (%rax),%eax
   43df2:	83 f8 2f             	cmp    $0x2f,%eax
   43df5:	77 30                	ja     43e27 <printer_vprintf+0x46c>
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
   43e25:	eb 1a                	jmp    43e41 <printer_vprintf+0x486>
   43e27:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e2e:	48 8b 40 08          	mov    0x8(%rax),%rax
   43e32:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43e36:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e3d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43e41:	48 8b 00             	mov    (%rax),%rax
   43e44:	eb 5c                	jmp    43ea2 <printer_vprintf+0x4e7>
   43e46:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e4d:	8b 00                	mov    (%rax),%eax
   43e4f:	83 f8 2f             	cmp    $0x2f,%eax
   43e52:	77 30                	ja     43e84 <printer_vprintf+0x4c9>
   43e54:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e5b:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43e5f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e66:	8b 00                	mov    (%rax),%eax
   43e68:	89 c0                	mov    %eax,%eax
   43e6a:	48 01 d0             	add    %rdx,%rax
   43e6d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e74:	8b 12                	mov    (%rdx),%edx
   43e76:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43e79:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e80:	89 0a                	mov    %ecx,(%rdx)
   43e82:	eb 1a                	jmp    43e9e <printer_vprintf+0x4e3>
   43e84:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e8b:	48 8b 40 08          	mov    0x8(%rax),%rax
   43e8f:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43e93:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e9a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43e9e:	8b 00                	mov    (%rax),%eax
   43ea0:	89 c0                	mov    %eax,%eax
   43ea2:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   43ea6:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   43eaa:	e9 03 02 00 00       	jmp    440b2 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
   43eaf:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   43eb6:	e9 28 ff ff ff       	jmp    43de3 <printer_vprintf+0x428>
        case 'X':
            base = 16;
   43ebb:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   43ec2:	e9 1c ff ff ff       	jmp    43de3 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   43ec7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ece:	8b 00                	mov    (%rax),%eax
   43ed0:	83 f8 2f             	cmp    $0x2f,%eax
   43ed3:	77 30                	ja     43f05 <printer_vprintf+0x54a>
   43ed5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43edc:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43ee0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ee7:	8b 00                	mov    (%rax),%eax
   43ee9:	89 c0                	mov    %eax,%eax
   43eeb:	48 01 d0             	add    %rdx,%rax
   43eee:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43ef5:	8b 12                	mov    (%rdx),%edx
   43ef7:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43efa:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f01:	89 0a                	mov    %ecx,(%rdx)
   43f03:	eb 1a                	jmp    43f1f <printer_vprintf+0x564>
   43f05:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f0c:	48 8b 40 08          	mov    0x8(%rax),%rax
   43f10:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43f14:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f1b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43f1f:	48 8b 00             	mov    (%rax),%rax
   43f22:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   43f26:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   43f2d:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   43f34:	e9 79 01 00 00       	jmp    440b2 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
   43f39:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f40:	8b 00                	mov    (%rax),%eax
   43f42:	83 f8 2f             	cmp    $0x2f,%eax
   43f45:	77 30                	ja     43f77 <printer_vprintf+0x5bc>
   43f47:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f4e:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43f52:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f59:	8b 00                	mov    (%rax),%eax
   43f5b:	89 c0                	mov    %eax,%eax
   43f5d:	48 01 d0             	add    %rdx,%rax
   43f60:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f67:	8b 12                	mov    (%rdx),%edx
   43f69:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43f6c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f73:	89 0a                	mov    %ecx,(%rdx)
   43f75:	eb 1a                	jmp    43f91 <printer_vprintf+0x5d6>
   43f77:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f7e:	48 8b 40 08          	mov    0x8(%rax),%rax
   43f82:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43f86:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f8d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43f91:	48 8b 00             	mov    (%rax),%rax
   43f94:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   43f98:	e9 15 01 00 00       	jmp    440b2 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
   43f9d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43fa4:	8b 00                	mov    (%rax),%eax
   43fa6:	83 f8 2f             	cmp    $0x2f,%eax
   43fa9:	77 30                	ja     43fdb <printer_vprintf+0x620>
   43fab:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43fb2:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43fb6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43fbd:	8b 00                	mov    (%rax),%eax
   43fbf:	89 c0                	mov    %eax,%eax
   43fc1:	48 01 d0             	add    %rdx,%rax
   43fc4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43fcb:	8b 12                	mov    (%rdx),%edx
   43fcd:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43fd0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43fd7:	89 0a                	mov    %ecx,(%rdx)
   43fd9:	eb 1a                	jmp    43ff5 <printer_vprintf+0x63a>
   43fdb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43fe2:	48 8b 40 08          	mov    0x8(%rax),%rax
   43fe6:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43fea:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43ff1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43ff5:	8b 00                	mov    (%rax),%eax
   43ff7:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   43ffd:	e9 67 03 00 00       	jmp    44369 <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
   44002:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   44006:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   4400a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44011:	8b 00                	mov    (%rax),%eax
   44013:	83 f8 2f             	cmp    $0x2f,%eax
   44016:	77 30                	ja     44048 <printer_vprintf+0x68d>
   44018:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4401f:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44023:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4402a:	8b 00                	mov    (%rax),%eax
   4402c:	89 c0                	mov    %eax,%eax
   4402e:	48 01 d0             	add    %rdx,%rax
   44031:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44038:	8b 12                	mov    (%rdx),%edx
   4403a:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4403d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44044:	89 0a                	mov    %ecx,(%rdx)
   44046:	eb 1a                	jmp    44062 <printer_vprintf+0x6a7>
   44048:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4404f:	48 8b 40 08          	mov    0x8(%rax),%rax
   44053:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44057:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4405e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44062:	8b 00                	mov    (%rax),%eax
   44064:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   44067:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   4406b:	eb 45                	jmp    440b2 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
   4406d:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   44071:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   44075:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4407c:	0f b6 00             	movzbl (%rax),%eax
   4407f:	84 c0                	test   %al,%al
   44081:	74 0c                	je     4408f <printer_vprintf+0x6d4>
   44083:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4408a:	0f b6 00             	movzbl (%rax),%eax
   4408d:	eb 05                	jmp    44094 <printer_vprintf+0x6d9>
   4408f:	b8 25 00 00 00       	mov    $0x25,%eax
   44094:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   44097:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   4409b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   440a2:	0f b6 00             	movzbl (%rax),%eax
   440a5:	84 c0                	test   %al,%al
   440a7:	75 08                	jne    440b1 <printer_vprintf+0x6f6>
                format--;
   440a9:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   440b0:	01 
            }
            break;
   440b1:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   440b2:	8b 45 ec             	mov    -0x14(%rbp),%eax
   440b5:	83 e0 20             	and    $0x20,%eax
   440b8:	85 c0                	test   %eax,%eax
   440ba:	74 1e                	je     440da <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   440bc:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   440c0:	48 83 c0 18          	add    $0x18,%rax
   440c4:	8b 55 e0             	mov    -0x20(%rbp),%edx
   440c7:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   440cb:	48 89 ce             	mov    %rcx,%rsi
   440ce:	48 89 c7             	mov    %rax,%rdi
   440d1:	e8 63 f8 ff ff       	call   43939 <fill_numbuf>
   440d6:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   440da:	48 c7 45 c0 06 52 04 	movq   $0x45206,-0x40(%rbp)
   440e1:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   440e2:	8b 45 ec             	mov    -0x14(%rbp),%eax
   440e5:	83 e0 20             	and    $0x20,%eax
   440e8:	85 c0                	test   %eax,%eax
   440ea:	74 48                	je     44134 <printer_vprintf+0x779>
   440ec:	8b 45 ec             	mov    -0x14(%rbp),%eax
   440ef:	83 e0 40             	and    $0x40,%eax
   440f2:	85 c0                	test   %eax,%eax
   440f4:	74 3e                	je     44134 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
   440f6:	8b 45 ec             	mov    -0x14(%rbp),%eax
   440f9:	25 80 00 00 00       	and    $0x80,%eax
   440fe:	85 c0                	test   %eax,%eax
   44100:	74 0a                	je     4410c <printer_vprintf+0x751>
                prefix = "-";
   44102:	48 c7 45 c0 07 52 04 	movq   $0x45207,-0x40(%rbp)
   44109:	00 
            if (flags & FLAG_NEGATIVE) {
   4410a:	eb 73                	jmp    4417f <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   4410c:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4410f:	83 e0 10             	and    $0x10,%eax
   44112:	85 c0                	test   %eax,%eax
   44114:	74 0a                	je     44120 <printer_vprintf+0x765>
                prefix = "+";
   44116:	48 c7 45 c0 09 52 04 	movq   $0x45209,-0x40(%rbp)
   4411d:	00 
            if (flags & FLAG_NEGATIVE) {
   4411e:	eb 5f                	jmp    4417f <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   44120:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44123:	83 e0 08             	and    $0x8,%eax
   44126:	85 c0                	test   %eax,%eax
   44128:	74 55                	je     4417f <printer_vprintf+0x7c4>
                prefix = " ";
   4412a:	48 c7 45 c0 0b 52 04 	movq   $0x4520b,-0x40(%rbp)
   44131:	00 
            if (flags & FLAG_NEGATIVE) {
   44132:	eb 4b                	jmp    4417f <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   44134:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44137:	83 e0 20             	and    $0x20,%eax
   4413a:	85 c0                	test   %eax,%eax
   4413c:	74 42                	je     44180 <printer_vprintf+0x7c5>
   4413e:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44141:	83 e0 01             	and    $0x1,%eax
   44144:	85 c0                	test   %eax,%eax
   44146:	74 38                	je     44180 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
   44148:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   4414c:	74 06                	je     44154 <printer_vprintf+0x799>
   4414e:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   44152:	75 2c                	jne    44180 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
   44154:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   44159:	75 0c                	jne    44167 <printer_vprintf+0x7ac>
   4415b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4415e:	25 00 01 00 00       	and    $0x100,%eax
   44163:	85 c0                	test   %eax,%eax
   44165:	74 19                	je     44180 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
   44167:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   4416b:	75 07                	jne    44174 <printer_vprintf+0x7b9>
   4416d:	b8 0d 52 04 00       	mov    $0x4520d,%eax
   44172:	eb 05                	jmp    44179 <printer_vprintf+0x7be>
   44174:	b8 10 52 04 00       	mov    $0x45210,%eax
   44179:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   4417d:	eb 01                	jmp    44180 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
   4417f:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   44180:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   44184:	78 24                	js     441aa <printer_vprintf+0x7ef>
   44186:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44189:	83 e0 20             	and    $0x20,%eax
   4418c:	85 c0                	test   %eax,%eax
   4418e:	75 1a                	jne    441aa <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
   44190:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44193:	48 63 d0             	movslq %eax,%rdx
   44196:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4419a:	48 89 d6             	mov    %rdx,%rsi
   4419d:	48 89 c7             	mov    %rax,%rdi
   441a0:	e8 ea f5 ff ff       	call   4378f <strnlen>
   441a5:	89 45 bc             	mov    %eax,-0x44(%rbp)
   441a8:	eb 0f                	jmp    441b9 <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
   441aa:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   441ae:	48 89 c7             	mov    %rax,%rdi
   441b1:	e8 a8 f5 ff ff       	call   4375e <strlen>
   441b6:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   441b9:	8b 45 ec             	mov    -0x14(%rbp),%eax
   441bc:	83 e0 20             	and    $0x20,%eax
   441bf:	85 c0                	test   %eax,%eax
   441c1:	74 20                	je     441e3 <printer_vprintf+0x828>
   441c3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   441c7:	78 1a                	js     441e3 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
   441c9:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   441cc:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   441cf:	7e 08                	jle    441d9 <printer_vprintf+0x81e>
   441d1:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   441d4:	2b 45 bc             	sub    -0x44(%rbp),%eax
   441d7:	eb 05                	jmp    441de <printer_vprintf+0x823>
   441d9:	b8 00 00 00 00       	mov    $0x0,%eax
   441de:	89 45 b8             	mov    %eax,-0x48(%rbp)
   441e1:	eb 5c                	jmp    4423f <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   441e3:	8b 45 ec             	mov    -0x14(%rbp),%eax
   441e6:	83 e0 20             	and    $0x20,%eax
   441e9:	85 c0                	test   %eax,%eax
   441eb:	74 4b                	je     44238 <printer_vprintf+0x87d>
   441ed:	8b 45 ec             	mov    -0x14(%rbp),%eax
   441f0:	83 e0 02             	and    $0x2,%eax
   441f3:	85 c0                	test   %eax,%eax
   441f5:	74 41                	je     44238 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
   441f7:	8b 45 ec             	mov    -0x14(%rbp),%eax
   441fa:	83 e0 04             	and    $0x4,%eax
   441fd:	85 c0                	test   %eax,%eax
   441ff:	75 37                	jne    44238 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
   44201:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44205:	48 89 c7             	mov    %rax,%rdi
   44208:	e8 51 f5 ff ff       	call   4375e <strlen>
   4420d:	89 c2                	mov    %eax,%edx
   4420f:	8b 45 bc             	mov    -0x44(%rbp),%eax
   44212:	01 d0                	add    %edx,%eax
   44214:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   44217:	7e 1f                	jle    44238 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
   44219:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4421c:	2b 45 bc             	sub    -0x44(%rbp),%eax
   4421f:	89 c3                	mov    %eax,%ebx
   44221:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44225:	48 89 c7             	mov    %rax,%rdi
   44228:	e8 31 f5 ff ff       	call   4375e <strlen>
   4422d:	89 c2                	mov    %eax,%edx
   4422f:	89 d8                	mov    %ebx,%eax
   44231:	29 d0                	sub    %edx,%eax
   44233:	89 45 b8             	mov    %eax,-0x48(%rbp)
   44236:	eb 07                	jmp    4423f <printer_vprintf+0x884>
        } else {
            zeros = 0;
   44238:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   4423f:	8b 55 bc             	mov    -0x44(%rbp),%edx
   44242:	8b 45 b8             	mov    -0x48(%rbp),%eax
   44245:	01 d0                	add    %edx,%eax
   44247:	48 63 d8             	movslq %eax,%rbx
   4424a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4424e:	48 89 c7             	mov    %rax,%rdi
   44251:	e8 08 f5 ff ff       	call   4375e <strlen>
   44256:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   4425a:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4425d:	29 d0                	sub    %edx,%eax
   4425f:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   44262:	eb 25                	jmp    44289 <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
   44264:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4426b:	48 8b 08             	mov    (%rax),%rcx
   4426e:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44274:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4427b:	be 20 00 00 00       	mov    $0x20,%esi
   44280:	48 89 c7             	mov    %rax,%rdi
   44283:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   44285:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   44289:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4428c:	83 e0 04             	and    $0x4,%eax
   4428f:	85 c0                	test   %eax,%eax
   44291:	75 36                	jne    442c9 <printer_vprintf+0x90e>
   44293:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   44297:	7f cb                	jg     44264 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
   44299:	eb 2e                	jmp    442c9 <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
   4429b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   442a2:	4c 8b 00             	mov    (%rax),%r8
   442a5:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   442a9:	0f b6 00             	movzbl (%rax),%eax
   442ac:	0f b6 c8             	movzbl %al,%ecx
   442af:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   442b5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   442bc:	89 ce                	mov    %ecx,%esi
   442be:	48 89 c7             	mov    %rax,%rdi
   442c1:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   442c4:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   442c9:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   442cd:	0f b6 00             	movzbl (%rax),%eax
   442d0:	84 c0                	test   %al,%al
   442d2:	75 c7                	jne    4429b <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
   442d4:	eb 25                	jmp    442fb <printer_vprintf+0x940>
            p->putc(p, '0', color);
   442d6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   442dd:	48 8b 08             	mov    (%rax),%rcx
   442e0:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   442e6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   442ed:	be 30 00 00 00       	mov    $0x30,%esi
   442f2:	48 89 c7             	mov    %rax,%rdi
   442f5:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   442f7:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   442fb:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   442ff:	7f d5                	jg     442d6 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
   44301:	eb 32                	jmp    44335 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
   44303:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4430a:	4c 8b 00             	mov    (%rax),%r8
   4430d:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44311:	0f b6 00             	movzbl (%rax),%eax
   44314:	0f b6 c8             	movzbl %al,%ecx
   44317:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   4431d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44324:	89 ce                	mov    %ecx,%esi
   44326:	48 89 c7             	mov    %rax,%rdi
   44329:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   4432c:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   44331:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   44335:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   44339:	7f c8                	jg     44303 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
   4433b:	eb 25                	jmp    44362 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
   4433d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44344:	48 8b 08             	mov    (%rax),%rcx
   44347:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   4434d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44354:	be 20 00 00 00       	mov    $0x20,%esi
   44359:	48 89 c7             	mov    %rax,%rdi
   4435c:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   4435e:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   44362:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   44366:	7f d5                	jg     4433d <printer_vprintf+0x982>
        }
    done: ;
   44368:	90                   	nop
    for (; *format; ++format) {
   44369:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44370:	01 
   44371:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44378:	0f b6 00             	movzbl (%rax),%eax
   4437b:	84 c0                	test   %al,%al
   4437d:	0f 85 64 f6 ff ff    	jne    439e7 <printer_vprintf+0x2c>
    }
}
   44383:	90                   	nop
   44384:	90                   	nop
   44385:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   44389:	c9                   	leave  
   4438a:	c3                   	ret    

000000000004438b <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   4438b:	55                   	push   %rbp
   4438c:	48 89 e5             	mov    %rsp,%rbp
   4438f:	48 83 ec 20          	sub    $0x20,%rsp
   44393:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44397:	89 f0                	mov    %esi,%eax
   44399:	89 55 e0             	mov    %edx,-0x20(%rbp)
   4439c:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   4439f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   443a3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   443a7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   443ab:	48 8b 40 08          	mov    0x8(%rax),%rax
   443af:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
   443b4:	48 39 d0             	cmp    %rdx,%rax
   443b7:	72 0c                	jb     443c5 <console_putc+0x3a>
        cp->cursor = console;
   443b9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   443bd:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
   443c4:	00 
    }
    if (c == '\n') {
   443c5:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   443c9:	75 78                	jne    44443 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
   443cb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   443cf:	48 8b 40 08          	mov    0x8(%rax),%rax
   443d3:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   443d9:	48 d1 f8             	sar    %rax
   443dc:	48 89 c1             	mov    %rax,%rcx
   443df:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   443e6:	66 66 66 
   443e9:	48 89 c8             	mov    %rcx,%rax
   443ec:	48 f7 ea             	imul   %rdx
   443ef:	48 c1 fa 05          	sar    $0x5,%rdx
   443f3:	48 89 c8             	mov    %rcx,%rax
   443f6:	48 c1 f8 3f          	sar    $0x3f,%rax
   443fa:	48 29 c2             	sub    %rax,%rdx
   443fd:	48 89 d0             	mov    %rdx,%rax
   44400:	48 c1 e0 02          	shl    $0x2,%rax
   44404:	48 01 d0             	add    %rdx,%rax
   44407:	48 c1 e0 04          	shl    $0x4,%rax
   4440b:	48 29 c1             	sub    %rax,%rcx
   4440e:	48 89 ca             	mov    %rcx,%rdx
   44411:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   44414:	eb 25                	jmp    4443b <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
   44416:	8b 45 e0             	mov    -0x20(%rbp),%eax
   44419:	83 c8 20             	or     $0x20,%eax
   4441c:	89 c6                	mov    %eax,%esi
   4441e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44422:	48 8b 40 08          	mov    0x8(%rax),%rax
   44426:	48 8d 48 02          	lea    0x2(%rax),%rcx
   4442a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4442e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44432:	89 f2                	mov    %esi,%edx
   44434:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   44437:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4443b:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   4443f:	75 d5                	jne    44416 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   44441:	eb 24                	jmp    44467 <console_putc+0xdc>
        *cp->cursor++ = c | color;
   44443:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
   44447:	8b 55 e0             	mov    -0x20(%rbp),%edx
   4444a:	09 d0                	or     %edx,%eax
   4444c:	89 c6                	mov    %eax,%esi
   4444e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44452:	48 8b 40 08          	mov    0x8(%rax),%rax
   44456:	48 8d 48 02          	lea    0x2(%rax),%rcx
   4445a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4445e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44462:	89 f2                	mov    %esi,%edx
   44464:	66 89 10             	mov    %dx,(%rax)
}
   44467:	90                   	nop
   44468:	c9                   	leave  
   44469:	c3                   	ret    

000000000004446a <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   4446a:	55                   	push   %rbp
   4446b:	48 89 e5             	mov    %rsp,%rbp
   4446e:	48 83 ec 30          	sub    $0x30,%rsp
   44472:	89 7d ec             	mov    %edi,-0x14(%rbp)
   44475:	89 75 e8             	mov    %esi,-0x18(%rbp)
   44478:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   4447c:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   44480:	48 c7 45 f0 8b 43 04 	movq   $0x4438b,-0x10(%rbp)
   44487:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   44488:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   4448c:	78 09                	js     44497 <console_vprintf+0x2d>
   4448e:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   44495:	7e 07                	jle    4449e <console_vprintf+0x34>
        cpos = 0;
   44497:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   4449e:	8b 45 ec             	mov    -0x14(%rbp),%eax
   444a1:	48 98                	cltq   
   444a3:	48 01 c0             	add    %rax,%rax
   444a6:	48 05 00 80 0b 00    	add    $0xb8000,%rax
   444ac:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   444b0:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   444b4:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   444b8:	8b 75 e8             	mov    -0x18(%rbp),%esi
   444bb:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   444bf:	48 89 c7             	mov    %rax,%rdi
   444c2:	e8 f4 f4 ff ff       	call   439bb <printer_vprintf>
    return cp.cursor - console;
   444c7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   444cb:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   444d1:	48 d1 f8             	sar    %rax
}
   444d4:	c9                   	leave  
   444d5:	c3                   	ret    

00000000000444d6 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   444d6:	55                   	push   %rbp
   444d7:	48 89 e5             	mov    %rsp,%rbp
   444da:	48 83 ec 60          	sub    $0x60,%rsp
   444de:	89 7d ac             	mov    %edi,-0x54(%rbp)
   444e1:	89 75 a8             	mov    %esi,-0x58(%rbp)
   444e4:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   444e8:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   444ec:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   444f0:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   444f4:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   444fb:	48 8d 45 10          	lea    0x10(%rbp),%rax
   444ff:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   44503:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44507:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   4450b:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   4450f:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   44513:	8b 75 a8             	mov    -0x58(%rbp),%esi
   44516:	8b 45 ac             	mov    -0x54(%rbp),%eax
   44519:	89 c7                	mov    %eax,%edi
   4451b:	e8 4a ff ff ff       	call   4446a <console_vprintf>
   44520:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   44523:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   44526:	c9                   	leave  
   44527:	c3                   	ret    

0000000000044528 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   44528:	55                   	push   %rbp
   44529:	48 89 e5             	mov    %rsp,%rbp
   4452c:	48 83 ec 20          	sub    $0x20,%rsp
   44530:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44534:	89 f0                	mov    %esi,%eax
   44536:	89 55 e0             	mov    %edx,-0x20(%rbp)
   44539:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   4453c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44540:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   44544:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44548:	48 8b 50 08          	mov    0x8(%rax),%rdx
   4454c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44550:	48 8b 40 10          	mov    0x10(%rax),%rax
   44554:	48 39 c2             	cmp    %rax,%rdx
   44557:	73 1a                	jae    44573 <string_putc+0x4b>
        *sp->s++ = c;
   44559:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4455d:	48 8b 40 08          	mov    0x8(%rax),%rax
   44561:	48 8d 48 01          	lea    0x1(%rax),%rcx
   44565:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   44569:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4456d:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   44571:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   44573:	90                   	nop
   44574:	c9                   	leave  
   44575:	c3                   	ret    

0000000000044576 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   44576:	55                   	push   %rbp
   44577:	48 89 e5             	mov    %rsp,%rbp
   4457a:	48 83 ec 40          	sub    $0x40,%rsp
   4457e:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   44582:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   44586:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   4458a:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   4458e:	48 c7 45 e8 28 45 04 	movq   $0x44528,-0x18(%rbp)
   44595:	00 
    sp.s = s;
   44596:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4459a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   4459e:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   445a3:	74 33                	je     445d8 <vsnprintf+0x62>
        sp.end = s + size - 1;
   445a5:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   445a9:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   445ad:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   445b1:	48 01 d0             	add    %rdx,%rax
   445b4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   445b8:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   445bc:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   445c0:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   445c4:	be 00 00 00 00       	mov    $0x0,%esi
   445c9:	48 89 c7             	mov    %rax,%rdi
   445cc:	e8 ea f3 ff ff       	call   439bb <printer_vprintf>
        *sp.s = 0;
   445d1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   445d5:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   445d8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   445dc:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   445e0:	c9                   	leave  
   445e1:	c3                   	ret    

00000000000445e2 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   445e2:	55                   	push   %rbp
   445e3:	48 89 e5             	mov    %rsp,%rbp
   445e6:	48 83 ec 70          	sub    $0x70,%rsp
   445ea:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   445ee:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   445f2:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   445f6:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   445fa:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   445fe:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44602:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   44609:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4460d:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   44611:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44615:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   44619:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   4461d:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   44621:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   44625:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44629:	48 89 c7             	mov    %rax,%rdi
   4462c:	e8 45 ff ff ff       	call   44576 <vsnprintf>
   44631:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   44634:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   44637:	c9                   	leave  
   44638:	c3                   	ret    

0000000000044639 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   44639:	55                   	push   %rbp
   4463a:	48 89 e5             	mov    %rsp,%rbp
   4463d:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44641:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   44648:	eb 13                	jmp    4465d <console_clear+0x24>
        console[i] = ' ' | 0x0700;
   4464a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4464d:	48 98                	cltq   
   4464f:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
   44656:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44659:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4465d:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   44664:	7e e4                	jle    4464a <console_clear+0x11>
    }
    cursorpos = 0;
   44666:	c7 05 8c 49 07 00 00 	movl   $0x0,0x7498c(%rip)        # b8ffc <cursorpos>
   4466d:	00 00 00 
}
   44670:	90                   	nop
   44671:	c9                   	leave  
   44672:	c3                   	ret    
