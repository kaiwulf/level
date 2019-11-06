gcc    -c -o level.tab.o level.tab.c -g
gcc -o level level.tab.o lex.yy.o -lfl -lm
