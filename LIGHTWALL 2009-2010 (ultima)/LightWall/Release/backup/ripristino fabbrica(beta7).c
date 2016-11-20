#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <strings.h>

//QUESTO SERVE PER RIPRISTINARE I FILE ALLA CONFIGURAZIONE DI FABBRICA, CIOE' COME SI PRESENTANO SUBITO DOPO L'INSTALLAZIONE
//BETA 7 funziona solo da beta 15.7 perchè qui è cambiata la struttura del file ks.dat inoltre ho ottmizzato anche questo programma togliendo 2 strutture inutili per la lettura
//per errore non ho tenuto la beta 6, ma per rifarla basta solo togliere dalla struttura writedata tutti i mixer e il gioco è fatto. non cambia assolutamente nulla


struct writeData{   //record per scrivere sul file, con acctname fissato ad 1, mentre i campi inutili  non servono a nulla, fa solo confusione per chi cercasse di cracckare
       int codice[7];
       int controllo;  //questa cifra è uan cifra di controlo ottenuta dall'algoritmo che crea il codice isbn (vedi wikipedia), io lo uso qui per rendere ancora più difficile la modifica del file licenza(quella.dat)
       int mixer1;
	   char reg[5];
	   int mixer2; //sono variabili che fanno incasinare (mescolare) i dati nel file, così è difficile capire quali sono dati utili e soprattutto uso questi dati per fare controlli su integrità file(sblocco licenza)
       int inutile;    //gli INUTILI ssono davvero inutili, rendono la comrpesione del file licenza più difficile, quindi è un bene perchè si impedisce la modifica di dati delicati
       int mixer3;
	   int mixer4;
	   double inutile2;
	   int pcname[20];
	   int mixer5;
	   int path_codificato[100];
	   int mixer6;
	   int controllo_registrazione; //variabile che serve solo a far si che non venga più richiesta la scelta della modalità di registrazione se già registrato
	   int mixer7;
	   int codice_controlloic[7];
	   int mixer8;
	   int mixer9;        
};        

struct writepcData{  //recordo per scrivere pc
       char nomepc_w[20];
};        
  

