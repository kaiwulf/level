#include <ctype.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

/* constants */

/* functions */
int scanner(char**);
void scan_errf(int);
int var_ident(FILE*);
int digit_ident(FILE*)
void lexical_error(char);
tree *insert(tree *treep, tree *newp);
tree *lookup(tree *treep, char *name);
tree *nrlookup(tree *treep, char *name);
void applyinorder(tree *treep, void (*fn)(tree*, void*), void *arg);
void applypostorder(tree *treep, void (*fn)(tree*, void*), void *arg);

/* data structures */

enum {
    fpname_err,
    not_ident
};

enum {
    LPAREN,
    RPAREN,
    BEGINBLOCK,
    ENDBLOCK,
    COMMA,
    PERIOD,
    PLUSOP,
    MINUSOP,
    NOTOP,
    DIVOP,
    LAND,
    LOR,
    LXOR,
    NOT,
    MULTOP,
    MODOP,
    GTOP,
    LTOP,
    EXPOOP,
    POINTEROP,
    EQUAL,
    LEQOP
};

typedef struct TREE tree;

struct TREE {
    char *token;
    int value;
    tree *left;
    tree *right;
};
