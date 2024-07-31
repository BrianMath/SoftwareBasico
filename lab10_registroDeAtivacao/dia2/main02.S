.data
	.globl v1
	.align 2
	v1: .short 1, 2

	.globl v2
	.align 8
	v2: .quad 1, 2, 3

# ############################################### #

.text
.globl aux
aux:
	#              %rdi    %esi 
	# void aux(short *a1, int p1)
	pushq %rbp
	movq %rsp, %rbp

	// Alocar espaço para os registradores
	subq $32, %rsp

	# int i -> %r8d
	
	// for (i = 2; i >= 0; i--)
	
	# i = 2
	movl $2, %r8d
for:
	cmpl $0, %r8d
	jl end_for
	
	# Salvar valores amarelos
	movq %rdi, -8(%rbp)
	movq %rsi, -16(%rbp)
	movq %r8, -24(%rbp)

	// sum(a1, p1, v2, i)
	# Passar argumentos e chamar função sum()
	movq $v2, %rdx	# 3º arg
	movl %r8d, %ecx	# 4º arg
	call sum

	# Recuperar valores amarelos
	movq -8(%rbp), %rdi
	movq -16(%rbp), %rsi
	movq -24(%rbp), %r8

	decl %r8d
	jmp for

end_for:

	leave
	ret

# ############################################### #

.globl main
main:
	pushq %rbp
	movq %rsp, %rbp

	subq $16, %rsp

	# Salvar valores verdes
	movq %r12, -8(%rbp)

	# int i = 0 -> %r12d
	movl $0, %r12d
	
	// while (i < 2)
while:
	cmpl $2, %r12d
	jge end_while

	// aux(v1, i)
	movq $v1, %rdi		# 1º arg
	movl %r12d, %esi	# 2º arg
	call aux

	# i++
	incl %r12d

	jmp while

end_while:

	# return 0
	movl $0, %eax

	# Recuperar valores verdes
	movq -8(%rbp), %r12

	leave
	ret
