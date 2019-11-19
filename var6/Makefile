LEX		= flex -I
BISON	= bison -d
CC		= gcc
OBJS	= level.tab.o lex.yy.o
BFLAGS	= -g -c
LFLAGS	= -lfl -lm
OFLAGS	= -fPIC -shared -g

level:	        $(OBJS)
	$(CC) -o level level.tab.o lex.yy.o $(LFLAGS)

bison:		level.y
	$(BISON) level.y

flex:		level.l
	$(LEX) level.l

lex.yy.o:	lex.yy.c level.tab.h
	$(CC) $(LFLAGS) $(OFLAGS) -c lex.yy.c -o lex.yy.o

yacc.yy.o: level.tab.c sym.h
	$(CC) $(BFLAGS) level.tab.c -o yacc.yy.o

level.tab.c level.tab.h: level.y
	$(BISON) level.y

lex.yy.c lexer.tab.h: level.l
	$(LEX) level.l

lex.yy.o yacc,yy.o:		sym.h

clear:
	rm -rf level.tab.h level.tab.o yacc.tab.o level.tab.c lex.yy.c lex.yy.o level
