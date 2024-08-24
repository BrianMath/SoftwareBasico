.section .rodata
	fmt1: .string "Objeto local [1] igual!\n"
	fmt2: .string "Objeto global igual!\n"

.data
	// rfid_object_t gObj
	.globl gObj
	.align 4
	gObj: .zero 24


.text
//            %rdi 
// int find(guid_t *id)
.globl find
find:
	pushq %rbp
	movq %rsp, %rbp
	subq $1024, %rsp

	// Salvar callee-saved (verdes)
	movq %rbx, -72(%rbp)
	movq %r12, -80(%rbp)

	# Salvar parâmetro *id em %rbx
	movq %rdi, %rbx

	# int found = 0 -> %r12
	movl $0, %r12d
	# rfid_object_t lObj[2];
	# short pins[5]

	// init_obj(&gObj, 0)
	movq $gObj, %rdi
	movl $0, %esi
	call init_obj

	// init_obj(&lObj[0], 1)
	leaq -48(%rbp), %rdi
	movl $1, %esi
	call init_obj

	// init_obj(&lObj[1], 2)
	leaq -24(%rbp), %rdi
	movl $2, %esi
	call init_obj

	// init_pins(pins)
	leaq -58(%rbp), %rdi
	call init_pins

	// _if (compare_guid(&lObj[1].id, id))
	
	//                  %rdi      %rsi
	// (compare_guid(&lObj[1].id, id)
	leaq -24(%rbp), %rax		# &lObj[1]
	movq 4(%rax), %rdi			# &lObj[1].id
	movq %rbx, %rsi
	call compare_guid
	# Retorno em %eax
if1:
	cmpl $0, %eax
	je end_if1

	// printf("Objeto local [1] igual!\n")
	movq $fmt1, %rdi
	movl $0, %eax
	call printf

end_if1:

	// _if (compare_guid(id, &gObj.id))
	movq %rbx, %rdi
	movq $gObj, %rax		# &gObj
	movq 4(%rax), %rsi		# &gObj.id
	call compare_guid
	# Retorno em %eax
if2:
	cmpl $0, %eax
	je end_if2

	movq $fmt2, %rdi
	movl $0, %eax
	call printf

end_if2:

	// _for (int i = 0; i < 2; i++)
	# int i = 0 -> %r8d
	movl $0, %r8d
for1:
	cmpl $2, %r8d
	jge end_for1

	// _for (int j = 0; j < 5; j++)
	# int j = 0 -> %r9d
	movl $0, %r9d
for2:
	cmpl $5, %r9d
	jge end_for2

	// _if (pins[j] == lObj[i].pin)
	// pins[j]
	leaq -58(%rbp), %r10		# &pins[0]
	movslq %r9d, %r11			# (long)j
	imulq $2, %r11
	addq %r11, %r10				# %r10 = &pins[j]
	movw (%r10), %cx			# %cx = pins[j]

	// lObj[i].pin
	leaq -48(%rbp), %r10
	movslq %r8d, %r11
	imulq $24, %r11

	# j++
	incl %r9d
	jmp for2

end_for2:

	# i++
	incl %r8d
	jmp for1

end_for1:


	// Recuperar callee-saved
	movq -72(%rbp), %rbx
	movq -80(%rbp), %r12

	leave
	ret
