%define O_RDONLY 0
%define PROT_READ 0x1
%define MAP_PRIVATE 0x2

section .data
fname: db 'test.txt', 0

section .text
global _start

print_string:
    push rdi
    call string_length
    pop rsi
    mov rdx, rax
    mov rax, 1
    mov rdi, 1
    syscall
    ret

string_length:
    xor rax, rax
.loop:
    cmp byte [rdi + rax], 0
    je .end
    inc rax
    jmp .loop
.end:
    ret

_start:
    ; call open
    mov rax, 2
    mov rdi, fname
    mov rsi, O_RDONLY
    mov rdx, 0
    syscall

    ; call mmap
    mov r8, rax                 ; = file descriptor

    mov rax, 9                  ; mmap syscall number
    mov rdi, 0                  ;
    mov rsi, 4096               ; page size
    mov rdx, PROT_READ          ; mark read only
    mov r10, MAP_PRIVATE        ; no share

    mov r9, 0                   ; test.txt file 内の offset
    syscall

    mov rdi, rax
    call print_string

    mov rax, 60                 ; exit call
    xor rdi, rdi
    syscall
