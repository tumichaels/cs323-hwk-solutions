
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
   400be:	e8 b4 06 00 00       	call   40777 <exception>

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

// kernel(command)
//    Initialize the hardware and processes and start running. The `command`
//    string is an optional string passed from the boot loader.

void kernel(const char* command) {
   40167:	55                   	push   %rbp
   40168:	48 89 e5             	mov    %rsp,%rbp
   4016b:	48 83 ec 20          	sub    $0x20,%rsp
   4016f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    hardware_init();
   40173:	e8 a1 14 00 00       	call   41619 <hardware_init>
    pageinfo_init();
   40178:	e8 15 0b 00 00       	call   40c92 <pageinfo_init>
    console_clear();
   4017d:	e8 3f 4a 00 00       	call   44bc1 <console_clear>
    timer_init(HZ);
   40182:	bf 64 00 00 00       	mov    $0x64,%edi
   40187:	e8 79 19 00 00       	call   41b05 <timer_init>

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   4018c:	ba 00 0f 00 00       	mov    $0xf00,%edx
   40191:	be 00 00 00 00       	mov    $0x0,%esi
   40196:	bf 00 f0 04 00       	mov    $0x4f000,%edi
   4019b:	e8 07 3b 00 00       	call   43ca7 <memset>
    for (pid_t i = 0; i < NPROC; i++) {
   401a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   401a7:	eb 44                	jmp    401ed <kernel+0x86>
        processes[i].p_pid = i;
   401a9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401ac:	48 63 d0             	movslq %eax,%rdx
   401af:	48 89 d0             	mov    %rdx,%rax
   401b2:	48 c1 e0 04          	shl    $0x4,%rax
   401b6:	48 29 d0             	sub    %rdx,%rax
   401b9:	48 c1 e0 04          	shl    $0x4,%rax
   401bd:	48 8d 90 00 f0 04 00 	lea    0x4f000(%rax),%rdx
   401c4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401c7:	89 02                	mov    %eax,(%rdx)
        processes[i].p_state = P_FREE;
   401c9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401cc:	48 63 d0             	movslq %eax,%rdx
   401cf:	48 89 d0             	mov    %rdx,%rax
   401d2:	48 c1 e0 04          	shl    $0x4,%rax
   401d6:	48 29 d0             	sub    %rdx,%rax
   401d9:	48 c1 e0 04          	shl    $0x4,%rax
   401dd:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   401e3:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
    for (pid_t i = 0; i < NPROC; i++) {
   401e9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   401ed:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   401f1:	7e b6                	jle    401a9 <kernel+0x42>
    }

    if (command && strcmp(command, "malloc") == 0) {
   401f3:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   401f8:	74 29                	je     40223 <kernel+0xbc>
   401fa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   401fe:	be 26 4c 04 00       	mov    $0x44c26,%esi
   40203:	48 89 c7             	mov    %rax,%rdi
   40206:	e8 95 3b 00 00       	call   43da0 <strcmp>
   4020b:	85 c0                	test   %eax,%eax
   4020d:	75 14                	jne    40223 <kernel+0xbc>
        process_setup(1, 1);
   4020f:	be 01 00 00 00       	mov    $0x1,%esi
   40214:	bf 01 00 00 00       	mov    $0x1,%edi
   40219:	e8 b8 00 00 00       	call   402d6 <process_setup>
   4021e:	e9 a9 00 00 00       	jmp    402cc <kernel+0x165>
    } else if (command && strcmp(command, "alloctests") == 0) {
   40223:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40228:	74 26                	je     40250 <kernel+0xe9>
   4022a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4022e:	be 2d 4c 04 00       	mov    $0x44c2d,%esi
   40233:	48 89 c7             	mov    %rax,%rdi
   40236:	e8 65 3b 00 00       	call   43da0 <strcmp>
   4023b:	85 c0                	test   %eax,%eax
   4023d:	75 11                	jne    40250 <kernel+0xe9>
        process_setup(1, 2);
   4023f:	be 02 00 00 00       	mov    $0x2,%esi
   40244:	bf 01 00 00 00       	mov    $0x1,%edi
   40249:	e8 88 00 00 00       	call   402d6 <process_setup>
   4024e:	eb 7c                	jmp    402cc <kernel+0x165>
    } else if (command && strcmp(command, "test") == 0){
   40250:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40255:	74 26                	je     4027d <kernel+0x116>
   40257:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4025b:	be 38 4c 04 00       	mov    $0x44c38,%esi
   40260:	48 89 c7             	mov    %rax,%rdi
   40263:	e8 38 3b 00 00       	call   43da0 <strcmp>
   40268:	85 c0                	test   %eax,%eax
   4026a:	75 11                	jne    4027d <kernel+0x116>
        process_setup(1, 3);
   4026c:	be 03 00 00 00       	mov    $0x3,%esi
   40271:	bf 01 00 00 00       	mov    $0x1,%edi
   40276:	e8 5b 00 00 00       	call   402d6 <process_setup>
   4027b:	eb 4f                	jmp    402cc <kernel+0x165>
    } else if (command && strcmp(command, "test2") == 0) {
   4027d:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40282:	74 39                	je     402bd <kernel+0x156>
   40284:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40288:	be 3d 4c 04 00       	mov    $0x44c3d,%esi
   4028d:	48 89 c7             	mov    %rax,%rdi
   40290:	e8 0b 3b 00 00       	call   43da0 <strcmp>
   40295:	85 c0                	test   %eax,%eax
   40297:	75 24                	jne    402bd <kernel+0x156>
        for (pid_t i = 1; i <= 2; ++i) {
   40299:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   402a0:	eb 13                	jmp    402b5 <kernel+0x14e>
            process_setup(i, 3);
   402a2:	8b 45 f8             	mov    -0x8(%rbp),%eax
   402a5:	be 03 00 00 00       	mov    $0x3,%esi
   402aa:	89 c7                	mov    %eax,%edi
   402ac:	e8 25 00 00 00       	call   402d6 <process_setup>
        for (pid_t i = 1; i <= 2; ++i) {
   402b1:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   402b5:	83 7d f8 02          	cmpl   $0x2,-0x8(%rbp)
   402b9:	7e e7                	jle    402a2 <kernel+0x13b>
   402bb:	eb 0f                	jmp    402cc <kernel+0x165>
        }
    } else {
        process_setup(1, 0);
   402bd:	be 00 00 00 00       	mov    $0x0,%esi
   402c2:	bf 01 00 00 00       	mov    $0x1,%edi
   402c7:	e8 0a 00 00 00       	call   402d6 <process_setup>
    }

    // Switch to the first process using run()
    run(&processes[1]);
   402cc:	bf f0 f0 04 00       	mov    $0x4f0f0,%edi
   402d1:	e8 2b 09 00 00       	call   40c01 <run>

00000000000402d6 <process_setup>:
// process_setup(pid, program_number)
//    Load application program `program_number` as process number `pid`.
//    This loads the application's code and data into memory, sets its
//    %rip and %rsp, gives it a stack page, and marks it as runnable.

void process_setup(pid_t pid, int program_number) {
   402d6:	55                   	push   %rbp
   402d7:	48 89 e5             	mov    %rsp,%rbp
   402da:	48 83 ec 10          	sub    $0x10,%rsp
   402de:	89 7d fc             	mov    %edi,-0x4(%rbp)
   402e1:	89 75 f8             	mov    %esi,-0x8(%rbp)
    process_init(&processes[pid], 0);
   402e4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   402e7:	48 63 d0             	movslq %eax,%rdx
   402ea:	48 89 d0             	mov    %rdx,%rax
   402ed:	48 c1 e0 04          	shl    $0x4,%rax
   402f1:	48 29 d0             	sub    %rdx,%rax
   402f4:	48 c1 e0 04          	shl    $0x4,%rax
   402f8:	48 05 00 f0 04 00    	add    $0x4f000,%rax
   402fe:	be 00 00 00 00       	mov    $0x0,%esi
   40303:	48 89 c7             	mov    %rax,%rdi
   40306:	e8 8b 1a 00 00       	call   41d96 <process_init>
    assert(process_config_tables(pid) == 0);
   4030b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4030e:	89 c7                	mov    %eax,%edi
   40310:	e8 5b 31 00 00       	call   43470 <process_config_tables>
   40315:	85 c0                	test   %eax,%eax
   40317:	74 14                	je     4032d <process_setup+0x57>
   40319:	ba 48 4c 04 00       	mov    $0x44c48,%edx
   4031e:	be 77 00 00 00       	mov    $0x77,%esi
   40323:	bf 68 4c 04 00       	mov    $0x44c68,%edi
   40328:	e8 37 22 00 00       	call   42564 <assert_fail>

    /* Calls program_load in k-loader */
    assert(process_load(&processes[pid], program_number) >= 0);
   4032d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40330:	48 63 d0             	movslq %eax,%rdx
   40333:	48 89 d0             	mov    %rdx,%rax
   40336:	48 c1 e0 04          	shl    $0x4,%rax
   4033a:	48 29 d0             	sub    %rdx,%rax
   4033d:	48 c1 e0 04          	shl    $0x4,%rax
   40341:	48 8d 90 00 f0 04 00 	lea    0x4f000(%rax),%rdx
   40348:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4034b:	89 c6                	mov    %eax,%esi
   4034d:	48 89 d7             	mov    %rdx,%rdi
   40350:	e8 69 34 00 00       	call   437be <process_load>
   40355:	85 c0                	test   %eax,%eax
   40357:	79 14                	jns    4036d <process_setup+0x97>
   40359:	ba 78 4c 04 00       	mov    $0x44c78,%edx
   4035e:	be 7a 00 00 00       	mov    $0x7a,%esi
   40363:	bf 68 4c 04 00       	mov    $0x44c68,%edi
   40368:	e8 f7 21 00 00       	call   42564 <assert_fail>

    process_setup_stack(&processes[pid]);
   4036d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40370:	48 63 d0             	movslq %eax,%rdx
   40373:	48 89 d0             	mov    %rdx,%rax
   40376:	48 c1 e0 04          	shl    $0x4,%rax
   4037a:	48 29 d0             	sub    %rdx,%rax
   4037d:	48 c1 e0 04          	shl    $0x4,%rax
   40381:	48 05 00 f0 04 00    	add    $0x4f000,%rax
   40387:	48 89 c7             	mov    %rax,%rdi
   4038a:	e8 67 34 00 00       	call   437f6 <process_setup_stack>

    processes[pid].p_state = P_RUNNABLE;
   4038f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40392:	48 63 d0             	movslq %eax,%rdx
   40395:	48 89 d0             	mov    %rdx,%rax
   40398:	48 c1 e0 04          	shl    $0x4,%rax
   4039c:	48 29 d0             	sub    %rdx,%rax
   4039f:	48 c1 e0 04          	shl    $0x4,%rax
   403a3:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   403a9:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
}
   403af:	90                   	nop
   403b0:	c9                   	leave  
   403b1:	c3                   	ret    

00000000000403b2 <assign_physical_page>:
// assign_physical_page(addr, owner)
//    Allocates the page with physical address `addr` to the given owner.
//    Fails if physical page `addr` was already allocated. Returns 0 on
//    success and -1 on failure. Used by the program loader.

int assign_physical_page(uintptr_t addr, int8_t owner) {
   403b2:	55                   	push   %rbp
   403b3:	48 89 e5             	mov    %rsp,%rbp
   403b6:	48 83 ec 10          	sub    $0x10,%rsp
   403ba:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   403be:	89 f0                	mov    %esi,%eax
   403c0:	88 45 f4             	mov    %al,-0xc(%rbp)
    if ((addr & 0xFFF) != 0
   403c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403c7:	25 ff 0f 00 00       	and    $0xfff,%eax
   403cc:	48 85 c0             	test   %rax,%rax
   403cf:	75 20                	jne    403f1 <assign_physical_page+0x3f>
        || addr >= MEMSIZE_PHYSICAL
   403d1:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   403d8:	00 
   403d9:	77 16                	ja     403f1 <assign_physical_page+0x3f>
        || pageinfo[PAGENUMBER(addr)].refcount != 0) {
   403db:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403df:	48 c1 e8 0c          	shr    $0xc,%rax
   403e3:	48 98                	cltq   
   403e5:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   403ec:	00 
   403ed:	84 c0                	test   %al,%al
   403ef:	74 07                	je     403f8 <assign_physical_page+0x46>
        return -1;
   403f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   403f6:	eb 2c                	jmp    40424 <assign_physical_page+0x72>
    } else {
        pageinfo[PAGENUMBER(addr)].refcount = 1;
   403f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403fc:	48 c1 e8 0c          	shr    $0xc,%rax
   40400:	48 98                	cltq   
   40402:	c6 84 00 21 ff 04 00 	movb   $0x1,0x4ff21(%rax,%rax,1)
   40409:	01 
        pageinfo[PAGENUMBER(addr)].owner = owner;
   4040a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4040e:	48 c1 e8 0c          	shr    $0xc,%rax
   40412:	48 98                	cltq   
   40414:	0f b6 55 f4          	movzbl -0xc(%rbp),%edx
   40418:	88 94 00 20 ff 04 00 	mov    %dl,0x4ff20(%rax,%rax,1)
        return 0;
   4041f:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   40424:	c9                   	leave  
   40425:	c3                   	ret    

0000000000040426 <syscall_fork>:

pid_t syscall_fork() {
   40426:	55                   	push   %rbp
   40427:	48 89 e5             	mov    %rsp,%rbp
    return process_fork(current);
   4042a:	48 8b 05 cf fa 00 00 	mov    0xfacf(%rip),%rax        # 4ff00 <current>
   40431:	48 89 c7             	mov    %rax,%rdi
   40434:	e8 70 34 00 00       	call   438a9 <process_fork>
}
   40439:	5d                   	pop    %rbp
   4043a:	c3                   	ret    

000000000004043b <syscall_exit>:


void syscall_exit() {
   4043b:	55                   	push   %rbp
   4043c:	48 89 e5             	mov    %rsp,%rbp
    process_free(current->p_pid);
   4043f:	48 8b 05 ba fa 00 00 	mov    0xfaba(%rip),%rax        # 4ff00 <current>
   40446:	8b 00                	mov    (%rax),%eax
   40448:	89 c7                	mov    %eax,%edi
   4044a:	e8 3f 2d 00 00       	call   4318e <process_free>
}
   4044f:	90                   	nop
   40450:	5d                   	pop    %rbp
   40451:	c3                   	ret    

0000000000040452 <syscall_page_alloc>:

int syscall_page_alloc(uintptr_t addr) {
   40452:	55                   	push   %rbp
   40453:	48 89 e5             	mov    %rsp,%rbp
   40456:	48 83 ec 10          	sub    $0x10,%rsp
   4045a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return process_page_alloc(current, addr);
   4045e:	48 8b 05 9b fa 00 00 	mov    0xfa9b(%rip),%rax        # 4ff00 <current>
   40465:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40469:	48 89 d6             	mov    %rdx,%rsi
   4046c:	48 89 c7             	mov    %rax,%rdi
   4046f:	e8 c7 36 00 00       	call   43b3b <process_page_alloc>
}
   40474:	c9                   	leave  
   40475:	c3                   	ret    

0000000000040476 <brk>:

// PAGE_ALIGN aligns to nearest page with addr <= input

# define PAGE_ALIGN(addr) (PAGEADDRESS(PAGENUMBER(addr)))

int brk(proc *p, uintptr_t addr) {
   40476:	55                   	push   %rbp
   40477:	48 89 e5             	mov    %rsp,%rbp
   4047a:	48 83 ec 40          	sub    $0x40,%rsp
   4047e:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   40482:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
	uintptr_t newbrk = PAGE_ALIGN(addr);
   40486:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4048a:	48 c1 e8 0c          	shr    $0xc,%rax
   4048e:	48 98                	cltq   
   40490:	48 c1 e0 0c          	shl    $0xc,%rax
   40494:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
	uintptr_t oldbrk = PAGE_ALIGN(p->program_break);
   40498:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4049c:	48 8b 40 08          	mov    0x8(%rax),%rax
   404a0:	48 c1 e8 0c          	shr    $0xc,%rax
   404a4:	48 98                	cltq   
   404a6:	48 c1 e0 0c          	shl    $0xc,%rax
   404aa:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

	// error checking on break values
	if (newbrk < p->original_break || newbrk > MEMSIZE_VIRTUAL - PAGESIZE) {
   404ae:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   404b2:	48 8b 40 10          	mov    0x10(%rax),%rax
   404b6:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   404ba:	72 0a                	jb     404c6 <brk+0x50>
   404bc:	48 81 7d f0 00 f0 2f 	cmpq   $0x2ff000,-0x10(%rbp)
   404c3:	00 
   404c4:	76 16                	jbe    404dc <brk+0x66>
		p->p_registers.reg_rax = -1;
   404c6:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   404ca:	48 c7 40 18 ff ff ff 	movq   $0xffffffffffffffff,0x18(%rax)
   404d1:	ff 
		return -1;
   404d2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   404d7:	e9 da 00 00 00       	jmp    405b6 <brk+0x140>
	}

	// handle unmap on contraction
	if (newbrk < oldbrk) {
   404dc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   404e0:	48 3b 45 e8          	cmp    -0x18(%rbp),%rax
   404e4:	0f 83 af 00 00 00    	jae    40599 <brk+0x123>
		for (uintptr_t va = oldbrk; va > newbrk; va -= PAGESIZE) {
   404ea:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   404ee:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   404f2:	e9 94 00 00 00       	jmp    4058b <brk+0x115>
			vamapping vamap = virtual_memory_lookup(p->p_pagetable, va);
   404f7:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   404fb:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40502:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   40506:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4050a:	48 89 ce             	mov    %rcx,%rsi
   4050d:	48 89 c7             	mov    %rax,%rdi
   40510:	e8 11 27 00 00       	call   42c26 <virtual_memory_lookup>
			if (vamap.pn != -1){
   40515:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40518:	83 f8 ff             	cmp    $0xffffffff,%eax
   4051b:	74 66                	je     40583 <brk+0x10d>
				virtual_memory_map(p->p_pagetable, va, PAGEADDRESS(vamap.pn),  PAGESIZE, 0);
   4051d:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40520:	48 98                	cltq   
   40522:	48 c1 e0 0c          	shl    $0xc,%rax
   40526:	48 89 c2             	mov    %rax,%rdx
   40529:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4052d:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40534:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   40538:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   4053e:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40543:	48 89 c7             	mov    %rax,%rdi
   40546:	e8 18 23 00 00       	call   42863 <virtual_memory_map>
				pageinfo[vamap.pn].refcount--;
   4054b:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4054e:	48 63 d0             	movslq %eax,%rdx
   40551:	0f b6 94 12 21 ff 04 	movzbl 0x4ff21(%rdx,%rdx,1),%edx
   40558:	00 
   40559:	83 ea 01             	sub    $0x1,%edx
   4055c:	48 98                	cltq   
   4055e:	88 94 00 21 ff 04 00 	mov    %dl,0x4ff21(%rax,%rax,1)
				if (pageinfo[vamap.pn].refcount == 0)
   40565:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40568:	48 98                	cltq   
   4056a:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   40571:	00 
   40572:	84 c0                	test   %al,%al
   40574:	75 0d                	jne    40583 <brk+0x10d>
					pageinfo[vamap.pn].owner = PO_FREE;
   40576:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40579:	48 98                	cltq   
   4057b:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   40582:	00 
		for (uintptr_t va = oldbrk; va > newbrk; va -= PAGESIZE) {
   40583:	48 81 6d f8 00 10 00 	subq   $0x1000,-0x8(%rbp)
   4058a:	00 
   4058b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4058f:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   40593:	0f 82 5e ff ff ff    	jb     404f7 <brk+0x81>
			}
		}
	}

	p->program_break = addr;
   40599:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4059d:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   405a1:	48 89 50 08          	mov    %rdx,0x8(%rax)
	p->p_registers.reg_rax = 0;
   405a5:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   405a9:	48 c7 40 18 00 00 00 	movq   $0x0,0x18(%rax)
   405b0:	00 
	return 0;	
   405b1:	b8 00 00 00 00       	mov    $0x0,%eax
}
   405b6:	c9                   	leave  
   405b7:	c3                   	ret    

00000000000405b8 <sbrk>:


int sbrk(proc *p, intptr_t difference) {
   405b8:	55                   	push   %rbp
   405b9:	48 89 e5             	mov    %rsp,%rbp
   405bc:	48 83 ec 20          	sub    $0x20,%rsp
   405c0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   405c4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
	// log_printf("sbrk was used\n");
    // TODO : Your code here -> done
    uintptr_t oldbrk = p->program_break;
   405c8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   405cc:	48 8b 40 08          	mov    0x8(%rax),%rax
   405d0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (brk(p, p->program_break + difference)) {
   405d4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   405d8:	48 8b 50 08          	mov    0x8(%rax),%rdx
   405dc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   405e0:	48 01 c2             	add    %rax,%rdx
   405e3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   405e7:	48 89 d6             	mov    %rdx,%rsi
   405ea:	48 89 c7             	mov    %rax,%rdi
   405ed:	e8 84 fe ff ff       	call   40476 <brk>
   405f2:	85 c0                	test   %eax,%eax
   405f4:	74 22                	je     40618 <sbrk+0x60>
		p->p_registers.reg_rax = (uint64_t)((void *)-1);
   405f6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   405fa:	48 c7 40 18 ff ff ff 	movq   $0xffffffffffffffff,0x18(%rax)
   40601:	ff 
		log_printf("oops got here\n");
   40602:	bf ab 4c 04 00       	mov    $0x44cab,%edi
   40607:	b8 00 00 00 00       	mov    $0x0,%eax
   4060c:	e8 35 1c 00 00       	call   42246 <log_printf>
	    return -1;
   40611:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40616:	eb 11                	jmp    40629 <sbrk+0x71>
    }
    p->p_registers.reg_rax = oldbrk;
   40618:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4061c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40620:	48 89 50 18          	mov    %rdx,0x18(%rax)
    return 0;
   40624:	b8 00 00 00 00       	mov    $0x0,%eax
}
   40629:	c9                   	leave  
   4062a:	c3                   	ret    

000000000004062b <syscall_mapping>:


void syscall_mapping(proc* p){
   4062b:	55                   	push   %rbp
   4062c:	48 89 e5             	mov    %rsp,%rbp
   4062f:	48 83 ec 70          	sub    $0x70,%rsp
   40633:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)
    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
   40637:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4063b:	48 8b 40 48          	mov    0x48(%rax),%rax
   4063f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t ptr = p->p_registers.reg_rsi;
   40643:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40647:	48 8b 40 40          	mov    0x40(%rax),%rax
   4064b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    //convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);
   4064f:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40653:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   4065a:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4065e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40662:	48 89 ce             	mov    %rcx,%rsi
   40665:	48 89 c7             	mov    %rax,%rdi
   40668:	e8 b9 25 00 00       	call   42c26 <virtual_memory_lookup>

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
   4066d:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40670:	48 98                	cltq   
   40672:	83 e0 06             	and    $0x6,%eax
   40675:	48 83 f8 06          	cmp    $0x6,%rax
   40679:	0f 85 89 00 00 00    	jne    40708 <syscall_mapping+0xdd>
        return;
    uintptr_t endaddr = mapping_ptr + sizeof(vamapping) - 1;
   4067f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40683:	48 83 c0 17          	add    $0x17,%rax
   40687:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    if (PAGENUMBER(endaddr) != PAGENUMBER(ptr)){
   4068b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4068f:	48 c1 e8 0c          	shr    $0xc,%rax
   40693:	89 c2                	mov    %eax,%edx
   40695:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40699:	48 c1 e8 0c          	shr    $0xc,%rax
   4069d:	39 c2                	cmp    %eax,%edx
   4069f:	74 2c                	je     406cd <syscall_mapping+0xa2>
        vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
   406a1:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   406a5:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   406ac:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   406b0:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   406b4:	48 89 ce             	mov    %rcx,%rsi
   406b7:	48 89 c7             	mov    %rax,%rdi
   406ba:	e8 67 25 00 00       	call   42c26 <virtual_memory_lookup>
        // check for write access for end address
        if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
   406bf:	8b 45 b0             	mov    -0x50(%rbp),%eax
   406c2:	48 98                	cltq   
   406c4:	83 e0 03             	and    $0x3,%eax
   406c7:	48 83 f8 03          	cmp    $0x3,%rax
   406cb:	75 3e                	jne    4070b <syscall_mapping+0xe0>
            return; 
    }
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
   406cd:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   406d1:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   406d8:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   406dc:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   406e0:	48 89 ce             	mov    %rcx,%rsi
   406e3:	48 89 c7             	mov    %rax,%rdi
   406e6:	e8 3b 25 00 00       	call   42c26 <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   406eb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   406ef:	48 89 c1             	mov    %rax,%rcx
   406f2:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   406f6:	ba 18 00 00 00       	mov    $0x18,%edx
   406fb:	48 89 c6             	mov    %rax,%rsi
   406fe:	48 89 cf             	mov    %rcx,%rdi
   40701:	e8 a3 34 00 00       	call   43ba9 <memcpy>
   40706:	eb 04                	jmp    4070c <syscall_mapping+0xe1>
        return;
   40708:	90                   	nop
   40709:	eb 01                	jmp    4070c <syscall_mapping+0xe1>
            return; 
   4070b:	90                   	nop
}
   4070c:	c9                   	leave  
   4070d:	c3                   	ret    

000000000004070e <syscall_mem_tog>:

void syscall_mem_tog(proc* process){
   4070e:	55                   	push   %rbp
   4070f:	48 89 e5             	mov    %rsp,%rbp
   40712:	48 83 ec 18          	sub    $0x18,%rsp
   40716:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)

    pid_t p = process->p_registers.reg_rdi;
   4071a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4071e:	48 8b 40 48          	mov    0x48(%rax),%rax
   40722:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(p == 0) {
   40725:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   40729:	75 14                	jne    4073f <syscall_mem_tog+0x31>
        disp_global = !disp_global;
   4072b:	0f b6 05 ce 58 00 00 	movzbl 0x58ce(%rip),%eax        # 46000 <disp_global>
   40732:	84 c0                	test   %al,%al
   40734:	0f 94 c0             	sete   %al
   40737:	88 05 c3 58 00 00    	mov    %al,0x58c3(%rip)        # 46000 <disp_global>
   4073d:	eb 36                	jmp    40775 <syscall_mem_tog+0x67>
    }
    else {
        if(p < 0 || p > NPROC || p != process->p_pid)
   4073f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   40743:	78 2f                	js     40774 <syscall_mem_tog+0x66>
   40745:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   40749:	7f 29                	jg     40774 <syscall_mem_tog+0x66>
   4074b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4074f:	8b 00                	mov    (%rax),%eax
   40751:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   40754:	75 1e                	jne    40774 <syscall_mem_tog+0x66>
            return;
        process->display_status = !(process->display_status);
   40756:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4075a:	0f b6 80 e8 00 00 00 	movzbl 0xe8(%rax),%eax
   40761:	84 c0                	test   %al,%al
   40763:	0f 94 c0             	sete   %al
   40766:	89 c2                	mov    %eax,%edx
   40768:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4076c:	88 90 e8 00 00 00    	mov    %dl,0xe8(%rax)
   40772:	eb 01                	jmp    40775 <syscall_mem_tog+0x67>
            return;
   40774:	90                   	nop
    }
}
   40775:	c9                   	leave  
   40776:	c3                   	ret    

0000000000040777 <exception>:
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_64_registers* reg) {
   40777:	55                   	push   %rbp
   40778:	48 89 e5             	mov    %rsp,%rbp
   4077b:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
   40782:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   40789:	48 8b 05 70 f7 00 00 	mov    0xf770(%rip),%rax        # 4ff00 <current>
   40790:	48 8b 95 08 ff ff ff 	mov    -0xf8(%rbp),%rdx
   40797:	48 83 c0 18          	add    $0x18,%rax
   4079b:	48 89 d6             	mov    %rdx,%rsi
   4079e:	ba 18 00 00 00       	mov    $0x18,%edx
   407a3:	48 89 c7             	mov    %rax,%rdi
   407a6:	48 89 d1             	mov    %rdx,%rcx
   407a9:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   407ac:	48 8b 05 4d 18 01 00 	mov    0x1184d(%rip),%rax        # 52000 <kernel_pagetable>
   407b3:	48 89 c7             	mov    %rax,%rdi
   407b6:	e8 77 1f 00 00       	call   42732 <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   407bb:	8b 05 3b 88 07 00    	mov    0x7883b(%rip),%eax        # b8ffc <cursorpos>
   407c1:	89 c7                	mov    %eax,%edi
   407c3:	e8 98 16 00 00       	call   41e60 <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT
   407c8:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   407cf:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   407d6:	48 83 f8 0e          	cmp    $0xe,%rax
   407da:	74 14                	je     407f0 <exception+0x79>
	    && reg->reg_intno != INT_GPF)
   407dc:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   407e3:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   407ea:	48 83 f8 0d          	cmp    $0xd,%rax
   407ee:	75 16                	jne    40806 <exception+0x8f>
            || (reg->reg_err & PFERR_USER)) {
   407f0:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   407f7:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   407fe:	83 e0 04             	and    $0x4,%eax
   40801:	48 85 c0             	test   %rax,%rax
   40804:	74 1a                	je     40820 <exception+0xa9>
        check_virtual_memory();
   40806:	e8 1e 08 00 00       	call   41029 <check_virtual_memory>
        if(disp_global){
   4080b:	0f b6 05 ee 57 00 00 	movzbl 0x57ee(%rip),%eax        # 46000 <disp_global>
   40812:	84 c0                	test   %al,%al
   40814:	74 0a                	je     40820 <exception+0xa9>
            memshow_physical();
   40816:	e8 86 09 00 00       	call   411a1 <memshow_physical>
            memshow_virtual_animate();
   4081b:	e8 b0 0c 00 00       	call   414d0 <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   40820:	e8 1e 1b 00 00       	call   42343 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   40825:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   4082c:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40833:	48 83 e8 0e          	sub    $0xe,%rax
   40837:	48 83 f8 2c          	cmp    $0x2c,%rax
   4083b:	0f 87 11 03 00 00    	ja     40b52 <exception+0x3db>
   40841:	48 8b 04 c5 48 4d 04 	mov    0x44d48(,%rax,8),%rax
   40848:	00 
   40849:	ff e0                	jmp    *%rax
        case INT_SYS_PANIC:
            {
                // rdi stores pointer for msg string
                {
                    char msg[160];
                    uintptr_t addr = current->p_registers.reg_rdi;
   4084b:	48 8b 05 ae f6 00 00 	mov    0xf6ae(%rip),%rax        # 4ff00 <current>
   40852:	48 8b 40 48          	mov    0x48(%rax),%rax
   40856:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                    if((void *)addr == NULL)
   4085a:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   4085f:	75 0f                	jne    40870 <exception+0xf9>
                        kernel_panic(NULL);
   40861:	bf 00 00 00 00       	mov    $0x0,%edi
   40866:	b8 00 00 00 00       	mov    $0x0,%eax
   4086b:	e8 14 1c 00 00       	call   42484 <kernel_panic>
                    vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   40870:	48 8b 05 89 f6 00 00 	mov    0xf689(%rip),%rax        # 4ff00 <current>
   40877:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   4087e:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   40882:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40886:	48 89 ce             	mov    %rcx,%rsi
   40889:	48 89 c7             	mov    %rax,%rdi
   4088c:	e8 95 23 00 00       	call   42c26 <virtual_memory_lookup>
                    memcpy(msg, (void *)map.pa, 160);
   40891:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40895:	48 89 c1             	mov    %rax,%rcx
   40898:	48 8d 85 10 ff ff ff 	lea    -0xf0(%rbp),%rax
   4089f:	ba a0 00 00 00       	mov    $0xa0,%edx
   408a4:	48 89 ce             	mov    %rcx,%rsi
   408a7:	48 89 c7             	mov    %rax,%rdi
   408aa:	e8 fa 32 00 00       	call   43ba9 <memcpy>
                    kernel_panic(msg);
   408af:	48 8d 85 10 ff ff ff 	lea    -0xf0(%rbp),%rax
   408b6:	48 89 c7             	mov    %rax,%rdi
   408b9:	b8 00 00 00 00       	mov    $0x0,%eax
   408be:	e8 c1 1b 00 00       	call   42484 <kernel_panic>
                kernel_panic(NULL);
                break;                  // will not be reached
            }
        case INT_SYS_GETPID:
            {
                current->p_registers.reg_rax = current->p_pid;
   408c3:	48 8b 05 36 f6 00 00 	mov    0xf636(%rip),%rax        # 4ff00 <current>
   408ca:	8b 10                	mov    (%rax),%edx
   408cc:	48 8b 05 2d f6 00 00 	mov    0xf62d(%rip),%rax        # 4ff00 <current>
   408d3:	48 63 d2             	movslq %edx,%rdx
   408d6:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   408da:	e9 83 02 00 00       	jmp    40b62 <exception+0x3eb>
            }
        case INT_SYS_FORK:
            {
                current->p_registers.reg_rax = syscall_fork();
   408df:	b8 00 00 00 00       	mov    $0x0,%eax
   408e4:	e8 3d fb ff ff       	call   40426 <syscall_fork>
   408e9:	89 c2                	mov    %eax,%edx
   408eb:	48 8b 05 0e f6 00 00 	mov    0xf60e(%rip),%rax        # 4ff00 <current>
   408f2:	48 63 d2             	movslq %edx,%rdx
   408f5:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   408f9:	e9 64 02 00 00       	jmp    40b62 <exception+0x3eb>
            }
        case INT_SYS_MAPPING:
            {
                syscall_mapping(current);
   408fe:	48 8b 05 fb f5 00 00 	mov    0xf5fb(%rip),%rax        # 4ff00 <current>
   40905:	48 89 c7             	mov    %rax,%rdi
   40908:	e8 1e fd ff ff       	call   4062b <syscall_mapping>
                break;
   4090d:	e9 50 02 00 00       	jmp    40b62 <exception+0x3eb>
            }

        case INT_SYS_EXIT:
            {
                syscall_exit();
   40912:	b8 00 00 00 00       	mov    $0x0,%eax
   40917:	e8 1f fb ff ff       	call   4043b <syscall_exit>
                schedule();
   4091c:	e8 6a 02 00 00       	call   40b8b <schedule>
                break;
   40921:	e9 3c 02 00 00       	jmp    40b62 <exception+0x3eb>
            }

        case INT_SYS_YIELD:
            {
                schedule();
   40926:	e8 60 02 00 00       	call   40b8b <schedule>
                break;                  /* will not be reached */
   4092b:	e9 32 02 00 00       	jmp    40b62 <exception+0x3eb>
            }

        case INT_SYS_BRK:
            {
                // TODO : Your code here
				brk(current, reg->reg_rdi);
   40930:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40937:	48 8b 50 30          	mov    0x30(%rax),%rdx
   4093b:	48 8b 05 be f5 00 00 	mov    0xf5be(%rip),%rax        # 4ff00 <current>
   40942:	48 89 d6             	mov    %rdx,%rsi
   40945:	48 89 c7             	mov    %rax,%rdi
   40948:	e8 29 fb ff ff       	call   40476 <brk>
		break;
   4094d:	e9 10 02 00 00       	jmp    40b62 <exception+0x3eb>
            }

        case INT_SYS_SBRK:
            {
                // TODO : Your code here
				sbrk(current, reg->reg_rdi);
   40952:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40959:	48 8b 40 30          	mov    0x30(%rax),%rax
   4095d:	48 89 c2             	mov    %rax,%rdx
   40960:	48 8b 05 99 f5 00 00 	mov    0xf599(%rip),%rax        # 4ff00 <current>
   40967:	48 89 d6             	mov    %rdx,%rsi
   4096a:	48 89 c7             	mov    %rax,%rdi
   4096d:	e8 46 fc ff ff       	call   405b8 <sbrk>
                break;
   40972:	e9 eb 01 00 00       	jmp    40b62 <exception+0x3eb>
            }
	case INT_SYS_PAGE_ALLOC:
	    {
		intptr_t addr = reg->reg_rdi;
   40977:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   4097e:	48 8b 40 30          	mov    0x30(%rax),%rax
   40982:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
		syscall_page_alloc(addr);
   40986:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4098a:	48 89 c7             	mov    %rax,%rdi
   4098d:	e8 c0 fa ff ff       	call   40452 <syscall_page_alloc>
		break;
   40992:	e9 cb 01 00 00       	jmp    40b62 <exception+0x3eb>
	    }
        case INT_SYS_MEM_TOG:
            {
                syscall_mem_tog(current);
   40997:	48 8b 05 62 f5 00 00 	mov    0xf562(%rip),%rax        # 4ff00 <current>
   4099e:	48 89 c7             	mov    %rax,%rdi
   409a1:	e8 68 fd ff ff       	call   4070e <syscall_mem_tog>
                break;
   409a6:	e9 b7 01 00 00       	jmp    40b62 <exception+0x3eb>
            }

        case INT_TIMER:
            {
                ++ticks;
   409ab:	8b 05 6f f9 00 00    	mov    0xf96f(%rip),%eax        # 50320 <ticks>
   409b1:	83 c0 01             	add    $0x1,%eax
   409b4:	89 05 66 f9 00 00    	mov    %eax,0xf966(%rip)        # 50320 <ticks>
                schedule();
   409ba:	e8 cc 01 00 00       	call   40b8b <schedule>
                break;                  /* will not be reached */
   409bf:	e9 9e 01 00 00       	jmp    40b62 <exception+0x3eb>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   409c4:	0f 20 d0             	mov    %cr2,%rax
   409c7:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    return val;
   409cb:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
            }

        case INT_PAGEFAULT: 
            {
                // Analyze faulting address and access type.
                uintptr_t addr = rcr2();
   409cf:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
		    // log_printf("\theap bottom: 0x%x\n", current->original_break);
		    // log_printf("\theap top: 0x%x\n", current->program_break);
		// unsure if second check is redundant?
		if (//reg->reg_err != PFERR_PRESENT 
		    //&& 
		    addr >= current->original_break && addr < current->program_break) {
   409d3:	48 8b 05 26 f5 00 00 	mov    0xf526(%rip),%rax        # 4ff00 <current>
   409da:	48 8b 40 10          	mov    0x10(%rax),%rax
		if (//reg->reg_err != PFERR_PRESENT 
   409de:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   409e2:	72 76                	jb     40a5a <exception+0x2e3>
		    addr >= current->original_break && addr < current->program_break) {
   409e4:	48 8b 05 15 f5 00 00 	mov    0xf515(%rip),%rax        # 4ff00 <current>
   409eb:	48 8b 40 08          	mov    0x8(%rax),%rax
   409ef:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   409f3:	73 65                	jae    40a5a <exception+0x2e3>
			uintptr_t pa = (uintptr_t) palloc(current->p_pid);
   409f5:	48 8b 05 04 f5 00 00 	mov    0xf504(%rip),%rax        # 4ff00 <current>
   409fc:	8b 00                	mov    (%rax),%eax
   409fe:	89 c7                	mov    %eax,%edi
   40a00:	e8 70 26 00 00       	call   43075 <palloc>
   40a05:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
			if (pa) {
   40a09:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   40a0e:	74 3b                	je     40a4b <exception+0x2d4>
				virtual_memory_map(current->p_pagetable, PAGEADDRESS(PAGENUMBER(addr)), pa, PAGESIZE, PTE_P | PTE_U | PTE_W);
   40a10:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40a14:	48 c1 e8 0c          	shr    $0xc,%rax
   40a18:	48 98                	cltq   
   40a1a:	48 c1 e0 0c          	shl    $0xc,%rax
   40a1e:	48 89 c6             	mov    %rax,%rsi
   40a21:	48 8b 05 d8 f4 00 00 	mov    0xf4d8(%rip),%rax        # 4ff00 <current>
   40a28:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40a2f:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   40a33:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40a39:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40a3e:	48 89 c7             	mov    %rax,%rdi
   40a41:	e8 1d 1e 00 00       	call   42863 <virtual_memory_map>
		    addr >= current->original_break && addr < current->program_break) {
   40a46:	e9 05 01 00 00       	jmp    40b50 <exception+0x3d9>
			} 
			else {
				syscall_exit();
   40a4b:	b8 00 00 00 00       	mov    $0x0,%eax
   40a50:	e8 e6 f9 ff ff       	call   4043b <syscall_exit>
		    addr >= current->original_break && addr < current->program_break) {
   40a55:	e9 f6 00 00 00       	jmp    40b50 <exception+0x3d9>
			}
		} else {
			const char* operation = reg->reg_err & PFERR_WRITE
   40a5a:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40a61:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40a68:	83 e0 02             	and    $0x2,%eax
			    ? "write" : "read";
   40a6b:	48 85 c0             	test   %rax,%rax
   40a6e:	74 07                	je     40a77 <exception+0x300>
   40a70:	b8 ba 4c 04 00       	mov    $0x44cba,%eax
   40a75:	eb 05                	jmp    40a7c <exception+0x305>
   40a77:	b8 c0 4c 04 00       	mov    $0x44cc0,%eax
			const char* operation = reg->reg_err & PFERR_WRITE
   40a7c:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
			const char* problem = reg->reg_err & PFERR_PRESENT
   40a80:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40a87:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40a8e:	83 e0 01             	and    $0x1,%eax
			    ? "protection problem" : "missing page";
   40a91:	48 85 c0             	test   %rax,%rax
   40a94:	74 07                	je     40a9d <exception+0x326>
   40a96:	b8 c5 4c 04 00       	mov    $0x44cc5,%eax
   40a9b:	eb 05                	jmp    40aa2 <exception+0x32b>
   40a9d:	b8 d8 4c 04 00       	mov    $0x44cd8,%eax
			const char* problem = reg->reg_err & PFERR_PRESENT
   40aa2:	48 89 45 d0          	mov    %rax,-0x30(%rbp)

			if (!(reg->reg_err & PFERR_USER)) {
   40aa6:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40aad:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40ab4:	83 e0 04             	and    $0x4,%eax
   40ab7:	48 85 c0             	test   %rax,%rax
   40aba:	75 2f                	jne    40aeb <exception+0x374>
			    kernel_panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   40abc:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40ac3:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   40aca:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
   40ace:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   40ad2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40ad6:	49 89 f0             	mov    %rsi,%r8
   40ad9:	48 89 c6             	mov    %rax,%rsi
   40adc:	bf e8 4c 04 00       	mov    $0x44ce8,%edi
   40ae1:	b8 00 00 00 00       	mov    $0x0,%eax
   40ae6:	e8 99 19 00 00       	call   42484 <kernel_panic>
				    addr, operation, problem, reg->reg_rip);
			}
			console_printf(CPOS(24, 0), 0x0C00,
   40aeb:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40af2:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
				"Process %d page fault for %p (%s %s, rip=%p)!\n",
				current->p_pid, addr, operation, problem, reg->reg_rip);
   40af9:	48 8b 05 00 f4 00 00 	mov    0xf400(%rip),%rax        # 4ff00 <current>
			console_printf(CPOS(24, 0), 0x0C00,
   40b00:	8b 00                	mov    (%rax),%eax
   40b02:	48 8b 75 d8          	mov    -0x28(%rbp),%rsi
   40b06:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   40b0a:	52                   	push   %rdx
   40b0b:	ff 75 d0             	push   -0x30(%rbp)
   40b0e:	49 89 f1             	mov    %rsi,%r9
   40b11:	49 89 c8             	mov    %rcx,%r8
   40b14:	89 c1                	mov    %eax,%ecx
   40b16:	ba 18 4d 04 00       	mov    $0x44d18,%edx
   40b1b:	be 00 0c 00 00       	mov    $0xc00,%esi
   40b20:	bf 80 07 00 00       	mov    $0x780,%edi
   40b25:	b8 00 00 00 00       	mov    $0x0,%eax
   40b2a:	e8 2f 3f 00 00       	call   44a5e <console_printf>
   40b2f:	48 83 c4 10          	add    $0x10,%rsp
			current->p_state = P_BROKEN;
   40b33:	48 8b 05 c6 f3 00 00 	mov    0xf3c6(%rip),%rax        # 4ff00 <current>
   40b3a:	c7 80 d8 00 00 00 03 	movl   $0x3,0xd8(%rax)
   40b41:	00 00 00 
			syscall_exit();
   40b44:	b8 00 00 00 00       	mov    $0x0,%eax
   40b49:	e8 ed f8 ff ff       	call   4043b <syscall_exit>
		}
                break;
   40b4e:	eb 12                	jmp    40b62 <exception+0x3eb>
   40b50:	eb 10                	jmp    40b62 <exception+0x3eb>
            }

        default:
            default_exception(current);
   40b52:	48 8b 05 a7 f3 00 00 	mov    0xf3a7(%rip),%rax        # 4ff00 <current>
   40b59:	48 89 c7             	mov    %rax,%rdi
   40b5c:	e8 33 1a 00 00       	call   42594 <default_exception>
            break;                  /* will not be reached */
   40b61:	90                   	nop

    }

    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   40b62:	48 8b 05 97 f3 00 00 	mov    0xf397(%rip),%rax        # 4ff00 <current>
   40b69:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   40b6f:	83 f8 01             	cmp    $0x1,%eax
   40b72:	75 0f                	jne    40b83 <exception+0x40c>
        run(current);
   40b74:	48 8b 05 85 f3 00 00 	mov    0xf385(%rip),%rax        # 4ff00 <current>
   40b7b:	48 89 c7             	mov    %rax,%rdi
   40b7e:	e8 7e 00 00 00       	call   40c01 <run>
    } else {
        schedule();
   40b83:	e8 03 00 00 00       	call   40b8b <schedule>
    }
}
   40b88:	90                   	nop
   40b89:	c9                   	leave  
   40b8a:	c3                   	ret    

0000000000040b8b <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   40b8b:	55                   	push   %rbp
   40b8c:	48 89 e5             	mov    %rsp,%rbp
   40b8f:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   40b93:	48 8b 05 66 f3 00 00 	mov    0xf366(%rip),%rax        # 4ff00 <current>
   40b9a:	8b 00                	mov    (%rax),%eax
   40b9c:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   40b9f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40ba2:	8d 50 01             	lea    0x1(%rax),%edx
   40ba5:	89 d0                	mov    %edx,%eax
   40ba7:	c1 f8 1f             	sar    $0x1f,%eax
   40baa:	c1 e8 1c             	shr    $0x1c,%eax
   40bad:	01 c2                	add    %eax,%edx
   40baf:	83 e2 0f             	and    $0xf,%edx
   40bb2:	29 c2                	sub    %eax,%edx
   40bb4:	89 55 fc             	mov    %edx,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   40bb7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40bba:	48 63 d0             	movslq %eax,%rdx
   40bbd:	48 89 d0             	mov    %rdx,%rax
   40bc0:	48 c1 e0 04          	shl    $0x4,%rax
   40bc4:	48 29 d0             	sub    %rdx,%rax
   40bc7:	48 c1 e0 04          	shl    $0x4,%rax
   40bcb:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   40bd1:	8b 00                	mov    (%rax),%eax
   40bd3:	83 f8 01             	cmp    $0x1,%eax
   40bd6:	75 22                	jne    40bfa <schedule+0x6f>
            run(&processes[pid]);
   40bd8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40bdb:	48 63 d0             	movslq %eax,%rdx
   40bde:	48 89 d0             	mov    %rdx,%rax
   40be1:	48 c1 e0 04          	shl    $0x4,%rax
   40be5:	48 29 d0             	sub    %rdx,%rax
   40be8:	48 c1 e0 04          	shl    $0x4,%rax
   40bec:	48 05 00 f0 04 00    	add    $0x4f000,%rax
   40bf2:	48 89 c7             	mov    %rax,%rdi
   40bf5:	e8 07 00 00 00       	call   40c01 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   40bfa:	e8 44 17 00 00       	call   42343 <check_keyboard>
        pid = (pid + 1) % NPROC;
   40bff:	eb 9e                	jmp    40b9f <schedule+0x14>

0000000000040c01 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   40c01:	55                   	push   %rbp
   40c02:	48 89 e5             	mov    %rsp,%rbp
   40c05:	48 83 ec 10          	sub    $0x10,%rsp
   40c09:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   40c0d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c11:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   40c17:	83 f8 01             	cmp    $0x1,%eax
   40c1a:	74 14                	je     40c30 <run+0x2f>
   40c1c:	ba b0 4e 04 00       	mov    $0x44eb0,%edx
   40c21:	be b4 01 00 00       	mov    $0x1b4,%esi
   40c26:	bf 68 4c 04 00       	mov    $0x44c68,%edi
   40c2b:	e8 34 19 00 00       	call   42564 <assert_fail>
    current = p;
   40c30:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c34:	48 89 05 c5 f2 00 00 	mov    %rax,0xf2c5(%rip)        # 4ff00 <current>

    // display running process in CONSOLE last value
    console_printf(CPOS(24, 79),
   40c3b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c3f:	8b 10                	mov    (%rax),%edx
            memstate_colors[p->p_pid - PO_KERNEL], "%d", p->p_pid);
   40c41:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c45:	8b 00                	mov    (%rax),%eax
   40c47:	83 c0 02             	add    $0x2,%eax
   40c4a:	48 98                	cltq   
   40c4c:	0f b7 84 00 00 4c 04 	movzwl 0x44c00(%rax,%rax,1),%eax
   40c53:	00 
    console_printf(CPOS(24, 79),
   40c54:	0f b7 c0             	movzwl %ax,%eax
   40c57:	89 d1                	mov    %edx,%ecx
   40c59:	ba c9 4e 04 00       	mov    $0x44ec9,%edx
   40c5e:	89 c6                	mov    %eax,%esi
   40c60:	bf cf 07 00 00       	mov    $0x7cf,%edi
   40c65:	b8 00 00 00 00       	mov    $0x0,%eax
   40c6a:	e8 ef 3d 00 00       	call   44a5e <console_printf>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   40c6f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c73:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40c7a:	48 89 c7             	mov    %rax,%rdi
   40c7d:	e8 b0 1a 00 00       	call   42732 <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   40c82:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c86:	48 83 c0 18          	add    $0x18,%rax
   40c8a:	48 89 c7             	mov    %rax,%rdi
   40c8d:	e8 31 f4 ff ff       	call   400c3 <exception_return>

0000000000040c92 <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   40c92:	55                   	push   %rbp
   40c93:	48 89 e5             	mov    %rsp,%rbp
   40c96:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40c9a:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40ca1:	00 
   40ca2:	e9 81 00 00 00       	jmp    40d28 <pageinfo_init+0x96>
        int owner;
        if (physical_memory_isreserved(addr)) {
   40ca7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40cab:	48 89 c7             	mov    %rax,%rdi
   40cae:	e8 1e 0f 00 00       	call   41bd1 <physical_memory_isreserved>
   40cb3:	85 c0                	test   %eax,%eax
   40cb5:	74 09                	je     40cc0 <pageinfo_init+0x2e>
            owner = PO_RESERVED;
   40cb7:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   40cbe:	eb 2f                	jmp    40cef <pageinfo_init+0x5d>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   40cc0:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   40cc7:	00 
   40cc8:	76 0b                	jbe    40cd5 <pageinfo_init+0x43>
   40cca:	b8 10 80 05 00       	mov    $0x58010,%eax
   40ccf:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40cd3:	72 0a                	jb     40cdf <pageinfo_init+0x4d>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   40cd5:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   40cdc:	00 
   40cdd:	75 09                	jne    40ce8 <pageinfo_init+0x56>
            owner = PO_KERNEL;
   40cdf:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   40ce6:	eb 07                	jmp    40cef <pageinfo_init+0x5d>
        } else {
            owner = PO_FREE;
   40ce8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40cef:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40cf3:	48 c1 e8 0c          	shr    $0xc,%rax
   40cf7:	89 c1                	mov    %eax,%ecx
   40cf9:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40cfc:	89 c2                	mov    %eax,%edx
   40cfe:	48 63 c1             	movslq %ecx,%rax
   40d01:	88 94 00 20 ff 04 00 	mov    %dl,0x4ff20(%rax,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   40d08:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40d0c:	0f 95 c2             	setne  %dl
   40d0f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d13:	48 c1 e8 0c          	shr    $0xc,%rax
   40d17:	48 98                	cltq   
   40d19:	88 94 00 21 ff 04 00 	mov    %dl,0x4ff21(%rax,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40d20:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40d27:	00 
   40d28:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40d2f:	00 
   40d30:	0f 86 71 ff ff ff    	jbe    40ca7 <pageinfo_init+0x15>
    }
}
   40d36:	90                   	nop
   40d37:	90                   	nop
   40d38:	c9                   	leave  
   40d39:	c3                   	ret    

0000000000040d3a <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   40d3a:	55                   	push   %rbp
   40d3b:	48 89 e5             	mov    %rsp,%rbp
   40d3e:	48 83 ec 50          	sub    $0x50,%rsp
   40d42:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   40d46:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40d4a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40d50:	48 89 c2             	mov    %rax,%rdx
   40d53:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40d57:	48 39 c2             	cmp    %rax,%rdx
   40d5a:	74 14                	je     40d70 <check_page_table_mappings+0x36>
   40d5c:	ba d0 4e 04 00       	mov    $0x44ed0,%edx
   40d61:	be e2 01 00 00       	mov    $0x1e2,%esi
   40d66:	bf 68 4c 04 00       	mov    $0x44c68,%edi
   40d6b:	e8 f4 17 00 00       	call   42564 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40d70:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   40d77:	00 
   40d78:	e9 9a 00 00 00       	jmp    40e17 <check_page_table_mappings+0xdd>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   40d7d:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   40d81:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40d85:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40d89:	48 89 ce             	mov    %rcx,%rsi
   40d8c:	48 89 c7             	mov    %rax,%rdi
   40d8f:	e8 92 1e 00 00       	call   42c26 <virtual_memory_lookup>
        if (vam.pa != va) {
   40d94:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40d98:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40d9c:	74 27                	je     40dc5 <check_page_table_mappings+0x8b>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   40d9e:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40da2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40da6:	49 89 d0             	mov    %rdx,%r8
   40da9:	48 89 c1             	mov    %rax,%rcx
   40dac:	ba ef 4e 04 00       	mov    $0x44eef,%edx
   40db1:	be 00 c0 00 00       	mov    $0xc000,%esi
   40db6:	bf e0 06 00 00       	mov    $0x6e0,%edi
   40dbb:	b8 00 00 00 00       	mov    $0x0,%eax
   40dc0:	e8 99 3c 00 00       	call   44a5e <console_printf>
        }
        assert(vam.pa == va);
   40dc5:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40dc9:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40dcd:	74 14                	je     40de3 <check_page_table_mappings+0xa9>
   40dcf:	ba f9 4e 04 00       	mov    $0x44ef9,%edx
   40dd4:	be eb 01 00 00       	mov    $0x1eb,%esi
   40dd9:	bf 68 4c 04 00       	mov    $0x44c68,%edi
   40dde:	e8 81 17 00 00       	call   42564 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   40de3:	b8 00 60 04 00       	mov    $0x46000,%eax
   40de8:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40dec:	72 21                	jb     40e0f <check_page_table_mappings+0xd5>
            assert(vam.perm & PTE_W);
   40dee:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40df1:	48 98                	cltq   
   40df3:	83 e0 02             	and    $0x2,%eax
   40df6:	48 85 c0             	test   %rax,%rax
   40df9:	75 14                	jne    40e0f <check_page_table_mappings+0xd5>
   40dfb:	ba 06 4f 04 00       	mov    $0x44f06,%edx
   40e00:	be ed 01 00 00       	mov    $0x1ed,%esi
   40e05:	bf 68 4c 04 00       	mov    $0x44c68,%edi
   40e0a:	e8 55 17 00 00       	call   42564 <assert_fail>
         va += PAGESIZE) {
   40e0f:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40e16:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40e17:	b8 10 80 05 00       	mov    $0x58010,%eax
   40e1c:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40e20:	0f 82 57 ff ff ff    	jb     40d7d <check_page_table_mappings+0x43>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   40e26:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   40e2d:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   40e2e:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   40e32:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40e36:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40e3a:	48 89 ce             	mov    %rcx,%rsi
   40e3d:	48 89 c7             	mov    %rax,%rdi
   40e40:	e8 e1 1d 00 00       	call   42c26 <virtual_memory_lookup>
    assert(vam.pa == kstack);
   40e45:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40e49:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   40e4d:	74 14                	je     40e63 <check_page_table_mappings+0x129>
   40e4f:	ba 17 4f 04 00       	mov    $0x44f17,%edx
   40e54:	be f4 01 00 00       	mov    $0x1f4,%esi
   40e59:	bf 68 4c 04 00       	mov    $0x44c68,%edi
   40e5e:	e8 01 17 00 00       	call   42564 <assert_fail>
    assert(vam.perm & PTE_W);
   40e63:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40e66:	48 98                	cltq   
   40e68:	83 e0 02             	and    $0x2,%eax
   40e6b:	48 85 c0             	test   %rax,%rax
   40e6e:	75 14                	jne    40e84 <check_page_table_mappings+0x14a>
   40e70:	ba 06 4f 04 00       	mov    $0x44f06,%edx
   40e75:	be f5 01 00 00       	mov    $0x1f5,%esi
   40e7a:	bf 68 4c 04 00       	mov    $0x44c68,%edi
   40e7f:	e8 e0 16 00 00       	call   42564 <assert_fail>
}
   40e84:	90                   	nop
   40e85:	c9                   	leave  
   40e86:	c3                   	ret    

0000000000040e87 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   40e87:	55                   	push   %rbp
   40e88:	48 89 e5             	mov    %rsp,%rbp
   40e8b:	48 83 ec 20          	sub    $0x20,%rsp
   40e8f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40e93:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   40e96:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40e99:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   40e9c:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   40ea3:	48 8b 05 56 11 01 00 	mov    0x11156(%rip),%rax        # 52000 <kernel_pagetable>
   40eaa:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40eae:	75 67                	jne    40f17 <check_page_table_ownership+0x90>
        owner = PO_KERNEL;
   40eb0:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40eb7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   40ebe:	eb 51                	jmp    40f11 <check_page_table_ownership+0x8a>
            if (processes[xpid].p_state != P_FREE
   40ec0:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40ec3:	48 63 d0             	movslq %eax,%rdx
   40ec6:	48 89 d0             	mov    %rdx,%rax
   40ec9:	48 c1 e0 04          	shl    $0x4,%rax
   40ecd:	48 29 d0             	sub    %rdx,%rax
   40ed0:	48 c1 e0 04          	shl    $0x4,%rax
   40ed4:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   40eda:	8b 00                	mov    (%rax),%eax
   40edc:	85 c0                	test   %eax,%eax
   40ede:	74 2d                	je     40f0d <check_page_table_ownership+0x86>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   40ee0:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40ee3:	48 63 d0             	movslq %eax,%rdx
   40ee6:	48 89 d0             	mov    %rdx,%rax
   40ee9:	48 c1 e0 04          	shl    $0x4,%rax
   40eed:	48 29 d0             	sub    %rdx,%rax
   40ef0:	48 c1 e0 04          	shl    $0x4,%rax
   40ef4:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   40efa:	48 8b 10             	mov    (%rax),%rdx
   40efd:	48 8b 05 fc 10 01 00 	mov    0x110fc(%rip),%rax        # 52000 <kernel_pagetable>
   40f04:	48 39 c2             	cmp    %rax,%rdx
   40f07:	75 04                	jne    40f0d <check_page_table_ownership+0x86>
                ++expected_refcount;
   40f09:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40f0d:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   40f11:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   40f15:	7e a9                	jle    40ec0 <check_page_table_ownership+0x39>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   40f17:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   40f1a:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40f1d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40f21:	be 00 00 00 00       	mov    $0x0,%esi
   40f26:	48 89 c7             	mov    %rax,%rdi
   40f29:	e8 03 00 00 00       	call   40f31 <check_page_table_ownership_level>
}
   40f2e:	90                   	nop
   40f2f:	c9                   	leave  
   40f30:	c3                   	ret    

0000000000040f31 <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   40f31:	55                   	push   %rbp
   40f32:	48 89 e5             	mov    %rsp,%rbp
   40f35:	48 83 ec 30          	sub    $0x30,%rsp
   40f39:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40f3d:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   40f40:	89 55 e0             	mov    %edx,-0x20(%rbp)
   40f43:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   40f46:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40f4a:	48 c1 e8 0c          	shr    $0xc,%rax
   40f4e:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   40f53:	7e 14                	jle    40f69 <check_page_table_ownership_level+0x38>
   40f55:	ba 28 4f 04 00       	mov    $0x44f28,%edx
   40f5a:	be 12 02 00 00       	mov    $0x212,%esi
   40f5f:	bf 68 4c 04 00       	mov    $0x44c68,%edi
   40f64:	e8 fb 15 00 00       	call   42564 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   40f69:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40f6d:	48 c1 e8 0c          	shr    $0xc,%rax
   40f71:	48 98                	cltq   
   40f73:	0f b6 84 00 20 ff 04 	movzbl 0x4ff20(%rax,%rax,1),%eax
   40f7a:	00 
   40f7b:	0f be c0             	movsbl %al,%eax
   40f7e:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   40f81:	74 14                	je     40f97 <check_page_table_ownership_level+0x66>
   40f83:	ba 40 4f 04 00       	mov    $0x44f40,%edx
   40f88:	be 13 02 00 00       	mov    $0x213,%esi
   40f8d:	bf 68 4c 04 00       	mov    $0x44c68,%edi
   40f92:	e8 cd 15 00 00       	call   42564 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   40f97:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40f9b:	48 c1 e8 0c          	shr    $0xc,%rax
   40f9f:	48 98                	cltq   
   40fa1:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   40fa8:	00 
   40fa9:	0f be c0             	movsbl %al,%eax
   40fac:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   40faf:	74 14                	je     40fc5 <check_page_table_ownership_level+0x94>
   40fb1:	ba 68 4f 04 00       	mov    $0x44f68,%edx
   40fb6:	be 14 02 00 00       	mov    $0x214,%esi
   40fbb:	bf 68 4c 04 00       	mov    $0x44c68,%edi
   40fc0:	e8 9f 15 00 00       	call   42564 <assert_fail>
    if (level < 3) {
   40fc5:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   40fc9:	7f 5b                	jg     41026 <check_page_table_ownership_level+0xf5>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   40fcb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   40fd2:	eb 49                	jmp    4101d <check_page_table_ownership_level+0xec>
            if (pt->entry[index]) {
   40fd4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40fd8:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40fdb:	48 63 d2             	movslq %edx,%rdx
   40fde:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   40fe2:	48 85 c0             	test   %rax,%rax
   40fe5:	74 32                	je     41019 <check_page_table_ownership_level+0xe8>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   40fe7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40feb:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40fee:	48 63 d2             	movslq %edx,%rdx
   40ff1:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   40ff5:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   40ffb:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   40fff:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   41002:	8d 70 01             	lea    0x1(%rax),%esi
   41005:	8b 55 e0             	mov    -0x20(%rbp),%edx
   41008:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4100c:	b9 01 00 00 00       	mov    $0x1,%ecx
   41011:	48 89 c7             	mov    %rax,%rdi
   41014:	e8 18 ff ff ff       	call   40f31 <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   41019:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4101d:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41024:	7e ae                	jle    40fd4 <check_page_table_ownership_level+0xa3>
            }
        }
    }
}
   41026:	90                   	nop
   41027:	c9                   	leave  
   41028:	c3                   	ret    

0000000000041029 <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   41029:	55                   	push   %rbp
   4102a:	48 89 e5             	mov    %rsp,%rbp
   4102d:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   41031:	8b 05 a1 e0 00 00    	mov    0xe0a1(%rip),%eax        # 4f0d8 <processes+0xd8>
   41037:	85 c0                	test   %eax,%eax
   41039:	74 14                	je     4104f <check_virtual_memory+0x26>
   4103b:	ba 98 4f 04 00       	mov    $0x44f98,%edx
   41040:	be 27 02 00 00       	mov    $0x227,%esi
   41045:	bf 68 4c 04 00       	mov    $0x44c68,%edi
   4104a:	e8 15 15 00 00       	call   42564 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   4104f:	48 8b 05 aa 0f 01 00 	mov    0x10faa(%rip),%rax        # 52000 <kernel_pagetable>
   41056:	48 89 c7             	mov    %rax,%rdi
   41059:	e8 dc fc ff ff       	call   40d3a <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   4105e:	48 8b 05 9b 0f 01 00 	mov    0x10f9b(%rip),%rax        # 52000 <kernel_pagetable>
   41065:	be ff ff ff ff       	mov    $0xffffffff,%esi
   4106a:	48 89 c7             	mov    %rax,%rdi
   4106d:	e8 15 fe ff ff       	call   40e87 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   41072:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41079:	e9 9c 00 00 00       	jmp    4111a <check_virtual_memory+0xf1>
        if (processes[pid].p_state != P_FREE
   4107e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41081:	48 63 d0             	movslq %eax,%rdx
   41084:	48 89 d0             	mov    %rdx,%rax
   41087:	48 c1 e0 04          	shl    $0x4,%rax
   4108b:	48 29 d0             	sub    %rdx,%rax
   4108e:	48 c1 e0 04          	shl    $0x4,%rax
   41092:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   41098:	8b 00                	mov    (%rax),%eax
   4109a:	85 c0                	test   %eax,%eax
   4109c:	74 78                	je     41116 <check_virtual_memory+0xed>
            && processes[pid].p_pagetable != kernel_pagetable) {
   4109e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   410a1:	48 63 d0             	movslq %eax,%rdx
   410a4:	48 89 d0             	mov    %rdx,%rax
   410a7:	48 c1 e0 04          	shl    $0x4,%rax
   410ab:	48 29 d0             	sub    %rdx,%rax
   410ae:	48 c1 e0 04          	shl    $0x4,%rax
   410b2:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   410b8:	48 8b 10             	mov    (%rax),%rdx
   410bb:	48 8b 05 3e 0f 01 00 	mov    0x10f3e(%rip),%rax        # 52000 <kernel_pagetable>
   410c2:	48 39 c2             	cmp    %rax,%rdx
   410c5:	74 4f                	je     41116 <check_virtual_memory+0xed>
            check_page_table_mappings(processes[pid].p_pagetable);
   410c7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   410ca:	48 63 d0             	movslq %eax,%rdx
   410cd:	48 89 d0             	mov    %rdx,%rax
   410d0:	48 c1 e0 04          	shl    $0x4,%rax
   410d4:	48 29 d0             	sub    %rdx,%rax
   410d7:	48 c1 e0 04          	shl    $0x4,%rax
   410db:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   410e1:	48 8b 00             	mov    (%rax),%rax
   410e4:	48 89 c7             	mov    %rax,%rdi
   410e7:	e8 4e fc ff ff       	call   40d3a <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   410ec:	8b 45 fc             	mov    -0x4(%rbp),%eax
   410ef:	48 63 d0             	movslq %eax,%rdx
   410f2:	48 89 d0             	mov    %rdx,%rax
   410f5:	48 c1 e0 04          	shl    $0x4,%rax
   410f9:	48 29 d0             	sub    %rdx,%rax
   410fc:	48 c1 e0 04          	shl    $0x4,%rax
   41100:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   41106:	48 8b 00             	mov    (%rax),%rax
   41109:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4110c:	89 d6                	mov    %edx,%esi
   4110e:	48 89 c7             	mov    %rax,%rdi
   41111:	e8 71 fd ff ff       	call   40e87 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   41116:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4111a:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   4111e:	0f 8e 5a ff ff ff    	jle    4107e <check_virtual_memory+0x55>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41124:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   4112b:	eb 67                	jmp    41194 <check_virtual_memory+0x16b>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   4112d:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41130:	48 98                	cltq   
   41132:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   41139:	00 
   4113a:	84 c0                	test   %al,%al
   4113c:	7e 52                	jle    41190 <check_virtual_memory+0x167>
   4113e:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41141:	48 98                	cltq   
   41143:	0f b6 84 00 20 ff 04 	movzbl 0x4ff20(%rax,%rax,1),%eax
   4114a:	00 
   4114b:	84 c0                	test   %al,%al
   4114d:	78 41                	js     41190 <check_virtual_memory+0x167>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   4114f:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41152:	48 98                	cltq   
   41154:	0f b6 84 00 20 ff 04 	movzbl 0x4ff20(%rax,%rax,1),%eax
   4115b:	00 
   4115c:	0f be c0             	movsbl %al,%eax
   4115f:	48 63 d0             	movslq %eax,%rdx
   41162:	48 89 d0             	mov    %rdx,%rax
   41165:	48 c1 e0 04          	shl    $0x4,%rax
   41169:	48 29 d0             	sub    %rdx,%rax
   4116c:	48 c1 e0 04          	shl    $0x4,%rax
   41170:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   41176:	8b 00                	mov    (%rax),%eax
   41178:	85 c0                	test   %eax,%eax
   4117a:	75 14                	jne    41190 <check_virtual_memory+0x167>
   4117c:	ba b8 4f 04 00       	mov    $0x44fb8,%edx
   41181:	be 3e 02 00 00       	mov    $0x23e,%esi
   41186:	bf 68 4c 04 00       	mov    $0x44c68,%edi
   4118b:	e8 d4 13 00 00       	call   42564 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41190:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41194:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   4119b:	7e 90                	jle    4112d <check_virtual_memory+0x104>
        }
    }
}
   4119d:	90                   	nop
   4119e:	90                   	nop
   4119f:	c9                   	leave  
   411a0:	c3                   	ret    

