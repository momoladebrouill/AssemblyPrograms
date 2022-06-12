section .data
  
  msg: db "Hello, world!", 10
  msglen: equ $ - msg
  nb: db 64

section .bss
 LETTER: RESB 1
 NUMBER: RESB 19

section .text

PRINTDEC:
  LEA R9, [NUMBER + 18] ; last character of buffer
  MOV R10, R9         ; copy the last character address
  MOV RBX, 10         ; base10 divisor

DIV_BY_10:
  XOR RDX, RDX          ; zero rdx for div
  DIV RBX            ; rax:rdx = rax / rbx
  ADD RDX, 0x30      ; convert binary digit to ascii
  TEST RAX,RAX          ; if rax == 0 exit DIV_BY_10
  JZ LAST_REMAINDER
  MOV byte [R9], DL       ; save remainder
  SUB R9, 1               ; decrement the buffer address
  JMP DIV_BY_10

LAST_REMAINDER:
  TEST DL, DL       ; if DL (last remainder) != 0 add it to the buffer
  JZ CHECK_BUFFER
  MOV byte [R9], DL       ; save remainder
  SUB R9, 1               ; decrement the buffer address

CHECK_BUFFER:
  CMP R9, R10       ; if the buffer has data print it
  JNE PRINT_BUFFER 
  MOV byte [R9], '0' ; place the default zero into the empty buffer
  SUB R9, 1

PRINT_BUFFER:
  ADD R9, 1          ; address of last digit saved to buffer
  SUB R10, R9        ; end address minus start address
  ADD R10, 1         ; R10 = length of number
  MOV RAX, 1         ; NR_write
  MOV RDI, 1         ;     stdout
  MOV RSI, R9        ;     number buffer address
  MOV RDX, R10       ;     string length
  SYSCALL

RET
_start:

  mov rax, 1        ; write(
  mov rdi, 1        ;   STDOUT_FILENO,
  mov rsi, msg      ;   "Hello, world!\n",
  mov rdx, msglen   ;   sizeof("Hello, world!\n")
  syscall

  mov rax,55
  call PRINTDEC 
  mov rax, 60       ; exit(
  mov rdi, 0        ;   EXIT_SUCCESS
  syscall           ; );

global _start

