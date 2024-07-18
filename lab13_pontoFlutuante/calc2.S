.section .rodata
	fmt1: .string "a = %f, b = %f, e = %f\n"

.data

.text

//              %xmm0   %xmm1
// float calc2(float a, float b)
.globl calc2
calc2:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp

	// double e = a + cos(b)
	
	# Salvar caller-saved
	movss %xmm0, -8(%rbp)
	movss %xmm1, -16(%rbp)

	// cos(b)
	cvtss2sd %xmm1, %xmm0		# %xmm0 = (double)b
	call cos
	// Retorno em %xmm0
	movsd %xmm0, %xmm2			# %xmm2 = (double) cos(b)

	# Recuperar caller-saved
	movss -8(%rbp), %xmm0
	movss -16(%rbp), %xmm1

	cvtss2sd %xmm0, %xmm3		# %xmm3  = (double)a
	addsd %xmm3, %xmm2			# %xmm2 -> (double) e

	# Salvar caller-saved
	movss %xmm0, -8(%rbp)
	movss %xmm1, -16(%rbp)

	// printf("a = %f, b = %f, e = %f\n", (double)a, (double)b, e)
	movq $fmt1, %rdi			# 1º arg int
	movsd %xmm3, %xmm0			# 1º arg fp
	cvtss2sd -16(%rbp), %xmm1	# 2º arg fp
	# 3º arg fp já está em %xmm2
	movl $3, %eax
	call printf

	# Recuperar caller-saved
	movss -8(%rbp), %xmm0
	movss -16(%rbp), %xmm1

	// return b
	movss %xmm1, %xmm0

	leave
	ret
