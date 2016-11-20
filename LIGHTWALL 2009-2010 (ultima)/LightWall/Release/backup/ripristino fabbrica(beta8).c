#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <openssl/sha.h>//essenziali per usare md5 e sha. Sono librerie di openssl da copiare nella cartella delle librerie di visual studio. Crecare stdio.h e nella cartella in cui si trova copiare dentro i 2 file
#include <openssl/md5.h>


//Attenzione. Rispristino fabbrica beta 8, sarà la sua ultima versione, in quanto sostituito permanentemente da LIGHTCOMMANDLINE (LCL) beta, che per ora non funziona a dovere, però il ripristino lo fa già
//abbastanza bene, quindi dichiaro RIP FABBRICA rimpiazzato per sempre da LCL, che aggiunge tantissime funzionalità al comune rispristino

//Correzioni in questa versione beta 8
//-Modifiche sostanziali per renderlo compatibile con beta 16.0.0
//-Riscrittura completa della visualizzazione grafica dei dati, maggiore ordine e + comodo leggere
//-Correzione rispristino fabbrica del percorso. Perchè la struttura è di 20, ma io facevo un for di 15. Il programma non vedeva errori o difetti per coincidenza, ma in casi particolari
  //avrebbero potuto esserci problemi anke gravi rendendo di fatto il programma inutilizzabile prima o dopo la registrazione. E' da tanto che c'era sto difetto ma me ne sono accorto solo ora

//QUESTO SERVE PER RIPRISTINARE I FILE ALLA CONFIGURAZIONE DI FABBRICA, CIOE' COME SI PRESENTANO SUBITO DOPO L'INSTALLAZIONE
//BETA 8 funziona solo da beta 16 perchè qui è cambiata la struttura del rek.dll. nON USARLA PER VERSIONI PRECEDENTI PERCHE' LE STRUTTURE SONO CAMBIATE TANTISSIMO



//variabili per hash md5 e sha1, le dichiaro qui per usarle anche nella funziona seguente
unsigned char md5_fun[16],sha1_fun[20];
void hash_rex_dll_funzione(void)
{
   //variabili per md5 e sha (versione semplice che verifica alcuni dati e scrive il codice dentro il file rek.dll
   char stringa_hash[150]; //ci sono molte altre variabili sparse per il programma
   int lungh_hash,ind=0;
   unsigned char buffer_md5[16],buffer_sha[20];	// i buffer devono essere unsigned char, mettere solo char causa un problema nella stampa
   MD5_CTX md5;// allora la struttura che contiene informazioni sugli hash
   SHA_CTX sha;// allora la struttura che contiene informazioni sugli hash

   //inizio procedura per salvare md5 e sha1 nel file rek
   strcpy(stringa_hash,"1");//copio in stringa_hash il percorso
   strcat (stringa_hash,"2");//concateno alla stringa_hash anche il nome pc
   lungh_hash=strlen("1")+strlen("2");//calcolo lunghezza della nuova stringa data da concatenazione del percorso e nome pc
   for(ind=0;ind<7;ind++) stringa_hash[ind+lungh_hash]=(char)(48);//aggiungo codice utente alla stringa come carattere
   stringa_hash[ind+lungh_hash]=(char)(48);//aggiungo codice di controllo del codice alla stringa
   stringa_hash[ind+lungh_hash+1]='\0';//importante mettono alla fine dell'array di char il carattere \0 per terminarlo e poterlo trattare come una stringa

   printf("\n%s\n",stringa_hash);

   // inizializza le strutture
   MD5_Init (&md5);
   SHA1_Init(&sha);

   // calcola l'hash della stringa in input
   MD5_Update (&md5, (unsigned char *) stringa_hash, strlen(stringa_hash));
   SHA1_Update(&sha, (unsigned char *) stringa_hash, strlen(stringa_hash));

   // calcola l'hash finale
   MD5_Final (buffer_md5, &md5);
   SHA1_Final (buffer_sha, &sha);

   //stampa l'MD5
   printf("\nMD5: ");
   for (ind=0;ind<16;ind++){
							 printf ("%02x", buffer_md5[ind]);
							 md5_fun[ind]=buffer_md5[ind];
						   }

   //stampa dello SHA-1
   printf("\nSHA-1: ");
   for (ind=0;ind<20;ind++){
							 printf ("%02x", buffer_sha[ind]); 
							 sha1_fun[ind]=buffer_sha[ind];
						   }

}





