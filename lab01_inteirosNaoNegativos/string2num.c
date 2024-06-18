#include <stdio.h>


int string2num(char *s, int base) {
	int a = 0;
	char sub;
	for ( ; *s; s++) {
		if (*s >= 'A') {
			sub = (*s - 'A' + 10);
		} else {
			sub = (*s - '0');
		}

		a = a*base + sub;
	}

	return a;
}

int main () {
	printf("==> %d\n", string2num("1234", 10));
	printf("==> %d\n", string2num("2322", 8));
	printf("==> %d\n", string2num("010011010010", 2));
	printf("==> %d\n", string2num("4D2", 16));

	return 0;
}

