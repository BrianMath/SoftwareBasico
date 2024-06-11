#include <stdio.h>
#include <stdlib.h>

struct s1 {
	char c;
	short s;
	int i;
	long l;
	float f;
};

struct s2 {
	short s;
	int i;
	long l;
	float f;
	char c;
};

struct s3 {
	int i;
	long l;
	float f;
	char c;
	short s;
};

struct s4 {
	long l;
	float f;
	char c;
	short s;
	int i;
};

struct s5 {
	float f;
	char c;
	short s;
	int i;
	long l;
};

int main() {
	char *pc = (char *) malloc(5 * sizeof(char));
	short *ps = (short *) malloc(5 * sizeof(short));
	int *pi = (int *) malloc(5 * sizeof(int));
	long *pl = (long *) malloc(5 * sizeof(long));
	float *pf = (float *) malloc(5 * sizeof(float));

	printf("char: %p\n", pc);
	printf("short: %p\n", ps);
	printf("int: %p\n", pi);
	printf("long: %p\n", pl);
	printf("float: %p\n\n", pf);

	struct s1 a;
	struct s2 *b;
	struct s3 *c;
	struct s4 *d;
	struct s5 *e;

	printf("a: %p - size: %lu\n", &a, sizeof(a));
	printf("b: %p - size: %lu\n", b, sizeof(struct s2));
	printf("c: %p - size: %lu\n", c, sizeof(struct s3));
	printf("d: %p - size: %lu\n", d, sizeof(struct s4));
	printf("e: %p - size: %lu\n", e, sizeof(struct s5));

	return 0;
}