00000000000411a1 <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   411a1:	55                   	push   %rbp
   411a2:	48 89 e5             	mov    %rsp,%rbp
   411a5:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   411a9:	ba e8 4f 04 00       	mov    $0x44fe8,%edx
   411ae:	be 00 0f 00 00       	mov    $0xf00,%esi
   411b3:	bf 20 00 00 00       	mov    $0x20,%edi
   411b8:	b8 00 00 00 00       	mov    $0x0,%eax
   411bd:	e8 9c 38 00 00       	call   44a5e <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   411c2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   411c9:	e9 f8 00 00 00       	jmp    412c6 <memshow_physical+0x125>
        if (pn % 64 == 0) {
   411ce:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411d1:	83 e0 3f             	and    $0x3f,%eax
   411d4:	85 c0                	test   %eax,%eax
   411d6:	75 3c                	jne    41214 <memshow_physical+0x73>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   411d8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411db:	c1 e0 0c             	shl    $0xc,%eax
   411de:	89 c1                	mov    %eax,%ecx
   411e0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411e3:	8d 50 3f             	lea    0x3f(%rax),%edx
   411e6:	85 c0                	test   %eax,%eax
   411e8:	0f 48 c2             	cmovs  %edx,%eax
   411eb:	c1 f8 06             	sar    $0x6,%eax
   411ee:	8d 50 01             	lea    0x1(%rax),%edx
   411f1:	89 d0                	mov    %edx,%eax
   411f3:	c1 e0 02             	shl    $0x2,%eax
   411f6:	01 d0                	add    %edx,%eax
   411f8:	c1 e0 04             	shl    $0x4,%eax
   411fb:	83 c0 03             	add    $0x3,%eax
   411fe:	ba f8 4f 04 00       	mov    $0x44ff8,%edx
   41203:	be 00 0f 00 00       	mov    $0xf00,%esi
   41208:	89 c7                	mov    %eax,%edi
   4120a:	b8 00 00 00 00       	mov    $0x0,%eax
   4120f:	e8 4a 38 00 00       	call   44a5e <console_printf>
        }

        int owner = pageinfo[pn].owner;
   41214:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41217:	48 98                	cltq   
   41219:	0f b6 84 00 20 ff 04 	movzbl 0x4ff20(%rax,%rax,1),%eax
   41220:	00 
   41221:	0f be c0             	movsbl %al,%eax
   41224:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   41227:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4122a:	48 98                	cltq   
   4122c:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   41233:	00 
   41234:	84 c0                	test   %al,%al
   41236:	75 07                	jne    4123f <memshow_physical+0x9e>
            owner = PO_FREE;
   41238:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   4123f:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41242:	83 c0 02             	add    $0x2,%eax
   41245:	48 98                	cltq   
   41247:	0f b7 84 00 00 4c 04 	movzwl 0x44c00(%rax,%rax,1),%eax
   4124e:	00 
   4124f:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   41253:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41256:	48 98                	cltq   
   41258:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   4125f:	00 
   41260:	3c 01                	cmp    $0x1,%al
   41262:	7e 1a                	jle    4127e <memshow_physical+0xdd>
   41264:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   41269:	48 c1 e8 0c          	shr    $0xc,%rax
   4126d:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   41270:	74 0c                	je     4127e <memshow_physical+0xdd>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   41272:	b8 53 00 00 00       	mov    $0x53,%eax
   41277:	80 cc 0f             	or     $0xf,%ah
   4127a:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   4127e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41281:	8d 50 3f             	lea    0x3f(%rax),%edx
   41284:	85 c0                	test   %eax,%eax
   41286:	0f 48 c2             	cmovs  %edx,%eax
   41289:	c1 f8 06             	sar    $0x6,%eax
   4128c:	8d 50 01             	lea    0x1(%rax),%edx
   4128f:	89 d0                	mov    %edx,%eax
   41291:	c1 e0 02             	shl    $0x2,%eax
   41294:	01 d0                	add    %edx,%eax
   41296:	c1 e0 04             	shl    $0x4,%eax
   41299:	89 c1                	mov    %eax,%ecx
   4129b:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4129e:	89 d0                	mov    %edx,%eax
   412a0:	c1 f8 1f             	sar    $0x1f,%eax
   412a3:	c1 e8 1a             	shr    $0x1a,%eax
   412a6:	01 c2                	add    %eax,%edx
   412a8:	83 e2 3f             	and    $0x3f,%edx
   412ab:	29 c2                	sub    %eax,%edx
   412ad:	89 d0                	mov    %edx,%eax
   412af:	83 c0 0c             	add    $0xc,%eax
   412b2:	01 c8                	add    %ecx,%eax
   412b4:	48 98                	cltq   
   412b6:	0f b7 55 f6          	movzwl -0xa(%rbp),%edx
   412ba:	66 89 94 00 00 80 0b 	mov    %dx,0xb8000(%rax,%rax,1)
   412c1:	00 
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   412c2:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   412c6:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   412cd:	0f 8e fb fe ff ff    	jle    411ce <memshow_physical+0x2d>
    }
}
   412d3:	90                   	nop
   412d4:	90                   	nop
   412d5:	c9                   	leave  
   412d6:	c3                   	ret    

