#include <stdio.h>

void dump(void *p, int n) {
	unsigned char *p1 = p;
	
	while (n--) {
		printf("%p - %02x\n", p1, *p1);
		p1++;
	}
}

int main(void) {
	short s = -3; // -0000 0000 0000 0011 == 1111 1111 1111 1101 (-3)
	int i = -151;
	char c = 200; // -1100 1000 == 0011 1000 (-56)
  
	printf("dump de s: %d\n", s);
	dump(&s, sizeof(s));
	
	printf("\ndump de i: %d\n", i);
	dump(&i, sizeof(i));
	
	printf("\ndump de c: %d\n", c);
	dump(&c, sizeof(c));
	
	return 0;
}
