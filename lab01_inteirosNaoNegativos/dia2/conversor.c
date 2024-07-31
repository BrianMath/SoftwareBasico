#include <stdio.h>

char digits[] = "0123456789abcdefghijklmnopqrstuvwxyz";

void num2string(int num, int base, char* buf) {	
	int cont = 0;

	for (; num; num /= base) {
		buf[cont] = digits[num%base];

		cont++;
	}

	// Inverter buffer para impressão
	for (int i = 0; i < cont/2; i++) {
		char tmp = buf[i];
		buf[i] = buf[cont-1-i];
		buf[cont-1-i] = tmp;
	}
	buf[cont] = '\0';
}

int main() {
	char buffer[128];
	
	num2string(589, 2, buffer);
	printf("==> %s\n", buffer);

	num2string(589, 16, buffer);
	printf("==> %s\n", buffer);	
	
	num2string(589, 32, buffer);
	printf("==> %s\n", buffer);	
	
	return 0;
}
