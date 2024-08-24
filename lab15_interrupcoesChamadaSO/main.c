#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include "encode.h"

//----------------------------------------------------------------------------
// Considere:
//   * size_t  -> unsigned long

#define TAM 128

int main(int argc, char** argv) {
	char buf[TAM];
	ssize_t len;

	handler_t handler = { 0 };

	// Input será do arquivo
	handler.buffer = buf;
	handler.size = TAM;

	if (argc != 3) {
		fprintf(stderr, "Usage: %s <input_file> <output_file>\n", argv[0]);
		return 1;
	}

	// Abre o arquivo
	handler.input = open(argv[1], O_RDONLY);

	if (handler.input < 0) {
		perror("[ERRO] Falha na abertura do arquivo de entrada: ");
		return 1;
	}

	init(&handler, argv[2], O_CREAT | O_RDWR | O_TRUNC);

	if (handler.output < 0) {
		perror("[ERRO] Falha na abertura do arquivo saída: ");
		return 1;
	}

	while ((len = read(handler.input, handler.buffer, TAM)) > 0) {
		handler.size = len;
		if (!encode(&handler)) {
			perror("[ERRO] Falha na codificação: ");
			
			return 1;
		}
	}

	close(handler.input);
	release(&handler);

	return 0;
}