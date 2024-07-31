.text

//               %xmm0     %xmm1 
// double calc1(double a, float b)
.globl calc1
calc1:
	pushq %rbp
	movq %rsp, %rbp

	// return (a+b)*(a-b)
	# a + b
	cvtss2sd %xmm1, %xmm2		# %xmm2 = (double)b
	addsd %xmm0, %xmm2			# %xmm2 = a + (double)b

	# a - b
	cvtss2sd %xmm1, %xmm1		# %xmm1 = (double)b
	subsd %xmm1, %xmm0			# %xmm0 = a - (double)b

	# (a+b)*(a-b)
	mulsd %xmm2, %xmm0

	leave
	ret
