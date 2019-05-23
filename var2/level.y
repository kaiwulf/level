%{
    /* gcc lex.yy.c level.tab.c -o adder -lm -lfl -ly */
    #include <stdio.h>
    double vbltable[26];
    int yylex();
    void yyerror(char *);
%}

%union {
	double dval;
	int vblno;
}

%token <vblno> VARIABLE
%token <dval> NUMBER
%left '-' '+'
%left '*' '/'
%nonassoc UMINUS

%type <dval> expression
%%
statement_list:	statement '\n'
	|	statement_list statement '\n'
	;

statement:	VARIABLE '=' expression	{ vbltable[$1] = $3; }
	|	expression		{ printf("= %lf\n", $1); }
	;

expression:	expression '+' expression { $$ = $1 + $3; }
	|	expression '-' expression { $$ = $1 - $3; }
	|	expression '*' expression { $$ = $1 * $3; }
	|	expression '/' expression
				{	if($3 == 0.0)
						yyerror("divide by zero");
					else
						$$ = $1 / $3;
				}
	|	'-' expression %prec UMINUS	{ $$ = -$2; }
	|	'(' expression ')'	{ $$ = $2; }
	|	NUMBER
	|	VARIABLE			{ $$ = vbltable[$1]; }
	;
%%
