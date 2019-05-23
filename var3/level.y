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
/*program:
    program statement '\n'
    |
    ;*/

statement_list: statement '\n'
    | statement_list statement '\n'

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
    | '(' expr ')'      { $$ = $2; }
    | '-' expr %prec UMINUS  { $$ = -$2; }
    | NUMBER            { $$ = $1; }
    | VARIABLE          { $$ = $1->value; }
    ;

/*stmt:
    IF expr stmt
    | IF expr stmt ELSE stmt
    ;*/
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
/*
int main(void) {
    yyparse();
    return 0;
}*/
