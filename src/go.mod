module level

go 1.21.6

replace level/lexer => ./lexer

require (
	level/lexer v0.0.0-00010101000000-000000000000
	level/token v0.0.0-00010101000000-000000000000
)

replace level/token => ./token
