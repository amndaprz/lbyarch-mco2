; John Lloyd Milan & Amanda Gabrielle Perez -- SS1

%include "io64.inc"
 section .data
    zero dd 0.0
section .bss
    input_buffer resb 11  ;10 bits for string
    X resb  536870912 ;Maximum bits needed for 2^30
    Y resb  536870912 ;Maximum bits needed for 2^30
section .text
global main
main:
    mov rbp, rsp; for correct debugging
    
    ;Get length of array
    GET_DEC 8, input_buffer
    mov ecx,dword[input_buffer]
    
    cmp ecx, 7
    jge start
    NEWLINE
    PRINT_STRING "Not enough vector size to perform stencil"
    jmp end 
    
    start:
    mov ebx, 0
    mov eax, 1
    ;Make an array X with vectors 
    loop_array:
    cvtsi2ss xmm0, eax        ; Convert integer in eax to double-precision floating-point in xmm0
    movsd [ X + ebx], xmm0    ; Store the floating-point value in xmm0 to memory location Y

    add eax, 1               ; Increment the value
    add ebx, 4               ; Next Single Precision Flaoting Point
    loop loop_array          ; Repeat until all elements are initialized

    mov ecx,dword[input_buffer]
    stencil:
    ;how many Y outputs are expected?
    ;Length - 6
    sub ecx, 6
    mov edx, 0
    loop_start:;terminate if edx == 0
    cmp ecx,0
    je end
    ;pxor xmm0,xmm0
    movss xmm0, [zero]
    mov eax, 6 ; add 7 elements per Y output 
        loop_add:
        cmp eax,-1       
        je end_add
        mov ebx, eax
        imul ebx,ebx,4
        movss xmm1, [X + ebx + edx]
        addss xmm0,xmm1
        dec eax
        jmp loop_add

     end_add:
    ;Store xmm0 to y
     movd [Y + edx], xmm0
     dec ecx     
     add edx,4 ;next index     
     jmp loop_start
    
    end:
    ;Sanity Check
    ; Check first 2
    MOVSS XMM0,[Y]
    MOVSS XMM1,[Y+4]
    ;Check last 2
    mov ecx,dword[input_buffer]
    sub ecx, 6 
    imul ecx, ecx, 4
    MOVSS XMM2, [Y + ecx - 4]
    MOVSS XMM3, [Y + ecx - 8]
    ;Convert single precision floating point to integer for sanity check
    cvtss2si rax, xmm0 
    cvtss2si rbx, xmm1 
    cvtss2si rcx, xmm2 
    cvtss2si rdx, xmm3 
    
    PRINT_DEC 8, rax
    NEWLINE
    PRINT_DEC 8, rbx
    NEWLINE
    PRINT_DEC 8, rcx
    NEWLINE
    PRINT_DEC 8, rdx
    NEWLINE
    xor rax, rax
    ret