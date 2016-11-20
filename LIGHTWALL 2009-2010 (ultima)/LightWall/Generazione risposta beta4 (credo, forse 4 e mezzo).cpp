#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>


//questa va benissimo, non richiede modifiche ed è compatibile con praticamente tutte le versioni di lightwall. Perfettamente funzionante e stratestata da 15.7
int main(){

//program generaz_codice BETA 4, ottimizzato e migliorato i commenti rispetto beta3, ma non necessita nuove modifiche va già benissimo

   int codice[7];
   char string[7];
   int risposta[12];
   int i;
   
   printf("Inserisci il codice utente in fila e premi invio al termine\n\n");
   scanf("%s",string);
 
   for(i=0;i<7;i++) codice[i]=(int)string[i]-48;  // con questo trasformo i caratteri(che poi sono numeri) inseriti nella stringa in interi, sottraendo 48, cioè il valore dello 0 in ASCII

   printf("\nGenerazione codice di risposta\n");  //genero secondo l'algoritmo che ho scelto
   risposta[0]=0;
   risposta[1]=codice[0]+codice[1]-codice[3];
   risposta[2]=codice[0];
   risposta[3]=codice[4]+2;
   risposta[4]=codice[4]+1;
   risposta[5]=8;
   risposta[6]=codice[1];
   risposta[7]=0;
   risposta[8]=codice[2]+codice[3]-1;
   risposta[9]=codice[2]+2;
   risposta[10]=codice[5]+codice[6]-4;
   risposta[11]=codice[5]-codice[6]+1;

   for(i=0;i<12;i++) printf("%d ",risposta[i]);
   
   printf("\n\nInvia questo codice all'utente che ha come codice %s\n\n",string);    
      
   system("PAUSE");
   return 0;
}
