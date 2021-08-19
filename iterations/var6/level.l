%{
    #include "level.tab.h"
    extern struct sym_node *symlook(char *s);
    /* extern int yylval; */
%}

%%
([0-9]+|([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?)  { yylval.dval = atof(yytext); return NUMBER; }
\+\+        { return ADDOP; }
\-\-        { return SUBOP; }
\$          { return DIVOP; }
==          { return EQOP; }
print       { return PRINT; }
what        { return WHAT; }
then        { return THEN; }
let         { return LET; }
end         { return END; }
how         { return HOW; }
\[          { return RSQUARE; }
\]          { return LSQUARE; }
:           { return COLON; }
\;          { return SEMICOL; }
::          { return DOUBLECOL; }
:\;         { return ENDCOL; }

[ \t]   ;
[A-Za-z][A-Za-z0-9]*    {
    yylval.str = strndup(yytext, strlen(yytext)+1);
    return VARIABLE;
}

\n      |
.       return yytext[0];
%%
int yywrap(void)
{
     return 0;
}
