
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
   40173:	e8 a0 14 00 00       	call   41618 <hardware_init>
    pageinfo_init();
   40178:	e8 14 0b 00 00       	call   40c91 <pageinfo_init>
    console_clear();
   4017d:	e8 3e 4a 00 00       	call   44bc0 <console_clear>
    timer_init(HZ);
   40182:	bf 64 00 00 00       	mov    $0x64,%edi
   40187:	e8 78 19 00 00       	call   41b04 <timer_init>

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   4018c:	ba 00 0f 00 00       	mov    $0xf00,%edx
   40191:	be 00 00 00 00       	mov    $0x0,%esi
   40196:	bf 00 e0 04 00       	mov    $0x4e000,%edi
   4019b:	e8 06 3b 00 00       	call   43ca6 <memset>
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
   401fe:	be 26 4c 04 00       	mov    $0x44c26,%esi
   40203:	48 89 c7             	mov    %rax,%rdi
   40206:	e8 94 3b 00 00       	call   43d9f <strcmp>
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
   40236:	e8 64 3b 00 00       	call   43d9f <strcmp>
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
   40263:	e8 37 3b 00 00       	call   43d9f <strcmp>
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
   40290:	e8 0a 3b 00 00       	call   43d9f <strcmp>
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
   402d1:	e8 2a 09 00 00       	call   40c00 <run>

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
   40306:	e8 8a 1a 00 00       	call   41d95 <process_init>
    assert(process_config_tables(pid) == 0);
   4030b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4030e:	89 c7                	mov    %eax,%edi
   40310:	e8 5a 31 00 00       	call   4346f <process_config_tables>
   40315:	85 c0                	test   %eax,%eax
   40317:	74 14                	je     4032d <process_setup+0x57>
   40319:	ba 48 4c 04 00       	mov    $0x44c48,%edx
   4031e:	be 77 00 00 00       	mov    $0x77,%esi
   40323:	bf 68 4c 04 00       	mov    $0x44c68,%edi
   40328:	e8 36 22 00 00       	call   42563 <assert_fail>

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
   40350:	e8 68 34 00 00       	call   437bd <process_load>
   40355:	85 c0                	test   %eax,%eax
   40357:	79 14                	jns    4036d <process_setup+0x97>
   40359:	ba 78 4c 04 00       	mov    $0x44c78,%edx
   4035e:	be 7a 00 00 00       	mov    $0x7a,%esi
   40363:	bf 68 4c 04 00       	mov    $0x44c68,%edi
   40368:	e8 f6 21 00 00       	call   42563 <assert_fail>

    process_setup_stack(&processes[pid]);
   4036d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40370:	48 63 d0             	movslq %eax,%rdx
   40373:	48 89 d0             	mov    %rdx,%rax
   40376:	48 c1 e0 04          	shl    $0x4,%rax
   4037a:	48 29 d0             	sub    %rdx,%rax
   4037d:	48 c1 e0 04          	shl    $0x4,%rax
   40381:	48 05 00 e0 04 00    	add    $0x4e000,%rax
   40387:	48 89 c7             	mov    %rax,%rdi
   4038a:	e8 66 34 00 00       	call   437f5 <process_setup_stack>

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
   40434:	e8 6f 34 00 00       	call   438a8 <process_fork>
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
   4044a:	e8 3e 2d 00 00       	call   4318d <process_free>
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
   4046f:	e8 c6 36 00 00       	call   43b3a <process_page_alloc>
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
	if (newbrk < p->original_break || newbrk >= MEMSIZE_VIRTUAL - PAGESIZE) {
   404ae:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   404b2:	48 8b 40 10          	mov    0x10(%rax),%rax
   404b6:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   404ba:	72 0a                	jb     404c6 <brk+0x50>
   404bc:	48 81 7d f0 ff ef 2f 	cmpq   $0x2fefff,-0x10(%rbp)
   404c3:	00 
   404c4:	76 16                	jbe    404dc <brk+0x66>
		p->p_registers.reg_rax = 0;
   404c6:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   404ca:	48 c7 40 18 00 00 00 	movq   $0x0,0x18(%rax)
   404d1:	00 
		return -1;
   404d2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   404d7:	e9 da 00 00 00       	jmp    405b6 <brk+0x140>
	}

	// handle unmap on contraction
	if (newbrk < oldbrk) {
   404dc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   404e0:	48 3b 45 e8          	cmp    -0x18(%rbp),%rax
   404e4:	0f 83 af 00 00 00    	jae    40599 <brk+0x123>
		// TODO
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
   40510:	e8 10 27 00 00       	call   42c25 <virtual_memory_lookup>
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
   40546:	e8 17 23 00 00       	call   42862 <virtual_memory_map>
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
   405f4:	74 07                	je     405fd <sbrk+0x45>
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
   4064d:	e8 d3 25 00 00       	call   42c25 <virtual_memory_lookup>

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
   4069f:	e8 81 25 00 00       	call   42c25 <virtual_memory_lookup>
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
   406cb:	e8 55 25 00 00       	call   42c25 <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   406d0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   406d4:	48 89 c1             	mov    %rax,%rcx
   406d7:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   406db:	ba 18 00 00 00       	mov    $0x18,%edx
   406e0:	48 89 c6             	mov    %rax,%rsi
   406e3:	48 89 cf             	mov    %rcx,%rdi
   406e6:	e8 bd 34 00 00       	call   43ba8 <memcpy>
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
   4076e:	48 8b 05 8b e7 00 00 	mov    0xe78b(%rip),%rax        # 4ef00 <current>
   40775:	48 8b 95 08 ff ff ff 	mov    -0xf8(%rbp),%rdx
   4077c:	48 83 c0 18          	add    $0x18,%rax
   40780:	48 89 d6             	mov    %rdx,%rsi
   40783:	ba 18 00 00 00       	mov    $0x18,%edx
   40788:	48 89 c7             	mov    %rax,%rdi
   4078b:	48 89 d1             	mov    %rdx,%rcx
   4078e:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   40791:	48 8b 05 68 08 01 00 	mov    0x10868(%rip),%rax        # 51000 <kernel_pagetable>
   40798:	48 89 c7             	mov    %rax,%rdi
   4079b:	e8 91 1f 00 00       	call   42731 <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   407a0:	8b 05 56 88 07 00    	mov    0x78856(%rip),%eax        # b8ffc <cursorpos>
   407a6:	89 c7                	mov    %eax,%edi
   407a8:	e8 b2 16 00 00       	call   41e5f <console_show_cursor>
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
   407eb:	e8 38 08 00 00       	call   41028 <check_virtual_memory>
        if(disp_global){
   407f0:	0f b6 05 09 58 00 00 	movzbl 0x5809(%rip),%eax        # 46000 <disp_global>
   407f7:	84 c0                	test   %al,%al
   407f9:	74 0a                	je     40805 <exception+0xa9>
            memshow_physical();
   407fb:	e8 a0 09 00 00       	call   411a0 <memshow_physical>
            memshow_virtual_animate();
   40800:	e8 ca 0c 00 00       	call   414cf <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   40805:	e8 38 1b 00 00       	call   42342 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   4080a:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40811:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40818:	48 83 e8 0e          	sub    $0xe,%rax
   4081c:	48 83 f8 2c          	cmp    $0x2c,%rax
   40820:	0f 87 2b 03 00 00    	ja     40b51 <exception+0x3f5>
   40826:	48 8b 04 c5 38 4d 04 	mov    0x44d38(,%rax,8),%rax
   4082d:	00 
   4082e:	ff e0                	jmp    *%rax
        case INT_SYS_PANIC:
            {
                // rdi stores pointer for msg string
                {
                    char msg[160];
                    uintptr_t addr = current->p_registers.reg_rdi;
   40830:	48 8b 05 c9 e6 00 00 	mov    0xe6c9(%rip),%rax        # 4ef00 <current>
   40837:	48 8b 40 48          	mov    0x48(%rax),%rax
   4083b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                    if((void *)addr == NULL)
   4083f:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   40844:	75 0f                	jne    40855 <exception+0xf9>
                        kernel_panic(NULL);
   40846:	bf 00 00 00 00       	mov    $0x0,%edi
   4084b:	b8 00 00 00 00       	mov    $0x0,%eax
   40850:	e8 2e 1c 00 00       	call   42483 <kernel_panic>
                    vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   40855:	48 8b 05 a4 e6 00 00 	mov    0xe6a4(%rip),%rax        # 4ef00 <current>
   4085c:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40863:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   40867:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4086b:	48 89 ce             	mov    %rcx,%rsi
   4086e:	48 89 c7             	mov    %rax,%rdi
   40871:	e8 af 23 00 00       	call   42c25 <virtual_memory_lookup>
                    memcpy(msg, (void *)map.pa, 160);
   40876:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4087a:	48 89 c1             	mov    %rax,%rcx
   4087d:	48 8d 85 10 ff ff ff 	lea    -0xf0(%rbp),%rax
   40884:	ba a0 00 00 00       	mov    $0xa0,%edx
   40889:	48 89 ce             	mov    %rcx,%rsi
   4088c:	48 89 c7             	mov    %rax,%rdi
   4088f:	e8 14 33 00 00       	call   43ba8 <memcpy>
                    kernel_panic(msg);
   40894:	48 8d 85 10 ff ff ff 	lea    -0xf0(%rbp),%rax
   4089b:	48 89 c7             	mov    %rax,%rdi
   4089e:	b8 00 00 00 00       	mov    $0x0,%eax
   408a3:	e8 db 1b 00 00       	call   42483 <kernel_panic>
                kernel_panic(NULL);
                break;                  // will not be reached
            }
        case INT_SYS_GETPID:
            {
                current->p_registers.reg_rax = current->p_pid;
   408a8:	48 8b 05 51 e6 00 00 	mov    0xe651(%rip),%rax        # 4ef00 <current>
   408af:	8b 10                	mov    (%rax),%edx
   408b1:	48 8b 05 48 e6 00 00 	mov    0xe648(%rip),%rax        # 4ef00 <current>
   408b8:	48 63 d2             	movslq %edx,%rdx
   408bb:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   408bf:	e9 9d 02 00 00       	jmp    40b61 <exception+0x405>
            }
        case INT_SYS_FORK:
            {
                current->p_registers.reg_rax = syscall_fork();
   408c4:	b8 00 00 00 00       	mov    $0x0,%eax
   408c9:	e8 58 fb ff ff       	call   40426 <syscall_fork>
   408ce:	89 c2                	mov    %eax,%edx
   408d0:	48 8b 05 29 e6 00 00 	mov    0xe629(%rip),%rax        # 4ef00 <current>
   408d7:	48 63 d2             	movslq %edx,%rdx
   408da:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   408de:	e9 7e 02 00 00       	jmp    40b61 <exception+0x405>
            }
        case INT_SYS_MAPPING:
            {
                syscall_mapping(current);
   408e3:	48 8b 05 16 e6 00 00 	mov    0xe616(%rip),%rax        # 4ef00 <current>
   408ea:	48 89 c7             	mov    %rax,%rdi
   408ed:	e8 1e fd ff ff       	call   40610 <syscall_mapping>
                break;
   408f2:	e9 6a 02 00 00       	jmp    40b61 <exception+0x405>
            }

        case INT_SYS_EXIT:
            {
                syscall_exit();
   408f7:	b8 00 00 00 00       	mov    $0x0,%eax
   408fc:	e8 3a fb ff ff       	call   4043b <syscall_exit>
                schedule();
   40901:	e8 84 02 00 00       	call   40b8a <schedule>
                break;
   40906:	e9 56 02 00 00       	jmp    40b61 <exception+0x405>
            }

        case INT_SYS_YIELD:
            {
                schedule();
   4090b:	e8 7a 02 00 00       	call   40b8a <schedule>
                break;                  /* will not be reached */
   40910:	e9 4c 02 00 00       	jmp    40b61 <exception+0x405>
            }

        case INT_SYS_BRK:
            {
                // TODO : Your code here
		reg->reg_rax = brk(current, reg->reg_rdi);
   40915:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   4091c:	48 8b 50 30          	mov    0x30(%rax),%rdx
   40920:	48 8b 05 d9 e5 00 00 	mov    0xe5d9(%rip),%rax        # 4ef00 <current>
   40927:	48 89 d6             	mov    %rdx,%rsi
   4092a:	48 89 c7             	mov    %rax,%rdi
   4092d:	e8 44 fb ff ff       	call   40476 <brk>
   40932:	48 63 d0             	movslq %eax,%rdx
   40935:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   4093c:	48 89 10             	mov    %rdx,(%rax)
		break;
   4093f:	e9 1d 02 00 00       	jmp    40b61 <exception+0x405>
            }

        case INT_SYS_SBRK:
            {
                // TODO : Your code here
		reg->reg_rax = sbrk(current, reg->reg_rdi);
   40944:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   4094b:	48 8b 40 30          	mov    0x30(%rax),%rax
   4094f:	48 89 c2             	mov    %rax,%rdx
   40952:	48 8b 05 a7 e5 00 00 	mov    0xe5a7(%rip),%rax        # 4ef00 <current>
   40959:	48 89 d6             	mov    %rdx,%rsi
   4095c:	48 89 c7             	mov    %rax,%rdi
   4095f:	e8 54 fc ff ff       	call   405b8 <sbrk>
   40964:	48 63 d0             	movslq %eax,%rdx
   40967:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   4096e:	48 89 10             	mov    %rdx,(%rax)
                break;
   40971:	e9 eb 01 00 00       	jmp    40b61 <exception+0x405>
            }
	case INT_SYS_PAGE_ALLOC:
	    {
		intptr_t addr = reg->reg_rdi;
   40976:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   4097d:	48 8b 40 30          	mov    0x30(%rax),%rax
   40981:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
		syscall_page_alloc(addr);
   40985:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40989:	48 89 c7             	mov    %rax,%rdi
   4098c:	e8 c1 fa ff ff       	call   40452 <syscall_page_alloc>
		break;
   40991:	e9 cb 01 00 00       	jmp    40b61 <exception+0x405>
	    }
        case INT_SYS_MEM_TOG:
            {
                syscall_mem_tog(current);
   40996:	48 8b 05 63 e5 00 00 	mov    0xe563(%rip),%rax        # 4ef00 <current>
   4099d:	48 89 c7             	mov    %rax,%rdi
   409a0:	e8 4e fd ff ff       	call   406f3 <syscall_mem_tog>
                break;
   409a5:	e9 b7 01 00 00       	jmp    40b61 <exception+0x405>
            }

        case INT_TIMER:
            {
                ++ticks;
   409aa:	8b 05 70 e9 00 00    	mov    0xe970(%rip),%eax        # 4f320 <ticks>
   409b0:	83 c0 01             	add    $0x1,%eax
   409b3:	89 05 67 e9 00 00    	mov    %eax,0xe967(%rip)        # 4f320 <ticks>
                schedule();
   409b9:	e8 cc 01 00 00       	call   40b8a <schedule>
                break;                  /* will not be reached */
   409be:	e9 9e 01 00 00       	jmp    40b61 <exception+0x405>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   409c3:	0f 20 d0             	mov    %cr2,%rax
   409c6:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    return val;
   409ca:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
            }

        case INT_PAGEFAULT: 
            {
                // Analyze faulting address and access type.
                uintptr_t addr = rcr2();
   409ce:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
		    // log_printf("\theap bottom: 0x%x\n", current->original_break);
		    // log_printf("\theap top: 0x%x\n", current->program_break);
		// unsure if second check is redundant?
		if (//reg->reg_err != PFERR_PRESENT 
		    //&& 
		    addr >= current->original_break && addr < current->program_break) {
   409d2:	48 8b 05 27 e5 00 00 	mov    0xe527(%rip),%rax        # 4ef00 <current>
   409d9:	48 8b 40 10          	mov    0x10(%rax),%rax
		if (//reg->reg_err != PFERR_PRESENT 
   409dd:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   409e1:	72 76                	jb     40a59 <exception+0x2fd>
		    addr >= current->original_break && addr < current->program_break) {
   409e3:	48 8b 05 16 e5 00 00 	mov    0xe516(%rip),%rax        # 4ef00 <current>
   409ea:	48 8b 40 08          	mov    0x8(%rax),%rax
   409ee:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   409f2:	73 65                	jae    40a59 <exception+0x2fd>
			uintptr_t pa = (uintptr_t) palloc(current->p_pid);
   409f4:	48 8b 05 05 e5 00 00 	mov    0xe505(%rip),%rax        # 4ef00 <current>
   409fb:	8b 00                	mov    (%rax),%eax
   409fd:	89 c7                	mov    %eax,%edi
   409ff:	e8 70 26 00 00       	call   43074 <palloc>
   40a04:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
			if (pa) {
   40a08:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   40a0d:	74 3b                	je     40a4a <exception+0x2ee>
				virtual_memory_map(current->p_pagetable, PAGEADDRESS(PAGENUMBER(addr)), pa, PAGESIZE, PTE_P | PTE_U | PTE_W);
   40a0f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40a13:	48 c1 e8 0c          	shr    $0xc,%rax
   40a17:	48 98                	cltq   
   40a19:	48 c1 e0 0c          	shl    $0xc,%rax
   40a1d:	48 89 c6             	mov    %rax,%rsi
   40a20:	48 8b 05 d9 e4 00 00 	mov    0xe4d9(%rip),%rax        # 4ef00 <current>
   40a27:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40a2e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   40a32:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40a38:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40a3d:	48 89 c7             	mov    %rax,%rdi
   40a40:	e8 1d 1e 00 00       	call   42862 <virtual_memory_map>
		    addr >= current->original_break && addr < current->program_break) {
   40a45:	e9 05 01 00 00       	jmp    40b4f <exception+0x3f3>
			} 
			else {
				syscall_exit();
   40a4a:	b8 00 00 00 00       	mov    $0x0,%eax
   40a4f:	e8 e7 f9 ff ff       	call   4043b <syscall_exit>
		    addr >= current->original_break && addr < current->program_break) {
   40a54:	e9 f6 00 00 00       	jmp    40b4f <exception+0x3f3>
			}
		} else {
			const char* operation = reg->reg_err & PFERR_WRITE
   40a59:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40a60:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40a67:	83 e0 02             	and    $0x2,%eax
			    ? "write" : "read";
   40a6a:	48 85 c0             	test   %rax,%rax
   40a6d:	74 07                	je     40a76 <exception+0x31a>
   40a6f:	b8 ab 4c 04 00       	mov    $0x44cab,%eax
   40a74:	eb 05                	jmp    40a7b <exception+0x31f>
   40a76:	b8 b1 4c 04 00       	mov    $0x44cb1,%eax
			const char* operation = reg->reg_err & PFERR_WRITE
   40a7b:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
			const char* problem = reg->reg_err & PFERR_PRESENT
   40a7f:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40a86:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40a8d:	83 e0 01             	and    $0x1,%eax
			    ? "protection problem" : "missing page";
   40a90:	48 85 c0             	test   %rax,%rax
   40a93:	74 07                	je     40a9c <exception+0x340>
   40a95:	b8 b6 4c 04 00       	mov    $0x44cb6,%eax
   40a9a:	eb 05                	jmp    40aa1 <exception+0x345>
   40a9c:	b8 c9 4c 04 00       	mov    $0x44cc9,%eax
			const char* problem = reg->reg_err & PFERR_PRESENT
   40aa1:	48 89 45 d0          	mov    %rax,-0x30(%rbp)

			if (!(reg->reg_err & PFERR_USER)) {
   40aa5:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40aac:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40ab3:	83 e0 04             	and    $0x4,%eax
   40ab6:	48 85 c0             	test   %rax,%rax
   40ab9:	75 2f                	jne    40aea <exception+0x38e>
			    kernel_panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   40abb:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40ac2:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   40ac9:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
   40acd:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   40ad1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40ad5:	49 89 f0             	mov    %rsi,%r8
   40ad8:	48 89 c6             	mov    %rax,%rsi
   40adb:	bf d8 4c 04 00       	mov    $0x44cd8,%edi
   40ae0:	b8 00 00 00 00       	mov    $0x0,%eax
   40ae5:	e8 99 19 00 00       	call   42483 <kernel_panic>
				    addr, operation, problem, reg->reg_rip);
			}
			console_printf(CPOS(24, 0), 0x0C00,
   40aea:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40af1:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
				"Process %d page fault for %p (%s %s, rip=%p)!\n",
				current->p_pid, addr, operation, problem, reg->reg_rip);
   40af8:	48 8b 05 01 e4 00 00 	mov    0xe401(%rip),%rax        # 4ef00 <current>
			console_printf(CPOS(24, 0), 0x0C00,
   40aff:	8b 00                	mov    (%rax),%eax
   40b01:	48 8b 75 d8          	mov    -0x28(%rbp),%rsi
   40b05:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   40b09:	52                   	push   %rdx
   40b0a:	ff 75 d0             	push   -0x30(%rbp)
   40b0d:	49 89 f1             	mov    %rsi,%r9
   40b10:	49 89 c8             	mov    %rcx,%r8
   40b13:	89 c1                	mov    %eax,%ecx
   40b15:	ba 08 4d 04 00       	mov    $0x44d08,%edx
   40b1a:	be 00 0c 00 00       	mov    $0xc00,%esi
   40b1f:	bf 80 07 00 00       	mov    $0x780,%edi
   40b24:	b8 00 00 00 00       	mov    $0x0,%eax
   40b29:	e8 2f 3f 00 00       	call   44a5d <console_printf>
   40b2e:	48 83 c4 10          	add    $0x10,%rsp
			current->p_state = P_BROKEN;
   40b32:	48 8b 05 c7 e3 00 00 	mov    0xe3c7(%rip),%rax        # 4ef00 <current>
   40b39:	c7 80 d8 00 00 00 03 	movl   $0x3,0xd8(%rax)
   40b40:	00 00 00 
			syscall_exit();
   40b43:	b8 00 00 00 00       	mov    $0x0,%eax
   40b48:	e8 ee f8 ff ff       	call   4043b <syscall_exit>
		}
                break;
   40b4d:	eb 12                	jmp    40b61 <exception+0x405>
   40b4f:	eb 10                	jmp    40b61 <exception+0x405>
            }

        default:
            default_exception(current);
   40b51:	48 8b 05 a8 e3 00 00 	mov    0xe3a8(%rip),%rax        # 4ef00 <current>
   40b58:	48 89 c7             	mov    %rax,%rdi
   40b5b:	e8 33 1a 00 00       	call   42593 <default_exception>
            break;                  /* will not be reached */
   40b60:	90                   	nop

    }

    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   40b61:	48 8b 05 98 e3 00 00 	mov    0xe398(%rip),%rax        # 4ef00 <current>
   40b68:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   40b6e:	83 f8 01             	cmp    $0x1,%eax
   40b71:	75 0f                	jne    40b82 <exception+0x426>
        run(current);
   40b73:	48 8b 05 86 e3 00 00 	mov    0xe386(%rip),%rax        # 4ef00 <current>
   40b7a:	48 89 c7             	mov    %rax,%rdi
   40b7d:	e8 7e 00 00 00       	call   40c00 <run>
    } else {
        schedule();
   40b82:	e8 03 00 00 00       	call   40b8a <schedule>
    }
}
   40b87:	90                   	nop
   40b88:	c9                   	leave  
   40b89:	c3                   	ret    

0000000000040b8a <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   40b8a:	55                   	push   %rbp
   40b8b:	48 89 e5             	mov    %rsp,%rbp
   40b8e:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   40b92:	48 8b 05 67 e3 00 00 	mov    0xe367(%rip),%rax        # 4ef00 <current>
   40b99:	8b 00                	mov    (%rax),%eax
   40b9b:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   40b9e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40ba1:	8d 50 01             	lea    0x1(%rax),%edx
   40ba4:	89 d0                	mov    %edx,%eax
   40ba6:	c1 f8 1f             	sar    $0x1f,%eax
   40ba9:	c1 e8 1c             	shr    $0x1c,%eax
   40bac:	01 c2                	add    %eax,%edx
   40bae:	83 e2 0f             	and    $0xf,%edx
   40bb1:	29 c2                	sub    %eax,%edx
   40bb3:	89 55 fc             	mov    %edx,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   40bb6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40bb9:	48 63 d0             	movslq %eax,%rdx
   40bbc:	48 89 d0             	mov    %rdx,%rax
   40bbf:	48 c1 e0 04          	shl    $0x4,%rax
   40bc3:	48 29 d0             	sub    %rdx,%rax
   40bc6:	48 c1 e0 04          	shl    $0x4,%rax
   40bca:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   40bd0:	8b 00                	mov    (%rax),%eax
   40bd2:	83 f8 01             	cmp    $0x1,%eax
   40bd5:	75 22                	jne    40bf9 <schedule+0x6f>
            run(&processes[pid]);
   40bd7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40bda:	48 63 d0             	movslq %eax,%rdx
   40bdd:	48 89 d0             	mov    %rdx,%rax
   40be0:	48 c1 e0 04          	shl    $0x4,%rax
   40be4:	48 29 d0             	sub    %rdx,%rax
   40be7:	48 c1 e0 04          	shl    $0x4,%rax
   40beb:	48 05 00 e0 04 00    	add    $0x4e000,%rax
   40bf1:	48 89 c7             	mov    %rax,%rdi
   40bf4:	e8 07 00 00 00       	call   40c00 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   40bf9:	e8 44 17 00 00       	call   42342 <check_keyboard>
        pid = (pid + 1) % NPROC;
   40bfe:	eb 9e                	jmp    40b9e <schedule+0x14>

0000000000040c00 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   40c00:	55                   	push   %rbp
   40c01:	48 89 e5             	mov    %rsp,%rbp
   40c04:	48 83 ec 10          	sub    $0x10,%rsp
   40c08:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   40c0c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c10:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   40c16:	83 f8 01             	cmp    $0x1,%eax
   40c19:	74 14                	je     40c2f <run+0x2f>
   40c1b:	ba a0 4e 04 00       	mov    $0x44ea0,%edx
   40c20:	be b3 01 00 00       	mov    $0x1b3,%esi
   40c25:	bf 68 4c 04 00       	mov    $0x44c68,%edi
   40c2a:	e8 34 19 00 00       	call   42563 <assert_fail>
    current = p;
   40c2f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c33:	48 89 05 c6 e2 00 00 	mov    %rax,0xe2c6(%rip)        # 4ef00 <current>

    // display running process in CONSOLE last value
    console_printf(CPOS(24, 79),
   40c3a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c3e:	8b 10                	mov    (%rax),%edx
            memstate_colors[p->p_pid - PO_KERNEL], "%d", p->p_pid);
   40c40:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c44:	8b 00                	mov    (%rax),%eax
   40c46:	83 c0 02             	add    $0x2,%eax
   40c49:	48 98                	cltq   
   40c4b:	0f b7 84 00 00 4c 04 	movzwl 0x44c00(%rax,%rax,1),%eax
   40c52:	00 
    console_printf(CPOS(24, 79),
   40c53:	0f b7 c0             	movzwl %ax,%eax
   40c56:	89 d1                	mov    %edx,%ecx
   40c58:	ba b9 4e 04 00       	mov    $0x44eb9,%edx
   40c5d:	89 c6                	mov    %eax,%esi
   40c5f:	bf cf 07 00 00       	mov    $0x7cf,%edi
   40c64:	b8 00 00 00 00       	mov    $0x0,%eax
   40c69:	e8 ef 3d 00 00       	call   44a5d <console_printf>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   40c6e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c72:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40c79:	48 89 c7             	mov    %rax,%rdi
   40c7c:	e8 b0 1a 00 00       	call   42731 <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   40c81:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c85:	48 83 c0 18          	add    $0x18,%rax
   40c89:	48 89 c7             	mov    %rax,%rdi
   40c8c:	e8 32 f4 ff ff       	call   400c3 <exception_return>

0000000000040c91 <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   40c91:	55                   	push   %rbp
   40c92:	48 89 e5             	mov    %rsp,%rbp
   40c95:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40c99:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40ca0:	00 
   40ca1:	e9 81 00 00 00       	jmp    40d27 <pageinfo_init+0x96>
        int owner;
        if (physical_memory_isreserved(addr)) {
   40ca6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40caa:	48 89 c7             	mov    %rax,%rdi
   40cad:	e8 1e 0f 00 00       	call   41bd0 <physical_memory_isreserved>
   40cb2:	85 c0                	test   %eax,%eax
   40cb4:	74 09                	je     40cbf <pageinfo_init+0x2e>
            owner = PO_RESERVED;
   40cb6:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   40cbd:	eb 2f                	jmp    40cee <pageinfo_init+0x5d>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   40cbf:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   40cc6:	00 
   40cc7:	76 0b                	jbe    40cd4 <pageinfo_init+0x43>
   40cc9:	b8 10 70 05 00       	mov    $0x57010,%eax
   40cce:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40cd2:	72 0a                	jb     40cde <pageinfo_init+0x4d>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   40cd4:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   40cdb:	00 
   40cdc:	75 09                	jne    40ce7 <pageinfo_init+0x56>
            owner = PO_KERNEL;
   40cde:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   40ce5:	eb 07                	jmp    40cee <pageinfo_init+0x5d>
        } else {
            owner = PO_FREE;
   40ce7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40cee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40cf2:	48 c1 e8 0c          	shr    $0xc,%rax
   40cf6:	89 c1                	mov    %eax,%ecx
   40cf8:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40cfb:	89 c2                	mov    %eax,%edx
   40cfd:	48 63 c1             	movslq %ecx,%rax
   40d00:	88 94 00 20 ef 04 00 	mov    %dl,0x4ef20(%rax,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   40d07:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40d0b:	0f 95 c2             	setne  %dl
   40d0e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d12:	48 c1 e8 0c          	shr    $0xc,%rax
   40d16:	48 98                	cltq   
   40d18:	88 94 00 21 ef 04 00 	mov    %dl,0x4ef21(%rax,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40d1f:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40d26:	00 
   40d27:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40d2e:	00 
   40d2f:	0f 86 71 ff ff ff    	jbe    40ca6 <pageinfo_init+0x15>
    }
}
   40d35:	90                   	nop
   40d36:	90                   	nop
   40d37:	c9                   	leave  
   40d38:	c3                   	ret    

0000000000040d39 <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   40d39:	55                   	push   %rbp
   40d3a:	48 89 e5             	mov    %rsp,%rbp
   40d3d:	48 83 ec 50          	sub    $0x50,%rsp
   40d41:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   40d45:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40d49:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40d4f:	48 89 c2             	mov    %rax,%rdx
   40d52:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40d56:	48 39 c2             	cmp    %rax,%rdx
   40d59:	74 14                	je     40d6f <check_page_table_mappings+0x36>
   40d5b:	ba c0 4e 04 00       	mov    $0x44ec0,%edx
   40d60:	be e1 01 00 00       	mov    $0x1e1,%esi
   40d65:	bf 68 4c 04 00       	mov    $0x44c68,%edi
   40d6a:	e8 f4 17 00 00       	call   42563 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40d6f:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   40d76:	00 
   40d77:	e9 9a 00 00 00       	jmp    40e16 <check_page_table_mappings+0xdd>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   40d7c:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   40d80:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40d84:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40d88:	48 89 ce             	mov    %rcx,%rsi
   40d8b:	48 89 c7             	mov    %rax,%rdi
   40d8e:	e8 92 1e 00 00       	call   42c25 <virtual_memory_lookup>
        if (vam.pa != va) {
   40d93:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40d97:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40d9b:	74 27                	je     40dc4 <check_page_table_mappings+0x8b>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   40d9d:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40da1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40da5:	49 89 d0             	mov    %rdx,%r8
   40da8:	48 89 c1             	mov    %rax,%rcx
   40dab:	ba df 4e 04 00       	mov    $0x44edf,%edx
   40db0:	be 00 c0 00 00       	mov    $0xc000,%esi
   40db5:	bf e0 06 00 00       	mov    $0x6e0,%edi
   40dba:	b8 00 00 00 00       	mov    $0x0,%eax
   40dbf:	e8 99 3c 00 00       	call   44a5d <console_printf>
        }
        assert(vam.pa == va);
   40dc4:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40dc8:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40dcc:	74 14                	je     40de2 <check_page_table_mappings+0xa9>
   40dce:	ba e9 4e 04 00       	mov    $0x44ee9,%edx
   40dd3:	be ea 01 00 00       	mov    $0x1ea,%esi
   40dd8:	bf 68 4c 04 00       	mov    $0x44c68,%edi
   40ddd:	e8 81 17 00 00       	call   42563 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   40de2:	b8 00 60 04 00       	mov    $0x46000,%eax
   40de7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40deb:	72 21                	jb     40e0e <check_page_table_mappings+0xd5>
            assert(vam.perm & PTE_W);
   40ded:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40df0:	48 98                	cltq   
   40df2:	83 e0 02             	and    $0x2,%eax
   40df5:	48 85 c0             	test   %rax,%rax
   40df8:	75 14                	jne    40e0e <check_page_table_mappings+0xd5>
   40dfa:	ba f6 4e 04 00       	mov    $0x44ef6,%edx
   40dff:	be ec 01 00 00       	mov    $0x1ec,%esi
   40e04:	bf 68 4c 04 00       	mov    $0x44c68,%edi
   40e09:	e8 55 17 00 00       	call   42563 <assert_fail>
         va += PAGESIZE) {
   40e0e:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40e15:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40e16:	b8 10 70 05 00       	mov    $0x57010,%eax
   40e1b:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40e1f:	0f 82 57 ff ff ff    	jb     40d7c <check_page_table_mappings+0x43>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   40e25:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   40e2c:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   40e2d:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   40e31:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40e35:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40e39:	48 89 ce             	mov    %rcx,%rsi
   40e3c:	48 89 c7             	mov    %rax,%rdi
   40e3f:	e8 e1 1d 00 00       	call   42c25 <virtual_memory_lookup>
    assert(vam.pa == kstack);
   40e44:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40e48:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   40e4c:	74 14                	je     40e62 <check_page_table_mappings+0x129>
   40e4e:	ba 07 4f 04 00       	mov    $0x44f07,%edx
   40e53:	be f3 01 00 00       	mov    $0x1f3,%esi
   40e58:	bf 68 4c 04 00       	mov    $0x44c68,%edi
   40e5d:	e8 01 17 00 00       	call   42563 <assert_fail>
    assert(vam.perm & PTE_W);
   40e62:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40e65:	48 98                	cltq   
   40e67:	83 e0 02             	and    $0x2,%eax
   40e6a:	48 85 c0             	test   %rax,%rax
   40e6d:	75 14                	jne    40e83 <check_page_table_mappings+0x14a>
   40e6f:	ba f6 4e 04 00       	mov    $0x44ef6,%edx
   40e74:	be f4 01 00 00       	mov    $0x1f4,%esi
   40e79:	bf 68 4c 04 00       	mov    $0x44c68,%edi
   40e7e:	e8 e0 16 00 00       	call   42563 <assert_fail>
}
   40e83:	90                   	nop
   40e84:	c9                   	leave  
   40e85:	c3                   	ret    

0000000000040e86 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   40e86:	55                   	push   %rbp
   40e87:	48 89 e5             	mov    %rsp,%rbp
   40e8a:	48 83 ec 20          	sub    $0x20,%rsp
   40e8e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40e92:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   40e95:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40e98:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   40e9b:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   40ea2:	48 8b 05 57 01 01 00 	mov    0x10157(%rip),%rax        # 51000 <kernel_pagetable>
   40ea9:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40ead:	75 67                	jne    40f16 <check_page_table_ownership+0x90>
        owner = PO_KERNEL;
   40eaf:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40eb6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   40ebd:	eb 51                	jmp    40f10 <check_page_table_ownership+0x8a>
            if (processes[xpid].p_state != P_FREE
   40ebf:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40ec2:	48 63 d0             	movslq %eax,%rdx
   40ec5:	48 89 d0             	mov    %rdx,%rax
   40ec8:	48 c1 e0 04          	shl    $0x4,%rax
   40ecc:	48 29 d0             	sub    %rdx,%rax
   40ecf:	48 c1 e0 04          	shl    $0x4,%rax
   40ed3:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   40ed9:	8b 00                	mov    (%rax),%eax
   40edb:	85 c0                	test   %eax,%eax
   40edd:	74 2d                	je     40f0c <check_page_table_ownership+0x86>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   40edf:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40ee2:	48 63 d0             	movslq %eax,%rdx
   40ee5:	48 89 d0             	mov    %rdx,%rax
   40ee8:	48 c1 e0 04          	shl    $0x4,%rax
   40eec:	48 29 d0             	sub    %rdx,%rax
   40eef:	48 c1 e0 04          	shl    $0x4,%rax
   40ef3:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   40ef9:	48 8b 10             	mov    (%rax),%rdx
   40efc:	48 8b 05 fd 00 01 00 	mov    0x100fd(%rip),%rax        # 51000 <kernel_pagetable>
   40f03:	48 39 c2             	cmp    %rax,%rdx
   40f06:	75 04                	jne    40f0c <check_page_table_ownership+0x86>
                ++expected_refcount;
   40f08:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40f0c:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   40f10:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   40f14:	7e a9                	jle    40ebf <check_page_table_ownership+0x39>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   40f16:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   40f19:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40f1c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40f20:	be 00 00 00 00       	mov    $0x0,%esi
   40f25:	48 89 c7             	mov    %rax,%rdi
   40f28:	e8 03 00 00 00       	call   40f30 <check_page_table_ownership_level>
}
   40f2d:	90                   	nop
   40f2e:	c9                   	leave  
   40f2f:	c3                   	ret    

0000000000040f30 <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   40f30:	55                   	push   %rbp
   40f31:	48 89 e5             	mov    %rsp,%rbp
   40f34:	48 83 ec 30          	sub    $0x30,%rsp
   40f38:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40f3c:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   40f3f:	89 55 e0             	mov    %edx,-0x20(%rbp)
   40f42:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   40f45:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40f49:	48 c1 e8 0c          	shr    $0xc,%rax
   40f4d:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   40f52:	7e 14                	jle    40f68 <check_page_table_ownership_level+0x38>
   40f54:	ba 18 4f 04 00       	mov    $0x44f18,%edx
   40f59:	be 11 02 00 00       	mov    $0x211,%esi
   40f5e:	bf 68 4c 04 00       	mov    $0x44c68,%edi
   40f63:	e8 fb 15 00 00       	call   42563 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   40f68:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40f6c:	48 c1 e8 0c          	shr    $0xc,%rax
   40f70:	48 98                	cltq   
   40f72:	0f b6 84 00 20 ef 04 	movzbl 0x4ef20(%rax,%rax,1),%eax
   40f79:	00 
   40f7a:	0f be c0             	movsbl %al,%eax
   40f7d:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   40f80:	74 14                	je     40f96 <check_page_table_ownership_level+0x66>
   40f82:	ba 30 4f 04 00       	mov    $0x44f30,%edx
   40f87:	be 12 02 00 00       	mov    $0x212,%esi
   40f8c:	bf 68 4c 04 00       	mov    $0x44c68,%edi
   40f91:	e8 cd 15 00 00       	call   42563 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   40f96:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40f9a:	48 c1 e8 0c          	shr    $0xc,%rax
   40f9e:	48 98                	cltq   
   40fa0:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   40fa7:	00 
   40fa8:	0f be c0             	movsbl %al,%eax
   40fab:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   40fae:	74 14                	je     40fc4 <check_page_table_ownership_level+0x94>
   40fb0:	ba 58 4f 04 00       	mov    $0x44f58,%edx
   40fb5:	be 13 02 00 00       	mov    $0x213,%esi
   40fba:	bf 68 4c 04 00       	mov    $0x44c68,%edi
   40fbf:	e8 9f 15 00 00       	call   42563 <assert_fail>
    if (level < 3) {
   40fc4:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   40fc8:	7f 5b                	jg     41025 <check_page_table_ownership_level+0xf5>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   40fca:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   40fd1:	eb 49                	jmp    4101c <check_page_table_ownership_level+0xec>
            if (pt->entry[index]) {
   40fd3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40fd7:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40fda:	48 63 d2             	movslq %edx,%rdx
   40fdd:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   40fe1:	48 85 c0             	test   %rax,%rax
   40fe4:	74 32                	je     41018 <check_page_table_ownership_level+0xe8>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   40fe6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40fea:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40fed:	48 63 d2             	movslq %edx,%rdx
   40ff0:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   40ff4:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   40ffa:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   40ffe:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   41001:	8d 70 01             	lea    0x1(%rax),%esi
   41004:	8b 55 e0             	mov    -0x20(%rbp),%edx
   41007:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4100b:	b9 01 00 00 00       	mov    $0x1,%ecx
   41010:	48 89 c7             	mov    %rax,%rdi
   41013:	e8 18 ff ff ff       	call   40f30 <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   41018:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4101c:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41023:	7e ae                	jle    40fd3 <check_page_table_ownership_level+0xa3>
            }
        }
    }
}
   41025:	90                   	nop
   41026:	c9                   	leave  
   41027:	c3                   	ret    

