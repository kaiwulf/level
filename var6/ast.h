enum code {
    BLOCK_STATEMENT,
    EXP,
    WHEN_STATEMENT,
    HOW_STATEMENT,
    ADDOP,
    SUBOP,
    MULTOP,
    DIVOP,
    SYM
};

typedef struct AST {
    int val;
    char *str;
    enum code op;
    struct symbol_table *sym;
    struct AST *left, *right;
} ast;

/* symbol table node to be inserted to hash table */
typedef struct sym_node {
    char *name;
    int val;
    int addr;
    ast *func_params;
    ast *func_body;
} symbol;

/* symbol table list to be used when collisions occure in hash table */
struct sym_list {
    struct sym_list *head;
}

/*
    TODO:
    Implement hash table here
    sym_node will be individual nodes inserted to the hash table
*/
