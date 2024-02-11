format ELF64
public _start

extrn time
extrn sleep
extrn printf

section '.data' writable
sprint db "The elapsed time is %d seconds", 0xA, 0x0
time_begin dq ?

section '.text' executable
_start:
    ; Get initial time
    xor rdi, rdi
    call time
    mov [time_begin], rax

    ; Sleep for 2 seconds
    mov rdi, 2
    call sleep

    ; Get the finish time
    xor rdi, rdi
    call time
    ; Calculate the difference
    sub rax, [time_begin]

    ; Print the difference
    mov rdi, sprint
    mov rsi, rax
    xor eax, eax
    call printf

    ; Exit
    mov rdi, 0  ; error_code
    mov rax, 60 ; exit
    syscall