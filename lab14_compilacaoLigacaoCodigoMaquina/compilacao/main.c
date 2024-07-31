#include <stdio.h>

void fill_a(int *ptr);

int get_b();

int a = 0;

int main (void) {
	fill_a(&a);
	int b = get_b();
	printf("a = %d, b = %d\n", a, b);

	return 0;
}