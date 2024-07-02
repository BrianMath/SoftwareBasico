#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>

char str[] = "beba muito mais cafe";

// Considere 'size_t' -> 'unsigned long'
void process(char *str, size_t size, char v) {
	size_t i = 0;
	while (i < size) {
		if (str[i] % v) {
			unsigned char c = (unsigned char)str[i];
			str[i] = (char)toupper((unsigned int)c);
		}

		i++;
	}
}

int main() {
	process(str, strlen(str), 2);
	printf("%s\n", str);

	return 0;
}
