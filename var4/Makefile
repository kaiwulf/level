$LEX = flex -I
$BISON = bison -d

adder: level.tab.o lex.yy.o
	$(CC) -o adder level.tab.o lex.yy.o -ly -lfl -lm

lex.yy.o:	lex.yy.c "level.tab.h"

lex.yy.o level.tab.o: sym.h

level.tab.c "level.tab.h": level.y
	$(BISON) level.y

lex.yy.c: level.lex
	$(LEX) level.lex