int main(){
   FILE *cfPtr;  
   int i;
                                                               
   struct writeData write={{0,0,0,0,0,0,0},0,0,"",0,0,0,0,0.0,{0},0,{0},0,0,0,{0},0,0};  //imposto valori standard nella struttura   
   struct writepcData writepc={""};                                                      
                                               
//prima di tutto scrivo i mixer1->mixer9 nel record. questi ci rimarrano sempre. questi dati li modifico solo qui. Dopo li leggerò soltanto
write.mixer1=-1;
write.mixer2=4;
write.mixer3=8;
write.mixer4=5;
write.mixer5=1;
write.mixer6=-7;
write.mixer7=0;
write.mixer8=2;
write.mixer9=10;                                            
                                               
                                                  
   printf("***BENVENUTO NEL RESTARTER DI LIGHTWALL***\n\n");
   printf("Con questo file si puo' ripristinare il file principale ai valori iniziali\n\n");
   
   if ((cfPtr=fopen("ks.dat","rb"))==NULL) printf("File nn trovato\n");          //leggo i file come spiegato sotto, per vedere cosa c'è prima di fare la procedura di restart
   else {                                                                          
         fread(&write,sizeof(struct writeData),1,cfPtr);                             
          printf("Attualmente: %d %d %d %d %d %d %d _ %d _ %d _ %s _ %d _ %lf\n\n",write.codice[0],write.codice[1],write.codice[2],write.codice[3],write.codice[4],write.codice[5],write.codice[6],write.controllo,write.controllo_registrazione,write.reg,write.inutile,write.inutile2);                 
          printf("Nome pc originale: ");
          for(i=0;i<15;i++) printf("%d ",write.pcname[i]); 
          printf("\n\nPercorso originale: ");
          for(i=0;i<100;i++) if(write.path_codificato[i]!=0) printf("%d ",write.path_codificato[i]); //utilizzo dei numeri perchè mi sono accorto che è più comodo leggerli e salvarli, cos= uso stringhe convertite in array di interi contenenti il codice ascii delle lettere
          fclose(cfPtr);
         }     
         printf("\n\n");
 
   if ((cfPtr=fopen("ks.dat","rb+"))==NULL) printf("File nn trovato\n");  //apro file
   else {
         for(i=0;i<7;i++) write.codice[i]=0;        //imposto valore di fabbrica 
         write.controllo=0;                         //imposto valore di fabbrica, perchè se tutti num sono 0/7=0 con resto t, ma devo fare 7-7=0=controllo, quindi 0 è il valore inziale
         write.inutile=12344;                       //imposto valore di fabbrica
         write.inutile2=-546.451405;                //imposto valore di fabbrica
         strcpy(write.reg,"jhfiusw");               //imposto valore di fabbrica
         strcpy(writepc.nomepc_w,"XX-123456789012");//imposto valore di fabbrica
         write.controllo_registrazione=22;           //imposto valore di fabbrica
         for(i=0;i<15;i++) write.pcname[i]=32;      //imposto valore di fabbrica (ho scelto una volre a caso che in ascii è lo spazio      
         for(i=0;i<100;i++) write.path_codificato[i]=61;   //imposto valore di fabbrica (ho scelto una volre a caso che in ascii è l'uguale      
         fseek(cfPtr,0,SEEK_SET); 
         fwrite(&write,sizeof(struct writeData),1,cfPtr); //scrivo sul file i valori impostati prima come record
         fclose(cfPtr);                   //chiudo file
         printf("***********************************************************************\n");
         printf("***Ripristino informazioni a dati di fabbrica avvenuto con successo****\n");
         printf("***********************************************************************\n");
        }   
   printf("***********************************************************************\n");      
   if ((cfPtr=fopen("ks.dat","rb"))==NULL) printf("File nn trovato\n");          //leggo file e stampo tutto
   else {                                                                          //uso %lf per stampare a schermo un double
         fread(&write,sizeof(struct writeData),1,cfPtr);                             //stampo epr far si che possa vedere effettivamente cosa ha fatto questo programma
         printf("******************************************************\n");
         printf("***Lettura file ripristinato avvenuta con successo****\n");
         printf("******************************************************\n\n");
          printf("Dati resettati: %d %d %d %d %d %d %d _ %d _ %d _ %s _ %d _ %lf\n\n",write.codice[0],write.codice[1],write.codice[2],write.codice[3],write.codice[4],write.codice[5],write.codice[6],write.controllo,write.controllo_registrazione,write.reg,write.inutile,write.inutile2);                 
          printf("Nome pc resettato: ");
          for(i=0;i<15;i++) printf("%d ",write.pcname[i]); 
          printf("\n\nPercorso resettato: ");
          for(i=0;i<100;i++) if(write.path_codificato[i]!=0) printf("%d ",write.path_codificato[i]); 
          fclose(cfPtr);
         }     
   
   
   //qui fa le operazioni di reset sul il file rek.dll, cioè quello col nome del pc in cui è stato avviato la prima volta
   if ((cfPtr=fopen("rek.dll","rb"))==NULL) printf("\n");          
   else {                                                                          
         fread(&writepc,sizeof(struct writepcData),1,cfPtr);                             
          printf("\n\nAttualmente sul file rek.dll: %s\n\n\n",writepc.nomepc_w);                 
          fclose(cfPtr);
         }     
   if ((cfPtr=fopen("rek.dll","rb+"))==NULL) printf("\n");       //apro file
   else {                                                //imposto valore di fabbrica
         strcpy(writepc.nomepc_w,"XX-123456789012");                            //imposto valore di fabbrica
         fseek(cfPtr,0,SEEK_SET); 
         fwrite(&writepc,sizeof(struct writepcData),1,cfPtr);                   //scrivo sul file i valori impostati prima come record
         fclose(cfPtr);                                                         //chiudo file
        }         
        
system("PAUSE");
return 0;
}
