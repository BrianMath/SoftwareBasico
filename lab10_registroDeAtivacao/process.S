.text
.globl process
process:
	#               %edi  %esi   %edx   %ecx    %r8d   %r9d
	# int process(int a, int b, int c, int d, int e, int f)
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp	# abrir espaço na stack para salvar os argumentos

	// int r = calc(f, e, d, c, b, a)
	
	# Salvar argumentos
	movq %rdi, -8(%rbp)
	movq %rsi, -16(%rbp)
	movq %rdx, -24(%rbp)
	movq %rcx, -32(%rbp)
	movq %r8, -40(%rbp)
	movq %r9, -48(%rbp)

	# Passar argumentos e chamar função calc
	movl -48(%rbp), %edi
	movl -40(%rbp), %esi
	movl -32(%rbp), %edx
	movl -24(%rbp), %ecx
	movl -16(%rbp), %r8d
	movl -8(%rbp), %r9d

	call calc

	# r -> %r10d
	movl %eax, %r10d

	# Recuperar argumentos salvos
	movq -8(%rbp), %rdi
	movq -16(%rbp), %rsi
	movq -24(%rbp), %rdx
	movq -32(%rbp), %rcx
	movq -40(%rbp), %r8
	movq -48(%rbp), %r9

	# return r + a + b + c + d + e + f
	addl %edi, %r10d
	addl %esi, %r10d
	addl %edx, %r10d
	addl %ecx, %r10d
	addl %r8d, %r10d
	addl %r9d, %r10d

	movl %r10d, %eax

	leave
	ret
