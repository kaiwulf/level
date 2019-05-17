%{
    #include <stdio.h>
    int yylex();
    void yyerror(const char *s);
    double vbltable[26];
%}

%union {
    double dval;
    int vblno;
}

%token <vblno> VARIABLE
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

statement: VARIABLE '=' expr    { vbltable[$1] = $3; }
    | expr     { printf("%d", $1); }
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
    | '(' expr ')'      { $$ = $1; }
    | '-' expr %prec UMINUS  { $$ = -$2; }
    | NUMBER            { $$ = $1; }
    | VARIABLE          { $$ = vbltable[$1]; }
    ;

/*stmt:
    IF expr stmt
    | IF expr stmt ELSE stmt
    ;*/
%%
/*void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
    return 0;
}*/
/*
int main(void) {
    yyparse();
    return 0;
}*/
