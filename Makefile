CC ?= gcc
RUSTC ?= rustc
AR ?= ar
RUSTFLAGS ?=

RUST_SRC = $(shell find . -type f -name '*.rs')

.PHONY: all
all: libcocoa.dummy

libcocoa.dummy: cocoa.rc $(RUST_SRC) libmsgsend.a
	$(RUSTC) $(RUSTFLAGS) $< -o $@
	touch $@

cocoa-test: cocoa.rc $(RUST_SRC) libmsgsend.a
	$(RUSTC) $(RUSTFLAGS) $< -o $@ --test

libmsgsend.a: msgsend.o
	$(AR) rcs libmsgsend.a msgsend.o

msgsend.o: msgsend.c
	$(CC) $< -o $@ -c

check: cocoa-test
	./cocoa-test

.PHONY: clean
clean:
	rm -f cocoa-test *.a *.o *.so *.dylib *.dll *.dummy
