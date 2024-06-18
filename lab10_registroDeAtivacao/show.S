.section .rodata
	fmt: .string "%d\n"

.text
.globl show
show:
	#            %rdi    %rsi
	# void show(int *v, int size) {
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp

	# i -> %ecx

	# for (i = 0; i < size; i++)
	movl $0, %ecx
for01:
	cmpl %esi, %ecx # %esi é o 2º argumento da função (size)
	jge end_for01

	# printf("%d\n", v[i]);
	# Salva os valores antes de chamar a função
	movq %rcx, -8(%rbp)	 # abre espaço para a variável local i
	movq %rdi, -16(%rbp) # abre espaço para o 1º argumento (*v)
	movq %rsi, -24(%rbp) # abre espaço para o 2º argumento (size)

	# v[i]
	movq %rdi, %r8
	movslq %ecx, %r9
	imulq $4, %r9
	addq %r8, %r9

	# Passando os argumentos para a função printf
	movq $fmt, %rdi	 # 1º argumento é o char*
	movl (%r9), %esi # 2º argumento é int
	
	# Chama printf
	movl $0, %eax	 # printf exige em %eax a qtd de pontos flutuantes
	call printf

	# Recuperando os valores dos registradores antes da chamada da função
	movq -8(%rbp), %rcx
	movq -16(%rbp), %rdi
	movq -24(%rbp), %rsi 
	
	incl %ecx
	jmp for01

end_for01:

	leave
	ret
