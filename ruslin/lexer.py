# Token types
#
# EOF (end-of-file) token is used to indicate that
# there is no more input left for lexical analysis
INT, PLUS, MINUS, DIV, MULT, MOD, SPACE, EOF = 'INTEGER', 'PLUS', 'MINUS', 'DIV', 'MULT', 'MOD', 'SPACE', 'EOF'


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
    
    def isop(self, current_char):
        if current_char == '-' or current_char == '+' or current_char == '*' or current_char == '/' or current_char == '%':
            return True;

    def error(self):
        raise Exception('Error parsing input')

    def get_next_token(self):
        """Lexical analyzer (also known as scanner or tokenizer)

        This method is responsible for breaking a sentence
        apart into tokens. One token at a time.
        """
        text = self.text

        # is self.pos index past the end of the self.text ?
        # if so, then return EOF token because there is no more
        # input left to convert into tokens
        if self.pos > len(text) - 1:
            return Token(EOF, None)

        # get a character at the position self.pos and decide
        # what token to create based on the single character
        current_char = text[self.pos]

        if current_char == ' ':
                self.pos += 1
                return Token(SPACE, ' ')

        # if the character is a digit then convert it to
        # integer, create an INTEGER token, increment self.pos
        # index to point to the next character after the digit,
        # and return the INTEGER token
        if current_char.isdigit():
            token = Token(INT, int(current_char))
            self.pos += 1
            return token

        if self.isop(current_char):
            if current_char == '+':
                token = Token(PLUS, current_char)
                self.pos += 1
                return token
            elif current_char == '-':
                token = Token(MINUS, current_char)
                self.pos += 1
                return token
            elif current_char == '*':
                token = Token(MULT, current_char)
                self.pos += 1
                return token
            elif current_char == '/':
                token = Token(DIV, current_char)
                self.pos += 1
                return token
            elif current_char == '%':
                token = Token(MOD, current_char)
                self.pos += 1
                return token

        self.error()

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
        """expr -> INTEGER PLUS INTEGER"""
        # set current token to the first token taken from the input
        print(self.text)
        self.current_token = self.get_next_token()

        if self.current_token.type == SPACE:
            while self.current_token.type == SPACE:
                self.eat(SPACE)

        if self.current_token.type == INT:
                left = self.current_token
                print("left: ", left)
                self.eat(INT)

        while self.current_token.type != EOF:
            if self.current_token.type == SPACE:
                self.eat(SPACE)
            elif self.current_token.type == PLUS:
                op = '+'
                self.eat(PLUS)
                continue
            elif self.current_token.type == MINUS:
                op = '-'
                self.eat(MINUS)
                continue
            elif self.current_token.type == DIV:
                op = '/'
                self.eat(DIV)
                continue
            elif self.current_token.type == MULT:
                op = '*'
                self.eat(MULT)
                continue
            elif self.current_token.type == MOD:
                op = '%'
                self.eat(MOD)
                continue
            if self.current_token.type == INT:
                right = self.current_token
                self.eat(INT)
                continue

        if self.current_token.type == SPACE:
            while self.current_token.type == SPACE:
                self.eat(SPACE)

        if op == '+':
            result = left.value + right.value
        if op == '-':
            result = left.value - right.value
        if op == '/':
            result = left.value / right.value
        if op == '*':
            result = left.value * right.value
        if op == '%':
            result = left.value % right.value

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