0000000000041028 <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   41028:	55                   	push   %rbp
   41029:	48 89 e5             	mov    %rsp,%rbp
   4102c:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   41030:	8b 05 a2 d0 00 00    	mov    0xd0a2(%rip),%eax        # 4e0d8 <processes+0xd8>
   41036:	85 c0                	test   %eax,%eax
   41038:	74 14                	je     4104e <check_virtual_memory+0x26>
   4103a:	ba 88 4f 04 00       	mov    $0x44f88,%edx
   4103f:	be 26 02 00 00       	mov    $0x226,%esi
   41044:	bf 68 4c 04 00       	mov    $0x44c68,%edi
   41049:	e8 15 15 00 00       	call   42563 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   4104e:	48 8b 05 ab ff 00 00 	mov    0xffab(%rip),%rax        # 51000 <kernel_pagetable>
   41055:	48 89 c7             	mov    %rax,%rdi
   41058:	e8 dc fc ff ff       	call   40d39 <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   4105d:	48 8b 05 9c ff 00 00 	mov    0xff9c(%rip),%rax        # 51000 <kernel_pagetable>
   41064:	be ff ff ff ff       	mov    $0xffffffff,%esi
   41069:	48 89 c7             	mov    %rax,%rdi
   4106c:	e8 15 fe ff ff       	call   40e86 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   41071:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41078:	e9 9c 00 00 00       	jmp    41119 <check_virtual_memory+0xf1>
        if (processes[pid].p_state != P_FREE
   4107d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41080:	48 63 d0             	movslq %eax,%rdx
   41083:	48 89 d0             	mov    %rdx,%rax
   41086:	48 c1 e0 04          	shl    $0x4,%rax
   4108a:	48 29 d0             	sub    %rdx,%rax
   4108d:	48 c1 e0 04          	shl    $0x4,%rax
   41091:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   41097:	8b 00                	mov    (%rax),%eax
   41099:	85 c0                	test   %eax,%eax
   4109b:	74 78                	je     41115 <check_virtual_memory+0xed>
            && processes[pid].p_pagetable != kernel_pagetable) {
   4109d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   410a0:	48 63 d0             	movslq %eax,%rdx
   410a3:	48 89 d0             	mov    %rdx,%rax
   410a6:	48 c1 e0 04          	shl    $0x4,%rax
   410aa:	48 29 d0             	sub    %rdx,%rax
   410ad:	48 c1 e0 04          	shl    $0x4,%rax
   410b1:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   410b7:	48 8b 10             	mov    (%rax),%rdx
   410ba:	48 8b 05 3f ff 00 00 	mov    0xff3f(%rip),%rax        # 51000 <kernel_pagetable>
   410c1:	48 39 c2             	cmp    %rax,%rdx
   410c4:	74 4f                	je     41115 <check_virtual_memory+0xed>
            check_page_table_mappings(processes[pid].p_pagetable);
   410c6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   410c9:	48 63 d0             	movslq %eax,%rdx
   410cc:	48 89 d0             	mov    %rdx,%rax
   410cf:	48 c1 e0 04          	shl    $0x4,%rax
   410d3:	48 29 d0             	sub    %rdx,%rax
   410d6:	48 c1 e0 04          	shl    $0x4,%rax
   410da:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   410e0:	48 8b 00             	mov    (%rax),%rax
   410e3:	48 89 c7             	mov    %rax,%rdi
   410e6:	e8 4e fc ff ff       	call   40d39 <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   410eb:	8b 45 fc             	mov    -0x4(%rbp),%eax
   410ee:	48 63 d0             	movslq %eax,%rdx
   410f1:	48 89 d0             	mov    %rdx,%rax
   410f4:	48 c1 e0 04          	shl    $0x4,%rax
   410f8:	48 29 d0             	sub    %rdx,%rax
   410fb:	48 c1 e0 04          	shl    $0x4,%rax
   410ff:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   41105:	48 8b 00             	mov    (%rax),%rax
   41108:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4110b:	89 d6                	mov    %edx,%esi
   4110d:	48 89 c7             	mov    %rax,%rdi
   41110:	e8 71 fd ff ff       	call   40e86 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   41115:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41119:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   4111d:	0f 8e 5a ff ff ff    	jle    4107d <check_virtual_memory+0x55>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41123:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   4112a:	eb 67                	jmp    41193 <check_virtual_memory+0x16b>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   4112c:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4112f:	48 98                	cltq   
   41131:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   41138:	00 
   41139:	84 c0                	test   %al,%al
   4113b:	7e 52                	jle    4118f <check_virtual_memory+0x167>
   4113d:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41140:	48 98                	cltq   
   41142:	0f b6 84 00 20 ef 04 	movzbl 0x4ef20(%rax,%rax,1),%eax
   41149:	00 
   4114a:	84 c0                	test   %al,%al
   4114c:	78 41                	js     4118f <check_virtual_memory+0x167>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   4114e:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41151:	48 98                	cltq   
   41153:	0f b6 84 00 20 ef 04 	movzbl 0x4ef20(%rax,%rax,1),%eax
   4115a:	00 
   4115b:	0f be c0             	movsbl %al,%eax
   4115e:	48 63 d0             	movslq %eax,%rdx
   41161:	48 89 d0             	mov    %rdx,%rax
   41164:	48 c1 e0 04          	shl    $0x4,%rax
   41168:	48 29 d0             	sub    %rdx,%rax
   4116b:	48 c1 e0 04          	shl    $0x4,%rax
   4116f:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   41175:	8b 00                	mov    (%rax),%eax
   41177:	85 c0                	test   %eax,%eax
   41179:	75 14                	jne    4118f <check_virtual_memory+0x167>
   4117b:	ba a8 4f 04 00       	mov    $0x44fa8,%edx
   41180:	be 3d 02 00 00       	mov    $0x23d,%esi
   41185:	bf 68 4c 04 00       	mov    $0x44c68,%edi
   4118a:	e8 d4 13 00 00       	call   42563 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4118f:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41193:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   4119a:	7e 90                	jle    4112c <check_virtual_memory+0x104>
        }
    }
}
   4119c:	90                   	nop
   4119d:	90                   	nop
   4119e:	c9                   	leave  
   4119f:	c3                   	ret    

00000000000411a0 <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   411a0:	55                   	push   %rbp
   411a1:	48 89 e5             	mov    %rsp,%rbp
   411a4:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   411a8:	ba d8 4f 04 00       	mov    $0x44fd8,%edx
   411ad:	be 00 0f 00 00       	mov    $0xf00,%esi
   411b2:	bf 20 00 00 00       	mov    $0x20,%edi
   411b7:	b8 00 00 00 00       	mov    $0x0,%eax
   411bc:	e8 9c 38 00 00       	call   44a5d <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   411c1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   411c8:	e9 f8 00 00 00       	jmp    412c5 <memshow_physical+0x125>
        if (pn % 64 == 0) {
   411cd:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411d0:	83 e0 3f             	and    $0x3f,%eax
   411d3:	85 c0                	test   %eax,%eax
   411d5:	75 3c                	jne    41213 <memshow_physical+0x73>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   411d7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411da:	c1 e0 0c             	shl    $0xc,%eax
   411dd:	89 c1                	mov    %eax,%ecx
   411df:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411e2:	8d 50 3f             	lea    0x3f(%rax),%edx
   411e5:	85 c0                	test   %eax,%eax
   411e7:	0f 48 c2             	cmovs  %edx,%eax
   411ea:	c1 f8 06             	sar    $0x6,%eax
   411ed:	8d 50 01             	lea    0x1(%rax),%edx
   411f0:	89 d0                	mov    %edx,%eax
   411f2:	c1 e0 02             	shl    $0x2,%eax
   411f5:	01 d0                	add    %edx,%eax
   411f7:	c1 e0 04             	shl    $0x4,%eax
   411fa:	83 c0 03             	add    $0x3,%eax
   411fd:	ba e8 4f 04 00       	mov    $0x44fe8,%edx
   41202:	be 00 0f 00 00       	mov    $0xf00,%esi
   41207:	89 c7                	mov    %eax,%edi
   41209:	b8 00 00 00 00       	mov    $0x0,%eax
   4120e:	e8 4a 38 00 00       	call   44a5d <console_printf>
        }

        int owner = pageinfo[pn].owner;
   41213:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41216:	48 98                	cltq   
   41218:	0f b6 84 00 20 ef 04 	movzbl 0x4ef20(%rax,%rax,1),%eax
   4121f:	00 
   41220:	0f be c0             	movsbl %al,%eax
   41223:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   41226:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41229:	48 98                	cltq   
   4122b:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   41232:	00 
   41233:	84 c0                	test   %al,%al
   41235:	75 07                	jne    4123e <memshow_physical+0x9e>
            owner = PO_FREE;
   41237:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   4123e:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41241:	83 c0 02             	add    $0x2,%eax
   41244:	48 98                	cltq   
   41246:	0f b7 84 00 00 4c 04 	movzwl 0x44c00(%rax,%rax,1),%eax
   4124d:	00 
   4124e:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   41252:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41255:	48 98                	cltq   
   41257:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   4125e:	00 
   4125f:	3c 01                	cmp    $0x1,%al
   41261:	7e 1a                	jle    4127d <memshow_physical+0xdd>
   41263:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   41268:	48 c1 e8 0c          	shr    $0xc,%rax
   4126c:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   4126f:	74 0c                	je     4127d <memshow_physical+0xdd>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   41271:	b8 53 00 00 00       	mov    $0x53,%eax
   41276:	80 cc 0f             	or     $0xf,%ah
   41279:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   4127d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41280:	8d 50 3f             	lea    0x3f(%rax),%edx
   41283:	85 c0                	test   %eax,%eax
   41285:	0f 48 c2             	cmovs  %edx,%eax
   41288:	c1 f8 06             	sar    $0x6,%eax
   4128b:	8d 50 01             	lea    0x1(%rax),%edx
   4128e:	89 d0                	mov    %edx,%eax
   41290:	c1 e0 02             	shl    $0x2,%eax
   41293:	01 d0                	add    %edx,%eax
   41295:	c1 e0 04             	shl    $0x4,%eax
   41298:	89 c1                	mov    %eax,%ecx
   4129a:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4129d:	89 d0                	mov    %edx,%eax
   4129f:	c1 f8 1f             	sar    $0x1f,%eax
   412a2:	c1 e8 1a             	shr    $0x1a,%eax
   412a5:	01 c2                	add    %eax,%edx
   412a7:	83 e2 3f             	and    $0x3f,%edx
   412aa:	29 c2                	sub    %eax,%edx
   412ac:	89 d0                	mov    %edx,%eax
   412ae:	83 c0 0c             	add    $0xc,%eax
   412b1:	01 c8                	add    %ecx,%eax
   412b3:	48 98                	cltq   
   412b5:	0f b7 55 f6          	movzwl -0xa(%rbp),%edx
   412b9:	66 89 94 00 00 80 0b 	mov    %dx,0xb8000(%rax,%rax,1)
   412c0:	00 
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   412c1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   412c5:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   412cc:	0f 8e fb fe ff ff    	jle    411cd <memshow_physical+0x2d>
    }
}
   412d2:	90                   	nop
   412d3:	90                   	nop
   412d4:	c9                   	leave  
   412d5:	c3                   	ret    

00000000000412d6 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   412d6:	55                   	push   %rbp
   412d7:	48 89 e5             	mov    %rsp,%rbp
   412da:	48 83 ec 40          	sub    $0x40,%rsp
   412de:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   412e2:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   412e6:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   412ea:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   412f0:	48 89 c2             	mov    %rax,%rdx
   412f3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   412f7:	48 39 c2             	cmp    %rax,%rdx
   412fa:	74 14                	je     41310 <memshow_virtual+0x3a>
   412fc:	ba f0 4f 04 00       	mov    $0x44ff0,%edx
   41301:	be 6e 02 00 00       	mov    $0x26e,%esi
   41306:	bf 68 4c 04 00       	mov    $0x44c68,%edi
   4130b:	e8 53 12 00 00       	call   42563 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   41310:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   41314:	48 89 c1             	mov    %rax,%rcx
   41317:	ba 1d 50 04 00       	mov    $0x4501d,%edx
   4131c:	be 00 0f 00 00       	mov    $0xf00,%esi
   41321:	bf 3a 03 00 00       	mov    $0x33a,%edi
   41326:	b8 00 00 00 00       	mov    $0x0,%eax
   4132b:	e8 2d 37 00 00       	call   44a5d <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41330:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   41337:	00 
   41338:	e9 80 01 00 00       	jmp    414bd <memshow_virtual+0x1e7>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   4133d:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   41341:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   41345:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   41349:	48 89 ce             	mov    %rcx,%rsi
   4134c:	48 89 c7             	mov    %rax,%rdi
   4134f:	e8 d1 18 00 00       	call   42c25 <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   41354:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41357:	85 c0                	test   %eax,%eax
   41359:	79 0b                	jns    41366 <memshow_virtual+0x90>
            color = ' ';
   4135b:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   41361:	e9 d7 00 00 00       	jmp    4143d <memshow_virtual+0x167>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   41366:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4136a:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   41370:	76 14                	jbe    41386 <memshow_virtual+0xb0>
   41372:	ba 3a 50 04 00       	mov    $0x4503a,%edx
   41377:	be 77 02 00 00       	mov    $0x277,%esi
   4137c:	bf 68 4c 04 00       	mov    $0x44c68,%edi
   41381:	e8 dd 11 00 00       	call   42563 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   41386:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41389:	48 98                	cltq   
   4138b:	0f b6 84 00 20 ef 04 	movzbl 0x4ef20(%rax,%rax,1),%eax
   41392:	00 
   41393:	0f be c0             	movsbl %al,%eax
   41396:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   41399:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4139c:	48 98                	cltq   
   4139e:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   413a5:	00 
   413a6:	84 c0                	test   %al,%al
   413a8:	75 07                	jne    413b1 <memshow_virtual+0xdb>
                owner = PO_FREE;
   413aa:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   413b1:	8b 45 f0             	mov    -0x10(%rbp),%eax
   413b4:	83 c0 02             	add    $0x2,%eax
   413b7:	48 98                	cltq   
   413b9:	0f b7 84 00 00 4c 04 	movzwl 0x44c00(%rax,%rax,1),%eax
   413c0:	00 
   413c1:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   413c5:	8b 45 e0             	mov    -0x20(%rbp),%eax
   413c8:	48 98                	cltq   
   413ca:	83 e0 04             	and    $0x4,%eax
   413cd:	48 85 c0             	test   %rax,%rax
   413d0:	74 27                	je     413f9 <memshow_virtual+0x123>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   413d2:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   413d6:	c1 e0 04             	shl    $0x4,%eax
   413d9:	66 25 00 f0          	and    $0xf000,%ax
   413dd:	89 c2                	mov    %eax,%edx
   413df:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   413e3:	c1 f8 04             	sar    $0x4,%eax
   413e6:	66 25 00 0f          	and    $0xf00,%ax
   413ea:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   413ec:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   413f0:	0f b6 c0             	movzbl %al,%eax
   413f3:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   413f5:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   413f9:	8b 45 d0             	mov    -0x30(%rbp),%eax
   413fc:	48 98                	cltq   
   413fe:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   41405:	00 
   41406:	3c 01                	cmp    $0x1,%al
   41408:	7e 33                	jle    4143d <memshow_virtual+0x167>
   4140a:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   4140f:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41413:	74 28                	je     4143d <memshow_virtual+0x167>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   41415:	b8 53 00 00 00       	mov    $0x53,%eax
   4141a:	89 c2                	mov    %eax,%edx
   4141c:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41420:	66 25 00 f0          	and    $0xf000,%ax
   41424:	09 d0                	or     %edx,%eax
   41426:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   4142a:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4142d:	48 98                	cltq   
   4142f:	83 e0 04             	and    $0x4,%eax
   41432:	48 85 c0             	test   %rax,%rax
   41435:	75 06                	jne    4143d <memshow_virtual+0x167>
                    color = color | 0x0F00;
   41437:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   4143d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41441:	48 c1 e8 0c          	shr    $0xc,%rax
   41445:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   41448:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4144b:	83 e0 3f             	and    $0x3f,%eax
   4144e:	85 c0                	test   %eax,%eax
   41450:	75 34                	jne    41486 <memshow_virtual+0x1b0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   41452:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41455:	c1 e8 06             	shr    $0x6,%eax
   41458:	89 c2                	mov    %eax,%edx
   4145a:	89 d0                	mov    %edx,%eax
   4145c:	c1 e0 02             	shl    $0x2,%eax
   4145f:	01 d0                	add    %edx,%eax
   41461:	c1 e0 04             	shl    $0x4,%eax
   41464:	05 73 03 00 00       	add    $0x373,%eax
   41469:	89 c7                	mov    %eax,%edi
   4146b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4146f:	48 89 c1             	mov    %rax,%rcx
   41472:	ba e8 4f 04 00       	mov    $0x44fe8,%edx
   41477:	be 00 0f 00 00       	mov    $0xf00,%esi
   4147c:	b8 00 00 00 00       	mov    $0x0,%eax
   41481:	e8 d7 35 00 00       	call   44a5d <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   41486:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41489:	c1 e8 06             	shr    $0x6,%eax
   4148c:	89 c2                	mov    %eax,%edx
   4148e:	89 d0                	mov    %edx,%eax
   41490:	c1 e0 02             	shl    $0x2,%eax
   41493:	01 d0                	add    %edx,%eax
   41495:	c1 e0 04             	shl    $0x4,%eax
   41498:	89 c2                	mov    %eax,%edx
   4149a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4149d:	83 e0 3f             	and    $0x3f,%eax
   414a0:	01 d0                	add    %edx,%eax
   414a2:	05 7c 03 00 00       	add    $0x37c,%eax
   414a7:	89 c2                	mov    %eax,%edx
   414a9:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   414ad:	66 89 84 12 00 80 0b 	mov    %ax,0xb8000(%rdx,%rdx,1)
   414b4:	00 
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   414b5:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   414bc:	00 
   414bd:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   414c4:	00 
   414c5:	0f 86 72 fe ff ff    	jbe    4133d <memshow_virtual+0x67>
    }
}
   414cb:	90                   	nop
   414cc:	90                   	nop
   414cd:	c9                   	leave  
   414ce:	c3                   	ret    

