
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
   400be:	e8 16 05 00 00       	call   405d9 <exception>

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
   40173:	e8 35 12 00 00       	call   413ad <hardware_init>
    pageinfo_init();
   40178:	e8 a9 08 00 00       	call   40a26 <pageinfo_init>
    console_clear();
   4017d:	e8 86 47 00 00       	call   44908 <console_clear>
    timer_init(HZ);
   40182:	bf 64 00 00 00       	mov    $0x64,%edi
   40187:	e8 0d 17 00 00       	call   41899 <timer_init>

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   4018c:	ba 00 0f 00 00       	mov    $0xf00,%edx
   40191:	be 00 00 00 00       	mov    $0x0,%esi
   40196:	bf 00 e0 04 00       	mov    $0x4e000,%edi
   4019b:	e8 4e 38 00 00       	call   439ee <memset>
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
   401fe:	be 86 49 04 00       	mov    $0x44986,%esi
   40203:	48 89 c7             	mov    %rax,%rdi
   40206:	e8 dc 38 00 00       	call   43ae7 <strcmp>
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
   4022e:	be 8d 49 04 00       	mov    $0x4498d,%esi
   40233:	48 89 c7             	mov    %rax,%rdi
   40236:	e8 ac 38 00 00       	call   43ae7 <strcmp>
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
   4025b:	be 98 49 04 00       	mov    $0x44998,%esi
   40260:	48 89 c7             	mov    %rax,%rdi
   40263:	e8 7f 38 00 00       	call   43ae7 <strcmp>
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
   40288:	be 9d 49 04 00       	mov    $0x4499d,%esi
   4028d:	48 89 c7             	mov    %rax,%rdi
   40290:	e8 52 38 00 00       	call   43ae7 <strcmp>
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
   402d1:	e8 bf 06 00 00       	call   40995 <run>

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
   40306:	e8 1f 18 00 00       	call   41b2a <process_init>
    assert(process_config_tables(pid) == 0);
   4030b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4030e:	89 c7                	mov    %eax,%edi
   40310:	e8 a2 2e 00 00       	call   431b7 <process_config_tables>
   40315:	85 c0                	test   %eax,%eax
   40317:	74 14                	je     4032d <process_setup+0x57>
   40319:	ba a8 49 04 00       	mov    $0x449a8,%edx
   4031e:	be 77 00 00 00       	mov    $0x77,%esi
   40323:	bf c8 49 04 00       	mov    $0x449c8,%edi
   40328:	e8 cb 1f 00 00       	call   422f8 <assert_fail>

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
   40350:	e8 b0 31 00 00       	call   43505 <process_load>
   40355:	85 c0                	test   %eax,%eax
   40357:	79 14                	jns    4036d <process_setup+0x97>
   40359:	ba d8 49 04 00       	mov    $0x449d8,%edx
   4035e:	be 7a 00 00 00       	mov    $0x7a,%esi
   40363:	bf c8 49 04 00       	mov    $0x449c8,%edi
   40368:	e8 8b 1f 00 00       	call   422f8 <assert_fail>

    process_setup_stack(&processes[pid]);
   4036d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40370:	48 63 d0             	movslq %eax,%rdx
   40373:	48 89 d0             	mov    %rdx,%rax
   40376:	48 c1 e0 04          	shl    $0x4,%rax
   4037a:	48 29 d0             	sub    %rdx,%rax
   4037d:	48 c1 e0 04          	shl    $0x4,%rax
   40381:	48 05 00 e0 04 00    	add    $0x4e000,%rax
   40387:	48 89 c7             	mov    %rax,%rdi
   4038a:	e8 ae 31 00 00       	call   4353d <process_setup_stack>

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
   40434:	e8 b7 31 00 00       	call   435f0 <process_fork>
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
   4044a:	e8 86 2a 00 00       	call   42ed5 <process_free>
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
   4046f:	e8 0e 34 00 00       	call   43882 <process_page_alloc>
}
   40474:	c9                   	leave  
   40475:	c3                   	ret    

0000000000040476 <sbrk>:


int sbrk(proc * p, intptr_t difference) {
   40476:	55                   	push   %rbp
   40477:	48 89 e5             	mov    %rsp,%rbp
   4047a:	48 83 ec 10          	sub    $0x10,%rsp
   4047e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   40482:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    // TODO : Your code here
    return 0;
   40486:	b8 00 00 00 00       	mov    $0x0,%eax
}
   4048b:	c9                   	leave  
   4048c:	c3                   	ret    

000000000004048d <syscall_mapping>:


void syscall_mapping(proc* p){
   4048d:	55                   	push   %rbp
   4048e:	48 89 e5             	mov    %rsp,%rbp
   40491:	48 83 ec 70          	sub    $0x70,%rsp
   40495:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)
    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
   40499:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4049d:	48 8b 40 48          	mov    0x48(%rax),%rax
   404a1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t ptr = p->p_registers.reg_rsi;
   404a5:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   404a9:	48 8b 40 40          	mov    0x40(%rax),%rax
   404ad:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    //convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);
   404b1:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   404b5:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   404bc:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   404c0:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   404c4:	48 89 ce             	mov    %rcx,%rsi
   404c7:	48 89 c7             	mov    %rax,%rdi
   404ca:	e8 eb 24 00 00       	call   429ba <virtual_memory_lookup>

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
   404cf:	8b 45 e0             	mov    -0x20(%rbp),%eax
   404d2:	48 98                	cltq   
   404d4:	83 e0 06             	and    $0x6,%eax
   404d7:	48 83 f8 06          	cmp    $0x6,%rax
   404db:	0f 85 89 00 00 00    	jne    4056a <syscall_mapping+0xdd>
        return;
    uintptr_t endaddr = mapping_ptr + sizeof(vamapping) - 1;
   404e1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   404e5:	48 83 c0 17          	add    $0x17,%rax
   404e9:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    if (PAGENUMBER(endaddr) != PAGENUMBER(ptr)){
   404ed:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   404f1:	48 c1 e8 0c          	shr    $0xc,%rax
   404f5:	89 c2                	mov    %eax,%edx
   404f7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   404fb:	48 c1 e8 0c          	shr    $0xc,%rax
   404ff:	39 c2                	cmp    %eax,%edx
   40501:	74 2c                	je     4052f <syscall_mapping+0xa2>
        vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
   40503:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40507:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   4050e:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40512:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   40516:	48 89 ce             	mov    %rcx,%rsi
   40519:	48 89 c7             	mov    %rax,%rdi
   4051c:	e8 99 24 00 00       	call   429ba <virtual_memory_lookup>
        // check for write access for end address
        if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
   40521:	8b 45 b0             	mov    -0x50(%rbp),%eax
   40524:	48 98                	cltq   
   40526:	83 e0 03             	and    $0x3,%eax
   40529:	48 83 f8 03          	cmp    $0x3,%rax
   4052d:	75 3e                	jne    4056d <syscall_mapping+0xe0>
            return; 
    }
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
   4052f:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40533:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   4053a:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   4053e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40542:	48 89 ce             	mov    %rcx,%rsi
   40545:	48 89 c7             	mov    %rax,%rdi
   40548:	e8 6d 24 00 00       	call   429ba <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   4054d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40551:	48 89 c1             	mov    %rax,%rcx
   40554:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   40558:	ba 18 00 00 00       	mov    $0x18,%edx
   4055d:	48 89 c6             	mov    %rax,%rsi
   40560:	48 89 cf             	mov    %rcx,%rdi
   40563:	e8 88 33 00 00       	call   438f0 <memcpy>
   40568:	eb 04                	jmp    4056e <syscall_mapping+0xe1>
        return;
   4056a:	90                   	nop
   4056b:	eb 01                	jmp    4056e <syscall_mapping+0xe1>
            return; 
   4056d:	90                   	nop
}
   4056e:	c9                   	leave  
   4056f:	c3                   	ret    

0000000000040570 <syscall_mem_tog>:

void syscall_mem_tog(proc* process){
   40570:	55                   	push   %rbp
   40571:	48 89 e5             	mov    %rsp,%rbp
   40574:	48 83 ec 18          	sub    $0x18,%rsp
   40578:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)

    pid_t p = process->p_registers.reg_rdi;
   4057c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40580:	48 8b 40 48          	mov    0x48(%rax),%rax
   40584:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(p == 0) {
   40587:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4058b:	75 14                	jne    405a1 <syscall_mem_tog+0x31>
        disp_global = !disp_global;
   4058d:	0f b6 05 6c 5a 00 00 	movzbl 0x5a6c(%rip),%eax        # 46000 <disp_global>
   40594:	84 c0                	test   %al,%al
   40596:	0f 94 c0             	sete   %al
   40599:	88 05 61 5a 00 00    	mov    %al,0x5a61(%rip)        # 46000 <disp_global>
   4059f:	eb 36                	jmp    405d7 <syscall_mem_tog+0x67>
    }
    else {
        if(p < 0 || p > NPROC || p != process->p_pid)
   405a1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   405a5:	78 2f                	js     405d6 <syscall_mem_tog+0x66>
   405a7:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   405ab:	7f 29                	jg     405d6 <syscall_mem_tog+0x66>
   405ad:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   405b1:	8b 00                	mov    (%rax),%eax
   405b3:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   405b6:	75 1e                	jne    405d6 <syscall_mem_tog+0x66>
            return;
        process->display_status = !(process->display_status);
   405b8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   405bc:	0f b6 80 e8 00 00 00 	movzbl 0xe8(%rax),%eax
   405c3:	84 c0                	test   %al,%al
   405c5:	0f 94 c0             	sete   %al
   405c8:	89 c2                	mov    %eax,%edx
   405ca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   405ce:	88 90 e8 00 00 00    	mov    %dl,0xe8(%rax)
   405d4:	eb 01                	jmp    405d7 <syscall_mem_tog+0x67>
            return;
   405d6:	90                   	nop
    }
}
   405d7:	c9                   	leave  
   405d8:	c3                   	ret    

00000000000405d9 <exception>:
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_64_registers* reg) {
   405d9:	55                   	push   %rbp
   405da:	48 89 e5             	mov    %rsp,%rbp
   405dd:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
   405e4:	48 89 bd 08 ff ff ff 	mov    %rdi,-0xf8(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   405eb:	48 8b 05 0e e9 00 00 	mov    0xe90e(%rip),%rax        # 4ef00 <current>
   405f2:	48 8b 95 08 ff ff ff 	mov    -0xf8(%rbp),%rdx
   405f9:	48 83 c0 18          	add    $0x18,%rax
   405fd:	48 89 d6             	mov    %rdx,%rsi
   40600:	ba 18 00 00 00       	mov    $0x18,%edx
   40605:	48 89 c7             	mov    %rax,%rdi
   40608:	48 89 d1             	mov    %rdx,%rcx
   4060b:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   4060e:	48 8b 05 eb 09 01 00 	mov    0x109eb(%rip),%rax        # 51000 <kernel_pagetable>
   40615:	48 89 c7             	mov    %rax,%rdi
   40618:	e8 a9 1e 00 00       	call   424c6 <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   4061d:	8b 05 d9 89 07 00    	mov    0x789d9(%rip),%eax        # b8ffc <cursorpos>
   40623:	89 c7                	mov    %eax,%edi
   40625:	e8 ca 15 00 00       	call   41bf4 <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT
   4062a:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40631:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40638:	48 83 f8 0e          	cmp    $0xe,%rax
   4063c:	74 14                	je     40652 <exception+0x79>
	    && reg->reg_intno != INT_GPF)
   4063e:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40645:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   4064c:	48 83 f8 0d          	cmp    $0xd,%rax
   40650:	75 16                	jne    40668 <exception+0x8f>
            || (reg->reg_err & PFERR_USER)) {
   40652:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40659:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40660:	83 e0 04             	and    $0x4,%eax
   40663:	48 85 c0             	test   %rax,%rax
   40666:	74 1a                	je     40682 <exception+0xa9>
        check_virtual_memory();
   40668:	e8 50 07 00 00       	call   40dbd <check_virtual_memory>
        if(disp_global){
   4066d:	0f b6 05 8c 59 00 00 	movzbl 0x598c(%rip),%eax        # 46000 <disp_global>
   40674:	84 c0                	test   %al,%al
   40676:	74 0a                	je     40682 <exception+0xa9>
            memshow_physical();
   40678:	e8 b8 08 00 00       	call   40f35 <memshow_physical>
            memshow_virtual_animate();
   4067d:	e8 e2 0b 00 00       	call   41264 <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   40682:	e8 50 1a 00 00       	call   420d7 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   40687:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   4068e:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40695:	48 83 e8 0e          	sub    $0xe,%rax
   40699:	48 83 f8 2c          	cmp    $0x2c,%rax
   4069d:	0f 87 41 02 00 00    	ja     408e4 <exception+0x30b>
   406a3:	48 8b 04 c5 98 4a 04 	mov    0x44a98(,%rax,8),%rax
   406aa:	00 
   406ab:	ff e0                	jmp    *%rax
        case INT_SYS_PANIC:
            {
                // rdi stores pointer for msg string
                {
                    char msg[160];
                    uintptr_t addr = current->p_registers.reg_rdi;
   406ad:	48 8b 05 4c e8 00 00 	mov    0xe84c(%rip),%rax        # 4ef00 <current>
   406b4:	48 8b 40 48          	mov    0x48(%rax),%rax
   406b8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                    if((void *)addr == NULL)
   406bc:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   406c1:	75 0f                	jne    406d2 <exception+0xf9>
                        kernel_panic(NULL);
   406c3:	bf 00 00 00 00       	mov    $0x0,%edi
   406c8:	b8 00 00 00 00       	mov    $0x0,%eax
   406cd:	e8 46 1b 00 00       	call   42218 <kernel_panic>
                    vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   406d2:	48 8b 05 27 e8 00 00 	mov    0xe827(%rip),%rax        # 4ef00 <current>
   406d9:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   406e0:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   406e4:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   406e8:	48 89 ce             	mov    %rcx,%rsi
   406eb:	48 89 c7             	mov    %rax,%rdi
   406ee:	e8 c7 22 00 00       	call   429ba <virtual_memory_lookup>
                    memcpy(msg, (void *)map.pa, 160);
   406f3:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   406f7:	48 89 c1             	mov    %rax,%rcx
   406fa:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
   40701:	ba a0 00 00 00       	mov    $0xa0,%edx
   40706:	48 89 ce             	mov    %rcx,%rsi
   40709:	48 89 c7             	mov    %rax,%rdi
   4070c:	e8 df 31 00 00       	call   438f0 <memcpy>
                    kernel_panic(msg);
   40711:	48 8d 85 18 ff ff ff 	lea    -0xe8(%rbp),%rax
   40718:	48 89 c7             	mov    %rax,%rdi
   4071b:	b8 00 00 00 00       	mov    $0x0,%eax
   40720:	e8 f3 1a 00 00       	call   42218 <kernel_panic>
                kernel_panic(NULL);
                break;                  // will not be reached
            }
        case INT_SYS_GETPID:
            {
                current->p_registers.reg_rax = current->p_pid;
   40725:	48 8b 05 d4 e7 00 00 	mov    0xe7d4(%rip),%rax        # 4ef00 <current>
   4072c:	8b 10                	mov    (%rax),%edx
   4072e:	48 8b 05 cb e7 00 00 	mov    0xe7cb(%rip),%rax        # 4ef00 <current>
   40735:	48 63 d2             	movslq %edx,%rdx
   40738:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   4073c:	e9 b5 01 00 00       	jmp    408f6 <exception+0x31d>
            }
        case INT_SYS_FORK:
            {
                current->p_registers.reg_rax = syscall_fork();
   40741:	b8 00 00 00 00       	mov    $0x0,%eax
   40746:	e8 db fc ff ff       	call   40426 <syscall_fork>
   4074b:	89 c2                	mov    %eax,%edx
   4074d:	48 8b 05 ac e7 00 00 	mov    0xe7ac(%rip),%rax        # 4ef00 <current>
   40754:	48 63 d2             	movslq %edx,%rdx
   40757:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   4075b:	e9 96 01 00 00       	jmp    408f6 <exception+0x31d>
            }
        case INT_SYS_MAPPING:
            {
                syscall_mapping(current);
   40760:	48 8b 05 99 e7 00 00 	mov    0xe799(%rip),%rax        # 4ef00 <current>
   40767:	48 89 c7             	mov    %rax,%rdi
   4076a:	e8 1e fd ff ff       	call   4048d <syscall_mapping>
                break;
   4076f:	e9 82 01 00 00       	jmp    408f6 <exception+0x31d>
            }

        case INT_SYS_EXIT:
            {
                syscall_exit();
   40774:	b8 00 00 00 00       	mov    $0x0,%eax
   40779:	e8 bd fc ff ff       	call   4043b <syscall_exit>
                schedule();
   4077e:	e8 9c 01 00 00       	call   4091f <schedule>
                break;
   40783:	e9 6e 01 00 00       	jmp    408f6 <exception+0x31d>
            }

        case INT_SYS_YIELD:
            {
                schedule();
   40788:	e8 92 01 00 00       	call   4091f <schedule>
                break;                  /* will not be reached */
   4078d:	e9 64 01 00 00       	jmp    408f6 <exception+0x31d>
                // TODO : Your code here
                break;
            }
	case INT_SYS_PAGE_ALLOC:
	    {
		intptr_t addr = reg->reg_rdi;
   40792:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40799:	48 8b 40 30          	mov    0x30(%rax),%rax
   4079d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
		syscall_page_alloc(addr);
   407a1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   407a5:	48 89 c7             	mov    %rax,%rdi
   407a8:	e8 a5 fc ff ff       	call   40452 <syscall_page_alloc>
		break;
   407ad:	e9 44 01 00 00       	jmp    408f6 <exception+0x31d>
	    }
        case INT_SYS_MEM_TOG:
            {
                syscall_mem_tog(current);
   407b2:	48 8b 05 47 e7 00 00 	mov    0xe747(%rip),%rax        # 4ef00 <current>
   407b9:	48 89 c7             	mov    %rax,%rdi
   407bc:	e8 af fd ff ff       	call   40570 <syscall_mem_tog>
                break;
   407c1:	e9 30 01 00 00       	jmp    408f6 <exception+0x31d>
            }

        case INT_TIMER:
            {
                ++ticks;
   407c6:	8b 05 54 eb 00 00    	mov    0xeb54(%rip),%eax        # 4f320 <ticks>
   407cc:	83 c0 01             	add    $0x1,%eax
   407cf:	89 05 4b eb 00 00    	mov    %eax,0xeb4b(%rip)        # 4f320 <ticks>
                schedule();
   407d5:	e8 45 01 00 00       	call   4091f <schedule>
                break;                  /* will not be reached */
   407da:	e9 17 01 00 00       	jmp    408f6 <exception+0x31d>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   407df:	0f 20 d0             	mov    %cr2,%rax
   407e2:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    return val;
   407e6:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
            }

        case INT_PAGEFAULT: 
            {
                // Analyze faulting address and access type.
                uintptr_t addr = rcr2();
   407ea:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
                const char* operation = reg->reg_err & PFERR_WRITE
   407ee:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   407f5:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   407fc:	83 e0 02             	and    $0x2,%eax
                    ? "write" : "read";
   407ff:	48 85 c0             	test   %rax,%rax
   40802:	74 07                	je     4080b <exception+0x232>
   40804:	b8 0b 4a 04 00       	mov    $0x44a0b,%eax
   40809:	eb 05                	jmp    40810 <exception+0x237>
   4080b:	b8 11 4a 04 00       	mov    $0x44a11,%eax
                const char* operation = reg->reg_err & PFERR_WRITE
   40810:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
                const char* problem = reg->reg_err & PFERR_PRESENT
   40814:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   4081b:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40822:	83 e0 01             	and    $0x1,%eax
                    ? "protection problem" : "missing page";
   40825:	48 85 c0             	test   %rax,%rax
   40828:	74 07                	je     40831 <exception+0x258>
   4082a:	b8 16 4a 04 00       	mov    $0x44a16,%eax
   4082f:	eb 05                	jmp    40836 <exception+0x25d>
   40831:	b8 29 4a 04 00       	mov    $0x44a29,%eax
                const char* problem = reg->reg_err & PFERR_PRESENT
   40836:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

                if (!(reg->reg_err & PFERR_USER)) {
   4083a:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40841:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40848:	83 e0 04             	and    $0x4,%eax
   4084b:	48 85 c0             	test   %rax,%rax
   4084e:	75 2f                	jne    4087f <exception+0x2a6>
                    kernel_panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   40850:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40857:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   4085e:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   40862:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   40866:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4086a:	49 89 f0             	mov    %rsi,%r8
   4086d:	48 89 c6             	mov    %rax,%rsi
   40870:	bf 38 4a 04 00       	mov    $0x44a38,%edi
   40875:	b8 00 00 00 00       	mov    $0x0,%eax
   4087a:	e8 99 19 00 00       	call   42218 <kernel_panic>
                            addr, operation, problem, reg->reg_rip);
                }
                console_printf(CPOS(24, 0), 0x0C00,
   4087f:	48 8b 85 08 ff ff ff 	mov    -0xf8(%rbp),%rax
   40886:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                        "Process %d page fault for %p (%s %s, rip=%p)!\n",
                        current->p_pid, addr, operation, problem, reg->reg_rip);
   4088d:	48 8b 05 6c e6 00 00 	mov    0xe66c(%rip),%rax        # 4ef00 <current>
                console_printf(CPOS(24, 0), 0x0C00,
   40894:	8b 00                	mov    (%rax),%eax
   40896:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
   4089a:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   4089e:	52                   	push   %rdx
   4089f:	ff 75 d8             	push   -0x28(%rbp)
   408a2:	49 89 f1             	mov    %rsi,%r9
   408a5:	49 89 c8             	mov    %rcx,%r8
   408a8:	89 c1                	mov    %eax,%ecx
   408aa:	ba 68 4a 04 00       	mov    $0x44a68,%edx
   408af:	be 00 0c 00 00       	mov    $0xc00,%esi
   408b4:	bf 80 07 00 00       	mov    $0x780,%edi
   408b9:	b8 00 00 00 00       	mov    $0x0,%eax
   408be:	e8 e2 3e 00 00       	call   447a5 <console_printf>
   408c3:	48 83 c4 10          	add    $0x10,%rsp
                current->p_state = P_BROKEN;
   408c7:	48 8b 05 32 e6 00 00 	mov    0xe632(%rip),%rax        # 4ef00 <current>
   408ce:	c7 80 d8 00 00 00 03 	movl   $0x3,0xd8(%rax)
   408d5:	00 00 00 
                syscall_exit();
   408d8:	b8 00 00 00 00       	mov    $0x0,%eax
   408dd:	e8 59 fb ff ff       	call   4043b <syscall_exit>
                break;
   408e2:	eb 12                	jmp    408f6 <exception+0x31d>
            }

        default:
            default_exception(current);
   408e4:	48 8b 05 15 e6 00 00 	mov    0xe615(%rip),%rax        # 4ef00 <current>
   408eb:	48 89 c7             	mov    %rax,%rdi
   408ee:	e8 35 1a 00 00       	call   42328 <default_exception>
            break;                  /* will not be reached */
   408f3:	eb 01                	jmp    408f6 <exception+0x31d>
		break;
   408f5:	90                   	nop

    }

    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   408f6:	48 8b 05 03 e6 00 00 	mov    0xe603(%rip),%rax        # 4ef00 <current>
   408fd:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   40903:	83 f8 01             	cmp    $0x1,%eax
   40906:	75 0f                	jne    40917 <exception+0x33e>
        run(current);
   40908:	48 8b 05 f1 e5 00 00 	mov    0xe5f1(%rip),%rax        # 4ef00 <current>
   4090f:	48 89 c7             	mov    %rax,%rdi
   40912:	e8 7e 00 00 00       	call   40995 <run>
    } else {
        schedule();
   40917:	e8 03 00 00 00       	call   4091f <schedule>
    }
}
   4091c:	90                   	nop
   4091d:	c9                   	leave  
   4091e:	c3                   	ret    

000000000004091f <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   4091f:	55                   	push   %rbp
   40920:	48 89 e5             	mov    %rsp,%rbp
   40923:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   40927:	48 8b 05 d2 e5 00 00 	mov    0xe5d2(%rip),%rax        # 4ef00 <current>
   4092e:	8b 00                	mov    (%rax),%eax
   40930:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   40933:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40936:	8d 50 01             	lea    0x1(%rax),%edx
   40939:	89 d0                	mov    %edx,%eax
   4093b:	c1 f8 1f             	sar    $0x1f,%eax
   4093e:	c1 e8 1c             	shr    $0x1c,%eax
   40941:	01 c2                	add    %eax,%edx
   40943:	83 e2 0f             	and    $0xf,%edx
   40946:	29 c2                	sub    %eax,%edx
   40948:	89 55 fc             	mov    %edx,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   4094b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4094e:	48 63 d0             	movslq %eax,%rdx
   40951:	48 89 d0             	mov    %rdx,%rax
   40954:	48 c1 e0 04          	shl    $0x4,%rax
   40958:	48 29 d0             	sub    %rdx,%rax
   4095b:	48 c1 e0 04          	shl    $0x4,%rax
   4095f:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   40965:	8b 00                	mov    (%rax),%eax
   40967:	83 f8 01             	cmp    $0x1,%eax
   4096a:	75 22                	jne    4098e <schedule+0x6f>
            run(&processes[pid]);
   4096c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4096f:	48 63 d0             	movslq %eax,%rdx
   40972:	48 89 d0             	mov    %rdx,%rax
   40975:	48 c1 e0 04          	shl    $0x4,%rax
   40979:	48 29 d0             	sub    %rdx,%rax
   4097c:	48 c1 e0 04          	shl    $0x4,%rax
   40980:	48 05 00 e0 04 00    	add    $0x4e000,%rax
   40986:	48 89 c7             	mov    %rax,%rdi
   40989:	e8 07 00 00 00       	call   40995 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   4098e:	e8 44 17 00 00       	call   420d7 <check_keyboard>
        pid = (pid + 1) % NPROC;
   40993:	eb 9e                	jmp    40933 <schedule+0x14>

