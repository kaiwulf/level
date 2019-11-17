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
    extern struct sym_list *list_create();
    extern struct sym_node *put_sym(char *, double);
    extern struct sym_node *symlook(char *, const char *, double);
    extern void context_check(char *sym_name);
    extern double sqrt(), exp(), log();
    extern void install(char *, double);

    int yylex();
    void yyerror(const char *s);

%}

%union {
    double dval;
    char *str;
    struct sym_node *sym_node;
}

%token <str> VARIABLE
%token <str> FUNC
%token <dval> NUMBER
%token PRINT COLON DOUBLECOL ENDCOL END
%token ADDOP SUBOP DIVOP EQOP LET SEMICOL
%token LET WHAT THEN RSQUARE LSQUARE
%left '*' DIVOP
%left ADDOP SUBOP
%right '^'
%nonassoc UMINUS

%type <dval> expr

%%

program:
        LET DOUBLECOL declarations ENDCOL body SEMICOL
      | statement_list

statement_list: statement '\n'
    | statement_list statement '\n'
    ;

statement:
      PRINT     { print_list(); }
    | VARIABLE EQOP expr    { install($1, $3); }
    | expr     { printf("%.10g\n", $1); }
    | body SEMICOL
    ;

body:
      START COLON commands STOP

commands:
      commands command

command:
    WHAT LBLOCK expr RBLOCK COLON commands THEN commands END WHAT SEMICOL

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
    | VARIABLE              { struct sym_node *node = get_sym($1);
                              if(!node) yyerror("no such symbol");
                              else $$ = node->value; }
    | expr ADDOP expr { $$ = $1 + $3; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(void) {
    g_sym_list = list_create();
    yyparse();

    return 0;
}
