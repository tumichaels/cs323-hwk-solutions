
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
   400be:	e8 5b 05 00 00       	call   4061e <exception>

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
   40173:	e8 6d 12 00 00       	call   413e5 <hardware_init>
    pageinfo_init();
   40178:	e8 cc 08 00 00       	call   40a49 <pageinfo_init>
    console_clear();
   4017d:	e8 14 3c 00 00       	call   43d96 <console_clear>
    timer_init(HZ);
   40182:	bf 64 00 00 00       	mov    $0x64,%edi
   40187:	e8 45 17 00 00       	call   418d1 <timer_init>


    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   4018c:	ba 00 0e 00 00       	mov    $0xe00,%edx
   40191:	be 00 00 00 00       	mov    $0x0,%esi
   40196:	bf 20 10 05 00       	mov    $0x51020,%edi
   4019b:	e8 dc 2c 00 00       	call   42e7c <memset>
    for (pid_t i = 0; i < NPROC; i++) {
   401a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   401a7:	eb 44                	jmp    401ed <kernel+0x86>
        processes[i].p_pid = i;
   401a9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401ac:	48 63 d0             	movslq %eax,%rdx
   401af:	48 89 d0             	mov    %rdx,%rax
   401b2:	48 c1 e0 03          	shl    $0x3,%rax
   401b6:	48 29 d0             	sub    %rdx,%rax
   401b9:	48 c1 e0 05          	shl    $0x5,%rax
   401bd:	48 8d 90 20 10 05 00 	lea    0x51020(%rax),%rdx
   401c4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401c7:	89 02                	mov    %eax,(%rdx)
        processes[i].p_state = P_FREE;
   401c9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401cc:	48 63 d0             	movslq %eax,%rdx
   401cf:	48 89 d0             	mov    %rdx,%rax
   401d2:	48 c1 e0 03          	shl    $0x3,%rax
   401d6:	48 29 d0             	sub    %rdx,%rax
   401d9:	48 c1 e0 05          	shl    $0x5,%rax
   401dd:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   401e3:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
    for (pid_t i = 0; i < NPROC; i++) {
   401e9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   401ed:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   401f1:	7e b6                	jle    401a9 <kernel+0x42>
    }

    if (command && strcmp(command, "fork") == 0) {
   401f3:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   401f8:	74 29                	je     40223 <kernel+0xbc>
   401fa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   401fe:	be e0 3d 04 00       	mov    $0x43de0,%esi
   40203:	48 89 c7             	mov    %rax,%rdi
   40206:	e8 6a 2d 00 00       	call   42f75 <strcmp>
   4020b:	85 c0                	test   %eax,%eax
   4020d:	75 14                	jne    40223 <kernel+0xbc>
        process_setup(1, 4);
   4020f:	be 04 00 00 00       	mov    $0x4,%esi
   40214:	bf 01 00 00 00       	mov    $0x1,%edi
   40219:	e8 d1 00 00 00       	call   402ef <process_setup>
   4021e:	e9 c2 00 00 00       	jmp    402e5 <kernel+0x17e>
    } else if (command && strcmp(command, "forkexit") == 0) {
   40223:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40228:	74 29                	je     40253 <kernel+0xec>
   4022a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4022e:	be e5 3d 04 00       	mov    $0x43de5,%esi
   40233:	48 89 c7             	mov    %rax,%rdi
   40236:	e8 3a 2d 00 00       	call   42f75 <strcmp>
   4023b:	85 c0                	test   %eax,%eax
   4023d:	75 14                	jne    40253 <kernel+0xec>
        process_setup(1, 5);
   4023f:	be 05 00 00 00       	mov    $0x5,%esi
   40244:	bf 01 00 00 00       	mov    $0x1,%edi
   40249:	e8 a1 00 00 00       	call   402ef <process_setup>
   4024e:	e9 92 00 00 00       	jmp    402e5 <kernel+0x17e>
    } else if (command && strcmp(command, "test") == 0) {
   40253:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40258:	74 26                	je     40280 <kernel+0x119>
   4025a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4025e:	be ee 3d 04 00       	mov    $0x43dee,%esi
   40263:	48 89 c7             	mov    %rax,%rdi
   40266:	e8 0a 2d 00 00       	call   42f75 <strcmp>
   4026b:	85 c0                	test   %eax,%eax
   4026d:	75 11                	jne    40280 <kernel+0x119>
        process_setup(1, 6);
   4026f:	be 06 00 00 00       	mov    $0x6,%esi
   40274:	bf 01 00 00 00       	mov    $0x1,%edi
   40279:	e8 71 00 00 00       	call   402ef <process_setup>
   4027e:	eb 65                	jmp    402e5 <kernel+0x17e>
    } else if (command && strcmp(command, "test2") == 0) {
   40280:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40285:	74 39                	je     402c0 <kernel+0x159>
   40287:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4028b:	be f3 3d 04 00       	mov    $0x43df3,%esi
   40290:	48 89 c7             	mov    %rax,%rdi
   40293:	e8 dd 2c 00 00       	call   42f75 <strcmp>
   40298:	85 c0                	test   %eax,%eax
   4029a:	75 24                	jne    402c0 <kernel+0x159>
        for (pid_t i = 1; i <= 2; ++i) {
   4029c:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   402a3:	eb 13                	jmp    402b8 <kernel+0x151>
            process_setup(i, 6);
   402a5:	8b 45 f8             	mov    -0x8(%rbp),%eax
   402a8:	be 06 00 00 00       	mov    $0x6,%esi
   402ad:	89 c7                	mov    %eax,%edi
   402af:	e8 3b 00 00 00       	call   402ef <process_setup>
        for (pid_t i = 1; i <= 2; ++i) {
   402b4:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   402b8:	83 7d f8 02          	cmpl   $0x2,-0x8(%rbp)
   402bc:	7e e7                	jle    402a5 <kernel+0x13e>
   402be:	eb 25                	jmp    402e5 <kernel+0x17e>
        }
    } else {
        for (pid_t i = 1; i <= 4; ++i) {
   402c0:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%rbp)
   402c7:	eb 16                	jmp    402df <kernel+0x178>
            process_setup(i, i - 1);
   402c9:	8b 45 f4             	mov    -0xc(%rbp),%eax
   402cc:	8d 50 ff             	lea    -0x1(%rax),%edx
   402cf:	8b 45 f4             	mov    -0xc(%rbp),%eax
   402d2:	89 d6                	mov    %edx,%esi
   402d4:	89 c7                	mov    %eax,%edi
   402d6:	e8 14 00 00 00       	call   402ef <process_setup>
        for (pid_t i = 1; i <= 4; ++i) {
   402db:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   402df:	83 7d f4 04          	cmpl   $0x4,-0xc(%rbp)
   402e3:	7e e4                	jle    402c9 <kernel+0x162>
        }
    }


    // Switch to the first process using run()
    run(&processes[1]);
   402e5:	bf 00 11 05 00       	mov    $0x51100,%edi
   402ea:	e8 fd 06 00 00       	call   409ec <run>

00000000000402ef <process_setup>:
// process_setup(pid, program_number)
//    Load application program `program_number` as process number `pid`.
//    This loads the application's code and data into memory, sets its
//    %rip and %rsp, gives it a stack page, and marks it as runnable.

void process_setup(pid_t pid, int program_number) {
   402ef:	55                   	push   %rbp
   402f0:	48 89 e5             	mov    %rsp,%rbp
   402f3:	48 83 ec 20          	sub    $0x20,%rsp
   402f7:	89 7d ec             	mov    %edi,-0x14(%rbp)
   402fa:	89 75 e8             	mov    %esi,-0x18(%rbp)
    process_init(&processes[pid], 0);
   402fd:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40300:	48 63 d0             	movslq %eax,%rdx
   40303:	48 89 d0             	mov    %rdx,%rax
   40306:	48 c1 e0 03          	shl    $0x3,%rax
   4030a:	48 29 d0             	sub    %rdx,%rax
   4030d:	48 c1 e0 05          	shl    $0x5,%rax
   40311:	48 05 20 10 05 00    	add    $0x51020,%rax
   40317:	be 00 00 00 00       	mov    $0x0,%esi
   4031c:	48 89 c7             	mov    %rax,%rdi
   4031f:	e8 3e 18 00 00       	call   41b62 <process_init>
    processes[pid].p_pagetable = kernel_pagetable;
   40324:	48 8b 0d d5 3c 01 00 	mov    0x13cd5(%rip),%rcx        # 54000 <kernel_pagetable>
   4032b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4032e:	48 63 d0             	movslq %eax,%rdx
   40331:	48 89 d0             	mov    %rdx,%rax
   40334:	48 c1 e0 03          	shl    $0x3,%rax
   40338:	48 29 d0             	sub    %rdx,%rax
   4033b:	48 c1 e0 05          	shl    $0x5,%rax
   4033f:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   40345:	48 89 08             	mov    %rcx,(%rax)
    ++pageinfo[PAGENUMBER(kernel_pagetable)].refcount; //increase refcount since kernel_pagetable was used
   40348:	48 8b 05 b1 3c 01 00 	mov    0x13cb1(%rip),%rax        # 54000 <kernel_pagetable>
   4034f:	48 c1 e8 0c          	shr    $0xc,%rax
   40353:	89 c2                	mov    %eax,%edx
   40355:	48 63 c2             	movslq %edx,%rax
   40358:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   4035f:	00 
   40360:	83 c0 01             	add    $0x1,%eax
   40363:	89 c1                	mov    %eax,%ecx
   40365:	48 63 c2             	movslq %edx,%rax
   40368:	88 8c 00 41 1e 05 00 	mov    %cl,0x51e41(%rax,%rax,1)

    int r = program_load(&processes[pid], program_number, NULL);
   4036f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40372:	48 63 d0             	movslq %eax,%rdx
   40375:	48 89 d0             	mov    %rdx,%rax
   40378:	48 c1 e0 03          	shl    $0x3,%rax
   4037c:	48 29 d0             	sub    %rdx,%rax
   4037f:	48 c1 e0 05          	shl    $0x5,%rax
   40383:	48 8d 88 20 10 05 00 	lea    0x51020(%rax),%rcx
   4038a:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4038d:	ba 00 00 00 00       	mov    $0x0,%edx
   40392:	89 c6                	mov    %eax,%esi
   40394:	48 89 cf             	mov    %rcx,%rdi
   40397:	e8 45 27 00 00       	call   42ae1 <program_load>
   4039c:	89 45 fc             	mov    %eax,-0x4(%rbp)
    assert(r >= 0);
   4039f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   403a3:	79 14                	jns    403b9 <process_setup+0xca>
   403a5:	ba f9 3d 04 00       	mov    $0x43df9,%edx
   403aa:	be 83 00 00 00       	mov    $0x83,%esi
   403af:	bf 00 3e 04 00       	mov    $0x43e00,%edi
   403b4:	e8 77 1f 00 00       	call   42330 <assert_fail>

    processes[pid].p_registers.reg_rsp = PROC_START_ADDR + PROC_SIZE * pid;
   403b9:	8b 45 ec             	mov    -0x14(%rbp),%eax
   403bc:	83 c0 04             	add    $0x4,%eax
   403bf:	c1 e0 12             	shl    $0x12,%eax
   403c2:	48 63 c8             	movslq %eax,%rcx
   403c5:	8b 45 ec             	mov    -0x14(%rbp),%eax
   403c8:	48 63 d0             	movslq %eax,%rdx
   403cb:	48 89 d0             	mov    %rdx,%rax
   403ce:	48 c1 e0 03          	shl    $0x3,%rax
   403d2:	48 29 d0             	sub    %rdx,%rax
   403d5:	48 c1 e0 05          	shl    $0x5,%rax
   403d9:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   403df:	48 89 08             	mov    %rcx,(%rax)
    uintptr_t stack_page = processes[pid].p_registers.reg_rsp - PAGESIZE;
   403e2:	8b 45 ec             	mov    -0x14(%rbp),%eax
   403e5:	48 63 d0             	movslq %eax,%rdx
   403e8:	48 89 d0             	mov    %rdx,%rax
   403eb:	48 c1 e0 03          	shl    $0x3,%rax
   403ef:	48 29 d0             	sub    %rdx,%rax
   403f2:	48 c1 e0 05          	shl    $0x5,%rax
   403f6:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   403fc:	48 8b 00             	mov    (%rax),%rax
   403ff:	48 2d 00 10 00 00    	sub    $0x1000,%rax
   40405:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assign_physical_page(stack_page, pid);
   40409:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4040c:	0f be d0             	movsbl %al,%edx
   4040f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40413:	89 d6                	mov    %edx,%esi
   40415:	48 89 c7             	mov    %rax,%rdi
   40418:	e8 5b 00 00 00       	call   40478 <assign_physical_page>
    virtual_memory_map(processes[pid].p_pagetable, stack_page, stack_page,
   4041d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40420:	48 63 d0             	movslq %eax,%rdx
   40423:	48 89 d0             	mov    %rdx,%rax
   40426:	48 c1 e0 03          	shl    $0x3,%rax
   4042a:	48 29 d0             	sub    %rdx,%rax
   4042d:	48 c1 e0 05          	shl    $0x5,%rax
   40431:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   40437:	48 8b 00             	mov    (%rax),%rax
   4043a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4043e:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   40442:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40448:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4044d:	48 89 c7             	mov    %rax,%rdi
   40450:	e8 da 21 00 00       	call   4262f <virtual_memory_map>
                       PAGESIZE, PTE_P | PTE_W | PTE_U);
    processes[pid].p_state = P_RUNNABLE;
   40455:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40458:	48 63 d0             	movslq %eax,%rdx
   4045b:	48 89 d0             	mov    %rdx,%rax
   4045e:	48 c1 e0 03          	shl    $0x3,%rax
   40462:	48 29 d0             	sub    %rdx,%rax
   40465:	48 c1 e0 05          	shl    $0x5,%rax
   40469:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   4046f:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
}
   40475:	90                   	nop
   40476:	c9                   	leave  
   40477:	c3                   	ret    

0000000000040478 <assign_physical_page>:
// assign_physical_page(addr, owner)
//    Allocates the page with physical address `addr` to the given owner.
//    Fails if physical page `addr` was already allocated. Returns 0 on
//    success and -1 on failure. Used by the program loader.

int assign_physical_page(uintptr_t addr, int8_t owner) {
   40478:	55                   	push   %rbp
   40479:	48 89 e5             	mov    %rsp,%rbp
   4047c:	48 83 ec 10          	sub    $0x10,%rsp
   40480:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   40484:	89 f0                	mov    %esi,%eax
   40486:	88 45 f4             	mov    %al,-0xc(%rbp)
    if ((addr & 0xFFF) != 0
   40489:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4048d:	25 ff 0f 00 00       	and    $0xfff,%eax
   40492:	48 85 c0             	test   %rax,%rax
   40495:	75 20                	jne    404b7 <assign_physical_page+0x3f>
        || addr >= MEMSIZE_PHYSICAL
   40497:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   4049e:	00 
   4049f:	77 16                	ja     404b7 <assign_physical_page+0x3f>
        || pageinfo[PAGENUMBER(addr)].refcount != 0) {
   404a1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   404a5:	48 c1 e8 0c          	shr    $0xc,%rax
   404a9:	48 98                	cltq   
   404ab:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   404b2:	00 
   404b3:	84 c0                	test   %al,%al
   404b5:	74 07                	je     404be <assign_physical_page+0x46>
        return -1;
   404b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   404bc:	eb 2c                	jmp    404ea <assign_physical_page+0x72>
    } else {
        pageinfo[PAGENUMBER(addr)].refcount = 1;
   404be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   404c2:	48 c1 e8 0c          	shr    $0xc,%rax
   404c6:	48 98                	cltq   
   404c8:	c6 84 00 41 1e 05 00 	movb   $0x1,0x51e41(%rax,%rax,1)
   404cf:	01 
        pageinfo[PAGENUMBER(addr)].owner = owner;
   404d0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   404d4:	48 c1 e8 0c          	shr    $0xc,%rax
   404d8:	48 98                	cltq   
   404da:	0f b6 55 f4          	movzbl -0xc(%rbp),%edx
   404de:	88 94 00 40 1e 05 00 	mov    %dl,0x51e40(%rax,%rax,1)
        return 0;
   404e5:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   404ea:	c9                   	leave  
   404eb:	c3                   	ret    

00000000000404ec <syscall_mapping>:

void syscall_mapping(proc* p){
   404ec:	55                   	push   %rbp
   404ed:	48 89 e5             	mov    %rsp,%rbp
   404f0:	48 83 ec 70          	sub    $0x70,%rsp
   404f4:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)

    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
   404f8:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   404fc:	48 8b 40 38          	mov    0x38(%rax),%rax
   40500:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t ptr = p->p_registers.reg_rsi;
   40504:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40508:	48 8b 40 30          	mov    0x30(%rax),%rax
   4050c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    //convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);
   40510:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40514:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   4051b:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4051f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40523:	48 89 ce             	mov    %rcx,%rsi
   40526:	48 89 c7             	mov    %rax,%rdi
   40529:	e8 bc 24 00 00       	call   429ea <virtual_memory_lookup>

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
   4052e:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40531:	48 98                	cltq   
   40533:	83 e0 06             	and    $0x6,%eax
   40536:	48 83 f8 06          	cmp    $0x6,%rax
   4053a:	75 73                	jne    405af <syscall_mapping+0xc3>
	return;
    uintptr_t endaddr = map.pa + sizeof(vamapping) - 1;
   4053c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40540:	48 83 c0 17          	add    $0x17,%rax
   40544:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    // check for write access for end address
    vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
   40548:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4054c:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40553:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   40557:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   4055b:	48 89 ce             	mov    %rcx,%rsi
   4055e:	48 89 c7             	mov    %rax,%rdi
   40561:	e8 84 24 00 00       	call   429ea <virtual_memory_lookup>
    if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
   40566:	8b 45 c8             	mov    -0x38(%rbp),%eax
   40569:	48 98                	cltq   
   4056b:	83 e0 03             	and    $0x3,%eax
   4056e:	48 83 f8 03          	cmp    $0x3,%rax
   40572:	75 3e                	jne    405b2 <syscall_mapping+0xc6>
	return;
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
   40574:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40578:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   4057f:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40583:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40587:	48 89 ce             	mov    %rcx,%rsi
   4058a:	48 89 c7             	mov    %rax,%rdi
   4058d:	e8 58 24 00 00       	call   429ea <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   40592:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40596:	48 89 c1             	mov    %rax,%rcx
   40599:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   4059d:	ba 18 00 00 00       	mov    $0x18,%edx
   405a2:	48 89 c6             	mov    %rax,%rsi
   405a5:	48 89 cf             	mov    %rcx,%rdi
   405a8:	e8 d1 27 00 00       	call   42d7e <memcpy>
   405ad:	eb 04                	jmp    405b3 <syscall_mapping+0xc7>
	return;
   405af:	90                   	nop
   405b0:	eb 01                	jmp    405b3 <syscall_mapping+0xc7>
	return;
   405b2:	90                   	nop
}
   405b3:	c9                   	leave  
   405b4:	c3                   	ret    

00000000000405b5 <syscall_mem_tog>:

void syscall_mem_tog(proc* process){
   405b5:	55                   	push   %rbp
   405b6:	48 89 e5             	mov    %rsp,%rbp
   405b9:	48 83 ec 18          	sub    $0x18,%rsp
   405bd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)

    pid_t p = process->p_registers.reg_rdi;
   405c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   405c5:	48 8b 40 38          	mov    0x38(%rax),%rax
   405c9:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(p == 0) {
   405cc:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   405d0:	75 14                	jne    405e6 <syscall_mem_tog+0x31>
        disp_global = !disp_global;
   405d2:	0f b6 05 27 4a 00 00 	movzbl 0x4a27(%rip),%eax        # 45000 <disp_global>
   405d9:	84 c0                	test   %al,%al
   405db:	0f 94 c0             	sete   %al
   405de:	88 05 1c 4a 00 00    	mov    %al,0x4a1c(%rip)        # 45000 <disp_global>
   405e4:	eb 36                	jmp    4061c <syscall_mem_tog+0x67>
    }
    else {
        if(p < 0 || p > NPROC || p != process->p_pid)
   405e6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   405ea:	78 2f                	js     4061b <syscall_mem_tog+0x66>
   405ec:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   405f0:	7f 29                	jg     4061b <syscall_mem_tog+0x66>
   405f2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   405f6:	8b 00                	mov    (%rax),%eax
   405f8:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   405fb:	75 1e                	jne    4061b <syscall_mem_tog+0x66>
            return;
        process->display_status = !(process->display_status);
   405fd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40601:	0f b6 80 d8 00 00 00 	movzbl 0xd8(%rax),%eax
   40608:	84 c0                	test   %al,%al
   4060a:	0f 94 c0             	sete   %al
   4060d:	89 c2                	mov    %eax,%edx
   4060f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40613:	88 90 d8 00 00 00    	mov    %dl,0xd8(%rax)
   40619:	eb 01                	jmp    4061c <syscall_mem_tog+0x67>
            return;
   4061b:	90                   	nop
    }
}
   4061c:	c9                   	leave  
   4061d:	c3                   	ret    

000000000004061e <exception>:
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_64_registers* reg) {
   4061e:	55                   	push   %rbp
   4061f:	48 89 e5             	mov    %rsp,%rbp
   40622:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
   40629:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   40630:	48 8b 05 c9 09 01 00 	mov    0x109c9(%rip),%rax        # 51000 <current>
   40637:	48 8b 95 08 ff ff ff 	mov    -0xf8(%rbp),%rdx
   4063e:	48 83 c0 08          	add    $0x8,%rax
   40642:	48 89 d6             	mov    %rdx,%rsi
   40645:	ba 18 00 00 00       	mov    $0x18,%edx
   4064a:	48 89 c7             	mov    %rax,%rdi
   4064d:	48 89 d1             	mov    %rdx,%rcx
   40650:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   40653:	48 8b 05 a6 39 01 00 	mov    0x139a6(%rip),%rax        # 54000 <kernel_pagetable>
   4065a:	48 89 c7             	mov    %rax,%rdi
   4065d:	e8 9c 1e 00 00       	call   424fe <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   40662:	8b 05 94 89 07 00    	mov    0x78994(%rip),%eax        # b8ffc <cursorpos>
   40668:	89 c7                	mov    %eax,%edi
   4066a:	e8 bd 15 00 00       	call   41c2c <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT && reg->reg_intno != INT_GPF) // no error due to pagefault or general fault
   4066f:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40676:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   4067d:	48 83 f8 0e          	cmp    $0xe,%rax
   40681:	74 14                	je     40697 <exception+0x79>
   40683:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   4068a:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40691:	48 83 f8 0d          	cmp    $0xd,%rax
   40695:	75 16                	jne    406ad <exception+0x8f>
            || (reg->reg_err & PFERR_USER)) // pagefault error in user mode 
   40697:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   4069e:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   406a5:	83 e0 04             	and    $0x4,%eax
   406a8:	48 85 c0             	test   %rax,%rax
   406ab:	74 1a                	je     406c7 <exception+0xa9>
    {
        check_virtual_memory();
   406ad:	e8 2e 07 00 00       	call   40de0 <check_virtual_memory>
        if(disp_global){
   406b2:	0f b6 05 47 49 00 00 	movzbl 0x4947(%rip),%eax        # 45000 <disp_global>
   406b9:	84 c0                	test   %al,%al
   406bb:	74 0a                	je     406c7 <exception+0xa9>
            memshow_physical();
   406bd:	e8 96 08 00 00       	call   40f58 <memshow_physical>
            memshow_virtual_animate();
   406c2:	e8 c0 0b 00 00       	call   41287 <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   406c7:	e8 43 1a 00 00       	call   4210f <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   406cc:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   406d3:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   406da:	48 83 e8 0e          	sub    $0xe,%rax
   406de:	48 83 f8 2a          	cmp    $0x2a,%rax
   406e2:	0f 87 55 02 00 00    	ja     4093d <exception+0x31f>
   406e8:	48 8b 04 c5 a0 3e 04 	mov    0x43ea0(,%rax,8),%rax
   406ef:	00 
   406f0:	ff e0                	jmp    *%rax

    case INT_SYS_PANIC:
	    // rdi stores pointer for msg string
	    {
		char msg[160];
		uintptr_t addr = current->p_registers.reg_rdi;
   406f2:	48 8b 05 07 09 01 00 	mov    0x10907(%rip),%rax        # 51000 <current>
   406f9:	48 8b 40 38          	mov    0x38(%rax),%rax
   406fd:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
		if((void *)addr == NULL)
   40701:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40706:	75 0f                	jne    40717 <exception+0xf9>
		    panic(NULL);
   40708:	bf 00 00 00 00       	mov    $0x0,%edi
   4070d:	b8 00 00 00 00       	mov    $0x0,%eax
   40712:	e8 39 1b 00 00       	call   42250 <panic>
		vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   40717:	48 8b 05 e2 08 01 00 	mov    0x108e2(%rip),%rax        # 51000 <current>
   4071e:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40725:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   40729:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   4072d:	48 89 ce             	mov    %rcx,%rsi
   40730:	48 89 c7             	mov    %rax,%rdi
   40733:	e8 b2 22 00 00       	call   429ea <virtual_memory_lookup>
		memcpy(msg, (void *)map.pa, 160);
   40738:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4073c:	48 89 c1             	mov    %rax,%rcx
   4073f:	48 8d 85 10 ff ff ff 	lea    -0xf0(%rbp),%rax
   40746:	ba a0 00 00 00       	mov    $0xa0,%edx
   4074b:	48 89 ce             	mov    %rcx,%rsi
   4074e:	48 89 c7             	mov    %rax,%rdi
   40751:	e8 28 26 00 00       	call   42d7e <memcpy>
		panic(msg);
   40756:	48 8d 85 10 ff ff ff 	lea    -0xf0(%rbp),%rax
   4075d:	48 89 c7             	mov    %rax,%rdi
   40760:	b8 00 00 00 00       	mov    $0x0,%eax
   40765:	e8 e6 1a 00 00       	call   42250 <panic>
	    }
	    panic(NULL);
	    break;                  // will not be reached

    case INT_SYS_GETPID:
        current->p_registers.reg_rax = current->p_pid;
   4076a:	48 8b 05 8f 08 01 00 	mov    0x1088f(%rip),%rax        # 51000 <current>
   40771:	8b 10                	mov    (%rax),%edx
   40773:	48 8b 05 86 08 01 00 	mov    0x10886(%rip),%rax        # 51000 <current>
   4077a:	48 63 d2             	movslq %edx,%rdx
   4077d:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   40781:	e9 c7 01 00 00       	jmp    4094d <exception+0x32f>

    case INT_SYS_YIELD:
        schedule();
   40786:	e8 eb 01 00 00       	call   40976 <schedule>
        break;                  /* will not be reached */
   4078b:	e9 bd 01 00 00       	jmp    4094d <exception+0x32f>

    case INT_SYS_PAGE_ALLOC: {
        uintptr_t addr = current->p_registers.reg_rdi;
   40790:	48 8b 05 69 08 01 00 	mov    0x10869(%rip),%rax        # 51000 <current>
   40797:	48 8b 40 38          	mov    0x38(%rax),%rax
   4079b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        int r = assign_physical_page(addr, current->p_pid);
   4079f:	48 8b 05 5a 08 01 00 	mov    0x1085a(%rip),%rax        # 51000 <current>
   407a6:	8b 00                	mov    (%rax),%eax
   407a8:	0f be d0             	movsbl %al,%edx
   407ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   407af:	89 d6                	mov    %edx,%esi
   407b1:	48 89 c7             	mov    %rax,%rdi
   407b4:	e8 bf fc ff ff       	call   40478 <assign_physical_page>
   407b9:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (r >= 0) {
   407bc:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   407c0:	78 29                	js     407eb <exception+0x1cd>
            virtual_memory_map(current->p_pagetable, addr, addr,
   407c2:	48 8b 05 37 08 01 00 	mov    0x10837(%rip),%rax        # 51000 <current>
   407c9:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   407d0:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   407d4:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   407d8:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   407de:	b9 00 10 00 00       	mov    $0x1000,%ecx
   407e3:	48 89 c7             	mov    %rax,%rdi
   407e6:	e8 44 1e 00 00       	call   4262f <virtual_memory_map>
                               PAGESIZE, PTE_P | PTE_W | PTE_U);
        }
        current->p_registers.reg_rax = r;
   407eb:	48 8b 05 0e 08 01 00 	mov    0x1080e(%rip),%rax        # 51000 <current>
   407f2:	8b 55 f4             	mov    -0xc(%rbp),%edx
   407f5:	48 63 d2             	movslq %edx,%rdx
   407f8:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   407fc:	e9 4c 01 00 00       	jmp    4094d <exception+0x32f>
    }

    case INT_SYS_MAPPING:
    {
	    syscall_mapping(current);
   40801:	48 8b 05 f8 07 01 00 	mov    0x107f8(%rip),%rax        # 51000 <current>
   40808:	48 89 c7             	mov    %rax,%rdi
   4080b:	e8 dc fc ff ff       	call   404ec <syscall_mapping>
            break;
   40810:	e9 38 01 00 00       	jmp    4094d <exception+0x32f>
    }

    case INT_SYS_MEM_TOG:
	{
	    syscall_mem_tog(current);
   40815:	48 8b 05 e4 07 01 00 	mov    0x107e4(%rip),%rax        # 51000 <current>
   4081c:	48 89 c7             	mov    %rax,%rdi
   4081f:	e8 91 fd ff ff       	call   405b5 <syscall_mem_tog>
	    break;
   40824:	e9 24 01 00 00       	jmp    4094d <exception+0x32f>
	}

    case INT_TIMER:
        ++ticks;
   40829:	8b 05 f1 15 01 00    	mov    0x115f1(%rip),%eax        # 51e20 <ticks>
   4082f:	83 c0 01             	add    $0x1,%eax
   40832:	89 05 e8 15 01 00    	mov    %eax,0x115e8(%rip)        # 51e20 <ticks>
        schedule();
   40838:	e8 39 01 00 00       	call   40976 <schedule>
        break;                  /* will not be reached */
   4083d:	e9 0b 01 00 00       	jmp    4094d <exception+0x32f>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   40842:	0f 20 d0             	mov    %cr2,%rax
   40845:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    return val;
   40849:	48 8b 45 c8          	mov    -0x38(%rbp),%rax

    case INT_PAGEFAULT: {
        // Analyze faulting address and access type.
        uintptr_t addr = rcr2();
   4084d:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
        const char* operation = reg->reg_err & PFERR_WRITE
   40851:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40858:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   4085f:	83 e0 02             	and    $0x2,%eax
                ? "write" : "read";
   40862:	48 85 c0             	test   %rax,%rax
   40865:	74 07                	je     4086e <exception+0x250>
   40867:	b8 10 3e 04 00       	mov    $0x43e10,%eax
   4086c:	eb 05                	jmp    40873 <exception+0x255>
   4086e:	b8 16 3e 04 00       	mov    $0x43e16,%eax
        const char* operation = reg->reg_err & PFERR_WRITE
   40873:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        const char* problem = reg->reg_err & PFERR_PRESENT
   40877:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   4087e:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40885:	83 e0 01             	and    $0x1,%eax
                ? "protection problem" : "missing page";
   40888:	48 85 c0             	test   %rax,%rax
   4088b:	74 07                	je     40894 <exception+0x276>
   4088d:	b8 1b 3e 04 00       	mov    $0x43e1b,%eax
   40892:	eb 05                	jmp    40899 <exception+0x27b>
   40894:	b8 2e 3e 04 00       	mov    $0x43e2e,%eax
        const char* problem = reg->reg_err & PFERR_PRESENT
   40899:	48 89 45 d0          	mov    %rax,-0x30(%rbp)

        if (!(reg->reg_err & PFERR_USER)) {
   4089d:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   408a4:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   408ab:	83 e0 04             	and    $0x4,%eax
   408ae:	48 85 c0             	test   %rax,%rax
   408b1:	75 2f                	jne    408e2 <exception+0x2c4>
            panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   408b3:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   408ba:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   408c1:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
   408c5:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   408c9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   408cd:	49 89 f0             	mov    %rsi,%r8
   408d0:	48 89 c6             	mov    %rax,%rsi
   408d3:	bf 40 3e 04 00       	mov    $0x43e40,%edi
   408d8:	b8 00 00 00 00       	mov    $0x0,%eax
   408dd:	e8 6e 19 00 00       	call   42250 <panic>
                  addr, operation, problem, reg->reg_rip);
        }
        console_printf(CPOS(24, 0), 0x0C00,
   408e2:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   408e9:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                       "Process %d page fault for %p (%s %s, rip=%p)!\n",
                       current->p_pid, addr, operation, problem, reg->reg_rip);
   408f0:	48 8b 05 09 07 01 00 	mov    0x10709(%rip),%rax        # 51000 <current>
        console_printf(CPOS(24, 0), 0x0C00,
   408f7:	8b 00                	mov    (%rax),%eax
   408f9:	48 8b 75 d8          	mov    -0x28(%rbp),%rsi
   408fd:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   40901:	52                   	push   %rdx
   40902:	ff 75 d0             	push   -0x30(%rbp)
   40905:	49 89 f1             	mov    %rsi,%r9
   40908:	49 89 c8             	mov    %rcx,%r8
   4090b:	89 c1                	mov    %eax,%ecx
   4090d:	ba 70 3e 04 00       	mov    $0x43e70,%edx
   40912:	be 00 0c 00 00       	mov    $0xc00,%esi
   40917:	bf 80 07 00 00       	mov    $0x780,%edi
   4091c:	b8 00 00 00 00       	mov    $0x0,%eax
   40921:	e8 0d 33 00 00       	call   43c33 <console_printf>
   40926:	48 83 c4 10          	add    $0x10,%rsp
        current->p_state = P_BROKEN;
   4092a:	48 8b 05 cf 06 01 00 	mov    0x106cf(%rip),%rax        # 51000 <current>
   40931:	c7 80 c8 00 00 00 03 	movl   $0x3,0xc8(%rax)
   40938:	00 00 00 
        break;
   4093b:	eb 10                	jmp    4094d <exception+0x32f>
    }

    default:
        default_exception(current);
   4093d:	48 8b 05 bc 06 01 00 	mov    0x106bc(%rip),%rax        # 51000 <current>
   40944:	48 89 c7             	mov    %rax,%rdi
   40947:	e8 14 1a 00 00       	call   42360 <default_exception>
        break;                  /* will not be reached */
   4094c:	90                   	nop

    }


    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   4094d:	48 8b 05 ac 06 01 00 	mov    0x106ac(%rip),%rax        # 51000 <current>
   40954:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   4095a:	83 f8 01             	cmp    $0x1,%eax
   4095d:	75 0f                	jne    4096e <exception+0x350>
        run(current);
   4095f:	48 8b 05 9a 06 01 00 	mov    0x1069a(%rip),%rax        # 51000 <current>
   40966:	48 89 c7             	mov    %rax,%rdi
   40969:	e8 7e 00 00 00       	call   409ec <run>
    } else {
        schedule();
   4096e:	e8 03 00 00 00       	call   40976 <schedule>
    }
}
   40973:	90                   	nop
   40974:	c9                   	leave  
   40975:	c3                   	ret    

