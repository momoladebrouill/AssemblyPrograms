make:
	@nasm -f elf64 hello.asm
	@ld -s -o hello hello.o
	@./hello

clean:
	$(RM) a.out
	$(RM) hello
	$(RM) *.o