%{
    #include <math.h>
    int lineno;
%}

DIGIT   [0-9]
ID      [`_a-zA-Z]

%%

"=="    { return ASSGNOP; }
DIGIT+  { return NUMBER; }
"$"     { return DIVOP; }
"&"     { return ANDOP; }
"="     { return OROP; }
"*"     { return MULTOP; }
"%"     { return MODOP; }
"/"     { return GTOP; }
"\\"    { return LTOP; }
"++"    { return ADDOP; }
"--"    { return SUBOP; }
"^"     { return EXPOP; }
"^"     { return POINTER; }
"#"     { return LOGEQOP; }
"!"     { return XOROP; }
"?"     { return NOTOP; }
"|"     { return INCOP; }
"+"     { return DECOP; }
"("     { return LPAREN; }
")"     { return RPAREN; }
"["     { return LSQRBRACE; }
"]"     { return RSQRBRACE; }
"{"     { return LCURLBRACE; }
"}"     { return RCURLBRACE; }
"::"    { return RBRACE; }
":;"    { return LBRACE; }
"<"     { return LTHAN; }
">"     { return GTHAN; }
"@*"    { return LCOM; }
"*@"    { return RCOM; }
"?>"    { return SCOM; }
let     { return LET; }
num     { return NUM; }
dec     { return DEC; }
letter  { return LETTER; }
loop    { return LOOP; }
how     { return HOW; }
go      { return GO; }
what    { return WHAT; }
then    { return THEN; }
segment { return SEGMENT; }
start   { return START; }
end     { return END; }
begin   { return BEGIN; }
stop    { return STOP; }
void    { return VOID; }
un      { return un; }
{ID}({ID}|{DIGIT})*  { return IDENT; }
[ \t\n]     /* white space */
.   printf("Unrecognized character %s\n", yytext);

int main(int argc, char *argv[]) {
    yyin = fopen(argv[1], "r");
    yylex();
    fclose(yyin);
}