0000000000040976 <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   40976:	55                   	push   %rbp
   40977:	48 89 e5             	mov    %rsp,%rbp
   4097a:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   4097e:	48 8b 05 7b 06 01 00 	mov    0x1067b(%rip),%rax        # 51000 <current>
   40985:	8b 00                	mov    (%rax),%eax
   40987:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   4098a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4098d:	8d 50 01             	lea    0x1(%rax),%edx
   40990:	89 d0                	mov    %edx,%eax
   40992:	c1 f8 1f             	sar    $0x1f,%eax
   40995:	c1 e8 1c             	shr    $0x1c,%eax
   40998:	01 c2                	add    %eax,%edx
   4099a:	83 e2 0f             	and    $0xf,%edx
   4099d:	29 c2                	sub    %eax,%edx
   4099f:	89 55 fc             	mov    %edx,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   409a2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   409a5:	48 63 d0             	movslq %eax,%rdx
   409a8:	48 89 d0             	mov    %rdx,%rax
   409ab:	48 c1 e0 03          	shl    $0x3,%rax
   409af:	48 29 d0             	sub    %rdx,%rax
   409b2:	48 c1 e0 05          	shl    $0x5,%rax
   409b6:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   409bc:	8b 00                	mov    (%rax),%eax
   409be:	83 f8 01             	cmp    $0x1,%eax
   409c1:	75 22                	jne    409e5 <schedule+0x6f>
            run(&processes[pid]);
   409c3:	8b 45 fc             	mov    -0x4(%rbp),%eax
   409c6:	48 63 d0             	movslq %eax,%rdx
   409c9:	48 89 d0             	mov    %rdx,%rax
   409cc:	48 c1 e0 03          	shl    $0x3,%rax
   409d0:	48 29 d0             	sub    %rdx,%rax
   409d3:	48 c1 e0 05          	shl    $0x5,%rax
   409d7:	48 05 20 10 05 00    	add    $0x51020,%rax
   409dd:	48 89 c7             	mov    %rax,%rdi
   409e0:	e8 07 00 00 00       	call   409ec <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   409e5:	e8 25 17 00 00       	call   4210f <check_keyboard>
        pid = (pid + 1) % NPROC;
   409ea:	eb 9e                	jmp    4098a <schedule+0x14>

00000000000409ec <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   409ec:	55                   	push   %rbp
   409ed:	48 89 e5             	mov    %rsp,%rbp
   409f0:	48 83 ec 10          	sub    $0x10,%rsp
   409f4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   409f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   409fc:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   40a02:	83 f8 01             	cmp    $0x1,%eax
   40a05:	74 14                	je     40a1b <run+0x2f>
   40a07:	ba f8 3f 04 00       	mov    $0x43ff8,%edx
   40a0c:	be 58 01 00 00       	mov    $0x158,%esi
   40a11:	bf 00 3e 04 00       	mov    $0x43e00,%edi
   40a16:	e8 15 19 00 00       	call   42330 <assert_fail>
    current = p;
   40a1b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a1f:	48 89 05 da 05 01 00 	mov    %rax,0x105da(%rip)        # 51000 <current>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   40a26:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a2a:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40a31:	48 89 c7             	mov    %rax,%rdi
   40a34:	e8 c5 1a 00 00       	call   424fe <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   40a39:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a3d:	48 83 c0 08          	add    $0x8,%rax
   40a41:	48 89 c7             	mov    %rax,%rdi
   40a44:	e8 7a f6 ff ff       	call   400c3 <exception_return>

0000000000040a49 <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   40a49:	55                   	push   %rbp
   40a4a:	48 89 e5             	mov    %rsp,%rbp
   40a4d:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40a51:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40a58:	00 
   40a59:	e9 81 00 00 00       	jmp    40adf <pageinfo_init+0x96>
        int owner;
        if (physical_memory_isreserved(addr)) {
   40a5e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a62:	48 89 c7             	mov    %rax,%rdi
   40a65:	e8 33 0f 00 00       	call   4199d <physical_memory_isreserved>
   40a6a:	85 c0                	test   %eax,%eax
   40a6c:	74 09                	je     40a77 <pageinfo_init+0x2e>
            owner = PO_RESERVED;
   40a6e:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   40a75:	eb 2f                	jmp    40aa6 <pageinfo_init+0x5d>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   40a77:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   40a7e:	00 
   40a7f:	76 0b                	jbe    40a8c <pageinfo_init+0x43>
   40a81:	b8 08 a0 05 00       	mov    $0x5a008,%eax
   40a86:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40a8a:	72 0a                	jb     40a96 <pageinfo_init+0x4d>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   40a8c:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   40a93:	00 
   40a94:	75 09                	jne    40a9f <pageinfo_init+0x56>
            owner = PO_KERNEL;
   40a96:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   40a9d:	eb 07                	jmp    40aa6 <pageinfo_init+0x5d>
        } else {
            owner = PO_FREE;
   40a9f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40aa6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40aaa:	48 c1 e8 0c          	shr    $0xc,%rax
   40aae:	89 c1                	mov    %eax,%ecx
   40ab0:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40ab3:	89 c2                	mov    %eax,%edx
   40ab5:	48 63 c1             	movslq %ecx,%rax
   40ab8:	88 94 00 40 1e 05 00 	mov    %dl,0x51e40(%rax,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   40abf:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40ac3:	0f 95 c2             	setne  %dl
   40ac6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40aca:	48 c1 e8 0c          	shr    $0xc,%rax
   40ace:	48 98                	cltq   
   40ad0:	88 94 00 41 1e 05 00 	mov    %dl,0x51e41(%rax,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40ad7:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40ade:	00 
   40adf:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40ae6:	00 
   40ae7:	0f 86 71 ff ff ff    	jbe    40a5e <pageinfo_init+0x15>
    }
}
   40aed:	90                   	nop
   40aee:	90                   	nop
   40aef:	c9                   	leave  
   40af0:	c3                   	ret    

0000000000040af1 <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   40af1:	55                   	push   %rbp
   40af2:	48 89 e5             	mov    %rsp,%rbp
   40af5:	48 83 ec 50          	sub    $0x50,%rsp
   40af9:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   40afd:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40b01:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40b07:	48 89 c2             	mov    %rax,%rdx
   40b0a:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40b0e:	48 39 c2             	cmp    %rax,%rdx
   40b11:	74 14                	je     40b27 <check_page_table_mappings+0x36>
   40b13:	ba 18 40 04 00       	mov    $0x44018,%edx
   40b18:	be 82 01 00 00       	mov    $0x182,%esi
   40b1d:	bf 00 3e 04 00       	mov    $0x43e00,%edi
   40b22:	e8 09 18 00 00       	call   42330 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40b27:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   40b2e:	00 
   40b2f:	e9 9a 00 00 00       	jmp    40bce <check_page_table_mappings+0xdd>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   40b34:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   40b38:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40b3c:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40b40:	48 89 ce             	mov    %rcx,%rsi
   40b43:	48 89 c7             	mov    %rax,%rdi
   40b46:	e8 9f 1e 00 00       	call   429ea <virtual_memory_lookup>
        if (vam.pa != va) {
   40b4b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40b4f:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40b53:	74 27                	je     40b7c <check_page_table_mappings+0x8b>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   40b55:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40b59:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40b5d:	49 89 d0             	mov    %rdx,%r8
   40b60:	48 89 c1             	mov    %rax,%rcx
   40b63:	ba 37 40 04 00       	mov    $0x44037,%edx
   40b68:	be 00 c0 00 00       	mov    $0xc000,%esi
   40b6d:	bf e0 06 00 00       	mov    $0x6e0,%edi
   40b72:	b8 00 00 00 00       	mov    $0x0,%eax
   40b77:	e8 b7 30 00 00       	call   43c33 <console_printf>
        }
        assert(vam.pa == va);
   40b7c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40b80:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40b84:	74 14                	je     40b9a <check_page_table_mappings+0xa9>
   40b86:	ba 41 40 04 00       	mov    $0x44041,%edx
   40b8b:	be 8b 01 00 00       	mov    $0x18b,%esi
   40b90:	bf 00 3e 04 00       	mov    $0x43e00,%edi
   40b95:	e8 96 17 00 00       	call   42330 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   40b9a:	b8 00 50 04 00       	mov    $0x45000,%eax
   40b9f:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40ba3:	72 21                	jb     40bc6 <check_page_table_mappings+0xd5>
            assert(vam.perm & PTE_W);
   40ba5:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40ba8:	48 98                	cltq   
   40baa:	83 e0 02             	and    $0x2,%eax
   40bad:	48 85 c0             	test   %rax,%rax
   40bb0:	75 14                	jne    40bc6 <check_page_table_mappings+0xd5>
   40bb2:	ba 4e 40 04 00       	mov    $0x4404e,%edx
   40bb7:	be 8d 01 00 00       	mov    $0x18d,%esi
   40bbc:	bf 00 3e 04 00       	mov    $0x43e00,%edi
   40bc1:	e8 6a 17 00 00       	call   42330 <assert_fail>
         va += PAGESIZE) {
   40bc6:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40bcd:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40bce:	b8 08 a0 05 00       	mov    $0x5a008,%eax
   40bd3:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40bd7:	0f 82 57 ff ff ff    	jb     40b34 <check_page_table_mappings+0x43>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   40bdd:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   40be4:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   40be5:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   40be9:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40bed:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40bf1:	48 89 ce             	mov    %rcx,%rsi
   40bf4:	48 89 c7             	mov    %rax,%rdi
   40bf7:	e8 ee 1d 00 00       	call   429ea <virtual_memory_lookup>
    assert(vam.pa == kstack);
   40bfc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40c00:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   40c04:	74 14                	je     40c1a <check_page_table_mappings+0x129>
   40c06:	ba 5f 40 04 00       	mov    $0x4405f,%edx
   40c0b:	be 94 01 00 00       	mov    $0x194,%esi
   40c10:	bf 00 3e 04 00       	mov    $0x43e00,%edi
   40c15:	e8 16 17 00 00       	call   42330 <assert_fail>
    assert(vam.perm & PTE_W);
   40c1a:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40c1d:	48 98                	cltq   
   40c1f:	83 e0 02             	and    $0x2,%eax
   40c22:	48 85 c0             	test   %rax,%rax
   40c25:	75 14                	jne    40c3b <check_page_table_mappings+0x14a>
   40c27:	ba 4e 40 04 00       	mov    $0x4404e,%edx
   40c2c:	be 95 01 00 00       	mov    $0x195,%esi
   40c31:	bf 00 3e 04 00       	mov    $0x43e00,%edi
   40c36:	e8 f5 16 00 00       	call   42330 <assert_fail>
}
   40c3b:	90                   	nop
   40c3c:	c9                   	leave  
   40c3d:	c3                   	ret    

0000000000040c3e <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   40c3e:	55                   	push   %rbp
   40c3f:	48 89 e5             	mov    %rsp,%rbp
   40c42:	48 83 ec 20          	sub    $0x20,%rsp
   40c46:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40c4a:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   40c4d:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40c50:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   40c53:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   40c5a:	48 8b 05 9f 33 01 00 	mov    0x1339f(%rip),%rax        # 54000 <kernel_pagetable>
   40c61:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40c65:	75 67                	jne    40cce <check_page_table_ownership+0x90>
        owner = PO_KERNEL;
   40c67:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40c6e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   40c75:	eb 51                	jmp    40cc8 <check_page_table_ownership+0x8a>
            if (processes[xpid].p_state != P_FREE
   40c77:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40c7a:	48 63 d0             	movslq %eax,%rdx
   40c7d:	48 89 d0             	mov    %rdx,%rax
   40c80:	48 c1 e0 03          	shl    $0x3,%rax
   40c84:	48 29 d0             	sub    %rdx,%rax
   40c87:	48 c1 e0 05          	shl    $0x5,%rax
   40c8b:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   40c91:	8b 00                	mov    (%rax),%eax
   40c93:	85 c0                	test   %eax,%eax
   40c95:	74 2d                	je     40cc4 <check_page_table_ownership+0x86>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   40c97:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40c9a:	48 63 d0             	movslq %eax,%rdx
   40c9d:	48 89 d0             	mov    %rdx,%rax
   40ca0:	48 c1 e0 03          	shl    $0x3,%rax
   40ca4:	48 29 d0             	sub    %rdx,%rax
   40ca7:	48 c1 e0 05          	shl    $0x5,%rax
   40cab:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   40cb1:	48 8b 10             	mov    (%rax),%rdx
   40cb4:	48 8b 05 45 33 01 00 	mov    0x13345(%rip),%rax        # 54000 <kernel_pagetable>
   40cbb:	48 39 c2             	cmp    %rax,%rdx
   40cbe:	75 04                	jne    40cc4 <check_page_table_ownership+0x86>
                ++expected_refcount;
   40cc0:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40cc4:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   40cc8:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   40ccc:	7e a9                	jle    40c77 <check_page_table_ownership+0x39>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   40cce:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   40cd1:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40cd4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40cd8:	be 00 00 00 00       	mov    $0x0,%esi
   40cdd:	48 89 c7             	mov    %rax,%rdi
   40ce0:	e8 03 00 00 00       	call   40ce8 <check_page_table_ownership_level>
}
   40ce5:	90                   	nop
   40ce6:	c9                   	leave  
   40ce7:	c3                   	ret    

0000000000040ce8 <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   40ce8:	55                   	push   %rbp
   40ce9:	48 89 e5             	mov    %rsp,%rbp
   40cec:	48 83 ec 30          	sub    $0x30,%rsp
   40cf0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40cf4:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   40cf7:	89 55 e0             	mov    %edx,-0x20(%rbp)
   40cfa:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   40cfd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40d01:	48 c1 e8 0c          	shr    $0xc,%rax
   40d05:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   40d0a:	7e 14                	jle    40d20 <check_page_table_ownership_level+0x38>
   40d0c:	ba 70 40 04 00       	mov    $0x44070,%edx
   40d11:	be b2 01 00 00       	mov    $0x1b2,%esi
   40d16:	bf 00 3e 04 00       	mov    $0x43e00,%edi
   40d1b:	e8 10 16 00 00       	call   42330 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   40d20:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40d24:	48 c1 e8 0c          	shr    $0xc,%rax
   40d28:	48 98                	cltq   
   40d2a:	0f b6 84 00 40 1e 05 	movzbl 0x51e40(%rax,%rax,1),%eax
   40d31:	00 
   40d32:	0f be c0             	movsbl %al,%eax
   40d35:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   40d38:	74 14                	je     40d4e <check_page_table_ownership_level+0x66>
   40d3a:	ba 88 40 04 00       	mov    $0x44088,%edx
   40d3f:	be b3 01 00 00       	mov    $0x1b3,%esi
   40d44:	bf 00 3e 04 00       	mov    $0x43e00,%edi
   40d49:	e8 e2 15 00 00       	call   42330 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   40d4e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40d52:	48 c1 e8 0c          	shr    $0xc,%rax
   40d56:	48 98                	cltq   
   40d58:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   40d5f:	00 
   40d60:	0f be c0             	movsbl %al,%eax
   40d63:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   40d66:	74 14                	je     40d7c <check_page_table_ownership_level+0x94>
   40d68:	ba b0 40 04 00       	mov    $0x440b0,%edx
   40d6d:	be b4 01 00 00       	mov    $0x1b4,%esi
   40d72:	bf 00 3e 04 00       	mov    $0x43e00,%edi
   40d77:	e8 b4 15 00 00       	call   42330 <assert_fail>
    if (level < 3) {
   40d7c:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   40d80:	7f 5b                	jg     40ddd <check_page_table_ownership_level+0xf5>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   40d82:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   40d89:	eb 49                	jmp    40dd4 <check_page_table_ownership_level+0xec>
            if (pt->entry[index]) {
   40d8b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40d8f:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40d92:	48 63 d2             	movslq %edx,%rdx
   40d95:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   40d99:	48 85 c0             	test   %rax,%rax
   40d9c:	74 32                	je     40dd0 <check_page_table_ownership_level+0xe8>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   40d9e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40da2:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40da5:	48 63 d2             	movslq %edx,%rdx
   40da8:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   40dac:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   40db2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   40db6:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40db9:	8d 70 01             	lea    0x1(%rax),%esi
   40dbc:	8b 55 e0             	mov    -0x20(%rbp),%edx
   40dbf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40dc3:	b9 01 00 00 00       	mov    $0x1,%ecx
   40dc8:	48 89 c7             	mov    %rax,%rdi
   40dcb:	e8 18 ff ff ff       	call   40ce8 <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   40dd0:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   40dd4:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   40ddb:	7e ae                	jle    40d8b <check_page_table_ownership_level+0xa3>
            }
        }
    }
}
   40ddd:	90                   	nop
   40dde:	c9                   	leave  
   40ddf:	c3                   	ret    

0000000000040de0 <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   40de0:	55                   	push   %rbp
   40de1:	48 89 e5             	mov    %rsp,%rbp
   40de4:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   40de8:	8b 05 fa 02 01 00    	mov    0x102fa(%rip),%eax        # 510e8 <processes+0xc8>
   40dee:	85 c0                	test   %eax,%eax
   40df0:	74 14                	je     40e06 <check_virtual_memory+0x26>
   40df2:	ba e0 40 04 00       	mov    $0x440e0,%edx
   40df7:	be c7 01 00 00       	mov    $0x1c7,%esi
   40dfc:	bf 00 3e 04 00       	mov    $0x43e00,%edi
   40e01:	e8 2a 15 00 00       	call   42330 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   40e06:	48 8b 05 f3 31 01 00 	mov    0x131f3(%rip),%rax        # 54000 <kernel_pagetable>
   40e0d:	48 89 c7             	mov    %rax,%rdi
   40e10:	e8 dc fc ff ff       	call   40af1 <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   40e15:	48 8b 05 e4 31 01 00 	mov    0x131e4(%rip),%rax        # 54000 <kernel_pagetable>
   40e1c:	be ff ff ff ff       	mov    $0xffffffff,%esi
   40e21:	48 89 c7             	mov    %rax,%rdi
   40e24:	e8 15 fe ff ff       	call   40c3e <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   40e29:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   40e30:	e9 9c 00 00 00       	jmp    40ed1 <check_virtual_memory+0xf1>
        if (processes[pid].p_state != P_FREE
   40e35:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40e38:	48 63 d0             	movslq %eax,%rdx
   40e3b:	48 89 d0             	mov    %rdx,%rax
   40e3e:	48 c1 e0 03          	shl    $0x3,%rax
   40e42:	48 29 d0             	sub    %rdx,%rax
   40e45:	48 c1 e0 05          	shl    $0x5,%rax
   40e49:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   40e4f:	8b 00                	mov    (%rax),%eax
   40e51:	85 c0                	test   %eax,%eax
   40e53:	74 78                	je     40ecd <check_virtual_memory+0xed>
            && processes[pid].p_pagetable != kernel_pagetable) {
   40e55:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40e58:	48 63 d0             	movslq %eax,%rdx
   40e5b:	48 89 d0             	mov    %rdx,%rax
   40e5e:	48 c1 e0 03          	shl    $0x3,%rax
   40e62:	48 29 d0             	sub    %rdx,%rax
   40e65:	48 c1 e0 05          	shl    $0x5,%rax
   40e69:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   40e6f:	48 8b 10             	mov    (%rax),%rdx
   40e72:	48 8b 05 87 31 01 00 	mov    0x13187(%rip),%rax        # 54000 <kernel_pagetable>
   40e79:	48 39 c2             	cmp    %rax,%rdx
   40e7c:	74 4f                	je     40ecd <check_virtual_memory+0xed>
            check_page_table_mappings(processes[pid].p_pagetable);
   40e7e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40e81:	48 63 d0             	movslq %eax,%rdx
   40e84:	48 89 d0             	mov    %rdx,%rax
   40e87:	48 c1 e0 03          	shl    $0x3,%rax
   40e8b:	48 29 d0             	sub    %rdx,%rax
   40e8e:	48 c1 e0 05          	shl    $0x5,%rax
   40e92:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   40e98:	48 8b 00             	mov    (%rax),%rax
   40e9b:	48 89 c7             	mov    %rax,%rdi
   40e9e:	e8 4e fc ff ff       	call   40af1 <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   40ea3:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40ea6:	48 63 d0             	movslq %eax,%rdx
   40ea9:	48 89 d0             	mov    %rdx,%rax
   40eac:	48 c1 e0 03          	shl    $0x3,%rax
   40eb0:	48 29 d0             	sub    %rdx,%rax
   40eb3:	48 c1 e0 05          	shl    $0x5,%rax
   40eb7:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   40ebd:	48 8b 00             	mov    (%rax),%rax
   40ec0:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40ec3:	89 d6                	mov    %edx,%esi
   40ec5:	48 89 c7             	mov    %rax,%rdi
   40ec8:	e8 71 fd ff ff       	call   40c3e <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   40ecd:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   40ed1:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   40ed5:	0f 8e 5a ff ff ff    	jle    40e35 <check_virtual_memory+0x55>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   40edb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   40ee2:	eb 67                	jmp    40f4b <check_virtual_memory+0x16b>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   40ee4:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40ee7:	48 98                	cltq   
   40ee9:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   40ef0:	00 
   40ef1:	84 c0                	test   %al,%al
   40ef3:	7e 52                	jle    40f47 <check_virtual_memory+0x167>
   40ef5:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40ef8:	48 98                	cltq   
   40efa:	0f b6 84 00 40 1e 05 	movzbl 0x51e40(%rax,%rax,1),%eax
   40f01:	00 
   40f02:	84 c0                	test   %al,%al
   40f04:	78 41                	js     40f47 <check_virtual_memory+0x167>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   40f06:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40f09:	48 98                	cltq   
   40f0b:	0f b6 84 00 40 1e 05 	movzbl 0x51e40(%rax,%rax,1),%eax
   40f12:	00 
   40f13:	0f be c0             	movsbl %al,%eax
   40f16:	48 63 d0             	movslq %eax,%rdx
   40f19:	48 89 d0             	mov    %rdx,%rax
   40f1c:	48 c1 e0 03          	shl    $0x3,%rax
   40f20:	48 29 d0             	sub    %rdx,%rax
   40f23:	48 c1 e0 05          	shl    $0x5,%rax
   40f27:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   40f2d:	8b 00                	mov    (%rax),%eax
   40f2f:	85 c0                	test   %eax,%eax
   40f31:	75 14                	jne    40f47 <check_virtual_memory+0x167>
   40f33:	ba 00 41 04 00       	mov    $0x44100,%edx
   40f38:	be de 01 00 00       	mov    $0x1de,%esi
   40f3d:	bf 00 3e 04 00       	mov    $0x43e00,%edi
   40f42:	e8 e9 13 00 00       	call   42330 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   40f47:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   40f4b:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   40f52:	7e 90                	jle    40ee4 <check_virtual_memory+0x104>
        }
    }
}
   40f54:	90                   	nop
   40f55:	90                   	nop
   40f56:	c9                   	leave  
   40f57:	c3                   	ret    

