%{
    #include <stdio.h>
    #include <stdlib.h>
    #define YYDEBUG 1
    void yyerror(char const *);
    int yylex();
%}

%define api.value.type {int}
%token NUMBER
%%

input:
      %empty
    | input statement
    ;

 statement:	/*VARIABLE '=' expr {  $1 = $3; } */
    '\n'
	|	expr '\n'                  { printf ("%.10g\n", $1); }
	;

expr:
      NUMBER                { $$ = $1; }
	|   expr '+' NUMBER     { $$ = $1 + $3; }
	|	expr '-' NUMBER     { $$ = $1 - $3; }
	;
%%

void yyerror(char const *s) {
    fprintf (stderr, "%s\n", s);
}
