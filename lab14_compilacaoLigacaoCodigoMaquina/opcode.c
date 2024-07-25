#include <stdlib.h>
#include <stdio.h>

typedef int (*IntFunc)(int x);

void* build_exec(void* code, size_t size);

// Instruções da função (código de máquina)

unsigned char code[] = {
	// Colocar o hexadecimal do código aqui
	// 0x00, 0x00, ...
	0xf3, 0x0f, 0x1e, 0xfa,
	0x55, 
	0x48, 0x89, 0xe5, 
	0x89, 0x7d, 0xfc,
	0x8b, 0x45, 0xfc, 
	0x83, 0xc0, 0x01, 
	0x5d, 
	0xc3
};

int main() {
	// Copia as instruções para região executável
	unsigned char* exec = build_exec(code, sizeof(code));

	// f é um ponteiro para o código da função add()
	IntFunc f = (IntFunc)exec;
	int resp = f(41);

	printf("%d\n", resp);

	return 0;
}