0000000000040f58 <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   40f58:	55                   	push   %rbp
   40f59:	48 89 e5             	mov    %rsp,%rbp
   40f5c:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   40f60:	ba 66 41 04 00       	mov    $0x44166,%edx
   40f65:	be 00 0f 00 00       	mov    $0xf00,%esi
   40f6a:	bf 20 00 00 00       	mov    $0x20,%edi
   40f6f:	b8 00 00 00 00       	mov    $0x0,%eax
   40f74:	e8 ba 2c 00 00       	call   43c33 <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   40f79:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   40f80:	e9 f8 00 00 00       	jmp    4107d <memshow_physical+0x125>
        if (pn % 64 == 0) {
   40f85:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40f88:	83 e0 3f             	and    $0x3f,%eax
   40f8b:	85 c0                	test   %eax,%eax
   40f8d:	75 3c                	jne    40fcb <memshow_physical+0x73>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   40f8f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40f92:	c1 e0 0c             	shl    $0xc,%eax
   40f95:	89 c1                	mov    %eax,%ecx
   40f97:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40f9a:	8d 50 3f             	lea    0x3f(%rax),%edx
   40f9d:	85 c0                	test   %eax,%eax
   40f9f:	0f 48 c2             	cmovs  %edx,%eax
   40fa2:	c1 f8 06             	sar    $0x6,%eax
   40fa5:	8d 50 01             	lea    0x1(%rax),%edx
   40fa8:	89 d0                	mov    %edx,%eax
   40faa:	c1 e0 02             	shl    $0x2,%eax
   40fad:	01 d0                	add    %edx,%eax
   40faf:	c1 e0 04             	shl    $0x4,%eax
   40fb2:	83 c0 03             	add    $0x3,%eax
   40fb5:	ba 76 41 04 00       	mov    $0x44176,%edx
   40fba:	be 00 0f 00 00       	mov    $0xf00,%esi
   40fbf:	89 c7                	mov    %eax,%edi
   40fc1:	b8 00 00 00 00       	mov    $0x0,%eax
   40fc6:	e8 68 2c 00 00       	call   43c33 <console_printf>
        }

        int owner = pageinfo[pn].owner;
   40fcb:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40fce:	48 98                	cltq   
   40fd0:	0f b6 84 00 40 1e 05 	movzbl 0x51e40(%rax,%rax,1),%eax
   40fd7:	00 
   40fd8:	0f be c0             	movsbl %al,%eax
   40fdb:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   40fde:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40fe1:	48 98                	cltq   
   40fe3:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   40fea:	00 
   40feb:	84 c0                	test   %al,%al
   40fed:	75 07                	jne    40ff6 <memshow_physical+0x9e>
            owner = PO_FREE;
   40fef:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   40ff6:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40ff9:	83 c0 02             	add    $0x2,%eax
   40ffc:	48 98                	cltq   
   40ffe:	0f b7 84 00 40 41 04 	movzwl 0x44140(%rax,%rax,1),%eax
   41005:	00 
   41006:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   4100a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4100d:	48 98                	cltq   
   4100f:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   41016:	00 
   41017:	3c 01                	cmp    $0x1,%al
   41019:	7e 1a                	jle    41035 <memshow_physical+0xdd>
   4101b:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   41020:	48 c1 e8 0c          	shr    $0xc,%rax
   41024:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   41027:	74 0c                	je     41035 <memshow_physical+0xdd>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   41029:	b8 53 00 00 00       	mov    $0x53,%eax
   4102e:	80 cc 0f             	or     $0xf,%ah
   41031:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   41035:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41038:	8d 50 3f             	lea    0x3f(%rax),%edx
   4103b:	85 c0                	test   %eax,%eax
   4103d:	0f 48 c2             	cmovs  %edx,%eax
   41040:	c1 f8 06             	sar    $0x6,%eax
   41043:	8d 50 01             	lea    0x1(%rax),%edx
   41046:	89 d0                	mov    %edx,%eax
   41048:	c1 e0 02             	shl    $0x2,%eax
   4104b:	01 d0                	add    %edx,%eax
   4104d:	c1 e0 04             	shl    $0x4,%eax
   41050:	89 c1                	mov    %eax,%ecx
   41052:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41055:	89 d0                	mov    %edx,%eax
   41057:	c1 f8 1f             	sar    $0x1f,%eax
   4105a:	c1 e8 1a             	shr    $0x1a,%eax
   4105d:	01 c2                	add    %eax,%edx
   4105f:	83 e2 3f             	and    $0x3f,%edx
   41062:	29 c2                	sub    %eax,%edx
   41064:	89 d0                	mov    %edx,%eax
   41066:	83 c0 0c             	add    $0xc,%eax
   41069:	01 c8                	add    %ecx,%eax
   4106b:	48 98                	cltq   
   4106d:	0f b7 55 f6          	movzwl -0xa(%rbp),%edx
   41071:	66 89 94 00 00 80 0b 	mov    %dx,0xb8000(%rax,%rax,1)
   41078:	00 
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41079:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4107d:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41084:	0f 8e fb fe ff ff    	jle    40f85 <memshow_physical+0x2d>
    }
}
   4108a:	90                   	nop
   4108b:	90                   	nop
   4108c:	c9                   	leave  
   4108d:	c3                   	ret    

000000000004108e <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   4108e:	55                   	push   %rbp
   4108f:	48 89 e5             	mov    %rsp,%rbp
   41092:	48 83 ec 40          	sub    $0x40,%rsp
   41096:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   4109a:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   4109e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   410a2:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   410a8:	48 89 c2             	mov    %rax,%rdx
   410ab:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   410af:	48 39 c2             	cmp    %rax,%rdx
   410b2:	74 14                	je     410c8 <memshow_virtual+0x3a>
   410b4:	ba 80 41 04 00       	mov    $0x44180,%edx
   410b9:	be 0f 02 00 00       	mov    $0x20f,%esi
   410be:	bf 00 3e 04 00       	mov    $0x43e00,%edi
   410c3:	e8 68 12 00 00       	call   42330 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   410c8:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   410cc:	48 89 c1             	mov    %rax,%rcx
   410cf:	ba ad 41 04 00       	mov    $0x441ad,%edx
   410d4:	be 00 0f 00 00       	mov    $0xf00,%esi
   410d9:	bf 3a 03 00 00       	mov    $0x33a,%edi
   410de:	b8 00 00 00 00       	mov    $0x0,%eax
   410e3:	e8 4b 2b 00 00       	call   43c33 <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   410e8:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   410ef:	00 
   410f0:	e9 80 01 00 00       	jmp    41275 <memshow_virtual+0x1e7>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   410f5:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   410f9:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   410fd:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   41101:	48 89 ce             	mov    %rcx,%rsi
   41104:	48 89 c7             	mov    %rax,%rdi
   41107:	e8 de 18 00 00       	call   429ea <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   4110c:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4110f:	85 c0                	test   %eax,%eax
   41111:	79 0b                	jns    4111e <memshow_virtual+0x90>
            color = ' ';
   41113:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   41119:	e9 d7 00 00 00       	jmp    411f5 <memshow_virtual+0x167>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   4111e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41122:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   41128:	76 14                	jbe    4113e <memshow_virtual+0xb0>
   4112a:	ba ca 41 04 00       	mov    $0x441ca,%edx
   4112f:	be 18 02 00 00       	mov    $0x218,%esi
   41134:	bf 00 3e 04 00       	mov    $0x43e00,%edi
   41139:	e8 f2 11 00 00       	call   42330 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   4113e:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41141:	48 98                	cltq   
   41143:	0f b6 84 00 40 1e 05 	movzbl 0x51e40(%rax,%rax,1),%eax
   4114a:	00 
   4114b:	0f be c0             	movsbl %al,%eax
   4114e:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   41151:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41154:	48 98                	cltq   
   41156:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   4115d:	00 
   4115e:	84 c0                	test   %al,%al
   41160:	75 07                	jne    41169 <memshow_virtual+0xdb>
                owner = PO_FREE;
   41162:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   41169:	8b 45 f0             	mov    -0x10(%rbp),%eax
   4116c:	83 c0 02             	add    $0x2,%eax
   4116f:	48 98                	cltq   
   41171:	0f b7 84 00 40 41 04 	movzwl 0x44140(%rax,%rax,1),%eax
   41178:	00 
   41179:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   4117d:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41180:	48 98                	cltq   
   41182:	83 e0 04             	and    $0x4,%eax
   41185:	48 85 c0             	test   %rax,%rax
   41188:	74 27                	je     411b1 <memshow_virtual+0x123>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   4118a:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4118e:	c1 e0 04             	shl    $0x4,%eax
   41191:	66 25 00 f0          	and    $0xf000,%ax
   41195:	89 c2                	mov    %eax,%edx
   41197:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4119b:	c1 f8 04             	sar    $0x4,%eax
   4119e:	66 25 00 0f          	and    $0xf00,%ax
   411a2:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   411a4:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   411a8:	0f b6 c0             	movzbl %al,%eax
   411ab:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   411ad:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   411b1:	8b 45 d0             	mov    -0x30(%rbp),%eax
   411b4:	48 98                	cltq   
   411b6:	0f b6 84 00 41 1e 05 	movzbl 0x51e41(%rax,%rax,1),%eax
   411bd:	00 
   411be:	3c 01                	cmp    $0x1,%al
   411c0:	7e 33                	jle    411f5 <memshow_virtual+0x167>
   411c2:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   411c7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   411cb:	74 28                	je     411f5 <memshow_virtual+0x167>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   411cd:	b8 53 00 00 00       	mov    $0x53,%eax
   411d2:	89 c2                	mov    %eax,%edx
   411d4:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   411d8:	66 25 00 f0          	and    $0xf000,%ax
   411dc:	09 d0                	or     %edx,%eax
   411de:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   411e2:	8b 45 e0             	mov    -0x20(%rbp),%eax
   411e5:	48 98                	cltq   
   411e7:	83 e0 04             	and    $0x4,%eax
   411ea:	48 85 c0             	test   %rax,%rax
   411ed:	75 06                	jne    411f5 <memshow_virtual+0x167>
                    color = color | 0x0F00;
   411ef:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   411f5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   411f9:	48 c1 e8 0c          	shr    $0xc,%rax
   411fd:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   41200:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41203:	83 e0 3f             	and    $0x3f,%eax
   41206:	85 c0                	test   %eax,%eax
   41208:	75 34                	jne    4123e <memshow_virtual+0x1b0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   4120a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4120d:	c1 e8 06             	shr    $0x6,%eax
   41210:	89 c2                	mov    %eax,%edx
   41212:	89 d0                	mov    %edx,%eax
   41214:	c1 e0 02             	shl    $0x2,%eax
   41217:	01 d0                	add    %edx,%eax
   41219:	c1 e0 04             	shl    $0x4,%eax
   4121c:	05 73 03 00 00       	add    $0x373,%eax
   41221:	89 c7                	mov    %eax,%edi
   41223:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41227:	48 89 c1             	mov    %rax,%rcx
   4122a:	ba 76 41 04 00       	mov    $0x44176,%edx
   4122f:	be 00 0f 00 00       	mov    $0xf00,%esi
   41234:	b8 00 00 00 00       	mov    $0x0,%eax
   41239:	e8 f5 29 00 00       	call   43c33 <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   4123e:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41241:	c1 e8 06             	shr    $0x6,%eax
   41244:	89 c2                	mov    %eax,%edx
   41246:	89 d0                	mov    %edx,%eax
   41248:	c1 e0 02             	shl    $0x2,%eax
   4124b:	01 d0                	add    %edx,%eax
   4124d:	c1 e0 04             	shl    $0x4,%eax
   41250:	89 c2                	mov    %eax,%edx
   41252:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41255:	83 e0 3f             	and    $0x3f,%eax
   41258:	01 d0                	add    %edx,%eax
   4125a:	05 7c 03 00 00       	add    $0x37c,%eax
   4125f:	89 c2                	mov    %eax,%edx
   41261:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41265:	66 89 84 12 00 80 0b 	mov    %ax,0xb8000(%rdx,%rdx,1)
   4126c:	00 
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   4126d:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41274:	00 
   41275:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   4127c:	00 
   4127d:	0f 86 72 fe ff ff    	jbe    410f5 <memshow_virtual+0x67>
    }
}
   41283:	90                   	nop
   41284:	90                   	nop
   41285:	c9                   	leave  
   41286:	c3                   	ret    

0000000000041287 <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   41287:	55                   	push   %rbp
   41288:	48 89 e5             	mov    %rsp,%rbp
   4128b:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   4128f:	8b 05 ab 0f 01 00    	mov    0x10fab(%rip),%eax        # 52240 <last_ticks.1>
   41295:	85 c0                	test   %eax,%eax
   41297:	74 13                	je     412ac <memshow_virtual_animate+0x25>
   41299:	8b 15 81 0b 01 00    	mov    0x10b81(%rip),%edx        # 51e20 <ticks>
   4129f:	8b 05 9b 0f 01 00    	mov    0x10f9b(%rip),%eax        # 52240 <last_ticks.1>
   412a5:	29 c2                	sub    %eax,%edx
   412a7:	83 fa 31             	cmp    $0x31,%edx
   412aa:	76 2c                	jbe    412d8 <memshow_virtual_animate+0x51>
        last_ticks = ticks;
   412ac:	8b 05 6e 0b 01 00    	mov    0x10b6e(%rip),%eax        # 51e20 <ticks>
   412b2:	89 05 88 0f 01 00    	mov    %eax,0x10f88(%rip)        # 52240 <last_ticks.1>
        ++showing;
   412b8:	8b 05 46 3d 00 00    	mov    0x3d46(%rip),%eax        # 45004 <showing.0>
   412be:	83 c0 01             	add    $0x1,%eax
   412c1:	89 05 3d 3d 00 00    	mov    %eax,0x3d3d(%rip)        # 45004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   412c7:	eb 0f                	jmp    412d8 <memshow_virtual_animate+0x51>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
        ++showing;
   412c9:	8b 05 35 3d 00 00    	mov    0x3d35(%rip),%eax        # 45004 <showing.0>
   412cf:	83 c0 01             	add    $0x1,%eax
   412d2:	89 05 2c 3d 00 00    	mov    %eax,0x3d2c(%rip)        # 45004 <showing.0>
    while (showing <= 2*NPROC
   412d8:	8b 05 26 3d 00 00    	mov    0x3d26(%rip),%eax        # 45004 <showing.0>
           && (processes[showing % NPROC].p_state == P_FREE || processes[showing % NPROC].display_status == 0)) {
   412de:	83 f8 20             	cmp    $0x20,%eax
   412e1:	7f 6d                	jg     41350 <memshow_virtual_animate+0xc9>
   412e3:	8b 15 1b 3d 00 00    	mov    0x3d1b(%rip),%edx        # 45004 <showing.0>
   412e9:	89 d0                	mov    %edx,%eax
   412eb:	c1 f8 1f             	sar    $0x1f,%eax
   412ee:	c1 e8 1c             	shr    $0x1c,%eax
   412f1:	01 c2                	add    %eax,%edx
   412f3:	83 e2 0f             	and    $0xf,%edx
   412f6:	29 c2                	sub    %eax,%edx
   412f8:	89 d0                	mov    %edx,%eax
   412fa:	48 63 d0             	movslq %eax,%rdx
   412fd:	48 89 d0             	mov    %rdx,%rax
   41300:	48 c1 e0 03          	shl    $0x3,%rax
   41304:	48 29 d0             	sub    %rdx,%rax
   41307:	48 c1 e0 05          	shl    $0x5,%rax
   4130b:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   41311:	8b 00                	mov    (%rax),%eax
   41313:	85 c0                	test   %eax,%eax
   41315:	74 b2                	je     412c9 <memshow_virtual_animate+0x42>
   41317:	8b 15 e7 3c 00 00    	mov    0x3ce7(%rip),%edx        # 45004 <showing.0>
   4131d:	89 d0                	mov    %edx,%eax
   4131f:	c1 f8 1f             	sar    $0x1f,%eax
   41322:	c1 e8 1c             	shr    $0x1c,%eax
   41325:	01 c2                	add    %eax,%edx
   41327:	83 e2 0f             	and    $0xf,%edx
   4132a:	29 c2                	sub    %eax,%edx
   4132c:	89 d0                	mov    %edx,%eax
   4132e:	48 63 d0             	movslq %eax,%rdx
   41331:	48 89 d0             	mov    %rdx,%rax
   41334:	48 c1 e0 03          	shl    $0x3,%rax
   41338:	48 29 d0             	sub    %rdx,%rax
   4133b:	48 c1 e0 05          	shl    $0x5,%rax
   4133f:	48 05 f8 10 05 00    	add    $0x510f8,%rax
   41345:	0f b6 00             	movzbl (%rax),%eax
   41348:	84 c0                	test   %al,%al
   4134a:	0f 84 79 ff ff ff    	je     412c9 <memshow_virtual_animate+0x42>
    }
    showing = showing % NPROC;
   41350:	8b 15 ae 3c 00 00    	mov    0x3cae(%rip),%edx        # 45004 <showing.0>
   41356:	89 d0                	mov    %edx,%eax
   41358:	c1 f8 1f             	sar    $0x1f,%eax
   4135b:	c1 e8 1c             	shr    $0x1c,%eax
   4135e:	01 c2                	add    %eax,%edx
   41360:	83 e2 0f             	and    $0xf,%edx
   41363:	29 c2                	sub    %eax,%edx
   41365:	89 d0                	mov    %edx,%eax
   41367:	89 05 97 3c 00 00    	mov    %eax,0x3c97(%rip)        # 45004 <showing.0>

    if (processes[showing].p_state != P_FREE) {
   4136d:	8b 05 91 3c 00 00    	mov    0x3c91(%rip),%eax        # 45004 <showing.0>
   41373:	48 63 d0             	movslq %eax,%rdx
   41376:	48 89 d0             	mov    %rdx,%rax
   41379:	48 c1 e0 03          	shl    $0x3,%rax
   4137d:	48 29 d0             	sub    %rdx,%rax
   41380:	48 c1 e0 05          	shl    $0x5,%rax
   41384:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   4138a:	8b 00                	mov    (%rax),%eax
   4138c:	85 c0                	test   %eax,%eax
   4138e:	74 52                	je     413e2 <memshow_virtual_animate+0x15b>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   41390:	8b 15 6e 3c 00 00    	mov    0x3c6e(%rip),%edx        # 45004 <showing.0>
   41396:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   4139a:	89 d1                	mov    %edx,%ecx
   4139c:	ba e4 41 04 00       	mov    $0x441e4,%edx
   413a1:	be 04 00 00 00       	mov    $0x4,%esi
   413a6:	48 89 c7             	mov    %rax,%rdi
   413a9:	b8 00 00 00 00       	mov    $0x0,%eax
   413ae:	e8 8c 29 00 00       	call   43d3f <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   413b3:	8b 05 4b 3c 00 00    	mov    0x3c4b(%rip),%eax        # 45004 <showing.0>
   413b9:	48 63 d0             	movslq %eax,%rdx
   413bc:	48 89 d0             	mov    %rdx,%rax
   413bf:	48 c1 e0 03          	shl    $0x3,%rax
   413c3:	48 29 d0             	sub    %rdx,%rax
   413c6:	48 c1 e0 05          	shl    $0x5,%rax
   413ca:	48 05 f0 10 05 00    	add    $0x510f0,%rax
   413d0:	48 8b 00             	mov    (%rax),%rax
   413d3:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   413d7:	48 89 d6             	mov    %rdx,%rsi
   413da:	48 89 c7             	mov    %rax,%rdi
   413dd:	e8 ac fc ff ff       	call   4108e <memshow_virtual>
    }
}
   413e2:	90                   	nop
   413e3:	c9                   	leave  
   413e4:	c3                   	ret    

00000000000413e5 <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   413e5:	55                   	push   %rbp
   413e6:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   413e9:	e8 4f 01 00 00       	call   4153d <segments_init>
    interrupt_init();
   413ee:	e8 d0 03 00 00       	call   417c3 <interrupt_init>
    virtual_memory_init();
   413f3:	e8 f3 0f 00 00       	call   423eb <virtual_memory_init>
}
   413f8:	90                   	nop
   413f9:	5d                   	pop    %rbp
   413fa:	c3                   	ret    

00000000000413fb <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   413fb:	55                   	push   %rbp
   413fc:	48 89 e5             	mov    %rsp,%rbp
   413ff:	48 83 ec 18          	sub    $0x18,%rsp
   41403:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41407:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   4140b:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   4140e:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41411:	48 98                	cltq   
   41413:	48 c1 e0 2d          	shl    $0x2d,%rax
   41417:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   4141b:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   41422:	90 00 00 
   41425:	48 09 c2             	or     %rax,%rdx
    *segment = type
   41428:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4142c:	48 89 10             	mov    %rdx,(%rax)
}
   4142f:	90                   	nop
   41430:	c9                   	leave  
   41431:	c3                   	ret    

0000000000041432 <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   41432:	55                   	push   %rbp
   41433:	48 89 e5             	mov    %rsp,%rbp
   41436:	48 83 ec 28          	sub    $0x28,%rsp
   4143a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4143e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41442:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41445:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   41449:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   4144d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41451:	48 c1 e0 10          	shl    $0x10,%rax
   41455:	48 89 c2             	mov    %rax,%rdx
   41458:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   4145f:	00 00 00 
   41462:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   41465:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41469:	48 c1 e0 20          	shl    $0x20,%rax
   4146d:	48 89 c1             	mov    %rax,%rcx
   41470:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   41477:	00 00 ff 
   4147a:	48 21 c8             	and    %rcx,%rax
   4147d:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   41480:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41484:	48 83 e8 01          	sub    $0x1,%rax
   41488:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   4148b:	48 09 d0             	or     %rdx,%rax
        | type
   4148e:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   41492:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41495:	48 63 d2             	movslq %edx,%rdx
   41498:	48 c1 e2 2d          	shl    $0x2d,%rdx
   4149c:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   4149f:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   414a6:	80 00 00 
   414a9:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   414ac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   414b0:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   414b3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   414b7:	48 83 c0 08          	add    $0x8,%rax
   414bb:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   414bf:	48 c1 ea 20          	shr    $0x20,%rdx
   414c3:	48 89 10             	mov    %rdx,(%rax)
}
   414c6:	90                   	nop
   414c7:	c9                   	leave  
   414c8:	c3                   	ret    

00000000000414c9 <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   414c9:	55                   	push   %rbp
   414ca:	48 89 e5             	mov    %rsp,%rbp
   414cd:	48 83 ec 20          	sub    $0x20,%rsp
   414d1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   414d5:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   414d9:	89 55 ec             	mov    %edx,-0x14(%rbp)
   414dc:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   414e0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   414e4:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   414e7:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   414eb:	8b 55 ec             	mov    -0x14(%rbp),%edx
   414ee:	48 63 d2             	movslq %edx,%rdx
   414f1:	48 c1 e2 2d          	shl    $0x2d,%rdx
   414f5:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   414f8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   414fc:	48 c1 e0 20          	shl    $0x20,%rax
   41500:	48 89 c1             	mov    %rax,%rcx
   41503:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   4150a:	00 ff ff 
   4150d:	48 21 c8             	and    %rcx,%rax
   41510:	48 09 c2             	or     %rax,%rdx
   41513:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   4151a:	80 00 00 
   4151d:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41520:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41524:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   41527:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4152b:	48 c1 e8 20          	shr    $0x20,%rax
   4152f:	48 89 c2             	mov    %rax,%rdx
   41532:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41536:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   4153a:	90                   	nop
   4153b:	c9                   	leave  
   4153c:	c3                   	ret    

