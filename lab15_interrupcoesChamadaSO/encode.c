#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include "encode.h"

extern char start; // = 0x7E;
extern char escape[3]; // = { 0x7B, 0x61, 0x7D };

// void init(handler_t* h, const char* filename, int flags) {
// 	// 0600 octal = 0x180 hexadecimal
// 	h->output = open(filename, flags, 0600);
// }

// void release(handler_t* h) {
// 	close(h->output);
// }

// int encode(handler_t* h) {
// 	char b;
// 	int r;

// 	r = write(h->output, &start, 1);

// 	if (r != 1) { return 0; }

// 	for (int i = 0; i < h->size; i++) {
// 		b = h->buffer[i];

// 		if (b == 0x61) {
// 			r = write(h->output, &escape, 3);
// 			if (r != 3) { return 0; }
// 			continue;
// 		} else {
// 			r = write(h->output, &b, 1);
// 			if (r != 1) { return 0; }
// 		}
// 	}

// 	return 1;
// }