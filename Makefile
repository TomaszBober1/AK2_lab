all: encryption

encryption: encryption.o
	ld encryption.o -o encryption

encryption.o: encryption.s
	as encryption.s -o encryption.o

clean:
	encryption encryption.o
