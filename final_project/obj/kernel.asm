
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
   40173:	e8 bb 14 00 00       	call   41633 <hardware_init>
    pageinfo_init();
   40178:	e8 2f 0b 00 00       	call   40cac <pageinfo_init>
    console_clear();
   4017d:	e8 59 4a 00 00       	call   44bdb <console_clear>
    timer_init(HZ);
   40182:	bf 64 00 00 00       	mov    $0x64,%edi
   40187:	e8 93 19 00 00       	call   41b1f <timer_init>

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   4018c:	ba 00 0f 00 00       	mov    $0xf00,%edx
   40191:	be 00 00 00 00       	mov    $0x0,%esi
   40196:	bf 00 e0 04 00       	mov    $0x4e000,%edi
   4019b:	e8 21 3b 00 00       	call   43cc1 <memset>
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
   401bd:	48 8d 90 00 e0 04 00 	lea    0x4e000(%rax),%rdx
   401c4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401c7:	89 02                	mov    %eax,(%rdx)
        processes[i].p_state = P_FREE;
   401c9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401cc:	48 63 d0             	movslq %eax,%rdx
   401cf:	48 89 d0             	mov    %rdx,%rax
   401d2:	48 c1 e0 04          	shl    $0x4,%rax
   401d6:	48 29 d0             	sub    %rdx,%rax
   401d9:	48 c1 e0 04          	shl    $0x4,%rax
   401dd:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
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
   401fe:	be 46 4c 04 00       	mov    $0x44c46,%esi
   40203:	48 89 c7             	mov    %rax,%rdi
   40206:	e8 af 3b 00 00       	call   43dba <strcmp>
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
   4022e:	be 4d 4c 04 00       	mov    $0x44c4d,%esi
   40233:	48 89 c7             	mov    %rax,%rdi
   40236:	e8 7f 3b 00 00       	call   43dba <strcmp>
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
   4025b:	be 58 4c 04 00       	mov    $0x44c58,%esi
   40260:	48 89 c7             	mov    %rax,%rdi
   40263:	e8 52 3b 00 00       	call   43dba <strcmp>
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
   40288:	be 5d 4c 04 00       	mov    $0x44c5d,%esi
   4028d:	48 89 c7             	mov    %rax,%rdi
   40290:	e8 25 3b 00 00       	call   43dba <strcmp>
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
   402cc:	bf f0 e0 04 00       	mov    $0x4e0f0,%edi
   402d1:	e8 45 09 00 00       	call   40c1b <run>

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
   402f8:	48 05 00 e0 04 00    	add    $0x4e000,%rax
   402fe:	be 00 00 00 00       	mov    $0x0,%esi
   40303:	48 89 c7             	mov    %rax,%rdi
   40306:	e8 a5 1a 00 00       	call   41db0 <process_init>
    assert(process_config_tables(pid) == 0);
   4030b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4030e:	89 c7                	mov    %eax,%edi
   40310:	e8 75 31 00 00       	call   4348a <process_config_tables>
   40315:	85 c0                	test   %eax,%eax
   40317:	74 14                	je     4032d <process_setup+0x57>
   40319:	ba 68 4c 04 00       	mov    $0x44c68,%edx
   4031e:	be 77 00 00 00       	mov    $0x77,%esi
   40323:	bf 88 4c 04 00       	mov    $0x44c88,%edi
   40328:	e8 51 22 00 00       	call   4257e <assert_fail>

    /* Calls program_load in k-loader */
    assert(process_load(&processes[pid], program_number) >= 0);
   4032d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40330:	48 63 d0             	movslq %eax,%rdx
   40333:	48 89 d0             	mov    %rdx,%rax
   40336:	48 c1 e0 04          	shl    $0x4,%rax
   4033a:	48 29 d0             	sub    %rdx,%rax
   4033d:	48 c1 e0 04          	shl    $0x4,%rax
   40341:	48 8d 90 00 e0 04 00 	lea    0x4e000(%rax),%rdx
   40348:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4034b:	89 c6                	mov    %eax,%esi
   4034d:	48 89 d7             	mov    %rdx,%rdi
   40350:	e8 83 34 00 00       	call   437d8 <process_load>
   40355:	85 c0                	test   %eax,%eax
   40357:	79 14                	jns    4036d <process_setup+0x97>
   40359:	ba 98 4c 04 00       	mov    $0x44c98,%edx
   4035e:	be 7a 00 00 00       	mov    $0x7a,%esi
   40363:	bf 88 4c 04 00       	mov    $0x44c88,%edi
   40368:	e8 11 22 00 00       	call   4257e <assert_fail>

    process_setup_stack(&processes[pid]);
   4036d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40370:	48 63 d0             	movslq %eax,%rdx
   40373:	48 89 d0             	mov    %rdx,%rax
   40376:	48 c1 e0 04          	shl    $0x4,%rax
   4037a:	48 29 d0             	sub    %rdx,%rax
   4037d:	48 c1 e0 04          	shl    $0x4,%rax
   40381:	48 05 00 e0 04 00    	add    $0x4e000,%rax
   40387:	48 89 c7             	mov    %rax,%rdi
   4038a:	e8 81 34 00 00       	call   43810 <process_setup_stack>

    processes[pid].p_state = P_RUNNABLE;
   4038f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40392:	48 63 d0             	movslq %eax,%rdx
   40395:	48 89 d0             	mov    %rdx,%rax
   40398:	48 c1 e0 04          	shl    $0x4,%rax
   4039c:	48 29 d0             	sub    %rdx,%rax
   4039f:	48 c1 e0 04          	shl    $0x4,%rax
   403a3:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
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
   403e5:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
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
   40402:	c6 84 00 21 ef 04 00 	movb   $0x1,0x4ef21(%rax,%rax,1)
   40409:	01 
        pageinfo[PAGENUMBER(addr)].owner = owner;
   4040a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4040e:	48 c1 e8 0c          	shr    $0xc,%rax
   40412:	48 98                	cltq   
   40414:	0f b6 55 f4          	movzbl -0xc(%rbp),%edx
   40418:	88 94 00 20 ef 04 00 	mov    %dl,0x4ef20(%rax,%rax,1)
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
   4042a:	48 8b 05 cf ea 00 00 	mov    0xeacf(%rip),%rax        # 4ef00 <current>
   40431:	48 89 c7             	mov    %rax,%rdi
   40434:	e8 8a 34 00 00       	call   438c3 <process_fork>
}
   40439:	5d                   	pop    %rbp
   4043a:	c3                   	ret    

000000000004043b <syscall_exit>:


void syscall_exit() {
   4043b:	55                   	push   %rbp
   4043c:	48 89 e5             	mov    %rsp,%rbp
    process_free(current->p_pid);
   4043f:	48 8b 05 ba ea 00 00 	mov    0xeaba(%rip),%rax        # 4ef00 <current>
   40446:	8b 00                	mov    (%rax),%eax
   40448:	89 c7                	mov    %eax,%edi
   4044a:	e8 59 2d 00 00       	call   431a8 <process_free>
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
   4045e:	48 8b 05 9b ea 00 00 	mov    0xea9b(%rip),%rax        # 4ef00 <current>
   40465:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40469:	48 89 d6             	mov    %rdx,%rsi
   4046c:	48 89 c7             	mov    %rax,%rdi
   4046f:	e8 e1 36 00 00       	call   43b55 <process_page_alloc>
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
   40510:	e8 2b 27 00 00       	call   42c40 <virtual_memory_lookup>
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
   40546:	e8 32 23 00 00       	call   4287d <virtual_memory_map>
				pageinfo[vamap.pn].refcount--;
   4054b:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4054e:	48 63 d0             	movslq %eax,%rdx
   40551:	0f b6 94 12 21 ef 04 	movzbl 0x4ef21(%rdx,%rdx,1),%edx
   40558:	00 
   40559:	83 ea 01             	sub    $0x1,%edx
   4055c:	48 98                	cltq   
   4055e:	88 94 00 21 ef 04 00 	mov    %dl,0x4ef21(%rax,%rax,1)
				if (pageinfo[vamap.pn].refcount == 0)
   40565:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40568:	48 98                	cltq   
   4056a:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   40571:	00 
   40572:	84 c0                	test   %al,%al
   40574:	75 0d                	jne    40583 <brk+0x10d>
					pageinfo[vamap.pn].owner = PO_FREE;
   40576:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40579:	48 98                	cltq   
   4057b:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
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
		p->p_registers.reg_rax = -1;
   405f6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   405fa:	48 c7 40 18 ff ff ff 	movq   $0xffffffffffffffff,0x18(%rax)
   40601:	ff 
		log_printf("oops got here\n");
   40602:	bf cb 4c 04 00       	mov    $0x44ccb,%edi
   40607:	b8 00 00 00 00       	mov    $0x0,%eax
   4060c:	e8 4f 1c 00 00       	call   42260 <log_printf>
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
   40668:	e8 d3 25 00 00       	call   42c40 <virtual_memory_lookup>

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
   406ba:	e8 81 25 00 00       	call   42c40 <virtual_memory_lookup>
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
   406e6:	e8 55 25 00 00       	call   42c40 <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   406eb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   406ef:	48 89 c1             	mov    %rax,%rcx
   406f2:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   406f6:	ba 18 00 00 00       	mov    $0x18,%edx
   406fb:	48 89 c6             	mov    %rax,%rsi
   406fe:	48 89 cf             	mov    %rcx,%rdi
   40701:	e8 bd 34 00 00       	call   43bc3 <memcpy>
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
   40789:	48 8b 05 70 e7 00 00 	mov    0xe770(%rip),%rax        # 4ef00 <current>
   40790:	48 8b 95 08 ff ff ff 	mov    -0xf8(%rbp),%rdx
   40797:	48 83 c0 18          	add    $0x18,%rax
   4079b:	48 89 d6             	mov    %rdx,%rsi
   4079e:	ba 18 00 00 00       	mov    $0x18,%edx
   407a3:	48 89 c7             	mov    %rax,%rdi
   407a6:	48 89 d1             	mov    %rdx,%rcx
   407a9:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   407ac:	48 8b 05 4d 08 01 00 	mov    0x1084d(%rip),%rax        # 51000 <kernel_pagetable>
   407b3:	48 89 c7             	mov    %rax,%rdi
   407b6:	e8 91 1f 00 00       	call   4274c <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   407bb:	8b 05 3b 88 07 00    	mov    0x7883b(%rip),%eax        # b8ffc <cursorpos>
   407c1:	89 c7                	mov    %eax,%edi
   407c3:	e8 b2 16 00 00       	call   41e7a <console_show_cursor>
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
   40806:	e8 38 08 00 00       	call   41043 <check_virtual_memory>
        if(disp_global){
   4080b:	0f b6 05 ee 57 00 00 	movzbl 0x57ee(%rip),%eax        # 46000 <disp_global>
   40812:	84 c0                	test   %al,%al
   40814:	74 0a                	je     40820 <exception+0xa9>
            memshow_physical();
   40816:	e8 a0 09 00 00       	call   411bb <memshow_physical>
            memshow_virtual_animate();
   4081b:	e8 ca 0c 00 00       	call   414ea <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   40820:	e8 38 1b 00 00       	call   4235d <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   40825:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   4082c:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40833:	48 83 e8 0e          	sub    $0xe,%rax
   40837:	48 83 f8 2c          	cmp    $0x2c,%rax
   4083b:	0f 87 2b 03 00 00    	ja     40b6c <exception+0x3f5>
   40841:	48 8b 04 c5 68 4d 04 	mov    0x44d68(,%rax,8),%rax
   40848:	00 
   40849:	ff e0                	jmp    *%rax
        case INT_SYS_PANIC:
            {
                // rdi stores pointer for msg string
                {
                    char msg[160];
                    uintptr_t addr = current->p_registers.reg_rdi;
   4084b:	48 8b 05 ae e6 00 00 	mov    0xe6ae(%rip),%rax        # 4ef00 <current>
   40852:	48 8b 40 48          	mov    0x48(%rax),%rax
   40856:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                    if((void *)addr == NULL)
   4085a:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   4085f:	75 0f                	jne    40870 <exception+0xf9>
                        kernel_panic(NULL);
   40861:	bf 00 00 00 00       	mov    $0x0,%edi
   40866:	b8 00 00 00 00       	mov    $0x0,%eax
   4086b:	e8 2e 1c 00 00       	call   4249e <kernel_panic>
                    vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   40870:	48 8b 05 89 e6 00 00 	mov    0xe689(%rip),%rax        # 4ef00 <current>
   40877:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   4087e:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   40882:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40886:	48 89 ce             	mov    %rcx,%rsi
   40889:	48 89 c7             	mov    %rax,%rdi
   4088c:	e8 af 23 00 00       	call   42c40 <virtual_memory_lookup>
                    memcpy(msg, (void *)map.pa, 160);
   40891:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40895:	48 89 c1             	mov    %rax,%rcx
   40898:	48 8d 85 10 ff ff ff 	lea    -0xf0(%rbp),%rax
   4089f:	ba a0 00 00 00       	mov    $0xa0,%edx
   408a4:	48 89 ce             	mov    %rcx,%rsi
   408a7:	48 89 c7             	mov    %rax,%rdi
   408aa:	e8 14 33 00 00       	call   43bc3 <memcpy>
                    kernel_panic(msg);
   408af:	48 8d 85 10 ff ff ff 	lea    -0xf0(%rbp),%rax
   408b6:	48 89 c7             	mov    %rax,%rdi
   408b9:	b8 00 00 00 00       	mov    $0x0,%eax
   408be:	e8 db 1b 00 00       	call   4249e <kernel_panic>
                kernel_panic(NULL);
                break;                  // will not be reached
            }
        case INT_SYS_GETPID:
            {
                current->p_registers.reg_rax = current->p_pid;
   408c3:	48 8b 05 36 e6 00 00 	mov    0xe636(%rip),%rax        # 4ef00 <current>
   408ca:	8b 10                	mov    (%rax),%edx
   408cc:	48 8b 05 2d e6 00 00 	mov    0xe62d(%rip),%rax        # 4ef00 <current>
   408d3:	48 63 d2             	movslq %edx,%rdx
   408d6:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   408da:	e9 9d 02 00 00       	jmp    40b7c <exception+0x405>
            }
        case INT_SYS_FORK:
            {
                current->p_registers.reg_rax = syscall_fork();
   408df:	b8 00 00 00 00       	mov    $0x0,%eax
   408e4:	e8 3d fb ff ff       	call   40426 <syscall_fork>
   408e9:	89 c2                	mov    %eax,%edx
   408eb:	48 8b 05 0e e6 00 00 	mov    0xe60e(%rip),%rax        # 4ef00 <current>
   408f2:	48 63 d2             	movslq %edx,%rdx
   408f5:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   408f9:	e9 7e 02 00 00       	jmp    40b7c <exception+0x405>
            }
        case INT_SYS_MAPPING:
            {
                syscall_mapping(current);
   408fe:	48 8b 05 fb e5 00 00 	mov    0xe5fb(%rip),%rax        # 4ef00 <current>
   40905:	48 89 c7             	mov    %rax,%rdi
   40908:	e8 1e fd ff ff       	call   4062b <syscall_mapping>
                break;
   4090d:	e9 6a 02 00 00       	jmp    40b7c <exception+0x405>
            }

        case INT_SYS_EXIT:
            {
                syscall_exit();
   40912:	b8 00 00 00 00       	mov    $0x0,%eax
   40917:	e8 1f fb ff ff       	call   4043b <syscall_exit>
                schedule();
   4091c:	e8 84 02 00 00       	call   40ba5 <schedule>
                break;
   40921:	e9 56 02 00 00       	jmp    40b7c <exception+0x405>
            }

        case INT_SYS_YIELD:
            {
                schedule();
   40926:	e8 7a 02 00 00       	call   40ba5 <schedule>
                break;                  /* will not be reached */
   4092b:	e9 4c 02 00 00       	jmp    40b7c <exception+0x405>
            }

        case INT_SYS_BRK:
            {
                // TODO : Your code here
		reg->reg_rax = brk(current, reg->reg_rdi);
   40930:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40937:	48 8b 50 30          	mov    0x30(%rax),%rdx
   4093b:	48 8b 05 be e5 00 00 	mov    0xe5be(%rip),%rax        # 4ef00 <current>
   40942:	48 89 d6             	mov    %rdx,%rsi
   40945:	48 89 c7             	mov    %rax,%rdi
   40948:	e8 29 fb ff ff       	call   40476 <brk>
   4094d:	48 63 d0             	movslq %eax,%rdx
   40950:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40957:	48 89 10             	mov    %rdx,(%rax)
		break;
   4095a:	e9 1d 02 00 00       	jmp    40b7c <exception+0x405>
            }

        case INT_SYS_SBRK:
            {
                // TODO : Your code here
		reg->reg_rax = sbrk(current, reg->reg_rdi);
   4095f:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40966:	48 8b 40 30          	mov    0x30(%rax),%rax
   4096a:	48 89 c2             	mov    %rax,%rdx
   4096d:	48 8b 05 8c e5 00 00 	mov    0xe58c(%rip),%rax        # 4ef00 <current>
   40974:	48 89 d6             	mov    %rdx,%rsi
   40977:	48 89 c7             	mov    %rax,%rdi
   4097a:	e8 39 fc ff ff       	call   405b8 <sbrk>
   4097f:	48 63 d0             	movslq %eax,%rdx
   40982:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40989:	48 89 10             	mov    %rdx,(%rax)
                break;
   4098c:	e9 eb 01 00 00       	jmp    40b7c <exception+0x405>
            }
	case INT_SYS_PAGE_ALLOC:
	    {
		intptr_t addr = reg->reg_rdi;
   40991:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40998:	48 8b 40 30          	mov    0x30(%rax),%rax
   4099c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
		syscall_page_alloc(addr);
   409a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   409a4:	48 89 c7             	mov    %rax,%rdi
   409a7:	e8 a6 fa ff ff       	call   40452 <syscall_page_alloc>
		break;
   409ac:	e9 cb 01 00 00       	jmp    40b7c <exception+0x405>
	    }
        case INT_SYS_MEM_TOG:
            {
                syscall_mem_tog(current);
   409b1:	48 8b 05 48 e5 00 00 	mov    0xe548(%rip),%rax        # 4ef00 <current>
   409b8:	48 89 c7             	mov    %rax,%rdi
   409bb:	e8 4e fd ff ff       	call   4070e <syscall_mem_tog>
                break;
   409c0:	e9 b7 01 00 00       	jmp    40b7c <exception+0x405>
            }

        case INT_TIMER:
            {
                ++ticks;
   409c5:	8b 05 55 e9 00 00    	mov    0xe955(%rip),%eax        # 4f320 <ticks>
   409cb:	83 c0 01             	add    $0x1,%eax
   409ce:	89 05 4c e9 00 00    	mov    %eax,0xe94c(%rip)        # 4f320 <ticks>
                schedule();
   409d4:	e8 cc 01 00 00       	call   40ba5 <schedule>
                break;                  /* will not be reached */
   409d9:	e9 9e 01 00 00       	jmp    40b7c <exception+0x405>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   409de:	0f 20 d0             	mov    %cr2,%rax
   409e1:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    return val;
   409e5:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
            }

        case INT_PAGEFAULT: 
            {
                // Analyze faulting address and access type.
                uintptr_t addr = rcr2();
   409e9:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
		    // log_printf("\theap bottom: 0x%x\n", current->original_break);
		    // log_printf("\theap top: 0x%x\n", current->program_break);
		// unsure if second check is redundant?
		if (//reg->reg_err != PFERR_PRESENT 
		    //&& 
		    addr >= current->original_break && addr < current->program_break) {
   409ed:	48 8b 05 0c e5 00 00 	mov    0xe50c(%rip),%rax        # 4ef00 <current>
   409f4:	48 8b 40 10          	mov    0x10(%rax),%rax
		if (//reg->reg_err != PFERR_PRESENT 
   409f8:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   409fc:	72 76                	jb     40a74 <exception+0x2fd>
		    addr >= current->original_break && addr < current->program_break) {
   409fe:	48 8b 05 fb e4 00 00 	mov    0xe4fb(%rip),%rax        # 4ef00 <current>
   40a05:	48 8b 40 08          	mov    0x8(%rax),%rax
   40a09:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40a0d:	73 65                	jae    40a74 <exception+0x2fd>
			uintptr_t pa = (uintptr_t) palloc(current->p_pid);
   40a0f:	48 8b 05 ea e4 00 00 	mov    0xe4ea(%rip),%rax        # 4ef00 <current>
   40a16:	8b 00                	mov    (%rax),%eax
   40a18:	89 c7                	mov    %eax,%edi
   40a1a:	e8 70 26 00 00       	call   4308f <palloc>
   40a1f:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
			if (pa) {
   40a23:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   40a28:	74 3b                	je     40a65 <exception+0x2ee>
				virtual_memory_map(current->p_pagetable, PAGEADDRESS(PAGENUMBER(addr)), pa, PAGESIZE, PTE_P | PTE_U | PTE_W);
   40a2a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40a2e:	48 c1 e8 0c          	shr    $0xc,%rax
   40a32:	48 98                	cltq   
   40a34:	48 c1 e0 0c          	shl    $0xc,%rax
   40a38:	48 89 c6             	mov    %rax,%rsi
   40a3b:	48 8b 05 be e4 00 00 	mov    0xe4be(%rip),%rax        # 4ef00 <current>
   40a42:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40a49:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   40a4d:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40a53:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40a58:	48 89 c7             	mov    %rax,%rdi
   40a5b:	e8 1d 1e 00 00       	call   4287d <virtual_memory_map>
		    addr >= current->original_break && addr < current->program_break) {
   40a60:	e9 05 01 00 00       	jmp    40b6a <exception+0x3f3>
			} 
			else {
				syscall_exit();
   40a65:	b8 00 00 00 00       	mov    $0x0,%eax
   40a6a:	e8 cc f9 ff ff       	call   4043b <syscall_exit>
		    addr >= current->original_break && addr < current->program_break) {
   40a6f:	e9 f6 00 00 00       	jmp    40b6a <exception+0x3f3>
			}
		} else {
			const char* operation = reg->reg_err & PFERR_WRITE
   40a74:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40a7b:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40a82:	83 e0 02             	and    $0x2,%eax
			    ? "write" : "read";
   40a85:	48 85 c0             	test   %rax,%rax
   40a88:	74 07                	je     40a91 <exception+0x31a>
   40a8a:	b8 da 4c 04 00       	mov    $0x44cda,%eax
   40a8f:	eb 05                	jmp    40a96 <exception+0x31f>
   40a91:	b8 e0 4c 04 00       	mov    $0x44ce0,%eax
			const char* operation = reg->reg_err & PFERR_WRITE
   40a96:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
			const char* problem = reg->reg_err & PFERR_PRESENT
   40a9a:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40aa1:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40aa8:	83 e0 01             	and    $0x1,%eax
			    ? "protection problem" : "missing page";
   40aab:	48 85 c0             	test   %rax,%rax
   40aae:	74 07                	je     40ab7 <exception+0x340>
   40ab0:	b8 e5 4c 04 00       	mov    $0x44ce5,%eax
   40ab5:	eb 05                	jmp    40abc <exception+0x345>
   40ab7:	b8 f8 4c 04 00       	mov    $0x44cf8,%eax
			const char* problem = reg->reg_err & PFERR_PRESENT
   40abc:	48 89 45 d0          	mov    %rax,-0x30(%rbp)

			if (!(reg->reg_err & PFERR_USER)) {
   40ac0:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40ac7:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40ace:	83 e0 04             	and    $0x4,%eax
   40ad1:	48 85 c0             	test   %rax,%rax
   40ad4:	75 2f                	jne    40b05 <exception+0x38e>
			    kernel_panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   40ad6:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40add:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   40ae4:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
   40ae8:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   40aec:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40af0:	49 89 f0             	mov    %rsi,%r8
   40af3:	48 89 c6             	mov    %rax,%rsi
   40af6:	bf 08 4d 04 00       	mov    $0x44d08,%edi
   40afb:	b8 00 00 00 00       	mov    $0x0,%eax
   40b00:	e8 99 19 00 00       	call   4249e <kernel_panic>
				    addr, operation, problem, reg->reg_rip);
			}
			console_printf(CPOS(24, 0), 0x0C00,
   40b05:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40b0c:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
				"Process %d page fault for %p (%s %s, rip=%p)!\n",
				current->p_pid, addr, operation, problem, reg->reg_rip);
   40b13:	48 8b 05 e6 e3 00 00 	mov    0xe3e6(%rip),%rax        # 4ef00 <current>
			console_printf(CPOS(24, 0), 0x0C00,
   40b1a:	8b 00                	mov    (%rax),%eax
   40b1c:	48 8b 75 d8          	mov    -0x28(%rbp),%rsi
   40b20:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   40b24:	52                   	push   %rdx
   40b25:	ff 75 d0             	push   -0x30(%rbp)
   40b28:	49 89 f1             	mov    %rsi,%r9
   40b2b:	49 89 c8             	mov    %rcx,%r8
   40b2e:	89 c1                	mov    %eax,%ecx
   40b30:	ba 38 4d 04 00       	mov    $0x44d38,%edx
   40b35:	be 00 0c 00 00       	mov    $0xc00,%esi
   40b3a:	bf 80 07 00 00       	mov    $0x780,%edi
   40b3f:	b8 00 00 00 00       	mov    $0x0,%eax
   40b44:	e8 2f 3f 00 00       	call   44a78 <console_printf>
   40b49:	48 83 c4 10          	add    $0x10,%rsp
			current->p_state = P_BROKEN;
   40b4d:	48 8b 05 ac e3 00 00 	mov    0xe3ac(%rip),%rax        # 4ef00 <current>
   40b54:	c7 80 d8 00 00 00 03 	movl   $0x3,0xd8(%rax)
   40b5b:	00 00 00 
			syscall_exit();
   40b5e:	b8 00 00 00 00       	mov    $0x0,%eax
   40b63:	e8 d3 f8 ff ff       	call   4043b <syscall_exit>
		}
                break;
   40b68:	eb 12                	jmp    40b7c <exception+0x405>
   40b6a:	eb 10                	jmp    40b7c <exception+0x405>
            }

        default:
            default_exception(current);
   40b6c:	48 8b 05 8d e3 00 00 	mov    0xe38d(%rip),%rax        # 4ef00 <current>
   40b73:	48 89 c7             	mov    %rax,%rdi
   40b76:	e8 33 1a 00 00       	call   425ae <default_exception>
            break;                  /* will not be reached */
   40b7b:	90                   	nop

    }

    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   40b7c:	48 8b 05 7d e3 00 00 	mov    0xe37d(%rip),%rax        # 4ef00 <current>
   40b83:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   40b89:	83 f8 01             	cmp    $0x1,%eax
   40b8c:	75 0f                	jne    40b9d <exception+0x426>
        run(current);
   40b8e:	48 8b 05 6b e3 00 00 	mov    0xe36b(%rip),%rax        # 4ef00 <current>
   40b95:	48 89 c7             	mov    %rax,%rdi
   40b98:	e8 7e 00 00 00       	call   40c1b <run>
    } else {
        schedule();
   40b9d:	e8 03 00 00 00       	call   40ba5 <schedule>
    }
}
   40ba2:	90                   	nop
   40ba3:	c9                   	leave  
   40ba4:	c3                   	ret    

0000000000040ba5 <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   40ba5:	55                   	push   %rbp
   40ba6:	48 89 e5             	mov    %rsp,%rbp
   40ba9:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   40bad:	48 8b 05 4c e3 00 00 	mov    0xe34c(%rip),%rax        # 4ef00 <current>
   40bb4:	8b 00                	mov    (%rax),%eax
   40bb6:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   40bb9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40bbc:	8d 50 01             	lea    0x1(%rax),%edx
   40bbf:	89 d0                	mov    %edx,%eax
   40bc1:	c1 f8 1f             	sar    $0x1f,%eax
   40bc4:	c1 e8 1c             	shr    $0x1c,%eax
   40bc7:	01 c2                	add    %eax,%edx
   40bc9:	83 e2 0f             	and    $0xf,%edx
   40bcc:	29 c2                	sub    %eax,%edx
   40bce:	89 55 fc             	mov    %edx,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   40bd1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40bd4:	48 63 d0             	movslq %eax,%rdx
   40bd7:	48 89 d0             	mov    %rdx,%rax
   40bda:	48 c1 e0 04          	shl    $0x4,%rax
   40bde:	48 29 d0             	sub    %rdx,%rax
   40be1:	48 c1 e0 04          	shl    $0x4,%rax
   40be5:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   40beb:	8b 00                	mov    (%rax),%eax
   40bed:	83 f8 01             	cmp    $0x1,%eax
   40bf0:	75 22                	jne    40c14 <schedule+0x6f>
            run(&processes[pid]);
   40bf2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40bf5:	48 63 d0             	movslq %eax,%rdx
   40bf8:	48 89 d0             	mov    %rdx,%rax
   40bfb:	48 c1 e0 04          	shl    $0x4,%rax
   40bff:	48 29 d0             	sub    %rdx,%rax
   40c02:	48 c1 e0 04          	shl    $0x4,%rax
   40c06:	48 05 00 e0 04 00    	add    $0x4e000,%rax
   40c0c:	48 89 c7             	mov    %rax,%rdi
   40c0f:	e8 07 00 00 00       	call   40c1b <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   40c14:	e8 44 17 00 00       	call   4235d <check_keyboard>
        pid = (pid + 1) % NPROC;
   40c19:	eb 9e                	jmp    40bb9 <schedule+0x14>

0000000000040c1b <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   40c1b:	55                   	push   %rbp
   40c1c:	48 89 e5             	mov    %rsp,%rbp
   40c1f:	48 83 ec 10          	sub    $0x10,%rsp
   40c23:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   40c27:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c2b:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   40c31:	83 f8 01             	cmp    $0x1,%eax
   40c34:	74 14                	je     40c4a <run+0x2f>
   40c36:	ba d0 4e 04 00       	mov    $0x44ed0,%edx
   40c3b:	be b4 01 00 00       	mov    $0x1b4,%esi
   40c40:	bf 88 4c 04 00       	mov    $0x44c88,%edi
   40c45:	e8 34 19 00 00       	call   4257e <assert_fail>
    current = p;
   40c4a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c4e:	48 89 05 ab e2 00 00 	mov    %rax,0xe2ab(%rip)        # 4ef00 <current>

    // display running process in CONSOLE last value
    console_printf(CPOS(24, 79),
   40c55:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c59:	8b 10                	mov    (%rax),%edx
            memstate_colors[p->p_pid - PO_KERNEL], "%d", p->p_pid);
   40c5b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c5f:	8b 00                	mov    (%rax),%eax
   40c61:	83 c0 02             	add    $0x2,%eax
   40c64:	48 98                	cltq   
   40c66:	0f b7 84 00 20 4c 04 	movzwl 0x44c20(%rax,%rax,1),%eax
   40c6d:	00 
    console_printf(CPOS(24, 79),
   40c6e:	0f b7 c0             	movzwl %ax,%eax
   40c71:	89 d1                	mov    %edx,%ecx
   40c73:	ba e9 4e 04 00       	mov    $0x44ee9,%edx
   40c78:	89 c6                	mov    %eax,%esi
   40c7a:	bf cf 07 00 00       	mov    $0x7cf,%edi
   40c7f:	b8 00 00 00 00       	mov    $0x0,%eax
   40c84:	e8 ef 3d 00 00       	call   44a78 <console_printf>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   40c89:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c8d:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40c94:	48 89 c7             	mov    %rax,%rdi
   40c97:	e8 b0 1a 00 00       	call   4274c <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   40c9c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40ca0:	48 83 c0 18          	add    $0x18,%rax
   40ca4:	48 89 c7             	mov    %rax,%rdi
   40ca7:	e8 17 f4 ff ff       	call   400c3 <exception_return>

0000000000040cac <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   40cac:	55                   	push   %rbp
   40cad:	48 89 e5             	mov    %rsp,%rbp
   40cb0:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40cb4:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40cbb:	00 
   40cbc:	e9 81 00 00 00       	jmp    40d42 <pageinfo_init+0x96>
        int owner;
        if (physical_memory_isreserved(addr)) {
   40cc1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40cc5:	48 89 c7             	mov    %rax,%rdi
   40cc8:	e8 1e 0f 00 00       	call   41beb <physical_memory_isreserved>
   40ccd:	85 c0                	test   %eax,%eax
   40ccf:	74 09                	je     40cda <pageinfo_init+0x2e>
            owner = PO_RESERVED;
   40cd1:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   40cd8:	eb 2f                	jmp    40d09 <pageinfo_init+0x5d>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   40cda:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   40ce1:	00 
   40ce2:	76 0b                	jbe    40cef <pageinfo_init+0x43>
   40ce4:	b8 10 70 05 00       	mov    $0x57010,%eax
   40ce9:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40ced:	72 0a                	jb     40cf9 <pageinfo_init+0x4d>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   40cef:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   40cf6:	00 
   40cf7:	75 09                	jne    40d02 <pageinfo_init+0x56>
            owner = PO_KERNEL;
   40cf9:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   40d00:	eb 07                	jmp    40d09 <pageinfo_init+0x5d>
        } else {
            owner = PO_FREE;
   40d02:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40d09:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d0d:	48 c1 e8 0c          	shr    $0xc,%rax
   40d11:	89 c1                	mov    %eax,%ecx
   40d13:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40d16:	89 c2                	mov    %eax,%edx
   40d18:	48 63 c1             	movslq %ecx,%rax
   40d1b:	88 94 00 20 ef 04 00 	mov    %dl,0x4ef20(%rax,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   40d22:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40d26:	0f 95 c2             	setne  %dl
   40d29:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d2d:	48 c1 e8 0c          	shr    $0xc,%rax
   40d31:	48 98                	cltq   
   40d33:	88 94 00 21 ef 04 00 	mov    %dl,0x4ef21(%rax,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40d3a:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40d41:	00 
   40d42:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40d49:	00 
   40d4a:	0f 86 71 ff ff ff    	jbe    40cc1 <pageinfo_init+0x15>
    }
}
   40d50:	90                   	nop
   40d51:	90                   	nop
   40d52:	c9                   	leave  
   40d53:	c3                   	ret    

0000000000040d54 <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   40d54:	55                   	push   %rbp
   40d55:	48 89 e5             	mov    %rsp,%rbp
   40d58:	48 83 ec 50          	sub    $0x50,%rsp
   40d5c:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   40d60:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40d64:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40d6a:	48 89 c2             	mov    %rax,%rdx
   40d6d:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40d71:	48 39 c2             	cmp    %rax,%rdx
   40d74:	74 14                	je     40d8a <check_page_table_mappings+0x36>
   40d76:	ba f0 4e 04 00       	mov    $0x44ef0,%edx
   40d7b:	be e2 01 00 00       	mov    $0x1e2,%esi
   40d80:	bf 88 4c 04 00       	mov    $0x44c88,%edi
   40d85:	e8 f4 17 00 00       	call   4257e <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40d8a:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   40d91:	00 
   40d92:	e9 9a 00 00 00       	jmp    40e31 <check_page_table_mappings+0xdd>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   40d97:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   40d9b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40d9f:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40da3:	48 89 ce             	mov    %rcx,%rsi
   40da6:	48 89 c7             	mov    %rax,%rdi
   40da9:	e8 92 1e 00 00       	call   42c40 <virtual_memory_lookup>
        if (vam.pa != va) {
   40dae:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40db2:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40db6:	74 27                	je     40ddf <check_page_table_mappings+0x8b>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   40db8:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40dbc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40dc0:	49 89 d0             	mov    %rdx,%r8
   40dc3:	48 89 c1             	mov    %rax,%rcx
   40dc6:	ba 0f 4f 04 00       	mov    $0x44f0f,%edx
   40dcb:	be 00 c0 00 00       	mov    $0xc000,%esi
   40dd0:	bf e0 06 00 00       	mov    $0x6e0,%edi
   40dd5:	b8 00 00 00 00       	mov    $0x0,%eax
   40dda:	e8 99 3c 00 00       	call   44a78 <console_printf>
        }
        assert(vam.pa == va);
   40ddf:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40de3:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40de7:	74 14                	je     40dfd <check_page_table_mappings+0xa9>
   40de9:	ba 19 4f 04 00       	mov    $0x44f19,%edx
   40dee:	be eb 01 00 00       	mov    $0x1eb,%esi
   40df3:	bf 88 4c 04 00       	mov    $0x44c88,%edi
   40df8:	e8 81 17 00 00       	call   4257e <assert_fail>
        if (va >= (uintptr_t) start_data) {
   40dfd:	b8 00 60 04 00       	mov    $0x46000,%eax
   40e02:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40e06:	72 21                	jb     40e29 <check_page_table_mappings+0xd5>
            assert(vam.perm & PTE_W);
   40e08:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40e0b:	48 98                	cltq   
   40e0d:	83 e0 02             	and    $0x2,%eax
   40e10:	48 85 c0             	test   %rax,%rax
   40e13:	75 14                	jne    40e29 <check_page_table_mappings+0xd5>
   40e15:	ba 26 4f 04 00       	mov    $0x44f26,%edx
   40e1a:	be ed 01 00 00       	mov    $0x1ed,%esi
   40e1f:	bf 88 4c 04 00       	mov    $0x44c88,%edi
   40e24:	e8 55 17 00 00       	call   4257e <assert_fail>
         va += PAGESIZE) {
   40e29:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40e30:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40e31:	b8 10 70 05 00       	mov    $0x57010,%eax
   40e36:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40e3a:	0f 82 57 ff ff ff    	jb     40d97 <check_page_table_mappings+0x43>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   40e40:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   40e47:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   40e48:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   40e4c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40e50:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40e54:	48 89 ce             	mov    %rcx,%rsi
   40e57:	48 89 c7             	mov    %rax,%rdi
   40e5a:	e8 e1 1d 00 00       	call   42c40 <virtual_memory_lookup>
    assert(vam.pa == kstack);
   40e5f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40e63:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   40e67:	74 14                	je     40e7d <check_page_table_mappings+0x129>
   40e69:	ba 37 4f 04 00       	mov    $0x44f37,%edx
   40e6e:	be f4 01 00 00       	mov    $0x1f4,%esi
   40e73:	bf 88 4c 04 00       	mov    $0x44c88,%edi
   40e78:	e8 01 17 00 00       	call   4257e <assert_fail>
    assert(vam.perm & PTE_W);
   40e7d:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40e80:	48 98                	cltq   
   40e82:	83 e0 02             	and    $0x2,%eax
   40e85:	48 85 c0             	test   %rax,%rax
   40e88:	75 14                	jne    40e9e <check_page_table_mappings+0x14a>
   40e8a:	ba 26 4f 04 00       	mov    $0x44f26,%edx
   40e8f:	be f5 01 00 00       	mov    $0x1f5,%esi
   40e94:	bf 88 4c 04 00       	mov    $0x44c88,%edi
   40e99:	e8 e0 16 00 00       	call   4257e <assert_fail>
}
   40e9e:	90                   	nop
   40e9f:	c9                   	leave  
   40ea0:	c3                   	ret    

0000000000040ea1 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   40ea1:	55                   	push   %rbp
   40ea2:	48 89 e5             	mov    %rsp,%rbp
   40ea5:	48 83 ec 20          	sub    $0x20,%rsp
   40ea9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40ead:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   40eb0:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40eb3:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   40eb6:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   40ebd:	48 8b 05 3c 01 01 00 	mov    0x1013c(%rip),%rax        # 51000 <kernel_pagetable>
   40ec4:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40ec8:	75 67                	jne    40f31 <check_page_table_ownership+0x90>
        owner = PO_KERNEL;
   40eca:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40ed1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   40ed8:	eb 51                	jmp    40f2b <check_page_table_ownership+0x8a>
            if (processes[xpid].p_state != P_FREE
   40eda:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40edd:	48 63 d0             	movslq %eax,%rdx
   40ee0:	48 89 d0             	mov    %rdx,%rax
   40ee3:	48 c1 e0 04          	shl    $0x4,%rax
   40ee7:	48 29 d0             	sub    %rdx,%rax
   40eea:	48 c1 e0 04          	shl    $0x4,%rax
   40eee:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   40ef4:	8b 00                	mov    (%rax),%eax
   40ef6:	85 c0                	test   %eax,%eax
   40ef8:	74 2d                	je     40f27 <check_page_table_ownership+0x86>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   40efa:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40efd:	48 63 d0             	movslq %eax,%rdx
   40f00:	48 89 d0             	mov    %rdx,%rax
   40f03:	48 c1 e0 04          	shl    $0x4,%rax
   40f07:	48 29 d0             	sub    %rdx,%rax
   40f0a:	48 c1 e0 04          	shl    $0x4,%rax
   40f0e:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   40f14:	48 8b 10             	mov    (%rax),%rdx
   40f17:	48 8b 05 e2 00 01 00 	mov    0x100e2(%rip),%rax        # 51000 <kernel_pagetable>
   40f1e:	48 39 c2             	cmp    %rax,%rdx
   40f21:	75 04                	jne    40f27 <check_page_table_ownership+0x86>
                ++expected_refcount;
   40f23:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40f27:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   40f2b:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   40f2f:	7e a9                	jle    40eda <check_page_table_ownership+0x39>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   40f31:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   40f34:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40f37:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40f3b:	be 00 00 00 00       	mov    $0x0,%esi
   40f40:	48 89 c7             	mov    %rax,%rdi
   40f43:	e8 03 00 00 00       	call   40f4b <check_page_table_ownership_level>
}
   40f48:	90                   	nop
   40f49:	c9                   	leave  
   40f4a:	c3                   	ret    

0000000000040f4b <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   40f4b:	55                   	push   %rbp
   40f4c:	48 89 e5             	mov    %rsp,%rbp
   40f4f:	48 83 ec 30          	sub    $0x30,%rsp
   40f53:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40f57:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   40f5a:	89 55 e0             	mov    %edx,-0x20(%rbp)
   40f5d:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   40f60:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40f64:	48 c1 e8 0c          	shr    $0xc,%rax
   40f68:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   40f6d:	7e 14                	jle    40f83 <check_page_table_ownership_level+0x38>
   40f6f:	ba 48 4f 04 00       	mov    $0x44f48,%edx
   40f74:	be 12 02 00 00       	mov    $0x212,%esi
   40f79:	bf 88 4c 04 00       	mov    $0x44c88,%edi
   40f7e:	e8 fb 15 00 00       	call   4257e <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   40f83:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40f87:	48 c1 e8 0c          	shr    $0xc,%rax
   40f8b:	48 98                	cltq   
   40f8d:	0f b6 84 00 20 ef 04 	movzbl 0x4ef20(%rax,%rax,1),%eax
   40f94:	00 
   40f95:	0f be c0             	movsbl %al,%eax
   40f98:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   40f9b:	74 14                	je     40fb1 <check_page_table_ownership_level+0x66>
   40f9d:	ba 60 4f 04 00       	mov    $0x44f60,%edx
   40fa2:	be 13 02 00 00       	mov    $0x213,%esi
   40fa7:	bf 88 4c 04 00       	mov    $0x44c88,%edi
   40fac:	e8 cd 15 00 00       	call   4257e <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   40fb1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40fb5:	48 c1 e8 0c          	shr    $0xc,%rax
   40fb9:	48 98                	cltq   
   40fbb:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   40fc2:	00 
   40fc3:	0f be c0             	movsbl %al,%eax
   40fc6:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   40fc9:	74 14                	je     40fdf <check_page_table_ownership_level+0x94>
   40fcb:	ba 88 4f 04 00       	mov    $0x44f88,%edx
   40fd0:	be 14 02 00 00       	mov    $0x214,%esi
   40fd5:	bf 88 4c 04 00       	mov    $0x44c88,%edi
   40fda:	e8 9f 15 00 00       	call   4257e <assert_fail>
    if (level < 3) {
   40fdf:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   40fe3:	7f 5b                	jg     41040 <check_page_table_ownership_level+0xf5>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   40fe5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   40fec:	eb 49                	jmp    41037 <check_page_table_ownership_level+0xec>
            if (pt->entry[index]) {
   40fee:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40ff2:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40ff5:	48 63 d2             	movslq %edx,%rdx
   40ff8:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   40ffc:	48 85 c0             	test   %rax,%rax
   40fff:	74 32                	je     41033 <check_page_table_ownership_level+0xe8>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   41001:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41005:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41008:	48 63 d2             	movslq %edx,%rdx
   4100b:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   4100f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   41015:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   41019:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4101c:	8d 70 01             	lea    0x1(%rax),%esi
   4101f:	8b 55 e0             	mov    -0x20(%rbp),%edx
   41022:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   41026:	b9 01 00 00 00       	mov    $0x1,%ecx
   4102b:	48 89 c7             	mov    %rax,%rdi
   4102e:	e8 18 ff ff ff       	call   40f4b <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   41033:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41037:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   4103e:	7e ae                	jle    40fee <check_page_table_ownership_level+0xa3>
            }
        }
    }
}
   41040:	90                   	nop
   41041:	c9                   	leave  
   41042:	c3                   	ret    

0000000000041043 <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   41043:	55                   	push   %rbp
   41044:	48 89 e5             	mov    %rsp,%rbp
   41047:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   4104b:	8b 05 87 d0 00 00    	mov    0xd087(%rip),%eax        # 4e0d8 <processes+0xd8>
   41051:	85 c0                	test   %eax,%eax
   41053:	74 14                	je     41069 <check_virtual_memory+0x26>
   41055:	ba b8 4f 04 00       	mov    $0x44fb8,%edx
   4105a:	be 27 02 00 00       	mov    $0x227,%esi
   4105f:	bf 88 4c 04 00       	mov    $0x44c88,%edi
   41064:	e8 15 15 00 00       	call   4257e <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   41069:	48 8b 05 90 ff 00 00 	mov    0xff90(%rip),%rax        # 51000 <kernel_pagetable>
   41070:	48 89 c7             	mov    %rax,%rdi
   41073:	e8 dc fc ff ff       	call   40d54 <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   41078:	48 8b 05 81 ff 00 00 	mov    0xff81(%rip),%rax        # 51000 <kernel_pagetable>
   4107f:	be ff ff ff ff       	mov    $0xffffffff,%esi
   41084:	48 89 c7             	mov    %rax,%rdi
   41087:	e8 15 fe ff ff       	call   40ea1 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   4108c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41093:	e9 9c 00 00 00       	jmp    41134 <check_virtual_memory+0xf1>
        if (processes[pid].p_state != P_FREE
   41098:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4109b:	48 63 d0             	movslq %eax,%rdx
   4109e:	48 89 d0             	mov    %rdx,%rax
   410a1:	48 c1 e0 04          	shl    $0x4,%rax
   410a5:	48 29 d0             	sub    %rdx,%rax
   410a8:	48 c1 e0 04          	shl    $0x4,%rax
   410ac:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   410b2:	8b 00                	mov    (%rax),%eax
   410b4:	85 c0                	test   %eax,%eax
   410b6:	74 78                	je     41130 <check_virtual_memory+0xed>
            && processes[pid].p_pagetable != kernel_pagetable) {
   410b8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   410bb:	48 63 d0             	movslq %eax,%rdx
   410be:	48 89 d0             	mov    %rdx,%rax
   410c1:	48 c1 e0 04          	shl    $0x4,%rax
   410c5:	48 29 d0             	sub    %rdx,%rax
   410c8:	48 c1 e0 04          	shl    $0x4,%rax
   410cc:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   410d2:	48 8b 10             	mov    (%rax),%rdx
   410d5:	48 8b 05 24 ff 00 00 	mov    0xff24(%rip),%rax        # 51000 <kernel_pagetable>
   410dc:	48 39 c2             	cmp    %rax,%rdx
   410df:	74 4f                	je     41130 <check_virtual_memory+0xed>
            check_page_table_mappings(processes[pid].p_pagetable);
   410e1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   410e4:	48 63 d0             	movslq %eax,%rdx
   410e7:	48 89 d0             	mov    %rdx,%rax
   410ea:	48 c1 e0 04          	shl    $0x4,%rax
   410ee:	48 29 d0             	sub    %rdx,%rax
   410f1:	48 c1 e0 04          	shl    $0x4,%rax
   410f5:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   410fb:	48 8b 00             	mov    (%rax),%rax
   410fe:	48 89 c7             	mov    %rax,%rdi
   41101:	e8 4e fc ff ff       	call   40d54 <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   41106:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41109:	48 63 d0             	movslq %eax,%rdx
   4110c:	48 89 d0             	mov    %rdx,%rax
   4110f:	48 c1 e0 04          	shl    $0x4,%rax
   41113:	48 29 d0             	sub    %rdx,%rax
   41116:	48 c1 e0 04          	shl    $0x4,%rax
   4111a:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   41120:	48 8b 00             	mov    (%rax),%rax
   41123:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41126:	89 d6                	mov    %edx,%esi
   41128:	48 89 c7             	mov    %rax,%rdi
   4112b:	e8 71 fd ff ff       	call   40ea1 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   41130:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41134:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   41138:	0f 8e 5a ff ff ff    	jle    41098 <check_virtual_memory+0x55>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4113e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41145:	eb 67                	jmp    411ae <check_virtual_memory+0x16b>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   41147:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4114a:	48 98                	cltq   
   4114c:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   41153:	00 
   41154:	84 c0                	test   %al,%al
   41156:	7e 52                	jle    411aa <check_virtual_memory+0x167>
   41158:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4115b:	48 98                	cltq   
   4115d:	0f b6 84 00 20 ef 04 	movzbl 0x4ef20(%rax,%rax,1),%eax
   41164:	00 
   41165:	84 c0                	test   %al,%al
   41167:	78 41                	js     411aa <check_virtual_memory+0x167>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   41169:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4116c:	48 98                	cltq   
   4116e:	0f b6 84 00 20 ef 04 	movzbl 0x4ef20(%rax,%rax,1),%eax
   41175:	00 
   41176:	0f be c0             	movsbl %al,%eax
   41179:	48 63 d0             	movslq %eax,%rdx
   4117c:	48 89 d0             	mov    %rdx,%rax
   4117f:	48 c1 e0 04          	shl    $0x4,%rax
   41183:	48 29 d0             	sub    %rdx,%rax
   41186:	48 c1 e0 04          	shl    $0x4,%rax
   4118a:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   41190:	8b 00                	mov    (%rax),%eax
   41192:	85 c0                	test   %eax,%eax
   41194:	75 14                	jne    411aa <check_virtual_memory+0x167>
   41196:	ba d8 4f 04 00       	mov    $0x44fd8,%edx
   4119b:	be 3e 02 00 00       	mov    $0x23e,%esi
   411a0:	bf 88 4c 04 00       	mov    $0x44c88,%edi
   411a5:	e8 d4 13 00 00       	call   4257e <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   411aa:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   411ae:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   411b5:	7e 90                	jle    41147 <check_virtual_memory+0x104>
        }
    }
}
   411b7:	90                   	nop
   411b8:	90                   	nop
   411b9:	c9                   	leave  
   411ba:	c3                   	ret    

