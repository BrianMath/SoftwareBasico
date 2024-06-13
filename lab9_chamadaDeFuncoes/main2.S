.section .rodata

.data
	.globl i
	.align 4
	val: .int 0

	.globl bias
	.align 8
	bias: .quad 256

	.globl vet
	.align 1
	vet: .char 12, 3, 20, 8

.text
.globl main
main:
	pushq %rbp
	movq %rsp, %rbp

	

	leave
	ret

