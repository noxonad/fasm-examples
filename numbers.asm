format ELF64
public _start

extrn printf

section '.data' writable
; Note that we intentionally have different size operands
; to demonstrate how to work with converting them
numa dd 1691    ; double word (32-bit/4bytes)
numb db 42      ; byte (8 bits)
msg db  'Number A: %d', 0xA, \
        'Number B: %d', 0xA, \
        'Sum: %d', 0xA, \
        'Diff: %d', 0xA, \
        'Mul: %.2f', 0xA, \
        'Div: %.5f', 0xA, \
        'Mod: %d', 0xA, \
        0

section '.text' executable
_start:
    ; Calculate the mod beforehand
    ; for the double it's [edx:eax]/ecx = eax, mod = edx
    xor edx, edx
    mov eax, [numa]
    movzx ecx, [numb]
    idiv ecx
    mov r9d, edx        ; mod is the last one so it goes into r9d
    ; however we optimize by using edx, ecx and eax without saving
    ; their state and then restoring them

    ; Basic number printing
    mov esi, [numa]
    movzx rdx, [numb]
    mov ecx, [numa]
    mov r8d, [numa]

    ; rax for accumulator, rax will be reused later
    movzx rax, [numb]

    ; Basic addition and substraction
    add rcx, rax
    sub r8, rax

    ; Multiplication
    cvtsi2sd xmm0, [numa]   ; load double word
    movzx eax, [numb]       ; load byte
    cvtsi2sd xmm2, eax
    mulsd xmm0, xmm2

    ; Division
    cvtsi2sd xmm1, [numa]
    divsd xmm1, xmm2        ; reusing the xmm2

    ; Print the string
    mov rdi, msg            ; printf message template
    mov rax, 2              ; declaring that we have 2 float numbers
    call printf

    ; Exit
    mov rdi, 0  ; error_code
    mov rax, 60 ; exit
    syscall