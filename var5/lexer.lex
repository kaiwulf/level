%{
    #include "level.tab.h"
    extern struct sym_rec *symlook(char *s);
    /* extern int yylval; */
%}

%%
([0-9]+|([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?)  { yylval.dval = atof(yytext); return NUMBER; }
\+\+        { return ADDOP; }
\-\-        { return SUBOP; }
\$          { return DIVOP; }
==          { return EQOP; }
[ \t]   ;
[A-Za-z][A-Za-z0-9]*    {
    struct sym_rec *sp = symlook(yytext);
    yylval.sym_rec = sp;
    return VARIABLE;
}

\n      |
.       return yytext[0];
%%
int yywrap(void)
{
     return 0;
}