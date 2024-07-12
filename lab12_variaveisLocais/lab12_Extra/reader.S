// struct Object
//	int type			+0
//	4 -padding-			+4
//	long ID				+8
//	char name[16]		+16
//	total = 			32

// struct Person
//	int type			+0
//	4 -padding-			+4
//	long ID				+8				
//	char name[16]		+16
//	int age				+32
//	4 -padding-			+36
//	total =				40	

// struct Car
//	int type			+0
//	4 -padding-			+4
//	long ID				+8
//	char name[16]		+16
//	char color[8]		+32
//	total =				40

.section .rodata
	fmt1: .string "id1 = %d, id2 = %d, id3 = %d\n"
	fmt2: .string "Person ID: %ld\n"
	fmt3: .string "Car ID: %ld\n"
	fmt4: .string "tipo = %d, ID = %ld, nome = '%s', idade = %d\n"
	fmt5: .string "tipo = %d, ID = %ld, nome = '%s', cor = '%s'\n"

# #################################################### #

.text
//               %rdi
// void reader(long verbose)
.globl reader
reader:
	pushq %rbp
	movq %rsp, %rbp
	subq $256, %rsp

	# Salvar registradores callee-saved (verde)
	movq %rbx, -144(%rbp)

	// Pilha de reader()
	//	| %rbp |
	//	| p    | <= -40(%rbp)
	//	| c[1] | <= -80(%rbp)
	//  | c[0] | <= -120(%rbp)
	//	| id1  | <= -124(%rbp)
	//  | id2  | <= -128(%rbp)
	//  | id3  | <= -132(%rbp)
	//  | padd | <= -133(%rbp) a -136(%rbp)
	//  | %rbx | <= -144(%rbp)

	# int id1, id2, id3
	# struct Person p
	# struct Car c[2]

	// Vou salvar o %rdi em um registrador callee-saved (verde)
	// pra não precisar salvar em toda chamada de função
	movq %rdi, %rbx


	// readPerson(&p, &id1)
	leaq -40(%rbp), %rdi
	leaq -124(%rbp), %rsi
	call readPerson
	
	// readCar(&c[0], &id2)
	leaq -120(%rbp), %rdi
	leaq -128(%rbp), %rsi
	call readCar

	// readCar(&c[1], &id3)
	leaq -80(%rbp), %rdi
	leaq -132(%rbp), %rsi
	call readCar

	// _if (verbose) -> verbose é %rbx
if1:
	cmpq $0, %rbx
	je end_if1

	// printf("id1 = %d, id2 = %d, id3 = %d\n", id1, id2, id3)
	movq $fmt1, %rdi			# 1º arg
	leaq -124(%rbp), %rax	# &id1
	movl (%rax), %esi			# 2º arg
	leaq -128(%rbp), %rax	# &id2
	movl (%rax), %edx			# 3º arg
	leaq -132(%rbp), %rax	# &id3
	movl (%rax), %ecx			# 4º arg
	movl $0, %eax
	call printf

	// printf("Person ID: %ld\n", p.ID)
	movq $fmt2, %rdi			# 1º arg
	leaq -40(%rbp), %rax	# &p			
	movq 8(%rax), %rsi			# 2º arg
	movl $0, %eax
	call printf

	// printf("Car ID: %ld\n", c[0].ID)
	movq $fmt3, %rdi			# 1º arg
	leaq -120(%rbp), %rax	# &c[0]
	movq 8(%rax), %rsi			# 2º arg
	movl $0, %eax
	call printf

	// printf("Car ID: %ld\n", c[1].ID)
	movq $fmt3, %rdi			# 1º arg
	leaq -80(%rbp), %rax	# &c[1]
	movq 8(%rax), %rsi			# 2º arg
	movl $0, %eax
	call printf

end_if1:
	
	// showPerson(&p)
	leaq -40(%rbp), %rdi		# 1º arg
	call showPerson

	// showCar(&c[0])
	leaq -120(%rbp), %rdi		# 1º arg
	call showCar

	// showCar(&c[1])
	leaq -80(%rbp), %rdi		# 1º arg
	call showCar

	# Recuperar registradores verdes
	movq -144(%rbp), %rbx

	leave
	ret

# ############################################################# #

// void showPerson(struct Person *person)
.globl showPerson
showPerson:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp

	# Salvar registradores callee-saved (verdes)
	movq %rbx, -8(%rbp)

	# Salvar *person em %rbx
	movq %rdi, %rbx

	// printf("tipo = %d, ID = %ld, nome = '%s', idade = %d\n",
	//	person->type, person->ID, person->name, person->age)
	movq $fmt4, %rdi		# 1º arg
	movl (%rbx), %esi		# 2º arg
	movq 8(%rbx), %rdx		# 3º arg
	leaq 16(%rbx), %rcx		# 4º arg
	movl 32(%rbx), %r8d		# 5º arg
	movl $0, %eax
	call printf

	# Recuperar registradores verdes
	movq -8(%rbp), %rbx

	leave
	ret

# ############################################################# #

// void showCar(struct Car *car)
.globl showCar
showCar:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp

	# Salvar registradores callee-saved (verdes)
	movq %rbx, -8(%rbp)

	# Mover *car para %rbx
	movq %rdi, %rbx

	// printf("tipo = %d, ID = %ld, nome = '%s', cor = '%s'\n",
	//	car->type, car->ID, car->name, car->color)
	movq $fmt5, %rdi		# 1º arg
	movl (%rbx), %esi		# 2º arg
	movq 8(%rbx), %rdx		# 3º arg
	leaq 16(%rbx), %rcx		# 4º arg
	leaq 32(%rbx), %r8		# 5º arg
	movl $0, %eax
	call printf

	# Recuperar registradores verdes
	movq -8(%rbp), %rbx

	leave
	ret
