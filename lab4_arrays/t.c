#include <stdio.h>

int main() {
	int a[10] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
	int *p = a;

	printf("%lu - %lu - %lu\n", sizeof(a), sizeof(a[0]), sizeof(p));
	p += 3;
	printf("%lu - %d\n", sizeof(p), *p);

	return 0;
}

