package token

type TokenType string

type Token struct {
	Type TokenType
	Literal string
}

const (
	ERR			= "ERR"
	EOF			= "EOF"

	IDENT		= "IDENT"
	INT			= "NUM"

	/* operators */
	ASSIGN		= "^*"
	PLUS		= "++"

	/* delimiters */
	COMMA		= ","
	SEMICOLON	= ";"

	DOUBLECOL	= "::"
	ENDCOL		= ":;"
	LSQUARE		= "["
	RSQUARE		= "]"
	LBRACE		= "{"
	RBRACE		= "}"
	LPAREN		= "("
	RPAREN		= ")"
	LTBRACE		= '<'
	GTBRACE		= '>'

	FUNCTION	= "segment"
	LET			= "let"
)