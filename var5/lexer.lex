%{
    #include "level.tab.h"
    extern struct symtab *symlook(char *s);
    /* extern int yylval; */
%}

%%
([0-9]+|([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?)  { yylval.dval = atof(yytext); return NUMBER; }
[ \t]   ;
[A-Za-z][A-Za-z0-9]*    {
    struct symtab *sp = symlook(yytext);
    yylval.symp = sp;
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