00000000000412d7 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   412d7:	55                   	push   %rbp
   412d8:	48 89 e5             	mov    %rsp,%rbp
   412db:	48 83 ec 40          	sub    $0x40,%rsp
   412df:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   412e3:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   412e7:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   412eb:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   412f1:	48 89 c2             	mov    %rax,%rdx
   412f4:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   412f8:	48 39 c2             	cmp    %rax,%rdx
   412fb:	74 14                	je     41311 <memshow_virtual+0x3a>
   412fd:	ba 00 50 04 00       	mov    $0x45000,%edx
   41302:	be 6f 02 00 00       	mov    $0x26f,%esi
   41307:	bf 68 4c 04 00       	mov    $0x44c68,%edi
   4130c:	e8 53 12 00 00       	call   42564 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   41311:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   41315:	48 89 c1             	mov    %rax,%rcx
   41318:	ba 2d 50 04 00       	mov    $0x4502d,%edx
   4131d:	be 00 0f 00 00       	mov    $0xf00,%esi
   41322:	bf 3a 03 00 00       	mov    $0x33a,%edi
   41327:	b8 00 00 00 00       	mov    $0x0,%eax
   4132c:	e8 2d 37 00 00       	call   44a5e <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41331:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   41338:	00 
   41339:	e9 80 01 00 00       	jmp    414be <memshow_virtual+0x1e7>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   4133e:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   41342:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   41346:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   4134a:	48 89 ce             	mov    %rcx,%rsi
   4134d:	48 89 c7             	mov    %rax,%rdi
   41350:	e8 d1 18 00 00       	call   42c26 <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   41355:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41358:	85 c0                	test   %eax,%eax
   4135a:	79 0b                	jns    41367 <memshow_virtual+0x90>
            color = ' ';
   4135c:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   41362:	e9 d7 00 00 00       	jmp    4143e <memshow_virtual+0x167>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   41367:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4136b:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   41371:	76 14                	jbe    41387 <memshow_virtual+0xb0>
   41373:	ba 4a 50 04 00       	mov    $0x4504a,%edx
   41378:	be 78 02 00 00       	mov    $0x278,%esi
   4137d:	bf 68 4c 04 00       	mov    $0x44c68,%edi
   41382:	e8 dd 11 00 00       	call   42564 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   41387:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4138a:	48 98                	cltq   
   4138c:	0f b6 84 00 20 ff 04 	movzbl 0x4ff20(%rax,%rax,1),%eax
   41393:	00 
   41394:	0f be c0             	movsbl %al,%eax
   41397:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   4139a:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4139d:	48 98                	cltq   
   4139f:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   413a6:	00 
   413a7:	84 c0                	test   %al,%al
   413a9:	75 07                	jne    413b2 <memshow_virtual+0xdb>
                owner = PO_FREE;
   413ab:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   413b2:	8b 45 f0             	mov    -0x10(%rbp),%eax
   413b5:	83 c0 02             	add    $0x2,%eax
   413b8:	48 98                	cltq   
   413ba:	0f b7 84 00 00 4c 04 	movzwl 0x44c00(%rax,%rax,1),%eax
   413c1:	00 
   413c2:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   413c6:	8b 45 e0             	mov    -0x20(%rbp),%eax
   413c9:	48 98                	cltq   
   413cb:	83 e0 04             	and    $0x4,%eax
   413ce:	48 85 c0             	test   %rax,%rax
   413d1:	74 27                	je     413fa <memshow_virtual+0x123>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   413d3:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   413d7:	c1 e0 04             	shl    $0x4,%eax
   413da:	66 25 00 f0          	and    $0xf000,%ax
   413de:	89 c2                	mov    %eax,%edx
   413e0:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   413e4:	c1 f8 04             	sar    $0x4,%eax
   413e7:	66 25 00 0f          	and    $0xf00,%ax
   413eb:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   413ed:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   413f1:	0f b6 c0             	movzbl %al,%eax
   413f4:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   413f6:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   413fa:	8b 45 d0             	mov    -0x30(%rbp),%eax
   413fd:	48 98                	cltq   
   413ff:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   41406:	00 
   41407:	3c 01                	cmp    $0x1,%al
   41409:	7e 33                	jle    4143e <memshow_virtual+0x167>
   4140b:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   41410:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41414:	74 28                	je     4143e <memshow_virtual+0x167>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   41416:	b8 53 00 00 00       	mov    $0x53,%eax
   4141b:	89 c2                	mov    %eax,%edx
   4141d:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41421:	66 25 00 f0          	and    $0xf000,%ax
   41425:	09 d0                	or     %edx,%eax
   41427:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   4142b:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4142e:	48 98                	cltq   
   41430:	83 e0 04             	and    $0x4,%eax
   41433:	48 85 c0             	test   %rax,%rax
   41436:	75 06                	jne    4143e <memshow_virtual+0x167>
                    color = color | 0x0F00;
   41438:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   4143e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41442:	48 c1 e8 0c          	shr    $0xc,%rax
   41446:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   41449:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4144c:	83 e0 3f             	and    $0x3f,%eax
   4144f:	85 c0                	test   %eax,%eax
   41451:	75 34                	jne    41487 <memshow_virtual+0x1b0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   41453:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41456:	c1 e8 06             	shr    $0x6,%eax
   41459:	89 c2                	mov    %eax,%edx
   4145b:	89 d0                	mov    %edx,%eax
   4145d:	c1 e0 02             	shl    $0x2,%eax
   41460:	01 d0                	add    %edx,%eax
   41462:	c1 e0 04             	shl    $0x4,%eax
   41465:	05 73 03 00 00       	add    $0x373,%eax
   4146a:	89 c7                	mov    %eax,%edi
   4146c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41470:	48 89 c1             	mov    %rax,%rcx
   41473:	ba f8 4f 04 00       	mov    $0x44ff8,%edx
   41478:	be 00 0f 00 00       	mov    $0xf00,%esi
   4147d:	b8 00 00 00 00       	mov    $0x0,%eax
   41482:	e8 d7 35 00 00       	call   44a5e <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   41487:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4148a:	c1 e8 06             	shr    $0x6,%eax
   4148d:	89 c2                	mov    %eax,%edx
   4148f:	89 d0                	mov    %edx,%eax
   41491:	c1 e0 02             	shl    $0x2,%eax
   41494:	01 d0                	add    %edx,%eax
   41496:	c1 e0 04             	shl    $0x4,%eax
   41499:	89 c2                	mov    %eax,%edx
   4149b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4149e:	83 e0 3f             	and    $0x3f,%eax
   414a1:	01 d0                	add    %edx,%eax
   414a3:	05 7c 03 00 00       	add    $0x37c,%eax
   414a8:	89 c2                	mov    %eax,%edx
   414aa:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   414ae:	66 89 84 12 00 80 0b 	mov    %ax,0xb8000(%rdx,%rdx,1)
   414b5:	00 
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   414b6:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   414bd:	00 
   414be:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   414c5:	00 
   414c6:	0f 86 72 fe ff ff    	jbe    4133e <memshow_virtual+0x67>
    }
}
   414cc:	90                   	nop
   414cd:	90                   	nop
   414ce:	c9                   	leave  
   414cf:	c3                   	ret    

00000000000414d0 <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   414d0:	55                   	push   %rbp
   414d1:	48 89 e5             	mov    %rsp,%rbp
   414d4:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   414d8:	8b 05 46 ee 00 00    	mov    0xee46(%rip),%eax        # 50324 <last_ticks.1>
   414de:	85 c0                	test   %eax,%eax
   414e0:	74 13                	je     414f5 <memshow_virtual_animate+0x25>
   414e2:	8b 15 38 ee 00 00    	mov    0xee38(%rip),%edx        # 50320 <ticks>
   414e8:	8b 05 36 ee 00 00    	mov    0xee36(%rip),%eax        # 50324 <last_ticks.1>
   414ee:	29 c2                	sub    %eax,%edx
   414f0:	83 fa 31             	cmp    $0x31,%edx
   414f3:	76 2c                	jbe    41521 <memshow_virtual_animate+0x51>
        last_ticks = ticks;
   414f5:	8b 05 25 ee 00 00    	mov    0xee25(%rip),%eax        # 50320 <ticks>
   414fb:	89 05 23 ee 00 00    	mov    %eax,0xee23(%rip)        # 50324 <last_ticks.1>
        ++showing;
   41501:	8b 05 fd 4a 00 00    	mov    0x4afd(%rip),%eax        # 46004 <showing.0>
   41507:	83 c0 01             	add    $0x1,%eax
   4150a:	89 05 f4 4a 00 00    	mov    %eax,0x4af4(%rip)        # 46004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   41510:	eb 0f                	jmp    41521 <memshow_virtual_animate+0x51>
           && processes[showing % NPROC].p_state == P_FREE) {
        ++showing;
   41512:	8b 05 ec 4a 00 00    	mov    0x4aec(%rip),%eax        # 46004 <showing.0>
   41518:	83 c0 01             	add    $0x1,%eax
   4151b:	89 05 e3 4a 00 00    	mov    %eax,0x4ae3(%rip)        # 46004 <showing.0>
    while (showing <= 2*NPROC
   41521:	8b 05 dd 4a 00 00    	mov    0x4add(%rip),%eax        # 46004 <showing.0>
           && processes[showing % NPROC].p_state == P_FREE) {
   41527:	83 f8 20             	cmp    $0x20,%eax
   4152a:	7f 34                	jg     41560 <memshow_virtual_animate+0x90>
   4152c:	8b 15 d2 4a 00 00    	mov    0x4ad2(%rip),%edx        # 46004 <showing.0>
   41532:	89 d0                	mov    %edx,%eax
   41534:	c1 f8 1f             	sar    $0x1f,%eax
   41537:	c1 e8 1c             	shr    $0x1c,%eax
   4153a:	01 c2                	add    %eax,%edx
   4153c:	83 e2 0f             	and    $0xf,%edx
   4153f:	29 c2                	sub    %eax,%edx
   41541:	89 d0                	mov    %edx,%eax
   41543:	48 63 d0             	movslq %eax,%rdx
   41546:	48 89 d0             	mov    %rdx,%rax
   41549:	48 c1 e0 04          	shl    $0x4,%rax
   4154d:	48 29 d0             	sub    %rdx,%rax
   41550:	48 c1 e0 04          	shl    $0x4,%rax
   41554:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   4155a:	8b 00                	mov    (%rax),%eax
   4155c:	85 c0                	test   %eax,%eax
   4155e:	74 b2                	je     41512 <memshow_virtual_animate+0x42>
    }
    showing = showing % NPROC;
   41560:	8b 15 9e 4a 00 00    	mov    0x4a9e(%rip),%edx        # 46004 <showing.0>
   41566:	89 d0                	mov    %edx,%eax
   41568:	c1 f8 1f             	sar    $0x1f,%eax
   4156b:	c1 e8 1c             	shr    $0x1c,%eax
   4156e:	01 c2                	add    %eax,%edx
   41570:	83 e2 0f             	and    $0xf,%edx
   41573:	29 c2                	sub    %eax,%edx
   41575:	89 d0                	mov    %edx,%eax
   41577:	89 05 87 4a 00 00    	mov    %eax,0x4a87(%rip)        # 46004 <showing.0>

    if (processes[showing].p_state != P_FREE && processes[showing].display_status) {
   4157d:	8b 05 81 4a 00 00    	mov    0x4a81(%rip),%eax        # 46004 <showing.0>
   41583:	48 63 d0             	movslq %eax,%rdx
   41586:	48 89 d0             	mov    %rdx,%rax
   41589:	48 c1 e0 04          	shl    $0x4,%rax
   4158d:	48 29 d0             	sub    %rdx,%rax
   41590:	48 c1 e0 04          	shl    $0x4,%rax
   41594:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   4159a:	8b 00                	mov    (%rax),%eax
   4159c:	85 c0                	test   %eax,%eax
   4159e:	74 76                	je     41616 <memshow_virtual_animate+0x146>
   415a0:	8b 05 5e 4a 00 00    	mov    0x4a5e(%rip),%eax        # 46004 <showing.0>
   415a6:	48 63 d0             	movslq %eax,%rdx
   415a9:	48 89 d0             	mov    %rdx,%rax
   415ac:	48 c1 e0 04          	shl    $0x4,%rax
   415b0:	48 29 d0             	sub    %rdx,%rax
   415b3:	48 c1 e0 04          	shl    $0x4,%rax
   415b7:	48 05 e8 f0 04 00    	add    $0x4f0e8,%rax
   415bd:	0f b6 00             	movzbl (%rax),%eax
   415c0:	84 c0                	test   %al,%al
   415c2:	74 52                	je     41616 <memshow_virtual_animate+0x146>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   415c4:	8b 15 3a 4a 00 00    	mov    0x4a3a(%rip),%edx        # 46004 <showing.0>
   415ca:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   415ce:	89 d1                	mov    %edx,%ecx
   415d0:	ba 64 50 04 00       	mov    $0x45064,%edx
   415d5:	be 04 00 00 00       	mov    $0x4,%esi
   415da:	48 89 c7             	mov    %rax,%rdi
   415dd:	b8 00 00 00 00       	mov    $0x0,%eax
   415e2:	e8 83 35 00 00       	call   44b6a <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   415e7:	8b 05 17 4a 00 00    	mov    0x4a17(%rip),%eax        # 46004 <showing.0>
   415ed:	48 63 d0             	movslq %eax,%rdx
   415f0:	48 89 d0             	mov    %rdx,%rax
   415f3:	48 c1 e0 04          	shl    $0x4,%rax
   415f7:	48 29 d0             	sub    %rdx,%rax
   415fa:	48 c1 e0 04          	shl    $0x4,%rax
   415fe:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   41604:	48 8b 00             	mov    (%rax),%rax
   41607:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   4160b:	48 89 d6             	mov    %rdx,%rsi
   4160e:	48 89 c7             	mov    %rax,%rdi
   41611:	e8 c1 fc ff ff       	call   412d7 <memshow_virtual>
    }
}
   41616:	90                   	nop
   41617:	c9                   	leave  
   41618:	c3                   	ret    

0000000000041619 <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   41619:	55                   	push   %rbp
   4161a:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   4161d:	e8 4f 01 00 00       	call   41771 <segments_init>
    interrupt_init();
   41622:	e8 d0 03 00 00       	call   419f7 <interrupt_init>
    virtual_memory_init();
   41627:	e8 f3 0f 00 00       	call   4261f <virtual_memory_init>
}
   4162c:	90                   	nop
   4162d:	5d                   	pop    %rbp
   4162e:	c3                   	ret    

000000000004162f <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   4162f:	55                   	push   %rbp
   41630:	48 89 e5             	mov    %rsp,%rbp
   41633:	48 83 ec 18          	sub    $0x18,%rsp
   41637:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4163b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   4163f:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   41642:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41645:	48 98                	cltq   
   41647:	48 c1 e0 2d          	shl    $0x2d,%rax
   4164b:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   4164f:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   41656:	90 00 00 
   41659:	48 09 c2             	or     %rax,%rdx
    *segment = type
   4165c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41660:	48 89 10             	mov    %rdx,(%rax)
}
   41663:	90                   	nop
   41664:	c9                   	leave  
   41665:	c3                   	ret    

0000000000041666 <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   41666:	55                   	push   %rbp
   41667:	48 89 e5             	mov    %rsp,%rbp
   4166a:	48 83 ec 28          	sub    $0x28,%rsp
   4166e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41672:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41676:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41679:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   4167d:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41681:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41685:	48 c1 e0 10          	shl    $0x10,%rax
   41689:	48 89 c2             	mov    %rax,%rdx
   4168c:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   41693:	00 00 00 
   41696:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   41699:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4169d:	48 c1 e0 20          	shl    $0x20,%rax
   416a1:	48 89 c1             	mov    %rax,%rcx
   416a4:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   416ab:	00 00 ff 
   416ae:	48 21 c8             	and    %rcx,%rax
   416b1:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   416b4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   416b8:	48 83 e8 01          	sub    $0x1,%rax
   416bc:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   416bf:	48 09 d0             	or     %rdx,%rax
        | type
   416c2:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   416c6:	8b 55 ec             	mov    -0x14(%rbp),%edx
   416c9:	48 63 d2             	movslq %edx,%rdx
   416cc:	48 c1 e2 2d          	shl    $0x2d,%rdx
   416d0:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   416d3:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   416da:	80 00 00 
   416dd:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   416e0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   416e4:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   416e7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   416eb:	48 83 c0 08          	add    $0x8,%rax
   416ef:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   416f3:	48 c1 ea 20          	shr    $0x20,%rdx
   416f7:	48 89 10             	mov    %rdx,(%rax)
}
   416fa:	90                   	nop
   416fb:	c9                   	leave  
   416fc:	c3                   	ret    

00000000000416fd <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   416fd:	55                   	push   %rbp
   416fe:	48 89 e5             	mov    %rsp,%rbp
   41701:	48 83 ec 20          	sub    $0x20,%rsp
   41705:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41709:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   4170d:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41710:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41714:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41718:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   4171b:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   4171f:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41722:	48 63 d2             	movslq %edx,%rdx
   41725:	48 c1 e2 2d          	shl    $0x2d,%rdx
   41729:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   4172c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41730:	48 c1 e0 20          	shl    $0x20,%rax
   41734:	48 89 c1             	mov    %rax,%rcx
   41737:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   4173e:	00 ff ff 
   41741:	48 21 c8             	and    %rcx,%rax
   41744:	48 09 c2             	or     %rax,%rdx
   41747:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   4174e:	80 00 00 
   41751:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41754:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41758:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   4175b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4175f:	48 c1 e8 20          	shr    $0x20,%rax
   41763:	48 89 c2             	mov    %rax,%rdx
   41766:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4176a:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   4176e:	90                   	nop
   4176f:	c9                   	leave  
   41770:	c3                   	ret    

0000000000041771 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   41771:	55                   	push   %rbp
   41772:	48 89 e5             	mov    %rsp,%rbp
   41775:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   41779:	48 c7 05 bc eb 00 00 	movq   $0x0,0xebbc(%rip)        # 50340 <segments>
   41780:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   41784:	ba 00 00 00 00       	mov    $0x0,%edx
   41789:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41790:	08 20 00 
   41793:	48 89 c6             	mov    %rax,%rsi
   41796:	bf 48 03 05 00       	mov    $0x50348,%edi
   4179b:	e8 8f fe ff ff       	call   4162f <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   417a0:	ba 03 00 00 00       	mov    $0x3,%edx
   417a5:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   417ac:	08 20 00 
   417af:	48 89 c6             	mov    %rax,%rsi
   417b2:	bf 50 03 05 00       	mov    $0x50350,%edi
   417b7:	e8 73 fe ff ff       	call   4162f <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   417bc:	ba 00 00 00 00       	mov    $0x0,%edx
   417c1:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   417c8:	02 00 00 
   417cb:	48 89 c6             	mov    %rax,%rsi
   417ce:	bf 58 03 05 00       	mov    $0x50358,%edi
   417d3:	e8 57 fe ff ff       	call   4162f <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   417d8:	ba 03 00 00 00       	mov    $0x3,%edx
   417dd:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   417e4:	02 00 00 
   417e7:	48 89 c6             	mov    %rax,%rsi
   417ea:	bf 60 03 05 00       	mov    $0x50360,%edi
   417ef:	e8 3b fe ff ff       	call   4162f <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   417f4:	b8 80 13 05 00       	mov    $0x51380,%eax
   417f9:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   417ff:	48 89 c1             	mov    %rax,%rcx
   41802:	ba 00 00 00 00       	mov    $0x0,%edx
   41807:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   4180e:	09 00 00 
   41811:	48 89 c6             	mov    %rax,%rsi
   41814:	bf 68 03 05 00       	mov    $0x50368,%edi
   41819:	e8 48 fe ff ff       	call   41666 <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   4181e:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   41824:	b8 40 03 05 00       	mov    $0x50340,%eax
   41829:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   4182d:	ba 60 00 00 00       	mov    $0x60,%edx
   41832:	be 00 00 00 00       	mov    $0x0,%esi
   41837:	bf 80 13 05 00       	mov    $0x51380,%edi
   4183c:	e8 66 24 00 00       	call   43ca7 <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   41841:	48 c7 05 38 fb 00 00 	movq   $0x80000,0xfb38(%rip)        # 51384 <kernel_task_descriptor+0x4>
   41848:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   4184c:	ba 00 10 00 00       	mov    $0x1000,%edx
   41851:	be 00 00 00 00       	mov    $0x0,%esi
   41856:	bf 80 03 05 00       	mov    $0x50380,%edi
   4185b:	e8 47 24 00 00       	call   43ca7 <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41860:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   41867:	eb 30                	jmp    41899 <segments_init+0x128>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   41869:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   4186e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41871:	48 c1 e0 04          	shl    $0x4,%rax
   41875:	48 05 80 03 05 00    	add    $0x50380,%rax
   4187b:	48 89 d1             	mov    %rdx,%rcx
   4187e:	ba 00 00 00 00       	mov    $0x0,%edx
   41883:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   4188a:	0e 00 00 
   4188d:	48 89 c7             	mov    %rax,%rdi
   41890:	e8 68 fe ff ff       	call   416fd <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41895:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41899:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   418a0:	76 c7                	jbe    41869 <segments_init+0xf8>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   418a2:	b8 36 00 04 00       	mov    $0x40036,%eax
   418a7:	48 89 c1             	mov    %rax,%rcx
   418aa:	ba 00 00 00 00       	mov    $0x0,%edx
   418af:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   418b6:	0e 00 00 
   418b9:	48 89 c6             	mov    %rax,%rsi
   418bc:	bf 80 05 05 00       	mov    $0x50580,%edi
   418c1:	e8 37 fe ff ff       	call   416fd <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   418c6:	b8 2e 00 04 00       	mov    $0x4002e,%eax
   418cb:	48 89 c1             	mov    %rax,%rcx
   418ce:	ba 00 00 00 00       	mov    $0x0,%edx
   418d3:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   418da:	0e 00 00 
   418dd:	48 89 c6             	mov    %rax,%rsi
   418e0:	bf 50 04 05 00       	mov    $0x50450,%edi
   418e5:	e8 13 fe ff ff       	call   416fd <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   418ea:	b8 32 00 04 00       	mov    $0x40032,%eax
   418ef:	48 89 c1             	mov    %rax,%rcx
   418f2:	ba 00 00 00 00       	mov    $0x0,%edx
   418f7:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   418fe:	0e 00 00 
   41901:	48 89 c6             	mov    %rax,%rsi
   41904:	bf 60 04 05 00       	mov    $0x50460,%edi
   41909:	e8 ef fd ff ff       	call   416fd <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   4190e:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   41915:	eb 3e                	jmp    41955 <segments_init+0x1e4>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   41917:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4191a:	83 e8 30             	sub    $0x30,%eax
   4191d:	89 c0                	mov    %eax,%eax
   4191f:	48 8b 04 c5 e7 00 04 	mov    0x400e7(,%rax,8),%rax
   41926:	00 
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   41927:	48 89 c2             	mov    %rax,%rdx
   4192a:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4192d:	48 c1 e0 04          	shl    $0x4,%rax
   41931:	48 05 80 03 05 00    	add    $0x50380,%rax
   41937:	48 89 d1             	mov    %rdx,%rcx
   4193a:	ba 03 00 00 00       	mov    $0x3,%edx
   4193f:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41946:	0e 00 00 
   41949:	48 89 c7             	mov    %rax,%rdi
   4194c:	e8 ac fd ff ff       	call   416fd <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41951:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41955:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   41959:	76 bc                	jbe    41917 <segments_init+0x1a6>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   4195b:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   41961:	b8 80 03 05 00       	mov    $0x50380,%eax
   41966:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   4196a:	b8 28 00 00 00       	mov    $0x28,%eax
   4196f:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   41973:	0f 00 d8             	ltr    %ax
   41976:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   4197a:	0f 20 c0             	mov    %cr0,%rax
   4197d:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   41981:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   41985:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   41988:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   4198f:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41992:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   41995:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41998:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   4199c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   419a0:	0f 22 c0             	mov    %rax,%cr0
}
   419a3:	90                   	nop
    lcr0(cr0);
}
   419a4:	90                   	nop
   419a5:	c9                   	leave  
   419a6:	c3                   	ret    

00000000000419a7 <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   419a7:	55                   	push   %rbp
   419a8:	48 89 e5             	mov    %rsp,%rbp
   419ab:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   419af:	0f b7 05 2a fa 00 00 	movzwl 0xfa2a(%rip),%eax        # 513e0 <interrupts_enabled>
   419b6:	f7 d0                	not    %eax
   419b8:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   419bc:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   419c0:	0f b6 c0             	movzbl %al,%eax
   419c3:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   419ca:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   419cd:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   419d1:	8b 55 f0             	mov    -0x10(%rbp),%edx
   419d4:	ee                   	out    %al,(%dx)
}
   419d5:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   419d6:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   419da:	66 c1 e8 08          	shr    $0x8,%ax
   419de:	0f b6 c0             	movzbl %al,%eax
   419e1:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   419e8:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   419eb:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   419ef:	8b 55 f8             	mov    -0x8(%rbp),%edx
   419f2:	ee                   	out    %al,(%dx)
}
   419f3:	90                   	nop
}
   419f4:	90                   	nop
   419f5:	c9                   	leave  
   419f6:	c3                   	ret    

00000000000419f7 <interrupt_init>:

