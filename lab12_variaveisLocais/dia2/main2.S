.section .rodata
	fmt1: .string "sum = %ld\n"

.data

.text

// node_s
// | int size       |		+0
// | 4 padding      |		+4
// | long values[5] |		+8
// | int used       |		+48
// | 4 padding      |		+52
// total = 56
 

// %rax         %rdi        %esi
// long sum(node_t* nodes, int size)
.globl sum
sum:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp

	leave
	ret

# ############################ #

.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp

	leave
	ret