00000000000411bb <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   411bb:	55                   	push   %rbp
   411bc:	48 89 e5             	mov    %rsp,%rbp
   411bf:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   411c3:	ba 08 50 04 00       	mov    $0x45008,%edx
   411c8:	be 00 0f 00 00       	mov    $0xf00,%esi
   411cd:	bf 20 00 00 00       	mov    $0x20,%edi
   411d2:	b8 00 00 00 00       	mov    $0x0,%eax
   411d7:	e8 9c 38 00 00       	call   44a78 <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   411dc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   411e3:	e9 f8 00 00 00       	jmp    412e0 <memshow_physical+0x125>
        if (pn % 64 == 0) {
   411e8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411eb:	83 e0 3f             	and    $0x3f,%eax
   411ee:	85 c0                	test   %eax,%eax
   411f0:	75 3c                	jne    4122e <memshow_physical+0x73>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   411f2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411f5:	c1 e0 0c             	shl    $0xc,%eax
   411f8:	89 c1                	mov    %eax,%ecx
   411fa:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411fd:	8d 50 3f             	lea    0x3f(%rax),%edx
   41200:	85 c0                	test   %eax,%eax
   41202:	0f 48 c2             	cmovs  %edx,%eax
   41205:	c1 f8 06             	sar    $0x6,%eax
   41208:	8d 50 01             	lea    0x1(%rax),%edx
   4120b:	89 d0                	mov    %edx,%eax
   4120d:	c1 e0 02             	shl    $0x2,%eax
   41210:	01 d0                	add    %edx,%eax
   41212:	c1 e0 04             	shl    $0x4,%eax
   41215:	83 c0 03             	add    $0x3,%eax
   41218:	ba 18 50 04 00       	mov    $0x45018,%edx
   4121d:	be 00 0f 00 00       	mov    $0xf00,%esi
   41222:	89 c7                	mov    %eax,%edi
   41224:	b8 00 00 00 00       	mov    $0x0,%eax
   41229:	e8 4a 38 00 00       	call   44a78 <console_printf>
        }

        int owner = pageinfo[pn].owner;
   4122e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41231:	48 98                	cltq   
   41233:	0f b6 84 00 20 ef 04 	movzbl 0x4ef20(%rax,%rax,1),%eax
   4123a:	00 
   4123b:	0f be c0             	movsbl %al,%eax
   4123e:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   41241:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41244:	48 98                	cltq   
   41246:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   4124d:	00 
   4124e:	84 c0                	test   %al,%al
   41250:	75 07                	jne    41259 <memshow_physical+0x9e>
            owner = PO_FREE;
   41252:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   41259:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4125c:	83 c0 02             	add    $0x2,%eax
   4125f:	48 98                	cltq   
   41261:	0f b7 84 00 20 4c 04 	movzwl 0x44c20(%rax,%rax,1),%eax
   41268:	00 
   41269:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   4126d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41270:	48 98                	cltq   
   41272:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   41279:	00 
   4127a:	3c 01                	cmp    $0x1,%al
   4127c:	7e 1a                	jle    41298 <memshow_physical+0xdd>
   4127e:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   41283:	48 c1 e8 0c          	shr    $0xc,%rax
   41287:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   4128a:	74 0c                	je     41298 <memshow_physical+0xdd>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   4128c:	b8 53 00 00 00       	mov    $0x53,%eax
   41291:	80 cc 0f             	or     $0xf,%ah
   41294:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   41298:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4129b:	8d 50 3f             	lea    0x3f(%rax),%edx
   4129e:	85 c0                	test   %eax,%eax
   412a0:	0f 48 c2             	cmovs  %edx,%eax
   412a3:	c1 f8 06             	sar    $0x6,%eax
   412a6:	8d 50 01             	lea    0x1(%rax),%edx
   412a9:	89 d0                	mov    %edx,%eax
   412ab:	c1 e0 02             	shl    $0x2,%eax
   412ae:	01 d0                	add    %edx,%eax
   412b0:	c1 e0 04             	shl    $0x4,%eax
   412b3:	89 c1                	mov    %eax,%ecx
   412b5:	8b 55 fc             	mov    -0x4(%rbp),%edx
   412b8:	89 d0                	mov    %edx,%eax
   412ba:	c1 f8 1f             	sar    $0x1f,%eax
   412bd:	c1 e8 1a             	shr    $0x1a,%eax
   412c0:	01 c2                	add    %eax,%edx
   412c2:	83 e2 3f             	and    $0x3f,%edx
   412c5:	29 c2                	sub    %eax,%edx
   412c7:	89 d0                	mov    %edx,%eax
   412c9:	83 c0 0c             	add    $0xc,%eax
   412cc:	01 c8                	add    %ecx,%eax
   412ce:	48 98                	cltq   
   412d0:	0f b7 55 f6          	movzwl -0xa(%rbp),%edx
   412d4:	66 89 94 00 00 80 0b 	mov    %dx,0xb8000(%rax,%rax,1)
   412db:	00 
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   412dc:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   412e0:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   412e7:	0f 8e fb fe ff ff    	jle    411e8 <memshow_physical+0x2d>
    }
}
   412ed:	90                   	nop
   412ee:	90                   	nop
   412ef:	c9                   	leave  
   412f0:	c3                   	ret    

00000000000412f1 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   412f1:	55                   	push   %rbp
   412f2:	48 89 e5             	mov    %rsp,%rbp
   412f5:	48 83 ec 40          	sub    $0x40,%rsp
   412f9:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   412fd:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   41301:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41305:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4130b:	48 89 c2             	mov    %rax,%rdx
   4130e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41312:	48 39 c2             	cmp    %rax,%rdx
   41315:	74 14                	je     4132b <memshow_virtual+0x3a>
   41317:	ba 20 50 04 00       	mov    $0x45020,%edx
   4131c:	be 6f 02 00 00       	mov    $0x26f,%esi
   41321:	bf 88 4c 04 00       	mov    $0x44c88,%edi
   41326:	e8 53 12 00 00       	call   4257e <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   4132b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4132f:	48 89 c1             	mov    %rax,%rcx
   41332:	ba 4d 50 04 00       	mov    $0x4504d,%edx
   41337:	be 00 0f 00 00       	mov    $0xf00,%esi
   4133c:	bf 3a 03 00 00       	mov    $0x33a,%edi
   41341:	b8 00 00 00 00       	mov    $0x0,%eax
   41346:	e8 2d 37 00 00       	call   44a78 <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   4134b:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   41352:	00 
   41353:	e9 80 01 00 00       	jmp    414d8 <memshow_virtual+0x1e7>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   41358:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4135c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   41360:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   41364:	48 89 ce             	mov    %rcx,%rsi
   41367:	48 89 c7             	mov    %rax,%rdi
   4136a:	e8 d1 18 00 00       	call   42c40 <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   4136f:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41372:	85 c0                	test   %eax,%eax
   41374:	79 0b                	jns    41381 <memshow_virtual+0x90>
            color = ' ';
   41376:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   4137c:	e9 d7 00 00 00       	jmp    41458 <memshow_virtual+0x167>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   41381:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41385:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   4138b:	76 14                	jbe    413a1 <memshow_virtual+0xb0>
   4138d:	ba 6a 50 04 00       	mov    $0x4506a,%edx
   41392:	be 78 02 00 00       	mov    $0x278,%esi
   41397:	bf 88 4c 04 00       	mov    $0x44c88,%edi
   4139c:	e8 dd 11 00 00       	call   4257e <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   413a1:	8b 45 d0             	mov    -0x30(%rbp),%eax
   413a4:	48 98                	cltq   
   413a6:	0f b6 84 00 20 ef 04 	movzbl 0x4ef20(%rax,%rax,1),%eax
   413ad:	00 
   413ae:	0f be c0             	movsbl %al,%eax
   413b1:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   413b4:	8b 45 d0             	mov    -0x30(%rbp),%eax
   413b7:	48 98                	cltq   
   413b9:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   413c0:	00 
   413c1:	84 c0                	test   %al,%al
   413c3:	75 07                	jne    413cc <memshow_virtual+0xdb>
                owner = PO_FREE;
   413c5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   413cc:	8b 45 f0             	mov    -0x10(%rbp),%eax
   413cf:	83 c0 02             	add    $0x2,%eax
   413d2:	48 98                	cltq   
   413d4:	0f b7 84 00 20 4c 04 	movzwl 0x44c20(%rax,%rax,1),%eax
   413db:	00 
   413dc:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   413e0:	8b 45 e0             	mov    -0x20(%rbp),%eax
   413e3:	48 98                	cltq   
   413e5:	83 e0 04             	and    $0x4,%eax
   413e8:	48 85 c0             	test   %rax,%rax
   413eb:	74 27                	je     41414 <memshow_virtual+0x123>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   413ed:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   413f1:	c1 e0 04             	shl    $0x4,%eax
   413f4:	66 25 00 f0          	and    $0xf000,%ax
   413f8:	89 c2                	mov    %eax,%edx
   413fa:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   413fe:	c1 f8 04             	sar    $0x4,%eax
   41401:	66 25 00 0f          	and    $0xf00,%ax
   41405:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   41407:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4140b:	0f b6 c0             	movzbl %al,%eax
   4140e:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41410:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   41414:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41417:	48 98                	cltq   
   41419:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   41420:	00 
   41421:	3c 01                	cmp    $0x1,%al
   41423:	7e 33                	jle    41458 <memshow_virtual+0x167>
   41425:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   4142a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4142e:	74 28                	je     41458 <memshow_virtual+0x167>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   41430:	b8 53 00 00 00       	mov    $0x53,%eax
   41435:	89 c2                	mov    %eax,%edx
   41437:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4143b:	66 25 00 f0          	and    $0xf000,%ax
   4143f:	09 d0                	or     %edx,%eax
   41441:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   41445:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41448:	48 98                	cltq   
   4144a:	83 e0 04             	and    $0x4,%eax
   4144d:	48 85 c0             	test   %rax,%rax
   41450:	75 06                	jne    41458 <memshow_virtual+0x167>
                    color = color | 0x0F00;
   41452:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   41458:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4145c:	48 c1 e8 0c          	shr    $0xc,%rax
   41460:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   41463:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41466:	83 e0 3f             	and    $0x3f,%eax
   41469:	85 c0                	test   %eax,%eax
   4146b:	75 34                	jne    414a1 <memshow_virtual+0x1b0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   4146d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41470:	c1 e8 06             	shr    $0x6,%eax
   41473:	89 c2                	mov    %eax,%edx
   41475:	89 d0                	mov    %edx,%eax
   41477:	c1 e0 02             	shl    $0x2,%eax
   4147a:	01 d0                	add    %edx,%eax
   4147c:	c1 e0 04             	shl    $0x4,%eax
   4147f:	05 73 03 00 00       	add    $0x373,%eax
   41484:	89 c7                	mov    %eax,%edi
   41486:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4148a:	48 89 c1             	mov    %rax,%rcx
   4148d:	ba 18 50 04 00       	mov    $0x45018,%edx
   41492:	be 00 0f 00 00       	mov    $0xf00,%esi
   41497:	b8 00 00 00 00       	mov    $0x0,%eax
   4149c:	e8 d7 35 00 00       	call   44a78 <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   414a1:	8b 45 ec             	mov    -0x14(%rbp),%eax
   414a4:	c1 e8 06             	shr    $0x6,%eax
   414a7:	89 c2                	mov    %eax,%edx
   414a9:	89 d0                	mov    %edx,%eax
   414ab:	c1 e0 02             	shl    $0x2,%eax
   414ae:	01 d0                	add    %edx,%eax
   414b0:	c1 e0 04             	shl    $0x4,%eax
   414b3:	89 c2                	mov    %eax,%edx
   414b5:	8b 45 ec             	mov    -0x14(%rbp),%eax
   414b8:	83 e0 3f             	and    $0x3f,%eax
   414bb:	01 d0                	add    %edx,%eax
   414bd:	05 7c 03 00 00       	add    $0x37c,%eax
   414c2:	89 c2                	mov    %eax,%edx
   414c4:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   414c8:	66 89 84 12 00 80 0b 	mov    %ax,0xb8000(%rdx,%rdx,1)
   414cf:	00 
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   414d0:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   414d7:	00 
   414d8:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   414df:	00 
   414e0:	0f 86 72 fe ff ff    	jbe    41358 <memshow_virtual+0x67>
    }
}
   414e6:	90                   	nop
   414e7:	90                   	nop
   414e8:	c9                   	leave  
   414e9:	c3                   	ret    