void interrupt_init(void) {
   419f7:	55                   	push   %rbp
   419f8:	48 89 e5             	mov    %rsp,%rbp
   419fb:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   419ff:	66 c7 05 d8 f9 00 00 	movw   $0x0,0xf9d8(%rip)        # 513e0 <interrupts_enabled>
   41a06:	00 00 
    interrupt_mask();
   41a08:	e8 9a ff ff ff       	call   419a7 <interrupt_mask>
   41a0d:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   41a14:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a18:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   41a1c:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   41a1f:	ee                   	out    %al,(%dx)
}
   41a20:	90                   	nop
   41a21:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   41a28:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a2c:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   41a30:	8b 55 ac             	mov    -0x54(%rbp),%edx
   41a33:	ee                   	out    %al,(%dx)
}
   41a34:	90                   	nop
   41a35:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   41a3c:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a40:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   41a44:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   41a47:	ee                   	out    %al,(%dx)
}
   41a48:	90                   	nop
   41a49:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   41a50:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a54:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   41a58:	8b 55 bc             	mov    -0x44(%rbp),%edx
   41a5b:	ee                   	out    %al,(%dx)
}
   41a5c:	90                   	nop
   41a5d:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   41a64:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a68:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   41a6c:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   41a6f:	ee                   	out    %al,(%dx)
}
   41a70:	90                   	nop
   41a71:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   41a78:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a7c:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   41a80:	8b 55 cc             	mov    -0x34(%rbp),%edx
   41a83:	ee                   	out    %al,(%dx)
}
   41a84:	90                   	nop
   41a85:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   41a8c:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a90:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   41a94:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   41a97:	ee                   	out    %al,(%dx)
}
   41a98:	90                   	nop
   41a99:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   41aa0:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41aa4:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   41aa8:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41aab:	ee                   	out    %al,(%dx)
}
   41aac:	90                   	nop
   41aad:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   41ab4:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ab8:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41abc:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41abf:	ee                   	out    %al,(%dx)
}
   41ac0:	90                   	nop
   41ac1:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   41ac8:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41acc:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41ad0:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41ad3:	ee                   	out    %al,(%dx)
}
   41ad4:	90                   	nop
   41ad5:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   41adc:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ae0:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41ae4:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41ae7:	ee                   	out    %al,(%dx)
}
   41ae8:	90                   	nop
   41ae9:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   41af0:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41af4:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41af8:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41afb:	ee                   	out    %al,(%dx)
}
   41afc:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   41afd:	e8 a5 fe ff ff       	call   419a7 <interrupt_mask>
}
   41b02:	90                   	nop
   41b03:	c9                   	leave  
   41b04:	c3                   	ret    

0000000000041b05 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   41b05:	55                   	push   %rbp
   41b06:	48 89 e5             	mov    %rsp,%rbp
   41b09:	48 83 ec 28          	sub    $0x28,%rsp
   41b0d:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   41b10:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41b14:	0f 8e 9e 00 00 00    	jle    41bb8 <timer_init+0xb3>
   41b1a:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   41b21:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b25:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41b29:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41b2c:	ee                   	out    %al,(%dx)
}
   41b2d:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   41b2e:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41b31:	89 c2                	mov    %eax,%edx
   41b33:	c1 ea 1f             	shr    $0x1f,%edx
   41b36:	01 d0                	add    %edx,%eax
   41b38:	d1 f8                	sar    %eax
   41b3a:	05 de 34 12 00       	add    $0x1234de,%eax
   41b3f:	99                   	cltd   
   41b40:	f7 7d dc             	idivl  -0x24(%rbp)
   41b43:	89 c2                	mov    %eax,%edx
   41b45:	89 d0                	mov    %edx,%eax
   41b47:	c1 f8 1f             	sar    $0x1f,%eax
   41b4a:	c1 e8 18             	shr    $0x18,%eax
   41b4d:	01 c2                	add    %eax,%edx
   41b4f:	0f b6 d2             	movzbl %dl,%edx
   41b52:	29 c2                	sub    %eax,%edx
   41b54:	89 d0                	mov    %edx,%eax
   41b56:	0f b6 c0             	movzbl %al,%eax
   41b59:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   41b60:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b63:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41b67:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41b6a:	ee                   	out    %al,(%dx)
}
   41b6b:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   41b6c:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41b6f:	89 c2                	mov    %eax,%edx
   41b71:	c1 ea 1f             	shr    $0x1f,%edx
   41b74:	01 d0                	add    %edx,%eax
   41b76:	d1 f8                	sar    %eax
   41b78:	05 de 34 12 00       	add    $0x1234de,%eax
   41b7d:	99                   	cltd   
   41b7e:	f7 7d dc             	idivl  -0x24(%rbp)
   41b81:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41b87:	85 c0                	test   %eax,%eax
   41b89:	0f 48 c2             	cmovs  %edx,%eax
   41b8c:	c1 f8 08             	sar    $0x8,%eax
   41b8f:	0f b6 c0             	movzbl %al,%eax
   41b92:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   41b99:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b9c:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41ba0:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41ba3:	ee                   	out    %al,(%dx)
}
   41ba4:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   41ba5:	0f b7 05 34 f8 00 00 	movzwl 0xf834(%rip),%eax        # 513e0 <interrupts_enabled>
   41bac:	83 c8 01             	or     $0x1,%eax
   41baf:	66 89 05 2a f8 00 00 	mov    %ax,0xf82a(%rip)        # 513e0 <interrupts_enabled>
   41bb6:	eb 11                	jmp    41bc9 <timer_init+0xc4>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   41bb8:	0f b7 05 21 f8 00 00 	movzwl 0xf821(%rip),%eax        # 513e0 <interrupts_enabled>
   41bbf:	83 e0 fe             	and    $0xfffffffe,%eax
   41bc2:	66 89 05 17 f8 00 00 	mov    %ax,0xf817(%rip)        # 513e0 <interrupts_enabled>
    }
    interrupt_mask();
   41bc9:	e8 d9 fd ff ff       	call   419a7 <interrupt_mask>
}
   41bce:	90                   	nop
   41bcf:	c9                   	leave  
   41bd0:	c3                   	ret    

0000000000041bd1 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   41bd1:	55                   	push   %rbp
   41bd2:	48 89 e5             	mov    %rsp,%rbp
   41bd5:	48 83 ec 08          	sub    $0x8,%rsp
   41bd9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   41bdd:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   41be2:	74 14                	je     41bf8 <physical_memory_isreserved+0x27>
   41be4:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   41beb:	00 
   41bec:	76 11                	jbe    41bff <physical_memory_isreserved+0x2e>
   41bee:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   41bf5:	00 
   41bf6:	77 07                	ja     41bff <physical_memory_isreserved+0x2e>
   41bf8:	b8 01 00 00 00       	mov    $0x1,%eax
   41bfd:	eb 05                	jmp    41c04 <physical_memory_isreserved+0x33>
   41bff:	b8 00 00 00 00       	mov    $0x0,%eax
}
   41c04:	c9                   	leave  
   41c05:	c3                   	ret    

0000000000041c06 <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   41c06:	55                   	push   %rbp
   41c07:	48 89 e5             	mov    %rsp,%rbp
   41c0a:	48 83 ec 10          	sub    $0x10,%rsp
   41c0e:	89 7d fc             	mov    %edi,-0x4(%rbp)
   41c11:	89 75 f8             	mov    %esi,-0x8(%rbp)
   41c14:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   41c17:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41c1a:	c1 e0 10             	shl    $0x10,%eax
   41c1d:	89 c2                	mov    %eax,%edx
   41c1f:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41c22:	c1 e0 0b             	shl    $0xb,%eax
   41c25:	09 c2                	or     %eax,%edx
   41c27:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41c2a:	c1 e0 08             	shl    $0x8,%eax
   41c2d:	09 d0                	or     %edx,%eax
}
   41c2f:	c9                   	leave  
   41c30:	c3                   	ret    

0000000000041c31 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   41c31:	55                   	push   %rbp
   41c32:	48 89 e5             	mov    %rsp,%rbp
   41c35:	48 83 ec 18          	sub    $0x18,%rsp
   41c39:	89 7d ec             	mov    %edi,-0x14(%rbp)
   41c3c:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   41c3f:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41c42:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41c45:	09 d0                	or     %edx,%eax
   41c47:	0d 00 00 00 80       	or     $0x80000000,%eax
   41c4c:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   41c53:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   41c56:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41c59:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41c5c:	ef                   	out    %eax,(%dx)
}
   41c5d:	90                   	nop
   41c5e:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   41c65:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41c68:	89 c2                	mov    %eax,%edx
   41c6a:	ed                   	in     (%dx),%eax
   41c6b:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   41c6e:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   41c71:	c9                   	leave  
   41c72:	c3                   	ret    

0000000000041c73 <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   41c73:	55                   	push   %rbp
   41c74:	48 89 e5             	mov    %rsp,%rbp
   41c77:	48 83 ec 28          	sub    $0x28,%rsp
   41c7b:	89 7d dc             	mov    %edi,-0x24(%rbp)
   41c7e:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   41c81:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41c88:	eb 73                	jmp    41cfd <pci_find_device+0x8a>
        for (int slot = 0; slot != 32; ++slot) {
   41c8a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41c91:	eb 60                	jmp    41cf3 <pci_find_device+0x80>
            for (int func = 0; func != 8; ++func) {
   41c93:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41c9a:	eb 4a                	jmp    41ce6 <pci_find_device+0x73>
                int configaddr = pci_make_configaddr(bus, slot, func);
   41c9c:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41c9f:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41ca2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41ca5:	89 ce                	mov    %ecx,%esi
   41ca7:	89 c7                	mov    %eax,%edi
   41ca9:	e8 58 ff ff ff       	call   41c06 <pci_make_configaddr>
   41cae:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   41cb1:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41cb4:	be 00 00 00 00       	mov    $0x0,%esi
   41cb9:	89 c7                	mov    %eax,%edi
   41cbb:	e8 71 ff ff ff       	call   41c31 <pci_config_readl>
   41cc0:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   41cc3:	8b 45 d8             	mov    -0x28(%rbp),%eax
   41cc6:	c1 e0 10             	shl    $0x10,%eax
   41cc9:	0b 45 dc             	or     -0x24(%rbp),%eax
   41ccc:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   41ccf:	75 05                	jne    41cd6 <pci_find_device+0x63>
                    return configaddr;
   41cd1:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41cd4:	eb 35                	jmp    41d0b <pci_find_device+0x98>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   41cd6:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   41cda:	75 06                	jne    41ce2 <pci_find_device+0x6f>
   41cdc:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41ce0:	74 0c                	je     41cee <pci_find_device+0x7b>
            for (int func = 0; func != 8; ++func) {
   41ce2:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41ce6:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   41cea:	75 b0                	jne    41c9c <pci_find_device+0x29>
   41cec:	eb 01                	jmp    41cef <pci_find_device+0x7c>
                    break;
   41cee:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   41cef:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41cf3:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   41cf7:	75 9a                	jne    41c93 <pci_find_device+0x20>
    for (int bus = 0; bus != 256; ++bus) {
   41cf9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41cfd:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   41d04:	75 84                	jne    41c8a <pci_find_device+0x17>
                }
            }
        }
    }
    return -1;
   41d06:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   41d0b:	c9                   	leave  
   41d0c:	c3                   	ret    

0000000000041d0d <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   41d0d:	55                   	push   %rbp
   41d0e:	48 89 e5             	mov    %rsp,%rbp
   41d11:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   41d15:	be 13 71 00 00       	mov    $0x7113,%esi
   41d1a:	bf 86 80 00 00       	mov    $0x8086,%edi
   41d1f:	e8 4f ff ff ff       	call   41c73 <pci_find_device>
   41d24:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   41d27:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   41d2b:	78 30                	js     41d5d <poweroff+0x50>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   41d2d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41d30:	be 40 00 00 00       	mov    $0x40,%esi
   41d35:	89 c7                	mov    %eax,%edi
   41d37:	e8 f5 fe ff ff       	call   41c31 <pci_config_readl>
   41d3c:	25 c0 ff 00 00       	and    $0xffc0,%eax
   41d41:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   41d44:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41d47:	83 c0 04             	add    $0x4,%eax
   41d4a:	89 45 f4             	mov    %eax,-0xc(%rbp)
   41d4d:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   41d53:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   41d57:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41d5a:	66 ef                	out    %ax,(%dx)
}
   41d5c:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   41d5d:	ba 80 50 04 00       	mov    $0x45080,%edx
   41d62:	be 00 c0 00 00       	mov    $0xc000,%esi
   41d67:	bf 80 07 00 00       	mov    $0x780,%edi
   41d6c:	b8 00 00 00 00       	mov    $0x0,%eax
   41d71:	e8 e8 2c 00 00       	call   44a5e <console_printf>
 spinloop: goto spinloop;
   41d76:	eb fe                	jmp    41d76 <poweroff+0x69>

0000000000041d78 <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   41d78:	55                   	push   %rbp
   41d79:	48 89 e5             	mov    %rsp,%rbp
   41d7c:	48 83 ec 10          	sub    $0x10,%rsp
   41d80:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   41d87:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d8b:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41d8f:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41d92:	ee                   	out    %al,(%dx)
}
   41d93:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   41d94:	eb fe                	jmp    41d94 <reboot+0x1c>

0000000000041d96 <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   41d96:	55                   	push   %rbp
   41d97:	48 89 e5             	mov    %rsp,%rbp
   41d9a:	48 83 ec 10          	sub    $0x10,%rsp
   41d9e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41da2:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   41da5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41da9:	48 83 c0 18          	add    $0x18,%rax
   41dad:	ba c0 00 00 00       	mov    $0xc0,%edx
   41db2:	be 00 00 00 00       	mov    $0x0,%esi
   41db7:	48 89 c7             	mov    %rax,%rdi
   41dba:	e8 e8 1e 00 00       	call   43ca7 <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   41dbf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41dc3:	66 c7 80 b8 00 00 00 	movw   $0x13,0xb8(%rax)
   41dca:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   41dcc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41dd0:	48 c7 80 90 00 00 00 	movq   $0x23,0x90(%rax)
   41dd7:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   41ddb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ddf:	48 c7 80 98 00 00 00 	movq   $0x23,0x98(%rax)
   41de6:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   41dea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41dee:	66 c7 80 d0 00 00 00 	movw   $0x23,0xd0(%rax)
   41df5:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   41df7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41dfb:	48 c7 80 c0 00 00 00 	movq   $0x200,0xc0(%rax)
   41e02:	00 02 00 00 

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   41e06:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41e09:	83 e0 01             	and    $0x1,%eax
   41e0c:	85 c0                	test   %eax,%eax
   41e0e:	74 1c                	je     41e2c <process_init+0x96>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   41e10:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e14:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   41e1b:	80 cc 30             	or     $0x30,%ah
   41e1e:	48 89 c2             	mov    %rax,%rdx
   41e21:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e25:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   41e2c:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41e2f:	83 e0 02             	and    $0x2,%eax
   41e32:	85 c0                	test   %eax,%eax
   41e34:	74 1c                	je     41e52 <process_init+0xbc>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   41e36:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e3a:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   41e41:	80 e4 fd             	and    $0xfd,%ah
   41e44:	48 89 c2             	mov    %rax,%rdx
   41e47:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e4b:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    p->display_status = 1;
   41e52:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e56:	c6 80 e8 00 00 00 01 	movb   $0x1,0xe8(%rax)
}
   41e5d:	90                   	nop
   41e5e:	c9                   	leave  
   41e5f:	c3                   	ret    

0000000000041e60 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   41e60:	55                   	push   %rbp
   41e61:	48 89 e5             	mov    %rsp,%rbp
   41e64:	48 83 ec 28          	sub    $0x28,%rsp
   41e68:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   41e6b:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41e6f:	78 09                	js     41e7a <console_show_cursor+0x1a>
   41e71:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   41e78:	7e 07                	jle    41e81 <console_show_cursor+0x21>
        cpos = 0;
   41e7a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   41e81:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   41e88:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e8c:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41e90:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41e93:	ee                   	out    %al,(%dx)
}
   41e94:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   41e95:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41e98:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41e9e:	85 c0                	test   %eax,%eax
   41ea0:	0f 48 c2             	cmovs  %edx,%eax
   41ea3:	c1 f8 08             	sar    $0x8,%eax
   41ea6:	0f b6 c0             	movzbl %al,%eax
   41ea9:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   41eb0:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41eb3:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41eb7:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41eba:	ee                   	out    %al,(%dx)
}
   41ebb:	90                   	nop
   41ebc:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   41ec3:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ec7:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41ecb:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41ece:	ee                   	out    %al,(%dx)
}
   41ecf:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   41ed0:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41ed3:	89 d0                	mov    %edx,%eax
   41ed5:	c1 f8 1f             	sar    $0x1f,%eax
   41ed8:	c1 e8 18             	shr    $0x18,%eax
   41edb:	01 c2                	add    %eax,%edx
   41edd:	0f b6 d2             	movzbl %dl,%edx
   41ee0:	29 c2                	sub    %eax,%edx
   41ee2:	89 d0                	mov    %edx,%eax
   41ee4:	0f b6 c0             	movzbl %al,%eax
   41ee7:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   41eee:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ef1:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41ef5:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41ef8:	ee                   	out    %al,(%dx)
}
   41ef9:	90                   	nop
}
   41efa:	90                   	nop
   41efb:	c9                   	leave  
   41efc:	c3                   	ret    

0000000000041efd <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   41efd:	55                   	push   %rbp
   41efe:	48 89 e5             	mov    %rsp,%rbp
   41f01:	48 83 ec 20          	sub    $0x20,%rsp
   41f05:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41f0c:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41f0f:	89 c2                	mov    %eax,%edx
   41f11:	ec                   	in     (%dx),%al
   41f12:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   41f15:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   41f19:	0f b6 c0             	movzbl %al,%eax
   41f1c:	83 e0 01             	and    $0x1,%eax
   41f1f:	85 c0                	test   %eax,%eax
   41f21:	75 0a                	jne    41f2d <keyboard_readc+0x30>
        return -1;
   41f23:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   41f28:	e9 e7 01 00 00       	jmp    42114 <keyboard_readc+0x217>
   41f2d:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41f34:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41f37:	89 c2                	mov    %eax,%edx
   41f39:	ec                   	in     (%dx),%al
   41f3a:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   41f3d:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   41f41:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   41f44:	0f b6 05 97 f4 00 00 	movzbl 0xf497(%rip),%eax        # 513e2 <last_escape.2>
   41f4b:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   41f4e:	c6 05 8d f4 00 00 00 	movb   $0x0,0xf48d(%rip)        # 513e2 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   41f55:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   41f59:	75 11                	jne    41f6c <keyboard_readc+0x6f>
        last_escape = 0x80;
   41f5b:	c6 05 80 f4 00 00 80 	movb   $0x80,0xf480(%rip)        # 513e2 <last_escape.2>
        return 0;
   41f62:	b8 00 00 00 00       	mov    $0x0,%eax
   41f67:	e9 a8 01 00 00       	jmp    42114 <keyboard_readc+0x217>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   41f6c:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41f70:	84 c0                	test   %al,%al
   41f72:	79 60                	jns    41fd4 <keyboard_readc+0xd7>
        int ch = keymap[(data & 0x7F) | escape];
   41f74:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41f78:	83 e0 7f             	and    $0x7f,%eax
   41f7b:	89 c2                	mov    %eax,%edx
   41f7d:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   41f81:	09 d0                	or     %edx,%eax
   41f83:	48 98                	cltq   
   41f85:	0f b6 80 a0 50 04 00 	movzbl 0x450a0(%rax),%eax
   41f8c:	0f b6 c0             	movzbl %al,%eax
   41f8f:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   41f92:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   41f99:	7e 2f                	jle    41fca <keyboard_readc+0xcd>
   41f9b:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   41fa2:	7f 26                	jg     41fca <keyboard_readc+0xcd>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   41fa4:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41fa7:	2d fa 00 00 00       	sub    $0xfa,%eax
   41fac:	ba 01 00 00 00       	mov    $0x1,%edx
   41fb1:	89 c1                	mov    %eax,%ecx
   41fb3:	d3 e2                	shl    %cl,%edx
   41fb5:	89 d0                	mov    %edx,%eax
   41fb7:	f7 d0                	not    %eax
   41fb9:	89 c2                	mov    %eax,%edx
   41fbb:	0f b6 05 21 f4 00 00 	movzbl 0xf421(%rip),%eax        # 513e3 <modifiers.1>
   41fc2:	21 d0                	and    %edx,%eax
   41fc4:	88 05 19 f4 00 00    	mov    %al,0xf419(%rip)        # 513e3 <modifiers.1>
        }
        return 0;
   41fca:	b8 00 00 00 00       	mov    $0x0,%eax
   41fcf:	e9 40 01 00 00       	jmp    42114 <keyboard_readc+0x217>
    }

    int ch = (unsigned char) keymap[data | escape];
   41fd4:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41fd8:	0a 45 fa             	or     -0x6(%rbp),%al
   41fdb:	0f b6 c0             	movzbl %al,%eax
   41fde:	48 98                	cltq   
   41fe0:	0f b6 80 a0 50 04 00 	movzbl 0x450a0(%rax),%eax
   41fe7:	0f b6 c0             	movzbl %al,%eax
   41fea:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   41fed:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   41ff1:	7e 57                	jle    4204a <keyboard_readc+0x14d>
   41ff3:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   41ff7:	7f 51                	jg     4204a <keyboard_readc+0x14d>
        if (modifiers & MOD_CONTROL) {
   41ff9:	0f b6 05 e3 f3 00 00 	movzbl 0xf3e3(%rip),%eax        # 513e3 <modifiers.1>
   42000:	0f b6 c0             	movzbl %al,%eax
   42003:	83 e0 02             	and    $0x2,%eax
   42006:	85 c0                	test   %eax,%eax
   42008:	74 09                	je     42013 <keyboard_readc+0x116>
            ch -= 0x60;
   4200a:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   4200e:	e9 fd 00 00 00       	jmp    42110 <keyboard_readc+0x213>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   42013:	0f b6 05 c9 f3 00 00 	movzbl 0xf3c9(%rip),%eax        # 513e3 <modifiers.1>
   4201a:	0f b6 c0             	movzbl %al,%eax
   4201d:	83 e0 01             	and    $0x1,%eax
   42020:	85 c0                	test   %eax,%eax
   42022:	0f 94 c2             	sete   %dl
   42025:	0f b6 05 b7 f3 00 00 	movzbl 0xf3b7(%rip),%eax        # 513e3 <modifiers.1>
   4202c:	0f b6 c0             	movzbl %al,%eax
   4202f:	83 e0 08             	and    $0x8,%eax
   42032:	85 c0                	test   %eax,%eax
   42034:	0f 94 c0             	sete   %al
   42037:	31 d0                	xor    %edx,%eax
   42039:	84 c0                	test   %al,%al
   4203b:	0f 84 cf 00 00 00    	je     42110 <keyboard_readc+0x213>
            ch -= 0x20;
   42041:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   42045:	e9 c6 00 00 00       	jmp    42110 <keyboard_readc+0x213>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   4204a:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   42051:	7e 30                	jle    42083 <keyboard_readc+0x186>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   42053:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42056:	2d fa 00 00 00       	sub    $0xfa,%eax
   4205b:	ba 01 00 00 00       	mov    $0x1,%edx
   42060:	89 c1                	mov    %eax,%ecx
   42062:	d3 e2                	shl    %cl,%edx
   42064:	89 d0                	mov    %edx,%eax
   42066:	89 c2                	mov    %eax,%edx
   42068:	0f b6 05 74 f3 00 00 	movzbl 0xf374(%rip),%eax        # 513e3 <modifiers.1>
   4206f:	31 d0                	xor    %edx,%eax
   42071:	88 05 6c f3 00 00    	mov    %al,0xf36c(%rip)        # 513e3 <modifiers.1>
        ch = 0;
   42077:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4207e:	e9 8e 00 00 00       	jmp    42111 <keyboard_readc+0x214>
    } else if (ch >= KEY_SHIFT) {
   42083:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   4208a:	7e 2d                	jle    420b9 <keyboard_readc+0x1bc>
        modifiers |= 1 << (ch - KEY_SHIFT);
   4208c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4208f:	2d fa 00 00 00       	sub    $0xfa,%eax
   42094:	ba 01 00 00 00       	mov    $0x1,%edx
   42099:	89 c1                	mov    %eax,%ecx
   4209b:	d3 e2                	shl    %cl,%edx
   4209d:	89 d0                	mov    %edx,%eax
   4209f:	89 c2                	mov    %eax,%edx
   420a1:	0f b6 05 3b f3 00 00 	movzbl 0xf33b(%rip),%eax        # 513e3 <modifiers.1>
   420a8:	09 d0                	or     %edx,%eax
   420aa:	88 05 33 f3 00 00    	mov    %al,0xf333(%rip)        # 513e3 <modifiers.1>
        ch = 0;
   420b0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   420b7:	eb 58                	jmp    42111 <keyboard_readc+0x214>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   420b9:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   420bd:	7e 31                	jle    420f0 <keyboard_readc+0x1f3>
   420bf:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   420c6:	7f 28                	jg     420f0 <keyboard_readc+0x1f3>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   420c8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   420cb:	8d 50 80             	lea    -0x80(%rax),%edx
   420ce:	0f b6 05 0e f3 00 00 	movzbl 0xf30e(%rip),%eax        # 513e3 <modifiers.1>
   420d5:	0f b6 c0             	movzbl %al,%eax
   420d8:	83 e0 03             	and    $0x3,%eax
   420db:	48 98                	cltq   
   420dd:	48 63 d2             	movslq %edx,%rdx
   420e0:	0f b6 84 90 a0 51 04 	movzbl 0x451a0(%rax,%rdx,4),%eax
   420e7:	00 
   420e8:	0f b6 c0             	movzbl %al,%eax
   420eb:	89 45 fc             	mov    %eax,-0x4(%rbp)
   420ee:	eb 21                	jmp    42111 <keyboard_readc+0x214>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   420f0:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   420f4:	7f 1b                	jg     42111 <keyboard_readc+0x214>
   420f6:	0f b6 05 e6 f2 00 00 	movzbl 0xf2e6(%rip),%eax        # 513e3 <modifiers.1>
   420fd:	0f b6 c0             	movzbl %al,%eax
   42100:	83 e0 02             	and    $0x2,%eax
   42103:	85 c0                	test   %eax,%eax
   42105:	74 0a                	je     42111 <keyboard_readc+0x214>
        ch = 0;
   42107:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4210e:	eb 01                	jmp    42111 <keyboard_readc+0x214>
        if (modifiers & MOD_CONTROL) {
   42110:	90                   	nop
    }

    return ch;
   42111:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   42114:	c9                   	leave  
   42115:	c3                   	ret    

0000000000042116 <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   42116:	55                   	push   %rbp
   42117:	48 89 e5             	mov    %rsp,%rbp
   4211a:	48 83 ec 20          	sub    $0x20,%rsp
   4211e:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42125:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   42128:	89 c2                	mov    %eax,%edx
   4212a:	ec                   	in     (%dx),%al
   4212b:	88 45 e3             	mov    %al,-0x1d(%rbp)
   4212e:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   42135:	8b 45 ec             	mov    -0x14(%rbp),%eax
   42138:	89 c2                	mov    %eax,%edx
   4213a:	ec                   	in     (%dx),%al
   4213b:	88 45 eb             	mov    %al,-0x15(%rbp)
   4213e:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   42145:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42148:	89 c2                	mov    %eax,%edx
   4214a:	ec                   	in     (%dx),%al
   4214b:	88 45 f3             	mov    %al,-0xd(%rbp)
   4214e:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   42155:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42158:	89 c2                	mov    %eax,%edx
   4215a:	ec                   	in     (%dx),%al
   4215b:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   4215e:	90                   	nop
   4215f:	c9                   	leave  
   42160:	c3                   	ret    

0000000000042161 <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   42161:	55                   	push   %rbp
   42162:	48 89 e5             	mov    %rsp,%rbp
   42165:	48 83 ec 40          	sub    $0x40,%rsp
   42169:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   4216d:	89 f0                	mov    %esi,%eax
   4216f:	89 55 c0             	mov    %edx,-0x40(%rbp)
   42172:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   42175:	8b 05 69 f2 00 00    	mov    0xf269(%rip),%eax        # 513e4 <initialized.0>
   4217b:	85 c0                	test   %eax,%eax
   4217d:	75 1e                	jne    4219d <parallel_port_putc+0x3c>
   4217f:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   42186:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4218a:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   4218e:	8b 55 f8             	mov    -0x8(%rbp),%edx
   42191:	ee                   	out    %al,(%dx)
}
   42192:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   42193:	c7 05 47 f2 00 00 01 	movl   $0x1,0xf247(%rip)        # 513e4 <initialized.0>
   4219a:	00 00 00 
    }

    for (int i = 0;
   4219d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   421a4:	eb 09                	jmp    421af <parallel_port_putc+0x4e>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   421a6:	e8 6b ff ff ff       	call   42116 <delay>
         ++i) {
   421ab:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   421af:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   421b6:	7f 18                	jg     421d0 <parallel_port_putc+0x6f>
   421b8:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   421bf:	8b 45 f0             	mov    -0x10(%rbp),%eax
   421c2:	89 c2                	mov    %eax,%edx
   421c4:	ec                   	in     (%dx),%al
   421c5:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   421c8:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   421cc:	84 c0                	test   %al,%al
   421ce:	79 d6                	jns    421a6 <parallel_port_putc+0x45>
    }
    outb(IO_PARALLEL1_DATA, c);
   421d0:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   421d4:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   421db:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421de:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   421e2:	8b 55 d8             	mov    -0x28(%rbp),%edx
   421e5:	ee                   	out    %al,(%dx)
}
   421e6:	90                   	nop
   421e7:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   421ee:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421f2:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   421f6:	8b 55 e0             	mov    -0x20(%rbp),%edx
   421f9:	ee                   	out    %al,(%dx)
}
   421fa:	90                   	nop
   421fb:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   42202:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42206:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   4220a:	8b 55 e8             	mov    -0x18(%rbp),%edx
   4220d:	ee                   	out    %al,(%dx)
}
   4220e:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   4220f:	90                   	nop
   42210:	c9                   	leave  
   42211:	c3                   	ret    

0000000000042212 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   42212:	55                   	push   %rbp
   42213:	48 89 e5             	mov    %rsp,%rbp
   42216:	48 83 ec 20          	sub    $0x20,%rsp
   4221a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4221e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   42222:	48 c7 45 f8 61 21 04 	movq   $0x42161,-0x8(%rbp)
   42229:	00 
    printer_vprintf(&p, 0, format, val);
   4222a:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   4222e:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   42232:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   42236:	be 00 00 00 00       	mov    $0x0,%esi
   4223b:	48 89 c7             	mov    %rax,%rdi
   4223e:	e8 00 1d 00 00       	call   43f43 <printer_vprintf>
}
   42243:	90                   	nop
   42244:	c9                   	leave  
   42245:	c3                   	ret    

0000000000042246 <log_printf>:

void log_printf(const char* format, ...) {
   42246:	55                   	push   %rbp
   42247:	48 89 e5             	mov    %rsp,%rbp
   4224a:	48 83 ec 60          	sub    $0x60,%rsp
   4224e:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42252:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42256:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   4225a:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4225e:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42262:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42266:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   4226d:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42271:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42275:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42279:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   4227d:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   42281:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42285:	48 89 d6             	mov    %rdx,%rsi
   42288:	48 89 c7             	mov    %rax,%rdi
   4228b:	e8 82 ff ff ff       	call   42212 <log_vprintf>
    va_end(val);
}
   42290:	90                   	nop
   42291:	c9                   	leave  
   42292:	c3                   	ret    

0000000000042293 <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   42293:	55                   	push   %rbp
   42294:	48 89 e5             	mov    %rsp,%rbp
   42297:	48 83 ec 40          	sub    $0x40,%rsp
   4229b:	89 7d dc             	mov    %edi,-0x24(%rbp)
   4229e:	89 75 d8             	mov    %esi,-0x28(%rbp)
   422a1:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   422a5:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   422a9:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   422ad:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   422b1:	48 8b 0a             	mov    (%rdx),%rcx
   422b4:	48 89 08             	mov    %rcx,(%rax)
   422b7:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   422bb:	48 89 48 08          	mov    %rcx,0x8(%rax)
   422bf:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   422c3:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   422c7:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   422cb:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   422cf:	48 89 d6             	mov    %rdx,%rsi
   422d2:	48 89 c7             	mov    %rax,%rdi
   422d5:	e8 38 ff ff ff       	call   42212 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   422da:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   422de:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   422e2:	8b 75 d8             	mov    -0x28(%rbp),%esi
   422e5:	8b 45 dc             	mov    -0x24(%rbp),%eax
   422e8:	89 c7                	mov    %eax,%edi
   422ea:	e8 03 27 00 00       	call   449f2 <console_vprintf>
}
   422ef:	c9                   	leave  
   422f0:	c3                   	ret    

00000000000422f1 <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   422f1:	55                   	push   %rbp
   422f2:	48 89 e5             	mov    %rsp,%rbp
   422f5:	48 83 ec 60          	sub    $0x60,%rsp
   422f9:	89 7d ac             	mov    %edi,-0x54(%rbp)
   422fc:	89 75 a8             	mov    %esi,-0x58(%rbp)
   422ff:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   42303:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42307:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4230b:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   4230f:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   42316:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4231a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   4231e:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42322:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   42326:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   4232a:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   4232e:	8b 75 a8             	mov    -0x58(%rbp),%esi
   42331:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42334:	89 c7                	mov    %eax,%edi
   42336:	e8 58 ff ff ff       	call   42293 <error_vprintf>
   4233b:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   4233e:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   42341:	c9                   	leave  
   42342:	c3                   	ret    

