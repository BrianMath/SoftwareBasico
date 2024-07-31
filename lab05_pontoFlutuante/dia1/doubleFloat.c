#include <stdio.h>

#define getsig(i)        ((i)>>31 & 1)
#define getexp(i)        ((i)>>23 & 0xff)
#define getfrac(i)       ((i) & 0x7fffff)
#define makefloat(s,e,f) ( (((s) & 1) << 31) | (((e) & 0xff) << 23) | ((f) & 0x7fffff) )

typedef union {
	float f;
	unsigned int i;
} U;

float float2(float value) {
	unsigned int sig = 0, exp = 0, frac = 0;

	U uniao;
	uniao.f = value;

	sig = getsig(uniao.i);
	exp = getexp(uniao.i);
	frac = getfrac(uniao.i);

	exp += 1;

	uniao.i = makefloat(sig, exp, frac);
	return uniao.f;
}


int main() {
	float dobro = float2(13.12);

	printf("%f\n", dobro);

	return 0;
}
