/*
 *	Symbol table for level interpreter
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define NSYMS 20	/* maximum number of symbols */

struct symtab *symlook(char *s);

struct sym_rec {
    double value;
    char *name;
    struct sym_rec *next;
};

struct symtab {
	char *name;
    double (*funcptr)();
	double value;
} symtab[NSYMS];


struct sym_rec *sym_table = NULL;
struct sym_rec *put_sym();
struct sym_rec *get_sym();

struct sym_rec* put_sym(char *sym_name) {
    struct sym_rec *ptr;
    ptr = (struct sym_rec *) malloc(sizeof(struct sym_rec));
    ptr->name = (char *) malloc(strlen(sym_name)+1);
    strcpy(ptr->name, sym_name);
    ptr->next = (struct sym_rec *)sym_table;
    sym_table = ptr;

    return ptr;
}

struct sym_rec *get_sym(char *sym_name) {
    struct sym_rec *ptr;
    for(ptr = sym_table; ptr != NULL; ptr = (struct sym_rec *) ptr->next) {
        if(strcmp(ptr->name, sym_name) == 0)
            return ptr;
    }
    return 0;
}