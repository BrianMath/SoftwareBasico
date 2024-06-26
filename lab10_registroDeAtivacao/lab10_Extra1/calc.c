#include <stdlib.h>
#include <stdio.h>

short v[5] = {1, 2, 3, 4, 5};
short max = 0;

long calc(short *vet, int size, int factor, short *max, char option) {
	short value; // Use obrigatoriamente r12w para 'value'
	int i = 0; // Use obrigatoriamente r13d para 'i'
	long sum = 0; // Use obrigatoriamente r14 para 'sum'

	while (i < size) {
		value = vet[i];
		if (*max < value)
			*max = value;

		sum = (long)(*max * (short)factor);
		printf("%d: sum = %ld\n", i++, sum);
	}

	if (option == 1)
		return sum;

	return 0;
}

int main() {
	long r = calc(v, 5, 2, &max, 1);
	printf("retorno = %ld\n", r);

	return 0;
}
