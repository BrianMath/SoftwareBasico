.section .rodata
	fmt: .string "Valor: x = %ld, i = %d\n"

.data
	.globl x
	.align 8
	x: .quad 10

.text
.globl aux
aux:
	#            %edi    %rsi
	# long aux(int i, long *ptr) {
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp # abre espaço na pilha para salvar as coisas locais

	# x = 5;
	movq $5, x

	# Salva os valores antes de chamar a função
	movq %rdi, -8(%rbp)  # i
	movq %rsi, -16(%rbp) # *ptr

	# Passa os argumentos para printf
	movl %edi, %r11d  # salva o i em um lugar temporário (%r11d)
	movq $fmt, %rdi   # 1º argumento (string)
	movq x, %rsi	  # 2º argumento (x)
	movl %r11d, %edx  # 3º argumento (i)

	# printf("Valor: x = %ld, i = %d\n", x, i);
	movl $0, %eax
	call printf

	# Recupera os argumentos passados
	movq -8(%rbp), %rdi  # i
	movq -16(%rbp), %rsi # *ptr

	# return x + i + *ptr;
	movslq %edi, %r8
	addq x, %r8
	addq (%rsi), %r8
	
	movq %r8, %rax

	leave
	ret
