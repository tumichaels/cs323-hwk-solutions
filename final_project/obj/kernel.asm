
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
   400be:	e8 99 06 00 00       	call   4075c <exception>

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
   40173:	e8 86 14 00 00       	call   415fe <hardware_init>
    pageinfo_init();
   40178:	e8 fa 0a 00 00       	call   40c77 <pageinfo_init>
    console_clear();
   4017d:	e8 24 4a 00 00       	call   44ba6 <console_clear>
    timer_init(HZ);
   40182:	bf 64 00 00 00       	mov    $0x64,%edi
   40187:	e8 5e 19 00 00       	call   41aea <timer_init>

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   4018c:	ba 00 0f 00 00       	mov    $0xf00,%edx
   40191:	be 00 00 00 00       	mov    $0x0,%esi
   40196:	bf 00 f0 04 00       	mov    $0x4f000,%edi
   4019b:	e8 ec 3a 00 00       	call   43c8c <memset>
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
   401fe:	be 06 4c 04 00       	mov    $0x44c06,%esi
   40203:	48 89 c7             	mov    %rax,%rdi
   40206:	e8 7a 3b 00 00       	call   43d85 <strcmp>
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
   4022e:	be 0d 4c 04 00       	mov    $0x44c0d,%esi
   40233:	48 89 c7             	mov    %rax,%rdi
   40236:	e8 4a 3b 00 00       	call   43d85 <strcmp>
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
   4025b:	be 18 4c 04 00       	mov    $0x44c18,%esi
   40260:	48 89 c7             	mov    %rax,%rdi
   40263:	e8 1d 3b 00 00       	call   43d85 <strcmp>
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
   40288:	be 1d 4c 04 00       	mov    $0x44c1d,%esi
   4028d:	48 89 c7             	mov    %rax,%rdi
   40290:	e8 f0 3a 00 00       	call   43d85 <strcmp>
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
   402d1:	e8 10 09 00 00       	call   40be6 <run>

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
   40306:	e8 70 1a 00 00       	call   41d7b <process_init>
    assert(process_config_tables(pid) == 0);
   4030b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4030e:	89 c7                	mov    %eax,%edi
   40310:	e8 40 31 00 00       	call   43455 <process_config_tables>
   40315:	85 c0                	test   %eax,%eax
   40317:	74 14                	je     4032d <process_setup+0x57>
   40319:	ba 28 4c 04 00       	mov    $0x44c28,%edx
   4031e:	be 77 00 00 00       	mov    $0x77,%esi
   40323:	bf 48 4c 04 00       	mov    $0x44c48,%edi
   40328:	e8 1c 22 00 00       	call   42549 <assert_fail>

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
   40350:	e8 4e 34 00 00       	call   437a3 <process_load>
   40355:	85 c0                	test   %eax,%eax
   40357:	79 14                	jns    4036d <process_setup+0x97>
   40359:	ba 58 4c 04 00       	mov    $0x44c58,%edx
   4035e:	be 7a 00 00 00       	mov    $0x7a,%esi
   40363:	bf 48 4c 04 00       	mov    $0x44c48,%edi
   40368:	e8 dc 21 00 00       	call   42549 <assert_fail>

    process_setup_stack(&processes[pid]);
   4036d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40370:	48 63 d0             	movslq %eax,%rdx
   40373:	48 89 d0             	mov    %rdx,%rax
   40376:	48 c1 e0 04          	shl    $0x4,%rax
   4037a:	48 29 d0             	sub    %rdx,%rax
   4037d:	48 c1 e0 04          	shl    $0x4,%rax
   40381:	48 05 00 f0 04 00    	add    $0x4f000,%rax
   40387:	48 89 c7             	mov    %rax,%rdi
   4038a:	e8 4c 34 00 00       	call   437db <process_setup_stack>

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
   40434:	e8 55 34 00 00       	call   4388e <process_fork>
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
   4044a:	e8 24 2d 00 00       	call   43173 <process_free>
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
   4046f:	e8 ac 36 00 00       	call   43b20 <process_page_alloc>
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
		for (uintptr_t va = oldbrk; va >= newbrk; va -= PAGESIZE) {
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
   40510:	e8 f6 26 00 00       	call   42c0b <virtual_memory_lookup>
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
   40546:	e8 fd 22 00 00       	call   42848 <virtual_memory_map>
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
		for (uintptr_t va = oldbrk; va >= newbrk; va -= PAGESIZE) {
   40583:	48 81 6d f8 00 10 00 	subq   $0x1000,-0x8(%rbp)
   4058a:	00 
   4058b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4058f:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   40593:	0f 83 5e ff ff ff    	jae    404f7 <brk+0x81>
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
	// log_printf("sbsbrk(ALIGN(info->num_allocs * sizeof(void *) + OVERHEAD));rk was used\n");
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
   405f4:	74 07                	je     405fd <sbrk+0x45>
	    // brk already sets registers to -1 on failure
	    return -1;
   405f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   405fb:	eb 11                	jmp    4060e <sbrk+0x56>
    }
    p->p_registers.reg_rax = oldbrk;
   405fd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40601:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40605:	48 89 50 18          	mov    %rdx,0x18(%rax)
    return 0;
   40609:	b8 00 00 00 00       	mov    $0x0,%eax
}
   4060e:	c9                   	leave  
   4060f:	c3                   	ret    

0000000000040610 <syscall_mapping>:


void syscall_mapping(proc* p){
   40610:	55                   	push   %rbp
   40611:	48 89 e5             	mov    %rsp,%rbp
   40614:	48 83 ec 70          	sub    $0x70,%rsp
   40618:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)
    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
   4061c:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40620:	48 8b 40 48          	mov    0x48(%rax),%rax
   40624:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t ptr = p->p_registers.reg_rsi;
   40628:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4062c:	48 8b 40 40          	mov    0x40(%rax),%rax
   40630:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    //convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);
   40634:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40638:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   4063f:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   40643:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40647:	48 89 ce             	mov    %rcx,%rsi
   4064a:	48 89 c7             	mov    %rax,%rdi
   4064d:	e8 b9 25 00 00       	call   42c0b <virtual_memory_lookup>

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
   40652:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40655:	48 98                	cltq   
   40657:	83 e0 06             	and    $0x6,%eax
   4065a:	48 83 f8 06          	cmp    $0x6,%rax
   4065e:	0f 85 89 00 00 00    	jne    406ed <syscall_mapping+0xdd>
        return;
    uintptr_t endaddr = mapping_ptr + sizeof(vamapping) - 1;
   40664:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40668:	48 83 c0 17          	add    $0x17,%rax
   4066c:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    if (PAGENUMBER(endaddr) != PAGENUMBER(ptr)){
   40670:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40674:	48 c1 e8 0c          	shr    $0xc,%rax
   40678:	89 c2                	mov    %eax,%edx
   4067a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4067e:	48 c1 e8 0c          	shr    $0xc,%rax
   40682:	39 c2                	cmp    %eax,%edx
   40684:	74 2c                	je     406b2 <syscall_mapping+0xa2>
        vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
   40686:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4068a:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40691:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40695:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   40699:	48 89 ce             	mov    %rcx,%rsi
   4069c:	48 89 c7             	mov    %rax,%rdi
   4069f:	e8 67 25 00 00       	call   42c0b <virtual_memory_lookup>
        // check for write access for end address
        if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
   406a4:	8b 45 b0             	mov    -0x50(%rbp),%eax
   406a7:	48 98                	cltq   
   406a9:	83 e0 03             	and    $0x3,%eax
   406ac:	48 83 f8 03          	cmp    $0x3,%rax
   406b0:	75 3e                	jne    406f0 <syscall_mapping+0xe0>
            return; 
    }
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
   406b2:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   406b6:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   406bd:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   406c1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   406c5:	48 89 ce             	mov    %rcx,%rsi
   406c8:	48 89 c7             	mov    %rax,%rdi
   406cb:	e8 3b 25 00 00       	call   42c0b <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   406d0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   406d4:	48 89 c1             	mov    %rax,%rcx
   406d7:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   406db:	ba 18 00 00 00       	mov    $0x18,%edx
   406e0:	48 89 c6             	mov    %rax,%rsi
   406e3:	48 89 cf             	mov    %rcx,%rdi
   406e6:	e8 a3 34 00 00       	call   43b8e <memcpy>
   406eb:	eb 04                	jmp    406f1 <syscall_mapping+0xe1>
        return;
   406ed:	90                   	nop
   406ee:	eb 01                	jmp    406f1 <syscall_mapping+0xe1>
            return; 
   406f0:	90                   	nop
}
   406f1:	c9                   	leave  
   406f2:	c3                   	ret    

00000000000406f3 <syscall_mem_tog>:

void syscall_mem_tog(proc* process){
   406f3:	55                   	push   %rbp
   406f4:	48 89 e5             	mov    %rsp,%rbp
   406f7:	48 83 ec 18          	sub    $0x18,%rsp
   406fb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)

    pid_t p = process->p_registers.reg_rdi;
   406ff:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40703:	48 8b 40 48          	mov    0x48(%rax),%rax
   40707:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(p == 0) {
   4070a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4070e:	75 14                	jne    40724 <syscall_mem_tog+0x31>
        disp_global = !disp_global;
   40710:	0f b6 05 e9 58 00 00 	movzbl 0x58e9(%rip),%eax        # 46000 <disp_global>
   40717:	84 c0                	test   %al,%al
   40719:	0f 94 c0             	sete   %al
   4071c:	88 05 de 58 00 00    	mov    %al,0x58de(%rip)        # 46000 <disp_global>
   40722:	eb 36                	jmp    4075a <syscall_mem_tog+0x67>
    }
    else {
        if(p < 0 || p > NPROC || p != process->p_pid)
   40724:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   40728:	78 2f                	js     40759 <syscall_mem_tog+0x66>
   4072a:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   4072e:	7f 29                	jg     40759 <syscall_mem_tog+0x66>
   40730:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40734:	8b 00                	mov    (%rax),%eax
   40736:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   40739:	75 1e                	jne    40759 <syscall_mem_tog+0x66>
            return;
        process->display_status = !(process->display_status);
   4073b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4073f:	0f b6 80 e8 00 00 00 	movzbl 0xe8(%rax),%eax
   40746:	84 c0                	test   %al,%al
   40748:	0f 94 c0             	sete   %al
   4074b:	89 c2                	mov    %eax,%edx
   4074d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40751:	88 90 e8 00 00 00    	mov    %dl,0xe8(%rax)
   40757:	eb 01                	jmp    4075a <syscall_mem_tog+0x67>
            return;
   40759:	90                   	nop
    }
}
   4075a:	c9                   	leave  
   4075b:	c3                   	ret    

000000000004075c <exception>:
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_64_registers* reg) {
   4075c:	55                   	push   %rbp
   4075d:	48 89 e5             	mov    %rsp,%rbp
   40760:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
   40767:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   4076e:	48 8b 05 8b f7 00 00 	mov    0xf78b(%rip),%rax        # 4ff00 <current>
   40775:	48 8b 95 08 ff ff ff 	mov    -0xf8(%rbp),%rdx
   4077c:	48 83 c0 18          	add    $0x18,%rax
   40780:	48 89 d6             	mov    %rdx,%rsi
   40783:	ba 18 00 00 00       	mov    $0x18,%edx
   40788:	48 89 c7             	mov    %rax,%rdi
   4078b:	48 89 d1             	mov    %rdx,%rcx
   4078e:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   40791:	48 8b 05 68 18 01 00 	mov    0x11868(%rip),%rax        # 52000 <kernel_pagetable>
   40798:	48 89 c7             	mov    %rax,%rdi
   4079b:	e8 77 1f 00 00       	call   42717 <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   407a0:	8b 05 56 88 07 00    	mov    0x78856(%rip),%eax        # b8ffc <cursorpos>
   407a6:	89 c7                	mov    %eax,%edi
   407a8:	e8 98 16 00 00       	call   41e45 <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT
   407ad:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   407b4:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   407bb:	48 83 f8 0e          	cmp    $0xe,%rax
   407bf:	74 14                	je     407d5 <exception+0x79>
	    && reg->reg_intno != INT_GPF)
   407c1:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   407c8:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   407cf:	48 83 f8 0d          	cmp    $0xd,%rax
   407d3:	75 16                	jne    407eb <exception+0x8f>
            || (reg->reg_err & PFERR_USER)) {
   407d5:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   407dc:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   407e3:	83 e0 04             	and    $0x4,%eax
   407e6:	48 85 c0             	test   %rax,%rax
   407e9:	74 1a                	je     40805 <exception+0xa9>
        check_virtual_memory();
   407eb:	e8 1e 08 00 00       	call   4100e <check_virtual_memory>
        if(disp_global){
   407f0:	0f b6 05 09 58 00 00 	movzbl 0x5809(%rip),%eax        # 46000 <disp_global>
   407f7:	84 c0                	test   %al,%al
   407f9:	74 0a                	je     40805 <exception+0xa9>
            memshow_physical();
   407fb:	e8 86 09 00 00       	call   41186 <memshow_physical>
            memshow_virtual_animate();
   40800:	e8 b0 0c 00 00       	call   414b5 <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   40805:	e8 1e 1b 00 00       	call   42328 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   4080a:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40811:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40818:	48 83 e8 0e          	sub    $0xe,%rax
   4081c:	48 83 f8 2c          	cmp    $0x2c,%rax
   40820:	0f 87 11 03 00 00    	ja     40b37 <exception+0x3db>
   40826:	48 8b 04 c5 18 4d 04 	mov    0x44d18(,%rax,8),%rax
   4082d:	00 
   4082e:	ff e0                	jmp    *%rax
        case INT_SYS_PANIC:
            {
                // rdi stores pointer for msg string
                {
                    char msg[160];
                    uintptr_t addr = current->p_registers.reg_rdi;
   40830:	48 8b 05 c9 f6 00 00 	mov    0xf6c9(%rip),%rax        # 4ff00 <current>
   40837:	48 8b 40 48          	mov    0x48(%rax),%rax
   4083b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                    if((void *)addr == NULL)
   4083f:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   40844:	75 0f                	jne    40855 <exception+0xf9>
                        kernel_panic(NULL);
   40846:	bf 00 00 00 00       	mov    $0x0,%edi
   4084b:	b8 00 00 00 00       	mov    $0x0,%eax
   40850:	e8 14 1c 00 00       	call   42469 <kernel_panic>
                    vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   40855:	48 8b 05 a4 f6 00 00 	mov    0xf6a4(%rip),%rax        # 4ff00 <current>
   4085c:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40863:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   40867:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4086b:	48 89 ce             	mov    %rcx,%rsi
   4086e:	48 89 c7             	mov    %rax,%rdi
   40871:	e8 95 23 00 00       	call   42c0b <virtual_memory_lookup>
                    memcpy(msg, (void *)map.pa, 160);
   40876:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4087a:	48 89 c1             	mov    %rax,%rcx
   4087d:	48 8d 85 10 ff ff ff 	lea    -0xf0(%rbp),%rax
   40884:	ba a0 00 00 00       	mov    $0xa0,%edx
   40889:	48 89 ce             	mov    %rcx,%rsi
   4088c:	48 89 c7             	mov    %rax,%rdi
   4088f:	e8 fa 32 00 00       	call   43b8e <memcpy>
                    kernel_panic(msg);
   40894:	48 8d 85 10 ff ff ff 	lea    -0xf0(%rbp),%rax
   4089b:	48 89 c7             	mov    %rax,%rdi
   4089e:	b8 00 00 00 00       	mov    $0x0,%eax
   408a3:	e8 c1 1b 00 00       	call   42469 <kernel_panic>
                kernel_panic(NULL);
                break;                  // will not be reached
            }
        case INT_SYS_GETPID:
            {
                current->p_registers.reg_rax = current->p_pid;
   408a8:	48 8b 05 51 f6 00 00 	mov    0xf651(%rip),%rax        # 4ff00 <current>
   408af:	8b 10                	mov    (%rax),%edx
   408b1:	48 8b 05 48 f6 00 00 	mov    0xf648(%rip),%rax        # 4ff00 <current>
   408b8:	48 63 d2             	movslq %edx,%rdx
   408bb:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   408bf:	e9 83 02 00 00       	jmp    40b47 <exception+0x3eb>
            }
        case INT_SYS_FORK:
            {
                current->p_registers.reg_rax = syscall_fork();
   408c4:	b8 00 00 00 00       	mov    $0x0,%eax
   408c9:	e8 58 fb ff ff       	call   40426 <syscall_fork>
   408ce:	89 c2                	mov    %eax,%edx
   408d0:	48 8b 05 29 f6 00 00 	mov    0xf629(%rip),%rax        # 4ff00 <current>
   408d7:	48 63 d2             	movslq %edx,%rdx
   408da:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   408de:	e9 64 02 00 00       	jmp    40b47 <exception+0x3eb>
            }
        case INT_SYS_MAPPING:
            {
                syscall_mapping(current);
   408e3:	48 8b 05 16 f6 00 00 	mov    0xf616(%rip),%rax        # 4ff00 <current>
   408ea:	48 89 c7             	mov    %rax,%rdi
   408ed:	e8 1e fd ff ff       	call   40610 <syscall_mapping>
                break;
   408f2:	e9 50 02 00 00       	jmp    40b47 <exception+0x3eb>
            }

        case INT_SYS_EXIT:
            {
                syscall_exit();
   408f7:	b8 00 00 00 00       	mov    $0x0,%eax
   408fc:	e8 3a fb ff ff       	call   4043b <syscall_exit>
                schedule();
   40901:	e8 6a 02 00 00       	call   40b70 <schedule>
                break;
   40906:	e9 3c 02 00 00       	jmp    40b47 <exception+0x3eb>
            }

        case INT_SYS_YIELD:
            {
                schedule();
   4090b:	e8 60 02 00 00       	call   40b70 <schedule>
                break;                  /* will not be reached */
   40910:	e9 32 02 00 00       	jmp    40b47 <exception+0x3eb>
            }

        case INT_SYS_BRK:
            {
                // TODO : Your code here
				brk(current, reg->reg_rdi);
   40915:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   4091c:	48 8b 50 30          	mov    0x30(%rax),%rdx
   40920:	48 8b 05 d9 f5 00 00 	mov    0xf5d9(%rip),%rax        # 4ff00 <current>
   40927:	48 89 d6             	mov    %rdx,%rsi
   4092a:	48 89 c7             	mov    %rax,%rdi
   4092d:	e8 44 fb ff ff       	call   40476 <brk>
		break;
   40932:	e9 10 02 00 00       	jmp    40b47 <exception+0x3eb>
            }

        case INT_SYS_SBRK:
            {
                // TODO : Your code here
				sbrk(current, reg->reg_rdi);
   40937:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   4093e:	48 8b 40 30          	mov    0x30(%rax),%rax
   40942:	48 89 c2             	mov    %rax,%rdx
   40945:	48 8b 05 b4 f5 00 00 	mov    0xf5b4(%rip),%rax        # 4ff00 <current>
   4094c:	48 89 d6             	mov    %rdx,%rsi
   4094f:	48 89 c7             	mov    %rax,%rdi
   40952:	e8 61 fc ff ff       	call   405b8 <sbrk>
                break;
   40957:	e9 eb 01 00 00       	jmp    40b47 <exception+0x3eb>
            }
	case INT_SYS_PAGE_ALLOC:
	    {
		intptr_t addr = reg->reg_rdi;
   4095c:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40963:	48 8b 40 30          	mov    0x30(%rax),%rax
   40967:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
		syscall_page_alloc(addr);
   4096b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4096f:	48 89 c7             	mov    %rax,%rdi
   40972:	e8 db fa ff ff       	call   40452 <syscall_page_alloc>
		break;
   40977:	e9 cb 01 00 00       	jmp    40b47 <exception+0x3eb>
	    }
        case INT_SYS_MEM_TOG:
            {
                syscall_mem_tog(current);
   4097c:	48 8b 05 7d f5 00 00 	mov    0xf57d(%rip),%rax        # 4ff00 <current>
   40983:	48 89 c7             	mov    %rax,%rdi
   40986:	e8 68 fd ff ff       	call   406f3 <syscall_mem_tog>
                break;
   4098b:	e9 b7 01 00 00       	jmp    40b47 <exception+0x3eb>
            }

        case INT_TIMER:
            {
                ++ticks;
   40990:	8b 05 8a f9 00 00    	mov    0xf98a(%rip),%eax        # 50320 <ticks>
   40996:	83 c0 01             	add    $0x1,%eax
   40999:	89 05 81 f9 00 00    	mov    %eax,0xf981(%rip)        # 50320 <ticks>
                schedule();
   4099f:	e8 cc 01 00 00       	call   40b70 <schedule>
                break;                  /* will not be reached */
   409a4:	e9 9e 01 00 00       	jmp    40b47 <exception+0x3eb>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   409a9:	0f 20 d0             	mov    %cr2,%rax
   409ac:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    return val;
   409b0:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
            }

        case INT_PAGEFAULT: 
            {
                // Analyze faulting address and access type.
                uintptr_t addr = rcr2();
   409b4:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
		    // log_printf("\theap bottom: 0x%x\n", current->original_break);
		    // log_printf("\theap top: 0x%x\n", current->program_break);
		// unsure if second check is redundant?
		if (//reg->reg_err != PFERR_PRESENT 
		    //&& 
		    addr >= current->original_break && addr < current->program_break) {
   409b8:	48 8b 05 41 f5 00 00 	mov    0xf541(%rip),%rax        # 4ff00 <current>
   409bf:	48 8b 40 10          	mov    0x10(%rax),%rax
		if (//reg->reg_err != PFERR_PRESENT 
   409c3:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   409c7:	72 76                	jb     40a3f <exception+0x2e3>
		    addr >= current->original_break && addr < current->program_break) {
   409c9:	48 8b 05 30 f5 00 00 	mov    0xf530(%rip),%rax        # 4ff00 <current>
   409d0:	48 8b 40 08          	mov    0x8(%rax),%rax
   409d4:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   409d8:	73 65                	jae    40a3f <exception+0x2e3>
			uintptr_t pa = (uintptr_t) palloc(current->p_pid);
   409da:	48 8b 05 1f f5 00 00 	mov    0xf51f(%rip),%rax        # 4ff00 <current>
   409e1:	8b 00                	mov    (%rax),%eax
   409e3:	89 c7                	mov    %eax,%edi
   409e5:	e8 70 26 00 00       	call   4305a <palloc>
   409ea:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
			if (pa) {
   409ee:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   409f3:	74 3b                	je     40a30 <exception+0x2d4>
				virtual_memory_map(current->p_pagetable, PAGEADDRESS(PAGENUMBER(addr)), pa, PAGESIZE, PTE_P | PTE_U | PTE_W);
   409f5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   409f9:	48 c1 e8 0c          	shr    $0xc,%rax
   409fd:	48 98                	cltq   
   409ff:	48 c1 e0 0c          	shl    $0xc,%rax
   40a03:	48 89 c6             	mov    %rax,%rsi
   40a06:	48 8b 05 f3 f4 00 00 	mov    0xf4f3(%rip),%rax        # 4ff00 <current>
   40a0d:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40a14:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   40a18:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40a1e:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40a23:	48 89 c7             	mov    %rax,%rdi
   40a26:	e8 1d 1e 00 00       	call   42848 <virtual_memory_map>
		    addr >= current->original_break && addr < current->program_break) {
   40a2b:	e9 05 01 00 00       	jmp    40b35 <exception+0x3d9>
			} 
			else {
				syscall_exit();
   40a30:	b8 00 00 00 00       	mov    $0x0,%eax
   40a35:	e8 01 fa ff ff       	call   4043b <syscall_exit>
		    addr >= current->original_break && addr < current->program_break) {
   40a3a:	e9 f6 00 00 00       	jmp    40b35 <exception+0x3d9>
			}
		} else {
			const char* operation = reg->reg_err & PFERR_WRITE
   40a3f:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40a46:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40a4d:	83 e0 02             	and    $0x2,%eax
			    ? "write" : "read";
   40a50:	48 85 c0             	test   %rax,%rax
   40a53:	74 07                	je     40a5c <exception+0x300>
   40a55:	b8 8b 4c 04 00       	mov    $0x44c8b,%eax
   40a5a:	eb 05                	jmp    40a61 <exception+0x305>
   40a5c:	b8 91 4c 04 00       	mov    $0x44c91,%eax
			const char* operation = reg->reg_err & PFERR_WRITE
   40a61:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
			const char* problem = reg->reg_err & PFERR_PRESENT
   40a65:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40a6c:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40a73:	83 e0 01             	and    $0x1,%eax
			    ? "protection problem" : "missing page";
   40a76:	48 85 c0             	test   %rax,%rax
   40a79:	74 07                	je     40a82 <exception+0x326>
   40a7b:	b8 96 4c 04 00       	mov    $0x44c96,%eax
   40a80:	eb 05                	jmp    40a87 <exception+0x32b>
   40a82:	b8 a9 4c 04 00       	mov    $0x44ca9,%eax
			const char* problem = reg->reg_err & PFERR_PRESENT
   40a87:	48 89 45 d0          	mov    %rax,-0x30(%rbp)

			if (!(reg->reg_err & PFERR_USER)) {
   40a8b:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40a92:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40a99:	83 e0 04             	and    $0x4,%eax
   40a9c:	48 85 c0             	test   %rax,%rax
   40a9f:	75 2f                	jne    40ad0 <exception+0x374>
			    kernel_panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   40aa1:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40aa8:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   40aaf:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
   40ab3:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   40ab7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40abb:	49 89 f0             	mov    %rsi,%r8
   40abe:	48 89 c6             	mov    %rax,%rsi
   40ac1:	bf b8 4c 04 00       	mov    $0x44cb8,%edi
   40ac6:	b8 00 00 00 00       	mov    $0x0,%eax
   40acb:	e8 99 19 00 00       	call   42469 <kernel_panic>
				    addr, operation, problem, reg->reg_rip);
			}
			console_printf(CPOS(24, 0), 0x0C00,
   40ad0:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40ad7:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
				"Process %d page fault for %p (%s %s, rip=%p)!\n",
				current->p_pid, addr, operation, problem, reg->reg_rip);
   40ade:	48 8b 05 1b f4 00 00 	mov    0xf41b(%rip),%rax        # 4ff00 <current>
			console_printf(CPOS(24, 0), 0x0C00,
   40ae5:	8b 00                	mov    (%rax),%eax
   40ae7:	48 8b 75 d8          	mov    -0x28(%rbp),%rsi
   40aeb:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   40aef:	52                   	push   %rdx
   40af0:	ff 75 d0             	push   -0x30(%rbp)
   40af3:	49 89 f1             	mov    %rsi,%r9
   40af6:	49 89 c8             	mov    %rcx,%r8
   40af9:	89 c1                	mov    %eax,%ecx
   40afb:	ba e8 4c 04 00       	mov    $0x44ce8,%edx
   40b00:	be 00 0c 00 00       	mov    $0xc00,%esi
   40b05:	bf 80 07 00 00       	mov    $0x780,%edi
   40b0a:	b8 00 00 00 00       	mov    $0x0,%eax
   40b0f:	e8 2f 3f 00 00       	call   44a43 <console_printf>
   40b14:	48 83 c4 10          	add    $0x10,%rsp
			current->p_state = P_BROKEN;
   40b18:	48 8b 05 e1 f3 00 00 	mov    0xf3e1(%rip),%rax        # 4ff00 <current>
   40b1f:	c7 80 d8 00 00 00 03 	movl   $0x3,0xd8(%rax)
   40b26:	00 00 00 
			syscall_exit();
   40b29:	b8 00 00 00 00       	mov    $0x0,%eax
   40b2e:	e8 08 f9 ff ff       	call   4043b <syscall_exit>
		}
                break;
   40b33:	eb 12                	jmp    40b47 <exception+0x3eb>
   40b35:	eb 10                	jmp    40b47 <exception+0x3eb>
            }

        default:
            default_exception(current);
   40b37:	48 8b 05 c2 f3 00 00 	mov    0xf3c2(%rip),%rax        # 4ff00 <current>
   40b3e:	48 89 c7             	mov    %rax,%rdi
   40b41:	e8 33 1a 00 00       	call   42579 <default_exception>
            break;                  /* will not be reached */
   40b46:	90                   	nop

    }

    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   40b47:	48 8b 05 b2 f3 00 00 	mov    0xf3b2(%rip),%rax        # 4ff00 <current>
   40b4e:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   40b54:	83 f8 01             	cmp    $0x1,%eax
   40b57:	75 0f                	jne    40b68 <exception+0x40c>
        run(current);
   40b59:	48 8b 05 a0 f3 00 00 	mov    0xf3a0(%rip),%rax        # 4ff00 <current>
   40b60:	48 89 c7             	mov    %rax,%rdi
   40b63:	e8 7e 00 00 00       	call   40be6 <run>
    } else {
        schedule();
   40b68:	e8 03 00 00 00       	call   40b70 <schedule>
    }
}
   40b6d:	90                   	nop
   40b6e:	c9                   	leave  
   40b6f:	c3                   	ret    

0000000000040b70 <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   40b70:	55                   	push   %rbp
   40b71:	48 89 e5             	mov    %rsp,%rbp
   40b74:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   40b78:	48 8b 05 81 f3 00 00 	mov    0xf381(%rip),%rax        # 4ff00 <current>
   40b7f:	8b 00                	mov    (%rax),%eax
   40b81:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   40b84:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40b87:	8d 50 01             	lea    0x1(%rax),%edx
   40b8a:	89 d0                	mov    %edx,%eax
   40b8c:	c1 f8 1f             	sar    $0x1f,%eax
   40b8f:	c1 e8 1c             	shr    $0x1c,%eax
   40b92:	01 c2                	add    %eax,%edx
   40b94:	83 e2 0f             	and    $0xf,%edx
   40b97:	29 c2                	sub    %eax,%edx
   40b99:	89 55 fc             	mov    %edx,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   40b9c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40b9f:	48 63 d0             	movslq %eax,%rdx
   40ba2:	48 89 d0             	mov    %rdx,%rax
   40ba5:	48 c1 e0 04          	shl    $0x4,%rax
   40ba9:	48 29 d0             	sub    %rdx,%rax
   40bac:	48 c1 e0 04          	shl    $0x4,%rax
   40bb0:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   40bb6:	8b 00                	mov    (%rax),%eax
   40bb8:	83 f8 01             	cmp    $0x1,%eax
   40bbb:	75 22                	jne    40bdf <schedule+0x6f>
            run(&processes[pid]);
   40bbd:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40bc0:	48 63 d0             	movslq %eax,%rdx
   40bc3:	48 89 d0             	mov    %rdx,%rax
   40bc6:	48 c1 e0 04          	shl    $0x4,%rax
   40bca:	48 29 d0             	sub    %rdx,%rax
   40bcd:	48 c1 e0 04          	shl    $0x4,%rax
   40bd1:	48 05 00 f0 04 00    	add    $0x4f000,%rax
   40bd7:	48 89 c7             	mov    %rax,%rdi
   40bda:	e8 07 00 00 00       	call   40be6 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   40bdf:	e8 44 17 00 00       	call   42328 <check_keyboard>
        pid = (pid + 1) % NPROC;
   40be4:	eb 9e                	jmp    40b84 <schedule+0x14>

0000000000040be6 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   40be6:	55                   	push   %rbp
   40be7:	48 89 e5             	mov    %rsp,%rbp
   40bea:	48 83 ec 10          	sub    $0x10,%rsp
   40bee:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   40bf2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40bf6:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   40bfc:	83 f8 01             	cmp    $0x1,%eax
   40bff:	74 14                	je     40c15 <run+0x2f>
   40c01:	ba 80 4e 04 00       	mov    $0x44e80,%edx
   40c06:	be b3 01 00 00       	mov    $0x1b3,%esi
   40c0b:	bf 48 4c 04 00       	mov    $0x44c48,%edi
   40c10:	e8 34 19 00 00       	call   42549 <assert_fail>
    current = p;
   40c15:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c19:	48 89 05 e0 f2 00 00 	mov    %rax,0xf2e0(%rip)        # 4ff00 <current>

    // display running process in CONSOLE last value
    console_printf(CPOS(24, 79),
   40c20:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c24:	8b 10                	mov    (%rax),%edx
            memstate_colors[p->p_pid - PO_KERNEL], "%d", p->p_pid);
   40c26:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c2a:	8b 00                	mov    (%rax),%eax
   40c2c:	83 c0 02             	add    $0x2,%eax
   40c2f:	48 98                	cltq   
   40c31:	0f b7 84 00 e0 4b 04 	movzwl 0x44be0(%rax,%rax,1),%eax
   40c38:	00 
    console_printf(CPOS(24, 79),
   40c39:	0f b7 c0             	movzwl %ax,%eax
   40c3c:	89 d1                	mov    %edx,%ecx
   40c3e:	ba 99 4e 04 00       	mov    $0x44e99,%edx
   40c43:	89 c6                	mov    %eax,%esi
   40c45:	bf cf 07 00 00       	mov    $0x7cf,%edi
   40c4a:	b8 00 00 00 00       	mov    $0x0,%eax
   40c4f:	e8 ef 3d 00 00       	call   44a43 <console_printf>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   40c54:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c58:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40c5f:	48 89 c7             	mov    %rax,%rdi
   40c62:	e8 b0 1a 00 00       	call   42717 <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   40c67:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c6b:	48 83 c0 18          	add    $0x18,%rax
   40c6f:	48 89 c7             	mov    %rax,%rdi
   40c72:	e8 4c f4 ff ff       	call   400c3 <exception_return>

0000000000040c77 <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   40c77:	55                   	push   %rbp
   40c78:	48 89 e5             	mov    %rsp,%rbp
   40c7b:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40c7f:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40c86:	00 
   40c87:	e9 81 00 00 00       	jmp    40d0d <pageinfo_init+0x96>
        int owner;
        if (physical_memory_isreserved(addr)) {
   40c8c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c90:	48 89 c7             	mov    %rax,%rdi
   40c93:	e8 1e 0f 00 00       	call   41bb6 <physical_memory_isreserved>
   40c98:	85 c0                	test   %eax,%eax
   40c9a:	74 09                	je     40ca5 <pageinfo_init+0x2e>
            owner = PO_RESERVED;
   40c9c:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   40ca3:	eb 2f                	jmp    40cd4 <pageinfo_init+0x5d>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   40ca5:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   40cac:	00 
   40cad:	76 0b                	jbe    40cba <pageinfo_init+0x43>
   40caf:	b8 10 80 05 00       	mov    $0x58010,%eax
   40cb4:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40cb8:	72 0a                	jb     40cc4 <pageinfo_init+0x4d>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   40cba:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   40cc1:	00 
   40cc2:	75 09                	jne    40ccd <pageinfo_init+0x56>
            owner = PO_KERNEL;
   40cc4:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   40ccb:	eb 07                	jmp    40cd4 <pageinfo_init+0x5d>
        } else {
            owner = PO_FREE;
   40ccd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40cd4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40cd8:	48 c1 e8 0c          	shr    $0xc,%rax
   40cdc:	89 c1                	mov    %eax,%ecx
   40cde:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40ce1:	89 c2                	mov    %eax,%edx
   40ce3:	48 63 c1             	movslq %ecx,%rax
   40ce6:	88 94 00 20 ff 04 00 	mov    %dl,0x4ff20(%rax,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   40ced:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40cf1:	0f 95 c2             	setne  %dl
   40cf4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40cf8:	48 c1 e8 0c          	shr    $0xc,%rax
   40cfc:	48 98                	cltq   
   40cfe:	88 94 00 21 ff 04 00 	mov    %dl,0x4ff21(%rax,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40d05:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40d0c:	00 
   40d0d:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40d14:	00 
   40d15:	0f 86 71 ff ff ff    	jbe    40c8c <pageinfo_init+0x15>
    }
}
   40d1b:	90                   	nop
   40d1c:	90                   	nop
   40d1d:	c9                   	leave  
   40d1e:	c3                   	ret    

0000000000040d1f <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   40d1f:	55                   	push   %rbp
   40d20:	48 89 e5             	mov    %rsp,%rbp
   40d23:	48 83 ec 50          	sub    $0x50,%rsp
   40d27:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   40d2b:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40d2f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40d35:	48 89 c2             	mov    %rax,%rdx
   40d38:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40d3c:	48 39 c2             	cmp    %rax,%rdx
   40d3f:	74 14                	je     40d55 <check_page_table_mappings+0x36>
   40d41:	ba a0 4e 04 00       	mov    $0x44ea0,%edx
   40d46:	be e1 01 00 00       	mov    $0x1e1,%esi
   40d4b:	bf 48 4c 04 00       	mov    $0x44c48,%edi
   40d50:	e8 f4 17 00 00       	call   42549 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40d55:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   40d5c:	00 
   40d5d:	e9 9a 00 00 00       	jmp    40dfc <check_page_table_mappings+0xdd>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   40d62:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   40d66:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40d6a:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40d6e:	48 89 ce             	mov    %rcx,%rsi
   40d71:	48 89 c7             	mov    %rax,%rdi
   40d74:	e8 92 1e 00 00       	call   42c0b <virtual_memory_lookup>
        if (vam.pa != va) {
   40d79:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40d7d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40d81:	74 27                	je     40daa <check_page_table_mappings+0x8b>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   40d83:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40d87:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d8b:	49 89 d0             	mov    %rdx,%r8
   40d8e:	48 89 c1             	mov    %rax,%rcx
   40d91:	ba bf 4e 04 00       	mov    $0x44ebf,%edx
   40d96:	be 00 c0 00 00       	mov    $0xc000,%esi
   40d9b:	bf e0 06 00 00       	mov    $0x6e0,%edi
   40da0:	b8 00 00 00 00       	mov    $0x0,%eax
   40da5:	e8 99 3c 00 00       	call   44a43 <console_printf>
        }
        assert(vam.pa == va);
   40daa:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40dae:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40db2:	74 14                	je     40dc8 <check_page_table_mappings+0xa9>
   40db4:	ba c9 4e 04 00       	mov    $0x44ec9,%edx
   40db9:	be ea 01 00 00       	mov    $0x1ea,%esi
   40dbe:	bf 48 4c 04 00       	mov    $0x44c48,%edi
   40dc3:	e8 81 17 00 00       	call   42549 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   40dc8:	b8 00 60 04 00       	mov    $0x46000,%eax
   40dcd:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40dd1:	72 21                	jb     40df4 <check_page_table_mappings+0xd5>
            assert(vam.perm & PTE_W);
   40dd3:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40dd6:	48 98                	cltq   
   40dd8:	83 e0 02             	and    $0x2,%eax
   40ddb:	48 85 c0             	test   %rax,%rax
   40dde:	75 14                	jne    40df4 <check_page_table_mappings+0xd5>
   40de0:	ba d6 4e 04 00       	mov    $0x44ed6,%edx
   40de5:	be ec 01 00 00       	mov    $0x1ec,%esi
   40dea:	bf 48 4c 04 00       	mov    $0x44c48,%edi
   40def:	e8 55 17 00 00       	call   42549 <assert_fail>
         va += PAGESIZE) {
   40df4:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40dfb:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40dfc:	b8 10 80 05 00       	mov    $0x58010,%eax
   40e01:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40e05:	0f 82 57 ff ff ff    	jb     40d62 <check_page_table_mappings+0x43>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   40e0b:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   40e12:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   40e13:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   40e17:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40e1b:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40e1f:	48 89 ce             	mov    %rcx,%rsi
   40e22:	48 89 c7             	mov    %rax,%rdi
   40e25:	e8 e1 1d 00 00       	call   42c0b <virtual_memory_lookup>
    assert(vam.pa == kstack);
   40e2a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40e2e:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   40e32:	74 14                	je     40e48 <check_page_table_mappings+0x129>
   40e34:	ba e7 4e 04 00       	mov    $0x44ee7,%edx
   40e39:	be f3 01 00 00       	mov    $0x1f3,%esi
   40e3e:	bf 48 4c 04 00       	mov    $0x44c48,%edi
   40e43:	e8 01 17 00 00       	call   42549 <assert_fail>
    assert(vam.perm & PTE_W);
   40e48:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40e4b:	48 98                	cltq   
   40e4d:	83 e0 02             	and    $0x2,%eax
   40e50:	48 85 c0             	test   %rax,%rax
   40e53:	75 14                	jne    40e69 <check_page_table_mappings+0x14a>
   40e55:	ba d6 4e 04 00       	mov    $0x44ed6,%edx
   40e5a:	be f4 01 00 00       	mov    $0x1f4,%esi
   40e5f:	bf 48 4c 04 00       	mov    $0x44c48,%edi
   40e64:	e8 e0 16 00 00       	call   42549 <assert_fail>
}
   40e69:	90                   	nop
   40e6a:	c9                   	leave  
   40e6b:	c3                   	ret    

0000000000040e6c <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   40e6c:	55                   	push   %rbp
   40e6d:	48 89 e5             	mov    %rsp,%rbp
   40e70:	48 83 ec 20          	sub    $0x20,%rsp
   40e74:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40e78:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   40e7b:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40e7e:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   40e81:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   40e88:	48 8b 05 71 11 01 00 	mov    0x11171(%rip),%rax        # 52000 <kernel_pagetable>
   40e8f:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40e93:	75 67                	jne    40efc <check_page_table_ownership+0x90>
        owner = PO_KERNEL;
   40e95:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40e9c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   40ea3:	eb 51                	jmp    40ef6 <check_page_table_ownership+0x8a>
            if (processes[xpid].p_state != P_FREE
   40ea5:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40ea8:	48 63 d0             	movslq %eax,%rdx
   40eab:	48 89 d0             	mov    %rdx,%rax
   40eae:	48 c1 e0 04          	shl    $0x4,%rax
   40eb2:	48 29 d0             	sub    %rdx,%rax
   40eb5:	48 c1 e0 04          	shl    $0x4,%rax
   40eb9:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   40ebf:	8b 00                	mov    (%rax),%eax
   40ec1:	85 c0                	test   %eax,%eax
   40ec3:	74 2d                	je     40ef2 <check_page_table_ownership+0x86>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   40ec5:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40ec8:	48 63 d0             	movslq %eax,%rdx
   40ecb:	48 89 d0             	mov    %rdx,%rax
   40ece:	48 c1 e0 04          	shl    $0x4,%rax
   40ed2:	48 29 d0             	sub    %rdx,%rax
   40ed5:	48 c1 e0 04          	shl    $0x4,%rax
   40ed9:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   40edf:	48 8b 10             	mov    (%rax),%rdx
   40ee2:	48 8b 05 17 11 01 00 	mov    0x11117(%rip),%rax        # 52000 <kernel_pagetable>
   40ee9:	48 39 c2             	cmp    %rax,%rdx
   40eec:	75 04                	jne    40ef2 <check_page_table_ownership+0x86>
                ++expected_refcount;
   40eee:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40ef2:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   40ef6:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   40efa:	7e a9                	jle    40ea5 <check_page_table_ownership+0x39>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   40efc:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   40eff:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40f02:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40f06:	be 00 00 00 00       	mov    $0x0,%esi
   40f0b:	48 89 c7             	mov    %rax,%rdi
   40f0e:	e8 03 00 00 00       	call   40f16 <check_page_table_ownership_level>
}
   40f13:	90                   	nop
   40f14:	c9                   	leave  
   40f15:	c3                   	ret    

0000000000040f16 <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   40f16:	55                   	push   %rbp
   40f17:	48 89 e5             	mov    %rsp,%rbp
   40f1a:	48 83 ec 30          	sub    $0x30,%rsp
   40f1e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40f22:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   40f25:	89 55 e0             	mov    %edx,-0x20(%rbp)
   40f28:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   40f2b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40f2f:	48 c1 e8 0c          	shr    $0xc,%rax
   40f33:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   40f38:	7e 14                	jle    40f4e <check_page_table_ownership_level+0x38>
   40f3a:	ba f8 4e 04 00       	mov    $0x44ef8,%edx
   40f3f:	be 11 02 00 00       	mov    $0x211,%esi
   40f44:	bf 48 4c 04 00       	mov    $0x44c48,%edi
   40f49:	e8 fb 15 00 00       	call   42549 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   40f4e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40f52:	48 c1 e8 0c          	shr    $0xc,%rax
   40f56:	48 98                	cltq   
   40f58:	0f b6 84 00 20 ff 04 	movzbl 0x4ff20(%rax,%rax,1),%eax
   40f5f:	00 
   40f60:	0f be c0             	movsbl %al,%eax
   40f63:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   40f66:	74 14                	je     40f7c <check_page_table_ownership_level+0x66>
   40f68:	ba 10 4f 04 00       	mov    $0x44f10,%edx
   40f6d:	be 12 02 00 00       	mov    $0x212,%esi
   40f72:	bf 48 4c 04 00       	mov    $0x44c48,%edi
   40f77:	e8 cd 15 00 00       	call   42549 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   40f7c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40f80:	48 c1 e8 0c          	shr    $0xc,%rax
   40f84:	48 98                	cltq   
   40f86:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   40f8d:	00 
   40f8e:	0f be c0             	movsbl %al,%eax
   40f91:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   40f94:	74 14                	je     40faa <check_page_table_ownership_level+0x94>
   40f96:	ba 38 4f 04 00       	mov    $0x44f38,%edx
   40f9b:	be 13 02 00 00       	mov    $0x213,%esi
   40fa0:	bf 48 4c 04 00       	mov    $0x44c48,%edi
   40fa5:	e8 9f 15 00 00       	call   42549 <assert_fail>
    if (level < 3) {
   40faa:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   40fae:	7f 5b                	jg     4100b <check_page_table_ownership_level+0xf5>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   40fb0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   40fb7:	eb 49                	jmp    41002 <check_page_table_ownership_level+0xec>
            if (pt->entry[index]) {
   40fb9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40fbd:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40fc0:	48 63 d2             	movslq %edx,%rdx
   40fc3:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   40fc7:	48 85 c0             	test   %rax,%rax
   40fca:	74 32                	je     40ffe <check_page_table_ownership_level+0xe8>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   40fcc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40fd0:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40fd3:	48 63 d2             	movslq %edx,%rdx
   40fd6:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   40fda:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   40fe0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   40fe4:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40fe7:	8d 70 01             	lea    0x1(%rax),%esi
   40fea:	8b 55 e0             	mov    -0x20(%rbp),%edx
   40fed:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40ff1:	b9 01 00 00 00       	mov    $0x1,%ecx
   40ff6:	48 89 c7             	mov    %rax,%rdi
   40ff9:	e8 18 ff ff ff       	call   40f16 <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   40ffe:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41002:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41009:	7e ae                	jle    40fb9 <check_page_table_ownership_level+0xa3>
            }
        }
    }
}
   4100b:	90                   	nop
   4100c:	c9                   	leave  
   4100d:	c3                   	ret    

