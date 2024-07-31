.data
	.globl c
	.align 1
	c: .byte -20

	.globl i
	.align 4
	i: .int -256
	
	.globl j
	.align 4
	j: .int 512
	
	.globl l
	.align 8
	l: .quad 128
	
	.globl us
	.align 2
	us: .short 111 # unsigned
	
	.globl ui
	.align 4
	ui: .int 1024 # unsigned
	
	.globl ul
	.align 8
	ul: .quad 2048 # unsigned

.text
.globl aux
aux:
	pushq %rbp
	movq %rsp, %rbp

	// Atribuições simples
	# j = 68000;
	movl $68000, j
	# l = 4096;
	movq $4096, l
	# i = j;
	movl j, %r8d
	movl %r8d, i
	
	// Expressões
	# j = 10 + i - 5;
	movl i, %r8d
	addl $10, %r8d
	subl $5, %r8d
	movl %r8d, j
	# i = (i * 2) - (j + 5);
	movl i, %r8d
	imull $2, %r8d
	movl j, %r9d
	addl $5, %r9d
	subl %r9d, %r8d
	movl %r8d, i
	
	// Casts
	# unsigned ui = int i;
	movl i, %r8d
	movl %r8d, ui
	# int j = char c; 
	movsbl c, %r8d 
	movl %r8d, j
	# unsigned long ul = unsigned int ui 
	movl ui, %r8d
	movq %r8, ul
	# unsigned short us = unsigned long ul
	movq ul, %r8 
	movw %r8w, us
	# char c = int i + int j;
	movl i, %r8d
	addl j, %r8d
	movb %r8b, c

	// Ponteiros
	# long *ptr; -> %r8
	# ptr = &l;
	movq $l, %r8 
	# *ptr = 128;
	movq $128, (%r8)

	# int *iptr; -> %r9 
	# iptr = &i;
	movq $i, %r9 
	# j = j + *iptr;
	movl j, %r10d
	movl (%r9), %r11d
	addl %r10d, %r11d
	movl %r11d, j
	
	leave
	ret
