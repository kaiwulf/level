package lexer

// import "level/token"

type Lexer struct {
	input			string
	position		int
	readPosition	int
	char			byte
}

func New(input string) *Lexer {
	l := &Lexer{input: input}
	l.readChar()
	return l
}

func (L *Lexer) readChar() {
	if l.readPosition >= len(l.input) {
		l.ch = 0
	} else {
		l.ch = l.input[l.readPosition]
	}
	l.position = l.readPosition
	l.readPosition += 1
}

func (l *Lexer) NextToken token.Token {
	var tok token.Token

	switch l.ch {
		
	}
}