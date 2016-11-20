#include "iostream"
#include "stdafx.h"
#include <stdio.h>
#include <netdb.h>
#include <netinet/if_ether.h>

int _get_MAC(void) {
	int sock,sockfd, n, cnt;
	char buffer[2048];
	unsigned char *iphead, *ethhead;
	struct ether_addr ether;
  
	if ( (sock=socket(PF_PACKET, SOCK_RAW,htons(ETH_P_IP)))<0){
		perror("socket");
		exit(1);
	}

	while (1) {
		if (n = recvfrom(sock,buffer,2048,0,NULL,NULL)== -1) {
			perror("recvfrom");
			close(sock);
			exit(1);
		} 
	
		ethhead = (unsigned char *)buffer;
		
		if (ethhead != NULL){
			iphead = (unsigned char *)(buffer+14); // Skip Ethernet header
			printf("\n--------------------------------------"
				"\nMAC destino (server): "
				"%02x:%02x:%02x:%02x:%02x:%02x\n",
				ethhead[0],ethhead[1],ethhead[2],
				ethhead[3],ethhead[4],ethhead[5]);
			printf("MAC origen  (CAL30x): "
				"%02x:%02x:%02x:%02x:%02x:%02x\n",
				ethhead[6],ethhead[7],ethhead[8],
				ethhead[9],ethhead[10],ethhead[11]);  

			if (*iphead==0x45) { // Double check for IPv4 and no options present
				printf("IP destino  (server): %d.%d.%d.%d\n",
					iphead[12],iphead[13],
					iphead[14],iphead[15]);
				printf("IP origen   (CAL30x): %d.%d.%d.%d\n",
					iphead[16],iphead[17],
					iphead[18],iphead[19]);
				printf("Protocolo   (UDP=11): %02x Hex\n",iphead[9]);
			}
		}    
	}
	return 0;
}

int main(int argc, char **argv) 
{
    _get_MAC();
      return 0;
}