0000000000040995 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   40995:	55                   	push   %rbp
   40996:	48 89 e5             	mov    %rsp,%rbp
   40999:	48 83 ec 10          	sub    $0x10,%rsp
   4099d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   409a1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   409a5:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   409ab:	83 f8 01             	cmp    $0x1,%eax
   409ae:	74 14                	je     409c4 <run+0x2f>
   409b0:	ba 00 4c 04 00       	mov    $0x44c00,%edx
   409b5:	be 7a 01 00 00       	mov    $0x17a,%esi
   409ba:	bf c8 49 04 00       	mov    $0x449c8,%edi
   409bf:	e8 34 19 00 00       	call   422f8 <assert_fail>
    current = p;
   409c4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   409c8:	48 89 05 31 e5 00 00 	mov    %rax,0xe531(%rip)        # 4ef00 <current>

    // display running process in CONSOLE last value
    console_printf(CPOS(24, 79),
   409cf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   409d3:	8b 10                	mov    (%rax),%edx
            memstate_colors[p->p_pid - PO_KERNEL], "%d", p->p_pid);
   409d5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   409d9:	8b 00                	mov    (%rax),%eax
   409db:	83 c0 02             	add    $0x2,%eax
   409de:	48 98                	cltq   
   409e0:	0f b7 84 00 60 49 04 	movzwl 0x44960(%rax,%rax,1),%eax
   409e7:	00 
    console_printf(CPOS(24, 79),
   409e8:	0f b7 c0             	movzwl %ax,%eax
   409eb:	89 d1                	mov    %edx,%ecx
   409ed:	ba 19 4c 04 00       	mov    $0x44c19,%edx
   409f2:	89 c6                	mov    %eax,%esi
   409f4:	bf cf 07 00 00       	mov    $0x7cf,%edi
   409f9:	b8 00 00 00 00       	mov    $0x0,%eax
   409fe:	e8 a2 3d 00 00       	call   447a5 <console_printf>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   40a03:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a07:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40a0e:	48 89 c7             	mov    %rax,%rdi
   40a11:	e8 b0 1a 00 00       	call   424c6 <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   40a16:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a1a:	48 83 c0 18          	add    $0x18,%rax
   40a1e:	48 89 c7             	mov    %rax,%rdi
   40a21:	e8 9d f6 ff ff       	call   400c3 <exception_return>

0000000000040a26 <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   40a26:	55                   	push   %rbp
   40a27:	48 89 e5             	mov    %rsp,%rbp
   40a2a:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40a2e:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40a35:	00 
   40a36:	e9 81 00 00 00       	jmp    40abc <pageinfo_init+0x96>
        int owner;
        if (physical_memory_isreserved(addr)) {
   40a3b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a3f:	48 89 c7             	mov    %rax,%rdi
   40a42:	e8 1e 0f 00 00       	call   41965 <physical_memory_isreserved>
   40a47:	85 c0                	test   %eax,%eax
   40a49:	74 09                	je     40a54 <pageinfo_init+0x2e>
            owner = PO_RESERVED;
   40a4b:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   40a52:	eb 2f                	jmp    40a83 <pageinfo_init+0x5d>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   40a54:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   40a5b:	00 
   40a5c:	76 0b                	jbe    40a69 <pageinfo_init+0x43>
   40a5e:	b8 10 70 05 00       	mov    $0x57010,%eax
   40a63:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40a67:	72 0a                	jb     40a73 <pageinfo_init+0x4d>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   40a69:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   40a70:	00 
   40a71:	75 09                	jne    40a7c <pageinfo_init+0x56>
            owner = PO_KERNEL;
   40a73:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   40a7a:	eb 07                	jmp    40a83 <pageinfo_init+0x5d>
        } else {
            owner = PO_FREE;
   40a7c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40a83:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a87:	48 c1 e8 0c          	shr    $0xc,%rax
   40a8b:	89 c1                	mov    %eax,%ecx
   40a8d:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40a90:	89 c2                	mov    %eax,%edx
   40a92:	48 63 c1             	movslq %ecx,%rax
   40a95:	88 94 00 20 ef 04 00 	mov    %dl,0x4ef20(%rax,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   40a9c:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40aa0:	0f 95 c2             	setne  %dl
   40aa3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40aa7:	48 c1 e8 0c          	shr    $0xc,%rax
   40aab:	48 98                	cltq   
   40aad:	88 94 00 21 ef 04 00 	mov    %dl,0x4ef21(%rax,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40ab4:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40abb:	00 
   40abc:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40ac3:	00 
   40ac4:	0f 86 71 ff ff ff    	jbe    40a3b <pageinfo_init+0x15>
    }
}
   40aca:	90                   	nop
   40acb:	90                   	nop
   40acc:	c9                   	leave  
   40acd:	c3                   	ret    

0000000000040ace <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   40ace:	55                   	push   %rbp
   40acf:	48 89 e5             	mov    %rsp,%rbp
   40ad2:	48 83 ec 50          	sub    $0x50,%rsp
   40ad6:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   40ada:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40ade:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40ae4:	48 89 c2             	mov    %rax,%rdx
   40ae7:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40aeb:	48 39 c2             	cmp    %rax,%rdx
   40aee:	74 14                	je     40b04 <check_page_table_mappings+0x36>
   40af0:	ba 20 4c 04 00       	mov    $0x44c20,%edx
   40af5:	be a8 01 00 00       	mov    $0x1a8,%esi
   40afa:	bf c8 49 04 00       	mov    $0x449c8,%edi
   40aff:	e8 f4 17 00 00       	call   422f8 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40b04:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   40b0b:	00 
   40b0c:	e9 9a 00 00 00       	jmp    40bab <check_page_table_mappings+0xdd>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   40b11:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   40b15:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40b19:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40b1d:	48 89 ce             	mov    %rcx,%rsi
   40b20:	48 89 c7             	mov    %rax,%rdi
   40b23:	e8 92 1e 00 00       	call   429ba <virtual_memory_lookup>
        if (vam.pa != va) {
   40b28:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40b2c:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40b30:	74 27                	je     40b59 <check_page_table_mappings+0x8b>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   40b32:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40b36:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40b3a:	49 89 d0             	mov    %rdx,%r8
   40b3d:	48 89 c1             	mov    %rax,%rcx
   40b40:	ba 3f 4c 04 00       	mov    $0x44c3f,%edx
   40b45:	be 00 c0 00 00       	mov    $0xc000,%esi
   40b4a:	bf e0 06 00 00       	mov    $0x6e0,%edi
   40b4f:	b8 00 00 00 00       	mov    $0x0,%eax
   40b54:	e8 4c 3c 00 00       	call   447a5 <console_printf>
        }
        assert(vam.pa == va);
   40b59:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40b5d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40b61:	74 14                	je     40b77 <check_page_table_mappings+0xa9>
   40b63:	ba 49 4c 04 00       	mov    $0x44c49,%edx
   40b68:	be b1 01 00 00       	mov    $0x1b1,%esi
   40b6d:	bf c8 49 04 00       	mov    $0x449c8,%edi
   40b72:	e8 81 17 00 00       	call   422f8 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   40b77:	b8 00 60 04 00       	mov    $0x46000,%eax
   40b7c:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40b80:	72 21                	jb     40ba3 <check_page_table_mappings+0xd5>
            assert(vam.perm & PTE_W);
   40b82:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40b85:	48 98                	cltq   
   40b87:	83 e0 02             	and    $0x2,%eax
   40b8a:	48 85 c0             	test   %rax,%rax
   40b8d:	75 14                	jne    40ba3 <check_page_table_mappings+0xd5>
   40b8f:	ba 56 4c 04 00       	mov    $0x44c56,%edx
   40b94:	be b3 01 00 00       	mov    $0x1b3,%esi
   40b99:	bf c8 49 04 00       	mov    $0x449c8,%edi
   40b9e:	e8 55 17 00 00       	call   422f8 <assert_fail>
         va += PAGESIZE) {
   40ba3:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40baa:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40bab:	b8 10 70 05 00       	mov    $0x57010,%eax
   40bb0:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40bb4:	0f 82 57 ff ff ff    	jb     40b11 <check_page_table_mappings+0x43>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   40bba:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   40bc1:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   40bc2:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   40bc6:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40bca:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40bce:	48 89 ce             	mov    %rcx,%rsi
   40bd1:	48 89 c7             	mov    %rax,%rdi
   40bd4:	e8 e1 1d 00 00       	call   429ba <virtual_memory_lookup>
    assert(vam.pa == kstack);
   40bd9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40bdd:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   40be1:	74 14                	je     40bf7 <check_page_table_mappings+0x129>
   40be3:	ba 67 4c 04 00       	mov    $0x44c67,%edx
   40be8:	be ba 01 00 00       	mov    $0x1ba,%esi
   40bed:	bf c8 49 04 00       	mov    $0x449c8,%edi
   40bf2:	e8 01 17 00 00       	call   422f8 <assert_fail>
    assert(vam.perm & PTE_W);
   40bf7:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40bfa:	48 98                	cltq   
   40bfc:	83 e0 02             	and    $0x2,%eax
   40bff:	48 85 c0             	test   %rax,%rax
   40c02:	75 14                	jne    40c18 <check_page_table_mappings+0x14a>
   40c04:	ba 56 4c 04 00       	mov    $0x44c56,%edx
   40c09:	be bb 01 00 00       	mov    $0x1bb,%esi
   40c0e:	bf c8 49 04 00       	mov    $0x449c8,%edi
   40c13:	e8 e0 16 00 00       	call   422f8 <assert_fail>
}
   40c18:	90                   	nop
   40c19:	c9                   	leave  
   40c1a:	c3                   	ret    

0000000000040c1b <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   40c1b:	55                   	push   %rbp
   40c1c:	48 89 e5             	mov    %rsp,%rbp
   40c1f:	48 83 ec 20          	sub    $0x20,%rsp
   40c23:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40c27:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   40c2a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40c2d:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   40c30:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   40c37:	48 8b 05 c2 03 01 00 	mov    0x103c2(%rip),%rax        # 51000 <kernel_pagetable>
   40c3e:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40c42:	75 67                	jne    40cab <check_page_table_ownership+0x90>
        owner = PO_KERNEL;
   40c44:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40c4b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   40c52:	eb 51                	jmp    40ca5 <check_page_table_ownership+0x8a>
            if (processes[xpid].p_state != P_FREE
   40c54:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40c57:	48 63 d0             	movslq %eax,%rdx
   40c5a:	48 89 d0             	mov    %rdx,%rax
   40c5d:	48 c1 e0 04          	shl    $0x4,%rax
   40c61:	48 29 d0             	sub    %rdx,%rax
   40c64:	48 c1 e0 04          	shl    $0x4,%rax
   40c68:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   40c6e:	8b 00                	mov    (%rax),%eax
   40c70:	85 c0                	test   %eax,%eax
   40c72:	74 2d                	je     40ca1 <check_page_table_ownership+0x86>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   40c74:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40c77:	48 63 d0             	movslq %eax,%rdx
   40c7a:	48 89 d0             	mov    %rdx,%rax
   40c7d:	48 c1 e0 04          	shl    $0x4,%rax
   40c81:	48 29 d0             	sub    %rdx,%rax
   40c84:	48 c1 e0 04          	shl    $0x4,%rax
   40c88:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   40c8e:	48 8b 10             	mov    (%rax),%rdx
   40c91:	48 8b 05 68 03 01 00 	mov    0x10368(%rip),%rax        # 51000 <kernel_pagetable>
   40c98:	48 39 c2             	cmp    %rax,%rdx
   40c9b:	75 04                	jne    40ca1 <check_page_table_ownership+0x86>
                ++expected_refcount;
   40c9d:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40ca1:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   40ca5:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   40ca9:	7e a9                	jle    40c54 <check_page_table_ownership+0x39>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   40cab:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   40cae:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40cb1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40cb5:	be 00 00 00 00       	mov    $0x0,%esi
   40cba:	48 89 c7             	mov    %rax,%rdi
   40cbd:	e8 03 00 00 00       	call   40cc5 <check_page_table_ownership_level>
}
   40cc2:	90                   	nop
   40cc3:	c9                   	leave  
   40cc4:	c3                   	ret    

0000000000040cc5 <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   40cc5:	55                   	push   %rbp
   40cc6:	48 89 e5             	mov    %rsp,%rbp
   40cc9:	48 83 ec 30          	sub    $0x30,%rsp
   40ccd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40cd1:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   40cd4:	89 55 e0             	mov    %edx,-0x20(%rbp)
   40cd7:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   40cda:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40cde:	48 c1 e8 0c          	shr    $0xc,%rax
   40ce2:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   40ce7:	7e 14                	jle    40cfd <check_page_table_ownership_level+0x38>
   40ce9:	ba 78 4c 04 00       	mov    $0x44c78,%edx
   40cee:	be d8 01 00 00       	mov    $0x1d8,%esi
   40cf3:	bf c8 49 04 00       	mov    $0x449c8,%edi
   40cf8:	e8 fb 15 00 00       	call   422f8 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   40cfd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40d01:	48 c1 e8 0c          	shr    $0xc,%rax
   40d05:	48 98                	cltq   
   40d07:	0f b6 84 00 20 ef 04 	movzbl 0x4ef20(%rax,%rax,1),%eax
   40d0e:	00 
   40d0f:	0f be c0             	movsbl %al,%eax
   40d12:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   40d15:	74 14                	je     40d2b <check_page_table_ownership_level+0x66>
   40d17:	ba 90 4c 04 00       	mov    $0x44c90,%edx
   40d1c:	be d9 01 00 00       	mov    $0x1d9,%esi
   40d21:	bf c8 49 04 00       	mov    $0x449c8,%edi
   40d26:	e8 cd 15 00 00       	call   422f8 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   40d2b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40d2f:	48 c1 e8 0c          	shr    $0xc,%rax
   40d33:	48 98                	cltq   
   40d35:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   40d3c:	00 
   40d3d:	0f be c0             	movsbl %al,%eax
   40d40:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   40d43:	74 14                	je     40d59 <check_page_table_ownership_level+0x94>
   40d45:	ba b8 4c 04 00       	mov    $0x44cb8,%edx
   40d4a:	be da 01 00 00       	mov    $0x1da,%esi
   40d4f:	bf c8 49 04 00       	mov    $0x449c8,%edi
   40d54:	e8 9f 15 00 00       	call   422f8 <assert_fail>
    if (level < 3) {
   40d59:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   40d5d:	7f 5b                	jg     40dba <check_page_table_ownership_level+0xf5>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   40d5f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   40d66:	eb 49                	jmp    40db1 <check_page_table_ownership_level+0xec>
            if (pt->entry[index]) {
   40d68:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40d6c:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40d6f:	48 63 d2             	movslq %edx,%rdx
   40d72:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   40d76:	48 85 c0             	test   %rax,%rax
   40d79:	74 32                	je     40dad <check_page_table_ownership_level+0xe8>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   40d7b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40d7f:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40d82:	48 63 d2             	movslq %edx,%rdx
   40d85:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   40d89:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   40d8f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   40d93:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40d96:	8d 70 01             	lea    0x1(%rax),%esi
   40d99:	8b 55 e0             	mov    -0x20(%rbp),%edx
   40d9c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40da0:	b9 01 00 00 00       	mov    $0x1,%ecx
   40da5:	48 89 c7             	mov    %rax,%rdi
   40da8:	e8 18 ff ff ff       	call   40cc5 <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   40dad:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   40db1:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   40db8:	7e ae                	jle    40d68 <check_page_table_ownership_level+0xa3>
            }
        }
    }
}
   40dba:	90                   	nop
   40dbb:	c9                   	leave  
   40dbc:	c3                   	ret    

0000000000040dbd <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   40dbd:	55                   	push   %rbp
   40dbe:	48 89 e5             	mov    %rsp,%rbp
   40dc1:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   40dc5:	8b 05 0d d3 00 00    	mov    0xd30d(%rip),%eax        # 4e0d8 <processes+0xd8>
   40dcb:	85 c0                	test   %eax,%eax
   40dcd:	74 14                	je     40de3 <check_virtual_memory+0x26>
   40dcf:	ba e8 4c 04 00       	mov    $0x44ce8,%edx
   40dd4:	be ed 01 00 00       	mov    $0x1ed,%esi
   40dd9:	bf c8 49 04 00       	mov    $0x449c8,%edi
   40dde:	e8 15 15 00 00       	call   422f8 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   40de3:	48 8b 05 16 02 01 00 	mov    0x10216(%rip),%rax        # 51000 <kernel_pagetable>
   40dea:	48 89 c7             	mov    %rax,%rdi
   40ded:	e8 dc fc ff ff       	call   40ace <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   40df2:	48 8b 05 07 02 01 00 	mov    0x10207(%rip),%rax        # 51000 <kernel_pagetable>
   40df9:	be ff ff ff ff       	mov    $0xffffffff,%esi
   40dfe:	48 89 c7             	mov    %rax,%rdi
   40e01:	e8 15 fe ff ff       	call   40c1b <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   40e06:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   40e0d:	e9 9c 00 00 00       	jmp    40eae <check_virtual_memory+0xf1>
        if (processes[pid].p_state != P_FREE
   40e12:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40e15:	48 63 d0             	movslq %eax,%rdx
   40e18:	48 89 d0             	mov    %rdx,%rax
   40e1b:	48 c1 e0 04          	shl    $0x4,%rax
   40e1f:	48 29 d0             	sub    %rdx,%rax
   40e22:	48 c1 e0 04          	shl    $0x4,%rax
   40e26:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   40e2c:	8b 00                	mov    (%rax),%eax
   40e2e:	85 c0                	test   %eax,%eax
   40e30:	74 78                	je     40eaa <check_virtual_memory+0xed>
            && processes[pid].p_pagetable != kernel_pagetable) {
   40e32:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40e35:	48 63 d0             	movslq %eax,%rdx
   40e38:	48 89 d0             	mov    %rdx,%rax
   40e3b:	48 c1 e0 04          	shl    $0x4,%rax
   40e3f:	48 29 d0             	sub    %rdx,%rax
   40e42:	48 c1 e0 04          	shl    $0x4,%rax
   40e46:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   40e4c:	48 8b 10             	mov    (%rax),%rdx
   40e4f:	48 8b 05 aa 01 01 00 	mov    0x101aa(%rip),%rax        # 51000 <kernel_pagetable>
   40e56:	48 39 c2             	cmp    %rax,%rdx
   40e59:	74 4f                	je     40eaa <check_virtual_memory+0xed>
            check_page_table_mappings(processes[pid].p_pagetable);
   40e5b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40e5e:	48 63 d0             	movslq %eax,%rdx
   40e61:	48 89 d0             	mov    %rdx,%rax
   40e64:	48 c1 e0 04          	shl    $0x4,%rax
   40e68:	48 29 d0             	sub    %rdx,%rax
   40e6b:	48 c1 e0 04          	shl    $0x4,%rax
   40e6f:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   40e75:	48 8b 00             	mov    (%rax),%rax
   40e78:	48 89 c7             	mov    %rax,%rdi
   40e7b:	e8 4e fc ff ff       	call   40ace <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   40e80:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40e83:	48 63 d0             	movslq %eax,%rdx
   40e86:	48 89 d0             	mov    %rdx,%rax
   40e89:	48 c1 e0 04          	shl    $0x4,%rax
   40e8d:	48 29 d0             	sub    %rdx,%rax
   40e90:	48 c1 e0 04          	shl    $0x4,%rax
   40e94:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   40e9a:	48 8b 00             	mov    (%rax),%rax
   40e9d:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40ea0:	89 d6                	mov    %edx,%esi
   40ea2:	48 89 c7             	mov    %rax,%rdi
   40ea5:	e8 71 fd ff ff       	call   40c1b <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   40eaa:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   40eae:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   40eb2:	0f 8e 5a ff ff ff    	jle    40e12 <check_virtual_memory+0x55>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   40eb8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   40ebf:	eb 67                	jmp    40f28 <check_virtual_memory+0x16b>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   40ec1:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40ec4:	48 98                	cltq   
   40ec6:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   40ecd:	00 
   40ece:	84 c0                	test   %al,%al
   40ed0:	7e 52                	jle    40f24 <check_virtual_memory+0x167>
   40ed2:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40ed5:	48 98                	cltq   
   40ed7:	0f b6 84 00 20 ef 04 	movzbl 0x4ef20(%rax,%rax,1),%eax
   40ede:	00 
   40edf:	84 c0                	test   %al,%al
   40ee1:	78 41                	js     40f24 <check_virtual_memory+0x167>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   40ee3:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40ee6:	48 98                	cltq   
   40ee8:	0f b6 84 00 20 ef 04 	movzbl 0x4ef20(%rax,%rax,1),%eax
   40eef:	00 
   40ef0:	0f be c0             	movsbl %al,%eax
   40ef3:	48 63 d0             	movslq %eax,%rdx
   40ef6:	48 89 d0             	mov    %rdx,%rax
   40ef9:	48 c1 e0 04          	shl    $0x4,%rax
   40efd:	48 29 d0             	sub    %rdx,%rax
   40f00:	48 c1 e0 04          	shl    $0x4,%rax
   40f04:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   40f0a:	8b 00                	mov    (%rax),%eax
   40f0c:	85 c0                	test   %eax,%eax
   40f0e:	75 14                	jne    40f24 <check_virtual_memory+0x167>
   40f10:	ba 08 4d 04 00       	mov    $0x44d08,%edx
   40f15:	be 04 02 00 00       	mov    $0x204,%esi
   40f1a:	bf c8 49 04 00       	mov    $0x449c8,%edi
   40f1f:	e8 d4 13 00 00       	call   422f8 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   40f24:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   40f28:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   40f2f:	7e 90                	jle    40ec1 <check_virtual_memory+0x104>
        }
    }
}
   40f31:	90                   	nop
   40f32:	90                   	nop
   40f33:	c9                   	leave  
   40f34:	c3                   	ret    

0000000000040f35 <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   40f35:	55                   	push   %rbp
   40f36:	48 89 e5             	mov    %rsp,%rbp
   40f39:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   40f3d:	ba 38 4d 04 00       	mov    $0x44d38,%edx
   40f42:	be 00 0f 00 00       	mov    $0xf00,%esi
   40f47:	bf 20 00 00 00       	mov    $0x20,%edi
   40f4c:	b8 00 00 00 00       	mov    $0x0,%eax
   40f51:	e8 4f 38 00 00       	call   447a5 <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   40f56:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   40f5d:	e9 f8 00 00 00       	jmp    4105a <memshow_physical+0x125>
        if (pn % 64 == 0) {
   40f62:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40f65:	83 e0 3f             	and    $0x3f,%eax
   40f68:	85 c0                	test   %eax,%eax
   40f6a:	75 3c                	jne    40fa8 <memshow_physical+0x73>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   40f6c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40f6f:	c1 e0 0c             	shl    $0xc,%eax
   40f72:	89 c1                	mov    %eax,%ecx
   40f74:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40f77:	8d 50 3f             	lea    0x3f(%rax),%edx
   40f7a:	85 c0                	test   %eax,%eax
   40f7c:	0f 48 c2             	cmovs  %edx,%eax
   40f7f:	c1 f8 06             	sar    $0x6,%eax
   40f82:	8d 50 01             	lea    0x1(%rax),%edx
   40f85:	89 d0                	mov    %edx,%eax
   40f87:	c1 e0 02             	shl    $0x2,%eax
   40f8a:	01 d0                	add    %edx,%eax
   40f8c:	c1 e0 04             	shl    $0x4,%eax
   40f8f:	83 c0 03             	add    $0x3,%eax
   40f92:	ba 48 4d 04 00       	mov    $0x44d48,%edx
   40f97:	be 00 0f 00 00       	mov    $0xf00,%esi
   40f9c:	89 c7                	mov    %eax,%edi
   40f9e:	b8 00 00 00 00       	mov    $0x0,%eax
   40fa3:	e8 fd 37 00 00       	call   447a5 <console_printf>
        }

        int owner = pageinfo[pn].owner;
   40fa8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40fab:	48 98                	cltq   
   40fad:	0f b6 84 00 20 ef 04 	movzbl 0x4ef20(%rax,%rax,1),%eax
   40fb4:	00 
   40fb5:	0f be c0             	movsbl %al,%eax
   40fb8:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   40fbb:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40fbe:	48 98                	cltq   
   40fc0:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   40fc7:	00 
   40fc8:	84 c0                	test   %al,%al
   40fca:	75 07                	jne    40fd3 <memshow_physical+0x9e>
            owner = PO_FREE;
   40fcc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   40fd3:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40fd6:	83 c0 02             	add    $0x2,%eax
   40fd9:	48 98                	cltq   
   40fdb:	0f b7 84 00 60 49 04 	movzwl 0x44960(%rax,%rax,1),%eax
   40fe2:	00 
   40fe3:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   40fe7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40fea:	48 98                	cltq   
   40fec:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   40ff3:	00 
   40ff4:	3c 01                	cmp    $0x1,%al
   40ff6:	7e 1a                	jle    41012 <memshow_physical+0xdd>
   40ff8:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   40ffd:	48 c1 e8 0c          	shr    $0xc,%rax
   41001:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   41004:	74 0c                	je     41012 <memshow_physical+0xdd>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   41006:	b8 53 00 00 00       	mov    $0x53,%eax
   4100b:	80 cc 0f             	or     $0xf,%ah
   4100e:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   41012:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41015:	8d 50 3f             	lea    0x3f(%rax),%edx
   41018:	85 c0                	test   %eax,%eax
   4101a:	0f 48 c2             	cmovs  %edx,%eax
   4101d:	c1 f8 06             	sar    $0x6,%eax
   41020:	8d 50 01             	lea    0x1(%rax),%edx
   41023:	89 d0                	mov    %edx,%eax
   41025:	c1 e0 02             	shl    $0x2,%eax
   41028:	01 d0                	add    %edx,%eax
   4102a:	c1 e0 04             	shl    $0x4,%eax
   4102d:	89 c1                	mov    %eax,%ecx
   4102f:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41032:	89 d0                	mov    %edx,%eax
   41034:	c1 f8 1f             	sar    $0x1f,%eax
   41037:	c1 e8 1a             	shr    $0x1a,%eax
   4103a:	01 c2                	add    %eax,%edx
   4103c:	83 e2 3f             	and    $0x3f,%edx
   4103f:	29 c2                	sub    %eax,%edx
   41041:	89 d0                	mov    %edx,%eax
   41043:	83 c0 0c             	add    $0xc,%eax
   41046:	01 c8                	add    %ecx,%eax
   41048:	48 98                	cltq   
   4104a:	0f b7 55 f6          	movzwl -0xa(%rbp),%edx
   4104e:	66 89 94 00 00 80 0b 	mov    %dx,0xb8000(%rax,%rax,1)
   41055:	00 
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41056:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4105a:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41061:	0f 8e fb fe ff ff    	jle    40f62 <memshow_physical+0x2d>
    }
}
   41067:	90                   	nop
   41068:	90                   	nop
   41069:	c9                   	leave  
   4106a:	c3                   	ret    

000000000004106b <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   4106b:	55                   	push   %rbp
   4106c:	48 89 e5             	mov    %rsp,%rbp
   4106f:	48 83 ec 40          	sub    $0x40,%rsp
   41073:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   41077:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   4107b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4107f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   41085:	48 89 c2             	mov    %rax,%rdx
   41088:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4108c:	48 39 c2             	cmp    %rax,%rdx
   4108f:	74 14                	je     410a5 <memshow_virtual+0x3a>
   41091:	ba 50 4d 04 00       	mov    $0x44d50,%edx
   41096:	be 35 02 00 00       	mov    $0x235,%esi
   4109b:	bf c8 49 04 00       	mov    $0x449c8,%edi
   410a0:	e8 53 12 00 00       	call   422f8 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   410a5:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   410a9:	48 89 c1             	mov    %rax,%rcx
   410ac:	ba 7d 4d 04 00       	mov    $0x44d7d,%edx
   410b1:	be 00 0f 00 00       	mov    $0xf00,%esi
   410b6:	bf 3a 03 00 00       	mov    $0x33a,%edi
   410bb:	b8 00 00 00 00       	mov    $0x0,%eax
   410c0:	e8 e0 36 00 00       	call   447a5 <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   410c5:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   410cc:	00 
   410cd:	e9 80 01 00 00       	jmp    41252 <memshow_virtual+0x1e7>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   410d2:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   410d6:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   410da:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   410de:	48 89 ce             	mov    %rcx,%rsi
   410e1:	48 89 c7             	mov    %rax,%rdi
   410e4:	e8 d1 18 00 00       	call   429ba <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   410e9:	8b 45 d0             	mov    -0x30(%rbp),%eax
   410ec:	85 c0                	test   %eax,%eax
   410ee:	79 0b                	jns    410fb <memshow_virtual+0x90>
            color = ' ';
   410f0:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   410f6:	e9 d7 00 00 00       	jmp    411d2 <memshow_virtual+0x167>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   410fb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   410ff:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   41105:	76 14                	jbe    4111b <memshow_virtual+0xb0>
   41107:	ba 9a 4d 04 00       	mov    $0x44d9a,%edx
   4110c:	be 3e 02 00 00       	mov    $0x23e,%esi
   41111:	bf c8 49 04 00       	mov    $0x449c8,%edi
   41116:	e8 dd 11 00 00       	call   422f8 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   4111b:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4111e:	48 98                	cltq   
   41120:	0f b6 84 00 20 ef 04 	movzbl 0x4ef20(%rax,%rax,1),%eax
   41127:	00 
   41128:	0f be c0             	movsbl %al,%eax
   4112b:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   4112e:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41131:	48 98                	cltq   
   41133:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   4113a:	00 
   4113b:	84 c0                	test   %al,%al
   4113d:	75 07                	jne    41146 <memshow_virtual+0xdb>
                owner = PO_FREE;
   4113f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   41146:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41149:	83 c0 02             	add    $0x2,%eax
   4114c:	48 98                	cltq   
   4114e:	0f b7 84 00 60 49 04 	movzwl 0x44960(%rax,%rax,1),%eax
   41155:	00 
   41156:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   4115a:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4115d:	48 98                	cltq   
   4115f:	83 e0 04             	and    $0x4,%eax
   41162:	48 85 c0             	test   %rax,%rax
   41165:	74 27                	je     4118e <memshow_virtual+0x123>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41167:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4116b:	c1 e0 04             	shl    $0x4,%eax
   4116e:	66 25 00 f0          	and    $0xf000,%ax
   41172:	89 c2                	mov    %eax,%edx
   41174:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41178:	c1 f8 04             	sar    $0x4,%eax
   4117b:	66 25 00 0f          	and    $0xf00,%ax
   4117f:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   41181:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41185:	0f b6 c0             	movzbl %al,%eax
   41188:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   4118a:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   4118e:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41191:	48 98                	cltq   
   41193:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   4119a:	00 
   4119b:	3c 01                	cmp    $0x1,%al
   4119d:	7e 33                	jle    411d2 <memshow_virtual+0x167>
   4119f:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   411a4:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   411a8:	74 28                	je     411d2 <memshow_virtual+0x167>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   411aa:	b8 53 00 00 00       	mov    $0x53,%eax
   411af:	89 c2                	mov    %eax,%edx
   411b1:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   411b5:	66 25 00 f0          	and    $0xf000,%ax
   411b9:	09 d0                	or     %edx,%eax
   411bb:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   411bf:	8b 45 e0             	mov    -0x20(%rbp),%eax
   411c2:	48 98                	cltq   
   411c4:	83 e0 04             	and    $0x4,%eax
   411c7:	48 85 c0             	test   %rax,%rax
   411ca:	75 06                	jne    411d2 <memshow_virtual+0x167>
                    color = color | 0x0F00;
   411cc:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   411d2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   411d6:	48 c1 e8 0c          	shr    $0xc,%rax
   411da:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   411dd:	8b 45 ec             	mov    -0x14(%rbp),%eax
   411e0:	83 e0 3f             	and    $0x3f,%eax
   411e3:	85 c0                	test   %eax,%eax
   411e5:	75 34                	jne    4121b <memshow_virtual+0x1b0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   411e7:	8b 45 ec             	mov    -0x14(%rbp),%eax
   411ea:	c1 e8 06             	shr    $0x6,%eax
   411ed:	89 c2                	mov    %eax,%edx
   411ef:	89 d0                	mov    %edx,%eax
   411f1:	c1 e0 02             	shl    $0x2,%eax
   411f4:	01 d0                	add    %edx,%eax
   411f6:	c1 e0 04             	shl    $0x4,%eax
   411f9:	05 73 03 00 00       	add    $0x373,%eax
   411fe:	89 c7                	mov    %eax,%edi
   41200:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41204:	48 89 c1             	mov    %rax,%rcx
   41207:	ba 48 4d 04 00       	mov    $0x44d48,%edx
   4120c:	be 00 0f 00 00       	mov    $0xf00,%esi
   41211:	b8 00 00 00 00       	mov    $0x0,%eax
   41216:	e8 8a 35 00 00       	call   447a5 <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   4121b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4121e:	c1 e8 06             	shr    $0x6,%eax
   41221:	89 c2                	mov    %eax,%edx
   41223:	89 d0                	mov    %edx,%eax
   41225:	c1 e0 02             	shl    $0x2,%eax
   41228:	01 d0                	add    %edx,%eax
   4122a:	c1 e0 04             	shl    $0x4,%eax
   4122d:	89 c2                	mov    %eax,%edx
   4122f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41232:	83 e0 3f             	and    $0x3f,%eax
   41235:	01 d0                	add    %edx,%eax
   41237:	05 7c 03 00 00       	add    $0x37c,%eax
   4123c:	89 c2                	mov    %eax,%edx
   4123e:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41242:	66 89 84 12 00 80 0b 	mov    %ax,0xb8000(%rdx,%rdx,1)
   41249:	00 
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   4124a:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41251:	00 
   41252:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   41259:	00 
   4125a:	0f 86 72 fe ff ff    	jbe    410d2 <memshow_virtual+0x67>
    }
}
   41260:	90                   	nop
   41261:	90                   	nop
   41262:	c9                   	leave  
   41263:	c3                   	ret    

