test: atax.o polybench.o
	gcc atax.o polybench.o -o out
	
atax.o: useless.o
	gcc -c atax.c

useless.o: useless_in_folder.o
	gcc -c useless
	
polybench.o:
	gcc -c polybench.c
	
direct_compile:
	gcc -o out atax.c polybench.c
	
clean:
	rm -f *.o
	rm -f out
