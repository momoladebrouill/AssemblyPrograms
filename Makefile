make:
	@nasm -f elf64 loop.asm -o hello.o
	@ld -s -o hello hello.o
	@./hello

clean:
	$(RM) a.out
	$(RM) hello
	$(RM) *.o