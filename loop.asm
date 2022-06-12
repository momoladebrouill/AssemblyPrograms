section .data
  msg: db "anato", 10
  msglen: equ $ - msg
  nb: equ 1
section .text

_start:
  mov r9, nb
  jmp l

l:
  test r9,r9
  jz exit
  sub r9,1
  call print
  jmp l

print:
  mov rax, 1        ; write(
  mov rdi, 1        ;   stdout_fileno,
  mov rsi, msg      ;   "hello, world!\n",
  mov rdx, msglen   ;   sizeof("hello, world!\n")
  syscall
  ret

exit:
  mov rax, 60       ; exit(
  mov rdi, 0        ;   exit_success
  syscall           ; );

global _start