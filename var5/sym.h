/*
 *	Symbol table for level interpreter
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#define NSYMS 20	/* maximum number of symbols */

struct sym_node *symlook(char *s);

struct sym_node {
    double value;
    char *name;
    double (*funcptr)();
    struct sym_node *next;
};

struct sym_list {
    struct sym_node *head;
};

struct sym_node *put_sym(char *, double);
struct sym_node *get_sym(char *);
struct sym_list *list_create();
struct sym_node *symlook(char *);

struct sym_list *g_sym_list;

struct sym_node *node_create(struct sym_node *node, double (*funcptr)(), char *name, double value) {

    if(node == NULL) {
        node = (struct sym_node *) malloc(sizeof(struct sym_node));;
    } else {
        node->next = (struct sym_node *) malloc(sizeof(struct sym_node));
        node->next = node;
    }
    node->funcptr = funcptr;
    node->name = name;
    node->value = value;

    return node;
}

struct sym_list *list_create() {

    struct sym_list *list = malloc(sizeof(struct sym_list));

    list->head = node_create(NULL, NULL, NULL, 0);

    return list;
}

struct sym_node* put_sym(char *sym_name, double val) {

    struct sym_node *sym = symlook(sym_name);
    sym->value = val;
    return sym;
}

struct sym_node *get_sym(char *sym_name) {
    struct sym_node *ptr;
    for(ptr = g_sym_list->head; ptr != NULL; ptr = ptr->next) {
        if(ptr->name != NULL) {
            if(strcmp(ptr->name, sym_name) == 0)
                return ptr;
            else
                return NULL;
        } else if(ptr->name == NULL) {

        }
    }
}

// https://stackoverflow.com/questions/20932623/global-pointer-in-linked-list
