//SOURCECODE BY KS89 (CAPPA STEFANO)
//BETA 5 SOURCECODE, funziona davvero!!!!!!
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>


//questa va benissimo. COMPATIBILE SOLO DA BETA 17.1.0 ECC... E DA LCL BETA 2.0.0   TESTATA ANCHE SU LIGHTWALL BETA 17.3.2, LICENSE MANAGER 1.0.1 E LCL 2.0.2 TUTTO OK!
int main(){

//program generaz_codice BETA 5, nuovissimi algoritmo per il codice utente e risposta ecc.. di conseguenza ho riscritto questo generaz risposta in beta 5, credo anche l'ultima, visto che vorrei mettere tutto in LCL

   int codice[11];
   char string[11];
   int risposta[14];
   int i,tipolic,variabile,variabile2;

   printf("          ***********************************************************\n");
   printf("          *..::Benvenuto in GENERAZIONE RISPOSTA BETA 5 by ks89!::..*\n");
   printf("          ***********************************************************\n\n");

   printf("Scegli il tipo di licenza\n");
   printf("99 -> PROFESSIONAL\n");
   printf("1,2 o 3 -> HOME (num anni)\n\n");
   scanf("%d",&tipolic);
   if (tipolic==99) {//PRO
						variabile=2;
						variabile2=1;
					}
   else {//HOME
			variabile=1;
			variabile2=tipolic; //setto la quantità di anni. AL massimo 3
		}

   printf("Inserisci il codice utente in fila e premi invio al termine\n\n");
   scanf("%s",string);
 
   for(i=0;i<11;i++) codice[i]=(int)string[i]-48;  // con questo trasformo i caratteri(che poi sono numeri) inseriti nella stringa in interi, sottraendo 48, cioè il valore dello 0 in ASCII


   printf("\nGenerazione codice di risposta\n");  //genero secondo l'algoritmo che ho scelto
   risposta[0]=codice[3]+codice[7]-1;
   risposta[1]=codice[0]+codice[1]-codice[3];
   risposta[2]=codice[0]+codice[7]-1;
   risposta[3]=codice[4]+2;
   risposta[4]=codice[4]+1;
   if((codice[5]-codice[6])>=0) risposta[5]=(codice[5]-codice[6]);
   else risposta[5]=(codice[5]-codice[6])*(-1);
   risposta[6]=codice[1]-1;
   risposta[7]=codice[8]+codice[7]-3;
   risposta[8]=codice[2]+codice[3]-1;

   risposta[9]=(codice[7]*2)-variabile;//tipo licenza in base a variabile

   risposta[10]=codice[2]+2;

   risposta[11]=codice[1]+variabile2;//durata
						
   risposta[12]=codice[5]-1;
   int verif_risp_isbn1=10-(((risposta[0]*9)+(risposta[1]*8)+(risposta[2]*7)+(risposta[3]*6)+(risposta[4]*5)+(risposta[5]*4)+(risposta[6]*3)+(risposta[7]*2))%10);
   risposta[13]=8-(((verif_risp_isbn1*7)+(risposta[8]*6)+(risposta[9]*5)+(risposta[10]*4)+(risposta[11]*3)+(risposta[12]*2))%8);


   for(i=0;i<14;i++) printf("%d ",risposta[i]);
   
   printf("\n\nInvia questo codice all'utente che ha come codice %s\n\n",string);    
      
   system("PAUSE");
   return 0;
}
