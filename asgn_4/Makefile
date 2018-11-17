a.out: lex.yy.o y.tab.o asgn4_16CS30005_main.o
	gcc lex.yy.o y.tab.o asgn4_16CS30005_main.o -lfl

asgn4_16CS30005_main.o: asgn4_16CS30005_main.c
	gcc -c asgn4_16CS30005_main.c

lex.yy.o: lex.yy.c
	gcc -c lex.yy.c -lfl

y.tab.o: y.tab.c
	gcc -c y.tab.c

lex.yy.c: asgn4_16CS30005.l y.tab.h
	flex asgn4_16CS30005.l

y.tab.c: asgn4_16CS30005.y
	yacc -dtv asgn4_16CS30005.y -W

y.tab.h: asgn4_16CS30005.y
	yacc -dtv asgn4_16CS30005.y -W

clean:
	rm lex.yy.c y.tab.c y.tab.h lex.yy.o y.tab.o asgn4_16CS30005_main.o y.output a.out asgn4_16CS30005_test_output

test: 
	./a.out < asgn4_16CS30005_test.c 2> asgn4_16CS30005_test_output