00000000000414ea <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   414ea:	55                   	push   %rbp
   414eb:	48 89 e5             	mov    %rsp,%rbp
   414ee:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   414f2:	8b 05 2c de 00 00    	mov    0xde2c(%rip),%eax        # 4f324 <last_ticks.1>
   414f8:	85 c0                	test   %eax,%eax
   414fa:	74 13                	je     4150f <memshow_virtual_animate+0x25>
   414fc:	8b 15 1e de 00 00    	mov    0xde1e(%rip),%edx        # 4f320 <ticks>
   41502:	8b 05 1c de 00 00    	mov    0xde1c(%rip),%eax        # 4f324 <last_ticks.1>
   41508:	29 c2                	sub    %eax,%edx
   4150a:	83 fa 31             	cmp    $0x31,%edx
   4150d:	76 2c                	jbe    4153b <memshow_virtual_animate+0x51>
        last_ticks = ticks;
   4150f:	8b 05 0b de 00 00    	mov    0xde0b(%rip),%eax        # 4f320 <ticks>
   41515:	89 05 09 de 00 00    	mov    %eax,0xde09(%rip)        # 4f324 <last_ticks.1>
        ++showing;
   4151b:	8b 05 e3 4a 00 00    	mov    0x4ae3(%rip),%eax        # 46004 <showing.0>
   41521:	83 c0 01             	add    $0x1,%eax
   41524:	89 05 da 4a 00 00    	mov    %eax,0x4ada(%rip)        # 46004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   4152a:	eb 0f                	jmp    4153b <memshow_virtual_animate+0x51>
           && processes[showing % NPROC].p_state == P_FREE) {
        ++showing;
   4152c:	8b 05 d2 4a 00 00    	mov    0x4ad2(%rip),%eax        # 46004 <showing.0>
   41532:	83 c0 01             	add    $0x1,%eax
   41535:	89 05 c9 4a 00 00    	mov    %eax,0x4ac9(%rip)        # 46004 <showing.0>
    while (showing <= 2*NPROC
   4153b:	8b 05 c3 4a 00 00    	mov    0x4ac3(%rip),%eax        # 46004 <showing.0>
           && processes[showing % NPROC].p_state == P_FREE) {
   41541:	83 f8 20             	cmp    $0x20,%eax
   41544:	7f 34                	jg     4157a <memshow_virtual_animate+0x90>
   41546:	8b 15 b8 4a 00 00    	mov    0x4ab8(%rip),%edx        # 46004 <showing.0>
   4154c:	89 d0                	mov    %edx,%eax
   4154e:	c1 f8 1f             	sar    $0x1f,%eax
   41551:	c1 e8 1c             	shr    $0x1c,%eax
   41554:	01 c2                	add    %eax,%edx
   41556:	83 e2 0f             	and    $0xf,%edx
   41559:	29 c2                	sub    %eax,%edx
   4155b:	89 d0                	mov    %edx,%eax
   4155d:	48 63 d0             	movslq %eax,%rdx
   41560:	48 89 d0             	mov    %rdx,%rax
   41563:	48 c1 e0 04          	shl    $0x4,%rax
   41567:	48 29 d0             	sub    %rdx,%rax
   4156a:	48 c1 e0 04          	shl    $0x4,%rax
   4156e:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   41574:	8b 00                	mov    (%rax),%eax
   41576:	85 c0                	test   %eax,%eax
   41578:	74 b2                	je     4152c <memshow_virtual_animate+0x42>
    }
    showing = showing % NPROC;
   4157a:	8b 15 84 4a 00 00    	mov    0x4a84(%rip),%edx        # 46004 <showing.0>
   41580:	89 d0                	mov    %edx,%eax
   41582:	c1 f8 1f             	sar    $0x1f,%eax
   41585:	c1 e8 1c             	shr    $0x1c,%eax
   41588:	01 c2                	add    %eax,%edx
   4158a:	83 e2 0f             	and    $0xf,%edx
   4158d:	29 c2                	sub    %eax,%edx
   4158f:	89 d0                	mov    %edx,%eax
   41591:	89 05 6d 4a 00 00    	mov    %eax,0x4a6d(%rip)        # 46004 <showing.0>

    if (processes[showing].p_state != P_FREE && processes[showing].display_status) {
   41597:	8b 05 67 4a 00 00    	mov    0x4a67(%rip),%eax        # 46004 <showing.0>
   4159d:	48 63 d0             	movslq %eax,%rdx
   415a0:	48 89 d0             	mov    %rdx,%rax
   415a3:	48 c1 e0 04          	shl    $0x4,%rax
   415a7:	48 29 d0             	sub    %rdx,%rax
   415aa:	48 c1 e0 04          	shl    $0x4,%rax
   415ae:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   415b4:	8b 00                	mov    (%rax),%eax
   415b6:	85 c0                	test   %eax,%eax
   415b8:	74 76                	je     41630 <memshow_virtual_animate+0x146>
   415ba:	8b 05 44 4a 00 00    	mov    0x4a44(%rip),%eax        # 46004 <showing.0>
   415c0:	48 63 d0             	movslq %eax,%rdx
   415c3:	48 89 d0             	mov    %rdx,%rax
   415c6:	48 c1 e0 04          	shl    $0x4,%rax
   415ca:	48 29 d0             	sub    %rdx,%rax
   415cd:	48 c1 e0 04          	shl    $0x4,%rax
   415d1:	48 05 e8 e0 04 00    	add    $0x4e0e8,%rax
   415d7:	0f b6 00             	movzbl (%rax),%eax
   415da:	84 c0                	test   %al,%al
   415dc:	74 52                	je     41630 <memshow_virtual_animate+0x146>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   415de:	8b 15 20 4a 00 00    	mov    0x4a20(%rip),%edx        # 46004 <showing.0>
   415e4:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   415e8:	89 d1                	mov    %edx,%ecx
   415ea:	ba 84 50 04 00       	mov    $0x45084,%edx
   415ef:	be 04 00 00 00       	mov    $0x4,%esi
   415f4:	48 89 c7             	mov    %rax,%rdi
   415f7:	b8 00 00 00 00       	mov    $0x0,%eax
   415fc:	e8 83 35 00 00       	call   44b84 <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   41601:	8b 05 fd 49 00 00    	mov    0x49fd(%rip),%eax        # 46004 <showing.0>
   41607:	48 63 d0             	movslq %eax,%rdx
   4160a:	48 89 d0             	mov    %rdx,%rax
   4160d:	48 c1 e0 04          	shl    $0x4,%rax
   41611:	48 29 d0             	sub    %rdx,%rax
   41614:	48 c1 e0 04          	shl    $0x4,%rax
   41618:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   4161e:	48 8b 00             	mov    (%rax),%rax
   41621:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   41625:	48 89 d6             	mov    %rdx,%rsi
   41628:	48 89 c7             	mov    %rax,%rdi
   4162b:	e8 c1 fc ff ff       	call   412f1 <memshow_virtual>
    }
}
   41630:	90                   	nop
   41631:	c9                   	leave  
   41632:	c3                   	ret    

0000000000041633 <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   41633:	55                   	push   %rbp
   41634:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   41637:	e8 4f 01 00 00       	call   4178b <segments_init>
    interrupt_init();
   4163c:	e8 d0 03 00 00       	call   41a11 <interrupt_init>
    virtual_memory_init();
   41641:	e8 f3 0f 00 00       	call   42639 <virtual_memory_init>
}
   41646:	90                   	nop
   41647:	5d                   	pop    %rbp
   41648:	c3                   	ret    

0000000000041649 <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   41649:	55                   	push   %rbp
   4164a:	48 89 e5             	mov    %rsp,%rbp
   4164d:	48 83 ec 18          	sub    $0x18,%rsp
   41651:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41655:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41659:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   4165c:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4165f:	48 98                	cltq   
   41661:	48 c1 e0 2d          	shl    $0x2d,%rax
   41665:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   41669:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   41670:	90 00 00 
   41673:	48 09 c2             	or     %rax,%rdx
    *segment = type
   41676:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4167a:	48 89 10             	mov    %rdx,(%rax)
}
   4167d:	90                   	nop
   4167e:	c9                   	leave  
   4167f:	c3                   	ret    

0000000000041680 <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   41680:	55                   	push   %rbp
   41681:	48 89 e5             	mov    %rsp,%rbp
   41684:	48 83 ec 28          	sub    $0x28,%rsp
   41688:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4168c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41690:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41693:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   41697:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   4169b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4169f:	48 c1 e0 10          	shl    $0x10,%rax
   416a3:	48 89 c2             	mov    %rax,%rdx
   416a6:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   416ad:	00 00 00 
   416b0:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   416b3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   416b7:	48 c1 e0 20          	shl    $0x20,%rax
   416bb:	48 89 c1             	mov    %rax,%rcx
   416be:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   416c5:	00 00 ff 
   416c8:	48 21 c8             	and    %rcx,%rax
   416cb:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   416ce:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   416d2:	48 83 e8 01          	sub    $0x1,%rax
   416d6:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   416d9:	48 09 d0             	or     %rdx,%rax
        | type
   416dc:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   416e0:	8b 55 ec             	mov    -0x14(%rbp),%edx
   416e3:	48 63 d2             	movslq %edx,%rdx
   416e6:	48 c1 e2 2d          	shl    $0x2d,%rdx
   416ea:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   416ed:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   416f4:	80 00 00 
   416f7:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   416fa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   416fe:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   41701:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41705:	48 83 c0 08          	add    $0x8,%rax
   41709:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   4170d:	48 c1 ea 20          	shr    $0x20,%rdx
   41711:	48 89 10             	mov    %rdx,(%rax)
}
   41714:	90                   	nop
   41715:	c9                   	leave  
   41716:	c3                   	ret    

0000000000041717 <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   41717:	55                   	push   %rbp
   41718:	48 89 e5             	mov    %rsp,%rbp
   4171b:	48 83 ec 20          	sub    $0x20,%rsp
   4171f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41723:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41727:	89 55 ec             	mov    %edx,-0x14(%rbp)
   4172a:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   4172e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41732:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   41735:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   41739:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4173c:	48 63 d2             	movslq %edx,%rdx
   4173f:	48 c1 e2 2d          	shl    $0x2d,%rdx
   41743:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   41746:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4174a:	48 c1 e0 20          	shl    $0x20,%rax
   4174e:	48 89 c1             	mov    %rax,%rcx
   41751:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   41758:	00 ff ff 
   4175b:	48 21 c8             	and    %rcx,%rax
   4175e:	48 09 c2             	or     %rax,%rdx
   41761:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   41768:	80 00 00 
   4176b:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   4176e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41772:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   41775:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41779:	48 c1 e8 20          	shr    $0x20,%rax
   4177d:	48 89 c2             	mov    %rax,%rdx
   41780:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41784:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   41788:	90                   	nop
   41789:	c9                   	leave  
   4178a:	c3                   	ret    

000000000004178b <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   4178b:	55                   	push   %rbp
   4178c:	48 89 e5             	mov    %rsp,%rbp
   4178f:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   41793:	48 c7 05 a2 db 00 00 	movq   $0x0,0xdba2(%rip)        # 4f340 <segments>
   4179a:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   4179e:	ba 00 00 00 00       	mov    $0x0,%edx
   417a3:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   417aa:	08 20 00 
   417ad:	48 89 c6             	mov    %rax,%rsi
   417b0:	bf 48 f3 04 00       	mov    $0x4f348,%edi
   417b5:	e8 8f fe ff ff       	call   41649 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   417ba:	ba 03 00 00 00       	mov    $0x3,%edx
   417bf:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   417c6:	08 20 00 
   417c9:	48 89 c6             	mov    %rax,%rsi
   417cc:	bf 50 f3 04 00       	mov    $0x4f350,%edi
   417d1:	e8 73 fe ff ff       	call   41649 <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   417d6:	ba 00 00 00 00       	mov    $0x0,%edx
   417db:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   417e2:	02 00 00 
   417e5:	48 89 c6             	mov    %rax,%rsi
   417e8:	bf 58 f3 04 00       	mov    $0x4f358,%edi
   417ed:	e8 57 fe ff ff       	call   41649 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   417f2:	ba 03 00 00 00       	mov    $0x3,%edx
   417f7:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   417fe:	02 00 00 
   41801:	48 89 c6             	mov    %rax,%rsi
   41804:	bf 60 f3 04 00       	mov    $0x4f360,%edi
   41809:	e8 3b fe ff ff       	call   41649 <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   4180e:	b8 80 03 05 00       	mov    $0x50380,%eax
   41813:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   41819:	48 89 c1             	mov    %rax,%rcx
   4181c:	ba 00 00 00 00       	mov    $0x0,%edx
   41821:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   41828:	09 00 00 
   4182b:	48 89 c6             	mov    %rax,%rsi
   4182e:	bf 68 f3 04 00       	mov    $0x4f368,%edi
   41833:	e8 48 fe ff ff       	call   41680 <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   41838:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   4183e:	b8 40 f3 04 00       	mov    $0x4f340,%eax
   41843:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   41847:	ba 60 00 00 00       	mov    $0x60,%edx
   4184c:	be 00 00 00 00       	mov    $0x0,%esi
   41851:	bf 80 03 05 00       	mov    $0x50380,%edi
   41856:	e8 66 24 00 00       	call   43cc1 <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   4185b:	48 c7 05 1e eb 00 00 	movq   $0x80000,0xeb1e(%rip)        # 50384 <kernel_task_descriptor+0x4>
   41862:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   41866:	ba 00 10 00 00       	mov    $0x1000,%edx
   4186b:	be 00 00 00 00       	mov    $0x0,%esi
   41870:	bf 80 f3 04 00       	mov    $0x4f380,%edi
   41875:	e8 47 24 00 00       	call   43cc1 <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   4187a:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   41881:	eb 30                	jmp    418b3 <segments_init+0x128>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   41883:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   41888:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4188b:	48 c1 e0 04          	shl    $0x4,%rax
   4188f:	48 05 80 f3 04 00    	add    $0x4f380,%rax
   41895:	48 89 d1             	mov    %rdx,%rcx
   41898:	ba 00 00 00 00       	mov    $0x0,%edx
   4189d:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   418a4:	0e 00 00 
   418a7:	48 89 c7             	mov    %rax,%rdi
   418aa:	e8 68 fe ff ff       	call   41717 <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   418af:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   418b3:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   418ba:	76 c7                	jbe    41883 <segments_init+0xf8>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   418bc:	b8 36 00 04 00       	mov    $0x40036,%eax
   418c1:	48 89 c1             	mov    %rax,%rcx
   418c4:	ba 00 00 00 00       	mov    $0x0,%edx
   418c9:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   418d0:	0e 00 00 
   418d3:	48 89 c6             	mov    %rax,%rsi
   418d6:	bf 80 f5 04 00       	mov    $0x4f580,%edi
   418db:	e8 37 fe ff ff       	call   41717 <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   418e0:	b8 2e 00 04 00       	mov    $0x4002e,%eax
   418e5:	48 89 c1             	mov    %rax,%rcx
   418e8:	ba 00 00 00 00       	mov    $0x0,%edx
   418ed:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   418f4:	0e 00 00 
   418f7:	48 89 c6             	mov    %rax,%rsi
   418fa:	bf 50 f4 04 00       	mov    $0x4f450,%edi
   418ff:	e8 13 fe ff ff       	call   41717 <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   41904:	b8 32 00 04 00       	mov    $0x40032,%eax
   41909:	48 89 c1             	mov    %rax,%rcx
   4190c:	ba 00 00 00 00       	mov    $0x0,%edx
   41911:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41918:	0e 00 00 
   4191b:	48 89 c6             	mov    %rax,%rsi
   4191e:	bf 60 f4 04 00       	mov    $0x4f460,%edi
   41923:	e8 ef fd ff ff       	call   41717 <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41928:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   4192f:	eb 3e                	jmp    4196f <segments_init+0x1e4>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   41931:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41934:	83 e8 30             	sub    $0x30,%eax
   41937:	89 c0                	mov    %eax,%eax
   41939:	48 8b 04 c5 e7 00 04 	mov    0x400e7(,%rax,8),%rax
   41940:	00 
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   41941:	48 89 c2             	mov    %rax,%rdx
   41944:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41947:	48 c1 e0 04          	shl    $0x4,%rax
   4194b:	48 05 80 f3 04 00    	add    $0x4f380,%rax
   41951:	48 89 d1             	mov    %rdx,%rcx
   41954:	ba 03 00 00 00       	mov    $0x3,%edx
   41959:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41960:	0e 00 00 
   41963:	48 89 c7             	mov    %rax,%rdi
   41966:	e8 ac fd ff ff       	call   41717 <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   4196b:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   4196f:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   41973:	76 bc                	jbe    41931 <segments_init+0x1a6>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   41975:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   4197b:	b8 80 f3 04 00       	mov    $0x4f380,%eax
   41980:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   41984:	b8 28 00 00 00       	mov    $0x28,%eax
   41989:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   4198d:	0f 00 d8             	ltr    %ax
   41990:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   41994:	0f 20 c0             	mov    %cr0,%rax
   41997:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   4199b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   4199f:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   419a2:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   419a9:	8b 45 f4             	mov    -0xc(%rbp),%eax
   419ac:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   419af:	8b 45 f0             	mov    -0x10(%rbp),%eax
   419b2:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   419b6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   419ba:	0f 22 c0             	mov    %rax,%cr0
}
   419bd:	90                   	nop
    lcr0(cr0);
}
   419be:	90                   	nop
   419bf:	c9                   	leave  
   419c0:	c3                   	ret    

00000000000419c1 <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   419c1:	55                   	push   %rbp
   419c2:	48 89 e5             	mov    %rsp,%rbp
   419c5:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   419c9:	0f b7 05 10 ea 00 00 	movzwl 0xea10(%rip),%eax        # 503e0 <interrupts_enabled>
   419d0:	f7 d0                	not    %eax
   419d2:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   419d6:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   419da:	0f b6 c0             	movzbl %al,%eax
   419dd:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   419e4:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   419e7:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   419eb:	8b 55 f0             	mov    -0x10(%rbp),%edx
   419ee:	ee                   	out    %al,(%dx)
}
   419ef:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   419f0:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   419f4:	66 c1 e8 08          	shr    $0x8,%ax
   419f8:	0f b6 c0             	movzbl %al,%eax
   419fb:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   41a02:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a05:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   41a09:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41a0c:	ee                   	out    %al,(%dx)
}
   41a0d:	90                   	nop
}
   41a0e:	90                   	nop
   41a0f:	c9                   	leave  
   41a10:	c3                   	ret    

0000000000041a11 <interrupt_init>:

void interrupt_init(void) {
   41a11:	55                   	push   %rbp
   41a12:	48 89 e5             	mov    %rsp,%rbp
   41a15:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   41a19:	66 c7 05 be e9 00 00 	movw   $0x0,0xe9be(%rip)        # 503e0 <interrupts_enabled>
   41a20:	00 00 
    interrupt_mask();
   41a22:	e8 9a ff ff ff       	call   419c1 <interrupt_mask>
   41a27:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   41a2e:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a32:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   41a36:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   41a39:	ee                   	out    %al,(%dx)
}
   41a3a:	90                   	nop
   41a3b:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   41a42:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a46:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   41a4a:	8b 55 ac             	mov    -0x54(%rbp),%edx
   41a4d:	ee                   	out    %al,(%dx)
}
   41a4e:	90                   	nop
   41a4f:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   41a56:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a5a:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   41a5e:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   41a61:	ee                   	out    %al,(%dx)
}
   41a62:	90                   	nop
   41a63:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   41a6a:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a6e:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   41a72:	8b 55 bc             	mov    -0x44(%rbp),%edx
   41a75:	ee                   	out    %al,(%dx)
}
   41a76:	90                   	nop
   41a77:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   41a7e:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a82:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   41a86:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   41a89:	ee                   	out    %al,(%dx)
}
   41a8a:	90                   	nop
   41a8b:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   41a92:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a96:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   41a9a:	8b 55 cc             	mov    -0x34(%rbp),%edx
   41a9d:	ee                   	out    %al,(%dx)
}
   41a9e:	90                   	nop
   41a9f:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   41aa6:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41aaa:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   41aae:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   41ab1:	ee                   	out    %al,(%dx)
}
   41ab2:	90                   	nop
   41ab3:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   41aba:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41abe:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   41ac2:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41ac5:	ee                   	out    %al,(%dx)
}
   41ac6:	90                   	nop
   41ac7:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   41ace:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ad2:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41ad6:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41ad9:	ee                   	out    %al,(%dx)
}
   41ada:	90                   	nop
   41adb:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   41ae2:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ae6:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41aea:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41aed:	ee                   	out    %al,(%dx)
}
   41aee:	90                   	nop
   41aef:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   41af6:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41afa:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41afe:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41b01:	ee                   	out    %al,(%dx)
}
   41b02:	90                   	nop
   41b03:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   41b0a:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b0e:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41b12:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41b15:	ee                   	out    %al,(%dx)
}
   41b16:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   41b17:	e8 a5 fe ff ff       	call   419c1 <interrupt_mask>
}
   41b1c:	90                   	nop
   41b1d:	c9                   	leave  
   41b1e:	c3                   	ret    

0000000000041b1f <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   41b1f:	55                   	push   %rbp
   41b20:	48 89 e5             	mov    %rsp,%rbp
   41b23:	48 83 ec 28          	sub    $0x28,%rsp
   41b27:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   41b2a:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41b2e:	0f 8e 9e 00 00 00    	jle    41bd2 <timer_init+0xb3>
   41b34:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   41b3b:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b3f:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41b43:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41b46:	ee                   	out    %al,(%dx)
}
   41b47:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   41b48:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41b4b:	89 c2                	mov    %eax,%edx
   41b4d:	c1 ea 1f             	shr    $0x1f,%edx
   41b50:	01 d0                	add    %edx,%eax
   41b52:	d1 f8                	sar    %eax
   41b54:	05 de 34 12 00       	add    $0x1234de,%eax
   41b59:	99                   	cltd   
   41b5a:	f7 7d dc             	idivl  -0x24(%rbp)
   41b5d:	89 c2                	mov    %eax,%edx
   41b5f:	89 d0                	mov    %edx,%eax
   41b61:	c1 f8 1f             	sar    $0x1f,%eax
   41b64:	c1 e8 18             	shr    $0x18,%eax
   41b67:	01 c2                	add    %eax,%edx
   41b69:	0f b6 d2             	movzbl %dl,%edx
   41b6c:	29 c2                	sub    %eax,%edx
   41b6e:	89 d0                	mov    %edx,%eax
   41b70:	0f b6 c0             	movzbl %al,%eax
   41b73:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   41b7a:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b7d:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41b81:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41b84:	ee                   	out    %al,(%dx)
}
   41b85:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   41b86:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41b89:	89 c2                	mov    %eax,%edx
   41b8b:	c1 ea 1f             	shr    $0x1f,%edx
   41b8e:	01 d0                	add    %edx,%eax
   41b90:	d1 f8                	sar    %eax
   41b92:	05 de 34 12 00       	add    $0x1234de,%eax
   41b97:	99                   	cltd   
   41b98:	f7 7d dc             	idivl  -0x24(%rbp)
   41b9b:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41ba1:	85 c0                	test   %eax,%eax
   41ba3:	0f 48 c2             	cmovs  %edx,%eax
   41ba6:	c1 f8 08             	sar    $0x8,%eax
   41ba9:	0f b6 c0             	movzbl %al,%eax
   41bac:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   41bb3:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41bb6:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41bba:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41bbd:	ee                   	out    %al,(%dx)
}
   41bbe:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   41bbf:	0f b7 05 1a e8 00 00 	movzwl 0xe81a(%rip),%eax        # 503e0 <interrupts_enabled>
   41bc6:	83 c8 01             	or     $0x1,%eax
   41bc9:	66 89 05 10 e8 00 00 	mov    %ax,0xe810(%rip)        # 503e0 <interrupts_enabled>
   41bd0:	eb 11                	jmp    41be3 <timer_init+0xc4>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   41bd2:	0f b7 05 07 e8 00 00 	movzwl 0xe807(%rip),%eax        # 503e0 <interrupts_enabled>
   41bd9:	83 e0 fe             	and    $0xfffffffe,%eax
   41bdc:	66 89 05 fd e7 00 00 	mov    %ax,0xe7fd(%rip)        # 503e0 <interrupts_enabled>
    }
    interrupt_mask();
   41be3:	e8 d9 fd ff ff       	call   419c1 <interrupt_mask>
}
   41be8:	90                   	nop
   41be9:	c9                   	leave  
   41bea:	c3                   	ret    

0000000000041beb <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   41beb:	55                   	push   %rbp
   41bec:	48 89 e5             	mov    %rsp,%rbp
   41bef:	48 83 ec 08          	sub    $0x8,%rsp
   41bf3:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   41bf7:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   41bfc:	74 14                	je     41c12 <physical_memory_isreserved+0x27>
   41bfe:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   41c05:	00 
   41c06:	76 11                	jbe    41c19 <physical_memory_isreserved+0x2e>
   41c08:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   41c0f:	00 
   41c10:	77 07                	ja     41c19 <physical_memory_isreserved+0x2e>
   41c12:	b8 01 00 00 00       	mov    $0x1,%eax
   41c17:	eb 05                	jmp    41c1e <physical_memory_isreserved+0x33>
   41c19:	b8 00 00 00 00       	mov    $0x0,%eax
}
   41c1e:	c9                   	leave  
   41c1f:	c3                   	ret    

0000000000041c20 <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   41c20:	55                   	push   %rbp
   41c21:	48 89 e5             	mov    %rsp,%rbp
   41c24:	48 83 ec 10          	sub    $0x10,%rsp
   41c28:	89 7d fc             	mov    %edi,-0x4(%rbp)
   41c2b:	89 75 f8             	mov    %esi,-0x8(%rbp)
   41c2e:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   41c31:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41c34:	c1 e0 10             	shl    $0x10,%eax
   41c37:	89 c2                	mov    %eax,%edx
   41c39:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41c3c:	c1 e0 0b             	shl    $0xb,%eax
   41c3f:	09 c2                	or     %eax,%edx
   41c41:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41c44:	c1 e0 08             	shl    $0x8,%eax
   41c47:	09 d0                	or     %edx,%eax
}
   41c49:	c9                   	leave  
   41c4a:	c3                   	ret    

0000000000041c4b <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   41c4b:	55                   	push   %rbp
   41c4c:	48 89 e5             	mov    %rsp,%rbp
   41c4f:	48 83 ec 18          	sub    $0x18,%rsp
   41c53:	89 7d ec             	mov    %edi,-0x14(%rbp)
   41c56:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   41c59:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41c5c:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41c5f:	09 d0                	or     %edx,%eax
   41c61:	0d 00 00 00 80       	or     $0x80000000,%eax
   41c66:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   41c6d:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   41c70:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41c73:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41c76:	ef                   	out    %eax,(%dx)
}
   41c77:	90                   	nop
   41c78:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   41c7f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41c82:	89 c2                	mov    %eax,%edx
   41c84:	ed                   	in     (%dx),%eax
   41c85:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   41c88:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   41c8b:	c9                   	leave  
   41c8c:	c3                   	ret    

0000000000041c8d <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   41c8d:	55                   	push   %rbp
   41c8e:	48 89 e5             	mov    %rsp,%rbp
   41c91:	48 83 ec 28          	sub    $0x28,%rsp
   41c95:	89 7d dc             	mov    %edi,-0x24(%rbp)
   41c98:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   41c9b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41ca2:	eb 73                	jmp    41d17 <pci_find_device+0x8a>
        for (int slot = 0; slot != 32; ++slot) {
   41ca4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41cab:	eb 60                	jmp    41d0d <pci_find_device+0x80>
            for (int func = 0; func != 8; ++func) {
   41cad:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41cb4:	eb 4a                	jmp    41d00 <pci_find_device+0x73>
                int configaddr = pci_make_configaddr(bus, slot, func);
   41cb6:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41cb9:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41cbc:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41cbf:	89 ce                	mov    %ecx,%esi
   41cc1:	89 c7                	mov    %eax,%edi
   41cc3:	e8 58 ff ff ff       	call   41c20 <pci_make_configaddr>
   41cc8:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   41ccb:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41cce:	be 00 00 00 00       	mov    $0x0,%esi
   41cd3:	89 c7                	mov    %eax,%edi
   41cd5:	e8 71 ff ff ff       	call   41c4b <pci_config_readl>
   41cda:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   41cdd:	8b 45 d8             	mov    -0x28(%rbp),%eax
   41ce0:	c1 e0 10             	shl    $0x10,%eax
   41ce3:	0b 45 dc             	or     -0x24(%rbp),%eax
   41ce6:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   41ce9:	75 05                	jne    41cf0 <pci_find_device+0x63>
                    return configaddr;
   41ceb:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41cee:	eb 35                	jmp    41d25 <pci_find_device+0x98>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   41cf0:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   41cf4:	75 06                	jne    41cfc <pci_find_device+0x6f>
   41cf6:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41cfa:	74 0c                	je     41d08 <pci_find_device+0x7b>
            for (int func = 0; func != 8; ++func) {
   41cfc:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41d00:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   41d04:	75 b0                	jne    41cb6 <pci_find_device+0x29>
   41d06:	eb 01                	jmp    41d09 <pci_find_device+0x7c>
                    break;
   41d08:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   41d09:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41d0d:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   41d11:	75 9a                	jne    41cad <pci_find_device+0x20>
    for (int bus = 0; bus != 256; ++bus) {
   41d13:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41d17:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   41d1e:	75 84                	jne    41ca4 <pci_find_device+0x17>
                }
            }
        }
    }
    return -1;
   41d20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   41d25:	c9                   	leave  
   41d26:	c3                   	ret    

0000000000041d27 <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   41d27:	55                   	push   %rbp
   41d28:	48 89 e5             	mov    %rsp,%rbp
   41d2b:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   41d2f:	be 13 71 00 00       	mov    $0x7113,%esi
   41d34:	bf 86 80 00 00       	mov    $0x8086,%edi
   41d39:	e8 4f ff ff ff       	call   41c8d <pci_find_device>
   41d3e:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   41d41:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   41d45:	78 30                	js     41d77 <poweroff+0x50>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   41d47:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41d4a:	be 40 00 00 00       	mov    $0x40,%esi
   41d4f:	89 c7                	mov    %eax,%edi
   41d51:	e8 f5 fe ff ff       	call   41c4b <pci_config_readl>
   41d56:	25 c0 ff 00 00       	and    $0xffc0,%eax
   41d5b:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   41d5e:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41d61:	83 c0 04             	add    $0x4,%eax
   41d64:	89 45 f4             	mov    %eax,-0xc(%rbp)
   41d67:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   41d6d:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   41d71:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41d74:	66 ef                	out    %ax,(%dx)
}
   41d76:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   41d77:	ba a0 50 04 00       	mov    $0x450a0,%edx
   41d7c:	be 00 c0 00 00       	mov    $0xc000,%esi
   41d81:	bf 80 07 00 00       	mov    $0x780,%edi
   41d86:	b8 00 00 00 00       	mov    $0x0,%eax
   41d8b:	e8 e8 2c 00 00       	call   44a78 <console_printf>
 spinloop: goto spinloop;
   41d90:	eb fe                	jmp    41d90 <poweroff+0x69>

