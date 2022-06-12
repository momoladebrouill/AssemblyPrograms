section .data
  msg: db "anato", 10
  msglen: equ $ - msg
  nb: equ 5
section .text

loopo:
  call print
  sub r10,1
  test r10,r10
  jnz loopo
  ret

print:
  mov rax, 1        ; write(
  mov rdi, 1        ;   stdout_fileno,
  mov rsi, msg      ;   "hello, world!\n",
  mov rdx, msglen   ;   sizeof("hello, world!\n")
  syscall
  ret

_start:
  mov r10, nb
  call loopo

  mov rax, 60       ; exit(
  mov rdi, 0        ;   exit_success
  syscall           ; );

global _start