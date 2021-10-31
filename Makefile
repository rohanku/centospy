# source: python-forum.io/thread-18656.html
# Initialize env vars
ifeq ($(strip $(PREFIX)),)
PREFIX=/home/cc/ee147/fl21/class/ee147-aaf/software/python/$(revision)
endif
LDFLAGS=-Wl,-rpath,$(PREFIX)/lib:$(PREFIX)/lib64 -L$(PREFIX)/lib:$(PREFIX)/lib64
CFLAGS=-Wl,-rpath,$(PREFIX)/lib:$(PREFIX)/lib64 -I$(PREFIX)/include
CPPFLAGS=$(CFLAGS)
LD_RUN_PATH=$(PREFIX)/lib:$(PREFIX)/lib64
LD_LIBRARY_PATH=$(PREFIX)/lib:$(PREFIX)/lib64
 
export LDFLAGS CFLAGS CPPFLAGS PREFIX
 
# Software Package Versions
revision=1
expat=2.2.6
ffi=3.2.1
mpdec=2.4.2
ncurses=6.1
openssl=1.0.2r
python3=3.7.3
readline=8.0
sqlite3=3.28.0
zlib=1.2.11
 
#Global vars
PYTHON_LIBS=-ltinfo -lncurses
 
#Software Sources
expatsource=https://github.com/libexpat/libexpat/releases/download/R_$(subst .,_,$(expat))/$(expatfile)
ffisource=ftp://sourceware.org/pub/libffi/$(ffifile)
mpdecsource=https://www.bytereef.org/software/mpdecimal/releases/$(mpdecfile)
ncursessource=ftp://ftp.gnu.org/gnu/ncurses/$(ncursesfile)
opensslsource=https://www.openssl.org/source/$(opensslfile)
python3source=https://www.python.org/ftp/python/$(python3)/$(python3file)
readlinesource=ftp://ftp.gnu.org/gnu/readline/$(readlinefile)
sqlite3source=https://www.sqlite.org/2019/$(sqlite3file)
zlibsource=https://zlib.net/$(zlibfile)
 
# Derived global vars
expatfile=expat-$(expat).tar.bz2
ffifile=libffi-$(ffi).tar.gz
mpdecfile=mpdecimal-$(mpdec).tar.gz
ncursesfile=ncurses-$(ncurses).tar.gz
opensslfile=openssl-$(openssl).tar.gz
readlinefile=readline-$(readline).tar.gz
sqlite3file=sqlite-autoconf-$(shell printf '%d%02d%02d%02d' $(subst ., ,$(sqlite3))).tar.gz
python3file=Python-$(python3).tgz
zlibfile=zlib-$(zlib).tar.gz
 
expatdir=$(basename $(basename $(expatfile)))
ffidir=$(basename $(basename $(ffifile)))
mpdecdir=$(basename $(basename $(mpdecfile)))
ncursesdir=$(basename $(basename $(ncursesfile)))
openssldir=$(basename $(basename $(opensslfile)))
readlinedir=$(basename $(basename $(readlinefile)))
sqlite3dir=$(basename $(basename $(sqlite3file)))
python3dir=$(basename $(python3file))
zlibdir=$(basename $(basename $(zlibfile)))
 
cleanexpat=$(wildcard $(expatdir)/.)
cleanffi=$(wildcard $(ffidir)/.)
cleanmpdec=$(wildcard $(mpdecdir)/.)
cleanncurses=$(wildcard $(ncursesdir)/.)
cleanopenssl=$(wildcard $(openssldir)/.)
cleanreadline=$(wildcard $(readlinedir)/.)
cleansqlite3=$(wildcard $(sqlite3dir)/.)
cleanpython3=$(wildcard $(python3dir)/.)
cleanzlib=$(wildcard $(zlibdir)/.)
 
