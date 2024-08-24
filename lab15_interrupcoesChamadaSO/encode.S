.data
	.globl start
	.align 1
	start: .byte 0x7E

	.globl escape
	.align 1
	escape: .byte 0x7B, 0x61, 0x7D

.text

//               %rdi            %rsi             %edx
// void init(handler_t *h, const char *filename, int flags)
.globl init
init:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp

	// h->output = open(filename, flags, 0600)

	movq %rdi, -8(%rbp)
	movq %rsi, -16(%rbp)
	movq %rdx, -24(%rbp)

	// open(filename, flags, 0600)
	movq %rsi, %rdi
	movl %edx, %esi
	movl $0x180, %edx
	movq $2, %rax
	syscall

	movq -8(%rbp), %rdi
	movq -16(%rbp), %rsi
	movq -24(%rbp), %rdx

	// h->output = %eax
	movl %eax, 4(%rdi)

	leave
	ret

# ###################################################### #

//                 %rdi
// void release(handler_t* h)
.globl release
release:
	pushq %rbp
	movq %rsp, %rbp

	// close(h->output)
	movl 4(%rdi), %edi
	movq $3, %rax
	syscall

	leave
	ret

# ###################################################### #

// %eax          %rdi
// int encode(handler_t* h)
.globl encode
encode:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp

	movq %r13, -16(%rbp)
	movq %r14, -24(%rbp)

	# char b -> -1(%rbp)
	# int r -> %r13d

	// r = write(h->output, &start, 1)

	movq %rdi, %r8		# h fica salvo em %r8

	// write(h->output, &start, 1)
	movl 4(%rdi), %edi	# 1º arg
	movq $start, %rsi	# 2º arg
	movq $1, %rdx		# 3º arg
	movq $1, %rax		# num syscall
	syscall
	# Retorno em %eax

	movq %r8, %rdi		# Recupera h

	# r = write()
	movl %eax, %r13d

	// _if (r != 1) { return 0; }
if1:
	cmpl $1, %r13d
	je end_if1

	movl $0, %eax

	movq -16(%rbp), %r13
	movq -24(%rbp), %r14

	leave
	ret

end_if1:

	// _for (int i = 0; i < h->size; i++)
	# int i = 0 -> %r14d
	movl $0, %r14d
for1:
	movq 8(%rdi), %r8		# %r8 = h->size
	movslq %r14d, %r9		# %r9 = (long)i
	cmpq %r8, %r9			
	jge end_for1

	// b = h->buffer[i]
	movq 16(%rdi), %r8		# %r8 = h->buffer	
	movslq %r14d, %r9		# %r9 = (long)i
	movb (%r8, %r9, 1), %al
	movb %al, -1(%rbp)

	// _if (b == 0x61)
if2:
	movb -1(%rbp), %al
	cmpb $0x61, %al
	jne else_if2

	// r = write(h->output, &escape, 3)

	movq %rdi, %r8		# h fica salvo em %r8

	// write(h->output, &escape, 3)
	movl 4(%rdi), %edi 	# 1º arg
	movq $escape, %rsi	# 2º arg
	movq $3, %rdx		# 3º arg
	movq $1, %rax		# num syscall
	syscall
	# Retorno em %eax

	movq %r8, %rdi		# Recupera h

	# r = write()
	movl %eax, %r13d

	// _if (r != 3) { return 0; }
if3:
	cmpl $3, %r13d
	je end_if3

	movl $0, %eax

	movq -16(%rbp), %r13
	movq -24(%rbp), %r14

	leave
	ret

end_if3:

	# i++
	incl %r14d

	jmp for1

else_if2:
	// r = write(h->output, &b, 1)

	movq %rdi, %r8		# h fica salvo em %r8

	// write(h->output, &b, 1)
	movl 4(%rdi), %edi 	# 1º arg
	leaq -1(%rbp), %rsi	# 2º arg
	movq $1, %rdx		# 3º arg
	movq $1, %rax		# num syscall
	syscall
	# Retorno em %eax

	movq %r8, %rdi		# Recupera h

	# r = write()
	movl %eax, %r13d

	// _if (r != 1) { return 0; }
if4:
	cmpl $1, %r13d
	je end_if4

	movl $0, %eax

	movq -16(%rbp), %r13
	movq -24(%rbp), %r14

	leave
	ret

end_if4:

end_if2:

	# i++
	incl %r14d

	jmp for1

end_for1:

	# return 1
	movl $1, %eax

	movq -16(%rbp), %r13
	movq -24(%rbp), %r14

	leave
	ret