0000000000041264 <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   41264:	55                   	push   %rbp
   41265:	48 89 e5             	mov    %rsp,%rbp
   41268:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   4126c:	8b 05 b2 e0 00 00    	mov    0xe0b2(%rip),%eax        # 4f324 <last_ticks.1>
   41272:	85 c0                	test   %eax,%eax
   41274:	74 13                	je     41289 <memshow_virtual_animate+0x25>
   41276:	8b 15 a4 e0 00 00    	mov    0xe0a4(%rip),%edx        # 4f320 <ticks>
   4127c:	8b 05 a2 e0 00 00    	mov    0xe0a2(%rip),%eax        # 4f324 <last_ticks.1>
   41282:	29 c2                	sub    %eax,%edx
   41284:	83 fa 31             	cmp    $0x31,%edx
   41287:	76 2c                	jbe    412b5 <memshow_virtual_animate+0x51>
        last_ticks = ticks;
   41289:	8b 05 91 e0 00 00    	mov    0xe091(%rip),%eax        # 4f320 <ticks>
   4128f:	89 05 8f e0 00 00    	mov    %eax,0xe08f(%rip)        # 4f324 <last_ticks.1>
        ++showing;
   41295:	8b 05 69 4d 00 00    	mov    0x4d69(%rip),%eax        # 46004 <showing.0>
   4129b:	83 c0 01             	add    $0x1,%eax
   4129e:	89 05 60 4d 00 00    	mov    %eax,0x4d60(%rip)        # 46004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   412a4:	eb 0f                	jmp    412b5 <memshow_virtual_animate+0x51>
           && processes[showing % NPROC].p_state == P_FREE) {
        ++showing;
   412a6:	8b 05 58 4d 00 00    	mov    0x4d58(%rip),%eax        # 46004 <showing.0>
   412ac:	83 c0 01             	add    $0x1,%eax
   412af:	89 05 4f 4d 00 00    	mov    %eax,0x4d4f(%rip)        # 46004 <showing.0>
    while (showing <= 2*NPROC
   412b5:	8b 05 49 4d 00 00    	mov    0x4d49(%rip),%eax        # 46004 <showing.0>
           && processes[showing % NPROC].p_state == P_FREE) {
   412bb:	83 f8 20             	cmp    $0x20,%eax
   412be:	7f 34                	jg     412f4 <memshow_virtual_animate+0x90>
   412c0:	8b 15 3e 4d 00 00    	mov    0x4d3e(%rip),%edx        # 46004 <showing.0>
   412c6:	89 d0                	mov    %edx,%eax
   412c8:	c1 f8 1f             	sar    $0x1f,%eax
   412cb:	c1 e8 1c             	shr    $0x1c,%eax
   412ce:	01 c2                	add    %eax,%edx
   412d0:	83 e2 0f             	and    $0xf,%edx
   412d3:	29 c2                	sub    %eax,%edx
   412d5:	89 d0                	mov    %edx,%eax
   412d7:	48 63 d0             	movslq %eax,%rdx
   412da:	48 89 d0             	mov    %rdx,%rax
   412dd:	48 c1 e0 04          	shl    $0x4,%rax
   412e1:	48 29 d0             	sub    %rdx,%rax
   412e4:	48 c1 e0 04          	shl    $0x4,%rax
   412e8:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   412ee:	8b 00                	mov    (%rax),%eax
   412f0:	85 c0                	test   %eax,%eax
   412f2:	74 b2                	je     412a6 <memshow_virtual_animate+0x42>
    }
    showing = showing % NPROC;
   412f4:	8b 15 0a 4d 00 00    	mov    0x4d0a(%rip),%edx        # 46004 <showing.0>
   412fa:	89 d0                	mov    %edx,%eax
   412fc:	c1 f8 1f             	sar    $0x1f,%eax
   412ff:	c1 e8 1c             	shr    $0x1c,%eax
   41302:	01 c2                	add    %eax,%edx
   41304:	83 e2 0f             	and    $0xf,%edx
   41307:	29 c2                	sub    %eax,%edx
   41309:	89 d0                	mov    %edx,%eax
   4130b:	89 05 f3 4c 00 00    	mov    %eax,0x4cf3(%rip)        # 46004 <showing.0>

    if (processes[showing].p_state != P_FREE && processes[showing].display_status) {
   41311:	8b 05 ed 4c 00 00    	mov    0x4ced(%rip),%eax        # 46004 <showing.0>
   41317:	48 63 d0             	movslq %eax,%rdx
   4131a:	48 89 d0             	mov    %rdx,%rax
   4131d:	48 c1 e0 04          	shl    $0x4,%rax
   41321:	48 29 d0             	sub    %rdx,%rax
   41324:	48 c1 e0 04          	shl    $0x4,%rax
   41328:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   4132e:	8b 00                	mov    (%rax),%eax
   41330:	85 c0                	test   %eax,%eax
   41332:	74 76                	je     413aa <memshow_virtual_animate+0x146>
   41334:	8b 05 ca 4c 00 00    	mov    0x4cca(%rip),%eax        # 46004 <showing.0>
   4133a:	48 63 d0             	movslq %eax,%rdx
   4133d:	48 89 d0             	mov    %rdx,%rax
   41340:	48 c1 e0 04          	shl    $0x4,%rax
   41344:	48 29 d0             	sub    %rdx,%rax
   41347:	48 c1 e0 04          	shl    $0x4,%rax
   4134b:	48 05 e8 e0 04 00    	add    $0x4e0e8,%rax
   41351:	0f b6 00             	movzbl (%rax),%eax
   41354:	84 c0                	test   %al,%al
   41356:	74 52                	je     413aa <memshow_virtual_animate+0x146>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   41358:	8b 15 a6 4c 00 00    	mov    0x4ca6(%rip),%edx        # 46004 <showing.0>
   4135e:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   41362:	89 d1                	mov    %edx,%ecx
   41364:	ba b4 4d 04 00       	mov    $0x44db4,%edx
   41369:	be 04 00 00 00       	mov    $0x4,%esi
   4136e:	48 89 c7             	mov    %rax,%rdi
   41371:	b8 00 00 00 00       	mov    $0x0,%eax
   41376:	e8 36 35 00 00       	call   448b1 <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   4137b:	8b 05 83 4c 00 00    	mov    0x4c83(%rip),%eax        # 46004 <showing.0>
   41381:	48 63 d0             	movslq %eax,%rdx
   41384:	48 89 d0             	mov    %rdx,%rax
   41387:	48 c1 e0 04          	shl    $0x4,%rax
   4138b:	48 29 d0             	sub    %rdx,%rax
   4138e:	48 c1 e0 04          	shl    $0x4,%rax
   41392:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   41398:	48 8b 00             	mov    (%rax),%rax
   4139b:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   4139f:	48 89 d6             	mov    %rdx,%rsi
   413a2:	48 89 c7             	mov    %rax,%rdi
   413a5:	e8 c1 fc ff ff       	call   4106b <memshow_virtual>
    }
}
   413aa:	90                   	nop
   413ab:	c9                   	leave  
   413ac:	c3                   	ret    

00000000000413ad <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   413ad:	55                   	push   %rbp
   413ae:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   413b1:	e8 4f 01 00 00       	call   41505 <segments_init>
    interrupt_init();
   413b6:	e8 d0 03 00 00       	call   4178b <interrupt_init>
    virtual_memory_init();
   413bb:	e8 f3 0f 00 00       	call   423b3 <virtual_memory_init>
}
   413c0:	90                   	nop
   413c1:	5d                   	pop    %rbp
   413c2:	c3                   	ret    

00000000000413c3 <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   413c3:	55                   	push   %rbp
   413c4:	48 89 e5             	mov    %rsp,%rbp
   413c7:	48 83 ec 18          	sub    $0x18,%rsp
   413cb:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   413cf:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   413d3:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   413d6:	8b 45 ec             	mov    -0x14(%rbp),%eax
   413d9:	48 98                	cltq   
   413db:	48 c1 e0 2d          	shl    $0x2d,%rax
   413df:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   413e3:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   413ea:	90 00 00 
   413ed:	48 09 c2             	or     %rax,%rdx
    *segment = type
   413f0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   413f4:	48 89 10             	mov    %rdx,(%rax)
}
   413f7:	90                   	nop
   413f8:	c9                   	leave  
   413f9:	c3                   	ret    

00000000000413fa <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   413fa:	55                   	push   %rbp
   413fb:	48 89 e5             	mov    %rsp,%rbp
   413fe:	48 83 ec 28          	sub    $0x28,%rsp
   41402:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41406:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   4140a:	89 55 ec             	mov    %edx,-0x14(%rbp)
   4140d:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   41411:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41415:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41419:	48 c1 e0 10          	shl    $0x10,%rax
   4141d:	48 89 c2             	mov    %rax,%rdx
   41420:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   41427:	00 00 00 
   4142a:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   4142d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41431:	48 c1 e0 20          	shl    $0x20,%rax
   41435:	48 89 c1             	mov    %rax,%rcx
   41438:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   4143f:	00 00 ff 
   41442:	48 21 c8             	and    %rcx,%rax
   41445:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   41448:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4144c:	48 83 e8 01          	sub    $0x1,%rax
   41450:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   41453:	48 09 d0             	or     %rdx,%rax
        | type
   41456:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   4145a:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4145d:	48 63 d2             	movslq %edx,%rdx
   41460:	48 c1 e2 2d          	shl    $0x2d,%rdx
   41464:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   41467:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   4146e:	80 00 00 
   41471:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41474:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41478:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   4147b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4147f:	48 83 c0 08          	add    $0x8,%rax
   41483:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   41487:	48 c1 ea 20          	shr    $0x20,%rdx
   4148b:	48 89 10             	mov    %rdx,(%rax)
}
   4148e:	90                   	nop
   4148f:	c9                   	leave  
   41490:	c3                   	ret    

0000000000041491 <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   41491:	55                   	push   %rbp
   41492:	48 89 e5             	mov    %rsp,%rbp
   41495:	48 83 ec 20          	sub    $0x20,%rsp
   41499:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4149d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   414a1:	89 55 ec             	mov    %edx,-0x14(%rbp)
   414a4:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   414a8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   414ac:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   414af:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   414b3:	8b 55 ec             	mov    -0x14(%rbp),%edx
   414b6:	48 63 d2             	movslq %edx,%rdx
   414b9:	48 c1 e2 2d          	shl    $0x2d,%rdx
   414bd:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   414c0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   414c4:	48 c1 e0 20          	shl    $0x20,%rax
   414c8:	48 89 c1             	mov    %rax,%rcx
   414cb:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   414d2:	00 ff ff 
   414d5:	48 21 c8             	and    %rcx,%rax
   414d8:	48 09 c2             	or     %rax,%rdx
   414db:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   414e2:	80 00 00 
   414e5:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   414e8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   414ec:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   414ef:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   414f3:	48 c1 e8 20          	shr    $0x20,%rax
   414f7:	48 89 c2             	mov    %rax,%rdx
   414fa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   414fe:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   41502:	90                   	nop
   41503:	c9                   	leave  
   41504:	c3                   	ret    

0000000000041505 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   41505:	55                   	push   %rbp
   41506:	48 89 e5             	mov    %rsp,%rbp
   41509:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   4150d:	48 c7 05 28 de 00 00 	movq   $0x0,0xde28(%rip)        # 4f340 <segments>
   41514:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   41518:	ba 00 00 00 00       	mov    $0x0,%edx
   4151d:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41524:	08 20 00 
   41527:	48 89 c6             	mov    %rax,%rsi
   4152a:	bf 48 f3 04 00       	mov    $0x4f348,%edi
   4152f:	e8 8f fe ff ff       	call   413c3 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   41534:	ba 03 00 00 00       	mov    $0x3,%edx
   41539:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41540:	08 20 00 
   41543:	48 89 c6             	mov    %rax,%rsi
   41546:	bf 50 f3 04 00       	mov    $0x4f350,%edi
   4154b:	e8 73 fe ff ff       	call   413c3 <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   41550:	ba 00 00 00 00       	mov    $0x0,%edx
   41555:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   4155c:	02 00 00 
   4155f:	48 89 c6             	mov    %rax,%rsi
   41562:	bf 58 f3 04 00       	mov    $0x4f358,%edi
   41567:	e8 57 fe ff ff       	call   413c3 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   4156c:	ba 03 00 00 00       	mov    $0x3,%edx
   41571:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41578:	02 00 00 
   4157b:	48 89 c6             	mov    %rax,%rsi
   4157e:	bf 60 f3 04 00       	mov    $0x4f360,%edi
   41583:	e8 3b fe ff ff       	call   413c3 <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   41588:	b8 80 03 05 00       	mov    $0x50380,%eax
   4158d:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   41593:	48 89 c1             	mov    %rax,%rcx
   41596:	ba 00 00 00 00       	mov    $0x0,%edx
   4159b:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   415a2:	09 00 00 
   415a5:	48 89 c6             	mov    %rax,%rsi
   415a8:	bf 68 f3 04 00       	mov    $0x4f368,%edi
   415ad:	e8 48 fe ff ff       	call   413fa <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   415b2:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   415b8:	b8 40 f3 04 00       	mov    $0x4f340,%eax
   415bd:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   415c1:	ba 60 00 00 00       	mov    $0x60,%edx
   415c6:	be 00 00 00 00       	mov    $0x0,%esi
   415cb:	bf 80 03 05 00       	mov    $0x50380,%edi
   415d0:	e8 19 24 00 00       	call   439ee <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   415d5:	48 c7 05 a4 ed 00 00 	movq   $0x80000,0xeda4(%rip)        # 50384 <kernel_task_descriptor+0x4>
   415dc:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   415e0:	ba 00 10 00 00       	mov    $0x1000,%edx
   415e5:	be 00 00 00 00       	mov    $0x0,%esi
   415ea:	bf 80 f3 04 00       	mov    $0x4f380,%edi
   415ef:	e8 fa 23 00 00       	call   439ee <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   415f4:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   415fb:	eb 30                	jmp    4162d <segments_init+0x128>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   415fd:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   41602:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41605:	48 c1 e0 04          	shl    $0x4,%rax
   41609:	48 05 80 f3 04 00    	add    $0x4f380,%rax
   4160f:	48 89 d1             	mov    %rdx,%rcx
   41612:	ba 00 00 00 00       	mov    $0x0,%edx
   41617:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   4161e:	0e 00 00 
   41621:	48 89 c7             	mov    %rax,%rdi
   41624:	e8 68 fe ff ff       	call   41491 <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41629:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4162d:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   41634:	76 c7                	jbe    415fd <segments_init+0xf8>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   41636:	b8 36 00 04 00       	mov    $0x40036,%eax
   4163b:	48 89 c1             	mov    %rax,%rcx
   4163e:	ba 00 00 00 00       	mov    $0x0,%edx
   41643:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   4164a:	0e 00 00 
   4164d:	48 89 c6             	mov    %rax,%rsi
   41650:	bf 80 f5 04 00       	mov    $0x4f580,%edi
   41655:	e8 37 fe ff ff       	call   41491 <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   4165a:	b8 2e 00 04 00       	mov    $0x4002e,%eax
   4165f:	48 89 c1             	mov    %rax,%rcx
   41662:	ba 00 00 00 00       	mov    $0x0,%edx
   41667:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   4166e:	0e 00 00 
   41671:	48 89 c6             	mov    %rax,%rsi
   41674:	bf 50 f4 04 00       	mov    $0x4f450,%edi
   41679:	e8 13 fe ff ff       	call   41491 <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   4167e:	b8 32 00 04 00       	mov    $0x40032,%eax
   41683:	48 89 c1             	mov    %rax,%rcx
   41686:	ba 00 00 00 00       	mov    $0x0,%edx
   4168b:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41692:	0e 00 00 
   41695:	48 89 c6             	mov    %rax,%rsi
   41698:	bf 60 f4 04 00       	mov    $0x4f460,%edi
   4169d:	e8 ef fd ff ff       	call   41491 <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   416a2:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   416a9:	eb 3e                	jmp    416e9 <segments_init+0x1e4>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   416ab:	8b 45 f8             	mov    -0x8(%rbp),%eax
   416ae:	83 e8 30             	sub    $0x30,%eax
   416b1:	89 c0                	mov    %eax,%eax
   416b3:	48 8b 04 c5 e7 00 04 	mov    0x400e7(,%rax,8),%rax
   416ba:	00 
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   416bb:	48 89 c2             	mov    %rax,%rdx
   416be:	8b 45 f8             	mov    -0x8(%rbp),%eax
   416c1:	48 c1 e0 04          	shl    $0x4,%rax
   416c5:	48 05 80 f3 04 00    	add    $0x4f380,%rax
   416cb:	48 89 d1             	mov    %rdx,%rcx
   416ce:	ba 03 00 00 00       	mov    $0x3,%edx
   416d3:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   416da:	0e 00 00 
   416dd:	48 89 c7             	mov    %rax,%rdi
   416e0:	e8 ac fd ff ff       	call   41491 <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   416e5:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   416e9:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   416ed:	76 bc                	jbe    416ab <segments_init+0x1a6>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   416ef:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   416f5:	b8 80 f3 04 00       	mov    $0x4f380,%eax
   416fa:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   416fe:	b8 28 00 00 00       	mov    $0x28,%eax
   41703:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   41707:	0f 00 d8             	ltr    %ax
   4170a:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   4170e:	0f 20 c0             	mov    %cr0,%rax
   41711:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   41715:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   41719:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   4171c:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   41723:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41726:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   41729:	8b 45 f0             	mov    -0x10(%rbp),%eax
   4172c:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   41730:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41734:	0f 22 c0             	mov    %rax,%cr0
}
   41737:	90                   	nop
    lcr0(cr0);
}
   41738:	90                   	nop
   41739:	c9                   	leave  
   4173a:	c3                   	ret    

000000000004173b <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   4173b:	55                   	push   %rbp
   4173c:	48 89 e5             	mov    %rsp,%rbp
   4173f:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   41743:	0f b7 05 96 ec 00 00 	movzwl 0xec96(%rip),%eax        # 503e0 <interrupts_enabled>
   4174a:	f7 d0                	not    %eax
   4174c:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   41750:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41754:	0f b6 c0             	movzbl %al,%eax
   41757:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   4175e:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41761:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   41765:	8b 55 f0             	mov    -0x10(%rbp),%edx
   41768:	ee                   	out    %al,(%dx)
}
   41769:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   4176a:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   4176e:	66 c1 e8 08          	shr    $0x8,%ax
   41772:	0f b6 c0             	movzbl %al,%eax
   41775:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   4177c:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4177f:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   41783:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41786:	ee                   	out    %al,(%dx)
}
   41787:	90                   	nop
}
   41788:	90                   	nop
   41789:	c9                   	leave  
   4178a:	c3                   	ret    

000000000004178b <interrupt_init>:

void interrupt_init(void) {
   4178b:	55                   	push   %rbp
   4178c:	48 89 e5             	mov    %rsp,%rbp
   4178f:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   41793:	66 c7 05 44 ec 00 00 	movw   $0x0,0xec44(%rip)        # 503e0 <interrupts_enabled>
   4179a:	00 00 
    interrupt_mask();
   4179c:	e8 9a ff ff ff       	call   4173b <interrupt_mask>
   417a1:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   417a8:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   417ac:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   417b0:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   417b3:	ee                   	out    %al,(%dx)
}
   417b4:	90                   	nop
   417b5:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   417bc:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   417c0:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   417c4:	8b 55 ac             	mov    -0x54(%rbp),%edx
   417c7:	ee                   	out    %al,(%dx)
}
   417c8:	90                   	nop
   417c9:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   417d0:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   417d4:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   417d8:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   417db:	ee                   	out    %al,(%dx)
}
   417dc:	90                   	nop
   417dd:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   417e4:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   417e8:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   417ec:	8b 55 bc             	mov    -0x44(%rbp),%edx
   417ef:	ee                   	out    %al,(%dx)
}
   417f0:	90                   	nop
   417f1:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   417f8:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   417fc:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   41800:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   41803:	ee                   	out    %al,(%dx)
}
   41804:	90                   	nop
   41805:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   4180c:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41810:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   41814:	8b 55 cc             	mov    -0x34(%rbp),%edx
   41817:	ee                   	out    %al,(%dx)
}
   41818:	90                   	nop
   41819:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   41820:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41824:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   41828:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   4182b:	ee                   	out    %al,(%dx)
}
   4182c:	90                   	nop
   4182d:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   41834:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41838:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   4183c:	8b 55 dc             	mov    -0x24(%rbp),%edx
   4183f:	ee                   	out    %al,(%dx)
}
   41840:	90                   	nop
   41841:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   41848:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4184c:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41850:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41853:	ee                   	out    %al,(%dx)
}
   41854:	90                   	nop
   41855:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   4185c:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41860:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41864:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41867:	ee                   	out    %al,(%dx)
}
   41868:	90                   	nop
   41869:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   41870:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41874:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41878:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4187b:	ee                   	out    %al,(%dx)
}
   4187c:	90                   	nop
   4187d:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   41884:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41888:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4188c:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4188f:	ee                   	out    %al,(%dx)
}
   41890:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   41891:	e8 a5 fe ff ff       	call   4173b <interrupt_mask>
}
   41896:	90                   	nop
   41897:	c9                   	leave  
   41898:	c3                   	ret    

0000000000041899 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   41899:	55                   	push   %rbp
   4189a:	48 89 e5             	mov    %rsp,%rbp
   4189d:	48 83 ec 28          	sub    $0x28,%rsp
   418a1:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   418a4:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   418a8:	0f 8e 9e 00 00 00    	jle    4194c <timer_init+0xb3>
   418ae:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   418b5:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   418b9:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   418bd:	8b 55 ec             	mov    -0x14(%rbp),%edx
   418c0:	ee                   	out    %al,(%dx)
}
   418c1:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   418c2:	8b 45 dc             	mov    -0x24(%rbp),%eax
   418c5:	89 c2                	mov    %eax,%edx
   418c7:	c1 ea 1f             	shr    $0x1f,%edx
   418ca:	01 d0                	add    %edx,%eax
   418cc:	d1 f8                	sar    %eax
   418ce:	05 de 34 12 00       	add    $0x1234de,%eax
   418d3:	99                   	cltd   
   418d4:	f7 7d dc             	idivl  -0x24(%rbp)
   418d7:	89 c2                	mov    %eax,%edx
   418d9:	89 d0                	mov    %edx,%eax
   418db:	c1 f8 1f             	sar    $0x1f,%eax
   418de:	c1 e8 18             	shr    $0x18,%eax
   418e1:	01 c2                	add    %eax,%edx
   418e3:	0f b6 d2             	movzbl %dl,%edx
   418e6:	29 c2                	sub    %eax,%edx
   418e8:	89 d0                	mov    %edx,%eax
   418ea:	0f b6 c0             	movzbl %al,%eax
   418ed:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   418f4:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   418f7:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   418fb:	8b 55 f4             	mov    -0xc(%rbp),%edx
   418fe:	ee                   	out    %al,(%dx)
}
   418ff:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   41900:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41903:	89 c2                	mov    %eax,%edx
   41905:	c1 ea 1f             	shr    $0x1f,%edx
   41908:	01 d0                	add    %edx,%eax
   4190a:	d1 f8                	sar    %eax
   4190c:	05 de 34 12 00       	add    $0x1234de,%eax
   41911:	99                   	cltd   
   41912:	f7 7d dc             	idivl  -0x24(%rbp)
   41915:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   4191b:	85 c0                	test   %eax,%eax
   4191d:	0f 48 c2             	cmovs  %edx,%eax
   41920:	c1 f8 08             	sar    $0x8,%eax
   41923:	0f b6 c0             	movzbl %al,%eax
   41926:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   4192d:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41930:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41934:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41937:	ee                   	out    %al,(%dx)
}
   41938:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   41939:	0f b7 05 a0 ea 00 00 	movzwl 0xeaa0(%rip),%eax        # 503e0 <interrupts_enabled>
   41940:	83 c8 01             	or     $0x1,%eax
   41943:	66 89 05 96 ea 00 00 	mov    %ax,0xea96(%rip)        # 503e0 <interrupts_enabled>
   4194a:	eb 11                	jmp    4195d <timer_init+0xc4>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   4194c:	0f b7 05 8d ea 00 00 	movzwl 0xea8d(%rip),%eax        # 503e0 <interrupts_enabled>
   41953:	83 e0 fe             	and    $0xfffffffe,%eax
   41956:	66 89 05 83 ea 00 00 	mov    %ax,0xea83(%rip)        # 503e0 <interrupts_enabled>
    }
    interrupt_mask();
   4195d:	e8 d9 fd ff ff       	call   4173b <interrupt_mask>
}
   41962:	90                   	nop
   41963:	c9                   	leave  
   41964:	c3                   	ret    

0000000000041965 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   41965:	55                   	push   %rbp
   41966:	48 89 e5             	mov    %rsp,%rbp
   41969:	48 83 ec 08          	sub    $0x8,%rsp
   4196d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   41971:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   41976:	74 14                	je     4198c <physical_memory_isreserved+0x27>
   41978:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   4197f:	00 
   41980:	76 11                	jbe    41993 <physical_memory_isreserved+0x2e>
   41982:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   41989:	00 
   4198a:	77 07                	ja     41993 <physical_memory_isreserved+0x2e>
   4198c:	b8 01 00 00 00       	mov    $0x1,%eax
   41991:	eb 05                	jmp    41998 <physical_memory_isreserved+0x33>
   41993:	b8 00 00 00 00       	mov    $0x0,%eax
}
   41998:	c9                   	leave  
   41999:	c3                   	ret    

000000000004199a <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   4199a:	55                   	push   %rbp
   4199b:	48 89 e5             	mov    %rsp,%rbp
   4199e:	48 83 ec 10          	sub    $0x10,%rsp
   419a2:	89 7d fc             	mov    %edi,-0x4(%rbp)
   419a5:	89 75 f8             	mov    %esi,-0x8(%rbp)
   419a8:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   419ab:	8b 45 fc             	mov    -0x4(%rbp),%eax
   419ae:	c1 e0 10             	shl    $0x10,%eax
   419b1:	89 c2                	mov    %eax,%edx
   419b3:	8b 45 f8             	mov    -0x8(%rbp),%eax
   419b6:	c1 e0 0b             	shl    $0xb,%eax
   419b9:	09 c2                	or     %eax,%edx
   419bb:	8b 45 f4             	mov    -0xc(%rbp),%eax
   419be:	c1 e0 08             	shl    $0x8,%eax
   419c1:	09 d0                	or     %edx,%eax
}
   419c3:	c9                   	leave  
   419c4:	c3                   	ret    

00000000000419c5 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   419c5:	55                   	push   %rbp
   419c6:	48 89 e5             	mov    %rsp,%rbp
   419c9:	48 83 ec 18          	sub    $0x18,%rsp
   419cd:	89 7d ec             	mov    %edi,-0x14(%rbp)
   419d0:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   419d3:	8b 55 ec             	mov    -0x14(%rbp),%edx
   419d6:	8b 45 e8             	mov    -0x18(%rbp),%eax
   419d9:	09 d0                	or     %edx,%eax
   419db:	0d 00 00 00 80       	or     $0x80000000,%eax
   419e0:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   419e7:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   419ea:	8b 45 f0             	mov    -0x10(%rbp),%eax
   419ed:	8b 55 f4             	mov    -0xc(%rbp),%edx
   419f0:	ef                   	out    %eax,(%dx)
}
   419f1:	90                   	nop
   419f2:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   419f9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   419fc:	89 c2                	mov    %eax,%edx
   419fe:	ed                   	in     (%dx),%eax
   419ff:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   41a02:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   41a05:	c9                   	leave  
   41a06:	c3                   	ret    

0000000000041a07 <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   41a07:	55                   	push   %rbp
   41a08:	48 89 e5             	mov    %rsp,%rbp
   41a0b:	48 83 ec 28          	sub    $0x28,%rsp
   41a0f:	89 7d dc             	mov    %edi,-0x24(%rbp)
   41a12:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   41a15:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41a1c:	eb 73                	jmp    41a91 <pci_find_device+0x8a>
        for (int slot = 0; slot != 32; ++slot) {
   41a1e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41a25:	eb 60                	jmp    41a87 <pci_find_device+0x80>
            for (int func = 0; func != 8; ++func) {
   41a27:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41a2e:	eb 4a                	jmp    41a7a <pci_find_device+0x73>
                int configaddr = pci_make_configaddr(bus, slot, func);
   41a30:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41a33:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41a36:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41a39:	89 ce                	mov    %ecx,%esi
   41a3b:	89 c7                	mov    %eax,%edi
   41a3d:	e8 58 ff ff ff       	call   4199a <pci_make_configaddr>
   41a42:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   41a45:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41a48:	be 00 00 00 00       	mov    $0x0,%esi
   41a4d:	89 c7                	mov    %eax,%edi
   41a4f:	e8 71 ff ff ff       	call   419c5 <pci_config_readl>
   41a54:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   41a57:	8b 45 d8             	mov    -0x28(%rbp),%eax
   41a5a:	c1 e0 10             	shl    $0x10,%eax
   41a5d:	0b 45 dc             	or     -0x24(%rbp),%eax
   41a60:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   41a63:	75 05                	jne    41a6a <pci_find_device+0x63>
                    return configaddr;
   41a65:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41a68:	eb 35                	jmp    41a9f <pci_find_device+0x98>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   41a6a:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   41a6e:	75 06                	jne    41a76 <pci_find_device+0x6f>
   41a70:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41a74:	74 0c                	je     41a82 <pci_find_device+0x7b>
            for (int func = 0; func != 8; ++func) {
   41a76:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41a7a:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   41a7e:	75 b0                	jne    41a30 <pci_find_device+0x29>
   41a80:	eb 01                	jmp    41a83 <pci_find_device+0x7c>
                    break;
   41a82:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   41a83:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41a87:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   41a8b:	75 9a                	jne    41a27 <pci_find_device+0x20>
    for (int bus = 0; bus != 256; ++bus) {
   41a8d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41a91:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   41a98:	75 84                	jne    41a1e <pci_find_device+0x17>
                }
            }
        }
    }
    return -1;
   41a9a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   41a9f:	c9                   	leave  
   41aa0:	c3                   	ret    

0000000000041aa1 <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   41aa1:	55                   	push   %rbp
   41aa2:	48 89 e5             	mov    %rsp,%rbp
   41aa5:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   41aa9:	be 13 71 00 00       	mov    $0x7113,%esi
   41aae:	bf 86 80 00 00       	mov    $0x8086,%edi
   41ab3:	e8 4f ff ff ff       	call   41a07 <pci_find_device>
   41ab8:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   41abb:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   41abf:	78 30                	js     41af1 <poweroff+0x50>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   41ac1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41ac4:	be 40 00 00 00       	mov    $0x40,%esi
   41ac9:	89 c7                	mov    %eax,%edi
   41acb:	e8 f5 fe ff ff       	call   419c5 <pci_config_readl>
   41ad0:	25 c0 ff 00 00       	and    $0xffc0,%eax
   41ad5:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   41ad8:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41adb:	83 c0 04             	add    $0x4,%eax
   41ade:	89 45 f4             	mov    %eax,-0xc(%rbp)
   41ae1:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   41ae7:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   41aeb:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41aee:	66 ef                	out    %ax,(%dx)
}
   41af0:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   41af1:	ba c0 4d 04 00       	mov    $0x44dc0,%edx
   41af6:	be 00 c0 00 00       	mov    $0xc000,%esi
   41afb:	bf 80 07 00 00       	mov    $0x780,%edi
   41b00:	b8 00 00 00 00       	mov    $0x0,%eax
   41b05:	e8 9b 2c 00 00       	call   447a5 <console_printf>
 spinloop: goto spinloop;
   41b0a:	eb fe                	jmp    41b0a <poweroff+0x69>

0000000000041b0c <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   41b0c:	55                   	push   %rbp
   41b0d:	48 89 e5             	mov    %rsp,%rbp
   41b10:	48 83 ec 10          	sub    $0x10,%rsp
   41b14:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   41b1b:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b1f:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41b23:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41b26:	ee                   	out    %al,(%dx)
}
   41b27:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   41b28:	eb fe                	jmp    41b28 <reboot+0x1c>

