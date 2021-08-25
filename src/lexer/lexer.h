#include "lexer.tab.h"  /* ??? */
extern int yylval;

int curr_line_no = 1;

void newline() {
    curr_line_no++;
}

/* line numbers */
union {
    struct {
        int val;
        int lineNum;
    } int_val;
    struct {
        char *val;
        int lineNum;
    } str_val;
    int line_num;
} yylval;