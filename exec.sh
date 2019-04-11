#!/bin/zsh

flex level.lex
gcc lex.yy.c -lfl -o yylevel
./yylevel sam.lvl