0000000000042343 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'm', and 'c' cause a soft
//    reboot where the kernel runs the allocator programs, "malloc", or
//    "alloctests", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   42343:	55                   	push   %rbp
   42344:	48 89 e5             	mov    %rsp,%rbp
   42347:	53                   	push   %rbx
   42348:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   4234c:	e8 ac fb ff ff       	call   41efd <keyboard_readc>
   42351:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'm' || c == 'c' || c == 't'|| c =='2') {
   42354:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42358:	74 1c                	je     42376 <check_keyboard+0x33>
   4235a:	83 7d e4 6d          	cmpl   $0x6d,-0x1c(%rbp)
   4235e:	74 16                	je     42376 <check_keyboard+0x33>
   42360:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   42364:	74 10                	je     42376 <check_keyboard+0x33>
   42366:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   4236a:	74 0a                	je     42376 <check_keyboard+0x33>
   4236c:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42370:	0f 85 e9 00 00 00    	jne    4245f <check_keyboard+0x11c>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   42376:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   4237d:	00 
        memset(pt, 0, PAGESIZE * 3);
   4237e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42382:	ba 00 30 00 00       	mov    $0x3000,%edx
   42387:	be 00 00 00 00       	mov    $0x0,%esi
   4238c:	48 89 c7             	mov    %rax,%rdi
   4238f:	e8 13 19 00 00       	call   43ca7 <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   42394:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42398:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   4239f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   423a3:	48 05 00 10 00 00    	add    $0x1000,%rax
   423a9:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   423b0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   423b4:	48 05 00 20 00 00    	add    $0x2000,%rax
   423ba:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   423c1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   423c5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   423c9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   423cd:	0f 22 d8             	mov    %rax,%cr3
}
   423d0:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   423d1:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "malloc";
   423d8:	48 c7 45 e8 f8 51 04 	movq   $0x451f8,-0x18(%rbp)
   423df:	00 
        if (c == 'a') {
   423e0:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   423e4:	75 0a                	jne    423f0 <check_keyboard+0xad>
            argument = "allocator";
   423e6:	48 c7 45 e8 ff 51 04 	movq   $0x451ff,-0x18(%rbp)
   423ed:	00 
   423ee:	eb 2e                	jmp    4241e <check_keyboard+0xdb>
        } else if (c == 'c') {
   423f0:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   423f4:	75 0a                	jne    42400 <check_keyboard+0xbd>
            argument = "alloctests";
   423f6:	48 c7 45 e8 09 52 04 	movq   $0x45209,-0x18(%rbp)
   423fd:	00 
   423fe:	eb 1e                	jmp    4241e <check_keyboard+0xdb>
        } else if(c == 't'){
   42400:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42404:	75 0a                	jne    42410 <check_keyboard+0xcd>
            argument = "test";
   42406:	48 c7 45 e8 14 52 04 	movq   $0x45214,-0x18(%rbp)
   4240d:	00 
   4240e:	eb 0e                	jmp    4241e <check_keyboard+0xdb>
        }
        else if(c == '2'){
   42410:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42414:	75 08                	jne    4241e <check_keyboard+0xdb>
            argument = "test2";
   42416:	48 c7 45 e8 19 52 04 	movq   $0x45219,-0x18(%rbp)
   4241d:	00 
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   4241e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42422:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   42426:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4242b:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   4242f:	73 14                	jae    42445 <check_keyboard+0x102>
   42431:	ba 1f 52 04 00       	mov    $0x4521f,%edx
   42436:	be 5c 02 00 00       	mov    $0x25c,%esi
   4243b:	bf 3b 52 04 00       	mov    $0x4523b,%edi
   42440:	e8 1f 01 00 00       	call   42564 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   42445:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42449:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   4244c:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   42450:	48 89 c3             	mov    %rax,%rbx
   42453:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   42458:	e9 a3 db ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'm' || c == 'c' || c == 't'|| c =='2') {
   4245d:	eb 11                	jmp    42470 <check_keyboard+0x12d>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   4245f:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   42463:	74 06                	je     4246b <check_keyboard+0x128>
   42465:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   42469:	75 05                	jne    42470 <check_keyboard+0x12d>
        poweroff();
   4246b:	e8 9d f8 ff ff       	call   41d0d <poweroff>
    }
    return c;
   42470:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   42473:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42477:	c9                   	leave  
   42478:	c3                   	ret    

0000000000042479 <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   42479:	55                   	push   %rbp
   4247a:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   4247d:	e8 c1 fe ff ff       	call   42343 <check_keyboard>
   42482:	eb f9                	jmp    4247d <fail+0x4>

0000000000042484 <kernel_panic>:

// kernel_panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void kernel_panic(const char* format, ...) {
   42484:	55                   	push   %rbp
   42485:	48 89 e5             	mov    %rsp,%rbp
   42488:	48 83 ec 60          	sub    $0x60,%rsp
   4248c:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42490:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42494:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42498:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4249c:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   424a0:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   424a4:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   424ab:	48 8d 45 10          	lea    0x10(%rbp),%rax
   424af:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   424b3:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   424b7:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   424bb:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   424c0:	0f 84 80 00 00 00    	je     42546 <kernel_panic+0xc2>
        // Print kernel_panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   424c6:	ba 4f 52 04 00       	mov    $0x4524f,%edx
   424cb:	be 00 c0 00 00       	mov    $0xc000,%esi
   424d0:	bf 30 07 00 00       	mov    $0x730,%edi
   424d5:	b8 00 00 00 00       	mov    $0x0,%eax
   424da:	e8 12 fe ff ff       	call   422f1 <error_printf>
   424df:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   424e2:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   424e6:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   424ea:	8b 45 cc             	mov    -0x34(%rbp),%eax
   424ed:	be 00 c0 00 00       	mov    $0xc000,%esi
   424f2:	89 c7                	mov    %eax,%edi
   424f4:	e8 9a fd ff ff       	call   42293 <error_vprintf>
   424f9:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   424fc:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   424ff:	48 63 c1             	movslq %ecx,%rax
   42502:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   42509:	48 c1 e8 20          	shr    $0x20,%rax
   4250d:	89 c2                	mov    %eax,%edx
   4250f:	c1 fa 05             	sar    $0x5,%edx
   42512:	89 c8                	mov    %ecx,%eax
   42514:	c1 f8 1f             	sar    $0x1f,%eax
   42517:	29 c2                	sub    %eax,%edx
   42519:	89 d0                	mov    %edx,%eax
   4251b:	c1 e0 02             	shl    $0x2,%eax
   4251e:	01 d0                	add    %edx,%eax
   42520:	c1 e0 04             	shl    $0x4,%eax
   42523:	29 c1                	sub    %eax,%ecx
   42525:	89 ca                	mov    %ecx,%edx
   42527:	85 d2                	test   %edx,%edx
   42529:	74 34                	je     4255f <kernel_panic+0xdb>
            error_printf(cpos, 0xC000, "\n");
   4252b:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4252e:	ba 57 52 04 00       	mov    $0x45257,%edx
   42533:	be 00 c0 00 00       	mov    $0xc000,%esi
   42538:	89 c7                	mov    %eax,%edi
   4253a:	b8 00 00 00 00       	mov    $0x0,%eax
   4253f:	e8 ad fd ff ff       	call   422f1 <error_printf>
   42544:	eb 19                	jmp    4255f <kernel_panic+0xdb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   42546:	ba 59 52 04 00       	mov    $0x45259,%edx
   4254b:	be 00 c0 00 00       	mov    $0xc000,%esi
   42550:	bf 30 07 00 00       	mov    $0x730,%edi
   42555:	b8 00 00 00 00       	mov    $0x0,%eax
   4255a:	e8 92 fd ff ff       	call   422f1 <error_printf>
    }

    va_end(val);
    fail();
   4255f:	e8 15 ff ff ff       	call   42479 <fail>

0000000000042564 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   42564:	55                   	push   %rbp
   42565:	48 89 e5             	mov    %rsp,%rbp
   42568:	48 83 ec 20          	sub    $0x20,%rsp
   4256c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42570:	89 75 f4             	mov    %esi,-0xc(%rbp)
   42573:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    kernel_panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   42577:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   4257b:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4257e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42582:	48 89 c6             	mov    %rax,%rsi
   42585:	bf 5f 52 04 00       	mov    $0x4525f,%edi
   4258a:	b8 00 00 00 00       	mov    $0x0,%eax
   4258f:	e8 f0 fe ff ff       	call   42484 <kernel_panic>

0000000000042594 <default_exception>:
}

void default_exception(proc* p){
   42594:	55                   	push   %rbp
   42595:	48 89 e5             	mov    %rsp,%rbp
   42598:	48 83 ec 20          	sub    $0x20,%rsp
   4259c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   425a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   425a4:	48 83 c0 18          	add    $0x18,%rax
   425a8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    kernel_panic("Unexpected exception %d!\n", reg->reg_intno);
   425ac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   425b0:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   425b7:	48 89 c6             	mov    %rax,%rsi
   425ba:	bf 7d 52 04 00       	mov    $0x4527d,%edi
   425bf:	b8 00 00 00 00       	mov    $0x0,%eax
   425c4:	e8 bb fe ff ff       	call   42484 <kernel_panic>

00000000000425c9 <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   425c9:	55                   	push   %rbp
   425ca:	48 89 e5             	mov    %rsp,%rbp
   425cd:	48 83 ec 10          	sub    $0x10,%rsp
   425d1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   425d5:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   425d8:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   425dc:	78 06                	js     425e4 <pageindex+0x1b>
   425de:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   425e2:	7e 14                	jle    425f8 <pageindex+0x2f>
   425e4:	ba 98 52 04 00       	mov    $0x45298,%edx
   425e9:	be 1e 00 00 00       	mov    $0x1e,%esi
   425ee:	bf b1 52 04 00       	mov    $0x452b1,%edi
   425f3:	e8 6c ff ff ff       	call   42564 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   425f8:	b8 03 00 00 00       	mov    $0x3,%eax
   425fd:	2b 45 f4             	sub    -0xc(%rbp),%eax
   42600:	89 c2                	mov    %eax,%edx
   42602:	89 d0                	mov    %edx,%eax
   42604:	c1 e0 03             	shl    $0x3,%eax
   42607:	01 d0                	add    %edx,%eax
   42609:	83 c0 0c             	add    $0xc,%eax
   4260c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42610:	89 c1                	mov    %eax,%ecx
   42612:	48 d3 ea             	shr    %cl,%rdx
   42615:	48 89 d0             	mov    %rdx,%rax
   42618:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   4261d:	c9                   	leave  
   4261e:	c3                   	ret    

000000000004261f <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   4261f:	55                   	push   %rbp
   42620:	48 89 e5             	mov    %rsp,%rbp
   42623:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   42627:	48 c7 05 ce f9 00 00 	movq   $0x53000,0xf9ce(%rip)        # 52000 <kernel_pagetable>
   4262e:	00 30 05 00 
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   42632:	ba 00 50 00 00       	mov    $0x5000,%edx
   42637:	be 00 00 00 00       	mov    $0x0,%esi
   4263c:	bf 00 30 05 00       	mov    $0x53000,%edi
   42641:	e8 61 16 00 00       	call   43ca7 <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   42646:	b8 00 40 05 00       	mov    $0x54000,%eax
   4264b:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   4264f:	48 89 05 aa 09 01 00 	mov    %rax,0x109aa(%rip)        # 53000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   42656:	b8 00 50 05 00       	mov    $0x55000,%eax
   4265b:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   4265f:	48 89 05 9a 19 01 00 	mov    %rax,0x1199a(%rip)        # 54000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   42666:	b8 00 60 05 00       	mov    $0x56000,%eax
   4266b:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   4266f:	48 89 05 8a 29 01 00 	mov    %rax,0x1298a(%rip)        # 55000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   42676:	b8 00 70 05 00       	mov    $0x57000,%eax
   4267b:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   4267f:	48 89 05 82 29 01 00 	mov    %rax,0x12982(%rip)        # 55008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   42686:	48 8b 05 73 f9 00 00 	mov    0xf973(%rip),%rax        # 52000 <kernel_pagetable>
   4268d:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42693:	b9 00 00 20 00       	mov    $0x200000,%ecx
   42698:	ba 00 00 00 00       	mov    $0x0,%edx
   4269d:	be 00 00 00 00       	mov    $0x0,%esi
   426a2:	48 89 c7             	mov    %rax,%rdi
   426a5:	e8 b9 01 00 00       	call   42863 <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   426aa:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   426b1:	00 
   426b2:	eb 62                	jmp    42716 <virtual_memory_init+0xf7>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   426b4:	48 8b 0d 45 f9 00 00 	mov    0xf945(%rip),%rcx        # 52000 <kernel_pagetable>
   426bb:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   426bf:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   426c3:	48 89 ce             	mov    %rcx,%rsi
   426c6:	48 89 c7             	mov    %rax,%rdi
   426c9:	e8 58 05 00 00       	call   42c26 <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l4pagetable ?
        assert(vmap.pa == addr);
   426ce:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   426d2:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   426d6:	74 14                	je     426ec <virtual_memory_init+0xcd>
   426d8:	ba c5 52 04 00       	mov    $0x452c5,%edx
   426dd:	be 2d 00 00 00       	mov    $0x2d,%esi
   426e2:	bf d5 52 04 00       	mov    $0x452d5,%edi
   426e7:	e8 78 fe ff ff       	call   42564 <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   426ec:	8b 45 f0             	mov    -0x10(%rbp),%eax
   426ef:	48 98                	cltq   
   426f1:	83 e0 03             	and    $0x3,%eax
   426f4:	48 83 f8 03          	cmp    $0x3,%rax
   426f8:	74 14                	je     4270e <virtual_memory_init+0xef>
   426fa:	ba e8 52 04 00       	mov    $0x452e8,%edx
   426ff:	be 2e 00 00 00       	mov    $0x2e,%esi
   42704:	bf d5 52 04 00       	mov    $0x452d5,%edi
   42709:	e8 56 fe ff ff       	call   42564 <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   4270e:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42715:	00 
   42716:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   4271d:	00 
   4271e:	76 94                	jbe    426b4 <virtual_memory_init+0x95>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   42720:	48 8b 05 d9 f8 00 00 	mov    0xf8d9(%rip),%rax        # 52000 <kernel_pagetable>
   42727:	48 89 c7             	mov    %rax,%rdi
   4272a:	e8 03 00 00 00       	call   42732 <set_pagetable>
}
   4272f:	90                   	nop
   42730:	c9                   	leave  
   42731:	c3                   	ret    

0000000000042732 <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls kernel_panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   42732:	55                   	push   %rbp
   42733:	48 89 e5             	mov    %rsp,%rbp
   42736:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   4273a:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   4273e:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42742:	25 ff 0f 00 00       	and    $0xfff,%eax
   42747:	48 85 c0             	test   %rax,%rax
   4274a:	74 14                	je     42760 <set_pagetable+0x2e>
   4274c:	ba 15 53 04 00       	mov    $0x45315,%edx
   42751:	be 3d 00 00 00       	mov    $0x3d,%esi
   42756:	bf d5 52 04 00       	mov    $0x452d5,%edi
   4275b:	e8 04 fe ff ff       	call   42564 <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   42760:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42765:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   42769:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   4276d:	48 89 ce             	mov    %rcx,%rsi
   42770:	48 89 c7             	mov    %rax,%rdi
   42773:	e8 ae 04 00 00       	call   42c26 <virtual_memory_lookup>
   42778:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   4277c:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42781:	48 39 d0             	cmp    %rdx,%rax
   42784:	74 14                	je     4279a <set_pagetable+0x68>
   42786:	ba 30 53 04 00       	mov    $0x45330,%edx
   4278b:	be 3f 00 00 00       	mov    $0x3f,%esi
   42790:	bf d5 52 04 00       	mov    $0x452d5,%edi
   42795:	e8 ca fd ff ff       	call   42564 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   4279a:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   4279e:	48 8b 0d 5b f8 00 00 	mov    0xf85b(%rip),%rcx        # 52000 <kernel_pagetable>
   427a5:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   427a9:	48 89 ce             	mov    %rcx,%rsi
   427ac:	48 89 c7             	mov    %rax,%rdi
   427af:	e8 72 04 00 00       	call   42c26 <virtual_memory_lookup>
   427b4:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   427b8:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   427bc:	48 39 c2             	cmp    %rax,%rdx
   427bf:	74 14                	je     427d5 <set_pagetable+0xa3>
   427c1:	ba 98 53 04 00       	mov    $0x45398,%edx
   427c6:	be 41 00 00 00       	mov    $0x41,%esi
   427cb:	bf d5 52 04 00       	mov    $0x452d5,%edi
   427d0:	e8 8f fd ff ff       	call   42564 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   427d5:	48 8b 05 24 f8 00 00 	mov    0xf824(%rip),%rax        # 52000 <kernel_pagetable>
   427dc:	48 89 c2             	mov    %rax,%rdx
   427df:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   427e3:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   427e7:	48 89 ce             	mov    %rcx,%rsi
   427ea:	48 89 c7             	mov    %rax,%rdi
   427ed:	e8 34 04 00 00       	call   42c26 <virtual_memory_lookup>
   427f2:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   427f6:	48 8b 15 03 f8 00 00 	mov    0xf803(%rip),%rdx        # 52000 <kernel_pagetable>
   427fd:	48 39 d0             	cmp    %rdx,%rax
   42800:	74 14                	je     42816 <set_pagetable+0xe4>
   42802:	ba f8 53 04 00       	mov    $0x453f8,%edx
   42807:	be 43 00 00 00       	mov    $0x43,%esi
   4280c:	bf d5 52 04 00       	mov    $0x452d5,%edi
   42811:	e8 4e fd ff ff       	call   42564 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   42816:	ba 63 28 04 00       	mov    $0x42863,%edx
   4281b:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   4281f:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42823:	48 89 ce             	mov    %rcx,%rsi
   42826:	48 89 c7             	mov    %rax,%rdi
   42829:	e8 f8 03 00 00       	call   42c26 <virtual_memory_lookup>
   4282e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42832:	ba 63 28 04 00       	mov    $0x42863,%edx
   42837:	48 39 d0             	cmp    %rdx,%rax
   4283a:	74 14                	je     42850 <set_pagetable+0x11e>
   4283c:	ba 60 54 04 00       	mov    $0x45460,%edx
   42841:	be 45 00 00 00       	mov    $0x45,%esi
   42846:	bf d5 52 04 00       	mov    $0x452d5,%edi
   4284b:	e8 14 fd ff ff       	call   42564 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   42850:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42854:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42858:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4285c:	0f 22 d8             	mov    %rax,%cr3
}
   4285f:	90                   	nop
}
   42860:	90                   	nop
   42861:	c9                   	leave  
   42862:	c3                   	ret    

0000000000042863 <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   42863:	55                   	push   %rbp
   42864:	48 89 e5             	mov    %rsp,%rbp
   42867:	53                   	push   %rbx
   42868:	48 83 ec 58          	sub    $0x58,%rsp
   4286c:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42870:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42874:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   42878:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
   4287c:	44 89 45 ac          	mov    %r8d,-0x54(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   42880:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42884:	25 ff 0f 00 00       	and    $0xfff,%eax
   42889:	48 85 c0             	test   %rax,%rax
   4288c:	74 14                	je     428a2 <virtual_memory_map+0x3f>
   4288e:	ba c6 54 04 00       	mov    $0x454c6,%edx
   42893:	be 66 00 00 00       	mov    $0x66,%esi
   42898:	bf d5 52 04 00       	mov    $0x452d5,%edi
   4289d:	e8 c2 fc ff ff       	call   42564 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   428a2:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   428a6:	25 ff 0f 00 00       	and    $0xfff,%eax
   428ab:	48 85 c0             	test   %rax,%rax
   428ae:	74 14                	je     428c4 <virtual_memory_map+0x61>
   428b0:	ba d9 54 04 00       	mov    $0x454d9,%edx
   428b5:	be 67 00 00 00       	mov    $0x67,%esi
   428ba:	bf d5 52 04 00       	mov    $0x452d5,%edi
   428bf:	e8 a0 fc ff ff       	call   42564 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   428c4:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   428c8:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   428cc:	48 01 d0             	add    %rdx,%rax
   428cf:	48 3b 45 c0          	cmp    -0x40(%rbp),%rax
   428d3:	73 24                	jae    428f9 <virtual_memory_map+0x96>
   428d5:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   428d9:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   428dd:	48 01 d0             	add    %rdx,%rax
   428e0:	48 85 c0             	test   %rax,%rax
   428e3:	74 14                	je     428f9 <virtual_memory_map+0x96>
   428e5:	ba ec 54 04 00       	mov    $0x454ec,%edx
   428ea:	be 68 00 00 00       	mov    $0x68,%esi
   428ef:	bf d5 52 04 00       	mov    $0x452d5,%edi
   428f4:	e8 6b fc ff ff       	call   42564 <assert_fail>
    if (perm & PTE_P) {
   428f9:	8b 45 ac             	mov    -0x54(%rbp),%eax
   428fc:	48 98                	cltq   
   428fe:	83 e0 01             	and    $0x1,%eax
   42901:	48 85 c0             	test   %rax,%rax
   42904:	74 6e                	je     42974 <virtual_memory_map+0x111>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   42906:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4290a:	25 ff 0f 00 00       	and    $0xfff,%eax
   4290f:	48 85 c0             	test   %rax,%rax
   42912:	74 14                	je     42928 <virtual_memory_map+0xc5>
   42914:	ba 0a 55 04 00       	mov    $0x4550a,%edx
   42919:	be 6a 00 00 00       	mov    $0x6a,%esi
   4291e:	bf d5 52 04 00       	mov    $0x452d5,%edi
   42923:	e8 3c fc ff ff       	call   42564 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   42928:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   4292c:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42930:	48 01 d0             	add    %rdx,%rax
   42933:	48 3b 45 b8          	cmp    -0x48(%rbp),%rax
   42937:	73 14                	jae    4294d <virtual_memory_map+0xea>
   42939:	ba 1d 55 04 00       	mov    $0x4551d,%edx
   4293e:	be 6b 00 00 00       	mov    $0x6b,%esi
   42943:	bf d5 52 04 00       	mov    $0x452d5,%edi
   42948:	e8 17 fc ff ff       	call   42564 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   4294d:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42951:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42955:	48 01 d0             	add    %rdx,%rax
   42958:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   4295e:	76 14                	jbe    42974 <virtual_memory_map+0x111>
   42960:	ba 2b 55 04 00       	mov    $0x4552b,%edx
   42965:	be 6c 00 00 00       	mov    $0x6c,%esi
   4296a:	bf d5 52 04 00       	mov    $0x452d5,%edi
   4296f:	e8 f0 fb ff ff       	call   42564 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   42974:	83 7d ac 00          	cmpl   $0x0,-0x54(%rbp)
   42978:	78 09                	js     42983 <virtual_memory_map+0x120>
   4297a:	81 7d ac ff 0f 00 00 	cmpl   $0xfff,-0x54(%rbp)
   42981:	7e 14                	jle    42997 <virtual_memory_map+0x134>
   42983:	ba 47 55 04 00       	mov    $0x45547,%edx
   42988:	be 6e 00 00 00       	mov    $0x6e,%esi
   4298d:	bf d5 52 04 00       	mov    $0x452d5,%edi
   42992:	e8 cd fb ff ff       	call   42564 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   42997:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4299b:	25 ff 0f 00 00       	and    $0xfff,%eax
   429a0:	48 85 c0             	test   %rax,%rax
   429a3:	74 14                	je     429b9 <virtual_memory_map+0x156>
   429a5:	ba 68 55 04 00       	mov    $0x45568,%edx
   429aa:	be 6f 00 00 00       	mov    $0x6f,%esi
   429af:	bf d5 52 04 00       	mov    $0x452d5,%edi
   429b4:	e8 ab fb ff ff       	call   42564 <assert_fail>

    int last_index123 = -1;
   429b9:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%rbp)
    x86_64_pagetable* l4pagetable = NULL;
   429c0:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
   429c7:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   429c8:	e9 e1 00 00 00       	jmp    42aae <virtual_memory_map+0x24b>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   429cd:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   429d1:	48 c1 e8 15          	shr    $0x15,%rax
   429d5:	89 45 dc             	mov    %eax,-0x24(%rbp)
        if (cur_index123 != last_index123) {
   429d8:	8b 45 dc             	mov    -0x24(%rbp),%eax
   429db:	3b 45 ec             	cmp    -0x14(%rbp),%eax
   429de:	74 20                	je     42a00 <virtual_memory_map+0x19d>
            // find pointer to last level pagetable for current va
            l4pagetable = lookup_l4pagetable(pagetable, va, perm);
   429e0:	8b 55 ac             	mov    -0x54(%rbp),%edx
   429e3:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   429e7:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   429eb:	48 89 ce             	mov    %rcx,%rsi
   429ee:	48 89 c7             	mov    %rax,%rdi
   429f1:	e8 ce 00 00 00       	call   42ac4 <lookup_l4pagetable>
   429f6:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            last_index123 = cur_index123;
   429fa:	8b 45 dc             	mov    -0x24(%rbp),%eax
   429fd:	89 45 ec             	mov    %eax,-0x14(%rbp)
        }
        if ((perm & PTE_P) && l4pagetable) { // if page is marked present
   42a00:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42a03:	48 98                	cltq   
   42a05:	83 e0 01             	and    $0x1,%eax
   42a08:	48 85 c0             	test   %rax,%rax
   42a0b:	74 34                	je     42a41 <virtual_memory_map+0x1de>
   42a0d:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42a12:	74 2d                	je     42a41 <virtual_memory_map+0x1de>
            // set page table entry to pa and perm
            l4pagetable->entry[L4PAGEINDEX(va)] = pa | perm;
   42a14:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42a17:	48 63 d8             	movslq %eax,%rbx
   42a1a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42a1e:	be 03 00 00 00       	mov    $0x3,%esi
   42a23:	48 89 c7             	mov    %rax,%rdi
   42a26:	e8 9e fb ff ff       	call   425c9 <pageindex>
   42a2b:	89 c2                	mov    %eax,%edx
   42a2d:	48 0b 5d b8          	or     -0x48(%rbp),%rbx
   42a31:	48 89 d9             	mov    %rbx,%rcx
   42a34:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42a38:	48 63 d2             	movslq %edx,%rdx
   42a3b:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42a3f:	eb 55                	jmp    42a96 <virtual_memory_map+0x233>
        } else if (l4pagetable) { // if page is NOT marked present
   42a41:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42a46:	74 26                	je     42a6e <virtual_memory_map+0x20b>
            // set page table entry to just perm
            l4pagetable->entry[L4PAGEINDEX(va)] = perm;
   42a48:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42a4c:	be 03 00 00 00       	mov    $0x3,%esi
   42a51:	48 89 c7             	mov    %rax,%rdi
   42a54:	e8 70 fb ff ff       	call   425c9 <pageindex>
   42a59:	89 c2                	mov    %eax,%edx
   42a5b:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42a5e:	48 63 c8             	movslq %eax,%rcx
   42a61:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42a65:	48 63 d2             	movslq %edx,%rdx
   42a68:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42a6c:	eb 28                	jmp    42a96 <virtual_memory_map+0x233>
        } else if (perm & PTE_P) {
   42a6e:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42a71:	48 98                	cltq   
   42a73:	83 e0 01             	and    $0x1,%eax
   42a76:	48 85 c0             	test   %rax,%rax
   42a79:	74 1b                	je     42a96 <virtual_memory_map+0x233>
            // error, no allocated l4 page found for va
            log_printf("[Kern Info] failed to find l4pagetable address at " __FILE__ ": %d\n", __LINE__);
   42a7b:	be 84 00 00 00       	mov    $0x84,%esi
   42a80:	bf 90 55 04 00       	mov    $0x45590,%edi
   42a85:	b8 00 00 00 00       	mov    $0x0,%eax
   42a8a:	e8 b7 f7 ff ff       	call   42246 <log_printf>
            return -1;
   42a8f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42a94:	eb 28                	jmp    42abe <virtual_memory_map+0x25b>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42a96:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
   42a9d:	00 
   42a9e:	48 81 45 b8 00 10 00 	addq   $0x1000,-0x48(%rbp)
   42aa5:	00 
   42aa6:	48 81 6d b0 00 10 00 	subq   $0x1000,-0x50(%rbp)
   42aad:	00 
   42aae:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   42ab3:	0f 85 14 ff ff ff    	jne    429cd <virtual_memory_map+0x16a>
        }
    }
    return 0;
   42ab9:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42abe:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42ac2:	c9                   	leave  
   42ac3:	c3                   	ret    

0000000000042ac4 <lookup_l4pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   42ac4:	55                   	push   %rbp
   42ac5:	48 89 e5             	mov    %rsp,%rbp
   42ac8:	48 83 ec 40          	sub    $0x40,%rsp
   42acc:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42ad0:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42ad4:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   42ad7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42adb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l4 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   42adf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   42ae6:	e9 2b 01 00 00       	jmp    42c16 <lookup_l4pagetable+0x152>
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        x86_64_pageentry_t pe = pt->entry[PAGEINDEX(va, i)];
   42aeb:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42aee:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42af2:	89 d6                	mov    %edx,%esi
   42af4:	48 89 c7             	mov    %rax,%rdi
   42af7:	e8 cd fa ff ff       	call   425c9 <pageindex>
   42afc:	89 c2                	mov    %eax,%edx
   42afe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42b02:	48 63 d2             	movslq %edx,%rdx
   42b05:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   42b09:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   42b0d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b11:	83 e0 01             	and    $0x1,%eax
   42b14:	48 85 c0             	test   %rax,%rax
   42b17:	75 63                	jne    42b7c <lookup_l4pagetable+0xb8>
            log_printf("[Kern Info] Error looking up l4pagetable: Pagetable address: 0x%x perm: 0x%x."
   42b19:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42b1c:	8d 48 02             	lea    0x2(%rax),%ecx
   42b1f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b23:	25 ff 0f 00 00       	and    $0xfff,%eax
   42b28:	48 89 c2             	mov    %rax,%rdx
   42b2b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b2f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42b35:	48 89 c6             	mov    %rax,%rsi
   42b38:	bf d8 55 04 00       	mov    $0x455d8,%edi
   42b3d:	b8 00 00 00 00       	mov    $0x0,%eax
   42b42:	e8 ff f6 ff ff       	call   42246 <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   42b47:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42b4a:	48 98                	cltq   
   42b4c:	83 e0 01             	and    $0x1,%eax
   42b4f:	48 85 c0             	test   %rax,%rax
   42b52:	75 0a                	jne    42b5e <lookup_l4pagetable+0x9a>
                return NULL;
   42b54:	b8 00 00 00 00       	mov    $0x0,%eax
   42b59:	e9 c6 00 00 00       	jmp    42c24 <lookup_l4pagetable+0x160>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   42b5e:	be a7 00 00 00       	mov    $0xa7,%esi
   42b63:	bf 40 56 04 00       	mov    $0x45640,%edi
   42b68:	b8 00 00 00 00       	mov    $0x0,%eax
   42b6d:	e8 d4 f6 ff ff       	call   42246 <log_printf>
            return NULL;
   42b72:	b8 00 00 00 00       	mov    $0x0,%eax
   42b77:	e9 a8 00 00 00       	jmp    42c24 <lookup_l4pagetable+0x160>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   42b7c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b80:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42b86:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   42b8c:	76 14                	jbe    42ba2 <lookup_l4pagetable+0xde>
   42b8e:	ba 88 56 04 00       	mov    $0x45688,%edx
   42b93:	be ac 00 00 00       	mov    $0xac,%esi
   42b98:	bf d5 52 04 00       	mov    $0x452d5,%edi
   42b9d:	e8 c2 f9 ff ff       	call   42564 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   42ba2:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42ba5:	48 98                	cltq   
   42ba7:	83 e0 02             	and    $0x2,%eax
   42baa:	48 85 c0             	test   %rax,%rax
   42bad:	74 20                	je     42bcf <lookup_l4pagetable+0x10b>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   42baf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42bb3:	83 e0 02             	and    $0x2,%eax
   42bb6:	48 85 c0             	test   %rax,%rax
   42bb9:	75 14                	jne    42bcf <lookup_l4pagetable+0x10b>
   42bbb:	ba a8 56 04 00       	mov    $0x456a8,%edx
   42bc0:	be ae 00 00 00       	mov    $0xae,%esi
   42bc5:	bf d5 52 04 00       	mov    $0x452d5,%edi
   42bca:	e8 95 f9 ff ff       	call   42564 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   42bcf:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42bd2:	48 98                	cltq   
   42bd4:	83 e0 04             	and    $0x4,%eax
   42bd7:	48 85 c0             	test   %rax,%rax
   42bda:	74 20                	je     42bfc <lookup_l4pagetable+0x138>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   42bdc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42be0:	83 e0 04             	and    $0x4,%eax
   42be3:	48 85 c0             	test   %rax,%rax
   42be6:	75 14                	jne    42bfc <lookup_l4pagetable+0x138>
   42be8:	ba b3 56 04 00       	mov    $0x456b3,%edx
   42bed:	be b1 00 00 00       	mov    $0xb1,%esi
   42bf2:	bf d5 52 04 00       	mov    $0x452d5,%edi
   42bf7:	e8 68 f9 ff ff       	call   42564 <assert_fail>
        }

        // set pt to physical address to next pagetable using `pe`
        pt = 0; // replace this
   42bfc:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42c03:	00 
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42c04:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c08:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42c0e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   42c12:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   42c16:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   42c1a:	0f 8e cb fe ff ff    	jle    42aeb <lookup_l4pagetable+0x27>
    }
    return pt;
   42c20:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   42c24:	c9                   	leave  
   42c25:	c3                   	ret    