000000000004153d <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   4153d:	55                   	push   %rbp
   4153e:	48 89 e5             	mov    %rsp,%rbp
   41541:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   41545:	48 c7 05 10 0d 01 00 	movq   $0x0,0x10d10(%rip)        # 52260 <segments>
   4154c:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   41550:	ba 00 00 00 00       	mov    $0x0,%edx
   41555:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   4155c:	08 20 00 
   4155f:	48 89 c6             	mov    %rax,%rsi
   41562:	bf 68 22 05 00       	mov    $0x52268,%edi
   41567:	e8 8f fe ff ff       	call   413fb <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   4156c:	ba 03 00 00 00       	mov    $0x3,%edx
   41571:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41578:	08 20 00 
   4157b:	48 89 c6             	mov    %rax,%rsi
   4157e:	bf 70 22 05 00       	mov    $0x52270,%edi
   41583:	e8 73 fe ff ff       	call   413fb <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   41588:	ba 00 00 00 00       	mov    $0x0,%edx
   4158d:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41594:	02 00 00 
   41597:	48 89 c6             	mov    %rax,%rsi
   4159a:	bf 78 22 05 00       	mov    $0x52278,%edi
   4159f:	e8 57 fe ff ff       	call   413fb <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   415a4:	ba 03 00 00 00       	mov    $0x3,%edx
   415a9:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   415b0:	02 00 00 
   415b3:	48 89 c6             	mov    %rax,%rsi
   415b6:	bf 80 22 05 00       	mov    $0x52280,%edi
   415bb:	e8 3b fe ff ff       	call   413fb <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   415c0:	b8 a0 32 05 00       	mov    $0x532a0,%eax
   415c5:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   415cb:	48 89 c1             	mov    %rax,%rcx
   415ce:	ba 00 00 00 00       	mov    $0x0,%edx
   415d3:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   415da:	09 00 00 
   415dd:	48 89 c6             	mov    %rax,%rsi
   415e0:	bf 88 22 05 00       	mov    $0x52288,%edi
   415e5:	e8 48 fe ff ff       	call   41432 <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   415ea:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   415f0:	b8 60 22 05 00       	mov    $0x52260,%eax
   415f5:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   415f9:	ba 60 00 00 00       	mov    $0x60,%edx
   415fe:	be 00 00 00 00       	mov    $0x0,%esi
   41603:	bf a0 32 05 00       	mov    $0x532a0,%edi
   41608:	e8 6f 18 00 00       	call   42e7c <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   4160d:	48 c7 05 8c 1c 01 00 	movq   $0x80000,0x11c8c(%rip)        # 532a4 <kernel_task_descriptor+0x4>
   41614:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   41618:	ba 00 10 00 00       	mov    $0x1000,%edx
   4161d:	be 00 00 00 00       	mov    $0x0,%esi
   41622:	bf a0 22 05 00       	mov    $0x522a0,%edi
   41627:	e8 50 18 00 00       	call   42e7c <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   4162c:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   41633:	eb 30                	jmp    41665 <segments_init+0x128>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   41635:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   4163a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4163d:	48 c1 e0 04          	shl    $0x4,%rax
   41641:	48 05 a0 22 05 00    	add    $0x522a0,%rax
   41647:	48 89 d1             	mov    %rdx,%rcx
   4164a:	ba 00 00 00 00       	mov    $0x0,%edx
   4164f:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41656:	0e 00 00 
   41659:	48 89 c7             	mov    %rax,%rdi
   4165c:	e8 68 fe ff ff       	call   414c9 <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41661:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41665:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   4166c:	76 c7                	jbe    41635 <segments_init+0xf8>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   4166e:	b8 36 00 04 00       	mov    $0x40036,%eax
   41673:	48 89 c1             	mov    %rax,%rcx
   41676:	ba 00 00 00 00       	mov    $0x0,%edx
   4167b:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41682:	0e 00 00 
   41685:	48 89 c6             	mov    %rax,%rsi
   41688:	bf a0 24 05 00       	mov    $0x524a0,%edi
   4168d:	e8 37 fe ff ff       	call   414c9 <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   41692:	b8 2e 00 04 00       	mov    $0x4002e,%eax
   41697:	48 89 c1             	mov    %rax,%rcx
   4169a:	ba 00 00 00 00       	mov    $0x0,%edx
   4169f:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   416a6:	0e 00 00 
   416a9:	48 89 c6             	mov    %rax,%rsi
   416ac:	bf 70 23 05 00       	mov    $0x52370,%edi
   416b1:	e8 13 fe ff ff       	call   414c9 <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   416b6:	b8 32 00 04 00       	mov    $0x40032,%eax
   416bb:	48 89 c1             	mov    %rax,%rcx
   416be:	ba 00 00 00 00       	mov    $0x0,%edx
   416c3:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   416ca:	0e 00 00 
   416cd:	48 89 c6             	mov    %rax,%rsi
   416d0:	bf 80 23 05 00       	mov    $0x52380,%edi
   416d5:	e8 ef fd ff ff       	call   414c9 <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   416da:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   416e1:	eb 3e                	jmp    41721 <segments_init+0x1e4>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   416e3:	8b 45 f8             	mov    -0x8(%rbp),%eax
   416e6:	83 e8 30             	sub    $0x30,%eax
   416e9:	89 c0                	mov    %eax,%eax
   416eb:	48 8b 04 c5 e7 00 04 	mov    0x400e7(,%rax,8),%rax
   416f2:	00 
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   416f3:	48 89 c2             	mov    %rax,%rdx
   416f6:	8b 45 f8             	mov    -0x8(%rbp),%eax
   416f9:	48 c1 e0 04          	shl    $0x4,%rax
   416fd:	48 05 a0 22 05 00    	add    $0x522a0,%rax
   41703:	48 89 d1             	mov    %rdx,%rcx
   41706:	ba 03 00 00 00       	mov    $0x3,%edx
   4170b:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41712:	0e 00 00 
   41715:	48 89 c7             	mov    %rax,%rdi
   41718:	e8 ac fd ff ff       	call   414c9 <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   4171d:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41721:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   41725:	76 bc                	jbe    416e3 <segments_init+0x1a6>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   41727:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   4172d:	b8 a0 22 05 00       	mov    $0x522a0,%eax
   41732:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   41736:	b8 28 00 00 00       	mov    $0x28,%eax
   4173b:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   4173f:	0f 00 d8             	ltr    %ax
   41742:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   41746:	0f 20 c0             	mov    %cr0,%rax
   41749:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   4174d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   41751:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   41754:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   4175b:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4175e:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   41761:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41764:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   41768:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4176c:	0f 22 c0             	mov    %rax,%cr0
}
   4176f:	90                   	nop
    lcr0(cr0);
}
   41770:	90                   	nop
   41771:	c9                   	leave  
   41772:	c3                   	ret    

0000000000041773 <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   41773:	55                   	push   %rbp
   41774:	48 89 e5             	mov    %rsp,%rbp
   41777:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   4177b:	0f b7 05 7e 1b 01 00 	movzwl 0x11b7e(%rip),%eax        # 53300 <interrupts_enabled>
   41782:	f7 d0                	not    %eax
   41784:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   41788:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   4178c:	0f b6 c0             	movzbl %al,%eax
   4178f:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   41796:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41799:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   4179d:	8b 55 f0             	mov    -0x10(%rbp),%edx
   417a0:	ee                   	out    %al,(%dx)
}
   417a1:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   417a2:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   417a6:	66 c1 e8 08          	shr    $0x8,%ax
   417aa:	0f b6 c0             	movzbl %al,%eax
   417ad:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   417b4:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   417b7:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   417bb:	8b 55 f8             	mov    -0x8(%rbp),%edx
   417be:	ee                   	out    %al,(%dx)
}
   417bf:	90                   	nop
}
   417c0:	90                   	nop
   417c1:	c9                   	leave  
   417c2:	c3                   	ret    

00000000000417c3 <interrupt_init>:

void interrupt_init(void) {
   417c3:	55                   	push   %rbp
   417c4:	48 89 e5             	mov    %rsp,%rbp
   417c7:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   417cb:	66 c7 05 2c 1b 01 00 	movw   $0x0,0x11b2c(%rip)        # 53300 <interrupts_enabled>
   417d2:	00 00 
    interrupt_mask();
   417d4:	e8 9a ff ff ff       	call   41773 <interrupt_mask>
   417d9:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   417e0:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   417e4:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   417e8:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   417eb:	ee                   	out    %al,(%dx)
}
   417ec:	90                   	nop
   417ed:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   417f4:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   417f8:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   417fc:	8b 55 ac             	mov    -0x54(%rbp),%edx
   417ff:	ee                   	out    %al,(%dx)
}
   41800:	90                   	nop
   41801:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   41808:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4180c:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   41810:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   41813:	ee                   	out    %al,(%dx)
}
   41814:	90                   	nop
   41815:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   4181c:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41820:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   41824:	8b 55 bc             	mov    -0x44(%rbp),%edx
   41827:	ee                   	out    %al,(%dx)
}
   41828:	90                   	nop
   41829:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   41830:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41834:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   41838:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   4183b:	ee                   	out    %al,(%dx)
}
   4183c:	90                   	nop
   4183d:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   41844:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41848:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   4184c:	8b 55 cc             	mov    -0x34(%rbp),%edx
   4184f:	ee                   	out    %al,(%dx)
}
   41850:	90                   	nop
   41851:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   41858:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4185c:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   41860:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   41863:	ee                   	out    %al,(%dx)
}
   41864:	90                   	nop
   41865:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   4186c:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41870:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   41874:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41877:	ee                   	out    %al,(%dx)
}
   41878:	90                   	nop
   41879:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   41880:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41884:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41888:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   4188b:	ee                   	out    %al,(%dx)
}
   4188c:	90                   	nop
   4188d:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   41894:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41898:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   4189c:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4189f:	ee                   	out    %al,(%dx)
}
   418a0:	90                   	nop
   418a1:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   418a8:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   418ac:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   418b0:	8b 55 f4             	mov    -0xc(%rbp),%edx
   418b3:	ee                   	out    %al,(%dx)
}
   418b4:	90                   	nop
   418b5:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   418bc:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   418c0:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   418c4:	8b 55 fc             	mov    -0x4(%rbp),%edx
   418c7:	ee                   	out    %al,(%dx)
}
   418c8:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   418c9:	e8 a5 fe ff ff       	call   41773 <interrupt_mask>
}
   418ce:	90                   	nop
   418cf:	c9                   	leave  
   418d0:	c3                   	ret    

00000000000418d1 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   418d1:	55                   	push   %rbp
   418d2:	48 89 e5             	mov    %rsp,%rbp
   418d5:	48 83 ec 28          	sub    $0x28,%rsp
   418d9:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   418dc:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   418e0:	0f 8e 9e 00 00 00    	jle    41984 <timer_init+0xb3>
   418e6:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   418ed:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   418f1:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   418f5:	8b 55 ec             	mov    -0x14(%rbp),%edx
   418f8:	ee                   	out    %al,(%dx)
}
   418f9:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   418fa:	8b 45 dc             	mov    -0x24(%rbp),%eax
   418fd:	89 c2                	mov    %eax,%edx
   418ff:	c1 ea 1f             	shr    $0x1f,%edx
   41902:	01 d0                	add    %edx,%eax
   41904:	d1 f8                	sar    %eax
   41906:	05 de 34 12 00       	add    $0x1234de,%eax
   4190b:	99                   	cltd   
   4190c:	f7 7d dc             	idivl  -0x24(%rbp)
   4190f:	89 c2                	mov    %eax,%edx
   41911:	89 d0                	mov    %edx,%eax
   41913:	c1 f8 1f             	sar    $0x1f,%eax
   41916:	c1 e8 18             	shr    $0x18,%eax
   41919:	01 c2                	add    %eax,%edx
   4191b:	0f b6 d2             	movzbl %dl,%edx
   4191e:	29 c2                	sub    %eax,%edx
   41920:	89 d0                	mov    %edx,%eax
   41922:	0f b6 c0             	movzbl %al,%eax
   41925:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   4192c:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4192f:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41933:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41936:	ee                   	out    %al,(%dx)
}
   41937:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   41938:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4193b:	89 c2                	mov    %eax,%edx
   4193d:	c1 ea 1f             	shr    $0x1f,%edx
   41940:	01 d0                	add    %edx,%eax
   41942:	d1 f8                	sar    %eax
   41944:	05 de 34 12 00       	add    $0x1234de,%eax
   41949:	99                   	cltd   
   4194a:	f7 7d dc             	idivl  -0x24(%rbp)
   4194d:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41953:	85 c0                	test   %eax,%eax
   41955:	0f 48 c2             	cmovs  %edx,%eax
   41958:	c1 f8 08             	sar    $0x8,%eax
   4195b:	0f b6 c0             	movzbl %al,%eax
   4195e:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   41965:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41968:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4196c:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4196f:	ee                   	out    %al,(%dx)
}
   41970:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   41971:	0f b7 05 88 19 01 00 	movzwl 0x11988(%rip),%eax        # 53300 <interrupts_enabled>
   41978:	83 c8 01             	or     $0x1,%eax
   4197b:	66 89 05 7e 19 01 00 	mov    %ax,0x1197e(%rip)        # 53300 <interrupts_enabled>
   41982:	eb 11                	jmp    41995 <timer_init+0xc4>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   41984:	0f b7 05 75 19 01 00 	movzwl 0x11975(%rip),%eax        # 53300 <interrupts_enabled>
   4198b:	83 e0 fe             	and    $0xfffffffe,%eax
   4198e:	66 89 05 6b 19 01 00 	mov    %ax,0x1196b(%rip)        # 53300 <interrupts_enabled>
    }
    interrupt_mask();
   41995:	e8 d9 fd ff ff       	call   41773 <interrupt_mask>
}
   4199a:	90                   	nop
   4199b:	c9                   	leave  
   4199c:	c3                   	ret    

000000000004199d <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   4199d:	55                   	push   %rbp
   4199e:	48 89 e5             	mov    %rsp,%rbp
   419a1:	48 83 ec 08          	sub    $0x8,%rsp
   419a5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   419a9:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   419ae:	74 14                	je     419c4 <physical_memory_isreserved+0x27>
   419b0:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   419b7:	00 
   419b8:	76 11                	jbe    419cb <physical_memory_isreserved+0x2e>
   419ba:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   419c1:	00 
   419c2:	77 07                	ja     419cb <physical_memory_isreserved+0x2e>
   419c4:	b8 01 00 00 00       	mov    $0x1,%eax
   419c9:	eb 05                	jmp    419d0 <physical_memory_isreserved+0x33>
   419cb:	b8 00 00 00 00       	mov    $0x0,%eax
}
   419d0:	c9                   	leave  
   419d1:	c3                   	ret    

00000000000419d2 <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   419d2:	55                   	push   %rbp
   419d3:	48 89 e5             	mov    %rsp,%rbp
   419d6:	48 83 ec 10          	sub    $0x10,%rsp
   419da:	89 7d fc             	mov    %edi,-0x4(%rbp)
   419dd:	89 75 f8             	mov    %esi,-0x8(%rbp)
   419e0:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   419e3:	8b 45 fc             	mov    -0x4(%rbp),%eax
   419e6:	c1 e0 10             	shl    $0x10,%eax
   419e9:	89 c2                	mov    %eax,%edx
   419eb:	8b 45 f8             	mov    -0x8(%rbp),%eax
   419ee:	c1 e0 0b             	shl    $0xb,%eax
   419f1:	09 c2                	or     %eax,%edx
   419f3:	8b 45 f4             	mov    -0xc(%rbp),%eax
   419f6:	c1 e0 08             	shl    $0x8,%eax
   419f9:	09 d0                	or     %edx,%eax
}
   419fb:	c9                   	leave  
   419fc:	c3                   	ret    

00000000000419fd <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   419fd:	55                   	push   %rbp
   419fe:	48 89 e5             	mov    %rsp,%rbp
   41a01:	48 83 ec 18          	sub    $0x18,%rsp
   41a05:	89 7d ec             	mov    %edi,-0x14(%rbp)
   41a08:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   41a0b:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41a0e:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41a11:	09 d0                	or     %edx,%eax
   41a13:	0d 00 00 00 80       	or     $0x80000000,%eax
   41a18:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   41a1f:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   41a22:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41a25:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41a28:	ef                   	out    %eax,(%dx)
}
   41a29:	90                   	nop
   41a2a:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   41a31:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41a34:	89 c2                	mov    %eax,%edx
   41a36:	ed                   	in     (%dx),%eax
   41a37:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   41a3a:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   41a3d:	c9                   	leave  
   41a3e:	c3                   	ret    

0000000000041a3f <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   41a3f:	55                   	push   %rbp
   41a40:	48 89 e5             	mov    %rsp,%rbp
   41a43:	48 83 ec 28          	sub    $0x28,%rsp
   41a47:	89 7d dc             	mov    %edi,-0x24(%rbp)
   41a4a:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   41a4d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41a54:	eb 73                	jmp    41ac9 <pci_find_device+0x8a>
        for (int slot = 0; slot != 32; ++slot) {
   41a56:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41a5d:	eb 60                	jmp    41abf <pci_find_device+0x80>
            for (int func = 0; func != 8; ++func) {
   41a5f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41a66:	eb 4a                	jmp    41ab2 <pci_find_device+0x73>
                int configaddr = pci_make_configaddr(bus, slot, func);
   41a68:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41a6b:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41a6e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41a71:	89 ce                	mov    %ecx,%esi
   41a73:	89 c7                	mov    %eax,%edi
   41a75:	e8 58 ff ff ff       	call   419d2 <pci_make_configaddr>
   41a7a:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   41a7d:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41a80:	be 00 00 00 00       	mov    $0x0,%esi
   41a85:	89 c7                	mov    %eax,%edi
   41a87:	e8 71 ff ff ff       	call   419fd <pci_config_readl>
   41a8c:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   41a8f:	8b 45 d8             	mov    -0x28(%rbp),%eax
   41a92:	c1 e0 10             	shl    $0x10,%eax
   41a95:	0b 45 dc             	or     -0x24(%rbp),%eax
   41a98:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   41a9b:	75 05                	jne    41aa2 <pci_find_device+0x63>
                    return configaddr;
   41a9d:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41aa0:	eb 35                	jmp    41ad7 <pci_find_device+0x98>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   41aa2:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   41aa6:	75 06                	jne    41aae <pci_find_device+0x6f>
   41aa8:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41aac:	74 0c                	je     41aba <pci_find_device+0x7b>
            for (int func = 0; func != 8; ++func) {
   41aae:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41ab2:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   41ab6:	75 b0                	jne    41a68 <pci_find_device+0x29>
   41ab8:	eb 01                	jmp    41abb <pci_find_device+0x7c>
                    break;
   41aba:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   41abb:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41abf:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   41ac3:	75 9a                	jne    41a5f <pci_find_device+0x20>
    for (int bus = 0; bus != 256; ++bus) {
   41ac5:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41ac9:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   41ad0:	75 84                	jne    41a56 <pci_find_device+0x17>
                }
            }
        }
    }
    return -1;
   41ad2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   41ad7:	c9                   	leave  
   41ad8:	c3                   	ret    

0000000000041ad9 <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   41ad9:	55                   	push   %rbp
   41ada:	48 89 e5             	mov    %rsp,%rbp
   41add:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   41ae1:	be 13 71 00 00       	mov    $0x7113,%esi
   41ae6:	bf 86 80 00 00       	mov    $0x8086,%edi
   41aeb:	e8 4f ff ff ff       	call   41a3f <pci_find_device>
   41af0:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   41af3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   41af7:	78 30                	js     41b29 <poweroff+0x50>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   41af9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41afc:	be 40 00 00 00       	mov    $0x40,%esi
   41b01:	89 c7                	mov    %eax,%edi
   41b03:	e8 f5 fe ff ff       	call   419fd <pci_config_readl>
   41b08:	25 c0 ff 00 00       	and    $0xffc0,%eax
   41b0d:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   41b10:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41b13:	83 c0 04             	add    $0x4,%eax
   41b16:	89 45 f4             	mov    %eax,-0xc(%rbp)
   41b19:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   41b1f:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   41b23:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41b26:	66 ef                	out    %ax,(%dx)
}
   41b28:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   41b29:	ba 00 42 04 00       	mov    $0x44200,%edx
   41b2e:	be 00 c0 00 00       	mov    $0xc000,%esi
   41b33:	bf 80 07 00 00       	mov    $0x780,%edi
   41b38:	b8 00 00 00 00       	mov    $0x0,%eax
   41b3d:	e8 f1 20 00 00       	call   43c33 <console_printf>
 spinloop: goto spinloop;
   41b42:	eb fe                	jmp    41b42 <poweroff+0x69>

0000000000041b44 <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   41b44:	55                   	push   %rbp
   41b45:	48 89 e5             	mov    %rsp,%rbp
   41b48:	48 83 ec 10          	sub    $0x10,%rsp
   41b4c:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   41b53:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b57:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41b5b:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41b5e:	ee                   	out    %al,(%dx)
}
   41b5f:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   41b60:	eb fe                	jmp    41b60 <reboot+0x1c>

0000000000041b62 <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   41b62:	55                   	push   %rbp
   41b63:	48 89 e5             	mov    %rsp,%rbp
   41b66:	48 83 ec 10          	sub    $0x10,%rsp
   41b6a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41b6e:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   41b71:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41b75:	48 83 c0 08          	add    $0x8,%rax
   41b79:	ba c0 00 00 00       	mov    $0xc0,%edx
   41b7e:	be 00 00 00 00       	mov    $0x0,%esi
   41b83:	48 89 c7             	mov    %rax,%rdi
   41b86:	e8 f1 12 00 00       	call   42e7c <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   41b8b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41b8f:	66 c7 80 a8 00 00 00 	movw   $0x13,0xa8(%rax)
   41b96:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   41b98:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41b9c:	48 c7 80 80 00 00 00 	movq   $0x23,0x80(%rax)
   41ba3:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   41ba7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41bab:	48 c7 80 88 00 00 00 	movq   $0x23,0x88(%rax)
   41bb2:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   41bb6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41bba:	66 c7 80 c0 00 00 00 	movw   $0x23,0xc0(%rax)
   41bc1:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   41bc3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41bc7:	48 c7 80 b0 00 00 00 	movq   $0x200,0xb0(%rax)
   41bce:	00 02 00 00 
    p->display_status = 1;
   41bd2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41bd6:	c6 80 d8 00 00 00 01 	movb   $0x1,0xd8(%rax)

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   41bdd:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41be0:	83 e0 01             	and    $0x1,%eax
   41be3:	85 c0                	test   %eax,%eax
   41be5:	74 1c                	je     41c03 <process_init+0xa1>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   41be7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41beb:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   41bf2:	80 cc 30             	or     $0x30,%ah
   41bf5:	48 89 c2             	mov    %rax,%rdx
   41bf8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41bfc:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   41c03:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41c06:	83 e0 02             	and    $0x2,%eax
   41c09:	85 c0                	test   %eax,%eax
   41c0b:	74 1c                	je     41c29 <process_init+0xc7>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   41c0d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41c11:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   41c18:	80 e4 fd             	and    $0xfd,%ah
   41c1b:	48 89 c2             	mov    %rax,%rdx
   41c1e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41c22:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
}
   41c29:	90                   	nop
   41c2a:	c9                   	leave  
   41c2b:	c3                   	ret    

0000000000041c2c <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   41c2c:	55                   	push   %rbp
   41c2d:	48 89 e5             	mov    %rsp,%rbp
   41c30:	48 83 ec 28          	sub    $0x28,%rsp
   41c34:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   41c37:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41c3b:	78 09                	js     41c46 <console_show_cursor+0x1a>
   41c3d:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   41c44:	7e 07                	jle    41c4d <console_show_cursor+0x21>
        cpos = 0;
   41c46:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   41c4d:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   41c54:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c58:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41c5c:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41c5f:	ee                   	out    %al,(%dx)
}
   41c60:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   41c61:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41c64:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41c6a:	85 c0                	test   %eax,%eax
   41c6c:	0f 48 c2             	cmovs  %edx,%eax
   41c6f:	c1 f8 08             	sar    $0x8,%eax
   41c72:	0f b6 c0             	movzbl %al,%eax
   41c75:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   41c7c:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c7f:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41c83:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41c86:	ee                   	out    %al,(%dx)
}
   41c87:	90                   	nop
   41c88:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   41c8f:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c93:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41c97:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41c9a:	ee                   	out    %al,(%dx)
}
   41c9b:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   41c9c:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41c9f:	89 d0                	mov    %edx,%eax
   41ca1:	c1 f8 1f             	sar    $0x1f,%eax
   41ca4:	c1 e8 18             	shr    $0x18,%eax
   41ca7:	01 c2                	add    %eax,%edx
   41ca9:	0f b6 d2             	movzbl %dl,%edx
   41cac:	29 c2                	sub    %eax,%edx
   41cae:	89 d0                	mov    %edx,%eax
   41cb0:	0f b6 c0             	movzbl %al,%eax
   41cb3:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   41cba:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41cbd:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41cc1:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41cc4:	ee                   	out    %al,(%dx)
}
   41cc5:	90                   	nop
}
   41cc6:	90                   	nop
   41cc7:	c9                   	leave  
   41cc8:	c3                   	ret    