help:
		echo "makefile for Python $(python3) and dependancies."
		echo "Will build artifacts and install them to PREFIX=$(PREFIX)"
		echo "If PREFIX is set as an environment variable this makefile will use it."
		echo
		echo "Any source code needed will be retrieved."
		echo "Any target will automatically build and install dependancies."
		echo "Note: OpenSSL is compiled without compression support for additional security"
		echo
		printf "%-8s %-7s %s\n" "TARGET" "VERSION" "DEPENDENCIES"
		printf "%-8s %-7s %s\n" "expat" "$(expat)" "none"
		printf "%-8s %-7s %s\n" "ffi" "$(ffi)" "none"
		printf "%-8s %-7s %s\n" "mpdec" "$(mpdec)" "none"
		printf "%-8s %-7s %s\n" "ncurses" "$(ncurses)" "none"
		printf "%-8s %-7s %s\n" "openssl" "$(openssl)" "none"
		printf "%-8s %-7s %s\n" "python3" "$(python3)" "expat ffi mpdec openssl sqlite3"
		printf "%-8s %-7s %s\n" "readline" "$(readline)" "ncurses"
		printf "%-8s %-7s %s\n" "sqlite3" "$(sqlite3)" "readline zlib"
		printf "%-8s %-7s %s\n" "zlib" "$(zlib)" "none"
		echo
		echo "Special build targets:"
		echo "all   - Synonym for python3"
		echo "help  - Displays this message"
		echo "clean - Removes temp directories"
		echo
		echo "Set VERBOSE to any non-null value to see debug messages"
 
$(VERBOSE).SILENT:
 
.PHONY: \
		help \
		expat \
		ffi \
		mpdec \
		ncurses \
		openssl \
		python3 \
		readline \
		sqlite3 \
		zlib \
		$(cleanexpat) \
		$(cleanffi) \
		$(cleanmpdec) \
		$(cleanncurses) \
		$(cleanopenssl) \
		$(cleanpython3) \
		$(cleanreadline) \
		$(cleansqlite3) \
		$(cleanzlib)
 
all: python3
 
expat:
		echo "INFO: CFLAGS=$(CFLAGS)"
		echo "INFO: CPPFLAGS=$(CPPFLAGS)"
		echo "INFO: PREFIX=$(PREFIX)"
		echo "INFO: expatfile=$(expatfile)"
		echo "INFO: expatsource=$(expatsource)"
		# test -f "$(expatfile)" \
		# 		&& echo "INFO: Found $(expatfile)" \
		# 		|| (echo "INFO: Retrieving $(expatsource)"; curl -Lso "$(expatfile)" "$(expatsource)")
		# tar -xf "$(expatfile)"
		cd "$(expatdir)" && \
		./configure \
				--prefix="$(PREFIX)" \
				--enable-shared \
				--enable-static \
				--without-docbook && \
		make && \
		make install
		echo "expat $(expat)" >> $(PREFIX)/version
 
ffi:
		echo "INFO: CFLAGS=$(CFLAGS)"
		echo "INFO: CPPFLAGS=$(CPPFLAGS)"
		echo "INFO: PREFIX=$(PREFIX)"
		echo "INFO: ffifile=$(ffifile)"
		echo "INFO: ffisource=$(ffisource)"
		# test -f "$(ffifile)" \
		# 		&& echo "INFO: Found $(ffifile)" \
		# 		|| (echo "INFO: Retrieving $(ffisource)"; curl -Lso "$(ffifile)" "$(ffisource)")
		# tar -xf "$(ffifile)"
		cd "$(ffidir)" && \
		./configure \
				--prefix="$(PREFIX)" \
				--enable-shared
		make && \
		make install
		echo "ffi $(ffi)" >> $(PREFIX)/version
 
mpdec:
		echo "INFO: CFLAGS=$(CFLAGS)"
		echo "INFO: CPPFLAGS=$(CPPFLAGS)"
		echo "INFO: PREFIX=$(PREFIX)"
		echo "INFO: mpdecfile=$(mpdecfile)"
		echo "INFO: mpdecsource=$(mpdecsource)"
		# test -f "$(mpdecfile)" \
		# 		&& echo "INFO: Found $(mpdecfile)" \
		# 		|| (echo "INFO: Retrieving $(mpdecsource)"; curl -Lso "$(mpdecfile)" "$(mpdecsource)")
		# tar -xf "$(mpdecfile)"
		cd "$(mpdecdir)" && \
		./configure \
				--prefix="$(PREFIX)" && \
		make && \
		make install
		echo "mpdec $(mpdec)" >> $(PREFIX)/version
 
