%{
    #include "level.tab.h"
    extern int yylval;
%}

%%
([0-9]+|([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?)  { yylval.dval = atoi(yytext); return NUMBER; }
[ \t]   ;
[a-z]   { yyval.vblno = yytext[0] - 'a'; return VARIABLE; }
"?"     { return 0; }
\n      |
.       return yytext[0];
%%
