#include <openssl/sha.h>
#include <openssl/md5.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>





int main (void)
{
const char test[]="Hello World!";
char str[150];
int i;
char t;
FILE *cfPtr;

i=0;
if((cfPtr=fopen("clients.dat","r"))==NULL) printf("\n\n non va\n\n");
else
{
	fscanf(cfPtr,"%c",&t);
	while(!feof(cfPtr))
	{
		fscanf(cfPtr,"%c",&t);
		str[i]=t;
		i++;
		printf("%c",t);
	}
}
fclose(cfPtr);
system("PAUSE");
printf("\n %s \n",str);



// allora la struttura che contiene informazioni sugli hash
MD5_CTX md5;
SHA_CTX sha;

// inizializza le strutture
MD5_Init (&md5);
SHA1_Init(&sha);

// calcola l'hash della stringa in input
MD5_Update (&md5, (const unsigned char *) test, strlen(str));
SHA1_Update(&sha, (const unsigned char *) test, strlen(str));

// i buffer devono essere unsigned char, mettere solo char
// causa un problema nella stampa
unsigned char buffer_md5[16];
unsigned char buffer_sha[20];

// calcola l'hash finale
MD5_Final ( buffer_md5, &md5);
SHA1_Final ( buffer_sha, &sha);

printf("\nStringa di input: %s", str);

//stampa l'MD5
printf("\nMD5: ");
for (i=0;i<16;i++)
printf ("%02x", buffer_md5[i]);

//stampa dello SHA-1
printf("\nSHA-1: ");
for (i=0;i<20;i++)
printf ("%02x", buffer_sha[i]); 
system("PAUSE");
return 1;
}