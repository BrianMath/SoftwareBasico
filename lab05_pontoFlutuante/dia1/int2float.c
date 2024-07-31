#include <stdio.h>

#define getsig(i)        ((i)>>31 & 1)
#define getexp(i)        ((i)>>23 & 0xff)
#define getfrac(i)       ((i) & 0x7fffff)
#define makefloat(s,e,f) ( (((s) & 1) << 31) | (((e) & 0xff) << 23) | ((f) & 0x7fffff) )

typedef union {
	float f;
	unsigned int i;
} U;

float int2float(int num) {
	U uniao;

	if (num == 0) {
		uniao.i = makefloat(0, 0, 0);
		return uniao.f;
	}

	// 1) Transformar em binário e positivo
	int sig = 0;
	
	if (num < 0) {
		sig = 1;
		num = -num;
	}

	// 2) Normalizar
	int mask = 1, E = 0;

	// mask ==	0000 0000 | 0000 0000 | 0000 0000 | 0000 0100
	// num 	==	0000 0000 | 0000 0000 | 0000 0000 | 0000 0010 == 2

	for (int i = 0; i < 32; i++) {
		if (num & mask) {
			E = i;		
		}

		mask <<= 1;
	}

	// 3) Salvar a fração 
	int frac;

	if (E == 23) {
		frac = num;		
	} else if (E < 23) {
		frac = num << (23 - E);
	} else if (E > 23) {
		frac = num >> (E - 23);
	}

	// 4) Calcular expoente
	int exp = E + 127;

	uniao.i = makefloat(sig, exp, frac);
	return uniao.f;
}


int main() {
	int i;

	printf("\n******** int2float ****************\n");

	i = 0;
	printf(" %d -> %+10.4f, %+10.4f\n", i, (float)i, int2float(i));

	i = 1;
	printf(" %d -> %+10.4f, %+10.4f\n", i, (float)i, int2float(i));

	i = -1;
	printf(" %d -> %+10.4f, %+10.4f\n", i, (float)i, int2float(i));

	i = 256;
	printf(" %d -> %+10.4f, %+10.4f\n", i, (float)i, int2float(i));

	i = 12345;
	printf(" %d -> %+10.4f, %+10.4f\n", i, (float)i, int2float(i));

	i = -12345;
	printf(" %d -> %+10.4f, %+10.4f\n", i, (float)i, int2float(i));

	i = 13631488;
	printf(" %d -> %+10.4f, %+10.4f\n", i, (float)i, int2float(i));

	i = 1879048192;
	printf(" %d -> %+10.4f, %+10.4f\n", i, (float)i, int2float(i));

	i = 0x7fffffff;
	printf(" %d -> %+10.4f, %+10.4f\n", i, (float)i, int2float(i));

	i = -i;
	printf(" %d -> %+10.4f, %+10.4f\n", i, (float)i, int2float(i));

	return 0;
}