0000000000041d92 <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   41d92:	55                   	push   %rbp
   41d93:	48 89 e5             	mov    %rsp,%rbp
   41d96:	48 83 ec 10          	sub    $0x10,%rsp
   41d9a:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   41da1:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41da5:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41da9:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41dac:	ee                   	out    %al,(%dx)
}
   41dad:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   41dae:	eb fe                	jmp    41dae <reboot+0x1c>

0000000000041db0 <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   41db0:	55                   	push   %rbp
   41db1:	48 89 e5             	mov    %rsp,%rbp
   41db4:	48 83 ec 10          	sub    $0x10,%rsp
   41db8:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41dbc:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   41dbf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41dc3:	48 83 c0 18          	add    $0x18,%rax
   41dc7:	ba c0 00 00 00       	mov    $0xc0,%edx
   41dcc:	be 00 00 00 00       	mov    $0x0,%esi
   41dd1:	48 89 c7             	mov    %rax,%rdi
   41dd4:	e8 e8 1e 00 00       	call   43cc1 <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   41dd9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ddd:	66 c7 80 b8 00 00 00 	movw   $0x13,0xb8(%rax)
   41de4:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   41de6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41dea:	48 c7 80 90 00 00 00 	movq   $0x23,0x90(%rax)
   41df1:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   41df5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41df9:	48 c7 80 98 00 00 00 	movq   $0x23,0x98(%rax)
   41e00:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   41e04:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e08:	66 c7 80 d0 00 00 00 	movw   $0x23,0xd0(%rax)
   41e0f:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   41e11:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e15:	48 c7 80 c0 00 00 00 	movq   $0x200,0xc0(%rax)
   41e1c:	00 02 00 00 

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   41e20:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41e23:	83 e0 01             	and    $0x1,%eax
   41e26:	85 c0                	test   %eax,%eax
   41e28:	74 1c                	je     41e46 <process_init+0x96>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   41e2a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e2e:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   41e35:	80 cc 30             	or     $0x30,%ah
   41e38:	48 89 c2             	mov    %rax,%rdx
   41e3b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e3f:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   41e46:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41e49:	83 e0 02             	and    $0x2,%eax
   41e4c:	85 c0                	test   %eax,%eax
   41e4e:	74 1c                	je     41e6c <process_init+0xbc>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   41e50:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e54:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   41e5b:	80 e4 fd             	and    $0xfd,%ah
   41e5e:	48 89 c2             	mov    %rax,%rdx
   41e61:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e65:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    p->display_status = 1;
   41e6c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e70:	c6 80 e8 00 00 00 01 	movb   $0x1,0xe8(%rax)
}
   41e77:	90                   	nop
   41e78:	c9                   	leave  
   41e79:	c3                   	ret    

0000000000041e7a <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   41e7a:	55                   	push   %rbp
   41e7b:	48 89 e5             	mov    %rsp,%rbp
   41e7e:	48 83 ec 28          	sub    $0x28,%rsp
   41e82:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   41e85:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41e89:	78 09                	js     41e94 <console_show_cursor+0x1a>
   41e8b:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   41e92:	7e 07                	jle    41e9b <console_show_cursor+0x21>
        cpos = 0;
   41e94:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   41e9b:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   41ea2:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ea6:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41eaa:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41ead:	ee                   	out    %al,(%dx)
}
   41eae:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   41eaf:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41eb2:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41eb8:	85 c0                	test   %eax,%eax
   41eba:	0f 48 c2             	cmovs  %edx,%eax
   41ebd:	c1 f8 08             	sar    $0x8,%eax
   41ec0:	0f b6 c0             	movzbl %al,%eax
   41ec3:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   41eca:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ecd:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41ed1:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41ed4:	ee                   	out    %al,(%dx)
}
   41ed5:	90                   	nop
   41ed6:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   41edd:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ee1:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41ee5:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41ee8:	ee                   	out    %al,(%dx)
}
   41ee9:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   41eea:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41eed:	89 d0                	mov    %edx,%eax
   41eef:	c1 f8 1f             	sar    $0x1f,%eax
   41ef2:	c1 e8 18             	shr    $0x18,%eax
   41ef5:	01 c2                	add    %eax,%edx
   41ef7:	0f b6 d2             	movzbl %dl,%edx
   41efa:	29 c2                	sub    %eax,%edx
   41efc:	89 d0                	mov    %edx,%eax
   41efe:	0f b6 c0             	movzbl %al,%eax
   41f01:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   41f08:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f0b:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41f0f:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41f12:	ee                   	out    %al,(%dx)
}
   41f13:	90                   	nop
}
   41f14:	90                   	nop
   41f15:	c9                   	leave  
   41f16:	c3                   	ret    

0000000000041f17 <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   41f17:	55                   	push   %rbp
   41f18:	48 89 e5             	mov    %rsp,%rbp
   41f1b:	48 83 ec 20          	sub    $0x20,%rsp
   41f1f:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41f26:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41f29:	89 c2                	mov    %eax,%edx
   41f2b:	ec                   	in     (%dx),%al
   41f2c:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   41f2f:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   41f33:	0f b6 c0             	movzbl %al,%eax
   41f36:	83 e0 01             	and    $0x1,%eax
   41f39:	85 c0                	test   %eax,%eax
   41f3b:	75 0a                	jne    41f47 <keyboard_readc+0x30>
        return -1;
   41f3d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   41f42:	e9 e7 01 00 00       	jmp    4212e <keyboard_readc+0x217>
   41f47:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41f4e:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41f51:	89 c2                	mov    %eax,%edx
   41f53:	ec                   	in     (%dx),%al
   41f54:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   41f57:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   41f5b:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   41f5e:	0f b6 05 7d e4 00 00 	movzbl 0xe47d(%rip),%eax        # 503e2 <last_escape.2>
   41f65:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   41f68:	c6 05 73 e4 00 00 00 	movb   $0x0,0xe473(%rip)        # 503e2 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   41f6f:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   41f73:	75 11                	jne    41f86 <keyboard_readc+0x6f>
        last_escape = 0x80;
   41f75:	c6 05 66 e4 00 00 80 	movb   $0x80,0xe466(%rip)        # 503e2 <last_escape.2>
        return 0;
   41f7c:	b8 00 00 00 00       	mov    $0x0,%eax
   41f81:	e9 a8 01 00 00       	jmp    4212e <keyboard_readc+0x217>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   41f86:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41f8a:	84 c0                	test   %al,%al
   41f8c:	79 60                	jns    41fee <keyboard_readc+0xd7>
        int ch = keymap[(data & 0x7F) | escape];
   41f8e:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41f92:	83 e0 7f             	and    $0x7f,%eax
   41f95:	89 c2                	mov    %eax,%edx
   41f97:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   41f9b:	09 d0                	or     %edx,%eax
   41f9d:	48 98                	cltq   
   41f9f:	0f b6 80 c0 50 04 00 	movzbl 0x450c0(%rax),%eax
   41fa6:	0f b6 c0             	movzbl %al,%eax
   41fa9:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   41fac:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   41fb3:	7e 2f                	jle    41fe4 <keyboard_readc+0xcd>
   41fb5:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   41fbc:	7f 26                	jg     41fe4 <keyboard_readc+0xcd>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   41fbe:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41fc1:	2d fa 00 00 00       	sub    $0xfa,%eax
   41fc6:	ba 01 00 00 00       	mov    $0x1,%edx
   41fcb:	89 c1                	mov    %eax,%ecx
   41fcd:	d3 e2                	shl    %cl,%edx
   41fcf:	89 d0                	mov    %edx,%eax
   41fd1:	f7 d0                	not    %eax
   41fd3:	89 c2                	mov    %eax,%edx
   41fd5:	0f b6 05 07 e4 00 00 	movzbl 0xe407(%rip),%eax        # 503e3 <modifiers.1>
   41fdc:	21 d0                	and    %edx,%eax
   41fde:	88 05 ff e3 00 00    	mov    %al,0xe3ff(%rip)        # 503e3 <modifiers.1>
        }
        return 0;
   41fe4:	b8 00 00 00 00       	mov    $0x0,%eax
   41fe9:	e9 40 01 00 00       	jmp    4212e <keyboard_readc+0x217>
    }

    int ch = (unsigned char) keymap[data | escape];
   41fee:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41ff2:	0a 45 fa             	or     -0x6(%rbp),%al
   41ff5:	0f b6 c0             	movzbl %al,%eax
   41ff8:	48 98                	cltq   
   41ffa:	0f b6 80 c0 50 04 00 	movzbl 0x450c0(%rax),%eax
   42001:	0f b6 c0             	movzbl %al,%eax
   42004:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   42007:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   4200b:	7e 57                	jle    42064 <keyboard_readc+0x14d>
   4200d:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   42011:	7f 51                	jg     42064 <keyboard_readc+0x14d>
        if (modifiers & MOD_CONTROL) {
   42013:	0f b6 05 c9 e3 00 00 	movzbl 0xe3c9(%rip),%eax        # 503e3 <modifiers.1>
   4201a:	0f b6 c0             	movzbl %al,%eax
   4201d:	83 e0 02             	and    $0x2,%eax
   42020:	85 c0                	test   %eax,%eax
   42022:	74 09                	je     4202d <keyboard_readc+0x116>
            ch -= 0x60;
   42024:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   42028:	e9 fd 00 00 00       	jmp    4212a <keyboard_readc+0x213>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   4202d:	0f b6 05 af e3 00 00 	movzbl 0xe3af(%rip),%eax        # 503e3 <modifiers.1>
   42034:	0f b6 c0             	movzbl %al,%eax
   42037:	83 e0 01             	and    $0x1,%eax
   4203a:	85 c0                	test   %eax,%eax
   4203c:	0f 94 c2             	sete   %dl
   4203f:	0f b6 05 9d e3 00 00 	movzbl 0xe39d(%rip),%eax        # 503e3 <modifiers.1>
   42046:	0f b6 c0             	movzbl %al,%eax
   42049:	83 e0 08             	and    $0x8,%eax
   4204c:	85 c0                	test   %eax,%eax
   4204e:	0f 94 c0             	sete   %al
   42051:	31 d0                	xor    %edx,%eax
   42053:	84 c0                	test   %al,%al
   42055:	0f 84 cf 00 00 00    	je     4212a <keyboard_readc+0x213>
            ch -= 0x20;
   4205b:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   4205f:	e9 c6 00 00 00       	jmp    4212a <keyboard_readc+0x213>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   42064:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   4206b:	7e 30                	jle    4209d <keyboard_readc+0x186>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   4206d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42070:	2d fa 00 00 00       	sub    $0xfa,%eax
   42075:	ba 01 00 00 00       	mov    $0x1,%edx
   4207a:	89 c1                	mov    %eax,%ecx
   4207c:	d3 e2                	shl    %cl,%edx
   4207e:	89 d0                	mov    %edx,%eax
   42080:	89 c2                	mov    %eax,%edx
   42082:	0f b6 05 5a e3 00 00 	movzbl 0xe35a(%rip),%eax        # 503e3 <modifiers.1>
   42089:	31 d0                	xor    %edx,%eax
   4208b:	88 05 52 e3 00 00    	mov    %al,0xe352(%rip)        # 503e3 <modifiers.1>
        ch = 0;
   42091:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42098:	e9 8e 00 00 00       	jmp    4212b <keyboard_readc+0x214>
    } else if (ch >= KEY_SHIFT) {
   4209d:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   420a4:	7e 2d                	jle    420d3 <keyboard_readc+0x1bc>
        modifiers |= 1 << (ch - KEY_SHIFT);
   420a6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   420a9:	2d fa 00 00 00       	sub    $0xfa,%eax
   420ae:	ba 01 00 00 00       	mov    $0x1,%edx
   420b3:	89 c1                	mov    %eax,%ecx
   420b5:	d3 e2                	shl    %cl,%edx
   420b7:	89 d0                	mov    %edx,%eax
   420b9:	89 c2                	mov    %eax,%edx
   420bb:	0f b6 05 21 e3 00 00 	movzbl 0xe321(%rip),%eax        # 503e3 <modifiers.1>
   420c2:	09 d0                	or     %edx,%eax
   420c4:	88 05 19 e3 00 00    	mov    %al,0xe319(%rip)        # 503e3 <modifiers.1>
        ch = 0;
   420ca:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   420d1:	eb 58                	jmp    4212b <keyboard_readc+0x214>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   420d3:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   420d7:	7e 31                	jle    4210a <keyboard_readc+0x1f3>
   420d9:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   420e0:	7f 28                	jg     4210a <keyboard_readc+0x1f3>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   420e2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   420e5:	8d 50 80             	lea    -0x80(%rax),%edx
   420e8:	0f b6 05 f4 e2 00 00 	movzbl 0xe2f4(%rip),%eax        # 503e3 <modifiers.1>
   420ef:	0f b6 c0             	movzbl %al,%eax
   420f2:	83 e0 03             	and    $0x3,%eax
   420f5:	48 98                	cltq   
   420f7:	48 63 d2             	movslq %edx,%rdx
   420fa:	0f b6 84 90 c0 51 04 	movzbl 0x451c0(%rax,%rdx,4),%eax
   42101:	00 
   42102:	0f b6 c0             	movzbl %al,%eax
   42105:	89 45 fc             	mov    %eax,-0x4(%rbp)
   42108:	eb 21                	jmp    4212b <keyboard_readc+0x214>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   4210a:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   4210e:	7f 1b                	jg     4212b <keyboard_readc+0x214>
   42110:	0f b6 05 cc e2 00 00 	movzbl 0xe2cc(%rip),%eax        # 503e3 <modifiers.1>
   42117:	0f b6 c0             	movzbl %al,%eax
   4211a:	83 e0 02             	and    $0x2,%eax
   4211d:	85 c0                	test   %eax,%eax
   4211f:	74 0a                	je     4212b <keyboard_readc+0x214>
        ch = 0;
   42121:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42128:	eb 01                	jmp    4212b <keyboard_readc+0x214>
        if (modifiers & MOD_CONTROL) {
   4212a:	90                   	nop
    }

    return ch;
   4212b:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   4212e:	c9                   	leave  
   4212f:	c3                   	ret    

0000000000042130 <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   42130:	55                   	push   %rbp
   42131:	48 89 e5             	mov    %rsp,%rbp
   42134:	48 83 ec 20          	sub    $0x20,%rsp
   42138:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   4213f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   42142:	89 c2                	mov    %eax,%edx
   42144:	ec                   	in     (%dx),%al
   42145:	88 45 e3             	mov    %al,-0x1d(%rbp)
   42148:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   4214f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   42152:	89 c2                	mov    %eax,%edx
   42154:	ec                   	in     (%dx),%al
   42155:	88 45 eb             	mov    %al,-0x15(%rbp)
   42158:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   4215f:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42162:	89 c2                	mov    %eax,%edx
   42164:	ec                   	in     (%dx),%al
   42165:	88 45 f3             	mov    %al,-0xd(%rbp)
   42168:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   4216f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42172:	89 c2                	mov    %eax,%edx
   42174:	ec                   	in     (%dx),%al
   42175:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   42178:	90                   	nop
   42179:	c9                   	leave  
   4217a:	c3                   	ret    

000000000004217b <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   4217b:	55                   	push   %rbp
   4217c:	48 89 e5             	mov    %rsp,%rbp
   4217f:	48 83 ec 40          	sub    $0x40,%rsp
   42183:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42187:	89 f0                	mov    %esi,%eax
   42189:	89 55 c0             	mov    %edx,-0x40(%rbp)
   4218c:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   4218f:	8b 05 4f e2 00 00    	mov    0xe24f(%rip),%eax        # 503e4 <initialized.0>
   42195:	85 c0                	test   %eax,%eax
   42197:	75 1e                	jne    421b7 <parallel_port_putc+0x3c>
   42199:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   421a0:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421a4:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   421a8:	8b 55 f8             	mov    -0x8(%rbp),%edx
   421ab:	ee                   	out    %al,(%dx)
}
   421ac:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   421ad:	c7 05 2d e2 00 00 01 	movl   $0x1,0xe22d(%rip)        # 503e4 <initialized.0>
   421b4:	00 00 00 
    }

    for (int i = 0;
   421b7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   421be:	eb 09                	jmp    421c9 <parallel_port_putc+0x4e>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   421c0:	e8 6b ff ff ff       	call   42130 <delay>
         ++i) {
   421c5:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   421c9:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   421d0:	7f 18                	jg     421ea <parallel_port_putc+0x6f>
   421d2:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   421d9:	8b 45 f0             	mov    -0x10(%rbp),%eax
   421dc:	89 c2                	mov    %eax,%edx
   421de:	ec                   	in     (%dx),%al
   421df:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   421e2:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   421e6:	84 c0                	test   %al,%al
   421e8:	79 d6                	jns    421c0 <parallel_port_putc+0x45>
    }
    outb(IO_PARALLEL1_DATA, c);
   421ea:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   421ee:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   421f5:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421f8:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   421fc:	8b 55 d8             	mov    -0x28(%rbp),%edx
   421ff:	ee                   	out    %al,(%dx)
}
   42200:	90                   	nop
   42201:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   42208:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4220c:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   42210:	8b 55 e0             	mov    -0x20(%rbp),%edx
   42213:	ee                   	out    %al,(%dx)
}
   42214:	90                   	nop
   42215:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   4221c:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42220:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   42224:	8b 55 e8             	mov    -0x18(%rbp),%edx
   42227:	ee                   	out    %al,(%dx)
}
   42228:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   42229:	90                   	nop
   4222a:	c9                   	leave  
   4222b:	c3                   	ret    

000000000004222c <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   4222c:	55                   	push   %rbp
   4222d:	48 89 e5             	mov    %rsp,%rbp
   42230:	48 83 ec 20          	sub    $0x20,%rsp
   42234:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42238:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   4223c:	48 c7 45 f8 7b 21 04 	movq   $0x4217b,-0x8(%rbp)
   42243:	00 
    printer_vprintf(&p, 0, format, val);
   42244:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   42248:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   4224c:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   42250:	be 00 00 00 00       	mov    $0x0,%esi
   42255:	48 89 c7             	mov    %rax,%rdi
   42258:	e8 00 1d 00 00       	call   43f5d <printer_vprintf>
}
   4225d:	90                   	nop
   4225e:	c9                   	leave  
   4225f:	c3                   	ret    

0000000000042260 <log_printf>:

void log_printf(const char* format, ...) {
   42260:	55                   	push   %rbp
   42261:	48 89 e5             	mov    %rsp,%rbp
   42264:	48 83 ec 60          	sub    $0x60,%rsp
   42268:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   4226c:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42270:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42274:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42278:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4227c:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42280:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   42287:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4228b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   4228f:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42293:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   42297:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   4229b:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4229f:	48 89 d6             	mov    %rdx,%rsi
   422a2:	48 89 c7             	mov    %rax,%rdi
   422a5:	e8 82 ff ff ff       	call   4222c <log_vprintf>
    va_end(val);
}
   422aa:	90                   	nop
   422ab:	c9                   	leave  
   422ac:	c3                   	ret    

00000000000422ad <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   422ad:	55                   	push   %rbp
   422ae:	48 89 e5             	mov    %rsp,%rbp
   422b1:	48 83 ec 40          	sub    $0x40,%rsp
   422b5:	89 7d dc             	mov    %edi,-0x24(%rbp)
   422b8:	89 75 d8             	mov    %esi,-0x28(%rbp)
   422bb:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   422bf:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   422c3:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   422c7:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   422cb:	48 8b 0a             	mov    (%rdx),%rcx
   422ce:	48 89 08             	mov    %rcx,(%rax)
   422d1:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   422d5:	48 89 48 08          	mov    %rcx,0x8(%rax)
   422d9:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   422dd:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   422e1:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   422e5:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   422e9:	48 89 d6             	mov    %rdx,%rsi
   422ec:	48 89 c7             	mov    %rax,%rdi
   422ef:	e8 38 ff ff ff       	call   4222c <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   422f4:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   422f8:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   422fc:	8b 75 d8             	mov    -0x28(%rbp),%esi
   422ff:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42302:	89 c7                	mov    %eax,%edi
   42304:	e8 03 27 00 00       	call   44a0c <console_vprintf>
}
   42309:	c9                   	leave  
   4230a:	c3                   	ret    

000000000004230b <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   4230b:	55                   	push   %rbp
   4230c:	48 89 e5             	mov    %rsp,%rbp
   4230f:	48 83 ec 60          	sub    $0x60,%rsp
   42313:	89 7d ac             	mov    %edi,-0x54(%rbp)
   42316:	89 75 a8             	mov    %esi,-0x58(%rbp)
   42319:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   4231d:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42321:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42325:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42329:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   42330:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42334:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42338:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4233c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   42340:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   42344:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   42348:	8b 75 a8             	mov    -0x58(%rbp),%esi
   4234b:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4234e:	89 c7                	mov    %eax,%edi
   42350:	e8 58 ff ff ff       	call   422ad <error_vprintf>
   42355:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   42358:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   4235b:	c9                   	leave  
   4235c:	c3                   	ret    

000000000004235d <check_keyboard>:
//    Check for the user typing a control key. 'a', 'm', and 'c' cause a soft
//    reboot where the kernel runs the allocator programs, "malloc", or
//    "alloctests", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   4235d:	55                   	push   %rbp
   4235e:	48 89 e5             	mov    %rsp,%rbp
   42361:	53                   	push   %rbx
   42362:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   42366:	e8 ac fb ff ff       	call   41f17 <keyboard_readc>
   4236b:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'm' || c == 'c' || c == 't'|| c =='2') {
   4236e:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42372:	74 1c                	je     42390 <check_keyboard+0x33>
   42374:	83 7d e4 6d          	cmpl   $0x6d,-0x1c(%rbp)
   42378:	74 16                	je     42390 <check_keyboard+0x33>
   4237a:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   4237e:	74 10                	je     42390 <check_keyboard+0x33>
   42380:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42384:	74 0a                	je     42390 <check_keyboard+0x33>
   42386:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   4238a:	0f 85 e9 00 00 00    	jne    42479 <check_keyboard+0x11c>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   42390:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   42397:	00 
        memset(pt, 0, PAGESIZE * 3);
   42398:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4239c:	ba 00 30 00 00       	mov    $0x3000,%edx
   423a1:	be 00 00 00 00       	mov    $0x0,%esi
   423a6:	48 89 c7             	mov    %rax,%rdi
   423a9:	e8 13 19 00 00       	call   43cc1 <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   423ae:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   423b2:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   423b9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   423bd:	48 05 00 10 00 00    	add    $0x1000,%rax
   423c3:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   423ca:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   423ce:	48 05 00 20 00 00    	add    $0x2000,%rax
   423d4:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   423db:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   423df:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   423e3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   423e7:	0f 22 d8             	mov    %rax,%cr3
}
   423ea:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   423eb:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "malloc";
   423f2:	48 c7 45 e8 18 52 04 	movq   $0x45218,-0x18(%rbp)
   423f9:	00 
        if (c == 'a') {
   423fa:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   423fe:	75 0a                	jne    4240a <check_keyboard+0xad>
            argument = "allocator";
   42400:	48 c7 45 e8 1f 52 04 	movq   $0x4521f,-0x18(%rbp)
   42407:	00 
   42408:	eb 2e                	jmp    42438 <check_keyboard+0xdb>
        } else if (c == 'c') {
   4240a:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   4240e:	75 0a                	jne    4241a <check_keyboard+0xbd>
            argument = "alloctests";
   42410:	48 c7 45 e8 29 52 04 	movq   $0x45229,-0x18(%rbp)
   42417:	00 
   42418:	eb 1e                	jmp    42438 <check_keyboard+0xdb>
        } else if(c == 't'){
   4241a:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   4241e:	75 0a                	jne    4242a <check_keyboard+0xcd>
            argument = "test";
   42420:	48 c7 45 e8 34 52 04 	movq   $0x45234,-0x18(%rbp)
   42427:	00 
   42428:	eb 0e                	jmp    42438 <check_keyboard+0xdb>
        }
        else if(c == '2'){
   4242a:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   4242e:	75 08                	jne    42438 <check_keyboard+0xdb>
            argument = "test2";
   42430:	48 c7 45 e8 39 52 04 	movq   $0x45239,-0x18(%rbp)
   42437:	00 
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   42438:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4243c:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   42440:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42445:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   42449:	73 14                	jae    4245f <check_keyboard+0x102>
   4244b:	ba 3f 52 04 00       	mov    $0x4523f,%edx
   42450:	be 5c 02 00 00       	mov    $0x25c,%esi
   42455:	bf 5b 52 04 00       	mov    $0x4525b,%edi
   4245a:	e8 1f 01 00 00       	call   4257e <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   4245f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42463:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   42466:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   4246a:	48 89 c3             	mov    %rax,%rbx
   4246d:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   42472:	e9 89 db ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'm' || c == 'c' || c == 't'|| c =='2') {
   42477:	eb 11                	jmp    4248a <check_keyboard+0x12d>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   42479:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   4247d:	74 06                	je     42485 <check_keyboard+0x128>
   4247f:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   42483:	75 05                	jne    4248a <check_keyboard+0x12d>
        poweroff();
   42485:	e8 9d f8 ff ff       	call   41d27 <poweroff>
    }
    return c;
   4248a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   4248d:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42491:	c9                   	leave  
   42492:	c3                   	ret    

0000000000042493 <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   42493:	55                   	push   %rbp
   42494:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   42497:	e8 c1 fe ff ff       	call   4235d <check_keyboard>
   4249c:	eb f9                	jmp    42497 <fail+0x4>

000000000004249e <kernel_panic>:

// kernel_panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void kernel_panic(const char* format, ...) {
   4249e:	55                   	push   %rbp
   4249f:	48 89 e5             	mov    %rsp,%rbp
   424a2:	48 83 ec 60          	sub    $0x60,%rsp
   424a6:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   424aa:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   424ae:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   424b2:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   424b6:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   424ba:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   424be:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   424c5:	48 8d 45 10          	lea    0x10(%rbp),%rax
   424c9:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   424cd:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   424d1:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   424d5:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   424da:	0f 84 80 00 00 00    	je     42560 <kernel_panic+0xc2>
        // Print kernel_panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   424e0:	ba 6f 52 04 00       	mov    $0x4526f,%edx
   424e5:	be 00 c0 00 00       	mov    $0xc000,%esi
   424ea:	bf 30 07 00 00       	mov    $0x730,%edi
   424ef:	b8 00 00 00 00       	mov    $0x0,%eax
   424f4:	e8 12 fe ff ff       	call   4230b <error_printf>
   424f9:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   424fc:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   42500:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   42504:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42507:	be 00 c0 00 00       	mov    $0xc000,%esi
   4250c:	89 c7                	mov    %eax,%edi
   4250e:	e8 9a fd ff ff       	call   422ad <error_vprintf>
   42513:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   42516:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   42519:	48 63 c1             	movslq %ecx,%rax
   4251c:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   42523:	48 c1 e8 20          	shr    $0x20,%rax
   42527:	89 c2                	mov    %eax,%edx
   42529:	c1 fa 05             	sar    $0x5,%edx
   4252c:	89 c8                	mov    %ecx,%eax
   4252e:	c1 f8 1f             	sar    $0x1f,%eax
   42531:	29 c2                	sub    %eax,%edx
   42533:	89 d0                	mov    %edx,%eax
   42535:	c1 e0 02             	shl    $0x2,%eax
   42538:	01 d0                	add    %edx,%eax
   4253a:	c1 e0 04             	shl    $0x4,%eax
   4253d:	29 c1                	sub    %eax,%ecx
   4253f:	89 ca                	mov    %ecx,%edx
   42541:	85 d2                	test   %edx,%edx
   42543:	74 34                	je     42579 <kernel_panic+0xdb>
            error_printf(cpos, 0xC000, "\n");
   42545:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42548:	ba 77 52 04 00       	mov    $0x45277,%edx
   4254d:	be 00 c0 00 00       	mov    $0xc000,%esi
   42552:	89 c7                	mov    %eax,%edi
   42554:	b8 00 00 00 00       	mov    $0x0,%eax
   42559:	e8 ad fd ff ff       	call   4230b <error_printf>
   4255e:	eb 19                	jmp    42579 <kernel_panic+0xdb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   42560:	ba 79 52 04 00       	mov    $0x45279,%edx
   42565:	be 00 c0 00 00       	mov    $0xc000,%esi
   4256a:	bf 30 07 00 00       	mov    $0x730,%edi
   4256f:	b8 00 00 00 00       	mov    $0x0,%eax
   42574:	e8 92 fd ff ff       	call   4230b <error_printf>
    }

    va_end(val);
    fail();
   42579:	e8 15 ff ff ff       	call   42493 <fail>

000000000004257e <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   4257e:	55                   	push   %rbp
   4257f:	48 89 e5             	mov    %rsp,%rbp
   42582:	48 83 ec 20          	sub    $0x20,%rsp
   42586:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4258a:	89 75 f4             	mov    %esi,-0xc(%rbp)
   4258d:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    kernel_panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   42591:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   42595:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42598:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4259c:	48 89 c6             	mov    %rax,%rsi
   4259f:	bf 7f 52 04 00       	mov    $0x4527f,%edi
   425a4:	b8 00 00 00 00       	mov    $0x0,%eax
   425a9:	e8 f0 fe ff ff       	call   4249e <kernel_panic>

00000000000425ae <default_exception>:
}

