#include <stdio.h>

extern char byte_quociente;
extern char byte_resto;
extern char word_quociente;
extern char word_resto;
extern char long_quociente;
extern char long_resto;
extern char quad_quociente;
extern char quad_resto;

extern char byte_quociente_un;
extern char byte_resto_un;
extern char word_quociente_un;
extern char word_resto_un;
extern char long_quociente_un;
extern char long_resto_un;
extern char quad_quociente_un;
extern char quad_resto_un;

void divisao();

int main() {
	divisao();
	printf("DIVISÕES COM SINAL:\n\n");
	printf("BYTE: -11/2 == %d, resto == %d\n", byte_quociente, byte_resto);
	printf("WORD: 23/5 == %d, resto == %d\n", word_quociente, word_resto);
	printf("LONG: -35/-7 == %d, resto == %d\n", long_quociente, long_resto);
	printf("QUAD: 29/-9 == %d, resto == %d\n\n", quad_quociente, quad_resto);

	printf("DIVISÕES SEM SINAL:\n\n");
	printf("BYTE: 11/2 == %d, resto == %d\n", byte_quociente_un, byte_resto_un);
	printf("WORD: 23/5 == %d, resto == %d\n", word_quociente_un, word_resto_un);
	printf("LONG: 35/7 == %d, resto == %d\n", long_quociente_un, long_resto_un);
	printf("QUAD: 29/9 == %d, resto == %d\n\n", quad_quociente_un, quad_resto_un);	

	return 0;
}