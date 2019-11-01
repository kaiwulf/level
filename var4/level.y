%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "sym.h"

    int yylex();
    void yyerror(const char *s);
    struct symtab *symlook(char *s);
    double vbltable[26];
%}

%union {
    double dval;
    struct symtab *symp;
}

%token <symp> VARIABLE
%token <dval> NUMBER
%left '+' '-'
%left '*' '/'
%nonassoc UMINUS

%type <dval> expr
%%

statement_list: statement '\n'
    | statement_list statement '\n'
    ;

statement: VARIABLE '=' expr    { $1->value = $3; }
    | expr     { printf("%.10g\n", $1); }
    ;


expr:
    expr '+' expr { $$ = $1 + $3; }
    | expr '-' expr { $$ = $1 - $3; }
    | expr '*' expr { $$ = $1 * $3; }
    | expr '/' expr
        {
            if($3 == 0.0)
                yyerror("divide by zero\n");
            else
                $$ = $1 / $3;
         }
    | VARIABLE '(' expr ')' {
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
    | VARIABLE              { $$ = $1->value; }
    ;
%%

struct symtab *symlook(char *s) {
    char *p;
    struct symtab *sp;

    for(sp = symtab; sp < &symtab[NSYMS]; sp++) {
        if(sp->name && !strcmp(sp->name, s))
            return sp;
        if(!sp->name) {
            sp->name = strdup(s);
            return sp;
        }
    }
    yyerror("Too many symbols");
    exit(1);
}

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