0000000000042c26 <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   42c26:	55                   	push   %rbp
   42c27:	48 89 e5             	mov    %rsp,%rbp
   42c2a:	48 83 ec 50          	sub    $0x50,%rsp
   42c2e:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42c32:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42c36:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   42c3a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42c3e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   42c42:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   42c49:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42c4a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   42c51:	eb 41                	jmp    42c94 <virtual_memory_lookup+0x6e>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   42c53:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42c56:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42c5a:	89 d6                	mov    %edx,%esi
   42c5c:	48 89 c7             	mov    %rax,%rdi
   42c5f:	e8 65 f9 ff ff       	call   425c9 <pageindex>
   42c64:	89 c2                	mov    %eax,%edx
   42c66:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42c6a:	48 63 d2             	movslq %edx,%rdx
   42c6d:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   42c71:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c75:	83 e0 06             	and    $0x6,%eax
   42c78:	48 f7 d0             	not    %rax
   42c7b:	48 21 d0             	and    %rdx,%rax
   42c7e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42c82:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c86:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42c8c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42c90:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   42c94:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   42c98:	7f 0c                	jg     42ca6 <virtual_memory_lookup+0x80>
   42c9a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c9e:	83 e0 01             	and    $0x1,%eax
   42ca1:	48 85 c0             	test   %rax,%rax
   42ca4:	75 ad                	jne    42c53 <virtual_memory_lookup+0x2d>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   42ca6:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   42cad:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   42cb4:	ff 
   42cb5:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   42cbc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42cc0:	83 e0 01             	and    $0x1,%eax
   42cc3:	48 85 c0             	test   %rax,%rax
   42cc6:	74 34                	je     42cfc <virtual_memory_lookup+0xd6>
        vam.pn = PAGENUMBER(pe);
   42cc8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ccc:	48 c1 e8 0c          	shr    $0xc,%rax
   42cd0:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   42cd3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42cd7:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42cdd:	48 89 c2             	mov    %rax,%rdx
   42ce0:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42ce4:	25 ff 0f 00 00       	and    $0xfff,%eax
   42ce9:	48 09 d0             	or     %rdx,%rax
   42cec:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   42cf0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42cf4:	25 ff 0f 00 00       	and    $0xfff,%eax
   42cf9:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   42cfc:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42d00:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42d04:	48 89 10             	mov    %rdx,(%rax)
   42d07:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   42d0b:	48 89 50 08          	mov    %rdx,0x8(%rax)
   42d0f:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42d13:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   42d17:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42d1b:	c9                   	leave  
   42d1c:	c3                   	ret    

0000000000042d1d <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   42d1d:	55                   	push   %rbp
   42d1e:	48 89 e5             	mov    %rsp,%rbp
   42d21:	48 83 ec 40          	sub    $0x40,%rsp
   42d25:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42d29:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   42d2c:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   42d30:	c7 45 f8 04 00 00 00 	movl   $0x4,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   42d37:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   42d3b:	78 08                	js     42d45 <program_load+0x28>
   42d3d:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42d40:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   42d43:	7c 14                	jl     42d59 <program_load+0x3c>
   42d45:	ba c0 56 04 00       	mov    $0x456c0,%edx
   42d4a:	be 2e 00 00 00       	mov    $0x2e,%esi
   42d4f:	bf f0 56 04 00       	mov    $0x456f0,%edi
   42d54:	e8 0b f8 ff ff       	call   42564 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   42d59:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42d5c:	48 98                	cltq   
   42d5e:	48 c1 e0 04          	shl    $0x4,%rax
   42d62:	48 05 20 60 04 00    	add    $0x46020,%rax
   42d68:	48 8b 00             	mov    (%rax),%rax
   42d6b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   42d6f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d73:	8b 00                	mov    (%rax),%eax
   42d75:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   42d7a:	74 14                	je     42d90 <program_load+0x73>
   42d7c:	ba 02 57 04 00       	mov    $0x45702,%edx
   42d81:	be 30 00 00 00       	mov    $0x30,%esi
   42d86:	bf f0 56 04 00       	mov    $0x456f0,%edi
   42d8b:	e8 d4 f7 ff ff       	call   42564 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   42d90:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d94:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42d98:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d9c:	48 01 d0             	add    %rdx,%rax
   42d9f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   42da3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42daa:	e9 94 00 00 00       	jmp    42e43 <program_load+0x126>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   42daf:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42db2:	48 63 d0             	movslq %eax,%rdx
   42db5:	48 89 d0             	mov    %rdx,%rax
   42db8:	48 c1 e0 03          	shl    $0x3,%rax
   42dbc:	48 29 d0             	sub    %rdx,%rax
   42dbf:	48 c1 e0 03          	shl    $0x3,%rax
   42dc3:	48 89 c2             	mov    %rax,%rdx
   42dc6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42dca:	48 01 d0             	add    %rdx,%rax
   42dcd:	8b 00                	mov    (%rax),%eax
   42dcf:	83 f8 01             	cmp    $0x1,%eax
   42dd2:	75 6b                	jne    42e3f <program_load+0x122>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   42dd4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42dd7:	48 63 d0             	movslq %eax,%rdx
   42dda:	48 89 d0             	mov    %rdx,%rax
   42ddd:	48 c1 e0 03          	shl    $0x3,%rax
   42de1:	48 29 d0             	sub    %rdx,%rax
   42de4:	48 c1 e0 03          	shl    $0x3,%rax
   42de8:	48 89 c2             	mov    %rax,%rdx
   42deb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42def:	48 01 d0             	add    %rdx,%rax
   42df2:	48 8b 50 08          	mov    0x8(%rax),%rdx
   42df6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42dfa:	48 01 d0             	add    %rdx,%rax
   42dfd:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   42e01:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42e04:	48 63 d0             	movslq %eax,%rdx
   42e07:	48 89 d0             	mov    %rdx,%rax
   42e0a:	48 c1 e0 03          	shl    $0x3,%rax
   42e0e:	48 29 d0             	sub    %rdx,%rax
   42e11:	48 c1 e0 03          	shl    $0x3,%rax
   42e15:	48 89 c2             	mov    %rax,%rdx
   42e18:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42e1c:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   42e20:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42e24:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42e28:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e2c:	48 89 c7             	mov    %rax,%rdi
   42e2f:	e8 3d 00 00 00       	call   42e71 <program_load_segment>
   42e34:	85 c0                	test   %eax,%eax
   42e36:	79 07                	jns    42e3f <program_load+0x122>
                return -1;
   42e38:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42e3d:	eb 30                	jmp    42e6f <program_load+0x152>
    for (int i = 0; i < eh->e_phnum; ++i) {
   42e3f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   42e43:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e47:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   42e4b:	0f b7 c0             	movzwl %ax,%eax
   42e4e:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   42e51:	0f 8c 58 ff ff ff    	jl     42daf <program_load+0x92>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   42e57:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e5b:	48 8b 50 18          	mov    0x18(%rax),%rdx
   42e5f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e63:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    return 0;
   42e6a:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42e6f:	c9                   	leave  
   42e70:	c3                   	ret    

0000000000042e71 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   42e71:	55                   	push   %rbp
   42e72:	48 89 e5             	mov    %rsp,%rbp
   42e75:	48 83 ec 70          	sub    $0x70,%rsp
   42e79:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42e7d:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   42e81:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   42e85:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   42e89:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42e8d:	48 8b 40 10          	mov    0x10(%rax),%rax
   42e91:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   42e95:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42e99:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42e9d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ea1:	48 01 d0             	add    %rdx,%rax
   42ea4:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   42ea8:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42eac:	48 8b 50 28          	mov    0x28(%rax),%rdx
   42eb0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42eb4:	48 01 d0             	add    %rdx,%rax
   42eb7:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   42ebb:	48 81 65 e8 00 f0 ff 	andq   $0xfffffffffffff000,-0x18(%rbp)
   42ec2:	ff 


    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42ec3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ec7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   42ecb:	eb 7c                	jmp    42f49 <program_load_segment+0xd8>
        uintptr_t pa = (uintptr_t)palloc(p->p_pid);
   42ecd:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42ed1:	8b 00                	mov    (%rax),%eax
   42ed3:	89 c7                	mov    %eax,%edi
   42ed5:	e8 9b 01 00 00       	call   43075 <palloc>
   42eda:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        if(pa == (uintptr_t)NULL || virtual_memory_map(p->p_pagetable, addr, pa, PAGESIZE,
   42ede:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
   42ee3:	74 2a                	je     42f0f <program_load_segment+0x9e>
   42ee5:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42ee9:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   42ef0:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42ef4:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   42ef8:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42efe:	b9 00 10 00 00       	mov    $0x1000,%ecx
   42f03:	48 89 c7             	mov    %rax,%rdi
   42f06:	e8 58 f9 ff ff       	call   42863 <virtual_memory_map>
   42f0b:	85 c0                	test   %eax,%eax
   42f0d:	79 32                	jns    42f41 <program_load_segment+0xd0>
                    PTE_W | PTE_P | PTE_U) < 0) {
            console_printf(CPOS(22, 0), 0xC000,
   42f0f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42f13:	8b 00                	mov    (%rax),%eax
   42f15:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42f19:	49 89 d0             	mov    %rdx,%r8
   42f1c:	89 c1                	mov    %eax,%ecx
   42f1e:	ba 20 57 04 00       	mov    $0x45720,%edx
   42f23:	be 00 c0 00 00       	mov    $0xc000,%esi
   42f28:	bf e0 06 00 00       	mov    $0x6e0,%edi
   42f2d:	b8 00 00 00 00       	mov    $0x0,%eax
   42f32:	e8 27 1b 00 00       	call   44a5e <console_printf>
                    "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
            return -1;
   42f37:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42f3c:	e9 32 01 00 00       	jmp    43073 <program_load_segment+0x202>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42f41:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42f48:	00 
   42f49:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42f4d:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   42f51:	0f 82 76 ff ff ff    	jb     42ecd <program_load_segment+0x5c>
        }
    }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   42f57:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42f5b:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   42f62:	48 89 c7             	mov    %rax,%rdi
   42f65:	e8 c8 f7 ff ff       	call   42732 <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   42f6a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42f6e:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   42f72:	48 89 c2             	mov    %rax,%rdx
   42f75:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f79:	48 8b 4d 98          	mov    -0x68(%rbp),%rcx
   42f7d:	48 89 ce             	mov    %rcx,%rsi
   42f80:	48 89 c7             	mov    %rax,%rdi
   42f83:	e8 21 0c 00 00       	call   43ba9 <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   42f88:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42f8c:	48 2b 45 e0          	sub    -0x20(%rbp),%rax
   42f90:	48 89 c2             	mov    %rax,%rdx
   42f93:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42f97:	be 00 00 00 00       	mov    $0x0,%esi
   42f9c:	48 89 c7             	mov    %rax,%rdi
   42f9f:	e8 03 0d 00 00       	call   43ca7 <memset>

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   42fa4:	48 8b 05 55 f0 00 00 	mov    0xf055(%rip),%rax        # 52000 <kernel_pagetable>
   42fab:	48 89 c7             	mov    %rax,%rdi
   42fae:	e8 7f f7 ff ff       	call   42732 <set_pagetable>


    if((ph->p_flags & ELF_PFLAG_WRITE) == 0) {
   42fb3:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42fb7:	8b 40 04             	mov    0x4(%rax),%eax
   42fba:	83 e0 02             	and    $0x2,%eax
   42fbd:	85 c0                	test   %eax,%eax
   42fbf:	75 60                	jne    43021 <program_load_segment+0x1b0>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42fc1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42fc5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   42fc9:	eb 4c                	jmp    43017 <program_load_segment+0x1a6>
            vamapping mapping = virtual_memory_lookup(p->p_pagetable, addr);
   42fcb:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42fcf:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   42fd6:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   42fda:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   42fde:	48 89 ce             	mov    %rcx,%rsi
   42fe1:	48 89 c7             	mov    %rax,%rdi
   42fe4:	e8 3d fc ff ff       	call   42c26 <virtual_memory_lookup>

            virtual_memory_map(p->p_pagetable, addr, mapping.pa, PAGESIZE,
   42fe9:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42fed:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42ff1:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   42ff8:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   42ffc:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   43002:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43007:	48 89 c7             	mov    %rax,%rdi
   4300a:	e8 54 f8 ff ff       	call   42863 <virtual_memory_map>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   4300f:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   43016:	00 
   43017:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4301b:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   4301f:	72 aa                	jb     42fcb <program_load_segment+0x15a>
                    PTE_P | PTE_U);
        }
    }
    // TODO : Add code here -> done
    // log_printf("heap bottom/top before loading this segment: 0x%x\n", p->original_break);
    uintptr_t newbrk = (ph->p_va + ph->p_memsz + (PAGESIZE - 1)) & ~(PAGESIZE - 1);
   43021:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   43025:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43029:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   4302d:	48 8b 40 28          	mov    0x28(%rax),%rax
   43031:	48 01 d0             	add    %rdx,%rax
   43034:	48 05 ff 0f 00 00    	add    $0xfff,%rax
   4303a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43040:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    if (newbrk > p->original_break)
   43044:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43048:	48 8b 40 10          	mov    0x10(%rax),%rax
   4304c:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   43050:	73 0c                	jae    4305e <program_load_segment+0x1ed>
	    p->original_break = newbrk;
   43052:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43056:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   4305a:	48 89 50 10          	mov    %rdx,0x10(%rax)
    p->program_break = p->original_break;
   4305e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43062:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43066:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4306a:	48 89 50 08          	mov    %rdx,0x8(%rax)
    // log_printf("heap bottom/top after loading this segment: 0x%x\n", p->original_break);
    return 0;
   4306e:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43073:	c9                   	leave  
   43074:	c3                   	ret    

0000000000043075 <palloc>:
   43075:	55                   	push   %rbp
   43076:	48 89 e5             	mov    %rsp,%rbp
   43079:	48 83 ec 20          	sub    $0x20,%rsp
   4307d:	89 7d ec             	mov    %edi,-0x14(%rbp)
   43080:	48 c7 45 f8 00 10 00 	movq   $0x1000,-0x8(%rbp)
   43087:	00 
   43088:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4308c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43090:	e9 95 00 00 00       	jmp    4312a <palloc+0xb5>
   43095:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43099:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   4309d:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   430a4:	00 
   430a5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   430a9:	48 c1 e8 0c          	shr    $0xc,%rax
   430ad:	48 98                	cltq   
   430af:	0f b6 84 00 20 ff 04 	movzbl 0x4ff20(%rax,%rax,1),%eax
   430b6:	00 
   430b7:	84 c0                	test   %al,%al
   430b9:	75 6f                	jne    4312a <palloc+0xb5>
   430bb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   430bf:	48 c1 e8 0c          	shr    $0xc,%rax
   430c3:	48 98                	cltq   
   430c5:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   430cc:	00 
   430cd:	84 c0                	test   %al,%al
   430cf:	75 59                	jne    4312a <palloc+0xb5>
   430d1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   430d5:	48 c1 e8 0c          	shr    $0xc,%rax
   430d9:	89 c2                	mov    %eax,%edx
   430db:	48 63 c2             	movslq %edx,%rax
   430de:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   430e5:	00 
   430e6:	83 c0 01             	add    $0x1,%eax
   430e9:	89 c1                	mov    %eax,%ecx
   430eb:	48 63 c2             	movslq %edx,%rax
   430ee:	88 8c 00 21 ff 04 00 	mov    %cl,0x4ff21(%rax,%rax,1)
   430f5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   430f9:	48 c1 e8 0c          	shr    $0xc,%rax
   430fd:	89 c1                	mov    %eax,%ecx
   430ff:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43102:	89 c2                	mov    %eax,%edx
   43104:	48 63 c1             	movslq %ecx,%rax
   43107:	88 94 00 20 ff 04 00 	mov    %dl,0x4ff20(%rax,%rax,1)
   4310e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43112:	ba 00 10 00 00       	mov    $0x1000,%edx
   43117:	be cc 00 00 00       	mov    $0xcc,%esi
   4311c:	48 89 c7             	mov    %rax,%rdi
   4311f:	e8 83 0b 00 00       	call   43ca7 <memset>
   43124:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43128:	eb 2c                	jmp    43156 <palloc+0xe1>
   4312a:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   43131:	00 
   43132:	0f 86 5d ff ff ff    	jbe    43095 <palloc+0x20>
   43138:	ba 58 57 04 00       	mov    $0x45758,%edx
   4313d:	be 00 0c 00 00       	mov    $0xc00,%esi
   43142:	bf 80 07 00 00       	mov    $0x780,%edi
   43147:	b8 00 00 00 00       	mov    $0x0,%eax
   4314c:	e8 0d 19 00 00       	call   44a5e <console_printf>
   43151:	b8 00 00 00 00       	mov    $0x0,%eax
   43156:	c9                   	leave  
   43157:	c3                   	ret    

0000000000043158 <palloc_target>:
   43158:	55                   	push   %rbp
   43159:	48 89 e5             	mov    %rsp,%rbp
   4315c:	48 8b 05 9d 4e 01 00 	mov    0x14e9d(%rip),%rax        # 58000 <palloc_target_proc>
   43163:	48 85 c0             	test   %rax,%rax
   43166:	75 14                	jne    4317c <palloc_target+0x24>
   43168:	ba 71 57 04 00       	mov    $0x45771,%edx
   4316d:	be 27 00 00 00       	mov    $0x27,%esi
   43172:	bf 8c 57 04 00       	mov    $0x4578c,%edi
   43177:	e8 e8 f3 ff ff       	call   42564 <assert_fail>
   4317c:	48 8b 05 7d 4e 01 00 	mov    0x14e7d(%rip),%rax        # 58000 <palloc_target_proc>
   43183:	8b 00                	mov    (%rax),%eax
   43185:	89 c7                	mov    %eax,%edi
   43187:	e8 e9 fe ff ff       	call   43075 <palloc>
   4318c:	5d                   	pop    %rbp
   4318d:	c3                   	ret    

000000000004318e <process_free>:
   4318e:	55                   	push   %rbp
   4318f:	48 89 e5             	mov    %rsp,%rbp
   43192:	48 83 ec 60          	sub    $0x60,%rsp
   43196:	89 7d ac             	mov    %edi,-0x54(%rbp)
   43199:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4319c:	48 63 d0             	movslq %eax,%rdx
   4319f:	48 89 d0             	mov    %rdx,%rax
   431a2:	48 c1 e0 04          	shl    $0x4,%rax
   431a6:	48 29 d0             	sub    %rdx,%rax
   431a9:	48 c1 e0 04          	shl    $0x4,%rax
   431ad:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   431b3:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
   431b9:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   431c0:	00 
   431c1:	e9 ad 00 00 00       	jmp    43273 <process_free+0xe5>
   431c6:	8b 45 ac             	mov    -0x54(%rbp),%eax
   431c9:	48 63 d0             	movslq %eax,%rdx
   431cc:	48 89 d0             	mov    %rdx,%rax
   431cf:	48 c1 e0 04          	shl    $0x4,%rax
   431d3:	48 29 d0             	sub    %rdx,%rax
   431d6:	48 c1 e0 04          	shl    $0x4,%rax
   431da:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   431e0:	48 8b 08             	mov    (%rax),%rcx
   431e3:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   431e7:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   431eb:	48 89 ce             	mov    %rcx,%rsi
   431ee:	48 89 c7             	mov    %rax,%rdi
   431f1:	e8 30 fa ff ff       	call   42c26 <virtual_memory_lookup>
   431f6:	8b 45 c8             	mov    -0x38(%rbp),%eax
   431f9:	48 98                	cltq   
   431fb:	83 e0 01             	and    $0x1,%eax
   431fe:	48 85 c0             	test   %rax,%rax
   43201:	74 68                	je     4326b <process_free+0xdd>
   43203:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43206:	48 63 d0             	movslq %eax,%rdx
   43209:	0f b6 94 12 21 ff 04 	movzbl 0x4ff21(%rdx,%rdx,1),%edx
   43210:	00 
   43211:	83 ea 01             	sub    $0x1,%edx
   43214:	48 98                	cltq   
   43216:	88 94 00 21 ff 04 00 	mov    %dl,0x4ff21(%rax,%rax,1)
   4321d:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43220:	48 98                	cltq   
   43222:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   43229:	00 
   4322a:	84 c0                	test   %al,%al
   4322c:	75 0f                	jne    4323d <process_free+0xaf>
   4322e:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43231:	48 98                	cltq   
   43233:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   4323a:	00 
   4323b:	eb 2e                	jmp    4326b <process_free+0xdd>
   4323d:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43240:	48 98                	cltq   
   43242:	0f b6 84 00 20 ff 04 	movzbl 0x4ff20(%rax,%rax,1),%eax
   43249:	00 
   4324a:	0f be c0             	movsbl %al,%eax
   4324d:	39 45 ac             	cmp    %eax,-0x54(%rbp)
   43250:	75 19                	jne    4326b <process_free+0xdd>
   43252:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43256:	8b 55 ac             	mov    -0x54(%rbp),%edx
   43259:	48 89 c6             	mov    %rax,%rsi
   4325c:	bf 98 57 04 00       	mov    $0x45798,%edi
   43261:	b8 00 00 00 00       	mov    $0x0,%eax
   43266:	e8 db ef ff ff       	call   42246 <log_printf>
   4326b:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43272:	00 
   43273:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   4327a:	00 
   4327b:	0f 86 45 ff ff ff    	jbe    431c6 <process_free+0x38>
   43281:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43284:	48 63 d0             	movslq %eax,%rdx
   43287:	48 89 d0             	mov    %rdx,%rax
   4328a:	48 c1 e0 04          	shl    $0x4,%rax
   4328e:	48 29 d0             	sub    %rdx,%rax
   43291:	48 c1 e0 04          	shl    $0x4,%rax
   43295:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   4329b:	48 8b 00             	mov    (%rax),%rax
   4329e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   432a2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432a6:	48 8b 00             	mov    (%rax),%rax
   432a9:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   432af:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   432b3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   432b7:	48 8b 00             	mov    (%rax),%rax
   432ba:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   432c0:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   432c4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   432c8:	48 8b 00             	mov    (%rax),%rax
   432cb:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   432d1:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   432d5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   432d9:	48 8b 40 08          	mov    0x8(%rax),%rax
   432dd:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   432e3:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
   432e7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432eb:	48 c1 e8 0c          	shr    $0xc,%rax
   432ef:	48 98                	cltq   
   432f1:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   432f8:	00 
   432f9:	3c 01                	cmp    $0x1,%al
   432fb:	74 14                	je     43311 <process_free+0x183>
   432fd:	ba d0 57 04 00       	mov    $0x457d0,%edx
   43302:	be 4f 00 00 00       	mov    $0x4f,%esi
   43307:	bf 8c 57 04 00       	mov    $0x4578c,%edi
   4330c:	e8 53 f2 ff ff       	call   42564 <assert_fail>
   43311:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43315:	48 c1 e8 0c          	shr    $0xc,%rax
   43319:	48 98                	cltq   
   4331b:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43322:	00 
   43323:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43327:	48 c1 e8 0c          	shr    $0xc,%rax
   4332b:	48 98                	cltq   
   4332d:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43334:	00 
   43335:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43339:	48 c1 e8 0c          	shr    $0xc,%rax
   4333d:	48 98                	cltq   
   4333f:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   43346:	00 
   43347:	3c 01                	cmp    $0x1,%al
   43349:	74 14                	je     4335f <process_free+0x1d1>
   4334b:	ba f8 57 04 00       	mov    $0x457f8,%edx
   43350:	be 52 00 00 00       	mov    $0x52,%esi
   43355:	bf 8c 57 04 00       	mov    $0x4578c,%edi
   4335a:	e8 05 f2 ff ff       	call   42564 <assert_fail>
   4335f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43363:	48 c1 e8 0c          	shr    $0xc,%rax
   43367:	48 98                	cltq   
   43369:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43370:	00 
   43371:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43375:	48 c1 e8 0c          	shr    $0xc,%rax
   43379:	48 98                	cltq   
   4337b:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43382:	00 
   43383:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43387:	48 c1 e8 0c          	shr    $0xc,%rax
   4338b:	48 98                	cltq   
   4338d:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   43394:	00 
   43395:	3c 01                	cmp    $0x1,%al
   43397:	74 14                	je     433ad <process_free+0x21f>
   43399:	ba 20 58 04 00       	mov    $0x45820,%edx
   4339e:	be 55 00 00 00       	mov    $0x55,%esi
   433a3:	bf 8c 57 04 00       	mov    $0x4578c,%edi
   433a8:	e8 b7 f1 ff ff       	call   42564 <assert_fail>
   433ad:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   433b1:	48 c1 e8 0c          	shr    $0xc,%rax
   433b5:	48 98                	cltq   
   433b7:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   433be:	00 
   433bf:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   433c3:	48 c1 e8 0c          	shr    $0xc,%rax
   433c7:	48 98                	cltq   
   433c9:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   433d0:	00 
   433d1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   433d5:	48 c1 e8 0c          	shr    $0xc,%rax
   433d9:	48 98                	cltq   
   433db:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   433e2:	00 
   433e3:	3c 01                	cmp    $0x1,%al
   433e5:	74 14                	je     433fb <process_free+0x26d>
   433e7:	ba 48 58 04 00       	mov    $0x45848,%edx
   433ec:	be 58 00 00 00       	mov    $0x58,%esi
   433f1:	bf 8c 57 04 00       	mov    $0x4578c,%edi
   433f6:	e8 69 f1 ff ff       	call   42564 <assert_fail>
   433fb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   433ff:	48 c1 e8 0c          	shr    $0xc,%rax
   43403:	48 98                	cltq   
   43405:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   4340c:	00 
   4340d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43411:	48 c1 e8 0c          	shr    $0xc,%rax
   43415:	48 98                	cltq   
   43417:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   4341e:	00 
   4341f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43423:	48 c1 e8 0c          	shr    $0xc,%rax
   43427:	48 98                	cltq   
   43429:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   43430:	00 
   43431:	3c 01                	cmp    $0x1,%al
   43433:	74 14                	je     43449 <process_free+0x2bb>
   43435:	ba 70 58 04 00       	mov    $0x45870,%edx
   4343a:	be 5b 00 00 00       	mov    $0x5b,%esi
   4343f:	bf 8c 57 04 00       	mov    $0x4578c,%edi
   43444:	e8 1b f1 ff ff       	call   42564 <assert_fail>
   43449:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4344d:	48 c1 e8 0c          	shr    $0xc,%rax
   43451:	48 98                	cltq   
   43453:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   4345a:	00 
   4345b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4345f:	48 c1 e8 0c          	shr    $0xc,%rax
   43463:	48 98                	cltq   
   43465:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   4346c:	00 
   4346d:	90                   	nop
   4346e:	c9                   	leave  
   4346f:	c3                   	ret    

0000000000043470 <process_config_tables>:
   43470:	55                   	push   %rbp
   43471:	48 89 e5             	mov    %rsp,%rbp
   43474:	48 83 ec 40          	sub    $0x40,%rsp
   43478:	89 7d cc             	mov    %edi,-0x34(%rbp)
   4347b:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4347e:	89 c7                	mov    %eax,%edi
   43480:	e8 f0 fb ff ff       	call   43075 <palloc>
   43485:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43489:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4348c:	89 c7                	mov    %eax,%edi
   4348e:	e8 e2 fb ff ff       	call   43075 <palloc>
   43493:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43497:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4349a:	89 c7                	mov    %eax,%edi
   4349c:	e8 d4 fb ff ff       	call   43075 <palloc>
   434a1:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   434a5:	8b 45 cc             	mov    -0x34(%rbp),%eax
   434a8:	89 c7                	mov    %eax,%edi
   434aa:	e8 c6 fb ff ff       	call   43075 <palloc>
   434af:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   434b3:	8b 45 cc             	mov    -0x34(%rbp),%eax
   434b6:	89 c7                	mov    %eax,%edi
   434b8:	e8 b8 fb ff ff       	call   43075 <palloc>
   434bd:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   434c1:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   434c6:	74 20                	je     434e8 <process_config_tables+0x78>
   434c8:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   434cd:	74 19                	je     434e8 <process_config_tables+0x78>
   434cf:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   434d4:	74 12                	je     434e8 <process_config_tables+0x78>
   434d6:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   434db:	74 0b                	je     434e8 <process_config_tables+0x78>
   434dd:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   434e2:	0f 85 e1 00 00 00    	jne    435c9 <process_config_tables+0x159>
   434e8:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   434ed:	74 24                	je     43513 <process_config_tables+0xa3>
   434ef:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   434f3:	48 c1 e8 0c          	shr    $0xc,%rax
   434f7:	48 98                	cltq   
   434f9:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43500:	00 
   43501:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43505:	48 c1 e8 0c          	shr    $0xc,%rax
   43509:	48 98                	cltq   
   4350b:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43512:	00 
   43513:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   43518:	74 24                	je     4353e <process_config_tables+0xce>
   4351a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4351e:	48 c1 e8 0c          	shr    $0xc,%rax
   43522:	48 98                	cltq   
   43524:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   4352b:	00 
   4352c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43530:	48 c1 e8 0c          	shr    $0xc,%rax
   43534:	48 98                	cltq   
   43536:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   4353d:	00 
   4353e:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   43543:	74 24                	je     43569 <process_config_tables+0xf9>
   43545:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43549:	48 c1 e8 0c          	shr    $0xc,%rax
   4354d:	48 98                	cltq   
   4354f:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43556:	00 
   43557:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4355b:	48 c1 e8 0c          	shr    $0xc,%rax
   4355f:	48 98                	cltq   
   43561:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43568:	00 
   43569:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   4356e:	74 24                	je     43594 <process_config_tables+0x124>
   43570:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43574:	48 c1 e8 0c          	shr    $0xc,%rax
   43578:	48 98                	cltq   
   4357a:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43581:	00 
   43582:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43586:	48 c1 e8 0c          	shr    $0xc,%rax
   4358a:	48 98                	cltq   
   4358c:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43593:	00 
   43594:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43599:	74 24                	je     435bf <process_config_tables+0x14f>
   4359b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4359f:	48 c1 e8 0c          	shr    $0xc,%rax
   435a3:	48 98                	cltq   
   435a5:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   435ac:	00 
   435ad:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   435b1:	48 c1 e8 0c          	shr    $0xc,%rax
   435b5:	48 98                	cltq   
   435b7:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   435be:	00 
   435bf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   435c4:	e9 f3 01 00 00       	jmp    437bc <process_config_tables+0x34c>
   435c9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   435cd:	ba 00 10 00 00       	mov    $0x1000,%edx
   435d2:	be 00 00 00 00       	mov    $0x0,%esi
   435d7:	48 89 c7             	mov    %rax,%rdi
   435da:	e8 c8 06 00 00       	call   43ca7 <memset>
   435df:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435e3:	ba 00 10 00 00       	mov    $0x1000,%edx
   435e8:	be 00 00 00 00       	mov    $0x0,%esi
   435ed:	48 89 c7             	mov    %rax,%rdi
   435f0:	e8 b2 06 00 00       	call   43ca7 <memset>
   435f5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   435f9:	ba 00 10 00 00       	mov    $0x1000,%edx
   435fe:	be 00 00 00 00       	mov    $0x0,%esi
   43603:	48 89 c7             	mov    %rax,%rdi
   43606:	e8 9c 06 00 00       	call   43ca7 <memset>
   4360b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4360f:	ba 00 10 00 00       	mov    $0x1000,%edx
   43614:	be 00 00 00 00       	mov    $0x0,%esi
   43619:	48 89 c7             	mov    %rax,%rdi
   4361c:	e8 86 06 00 00       	call   43ca7 <memset>
   43621:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43625:	ba 00 10 00 00       	mov    $0x1000,%edx
   4362a:	be 00 00 00 00       	mov    $0x0,%esi
   4362f:	48 89 c7             	mov    %rax,%rdi
   43632:	e8 70 06 00 00       	call   43ca7 <memset>
   43637:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4363b:	48 83 c8 07          	or     $0x7,%rax
   4363f:	48 89 c2             	mov    %rax,%rdx
   43642:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43646:	48 89 10             	mov    %rdx,(%rax)
   43649:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4364d:	48 83 c8 07          	or     $0x7,%rax
   43651:	48 89 c2             	mov    %rax,%rdx
   43654:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43658:	48 89 10             	mov    %rdx,(%rax)
   4365b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4365f:	48 83 c8 07          	or     $0x7,%rax
   43663:	48 89 c2             	mov    %rax,%rdx
   43666:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4366a:	48 89 10             	mov    %rdx,(%rax)
   4366d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43671:	48 83 c8 07          	or     $0x7,%rax
   43675:	48 89 c2             	mov    %rax,%rdx
   43678:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4367c:	48 89 50 08          	mov    %rdx,0x8(%rax)
   43680:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43684:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   4368a:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   43690:	b9 00 00 10 00       	mov    $0x100000,%ecx
   43695:	ba 00 00 00 00       	mov    $0x0,%edx
   4369a:	be 00 00 00 00       	mov    $0x0,%esi
   4369f:	48 89 c7             	mov    %rax,%rdi
   436a2:	e8 bc f1 ff ff       	call   42863 <virtual_memory_map>
   436a7:	85 c0                	test   %eax,%eax
   436a9:	75 2f                	jne    436da <process_config_tables+0x26a>
   436ab:	ba 00 80 0b 00       	mov    $0xb8000,%edx
   436b0:	be 00 80 0b 00       	mov    $0xb8000,%esi
   436b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   436b9:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   436bf:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   436c5:	b9 00 10 00 00       	mov    $0x1000,%ecx
   436ca:	48 89 c7             	mov    %rax,%rdi
   436cd:	e8 91 f1 ff ff       	call   42863 <virtual_memory_map>
   436d2:	85 c0                	test   %eax,%eax
   436d4:	0f 84 bb 00 00 00    	je     43795 <process_config_tables+0x325>
   436da:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   436de:	48 c1 e8 0c          	shr    $0xc,%rax
   436e2:	48 98                	cltq   
   436e4:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   436eb:	00 
   436ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   436f0:	48 c1 e8 0c          	shr    $0xc,%rax
   436f4:	48 98                	cltq   
   436f6:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   436fd:	00 
   436fe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43702:	48 c1 e8 0c          	shr    $0xc,%rax
   43706:	48 98                	cltq   
   43708:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   4370f:	00 
   43710:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43714:	48 c1 e8 0c          	shr    $0xc,%rax
   43718:	48 98                	cltq   
   4371a:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43721:	00 
   43722:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43726:	48 c1 e8 0c          	shr    $0xc,%rax
   4372a:	48 98                	cltq   
   4372c:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43733:	00 
   43734:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43738:	48 c1 e8 0c          	shr    $0xc,%rax
   4373c:	48 98                	cltq   
   4373e:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43745:	00 
   43746:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4374a:	48 c1 e8 0c          	shr    $0xc,%rax
   4374e:	48 98                	cltq   
   43750:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43757:	00 
   43758:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4375c:	48 c1 e8 0c          	shr    $0xc,%rax
   43760:	48 98                	cltq   
   43762:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43769:	00 
   4376a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4376e:	48 c1 e8 0c          	shr    $0xc,%rax
   43772:	48 98                	cltq   
   43774:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   4377b:	00 
   4377c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43780:	48 c1 e8 0c          	shr    $0xc,%rax
   43784:	48 98                	cltq   
   43786:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   4378d:	00 
   4378e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43793:	eb 27                	jmp    437bc <process_config_tables+0x34c>
   43795:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43798:	48 63 d0             	movslq %eax,%rdx
   4379b:	48 89 d0             	mov    %rdx,%rax
   4379e:	48 c1 e0 04          	shl    $0x4,%rax
   437a2:	48 29 d0             	sub    %rdx,%rax
   437a5:	48 c1 e0 04          	shl    $0x4,%rax
   437a9:	48 8d 90 e0 f0 04 00 	lea    0x4f0e0(%rax),%rdx
   437b0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   437b4:	48 89 02             	mov    %rax,(%rdx)
   437b7:	b8 00 00 00 00       	mov    $0x0,%eax
   437bc:	c9                   	leave  
   437bd:	c3                   	ret    