0000000000041b2a <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   41b2a:	55                   	push   %rbp
   41b2b:	48 89 e5             	mov    %rsp,%rbp
   41b2e:	48 83 ec 10          	sub    $0x10,%rsp
   41b32:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41b36:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   41b39:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41b3d:	48 83 c0 18          	add    $0x18,%rax
   41b41:	ba c0 00 00 00       	mov    $0xc0,%edx
   41b46:	be 00 00 00 00       	mov    $0x0,%esi
   41b4b:	48 89 c7             	mov    %rax,%rdi
   41b4e:	e8 9b 1e 00 00       	call   439ee <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   41b53:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41b57:	66 c7 80 b8 00 00 00 	movw   $0x13,0xb8(%rax)
   41b5e:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   41b60:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41b64:	48 c7 80 90 00 00 00 	movq   $0x23,0x90(%rax)
   41b6b:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   41b6f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41b73:	48 c7 80 98 00 00 00 	movq   $0x23,0x98(%rax)
   41b7a:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   41b7e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41b82:	66 c7 80 d0 00 00 00 	movw   $0x23,0xd0(%rax)
   41b89:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   41b8b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41b8f:	48 c7 80 c0 00 00 00 	movq   $0x200,0xc0(%rax)
   41b96:	00 02 00 00 

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   41b9a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41b9d:	83 e0 01             	and    $0x1,%eax
   41ba0:	85 c0                	test   %eax,%eax
   41ba2:	74 1c                	je     41bc0 <process_init+0x96>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   41ba4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ba8:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   41baf:	80 cc 30             	or     $0x30,%ah
   41bb2:	48 89 c2             	mov    %rax,%rdx
   41bb5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41bb9:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   41bc0:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41bc3:	83 e0 02             	and    $0x2,%eax
   41bc6:	85 c0                	test   %eax,%eax
   41bc8:	74 1c                	je     41be6 <process_init+0xbc>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   41bca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41bce:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   41bd5:	80 e4 fd             	and    $0xfd,%ah
   41bd8:	48 89 c2             	mov    %rax,%rdx
   41bdb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41bdf:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    p->display_status = 1;
   41be6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41bea:	c6 80 e8 00 00 00 01 	movb   $0x1,0xe8(%rax)
}
   41bf1:	90                   	nop
   41bf2:	c9                   	leave  
   41bf3:	c3                   	ret    

0000000000041bf4 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   41bf4:	55                   	push   %rbp
   41bf5:	48 89 e5             	mov    %rsp,%rbp
   41bf8:	48 83 ec 28          	sub    $0x28,%rsp
   41bfc:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   41bff:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41c03:	78 09                	js     41c0e <console_show_cursor+0x1a>
   41c05:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   41c0c:	7e 07                	jle    41c15 <console_show_cursor+0x21>
        cpos = 0;
   41c0e:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   41c15:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   41c1c:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c20:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41c24:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41c27:	ee                   	out    %al,(%dx)
}
   41c28:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   41c29:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41c2c:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41c32:	85 c0                	test   %eax,%eax
   41c34:	0f 48 c2             	cmovs  %edx,%eax
   41c37:	c1 f8 08             	sar    $0x8,%eax
   41c3a:	0f b6 c0             	movzbl %al,%eax
   41c3d:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   41c44:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c47:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41c4b:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41c4e:	ee                   	out    %al,(%dx)
}
   41c4f:	90                   	nop
   41c50:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   41c57:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c5b:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41c5f:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41c62:	ee                   	out    %al,(%dx)
}
   41c63:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   41c64:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41c67:	89 d0                	mov    %edx,%eax
   41c69:	c1 f8 1f             	sar    $0x1f,%eax
   41c6c:	c1 e8 18             	shr    $0x18,%eax
   41c6f:	01 c2                	add    %eax,%edx
   41c71:	0f b6 d2             	movzbl %dl,%edx
   41c74:	29 c2                	sub    %eax,%edx
   41c76:	89 d0                	mov    %edx,%eax
   41c78:	0f b6 c0             	movzbl %al,%eax
   41c7b:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   41c82:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41c85:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41c89:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41c8c:	ee                   	out    %al,(%dx)
}
   41c8d:	90                   	nop
}
   41c8e:	90                   	nop
   41c8f:	c9                   	leave  
   41c90:	c3                   	ret    

0000000000041c91 <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   41c91:	55                   	push   %rbp
   41c92:	48 89 e5             	mov    %rsp,%rbp
   41c95:	48 83 ec 20          	sub    $0x20,%rsp
   41c99:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41ca0:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41ca3:	89 c2                	mov    %eax,%edx
   41ca5:	ec                   	in     (%dx),%al
   41ca6:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   41ca9:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   41cad:	0f b6 c0             	movzbl %al,%eax
   41cb0:	83 e0 01             	and    $0x1,%eax
   41cb3:	85 c0                	test   %eax,%eax
   41cb5:	75 0a                	jne    41cc1 <keyboard_readc+0x30>
        return -1;
   41cb7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   41cbc:	e9 e7 01 00 00       	jmp    41ea8 <keyboard_readc+0x217>
   41cc1:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41cc8:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41ccb:	89 c2                	mov    %eax,%edx
   41ccd:	ec                   	in     (%dx),%al
   41cce:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   41cd1:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   41cd5:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   41cd8:	0f b6 05 03 e7 00 00 	movzbl 0xe703(%rip),%eax        # 503e2 <last_escape.2>
   41cdf:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   41ce2:	c6 05 f9 e6 00 00 00 	movb   $0x0,0xe6f9(%rip)        # 503e2 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   41ce9:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   41ced:	75 11                	jne    41d00 <keyboard_readc+0x6f>
        last_escape = 0x80;
   41cef:	c6 05 ec e6 00 00 80 	movb   $0x80,0xe6ec(%rip)        # 503e2 <last_escape.2>
        return 0;
   41cf6:	b8 00 00 00 00       	mov    $0x0,%eax
   41cfb:	e9 a8 01 00 00       	jmp    41ea8 <keyboard_readc+0x217>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   41d00:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41d04:	84 c0                	test   %al,%al
   41d06:	79 60                	jns    41d68 <keyboard_readc+0xd7>
        int ch = keymap[(data & 0x7F) | escape];
   41d08:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41d0c:	83 e0 7f             	and    $0x7f,%eax
   41d0f:	89 c2                	mov    %eax,%edx
   41d11:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   41d15:	09 d0                	or     %edx,%eax
   41d17:	48 98                	cltq   
   41d19:	0f b6 80 e0 4d 04 00 	movzbl 0x44de0(%rax),%eax
   41d20:	0f b6 c0             	movzbl %al,%eax
   41d23:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   41d26:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   41d2d:	7e 2f                	jle    41d5e <keyboard_readc+0xcd>
   41d2f:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   41d36:	7f 26                	jg     41d5e <keyboard_readc+0xcd>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   41d38:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41d3b:	2d fa 00 00 00       	sub    $0xfa,%eax
   41d40:	ba 01 00 00 00       	mov    $0x1,%edx
   41d45:	89 c1                	mov    %eax,%ecx
   41d47:	d3 e2                	shl    %cl,%edx
   41d49:	89 d0                	mov    %edx,%eax
   41d4b:	f7 d0                	not    %eax
   41d4d:	89 c2                	mov    %eax,%edx
   41d4f:	0f b6 05 8d e6 00 00 	movzbl 0xe68d(%rip),%eax        # 503e3 <modifiers.1>
   41d56:	21 d0                	and    %edx,%eax
   41d58:	88 05 85 e6 00 00    	mov    %al,0xe685(%rip)        # 503e3 <modifiers.1>
        }
        return 0;
   41d5e:	b8 00 00 00 00       	mov    $0x0,%eax
   41d63:	e9 40 01 00 00       	jmp    41ea8 <keyboard_readc+0x217>
    }

    int ch = (unsigned char) keymap[data | escape];
   41d68:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41d6c:	0a 45 fa             	or     -0x6(%rbp),%al
   41d6f:	0f b6 c0             	movzbl %al,%eax
   41d72:	48 98                	cltq   
   41d74:	0f b6 80 e0 4d 04 00 	movzbl 0x44de0(%rax),%eax
   41d7b:	0f b6 c0             	movzbl %al,%eax
   41d7e:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   41d81:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   41d85:	7e 57                	jle    41dde <keyboard_readc+0x14d>
   41d87:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   41d8b:	7f 51                	jg     41dde <keyboard_readc+0x14d>
        if (modifiers & MOD_CONTROL) {
   41d8d:	0f b6 05 4f e6 00 00 	movzbl 0xe64f(%rip),%eax        # 503e3 <modifiers.1>
   41d94:	0f b6 c0             	movzbl %al,%eax
   41d97:	83 e0 02             	and    $0x2,%eax
   41d9a:	85 c0                	test   %eax,%eax
   41d9c:	74 09                	je     41da7 <keyboard_readc+0x116>
            ch -= 0x60;
   41d9e:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   41da2:	e9 fd 00 00 00       	jmp    41ea4 <keyboard_readc+0x213>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   41da7:	0f b6 05 35 e6 00 00 	movzbl 0xe635(%rip),%eax        # 503e3 <modifiers.1>
   41dae:	0f b6 c0             	movzbl %al,%eax
   41db1:	83 e0 01             	and    $0x1,%eax
   41db4:	85 c0                	test   %eax,%eax
   41db6:	0f 94 c2             	sete   %dl
   41db9:	0f b6 05 23 e6 00 00 	movzbl 0xe623(%rip),%eax        # 503e3 <modifiers.1>
   41dc0:	0f b6 c0             	movzbl %al,%eax
   41dc3:	83 e0 08             	and    $0x8,%eax
   41dc6:	85 c0                	test   %eax,%eax
   41dc8:	0f 94 c0             	sete   %al
   41dcb:	31 d0                	xor    %edx,%eax
   41dcd:	84 c0                	test   %al,%al
   41dcf:	0f 84 cf 00 00 00    	je     41ea4 <keyboard_readc+0x213>
            ch -= 0x20;
   41dd5:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   41dd9:	e9 c6 00 00 00       	jmp    41ea4 <keyboard_readc+0x213>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   41dde:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   41de5:	7e 30                	jle    41e17 <keyboard_readc+0x186>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   41de7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41dea:	2d fa 00 00 00       	sub    $0xfa,%eax
   41def:	ba 01 00 00 00       	mov    $0x1,%edx
   41df4:	89 c1                	mov    %eax,%ecx
   41df6:	d3 e2                	shl    %cl,%edx
   41df8:	89 d0                	mov    %edx,%eax
   41dfa:	89 c2                	mov    %eax,%edx
   41dfc:	0f b6 05 e0 e5 00 00 	movzbl 0xe5e0(%rip),%eax        # 503e3 <modifiers.1>
   41e03:	31 d0                	xor    %edx,%eax
   41e05:	88 05 d8 e5 00 00    	mov    %al,0xe5d8(%rip)        # 503e3 <modifiers.1>
        ch = 0;
   41e0b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41e12:	e9 8e 00 00 00       	jmp    41ea5 <keyboard_readc+0x214>
    } else if (ch >= KEY_SHIFT) {
   41e17:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   41e1e:	7e 2d                	jle    41e4d <keyboard_readc+0x1bc>
        modifiers |= 1 << (ch - KEY_SHIFT);
   41e20:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41e23:	2d fa 00 00 00       	sub    $0xfa,%eax
   41e28:	ba 01 00 00 00       	mov    $0x1,%edx
   41e2d:	89 c1                	mov    %eax,%ecx
   41e2f:	d3 e2                	shl    %cl,%edx
   41e31:	89 d0                	mov    %edx,%eax
   41e33:	89 c2                	mov    %eax,%edx
   41e35:	0f b6 05 a7 e5 00 00 	movzbl 0xe5a7(%rip),%eax        # 503e3 <modifiers.1>
   41e3c:	09 d0                	or     %edx,%eax
   41e3e:	88 05 9f e5 00 00    	mov    %al,0xe59f(%rip)        # 503e3 <modifiers.1>
        ch = 0;
   41e44:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41e4b:	eb 58                	jmp    41ea5 <keyboard_readc+0x214>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   41e4d:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   41e51:	7e 31                	jle    41e84 <keyboard_readc+0x1f3>
   41e53:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   41e5a:	7f 28                	jg     41e84 <keyboard_readc+0x1f3>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   41e5c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41e5f:	8d 50 80             	lea    -0x80(%rax),%edx
   41e62:	0f b6 05 7a e5 00 00 	movzbl 0xe57a(%rip),%eax        # 503e3 <modifiers.1>
   41e69:	0f b6 c0             	movzbl %al,%eax
   41e6c:	83 e0 03             	and    $0x3,%eax
   41e6f:	48 98                	cltq   
   41e71:	48 63 d2             	movslq %edx,%rdx
   41e74:	0f b6 84 90 e0 4e 04 	movzbl 0x44ee0(%rax,%rdx,4),%eax
   41e7b:	00 
   41e7c:	0f b6 c0             	movzbl %al,%eax
   41e7f:	89 45 fc             	mov    %eax,-0x4(%rbp)
   41e82:	eb 21                	jmp    41ea5 <keyboard_readc+0x214>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   41e84:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   41e88:	7f 1b                	jg     41ea5 <keyboard_readc+0x214>
   41e8a:	0f b6 05 52 e5 00 00 	movzbl 0xe552(%rip),%eax        # 503e3 <modifiers.1>
   41e91:	0f b6 c0             	movzbl %al,%eax
   41e94:	83 e0 02             	and    $0x2,%eax
   41e97:	85 c0                	test   %eax,%eax
   41e99:	74 0a                	je     41ea5 <keyboard_readc+0x214>
        ch = 0;
   41e9b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41ea2:	eb 01                	jmp    41ea5 <keyboard_readc+0x214>
        if (modifiers & MOD_CONTROL) {
   41ea4:	90                   	nop
    }

    return ch;
   41ea5:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   41ea8:	c9                   	leave  
   41ea9:	c3                   	ret    

0000000000041eaa <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   41eaa:	55                   	push   %rbp
   41eab:	48 89 e5             	mov    %rsp,%rbp
   41eae:	48 83 ec 20          	sub    $0x20,%rsp
   41eb2:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41eb9:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   41ebc:	89 c2                	mov    %eax,%edx
   41ebe:	ec                   	in     (%dx),%al
   41ebf:	88 45 e3             	mov    %al,-0x1d(%rbp)
   41ec2:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   41ec9:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41ecc:	89 c2                	mov    %eax,%edx
   41ece:	ec                   	in     (%dx),%al
   41ecf:	88 45 eb             	mov    %al,-0x15(%rbp)
   41ed2:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   41ed9:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41edc:	89 c2                	mov    %eax,%edx
   41ede:	ec                   	in     (%dx),%al
   41edf:	88 45 f3             	mov    %al,-0xd(%rbp)
   41ee2:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   41ee9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41eec:	89 c2                	mov    %eax,%edx
   41eee:	ec                   	in     (%dx),%al
   41eef:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   41ef2:	90                   	nop
   41ef3:	c9                   	leave  
   41ef4:	c3                   	ret    

0000000000041ef5 <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   41ef5:	55                   	push   %rbp
   41ef6:	48 89 e5             	mov    %rsp,%rbp
   41ef9:	48 83 ec 40          	sub    $0x40,%rsp
   41efd:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   41f01:	89 f0                	mov    %esi,%eax
   41f03:	89 55 c0             	mov    %edx,-0x40(%rbp)
   41f06:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   41f09:	8b 05 d5 e4 00 00    	mov    0xe4d5(%rip),%eax        # 503e4 <initialized.0>
   41f0f:	85 c0                	test   %eax,%eax
   41f11:	75 1e                	jne    41f31 <parallel_port_putc+0x3c>
   41f13:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   41f1a:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f1e:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   41f22:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41f25:	ee                   	out    %al,(%dx)
}
   41f26:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   41f27:	c7 05 b3 e4 00 00 01 	movl   $0x1,0xe4b3(%rip)        # 503e4 <initialized.0>
   41f2e:	00 00 00 
    }

    for (int i = 0;
   41f31:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41f38:	eb 09                	jmp    41f43 <parallel_port_putc+0x4e>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   41f3a:	e8 6b ff ff ff       	call   41eaa <delay>
         ++i) {
   41f3f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   41f43:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   41f4a:	7f 18                	jg     41f64 <parallel_port_putc+0x6f>
   41f4c:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41f53:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41f56:	89 c2                	mov    %eax,%edx
   41f58:	ec                   	in     (%dx),%al
   41f59:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   41f5c:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   41f60:	84 c0                	test   %al,%al
   41f62:	79 d6                	jns    41f3a <parallel_port_putc+0x45>
    }
    outb(IO_PARALLEL1_DATA, c);
   41f64:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   41f68:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   41f6f:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f72:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   41f76:	8b 55 d8             	mov    -0x28(%rbp),%edx
   41f79:	ee                   	out    %al,(%dx)
}
   41f7a:	90                   	nop
   41f7b:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   41f82:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f86:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   41f8a:	8b 55 e0             	mov    -0x20(%rbp),%edx
   41f8d:	ee                   	out    %al,(%dx)
}
   41f8e:	90                   	nop
   41f8f:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   41f96:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f9a:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   41f9e:	8b 55 e8             	mov    -0x18(%rbp),%edx
   41fa1:	ee                   	out    %al,(%dx)
}
   41fa2:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   41fa3:	90                   	nop
   41fa4:	c9                   	leave  
   41fa5:	c3                   	ret    

0000000000041fa6 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   41fa6:	55                   	push   %rbp
   41fa7:	48 89 e5             	mov    %rsp,%rbp
   41faa:	48 83 ec 20          	sub    $0x20,%rsp
   41fae:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   41fb2:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   41fb6:	48 c7 45 f8 f5 1e 04 	movq   $0x41ef5,-0x8(%rbp)
   41fbd:	00 
    printer_vprintf(&p, 0, format, val);
   41fbe:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   41fc2:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   41fc6:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   41fca:	be 00 00 00 00       	mov    $0x0,%esi
   41fcf:	48 89 c7             	mov    %rax,%rdi
   41fd2:	e8 b3 1c 00 00       	call   43c8a <printer_vprintf>
}
   41fd7:	90                   	nop
   41fd8:	c9                   	leave  
   41fd9:	c3                   	ret    

0000000000041fda <log_printf>:

void log_printf(const char* format, ...) {
   41fda:	55                   	push   %rbp
   41fdb:	48 89 e5             	mov    %rsp,%rbp
   41fde:	48 83 ec 60          	sub    $0x60,%rsp
   41fe2:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   41fe6:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   41fea:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   41fee:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   41ff2:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   41ff6:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   41ffa:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   42001:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42005:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42009:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4200d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   42011:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   42015:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42019:	48 89 d6             	mov    %rdx,%rsi
   4201c:	48 89 c7             	mov    %rax,%rdi
   4201f:	e8 82 ff ff ff       	call   41fa6 <log_vprintf>
    va_end(val);
}
   42024:	90                   	nop
   42025:	c9                   	leave  
   42026:	c3                   	ret    

0000000000042027 <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   42027:	55                   	push   %rbp
   42028:	48 89 e5             	mov    %rsp,%rbp
   4202b:	48 83 ec 40          	sub    $0x40,%rsp
   4202f:	89 7d dc             	mov    %edi,-0x24(%rbp)
   42032:	89 75 d8             	mov    %esi,-0x28(%rbp)
   42035:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   42039:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   4203d:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   42041:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42045:	48 8b 0a             	mov    (%rdx),%rcx
   42048:	48 89 08             	mov    %rcx,(%rax)
   4204b:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   4204f:	48 89 48 08          	mov    %rcx,0x8(%rax)
   42053:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   42057:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   4205b:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   4205f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42063:	48 89 d6             	mov    %rdx,%rsi
   42066:	48 89 c7             	mov    %rax,%rdi
   42069:	e8 38 ff ff ff       	call   41fa6 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   4206e:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42072:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42076:	8b 75 d8             	mov    -0x28(%rbp),%esi
   42079:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4207c:	89 c7                	mov    %eax,%edi
   4207e:	e8 b6 26 00 00       	call   44739 <console_vprintf>
}
   42083:	c9                   	leave  
   42084:	c3                   	ret    

0000000000042085 <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   42085:	55                   	push   %rbp
   42086:	48 89 e5             	mov    %rsp,%rbp
   42089:	48 83 ec 60          	sub    $0x60,%rsp
   4208d:	89 7d ac             	mov    %edi,-0x54(%rbp)
   42090:	89 75 a8             	mov    %esi,-0x58(%rbp)
   42093:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   42097:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4209b:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4209f:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   420a3:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   420aa:	48 8d 45 10          	lea    0x10(%rbp),%rax
   420ae:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   420b2:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   420b6:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   420ba:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   420be:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   420c2:	8b 75 a8             	mov    -0x58(%rbp),%esi
   420c5:	8b 45 ac             	mov    -0x54(%rbp),%eax
   420c8:	89 c7                	mov    %eax,%edi
   420ca:	e8 58 ff ff ff       	call   42027 <error_vprintf>
   420cf:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   420d2:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   420d5:	c9                   	leave  
   420d6:	c3                   	ret    

00000000000420d7 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'm', and 'c' cause a soft
//    reboot where the kernel runs the allocator programs, "malloc", or
//    "alloctests", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   420d7:	55                   	push   %rbp
   420d8:	48 89 e5             	mov    %rsp,%rbp
   420db:	53                   	push   %rbx
   420dc:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   420e0:	e8 ac fb ff ff       	call   41c91 <keyboard_readc>
   420e5:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'm' || c == 'c' || c == 't'|| c =='2') {
   420e8:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   420ec:	74 1c                	je     4210a <check_keyboard+0x33>
   420ee:	83 7d e4 6d          	cmpl   $0x6d,-0x1c(%rbp)
   420f2:	74 16                	je     4210a <check_keyboard+0x33>
   420f4:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   420f8:	74 10                	je     4210a <check_keyboard+0x33>
   420fa:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   420fe:	74 0a                	je     4210a <check_keyboard+0x33>
   42100:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42104:	0f 85 e9 00 00 00    	jne    421f3 <check_keyboard+0x11c>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   4210a:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   42111:	00 
        memset(pt, 0, PAGESIZE * 3);
   42112:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42116:	ba 00 30 00 00       	mov    $0x3000,%edx
   4211b:	be 00 00 00 00       	mov    $0x0,%esi
   42120:	48 89 c7             	mov    %rax,%rdi
   42123:	e8 c6 18 00 00       	call   439ee <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   42128:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4212c:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   42133:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42137:	48 05 00 10 00 00    	add    $0x1000,%rax
   4213d:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   42144:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42148:	48 05 00 20 00 00    	add    $0x2000,%rax
   4214e:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   42155:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42159:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   4215d:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42161:	0f 22 d8             	mov    %rax,%cr3
}
   42164:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   42165:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "malloc";
   4216c:	48 c7 45 e8 38 4f 04 	movq   $0x44f38,-0x18(%rbp)
   42173:	00 
        if (c == 'a') {
   42174:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42178:	75 0a                	jne    42184 <check_keyboard+0xad>
            argument = "allocator";
   4217a:	48 c7 45 e8 3f 4f 04 	movq   $0x44f3f,-0x18(%rbp)
   42181:	00 
   42182:	eb 2e                	jmp    421b2 <check_keyboard+0xdb>
        } else if (c == 'c') {
   42184:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   42188:	75 0a                	jne    42194 <check_keyboard+0xbd>
            argument = "alloctests";
   4218a:	48 c7 45 e8 49 4f 04 	movq   $0x44f49,-0x18(%rbp)
   42191:	00 
   42192:	eb 1e                	jmp    421b2 <check_keyboard+0xdb>
        } else if(c == 't'){
   42194:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42198:	75 0a                	jne    421a4 <check_keyboard+0xcd>
            argument = "test";
   4219a:	48 c7 45 e8 54 4f 04 	movq   $0x44f54,-0x18(%rbp)
   421a1:	00 
   421a2:	eb 0e                	jmp    421b2 <check_keyboard+0xdb>
        }
        else if(c == '2'){
   421a4:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   421a8:	75 08                	jne    421b2 <check_keyboard+0xdb>
            argument = "test2";
   421aa:	48 c7 45 e8 59 4f 04 	movq   $0x44f59,-0x18(%rbp)
   421b1:	00 
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   421b2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   421b6:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   421ba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   421bf:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   421c3:	73 14                	jae    421d9 <check_keyboard+0x102>
   421c5:	ba 5f 4f 04 00       	mov    $0x44f5f,%edx
   421ca:	be 5c 02 00 00       	mov    $0x25c,%esi
   421cf:	bf 7b 4f 04 00       	mov    $0x44f7b,%edi
   421d4:	e8 1f 01 00 00       	call   422f8 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   421d9:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   421dd:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   421e0:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   421e4:	48 89 c3             	mov    %rax,%rbx
   421e7:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   421ec:	e9 0f de ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'm' || c == 'c' || c == 't'|| c =='2') {
   421f1:	eb 11                	jmp    42204 <check_keyboard+0x12d>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   421f3:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   421f7:	74 06                	je     421ff <check_keyboard+0x128>
   421f9:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   421fd:	75 05                	jne    42204 <check_keyboard+0x12d>
        poweroff();
   421ff:	e8 9d f8 ff ff       	call   41aa1 <poweroff>
    }
    return c;
   42204:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   42207:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   4220b:	c9                   	leave  
   4220c:	c3                   	ret    

000000000004220d <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   4220d:	55                   	push   %rbp
   4220e:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   42211:	e8 c1 fe ff ff       	call   420d7 <check_keyboard>
   42216:	eb f9                	jmp    42211 <fail+0x4>

0000000000042218 <kernel_panic>:

// kernel_panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void kernel_panic(const char* format, ...) {
   42218:	55                   	push   %rbp
   42219:	48 89 e5             	mov    %rsp,%rbp
   4221c:	48 83 ec 60          	sub    $0x60,%rsp
   42220:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42224:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42228:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   4222c:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42230:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42234:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42238:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   4223f:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42243:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   42247:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4224b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   4224f:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   42254:	0f 84 80 00 00 00    	je     422da <kernel_panic+0xc2>
        // Print kernel_panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   4225a:	ba 8f 4f 04 00       	mov    $0x44f8f,%edx
   4225f:	be 00 c0 00 00       	mov    $0xc000,%esi
   42264:	bf 30 07 00 00       	mov    $0x730,%edi
   42269:	b8 00 00 00 00       	mov    $0x0,%eax
   4226e:	e8 12 fe ff ff       	call   42085 <error_printf>
   42273:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   42276:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   4227a:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   4227e:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42281:	be 00 c0 00 00       	mov    $0xc000,%esi
   42286:	89 c7                	mov    %eax,%edi
   42288:	e8 9a fd ff ff       	call   42027 <error_vprintf>
   4228d:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   42290:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   42293:	48 63 c1             	movslq %ecx,%rax
   42296:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   4229d:	48 c1 e8 20          	shr    $0x20,%rax
   422a1:	89 c2                	mov    %eax,%edx
   422a3:	c1 fa 05             	sar    $0x5,%edx
   422a6:	89 c8                	mov    %ecx,%eax
   422a8:	c1 f8 1f             	sar    $0x1f,%eax
   422ab:	29 c2                	sub    %eax,%edx
   422ad:	89 d0                	mov    %edx,%eax
   422af:	c1 e0 02             	shl    $0x2,%eax
   422b2:	01 d0                	add    %edx,%eax
   422b4:	c1 e0 04             	shl    $0x4,%eax
   422b7:	29 c1                	sub    %eax,%ecx
   422b9:	89 ca                	mov    %ecx,%edx
   422bb:	85 d2                	test   %edx,%edx
   422bd:	74 34                	je     422f3 <kernel_panic+0xdb>
            error_printf(cpos, 0xC000, "\n");
   422bf:	8b 45 cc             	mov    -0x34(%rbp),%eax
   422c2:	ba 97 4f 04 00       	mov    $0x44f97,%edx
   422c7:	be 00 c0 00 00       	mov    $0xc000,%esi
   422cc:	89 c7                	mov    %eax,%edi
   422ce:	b8 00 00 00 00       	mov    $0x0,%eax
   422d3:	e8 ad fd ff ff       	call   42085 <error_printf>
   422d8:	eb 19                	jmp    422f3 <kernel_panic+0xdb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   422da:	ba 99 4f 04 00       	mov    $0x44f99,%edx
   422df:	be 00 c0 00 00       	mov    $0xc000,%esi
   422e4:	bf 30 07 00 00       	mov    $0x730,%edi
   422e9:	b8 00 00 00 00       	mov    $0x0,%eax
   422ee:	e8 92 fd ff ff       	call   42085 <error_printf>
    }

    va_end(val);
    fail();
   422f3:	e8 15 ff ff ff       	call   4220d <fail>

00000000000422f8 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   422f8:	55                   	push   %rbp
   422f9:	48 89 e5             	mov    %rsp,%rbp
   422fc:	48 83 ec 20          	sub    $0x20,%rsp
   42300:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42304:	89 75 f4             	mov    %esi,-0xc(%rbp)
   42307:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    kernel_panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   4230b:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   4230f:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42312:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42316:	48 89 c6             	mov    %rax,%rsi
   42319:	bf 9f 4f 04 00       	mov    $0x44f9f,%edi
   4231e:	b8 00 00 00 00       	mov    $0x0,%eax
   42323:	e8 f0 fe ff ff       	call   42218 <kernel_panic>

0000000000042328 <default_exception>:
}

