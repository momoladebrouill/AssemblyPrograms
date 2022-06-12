make:
	@nasm -f elf64 hello.asm
	@ld -s -o hello hello.o
	@./hello

clean:
	rm a.out
	rm hello