struct writeData{      //record per scrivere sul file, i campi inutili  non servono a nulla, fa solo confusione per chi cercasse di cracckare
       int mixer8;     //sono variabili che fanno incasinare (mescolare) i dati nel file, così è difficile capire quali sono dati utili e soprattutto uso questi dati per fare controlli su integrità file(sblocco licenza)
	   int codice[7];
	   int mixer6;
       int controllo;  //questa cifra è di controlo ottenuta dall'algoritmo che crea il codice isbn (vedi wikipedia), io lo uso qui per rendere ancora più difficile la modifica del file licenza(quella.dat)
	   int mixer4;
	   char reg[5];
	   int mixer5;
	   int inutile;    //gli INUTILI ssono davvero inutili, rendono la compresione del file licenza più difficile, quindi è un bene perchè si impedisce la modifica di dati delicati
	   int mixer7;
	   double inutile2;
	   int pcname[20];
	   char space[2];//inutile alla grande! serve solo a creare spazio tra pcname e pathcodificato se no il rispristino fabbrica sbaglia la lettura dei dati
	   int path_codificato[100];
	   int controllo_registrazione; //variabile che serve solo a far si che non venga più richiesta la scelta della modalità di registrazione se già registrato
	   int codice_controlloic[7];
	   int mixer3;
	   int mixer2;
	   int mixer1;
	   int mixer9;
	   int matrice[10][10];
};              

struct writepcData{  //record per scrivere nome pc
	   char nomepc_w[20];
	   int codice_controlloic_w[7];
	   unsigned char md5_w[16];
	   unsigned char sha1_w[20];
	   int matrice_w[10][10];
};             