00000000000414cf <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   414cf:	55                   	push   %rbp
   414d0:	48 89 e5             	mov    %rsp,%rbp
   414d3:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   414d7:	8b 05 47 de 00 00    	mov    0xde47(%rip),%eax        # 4f324 <last_ticks.1>
   414dd:	85 c0                	test   %eax,%eax
   414df:	74 13                	je     414f4 <memshow_virtual_animate+0x25>
   414e1:	8b 15 39 de 00 00    	mov    0xde39(%rip),%edx        # 4f320 <ticks>
   414e7:	8b 05 37 de 00 00    	mov    0xde37(%rip),%eax        # 4f324 <last_ticks.1>
   414ed:	29 c2                	sub    %eax,%edx
   414ef:	83 fa 31             	cmp    $0x31,%edx
   414f2:	76 2c                	jbe    41520 <memshow_virtual_animate+0x51>
        last_ticks = ticks;
   414f4:	8b 05 26 de 00 00    	mov    0xde26(%rip),%eax        # 4f320 <ticks>
   414fa:	89 05 24 de 00 00    	mov    %eax,0xde24(%rip)        # 4f324 <last_ticks.1>
        ++showing;
   41500:	8b 05 fe 4a 00 00    	mov    0x4afe(%rip),%eax        # 46004 <showing.0>
   41506:	83 c0 01             	add    $0x1,%eax
   41509:	89 05 f5 4a 00 00    	mov    %eax,0x4af5(%rip)        # 46004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   4150f:	eb 0f                	jmp    41520 <memshow_virtual_animate+0x51>
           && processes[showing % NPROC].p_state == P_FREE) {
        ++showing;
   41511:	8b 05 ed 4a 00 00    	mov    0x4aed(%rip),%eax        # 46004 <showing.0>
   41517:	83 c0 01             	add    $0x1,%eax
   4151a:	89 05 e4 4a 00 00    	mov    %eax,0x4ae4(%rip)        # 46004 <showing.0>
    while (showing <= 2*NPROC
   41520:	8b 05 de 4a 00 00    	mov    0x4ade(%rip),%eax        # 46004 <showing.0>
           && processes[showing % NPROC].p_state == P_FREE) {
   41526:	83 f8 20             	cmp    $0x20,%eax
   41529:	7f 34                	jg     4155f <memshow_virtual_animate+0x90>
   4152b:	8b 15 d3 4a 00 00    	mov    0x4ad3(%rip),%edx        # 46004 <showing.0>
   41531:	89 d0                	mov    %edx,%eax
   41533:	c1 f8 1f             	sar    $0x1f,%eax
   41536:	c1 e8 1c             	shr    $0x1c,%eax
   41539:	01 c2                	add    %eax,%edx
   4153b:	83 e2 0f             	and    $0xf,%edx
   4153e:	29 c2                	sub    %eax,%edx
   41540:	89 d0                	mov    %edx,%eax
   41542:	48 63 d0             	movslq %eax,%rdx
   41545:	48 89 d0             	mov    %rdx,%rax
   41548:	48 c1 e0 04          	shl    $0x4,%rax
   4154c:	48 29 d0             	sub    %rdx,%rax
   4154f:	48 c1 e0 04          	shl    $0x4,%rax
   41553:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   41559:	8b 00                	mov    (%rax),%eax
   4155b:	85 c0                	test   %eax,%eax
   4155d:	74 b2                	je     41511 <memshow_virtual_animate+0x42>
    }
    showing = showing % NPROC;
   4155f:	8b 15 9f 4a 00 00    	mov    0x4a9f(%rip),%edx        # 46004 <showing.0>
   41565:	89 d0                	mov    %edx,%eax
   41567:	c1 f8 1f             	sar    $0x1f,%eax
   4156a:	c1 e8 1c             	shr    $0x1c,%eax
   4156d:	01 c2                	add    %eax,%edx
   4156f:	83 e2 0f             	and    $0xf,%edx
   41572:	29 c2                	sub    %eax,%edx
   41574:	89 d0                	mov    %edx,%eax
   41576:	89 05 88 4a 00 00    	mov    %eax,0x4a88(%rip)        # 46004 <showing.0>

    if (processes[showing].p_state != P_FREE && processes[showing].display_status) {
   4157c:	8b 05 82 4a 00 00    	mov    0x4a82(%rip),%eax        # 46004 <showing.0>
   41582:	48 63 d0             	movslq %eax,%rdx
   41585:	48 89 d0             	mov    %rdx,%rax
   41588:	48 c1 e0 04          	shl    $0x4,%rax
   4158c:	48 29 d0             	sub    %rdx,%rax
   4158f:	48 c1 e0 04          	shl    $0x4,%rax
   41593:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   41599:	8b 00                	mov    (%rax),%eax
   4159b:	85 c0                	test   %eax,%eax
   4159d:	74 76                	je     41615 <memshow_virtual_animate+0x146>
   4159f:	8b 05 5f 4a 00 00    	mov    0x4a5f(%rip),%eax        # 46004 <showing.0>
   415a5:	48 63 d0             	movslq %eax,%rdx
   415a8:	48 89 d0             	mov    %rdx,%rax
   415ab:	48 c1 e0 04          	shl    $0x4,%rax
   415af:	48 29 d0             	sub    %rdx,%rax
   415b2:	48 c1 e0 04          	shl    $0x4,%rax
   415b6:	48 05 e8 e0 04 00    	add    $0x4e0e8,%rax
   415bc:	0f b6 00             	movzbl (%rax),%eax
   415bf:	84 c0                	test   %al,%al
   415c1:	74 52                	je     41615 <memshow_virtual_animate+0x146>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   415c3:	8b 15 3b 4a 00 00    	mov    0x4a3b(%rip),%edx        # 46004 <showing.0>
   415c9:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   415cd:	89 d1                	mov    %edx,%ecx
   415cf:	ba 54 50 04 00       	mov    $0x45054,%edx
   415d4:	be 04 00 00 00       	mov    $0x4,%esi
   415d9:	48 89 c7             	mov    %rax,%rdi
   415dc:	b8 00 00 00 00       	mov    $0x0,%eax
   415e1:	e8 83 35 00 00       	call   44b69 <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   415e6:	8b 05 18 4a 00 00    	mov    0x4a18(%rip),%eax        # 46004 <showing.0>
   415ec:	48 63 d0             	movslq %eax,%rdx
   415ef:	48 89 d0             	mov    %rdx,%rax
   415f2:	48 c1 e0 04          	shl    $0x4,%rax
   415f6:	48 29 d0             	sub    %rdx,%rax
   415f9:	48 c1 e0 04          	shl    $0x4,%rax
   415fd:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   41603:	48 8b 00             	mov    (%rax),%rax
   41606:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   4160a:	48 89 d6             	mov    %rdx,%rsi
   4160d:	48 89 c7             	mov    %rax,%rdi
   41610:	e8 c1 fc ff ff       	call   412d6 <memshow_virtual>
    }
}
   41615:	90                   	nop
   41616:	c9                   	leave  
   41617:	c3                   	ret    

0000000000041618 <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   41618:	55                   	push   %rbp
   41619:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   4161c:	e8 4f 01 00 00       	call   41770 <segments_init>
    interrupt_init();
   41621:	e8 d0 03 00 00       	call   419f6 <interrupt_init>
    virtual_memory_init();
   41626:	e8 f3 0f 00 00       	call   4261e <virtual_memory_init>
}
   4162b:	90                   	nop
   4162c:	5d                   	pop    %rbp
   4162d:	c3                   	ret    

000000000004162e <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   4162e:	55                   	push   %rbp
   4162f:	48 89 e5             	mov    %rsp,%rbp
   41632:	48 83 ec 18          	sub    $0x18,%rsp
   41636:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4163a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   4163e:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   41641:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41644:	48 98                	cltq   
   41646:	48 c1 e0 2d          	shl    $0x2d,%rax
   4164a:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   4164e:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   41655:	90 00 00 
   41658:	48 09 c2             	or     %rax,%rdx
    *segment = type
   4165b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4165f:	48 89 10             	mov    %rdx,(%rax)
}
   41662:	90                   	nop
   41663:	c9                   	leave  
   41664:	c3                   	ret    

0000000000041665 <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   41665:	55                   	push   %rbp
   41666:	48 89 e5             	mov    %rsp,%rbp
   41669:	48 83 ec 28          	sub    $0x28,%rsp
   4166d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41671:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41675:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41678:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   4167c:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41680:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41684:	48 c1 e0 10          	shl    $0x10,%rax
   41688:	48 89 c2             	mov    %rax,%rdx
   4168b:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   41692:	00 00 00 
   41695:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   41698:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4169c:	48 c1 e0 20          	shl    $0x20,%rax
   416a0:	48 89 c1             	mov    %rax,%rcx
   416a3:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   416aa:	00 00 ff 
   416ad:	48 21 c8             	and    %rcx,%rax
   416b0:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   416b3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   416b7:	48 83 e8 01          	sub    $0x1,%rax
   416bb:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   416be:	48 09 d0             	or     %rdx,%rax
        | type
   416c1:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   416c5:	8b 55 ec             	mov    -0x14(%rbp),%edx
   416c8:	48 63 d2             	movslq %edx,%rdx
   416cb:	48 c1 e2 2d          	shl    $0x2d,%rdx
   416cf:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   416d2:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   416d9:	80 00 00 
   416dc:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   416df:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   416e3:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   416e6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   416ea:	48 83 c0 08          	add    $0x8,%rax
   416ee:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   416f2:	48 c1 ea 20          	shr    $0x20,%rdx
   416f6:	48 89 10             	mov    %rdx,(%rax)
}
   416f9:	90                   	nop
   416fa:	c9                   	leave  
   416fb:	c3                   	ret    

00000000000416fc <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   416fc:	55                   	push   %rbp
   416fd:	48 89 e5             	mov    %rsp,%rbp
   41700:	48 83 ec 20          	sub    $0x20,%rsp
   41704:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41708:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   4170c:	89 55 ec             	mov    %edx,-0x14(%rbp)
   4170f:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41713:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41717:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   4171a:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   4171e:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41721:	48 63 d2             	movslq %edx,%rdx
   41724:	48 c1 e2 2d          	shl    $0x2d,%rdx
   41728:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   4172b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4172f:	48 c1 e0 20          	shl    $0x20,%rax
   41733:	48 89 c1             	mov    %rax,%rcx
   41736:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   4173d:	00 ff ff 
   41740:	48 21 c8             	and    %rcx,%rax
   41743:	48 09 c2             	or     %rax,%rdx
   41746:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   4174d:	80 00 00 
   41750:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41753:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41757:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   4175a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4175e:	48 c1 e8 20          	shr    $0x20,%rax
   41762:	48 89 c2             	mov    %rax,%rdx
   41765:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41769:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   4176d:	90                   	nop
   4176e:	c9                   	leave  
   4176f:	c3                   	ret    

0000000000041770 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   41770:	55                   	push   %rbp
   41771:	48 89 e5             	mov    %rsp,%rbp
   41774:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   41778:	48 c7 05 bd db 00 00 	movq   $0x0,0xdbbd(%rip)        # 4f340 <segments>
   4177f:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   41783:	ba 00 00 00 00       	mov    $0x0,%edx
   41788:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   4178f:	08 20 00 
   41792:	48 89 c6             	mov    %rax,%rsi
   41795:	bf 48 f3 04 00       	mov    $0x4f348,%edi
   4179a:	e8 8f fe ff ff       	call   4162e <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   4179f:	ba 03 00 00 00       	mov    $0x3,%edx
   417a4:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   417ab:	08 20 00 
   417ae:	48 89 c6             	mov    %rax,%rsi
   417b1:	bf 50 f3 04 00       	mov    $0x4f350,%edi
   417b6:	e8 73 fe ff ff       	call   4162e <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   417bb:	ba 00 00 00 00       	mov    $0x0,%edx
   417c0:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   417c7:	02 00 00 
   417ca:	48 89 c6             	mov    %rax,%rsi
   417cd:	bf 58 f3 04 00       	mov    $0x4f358,%edi
   417d2:	e8 57 fe ff ff       	call   4162e <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   417d7:	ba 03 00 00 00       	mov    $0x3,%edx
   417dc:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   417e3:	02 00 00 
   417e6:	48 89 c6             	mov    %rax,%rsi
   417e9:	bf 60 f3 04 00       	mov    $0x4f360,%edi
   417ee:	e8 3b fe ff ff       	call   4162e <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   417f3:	b8 80 03 05 00       	mov    $0x50380,%eax
   417f8:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   417fe:	48 89 c1             	mov    %rax,%rcx
   41801:	ba 00 00 00 00       	mov    $0x0,%edx
   41806:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   4180d:	09 00 00 
   41810:	48 89 c6             	mov    %rax,%rsi
   41813:	bf 68 f3 04 00       	mov    $0x4f368,%edi
   41818:	e8 48 fe ff ff       	call   41665 <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   4181d:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   41823:	b8 40 f3 04 00       	mov    $0x4f340,%eax
   41828:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   4182c:	ba 60 00 00 00       	mov    $0x60,%edx
   41831:	be 00 00 00 00       	mov    $0x0,%esi
   41836:	bf 80 03 05 00       	mov    $0x50380,%edi
   4183b:	e8 66 24 00 00       	call   43ca6 <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   41840:	48 c7 05 39 eb 00 00 	movq   $0x80000,0xeb39(%rip)        # 50384 <kernel_task_descriptor+0x4>
   41847:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   4184b:	ba 00 10 00 00       	mov    $0x1000,%edx
   41850:	be 00 00 00 00       	mov    $0x0,%esi
   41855:	bf 80 f3 04 00       	mov    $0x4f380,%edi
   4185a:	e8 47 24 00 00       	call   43ca6 <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   4185f:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   41866:	eb 30                	jmp    41898 <segments_init+0x128>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   41868:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   4186d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41870:	48 c1 e0 04          	shl    $0x4,%rax
   41874:	48 05 80 f3 04 00    	add    $0x4f380,%rax
   4187a:	48 89 d1             	mov    %rdx,%rcx
   4187d:	ba 00 00 00 00       	mov    $0x0,%edx
   41882:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41889:	0e 00 00 
   4188c:	48 89 c7             	mov    %rax,%rdi
   4188f:	e8 68 fe ff ff       	call   416fc <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41894:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41898:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   4189f:	76 c7                	jbe    41868 <segments_init+0xf8>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   418a1:	b8 36 00 04 00       	mov    $0x40036,%eax
   418a6:	48 89 c1             	mov    %rax,%rcx
   418a9:	ba 00 00 00 00       	mov    $0x0,%edx
   418ae:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   418b5:	0e 00 00 
   418b8:	48 89 c6             	mov    %rax,%rsi
   418bb:	bf 80 f5 04 00       	mov    $0x4f580,%edi
   418c0:	e8 37 fe ff ff       	call   416fc <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   418c5:	b8 2e 00 04 00       	mov    $0x4002e,%eax
   418ca:	48 89 c1             	mov    %rax,%rcx
   418cd:	ba 00 00 00 00       	mov    $0x0,%edx
   418d2:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   418d9:	0e 00 00 
   418dc:	48 89 c6             	mov    %rax,%rsi
   418df:	bf 50 f4 04 00       	mov    $0x4f450,%edi
   418e4:	e8 13 fe ff ff       	call   416fc <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   418e9:	b8 32 00 04 00       	mov    $0x40032,%eax
   418ee:	48 89 c1             	mov    %rax,%rcx
   418f1:	ba 00 00 00 00       	mov    $0x0,%edx
   418f6:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   418fd:	0e 00 00 
   41900:	48 89 c6             	mov    %rax,%rsi
   41903:	bf 60 f4 04 00       	mov    $0x4f460,%edi
   41908:	e8 ef fd ff ff       	call   416fc <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   4190d:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   41914:	eb 3e                	jmp    41954 <segments_init+0x1e4>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   41916:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41919:	83 e8 30             	sub    $0x30,%eax
   4191c:	89 c0                	mov    %eax,%eax
   4191e:	48 8b 04 c5 e7 00 04 	mov    0x400e7(,%rax,8),%rax
   41925:	00 
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   41926:	48 89 c2             	mov    %rax,%rdx
   41929:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4192c:	48 c1 e0 04          	shl    $0x4,%rax
   41930:	48 05 80 f3 04 00    	add    $0x4f380,%rax
   41936:	48 89 d1             	mov    %rdx,%rcx
   41939:	ba 03 00 00 00       	mov    $0x3,%edx
   4193e:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41945:	0e 00 00 
   41948:	48 89 c7             	mov    %rax,%rdi
   4194b:	e8 ac fd ff ff       	call   416fc <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41950:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41954:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   41958:	76 bc                	jbe    41916 <segments_init+0x1a6>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   4195a:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   41960:	b8 80 f3 04 00       	mov    $0x4f380,%eax
   41965:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   41969:	b8 28 00 00 00       	mov    $0x28,%eax
   4196e:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   41972:	0f 00 d8             	ltr    %ax
   41975:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   41979:	0f 20 c0             	mov    %cr0,%rax
   4197c:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   41980:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   41984:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   41987:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   4198e:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41991:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   41994:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41997:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   4199b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4199f:	0f 22 c0             	mov    %rax,%cr0
}
   419a2:	90                   	nop
    lcr0(cr0);
}
   419a3:	90                   	nop
   419a4:	c9                   	leave  
   419a5:	c3                   	ret    

00000000000419a6 <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   419a6:	55                   	push   %rbp
   419a7:	48 89 e5             	mov    %rsp,%rbp
   419aa:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   419ae:	0f b7 05 2b ea 00 00 	movzwl 0xea2b(%rip),%eax        # 503e0 <interrupts_enabled>
   419b5:	f7 d0                	not    %eax
   419b7:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   419bb:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   419bf:	0f b6 c0             	movzbl %al,%eax
   419c2:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   419c9:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   419cc:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   419d0:	8b 55 f0             	mov    -0x10(%rbp),%edx
   419d3:	ee                   	out    %al,(%dx)
}
   419d4:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   419d5:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   419d9:	66 c1 e8 08          	shr    $0x8,%ax
   419dd:	0f b6 c0             	movzbl %al,%eax
   419e0:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   419e7:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   419ea:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   419ee:	8b 55 f8             	mov    -0x8(%rbp),%edx
   419f1:	ee                   	out    %al,(%dx)
}
   419f2:	90                   	nop
}
   419f3:	90                   	nop
   419f4:	c9                   	leave  
   419f5:	c3                   	ret    

00000000000419f6 <interrupt_init>:

void interrupt_init(void) {
   419f6:	55                   	push   %rbp
   419f7:	48 89 e5             	mov    %rsp,%rbp
   419fa:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   419fe:	66 c7 05 d9 e9 00 00 	movw   $0x0,0xe9d9(%rip)        # 503e0 <interrupts_enabled>
   41a05:	00 00 
    interrupt_mask();
   41a07:	e8 9a ff ff ff       	call   419a6 <interrupt_mask>
   41a0c:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   41a13:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a17:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   41a1b:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   41a1e:	ee                   	out    %al,(%dx)
}
   41a1f:	90                   	nop
   41a20:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   41a27:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a2b:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   41a2f:	8b 55 ac             	mov    -0x54(%rbp),%edx
   41a32:	ee                   	out    %al,(%dx)
}
   41a33:	90                   	nop
   41a34:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   41a3b:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a3f:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   41a43:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   41a46:	ee                   	out    %al,(%dx)
}
   41a47:	90                   	nop
   41a48:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   41a4f:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a53:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   41a57:	8b 55 bc             	mov    -0x44(%rbp),%edx
   41a5a:	ee                   	out    %al,(%dx)
}
   41a5b:	90                   	nop
   41a5c:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   41a63:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a67:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   41a6b:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   41a6e:	ee                   	out    %al,(%dx)
}
   41a6f:	90                   	nop
   41a70:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   41a77:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a7b:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   41a7f:	8b 55 cc             	mov    -0x34(%rbp),%edx
   41a82:	ee                   	out    %al,(%dx)
}
   41a83:	90                   	nop
   41a84:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   41a8b:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a8f:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   41a93:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   41a96:	ee                   	out    %al,(%dx)
}
   41a97:	90                   	nop
   41a98:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   41a9f:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41aa3:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   41aa7:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41aaa:	ee                   	out    %al,(%dx)
}
   41aab:	90                   	nop
   41aac:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   41ab3:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ab7:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41abb:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41abe:	ee                   	out    %al,(%dx)
}
   41abf:	90                   	nop
   41ac0:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   41ac7:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41acb:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41acf:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41ad2:	ee                   	out    %al,(%dx)
}
   41ad3:	90                   	nop
   41ad4:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   41adb:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41adf:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41ae3:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41ae6:	ee                   	out    %al,(%dx)
}
   41ae7:	90                   	nop
   41ae8:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   41aef:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41af3:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41af7:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41afa:	ee                   	out    %al,(%dx)
}
   41afb:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   41afc:	e8 a5 fe ff ff       	call   419a6 <interrupt_mask>
}
   41b01:	90                   	nop
   41b02:	c9                   	leave  
   41b03:	c3                   	ret    

0000000000041b04 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   41b04:	55                   	push   %rbp
   41b05:	48 89 e5             	mov    %rsp,%rbp
   41b08:	48 83 ec 28          	sub    $0x28,%rsp
   41b0c:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   41b0f:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41b13:	0f 8e 9e 00 00 00    	jle    41bb7 <timer_init+0xb3>
   41b19:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   41b20:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b24:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41b28:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41b2b:	ee                   	out    %al,(%dx)
}
   41b2c:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   41b2d:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41b30:	89 c2                	mov    %eax,%edx
   41b32:	c1 ea 1f             	shr    $0x1f,%edx
   41b35:	01 d0                	add    %edx,%eax
   41b37:	d1 f8                	sar    %eax
   41b39:	05 de 34 12 00       	add    $0x1234de,%eax
   41b3e:	99                   	cltd   
   41b3f:	f7 7d dc             	idivl  -0x24(%rbp)
   41b42:	89 c2                	mov    %eax,%edx
   41b44:	89 d0                	mov    %edx,%eax
   41b46:	c1 f8 1f             	sar    $0x1f,%eax
   41b49:	c1 e8 18             	shr    $0x18,%eax
   41b4c:	01 c2                	add    %eax,%edx
   41b4e:	0f b6 d2             	movzbl %dl,%edx
   41b51:	29 c2                	sub    %eax,%edx
   41b53:	89 d0                	mov    %edx,%eax
   41b55:	0f b6 c0             	movzbl %al,%eax
   41b58:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   41b5f:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b62:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41b66:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41b69:	ee                   	out    %al,(%dx)
}
   41b6a:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   41b6b:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41b6e:	89 c2                	mov    %eax,%edx
   41b70:	c1 ea 1f             	shr    $0x1f,%edx
   41b73:	01 d0                	add    %edx,%eax
   41b75:	d1 f8                	sar    %eax
   41b77:	05 de 34 12 00       	add    $0x1234de,%eax
   41b7c:	99                   	cltd   
   41b7d:	f7 7d dc             	idivl  -0x24(%rbp)
   41b80:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41b86:	85 c0                	test   %eax,%eax
   41b88:	0f 48 c2             	cmovs  %edx,%eax
   41b8b:	c1 f8 08             	sar    $0x8,%eax
   41b8e:	0f b6 c0             	movzbl %al,%eax
   41b91:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   41b98:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b9b:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41b9f:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41ba2:	ee                   	out    %al,(%dx)
}
   41ba3:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   41ba4:	0f b7 05 35 e8 00 00 	movzwl 0xe835(%rip),%eax        # 503e0 <interrupts_enabled>
   41bab:	83 c8 01             	or     $0x1,%eax
   41bae:	66 89 05 2b e8 00 00 	mov    %ax,0xe82b(%rip)        # 503e0 <interrupts_enabled>
   41bb5:	eb 11                	jmp    41bc8 <timer_init+0xc4>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   41bb7:	0f b7 05 22 e8 00 00 	movzwl 0xe822(%rip),%eax        # 503e0 <interrupts_enabled>
   41bbe:	83 e0 fe             	and    $0xfffffffe,%eax
   41bc1:	66 89 05 18 e8 00 00 	mov    %ax,0xe818(%rip)        # 503e0 <interrupts_enabled>
    }
    interrupt_mask();
   41bc8:	e8 d9 fd ff ff       	call   419a6 <interrupt_mask>
}
   41bcd:	90                   	nop
   41bce:	c9                   	leave  
   41bcf:	c3                   	ret    

0000000000041bd0 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   41bd0:	55                   	push   %rbp
   41bd1:	48 89 e5             	mov    %rsp,%rbp
   41bd4:	48 83 ec 08          	sub    $0x8,%rsp
   41bd8:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   41bdc:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   41be1:	74 14                	je     41bf7 <physical_memory_isreserved+0x27>
   41be3:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   41bea:	00 
   41beb:	76 11                	jbe    41bfe <physical_memory_isreserved+0x2e>
   41bed:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   41bf4:	00 
   41bf5:	77 07                	ja     41bfe <physical_memory_isreserved+0x2e>
   41bf7:	b8 01 00 00 00       	mov    $0x1,%eax
   41bfc:	eb 05                	jmp    41c03 <physical_memory_isreserved+0x33>
   41bfe:	b8 00 00 00 00       	mov    $0x0,%eax
}
   41c03:	c9                   	leave  
   41c04:	c3                   	ret    

0000000000041c05 <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   41c05:	55                   	push   %rbp
   41c06:	48 89 e5             	mov    %rsp,%rbp
   41c09:	48 83 ec 10          	sub    $0x10,%rsp
   41c0d:	89 7d fc             	mov    %edi,-0x4(%rbp)
   41c10:	89 75 f8             	mov    %esi,-0x8(%rbp)
   41c13:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   41c16:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41c19:	c1 e0 10             	shl    $0x10,%eax
   41c1c:	89 c2                	mov    %eax,%edx
   41c1e:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41c21:	c1 e0 0b             	shl    $0xb,%eax
   41c24:	09 c2                	or     %eax,%edx
   41c26:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41c29:	c1 e0 08             	shl    $0x8,%eax
   41c2c:	09 d0                	or     %edx,%eax
}
   41c2e:	c9                   	leave  
   41c2f:	c3                   	ret    

0000000000041c30 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   41c30:	55                   	push   %rbp
   41c31:	48 89 e5             	mov    %rsp,%rbp
   41c34:	48 83 ec 18          	sub    $0x18,%rsp
   41c38:	89 7d ec             	mov    %edi,-0x14(%rbp)
   41c3b:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   41c3e:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41c41:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41c44:	09 d0                	or     %edx,%eax
   41c46:	0d 00 00 00 80       	or     $0x80000000,%eax
   41c4b:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   41c52:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   41c55:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41c58:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41c5b:	ef                   	out    %eax,(%dx)
}
   41c5c:	90                   	nop
   41c5d:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   41c64:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41c67:	89 c2                	mov    %eax,%edx
   41c69:	ed                   	in     (%dx),%eax
   41c6a:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   41c6d:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   41c70:	c9                   	leave  
   41c71:	c3                   	ret    

0000000000041c72 <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   41c72:	55                   	push   %rbp
   41c73:	48 89 e5             	mov    %rsp,%rbp
   41c76:	48 83 ec 28          	sub    $0x28,%rsp
   41c7a:	89 7d dc             	mov    %edi,-0x24(%rbp)
   41c7d:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   41c80:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41c87:	eb 73                	jmp    41cfc <pci_find_device+0x8a>
        for (int slot = 0; slot != 32; ++slot) {
   41c89:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41c90:	eb 60                	jmp    41cf2 <pci_find_device+0x80>
            for (int func = 0; func != 8; ++func) {
   41c92:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41c99:	eb 4a                	jmp    41ce5 <pci_find_device+0x73>
                int configaddr = pci_make_configaddr(bus, slot, func);
   41c9b:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41c9e:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41ca1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41ca4:	89 ce                	mov    %ecx,%esi
   41ca6:	89 c7                	mov    %eax,%edi
   41ca8:	e8 58 ff ff ff       	call   41c05 <pci_make_configaddr>
   41cad:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   41cb0:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41cb3:	be 00 00 00 00       	mov    $0x0,%esi
   41cb8:	89 c7                	mov    %eax,%edi
   41cba:	e8 71 ff ff ff       	call   41c30 <pci_config_readl>
   41cbf:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   41cc2:	8b 45 d8             	mov    -0x28(%rbp),%eax
   41cc5:	c1 e0 10             	shl    $0x10,%eax
   41cc8:	0b 45 dc             	or     -0x24(%rbp),%eax
   41ccb:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   41cce:	75 05                	jne    41cd5 <pci_find_device+0x63>
                    return configaddr;
   41cd0:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41cd3:	eb 35                	jmp    41d0a <pci_find_device+0x98>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   41cd5:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   41cd9:	75 06                	jne    41ce1 <pci_find_device+0x6f>
   41cdb:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41cdf:	74 0c                	je     41ced <pci_find_device+0x7b>
            for (int func = 0; func != 8; ++func) {
   41ce1:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41ce5:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   41ce9:	75 b0                	jne    41c9b <pci_find_device+0x29>
   41ceb:	eb 01                	jmp    41cee <pci_find_device+0x7c>
                    break;
   41ced:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   41cee:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41cf2:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   41cf6:	75 9a                	jne    41c92 <pci_find_device+0x20>
    for (int bus = 0; bus != 256; ++bus) {
   41cf8:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41cfc:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   41d03:	75 84                	jne    41c89 <pci_find_device+0x17>
                }
            }
        }
    }
    return -1;
   41d05:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   41d0a:	c9                   	leave  
   41d0b:	c3                   	ret    

0000000000041d0c <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   41d0c:	55                   	push   %rbp
   41d0d:	48 89 e5             	mov    %rsp,%rbp
   41d10:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   41d14:	be 13 71 00 00       	mov    $0x7113,%esi
   41d19:	bf 86 80 00 00       	mov    $0x8086,%edi
   41d1e:	e8 4f ff ff ff       	call   41c72 <pci_find_device>
   41d23:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   41d26:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   41d2a:	78 30                	js     41d5c <poweroff+0x50>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   41d2c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41d2f:	be 40 00 00 00       	mov    $0x40,%esi
   41d34:	89 c7                	mov    %eax,%edi
   41d36:	e8 f5 fe ff ff       	call   41c30 <pci_config_readl>
   41d3b:	25 c0 ff 00 00       	and    $0xffc0,%eax
   41d40:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   41d43:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41d46:	83 c0 04             	add    $0x4,%eax
   41d49:	89 45 f4             	mov    %eax,-0xc(%rbp)
   41d4c:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   41d52:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   41d56:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41d59:	66 ef                	out    %ax,(%dx)
}
   41d5b:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   41d5c:	ba 60 50 04 00       	mov    $0x45060,%edx
   41d61:	be 00 c0 00 00       	mov    $0xc000,%esi
   41d66:	bf 80 07 00 00       	mov    $0x780,%edi
   41d6b:	b8 00 00 00 00       	mov    $0x0,%eax
   41d70:	e8 e8 2c 00 00       	call   44a5d <console_printf>
 spinloop: goto spinloop;
   41d75:	eb fe                	jmp    41d75 <poweroff+0x69>

0000000000041d77 <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   41d77:	55                   	push   %rbp
   41d78:	48 89 e5             	mov    %rsp,%rbp
   41d7b:	48 83 ec 10          	sub    $0x10,%rsp
   41d7f:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   41d86:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d8a:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41d8e:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41d91:	ee                   	out    %al,(%dx)
}
   41d92:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   41d93:	eb fe                	jmp    41d93 <reboot+0x1c>

0000000000041d95 <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   41d95:	55                   	push   %rbp
   41d96:	48 89 e5             	mov    %rsp,%rbp
   41d99:	48 83 ec 10          	sub    $0x10,%rsp
   41d9d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41da1:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   41da4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41da8:	48 83 c0 18          	add    $0x18,%rax
   41dac:	ba c0 00 00 00       	mov    $0xc0,%edx
   41db1:	be 00 00 00 00       	mov    $0x0,%esi
   41db6:	48 89 c7             	mov    %rax,%rdi
   41db9:	e8 e8 1e 00 00       	call   43ca6 <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   41dbe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41dc2:	66 c7 80 b8 00 00 00 	movw   $0x13,0xb8(%rax)
   41dc9:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   41dcb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41dcf:	48 c7 80 90 00 00 00 	movq   $0x23,0x90(%rax)
   41dd6:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   41dda:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41dde:	48 c7 80 98 00 00 00 	movq   $0x23,0x98(%rax)
   41de5:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   41de9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ded:	66 c7 80 d0 00 00 00 	movw   $0x23,0xd0(%rax)
   41df4:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   41df6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41dfa:	48 c7 80 c0 00 00 00 	movq   $0x200,0xc0(%rax)
   41e01:	00 02 00 00 

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   41e05:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41e08:	83 e0 01             	and    $0x1,%eax
   41e0b:	85 c0                	test   %eax,%eax
   41e0d:	74 1c                	je     41e2b <process_init+0x96>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   41e0f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e13:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   41e1a:	80 cc 30             	or     $0x30,%ah
   41e1d:	48 89 c2             	mov    %rax,%rdx
   41e20:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e24:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   41e2b:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41e2e:	83 e0 02             	and    $0x2,%eax
   41e31:	85 c0                	test   %eax,%eax
   41e33:	74 1c                	je     41e51 <process_init+0xbc>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   41e35:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e39:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   41e40:	80 e4 fd             	and    $0xfd,%ah
   41e43:	48 89 c2             	mov    %rax,%rdx
   41e46:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e4a:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    p->display_status = 1;
   41e51:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e55:	c6 80 e8 00 00 00 01 	movb   $0x1,0xe8(%rax)
}
   41e5c:	90                   	nop
   41e5d:	c9                   	leave  
   41e5e:	c3                   	ret    

