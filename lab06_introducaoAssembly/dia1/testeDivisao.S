.data
	.globl byte_quociente
	.align 1
	byte_quociente: .byte 0

	.globl byte_resto
	.align 1
	byte_resto: .byte 0

	.globl word_quociente
	.align 2
	word_quociente: .word 0

	.globl word_resto
	.align 2
	word_resto: .word 0

	.globl long_quociente
	.align 4
	long_quociente: .long 0

	.globl long_resto
	.align 4
	long_resto: .long 0

	.globl quad_quociente
	.align 8
	quad_quociente: .quad 0

	.globl quad_resto
	.align 8
	quad_resto: .quad 0

	# ############################### #

	.globl byte_quociente_un
	.align 1
	byte_quociente_un: .byte 0

	.globl byte_resto_un
	.align 1
	byte_resto_un: .byte 0

	.globl word_quociente_un
	.align 2
	word_quociente_un: .word 0

	.globl word_resto_un
	.align 2
	word_resto_un: .word 0

	.globl long_quociente_un
	.align 4
	long_quociente_un: .long 0

	.globl long_resto_un
	.align 4
	long_resto_un: .long 0

	.globl quad_quociente_un
	.align 8
	quad_quociente_un: .quad 0

	.globl quad_resto_un
	.align 8
	quad_resto_un: .quad 0

.text
.globl divisao
divisao:
	pushq %rbp
	movq %rsp, %rbp

	# dividendo / divisor
	# dividendo tem locais específicos
	# divisor só precisa respeitar o tamanho

	# Divisões com sinal

	# divisão de 1 byte (byte)
	# -11/2 == -5, resto == -1
	movb $-11, %r8b
	movb $2, %r9b

	movb %r8b, %al
	cbtw # Estende o sinal de %al (byte) para %ax (word)
	idivb %r9b
	movb %al, byte_quociente
	movb %ah, byte_resto

	# divisão de 2 bytes (word)
	# 23/5 == 4, resto == 3
	movw $23, %r8w
	movw $5, %r9w

	movw %r8w, %ax
	cwtd # Estende o sinal de %ax (word) para %dx (word) -> DX:AX (doubleword)
	idivw %r9w
	movw %ax, word_quociente
	movw %dx, word_resto

	# divisão de 4 bytes (long)
	# -35/-7 == 5, resto == 0
	movl $-35, %r8d
	movl $-7, %r9d

	movl %r8d, %eax
	cltd # Estende o sinal de %eax (long) para %edx (long) -> EDX:EAX (quadword)
	idivl %r9d
	movl %eax, long_quociente
	movl %edx, long_resto

	# divisão de 8 bytes (quad)
	# 29/-9 == -3, resto == 2
	movq $29, %r8
	movq $-9, %r9

	movq %r8, %rax
	cqto # Estende o sinal de %rax (quad) para %rdx (quad) -> RDX:RAX (octoword)
	idivq %r9
	movq %rax, quad_quociente
	movq %rdx, quad_resto

	# ############################### #

	# Divisões sem sinal

	# divisão de 1 byte (byte)
	# 11/2 == 5, resto == 1
	movb $11, %r8b
	movb $2, %r9b

	movzbw %r8b, %ax	# Estende o dividendo (1 byte) com zeros para o dobro do tamanho (%ax: 2 bytes) 
	divb %r9b
	movb %al, byte_quociente_un
	movb %ah, byte_resto_un

	# divisão de 2 bytes (word)
	# 23/5 == 4, resto == 3
	movw $23, %r8w
	movw $5, %r9w

	movw %r8w, %ax		# Move o dividendo para a metade menos significativa
	movw $0, %dx		# E zera a metade mais significativa da dupla de registradores DX:AX (doubleword)
	divw %r9w
	movw %ax, word_quociente_un
	movw %dx, word_resto_un

	# divisão de 4 bytes (long)
	# 35/7 == 5, resto == 0
	movl $35, %r8d
	movl $7, %r9d

	movl %r8d, %eax		# Move o dividendo para a metade menos significativa
	movl $0, %edx		# E zera a metade mais significativa da dupla de registradores EDX:EAX (quadword)
	divl %r9d
	movl %eax, long_quociente_un
	movl %edx, long_resto_un

	# divisão de 8 bytes (quad)
	# 29/9 == 3, resto == 2
	movq $29, %r8
	movq $9, %r9

	movq %r8, %rax		# Move o dividendo para a metade menos significativa
	movq $0, %rdx		# E zera a metade mais significativa da dupla de registradores RDX:RAX (octoword)
	divq %r9
	movq %rax, quad_quociente_un
	movq %rdx, quad_resto_un

	leave
	ret
