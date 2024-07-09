.section .rodata
	fmt1: .string "Soma: %ld\n"

.text
.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp

	movq %r12, -8(%rbp)

	# short s -> %r12w
	# long l		| -16(%rbp)
	# int i			| -20(%rbp)

	// s = (short)constante();
	call constante
	# retorno em %al
	
	# s = (short)constante()
	movsbw %al, %r12w

	//    %di %rsi %rdx
	// init(s, &l, &i)
	movw %r12w, %di			# 1º arg
	leaq -16(%rbp), %rsi	# 2º arg
	leaq -20(%rbp), %rdx	# 3º arg
	call init
	# sem retorno

	// printf("Soma: %ld\n", l + i + s)
	movq $fmt1, %rdi		# 1º arg
	movq -16(%rbp), %rsi	# %rsi = l
	movslq -20(%rbp), %r8	# %r8 = (long)i
	addq %r8, %rsi			# %rsi = l + (long)i
	movswq %r12w, %r8		# %r8 = (long)s
	addq %r8, %rsi			# 2º arg | %rsi = l + (long)i + (long)s
	movl $0, %eax
	call printf

	// return 0
	movl $0, %eax

	movq -8(%rbp), %r12

	leave
	ret