0000000000041e5f <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   41e5f:	55                   	push   %rbp
   41e60:	48 89 e5             	mov    %rsp,%rbp
   41e63:	48 83 ec 28          	sub    $0x28,%rsp
   41e67:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   41e6a:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41e6e:	78 09                	js     41e79 <console_show_cursor+0x1a>
   41e70:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   41e77:	7e 07                	jle    41e80 <console_show_cursor+0x21>
        cpos = 0;
   41e79:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   41e80:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   41e87:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e8b:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41e8f:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41e92:	ee                   	out    %al,(%dx)
}
   41e93:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   41e94:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41e97:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41e9d:	85 c0                	test   %eax,%eax
   41e9f:	0f 48 c2             	cmovs  %edx,%eax
   41ea2:	c1 f8 08             	sar    $0x8,%eax
   41ea5:	0f b6 c0             	movzbl %al,%eax
   41ea8:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   41eaf:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41eb2:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41eb6:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41eb9:	ee                   	out    %al,(%dx)
}
   41eba:	90                   	nop
   41ebb:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   41ec2:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ec6:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41eca:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41ecd:	ee                   	out    %al,(%dx)
}
   41ece:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   41ecf:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41ed2:	89 d0                	mov    %edx,%eax
   41ed4:	c1 f8 1f             	sar    $0x1f,%eax
   41ed7:	c1 e8 18             	shr    $0x18,%eax
   41eda:	01 c2                	add    %eax,%edx
   41edc:	0f b6 d2             	movzbl %dl,%edx
   41edf:	29 c2                	sub    %eax,%edx
   41ee1:	89 d0                	mov    %edx,%eax
   41ee3:	0f b6 c0             	movzbl %al,%eax
   41ee6:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   41eed:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ef0:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41ef4:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41ef7:	ee                   	out    %al,(%dx)
}
   41ef8:	90                   	nop
}
   41ef9:	90                   	nop
   41efa:	c9                   	leave  
   41efb:	c3                   	ret    

0000000000041efc <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   41efc:	55                   	push   %rbp
   41efd:	48 89 e5             	mov    %rsp,%rbp
   41f00:	48 83 ec 20          	sub    $0x20,%rsp
   41f04:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41f0b:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41f0e:	89 c2                	mov    %eax,%edx
   41f10:	ec                   	in     (%dx),%al
   41f11:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   41f14:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   41f18:	0f b6 c0             	movzbl %al,%eax
   41f1b:	83 e0 01             	and    $0x1,%eax
   41f1e:	85 c0                	test   %eax,%eax
   41f20:	75 0a                	jne    41f2c <keyboard_readc+0x30>
        return -1;
   41f22:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   41f27:	e9 e7 01 00 00       	jmp    42113 <keyboard_readc+0x217>
   41f2c:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41f33:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41f36:	89 c2                	mov    %eax,%edx
   41f38:	ec                   	in     (%dx),%al
   41f39:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   41f3c:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   41f40:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   41f43:	0f b6 05 98 e4 00 00 	movzbl 0xe498(%rip),%eax        # 503e2 <last_escape.2>
   41f4a:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   41f4d:	c6 05 8e e4 00 00 00 	movb   $0x0,0xe48e(%rip)        # 503e2 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   41f54:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   41f58:	75 11                	jne    41f6b <keyboard_readc+0x6f>
        last_escape = 0x80;
   41f5a:	c6 05 81 e4 00 00 80 	movb   $0x80,0xe481(%rip)        # 503e2 <last_escape.2>
        return 0;
   41f61:	b8 00 00 00 00       	mov    $0x0,%eax
   41f66:	e9 a8 01 00 00       	jmp    42113 <keyboard_readc+0x217>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   41f6b:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41f6f:	84 c0                	test   %al,%al
   41f71:	79 60                	jns    41fd3 <keyboard_readc+0xd7>
        int ch = keymap[(data & 0x7F) | escape];
   41f73:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41f77:	83 e0 7f             	and    $0x7f,%eax
   41f7a:	89 c2                	mov    %eax,%edx
   41f7c:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   41f80:	09 d0                	or     %edx,%eax
   41f82:	48 98                	cltq   
   41f84:	0f b6 80 80 50 04 00 	movzbl 0x45080(%rax),%eax
   41f8b:	0f b6 c0             	movzbl %al,%eax
   41f8e:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   41f91:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   41f98:	7e 2f                	jle    41fc9 <keyboard_readc+0xcd>
   41f9a:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   41fa1:	7f 26                	jg     41fc9 <keyboard_readc+0xcd>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   41fa3:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41fa6:	2d fa 00 00 00       	sub    $0xfa,%eax
   41fab:	ba 01 00 00 00       	mov    $0x1,%edx
   41fb0:	89 c1                	mov    %eax,%ecx
   41fb2:	d3 e2                	shl    %cl,%edx
   41fb4:	89 d0                	mov    %edx,%eax
   41fb6:	f7 d0                	not    %eax
   41fb8:	89 c2                	mov    %eax,%edx
   41fba:	0f b6 05 22 e4 00 00 	movzbl 0xe422(%rip),%eax        # 503e3 <modifiers.1>
   41fc1:	21 d0                	and    %edx,%eax
   41fc3:	88 05 1a e4 00 00    	mov    %al,0xe41a(%rip)        # 503e3 <modifiers.1>
        }
        return 0;
   41fc9:	b8 00 00 00 00       	mov    $0x0,%eax
   41fce:	e9 40 01 00 00       	jmp    42113 <keyboard_readc+0x217>
    }

    int ch = (unsigned char) keymap[data | escape];
   41fd3:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41fd7:	0a 45 fa             	or     -0x6(%rbp),%al
   41fda:	0f b6 c0             	movzbl %al,%eax
   41fdd:	48 98                	cltq   
   41fdf:	0f b6 80 80 50 04 00 	movzbl 0x45080(%rax),%eax
   41fe6:	0f b6 c0             	movzbl %al,%eax
   41fe9:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   41fec:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   41ff0:	7e 57                	jle    42049 <keyboard_readc+0x14d>
   41ff2:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   41ff6:	7f 51                	jg     42049 <keyboard_readc+0x14d>
        if (modifiers & MOD_CONTROL) {
   41ff8:	0f b6 05 e4 e3 00 00 	movzbl 0xe3e4(%rip),%eax        # 503e3 <modifiers.1>
   41fff:	0f b6 c0             	movzbl %al,%eax
   42002:	83 e0 02             	and    $0x2,%eax
   42005:	85 c0                	test   %eax,%eax
   42007:	74 09                	je     42012 <keyboard_readc+0x116>
            ch -= 0x60;
   42009:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   4200d:	e9 fd 00 00 00       	jmp    4210f <keyboard_readc+0x213>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   42012:	0f b6 05 ca e3 00 00 	movzbl 0xe3ca(%rip),%eax        # 503e3 <modifiers.1>
   42019:	0f b6 c0             	movzbl %al,%eax
   4201c:	83 e0 01             	and    $0x1,%eax
   4201f:	85 c0                	test   %eax,%eax
   42021:	0f 94 c2             	sete   %dl
   42024:	0f b6 05 b8 e3 00 00 	movzbl 0xe3b8(%rip),%eax        # 503e3 <modifiers.1>
   4202b:	0f b6 c0             	movzbl %al,%eax
   4202e:	83 e0 08             	and    $0x8,%eax
   42031:	85 c0                	test   %eax,%eax
   42033:	0f 94 c0             	sete   %al
   42036:	31 d0                	xor    %edx,%eax
   42038:	84 c0                	test   %al,%al
   4203a:	0f 84 cf 00 00 00    	je     4210f <keyboard_readc+0x213>
            ch -= 0x20;
   42040:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   42044:	e9 c6 00 00 00       	jmp    4210f <keyboard_readc+0x213>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   42049:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   42050:	7e 30                	jle    42082 <keyboard_readc+0x186>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   42052:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42055:	2d fa 00 00 00       	sub    $0xfa,%eax
   4205a:	ba 01 00 00 00       	mov    $0x1,%edx
   4205f:	89 c1                	mov    %eax,%ecx
   42061:	d3 e2                	shl    %cl,%edx
   42063:	89 d0                	mov    %edx,%eax
   42065:	89 c2                	mov    %eax,%edx
   42067:	0f b6 05 75 e3 00 00 	movzbl 0xe375(%rip),%eax        # 503e3 <modifiers.1>
   4206e:	31 d0                	xor    %edx,%eax
   42070:	88 05 6d e3 00 00    	mov    %al,0xe36d(%rip)        # 503e3 <modifiers.1>
        ch = 0;
   42076:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4207d:	e9 8e 00 00 00       	jmp    42110 <keyboard_readc+0x214>
    } else if (ch >= KEY_SHIFT) {
   42082:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   42089:	7e 2d                	jle    420b8 <keyboard_readc+0x1bc>
        modifiers |= 1 << (ch - KEY_SHIFT);
   4208b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4208e:	2d fa 00 00 00       	sub    $0xfa,%eax
   42093:	ba 01 00 00 00       	mov    $0x1,%edx
   42098:	89 c1                	mov    %eax,%ecx
   4209a:	d3 e2                	shl    %cl,%edx
   4209c:	89 d0                	mov    %edx,%eax
   4209e:	89 c2                	mov    %eax,%edx
   420a0:	0f b6 05 3c e3 00 00 	movzbl 0xe33c(%rip),%eax        # 503e3 <modifiers.1>
   420a7:	09 d0                	or     %edx,%eax
   420a9:	88 05 34 e3 00 00    	mov    %al,0xe334(%rip)        # 503e3 <modifiers.1>
        ch = 0;
   420af:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   420b6:	eb 58                	jmp    42110 <keyboard_readc+0x214>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   420b8:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   420bc:	7e 31                	jle    420ef <keyboard_readc+0x1f3>
   420be:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   420c5:	7f 28                	jg     420ef <keyboard_readc+0x1f3>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   420c7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   420ca:	8d 50 80             	lea    -0x80(%rax),%edx
   420cd:	0f b6 05 0f e3 00 00 	movzbl 0xe30f(%rip),%eax        # 503e3 <modifiers.1>
   420d4:	0f b6 c0             	movzbl %al,%eax
   420d7:	83 e0 03             	and    $0x3,%eax
   420da:	48 98                	cltq   
   420dc:	48 63 d2             	movslq %edx,%rdx
   420df:	0f b6 84 90 80 51 04 	movzbl 0x45180(%rax,%rdx,4),%eax
   420e6:	00 
   420e7:	0f b6 c0             	movzbl %al,%eax
   420ea:	89 45 fc             	mov    %eax,-0x4(%rbp)
   420ed:	eb 21                	jmp    42110 <keyboard_readc+0x214>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   420ef:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   420f3:	7f 1b                	jg     42110 <keyboard_readc+0x214>
   420f5:	0f b6 05 e7 e2 00 00 	movzbl 0xe2e7(%rip),%eax        # 503e3 <modifiers.1>
   420fc:	0f b6 c0             	movzbl %al,%eax
   420ff:	83 e0 02             	and    $0x2,%eax
   42102:	85 c0                	test   %eax,%eax
   42104:	74 0a                	je     42110 <keyboard_readc+0x214>
        ch = 0;
   42106:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4210d:	eb 01                	jmp    42110 <keyboard_readc+0x214>
        if (modifiers & MOD_CONTROL) {
   4210f:	90                   	nop
    }

    return ch;
   42110:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   42113:	c9                   	leave  
   42114:	c3                   	ret    

0000000000042115 <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   42115:	55                   	push   %rbp
   42116:	48 89 e5             	mov    %rsp,%rbp
   42119:	48 83 ec 20          	sub    $0x20,%rsp
   4211d:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42124:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   42127:	89 c2                	mov    %eax,%edx
   42129:	ec                   	in     (%dx),%al
   4212a:	88 45 e3             	mov    %al,-0x1d(%rbp)
   4212d:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   42134:	8b 45 ec             	mov    -0x14(%rbp),%eax
   42137:	89 c2                	mov    %eax,%edx
   42139:	ec                   	in     (%dx),%al
   4213a:	88 45 eb             	mov    %al,-0x15(%rbp)
   4213d:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   42144:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42147:	89 c2                	mov    %eax,%edx
   42149:	ec                   	in     (%dx),%al
   4214a:	88 45 f3             	mov    %al,-0xd(%rbp)
   4214d:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   42154:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42157:	89 c2                	mov    %eax,%edx
   42159:	ec                   	in     (%dx),%al
   4215a:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   4215d:	90                   	nop
   4215e:	c9                   	leave  
   4215f:	c3                   	ret    

0000000000042160 <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   42160:	55                   	push   %rbp
   42161:	48 89 e5             	mov    %rsp,%rbp
   42164:	48 83 ec 40          	sub    $0x40,%rsp
   42168:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   4216c:	89 f0                	mov    %esi,%eax
   4216e:	89 55 c0             	mov    %edx,-0x40(%rbp)
   42171:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   42174:	8b 05 6a e2 00 00    	mov    0xe26a(%rip),%eax        # 503e4 <initialized.0>
   4217a:	85 c0                	test   %eax,%eax
   4217c:	75 1e                	jne    4219c <parallel_port_putc+0x3c>
   4217e:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   42185:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42189:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   4218d:	8b 55 f8             	mov    -0x8(%rbp),%edx
   42190:	ee                   	out    %al,(%dx)
}
   42191:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   42192:	c7 05 48 e2 00 00 01 	movl   $0x1,0xe248(%rip)        # 503e4 <initialized.0>
   42199:	00 00 00 
    }

    for (int i = 0;
   4219c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   421a3:	eb 09                	jmp    421ae <parallel_port_putc+0x4e>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   421a5:	e8 6b ff ff ff       	call   42115 <delay>
         ++i) {
   421aa:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   421ae:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   421b5:	7f 18                	jg     421cf <parallel_port_putc+0x6f>
   421b7:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   421be:	8b 45 f0             	mov    -0x10(%rbp),%eax
   421c1:	89 c2                	mov    %eax,%edx
   421c3:	ec                   	in     (%dx),%al
   421c4:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   421c7:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   421cb:	84 c0                	test   %al,%al
   421cd:	79 d6                	jns    421a5 <parallel_port_putc+0x45>
    }
    outb(IO_PARALLEL1_DATA, c);
   421cf:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   421d3:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   421da:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421dd:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   421e1:	8b 55 d8             	mov    -0x28(%rbp),%edx
   421e4:	ee                   	out    %al,(%dx)
}
   421e5:	90                   	nop
   421e6:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   421ed:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421f1:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   421f5:	8b 55 e0             	mov    -0x20(%rbp),%edx
   421f8:	ee                   	out    %al,(%dx)
}
   421f9:	90                   	nop
   421fa:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   42201:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42205:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   42209:	8b 55 e8             	mov    -0x18(%rbp),%edx
   4220c:	ee                   	out    %al,(%dx)
}
   4220d:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   4220e:	90                   	nop
   4220f:	c9                   	leave  
   42210:	c3                   	ret    

0000000000042211 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   42211:	55                   	push   %rbp
   42212:	48 89 e5             	mov    %rsp,%rbp
   42215:	48 83 ec 20          	sub    $0x20,%rsp
   42219:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4221d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   42221:	48 c7 45 f8 60 21 04 	movq   $0x42160,-0x8(%rbp)
   42228:	00 
    printer_vprintf(&p, 0, format, val);
   42229:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   4222d:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   42231:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   42235:	be 00 00 00 00       	mov    $0x0,%esi
   4223a:	48 89 c7             	mov    %rax,%rdi
   4223d:	e8 00 1d 00 00       	call   43f42 <printer_vprintf>
}
   42242:	90                   	nop
   42243:	c9                   	leave  
   42244:	c3                   	ret    

0000000000042245 <log_printf>:

void log_printf(const char* format, ...) {
   42245:	55                   	push   %rbp
   42246:	48 89 e5             	mov    %rsp,%rbp
   42249:	48 83 ec 60          	sub    $0x60,%rsp
   4224d:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42251:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42255:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42259:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4225d:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42261:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42265:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   4226c:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42270:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42274:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42278:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   4227c:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   42280:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42284:	48 89 d6             	mov    %rdx,%rsi
   42287:	48 89 c7             	mov    %rax,%rdi
   4228a:	e8 82 ff ff ff       	call   42211 <log_vprintf>
    va_end(val);
}
   4228f:	90                   	nop
   42290:	c9                   	leave  
   42291:	c3                   	ret    

0000000000042292 <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   42292:	55                   	push   %rbp
   42293:	48 89 e5             	mov    %rsp,%rbp
   42296:	48 83 ec 40          	sub    $0x40,%rsp
   4229a:	89 7d dc             	mov    %edi,-0x24(%rbp)
   4229d:	89 75 d8             	mov    %esi,-0x28(%rbp)
   422a0:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   422a4:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   422a8:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   422ac:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   422b0:	48 8b 0a             	mov    (%rdx),%rcx
   422b3:	48 89 08             	mov    %rcx,(%rax)
   422b6:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   422ba:	48 89 48 08          	mov    %rcx,0x8(%rax)
   422be:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   422c2:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   422c6:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   422ca:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   422ce:	48 89 d6             	mov    %rdx,%rsi
   422d1:	48 89 c7             	mov    %rax,%rdi
   422d4:	e8 38 ff ff ff       	call   42211 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   422d9:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   422dd:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   422e1:	8b 75 d8             	mov    -0x28(%rbp),%esi
   422e4:	8b 45 dc             	mov    -0x24(%rbp),%eax
   422e7:	89 c7                	mov    %eax,%edi
   422e9:	e8 03 27 00 00       	call   449f1 <console_vprintf>
}
   422ee:	c9                   	leave  
   422ef:	c3                   	ret    

00000000000422f0 <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   422f0:	55                   	push   %rbp
   422f1:	48 89 e5             	mov    %rsp,%rbp
   422f4:	48 83 ec 60          	sub    $0x60,%rsp
   422f8:	89 7d ac             	mov    %edi,-0x54(%rbp)
   422fb:	89 75 a8             	mov    %esi,-0x58(%rbp)
   422fe:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   42302:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42306:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4230a:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   4230e:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   42315:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42319:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   4231d:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42321:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   42325:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   42329:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   4232d:	8b 75 a8             	mov    -0x58(%rbp),%esi
   42330:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42333:	89 c7                	mov    %eax,%edi
   42335:	e8 58 ff ff ff       	call   42292 <error_vprintf>
   4233a:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   4233d:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   42340:	c9                   	leave  
   42341:	c3                   	ret    

0000000000042342 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'm', and 'c' cause a soft
//    reboot where the kernel runs the allocator programs, "malloc", or
//    "alloctests", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   42342:	55                   	push   %rbp
   42343:	48 89 e5             	mov    %rsp,%rbp
   42346:	53                   	push   %rbx
   42347:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   4234b:	e8 ac fb ff ff       	call   41efc <keyboard_readc>
   42350:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'm' || c == 'c' || c == 't'|| c =='2') {
   42353:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42357:	74 1c                	je     42375 <check_keyboard+0x33>
   42359:	83 7d e4 6d          	cmpl   $0x6d,-0x1c(%rbp)
   4235d:	74 16                	je     42375 <check_keyboard+0x33>
   4235f:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   42363:	74 10                	je     42375 <check_keyboard+0x33>
   42365:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42369:	74 0a                	je     42375 <check_keyboard+0x33>
   4236b:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   4236f:	0f 85 e9 00 00 00    	jne    4245e <check_keyboard+0x11c>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   42375:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   4237c:	00 
        memset(pt, 0, PAGESIZE * 3);
   4237d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42381:	ba 00 30 00 00       	mov    $0x3000,%edx
   42386:	be 00 00 00 00       	mov    $0x0,%esi
   4238b:	48 89 c7             	mov    %rax,%rdi
   4238e:	e8 13 19 00 00       	call   43ca6 <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   42393:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42397:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   4239e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   423a2:	48 05 00 10 00 00    	add    $0x1000,%rax
   423a8:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   423af:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   423b3:	48 05 00 20 00 00    	add    $0x2000,%rax
   423b9:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   423c0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   423c4:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   423c8:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   423cc:	0f 22 d8             	mov    %rax,%cr3
}
   423cf:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   423d0:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "malloc";
   423d7:	48 c7 45 e8 d8 51 04 	movq   $0x451d8,-0x18(%rbp)
   423de:	00 
        if (c == 'a') {
   423df:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   423e3:	75 0a                	jne    423ef <check_keyboard+0xad>
            argument = "allocator";
   423e5:	48 c7 45 e8 df 51 04 	movq   $0x451df,-0x18(%rbp)
   423ec:	00 
   423ed:	eb 2e                	jmp    4241d <check_keyboard+0xdb>
        } else if (c == 'c') {
   423ef:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   423f3:	75 0a                	jne    423ff <check_keyboard+0xbd>
            argument = "alloctests";
   423f5:	48 c7 45 e8 e9 51 04 	movq   $0x451e9,-0x18(%rbp)
   423fc:	00 
   423fd:	eb 1e                	jmp    4241d <check_keyboard+0xdb>
        } else if(c == 't'){
   423ff:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42403:	75 0a                	jne    4240f <check_keyboard+0xcd>
            argument = "test";
   42405:	48 c7 45 e8 f4 51 04 	movq   $0x451f4,-0x18(%rbp)
   4240c:	00 
   4240d:	eb 0e                	jmp    4241d <check_keyboard+0xdb>
        }
        else if(c == '2'){
   4240f:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42413:	75 08                	jne    4241d <check_keyboard+0xdb>
            argument = "test2";
   42415:	48 c7 45 e8 f9 51 04 	movq   $0x451f9,-0x18(%rbp)
   4241c:	00 
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   4241d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42421:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   42425:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4242a:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   4242e:	73 14                	jae    42444 <check_keyboard+0x102>
   42430:	ba ff 51 04 00       	mov    $0x451ff,%edx
   42435:	be 5c 02 00 00       	mov    $0x25c,%esi
   4243a:	bf 1b 52 04 00       	mov    $0x4521b,%edi
   4243f:	e8 1f 01 00 00       	call   42563 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   42444:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42448:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   4244b:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   4244f:	48 89 c3             	mov    %rax,%rbx
   42452:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   42457:	e9 a4 db ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'm' || c == 'c' || c == 't'|| c =='2') {
   4245c:	eb 11                	jmp    4246f <check_keyboard+0x12d>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   4245e:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   42462:	74 06                	je     4246a <check_keyboard+0x128>
   42464:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   42468:	75 05                	jne    4246f <check_keyboard+0x12d>
        poweroff();
   4246a:	e8 9d f8 ff ff       	call   41d0c <poweroff>
    }
    return c;
   4246f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   42472:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42476:	c9                   	leave  
   42477:	c3                   	ret    

0000000000042478 <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   42478:	55                   	push   %rbp
   42479:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   4247c:	e8 c1 fe ff ff       	call   42342 <check_keyboard>
   42481:	eb f9                	jmp    4247c <fail+0x4>

0000000000042483 <kernel_panic>:

// kernel_panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void kernel_panic(const char* format, ...) {
   42483:	55                   	push   %rbp
   42484:	48 89 e5             	mov    %rsp,%rbp
   42487:	48 83 ec 60          	sub    $0x60,%rsp
   4248b:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   4248f:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42493:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42497:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4249b:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4249f:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   424a3:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   424aa:	48 8d 45 10          	lea    0x10(%rbp),%rax
   424ae:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   424b2:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   424b6:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   424ba:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   424bf:	0f 84 80 00 00 00    	je     42545 <kernel_panic+0xc2>
        // Print kernel_panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   424c5:	ba 2f 52 04 00       	mov    $0x4522f,%edx
   424ca:	be 00 c0 00 00       	mov    $0xc000,%esi
   424cf:	bf 30 07 00 00       	mov    $0x730,%edi
   424d4:	b8 00 00 00 00       	mov    $0x0,%eax
   424d9:	e8 12 fe ff ff       	call   422f0 <error_printf>
   424de:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   424e1:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   424e5:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   424e9:	8b 45 cc             	mov    -0x34(%rbp),%eax
   424ec:	be 00 c0 00 00       	mov    $0xc000,%esi
   424f1:	89 c7                	mov    %eax,%edi
   424f3:	e8 9a fd ff ff       	call   42292 <error_vprintf>
   424f8:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   424fb:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   424fe:	48 63 c1             	movslq %ecx,%rax
   42501:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   42508:	48 c1 e8 20          	shr    $0x20,%rax
   4250c:	89 c2                	mov    %eax,%edx
   4250e:	c1 fa 05             	sar    $0x5,%edx
   42511:	89 c8                	mov    %ecx,%eax
   42513:	c1 f8 1f             	sar    $0x1f,%eax
   42516:	29 c2                	sub    %eax,%edx
   42518:	89 d0                	mov    %edx,%eax
   4251a:	c1 e0 02             	shl    $0x2,%eax
   4251d:	01 d0                	add    %edx,%eax
   4251f:	c1 e0 04             	shl    $0x4,%eax
   42522:	29 c1                	sub    %eax,%ecx
   42524:	89 ca                	mov    %ecx,%edx
   42526:	85 d2                	test   %edx,%edx
   42528:	74 34                	je     4255e <kernel_panic+0xdb>
            error_printf(cpos, 0xC000, "\n");
   4252a:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4252d:	ba 37 52 04 00       	mov    $0x45237,%edx
   42532:	be 00 c0 00 00       	mov    $0xc000,%esi
   42537:	89 c7                	mov    %eax,%edi
   42539:	b8 00 00 00 00       	mov    $0x0,%eax
   4253e:	e8 ad fd ff ff       	call   422f0 <error_printf>
   42543:	eb 19                	jmp    4255e <kernel_panic+0xdb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   42545:	ba 39 52 04 00       	mov    $0x45239,%edx
   4254a:	be 00 c0 00 00       	mov    $0xc000,%esi
   4254f:	bf 30 07 00 00       	mov    $0x730,%edi
   42554:	b8 00 00 00 00       	mov    $0x0,%eax
   42559:	e8 92 fd ff ff       	call   422f0 <error_printf>
    }

    va_end(val);
    fail();
   4255e:	e8 15 ff ff ff       	call   42478 <fail>

0000000000042563 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   42563:	55                   	push   %rbp
   42564:	48 89 e5             	mov    %rsp,%rbp
   42567:	48 83 ec 20          	sub    $0x20,%rsp
   4256b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4256f:	89 75 f4             	mov    %esi,-0xc(%rbp)
   42572:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    kernel_panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   42576:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   4257a:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4257d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42581:	48 89 c6             	mov    %rax,%rsi
   42584:	bf 3f 52 04 00       	mov    $0x4523f,%edi
   42589:	b8 00 00 00 00       	mov    $0x0,%eax
   4258e:	e8 f0 fe ff ff       	call   42483 <kernel_panic>

0000000000042593 <default_exception>:
}

void default_exception(proc* p){
   42593:	55                   	push   %rbp
   42594:	48 89 e5             	mov    %rsp,%rbp
   42597:	48 83 ec 20          	sub    $0x20,%rsp
   4259b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   4259f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   425a3:	48 83 c0 18          	add    $0x18,%rax
   425a7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    kernel_panic("Unexpected exception %d!\n", reg->reg_intno);
   425ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   425af:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   425b6:	48 89 c6             	mov    %rax,%rsi
   425b9:	bf 5d 52 04 00       	mov    $0x4525d,%edi
   425be:	b8 00 00 00 00       	mov    $0x0,%eax
   425c3:	e8 bb fe ff ff       	call   42483 <kernel_panic>

00000000000425c8 <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   425c8:	55                   	push   %rbp
   425c9:	48 89 e5             	mov    %rsp,%rbp
   425cc:	48 83 ec 10          	sub    $0x10,%rsp
   425d0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   425d4:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   425d7:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   425db:	78 06                	js     425e3 <pageindex+0x1b>
   425dd:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   425e1:	7e 14                	jle    425f7 <pageindex+0x2f>
   425e3:	ba 78 52 04 00       	mov    $0x45278,%edx
   425e8:	be 1e 00 00 00       	mov    $0x1e,%esi
   425ed:	bf 91 52 04 00       	mov    $0x45291,%edi
   425f2:	e8 6c ff ff ff       	call   42563 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   425f7:	b8 03 00 00 00       	mov    $0x3,%eax
   425fc:	2b 45 f4             	sub    -0xc(%rbp),%eax
   425ff:	89 c2                	mov    %eax,%edx
   42601:	89 d0                	mov    %edx,%eax
   42603:	c1 e0 03             	shl    $0x3,%eax
   42606:	01 d0                	add    %edx,%eax
   42608:	83 c0 0c             	add    $0xc,%eax
   4260b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4260f:	89 c1                	mov    %eax,%ecx
   42611:	48 d3 ea             	shr    %cl,%rdx
   42614:	48 89 d0             	mov    %rdx,%rax
   42617:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   4261c:	c9                   	leave  
   4261d:	c3                   	ret    

000000000004261e <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   4261e:	55                   	push   %rbp
   4261f:	48 89 e5             	mov    %rsp,%rbp
   42622:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   42626:	48 c7 05 cf e9 00 00 	movq   $0x52000,0xe9cf(%rip)        # 51000 <kernel_pagetable>
   4262d:	00 20 05 00 
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   42631:	ba 00 50 00 00       	mov    $0x5000,%edx
   42636:	be 00 00 00 00       	mov    $0x0,%esi
   4263b:	bf 00 20 05 00       	mov    $0x52000,%edi
   42640:	e8 61 16 00 00       	call   43ca6 <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   42645:	b8 00 30 05 00       	mov    $0x53000,%eax
   4264a:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   4264e:	48 89 05 ab f9 00 00 	mov    %rax,0xf9ab(%rip)        # 52000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   42655:	b8 00 40 05 00       	mov    $0x54000,%eax
   4265a:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   4265e:	48 89 05 9b 09 01 00 	mov    %rax,0x1099b(%rip)        # 53000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   42665:	b8 00 50 05 00       	mov    $0x55000,%eax
   4266a:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   4266e:	48 89 05 8b 19 01 00 	mov    %rax,0x1198b(%rip)        # 54000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   42675:	b8 00 60 05 00       	mov    $0x56000,%eax
   4267a:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   4267e:	48 89 05 83 19 01 00 	mov    %rax,0x11983(%rip)        # 54008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   42685:	48 8b 05 74 e9 00 00 	mov    0xe974(%rip),%rax        # 51000 <kernel_pagetable>
   4268c:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42692:	b9 00 00 20 00       	mov    $0x200000,%ecx
   42697:	ba 00 00 00 00       	mov    $0x0,%edx
   4269c:	be 00 00 00 00       	mov    $0x0,%esi
   426a1:	48 89 c7             	mov    %rax,%rdi
   426a4:	e8 b9 01 00 00       	call   42862 <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   426a9:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   426b0:	00 
   426b1:	eb 62                	jmp    42715 <virtual_memory_init+0xf7>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   426b3:	48 8b 0d 46 e9 00 00 	mov    0xe946(%rip),%rcx        # 51000 <kernel_pagetable>
   426ba:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   426be:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   426c2:	48 89 ce             	mov    %rcx,%rsi
   426c5:	48 89 c7             	mov    %rax,%rdi
   426c8:	e8 58 05 00 00       	call   42c25 <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l4pagetable ?
        assert(vmap.pa == addr);
   426cd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   426d1:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   426d5:	74 14                	je     426eb <virtual_memory_init+0xcd>
   426d7:	ba a5 52 04 00       	mov    $0x452a5,%edx
   426dc:	be 2d 00 00 00       	mov    $0x2d,%esi
   426e1:	bf b5 52 04 00       	mov    $0x452b5,%edi
   426e6:	e8 78 fe ff ff       	call   42563 <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   426eb:	8b 45 f0             	mov    -0x10(%rbp),%eax
   426ee:	48 98                	cltq   
   426f0:	83 e0 03             	and    $0x3,%eax
   426f3:	48 83 f8 03          	cmp    $0x3,%rax
   426f7:	74 14                	je     4270d <virtual_memory_init+0xef>
   426f9:	ba c8 52 04 00       	mov    $0x452c8,%edx
   426fe:	be 2e 00 00 00       	mov    $0x2e,%esi
   42703:	bf b5 52 04 00       	mov    $0x452b5,%edi
   42708:	e8 56 fe ff ff       	call   42563 <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   4270d:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42714:	00 
   42715:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   4271c:	00 
   4271d:	76 94                	jbe    426b3 <virtual_memory_init+0x95>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   4271f:	48 8b 05 da e8 00 00 	mov    0xe8da(%rip),%rax        # 51000 <kernel_pagetable>
   42726:	48 89 c7             	mov    %rax,%rdi
   42729:	e8 03 00 00 00       	call   42731 <set_pagetable>
}
   4272e:	90                   	nop
   4272f:	c9                   	leave  
   42730:	c3                   	ret    

