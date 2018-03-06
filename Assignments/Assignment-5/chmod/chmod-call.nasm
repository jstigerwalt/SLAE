; Author: John Stigerwalt
; SLAE: Assignment #5
; Website: slae.whiteknightlabs.com
; Shellcode: chmod /tmp/test mode 0777
; Metasploit Re-Write of chmod with parameter "/tmp/test" mode 0777
; Shellcode using jmp-call-pop method

global _start

section .text

_start:

cdq
push 0xf
pop eax
push edx

jmp short push_str

last:
    pop ebx
    push 0x1ff
    pop ecx
    int 0x80
    push 0x1
    pop eax
    int 0x80

push_str:
    call last
    str: db "/tmp/test"
