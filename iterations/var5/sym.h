/*
 *	Symbol table for level interpreter
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#define NSYMS 20	/* maximum number of symbols */

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
struct sym_node *symlook(char *, const char *, double);
struct sym_node *add_to_table(char *, double);

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

    struct sym_node *sym = add_to_table(sym_name, val);
    return sym;
}

struct sym_node *add_to_table(char *s, double v) {
    struct sym_node *sp = malloc(sizeof(struct sym_node *));

    for(sp = g_sym_list->head; sp != NULL; sp = sp->next) {
        if(sp->name != NULL) {                                      /* If a symbol is in the linked list... */
            if(strcmp(sp->name, s) != 0 && sp->next == NULL) {      /* ...and the symbols are different and the next node is empty... */
                sp->next = node_create(NULL, NULL, s, v);           /* ...create a new node and insert string... */
            } else if(sp->next != NULL && sp->next->name == NULL) { /* ...else if next node exists and the string is null... */
                strncpy(sp->next->name, s, strlen(s)+1);            /* ...copy s to node's string field... */
                sp->next->value = v;                                /* ...and add value... */
            } else if(strcmp(sp->name, s) == 0)                     /* ...else if the string and symbol are the same, return the node... */
                return sp;
        } else if(sp->name == NULL) {                               /* ...but if string is NULL... */
            sp->name = strndup(s, strlen(s)+1);                     /* ...copy it, add it to the list node and return node. */
            sp->value = v;
            return sp;
        }
    }
}

struct sym_node *get_sym(char *sym_name) {
    struct sym_node *ptr;
    for(ptr = g_sym_list->head; ptr != NULL; ptr = ptr->next) {
        if(ptr->name != NULL) {
            if(strcmp(ptr->name, sym_name) == 0)
                return ptr;
        }
    }
    return NULL;
}

void print_list() {
    const struct sym_node *node = g_sym_list->head;

    printf("{");
    while(node) {
        if(node != g_sym_list->head) printf("; ");
        printf("%s, %.10g", node->value, node->name);
        node = node->next;
    }
    printf("}\n");
}

// https://stackoverflow.com/questions/20932623/global-pointer-in-linked-list
