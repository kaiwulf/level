%{
    /*
    * Parser for level programming language.
    * Sections of code borroed and adopted from
    * "Compiler Construction using Flex and Bison"
    * by Anthony A. Aaby of Wall Walla College.
    */

    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <assert.h>
    #include "sym.h"

    #define YYDEBUG 1

    extern struct sym_list *g_sym_list;
    extern double sqrt(), exp(), log();
    extern struct sym_list *list_create();
    extern struct sym_node *put_sym(char *, double);

    int yylex();
    void yyerror(const char *s);
    void install(char *sym_name, double val) {
        struct sym_node *s;
        s = get_sym(sym_name);
        if(s == NULL) s = put_sym(sym_name, val);
        else {
            printf("symbol already exists\n");
        }
    }

    void context_check(char *sym_name) {
        if(get_sym(sym_name) == 0) printf("%s is an undeclared identifier\n", sym_name);
    }

%}

%union {
    double dval;
    char *str;

    struct sym_node *sym_node;
}

%token <str> VARIABLE
%token <sym_node> FUNC
%token <dval> NUMBER
%token ADDOP SUBOP DIVOP EQOP
%token LET WHAT THEN
%left '*' DIVOP
%left ADDOP SUBOP
%right '^'
%nonassoc UMINUS

%type <dval> expr

%%

statement_list: statement '\n'
    | statement_list statement '\n'
    ;

statement:
      VARIABLE EQOP expr    { install($1, $3); }
    | expr     { printf("%.10g\n", $1); }
    ;

expr:
      expr SUBOP expr { $$ = $1 - $3; }
    | expr '*' expr { $$ = $1 * $3; }
    | expr DIVOP expr
        {
            if($3 == 0.0)
                yyerror("divide by zero\n");
            else
                $$ = $1 / $3;
         }
    | FUNC '(' expr ')' {
        if($1->funcptr)
            $$ = ($1->funcptr)($3);
        else {
            printf("%s not a function\n", $1->name);
            $$ = 0.0;
        }
    }
    | '(' expr ')'          { $$ = $2; }
    | '-' expr %prec UMINUS { $$ = -$2; }
    | expr '^' expr         { $$ = pow($1, $3); }
    | NUMBER                { $$ = $1; }
    | VARIABLE              { struct sym_node *node = symlook($1);
                              $$ = node->value; }
    | expr ADDOP expr { $$ = $1 + $3; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "%s\n", s);
}

void addfunc(char *name, double (*func)()) {

    struct sym_node *sp = symlook(name);
    /*sp->name = strndup(name, strlen(name)+1);*/
    sp->funcptr = func;
}

struct sym_node *symlook(char *s) {
    char *p;
    struct sym_node *sp;
    for(sp = g_sym_list->head; sp != NULL; sp = sp->next) {
        if(sp->name != NULL) {                                      /* If a symbol is in the linked list... */
            if(strcmp(sp->name, s) != 0 && sp->next == NULL) {      /* ...and the symbols are different and the next node is empty... */
                sp->next = node_create(NULL, NULL, s, 0);           /* ...create a new node and insert string... */
            } else if(sp->next != NULL && sp->next->name == NULL) { /* ...else if next node exists and the string is null... */
                strncpy(sp->next->name, s, strlen(s)+1);            /* ...copy s to node's string field... */
            } else if(strcmp(sp->name, s) == 0)                     /* else if the string and symbol are the same, return the node.  */
                return sp;
        return sp;
        } else if(sp->name == NULL) {
            sp->name = strndup(s, strlen(s)+1);
            return sp;
        }
    }
}

int main(void) {
    g_sym_list = list_create();
    addfunc("sqrt", sqrt);
    addfunc("exp", exp);
    addfunc("log", log);
    yyparse();

    return 0;
}
