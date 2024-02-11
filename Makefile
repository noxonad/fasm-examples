CC=./fasm
CFLAGS=-dynamic-linker /lib64/ld-linux-x86-64.so.2
CLIBS=-lc
CLEAR=*.o *.dump
.PHONY: default build malloc time numbers

default: build

build: malloc time numbers

malloc: malloc.asm
	$(CC) malloc.asm
	ld malloc.o $(CLIBS) $(CFLAGS) -o malloc

time: time.asm
	$(CC) time.asm
	ld time.o $(CLIBS) $(CFLAGS) -o time

numbers: numbers.asm
	$(CC) numbers.asm
	ld numbers.o $(CLIBS) $(CFLAGS) -o numbers

clean:
	rm -f time time.o malloc malloc.o numbers numbers.o