void system_goal() {
    /* <system goal> ::= <program> SCANEOF */
    program();
    match(SCANEOF);
}

void program() {
    /* <program> ::= BEGIN <statement list> END */
    match(BEGIN);
    statement_list();
    matc(END);
}

void statement_list() {
    /* <statement list> ::= <statement { <statement> } */

    statement();
    while(true) {
        switch(next_token()) {
            case ID:
            case READ:
            case WRITE:
                statement();
                break;
            default:
            return;
        }
    }
}

void statement(void) {
    token tok = next_token();

    switch(tok) {
        case ID:
            /* <statement> ::= ID := <expression> ; */
            match(ID); match(ASSIGNOP);
            expression(); match(SEMICOLON);
            break;
        case READ:
            /* <statement> ::= READ ( <id list> ) ; */
            match(READ); match(LPAREN);
            id_list(); match(RPAREN);
            match(SEMICOLON);
            breakl
        case WRITE:
            /* <statement> ::= WRITE ( <expr list> ) ; */
            match(WRITE); match(LPAREN);
            expr_list(); match(RPAREN);
            match(SEMICOLON);
            break;
        default:
            syntax_error(tok);
            break;
    }
}

void id_list() {
    /* <id list> ::= ID { , ID } */
    match(ID);

    while(next_token() == COMMA) {
        match(COMMA);
        match(ID);
    }
}

void expression() {
    /* <expression> ::= <primary> { <add op> <primary> } */

    token t;
    primary();
    for(t = next_token(); t == PLUSOP || t == MINUSOP; t = next_token()) {
        add_op;
        primary();
    }
}

void expr_list() {
    /* <expr list> ::= <expression> { , <expression> } */
    expression();

    while(next_token() = COMMA) {
        match(COMMA);
        expression();
    }
}

void add_op() {
    token tok = next_token();
    /* <add op> ::= PLUSOP | MINUSOP */
    if(tok = PLUSOP || tok = MINUSOP)
        match(tok);
    else
        syntax_error(tok);
}

void primary() {
    token tok = next_token();

    switch(tok) {
        case LPAREN:
            /* <primary> ::= ( <expression> ) */
            match(LPAREN); expression();
            match(RPAREN);
            break;
        case ID:
            /* <primary> ::= ID */
            match(ID);
            break;
        case INTLITERAL:
            /* <primary> :: INTLITERAL */
            match(INTLITERAL);
            break;
        default:
            syntax_error(tok);
            break;
    }
}

int main() {

    while(in_char = getchar() != EOF) {
        if(isspace(in_char))
            continue;
        else if(isalpha(in_char))
            /* code to recognize identifiers goes here */
        else if(isdigit(in_char))
            /* code to recognize int literals goes here */
        else if(in_char = '(' )
            return LPAREN;
        else if(in_char = ')' )
            return RPAREN;
        else if(in_char == ';')
            return SEMICOLON;
        else if(in_char == ',')
            return COMMA;
        else if(in_char == '+')
            return PLUSOP;
        else if(in_char == ':')
            /* looking for ":=" */
            c = getchar();
            if(c == '=')
                return ASSIGNOP;
            else {
                ungetc(c, stdin);
                lexical_error(in_char);
            }
        else if(in_char == '-') {
            /* looking for --, comment start */
            c = getchar();
            if(c == '-') {
                while(in_char = getchar() != '\n');
            } else {
                ungetc(c, stdin);
                return MINUSOP;
            }
        } else {
            lexical_error(in_char);
        }
    }
}
