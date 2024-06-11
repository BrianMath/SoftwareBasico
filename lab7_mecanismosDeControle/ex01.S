.section .rodata

.data
	.globl a
	.align 4
	a: .int 30

	.globl b
	.align 4
	b: .int 45

	.globl c
	.align 4
	c: .int -60

	.globl d
	.align 4
	d: .int 25

.text
.globl ex01
ex01:
	pushq %rbp
	movq %rsp, %rbp

	movl a, %r8d
	movl b, %r9d

	# _if (a > b) { --> (a <= b)
	cmpl %r9d, %r8d
	jle end_if1
	
		# c = -c
		negl c

		# d = c / 3
		movl c, %eax # dividendo deve estar em rax
		cltd
		movl $3, %r10d
		idivl %r10d
		movl %eax, d

	# }
	
end_if1:
	movl a, %r8d
	movl b, %r9d
	movl c, %r10d

	# _if (b >= a) { --> (b < a)
	cmpl %r8d, %r9d
	jl end_if2

		# c = (a + b) * c
		addl %r8d, %r9d
		imull %r9d, %r10d
		movl %r10d, c

		# d = 1024
		movl $1024, d
	# }

end_if2:

	leave
	ret
