a.out: ass2_16CS30005_main.o libass2_16CS30005.a
	gcc ass2_16CS30005_main.o -L. -lass2_16CS30005

main.o: ass2_16CS30005_main.c myl.h
	gcc -Wall -c ass2_16CS30005_main.c

libass2_16CS30005.a: ass2_16CS30005.o
	ar -rcs libass2_16CS30005.a ass2_16CS30005.o

ass2_16CS30005.o: ass2_16CS30005.c myl.h
	gcc -Wall -c ass2_16CS30005.c

clean:
	rm a.out ass2_16CS30005_main.o libass2_16CS30005.a ass2_16CS30005.o
