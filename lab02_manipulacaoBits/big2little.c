#include <stdio.h>

unsigned int convertB2L(unsigned int big) {
	unsigned int temp0 = big >> 24;
	unsigned int temp1 = (big >> 8) & 0x0000FF00;
	unsigned int temp2 = (big << 8) & 0x00FF0000;
	unsigned int temp3 = big << 24;

	return (temp0 | temp1 | temp2 | temp3);
}

int main() {
  unsigned int b = 0x12AB34CD;
  unsigned int l = convertB2L(b);

  printf("b = 0x%08X\n", b);
  printf("l = 0x%08X\n", l);

  return 0;
}
