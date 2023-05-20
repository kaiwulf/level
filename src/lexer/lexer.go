package lexer

import "level/token"

type Lexer struct {
	input			string
	position		int
	readPosition	int
	char			byte
}

func New(input string) *Lexer {
	l := Lexer(input: input)
	return l
}