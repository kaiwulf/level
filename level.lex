%{
    #include <math.h>
}%

DIGIT   [0-9]
ID      [a-z][a-z0-9]

%%

{DIGIT}+    {
        printf("An integer: %s (%d)", yytext, atoi(yytext));
}

{DIGIT}+"."{DIGIT}* {
        printf("A float: %s (%g)", yytext, atof(yytext));
}

let|num|dec|letter|loop|how|go|loop|what|then|segment|start|end|begin|stop
{
    printf("keyword %s\n", yytext);
}

"$"|"&"|"-"|"*"|%|"/"|"\"|"++"|"--"|"^"|"~"|"=="|","|"#"|"!"|"?"|"+"|"|"     {
        printf("operator %s\n", yytext);
}

[ \t\n]     /* white space */
.       printf("Unrecognized character\n");
