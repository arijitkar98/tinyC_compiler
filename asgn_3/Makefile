a.out: lex.yy.o
		gcc lex.yy.o -lfl

lex.yy.o: lex.yy.c
		gcc -c lex.yy.c -lfl

lex.yy.c: ass3_16CS30005.l ass3_16CS30005.c
		flex ass3_16CS30005.l ass3_16CS30005.c

clean:
		rm -f a.out lex.yy.c lex.yy.o
