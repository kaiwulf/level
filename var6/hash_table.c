#include <stdio.h>
#include "sym_table.h"


int main() {
	char c;
	struct hash_table *hash_table;
	for(c = 'a'; c < 10; c++) {
		hash_table = put_sym(c);
	}
}