void default_exception(proc* p){
   42328:	55                   	push   %rbp
   42329:	48 89 e5             	mov    %rsp,%rbp
   4232c:	48 83 ec 20          	sub    $0x20,%rsp
   42330:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   42334:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42338:	48 83 c0 18          	add    $0x18,%rax
   4233c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    kernel_panic("Unexpected exception %d!\n", reg->reg_intno);
   42340:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42344:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   4234b:	48 89 c6             	mov    %rax,%rsi
   4234e:	bf bd 4f 04 00       	mov    $0x44fbd,%edi
   42353:	b8 00 00 00 00       	mov    $0x0,%eax
   42358:	e8 bb fe ff ff       	call   42218 <kernel_panic>

000000000004235d <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   4235d:	55                   	push   %rbp
   4235e:	48 89 e5             	mov    %rsp,%rbp
   42361:	48 83 ec 10          	sub    $0x10,%rsp
   42365:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42369:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   4236c:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   42370:	78 06                	js     42378 <pageindex+0x1b>
   42372:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   42376:	7e 14                	jle    4238c <pageindex+0x2f>
   42378:	ba d8 4f 04 00       	mov    $0x44fd8,%edx
   4237d:	be 1e 00 00 00       	mov    $0x1e,%esi
   42382:	bf f1 4f 04 00       	mov    $0x44ff1,%edi
   42387:	e8 6c ff ff ff       	call   422f8 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   4238c:	b8 03 00 00 00       	mov    $0x3,%eax
   42391:	2b 45 f4             	sub    -0xc(%rbp),%eax
   42394:	89 c2                	mov    %eax,%edx
   42396:	89 d0                	mov    %edx,%eax
   42398:	c1 e0 03             	shl    $0x3,%eax
   4239b:	01 d0                	add    %edx,%eax
   4239d:	83 c0 0c             	add    $0xc,%eax
   423a0:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   423a4:	89 c1                	mov    %eax,%ecx
   423a6:	48 d3 ea             	shr    %cl,%rdx
   423a9:	48 89 d0             	mov    %rdx,%rax
   423ac:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   423b1:	c9                   	leave  
   423b2:	c3                   	ret    

00000000000423b3 <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   423b3:	55                   	push   %rbp
   423b4:	48 89 e5             	mov    %rsp,%rbp
   423b7:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   423bb:	48 c7 05 3a ec 00 00 	movq   $0x52000,0xec3a(%rip)        # 51000 <kernel_pagetable>
   423c2:	00 20 05 00 
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   423c6:	ba 00 50 00 00       	mov    $0x5000,%edx
   423cb:	be 00 00 00 00       	mov    $0x0,%esi
   423d0:	bf 00 20 05 00       	mov    $0x52000,%edi
   423d5:	e8 14 16 00 00       	call   439ee <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   423da:	b8 00 30 05 00       	mov    $0x53000,%eax
   423df:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   423e3:	48 89 05 16 fc 00 00 	mov    %rax,0xfc16(%rip)        # 52000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   423ea:	b8 00 40 05 00       	mov    $0x54000,%eax
   423ef:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   423f3:	48 89 05 06 0c 01 00 	mov    %rax,0x10c06(%rip)        # 53000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   423fa:	b8 00 50 05 00       	mov    $0x55000,%eax
   423ff:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   42403:	48 89 05 f6 1b 01 00 	mov    %rax,0x11bf6(%rip)        # 54000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   4240a:	b8 00 60 05 00       	mov    $0x56000,%eax
   4240f:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   42413:	48 89 05 ee 1b 01 00 	mov    %rax,0x11bee(%rip)        # 54008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   4241a:	48 8b 05 df eb 00 00 	mov    0xebdf(%rip),%rax        # 51000 <kernel_pagetable>
   42421:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42427:	b9 00 00 20 00       	mov    $0x200000,%ecx
   4242c:	ba 00 00 00 00       	mov    $0x0,%edx
   42431:	be 00 00 00 00       	mov    $0x0,%esi
   42436:	48 89 c7             	mov    %rax,%rdi
   42439:	e8 b9 01 00 00       	call   425f7 <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   4243e:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42445:	00 
   42446:	eb 62                	jmp    424aa <virtual_memory_init+0xf7>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   42448:	48 8b 0d b1 eb 00 00 	mov    0xebb1(%rip),%rcx        # 51000 <kernel_pagetable>
   4244f:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42453:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42457:	48 89 ce             	mov    %rcx,%rsi
   4245a:	48 89 c7             	mov    %rax,%rdi
   4245d:	e8 58 05 00 00       	call   429ba <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l4pagetable ?
        assert(vmap.pa == addr);
   42462:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42466:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4246a:	74 14                	je     42480 <virtual_memory_init+0xcd>
   4246c:	ba 05 50 04 00       	mov    $0x45005,%edx
   42471:	be 2d 00 00 00       	mov    $0x2d,%esi
   42476:	bf 15 50 04 00       	mov    $0x45015,%edi
   4247b:	e8 78 fe ff ff       	call   422f8 <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   42480:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42483:	48 98                	cltq   
   42485:	83 e0 03             	and    $0x3,%eax
   42488:	48 83 f8 03          	cmp    $0x3,%rax
   4248c:	74 14                	je     424a2 <virtual_memory_init+0xef>
   4248e:	ba 28 50 04 00       	mov    $0x45028,%edx
   42493:	be 2e 00 00 00       	mov    $0x2e,%esi
   42498:	bf 15 50 04 00       	mov    $0x45015,%edi
   4249d:	e8 56 fe ff ff       	call   422f8 <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   424a2:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   424a9:	00 
   424aa:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   424b1:	00 
   424b2:	76 94                	jbe    42448 <virtual_memory_init+0x95>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   424b4:	48 8b 05 45 eb 00 00 	mov    0xeb45(%rip),%rax        # 51000 <kernel_pagetable>
   424bb:	48 89 c7             	mov    %rax,%rdi
   424be:	e8 03 00 00 00       	call   424c6 <set_pagetable>
}
   424c3:	90                   	nop
   424c4:	c9                   	leave  
   424c5:	c3                   	ret    

00000000000424c6 <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls kernel_panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   424c6:	55                   	push   %rbp
   424c7:	48 89 e5             	mov    %rsp,%rbp
   424ca:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   424ce:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   424d2:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   424d6:	25 ff 0f 00 00       	and    $0xfff,%eax
   424db:	48 85 c0             	test   %rax,%rax
   424de:	74 14                	je     424f4 <set_pagetable+0x2e>
   424e0:	ba 55 50 04 00       	mov    $0x45055,%edx
   424e5:	be 3d 00 00 00       	mov    $0x3d,%esi
   424ea:	bf 15 50 04 00       	mov    $0x45015,%edi
   424ef:	e8 04 fe ff ff       	call   422f8 <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   424f4:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   424f9:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   424fd:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42501:	48 89 ce             	mov    %rcx,%rsi
   42504:	48 89 c7             	mov    %rax,%rdi
   42507:	e8 ae 04 00 00       	call   429ba <virtual_memory_lookup>
   4250c:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42510:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42515:	48 39 d0             	cmp    %rdx,%rax
   42518:	74 14                	je     4252e <set_pagetable+0x68>
   4251a:	ba 70 50 04 00       	mov    $0x45070,%edx
   4251f:	be 3f 00 00 00       	mov    $0x3f,%esi
   42524:	bf 15 50 04 00       	mov    $0x45015,%edi
   42529:	e8 ca fd ff ff       	call   422f8 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   4252e:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   42532:	48 8b 0d c7 ea 00 00 	mov    0xeac7(%rip),%rcx        # 51000 <kernel_pagetable>
   42539:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   4253d:	48 89 ce             	mov    %rcx,%rsi
   42540:	48 89 c7             	mov    %rax,%rdi
   42543:	e8 72 04 00 00       	call   429ba <virtual_memory_lookup>
   42548:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   4254c:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42550:	48 39 c2             	cmp    %rax,%rdx
   42553:	74 14                	je     42569 <set_pagetable+0xa3>
   42555:	ba d8 50 04 00       	mov    $0x450d8,%edx
   4255a:	be 41 00 00 00       	mov    $0x41,%esi
   4255f:	bf 15 50 04 00       	mov    $0x45015,%edi
   42564:	e8 8f fd ff ff       	call   422f8 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   42569:	48 8b 05 90 ea 00 00 	mov    0xea90(%rip),%rax        # 51000 <kernel_pagetable>
   42570:	48 89 c2             	mov    %rax,%rdx
   42573:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   42577:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   4257b:	48 89 ce             	mov    %rcx,%rsi
   4257e:	48 89 c7             	mov    %rax,%rdi
   42581:	e8 34 04 00 00       	call   429ba <virtual_memory_lookup>
   42586:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4258a:	48 8b 15 6f ea 00 00 	mov    0xea6f(%rip),%rdx        # 51000 <kernel_pagetable>
   42591:	48 39 d0             	cmp    %rdx,%rax
   42594:	74 14                	je     425aa <set_pagetable+0xe4>
   42596:	ba 38 51 04 00       	mov    $0x45138,%edx
   4259b:	be 43 00 00 00       	mov    $0x43,%esi
   425a0:	bf 15 50 04 00       	mov    $0x45015,%edi
   425a5:	e8 4e fd ff ff       	call   422f8 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   425aa:	ba f7 25 04 00       	mov    $0x425f7,%edx
   425af:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   425b3:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   425b7:	48 89 ce             	mov    %rcx,%rsi
   425ba:	48 89 c7             	mov    %rax,%rdi
   425bd:	e8 f8 03 00 00       	call   429ba <virtual_memory_lookup>
   425c2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   425c6:	ba f7 25 04 00       	mov    $0x425f7,%edx
   425cb:	48 39 d0             	cmp    %rdx,%rax
   425ce:	74 14                	je     425e4 <set_pagetable+0x11e>
   425d0:	ba a0 51 04 00       	mov    $0x451a0,%edx
   425d5:	be 45 00 00 00       	mov    $0x45,%esi
   425da:	bf 15 50 04 00       	mov    $0x45015,%edi
   425df:	e8 14 fd ff ff       	call   422f8 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   425e4:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   425e8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   425ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   425f0:	0f 22 d8             	mov    %rax,%cr3
}
   425f3:	90                   	nop
}
   425f4:	90                   	nop
   425f5:	c9                   	leave  
   425f6:	c3                   	ret    

00000000000425f7 <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   425f7:	55                   	push   %rbp
   425f8:	48 89 e5             	mov    %rsp,%rbp
   425fb:	53                   	push   %rbx
   425fc:	48 83 ec 58          	sub    $0x58,%rsp
   42600:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42604:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42608:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   4260c:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
   42610:	44 89 45 ac          	mov    %r8d,-0x54(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   42614:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42618:	25 ff 0f 00 00       	and    $0xfff,%eax
   4261d:	48 85 c0             	test   %rax,%rax
   42620:	74 14                	je     42636 <virtual_memory_map+0x3f>
   42622:	ba 06 52 04 00       	mov    $0x45206,%edx
   42627:	be 66 00 00 00       	mov    $0x66,%esi
   4262c:	bf 15 50 04 00       	mov    $0x45015,%edi
   42631:	e8 c2 fc ff ff       	call   422f8 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   42636:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   4263a:	25 ff 0f 00 00       	and    $0xfff,%eax
   4263f:	48 85 c0             	test   %rax,%rax
   42642:	74 14                	je     42658 <virtual_memory_map+0x61>
   42644:	ba 19 52 04 00       	mov    $0x45219,%edx
   42649:	be 67 00 00 00       	mov    $0x67,%esi
   4264e:	bf 15 50 04 00       	mov    $0x45015,%edi
   42653:	e8 a0 fc ff ff       	call   422f8 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   42658:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   4265c:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42660:	48 01 d0             	add    %rdx,%rax
   42663:	48 3b 45 c0          	cmp    -0x40(%rbp),%rax
   42667:	73 24                	jae    4268d <virtual_memory_map+0x96>
   42669:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   4266d:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42671:	48 01 d0             	add    %rdx,%rax
   42674:	48 85 c0             	test   %rax,%rax
   42677:	74 14                	je     4268d <virtual_memory_map+0x96>
   42679:	ba 2c 52 04 00       	mov    $0x4522c,%edx
   4267e:	be 68 00 00 00       	mov    $0x68,%esi
   42683:	bf 15 50 04 00       	mov    $0x45015,%edi
   42688:	e8 6b fc ff ff       	call   422f8 <assert_fail>
    if (perm & PTE_P) {
   4268d:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42690:	48 98                	cltq   
   42692:	83 e0 01             	and    $0x1,%eax
   42695:	48 85 c0             	test   %rax,%rax
   42698:	74 6e                	je     42708 <virtual_memory_map+0x111>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   4269a:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4269e:	25 ff 0f 00 00       	and    $0xfff,%eax
   426a3:	48 85 c0             	test   %rax,%rax
   426a6:	74 14                	je     426bc <virtual_memory_map+0xc5>
   426a8:	ba 4a 52 04 00       	mov    $0x4524a,%edx
   426ad:	be 6a 00 00 00       	mov    $0x6a,%esi
   426b2:	bf 15 50 04 00       	mov    $0x45015,%edi
   426b7:	e8 3c fc ff ff       	call   422f8 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   426bc:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   426c0:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   426c4:	48 01 d0             	add    %rdx,%rax
   426c7:	48 3b 45 b8          	cmp    -0x48(%rbp),%rax
   426cb:	73 14                	jae    426e1 <virtual_memory_map+0xea>
   426cd:	ba 5d 52 04 00       	mov    $0x4525d,%edx
   426d2:	be 6b 00 00 00       	mov    $0x6b,%esi
   426d7:	bf 15 50 04 00       	mov    $0x45015,%edi
   426dc:	e8 17 fc ff ff       	call   422f8 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   426e1:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   426e5:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   426e9:	48 01 d0             	add    %rdx,%rax
   426ec:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   426f2:	76 14                	jbe    42708 <virtual_memory_map+0x111>
   426f4:	ba 6b 52 04 00       	mov    $0x4526b,%edx
   426f9:	be 6c 00 00 00       	mov    $0x6c,%esi
   426fe:	bf 15 50 04 00       	mov    $0x45015,%edi
   42703:	e8 f0 fb ff ff       	call   422f8 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   42708:	83 7d ac 00          	cmpl   $0x0,-0x54(%rbp)
   4270c:	78 09                	js     42717 <virtual_memory_map+0x120>
   4270e:	81 7d ac ff 0f 00 00 	cmpl   $0xfff,-0x54(%rbp)
   42715:	7e 14                	jle    4272b <virtual_memory_map+0x134>
   42717:	ba 87 52 04 00       	mov    $0x45287,%edx
   4271c:	be 6e 00 00 00       	mov    $0x6e,%esi
   42721:	bf 15 50 04 00       	mov    $0x45015,%edi
   42726:	e8 cd fb ff ff       	call   422f8 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   4272b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4272f:	25 ff 0f 00 00       	and    $0xfff,%eax
   42734:	48 85 c0             	test   %rax,%rax
   42737:	74 14                	je     4274d <virtual_memory_map+0x156>
   42739:	ba a8 52 04 00       	mov    $0x452a8,%edx
   4273e:	be 6f 00 00 00       	mov    $0x6f,%esi
   42743:	bf 15 50 04 00       	mov    $0x45015,%edi
   42748:	e8 ab fb ff ff       	call   422f8 <assert_fail>

    int last_index123 = -1;
   4274d:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%rbp)
    x86_64_pagetable* l4pagetable = NULL;
   42754:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
   4275b:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   4275c:	e9 e1 00 00 00       	jmp    42842 <virtual_memory_map+0x24b>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   42761:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42765:	48 c1 e8 15          	shr    $0x15,%rax
   42769:	89 45 dc             	mov    %eax,-0x24(%rbp)
        if (cur_index123 != last_index123) {
   4276c:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4276f:	3b 45 ec             	cmp    -0x14(%rbp),%eax
   42772:	74 20                	je     42794 <virtual_memory_map+0x19d>
            // find pointer to last level pagetable for current va
            l4pagetable = lookup_l4pagetable(pagetable, va, perm);
   42774:	8b 55 ac             	mov    -0x54(%rbp),%edx
   42777:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   4277b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4277f:	48 89 ce             	mov    %rcx,%rsi
   42782:	48 89 c7             	mov    %rax,%rdi
   42785:	e8 ce 00 00 00       	call   42858 <lookup_l4pagetable>
   4278a:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            last_index123 = cur_index123;
   4278e:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42791:	89 45 ec             	mov    %eax,-0x14(%rbp)
        }
        if ((perm & PTE_P) && l4pagetable) { // if page is marked present
   42794:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42797:	48 98                	cltq   
   42799:	83 e0 01             	and    $0x1,%eax
   4279c:	48 85 c0             	test   %rax,%rax
   4279f:	74 34                	je     427d5 <virtual_memory_map+0x1de>
   427a1:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   427a6:	74 2d                	je     427d5 <virtual_memory_map+0x1de>
            // set page table entry to pa and perm
            l4pagetable->entry[L4PAGEINDEX(va)] = pa | perm;
   427a8:	8b 45 ac             	mov    -0x54(%rbp),%eax
   427ab:	48 63 d8             	movslq %eax,%rbx
   427ae:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   427b2:	be 03 00 00 00       	mov    $0x3,%esi
   427b7:	48 89 c7             	mov    %rax,%rdi
   427ba:	e8 9e fb ff ff       	call   4235d <pageindex>
   427bf:	89 c2                	mov    %eax,%edx
   427c1:	48 0b 5d b8          	or     -0x48(%rbp),%rbx
   427c5:	48 89 d9             	mov    %rbx,%rcx
   427c8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   427cc:	48 63 d2             	movslq %edx,%rdx
   427cf:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   427d3:	eb 55                	jmp    4282a <virtual_memory_map+0x233>
        } else if (l4pagetable) { // if page is NOT marked present
   427d5:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   427da:	74 26                	je     42802 <virtual_memory_map+0x20b>
            // set page table entry to just perm
            l4pagetable->entry[L4PAGEINDEX(va)] = perm;
   427dc:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   427e0:	be 03 00 00 00       	mov    $0x3,%esi
   427e5:	48 89 c7             	mov    %rax,%rdi
   427e8:	e8 70 fb ff ff       	call   4235d <pageindex>
   427ed:	89 c2                	mov    %eax,%edx
   427ef:	8b 45 ac             	mov    -0x54(%rbp),%eax
   427f2:	48 63 c8             	movslq %eax,%rcx
   427f5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   427f9:	48 63 d2             	movslq %edx,%rdx
   427fc:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42800:	eb 28                	jmp    4282a <virtual_memory_map+0x233>
        } else if (perm & PTE_P) {
   42802:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42805:	48 98                	cltq   
   42807:	83 e0 01             	and    $0x1,%eax
   4280a:	48 85 c0             	test   %rax,%rax
   4280d:	74 1b                	je     4282a <virtual_memory_map+0x233>
            // error, no allocated l4 page found for va
            log_printf("[Kern Info] failed to find l4pagetable address at " __FILE__ ": %d\n", __LINE__);
   4280f:	be 84 00 00 00       	mov    $0x84,%esi
   42814:	bf d0 52 04 00       	mov    $0x452d0,%edi
   42819:	b8 00 00 00 00       	mov    $0x0,%eax
   4281e:	e8 b7 f7 ff ff       	call   41fda <log_printf>
            return -1;
   42823:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42828:	eb 28                	jmp    42852 <virtual_memory_map+0x25b>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   4282a:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
   42831:	00 
   42832:	48 81 45 b8 00 10 00 	addq   $0x1000,-0x48(%rbp)
   42839:	00 
   4283a:	48 81 6d b0 00 10 00 	subq   $0x1000,-0x50(%rbp)
   42841:	00 
   42842:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   42847:	0f 85 14 ff ff ff    	jne    42761 <virtual_memory_map+0x16a>
        }
    }
    return 0;
   4284d:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42852:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42856:	c9                   	leave  
   42857:	c3                   	ret    

0000000000042858 <lookup_l4pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   42858:	55                   	push   %rbp
   42859:	48 89 e5             	mov    %rsp,%rbp
   4285c:	48 83 ec 40          	sub    $0x40,%rsp
   42860:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42864:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42868:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   4286b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4286f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l4 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   42873:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   4287a:	e9 2b 01 00 00       	jmp    429aa <lookup_l4pagetable+0x152>
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        x86_64_pageentry_t pe = pt->entry[PAGEINDEX(va, i)];
   4287f:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42882:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42886:	89 d6                	mov    %edx,%esi
   42888:	48 89 c7             	mov    %rax,%rdi
   4288b:	e8 cd fa ff ff       	call   4235d <pageindex>
   42890:	89 c2                	mov    %eax,%edx
   42892:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42896:	48 63 d2             	movslq %edx,%rdx
   42899:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   4289d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   428a1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   428a5:	83 e0 01             	and    $0x1,%eax
   428a8:	48 85 c0             	test   %rax,%rax
   428ab:	75 63                	jne    42910 <lookup_l4pagetable+0xb8>
            log_printf("[Kern Info] Error looking up l4pagetable: Pagetable address: 0x%x perm: 0x%x."
   428ad:	8b 45 f4             	mov    -0xc(%rbp),%eax
   428b0:	8d 48 02             	lea    0x2(%rax),%ecx
   428b3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   428b7:	25 ff 0f 00 00       	and    $0xfff,%eax
   428bc:	48 89 c2             	mov    %rax,%rdx
   428bf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   428c3:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   428c9:	48 89 c6             	mov    %rax,%rsi
   428cc:	bf 18 53 04 00       	mov    $0x45318,%edi
   428d1:	b8 00 00 00 00       	mov    $0x0,%eax
   428d6:	e8 ff f6 ff ff       	call   41fda <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   428db:	8b 45 cc             	mov    -0x34(%rbp),%eax
   428de:	48 98                	cltq   
   428e0:	83 e0 01             	and    $0x1,%eax
   428e3:	48 85 c0             	test   %rax,%rax
   428e6:	75 0a                	jne    428f2 <lookup_l4pagetable+0x9a>
                return NULL;
   428e8:	b8 00 00 00 00       	mov    $0x0,%eax
   428ed:	e9 c6 00 00 00       	jmp    429b8 <lookup_l4pagetable+0x160>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   428f2:	be a7 00 00 00       	mov    $0xa7,%esi
   428f7:	bf 80 53 04 00       	mov    $0x45380,%edi
   428fc:	b8 00 00 00 00       	mov    $0x0,%eax
   42901:	e8 d4 f6 ff ff       	call   41fda <log_printf>
            return NULL;
   42906:	b8 00 00 00 00       	mov    $0x0,%eax
   4290b:	e9 a8 00 00 00       	jmp    429b8 <lookup_l4pagetable+0x160>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   42910:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42914:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4291a:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   42920:	76 14                	jbe    42936 <lookup_l4pagetable+0xde>
   42922:	ba c8 53 04 00       	mov    $0x453c8,%edx
   42927:	be ac 00 00 00       	mov    $0xac,%esi
   4292c:	bf 15 50 04 00       	mov    $0x45015,%edi
   42931:	e8 c2 f9 ff ff       	call   422f8 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   42936:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42939:	48 98                	cltq   
   4293b:	83 e0 02             	and    $0x2,%eax
   4293e:	48 85 c0             	test   %rax,%rax
   42941:	74 20                	je     42963 <lookup_l4pagetable+0x10b>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   42943:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42947:	83 e0 02             	and    $0x2,%eax
   4294a:	48 85 c0             	test   %rax,%rax
   4294d:	75 14                	jne    42963 <lookup_l4pagetable+0x10b>
   4294f:	ba e8 53 04 00       	mov    $0x453e8,%edx
   42954:	be ae 00 00 00       	mov    $0xae,%esi
   42959:	bf 15 50 04 00       	mov    $0x45015,%edi
   4295e:	e8 95 f9 ff ff       	call   422f8 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   42963:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42966:	48 98                	cltq   
   42968:	83 e0 04             	and    $0x4,%eax
   4296b:	48 85 c0             	test   %rax,%rax
   4296e:	74 20                	je     42990 <lookup_l4pagetable+0x138>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   42970:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42974:	83 e0 04             	and    $0x4,%eax
   42977:	48 85 c0             	test   %rax,%rax
   4297a:	75 14                	jne    42990 <lookup_l4pagetable+0x138>
   4297c:	ba f3 53 04 00       	mov    $0x453f3,%edx
   42981:	be b1 00 00 00       	mov    $0xb1,%esi
   42986:	bf 15 50 04 00       	mov    $0x45015,%edi
   4298b:	e8 68 f9 ff ff       	call   422f8 <assert_fail>
        }

        // set pt to physical address to next pagetable using `pe`
        pt = 0; // replace this
   42990:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42997:	00 
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42998:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4299c:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   429a2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   429a6:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   429aa:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   429ae:	0f 8e cb fe ff ff    	jle    4287f <lookup_l4pagetable+0x27>
    }
    return pt;
   429b4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   429b8:	c9                   	leave  
   429b9:	c3                   	ret    

00000000000429ba <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   429ba:	55                   	push   %rbp
   429bb:	48 89 e5             	mov    %rsp,%rbp
   429be:	48 83 ec 50          	sub    $0x50,%rsp
   429c2:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   429c6:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   429ca:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   429ce:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   429d2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   429d6:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   429dd:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   429de:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   429e5:	eb 41                	jmp    42a28 <virtual_memory_lookup+0x6e>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   429e7:	8b 55 ec             	mov    -0x14(%rbp),%edx
   429ea:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   429ee:	89 d6                	mov    %edx,%esi
   429f0:	48 89 c7             	mov    %rax,%rdi
   429f3:	e8 65 f9 ff ff       	call   4235d <pageindex>
   429f8:	89 c2                	mov    %eax,%edx
   429fa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   429fe:	48 63 d2             	movslq %edx,%rdx
   42a01:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   42a05:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42a09:	83 e0 06             	and    $0x6,%eax
   42a0c:	48 f7 d0             	not    %rax
   42a0f:	48 21 d0             	and    %rdx,%rax
   42a12:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42a16:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42a1a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42a20:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42a24:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   42a28:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   42a2c:	7f 0c                	jg     42a3a <virtual_memory_lookup+0x80>
   42a2e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42a32:	83 e0 01             	and    $0x1,%eax
   42a35:	48 85 c0             	test   %rax,%rax
   42a38:	75 ad                	jne    429e7 <virtual_memory_lookup+0x2d>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   42a3a:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   42a41:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   42a48:	ff 
   42a49:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   42a50:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42a54:	83 e0 01             	and    $0x1,%eax
   42a57:	48 85 c0             	test   %rax,%rax
   42a5a:	74 34                	je     42a90 <virtual_memory_lookup+0xd6>
        vam.pn = PAGENUMBER(pe);
   42a5c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42a60:	48 c1 e8 0c          	shr    $0xc,%rax
   42a64:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   42a67:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42a6b:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42a71:	48 89 c2             	mov    %rax,%rdx
   42a74:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42a78:	25 ff 0f 00 00       	and    $0xfff,%eax
   42a7d:	48 09 d0             	or     %rdx,%rax
   42a80:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   42a84:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42a88:	25 ff 0f 00 00       	and    $0xfff,%eax
   42a8d:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   42a90:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42a94:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42a98:	48 89 10             	mov    %rdx,(%rax)
   42a9b:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   42a9f:	48 89 50 08          	mov    %rdx,0x8(%rax)
   42aa3:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42aa7:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   42aab:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42aaf:	c9                   	leave  
   42ab0:	c3                   	ret    

0000000000042ab1 <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   42ab1:	55                   	push   %rbp
   42ab2:	48 89 e5             	mov    %rsp,%rbp
   42ab5:	48 83 ec 40          	sub    $0x40,%rsp
   42ab9:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42abd:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   42ac0:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   42ac4:	c7 45 f8 04 00 00 00 	movl   $0x4,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   42acb:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   42acf:	78 08                	js     42ad9 <program_load+0x28>
   42ad1:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42ad4:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   42ad7:	7c 14                	jl     42aed <program_load+0x3c>
   42ad9:	ba 00 54 04 00       	mov    $0x45400,%edx
   42ade:	be 2e 00 00 00       	mov    $0x2e,%esi
   42ae3:	bf 30 54 04 00       	mov    $0x45430,%edi
   42ae8:	e8 0b f8 ff ff       	call   422f8 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   42aed:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42af0:	48 98                	cltq   
   42af2:	48 c1 e0 04          	shl    $0x4,%rax
   42af6:	48 05 20 60 04 00    	add    $0x46020,%rax
   42afc:	48 8b 00             	mov    (%rax),%rax
   42aff:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   42b03:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42b07:	8b 00                	mov    (%rax),%eax
   42b09:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   42b0e:	74 14                	je     42b24 <program_load+0x73>
   42b10:	ba 42 54 04 00       	mov    $0x45442,%edx
   42b15:	be 30 00 00 00       	mov    $0x30,%esi
   42b1a:	bf 30 54 04 00       	mov    $0x45430,%edi
   42b1f:	e8 d4 f7 ff ff       	call   422f8 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   42b24:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42b28:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42b2c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42b30:	48 01 d0             	add    %rdx,%rax
   42b33:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   42b37:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42b3e:	e9 94 00 00 00       	jmp    42bd7 <program_load+0x126>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   42b43:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42b46:	48 63 d0             	movslq %eax,%rdx
   42b49:	48 89 d0             	mov    %rdx,%rax
   42b4c:	48 c1 e0 03          	shl    $0x3,%rax
   42b50:	48 29 d0             	sub    %rdx,%rax
   42b53:	48 c1 e0 03          	shl    $0x3,%rax
   42b57:	48 89 c2             	mov    %rax,%rdx
   42b5a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b5e:	48 01 d0             	add    %rdx,%rax
   42b61:	8b 00                	mov    (%rax),%eax
   42b63:	83 f8 01             	cmp    $0x1,%eax
   42b66:	75 6b                	jne    42bd3 <program_load+0x122>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   42b68:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42b6b:	48 63 d0             	movslq %eax,%rdx
   42b6e:	48 89 d0             	mov    %rdx,%rax
   42b71:	48 c1 e0 03          	shl    $0x3,%rax
   42b75:	48 29 d0             	sub    %rdx,%rax
   42b78:	48 c1 e0 03          	shl    $0x3,%rax
   42b7c:	48 89 c2             	mov    %rax,%rdx
   42b7f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b83:	48 01 d0             	add    %rdx,%rax
   42b86:	48 8b 50 08          	mov    0x8(%rax),%rdx
   42b8a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42b8e:	48 01 d0             	add    %rdx,%rax
   42b91:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   42b95:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42b98:	48 63 d0             	movslq %eax,%rdx
   42b9b:	48 89 d0             	mov    %rdx,%rax
   42b9e:	48 c1 e0 03          	shl    $0x3,%rax
   42ba2:	48 29 d0             	sub    %rdx,%rax
   42ba5:	48 c1 e0 03          	shl    $0x3,%rax
   42ba9:	48 89 c2             	mov    %rax,%rdx
   42bac:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42bb0:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   42bb4:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42bb8:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42bbc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42bc0:	48 89 c7             	mov    %rax,%rdi
   42bc3:	e8 3d 00 00 00       	call   42c05 <program_load_segment>
   42bc8:	85 c0                	test   %eax,%eax
   42bca:	79 07                	jns    42bd3 <program_load+0x122>
                return -1;
   42bcc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42bd1:	eb 30                	jmp    42c03 <program_load+0x152>
    for (int i = 0; i < eh->e_phnum; ++i) {
   42bd3:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   42bd7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42bdb:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   42bdf:	0f b7 c0             	movzwl %ax,%eax
   42be2:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   42be5:	0f 8c 58 ff ff ff    	jl     42b43 <program_load+0x92>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   42beb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42bef:	48 8b 50 18          	mov    0x18(%rax),%rdx
   42bf3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42bf7:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    return 0;
   42bfe:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42c03:	c9                   	leave  
   42c04:	c3                   	ret    

0000000000042c05 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   42c05:	55                   	push   %rbp
   42c06:	48 89 e5             	mov    %rsp,%rbp
   42c09:	48 83 ec 70          	sub    $0x70,%rsp
   42c0d:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42c11:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   42c15:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   42c19:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   42c1d:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42c21:	48 8b 40 10          	mov    0x10(%rax),%rax
   42c25:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   42c29:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42c2d:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42c31:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c35:	48 01 d0             	add    %rdx,%rax
   42c38:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   42c3c:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42c40:	48 8b 50 28          	mov    0x28(%rax),%rdx
   42c44:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c48:	48 01 d0             	add    %rdx,%rax
   42c4b:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   42c4f:	48 81 65 e8 00 f0 ff 	andq   $0xfffffffffffff000,-0x18(%rbp)
   42c56:	ff 


    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42c57:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c5b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   42c5f:	eb 7c                	jmp    42cdd <program_load_segment+0xd8>
        uintptr_t pa = (uintptr_t)palloc(p->p_pid);
   42c61:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42c65:	8b 00                	mov    (%rax),%eax
   42c67:	89 c7                	mov    %eax,%edi
   42c69:	e8 4e 01 00 00       	call   42dbc <palloc>
   42c6e:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        if(pa == (uintptr_t)NULL || virtual_memory_map(p->p_pagetable, addr, pa, PAGESIZE,
   42c72:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   42c77:	74 2a                	je     42ca3 <program_load_segment+0x9e>
   42c79:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42c7d:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   42c84:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42c88:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   42c8c:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42c92:	b9 00 10 00 00       	mov    $0x1000,%ecx
   42c97:	48 89 c7             	mov    %rax,%rdi
   42c9a:	e8 58 f9 ff ff       	call   425f7 <virtual_memory_map>
   42c9f:	85 c0                	test   %eax,%eax
   42ca1:	79 32                	jns    42cd5 <program_load_segment+0xd0>
                    PTE_W | PTE_P | PTE_U) < 0) {
            console_printf(CPOS(22, 0), 0xC000,
   42ca3:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42ca7:	8b 00                	mov    (%rax),%eax
   42ca9:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42cad:	49 89 d0             	mov    %rdx,%r8
   42cb0:	89 c1                	mov    %eax,%ecx
   42cb2:	ba 60 54 04 00       	mov    $0x45460,%edx
   42cb7:	be 00 c0 00 00       	mov    $0xc000,%esi
   42cbc:	bf e0 06 00 00       	mov    $0x6e0,%edi
   42cc1:	b8 00 00 00 00       	mov    $0x0,%eax
   42cc6:	e8 da 1a 00 00       	call   447a5 <console_printf>
                    "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
            return -1;
   42ccb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42cd0:	e9 e5 00 00 00       	jmp    42dba <program_load_segment+0x1b5>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42cd5:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42cdc:	00 
   42cdd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42ce1:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   42ce5:	0f 82 76 ff ff ff    	jb     42c61 <program_load_segment+0x5c>
        }
    }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   42ceb:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42cef:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   42cf6:	48 89 c7             	mov    %rax,%rdi
   42cf9:	e8 c8 f7 ff ff       	call   424c6 <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   42cfe:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42d02:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   42d06:	48 89 c2             	mov    %rax,%rdx
   42d09:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d0d:	48 8b 4d 98          	mov    -0x68(%rbp),%rcx
   42d11:	48 89 ce             	mov    %rcx,%rsi
   42d14:	48 89 c7             	mov    %rax,%rdi
   42d17:	e8 d4 0b 00 00       	call   438f0 <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   42d1c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42d20:	48 2b 45 e0          	sub    -0x20(%rbp),%rax
   42d24:	48 89 c2             	mov    %rax,%rdx
   42d27:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42d2b:	be 00 00 00 00       	mov    $0x0,%esi
   42d30:	48 89 c7             	mov    %rax,%rdi
   42d33:	e8 b6 0c 00 00       	call   439ee <memset>

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   42d38:	48 8b 05 c1 e2 00 00 	mov    0xe2c1(%rip),%rax        # 51000 <kernel_pagetable>
   42d3f:	48 89 c7             	mov    %rax,%rdi
   42d42:	e8 7f f7 ff ff       	call   424c6 <set_pagetable>


    if((ph->p_flags & ELF_PFLAG_WRITE) == 0) {
   42d47:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42d4b:	8b 40 04             	mov    0x4(%rax),%eax
   42d4e:	83 e0 02             	and    $0x2,%eax
   42d51:	85 c0                	test   %eax,%eax
   42d53:	75 60                	jne    42db5 <program_load_segment+0x1b0>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42d55:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42d59:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   42d5d:	eb 4c                	jmp    42dab <program_load_segment+0x1a6>
            vamapping mapping = virtual_memory_lookup(p->p_pagetable, addr);
   42d5f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42d63:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   42d6a:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   42d6e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   42d72:	48 89 ce             	mov    %rcx,%rsi
   42d75:	48 89 c7             	mov    %rax,%rdi
   42d78:	e8 3d fc ff ff       	call   429ba <virtual_memory_lookup>

            virtual_memory_map(p->p_pagetable, addr, mapping.pa, PAGESIZE,
   42d7d:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42d81:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42d85:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   42d8c:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   42d90:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   42d96:	b9 00 10 00 00       	mov    $0x1000,%ecx
   42d9b:	48 89 c7             	mov    %rax,%rdi
   42d9e:	e8 54 f8 ff ff       	call   425f7 <virtual_memory_map>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42da3:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   42daa:	00 
   42dab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42daf:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   42db3:	72 aa                	jb     42d5f <program_load_segment+0x15a>
                    PTE_P | PTE_U);
        }
    }
    // TODO : Add code here
    return 0;
   42db5:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42dba:	c9                   	leave  
   42dbb:	c3                   	ret    

