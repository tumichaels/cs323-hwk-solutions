
.globl boo
boo:
pushq %rbp
movq %rsp, %rbp
push %rbx
push %r12
push %r13
push %r14
push %r15
subq $24, %rsp
movq %rdi, %rax
addq $12, %rax
movq %rax, %rbx
movq %rbx, %rax
addq $24, %rsp
pop %r15
pop %r14
pop %r13
pop %r12
pop %rbx
movq %rbp, %rsp
popq  %rbp
retq

.globl foo
foo:
pushq %rbp
movq %rsp, %rbp
push %rbx
push %r12
push %r13
push %r14
push %r15
subq $40, %rsp
movq %rdi, %rax
addq $12, %rax
movq %rax, %rbx
push %rsi
push %rdi
movq $24, %rdi
movq %rbx, %rsi
call boo
movq %rax, %r12
pop %rdi
pop %rsi
movq %r12, %rax
subq %rbx, %rax
movq %rax, %r13
movq %r13, %rax
addq $40, %rsp
pop %r15
pop %r14
pop %r13
pop %r12
pop %rbx
movq %rbp, %rsp
popq  %rbp
retq
