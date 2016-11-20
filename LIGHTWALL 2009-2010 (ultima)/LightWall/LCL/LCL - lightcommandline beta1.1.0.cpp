using namespace System;           //servono per le cose che faccio in c++
using namespace Microsoft::Win32; //servono per le cose che faccio in c++
//SOURCECODE BY KS89 (CAPPA STEFANO)
//BETA 1.1.0 SOURCECODE
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <openssl/sha.h>//essenziali per usare md5 e sha. Sono librerie di openssl da copiare nella cartella delle librerie di visual studio. Crecare stdio.h e nella cartella in cui si trova copiare dentro i 2 file
#include <openssl/md5.h>//attenzione è necessario che nella cartella dei file h in visual studio (dove installato) ci sia dentro la libreria openSSL. Copiare tutta la cartella dentro a quella con i file .h perchè funzioni
#include <string.h>
#include <malloc.h>
#include <vcclr.h> //serve solo per calcolare la lunghezza del percorso generato da environment::currentdirectory e per il nome pc

//VERSIONE BETA 1.1.0 di LCL compatibile solo da versione protezione lightwall beta 16.0.x e ripristino fabbrica beta8. 



//BUG NOTI
//- Il percorso salvato sui file e quello generato ogni volta da LightWall per qualche strano motivo non coincidono.
   //Forse è dovuto al fatto che il percorso generato non presenta un '\0' alla fine, che indica la fine della stringa.

//NELLA PROSSIMA VERSIONE
//Aggiungere qualche strumento che verifica la validità dei codici utente e licenza inseriti, in modo tale che le risposte abbiano valori ammessi ecc... Aggiungere controlli in generale per evitare brutte sorprese


//Miglioramenti rispetto versione 1.0.0
//-Aggiunta scrittura e generazione matrice essenziale per poter modificare le registrazioni. La versione 1.0.0 non era in grado di registrare il programma partendo dai file già generati.
//-Correzione bug:  (OK)
//-Miglioramento funzionalità  (OK)
//-Aggiunta codice errori L00x->Lxxx in modo tale da individuare il problema al volo. Codici errore messi con logica   (OK)
//-Sostituito messaggio "comando eseguito" con una printf che mostra i valori appena salvati nell'elemento della struttura  (OK)



//VERSIONE FUNZIONANTE. UNICO BUG SUL PERCORSO



//funzione che userò nel programma e dichiarata alla fine di tutto
void matrix_funzione(int matrix2[][10],int i,int codice[],char path[],int a1,int a2,int a3,int a4,int a5,int a6,int a7,int a8);//novità beta 1.1.0



