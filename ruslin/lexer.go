package main

import (
	"fmt"
)

type interpreter struct {
	var current_token string
	var current_char string
	var text string
	var pos int
}

type Token struct {
	var desc string
	var typie string
	var val int
}

func (inter interpreter) error() {

}

func (inter interpreter) step() {

}

func (inter interpreter) expr() {

}

func (inter interpreter) get_next_token() {

}

func (token Token) def_token_type {
	desc = fmt.Sprintf("Token{%s}{%d}", token.typie, token.val)
}

func repl_print() {
	fmt.Print("lex-repl> ")
}

func main() {
	commands := map[string]interface {
		"help": help,
		"cls": cls
	}

	reader := bufio.NewReader(os.StdIn)

	

}