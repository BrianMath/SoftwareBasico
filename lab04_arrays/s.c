#include <stdio.h>

struct s {
	int a;
	char c;
	int b;
};

int main() {
	struct s s1;
	s1.a = 10;
	s1.b = 20;
	s1.c = 1;

	printf("s1: %p - a:%p - b:%p - c:%p\n", &s1, &s1.a, &s1.b, &s1.c);

	return 0;
}

