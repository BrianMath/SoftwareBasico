.data
	.globl last
	.align 8
	last: .quad 0

	.globl values
	.align 8
	values: .quad 50, -10, 60, -20, 70

.text
.globl swap
swap:
	pushq %rbp
	movq %rsp, %rbp

	# i -> r8d
	# j -> r9d; int j = 4
	movl $4, %r9d
	
	# i = 0
	movl $0, %r8d

loop:
	# _for (i = 0; i < j; i++, j--)
	cmpl %r9d, %r8d
	jge end_loop

	# rax = &values 
	movq $values, %rax
	# r10 = (long) i 
	movslq %r8d, %r10
	# r10 = i * sizeOf(long) == i * 8
	imulq $8, %r10
	# r10 = &values + (i * sizeOf(long))
	addq %rax, %r10
	# tmp -> r11; long tmp = values[i]
	movq (%r10), %r11

	# rax = &values
	movslq %r9d, %rbx		# rbx = (long) j
	imulq $8, %rbx			# rbx = j * sizeOf(long)
	addq %rax, %rbx			# rbx = &values[j]
	movq (%rbx), %rcx		# rcx = values[j]
	# values[i] = values[j]
	movq %rcx, (%r10)
	# values[j] = tmp;
	movq %r11, (%rbx)

	incl %r8d
	decl %r9d

	jmp loop

end_loop:

	# last = values[4];
	movq $values, %r10
	movq 32(%r10), %r11
	movq %r11, last

	leave
	ret
