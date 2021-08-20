#include "lexer.tab.h"  /* ??? */
extern int yylval;


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