void default_exception(proc* p){
   425ae:	55                   	push   %rbp
   425af:	48 89 e5             	mov    %rsp,%rbp
   425b2:	48 83 ec 20          	sub    $0x20,%rsp
   425b6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   425ba:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   425be:	48 83 c0 18          	add    $0x18,%rax
   425c2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    kernel_panic("Unexpected exception %d!\n", reg->reg_intno);
   425c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   425ca:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   425d1:	48 89 c6             	mov    %rax,%rsi
   425d4:	bf 9d 52 04 00       	mov    $0x4529d,%edi
   425d9:	b8 00 00 00 00       	mov    $0x0,%eax
   425de:	e8 bb fe ff ff       	call   4249e <kernel_panic>

00000000000425e3 <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   425e3:	55                   	push   %rbp
   425e4:	48 89 e5             	mov    %rsp,%rbp
   425e7:	48 83 ec 10          	sub    $0x10,%rsp
   425eb:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   425ef:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   425f2:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   425f6:	78 06                	js     425fe <pageindex+0x1b>
   425f8:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   425fc:	7e 14                	jle    42612 <pageindex+0x2f>
   425fe:	ba b8 52 04 00       	mov    $0x452b8,%edx
   42603:	be 1e 00 00 00       	mov    $0x1e,%esi
   42608:	bf d1 52 04 00       	mov    $0x452d1,%edi
   4260d:	e8 6c ff ff ff       	call   4257e <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   42612:	b8 03 00 00 00       	mov    $0x3,%eax
   42617:	2b 45 f4             	sub    -0xc(%rbp),%eax
   4261a:	89 c2                	mov    %eax,%edx
   4261c:	89 d0                	mov    %edx,%eax
   4261e:	c1 e0 03             	shl    $0x3,%eax
   42621:	01 d0                	add    %edx,%eax
   42623:	83 c0 0c             	add    $0xc,%eax
   42626:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4262a:	89 c1                	mov    %eax,%ecx
   4262c:	48 d3 ea             	shr    %cl,%rdx
   4262f:	48 89 d0             	mov    %rdx,%rax
   42632:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   42637:	c9                   	leave  
   42638:	c3                   	ret    

0000000000042639 <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   42639:	55                   	push   %rbp
   4263a:	48 89 e5             	mov    %rsp,%rbp
   4263d:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   42641:	48 c7 05 b4 e9 00 00 	movq   $0x52000,0xe9b4(%rip)        # 51000 <kernel_pagetable>
   42648:	00 20 05 00 
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   4264c:	ba 00 50 00 00       	mov    $0x5000,%edx
   42651:	be 00 00 00 00       	mov    $0x0,%esi
   42656:	bf 00 20 05 00       	mov    $0x52000,%edi
   4265b:	e8 61 16 00 00       	call   43cc1 <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   42660:	b8 00 30 05 00       	mov    $0x53000,%eax
   42665:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   42669:	48 89 05 90 f9 00 00 	mov    %rax,0xf990(%rip)        # 52000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   42670:	b8 00 40 05 00       	mov    $0x54000,%eax
   42675:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   42679:	48 89 05 80 09 01 00 	mov    %rax,0x10980(%rip)        # 53000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   42680:	b8 00 50 05 00       	mov    $0x55000,%eax
   42685:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   42689:	48 89 05 70 19 01 00 	mov    %rax,0x11970(%rip)        # 54000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   42690:	b8 00 60 05 00       	mov    $0x56000,%eax
   42695:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   42699:	48 89 05 68 19 01 00 	mov    %rax,0x11968(%rip)        # 54008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   426a0:	48 8b 05 59 e9 00 00 	mov    0xe959(%rip),%rax        # 51000 <kernel_pagetable>
   426a7:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   426ad:	b9 00 00 20 00       	mov    $0x200000,%ecx
   426b2:	ba 00 00 00 00       	mov    $0x0,%edx
   426b7:	be 00 00 00 00       	mov    $0x0,%esi
   426bc:	48 89 c7             	mov    %rax,%rdi
   426bf:	e8 b9 01 00 00       	call   4287d <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   426c4:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   426cb:	00 
   426cc:	eb 62                	jmp    42730 <virtual_memory_init+0xf7>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   426ce:	48 8b 0d 2b e9 00 00 	mov    0xe92b(%rip),%rcx        # 51000 <kernel_pagetable>
   426d5:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   426d9:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   426dd:	48 89 ce             	mov    %rcx,%rsi
   426e0:	48 89 c7             	mov    %rax,%rdi
   426e3:	e8 58 05 00 00       	call   42c40 <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l4pagetable ?
        assert(vmap.pa == addr);
   426e8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   426ec:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   426f0:	74 14                	je     42706 <virtual_memory_init+0xcd>
   426f2:	ba e5 52 04 00       	mov    $0x452e5,%edx
   426f7:	be 2d 00 00 00       	mov    $0x2d,%esi
   426fc:	bf f5 52 04 00       	mov    $0x452f5,%edi
   42701:	e8 78 fe ff ff       	call   4257e <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   42706:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42709:	48 98                	cltq   
   4270b:	83 e0 03             	and    $0x3,%eax
   4270e:	48 83 f8 03          	cmp    $0x3,%rax
   42712:	74 14                	je     42728 <virtual_memory_init+0xef>
   42714:	ba 08 53 04 00       	mov    $0x45308,%edx
   42719:	be 2e 00 00 00       	mov    $0x2e,%esi
   4271e:	bf f5 52 04 00       	mov    $0x452f5,%edi
   42723:	e8 56 fe ff ff       	call   4257e <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42728:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4272f:	00 
   42730:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   42737:	00 
   42738:	76 94                	jbe    426ce <virtual_memory_init+0x95>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   4273a:	48 8b 05 bf e8 00 00 	mov    0xe8bf(%rip),%rax        # 51000 <kernel_pagetable>
   42741:	48 89 c7             	mov    %rax,%rdi
   42744:	e8 03 00 00 00       	call   4274c <set_pagetable>
}
   42749:	90                   	nop
   4274a:	c9                   	leave  
   4274b:	c3                   	ret    

000000000004274c <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls kernel_panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   4274c:	55                   	push   %rbp
   4274d:	48 89 e5             	mov    %rsp,%rbp
   42750:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   42754:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   42758:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   4275c:	25 ff 0f 00 00       	and    $0xfff,%eax
   42761:	48 85 c0             	test   %rax,%rax
   42764:	74 14                	je     4277a <set_pagetable+0x2e>
   42766:	ba 35 53 04 00       	mov    $0x45335,%edx
   4276b:	be 3d 00 00 00       	mov    $0x3d,%esi
   42770:	bf f5 52 04 00       	mov    $0x452f5,%edi
   42775:	e8 04 fe ff ff       	call   4257e <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   4277a:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   4277f:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   42783:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42787:	48 89 ce             	mov    %rcx,%rsi
   4278a:	48 89 c7             	mov    %rax,%rdi
   4278d:	e8 ae 04 00 00       	call   42c40 <virtual_memory_lookup>
   42792:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42796:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   4279b:	48 39 d0             	cmp    %rdx,%rax
   4279e:	74 14                	je     427b4 <set_pagetable+0x68>
   427a0:	ba 50 53 04 00       	mov    $0x45350,%edx
   427a5:	be 3f 00 00 00       	mov    $0x3f,%esi
   427aa:	bf f5 52 04 00       	mov    $0x452f5,%edi
   427af:	e8 ca fd ff ff       	call   4257e <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   427b4:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   427b8:	48 8b 0d 41 e8 00 00 	mov    0xe841(%rip),%rcx        # 51000 <kernel_pagetable>
   427bf:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   427c3:	48 89 ce             	mov    %rcx,%rsi
   427c6:	48 89 c7             	mov    %rax,%rdi
   427c9:	e8 72 04 00 00       	call   42c40 <virtual_memory_lookup>
   427ce:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   427d2:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   427d6:	48 39 c2             	cmp    %rax,%rdx
   427d9:	74 14                	je     427ef <set_pagetable+0xa3>
   427db:	ba b8 53 04 00       	mov    $0x453b8,%edx
   427e0:	be 41 00 00 00       	mov    $0x41,%esi
   427e5:	bf f5 52 04 00       	mov    $0x452f5,%edi
   427ea:	e8 8f fd ff ff       	call   4257e <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   427ef:	48 8b 05 0a e8 00 00 	mov    0xe80a(%rip),%rax        # 51000 <kernel_pagetable>
   427f6:	48 89 c2             	mov    %rax,%rdx
   427f9:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   427fd:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42801:	48 89 ce             	mov    %rcx,%rsi
   42804:	48 89 c7             	mov    %rax,%rdi
   42807:	e8 34 04 00 00       	call   42c40 <virtual_memory_lookup>
   4280c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42810:	48 8b 15 e9 e7 00 00 	mov    0xe7e9(%rip),%rdx        # 51000 <kernel_pagetable>
   42817:	48 39 d0             	cmp    %rdx,%rax
   4281a:	74 14                	je     42830 <set_pagetable+0xe4>
   4281c:	ba 18 54 04 00       	mov    $0x45418,%edx
   42821:	be 43 00 00 00       	mov    $0x43,%esi
   42826:	bf f5 52 04 00       	mov    $0x452f5,%edi
   4282b:	e8 4e fd ff ff       	call   4257e <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   42830:	ba 7d 28 04 00       	mov    $0x4287d,%edx
   42835:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42839:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   4283d:	48 89 ce             	mov    %rcx,%rsi
   42840:	48 89 c7             	mov    %rax,%rdi
   42843:	e8 f8 03 00 00       	call   42c40 <virtual_memory_lookup>
   42848:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4284c:	ba 7d 28 04 00       	mov    $0x4287d,%edx
   42851:	48 39 d0             	cmp    %rdx,%rax
   42854:	74 14                	je     4286a <set_pagetable+0x11e>
   42856:	ba 80 54 04 00       	mov    $0x45480,%edx
   4285b:	be 45 00 00 00       	mov    $0x45,%esi
   42860:	bf f5 52 04 00       	mov    $0x452f5,%edi
   42865:	e8 14 fd ff ff       	call   4257e <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   4286a:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   4286e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42872:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42876:	0f 22 d8             	mov    %rax,%cr3
}
   42879:	90                   	nop
}
   4287a:	90                   	nop
   4287b:	c9                   	leave  
   4287c:	c3                   	ret    

000000000004287d <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   4287d:	55                   	push   %rbp
   4287e:	48 89 e5             	mov    %rsp,%rbp
   42881:	53                   	push   %rbx
   42882:	48 83 ec 58          	sub    $0x58,%rsp
   42886:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   4288a:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   4288e:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   42892:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
   42896:	44 89 45 ac          	mov    %r8d,-0x54(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   4289a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4289e:	25 ff 0f 00 00       	and    $0xfff,%eax
   428a3:	48 85 c0             	test   %rax,%rax
   428a6:	74 14                	je     428bc <virtual_memory_map+0x3f>
   428a8:	ba e6 54 04 00       	mov    $0x454e6,%edx
   428ad:	be 66 00 00 00       	mov    $0x66,%esi
   428b2:	bf f5 52 04 00       	mov    $0x452f5,%edi
   428b7:	e8 c2 fc ff ff       	call   4257e <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   428bc:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   428c0:	25 ff 0f 00 00       	and    $0xfff,%eax
   428c5:	48 85 c0             	test   %rax,%rax
   428c8:	74 14                	je     428de <virtual_memory_map+0x61>
   428ca:	ba f9 54 04 00       	mov    $0x454f9,%edx
   428cf:	be 67 00 00 00       	mov    $0x67,%esi
   428d4:	bf f5 52 04 00       	mov    $0x452f5,%edi
   428d9:	e8 a0 fc ff ff       	call   4257e <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   428de:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   428e2:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   428e6:	48 01 d0             	add    %rdx,%rax
   428e9:	48 3b 45 c0          	cmp    -0x40(%rbp),%rax
   428ed:	73 24                	jae    42913 <virtual_memory_map+0x96>
   428ef:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   428f3:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   428f7:	48 01 d0             	add    %rdx,%rax
   428fa:	48 85 c0             	test   %rax,%rax
   428fd:	74 14                	je     42913 <virtual_memory_map+0x96>
   428ff:	ba 0c 55 04 00       	mov    $0x4550c,%edx
   42904:	be 68 00 00 00       	mov    $0x68,%esi
   42909:	bf f5 52 04 00       	mov    $0x452f5,%edi
   4290e:	e8 6b fc ff ff       	call   4257e <assert_fail>
    if (perm & PTE_P) {
   42913:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42916:	48 98                	cltq   
   42918:	83 e0 01             	and    $0x1,%eax
   4291b:	48 85 c0             	test   %rax,%rax
   4291e:	74 6e                	je     4298e <virtual_memory_map+0x111>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   42920:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42924:	25 ff 0f 00 00       	and    $0xfff,%eax
   42929:	48 85 c0             	test   %rax,%rax
   4292c:	74 14                	je     42942 <virtual_memory_map+0xc5>
   4292e:	ba 2a 55 04 00       	mov    $0x4552a,%edx
   42933:	be 6a 00 00 00       	mov    $0x6a,%esi
   42938:	bf f5 52 04 00       	mov    $0x452f5,%edi
   4293d:	e8 3c fc ff ff       	call   4257e <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   42942:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42946:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   4294a:	48 01 d0             	add    %rdx,%rax
   4294d:	48 3b 45 b8          	cmp    -0x48(%rbp),%rax
   42951:	73 14                	jae    42967 <virtual_memory_map+0xea>
   42953:	ba 3d 55 04 00       	mov    $0x4553d,%edx
   42958:	be 6b 00 00 00       	mov    $0x6b,%esi
   4295d:	bf f5 52 04 00       	mov    $0x452f5,%edi
   42962:	e8 17 fc ff ff       	call   4257e <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   42967:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   4296b:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   4296f:	48 01 d0             	add    %rdx,%rax
   42972:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   42978:	76 14                	jbe    4298e <virtual_memory_map+0x111>
   4297a:	ba 4b 55 04 00       	mov    $0x4554b,%edx
   4297f:	be 6c 00 00 00       	mov    $0x6c,%esi
   42984:	bf f5 52 04 00       	mov    $0x452f5,%edi
   42989:	e8 f0 fb ff ff       	call   4257e <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   4298e:	83 7d ac 00          	cmpl   $0x0,-0x54(%rbp)
   42992:	78 09                	js     4299d <virtual_memory_map+0x120>
   42994:	81 7d ac ff 0f 00 00 	cmpl   $0xfff,-0x54(%rbp)
   4299b:	7e 14                	jle    429b1 <virtual_memory_map+0x134>
   4299d:	ba 67 55 04 00       	mov    $0x45567,%edx
   429a2:	be 6e 00 00 00       	mov    $0x6e,%esi
   429a7:	bf f5 52 04 00       	mov    $0x452f5,%edi
   429ac:	e8 cd fb ff ff       	call   4257e <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   429b1:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   429b5:	25 ff 0f 00 00       	and    $0xfff,%eax
   429ba:	48 85 c0             	test   %rax,%rax
   429bd:	74 14                	je     429d3 <virtual_memory_map+0x156>
   429bf:	ba 88 55 04 00       	mov    $0x45588,%edx
   429c4:	be 6f 00 00 00       	mov    $0x6f,%esi
   429c9:	bf f5 52 04 00       	mov    $0x452f5,%edi
   429ce:	e8 ab fb ff ff       	call   4257e <assert_fail>

    int last_index123 = -1;
   429d3:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%rbp)
    x86_64_pagetable* l4pagetable = NULL;
   429da:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
   429e1:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   429e2:	e9 e1 00 00 00       	jmp    42ac8 <virtual_memory_map+0x24b>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   429e7:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   429eb:	48 c1 e8 15          	shr    $0x15,%rax
   429ef:	89 45 dc             	mov    %eax,-0x24(%rbp)
        if (cur_index123 != last_index123) {
   429f2:	8b 45 dc             	mov    -0x24(%rbp),%eax
   429f5:	3b 45 ec             	cmp    -0x14(%rbp),%eax
   429f8:	74 20                	je     42a1a <virtual_memory_map+0x19d>
            // find pointer to last level pagetable for current va
            l4pagetable = lookup_l4pagetable(pagetable, va, perm);
   429fa:	8b 55 ac             	mov    -0x54(%rbp),%edx
   429fd:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   42a01:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42a05:	48 89 ce             	mov    %rcx,%rsi
   42a08:	48 89 c7             	mov    %rax,%rdi
   42a0b:	e8 ce 00 00 00       	call   42ade <lookup_l4pagetable>
   42a10:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            last_index123 = cur_index123;
   42a14:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42a17:	89 45 ec             	mov    %eax,-0x14(%rbp)
        }
        if ((perm & PTE_P) && l4pagetable) { // if page is marked present
   42a1a:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42a1d:	48 98                	cltq   
   42a1f:	83 e0 01             	and    $0x1,%eax
   42a22:	48 85 c0             	test   %rax,%rax
   42a25:	74 34                	je     42a5b <virtual_memory_map+0x1de>
   42a27:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42a2c:	74 2d                	je     42a5b <virtual_memory_map+0x1de>
            // set page table entry to pa and perm
            l4pagetable->entry[L4PAGEINDEX(va)] = pa | perm;
   42a2e:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42a31:	48 63 d8             	movslq %eax,%rbx
   42a34:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42a38:	be 03 00 00 00       	mov    $0x3,%esi
   42a3d:	48 89 c7             	mov    %rax,%rdi
   42a40:	e8 9e fb ff ff       	call   425e3 <pageindex>
   42a45:	89 c2                	mov    %eax,%edx
   42a47:	48 0b 5d b8          	or     -0x48(%rbp),%rbx
   42a4b:	48 89 d9             	mov    %rbx,%rcx
   42a4e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42a52:	48 63 d2             	movslq %edx,%rdx
   42a55:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42a59:	eb 55                	jmp    42ab0 <virtual_memory_map+0x233>
        } else if (l4pagetable) { // if page is NOT marked present
   42a5b:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42a60:	74 26                	je     42a88 <virtual_memory_map+0x20b>
            // set page table entry to just perm
            l4pagetable->entry[L4PAGEINDEX(va)] = perm;
   42a62:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42a66:	be 03 00 00 00       	mov    $0x3,%esi
   42a6b:	48 89 c7             	mov    %rax,%rdi
   42a6e:	e8 70 fb ff ff       	call   425e3 <pageindex>
   42a73:	89 c2                	mov    %eax,%edx
   42a75:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42a78:	48 63 c8             	movslq %eax,%rcx
   42a7b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42a7f:	48 63 d2             	movslq %edx,%rdx
   42a82:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42a86:	eb 28                	jmp    42ab0 <virtual_memory_map+0x233>
        } else if (perm & PTE_P) {
   42a88:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42a8b:	48 98                	cltq   
   42a8d:	83 e0 01             	and    $0x1,%eax
   42a90:	48 85 c0             	test   %rax,%rax
   42a93:	74 1b                	je     42ab0 <virtual_memory_map+0x233>
            // error, no allocated l4 page found for va
            log_printf("[Kern Info] failed to find l4pagetable address at " __FILE__ ": %d\n", __LINE__);
   42a95:	be 84 00 00 00       	mov    $0x84,%esi
   42a9a:	bf b0 55 04 00       	mov    $0x455b0,%edi
   42a9f:	b8 00 00 00 00       	mov    $0x0,%eax
   42aa4:	e8 b7 f7 ff ff       	call   42260 <log_printf>
            return -1;
   42aa9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42aae:	eb 28                	jmp    42ad8 <virtual_memory_map+0x25b>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42ab0:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
   42ab7:	00 
   42ab8:	48 81 45 b8 00 10 00 	addq   $0x1000,-0x48(%rbp)
   42abf:	00 
   42ac0:	48 81 6d b0 00 10 00 	subq   $0x1000,-0x50(%rbp)
   42ac7:	00 
   42ac8:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   42acd:	0f 85 14 ff ff ff    	jne    429e7 <virtual_memory_map+0x16a>
        }
    }
    return 0;
   42ad3:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42ad8:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42adc:	c9                   	leave  
   42add:	c3                   	ret    

0000000000042ade <lookup_l4pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   42ade:	55                   	push   %rbp
   42adf:	48 89 e5             	mov    %rsp,%rbp
   42ae2:	48 83 ec 40          	sub    $0x40,%rsp
   42ae6:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42aea:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42aee:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   42af1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42af5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l4 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   42af9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   42b00:	e9 2b 01 00 00       	jmp    42c30 <lookup_l4pagetable+0x152>
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        x86_64_pageentry_t pe = pt->entry[PAGEINDEX(va, i)];
   42b05:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42b08:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42b0c:	89 d6                	mov    %edx,%esi
   42b0e:	48 89 c7             	mov    %rax,%rdi
   42b11:	e8 cd fa ff ff       	call   425e3 <pageindex>
   42b16:	89 c2                	mov    %eax,%edx
   42b18:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42b1c:	48 63 d2             	movslq %edx,%rdx
   42b1f:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   42b23:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   42b27:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b2b:	83 e0 01             	and    $0x1,%eax
   42b2e:	48 85 c0             	test   %rax,%rax
   42b31:	75 63                	jne    42b96 <lookup_l4pagetable+0xb8>
            log_printf("[Kern Info] Error looking up l4pagetable: Pagetable address: 0x%x perm: 0x%x."
   42b33:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42b36:	8d 48 02             	lea    0x2(%rax),%ecx
   42b39:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b3d:	25 ff 0f 00 00       	and    $0xfff,%eax
   42b42:	48 89 c2             	mov    %rax,%rdx
   42b45:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b49:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42b4f:	48 89 c6             	mov    %rax,%rsi
   42b52:	bf f8 55 04 00       	mov    $0x455f8,%edi
   42b57:	b8 00 00 00 00       	mov    $0x0,%eax
   42b5c:	e8 ff f6 ff ff       	call   42260 <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   42b61:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42b64:	48 98                	cltq   
   42b66:	83 e0 01             	and    $0x1,%eax
   42b69:	48 85 c0             	test   %rax,%rax
   42b6c:	75 0a                	jne    42b78 <lookup_l4pagetable+0x9a>
                return NULL;
   42b6e:	b8 00 00 00 00       	mov    $0x0,%eax
   42b73:	e9 c6 00 00 00       	jmp    42c3e <lookup_l4pagetable+0x160>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   42b78:	be a7 00 00 00       	mov    $0xa7,%esi
   42b7d:	bf 60 56 04 00       	mov    $0x45660,%edi
   42b82:	b8 00 00 00 00       	mov    $0x0,%eax
   42b87:	e8 d4 f6 ff ff       	call   42260 <log_printf>
            return NULL;
   42b8c:	b8 00 00 00 00       	mov    $0x0,%eax
   42b91:	e9 a8 00 00 00       	jmp    42c3e <lookup_l4pagetable+0x160>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   42b96:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b9a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42ba0:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   42ba6:	76 14                	jbe    42bbc <lookup_l4pagetable+0xde>
   42ba8:	ba a8 56 04 00       	mov    $0x456a8,%edx
   42bad:	be ac 00 00 00       	mov    $0xac,%esi
   42bb2:	bf f5 52 04 00       	mov    $0x452f5,%edi
   42bb7:	e8 c2 f9 ff ff       	call   4257e <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   42bbc:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42bbf:	48 98                	cltq   
   42bc1:	83 e0 02             	and    $0x2,%eax
   42bc4:	48 85 c0             	test   %rax,%rax
   42bc7:	74 20                	je     42be9 <lookup_l4pagetable+0x10b>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   42bc9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42bcd:	83 e0 02             	and    $0x2,%eax
   42bd0:	48 85 c0             	test   %rax,%rax
   42bd3:	75 14                	jne    42be9 <lookup_l4pagetable+0x10b>
   42bd5:	ba c8 56 04 00       	mov    $0x456c8,%edx
   42bda:	be ae 00 00 00       	mov    $0xae,%esi
   42bdf:	bf f5 52 04 00       	mov    $0x452f5,%edi
   42be4:	e8 95 f9 ff ff       	call   4257e <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   42be9:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42bec:	48 98                	cltq   
   42bee:	83 e0 04             	and    $0x4,%eax
   42bf1:	48 85 c0             	test   %rax,%rax
   42bf4:	74 20                	je     42c16 <lookup_l4pagetable+0x138>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   42bf6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42bfa:	83 e0 04             	and    $0x4,%eax
   42bfd:	48 85 c0             	test   %rax,%rax
   42c00:	75 14                	jne    42c16 <lookup_l4pagetable+0x138>
   42c02:	ba d3 56 04 00       	mov    $0x456d3,%edx
   42c07:	be b1 00 00 00       	mov    $0xb1,%esi
   42c0c:	bf f5 52 04 00       	mov    $0x452f5,%edi
   42c11:	e8 68 f9 ff ff       	call   4257e <assert_fail>
        }

        // set pt to physical address to next pagetable using `pe`
        pt = 0; // replace this
   42c16:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42c1d:	00 
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42c1e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c22:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42c28:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   42c2c:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   42c30:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   42c34:	0f 8e cb fe ff ff    	jle    42b05 <lookup_l4pagetable+0x27>
    }
    return pt;
   42c3a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   42c3e:	c9                   	leave  
   42c3f:	c3                   	ret    

0000000000042c40 <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   42c40:	55                   	push   %rbp
   42c41:	48 89 e5             	mov    %rsp,%rbp
   42c44:	48 83 ec 50          	sub    $0x50,%rsp
   42c48:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42c4c:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42c50:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   42c54:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42c58:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   42c5c:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   42c63:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42c64:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   42c6b:	eb 41                	jmp    42cae <virtual_memory_lookup+0x6e>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   42c6d:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42c70:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42c74:	89 d6                	mov    %edx,%esi
   42c76:	48 89 c7             	mov    %rax,%rdi
   42c79:	e8 65 f9 ff ff       	call   425e3 <pageindex>
   42c7e:	89 c2                	mov    %eax,%edx
   42c80:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42c84:	48 63 d2             	movslq %edx,%rdx
   42c87:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   42c8b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c8f:	83 e0 06             	and    $0x6,%eax
   42c92:	48 f7 d0             	not    %rax
   42c95:	48 21 d0             	and    %rdx,%rax
   42c98:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42c9c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ca0:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42ca6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42caa:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   42cae:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   42cb2:	7f 0c                	jg     42cc0 <virtual_memory_lookup+0x80>
   42cb4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42cb8:	83 e0 01             	and    $0x1,%eax
   42cbb:	48 85 c0             	test   %rax,%rax
   42cbe:	75 ad                	jne    42c6d <virtual_memory_lookup+0x2d>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   42cc0:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   42cc7:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   42cce:	ff 
   42ccf:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   42cd6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42cda:	83 e0 01             	and    $0x1,%eax
   42cdd:	48 85 c0             	test   %rax,%rax
   42ce0:	74 34                	je     42d16 <virtual_memory_lookup+0xd6>
        vam.pn = PAGENUMBER(pe);
   42ce2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ce6:	48 c1 e8 0c          	shr    $0xc,%rax
   42cea:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   42ced:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42cf1:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42cf7:	48 89 c2             	mov    %rax,%rdx
   42cfa:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42cfe:	25 ff 0f 00 00       	and    $0xfff,%eax
   42d03:	48 09 d0             	or     %rdx,%rax
   42d06:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   42d0a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d0e:	25 ff 0f 00 00       	and    $0xfff,%eax
   42d13:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   42d16:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42d1a:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42d1e:	48 89 10             	mov    %rdx,(%rax)
   42d21:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   42d25:	48 89 50 08          	mov    %rdx,0x8(%rax)
   42d29:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42d2d:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   42d31:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42d35:	c9                   	leave  
   42d36:	c3                   	ret    

