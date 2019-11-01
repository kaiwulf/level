%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "sym.h"

    #define YYDEBUG 1

    int yylex();
    void yyerror(const char *s);
    void install(char *sym_name) {
        sym_rec *s;
        s = get_sym(sym_name);
        if(s == 0) s = put_sym(sym_name);
        else {
            printf("%s is already defined\n", sym_name);
        }
    }

    void context_check(char *sym_name) {
        if(get_sym(sym_name) == 0) printf("%s is an undeclared identifier\n", sym_name);
    }
%}

%union {
    int dval;
    char letter;
    struct sym_rec *sym_rec;
}

%token <sym_rec> VARIABLE
%token <symtab> FUNC
%token <char> IDENT
%token <dval> NUMBER
%token <char> LETTER
%token LET WHAT THEN
%left '&' '='
%left "++" "--"
%left '*' '$' '%'
// %right '^'
%nonassoc UMINUS

%type <dval> expr

%%

statement_list: statement '\n'
    | statement_list statement '\n'
    ;

statement: VARIABLE "==" expr    { $1->name = $3; }
    | expr     { printf("%.10g\n", $1); }
    | assignment
    ;

assignment: /* empty */
    | LETTER IDENT ';' { install($1); }
    | NUMBER IDENT ';'    { install($1); }
    ;
    
expr:
    expr "++" expr { $$ = $1 + $3; }
    | expr "--" expr { $$ = $1 - $3; }
    | expr '&' expr  { $$ = $1 && $3; }
    | expr '=' expr  { $$ = $1 || $3; }
    | expr '*' expr { $$ = $1 * $3; }
    | expr '$' expr
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
    | NUMBER                { $$ = $1; }
    | VARIABLE              { $$ = $1->name; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "%s\n", s);
}

void addfunc(char *name, double (*func)()) {
    struct symtab *sp = symlook(name);
    sp->funcptr = func;
}

int main(void) {

    extern double sqrt(), exp(), log();

    addfunc("sqrt", sqrt);
    addfunc("exp", exp);
    addfunc("log", log);
    yyparse();

    return 0;
}