000000000004100e <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   4100e:	55                   	push   %rbp
   4100f:	48 89 e5             	mov    %rsp,%rbp
   41012:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   41016:	8b 05 bc e0 00 00    	mov    0xe0bc(%rip),%eax        # 4f0d8 <processes+0xd8>
   4101c:	85 c0                	test   %eax,%eax
   4101e:	74 14                	je     41034 <check_virtual_memory+0x26>
   41020:	ba 68 4f 04 00       	mov    $0x44f68,%edx
   41025:	be 26 02 00 00       	mov    $0x226,%esi
   4102a:	bf 48 4c 04 00       	mov    $0x44c48,%edi
   4102f:	e8 15 15 00 00       	call   42549 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   41034:	48 8b 05 c5 0f 01 00 	mov    0x10fc5(%rip),%rax        # 52000 <kernel_pagetable>
   4103b:	48 89 c7             	mov    %rax,%rdi
   4103e:	e8 dc fc ff ff       	call   40d1f <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   41043:	48 8b 05 b6 0f 01 00 	mov    0x10fb6(%rip),%rax        # 52000 <kernel_pagetable>
   4104a:	be ff ff ff ff       	mov    $0xffffffff,%esi
   4104f:	48 89 c7             	mov    %rax,%rdi
   41052:	e8 15 fe ff ff       	call   40e6c <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   41057:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4105e:	e9 9c 00 00 00       	jmp    410ff <check_virtual_memory+0xf1>
        if (processes[pid].p_state != P_FREE
   41063:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41066:	48 63 d0             	movslq %eax,%rdx
   41069:	48 89 d0             	mov    %rdx,%rax
   4106c:	48 c1 e0 04          	shl    $0x4,%rax
   41070:	48 29 d0             	sub    %rdx,%rax
   41073:	48 c1 e0 04          	shl    $0x4,%rax
   41077:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   4107d:	8b 00                	mov    (%rax),%eax
   4107f:	85 c0                	test   %eax,%eax
   41081:	74 78                	je     410fb <check_virtual_memory+0xed>
            && processes[pid].p_pagetable != kernel_pagetable) {
   41083:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41086:	48 63 d0             	movslq %eax,%rdx
   41089:	48 89 d0             	mov    %rdx,%rax
   4108c:	48 c1 e0 04          	shl    $0x4,%rax
   41090:	48 29 d0             	sub    %rdx,%rax
   41093:	48 c1 e0 04          	shl    $0x4,%rax
   41097:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   4109d:	48 8b 10             	mov    (%rax),%rdx
   410a0:	48 8b 05 59 0f 01 00 	mov    0x10f59(%rip),%rax        # 52000 <kernel_pagetable>
   410a7:	48 39 c2             	cmp    %rax,%rdx
   410aa:	74 4f                	je     410fb <check_virtual_memory+0xed>
            check_page_table_mappings(processes[pid].p_pagetable);
   410ac:	8b 45 fc             	mov    -0x4(%rbp),%eax
   410af:	48 63 d0             	movslq %eax,%rdx
   410b2:	48 89 d0             	mov    %rdx,%rax
   410b5:	48 c1 e0 04          	shl    $0x4,%rax
   410b9:	48 29 d0             	sub    %rdx,%rax
   410bc:	48 c1 e0 04          	shl    $0x4,%rax
   410c0:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   410c6:	48 8b 00             	mov    (%rax),%rax
   410c9:	48 89 c7             	mov    %rax,%rdi
   410cc:	e8 4e fc ff ff       	call   40d1f <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   410d1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   410d4:	48 63 d0             	movslq %eax,%rdx
   410d7:	48 89 d0             	mov    %rdx,%rax
   410da:	48 c1 e0 04          	shl    $0x4,%rax
   410de:	48 29 d0             	sub    %rdx,%rax
   410e1:	48 c1 e0 04          	shl    $0x4,%rax
   410e5:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   410eb:	48 8b 00             	mov    (%rax),%rax
   410ee:	8b 55 fc             	mov    -0x4(%rbp),%edx
   410f1:	89 d6                	mov    %edx,%esi
   410f3:	48 89 c7             	mov    %rax,%rdi
   410f6:	e8 71 fd ff ff       	call   40e6c <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   410fb:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   410ff:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   41103:	0f 8e 5a ff ff ff    	jle    41063 <check_virtual_memory+0x55>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41109:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41110:	eb 67                	jmp    41179 <check_virtual_memory+0x16b>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   41112:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41115:	48 98                	cltq   
   41117:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   4111e:	00 
   4111f:	84 c0                	test   %al,%al
   41121:	7e 52                	jle    41175 <check_virtual_memory+0x167>
   41123:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41126:	48 98                	cltq   
   41128:	0f b6 84 00 20 ff 04 	movzbl 0x4ff20(%rax,%rax,1),%eax
   4112f:	00 
   41130:	84 c0                	test   %al,%al
   41132:	78 41                	js     41175 <check_virtual_memory+0x167>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   41134:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41137:	48 98                	cltq   
   41139:	0f b6 84 00 20 ff 04 	movzbl 0x4ff20(%rax,%rax,1),%eax
   41140:	00 
   41141:	0f be c0             	movsbl %al,%eax
   41144:	48 63 d0             	movslq %eax,%rdx
   41147:	48 89 d0             	mov    %rdx,%rax
   4114a:	48 c1 e0 04          	shl    $0x4,%rax
   4114e:	48 29 d0             	sub    %rdx,%rax
   41151:	48 c1 e0 04          	shl    $0x4,%rax
   41155:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   4115b:	8b 00                	mov    (%rax),%eax
   4115d:	85 c0                	test   %eax,%eax
   4115f:	75 14                	jne    41175 <check_virtual_memory+0x167>
   41161:	ba 88 4f 04 00       	mov    $0x44f88,%edx
   41166:	be 3d 02 00 00       	mov    $0x23d,%esi
   4116b:	bf 48 4c 04 00       	mov    $0x44c48,%edi
   41170:	e8 d4 13 00 00       	call   42549 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41175:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41179:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   41180:	7e 90                	jle    41112 <check_virtual_memory+0x104>
        }
    }
}
   41182:	90                   	nop
   41183:	90                   	nop
   41184:	c9                   	leave  
   41185:	c3                   	ret    

0000000000041186 <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   41186:	55                   	push   %rbp
   41187:	48 89 e5             	mov    %rsp,%rbp
   4118a:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   4118e:	ba b8 4f 04 00       	mov    $0x44fb8,%edx
   41193:	be 00 0f 00 00       	mov    $0xf00,%esi
   41198:	bf 20 00 00 00       	mov    $0x20,%edi
   4119d:	b8 00 00 00 00       	mov    $0x0,%eax
   411a2:	e8 9c 38 00 00       	call   44a43 <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   411a7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   411ae:	e9 f8 00 00 00       	jmp    412ab <memshow_physical+0x125>
        if (pn % 64 == 0) {
   411b3:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411b6:	83 e0 3f             	and    $0x3f,%eax
   411b9:	85 c0                	test   %eax,%eax
   411bb:	75 3c                	jne    411f9 <memshow_physical+0x73>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   411bd:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411c0:	c1 e0 0c             	shl    $0xc,%eax
   411c3:	89 c1                	mov    %eax,%ecx
   411c5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411c8:	8d 50 3f             	lea    0x3f(%rax),%edx
   411cb:	85 c0                	test   %eax,%eax
   411cd:	0f 48 c2             	cmovs  %edx,%eax
   411d0:	c1 f8 06             	sar    $0x6,%eax
   411d3:	8d 50 01             	lea    0x1(%rax),%edx
   411d6:	89 d0                	mov    %edx,%eax
   411d8:	c1 e0 02             	shl    $0x2,%eax
   411db:	01 d0                	add    %edx,%eax
   411dd:	c1 e0 04             	shl    $0x4,%eax
   411e0:	83 c0 03             	add    $0x3,%eax
   411e3:	ba c8 4f 04 00       	mov    $0x44fc8,%edx
   411e8:	be 00 0f 00 00       	mov    $0xf00,%esi
   411ed:	89 c7                	mov    %eax,%edi
   411ef:	b8 00 00 00 00       	mov    $0x0,%eax
   411f4:	e8 4a 38 00 00       	call   44a43 <console_printf>
        }

        int owner = pageinfo[pn].owner;
   411f9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411fc:	48 98                	cltq   
   411fe:	0f b6 84 00 20 ff 04 	movzbl 0x4ff20(%rax,%rax,1),%eax
   41205:	00 
   41206:	0f be c0             	movsbl %al,%eax
   41209:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   4120c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4120f:	48 98                	cltq   
   41211:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   41218:	00 
   41219:	84 c0                	test   %al,%al
   4121b:	75 07                	jne    41224 <memshow_physical+0x9e>
            owner = PO_FREE;
   4121d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   41224:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41227:	83 c0 02             	add    $0x2,%eax
   4122a:	48 98                	cltq   
   4122c:	0f b7 84 00 e0 4b 04 	movzwl 0x44be0(%rax,%rax,1),%eax
   41233:	00 
   41234:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   41238:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4123b:	48 98                	cltq   
   4123d:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   41244:	00 
   41245:	3c 01                	cmp    $0x1,%al
   41247:	7e 1a                	jle    41263 <memshow_physical+0xdd>
   41249:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   4124e:	48 c1 e8 0c          	shr    $0xc,%rax
   41252:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   41255:	74 0c                	je     41263 <memshow_physical+0xdd>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   41257:	b8 53 00 00 00       	mov    $0x53,%eax
   4125c:	80 cc 0f             	or     $0xf,%ah
   4125f:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   41263:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41266:	8d 50 3f             	lea    0x3f(%rax),%edx
   41269:	85 c0                	test   %eax,%eax
   4126b:	0f 48 c2             	cmovs  %edx,%eax
   4126e:	c1 f8 06             	sar    $0x6,%eax
   41271:	8d 50 01             	lea    0x1(%rax),%edx
   41274:	89 d0                	mov    %edx,%eax
   41276:	c1 e0 02             	shl    $0x2,%eax
   41279:	01 d0                	add    %edx,%eax
   4127b:	c1 e0 04             	shl    $0x4,%eax
   4127e:	89 c1                	mov    %eax,%ecx
   41280:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41283:	89 d0                	mov    %edx,%eax
   41285:	c1 f8 1f             	sar    $0x1f,%eax
   41288:	c1 e8 1a             	shr    $0x1a,%eax
   4128b:	01 c2                	add    %eax,%edx
   4128d:	83 e2 3f             	and    $0x3f,%edx
   41290:	29 c2                	sub    %eax,%edx
   41292:	89 d0                	mov    %edx,%eax
   41294:	83 c0 0c             	add    $0xc,%eax
   41297:	01 c8                	add    %ecx,%eax
   41299:	48 98                	cltq   
   4129b:	0f b7 55 f6          	movzwl -0xa(%rbp),%edx
   4129f:	66 89 94 00 00 80 0b 	mov    %dx,0xb8000(%rax,%rax,1)
   412a6:	00 
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   412a7:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   412ab:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   412b2:	0f 8e fb fe ff ff    	jle    411b3 <memshow_physical+0x2d>
    }
}
   412b8:	90                   	nop
   412b9:	90                   	nop
   412ba:	c9                   	leave  
   412bb:	c3                   	ret    

00000000000412bc <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   412bc:	55                   	push   %rbp
   412bd:	48 89 e5             	mov    %rsp,%rbp
   412c0:	48 83 ec 40          	sub    $0x40,%rsp
   412c4:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   412c8:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   412cc:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   412d0:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   412d6:	48 89 c2             	mov    %rax,%rdx
   412d9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   412dd:	48 39 c2             	cmp    %rax,%rdx
   412e0:	74 14                	je     412f6 <memshow_virtual+0x3a>
   412e2:	ba d0 4f 04 00       	mov    $0x44fd0,%edx
   412e7:	be 6e 02 00 00       	mov    $0x26e,%esi
   412ec:	bf 48 4c 04 00       	mov    $0x44c48,%edi
   412f1:	e8 53 12 00 00       	call   42549 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   412f6:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   412fa:	48 89 c1             	mov    %rax,%rcx
   412fd:	ba fd 4f 04 00       	mov    $0x44ffd,%edx
   41302:	be 00 0f 00 00       	mov    $0xf00,%esi
   41307:	bf 3a 03 00 00       	mov    $0x33a,%edi
   4130c:	b8 00 00 00 00       	mov    $0x0,%eax
   41311:	e8 2d 37 00 00       	call   44a43 <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41316:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   4131d:	00 
   4131e:	e9 80 01 00 00       	jmp    414a3 <memshow_virtual+0x1e7>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   41323:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   41327:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4132b:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   4132f:	48 89 ce             	mov    %rcx,%rsi
   41332:	48 89 c7             	mov    %rax,%rdi
   41335:	e8 d1 18 00 00       	call   42c0b <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   4133a:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4133d:	85 c0                	test   %eax,%eax
   4133f:	79 0b                	jns    4134c <memshow_virtual+0x90>
            color = ' ';
   41341:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   41347:	e9 d7 00 00 00       	jmp    41423 <memshow_virtual+0x167>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   4134c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41350:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   41356:	76 14                	jbe    4136c <memshow_virtual+0xb0>
   41358:	ba 1a 50 04 00       	mov    $0x4501a,%edx
   4135d:	be 77 02 00 00       	mov    $0x277,%esi
   41362:	bf 48 4c 04 00       	mov    $0x44c48,%edi
   41367:	e8 dd 11 00 00       	call   42549 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   4136c:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4136f:	48 98                	cltq   
   41371:	0f b6 84 00 20 ff 04 	movzbl 0x4ff20(%rax,%rax,1),%eax
   41378:	00 
   41379:	0f be c0             	movsbl %al,%eax
   4137c:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   4137f:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41382:	48 98                	cltq   
   41384:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   4138b:	00 
   4138c:	84 c0                	test   %al,%al
   4138e:	75 07                	jne    41397 <memshow_virtual+0xdb>
                owner = PO_FREE;
   41390:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   41397:	8b 45 f0             	mov    -0x10(%rbp),%eax
   4139a:	83 c0 02             	add    $0x2,%eax
   4139d:	48 98                	cltq   
   4139f:	0f b7 84 00 e0 4b 04 	movzwl 0x44be0(%rax,%rax,1),%eax
   413a6:	00 
   413a7:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   413ab:	8b 45 e0             	mov    -0x20(%rbp),%eax
   413ae:	48 98                	cltq   
   413b0:	83 e0 04             	and    $0x4,%eax
   413b3:	48 85 c0             	test   %rax,%rax
   413b6:	74 27                	je     413df <memshow_virtual+0x123>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   413b8:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   413bc:	c1 e0 04             	shl    $0x4,%eax
   413bf:	66 25 00 f0          	and    $0xf000,%ax
   413c3:	89 c2                	mov    %eax,%edx
   413c5:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   413c9:	c1 f8 04             	sar    $0x4,%eax
   413cc:	66 25 00 0f          	and    $0xf00,%ax
   413d0:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   413d2:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   413d6:	0f b6 c0             	movzbl %al,%eax
   413d9:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   413db:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   413df:	8b 45 d0             	mov    -0x30(%rbp),%eax
   413e2:	48 98                	cltq   
   413e4:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   413eb:	00 
   413ec:	3c 01                	cmp    $0x1,%al
   413ee:	7e 33                	jle    41423 <memshow_virtual+0x167>
   413f0:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   413f5:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   413f9:	74 28                	je     41423 <memshow_virtual+0x167>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   413fb:	b8 53 00 00 00       	mov    $0x53,%eax
   41400:	89 c2                	mov    %eax,%edx
   41402:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41406:	66 25 00 f0          	and    $0xf000,%ax
   4140a:	09 d0                	or     %edx,%eax
   4140c:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   41410:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41413:	48 98                	cltq   
   41415:	83 e0 04             	and    $0x4,%eax
   41418:	48 85 c0             	test   %rax,%rax
   4141b:	75 06                	jne    41423 <memshow_virtual+0x167>
                    color = color | 0x0F00;
   4141d:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   41423:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41427:	48 c1 e8 0c          	shr    $0xc,%rax
   4142b:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   4142e:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41431:	83 e0 3f             	and    $0x3f,%eax
   41434:	85 c0                	test   %eax,%eax
   41436:	75 34                	jne    4146c <memshow_virtual+0x1b0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   41438:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4143b:	c1 e8 06             	shr    $0x6,%eax
   4143e:	89 c2                	mov    %eax,%edx
   41440:	89 d0                	mov    %edx,%eax
   41442:	c1 e0 02             	shl    $0x2,%eax
   41445:	01 d0                	add    %edx,%eax
   41447:	c1 e0 04             	shl    $0x4,%eax
   4144a:	05 73 03 00 00       	add    $0x373,%eax
   4144f:	89 c7                	mov    %eax,%edi
   41451:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41455:	48 89 c1             	mov    %rax,%rcx
   41458:	ba c8 4f 04 00       	mov    $0x44fc8,%edx
   4145d:	be 00 0f 00 00       	mov    $0xf00,%esi
   41462:	b8 00 00 00 00       	mov    $0x0,%eax
   41467:	e8 d7 35 00 00       	call   44a43 <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   4146c:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4146f:	c1 e8 06             	shr    $0x6,%eax
   41472:	89 c2                	mov    %eax,%edx
   41474:	89 d0                	mov    %edx,%eax
   41476:	c1 e0 02             	shl    $0x2,%eax
   41479:	01 d0                	add    %edx,%eax
   4147b:	c1 e0 04             	shl    $0x4,%eax
   4147e:	89 c2                	mov    %eax,%edx
   41480:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41483:	83 e0 3f             	and    $0x3f,%eax
   41486:	01 d0                	add    %edx,%eax
   41488:	05 7c 03 00 00       	add    $0x37c,%eax
   4148d:	89 c2                	mov    %eax,%edx
   4148f:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41493:	66 89 84 12 00 80 0b 	mov    %ax,0xb8000(%rdx,%rdx,1)
   4149a:	00 
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   4149b:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   414a2:	00 
   414a3:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   414aa:	00 
   414ab:	0f 86 72 fe ff ff    	jbe    41323 <memshow_virtual+0x67>
    }
}
   414b1:	90                   	nop
   414b2:	90                   	nop
   414b3:	c9                   	leave  
   414b4:	c3                   	ret    

