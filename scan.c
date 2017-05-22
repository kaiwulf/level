#include <level.h>

int scanner(char *in) {

    FILE *fp;
    char *fpname[200];

    if(fgets(fpname, sizeof(fpname), stdin) == NULL) {
        scan_errf(fpname_err);
    }

    fp = fopen(fpname, "r");

    while((in_char = fgetc(fp)) != EOF) {
        if(in_char == ' ')
            continue;
        else if(isalpha(in_char) || in_char == '`' || in_char == '_') {
            /* code to recognize identifiers goes here */
            return var_ident(fp);
        } else if(isdigit(in_char) || ) {
            /* code to recognize int literals goes here */
            return digit_ident(fp);
        } else if(in_char = '(' )
            return LPAREN;
        else if(in_char = ')' )
            return RPAREN;
        else if(in_char == ':') {
            /* looping for :: or :; */
            c = getchar();
            if(c == ':')
                return BEGINBLOCK;
            else if(c == ';')
                return ENDBLOCK;
        } else if(in_char == ',')
            return COMMA;
        else if(in_char == '.')
            return PERIOD;
        else if(in_char == '+') {
            c = getchar();
            if(c == '+')
                return PLUSOP;
            else {
                lexical_error(in_char);
                unget(c, stdin);
            }
        } else if(in_char == '-') {
            c = getchar();
            if(c == '-')
                return MINUSOP;
            else {
                lexical_error(in_char);
                unget(c, stdin);
            }
        } else if(in_char == '?') {
            /* looking for ?>, comment start */
            c = getchar();
            if(c == '>') {
                while(in_char = getchar() != '\n');
            } else {
                return NOT;
            }
        } else if(in_char == '@') {
            /* looking for @* comment */
            c = getchar();
            if(c == '*') {
                while( in_char = getchar()) {
                    /* Loop through until finding *@ */
                    if( in_char == '*') {
                        if( in_char = getchar() == '@') {
                            break;
                        }
                    } else {
                        continue;       // Create detection for EOF error
                    }
                }
            }
        } else if(in_char == '$')
            return DIVOP;
        else if(in_char == '&')
            return LAND;
        else if(in_char == '|')
            return LOR;
        else if(in_char == '!')
            return LXOR;
        else if(in_char == '#')
            return NOT;
        else if(in_char == '*')
            return MULTOP;
        else if(in_char == '%')
            return MODOP;
        else if(in_char == '/')
            return GTOP;
        else if(in_char == '\\')
            return LTOP;
        else if(in_char == '^')
            return EXPOOP;
        else if(in_char == '~')
            return POINTEROP;
        else if(in_char == '=') {
            /* looking for ==, equals */
            c = getchar();
            if(in_char == '=')
                return EQUAL;
            else {
                lexical_error(in_char);
                unget(c, stdin);
            }
        } else if(in_char == '#')
            return LEQOP;
        else {
            lexical_error(in_char);
        }
    }
}

void lexical_error(char c) {
    fprintf(stderr, "Identifier %c not recognized\n", c);
}
