%{
    #include <math.h>
%}

DIGIT   [0-9]
ID      [*`][a-z][a-z0-9]
OPS     "+"|"="|"*"|"/"|"=="|"~"|"&"|"%"|"|"|"~"|"++"|"--"|"\\"|"^"|"~"|"!"|"?"|"|"|"$"|"-"|"#"
LBRACE  "("|"["|"{"|"::"|"<"
RBRACE  ")"|"]"|"}"|":;"|">"
KEY     let|num|dec|letter|loop|how|go|loop|what|then|segment|start|end|begin|stop|void|letter|un

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

{ID} {
    printf("An i.d.: %s\n", yytext);
    }

{LBRACE} printf("left brace: %s\n", yytext);

{RBRACE} printf("right brace: %s\n", yytext);

{KEY} {
    printf("keyword %s\n", yytext);
    }

{OPS} {
    printf( "An operator: %s\n", yytext );
    }

;   printf("Delemeter: %s\n", yytext);

[ \t\n]     /* white space */
.   printf("Unrecognized character %s\n", yytext);
%%

int main(int argc, char *argv[]) {
    yyin = fopen(argv[1], "r");
    yylex();
    fclose(yyin);
}