0000000000041cc9 <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   41cc9:	55                   	push   %rbp
   41cca:	48 89 e5             	mov    %rsp,%rbp
   41ccd:	48 83 ec 20          	sub    $0x20,%rsp
   41cd1:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41cd8:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41cdb:	89 c2                	mov    %eax,%edx
   41cdd:	ec                   	in     (%dx),%al
   41cde:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   41ce1:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   41ce5:	0f b6 c0             	movzbl %al,%eax
   41ce8:	83 e0 01             	and    $0x1,%eax
   41ceb:	85 c0                	test   %eax,%eax
   41ced:	75 0a                	jne    41cf9 <keyboard_readc+0x30>
        return -1;
   41cef:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   41cf4:	e9 e7 01 00 00       	jmp    41ee0 <keyboard_readc+0x217>
   41cf9:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41d00:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41d03:	89 c2                	mov    %eax,%edx
   41d05:	ec                   	in     (%dx),%al
   41d06:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   41d09:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   41d0d:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   41d10:	0f b6 05 eb 15 01 00 	movzbl 0x115eb(%rip),%eax        # 53302 <last_escape.2>
   41d17:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   41d1a:	c6 05 e1 15 01 00 00 	movb   $0x0,0x115e1(%rip)        # 53302 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   41d21:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   41d25:	75 11                	jne    41d38 <keyboard_readc+0x6f>
        last_escape = 0x80;
   41d27:	c6 05 d4 15 01 00 80 	movb   $0x80,0x115d4(%rip)        # 53302 <last_escape.2>
        return 0;
   41d2e:	b8 00 00 00 00       	mov    $0x0,%eax
   41d33:	e9 a8 01 00 00       	jmp    41ee0 <keyboard_readc+0x217>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   41d38:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41d3c:	84 c0                	test   %al,%al
   41d3e:	79 60                	jns    41da0 <keyboard_readc+0xd7>
        int ch = keymap[(data & 0x7F) | escape];
   41d40:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41d44:	83 e0 7f             	and    $0x7f,%eax
   41d47:	89 c2                	mov    %eax,%edx
   41d49:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   41d4d:	09 d0                	or     %edx,%eax
   41d4f:	48 98                	cltq   
   41d51:	0f b6 80 20 42 04 00 	movzbl 0x44220(%rax),%eax
   41d58:	0f b6 c0             	movzbl %al,%eax
   41d5b:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   41d5e:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   41d65:	7e 2f                	jle    41d96 <keyboard_readc+0xcd>
   41d67:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   41d6e:	7f 26                	jg     41d96 <keyboard_readc+0xcd>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   41d70:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41d73:	2d fa 00 00 00       	sub    $0xfa,%eax
   41d78:	ba 01 00 00 00       	mov    $0x1,%edx
   41d7d:	89 c1                	mov    %eax,%ecx
   41d7f:	d3 e2                	shl    %cl,%edx
   41d81:	89 d0                	mov    %edx,%eax
   41d83:	f7 d0                	not    %eax
   41d85:	89 c2                	mov    %eax,%edx
   41d87:	0f b6 05 75 15 01 00 	movzbl 0x11575(%rip),%eax        # 53303 <modifiers.1>
   41d8e:	21 d0                	and    %edx,%eax
   41d90:	88 05 6d 15 01 00    	mov    %al,0x1156d(%rip)        # 53303 <modifiers.1>
        }
        return 0;
   41d96:	b8 00 00 00 00       	mov    $0x0,%eax
   41d9b:	e9 40 01 00 00       	jmp    41ee0 <keyboard_readc+0x217>
    }

    int ch = (unsigned char) keymap[data | escape];
   41da0:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41da4:	0a 45 fa             	or     -0x6(%rbp),%al
   41da7:	0f b6 c0             	movzbl %al,%eax
   41daa:	48 98                	cltq   
   41dac:	0f b6 80 20 42 04 00 	movzbl 0x44220(%rax),%eax
   41db3:	0f b6 c0             	movzbl %al,%eax
   41db6:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   41db9:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   41dbd:	7e 57                	jle    41e16 <keyboard_readc+0x14d>
   41dbf:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   41dc3:	7f 51                	jg     41e16 <keyboard_readc+0x14d>
        if (modifiers & MOD_CONTROL) {
   41dc5:	0f b6 05 37 15 01 00 	movzbl 0x11537(%rip),%eax        # 53303 <modifiers.1>
   41dcc:	0f b6 c0             	movzbl %al,%eax
   41dcf:	83 e0 02             	and    $0x2,%eax
   41dd2:	85 c0                	test   %eax,%eax
   41dd4:	74 09                	je     41ddf <keyboard_readc+0x116>
            ch -= 0x60;
   41dd6:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   41dda:	e9 fd 00 00 00       	jmp    41edc <keyboard_readc+0x213>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   41ddf:	0f b6 05 1d 15 01 00 	movzbl 0x1151d(%rip),%eax        # 53303 <modifiers.1>
   41de6:	0f b6 c0             	movzbl %al,%eax
   41de9:	83 e0 01             	and    $0x1,%eax
   41dec:	85 c0                	test   %eax,%eax
   41dee:	0f 94 c2             	sete   %dl
   41df1:	0f b6 05 0b 15 01 00 	movzbl 0x1150b(%rip),%eax        # 53303 <modifiers.1>
   41df8:	0f b6 c0             	movzbl %al,%eax
   41dfb:	83 e0 08             	and    $0x8,%eax
   41dfe:	85 c0                	test   %eax,%eax
   41e00:	0f 94 c0             	sete   %al
   41e03:	31 d0                	xor    %edx,%eax
   41e05:	84 c0                	test   %al,%al
   41e07:	0f 84 cf 00 00 00    	je     41edc <keyboard_readc+0x213>
            ch -= 0x20;
   41e0d:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   41e11:	e9 c6 00 00 00       	jmp    41edc <keyboard_readc+0x213>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   41e16:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   41e1d:	7e 30                	jle    41e4f <keyboard_readc+0x186>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   41e1f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41e22:	2d fa 00 00 00       	sub    $0xfa,%eax
   41e27:	ba 01 00 00 00       	mov    $0x1,%edx
   41e2c:	89 c1                	mov    %eax,%ecx
   41e2e:	d3 e2                	shl    %cl,%edx
   41e30:	89 d0                	mov    %edx,%eax
   41e32:	89 c2                	mov    %eax,%edx
   41e34:	0f b6 05 c8 14 01 00 	movzbl 0x114c8(%rip),%eax        # 53303 <modifiers.1>
   41e3b:	31 d0                	xor    %edx,%eax
   41e3d:	88 05 c0 14 01 00    	mov    %al,0x114c0(%rip)        # 53303 <modifiers.1>
        ch = 0;
   41e43:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41e4a:	e9 8e 00 00 00       	jmp    41edd <keyboard_readc+0x214>
    } else if (ch >= KEY_SHIFT) {
   41e4f:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   41e56:	7e 2d                	jle    41e85 <keyboard_readc+0x1bc>
        modifiers |= 1 << (ch - KEY_SHIFT);
   41e58:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41e5b:	2d fa 00 00 00       	sub    $0xfa,%eax
   41e60:	ba 01 00 00 00       	mov    $0x1,%edx
   41e65:	89 c1                	mov    %eax,%ecx
   41e67:	d3 e2                	shl    %cl,%edx
   41e69:	89 d0                	mov    %edx,%eax
   41e6b:	89 c2                	mov    %eax,%edx
   41e6d:	0f b6 05 8f 14 01 00 	movzbl 0x1148f(%rip),%eax        # 53303 <modifiers.1>
   41e74:	09 d0                	or     %edx,%eax
   41e76:	88 05 87 14 01 00    	mov    %al,0x11487(%rip)        # 53303 <modifiers.1>
        ch = 0;
   41e7c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41e83:	eb 58                	jmp    41edd <keyboard_readc+0x214>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   41e85:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   41e89:	7e 31                	jle    41ebc <keyboard_readc+0x1f3>
   41e8b:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   41e92:	7f 28                	jg     41ebc <keyboard_readc+0x1f3>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   41e94:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41e97:	8d 50 80             	lea    -0x80(%rax),%edx
   41e9a:	0f b6 05 62 14 01 00 	movzbl 0x11462(%rip),%eax        # 53303 <modifiers.1>
   41ea1:	0f b6 c0             	movzbl %al,%eax
   41ea4:	83 e0 03             	and    $0x3,%eax
   41ea7:	48 98                	cltq   
   41ea9:	48 63 d2             	movslq %edx,%rdx
   41eac:	0f b6 84 90 20 43 04 	movzbl 0x44320(%rax,%rdx,4),%eax
   41eb3:	00 
   41eb4:	0f b6 c0             	movzbl %al,%eax
   41eb7:	89 45 fc             	mov    %eax,-0x4(%rbp)
   41eba:	eb 21                	jmp    41edd <keyboard_readc+0x214>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   41ebc:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   41ec0:	7f 1b                	jg     41edd <keyboard_readc+0x214>
   41ec2:	0f b6 05 3a 14 01 00 	movzbl 0x1143a(%rip),%eax        # 53303 <modifiers.1>
   41ec9:	0f b6 c0             	movzbl %al,%eax
   41ecc:	83 e0 02             	and    $0x2,%eax
   41ecf:	85 c0                	test   %eax,%eax
   41ed1:	74 0a                	je     41edd <keyboard_readc+0x214>
        ch = 0;
   41ed3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41eda:	eb 01                	jmp    41edd <keyboard_readc+0x214>
        if (modifiers & MOD_CONTROL) {
   41edc:	90                   	nop
    }

    return ch;
   41edd:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   41ee0:	c9                   	leave  
   41ee1:	c3                   	ret    

0000000000041ee2 <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   41ee2:	55                   	push   %rbp
   41ee3:	48 89 e5             	mov    %rsp,%rbp
   41ee6:	48 83 ec 20          	sub    $0x20,%rsp
   41eea:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41ef1:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   41ef4:	89 c2                	mov    %eax,%edx
   41ef6:	ec                   	in     (%dx),%al
   41ef7:	88 45 e3             	mov    %al,-0x1d(%rbp)
   41efa:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   41f01:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41f04:	89 c2                	mov    %eax,%edx
   41f06:	ec                   	in     (%dx),%al
   41f07:	88 45 eb             	mov    %al,-0x15(%rbp)
   41f0a:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   41f11:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41f14:	89 c2                	mov    %eax,%edx
   41f16:	ec                   	in     (%dx),%al
   41f17:	88 45 f3             	mov    %al,-0xd(%rbp)
   41f1a:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   41f21:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41f24:	89 c2                	mov    %eax,%edx
   41f26:	ec                   	in     (%dx),%al
   41f27:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   41f2a:	90                   	nop
   41f2b:	c9                   	leave  
   41f2c:	c3                   	ret    

0000000000041f2d <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   41f2d:	55                   	push   %rbp
   41f2e:	48 89 e5             	mov    %rsp,%rbp
   41f31:	48 83 ec 40          	sub    $0x40,%rsp
   41f35:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   41f39:	89 f0                	mov    %esi,%eax
   41f3b:	89 55 c0             	mov    %edx,-0x40(%rbp)
   41f3e:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   41f41:	8b 05 bd 13 01 00    	mov    0x113bd(%rip),%eax        # 53304 <initialized.0>
   41f47:	85 c0                	test   %eax,%eax
   41f49:	75 1e                	jne    41f69 <parallel_port_putc+0x3c>
   41f4b:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   41f52:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f56:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   41f5a:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41f5d:	ee                   	out    %al,(%dx)
}
   41f5e:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   41f5f:	c7 05 9b 13 01 00 01 	movl   $0x1,0x1139b(%rip)        # 53304 <initialized.0>
   41f66:	00 00 00 
    }

    for (int i = 0;
   41f69:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41f70:	eb 09                	jmp    41f7b <parallel_port_putc+0x4e>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   41f72:	e8 6b ff ff ff       	call   41ee2 <delay>
         ++i) {
   41f77:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   41f7b:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   41f82:	7f 18                	jg     41f9c <parallel_port_putc+0x6f>
   41f84:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41f8b:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41f8e:	89 c2                	mov    %eax,%edx
   41f90:	ec                   	in     (%dx),%al
   41f91:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   41f94:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   41f98:	84 c0                	test   %al,%al
   41f9a:	79 d6                	jns    41f72 <parallel_port_putc+0x45>
    }
    outb(IO_PARALLEL1_DATA, c);
   41f9c:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   41fa0:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   41fa7:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41faa:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   41fae:	8b 55 d8             	mov    -0x28(%rbp),%edx
   41fb1:	ee                   	out    %al,(%dx)
}
   41fb2:	90                   	nop
   41fb3:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   41fba:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41fbe:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   41fc2:	8b 55 e0             	mov    -0x20(%rbp),%edx
   41fc5:	ee                   	out    %al,(%dx)
}
   41fc6:	90                   	nop
   41fc7:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   41fce:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41fd2:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   41fd6:	8b 55 e8             	mov    -0x18(%rbp),%edx
   41fd9:	ee                   	out    %al,(%dx)
}
   41fda:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   41fdb:	90                   	nop
   41fdc:	c9                   	leave  
   41fdd:	c3                   	ret    

0000000000041fde <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   41fde:	55                   	push   %rbp
   41fdf:	48 89 e5             	mov    %rsp,%rbp
   41fe2:	48 83 ec 20          	sub    $0x20,%rsp
   41fe6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   41fea:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   41fee:	48 c7 45 f8 2d 1f 04 	movq   $0x41f2d,-0x8(%rbp)
   41ff5:	00 
    printer_vprintf(&p, 0, format, val);
   41ff6:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   41ffa:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   41ffe:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   42002:	be 00 00 00 00       	mov    $0x0,%esi
   42007:	48 89 c7             	mov    %rax,%rdi
   4200a:	e8 09 11 00 00       	call   43118 <printer_vprintf>
}
   4200f:	90                   	nop
   42010:	c9                   	leave  
   42011:	c3                   	ret    

0000000000042012 <log_printf>:

void log_printf(const char* format, ...) {
   42012:	55                   	push   %rbp
   42013:	48 89 e5             	mov    %rsp,%rbp
   42016:	48 83 ec 60          	sub    $0x60,%rsp
   4201a:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   4201e:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42022:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42026:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4202a:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4202e:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42032:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   42039:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4203d:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42041:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42045:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   42049:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   4204d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42051:	48 89 d6             	mov    %rdx,%rsi
   42054:	48 89 c7             	mov    %rax,%rdi
   42057:	e8 82 ff ff ff       	call   41fde <log_vprintf>
    va_end(val);
}
   4205c:	90                   	nop
   4205d:	c9                   	leave  
   4205e:	c3                   	ret    

000000000004205f <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   4205f:	55                   	push   %rbp
   42060:	48 89 e5             	mov    %rsp,%rbp
   42063:	48 83 ec 40          	sub    $0x40,%rsp
   42067:	89 7d dc             	mov    %edi,-0x24(%rbp)
   4206a:	89 75 d8             	mov    %esi,-0x28(%rbp)
   4206d:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   42071:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   42075:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   42079:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   4207d:	48 8b 0a             	mov    (%rdx),%rcx
   42080:	48 89 08             	mov    %rcx,(%rax)
   42083:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   42087:	48 89 48 08          	mov    %rcx,0x8(%rax)
   4208b:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   4208f:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   42093:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   42097:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4209b:	48 89 d6             	mov    %rdx,%rsi
   4209e:	48 89 c7             	mov    %rax,%rdi
   420a1:	e8 38 ff ff ff       	call   41fde <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   420a6:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   420aa:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   420ae:	8b 75 d8             	mov    -0x28(%rbp),%esi
   420b1:	8b 45 dc             	mov    -0x24(%rbp),%eax
   420b4:	89 c7                	mov    %eax,%edi
   420b6:	e8 0c 1b 00 00       	call   43bc7 <console_vprintf>
}
   420bb:	c9                   	leave  
   420bc:	c3                   	ret    

00000000000420bd <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   420bd:	55                   	push   %rbp
   420be:	48 89 e5             	mov    %rsp,%rbp
   420c1:	48 83 ec 60          	sub    $0x60,%rsp
   420c5:	89 7d ac             	mov    %edi,-0x54(%rbp)
   420c8:	89 75 a8             	mov    %esi,-0x58(%rbp)
   420cb:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   420cf:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   420d3:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   420d7:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   420db:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   420e2:	48 8d 45 10          	lea    0x10(%rbp),%rax
   420e6:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   420ea:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   420ee:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   420f2:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   420f6:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   420fa:	8b 75 a8             	mov    -0x58(%rbp),%esi
   420fd:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42100:	89 c7                	mov    %eax,%edi
   42102:	e8 58 ff ff ff       	call   4205f <error_vprintf>
   42107:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   4210a:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   4210d:	c9                   	leave  
   4210e:	c3                   	ret    

000000000004210f <check_keyboard>:
//    Check for the user typing a control key. 'a', 'f', and 'e' cause a soft
//    reboot where the kernel runs the allocator programs, "fork", or
//    "forkexit", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   4210f:	55                   	push   %rbp
   42110:	48 89 e5             	mov    %rsp,%rbp
   42113:	53                   	push   %rbx
   42114:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   42118:	e8 ac fb ff ff       	call   41cc9 <keyboard_readc>
   4211d:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   42120:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42124:	74 1c                	je     42142 <check_keyboard+0x33>
   42126:	83 7d e4 66          	cmpl   $0x66,-0x1c(%rbp)
   4212a:	74 16                	je     42142 <check_keyboard+0x33>
   4212c:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42130:	74 10                	je     42142 <check_keyboard+0x33>
   42132:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42136:	74 0a                	je     42142 <check_keyboard+0x33>
   42138:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   4213c:	0f 85 e9 00 00 00    	jne    4222b <check_keyboard+0x11c>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   42142:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   42149:	00 
        memset(pt, 0, PAGESIZE * 3);
   4214a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4214e:	ba 00 30 00 00       	mov    $0x3000,%edx
   42153:	be 00 00 00 00       	mov    $0x0,%esi
   42158:	48 89 c7             	mov    %rax,%rdi
   4215b:	e8 1c 0d 00 00       	call   42e7c <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   42160:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42164:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   4216b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4216f:	48 05 00 10 00 00    	add    $0x1000,%rax
   42175:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   4217c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42180:	48 05 00 20 00 00    	add    $0x2000,%rax
   42186:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   4218d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42191:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42195:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42199:	0f 22 d8             	mov    %rax,%cr3
}
   4219c:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   4219d:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "fork";
   421a4:	48 c7 45 e8 78 43 04 	movq   $0x44378,-0x18(%rbp)
   421ab:	00 
        if (c == 'a') {
   421ac:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   421b0:	75 0a                	jne    421bc <check_keyboard+0xad>
            argument = "allocator";
   421b2:	48 c7 45 e8 7d 43 04 	movq   $0x4437d,-0x18(%rbp)
   421b9:	00 
   421ba:	eb 2e                	jmp    421ea <check_keyboard+0xdb>
        } else if (c == 'e') {
   421bc:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   421c0:	75 0a                	jne    421cc <check_keyboard+0xbd>
            argument = "forkexit";
   421c2:	48 c7 45 e8 87 43 04 	movq   $0x44387,-0x18(%rbp)
   421c9:	00 
   421ca:	eb 1e                	jmp    421ea <check_keyboard+0xdb>
        }
        else if (c == 't'){
   421cc:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   421d0:	75 0a                	jne    421dc <check_keyboard+0xcd>
            argument = "test";
   421d2:	48 c7 45 e8 90 43 04 	movq   $0x44390,-0x18(%rbp)
   421d9:	00 
   421da:	eb 0e                	jmp    421ea <check_keyboard+0xdb>
        }
        else if(c == '2'){
   421dc:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   421e0:	75 08                	jne    421ea <check_keyboard+0xdb>
            argument = "test2";
   421e2:	48 c7 45 e8 95 43 04 	movq   $0x44395,-0x18(%rbp)
   421e9:	00 
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   421ea:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   421ee:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   421f2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   421f7:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   421fb:	73 14                	jae    42211 <check_keyboard+0x102>
   421fd:	ba 9b 43 04 00       	mov    $0x4439b,%edx
   42202:	be 5d 02 00 00       	mov    $0x25d,%esi
   42207:	bf b7 43 04 00       	mov    $0x443b7,%edi
   4220c:	e8 1f 01 00 00       	call   42330 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   42211:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42215:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   42218:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   4221c:	48 89 c3             	mov    %rax,%rbx
   4221f:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   42224:	e9 d7 dd ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   42229:	eb 11                	jmp    4223c <check_keyboard+0x12d>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   4222b:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   4222f:	74 06                	je     42237 <check_keyboard+0x128>
   42231:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   42235:	75 05                	jne    4223c <check_keyboard+0x12d>
        poweroff();
   42237:	e8 9d f8 ff ff       	call   41ad9 <poweroff>
    }
    return c;
   4223c:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   4223f:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42243:	c9                   	leave  
   42244:	c3                   	ret    

0000000000042245 <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   42245:	55                   	push   %rbp
   42246:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   42249:	e8 c1 fe ff ff       	call   4210f <check_keyboard>
   4224e:	eb f9                	jmp    42249 <fail+0x4>

0000000000042250 <panic>:

// panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void panic(const char* format, ...) {
   42250:	55                   	push   %rbp
   42251:	48 89 e5             	mov    %rsp,%rbp
   42254:	48 83 ec 60          	sub    $0x60,%rsp
   42258:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   4225c:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42260:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42264:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42268:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4226c:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42270:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   42277:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4227b:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   4227f:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42283:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   42287:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   4228c:	0f 84 80 00 00 00    	je     42312 <panic+0xc2>
        // Print panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   42292:	ba cb 43 04 00       	mov    $0x443cb,%edx
   42297:	be 00 c0 00 00       	mov    $0xc000,%esi
   4229c:	bf 30 07 00 00       	mov    $0x730,%edi
   422a1:	b8 00 00 00 00       	mov    $0x0,%eax
   422a6:	e8 12 fe ff ff       	call   420bd <error_printf>
   422ab:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   422ae:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   422b2:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   422b6:	8b 45 cc             	mov    -0x34(%rbp),%eax
   422b9:	be 00 c0 00 00       	mov    $0xc000,%esi
   422be:	89 c7                	mov    %eax,%edi
   422c0:	e8 9a fd ff ff       	call   4205f <error_vprintf>
   422c5:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   422c8:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   422cb:	48 63 c1             	movslq %ecx,%rax
   422ce:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   422d5:	48 c1 e8 20          	shr    $0x20,%rax
   422d9:	89 c2                	mov    %eax,%edx
   422db:	c1 fa 05             	sar    $0x5,%edx
   422de:	89 c8                	mov    %ecx,%eax
   422e0:	c1 f8 1f             	sar    $0x1f,%eax
   422e3:	29 c2                	sub    %eax,%edx
   422e5:	89 d0                	mov    %edx,%eax
   422e7:	c1 e0 02             	shl    $0x2,%eax
   422ea:	01 d0                	add    %edx,%eax
   422ec:	c1 e0 04             	shl    $0x4,%eax
   422ef:	29 c1                	sub    %eax,%ecx
   422f1:	89 ca                	mov    %ecx,%edx
   422f3:	85 d2                	test   %edx,%edx
   422f5:	74 34                	je     4232b <panic+0xdb>
            error_printf(cpos, 0xC000, "\n");
   422f7:	8b 45 cc             	mov    -0x34(%rbp),%eax
   422fa:	ba d3 43 04 00       	mov    $0x443d3,%edx
   422ff:	be 00 c0 00 00       	mov    $0xc000,%esi
   42304:	89 c7                	mov    %eax,%edi
   42306:	b8 00 00 00 00       	mov    $0x0,%eax
   4230b:	e8 ad fd ff ff       	call   420bd <error_printf>
   42310:	eb 19                	jmp    4232b <panic+0xdb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   42312:	ba d5 43 04 00       	mov    $0x443d5,%edx
   42317:	be 00 c0 00 00       	mov    $0xc000,%esi
   4231c:	bf 30 07 00 00       	mov    $0x730,%edi
   42321:	b8 00 00 00 00       	mov    $0x0,%eax
   42326:	e8 92 fd ff ff       	call   420bd <error_printf>
    }

    va_end(val);
    fail();
   4232b:	e8 15 ff ff ff       	call   42245 <fail>

0000000000042330 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   42330:	55                   	push   %rbp
   42331:	48 89 e5             	mov    %rsp,%rbp
   42334:	48 83 ec 20          	sub    $0x20,%rsp
   42338:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4233c:	89 75 f4             	mov    %esi,-0xc(%rbp)
   4233f:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   42343:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   42347:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4234a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4234e:	48 89 c6             	mov    %rax,%rsi
   42351:	bf db 43 04 00       	mov    $0x443db,%edi
   42356:	b8 00 00 00 00       	mov    $0x0,%eax
   4235b:	e8 f0 fe ff ff       	call   42250 <panic>

0000000000042360 <default_exception>:
}

void default_exception(proc* p){
   42360:	55                   	push   %rbp
   42361:	48 89 e5             	mov    %rsp,%rbp
   42364:	48 83 ec 20          	sub    $0x20,%rsp
   42368:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   4236c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42370:	48 83 c0 08          	add    $0x8,%rax
   42374:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    panic("Unexpected exception %d!\n", reg->reg_intno);
   42378:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4237c:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   42383:	48 89 c6             	mov    %rax,%rsi
   42386:	bf f9 43 04 00       	mov    $0x443f9,%edi
   4238b:	b8 00 00 00 00       	mov    $0x0,%eax
   42390:	e8 bb fe ff ff       	call   42250 <panic>

0000000000042395 <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   42395:	55                   	push   %rbp
   42396:	48 89 e5             	mov    %rsp,%rbp
   42399:	48 83 ec 10          	sub    $0x10,%rsp
   4239d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   423a1:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   423a4:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   423a8:	78 06                	js     423b0 <pageindex+0x1b>
   423aa:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   423ae:	7e 14                	jle    423c4 <pageindex+0x2f>
   423b0:	ba 18 44 04 00       	mov    $0x44418,%edx
   423b5:	be 1e 00 00 00       	mov    $0x1e,%esi
   423ba:	bf 31 44 04 00       	mov    $0x44431,%edi
   423bf:	e8 6c ff ff ff       	call   42330 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   423c4:	b8 03 00 00 00       	mov    $0x3,%eax
   423c9:	2b 45 f4             	sub    -0xc(%rbp),%eax
   423cc:	89 c2                	mov    %eax,%edx
   423ce:	89 d0                	mov    %edx,%eax
   423d0:	c1 e0 03             	shl    $0x3,%eax
   423d3:	01 d0                	add    %edx,%eax
   423d5:	83 c0 0c             	add    $0xc,%eax
   423d8:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   423dc:	89 c1                	mov    %eax,%ecx
   423de:	48 d3 ea             	shr    %cl,%rdx
   423e1:	48 89 d0             	mov    %rdx,%rax
   423e4:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   423e9:	c9                   	leave  
   423ea:	c3                   	ret    

00000000000423eb <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   423eb:	55                   	push   %rbp
   423ec:	48 89 e5             	mov    %rsp,%rbp
   423ef:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   423f3:	48 c7 05 02 1c 01 00 	movq   $0x55000,0x11c02(%rip)        # 54000 <kernel_pagetable>
   423fa:	00 50 05 00 
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   423fe:	ba 00 50 00 00       	mov    $0x5000,%edx
   42403:	be 00 00 00 00       	mov    $0x0,%esi
   42408:	bf 00 50 05 00       	mov    $0x55000,%edi
   4240d:	e8 6a 0a 00 00       	call   42e7c <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   42412:	b8 00 60 05 00       	mov    $0x56000,%eax
   42417:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   4241b:	48 89 05 de 2b 01 00 	mov    %rax,0x12bde(%rip)        # 55000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   42422:	b8 00 70 05 00       	mov    $0x57000,%eax
   42427:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   4242b:	48 89 05 ce 3b 01 00 	mov    %rax,0x13bce(%rip)        # 56000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   42432:	b8 00 80 05 00       	mov    $0x58000,%eax
   42437:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   4243b:	48 89 05 be 4b 01 00 	mov    %rax,0x14bbe(%rip)        # 57000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   42442:	b8 00 90 05 00       	mov    $0x59000,%eax
   42447:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   4244b:	48 89 05 b6 4b 01 00 	mov    %rax,0x14bb6(%rip)        # 57008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   42452:	48 8b 05 a7 1b 01 00 	mov    0x11ba7(%rip),%rax        # 54000 <kernel_pagetable>
   42459:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4245f:	b9 00 00 20 00       	mov    $0x200000,%ecx
   42464:	ba 00 00 00 00       	mov    $0x0,%edx
   42469:	be 00 00 00 00       	mov    $0x0,%esi
   4246e:	48 89 c7             	mov    %rax,%rdi
   42471:	e8 b9 01 00 00       	call   4262f <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42476:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   4247d:	00 
   4247e:	eb 62                	jmp    424e2 <virtual_memory_init+0xf7>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   42480:	48 8b 0d 79 1b 01 00 	mov    0x11b79(%rip),%rcx        # 54000 <kernel_pagetable>
   42487:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   4248b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4248f:	48 89 ce             	mov    %rcx,%rsi
   42492:	48 89 c7             	mov    %rax,%rdi
   42495:	e8 50 05 00 00       	call   429ea <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l1pagetable ?
        assert(vmap.pa == addr);
   4249a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4249e:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   424a2:	74 14                	je     424b8 <virtual_memory_init+0xcd>
   424a4:	ba 45 44 04 00       	mov    $0x44445,%edx
   424a9:	be 2d 00 00 00       	mov    $0x2d,%esi
   424ae:	bf 55 44 04 00       	mov    $0x44455,%edi
   424b3:	e8 78 fe ff ff       	call   42330 <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   424b8:	8b 45 f0             	mov    -0x10(%rbp),%eax
   424bb:	48 98                	cltq   
   424bd:	83 e0 03             	and    $0x3,%eax
   424c0:	48 83 f8 03          	cmp    $0x3,%rax
   424c4:	74 14                	je     424da <virtual_memory_init+0xef>
   424c6:	ba 68 44 04 00       	mov    $0x44468,%edx
   424cb:	be 2e 00 00 00       	mov    $0x2e,%esi
   424d0:	bf 55 44 04 00       	mov    $0x44455,%edi
   424d5:	e8 56 fe ff ff       	call   42330 <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   424da:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   424e1:	00 
   424e2:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   424e9:	00 
   424ea:	76 94                	jbe    42480 <virtual_memory_init+0x95>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   424ec:	48 8b 05 0d 1b 01 00 	mov    0x11b0d(%rip),%rax        # 54000 <kernel_pagetable>
   424f3:	48 89 c7             	mov    %rax,%rdi
   424f6:	e8 03 00 00 00       	call   424fe <set_pagetable>
}
   424fb:	90                   	nop
   424fc:	c9                   	leave  
   424fd:	c3                   	ret    

