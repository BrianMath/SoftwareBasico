.data
	.globl a
	.align 4
	a: .int 1

	.globl b
	.align 8
	b: .quad 5


.text
.globl ex02
ex02:
	pushq %rbp
	movq %rsp, %rbp

	# _if (a) {
	cmpl $0, a
	je end_if1

		# _if (b < 5)
		cmpq $5, b
		jge else1

			# b = (a << 1) + (a * b);
			movl a, %r8d
			shll $1, %r8d

			movslq a, %r10
			imulq b, %r10

			movslq %r8d, %r9 
			addq %r9, %r10
			movq %r10, b

		jmp end_if1
		# }
else1:
		# _else {
			# a = b ^ 0x1FL;
			movq b, %r8
			xorq $0x1FL, %r8
			movl %r8d, a
		# }
	# }

end_if1:

	leave
	ret