ncurses:
		echo "INFO: CFLAGS=$(CFLAGS)"
		echo "INFO: CPPFLAGS=$(CPPFLAGS)"
		echo "INFO: PREFIX=$(PREFIX)"
		echo "INFO: ncursesfile=$(ncursesfile)"
		echo "INFO: ncursessource=$(ncursessource)"
		# test -f "$(ncursesfile)" \
		# 		&& echo "INFO: Found $(ncursesfile)" \
		# 		|| (echo "INFO: Retrieving $(ncursessource)"; curl -Lso "$(ncursesfile)" "$(ncursessource)")
		# tar -xf "$(ncursesfile)"
		cd "$(ncursesdir)" && \
		./configure \
				--prefix="$(PREFIX)" \
				--with-cxx-shared \
				--with-profile \
				--with-pthread \
				--with-shared \
				--with-termlib \
				--enable-broken_linker \
				--enable-ext-colors \
				--enable-ext-mouse \
				--enable-ext-putwin \
				--enable-hard-tabs \
				--enable-no-padding \
				--enable-opaque-curses \
				--enable-opaque-form \
				--enable-opaque-menu \
				--enable-opaque-panel \
				--enable-pthreads-eintr \
				--enable-reentrant \
				--enable-rpath \
				--enable-signed-char \
				--enable-sigwinch \
				--enable-symlinks \
				--enable-tcap-names \
				--enable-termcap \
				--enable-weak-symbols \
				--enable-widec \
				--enable-xmc-glitch && \
		make && \
		make install
		echo "ncurses $(ncurses)" >> $(PREFIX)/version
 
openssl:
		echo "INFO: CFLAGS=$(CFLAGS)"
		echo "INFO: CPPFLAGS=$(CPPFLAGS)"
		echo "INFO: PREFIX=$(PREFIX)"
		echo "INFO: opensslfile=$(opensslfile)"
		echo "INFO: opensslsource=$(opensslsource)"
		# test -f "$(opensslfile)" \
		# 		&& echo "INFO: Found $(opensslfile)" \
		# 		|| (echo "INFO: Retrieving $(opensslsource)"; curl -Lso "$(opensslfile)" "$(opensslsource)")
		# tar -xf "$(opensslfile)"
		cd "$(openssldir)" && \
		./config \
				--prefix="$(PREFIX)" \
				--openssldir="$(PREFIX)" \
				threads \
				shared \
				no-comp \
				"$(CFLAGS)" && \
		make depend && \
		make && \
		make install
		echo "OpenSSL $(openssl)" >> $(PREFIX)/version
 
python3:
		echo "INFO: CFLAGS=$(CFLAGS)"
		echo "INFO: CPPFLAGS=$(CPPFLAGS)"
		echo "INFO: PREFIX=$(PREFIX)"
		echo "INFO: python3file=$(python3file)"
		echo "INFO: python3source=$(python3source)"
		# test -f "$(python3file)" \
		# 		&& echo "INFO: Found $(python3file)" \
		# 		|| (echo "INFO: Retreiving $(python3source)"; curl -Lso "$(python3file)" "$(python3source)")
		# tar -xf "$(python3file)"
		cd "$(python3dir)" && \
		./configure \
				--prefix="$(PREFIX)" \
				--enable-shared \
				--enable-optimizations \
				--enable-profiling \
				--enable-loadable-sqlite-extensions \
				--enable-ipv6 \
				--with-system-expat=$(PREFIX) \
				--with-system-ffi=$(PREFIX) \
				--with-system-libmpdec=$(PREFIX) \
				--with-openssl=$(PREFIX) \
				--with-ensurepip=upgrade \
				"CFLAGS=$(CFLAGS) $(PYTHON_LIBS)" \
				"CPPFLAGS=$(CPPFLAGS) $(PYTHON_LIBS)" \
				"LDFLAGS=$(LDFLAGS) $(PYTHON_LIBS)" && \
		make \
				"CFLAGS=$(CFLAGS) $(PYTHON_LIBS)" \
				"CPPFLAGS=$(CPPFLAGS) $(PYTHON_LIBS)" \
				"LDFLAGS=$(LDFLAGS) $(PYTHON_LIBS)" && \
		make install
		echo -n "INFO: Testing if Python runs: "
		$(PREFIX)/bin/python3 --version
		[[ -x find_deps.sh ]] && echo "Testing binary dependancies:" && ./find_deps.sh
		echo "python3 $(python3)" >> $(PREFIX)/version
 