0000000000042731 <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls kernel_panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   42731:	55                   	push   %rbp
   42732:	48 89 e5             	mov    %rsp,%rbp
   42735:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   42739:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   4273d:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42741:	25 ff 0f 00 00       	and    $0xfff,%eax
   42746:	48 85 c0             	test   %rax,%rax
   42749:	74 14                	je     4275f <set_pagetable+0x2e>
   4274b:	ba f5 52 04 00       	mov    $0x452f5,%edx
   42750:	be 3d 00 00 00       	mov    $0x3d,%esi
   42755:	bf b5 52 04 00       	mov    $0x452b5,%edi
   4275a:	e8 04 fe ff ff       	call   42563 <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   4275f:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42764:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   42768:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   4276c:	48 89 ce             	mov    %rcx,%rsi
   4276f:	48 89 c7             	mov    %rax,%rdi
   42772:	e8 ae 04 00 00       	call   42c25 <virtual_memory_lookup>
   42777:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   4277b:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42780:	48 39 d0             	cmp    %rdx,%rax
   42783:	74 14                	je     42799 <set_pagetable+0x68>
   42785:	ba 10 53 04 00       	mov    $0x45310,%edx
   4278a:	be 3f 00 00 00       	mov    $0x3f,%esi
   4278f:	bf b5 52 04 00       	mov    $0x452b5,%edi
   42794:	e8 ca fd ff ff       	call   42563 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   42799:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   4279d:	48 8b 0d 5c e8 00 00 	mov    0xe85c(%rip),%rcx        # 51000 <kernel_pagetable>
   427a4:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   427a8:	48 89 ce             	mov    %rcx,%rsi
   427ab:	48 89 c7             	mov    %rax,%rdi
   427ae:	e8 72 04 00 00       	call   42c25 <virtual_memory_lookup>
   427b3:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   427b7:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   427bb:	48 39 c2             	cmp    %rax,%rdx
   427be:	74 14                	je     427d4 <set_pagetable+0xa3>
   427c0:	ba 78 53 04 00       	mov    $0x45378,%edx
   427c5:	be 41 00 00 00       	mov    $0x41,%esi
   427ca:	bf b5 52 04 00       	mov    $0x452b5,%edi
   427cf:	e8 8f fd ff ff       	call   42563 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   427d4:	48 8b 05 25 e8 00 00 	mov    0xe825(%rip),%rax        # 51000 <kernel_pagetable>
   427db:	48 89 c2             	mov    %rax,%rdx
   427de:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   427e2:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   427e6:	48 89 ce             	mov    %rcx,%rsi
   427e9:	48 89 c7             	mov    %rax,%rdi
   427ec:	e8 34 04 00 00       	call   42c25 <virtual_memory_lookup>
   427f1:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   427f5:	48 8b 15 04 e8 00 00 	mov    0xe804(%rip),%rdx        # 51000 <kernel_pagetable>
   427fc:	48 39 d0             	cmp    %rdx,%rax
   427ff:	74 14                	je     42815 <set_pagetable+0xe4>
   42801:	ba d8 53 04 00       	mov    $0x453d8,%edx
   42806:	be 43 00 00 00       	mov    $0x43,%esi
   4280b:	bf b5 52 04 00       	mov    $0x452b5,%edi
   42810:	e8 4e fd ff ff       	call   42563 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   42815:	ba 62 28 04 00       	mov    $0x42862,%edx
   4281a:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   4281e:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42822:	48 89 ce             	mov    %rcx,%rsi
   42825:	48 89 c7             	mov    %rax,%rdi
   42828:	e8 f8 03 00 00       	call   42c25 <virtual_memory_lookup>
   4282d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42831:	ba 62 28 04 00       	mov    $0x42862,%edx
   42836:	48 39 d0             	cmp    %rdx,%rax
   42839:	74 14                	je     4284f <set_pagetable+0x11e>
   4283b:	ba 40 54 04 00       	mov    $0x45440,%edx
   42840:	be 45 00 00 00       	mov    $0x45,%esi
   42845:	bf b5 52 04 00       	mov    $0x452b5,%edi
   4284a:	e8 14 fd ff ff       	call   42563 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   4284f:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42853:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42857:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4285b:	0f 22 d8             	mov    %rax,%cr3
}
   4285e:	90                   	nop
}
   4285f:	90                   	nop
   42860:	c9                   	leave  
   42861:	c3                   	ret    

0000000000042862 <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   42862:	55                   	push   %rbp
   42863:	48 89 e5             	mov    %rsp,%rbp
   42866:	53                   	push   %rbx
   42867:	48 83 ec 58          	sub    $0x58,%rsp
   4286b:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   4286f:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42873:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   42877:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
   4287b:	44 89 45 ac          	mov    %r8d,-0x54(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   4287f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42883:	25 ff 0f 00 00       	and    $0xfff,%eax
   42888:	48 85 c0             	test   %rax,%rax
   4288b:	74 14                	je     428a1 <virtual_memory_map+0x3f>
   4288d:	ba a6 54 04 00       	mov    $0x454a6,%edx
   42892:	be 66 00 00 00       	mov    $0x66,%esi
   42897:	bf b5 52 04 00       	mov    $0x452b5,%edi
   4289c:	e8 c2 fc ff ff       	call   42563 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   428a1:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   428a5:	25 ff 0f 00 00       	and    $0xfff,%eax
   428aa:	48 85 c0             	test   %rax,%rax
   428ad:	74 14                	je     428c3 <virtual_memory_map+0x61>
   428af:	ba b9 54 04 00       	mov    $0x454b9,%edx
   428b4:	be 67 00 00 00       	mov    $0x67,%esi
   428b9:	bf b5 52 04 00       	mov    $0x452b5,%edi
   428be:	e8 a0 fc ff ff       	call   42563 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   428c3:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   428c7:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   428cb:	48 01 d0             	add    %rdx,%rax
   428ce:	48 3b 45 c0          	cmp    -0x40(%rbp),%rax
   428d2:	73 24                	jae    428f8 <virtual_memory_map+0x96>
   428d4:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   428d8:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   428dc:	48 01 d0             	add    %rdx,%rax
   428df:	48 85 c0             	test   %rax,%rax
   428e2:	74 14                	je     428f8 <virtual_memory_map+0x96>
   428e4:	ba cc 54 04 00       	mov    $0x454cc,%edx
   428e9:	be 68 00 00 00       	mov    $0x68,%esi
   428ee:	bf b5 52 04 00       	mov    $0x452b5,%edi
   428f3:	e8 6b fc ff ff       	call   42563 <assert_fail>
    if (perm & PTE_P) {
   428f8:	8b 45 ac             	mov    -0x54(%rbp),%eax
   428fb:	48 98                	cltq   
   428fd:	83 e0 01             	and    $0x1,%eax
   42900:	48 85 c0             	test   %rax,%rax
   42903:	74 6e                	je     42973 <virtual_memory_map+0x111>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   42905:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42909:	25 ff 0f 00 00       	and    $0xfff,%eax
   4290e:	48 85 c0             	test   %rax,%rax
   42911:	74 14                	je     42927 <virtual_memory_map+0xc5>
   42913:	ba ea 54 04 00       	mov    $0x454ea,%edx
   42918:	be 6a 00 00 00       	mov    $0x6a,%esi
   4291d:	bf b5 52 04 00       	mov    $0x452b5,%edi
   42922:	e8 3c fc ff ff       	call   42563 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   42927:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   4292b:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   4292f:	48 01 d0             	add    %rdx,%rax
   42932:	48 3b 45 b8          	cmp    -0x48(%rbp),%rax
   42936:	73 14                	jae    4294c <virtual_memory_map+0xea>
   42938:	ba fd 54 04 00       	mov    $0x454fd,%edx
   4293d:	be 6b 00 00 00       	mov    $0x6b,%esi
   42942:	bf b5 52 04 00       	mov    $0x452b5,%edi
   42947:	e8 17 fc ff ff       	call   42563 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   4294c:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42950:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42954:	48 01 d0             	add    %rdx,%rax
   42957:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   4295d:	76 14                	jbe    42973 <virtual_memory_map+0x111>
   4295f:	ba 0b 55 04 00       	mov    $0x4550b,%edx
   42964:	be 6c 00 00 00       	mov    $0x6c,%esi
   42969:	bf b5 52 04 00       	mov    $0x452b5,%edi
   4296e:	e8 f0 fb ff ff       	call   42563 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   42973:	83 7d ac 00          	cmpl   $0x0,-0x54(%rbp)
   42977:	78 09                	js     42982 <virtual_memory_map+0x120>
   42979:	81 7d ac ff 0f 00 00 	cmpl   $0xfff,-0x54(%rbp)
   42980:	7e 14                	jle    42996 <virtual_memory_map+0x134>
   42982:	ba 27 55 04 00       	mov    $0x45527,%edx
   42987:	be 6e 00 00 00       	mov    $0x6e,%esi
   4298c:	bf b5 52 04 00       	mov    $0x452b5,%edi
   42991:	e8 cd fb ff ff       	call   42563 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   42996:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4299a:	25 ff 0f 00 00       	and    $0xfff,%eax
   4299f:	48 85 c0             	test   %rax,%rax
   429a2:	74 14                	je     429b8 <virtual_memory_map+0x156>
   429a4:	ba 48 55 04 00       	mov    $0x45548,%edx
   429a9:	be 6f 00 00 00       	mov    $0x6f,%esi
   429ae:	bf b5 52 04 00       	mov    $0x452b5,%edi
   429b3:	e8 ab fb ff ff       	call   42563 <assert_fail>

    int last_index123 = -1;
   429b8:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%rbp)
    x86_64_pagetable* l4pagetable = NULL;
   429bf:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
   429c6:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   429c7:	e9 e1 00 00 00       	jmp    42aad <virtual_memory_map+0x24b>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   429cc:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   429d0:	48 c1 e8 15          	shr    $0x15,%rax
   429d4:	89 45 dc             	mov    %eax,-0x24(%rbp)
        if (cur_index123 != last_index123) {
   429d7:	8b 45 dc             	mov    -0x24(%rbp),%eax
   429da:	3b 45 ec             	cmp    -0x14(%rbp),%eax
   429dd:	74 20                	je     429ff <virtual_memory_map+0x19d>
            // find pointer to last level pagetable for current va
            l4pagetable = lookup_l4pagetable(pagetable, va, perm);
   429df:	8b 55 ac             	mov    -0x54(%rbp),%edx
   429e2:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   429e6:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   429ea:	48 89 ce             	mov    %rcx,%rsi
   429ed:	48 89 c7             	mov    %rax,%rdi
   429f0:	e8 ce 00 00 00       	call   42ac3 <lookup_l4pagetable>
   429f5:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            last_index123 = cur_index123;
   429f9:	8b 45 dc             	mov    -0x24(%rbp),%eax
   429fc:	89 45 ec             	mov    %eax,-0x14(%rbp)
        }
        if ((perm & PTE_P) && l4pagetable) { // if page is marked present
   429ff:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42a02:	48 98                	cltq   
   42a04:	83 e0 01             	and    $0x1,%eax
   42a07:	48 85 c0             	test   %rax,%rax
   42a0a:	74 34                	je     42a40 <virtual_memory_map+0x1de>
   42a0c:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42a11:	74 2d                	je     42a40 <virtual_memory_map+0x1de>
            // set page table entry to pa and perm
            l4pagetable->entry[L4PAGEINDEX(va)] = pa | perm;
   42a13:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42a16:	48 63 d8             	movslq %eax,%rbx
   42a19:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42a1d:	be 03 00 00 00       	mov    $0x3,%esi
   42a22:	48 89 c7             	mov    %rax,%rdi
   42a25:	e8 9e fb ff ff       	call   425c8 <pageindex>
   42a2a:	89 c2                	mov    %eax,%edx
   42a2c:	48 0b 5d b8          	or     -0x48(%rbp),%rbx
   42a30:	48 89 d9             	mov    %rbx,%rcx
   42a33:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42a37:	48 63 d2             	movslq %edx,%rdx
   42a3a:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42a3e:	eb 55                	jmp    42a95 <virtual_memory_map+0x233>
        } else if (l4pagetable) { // if page is NOT marked present
   42a40:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42a45:	74 26                	je     42a6d <virtual_memory_map+0x20b>
            // set page table entry to just perm
            l4pagetable->entry[L4PAGEINDEX(va)] = perm;
   42a47:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42a4b:	be 03 00 00 00       	mov    $0x3,%esi
   42a50:	48 89 c7             	mov    %rax,%rdi
   42a53:	e8 70 fb ff ff       	call   425c8 <pageindex>
   42a58:	89 c2                	mov    %eax,%edx
   42a5a:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42a5d:	48 63 c8             	movslq %eax,%rcx
   42a60:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42a64:	48 63 d2             	movslq %edx,%rdx
   42a67:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42a6b:	eb 28                	jmp    42a95 <virtual_memory_map+0x233>
        } else if (perm & PTE_P) {
   42a6d:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42a70:	48 98                	cltq   
   42a72:	83 e0 01             	and    $0x1,%eax
   42a75:	48 85 c0             	test   %rax,%rax
   42a78:	74 1b                	je     42a95 <virtual_memory_map+0x233>
            // error, no allocated l4 page found for va
            log_printf("[Kern Info] failed to find l4pagetable address at " __FILE__ ": %d\n", __LINE__);
   42a7a:	be 84 00 00 00       	mov    $0x84,%esi
   42a7f:	bf 70 55 04 00       	mov    $0x45570,%edi
   42a84:	b8 00 00 00 00       	mov    $0x0,%eax
   42a89:	e8 b7 f7 ff ff       	call   42245 <log_printf>
            return -1;
   42a8e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42a93:	eb 28                	jmp    42abd <virtual_memory_map+0x25b>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42a95:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
   42a9c:	00 
   42a9d:	48 81 45 b8 00 10 00 	addq   $0x1000,-0x48(%rbp)
   42aa4:	00 
   42aa5:	48 81 6d b0 00 10 00 	subq   $0x1000,-0x50(%rbp)
   42aac:	00 
   42aad:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   42ab2:	0f 85 14 ff ff ff    	jne    429cc <virtual_memory_map+0x16a>
        }
    }
    return 0;
   42ab8:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42abd:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42ac1:	c9                   	leave  
   42ac2:	c3                   	ret    

0000000000042ac3 <lookup_l4pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   42ac3:	55                   	push   %rbp
   42ac4:	48 89 e5             	mov    %rsp,%rbp
   42ac7:	48 83 ec 40          	sub    $0x40,%rsp
   42acb:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42acf:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42ad3:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   42ad6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42ada:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l4 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   42ade:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   42ae5:	e9 2b 01 00 00       	jmp    42c15 <lookup_l4pagetable+0x152>
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        x86_64_pageentry_t pe = pt->entry[PAGEINDEX(va, i)];
   42aea:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42aed:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42af1:	89 d6                	mov    %edx,%esi
   42af3:	48 89 c7             	mov    %rax,%rdi
   42af6:	e8 cd fa ff ff       	call   425c8 <pageindex>
   42afb:	89 c2                	mov    %eax,%edx
   42afd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42b01:	48 63 d2             	movslq %edx,%rdx
   42b04:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   42b08:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   42b0c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b10:	83 e0 01             	and    $0x1,%eax
   42b13:	48 85 c0             	test   %rax,%rax
   42b16:	75 63                	jne    42b7b <lookup_l4pagetable+0xb8>
            log_printf("[Kern Info] Error looking up l4pagetable: Pagetable address: 0x%x perm: 0x%x."
   42b18:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42b1b:	8d 48 02             	lea    0x2(%rax),%ecx
   42b1e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b22:	25 ff 0f 00 00       	and    $0xfff,%eax
   42b27:	48 89 c2             	mov    %rax,%rdx
   42b2a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b2e:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42b34:	48 89 c6             	mov    %rax,%rsi
   42b37:	bf b8 55 04 00       	mov    $0x455b8,%edi
   42b3c:	b8 00 00 00 00       	mov    $0x0,%eax
   42b41:	e8 ff f6 ff ff       	call   42245 <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   42b46:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42b49:	48 98                	cltq   
   42b4b:	83 e0 01             	and    $0x1,%eax
   42b4e:	48 85 c0             	test   %rax,%rax
   42b51:	75 0a                	jne    42b5d <lookup_l4pagetable+0x9a>
                return NULL;
   42b53:	b8 00 00 00 00       	mov    $0x0,%eax
   42b58:	e9 c6 00 00 00       	jmp    42c23 <lookup_l4pagetable+0x160>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   42b5d:	be a7 00 00 00       	mov    $0xa7,%esi
   42b62:	bf 20 56 04 00       	mov    $0x45620,%edi
   42b67:	b8 00 00 00 00       	mov    $0x0,%eax
   42b6c:	e8 d4 f6 ff ff       	call   42245 <log_printf>
            return NULL;
   42b71:	b8 00 00 00 00       	mov    $0x0,%eax
   42b76:	e9 a8 00 00 00       	jmp    42c23 <lookup_l4pagetable+0x160>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   42b7b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b7f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42b85:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   42b8b:	76 14                	jbe    42ba1 <lookup_l4pagetable+0xde>
   42b8d:	ba 68 56 04 00       	mov    $0x45668,%edx
   42b92:	be ac 00 00 00       	mov    $0xac,%esi
   42b97:	bf b5 52 04 00       	mov    $0x452b5,%edi
   42b9c:	e8 c2 f9 ff ff       	call   42563 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   42ba1:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42ba4:	48 98                	cltq   
   42ba6:	83 e0 02             	and    $0x2,%eax
   42ba9:	48 85 c0             	test   %rax,%rax
   42bac:	74 20                	je     42bce <lookup_l4pagetable+0x10b>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   42bae:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42bb2:	83 e0 02             	and    $0x2,%eax
   42bb5:	48 85 c0             	test   %rax,%rax
   42bb8:	75 14                	jne    42bce <lookup_l4pagetable+0x10b>
   42bba:	ba 88 56 04 00       	mov    $0x45688,%edx
   42bbf:	be ae 00 00 00       	mov    $0xae,%esi
   42bc4:	bf b5 52 04 00       	mov    $0x452b5,%edi
   42bc9:	e8 95 f9 ff ff       	call   42563 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   42bce:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42bd1:	48 98                	cltq   
   42bd3:	83 e0 04             	and    $0x4,%eax
   42bd6:	48 85 c0             	test   %rax,%rax
   42bd9:	74 20                	je     42bfb <lookup_l4pagetable+0x138>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   42bdb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42bdf:	83 e0 04             	and    $0x4,%eax
   42be2:	48 85 c0             	test   %rax,%rax
   42be5:	75 14                	jne    42bfb <lookup_l4pagetable+0x138>
   42be7:	ba 93 56 04 00       	mov    $0x45693,%edx
   42bec:	be b1 00 00 00       	mov    $0xb1,%esi
   42bf1:	bf b5 52 04 00       	mov    $0x452b5,%edi
   42bf6:	e8 68 f9 ff ff       	call   42563 <assert_fail>
        }

        // set pt to physical address to next pagetable using `pe`
        pt = 0; // replace this
   42bfb:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42c02:	00 
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42c03:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c07:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42c0d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   42c11:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   42c15:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   42c19:	0f 8e cb fe ff ff    	jle    42aea <lookup_l4pagetable+0x27>
    }
    return pt;
   42c1f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   42c23:	c9                   	leave  
   42c24:	c3                   	ret    

0000000000042c25 <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   42c25:	55                   	push   %rbp
   42c26:	48 89 e5             	mov    %rsp,%rbp
   42c29:	48 83 ec 50          	sub    $0x50,%rsp
   42c2d:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42c31:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42c35:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   42c39:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42c3d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   42c41:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   42c48:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42c49:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   42c50:	eb 41                	jmp    42c93 <virtual_memory_lookup+0x6e>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   42c52:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42c55:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42c59:	89 d6                	mov    %edx,%esi
   42c5b:	48 89 c7             	mov    %rax,%rdi
   42c5e:	e8 65 f9 ff ff       	call   425c8 <pageindex>
   42c63:	89 c2                	mov    %eax,%edx
   42c65:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42c69:	48 63 d2             	movslq %edx,%rdx
   42c6c:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   42c70:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c74:	83 e0 06             	and    $0x6,%eax
   42c77:	48 f7 d0             	not    %rax
   42c7a:	48 21 d0             	and    %rdx,%rax
   42c7d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42c81:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c85:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42c8b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42c8f:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   42c93:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   42c97:	7f 0c                	jg     42ca5 <virtual_memory_lookup+0x80>
   42c99:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c9d:	83 e0 01             	and    $0x1,%eax
   42ca0:	48 85 c0             	test   %rax,%rax
   42ca3:	75 ad                	jne    42c52 <virtual_memory_lookup+0x2d>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   42ca5:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   42cac:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   42cb3:	ff 
   42cb4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   42cbb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42cbf:	83 e0 01             	and    $0x1,%eax
   42cc2:	48 85 c0             	test   %rax,%rax
   42cc5:	74 34                	je     42cfb <virtual_memory_lookup+0xd6>
        vam.pn = PAGENUMBER(pe);
   42cc7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ccb:	48 c1 e8 0c          	shr    $0xc,%rax
   42ccf:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   42cd2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42cd6:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42cdc:	48 89 c2             	mov    %rax,%rdx
   42cdf:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42ce3:	25 ff 0f 00 00       	and    $0xfff,%eax
   42ce8:	48 09 d0             	or     %rdx,%rax
   42ceb:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   42cef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42cf3:	25 ff 0f 00 00       	and    $0xfff,%eax
   42cf8:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   42cfb:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42cff:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42d03:	48 89 10             	mov    %rdx,(%rax)
   42d06:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   42d0a:	48 89 50 08          	mov    %rdx,0x8(%rax)
   42d0e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42d12:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   42d16:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42d1a:	c9                   	leave  
   42d1b:	c3                   	ret    

0000000000042d1c <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   42d1c:	55                   	push   %rbp
   42d1d:	48 89 e5             	mov    %rsp,%rbp
   42d20:	48 83 ec 40          	sub    $0x40,%rsp
   42d24:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42d28:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   42d2b:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   42d2f:	c7 45 f8 04 00 00 00 	movl   $0x4,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   42d36:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   42d3a:	78 08                	js     42d44 <program_load+0x28>
   42d3c:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42d3f:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   42d42:	7c 14                	jl     42d58 <program_load+0x3c>
   42d44:	ba a0 56 04 00       	mov    $0x456a0,%edx
   42d49:	be 2e 00 00 00       	mov    $0x2e,%esi
   42d4e:	bf d0 56 04 00       	mov    $0x456d0,%edi
   42d53:	e8 0b f8 ff ff       	call   42563 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   42d58:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42d5b:	48 98                	cltq   
   42d5d:	48 c1 e0 04          	shl    $0x4,%rax
   42d61:	48 05 20 60 04 00    	add    $0x46020,%rax
   42d67:	48 8b 00             	mov    (%rax),%rax
   42d6a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   42d6e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d72:	8b 00                	mov    (%rax),%eax
   42d74:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   42d79:	74 14                	je     42d8f <program_load+0x73>
   42d7b:	ba e2 56 04 00       	mov    $0x456e2,%edx
   42d80:	be 30 00 00 00       	mov    $0x30,%esi
   42d85:	bf d0 56 04 00       	mov    $0x456d0,%edi
   42d8a:	e8 d4 f7 ff ff       	call   42563 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   42d8f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d93:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42d97:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d9b:	48 01 d0             	add    %rdx,%rax
   42d9e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   42da2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42da9:	e9 94 00 00 00       	jmp    42e42 <program_load+0x126>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   42dae:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42db1:	48 63 d0             	movslq %eax,%rdx
   42db4:	48 89 d0             	mov    %rdx,%rax
   42db7:	48 c1 e0 03          	shl    $0x3,%rax
   42dbb:	48 29 d0             	sub    %rdx,%rax
   42dbe:	48 c1 e0 03          	shl    $0x3,%rax
   42dc2:	48 89 c2             	mov    %rax,%rdx
   42dc5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42dc9:	48 01 d0             	add    %rdx,%rax
   42dcc:	8b 00                	mov    (%rax),%eax
   42dce:	83 f8 01             	cmp    $0x1,%eax
   42dd1:	75 6b                	jne    42e3e <program_load+0x122>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   42dd3:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42dd6:	48 63 d0             	movslq %eax,%rdx
   42dd9:	48 89 d0             	mov    %rdx,%rax
   42ddc:	48 c1 e0 03          	shl    $0x3,%rax
   42de0:	48 29 d0             	sub    %rdx,%rax
   42de3:	48 c1 e0 03          	shl    $0x3,%rax
   42de7:	48 89 c2             	mov    %rax,%rdx
   42dea:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42dee:	48 01 d0             	add    %rdx,%rax
   42df1:	48 8b 50 08          	mov    0x8(%rax),%rdx
   42df5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42df9:	48 01 d0             	add    %rdx,%rax
   42dfc:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   42e00:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42e03:	48 63 d0             	movslq %eax,%rdx
   42e06:	48 89 d0             	mov    %rdx,%rax
   42e09:	48 c1 e0 03          	shl    $0x3,%rax
   42e0d:	48 29 d0             	sub    %rdx,%rax
   42e10:	48 c1 e0 03          	shl    $0x3,%rax
   42e14:	48 89 c2             	mov    %rax,%rdx
   42e17:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42e1b:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   42e1f:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42e23:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42e27:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e2b:	48 89 c7             	mov    %rax,%rdi
   42e2e:	e8 3d 00 00 00       	call   42e70 <program_load_segment>
   42e33:	85 c0                	test   %eax,%eax
   42e35:	79 07                	jns    42e3e <program_load+0x122>
                return -1;
   42e37:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42e3c:	eb 30                	jmp    42e6e <program_load+0x152>
    for (int i = 0; i < eh->e_phnum; ++i) {
   42e3e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   42e42:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e46:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   42e4a:	0f b7 c0             	movzwl %ax,%eax
   42e4d:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   42e50:	0f 8c 58 ff ff ff    	jl     42dae <program_load+0x92>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   42e56:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e5a:	48 8b 50 18          	mov    0x18(%rax),%rdx
   42e5e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e62:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    return 0;
   42e69:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42e6e:	c9                   	leave  
   42e6f:	c3                   	ret    

0000000000042e70 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   42e70:	55                   	push   %rbp
   42e71:	48 89 e5             	mov    %rsp,%rbp
   42e74:	48 83 ec 70          	sub    $0x70,%rsp
   42e78:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42e7c:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   42e80:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   42e84:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   42e88:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42e8c:	48 8b 40 10          	mov    0x10(%rax),%rax
   42e90:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   42e94:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42e98:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42e9c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ea0:	48 01 d0             	add    %rdx,%rax
   42ea3:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   42ea7:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42eab:	48 8b 50 28          	mov    0x28(%rax),%rdx
   42eaf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42eb3:	48 01 d0             	add    %rdx,%rax
   42eb6:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   42eba:	48 81 65 e8 00 f0 ff 	andq   $0xfffffffffffff000,-0x18(%rbp)
   42ec1:	ff 


    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42ec2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ec6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   42eca:	eb 7c                	jmp    42f48 <program_load_segment+0xd8>
        uintptr_t pa = (uintptr_t)palloc(p->p_pid);
   42ecc:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42ed0:	8b 00                	mov    (%rax),%eax
   42ed2:	89 c7                	mov    %eax,%edi
   42ed4:	e8 9b 01 00 00       	call   43074 <palloc>
   42ed9:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        if(pa == (uintptr_t)NULL || virtual_memory_map(p->p_pagetable, addr, pa, PAGESIZE,
   42edd:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
   42ee2:	74 2a                	je     42f0e <program_load_segment+0x9e>
   42ee4:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42ee8:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   42eef:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42ef3:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   42ef7:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42efd:	b9 00 10 00 00       	mov    $0x1000,%ecx
   42f02:	48 89 c7             	mov    %rax,%rdi
   42f05:	e8 58 f9 ff ff       	call   42862 <virtual_memory_map>
   42f0a:	85 c0                	test   %eax,%eax
   42f0c:	79 32                	jns    42f40 <program_load_segment+0xd0>
                    PTE_W | PTE_P | PTE_U) < 0) {
            console_printf(CPOS(22, 0), 0xC000,
   42f0e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42f12:	8b 00                	mov    (%rax),%eax
   42f14:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42f18:	49 89 d0             	mov    %rdx,%r8
   42f1b:	89 c1                	mov    %eax,%ecx
   42f1d:	ba 00 57 04 00       	mov    $0x45700,%edx
   42f22:	be 00 c0 00 00       	mov    $0xc000,%esi
   42f27:	bf e0 06 00 00       	mov    $0x6e0,%edi
   42f2c:	b8 00 00 00 00       	mov    $0x0,%eax
   42f31:	e8 27 1b 00 00       	call   44a5d <console_printf>
                    "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
            return -1;
   42f36:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42f3b:	e9 32 01 00 00       	jmp    43072 <program_load_segment+0x202>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42f40:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42f47:	00 
   42f48:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42f4c:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   42f50:	0f 82 76 ff ff ff    	jb     42ecc <program_load_segment+0x5c>
        }
    }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   42f56:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42f5a:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   42f61:	48 89 c7             	mov    %rax,%rdi
   42f64:	e8 c8 f7 ff ff       	call   42731 <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   42f69:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42f6d:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   42f71:	48 89 c2             	mov    %rax,%rdx
   42f74:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f78:	48 8b 4d 98          	mov    -0x68(%rbp),%rcx
   42f7c:	48 89 ce             	mov    %rcx,%rsi
   42f7f:	48 89 c7             	mov    %rax,%rdi
   42f82:	e8 21 0c 00 00       	call   43ba8 <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   42f87:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42f8b:	48 2b 45 e0          	sub    -0x20(%rbp),%rax
   42f8f:	48 89 c2             	mov    %rax,%rdx
   42f92:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42f96:	be 00 00 00 00       	mov    $0x0,%esi
   42f9b:	48 89 c7             	mov    %rax,%rdi
   42f9e:	e8 03 0d 00 00       	call   43ca6 <memset>

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   42fa3:	48 8b 05 56 e0 00 00 	mov    0xe056(%rip),%rax        # 51000 <kernel_pagetable>
   42faa:	48 89 c7             	mov    %rax,%rdi
   42fad:	e8 7f f7 ff ff       	call   42731 <set_pagetable>


    if((ph->p_flags & ELF_PFLAG_WRITE) == 0) {
   42fb2:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42fb6:	8b 40 04             	mov    0x4(%rax),%eax
   42fb9:	83 e0 02             	and    $0x2,%eax
   42fbc:	85 c0                	test   %eax,%eax
   42fbe:	75 60                	jne    43020 <program_load_segment+0x1b0>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42fc0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42fc4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   42fc8:	eb 4c                	jmp    43016 <program_load_segment+0x1a6>
            vamapping mapping = virtual_memory_lookup(p->p_pagetable, addr);
   42fca:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42fce:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   42fd5:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   42fd9:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   42fdd:	48 89 ce             	mov    %rcx,%rsi
   42fe0:	48 89 c7             	mov    %rax,%rdi
   42fe3:	e8 3d fc ff ff       	call   42c25 <virtual_memory_lookup>

            virtual_memory_map(p->p_pagetable, addr, mapping.pa, PAGESIZE,
   42fe8:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42fec:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42ff0:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   42ff7:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   42ffb:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   43001:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43006:	48 89 c7             	mov    %rax,%rdi
   43009:	e8 54 f8 ff ff       	call   42862 <virtual_memory_map>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   4300e:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   43015:	00 
   43016:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4301a:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   4301e:	72 aa                	jb     42fca <program_load_segment+0x15a>
                    PTE_P | PTE_U);
        }
    }
    // TODO : Add code here -> done
    // log_printf("heap bottom/top before loading this segment: 0x%x\n", p->original_break);
    uintptr_t newbrk = (ph->p_va + ph->p_memsz + (PAGESIZE - 1)) & ~(PAGESIZE - 1);
   43020:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   43024:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43028:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   4302c:	48 8b 40 28          	mov    0x28(%rax),%rax
   43030:	48 01 d0             	add    %rdx,%rax
   43033:	48 05 ff 0f 00 00    	add    $0xfff,%rax
   43039:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4303f:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    if (newbrk > p->original_break)
   43043:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43047:	48 8b 40 10          	mov    0x10(%rax),%rax
   4304b:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   4304f:	73 0c                	jae    4305d <program_load_segment+0x1ed>
	    p->original_break = newbrk;
   43051:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43055:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   43059:	48 89 50 10          	mov    %rdx,0x10(%rax)
    p->program_break = p->original_break;
   4305d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43061:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43065:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43069:	48 89 50 08          	mov    %rdx,0x8(%rax)
    // log_printf("heap bottom/top after loading this segment: 0x%x\n", p->original_break);
    return 0;
   4306d:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43072:	c9                   	leave  
   43073:	c3                   	ret    

