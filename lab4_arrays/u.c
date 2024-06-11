#include <stdio.h>

union u {
	char c;
	int i;
	char *s;
};

int main() {
	union u u1;

	u1.c = 'B';
	printf("%c - size: %lu\n", u1.c, sizeof(u1.c));

	u1.i = 20;
	printf("%d - size: %lu\n", u1.i, sizeof(u1.i));

	u1.s = "BrianBonitao";
	printf("%s - size: %lu\n", u1.s, sizeof(u1.s));
	
	return 0;
}
