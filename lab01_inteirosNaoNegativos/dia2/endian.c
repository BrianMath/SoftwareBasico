#include <stdio.h>

int is_little() {
	short num = 256;
	char* n = (char*) &num;

	return (*n == 0); 
}

int main() {
	if (is_little()) {
		printf("Little-endian!\n");
	} else {
		printf("Big-endian!\n");
	}

	return 0;
}
