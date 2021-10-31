
SRCDIR = ../libmpdec

CC = gcc
LD = gcc
AR = ar

LIBSTATIC = libmpdec.a
LIBSHARED = libmpdec.so.2.4.2

MPD_WARN = -Wall -W -Wno-unknown-pragmas -std=c99 -pedantic
MPD_CONFIG = -DCONFIG_64 -DASM

CONFIGURE_CFLAGS = -Wall -W -Wno-unknown-pragmas -std=c99 -pedantic -DCONFIG_64 -DASM -O2 -Wl,-rpath,/home/cc/ee147/fl21/class/ee147-aaf/software/python/1/lib:/home/cc/ee147/fl21/class/ee147-aaf/software/python/1/lib64 -I/home/cc/ee147/fl21/class/ee147-aaf/software/python/1/include
CFLAGS ?= $(CONFIGURE_CFLAGS)


default: runtest runtest_shared runtest_alloc runtest_alloc_shared


# Short test.
runtest:\
Makefile runtest.c $(SRCDIR)/io.h $(SRCDIR)/mpdecimal.h $(SRCDIR)/memory.h \
malloc_fail.c malloc_fail.h mptest.h $(SRCDIR)/$(LIBSTATIC)
	$(CC) -I$(SRCDIR) $(CFLAGS) -o runtest runtest.c malloc_fail.c $(SRCDIR)/libmpdec.a -lm

runtest_shared:\
Makefile runtest.c $(SRCDIR)/io.h $(SRCDIR)/mpdecimal.h $(SRCDIR)/memory.h \
malloc_fail.c malloc_fail.h mptest.h $(SRCDIR)/$(LIBSHARED)
	$(CC) -I$(SRCDIR) -L$(SRCDIR) $(CFLAGS) -o runtest_shared runtest.c malloc_fail.c -lmpdec -lm

# Also test all allocation failures.
runtest_alloc:\
Makefile runtest.c $(SRCDIR)/io.h $(SRCDIR)/mpdecimal.h $(SRCDIR)/memory.h \
malloc_fail.c malloc_fail.h mptest.h $(SRCDIR)/$(LIBSTATIC)
	$(CC) -I$(SRCDIR) $(CFLAGS) -DTEST_ALLOC -o runtest_alloc runtest.c malloc_fail.c $(SRCDIR)/libmpdec.a -lm

runtest_alloc_shared:\
Makefile runtest.c $(SRCDIR)/io.h $(SRCDIR)/mpdecimal.h $(SRCDIR)/memory.h \
malloc_fail.c malloc_fail.h mptest.h $(SRCDIR)/$(LIBSHARED)
	$(CC) -I$(SRCDIR) -L$(SRCDIR) $(CFLAGS) -DTEST_ALLOC -o runtest_alloc_shared runtest.c malloc_fail.c -lmpdec -lm


FORCE:

clean: FORCE
	rm -f *.o *.gch *.gcda *.gcno *.gcov *.dyn *.dpi *.lock
	rm -f runtest runtest_shared runtest_alloc runtest_alloc_shared

distclean: FORCE
	$(MAKE) clean
	rm -rf Makefile dectest.zip testdata


