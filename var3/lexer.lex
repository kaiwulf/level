%{
    #include "level.tab.h"
    #include "sym.h"
    /* extern int yylval; */
%}

%%
([0-9]+|([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?)  { yylval.dval = atof(yytext); return NUMBER; }
[ \t]   ;
[A-Za-z][A-Za-z0-9]*    {
        yylval.symp = symlook(yytext);
        return VARIABLE;
}

"$"     { return 0; }
\n      |
.       return yytext[0];
%%

int yywrap(void)
{
     return 0;
}

int main(void)
{
    yyparse();
    return 0;
}
