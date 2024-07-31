#include <stdio.h>

/*
struct X {
	long b;
	long d;
	char a;
	char c;
	char e;
};
*/


struct X {
	int a;
	short b;
	float c;
};


// campos:         b                    d                 a     c     e
//struct X varx = {0xB1B2B3B4B5B6B7B8, 0xD1D2D3D4D5D6D7D8, 0xA1, 0xC1, 0xE1};

//       campos:    a           b       c
struct X varx = {0xA1A2A3A4, 0xB1B2, 4};

void dump(void *p, int n) {
	unsigned char *p1 = p;

	while (n--) {
		printf("%p - 0x%08b\n", p1, *p1);
		p1++;
	}
}

int main() {
	dump(&varx, sizeof(varx));

	printf("%lu\n", sizeof(varx));

	return 0;
}
