; John Lloyd Milan & Amanda Gabrielle Perez -- SS1

%include "io64.inc"
 section .data
    X dd 1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,0.0,0.0,0.0  ; Input array X -- need to make an array based on user input 
    zero dd 0.0
section .bss
    input_buffer resb 11  ;10 bits for string
    ; Define uninitialized space for vector Y
   ; X resb  100000
    Y resb  10000 
section .text
global main
main:
    mov rbp, rsp; for correct debugging
    
    ;Get length of array
    GET_DEC 8, input_buffer
    mov ecx,dword[input_buffer]
    
    
    
    cmp ecx, 7
    jge stencil
    NEWLINE
    PRINT_STRING "Not enough vector size to perform stencil"
    jmp end 
    
    ;Make an array X with vectors 
    
    
   
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
        movss xmm1, [X+ebx+EDX]
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
    MOVSS XMM0,[Y]
    MOVSS XMM1,[Y+4]
    MOVSS XMM2, [Y+8]
    MOVSS XMM3, [Y+12]
    xor rax, rax
    ret