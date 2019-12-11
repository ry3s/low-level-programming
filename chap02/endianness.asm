section .data

newline_char: db 10
codes: db '0123456789abcdef'

section .text
global _start

print_newline:
    mov rax, 1                  ; 'write syscall identifier
    mov rdi, 1                  ; stdout file descriptor
    mov rsi, newline_char       ; where do we take data from
    mov rdx, 1                  ; the amount of bytes to write
    syscall
    ret

print_hex:
    mov rax, rdi

    mov rdi, 1
    mov rdx, 1
    mov rcx, 64                 ; how far are we shifting rax?
iterate:
    push rax                    ; save the initial rax value
    sub rcx, 4
    sar rax, cl
    ; shift to 60, 56, 52, ..., 4, 0
    ; the cl register is the smallest part of rcx
    and rax, 0xf                ; clear all bits but the lowest four
    lea rsi, [codes + rax]      ; take a hexadecimal digit character code

    mov rax, 1

    push rcx                    ; syscall will break rcx
    syscall
    ; rax = 1 (31) -- the write identifier,
    ; rdi = 1 for stdout
    ; rsi = the address of a character

    pop rcx
    pop rax
    test rcx, rcx
    jnz iterate

    ret

section .data
demo1: dq 0x1122334455667788
demo2: db 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88

_start:
    mov rdi, [demo1]
    call print_hex
    call print_newline

    mov rdi, [demo2]
    call print_hex
    call print_newline

    mov rax, 60
    xor rdi, rdi
    syscall