0000000000043074 <palloc>:
   43074:	55                   	push   %rbp
   43075:	48 89 e5             	mov    %rsp,%rbp
   43078:	48 83 ec 20          	sub    $0x20,%rsp
   4307c:	89 7d ec             	mov    %edi,-0x14(%rbp)
   4307f:	48 c7 45 f8 00 10 00 	movq   $0x1000,-0x8(%rbp)
   43086:	00 
   43087:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4308b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   4308f:	e9 95 00 00 00       	jmp    43129 <palloc+0xb5>
   43094:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43098:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   4309c:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   430a3:	00 
   430a4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   430a8:	48 c1 e8 0c          	shr    $0xc,%rax
   430ac:	48 98                	cltq   
   430ae:	0f b6 84 00 20 ef 04 	movzbl 0x4ef20(%rax,%rax,1),%eax
   430b5:	00 
   430b6:	84 c0                	test   %al,%al
   430b8:	75 6f                	jne    43129 <palloc+0xb5>
   430ba:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   430be:	48 c1 e8 0c          	shr    $0xc,%rax
   430c2:	48 98                	cltq   
   430c4:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   430cb:	00 
   430cc:	84 c0                	test   %al,%al
   430ce:	75 59                	jne    43129 <palloc+0xb5>
   430d0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   430d4:	48 c1 e8 0c          	shr    $0xc,%rax
   430d8:	89 c2                	mov    %eax,%edx
   430da:	48 63 c2             	movslq %edx,%rax
   430dd:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   430e4:	00 
   430e5:	83 c0 01             	add    $0x1,%eax
   430e8:	89 c1                	mov    %eax,%ecx
   430ea:	48 63 c2             	movslq %edx,%rax
   430ed:	88 8c 00 21 ef 04 00 	mov    %cl,0x4ef21(%rax,%rax,1)
   430f4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   430f8:	48 c1 e8 0c          	shr    $0xc,%rax
   430fc:	89 c1                	mov    %eax,%ecx
   430fe:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43101:	89 c2                	mov    %eax,%edx
   43103:	48 63 c1             	movslq %ecx,%rax
   43106:	88 94 00 20 ef 04 00 	mov    %dl,0x4ef20(%rax,%rax,1)
   4310d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43111:	ba 00 10 00 00       	mov    $0x1000,%edx
   43116:	be cc 00 00 00       	mov    $0xcc,%esi
   4311b:	48 89 c7             	mov    %rax,%rdi
   4311e:	e8 83 0b 00 00       	call   43ca6 <memset>
   43123:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43127:	eb 2c                	jmp    43155 <palloc+0xe1>
   43129:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   43130:	00 
   43131:	0f 86 5d ff ff ff    	jbe    43094 <palloc+0x20>
   43137:	ba 38 57 04 00       	mov    $0x45738,%edx
   4313c:	be 00 0c 00 00       	mov    $0xc00,%esi
   43141:	bf 80 07 00 00       	mov    $0x780,%edi
   43146:	b8 00 00 00 00       	mov    $0x0,%eax
   4314b:	e8 0d 19 00 00       	call   44a5d <console_printf>
   43150:	b8 00 00 00 00       	mov    $0x0,%eax
   43155:	c9                   	leave  
   43156:	c3                   	ret    

0000000000043157 <palloc_target>:
   43157:	55                   	push   %rbp
   43158:	48 89 e5             	mov    %rsp,%rbp
   4315b:	48 8b 05 9e 3e 01 00 	mov    0x13e9e(%rip),%rax        # 57000 <palloc_target_proc>
   43162:	48 85 c0             	test   %rax,%rax
   43165:	75 14                	jne    4317b <palloc_target+0x24>
   43167:	ba 51 57 04 00       	mov    $0x45751,%edx
   4316c:	be 27 00 00 00       	mov    $0x27,%esi
   43171:	bf 6c 57 04 00       	mov    $0x4576c,%edi
   43176:	e8 e8 f3 ff ff       	call   42563 <assert_fail>
   4317b:	48 8b 05 7e 3e 01 00 	mov    0x13e7e(%rip),%rax        # 57000 <palloc_target_proc>
   43182:	8b 00                	mov    (%rax),%eax
   43184:	89 c7                	mov    %eax,%edi
   43186:	e8 e9 fe ff ff       	call   43074 <palloc>
   4318b:	5d                   	pop    %rbp
   4318c:	c3                   	ret    

000000000004318d <process_free>:
   4318d:	55                   	push   %rbp
   4318e:	48 89 e5             	mov    %rsp,%rbp
   43191:	48 83 ec 60          	sub    $0x60,%rsp
   43195:	89 7d ac             	mov    %edi,-0x54(%rbp)
   43198:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4319b:	48 63 d0             	movslq %eax,%rdx
   4319e:	48 89 d0             	mov    %rdx,%rax
   431a1:	48 c1 e0 04          	shl    $0x4,%rax
   431a5:	48 29 d0             	sub    %rdx,%rax
   431a8:	48 c1 e0 04          	shl    $0x4,%rax
   431ac:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   431b2:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
   431b8:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   431bf:	00 
   431c0:	e9 ad 00 00 00       	jmp    43272 <process_free+0xe5>
   431c5:	8b 45 ac             	mov    -0x54(%rbp),%eax
   431c8:	48 63 d0             	movslq %eax,%rdx
   431cb:	48 89 d0             	mov    %rdx,%rax
   431ce:	48 c1 e0 04          	shl    $0x4,%rax
   431d2:	48 29 d0             	sub    %rdx,%rax
   431d5:	48 c1 e0 04          	shl    $0x4,%rax
   431d9:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   431df:	48 8b 08             	mov    (%rax),%rcx
   431e2:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   431e6:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   431ea:	48 89 ce             	mov    %rcx,%rsi
   431ed:	48 89 c7             	mov    %rax,%rdi
   431f0:	e8 30 fa ff ff       	call   42c25 <virtual_memory_lookup>
   431f5:	8b 45 c8             	mov    -0x38(%rbp),%eax
   431f8:	48 98                	cltq   
   431fa:	83 e0 01             	and    $0x1,%eax
   431fd:	48 85 c0             	test   %rax,%rax
   43200:	74 68                	je     4326a <process_free+0xdd>
   43202:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43205:	48 63 d0             	movslq %eax,%rdx
   43208:	0f b6 94 12 21 ef 04 	movzbl 0x4ef21(%rdx,%rdx,1),%edx
   4320f:	00 
   43210:	83 ea 01             	sub    $0x1,%edx
   43213:	48 98                	cltq   
   43215:	88 94 00 21 ef 04 00 	mov    %dl,0x4ef21(%rax,%rax,1)
   4321c:	8b 45 b8             	mov    -0x48(%rbp),%eax
   4321f:	48 98                	cltq   
   43221:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   43228:	00 
   43229:	84 c0                	test   %al,%al
   4322b:	75 0f                	jne    4323c <process_free+0xaf>
   4322d:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43230:	48 98                	cltq   
   43232:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43239:	00 
   4323a:	eb 2e                	jmp    4326a <process_free+0xdd>
   4323c:	8b 45 b8             	mov    -0x48(%rbp),%eax
   4323f:	48 98                	cltq   
   43241:	0f b6 84 00 20 ef 04 	movzbl 0x4ef20(%rax,%rax,1),%eax
   43248:	00 
   43249:	0f be c0             	movsbl %al,%eax
   4324c:	39 45 ac             	cmp    %eax,-0x54(%rbp)
   4324f:	75 19                	jne    4326a <process_free+0xdd>
   43251:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43255:	8b 55 ac             	mov    -0x54(%rbp),%edx
   43258:	48 89 c6             	mov    %rax,%rsi
   4325b:	bf 78 57 04 00       	mov    $0x45778,%edi
   43260:	b8 00 00 00 00       	mov    $0x0,%eax
   43265:	e8 db ef ff ff       	call   42245 <log_printf>
   4326a:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43271:	00 
   43272:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   43279:	00 
   4327a:	0f 86 45 ff ff ff    	jbe    431c5 <process_free+0x38>
   43280:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43283:	48 63 d0             	movslq %eax,%rdx
   43286:	48 89 d0             	mov    %rdx,%rax
   43289:	48 c1 e0 04          	shl    $0x4,%rax
   4328d:	48 29 d0             	sub    %rdx,%rax
   43290:	48 c1 e0 04          	shl    $0x4,%rax
   43294:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   4329a:	48 8b 00             	mov    (%rax),%rax
   4329d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   432a1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432a5:	48 8b 00             	mov    (%rax),%rax
   432a8:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   432ae:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   432b2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   432b6:	48 8b 00             	mov    (%rax),%rax
   432b9:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   432bf:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   432c3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   432c7:	48 8b 00             	mov    (%rax),%rax
   432ca:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   432d0:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   432d4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   432d8:	48 8b 40 08          	mov    0x8(%rax),%rax
   432dc:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   432e2:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
   432e6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   432ea:	48 c1 e8 0c          	shr    $0xc,%rax
   432ee:	48 98                	cltq   
   432f0:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   432f7:	00 
   432f8:	3c 01                	cmp    $0x1,%al
   432fa:	74 14                	je     43310 <process_free+0x183>
   432fc:	ba b0 57 04 00       	mov    $0x457b0,%edx
   43301:	be 4f 00 00 00       	mov    $0x4f,%esi
   43306:	bf 6c 57 04 00       	mov    $0x4576c,%edi
   4330b:	e8 53 f2 ff ff       	call   42563 <assert_fail>
   43310:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43314:	48 c1 e8 0c          	shr    $0xc,%rax
   43318:	48 98                	cltq   
   4331a:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43321:	00 
   43322:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43326:	48 c1 e8 0c          	shr    $0xc,%rax
   4332a:	48 98                	cltq   
   4332c:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43333:	00 
   43334:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43338:	48 c1 e8 0c          	shr    $0xc,%rax
   4333c:	48 98                	cltq   
   4333e:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   43345:	00 
   43346:	3c 01                	cmp    $0x1,%al
   43348:	74 14                	je     4335e <process_free+0x1d1>
   4334a:	ba d8 57 04 00       	mov    $0x457d8,%edx
   4334f:	be 52 00 00 00       	mov    $0x52,%esi
   43354:	bf 6c 57 04 00       	mov    $0x4576c,%edi
   43359:	e8 05 f2 ff ff       	call   42563 <assert_fail>
   4335e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43362:	48 c1 e8 0c          	shr    $0xc,%rax
   43366:	48 98                	cltq   
   43368:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   4336f:	00 
   43370:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43374:	48 c1 e8 0c          	shr    $0xc,%rax
   43378:	48 98                	cltq   
   4337a:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43381:	00 
   43382:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43386:	48 c1 e8 0c          	shr    $0xc,%rax
   4338a:	48 98                	cltq   
   4338c:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   43393:	00 
   43394:	3c 01                	cmp    $0x1,%al
   43396:	74 14                	je     433ac <process_free+0x21f>
   43398:	ba 00 58 04 00       	mov    $0x45800,%edx
   4339d:	be 55 00 00 00       	mov    $0x55,%esi
   433a2:	bf 6c 57 04 00       	mov    $0x4576c,%edi
   433a7:	e8 b7 f1 ff ff       	call   42563 <assert_fail>
   433ac:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   433b0:	48 c1 e8 0c          	shr    $0xc,%rax
   433b4:	48 98                	cltq   
   433b6:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   433bd:	00 
   433be:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   433c2:	48 c1 e8 0c          	shr    $0xc,%rax
   433c6:	48 98                	cltq   
   433c8:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   433cf:	00 
   433d0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   433d4:	48 c1 e8 0c          	shr    $0xc,%rax
   433d8:	48 98                	cltq   
   433da:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   433e1:	00 
   433e2:	3c 01                	cmp    $0x1,%al
   433e4:	74 14                	je     433fa <process_free+0x26d>
   433e6:	ba 28 58 04 00       	mov    $0x45828,%edx
   433eb:	be 58 00 00 00       	mov    $0x58,%esi
   433f0:	bf 6c 57 04 00       	mov    $0x4576c,%edi
   433f5:	e8 69 f1 ff ff       	call   42563 <assert_fail>
   433fa:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   433fe:	48 c1 e8 0c          	shr    $0xc,%rax
   43402:	48 98                	cltq   
   43404:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   4340b:	00 
   4340c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43410:	48 c1 e8 0c          	shr    $0xc,%rax
   43414:	48 98                	cltq   
   43416:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   4341d:	00 
   4341e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43422:	48 c1 e8 0c          	shr    $0xc,%rax
   43426:	48 98                	cltq   
   43428:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   4342f:	00 
   43430:	3c 01                	cmp    $0x1,%al
   43432:	74 14                	je     43448 <process_free+0x2bb>
   43434:	ba 50 58 04 00       	mov    $0x45850,%edx
   43439:	be 5b 00 00 00       	mov    $0x5b,%esi
   4343e:	bf 6c 57 04 00       	mov    $0x4576c,%edi
   43443:	e8 1b f1 ff ff       	call   42563 <assert_fail>
   43448:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4344c:	48 c1 e8 0c          	shr    $0xc,%rax
   43450:	48 98                	cltq   
   43452:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43459:	00 
   4345a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4345e:	48 c1 e8 0c          	shr    $0xc,%rax
   43462:	48 98                	cltq   
   43464:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   4346b:	00 
   4346c:	90                   	nop
   4346d:	c9                   	leave  
   4346e:	c3                   	ret    

000000000004346f <process_config_tables>:
   4346f:	55                   	push   %rbp
   43470:	48 89 e5             	mov    %rsp,%rbp
   43473:	48 83 ec 40          	sub    $0x40,%rsp
   43477:	89 7d cc             	mov    %edi,-0x34(%rbp)
   4347a:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4347d:	89 c7                	mov    %eax,%edi
   4347f:	e8 f0 fb ff ff       	call   43074 <palloc>
   43484:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43488:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4348b:	89 c7                	mov    %eax,%edi
   4348d:	e8 e2 fb ff ff       	call   43074 <palloc>
   43492:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43496:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43499:	89 c7                	mov    %eax,%edi
   4349b:	e8 d4 fb ff ff       	call   43074 <palloc>
   434a0:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   434a4:	8b 45 cc             	mov    -0x34(%rbp),%eax
   434a7:	89 c7                	mov    %eax,%edi
   434a9:	e8 c6 fb ff ff       	call   43074 <palloc>
   434ae:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   434b2:	8b 45 cc             	mov    -0x34(%rbp),%eax
   434b5:	89 c7                	mov    %eax,%edi
   434b7:	e8 b8 fb ff ff       	call   43074 <palloc>
   434bc:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   434c0:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   434c5:	74 20                	je     434e7 <process_config_tables+0x78>
   434c7:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   434cc:	74 19                	je     434e7 <process_config_tables+0x78>
   434ce:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   434d3:	74 12                	je     434e7 <process_config_tables+0x78>
   434d5:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   434da:	74 0b                	je     434e7 <process_config_tables+0x78>
   434dc:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   434e1:	0f 85 e1 00 00 00    	jne    435c8 <process_config_tables+0x159>
   434e7:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   434ec:	74 24                	je     43512 <process_config_tables+0xa3>
   434ee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   434f2:	48 c1 e8 0c          	shr    $0xc,%rax
   434f6:	48 98                	cltq   
   434f8:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   434ff:	00 
   43500:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43504:	48 c1 e8 0c          	shr    $0xc,%rax
   43508:	48 98                	cltq   
   4350a:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43511:	00 
   43512:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   43517:	74 24                	je     4353d <process_config_tables+0xce>
   43519:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4351d:	48 c1 e8 0c          	shr    $0xc,%rax
   43521:	48 98                	cltq   
   43523:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   4352a:	00 
   4352b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4352f:	48 c1 e8 0c          	shr    $0xc,%rax
   43533:	48 98                	cltq   
   43535:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   4353c:	00 
   4353d:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   43542:	74 24                	je     43568 <process_config_tables+0xf9>
   43544:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43548:	48 c1 e8 0c          	shr    $0xc,%rax
   4354c:	48 98                	cltq   
   4354e:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43555:	00 
   43556:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4355a:	48 c1 e8 0c          	shr    $0xc,%rax
   4355e:	48 98                	cltq   
   43560:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43567:	00 
   43568:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   4356d:	74 24                	je     43593 <process_config_tables+0x124>
   4356f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43573:	48 c1 e8 0c          	shr    $0xc,%rax
   43577:	48 98                	cltq   
   43579:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43580:	00 
   43581:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43585:	48 c1 e8 0c          	shr    $0xc,%rax
   43589:	48 98                	cltq   
   4358b:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43592:	00 
   43593:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43598:	74 24                	je     435be <process_config_tables+0x14f>
   4359a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4359e:	48 c1 e8 0c          	shr    $0xc,%rax
   435a2:	48 98                	cltq   
   435a4:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   435ab:	00 
   435ac:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   435b0:	48 c1 e8 0c          	shr    $0xc,%rax
   435b4:	48 98                	cltq   
   435b6:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   435bd:	00 
   435be:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   435c3:	e9 f3 01 00 00       	jmp    437bb <process_config_tables+0x34c>
   435c8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   435cc:	ba 00 10 00 00       	mov    $0x1000,%edx
   435d1:	be 00 00 00 00       	mov    $0x0,%esi
   435d6:	48 89 c7             	mov    %rax,%rdi
   435d9:	e8 c8 06 00 00       	call   43ca6 <memset>
   435de:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435e2:	ba 00 10 00 00       	mov    $0x1000,%edx
   435e7:	be 00 00 00 00       	mov    $0x0,%esi
   435ec:	48 89 c7             	mov    %rax,%rdi
   435ef:	e8 b2 06 00 00       	call   43ca6 <memset>
   435f4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   435f8:	ba 00 10 00 00       	mov    $0x1000,%edx
   435fd:	be 00 00 00 00       	mov    $0x0,%esi
   43602:	48 89 c7             	mov    %rax,%rdi
   43605:	e8 9c 06 00 00       	call   43ca6 <memset>
   4360a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4360e:	ba 00 10 00 00       	mov    $0x1000,%edx
   43613:	be 00 00 00 00       	mov    $0x0,%esi
   43618:	48 89 c7             	mov    %rax,%rdi
   4361b:	e8 86 06 00 00       	call   43ca6 <memset>
   43620:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43624:	ba 00 10 00 00       	mov    $0x1000,%edx
   43629:	be 00 00 00 00       	mov    $0x0,%esi
   4362e:	48 89 c7             	mov    %rax,%rdi
   43631:	e8 70 06 00 00       	call   43ca6 <memset>
   43636:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4363a:	48 83 c8 07          	or     $0x7,%rax
   4363e:	48 89 c2             	mov    %rax,%rdx
   43641:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43645:	48 89 10             	mov    %rdx,(%rax)
   43648:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4364c:	48 83 c8 07          	or     $0x7,%rax
   43650:	48 89 c2             	mov    %rax,%rdx
   43653:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43657:	48 89 10             	mov    %rdx,(%rax)
   4365a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4365e:	48 83 c8 07          	or     $0x7,%rax
   43662:	48 89 c2             	mov    %rax,%rdx
   43665:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43669:	48 89 10             	mov    %rdx,(%rax)
   4366c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43670:	48 83 c8 07          	or     $0x7,%rax
   43674:	48 89 c2             	mov    %rax,%rdx
   43677:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4367b:	48 89 50 08          	mov    %rdx,0x8(%rax)
   4367f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43683:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43689:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   4368f:	b9 00 00 10 00       	mov    $0x100000,%ecx
   43694:	ba 00 00 00 00       	mov    $0x0,%edx
   43699:	be 00 00 00 00       	mov    $0x0,%esi
   4369e:	48 89 c7             	mov    %rax,%rdi
   436a1:	e8 bc f1 ff ff       	call   42862 <virtual_memory_map>
   436a6:	85 c0                	test   %eax,%eax
   436a8:	75 2f                	jne    436d9 <process_config_tables+0x26a>
   436aa:	ba 00 80 0b 00       	mov    $0xb8000,%edx
   436af:	be 00 80 0b 00       	mov    $0xb8000,%esi
   436b4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   436b8:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   436be:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   436c4:	b9 00 10 00 00       	mov    $0x1000,%ecx
   436c9:	48 89 c7             	mov    %rax,%rdi
   436cc:	e8 91 f1 ff ff       	call   42862 <virtual_memory_map>
   436d1:	85 c0                	test   %eax,%eax
   436d3:	0f 84 bb 00 00 00    	je     43794 <process_config_tables+0x325>
   436d9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   436dd:	48 c1 e8 0c          	shr    $0xc,%rax
   436e1:	48 98                	cltq   
   436e3:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   436ea:	00 
   436eb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   436ef:	48 c1 e8 0c          	shr    $0xc,%rax
   436f3:	48 98                	cltq   
   436f5:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   436fc:	00 
   436fd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43701:	48 c1 e8 0c          	shr    $0xc,%rax
   43705:	48 98                	cltq   
   43707:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   4370e:	00 
   4370f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43713:	48 c1 e8 0c          	shr    $0xc,%rax
   43717:	48 98                	cltq   
   43719:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43720:	00 
   43721:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43725:	48 c1 e8 0c          	shr    $0xc,%rax
   43729:	48 98                	cltq   
   4372b:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43732:	00 
   43733:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43737:	48 c1 e8 0c          	shr    $0xc,%rax
   4373b:	48 98                	cltq   
   4373d:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43744:	00 
   43745:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43749:	48 c1 e8 0c          	shr    $0xc,%rax
   4374d:	48 98                	cltq   
   4374f:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43756:	00 
   43757:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4375b:	48 c1 e8 0c          	shr    $0xc,%rax
   4375f:	48 98                	cltq   
   43761:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43768:	00 
   43769:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4376d:	48 c1 e8 0c          	shr    $0xc,%rax
   43771:	48 98                	cltq   
   43773:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   4377a:	00 
   4377b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4377f:	48 c1 e8 0c          	shr    $0xc,%rax
   43783:	48 98                	cltq   
   43785:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   4378c:	00 
   4378d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43792:	eb 27                	jmp    437bb <process_config_tables+0x34c>
   43794:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43797:	48 63 d0             	movslq %eax,%rdx
   4379a:	48 89 d0             	mov    %rdx,%rax
   4379d:	48 c1 e0 04          	shl    $0x4,%rax
   437a1:	48 29 d0             	sub    %rdx,%rax
   437a4:	48 c1 e0 04          	shl    $0x4,%rax
   437a8:	48 8d 90 e0 e0 04 00 	lea    0x4e0e0(%rax),%rdx
   437af:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   437b3:	48 89 02             	mov    %rax,(%rdx)
   437b6:	b8 00 00 00 00       	mov    $0x0,%eax
   437bb:	c9                   	leave  
   437bc:	c3                   	ret    

00000000000437bd <process_load>:
   437bd:	55                   	push   %rbp
   437be:	48 89 e5             	mov    %rsp,%rbp
   437c1:	48 83 ec 20          	sub    $0x20,%rsp
   437c5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   437c9:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   437cc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   437d0:	48 89 05 29 38 01 00 	mov    %rax,0x13829(%rip)        # 57000 <palloc_target_proc>
   437d7:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
   437da:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   437de:	ba 57 31 04 00       	mov    $0x43157,%edx
   437e3:	89 ce                	mov    %ecx,%esi
   437e5:	48 89 c7             	mov    %rax,%rdi
   437e8:	e8 2f f5 ff ff       	call   42d1c <program_load>
   437ed:	89 45 fc             	mov    %eax,-0x4(%rbp)
   437f0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   437f3:	c9                   	leave  
   437f4:	c3                   	ret    

00000000000437f5 <process_setup_stack>:
   437f5:	55                   	push   %rbp
   437f6:	48 89 e5             	mov    %rsp,%rbp
   437f9:	48 83 ec 20          	sub    $0x20,%rsp
   437fd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43801:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43805:	8b 00                	mov    (%rax),%eax
   43807:	89 c7                	mov    %eax,%edi
   43809:	e8 66 f8 ff ff       	call   43074 <palloc>
   4380e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43812:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43816:	48 c7 80 c8 00 00 00 	movq   $0x300000,0xc8(%rax)
   4381d:	00 00 30 00 
   43821:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43825:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   4382c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43830:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43836:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4383c:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43841:	be 00 f0 2f 00       	mov    $0x2ff000,%esi
   43846:	48 89 c7             	mov    %rax,%rdi
   43849:	e8 14 f0 ff ff       	call   42862 <virtual_memory_map>
   4384e:	90                   	nop
   4384f:	c9                   	leave  
   43850:	c3                   	ret    

0000000000043851 <find_free_pid>:
   43851:	55                   	push   %rbp
   43852:	48 89 e5             	mov    %rsp,%rbp
   43855:	48 83 ec 10          	sub    $0x10,%rsp
   43859:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   43860:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
   43867:	eb 24                	jmp    4388d <find_free_pid+0x3c>
   43869:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4386c:	48 63 d0             	movslq %eax,%rdx
   4386f:	48 89 d0             	mov    %rdx,%rax
   43872:	48 c1 e0 04          	shl    $0x4,%rax
   43876:	48 29 d0             	sub    %rdx,%rax
   43879:	48 c1 e0 04          	shl    $0x4,%rax
   4387d:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   43883:	8b 00                	mov    (%rax),%eax
   43885:	85 c0                	test   %eax,%eax
   43887:	74 0c                	je     43895 <find_free_pid+0x44>
   43889:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4388d:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   43891:	7e d6                	jle    43869 <find_free_pid+0x18>
   43893:	eb 01                	jmp    43896 <find_free_pid+0x45>
   43895:	90                   	nop
   43896:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   4389a:	74 05                	je     438a1 <find_free_pid+0x50>
   4389c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4389f:	eb 05                	jmp    438a6 <find_free_pid+0x55>
   438a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   438a6:	c9                   	leave  
   438a7:	c3                   	ret    