00000000000414b5 <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   414b5:	55                   	push   %rbp
   414b6:	48 89 e5             	mov    %rsp,%rbp
   414b9:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   414bd:	8b 05 61 ee 00 00    	mov    0xee61(%rip),%eax        # 50324 <last_ticks.1>
   414c3:	85 c0                	test   %eax,%eax
   414c5:	74 13                	je     414da <memshow_virtual_animate+0x25>
   414c7:	8b 15 53 ee 00 00    	mov    0xee53(%rip),%edx        # 50320 <ticks>
   414cd:	8b 05 51 ee 00 00    	mov    0xee51(%rip),%eax        # 50324 <last_ticks.1>
   414d3:	29 c2                	sub    %eax,%edx
   414d5:	83 fa 31             	cmp    $0x31,%edx
   414d8:	76 2c                	jbe    41506 <memshow_virtual_animate+0x51>
        last_ticks = ticks;
   414da:	8b 05 40 ee 00 00    	mov    0xee40(%rip),%eax        # 50320 <ticks>
   414e0:	89 05 3e ee 00 00    	mov    %eax,0xee3e(%rip)        # 50324 <last_ticks.1>
        ++showing;
   414e6:	8b 05 18 4b 00 00    	mov    0x4b18(%rip),%eax        # 46004 <showing.0>
   414ec:	83 c0 01             	add    $0x1,%eax
   414ef:	89 05 0f 4b 00 00    	mov    %eax,0x4b0f(%rip)        # 46004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   414f5:	eb 0f                	jmp    41506 <memshow_virtual_animate+0x51>
           && processes[showing % NPROC].p_state == P_FREE) {
        ++showing;
   414f7:	8b 05 07 4b 00 00    	mov    0x4b07(%rip),%eax        # 46004 <showing.0>
   414fd:	83 c0 01             	add    $0x1,%eax
   41500:	89 05 fe 4a 00 00    	mov    %eax,0x4afe(%rip)        # 46004 <showing.0>
    while (showing <= 2*NPROC
   41506:	8b 05 f8 4a 00 00    	mov    0x4af8(%rip),%eax        # 46004 <showing.0>
           && processes[showing % NPROC].p_state == P_FREE) {
   4150c:	83 f8 20             	cmp    $0x20,%eax
   4150f:	7f 34                	jg     41545 <memshow_virtual_animate+0x90>
   41511:	8b 15 ed 4a 00 00    	mov    0x4aed(%rip),%edx        # 46004 <showing.0>
   41517:	89 d0                	mov    %edx,%eax
   41519:	c1 f8 1f             	sar    $0x1f,%eax
   4151c:	c1 e8 1c             	shr    $0x1c,%eax
   4151f:	01 c2                	add    %eax,%edx
   41521:	83 e2 0f             	and    $0xf,%edx
   41524:	29 c2                	sub    %eax,%edx
   41526:	89 d0                	mov    %edx,%eax
   41528:	48 63 d0             	movslq %eax,%rdx
   4152b:	48 89 d0             	mov    %rdx,%rax
   4152e:	48 c1 e0 04          	shl    $0x4,%rax
   41532:	48 29 d0             	sub    %rdx,%rax
   41535:	48 c1 e0 04          	shl    $0x4,%rax
   41539:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   4153f:	8b 00                	mov    (%rax),%eax
   41541:	85 c0                	test   %eax,%eax
   41543:	74 b2                	je     414f7 <memshow_virtual_animate+0x42>
    }
    showing = showing % NPROC;
   41545:	8b 15 b9 4a 00 00    	mov    0x4ab9(%rip),%edx        # 46004 <showing.0>
   4154b:	89 d0                	mov    %edx,%eax
   4154d:	c1 f8 1f             	sar    $0x1f,%eax
   41550:	c1 e8 1c             	shr    $0x1c,%eax
   41553:	01 c2                	add    %eax,%edx
   41555:	83 e2 0f             	and    $0xf,%edx
   41558:	29 c2                	sub    %eax,%edx
   4155a:	89 d0                	mov    %edx,%eax
   4155c:	89 05 a2 4a 00 00    	mov    %eax,0x4aa2(%rip)        # 46004 <showing.0>

    if (processes[showing].p_state != P_FREE && processes[showing].display_status) {
   41562:	8b 05 9c 4a 00 00    	mov    0x4a9c(%rip),%eax        # 46004 <showing.0>
   41568:	48 63 d0             	movslq %eax,%rdx
   4156b:	48 89 d0             	mov    %rdx,%rax
   4156e:	48 c1 e0 04          	shl    $0x4,%rax
   41572:	48 29 d0             	sub    %rdx,%rax
   41575:	48 c1 e0 04          	shl    $0x4,%rax
   41579:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   4157f:	8b 00                	mov    (%rax),%eax
   41581:	85 c0                	test   %eax,%eax
   41583:	74 76                	je     415fb <memshow_virtual_animate+0x146>
   41585:	8b 05 79 4a 00 00    	mov    0x4a79(%rip),%eax        # 46004 <showing.0>
   4158b:	48 63 d0             	movslq %eax,%rdx
   4158e:	48 89 d0             	mov    %rdx,%rax
   41591:	48 c1 e0 04          	shl    $0x4,%rax
   41595:	48 29 d0             	sub    %rdx,%rax
   41598:	48 c1 e0 04          	shl    $0x4,%rax
   4159c:	48 05 e8 f0 04 00    	add    $0x4f0e8,%rax
   415a2:	0f b6 00             	movzbl (%rax),%eax
   415a5:	84 c0                	test   %al,%al
   415a7:	74 52                	je     415fb <memshow_virtual_animate+0x146>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   415a9:	8b 15 55 4a 00 00    	mov    0x4a55(%rip),%edx        # 46004 <showing.0>
   415af:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   415b3:	89 d1                	mov    %edx,%ecx
   415b5:	ba 34 50 04 00       	mov    $0x45034,%edx
   415ba:	be 04 00 00 00       	mov    $0x4,%esi
   415bf:	48 89 c7             	mov    %rax,%rdi
   415c2:	b8 00 00 00 00       	mov    $0x0,%eax
   415c7:	e8 83 35 00 00       	call   44b4f <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   415cc:	8b 05 32 4a 00 00    	mov    0x4a32(%rip),%eax        # 46004 <showing.0>
   415d2:	48 63 d0             	movslq %eax,%rdx
   415d5:	48 89 d0             	mov    %rdx,%rax
   415d8:	48 c1 e0 04          	shl    $0x4,%rax
   415dc:	48 29 d0             	sub    %rdx,%rax
   415df:	48 c1 e0 04          	shl    $0x4,%rax
   415e3:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   415e9:	48 8b 00             	mov    (%rax),%rax
   415ec:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   415f0:	48 89 d6             	mov    %rdx,%rsi
   415f3:	48 89 c7             	mov    %rax,%rdi
   415f6:	e8 c1 fc ff ff       	call   412bc <memshow_virtual>
    }
}
   415fb:	90                   	nop
   415fc:	c9                   	leave  
   415fd:	c3                   	ret    

00000000000415fe <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   415fe:	55                   	push   %rbp
   415ff:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   41602:	e8 4f 01 00 00       	call   41756 <segments_init>
    interrupt_init();
   41607:	e8 d0 03 00 00       	call   419dc <interrupt_init>
    virtual_memory_init();
   4160c:	e8 f3 0f 00 00       	call   42604 <virtual_memory_init>
}
   41611:	90                   	nop
   41612:	5d                   	pop    %rbp
   41613:	c3                   	ret    

0000000000041614 <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   41614:	55                   	push   %rbp
   41615:	48 89 e5             	mov    %rsp,%rbp
   41618:	48 83 ec 18          	sub    $0x18,%rsp
   4161c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41620:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41624:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   41627:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4162a:	48 98                	cltq   
   4162c:	48 c1 e0 2d          	shl    $0x2d,%rax
   41630:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   41634:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   4163b:	90 00 00 
   4163e:	48 09 c2             	or     %rax,%rdx
    *segment = type
   41641:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41645:	48 89 10             	mov    %rdx,(%rax)
}
   41648:	90                   	nop
   41649:	c9                   	leave  
   4164a:	c3                   	ret    

000000000004164b <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   4164b:	55                   	push   %rbp
   4164c:	48 89 e5             	mov    %rsp,%rbp
   4164f:	48 83 ec 28          	sub    $0x28,%rsp
   41653:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41657:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   4165b:	89 55 ec             	mov    %edx,-0x14(%rbp)
   4165e:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   41662:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41666:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4166a:	48 c1 e0 10          	shl    $0x10,%rax
   4166e:	48 89 c2             	mov    %rax,%rdx
   41671:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   41678:	00 00 00 
   4167b:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   4167e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41682:	48 c1 e0 20          	shl    $0x20,%rax
   41686:	48 89 c1             	mov    %rax,%rcx
   41689:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   41690:	00 00 ff 
   41693:	48 21 c8             	and    %rcx,%rax
   41696:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   41699:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4169d:	48 83 e8 01          	sub    $0x1,%rax
   416a1:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   416a4:	48 09 d0             	or     %rdx,%rax
        | type
   416a7:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   416ab:	8b 55 ec             	mov    -0x14(%rbp),%edx
   416ae:	48 63 d2             	movslq %edx,%rdx
   416b1:	48 c1 e2 2d          	shl    $0x2d,%rdx
   416b5:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   416b8:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   416bf:	80 00 00 
   416c2:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   416c5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   416c9:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   416cc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   416d0:	48 83 c0 08          	add    $0x8,%rax
   416d4:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   416d8:	48 c1 ea 20          	shr    $0x20,%rdx
   416dc:	48 89 10             	mov    %rdx,(%rax)
}
   416df:	90                   	nop
   416e0:	c9                   	leave  
   416e1:	c3                   	ret    

00000000000416e2 <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   416e2:	55                   	push   %rbp
   416e3:	48 89 e5             	mov    %rsp,%rbp
   416e6:	48 83 ec 20          	sub    $0x20,%rsp
   416ea:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   416ee:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   416f2:	89 55 ec             	mov    %edx,-0x14(%rbp)
   416f5:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   416f9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   416fd:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   41700:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   41704:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41707:	48 63 d2             	movslq %edx,%rdx
   4170a:	48 c1 e2 2d          	shl    $0x2d,%rdx
   4170e:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   41711:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41715:	48 c1 e0 20          	shl    $0x20,%rax
   41719:	48 89 c1             	mov    %rax,%rcx
   4171c:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   41723:	00 ff ff 
   41726:	48 21 c8             	and    %rcx,%rax
   41729:	48 09 c2             	or     %rax,%rdx
   4172c:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   41733:	80 00 00 
   41736:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41739:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4173d:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   41740:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41744:	48 c1 e8 20          	shr    $0x20,%rax
   41748:	48 89 c2             	mov    %rax,%rdx
   4174b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4174f:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   41753:	90                   	nop
   41754:	c9                   	leave  
   41755:	c3                   	ret    

0000000000041756 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   41756:	55                   	push   %rbp
   41757:	48 89 e5             	mov    %rsp,%rbp
   4175a:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   4175e:	48 c7 05 d7 eb 00 00 	movq   $0x0,0xebd7(%rip)        # 50340 <segments>
   41765:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   41769:	ba 00 00 00 00       	mov    $0x0,%edx
   4176e:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41775:	08 20 00 
   41778:	48 89 c6             	mov    %rax,%rsi
   4177b:	bf 48 03 05 00       	mov    $0x50348,%edi
   41780:	e8 8f fe ff ff       	call   41614 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   41785:	ba 03 00 00 00       	mov    $0x3,%edx
   4178a:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41791:	08 20 00 
   41794:	48 89 c6             	mov    %rax,%rsi
   41797:	bf 50 03 05 00       	mov    $0x50350,%edi
   4179c:	e8 73 fe ff ff       	call   41614 <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   417a1:	ba 00 00 00 00       	mov    $0x0,%edx
   417a6:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   417ad:	02 00 00 
   417b0:	48 89 c6             	mov    %rax,%rsi
   417b3:	bf 58 03 05 00       	mov    $0x50358,%edi
   417b8:	e8 57 fe ff ff       	call   41614 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   417bd:	ba 03 00 00 00       	mov    $0x3,%edx
   417c2:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   417c9:	02 00 00 
   417cc:	48 89 c6             	mov    %rax,%rsi
   417cf:	bf 60 03 05 00       	mov    $0x50360,%edi
   417d4:	e8 3b fe ff ff       	call   41614 <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   417d9:	b8 80 13 05 00       	mov    $0x51380,%eax
   417de:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   417e4:	48 89 c1             	mov    %rax,%rcx
   417e7:	ba 00 00 00 00       	mov    $0x0,%edx
   417ec:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   417f3:	09 00 00 
   417f6:	48 89 c6             	mov    %rax,%rsi
   417f9:	bf 68 03 05 00       	mov    $0x50368,%edi
   417fe:	e8 48 fe ff ff       	call   4164b <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   41803:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   41809:	b8 40 03 05 00       	mov    $0x50340,%eax
   4180e:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   41812:	ba 60 00 00 00       	mov    $0x60,%edx
   41817:	be 00 00 00 00       	mov    $0x0,%esi
   4181c:	bf 80 13 05 00       	mov    $0x51380,%edi
   41821:	e8 66 24 00 00       	call   43c8c <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   41826:	48 c7 05 53 fb 00 00 	movq   $0x80000,0xfb53(%rip)        # 51384 <kernel_task_descriptor+0x4>
   4182d:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   41831:	ba 00 10 00 00       	mov    $0x1000,%edx
   41836:	be 00 00 00 00       	mov    $0x0,%esi
   4183b:	bf 80 03 05 00       	mov    $0x50380,%edi
   41840:	e8 47 24 00 00       	call   43c8c <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41845:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   4184c:	eb 30                	jmp    4187e <segments_init+0x128>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   4184e:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   41853:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41856:	48 c1 e0 04          	shl    $0x4,%rax
   4185a:	48 05 80 03 05 00    	add    $0x50380,%rax
   41860:	48 89 d1             	mov    %rdx,%rcx
   41863:	ba 00 00 00 00       	mov    $0x0,%edx
   41868:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   4186f:	0e 00 00 
   41872:	48 89 c7             	mov    %rax,%rdi
   41875:	e8 68 fe ff ff       	call   416e2 <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   4187a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4187e:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   41885:	76 c7                	jbe    4184e <segments_init+0xf8>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   41887:	b8 36 00 04 00       	mov    $0x40036,%eax
   4188c:	48 89 c1             	mov    %rax,%rcx
   4188f:	ba 00 00 00 00       	mov    $0x0,%edx
   41894:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   4189b:	0e 00 00 
   4189e:	48 89 c6             	mov    %rax,%rsi
   418a1:	bf 80 05 05 00       	mov    $0x50580,%edi
   418a6:	e8 37 fe ff ff       	call   416e2 <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   418ab:	b8 2e 00 04 00       	mov    $0x4002e,%eax
   418b0:	48 89 c1             	mov    %rax,%rcx
   418b3:	ba 00 00 00 00       	mov    $0x0,%edx
   418b8:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   418bf:	0e 00 00 
   418c2:	48 89 c6             	mov    %rax,%rsi
   418c5:	bf 50 04 05 00       	mov    $0x50450,%edi
   418ca:	e8 13 fe ff ff       	call   416e2 <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   418cf:	b8 32 00 04 00       	mov    $0x40032,%eax
   418d4:	48 89 c1             	mov    %rax,%rcx
   418d7:	ba 00 00 00 00       	mov    $0x0,%edx
   418dc:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   418e3:	0e 00 00 
   418e6:	48 89 c6             	mov    %rax,%rsi
   418e9:	bf 60 04 05 00       	mov    $0x50460,%edi
   418ee:	e8 ef fd ff ff       	call   416e2 <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   418f3:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   418fa:	eb 3e                	jmp    4193a <segments_init+0x1e4>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   418fc:	8b 45 f8             	mov    -0x8(%rbp),%eax
   418ff:	83 e8 30             	sub    $0x30,%eax
   41902:	89 c0                	mov    %eax,%eax
   41904:	48 8b 04 c5 e7 00 04 	mov    0x400e7(,%rax,8),%rax
   4190b:	00 
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   4190c:	48 89 c2             	mov    %rax,%rdx
   4190f:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41912:	48 c1 e0 04          	shl    $0x4,%rax
   41916:	48 05 80 03 05 00    	add    $0x50380,%rax
   4191c:	48 89 d1             	mov    %rdx,%rcx
   4191f:	ba 03 00 00 00       	mov    $0x3,%edx
   41924:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   4192b:	0e 00 00 
   4192e:	48 89 c7             	mov    %rax,%rdi
   41931:	e8 ac fd ff ff       	call   416e2 <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41936:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   4193a:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   4193e:	76 bc                	jbe    418fc <segments_init+0x1a6>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   41940:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   41946:	b8 80 03 05 00       	mov    $0x50380,%eax
   4194b:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   4194f:	b8 28 00 00 00       	mov    $0x28,%eax
   41954:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   41958:	0f 00 d8             	ltr    %ax
   4195b:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   4195f:	0f 20 c0             	mov    %cr0,%rax
   41962:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   41966:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   4196a:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   4196d:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   41974:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41977:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   4197a:	8b 45 f0             	mov    -0x10(%rbp),%eax
   4197d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   41981:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41985:	0f 22 c0             	mov    %rax,%cr0
}
   41988:	90                   	nop
    lcr0(cr0);
}
   41989:	90                   	nop
   4198a:	c9                   	leave  
   4198b:	c3                   	ret    

000000000004198c <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   4198c:	55                   	push   %rbp
   4198d:	48 89 e5             	mov    %rsp,%rbp
   41990:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   41994:	0f b7 05 45 fa 00 00 	movzwl 0xfa45(%rip),%eax        # 513e0 <interrupts_enabled>
   4199b:	f7 d0                	not    %eax
   4199d:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   419a1:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   419a5:	0f b6 c0             	movzbl %al,%eax
   419a8:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   419af:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   419b2:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   419b6:	8b 55 f0             	mov    -0x10(%rbp),%edx
   419b9:	ee                   	out    %al,(%dx)
}
   419ba:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   419bb:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   419bf:	66 c1 e8 08          	shr    $0x8,%ax
   419c3:	0f b6 c0             	movzbl %al,%eax
   419c6:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   419cd:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   419d0:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   419d4:	8b 55 f8             	mov    -0x8(%rbp),%edx
   419d7:	ee                   	out    %al,(%dx)
}
   419d8:	90                   	nop
}
   419d9:	90                   	nop
   419da:	c9                   	leave  
   419db:	c3                   	ret    

00000000000419dc <interrupt_init>:

void interrupt_init(void) {
   419dc:	55                   	push   %rbp
   419dd:	48 89 e5             	mov    %rsp,%rbp
   419e0:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   419e4:	66 c7 05 f3 f9 00 00 	movw   $0x0,0xf9f3(%rip)        # 513e0 <interrupts_enabled>
   419eb:	00 00 
    interrupt_mask();
   419ed:	e8 9a ff ff ff       	call   4198c <interrupt_mask>
   419f2:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   419f9:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   419fd:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   41a01:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   41a04:	ee                   	out    %al,(%dx)
}
   41a05:	90                   	nop
   41a06:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   41a0d:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a11:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   41a15:	8b 55 ac             	mov    -0x54(%rbp),%edx
   41a18:	ee                   	out    %al,(%dx)
}
   41a19:	90                   	nop
   41a1a:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   41a21:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a25:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   41a29:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   41a2c:	ee                   	out    %al,(%dx)
}
   41a2d:	90                   	nop
   41a2e:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   41a35:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a39:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   41a3d:	8b 55 bc             	mov    -0x44(%rbp),%edx
   41a40:	ee                   	out    %al,(%dx)
}
   41a41:	90                   	nop
   41a42:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   41a49:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a4d:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   41a51:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   41a54:	ee                   	out    %al,(%dx)
}
   41a55:	90                   	nop
   41a56:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   41a5d:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a61:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   41a65:	8b 55 cc             	mov    -0x34(%rbp),%edx
   41a68:	ee                   	out    %al,(%dx)
}
   41a69:	90                   	nop
   41a6a:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   41a71:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a75:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   41a79:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   41a7c:	ee                   	out    %al,(%dx)
}
   41a7d:	90                   	nop
   41a7e:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   41a85:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a89:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   41a8d:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41a90:	ee                   	out    %al,(%dx)
}
   41a91:	90                   	nop
   41a92:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   41a99:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a9d:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41aa1:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41aa4:	ee                   	out    %al,(%dx)
}
   41aa5:	90                   	nop
   41aa6:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   41aad:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ab1:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41ab5:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41ab8:	ee                   	out    %al,(%dx)
}
   41ab9:	90                   	nop
   41aba:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   41ac1:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ac5:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41ac9:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41acc:	ee                   	out    %al,(%dx)
}
   41acd:	90                   	nop
   41ace:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   41ad5:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ad9:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41add:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41ae0:	ee                   	out    %al,(%dx)
}
   41ae1:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   41ae2:	e8 a5 fe ff ff       	call   4198c <interrupt_mask>
}
   41ae7:	90                   	nop
   41ae8:	c9                   	leave  
   41ae9:	c3                   	ret    

0000000000041aea <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   41aea:	55                   	push   %rbp
   41aeb:	48 89 e5             	mov    %rsp,%rbp
   41aee:	48 83 ec 28          	sub    $0x28,%rsp
   41af2:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   41af5:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41af9:	0f 8e 9e 00 00 00    	jle    41b9d <timer_init+0xb3>
   41aff:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   41b06:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b0a:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41b0e:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41b11:	ee                   	out    %al,(%dx)
}
   41b12:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   41b13:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41b16:	89 c2                	mov    %eax,%edx
   41b18:	c1 ea 1f             	shr    $0x1f,%edx
   41b1b:	01 d0                	add    %edx,%eax
   41b1d:	d1 f8                	sar    %eax
   41b1f:	05 de 34 12 00       	add    $0x1234de,%eax
   41b24:	99                   	cltd   
   41b25:	f7 7d dc             	idivl  -0x24(%rbp)
   41b28:	89 c2                	mov    %eax,%edx
   41b2a:	89 d0                	mov    %edx,%eax
   41b2c:	c1 f8 1f             	sar    $0x1f,%eax
   41b2f:	c1 e8 18             	shr    $0x18,%eax
   41b32:	01 c2                	add    %eax,%edx
   41b34:	0f b6 d2             	movzbl %dl,%edx
   41b37:	29 c2                	sub    %eax,%edx
   41b39:	89 d0                	mov    %edx,%eax
   41b3b:	0f b6 c0             	movzbl %al,%eax
   41b3e:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   41b45:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b48:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41b4c:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41b4f:	ee                   	out    %al,(%dx)
}
   41b50:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   41b51:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41b54:	89 c2                	mov    %eax,%edx
   41b56:	c1 ea 1f             	shr    $0x1f,%edx
   41b59:	01 d0                	add    %edx,%eax
   41b5b:	d1 f8                	sar    %eax
   41b5d:	05 de 34 12 00       	add    $0x1234de,%eax
   41b62:	99                   	cltd   
   41b63:	f7 7d dc             	idivl  -0x24(%rbp)
   41b66:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41b6c:	85 c0                	test   %eax,%eax
   41b6e:	0f 48 c2             	cmovs  %edx,%eax
   41b71:	c1 f8 08             	sar    $0x8,%eax
   41b74:	0f b6 c0             	movzbl %al,%eax
   41b77:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   41b7e:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b81:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41b85:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41b88:	ee                   	out    %al,(%dx)
}
   41b89:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   41b8a:	0f b7 05 4f f8 00 00 	movzwl 0xf84f(%rip),%eax        # 513e0 <interrupts_enabled>
   41b91:	83 c8 01             	or     $0x1,%eax
   41b94:	66 89 05 45 f8 00 00 	mov    %ax,0xf845(%rip)        # 513e0 <interrupts_enabled>
   41b9b:	eb 11                	jmp    41bae <timer_init+0xc4>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   41b9d:	0f b7 05 3c f8 00 00 	movzwl 0xf83c(%rip),%eax        # 513e0 <interrupts_enabled>
   41ba4:	83 e0 fe             	and    $0xfffffffe,%eax
   41ba7:	66 89 05 32 f8 00 00 	mov    %ax,0xf832(%rip)        # 513e0 <interrupts_enabled>
    }
    interrupt_mask();
   41bae:	e8 d9 fd ff ff       	call   4198c <interrupt_mask>
}
   41bb3:	90                   	nop
   41bb4:	c9                   	leave  
   41bb5:	c3                   	ret    

0000000000041bb6 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   41bb6:	55                   	push   %rbp
   41bb7:	48 89 e5             	mov    %rsp,%rbp
   41bba:	48 83 ec 08          	sub    $0x8,%rsp
   41bbe:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   41bc2:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   41bc7:	74 14                	je     41bdd <physical_memory_isreserved+0x27>
   41bc9:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   41bd0:	00 
   41bd1:	76 11                	jbe    41be4 <physical_memory_isreserved+0x2e>
   41bd3:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   41bda:	00 
   41bdb:	77 07                	ja     41be4 <physical_memory_isreserved+0x2e>
   41bdd:	b8 01 00 00 00       	mov    $0x1,%eax
   41be2:	eb 05                	jmp    41be9 <physical_memory_isreserved+0x33>
   41be4:	b8 00 00 00 00       	mov    $0x0,%eax
}
   41be9:	c9                   	leave  
   41bea:	c3                   	ret    

0000000000041beb <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   41beb:	55                   	push   %rbp
   41bec:	48 89 e5             	mov    %rsp,%rbp
   41bef:	48 83 ec 10          	sub    $0x10,%rsp
   41bf3:	89 7d fc             	mov    %edi,-0x4(%rbp)
   41bf6:	89 75 f8             	mov    %esi,-0x8(%rbp)
   41bf9:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   41bfc:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41bff:	c1 e0 10             	shl    $0x10,%eax
   41c02:	89 c2                	mov    %eax,%edx
   41c04:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41c07:	c1 e0 0b             	shl    $0xb,%eax
   41c0a:	09 c2                	or     %eax,%edx
   41c0c:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41c0f:	c1 e0 08             	shl    $0x8,%eax
   41c12:	09 d0                	or     %edx,%eax
}
   41c14:	c9                   	leave  
   41c15:	c3                   	ret    

0000000000041c16 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   41c16:	55                   	push   %rbp
   41c17:	48 89 e5             	mov    %rsp,%rbp
   41c1a:	48 83 ec 18          	sub    $0x18,%rsp
   41c1e:	89 7d ec             	mov    %edi,-0x14(%rbp)
   41c21:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   41c24:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41c27:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41c2a:	09 d0                	or     %edx,%eax
   41c2c:	0d 00 00 00 80       	or     $0x80000000,%eax
   41c31:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   41c38:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   41c3b:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41c3e:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41c41:	ef                   	out    %eax,(%dx)
}
   41c42:	90                   	nop
   41c43:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   41c4a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41c4d:	89 c2                	mov    %eax,%edx
   41c4f:	ed                   	in     (%dx),%eax
   41c50:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   41c53:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   41c56:	c9                   	leave  
   41c57:	c3                   	ret    

0000000000041c58 <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   41c58:	55                   	push   %rbp
   41c59:	48 89 e5             	mov    %rsp,%rbp
   41c5c:	48 83 ec 28          	sub    $0x28,%rsp
   41c60:	89 7d dc             	mov    %edi,-0x24(%rbp)
   41c63:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   41c66:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41c6d:	eb 73                	jmp    41ce2 <pci_find_device+0x8a>
        for (int slot = 0; slot != 32; ++slot) {
   41c6f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41c76:	eb 60                	jmp    41cd8 <pci_find_device+0x80>
            for (int func = 0; func != 8; ++func) {
   41c78:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41c7f:	eb 4a                	jmp    41ccb <pci_find_device+0x73>
                int configaddr = pci_make_configaddr(bus, slot, func);
   41c81:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41c84:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41c87:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41c8a:	89 ce                	mov    %ecx,%esi
   41c8c:	89 c7                	mov    %eax,%edi
   41c8e:	e8 58 ff ff ff       	call   41beb <pci_make_configaddr>
   41c93:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   41c96:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41c99:	be 00 00 00 00       	mov    $0x0,%esi
   41c9e:	89 c7                	mov    %eax,%edi
   41ca0:	e8 71 ff ff ff       	call   41c16 <pci_config_readl>
   41ca5:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   41ca8:	8b 45 d8             	mov    -0x28(%rbp),%eax
   41cab:	c1 e0 10             	shl    $0x10,%eax
   41cae:	0b 45 dc             	or     -0x24(%rbp),%eax
   41cb1:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   41cb4:	75 05                	jne    41cbb <pci_find_device+0x63>
                    return configaddr;
   41cb6:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41cb9:	eb 35                	jmp    41cf0 <pci_find_device+0x98>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   41cbb:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   41cbf:	75 06                	jne    41cc7 <pci_find_device+0x6f>
   41cc1:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41cc5:	74 0c                	je     41cd3 <pci_find_device+0x7b>
            for (int func = 0; func != 8; ++func) {
   41cc7:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41ccb:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   41ccf:	75 b0                	jne    41c81 <pci_find_device+0x29>
   41cd1:	eb 01                	jmp    41cd4 <pci_find_device+0x7c>
                    break;
   41cd3:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   41cd4:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41cd8:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   41cdc:	75 9a                	jne    41c78 <pci_find_device+0x20>
    for (int bus = 0; bus != 256; ++bus) {
   41cde:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41ce2:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   41ce9:	75 84                	jne    41c6f <pci_find_device+0x17>
                }
            }
        }
    }
    return -1;
   41ceb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   41cf0:	c9                   	leave  
   41cf1:	c3                   	ret    

