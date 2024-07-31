.section .rodata
	fmt1: .string "Iteração %d, v = %d\n"


.data
	.globl i
	.align 4
	i: .int 0

	.globl v
	.align 2
	v: .short 0

	.globl vetA
	.align 2
	vetA: .short 28, 42, 16, 23, 47

	.globl vetB
	.align 4
	vetB: .int 0, 0, 0, 0, 0


.text
.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	
	# _while (i < 5)
while:
	cmpl $5, i
	jge end_while

	// v = vetA[i] << 2
	movq $vetA, %r8
	movslq i, %r9
	movw (%r8, %r9, 2), %r10w	# %r10w = vetA[i]
	shlw $2, %r10w
	movw %r10w, v 

	// printf("Iteração %d, v = %d\n", i, (int)v)
	movq $fmt1, %rdi
	movl i, %esi
	movswl v, %edx
	movl $0, %eax

	call printf 

	// process(i, v, &vetB[i])
	movl i, %edi		# 1º arg
	movw v, %si			# 2º arg
	# &vetB[i]
	movq $vetB, %r8		# %r8 = &vetB
	movslq %edi, %r9	# %r9 = (long)i
	imulq $4, %r9		# %r9 = 4 * (long)i
	addq %r8, %r9		# %r9 = &vetB + ((long)i * 4)
	movq %r9, %rdx		# 3º arg

	call process

	# i++
	incl i

	jmp while

end_while:

	// show(vetB, 5)
	movq $vetB, %rdi
	movq $5, %rsi

	call show

	leave
	ret
