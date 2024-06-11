#include <stdio.h>

int main() {
	unsigned int x = 0x87654321;
	unsigned int a, b;

	// Manter o byte menos significativo de x e os outros bits em '0'	
	//a = (x & 0b00000000000000000000000011111111);
	a = (x & 0x000000FF);
	
	printf("a = 0x%08X\n", a);

	// Mudar byte mais sign. para bits com '1' e manter os outros bytes
	b = (x | 0xFF000000);
	printf("b = 0x%08X\n", b);

	return 0;
}
