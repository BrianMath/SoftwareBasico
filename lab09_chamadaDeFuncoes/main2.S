.data
	.globl i
	.align 4
	i: .int 0

	.globl bias
	.align 8
	bias: .quad 256

	.globl vet
	.align 1
	vet: .byte 12, 3, 20, 8 # unsigned

	
.text
.globl main
main:
	pushq %rbp
	movq %rsp, %rbp

	// _for (i = 0; i < LEN; i++)
	# i = 0
	movl $0, i
for:
	# i < 4
	cmpl $4, i
	jge end_for

	// bias = filtro(vet[i], LIM, bias)
	
	#         %dil  %esi %rdx
	# filtro(vet[i], 10, bias)
	movq $vet, %r8		# %r8 = &vet
	movslq i, %r9		# %r9 = i
	addq %r9, %r8		# %r8 = &vet[i]
	movb (%r8), %dil	# %dil = vet[i]
	movl $10, %esi		# %esi = 10
	movq bias, %rdx		# %rdx = bias

	call filtro
	# retorno em %rax
	# bias = filtro()
	movq %rax, bias

	# i++
	incl i

	jmp for

end_for:

	leave
	ret

