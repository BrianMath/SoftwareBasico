.data
	.globl s
	.align 4
	s: .int 0

	.globl nums
	.align 4
	nums: .int 65, -105, 111, 34

.text
.globl sum
sum:
	pushq %rbp
	movq %rsp, %rbp

	# i = 0
	movl $0, %r8d
	# s
	movl s, %eax

loop:
	cmpl $4, %r8d
	jge end_loop

	# r9 = &nums
	movq $nums, %r9
	# r10 = (long) i
	movslq %r8d, %r10
	# r10 = i * sizeOf(int) == i * 4
	imulq $4, %r10
	# r10 = &nums + (i * sizeOf(int))
	addq %r9, %r10
	# eax = nums[i]
	movl (%r10), %eax
	# s += nums[i]
	addl %eax, s

	# i++
	incl %r8d
	jmp loop

end_loop:

	leave
	ret
