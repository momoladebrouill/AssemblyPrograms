section .data ; début du segment de données
	tableau:
		.quad 1
		.quad 5
	.quad 2
	.quad 18
	somme:
	.quad 0
section .text ; début du segment de code
	.global _start
	_start:
		xor %rax, %rax ; RAX = 0
		xor %rbx, %rbx ; RBX = 0
		mov $tableau, %rcx ; RCX = tableau
	tant_que:
		cmp $4, %rax ; RAX == 4 ?
		je fin ; alors fini
		add (%rcx, %rax,8), %rbx ; RBX += RCX[RAX]
		inc %rax ; RAX++
		jmp tant_que
	fin:
		mov %rbx, somme ; fini, résultat dans somme
		mov $60, %rax ; RAX = 60 (code de l’AS exit)
		xor %rdi, %rdi ; RDI = 0
		syscall ; appel systeme