0000000000042dbc <palloc>:
   42dbc:	55                   	push   %rbp
   42dbd:	48 89 e5             	mov    %rsp,%rbp
   42dc0:	48 83 ec 20          	sub    $0x20,%rsp
   42dc4:	89 7d ec             	mov    %edi,-0x14(%rbp)
   42dc7:	48 c7 45 f8 00 10 00 	movq   $0x1000,-0x8(%rbp)
   42dce:	00 
   42dcf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42dd3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   42dd7:	e9 95 00 00 00       	jmp    42e71 <palloc+0xb5>
   42ddc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42de0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   42de4:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42deb:	00 
   42dec:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42df0:	48 c1 e8 0c          	shr    $0xc,%rax
   42df4:	48 98                	cltq   
   42df6:	0f b6 84 00 20 ef 04 	movzbl 0x4ef20(%rax,%rax,1),%eax
   42dfd:	00 
   42dfe:	84 c0                	test   %al,%al
   42e00:	75 6f                	jne    42e71 <palloc+0xb5>
   42e02:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e06:	48 c1 e8 0c          	shr    $0xc,%rax
   42e0a:	48 98                	cltq   
   42e0c:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   42e13:	00 
   42e14:	84 c0                	test   %al,%al
   42e16:	75 59                	jne    42e71 <palloc+0xb5>
   42e18:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e1c:	48 c1 e8 0c          	shr    $0xc,%rax
   42e20:	89 c2                	mov    %eax,%edx
   42e22:	48 63 c2             	movslq %edx,%rax
   42e25:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   42e2c:	00 
   42e2d:	83 c0 01             	add    $0x1,%eax
   42e30:	89 c1                	mov    %eax,%ecx
   42e32:	48 63 c2             	movslq %edx,%rax
   42e35:	88 8c 00 21 ef 04 00 	mov    %cl,0x4ef21(%rax,%rax,1)
   42e3c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e40:	48 c1 e8 0c          	shr    $0xc,%rax
   42e44:	89 c1                	mov    %eax,%ecx
   42e46:	8b 45 ec             	mov    -0x14(%rbp),%eax
   42e49:	89 c2                	mov    %eax,%edx
   42e4b:	48 63 c1             	movslq %ecx,%rax
   42e4e:	88 94 00 20 ef 04 00 	mov    %dl,0x4ef20(%rax,%rax,1)
   42e55:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e59:	ba 00 10 00 00       	mov    $0x1000,%edx
   42e5e:	be cc 00 00 00       	mov    $0xcc,%esi
   42e63:	48 89 c7             	mov    %rax,%rdi
   42e66:	e8 83 0b 00 00       	call   439ee <memset>
   42e6b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e6f:	eb 2c                	jmp    42e9d <palloc+0xe1>
   42e71:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   42e78:	00 
   42e79:	0f 86 5d ff ff ff    	jbe    42ddc <palloc+0x20>
   42e7f:	ba 98 54 04 00       	mov    $0x45498,%edx
   42e84:	be 00 0c 00 00       	mov    $0xc00,%esi
   42e89:	bf 80 07 00 00       	mov    $0x780,%edi
   42e8e:	b8 00 00 00 00       	mov    $0x0,%eax
   42e93:	e8 0d 19 00 00       	call   447a5 <console_printf>
   42e98:	b8 00 00 00 00       	mov    $0x0,%eax
   42e9d:	c9                   	leave  
   42e9e:	c3                   	ret    

0000000000042e9f <palloc_target>:
   42e9f:	55                   	push   %rbp
   42ea0:	48 89 e5             	mov    %rsp,%rbp
   42ea3:	48 8b 05 56 41 01 00 	mov    0x14156(%rip),%rax        # 57000 <palloc_target_proc>
   42eaa:	48 85 c0             	test   %rax,%rax
   42ead:	75 14                	jne    42ec3 <palloc_target+0x24>
   42eaf:	ba b1 54 04 00       	mov    $0x454b1,%edx
   42eb4:	be 27 00 00 00       	mov    $0x27,%esi
   42eb9:	bf cc 54 04 00       	mov    $0x454cc,%edi
   42ebe:	e8 35 f4 ff ff       	call   422f8 <assert_fail>
   42ec3:	48 8b 05 36 41 01 00 	mov    0x14136(%rip),%rax        # 57000 <palloc_target_proc>
   42eca:	8b 00                	mov    (%rax),%eax
   42ecc:	89 c7                	mov    %eax,%edi
   42ece:	e8 e9 fe ff ff       	call   42dbc <palloc>
   42ed3:	5d                   	pop    %rbp
   42ed4:	c3                   	ret    

0000000000042ed5 <process_free>:
   42ed5:	55                   	push   %rbp
   42ed6:	48 89 e5             	mov    %rsp,%rbp
   42ed9:	48 83 ec 60          	sub    $0x60,%rsp
   42edd:	89 7d ac             	mov    %edi,-0x54(%rbp)
   42ee0:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42ee3:	48 63 d0             	movslq %eax,%rdx
   42ee6:	48 89 d0             	mov    %rdx,%rax
   42ee9:	48 c1 e0 04          	shl    $0x4,%rax
   42eed:	48 29 d0             	sub    %rdx,%rax
   42ef0:	48 c1 e0 04          	shl    $0x4,%rax
   42ef4:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   42efa:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
   42f00:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   42f07:	00 
   42f08:	e9 ad 00 00 00       	jmp    42fba <process_free+0xe5>
   42f0d:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42f10:	48 63 d0             	movslq %eax,%rdx
   42f13:	48 89 d0             	mov    %rdx,%rax
   42f16:	48 c1 e0 04          	shl    $0x4,%rax
   42f1a:	48 29 d0             	sub    %rdx,%rax
   42f1d:	48 c1 e0 04          	shl    $0x4,%rax
   42f21:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   42f27:	48 8b 08             	mov    (%rax),%rcx
   42f2a:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   42f2e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42f32:	48 89 ce             	mov    %rcx,%rsi
   42f35:	48 89 c7             	mov    %rax,%rdi
   42f38:	e8 7d fa ff ff       	call   429ba <virtual_memory_lookup>
   42f3d:	8b 45 c8             	mov    -0x38(%rbp),%eax
   42f40:	48 98                	cltq   
   42f42:	83 e0 01             	and    $0x1,%eax
   42f45:	48 85 c0             	test   %rax,%rax
   42f48:	74 68                	je     42fb2 <process_free+0xdd>
   42f4a:	8b 45 b8             	mov    -0x48(%rbp),%eax
   42f4d:	48 63 d0             	movslq %eax,%rdx
   42f50:	0f b6 94 12 21 ef 04 	movzbl 0x4ef21(%rdx,%rdx,1),%edx
   42f57:	00 
   42f58:	83 ea 01             	sub    $0x1,%edx
   42f5b:	48 98                	cltq   
   42f5d:	88 94 00 21 ef 04 00 	mov    %dl,0x4ef21(%rax,%rax,1)
   42f64:	8b 45 b8             	mov    -0x48(%rbp),%eax
   42f67:	48 98                	cltq   
   42f69:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   42f70:	00 
   42f71:	84 c0                	test   %al,%al
   42f73:	75 0f                	jne    42f84 <process_free+0xaf>
   42f75:	8b 45 b8             	mov    -0x48(%rbp),%eax
   42f78:	48 98                	cltq   
   42f7a:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   42f81:	00 
   42f82:	eb 2e                	jmp    42fb2 <process_free+0xdd>
   42f84:	8b 45 b8             	mov    -0x48(%rbp),%eax
   42f87:	48 98                	cltq   
   42f89:	0f b6 84 00 20 ef 04 	movzbl 0x4ef20(%rax,%rax,1),%eax
   42f90:	00 
   42f91:	0f be c0             	movsbl %al,%eax
   42f94:	39 45 ac             	cmp    %eax,-0x54(%rbp)
   42f97:	75 19                	jne    42fb2 <process_free+0xdd>
   42f99:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42f9d:	8b 55 ac             	mov    -0x54(%rbp),%edx
   42fa0:	48 89 c6             	mov    %rax,%rsi
   42fa3:	bf d8 54 04 00       	mov    $0x454d8,%edi
   42fa8:	b8 00 00 00 00       	mov    $0x0,%eax
   42fad:	e8 28 f0 ff ff       	call   41fda <log_printf>
   42fb2:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42fb9:	00 
   42fba:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   42fc1:	00 
   42fc2:	0f 86 45 ff ff ff    	jbe    42f0d <process_free+0x38>
   42fc8:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42fcb:	48 63 d0             	movslq %eax,%rdx
   42fce:	48 89 d0             	mov    %rdx,%rax
   42fd1:	48 c1 e0 04          	shl    $0x4,%rax
   42fd5:	48 29 d0             	sub    %rdx,%rax
   42fd8:	48 c1 e0 04          	shl    $0x4,%rax
   42fdc:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   42fe2:	48 8b 00             	mov    (%rax),%rax
   42fe5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   42fe9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42fed:	48 8b 00             	mov    (%rax),%rax
   42ff0:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42ff6:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   42ffa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ffe:	48 8b 00             	mov    (%rax),%rax
   43001:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43007:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   4300b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4300f:	48 8b 00             	mov    (%rax),%rax
   43012:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43018:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   4301c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43020:	48 8b 40 08          	mov    0x8(%rax),%rax
   43024:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4302a:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
   4302e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43032:	48 c1 e8 0c          	shr    $0xc,%rax
   43036:	48 98                	cltq   
   43038:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   4303f:	00 
   43040:	3c 01                	cmp    $0x1,%al
   43042:	74 14                	je     43058 <process_free+0x183>
   43044:	ba 10 55 04 00       	mov    $0x45510,%edx
   43049:	be 4f 00 00 00       	mov    $0x4f,%esi
   4304e:	bf cc 54 04 00       	mov    $0x454cc,%edi
   43053:	e8 a0 f2 ff ff       	call   422f8 <assert_fail>
   43058:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4305c:	48 c1 e8 0c          	shr    $0xc,%rax
   43060:	48 98                	cltq   
   43062:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43069:	00 
   4306a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4306e:	48 c1 e8 0c          	shr    $0xc,%rax
   43072:	48 98                	cltq   
   43074:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   4307b:	00 
   4307c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43080:	48 c1 e8 0c          	shr    $0xc,%rax
   43084:	48 98                	cltq   
   43086:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   4308d:	00 
   4308e:	3c 01                	cmp    $0x1,%al
   43090:	74 14                	je     430a6 <process_free+0x1d1>
   43092:	ba 38 55 04 00       	mov    $0x45538,%edx
   43097:	be 52 00 00 00       	mov    $0x52,%esi
   4309c:	bf cc 54 04 00       	mov    $0x454cc,%edi
   430a1:	e8 52 f2 ff ff       	call   422f8 <assert_fail>
   430a6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   430aa:	48 c1 e8 0c          	shr    $0xc,%rax
   430ae:	48 98                	cltq   
   430b0:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   430b7:	00 
   430b8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   430bc:	48 c1 e8 0c          	shr    $0xc,%rax
   430c0:	48 98                	cltq   
   430c2:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   430c9:	00 
   430ca:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   430ce:	48 c1 e8 0c          	shr    $0xc,%rax
   430d2:	48 98                	cltq   
   430d4:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   430db:	00 
   430dc:	3c 01                	cmp    $0x1,%al
   430de:	74 14                	je     430f4 <process_free+0x21f>
   430e0:	ba 60 55 04 00       	mov    $0x45560,%edx
   430e5:	be 55 00 00 00       	mov    $0x55,%esi
   430ea:	bf cc 54 04 00       	mov    $0x454cc,%edi
   430ef:	e8 04 f2 ff ff       	call   422f8 <assert_fail>
   430f4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   430f8:	48 c1 e8 0c          	shr    $0xc,%rax
   430fc:	48 98                	cltq   
   430fe:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43105:	00 
   43106:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4310a:	48 c1 e8 0c          	shr    $0xc,%rax
   4310e:	48 98                	cltq   
   43110:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43117:	00 
   43118:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4311c:	48 c1 e8 0c          	shr    $0xc,%rax
   43120:	48 98                	cltq   
   43122:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   43129:	00 
   4312a:	3c 01                	cmp    $0x1,%al
   4312c:	74 14                	je     43142 <process_free+0x26d>
   4312e:	ba 88 55 04 00       	mov    $0x45588,%edx
   43133:	be 58 00 00 00       	mov    $0x58,%esi
   43138:	bf cc 54 04 00       	mov    $0x454cc,%edi
   4313d:	e8 b6 f1 ff ff       	call   422f8 <assert_fail>
   43142:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43146:	48 c1 e8 0c          	shr    $0xc,%rax
   4314a:	48 98                	cltq   
   4314c:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43153:	00 
   43154:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43158:	48 c1 e8 0c          	shr    $0xc,%rax
   4315c:	48 98                	cltq   
   4315e:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43165:	00 
   43166:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4316a:	48 c1 e8 0c          	shr    $0xc,%rax
   4316e:	48 98                	cltq   
   43170:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   43177:	00 
   43178:	3c 01                	cmp    $0x1,%al
   4317a:	74 14                	je     43190 <process_free+0x2bb>
   4317c:	ba b0 55 04 00       	mov    $0x455b0,%edx
   43181:	be 5b 00 00 00       	mov    $0x5b,%esi
   43186:	bf cc 54 04 00       	mov    $0x454cc,%edi
   4318b:	e8 68 f1 ff ff       	call   422f8 <assert_fail>
   43190:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43194:	48 c1 e8 0c          	shr    $0xc,%rax
   43198:	48 98                	cltq   
   4319a:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   431a1:	00 
   431a2:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   431a6:	48 c1 e8 0c          	shr    $0xc,%rax
   431aa:	48 98                	cltq   
   431ac:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   431b3:	00 
   431b4:	90                   	nop
   431b5:	c9                   	leave  
   431b6:	c3                   	ret    

00000000000431b7 <process_config_tables>:
   431b7:	55                   	push   %rbp
   431b8:	48 89 e5             	mov    %rsp,%rbp
   431bb:	48 83 ec 40          	sub    $0x40,%rsp
   431bf:	89 7d cc             	mov    %edi,-0x34(%rbp)
   431c2:	8b 45 cc             	mov    -0x34(%rbp),%eax
   431c5:	89 c7                	mov    %eax,%edi
   431c7:	e8 f0 fb ff ff       	call   42dbc <palloc>
   431cc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   431d0:	8b 45 cc             	mov    -0x34(%rbp),%eax
   431d3:	89 c7                	mov    %eax,%edi
   431d5:	e8 e2 fb ff ff       	call   42dbc <palloc>
   431da:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   431de:	8b 45 cc             	mov    -0x34(%rbp),%eax
   431e1:	89 c7                	mov    %eax,%edi
   431e3:	e8 d4 fb ff ff       	call   42dbc <palloc>
   431e8:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   431ec:	8b 45 cc             	mov    -0x34(%rbp),%eax
   431ef:	89 c7                	mov    %eax,%edi
   431f1:	e8 c6 fb ff ff       	call   42dbc <palloc>
   431f6:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   431fa:	8b 45 cc             	mov    -0x34(%rbp),%eax
   431fd:	89 c7                	mov    %eax,%edi
   431ff:	e8 b8 fb ff ff       	call   42dbc <palloc>
   43204:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   43208:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   4320d:	74 20                	je     4322f <process_config_tables+0x78>
   4320f:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   43214:	74 19                	je     4322f <process_config_tables+0x78>
   43216:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4321b:	74 12                	je     4322f <process_config_tables+0x78>
   4321d:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43222:	74 0b                	je     4322f <process_config_tables+0x78>
   43224:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43229:	0f 85 e1 00 00 00    	jne    43310 <process_config_tables+0x159>
   4322f:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   43234:	74 24                	je     4325a <process_config_tables+0xa3>
   43236:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4323a:	48 c1 e8 0c          	shr    $0xc,%rax
   4323e:	48 98                	cltq   
   43240:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43247:	00 
   43248:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4324c:	48 c1 e8 0c          	shr    $0xc,%rax
   43250:	48 98                	cltq   
   43252:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43259:	00 
   4325a:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   4325f:	74 24                	je     43285 <process_config_tables+0xce>
   43261:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43265:	48 c1 e8 0c          	shr    $0xc,%rax
   43269:	48 98                	cltq   
   4326b:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43272:	00 
   43273:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43277:	48 c1 e8 0c          	shr    $0xc,%rax
   4327b:	48 98                	cltq   
   4327d:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43284:	00 
   43285:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4328a:	74 24                	je     432b0 <process_config_tables+0xf9>
   4328c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43290:	48 c1 e8 0c          	shr    $0xc,%rax
   43294:	48 98                	cltq   
   43296:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   4329d:	00 
   4329e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   432a2:	48 c1 e8 0c          	shr    $0xc,%rax
   432a6:	48 98                	cltq   
   432a8:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   432af:	00 
   432b0:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   432b5:	74 24                	je     432db <process_config_tables+0x124>
   432b7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   432bb:	48 c1 e8 0c          	shr    $0xc,%rax
   432bf:	48 98                	cltq   
   432c1:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   432c8:	00 
   432c9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   432cd:	48 c1 e8 0c          	shr    $0xc,%rax
   432d1:	48 98                	cltq   
   432d3:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   432da:	00 
   432db:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   432e0:	74 24                	je     43306 <process_config_tables+0x14f>
   432e2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   432e6:	48 c1 e8 0c          	shr    $0xc,%rax
   432ea:	48 98                	cltq   
   432ec:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   432f3:	00 
   432f4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   432f8:	48 c1 e8 0c          	shr    $0xc,%rax
   432fc:	48 98                	cltq   
   432fe:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43305:	00 
   43306:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4330b:	e9 f3 01 00 00       	jmp    43503 <process_config_tables+0x34c>
   43310:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43314:	ba 00 10 00 00       	mov    $0x1000,%edx
   43319:	be 00 00 00 00       	mov    $0x0,%esi
   4331e:	48 89 c7             	mov    %rax,%rdi
   43321:	e8 c8 06 00 00       	call   439ee <memset>
   43326:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4332a:	ba 00 10 00 00       	mov    $0x1000,%edx
   4332f:	be 00 00 00 00       	mov    $0x0,%esi
   43334:	48 89 c7             	mov    %rax,%rdi
   43337:	e8 b2 06 00 00       	call   439ee <memset>
   4333c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43340:	ba 00 10 00 00       	mov    $0x1000,%edx
   43345:	be 00 00 00 00       	mov    $0x0,%esi
   4334a:	48 89 c7             	mov    %rax,%rdi
   4334d:	e8 9c 06 00 00       	call   439ee <memset>
   43352:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43356:	ba 00 10 00 00       	mov    $0x1000,%edx
   4335b:	be 00 00 00 00       	mov    $0x0,%esi
   43360:	48 89 c7             	mov    %rax,%rdi
   43363:	e8 86 06 00 00       	call   439ee <memset>
   43368:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4336c:	ba 00 10 00 00       	mov    $0x1000,%edx
   43371:	be 00 00 00 00       	mov    $0x0,%esi
   43376:	48 89 c7             	mov    %rax,%rdi
   43379:	e8 70 06 00 00       	call   439ee <memset>
   4337e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43382:	48 83 c8 07          	or     $0x7,%rax
   43386:	48 89 c2             	mov    %rax,%rdx
   43389:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4338d:	48 89 10             	mov    %rdx,(%rax)
   43390:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43394:	48 83 c8 07          	or     $0x7,%rax
   43398:	48 89 c2             	mov    %rax,%rdx
   4339b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4339f:	48 89 10             	mov    %rdx,(%rax)
   433a2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   433a6:	48 83 c8 07          	or     $0x7,%rax
   433aa:	48 89 c2             	mov    %rax,%rdx
   433ad:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   433b1:	48 89 10             	mov    %rdx,(%rax)
   433b4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   433b8:	48 83 c8 07          	or     $0x7,%rax
   433bc:	48 89 c2             	mov    %rax,%rdx
   433bf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   433c3:	48 89 50 08          	mov    %rdx,0x8(%rax)
   433c7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   433cb:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   433d1:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   433d7:	b9 00 00 10 00       	mov    $0x100000,%ecx
   433dc:	ba 00 00 00 00       	mov    $0x0,%edx
   433e1:	be 00 00 00 00       	mov    $0x0,%esi
   433e6:	48 89 c7             	mov    %rax,%rdi
   433e9:	e8 09 f2 ff ff       	call   425f7 <virtual_memory_map>
   433ee:	85 c0                	test   %eax,%eax
   433f0:	75 2f                	jne    43421 <process_config_tables+0x26a>
   433f2:	ba 00 80 0b 00       	mov    $0xb8000,%edx
   433f7:	be 00 80 0b 00       	mov    $0xb8000,%esi
   433fc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43400:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43406:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4340c:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43411:	48 89 c7             	mov    %rax,%rdi
   43414:	e8 de f1 ff ff       	call   425f7 <virtual_memory_map>
   43419:	85 c0                	test   %eax,%eax
   4341b:	0f 84 bb 00 00 00    	je     434dc <process_config_tables+0x325>
   43421:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43425:	48 c1 e8 0c          	shr    $0xc,%rax
   43429:	48 98                	cltq   
   4342b:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43432:	00 
   43433:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43437:	48 c1 e8 0c          	shr    $0xc,%rax
   4343b:	48 98                	cltq   
   4343d:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43444:	00 
   43445:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43449:	48 c1 e8 0c          	shr    $0xc,%rax
   4344d:	48 98                	cltq   
   4344f:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   43456:	00 
   43457:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4345b:	48 c1 e8 0c          	shr    $0xc,%rax
   4345f:	48 98                	cltq   
   43461:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   43468:	00 
   43469:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4346d:	48 c1 e8 0c          	shr    $0xc,%rax
   43471:	48 98                	cltq   
   43473:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   4347a:	00 
   4347b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4347f:	48 c1 e8 0c          	shr    $0xc,%rax
   43483:	48 98                	cltq   
   43485:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   4348c:	00 
   4348d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43491:	48 c1 e8 0c          	shr    $0xc,%rax
   43495:	48 98                	cltq   
   43497:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   4349e:	00 
   4349f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   434a3:	48 c1 e8 0c          	shr    $0xc,%rax
   434a7:	48 98                	cltq   
   434a9:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   434b0:	00 
   434b1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   434b5:	48 c1 e8 0c          	shr    $0xc,%rax
   434b9:	48 98                	cltq   
   434bb:	c6 84 00 20 ef 04 00 	movb   $0x0,0x4ef20(%rax,%rax,1)
   434c2:	00 
   434c3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   434c7:	48 c1 e8 0c          	shr    $0xc,%rax
   434cb:	48 98                	cltq   
   434cd:	c6 84 00 21 ef 04 00 	movb   $0x0,0x4ef21(%rax,%rax,1)
   434d4:	00 
   434d5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   434da:	eb 27                	jmp    43503 <process_config_tables+0x34c>
   434dc:	8b 45 cc             	mov    -0x34(%rbp),%eax
   434df:	48 63 d0             	movslq %eax,%rdx
   434e2:	48 89 d0             	mov    %rdx,%rax
   434e5:	48 c1 e0 04          	shl    $0x4,%rax
   434e9:	48 29 d0             	sub    %rdx,%rax
   434ec:	48 c1 e0 04          	shl    $0x4,%rax
   434f0:	48 8d 90 e0 e0 04 00 	lea    0x4e0e0(%rax),%rdx
   434f7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   434fb:	48 89 02             	mov    %rax,(%rdx)
   434fe:	b8 00 00 00 00       	mov    $0x0,%eax
   43503:	c9                   	leave  
   43504:	c3                   	ret    

0000000000043505 <process_load>:
   43505:	55                   	push   %rbp
   43506:	48 89 e5             	mov    %rsp,%rbp
   43509:	48 83 ec 20          	sub    $0x20,%rsp
   4350d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43511:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   43514:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43518:	48 89 05 e1 3a 01 00 	mov    %rax,0x13ae1(%rip)        # 57000 <palloc_target_proc>
   4351f:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
   43522:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43526:	ba 9f 2e 04 00       	mov    $0x42e9f,%edx
   4352b:	89 ce                	mov    %ecx,%esi
   4352d:	48 89 c7             	mov    %rax,%rdi
   43530:	e8 7c f5 ff ff       	call   42ab1 <program_load>
   43535:	89 45 fc             	mov    %eax,-0x4(%rbp)
   43538:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4353b:	c9                   	leave  
   4353c:	c3                   	ret    

000000000004353d <process_setup_stack>:
   4353d:	55                   	push   %rbp
   4353e:	48 89 e5             	mov    %rsp,%rbp
   43541:	48 83 ec 20          	sub    $0x20,%rsp
   43545:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43549:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4354d:	8b 00                	mov    (%rax),%eax
   4354f:	89 c7                	mov    %eax,%edi
   43551:	e8 66 f8 ff ff       	call   42dbc <palloc>
   43556:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   4355a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4355e:	48 c7 80 c8 00 00 00 	movq   $0x300000,0xc8(%rax)
   43565:	00 00 30 00 
   43569:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4356d:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   43574:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43578:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   4357e:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43584:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43589:	be 00 f0 2f 00       	mov    $0x2ff000,%esi
   4358e:	48 89 c7             	mov    %rax,%rdi
   43591:	e8 61 f0 ff ff       	call   425f7 <virtual_memory_map>
   43596:	90                   	nop
   43597:	c9                   	leave  
   43598:	c3                   	ret    

0000000000043599 <find_free_pid>:
   43599:	55                   	push   %rbp
   4359a:	48 89 e5             	mov    %rsp,%rbp
   4359d:	48 83 ec 10          	sub    $0x10,%rsp
   435a1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   435a8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
   435af:	eb 24                	jmp    435d5 <find_free_pid+0x3c>
   435b1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   435b4:	48 63 d0             	movslq %eax,%rdx
   435b7:	48 89 d0             	mov    %rdx,%rax
   435ba:	48 c1 e0 04          	shl    $0x4,%rax
   435be:	48 29 d0             	sub    %rdx,%rax
   435c1:	48 c1 e0 04          	shl    $0x4,%rax
   435c5:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   435cb:	8b 00                	mov    (%rax),%eax
   435cd:	85 c0                	test   %eax,%eax
   435cf:	74 0c                	je     435dd <find_free_pid+0x44>
   435d1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   435d5:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   435d9:	7e d6                	jle    435b1 <find_free_pid+0x18>
   435db:	eb 01                	jmp    435de <find_free_pid+0x45>
   435dd:	90                   	nop
   435de:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   435e2:	74 05                	je     435e9 <find_free_pid+0x50>
   435e4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   435e7:	eb 05                	jmp    435ee <find_free_pid+0x55>
   435e9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   435ee:	c9                   	leave  
   435ef:	c3                   	ret    

