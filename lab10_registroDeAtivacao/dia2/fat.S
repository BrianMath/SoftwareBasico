.data

.text
.globl fat
fat:
	#           %edi 
	# int fat (int n) {
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp

	# _if (n > 0)
	cmpl $0, %edi
	jle end_if

	// return fat(n-1) * n;

	# Salve os valores
	movq %rdi, -8(%rbp)

	# Chame a função
	# fat(n-1)
	decl %edi
	call fat

	# Recupere os valores
	movq -8(%rbp), %rdi

	#  %eax     %edi
	# fat(n-1) * n
	imull %edi, %eax

	leave
	ret

end_if:
	# return 1;
	movl $1, %eax

	leave
	ret
