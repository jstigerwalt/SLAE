; Author: John Stigerwalt
; SLAE: Assignment #5
; Website: slae.whiteknightlabs.com
; Shellcode: exec /bin/sh -c "/sbin/ifconfig"
; Metasploit Re-Write of exec "/sbin/ifconfig"
; Shellcode using push dword method

global _start

section .text

_start:

push byte +0xb
pop eax
cdq
push edx
push word 0x632d
mov edi,esp
push dword 0x68732f
push dword 0x6e69622f
mov ebx,esp
push edx

push dword 0x6769
push dword 0x666e6f63
push dword 0x66692f6e
push dword 0x6962732f
mov esi, esp

push edx
push esi
push edi
push ebx
mov ecx,esp
int 0x80