00000000000435f0 <process_fork>:
   435f0:	55                   	push   %rbp
   435f1:	48 89 e5             	mov    %rsp,%rbp
   435f4:	48 83 ec 40          	sub    $0x40,%rsp
   435f8:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   435fc:	b8 00 00 00 00       	mov    $0x0,%eax
   43601:	e8 93 ff ff ff       	call   43599 <find_free_pid>
   43606:	89 45 f4             	mov    %eax,-0xc(%rbp)
   43609:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%rbp)
   4360d:	75 0a                	jne    43619 <process_fork+0x29>
   4360f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43614:	e9 67 02 00 00       	jmp    43880 <process_fork+0x290>
   43619:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4361c:	48 63 d0             	movslq %eax,%rdx
   4361f:	48 89 d0             	mov    %rdx,%rax
   43622:	48 c1 e0 04          	shl    $0x4,%rax
   43626:	48 29 d0             	sub    %rdx,%rax
   43629:	48 c1 e0 04          	shl    $0x4,%rax
   4362d:	48 05 00 e0 04 00    	add    $0x4e000,%rax
   43633:	be 00 00 00 00       	mov    $0x0,%esi
   43638:	48 89 c7             	mov    %rax,%rdi
   4363b:	e8 ea e4 ff ff       	call   41b2a <process_init>
   43640:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43643:	89 c7                	mov    %eax,%edi
   43645:	e8 6d fb ff ff       	call   431b7 <process_config_tables>
   4364a:	83 f8 ff             	cmp    $0xffffffff,%eax
   4364d:	75 0a                	jne    43659 <process_fork+0x69>
   4364f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43654:	e9 27 02 00 00       	jmp    43880 <process_fork+0x290>
   43659:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   43660:	00 
   43661:	e9 79 01 00 00       	jmp    437df <process_fork+0x1ef>
   43666:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4366a:	8b 00                	mov    (%rax),%eax
   4366c:	48 63 d0             	movslq %eax,%rdx
   4366f:	48 89 d0             	mov    %rdx,%rax
   43672:	48 c1 e0 04          	shl    $0x4,%rax
   43676:	48 29 d0             	sub    %rdx,%rax
   43679:	48 c1 e0 04          	shl    $0x4,%rax
   4367d:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   43683:	48 8b 08             	mov    (%rax),%rcx
   43686:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4368a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4368e:	48 89 ce             	mov    %rcx,%rsi
   43691:	48 89 c7             	mov    %rax,%rdi
   43694:	e8 21 f3 ff ff       	call   429ba <virtual_memory_lookup>
   43699:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4369c:	48 98                	cltq   
   4369e:	83 e0 07             	and    $0x7,%eax
   436a1:	48 83 f8 07          	cmp    $0x7,%rax
   436a5:	0f 85 a1 00 00 00    	jne    4374c <process_fork+0x15c>
   436ab:	8b 45 f4             	mov    -0xc(%rbp),%eax
   436ae:	89 c7                	mov    %eax,%edi
   436b0:	e8 07 f7 ff ff       	call   42dbc <palloc>
   436b5:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   436b9:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   436be:	75 14                	jne    436d4 <process_fork+0xe4>
   436c0:	8b 45 f4             	mov    -0xc(%rbp),%eax
   436c3:	89 c7                	mov    %eax,%edi
   436c5:	e8 0b f8 ff ff       	call   42ed5 <process_free>
   436ca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   436cf:	e9 ac 01 00 00       	jmp    43880 <process_fork+0x290>
   436d4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   436d8:	48 89 c1             	mov    %rax,%rcx
   436db:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   436df:	ba 00 10 00 00       	mov    $0x1000,%edx
   436e4:	48 89 ce             	mov    %rcx,%rsi
   436e7:	48 89 c7             	mov    %rax,%rdi
   436ea:	e8 01 02 00 00       	call   438f0 <memcpy>
   436ef:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
   436f3:	8b 45 f4             	mov    -0xc(%rbp),%eax
   436f6:	48 63 d0             	movslq %eax,%rdx
   436f9:	48 89 d0             	mov    %rdx,%rax
   436fc:	48 c1 e0 04          	shl    $0x4,%rax
   43700:	48 29 d0             	sub    %rdx,%rax
   43703:	48 c1 e0 04          	shl    $0x4,%rax
   43707:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   4370d:	48 8b 00             	mov    (%rax),%rax
   43710:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   43714:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   4371a:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43720:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43725:	48 89 fa             	mov    %rdi,%rdx
   43728:	48 89 c7             	mov    %rax,%rdi
   4372b:	e8 c7 ee ff ff       	call   425f7 <virtual_memory_map>
   43730:	85 c0                	test   %eax,%eax
   43732:	0f 84 9f 00 00 00    	je     437d7 <process_fork+0x1e7>
   43738:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4373b:	89 c7                	mov    %eax,%edi
   4373d:	e8 93 f7 ff ff       	call   42ed5 <process_free>
   43742:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43747:	e9 34 01 00 00       	jmp    43880 <process_fork+0x290>
   4374c:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4374f:	48 98                	cltq   
   43751:	83 e0 05             	and    $0x5,%eax
   43754:	48 83 f8 05          	cmp    $0x5,%rax
   43758:	75 7d                	jne    437d7 <process_fork+0x1e7>
   4375a:	48 8b 7d d8          	mov    -0x28(%rbp),%rdi
   4375e:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43761:	48 63 d0             	movslq %eax,%rdx
   43764:	48 89 d0             	mov    %rdx,%rax
   43767:	48 c1 e0 04          	shl    $0x4,%rax
   4376b:	48 29 d0             	sub    %rdx,%rax
   4376e:	48 c1 e0 04          	shl    $0x4,%rax
   43772:	48 05 e0 e0 04 00    	add    $0x4e0e0,%rax
   43778:	48 8b 00             	mov    (%rax),%rax
   4377b:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   4377f:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43785:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   4378b:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43790:	48 89 fa             	mov    %rdi,%rdx
   43793:	48 89 c7             	mov    %rax,%rdi
   43796:	e8 5c ee ff ff       	call   425f7 <virtual_memory_map>
   4379b:	85 c0                	test   %eax,%eax
   4379d:	74 14                	je     437b3 <process_fork+0x1c3>
   4379f:	8b 45 f4             	mov    -0xc(%rbp),%eax
   437a2:	89 c7                	mov    %eax,%edi
   437a4:	e8 2c f7 ff ff       	call   42ed5 <process_free>
   437a9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   437ae:	e9 cd 00 00 00       	jmp    43880 <process_fork+0x290>
   437b3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   437b7:	48 c1 e8 0c          	shr    $0xc,%rax
   437bb:	89 c2                	mov    %eax,%edx
   437bd:	48 63 c2             	movslq %edx,%rax
   437c0:	0f b6 84 00 21 ef 04 	movzbl 0x4ef21(%rax,%rax,1),%eax
   437c7:	00 
   437c8:	83 c0 01             	add    $0x1,%eax
   437cb:	89 c1                	mov    %eax,%ecx
   437cd:	48 63 c2             	movslq %edx,%rax
   437d0:	88 8c 00 21 ef 04 00 	mov    %cl,0x4ef21(%rax,%rax,1)
   437d7:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   437de:	00 
   437df:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   437e6:	00 
   437e7:	0f 86 79 fe ff ff    	jbe    43666 <process_fork+0x76>
   437ed:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   437f1:	8b 08                	mov    (%rax),%ecx
   437f3:	8b 45 f4             	mov    -0xc(%rbp),%eax
   437f6:	48 63 d0             	movslq %eax,%rdx
   437f9:	48 89 d0             	mov    %rdx,%rax
   437fc:	48 c1 e0 04          	shl    $0x4,%rax
   43800:	48 29 d0             	sub    %rdx,%rax
   43803:	48 c1 e0 04          	shl    $0x4,%rax
   43807:	48 8d b0 10 e0 04 00 	lea    0x4e010(%rax),%rsi
   4380e:	48 63 d1             	movslq %ecx,%rdx
   43811:	48 89 d0             	mov    %rdx,%rax
   43814:	48 c1 e0 04          	shl    $0x4,%rax
   43818:	48 29 d0             	sub    %rdx,%rax
   4381b:	48 c1 e0 04          	shl    $0x4,%rax
   4381f:	48 8d 90 10 e0 04 00 	lea    0x4e010(%rax),%rdx
   43826:	48 8d 46 08          	lea    0x8(%rsi),%rax
   4382a:	48 83 c2 08          	add    $0x8,%rdx
   4382e:	b9 18 00 00 00       	mov    $0x18,%ecx
   43833:	48 89 c7             	mov    %rax,%rdi
   43836:	48 89 d6             	mov    %rdx,%rsi
   43839:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
   4383c:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4383f:	48 63 d0             	movslq %eax,%rdx
   43842:	48 89 d0             	mov    %rdx,%rax
   43845:	48 c1 e0 04          	shl    $0x4,%rax
   43849:	48 29 d0             	sub    %rdx,%rax
   4384c:	48 c1 e0 04          	shl    $0x4,%rax
   43850:	48 05 18 e0 04 00    	add    $0x4e018,%rax
   43856:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
   4385d:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43860:	48 63 d0             	movslq %eax,%rdx
   43863:	48 89 d0             	mov    %rdx,%rax
   43866:	48 c1 e0 04          	shl    $0x4,%rax
   4386a:	48 29 d0             	sub    %rdx,%rax
   4386d:	48 c1 e0 04          	shl    $0x4,%rax
   43871:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   43877:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
   4387d:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43880:	c9                   	leave  
   43881:	c3                   	ret    

0000000000043882 <process_page_alloc>:
   43882:	55                   	push   %rbp
   43883:	48 89 e5             	mov    %rsp,%rbp
   43886:	48 83 ec 20          	sub    $0x20,%rsp
   4388a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4388e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43892:	48 81 7d e0 ff ff 0f 	cmpq   $0xfffff,-0x20(%rbp)
   43899:	00 
   4389a:	77 07                	ja     438a3 <process_page_alloc+0x21>
   4389c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   438a1:	eb 4b                	jmp    438ee <process_page_alloc+0x6c>
   438a3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   438a7:	8b 00                	mov    (%rax),%eax
   438a9:	89 c7                	mov    %eax,%edi
   438ab:	e8 0c f5 ff ff       	call   42dbc <palloc>
   438b0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   438b4:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   438b9:	74 2e                	je     438e9 <process_page_alloc+0x67>
   438bb:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   438bf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   438c3:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   438ca:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
   438ce:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   438d4:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   438da:	b9 00 10 00 00       	mov    $0x1000,%ecx
   438df:	48 89 c7             	mov    %rax,%rdi
   438e2:	e8 10 ed ff ff       	call   425f7 <virtual_memory_map>
   438e7:	eb 05                	jmp    438ee <process_page_alloc+0x6c>
   438e9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   438ee:	c9                   	leave  
   438ef:	c3                   	ret    

00000000000438f0 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   438f0:	55                   	push   %rbp
   438f1:	48 89 e5             	mov    %rsp,%rbp
   438f4:	48 83 ec 28          	sub    $0x28,%rsp
   438f8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   438fc:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43900:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43904:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43908:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   4390c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43910:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43914:	eb 1c                	jmp    43932 <memcpy+0x42>
        *d = *s;
   43916:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4391a:	0f b6 10             	movzbl (%rax),%edx
   4391d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43921:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43923:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43928:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   4392d:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   43932:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43937:	75 dd                	jne    43916 <memcpy+0x26>
    }
    return dst;
   43939:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   4393d:	c9                   	leave  
   4393e:	c3                   	ret    

000000000004393f <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   4393f:	55                   	push   %rbp
   43940:	48 89 e5             	mov    %rsp,%rbp
   43943:	48 83 ec 28          	sub    $0x28,%rsp
   43947:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4394b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   4394f:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43953:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43957:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   4395b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4395f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   43963:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43967:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   4396b:	73 6a                	jae    439d7 <memmove+0x98>
   4396d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43971:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43975:	48 01 d0             	add    %rdx,%rax
   43978:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   4397c:	73 59                	jae    439d7 <memmove+0x98>
        s += n, d += n;
   4397e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43982:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   43986:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4398a:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   4398e:	eb 17                	jmp    439a7 <memmove+0x68>
            *--d = *--s;
   43990:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   43995:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   4399a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4399e:	0f b6 10             	movzbl (%rax),%edx
   439a1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   439a5:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   439a7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   439ab:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   439af:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   439b3:	48 85 c0             	test   %rax,%rax
   439b6:	75 d8                	jne    43990 <memmove+0x51>
    if (s < d && s + n > d) {
   439b8:	eb 2e                	jmp    439e8 <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   439ba:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   439be:	48 8d 42 01          	lea    0x1(%rdx),%rax
   439c2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   439c6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   439ca:	48 8d 48 01          	lea    0x1(%rax),%rcx
   439ce:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   439d2:	0f b6 12             	movzbl (%rdx),%edx
   439d5:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   439d7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   439db:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   439df:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   439e3:	48 85 c0             	test   %rax,%rax
   439e6:	75 d2                	jne    439ba <memmove+0x7b>
        }
    }
    return dst;
   439e8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   439ec:	c9                   	leave  
   439ed:	c3                   	ret    

00000000000439ee <memset>:

void* memset(void* v, int c, size_t n) {
   439ee:	55                   	push   %rbp
   439ef:	48 89 e5             	mov    %rsp,%rbp
   439f2:	48 83 ec 28          	sub    $0x28,%rsp
   439f6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   439fa:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   439fd:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43a01:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43a05:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43a09:	eb 15                	jmp    43a20 <memset+0x32>
        *p = c;
   43a0b:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43a0e:	89 c2                	mov    %eax,%edx
   43a10:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43a14:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43a16:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43a1b:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43a20:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43a25:	75 e4                	jne    43a0b <memset+0x1d>
    }
    return v;
   43a27:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43a2b:	c9                   	leave  
   43a2c:	c3                   	ret    

0000000000043a2d <strlen>:

size_t strlen(const char* s) {
   43a2d:	55                   	push   %rbp
   43a2e:	48 89 e5             	mov    %rsp,%rbp
   43a31:	48 83 ec 18          	sub    $0x18,%rsp
   43a35:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   43a39:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43a40:	00 
   43a41:	eb 0a                	jmp    43a4d <strlen+0x20>
        ++n;
   43a43:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   43a48:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43a4d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43a51:	0f b6 00             	movzbl (%rax),%eax
   43a54:	84 c0                	test   %al,%al
   43a56:	75 eb                	jne    43a43 <strlen+0x16>
    }
    return n;
   43a58:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43a5c:	c9                   	leave  
   43a5d:	c3                   	ret    

0000000000043a5e <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   43a5e:	55                   	push   %rbp
   43a5f:	48 89 e5             	mov    %rsp,%rbp
   43a62:	48 83 ec 20          	sub    $0x20,%rsp
   43a66:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43a6a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43a6e:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43a75:	00 
   43a76:	eb 0a                	jmp    43a82 <strnlen+0x24>
        ++n;
   43a78:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43a7d:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43a82:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43a86:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   43a8a:	74 0b                	je     43a97 <strnlen+0x39>
   43a8c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43a90:	0f b6 00             	movzbl (%rax),%eax
   43a93:	84 c0                	test   %al,%al
   43a95:	75 e1                	jne    43a78 <strnlen+0x1a>
    }
    return n;
   43a97:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43a9b:	c9                   	leave  
   43a9c:	c3                   	ret    

0000000000043a9d <strcpy>:

char* strcpy(char* dst, const char* src) {
   43a9d:	55                   	push   %rbp
   43a9e:	48 89 e5             	mov    %rsp,%rbp
   43aa1:	48 83 ec 20          	sub    $0x20,%rsp
   43aa5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43aa9:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   43aad:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43ab1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   43ab5:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43ab9:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43abd:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43ac1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43ac5:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43ac9:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   43acd:	0f b6 12             	movzbl (%rdx),%edx
   43ad0:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   43ad2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43ad6:	48 83 e8 01          	sub    $0x1,%rax
   43ada:	0f b6 00             	movzbl (%rax),%eax
   43add:	84 c0                	test   %al,%al
   43adf:	75 d4                	jne    43ab5 <strcpy+0x18>
    return dst;
   43ae1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43ae5:	c9                   	leave  
   43ae6:	c3                   	ret    

0000000000043ae7 <strcmp>:

int strcmp(const char* a, const char* b) {
   43ae7:	55                   	push   %rbp
   43ae8:	48 89 e5             	mov    %rsp,%rbp
   43aeb:	48 83 ec 10          	sub    $0x10,%rsp
   43aef:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43af3:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43af7:	eb 0a                	jmp    43b03 <strcmp+0x1c>
        ++a, ++b;
   43af9:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43afe:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43b03:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43b07:	0f b6 00             	movzbl (%rax),%eax
   43b0a:	84 c0                	test   %al,%al
   43b0c:	74 1d                	je     43b2b <strcmp+0x44>
   43b0e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43b12:	0f b6 00             	movzbl (%rax),%eax
   43b15:	84 c0                	test   %al,%al
   43b17:	74 12                	je     43b2b <strcmp+0x44>
   43b19:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43b1d:	0f b6 10             	movzbl (%rax),%edx
   43b20:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43b24:	0f b6 00             	movzbl (%rax),%eax
   43b27:	38 c2                	cmp    %al,%dl
   43b29:	74 ce                	je     43af9 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   43b2b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43b2f:	0f b6 00             	movzbl (%rax),%eax
   43b32:	89 c2                	mov    %eax,%edx
   43b34:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43b38:	0f b6 00             	movzbl (%rax),%eax
   43b3b:	38 d0                	cmp    %dl,%al
   43b3d:	0f 92 c0             	setb   %al
   43b40:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   43b43:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43b47:	0f b6 00             	movzbl (%rax),%eax
   43b4a:	89 c1                	mov    %eax,%ecx
   43b4c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43b50:	0f b6 00             	movzbl (%rax),%eax
   43b53:	38 c1                	cmp    %al,%cl
   43b55:	0f 92 c0             	setb   %al
   43b58:	0f b6 c0             	movzbl %al,%eax
   43b5b:	29 c2                	sub    %eax,%edx
   43b5d:	89 d0                	mov    %edx,%eax
}
   43b5f:	c9                   	leave  
   43b60:	c3                   	ret    

0000000000043b61 <strchr>:

char* strchr(const char* s, int c) {
   43b61:	55                   	push   %rbp
   43b62:	48 89 e5             	mov    %rsp,%rbp
   43b65:	48 83 ec 10          	sub    $0x10,%rsp
   43b69:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43b6d:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   43b70:	eb 05                	jmp    43b77 <strchr+0x16>
        ++s;
   43b72:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   43b77:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43b7b:	0f b6 00             	movzbl (%rax),%eax
   43b7e:	84 c0                	test   %al,%al
   43b80:	74 0e                	je     43b90 <strchr+0x2f>
   43b82:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43b86:	0f b6 00             	movzbl (%rax),%eax
   43b89:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43b8c:	38 d0                	cmp    %dl,%al
   43b8e:	75 e2                	jne    43b72 <strchr+0x11>
    }
    if (*s == (char) c) {
   43b90:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43b94:	0f b6 00             	movzbl (%rax),%eax
   43b97:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43b9a:	38 d0                	cmp    %dl,%al
   43b9c:	75 06                	jne    43ba4 <strchr+0x43>
        return (char*) s;
   43b9e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43ba2:	eb 05                	jmp    43ba9 <strchr+0x48>
    } else {
        return NULL;
   43ba4:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   43ba9:	c9                   	leave  
   43baa:	c3                   	ret    

0000000000043bab <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   43bab:	55                   	push   %rbp
   43bac:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   43baf:	8b 05 53 34 01 00    	mov    0x13453(%rip),%eax        # 57008 <rand_seed_set>
   43bb5:	85 c0                	test   %eax,%eax
   43bb7:	75 0a                	jne    43bc3 <rand+0x18>
        srand(819234718U);
   43bb9:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   43bbe:	e8 24 00 00 00       	call   43be7 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   43bc3:	8b 05 43 34 01 00    	mov    0x13443(%rip),%eax        # 5700c <rand_seed>
   43bc9:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   43bcf:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   43bd4:	89 05 32 34 01 00    	mov    %eax,0x13432(%rip)        # 5700c <rand_seed>
    return rand_seed & RAND_MAX;
   43bda:	8b 05 2c 34 01 00    	mov    0x1342c(%rip),%eax        # 5700c <rand_seed>
   43be0:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   43be5:	5d                   	pop    %rbp
   43be6:	c3                   	ret    

0000000000043be7 <srand>:

void srand(unsigned seed) {
   43be7:	55                   	push   %rbp
   43be8:	48 89 e5             	mov    %rsp,%rbp
   43beb:	48 83 ec 08          	sub    $0x8,%rsp
   43bef:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   43bf2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43bf5:	89 05 11 34 01 00    	mov    %eax,0x13411(%rip)        # 5700c <rand_seed>
    rand_seed_set = 1;
   43bfb:	c7 05 03 34 01 00 01 	movl   $0x1,0x13403(%rip)        # 57008 <rand_seed_set>
   43c02:	00 00 00 
}
   43c05:	90                   	nop
   43c06:	c9                   	leave  
   43c07:	c3                   	ret    

0000000000043c08 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   43c08:	55                   	push   %rbp
   43c09:	48 89 e5             	mov    %rsp,%rbp
   43c0c:	48 83 ec 28          	sub    $0x28,%rsp
   43c10:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43c14:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43c18:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   43c1b:	48 c7 45 f8 c0 57 04 	movq   $0x457c0,-0x8(%rbp)
   43c22:	00 
    if (base < 0) {
   43c23:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   43c27:	79 0b                	jns    43c34 <fill_numbuf+0x2c>
        digits = lower_digits;
   43c29:	48 c7 45 f8 e0 57 04 	movq   $0x457e0,-0x8(%rbp)
   43c30:	00 
        base = -base;
   43c31:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   43c34:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43c39:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43c3d:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   43c40:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43c43:	48 63 c8             	movslq %eax,%rcx
   43c46:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43c4a:	ba 00 00 00 00       	mov    $0x0,%edx
   43c4f:	48 f7 f1             	div    %rcx
   43c52:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c56:	48 01 d0             	add    %rdx,%rax
   43c59:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43c5e:	0f b6 10             	movzbl (%rax),%edx
   43c61:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43c65:	88 10                	mov    %dl,(%rax)
        val /= base;
   43c67:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43c6a:	48 63 f0             	movslq %eax,%rsi
   43c6d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43c71:	ba 00 00 00 00       	mov    $0x0,%edx
   43c76:	48 f7 f6             	div    %rsi
   43c79:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   43c7d:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43c82:	75 bc                	jne    43c40 <fill_numbuf+0x38>
    return numbuf_end;
   43c84:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43c88:	c9                   	leave  
   43c89:	c3                   	ret    

0000000000043c8a <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   43c8a:	55                   	push   %rbp
   43c8b:	48 89 e5             	mov    %rsp,%rbp
   43c8e:	53                   	push   %rbx
   43c8f:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   43c96:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   43c9d:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   43ca3:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43caa:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   43cb1:	e9 8a 09 00 00       	jmp    44640 <printer_vprintf+0x9b6>
        if (*format != '%') {
   43cb6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43cbd:	0f b6 00             	movzbl (%rax),%eax
   43cc0:	3c 25                	cmp    $0x25,%al
   43cc2:	74 31                	je     43cf5 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
   43cc4:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43ccb:	4c 8b 00             	mov    (%rax),%r8
   43cce:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43cd5:	0f b6 00             	movzbl (%rax),%eax
   43cd8:	0f b6 c8             	movzbl %al,%ecx
   43cdb:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   43ce1:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   43ce8:	89 ce                	mov    %ecx,%esi
   43cea:	48 89 c7             	mov    %rax,%rdi
   43ced:	41 ff d0             	call   *%r8
            continue;
   43cf0:	e9 43 09 00 00       	jmp    44638 <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
   43cf5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   43cfc:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43d03:	01 
   43d04:	eb 44                	jmp    43d4a <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
   43d06:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43d0d:	0f b6 00             	movzbl (%rax),%eax
   43d10:	0f be c0             	movsbl %al,%eax
   43d13:	89 c6                	mov    %eax,%esi
   43d15:	bf e0 55 04 00       	mov    $0x455e0,%edi
   43d1a:	e8 42 fe ff ff       	call   43b61 <strchr>
   43d1f:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   43d23:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   43d28:	74 30                	je     43d5a <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
   43d2a:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   43d2e:	48 2d e0 55 04 00    	sub    $0x455e0,%rax
   43d34:	ba 01 00 00 00       	mov    $0x1,%edx
   43d39:	89 c1                	mov    %eax,%ecx
   43d3b:	d3 e2                	shl    %cl,%edx
   43d3d:	89 d0                	mov    %edx,%eax
   43d3f:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   43d42:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43d49:	01 
   43d4a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43d51:	0f b6 00             	movzbl (%rax),%eax
   43d54:	84 c0                	test   %al,%al
   43d56:	75 ae                	jne    43d06 <printer_vprintf+0x7c>
   43d58:	eb 01                	jmp    43d5b <printer_vprintf+0xd1>
            } else {
                break;
   43d5a:	90                   	nop
            }
        }

        // process width
        int width = -1;
   43d5b:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   43d62:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43d69:	0f b6 00             	movzbl (%rax),%eax
   43d6c:	3c 30                	cmp    $0x30,%al
   43d6e:	7e 67                	jle    43dd7 <printer_vprintf+0x14d>
   43d70:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43d77:	0f b6 00             	movzbl (%rax),%eax
   43d7a:	3c 39                	cmp    $0x39,%al
   43d7c:	7f 59                	jg     43dd7 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43d7e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   43d85:	eb 2e                	jmp    43db5 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
   43d87:	8b 55 e8             	mov    -0x18(%rbp),%edx
   43d8a:	89 d0                	mov    %edx,%eax
   43d8c:	c1 e0 02             	shl    $0x2,%eax
   43d8f:	01 d0                	add    %edx,%eax
   43d91:	01 c0                	add    %eax,%eax
   43d93:	89 c1                	mov    %eax,%ecx
   43d95:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43d9c:	48 8d 50 01          	lea    0x1(%rax),%rdx
   43da0:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43da7:	0f b6 00             	movzbl (%rax),%eax
   43daa:	0f be c0             	movsbl %al,%eax
   43dad:	01 c8                	add    %ecx,%eax
   43daf:	83 e8 30             	sub    $0x30,%eax
   43db2:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43db5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43dbc:	0f b6 00             	movzbl (%rax),%eax
   43dbf:	3c 2f                	cmp    $0x2f,%al
   43dc1:	0f 8e 85 00 00 00    	jle    43e4c <printer_vprintf+0x1c2>
   43dc7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43dce:	0f b6 00             	movzbl (%rax),%eax
   43dd1:	3c 39                	cmp    $0x39,%al
   43dd3:	7e b2                	jle    43d87 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
   43dd5:	eb 75                	jmp    43e4c <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
   43dd7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43dde:	0f b6 00             	movzbl (%rax),%eax
   43de1:	3c 2a                	cmp    $0x2a,%al
   43de3:	75 68                	jne    43e4d <printer_vprintf+0x1c3>
            width = va_arg(val, int);
   43de5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43dec:	8b 00                	mov    (%rax),%eax
   43dee:	83 f8 2f             	cmp    $0x2f,%eax
   43df1:	77 30                	ja     43e23 <printer_vprintf+0x199>
   43df3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43dfa:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43dfe:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e05:	8b 00                	mov    (%rax),%eax
   43e07:	89 c0                	mov    %eax,%eax
   43e09:	48 01 d0             	add    %rdx,%rax
   43e0c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e13:	8b 12                	mov    (%rdx),%edx
   43e15:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43e18:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e1f:	89 0a                	mov    %ecx,(%rdx)
   43e21:	eb 1a                	jmp    43e3d <printer_vprintf+0x1b3>
   43e23:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43e2a:	48 8b 40 08          	mov    0x8(%rax),%rax
   43e2e:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43e32:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43e39:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43e3d:	8b 00                	mov    (%rax),%eax
   43e3f:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   43e42:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43e49:	01 
   43e4a:	eb 01                	jmp    43e4d <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
   43e4c:	90                   	nop
        }

        // process precision
        int precision = -1;
   43e4d:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   43e54:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43e5b:	0f b6 00             	movzbl (%rax),%eax
   43e5e:	3c 2e                	cmp    $0x2e,%al
   43e60:	0f 85 00 01 00 00    	jne    43f66 <printer_vprintf+0x2dc>
            ++format;
   43e66:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43e6d:	01 
            if (*format >= '0' && *format <= '9') {
   43e6e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43e75:	0f b6 00             	movzbl (%rax),%eax
   43e78:	3c 2f                	cmp    $0x2f,%al
   43e7a:	7e 67                	jle    43ee3 <printer_vprintf+0x259>
   43e7c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43e83:	0f b6 00             	movzbl (%rax),%eax
   43e86:	3c 39                	cmp    $0x39,%al
   43e88:	7f 59                	jg     43ee3 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43e8a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   43e91:	eb 2e                	jmp    43ec1 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
   43e93:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   43e96:	89 d0                	mov    %edx,%eax
   43e98:	c1 e0 02             	shl    $0x2,%eax
   43e9b:	01 d0                	add    %edx,%eax
   43e9d:	01 c0                	add    %eax,%eax
   43e9f:	89 c1                	mov    %eax,%ecx
   43ea1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43ea8:	48 8d 50 01          	lea    0x1(%rax),%rdx
   43eac:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43eb3:	0f b6 00             	movzbl (%rax),%eax
   43eb6:	0f be c0             	movsbl %al,%eax
   43eb9:	01 c8                	add    %ecx,%eax
   43ebb:	83 e8 30             	sub    $0x30,%eax
   43ebe:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43ec1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43ec8:	0f b6 00             	movzbl (%rax),%eax
   43ecb:	3c 2f                	cmp    $0x2f,%al
   43ecd:	0f 8e 85 00 00 00    	jle    43f58 <printer_vprintf+0x2ce>
   43ed3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43eda:	0f b6 00             	movzbl (%rax),%eax
   43edd:	3c 39                	cmp    $0x39,%al
   43edf:	7e b2                	jle    43e93 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
   43ee1:	eb 75                	jmp    43f58 <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
   43ee3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43eea:	0f b6 00             	movzbl (%rax),%eax
   43eed:	3c 2a                	cmp    $0x2a,%al
   43eef:	75 68                	jne    43f59 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
   43ef1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43ef8:	8b 00                	mov    (%rax),%eax
   43efa:	83 f8 2f             	cmp    $0x2f,%eax
   43efd:	77 30                	ja     43f2f <printer_vprintf+0x2a5>
   43eff:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f06:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43f0a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f11:	8b 00                	mov    (%rax),%eax
   43f13:	89 c0                	mov    %eax,%eax
   43f15:	48 01 d0             	add    %rdx,%rax
   43f18:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f1f:	8b 12                	mov    (%rdx),%edx
   43f21:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43f24:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f2b:	89 0a                	mov    %ecx,(%rdx)
   43f2d:	eb 1a                	jmp    43f49 <printer_vprintf+0x2bf>
   43f2f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43f36:	48 8b 40 08          	mov    0x8(%rax),%rax
   43f3a:	48 8d 48 08          	lea    0x8(%rax),%rcx
   43f3e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43f45:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   43f49:	8b 00                	mov    (%rax),%eax
   43f4b:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   43f4e:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43f55:	01 
   43f56:	eb 01                	jmp    43f59 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
   43f58:	90                   	nop
            }
            if (precision < 0) {
   43f59:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   43f5d:	79 07                	jns    43f66 <printer_vprintf+0x2dc>
                precision = 0;
   43f5f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   43f66:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   43f6d:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   43f74:	00 
        int length = 0;
   43f75:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   43f7c:	48 c7 45 c8 e6 55 04 	movq   $0x455e6,-0x38(%rbp)
   43f83:	00 
    again:
        switch (*format) {
   43f84:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   43f8b:	0f b6 00             	movzbl (%rax),%eax
   43f8e:	0f be c0             	movsbl %al,%eax
   43f91:	83 e8 43             	sub    $0x43,%eax
   43f94:	83 f8 37             	cmp    $0x37,%eax
   43f97:	0f 87 9f 03 00 00    	ja     4433c <printer_vprintf+0x6b2>
   43f9d:	89 c0                	mov    %eax,%eax
   43f9f:	48 8b 04 c5 f8 55 04 	mov    0x455f8(,%rax,8),%rax
   43fa6:	00 
   43fa7:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
   43fa9:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   43fb0:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   43fb7:	01 
            goto again;
   43fb8:	eb ca                	jmp    43f84 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   43fba:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43fbe:	74 5d                	je     4401d <printer_vprintf+0x393>
   43fc0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43fc7:	8b 00                	mov    (%rax),%eax
   43fc9:	83 f8 2f             	cmp    $0x2f,%eax
   43fcc:	77 30                	ja     43ffe <printer_vprintf+0x374>
   43fce:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43fd5:	48 8b 50 10          	mov    0x10(%rax),%rdx
   43fd9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   43fe0:	8b 00                	mov    (%rax),%eax
   43fe2:	89 c0                	mov    %eax,%eax
   43fe4:	48 01 d0             	add    %rdx,%rax
   43fe7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43fee:	8b 12                	mov    (%rdx),%edx
   43ff0:	8d 4a 08             	lea    0x8(%rdx),%ecx
   43ff3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   43ffa:	89 0a                	mov    %ecx,(%rdx)
   43ffc:	eb 1a                	jmp    44018 <printer_vprintf+0x38e>
   43ffe:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44005:	48 8b 40 08          	mov    0x8(%rax),%rax
   44009:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4400d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44014:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44018:	48 8b 00             	mov    (%rax),%rax
   4401b:	eb 5c                	jmp    44079 <printer_vprintf+0x3ef>
   4401d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44024:	8b 00                	mov    (%rax),%eax
   44026:	83 f8 2f             	cmp    $0x2f,%eax
   44029:	77 30                	ja     4405b <printer_vprintf+0x3d1>
   4402b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44032:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44036:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4403d:	8b 00                	mov    (%rax),%eax
   4403f:	89 c0                	mov    %eax,%eax
   44041:	48 01 d0             	add    %rdx,%rax
   44044:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4404b:	8b 12                	mov    (%rdx),%edx
   4404d:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44050:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44057:	89 0a                	mov    %ecx,(%rdx)
   44059:	eb 1a                	jmp    44075 <printer_vprintf+0x3eb>
   4405b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44062:	48 8b 40 08          	mov    0x8(%rax),%rax
   44066:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4406a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44071:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44075:	8b 00                	mov    (%rax),%eax
   44077:	48 98                	cltq   
   44079:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   4407d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44081:	48 c1 f8 38          	sar    $0x38,%rax
   44085:	25 80 00 00 00       	and    $0x80,%eax
   4408a:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   4408d:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   44091:	74 09                	je     4409c <printer_vprintf+0x412>
   44093:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44097:	48 f7 d8             	neg    %rax
   4409a:	eb 04                	jmp    440a0 <printer_vprintf+0x416>
   4409c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   440a0:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   440a4:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   440a7:	83 c8 60             	or     $0x60,%eax
   440aa:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   440ad:	e9 cf 02 00 00       	jmp    44381 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   440b2:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   440b6:	74 5d                	je     44115 <printer_vprintf+0x48b>
   440b8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   440bf:	8b 00                	mov    (%rax),%eax
   440c1:	83 f8 2f             	cmp    $0x2f,%eax
   440c4:	77 30                	ja     440f6 <printer_vprintf+0x46c>
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
   440f4:	eb 1a                	jmp    44110 <printer_vprintf+0x486>
   440f6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   440fd:	48 8b 40 08          	mov    0x8(%rax),%rax
   44101:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44105:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4410c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44110:	48 8b 00             	mov    (%rax),%rax
   44113:	eb 5c                	jmp    44171 <printer_vprintf+0x4e7>
   44115:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4411c:	8b 00                	mov    (%rax),%eax
   4411e:	83 f8 2f             	cmp    $0x2f,%eax
   44121:	77 30                	ja     44153 <printer_vprintf+0x4c9>
   44123:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4412a:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4412e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44135:	8b 00                	mov    (%rax),%eax
   44137:	89 c0                	mov    %eax,%eax
   44139:	48 01 d0             	add    %rdx,%rax
   4413c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44143:	8b 12                	mov    (%rdx),%edx
   44145:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44148:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4414f:	89 0a                	mov    %ecx,(%rdx)
   44151:	eb 1a                	jmp    4416d <printer_vprintf+0x4e3>
   44153:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4415a:	48 8b 40 08          	mov    0x8(%rax),%rax
   4415e:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44162:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44169:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4416d:	8b 00                	mov    (%rax),%eax
   4416f:	89 c0                	mov    %eax,%eax
   44171:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   44175:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   44179:	e9 03 02 00 00       	jmp    44381 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
   4417e:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   44185:	e9 28 ff ff ff       	jmp    440b2 <printer_vprintf+0x428>
        case 'X':
            base = 16;
   4418a:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   44191:	e9 1c ff ff ff       	jmp    440b2 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   44196:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4419d:	8b 00                	mov    (%rax),%eax
   4419f:	83 f8 2f             	cmp    $0x2f,%eax
   441a2:	77 30                	ja     441d4 <printer_vprintf+0x54a>
   441a4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   441ab:	48 8b 50 10          	mov    0x10(%rax),%rdx
   441af:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   441b6:	8b 00                	mov    (%rax),%eax
   441b8:	89 c0                	mov    %eax,%eax
   441ba:	48 01 d0             	add    %rdx,%rax
   441bd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   441c4:	8b 12                	mov    (%rdx),%edx
   441c6:	8d 4a 08             	lea    0x8(%rdx),%ecx
   441c9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   441d0:	89 0a                	mov    %ecx,(%rdx)
   441d2:	eb 1a                	jmp    441ee <printer_vprintf+0x564>
   441d4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   441db:	48 8b 40 08          	mov    0x8(%rax),%rax
   441df:	48 8d 48 08          	lea    0x8(%rax),%rcx
   441e3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   441ea:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   441ee:	48 8b 00             	mov    (%rax),%rax
   441f1:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   441f5:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   441fc:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   44203:	e9 79 01 00 00       	jmp    44381 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
   44208:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4420f:	8b 00                	mov    (%rax),%eax
   44211:	83 f8 2f             	cmp    $0x2f,%eax
   44214:	77 30                	ja     44246 <printer_vprintf+0x5bc>
   44216:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4421d:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44221:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44228:	8b 00                	mov    (%rax),%eax
   4422a:	89 c0                	mov    %eax,%eax
   4422c:	48 01 d0             	add    %rdx,%rax
   4422f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44236:	8b 12                	mov    (%rdx),%edx
   44238:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4423b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44242:	89 0a                	mov    %ecx,(%rdx)
   44244:	eb 1a                	jmp    44260 <printer_vprintf+0x5d6>
   44246:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4424d:	48 8b 40 08          	mov    0x8(%rax),%rax
   44251:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44255:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4425c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44260:	48 8b 00             	mov    (%rax),%rax
   44263:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   44267:	e9 15 01 00 00       	jmp    44381 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
   4426c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44273:	8b 00                	mov    (%rax),%eax
   44275:	83 f8 2f             	cmp    $0x2f,%eax
   44278:	77 30                	ja     442aa <printer_vprintf+0x620>
   4427a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44281:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44285:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4428c:	8b 00                	mov    (%rax),%eax
   4428e:	89 c0                	mov    %eax,%eax
   44290:	48 01 d0             	add    %rdx,%rax
   44293:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4429a:	8b 12                	mov    (%rdx),%edx
   4429c:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4429f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442a6:	89 0a                	mov    %ecx,(%rdx)
   442a8:	eb 1a                	jmp    442c4 <printer_vprintf+0x63a>
   442aa:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442b1:	48 8b 40 08          	mov    0x8(%rax),%rax
   442b5:	48 8d 48 08          	lea    0x8(%rax),%rcx
   442b9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   442c0:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   442c4:	8b 00                	mov    (%rax),%eax
   442c6:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   442cc:	e9 67 03 00 00       	jmp    44638 <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
   442d1:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   442d5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   442d9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442e0:	8b 00                	mov    (%rax),%eax
   442e2:	83 f8 2f             	cmp    $0x2f,%eax
   442e5:	77 30                	ja     44317 <printer_vprintf+0x68d>
   442e7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442ee:	48 8b 50 10          	mov    0x10(%rax),%rdx
   442f2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   442f9:	8b 00                	mov    (%rax),%eax
   442fb:	89 c0                	mov    %eax,%eax
   442fd:	48 01 d0             	add    %rdx,%rax
   44300:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44307:	8b 12                	mov    (%rdx),%edx
   44309:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4430c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44313:	89 0a                	mov    %ecx,(%rdx)
   44315:	eb 1a                	jmp    44331 <printer_vprintf+0x6a7>
   44317:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4431e:	48 8b 40 08          	mov    0x8(%rax),%rax
   44322:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44326:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4432d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44331:	8b 00                	mov    (%rax),%eax
   44333:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   44336:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   4433a:	eb 45                	jmp    44381 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
   4433c:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   44340:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   44344:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4434b:	0f b6 00             	movzbl (%rax),%eax
   4434e:	84 c0                	test   %al,%al
   44350:	74 0c                	je     4435e <printer_vprintf+0x6d4>
   44352:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44359:	0f b6 00             	movzbl (%rax),%eax
   4435c:	eb 05                	jmp    44363 <printer_vprintf+0x6d9>
   4435e:	b8 25 00 00 00       	mov    $0x25,%eax
   44363:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   44366:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   4436a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44371:	0f b6 00             	movzbl (%rax),%eax
   44374:	84 c0                	test   %al,%al
   44376:	75 08                	jne    44380 <printer_vprintf+0x6f6>
                format--;
   44378:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   4437f:	01 
            }
            break;
   44380:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   44381:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44384:	83 e0 20             	and    $0x20,%eax
   44387:	85 c0                	test   %eax,%eax
   44389:	74 1e                	je     443a9 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   4438b:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   4438f:	48 83 c0 18          	add    $0x18,%rax
   44393:	8b 55 e0             	mov    -0x20(%rbp),%edx
   44396:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   4439a:	48 89 ce             	mov    %rcx,%rsi
   4439d:	48 89 c7             	mov    %rax,%rdi
   443a0:	e8 63 f8 ff ff       	call   43c08 <fill_numbuf>
   443a5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   443a9:	48 c7 45 c0 e6 55 04 	movq   $0x455e6,-0x40(%rbp)
   443b0:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   443b1:	8b 45 ec             	mov    -0x14(%rbp),%eax
   443b4:	83 e0 20             	and    $0x20,%eax
   443b7:	85 c0                	test   %eax,%eax
   443b9:	74 48                	je     44403 <printer_vprintf+0x779>
   443bb:	8b 45 ec             	mov    -0x14(%rbp),%eax
   443be:	83 e0 40             	and    $0x40,%eax
   443c1:	85 c0                	test   %eax,%eax
   443c3:	74 3e                	je     44403 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
   443c5:	8b 45 ec             	mov    -0x14(%rbp),%eax
   443c8:	25 80 00 00 00       	and    $0x80,%eax
   443cd:	85 c0                	test   %eax,%eax
   443cf:	74 0a                	je     443db <printer_vprintf+0x751>
                prefix = "-";
   443d1:	48 c7 45 c0 e7 55 04 	movq   $0x455e7,-0x40(%rbp)
   443d8:	00 
            if (flags & FLAG_NEGATIVE) {
   443d9:	eb 73                	jmp    4444e <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   443db:	8b 45 ec             	mov    -0x14(%rbp),%eax
   443de:	83 e0 10             	and    $0x10,%eax
   443e1:	85 c0                	test   %eax,%eax
   443e3:	74 0a                	je     443ef <printer_vprintf+0x765>
                prefix = "+";
   443e5:	48 c7 45 c0 e9 55 04 	movq   $0x455e9,-0x40(%rbp)
   443ec:	00 
            if (flags & FLAG_NEGATIVE) {
   443ed:	eb 5f                	jmp    4444e <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   443ef:	8b 45 ec             	mov    -0x14(%rbp),%eax
   443f2:	83 e0 08             	and    $0x8,%eax
   443f5:	85 c0                	test   %eax,%eax
   443f7:	74 55                	je     4444e <printer_vprintf+0x7c4>
                prefix = " ";
   443f9:	48 c7 45 c0 eb 55 04 	movq   $0x455eb,-0x40(%rbp)
   44400:	00 
            if (flags & FLAG_NEGATIVE) {
   44401:	eb 4b                	jmp    4444e <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   44403:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44406:	83 e0 20             	and    $0x20,%eax
   44409:	85 c0                	test   %eax,%eax
   4440b:	74 42                	je     4444f <printer_vprintf+0x7c5>
   4440d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44410:	83 e0 01             	and    $0x1,%eax
   44413:	85 c0                	test   %eax,%eax
   44415:	74 38                	je     4444f <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
   44417:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   4441b:	74 06                	je     44423 <printer_vprintf+0x799>
   4441d:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   44421:	75 2c                	jne    4444f <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
   44423:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   44428:	75 0c                	jne    44436 <printer_vprintf+0x7ac>
   4442a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4442d:	25 00 01 00 00       	and    $0x100,%eax
   44432:	85 c0                	test   %eax,%eax
   44434:	74 19                	je     4444f <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
   44436:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   4443a:	75 07                	jne    44443 <printer_vprintf+0x7b9>
   4443c:	b8 ed 55 04 00       	mov    $0x455ed,%eax
   44441:	eb 05                	jmp    44448 <printer_vprintf+0x7be>
   44443:	b8 f0 55 04 00       	mov    $0x455f0,%eax
   44448:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   4444c:	eb 01                	jmp    4444f <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
   4444e:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   4444f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   44453:	78 24                	js     44479 <printer_vprintf+0x7ef>
   44455:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44458:	83 e0 20             	and    $0x20,%eax
   4445b:	85 c0                	test   %eax,%eax
   4445d:	75 1a                	jne    44479 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
   4445f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   44462:	48 63 d0             	movslq %eax,%rdx
   44465:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44469:	48 89 d6             	mov    %rdx,%rsi
   4446c:	48 89 c7             	mov    %rax,%rdi
   4446f:	e8 ea f5 ff ff       	call   43a5e <strnlen>
   44474:	89 45 bc             	mov    %eax,-0x44(%rbp)
   44477:	eb 0f                	jmp    44488 <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
   44479:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4447d:	48 89 c7             	mov    %rax,%rdi
   44480:	e8 a8 f5 ff ff       	call   43a2d <strlen>
   44485:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   44488:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4448b:	83 e0 20             	and    $0x20,%eax
   4448e:	85 c0                	test   %eax,%eax
   44490:	74 20                	je     444b2 <printer_vprintf+0x828>
   44492:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   44496:	78 1a                	js     444b2 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
   44498:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   4449b:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   4449e:	7e 08                	jle    444a8 <printer_vprintf+0x81e>
   444a0:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   444a3:	2b 45 bc             	sub    -0x44(%rbp),%eax
   444a6:	eb 05                	jmp    444ad <printer_vprintf+0x823>
   444a8:	b8 00 00 00 00       	mov    $0x0,%eax
   444ad:	89 45 b8             	mov    %eax,-0x48(%rbp)
   444b0:	eb 5c                	jmp    4450e <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   444b2:	8b 45 ec             	mov    -0x14(%rbp),%eax
   444b5:	83 e0 20             	and    $0x20,%eax
   444b8:	85 c0                	test   %eax,%eax
   444ba:	74 4b                	je     44507 <printer_vprintf+0x87d>
   444bc:	8b 45 ec             	mov    -0x14(%rbp),%eax
   444bf:	83 e0 02             	and    $0x2,%eax
   444c2:	85 c0                	test   %eax,%eax
   444c4:	74 41                	je     44507 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
   444c6:	8b 45 ec             	mov    -0x14(%rbp),%eax
   444c9:	83 e0 04             	and    $0x4,%eax
   444cc:	85 c0                	test   %eax,%eax
   444ce:	75 37                	jne    44507 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
   444d0:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   444d4:	48 89 c7             	mov    %rax,%rdi
   444d7:	e8 51 f5 ff ff       	call   43a2d <strlen>
   444dc:	89 c2                	mov    %eax,%edx
   444de:	8b 45 bc             	mov    -0x44(%rbp),%eax
   444e1:	01 d0                	add    %edx,%eax
   444e3:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   444e6:	7e 1f                	jle    44507 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
   444e8:	8b 45 e8             	mov    -0x18(%rbp),%eax
   444eb:	2b 45 bc             	sub    -0x44(%rbp),%eax
   444ee:	89 c3                	mov    %eax,%ebx
   444f0:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   444f4:	48 89 c7             	mov    %rax,%rdi
   444f7:	e8 31 f5 ff ff       	call   43a2d <strlen>
   444fc:	89 c2                	mov    %eax,%edx
   444fe:	89 d8                	mov    %ebx,%eax
   44500:	29 d0                	sub    %edx,%eax
   44502:	89 45 b8             	mov    %eax,-0x48(%rbp)
   44505:	eb 07                	jmp    4450e <printer_vprintf+0x884>
        } else {
            zeros = 0;
   44507:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   4450e:	8b 55 bc             	mov    -0x44(%rbp),%edx
   44511:	8b 45 b8             	mov    -0x48(%rbp),%eax
   44514:	01 d0                	add    %edx,%eax
   44516:	48 63 d8             	movslq %eax,%rbx
   44519:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4451d:	48 89 c7             	mov    %rax,%rdi
   44520:	e8 08 f5 ff ff       	call   43a2d <strlen>
   44525:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   44529:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4452c:	29 d0                	sub    %edx,%eax
   4452e:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   44531:	eb 25                	jmp    44558 <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
   44533:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4453a:	48 8b 08             	mov    (%rax),%rcx
   4453d:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44543:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4454a:	be 20 00 00 00       	mov    $0x20,%esi
   4454f:	48 89 c7             	mov    %rax,%rdi
   44552:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   44554:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   44558:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4455b:	83 e0 04             	and    $0x4,%eax
   4455e:	85 c0                	test   %eax,%eax
   44560:	75 36                	jne    44598 <printer_vprintf+0x90e>
   44562:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   44566:	7f cb                	jg     44533 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
   44568:	eb 2e                	jmp    44598 <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
   4456a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44571:	4c 8b 00             	mov    (%rax),%r8
   44574:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44578:	0f b6 00             	movzbl (%rax),%eax
   4457b:	0f b6 c8             	movzbl %al,%ecx
   4457e:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44584:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4458b:	89 ce                	mov    %ecx,%esi
   4458d:	48 89 c7             	mov    %rax,%rdi
   44590:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   44593:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   44598:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4459c:	0f b6 00             	movzbl (%rax),%eax
   4459f:	84 c0                	test   %al,%al
   445a1:	75 c7                	jne    4456a <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
   445a3:	eb 25                	jmp    445ca <printer_vprintf+0x940>
            p->putc(p, '0', color);
   445a5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   445ac:	48 8b 08             	mov    (%rax),%rcx
   445af:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   445b5:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   445bc:	be 30 00 00 00       	mov    $0x30,%esi
   445c1:	48 89 c7             	mov    %rax,%rdi
   445c4:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   445c6:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   445ca:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   445ce:	7f d5                	jg     445a5 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
   445d0:	eb 32                	jmp    44604 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
   445d2:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   445d9:	4c 8b 00             	mov    (%rax),%r8
   445dc:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   445e0:	0f b6 00             	movzbl (%rax),%eax
   445e3:	0f b6 c8             	movzbl %al,%ecx
   445e6:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   445ec:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   445f3:	89 ce                	mov    %ecx,%esi
   445f5:	48 89 c7             	mov    %rax,%rdi
   445f8:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   445fb:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   44600:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   44604:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   44608:	7f c8                	jg     445d2 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
   4460a:	eb 25                	jmp    44631 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
   4460c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44613:	48 8b 08             	mov    (%rax),%rcx
   44616:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   4461c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44623:	be 20 00 00 00       	mov    $0x20,%esi
   44628:	48 89 c7             	mov    %rax,%rdi
   4462b:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   4462d:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   44631:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   44635:	7f d5                	jg     4460c <printer_vprintf+0x982>
        }
    done: ;
   44637:	90                   	nop
    for (; *format; ++format) {
   44638:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4463f:	01 
   44640:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44647:	0f b6 00             	movzbl (%rax),%eax
   4464a:	84 c0                	test   %al,%al
   4464c:	0f 85 64 f6 ff ff    	jne    43cb6 <printer_vprintf+0x2c>
    }
}
   44652:	90                   	nop
   44653:	90                   	nop
   44654:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   44658:	c9                   	leave  
   44659:	c3                   	ret    

000000000004465a <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   4465a:	55                   	push   %rbp
   4465b:	48 89 e5             	mov    %rsp,%rbp
   4465e:	48 83 ec 20          	sub    $0x20,%rsp
   44662:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44666:	89 f0                	mov    %esi,%eax
   44668:	89 55 e0             	mov    %edx,-0x20(%rbp)
   4466b:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   4466e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44672:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   44676:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4467a:	48 8b 40 08          	mov    0x8(%rax),%rax
   4467e:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
   44683:	48 39 d0             	cmp    %rdx,%rax
   44686:	72 0c                	jb     44694 <console_putc+0x3a>
        cp->cursor = console;
   44688:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4468c:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
   44693:	00 
    }
    if (c == '\n') {
   44694:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   44698:	75 78                	jne    44712 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
   4469a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4469e:	48 8b 40 08          	mov    0x8(%rax),%rax
   446a2:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   446a8:	48 d1 f8             	sar    %rax
   446ab:	48 89 c1             	mov    %rax,%rcx
   446ae:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   446b5:	66 66 66 
   446b8:	48 89 c8             	mov    %rcx,%rax
   446bb:	48 f7 ea             	imul   %rdx
   446be:	48 c1 fa 05          	sar    $0x5,%rdx
   446c2:	48 89 c8             	mov    %rcx,%rax
   446c5:	48 c1 f8 3f          	sar    $0x3f,%rax
   446c9:	48 29 c2             	sub    %rax,%rdx
   446cc:	48 89 d0             	mov    %rdx,%rax
   446cf:	48 c1 e0 02          	shl    $0x2,%rax
   446d3:	48 01 d0             	add    %rdx,%rax
   446d6:	48 c1 e0 04          	shl    $0x4,%rax
   446da:	48 29 c1             	sub    %rax,%rcx
   446dd:	48 89 ca             	mov    %rcx,%rdx
   446e0:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   446e3:	eb 25                	jmp    4470a <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
   446e5:	8b 45 e0             	mov    -0x20(%rbp),%eax
   446e8:	83 c8 20             	or     $0x20,%eax
   446eb:	89 c6                	mov    %eax,%esi
   446ed:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   446f1:	48 8b 40 08          	mov    0x8(%rax),%rax
   446f5:	48 8d 48 02          	lea    0x2(%rax),%rcx
   446f9:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   446fd:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44701:	89 f2                	mov    %esi,%edx
   44703:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   44706:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4470a:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   4470e:	75 d5                	jne    446e5 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   44710:	eb 24                	jmp    44736 <console_putc+0xdc>
        *cp->cursor++ = c | color;
   44712:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
   44716:	8b 55 e0             	mov    -0x20(%rbp),%edx
   44719:	09 d0                	or     %edx,%eax
   4471b:	89 c6                	mov    %eax,%esi
   4471d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44721:	48 8b 40 08          	mov    0x8(%rax),%rax
   44725:	48 8d 48 02          	lea    0x2(%rax),%rcx
   44729:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4472d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44731:	89 f2                	mov    %esi,%edx
   44733:	66 89 10             	mov    %dx,(%rax)
}
   44736:	90                   	nop
   44737:	c9                   	leave  
   44738:	c3                   	ret    

0000000000044739 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   44739:	55                   	push   %rbp
   4473a:	48 89 e5             	mov    %rsp,%rbp
   4473d:	48 83 ec 30          	sub    $0x30,%rsp
   44741:	89 7d ec             	mov    %edi,-0x14(%rbp)
   44744:	89 75 e8             	mov    %esi,-0x18(%rbp)
   44747:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   4474b:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   4474f:	48 c7 45 f0 5a 46 04 	movq   $0x4465a,-0x10(%rbp)
   44756:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   44757:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   4475b:	78 09                	js     44766 <console_vprintf+0x2d>
   4475d:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   44764:	7e 07                	jle    4476d <console_vprintf+0x34>
        cpos = 0;
   44766:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   4476d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44770:	48 98                	cltq   
   44772:	48 01 c0             	add    %rax,%rax
   44775:	48 05 00 80 0b 00    	add    $0xb8000,%rax
   4477b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   4477f:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   44783:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   44787:	8b 75 e8             	mov    -0x18(%rbp),%esi
   4478a:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   4478e:	48 89 c7             	mov    %rax,%rdi
   44791:	e8 f4 f4 ff ff       	call   43c8a <printer_vprintf>
    return cp.cursor - console;
   44796:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4479a:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   447a0:	48 d1 f8             	sar    %rax
}
   447a3:	c9                   	leave  
   447a4:	c3                   	ret    

00000000000447a5 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   447a5:	55                   	push   %rbp
   447a6:	48 89 e5             	mov    %rsp,%rbp
   447a9:	48 83 ec 60          	sub    $0x60,%rsp
   447ad:	89 7d ac             	mov    %edi,-0x54(%rbp)
   447b0:	89 75 a8             	mov    %esi,-0x58(%rbp)
   447b3:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   447b7:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   447bb:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   447bf:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   447c3:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   447ca:	48 8d 45 10          	lea    0x10(%rbp),%rax
   447ce:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   447d2:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   447d6:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   447da:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   447de:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   447e2:	8b 75 a8             	mov    -0x58(%rbp),%esi
   447e5:	8b 45 ac             	mov    -0x54(%rbp),%eax
   447e8:	89 c7                	mov    %eax,%edi
   447ea:	e8 4a ff ff ff       	call   44739 <console_vprintf>
   447ef:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   447f2:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   447f5:	c9                   	leave  
   447f6:	c3                   	ret    

00000000000447f7 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   447f7:	55                   	push   %rbp
   447f8:	48 89 e5             	mov    %rsp,%rbp
   447fb:	48 83 ec 20          	sub    $0x20,%rsp
   447ff:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44803:	89 f0                	mov    %esi,%eax
   44805:	89 55 e0             	mov    %edx,-0x20(%rbp)
   44808:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   4480b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4480f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   44813:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44817:	48 8b 50 08          	mov    0x8(%rax),%rdx
   4481b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4481f:	48 8b 40 10          	mov    0x10(%rax),%rax
   44823:	48 39 c2             	cmp    %rax,%rdx
   44826:	73 1a                	jae    44842 <string_putc+0x4b>
        *sp->s++ = c;
   44828:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4482c:	48 8b 40 08          	mov    0x8(%rax),%rax
   44830:	48 8d 48 01          	lea    0x1(%rax),%rcx
   44834:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   44838:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4483c:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   44840:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   44842:	90                   	nop
   44843:	c9                   	leave  
   44844:	c3                   	ret    

0000000000044845 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   44845:	55                   	push   %rbp
   44846:	48 89 e5             	mov    %rsp,%rbp
   44849:	48 83 ec 40          	sub    $0x40,%rsp
   4484d:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   44851:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   44855:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   44859:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   4485d:	48 c7 45 e8 f7 47 04 	movq   $0x447f7,-0x18(%rbp)
   44864:	00 
    sp.s = s;
   44865:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44869:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   4486d:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   44872:	74 33                	je     448a7 <vsnprintf+0x62>
        sp.end = s + size - 1;
   44874:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   44878:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   4487c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44880:	48 01 d0             	add    %rdx,%rax
   44883:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   44887:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   4488b:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   4488f:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   44893:	be 00 00 00 00       	mov    $0x0,%esi
   44898:	48 89 c7             	mov    %rax,%rdi
   4489b:	e8 ea f3 ff ff       	call   43c8a <printer_vprintf>
        *sp.s = 0;
   448a0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   448a4:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   448a7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   448ab:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   448af:	c9                   	leave  
   448b0:	c3                   	ret    

00000000000448b1 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   448b1:	55                   	push   %rbp
   448b2:	48 89 e5             	mov    %rsp,%rbp
   448b5:	48 83 ec 70          	sub    $0x70,%rsp
   448b9:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   448bd:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   448c1:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   448c5:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   448c9:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   448cd:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   448d1:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   448d8:	48 8d 45 10          	lea    0x10(%rbp),%rax
   448dc:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   448e0:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   448e4:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   448e8:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   448ec:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   448f0:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   448f4:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   448f8:	48 89 c7             	mov    %rax,%rdi
   448fb:	e8 45 ff ff ff       	call   44845 <vsnprintf>
   44900:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   44903:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   44906:	c9                   	leave  
   44907:	c3                   	ret    

0000000000044908 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   44908:	55                   	push   %rbp
   44909:	48 89 e5             	mov    %rsp,%rbp
   4490c:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44910:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   44917:	eb 13                	jmp    4492c <console_clear+0x24>
        console[i] = ' ' | 0x0700;
   44919:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4491c:	48 98                	cltq   
   4491e:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
   44925:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44928:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4492c:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   44933:	7e e4                	jle    44919 <console_clear+0x11>
    }
    cursorpos = 0;
   44935:	c7 05 bd 46 07 00 00 	movl   $0x0,0x746bd(%rip)        # b8ffc <cursorpos>
   4493c:	00 00 00 
}
   4493f:	90                   	nop
   44940:	c9                   	leave  
   44941:	c3                   	ret    