00000000000438a8 <process_fork>:
   438a8:	55                   	push   %rbp
   438a9:	48 89 e5             	mov    %rsp,%rbp
   438ac:	48 83 ec 40          	sub    $0x40,%rsp
   438b0:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   438b4:	b8 00 00 00 00       	mov    $0x0,%eax
   438b9:	e8 93 ff ff ff       	call   43851 <find_free_pid>
   438be:	89 45 f4             	mov    %eax,-0xc(%rbp)
   438c1:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%rbp)
   438c5:	75 0a                	jne    438d1 <process_fork+0x29>
   438c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   438cc:	e9 67 02 00 00       	jmp    43b38 <process_fork+0x290>
   438d1:	8b 45 f4             	mov    -0xc(%rbp),%eax
   438d4:	48 63 d0             	movslq %eax,%rdx
   438d7:	48 89 d0             	mov    %rdx,%rax
   438da:	48 c1 e0 04          	shl    $0x4,%rax
   438de:	48 29 d0             	sub    %rdx,%rax
   438e1:	48 c1 e0 04          	shl    $0x4,%rax
   438e5:	48 05 00 e0 04 00    	add    $0x4e000,%rax
   438eb:	be 00 00 00 00       	mov    $0x0,%esi
   438f0:	48 89 c7             	mov    %rax,%rdi
   438f3:	e8 9d e4 ff ff       	call   41d95 <process_init>
   438f8:	8b 45 f4             	mov    -0xc(%rbp),%eax
   438fb:	89 c7                	mov    %eax,%edi
   438fd:	e8 6d fb ff ff       	call   4346f <process_config_tables>
   43902:	83 f8 ff             	cmp    $0xffffffff,%eax
   43905:	75 0a                	jne    43911 <process_fork+0x69>
   43907:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4390c:	e9 27 02 00 00       	jmp    43b38 <process_fork+0x290>
   43911:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   43918:	00 
   43919:	e9 79 01 00 00       	jmp    43a97 <process_fork+0x1ef>
   4391e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43922:	8b 00                	mov    (%rax),%eax
   43924:	48 63 d0             	movslq %eax,%rdx
   43927:	48 89 d0             	mov    %rdx,%rax
   4392a:	48 c1 e0 04          	shl    $0x4,%rax
   4392e:	48 29 d0             	sub    %rdx,%rax
   43931:	48 c1 e0 04          	shl    $0x4,%rax
   43935:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   4393b:	48 8b 08             	mov    (%rax),%rcx
   4393e:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   43942:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43946:	48 89 ce             	mov    %rcx,%rsi
   43949:	48 89 c7             	mov    %rax,%rdi
   4394c:	e8 d4 f2 ff ff       	call   42c25 <virtual_memory_lookup>
   43951:	8b 45 e0             	mov    -0x20(%rbp),%eax
   43954:	48 98                	cltq   
   43956:	83 e0 07             	and    $0x7,%eax
   43959:	48 83 f8 07          	cmp    $0x7,%rax
   4395d:	0f 85 a1 00 00 00    	jne    43a04 <process_fork+0x15c>
   43963:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43966:	89 c7                	mov    %eax,%edi
   43968:	e8 07 f7 ff ff       	call   43074 <palloc>
   4396d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   43971:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   43976:	75 14                	jne    4398c <process_fork+0xe4>
   43978:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4397b:	89 c7                	mov    %eax,%edi
   4397d:	e8 0b f8 ff ff       	call   4318d <process_free>
   43982:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43987:	e9 ac 01 00 00       	jmp    43b38 <process_fork+0x290>
   4398c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43990:	48 89 c1             	mov    %rax,%rcx
   43993:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43997:	ba 00 10 00 00       	mov    $0x1000,%edx
   4399c:	48 89 ce             	mov    %rcx,%rsi
   4399f:	48 89 c7             	mov    %rax,%rdi
   439a2:	e8 01 02 00 00       	call   43ba8 <memcpy>
   439a7:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
   439ab:	8b 45 f4             	mov    -0xc(%rbp),%eax
   439ae:	48 63 d0             	movslq %eax,%rdx
   439b1:	48 89 d0             	mov    %rdx,%rax
   439b4:	48 c1 e0 04          	shl    $0x4,%rax
   439b8:	48 29 d0             	sub    %rdx,%rax
   439bb:	48 c1 e0 04          	shl    $0x4,%rax
   439bf:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   439c5:	48 8b 00             	mov    (%rax),%rax
   439c8:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   439cc:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   439d2:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   439d8:	b9 00 10 00 00       	mov    $0x1000,%ecx
   439dd:	48 89 fa             	mov    %rdi,%rdx
   439e0:	48 89 c7             	mov    %rax,%rdi
   439e3:	e8 7a ee ff ff       	call   42862 <virtual_memory_map>
   439e8:	85 c0                	test   %eax,%eax
   439ea:	0f 84 9f 00 00 00    	je     43a8f <process_fork+0x1e7>
   439f0:	8b 45 f4             	mov    -0xc(%rbp),%eax
   439f3:	89 c7                	mov    %eax,%edi
   439f5:	e8 93 f7 ff ff       	call   4318d <process_free>
   439fa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   439ff:	e9 34 01 00 00       	jmp    43b38 <process_fork+0x290>
   43a04:	8b 45 e0             	mov    -0x20(%rbp),%eax
   43a07:	48 98                	cltq   
   43a09:	83 e0 05             	and    $0x5,%eax
   43a0c:	48 83 f8 05          	cmp    $0x5,%rax
   43a10:	75 7d                	jne    43a8f <process_fork+0x1e7>
   43a12:	48 8b 7d d8          	mov    -0x28(%rbp),%rdi
   43a16:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43a19:	48 63 d0             	movslq %eax,%rdx
   43a1c:	48 89 d0             	mov    %rdx,%rax
   43a1f:	48 c1 e0 04          	shl    $0x4,%rax
   43a23:	48 29 d0             	sub    %rdx,%rax
   43a26:	48 c1 e0 04          	shl    $0x4,%rax
   43a2a:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   43a30:	48 8b 00             	mov    (%rax),%rax
   43a33:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   43a37:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43a3d:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   43a43:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43a48:	48 89 fa             	mov    %rdi,%rdx
   43a4b:	48 89 c7             	mov    %rax,%rdi
   43a4e:	e8 0f ee ff ff       	call   42862 <virtual_memory_map>
   43a53:	85 c0                	test   %eax,%eax
   43a55:	74 14                	je     43a6b <process_fork+0x1c3>
   43a57:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43a5a:	89 c7                	mov    %eax,%edi
   43a5c:	e8 2c f7 ff ff       	call   4318d <process_free>
   43a61:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43a66:	e9 cd 00 00 00       	jmp    43b38 <process_fork+0x290>
   43a6b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43a6f:	48 c1 e8 0c          	shr    $0xc,%rax
   43a73:	89 c2                	mov    %eax,%edx
   43a75:	48 63 c2             	movslq %edx,%rax
   43a78:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   43a7f:	00 
   43a80:	83 c0 01             	add    $0x1,%eax
   43a83:	89 c1                	mov    %eax,%ecx
   43a85:	48 63 c2             	movslq %edx,%rax
   43a88:	88 8c 00 21 ef 04 00 	mov    %cl,0x4ef21(%rax,%rax,1)
   43a8f:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43a96:	00 
   43a97:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   43a9e:	00 
   43a9f:	0f 86 79 fe ff ff    	jbe    4391e <process_fork+0x76>
   43aa5:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43aa9:	8b 08                	mov    (%rax),%ecx
   43aab:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43aae:	48 63 d0             	movslq %eax,%rdx
   43ab1:	48 89 d0             	mov    %rdx,%rax
   43ab4:	48 c1 e0 04          	shl    $0x4,%rax
   43ab8:	48 29 d0             	sub    %rdx,%rax
   43abb:	48 c1 e0 04          	shl    $0x4,%rax
   43abf:	48 8d b0 10 e0 04 00 	lea    0x4e010(%rax),%rsi
   43ac6:	48 63 d1             	movslq %ecx,%rdx
   43ac9:	48 89 d0             	mov    %rdx,%rax
   43acc:	48 c1 e0 04          	shl    $0x4,%rax
   43ad0:	48 29 d0             	sub    %rdx,%rax
   43ad3:	48 c1 e0 04          	shl    $0x4,%rax
   43ad7:	48 8d 90 10 e0 04 00 	lea    0x4e010(%rax),%rdx
   43ade:	48 8d 46 08          	lea    0x8(%rsi),%rax
   43ae2:	48 83 c2 08          	add    $0x8,%rdx
   43ae6:	b9 18 00 00 00       	mov    $0x18,%ecx
   43aeb:	48 89 c7             	mov    %rax,%rdi
   43aee:	48 89 d6             	mov    %rdx,%rsi
   43af1:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
   43af4:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43af7:	48 63 d0             	movslq %eax,%rdx
   43afa:	48 89 d0             	mov    %rdx,%rax
   43afd:	48 c1 e0 04          	shl    $0x4,%rax
   43b01:	48 29 d0             	sub    %rdx,%rax
   43b04:	48 c1 e0 04          	shl    $0x4,%rax
   43b08:	48 05 18 e0 04 00    	add    $0x4e018,%rax
   43b0e:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
   43b15:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43b18:	48 63 d0             	movslq %eax,%rdx
   43b1b:	48 89 d0             	mov    %rdx,%rax
   43b1e:	48 c1 e0 04          	shl    $0x4,%rax
   43b22:	48 29 d0             	sub    %rdx,%rax
   43b25:	48 c1 e0 04          	shl    $0x4,%rax
   43b29:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   43b2f:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
   43b35:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43b38:	c9                   	leave  
   43b39:	c3                   	ret    

0000000000043b3a <process_page_alloc>:
   43b3a:	55                   	push   %rbp
   43b3b:	48 89 e5             	mov    %rsp,%rbp
   43b3e:	48 83 ec 20          	sub    $0x20,%rsp
   43b42:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43b46:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43b4a:	48 81 7d e0 ff ff 0f 	cmpq   $0xfffff,-0x20(%rbp)
   43b51:	00 
   43b52:	77 07                	ja     43b5b <process_page_alloc+0x21>
   43b54:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43b59:	eb 4b                	jmp    43ba6 <process_page_alloc+0x6c>
   43b5b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43b5f:	8b 00                	mov    (%rax),%eax
   43b61:	89 c7                	mov    %eax,%edi
   43b63:	e8 0c f5 ff ff       	call   43074 <palloc>
   43b68:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43b6c:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   43b71:	74 2e                	je     43ba1 <process_page_alloc+0x67>
   43b73:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43b77:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43b7b:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   43b82:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
   43b86:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43b8c:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43b92:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43b97:	48 89 c7             	mov    %rax,%rdi
   43b9a:	e8 c3 ec ff ff       	call   42862 <virtual_memory_map>
   43b9f:	eb 05                	jmp    43ba6 <process_page_alloc+0x6c>
   43ba1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43ba6:	c9                   	leave  
   43ba7:	c3                   	ret    

0000000000043ba8 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   43ba8:	55                   	push   %rbp
   43ba9:	48 89 e5             	mov    %rsp,%rbp
   43bac:	48 83 ec 28          	sub    $0x28,%rsp
   43bb0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43bb4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43bb8:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43bbc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43bc0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43bc4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43bc8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43bcc:	eb 1c                	jmp    43bea <memcpy+0x42>
        *d = *s;
   43bce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43bd2:	0f b6 10             	movzbl (%rax),%edx
   43bd5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43bd9:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43bdb:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43be0:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43be5:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   43bea:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43bef:	75 dd                	jne    43bce <memcpy+0x26>
    }
    return dst;
   43bf1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43bf5:	c9                   	leave  
   43bf6:	c3                   	ret    

0000000000043bf7 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   43bf7:	55                   	push   %rbp
   43bf8:	48 89 e5             	mov    %rsp,%rbp
   43bfb:	48 83 ec 28          	sub    $0x28,%rsp
   43bff:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43c03:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43c07:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43c0b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43c0f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   43c13:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43c17:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   43c1b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c1f:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   43c23:	73 6a                	jae    43c8f <memmove+0x98>
   43c25:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43c29:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43c2d:	48 01 d0             	add    %rdx,%rax
   43c30:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   43c34:	73 59                	jae    43c8f <memmove+0x98>
        s += n, d += n;
   43c36:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43c3a:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   43c3e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43c42:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   43c46:	eb 17                	jmp    43c5f <memmove+0x68>
            *--d = *--s;
   43c48:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   43c4d:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   43c52:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c56:	0f b6 10             	movzbl (%rax),%edx
   43c59:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43c5d:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43c5f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43c63:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43c67:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43c6b:	48 85 c0             	test   %rax,%rax
   43c6e:	75 d8                	jne    43c48 <memmove+0x51>
    if (s < d && s + n > d) {
   43c70:	eb 2e                	jmp    43ca0 <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   43c72:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43c76:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43c7a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43c7e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43c82:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43c86:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   43c8a:	0f b6 12             	movzbl (%rdx),%edx
   43c8d:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43c8f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43c93:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43c97:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43c9b:	48 85 c0             	test   %rax,%rax
   43c9e:	75 d2                	jne    43c72 <memmove+0x7b>
        }
    }
    return dst;
   43ca0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43ca4:	c9                   	leave  
   43ca5:	c3                   	ret    

0000000000043ca6 <memset>:

void* memset(void* v, int c, size_t n) {
   43ca6:	55                   	push   %rbp
   43ca7:	48 89 e5             	mov    %rsp,%rbp
   43caa:	48 83 ec 28          	sub    $0x28,%rsp
   43cae:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43cb2:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   43cb5:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43cb9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43cbd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43cc1:	eb 15                	jmp    43cd8 <memset+0x32>
        *p = c;
   43cc3:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43cc6:	89 c2                	mov    %eax,%edx
   43cc8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43ccc:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43cce:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43cd3:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43cd8:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43cdd:	75 e4                	jne    43cc3 <memset+0x1d>
    }
    return v;
   43cdf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43ce3:	c9                   	leave  
   43ce4:	c3                   	ret    

0000000000043ce5 <strlen>:

size_t strlen(const char* s) {
   43ce5:	55                   	push   %rbp
   43ce6:	48 89 e5             	mov    %rsp,%rbp
   43ce9:	48 83 ec 18          	sub    $0x18,%rsp
   43ced:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   43cf1:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43cf8:	00 
   43cf9:	eb 0a                	jmp    43d05 <strlen+0x20>
        ++n;
   43cfb:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   43d00:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43d05:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43d09:	0f b6 00             	movzbl (%rax),%eax
   43d0c:	84 c0                	test   %al,%al
   43d0e:	75 eb                	jne    43cfb <strlen+0x16>
    }
    return n;
   43d10:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43d14:	c9                   	leave  
   43d15:	c3                   	ret    

0000000000043d16 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   43d16:	55                   	push   %rbp
   43d17:	48 89 e5             	mov    %rsp,%rbp
   43d1a:	48 83 ec 20          	sub    $0x20,%rsp
   43d1e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43d22:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43d26:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43d2d:	00 
   43d2e:	eb 0a                	jmp    43d3a <strnlen+0x24>
        ++n;
   43d30:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43d35:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43d3a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43d3e:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   43d42:	74 0b                	je     43d4f <strnlen+0x39>
   43d44:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43d48:	0f b6 00             	movzbl (%rax),%eax
   43d4b:	84 c0                	test   %al,%al
   43d4d:	75 e1                	jne    43d30 <strnlen+0x1a>
    }
    return n;
   43d4f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43d53:	c9                   	leave  
   43d54:	c3                   	ret    

0000000000043d55 <strcpy>:

char* strcpy(char* dst, const char* src) {
   43d55:	55                   	push   %rbp
   43d56:	48 89 e5             	mov    %rsp,%rbp
   43d59:	48 83 ec 20          	sub    $0x20,%rsp
   43d5d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43d61:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   43d65:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43d69:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   43d6d:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43d71:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43d75:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43d79:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43d7d:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43d81:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   43d85:	0f b6 12             	movzbl (%rdx),%edx
   43d88:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   43d8a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43d8e:	48 83 e8 01          	sub    $0x1,%rax
   43d92:	0f b6 00             	movzbl (%rax),%eax
   43d95:	84 c0                	test   %al,%al
   43d97:	75 d4                	jne    43d6d <strcpy+0x18>
    return dst;
   43d99:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43d9d:	c9                   	leave  
   43d9e:	c3                   	ret    

0000000000043d9f <strcmp>:

int strcmp(const char* a, const char* b) {
   43d9f:	55                   	push   %rbp
   43da0:	48 89 e5             	mov    %rsp,%rbp
   43da3:	48 83 ec 10          	sub    $0x10,%rsp
   43da7:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43dab:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43daf:	eb 0a                	jmp    43dbb <strcmp+0x1c>
        ++a, ++b;
   43db1:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43db6:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43dbb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43dbf:	0f b6 00             	movzbl (%rax),%eax
   43dc2:	84 c0                	test   %al,%al
   43dc4:	74 1d                	je     43de3 <strcmp+0x44>
   43dc6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43dca:	0f b6 00             	movzbl (%rax),%eax
   43dcd:	84 c0                	test   %al,%al
   43dcf:	74 12                	je     43de3 <strcmp+0x44>
   43dd1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43dd5:	0f b6 10             	movzbl (%rax),%edx
   43dd8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43ddc:	0f b6 00             	movzbl (%rax),%eax
   43ddf:	38 c2                	cmp    %al,%dl
   43de1:	74 ce                	je     43db1 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   43de3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43de7:	0f b6 00             	movzbl (%rax),%eax
   43dea:	89 c2                	mov    %eax,%edx
   43dec:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43df0:	0f b6 00             	movzbl (%rax),%eax
   43df3:	38 d0                	cmp    %dl,%al
   43df5:	0f 92 c0             	setb   %al
   43df8:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   43dfb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43dff:	0f b6 00             	movzbl (%rax),%eax
   43e02:	89 c1                	mov    %eax,%ecx
   43e04:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43e08:	0f b6 00             	movzbl (%rax),%eax
   43e0b:	38 c1                	cmp    %al,%cl
   43e0d:	0f 92 c0             	setb   %al
   43e10:	0f b6 c0             	movzbl %al,%eax
   43e13:	29 c2                	sub    %eax,%edx
   43e15:	89 d0                	mov    %edx,%eax
}
   43e17:	c9                   	leave  
   43e18:	c3                   	ret    

0000000000043e19 <strchr>:

char* strchr(const char* s, int c) {
   43e19:	55                   	push   %rbp
   43e1a:	48 89 e5             	mov    %rsp,%rbp
   43e1d:	48 83 ec 10          	sub    $0x10,%rsp
   43e21:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43e25:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   43e28:	eb 05                	jmp    43e2f <strchr+0x16>
        ++s;
   43e2a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   43e2f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e33:	0f b6 00             	movzbl (%rax),%eax
   43e36:	84 c0                	test   %al,%al
   43e38:	74 0e                	je     43e48 <strchr+0x2f>
   43e3a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e3e:	0f b6 00             	movzbl (%rax),%eax
   43e41:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43e44:	38 d0                	cmp    %dl,%al
   43e46:	75 e2                	jne    43e2a <strchr+0x11>
    }
    if (*s == (char) c) {
   43e48:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e4c:	0f b6 00             	movzbl (%rax),%eax
   43e4f:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43e52:	38 d0                	cmp    %dl,%al
   43e54:	75 06                	jne    43e5c <strchr+0x43>
        return (char*) s;
   43e56:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e5a:	eb 05                	jmp    43e61 <strchr+0x48>
    } else {
        return NULL;
   43e5c:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   43e61:	c9                   	leave  
   43e62:	c3                   	ret    

0000000000043e63 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   43e63:	55                   	push   %rbp
   43e64:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   43e67:	8b 05 9b 31 01 00    	mov    0x1319b(%rip),%eax        # 57008 <rand_seed_set>
   43e6d:	85 c0                	test   %eax,%eax
   43e6f:	75 0a                	jne    43e7b <rand+0x18>
        srand(819234718U);
   43e71:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   43e76:	e8 24 00 00 00       	call   43e9f <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   43e7b:	8b 05 8b 31 01 00    	mov    0x1318b(%rip),%eax        # 5700c <rand_seed>
   43e81:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   43e87:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   43e8c:	89 05 7a 31 01 00    	mov    %eax,0x1317a(%rip)        # 5700c <rand_seed>
    return rand_seed & RAND_MAX;
   43e92:	8b 05 74 31 01 00    	mov    0x13174(%rip),%eax        # 5700c <rand_seed>
   43e98:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   43e9d:	5d                   	pop    %rbp
   43e9e:	c3                   	ret    

0000000000043e9f <srand>:

void srand(unsigned seed) {
   43e9f:	55                   	push   %rbp
   43ea0:	48 89 e5             	mov    %rsp,%rbp
   43ea3:	48 83 ec 08          	sub    $0x8,%rsp
   43ea7:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   43eaa:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43ead:	89 05 59 31 01 00    	mov    %eax,0x13159(%rip)        # 5700c <rand_seed>
    rand_seed_set = 1;
   43eb3:	c7 05 4b 31 01 00 01 	movl   $0x1,0x1314b(%rip)        # 57008 <rand_seed_set>
   43eba:	00 00 00 
}
   43ebd:	90                   	nop
   43ebe:	c9                   	leave  
   43ebf:	c3                   	ret    

0000000000043ec0 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   43ec0:	55                   	push   %rbp
   43ec1:	48 89 e5             	mov    %rsp,%rbp
   43ec4:	48 83 ec 28          	sub    $0x28,%rsp
   43ec8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43ecc:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43ed0:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   43ed3:	48 c7 45 f8 60 5a 04 	movq   $0x45a60,-0x8(%rbp)
   43eda:	00 
    if (base < 0) {
   43edb:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   43edf:	79 0b                	jns    43eec <fill_numbuf+0x2c>
        digits = lower_digits;
   43ee1:	48 c7 45 f8 80 5a 04 	movq   $0x45a80,-0x8(%rbp)
   43ee8:	00 
        base = -base;
   43ee9:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   43eec:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43ef1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43ef5:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   43ef8:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43efb:	48 63 c8             	movslq %eax,%rcx
   43efe:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43f02:	ba 00 00 00 00       	mov    $0x0,%edx
   43f07:	48 f7 f1             	div    %rcx
   43f0a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43f0e:	48 01 d0             	add    %rdx,%rax
   43f11:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43f16:	0f b6 10             	movzbl (%rax),%edx
   43f19:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43f1d:	88 10                	mov    %dl,(%rax)
        val /= base;
   43f1f:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43f22:	48 63 f0             	movslq %eax,%rsi
   43f25:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43f29:	ba 00 00 00 00       	mov    $0x0,%edx
   43f2e:	48 f7 f6             	div    %rsi
   43f31:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   43f35:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43f3a:	75 bc                	jne    43ef8 <fill_numbuf+0x38>
    return numbuf_end;
   43f3c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43f40:	c9                   	leave  
   43f41:	c3                   	ret    

0000000000043f42 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   43f42:	55                   	push   %rbp
   43f43:	48 89 e5             	mov    %rsp,%rbp
   43f46:	53                   	push   %rbx
   43f47:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   43f4e:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   43f55:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   43f5b:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43f62:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   43f69:	e9 8a 09 00 00       	jmp    448f8 <printer_vprintf+0x9b6>
        if (*format != '%') {
   43f6e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f75:	0f b6 00             	movzbl (%rax),%eax
   43f78:	3c 25                	cmp    $0x25,%al
   43f7a:	74 31                	je     43fad <printer_vprintf+0x6b>
            p->putc(p, *format, color);
   43f7c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43f83:	4c 8b 00             	mov    (%rax),%r8
   43f86:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f8d:	0f b6 00             	movzbl (%rax),%eax
   43f90:	0f b6 c8             	movzbl %al,%ecx
   43f93:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43f99:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43fa0:	89 ce                	mov    %ecx,%esi
   43fa2:	48 89 c7             	mov    %rax,%rdi
   43fa5:	41 ff d0             	call   *%r8
            continue;
   43fa8:	e9 43 09 00 00       	jmp    448f0 <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
   43fad:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   43fb4:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43fbb:	01 
   43fbc:	eb 44                	jmp    44002 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
   43fbe:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43fc5:	0f b6 00             	movzbl (%rax),%eax
   43fc8:	0f be c0             	movsbl %al,%eax
   43fcb:	89 c6                	mov    %eax,%esi
   43fcd:	bf 80 58 04 00       	mov    $0x45880,%edi
   43fd2:	e8 42 fe ff ff       	call   43e19 <strchr>
   43fd7:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   43fdb:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   43fe0:	74 30                	je     44012 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
   43fe2:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   43fe6:	48 2d 80 58 04 00    	sub    $0x45880,%rax
   43fec:	ba 01 00 00 00       	mov    $0x1,%edx
   43ff1:	89 c1                	mov    %eax,%ecx
   43ff3:	d3 e2                	shl    %cl,%edx
   43ff5:	89 d0                	mov    %edx,%eax
   43ff7:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   43ffa:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44001:	01 
   44002:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44009:	0f b6 00             	movzbl (%rax),%eax
   4400c:	84 c0                	test   %al,%al
   4400e:	75 ae                	jne    43fbe <printer_vprintf+0x7c>
   44010:	eb 01                	jmp    44013 <printer_vprintf+0xd1>
            } else {
                break;
   44012:	90                   	nop
            }
        }

        // process width
        int width = -1;
   44013:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   4401a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44021:	0f b6 00             	movzbl (%rax),%eax
   44024:	3c 30                	cmp    $0x30,%al
   44026:	7e 67                	jle    4408f <printer_vprintf+0x14d>
   44028:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4402f:	0f b6 00             	movzbl (%rax),%eax
   44032:	3c 39                	cmp    $0x39,%al
   44034:	7f 59                	jg     4408f <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   44036:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   4403d:	eb 2e                	jmp    4406d <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
   4403f:	8b 55 e8             	mov    -0x18(%rbp),%edx
   44042:	89 d0                	mov    %edx,%eax
   44044:	c1 e0 02             	shl    $0x2,%eax
   44047:	01 d0                	add    %edx,%eax
   44049:	01 c0                	add    %eax,%eax
   4404b:	89 c1                	mov    %eax,%ecx
   4404d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44054:	48 8d 50 01          	lea    0x1(%rax),%rdx
   44058:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   4405f:	0f b6 00             	movzbl (%rax),%eax
   44062:	0f be c0             	movsbl %al,%eax
   44065:	01 c8                	add    %ecx,%eax
   44067:	83 e8 30             	sub    $0x30,%eax
   4406a:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   4406d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44074:	0f b6 00             	movzbl (%rax),%eax
   44077:	3c 2f                	cmp    $0x2f,%al
   44079:	0f 8e 85 00 00 00    	jle    44104 <printer_vprintf+0x1c2>
   4407f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44086:	0f b6 00             	movzbl (%rax),%eax
   44089:	3c 39                	cmp    $0x39,%al
   4408b:	7e b2                	jle    4403f <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
   4408d:	eb 75                	jmp    44104 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
   4408f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44096:	0f b6 00             	movzbl (%rax),%eax
   44099:	3c 2a                	cmp    $0x2a,%al
   4409b:	75 68                	jne    44105 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
   4409d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   440a4:	8b 00                	mov    (%rax),%eax
   440a6:	83 f8 2f             	cmp    $0x2f,%eax
   440a9:	77 30                	ja     440db <printer_vprintf+0x199>
   440ab:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   440b2:	48 8b 50 10          	mov    0x10(%rax),%rdx
   440b6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   440bd:	8b 00                	mov    (%rax),%eax
   440bf:	89 c0                	mov    %eax,%eax
   440c1:	48 01 d0             	add    %rdx,%rax
   440c4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   440cb:	8b 12                	mov    (%rdx),%edx
   440cd:	8d 4a 08             	lea    0x8(%rdx),%ecx
   440d0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   440d7:	89 0a                	mov    %ecx,(%rdx)
   440d9:	eb 1a                	jmp    440f5 <printer_vprintf+0x1b3>
   440db:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   440e2:	48 8b 40 08          	mov    0x8(%rax),%rax
   440e6:	48 8d 48 08          	lea    0x8(%rax),%rcx
   440ea:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   440f1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   440f5:	8b 00                	mov    (%rax),%eax
   440f7:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   440fa:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44101:	01 
   44102:	eb 01                	jmp    44105 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
   44104:	90                   	nop
        }

        // process precision
        int precision = -1;
   44105:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   4410c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44113:	0f b6 00             	movzbl (%rax),%eax
   44116:	3c 2e                	cmp    $0x2e,%al
   44118:	0f 85 00 01 00 00    	jne    4421e <printer_vprintf+0x2dc>
            ++format;
   4411e:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44125:	01 
            if (*format >= '0' && *format <= '9') {
   44126:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4412d:	0f b6 00             	movzbl (%rax),%eax
   44130:	3c 2f                	cmp    $0x2f,%al
   44132:	7e 67                	jle    4419b <printer_vprintf+0x259>
   44134:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4413b:	0f b6 00             	movzbl (%rax),%eax
   4413e:	3c 39                	cmp    $0x39,%al
   44140:	7f 59                	jg     4419b <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   44142:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   44149:	eb 2e                	jmp    44179 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
   4414b:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   4414e:	89 d0                	mov    %edx,%eax
   44150:	c1 e0 02             	shl    $0x2,%eax
   44153:	01 d0                	add    %edx,%eax
   44155:	01 c0                	add    %eax,%eax
   44157:	89 c1                	mov    %eax,%ecx
   44159:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44160:	48 8d 50 01          	lea    0x1(%rax),%rdx
   44164:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   4416b:	0f b6 00             	movzbl (%rax),%eax
   4416e:	0f be c0             	movsbl %al,%eax
   44171:	01 c8                	add    %ecx,%eax
   44173:	83 e8 30             	sub    $0x30,%eax
   44176:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   44179:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44180:	0f b6 00             	movzbl (%rax),%eax
   44183:	3c 2f                	cmp    $0x2f,%al
   44185:	0f 8e 85 00 00 00    	jle    44210 <printer_vprintf+0x2ce>
   4418b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44192:	0f b6 00             	movzbl (%rax),%eax
   44195:	3c 39                	cmp    $0x39,%al
   44197:	7e b2                	jle    4414b <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
   44199:	eb 75                	jmp    44210 <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
   4419b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   441a2:	0f b6 00             	movzbl (%rax),%eax
   441a5:	3c 2a                	cmp    $0x2a,%al
   441a7:	75 68                	jne    44211 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
   441a9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   441b0:	8b 00                	mov    (%rax),%eax
   441b2:	83 f8 2f             	cmp    $0x2f,%eax
   441b5:	77 30                	ja     441e7 <printer_vprintf+0x2a5>
   441b7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   441be:	48 8b 50 10          	mov    0x10(%rax),%rdx
   441c2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   441c9:	8b 00                	mov    (%rax),%eax
   441cb:	89 c0                	mov    %eax,%eax
   441cd:	48 01 d0             	add    %rdx,%rax
   441d0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   441d7:	8b 12                	mov    (%rdx),%edx
   441d9:	8d 4a 08             	lea    0x8(%rdx),%ecx
   441dc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   441e3:	89 0a                	mov    %ecx,(%rdx)
   441e5:	eb 1a                	jmp    44201 <printer_vprintf+0x2bf>
   441e7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   441ee:	48 8b 40 08          	mov    0x8(%rax),%rax
   441f2:	48 8d 48 08          	lea    0x8(%rax),%rcx
   441f6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   441fd:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44201:	8b 00                	mov    (%rax),%eax
   44203:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   44206:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4420d:	01 
   4420e:	eb 01                	jmp    44211 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
   44210:	90                   	nop
            }
            if (precision < 0) {
   44211:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   44215:	79 07                	jns    4421e <printer_vprintf+0x2dc>
                precision = 0;
   44217:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   4421e:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   44225:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   4422c:	00 
        int length = 0;
   4422d:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   44234:	48 c7 45 c8 86 58 04 	movq   $0x45886,-0x38(%rbp)
   4423b:	00 
    again:
        switch (*format) {
   4423c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44243:	0f b6 00             	movzbl (%rax),%eax
   44246:	0f be c0             	movsbl %al,%eax
   44249:	83 e8 43             	sub    $0x43,%eax
   4424c:	83 f8 37             	cmp    $0x37,%eax
   4424f:	0f 87 9f 03 00 00    	ja     445f4 <printer_vprintf+0x6b2>
   44255:	89 c0                	mov    %eax,%eax
   44257:	48 8b 04 c5 98 58 04 	mov    0x45898(,%rax,8),%rax
   4425e:	00 
   4425f:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
   44261:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   44268:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4426f:	01 
            goto again;
   44270:	eb ca                	jmp    4423c <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   44272:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   44276:	74 5d                	je     442d5 <printer_vprintf+0x393>
   44278:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4427f:	8b 00                	mov    (%rax),%eax
   44281:	83 f8 2f             	cmp    $0x2f,%eax
   44284:	77 30                	ja     442b6 <printer_vprintf+0x374>
   44286:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4428d:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44291:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44298:	8b 00                	mov    (%rax),%eax
   4429a:	89 c0                	mov    %eax,%eax
   4429c:	48 01 d0             	add    %rdx,%rax
   4429f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442a6:	8b 12                	mov    (%rdx),%edx
   442a8:	8d 4a 08             	lea    0x8(%rdx),%ecx
   442ab:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442b2:	89 0a                	mov    %ecx,(%rdx)
   442b4:	eb 1a                	jmp    442d0 <printer_vprintf+0x38e>
   442b6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442bd:	48 8b 40 08          	mov    0x8(%rax),%rax
   442c1:	48 8d 48 08          	lea    0x8(%rax),%rcx
   442c5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442cc:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   442d0:	48 8b 00             	mov    (%rax),%rax
   442d3:	eb 5c                	jmp    44331 <printer_vprintf+0x3ef>
   442d5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442dc:	8b 00                	mov    (%rax),%eax
   442de:	83 f8 2f             	cmp    $0x2f,%eax
   442e1:	77 30                	ja     44313 <printer_vprintf+0x3d1>
   442e3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442ea:	48 8b 50 10          	mov    0x10(%rax),%rdx
   442ee:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442f5:	8b 00                	mov    (%rax),%eax
   442f7:	89 c0                	mov    %eax,%eax
   442f9:	48 01 d0             	add    %rdx,%rax
   442fc:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44303:	8b 12                	mov    (%rdx),%edx
   44305:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44308:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4430f:	89 0a                	mov    %ecx,(%rdx)
   44311:	eb 1a                	jmp    4432d <printer_vprintf+0x3eb>
   44313:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4431a:	48 8b 40 08          	mov    0x8(%rax),%rax
   4431e:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44322:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44329:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4432d:	8b 00                	mov    (%rax),%eax
   4432f:	48 98                	cltq   
   44331:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   44335:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44339:	48 c1 f8 38          	sar    $0x38,%rax
   4433d:	25 80 00 00 00       	and    $0x80,%eax
   44342:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   44345:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   44349:	74 09                	je     44354 <printer_vprintf+0x412>
   4434b:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4434f:	48 f7 d8             	neg    %rax
   44352:	eb 04                	jmp    44358 <printer_vprintf+0x416>
   44354:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44358:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   4435c:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   4435f:	83 c8 60             	or     $0x60,%eax
   44362:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   44365:	e9 cf 02 00 00       	jmp    44639 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   4436a:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   4436e:	74 5d                	je     443cd <printer_vprintf+0x48b>
   44370:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44377:	8b 00                	mov    (%rax),%eax
   44379:	83 f8 2f             	cmp    $0x2f,%eax
   4437c:	77 30                	ja     443ae <printer_vprintf+0x46c>
   4437e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44385:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44389:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44390:	8b 00                	mov    (%rax),%eax
   44392:	89 c0                	mov    %eax,%eax
   44394:	48 01 d0             	add    %rdx,%rax
   44397:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4439e:	8b 12                	mov    (%rdx),%edx
   443a0:	8d 4a 08             	lea    0x8(%rdx),%ecx
   443a3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   443aa:	89 0a                	mov    %ecx,(%rdx)
   443ac:	eb 1a                	jmp    443c8 <printer_vprintf+0x486>
   443ae:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443b5:	48 8b 40 08          	mov    0x8(%rax),%rax
   443b9:	48 8d 48 08          	lea    0x8(%rax),%rcx
   443bd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   443c4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   443c8:	48 8b 00             	mov    (%rax),%rax
   443cb:	eb 5c                	jmp    44429 <printer_vprintf+0x4e7>
   443cd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443d4:	8b 00                	mov    (%rax),%eax
   443d6:	83 f8 2f             	cmp    $0x2f,%eax
   443d9:	77 30                	ja     4440b <printer_vprintf+0x4c9>
   443db:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443e2:	48 8b 50 10          	mov    0x10(%rax),%rdx
   443e6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443ed:	8b 00                	mov    (%rax),%eax
   443ef:	89 c0                	mov    %eax,%eax
   443f1:	48 01 d0             	add    %rdx,%rax
   443f4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   443fb:	8b 12                	mov    (%rdx),%edx
   443fd:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44400:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44407:	89 0a                	mov    %ecx,(%rdx)
   44409:	eb 1a                	jmp    44425 <printer_vprintf+0x4e3>
   4440b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44412:	48 8b 40 08          	mov    0x8(%rax),%rax
   44416:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4441a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44421:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44425:	8b 00                	mov    (%rax),%eax
   44427:	89 c0                	mov    %eax,%eax
   44429:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   4442d:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   44431:	e9 03 02 00 00       	jmp    44639 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
   44436:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   4443d:	e9 28 ff ff ff       	jmp    4436a <printer_vprintf+0x428>
        case 'X':
            base = 16;
   44442:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   44449:	e9 1c ff ff ff       	jmp    4436a <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   4444e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44455:	8b 00                	mov    (%rax),%eax
   44457:	83 f8 2f             	cmp    $0x2f,%eax
   4445a:	77 30                	ja     4448c <printer_vprintf+0x54a>
   4445c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44463:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44467:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4446e:	8b 00                	mov    (%rax),%eax
   44470:	89 c0                	mov    %eax,%eax
   44472:	48 01 d0             	add    %rdx,%rax
   44475:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4447c:	8b 12                	mov    (%rdx),%edx
   4447e:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44481:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44488:	89 0a                	mov    %ecx,(%rdx)
   4448a:	eb 1a                	jmp    444a6 <printer_vprintf+0x564>
   4448c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44493:	48 8b 40 08          	mov    0x8(%rax),%rax
   44497:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4449b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   444a2:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   444a6:	48 8b 00             	mov    (%rax),%rax
   444a9:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   444ad:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   444b4:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   444bb:	e9 79 01 00 00       	jmp    44639 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
   444c0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444c7:	8b 00                	mov    (%rax),%eax
   444c9:	83 f8 2f             	cmp    $0x2f,%eax
   444cc:	77 30                	ja     444fe <printer_vprintf+0x5bc>
   444ce:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444d5:	48 8b 50 10          	mov    0x10(%rax),%rdx
   444d9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444e0:	8b 00                	mov    (%rax),%eax
   444e2:	89 c0                	mov    %eax,%eax
   444e4:	48 01 d0             	add    %rdx,%rax
   444e7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   444ee:	8b 12                	mov    (%rdx),%edx
   444f0:	8d 4a 08             	lea    0x8(%rdx),%ecx
   444f3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   444fa:	89 0a                	mov    %ecx,(%rdx)
   444fc:	eb 1a                	jmp    44518 <printer_vprintf+0x5d6>
   444fe:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44505:	48 8b 40 08          	mov    0x8(%rax),%rax
   44509:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4450d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44514:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44518:	48 8b 00             	mov    (%rax),%rax
   4451b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   4451f:	e9 15 01 00 00       	jmp    44639 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
   44524:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4452b:	8b 00                	mov    (%rax),%eax
   4452d:	83 f8 2f             	cmp    $0x2f,%eax
   44530:	77 30                	ja     44562 <printer_vprintf+0x620>
   44532:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44539:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4453d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44544:	8b 00                	mov    (%rax),%eax
   44546:	89 c0                	mov    %eax,%eax
   44548:	48 01 d0             	add    %rdx,%rax
   4454b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44552:	8b 12                	mov    (%rdx),%edx
   44554:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44557:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4455e:	89 0a                	mov    %ecx,(%rdx)
   44560:	eb 1a                	jmp    4457c <printer_vprintf+0x63a>
   44562:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44569:	48 8b 40 08          	mov    0x8(%rax),%rax
   4456d:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44571:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44578:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4457c:	8b 00                	mov    (%rax),%eax
   4457e:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   44584:	e9 67 03 00 00       	jmp    448f0 <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
   44589:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   4458d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   44591:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44598:	8b 00                	mov    (%rax),%eax
   4459a:	83 f8 2f             	cmp    $0x2f,%eax
   4459d:	77 30                	ja     445cf <printer_vprintf+0x68d>
   4459f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445a6:	48 8b 50 10          	mov    0x10(%rax),%rdx
   445aa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445b1:	8b 00                	mov    (%rax),%eax
   445b3:	89 c0                	mov    %eax,%eax
   445b5:	48 01 d0             	add    %rdx,%rax
   445b8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445bf:	8b 12                	mov    (%rdx),%edx
   445c1:	8d 4a 08             	lea    0x8(%rdx),%ecx
   445c4:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445cb:	89 0a                	mov    %ecx,(%rdx)
   445cd:	eb 1a                	jmp    445e9 <printer_vprintf+0x6a7>
   445cf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445d6:	48 8b 40 08          	mov    0x8(%rax),%rax
   445da:	48 8d 48 08          	lea    0x8(%rax),%rcx
   445de:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445e5:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   445e9:	8b 00                	mov    (%rax),%eax
   445eb:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   445ee:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   445f2:	eb 45                	jmp    44639 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
   445f4:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   445f8:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   445fc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44603:	0f b6 00             	movzbl (%rax),%eax
   44606:	84 c0                	test   %al,%al
   44608:	74 0c                	je     44616 <printer_vprintf+0x6d4>
   4460a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44611:	0f b6 00             	movzbl (%rax),%eax
   44614:	eb 05                	jmp    4461b <printer_vprintf+0x6d9>
   44616:	b8 25 00 00 00       	mov    $0x25,%eax
   4461b:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   4461e:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   44622:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44629:	0f b6 00             	movzbl (%rax),%eax
   4462c:	84 c0                	test   %al,%al
   4462e:	75 08                	jne    44638 <printer_vprintf+0x6f6>
                format--;
   44630:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   44637:	01 
            }
            break;
   44638:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   44639:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4463c:	83 e0 20             	and    $0x20,%eax
   4463f:	85 c0                	test   %eax,%eax
   44641:	74 1e                	je     44661 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   44643:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   44647:	48 83 c0 18          	add    $0x18,%rax
   4464b:	8b 55 e0             	mov    -0x20(%rbp),%edx
   4464e:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   44652:	48 89 ce             	mov    %rcx,%rsi
   44655:	48 89 c7             	mov    %rax,%rdi
   44658:	e8 63 f8 ff ff       	call   43ec0 <fill_numbuf>
   4465d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   44661:	48 c7 45 c0 86 58 04 	movq   $0x45886,-0x40(%rbp)
   44668:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   44669:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4466c:	83 e0 20             	and    $0x20,%eax
   4466f:	85 c0                	test   %eax,%eax
   44671:	74 48                	je     446bb <printer_vprintf+0x779>
   44673:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44676:	83 e0 40             	and    $0x40,%eax
   44679:	85 c0                	test   %eax,%eax
   4467b:	74 3e                	je     446bb <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
   4467d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44680:	25 80 00 00 00       	and    $0x80,%eax
   44685:	85 c0                	test   %eax,%eax
   44687:	74 0a                	je     44693 <printer_vprintf+0x751>
                prefix = "-";
   44689:	48 c7 45 c0 87 58 04 	movq   $0x45887,-0x40(%rbp)
   44690:	00 
            if (flags & FLAG_NEGATIVE) {
   44691:	eb 73                	jmp    44706 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   44693:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44696:	83 e0 10             	and    $0x10,%eax
   44699:	85 c0                	test   %eax,%eax
   4469b:	74 0a                	je     446a7 <printer_vprintf+0x765>
                prefix = "+";
   4469d:	48 c7 45 c0 89 58 04 	movq   $0x45889,-0x40(%rbp)
   446a4:	00 
            if (flags & FLAG_NEGATIVE) {
   446a5:	eb 5f                	jmp    44706 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   446a7:	8b 45 ec             	mov    -0x14(%rbp),%eax
   446aa:	83 e0 08             	and    $0x8,%eax
   446ad:	85 c0                	test   %eax,%eax
   446af:	74 55                	je     44706 <printer_vprintf+0x7c4>
                prefix = " ";
   446b1:	48 c7 45 c0 8b 58 04 	movq   $0x4588b,-0x40(%rbp)
   446b8:	00 
            if (flags & FLAG_NEGATIVE) {
   446b9:	eb 4b                	jmp    44706 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   446bb:	8b 45 ec             	mov    -0x14(%rbp),%eax
   446be:	83 e0 20             	and    $0x20,%eax
   446c1:	85 c0                	test   %eax,%eax
   446c3:	74 42                	je     44707 <printer_vprintf+0x7c5>
   446c5:	8b 45 ec             	mov    -0x14(%rbp),%eax
   446c8:	83 e0 01             	and    $0x1,%eax
   446cb:	85 c0                	test   %eax,%eax
   446cd:	74 38                	je     44707 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
   446cf:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   446d3:	74 06                	je     446db <printer_vprintf+0x799>
   446d5:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   446d9:	75 2c                	jne    44707 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
   446db:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   446e0:	75 0c                	jne    446ee <printer_vprintf+0x7ac>
   446e2:	8b 45 ec             	mov    -0x14(%rbp),%eax
   446e5:	25 00 01 00 00       	and    $0x100,%eax
   446ea:	85 c0                	test   %eax,%eax
   446ec:	74 19                	je     44707 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
   446ee:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   446f2:	75 07                	jne    446fb <printer_vprintf+0x7b9>
   446f4:	b8 8d 58 04 00       	mov    $0x4588d,%eax
   446f9:	eb 05                	jmp    44700 <printer_vprintf+0x7be>
   446fb:	b8 90 58 04 00       	mov    $0x45890,%eax
   44700:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   44704:	eb 01                	jmp    44707 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
   44706:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   44707:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   4470b:	78 24                	js     44731 <printer_vprintf+0x7ef>
   4470d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44710:	83 e0 20             	and    $0x20,%eax
   44713:	85 c0                	test   %eax,%eax
   44715:	75 1a                	jne    44731 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
   44717:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4471a:	48 63 d0             	movslq %eax,%rdx
   4471d:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44721:	48 89 d6             	mov    %rdx,%rsi
   44724:	48 89 c7             	mov    %rax,%rdi
   44727:	e8 ea f5 ff ff       	call   43d16 <strnlen>
   4472c:	89 45 bc             	mov    %eax,-0x44(%rbp)
   4472f:	eb 0f                	jmp    44740 <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
   44731:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44735:	48 89 c7             	mov    %rax,%rdi
   44738:	e8 a8 f5 ff ff       	call   43ce5 <strlen>
   4473d:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   44740:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44743:	83 e0 20             	and    $0x20,%eax
   44746:	85 c0                	test   %eax,%eax
   44748:	74 20                	je     4476a <printer_vprintf+0x828>
   4474a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   4474e:	78 1a                	js     4476a <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
   44750:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44753:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   44756:	7e 08                	jle    44760 <printer_vprintf+0x81e>
   44758:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4475b:	2b 45 bc             	sub    -0x44(%rbp),%eax
   4475e:	eb 05                	jmp    44765 <printer_vprintf+0x823>
   44760:	b8 00 00 00 00       	mov    $0x0,%eax
   44765:	89 45 b8             	mov    %eax,-0x48(%rbp)
   44768:	eb 5c                	jmp    447c6 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   4476a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4476d:	83 e0 20             	and    $0x20,%eax
   44770:	85 c0                	test   %eax,%eax
   44772:	74 4b                	je     447bf <printer_vprintf+0x87d>
   44774:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44777:	83 e0 02             	and    $0x2,%eax
   4477a:	85 c0                	test   %eax,%eax
   4477c:	74 41                	je     447bf <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
   4477e:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44781:	83 e0 04             	and    $0x4,%eax
   44784:	85 c0                	test   %eax,%eax
   44786:	75 37                	jne    447bf <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
   44788:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4478c:	48 89 c7             	mov    %rax,%rdi
   4478f:	e8 51 f5 ff ff       	call   43ce5 <strlen>
   44794:	89 c2                	mov    %eax,%edx
   44796:	8b 45 bc             	mov    -0x44(%rbp),%eax
   44799:	01 d0                	add    %edx,%eax
   4479b:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   4479e:	7e 1f                	jle    447bf <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
   447a0:	8b 45 e8             	mov    -0x18(%rbp),%eax
   447a3:	2b 45 bc             	sub    -0x44(%rbp),%eax
   447a6:	89 c3                	mov    %eax,%ebx
   447a8:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   447ac:	48 89 c7             	mov    %rax,%rdi
   447af:	e8 31 f5 ff ff       	call   43ce5 <strlen>
   447b4:	89 c2                	mov    %eax,%edx
   447b6:	89 d8                	mov    %ebx,%eax
   447b8:	29 d0                	sub    %edx,%eax
   447ba:	89 45 b8             	mov    %eax,-0x48(%rbp)
   447bd:	eb 07                	jmp    447c6 <printer_vprintf+0x884>
        } else {
            zeros = 0;
   447bf:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   447c6:	8b 55 bc             	mov    -0x44(%rbp),%edx
   447c9:	8b 45 b8             	mov    -0x48(%rbp),%eax
   447cc:	01 d0                	add    %edx,%eax
   447ce:	48 63 d8             	movslq %eax,%rbx
   447d1:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   447d5:	48 89 c7             	mov    %rax,%rdi
   447d8:	e8 08 f5 ff ff       	call   43ce5 <strlen>
   447dd:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   447e1:	8b 45 e8             	mov    -0x18(%rbp),%eax
   447e4:	29 d0                	sub    %edx,%eax
   447e6:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   447e9:	eb 25                	jmp    44810 <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
   447eb:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   447f2:	48 8b 08             	mov    (%rax),%rcx
   447f5:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   447fb:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44802:	be 20 00 00 00       	mov    $0x20,%esi
   44807:	48 89 c7             	mov    %rax,%rdi
   4480a:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   4480c:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   44810:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44813:	83 e0 04             	and    $0x4,%eax
   44816:	85 c0                	test   %eax,%eax
   44818:	75 36                	jne    44850 <printer_vprintf+0x90e>
   4481a:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   4481e:	7f cb                	jg     447eb <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
   44820:	eb 2e                	jmp    44850 <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
   44822:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44829:	4c 8b 00             	mov    (%rax),%r8
   4482c:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44830:	0f b6 00             	movzbl (%rax),%eax
   44833:	0f b6 c8             	movzbl %al,%ecx
   44836:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   4483c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44843:	89 ce                	mov    %ecx,%esi
   44845:	48 89 c7             	mov    %rax,%rdi
   44848:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   4484b:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   44850:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44854:	0f b6 00             	movzbl (%rax),%eax
   44857:	84 c0                	test   %al,%al
   44859:	75 c7                	jne    44822 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
   4485b:	eb 25                	jmp    44882 <printer_vprintf+0x940>
            p->putc(p, '0', color);
   4485d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44864:	48 8b 08             	mov    (%rax),%rcx
   44867:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   4486d:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44874:	be 30 00 00 00       	mov    $0x30,%esi
   44879:	48 89 c7             	mov    %rax,%rdi
   4487c:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   4487e:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   44882:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   44886:	7f d5                	jg     4485d <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
   44888:	eb 32                	jmp    448bc <printer_vprintf+0x97a>
            p->putc(p, *data, color);
   4488a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44891:	4c 8b 00             	mov    (%rax),%r8
   44894:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44898:	0f b6 00             	movzbl (%rax),%eax
   4489b:	0f b6 c8             	movzbl %al,%ecx
   4489e:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   448a4:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   448ab:	89 ce                	mov    %ecx,%esi
   448ad:	48 89 c7             	mov    %rax,%rdi
   448b0:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   448b3:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   448b8:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   448bc:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   448c0:	7f c8                	jg     4488a <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
   448c2:	eb 25                	jmp    448e9 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
   448c4:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   448cb:	48 8b 08             	mov    (%rax),%rcx
   448ce:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   448d4:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   448db:	be 20 00 00 00       	mov    $0x20,%esi
   448e0:	48 89 c7             	mov    %rax,%rdi
   448e3:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   448e5:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   448e9:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   448ed:	7f d5                	jg     448c4 <printer_vprintf+0x982>
        }
    done: ;
   448ef:	90                   	nop
    for (; *format; ++format) {
   448f0:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   448f7:	01 
   448f8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   448ff:	0f b6 00             	movzbl (%rax),%eax
   44902:	84 c0                	test   %al,%al
   44904:	0f 85 64 f6 ff ff    	jne    43f6e <printer_vprintf+0x2c>
    }
}
   4490a:	90                   	nop
   4490b:	90                   	nop
   4490c:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   44910:	c9                   	leave  
   44911:	c3                   	ret    

0000000000044912 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   44912:	55                   	push   %rbp
   44913:	48 89 e5             	mov    %rsp,%rbp
   44916:	48 83 ec 20          	sub    $0x20,%rsp
   4491a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4491e:	89 f0                	mov    %esi,%eax
   44920:	89 55 e0             	mov    %edx,-0x20(%rbp)
   44923:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   44926:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4492a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   4492e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44932:	48 8b 40 08          	mov    0x8(%rax),%rax
   44936:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
   4493b:	48 39 d0             	cmp    %rdx,%rax
   4493e:	72 0c                	jb     4494c <console_putc+0x3a>
        cp->cursor = console;
   44940:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44944:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
   4494b:	00 
    }
    if (c == '\n') {
   4494c:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   44950:	75 78                	jne    449ca <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
   44952:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44956:	48 8b 40 08          	mov    0x8(%rax),%rax
   4495a:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   44960:	48 d1 f8             	sar    %rax
   44963:	48 89 c1             	mov    %rax,%rcx
   44966:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   4496d:	66 66 66 
   44970:	48 89 c8             	mov    %rcx,%rax
   44973:	48 f7 ea             	imul   %rdx
   44976:	48 c1 fa 05          	sar    $0x5,%rdx
   4497a:	48 89 c8             	mov    %rcx,%rax
   4497d:	48 c1 f8 3f          	sar    $0x3f,%rax
   44981:	48 29 c2             	sub    %rax,%rdx
   44984:	48 89 d0             	mov    %rdx,%rax
   44987:	48 c1 e0 02          	shl    $0x2,%rax
   4498b:	48 01 d0             	add    %rdx,%rax
   4498e:	48 c1 e0 04          	shl    $0x4,%rax
   44992:	48 29 c1             	sub    %rax,%rcx
   44995:	48 89 ca             	mov    %rcx,%rdx
   44998:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   4499b:	eb 25                	jmp    449c2 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
   4499d:	8b 45 e0             	mov    -0x20(%rbp),%eax
   449a0:	83 c8 20             	or     $0x20,%eax
   449a3:	89 c6                	mov    %eax,%esi
   449a5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   449a9:	48 8b 40 08          	mov    0x8(%rax),%rax
   449ad:	48 8d 48 02          	lea    0x2(%rax),%rcx
   449b1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   449b5:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   449b9:	89 f2                	mov    %esi,%edx
   449bb:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   449be:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   449c2:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   449c6:	75 d5                	jne    4499d <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   449c8:	eb 24                	jmp    449ee <console_putc+0xdc>
        *cp->cursor++ = c | color;
   449ca:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
   449ce:	8b 55 e0             	mov    -0x20(%rbp),%edx
   449d1:	09 d0                	or     %edx,%eax
   449d3:	89 c6                	mov    %eax,%esi
   449d5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   449d9:	48 8b 40 08          	mov    0x8(%rax),%rax
   449dd:	48 8d 48 02          	lea    0x2(%rax),%rcx
   449e1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   449e5:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   449e9:	89 f2                	mov    %esi,%edx
   449eb:	66 89 10             	mov    %dx,(%rax)
}
   449ee:	90                   	nop
   449ef:	c9                   	leave  
   449f0:	c3                   	ret    

00000000000449f1 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   449f1:	55                   	push   %rbp
   449f2:	48 89 e5             	mov    %rsp,%rbp
   449f5:	48 83 ec 30          	sub    $0x30,%rsp
   449f9:	89 7d ec             	mov    %edi,-0x14(%rbp)
   449fc:	89 75 e8             	mov    %esi,-0x18(%rbp)
   449ff:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   44a03:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   44a07:	48 c7 45 f0 12 49 04 	movq   $0x44912,-0x10(%rbp)
   44a0e:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   44a0f:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   44a13:	78 09                	js     44a1e <console_vprintf+0x2d>
   44a15:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   44a1c:	7e 07                	jle    44a25 <console_vprintf+0x34>
        cpos = 0;
   44a1e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   44a25:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44a28:	48 98                	cltq   
   44a2a:	48 01 c0             	add    %rax,%rax
   44a2d:	48 05 00 80 0b 00    	add    $0xb8000,%rax
   44a33:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   44a37:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   44a3b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   44a3f:	8b 75 e8             	mov    -0x18(%rbp),%esi
   44a42:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   44a46:	48 89 c7             	mov    %rax,%rdi
   44a49:	e8 f4 f4 ff ff       	call   43f42 <printer_vprintf>
    return cp.cursor - console;
   44a4e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44a52:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   44a58:	48 d1 f8             	sar    %rax
}
   44a5b:	c9                   	leave  
   44a5c:	c3                   	ret    

0000000000044a5d <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   44a5d:	55                   	push   %rbp
   44a5e:	48 89 e5             	mov    %rsp,%rbp
   44a61:	48 83 ec 60          	sub    $0x60,%rsp
   44a65:	89 7d ac             	mov    %edi,-0x54(%rbp)
   44a68:	89 75 a8             	mov    %esi,-0x58(%rbp)
   44a6b:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   44a6f:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44a73:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44a77:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44a7b:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   44a82:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44a86:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   44a8a:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44a8e:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   44a92:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   44a96:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   44a9a:	8b 75 a8             	mov    -0x58(%rbp),%esi
   44a9d:	8b 45 ac             	mov    -0x54(%rbp),%eax
   44aa0:	89 c7                	mov    %eax,%edi
   44aa2:	e8 4a ff ff ff       	call   449f1 <console_vprintf>
   44aa7:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   44aaa:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   44aad:	c9                   	leave  
   44aae:	c3                   	ret    

0000000000044aaf <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   44aaf:	55                   	push   %rbp
   44ab0:	48 89 e5             	mov    %rsp,%rbp
   44ab3:	48 83 ec 20          	sub    $0x20,%rsp
   44ab7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44abb:	89 f0                	mov    %esi,%eax
   44abd:	89 55 e0             	mov    %edx,-0x20(%rbp)
   44ac0:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   44ac3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44ac7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   44acb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44acf:	48 8b 50 08          	mov    0x8(%rax),%rdx
   44ad3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44ad7:	48 8b 40 10          	mov    0x10(%rax),%rax
   44adb:	48 39 c2             	cmp    %rax,%rdx
   44ade:	73 1a                	jae    44afa <string_putc+0x4b>
        *sp->s++ = c;
   44ae0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44ae4:	48 8b 40 08          	mov    0x8(%rax),%rax
   44ae8:	48 8d 48 01          	lea    0x1(%rax),%rcx
   44aec:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   44af0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44af4:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   44af8:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   44afa:	90                   	nop
   44afb:	c9                   	leave  
   44afc:	c3                   	ret    

0000000000044afd <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   44afd:	55                   	push   %rbp
   44afe:	48 89 e5             	mov    %rsp,%rbp
   44b01:	48 83 ec 40          	sub    $0x40,%rsp
   44b05:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   44b09:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   44b0d:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   44b11:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   44b15:	48 c7 45 e8 af 4a 04 	movq   $0x44aaf,-0x18(%rbp)
   44b1c:	00 
    sp.s = s;
   44b1d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44b21:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   44b25:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   44b2a:	74 33                	je     44b5f <vsnprintf+0x62>
        sp.end = s + size - 1;
   44b2c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   44b30:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   44b34:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44b38:	48 01 d0             	add    %rdx,%rax
   44b3b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   44b3f:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   44b43:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   44b47:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   44b4b:	be 00 00 00 00       	mov    $0x0,%esi
   44b50:	48 89 c7             	mov    %rax,%rdi
   44b53:	e8 ea f3 ff ff       	call   43f42 <printer_vprintf>
        *sp.s = 0;
   44b58:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44b5c:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   44b5f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44b63:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   44b67:	c9                   	leave  
   44b68:	c3                   	ret    

0000000000044b69 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   44b69:	55                   	push   %rbp
   44b6a:	48 89 e5             	mov    %rsp,%rbp
   44b6d:	48 83 ec 70          	sub    $0x70,%rsp
   44b71:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   44b75:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   44b79:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   44b7d:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44b81:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44b85:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44b89:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   44b90:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44b94:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   44b98:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44b9c:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   44ba0:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   44ba4:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   44ba8:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   44bac:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44bb0:	48 89 c7             	mov    %rax,%rdi
   44bb3:	e8 45 ff ff ff       	call   44afd <vsnprintf>
   44bb8:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   44bbb:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   44bbe:	c9                   	leave  
   44bbf:	c3                   	ret    

0000000000044bc0 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   44bc0:	55                   	push   %rbp
   44bc1:	48 89 e5             	mov    %rsp,%rbp
   44bc4:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44bc8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   44bcf:	eb 13                	jmp    44be4 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
   44bd1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   44bd4:	48 98                	cltq   
   44bd6:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
   44bdd:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44be0:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44be4:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   44beb:	7e e4                	jle    44bd1 <console_clear+0x11>
    }
    cursorpos = 0;
   44bed:	c7 05 05 44 07 00 00 	movl   $0x0,0x74405(%rip)        # b8ffc <cursorpos>
   44bf4:	00 00 00 
}
   44bf7:	90                   	nop
   44bf8:	c9                   	leave  
   44bf9:	c3                   	ret    
