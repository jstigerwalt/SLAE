; Author: John Stigerwalt
; SLAE: Assignment #5
; Website: slae.whiteknightlabs.com
; Shellcode: exec /bin/sh -c "/sbin/ifconfig"
; Metasploit Re-Write of exec "/sbin/ifconfig"
; Shellcode using jmp-call-pop method

global _start

section .text

_start:

xor eax, eax
xor edx, edx
push byte +0xb
pop eax
cdq
push edx
push word 0x632d
mov edi,esp
push dword 0x68732f
push dword 0x6e69622f   ; /bin/sh -c
mov ebx,esp             ; Set STack pointer to ebx
push edx

jmp short push_str

;Metasploit String Junk pdisas ("/sbin/ifconfig")
;call dword 0x2c
;das
;jnc 0x82
;imul ebp,[esi+0x2f],dword 0x6f636669
;outsb
;imul sp,[edi+0x0],word 0x5357

last:
    push edi
    push ebx
    mov ecx,esp
    int 0x80


push_str:
    call last
    command: db "/sbin/ifconfig"
