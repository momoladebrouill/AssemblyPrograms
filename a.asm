section .data
  
  msg: db "hello world", 10
  msglen: equ $ - msg
  squidgame: db 10

section .bss
  letter: resb 1
  number: resb 19

section .text

printdec:
  lea r9, [number + 18] ; last character of tampon ;  Load Effective Address
  mov r10, r9         ; copy the last character address
  mov rbx, 10         ; base10 divisor

div_by_10:
  xor rdx, rdx          ; set rdx to 0 for div
  div rbx            ; rax:rdx = rax / rbx
  add rdx, 0x30      ; convert binary digit to ascii
  test rax,rax          ; if rax == 0 exit div_by_10
  jz last_remainder ; jump if zero, given by test
  mov byte [r9], dl       ; save remainder
  sub r9, 1               ; decrement the tampon address
  jmp div_by_10

last_remainder:
  test dl, dl       ; if dl (last remainder) != 0 add it to the tampon
  jz check_tampon
  mov byte [r9], dl       ; save remainder
  sub r9, 1               ; decrement the tampon address

check_tampon:
  cmp r9, r10       ; if the tampon has data print it
  jne print_tampon 
  mov byte [r9], '0' ; place the default zero into the empty tampon
  sub r9, 1

print_tampon:
  add r9, 1          ; address of last digit saved to tampon
  sub r10, r9        ; end address minus start address
  add r10, 1         ; r10 = length of number
  mov rax, 1         ; nr_write
  mov rdi, 1         ;     stdout
  mov rsi, r9        ;     number in the tampon address
  mov rdx, r10       ;     string length
  syscall
  ret ; return where this function where called

_start:

  mov rax, 1        ; write(
  mov rdi, 1        ;   stdout_fileno,
  mov rsi, msg      ;   "hello, world!\n",
  mov rdx, msglen   ;   sizeof("hello, world!\n")
  syscall

  mov rax,69   ; on le met dans rax
  call printdec   ; ecire le nombre

  mov rax,420   ; on le met dans rax
  call printdec   ; ecire le nombre

  mov rax, 60       ; exit(
  mov rdi, 0        ;   exit_success
  syscall           ; );

global _start

