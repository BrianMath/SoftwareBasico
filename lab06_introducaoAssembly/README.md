# Introdução à linguagem Assembly

## Qual Assembly? 
- Arquitetura AMD64 (x86_64)
- Regras da linguagem C
- Assembly AT&T (Linux)


## Conteúdo da aula
- Código é separado em seções:
	- **Seção de dados:**
		- .section .data
		- .data
	- **Seção de código:**
		- .section .text
		- .text
	- **Seção somente de leitura:**
		- .section .rodata
- Temos 3 opções de armazenamento:
	- **Registradores da CPU:**
		- Podem armazenar 1, 2, 4 ou 8 bytes
	- **Variáveis globais:**
		- Definidas na seção de dados
		- Devem ser alinhadas com o tamanho do tipo de dado
		- Para serem acessadas de qualquer arquivo devem possuir a diretiva global
		- Exemplo:
		```assembly
		.data
			.globl var
			.align 1/2/4/8
			var: .tipo valor

		# Tipos inteiros:
		#	.byte -> 1 byte
		#	.word ou .short -> 2 bytes
		#	.long ou .int -> 4 bytes
		#	.quad -> 8 bytes
		
		# Strings:
		#	.ascii -> Não adiciona '\0' ao final da string
		#	.asciz ou .string -> Adiciona '\0' ao final da string
		```
	- **Variáveis locais:**
		- Usadas em funções
- Movimentação de dados:
	- Usamos a instrução **`mov[b w l q] fonte, destino`**, sendo o \[sufixo\] equivalente ao tipo de dado movimentado
	- Obs.:
		- `mov` movimenta constantes de até *32-bits* (signed)
		- `movabs` movimenta uma constante de *64-bits* (signed) para um registrador de *64-bits*.
			- Para mover uma constante de 64-bits para a memória deve-se mover para um registrador primeiro e dele para a memória
	- Tanto `fonte` quanto `destino` devem ser compatíveis com o sufixo
	- **NÃO** é possível movimentação entre memória -> memória, então pelo menos um entre `fonte` e `destino` deve ser um registrador ou constante
- Constantes e registradores:
	- Constantes (ou imediatos) devem ser escritos como em C, mas precedidos por '$':
		- `$5		# Decimal`
		- `$0x12FF	# Hexadecimal`
	- Registradores são acessados pelo nome precedido por '%':
		- `%rax`
		- `%r8d`
- Endereços de variáveis e ponteiros:
	- Para obter o endereço de uma variável utiliza-se o nome precedido por '$':
		- `$val # Endereço de val na memória`
	- Para deferenciar um registrador que guarda um endereço da memória (um ponteiro), utiliza-se o nome cercado por "()":
		```assembly
		.data
			num: .int 256

		.text
		main:
			# Endereço de val é movido para %r8
			movq $val, %r8
			
			# Note o sufixo de 4 bytes
			# val = 1
			movl $1, (%r8)
			
			# %r9d = 1
			movl (%r8), %r9d
		```
- Movimentação com extensão (tipo menor para maior):
	- Usamos duas instruções: **`movs[b w l][w l q] fonte, registrador`** ou **`movz[b w l][w l q] fonte, registrador`**
	- `movs` (signed) extende com o bit de sinal
	- `movz` (unsigned) extende com zeros
		- **NÃO** existe `movzlq`. Nesse caso, use `movl` para um registrador de 32-bits e utilize a sua parte de 64-bits (os bits mais significativos são zerados automaticamente pela CPU):
		```assembly
		movl %r8d, %r9d

		# O registrador %r9 agora possui o número anterior em 64-bits
		```
- Movimentação com truncamento (tipo maior para menor):
	- Utiliza-se a instrução `mov`, movendo só a parte truncada do registrador desejado:
	```assembly
	movq $256, %r8
	movl %r8d, %r9d

	# O registrador %r9d agora possui o número 256 em inteiro
	```
- Operações aritméticas:
	- O `operando` podem ser a memória ou um registrador
	- `inc[b w l q] operando` -> incrementa em 1 o valor armazenado
	- `dec[b w l q] operando` -> decrementa em 1 o valor armazenado
	- `neg[b w l q] operando` -> inverte o sinal do número
	- `add[b w l q] fonte, destino` -> adiciona a fonte no destino, sobrescrevendo o valor anterior no destino
	- `sub[b w l q] fonte, destino` -> subtrai a fonte do destino, sobrescrevendo o valor anterior no destino
	- `imul[w l q] fonte, destino` -> multiplica a fonte pelo destino, sobrescrevendo o valor anterior no destino
		- **NÃO** existe `imulb` com dois argumentos
- Divisão inteira:
	- **OBS.**: a divisão pode ser confusa, portanto, considere checar os arquivos `testeDivisao.S` e `testeDivisao.c`
	```zsh
	$ gcc -no-pie -o testeDivisao testeDivisao.S testeDivisao.c
	$ ./testeDivisao
	```
	- Usamos duas intruções: **`div[b w l q] divisor`** ou **`idiv[b w l q] divisor`**
	- O `divisor` pode ser a memória ou um registrador
	- O `dividendo` é feito pela combinação dos registradores `RDX:RAX` e suas subdivisões
		- Exceto para divisão de tipo byte, quando a combinação é entre `AH:AL`
	- O `quociente` é movido automaticamente para `RAX` e suas subdivisões
		- Exceto para divisão do tipo byte, quando é movido para `AL`
	- O `resto` é movido automaticamente para `RDX` e suas subdivisões
		- Exceto para divisão do tipo byte, quando é movido para `AH`
	- `div` (unsigned): é necessário mover o dividendo para a metade menos significativa (`RAX`) e zerar a metade mais significativa (`RDX`) antes de usar
	- `idiv` (signed): é necessário mover o dividendo para a metade menos significativa (`RAX`) e estender o sinal para a metade mais significativa (`RDX`) antes de usar
		- `cbtw` estende de AL -> AX (usado com `idivb`)
		- `cwtd` estende de AX -> DX (usado com `idivw`)
		- `cltd` estende de EAX -> EDX (usado com `idivl`)
		- `cqto` estende de RAX -> RDX (usado com `idivq`)	
	- A seguinte tabela pode ajudar:

| **Tamanho**     | **Dividendo** | **Estender com** | **Divisor** | **Quociente** | **Resto** |
|-----------------|:-------------:|:----------------:|:-----------:|:-------------:|-----------|
| _byte_          |       AL      |       cbtw       |  reg/mem08  |      %al      |    %ah    |
| _word ou short_ |     DX:AX     |       cwtd       |  reg/mem16  |      %ax      |    %dx    |
| _long ou int_   |    EDX:EAX    |       cltd       |  reg/mem32  |      %eax     |    %edx   |
| _quad_          |    RAX:RDX    |       cqto       |  reg/mem64  |      %rax     |    %rdx   |
- Operações bit a bit:
	- `and[b w l q] fonte, destino` -> destino = destino & fonte
	- `or[b w l q] fonte, destino` -> destino = destino | fonte
	- `xor[b w l q] fonte, destino` -> destino = destino ^ fonte
	- `not[b w l q] fonte, destino` -> destino = ~destino
	- `shl[b w l q] imediato/%cl, destino` -> destino = destino << imediato
	- `shr[b w l q] imediato/%cl, destino` -> destino = destino >> imediato (lógico)
	- `sar[b w l q] imediato/%cl, destino` -> destino = destino >> imediato (aritmético)


## Como compilar?
- `gcc -no-pie -o main main.S aux.c ...`