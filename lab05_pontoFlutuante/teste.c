#include <stdio.h>

int main() {
	int a = 0, b = 0;
	if (a && b) {
		printf("bilau\n");
	}
	if (a & b) {
		printf("biloca\n");
	}

	a = 1, b = 0;
	if (a && b) {
		printf("bilela\n");
	}
	if (a & b) {
		printf("bolila\n");
	}

	a = 0, b = 1;
	if (a && b) {
		printf("balela\n");
	}
	if (a & b) {
		printf("pinto\n");
	}
	
	bool aa = true, bb = false;
	if (a || b) {
		printf("pomba\n");
	}
	// 00000010 == 00000001
	if (a == 0 == b) {
		printf("rola\n");
	}

	return 0;
}
