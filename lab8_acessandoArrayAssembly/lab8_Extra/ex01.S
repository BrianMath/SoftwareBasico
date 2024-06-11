.data
	.globl vet
	.align 2
	vet: .short 50, 10, 67, 42

	.globl max
	.align 2
	max: .short 0

.text
.globl ex01
ex01:
	pushq %rbp
	movq %rsp, %rbp

	# char i -> %r8b
	# i = 0
	movb $0, %r8b

# _for (i = 0; i < 4; i++)
for_loop:
	cmpb $4, %r8b
	jge end_for

	# vet[i] 
	movq $vet, %r9		# %r9 = &vet 
	movsbq %r8b, %r10	# %r10 = (long)i
	imulq $2, %r10		# %r10 = i * sizeOf(short)
	addq %r9, %r10		# %r10 = &vet + (i * sizeOf(short))

	# _if (vet[i] > max)
	movw max, %r11w
	cmpw %r11w, (%r10)
	jle end_if

	# max = vet[i];
	movw (%r10), %r11w
	movw %r11w, max

end_if:
	
	incb %r8b
	jmp for_loop

end_for:

	leave
	ret
