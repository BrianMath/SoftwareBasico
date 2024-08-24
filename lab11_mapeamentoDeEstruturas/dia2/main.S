.section .rodata
	fmt1: .string "Diferença em %d/%d: %ld\n"

.data
	# struct Produto prods[2]
	.globl prods
	.align 8
	prods: .zero 48
		# .byte 0		 +0  | char mes
		# .zero 7		 +1  | -padding-
		# .quad 0		 +8  | long preco
		# .int 0		 +16 | int ano
		# .zero 4		 +20 | -padding-
		# total = 24 bytes

// long media(struct Produto *ptr, long size)

.text
.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp

	# int i = 0 -> %r8d
	movl $0, %r8d

	// %r9 = &prods[0]
	movq $prods, %r9
	# prods[0].mes   = 1
	movb $1, (%r9)
	# prods[0].preco = 100
	movq $100, 8(%r9)
	# prods[0].ano   = 2020
	movl $2020, 16(%r9)

	# %r9 = $prods[1]
	addq 24, %r9
	# prods[1].mes   = FEV
	movb $2, (%r9)
	# prods[1].preco = 120
	movq $120, 8(%r9)
	# prods[1].ano   = 2020
	movl $2020, 16(%r9)

	//                %rdi  %rsi
	// long m = media(prods, 2)

	# %r9 = prods[0]
	subq $24, %r9

	# Salvar caller-saved
	movq %r8, -8(%rbp)		# i 

	# media(prods, 2)
	movq %r9, %rdi		# 1º arg
	movq $2, %rsi		# 2º arg
	call media
	# Retorno em %rax
	# long m = %rax -> %r9
	movq %rax, %r9

	# Recuperar caller-saved
	movq -8(%rbp), %r8		# i

	// while (i < 2)
while1:
	cmpl $2, %r8d
	jge end_while1

	# Salvar caller-saved
	movq %r8, -8(%rbp)		# i
	movq %r9, -16(%rbp)		# m

	//         %rdi         %esi             %edx           %rcx
	// printf($fmt1, (int)prods[i].mes, prods[i].ano, prods[i].preco - m)
	movq $fmt1, %rdi		# 1º arg
	
	movq $prods, %rax		# &prods[0]
	movslq %r8d, %rcx		# (long)i
	imulq $24, %rcx			# (long)i * 24
	addq %rcx, %rax			# &prods[i]

	# %esi = (int)prods[i].mes
	movsbl (%rax), %esi		# 2º arg
	# %edx = prods[i].ano
	movl 16(%rax), %edx		# 3º arg
	# %rcx = prods[i].preco
	movq 8(%rax), %rcx
	# %rcx -= m 
	subq %r9, %rcx			# 4º arg
	movl $0, %eax

	call printf

	# Recuperar caller-saved
	movq -8(%rbp), %r8		# i
	movq -16(%rbp), %r9		# m

	# i++
	incl %r8d

	jmp while1
end_while1:

	# return 0
	movl $0, %eax

	leave
	ret
