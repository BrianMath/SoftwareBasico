.section .rodata
	.align 8
	tmp1: .double 0.0

.data

.text

// produto_s
// | int id       |		+0
// | 4 - padding  |		+4
// | double value |		+8
// total = 				+16

// stack
// | %xmm10 |			-8
// | %rdi   |			-16

//                    %rdi
// double max_prod(produto_t *ptr)
.globl max_prod
max_prod:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp

	# double m = 0.0 -> %xmm10
	movsd tmp1, %xmm10

	// _while (ptr->id)
while:
	cmpl $0, (%rdi)
	je end_while

	// double tmp = floor(ptr->value)

	# Salvar registradores caller-saved (amarelos)
	movsd %xmm10, -8(%rbp)
	movq %rdi, -16(%rbp)

	//         %xmm0
	// floor(ptr->value)
	movsd 8(%rdi), %xmm0
	call floor
	# Retorno em %xmm0

	# Recuperar registradores amarelos
	movsd -8(%rbp), %xmm10
	movq -16(%rbp), %rdi

	# double tmp = floor(ptr->value) -> %xmm11
	movsd %xmm0, %xmm11

	// _if (m < tmp)
if:
	ucomisd %xmm11, %xmm10
	jp end_if
	jae end_if

	# m = tmp
	movsd %xmm11, %xmm10

end_if:

	# ptr++
	addq $16, %rdi

	jmp while

end_while:

	# return m
	movsd %xmm10, %xmm0

	leave
	ret