0000000000041cf2 <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   41cf2:	55                   	push   %rbp
   41cf3:	48 89 e5             	mov    %rsp,%rbp
   41cf6:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   41cfa:	be 13 71 00 00       	mov    $0x7113,%esi
   41cff:	bf 86 80 00 00       	mov    $0x8086,%edi
   41d04:	e8 4f ff ff ff       	call   41c58 <pci_find_device>
   41d09:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   41d0c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   41d10:	78 30                	js     41d42 <poweroff+0x50>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   41d12:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41d15:	be 40 00 00 00       	mov    $0x40,%esi
   41d1a:	89 c7                	mov    %eax,%edi
   41d1c:	e8 f5 fe ff ff       	call   41c16 <pci_config_readl>
   41d21:	25 c0 ff 00 00       	and    $0xffc0,%eax
   41d26:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   41d29:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41d2c:	83 c0 04             	add    $0x4,%eax
   41d2f:	89 45 f4             	mov    %eax,-0xc(%rbp)
   41d32:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   41d38:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   41d3c:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41d3f:	66 ef                	out    %ax,(%dx)
}
   41d41:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   41d42:	ba 40 50 04 00       	mov    $0x45040,%edx
   41d47:	be 00 c0 00 00       	mov    $0xc000,%esi
   41d4c:	bf 80 07 00 00       	mov    $0x780,%edi
   41d51:	b8 00 00 00 00       	mov    $0x0,%eax
   41d56:	e8 e8 2c 00 00       	call   44a43 <console_printf>
 spinloop: goto spinloop;
   41d5b:	eb fe                	jmp    41d5b <poweroff+0x69>

0000000000041d5d <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   41d5d:	55                   	push   %rbp
   41d5e:	48 89 e5             	mov    %rsp,%rbp
   41d61:	48 83 ec 10          	sub    $0x10,%rsp
   41d65:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   41d6c:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d70:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41d74:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41d77:	ee                   	out    %al,(%dx)
}
   41d78:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   41d79:	eb fe                	jmp    41d79 <reboot+0x1c>

0000000000041d7b <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   41d7b:	55                   	push   %rbp
   41d7c:	48 89 e5             	mov    %rsp,%rbp
   41d7f:	48 83 ec 10          	sub    $0x10,%rsp
   41d83:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41d87:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   41d8a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d8e:	48 83 c0 18          	add    $0x18,%rax
   41d92:	ba c0 00 00 00       	mov    $0xc0,%edx
   41d97:	be 00 00 00 00       	mov    $0x0,%esi
   41d9c:	48 89 c7             	mov    %rax,%rdi
   41d9f:	e8 e8 1e 00 00       	call   43c8c <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   41da4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41da8:	66 c7 80 b8 00 00 00 	movw   $0x13,0xb8(%rax)
   41daf:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   41db1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41db5:	48 c7 80 90 00 00 00 	movq   $0x23,0x90(%rax)
   41dbc:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   41dc0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41dc4:	48 c7 80 98 00 00 00 	movq   $0x23,0x98(%rax)
   41dcb:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   41dcf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41dd3:	66 c7 80 d0 00 00 00 	movw   $0x23,0xd0(%rax)
   41dda:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   41ddc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41de0:	48 c7 80 c0 00 00 00 	movq   $0x200,0xc0(%rax)
   41de7:	00 02 00 00 

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   41deb:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41dee:	83 e0 01             	and    $0x1,%eax
   41df1:	85 c0                	test   %eax,%eax
   41df3:	74 1c                	je     41e11 <process_init+0x96>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   41df5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41df9:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   41e00:	80 cc 30             	or     $0x30,%ah
   41e03:	48 89 c2             	mov    %rax,%rdx
   41e06:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e0a:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   41e11:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41e14:	83 e0 02             	and    $0x2,%eax
   41e17:	85 c0                	test   %eax,%eax
   41e19:	74 1c                	je     41e37 <process_init+0xbc>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   41e1b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e1f:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   41e26:	80 e4 fd             	and    $0xfd,%ah
   41e29:	48 89 c2             	mov    %rax,%rdx
   41e2c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e30:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    p->display_status = 1;
   41e37:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e3b:	c6 80 e8 00 00 00 01 	movb   $0x1,0xe8(%rax)
}
   41e42:	90                   	nop
   41e43:	c9                   	leave  
   41e44:	c3                   	ret    

0000000000041e45 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   41e45:	55                   	push   %rbp
   41e46:	48 89 e5             	mov    %rsp,%rbp
   41e49:	48 83 ec 28          	sub    $0x28,%rsp
   41e4d:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   41e50:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41e54:	78 09                	js     41e5f <console_show_cursor+0x1a>
   41e56:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   41e5d:	7e 07                	jle    41e66 <console_show_cursor+0x21>
        cpos = 0;
   41e5f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   41e66:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   41e6d:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e71:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41e75:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41e78:	ee                   	out    %al,(%dx)
}
   41e79:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   41e7a:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41e7d:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41e83:	85 c0                	test   %eax,%eax
   41e85:	0f 48 c2             	cmovs  %edx,%eax
   41e88:	c1 f8 08             	sar    $0x8,%eax
   41e8b:	0f b6 c0             	movzbl %al,%eax
   41e8e:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   41e95:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e98:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41e9c:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41e9f:	ee                   	out    %al,(%dx)
}
   41ea0:	90                   	nop
   41ea1:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   41ea8:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41eac:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41eb0:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41eb3:	ee                   	out    %al,(%dx)
}
   41eb4:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   41eb5:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41eb8:	89 d0                	mov    %edx,%eax
   41eba:	c1 f8 1f             	sar    $0x1f,%eax
   41ebd:	c1 e8 18             	shr    $0x18,%eax
   41ec0:	01 c2                	add    %eax,%edx
   41ec2:	0f b6 d2             	movzbl %dl,%edx
   41ec5:	29 c2                	sub    %eax,%edx
   41ec7:	89 d0                	mov    %edx,%eax
   41ec9:	0f b6 c0             	movzbl %al,%eax
   41ecc:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   41ed3:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ed6:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41eda:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41edd:	ee                   	out    %al,(%dx)
}
   41ede:	90                   	nop
}
   41edf:	90                   	nop
   41ee0:	c9                   	leave  
   41ee1:	c3                   	ret    

0000000000041ee2 <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   41ee2:	55                   	push   %rbp
   41ee3:	48 89 e5             	mov    %rsp,%rbp
   41ee6:	48 83 ec 20          	sub    $0x20,%rsp
   41eea:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41ef1:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41ef4:	89 c2                	mov    %eax,%edx
   41ef6:	ec                   	in     (%dx),%al
   41ef7:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   41efa:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   41efe:	0f b6 c0             	movzbl %al,%eax
   41f01:	83 e0 01             	and    $0x1,%eax
   41f04:	85 c0                	test   %eax,%eax
   41f06:	75 0a                	jne    41f12 <keyboard_readc+0x30>
        return -1;
   41f08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   41f0d:	e9 e7 01 00 00       	jmp    420f9 <keyboard_readc+0x217>
   41f12:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41f19:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41f1c:	89 c2                	mov    %eax,%edx
   41f1e:	ec                   	in     (%dx),%al
   41f1f:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   41f22:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   41f26:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   41f29:	0f b6 05 b2 f4 00 00 	movzbl 0xf4b2(%rip),%eax        # 513e2 <last_escape.2>
   41f30:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   41f33:	c6 05 a8 f4 00 00 00 	movb   $0x0,0xf4a8(%rip)        # 513e2 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   41f3a:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   41f3e:	75 11                	jne    41f51 <keyboard_readc+0x6f>
        last_escape = 0x80;
   41f40:	c6 05 9b f4 00 00 80 	movb   $0x80,0xf49b(%rip)        # 513e2 <last_escape.2>
        return 0;
   41f47:	b8 00 00 00 00       	mov    $0x0,%eax
   41f4c:	e9 a8 01 00 00       	jmp    420f9 <keyboard_readc+0x217>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   41f51:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41f55:	84 c0                	test   %al,%al
   41f57:	79 60                	jns    41fb9 <keyboard_readc+0xd7>
        int ch = keymap[(data & 0x7F) | escape];
   41f59:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41f5d:	83 e0 7f             	and    $0x7f,%eax
   41f60:	89 c2                	mov    %eax,%edx
   41f62:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   41f66:	09 d0                	or     %edx,%eax
   41f68:	48 98                	cltq   
   41f6a:	0f b6 80 60 50 04 00 	movzbl 0x45060(%rax),%eax
   41f71:	0f b6 c0             	movzbl %al,%eax
   41f74:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   41f77:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   41f7e:	7e 2f                	jle    41faf <keyboard_readc+0xcd>
   41f80:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   41f87:	7f 26                	jg     41faf <keyboard_readc+0xcd>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   41f89:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41f8c:	2d fa 00 00 00       	sub    $0xfa,%eax
   41f91:	ba 01 00 00 00       	mov    $0x1,%edx
   41f96:	89 c1                	mov    %eax,%ecx
   41f98:	d3 e2                	shl    %cl,%edx
   41f9a:	89 d0                	mov    %edx,%eax
   41f9c:	f7 d0                	not    %eax
   41f9e:	89 c2                	mov    %eax,%edx
   41fa0:	0f b6 05 3c f4 00 00 	movzbl 0xf43c(%rip),%eax        # 513e3 <modifiers.1>
   41fa7:	21 d0                	and    %edx,%eax
   41fa9:	88 05 34 f4 00 00    	mov    %al,0xf434(%rip)        # 513e3 <modifiers.1>
        }
        return 0;
   41faf:	b8 00 00 00 00       	mov    $0x0,%eax
   41fb4:	e9 40 01 00 00       	jmp    420f9 <keyboard_readc+0x217>
    }

    int ch = (unsigned char) keymap[data | escape];
   41fb9:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41fbd:	0a 45 fa             	or     -0x6(%rbp),%al
   41fc0:	0f b6 c0             	movzbl %al,%eax
   41fc3:	48 98                	cltq   
   41fc5:	0f b6 80 60 50 04 00 	movzbl 0x45060(%rax),%eax
   41fcc:	0f b6 c0             	movzbl %al,%eax
   41fcf:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   41fd2:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   41fd6:	7e 57                	jle    4202f <keyboard_readc+0x14d>
   41fd8:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   41fdc:	7f 51                	jg     4202f <keyboard_readc+0x14d>
        if (modifiers & MOD_CONTROL) {
   41fde:	0f b6 05 fe f3 00 00 	movzbl 0xf3fe(%rip),%eax        # 513e3 <modifiers.1>
   41fe5:	0f b6 c0             	movzbl %al,%eax
   41fe8:	83 e0 02             	and    $0x2,%eax
   41feb:	85 c0                	test   %eax,%eax
   41fed:	74 09                	je     41ff8 <keyboard_readc+0x116>
            ch -= 0x60;
   41fef:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   41ff3:	e9 fd 00 00 00       	jmp    420f5 <keyboard_readc+0x213>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   41ff8:	0f b6 05 e4 f3 00 00 	movzbl 0xf3e4(%rip),%eax        # 513e3 <modifiers.1>
   41fff:	0f b6 c0             	movzbl %al,%eax
   42002:	83 e0 01             	and    $0x1,%eax
   42005:	85 c0                	test   %eax,%eax
   42007:	0f 94 c2             	sete   %dl
   4200a:	0f b6 05 d2 f3 00 00 	movzbl 0xf3d2(%rip),%eax        # 513e3 <modifiers.1>
   42011:	0f b6 c0             	movzbl %al,%eax
   42014:	83 e0 08             	and    $0x8,%eax
   42017:	85 c0                	test   %eax,%eax
   42019:	0f 94 c0             	sete   %al
   4201c:	31 d0                	xor    %edx,%eax
   4201e:	84 c0                	test   %al,%al
   42020:	0f 84 cf 00 00 00    	je     420f5 <keyboard_readc+0x213>
            ch -= 0x20;
   42026:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   4202a:	e9 c6 00 00 00       	jmp    420f5 <keyboard_readc+0x213>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   4202f:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   42036:	7e 30                	jle    42068 <keyboard_readc+0x186>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   42038:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4203b:	2d fa 00 00 00       	sub    $0xfa,%eax
   42040:	ba 01 00 00 00       	mov    $0x1,%edx
   42045:	89 c1                	mov    %eax,%ecx
   42047:	d3 e2                	shl    %cl,%edx
   42049:	89 d0                	mov    %edx,%eax
   4204b:	89 c2                	mov    %eax,%edx
   4204d:	0f b6 05 8f f3 00 00 	movzbl 0xf38f(%rip),%eax        # 513e3 <modifiers.1>
   42054:	31 d0                	xor    %edx,%eax
   42056:	88 05 87 f3 00 00    	mov    %al,0xf387(%rip)        # 513e3 <modifiers.1>
        ch = 0;
   4205c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42063:	e9 8e 00 00 00       	jmp    420f6 <keyboard_readc+0x214>
    } else if (ch >= KEY_SHIFT) {
   42068:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   4206f:	7e 2d                	jle    4209e <keyboard_readc+0x1bc>
        modifiers |= 1 << (ch - KEY_SHIFT);
   42071:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42074:	2d fa 00 00 00       	sub    $0xfa,%eax
   42079:	ba 01 00 00 00       	mov    $0x1,%edx
   4207e:	89 c1                	mov    %eax,%ecx
   42080:	d3 e2                	shl    %cl,%edx
   42082:	89 d0                	mov    %edx,%eax
   42084:	89 c2                	mov    %eax,%edx
   42086:	0f b6 05 56 f3 00 00 	movzbl 0xf356(%rip),%eax        # 513e3 <modifiers.1>
   4208d:	09 d0                	or     %edx,%eax
   4208f:	88 05 4e f3 00 00    	mov    %al,0xf34e(%rip)        # 513e3 <modifiers.1>
        ch = 0;
   42095:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4209c:	eb 58                	jmp    420f6 <keyboard_readc+0x214>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   4209e:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   420a2:	7e 31                	jle    420d5 <keyboard_readc+0x1f3>
   420a4:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   420ab:	7f 28                	jg     420d5 <keyboard_readc+0x1f3>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   420ad:	8b 45 fc             	mov    -0x4(%rbp),%eax
   420b0:	8d 50 80             	lea    -0x80(%rax),%edx
   420b3:	0f b6 05 29 f3 00 00 	movzbl 0xf329(%rip),%eax        # 513e3 <modifiers.1>
   420ba:	0f b6 c0             	movzbl %al,%eax
   420bd:	83 e0 03             	and    $0x3,%eax
   420c0:	48 98                	cltq   
   420c2:	48 63 d2             	movslq %edx,%rdx
   420c5:	0f b6 84 90 60 51 04 	movzbl 0x45160(%rax,%rdx,4),%eax
   420cc:	00 
   420cd:	0f b6 c0             	movzbl %al,%eax
   420d0:	89 45 fc             	mov    %eax,-0x4(%rbp)
   420d3:	eb 21                	jmp    420f6 <keyboard_readc+0x214>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   420d5:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   420d9:	7f 1b                	jg     420f6 <keyboard_readc+0x214>
   420db:	0f b6 05 01 f3 00 00 	movzbl 0xf301(%rip),%eax        # 513e3 <modifiers.1>
   420e2:	0f b6 c0             	movzbl %al,%eax
   420e5:	83 e0 02             	and    $0x2,%eax
   420e8:	85 c0                	test   %eax,%eax
   420ea:	74 0a                	je     420f6 <keyboard_readc+0x214>
        ch = 0;
   420ec:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   420f3:	eb 01                	jmp    420f6 <keyboard_readc+0x214>
        if (modifiers & MOD_CONTROL) {
   420f5:	90                   	nop
    }

    return ch;
   420f6:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   420f9:	c9                   	leave  
   420fa:	c3                   	ret    

00000000000420fb <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   420fb:	55                   	push   %rbp
   420fc:	48 89 e5             	mov    %rsp,%rbp
   420ff:	48 83 ec 20          	sub    $0x20,%rsp
   42103:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   4210a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4210d:	89 c2                	mov    %eax,%edx
   4210f:	ec                   	in     (%dx),%al
   42110:	88 45 e3             	mov    %al,-0x1d(%rbp)
   42113:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   4211a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4211d:	89 c2                	mov    %eax,%edx
   4211f:	ec                   	in     (%dx),%al
   42120:	88 45 eb             	mov    %al,-0x15(%rbp)
   42123:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   4212a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4212d:	89 c2                	mov    %eax,%edx
   4212f:	ec                   	in     (%dx),%al
   42130:	88 45 f3             	mov    %al,-0xd(%rbp)
   42133:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   4213a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4213d:	89 c2                	mov    %eax,%edx
   4213f:	ec                   	in     (%dx),%al
   42140:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   42143:	90                   	nop
   42144:	c9                   	leave  
   42145:	c3                   	ret    

0000000000042146 <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   42146:	55                   	push   %rbp
   42147:	48 89 e5             	mov    %rsp,%rbp
   4214a:	48 83 ec 40          	sub    $0x40,%rsp
   4214e:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42152:	89 f0                	mov    %esi,%eax
   42154:	89 55 c0             	mov    %edx,-0x40(%rbp)
   42157:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   4215a:	8b 05 84 f2 00 00    	mov    0xf284(%rip),%eax        # 513e4 <initialized.0>
   42160:	85 c0                	test   %eax,%eax
   42162:	75 1e                	jne    42182 <parallel_port_putc+0x3c>
   42164:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   4216b:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4216f:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   42173:	8b 55 f8             	mov    -0x8(%rbp),%edx
   42176:	ee                   	out    %al,(%dx)
}
   42177:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   42178:	c7 05 62 f2 00 00 01 	movl   $0x1,0xf262(%rip)        # 513e4 <initialized.0>
   4217f:	00 00 00 
    }

    for (int i = 0;
   42182:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42189:	eb 09                	jmp    42194 <parallel_port_putc+0x4e>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   4218b:	e8 6b ff ff ff       	call   420fb <delay>
         ++i) {
   42190:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   42194:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   4219b:	7f 18                	jg     421b5 <parallel_port_putc+0x6f>
   4219d:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   421a4:	8b 45 f0             	mov    -0x10(%rbp),%eax
   421a7:	89 c2                	mov    %eax,%edx
   421a9:	ec                   	in     (%dx),%al
   421aa:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   421ad:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   421b1:	84 c0                	test   %al,%al
   421b3:	79 d6                	jns    4218b <parallel_port_putc+0x45>
    }
    outb(IO_PARALLEL1_DATA, c);
   421b5:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   421b9:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   421c0:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421c3:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   421c7:	8b 55 d8             	mov    -0x28(%rbp),%edx
   421ca:	ee                   	out    %al,(%dx)
}
   421cb:	90                   	nop
   421cc:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   421d3:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421d7:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   421db:	8b 55 e0             	mov    -0x20(%rbp),%edx
   421de:	ee                   	out    %al,(%dx)
}
   421df:	90                   	nop
   421e0:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   421e7:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421eb:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   421ef:	8b 55 e8             	mov    -0x18(%rbp),%edx
   421f2:	ee                   	out    %al,(%dx)
}
   421f3:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   421f4:	90                   	nop
   421f5:	c9                   	leave  
   421f6:	c3                   	ret    

00000000000421f7 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   421f7:	55                   	push   %rbp
   421f8:	48 89 e5             	mov    %rsp,%rbp
   421fb:	48 83 ec 20          	sub    $0x20,%rsp
   421ff:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42203:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   42207:	48 c7 45 f8 46 21 04 	movq   $0x42146,-0x8(%rbp)
   4220e:	00 
    printer_vprintf(&p, 0, format, val);
   4220f:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   42213:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   42217:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   4221b:	be 00 00 00 00       	mov    $0x0,%esi
   42220:	48 89 c7             	mov    %rax,%rdi
   42223:	e8 00 1d 00 00       	call   43f28 <printer_vprintf>
}
   42228:	90                   	nop
   42229:	c9                   	leave  
   4222a:	c3                   	ret    

000000000004222b <log_printf>:

void log_printf(const char* format, ...) {
   4222b:	55                   	push   %rbp
   4222c:	48 89 e5             	mov    %rsp,%rbp
   4222f:	48 83 ec 60          	sub    $0x60,%rsp
   42233:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42237:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   4223b:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   4223f:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42243:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42247:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   4224b:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   42252:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42256:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   4225a:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4225e:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   42262:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   42266:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4226a:	48 89 d6             	mov    %rdx,%rsi
   4226d:	48 89 c7             	mov    %rax,%rdi
   42270:	e8 82 ff ff ff       	call   421f7 <log_vprintf>
    va_end(val);
}
   42275:	90                   	nop
   42276:	c9                   	leave  
   42277:	c3                   	ret    

0000000000042278 <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   42278:	55                   	push   %rbp
   42279:	48 89 e5             	mov    %rsp,%rbp
   4227c:	48 83 ec 40          	sub    $0x40,%rsp
   42280:	89 7d dc             	mov    %edi,-0x24(%rbp)
   42283:	89 75 d8             	mov    %esi,-0x28(%rbp)
   42286:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   4228a:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   4228e:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   42292:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42296:	48 8b 0a             	mov    (%rdx),%rcx
   42299:	48 89 08             	mov    %rcx,(%rax)
   4229c:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   422a0:	48 89 48 08          	mov    %rcx,0x8(%rax)
   422a4:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   422a8:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   422ac:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   422b0:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   422b4:	48 89 d6             	mov    %rdx,%rsi
   422b7:	48 89 c7             	mov    %rax,%rdi
   422ba:	e8 38 ff ff ff       	call   421f7 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   422bf:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   422c3:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   422c7:	8b 75 d8             	mov    -0x28(%rbp),%esi
   422ca:	8b 45 dc             	mov    -0x24(%rbp),%eax
   422cd:	89 c7                	mov    %eax,%edi
   422cf:	e8 03 27 00 00       	call   449d7 <console_vprintf>
}
   422d4:	c9                   	leave  
   422d5:	c3                   	ret    

00000000000422d6 <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   422d6:	55                   	push   %rbp
   422d7:	48 89 e5             	mov    %rsp,%rbp
   422da:	48 83 ec 60          	sub    $0x60,%rsp
   422de:	89 7d ac             	mov    %edi,-0x54(%rbp)
   422e1:	89 75 a8             	mov    %esi,-0x58(%rbp)
   422e4:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   422e8:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   422ec:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   422f0:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   422f4:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   422fb:	48 8d 45 10          	lea    0x10(%rbp),%rax
   422ff:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42303:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42307:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   4230b:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   4230f:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   42313:	8b 75 a8             	mov    -0x58(%rbp),%esi
   42316:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42319:	89 c7                	mov    %eax,%edi
   4231b:	e8 58 ff ff ff       	call   42278 <error_vprintf>
   42320:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   42323:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   42326:	c9                   	leave  
   42327:	c3                   	ret    

0000000000042328 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'm', and 'c' cause a soft
//    reboot where the kernel runs the allocator programs, "malloc", or
//    "alloctests", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   42328:	55                   	push   %rbp
   42329:	48 89 e5             	mov    %rsp,%rbp
   4232c:	53                   	push   %rbx
   4232d:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   42331:	e8 ac fb ff ff       	call   41ee2 <keyboard_readc>
   42336:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'm' || c == 'c' || c == 't'|| c =='2') {
   42339:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   4233d:	74 1c                	je     4235b <check_keyboard+0x33>
   4233f:	83 7d e4 6d          	cmpl   $0x6d,-0x1c(%rbp)
   42343:	74 16                	je     4235b <check_keyboard+0x33>
   42345:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   42349:	74 10                	je     4235b <check_keyboard+0x33>
   4234b:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   4234f:	74 0a                	je     4235b <check_keyboard+0x33>
   42351:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42355:	0f 85 e9 00 00 00    	jne    42444 <check_keyboard+0x11c>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   4235b:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   42362:	00 
        memset(pt, 0, PAGESIZE * 3);
   42363:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42367:	ba 00 30 00 00       	mov    $0x3000,%edx
   4236c:	be 00 00 00 00       	mov    $0x0,%esi
   42371:	48 89 c7             	mov    %rax,%rdi
   42374:	e8 13 19 00 00       	call   43c8c <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   42379:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4237d:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   42384:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42388:	48 05 00 10 00 00    	add    $0x1000,%rax
   4238e:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   42395:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42399:	48 05 00 20 00 00    	add    $0x2000,%rax
   4239f:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   423a6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   423aa:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   423ae:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   423b2:	0f 22 d8             	mov    %rax,%cr3
}
   423b5:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   423b6:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "malloc";
   423bd:	48 c7 45 e8 b8 51 04 	movq   $0x451b8,-0x18(%rbp)
   423c4:	00 
        if (c == 'a') {
   423c5:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   423c9:	75 0a                	jne    423d5 <check_keyboard+0xad>
            argument = "allocator";
   423cb:	48 c7 45 e8 bf 51 04 	movq   $0x451bf,-0x18(%rbp)
   423d2:	00 
   423d3:	eb 2e                	jmp    42403 <check_keyboard+0xdb>
        } else if (c == 'c') {
   423d5:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   423d9:	75 0a                	jne    423e5 <check_keyboard+0xbd>
            argument = "alloctests";
   423db:	48 c7 45 e8 c9 51 04 	movq   $0x451c9,-0x18(%rbp)
   423e2:	00 
   423e3:	eb 1e                	jmp    42403 <check_keyboard+0xdb>
        } else if(c == 't'){
   423e5:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   423e9:	75 0a                	jne    423f5 <check_keyboard+0xcd>
            argument = "test";
   423eb:	48 c7 45 e8 d4 51 04 	movq   $0x451d4,-0x18(%rbp)
   423f2:	00 
   423f3:	eb 0e                	jmp    42403 <check_keyboard+0xdb>
        }
        else if(c == '2'){
   423f5:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   423f9:	75 08                	jne    42403 <check_keyboard+0xdb>
            argument = "test2";
   423fb:	48 c7 45 e8 d9 51 04 	movq   $0x451d9,-0x18(%rbp)
   42402:	00 
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   42403:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42407:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   4240b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42410:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   42414:	73 14                	jae    4242a <check_keyboard+0x102>
   42416:	ba df 51 04 00       	mov    $0x451df,%edx
   4241b:	be 5c 02 00 00       	mov    $0x25c,%esi
   42420:	bf fb 51 04 00       	mov    $0x451fb,%edi
   42425:	e8 1f 01 00 00       	call   42549 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   4242a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4242e:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   42431:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   42435:	48 89 c3             	mov    %rax,%rbx
   42438:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   4243d:	e9 be db ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'm' || c == 'c' || c == 't'|| c =='2') {
   42442:	eb 11                	jmp    42455 <check_keyboard+0x12d>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   42444:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   42448:	74 06                	je     42450 <check_keyboard+0x128>
   4244a:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   4244e:	75 05                	jne    42455 <check_keyboard+0x12d>
        poweroff();
   42450:	e8 9d f8 ff ff       	call   41cf2 <poweroff>
    }
    return c;
   42455:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   42458:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   4245c:	c9                   	leave  
   4245d:	c3                   	ret    

000000000004245e <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   4245e:	55                   	push   %rbp
   4245f:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   42462:	e8 c1 fe ff ff       	call   42328 <check_keyboard>
   42467:	eb f9                	jmp    42462 <fail+0x4>

0000000000042469 <kernel_panic>:

// kernel_panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void kernel_panic(const char* format, ...) {
   42469:	55                   	push   %rbp
   4246a:	48 89 e5             	mov    %rsp,%rbp
   4246d:	48 83 ec 60          	sub    $0x60,%rsp
   42471:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42475:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42479:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   4247d:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42481:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42485:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42489:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   42490:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42494:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   42498:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4249c:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   424a0:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   424a5:	0f 84 80 00 00 00    	je     4252b <kernel_panic+0xc2>
        // Print kernel_panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   424ab:	ba 0f 52 04 00       	mov    $0x4520f,%edx
   424b0:	be 00 c0 00 00       	mov    $0xc000,%esi
   424b5:	bf 30 07 00 00       	mov    $0x730,%edi
   424ba:	b8 00 00 00 00       	mov    $0x0,%eax
   424bf:	e8 12 fe ff ff       	call   422d6 <error_printf>
   424c4:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   424c7:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   424cb:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   424cf:	8b 45 cc             	mov    -0x34(%rbp),%eax
   424d2:	be 00 c0 00 00       	mov    $0xc000,%esi
   424d7:	89 c7                	mov    %eax,%edi
   424d9:	e8 9a fd ff ff       	call   42278 <error_vprintf>
   424de:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   424e1:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   424e4:	48 63 c1             	movslq %ecx,%rax
   424e7:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   424ee:	48 c1 e8 20          	shr    $0x20,%rax
   424f2:	89 c2                	mov    %eax,%edx
   424f4:	c1 fa 05             	sar    $0x5,%edx
   424f7:	89 c8                	mov    %ecx,%eax
   424f9:	c1 f8 1f             	sar    $0x1f,%eax
   424fc:	29 c2                	sub    %eax,%edx
   424fe:	89 d0                	mov    %edx,%eax
   42500:	c1 e0 02             	shl    $0x2,%eax
   42503:	01 d0                	add    %edx,%eax
   42505:	c1 e0 04             	shl    $0x4,%eax
   42508:	29 c1                	sub    %eax,%ecx
   4250a:	89 ca                	mov    %ecx,%edx
   4250c:	85 d2                	test   %edx,%edx
   4250e:	74 34                	je     42544 <kernel_panic+0xdb>
            error_printf(cpos, 0xC000, "\n");
   42510:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42513:	ba 17 52 04 00       	mov    $0x45217,%edx
   42518:	be 00 c0 00 00       	mov    $0xc000,%esi
   4251d:	89 c7                	mov    %eax,%edi
   4251f:	b8 00 00 00 00       	mov    $0x0,%eax
   42524:	e8 ad fd ff ff       	call   422d6 <error_printf>
   42529:	eb 19                	jmp    42544 <kernel_panic+0xdb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   4252b:	ba 19 52 04 00       	mov    $0x45219,%edx
   42530:	be 00 c0 00 00       	mov    $0xc000,%esi
   42535:	bf 30 07 00 00       	mov    $0x730,%edi
   4253a:	b8 00 00 00 00       	mov    $0x0,%eax
   4253f:	e8 92 fd ff ff       	call   422d6 <error_printf>
    }

    va_end(val);
    fail();
   42544:	e8 15 ff ff ff       	call   4245e <fail>

0000000000042549 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   42549:	55                   	push   %rbp
   4254a:	48 89 e5             	mov    %rsp,%rbp
   4254d:	48 83 ec 20          	sub    $0x20,%rsp
   42551:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42555:	89 75 f4             	mov    %esi,-0xc(%rbp)
   42558:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    kernel_panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   4255c:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   42560:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42563:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42567:	48 89 c6             	mov    %rax,%rsi
   4256a:	bf 1f 52 04 00       	mov    $0x4521f,%edi
   4256f:	b8 00 00 00 00       	mov    $0x0,%eax
   42574:	e8 f0 fe ff ff       	call   42469 <kernel_panic>

0000000000042579 <default_exception>:
}

