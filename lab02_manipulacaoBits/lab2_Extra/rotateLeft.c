#include <stdio.h>

unsigned char rotate_left1(unsigned char num, int shifts) {
	return (num >> (8-shifts) | num << shifts);
}

unsigned char rotate_left(unsigned char num, int shifts) {
	for (int i = 0; i < shifts; i++) {
		unsigned char temp = (num & 0x80);
		temp >>= 7;
		num <<= 1;
		num = (num | temp);
	}

	return num;
}

int main() {
	printf("%0x\n", rotate_left1(0x61, 1));
	printf("%0x\n", rotate_left1(0x61, 2));
	printf("%0x\n", rotate_left1(0x61, 7));

	printf("----------\n");
	
	printf("%0x\n", rotate_left(0x61, 1));
	printf("%0x\n", rotate_left(0x61, 2));
	printf("%0x\n", rotate_left(0x61, 7));

	return 0;
}
