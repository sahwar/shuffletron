SBCL=sbcl
CCL=ccl
CCL64=ccl64
PREFIX=/usr/local

all:	shuffletron-bin

clean:
	rm -f shuffletron-bin shuffletron-ccl shuffletron-ccl64
	rm -f *~ *.fasl *.lx*fsl

distclean:
	rm -f *~ *.fasl *.lx*fsl \#*\#

install:
	install -m 0755 shuffletron shuffletron-bin $(PREFIX)/bin

.PHONY: install all clean distclean

shuffletron-bin: shuffletron.lisp build-sbcl.lisp
	$(SBCL) --noinform --no-userinit --disable-debugger \
	        --eval "(require :asdf)" \
	        --eval "(load \"build-sbcl.lisp\")"

shaken: shuffletron.lisp build-shaker.lisp
	$(SBCL) --noinform --no-userinit --disable-debugger \
	        --eval "(require :asdf)" \
	        --eval "(load \"build-shaker.lisp\")"

shuffletron-ccl64: shuffletron.lisp build-ccl.lisp
	$(CCL64) -n -e "(require :asdf)" \
	            -e "(load \"build-ccl.lisp\")"

shuffletron-ccl: shuffletron.lisp build-ccl.lisp
	$(CCL) -n -e "(require :asdf)" \
	          -e "(load \"build-ccl.lisp\")"