void default_exception(proc* p){
   42579:	55                   	push   %rbp
   4257a:	48 89 e5             	mov    %rsp,%rbp
   4257d:	48 83 ec 20          	sub    $0x20,%rsp
   42581:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   42585:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42589:	48 83 c0 18          	add    $0x18,%rax
   4258d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    kernel_panic("Unexpected exception %d!\n", reg->reg_intno);
   42591:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42595:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   4259c:	48 89 c6             	mov    %rax,%rsi
   4259f:	bf 3d 52 04 00       	mov    $0x4523d,%edi
   425a4:	b8 00 00 00 00       	mov    $0x0,%eax
   425a9:	e8 bb fe ff ff       	call   42469 <kernel_panic>

00000000000425ae <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   425ae:	55                   	push   %rbp
   425af:	48 89 e5             	mov    %rsp,%rbp
   425b2:	48 83 ec 10          	sub    $0x10,%rsp
   425b6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   425ba:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   425bd:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   425c1:	78 06                	js     425c9 <pageindex+0x1b>
   425c3:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   425c7:	7e 14                	jle    425dd <pageindex+0x2f>
   425c9:	ba 58 52 04 00       	mov    $0x45258,%edx
   425ce:	be 1e 00 00 00       	mov    $0x1e,%esi
   425d3:	bf 71 52 04 00       	mov    $0x45271,%edi
   425d8:	e8 6c ff ff ff       	call   42549 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   425dd:	b8 03 00 00 00       	mov    $0x3,%eax
   425e2:	2b 45 f4             	sub    -0xc(%rbp),%eax
   425e5:	89 c2                	mov    %eax,%edx
   425e7:	89 d0                	mov    %edx,%eax
   425e9:	c1 e0 03             	shl    $0x3,%eax
   425ec:	01 d0                	add    %edx,%eax
   425ee:	83 c0 0c             	add    $0xc,%eax
   425f1:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   425f5:	89 c1                	mov    %eax,%ecx
   425f7:	48 d3 ea             	shr    %cl,%rdx
   425fa:	48 89 d0             	mov    %rdx,%rax
   425fd:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   42602:	c9                   	leave  
   42603:	c3                   	ret    

0000000000042604 <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   42604:	55                   	push   %rbp
   42605:	48 89 e5             	mov    %rsp,%rbp
   42608:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   4260c:	48 c7 05 e9 f9 00 00 	movq   $0x53000,0xf9e9(%rip)        # 52000 <kernel_pagetable>
   42613:	00 30 05 00 
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   42617:	ba 00 50 00 00       	mov    $0x5000,%edx
   4261c:	be 00 00 00 00       	mov    $0x0,%esi
   42621:	bf 00 30 05 00       	mov    $0x53000,%edi
   42626:	e8 61 16 00 00       	call   43c8c <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   4262b:	b8 00 40 05 00       	mov    $0x54000,%eax
   42630:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   42634:	48 89 05 c5 09 01 00 	mov    %rax,0x109c5(%rip)        # 53000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   4263b:	b8 00 50 05 00       	mov    $0x55000,%eax
   42640:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   42644:	48 89 05 b5 19 01 00 	mov    %rax,0x119b5(%rip)        # 54000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   4264b:	b8 00 60 05 00       	mov    $0x56000,%eax
   42650:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   42654:	48 89 05 a5 29 01 00 	mov    %rax,0x129a5(%rip)        # 55000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   4265b:	b8 00 70 05 00       	mov    $0x57000,%eax
   42660:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   42664:	48 89 05 9d 29 01 00 	mov    %rax,0x1299d(%rip)        # 55008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   4266b:	48 8b 05 8e f9 00 00 	mov    0xf98e(%rip),%rax        # 52000 <kernel_pagetable>
   42672:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42678:	b9 00 00 20 00       	mov    $0x200000,%ecx
   4267d:	ba 00 00 00 00       	mov    $0x0,%edx
   42682:	be 00 00 00 00       	mov    $0x0,%esi
   42687:	48 89 c7             	mov    %rax,%rdi
   4268a:	e8 b9 01 00 00       	call   42848 <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   4268f:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42696:	00 
   42697:	eb 62                	jmp    426fb <virtual_memory_init+0xf7>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   42699:	48 8b 0d 60 f9 00 00 	mov    0xf960(%rip),%rcx        # 52000 <kernel_pagetable>
   426a0:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   426a4:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   426a8:	48 89 ce             	mov    %rcx,%rsi
   426ab:	48 89 c7             	mov    %rax,%rdi
   426ae:	e8 58 05 00 00       	call   42c0b <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l4pagetable ?
        assert(vmap.pa == addr);
   426b3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   426b7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   426bb:	74 14                	je     426d1 <virtual_memory_init+0xcd>
   426bd:	ba 85 52 04 00       	mov    $0x45285,%edx
   426c2:	be 2d 00 00 00       	mov    $0x2d,%esi
   426c7:	bf 95 52 04 00       	mov    $0x45295,%edi
   426cc:	e8 78 fe ff ff       	call   42549 <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   426d1:	8b 45 f0             	mov    -0x10(%rbp),%eax
   426d4:	48 98                	cltq   
   426d6:	83 e0 03             	and    $0x3,%eax
   426d9:	48 83 f8 03          	cmp    $0x3,%rax
   426dd:	74 14                	je     426f3 <virtual_memory_init+0xef>
   426df:	ba a8 52 04 00       	mov    $0x452a8,%edx
   426e4:	be 2e 00 00 00       	mov    $0x2e,%esi
   426e9:	bf 95 52 04 00       	mov    $0x45295,%edi
   426ee:	e8 56 fe ff ff       	call   42549 <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   426f3:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   426fa:	00 
   426fb:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   42702:	00 
   42703:	76 94                	jbe    42699 <virtual_memory_init+0x95>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   42705:	48 8b 05 f4 f8 00 00 	mov    0xf8f4(%rip),%rax        # 52000 <kernel_pagetable>
   4270c:	48 89 c7             	mov    %rax,%rdi
   4270f:	e8 03 00 00 00       	call   42717 <set_pagetable>
}
   42714:	90                   	nop
   42715:	c9                   	leave  
   42716:	c3                   	ret    

0000000000042717 <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls kernel_panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   42717:	55                   	push   %rbp
   42718:	48 89 e5             	mov    %rsp,%rbp
   4271b:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   4271f:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   42723:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42727:	25 ff 0f 00 00       	and    $0xfff,%eax
   4272c:	48 85 c0             	test   %rax,%rax
   4272f:	74 14                	je     42745 <set_pagetable+0x2e>
   42731:	ba d5 52 04 00       	mov    $0x452d5,%edx
   42736:	be 3d 00 00 00       	mov    $0x3d,%esi
   4273b:	bf 95 52 04 00       	mov    $0x45295,%edi
   42740:	e8 04 fe ff ff       	call   42549 <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   42745:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   4274a:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   4274e:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42752:	48 89 ce             	mov    %rcx,%rsi
   42755:	48 89 c7             	mov    %rax,%rdi
   42758:	e8 ae 04 00 00       	call   42c0b <virtual_memory_lookup>
   4275d:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42761:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42766:	48 39 d0             	cmp    %rdx,%rax
   42769:	74 14                	je     4277f <set_pagetable+0x68>
   4276b:	ba f0 52 04 00       	mov    $0x452f0,%edx
   42770:	be 3f 00 00 00       	mov    $0x3f,%esi
   42775:	bf 95 52 04 00       	mov    $0x45295,%edi
   4277a:	e8 ca fd ff ff       	call   42549 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   4277f:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   42783:	48 8b 0d 76 f8 00 00 	mov    0xf876(%rip),%rcx        # 52000 <kernel_pagetable>
   4278a:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   4278e:	48 89 ce             	mov    %rcx,%rsi
   42791:	48 89 c7             	mov    %rax,%rdi
   42794:	e8 72 04 00 00       	call   42c0b <virtual_memory_lookup>
   42799:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   4279d:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   427a1:	48 39 c2             	cmp    %rax,%rdx
   427a4:	74 14                	je     427ba <set_pagetable+0xa3>
   427a6:	ba 58 53 04 00       	mov    $0x45358,%edx
   427ab:	be 41 00 00 00       	mov    $0x41,%esi
   427b0:	bf 95 52 04 00       	mov    $0x45295,%edi
   427b5:	e8 8f fd ff ff       	call   42549 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   427ba:	48 8b 05 3f f8 00 00 	mov    0xf83f(%rip),%rax        # 52000 <kernel_pagetable>
   427c1:	48 89 c2             	mov    %rax,%rdx
   427c4:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   427c8:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   427cc:	48 89 ce             	mov    %rcx,%rsi
   427cf:	48 89 c7             	mov    %rax,%rdi
   427d2:	e8 34 04 00 00       	call   42c0b <virtual_memory_lookup>
   427d7:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   427db:	48 8b 15 1e f8 00 00 	mov    0xf81e(%rip),%rdx        # 52000 <kernel_pagetable>
   427e2:	48 39 d0             	cmp    %rdx,%rax
   427e5:	74 14                	je     427fb <set_pagetable+0xe4>
   427e7:	ba b8 53 04 00       	mov    $0x453b8,%edx
   427ec:	be 43 00 00 00       	mov    $0x43,%esi
   427f1:	bf 95 52 04 00       	mov    $0x45295,%edi
   427f6:	e8 4e fd ff ff       	call   42549 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   427fb:	ba 48 28 04 00       	mov    $0x42848,%edx
   42800:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42804:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42808:	48 89 ce             	mov    %rcx,%rsi
   4280b:	48 89 c7             	mov    %rax,%rdi
   4280e:	e8 f8 03 00 00       	call   42c0b <virtual_memory_lookup>
   42813:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42817:	ba 48 28 04 00       	mov    $0x42848,%edx
   4281c:	48 39 d0             	cmp    %rdx,%rax
   4281f:	74 14                	je     42835 <set_pagetable+0x11e>
   42821:	ba 20 54 04 00       	mov    $0x45420,%edx
   42826:	be 45 00 00 00       	mov    $0x45,%esi
   4282b:	bf 95 52 04 00       	mov    $0x45295,%edi
   42830:	e8 14 fd ff ff       	call   42549 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   42835:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42839:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   4283d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42841:	0f 22 d8             	mov    %rax,%cr3
}
   42844:	90                   	nop
}
   42845:	90                   	nop
   42846:	c9                   	leave  
   42847:	c3                   	ret    

0000000000042848 <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   42848:	55                   	push   %rbp
   42849:	48 89 e5             	mov    %rsp,%rbp
   4284c:	53                   	push   %rbx
   4284d:	48 83 ec 58          	sub    $0x58,%rsp
   42851:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42855:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42859:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   4285d:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
   42861:	44 89 45 ac          	mov    %r8d,-0x54(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   42865:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42869:	25 ff 0f 00 00       	and    $0xfff,%eax
   4286e:	48 85 c0             	test   %rax,%rax
   42871:	74 14                	je     42887 <virtual_memory_map+0x3f>
   42873:	ba 86 54 04 00       	mov    $0x45486,%edx
   42878:	be 66 00 00 00       	mov    $0x66,%esi
   4287d:	bf 95 52 04 00       	mov    $0x45295,%edi
   42882:	e8 c2 fc ff ff       	call   42549 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   42887:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   4288b:	25 ff 0f 00 00       	and    $0xfff,%eax
   42890:	48 85 c0             	test   %rax,%rax
   42893:	74 14                	je     428a9 <virtual_memory_map+0x61>
   42895:	ba 99 54 04 00       	mov    $0x45499,%edx
   4289a:	be 67 00 00 00       	mov    $0x67,%esi
   4289f:	bf 95 52 04 00       	mov    $0x45295,%edi
   428a4:	e8 a0 fc ff ff       	call   42549 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   428a9:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   428ad:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   428b1:	48 01 d0             	add    %rdx,%rax
   428b4:	48 3b 45 c0          	cmp    -0x40(%rbp),%rax
   428b8:	73 24                	jae    428de <virtual_memory_map+0x96>
   428ba:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   428be:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   428c2:	48 01 d0             	add    %rdx,%rax
   428c5:	48 85 c0             	test   %rax,%rax
   428c8:	74 14                	je     428de <virtual_memory_map+0x96>
   428ca:	ba ac 54 04 00       	mov    $0x454ac,%edx
   428cf:	be 68 00 00 00       	mov    $0x68,%esi
   428d4:	bf 95 52 04 00       	mov    $0x45295,%edi
   428d9:	e8 6b fc ff ff       	call   42549 <assert_fail>
    if (perm & PTE_P) {
   428de:	8b 45 ac             	mov    -0x54(%rbp),%eax
   428e1:	48 98                	cltq   
   428e3:	83 e0 01             	and    $0x1,%eax
   428e6:	48 85 c0             	test   %rax,%rax
   428e9:	74 6e                	je     42959 <virtual_memory_map+0x111>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   428eb:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   428ef:	25 ff 0f 00 00       	and    $0xfff,%eax
   428f4:	48 85 c0             	test   %rax,%rax
   428f7:	74 14                	je     4290d <virtual_memory_map+0xc5>
   428f9:	ba ca 54 04 00       	mov    $0x454ca,%edx
   428fe:	be 6a 00 00 00       	mov    $0x6a,%esi
   42903:	bf 95 52 04 00       	mov    $0x45295,%edi
   42908:	e8 3c fc ff ff       	call   42549 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   4290d:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42911:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42915:	48 01 d0             	add    %rdx,%rax
   42918:	48 3b 45 b8          	cmp    -0x48(%rbp),%rax
   4291c:	73 14                	jae    42932 <virtual_memory_map+0xea>
   4291e:	ba dd 54 04 00       	mov    $0x454dd,%edx
   42923:	be 6b 00 00 00       	mov    $0x6b,%esi
   42928:	bf 95 52 04 00       	mov    $0x45295,%edi
   4292d:	e8 17 fc ff ff       	call   42549 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   42932:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42936:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   4293a:	48 01 d0             	add    %rdx,%rax
   4293d:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   42943:	76 14                	jbe    42959 <virtual_memory_map+0x111>
   42945:	ba eb 54 04 00       	mov    $0x454eb,%edx
   4294a:	be 6c 00 00 00       	mov    $0x6c,%esi
   4294f:	bf 95 52 04 00       	mov    $0x45295,%edi
   42954:	e8 f0 fb ff ff       	call   42549 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   42959:	83 7d ac 00          	cmpl   $0x0,-0x54(%rbp)
   4295d:	78 09                	js     42968 <virtual_memory_map+0x120>
   4295f:	81 7d ac ff 0f 00 00 	cmpl   $0xfff,-0x54(%rbp)
   42966:	7e 14                	jle    4297c <virtual_memory_map+0x134>
   42968:	ba 07 55 04 00       	mov    $0x45507,%edx
   4296d:	be 6e 00 00 00       	mov    $0x6e,%esi
   42972:	bf 95 52 04 00       	mov    $0x45295,%edi
   42977:	e8 cd fb ff ff       	call   42549 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   4297c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42980:	25 ff 0f 00 00       	and    $0xfff,%eax
   42985:	48 85 c0             	test   %rax,%rax
   42988:	74 14                	je     4299e <virtual_memory_map+0x156>
   4298a:	ba 28 55 04 00       	mov    $0x45528,%edx
   4298f:	be 6f 00 00 00       	mov    $0x6f,%esi
   42994:	bf 95 52 04 00       	mov    $0x45295,%edi
   42999:	e8 ab fb ff ff       	call   42549 <assert_fail>

    int last_index123 = -1;
   4299e:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%rbp)
    x86_64_pagetable* l4pagetable = NULL;
   429a5:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
   429ac:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   429ad:	e9 e1 00 00 00       	jmp    42a93 <virtual_memory_map+0x24b>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   429b2:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   429b6:	48 c1 e8 15          	shr    $0x15,%rax
   429ba:	89 45 dc             	mov    %eax,-0x24(%rbp)
        if (cur_index123 != last_index123) {
   429bd:	8b 45 dc             	mov    -0x24(%rbp),%eax
   429c0:	3b 45 ec             	cmp    -0x14(%rbp),%eax
   429c3:	74 20                	je     429e5 <virtual_memory_map+0x19d>
            // find pointer to last level pagetable for current va
            l4pagetable = lookup_l4pagetable(pagetable, va, perm);
   429c5:	8b 55 ac             	mov    -0x54(%rbp),%edx
   429c8:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   429cc:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   429d0:	48 89 ce             	mov    %rcx,%rsi
   429d3:	48 89 c7             	mov    %rax,%rdi
   429d6:	e8 ce 00 00 00       	call   42aa9 <lookup_l4pagetable>
   429db:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            last_index123 = cur_index123;
   429df:	8b 45 dc             	mov    -0x24(%rbp),%eax
   429e2:	89 45 ec             	mov    %eax,-0x14(%rbp)
        }
        if ((perm & PTE_P) && l4pagetable) { // if page is marked present
   429e5:	8b 45 ac             	mov    -0x54(%rbp),%eax
   429e8:	48 98                	cltq   
   429ea:	83 e0 01             	and    $0x1,%eax
   429ed:	48 85 c0             	test   %rax,%rax
   429f0:	74 34                	je     42a26 <virtual_memory_map+0x1de>
   429f2:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   429f7:	74 2d                	je     42a26 <virtual_memory_map+0x1de>
            // set page table entry to pa and perm
            l4pagetable->entry[L4PAGEINDEX(va)] = pa | perm;
   429f9:	8b 45 ac             	mov    -0x54(%rbp),%eax
   429fc:	48 63 d8             	movslq %eax,%rbx
   429ff:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42a03:	be 03 00 00 00       	mov    $0x3,%esi
   42a08:	48 89 c7             	mov    %rax,%rdi
   42a0b:	e8 9e fb ff ff       	call   425ae <pageindex>
   42a10:	89 c2                	mov    %eax,%edx
   42a12:	48 0b 5d b8          	or     -0x48(%rbp),%rbx
   42a16:	48 89 d9             	mov    %rbx,%rcx
   42a19:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42a1d:	48 63 d2             	movslq %edx,%rdx
   42a20:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42a24:	eb 55                	jmp    42a7b <virtual_memory_map+0x233>
        } else if (l4pagetable) { // if page is NOT marked present
   42a26:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42a2b:	74 26                	je     42a53 <virtual_memory_map+0x20b>
            // set page table entry to just perm
            l4pagetable->entry[L4PAGEINDEX(va)] = perm;
   42a2d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42a31:	be 03 00 00 00       	mov    $0x3,%esi
   42a36:	48 89 c7             	mov    %rax,%rdi
   42a39:	e8 70 fb ff ff       	call   425ae <pageindex>
   42a3e:	89 c2                	mov    %eax,%edx
   42a40:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42a43:	48 63 c8             	movslq %eax,%rcx
   42a46:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42a4a:	48 63 d2             	movslq %edx,%rdx
   42a4d:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42a51:	eb 28                	jmp    42a7b <virtual_memory_map+0x233>
        } else if (perm & PTE_P) {
   42a53:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42a56:	48 98                	cltq   
   42a58:	83 e0 01             	and    $0x1,%eax
   42a5b:	48 85 c0             	test   %rax,%rax
   42a5e:	74 1b                	je     42a7b <virtual_memory_map+0x233>
            // error, no allocated l4 page found for va
            log_printf("[Kern Info] failed to find l4pagetable address at " __FILE__ ": %d\n", __LINE__);
   42a60:	be 84 00 00 00       	mov    $0x84,%esi
   42a65:	bf 50 55 04 00       	mov    $0x45550,%edi
   42a6a:	b8 00 00 00 00       	mov    $0x0,%eax
   42a6f:	e8 b7 f7 ff ff       	call   4222b <log_printf>
            return -1;
   42a74:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42a79:	eb 28                	jmp    42aa3 <virtual_memory_map+0x25b>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42a7b:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
   42a82:	00 
   42a83:	48 81 45 b8 00 10 00 	addq   $0x1000,-0x48(%rbp)
   42a8a:	00 
   42a8b:	48 81 6d b0 00 10 00 	subq   $0x1000,-0x50(%rbp)
   42a92:	00 
   42a93:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   42a98:	0f 85 14 ff ff ff    	jne    429b2 <virtual_memory_map+0x16a>
        }
    }
    return 0;
   42a9e:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42aa3:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42aa7:	c9                   	leave  
   42aa8:	c3                   	ret    

0000000000042aa9 <lookup_l4pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   42aa9:	55                   	push   %rbp
   42aaa:	48 89 e5             	mov    %rsp,%rbp
   42aad:	48 83 ec 40          	sub    $0x40,%rsp
   42ab1:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42ab5:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42ab9:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   42abc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42ac0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l4 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   42ac4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   42acb:	e9 2b 01 00 00       	jmp    42bfb <lookup_l4pagetable+0x152>
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        x86_64_pageentry_t pe = pt->entry[PAGEINDEX(va, i)];
   42ad0:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42ad3:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42ad7:	89 d6                	mov    %edx,%esi
   42ad9:	48 89 c7             	mov    %rax,%rdi
   42adc:	e8 cd fa ff ff       	call   425ae <pageindex>
   42ae1:	89 c2                	mov    %eax,%edx
   42ae3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42ae7:	48 63 d2             	movslq %edx,%rdx
   42aea:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   42aee:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   42af2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42af6:	83 e0 01             	and    $0x1,%eax
   42af9:	48 85 c0             	test   %rax,%rax
   42afc:	75 63                	jne    42b61 <lookup_l4pagetable+0xb8>
            log_printf("[Kern Info] Error looking up l4pagetable: Pagetable address: 0x%x perm: 0x%x."
   42afe:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42b01:	8d 48 02             	lea    0x2(%rax),%ecx
   42b04:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b08:	25 ff 0f 00 00       	and    $0xfff,%eax
   42b0d:	48 89 c2             	mov    %rax,%rdx
   42b10:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b14:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42b1a:	48 89 c6             	mov    %rax,%rsi
   42b1d:	bf 98 55 04 00       	mov    $0x45598,%edi
   42b22:	b8 00 00 00 00       	mov    $0x0,%eax
   42b27:	e8 ff f6 ff ff       	call   4222b <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   42b2c:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42b2f:	48 98                	cltq   
   42b31:	83 e0 01             	and    $0x1,%eax
   42b34:	48 85 c0             	test   %rax,%rax
   42b37:	75 0a                	jne    42b43 <lookup_l4pagetable+0x9a>
                return NULL;
   42b39:	b8 00 00 00 00       	mov    $0x0,%eax
   42b3e:	e9 c6 00 00 00       	jmp    42c09 <lookup_l4pagetable+0x160>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   42b43:	be a7 00 00 00       	mov    $0xa7,%esi
   42b48:	bf 00 56 04 00       	mov    $0x45600,%edi
   42b4d:	b8 00 00 00 00       	mov    $0x0,%eax
   42b52:	e8 d4 f6 ff ff       	call   4222b <log_printf>
            return NULL;
   42b57:	b8 00 00 00 00       	mov    $0x0,%eax
   42b5c:	e9 a8 00 00 00       	jmp    42c09 <lookup_l4pagetable+0x160>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   42b61:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b65:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42b6b:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   42b71:	76 14                	jbe    42b87 <lookup_l4pagetable+0xde>
   42b73:	ba 48 56 04 00       	mov    $0x45648,%edx
   42b78:	be ac 00 00 00       	mov    $0xac,%esi
   42b7d:	bf 95 52 04 00       	mov    $0x45295,%edi
   42b82:	e8 c2 f9 ff ff       	call   42549 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   42b87:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42b8a:	48 98                	cltq   
   42b8c:	83 e0 02             	and    $0x2,%eax
   42b8f:	48 85 c0             	test   %rax,%rax
   42b92:	74 20                	je     42bb4 <lookup_l4pagetable+0x10b>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   42b94:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b98:	83 e0 02             	and    $0x2,%eax
   42b9b:	48 85 c0             	test   %rax,%rax
   42b9e:	75 14                	jne    42bb4 <lookup_l4pagetable+0x10b>
   42ba0:	ba 68 56 04 00       	mov    $0x45668,%edx
   42ba5:	be ae 00 00 00       	mov    $0xae,%esi
   42baa:	bf 95 52 04 00       	mov    $0x45295,%edi
   42baf:	e8 95 f9 ff ff       	call   42549 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   42bb4:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42bb7:	48 98                	cltq   
   42bb9:	83 e0 04             	and    $0x4,%eax
   42bbc:	48 85 c0             	test   %rax,%rax
   42bbf:	74 20                	je     42be1 <lookup_l4pagetable+0x138>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   42bc1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42bc5:	83 e0 04             	and    $0x4,%eax
   42bc8:	48 85 c0             	test   %rax,%rax
   42bcb:	75 14                	jne    42be1 <lookup_l4pagetable+0x138>
   42bcd:	ba 73 56 04 00       	mov    $0x45673,%edx
   42bd2:	be b1 00 00 00       	mov    $0xb1,%esi
   42bd7:	bf 95 52 04 00       	mov    $0x45295,%edi
   42bdc:	e8 68 f9 ff ff       	call   42549 <assert_fail>
        }

        // set pt to physical address to next pagetable using `pe`
        pt = 0; // replace this
   42be1:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42be8:	00 
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42be9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42bed:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42bf3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   42bf7:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   42bfb:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   42bff:	0f 8e cb fe ff ff    	jle    42ad0 <lookup_l4pagetable+0x27>
    }
    return pt;
   42c05:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   42c09:	c9                   	leave  
   42c0a:	c3                   	ret    

0000000000042c0b <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   42c0b:	55                   	push   %rbp
   42c0c:	48 89 e5             	mov    %rsp,%rbp
   42c0f:	48 83 ec 50          	sub    $0x50,%rsp
   42c13:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42c17:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42c1b:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   42c1f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42c23:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   42c27:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   42c2e:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42c2f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   42c36:	eb 41                	jmp    42c79 <virtual_memory_lookup+0x6e>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   42c38:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42c3b:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42c3f:	89 d6                	mov    %edx,%esi
   42c41:	48 89 c7             	mov    %rax,%rdi
   42c44:	e8 65 f9 ff ff       	call   425ae <pageindex>
   42c49:	89 c2                	mov    %eax,%edx
   42c4b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42c4f:	48 63 d2             	movslq %edx,%rdx
   42c52:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   42c56:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c5a:	83 e0 06             	and    $0x6,%eax
   42c5d:	48 f7 d0             	not    %rax
   42c60:	48 21 d0             	and    %rdx,%rax
   42c63:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42c67:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c6b:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42c71:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42c75:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   42c79:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   42c7d:	7f 0c                	jg     42c8b <virtual_memory_lookup+0x80>
   42c7f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c83:	83 e0 01             	and    $0x1,%eax
   42c86:	48 85 c0             	test   %rax,%rax
   42c89:	75 ad                	jne    42c38 <virtual_memory_lookup+0x2d>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   42c8b:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   42c92:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   42c99:	ff 
   42c9a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   42ca1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ca5:	83 e0 01             	and    $0x1,%eax
   42ca8:	48 85 c0             	test   %rax,%rax
   42cab:	74 34                	je     42ce1 <virtual_memory_lookup+0xd6>
        vam.pn = PAGENUMBER(pe);
   42cad:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42cb1:	48 c1 e8 0c          	shr    $0xc,%rax
   42cb5:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   42cb8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42cbc:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42cc2:	48 89 c2             	mov    %rax,%rdx
   42cc5:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42cc9:	25 ff 0f 00 00       	and    $0xfff,%eax
   42cce:	48 09 d0             	or     %rdx,%rax
   42cd1:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   42cd5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42cd9:	25 ff 0f 00 00       	and    $0xfff,%eax
   42cde:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   42ce1:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42ce5:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42ce9:	48 89 10             	mov    %rdx,(%rax)
   42cec:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   42cf0:	48 89 50 08          	mov    %rdx,0x8(%rax)
   42cf4:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42cf8:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   42cfc:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42d00:	c9                   	leave  
   42d01:	c3                   	ret    

