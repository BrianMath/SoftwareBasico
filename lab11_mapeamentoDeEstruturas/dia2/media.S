//                      %rdi          %rsi
// long media(struct Produto *ptr, long size)
.globl media
media:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp

	movq %r12, -8(%rbp)
	movq %r13, -16(%rbp)

	# int i = 0
	movl $0, %r12d

	# long soma = 0
	movq $0, %r13
	
	// _for (i = 0; i < size; i++)
	# i = 0
	movl $0, %r12d
for01:
	movslq %r12d, %rax		# %rax = (long)i
	# i < size
	cmpq %rsi, %rax
	jge endfor01
	
	//	soma += ptr[i].preco
	movslq %r12d, %rax		# %rax = (long)i
	imulq $24, %rax			# %rax = (long)i * sizeOf(struct Produto) == (long)i * 24
	addq %rdi, %rax			# %rax = &ptr + (long)i * 24
	# soma += ptr[i].preco
	addq 8(%rax), %r13	

	# i++
	incl %r12d
	jmp for01
endfor01:

	// return soma / size
	movq %r13, %rax
	cqto
	idivq %rsi

	movq -8(%rbp), %r12
	movq -16(%rbp), %r13

	leave
	ret
