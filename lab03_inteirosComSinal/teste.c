#include <stdio.h>

void boi(void *pointer) {
	char *p = pointer;

	printf("%lu\n", sizeof(pointer));
}

int main() {
	int num = -3;
	unsigned char *p = &num;

	printf("%lu\n", sizeof(p));
	boi(&num);

	return 0;
}
