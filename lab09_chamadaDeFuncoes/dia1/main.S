.section .rodata
	str0: .string "Hello"

.data
	.globl val
	.align 4
	val: .int 432

	.globl age
	.align 2
	age: .short 4

	.globl r
	.align 4
	r: .int 0

	.globl err
	.align 8
	err: .quad 2048

.text
.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	
	#             %rdi   %esi %dx  %rcx
	# val = sum("Hello", val, age, &r);
	movq $str0, %rdi
	movl val, %esi
	movw age, %dx
	movq $r, %rcx	
	call sum
	movl %eax, val

	#      %rdi %esi %edx 
	# show(err, val, r);
	movq err, %rdi
	movl val, %esi
	movl r, %edx 
	call show

	leave
	ret
