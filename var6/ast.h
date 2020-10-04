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

typedef struct abs_syn_tree {
    enum code op;
    int val;
    struct symbol *sym;
    struct abs_syn_tree *left,*right;
    char *str;
} AST;

/* symbol table node to be inserted to hash table */
typedef struct sym {
    char *name;
    int val;
    int addr;
    AST *func_params;
    AST *func_body;
} symbol;

#define MAX_SYMS 100

extern symbol sym_table[];
extern int n_syms;

/* symbol table list to be used when collisions occure in hash table */
struct sym_list {
    struct sym_list *head;
}

void AST_print(AST *p);

AST *makeSymbol(char *name);
symbol *lookup_symbol(char *name);
symbole *get_symbol(AST *p);

AST *make_num(int val);
AST *make_str(char *s);
AST *make_AST(enum code op, AST *right, AST *left);

AST *get_nth(AST *p, int nth);
AST *get_next(AST *p);
AST *add_last(AST *l, AST *p);

#define getFirst(p) get_nth(p, 0)
#define makeList1(x1) make_AST(LIST, x1, NULL)
#define makeList2(x1, x2) make_AST(LIST, x1, make_AST(LIST, x2, NULL)
#define makeList3(x1, x2, x3) make_AST(LIST, x1, make_AST(LIST, x2, make_AST(LIST, x3, NULL)))

void define_func(symbol *fsym, AST *params, AST *body);
void decl_var(symbol *vsym, AST *init_value);
void decl_arr(symbol *asym, AST *size);

void error(char *msg);
