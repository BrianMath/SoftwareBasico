#ifndef ENCODE_H

#include <stdlib.h>

//----------------------------------------------------------------------------
// Considere:
//   * size_t  -> unsigned long

struct handler_s {
	int input;
	int output;
	size_t size;
	char* buffer;
};

typedef struct handler_s handler_t;
void init(handler_t* h, const char* filename, int flags);
void release(handler_t* h);
int  encode(handler_t* h);

#endif