0000000000042d37 <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   42d37:	55                   	push   %rbp
   42d38:	48 89 e5             	mov    %rsp,%rbp
   42d3b:	48 83 ec 40          	sub    $0x40,%rsp
   42d3f:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42d43:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   42d46:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   42d4a:	c7 45 f8 04 00 00 00 	movl   $0x4,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   42d51:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   42d55:	78 08                	js     42d5f <program_load+0x28>
   42d57:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42d5a:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   42d5d:	7c 14                	jl     42d73 <program_load+0x3c>
   42d5f:	ba e0 56 04 00       	mov    $0x456e0,%edx
   42d64:	be 2e 00 00 00       	mov    $0x2e,%esi
   42d69:	bf 10 57 04 00       	mov    $0x45710,%edi
   42d6e:	e8 0b f8 ff ff       	call   4257e <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   42d73:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42d76:	48 98                	cltq   
   42d78:	48 c1 e0 04          	shl    $0x4,%rax
   42d7c:	48 05 20 60 04 00    	add    $0x46020,%rax
   42d82:	48 8b 00             	mov    (%rax),%rax
   42d85:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   42d89:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d8d:	8b 00                	mov    (%rax),%eax
   42d8f:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   42d94:	74 14                	je     42daa <program_load+0x73>
   42d96:	ba 22 57 04 00       	mov    $0x45722,%edx
   42d9b:	be 30 00 00 00       	mov    $0x30,%esi
   42da0:	bf 10 57 04 00       	mov    $0x45710,%edi
   42da5:	e8 d4 f7 ff ff       	call   4257e <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   42daa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42dae:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42db2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42db6:	48 01 d0             	add    %rdx,%rax
   42db9:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   42dbd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42dc4:	e9 94 00 00 00       	jmp    42e5d <program_load+0x126>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   42dc9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42dcc:	48 63 d0             	movslq %eax,%rdx
   42dcf:	48 89 d0             	mov    %rdx,%rax
   42dd2:	48 c1 e0 03          	shl    $0x3,%rax
   42dd6:	48 29 d0             	sub    %rdx,%rax
   42dd9:	48 c1 e0 03          	shl    $0x3,%rax
   42ddd:	48 89 c2             	mov    %rax,%rdx
   42de0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42de4:	48 01 d0             	add    %rdx,%rax
   42de7:	8b 00                	mov    (%rax),%eax
   42de9:	83 f8 01             	cmp    $0x1,%eax
   42dec:	75 6b                	jne    42e59 <program_load+0x122>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   42dee:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42df1:	48 63 d0             	movslq %eax,%rdx
   42df4:	48 89 d0             	mov    %rdx,%rax
   42df7:	48 c1 e0 03          	shl    $0x3,%rax
   42dfb:	48 29 d0             	sub    %rdx,%rax
   42dfe:	48 c1 e0 03          	shl    $0x3,%rax
   42e02:	48 89 c2             	mov    %rax,%rdx
   42e05:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42e09:	48 01 d0             	add    %rdx,%rax
   42e0c:	48 8b 50 08          	mov    0x8(%rax),%rdx
   42e10:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e14:	48 01 d0             	add    %rdx,%rax
   42e17:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   42e1b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42e1e:	48 63 d0             	movslq %eax,%rdx
   42e21:	48 89 d0             	mov    %rdx,%rax
   42e24:	48 c1 e0 03          	shl    $0x3,%rax
   42e28:	48 29 d0             	sub    %rdx,%rax
   42e2b:	48 c1 e0 03          	shl    $0x3,%rax
   42e2f:	48 89 c2             	mov    %rax,%rdx
   42e32:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42e36:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   42e3a:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42e3e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42e42:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e46:	48 89 c7             	mov    %rax,%rdi
   42e49:	e8 3d 00 00 00       	call   42e8b <program_load_segment>
   42e4e:	85 c0                	test   %eax,%eax
   42e50:	79 07                	jns    42e59 <program_load+0x122>
                return -1;
   42e52:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42e57:	eb 30                	jmp    42e89 <program_load+0x152>
    for (int i = 0; i < eh->e_phnum; ++i) {
   42e59:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   42e5d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e61:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   42e65:	0f b7 c0             	movzwl %ax,%eax
   42e68:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   42e6b:	0f 8c 58 ff ff ff    	jl     42dc9 <program_load+0x92>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   42e71:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e75:	48 8b 50 18          	mov    0x18(%rax),%rdx
   42e79:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e7d:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    return 0;
   42e84:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42e89:	c9                   	leave  
   42e8a:	c3                   	ret    

0000000000042e8b <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   42e8b:	55                   	push   %rbp
   42e8c:	48 89 e5             	mov    %rsp,%rbp
   42e8f:	48 83 ec 70          	sub    $0x70,%rsp
   42e93:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42e97:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   42e9b:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   42e9f:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   42ea3:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42ea7:	48 8b 40 10          	mov    0x10(%rax),%rax
   42eab:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   42eaf:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42eb3:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42eb7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ebb:	48 01 d0             	add    %rdx,%rax
   42ebe:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   42ec2:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42ec6:	48 8b 50 28          	mov    0x28(%rax),%rdx
   42eca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ece:	48 01 d0             	add    %rdx,%rax
   42ed1:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   42ed5:	48 81 65 e8 00 f0 ff 	andq   $0xfffffffffffff000,-0x18(%rbp)
   42edc:	ff 


    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42edd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ee1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   42ee5:	eb 7c                	jmp    42f63 <program_load_segment+0xd8>
        uintptr_t pa = (uintptr_t)palloc(p->p_pid);
   42ee7:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42eeb:	8b 00                	mov    (%rax),%eax
   42eed:	89 c7                	mov    %eax,%edi
   42eef:	e8 9b 01 00 00       	call   4308f <palloc>
   42ef4:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        if(pa == (uintptr_t)NULL || virtual_memory_map(p->p_pagetable, addr, pa, PAGESIZE,
   42ef8:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
   42efd:	74 2a                	je     42f29 <program_load_segment+0x9e>
   42eff:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42f03:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   42f0a:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42f0e:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   42f12:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42f18:	b9 00 10 00 00       	mov    $0x1000,%ecx
   42f1d:	48 89 c7             	mov    %rax,%rdi
   42f20:	e8 58 f9 ff ff       	call   4287d <virtual_memory_map>
   42f25:	85 c0                	test   %eax,%eax
   42f27:	79 32                	jns    42f5b <program_load_segment+0xd0>
                    PTE_W | PTE_P | PTE_U) < 0) {
            console_printf(CPOS(22, 0), 0xC000,
   42f29:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42f2d:	8b 00                	mov    (%rax),%eax
   42f2f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42f33:	49 89 d0             	mov    %rdx,%r8
   42f36:	89 c1                	mov    %eax,%ecx
   42f38:	ba 40 57 04 00       	mov    $0x45740,%edx
   42f3d:	be 00 c0 00 00       	mov    $0xc000,%esi
   42f42:	bf e0 06 00 00       	mov    $0x6e0,%edi
   42f47:	b8 00 00 00 00       	mov    $0x0,%eax
   42f4c:	e8 27 1b 00 00       	call   44a78 <console_printf>
                    "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
            return -1;
   42f51:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42f56:	e9 32 01 00 00       	jmp    4308d <program_load_segment+0x202>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42f5b:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42f62:	00 
   42f63:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42f67:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   42f6b:	0f 82 76 ff ff ff    	jb     42ee7 <program_load_segment+0x5c>
        }
    }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   42f71:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42f75:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   42f7c:	48 89 c7             	mov    %rax,%rdi
   42f7f:	e8 c8 f7 ff ff       	call   4274c <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   42f84:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42f88:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   42f8c:	48 89 c2             	mov    %rax,%rdx
   42f8f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f93:	48 8b 4d 98          	mov    -0x68(%rbp),%rcx
   42f97:	48 89 ce             	mov    %rcx,%rsi
   42f9a:	48 89 c7             	mov    %rax,%rdi
   42f9d:	e8 21 0c 00 00       	call   43bc3 <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   42fa2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42fa6:	48 2b 45 e0          	sub    -0x20(%rbp),%rax
   42faa:	48 89 c2             	mov    %rax,%rdx
   42fad:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42fb1:	be 00 00 00 00       	mov    $0x0,%esi
   42fb6:	48 89 c7             	mov    %rax,%rdi
   42fb9:	e8 03 0d 00 00       	call   43cc1 <memset>

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   42fbe:	48 8b 05 3b e0 00 00 	mov    0xe03b(%rip),%rax        # 51000 <kernel_pagetable>
   42fc5:	48 89 c7             	mov    %rax,%rdi
   42fc8:	e8 7f f7 ff ff       	call   4274c <set_pagetable>


    if((ph->p_flags & ELF_PFLAG_WRITE) == 0) {
   42fcd:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42fd1:	8b 40 04             	mov    0x4(%rax),%eax
   42fd4:	83 e0 02             	and    $0x2,%eax
   42fd7:	85 c0                	test   %eax,%eax
   42fd9:	75 60                	jne    4303b <program_load_segment+0x1b0>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42fdb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42fdf:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   42fe3:	eb 4c                	jmp    43031 <program_load_segment+0x1a6>
            vamapping mapping = virtual_memory_lookup(p->p_pagetable, addr);
   42fe5:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42fe9:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   42ff0:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   42ff4:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   42ff8:	48 89 ce             	mov    %rcx,%rsi
   42ffb:	48 89 c7             	mov    %rax,%rdi
   42ffe:	e8 3d fc ff ff       	call   42c40 <virtual_memory_lookup>

            virtual_memory_map(p->p_pagetable, addr, mapping.pa, PAGESIZE,
   43003:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   43007:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4300b:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   43012:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   43016:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   4301c:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43021:	48 89 c7             	mov    %rax,%rdi
   43024:	e8 54 f8 ff ff       	call   4287d <virtual_memory_map>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   43029:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   43030:	00 
   43031:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43035:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   43039:	72 aa                	jb     42fe5 <program_load_segment+0x15a>
                    PTE_P | PTE_U);
        }
    }
    // TODO : Add code here -> done
    // log_printf("heap bottom/top before loading this segment: 0x%x\n", p->original_break);
    uintptr_t newbrk = (ph->p_va + ph->p_memsz + (PAGESIZE - 1)) & ~(PAGESIZE - 1);
   4303b:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   4303f:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43043:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   43047:	48 8b 40 28          	mov    0x28(%rax),%rax
   4304b:	48 01 d0             	add    %rdx,%rax
   4304e:	48 05 ff 0f 00 00    	add    $0xfff,%rax
   43054:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4305a:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    if (newbrk > p->original_break)
   4305e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43062:	48 8b 40 10          	mov    0x10(%rax),%rax
   43066:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   4306a:	73 0c                	jae    43078 <program_load_segment+0x1ed>
	    p->original_break = newbrk;
   4306c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43070:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   43074:	48 89 50 10          	mov    %rdx,0x10(%rax)
    p->program_break = p->original_break;
   43078:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4307c:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43080:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43084:	48 89 50 08          	mov    %rdx,0x8(%rax)
    // log_printf("heap bottom/top after loading this segment: 0x%x\n", p->original_break);
    return 0;
   43088:	b8 00 00 00 00       	mov    $0x0,%eax
}
   4308d:	c9                   	leave  
   4308e:	c3                   	ret    

000000000004308f <palloc>:
   4308f:	55                   	push   %rbp
   43090:	48 89 e5             	mov    %rsp,%rbp
   43093:	48 83 ec 20          	sub    $0x20,%rsp
   43097:	89 7d ec             	mov    %edi,-0x14(%rbp)
   4309a:	48 c7 45 f8 00 10 00 	movq   $0x1000,-0x8(%rbp)
   430a1:	00 
   430a2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   430a6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   430aa:	e9 95 00 00 00       	jmp    43144 <palloc+0xb5>
   430af:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   430b3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   430b7:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   430be:	00 
   430bf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   430c3:	48 c1 e8 0c          	shr    $0xc,%rax
   430c7:	48 98                	cltq   
   430c9:	0f b6 84 00 20 ef 04 	movzbl 0x4ef20(%rax,%rax,1),%eax
   430d0:	00 
   430d1:	84 c0                	test   %al,%al
   430d3:	75 6f                	jne    43144 <palloc+0xb5>
   430d5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   430d9:	48 c1 e8 0c          	shr    $0xc,%rax
   430dd:	48 98                	cltq   
   430df:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   430e6:	00 
   430e7:	84 c0                	test   %al,%al
   430e9:	75 59                	jne    43144 <palloc+0xb5>
   430eb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   430ef:	48 c1 e8 0c          	shr    $0xc,%rax
   430f3:	89 c2                	mov    %eax,%edx
   430f5:	48 63 c2             	movslq %edx,%rax
   430f8:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   430ff:	00 
   43100:	83 c0 01             	add    $0x1,%eax
   43103:	89 c1                	mov    %eax,%ecx
   43105:	48 63 c2             	movslq %edx,%rax
   43108:	88 8c 00 21 ef 04 00 	mov    %cl,0x4ef21(%rax,%rax,1)
   4310f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43113:	48 c1 e8 0c          	shr    $0xc,%rax
   43117:	89 c1                	mov    %eax,%ecx
   43119:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4311c:	89 c2                	mov    %eax,%edx
   4311e:	48 63 c1             	movslq %ecx,%rax
   43121:	88 94 00 20 ef 04 00 	mov    %dl,0x4ef20(%rax,%rax,1)
   43128:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4312c:	ba 00 10 00 00       	mov    $0x1000,%edx
   43131:	be cc 00 00 00       	mov    $0xcc,%esi
   43136:	48 89 c7             	mov    %rax,%rdi
   43139:	e8 83 0b 00 00       	call   43cc1 <memset>
   4313e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43142:	eb 2c                	jmp    43170 <palloc+0xe1>
   43144:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   4314b:	00 
   4314c:	0f 86 5d ff ff ff    	jbe    430af <palloc+0x20>
   43152:	ba 78 57 04 00       	mov    $0x45778,%edx
   43157:	be 00 0c 00 00       	mov    $0xc00,%esi
   4315c:	bf 80 07 00 00       	mov    $0x780,%edi
   43161:	b8 00 00 00 00       	mov    $0x0,%eax
   43166:	e8 0d 19 00 00       	call   44a78 <console_printf>
   4316b:	b8 00 00 00 00       	mov    $0x0,%eax
   43170:	c9                   	leave  
   43171:	c3                   	ret    

0000000000043172 <palloc_target>:
   43172:	55                   	push   %rbp
   43173:	48 89 e5             	mov    %rsp,%rbp
   43176:	48 8b 05 83 3e 01 00 	mov    0x13e83(%rip),%rax        # 57000 <palloc_target_proc>
   4317d:	48 85 c0             	test   %rax,%rax
   43180:	75 14                	jne    43196 <palloc_target+0x24>
   43182:	ba 91 57 04 00       	mov    $0x45791,%edx
   43187:	be 27 00 00 00       	mov    $0x27,%esi
   4318c:	bf ac 57 04 00       	mov    $0x457ac,%edi
   43191:	e8 e8 f3 ff ff       	call   4257e <assert_fail>
   43196:	48 8b 05 63 3e 01 00 	mov    0x13e63(%rip),%rax        # 57000 <palloc_target_proc>
   4319d:	8b 00                	mov    (%rax),%eax
   4319f:	89 c7                	mov    %eax,%edi
   431a1:	e8 e9 fe ff ff       	call   4308f <palloc>
   431a6:	5d                   	pop    %rbp
   431a7:	c3                   	ret    

00000000000431a8 <process_free>:
   431a8:	55                   	push   %rbp
   431a9:	48 89 e5             	mov    %rsp,%rbp
   431ac:	48 83 ec 60          	sub    $0x60,%rsp
   431b0:	89 7d ac             	mov    %edi,-0x54(%rbp)
   431b3:	8b 45 ac             	mov    -0x54(%rbp),%eax
   431b6:	48 63 d0             	movslq %eax,%rdx
   431b9:	48 89 d0             	mov    %rdx,%rax
   431bc:	48 c1 e0 04          	shl    $0x4,%rax
   431c0:	48 29 d0             	sub    %rdx,%rax
   431c3:	48 c1 e0 04          	shl    $0x4,%rax
   431c7:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   431cd:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
   431d3:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   431da:	00 
   431db:	e9 ad 00 00 00       	jmp    4328d <process_free+0xe5>
   431e0:	8b 45 ac             	mov    -0x54(%rbp),%eax
   431e3:	48 63 d0             	movslq %eax,%rdx
   431e6:	48 89 d0             	mov    %rdx,%rax
   431e9:	48 c1 e0 04          	shl    $0x4,%rax
   431ed:	48 29 d0             	sub    %rdx,%rax
   431f0:	48 c1 e0 04          	shl    $0x4,%rax
   431f4:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   431fa:	48 8b 08             	mov    (%rax),%rcx
   431fd:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   43201:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43205:	48 89 ce             	mov    %rcx,%rsi
   43208:	48 89 c7             	mov    %rax,%rdi
   4320b:	e8 30 fa ff ff       	call   42c40 <virtual_memory_lookup>
   43210:	8b 45 c8             	mov    -0x38(%rbp),%eax
   43213:	48 98                	cltq   
   43215:	83 e0 01             	and    $0x1,%eax
   43218:	48 85 c0             	test   %rax,%rax
   4321b:	74 68                	je     43285 <process_free+0xdd>
   4321d:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43220:	48 63 d0             	movslq %eax,%rdx
   43223:	0f b6 94 12 21 ef 04 	movzbl 0x4ef21(%rdx,%rdx,1),%edx
   4322a:	00 
   4322b:	83 ea 01             	sub    $0x1,%edx
   4322e:	48 98                	cltq   
   43230:	88 94 00 21 ef 04 00 	mov    %dl,0x4ef21(%rax,%rax,1)
   43237:	8b 45 b8             	mov    -0x48(%rbp),%eax
   4323a:	48 98                	cltq   
   4323c:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   43243:	00 
   43244:	84 c0                	test   %al,%al
   43246:	75 0f                	jne    43257 <process_free+0xaf>
   43248:	8b 45 b8             	mov    -0x48(%rbp),%eax
   4324b:	48 98                	cltq   
   4324d:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43254:	00 
   43255:	eb 2e                	jmp    43285 <process_free+0xdd>
   43257:	8b 45 b8             	mov    -0x48(%rbp),%eax
   4325a:	48 98                	cltq   
   4325c:	0f b6 84 00 20 ef 04 	movzbl 0x4ef20(%rax,%rax,1),%eax
   43263:	00 
   43264:	0f be c0             	movsbl %al,%eax
   43267:	39 45 ac             	cmp    %eax,-0x54(%rbp)
   4326a:	75 19                	jne    43285 <process_free+0xdd>
   4326c:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43270:	8b 55 ac             	mov    -0x54(%rbp),%edx
   43273:	48 89 c6             	mov    %rax,%rsi
   43276:	bf b8 57 04 00       	mov    $0x457b8,%edi
   4327b:	b8 00 00 00 00       	mov    $0x0,%eax
   43280:	e8 db ef ff ff       	call   42260 <log_printf>
   43285:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4328c:	00 
   4328d:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   43294:	00 
   43295:	0f 86 45 ff ff ff    	jbe    431e0 <process_free+0x38>
   4329b:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4329e:	48 63 d0             	movslq %eax,%rdx
   432a1:	48 89 d0             	mov    %rdx,%rax
   432a4:	48 c1 e0 04          	shl    $0x4,%rax
   432a8:	48 29 d0             	sub    %rdx,%rax
   432ab:	48 c1 e0 04          	shl    $0x4,%rax
   432af:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   432b5:	48 8b 00             	mov    (%rax),%rax
   432b8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   432bc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432c0:	48 8b 00             	mov    (%rax),%rax
   432c3:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   432c9:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   432cd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   432d1:	48 8b 00             	mov    (%rax),%rax
   432d4:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   432da:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   432de:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   432e2:	48 8b 00             	mov    (%rax),%rax
   432e5:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   432eb:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   432ef:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   432f3:	48 8b 40 08          	mov    0x8(%rax),%rax
   432f7:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   432fd:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
   43301:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43305:	48 c1 e8 0c          	shr    $0xc,%rax
   43309:	48 98                	cltq   
   4330b:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   43312:	00 
   43313:	3c 01                	cmp    $0x1,%al
   43315:	74 14                	je     4332b <process_free+0x183>
   43317:	ba f0 57 04 00       	mov    $0x457f0,%edx
   4331c:	be 4f 00 00 00       	mov    $0x4f,%esi
   43321:	bf ac 57 04 00       	mov    $0x457ac,%edi
   43326:	e8 53 f2 ff ff       	call   4257e <assert_fail>
   4332b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4332f:	48 c1 e8 0c          	shr    $0xc,%rax
   43333:	48 98                	cltq   
   43335:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   4333c:	00 
   4333d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43341:	48 c1 e8 0c          	shr    $0xc,%rax
   43345:	48 98                	cltq   
   43347:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   4334e:	00 
   4334f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43353:	48 c1 e8 0c          	shr    $0xc,%rax
   43357:	48 98                	cltq   
   43359:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   43360:	00 
   43361:	3c 01                	cmp    $0x1,%al
   43363:	74 14                	je     43379 <process_free+0x1d1>
   43365:	ba 18 58 04 00       	mov    $0x45818,%edx
   4336a:	be 52 00 00 00       	mov    $0x52,%esi
   4336f:	bf ac 57 04 00       	mov    $0x457ac,%edi
   43374:	e8 05 f2 ff ff       	call   4257e <assert_fail>
   43379:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4337d:	48 c1 e8 0c          	shr    $0xc,%rax
   43381:	48 98                	cltq   
   43383:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   4338a:	00 
   4338b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4338f:	48 c1 e8 0c          	shr    $0xc,%rax
   43393:	48 98                	cltq   
   43395:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   4339c:	00 
   4339d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   433a1:	48 c1 e8 0c          	shr    $0xc,%rax
   433a5:	48 98                	cltq   
   433a7:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   433ae:	00 
   433af:	3c 01                	cmp    $0x1,%al
   433b1:	74 14                	je     433c7 <process_free+0x21f>
   433b3:	ba 40 58 04 00       	mov    $0x45840,%edx
   433b8:	be 55 00 00 00       	mov    $0x55,%esi
   433bd:	bf ac 57 04 00       	mov    $0x457ac,%edi
   433c2:	e8 b7 f1 ff ff       	call   4257e <assert_fail>
   433c7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   433cb:	48 c1 e8 0c          	shr    $0xc,%rax
   433cf:	48 98                	cltq   
   433d1:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   433d8:	00 
   433d9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   433dd:	48 c1 e8 0c          	shr    $0xc,%rax
   433e1:	48 98                	cltq   
   433e3:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   433ea:	00 
   433eb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   433ef:	48 c1 e8 0c          	shr    $0xc,%rax
   433f3:	48 98                	cltq   
   433f5:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   433fc:	00 
   433fd:	3c 01                	cmp    $0x1,%al
   433ff:	74 14                	je     43415 <process_free+0x26d>
   43401:	ba 68 58 04 00       	mov    $0x45868,%edx
   43406:	be 58 00 00 00       	mov    $0x58,%esi
   4340b:	bf ac 57 04 00       	mov    $0x457ac,%edi
   43410:	e8 69 f1 ff ff       	call   4257e <assert_fail>
   43415:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43419:	48 c1 e8 0c          	shr    $0xc,%rax
   4341d:	48 98                	cltq   
   4341f:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43426:	00 
   43427:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4342b:	48 c1 e8 0c          	shr    $0xc,%rax
   4342f:	48 98                	cltq   
   43431:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43438:	00 
   43439:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4343d:	48 c1 e8 0c          	shr    $0xc,%rax
   43441:	48 98                	cltq   
   43443:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   4344a:	00 
   4344b:	3c 01                	cmp    $0x1,%al
   4344d:	74 14                	je     43463 <process_free+0x2bb>
   4344f:	ba 90 58 04 00       	mov    $0x45890,%edx
   43454:	be 5b 00 00 00       	mov    $0x5b,%esi
   43459:	bf ac 57 04 00       	mov    $0x457ac,%edi
   4345e:	e8 1b f1 ff ff       	call   4257e <assert_fail>
   43463:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43467:	48 c1 e8 0c          	shr    $0xc,%rax
   4346b:	48 98                	cltq   
   4346d:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43474:	00 
   43475:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43479:	48 c1 e8 0c          	shr    $0xc,%rax
   4347d:	48 98                	cltq   
   4347f:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43486:	00 
   43487:	90                   	nop
   43488:	c9                   	leave  
   43489:	c3                   	ret    

000000000004348a <process_config_tables>:
   4348a:	55                   	push   %rbp
   4348b:	48 89 e5             	mov    %rsp,%rbp
   4348e:	48 83 ec 40          	sub    $0x40,%rsp
   43492:	89 7d cc             	mov    %edi,-0x34(%rbp)
   43495:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43498:	89 c7                	mov    %eax,%edi
   4349a:	e8 f0 fb ff ff       	call   4308f <palloc>
   4349f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   434a3:	8b 45 cc             	mov    -0x34(%rbp),%eax
   434a6:	89 c7                	mov    %eax,%edi
   434a8:	e8 e2 fb ff ff       	call   4308f <palloc>
   434ad:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   434b1:	8b 45 cc             	mov    -0x34(%rbp),%eax
   434b4:	89 c7                	mov    %eax,%edi
   434b6:	e8 d4 fb ff ff       	call   4308f <palloc>
   434bb:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   434bf:	8b 45 cc             	mov    -0x34(%rbp),%eax
   434c2:	89 c7                	mov    %eax,%edi
   434c4:	e8 c6 fb ff ff       	call   4308f <palloc>
   434c9:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   434cd:	8b 45 cc             	mov    -0x34(%rbp),%eax
   434d0:	89 c7                	mov    %eax,%edi
   434d2:	e8 b8 fb ff ff       	call   4308f <palloc>
   434d7:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   434db:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   434e0:	74 20                	je     43502 <process_config_tables+0x78>
   434e2:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   434e7:	74 19                	je     43502 <process_config_tables+0x78>
   434e9:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   434ee:	74 12                	je     43502 <process_config_tables+0x78>
   434f0:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   434f5:	74 0b                	je     43502 <process_config_tables+0x78>
   434f7:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   434fc:	0f 85 e1 00 00 00    	jne    435e3 <process_config_tables+0x159>
   43502:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   43507:	74 24                	je     4352d <process_config_tables+0xa3>
   43509:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4350d:	48 c1 e8 0c          	shr    $0xc,%rax
   43511:	48 98                	cltq   
   43513:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   4351a:	00 
   4351b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4351f:	48 c1 e8 0c          	shr    $0xc,%rax
   43523:	48 98                	cltq   
   43525:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   4352c:	00 
   4352d:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   43532:	74 24                	je     43558 <process_config_tables+0xce>
   43534:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43538:	48 c1 e8 0c          	shr    $0xc,%rax
   4353c:	48 98                	cltq   
   4353e:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43545:	00 
   43546:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4354a:	48 c1 e8 0c          	shr    $0xc,%rax
   4354e:	48 98                	cltq   
   43550:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43557:	00 
   43558:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4355d:	74 24                	je     43583 <process_config_tables+0xf9>
   4355f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43563:	48 c1 e8 0c          	shr    $0xc,%rax
   43567:	48 98                	cltq   
   43569:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43570:	00 
   43571:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43575:	48 c1 e8 0c          	shr    $0xc,%rax
   43579:	48 98                	cltq   
   4357b:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43582:	00 
   43583:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43588:	74 24                	je     435ae <process_config_tables+0x124>
   4358a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4358e:	48 c1 e8 0c          	shr    $0xc,%rax
   43592:	48 98                	cltq   
   43594:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   4359b:	00 
   4359c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   435a0:	48 c1 e8 0c          	shr    $0xc,%rax
   435a4:	48 98                	cltq   
   435a6:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   435ad:	00 
   435ae:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   435b3:	74 24                	je     435d9 <process_config_tables+0x14f>
   435b5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   435b9:	48 c1 e8 0c          	shr    $0xc,%rax
   435bd:	48 98                	cltq   
   435bf:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   435c6:	00 
   435c7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   435cb:	48 c1 e8 0c          	shr    $0xc,%rax
   435cf:	48 98                	cltq   
   435d1:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   435d8:	00 
   435d9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   435de:	e9 f3 01 00 00       	jmp    437d6 <process_config_tables+0x34c>
   435e3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   435e7:	ba 00 10 00 00       	mov    $0x1000,%edx
   435ec:	be 00 00 00 00       	mov    $0x0,%esi
   435f1:	48 89 c7             	mov    %rax,%rdi
   435f4:	e8 c8 06 00 00       	call   43cc1 <memset>
   435f9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435fd:	ba 00 10 00 00       	mov    $0x1000,%edx
   43602:	be 00 00 00 00       	mov    $0x0,%esi
   43607:	48 89 c7             	mov    %rax,%rdi
   4360a:	e8 b2 06 00 00       	call   43cc1 <memset>
   4360f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43613:	ba 00 10 00 00       	mov    $0x1000,%edx
   43618:	be 00 00 00 00       	mov    $0x0,%esi
   4361d:	48 89 c7             	mov    %rax,%rdi
   43620:	e8 9c 06 00 00       	call   43cc1 <memset>
   43625:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43629:	ba 00 10 00 00       	mov    $0x1000,%edx
   4362e:	be 00 00 00 00       	mov    $0x0,%esi
   43633:	48 89 c7             	mov    %rax,%rdi
   43636:	e8 86 06 00 00       	call   43cc1 <memset>
   4363b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4363f:	ba 00 10 00 00       	mov    $0x1000,%edx
   43644:	be 00 00 00 00       	mov    $0x0,%esi
   43649:	48 89 c7             	mov    %rax,%rdi
   4364c:	e8 70 06 00 00       	call   43cc1 <memset>
   43651:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43655:	48 83 c8 07          	or     $0x7,%rax
   43659:	48 89 c2             	mov    %rax,%rdx
   4365c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43660:	48 89 10             	mov    %rdx,(%rax)
   43663:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43667:	48 83 c8 07          	or     $0x7,%rax
   4366b:	48 89 c2             	mov    %rax,%rdx
   4366e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43672:	48 89 10             	mov    %rdx,(%rax)
   43675:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43679:	48 83 c8 07          	or     $0x7,%rax
   4367d:	48 89 c2             	mov    %rax,%rdx
   43680:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43684:	48 89 10             	mov    %rdx,(%rax)
   43687:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4368b:	48 83 c8 07          	or     $0x7,%rax
   4368f:	48 89 c2             	mov    %rax,%rdx
   43692:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43696:	48 89 50 08          	mov    %rdx,0x8(%rax)
   4369a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4369e:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   436a4:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   436aa:	b9 00 00 10 00       	mov    $0x100000,%ecx
   436af:	ba 00 00 00 00       	mov    $0x0,%edx
   436b4:	be 00 00 00 00       	mov    $0x0,%esi
   436b9:	48 89 c7             	mov    %rax,%rdi
   436bc:	e8 bc f1 ff ff       	call   4287d <virtual_memory_map>
   436c1:	85 c0                	test   %eax,%eax
   436c3:	75 2f                	jne    436f4 <process_config_tables+0x26a>
   436c5:	ba 00 80 0b 00       	mov    $0xb8000,%edx
   436ca:	be 00 80 0b 00       	mov    $0xb8000,%esi
   436cf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   436d3:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   436d9:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   436df:	b9 00 10 00 00       	mov    $0x1000,%ecx
   436e4:	48 89 c7             	mov    %rax,%rdi
   436e7:	e8 91 f1 ff ff       	call   4287d <virtual_memory_map>
   436ec:	85 c0                	test   %eax,%eax
   436ee:	0f 84 bb 00 00 00    	je     437af <process_config_tables+0x325>
   436f4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   436f8:	48 c1 e8 0c          	shr    $0xc,%rax
   436fc:	48 98                	cltq   
   436fe:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43705:	00 
   43706:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4370a:	48 c1 e8 0c          	shr    $0xc,%rax
   4370e:	48 98                	cltq   
   43710:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43717:	00 
   43718:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4371c:	48 c1 e8 0c          	shr    $0xc,%rax
   43720:	48 98                	cltq   
   43722:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43729:	00 
   4372a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4372e:	48 c1 e8 0c          	shr    $0xc,%rax
   43732:	48 98                	cltq   
   43734:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   4373b:	00 
   4373c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43740:	48 c1 e8 0c          	shr    $0xc,%rax
   43744:	48 98                	cltq   
   43746:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   4374d:	00 
   4374e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43752:	48 c1 e8 0c          	shr    $0xc,%rax
   43756:	48 98                	cltq   
   43758:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   4375f:	00 
   43760:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43764:	48 c1 e8 0c          	shr    $0xc,%rax
   43768:	48 98                	cltq   
   4376a:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43771:	00 
   43772:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43776:	48 c1 e8 0c          	shr    $0xc,%rax
   4377a:	48 98                	cltq   
   4377c:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43783:	00 
   43784:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43788:	48 c1 e8 0c          	shr    $0xc,%rax
   4378c:	48 98                	cltq   
   4378e:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43795:	00 
   43796:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4379a:	48 c1 e8 0c          	shr    $0xc,%rax
   4379e:	48 98                	cltq   
   437a0:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   437a7:	00 
   437a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   437ad:	eb 27                	jmp    437d6 <process_config_tables+0x34c>
   437af:	8b 45 cc             	mov    -0x34(%rbp),%eax
   437b2:	48 63 d0             	movslq %eax,%rdx
   437b5:	48 89 d0             	mov    %rdx,%rax
   437b8:	48 c1 e0 04          	shl    $0x4,%rax
   437bc:	48 29 d0             	sub    %rdx,%rax
   437bf:	48 c1 e0 04          	shl    $0x4,%rax
   437c3:	48 8d 90 e0 e0 04 00 	lea    0x4e0e0(%rax),%rdx
   437ca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   437ce:	48 89 02             	mov    %rax,(%rdx)
   437d1:	b8 00 00 00 00       	mov    $0x0,%eax
   437d6:	c9                   	leave  
   437d7:	c3                   	ret    

00000000000437d8 <process_load>:
   437d8:	55                   	push   %rbp
   437d9:	48 89 e5             	mov    %rsp,%rbp
   437dc:	48 83 ec 20          	sub    $0x20,%rsp
   437e0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   437e4:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   437e7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   437eb:	48 89 05 0e 38 01 00 	mov    %rax,0x1380e(%rip)        # 57000 <palloc_target_proc>
   437f2:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
   437f5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   437f9:	ba 72 31 04 00       	mov    $0x43172,%edx
   437fe:	89 ce                	mov    %ecx,%esi
   43800:	48 89 c7             	mov    %rax,%rdi
   43803:	e8 2f f5 ff ff       	call   42d37 <program_load>
   43808:	89 45 fc             	mov    %eax,-0x4(%rbp)
   4380b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4380e:	c9                   	leave  
   4380f:	c3                   	ret    

0000000000043810 <process_setup_stack>:
   43810:	55                   	push   %rbp
   43811:	48 89 e5             	mov    %rsp,%rbp
   43814:	48 83 ec 20          	sub    $0x20,%rsp
   43818:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4381c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43820:	8b 00                	mov    (%rax),%eax
   43822:	89 c7                	mov    %eax,%edi
   43824:	e8 66 f8 ff ff       	call   4308f <palloc>
   43829:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   4382d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43831:	48 c7 80 c8 00 00 00 	movq   $0x300000,0xc8(%rax)
   43838:	00 00 30 00 
   4383c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43840:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   43847:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4384b:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43851:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43857:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4385c:	be 00 f0 2f 00       	mov    $0x2ff000,%esi
   43861:	48 89 c7             	mov    %rax,%rdi
   43864:	e8 14 f0 ff ff       	call   4287d <virtual_memory_map>
   43869:	90                   	nop
   4386a:	c9                   	leave  
   4386b:	c3                   	ret    

000000000004386c <find_free_pid>:
   4386c:	55                   	push   %rbp
   4386d:	48 89 e5             	mov    %rsp,%rbp
   43870:	48 83 ec 10          	sub    $0x10,%rsp
   43874:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4387b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
   43882:	eb 24                	jmp    438a8 <find_free_pid+0x3c>
   43884:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43887:	48 63 d0             	movslq %eax,%rdx
   4388a:	48 89 d0             	mov    %rdx,%rax
   4388d:	48 c1 e0 04          	shl    $0x4,%rax
   43891:	48 29 d0             	sub    %rdx,%rax
   43894:	48 c1 e0 04          	shl    $0x4,%rax
   43898:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   4389e:	8b 00                	mov    (%rax),%eax
   438a0:	85 c0                	test   %eax,%eax
   438a2:	74 0c                	je     438b0 <find_free_pid+0x44>
   438a4:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   438a8:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   438ac:	7e d6                	jle    43884 <find_free_pid+0x18>
   438ae:	eb 01                	jmp    438b1 <find_free_pid+0x45>
   438b0:	90                   	nop
   438b1:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   438b5:	74 05                	je     438bc <find_free_pid+0x50>
   438b7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   438ba:	eb 05                	jmp    438c1 <find_free_pid+0x55>
   438bc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   438c1:	c9                   	leave  
   438c2:	c3                   	ret    

