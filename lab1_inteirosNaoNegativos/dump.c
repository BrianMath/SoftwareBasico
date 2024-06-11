#include <stdio.h>

void dump(void *addr, int n) {
	unsigned char *p = (unsigned char *)addr;
	unsigned char *pp = (unsigned char *)addr;
	int nn = n;

	while (n--) {
		printf("%p - %08b\n", p, *p);
		p++;
	}

	printf("\n");

	while (nn--) {
		printf("%p - %02x\n", pp, *pp);
		pp++;
	}
}

int main() {
	char p[] = "ABCD"; // 10000 dec == 2710 hex
	dump(&p, sizeof(p));

	printf("%ld\n", sizeof(p));
 
	return 0;
}
