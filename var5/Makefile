LEX = flex -I
BISON = bison -d
LFLAGS = -lfl -lm
BFLAGS = -ly
OFLAGS = -fPIC -shared

adder: level.tab.o lex.yy.o
	$(CC) -o adder level.tab.o lex.yy.o $(LFLAGS) 

lex.yy.o:	lex.yy.c level.tab.h

lex.yy.o level.tab.o: sym.h

level.tab.c lexer.tab.h: level.y
	$(BISON) level.y

lex.yy.c level.tab.h: lexer.lex
	$(LEX) lexer.lex

clear:
	rm -rf level.tab.h level.tab.o level.tab.c lex.yy.c lex.yy.o