00000000000424fe <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   424fe:	55                   	push   %rbp
   424ff:	48 89 e5             	mov    %rsp,%rbp
   42502:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   42506:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   4250a:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   4250e:	25 ff 0f 00 00       	and    $0xfff,%eax
   42513:	48 85 c0             	test   %rax,%rax
   42516:	74 14                	je     4252c <set_pagetable+0x2e>
   42518:	ba 95 44 04 00       	mov    $0x44495,%edx
   4251d:	be 3d 00 00 00       	mov    $0x3d,%esi
   42522:	bf 55 44 04 00       	mov    $0x44455,%edi
   42527:	e8 04 fe ff ff       	call   42330 <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   4252c:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42531:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   42535:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42539:	48 89 ce             	mov    %rcx,%rsi
   4253c:	48 89 c7             	mov    %rax,%rdi
   4253f:	e8 a6 04 00 00       	call   429ea <virtual_memory_lookup>
   42544:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42548:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   4254d:	48 39 d0             	cmp    %rdx,%rax
   42550:	74 14                	je     42566 <set_pagetable+0x68>
   42552:	ba b0 44 04 00       	mov    $0x444b0,%edx
   42557:	be 3f 00 00 00       	mov    $0x3f,%esi
   4255c:	bf 55 44 04 00       	mov    $0x44455,%edi
   42561:	e8 ca fd ff ff       	call   42330 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   42566:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   4256a:	48 8b 0d 8f 1a 01 00 	mov    0x11a8f(%rip),%rcx        # 54000 <kernel_pagetable>
   42571:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   42575:	48 89 ce             	mov    %rcx,%rsi
   42578:	48 89 c7             	mov    %rax,%rdi
   4257b:	e8 6a 04 00 00       	call   429ea <virtual_memory_lookup>
   42580:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42584:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42588:	48 39 c2             	cmp    %rax,%rdx
   4258b:	74 14                	je     425a1 <set_pagetable+0xa3>
   4258d:	ba 18 45 04 00       	mov    $0x44518,%edx
   42592:	be 41 00 00 00       	mov    $0x41,%esi
   42597:	bf 55 44 04 00       	mov    $0x44455,%edi
   4259c:	e8 8f fd ff ff       	call   42330 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   425a1:	48 8b 05 58 1a 01 00 	mov    0x11a58(%rip),%rax        # 54000 <kernel_pagetable>
   425a8:	48 89 c2             	mov    %rax,%rdx
   425ab:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   425af:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   425b3:	48 89 ce             	mov    %rcx,%rsi
   425b6:	48 89 c7             	mov    %rax,%rdi
   425b9:	e8 2c 04 00 00       	call   429ea <virtual_memory_lookup>
   425be:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   425c2:	48 8b 15 37 1a 01 00 	mov    0x11a37(%rip),%rdx        # 54000 <kernel_pagetable>
   425c9:	48 39 d0             	cmp    %rdx,%rax
   425cc:	74 14                	je     425e2 <set_pagetable+0xe4>
   425ce:	ba 78 45 04 00       	mov    $0x44578,%edx
   425d3:	be 43 00 00 00       	mov    $0x43,%esi
   425d8:	bf 55 44 04 00       	mov    $0x44455,%edi
   425dd:	e8 4e fd ff ff       	call   42330 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   425e2:	ba 2f 26 04 00       	mov    $0x4262f,%edx
   425e7:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   425eb:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   425ef:	48 89 ce             	mov    %rcx,%rsi
   425f2:	48 89 c7             	mov    %rax,%rdi
   425f5:	e8 f0 03 00 00       	call   429ea <virtual_memory_lookup>
   425fa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   425fe:	ba 2f 26 04 00       	mov    $0x4262f,%edx
   42603:	48 39 d0             	cmp    %rdx,%rax
   42606:	74 14                	je     4261c <set_pagetable+0x11e>
   42608:	ba e0 45 04 00       	mov    $0x445e0,%edx
   4260d:	be 45 00 00 00       	mov    $0x45,%esi
   42612:	bf 55 44 04 00       	mov    $0x44455,%edi
   42617:	e8 14 fd ff ff       	call   42330 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   4261c:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42620:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42624:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42628:	0f 22 d8             	mov    %rax,%cr3
}
   4262b:	90                   	nop
}
   4262c:	90                   	nop
   4262d:	c9                   	leave  
   4262e:	c3                   	ret    

000000000004262f <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   4262f:	55                   	push   %rbp
   42630:	48 89 e5             	mov    %rsp,%rbp
   42633:	53                   	push   %rbx
   42634:	48 83 ec 58          	sub    $0x58,%rsp
   42638:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   4263c:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42640:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   42644:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
   42648:	44 89 45 ac          	mov    %r8d,-0x54(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   4264c:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42650:	25 ff 0f 00 00       	and    $0xfff,%eax
   42655:	48 85 c0             	test   %rax,%rax
   42658:	74 14                	je     4266e <virtual_memory_map+0x3f>
   4265a:	ba 46 46 04 00       	mov    $0x44646,%edx
   4265f:	be 66 00 00 00       	mov    $0x66,%esi
   42664:	bf 55 44 04 00       	mov    $0x44455,%edi
   42669:	e8 c2 fc ff ff       	call   42330 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   4266e:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42672:	25 ff 0f 00 00       	and    $0xfff,%eax
   42677:	48 85 c0             	test   %rax,%rax
   4267a:	74 14                	je     42690 <virtual_memory_map+0x61>
   4267c:	ba 59 46 04 00       	mov    $0x44659,%edx
   42681:	be 67 00 00 00       	mov    $0x67,%esi
   42686:	bf 55 44 04 00       	mov    $0x44455,%edi
   4268b:	e8 a0 fc ff ff       	call   42330 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   42690:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42694:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42698:	48 01 d0             	add    %rdx,%rax
   4269b:	48 3b 45 c0          	cmp    -0x40(%rbp),%rax
   4269f:	73 24                	jae    426c5 <virtual_memory_map+0x96>
   426a1:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   426a5:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   426a9:	48 01 d0             	add    %rdx,%rax
   426ac:	48 85 c0             	test   %rax,%rax
   426af:	74 14                	je     426c5 <virtual_memory_map+0x96>
   426b1:	ba 6c 46 04 00       	mov    $0x4466c,%edx
   426b6:	be 68 00 00 00       	mov    $0x68,%esi
   426bb:	bf 55 44 04 00       	mov    $0x44455,%edi
   426c0:	e8 6b fc ff ff       	call   42330 <assert_fail>
    if (perm & PTE_P) {
   426c5:	8b 45 ac             	mov    -0x54(%rbp),%eax
   426c8:	48 98                	cltq   
   426ca:	83 e0 01             	and    $0x1,%eax
   426cd:	48 85 c0             	test   %rax,%rax
   426d0:	74 6e                	je     42740 <virtual_memory_map+0x111>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   426d2:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   426d6:	25 ff 0f 00 00       	and    $0xfff,%eax
   426db:	48 85 c0             	test   %rax,%rax
   426de:	74 14                	je     426f4 <virtual_memory_map+0xc5>
   426e0:	ba 8a 46 04 00       	mov    $0x4468a,%edx
   426e5:	be 6a 00 00 00       	mov    $0x6a,%esi
   426ea:	bf 55 44 04 00       	mov    $0x44455,%edi
   426ef:	e8 3c fc ff ff       	call   42330 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   426f4:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   426f8:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   426fc:	48 01 d0             	add    %rdx,%rax
   426ff:	48 3b 45 b8          	cmp    -0x48(%rbp),%rax
   42703:	73 14                	jae    42719 <virtual_memory_map+0xea>
   42705:	ba 9d 46 04 00       	mov    $0x4469d,%edx
   4270a:	be 6b 00 00 00       	mov    $0x6b,%esi
   4270f:	bf 55 44 04 00       	mov    $0x44455,%edi
   42714:	e8 17 fc ff ff       	call   42330 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   42719:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   4271d:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42721:	48 01 d0             	add    %rdx,%rax
   42724:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   4272a:	76 14                	jbe    42740 <virtual_memory_map+0x111>
   4272c:	ba ab 46 04 00       	mov    $0x446ab,%edx
   42731:	be 6c 00 00 00       	mov    $0x6c,%esi
   42736:	bf 55 44 04 00       	mov    $0x44455,%edi
   4273b:	e8 f0 fb ff ff       	call   42330 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   42740:	83 7d ac 00          	cmpl   $0x0,-0x54(%rbp)
   42744:	78 09                	js     4274f <virtual_memory_map+0x120>
   42746:	81 7d ac ff 0f 00 00 	cmpl   $0xfff,-0x54(%rbp)
   4274d:	7e 14                	jle    42763 <virtual_memory_map+0x134>
   4274f:	ba c7 46 04 00       	mov    $0x446c7,%edx
   42754:	be 6e 00 00 00       	mov    $0x6e,%esi
   42759:	bf 55 44 04 00       	mov    $0x44455,%edi
   4275e:	e8 cd fb ff ff       	call   42330 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   42763:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42767:	25 ff 0f 00 00       	and    $0xfff,%eax
   4276c:	48 85 c0             	test   %rax,%rax
   4276f:	74 14                	je     42785 <virtual_memory_map+0x156>
   42771:	ba e8 46 04 00       	mov    $0x446e8,%edx
   42776:	be 6f 00 00 00       	mov    $0x6f,%esi
   4277b:	bf 55 44 04 00       	mov    $0x44455,%edi
   42780:	e8 ab fb ff ff       	call   42330 <assert_fail>

    int last_index123 = -1;
   42785:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%rbp)
    x86_64_pagetable* l1pagetable = NULL;
   4278c:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
   42793:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42794:	e9 e1 00 00 00       	jmp    4287a <virtual_memory_map+0x24b>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   42799:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4279d:	48 c1 e8 15          	shr    $0x15,%rax
   427a1:	89 45 dc             	mov    %eax,-0x24(%rbp)
        if (cur_index123 != last_index123) {
   427a4:	8b 45 dc             	mov    -0x24(%rbp),%eax
   427a7:	3b 45 ec             	cmp    -0x14(%rbp),%eax
   427aa:	74 20                	je     427cc <virtual_memory_map+0x19d>
            // TODO --> done
            // find pointer to last level pagetable for current va
			l1pagetable = lookup_l1pagetable(pagetable, va, perm);
   427ac:	8b 55 ac             	mov    -0x54(%rbp),%edx
   427af:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   427b3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   427b7:	48 89 ce             	mov    %rcx,%rsi
   427ba:	48 89 c7             	mov    %rax,%rdi
   427bd:	e8 ce 00 00 00       	call   42890 <lookup_l1pagetable>
   427c2:	48 89 45 e0          	mov    %rax,-0x20(%rbp)

            last_index123 = cur_index123;
   427c6:	8b 45 dc             	mov    -0x24(%rbp),%eax
   427c9:	89 45 ec             	mov    %eax,-0x14(%rbp)
        }
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   427cc:	8b 45 ac             	mov    -0x54(%rbp),%eax
   427cf:	48 98                	cltq   
   427d1:	83 e0 01             	and    $0x1,%eax
   427d4:	48 85 c0             	test   %rax,%rax
   427d7:	74 34                	je     4280d <virtual_memory_map+0x1de>
   427d9:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   427de:	74 2d                	je     4280d <virtual_memory_map+0x1de>
            // TODO --> done
            // map `pa` at appropriate entry with permissions `perm`
			l1pagetable->entry[L1PAGEINDEX(va)] = pa | perm;
   427e0:	8b 45 ac             	mov    -0x54(%rbp),%eax
   427e3:	48 63 d8             	movslq %eax,%rbx
   427e6:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   427ea:	be 03 00 00 00       	mov    $0x3,%esi
   427ef:	48 89 c7             	mov    %rax,%rdi
   427f2:	e8 9e fb ff ff       	call   42395 <pageindex>
   427f7:	89 c2                	mov    %eax,%edx
   427f9:	48 0b 5d b8          	or     -0x48(%rbp),%rbx
   427fd:	48 89 d9             	mov    %rbx,%rcx
   42800:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42804:	48 63 d2             	movslq %edx,%rdx
   42807:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   4280b:	eb 55                	jmp    42862 <virtual_memory_map+0x233>

        } else if (l1pagetable) { // if page is NOT marked present
   4280d:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42812:	74 26                	je     4283a <virtual_memory_map+0x20b>
            // TODO --> done
            // map to address 0 with `perm`
			l1pagetable->entry[L1PAGEINDEX(va)] = 0 | perm;
   42814:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42818:	be 03 00 00 00       	mov    $0x3,%esi
   4281d:	48 89 c7             	mov    %rax,%rdi
   42820:	e8 70 fb ff ff       	call   42395 <pageindex>
   42825:	89 c2                	mov    %eax,%edx
   42827:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4282a:	48 63 c8             	movslq %eax,%rcx
   4282d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42831:	48 63 d2             	movslq %edx,%rdx
   42834:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42838:	eb 28                	jmp    42862 <virtual_memory_map+0x233>

        } else if (perm & PTE_P) {
   4283a:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4283d:	48 98                	cltq   
   4283f:	83 e0 01             	and    $0x1,%eax
   42842:	48 85 c0             	test   %rax,%rax
   42845:	74 1b                	je     42862 <virtual_memory_map+0x233>
            // error, no allocated l1 page found for va
            log_printf("[Kern Info] failed to find l1pagetable address at " __FILE__ ": %d\n", __LINE__);
   42847:	be 8a 00 00 00       	mov    $0x8a,%esi
   4284c:	bf 10 47 04 00       	mov    $0x44710,%edi
   42851:	b8 00 00 00 00       	mov    $0x0,%eax
   42856:	e8 b7 f7 ff ff       	call   42012 <log_printf>
            return -1;
   4285b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42860:	eb 28                	jmp    4288a <virtual_memory_map+0x25b>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42862:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
   42869:	00 
   4286a:	48 81 45 b8 00 10 00 	addq   $0x1000,-0x48(%rbp)
   42871:	00 
   42872:	48 81 6d b0 00 10 00 	subq   $0x1000,-0x50(%rbp)
   42879:	00 
   4287a:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   4287f:	0f 85 14 ff ff ff    	jne    42799 <virtual_memory_map+0x16a>
        }
    }
    return 0;
   42885:	b8 00 00 00 00       	mov    $0x0,%eax
}
   4288a:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   4288e:	c9                   	leave  
   4288f:	c3                   	ret    

0000000000042890 <lookup_l1pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   42890:	55                   	push   %rbp
   42891:	48 89 e5             	mov    %rsp,%rbp
   42894:	48 83 ec 40          	sub    $0x40,%rsp
   42898:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   4289c:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   428a0:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   428a3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   428a7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l1 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   428ab:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   428b2:	e9 23 01 00 00       	jmp    429da <lookup_l1pagetable+0x14a>
        // TODO --> done
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        x86_64_pageentry_t pe = pt->entry[PAGEINDEX(va, i)]; // replace this --> done
   428b7:	8b 55 f4             	mov    -0xc(%rbp),%edx
   428ba:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   428be:	89 d6                	mov    %edx,%esi
   428c0:	48 89 c7             	mov    %rax,%rdi
   428c3:	e8 cd fa ff ff       	call   42395 <pageindex>
   428c8:	89 c2                	mov    %eax,%edx
   428ca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   428ce:	48 63 d2             	movslq %edx,%rdx
   428d1:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   428d5:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   428d9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   428dd:	83 e0 01             	and    $0x1,%eax
   428e0:	48 85 c0             	test   %rax,%rax
   428e3:	75 63                	jne    42948 <lookup_l1pagetable+0xb8>
            log_printf("[Kern Info] Error looking up l1pagetable: Pagetable address: 0x%x perm: 0x%x."
   428e5:	8b 45 f4             	mov    -0xc(%rbp),%eax
   428e8:	8d 48 02             	lea    0x2(%rax),%ecx
   428eb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   428ef:	25 ff 0f 00 00       	and    $0xfff,%eax
   428f4:	48 89 c2             	mov    %rax,%rdx
   428f7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   428fb:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42901:	48 89 c6             	mov    %rax,%rsi
   42904:	bf 58 47 04 00       	mov    $0x44758,%edi
   42909:	b8 00 00 00 00       	mov    $0x0,%eax
   4290e:	e8 ff f6 ff ff       	call   42012 <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   42913:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42916:	48 98                	cltq   
   42918:	83 e0 01             	and    $0x1,%eax
   4291b:	48 85 c0             	test   %rax,%rax
   4291e:	75 0a                	jne    4292a <lookup_l1pagetable+0x9a>
                return NULL;
   42920:	b8 00 00 00 00       	mov    $0x0,%eax
   42925:	e9 be 00 00 00       	jmp    429e8 <lookup_l1pagetable+0x158>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   4292a:	be ae 00 00 00       	mov    $0xae,%esi
   4292f:	bf c0 47 04 00       	mov    $0x447c0,%edi
   42934:	b8 00 00 00 00       	mov    $0x0,%eax
   42939:	e8 d4 f6 ff ff       	call   42012 <log_printf>
            return NULL;
   4293e:	b8 00 00 00 00       	mov    $0x0,%eax
   42943:	e9 a0 00 00 00       	jmp    429e8 <lookup_l1pagetable+0x158>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   42948:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4294c:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42952:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   42958:	76 14                	jbe    4296e <lookup_l1pagetable+0xde>
   4295a:	ba 08 48 04 00       	mov    $0x44808,%edx
   4295f:	be b3 00 00 00       	mov    $0xb3,%esi
   42964:	bf 55 44 04 00       	mov    $0x44455,%edi
   42969:	e8 c2 f9 ff ff       	call   42330 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   4296e:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42971:	48 98                	cltq   
   42973:	83 e0 02             	and    $0x2,%eax
   42976:	48 85 c0             	test   %rax,%rax
   42979:	74 20                	je     4299b <lookup_l1pagetable+0x10b>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   4297b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4297f:	83 e0 02             	and    $0x2,%eax
   42982:	48 85 c0             	test   %rax,%rax
   42985:	75 14                	jne    4299b <lookup_l1pagetable+0x10b>
   42987:	ba 28 48 04 00       	mov    $0x44828,%edx
   4298c:	be b5 00 00 00       	mov    $0xb5,%esi
   42991:	bf 55 44 04 00       	mov    $0x44455,%edi
   42996:	e8 95 f9 ff ff       	call   42330 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   4299b:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4299e:	48 98                	cltq   
   429a0:	83 e0 04             	and    $0x4,%eax
   429a3:	48 85 c0             	test   %rax,%rax
   429a6:	74 20                	je     429c8 <lookup_l1pagetable+0x138>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   429a8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   429ac:	83 e0 04             	and    $0x4,%eax
   429af:	48 85 c0             	test   %rax,%rax
   429b2:	75 14                	jne    429c8 <lookup_l1pagetable+0x138>
   429b4:	ba 33 48 04 00       	mov    $0x44833,%edx
   429b9:	be b8 00 00 00       	mov    $0xb8,%esi
   429be:	bf 55 44 04 00       	mov    $0x44455,%edi
   429c3:	e8 68 f9 ff ff       	call   42330 <assert_fail>
        }

        // TODO --> done
        // set pt to physical address to next pagetable using `pe`
        pt = (x86_64_pagetable *)PTE_ADDR(pe); // replace this --> done
   429c8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   429cc:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   429d2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   429d6:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   429da:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   429de:	0f 8e d3 fe ff ff    	jle    428b7 <lookup_l1pagetable+0x27>
    }
    return pt;
   429e4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   429e8:	c9                   	leave  
   429e9:	c3                   	ret    

00000000000429ea <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   429ea:	55                   	push   %rbp
   429eb:	48 89 e5             	mov    %rsp,%rbp
   429ee:	48 83 ec 50          	sub    $0x50,%rsp
   429f2:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   429f6:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   429fa:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   429fe:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42a02:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   42a06:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   42a0d:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42a0e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   42a15:	eb 41                	jmp    42a58 <virtual_memory_lookup+0x6e>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   42a17:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42a1a:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42a1e:	89 d6                	mov    %edx,%esi
   42a20:	48 89 c7             	mov    %rax,%rdi
   42a23:	e8 6d f9 ff ff       	call   42395 <pageindex>
   42a28:	89 c2                	mov    %eax,%edx
   42a2a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42a2e:	48 63 d2             	movslq %edx,%rdx
   42a31:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   42a35:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42a39:	83 e0 06             	and    $0x6,%eax
   42a3c:	48 f7 d0             	not    %rax
   42a3f:	48 21 d0             	and    %rdx,%rax
   42a42:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42a46:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42a4a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42a50:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42a54:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   42a58:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   42a5c:	7f 0c                	jg     42a6a <virtual_memory_lookup+0x80>
   42a5e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42a62:	83 e0 01             	and    $0x1,%eax
   42a65:	48 85 c0             	test   %rax,%rax
   42a68:	75 ad                	jne    42a17 <virtual_memory_lookup+0x2d>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   42a6a:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   42a71:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   42a78:	ff 
   42a79:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   42a80:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42a84:	83 e0 01             	and    $0x1,%eax
   42a87:	48 85 c0             	test   %rax,%rax
   42a8a:	74 34                	je     42ac0 <virtual_memory_lookup+0xd6>
        vam.pn = PAGENUMBER(pe);
   42a8c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42a90:	48 c1 e8 0c          	shr    $0xc,%rax
   42a94:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   42a97:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42a9b:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42aa1:	48 89 c2             	mov    %rax,%rdx
   42aa4:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42aa8:	25 ff 0f 00 00       	and    $0xfff,%eax
   42aad:	48 09 d0             	or     %rdx,%rax
   42ab0:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   42ab4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ab8:	25 ff 0f 00 00       	and    $0xfff,%eax
   42abd:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   42ac0:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42ac4:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42ac8:	48 89 10             	mov    %rdx,(%rax)
   42acb:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   42acf:	48 89 50 08          	mov    %rdx,0x8(%rax)
   42ad3:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42ad7:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   42adb:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42adf:	c9                   	leave  
   42ae0:	c3                   	ret    

0000000000042ae1 <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   42ae1:	55                   	push   %rbp
   42ae2:	48 89 e5             	mov    %rsp,%rbp
   42ae5:	48 83 ec 40          	sub    $0x40,%rsp
   42ae9:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42aed:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   42af0:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   42af4:	c7 45 f8 07 00 00 00 	movl   $0x7,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   42afb:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   42aff:	78 08                	js     42b09 <program_load+0x28>
   42b01:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42b04:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   42b07:	7c 14                	jl     42b1d <program_load+0x3c>
   42b09:	ba 40 48 04 00       	mov    $0x44840,%edx
   42b0e:	be 37 00 00 00       	mov    $0x37,%esi
   42b13:	bf 70 48 04 00       	mov    $0x44870,%edi
   42b18:	e8 13 f8 ff ff       	call   42330 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   42b1d:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42b20:	48 98                	cltq   
   42b22:	48 c1 e0 04          	shl    $0x4,%rax
   42b26:	48 05 20 50 04 00    	add    $0x45020,%rax
   42b2c:	48 8b 00             	mov    (%rax),%rax
   42b2f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   42b33:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42b37:	8b 00                	mov    (%rax),%eax
   42b39:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   42b3e:	74 14                	je     42b54 <program_load+0x73>
   42b40:	ba 82 48 04 00       	mov    $0x44882,%edx
   42b45:	be 39 00 00 00       	mov    $0x39,%esi
   42b4a:	bf 70 48 04 00       	mov    $0x44870,%edi
   42b4f:	e8 dc f7 ff ff       	call   42330 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   42b54:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42b58:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42b5c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42b60:	48 01 d0             	add    %rdx,%rax
   42b63:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   42b67:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42b6e:	e9 94 00 00 00       	jmp    42c07 <program_load+0x126>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   42b73:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42b76:	48 63 d0             	movslq %eax,%rdx
   42b79:	48 89 d0             	mov    %rdx,%rax
   42b7c:	48 c1 e0 03          	shl    $0x3,%rax
   42b80:	48 29 d0             	sub    %rdx,%rax
   42b83:	48 c1 e0 03          	shl    $0x3,%rax
   42b87:	48 89 c2             	mov    %rax,%rdx
   42b8a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b8e:	48 01 d0             	add    %rdx,%rax
   42b91:	8b 00                	mov    (%rax),%eax
   42b93:	83 f8 01             	cmp    $0x1,%eax
   42b96:	75 6b                	jne    42c03 <program_load+0x122>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   42b98:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42b9b:	48 63 d0             	movslq %eax,%rdx
   42b9e:	48 89 d0             	mov    %rdx,%rax
   42ba1:	48 c1 e0 03          	shl    $0x3,%rax
   42ba5:	48 29 d0             	sub    %rdx,%rax
   42ba8:	48 c1 e0 03          	shl    $0x3,%rax
   42bac:	48 89 c2             	mov    %rax,%rdx
   42baf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42bb3:	48 01 d0             	add    %rdx,%rax
   42bb6:	48 8b 50 08          	mov    0x8(%rax),%rdx
   42bba:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42bbe:	48 01 d0             	add    %rdx,%rax
   42bc1:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   42bc5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42bc8:	48 63 d0             	movslq %eax,%rdx
   42bcb:	48 89 d0             	mov    %rdx,%rax
   42bce:	48 c1 e0 03          	shl    $0x3,%rax
   42bd2:	48 29 d0             	sub    %rdx,%rax
   42bd5:	48 c1 e0 03          	shl    $0x3,%rax
   42bd9:	48 89 c2             	mov    %rax,%rdx
   42bdc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42be0:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   42be4:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42be8:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42bec:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42bf0:	48 89 c7             	mov    %rax,%rdi
   42bf3:	e8 3d 00 00 00       	call   42c35 <program_load_segment>
   42bf8:	85 c0                	test   %eax,%eax
   42bfa:	79 07                	jns    42c03 <program_load+0x122>
                return -1;
   42bfc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42c01:	eb 30                	jmp    42c33 <program_load+0x152>
    for (int i = 0; i < eh->e_phnum; ++i) {
   42c03:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   42c07:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c0b:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   42c0f:	0f b7 c0             	movzwl %ax,%eax
   42c12:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   42c15:	0f 8c 58 ff ff ff    	jl     42b73 <program_load+0x92>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   42c1b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c1f:	48 8b 50 18          	mov    0x18(%rax),%rdx
   42c23:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42c27:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    return 0;
   42c2e:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42c33:	c9                   	leave  
   42c34:	c3                   	ret    

0000000000042c35 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   42c35:	55                   	push   %rbp
   42c36:	48 89 e5             	mov    %rsp,%rbp
   42c39:	48 83 ec 40          	sub    $0x40,%rsp
   42c3d:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42c41:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42c45:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   42c49:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   42c4d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42c51:	48 8b 40 10          	mov    0x10(%rax),%rax
   42c55:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   42c59:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42c5d:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42c61:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c65:	48 01 d0             	add    %rdx,%rax
   42c68:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42c6c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42c70:	48 8b 50 28          	mov    0x28(%rax),%rdx
   42c74:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c78:	48 01 d0             	add    %rdx,%rax
   42c7b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   42c7f:	48 81 65 f0 00 f0 ff 	andq   $0xfffffffffffff000,-0x10(%rbp)
   42c86:	ff 

    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42c87:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c8b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   42c8f:	eb 7c                	jmp    42d0d <program_load_segment+0xd8>
        if (assign_physical_page(addr, p->p_pid) < 0
   42c91:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42c95:	8b 00                	mov    (%rax),%eax
   42c97:	0f be d0             	movsbl %al,%edx
   42c9a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42c9e:	89 d6                	mov    %edx,%esi
   42ca0:	48 89 c7             	mov    %rax,%rdi
   42ca3:	e8 d0 d7 ff ff       	call   40478 <assign_physical_page>
   42ca8:	85 c0                	test   %eax,%eax
   42caa:	78 2a                	js     42cd6 <program_load_segment+0xa1>
            || virtual_memory_map(p->p_pagetable, addr, addr, PAGESIZE,
   42cac:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42cb0:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   42cb7:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42cbb:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   42cbf:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42cc5:	b9 00 10 00 00       	mov    $0x1000,%ecx
   42cca:	48 89 c7             	mov    %rax,%rdi
   42ccd:	e8 5d f9 ff ff       	call   4262f <virtual_memory_map>
   42cd2:	85 c0                	test   %eax,%eax
   42cd4:	79 2f                	jns    42d05 <program_load_segment+0xd0>
                                  PTE_P | PTE_W | PTE_U) < 0) {
            console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   42cd6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42cda:	8b 00                	mov    (%rax),%eax
   42cdc:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42ce0:	49 89 d0             	mov    %rdx,%r8
   42ce3:	89 c1                	mov    %eax,%ecx
   42ce5:	ba a0 48 04 00       	mov    $0x448a0,%edx
   42cea:	be 00 c0 00 00       	mov    $0xc000,%esi
   42cef:	bf e0 06 00 00       	mov    $0x6e0,%edi
   42cf4:	b8 00 00 00 00       	mov    $0x0,%eax
   42cf9:	e8 35 0f 00 00       	call   43c33 <console_printf>
            return -1;
   42cfe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42d03:	eb 77                	jmp    42d7c <program_load_segment+0x147>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42d05:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42d0c:	00 
   42d0d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42d11:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   42d15:	0f 82 76 ff ff ff    	jb     42c91 <program_load_segment+0x5c>
        }
    }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   42d1b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42d1f:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   42d26:	48 89 c7             	mov    %rax,%rdi
   42d29:	e8 d0 f7 ff ff       	call   424fe <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   42d2e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d32:	48 2b 45 f0          	sub    -0x10(%rbp),%rax
   42d36:	48 89 c2             	mov    %rax,%rdx
   42d39:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d3d:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42d41:	48 89 ce             	mov    %rcx,%rsi
   42d44:	48 89 c7             	mov    %rax,%rdi
   42d47:	e8 32 00 00 00       	call   42d7e <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   42d4c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42d50:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   42d54:	48 89 c2             	mov    %rax,%rdx
   42d57:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d5b:	be 00 00 00 00       	mov    $0x0,%esi
   42d60:	48 89 c7             	mov    %rax,%rdi
   42d63:	e8 14 01 00 00       	call   42e7c <memset>

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   42d68:	48 8b 05 91 12 01 00 	mov    0x11291(%rip),%rax        # 54000 <kernel_pagetable>
   42d6f:	48 89 c7             	mov    %rax,%rdi
   42d72:	e8 87 f7 ff ff       	call   424fe <set_pagetable>
    return 0;
   42d77:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42d7c:	c9                   	leave  
   42d7d:	c3                   	ret    

