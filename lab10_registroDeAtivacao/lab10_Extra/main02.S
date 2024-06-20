.section .rodata

.data

.text
.globl aux
aux:
	#             %di       %si 
	# void aux(short *a1, int p1)
	pushq %rbp
	movq %rsp, %rbp

	# int i -> %ebx (callee)
	
	// _for (i = 2; i >= 0; i--)
	
	# i = 2
	movl $2, %ebx 
for:
	# i >= 0
	cmpl $0, %ebx
	jl end_for

	

	# i--
	decl %ebx
	jmp for

end_for:

	leave
	ret

# ###############################################

.globl main
main:
	pushq %rbp
	movq %rsp, %rbp

	leave
	ret

