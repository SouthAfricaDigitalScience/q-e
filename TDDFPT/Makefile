# Makefile for TDDFPT
sinclude ../make.sys

default: all

all: bindir tddfpt tddfptools

bindir:
	if [ ! -d bin ] ; then mkdir bin; fi;

tddfpt:
	( cd src ; $(MAKE) all || exit 1 ) 

tddfptools:
	( cd tools ; $(MAKE) all || exit  1 )

clean :
	( cd src ; $(MAKE) clean ; )
	( cd tools ; $(MAKE) clean ; )

doc:
	if test -d Doc ; then \
        ( cd Doc ; $(MAKE) all || exit 1 ) ; fi

doc_clean:
	if test -d Doc ; then \
        (cd Doc ; $(MAKE) clean ) ; fi

distclean: clean