readline:
		echo "INFO: CFLAGS=$(CFLAGS)"
		echo "INFO: CPPFLAGS=$(CPPFLAGS)"
		echo "INFO: PREFIX=$(PREFIX)"
		echo "INFO: readlinefile=$(readlinefile)"
		echo "INFO: readlinesource=$(readlinesource)"
		# test -f "$(readlinefile)" \
		# 		&& echo "INFO: Found $(readlinefile)" \
		# 		|| (echo "INFO: Retrieving $(readlinesource)"; curl -Lso "$(readlinefile)" "$(readlinesource)")
		# tar -xf "$(readlinefile)"
		cd "$(readlinedir)" && \
		./configure \
				--prefix="$(PREFIX)" \
				--with-curses="$(PREFIX)" \
				--enable-shared \
				--enable-static && \
		make && \
		make install
		echo "readline $(readline)" >> $(PREFIX)/version
 
sqlite3: 
		echo "INFO: CFLAGS=$(CFLAGS)"
		echo "INFO: CPPFLAGS=$(CPPFLAGS)"
		echo "INFO: PREFIX=$(PREFIX)"
		echo "INFO: sqlite3file=$(sqlite3file)"
		echo "INFO: sqlite3source=$(sqlite3source)"
		# test -f "$(sqlite3file)" \
		# 		&& echo "INFO: Found $(sqlite3file)" \
		# 		|| (echo "INFO: Retreiving $(sqlite3source)"; curl -Lso "$(sqlite3file)" "$(sqlite3source)")
		# tar -xf "$(sqlite3file)"
		cd "$(sqlite3dir)" && \
		./configure \
				--prefix="$(PREFIX)" \
				--enable-shared \
				--enable-static \
				--enable-readline \
				--enable-threadsafe \
				--enable-dynamic-extensions && \
		make && \
		make install
		echo "sqlite3 $(sqlite3)" >> $(PREFIX)/version
 
zlib:
		echo "INFO: CFLAGS=$(CFLAGS)"
		echo "INFO: CPPFLAGS=$(CPPFLAGS)"
		echo "INFO: PREFIX=$(PREFIX)"
		echo "INFO: zlibfile=$(zlibfile)"
		echo "INFO: zlibsource=$(zlibsource)"
		# test -f "$(zlibfile)" \
		# 		&& echo "INFO: Found $(zlibfile)" \
		# 		|| (echo "INFO: Retrieving $(zlibsource)"; curl -Lso "$(zlibfile)" "$(zlibsource)")
		# tar -xf "$(zlibfile)"
		cd "$(zlibdir)" && \
		./configure \
				--prefix="$(PREFIX)" \
				--64 \
				--shared \
				--libdir="$(PREFIX)/lib" \
				--sharedlibdir="$(PREFIX)/lib" && \
		make && \
		make install
		echo "zlib $(zlib)" >> $(PREFIX)/version
 
 
clean: | \
		$(cleanexpat) \
		$(cleanffi) \
		$(cleanmpdec) \
		$(cleanncurses) \
		$(cleanopenssl) \
		$(cleanpython3) \
		$(cleanreadline) \
		$(cleansqlite3) \
		$(cleanzlib)
		@echo "INFO: Done cleaning"
 
$(cleanexpat):
		@echo "INFO: Removing $(expatdir)"
		rm -rf "$(expatdir)"
 
$(cleanffi):
		@echo "INFO: Removing $(ffidir)"
		rm -rf "$(ffidir)"
 
$(cleanmpdec):
		@echo "INFO: Removing $(mpdecdir)"
		rm -rf "$(mpdecdir)"
 
$(cleanncurses):
		@echo "INFO: Removing $(ncursesdir)"
		rm -rf "$(ncursesdir)"
 
$(cleanopenssl):
		@echo "INFO: Removing $(openssldir)"
		rm -rf "$(openssldir)"
 
$(cleanpython3):
		@echo "INFO: Removing $(python3dir)"
		rm -rf "$(python3dir)"
 
$(cleanreadline):
		@echo "INFO: Removing $(readlinedir)"
		rm -rf "$(readlinedir)"
 
$(cleansqlite3):
		@echo "INFO: Removing $(sqlite3dir)"
		rm -rf "$(sqlite3dir)"
 
$(cleanzlib):
		@echo "INFO: Removing $(zlibdir)"
		rm -rf "$(zlibdir)"
