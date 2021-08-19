%{
    #include <stdio.h>
    #include <stdlib.h>
    #define YYDEBUG 1
    void yyerror(char const *);
    int yylex();
%}

%define api.value.type {int}
%token VARIABLE NUMBER
%%


 statement:	VARIABLE '=' expr
	|	expr                   { printf ("%d\n", $1); }
	;

expr:
	|   expr '+' NUMBER     { $$ = $1 + $3; }
	|	expr '-' NUMBER     { $$ = $1 - $3; }
    |   NUMBER              { $$ = $1; }
	;
%%

void yyerror(char const *s) {
    fprintf (stderr, "%s\n", s);
}
