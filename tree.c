#include "level.h"

tree *createt(char *node, int value) {
    tree trie;

    trie = (tree*) malloc(sizeof(tree));

    strcpy(trie.token, node);
    trie.value = value;
    trie.left = NULL;
    trie.right = NULL;
    return trie;
}

tree *insert(tree *treep, tree *newp) {
    int cmp;

    if(treep == NULL)
        return newp;

    cmp = strcmp(newp->name, treep->name);

    if(cmp == 0)
        printf("insert: duplicate entry %s ignored", newp->name);
    else if(cmp < 0)
        treep->left = insert(treep->left, newp);
    else
        treep->right = insert(treep->right, newp);
    return treep;
}

tree *lookup(tree *treep, char *name) {
    int cmp;

    if(treep == NULL)
        return NULL;
    cmp = strcmp(name, treep->name);
    if(cmp == 0)
        return lookup(treep->left, name);
    else
        return lookup(treep->right, name);
}

tree *nrlookup(tree *treep, char *name) {
    int cmp;

    while(treep != NULL) {
        cmp = strcmp(name, treep->name);
        if(cmp == 0)
            return treep;
        else if(cmp < 0)
            treep = treep->left;
        else
            treep = treep->right;
    }
    return NULL;
}

void applyinorder(tree *treep, void (*(*fn)(tree*, void*)), void *arg) {
    tree *tl;
    // tl = (tree*) malloc(sizeof(tree));
    if(treep == NULL)
        return arg;
    applyinorder(treep->left, fn, arg);
    tl = (tree*) (*fn)(treep, arg);
    applyinorder(treep->right, fn, arg);
}

void *nvprint(tree *treep, void *arg) {
    char *fmt;

    fmt = (char *) arg;
    printf(fmt, p->name, p->value);
}

void applypostorder(tree *treep, void (*(*fn)(tree*, void*)), void *arg) {
    if(treep == NULL)
        return;
    applypostorder(treep->left, fn, arg);
    applypostorder(treep->right, fn, arg);
    (*fn)(treep, arg);
}

void applypreorder(tree *treep, void (*(*fn)(tree*, void*)), void *arg) {
    if(treep == NULL)
        return;
    (*fn)(treep, arg);
    applypostorder(treep->left, fn, arg);
    applypostorder(treep->right, fn, arg);
}

void dfs(tree *trie) {

}