00000000000438c3 <process_fork>:
   438c3:	55                   	push   %rbp
   438c4:	48 89 e5             	mov    %rsp,%rbp
   438c7:	48 83 ec 40          	sub    $0x40,%rsp
   438cb:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   438cf:	b8 00 00 00 00       	mov    $0x0,%eax
   438d4:	e8 93 ff ff ff       	call   4386c <find_free_pid>
   438d9:	89 45 f4             	mov    %eax,-0xc(%rbp)
   438dc:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%rbp)
   438e0:	75 0a                	jne    438ec <process_fork+0x29>
   438e2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   438e7:	e9 67 02 00 00       	jmp    43b53 <process_fork+0x290>
   438ec:	8b 45 f4             	mov    -0xc(%rbp),%eax
   438ef:	48 63 d0             	movslq %eax,%rdx
   438f2:	48 89 d0             	mov    %rdx,%rax
   438f5:	48 c1 e0 04          	shl    $0x4,%rax
   438f9:	48 29 d0             	sub    %rdx,%rax
   438fc:	48 c1 e0 04          	shl    $0x4,%rax
   43900:	48 05 00 e0 04 00    	add    $0x4e000,%rax
   43906:	be 00 00 00 00       	mov    $0x0,%esi
   4390b:	48 89 c7             	mov    %rax,%rdi
   4390e:	e8 9d e4 ff ff       	call   41db0 <process_init>
   43913:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43916:	89 c7                	mov    %eax,%edi
   43918:	e8 6d fb ff ff       	call   4348a <process_config_tables>
   4391d:	83 f8 ff             	cmp    $0xffffffff,%eax
   43920:	75 0a                	jne    4392c <process_fork+0x69>
   43922:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43927:	e9 27 02 00 00       	jmp    43b53 <process_fork+0x290>
   4392c:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   43933:	00 
   43934:	e9 79 01 00 00       	jmp    43ab2 <process_fork+0x1ef>
   43939:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4393d:	8b 00                	mov    (%rax),%eax
   4393f:	48 63 d0             	movslq %eax,%rdx
   43942:	48 89 d0             	mov    %rdx,%rax
   43945:	48 c1 e0 04          	shl    $0x4,%rax
   43949:	48 29 d0             	sub    %rdx,%rax
   4394c:	48 c1 e0 04          	shl    $0x4,%rax
   43950:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   43956:	48 8b 08             	mov    (%rax),%rcx
   43959:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4395d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43961:	48 89 ce             	mov    %rcx,%rsi
   43964:	48 89 c7             	mov    %rax,%rdi
   43967:	e8 d4 f2 ff ff       	call   42c40 <virtual_memory_lookup>
   4396c:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4396f:	48 98                	cltq   
   43971:	83 e0 07             	and    $0x7,%eax
   43974:	48 83 f8 07          	cmp    $0x7,%rax
   43978:	0f 85 a1 00 00 00    	jne    43a1f <process_fork+0x15c>
   4397e:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43981:	89 c7                	mov    %eax,%edi
   43983:	e8 07 f7 ff ff       	call   4308f <palloc>
   43988:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   4398c:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   43991:	75 14                	jne    439a7 <process_fork+0xe4>
   43993:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43996:	89 c7                	mov    %eax,%edi
   43998:	e8 0b f8 ff ff       	call   431a8 <process_free>
   4399d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   439a2:	e9 ac 01 00 00       	jmp    43b53 <process_fork+0x290>
   439a7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   439ab:	48 89 c1             	mov    %rax,%rcx
   439ae:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   439b2:	ba 00 10 00 00       	mov    $0x1000,%edx
   439b7:	48 89 ce             	mov    %rcx,%rsi
   439ba:	48 89 c7             	mov    %rax,%rdi
   439bd:	e8 01 02 00 00       	call   43bc3 <memcpy>
   439c2:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
   439c6:	8b 45 f4             	mov    -0xc(%rbp),%eax
   439c9:	48 63 d0             	movslq %eax,%rdx
   439cc:	48 89 d0             	mov    %rdx,%rax
   439cf:	48 c1 e0 04          	shl    $0x4,%rax
   439d3:	48 29 d0             	sub    %rdx,%rax
   439d6:	48 c1 e0 04          	shl    $0x4,%rax
   439da:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   439e0:	48 8b 00             	mov    (%rax),%rax
   439e3:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   439e7:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   439ed:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   439f3:	b9 00 10 00 00       	mov    $0x1000,%ecx
   439f8:	48 89 fa             	mov    %rdi,%rdx
   439fb:	48 89 c7             	mov    %rax,%rdi
   439fe:	e8 7a ee ff ff       	call   4287d <virtual_memory_map>
   43a03:	85 c0                	test   %eax,%eax
   43a05:	0f 84 9f 00 00 00    	je     43aaa <process_fork+0x1e7>
   43a0b:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43a0e:	89 c7                	mov    %eax,%edi
   43a10:	e8 93 f7 ff ff       	call   431a8 <process_free>
   43a15:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43a1a:	e9 34 01 00 00       	jmp    43b53 <process_fork+0x290>
   43a1f:	8b 45 e0             	mov    -0x20(%rbp),%eax
   43a22:	48 98                	cltq   
   43a24:	83 e0 05             	and    $0x5,%eax
   43a27:	48 83 f8 05          	cmp    $0x5,%rax
   43a2b:	75 7d                	jne    43aaa <process_fork+0x1e7>
   43a2d:	48 8b 7d d8          	mov    -0x28(%rbp),%rdi
   43a31:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43a34:	48 63 d0             	movslq %eax,%rdx
   43a37:	48 89 d0             	mov    %rdx,%rax
   43a3a:	48 c1 e0 04          	shl    $0x4,%rax
   43a3e:	48 29 d0             	sub    %rdx,%rax
   43a41:	48 c1 e0 04          	shl    $0x4,%rax
   43a45:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   43a4b:	48 8b 00             	mov    (%rax),%rax
   43a4e:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   43a52:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43a58:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   43a5e:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43a63:	48 89 fa             	mov    %rdi,%rdx
   43a66:	48 89 c7             	mov    %rax,%rdi
   43a69:	e8 0f ee ff ff       	call   4287d <virtual_memory_map>
   43a6e:	85 c0                	test   %eax,%eax
   43a70:	74 14                	je     43a86 <process_fork+0x1c3>
   43a72:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43a75:	89 c7                	mov    %eax,%edi
   43a77:	e8 2c f7 ff ff       	call   431a8 <process_free>
   43a7c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43a81:	e9 cd 00 00 00       	jmp    43b53 <process_fork+0x290>
   43a86:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43a8a:	48 c1 e8 0c          	shr    $0xc,%rax
   43a8e:	89 c2                	mov    %eax,%edx
   43a90:	48 63 c2             	movslq %edx,%rax
   43a93:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   43a9a:	00 
   43a9b:	83 c0 01             	add    $0x1,%eax
   43a9e:	89 c1                	mov    %eax,%ecx
   43aa0:	48 63 c2             	movslq %edx,%rax
   43aa3:	88 8c 00 21 ef 04 00 	mov    %cl,0x4ef21(%rax,%rax,1)
   43aaa:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43ab1:	00 
   43ab2:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   43ab9:	00 
   43aba:	0f 86 79 fe ff ff    	jbe    43939 <process_fork+0x76>
   43ac0:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43ac4:	8b 08                	mov    (%rax),%ecx
   43ac6:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43ac9:	48 63 d0             	movslq %eax,%rdx
   43acc:	48 89 d0             	mov    %rdx,%rax
   43acf:	48 c1 e0 04          	shl    $0x4,%rax
   43ad3:	48 29 d0             	sub    %rdx,%rax
   43ad6:	48 c1 e0 04          	shl    $0x4,%rax
   43ada:	48 8d b0 10 e0 04 00 	lea    0x4e010(%rax),%rsi
   43ae1:	48 63 d1             	movslq %ecx,%rdx
   43ae4:	48 89 d0             	mov    %rdx,%rax
   43ae7:	48 c1 e0 04          	shl    $0x4,%rax
   43aeb:	48 29 d0             	sub    %rdx,%rax
   43aee:	48 c1 e0 04          	shl    $0x4,%rax
   43af2:	48 8d 90 10 e0 04 00 	lea    0x4e010(%rax),%rdx
   43af9:	48 8d 46 08          	lea    0x8(%rsi),%rax
   43afd:	48 83 c2 08          	add    $0x8,%rdx
   43b01:	b9 18 00 00 00       	mov    $0x18,%ecx
   43b06:	48 89 c7             	mov    %rax,%rdi
   43b09:	48 89 d6             	mov    %rdx,%rsi
   43b0c:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
   43b0f:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43b12:	48 63 d0             	movslq %eax,%rdx
   43b15:	48 89 d0             	mov    %rdx,%rax
   43b18:	48 c1 e0 04          	shl    $0x4,%rax
   43b1c:	48 29 d0             	sub    %rdx,%rax
   43b1f:	48 c1 e0 04          	shl    $0x4,%rax
   43b23:	48 05 18 e0 04 00    	add    $0x4e018,%rax
   43b29:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
   43b30:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43b33:	48 63 d0             	movslq %eax,%rdx
   43b36:	48 89 d0             	mov    %rdx,%rax
   43b39:	48 c1 e0 04          	shl    $0x4,%rax
   43b3d:	48 29 d0             	sub    %rdx,%rax
   43b40:	48 c1 e0 04          	shl    $0x4,%rax
   43b44:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   43b4a:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
   43b50:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43b53:	c9                   	leave  
   43b54:	c3                   	ret    

0000000000043b55 <process_page_alloc>:
   43b55:	55                   	push   %rbp
   43b56:	48 89 e5             	mov    %rsp,%rbp
   43b59:	48 83 ec 20          	sub    $0x20,%rsp
   43b5d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43b61:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43b65:	48 81 7d e0 ff ff 0f 	cmpq   $0xfffff,-0x20(%rbp)
   43b6c:	00 
   43b6d:	77 07                	ja     43b76 <process_page_alloc+0x21>
   43b6f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43b74:	eb 4b                	jmp    43bc1 <process_page_alloc+0x6c>
   43b76:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43b7a:	8b 00                	mov    (%rax),%eax
   43b7c:	89 c7                	mov    %eax,%edi
   43b7e:	e8 0c f5 ff ff       	call   4308f <palloc>
   43b83:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43b87:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   43b8c:	74 2e                	je     43bbc <process_page_alloc+0x67>
   43b8e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43b92:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43b96:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   43b9d:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
   43ba1:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43ba7:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43bad:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43bb2:	48 89 c7             	mov    %rax,%rdi
   43bb5:	e8 c3 ec ff ff       	call   4287d <virtual_memory_map>
   43bba:	eb 05                	jmp    43bc1 <process_page_alloc+0x6c>
   43bbc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43bc1:	c9                   	leave  
   43bc2:	c3                   	ret    

0000000000043bc3 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   43bc3:	55                   	push   %rbp
   43bc4:	48 89 e5             	mov    %rsp,%rbp
   43bc7:	48 83 ec 28          	sub    $0x28,%rsp
   43bcb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43bcf:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43bd3:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43bd7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43bdb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43bdf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43be3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43be7:	eb 1c                	jmp    43c05 <memcpy+0x42>
        *d = *s;
   43be9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43bed:	0f b6 10             	movzbl (%rax),%edx
   43bf0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43bf4:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43bf6:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43bfb:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43c00:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   43c05:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43c0a:	75 dd                	jne    43be9 <memcpy+0x26>
    }
    return dst;
   43c0c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43c10:	c9                   	leave  
   43c11:	c3                   	ret    

0000000000043c12 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   43c12:	55                   	push   %rbp
   43c13:	48 89 e5             	mov    %rsp,%rbp
   43c16:	48 83 ec 28          	sub    $0x28,%rsp
   43c1a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43c1e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43c22:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43c26:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43c2a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   43c2e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43c32:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   43c36:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c3a:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   43c3e:	73 6a                	jae    43caa <memmove+0x98>
   43c40:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43c44:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43c48:	48 01 d0             	add    %rdx,%rax
   43c4b:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   43c4f:	73 59                	jae    43caa <memmove+0x98>
        s += n, d += n;
   43c51:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43c55:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   43c59:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43c5d:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   43c61:	eb 17                	jmp    43c7a <memmove+0x68>
            *--d = *--s;
   43c63:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   43c68:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   43c6d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c71:	0f b6 10             	movzbl (%rax),%edx
   43c74:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43c78:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43c7a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43c7e:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43c82:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43c86:	48 85 c0             	test   %rax,%rax
   43c89:	75 d8                	jne    43c63 <memmove+0x51>
    if (s < d && s + n > d) {
   43c8b:	eb 2e                	jmp    43cbb <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   43c8d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43c91:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43c95:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43c99:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43c9d:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43ca1:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   43ca5:	0f b6 12             	movzbl (%rdx),%edx
   43ca8:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43caa:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43cae:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43cb2:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43cb6:	48 85 c0             	test   %rax,%rax
   43cb9:	75 d2                	jne    43c8d <memmove+0x7b>
        }
    }
    return dst;
   43cbb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43cbf:	c9                   	leave  
   43cc0:	c3                   	ret    

0000000000043cc1 <memset>:

void* memset(void* v, int c, size_t n) {
   43cc1:	55                   	push   %rbp
   43cc2:	48 89 e5             	mov    %rsp,%rbp
   43cc5:	48 83 ec 28          	sub    $0x28,%rsp
   43cc9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43ccd:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   43cd0:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43cd4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43cd8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43cdc:	eb 15                	jmp    43cf3 <memset+0x32>
        *p = c;
   43cde:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43ce1:	89 c2                	mov    %eax,%edx
   43ce3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43ce7:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43ce9:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43cee:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43cf3:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43cf8:	75 e4                	jne    43cde <memset+0x1d>
    }
    return v;
   43cfa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43cfe:	c9                   	leave  
   43cff:	c3                   	ret    

0000000000043d00 <strlen>:

size_t strlen(const char* s) {
   43d00:	55                   	push   %rbp
   43d01:	48 89 e5             	mov    %rsp,%rbp
   43d04:	48 83 ec 18          	sub    $0x18,%rsp
   43d08:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   43d0c:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43d13:	00 
   43d14:	eb 0a                	jmp    43d20 <strlen+0x20>
        ++n;
   43d16:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   43d1b:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43d20:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43d24:	0f b6 00             	movzbl (%rax),%eax
   43d27:	84 c0                	test   %al,%al
   43d29:	75 eb                	jne    43d16 <strlen+0x16>
    }
    return n;
   43d2b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43d2f:	c9                   	leave  
   43d30:	c3                   	ret    

0000000000043d31 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   43d31:	55                   	push   %rbp
   43d32:	48 89 e5             	mov    %rsp,%rbp
   43d35:	48 83 ec 20          	sub    $0x20,%rsp
   43d39:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43d3d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43d41:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43d48:	00 
   43d49:	eb 0a                	jmp    43d55 <strnlen+0x24>
        ++n;
   43d4b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43d50:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43d55:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43d59:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   43d5d:	74 0b                	je     43d6a <strnlen+0x39>
   43d5f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43d63:	0f b6 00             	movzbl (%rax),%eax
   43d66:	84 c0                	test   %al,%al
   43d68:	75 e1                	jne    43d4b <strnlen+0x1a>
    }
    return n;
   43d6a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43d6e:	c9                   	leave  
   43d6f:	c3                   	ret    

0000000000043d70 <strcpy>:

