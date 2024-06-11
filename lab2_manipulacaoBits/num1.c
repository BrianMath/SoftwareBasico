#include <stdio.h>

int odd_ones(unsigned int num) {
	int impar = 0;

	for (int i = 0; i < 32; i++) {
		//if (num & 1) {
		//	if (impar) {
		//		impar = 0;
		//	} else {
		//		impar = 1;
		//	}
		//}

		impar = impar ^ (num & 1);

		num = num >> 1;
	}

	return impar;
}

int main() {
	unsigned int v;

	v = 0x01010101;
	// 0000 0001 0000 0001 0000 0001 0000 0001
	printf("0x%X tem número %s de bits\n", v, odd_ones(v) ? "ímpar" : "par");

	v = 0x01030101;
	printf("0x%X tem número %s de bits\n", v, odd_ones(v) ? "ímpar" : "par");

	return 0;
}
