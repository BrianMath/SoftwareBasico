.section .rodata
	fmt: .string "%d: sum = %ld\n"
	fmt2: .string "retorno = %ld\n"

.data
	.globl v
	.align 2
	v: .short 1, 2, 3, 4, 5

	.globl max
	.align 2
	max: .short 0

.text
.globl calc
calc:
	#               %rdi       %esi     %edx         %rcx        %r8b 
	# long calc(short *vet, int size, int factor, short *max, char option)
	pushq %rbp
	movq %rsp, %rbp
	# Abre espaço da memória
	subq $64, %rsp

	# Salvando registradores verdes
	movq %r12, -8(%rbp)
	movq %r13, -16(%rbp)
	movq %r14, -24(%rbp)

	# short value;         // Use obrigatoriamente r12w para 'value'
	# int i = 0;           // Use obrigatoriamente r13d para 'i'
	movl $0, %r13d
	# long sum = 0;        // Use obrigatoriamente r14 para 'sum'
	movq $0, %r14

	# _while (i < size)
while:
	cmpl %esi, %r13d
	jge end_while

	# value = vet[i]
	# &vet + i * 2 -> value
	movslq %r13d, %rax
	movw (%rdi, %rax, 2), %r12w

	# _if (*max < value)
	cmpw %r12w, (%rcx)
	jge end_if1

	# *max = value;
	movw %r12w, (%rcx)

end_if1:

	// sum = (long)(*max * (short)factor)
	movw %dx, %r9w		# %r9w = (short)factor
	imulw (%rcx), %r9w  # %r9w = *max * %r9w
	movswq %r9w, %r14	# sum = (long)%r9w

	// Salvar valores amarelos (pegar memória)
	movq %rdi, -32(%rbp) # short *data
	movq %rsi, -40(%rbp) # int size
	movq %rdx, -48(%rbp) # int factor
	movq %rcx, -56(%rbp) # short *max
	movq %r8, -64(%rbp)  # char option

	# printf("%d: sum = %ld\n", i++, sum)
	movq $fmt, %rdi	 # string
	movl %r13d, %esi # i
	incl %r13d		 # i++
	movq %r14, %rdx  # sum
	movl $0, %eax	 # qtd de floats passados

	call printf

	// Recuperando valores
	movq -32(%rbp), %rdi
	movq -40(%rbp), %rsi
	movq -48(%rbp), %rdx
	movq -56(%rbp), %rcx
	movq -64(%rbp), %r8

	jmp while

end_while:

	# _if (option == 1)
	cmpb $1, %r8b
	jne end_if2

	# _return sum
	movq %r14, %rax

	movq  -8(%rbp), %r12
	movq -16(%rbp), %r13
	movq -24(%rbp), %r14

	leave
	ret

end_if2:
	# _return 0
	movq $0, %rax

	movq  -8(%rbp), %r12
	movq -16(%rbp), %r13
	movq -24(%rbp), %r14

	leave
	ret

# ####################################################### #

.globl main
main:
	pushq %rbp
	movq %rsp, %rbp

	// long r = calc(v, 5, 2, &max, 1)
	movq $v, %rdi
	movl $5, %esi
	movl $2, %edx
	movq $max, %rcx
	movb $1, %r8b

	call calc

	# long r -> %r8
	# r = %eax
	movq %rax, %r8

	// printf("retorno = %ld\n", r)
	movq $fmt2, %rdi
	movq %r8, %rsi
	movl $0, %eax

	call printf

	leave
	ret