00000000000437be <process_load>:
   437be:	55                   	push   %rbp
   437bf:	48 89 e5             	mov    %rsp,%rbp
   437c2:	48 83 ec 20          	sub    $0x20,%rsp
   437c6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   437ca:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   437cd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   437d1:	48 89 05 28 48 01 00 	mov    %rax,0x14828(%rip)        # 58000 <palloc_target_proc>
   437d8:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
   437db:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   437df:	ba 58 31 04 00       	mov    $0x43158,%edx
   437e4:	89 ce                	mov    %ecx,%esi
   437e6:	48 89 c7             	mov    %rax,%rdi
   437e9:	e8 2f f5 ff ff       	call   42d1d <program_load>
   437ee:	89 45 fc             	mov    %eax,-0x4(%rbp)
   437f1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   437f4:	c9                   	leave  
   437f5:	c3                   	ret    

00000000000437f6 <process_setup_stack>:
   437f6:	55                   	push   %rbp
   437f7:	48 89 e5             	mov    %rsp,%rbp
   437fa:	48 83 ec 20          	sub    $0x20,%rsp
   437fe:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43802:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43806:	8b 00                	mov    (%rax),%eax
   43808:	89 c7                	mov    %eax,%edi
   4380a:	e8 66 f8 ff ff       	call   43075 <palloc>
   4380f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43813:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43817:	48 c7 80 c8 00 00 00 	movq   $0x300000,0xc8(%rax)
   4381e:	00 00 30 00 
   43822:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43826:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   4382d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43831:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43837:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4383d:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43842:	be 00 f0 2f 00       	mov    $0x2ff000,%esi
   43847:	48 89 c7             	mov    %rax,%rdi
   4384a:	e8 14 f0 ff ff       	call   42863 <virtual_memory_map>
   4384f:	90                   	nop
   43850:	c9                   	leave  
   43851:	c3                   	ret    

0000000000043852 <find_free_pid>:
   43852:	55                   	push   %rbp
   43853:	48 89 e5             	mov    %rsp,%rbp
   43856:	48 83 ec 10          	sub    $0x10,%rsp
   4385a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   43861:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
   43868:	eb 24                	jmp    4388e <find_free_pid+0x3c>
   4386a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4386d:	48 63 d0             	movslq %eax,%rdx
   43870:	48 89 d0             	mov    %rdx,%rax
   43873:	48 c1 e0 04          	shl    $0x4,%rax
   43877:	48 29 d0             	sub    %rdx,%rax
   4387a:	48 c1 e0 04          	shl    $0x4,%rax
   4387e:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   43884:	8b 00                	mov    (%rax),%eax
   43886:	85 c0                	test   %eax,%eax
   43888:	74 0c                	je     43896 <find_free_pid+0x44>
   4388a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4388e:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   43892:	7e d6                	jle    4386a <find_free_pid+0x18>
   43894:	eb 01                	jmp    43897 <find_free_pid+0x45>
   43896:	90                   	nop
   43897:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   4389b:	74 05                	je     438a2 <find_free_pid+0x50>
   4389d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   438a0:	eb 05                	jmp    438a7 <find_free_pid+0x55>
   438a2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   438a7:	c9                   	leave  
   438a8:	c3                   	ret    

00000000000438a9 <process_fork>:
   438a9:	55                   	push   %rbp
   438aa:	48 89 e5             	mov    %rsp,%rbp
   438ad:	48 83 ec 40          	sub    $0x40,%rsp
   438b1:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   438b5:	b8 00 00 00 00       	mov    $0x0,%eax
   438ba:	e8 93 ff ff ff       	call   43852 <find_free_pid>
   438bf:	89 45 f4             	mov    %eax,-0xc(%rbp)
   438c2:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%rbp)
   438c6:	75 0a                	jne    438d2 <process_fork+0x29>
   438c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   438cd:	e9 67 02 00 00       	jmp    43b39 <process_fork+0x290>
   438d2:	8b 45 f4             	mov    -0xc(%rbp),%eax
   438d5:	48 63 d0             	movslq %eax,%rdx
   438d8:	48 89 d0             	mov    %rdx,%rax
   438db:	48 c1 e0 04          	shl    $0x4,%rax
   438df:	48 29 d0             	sub    %rdx,%rax
   438e2:	48 c1 e0 04          	shl    $0x4,%rax
   438e6:	48 05 00 f0 04 00    	add    $0x4f000,%rax
   438ec:	be 00 00 00 00       	mov    $0x0,%esi
   438f1:	48 89 c7             	mov    %rax,%rdi
   438f4:	e8 9d e4 ff ff       	call   41d96 <process_init>
   438f9:	8b 45 f4             	mov    -0xc(%rbp),%eax
   438fc:	89 c7                	mov    %eax,%edi
   438fe:	e8 6d fb ff ff       	call   43470 <process_config_tables>
   43903:	83 f8 ff             	cmp    $0xffffffff,%eax
   43906:	75 0a                	jne    43912 <process_fork+0x69>
   43908:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4390d:	e9 27 02 00 00       	jmp    43b39 <process_fork+0x290>
   43912:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   43919:	00 
   4391a:	e9 79 01 00 00       	jmp    43a98 <process_fork+0x1ef>
   4391f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43923:	8b 00                	mov    (%rax),%eax
   43925:	48 63 d0             	movslq %eax,%rdx
   43928:	48 89 d0             	mov    %rdx,%rax
   4392b:	48 c1 e0 04          	shl    $0x4,%rax
   4392f:	48 29 d0             	sub    %rdx,%rax
   43932:	48 c1 e0 04          	shl    $0x4,%rax
   43936:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   4393c:	48 8b 08             	mov    (%rax),%rcx
   4393f:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   43943:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43947:	48 89 ce             	mov    %rcx,%rsi
   4394a:	48 89 c7             	mov    %rax,%rdi
   4394d:	e8 d4 f2 ff ff       	call   42c26 <virtual_memory_lookup>
   43952:	8b 45 e0             	mov    -0x20(%rbp),%eax
   43955:	48 98                	cltq   
   43957:	83 e0 07             	and    $0x7,%eax
   4395a:	48 83 f8 07          	cmp    $0x7,%rax
   4395e:	0f 85 a1 00 00 00    	jne    43a05 <process_fork+0x15c>
   43964:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43967:	89 c7                	mov    %eax,%edi
   43969:	e8 07 f7 ff ff       	call   43075 <palloc>
   4396e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   43972:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   43977:	75 14                	jne    4398d <process_fork+0xe4>
   43979:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4397c:	89 c7                	mov    %eax,%edi
   4397e:	e8 0b f8 ff ff       	call   4318e <process_free>
   43983:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43988:	e9 ac 01 00 00       	jmp    43b39 <process_fork+0x290>
   4398d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43991:	48 89 c1             	mov    %rax,%rcx
   43994:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43998:	ba 00 10 00 00       	mov    $0x1000,%edx
   4399d:	48 89 ce             	mov    %rcx,%rsi
   439a0:	48 89 c7             	mov    %rax,%rdi
   439a3:	e8 01 02 00 00       	call   43ba9 <memcpy>
   439a8:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
   439ac:	8b 45 f4             	mov    -0xc(%rbp),%eax
   439af:	48 63 d0             	movslq %eax,%rdx
   439b2:	48 89 d0             	mov    %rdx,%rax
   439b5:	48 c1 e0 04          	shl    $0x4,%rax
   439b9:	48 29 d0             	sub    %rdx,%rax
   439bc:	48 c1 e0 04          	shl    $0x4,%rax
   439c0:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   439c6:	48 8b 00             	mov    (%rax),%rax
   439c9:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   439cd:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   439d3:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   439d9:	b9 00 10 00 00       	mov    $0x1000,%ecx
   439de:	48 89 fa             	mov    %rdi,%rdx
   439e1:	48 89 c7             	mov    %rax,%rdi
   439e4:	e8 7a ee ff ff       	call   42863 <virtual_memory_map>
   439e9:	85 c0                	test   %eax,%eax
   439eb:	0f 84 9f 00 00 00    	je     43a90 <process_fork+0x1e7>
   439f1:	8b 45 f4             	mov    -0xc(%rbp),%eax
   439f4:	89 c7                	mov    %eax,%edi
   439f6:	e8 93 f7 ff ff       	call   4318e <process_free>
   439fb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43a00:	e9 34 01 00 00       	jmp    43b39 <process_fork+0x290>
   43a05:	8b 45 e0             	mov    -0x20(%rbp),%eax
   43a08:	48 98                	cltq   
   43a0a:	83 e0 05             	and    $0x5,%eax
   43a0d:	48 83 f8 05          	cmp    $0x5,%rax
   43a11:	75 7d                	jne    43a90 <process_fork+0x1e7>
   43a13:	48 8b 7d d8          	mov    -0x28(%rbp),%rdi
   43a17:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43a1a:	48 63 d0             	movslq %eax,%rdx
   43a1d:	48 89 d0             	mov    %rdx,%rax
   43a20:	48 c1 e0 04          	shl    $0x4,%rax
   43a24:	48 29 d0             	sub    %rdx,%rax
   43a27:	48 c1 e0 04          	shl    $0x4,%rax
   43a2b:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   43a31:	48 8b 00             	mov    (%rax),%rax
   43a34:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   43a38:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43a3e:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   43a44:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43a49:	48 89 fa             	mov    %rdi,%rdx
   43a4c:	48 89 c7             	mov    %rax,%rdi
   43a4f:	e8 0f ee ff ff       	call   42863 <virtual_memory_map>
   43a54:	85 c0                	test   %eax,%eax
   43a56:	74 14                	je     43a6c <process_fork+0x1c3>
   43a58:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43a5b:	89 c7                	mov    %eax,%edi
   43a5d:	e8 2c f7 ff ff       	call   4318e <process_free>
   43a62:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43a67:	e9 cd 00 00 00       	jmp    43b39 <process_fork+0x290>
   43a6c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43a70:	48 c1 e8 0c          	shr    $0xc,%rax
   43a74:	89 c2                	mov    %eax,%edx
   43a76:	48 63 c2             	movslq %edx,%rax
   43a79:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   43a80:	00 
   43a81:	83 c0 01             	add    $0x1,%eax
   43a84:	89 c1                	mov    %eax,%ecx
   43a86:	48 63 c2             	movslq %edx,%rax
   43a89:	88 8c 00 21 ff 04 00 	mov    %cl,0x4ff21(%rax,%rax,1)
   43a90:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43a97:	00 
   43a98:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   43a9f:	00 
   43aa0:	0f 86 79 fe ff ff    	jbe    4391f <process_fork+0x76>
   43aa6:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43aaa:	8b 08                	mov    (%rax),%ecx
   43aac:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43aaf:	48 63 d0             	movslq %eax,%rdx
   43ab2:	48 89 d0             	mov    %rdx,%rax
   43ab5:	48 c1 e0 04          	shl    $0x4,%rax
   43ab9:	48 29 d0             	sub    %rdx,%rax
   43abc:	48 c1 e0 04          	shl    $0x4,%rax
   43ac0:	48 8d b0 10 f0 04 00 	lea    0x4f010(%rax),%rsi
   43ac7:	48 63 d1             	movslq %ecx,%rdx
   43aca:	48 89 d0             	mov    %rdx,%rax
   43acd:	48 c1 e0 04          	shl    $0x4,%rax
   43ad1:	48 29 d0             	sub    %rdx,%rax
   43ad4:	48 c1 e0 04          	shl    $0x4,%rax
   43ad8:	48 8d 90 10 f0 04 00 	lea    0x4f010(%rax),%rdx
   43adf:	48 8d 46 08          	lea    0x8(%rsi),%rax
   43ae3:	48 83 c2 08          	add    $0x8,%rdx
   43ae7:	b9 18 00 00 00       	mov    $0x18,%ecx
   43aec:	48 89 c7             	mov    %rax,%rdi
   43aef:	48 89 d6             	mov    %rdx,%rsi
   43af2:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
   43af5:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43af8:	48 63 d0             	movslq %eax,%rdx
   43afb:	48 89 d0             	mov    %rdx,%rax
   43afe:	48 c1 e0 04          	shl    $0x4,%rax
   43b02:	48 29 d0             	sub    %rdx,%rax
   43b05:	48 c1 e0 04          	shl    $0x4,%rax
   43b09:	48 05 18 f0 04 00    	add    $0x4f018,%rax
   43b0f:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
   43b16:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43b19:	48 63 d0             	movslq %eax,%rdx
   43b1c:	48 89 d0             	mov    %rdx,%rax
   43b1f:	48 c1 e0 04          	shl    $0x4,%rax
   43b23:	48 29 d0             	sub    %rdx,%rax
   43b26:	48 c1 e0 04          	shl    $0x4,%rax
   43b2a:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   43b30:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
   43b36:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43b39:	c9                   	leave  
   43b3a:	c3                   	ret    

0000000000043b3b <process_page_alloc>:
   43b3b:	55                   	push   %rbp
   43b3c:	48 89 e5             	mov    %rsp,%rbp
   43b3f:	48 83 ec 20          	sub    $0x20,%rsp
   43b43:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43b47:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43b4b:	48 81 7d e0 ff ff 0f 	cmpq   $0xfffff,-0x20(%rbp)
   43b52:	00 
   43b53:	77 07                	ja     43b5c <process_page_alloc+0x21>
   43b55:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43b5a:	eb 4b                	jmp    43ba7 <process_page_alloc+0x6c>
   43b5c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43b60:	8b 00                	mov    (%rax),%eax
   43b62:	89 c7                	mov    %eax,%edi
   43b64:	e8 0c f5 ff ff       	call   43075 <palloc>
   43b69:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43b6d:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   43b72:	74 2e                	je     43ba2 <process_page_alloc+0x67>
   43b74:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43b78:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43b7c:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   43b83:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
   43b87:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43b8d:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43b93:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43b98:	48 89 c7             	mov    %rax,%rdi
   43b9b:	e8 c3 ec ff ff       	call   42863 <virtual_memory_map>
   43ba0:	eb 05                	jmp    43ba7 <process_page_alloc+0x6c>
   43ba2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43ba7:	c9                   	leave  
   43ba8:	c3                   	ret    

0000000000043ba9 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   43ba9:	55                   	push   %rbp
   43baa:	48 89 e5             	mov    %rsp,%rbp
   43bad:	48 83 ec 28          	sub    $0x28,%rsp
   43bb1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43bb5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43bb9:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43bbd:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43bc1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43bc5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43bc9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43bcd:	eb 1c                	jmp    43beb <memcpy+0x42>
        *d = *s;
   43bcf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43bd3:	0f b6 10             	movzbl (%rax),%edx
   43bd6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43bda:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43bdc:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43be1:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43be6:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   43beb:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43bf0:	75 dd                	jne    43bcf <memcpy+0x26>
    }
    return dst;
   43bf2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43bf6:	c9                   	leave  
   43bf7:	c3                   	ret    

0000000000043bf8 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   43bf8:	55                   	push   %rbp
   43bf9:	48 89 e5             	mov    %rsp,%rbp
   43bfc:	48 83 ec 28          	sub    $0x28,%rsp
   43c00:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43c04:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43c08:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43c0c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43c10:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   43c14:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43c18:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   43c1c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c20:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   43c24:	73 6a                	jae    43c90 <memmove+0x98>
   43c26:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43c2a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43c2e:	48 01 d0             	add    %rdx,%rax
   43c31:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   43c35:	73 59                	jae    43c90 <memmove+0x98>
        s += n, d += n;
   43c37:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43c3b:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   43c3f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43c43:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   43c47:	eb 17                	jmp    43c60 <memmove+0x68>
            *--d = *--s;
   43c49:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   43c4e:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   43c53:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c57:	0f b6 10             	movzbl (%rax),%edx
   43c5a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43c5e:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43c60:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43c64:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43c68:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43c6c:	48 85 c0             	test   %rax,%rax
   43c6f:	75 d8                	jne    43c49 <memmove+0x51>
    if (s < d && s + n > d) {
   43c71:	eb 2e                	jmp    43ca1 <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   43c73:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43c77:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43c7b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43c7f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43c83:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43c87:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   43c8b:	0f b6 12             	movzbl (%rdx),%edx
   43c8e:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43c90:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43c94:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43c98:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43c9c:	48 85 c0             	test   %rax,%rax
   43c9f:	75 d2                	jne    43c73 <memmove+0x7b>
        }
    }
    return dst;
   43ca1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43ca5:	c9                   	leave  
   43ca6:	c3                   	ret    

0000000000043ca7 <memset>:

void* memset(void* v, int c, size_t n) {
   43ca7:	55                   	push   %rbp
   43ca8:	48 89 e5             	mov    %rsp,%rbp
   43cab:	48 83 ec 28          	sub    $0x28,%rsp
   43caf:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43cb3:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   43cb6:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43cba:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43cbe:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43cc2:	eb 15                	jmp    43cd9 <memset+0x32>
        *p = c;
   43cc4:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43cc7:	89 c2                	mov    %eax,%edx
   43cc9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43ccd:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43ccf:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43cd4:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43cd9:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43cde:	75 e4                	jne    43cc4 <memset+0x1d>
    }
    return v;
   43ce0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43ce4:	c9                   	leave  
   43ce5:	c3                   	ret    

0000000000043ce6 <strlen>:

size_t strlen(const char* s) {
   43ce6:	55                   	push   %rbp
   43ce7:	48 89 e5             	mov    %rsp,%rbp
   43cea:	48 83 ec 18          	sub    $0x18,%rsp
   43cee:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   43cf2:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43cf9:	00 
   43cfa:	eb 0a                	jmp    43d06 <strlen+0x20>
        ++n;
   43cfc:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   43d01:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43d06:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43d0a:	0f b6 00             	movzbl (%rax),%eax
   43d0d:	84 c0                	test   %al,%al
   43d0f:	75 eb                	jne    43cfc <strlen+0x16>
    }
    return n;
   43d11:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43d15:	c9                   	leave  
   43d16:	c3                   	ret    

0000000000043d17 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   43d17:	55                   	push   %rbp
   43d18:	48 89 e5             	mov    %rsp,%rbp
   43d1b:	48 83 ec 20          	sub    $0x20,%rsp
   43d1f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43d23:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43d27:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43d2e:	00 
   43d2f:	eb 0a                	jmp    43d3b <strnlen+0x24>
        ++n;
   43d31:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43d36:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43d3b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43d3f:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   43d43:	74 0b                	je     43d50 <strnlen+0x39>
   43d45:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43d49:	0f b6 00             	movzbl (%rax),%eax
   43d4c:	84 c0                	test   %al,%al
   43d4e:	75 e1                	jne    43d31 <strnlen+0x1a>
    }
    return n;
   43d50:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43d54:	c9                   	leave  
   43d55:	c3                   	ret    

0000000000043d56 <strcpy>:

char* strcpy(char* dst, const char* src) {
   43d56:	55                   	push   %rbp
   43d57:	48 89 e5             	mov    %rsp,%rbp
   43d5a:	48 83 ec 20          	sub    $0x20,%rsp
   43d5e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43d62:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   43d66:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43d6a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   43d6e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43d72:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43d76:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43d7a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43d7e:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43d82:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   43d86:	0f b6 12             	movzbl (%rdx),%edx
   43d89:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   43d8b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43d8f:	48 83 e8 01          	sub    $0x1,%rax
   43d93:	0f b6 00             	movzbl (%rax),%eax
   43d96:	84 c0                	test   %al,%al
   43d98:	75 d4                	jne    43d6e <strcpy+0x18>
    return dst;
   43d9a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43d9e:	c9                   	leave  
   43d9f:	c3                   	ret    

0000000000043da0 <strcmp>:

int strcmp(const char* a, const char* b) {
   43da0:	55                   	push   %rbp
   43da1:	48 89 e5             	mov    %rsp,%rbp
   43da4:	48 83 ec 10          	sub    $0x10,%rsp
   43da8:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43dac:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43db0:	eb 0a                	jmp    43dbc <strcmp+0x1c>
        ++a, ++b;
   43db2:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43db7:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43dbc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43dc0:	0f b6 00             	movzbl (%rax),%eax
   43dc3:	84 c0                	test   %al,%al
   43dc5:	74 1d                	je     43de4 <strcmp+0x44>
   43dc7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43dcb:	0f b6 00             	movzbl (%rax),%eax
   43dce:	84 c0                	test   %al,%al
   43dd0:	74 12                	je     43de4 <strcmp+0x44>
   43dd2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43dd6:	0f b6 10             	movzbl (%rax),%edx
   43dd9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43ddd:	0f b6 00             	movzbl (%rax),%eax
   43de0:	38 c2                	cmp    %al,%dl
   43de2:	74 ce                	je     43db2 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   43de4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43de8:	0f b6 00             	movzbl (%rax),%eax
   43deb:	89 c2                	mov    %eax,%edx
   43ded:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43df1:	0f b6 00             	movzbl (%rax),%eax
   43df4:	38 d0                	cmp    %dl,%al
   43df6:	0f 92 c0             	setb   %al
   43df9:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   43dfc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e00:	0f b6 00             	movzbl (%rax),%eax
   43e03:	89 c1                	mov    %eax,%ecx
   43e05:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43e09:	0f b6 00             	movzbl (%rax),%eax
   43e0c:	38 c1                	cmp    %al,%cl
   43e0e:	0f 92 c0             	setb   %al
   43e11:	0f b6 c0             	movzbl %al,%eax
   43e14:	29 c2                	sub    %eax,%edx
   43e16:	89 d0                	mov    %edx,%eax
}
   43e18:	c9                   	leave  
   43e19:	c3                   	ret    

0000000000043e1a <strchr>:

char* strchr(const char* s, int c) {
   43e1a:	55                   	push   %rbp
   43e1b:	48 89 e5             	mov    %rsp,%rbp
   43e1e:	48 83 ec 10          	sub    $0x10,%rsp
   43e22:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43e26:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   43e29:	eb 05                	jmp    43e30 <strchr+0x16>
        ++s;
   43e2b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   43e30:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e34:	0f b6 00             	movzbl (%rax),%eax
   43e37:	84 c0                	test   %al,%al
   43e39:	74 0e                	je     43e49 <strchr+0x2f>
   43e3b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e3f:	0f b6 00             	movzbl (%rax),%eax
   43e42:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43e45:	38 d0                	cmp    %dl,%al
   43e47:	75 e2                	jne    43e2b <strchr+0x11>
    }
    if (*s == (char) c) {
   43e49:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e4d:	0f b6 00             	movzbl (%rax),%eax
   43e50:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43e53:	38 d0                	cmp    %dl,%al
   43e55:	75 06                	jne    43e5d <strchr+0x43>
        return (char*) s;
   43e57:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e5b:	eb 05                	jmp    43e62 <strchr+0x48>
    } else {
        return NULL;
   43e5d:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   43e62:	c9                   	leave  
   43e63:	c3                   	ret    

0000000000043e64 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   43e64:	55                   	push   %rbp
   43e65:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   43e68:	8b 05 9a 41 01 00    	mov    0x1419a(%rip),%eax        # 58008 <rand_seed_set>
   43e6e:	85 c0                	test   %eax,%eax
   43e70:	75 0a                	jne    43e7c <rand+0x18>
        srand(819234718U);
   43e72:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   43e77:	e8 24 00 00 00       	call   43ea0 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   43e7c:	8b 05 8a 41 01 00    	mov    0x1418a(%rip),%eax        # 5800c <rand_seed>
   43e82:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   43e88:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   43e8d:	89 05 79 41 01 00    	mov    %eax,0x14179(%rip)        # 5800c <rand_seed>
    return rand_seed & RAND_MAX;
   43e93:	8b 05 73 41 01 00    	mov    0x14173(%rip),%eax        # 5800c <rand_seed>
   43e99:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   43e9e:	5d                   	pop    %rbp
   43e9f:	c3                   	ret    

0000000000043ea0 <srand>:

void srand(unsigned seed) {
   43ea0:	55                   	push   %rbp
   43ea1:	48 89 e5             	mov    %rsp,%rbp
   43ea4:	48 83 ec 08          	sub    $0x8,%rsp
   43ea8:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   43eab:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43eae:	89 05 58 41 01 00    	mov    %eax,0x14158(%rip)        # 5800c <rand_seed>
    rand_seed_set = 1;
   43eb4:	c7 05 4a 41 01 00 01 	movl   $0x1,0x1414a(%rip)        # 58008 <rand_seed_set>
   43ebb:	00 00 00 
}
   43ebe:	90                   	nop
   43ebf:	c9                   	leave  
   43ec0:	c3                   	ret    

0000000000043ec1 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   43ec1:	55                   	push   %rbp
   43ec2:	48 89 e5             	mov    %rsp,%rbp
   43ec5:	48 83 ec 28          	sub    $0x28,%rsp
   43ec9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43ecd:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43ed1:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   43ed4:	48 c7 45 f8 80 5a 04 	movq   $0x45a80,-0x8(%rbp)
   43edb:	00 
    if (base < 0) {
   43edc:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   43ee0:	79 0b                	jns    43eed <fill_numbuf+0x2c>
        digits = lower_digits;
   43ee2:	48 c7 45 f8 a0 5a 04 	movq   $0x45aa0,-0x8(%rbp)
   43ee9:	00 
        base = -base;
   43eea:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   43eed:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43ef2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43ef6:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   43ef9:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43efc:	48 63 c8             	movslq %eax,%rcx
   43eff:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43f03:	ba 00 00 00 00       	mov    $0x0,%edx
   43f08:	48 f7 f1             	div    %rcx
   43f0b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43f0f:	48 01 d0             	add    %rdx,%rax
   43f12:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43f17:	0f b6 10             	movzbl (%rax),%edx
   43f1a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43f1e:	88 10                	mov    %dl,(%rax)
        val /= base;
   43f20:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43f23:	48 63 f0             	movslq %eax,%rsi
   43f26:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43f2a:	ba 00 00 00 00       	mov    $0x0,%edx
   43f2f:	48 f7 f6             	div    %rsi
   43f32:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   43f36:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43f3b:	75 bc                	jne    43ef9 <fill_numbuf+0x38>
    return numbuf_end;
   43f3d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43f41:	c9                   	leave  
   43f42:	c3                   	ret    

0000000000043f43 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   43f43:	55                   	push   %rbp
   43f44:	48 89 e5             	mov    %rsp,%rbp
   43f47:	53                   	push   %rbx
   43f48:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   43f4f:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   43f56:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   43f5c:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43f63:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   43f6a:	e9 8a 09 00 00       	jmp    448f9 <printer_vprintf+0x9b6>
        if (*format != '%') {
   43f6f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f76:	0f b6 00             	movzbl (%rax),%eax
   43f79:	3c 25                	cmp    $0x25,%al
   43f7b:	74 31                	je     43fae <printer_vprintf+0x6b>
            p->putc(p, *format, color);
   43f7d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43f84:	4c 8b 00             	mov    (%rax),%r8
   43f87:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f8e:	0f b6 00             	movzbl (%rax),%eax
   43f91:	0f b6 c8             	movzbl %al,%ecx
   43f94:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43f9a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43fa1:	89 ce                	mov    %ecx,%esi
   43fa3:	48 89 c7             	mov    %rax,%rdi
   43fa6:	41 ff d0             	call   *%r8
            continue;
   43fa9:	e9 43 09 00 00       	jmp    448f1 <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
   43fae:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   43fb5:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43fbc:	01 
   43fbd:	eb 44                	jmp    44003 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
   43fbf:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43fc6:	0f b6 00             	movzbl (%rax),%eax
   43fc9:	0f be c0             	movsbl %al,%eax
   43fcc:	89 c6                	mov    %eax,%esi
   43fce:	bf a0 58 04 00       	mov    $0x458a0,%edi
   43fd3:	e8 42 fe ff ff       	call   43e1a <strchr>
   43fd8:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   43fdc:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   43fe1:	74 30                	je     44013 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
   43fe3:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   43fe7:	48 2d a0 58 04 00    	sub    $0x458a0,%rax
   43fed:	ba 01 00 00 00       	mov    $0x1,%edx
   43ff2:	89 c1                	mov    %eax,%ecx
   43ff4:	d3 e2                	shl    %cl,%edx
   43ff6:	89 d0                	mov    %edx,%eax
   43ff8:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   43ffb:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44002:	01 
   44003:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4400a:	0f b6 00             	movzbl (%rax),%eax
   4400d:	84 c0                	test   %al,%al
   4400f:	75 ae                	jne    43fbf <printer_vprintf+0x7c>
   44011:	eb 01                	jmp    44014 <printer_vprintf+0xd1>
            } else {
                break;
   44013:	90                   	nop
            }
        }

        // process width
        int width = -1;
   44014:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   4401b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44022:	0f b6 00             	movzbl (%rax),%eax
   44025:	3c 30                	cmp    $0x30,%al
   44027:	7e 67                	jle    44090 <printer_vprintf+0x14d>
   44029:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44030:	0f b6 00             	movzbl (%rax),%eax
   44033:	3c 39                	cmp    $0x39,%al
   44035:	7f 59                	jg     44090 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   44037:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   4403e:	eb 2e                	jmp    4406e <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
   44040:	8b 55 e8             	mov    -0x18(%rbp),%edx
   44043:	89 d0                	mov    %edx,%eax
   44045:	c1 e0 02             	shl    $0x2,%eax
   44048:	01 d0                	add    %edx,%eax
   4404a:	01 c0                	add    %eax,%eax
   4404c:	89 c1                	mov    %eax,%ecx
   4404e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44055:	48 8d 50 01          	lea    0x1(%rax),%rdx
   44059:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   44060:	0f b6 00             	movzbl (%rax),%eax
   44063:	0f be c0             	movsbl %al,%eax
   44066:	01 c8                	add    %ecx,%eax
   44068:	83 e8 30             	sub    $0x30,%eax
   4406b:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   4406e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44075:	0f b6 00             	movzbl (%rax),%eax
   44078:	3c 2f                	cmp    $0x2f,%al
   4407a:	0f 8e 85 00 00 00    	jle    44105 <printer_vprintf+0x1c2>
   44080:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44087:	0f b6 00             	movzbl (%rax),%eax
   4408a:	3c 39                	cmp    $0x39,%al
   4408c:	7e b2                	jle    44040 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
   4408e:	eb 75                	jmp    44105 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
   44090:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44097:	0f b6 00             	movzbl (%rax),%eax
   4409a:	3c 2a                	cmp    $0x2a,%al
   4409c:	75 68                	jne    44106 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
   4409e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   440a5:	8b 00                	mov    (%rax),%eax
   440a7:	83 f8 2f             	cmp    $0x2f,%eax
   440aa:	77 30                	ja     440dc <printer_vprintf+0x199>
   440ac:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   440b3:	48 8b 50 10          	mov    0x10(%rax),%rdx
   440b7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   440be:	8b 00                	mov    (%rax),%eax
   440c0:	89 c0                	mov    %eax,%eax
   440c2:	48 01 d0             	add    %rdx,%rax
   440c5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   440cc:	8b 12                	mov    (%rdx),%edx
   440ce:	8d 4a 08             	lea    0x8(%rdx),%ecx
   440d1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   440d8:	89 0a                	mov    %ecx,(%rdx)
   440da:	eb 1a                	jmp    440f6 <printer_vprintf+0x1b3>
   440dc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   440e3:	48 8b 40 08          	mov    0x8(%rax),%rax
   440e7:	48 8d 48 08          	lea    0x8(%rax),%rcx
   440eb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   440f2:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   440f6:	8b 00                	mov    (%rax),%eax
   440f8:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   440fb:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44102:	01 
   44103:	eb 01                	jmp    44106 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
   44105:	90                   	nop
        }

        // process precision
        int precision = -1;
   44106:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   4410d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44114:	0f b6 00             	movzbl (%rax),%eax
   44117:	3c 2e                	cmp    $0x2e,%al
   44119:	0f 85 00 01 00 00    	jne    4421f <printer_vprintf+0x2dc>
            ++format;
   4411f:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44126:	01 
            if (*format >= '0' && *format <= '9') {
   44127:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4412e:	0f b6 00             	movzbl (%rax),%eax
   44131:	3c 2f                	cmp    $0x2f,%al
   44133:	7e 67                	jle    4419c <printer_vprintf+0x259>
   44135:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4413c:	0f b6 00             	movzbl (%rax),%eax
   4413f:	3c 39                	cmp    $0x39,%al
   44141:	7f 59                	jg     4419c <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   44143:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   4414a:	eb 2e                	jmp    4417a <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
   4414c:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   4414f:	89 d0                	mov    %edx,%eax
   44151:	c1 e0 02             	shl    $0x2,%eax
   44154:	01 d0                	add    %edx,%eax
   44156:	01 c0                	add    %eax,%eax
   44158:	89 c1                	mov    %eax,%ecx
   4415a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44161:	48 8d 50 01          	lea    0x1(%rax),%rdx
   44165:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   4416c:	0f b6 00             	movzbl (%rax),%eax
   4416f:	0f be c0             	movsbl %al,%eax
   44172:	01 c8                	add    %ecx,%eax
   44174:	83 e8 30             	sub    $0x30,%eax
   44177:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   4417a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44181:	0f b6 00             	movzbl (%rax),%eax
   44184:	3c 2f                	cmp    $0x2f,%al
   44186:	0f 8e 85 00 00 00    	jle    44211 <printer_vprintf+0x2ce>
   4418c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44193:	0f b6 00             	movzbl (%rax),%eax
   44196:	3c 39                	cmp    $0x39,%al
   44198:	7e b2                	jle    4414c <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
   4419a:	eb 75                	jmp    44211 <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
   4419c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   441a3:	0f b6 00             	movzbl (%rax),%eax
   441a6:	3c 2a                	cmp    $0x2a,%al
   441a8:	75 68                	jne    44212 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
   441aa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   441b1:	8b 00                	mov    (%rax),%eax
   441b3:	83 f8 2f             	cmp    $0x2f,%eax
   441b6:	77 30                	ja     441e8 <printer_vprintf+0x2a5>
   441b8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   441bf:	48 8b 50 10          	mov    0x10(%rax),%rdx
   441c3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   441ca:	8b 00                	mov    (%rax),%eax
   441cc:	89 c0                	mov    %eax,%eax
   441ce:	48 01 d0             	add    %rdx,%rax
   441d1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   441d8:	8b 12                	mov    (%rdx),%edx
   441da:	8d 4a 08             	lea    0x8(%rdx),%ecx
   441dd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   441e4:	89 0a                	mov    %ecx,(%rdx)
   441e6:	eb 1a                	jmp    44202 <printer_vprintf+0x2bf>
   441e8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   441ef:	48 8b 40 08          	mov    0x8(%rax),%rax
   441f3:	48 8d 48 08          	lea    0x8(%rax),%rcx
   441f7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   441fe:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44202:	8b 00                	mov    (%rax),%eax
   44204:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   44207:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4420e:	01 
   4420f:	eb 01                	jmp    44212 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
   44211:	90                   	nop
            }
            if (precision < 0) {
   44212:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   44216:	79 07                	jns    4421f <printer_vprintf+0x2dc>
                precision = 0;
   44218:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   4421f:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   44226:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   4422d:	00 
        int length = 0;
   4422e:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   44235:	48 c7 45 c8 a6 58 04 	movq   $0x458a6,-0x38(%rbp)
   4423c:	00 
    again:
        switch (*format) {
   4423d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44244:	0f b6 00             	movzbl (%rax),%eax
   44247:	0f be c0             	movsbl %al,%eax
   4424a:	83 e8 43             	sub    $0x43,%eax
   4424d:	83 f8 37             	cmp    $0x37,%eax
   44250:	0f 87 9f 03 00 00    	ja     445f5 <printer_vprintf+0x6b2>
   44256:	89 c0                	mov    %eax,%eax
   44258:	48 8b 04 c5 b8 58 04 	mov    0x458b8(,%rax,8),%rax
   4425f:	00 
   44260:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
   44262:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   44269:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44270:	01 
            goto again;
   44271:	eb ca                	jmp    4423d <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   44273:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   44277:	74 5d                	je     442d6 <printer_vprintf+0x393>
   44279:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44280:	8b 00                	mov    (%rax),%eax
   44282:	83 f8 2f             	cmp    $0x2f,%eax
   44285:	77 30                	ja     442b7 <printer_vprintf+0x374>
   44287:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4428e:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44292:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44299:	8b 00                	mov    (%rax),%eax
   4429b:	89 c0                	mov    %eax,%eax
   4429d:	48 01 d0             	add    %rdx,%rax
   442a0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442a7:	8b 12                	mov    (%rdx),%edx
   442a9:	8d 4a 08             	lea    0x8(%rdx),%ecx
   442ac:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442b3:	89 0a                	mov    %ecx,(%rdx)
   442b5:	eb 1a                	jmp    442d1 <printer_vprintf+0x38e>
   442b7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442be:	48 8b 40 08          	mov    0x8(%rax),%rax
   442c2:	48 8d 48 08          	lea    0x8(%rax),%rcx
   442c6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442cd:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   442d1:	48 8b 00             	mov    (%rax),%rax
   442d4:	eb 5c                	jmp    44332 <printer_vprintf+0x3ef>
   442d6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442dd:	8b 00                	mov    (%rax),%eax
   442df:	83 f8 2f             	cmp    $0x2f,%eax
   442e2:	77 30                	ja     44314 <printer_vprintf+0x3d1>
   442e4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442eb:	48 8b 50 10          	mov    0x10(%rax),%rdx
   442ef:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442f6:	8b 00                	mov    (%rax),%eax
   442f8:	89 c0                	mov    %eax,%eax
   442fa:	48 01 d0             	add    %rdx,%rax
   442fd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44304:	8b 12                	mov    (%rdx),%edx
   44306:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44309:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44310:	89 0a                	mov    %ecx,(%rdx)
   44312:	eb 1a                	jmp    4432e <printer_vprintf+0x3eb>
   44314:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4431b:	48 8b 40 08          	mov    0x8(%rax),%rax
   4431f:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44323:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4432a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4432e:	8b 00                	mov    (%rax),%eax
   44330:	48 98                	cltq   
   44332:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   44336:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4433a:	48 c1 f8 38          	sar    $0x38,%rax
   4433e:	25 80 00 00 00       	and    $0x80,%eax
   44343:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   44346:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   4434a:	74 09                	je     44355 <printer_vprintf+0x412>
   4434c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44350:	48 f7 d8             	neg    %rax
   44353:	eb 04                	jmp    44359 <printer_vprintf+0x416>
   44355:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44359:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   4435d:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   44360:	83 c8 60             	or     $0x60,%eax
   44363:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   44366:	e9 cf 02 00 00       	jmp    4463a <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   4436b:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   4436f:	74 5d                	je     443ce <printer_vprintf+0x48b>
   44371:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44378:	8b 00                	mov    (%rax),%eax
   4437a:	83 f8 2f             	cmp    $0x2f,%eax
   4437d:	77 30                	ja     443af <printer_vprintf+0x46c>
   4437f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44386:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4438a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44391:	8b 00                	mov    (%rax),%eax
   44393:	89 c0                	mov    %eax,%eax
   44395:	48 01 d0             	add    %rdx,%rax
   44398:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4439f:	8b 12                	mov    (%rdx),%edx
   443a1:	8d 4a 08             	lea    0x8(%rdx),%ecx
   443a4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   443ab:	89 0a                	mov    %ecx,(%rdx)
   443ad:	eb 1a                	jmp    443c9 <printer_vprintf+0x486>
   443af:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443b6:	48 8b 40 08          	mov    0x8(%rax),%rax
   443ba:	48 8d 48 08          	lea    0x8(%rax),%rcx
   443be:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   443c5:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   443c9:	48 8b 00             	mov    (%rax),%rax
   443cc:	eb 5c                	jmp    4442a <printer_vprintf+0x4e7>
   443ce:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443d5:	8b 00                	mov    (%rax),%eax
   443d7:	83 f8 2f             	cmp    $0x2f,%eax
   443da:	77 30                	ja     4440c <printer_vprintf+0x4c9>
   443dc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443e3:	48 8b 50 10          	mov    0x10(%rax),%rdx
   443e7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443ee:	8b 00                	mov    (%rax),%eax
   443f0:	89 c0                	mov    %eax,%eax
   443f2:	48 01 d0             	add    %rdx,%rax
   443f5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   443fc:	8b 12                	mov    (%rdx),%edx
   443fe:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44401:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44408:	89 0a                	mov    %ecx,(%rdx)
   4440a:	eb 1a                	jmp    44426 <printer_vprintf+0x4e3>
   4440c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44413:	48 8b 40 08          	mov    0x8(%rax),%rax
   44417:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4441b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44422:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44426:	8b 00                	mov    (%rax),%eax
   44428:	89 c0                	mov    %eax,%eax
   4442a:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   4442e:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   44432:	e9 03 02 00 00       	jmp    4463a <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
   44437:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   4443e:	e9 28 ff ff ff       	jmp    4436b <printer_vprintf+0x428>
        case 'X':
            base = 16;
   44443:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   4444a:	e9 1c ff ff ff       	jmp    4436b <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   4444f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44456:	8b 00                	mov    (%rax),%eax
   44458:	83 f8 2f             	cmp    $0x2f,%eax
   4445b:	77 30                	ja     4448d <printer_vprintf+0x54a>
   4445d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44464:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44468:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4446f:	8b 00                	mov    (%rax),%eax
   44471:	89 c0                	mov    %eax,%eax
   44473:	48 01 d0             	add    %rdx,%rax
   44476:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4447d:	8b 12                	mov    (%rdx),%edx
   4447f:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44482:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44489:	89 0a                	mov    %ecx,(%rdx)
   4448b:	eb 1a                	jmp    444a7 <printer_vprintf+0x564>
   4448d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44494:	48 8b 40 08          	mov    0x8(%rax),%rax
   44498:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4449c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   444a3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   444a7:	48 8b 00             	mov    (%rax),%rax
   444aa:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   444ae:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   444b5:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   444bc:	e9 79 01 00 00       	jmp    4463a <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
   444c1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444c8:	8b 00                	mov    (%rax),%eax
   444ca:	83 f8 2f             	cmp    $0x2f,%eax
   444cd:	77 30                	ja     444ff <printer_vprintf+0x5bc>
   444cf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444d6:	48 8b 50 10          	mov    0x10(%rax),%rdx
   444da:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444e1:	8b 00                	mov    (%rax),%eax
   444e3:	89 c0                	mov    %eax,%eax
   444e5:	48 01 d0             	add    %rdx,%rax
   444e8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   444ef:	8b 12                	mov    (%rdx),%edx
   444f1:	8d 4a 08             	lea    0x8(%rdx),%ecx
   444f4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   444fb:	89 0a                	mov    %ecx,(%rdx)
   444fd:	eb 1a                	jmp    44519 <printer_vprintf+0x5d6>
   444ff:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44506:	48 8b 40 08          	mov    0x8(%rax),%rax
   4450a:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4450e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44515:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44519:	48 8b 00             	mov    (%rax),%rax
   4451c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   44520:	e9 15 01 00 00       	jmp    4463a <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
   44525:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4452c:	8b 00                	mov    (%rax),%eax
   4452e:	83 f8 2f             	cmp    $0x2f,%eax
   44531:	77 30                	ja     44563 <printer_vprintf+0x620>
   44533:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4453a:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4453e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44545:	8b 00                	mov    (%rax),%eax
   44547:	89 c0                	mov    %eax,%eax
   44549:	48 01 d0             	add    %rdx,%rax
   4454c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44553:	8b 12                	mov    (%rdx),%edx
   44555:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44558:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4455f:	89 0a                	mov    %ecx,(%rdx)
   44561:	eb 1a                	jmp    4457d <printer_vprintf+0x63a>
   44563:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4456a:	48 8b 40 08          	mov    0x8(%rax),%rax
   4456e:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44572:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44579:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4457d:	8b 00                	mov    (%rax),%eax
   4457f:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   44585:	e9 67 03 00 00       	jmp    448f1 <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
   4458a:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   4458e:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   44592:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44599:	8b 00                	mov    (%rax),%eax
   4459b:	83 f8 2f             	cmp    $0x2f,%eax
   4459e:	77 30                	ja     445d0 <printer_vprintf+0x68d>
   445a0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445a7:	48 8b 50 10          	mov    0x10(%rax),%rdx
   445ab:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445b2:	8b 00                	mov    (%rax),%eax
   445b4:	89 c0                	mov    %eax,%eax
   445b6:	48 01 d0             	add    %rdx,%rax
   445b9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445c0:	8b 12                	mov    (%rdx),%edx
   445c2:	8d 4a 08             	lea    0x8(%rdx),%ecx
   445c5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445cc:	89 0a                	mov    %ecx,(%rdx)
   445ce:	eb 1a                	jmp    445ea <printer_vprintf+0x6a7>
   445d0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445d7:	48 8b 40 08          	mov    0x8(%rax),%rax
   445db:	48 8d 48 08          	lea    0x8(%rax),%rcx
   445df:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445e6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   445ea:	8b 00                	mov    (%rax),%eax
   445ec:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   445ef:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   445f3:	eb 45                	jmp    4463a <printer_vprintf+0x6f7>
        default:
            data = numbuf;
   445f5:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   445f9:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   445fd:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44604:	0f b6 00             	movzbl (%rax),%eax
   44607:	84 c0                	test   %al,%al
   44609:	74 0c                	je     44617 <printer_vprintf+0x6d4>
   4460b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44612:	0f b6 00             	movzbl (%rax),%eax
   44615:	eb 05                	jmp    4461c <printer_vprintf+0x6d9>
   44617:	b8 25 00 00 00       	mov    $0x25,%eax
   4461c:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   4461f:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   44623:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4462a:	0f b6 00             	movzbl (%rax),%eax
   4462d:	84 c0                	test   %al,%al
   4462f:	75 08                	jne    44639 <printer_vprintf+0x6f6>
                format--;
   44631:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   44638:	01 
            }
            break;
   44639:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   4463a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4463d:	83 e0 20             	and    $0x20,%eax
   44640:	85 c0                	test   %eax,%eax
   44642:	74 1e                	je     44662 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   44644:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   44648:	48 83 c0 18          	add    $0x18,%rax
   4464c:	8b 55 e0             	mov    -0x20(%rbp),%edx
   4464f:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   44653:	48 89 ce             	mov    %rcx,%rsi
   44656:	48 89 c7             	mov    %rax,%rdi
   44659:	e8 63 f8 ff ff       	call   43ec1 <fill_numbuf>
   4465e:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   44662:	48 c7 45 c0 a6 58 04 	movq   $0x458a6,-0x40(%rbp)
   44669:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   4466a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4466d:	83 e0 20             	and    $0x20,%eax
   44670:	85 c0                	test   %eax,%eax
   44672:	74 48                	je     446bc <printer_vprintf+0x779>
   44674:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44677:	83 e0 40             	and    $0x40,%eax
   4467a:	85 c0                	test   %eax,%eax
   4467c:	74 3e                	je     446bc <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
   4467e:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44681:	25 80 00 00 00       	and    $0x80,%eax
   44686:	85 c0                	test   %eax,%eax
   44688:	74 0a                	je     44694 <printer_vprintf+0x751>
                prefix = "-";
   4468a:	48 c7 45 c0 a7 58 04 	movq   $0x458a7,-0x40(%rbp)
   44691:	00 
            if (flags & FLAG_NEGATIVE) {
   44692:	eb 73                	jmp    44707 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   44694:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44697:	83 e0 10             	and    $0x10,%eax
   4469a:	85 c0                	test   %eax,%eax
   4469c:	74 0a                	je     446a8 <printer_vprintf+0x765>
                prefix = "+";
   4469e:	48 c7 45 c0 a9 58 04 	movq   $0x458a9,-0x40(%rbp)
   446a5:	00 
            if (flags & FLAG_NEGATIVE) {
   446a6:	eb 5f                	jmp    44707 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   446a8:	8b 45 ec             	mov    -0x14(%rbp),%eax
   446ab:	83 e0 08             	and    $0x8,%eax
   446ae:	85 c0                	test   %eax,%eax
   446b0:	74 55                	je     44707 <printer_vprintf+0x7c4>
                prefix = " ";
   446b2:	48 c7 45 c0 ab 58 04 	movq   $0x458ab,-0x40(%rbp)
   446b9:	00 
            if (flags & FLAG_NEGATIVE) {
   446ba:	eb 4b                	jmp    44707 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   446bc:	8b 45 ec             	mov    -0x14(%rbp),%eax
   446bf:	83 e0 20             	and    $0x20,%eax
   446c2:	85 c0                	test   %eax,%eax
   446c4:	74 42                	je     44708 <printer_vprintf+0x7c5>
   446c6:	8b 45 ec             	mov    -0x14(%rbp),%eax
   446c9:	83 e0 01             	and    $0x1,%eax
   446cc:	85 c0                	test   %eax,%eax
   446ce:	74 38                	je     44708 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
   446d0:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   446d4:	74 06                	je     446dc <printer_vprintf+0x799>
   446d6:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   446da:	75 2c                	jne    44708 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
   446dc:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   446e1:	75 0c                	jne    446ef <printer_vprintf+0x7ac>
   446e3:	8b 45 ec             	mov    -0x14(%rbp),%eax
   446e6:	25 00 01 00 00       	and    $0x100,%eax
   446eb:	85 c0                	test   %eax,%eax
   446ed:	74 19                	je     44708 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
   446ef:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   446f3:	75 07                	jne    446fc <printer_vprintf+0x7b9>
   446f5:	b8 ad 58 04 00       	mov    $0x458ad,%eax
   446fa:	eb 05                	jmp    44701 <printer_vprintf+0x7be>
   446fc:	b8 b0 58 04 00       	mov    $0x458b0,%eax
   44701:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   44705:	eb 01                	jmp    44708 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
   44707:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   44708:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   4470c:	78 24                	js     44732 <printer_vprintf+0x7ef>
   4470e:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44711:	83 e0 20             	and    $0x20,%eax
   44714:	85 c0                	test   %eax,%eax
   44716:	75 1a                	jne    44732 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
   44718:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4471b:	48 63 d0             	movslq %eax,%rdx
   4471e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44722:	48 89 d6             	mov    %rdx,%rsi
   44725:	48 89 c7             	mov    %rax,%rdi
   44728:	e8 ea f5 ff ff       	call   43d17 <strnlen>
   4472d:	89 45 bc             	mov    %eax,-0x44(%rbp)
   44730:	eb 0f                	jmp    44741 <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
   44732:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44736:	48 89 c7             	mov    %rax,%rdi
   44739:	e8 a8 f5 ff ff       	call   43ce6 <strlen>
   4473e:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   44741:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44744:	83 e0 20             	and    $0x20,%eax
   44747:	85 c0                	test   %eax,%eax
   44749:	74 20                	je     4476b <printer_vprintf+0x828>
   4474b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   4474f:	78 1a                	js     4476b <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
   44751:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44754:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   44757:	7e 08                	jle    44761 <printer_vprintf+0x81e>
   44759:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4475c:	2b 45 bc             	sub    -0x44(%rbp),%eax
   4475f:	eb 05                	jmp    44766 <printer_vprintf+0x823>
   44761:	b8 00 00 00 00       	mov    $0x0,%eax
   44766:	89 45 b8             	mov    %eax,-0x48(%rbp)
   44769:	eb 5c                	jmp    447c7 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   4476b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4476e:	83 e0 20             	and    $0x20,%eax
   44771:	85 c0                	test   %eax,%eax
   44773:	74 4b                	je     447c0 <printer_vprintf+0x87d>
   44775:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44778:	83 e0 02             	and    $0x2,%eax
   4477b:	85 c0                	test   %eax,%eax
   4477d:	74 41                	je     447c0 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
   4477f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44782:	83 e0 04             	and    $0x4,%eax
   44785:	85 c0                	test   %eax,%eax
   44787:	75 37                	jne    447c0 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
   44789:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4478d:	48 89 c7             	mov    %rax,%rdi
   44790:	e8 51 f5 ff ff       	call   43ce6 <strlen>
   44795:	89 c2                	mov    %eax,%edx
   44797:	8b 45 bc             	mov    -0x44(%rbp),%eax
   4479a:	01 d0                	add    %edx,%eax
   4479c:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   4479f:	7e 1f                	jle    447c0 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
   447a1:	8b 45 e8             	mov    -0x18(%rbp),%eax
   447a4:	2b 45 bc             	sub    -0x44(%rbp),%eax
   447a7:	89 c3                	mov    %eax,%ebx
   447a9:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   447ad:	48 89 c7             	mov    %rax,%rdi
   447b0:	e8 31 f5 ff ff       	call   43ce6 <strlen>
   447b5:	89 c2                	mov    %eax,%edx
   447b7:	89 d8                	mov    %ebx,%eax
   447b9:	29 d0                	sub    %edx,%eax
   447bb:	89 45 b8             	mov    %eax,-0x48(%rbp)
   447be:	eb 07                	jmp    447c7 <printer_vprintf+0x884>
        } else {
            zeros = 0;
   447c0:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   447c7:	8b 55 bc             	mov    -0x44(%rbp),%edx
   447ca:	8b 45 b8             	mov    -0x48(%rbp),%eax
   447cd:	01 d0                	add    %edx,%eax
   447cf:	48 63 d8             	movslq %eax,%rbx
   447d2:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   447d6:	48 89 c7             	mov    %rax,%rdi
   447d9:	e8 08 f5 ff ff       	call   43ce6 <strlen>
   447de:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   447e2:	8b 45 e8             	mov    -0x18(%rbp),%eax
   447e5:	29 d0                	sub    %edx,%eax
   447e7:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   447ea:	eb 25                	jmp    44811 <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
   447ec:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   447f3:	48 8b 08             	mov    (%rax),%rcx
   447f6:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   447fc:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44803:	be 20 00 00 00       	mov    $0x20,%esi
   44808:	48 89 c7             	mov    %rax,%rdi
   4480b:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   4480d:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   44811:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44814:	83 e0 04             	and    $0x4,%eax
   44817:	85 c0                	test   %eax,%eax
   44819:	75 36                	jne    44851 <printer_vprintf+0x90e>
   4481b:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   4481f:	7f cb                	jg     447ec <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
   44821:	eb 2e                	jmp    44851 <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
   44823:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4482a:	4c 8b 00             	mov    (%rax),%r8
   4482d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44831:	0f b6 00             	movzbl (%rax),%eax
   44834:	0f b6 c8             	movzbl %al,%ecx
   44837:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   4483d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44844:	89 ce                	mov    %ecx,%esi
   44846:	48 89 c7             	mov    %rax,%rdi
   44849:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   4484c:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   44851:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44855:	0f b6 00             	movzbl (%rax),%eax
   44858:	84 c0                	test   %al,%al
   4485a:	75 c7                	jne    44823 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
   4485c:	eb 25                	jmp    44883 <printer_vprintf+0x940>
            p->putc(p, '0', color);
   4485e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44865:	48 8b 08             	mov    (%rax),%rcx
   44868:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   4486e:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44875:	be 30 00 00 00       	mov    $0x30,%esi
   4487a:	48 89 c7             	mov    %rax,%rdi
   4487d:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   4487f:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   44883:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   44887:	7f d5                	jg     4485e <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
   44889:	eb 32                	jmp    448bd <printer_vprintf+0x97a>
            p->putc(p, *data, color);
   4488b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44892:	4c 8b 00             	mov    (%rax),%r8
   44895:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44899:	0f b6 00             	movzbl (%rax),%eax
   4489c:	0f b6 c8             	movzbl %al,%ecx
   4489f:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   448a5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   448ac:	89 ce                	mov    %ecx,%esi
   448ae:	48 89 c7             	mov    %rax,%rdi
   448b1:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   448b4:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   448b9:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   448bd:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   448c1:	7f c8                	jg     4488b <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
   448c3:	eb 25                	jmp    448ea <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
   448c5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   448cc:	48 8b 08             	mov    (%rax),%rcx
   448cf:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   448d5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   448dc:	be 20 00 00 00       	mov    $0x20,%esi
   448e1:	48 89 c7             	mov    %rax,%rdi
   448e4:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   448e6:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   448ea:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   448ee:	7f d5                	jg     448c5 <printer_vprintf+0x982>
        }
    done: ;
   448f0:	90                   	nop
    for (; *format; ++format) {
   448f1:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   448f8:	01 
   448f9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44900:	0f b6 00             	movzbl (%rax),%eax
   44903:	84 c0                	test   %al,%al
   44905:	0f 85 64 f6 ff ff    	jne    43f6f <printer_vprintf+0x2c>
    }
}
   4490b:	90                   	nop
   4490c:	90                   	nop
   4490d:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   44911:	c9                   	leave  
   44912:	c3                   	ret    

0000000000044913 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   44913:	55                   	push   %rbp
   44914:	48 89 e5             	mov    %rsp,%rbp
   44917:	48 83 ec 20          	sub    $0x20,%rsp
   4491b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4491f:	89 f0                	mov    %esi,%eax
   44921:	89 55 e0             	mov    %edx,-0x20(%rbp)
   44924:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   44927:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4492b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   4492f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44933:	48 8b 40 08          	mov    0x8(%rax),%rax
   44937:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
   4493c:	48 39 d0             	cmp    %rdx,%rax
   4493f:	72 0c                	jb     4494d <console_putc+0x3a>
        cp->cursor = console;
   44941:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44945:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
   4494c:	00 
    }
    if (c == '\n') {
   4494d:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   44951:	75 78                	jne    449cb <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
   44953:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44957:	48 8b 40 08          	mov    0x8(%rax),%rax
   4495b:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   44961:	48 d1 f8             	sar    %rax
   44964:	48 89 c1             	mov    %rax,%rcx
   44967:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   4496e:	66 66 66 
   44971:	48 89 c8             	mov    %rcx,%rax
   44974:	48 f7 ea             	imul   %rdx
   44977:	48 c1 fa 05          	sar    $0x5,%rdx
   4497b:	48 89 c8             	mov    %rcx,%rax
   4497e:	48 c1 f8 3f          	sar    $0x3f,%rax
   44982:	48 29 c2             	sub    %rax,%rdx
   44985:	48 89 d0             	mov    %rdx,%rax
   44988:	48 c1 e0 02          	shl    $0x2,%rax
   4498c:	48 01 d0             	add    %rdx,%rax
   4498f:	48 c1 e0 04          	shl    $0x4,%rax
   44993:	48 29 c1             	sub    %rax,%rcx
   44996:	48 89 ca             	mov    %rcx,%rdx
   44999:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   4499c:	eb 25                	jmp    449c3 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
   4499e:	8b 45 e0             	mov    -0x20(%rbp),%eax
   449a1:	83 c8 20             	or     $0x20,%eax
   449a4:	89 c6                	mov    %eax,%esi
   449a6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   449aa:	48 8b 40 08          	mov    0x8(%rax),%rax
   449ae:	48 8d 48 02          	lea    0x2(%rax),%rcx
   449b2:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   449b6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   449ba:	89 f2                	mov    %esi,%edx
   449bc:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   449bf:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   449c3:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   449c7:	75 d5                	jne    4499e <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   449c9:	eb 24                	jmp    449ef <console_putc+0xdc>
        *cp->cursor++ = c | color;
   449cb:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
   449cf:	8b 55 e0             	mov    -0x20(%rbp),%edx
   449d2:	09 d0                	or     %edx,%eax
   449d4:	89 c6                	mov    %eax,%esi
   449d6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   449da:	48 8b 40 08          	mov    0x8(%rax),%rax
   449de:	48 8d 48 02          	lea    0x2(%rax),%rcx
   449e2:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   449e6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   449ea:	89 f2                	mov    %esi,%edx
   449ec:	66 89 10             	mov    %dx,(%rax)
}
   449ef:	90                   	nop
   449f0:	c9                   	leave  
   449f1:	c3                   	ret    

00000000000449f2 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   449f2:	55                   	push   %rbp
   449f3:	48 89 e5             	mov    %rsp,%rbp
   449f6:	48 83 ec 30          	sub    $0x30,%rsp
   449fa:	89 7d ec             	mov    %edi,-0x14(%rbp)
   449fd:	89 75 e8             	mov    %esi,-0x18(%rbp)
   44a00:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   44a04:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   44a08:	48 c7 45 f0 13 49 04 	movq   $0x44913,-0x10(%rbp)
   44a0f:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   44a10:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   44a14:	78 09                	js     44a1f <console_vprintf+0x2d>
   44a16:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   44a1d:	7e 07                	jle    44a26 <console_vprintf+0x34>
        cpos = 0;
   44a1f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   44a26:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44a29:	48 98                	cltq   
   44a2b:	48 01 c0             	add    %rax,%rax
   44a2e:	48 05 00 80 0b 00    	add    $0xb8000,%rax
   44a34:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   44a38:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   44a3c:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   44a40:	8b 75 e8             	mov    -0x18(%rbp),%esi
   44a43:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   44a47:	48 89 c7             	mov    %rax,%rdi
   44a4a:	e8 f4 f4 ff ff       	call   43f43 <printer_vprintf>
    return cp.cursor - console;
   44a4f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44a53:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   44a59:	48 d1 f8             	sar    %rax
}
   44a5c:	c9                   	leave  
   44a5d:	c3                   	ret    

0000000000044a5e <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   44a5e:	55                   	push   %rbp
   44a5f:	48 89 e5             	mov    %rsp,%rbp
   44a62:	48 83 ec 60          	sub    $0x60,%rsp
   44a66:	89 7d ac             	mov    %edi,-0x54(%rbp)
   44a69:	89 75 a8             	mov    %esi,-0x58(%rbp)
   44a6c:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   44a70:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44a74:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44a78:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44a7c:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   44a83:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44a87:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   44a8b:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44a8f:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   44a93:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   44a97:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   44a9b:	8b 75 a8             	mov    -0x58(%rbp),%esi
   44a9e:	8b 45 ac             	mov    -0x54(%rbp),%eax
   44aa1:	89 c7                	mov    %eax,%edi
   44aa3:	e8 4a ff ff ff       	call   449f2 <console_vprintf>
   44aa8:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   44aab:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   44aae:	c9                   	leave  
   44aaf:	c3                   	ret    

0000000000044ab0 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   44ab0:	55                   	push   %rbp
   44ab1:	48 89 e5             	mov    %rsp,%rbp
   44ab4:	48 83 ec 20          	sub    $0x20,%rsp
   44ab8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44abc:	89 f0                	mov    %esi,%eax
   44abe:	89 55 e0             	mov    %edx,-0x20(%rbp)
   44ac1:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   44ac4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44ac8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   44acc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44ad0:	48 8b 50 08          	mov    0x8(%rax),%rdx
   44ad4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44ad8:	48 8b 40 10          	mov    0x10(%rax),%rax
   44adc:	48 39 c2             	cmp    %rax,%rdx
   44adf:	73 1a                	jae    44afb <string_putc+0x4b>
        *sp->s++ = c;
   44ae1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44ae5:	48 8b 40 08          	mov    0x8(%rax),%rax
   44ae9:	48 8d 48 01          	lea    0x1(%rax),%rcx
   44aed:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   44af1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44af5:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   44af9:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   44afb:	90                   	nop
   44afc:	c9                   	leave  
   44afd:	c3                   	ret    

0000000000044afe <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   44afe:	55                   	push   %rbp
   44aff:	48 89 e5             	mov    %rsp,%rbp
   44b02:	48 83 ec 40          	sub    $0x40,%rsp
   44b06:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   44b0a:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   44b0e:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   44b12:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   44b16:	48 c7 45 e8 b0 4a 04 	movq   $0x44ab0,-0x18(%rbp)
   44b1d:	00 
    sp.s = s;
   44b1e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44b22:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   44b26:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   44b2b:	74 33                	je     44b60 <vsnprintf+0x62>
        sp.end = s + size - 1;
   44b2d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   44b31:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   44b35:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44b39:	48 01 d0             	add    %rdx,%rax
   44b3c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   44b40:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   44b44:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   44b48:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   44b4c:	be 00 00 00 00       	mov    $0x0,%esi
   44b51:	48 89 c7             	mov    %rax,%rdi
   44b54:	e8 ea f3 ff ff       	call   43f43 <printer_vprintf>
        *sp.s = 0;
   44b59:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44b5d:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   44b60:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44b64:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   44b68:	c9                   	leave  
   44b69:	c3                   	ret    

0000000000044b6a <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   44b6a:	55                   	push   %rbp
   44b6b:	48 89 e5             	mov    %rsp,%rbp
   44b6e:	48 83 ec 70          	sub    $0x70,%rsp
   44b72:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   44b76:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   44b7a:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   44b7e:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44b82:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44b86:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44b8a:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   44b91:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44b95:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   44b99:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44b9d:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   44ba1:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   44ba5:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   44ba9:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   44bad:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44bb1:	48 89 c7             	mov    %rax,%rdi
   44bb4:	e8 45 ff ff ff       	call   44afe <vsnprintf>
   44bb9:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   44bbc:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   44bbf:	c9                   	leave  
   44bc0:	c3                   	ret    

0000000000044bc1 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   44bc1:	55                   	push   %rbp
   44bc2:	48 89 e5             	mov    %rsp,%rbp
   44bc5:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44bc9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   44bd0:	eb 13                	jmp    44be5 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
   44bd2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   44bd5:	48 98                	cltq   
   44bd7:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
   44bde:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44be1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44be5:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   44bec:	7e e4                	jle    44bd2 <console_clear+0x11>
    }
    cursorpos = 0;
   44bee:	c7 05 04 44 07 00 00 	movl   $0x0,0x74404(%rip)        # b8ffc <cursorpos>
   44bf5:	00 00 00 
}
   44bf8:	90                   	nop
   44bf9:	c9                   	leave  
   44bfa:	c3                   	ret    