int main(){
   FILE *cfPtr;  
   int i,z,y;
                                                               
   struct writeData write={0,{0,0,0,0,0,0,0},0,0,0,"",0,0,0,0.0,{0},"",{0},0,{0},0,0,0,0}; //imposto valori standard nella struttura   
   struct writepcData writepc;  


   printf("***BENVENUTO NEL RESTARTER DI LIGHTWALL***\n\n");
   printf("Con questo file si puo' ripristinare il file principale ai valori iniziali\n\n");
   printf("***********************************************************************\n");
   printf("**********Lettura informazioni dai file avvenuta con successo**********\n");
   printf("***********************************************************************\n\n");

//LETTURA DE 2 FILE rek e ks
//*************************************************************************************************************************
//*********************************KS.DAT*KS.DAT*KS.DAT*KS.DAT*KS.DAT*KS.DAT***********************************************
//*************************************************************************************************************************

   //leggo il file ks.dat come spiegato sotto, per vedere cosa c'è prima di fare la procedura di restart
   printf("->FILE KS.DAT\n\n");
   if ((cfPtr=fopen("ks.dat","rb"))==NULL) printf("File ks.dat non trovato\n");          
   else {                                                                          
         fread(&write,sizeof(struct writeData),1,cfPtr);                             
          printf("Attualmente: %d %d %d %d %d %d %d _ %d _ %d _ %s _ %d _ %lf\n",write.codice[0],write.codice[1],write.codice[2],write.codice[3],write.codice[4],write.codice[5],write.codice[6],write.controllo,write.controllo_registrazione,write.reg,write.inutile,write.inutile2);                 
          printf("I mixer sono: %d %d %d %d %d %d %d %d %d\n",write.mixer1,write.mixer2,write.mixer3,write.mixer4,write.mixer5,write.mixer6,write.mixer7,write.mixer8,write.mixer9);
		  printf("Controlloic: %d %d %d %d %d %d %d\n",write.codice_controlloic[0],write.codice_controlloic[1],write.codice_controlloic[2],write.codice_controlloic[3],write.codice_controlloic[4],write.codice_controlloic[5],write.codice_controlloic[6]);
		  printf("La matrice e':\n\n");
		  for(z=0;z<10;z++){
							for(y=0;y<10;y++) printf("%d\t",write.matrice[z][y]);
							printf("\n\n");
						   }

		  printf("Nome pc originale: ");
          for(i=0;i<20;i++) printf("%d ",write.pcname[i]); 
          printf("\n\nPercorso originale: ");
          for(i=0;i<100;i++) if(write.path_codificato[i]!=0) printf("%d ",write.path_codificato[i]); //utilizzo dei numeri perchè mi sono accorto che è più comodo leggerli e salvarli, cos= uso stringhe convertite in array di interi contenenti il codice ascii delle lettere
          fclose(cfPtr);
         }    
    printf("\n**************************************************************************\n");
//*************************************************************************************************************************
//********************************REK.DLL*REK.DLL*REK.DLL*REK.DLL*REK.DLL*REK.DLL******************************************
//*************************************************************************************************************************
   //leggo il file rek.dll come spiegato sotto, per vedere cosa c'è prima di fare la procedura di restart
   printf("\n\n->FILE REK.DLL\n\n");
   if ((cfPtr=fopen("rek.dll","rb"))==NULL) printf("File rek.dll non trovato\n");     
   else {                                                                          
         fread(&writepc,sizeof(struct writepcData),1,cfPtr);  
		 printf("Nome PC: %s\n",writepc.nomepc_w);
		 printf("Controlloic: %d %d %d %d %d %d %d\n",writepc.codice_controlloic_w[0],writepc.codice_controlloic_w[1],writepc.codice_controlloic_w[2],writepc.codice_controlloic_w[3],writepc.codice_controlloic_w[4],writepc.codice_controlloic_w[5],writepc.codice_controlloic_w[6]);
		 printf("La matrice e':\n");
		 for(z=0;z<10;z++){
			               for(y=0;y<10;y++) printf("%d\t",writepc.matrice_w[z][y]);
							printf("\n\n");
						   }

		 printf("MD5: ");
		 for (i=0;i<16;i++) printf ("%02x", writepc.md5_w[i]);

         printf("\nSHA-1: ");
		 for (i=0;i<20;i++) printf ("%02x", writepc.sha1_w[i]); 
         fclose(cfPtr);
         }    
    printf("\n\n**************************************************************************\n");


//SCRITTURA RESET DE 2 FILE rek e ks
//*************************************************************************************************************************
//*********************************KS.DAT*KS.DAT*KS.DAT*KS.DAT*KS.DAT*KS.DAT***********************************************
//*************************************************************************************************************************
	//resetto il file rek.dll
   if ((cfPtr=fopen("ks.dat","rb+"))==NULL) printf("File ks.dat non trovato\n");  //apro file in scrittura
   else {
         for(i=0;i<7;i++) write.codice[i]=0;        //imposto valore di fabbrica 
		 for(i=0;i<7;i++) write.codice_controlloic[i]=0;        //imposto valore di fabbrica 
         write.mixer1=1;
         write.mixer2=4;
         write.mixer3=8;
         write.mixer4=5; 
         write.mixer5=1;
         write.mixer6=7;
         write.mixer7=0;
         write.mixer8=2;
         write.mixer9=10;         
         write.controllo=0;                         //imposto valore di fabbrica, perchè se tutti num sono 0/7=0 con resto t, ma devo fare 7-7=0=controllo, quindi 0 è il valore inziale
         write.inutile=12344;                       //imposto valore di fabbrica
         write.inutile2=-546.451405;                //imposto valore di fabbrica
         strcpy(write.reg,"jhfiusw");               //imposto valore di fabbrica
         strcpy(writepc.nomepc_w,"XX-123456789012");//imposto valore di fabbrica
         write.controllo_registrazione=22;           //imposto valore di fabbrica
         for(i=0;i<20;i++) write.pcname[i]=32;      //imposto valore di fabbrica (ho scelto una volre a caso che in ascii è lo spazio      
         for(i=0;i<100;i++) write.path_codificato[i]=61;   //imposto valore di fabbrica (ho scelto una volre a caso che in ascii è l'uguale  
		 for(z=0;z<10;z++) for(y=0;y<10;y++) write.matrice[z][y]=0; //resetto matrice
         fseek(cfPtr,0,SEEK_SET); 
         fwrite(&write,sizeof(struct writeData),1,cfPtr); //scrivo sul file i valori impostati prima come record
         fclose(cfPtr);                   //chiudo file
         printf("**************************************************************************\n");
         printf("*Ripristino informazioni a dati di fabbrica ks.dat avvenuto con successo**\n");
         printf("**************************************************************************\n");
        }   
   printf("**************************************************************************\n");      
    
 //*************************************************************************************************************************
//********************************REK.DLL*REK.DLL*REK.DLL*REK.DLL*REK.DLL*REK.DLL******************************************
//*************************************************************************************************************************
   //resetto il file rek.dll
   if ((cfPtr=fopen("rek.dll","rb+"))==NULL) printf("\n");       //apro file in scrittura
   else {                                                //imposto valore di fabbrica
         strcpy(writepc.nomepc_w,"XX-123456789012");                            //imposto valore di fabbrica
		 for(i=0;i<7;i++) writepc.codice_controlloic_w[i]=0;        //imposto valore di fabbrica 
		 for(z=0;z<10;z++) for(y=0;y<10;y++) writepc.matrice_w[z][y]=0;
		 for (i=0;i<16;i++) writepc.md5_w[i]=md5_fun[i];
		 for (i=0;i<20;i++) writepc.sha1_w[i]=sha1_fun[i];
         fseek(cfPtr,0,SEEK_SET); 
         fwrite(&writepc,sizeof(struct writepcData),1,cfPtr);                   //scrivo sul file i valori impostati prima come record
         fclose(cfPtr);                                                         //chiudo file
		 printf("**************************************************************************\n");
         printf("*Ripristino informazioni a dati di fabbrica rek.dll avvenuto con successo*\n");
         printf("**************************************************************************\n");
        }         
printf("\n\n");


//RILETTURA DE 2 FILE rek e ks dopo al reset
//*************************************************************************************************************************
//*********************************KS.DAT*KS.DAT*KS.DAT*KS.DAT*KS.DAT*KS.DAT***********************************************
//*************************************************************************************************************************

   //leggo il file ks.dat come spiegato sotto, per vedere cosa c'è prima di fare la procedura di restart
   printf("->FILE KS.DAT\n\n");
   if ((cfPtr=fopen("ks.dat","rb"))==NULL) printf("File ks.dat non trovato\n");          
   else {                                                                          
         fread(&write,sizeof(struct writeData),1,cfPtr);                             
          printf("Attualmente: %d %d %d %d %d %d %d _ %d _ %d _ %s _ %d _ %lf\n",write.codice[0],write.codice[1],write.codice[2],write.codice[3],write.codice[4],write.codice[5],write.codice[6],write.controllo,write.controllo_registrazione,write.reg,write.inutile,write.inutile2);                 
          printf("I mixer sono: %d %d %d %d %d %d %d %d %d\n",write.mixer1,write.mixer2,write.mixer3,write.mixer4,write.mixer5,write.mixer6,write.mixer7,write.mixer8,write.mixer9);
		  printf("Controlloic: %d %d %d %d %d %d %d\n",write.codice_controlloic[0],write.codice_controlloic[1],write.codice_controlloic[2],write.codice_controlloic[3],write.codice_controlloic[4],write.codice_controlloic[5],write.codice_controlloic[6]);
		  printf("La matrice e':\n\n");
		  for(z=0;z<10;z++){
							for(y=0;y<10;y++) printf("%d\t",write.matrice[z][y]);
							printf("\n\n");
						   }

		  printf("Nome pc originale: ");
          for(i=0;i<20;i++) printf("%d ",write.pcname[i]); 
          printf("\n\nPercorso originale: ");
          for(i=0;i<100;i++) if(write.path_codificato[i]!=0) printf("%d ",write.path_codificato[i]); //utilizzo dei numeri perchè mi sono accorto che è più comodo leggerli e salvarli, cos= uso stringhe convertite in array di interi contenenti il codice ascii delle lettere
          fclose(cfPtr);
         }    
    printf("\n***************************************************************************\n");
//*************************************************************************************************************************
//********************************REK.DLL*REK.DLL*REK.DLL*REK.DLL*REK.DLL*REK.DLL******************************************
//*************************************************************************************************************************
   //leggo il file rek.dll come spiegato sotto, per vedere cosa c'è prima di fare la procedura di restart
   printf("\n\n->FILE REK.DLL\n\n");
   if ((cfPtr=fopen("rek.dll","rb"))==NULL) printf("File rek.dll non trovato\n");     
   else {                                                                          
         fread(&writepc,sizeof(struct writepcData),1,cfPtr);  
		 printf("Nome PC: %s\n",writepc.nomepc_w);
		 printf("Controlloic: %d %d %d %d %d %d %d\n",writepc.codice_controlloic_w[0],writepc.codice_controlloic_w[1],writepc.codice_controlloic_w[2],writepc.codice_controlloic_w[3],writepc.codice_controlloic_w[4],writepc.codice_controlloic_w[5],writepc.codice_controlloic_w[6]);
		 printf("La matrice e':\n");
		 for(z=0;z<10;z++){
			               for(y=0;y<10;y++) printf("%d\t",writepc.matrice_w[z][y]);
							printf("\n\n");
						   }

		 printf("MD5: ");
		 for (i=0;i<16;i++) printf ("%02x", writepc.md5_w[i]);

         printf("\nSHA-1: ");
		 for (i=0;i<20;i++) printf ("%02x", writepc.sha1_w[i]); 
         fclose(cfPtr);
         }    
   printf("\n\n");
system("PAUSE");
return 0;
}