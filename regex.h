#include <stdio.h>
#include <ctype.h>

int in_char , c;

typedef enum token_types {
    BEGIN, END, READ, WRITE, ID, INTLITERAL, LPAREN, RPAREN, SEMICOLON,
    COMMA, ASSIGNOP, PLUSOP, MINUSOP, SCANEOF
} token;

extern token scanner();

void primary();
void add_op();
void expr_list();
void expression();
void id_list();
void statement();
void statement_list();
void program();
void system_goal();
