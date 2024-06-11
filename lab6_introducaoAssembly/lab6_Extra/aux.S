.data
	.globl str
	.align 1
	str: .string "BEBAMUITOCAFE"

.text
.globl process
process:
	pushq %rbp
	movq %rsp, %rbp

	# Inicialização de 'ptr' aqui (Obs: utilize %r8 como sendo 'ptr')
	movq $str, %r8

beginwhile:
	cmpb $0, (%r8)
	je endwhile

	# Adiciona o valor 32 no conteúdo apontado por %r8 em 1 byte da string
	addb $32, (%r8)
	# Incrementa o endereço de %r8 em 1 posição
	incq %r8

	jmp beginwhile

endwhile:
	leave
	ret
