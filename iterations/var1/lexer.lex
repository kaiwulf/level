%{
    #include <stdlib.h>
    #include "level.tab.h"
    extern int yylval;
%}

%%
[0-9]+	{ yylval = atoi(yytext); return NUMBER; }
[ \t]	;		/* ignore white space */
\n	return 0;	/* logical EOF */
.	return yytext[0];
%%

/* int yywrap(void)
{
     return 0;
} */

int main(void)
{
    yyparse();
    return 0;
}
