.section .rodata

fmt: .string "Soma: %ld\n"

.data
	.globl sum
	.align 8
	sum: .quad 0

	.globl vet
	.align 8
	vet: .quad 10, 20, 30, 40, 50

.text
.globl main
main:
	pushq %rbp
	movq %rsp, %rbp

	# Inicializações de 'i' e 'ptr' aqui
	# Obs: utilize %ecx para 'i' e %r8 para 'ptr'
	movq $vet, %r8
	movl $0, %ecx

beginwhile:
	cmpl $5, %ecx
	jge endwhile

	# sum = sum + *ptr;
	movq sum, %r9
	addq (%r8), %r9
	movq %r9, sum

	# ptr++
	addq $8, %r8
	# i++
	addl $1, %ecx

	jmp beginwhile

endwhile:
	movq $fmt, %rdi    # printf()
	movq sum, %rsi
	movl $0, %eax
	call printf

	movl $0, %eax      # return 0
	leave
	ret
