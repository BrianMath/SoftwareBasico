#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/mman.h>

// Copia o código para uma área de memória executável para o código
void* build_exec(void* src, size_t size) {
	// Pede ao SO uma área de memória para código executável
	void* dst = mmap(NULL,
		getpagesize(),
		PROT_EXEC | PROT_READ | PROT_WRITE,
		MAP_PRIVATE | MAP_ANONYMOUS,
		-1, 0);

	if (dst == MAP_FAILED) {
		printf("[ERRO] Não foi possível alocar memória executável\n");
		exit(1);
	}

	// Copia o código binário para a área executável
	memcpy(dst, src, size);

	return dst;
}