%{
    #include <math.h>
    int lineno;
%}

DIGIT   [0-9]
ID      [`_a-zA-Z]
OPS     "+"|"="|"*"|"/"|"=="|"~"|"&"|"%"|"|"|"~"|"++"|"--"|"\\"|"^"|"~"|"!"|"?"|"|"|"$"|"-"|"#"|":"
LBRACE  "("|"["|"{"|"::"|"<"
RBRACE  ")"|"]"|"}"|":;"|">"
KEY     let|num|dec|letter|how|go|loop|what|then|segment|start|end|begin|stop|void|un

LCOM    "@*"
RCOM    "*@"
SCOM    "?>"
%%
{LCOM}  printf("left comment block: %s\n", yytext);

{RCOM}  printf("right comment block: %s\n", yytext);

{SCOM}  printf("single comment line: %s\n", yytext);

{DIGIT}+ {
    printf("An integer: %s (%d)\n", yytext, atoi(yytext));
    }

{DIGIT}+"."{DIGIT}* {
    printf("A float: %s (%g)\n", yytext, atof(yytext));
    }

{KEY} {
    printf("keyword %s\n", yytext);
    }

{ID}({ID}|{DIGIT})* {
    printf("An i.d.: %s\n", yytext);
    }

{LBRACE} printf("left brace: %s\n", yytext);

{RBRACE} printf("right brace: %s\n", yytext);

{OPS} {
    printf( "An operator: %s\n", yytext );
    }

;   printf("Delemeter: %s\n", yytext);

[ \t\n]     /* white space */
.   printf("Unrecognized character %s\n", yytext);

%%
