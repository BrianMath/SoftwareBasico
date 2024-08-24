# void filli(int *v, int cols, int k);
# void fills(short *v, int cols, int k);

.text
.globl calc
calc:
	pushq %rbp
	movq %rsp, %rbp
	subq $64, %rsp

	movq %r12, -8(%rbp)
	movq %r13, -16(%rbp)

	# int i = 0 -> %r12d
	movl $0, %r12d
	# int j = 4 -> %r13d
	movl $4, %r13d
	# int sum				| -20(%rbp)
	# int vet1[5]			| -40(%rbp)
	# short vet2[5]			| -50(%rbp)

	//      %rdi %esi %edx
	// filli(vet1, 5, i)
	leaq -40(%rbp), %rdi	# 1º arg
	movl $5, %esi			# 2º arg
	movl %r12d, %edx		# 3º arg
	call filli

	//      %rdi %esi %edx
	// fills(vet2, 5, j)
	leaq -50(%rbp), %rdi	# 1º arg
	movl $5, %esi			# 2º arg
	movl %r13d, %edx		# 3º arg
	call fills

	# sum = 0
	movl $0, -20(%rbp)

	// _for ( ; i < 5; i++, j--)
for:
	cmpl $5, %r12d
	jge end_for

	// sum += vet1[i] + vet2[j]
	// vet1[i]
	leaq -40(%rbp), %r8		# %r8 = &vet1
	movslq %r12d, %r9		# (long)i
	imulq $4, %r9			# (long)i * 4
	addq %r8, %r9			# %r9 = &vet[i]
	movl (%r9), %eax		# %eax = vet1[i]

	// vet2[j]
	leaq -50(%rbp), %r8		
	movslq %r13d, %r9
	imulq $2, %r9
	addq %r8, %r9
	movswl (%r9), %ecx

	# vet1[i] + vet2[j]
	addl %ecx, %eax

	# sum += vet1[i] + vet2[j]
	addl %eax, -20(%rbp)

	# i++
	incl %r12d
	# j--
	decl %r13d

	jmp for
end_for:

	# return sum
	movl -20(%rbp), %eax

	movq -8(%rbp), %r12
	movq -16(%rbp), %r13

	leave
	ret	
