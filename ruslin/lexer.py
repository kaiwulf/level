# Token types
#
# EOF (end-of-file) token is used to indicate that
# there is no more input left for lexical analysis
INT, PLUS, MINUS, DIV, MULT, MOD, EXP, SPACE, EOF = 'INTEGER', 'PLUS', 'MINUS', 'DIV', 'MULT', 'MOD', 'EXP', 'SPACE', 'EOF'


class Token(object):
    def __init__(self, type, value):
        # token type: INTEGER, PLUS, MINUS, SPACE or EOF
        self.type = type
        # token value: 0, 1, 2. 3, 4, 5, 6, 7, 8, 9, '+', '-', ' ', or None
        self.value = value
        # 

    def __str__(self):
        """String representation of the class instance.

        Examples:
            Token(INTEGER, 3)
            Token(PLUS '+')
            Token(MINUS, '-')
        """
        return 'Token({type}, {value})'.format(
            type=self.type,
            value=repr(self.value)
        )

    def __repr__(self):
        return self.__str__()


class Interpreter(object):
    def __init__(self, text):
        # client string input, e.g. "3+5"
        self.text = text
        # self.pos is an index into self.text
        self.pos = 0
        # current token instance
        self.current_token = None
        self.current_char = self.text[self.pos]

    def error(self):
        raise Exception('Error parsing input')

    def term(self):
        token = self.current_token
        self.eat(INT)
        return token.value
    
    def advance(self):
        self.pos += 1
        if self.pos > len(self.text) - 1:
            self.current_char = None
        else:
            self.current_char = self.text[self.pos]

    def whitespace(self):
        while self.current_char is not None and self.current_char.isspace():
            self.advance()
    
    def is_int(self):
        result = ''
        while self.current_char is not None and self.current_char.isdigit():
            result += self.current_char
            self.advance()
        return int(result)

    def get_next_token(self):
        """Lexical analyzer (also known as scanner or tokenizer)

        This method is responsible for breaking a sentence
        apart into tokens. One token at a time.
        """
        
        while self.current_char is not None:
        
            if self.current_char.isspace():
                    self.whitespace()
                    continue

            if self.current_char.isdigit():
                return Token(INT, self.is_int())

            if self.current_char == '+':
                self.advance()
                return Token(PLUS, '+')

            if self.current_char == '-':
                self.advance()
                return Token(MINUS, '-')
            
            if self.current_char == '*':
                self.advance()
                return Token(MULT, '*')
            
            if self.current_char == '/':
                self.advance()
                return Token(DIV, '/')
            
            if self.current_char == '%':
                self.advance()
                return Token(MOD, '%')

            if self.current_char == '^':
                self.advance()
                return Token(EXP, '^')

            self.error()
        
        return Token(EOF, None)

    def eat(self, token_type):
        # compare the current token type with the passed token
        # type and if they match then "eat" the current token
        # and assign the next token to the self.current_token,
        # otherwise raise an exception.
        if self.current_token.type == token_type:
            self.current_token = self.get_next_token()
        else:
            self.error()

    def expr(self):
        self.current_token = self.get_next_token()

        result = self.term()
        while self.current_token.type != EOF:
            if self.current_token.type == PLUS:
                self.eat(PLUS)
                result += self.term()
            elif self.current_token.type == MINUS:
                self.eat(MINUS)
                result -= self.term()
            elif self.current_token.type == DIV:
                self.eat(DIV)
                result /= self.term()
            elif self.current_token.type == MULT:
                self.eat(MULT)
                result *= self.term()
            elif self.current_token.type == MOD:
                self.eat(MOD)
                result %= self.term()
            elif self.current_token.type == EXP:
                self.eat(EXP)
                result **= self.term()

        return result


def main():
    while True:
        try:
            # To run under Python3 replace 'raw_input' call
            # with 'input'
            text = input('calc> ')
        except EOFError:
            break
        if not text:
            continue
        interpreter = Interpreter(text)
        result = interpreter.expr()
        print(result)


if __name__ == '__main__':
    main()