.section .rodata
	fmt1: .string "Soma %f maior que o limite %f (%d)\n"
	tmp1: .double 0.0

.text

//               %xmm0
// double sum(double limit)
.globl sum
sum:
	pushq %rbp
	movq %rsp, %rbp
	subq $80, %rsp

	# Salvar registradores callee-saved (verdes)
	movq %r12, -56(%rbp)

	# int i = 4
	movl $4, %r12d

	# double s = 0.0
	movsd tmp1, %xmm1

	# int vi[4] = {5,6,7,8}
	leaq -48(%rbp), %rax
	movl $5, (%rax)

	addq $4, %rax
	movl $6, (%rax)
	
	addq $4, %rax
	movl $7, (%rax)
	
	addq $4, %rax
	movl $8, (%rax)

	# double vd[4]

	// Salvar registradores caller-saved (amarelos)
	movq %xmm0, -64(%rbp)
	movq %xmm1, -72(%rbp)

	// mult(vi, vd, i)
	leaq -48(%rbp), %rdi		# 1º arg
	leaq -32(%rbp), %rsi 		# 2º arg
	movl %r12d, %edx			# 3º arg
	call mult

	// Recuperar registradores amarelos
	movq -64(%rbp), %xmm0
	movq -72(%rbp), %xmm1

	// _while (i > 0)
while1:
	cmpl $0, %r12d
	jle end_while1

	// s += vd[--i]
	# --i
	decl %r12d

	// vd[--i]
	leaq -32(%rbp), %r8		# %r8 = &vd
	movslq %r12d, %r9		# %r9 = (long)--i
	imulq $8, %r9			# %r9 = (long)--i * 8
	addq %r9, %r8			# %r8 = &vd + (long)--i * 8 == &vd[--i]

	// s += vd[--i]
	addsd (%r8), %xmm1

	// _if (s > limit)
if1:
	ucomisd %xmm0, %xmm1
	jp end_if1
	jbe end_if1

	// Salvar registradores caller-saved (amarelos)
	movq %xmm0, -64(%rbp)
	movq %xmm1, -72(%rbp)

	//                %rdi                        %xmm0  %xmm1 %esi
	// printf("Soma %f maior que o limite %f (%d)\n", s, limit, i)
	movq $fmt1, %rdi 		# 1º arg int
	movl %r12d, %esi		# 2º arg int
	movsd %xmm0, %xmm2		# %xmm2 = limit
	movsd %xmm1, %xmm0		# 1º arg FP
	movsd %xmm2, %xmm1		# 2º arg FP
	movl $2, %eax
	call printf

	// Recuperar registradores amarelos
	movq -64(%rbp), %xmm0
	movq -72(%rbp), %xmm1

end_if1:

	jmp while1

end_while1:

	# return s
	movsd %xmm1, %xmm0

	# Recuperar registradores verdes
	movq -56(%rbp), %r12

	leave
	ret