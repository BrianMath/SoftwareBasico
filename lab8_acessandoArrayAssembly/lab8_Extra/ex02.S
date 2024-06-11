.data
	.globl letters
	.align 1
	letters: .string "abcdefghij"
	
	.globl even
	.align 4
	even: .int 0 

	.globl odd
	.align 4
	odd: .int 0 

.text
.globl ex02
ex02:
	pushq %rbp
	movq %rsp, %rbp

	# unsigned int count = 0;
	movl $0, %r8d

while:
	# letters[count]
	movq $letters,  %r9		# &letters 
	movl %r8d, %r10d		# (long) i
	imulq $1, %r10			# i * sizeOf(char)
	addq %r9, %r10			# %r10 = &letters + (i * sizeOf(char))

	# _while (letters[count]) {
	cmpb $0, (%r10)
	je end_while
	
	# _if (letters[count++] & 1)
	movb (%r10), %r11b
	andb $1, %r11b
	incl %r8d
	
	cmpb $0, %r11b
	je else

	# odd++;
	incl odd
	jmp end_if

else:
	incl even

end_if:

	jmp while 

end_while:

	leave
	ret