0000000000042d02 <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   42d02:	55                   	push   %rbp
   42d03:	48 89 e5             	mov    %rsp,%rbp
   42d06:	48 83 ec 40          	sub    $0x40,%rsp
   42d0a:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42d0e:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   42d11:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   42d15:	c7 45 f8 04 00 00 00 	movl   $0x4,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   42d1c:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   42d20:	78 08                	js     42d2a <program_load+0x28>
   42d22:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42d25:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   42d28:	7c 14                	jl     42d3e <program_load+0x3c>
   42d2a:	ba 80 56 04 00       	mov    $0x45680,%edx
   42d2f:	be 2e 00 00 00       	mov    $0x2e,%esi
   42d34:	bf b0 56 04 00       	mov    $0x456b0,%edi
   42d39:	e8 0b f8 ff ff       	call   42549 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   42d3e:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42d41:	48 98                	cltq   
   42d43:	48 c1 e0 04          	shl    $0x4,%rax
   42d47:	48 05 20 60 04 00    	add    $0x46020,%rax
   42d4d:	48 8b 00             	mov    (%rax),%rax
   42d50:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   42d54:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d58:	8b 00                	mov    (%rax),%eax
   42d5a:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   42d5f:	74 14                	je     42d75 <program_load+0x73>
   42d61:	ba c2 56 04 00       	mov    $0x456c2,%edx
   42d66:	be 30 00 00 00       	mov    $0x30,%esi
   42d6b:	bf b0 56 04 00       	mov    $0x456b0,%edi
   42d70:	e8 d4 f7 ff ff       	call   42549 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   42d75:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d79:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42d7d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d81:	48 01 d0             	add    %rdx,%rax
   42d84:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   42d88:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42d8f:	e9 94 00 00 00       	jmp    42e28 <program_load+0x126>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   42d94:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42d97:	48 63 d0             	movslq %eax,%rdx
   42d9a:	48 89 d0             	mov    %rdx,%rax
   42d9d:	48 c1 e0 03          	shl    $0x3,%rax
   42da1:	48 29 d0             	sub    %rdx,%rax
   42da4:	48 c1 e0 03          	shl    $0x3,%rax
   42da8:	48 89 c2             	mov    %rax,%rdx
   42dab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42daf:	48 01 d0             	add    %rdx,%rax
   42db2:	8b 00                	mov    (%rax),%eax
   42db4:	83 f8 01             	cmp    $0x1,%eax
   42db7:	75 6b                	jne    42e24 <program_load+0x122>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   42db9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42dbc:	48 63 d0             	movslq %eax,%rdx
   42dbf:	48 89 d0             	mov    %rdx,%rax
   42dc2:	48 c1 e0 03          	shl    $0x3,%rax
   42dc6:	48 29 d0             	sub    %rdx,%rax
   42dc9:	48 c1 e0 03          	shl    $0x3,%rax
   42dcd:	48 89 c2             	mov    %rax,%rdx
   42dd0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42dd4:	48 01 d0             	add    %rdx,%rax
   42dd7:	48 8b 50 08          	mov    0x8(%rax),%rdx
   42ddb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ddf:	48 01 d0             	add    %rdx,%rax
   42de2:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   42de6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42de9:	48 63 d0             	movslq %eax,%rdx
   42dec:	48 89 d0             	mov    %rdx,%rax
   42def:	48 c1 e0 03          	shl    $0x3,%rax
   42df3:	48 29 d0             	sub    %rdx,%rax
   42df6:	48 c1 e0 03          	shl    $0x3,%rax
   42dfa:	48 89 c2             	mov    %rax,%rdx
   42dfd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42e01:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   42e05:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42e09:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42e0d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e11:	48 89 c7             	mov    %rax,%rdi
   42e14:	e8 3d 00 00 00       	call   42e56 <program_load_segment>
   42e19:	85 c0                	test   %eax,%eax
   42e1b:	79 07                	jns    42e24 <program_load+0x122>
                return -1;
   42e1d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42e22:	eb 30                	jmp    42e54 <program_load+0x152>
    for (int i = 0; i < eh->e_phnum; ++i) {
   42e24:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   42e28:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e2c:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   42e30:	0f b7 c0             	movzwl %ax,%eax
   42e33:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   42e36:	0f 8c 58 ff ff ff    	jl     42d94 <program_load+0x92>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   42e3c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e40:	48 8b 50 18          	mov    0x18(%rax),%rdx
   42e44:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e48:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    return 0;
   42e4f:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42e54:	c9                   	leave  
   42e55:	c3                   	ret    

0000000000042e56 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   42e56:	55                   	push   %rbp
   42e57:	48 89 e5             	mov    %rsp,%rbp
   42e5a:	48 83 ec 70          	sub    $0x70,%rsp
   42e5e:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42e62:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   42e66:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   42e6a:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   42e6e:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42e72:	48 8b 40 10          	mov    0x10(%rax),%rax
   42e76:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   42e7a:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42e7e:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42e82:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42e86:	48 01 d0             	add    %rdx,%rax
   42e89:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   42e8d:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42e91:	48 8b 50 28          	mov    0x28(%rax),%rdx
   42e95:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42e99:	48 01 d0             	add    %rdx,%rax
   42e9c:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   42ea0:	48 81 65 e8 00 f0 ff 	andq   $0xfffffffffffff000,-0x18(%rbp)
   42ea7:	ff 


    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42ea8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42eac:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   42eb0:	eb 7c                	jmp    42f2e <program_load_segment+0xd8>
        uintptr_t pa = (uintptr_t)palloc(p->p_pid);
   42eb2:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42eb6:	8b 00                	mov    (%rax),%eax
   42eb8:	89 c7                	mov    %eax,%edi
   42eba:	e8 9b 01 00 00       	call   4305a <palloc>
   42ebf:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        if(pa == (uintptr_t)NULL || virtual_memory_map(p->p_pagetable, addr, pa, PAGESIZE,
   42ec3:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
   42ec8:	74 2a                	je     42ef4 <program_load_segment+0x9e>
   42eca:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42ece:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   42ed5:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42ed9:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   42edd:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42ee3:	b9 00 10 00 00       	mov    $0x1000,%ecx
   42ee8:	48 89 c7             	mov    %rax,%rdi
   42eeb:	e8 58 f9 ff ff       	call   42848 <virtual_memory_map>
   42ef0:	85 c0                	test   %eax,%eax
   42ef2:	79 32                	jns    42f26 <program_load_segment+0xd0>
                    PTE_W | PTE_P | PTE_U) < 0) {
            console_printf(CPOS(22, 0), 0xC000,
   42ef4:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42ef8:	8b 00                	mov    (%rax),%eax
   42efa:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42efe:	49 89 d0             	mov    %rdx,%r8
   42f01:	89 c1                	mov    %eax,%ecx
   42f03:	ba e0 56 04 00       	mov    $0x456e0,%edx
   42f08:	be 00 c0 00 00       	mov    $0xc000,%esi
   42f0d:	bf e0 06 00 00       	mov    $0x6e0,%edi
   42f12:	b8 00 00 00 00       	mov    $0x0,%eax
   42f17:	e8 27 1b 00 00       	call   44a43 <console_printf>
                    "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
            return -1;
   42f1c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42f21:	e9 32 01 00 00       	jmp    43058 <program_load_segment+0x202>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42f26:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42f2d:	00 
   42f2e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42f32:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   42f36:	0f 82 76 ff ff ff    	jb     42eb2 <program_load_segment+0x5c>
        }
    }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   42f3c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42f40:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   42f47:	48 89 c7             	mov    %rax,%rdi
   42f4a:	e8 c8 f7 ff ff       	call   42717 <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   42f4f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42f53:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   42f57:	48 89 c2             	mov    %rax,%rdx
   42f5a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f5e:	48 8b 4d 98          	mov    -0x68(%rbp),%rcx
   42f62:	48 89 ce             	mov    %rcx,%rsi
   42f65:	48 89 c7             	mov    %rax,%rdi
   42f68:	e8 21 0c 00 00       	call   43b8e <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   42f6d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42f71:	48 2b 45 e0          	sub    -0x20(%rbp),%rax
   42f75:	48 89 c2             	mov    %rax,%rdx
   42f78:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42f7c:	be 00 00 00 00       	mov    $0x0,%esi
   42f81:	48 89 c7             	mov    %rax,%rdi
   42f84:	e8 03 0d 00 00       	call   43c8c <memset>

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   42f89:	48 8b 05 70 f0 00 00 	mov    0xf070(%rip),%rax        # 52000 <kernel_pagetable>
   42f90:	48 89 c7             	mov    %rax,%rdi
   42f93:	e8 7f f7 ff ff       	call   42717 <set_pagetable>


    if((ph->p_flags & ELF_PFLAG_WRITE) == 0) {
   42f98:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42f9c:	8b 40 04             	mov    0x4(%rax),%eax
   42f9f:	83 e0 02             	and    $0x2,%eax
   42fa2:	85 c0                	test   %eax,%eax
   42fa4:	75 60                	jne    43006 <program_load_segment+0x1b0>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42fa6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42faa:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   42fae:	eb 4c                	jmp    42ffc <program_load_segment+0x1a6>
            vamapping mapping = virtual_memory_lookup(p->p_pagetable, addr);
   42fb0:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42fb4:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   42fbb:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   42fbf:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   42fc3:	48 89 ce             	mov    %rcx,%rsi
   42fc6:	48 89 c7             	mov    %rax,%rdi
   42fc9:	e8 3d fc ff ff       	call   42c0b <virtual_memory_lookup>

            virtual_memory_map(p->p_pagetable, addr, mapping.pa, PAGESIZE,
   42fce:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42fd2:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42fd6:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   42fdd:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   42fe1:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   42fe7:	b9 00 10 00 00       	mov    $0x1000,%ecx
   42fec:	48 89 c7             	mov    %rax,%rdi
   42fef:	e8 54 f8 ff ff       	call   42848 <virtual_memory_map>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42ff4:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   42ffb:	00 
   42ffc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43000:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   43004:	72 aa                	jb     42fb0 <program_load_segment+0x15a>
                    PTE_P | PTE_U);
        }
    }
    // TODO : Add code here -> done
    // log_printf("heap bottom/top before loading this segment: 0x%x\n", p->original_break);
    uintptr_t newbrk = (ph->p_va + ph->p_memsz + (PAGESIZE - 1)) & ~(PAGESIZE - 1);
   43006:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   4300a:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4300e:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   43012:	48 8b 40 28          	mov    0x28(%rax),%rax
   43016:	48 01 d0             	add    %rdx,%rax
   43019:	48 05 ff 0f 00 00    	add    $0xfff,%rax
   4301f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43025:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    if (newbrk > p->original_break)
   43029:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4302d:	48 8b 40 10          	mov    0x10(%rax),%rax
   43031:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   43035:	73 0c                	jae    43043 <program_load_segment+0x1ed>
	    p->original_break = newbrk;
   43037:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4303b:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   4303f:	48 89 50 10          	mov    %rdx,0x10(%rax)
    p->program_break = p->original_break;
   43043:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43047:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4304b:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4304f:	48 89 50 08          	mov    %rdx,0x8(%rax)
    // log_printf("heap bottom/top after loading this segment: 0x%x\n", p->original_break);
    return 0;
   43053:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43058:	c9                   	leave  
   43059:	c3                   	ret    

000000000004305a <palloc>:
   4305a:	55                   	push   %rbp
   4305b:	48 89 e5             	mov    %rsp,%rbp
   4305e:	48 83 ec 20          	sub    $0x20,%rsp
   43062:	89 7d ec             	mov    %edi,-0x14(%rbp)
   43065:	48 c7 45 f8 00 10 00 	movq   $0x1000,-0x8(%rbp)
   4306c:	00 
   4306d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43071:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43075:	e9 95 00 00 00       	jmp    4310f <palloc+0xb5>
   4307a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4307e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43082:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43089:	00 
   4308a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4308e:	48 c1 e8 0c          	shr    $0xc,%rax
   43092:	48 98                	cltq   
   43094:	0f b6 84 00 20 ff 04 	movzbl 0x4ff20(%rax,%rax,1),%eax
   4309b:	00 
   4309c:	84 c0                	test   %al,%al
   4309e:	75 6f                	jne    4310f <palloc+0xb5>
   430a0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   430a4:	48 c1 e8 0c          	shr    $0xc,%rax
   430a8:	48 98                	cltq   
   430aa:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   430b1:	00 
   430b2:	84 c0                	test   %al,%al
   430b4:	75 59                	jne    4310f <palloc+0xb5>
   430b6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   430ba:	48 c1 e8 0c          	shr    $0xc,%rax
   430be:	89 c2                	mov    %eax,%edx
   430c0:	48 63 c2             	movslq %edx,%rax
   430c3:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   430ca:	00 
   430cb:	83 c0 01             	add    $0x1,%eax
   430ce:	89 c1                	mov    %eax,%ecx
   430d0:	48 63 c2             	movslq %edx,%rax
   430d3:	88 8c 00 21 ff 04 00 	mov    %cl,0x4ff21(%rax,%rax,1)
   430da:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   430de:	48 c1 e8 0c          	shr    $0xc,%rax
   430e2:	89 c1                	mov    %eax,%ecx
   430e4:	8b 45 ec             	mov    -0x14(%rbp),%eax
   430e7:	89 c2                	mov    %eax,%edx
   430e9:	48 63 c1             	movslq %ecx,%rax
   430ec:	88 94 00 20 ff 04 00 	mov    %dl,0x4ff20(%rax,%rax,1)
   430f3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   430f7:	ba 00 10 00 00       	mov    $0x1000,%edx
   430fc:	be cc 00 00 00       	mov    $0xcc,%esi
   43101:	48 89 c7             	mov    %rax,%rdi
   43104:	e8 83 0b 00 00       	call   43c8c <memset>
   43109:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4310d:	eb 2c                	jmp    4313b <palloc+0xe1>
   4310f:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   43116:	00 
   43117:	0f 86 5d ff ff ff    	jbe    4307a <palloc+0x20>
   4311d:	ba 18 57 04 00       	mov    $0x45718,%edx
   43122:	be 00 0c 00 00       	mov    $0xc00,%esi
   43127:	bf 80 07 00 00       	mov    $0x780,%edi
   4312c:	b8 00 00 00 00       	mov    $0x0,%eax
   43131:	e8 0d 19 00 00       	call   44a43 <console_printf>
   43136:	b8 00 00 00 00       	mov    $0x0,%eax
   4313b:	c9                   	leave  
   4313c:	c3                   	ret    

000000000004313d <palloc_target>:
   4313d:	55                   	push   %rbp
   4313e:	48 89 e5             	mov    %rsp,%rbp
   43141:	48 8b 05 b8 4e 01 00 	mov    0x14eb8(%rip),%rax        # 58000 <palloc_target_proc>
   43148:	48 85 c0             	test   %rax,%rax
   4314b:	75 14                	jne    43161 <palloc_target+0x24>
   4314d:	ba 31 57 04 00       	mov    $0x45731,%edx
   43152:	be 27 00 00 00       	mov    $0x27,%esi
   43157:	bf 4c 57 04 00       	mov    $0x4574c,%edi
   4315c:	e8 e8 f3 ff ff       	call   42549 <assert_fail>
   43161:	48 8b 05 98 4e 01 00 	mov    0x14e98(%rip),%rax        # 58000 <palloc_target_proc>
   43168:	8b 00                	mov    (%rax),%eax
   4316a:	89 c7                	mov    %eax,%edi
   4316c:	e8 e9 fe ff ff       	call   4305a <palloc>
   43171:	5d                   	pop    %rbp
   43172:	c3                   	ret    

0000000000043173 <process_free>:
   43173:	55                   	push   %rbp
   43174:	48 89 e5             	mov    %rsp,%rbp
   43177:	48 83 ec 60          	sub    $0x60,%rsp
   4317b:	89 7d ac             	mov    %edi,-0x54(%rbp)
   4317e:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43181:	48 63 d0             	movslq %eax,%rdx
   43184:	48 89 d0             	mov    %rdx,%rax
   43187:	48 c1 e0 04          	shl    $0x4,%rax
   4318b:	48 29 d0             	sub    %rdx,%rax
   4318e:	48 c1 e0 04          	shl    $0x4,%rax
   43192:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   43198:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
   4319e:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   431a5:	00 
   431a6:	e9 ad 00 00 00       	jmp    43258 <process_free+0xe5>
   431ab:	8b 45 ac             	mov    -0x54(%rbp),%eax
   431ae:	48 63 d0             	movslq %eax,%rdx
   431b1:	48 89 d0             	mov    %rdx,%rax
   431b4:	48 c1 e0 04          	shl    $0x4,%rax
   431b8:	48 29 d0             	sub    %rdx,%rax
   431bb:	48 c1 e0 04          	shl    $0x4,%rax
   431bf:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   431c5:	48 8b 08             	mov    (%rax),%rcx
   431c8:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   431cc:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   431d0:	48 89 ce             	mov    %rcx,%rsi
   431d3:	48 89 c7             	mov    %rax,%rdi
   431d6:	e8 30 fa ff ff       	call   42c0b <virtual_memory_lookup>
   431db:	8b 45 c8             	mov    -0x38(%rbp),%eax
   431de:	48 98                	cltq   
   431e0:	83 e0 01             	and    $0x1,%eax
   431e3:	48 85 c0             	test   %rax,%rax
   431e6:	74 68                	je     43250 <process_free+0xdd>
   431e8:	8b 45 b8             	mov    -0x48(%rbp),%eax
   431eb:	48 63 d0             	movslq %eax,%rdx
   431ee:	0f b6 94 12 21 ff 04 	movzbl 0x4ff21(%rdx,%rdx,1),%edx
   431f5:	00 
   431f6:	83 ea 01             	sub    $0x1,%edx
   431f9:	48 98                	cltq   
   431fb:	88 94 00 21 ff 04 00 	mov    %dl,0x4ff21(%rax,%rax,1)
   43202:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43205:	48 98                	cltq   
   43207:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   4320e:	00 
   4320f:	84 c0                	test   %al,%al
   43211:	75 0f                	jne    43222 <process_free+0xaf>
   43213:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43216:	48 98                	cltq   
   43218:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   4321f:	00 
   43220:	eb 2e                	jmp    43250 <process_free+0xdd>
   43222:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43225:	48 98                	cltq   
   43227:	0f b6 84 00 20 ff 04 	movzbl 0x4ff20(%rax,%rax,1),%eax
   4322e:	00 
   4322f:	0f be c0             	movsbl %al,%eax
   43232:	39 45 ac             	cmp    %eax,-0x54(%rbp)
   43235:	75 19                	jne    43250 <process_free+0xdd>
   43237:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4323b:	8b 55 ac             	mov    -0x54(%rbp),%edx
   4323e:	48 89 c6             	mov    %rax,%rsi
   43241:	bf 58 57 04 00       	mov    $0x45758,%edi
   43246:	b8 00 00 00 00       	mov    $0x0,%eax
   4324b:	e8 db ef ff ff       	call   4222b <log_printf>
   43250:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43257:	00 
   43258:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   4325f:	00 
   43260:	0f 86 45 ff ff ff    	jbe    431ab <process_free+0x38>
   43266:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43269:	48 63 d0             	movslq %eax,%rdx
   4326c:	48 89 d0             	mov    %rdx,%rax
   4326f:	48 c1 e0 04          	shl    $0x4,%rax
   43273:	48 29 d0             	sub    %rdx,%rax
   43276:	48 c1 e0 04          	shl    $0x4,%rax
   4327a:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   43280:	48 8b 00             	mov    (%rax),%rax
   43283:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43287:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4328b:	48 8b 00             	mov    (%rax),%rax
   4328e:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43294:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   43298:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4329c:	48 8b 00             	mov    (%rax),%rax
   4329f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   432a5:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   432a9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   432ad:	48 8b 00             	mov    (%rax),%rax
   432b0:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   432b6:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   432ba:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   432be:	48 8b 40 08          	mov    0x8(%rax),%rax
   432c2:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   432c8:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
   432cc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432d0:	48 c1 e8 0c          	shr    $0xc,%rax
   432d4:	48 98                	cltq   
   432d6:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   432dd:	00 
   432de:	3c 01                	cmp    $0x1,%al
   432e0:	74 14                	je     432f6 <process_free+0x183>
   432e2:	ba 90 57 04 00       	mov    $0x45790,%edx
   432e7:	be 4f 00 00 00       	mov    $0x4f,%esi
   432ec:	bf 4c 57 04 00       	mov    $0x4574c,%edi
   432f1:	e8 53 f2 ff ff       	call   42549 <assert_fail>
   432f6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432fa:	48 c1 e8 0c          	shr    $0xc,%rax
   432fe:	48 98                	cltq   
   43300:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43307:	00 
   43308:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4330c:	48 c1 e8 0c          	shr    $0xc,%rax
   43310:	48 98                	cltq   
   43312:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43319:	00 
   4331a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4331e:	48 c1 e8 0c          	shr    $0xc,%rax
   43322:	48 98                	cltq   
   43324:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   4332b:	00 
   4332c:	3c 01                	cmp    $0x1,%al
   4332e:	74 14                	je     43344 <process_free+0x1d1>
   43330:	ba b8 57 04 00       	mov    $0x457b8,%edx
   43335:	be 52 00 00 00       	mov    $0x52,%esi
   4333a:	bf 4c 57 04 00       	mov    $0x4574c,%edi
   4333f:	e8 05 f2 ff ff       	call   42549 <assert_fail>
   43344:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43348:	48 c1 e8 0c          	shr    $0xc,%rax
   4334c:	48 98                	cltq   
   4334e:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43355:	00 
   43356:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4335a:	48 c1 e8 0c          	shr    $0xc,%rax
   4335e:	48 98                	cltq   
   43360:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43367:	00 
   43368:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4336c:	48 c1 e8 0c          	shr    $0xc,%rax
   43370:	48 98                	cltq   
   43372:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   43379:	00 
   4337a:	3c 01                	cmp    $0x1,%al
   4337c:	74 14                	je     43392 <process_free+0x21f>
   4337e:	ba e0 57 04 00       	mov    $0x457e0,%edx
   43383:	be 55 00 00 00       	mov    $0x55,%esi
   43388:	bf 4c 57 04 00       	mov    $0x4574c,%edi
   4338d:	e8 b7 f1 ff ff       	call   42549 <assert_fail>
   43392:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43396:	48 c1 e8 0c          	shr    $0xc,%rax
   4339a:	48 98                	cltq   
   4339c:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   433a3:	00 
   433a4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   433a8:	48 c1 e8 0c          	shr    $0xc,%rax
   433ac:	48 98                	cltq   
   433ae:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   433b5:	00 
   433b6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   433ba:	48 c1 e8 0c          	shr    $0xc,%rax
   433be:	48 98                	cltq   
   433c0:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   433c7:	00 
   433c8:	3c 01                	cmp    $0x1,%al
   433ca:	74 14                	je     433e0 <process_free+0x26d>
   433cc:	ba 08 58 04 00       	mov    $0x45808,%edx
   433d1:	be 58 00 00 00       	mov    $0x58,%esi
   433d6:	bf 4c 57 04 00       	mov    $0x4574c,%edi
   433db:	e8 69 f1 ff ff       	call   42549 <assert_fail>
   433e0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   433e4:	48 c1 e8 0c          	shr    $0xc,%rax
   433e8:	48 98                	cltq   
   433ea:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   433f1:	00 
   433f2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   433f6:	48 c1 e8 0c          	shr    $0xc,%rax
   433fa:	48 98                	cltq   
   433fc:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43403:	00 
   43404:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43408:	48 c1 e8 0c          	shr    $0xc,%rax
   4340c:	48 98                	cltq   
   4340e:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   43415:	00 
   43416:	3c 01                	cmp    $0x1,%al
   43418:	74 14                	je     4342e <process_free+0x2bb>
   4341a:	ba 30 58 04 00       	mov    $0x45830,%edx
   4341f:	be 5b 00 00 00       	mov    $0x5b,%esi
   43424:	bf 4c 57 04 00       	mov    $0x4574c,%edi
   43429:	e8 1b f1 ff ff       	call   42549 <assert_fail>
   4342e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43432:	48 c1 e8 0c          	shr    $0xc,%rax
   43436:	48 98                	cltq   
   43438:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   4343f:	00 
   43440:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43444:	48 c1 e8 0c          	shr    $0xc,%rax
   43448:	48 98                	cltq   
   4344a:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43451:	00 
   43452:	90                   	nop
   43453:	c9                   	leave  
   43454:	c3                   	ret    

0000000000043455 <process_config_tables>:
   43455:	55                   	push   %rbp
   43456:	48 89 e5             	mov    %rsp,%rbp
   43459:	48 83 ec 40          	sub    $0x40,%rsp
   4345d:	89 7d cc             	mov    %edi,-0x34(%rbp)
   43460:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43463:	89 c7                	mov    %eax,%edi
   43465:	e8 f0 fb ff ff       	call   4305a <palloc>
   4346a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   4346e:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43471:	89 c7                	mov    %eax,%edi
   43473:	e8 e2 fb ff ff       	call   4305a <palloc>
   43478:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   4347c:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4347f:	89 c7                	mov    %eax,%edi
   43481:	e8 d4 fb ff ff       	call   4305a <palloc>
   43486:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   4348a:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4348d:	89 c7                	mov    %eax,%edi
   4348f:	e8 c6 fb ff ff       	call   4305a <palloc>
   43494:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43498:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4349b:	89 c7                	mov    %eax,%edi
   4349d:	e8 b8 fb ff ff       	call   4305a <palloc>
   434a2:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   434a6:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   434ab:	74 20                	je     434cd <process_config_tables+0x78>
   434ad:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   434b2:	74 19                	je     434cd <process_config_tables+0x78>
   434b4:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   434b9:	74 12                	je     434cd <process_config_tables+0x78>
   434bb:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   434c0:	74 0b                	je     434cd <process_config_tables+0x78>
   434c2:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   434c7:	0f 85 e1 00 00 00    	jne    435ae <process_config_tables+0x159>
   434cd:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   434d2:	74 24                	je     434f8 <process_config_tables+0xa3>
   434d4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   434d8:	48 c1 e8 0c          	shr    $0xc,%rax
   434dc:	48 98                	cltq   
   434de:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   434e5:	00 
   434e6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   434ea:	48 c1 e8 0c          	shr    $0xc,%rax
   434ee:	48 98                	cltq   
   434f0:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   434f7:	00 
   434f8:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   434fd:	74 24                	je     43523 <process_config_tables+0xce>
   434ff:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43503:	48 c1 e8 0c          	shr    $0xc,%rax
   43507:	48 98                	cltq   
   43509:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43510:	00 
   43511:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43515:	48 c1 e8 0c          	shr    $0xc,%rax
   43519:	48 98                	cltq   
   4351b:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43522:	00 
   43523:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   43528:	74 24                	je     4354e <process_config_tables+0xf9>
   4352a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4352e:	48 c1 e8 0c          	shr    $0xc,%rax
   43532:	48 98                	cltq   
   43534:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   4353b:	00 
   4353c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43540:	48 c1 e8 0c          	shr    $0xc,%rax
   43544:	48 98                	cltq   
   43546:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   4354d:	00 
   4354e:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43553:	74 24                	je     43579 <process_config_tables+0x124>
   43555:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43559:	48 c1 e8 0c          	shr    $0xc,%rax
   4355d:	48 98                	cltq   
   4355f:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43566:	00 
   43567:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4356b:	48 c1 e8 0c          	shr    $0xc,%rax
   4356f:	48 98                	cltq   
   43571:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43578:	00 
   43579:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   4357e:	74 24                	je     435a4 <process_config_tables+0x14f>
   43580:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43584:	48 c1 e8 0c          	shr    $0xc,%rax
   43588:	48 98                	cltq   
   4358a:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43591:	00 
   43592:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43596:	48 c1 e8 0c          	shr    $0xc,%rax
   4359a:	48 98                	cltq   
   4359c:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   435a3:	00 
   435a4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   435a9:	e9 f3 01 00 00       	jmp    437a1 <process_config_tables+0x34c>
   435ae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   435b2:	ba 00 10 00 00       	mov    $0x1000,%edx
   435b7:	be 00 00 00 00       	mov    $0x0,%esi
   435bc:	48 89 c7             	mov    %rax,%rdi
   435bf:	e8 c8 06 00 00       	call   43c8c <memset>
   435c4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435c8:	ba 00 10 00 00       	mov    $0x1000,%edx
   435cd:	be 00 00 00 00       	mov    $0x0,%esi
   435d2:	48 89 c7             	mov    %rax,%rdi
   435d5:	e8 b2 06 00 00       	call   43c8c <memset>
   435da:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   435de:	ba 00 10 00 00       	mov    $0x1000,%edx
   435e3:	be 00 00 00 00       	mov    $0x0,%esi
   435e8:	48 89 c7             	mov    %rax,%rdi
   435eb:	e8 9c 06 00 00       	call   43c8c <memset>
   435f0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   435f4:	ba 00 10 00 00       	mov    $0x1000,%edx
   435f9:	be 00 00 00 00       	mov    $0x0,%esi
   435fe:	48 89 c7             	mov    %rax,%rdi
   43601:	e8 86 06 00 00       	call   43c8c <memset>
   43606:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4360a:	ba 00 10 00 00       	mov    $0x1000,%edx
   4360f:	be 00 00 00 00       	mov    $0x0,%esi
   43614:	48 89 c7             	mov    %rax,%rdi
   43617:	e8 70 06 00 00       	call   43c8c <memset>
   4361c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43620:	48 83 c8 07          	or     $0x7,%rax
   43624:	48 89 c2             	mov    %rax,%rdx
   43627:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4362b:	48 89 10             	mov    %rdx,(%rax)
   4362e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43632:	48 83 c8 07          	or     $0x7,%rax
   43636:	48 89 c2             	mov    %rax,%rdx
   43639:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4363d:	48 89 10             	mov    %rdx,(%rax)
   43640:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43644:	48 83 c8 07          	or     $0x7,%rax
   43648:	48 89 c2             	mov    %rax,%rdx
   4364b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4364f:	48 89 10             	mov    %rdx,(%rax)
   43652:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43656:	48 83 c8 07          	or     $0x7,%rax
   4365a:	48 89 c2             	mov    %rax,%rdx
   4365d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43661:	48 89 50 08          	mov    %rdx,0x8(%rax)
   43665:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43669:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   4366f:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   43675:	b9 00 00 10 00       	mov    $0x100000,%ecx
   4367a:	ba 00 00 00 00       	mov    $0x0,%edx
   4367f:	be 00 00 00 00       	mov    $0x0,%esi
   43684:	48 89 c7             	mov    %rax,%rdi
   43687:	e8 bc f1 ff ff       	call   42848 <virtual_memory_map>
   4368c:	85 c0                	test   %eax,%eax
   4368e:	75 2f                	jne    436bf <process_config_tables+0x26a>
   43690:	ba 00 80 0b 00       	mov    $0xb8000,%edx
   43695:	be 00 80 0b 00       	mov    $0xb8000,%esi
   4369a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4369e:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   436a4:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   436aa:	b9 00 10 00 00       	mov    $0x1000,%ecx
   436af:	48 89 c7             	mov    %rax,%rdi
   436b2:	e8 91 f1 ff ff       	call   42848 <virtual_memory_map>
   436b7:	85 c0                	test   %eax,%eax
   436b9:	0f 84 bb 00 00 00    	je     4377a <process_config_tables+0x325>
   436bf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   436c3:	48 c1 e8 0c          	shr    $0xc,%rax
   436c7:	48 98                	cltq   
   436c9:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   436d0:	00 
   436d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   436d5:	48 c1 e8 0c          	shr    $0xc,%rax
   436d9:	48 98                	cltq   
   436db:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   436e2:	00 
   436e3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   436e7:	48 c1 e8 0c          	shr    $0xc,%rax
   436eb:	48 98                	cltq   
   436ed:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   436f4:	00 
   436f5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   436f9:	48 c1 e8 0c          	shr    $0xc,%rax
   436fd:	48 98                	cltq   
   436ff:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43706:	00 
   43707:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4370b:	48 c1 e8 0c          	shr    $0xc,%rax
   4370f:	48 98                	cltq   
   43711:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43718:	00 
   43719:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4371d:	48 c1 e8 0c          	shr    $0xc,%rax
   43721:	48 98                	cltq   
   43723:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   4372a:	00 
   4372b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4372f:	48 c1 e8 0c          	shr    $0xc,%rax
   43733:	48 98                	cltq   
   43735:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   4373c:	00 
   4373d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43741:	48 c1 e8 0c          	shr    $0xc,%rax
   43745:	48 98                	cltq   
   43747:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   4374e:	00 
   4374f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43753:	48 c1 e8 0c          	shr    $0xc,%rax
   43757:	48 98                	cltq   
   43759:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43760:	00 
   43761:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43765:	48 c1 e8 0c          	shr    $0xc,%rax
   43769:	48 98                	cltq   
   4376b:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43772:	00 
   43773:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43778:	eb 27                	jmp    437a1 <process_config_tables+0x34c>
   4377a:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4377d:	48 63 d0             	movslq %eax,%rdx
   43780:	48 89 d0             	mov    %rdx,%rax
   43783:	48 c1 e0 04          	shl    $0x4,%rax
   43787:	48 29 d0             	sub    %rdx,%rax
   4378a:	48 c1 e0 04          	shl    $0x4,%rax
   4378e:	48 8d 90 e0 f0 04 00 	lea    0x4f0e0(%rax),%rdx
   43795:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43799:	48 89 02             	mov    %rax,(%rdx)
   4379c:	b8 00 00 00 00       	mov    $0x0,%eax
   437a1:	c9                   	leave  
   437a2:	c3                   	ret    

00000000000437a3 <process_load>:
   437a3:	55                   	push   %rbp
   437a4:	48 89 e5             	mov    %rsp,%rbp
   437a7:	48 83 ec 20          	sub    $0x20,%rsp
   437ab:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   437af:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   437b2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   437b6:	48 89 05 43 48 01 00 	mov    %rax,0x14843(%rip)        # 58000 <palloc_target_proc>
   437bd:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
   437c0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   437c4:	ba 3d 31 04 00       	mov    $0x4313d,%edx
   437c9:	89 ce                	mov    %ecx,%esi
   437cb:	48 89 c7             	mov    %rax,%rdi
   437ce:	e8 2f f5 ff ff       	call   42d02 <program_load>
   437d3:	89 45 fc             	mov    %eax,-0x4(%rbp)
   437d6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   437d9:	c9                   	leave  
   437da:	c3                   	ret    

00000000000437db <process_setup_stack>:
   437db:	55                   	push   %rbp
   437dc:	48 89 e5             	mov    %rsp,%rbp
   437df:	48 83 ec 20          	sub    $0x20,%rsp
   437e3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   437e7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   437eb:	8b 00                	mov    (%rax),%eax
   437ed:	89 c7                	mov    %eax,%edi
   437ef:	e8 66 f8 ff ff       	call   4305a <palloc>
   437f4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   437f8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   437fc:	48 c7 80 c8 00 00 00 	movq   $0x300000,0xc8(%rax)
   43803:	00 00 30 00 
   43807:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4380b:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   43812:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43816:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   4381c:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43822:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43827:	be 00 f0 2f 00       	mov    $0x2ff000,%esi
   4382c:	48 89 c7             	mov    %rax,%rdi
   4382f:	e8 14 f0 ff ff       	call   42848 <virtual_memory_map>
   43834:	90                   	nop
   43835:	c9                   	leave  
   43836:	c3                   	ret    

