#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <strings.h>

//QUESTO SERVE PER RIPRISTINARE I FILE ALLA CONFIGURAZIONE DI FABBRICA, CIOE' COME SI PRESENTANO SUBITO DOPO L'INSTALLAZIONE
//BETA 5, questo funziona molto bene e ho ottimizzato il codice. Aggiunta delle migliorie sul file licenza (questo si vede in LW, qui ho solo aggiunto le modifiche per il reset)

struct writeData{   //record per scrivere sul file, con acctname fissato ad 1, mentre il campo inutile(e anche inutile2) non serve a nulla, fa solo confusione per chi cercasse di cracckare
       int acctNum;
       int codice[7];     
       int controllo;
       char reg[5];       
       int inutile;
       double inutile2;
	   int pcname[20]; 
	   int path_codificato[100];   
       int controllo_registrazione;           
};      

struct readData{  //recordo per leggere
       int acctNum_l;
       int codice_l[7];
       int controllo_l;
       char reg_l[5];       
       int inutile_l;
       double inutile2_l;
	   int pcname_l[20];    
	   int path_codificato_l[100];   
	   int controllo_registrazione_l;        
};    

struct writepcData{  //recordo per scrivere pc
       int acctNum_pw;
       char nomepc_w[20];
};        

struct readpcData{  //recordo per leggere pc
       int acctNum_pr;
       char nomepc_r[20];
};     

int main(){
   FILE *cfPtr;  
   int i;
                                                               
   struct writeData write={0,{0,0,0,0,0,0,0},0,"",0,0.0,{0},{0},0};  //imposto valori standard nella struttura
   struct readData read={0,{0,0,0,0,0,0,0},0,"",0,0.0,{0},{0},0};    
   struct writepcData writepc={0,""};    
   struct readpcData readpc={0,""};                                                     
                                                  
   printf("***BENVENUTO NEL RESTARTER DI LIGHTWALL***\n\n");
   printf("Con questo file si puo' ripristinare il file principale ai valori iniziali\n\n");
   
   if ((cfPtr=fopen("ks.dat","rb"))==NULL) printf("File nn trovato\n");          //leggo i file come spiegato sotto, per vedere cosa c'è prima di fare la procedura di restart
   else {                                                                          
         fread(&read,sizeof(struct readData),1,cfPtr);                             
         // if(read.acctNum_l!=0) printf("Attualmente: %d _ %d %d %d %d %d %d %d _ %d _ %d _ %s _ %d _ %lf\n\n",read.acctNum_l,read.codice_l[0],read.codice_l[1],read.codice_l[2],read.codice_l[3],read.codice_l[4],read.codice_l[5],read.codice_l[6],read.controllo_l,read.controllo_registrazione_l,read.reg_l,read.inutile_l,read.inutile2_l);                 
         // printf("Nome pc originale: ");
         // for(i=0;i<15;i++) printf("%d ",read.pcname_l[i]); 
         // printf("\n\nPercorso originale: ");
       //  for(i=0;i<100;i++) if(read.path_codificato_l[i]!=0) printf("%d ",read.path_codificato_l[i]); //utilizzo dei numeri perchè mi sono accorto che è più comodo leggerli e salvarli, cos= uso stringhe convertite in array di interi contenenti il codice ascii delle lettere
          fclose(cfPtr);
         }     
         //printf("\n\n");
 
   if ((cfPtr=fopen("ks.dat","rb+"))==NULL) printf("File nn trovato\n");  //apro file
   else {
         write.acctNum=1;                           //imposto valore di fabbrica
         for(i=0;i<7;i++) write.codice[i]=0;        //imposto valore di fabbrica 
         write.controllo=0;                         //imposto valore di fabbrica, perchè se tutti num sono 0/7=0 con resto t, ma devo fare 7-7=0=controllo, quindi 0 è il valore inziale
         write.inutile=12344;                       //imposto valore di fabbrica
         write.inutile2=-546.451405;                //imposto valore di fabbrica
         strcpy(write.reg,"jhfiusw");               //imposto valore di fabbrica
         strcpy(writepc.nomepc_w,"XX-123456789012");//imposto valore di fabbrica
         write.controllo_registrazione=22;           //imposto valore di fabbrica
         for(i=0;i<15;i++) write.pcname[i]=32;      //imposto valore di fabbrica (ho scelto una volre a caso che in ascii è lo spazio      
         for(i=0;i<15;i++) write.path_codificato[i]=61;   //imposto valore di fabbrica (ho scelto una volre a caso che in ascii è l'uguale      
         fseek(cfPtr,(write.acctNum-1)*sizeof(struct writeData),SEEK_SET); 
         fwrite(&write,sizeof(struct writeData),1,cfPtr); //scrivo sul file i valori impostati prima come record
         fclose(cfPtr);                   //chiudo file
       //  printf("***********************************************************************\n");
      //   printf("***Ripristino informazioni a dati di fabbrica avvenuto con successo****\n");
       //  printf("***********************************************************************\n");
        }   
  // printf("***********************************************************************\n");      
   if ((cfPtr=fopen("ks.dat","rb"))==NULL) printf("File nn trovato\n");          //leggo file e stampo tutto
   else {                                                                          //uso %lf per stampare a schermo un double
         fread(&read,sizeof(struct readData),1,cfPtr);                             //stampo epr far si che possa vedere effettivamente cosa ha fatto questo programma
      //   printf("******************************************************\n");
      //   printf("***Lettura file ripristinato avvenuta con successo****\n");
      //   printf("******************************************************\n\n");
        //  if(read.acctNum_l!=0) printf("Dati resettati: %d _ %d %d %d %d %d %d %d _ %d _ %d _ %s _ %d _ %lf\n\n",read.acctNum_l,read.codice_l[0],read.codice_l[1],read.codice_l[2],read.codice_l[3],read.codice_l[4],read.codice_l[5],read.codice_l[6],read.controllo_l,read.controllo_registrazione_l,read.reg_l,read.inutile_l,read.inutile2_l);                 
      //   printf("Nome pc resettato: ");
      //    for(i=0;i<15;i++) printf("%d ",read.pcname_l[i]); 
       //   printf("\n\nPercorso resettato: ");
       //   for(i=0;i<100;i++) if(read.path_codificato_l[i]!=0) printf("%d ",read.path_codificato_l[i]); 
          fclose(cfPtr);
         }     
   
   
   //qui fa le operazioni di reset sul il file rek.dll, cioè quello col nome del pc in cui è stato avviato la prima volta
   if ((cfPtr=fopen("rek.dll","rb"))==NULL) printf("\n");          
   else {                                                                          
         fread(&readpc,sizeof(struct readpcData),1,cfPtr);                             
         // if(readpc.acctNum_pr!=0) printf("\n\nAttualmente sul file rek.dll: %d _ %s\n\n\n",readpc.acctNum_pr,readpc.nomepc_r);                 
          fclose(cfPtr);
         }     
   if ((cfPtr=fopen("rek.dll","rb+"))==NULL) printf("\n");       //apro file
   else {
         writepc.acctNum_pw=1;                                                  //imposto valore di fabbrica
         strcpy(writepc.nomepc_w,"XX-123456789012");                            //imposto valore di fabbrica
         fseek(cfPtr,(writepc.acctNum_pw-1)*sizeof(struct writepcData),SEEK_SET); 
         fwrite(&writepc,sizeof(struct writepcData),1,cfPtr);                   //scrivo sul file i valori impostati prima come record
         fclose(cfPtr);                                                         //chiudo file
        }         
        
system("PAUSE");
return 0;
}
