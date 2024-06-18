#include <stdio.h>
int main() {
	signed char sc = -1; // -0000 0001 == 1111 1111
	unsigned int ui = sc; // 1111 1111 1111 1111 1111 1111 1111 1111
	
	printf("0x%08X - %u\n", ui, ui);
	
	return 0;
}
