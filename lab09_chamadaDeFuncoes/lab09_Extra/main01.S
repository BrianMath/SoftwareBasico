.section .rodata
	fmt1: .string "'a' maior do que 'b'\n"

	fmt2: .string "Valor de 'b': %d\n"

.data
	.globl a
	.align 1
	a: .byte 97

	.globl b
	.align 1
	b: .byte 105

.text
.globl main
main:
	pushq %rbp
	movq %rsp, %rbp

	// int ret = maximo(a, b)
	
	#         %dil    %sil 
	# maximo(char a, char b)
	movb a, %dil
	movb b, %sil
	
	call maximo

	# ret = %eax; ret -> %r8d
	movl %eax, %r8d

if:
	# _if (ret == (int)a)
	movsbl a, %r9d	# %r9d = (int)a
	cmpl %r9d, %r8d
	jne else

	# printf("'a' maior do que 'b'\n")
	movq $fmt1, %rdi
	movl 0, %eax

	call printf

	jmp end_if

else:	
	// printf("Valor de 'b': %d\n", (int)b)
	movsbl b, %r10d	# %r10d = (int)b
	movq $fmt2, %rdi
	movl %r10d, %esi
	movl $0, %eax

	call printf

end_if:

	leave
	ret
