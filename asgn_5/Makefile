a.out: y.tab.o lex.yy.o ass5_16CS30005_translator.o
	g++ -g ass5_16CS30005_translator.o lex.yy.o y.tab.o -lfl

lex.yy.c: ass5_16CS30005.l
	flex ass5_16CS30005.l

y.tab.c: ass5_16CS30005.y
	yacc -dtv ass5_16CS30005.y

ass5_16CS30005_translator.o: ass5_16CS30005_translator.cxx
	g++ -g -c ass5_16CS30005_translator.cxx

lex.yy.o: lex.yy.c
	g++ -g -c lex.yy.c

y.tab.o: y.tab.c
	g++ -g -DYYDEBUG -c y.tab.c

clean:
	rm lex.yy.c y.tab.h y.output y.tab.c lex.yy.o y.tab.o ass5_16CS30005_translator.o a.out
run:
	./a.out < ass5_16CS30005_test1.c > ass5_16CS30005_quad1.out
	./a.out < ass5_16CS30005_test2.c > ass5_16CS30005_quad2.out
	./a.out < ass5_16CS30005_test3.c > ass5_16CS30005_quad3.out
	./a.out < ass5_16CS30005_test4.c > ass5_16CS30005_quad4.out
	./a.out < ass5_16CS30005_test5.c > ass5_16CS30005_quad5.out
