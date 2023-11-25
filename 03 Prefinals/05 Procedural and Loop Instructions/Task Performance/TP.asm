;                                               ;
; Github: https://github.com/Jiei-Dux           ;
; Task Performance - TP.asm                     ;
; 64-bit NASM Assembly Language                 ;
;                                               ;
; - - - - - - - - - - - - - - - - - - - - - - - -

section .data
    prompt      db      "Enter a single-digit number [0-9]: ",  0
    greater     db      "The number is above 5",                0
    less        db      "The number is below 5",                0
    equal       db      "The number is equal to 5",             0




section .text
    global _start




_start:
    mov         eax,    1               ; SYS_WRITE
    mov         edi,    1               ; STDOUT
    mov         rsi,    prompt
    mov         rdx,    35              ; Message length
    syscall

    mov         eax,    0               ; SYS_READ
    mov         edi,    0               ; STDIN
    mov         rsi,    input_buffer
    mov         rdx,    1               ; # of bytes to read
    syscall

    sub byte [input_buffer], '0'        ; Converts string(ASCII) to integer

    call startCompare                   ; Calls for startCompare function

    mov         eax,    60              ; SYS_EXIT
    xor         edi,    edi             ; Exit code 0 (success)
    syscall




startCompare:
    cmp byte [input_buffer], 5          ; Compare the input to 5
    je  equalInput                      ; if equal to 5, jump to equal
    jl  lessInput                       ; if less than 5, jump to below
    jmp greaterInput                    ; if greater than 5, jump to greater




equalInput:
    mov         eax,    1
    mov         edi,    1
    mov         rsi,    equal
    mov         rdx,    24              ; Message length
    syscall
    ret




lessInput:
    mov         eax,    1
    mov         edi,    1
    mov         rsi,    less
    mov         rdx,    21              ; Message length
    syscall
    ret




greaterInput:
    mov         eax,    1
    mov         edi,    1
    mov         rsi,    greater
    mov         rdx,    21              ; Message length
    syscall
    ret




section .bss
    input_buffer resb   1               ; reserve space for the input
