#include <stdio.h>

int leading_zeros(unsigned short num) {
	int cont = 0;

	for (int i = 0; i < 16; i++) {
		if (num & 0x8000) {
			break;
		}

		cont++;
		num = num << 1;
	}	
	
	return cont;
}

int main() {
	printf("Zeros à esquerda: %d\n", leading_zeros(24432));
	printf("Zeros à esquerda: %d\n", leading_zeros(0));
	printf("Zeros à esquerda: %d\n", leading_zeros(0x0607));
	printf("Zeros à esquerda: %d\n", leading_zeros(0xC2A4));
	printf("Zeros à esquerda: %d\n", leading_zeros(0x0083));

	return 0;
}