0000000000043837 <find_free_pid>:
   43837:	55                   	push   %rbp
   43838:	48 89 e5             	mov    %rsp,%rbp
   4383b:	48 83 ec 10          	sub    $0x10,%rsp
   4383f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   43846:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
   4384d:	eb 24                	jmp    43873 <find_free_pid+0x3c>
   4384f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43852:	48 63 d0             	movslq %eax,%rdx
   43855:	48 89 d0             	mov    %rdx,%rax
   43858:	48 c1 e0 04          	shl    $0x4,%rax
   4385c:	48 29 d0             	sub    %rdx,%rax
   4385f:	48 c1 e0 04          	shl    $0x4,%rax
   43863:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   43869:	8b 00                	mov    (%rax),%eax
   4386b:	85 c0                	test   %eax,%eax
   4386d:	74 0c                	je     4387b <find_free_pid+0x44>
   4386f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   43873:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   43877:	7e d6                	jle    4384f <find_free_pid+0x18>
   43879:	eb 01                	jmp    4387c <find_free_pid+0x45>
   4387b:	90                   	nop
   4387c:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   43880:	74 05                	je     43887 <find_free_pid+0x50>
   43882:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43885:	eb 05                	jmp    4388c <find_free_pid+0x55>
   43887:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4388c:	c9                   	leave  
   4388d:	c3                   	ret    

000000000004388e <process_fork>:
   4388e:	55                   	push   %rbp
   4388f:	48 89 e5             	mov    %rsp,%rbp
   43892:	48 83 ec 40          	sub    $0x40,%rsp
   43896:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   4389a:	b8 00 00 00 00       	mov    $0x0,%eax
   4389f:	e8 93 ff ff ff       	call   43837 <find_free_pid>
   438a4:	89 45 f4             	mov    %eax,-0xc(%rbp)
   438a7:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%rbp)
   438ab:	75 0a                	jne    438b7 <process_fork+0x29>
   438ad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   438b2:	e9 67 02 00 00       	jmp    43b1e <process_fork+0x290>
   438b7:	8b 45 f4             	mov    -0xc(%rbp),%eax
   438ba:	48 63 d0             	movslq %eax,%rdx
   438bd:	48 89 d0             	mov    %rdx,%rax
   438c0:	48 c1 e0 04          	shl    $0x4,%rax
   438c4:	48 29 d0             	sub    %rdx,%rax
   438c7:	48 c1 e0 04          	shl    $0x4,%rax
   438cb:	48 05 00 f0 04 00    	add    $0x4f000,%rax
   438d1:	be 00 00 00 00       	mov    $0x0,%esi
   438d6:	48 89 c7             	mov    %rax,%rdi
   438d9:	e8 9d e4 ff ff       	call   41d7b <process_init>
   438de:	8b 45 f4             	mov    -0xc(%rbp),%eax
   438e1:	89 c7                	mov    %eax,%edi
   438e3:	e8 6d fb ff ff       	call   43455 <process_config_tables>
   438e8:	83 f8 ff             	cmp    $0xffffffff,%eax
   438eb:	75 0a                	jne    438f7 <process_fork+0x69>
   438ed:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   438f2:	e9 27 02 00 00       	jmp    43b1e <process_fork+0x290>
   438f7:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   438fe:	00 
   438ff:	e9 79 01 00 00       	jmp    43a7d <process_fork+0x1ef>
   43904:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43908:	8b 00                	mov    (%rax),%eax
   4390a:	48 63 d0             	movslq %eax,%rdx
   4390d:	48 89 d0             	mov    %rdx,%rax
   43910:	48 c1 e0 04          	shl    $0x4,%rax
   43914:	48 29 d0             	sub    %rdx,%rax
   43917:	48 c1 e0 04          	shl    $0x4,%rax
   4391b:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   43921:	48 8b 08             	mov    (%rax),%rcx
   43924:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   43928:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4392c:	48 89 ce             	mov    %rcx,%rsi
   4392f:	48 89 c7             	mov    %rax,%rdi
   43932:	e8 d4 f2 ff ff       	call   42c0b <virtual_memory_lookup>
   43937:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4393a:	48 98                	cltq   
   4393c:	83 e0 07             	and    $0x7,%eax
   4393f:	48 83 f8 07          	cmp    $0x7,%rax
   43943:	0f 85 a1 00 00 00    	jne    439ea <process_fork+0x15c>
   43949:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4394c:	89 c7                	mov    %eax,%edi
   4394e:	e8 07 f7 ff ff       	call   4305a <palloc>
   43953:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   43957:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4395c:	75 14                	jne    43972 <process_fork+0xe4>
   4395e:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43961:	89 c7                	mov    %eax,%edi
   43963:	e8 0b f8 ff ff       	call   43173 <process_free>
   43968:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4396d:	e9 ac 01 00 00       	jmp    43b1e <process_fork+0x290>
   43972:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43976:	48 89 c1             	mov    %rax,%rcx
   43979:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4397d:	ba 00 10 00 00       	mov    $0x1000,%edx
   43982:	48 89 ce             	mov    %rcx,%rsi
   43985:	48 89 c7             	mov    %rax,%rdi
   43988:	e8 01 02 00 00       	call   43b8e <memcpy>
   4398d:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
   43991:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43994:	48 63 d0             	movslq %eax,%rdx
   43997:	48 89 d0             	mov    %rdx,%rax
   4399a:	48 c1 e0 04          	shl    $0x4,%rax
   4399e:	48 29 d0             	sub    %rdx,%rax
   439a1:	48 c1 e0 04          	shl    $0x4,%rax
   439a5:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   439ab:	48 8b 00             	mov    (%rax),%rax
   439ae:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   439b2:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   439b8:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   439be:	b9 00 10 00 00       	mov    $0x1000,%ecx
   439c3:	48 89 fa             	mov    %rdi,%rdx
   439c6:	48 89 c7             	mov    %rax,%rdi
   439c9:	e8 7a ee ff ff       	call   42848 <virtual_memory_map>
   439ce:	85 c0                	test   %eax,%eax
   439d0:	0f 84 9f 00 00 00    	je     43a75 <process_fork+0x1e7>
   439d6:	8b 45 f4             	mov    -0xc(%rbp),%eax
   439d9:	89 c7                	mov    %eax,%edi
   439db:	e8 93 f7 ff ff       	call   43173 <process_free>
   439e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   439e5:	e9 34 01 00 00       	jmp    43b1e <process_fork+0x290>
   439ea:	8b 45 e0             	mov    -0x20(%rbp),%eax
   439ed:	48 98                	cltq   
   439ef:	83 e0 05             	and    $0x5,%eax
   439f2:	48 83 f8 05          	cmp    $0x5,%rax
   439f6:	75 7d                	jne    43a75 <process_fork+0x1e7>
   439f8:	48 8b 7d d8          	mov    -0x28(%rbp),%rdi
   439fc:	8b 45 f4             	mov    -0xc(%rbp),%eax
   439ff:	48 63 d0             	movslq %eax,%rdx
   43a02:	48 89 d0             	mov    %rdx,%rax
   43a05:	48 c1 e0 04          	shl    $0x4,%rax
   43a09:	48 29 d0             	sub    %rdx,%rax
   43a0c:	48 c1 e0 04          	shl    $0x4,%rax
   43a10:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   43a16:	48 8b 00             	mov    (%rax),%rax
   43a19:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   43a1d:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43a23:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   43a29:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43a2e:	48 89 fa             	mov    %rdi,%rdx
   43a31:	48 89 c7             	mov    %rax,%rdi
   43a34:	e8 0f ee ff ff       	call   42848 <virtual_memory_map>
   43a39:	85 c0                	test   %eax,%eax
   43a3b:	74 14                	je     43a51 <process_fork+0x1c3>
   43a3d:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43a40:	89 c7                	mov    %eax,%edi
   43a42:	e8 2c f7 ff ff       	call   43173 <process_free>
   43a47:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43a4c:	e9 cd 00 00 00       	jmp    43b1e <process_fork+0x290>
   43a51:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43a55:	48 c1 e8 0c          	shr    $0xc,%rax
   43a59:	89 c2                	mov    %eax,%edx
   43a5b:	48 63 c2             	movslq %edx,%rax
   43a5e:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   43a65:	00 
   43a66:	83 c0 01             	add    $0x1,%eax
   43a69:	89 c1                	mov    %eax,%ecx
   43a6b:	48 63 c2             	movslq %edx,%rax
   43a6e:	88 8c 00 21 ff 04 00 	mov    %cl,0x4ff21(%rax,%rax,1)
   43a75:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43a7c:	00 
   43a7d:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   43a84:	00 
   43a85:	0f 86 79 fe ff ff    	jbe    43904 <process_fork+0x76>
   43a8b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43a8f:	8b 08                	mov    (%rax),%ecx
   43a91:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43a94:	48 63 d0             	movslq %eax,%rdx
   43a97:	48 89 d0             	mov    %rdx,%rax
   43a9a:	48 c1 e0 04          	shl    $0x4,%rax
   43a9e:	48 29 d0             	sub    %rdx,%rax
   43aa1:	48 c1 e0 04          	shl    $0x4,%rax
   43aa5:	48 8d b0 10 f0 04 00 	lea    0x4f010(%rax),%rsi
   43aac:	48 63 d1             	movslq %ecx,%rdx
   43aaf:	48 89 d0             	mov    %rdx,%rax
   43ab2:	48 c1 e0 04          	shl    $0x4,%rax
   43ab6:	48 29 d0             	sub    %rdx,%rax
   43ab9:	48 c1 e0 04          	shl    $0x4,%rax
   43abd:	48 8d 90 10 f0 04 00 	lea    0x4f010(%rax),%rdx
   43ac4:	48 8d 46 08          	lea    0x8(%rsi),%rax
   43ac8:	48 83 c2 08          	add    $0x8,%rdx
   43acc:	b9 18 00 00 00       	mov    $0x18,%ecx
   43ad1:	48 89 c7             	mov    %rax,%rdi
   43ad4:	48 89 d6             	mov    %rdx,%rsi
   43ad7:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
   43ada:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43add:	48 63 d0             	movslq %eax,%rdx
   43ae0:	48 89 d0             	mov    %rdx,%rax
   43ae3:	48 c1 e0 04          	shl    $0x4,%rax
   43ae7:	48 29 d0             	sub    %rdx,%rax
   43aea:	48 c1 e0 04          	shl    $0x4,%rax
   43aee:	48 05 18 f0 04 00    	add    $0x4f018,%rax
   43af4:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
   43afb:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43afe:	48 63 d0             	movslq %eax,%rdx
   43b01:	48 89 d0             	mov    %rdx,%rax
   43b04:	48 c1 e0 04          	shl    $0x4,%rax
   43b08:	48 29 d0             	sub    %rdx,%rax
   43b0b:	48 c1 e0 04          	shl    $0x4,%rax
   43b0f:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   43b15:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
   43b1b:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43b1e:	c9                   	leave  
   43b1f:	c3                   	ret    

0000000000043b20 <process_page_alloc>:
   43b20:	55                   	push   %rbp
   43b21:	48 89 e5             	mov    %rsp,%rbp
   43b24:	48 83 ec 20          	sub    $0x20,%rsp
   43b28:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43b2c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43b30:	48 81 7d e0 ff ff 0f 	cmpq   $0xfffff,-0x20(%rbp)
   43b37:	00 
   43b38:	77 07                	ja     43b41 <process_page_alloc+0x21>
   43b3a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43b3f:	eb 4b                	jmp    43b8c <process_page_alloc+0x6c>
   43b41:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43b45:	8b 00                	mov    (%rax),%eax
   43b47:	89 c7                	mov    %eax,%edi
   43b49:	e8 0c f5 ff ff       	call   4305a <palloc>
   43b4e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43b52:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   43b57:	74 2e                	je     43b87 <process_page_alloc+0x67>
   43b59:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43b5d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43b61:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   43b68:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
   43b6c:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43b72:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43b78:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43b7d:	48 89 c7             	mov    %rax,%rdi
   43b80:	e8 c3 ec ff ff       	call   42848 <virtual_memory_map>
   43b85:	eb 05                	jmp    43b8c <process_page_alloc+0x6c>
   43b87:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43b8c:	c9                   	leave  
   43b8d:	c3                   	ret    

0000000000043b8e <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   43b8e:	55                   	push   %rbp
   43b8f:	48 89 e5             	mov    %rsp,%rbp
   43b92:	48 83 ec 28          	sub    $0x28,%rsp
   43b96:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43b9a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43b9e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43ba2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43ba6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43baa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43bae:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43bb2:	eb 1c                	jmp    43bd0 <memcpy+0x42>
        *d = *s;
   43bb4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43bb8:	0f b6 10             	movzbl (%rax),%edx
   43bbb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43bbf:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43bc1:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43bc6:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43bcb:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   43bd0:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43bd5:	75 dd                	jne    43bb4 <memcpy+0x26>
    }
    return dst;
   43bd7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43bdb:	c9                   	leave  
   43bdc:	c3                   	ret    

0000000000043bdd <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   43bdd:	55                   	push   %rbp
   43bde:	48 89 e5             	mov    %rsp,%rbp
   43be1:	48 83 ec 28          	sub    $0x28,%rsp
   43be5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43be9:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43bed:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43bf1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43bf5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   43bf9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43bfd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   43c01:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c05:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   43c09:	73 6a                	jae    43c75 <memmove+0x98>
   43c0b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43c0f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43c13:	48 01 d0             	add    %rdx,%rax
   43c16:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   43c1a:	73 59                	jae    43c75 <memmove+0x98>
        s += n, d += n;
   43c1c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43c20:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   43c24:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43c28:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   43c2c:	eb 17                	jmp    43c45 <memmove+0x68>
            *--d = *--s;
   43c2e:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   43c33:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   43c38:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c3c:	0f b6 10             	movzbl (%rax),%edx
   43c3f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43c43:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43c45:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43c49:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43c4d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43c51:	48 85 c0             	test   %rax,%rax
   43c54:	75 d8                	jne    43c2e <memmove+0x51>
    if (s < d && s + n > d) {
   43c56:	eb 2e                	jmp    43c86 <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   43c58:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43c5c:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43c60:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43c64:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43c68:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43c6c:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   43c70:	0f b6 12             	movzbl (%rdx),%edx
   43c73:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43c75:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43c79:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43c7d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43c81:	48 85 c0             	test   %rax,%rax
   43c84:	75 d2                	jne    43c58 <memmove+0x7b>
        }
    }
    return dst;
   43c86:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43c8a:	c9                   	leave  
   43c8b:	c3                   	ret    

0000000000043c8c <memset>:

void* memset(void* v, int c, size_t n) {
   43c8c:	55                   	push   %rbp
   43c8d:	48 89 e5             	mov    %rsp,%rbp
   43c90:	48 83 ec 28          	sub    $0x28,%rsp
   43c94:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43c98:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   43c9b:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43c9f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43ca3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43ca7:	eb 15                	jmp    43cbe <memset+0x32>
        *p = c;
   43ca9:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43cac:	89 c2                	mov    %eax,%edx
   43cae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43cb2:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43cb4:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43cb9:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43cbe:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43cc3:	75 e4                	jne    43ca9 <memset+0x1d>
    }
    return v;
   43cc5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43cc9:	c9                   	leave  
   43cca:	c3                   	ret    

0000000000043ccb <strlen>:

size_t strlen(const char* s) {
   43ccb:	55                   	push   %rbp
   43ccc:	48 89 e5             	mov    %rsp,%rbp
   43ccf:	48 83 ec 18          	sub    $0x18,%rsp
   43cd3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   43cd7:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43cde:	00 
   43cdf:	eb 0a                	jmp    43ceb <strlen+0x20>
        ++n;
   43ce1:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   43ce6:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43ceb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43cef:	0f b6 00             	movzbl (%rax),%eax
   43cf2:	84 c0                	test   %al,%al
   43cf4:	75 eb                	jne    43ce1 <strlen+0x16>
    }
    return n;
   43cf6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43cfa:	c9                   	leave  
   43cfb:	c3                   	ret    

0000000000043cfc <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   43cfc:	55                   	push   %rbp
   43cfd:	48 89 e5             	mov    %rsp,%rbp
   43d00:	48 83 ec 20          	sub    $0x20,%rsp
   43d04:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43d08:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43d0c:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43d13:	00 
   43d14:	eb 0a                	jmp    43d20 <strnlen+0x24>
        ++n;
   43d16:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43d1b:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43d20:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43d24:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   43d28:	74 0b                	je     43d35 <strnlen+0x39>
   43d2a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43d2e:	0f b6 00             	movzbl (%rax),%eax
   43d31:	84 c0                	test   %al,%al
   43d33:	75 e1                	jne    43d16 <strnlen+0x1a>
    }
    return n;
   43d35:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43d39:	c9                   	leave  
   43d3a:	c3                   	ret    

0000000000043d3b <strcpy>:

char* strcpy(char* dst, const char* src) {
   43d3b:	55                   	push   %rbp
   43d3c:	48 89 e5             	mov    %rsp,%rbp
   43d3f:	48 83 ec 20          	sub    $0x20,%rsp
   43d43:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43d47:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   43d4b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43d4f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   43d53:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43d57:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43d5b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43d5f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43d63:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43d67:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   43d6b:	0f b6 12             	movzbl (%rdx),%edx
   43d6e:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   43d70:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43d74:	48 83 e8 01          	sub    $0x1,%rax
   43d78:	0f b6 00             	movzbl (%rax),%eax
   43d7b:	84 c0                	test   %al,%al
   43d7d:	75 d4                	jne    43d53 <strcpy+0x18>
    return dst;
   43d7f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43d83:	c9                   	leave  
   43d84:	c3                   	ret    

0000000000043d85 <strcmp>:

int strcmp(const char* a, const char* b) {
   43d85:	55                   	push   %rbp
   43d86:	48 89 e5             	mov    %rsp,%rbp
   43d89:	48 83 ec 10          	sub    $0x10,%rsp
   43d8d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43d91:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43d95:	eb 0a                	jmp    43da1 <strcmp+0x1c>
        ++a, ++b;
   43d97:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43d9c:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43da1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43da5:	0f b6 00             	movzbl (%rax),%eax
   43da8:	84 c0                	test   %al,%al
   43daa:	74 1d                	je     43dc9 <strcmp+0x44>
   43dac:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43db0:	0f b6 00             	movzbl (%rax),%eax
   43db3:	84 c0                	test   %al,%al
   43db5:	74 12                	je     43dc9 <strcmp+0x44>
   43db7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43dbb:	0f b6 10             	movzbl (%rax),%edx
   43dbe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43dc2:	0f b6 00             	movzbl (%rax),%eax
   43dc5:	38 c2                	cmp    %al,%dl
   43dc7:	74 ce                	je     43d97 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   43dc9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43dcd:	0f b6 00             	movzbl (%rax),%eax
   43dd0:	89 c2                	mov    %eax,%edx
   43dd2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43dd6:	0f b6 00             	movzbl (%rax),%eax
   43dd9:	38 d0                	cmp    %dl,%al
   43ddb:	0f 92 c0             	setb   %al
   43dde:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   43de1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43de5:	0f b6 00             	movzbl (%rax),%eax
   43de8:	89 c1                	mov    %eax,%ecx
   43dea:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43dee:	0f b6 00             	movzbl (%rax),%eax
   43df1:	38 c1                	cmp    %al,%cl
   43df3:	0f 92 c0             	setb   %al
   43df6:	0f b6 c0             	movzbl %al,%eax
   43df9:	29 c2                	sub    %eax,%edx
   43dfb:	89 d0                	mov    %edx,%eax
}
   43dfd:	c9                   	leave  
   43dfe:	c3                   	ret    

0000000000043dff <strchr>:

char* strchr(const char* s, int c) {
   43dff:	55                   	push   %rbp
   43e00:	48 89 e5             	mov    %rsp,%rbp
   43e03:	48 83 ec 10          	sub    $0x10,%rsp
   43e07:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43e0b:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   43e0e:	eb 05                	jmp    43e15 <strchr+0x16>
        ++s;
   43e10:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   43e15:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e19:	0f b6 00             	movzbl (%rax),%eax
   43e1c:	84 c0                	test   %al,%al
   43e1e:	74 0e                	je     43e2e <strchr+0x2f>
   43e20:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e24:	0f b6 00             	movzbl (%rax),%eax
   43e27:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43e2a:	38 d0                	cmp    %dl,%al
   43e2c:	75 e2                	jne    43e10 <strchr+0x11>
    }
    if (*s == (char) c) {
   43e2e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e32:	0f b6 00             	movzbl (%rax),%eax
   43e35:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43e38:	38 d0                	cmp    %dl,%al
   43e3a:	75 06                	jne    43e42 <strchr+0x43>
        return (char*) s;
   43e3c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e40:	eb 05                	jmp    43e47 <strchr+0x48>
    } else {
        return NULL;
   43e42:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   43e47:	c9                   	leave  
   43e48:	c3                   	ret    

0000000000043e49 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   43e49:	55                   	push   %rbp
   43e4a:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   43e4d:	8b 05 b5 41 01 00    	mov    0x141b5(%rip),%eax        # 58008 <rand_seed_set>
   43e53:	85 c0                	test   %eax,%eax
   43e55:	75 0a                	jne    43e61 <rand+0x18>
        srand(819234718U);
   43e57:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   43e5c:	e8 24 00 00 00       	call   43e85 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   43e61:	8b 05 a5 41 01 00    	mov    0x141a5(%rip),%eax        # 5800c <rand_seed>
   43e67:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   43e6d:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   43e72:	89 05 94 41 01 00    	mov    %eax,0x14194(%rip)        # 5800c <rand_seed>
    return rand_seed & RAND_MAX;
   43e78:	8b 05 8e 41 01 00    	mov    0x1418e(%rip),%eax        # 5800c <rand_seed>
   43e7e:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   43e83:	5d                   	pop    %rbp
   43e84:	c3                   	ret    

0000000000043e85 <srand>:

void srand(unsigned seed) {
   43e85:	55                   	push   %rbp
   43e86:	48 89 e5             	mov    %rsp,%rbp
   43e89:	48 83 ec 08          	sub    $0x8,%rsp
   43e8d:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   43e90:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43e93:	89 05 73 41 01 00    	mov    %eax,0x14173(%rip)        # 5800c <rand_seed>
    rand_seed_set = 1;
   43e99:	c7 05 65 41 01 00 01 	movl   $0x1,0x14165(%rip)        # 58008 <rand_seed_set>
   43ea0:	00 00 00 
}
   43ea3:	90                   	nop
   43ea4:	c9                   	leave  
   43ea5:	c3                   	ret    

0000000000043ea6 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   43ea6:	55                   	push   %rbp
   43ea7:	48 89 e5             	mov    %rsp,%rbp
   43eaa:	48 83 ec 28          	sub    $0x28,%rsp
   43eae:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43eb2:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43eb6:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   43eb9:	48 c7 45 f8 40 5a 04 	movq   $0x45a40,-0x8(%rbp)
   43ec0:	00 
    if (base < 0) {
   43ec1:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   43ec5:	79 0b                	jns    43ed2 <fill_numbuf+0x2c>
        digits = lower_digits;
   43ec7:	48 c7 45 f8 60 5a 04 	movq   $0x45a60,-0x8(%rbp)
   43ece:	00 
        base = -base;
   43ecf:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   43ed2:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43ed7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43edb:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   43ede:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43ee1:	48 63 c8             	movslq %eax,%rcx
   43ee4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43ee8:	ba 00 00 00 00       	mov    $0x0,%edx
   43eed:	48 f7 f1             	div    %rcx
   43ef0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43ef4:	48 01 d0             	add    %rdx,%rax
   43ef7:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43efc:	0f b6 10             	movzbl (%rax),%edx
   43eff:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43f03:	88 10                	mov    %dl,(%rax)
        val /= base;
   43f05:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43f08:	48 63 f0             	movslq %eax,%rsi
   43f0b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43f0f:	ba 00 00 00 00       	mov    $0x0,%edx
   43f14:	48 f7 f6             	div    %rsi
   43f17:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   43f1b:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43f20:	75 bc                	jne    43ede <fill_numbuf+0x38>
    return numbuf_end;
   43f22:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43f26:	c9                   	leave  
   43f27:	c3                   	ret    

0000000000043f28 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   43f28:	55                   	push   %rbp
   43f29:	48 89 e5             	mov    %rsp,%rbp
   43f2c:	53                   	push   %rbx
   43f2d:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   43f34:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   43f3b:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   43f41:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43f48:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   43f4f:	e9 8a 09 00 00       	jmp    448de <printer_vprintf+0x9b6>
        if (*format != '%') {
   43f54:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f5b:	0f b6 00             	movzbl (%rax),%eax
   43f5e:	3c 25                	cmp    $0x25,%al
   43f60:	74 31                	je     43f93 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
   43f62:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43f69:	4c 8b 00             	mov    (%rax),%r8
   43f6c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f73:	0f b6 00             	movzbl (%rax),%eax
   43f76:	0f b6 c8             	movzbl %al,%ecx
   43f79:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43f7f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43f86:	89 ce                	mov    %ecx,%esi
   43f88:	48 89 c7             	mov    %rax,%rdi
   43f8b:	41 ff d0             	call   *%r8
            continue;
   43f8e:	e9 43 09 00 00       	jmp    448d6 <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
   43f93:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   43f9a:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43fa1:	01 
   43fa2:	eb 44                	jmp    43fe8 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
   43fa4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43fab:	0f b6 00             	movzbl (%rax),%eax
   43fae:	0f be c0             	movsbl %al,%eax
   43fb1:	89 c6                	mov    %eax,%esi
   43fb3:	bf 60 58 04 00       	mov    $0x45860,%edi
   43fb8:	e8 42 fe ff ff       	call   43dff <strchr>
   43fbd:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   43fc1:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   43fc6:	74 30                	je     43ff8 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
   43fc8:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   43fcc:	48 2d 60 58 04 00    	sub    $0x45860,%rax
   43fd2:	ba 01 00 00 00       	mov    $0x1,%edx
   43fd7:	89 c1                	mov    %eax,%ecx
   43fd9:	d3 e2                	shl    %cl,%edx
   43fdb:	89 d0                	mov    %edx,%eax
   43fdd:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   43fe0:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43fe7:	01 
   43fe8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43fef:	0f b6 00             	movzbl (%rax),%eax
   43ff2:	84 c0                	test   %al,%al
   43ff4:	75 ae                	jne    43fa4 <printer_vprintf+0x7c>
   43ff6:	eb 01                	jmp    43ff9 <printer_vprintf+0xd1>
            } else {
                break;
   43ff8:	90                   	nop
            }
        }

        // process width
        int width = -1;
   43ff9:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   44000:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44007:	0f b6 00             	movzbl (%rax),%eax
   4400a:	3c 30                	cmp    $0x30,%al
   4400c:	7e 67                	jle    44075 <printer_vprintf+0x14d>
   4400e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44015:	0f b6 00             	movzbl (%rax),%eax
   44018:	3c 39                	cmp    $0x39,%al
   4401a:	7f 59                	jg     44075 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   4401c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   44023:	eb 2e                	jmp    44053 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
   44025:	8b 55 e8             	mov    -0x18(%rbp),%edx
   44028:	89 d0                	mov    %edx,%eax
   4402a:	c1 e0 02             	shl    $0x2,%eax
   4402d:	01 d0                	add    %edx,%eax
   4402f:	01 c0                	add    %eax,%eax
   44031:	89 c1                	mov    %eax,%ecx
   44033:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4403a:	48 8d 50 01          	lea    0x1(%rax),%rdx
   4403e:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   44045:	0f b6 00             	movzbl (%rax),%eax
   44048:	0f be c0             	movsbl %al,%eax
   4404b:	01 c8                	add    %ecx,%eax
   4404d:	83 e8 30             	sub    $0x30,%eax
   44050:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   44053:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4405a:	0f b6 00             	movzbl (%rax),%eax
   4405d:	3c 2f                	cmp    $0x2f,%al
   4405f:	0f 8e 85 00 00 00    	jle    440ea <printer_vprintf+0x1c2>
   44065:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4406c:	0f b6 00             	movzbl (%rax),%eax
   4406f:	3c 39                	cmp    $0x39,%al
   44071:	7e b2                	jle    44025 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
   44073:	eb 75                	jmp    440ea <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
   44075:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4407c:	0f b6 00             	movzbl (%rax),%eax
   4407f:	3c 2a                	cmp    $0x2a,%al
   44081:	75 68                	jne    440eb <printer_vprintf+0x1c3>
            width = va_arg(val, int);
   44083:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4408a:	8b 00                	mov    (%rax),%eax
   4408c:	83 f8 2f             	cmp    $0x2f,%eax
   4408f:	77 30                	ja     440c1 <printer_vprintf+0x199>
   44091:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44098:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4409c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   440a3:	8b 00                	mov    (%rax),%eax
   440a5:	89 c0                	mov    %eax,%eax
   440a7:	48 01 d0             	add    %rdx,%rax
   440aa:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   440b1:	8b 12                	mov    (%rdx),%edx
   440b3:	8d 4a 08             	lea    0x8(%rdx),%ecx
   440b6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   440bd:	89 0a                	mov    %ecx,(%rdx)
   440bf:	eb 1a                	jmp    440db <printer_vprintf+0x1b3>
   440c1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   440c8:	48 8b 40 08          	mov    0x8(%rax),%rax
   440cc:	48 8d 48 08          	lea    0x8(%rax),%rcx
   440d0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   440d7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   440db:	8b 00                	mov    (%rax),%eax
   440dd:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   440e0:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   440e7:	01 
   440e8:	eb 01                	jmp    440eb <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
   440ea:	90                   	nop
        }

        // process precision
        int precision = -1;
   440eb:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   440f2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   440f9:	0f b6 00             	movzbl (%rax),%eax
   440fc:	3c 2e                	cmp    $0x2e,%al
   440fe:	0f 85 00 01 00 00    	jne    44204 <printer_vprintf+0x2dc>
            ++format;
   44104:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4410b:	01 
            if (*format >= '0' && *format <= '9') {
   4410c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44113:	0f b6 00             	movzbl (%rax),%eax
   44116:	3c 2f                	cmp    $0x2f,%al
   44118:	7e 67                	jle    44181 <printer_vprintf+0x259>
   4411a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44121:	0f b6 00             	movzbl (%rax),%eax
   44124:	3c 39                	cmp    $0x39,%al
   44126:	7f 59                	jg     44181 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   44128:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   4412f:	eb 2e                	jmp    4415f <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
   44131:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   44134:	89 d0                	mov    %edx,%eax
   44136:	c1 e0 02             	shl    $0x2,%eax
   44139:	01 d0                	add    %edx,%eax
   4413b:	01 c0                	add    %eax,%eax
   4413d:	89 c1                	mov    %eax,%ecx
   4413f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44146:	48 8d 50 01          	lea    0x1(%rax),%rdx
   4414a:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   44151:	0f b6 00             	movzbl (%rax),%eax
   44154:	0f be c0             	movsbl %al,%eax
   44157:	01 c8                	add    %ecx,%eax
   44159:	83 e8 30             	sub    $0x30,%eax
   4415c:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   4415f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44166:	0f b6 00             	movzbl (%rax),%eax
   44169:	3c 2f                	cmp    $0x2f,%al
   4416b:	0f 8e 85 00 00 00    	jle    441f6 <printer_vprintf+0x2ce>
   44171:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44178:	0f b6 00             	movzbl (%rax),%eax
   4417b:	3c 39                	cmp    $0x39,%al
   4417d:	7e b2                	jle    44131 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
   4417f:	eb 75                	jmp    441f6 <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
   44181:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44188:	0f b6 00             	movzbl (%rax),%eax
   4418b:	3c 2a                	cmp    $0x2a,%al
   4418d:	75 68                	jne    441f7 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
   4418f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44196:	8b 00                	mov    (%rax),%eax
   44198:	83 f8 2f             	cmp    $0x2f,%eax
   4419b:	77 30                	ja     441cd <printer_vprintf+0x2a5>
   4419d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   441a4:	48 8b 50 10          	mov    0x10(%rax),%rdx
   441a8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   441af:	8b 00                	mov    (%rax),%eax
   441b1:	89 c0                	mov    %eax,%eax
   441b3:	48 01 d0             	add    %rdx,%rax
   441b6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   441bd:	8b 12                	mov    (%rdx),%edx
   441bf:	8d 4a 08             	lea    0x8(%rdx),%ecx
   441c2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   441c9:	89 0a                	mov    %ecx,(%rdx)
   441cb:	eb 1a                	jmp    441e7 <printer_vprintf+0x2bf>
   441cd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   441d4:	48 8b 40 08          	mov    0x8(%rax),%rax
   441d8:	48 8d 48 08          	lea    0x8(%rax),%rcx
   441dc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   441e3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   441e7:	8b 00                	mov    (%rax),%eax
   441e9:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   441ec:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   441f3:	01 
   441f4:	eb 01                	jmp    441f7 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
   441f6:	90                   	nop
            }
            if (precision < 0) {
   441f7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   441fb:	79 07                	jns    44204 <printer_vprintf+0x2dc>
                precision = 0;
   441fd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   44204:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   4420b:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   44212:	00 
        int length = 0;
   44213:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   4421a:	48 c7 45 c8 66 58 04 	movq   $0x45866,-0x38(%rbp)
   44221:	00 
    again:
        switch (*format) {
   44222:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44229:	0f b6 00             	movzbl (%rax),%eax
   4422c:	0f be c0             	movsbl %al,%eax
   4422f:	83 e8 43             	sub    $0x43,%eax
   44232:	83 f8 37             	cmp    $0x37,%eax
   44235:	0f 87 9f 03 00 00    	ja     445da <printer_vprintf+0x6b2>
   4423b:	89 c0                	mov    %eax,%eax
   4423d:	48 8b 04 c5 78 58 04 	mov    0x45878(,%rax,8),%rax
   44244:	00 
   44245:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
   44247:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   4424e:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44255:	01 
            goto again;
   44256:	eb ca                	jmp    44222 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   44258:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   4425c:	74 5d                	je     442bb <printer_vprintf+0x393>
   4425e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44265:	8b 00                	mov    (%rax),%eax
   44267:	83 f8 2f             	cmp    $0x2f,%eax
   4426a:	77 30                	ja     4429c <printer_vprintf+0x374>
   4426c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44273:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44277:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4427e:	8b 00                	mov    (%rax),%eax
   44280:	89 c0                	mov    %eax,%eax
   44282:	48 01 d0             	add    %rdx,%rax
   44285:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4428c:	8b 12                	mov    (%rdx),%edx
   4428e:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44291:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44298:	89 0a                	mov    %ecx,(%rdx)
   4429a:	eb 1a                	jmp    442b6 <printer_vprintf+0x38e>
   4429c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442a3:	48 8b 40 08          	mov    0x8(%rax),%rax
   442a7:	48 8d 48 08          	lea    0x8(%rax),%rcx
   442ab:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442b2:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   442b6:	48 8b 00             	mov    (%rax),%rax
   442b9:	eb 5c                	jmp    44317 <printer_vprintf+0x3ef>
   442bb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442c2:	8b 00                	mov    (%rax),%eax
   442c4:	83 f8 2f             	cmp    $0x2f,%eax
   442c7:	77 30                	ja     442f9 <printer_vprintf+0x3d1>
   442c9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442d0:	48 8b 50 10          	mov    0x10(%rax),%rdx
   442d4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442db:	8b 00                	mov    (%rax),%eax
   442dd:	89 c0                	mov    %eax,%eax
   442df:	48 01 d0             	add    %rdx,%rax
   442e2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442e9:	8b 12                	mov    (%rdx),%edx
   442eb:	8d 4a 08             	lea    0x8(%rdx),%ecx
   442ee:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442f5:	89 0a                	mov    %ecx,(%rdx)
   442f7:	eb 1a                	jmp    44313 <printer_vprintf+0x3eb>
   442f9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44300:	48 8b 40 08          	mov    0x8(%rax),%rax
   44304:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44308:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4430f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44313:	8b 00                	mov    (%rax),%eax
   44315:	48 98                	cltq   
   44317:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   4431b:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4431f:	48 c1 f8 38          	sar    $0x38,%rax
   44323:	25 80 00 00 00       	and    $0x80,%eax
   44328:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   4432b:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   4432f:	74 09                	je     4433a <printer_vprintf+0x412>
   44331:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44335:	48 f7 d8             	neg    %rax
   44338:	eb 04                	jmp    4433e <printer_vprintf+0x416>
   4433a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4433e:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   44342:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   44345:	83 c8 60             	or     $0x60,%eax
   44348:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   4434b:	e9 cf 02 00 00       	jmp    4461f <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   44350:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   44354:	74 5d                	je     443b3 <printer_vprintf+0x48b>
   44356:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4435d:	8b 00                	mov    (%rax),%eax
   4435f:	83 f8 2f             	cmp    $0x2f,%eax
   44362:	77 30                	ja     44394 <printer_vprintf+0x46c>
   44364:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4436b:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4436f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44376:	8b 00                	mov    (%rax),%eax
   44378:	89 c0                	mov    %eax,%eax
   4437a:	48 01 d0             	add    %rdx,%rax
   4437d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44384:	8b 12                	mov    (%rdx),%edx
   44386:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44389:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44390:	89 0a                	mov    %ecx,(%rdx)
   44392:	eb 1a                	jmp    443ae <printer_vprintf+0x486>
   44394:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4439b:	48 8b 40 08          	mov    0x8(%rax),%rax
   4439f:	48 8d 48 08          	lea    0x8(%rax),%rcx
   443a3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   443aa:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   443ae:	48 8b 00             	mov    (%rax),%rax
   443b1:	eb 5c                	jmp    4440f <printer_vprintf+0x4e7>
   443b3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443ba:	8b 00                	mov    (%rax),%eax
   443bc:	83 f8 2f             	cmp    $0x2f,%eax
   443bf:	77 30                	ja     443f1 <printer_vprintf+0x4c9>
   443c1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443c8:	48 8b 50 10          	mov    0x10(%rax),%rdx
   443cc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443d3:	8b 00                	mov    (%rax),%eax
   443d5:	89 c0                	mov    %eax,%eax
   443d7:	48 01 d0             	add    %rdx,%rax
   443da:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   443e1:	8b 12                	mov    (%rdx),%edx
   443e3:	8d 4a 08             	lea    0x8(%rdx),%ecx
   443e6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   443ed:	89 0a                	mov    %ecx,(%rdx)
   443ef:	eb 1a                	jmp    4440b <printer_vprintf+0x4e3>
   443f1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443f8:	48 8b 40 08          	mov    0x8(%rax),%rax
   443fc:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44400:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44407:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4440b:	8b 00                	mov    (%rax),%eax
   4440d:	89 c0                	mov    %eax,%eax
   4440f:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   44413:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   44417:	e9 03 02 00 00       	jmp    4461f <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
   4441c:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   44423:	e9 28 ff ff ff       	jmp    44350 <printer_vprintf+0x428>
        case 'X':
            base = 16;
   44428:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   4442f:	e9 1c ff ff ff       	jmp    44350 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   44434:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4443b:	8b 00                	mov    (%rax),%eax
   4443d:	83 f8 2f             	cmp    $0x2f,%eax
   44440:	77 30                	ja     44472 <printer_vprintf+0x54a>
   44442:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44449:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4444d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44454:	8b 00                	mov    (%rax),%eax
   44456:	89 c0                	mov    %eax,%eax
   44458:	48 01 d0             	add    %rdx,%rax
   4445b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44462:	8b 12                	mov    (%rdx),%edx
   44464:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44467:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4446e:	89 0a                	mov    %ecx,(%rdx)
   44470:	eb 1a                	jmp    4448c <printer_vprintf+0x564>
   44472:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44479:	48 8b 40 08          	mov    0x8(%rax),%rax
   4447d:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44481:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44488:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4448c:	48 8b 00             	mov    (%rax),%rax
   4448f:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   44493:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   4449a:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   444a1:	e9 79 01 00 00       	jmp    4461f <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
   444a6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444ad:	8b 00                	mov    (%rax),%eax
   444af:	83 f8 2f             	cmp    $0x2f,%eax
   444b2:	77 30                	ja     444e4 <printer_vprintf+0x5bc>
   444b4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444bb:	48 8b 50 10          	mov    0x10(%rax),%rdx
   444bf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444c6:	8b 00                	mov    (%rax),%eax
   444c8:	89 c0                	mov    %eax,%eax
   444ca:	48 01 d0             	add    %rdx,%rax
   444cd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   444d4:	8b 12                	mov    (%rdx),%edx
   444d6:	8d 4a 08             	lea    0x8(%rdx),%ecx
   444d9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   444e0:	89 0a                	mov    %ecx,(%rdx)
   444e2:	eb 1a                	jmp    444fe <printer_vprintf+0x5d6>
   444e4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444eb:	48 8b 40 08          	mov    0x8(%rax),%rax
   444ef:	48 8d 48 08          	lea    0x8(%rax),%rcx
   444f3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   444fa:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   444fe:	48 8b 00             	mov    (%rax),%rax
   44501:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   44505:	e9 15 01 00 00       	jmp    4461f <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
   4450a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44511:	8b 00                	mov    (%rax),%eax
   44513:	83 f8 2f             	cmp    $0x2f,%eax
   44516:	77 30                	ja     44548 <printer_vprintf+0x620>
   44518:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4451f:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44523:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4452a:	8b 00                	mov    (%rax),%eax
   4452c:	89 c0                	mov    %eax,%eax
   4452e:	48 01 d0             	add    %rdx,%rax
   44531:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44538:	8b 12                	mov    (%rdx),%edx
   4453a:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4453d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44544:	89 0a                	mov    %ecx,(%rdx)
   44546:	eb 1a                	jmp    44562 <printer_vprintf+0x63a>
   44548:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4454f:	48 8b 40 08          	mov    0x8(%rax),%rax
   44553:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44557:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4455e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44562:	8b 00                	mov    (%rax),%eax
   44564:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   4456a:	e9 67 03 00 00       	jmp    448d6 <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
   4456f:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   44573:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   44577:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4457e:	8b 00                	mov    (%rax),%eax
   44580:	83 f8 2f             	cmp    $0x2f,%eax
   44583:	77 30                	ja     445b5 <printer_vprintf+0x68d>
   44585:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4458c:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44590:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44597:	8b 00                	mov    (%rax),%eax
   44599:	89 c0                	mov    %eax,%eax
   4459b:	48 01 d0             	add    %rdx,%rax
   4459e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445a5:	8b 12                	mov    (%rdx),%edx
   445a7:	8d 4a 08             	lea    0x8(%rdx),%ecx
   445aa:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445b1:	89 0a                	mov    %ecx,(%rdx)
   445b3:	eb 1a                	jmp    445cf <printer_vprintf+0x6a7>
   445b5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445bc:	48 8b 40 08          	mov    0x8(%rax),%rax
   445c0:	48 8d 48 08          	lea    0x8(%rax),%rcx
   445c4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445cb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   445cf:	8b 00                	mov    (%rax),%eax
   445d1:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   445d4:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   445d8:	eb 45                	jmp    4461f <printer_vprintf+0x6f7>
        default:
            data = numbuf;
   445da:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   445de:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   445e2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   445e9:	0f b6 00             	movzbl (%rax),%eax
   445ec:	84 c0                	test   %al,%al
   445ee:	74 0c                	je     445fc <printer_vprintf+0x6d4>
   445f0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   445f7:	0f b6 00             	movzbl (%rax),%eax
   445fa:	eb 05                	jmp    44601 <printer_vprintf+0x6d9>
   445fc:	b8 25 00 00 00       	mov    $0x25,%eax
   44601:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   44604:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   44608:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4460f:	0f b6 00             	movzbl (%rax),%eax
   44612:	84 c0                	test   %al,%al
   44614:	75 08                	jne    4461e <printer_vprintf+0x6f6>
                format--;
   44616:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   4461d:	01 
            }
            break;
   4461e:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   4461f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44622:	83 e0 20             	and    $0x20,%eax
   44625:	85 c0                	test   %eax,%eax
   44627:	74 1e                	je     44647 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   44629:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   4462d:	48 83 c0 18          	add    $0x18,%rax
   44631:	8b 55 e0             	mov    -0x20(%rbp),%edx
   44634:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   44638:	48 89 ce             	mov    %rcx,%rsi
   4463b:	48 89 c7             	mov    %rax,%rdi
   4463e:	e8 63 f8 ff ff       	call   43ea6 <fill_numbuf>
   44643:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   44647:	48 c7 45 c0 66 58 04 	movq   $0x45866,-0x40(%rbp)
   4464e:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   4464f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44652:	83 e0 20             	and    $0x20,%eax
   44655:	85 c0                	test   %eax,%eax
   44657:	74 48                	je     446a1 <printer_vprintf+0x779>
   44659:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4465c:	83 e0 40             	and    $0x40,%eax
   4465f:	85 c0                	test   %eax,%eax
   44661:	74 3e                	je     446a1 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
   44663:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44666:	25 80 00 00 00       	and    $0x80,%eax
   4466b:	85 c0                	test   %eax,%eax
   4466d:	74 0a                	je     44679 <printer_vprintf+0x751>
                prefix = "-";
   4466f:	48 c7 45 c0 67 58 04 	movq   $0x45867,-0x40(%rbp)
   44676:	00 
            if (flags & FLAG_NEGATIVE) {
   44677:	eb 73                	jmp    446ec <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   44679:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4467c:	83 e0 10             	and    $0x10,%eax
   4467f:	85 c0                	test   %eax,%eax
   44681:	74 0a                	je     4468d <printer_vprintf+0x765>
                prefix = "+";
   44683:	48 c7 45 c0 69 58 04 	movq   $0x45869,-0x40(%rbp)
   4468a:	00 
            if (flags & FLAG_NEGATIVE) {
   4468b:	eb 5f                	jmp    446ec <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   4468d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44690:	83 e0 08             	and    $0x8,%eax
   44693:	85 c0                	test   %eax,%eax
   44695:	74 55                	je     446ec <printer_vprintf+0x7c4>
                prefix = " ";
   44697:	48 c7 45 c0 6b 58 04 	movq   $0x4586b,-0x40(%rbp)
   4469e:	00 
            if (flags & FLAG_NEGATIVE) {
   4469f:	eb 4b                	jmp    446ec <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   446a1:	8b 45 ec             	mov    -0x14(%rbp),%eax
   446a4:	83 e0 20             	and    $0x20,%eax
   446a7:	85 c0                	test   %eax,%eax
   446a9:	74 42                	je     446ed <printer_vprintf+0x7c5>
   446ab:	8b 45 ec             	mov    -0x14(%rbp),%eax
   446ae:	83 e0 01             	and    $0x1,%eax
   446b1:	85 c0                	test   %eax,%eax
   446b3:	74 38                	je     446ed <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
   446b5:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   446b9:	74 06                	je     446c1 <printer_vprintf+0x799>
   446bb:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   446bf:	75 2c                	jne    446ed <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
   446c1:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   446c6:	75 0c                	jne    446d4 <printer_vprintf+0x7ac>
   446c8:	8b 45 ec             	mov    -0x14(%rbp),%eax
   446cb:	25 00 01 00 00       	and    $0x100,%eax
   446d0:	85 c0                	test   %eax,%eax
   446d2:	74 19                	je     446ed <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
   446d4:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   446d8:	75 07                	jne    446e1 <printer_vprintf+0x7b9>
   446da:	b8 6d 58 04 00       	mov    $0x4586d,%eax
   446df:	eb 05                	jmp    446e6 <printer_vprintf+0x7be>
   446e1:	b8 70 58 04 00       	mov    $0x45870,%eax
   446e6:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   446ea:	eb 01                	jmp    446ed <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
   446ec:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   446ed:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   446f1:	78 24                	js     44717 <printer_vprintf+0x7ef>
   446f3:	8b 45 ec             	mov    -0x14(%rbp),%eax
   446f6:	83 e0 20             	and    $0x20,%eax
   446f9:	85 c0                	test   %eax,%eax
   446fb:	75 1a                	jne    44717 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
   446fd:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44700:	48 63 d0             	movslq %eax,%rdx
   44703:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44707:	48 89 d6             	mov    %rdx,%rsi
   4470a:	48 89 c7             	mov    %rax,%rdi
   4470d:	e8 ea f5 ff ff       	call   43cfc <strnlen>
   44712:	89 45 bc             	mov    %eax,-0x44(%rbp)
   44715:	eb 0f                	jmp    44726 <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
   44717:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4471b:	48 89 c7             	mov    %rax,%rdi
   4471e:	e8 a8 f5 ff ff       	call   43ccb <strlen>
   44723:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   44726:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44729:	83 e0 20             	and    $0x20,%eax
   4472c:	85 c0                	test   %eax,%eax
   4472e:	74 20                	je     44750 <printer_vprintf+0x828>
   44730:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   44734:	78 1a                	js     44750 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
   44736:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44739:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   4473c:	7e 08                	jle    44746 <printer_vprintf+0x81e>
   4473e:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44741:	2b 45 bc             	sub    -0x44(%rbp),%eax
   44744:	eb 05                	jmp    4474b <printer_vprintf+0x823>
   44746:	b8 00 00 00 00       	mov    $0x0,%eax
   4474b:	89 45 b8             	mov    %eax,-0x48(%rbp)
   4474e:	eb 5c                	jmp    447ac <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   44750:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44753:	83 e0 20             	and    $0x20,%eax
   44756:	85 c0                	test   %eax,%eax
   44758:	74 4b                	je     447a5 <printer_vprintf+0x87d>
   4475a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4475d:	83 e0 02             	and    $0x2,%eax
   44760:	85 c0                	test   %eax,%eax
   44762:	74 41                	je     447a5 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
   44764:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44767:	83 e0 04             	and    $0x4,%eax
   4476a:	85 c0                	test   %eax,%eax
   4476c:	75 37                	jne    447a5 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
   4476e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44772:	48 89 c7             	mov    %rax,%rdi
   44775:	e8 51 f5 ff ff       	call   43ccb <strlen>
   4477a:	89 c2                	mov    %eax,%edx
   4477c:	8b 45 bc             	mov    -0x44(%rbp),%eax
   4477f:	01 d0                	add    %edx,%eax
   44781:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   44784:	7e 1f                	jle    447a5 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
   44786:	8b 45 e8             	mov    -0x18(%rbp),%eax
   44789:	2b 45 bc             	sub    -0x44(%rbp),%eax
   4478c:	89 c3                	mov    %eax,%ebx
   4478e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44792:	48 89 c7             	mov    %rax,%rdi
   44795:	e8 31 f5 ff ff       	call   43ccb <strlen>
   4479a:	89 c2                	mov    %eax,%edx
   4479c:	89 d8                	mov    %ebx,%eax
   4479e:	29 d0                	sub    %edx,%eax
   447a0:	89 45 b8             	mov    %eax,-0x48(%rbp)
   447a3:	eb 07                	jmp    447ac <printer_vprintf+0x884>
        } else {
            zeros = 0;
   447a5:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   447ac:	8b 55 bc             	mov    -0x44(%rbp),%edx
   447af:	8b 45 b8             	mov    -0x48(%rbp),%eax
   447b2:	01 d0                	add    %edx,%eax
   447b4:	48 63 d8             	movslq %eax,%rbx
   447b7:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   447bb:	48 89 c7             	mov    %rax,%rdi
   447be:	e8 08 f5 ff ff       	call   43ccb <strlen>
   447c3:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   447c7:	8b 45 e8             	mov    -0x18(%rbp),%eax
   447ca:	29 d0                	sub    %edx,%eax
   447cc:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   447cf:	eb 25                	jmp    447f6 <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
   447d1:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   447d8:	48 8b 08             	mov    (%rax),%rcx
   447db:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   447e1:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   447e8:	be 20 00 00 00       	mov    $0x20,%esi
   447ed:	48 89 c7             	mov    %rax,%rdi
   447f0:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   447f2:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   447f6:	8b 45 ec             	mov    -0x14(%rbp),%eax
   447f9:	83 e0 04             	and    $0x4,%eax
   447fc:	85 c0                	test   %eax,%eax
   447fe:	75 36                	jne    44836 <printer_vprintf+0x90e>
   44800:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   44804:	7f cb                	jg     447d1 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
   44806:	eb 2e                	jmp    44836 <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
   44808:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4480f:	4c 8b 00             	mov    (%rax),%r8
   44812:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44816:	0f b6 00             	movzbl (%rax),%eax
   44819:	0f b6 c8             	movzbl %al,%ecx
   4481c:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44822:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44829:	89 ce                	mov    %ecx,%esi
   4482b:	48 89 c7             	mov    %rax,%rdi
   4482e:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   44831:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   44836:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4483a:	0f b6 00             	movzbl (%rax),%eax
   4483d:	84 c0                	test   %al,%al
   4483f:	75 c7                	jne    44808 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
   44841:	eb 25                	jmp    44868 <printer_vprintf+0x940>
            p->putc(p, '0', color);
   44843:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4484a:	48 8b 08             	mov    (%rax),%rcx
   4484d:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44853:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4485a:	be 30 00 00 00       	mov    $0x30,%esi
   4485f:	48 89 c7             	mov    %rax,%rdi
   44862:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   44864:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   44868:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   4486c:	7f d5                	jg     44843 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
   4486e:	eb 32                	jmp    448a2 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
   44870:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44877:	4c 8b 00             	mov    (%rax),%r8
   4487a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4487e:	0f b6 00             	movzbl (%rax),%eax
   44881:	0f b6 c8             	movzbl %al,%ecx
   44884:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   4488a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44891:	89 ce                	mov    %ecx,%esi
   44893:	48 89 c7             	mov    %rax,%rdi
   44896:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   44899:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   4489e:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   448a2:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   448a6:	7f c8                	jg     44870 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
   448a8:	eb 25                	jmp    448cf <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
   448aa:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   448b1:	48 8b 08             	mov    (%rax),%rcx
   448b4:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   448ba:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   448c1:	be 20 00 00 00       	mov    $0x20,%esi
   448c6:	48 89 c7             	mov    %rax,%rdi
   448c9:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   448cb:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   448cf:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   448d3:	7f d5                	jg     448aa <printer_vprintf+0x982>
        }
    done: ;
   448d5:	90                   	nop
    for (; *format; ++format) {
   448d6:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   448dd:	01 
   448de:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   448e5:	0f b6 00             	movzbl (%rax),%eax
   448e8:	84 c0                	test   %al,%al
   448ea:	0f 85 64 f6 ff ff    	jne    43f54 <printer_vprintf+0x2c>
    }
}
   448f0:	90                   	nop
   448f1:	90                   	nop
   448f2:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   448f6:	c9                   	leave  
   448f7:	c3                   	ret    

00000000000448f8 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   448f8:	55                   	push   %rbp
   448f9:	48 89 e5             	mov    %rsp,%rbp
   448fc:	48 83 ec 20          	sub    $0x20,%rsp
   44900:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44904:	89 f0                	mov    %esi,%eax
   44906:	89 55 e0             	mov    %edx,-0x20(%rbp)
   44909:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   4490c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44910:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   44914:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44918:	48 8b 40 08          	mov    0x8(%rax),%rax
   4491c:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
   44921:	48 39 d0             	cmp    %rdx,%rax
   44924:	72 0c                	jb     44932 <console_putc+0x3a>
        cp->cursor = console;
   44926:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4492a:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
   44931:	00 
    }
    if (c == '\n') {
   44932:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   44936:	75 78                	jne    449b0 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
   44938:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4493c:	48 8b 40 08          	mov    0x8(%rax),%rax
   44940:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   44946:	48 d1 f8             	sar    %rax
   44949:	48 89 c1             	mov    %rax,%rcx
   4494c:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   44953:	66 66 66 
   44956:	48 89 c8             	mov    %rcx,%rax
   44959:	48 f7 ea             	imul   %rdx
   4495c:	48 c1 fa 05          	sar    $0x5,%rdx
   44960:	48 89 c8             	mov    %rcx,%rax
   44963:	48 c1 f8 3f          	sar    $0x3f,%rax
   44967:	48 29 c2             	sub    %rax,%rdx
   4496a:	48 89 d0             	mov    %rdx,%rax
   4496d:	48 c1 e0 02          	shl    $0x2,%rax
   44971:	48 01 d0             	add    %rdx,%rax
   44974:	48 c1 e0 04          	shl    $0x4,%rax
   44978:	48 29 c1             	sub    %rax,%rcx
   4497b:	48 89 ca             	mov    %rcx,%rdx
   4497e:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   44981:	eb 25                	jmp    449a8 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
   44983:	8b 45 e0             	mov    -0x20(%rbp),%eax
   44986:	83 c8 20             	or     $0x20,%eax
   44989:	89 c6                	mov    %eax,%esi
   4498b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4498f:	48 8b 40 08          	mov    0x8(%rax),%rax
   44993:	48 8d 48 02          	lea    0x2(%rax),%rcx
   44997:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4499b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4499f:	89 f2                	mov    %esi,%edx
   449a1:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   449a4:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   449a8:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   449ac:	75 d5                	jne    44983 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   449ae:	eb 24                	jmp    449d4 <console_putc+0xdc>
        *cp->cursor++ = c | color;
   449b0:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
   449b4:	8b 55 e0             	mov    -0x20(%rbp),%edx
   449b7:	09 d0                	or     %edx,%eax
   449b9:	89 c6                	mov    %eax,%esi
   449bb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   449bf:	48 8b 40 08          	mov    0x8(%rax),%rax
   449c3:	48 8d 48 02          	lea    0x2(%rax),%rcx
   449c7:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   449cb:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   449cf:	89 f2                	mov    %esi,%edx
   449d1:	66 89 10             	mov    %dx,(%rax)
}
   449d4:	90                   	nop
   449d5:	c9                   	leave  
   449d6:	c3                   	ret    

00000000000449d7 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   449d7:	55                   	push   %rbp
   449d8:	48 89 e5             	mov    %rsp,%rbp
   449db:	48 83 ec 30          	sub    $0x30,%rsp
   449df:	89 7d ec             	mov    %edi,-0x14(%rbp)
   449e2:	89 75 e8             	mov    %esi,-0x18(%rbp)
   449e5:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   449e9:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   449ed:	48 c7 45 f0 f8 48 04 	movq   $0x448f8,-0x10(%rbp)
   449f4:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   449f5:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   449f9:	78 09                	js     44a04 <console_vprintf+0x2d>
   449fb:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   44a02:	7e 07                	jle    44a0b <console_vprintf+0x34>
        cpos = 0;
   44a04:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   44a0b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44a0e:	48 98                	cltq   
   44a10:	48 01 c0             	add    %rax,%rax
   44a13:	48 05 00 80 0b 00    	add    $0xb8000,%rax
   44a19:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   44a1d:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   44a21:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   44a25:	8b 75 e8             	mov    -0x18(%rbp),%esi
   44a28:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   44a2c:	48 89 c7             	mov    %rax,%rdi
   44a2f:	e8 f4 f4 ff ff       	call   43f28 <printer_vprintf>
    return cp.cursor - console;
   44a34:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44a38:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   44a3e:	48 d1 f8             	sar    %rax
}
   44a41:	c9                   	leave  
   44a42:	c3                   	ret    

0000000000044a43 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   44a43:	55                   	push   %rbp
   44a44:	48 89 e5             	mov    %rsp,%rbp
   44a47:	48 83 ec 60          	sub    $0x60,%rsp
   44a4b:	89 7d ac             	mov    %edi,-0x54(%rbp)
   44a4e:	89 75 a8             	mov    %esi,-0x58(%rbp)
   44a51:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   44a55:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44a59:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44a5d:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44a61:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   44a68:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44a6c:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   44a70:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44a74:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   44a78:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   44a7c:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   44a80:	8b 75 a8             	mov    -0x58(%rbp),%esi
   44a83:	8b 45 ac             	mov    -0x54(%rbp),%eax
   44a86:	89 c7                	mov    %eax,%edi
   44a88:	e8 4a ff ff ff       	call   449d7 <console_vprintf>
   44a8d:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   44a90:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   44a93:	c9                   	leave  
   44a94:	c3                   	ret    

0000000000044a95 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   44a95:	55                   	push   %rbp
   44a96:	48 89 e5             	mov    %rsp,%rbp
   44a99:	48 83 ec 20          	sub    $0x20,%rsp
   44a9d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44aa1:	89 f0                	mov    %esi,%eax
   44aa3:	89 55 e0             	mov    %edx,-0x20(%rbp)
   44aa6:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   44aa9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44aad:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   44ab1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44ab5:	48 8b 50 08          	mov    0x8(%rax),%rdx
   44ab9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44abd:	48 8b 40 10          	mov    0x10(%rax),%rax
   44ac1:	48 39 c2             	cmp    %rax,%rdx
   44ac4:	73 1a                	jae    44ae0 <string_putc+0x4b>
        *sp->s++ = c;
   44ac6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44aca:	48 8b 40 08          	mov    0x8(%rax),%rax
   44ace:	48 8d 48 01          	lea    0x1(%rax),%rcx
   44ad2:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   44ad6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44ada:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   44ade:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   44ae0:	90                   	nop
   44ae1:	c9                   	leave  
   44ae2:	c3                   	ret    

0000000000044ae3 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   44ae3:	55                   	push   %rbp
   44ae4:	48 89 e5             	mov    %rsp,%rbp
   44ae7:	48 83 ec 40          	sub    $0x40,%rsp
   44aeb:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   44aef:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   44af3:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   44af7:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   44afb:	48 c7 45 e8 95 4a 04 	movq   $0x44a95,-0x18(%rbp)
   44b02:	00 
    sp.s = s;
   44b03:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44b07:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   44b0b:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   44b10:	74 33                	je     44b45 <vsnprintf+0x62>
        sp.end = s + size - 1;
   44b12:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   44b16:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   44b1a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44b1e:	48 01 d0             	add    %rdx,%rax
   44b21:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   44b25:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   44b29:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   44b2d:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   44b31:	be 00 00 00 00       	mov    $0x0,%esi
   44b36:	48 89 c7             	mov    %rax,%rdi
   44b39:	e8 ea f3 ff ff       	call   43f28 <printer_vprintf>
        *sp.s = 0;
   44b3e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44b42:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   44b45:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44b49:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   44b4d:	c9                   	leave  
   44b4e:	c3                   	ret    

0000000000044b4f <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   44b4f:	55                   	push   %rbp
   44b50:	48 89 e5             	mov    %rsp,%rbp
   44b53:	48 83 ec 70          	sub    $0x70,%rsp
   44b57:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   44b5b:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   44b5f:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   44b63:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44b67:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44b6b:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44b6f:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   44b76:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44b7a:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   44b7e:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44b82:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   44b86:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   44b8a:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   44b8e:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   44b92:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44b96:	48 89 c7             	mov    %rax,%rdi
   44b99:	e8 45 ff ff ff       	call   44ae3 <vsnprintf>
   44b9e:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   44ba1:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   44ba4:	c9                   	leave  
   44ba5:	c3                   	ret    

0000000000044ba6 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   44ba6:	55                   	push   %rbp
   44ba7:	48 89 e5             	mov    %rsp,%rbp
   44baa:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44bae:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   44bb5:	eb 13                	jmp    44bca <console_clear+0x24>
        console[i] = ' ' | 0x0700;
   44bb7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   44bba:	48 98                	cltq   
   44bbc:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
   44bc3:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44bc6:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44bca:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   44bd1:	7e e4                	jle    44bb7 <console_clear+0x11>
    }
    cursorpos = 0;
   44bd3:	c7 05 1f 44 07 00 00 	movl   $0x0,0x7441f(%rip)        # b8ffc <cursorpos>
   44bda:	00 00 00 
}
   44bdd:	90                   	nop
   44bde:	c9                   	leave  
   44bdf:	c3                   	ret    
