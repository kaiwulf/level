%{
    #include "level.tab.h"
    /* extern int yylval; */
%}

%%
([0-9]+|([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?)  { yylval.dval = atof(yytext); return NUMBER; }
[ \t]   ;
[A-Za-z][A-Za-z0-9]*    {
        yylval.dval = atof(yytext);
        return NUMBER;
}

"$"     { return 0; }
\n      |
.       return yytext[0];
%%