//variabili per hash md5 e sha1, le dichiaro qui per usarle anche nella funziona seguente
unsigned char md5_fun[16],sha1_fun[20];
//FUNZIONE che dichiaro direttamente qui per poter usufruire dentro ad essa di variabili globalie  non e far si che queste variabili valgano anche nel programma
void hash_rex_dll_funzione(char path_fun[],char nomepc_fun[],int codice_fun[],int controllo_fun)
{
   //variabili per md5 e sha (versione semplice che verifica alcuni dati e scrive il codice dentro il file rek.dll
   char stringa_hash[150]; //ci sono molte altre variabili sparse per il programma
   int lungh_hash,ind=0;
   unsigned char buffer_md5[16],buffer_sha[20];	// i buffer devono essere unsigned char, mettere solo char causa un problema nella stampa
   MD5_CTX md5;// allora la struttura che contiene informazioni sugli hash
   SHA_CTX sha;// allora la struttura che contiene informazioni sugli hash

   //inizio procedura per salvare md5 e sha1 nel file rek
   strcpy(stringa_hash,path_fun);//copio in stringa_hash il percorso
   strcat (stringa_hash,nomepc_fun);//concateno alla stringa_hash anche il nome pc
   lungh_hash=strlen(nomepc_fun)+strlen(path_fun);//calcolo lunghezza della nuova stringa data da concatenazione del percorso e nome pc
   for(ind=0;ind<7;ind++) stringa_hash[ind+lungh_hash]=(char)(codice_fun[ind]+48);//aggiungo codice utente alla stringa come carattere
   stringa_hash[ind+lungh_hash]=(char)(controllo_fun+48);//aggiungo codice di controllo del codice alla stringa
   stringa_hash[ind+lungh_hash+1]='\0';//importante mettono alla fine dell'array di char il carattere \0 per terminarlo e poterlo trattare come una stringa

   // inizializza le strutture
   MD5_Init (&md5);
   SHA1_Init(&sha);

   // calcola l'hash della stringa in input
   MD5_Update (&md5, (unsigned char *) stringa_hash, strlen(stringa_hash));
   SHA1_Update(&sha, (unsigned char *) stringa_hash, strlen(stringa_hash));

   // calcola l'hash finale
   MD5_Final (buffer_md5, &md5);
   SHA1_Final (buffer_sha, &sha);

   for (ind=0;ind<16;ind++) md5_fun[ind]=buffer_md5[ind];
   for (ind=0;ind<20;ind++) sha1_fun[ind]=buffer_sha[ind];
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

struct licenseData{     //record per scrivere file di licenza come backup. Questo ha l'aggiunta di informazioni personali, come la mail e nome e cognome e società a cui è intestata
       int codice_x[7];
       int controllo_x;
       char nome_x[30];
       char cogn_x[30];
       char soc_x[30];
       char mail_x[30];
       char reg_x[5];
       int inutile_x;
       double inutile2_x;
	   int num_domanda_x;
	   int domanda_x[50]; //uso un vettore bello grosso per stare certo che riesca a mettere dentro le risposte
};   

struct activate_licData{  //record per scrivere sul file, con acctname fissato ad 1, mentre i campi inutili  non servono a nulla, fa solo confusione per chi cercasse di cracckare
       int codice_dat[7];
       int controllo_dat;  
	   int codice_a0;
       int codice_a2;
	   int controllo_a;  //questa cifra è uan cifra di controlo ottenuta dall'algoritmo che crea il codice isbn (vedi wikipedia), io lo uso qui per rendere ancora più difficile la modifica del file licenza(quella.dat)
	   int codice_a6;
       char reg_a[5];
	   int codice_a1;
       int inutile_a;    //gli INUTILI ssono davvero inutili, rendono la compresione del file licenza più difficile, quindi è un bene perchè si impedisce la modifica di dati delicati
       double inutile2_a;
	   int codice_a3;
	   int pcname_a[20];
	   int codice_a4;
	   int controllo_registrazione_a; //variabile che serve solo a far si che non venga più richiesta la scelta della modalità di registrazione se già registrato
	   int codice_a5;
	   int codice_controlloic_a[7];
}; 

struct writepcData{  //record per scrivere nome pc
       char nomepc_w[20];
	   int codice_controlloic_w[7];
	   unsigned char md5_w[16]; //md5 e sha1 composti da percorso + nome pc  + codice + controllo
	   unsigned char sha1_w[20];
	   int matrice_w[10][10];
};        

struct pathWData{  //record per scrivere percorso
       char path_pathW[100];
	   int codice_controlloic_pathW[7];
	   int cont_licenza; //nascondo in questo file per non doverne usare un'altro il numero che conta quante volte ho sbagliato la domanda per l'attivazione licenza
	   int matrice_pathW[10][10];
};        

//file usati
//ks.dat = ha la registrazione corrente per far andare il programma
//license.lic ha la registrazione per far andare il prog in altro pc. Però questo file cmq genera un file ks.dat con dentro il tutto per andare
//lic.dat contiene numero licenza, e quindi serve per l'attivazione della licenza stessa e viene creato da zero dal programma
//irr.dat ha dentro il percorso
//rek.dll ha dentro il nome dell'utente, gli md5 e sha1

//i file che hanno dentro la matrice sono: irr,rek e ks

int main(){
//*****************************************************inizio dichiarazione varibili***************************************************************
   FILE *cfPtr;    //puntatore al file, essenziale per funzionare

   char scelta[200],struttura[15],comando[40],valore[100];
   int punto1=0,punto2=0,test=0,i=0,j=0,y=0,lunghezza=0,z=0,lun=0;
   int decimigliaia=0,migliaia=0,centinaia=0,decine=0,unita=0;   
 
   //variabili per matrice
   int matrix2[10][10]={{0},{0}},matrix[10][10]={{0},{0}},matrix3[10][10]={{0},{0}};

  //variabili per vedere se codice sha e md5 sono corretti. Se sha=20 e md5=16 allora sono corretti, se no no. Ps se i percorsi file o nome utente sono diversi non esegue nemmeno il controllo, li pongo direttamente a 99 così sono sicuro che mi da l'errore di manomissione
    int indsha=0,indmd5=0; //ce ne sono molte altre, ma sono locali dentro alla funzione dichiarata sopra oppure addirittura in mezzo al main

//*******************************************************fine dichiarazione varibili***************************************************************


//inizializzazzione delle strutture a 0 e "" per sicurezza e contemporaneamente le rinomino da writeData a write ecc... come se facessi un typedef(sinonimo)
struct writeData write={0,{0,0,0,0,0,0,0},0,0,0,"",0,0,0,0.0,{0},"",{0},0,{0},0,0,0,0};  //imposto valori standard nella struttura
struct licenseData license={{0,0,0,0,0,0,0},0,"","","","","",0,0.0,0,0,{0}};   
struct activate_licData activate;     //qui non inzializzo ma dichiaro solo il nome activate!. Volendo potrei anche inziializzare
struct writepcData writepc={"",{0}};  //record che uso per il nome del computer
struct pathWData pathW={"",{0},0};    //record che uso per il percorso dell'eseguibile



printf("         *************************************************************\n");
printf("         *..::Benvenuto in LIGHT COMMAND LINE BETA 1.1.0 by ks89!::..*\n");
printf("         *************************************************************\n\n");

while(strcmp(scelta,"quit")!=0 && strcmp(scelta,"exit")!=0)
{
  printf("\n>> ");
  for(i=0;i<15;i++) scelta[i]=(int)0;
  for(i=0;i<15;i++) struttura[i]=(int)0;
  for(i=0;i<40;i++) comando[i]=(int)0;
  for(i=0;i<100;i++) valore[i]=(int)0;
  gets(scelta);

  //da fare in funziona che accetta scelta e butta fuori la variabile PUNTO
  lunghezza=strlen(scelta);
  i=0;
  for(i=0;i<lunghezza;i++)
	{
	  if(scelta[i]=='.') test=i;
	  if(test!=0 && scelta[i+1]=='.') { punto1=test;
										punto2=i+1;
	                                  }
	}
  //campo struttura
  for(i=0;i<punto1;i++) struttura[i]=scelta[i];
  struttura[punto1]='\0';
  //campo comando
  z=0;
  while(i<punto2-1)
  {
	  comando[z]=scelta[i+1];
	  z++;
	  i++;
  }
  comando[z]='\0';
  //campo valore
  z=0;
  i++;
  while(i<lunghezza-1)
  {
	  valore[z]=scelta[i+1];
	  z++;
	  i++;
  }


//**********************************************************************************************************************************************************
//*****************************************************************************WRITE************************************************************************
//**********************************************************************************************************************************************************
 
  //procedura che dalla struttura in base al comando scrive il valore in writepc.   cioè file rek.dll
  if(strcmp(struttura,"writepc")==0)
  {
	  if(strcmp(comando,"pcname")==0) {						
										lun=strlen(valore);
										for(i=0;i<lun;i++) writepc.nomepc_w[i]=valore[i];
										writepc.nomepc_w[lun]='\0';
										for(i=0;i<100;i++) valore[i]=(int)0;
										printf("\n***NomePC: %s***\n",writepc.nomepc_w);
									  }

	  if(strcmp(comando,"controlloic")==0) {
											for(i=0;i<7;i++) writepc.codice_controlloic_w[i]=(int)valore[i]-48;
											printf("\n***Controlloic: ");
											for(i=0;i<7;i++) printf("%d ",writepc.codice_controlloic_w[i]);
											printf("***\n");
											}
	  if(strcmp(comando,"hash")==0) {
									  printf("\n Guida all'utilizzo: \n");
									  printf("\n Prima di poterla usare inserire il percorso in pathW, nome pc in nomepc e controllo in write.controllo, e quindi il codice\n\n");
									  printf("\nOppure inserire view.ks.1 e far si che le strutture si carichino con i dati del file\n");
									  hash_rex_dll_funzione(pathW.path_pathW,writepc.nomepc_w,write.codice,write.controllo);//funziona per calcolare hash e scriverlo su rek.dll
									  for(i=0;i<20;i++) writepc.sha1_w[i]=sha1_fun[i];
									  for(i=0;i<16;i++) writepc.md5_w[i]=md5_fun[i];
									  printf("\n***MD5: ");//stampa l'MD5
									  for (i=0;i<16;i++) printf ("%02x", writepc.md5_w[i]);
									  printf("***\n***SHA-1: ");//stampa dello SHA-1
									  for (i=0;i<20;i++) printf ("%02x", writepc.sha1_w[i]);
									  printf("***\n");
									}							
  }

  //procedura che dalla struttura in base al comando scrive il valore in pathW.  CIoè file irr.dat
  if(strcmp(struttura,"pathw")==0)
  {
	  if(strcmp(comando,"path")==0){							
		  							lun=strlen(valore);
		  							for(i=0;i<lun;i++) pathW.path_pathW[i]=valore[i];
		  							pathW.path_pathW[lun]='\0';
		  							for(i=0;i<100;i++) valore[i]=(int)0;	
									for(i=0;i<100;i++) valore[i]=(int)0;
									printf("\n***PathW: %s***\n",pathW.path_pathW);
								   }

	  if(strcmp(comando,"controlloic")==0) {
											for(i=0;i<7;i++) pathW.codice_controlloic_pathW[i]=(int)valore[i]-48;
											printf("\n***Controlloic: ");
											for(i=0;i<7;i++) printf("%d ",pathW.codice_controlloic_pathW[i]);
											printf("***\n");
										   }
	  if(strcmp(comando,"cont_licenza")==0) {
											  pathW.cont_licenza=(int)valore[0]-48;
											  printf("\n***Cont_licenza: %d***\n",pathW.cont_licenza);
											}
  }

  //procedura che dalla struttura in base al comando scrive il valore in write.
  if(strcmp(struttura,"write")==0)
  {
	  if(strcmp(comando,"codice")==0) {
										for(i=0;i<7;i++) write.codice[i]=(int)valore[i]-48;
										printf("\n***");
										for(i=0;i<7;i++) printf("%d",write.codice[i]);
										printf("***\n");
									  }
	  if(strcmp(comando,"controllo")==0) {
										   //qui mettere il codice e da quello crea il controllo e salva anche il codice
										   for(i=0;i<7;i++) write.codice[i]=(int)valore[i]-48;
										   write.controllo=7-(((write.codice[0]*6)+(write.codice[1]*5)+(write.codice[2]*4)+(write.codice[3]*3)+(write.codice[4]*2))%7);
										   printf("\n***Controllo: %d***\n",write.controllo);
	                                     }
	  if(strcmp(comando,"reg")==0) {
									strcpy(write.reg,valore);
									printf("\n***Reg: %s***\n",write.reg);
								   }
	  if(strcmp(comando,"inutile")==0) {
										 decimigliaia=(int)valore[0]-48;
										 migliaia=(int)valore[1]-48;
										 centinaia=(int)valore[2]-48;
										 decine=(int)valore[3]-48;
										 unita=(int)valore[4]-48;
										 write.inutile=unita+(decine*10)+(centinaia*100)+(migliaia*1000)+(decimigliaia*10000);
										 printf("\n***Inutile: %d***\n",write.inutile);
									   }

	  if(strcmp(comando,"inutile2")==0) {
										  if(valore[0]=='n') write.inutile2=-546.421405;
										  if(valore[0]=='y') write.inutile2=-546.451405;
										  printf("\n***Inutile2: %f***\n",write.inutile2);
	                                    }
										  
	  if(strcmp(comando,"pcname")==0) {
								
										lun=strlen(valore);
										for(i=0;i<20;i++) write.pcname[i]=(int)32;
										for(i=0;i<lun;i++) write.pcname[i]=(int)valore[i];
										for(i=0;i<100;i++) valore[i]=(int)0;
										printf("\n***Pcname: ");
										for(i=0;i<20;i++) printf("%d ",write.pcname[i]);
										printf("***\n");
	                                  }

	  if(strcmp(comando,"space")==0) {
										strcpy(write.space,valore);
										printf("\n***Space: %s***\n",write.space);
									 }
	  if(strcmp(comando,"path")==0) {
									  lun=strlen(valore);
									  for(i=0;i<100;i++) write.path_codificato[i]=(int)61;
									  for(i=0;i<lun;i++) write.path_codificato[i]=(int)valore[i];
									  for(i=0;i<100;i++) valore[i]=(int)0;
									  printf("\n***Path: ");
									  for(i=0;i<20;i++) printf("%d ",write.path_codificato[i]);
									  printf("***\n");
	                                 }
	  if(strcmp(comando,"controllo_registrazione")==0) {
														decine=(int)valore[0]-48;
														unita=(int)valore[1]-48;
														write.controllo_registrazione=(decine*10)+unita;
														printf("\n***Contr_registraz: %d***\n",write.controllo_registrazione);
	                                                   }
	  if(strcmp(comando,"controlloic")==0) {
											  for(i=0;i<7;i++) write.codice_controlloic[i]=(int)valore[i]-48;
											  printf("\n***Controlloic: ");
											  for(i=0;i<7;i++) printf("%d ",write.codice_controlloic[i]);
											  printf("***\n");
										   }
	  if(strcmp(comando,"mixer")==0){
		                             write.mixer1=valore[0]-48;
									 write.mixer2=valore[1]-48;
									 write.mixer3=valore[2]-48;
									 write.mixer4=valore[3]-48;
									 write.mixer5=valore[4]-48;
									 write.mixer6=valore[5]-48;
									 write.mixer7=valore[6]-48;
									 write.mixer8=valore[7]-48;
									 decine=(int)valore[8]-48;
								     unita=(int)valore[9]-48;
									 write.mixer9=(decine*10)+unita;
									 printf("\n***Mixer: %d %d %d %d %d %d %d %d %d***\n",write.mixer1,write.mixer2,write.mixer3,write.mixer4,write.mixer5,write.mixer6,write.mixer7,write.mixer8,write.mixer9);
									}
  }



  //procedura che dalla struttura in base al comando scrive il valore in license.
  if(strcmp(struttura,"lic")==0)
  {
	  if(strcmp(comando,"codice_dat")==0) {
										for(i=0;i<7;i++) activate.codice_dat[i]=write.codice[i];
										printf("\nPerchè funzioni definire prima write.codice\n***");
										for(i=0;i<7;i++) printf("%d ",activate.codice_dat[i]);
										printf("***\n");
									  }
	  if(strcmp(comando,"controllo_dat")==0) {
												for(i=0;i<7;i++) activate.codice_dat[i]=(int)valore[i]-48;
												activate.controllo_dat=7-(((activate.codice_dat[0]*6)+(activate.codice_dat[1]*5)+(activate.codice_dat[2]*4)+(activate.codice_dat[3]*3)+(activate.codice_dat[4]*2))%7);   //è 1 se il codice di controllo è ok. 
												printf("\n***Controllo_dat: %d***\n",activate.controllo_dat);
											 }
	  if(strcmp(comando,"reg")==0) {
									  strcpy(activate.reg_a,valore); //1234667 vuol dire registrato
									  printf("\n***Reg: %s***\n",activate.reg_a);
								   }
	  if(strcmp(comando,"inutile")==0) {
										 decimigliaia=(int)valore[0]-48;
										 migliaia=(int)valore[1]-48;
										 centinaia=(int)valore[2]-48;
										 decine=(int)valore[3]-48;
										 unita=(int)valore[4]-48;
										 activate.inutile_a=unita+(decine*10)+(centinaia*100)+(migliaia*1000)+(decimigliaia*10000);
										 printf("\n***Inutile: %d***\n",activate.inutile_a);
									   }

	  if(strcmp(comando,"inutile2")==0) {
										  if(valore[0]=='n') activate.inutile2_a=-546.421405;
										  if(valore[0]=='y') activate.inutile2_a=-546.451405;
										  printf("\n***Inutile2: %d***\n",activate.inutile2_a);
	                                    }
												
	  if(strcmp(comando,"pcname")==0) {							
										lun=strlen(valore);
										for(i=0;i<20;i++) activate.pcname_a[i]=(int)32;
										for(i=0;i<lun;i++) activate.pcname_a[i]=(int)valore[i];
										for(i=0;i<100;i++) valore[i]=(int)0;
										printf("\n***Pcname:");
										for(i=0;i<20;i++) printf("%d ",activate.pcname_a[i]);
										printf("***\n");
	                                  }

	  if(strcmp(comando,"controllo_registrazione")==0) {
														decine=(int)valore[0]-48;
														unita=(int)valore[1]-48;
														activate.controllo_registrazione_a=(decine*10)+unita;
														printf("\n***Controllo_reg: %d***\n",activate.controllo_registrazione_a);
	                                                   }
	  if(strcmp(comando,"controlloic")==0) {
											  for(i=0;i<7;i++) activate.codice_controlloic_a[i]=(int)valore[i]-48;
											  printf("\n***Controlloic: ");
											  for(i=0;i<7;i++) printf("%d ",activate.codice_controlloic_a[i]);
											  printf("***\n");
										   }

	  if(strcmp(comando,"codice_a")==0) { 
												printf("\nAssicurarsoi di aver eseguito questo comando solo dopo aver definito il write.codice e write.controllo\n");
												//mettere il codice che su vuole, tanto poi LCL modifica creando quello giusto perchè poi funzioni tutto
												activate.codice_a2=(int)valore[2]-48;   
												activate.codice_a4=(int)valore[4]-48; 
												activate.codice_a3=(int)valore[3]-48; 
												activate.codice_a5=write.codice[5];     //questa è la versione di windows
												activate.codice_a6=write.codice[6];     //anche qui
												activate.codice_a0=(((rand() % 9)*3)/(activate.codice_a2+activate.codice_a3-1))%9;
												activate.codice_a1=8-(((activate.codice_a0*7)+(activate.codice_a2*6)+(activate.codice_a3*5)+(activate.codice_a4*4)+(activate.codice_a5*3)+(activate.codice_a6*2))%8);
												printf("\n***Codice_licenza: %d %d %d %d %d %d %d***\n",activate.codice_a0,activate.codice_a1,activate.codice_a2,activate.codice_a3,activate.codice_a4,activate.codice_a5,activate.codice_a6);
											  }
	  if(strcmp(comando,"controllo_a")==0) {
										   //qui mettere il codice e da quello crea il controllo e salva anche il codice
										   for(i=0;i<7;i++) activate.codice_dat[i]=write.codice[i];
										   activate.controllo_a=7-(((activate.codice_a0*6)+(activate.codice_a1*5)+(activate.codice_a2*4)+(activate.codice_a3*3)+(activate.codice_a4*2))%7);
										   printf("\n***Controllo: %d***\n",activate.controllo_a);
	                                     }
  }


//procedura che dalla struttura in base al comando scrive il valore in license.
if(strcmp(struttura,"license")==0)
{
	if(strcmp(comando,"nome")==0) {
									strcpy(license.nome_x,valore);
									printf("\n***Nome: %s***\n",license.nome_x);
								  }
	if(strcmp(comando,"cogn")==0) {
									strcpy(license.cogn_x,valore);
									printf("\n***Cognome: %s***\n",license.cogn_x);
								  }
	  if(strcmp(comando,"soc")==0) {
									strcpy(license.soc_x,valore);
									printf("\n***Societa': %s***\n",license.soc_x);
								   }
	  if(strcmp(comando,"mail")==0) {
									strcpy(license.mail_x,valore);
									printf("\n***e-Mail: %s***\n",license.mail_x);
								   }
	  if(strcmp(comando,"reg")==0) {
									strcpy(license.reg_x,valore);
									printf("\n***Reg: %s***\n",license.reg_x);
								   }

	  if(strcmp(comando,"inutile")==0) {
										 decimigliaia=(int)valore[1]-48;
										 migliaia=(int)valore[2]-48;
										 centinaia=(int)valore[3]-48;
										 decine=(int)valore[4]-48;
										 unita=(int)valore[5]-48;
										 license.inutile_x=unita+(decine*10)+(centinaia*100)+(migliaia*1000)+(decimigliaia*10000);
										 printf("\n***Inutile: %d***\n",license.inutile_x);
									   }

	  if(strcmp(comando,"inutile2")==0) {
										 if(valore[0]=='n') license.inutile2_x=-546.421405;
										 if(valore[0]=='y') license.inutile2_x=-546.451405;
										 printf("\n***Inutile2: %f***\n",license.inutile2_x);
	                                    }

	  if(strcmp(comando,"num_domanda")==0) {
											 license.num_domanda_x=(int)valore[0]-48;
											 printf("\n***Num_domanda: %d***\n",license.num_domanda_x);
										   }

	  if(strcmp(comando,"domanda")==0) {
										 for(i=0;i<100;i++) license.domanda_x[i]=(char)valore[i];
										 printf("\n***Domanda: %s***\n",license.domanda_x);
									   }

	  //procedura per la generazione della matrice su tutti i file contemporaneamente
	  if(strcmp(comando,"matrice")==0) {    //attenzione, la matrice viene genrata uguale sempre per tutti i file. in questa versione on è generabile in modo diverso
										//*********************algoritmo matrix*************************
										printf("\nFunziona solo dopo aver fatto un view.all.1\n");
										matrix_funzione(matrix2,i,write.codice,writepc.nomepc_w,activate.codice_a0,activate.codice_a1,activate.codice_a2,activate.codice_a3,activate.codice_a4,activate.codice_a5,activate.codice_a6,activate.controllo_a);  //questa è quella che viene scritta sui file alla prima generazione!!
                       		
										//qui avviene la scrittura. Ho già testato e sembra che scriva giusto
										for(i=0;i<10;i++) for(j=0;j<10;j++)
										{
											writepc.matrice_w[i][j]=matrix2[i][j];
											pathW.matrice_pathW[i][j]=matrix2[i][j];
											write.matrice[i][j]=matrix2[i][j];
											matrix[i][j]=matrix2[i][j];//questo lo faccio perchè la funzione agisce su variabile locale. Io copio tutto in una che voglio sfruttare anche dopo
										}
										//***************************************************************
									}
}
//**********************************************************************************************************************************************************
//**************************************************************************FINE WRITE**********************************************************************
//**********************************************************************************************************************************************************



//**********************************************************************************************************************************************************
//*****************************************************************************VIEW*************************************************************************
//**********************************************************************************************************************************************************
if(strcmp(struttura,"view")==0)
  { 
	  if(strcmp(comando,"all")==0)
	  {
		 printf("\n***Comando eseguito***\n");
		 if ((cfPtr=fopen("irr.dat","rb"))==NULL) printf("Errore L001\n");
		 else {
				fread(&pathW,sizeof(struct pathWData),1,cfPtr);
				fclose(cfPtr);
		 }
		 if ((cfPtr=fopen("lic.dat","rb"))==NULL) printf("Errore L002\n");
		 else {
				fread(&activate,sizeof(struct activate_licData),1,cfPtr);
				fclose(cfPtr);
		 }
		 if ((cfPtr=fopen("license.lic","rb"))==NULL) printf("Errore L003\n");
		 else {
				fread(&license,sizeof(struct licenseData),1,cfPtr);
				fclose(cfPtr);
		 }
		 if ((cfPtr=fopen("ks.dat","rb"))==NULL) printf("Errore L004\n");
		 else {
  				fread(&write,sizeof(struct writeData),1,cfPtr);
  				fclose(cfPtr);
  		 }
	     if ((cfPtr=fopen("rek.dll","rb"))==NULL) printf("Errore L005\n");
		 else {
  				fread(&writepc,sizeof(struct writepcData),1,cfPtr);
  				fclose(cfPtr);
  		 }
	  }


	  if(strcmp(comando,"irr")==0)
	  {
		  	printf("\n***In memoria su struttura per irr.dat***");
			printf("\nCodice_controlloic: ");
		  	for(i=0;i<7;i++) printf("%d",pathW.codice_controlloic_pathW[i]);
		  	printf("\nCont Licenza: %d\n",pathW.cont_licenza);
		  	printf("Percorso: %s\n",pathW.path_pathW);

		  	if ((cfPtr=fopen("irr.dat","rb"))==NULL) printf("Errore L006\n");
		  	else {
		  			fread(&pathW,sizeof(struct pathWData),1,cfPtr);
		  			fclose(cfPtr);
		  	}

		  	printf("\n***In memoria sul file irr.dat***");
		  	printf("\nIn memoria su struttura per irr.dat");
		  	printf("\nCodice_controlloic: ");
		  	for(i=0;i<7;i++) printf("%d",pathW.codice_controlloic_pathW[i]);
		  	printf("\nCont Licenza: %d\n",pathW.cont_licenza);
		  	printf("Percorso: %s\n",pathW.path_pathW);
	  }


	  if(strcmp(comando,"lic")==0)
	  {
		  	printf("\n***In memoria su struttura per lic.dat***");
			printf("\nCodice: ");
			for(i=0;i<7;i++) printf("%d",activate.codice_dat[i]);
			printf("\nControllo: %d\n",activate.controllo_dat); 
			printf("Codice_controlloic: ");
			for(i=0;i<7;i++) printf("%d",activate.codice_controlloic_a[i]);
			printf("\nReg: %s\n",activate.reg_a);
			printf("Inutile: %d\n",activate.inutile_a);
			printf("Inutile2: %f\n",activate.inutile2_a);
			printf("Nome pc originale: ");
			for(i=0;i<20;i++) printf("%d ",activate.pcname_a[i]); 
			printf("\nControllo_registrazione: %d",activate.controllo_registrazione_a);
			printf("\nCodice_a (licenza): %d %d %d %d %d %d %d\n",activate.codice_a0,activate.codice_a1,activate.codice_a2,activate.codice_a3,activate.codice_a4,activate.codice_a5,activate.codice_a6);

			if ((cfPtr=fopen("lic.dat","rb"))==NULL) printf("Errore L007\n");
			else {
					fread(&activate,sizeof(struct activate_licData),1,cfPtr);
					fclose(cfPtr);
			}
			printf("\n***In memoria sul file per lic.dat***");
			printf("\nCodice: ");
			for(i=0;i<7;i++) printf("%d",activate.codice_dat[i]);
			printf("\nControllo: %d\n",activate.controllo_dat); 
			printf("Codice_controlloic: ");
			for(i=0;i<7;i++) printf("%d",activate.codice_controlloic_a[i]);
			printf("\nReg: %s\n",activate.reg_a);
			printf("Inutile: %d\n",activate.inutile_a);
			printf("Inutile2: %f\n",activate.inutile2_a);
			printf("Nome pc originale: ");
			for(i=0;i<20;i++) printf("%d ",activate.pcname_a[i]); 
			printf("\nControllo_registrazione: %d",activate.controllo_registrazione_a);
			printf("\nCodice_a (licenza): %d %d %d %d %d %d %d\n",activate.codice_a0,activate.codice_a1,activate.codice_a2,activate.codice_a3,activate.codice_a4,activate.codice_a5,activate.codice_a6);


	  }   


	  if(strcmp(comando,"license")==0)
	  {
			printf("\n***In memoria su struttura per license.lic***");
			printf("\nCodice: ");
			for(i=0;i<7;i++) printf("%d",license.codice_x[i]);
			printf("\nControllo: %d\n",license.controllo_x);
			printf("Nome e cognome: %s %s\n",license.nome_x,license.cogn_x);
			printf("Societa': %s\n",license.soc_x);
			printf("E-Mail: %s\n",license.mail_x);
			printf("Reg: %s\n",license.reg_x);
			printf("Inutile: %d\n",license.inutile_x);
			printf("Inutile2: %f\n",license.inutile2_x);
			printf("Num domanda: %d\n",license.num_domanda_x);
			printf("Domanda: %s\n",license.domanda_x);



			if ((cfPtr=fopen("license.lic","rb"))==NULL) printf("Errore L008\n");
			else {
					fread(&license,sizeof(struct licenseData),1,cfPtr);
					fclose(cfPtr);
			}

			printf("\n***In memoria sul file license.lic***");
			printf("\nCodice: ");
			for(i=0;i<7;i++) printf("%d",license.codice_x[i]);
			printf("\nControllo: %d\n",license.controllo_x);
			printf("Nome e cognome: %s %s\n",license.nome_x,license.cogn_x);
			printf("Societa': %s\n",license.soc_x);
			printf("E-Mail: %s\n",license.mail_x);
			printf("Reg: %s\n",license.reg_x);
			printf("Inutile: %d\n",license.inutile_x);
			printf("Inutile2: %f\n",license.inutile2_x);
			printf("Num domanda: %d\n",license.num_domanda_x);
			printf("Domanda: %s\n",license.domanda_x);
	  }


	  if(strcmp(comando,"ks")==0)
	  {                                                                                 
			printf("\n***In memoria su struttura per ks.dat***");
			printf("\nCodice: ");
			for(i=0;i<7;i++) printf("%d",write.codice[i]);
			printf("\nControllo: %d\n",write.controllo);
			printf("Codice_controlloic: ");
			for(i=0;i<7;i++) printf("%d",write.codice_controlloic[i]);
			printf("\nReg: %s\n",write.reg);
			printf("Inutile: %d\n",write.inutile);
			printf("Inutile2: %f\n",write.inutile2);
			printf("Space: %s\n",write.space);
			printf("Nome pc originale: ");
			for(i=0;i<20;i++) printf("%d ",write.pcname[i]); 
			printf("\nPercorso originale: ");
			for(i=0;i<100;i++) if(write.path_codificato[i]!=0) printf("%d ",write.path_codificato[i]); //utilizzo dei numeri perchè mi sono accorto che è più comodo leggerli e salvarli, cos= uso stringhe convertite in array di interi contenenti il codice ascii delle lettere
			printf("\nControllo_registrazione: %d",write.controllo_registrazione);
			printf("\nMixer: %d %d %d %d %d %d %d %d %d\n",write.mixer1,write.mixer2,write.mixer3,write.mixer4,write.mixer5,write.mixer6,write.mixer7,write.mixer8,write.mixer9);

			if ((cfPtr=fopen("ks.dat","rb"))==NULL) printf("Errore L009\n");
			else {
					fread(&write,sizeof(struct writeData),1,cfPtr);
					fclose(cfPtr);
			}

			printf("\n***In memoria sul file ks.dat***");
			printf("\nCodice: ");
			for(i=0;i<7;i++) printf("%d",write.codice[i]);
			printf("\nControllo: %d\n",write.controllo);
			printf("Codice_controlloic: ");
			for(i=0;i<7;i++) printf("%d",write.codice_controlloic[i]);
			printf("\nReg: %s\n",write.reg);
			printf("Inutile: %d\n",write.inutile);
			printf("Inutile2: %f\n",write.inutile2);
			printf("Space: %s\n",write.space);
			printf("Nome pc originale: ");
			for(i=0;i<15;i++) printf("%d ",write.pcname[i]); 
			printf("\nPercorso originale: ");
			for(i=0;i<100;i++) if(write.path_codificato[i]!=0) printf("%d ",write.path_codificato[i]); //utilizzo dei numeri perchè mi sono accorto che è più comodo leggerli e salvarli, cos= uso stringhe convertite in array di interi contenenti il codice ascii delle lettere
			printf("\nControllo_registrazione: %d",write.controllo_registrazione);
			printf("\nMixer: %d %d %d %d %d %d %d %d %d\n",write.mixer1,write.mixer2,write.mixer3,write.mixer4,write.mixer5,write.mixer6,write.mixer7,write.mixer8,write.mixer9);

	  }

	  if(strcmp(comando,"rek")==0)
	  {                                                                                 
			printf("\n***In memoria su struttura per rek.dll***");
			printf("\nCodice_controlloic: ");
			for(i=0;i<7;i++) printf("%d",writepc.codice_controlloic_w[i]);
			printf("\nNome pc originale: %s\n",writepc.nomepc_w);
			printf("MD5: ");
			for (i=0;i<16;i++) printf ("%02x", writepc.md5_w[i]);
			printf("\nSHA-1: ");
			for (i=0;i<20;i++) printf ("%02x", writepc.sha1_w[i]); 

			if ((cfPtr=fopen("rek.dll","rb"))==NULL) printf("Errore L010\n");
			else {
  						fread(&writepc,sizeof(struct writepcData),1,cfPtr);
  						fclose(cfPtr);
			}

			printf("\n***In memoria sul file rek.dll***");
			printf("\nCodice_controlloic: ");
			for(i=0;i<7;i++) printf("%d",writepc.codice_controlloic_w[i]);
			printf("\nNome pc originale: %s\n",writepc.nomepc_w);
			printf("MD5: ");
			for (i=0;i<16;i++) printf ("%02x", writepc.md5_w[i]);
			printf("\nSHA-1: ");
			for (i=0;i<20;i++) printf ("%02x", writepc.sha1_w[i]); 
	  }
}
//**********************************************************************************************************************************************************
//*************************************************************************FINE VIEW************************************************************************
//**********************************************************************************************************************************************************





//**********************************************************************************************************************************************************
//***************************************************************************RESTORE************************************************************************
//**********************************************************************************************************************************************************
//Fase in cui avviene il ripsristino dei file Ks, Rek, lic ed irr
if(strcmp(struttura,"restore")==0)
{
	if(strcmp(comando,"ks")==0)
	{
		//resetto il file ks.dat
		printf("\n***Comando eseguito***\n");
		if ((cfPtr=fopen("ks.dat","rb+"))==NULL) printf("Errore L011\n");  //apro file in scrittura
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
	}


  	if(strcmp(comando,"rek")==0)
	{  
		//resetto il file rek.dll
		printf("\n***Comando eseguito***\n");
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
	}


	if(strcmp(comando,"lic")==0)
	{ 	
		//resetto il file rek.dll
		printf("\n***Comando eseguito***\n");
		if ((cfPtr=fopen("lic.dat","rb+"))==NULL) printf("Errore L012\n");  //apro file in scrittura
		else {
					for(i=0;i<7;i++) activate.codice_dat[i]=0;        //imposto valore di fabbrica 
					activate.controllo_dat=0;    
					for(i=0;i<7;i++) activate.codice_controlloic_a[i]=0;        //imposto valore di fabbrica 
					activate.codice_a0=0;
					activate.codice_a1=0;
					activate.codice_a2=0;
					activate.codice_a3=0; 
					activate.codice_a4=0;
					activate.codice_a5=0;
					activate.codice_a6=0;
					strcpy(activate.reg_a,"1234567");  //cioè non registrato     
					activate.controllo_a=0;                         //imposto valore di fabbrica, perchè se tutti num sono 0/7=0 con resto t, ma devo fare 7-7=0=controllo, quindi 0 è il valore inziale
					activate.inutile_a=12344;                       //imposto valore di fabbrica
					activate.inutile2_a=-546.451405;                //imposto valore di fabbrica
					activate.controllo_registrazione_a=22;           //imposto valore di fabbrica
					for(i=0;i<20;i++) activate.pcname_a[i]=32;      //imposto valore di fabbrica (ho scelto una volre a caso che in ascii è lo spazio      
					fseek(cfPtr,0,SEEK_SET); 
					fwrite(&activate,sizeof(struct activate_licData),1,cfPtr); //scrivo sul file i valori impostati prima come record
					fclose(cfPtr);                   //chiudo file
		}   
	}
}
//**********************************************************************************************************************************************************
//************************************************************************FINE RESTORE**********************************************************************
//**********************************************************************************************************************************************************








//**********************************************************************************************************************************************************
//*****************************************************************************SAVE*************************************************************************
//**********************************************************************************************************************************************************
if(strcmp(struttura,"save")==0)
  { 
	  if(strcmp(comando,"ks")==0){
									printf("\n***Comando eseguito***\n");
									if ((cfPtr=fopen("ks.dat","rb+"))==NULL) printf("Errore L013");  //apro file
									else {
			                        		fseek(cfPtr,0,SEEK_SET); 
			                        		fwrite(&write,sizeof(struct writeData),1,cfPtr); //scrivo sul file i valori impostati prima come record
			                        		fclose(cfPtr);                   //chiudo file
									     }   
	  }
	  if(strcmp(comando,"rek")==0){
									printf("\n***Comando eseguito***\n");
									if ((cfPtr=fopen("rek.dll","rb+"))==NULL) printf("Errore L014");  //apro file
									else {
			                        		fseek(cfPtr,0,SEEK_SET); 
			                        		fwrite(&writepc,sizeof(struct writepcData),1,cfPtr); //scrivo sul file i valori impostati prima come record
			                        		fclose(cfPtr);                   //chiudo file
									     }   
	  }
	  if(strcmp(comando,"lic")==0){
									printf("\n***Comando eseguito***\n");
									if ((cfPtr=fopen("lic.dat","rb+"))==NULL) printf("Errore L015");  //apro file
									else {
			                        		fseek(cfPtr,0,SEEK_SET); 
			                        		fwrite(&activate,sizeof(struct activate_licData),1,cfPtr); //scrivo sul file i valori impostati prima come record
			                        		fclose(cfPtr);                   //chiudo file
									     }   
	  }
	  if(strcmp(comando,"license")==0){
									printf("\n***Comando eseguito***\n");
									if ((cfPtr=fopen("license.lic","rb+"))==NULL) printf("Errore L016");  //apro file
									else {
			                        		fseek(cfPtr,0,SEEK_SET); 
			                        		fwrite(&license,sizeof(struct licenseData),1,cfPtr); //scrivo sul file i valori impostati prima come record
			                        		fclose(cfPtr);                   //chiudo file
									     }   
	  }
	  if(strcmp(comando,"irr")==0){
									printf("\n***Comando eseguito***\n");
									if ((cfPtr=fopen("irr.dat","rb+"))==NULL) printf("Errore L017");  //apro file
									else {
			                        		fseek(cfPtr,0,SEEK_SET); 
			                        		fwrite(&pathW,sizeof(struct pathWData),1,cfPtr); //scrivo sul file i valori impostati prima come record
			                        		fclose(cfPtr);                   //chiudo file
									     }   
	  }
  }
//**********************************************************************************************************************************************************
//**************************************************************************FINE SAVE***********************************************************************
//**********************************************************************************************************************************************************





}//chiudo il while
return 0;
}









//***********************************************************************************INIZIO FUNZIONI****************************************************************************************

void matrix_funzione(int matrix2[][10],int i,int codice[],char path[],int a1,int a2,int a3,int a4,int a5,int a6,int a7,int a8)
{
//precaricamento della matrice
int j=0;
int y=0,z=0;
//y sono le righe, z le colonne
srand( time( NULL) );

for(y=0;y<10;y++) for(z=0;z<10;z++) matrix2[y][z]=0;

matrix2[0][0]=codice[0];
matrix2[0][2]=codice[1];
matrix2[0][4]=codice[2];
matrix2[0][6]=codice[3];
matrix2[0][8]=codice[4];
matrix2[2][0]=codice[5];
matrix2[2][2]=codice[6];

matrix2[2][4]=path[0]-65;
matrix2[2][6]=path[0]-65;
matrix2[2][8]=path[0]-65;

matrix2[4][0]=codice[0];
matrix2[4][2]=codice[1];
matrix2[4][4]=codice[2];
matrix2[4][6]=codice[3];
matrix2[4][8]=codice[4];
matrix2[6][0]=codice[5];
matrix2[6][2]=a1;
matrix2[6][4]=a2;
matrix2[6][6]=a3;
matrix2[6][8]=a4;
matrix2[8][0]=a5;
matrix2[8][2]=a6;
matrix2[8][4]=a7;
matrix2[8][6]=a8;
matrix2[8][8]=2;

for(z=1;z<10;z=z+2) for(y=0;y<10;y++) matrix2[y][z]=0;

matrix2[0][9]=0;

for(y=0;y<10;y=y+2) for(z=0;z<9;z++) matrix2[y][9]=matrix2[y][9]+matrix2[y][z];
for(z=0;z<10;z=z+2) for(y=0;y<9;y++) matrix2[9][z]=matrix2[9][z]+matrix2[y][z];

y=2;
z=2;
while(y<10 && z<10) {
	matrix2[y-1][z-1]=matrix2[y-2][z-2]-matrix2[y][z];
	y=y+2;
	z=z+2;
}

y=2;
z=6;
while(y<10 && z>=0){
	matrix2[y-1][z+1]=matrix2[y-2][z+2]-matrix2[y][z];
	y=y+2;
	z=z-2;
}

for(z=0;z<9;z=z+2) for(y=1;y<8;y=y+2) matrix2[y][z]=matrix2[y-1][z]+matrix2[y+1][z];
for(z=1;z<8;z=z+2) for(y=0;y<10;y++) if(y!=1 && y!=7) matrix2[y][z]=2; //c'era rand() 9
for(y=1;y<9;y=y+2) matrix2[y][9]=matrix2[y-1][9]+matrix2[y+1][9];
matrix2[9][9]=8; //c'era rand() 9
j=0;

for(i=0;i<11;i++)  //qui calcolo occorrenze num da 0 a 10 e li metto sulla diag principale della matrice. Però ogni volta che cerco un numero, possono cambiare le variabili in gioco, perchè
//nel giro precedente è possibile che il numero scritto sulla diagonale vada a cancellare proprio il valore che sto cercando nel giro attuale, cambiando il risultato
//questa è una cosa voluta!!!!!! E' l'algoritmo che deve fare questo!!!
{
	for(y=0;y<10;y++) for(z=0;z<10;z++) if(matrix2[y][z]==i) j++;
	matrix2[i][i]=j;
	j=0;
}

printf("\n\n***************************************************\n\n");
for(z=0;z<10;z++){
			for(y=0;y<10;y++) printf("%d\t",matrix2[z][y]);
			printf("\n\n");
}
}