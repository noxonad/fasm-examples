format ELF64
public _start

extrn malloc
extrn free
extrn printf

section '.data' writable
mem dd ? ; no initialization
fail_msg db 'Failed to allocate memory. Just download more RAM!!', 0xA, 0
int_msg db 'Value: %d', 0xA, 0

section '.text' executable
_start:
    ; Allocate memory using malloc 
    mov rdi, 24
    call malloc
    or eax, eax                 ; test for error
    jz _malloc_fail             ; allocated 0 memory (error case)
    mov [mem], eax              ; save the address to mem
    jmp _malloc_fail_skip       ; malloc is not failed

    ; Print the message on fail (and exit)
    _malloc_fail:
        mov rdi, fail_msg
        call printf
        jmp _exit
    _malloc_fail_skip:

    ; Write something in that memory
    mov eax, [mem]      ; load the address allocated by malloc
    mov bx, 10
    mov [eax], bx      ; write double word (10) into the first index
    mov bx, 5
    mov [eax+2], bx    ; write double word (5) into the second index 

    ; Print the first value
    mov rdi, int_msg
    mov si, [eax]
    call printf

    ; Print the second value
    xor esi, esi        ; clear the esi value
    mov eax, [mem]      ; make sure eax has the address from malloc
    mov rdi, int_msg
    mov si, [eax+2]
    call printf

    ; Free the memory
    mov edi, [mem]
    call free

    _exit:
        mov rdi, 0  ; error_code
        mov rax, 60 ; exit
        syscall