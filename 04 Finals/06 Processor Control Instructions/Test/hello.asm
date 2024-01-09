section .data
    hello db 'Hello and quack quack mfer!', 0

section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, hello
    mov edx, 18
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newLoine
    mov edx, 1
    int 0x80

    mov eax, 1
    int 0x80

section .data
    newLoine db 10
