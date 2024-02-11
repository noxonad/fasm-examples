format ELF64
public _start

extrn malloc
extrn free
extrn printf

section '.data' writable
fail_msg db 'Failed to allocate memory. Just download more RAM!!', 0xA, 0
int_msg db 'Value: %d', 0xA, 0
mem dd ? ; no initialization

section '.text' executable
_start:
    ; Allocate memory using malloc 
    mov rdi, 24
    call malloc
    or eax, eax                 ; test for error
    jz _malloc_fail             ; allocated 0 memory (error case)
    mov [mem], eax              ; save the address to mem
    jmp _malloc_fail_skip       ; malloc is not failed

    ; Print the message on fail and exit
    _malloc_fail:
        mov rdi, fail_msg
        call printf
        jmp _exit
    _malloc_fail_skip:

    ; Write something in that memory
    mov [mem+4], 10
    mov [mem+8], 5

    ; Print the first value
    mov rdi, int_msg
    mov esi, [mem+4]
    call printf

    ; Print the second value
    mov rdi, int_msg
    mov esi, [mem+8]
    call printf

    ; Free the memory
    mov edi, [mem]
    call free

    _exit:
        mov rdi, 0  ; error_code
        mov rax, 60 ; exit
        syscall