#include <stdio.h>

void dump(void *p, int n) {
	unsigned char *p1 = p;
	while (n--) {
		printf("%p - %08b\n", p1, *p1);
		p1++;
	}
}

int main() {
	short s;
	int i;
	long l;
	s = 108;
	i = (int)s;
	
	printf("--- s:\n");
	dump(&s, sizeof(s));
	
	printf("--- i:\n");
	dump(&i, sizeof(i));
	
	printf("-----------------------------------------------------------------");
	
	i = -10;
	l = (long)i;
	
	printf("--- i:\n");
	dump(&i, sizeof(i));
	
	printf("--- l:\n");
	dump(&l, sizeof(l));
	
	printf("-----------------------------------------------------------------");
	
	l = 83728472363;
	i = (int)l;
	s = (short)l;
	
	printf("--- l:\n");
	dump(&l, sizeof(l));
	
	printf("--- i:\n");
	dump(&i, sizeof(i));
	
	printf("--- s:\n");
	dump(&s, sizeof(s));
	
	return 0;
}
