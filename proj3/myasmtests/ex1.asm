	.file	"example1.c"
	.text
	.globl	foo
	.type	foo, @function
foo:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -104(%rbp)
	movq	%rsi, -112(%rbp)
	movq	$7, -8(%rbp)
	movq	-112(%rbp), %rax
	cqto
	idivq	-8(%rbp)
	movq	%rax, -16(%rbp)
	movq	-8(%rbp), %rax
	imulq	-16(%rbp), %rax
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rdx
	movq	-104(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rax
	subq	-112(%rbp), %rax
	movq	%rax, -40(%rbp)
	movq	-40(%rbp), %rax
	andq	-32(%rbp), %rax
	movq	%rax, -48(%rbp)
	movq	-40(%rbp), %rax
	orq	-48(%rbp), %rax
	movq	%rax, -56(%rbp)
	movq	-56(%rbp), %rax
	xorq	-48(%rbp), %rax
	movq	%rax, -64(%rbp)
	movq	-64(%rbp), %rax
	sarq	$2, %rax
	movq	%rax, -72(%rbp)
	movq	-72(%rbp), %rax
	salq	$2, %rax
	movq	%rax, -80(%rbp)
	movq	-80(%rbp), %rax
	negq	%rax
	movq	%rax, -88(%rbp)
	movq	-88(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	foo, .-foo
	.ident	"GCC: (GNU) 12.1.1 20220507 (Red Hat 12.1.1-1)"
	.section	.note.GNU-stack,"",@progbits