0000000000042d7e <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   42d7e:	55                   	push   %rbp
   42d7f:	48 89 e5             	mov    %rsp,%rbp
   42d82:	48 83 ec 28          	sub    $0x28,%rsp
   42d86:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42d8a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   42d8e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   42d92:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42d96:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   42d9a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d9e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   42da2:	eb 1c                	jmp    42dc0 <memcpy+0x42>
        *d = *s;
   42da4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42da8:	0f b6 10             	movzbl (%rax),%edx
   42dab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42daf:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   42db1:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   42db6:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   42dbb:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   42dc0:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   42dc5:	75 dd                	jne    42da4 <memcpy+0x26>
    }
    return dst;
   42dc7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   42dcb:	c9                   	leave  
   42dcc:	c3                   	ret    

0000000000042dcd <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   42dcd:	55                   	push   %rbp
   42dce:	48 89 e5             	mov    %rsp,%rbp
   42dd1:	48 83 ec 28          	sub    $0x28,%rsp
   42dd5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42dd9:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   42ddd:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   42de1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42de5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   42de9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ded:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   42df1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42df5:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   42df9:	73 6a                	jae    42e65 <memmove+0x98>
   42dfb:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42dff:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e03:	48 01 d0             	add    %rdx,%rax
   42e06:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   42e0a:	73 59                	jae    42e65 <memmove+0x98>
        s += n, d += n;
   42e0c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e10:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   42e14:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e18:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   42e1c:	eb 17                	jmp    42e35 <memmove+0x68>
            *--d = *--s;
   42e1e:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   42e23:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   42e28:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42e2c:	0f b6 10             	movzbl (%rax),%edx
   42e2f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e33:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   42e35:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e39:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   42e3d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   42e41:	48 85 c0             	test   %rax,%rax
   42e44:	75 d8                	jne    42e1e <memmove+0x51>
    if (s < d && s + n > d) {
   42e46:	eb 2e                	jmp    42e76 <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   42e48:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42e4c:	48 8d 42 01          	lea    0x1(%rdx),%rax
   42e50:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   42e54:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e58:	48 8d 48 01          	lea    0x1(%rax),%rcx
   42e5c:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   42e60:	0f b6 12             	movzbl (%rdx),%edx
   42e63:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   42e65:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e69:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   42e6d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   42e71:	48 85 c0             	test   %rax,%rax
   42e74:	75 d2                	jne    42e48 <memmove+0x7b>
        }
    }
    return dst;
   42e76:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   42e7a:	c9                   	leave  
   42e7b:	c3                   	ret    

0000000000042e7c <memset>:

void* memset(void* v, int c, size_t n) {
   42e7c:	55                   	push   %rbp
   42e7d:	48 89 e5             	mov    %rsp,%rbp
   42e80:	48 83 ec 28          	sub    $0x28,%rsp
   42e84:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42e88:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   42e8b:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   42e8f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42e93:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   42e97:	eb 15                	jmp    42eae <memset+0x32>
        *p = c;
   42e99:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   42e9c:	89 c2                	mov    %eax,%edx
   42e9e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42ea2:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   42ea4:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   42ea9:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   42eae:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   42eb3:	75 e4                	jne    42e99 <memset+0x1d>
    }
    return v;
   42eb5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   42eb9:	c9                   	leave  
   42eba:	c3                   	ret    

0000000000042ebb <strlen>:

size_t strlen(const char* s) {
   42ebb:	55                   	push   %rbp
   42ebc:	48 89 e5             	mov    %rsp,%rbp
   42ebf:	48 83 ec 18          	sub    $0x18,%rsp
   42ec3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   42ec7:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42ece:	00 
   42ecf:	eb 0a                	jmp    42edb <strlen+0x20>
        ++n;
   42ed1:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   42ed6:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   42edb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42edf:	0f b6 00             	movzbl (%rax),%eax
   42ee2:	84 c0                	test   %al,%al
   42ee4:	75 eb                	jne    42ed1 <strlen+0x16>
    }
    return n;
   42ee6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   42eea:	c9                   	leave  
   42eeb:	c3                   	ret    

0000000000042eec <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   42eec:	55                   	push   %rbp
   42eed:	48 89 e5             	mov    %rsp,%rbp
   42ef0:	48 83 ec 20          	sub    $0x20,%rsp
   42ef4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42ef8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   42efc:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42f03:	00 
   42f04:	eb 0a                	jmp    42f10 <strnlen+0x24>
        ++n;
   42f06:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   42f0b:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   42f10:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42f14:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   42f18:	74 0b                	je     42f25 <strnlen+0x39>
   42f1a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f1e:	0f b6 00             	movzbl (%rax),%eax
   42f21:	84 c0                	test   %al,%al
   42f23:	75 e1                	jne    42f06 <strnlen+0x1a>
    }
    return n;
   42f25:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   42f29:	c9                   	leave  
   42f2a:	c3                   	ret    

0000000000042f2b <strcpy>:

