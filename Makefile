CC=			gcc
CFLAGS=		-g -Wall -Wc++-compat -std=c99 -O2
CPPFLAGS=
INCLUDES=
OBJS=
PROG=		sdust
LIBS=		-lz

ifneq ($(asan),)
	CFLAGS+=-fsanitize=address
	LIBS+=-fsanitize=address
endif

.SUFFIXES:.c .o
.PHONY:all clean depend

.c.o:
		$(CC) -c $(CFLAGS) $(CPPFLAGS) $(INCLUDES) $< -o $@

all:$(PROG)

sdust:sdust.o
		$(CC) $(CFLAGS) $^ -o $@ $(LIBS)

clean:
		rm -fr gmon.out *.o a.out $(PROG) *~ *.a *.dSYM

depend:
		(LC_ALL=C; export LC_ALL; makedepend -Y -- $(CFLAGS) $(DFLAGS) -- *.c)

install:
		cp $(PROG) ~/my-apps/sdust/filter

# DO NOT DELETE

sdust.o: kdq.h kalloc.h kvec.h sdust.h ketopt.h kseq.h