char* strcpy(char* dst, const char* src) {
   43d70:	55                   	push   %rbp
   43d71:	48 89 e5             	mov    %rsp,%rbp
   43d74:	48 83 ec 20          	sub    $0x20,%rsp
   43d78:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43d7c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   43d80:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43d84:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   43d88:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43d8c:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43d90:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43d94:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43d98:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43d9c:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   43da0:	0f b6 12             	movzbl (%rdx),%edx
   43da3:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   43da5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43da9:	48 83 e8 01          	sub    $0x1,%rax
   43dad:	0f b6 00             	movzbl (%rax),%eax
   43db0:	84 c0                	test   %al,%al
   43db2:	75 d4                	jne    43d88 <strcpy+0x18>
    return dst;
   43db4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43db8:	c9                   	leave  
   43db9:	c3                   	ret    

0000000000043dba <strcmp>:

int strcmp(const char* a, const char* b) {
   43dba:	55                   	push   %rbp
   43dbb:	48 89 e5             	mov    %rsp,%rbp
   43dbe:	48 83 ec 10          	sub    $0x10,%rsp
   43dc2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43dc6:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43dca:	eb 0a                	jmp    43dd6 <strcmp+0x1c>
        ++a, ++b;
   43dcc:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43dd1:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43dd6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43dda:	0f b6 00             	movzbl (%rax),%eax
   43ddd:	84 c0                	test   %al,%al
   43ddf:	74 1d                	je     43dfe <strcmp+0x44>
   43de1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43de5:	0f b6 00             	movzbl (%rax),%eax
   43de8:	84 c0                	test   %al,%al
   43dea:	74 12                	je     43dfe <strcmp+0x44>
   43dec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43df0:	0f b6 10             	movzbl (%rax),%edx
   43df3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43df7:	0f b6 00             	movzbl (%rax),%eax
   43dfa:	38 c2                	cmp    %al,%dl
   43dfc:	74 ce                	je     43dcc <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   43dfe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e02:	0f b6 00             	movzbl (%rax),%eax
   43e05:	89 c2                	mov    %eax,%edx
   43e07:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43e0b:	0f b6 00             	movzbl (%rax),%eax
   43e0e:	38 d0                	cmp    %dl,%al
   43e10:	0f 92 c0             	setb   %al
   43e13:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   43e16:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e1a:	0f b6 00             	movzbl (%rax),%eax
   43e1d:	89 c1                	mov    %eax,%ecx
   43e1f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43e23:	0f b6 00             	movzbl (%rax),%eax
   43e26:	38 c1                	cmp    %al,%cl
   43e28:	0f 92 c0             	setb   %al
   43e2b:	0f b6 c0             	movzbl %al,%eax
   43e2e:	29 c2                	sub    %eax,%edx
   43e30:	89 d0                	mov    %edx,%eax
}
   43e32:	c9                   	leave  
   43e33:	c3                   	ret    

0000000000043e34 <strchr>:

char* strchr(const char* s, int c) {
   43e34:	55                   	push   %rbp
   43e35:	48 89 e5             	mov    %rsp,%rbp
   43e38:	48 83 ec 10          	sub    $0x10,%rsp
   43e3c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43e40:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   43e43:	eb 05                	jmp    43e4a <strchr+0x16>
        ++s;
   43e45:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   43e4a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e4e:	0f b6 00             	movzbl (%rax),%eax
   43e51:	84 c0                	test   %al,%al
   43e53:	74 0e                	je     43e63 <strchr+0x2f>
   43e55:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e59:	0f b6 00             	movzbl (%rax),%eax
   43e5c:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43e5f:	38 d0                	cmp    %dl,%al
   43e61:	75 e2                	jne    43e45 <strchr+0x11>
    }
    if (*s == (char) c) {
   43e63:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e67:	0f b6 00             	movzbl (%rax),%eax
   43e6a:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43e6d:	38 d0                	cmp    %dl,%al
   43e6f:	75 06                	jne    43e77 <strchr+0x43>
        return (char*) s;
   43e71:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e75:	eb 05                	jmp    43e7c <strchr+0x48>
    } else {
        return NULL;
   43e77:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   43e7c:	c9                   	leave  
   43e7d:	c3                   	ret    

0000000000043e7e <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   43e7e:	55                   	push   %rbp
   43e7f:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   43e82:	8b 05 80 31 01 00    	mov    0x13180(%rip),%eax        # 57008 <rand_seed_set>
   43e88:	85 c0                	test   %eax,%eax
   43e8a:	75 0a                	jne    43e96 <rand+0x18>
        srand(819234718U);
   43e8c:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   43e91:	e8 24 00 00 00       	call   43eba <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   43e96:	8b 05 70 31 01 00    	mov    0x13170(%rip),%eax        # 5700c <rand_seed>
   43e9c:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   43ea2:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   43ea7:	89 05 5f 31 01 00    	mov    %eax,0x1315f(%rip)        # 5700c <rand_seed>
    return rand_seed & RAND_MAX;
   43ead:	8b 05 59 31 01 00    	mov    0x13159(%rip),%eax        # 5700c <rand_seed>
   43eb3:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   43eb8:	5d                   	pop    %rbp
   43eb9:	c3                   	ret    

0000000000043eba <srand>:

void srand(unsigned seed) {
   43eba:	55                   	push   %rbp
   43ebb:	48 89 e5             	mov    %rsp,%rbp
   43ebe:	48 83 ec 08          	sub    $0x8,%rsp
   43ec2:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   43ec5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43ec8:	89 05 3e 31 01 00    	mov    %eax,0x1313e(%rip)        # 5700c <rand_seed>
    rand_seed_set = 1;
   43ece:	c7 05 30 31 01 00 01 	movl   $0x1,0x13130(%rip)        # 57008 <rand_seed_set>
   43ed5:	00 00 00 
}
   43ed8:	90                   	nop
   43ed9:	c9                   	leave  
   43eda:	c3                   	ret    

0000000000043edb <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   43edb:	55                   	push   %rbp
   43edc:	48 89 e5             	mov    %rsp,%rbp
   43edf:	48 83 ec 28          	sub    $0x28,%rsp
   43ee3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43ee7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43eeb:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   43eee:	48 c7 45 f8 a0 5a 04 	movq   $0x45aa0,-0x8(%rbp)
   43ef5:	00 
    if (base < 0) {
   43ef6:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   43efa:	79 0b                	jns    43f07 <fill_numbuf+0x2c>
        digits = lower_digits;
   43efc:	48 c7 45 f8 c0 5a 04 	movq   $0x45ac0,-0x8(%rbp)
   43f03:	00 
        base = -base;
   43f04:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   43f07:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43f0c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43f10:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   43f13:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43f16:	48 63 c8             	movslq %eax,%rcx
   43f19:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43f1d:	ba 00 00 00 00       	mov    $0x0,%edx
   43f22:	48 f7 f1             	div    %rcx
   43f25:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43f29:	48 01 d0             	add    %rdx,%rax
   43f2c:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43f31:	0f b6 10             	movzbl (%rax),%edx
   43f34:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43f38:	88 10                	mov    %dl,(%rax)
        val /= base;
   43f3a:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43f3d:	48 63 f0             	movslq %eax,%rsi
   43f40:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43f44:	ba 00 00 00 00       	mov    $0x0,%edx
   43f49:	48 f7 f6             	div    %rsi
   43f4c:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   43f50:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43f55:	75 bc                	jne    43f13 <fill_numbuf+0x38>
    return numbuf_end;
   43f57:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43f5b:	c9                   	leave  
   43f5c:	c3                   	ret    

0000000000043f5d <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   43f5d:	55                   	push   %rbp
   43f5e:	48 89 e5             	mov    %rsp,%rbp
   43f61:	53                   	push   %rbx
   43f62:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   43f69:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   43f70:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   43f76:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43f7d:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   43f84:	e9 8a 09 00 00       	jmp    44913 <printer_vprintf+0x9b6>
        if (*format != '%') {
   43f89:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f90:	0f b6 00             	movzbl (%rax),%eax
   43f93:	3c 25                	cmp    $0x25,%al
   43f95:	74 31                	je     43fc8 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
   43f97:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43f9e:	4c 8b 00             	mov    (%rax),%r8
   43fa1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43fa8:	0f b6 00             	movzbl (%rax),%eax
   43fab:	0f b6 c8             	movzbl %al,%ecx
   43fae:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43fb4:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43fbb:	89 ce                	mov    %ecx,%esi
   43fbd:	48 89 c7             	mov    %rax,%rdi
   43fc0:	41 ff d0             	call   *%r8
            continue;
   43fc3:	e9 43 09 00 00       	jmp    4490b <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
   43fc8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   43fcf:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43fd6:	01 
   43fd7:	eb 44                	jmp    4401d <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
   43fd9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43fe0:	0f b6 00             	movzbl (%rax),%eax
   43fe3:	0f be c0             	movsbl %al,%eax
   43fe6:	89 c6                	mov    %eax,%esi
   43fe8:	bf c0 58 04 00       	mov    $0x458c0,%edi
   43fed:	e8 42 fe ff ff       	call   43e34 <strchr>
   43ff2:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   43ff6:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   43ffb:	74 30                	je     4402d <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
   43ffd:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   44001:	48 2d c0 58 04 00    	sub    $0x458c0,%rax
   44007:	ba 01 00 00 00       	mov    $0x1,%edx
   4400c:	89 c1                	mov    %eax,%ecx
   4400e:	d3 e2                	shl    %cl,%edx
   44010:	89 d0                	mov    %edx,%eax
   44012:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   44015:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4401c:	01 
   4401d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44024:	0f b6 00             	movzbl (%rax),%eax
   44027:	84 c0                	test   %al,%al
   44029:	75 ae                	jne    43fd9 <printer_vprintf+0x7c>
   4402b:	eb 01                	jmp    4402e <printer_vprintf+0xd1>
            } else {
                break;
   4402d:	90                   	nop
            }
        }

        // process width
        int width = -1;
   4402e:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   44035:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4403c:	0f b6 00             	movzbl (%rax),%eax
   4403f:	3c 30                	cmp    $0x30,%al
   44041:	7e 67                	jle    440aa <printer_vprintf+0x14d>
   44043:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4404a:	0f b6 00             	movzbl (%rax),%eax
   4404d:	3c 39                	cmp    $0x39,%al
   4404f:	7f 59                	jg     440aa <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   44051:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   44058:	eb 2e                	jmp    44088 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
   4405a:	8b 55 e8             	mov    -0x18(%rbp),%edx
   4405d:	89 d0                	mov    %edx,%eax
   4405f:	c1 e0 02             	shl    $0x2,%eax
   44062:	01 d0                	add    %edx,%eax
   44064:	01 c0                	add    %eax,%eax
   44066:	89 c1                	mov    %eax,%ecx
   44068:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4406f:	48 8d 50 01          	lea    0x1(%rax),%rdx
   44073:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   4407a:	0f b6 00             	movzbl (%rax),%eax
   4407d:	0f be c0             	movsbl %al,%eax
   44080:	01 c8                	add    %ecx,%eax
   44082:	83 e8 30             	sub    $0x30,%eax
   44085:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   44088:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4408f:	0f b6 00             	movzbl (%rax),%eax
   44092:	3c 2f                	cmp    $0x2f,%al
   44094:	0f 8e 85 00 00 00    	jle    4411f <printer_vprintf+0x1c2>
   4409a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   440a1:	0f b6 00             	movzbl (%rax),%eax
   440a4:	3c 39                	cmp    $0x39,%al
   440a6:	7e b2                	jle    4405a <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
   440a8:	eb 75                	jmp    4411f <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
   440aa:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   440b1:	0f b6 00             	movzbl (%rax),%eax
   440b4:	3c 2a                	cmp    $0x2a,%al
   440b6:	75 68                	jne    44120 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
   440b8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   440bf:	8b 00                	mov    (%rax),%eax
   440c1:	83 f8 2f             	cmp    $0x2f,%eax
   440c4:	77 30                	ja     440f6 <printer_vprintf+0x199>
   440c6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   440cd:	48 8b 50 10          	mov    0x10(%rax),%rdx
   440d1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   440d8:	8b 00                	mov    (%rax),%eax
   440da:	89 c0                	mov    %eax,%eax
   440dc:	48 01 d0             	add    %rdx,%rax
   440df:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   440e6:	8b 12                	mov    (%rdx),%edx
   440e8:	8d 4a 08             	lea    0x8(%rdx),%ecx
   440eb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   440f2:	89 0a                	mov    %ecx,(%rdx)
   440f4:	eb 1a                	jmp    44110 <printer_vprintf+0x1b3>
   440f6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   440fd:	48 8b 40 08          	mov    0x8(%rax),%rax
   44101:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44105:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4410c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44110:	8b 00                	mov    (%rax),%eax
   44112:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   44115:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4411c:	01 
   4411d:	eb 01                	jmp    44120 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
   4411f:	90                   	nop
        }

        // process precision
        int precision = -1;
   44120:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   44127:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4412e:	0f b6 00             	movzbl (%rax),%eax
   44131:	3c 2e                	cmp    $0x2e,%al
   44133:	0f 85 00 01 00 00    	jne    44239 <printer_vprintf+0x2dc>
            ++format;
   44139:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44140:	01 
            if (*format >= '0' && *format <= '9') {
   44141:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44148:	0f b6 00             	movzbl (%rax),%eax
   4414b:	3c 2f                	cmp    $0x2f,%al
   4414d:	7e 67                	jle    441b6 <printer_vprintf+0x259>
   4414f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44156:	0f b6 00             	movzbl (%rax),%eax
   44159:	3c 39                	cmp    $0x39,%al
   4415b:	7f 59                	jg     441b6 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   4415d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   44164:	eb 2e                	jmp    44194 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
   44166:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   44169:	89 d0                	mov    %edx,%eax
   4416b:	c1 e0 02             	shl    $0x2,%eax
   4416e:	01 d0                	add    %edx,%eax
   44170:	01 c0                	add    %eax,%eax
   44172:	89 c1                	mov    %eax,%ecx
   44174:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4417b:	48 8d 50 01          	lea    0x1(%rax),%rdx
   4417f:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   44186:	0f b6 00             	movzbl (%rax),%eax
   44189:	0f be c0             	movsbl %al,%eax
   4418c:	01 c8                	add    %ecx,%eax
   4418e:	83 e8 30             	sub    $0x30,%eax
   44191:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   44194:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4419b:	0f b6 00             	movzbl (%rax),%eax
   4419e:	3c 2f                	cmp    $0x2f,%al
   441a0:	0f 8e 85 00 00 00    	jle    4422b <printer_vprintf+0x2ce>
   441a6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   441ad:	0f b6 00             	movzbl (%rax),%eax
   441b0:	3c 39                	cmp    $0x39,%al
   441b2:	7e b2                	jle    44166 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
   441b4:	eb 75                	jmp    4422b <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
   441b6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   441bd:	0f b6 00             	movzbl (%rax),%eax
   441c0:	3c 2a                	cmp    $0x2a,%al
   441c2:	75 68                	jne    4422c <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
   441c4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   441cb:	8b 00                	mov    (%rax),%eax
   441cd:	83 f8 2f             	cmp    $0x2f,%eax
   441d0:	77 30                	ja     44202 <printer_vprintf+0x2a5>
   441d2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   441d9:	48 8b 50 10          	mov    0x10(%rax),%rdx
   441dd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   441e4:	8b 00                	mov    (%rax),%eax
   441e6:	89 c0                	mov    %eax,%eax
   441e8:	48 01 d0             	add    %rdx,%rax
   441eb:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   441f2:	8b 12                	mov    (%rdx),%edx
   441f4:	8d 4a 08             	lea    0x8(%rdx),%ecx
   441f7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   441fe:	89 0a                	mov    %ecx,(%rdx)
   44200:	eb 1a                	jmp    4421c <printer_vprintf+0x2bf>
   44202:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44209:	48 8b 40 08          	mov    0x8(%rax),%rax
   4420d:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44211:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44218:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4421c:	8b 00                	mov    (%rax),%eax
   4421e:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   44221:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44228:	01 
   44229:	eb 01                	jmp    4422c <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
   4422b:	90                   	nop
            }
            if (precision < 0) {
   4422c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   44230:	79 07                	jns    44239 <printer_vprintf+0x2dc>
                precision = 0;
   44232:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   44239:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   44240:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   44247:	00 
        int length = 0;
   44248:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   4424f:	48 c7 45 c8 c6 58 04 	movq   $0x458c6,-0x38(%rbp)
   44256:	00 
    again:
        switch (*format) {
   44257:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4425e:	0f b6 00             	movzbl (%rax),%eax
   44261:	0f be c0             	movsbl %al,%eax
   44264:	83 e8 43             	sub    $0x43,%eax
   44267:	83 f8 37             	cmp    $0x37,%eax
   4426a:	0f 87 9f 03 00 00    	ja     4460f <printer_vprintf+0x6b2>
   44270:	89 c0                	mov    %eax,%eax
   44272:	48 8b 04 c5 d8 58 04 	mov    0x458d8(,%rax,8),%rax
   44279:	00 
   4427a:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
   4427c:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   44283:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4428a:	01 
            goto again;
   4428b:	eb ca                	jmp    44257 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   4428d:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   44291:	74 5d                	je     442f0 <printer_vprintf+0x393>
   44293:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4429a:	8b 00                	mov    (%rax),%eax
   4429c:	83 f8 2f             	cmp    $0x2f,%eax
   4429f:	77 30                	ja     442d1 <printer_vprintf+0x374>
   442a1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442a8:	48 8b 50 10          	mov    0x10(%rax),%rdx
   442ac:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442b3:	8b 00                	mov    (%rax),%eax
   442b5:	89 c0                	mov    %eax,%eax
   442b7:	48 01 d0             	add    %rdx,%rax
   442ba:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442c1:	8b 12                	mov    (%rdx),%edx
   442c3:	8d 4a 08             	lea    0x8(%rdx),%ecx
   442c6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442cd:	89 0a                	mov    %ecx,(%rdx)
   442cf:	eb 1a                	jmp    442eb <printer_vprintf+0x38e>
   442d1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442d8:	48 8b 40 08          	mov    0x8(%rax),%rax
   442dc:	48 8d 48 08          	lea    0x8(%rax),%rcx
   442e0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442e7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   442eb:	48 8b 00             	mov    (%rax),%rax
   442ee:	eb 5c                	jmp    4434c <printer_vprintf+0x3ef>
   442f0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442f7:	8b 00                	mov    (%rax),%eax
   442f9:	83 f8 2f             	cmp    $0x2f,%eax
   442fc:	77 30                	ja     4432e <printer_vprintf+0x3d1>
   442fe:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44305:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44309:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44310:	8b 00                	mov    (%rax),%eax
   44312:	89 c0                	mov    %eax,%eax
   44314:	48 01 d0             	add    %rdx,%rax
   44317:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4431e:	8b 12                	mov    (%rdx),%edx
   44320:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44323:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4432a:	89 0a                	mov    %ecx,(%rdx)
   4432c:	eb 1a                	jmp    44348 <printer_vprintf+0x3eb>
   4432e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44335:	48 8b 40 08          	mov    0x8(%rax),%rax
   44339:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4433d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44344:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44348:	8b 00                	mov    (%rax),%eax
   4434a:	48 98                	cltq   
   4434c:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   44350:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44354:	48 c1 f8 38          	sar    $0x38,%rax
   44358:	25 80 00 00 00       	and    $0x80,%eax
   4435d:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   44360:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   44364:	74 09                	je     4436f <printer_vprintf+0x412>
   44366:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4436a:	48 f7 d8             	neg    %rax
   4436d:	eb 04                	jmp    44373 <printer_vprintf+0x416>
   4436f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44373:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   44377:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   4437a:	83 c8 60             	or     $0x60,%eax
   4437d:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   44380:	e9 cf 02 00 00       	jmp    44654 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   44385:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   44389:	74 5d                	je     443e8 <printer_vprintf+0x48b>
   4438b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44392:	8b 00                	mov    (%rax),%eax
   44394:	83 f8 2f             	cmp    $0x2f,%eax
   44397:	77 30                	ja     443c9 <printer_vprintf+0x46c>
   44399:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443a0:	48 8b 50 10          	mov    0x10(%rax),%rdx
   443a4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443ab:	8b 00                	mov    (%rax),%eax
   443ad:	89 c0                	mov    %eax,%eax
   443af:	48 01 d0             	add    %rdx,%rax
   443b2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   443b9:	8b 12                	mov    (%rdx),%edx
   443bb:	8d 4a 08             	lea    0x8(%rdx),%ecx
   443be:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   443c5:	89 0a                	mov    %ecx,(%rdx)
   443c7:	eb 1a                	jmp    443e3 <printer_vprintf+0x486>
   443c9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443d0:	48 8b 40 08          	mov    0x8(%rax),%rax
   443d4:	48 8d 48 08          	lea    0x8(%rax),%rcx
   443d8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   443df:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   443e3:	48 8b 00             	mov    (%rax),%rax
   443e6:	eb 5c                	jmp    44444 <printer_vprintf+0x4e7>
   443e8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443ef:	8b 00                	mov    (%rax),%eax
   443f1:	83 f8 2f             	cmp    $0x2f,%eax
   443f4:	77 30                	ja     44426 <printer_vprintf+0x4c9>
   443f6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443fd:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44401:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44408:	8b 00                	mov    (%rax),%eax
   4440a:	89 c0                	mov    %eax,%eax
   4440c:	48 01 d0             	add    %rdx,%rax
   4440f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44416:	8b 12                	mov    (%rdx),%edx
   44418:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4441b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44422:	89 0a                	mov    %ecx,(%rdx)
   44424:	eb 1a                	jmp    44440 <printer_vprintf+0x4e3>
   44426:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4442d:	48 8b 40 08          	mov    0x8(%rax),%rax
   44431:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44435:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4443c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44440:	8b 00                	mov    (%rax),%eax
   44442:	89 c0                	mov    %eax,%eax
   44444:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   44448:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   4444c:	e9 03 02 00 00       	jmp    44654 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
   44451:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   44458:	e9 28 ff ff ff       	jmp    44385 <printer_vprintf+0x428>
        case 'X':
            base = 16;
   4445d:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   44464:	e9 1c ff ff ff       	jmp    44385 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   44469:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44470:	8b 00                	mov    (%rax),%eax
   44472:	83 f8 2f             	cmp    $0x2f,%eax
   44475:	77 30                	ja     444a7 <printer_vprintf+0x54a>
   44477:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4447e:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44482:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44489:	8b 00                	mov    (%rax),%eax
   4448b:	89 c0                	mov    %eax,%eax
   4448d:	48 01 d0             	add    %rdx,%rax
   44490:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44497:	8b 12                	mov    (%rdx),%edx
   44499:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4449c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   444a3:	89 0a                	mov    %ecx,(%rdx)
   444a5:	eb 1a                	jmp    444c1 <printer_vprintf+0x564>
   444a7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444ae:	48 8b 40 08          	mov    0x8(%rax),%rax
   444b2:	48 8d 48 08          	lea    0x8(%rax),%rcx
   444b6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   444bd:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   444c1:	48 8b 00             	mov    (%rax),%rax
   444c4:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   444c8:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   444cf:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   444d6:	e9 79 01 00 00       	jmp    44654 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
   444db:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444e2:	8b 00                	mov    (%rax),%eax
   444e4:	83 f8 2f             	cmp    $0x2f,%eax
   444e7:	77 30                	ja     44519 <printer_vprintf+0x5bc>
   444e9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444f0:	48 8b 50 10          	mov    0x10(%rax),%rdx
   444f4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444fb:	8b 00                	mov    (%rax),%eax
   444fd:	89 c0                	mov    %eax,%eax
   444ff:	48 01 d0             	add    %rdx,%rax
   44502:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44509:	8b 12                	mov    (%rdx),%edx
   4450b:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4450e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44515:	89 0a                	mov    %ecx,(%rdx)
   44517:	eb 1a                	jmp    44533 <printer_vprintf+0x5d6>
   44519:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44520:	48 8b 40 08          	mov    0x8(%rax),%rax
   44524:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44528:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4452f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44533:	48 8b 00             	mov    (%rax),%rax
   44536:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   4453a:	e9 15 01 00 00       	jmp    44654 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
   4453f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44546:	8b 00                	mov    (%rax),%eax
   44548:	83 f8 2f             	cmp    $0x2f,%eax
   4454b:	77 30                	ja     4457d <printer_vprintf+0x620>
   4454d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44554:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44558:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4455f:	8b 00                	mov    (%rax),%eax
   44561:	89 c0                	mov    %eax,%eax
   44563:	48 01 d0             	add    %rdx,%rax
   44566:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4456d:	8b 12                	mov    (%rdx),%edx
   4456f:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44572:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44579:	89 0a                	mov    %ecx,(%rdx)
   4457b:	eb 1a                	jmp    44597 <printer_vprintf+0x63a>
   4457d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44584:	48 8b 40 08          	mov    0x8(%rax),%rax
   44588:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4458c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44593:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44597:	8b 00                	mov    (%rax),%eax
   44599:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   4459f:	e9 67 03 00 00       	jmp    4490b <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
   445a4:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   445a8:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   445ac:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445b3:	8b 00                	mov    (%rax),%eax
   445b5:	83 f8 2f             	cmp    $0x2f,%eax
   445b8:	77 30                	ja     445ea <printer_vprintf+0x68d>
   445ba:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445c1:	48 8b 50 10          	mov    0x10(%rax),%rdx
   445c5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445cc:	8b 00                	mov    (%rax),%eax
   445ce:	89 c0                	mov    %eax,%eax
   445d0:	48 01 d0             	add    %rdx,%rax
   445d3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445da:	8b 12                	mov    (%rdx),%edx
   445dc:	8d 4a 08             	lea    0x8(%rdx),%ecx
   445df:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445e6:	89 0a                	mov    %ecx,(%rdx)
   445e8:	eb 1a                	jmp    44604 <printer_vprintf+0x6a7>
   445ea:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445f1:	48 8b 40 08          	mov    0x8(%rax),%rax
   445f5:	48 8d 48 08          	lea    0x8(%rax),%rcx
   445f9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44600:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44604:	8b 00                	mov    (%rax),%eax
   44606:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   44609:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   4460d:	eb 45                	jmp    44654 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
   4460f:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   44613:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   44617:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4461e:	0f b6 00             	movzbl (%rax),%eax
   44621:	84 c0                	test   %al,%al
   44623:	74 0c                	je     44631 <printer_vprintf+0x6d4>
   44625:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4462c:	0f b6 00             	movzbl (%rax),%eax
   4462f:	eb 05                	jmp    44636 <printer_vprintf+0x6d9>
   44631:	b8 25 00 00 00       	mov    $0x25,%eax
   44636:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   44639:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   4463d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44644:	0f b6 00             	movzbl (%rax),%eax
   44647:	84 c0                	test   %al,%al
   44649:	75 08                	jne    44653 <printer_vprintf+0x6f6>
                format--;
   4464b:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   44652:	01 
            }
            break;
   44653:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   44654:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44657:	83 e0 20             	and    $0x20,%eax
   4465a:	85 c0                	test   %eax,%eax
   4465c:	74 1e                	je     4467c <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   4465e:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   44662:	48 83 c0 18          	add    $0x18,%rax
   44666:	8b 55 e0             	mov    -0x20(%rbp),%edx
   44669:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   4466d:	48 89 ce             	mov    %rcx,%rsi
   44670:	48 89 c7             	mov    %rax,%rdi
   44673:	e8 63 f8 ff ff       	call   43edb <fill_numbuf>
   44678:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   4467c:	48 c7 45 c0 c6 58 04 	movq   $0x458c6,-0x40(%rbp)
   44683:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   44684:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44687:	83 e0 20             	and    $0x20,%eax
   4468a:	85 c0                	test   %eax,%eax
   4468c:	74 48                	je     446d6 <printer_vprintf+0x779>
   4468e:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44691:	83 e0 40             	and    $0x40,%eax
   44694:	85 c0                	test   %eax,%eax
   44696:	74 3e                	je     446d6 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
   44698:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4469b:	25 80 00 00 00       	and    $0x80,%eax
   446a0:	85 c0                	test   %eax,%eax
   446a2:	74 0a                	je     446ae <printer_vprintf+0x751>
                prefix = "-";
   446a4:	48 c7 45 c0 c7 58 04 	movq   $0x458c7,-0x40(%rbp)
   446ab:	00 
            if (flags & FLAG_NEGATIVE) {
   446ac:	eb 73                	jmp    44721 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   446ae:	8b 45 ec             	mov    -0x14(%rbp),%eax
   446b1:	83 e0 10             	and    $0x10,%eax
   446b4:	85 c0                	test   %eax,%eax
   446b6:	74 0a                	je     446c2 <printer_vprintf+0x765>
                prefix = "+";
   446b8:	48 c7 45 c0 c9 58 04 	movq   $0x458c9,-0x40(%rbp)
   446bf:	00 
            if (flags & FLAG_NEGATIVE) {
   446c0:	eb 5f                	jmp    44721 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   446c2:	8b 45 ec             	mov    -0x14(%rbp),%eax
   446c5:	83 e0 08             	and    $0x8,%eax
   446c8:	85 c0                	test   %eax,%eax
   446ca:	74 55                	je     44721 <printer_vprintf+0x7c4>
                prefix = " ";
   446cc:	48 c7 45 c0 cb 58 04 	movq   $0x458cb,-0x40(%rbp)
   446d3:	00 
            if (flags & FLAG_NEGATIVE) {
   446d4:	eb 4b                	jmp    44721 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   446d6:	8b 45 ec             	mov    -0x14(%rbp),%eax
   446d9:	83 e0 20             	and    $0x20,%eax
   446dc:	85 c0                	test   %eax,%eax
   446de:	74 42                	je     44722 <printer_vprintf+0x7c5>
   446e0:	8b 45 ec             	mov    -0x14(%rbp),%eax
   446e3:	83 e0 01             	and    $0x1,%eax
   446e6:	85 c0                	test   %eax,%eax
   446e8:	74 38                	je     44722 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
   446ea:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   446ee:	74 06                	je     446f6 <printer_vprintf+0x799>
   446f0:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   446f4:	75 2c                	jne    44722 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
   446f6:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   446fb:	75 0c                	jne    44709 <printer_vprintf+0x7ac>
   446fd:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44700:	25 00 01 00 00       	and    $0x100,%eax
   44705:	85 c0                	test   %eax,%eax
   44707:	74 19                	je     44722 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
   44709:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   4470d:	75 07                	jne    44716 <printer_vprintf+0x7b9>
   4470f:	b8 cd 58 04 00       	mov    $0x458cd,%eax
   44714:	eb 05                	jmp    4471b <printer_vprintf+0x7be>
   44716:	b8 d0 58 04 00       	mov    $0x458d0,%eax
   4471b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   4471f:	eb 01                	jmp    44722 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
   44721:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   44722:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   44726:	78 24                	js     4474c <printer_vprintf+0x7ef>
   44728:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4472b:	83 e0 20             	and    $0x20,%eax
   4472e:	85 c0                	test   %eax,%eax
   44730:	75 1a                	jne    4474c <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
   44732:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44735:	48 63 d0             	movslq %eax,%rdx
   44738:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4473c:	48 89 d6             	mov    %rdx,%rsi
   4473f:	48 89 c7             	mov    %rax,%rdi
   44742:	e8 ea f5 ff ff       	call   43d31 <strnlen>
   44747:	89 45 bc             	mov    %eax,-0x44(%rbp)
   4474a:	eb 0f                	jmp    4475b <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
   4474c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44750:	48 89 c7             	mov    %rax,%rdi
   44753:	e8 a8 f5 ff ff       	call   43d00 <strlen>
   44758:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   4475b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4475e:	83 e0 20             	and    $0x20,%eax
   44761:	85 c0                	test   %eax,%eax
   44763:	74 20                	je     44785 <printer_vprintf+0x828>
   44765:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   44769:	78 1a                	js     44785 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
   4476b:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4476e:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   44771:	7e 08                	jle    4477b <printer_vprintf+0x81e>
   44773:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44776:	2b 45 bc             	sub    -0x44(%rbp),%eax
   44779:	eb 05                	jmp    44780 <printer_vprintf+0x823>
   4477b:	b8 00 00 00 00       	mov    $0x0,%eax
   44780:	89 45 b8             	mov    %eax,-0x48(%rbp)
   44783:	eb 5c                	jmp    447e1 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   44785:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44788:	83 e0 20             	and    $0x20,%eax
   4478b:	85 c0                	test   %eax,%eax
   4478d:	74 4b                	je     447da <printer_vprintf+0x87d>
   4478f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44792:	83 e0 02             	and    $0x2,%eax
   44795:	85 c0                	test   %eax,%eax
   44797:	74 41                	je     447da <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
   44799:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4479c:	83 e0 04             	and    $0x4,%eax
   4479f:	85 c0                	test   %eax,%eax
   447a1:	75 37                	jne    447da <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
   447a3:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   447a7:	48 89 c7             	mov    %rax,%rdi
   447aa:	e8 51 f5 ff ff       	call   43d00 <strlen>
   447af:	89 c2                	mov    %eax,%edx
   447b1:	8b 45 bc             	mov    -0x44(%rbp),%eax
   447b4:	01 d0                	add    %edx,%eax
   447b6:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   447b9:	7e 1f                	jle    447da <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
   447bb:	8b 45 e8             	mov    -0x18(%rbp),%eax
   447be:	2b 45 bc             	sub    -0x44(%rbp),%eax
   447c1:	89 c3                	mov    %eax,%ebx
   447c3:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   447c7:	48 89 c7             	mov    %rax,%rdi
   447ca:	e8 31 f5 ff ff       	call   43d00 <strlen>
   447cf:	89 c2                	mov    %eax,%edx
   447d1:	89 d8                	mov    %ebx,%eax
   447d3:	29 d0                	sub    %edx,%eax
   447d5:	89 45 b8             	mov    %eax,-0x48(%rbp)
   447d8:	eb 07                	jmp    447e1 <printer_vprintf+0x884>
        } else {
            zeros = 0;
   447da:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   447e1:	8b 55 bc             	mov    -0x44(%rbp),%edx
   447e4:	8b 45 b8             	mov    -0x48(%rbp),%eax
   447e7:	01 d0                	add    %edx,%eax
   447e9:	48 63 d8             	movslq %eax,%rbx
   447ec:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   447f0:	48 89 c7             	mov    %rax,%rdi
   447f3:	e8 08 f5 ff ff       	call   43d00 <strlen>
   447f8:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   447fc:	8b 45 e8             	mov    -0x18(%rbp),%eax
   447ff:	29 d0                	sub    %edx,%eax
   44801:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   44804:	eb 25                	jmp    4482b <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
   44806:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4480d:	48 8b 08             	mov    (%rax),%rcx
   44810:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44816:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4481d:	be 20 00 00 00       	mov    $0x20,%esi
   44822:	48 89 c7             	mov    %rax,%rdi
   44825:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   44827:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   4482b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4482e:	83 e0 04             	and    $0x4,%eax
   44831:	85 c0                	test   %eax,%eax
   44833:	75 36                	jne    4486b <printer_vprintf+0x90e>
   44835:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   44839:	7f cb                	jg     44806 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
   4483b:	eb 2e                	jmp    4486b <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
   4483d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44844:	4c 8b 00             	mov    (%rax),%r8
   44847:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4484b:	0f b6 00             	movzbl (%rax),%eax
   4484e:	0f b6 c8             	movzbl %al,%ecx
   44851:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44857:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4485e:	89 ce                	mov    %ecx,%esi
   44860:	48 89 c7             	mov    %rax,%rdi
   44863:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   44866:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   4486b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4486f:	0f b6 00             	movzbl (%rax),%eax
   44872:	84 c0                	test   %al,%al
   44874:	75 c7                	jne    4483d <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
   44876:	eb 25                	jmp    4489d <printer_vprintf+0x940>
            p->putc(p, '0', color);
   44878:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4487f:	48 8b 08             	mov    (%rax),%rcx
   44882:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44888:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4488f:	be 30 00 00 00       	mov    $0x30,%esi
   44894:	48 89 c7             	mov    %rax,%rdi
   44897:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   44899:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   4489d:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   448a1:	7f d5                	jg     44878 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
   448a3:	eb 32                	jmp    448d7 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
   448a5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   448ac:	4c 8b 00             	mov    (%rax),%r8
   448af:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   448b3:	0f b6 00             	movzbl (%rax),%eax
   448b6:	0f b6 c8             	movzbl %al,%ecx
   448b9:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   448bf:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   448c6:	89 ce                	mov    %ecx,%esi
   448c8:	48 89 c7             	mov    %rax,%rdi
   448cb:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   448ce:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   448d3:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   448d7:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   448db:	7f c8                	jg     448a5 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
   448dd:	eb 25                	jmp    44904 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
   448df:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   448e6:	48 8b 08             	mov    (%rax),%rcx
   448e9:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   448ef:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   448f6:	be 20 00 00 00       	mov    $0x20,%esi
   448fb:	48 89 c7             	mov    %rax,%rdi
   448fe:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   44900:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   44904:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   44908:	7f d5                	jg     448df <printer_vprintf+0x982>
        }
    done: ;
   4490a:	90                   	nop
    for (; *format; ++format) {
   4490b:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44912:	01 
   44913:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4491a:	0f b6 00             	movzbl (%rax),%eax
   4491d:	84 c0                	test   %al,%al
   4491f:	0f 85 64 f6 ff ff    	jne    43f89 <printer_vprintf+0x2c>
    }
}
   44925:	90                   	nop
   44926:	90                   	nop
   44927:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   4492b:	c9                   	leave  
   4492c:	c3                   	ret    

000000000004492d <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   4492d:	55                   	push   %rbp
   4492e:	48 89 e5             	mov    %rsp,%rbp
   44931:	48 83 ec 20          	sub    $0x20,%rsp
   44935:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44939:	89 f0                	mov    %esi,%eax
   4493b:	89 55 e0             	mov    %edx,-0x20(%rbp)
   4493e:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   44941:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44945:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   44949:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4494d:	48 8b 40 08          	mov    0x8(%rax),%rax
   44951:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
   44956:	48 39 d0             	cmp    %rdx,%rax
   44959:	72 0c                	jb     44967 <console_putc+0x3a>
        cp->cursor = console;
   4495b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4495f:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
   44966:	00 
    }
    if (c == '\n') {
   44967:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   4496b:	75 78                	jne    449e5 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
   4496d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44971:	48 8b 40 08          	mov    0x8(%rax),%rax
   44975:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   4497b:	48 d1 f8             	sar    %rax
   4497e:	48 89 c1             	mov    %rax,%rcx
   44981:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   44988:	66 66 66 
   4498b:	48 89 c8             	mov    %rcx,%rax
   4498e:	48 f7 ea             	imul   %rdx
   44991:	48 c1 fa 05          	sar    $0x5,%rdx
   44995:	48 89 c8             	mov    %rcx,%rax
   44998:	48 c1 f8 3f          	sar    $0x3f,%rax
   4499c:	48 29 c2             	sub    %rax,%rdx
   4499f:	48 89 d0             	mov    %rdx,%rax
   449a2:	48 c1 e0 02          	shl    $0x2,%rax
   449a6:	48 01 d0             	add    %rdx,%rax
   449a9:	48 c1 e0 04          	shl    $0x4,%rax
   449ad:	48 29 c1             	sub    %rax,%rcx
   449b0:	48 89 ca             	mov    %rcx,%rdx
   449b3:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   449b6:	eb 25                	jmp    449dd <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
   449b8:	8b 45 e0             	mov    -0x20(%rbp),%eax
   449bb:	83 c8 20             	or     $0x20,%eax
   449be:	89 c6                	mov    %eax,%esi
   449c0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   449c4:	48 8b 40 08          	mov    0x8(%rax),%rax
   449c8:	48 8d 48 02          	lea    0x2(%rax),%rcx
   449cc:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   449d0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   449d4:	89 f2                	mov    %esi,%edx
   449d6:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   449d9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   449dd:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   449e1:	75 d5                	jne    449b8 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   449e3:	eb 24                	jmp    44a09 <console_putc+0xdc>
        *cp->cursor++ = c | color;
   449e5:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
   449e9:	8b 55 e0             	mov    -0x20(%rbp),%edx
   449ec:	09 d0                	or     %edx,%eax
   449ee:	89 c6                	mov    %eax,%esi
   449f0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   449f4:	48 8b 40 08          	mov    0x8(%rax),%rax
   449f8:	48 8d 48 02          	lea    0x2(%rax),%rcx
   449fc:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   44a00:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44a04:	89 f2                	mov    %esi,%edx
   44a06:	66 89 10             	mov    %dx,(%rax)
}
   44a09:	90                   	nop
   44a0a:	c9                   	leave  
   44a0b:	c3                   	ret    

0000000000044a0c <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   44a0c:	55                   	push   %rbp
   44a0d:	48 89 e5             	mov    %rsp,%rbp
   44a10:	48 83 ec 30          	sub    $0x30,%rsp
   44a14:	89 7d ec             	mov    %edi,-0x14(%rbp)
   44a17:	89 75 e8             	mov    %esi,-0x18(%rbp)
   44a1a:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   44a1e:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   44a22:	48 c7 45 f0 2d 49 04 	movq   $0x4492d,-0x10(%rbp)
   44a29:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   44a2a:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   44a2e:	78 09                	js     44a39 <console_vprintf+0x2d>
   44a30:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   44a37:	7e 07                	jle    44a40 <console_vprintf+0x34>
        cpos = 0;
   44a39:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   44a40:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44a43:	48 98                	cltq   
   44a45:	48 01 c0             	add    %rax,%rax
   44a48:	48 05 00 80 0b 00    	add    $0xb8000,%rax
   44a4e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   44a52:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   44a56:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   44a5a:	8b 75 e8             	mov    -0x18(%rbp),%esi
   44a5d:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   44a61:	48 89 c7             	mov    %rax,%rdi
   44a64:	e8 f4 f4 ff ff       	call   43f5d <printer_vprintf>
    return cp.cursor - console;
   44a69:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44a6d:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   44a73:	48 d1 f8             	sar    %rax
}
   44a76:	c9                   	leave  
   44a77:	c3                   	ret    

0000000000044a78 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   44a78:	55                   	push   %rbp
   44a79:	48 89 e5             	mov    %rsp,%rbp
   44a7c:	48 83 ec 60          	sub    $0x60,%rsp
   44a80:	89 7d ac             	mov    %edi,-0x54(%rbp)
   44a83:	89 75 a8             	mov    %esi,-0x58(%rbp)
   44a86:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   44a8a:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44a8e:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44a92:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44a96:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   44a9d:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44aa1:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   44aa5:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44aa9:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   44aad:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   44ab1:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   44ab5:	8b 75 a8             	mov    -0x58(%rbp),%esi
   44ab8:	8b 45 ac             	mov    -0x54(%rbp),%eax
   44abb:	89 c7                	mov    %eax,%edi
   44abd:	e8 4a ff ff ff       	call   44a0c <console_vprintf>
   44ac2:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   44ac5:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   44ac8:	c9                   	leave  
   44ac9:	c3                   	ret    

0000000000044aca <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   44aca:	55                   	push   %rbp
   44acb:	48 89 e5             	mov    %rsp,%rbp
   44ace:	48 83 ec 20          	sub    $0x20,%rsp
   44ad2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44ad6:	89 f0                	mov    %esi,%eax
   44ad8:	89 55 e0             	mov    %edx,-0x20(%rbp)
   44adb:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   44ade:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44ae2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   44ae6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44aea:	48 8b 50 08          	mov    0x8(%rax),%rdx
   44aee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44af2:	48 8b 40 10          	mov    0x10(%rax),%rax
   44af6:	48 39 c2             	cmp    %rax,%rdx
   44af9:	73 1a                	jae    44b15 <string_putc+0x4b>
        *sp->s++ = c;
   44afb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44aff:	48 8b 40 08          	mov    0x8(%rax),%rax
   44b03:	48 8d 48 01          	lea    0x1(%rax),%rcx
   44b07:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   44b0b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44b0f:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   44b13:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   44b15:	90                   	nop
   44b16:	c9                   	leave  
   44b17:	c3                   	ret    

0000000000044b18 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   44b18:	55                   	push   %rbp
   44b19:	48 89 e5             	mov    %rsp,%rbp
   44b1c:	48 83 ec 40          	sub    $0x40,%rsp
   44b20:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   44b24:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   44b28:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   44b2c:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   44b30:	48 c7 45 e8 ca 4a 04 	movq   $0x44aca,-0x18(%rbp)
   44b37:	00 
    sp.s = s;
   44b38:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44b3c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   44b40:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   44b45:	74 33                	je     44b7a <vsnprintf+0x62>
        sp.end = s + size - 1;
   44b47:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   44b4b:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   44b4f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44b53:	48 01 d0             	add    %rdx,%rax
   44b56:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   44b5a:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   44b5e:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   44b62:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   44b66:	be 00 00 00 00       	mov    $0x0,%esi
   44b6b:	48 89 c7             	mov    %rax,%rdi
   44b6e:	e8 ea f3 ff ff       	call   43f5d <printer_vprintf>
        *sp.s = 0;
   44b73:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44b77:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   44b7a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44b7e:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   44b82:	c9                   	leave  
   44b83:	c3                   	ret    

0000000000044b84 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   44b84:	55                   	push   %rbp
   44b85:	48 89 e5             	mov    %rsp,%rbp
   44b88:	48 83 ec 70          	sub    $0x70,%rsp
   44b8c:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   44b90:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   44b94:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   44b98:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44b9c:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44ba0:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44ba4:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   44bab:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44baf:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   44bb3:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44bb7:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   44bbb:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   44bbf:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   44bc3:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   44bc7:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44bcb:	48 89 c7             	mov    %rax,%rdi
   44bce:	e8 45 ff ff ff       	call   44b18 <vsnprintf>
   44bd3:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   44bd6:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   44bd9:	c9                   	leave  
   44bda:	c3                   	ret    

0000000000044bdb <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   44bdb:	55                   	push   %rbp
   44bdc:	48 89 e5             	mov    %rsp,%rbp
   44bdf:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44be3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   44bea:	eb 13                	jmp    44bff <console_clear+0x24>
        console[i] = ' ' | 0x0700;
   44bec:	8b 45 fc             	mov    -0x4(%rbp),%eax
   44bef:	48 98                	cltq   
   44bf1:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
   44bf8:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44bfb:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44bff:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   44c06:	7e e4                	jle    44bec <console_clear+0x11>
    }
    cursorpos = 0;
   44c08:	c7 05 ea 43 07 00 00 	movl   $0x0,0x743ea(%rip)        # b8ffc <cursorpos>
   44c0f:	00 00 00 
}
   44c12:	90                   	nop
   44c13:	c9                   	leave  
   44c14:	c3                   	ret    