char* strcpy(char* dst, const char* src) {
   42f2b:	55                   	push   %rbp
   42f2c:	48 89 e5             	mov    %rsp,%rbp
   42f2f:	48 83 ec 20          	sub    $0x20,%rsp
   42f33:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42f37:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   42f3b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f3f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   42f43:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42f47:	48 8d 42 01          	lea    0x1(%rdx),%rax
   42f4b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   42f4f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42f53:	48 8d 48 01          	lea    0x1(%rax),%rcx
   42f57:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   42f5b:	0f b6 12             	movzbl (%rdx),%edx
   42f5e:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   42f60:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42f64:	48 83 e8 01          	sub    $0x1,%rax
   42f68:	0f b6 00             	movzbl (%rax),%eax
   42f6b:	84 c0                	test   %al,%al
   42f6d:	75 d4                	jne    42f43 <strcpy+0x18>
    return dst;
   42f6f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   42f73:	c9                   	leave  
   42f74:	c3                   	ret    

0000000000042f75 <strcmp>:

int strcmp(const char* a, const char* b) {
   42f75:	55                   	push   %rbp
   42f76:	48 89 e5             	mov    %rsp,%rbp
   42f79:	48 83 ec 10          	sub    $0x10,%rsp
   42f7d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42f81:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   42f85:	eb 0a                	jmp    42f91 <strcmp+0x1c>
        ++a, ++b;
   42f87:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   42f8c:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   42f91:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42f95:	0f b6 00             	movzbl (%rax),%eax
   42f98:	84 c0                	test   %al,%al
   42f9a:	74 1d                	je     42fb9 <strcmp+0x44>
   42f9c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42fa0:	0f b6 00             	movzbl (%rax),%eax
   42fa3:	84 c0                	test   %al,%al
   42fa5:	74 12                	je     42fb9 <strcmp+0x44>
   42fa7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42fab:	0f b6 10             	movzbl (%rax),%edx
   42fae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42fb2:	0f b6 00             	movzbl (%rax),%eax
   42fb5:	38 c2                	cmp    %al,%dl
   42fb7:	74 ce                	je     42f87 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   42fb9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42fbd:	0f b6 00             	movzbl (%rax),%eax
   42fc0:	89 c2                	mov    %eax,%edx
   42fc2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42fc6:	0f b6 00             	movzbl (%rax),%eax
   42fc9:	38 d0                	cmp    %dl,%al
   42fcb:	0f 92 c0             	setb   %al
   42fce:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   42fd1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42fd5:	0f b6 00             	movzbl (%rax),%eax
   42fd8:	89 c1                	mov    %eax,%ecx
   42fda:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42fde:	0f b6 00             	movzbl (%rax),%eax
   42fe1:	38 c1                	cmp    %al,%cl
   42fe3:	0f 92 c0             	setb   %al
   42fe6:	0f b6 c0             	movzbl %al,%eax
   42fe9:	29 c2                	sub    %eax,%edx
   42feb:	89 d0                	mov    %edx,%eax
}
   42fed:	c9                   	leave  
   42fee:	c3                   	ret    

0000000000042fef <strchr>:

char* strchr(const char* s, int c) {
   42fef:	55                   	push   %rbp
   42ff0:	48 89 e5             	mov    %rsp,%rbp
   42ff3:	48 83 ec 10          	sub    $0x10,%rsp
   42ff7:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42ffb:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   42ffe:	eb 05                	jmp    43005 <strchr+0x16>
        ++s;
   43000:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   43005:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43009:	0f b6 00             	movzbl (%rax),%eax
   4300c:	84 c0                	test   %al,%al
   4300e:	74 0e                	je     4301e <strchr+0x2f>
   43010:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43014:	0f b6 00             	movzbl (%rax),%eax
   43017:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4301a:	38 d0                	cmp    %dl,%al
   4301c:	75 e2                	jne    43000 <strchr+0x11>
    }
    if (*s == (char) c) {
   4301e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43022:	0f b6 00             	movzbl (%rax),%eax
   43025:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43028:	38 d0                	cmp    %dl,%al
   4302a:	75 06                	jne    43032 <strchr+0x43>
        return (char*) s;
   4302c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43030:	eb 05                	jmp    43037 <strchr+0x48>
    } else {
        return NULL;
   43032:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   43037:	c9                   	leave  
   43038:	c3                   	ret    

0000000000043039 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   43039:	55                   	push   %rbp
   4303a:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   4303d:	8b 05 bd 6f 01 00    	mov    0x16fbd(%rip),%eax        # 5a000 <rand_seed_set>
   43043:	85 c0                	test   %eax,%eax
   43045:	75 0a                	jne    43051 <rand+0x18>
        srand(819234718U);
   43047:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   4304c:	e8 24 00 00 00       	call   43075 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   43051:	8b 05 ad 6f 01 00    	mov    0x16fad(%rip),%eax        # 5a004 <rand_seed>
   43057:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   4305d:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   43062:	89 05 9c 6f 01 00    	mov    %eax,0x16f9c(%rip)        # 5a004 <rand_seed>
    return rand_seed & RAND_MAX;
   43068:	8b 05 96 6f 01 00    	mov    0x16f96(%rip),%eax        # 5a004 <rand_seed>
   4306e:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   43073:	5d                   	pop    %rbp
   43074:	c3                   	ret    

0000000000043075 <srand>:

void srand(unsigned seed) {
   43075:	55                   	push   %rbp
   43076:	48 89 e5             	mov    %rsp,%rbp
   43079:	48 83 ec 08          	sub    $0x8,%rsp
   4307d:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   43080:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43083:	89 05 7b 6f 01 00    	mov    %eax,0x16f7b(%rip)        # 5a004 <rand_seed>
    rand_seed_set = 1;
   43089:	c7 05 6d 6f 01 00 01 	movl   $0x1,0x16f6d(%rip)        # 5a000 <rand_seed_set>
   43090:	00 00 00 
}
   43093:	90                   	nop
   43094:	c9                   	leave  
   43095:	c3                   	ret    

0000000000043096 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   43096:	55                   	push   %rbp
   43097:	48 89 e5             	mov    %rsp,%rbp
   4309a:	48 83 ec 28          	sub    $0x28,%rsp
   4309e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   430a2:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   430a6:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   430a9:	48 c7 45 f8 c0 4a 04 	movq   $0x44ac0,-0x8(%rbp)
   430b0:	00 
    if (base < 0) {
   430b1:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   430b5:	79 0b                	jns    430c2 <fill_numbuf+0x2c>
        digits = lower_digits;
   430b7:	48 c7 45 f8 e0 4a 04 	movq   $0x44ae0,-0x8(%rbp)
   430be:	00 
        base = -base;
   430bf:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   430c2:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   430c7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   430cb:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   430ce:	8b 45 dc             	mov    -0x24(%rbp),%eax
   430d1:	48 63 c8             	movslq %eax,%rcx
   430d4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   430d8:	ba 00 00 00 00       	mov    $0x0,%edx
   430dd:	48 f7 f1             	div    %rcx
   430e0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   430e4:	48 01 d0             	add    %rdx,%rax
   430e7:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   430ec:	0f b6 10             	movzbl (%rax),%edx
   430ef:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   430f3:	88 10                	mov    %dl,(%rax)
        val /= base;
   430f5:	8b 45 dc             	mov    -0x24(%rbp),%eax
   430f8:	48 63 f0             	movslq %eax,%rsi
   430fb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   430ff:	ba 00 00 00 00       	mov    $0x0,%edx
   43104:	48 f7 f6             	div    %rsi
   43107:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   4310b:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43110:	75 bc                	jne    430ce <fill_numbuf+0x38>
    return numbuf_end;
   43112:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43116:	c9                   	leave  
   43117:	c3                   	ret    

0000000000043118 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   43118:	55                   	push   %rbp
   43119:	48 89 e5             	mov    %rsp,%rbp
   4311c:	53                   	push   %rbx
   4311d:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   43124:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   4312b:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   43131:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43138:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   4313f:	e9 8a 09 00 00       	jmp    43ace <printer_vprintf+0x9b6>
        if (*format != '%') {
   43144:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4314b:	0f b6 00             	movzbl (%rax),%eax
   4314e:	3c 25                	cmp    $0x25,%al
   43150:	74 31                	je     43183 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
   43152:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43159:	4c 8b 00             	mov    (%rax),%r8
   4315c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43163:	0f b6 00             	movzbl (%rax),%eax
   43166:	0f b6 c8             	movzbl %al,%ecx
   43169:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   4316f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43176:	89 ce                	mov    %ecx,%esi
   43178:	48 89 c7             	mov    %rax,%rdi
   4317b:	41 ff d0             	call   *%r8
            continue;
   4317e:	e9 43 09 00 00       	jmp    43ac6 <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
   43183:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   4318a:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43191:	01 
   43192:	eb 44                	jmp    431d8 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
   43194:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4319b:	0f b6 00             	movzbl (%rax),%eax
   4319e:	0f be c0             	movsbl %al,%eax
   431a1:	89 c6                	mov    %eax,%esi
   431a3:	bf e0 48 04 00       	mov    $0x448e0,%edi
   431a8:	e8 42 fe ff ff       	call   42fef <strchr>
   431ad:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   431b1:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   431b6:	74 30                	je     431e8 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
   431b8:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   431bc:	48 2d e0 48 04 00    	sub    $0x448e0,%rax
   431c2:	ba 01 00 00 00       	mov    $0x1,%edx
   431c7:	89 c1                	mov    %eax,%ecx
   431c9:	d3 e2                	shl    %cl,%edx
   431cb:	89 d0                	mov    %edx,%eax
   431cd:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   431d0:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   431d7:	01 
   431d8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   431df:	0f b6 00             	movzbl (%rax),%eax
   431e2:	84 c0                	test   %al,%al
   431e4:	75 ae                	jne    43194 <printer_vprintf+0x7c>
   431e6:	eb 01                	jmp    431e9 <printer_vprintf+0xd1>
            } else {
                break;
   431e8:	90                   	nop
            }
        }

        // process width
        int width = -1;
   431e9:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   431f0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   431f7:	0f b6 00             	movzbl (%rax),%eax
   431fa:	3c 30                	cmp    $0x30,%al
   431fc:	7e 67                	jle    43265 <printer_vprintf+0x14d>
   431fe:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43205:	0f b6 00             	movzbl (%rax),%eax
   43208:	3c 39                	cmp    $0x39,%al
   4320a:	7f 59                	jg     43265 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   4320c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   43213:	eb 2e                	jmp    43243 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
   43215:	8b 55 e8             	mov    -0x18(%rbp),%edx
   43218:	89 d0                	mov    %edx,%eax
   4321a:	c1 e0 02             	shl    $0x2,%eax
   4321d:	01 d0                	add    %edx,%eax
   4321f:	01 c0                	add    %eax,%eax
   43221:	89 c1                	mov    %eax,%ecx
   43223:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4322a:	48 8d 50 01          	lea    0x1(%rax),%rdx
   4322e:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43235:	0f b6 00             	movzbl (%rax),%eax
   43238:	0f be c0             	movsbl %al,%eax
   4323b:	01 c8                	add    %ecx,%eax
   4323d:	83 e8 30             	sub    $0x30,%eax
   43240:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43243:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4324a:	0f b6 00             	movzbl (%rax),%eax
   4324d:	3c 2f                	cmp    $0x2f,%al
   4324f:	0f 8e 85 00 00 00    	jle    432da <printer_vprintf+0x1c2>
   43255:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4325c:	0f b6 00             	movzbl (%rax),%eax
   4325f:	3c 39                	cmp    $0x39,%al
   43261:	7e b2                	jle    43215 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
   43263:	eb 75                	jmp    432da <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
   43265:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4326c:	0f b6 00             	movzbl (%rax),%eax
   4326f:	3c 2a                	cmp    $0x2a,%al
   43271:	75 68                	jne    432db <printer_vprintf+0x1c3>
            width = va_arg(val, int);
   43273:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4327a:	8b 00                	mov    (%rax),%eax
   4327c:	83 f8 2f             	cmp    $0x2f,%eax
   4327f:	77 30                	ja     432b1 <printer_vprintf+0x199>
   43281:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43288:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4328c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43293:	8b 00                	mov    (%rax),%eax
   43295:	89 c0                	mov    %eax,%eax
   43297:	48 01 d0             	add    %rdx,%rax
   4329a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   432a1:	8b 12                	mov    (%rdx),%edx
   432a3:	8d 4a 08             	lea    0x8(%rdx),%ecx
   432a6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   432ad:	89 0a                	mov    %ecx,(%rdx)
   432af:	eb 1a                	jmp    432cb <printer_vprintf+0x1b3>
   432b1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   432b8:	48 8b 40 08          	mov    0x8(%rax),%rax
   432bc:	48 8d 48 08          	lea    0x8(%rax),%rcx
   432c0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   432c7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   432cb:	8b 00                	mov    (%rax),%eax
   432cd:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   432d0:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   432d7:	01 
   432d8:	eb 01                	jmp    432db <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
   432da:	90                   	nop
        }

        // process precision
        int precision = -1;
   432db:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   432e2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   432e9:	0f b6 00             	movzbl (%rax),%eax
   432ec:	3c 2e                	cmp    $0x2e,%al
   432ee:	0f 85 00 01 00 00    	jne    433f4 <printer_vprintf+0x2dc>
            ++format;
   432f4:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   432fb:	01 
            if (*format >= '0' && *format <= '9') {
   432fc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43303:	0f b6 00             	movzbl (%rax),%eax
   43306:	3c 2f                	cmp    $0x2f,%al
   43308:	7e 67                	jle    43371 <printer_vprintf+0x259>
   4330a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43311:	0f b6 00             	movzbl (%rax),%eax
   43314:	3c 39                	cmp    $0x39,%al
   43316:	7f 59                	jg     43371 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43318:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   4331f:	eb 2e                	jmp    4334f <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
   43321:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   43324:	89 d0                	mov    %edx,%eax
   43326:	c1 e0 02             	shl    $0x2,%eax
   43329:	01 d0                	add    %edx,%eax
   4332b:	01 c0                	add    %eax,%eax
   4332d:	89 c1                	mov    %eax,%ecx
   4332f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43336:	48 8d 50 01          	lea    0x1(%rax),%rdx
   4333a:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43341:	0f b6 00             	movzbl (%rax),%eax
   43344:	0f be c0             	movsbl %al,%eax
   43347:	01 c8                	add    %ecx,%eax
   43349:	83 e8 30             	sub    $0x30,%eax
   4334c:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   4334f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43356:	0f b6 00             	movzbl (%rax),%eax
   43359:	3c 2f                	cmp    $0x2f,%al
   4335b:	0f 8e 85 00 00 00    	jle    433e6 <printer_vprintf+0x2ce>
   43361:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43368:	0f b6 00             	movzbl (%rax),%eax
   4336b:	3c 39                	cmp    $0x39,%al
   4336d:	7e b2                	jle    43321 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
   4336f:	eb 75                	jmp    433e6 <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
   43371:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43378:	0f b6 00             	movzbl (%rax),%eax
   4337b:	3c 2a                	cmp    $0x2a,%al
   4337d:	75 68                	jne    433e7 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
   4337f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43386:	8b 00                	mov    (%rax),%eax
   43388:	83 f8 2f             	cmp    $0x2f,%eax
   4338b:	77 30                	ja     433bd <printer_vprintf+0x2a5>
   4338d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43394:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43398:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4339f:	8b 00                	mov    (%rax),%eax
   433a1:	89 c0                	mov    %eax,%eax
   433a3:	48 01 d0             	add    %rdx,%rax
   433a6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   433ad:	8b 12                	mov    (%rdx),%edx
   433af:	8d 4a 08             	lea    0x8(%rdx),%ecx
   433b2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   433b9:	89 0a                	mov    %ecx,(%rdx)
   433bb:	eb 1a                	jmp    433d7 <printer_vprintf+0x2bf>
   433bd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   433c4:	48 8b 40 08          	mov    0x8(%rax),%rax
   433c8:	48 8d 48 08          	lea    0x8(%rax),%rcx
   433cc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   433d3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   433d7:	8b 00                	mov    (%rax),%eax
   433d9:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   433dc:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   433e3:	01 
   433e4:	eb 01                	jmp    433e7 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
   433e6:	90                   	nop
            }
            if (precision < 0) {
   433e7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   433eb:	79 07                	jns    433f4 <printer_vprintf+0x2dc>
                precision = 0;
   433ed:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   433f4:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   433fb:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   43402:	00 
        int length = 0;
   43403:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   4340a:	48 c7 45 c8 e6 48 04 	movq   $0x448e6,-0x38(%rbp)
   43411:	00 
    again:
        switch (*format) {
   43412:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43419:	0f b6 00             	movzbl (%rax),%eax
   4341c:	0f be c0             	movsbl %al,%eax
   4341f:	83 e8 43             	sub    $0x43,%eax
   43422:	83 f8 37             	cmp    $0x37,%eax
   43425:	0f 87 9f 03 00 00    	ja     437ca <printer_vprintf+0x6b2>
   4342b:	89 c0                	mov    %eax,%eax
   4342d:	48 8b 04 c5 f8 48 04 	mov    0x448f8(,%rax,8),%rax
   43434:	00 
   43435:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
   43437:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   4343e:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43445:	01 
            goto again;
   43446:	eb ca                	jmp    43412 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   43448:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   4344c:	74 5d                	je     434ab <printer_vprintf+0x393>
   4344e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43455:	8b 00                	mov    (%rax),%eax
   43457:	83 f8 2f             	cmp    $0x2f,%eax
   4345a:	77 30                	ja     4348c <printer_vprintf+0x374>
   4345c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43463:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43467:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4346e:	8b 00                	mov    (%rax),%eax
   43470:	89 c0                	mov    %eax,%eax
   43472:	48 01 d0             	add    %rdx,%rax
   43475:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4347c:	8b 12                	mov    (%rdx),%edx
   4347e:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43481:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43488:	89 0a                	mov    %ecx,(%rdx)
   4348a:	eb 1a                	jmp    434a6 <printer_vprintf+0x38e>
   4348c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43493:	48 8b 40 08          	mov    0x8(%rax),%rax
   43497:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4349b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   434a2:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   434a6:	48 8b 00             	mov    (%rax),%rax
   434a9:	eb 5c                	jmp    43507 <printer_vprintf+0x3ef>
   434ab:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   434b2:	8b 00                	mov    (%rax),%eax
   434b4:	83 f8 2f             	cmp    $0x2f,%eax
   434b7:	77 30                	ja     434e9 <printer_vprintf+0x3d1>
   434b9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   434c0:	48 8b 50 10          	mov    0x10(%rax),%rdx
   434c4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   434cb:	8b 00                	mov    (%rax),%eax
   434cd:	89 c0                	mov    %eax,%eax
   434cf:	48 01 d0             	add    %rdx,%rax
   434d2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   434d9:	8b 12                	mov    (%rdx),%edx
   434db:	8d 4a 08             	lea    0x8(%rdx),%ecx
   434de:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   434e5:	89 0a                	mov    %ecx,(%rdx)
   434e7:	eb 1a                	jmp    43503 <printer_vprintf+0x3eb>
   434e9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   434f0:	48 8b 40 08          	mov    0x8(%rax),%rax
   434f4:	48 8d 48 08          	lea    0x8(%rax),%rcx
   434f8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   434ff:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43503:	8b 00                	mov    (%rax),%eax
   43505:	48 98                	cltq   
   43507:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   4350b:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4350f:	48 c1 f8 38          	sar    $0x38,%rax
   43513:	25 80 00 00 00       	and    $0x80,%eax
   43518:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   4351b:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   4351f:	74 09                	je     4352a <printer_vprintf+0x412>
   43521:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43525:	48 f7 d8             	neg    %rax
   43528:	eb 04                	jmp    4352e <printer_vprintf+0x416>
   4352a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4352e:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   43532:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   43535:	83 c8 60             	or     $0x60,%eax
   43538:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   4353b:	e9 cf 02 00 00       	jmp    4380f <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   43540:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43544:	74 5d                	je     435a3 <printer_vprintf+0x48b>
   43546:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4354d:	8b 00                	mov    (%rax),%eax
   4354f:	83 f8 2f             	cmp    $0x2f,%eax
   43552:	77 30                	ja     43584 <printer_vprintf+0x46c>
   43554:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4355b:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4355f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43566:	8b 00                	mov    (%rax),%eax
   43568:	89 c0                	mov    %eax,%eax
   4356a:	48 01 d0             	add    %rdx,%rax
   4356d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43574:	8b 12                	mov    (%rdx),%edx
   43576:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43579:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43580:	89 0a                	mov    %ecx,(%rdx)
   43582:	eb 1a                	jmp    4359e <printer_vprintf+0x486>
   43584:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4358b:	48 8b 40 08          	mov    0x8(%rax),%rax
   4358f:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43593:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4359a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4359e:	48 8b 00             	mov    (%rax),%rax
   435a1:	eb 5c                	jmp    435ff <printer_vprintf+0x4e7>
   435a3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   435aa:	8b 00                	mov    (%rax),%eax
   435ac:	83 f8 2f             	cmp    $0x2f,%eax
   435af:	77 30                	ja     435e1 <printer_vprintf+0x4c9>
   435b1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   435b8:	48 8b 50 10          	mov    0x10(%rax),%rdx
   435bc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   435c3:	8b 00                	mov    (%rax),%eax
   435c5:	89 c0                	mov    %eax,%eax
   435c7:	48 01 d0             	add    %rdx,%rax
   435ca:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   435d1:	8b 12                	mov    (%rdx),%edx
   435d3:	8d 4a 08             	lea    0x8(%rdx),%ecx
   435d6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   435dd:	89 0a                	mov    %ecx,(%rdx)
   435df:	eb 1a                	jmp    435fb <printer_vprintf+0x4e3>
   435e1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   435e8:	48 8b 40 08          	mov    0x8(%rax),%rax
   435ec:	48 8d 48 08          	lea    0x8(%rax),%rcx
   435f0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   435f7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   435fb:	8b 00                	mov    (%rax),%eax
   435fd:	89 c0                	mov    %eax,%eax
   435ff:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   43603:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   43607:	e9 03 02 00 00       	jmp    4380f <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
   4360c:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   43613:	e9 28 ff ff ff       	jmp    43540 <printer_vprintf+0x428>
        case 'X':
            base = 16;
   43618:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   4361f:	e9 1c ff ff ff       	jmp    43540 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   43624:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4362b:	8b 00                	mov    (%rax),%eax
   4362d:	83 f8 2f             	cmp    $0x2f,%eax
   43630:	77 30                	ja     43662 <printer_vprintf+0x54a>
   43632:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43639:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4363d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43644:	8b 00                	mov    (%rax),%eax
   43646:	89 c0                	mov    %eax,%eax
   43648:	48 01 d0             	add    %rdx,%rax
   4364b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43652:	8b 12                	mov    (%rdx),%edx
   43654:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43657:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4365e:	89 0a                	mov    %ecx,(%rdx)
   43660:	eb 1a                	jmp    4367c <printer_vprintf+0x564>
   43662:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43669:	48 8b 40 08          	mov    0x8(%rax),%rax
   4366d:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43671:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43678:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4367c:	48 8b 00             	mov    (%rax),%rax
   4367f:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   43683:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   4368a:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   43691:	e9 79 01 00 00       	jmp    4380f <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
   43696:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4369d:	8b 00                	mov    (%rax),%eax
   4369f:	83 f8 2f             	cmp    $0x2f,%eax
   436a2:	77 30                	ja     436d4 <printer_vprintf+0x5bc>
   436a4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   436ab:	48 8b 50 10          	mov    0x10(%rax),%rdx
   436af:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   436b6:	8b 00                	mov    (%rax),%eax
   436b8:	89 c0                	mov    %eax,%eax
   436ba:	48 01 d0             	add    %rdx,%rax
   436bd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   436c4:	8b 12                	mov    (%rdx),%edx
   436c6:	8d 4a 08             	lea    0x8(%rdx),%ecx
   436c9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   436d0:	89 0a                	mov    %ecx,(%rdx)
   436d2:	eb 1a                	jmp    436ee <printer_vprintf+0x5d6>
   436d4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   436db:	48 8b 40 08          	mov    0x8(%rax),%rax
   436df:	48 8d 48 08          	lea    0x8(%rax),%rcx
   436e3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   436ea:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   436ee:	48 8b 00             	mov    (%rax),%rax
   436f1:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   436f5:	e9 15 01 00 00       	jmp    4380f <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
   436fa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43701:	8b 00                	mov    (%rax),%eax
   43703:	83 f8 2f             	cmp    $0x2f,%eax
   43706:	77 30                	ja     43738 <printer_vprintf+0x620>
   43708:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4370f:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43713:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4371a:	8b 00                	mov    (%rax),%eax
   4371c:	89 c0                	mov    %eax,%eax
   4371e:	48 01 d0             	add    %rdx,%rax
   43721:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43728:	8b 12                	mov    (%rdx),%edx
   4372a:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4372d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43734:	89 0a                	mov    %ecx,(%rdx)
   43736:	eb 1a                	jmp    43752 <printer_vprintf+0x63a>
   43738:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4373f:	48 8b 40 08          	mov    0x8(%rax),%rax
   43743:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43747:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4374e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43752:	8b 00                	mov    (%rax),%eax
   43754:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   4375a:	e9 67 03 00 00       	jmp    43ac6 <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
   4375f:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   43763:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   43767:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4376e:	8b 00                	mov    (%rax),%eax
   43770:	83 f8 2f             	cmp    $0x2f,%eax
   43773:	77 30                	ja     437a5 <printer_vprintf+0x68d>
   43775:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4377c:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43780:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43787:	8b 00                	mov    (%rax),%eax
   43789:	89 c0                	mov    %eax,%eax
   4378b:	48 01 d0             	add    %rdx,%rax
   4378e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43795:	8b 12                	mov    (%rdx),%edx
   43797:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4379a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   437a1:	89 0a                	mov    %ecx,(%rdx)
   437a3:	eb 1a                	jmp    437bf <printer_vprintf+0x6a7>
   437a5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   437ac:	48 8b 40 08          	mov    0x8(%rax),%rax
   437b0:	48 8d 48 08          	lea    0x8(%rax),%rcx
   437b4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   437bb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   437bf:	8b 00                	mov    (%rax),%eax
   437c1:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   437c4:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   437c8:	eb 45                	jmp    4380f <printer_vprintf+0x6f7>
        default:
            data = numbuf;
   437ca:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   437ce:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   437d2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   437d9:	0f b6 00             	movzbl (%rax),%eax
   437dc:	84 c0                	test   %al,%al
   437de:	74 0c                	je     437ec <printer_vprintf+0x6d4>
   437e0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   437e7:	0f b6 00             	movzbl (%rax),%eax
   437ea:	eb 05                	jmp    437f1 <printer_vprintf+0x6d9>
   437ec:	b8 25 00 00 00       	mov    $0x25,%eax
   437f1:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   437f4:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   437f8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   437ff:	0f b6 00             	movzbl (%rax),%eax
   43802:	84 c0                	test   %al,%al
   43804:	75 08                	jne    4380e <printer_vprintf+0x6f6>
                format--;
   43806:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   4380d:	01 
            }
            break;
   4380e:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   4380f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43812:	83 e0 20             	and    $0x20,%eax
   43815:	85 c0                	test   %eax,%eax
   43817:	74 1e                	je     43837 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   43819:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   4381d:	48 83 c0 18          	add    $0x18,%rax
   43821:	8b 55 e0             	mov    -0x20(%rbp),%edx
   43824:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   43828:	48 89 ce             	mov    %rcx,%rsi
   4382b:	48 89 c7             	mov    %rax,%rdi
   4382e:	e8 63 f8 ff ff       	call   43096 <fill_numbuf>
   43833:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   43837:	48 c7 45 c0 e6 48 04 	movq   $0x448e6,-0x40(%rbp)
   4383e:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   4383f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43842:	83 e0 20             	and    $0x20,%eax
   43845:	85 c0                	test   %eax,%eax
   43847:	74 48                	je     43891 <printer_vprintf+0x779>
   43849:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4384c:	83 e0 40             	and    $0x40,%eax
   4384f:	85 c0                	test   %eax,%eax
   43851:	74 3e                	je     43891 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
   43853:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43856:	25 80 00 00 00       	and    $0x80,%eax
   4385b:	85 c0                	test   %eax,%eax
   4385d:	74 0a                	je     43869 <printer_vprintf+0x751>
                prefix = "-";
   4385f:	48 c7 45 c0 e7 48 04 	movq   $0x448e7,-0x40(%rbp)
   43866:	00 
            if (flags & FLAG_NEGATIVE) {
   43867:	eb 73                	jmp    438dc <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   43869:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4386c:	83 e0 10             	and    $0x10,%eax
   4386f:	85 c0                	test   %eax,%eax
   43871:	74 0a                	je     4387d <printer_vprintf+0x765>
                prefix = "+";
   43873:	48 c7 45 c0 e9 48 04 	movq   $0x448e9,-0x40(%rbp)
   4387a:	00 
            if (flags & FLAG_NEGATIVE) {
   4387b:	eb 5f                	jmp    438dc <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   4387d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43880:	83 e0 08             	and    $0x8,%eax
   43883:	85 c0                	test   %eax,%eax
   43885:	74 55                	je     438dc <printer_vprintf+0x7c4>
                prefix = " ";
   43887:	48 c7 45 c0 eb 48 04 	movq   $0x448eb,-0x40(%rbp)
   4388e:	00 
            if (flags & FLAG_NEGATIVE) {
   4388f:	eb 4b                	jmp    438dc <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   43891:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43894:	83 e0 20             	and    $0x20,%eax
   43897:	85 c0                	test   %eax,%eax
   43899:	74 42                	je     438dd <printer_vprintf+0x7c5>
   4389b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4389e:	83 e0 01             	and    $0x1,%eax
   438a1:	85 c0                	test   %eax,%eax
   438a3:	74 38                	je     438dd <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
   438a5:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   438a9:	74 06                	je     438b1 <printer_vprintf+0x799>
   438ab:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   438af:	75 2c                	jne    438dd <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
   438b1:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   438b6:	75 0c                	jne    438c4 <printer_vprintf+0x7ac>
   438b8:	8b 45 ec             	mov    -0x14(%rbp),%eax
   438bb:	25 00 01 00 00       	and    $0x100,%eax
   438c0:	85 c0                	test   %eax,%eax
   438c2:	74 19                	je     438dd <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
   438c4:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   438c8:	75 07                	jne    438d1 <printer_vprintf+0x7b9>
   438ca:	b8 ed 48 04 00       	mov    $0x448ed,%eax
   438cf:	eb 05                	jmp    438d6 <printer_vprintf+0x7be>
   438d1:	b8 f0 48 04 00       	mov    $0x448f0,%eax
   438d6:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   438da:	eb 01                	jmp    438dd <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
   438dc:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   438dd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   438e1:	78 24                	js     43907 <printer_vprintf+0x7ef>
   438e3:	8b 45 ec             	mov    -0x14(%rbp),%eax
   438e6:	83 e0 20             	and    $0x20,%eax
   438e9:	85 c0                	test   %eax,%eax
   438eb:	75 1a                	jne    43907 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
   438ed:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   438f0:	48 63 d0             	movslq %eax,%rdx
   438f3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   438f7:	48 89 d6             	mov    %rdx,%rsi
   438fa:	48 89 c7             	mov    %rax,%rdi
   438fd:	e8 ea f5 ff ff       	call   42eec <strnlen>
   43902:	89 45 bc             	mov    %eax,-0x44(%rbp)
   43905:	eb 0f                	jmp    43916 <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
   43907:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4390b:	48 89 c7             	mov    %rax,%rdi
   4390e:	e8 a8 f5 ff ff       	call   42ebb <strlen>
   43913:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   43916:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43919:	83 e0 20             	and    $0x20,%eax
   4391c:	85 c0                	test   %eax,%eax
   4391e:	74 20                	je     43940 <printer_vprintf+0x828>
   43920:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   43924:	78 1a                	js     43940 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
   43926:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43929:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   4392c:	7e 08                	jle    43936 <printer_vprintf+0x81e>
   4392e:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43931:	2b 45 bc             	sub    -0x44(%rbp),%eax
   43934:	eb 05                	jmp    4393b <printer_vprintf+0x823>
   43936:	b8 00 00 00 00       	mov    $0x0,%eax
   4393b:	89 45 b8             	mov    %eax,-0x48(%rbp)
   4393e:	eb 5c                	jmp    4399c <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   43940:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43943:	83 e0 20             	and    $0x20,%eax
   43946:	85 c0                	test   %eax,%eax
   43948:	74 4b                	je     43995 <printer_vprintf+0x87d>
   4394a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4394d:	83 e0 02             	and    $0x2,%eax
   43950:	85 c0                	test   %eax,%eax
   43952:	74 41                	je     43995 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
   43954:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43957:	83 e0 04             	and    $0x4,%eax
   4395a:	85 c0                	test   %eax,%eax
   4395c:	75 37                	jne    43995 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
   4395e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43962:	48 89 c7             	mov    %rax,%rdi
   43965:	e8 51 f5 ff ff       	call   42ebb <strlen>
   4396a:	89 c2                	mov    %eax,%edx
   4396c:	8b 45 bc             	mov    -0x44(%rbp),%eax
   4396f:	01 d0                	add    %edx,%eax
   43971:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   43974:	7e 1f                	jle    43995 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
   43976:	8b 45 e8             	mov    -0x18(%rbp),%eax
   43979:	2b 45 bc             	sub    -0x44(%rbp),%eax
   4397c:	89 c3                	mov    %eax,%ebx
   4397e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43982:	48 89 c7             	mov    %rax,%rdi
   43985:	e8 31 f5 ff ff       	call   42ebb <strlen>
   4398a:	89 c2                	mov    %eax,%edx
   4398c:	89 d8                	mov    %ebx,%eax
   4398e:	29 d0                	sub    %edx,%eax
   43990:	89 45 b8             	mov    %eax,-0x48(%rbp)
   43993:	eb 07                	jmp    4399c <printer_vprintf+0x884>
        } else {
            zeros = 0;
   43995:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   4399c:	8b 55 bc             	mov    -0x44(%rbp),%edx
   4399f:	8b 45 b8             	mov    -0x48(%rbp),%eax
   439a2:	01 d0                	add    %edx,%eax
   439a4:	48 63 d8             	movslq %eax,%rbx
   439a7:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   439ab:	48 89 c7             	mov    %rax,%rdi
   439ae:	e8 08 f5 ff ff       	call   42ebb <strlen>
   439b3:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   439b7:	8b 45 e8             	mov    -0x18(%rbp),%eax
   439ba:	29 d0                	sub    %edx,%eax
   439bc:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   439bf:	eb 25                	jmp    439e6 <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
   439c1:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   439c8:	48 8b 08             	mov    (%rax),%rcx
   439cb:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   439d1:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   439d8:	be 20 00 00 00       	mov    $0x20,%esi
   439dd:	48 89 c7             	mov    %rax,%rdi
   439e0:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   439e2:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   439e6:	8b 45 ec             	mov    -0x14(%rbp),%eax
   439e9:	83 e0 04             	and    $0x4,%eax
   439ec:	85 c0                	test   %eax,%eax
   439ee:	75 36                	jne    43a26 <printer_vprintf+0x90e>
   439f0:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   439f4:	7f cb                	jg     439c1 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
   439f6:	eb 2e                	jmp    43a26 <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
   439f8:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   439ff:	4c 8b 00             	mov    (%rax),%r8
   43a02:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43a06:	0f b6 00             	movzbl (%rax),%eax
   43a09:	0f b6 c8             	movzbl %al,%ecx
   43a0c:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43a12:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43a19:	89 ce                	mov    %ecx,%esi
   43a1b:	48 89 c7             	mov    %rax,%rdi
   43a1e:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   43a21:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   43a26:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43a2a:	0f b6 00             	movzbl (%rax),%eax
   43a2d:	84 c0                	test   %al,%al
   43a2f:	75 c7                	jne    439f8 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
   43a31:	eb 25                	jmp    43a58 <printer_vprintf+0x940>
            p->putc(p, '0', color);
   43a33:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43a3a:	48 8b 08             	mov    (%rax),%rcx
   43a3d:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43a43:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43a4a:	be 30 00 00 00       	mov    $0x30,%esi
   43a4f:	48 89 c7             	mov    %rax,%rdi
   43a52:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   43a54:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   43a58:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   43a5c:	7f d5                	jg     43a33 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
   43a5e:	eb 32                	jmp    43a92 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
   43a60:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43a67:	4c 8b 00             	mov    (%rax),%r8
   43a6a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43a6e:	0f b6 00             	movzbl (%rax),%eax
   43a71:	0f b6 c8             	movzbl %al,%ecx
   43a74:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43a7a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43a81:	89 ce                	mov    %ecx,%esi
   43a83:	48 89 c7             	mov    %rax,%rdi
   43a86:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   43a89:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   43a8e:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   43a92:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   43a96:	7f c8                	jg     43a60 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
   43a98:	eb 25                	jmp    43abf <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
   43a9a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43aa1:	48 8b 08             	mov    (%rax),%rcx
   43aa4:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43aaa:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43ab1:	be 20 00 00 00       	mov    $0x20,%esi
   43ab6:	48 89 c7             	mov    %rax,%rdi
   43ab9:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   43abb:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   43abf:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   43ac3:	7f d5                	jg     43a9a <printer_vprintf+0x982>
        }
    done: ;
   43ac5:	90                   	nop
    for (; *format; ++format) {
   43ac6:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43acd:	01 
   43ace:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43ad5:	0f b6 00             	movzbl (%rax),%eax
   43ad8:	84 c0                	test   %al,%al
   43ada:	0f 85 64 f6 ff ff    	jne    43144 <printer_vprintf+0x2c>
    }
}
   43ae0:	90                   	nop
   43ae1:	90                   	nop
   43ae2:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   43ae6:	c9                   	leave  
   43ae7:	c3                   	ret    

0000000000043ae8 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   43ae8:	55                   	push   %rbp
   43ae9:	48 89 e5             	mov    %rsp,%rbp
   43aec:	48 83 ec 20          	sub    $0x20,%rsp
   43af0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43af4:	89 f0                	mov    %esi,%eax
   43af6:	89 55 e0             	mov    %edx,-0x20(%rbp)
   43af9:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   43afc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43b00:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   43b04:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43b08:	48 8b 40 08          	mov    0x8(%rax),%rax
   43b0c:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
   43b11:	48 39 d0             	cmp    %rdx,%rax
   43b14:	72 0c                	jb     43b22 <console_putc+0x3a>
        cp->cursor = console;
   43b16:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43b1a:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
   43b21:	00 
    }
    if (c == '\n') {
   43b22:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   43b26:	75 78                	jne    43ba0 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
   43b28:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43b2c:	48 8b 40 08          	mov    0x8(%rax),%rax
   43b30:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   43b36:	48 d1 f8             	sar    %rax
   43b39:	48 89 c1             	mov    %rax,%rcx
   43b3c:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   43b43:	66 66 66 
   43b46:	48 89 c8             	mov    %rcx,%rax
   43b49:	48 f7 ea             	imul   %rdx
   43b4c:	48 c1 fa 05          	sar    $0x5,%rdx
   43b50:	48 89 c8             	mov    %rcx,%rax
   43b53:	48 c1 f8 3f          	sar    $0x3f,%rax
   43b57:	48 29 c2             	sub    %rax,%rdx
   43b5a:	48 89 d0             	mov    %rdx,%rax
   43b5d:	48 c1 e0 02          	shl    $0x2,%rax
   43b61:	48 01 d0             	add    %rdx,%rax
   43b64:	48 c1 e0 04          	shl    $0x4,%rax
   43b68:	48 29 c1             	sub    %rax,%rcx
   43b6b:	48 89 ca             	mov    %rcx,%rdx
   43b6e:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   43b71:	eb 25                	jmp    43b98 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
   43b73:	8b 45 e0             	mov    -0x20(%rbp),%eax
   43b76:	83 c8 20             	or     $0x20,%eax
   43b79:	89 c6                	mov    %eax,%esi
   43b7b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43b7f:	48 8b 40 08          	mov    0x8(%rax),%rax
   43b83:	48 8d 48 02          	lea    0x2(%rax),%rcx
   43b87:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   43b8b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43b8f:	89 f2                	mov    %esi,%edx
   43b91:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   43b94:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   43b98:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   43b9c:	75 d5                	jne    43b73 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   43b9e:	eb 24                	jmp    43bc4 <console_putc+0xdc>
        *cp->cursor++ = c | color;
   43ba0:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
   43ba4:	8b 55 e0             	mov    -0x20(%rbp),%edx
   43ba7:	09 d0                	or     %edx,%eax
   43ba9:	89 c6                	mov    %eax,%esi
   43bab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43baf:	48 8b 40 08          	mov    0x8(%rax),%rax
   43bb3:	48 8d 48 02          	lea    0x2(%rax),%rcx
   43bb7:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   43bbb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43bbf:	89 f2                	mov    %esi,%edx
   43bc1:	66 89 10             	mov    %dx,(%rax)
}
   43bc4:	90                   	nop
   43bc5:	c9                   	leave  
   43bc6:	c3                   	ret    

0000000000043bc7 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   43bc7:	55                   	push   %rbp
   43bc8:	48 89 e5             	mov    %rsp,%rbp
   43bcb:	48 83 ec 30          	sub    $0x30,%rsp
   43bcf:	89 7d ec             	mov    %edi,-0x14(%rbp)
   43bd2:	89 75 e8             	mov    %esi,-0x18(%rbp)
   43bd5:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   43bd9:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   43bdd:	48 c7 45 f0 e8 3a 04 	movq   $0x43ae8,-0x10(%rbp)
   43be4:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   43be5:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   43be9:	78 09                	js     43bf4 <console_vprintf+0x2d>
   43beb:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   43bf2:	7e 07                	jle    43bfb <console_vprintf+0x34>
        cpos = 0;
   43bf4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   43bfb:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43bfe:	48 98                	cltq   
   43c00:	48 01 c0             	add    %rax,%rax
   43c03:	48 05 00 80 0b 00    	add    $0xb8000,%rax
   43c09:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   43c0d:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   43c11:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43c15:	8b 75 e8             	mov    -0x18(%rbp),%esi
   43c18:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   43c1c:	48 89 c7             	mov    %rax,%rdi
   43c1f:	e8 f4 f4 ff ff       	call   43118 <printer_vprintf>
    return cp.cursor - console;
   43c24:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c28:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   43c2e:	48 d1 f8             	sar    %rax
}
   43c31:	c9                   	leave  
   43c32:	c3                   	ret    

0000000000043c33 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   43c33:	55                   	push   %rbp
   43c34:	48 89 e5             	mov    %rsp,%rbp
   43c37:	48 83 ec 60          	sub    $0x60,%rsp
   43c3b:	89 7d ac             	mov    %edi,-0x54(%rbp)
   43c3e:	89 75 a8             	mov    %esi,-0x58(%rbp)
   43c41:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   43c45:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   43c49:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   43c4d:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   43c51:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   43c58:	48 8d 45 10          	lea    0x10(%rbp),%rax
   43c5c:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   43c60:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   43c64:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   43c68:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   43c6c:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   43c70:	8b 75 a8             	mov    -0x58(%rbp),%esi
   43c73:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43c76:	89 c7                	mov    %eax,%edi
   43c78:	e8 4a ff ff ff       	call   43bc7 <console_vprintf>
   43c7d:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   43c80:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   43c83:	c9                   	leave  
   43c84:	c3                   	ret    

0000000000043c85 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   43c85:	55                   	push   %rbp
   43c86:	48 89 e5             	mov    %rsp,%rbp
   43c89:	48 83 ec 20          	sub    $0x20,%rsp
   43c8d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43c91:	89 f0                	mov    %esi,%eax
   43c93:	89 55 e0             	mov    %edx,-0x20(%rbp)
   43c96:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   43c99:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43c9d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   43ca1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43ca5:	48 8b 50 08          	mov    0x8(%rax),%rdx
   43ca9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43cad:	48 8b 40 10          	mov    0x10(%rax),%rax
   43cb1:	48 39 c2             	cmp    %rax,%rdx
   43cb4:	73 1a                	jae    43cd0 <string_putc+0x4b>
        *sp->s++ = c;
   43cb6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43cba:	48 8b 40 08          	mov    0x8(%rax),%rax
   43cbe:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43cc2:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43cc6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43cca:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   43cce:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   43cd0:	90                   	nop
   43cd1:	c9                   	leave  
   43cd2:	c3                   	ret    

0000000000043cd3 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   43cd3:	55                   	push   %rbp
   43cd4:	48 89 e5             	mov    %rsp,%rbp
   43cd7:	48 83 ec 40          	sub    $0x40,%rsp
   43cdb:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   43cdf:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   43ce3:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   43ce7:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   43ceb:	48 c7 45 e8 85 3c 04 	movq   $0x43c85,-0x18(%rbp)
   43cf2:	00 
    sp.s = s;
   43cf3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43cf7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   43cfb:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   43d00:	74 33                	je     43d35 <vsnprintf+0x62>
        sp.end = s + size - 1;
   43d02:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43d06:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43d0a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43d0e:	48 01 d0             	add    %rdx,%rax
   43d11:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   43d15:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   43d19:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   43d1d:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   43d21:	be 00 00 00 00       	mov    $0x0,%esi
   43d26:	48 89 c7             	mov    %rax,%rdi
   43d29:	e8 ea f3 ff ff       	call   43118 <printer_vprintf>
        *sp.s = 0;
   43d2e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43d32:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   43d35:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43d39:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   43d3d:	c9                   	leave  
   43d3e:	c3                   	ret    

0000000000043d3f <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   43d3f:	55                   	push   %rbp
   43d40:	48 89 e5             	mov    %rsp,%rbp
   43d43:	48 83 ec 70          	sub    $0x70,%rsp
   43d47:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   43d4b:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   43d4f:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   43d53:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   43d57:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   43d5b:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   43d5f:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   43d66:	48 8d 45 10          	lea    0x10(%rbp),%rax
   43d6a:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   43d6e:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   43d72:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   43d76:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   43d7a:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   43d7e:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   43d82:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43d86:	48 89 c7             	mov    %rax,%rdi
   43d89:	e8 45 ff ff ff       	call   43cd3 <vsnprintf>
   43d8e:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   43d91:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   43d94:	c9                   	leave  
   43d95:	c3                   	ret    

0000000000043d96 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   43d96:	55                   	push   %rbp
   43d97:	48 89 e5             	mov    %rsp,%rbp
   43d9a:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   43d9e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   43da5:	eb 13                	jmp    43dba <console_clear+0x24>
        console[i] = ' ' | 0x0700;
   43da7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43daa:	48 98                	cltq   
   43dac:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
   43db3:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   43db6:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   43dba:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   43dc1:	7e e4                	jle    43da7 <console_clear+0x11>
    }
    cursorpos = 0;
   43dc3:	c7 05 2f 52 07 00 00 	movl   $0x0,0x7522f(%rip)        # b8ffc <cursorpos>
   43dca:	00 00 00 
}
   43dcd:	90                   	nop
   43dce:	c9                   	leave  
   43dcf:	c3                   	ret    
