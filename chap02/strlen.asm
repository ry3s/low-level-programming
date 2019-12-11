global _start

section .data

test_string: db "abcdef", 0

section .text

strlen:
    ; argument: rdi
    xor rax, rax                ; rax = string length

.loop:
    cmp byte [rdi + rax], 0

    je .end                     ; Jump if we found null-terminator

    inc rax                     ; Otherwise go to next symbol and increase counter

    jmp .loop

.end:
    ret                         ; rax = return value

_start:
    mov rdi, test_string
    call strlen
    mov rdi, rax

    mov rax, 60
    syscall
