#include <stdio.h>
#include <math.h>
#include <limits.h>

#define getsig(x)			((x) >> 31 & 1)
#define getexp(x)			((x) >> 23 & 0xff)
#define getfrac(x)			((x) & 0x7fffff)
#define makefloat(s, e, f)  ((s & 1) << 31 | (((e) & 0xff) << 23) | ((f) & 0x7fffff))

typedef union {
	float f;
	unsigned int i;
} U;

int float2int(float value) {
	U uniao;
	uniao.f = value;
	
	unsigned int sig = getsig(uniao.i);
	unsigned int exp = getexp(uniao.i);
	unsigned int frac = getfrac(uniao.i);
	printf("s: %d - exp: %d - frac: 0x%08X:		", sig, exp, frac);

	// Caso seja 0.0 ou -0.0
	if (exp == 0 && frac == 0) {
		return 0;
	}
	// Se exp < 127 então value < 0, portanto, retorne 0
	if (exp < 127) {
		return 0;
	}

	int E = (int)exp - 127;
	int tmp;

	// 1 mais significativo do int foi movido pra posição 23 e cortado
	if (E < 23) {
		tmp = frac | (1 << 23);		// Adiciona o 1 cortado
		tmp = tmp >> (23 - E);		// Move pra posição inicial
		if (sig) { tmp = -tmp; }
		return tmp;
	}

	// 1 mais significativo do int já estava na posição 23 e foi cortado
	if (E == 23) {
		tmp = frac | (1 << 23);		// Adiciona o 1 cortado
		if (sig) { tmp = -tmp; }
		return tmp;
	}
	
	// 1 mais significativo estava à esquerda da posição 23 e foi movido para ela e cortado
	if (E > 23 && E < 31) {
		tmp = frac | (1 << 23);		// Adiciona o 1 cortado
		tmp = tmp << (E - 23);		// Move pra posição inicial
		if (sig) { tmp = -tmp; }
		return tmp;
	}
	
	// -2^31 é o menor int negativo válido
	if (sig && E == 31) {
		tmp = frac | (1 << 23);		// Adiciona o 1 cortado
		tmp = tmp << (E - 23);		// Move pra posição inicial
		if (sig) { tmp = -tmp; }
		return tmp;
	}

	// Overflow positivo
	if (!sig && E >= 31) {
		return INT_MAX;
	}

	// Overflow negativo
	if (sig && E > 31) {
		return INT_MIN;
	}

	return 0;
}


int main() {
	float f;

	printf("\n******** float2int ****************\n");

	f = 0.0;
	printf(" %+10.4f -> %d %d\n", f, (int)f, float2int(f));

	f = -0.0;
	printf(" %+10.4f -> %d %d\n", f, (int)f, float2int(f));

	f = 0.5;
	printf(" %+10.4f -> %d %d\n", f, (int)f, float2int(f));

	f = -0.5;
	printf(" %+10.4f -> %d %d\n", f, (int)f, float2int(f));

	f = 0.125;
	printf(" %+10.4f -> %d %d\n", f, (int)f, float2int(f));

	f = -0.125;
	printf(" %+10.4f -> %d %d\n", f, (int)f, float2int(f));

	f = 1.0;
	printf(" %+10.4f -> %d %d\n", f, (int)f, float2int(f));

	f = -1.0;
	printf(" %+10.4f -> %d %d\n", f, (int)f, float2int(f));

	f = 1.5;
	printf(" %+10.4f -> %d %d\n", f, (int)f, float2int(f));

	f = -1.5;
	printf(" %+10.4f -> %d %d\n", f, (int)f, float2int(f));

	f = 2.5;
	printf(" %+10.4f -> %d %d\n", f, (int)f, float2int(f));

	f = -2.5;
	printf(" %+10.4f -> %d %d\n", f, (int)f, float2int(f));

	f = 5.4;
	printf(" %+10.4f -> %d %d\n", f, (int)f, float2int(f));

	f = -5.4;
	printf(" %+10.4f -> %d %d\n", f, (int)f, float2int(f));

	f = 12345.0;
	printf(" %+10.4f -> %d %d\n", f, (int)f, float2int(f));

	f = -12345.0;
	printf(" %+10.4f -> %d %d\n", f, (int)f, float2int(f));

	f = 14690064.0;
	printf(" %+10.4f -> %d %d\n", f, (int)f, float2int(f));

	f = -14690064.0;
	printf(" %+10.4f -> %d %d\n", f, (int)f, float2int(f));

	f = 167788544.0;
	printf(" %+10.4f -> %d %d\n", f, (int)f, float2int(f));

	f = -167788544.0;
	printf(" %+10.4f -> %d %d\n", f, (int)f, float2int(f));

	f = (float)pow(2, 31);
	printf(" %+10.4f (2^31) = overflow -> %d %d\n", f, (int)f, float2int(f));

	f = -f;
	printf(" %+10.4f (-2^31) -> %d %d\n", f, (int)f, float2int(f));

	f = -((float)pow(2, 32));
	printf(" %+10.4f (-2^32 = overflow) -> %d %d\n", f, (int)f, float2int(f));

	return 0;
}
