/*
 *	Symbol table for level interpreter
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define NSYMS 20	/* maximum number of symbols */

struct sym_rec *symlook(char *s);

struct sym_rec {
    double value;
    char *name;
    double (*funcptr)();
    struct sym_rec *next;
};

struct symtab {
	char *name;
    double (*funcptr)();
	double value;
} symtab[NSYMS];


struct sym_rec *put_sym(char *);
struct sym_rec *get_sym(char *);
struct sym_rec *create();
// struct sym_rec *get_head();
// void set_head(struct sym_rec *);

struct sym_rec *g_sym_table;
struct sym_rec g_sym_head;

struct sym_rec *create() {
    struct sym_rec *sym_table;
    sym_table = (struct sym_rec *) malloc(sizeof(struct sym_rec));
    sym_table->next = (struct sym_rec *) malloc(sizeof(struct sym_rec));
    sym_table->next = NULL;
    sym_table->funcptr = NULL;
    sym_table->name = "print";
    sym_table->value = 0;
    return sym_table;
}

struct sym_rec* put_sym(char *sym_name) {
    struct sym_rec *ptr;
    ptr = (struct sym_rec *) malloc(sizeof(struct sym_rec));
    ptr->name = (char *) malloc(strlen(sym_name)+1);
    strcpy(ptr->name, sym_name);
    ptr->next = (struct sym_rec *) g_sym_table;
    g_sym_table = ptr;

    return ptr;
}

struct sym_rec *get_sym(char *sym_name) {
    struct sym_rec *ptr;
    for(ptr = &g_sym_head; ptr != NULL; ptr = (struct sym_rec *) ptr->next) {
        if(strcmp(ptr->name, sym_name) == 0)
            return ptr;
    }
    return 0;
}

// https://stackoverflow.com/questions/20932623/global-pointer-in-linked-list