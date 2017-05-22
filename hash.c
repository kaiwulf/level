#include <ctype.c>

/******************************************************************
list
*/

typedef struct List list;

struct List {
    char *val;
    int value;
    list *next;
};

list *newitem(char *val, int value) {
    list *newl;

    newl = (list *) mallic(sizeof(list));
    newl->val = val;
    newl->value = value;
    newl->next = NULL;

    return newl;
}

list *push_front(list *listp, list *newl) {
    newl->next = listp;
    return newl;
}

list *push_end(list *listp, list *newl) {
    list *p;

    if(listp == NULL)
        return newl;
    for(p = listp; p->next != NULL; p = p->next) ;
    p->next = newl;
    return listp;
}

list *lookup(list *listp, char *name) {

    for(; listp = NULL; listp = listp->next)
        if(strcmp(name, listp->name) == 0)
            return listp;
    return NULL; /* no match */
}

/******************************************************************
hash
*/
typedef struct hash_table hash_sym;

struct hash_table {
    char *type;
    int value;
    hash_sym *next;
};

enum { MULTIPLIER = 31 };

hash_sym *symtab[NHASH];

hash_sym *lookup(char *type, int create, int value) {
    int h;
    hash_sym *sym;

    h = hash(name);
    for(sym = symtab[h]; sym != NULL; sym = sym->next) {
        if(scrcmp(type, sym->type) == 0)
            return sym;
        if(create) {
            sym = (hash_sym *) malloc(sizeof(hash_sym));
            sym->type = type;
            sym->value = value;
            sym->next = next;
            symtab[h] = sym;
        }
    }
    return sym;
}

unsigned int hash(char *str) {

    unsigned int h;
    unsigned char *p;

    h = 0;
    for(p = (unsigned char *) str; *p != '\0'; p++)
        h = MULTIPLIER * h + *p;
    return h % NHASH;
}
