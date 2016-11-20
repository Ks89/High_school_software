using namespace System;           //servono per le cose che faccio in c++
using namespace Microsoft::Win32; //servono per le cose che faccio in c++
//SOURCECODE BY KS89 (CAPPA STEFANO)
//BETA 3.0.0 SOURCECODE
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <openssl/sha.h>//essenziali per usare md5 e sha. Sono librerie di openssl da copiare nella cartella delle librerie di visual studio. Cercare stdio.h e nella cartella in cui si trova copiare dentro i 2 file
#include <openssl/md5.h>//attenzione è necessario che nella cartella dei file h in visual studio (dove installato) ci sia dentro la libreria openSSL. Copiare tutta la cartella dentro a quella con i file .h perchè funzioni
#include <string.h>
#include <vcclr.h> //serve solo per calcolare la lunghezza del percorso generato da environment::currentdirectory e per il nome pc

//VERSIONE BETA 3.0.0 di LCL compatibile solo da versione protezione lightwall beta 17.3.2
//VERSIONE INNOVATIVA!!! AGGIUNTA E CORREZIONE DI TANTISSIME FUNZIONI. CORREZIONE BUG PERCORSO


//Miglioramenti rispetto versione 2.1.0
//-CORRETTO IL GRAVISSIMO BUG SUL PERCORSO, il problema era in lightwall. Ora è stato migliorato
//-Miglioramenti grafici vari
//-Correzione BUG vari, compreso uno sull'ora di scadenza e registrazione che non considerava i secondi per un errori di indice del valore[]
//-Test su le funzionalità
//-Aggiunta struttura simulate
//-Miglioramento gestione percorso, grazie alle modifiche effettuate in beta 17.3.3 importate poi anche in questo programma qui
//-Aggiunto e testato a fondo strumento simulate.complete.1 che fa delle domande e lui crea la registrazione nella memoria del programma.FA REGISTRAZIONE DAL NULLA
//-aggiunta strumento "auto" quando chiede pc o percorso in simulare.complete.1 per leggere il nome pc o percorso direttamente con c++ e salvarlo
//-Sostituiti tutti i rand() % 9 con rand()%10, perchè il primo da solo da 0 a 8, mentre quello dopo da anche il 9

//Prossime modifiche
//-Aggiungere qualche strumento che verifica la validità dei codici utente e licenza inseriti, in modo tale che le risposte abbiano valori ammessi ecc... Aggiungere controlli in generale per evitare brutte sorprese


//funzione che userò nel programma e dichiarata alla fine di tutto
void matrix_funzione(int matrix2[][10],int i,int codice[],char path[],int a1,int a2,int a3,int a4,int a5,int a6,int a7,int a8);//novità beta 1.1.0


//variabili per hash md5 e sha1, le dichiaro qui per usarle nelle funzioni seguenti
unsigned char md5_fun[16],sha1_fun[20];//per funziona rek,irr,ks,lic
unsigned char md5_fun2[16],sha1_fun2[20];//solo per funzione license.lic
//FUNZIONE che dichiaro direttamente qui per poter usufruire dentro ad essa di variabili globalie  non e far si che queste variabili valgano anche nel programma
void hash_rex_dll_funzione(char path_fun[],char nomepc_fun[],int codice_fun[],int controllo_fun,int controlloic_fun[])
{
   //variabili per md5 e sha (versione semplice che verifica alcuni dati e scrive il codice dentro il file rek.dll
   char stringa_hash[180]; //ci sono molte altre variabili sparse per il programma
   int lungh_hash,ind=0;
   unsigned char buffer_md5[16],buffer_sha[20];	// i buffer devono essere unsigned char, mettere solo char causa un problema nella stampa
   MD5_CTX md5;// allora la struttura che contiene informazioni sugli hash
   SHA_CTX sha;// allora la struttura che contiene informazioni sugli hash
   //inizio procedura per salvare md5 e sha1 nel file rek
   strcpy(stringa_hash,path_fun);//copio in stringa_hash il percorso
   strcat (stringa_hash,nomepc_fun);//concateno alla stringa_hash anche il nome pc
   lungh_hash=strlen(nomepc_fun)+strlen(path_fun);//calcolo lunghezza della nuova stringa data da concatenazione del percorso e nome pc
   for(ind=0;ind<11;ind++) stringa_hash[ind+lungh_hash]=(char)(codice_fun[ind]+48);//aggiungo codice utente alla stringa come carattere
   stringa_hash[ind+lungh_hash]=(char)(controllo_fun+48);//aggiungo codice di controllo del codice alla stringa
   for(ind=0;ind<30;ind++) stringa_hash[12+ind+lungh_hash]=(char)(controlloic_fun[ind]+48);//aggiungo codice utente alla stringa come carattere
   stringa_hash[ind+lungh_hash+12]='\0';//importante mettono alla fine dell'array di char il carattere \0 per terminarlo e poterlo trattare come una stringa
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

//fuzione per generare hash del file licenza. L'algoritmo è diverso da tutti glia ltri. Questo è mille volte più complesso
void hash_license_funzione(int codice_fun[],int controllo_fun,char nome_fun[],char cogn_fun[],char soc_fun[],char mail_fun[],char reg_fun[],int num_domanda_fun,int domanda_fun[],char version_fun[])
{
   //variabili per md5 e sha (versione semplice che verifica alcuni dati e scrive il codice dentro il file rek.dll
   char stringa_hash[220]; //ci sono molte altre variabili sparse per il programma
   int lungh_hash,ind=0;
   unsigned char buffer_md5[16],buffer_sha[20];	// i buffer devono essere unsigned char, mettere solo char causa un problema nella stampa
   MD5_CTX md5;// alloca la struttura che contiene informazioni sugli hash
   SHA_CTX sha;// alloca la struttura che contiene informazioni sugli hash
   for(ind=0;ind<220;ind++) stringa_hash[ind]=0;
   //inizio procedura per salvare md5 e sha1 nel file license. inizio  nel gestire prima le strighe, che soon più facile da concatenare
   strcpy(stringa_hash,nome_fun);//copio in stringa_hash il nome
   strcat(stringa_hash,cogn_fun);//concateno alla stringa_hash anche il cognome e così via per tutte le stringhe
   strcat(stringa_hash,soc_fun);
   strcat(stringa_hash,mail_fun);
   strcat(stringa_hash,reg_fun);
   strcat(stringa_hash,version_fun);
   lungh_hash=strlen(stringa_hash);//calcolo lunghezza della nuova stringa
   for(ind=0;ind<11;ind++) stringa_hash[ind+lungh_hash]=(char)(codice_fun[ind]+48);//aggiungo codice utente alla stringa come carattere
   stringa_hash[ind+lungh_hash]=(char)(controllo_fun+48);//aggiungo codice di controllo del codice alla stringa
   stringa_hash[ind+lungh_hash+1]=(char)(num_domanda_fun+48);//aggiungo numero domanda
   //ora devo concatenare la risposta alla domanda. so che mi trovo a dover mettere i dati a ind+lungh_hash+2, per semplicità inizializzo una variabile a questo valore
   int lun_part2=ind+lungh_hash+2;
   for(ind=0;ind<50;ind++) if(domanda_fun[ind]!=0) stringa_hash[lun_part2+ind]=domanda_fun[ind];
   stringa_hash[lun_part2+ind]='\0';//importante mettono alla fine dell'array di char il carattere \0 per terminarlo e poterlo trattare come una stringa
   // inizializza le strutture
   MD5_Init (&md5);
   SHA1_Init(&sha);
   // calcola l'hash della stringa in input
   MD5_Update (&md5, (unsigned char *) stringa_hash, strlen(stringa_hash));
   SHA1_Update(&sha, (unsigned char *) stringa_hash, strlen(stringa_hash));
   // calcola l'hash finale
   MD5_Final (buffer_md5, &md5);
   SHA1_Final (buffer_sha, &sha);
   for (ind=0;ind<16;ind++) md5_fun2[ind]=buffer_md5[ind];
   for (ind=0;ind<20;ind++) sha1_fun2[ind]=buffer_sha[ind];
}

//funzione per ora min e sec
void now (int &giom, int &mese, int &anno, int &gios, int &ora, int &min, int &sec)
{
time_t data;
struct tm * leggibile = NULL;

time (&data);
leggibile = localtime (&data);
giom = leggibile->tm_mday;
mese = leggibile->tm_mon +1;
anno = leggibile->tm_year+1900;
gios = leggibile->tm_wday+1; // 1 = Domenica - 7 = Sabato
ora = leggibile->tm_hour;
min = leggibile->tm_min;
sec = leggibile->tm_sec;
return;
}

struct writeData{      //record per scrivere sul file, i campi inutili  non servono a nulla, fa solo confusione per chi cercasse di cracckare
       int mixer8;     //sono variabili che fanno incasinare (mescolare) i dati nel file, così è difficile capire quali sono dati utili e soprattutto uso questi dati per fare controlli su integrità file(sblocco licenza)
	   int codice[11];
	   int mixer6;
       int controllo;  //questa cifra è di controlo ottenuta dall'algoritmo che crea il codice isbn (vedi wikipedia), io lo uso qui per rendere ancora più difficile la modifica del file licenza(quella.dat)
	   int mixer4;
	   char reg[5];
	   int mixer5;
	   int inutile;    //gli INUTILI ssono davvero inutili, rendono la compresione del file licenza più difficile, quindi è un bene perchè si impedisce la modifica di dati delicati
	   int mixer7;
	   double inutile2;
	   int pcname[20];
	   char space[2]; //inutile alla grande! serve solo a creare spazio tra pcname e pathcodificato se no il rispristino fabbrica sbaglia la lettura dei dati
	   int path_codificato[100];
	   int controllo_registrazione; //variabile che serve solo a far si che non venga più richiesta la scelta della modalità di registrazione se già registrato
	   int codice_controlloic[30];
	   int mixer3;
	   int mixer2;
	   int mixer1;
	   int mixer9;
	   unsigned char md5[16]; //md5 e sha1 composti da percorso + nome pc  + codice + controllo + codice controlloic
	   unsigned char sha1[20];
	   int matrice[10][10];

};      

struct licenseData{     //record per scrivere file di licenza come backup. Questo ha l'aggiunta di informazioni personali, come la mail e nome e cognome e società a cui è intestata
       char version[5];   //NON CAMBIARE ASSOLUTAMENTE QUESTO DATO. DOVRA' ESSERE SEMPRE DI 5, SI DEVE CHIAMARE VERSION, DEVE ESSERE CHAR E DEVE ESSERE SEMPRE IL PRIMO ELEMENTO DELLA STRUCT, perchè serve per far riconoscere a versioni future la versione della licenza e permetterne l'accettazione e conversione 
   	   int codice_x[11];
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
	   int tipolic;
	   int ora_s; //_s -> SCADENZA mentre _r -> REGISTRAZIONE
	   int min_s;
	   int sec_s;
	   int gio_s;
	   int mese_s;
	   int anno_s;
	   int gio_r;
	   int mese_r;
	   int anno_r;
	   int ora_r;
	   int min_r;
	   int sec_r;
	   unsigned char md5_x[16]; //2 particolari hash creati con la seconda funzione md5 e sha1. Questo perchè la seconda fa un controllo più approfondito controllando meglio i campi della licenza
	   unsigned char sha1_x[20];
	   int codice_up[7]; //serve per l'upgrade
};   

struct activate_licData{  //record per scrivere sul file, con acctname fissato ad 1, mentre i campi inutili  non servono a nulla, fa solo confusione per chi cercasse di cracckare
       int codice_dat[11]; //questo è sempre = al codice utente generato al primo avvio in ks.dat //SEMPRE, a differenza di codice_ax che è casuale+qualche legame con codice di ks.dat
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
	   int codice_controlloic_a[30];
	   int tipolic;
	   int gio_s;
	   int mese_s;
	   int anno_s;
	   int ora_s;
	   int min_s;
	   int sec_s;
	   int gio_r;
	   int mese_r;
	   int anno_r;
	   int ora_r;
	   int min_r;
	   int sec_r;
	   unsigned char md5_dat[16];
	   unsigned char sha1_dat[20];
	   char version[5];
	   /*int codice_up[7];*/  //per ora campo ancora inutilizzato, magari in futuro mi servirà per la modalità compatibilità della licenza, facendo attivare licenza scadute
}; 

struct writepcData{  //record per scrivere nome pc
       char nomepc_w[20];
	   int codice_controlloic_w[30];
	   unsigned char md5_w[16]; //md5 e sha1 composti da percorso + nome pc  + codice + controllo + codice controlloic
	   unsigned char sha1_w[20];
	   int matrice_w[10][10];
};        

struct pathWData{  //record per scrivere percorso
       char path_pathW[100];
	   int codice_controlloic_pathW[30];
	   int cont_licenza; //nascondo in questo file per non doverne usare un'altro il numero che conta quante volte ho sbagliato la domanda per l'attivazione licenza
	   unsigned char md5_pathW[16]; //md5 e sha1 composti da percorso + nome pc  + codice + controllo + codice controlloic
	   unsigned char sha1_pathW[20];
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
   int decimigliaia=0,migliaia=0,centinaia=0,decine=0,unita=0,controllo_test,controllo_lic_test;
 
   //tutto questo serve  perle cose fatte in c++ su percorsi e nome pc
   char nome_pc[20],pcname[20];  //per salvataggio nome pc
   char directory[100],percorso[100];   //percorso in char

   //variabili per matrice
   int matrix2[10][10]={{0},{0}},matrix[10][10]={{0},{0}},matrix3[10][10]={{0},{0}};

   //variabili per vedere se codice sha e md5 sono corretti. Se sha=20 e md5=16 allora sono corretti, se no no. Ps se i percorsi file o nome utente sono diversi non esegue nemmeno il controllo, li pongo direttamente a 99 così sono sicuro che mi da l'errore di manomissione
   int indsha=0,indmd5=0; //ce ne sono molte altre, ma sono locali dentro alla funzione dichiarata sopra oppure addirittura in mezzo al main

   //variabili per orologio e licenza HOME/Professional
   int gio, mese, anno, gios, ora, min, sec;  //NB l'opzione CLR su queste procedure dell'orologio può anche essere disattivata, ma non per percorso e nomepc. almeno per ora
//*******************************************************fine dichiarazione varibili***************************************************************

//inizializzazzione delle strutture a 0 e "" per sicurezza e contemporaneamente le rinomino da writeData a write ecc... come se facessi un typedef(sinonimo)
struct writeData write={0,{0,0,0,0,0,0,0,0,0,0,0},0,0,0,"",0,0,0,0.0,{0},"",{0},0,{0},0,0,0,0};  //imposto valori standard nella struttura
struct licenseData license={"",{0,0,0,0,0,0,0,0,0,0,0},0,"","","","","",0,0.0,0,{0},0,0,0,0,0,0,0,0,0,0,0,0,0,{0},{0}};   
struct activate_licData activate;     //qui non inzializzo ma dichiaro solo il nome activate!. Volendo potrei anche inziializzare
struct writepcData writepc={"",{0}};  //record che uso per il nome del computer
struct pathWData pathW={"",{0},0};    //record che uso per il percorso dell'eseguibile



//*************************************************************************************************
//*************************************************************************************************
//questo pezzetto strafigo calcola la lunghezza di una stringa dichiarata come system::string
//è talmente figa che non so nemmeno come funziona, ma io me ne frego, tanto ho fatto copia incolla da msdn e funziona da dio
//quindi non toccarla perchè non ho la minima idea di come risolvere i problemi legati a questo piccolo frammento del kaiser
pin_ptr<const wchar_t> wch = PtrToStringChars(Environment::CurrentDirectory);
size_t convertedChars = 0;
size_t  sizeInBytes = ((Environment::CurrentDirectory->Length + 1) * 2);
errno_t err = 0;
char    *ch = (char *)malloc(sizeInBytes);  //dichiaro qui la variabile che mi serve, come anche tutte le altre che uso per questo pezzetto.
err = wcstombs_s(&convertedChars,ch, sizeInBytes,wch, sizeInBytes);
if (err != 0) printf_s("Errore LM00A: Contattare ks89\n"); //non ho la minima idea di come come risolvere sto bug, perchè non ho la minima idea di come funzioni sto pezzo in c++
//*************************************************************************************************
//*************************************************************************************************

//mi assicuro che nel record da scrivere ci siano solo degli 0 e che dopo la scrittura del path, ci siano tutti 0 eccetto quelli col percorso
for(i=0;i<100;i++) write.path_codificato[i]=0;//svuoto anche il record in cui dovrò scrivere
for(i=0;i<100;i++) directory[i]=(int)0; //svuoto la stringa directory con tanti 0
//Sono costretto a fare strcpy ci ch in directory, se no mi ritrovo caratteri non ammessi. Non so perchè, ma cos' funziona
strcpy(directory,ch); //volendo potrei usare ch[i], ma originariamente il prog gestiva in modo diverso il percorso, per non cambiare tutti i directory, faccio un assegnamento così
for(i=0;i<100;i++) write.path_codificato[i]=(int)directory[i]; //metto il percorso codificato in numeri secondo ascii nel record


//*************************************************************************************************
//*************************************************************************************************
//fa lo stesso di sopra, ma questo serve per il nome del pc
wch = PtrToStringChars(Environment::MachineName);
convertedChars = 0;
sizeInBytes = ((Environment::MachineName->Length + 1) * 2);
err = 0;
char    *ch2 = (char *)malloc(sizeInBytes);  //dichiaro qui la variabile che mi serve, come anche tutte le altre che uso per questo pezzetto.
err = wcstombs_s(&convertedChars,ch2, sizeInBytes,wch, sizeInBytes);
if (err != 0) printf_s("Errore LM00B: Contattare ks89\n"); //non ho la minima idea di come come risolvere sto bug, perchè non ho la minima idea di come funzioni sto pezzo in c++
//*************************************************************************************************
//*************************************************************************************************
for(i=0;i<20;i++) write.pcname[i]=0;//svuoto anche il record in cui dovrò scrivere
for(i=0;i<20;i++) nome_pc[i]=(int)0; //svuoto la stringa directory con tanti 0
strcpy(nome_pc,ch2);
for(i=0;i<20;i++) write.pcname[i]=(int)nome_pc[i];



printf("         *************************************************************\n");
printf("         *..::Benvenuto in LIGHT COMMAND LINE BETA 3.0.0 by ks89!::..*\n");
printf("         *************************************************************\n\n");
printf("Novita': distinzione tra view e viewf\n");
printf("Novita': aggiunta struttura generate.1.1\n");
printf("Novita': aggiunta struttura simulate\n\n");
printf("Novita': aggiunta registrazione simulate.complete.1\n\n");

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
											for(i=0;i<30;i++) writepc.codice_controlloic_w[i]=(int)valore[i]-48;
											printf("\n***Controlloic: ");
											for(i=0;i<30;i++) printf("%d ",writepc.codice_controlloic_w[i]);
											printf("***\n");
											}
	  if(strcmp(comando,"hash")==0) {
									  printf("\n Guida all'utilizzo: \n");
									  printf("\n Prima di poterla usare inserire il percorso in pathW, nome pc in nomepc e controllo in write.controllo, e quindi il codice\n\n");
									  printf("\nOppure inserire view.ks.1 e far si che le strutture si carichino con i dati del file\n");
									  hash_rex_dll_funzione(pathW.path_pathW,writepc.nomepc_w,write.codice,write.controllo,write.codice_controlloic);//funziona per calcolare hash e scriverlo su rek.dll
									  for(i=0;i<20;i++) writepc.sha1_w[i]=sha1_fun[i];
									  for(i=0;i<16;i++) writepc.md5_w[i]=md5_fun[i];
									  printf("\nMD5: ");//stampa l'MD5
									  for (i=0;i<16;i++) printf ("%02x", writepc.md5_w[i]);
									  printf("\nSHA-1: ");//stampa dello SHA-1
									  for (i=0;i<20;i++) printf ("%02x", writepc.sha1_w[i]);
									  printf("\n");
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
									printf("\n***PathW: %s***\n",pathW.path_pathW);
								   }

	  if(strcmp(comando,"controlloic")==0) {
											for(i=0;i<30;i++) pathW.codice_controlloic_pathW[i]=(int)valore[i]-48;
											printf("\n***Controlloic: ");
											for(i=0;i<30;i++) printf("%d ",pathW.codice_controlloic_pathW[i]);
											printf("***\n");
										   }
	  if(strcmp(comando,"cont_licenza")==0) {
											  pathW.cont_licenza=(int)valore[0]-48;
											  printf("\n***Cont_licenza: %d***\n",pathW.cont_licenza);
											}
	  if(strcmp(comando,"hash")==0) {
									  printf("\n Guida all'utilizzo: \n");
									  printf("\n Prima di poterla usare inserire il percorso in pathW, nome pc in nomepc e controllo in write.controllo, e quindi il codice\n\n");
									  printf("\nOppure inserire view.ks.1 e far si che le strutture si carichino con i dati del file\n");
									  hash_rex_dll_funzione(pathW.path_pathW,writepc.nomepc_w,write.codice,write.controllo,write.codice_controlloic);//funziona per calcolare hash e scriverlo su rek.dll
									  for(i=0;i<20;i++) pathW.sha1_pathW[i]=sha1_fun[i];
									  for(i=0;i<16;i++) pathW.md5_pathW[i]=md5_fun[i];
									  printf("\nMD5: ");//stampa l'MD5
									  for (i=0;i<16;i++) printf ("%02x", pathW.md5_pathW[i]);
									  printf("\nSHA-1: ");//stampa dello SHA-1
									  for (i=0;i<20;i++) printf ("%02x", pathW.sha1_pathW[i]);
									  printf("\n");
									}	
  }


  //procedura che dalla struttura in base al comando scrive il valore in write.
  if(strcmp(struttura,"write")==0)
  {
	  if(strcmp(comando,"codice")==0) {
										for(i=0;i<11;i++) write.codice[i]=(int)valore[i]-48;
										printf("\n***");
										for(i=0;i<11;i++) printf("%d",write.codice[i]);
										printf("***\n");
									  }
	  if(strcmp(comando,"controllo")==0) {
										   //qui mettere il codice e da quello crea il controllo e salva anche il codice
										   for(i=0;i<11;i++) write.codice[i]=(int)valore[i]-48;
										   controllo_test=10-(((write.codice[0]*9)+(write.codice[1]*8)+(write.codice[2]*7)+(write.codice[3]*6)+(write.codice[4]*5)+(write.codice[5]*4)+(write.codice[6]*3)+(write.codice[7]*2))%10);
										   write.controllo=10-(((controllo_test*9)+(write.codice[8]*8)+(write.codice[9]*7)+(write.codice[10]*6)+(write.codice[0]*5)+(write.codice[1]*4)+(write.codice[2]*3)+(write.codice[5]*2))%10);
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
										  if(valore[0]=='n') write.inutile2=-546.421405; //danneggiato
										  if(valore[0]=='y') write.inutile2=-546.451405; //ok
										  printf("\n***Inutile2: %f***\n",write.inutile2);
	                                    }
										  
	  if(strcmp(comando,"pcname")==0) {
								
										lun=strlen(valore);
										for(i=0;i<20;i++) write.pcname[i]=(int)0;
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
									  for(i=0;i<100;i++) write.path_codificato[i]=0;
									  for(i=0;i<100;i++) write.path_codificato[i]=(int)valore[i];
									  for(i=0;i<100;i++) valore[i]=(int)0;
									  printf("\n***Path: ");
									  for(i=0;i<100;i++) printf("%d ",write.path_codificato[i]);
									  printf("***\n");
	                                 }
	  if(strcmp(comando,"controllo_registrazione")==0) {
														decine=(int)valore[0]-48;
														unita=(int)valore[1]-48;
														write.controllo_registrazione=(decine*10)+unita;
														printf("\n***Contr_registraz: %d***\n",write.controllo_registrazione);
	                                                   }
	  if(strcmp(comando,"controlloic")==0) {
											  for(i=0;i<30;i++) write.codice_controlloic[i]=(int)valore[i]-48;
											  printf("\n***Controlloic: ");
											  for(i=0;i<30;i++) printf("%d ",write.codice_controlloic[i]);
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
	  if(strcmp(comando,"hash")==0) {
									  printf("\n Guida all'utilizzo: \n");
									  printf("\n Prima di poterla usare inserire il percorso in pathW, nome pc in nomepc e controllo in write.controllo, e quindi il codice\n\n");
									  printf("\nOppure inserire view.ks.1 e far si che le strutture si carichino con i dati del file\n");
									  hash_rex_dll_funzione(pathW.path_pathW,writepc.nomepc_w,write.codice,write.controllo,write.codice_controlloic);//funziona per calcolare hash e scriverlo su rek.dll
									  for(i=0;i<20;i++) write.sha1[i]=sha1_fun[i];
									  for(i=0;i<16;i++) write.md5[i]=md5_fun[i];
									  printf("\nMD5: ");//stampa l'MD5
									  for (i=0;i<16;i++) printf ("%02x", write.md5[i]);
									  printf("\nSHA-1: ");//stampa dello SHA-1
									  for (i=0;i<20;i++) printf ("%02x", write.sha1[i]);
									  printf("\n");
									}	
  }

  //procedura che dalla struttura in base al comando scrive il valore in license.
  if(strcmp(struttura,"lic")==0)
  {
	  if(strcmp(comando,"codice_dat")==0) {
										for(i=0;i<11;i++) activate.codice_dat[i]=write.codice[i];
										printf("\nPerchè funzioni definire prima write.codice\n***");
										for(i=0;i<11;i++) printf("%d ",activate.codice_dat[i]);
										printf("***\n");
									  }
	  if(strcmp(comando,"controllo_dat")==0) {
												for(i=0;i<11;i++) activate.codice_dat[i]=(int)valore[i]-48;
												controllo_lic_test=10-(((activate.codice_dat[0]*9)+(activate.codice_dat[1]*8)+(activate.codice_dat[2]*7)+(activate.codice_dat[3]*6)+(activate.codice_dat[4]*5)+(activate.codice_dat[5]*4)+(activate.codice_dat[6]*3)+(activate.codice_dat[7]*2))%10);
												activate.controllo_dat=10-(((controllo_lic_test*9)+(activate.codice_dat[8]*8)+(activate.codice_dat[9]*7)+(activate.codice_dat[10]*6)+(activate.codice_dat[0]*5)+(activate.codice_dat[1]*4)+(activate.codice_dat[2]*3)+(activate.codice_dat[5]*2))%10); 
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
										for(i=0;i<20;i++) activate.pcname_a[i]=(int)0;
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
											  for(i=0;i<30;i++) activate.codice_controlloic_a[i]=(int)valore[i]-48;
											  printf("\n***Controlloic: ");
											  for(i=0;i<30;i++) printf("%d ",activate.codice_controlloic_a[i]);
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
												activate.codice_a0=(((rand() % 10)*3)/(activate.codice_a2+activate.codice_a3-1))%9;
												activate.codice_a1=8-(((activate.codice_a0*7)+(activate.codice_a2*6)+(activate.codice_a3*5)+(activate.codice_a4*4)+(activate.codice_a5*3)+(activate.codice_a6*2))%8);
												printf("\n***Codice_licenza: %d %d %d %d %d %d %d***\n",activate.codice_a0,activate.codice_a1,activate.codice_a2,activate.codice_a3,activate.codice_a4,activate.codice_a5,activate.codice_a6);
											  }
	  if(strcmp(comando,"controllo_a")==0) {
										   //qui mettere il codice e da quello crea il controllo e salva anche il codice
										   for(i=0;i<7;i++) activate.codice_dat[i]=write.codice[i];
										   activate.controllo_a=7-(((activate.codice_a0*6)+(activate.codice_a1*5)+(activate.codice_a2*4)+(activate.codice_a3*3)+(activate.codice_a4*2))%7);
										   printf("\n***Controllo: %d***\n",activate.controllo_a);
	                                     }
	  if(strcmp(comando,"tipolic")==0){
										if(valore[0]=='p') activate.tipolic=99;//cioè professional
										else activate.tipolic=(int)valore[0]-48;//cioè il numero di anni di validità della licenza HOME
									  }
	  if(strcmp(comando,"ora_r")==0)  {
										 printf("\nInserire la data registrazione secondo questo formato:\n");
										 printf("gg/mm/aaaa oo:mm:ss\n");
										 decine=(int)valore[0]-48;
										 unita=(int)valore[1]-48;
										 activate.gio_r=unita+(decine*10);
										 decine=(int)valore[3]-48;
										 unita=(int)valore[4]-48;
										 activate.mese_r=unita+(decine*10);
										 migliaia=(int)valore[6]-48;
										 centinaia=(int)valore[7]-48;
										 decine=(int)valore[8]-48;
										 unita=(int)valore[9]-48;
										 activate.anno_r=unita+(decine*10)+(centinaia*100)+(migliaia*1000);
										 decine=(int)valore[11]-48;
										 unita=(int)valore[12]-48;
										 activate.ora_r=unita+(decine*10);
										 decine=(int)valore[14]-48;
										 unita=(int)valore[15]-48;
										 activate.min_r=unita+(decine*10);
										 decine=(int)valore[17]-48;
										 unita=(int)valore[18]-48;
										 activate.sec_r=unita+(decine*10);
										 printf("\n***Data registrazione: %d/%d/%d %d:%d:%d***\n",activate.gio_r,activate.mese_r,activate.anno_r,activate.ora_r,activate.min_r,activate.sec_r);
									  }
	  if(strcmp(comando,"ora_s")==0)  {
										 printf("\nInserire la data scadenza secondo questo formato:\n");
										 printf("gg/mm/aaaa oo:mm:ss\n");
										 decine=(int)valore[0]-48;
										 unita=(int)valore[1]-48;
										 activate.gio_s=unita+(decine*10);
										 decine=(int)valore[3]-48;
										 unita=(int)valore[4]-48;
										 activate.mese_s=unita+(decine*10);
										 migliaia=(int)valore[6]-48;
										 centinaia=(int)valore[7]-48;
										 decine=(int)valore[8]-48;
										 unita=(int)valore[9]-48;
										 activate.anno_s=unita+(decine*10)+(centinaia*100)+(migliaia*1000);
										 decine=(int)valore[11]-48;
										 unita=(int)valore[12]-48;
										 activate.ora_s=unita+(decine*10);
										 decine=(int)valore[14]-48;
										 unita=(int)valore[15]-48;
										 activate.min_s=unita+(decine*10);
										 decine=(int)valore[17]-48;
										 unita=(int)valore[18]-48;
										 activate.sec_s=unita+(decine*10);
										 printf("\n***Data scadenza: %d/%d/%d %d:%d:%d***\n",activate.gio_s,activate.mese_s,activate.anno_s,activate.ora_s,activate.min_s,activate.sec_s);
									  }
	  if(strcmp(comando,"hash")==0) {
									  printf("\n Guida all'utilizzo: \n");
									  printf("\n Prima di poterla usare inserire il percorso in pathW, nome pc in nomepc e controllo in write.controllo, e quindi il codice\n\n");
									  printf("\nOppure inserire view.ks.1 e far si che le strutture si carichino con i dati del file\n");
									  hash_rex_dll_funzione(pathW.path_pathW,writepc.nomepc_w,write.codice,write.controllo,write.codice_controlloic);//funziona per calcolare hash e scriverlo su rek.dll
									  for(i=0;i<20;i++) activate.sha1_dat[i]=sha1_fun[i];
									  for(i=0;i<16;i++) activate.md5_dat[i]=md5_fun[i];
									  printf("\nMD5: ");//stampa l'MD5
									  for (i=0;i<16;i++) printf ("%02x", activate.md5_dat[i]);
									  printf("\nSHA-1: ");//stampa dello SHA-1
									  for (i=0;i<20;i++) printf ("%02x", activate.sha1_dat[i]);
									  printf("\n");
									}	
	  if(strcmp(comando,"version")==0){
										strcpy(activate.version,valore);
										printf("\nVersione: %s\n",activate.version);
									  }
  }

  //procedura che dalla struttura in base al comando scrive il valore in license.
  if(strcmp(struttura,"license")==0)
  {
	  if(strcmp(comando,"version")==0){
									   strcpy(license.version,valore);
									   printf("\nVersione: %s\n",license.version);
								    }
	  if(strcmp(comando,"codice")==0){
									printf("\nInserire codice utente durante generazione lizenza\n");
									for(i=0;i<11;i++) license.codice_x[i]=(int)valore[i]-48;
									for(i=0;i<11;i++) printf("%d ",license.codice_x[i]);
									printf("***\n");
								    }
	  if(strcmp(comando,"controllo")==0){
										for(i=0;i<11;i++) license.codice_x[i]=(int)valore[i]-48;
									    controllo_test=10-(((license.codice_x[0]*9)+(license.codice_x[1]*8)+(license.codice_x[2]*7)+(license.codice_x[3]*6)+(license.codice_x[4]*5)+(license.codice_x[5]*4)+(license.codice_x[6]*3)+(license.codice_x[7]*2))%10);
										license.controllo_x=10-(((controllo_test*9)+(license.codice_x[8]*8)+(license.codice_x[9]*7)+(license.codice_x[10]*6)+(license.codice_x[0]*5)+(license.codice_x[1]*4)+(license.codice_x[2]*3)+(license.codice_x[5]*2))%10); 
										printf("\n***Controllo_x: %d***\n",license.controllo_x);
									  }
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
										 decimigliaia=(int)valore[0]-48;
										 migliaia=(int)valore[1]-48;
										 centinaia=(int)valore[2]-48;
										 decine=(int)valore[3]-48;
										 unita=(int)valore[4]-48;
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
	  if(strcmp(comando,"tipolic")==0){
										if(valore[0]=='p') license.tipolic=99;//cioè professional
										else license.tipolic=(int)valore[0]-48;//cioè il numero di anni di validità della licenza HOME
									  }
	  if(strcmp(comando,"ora_r")==0)  {
										 printf("\nInserire la data registrazione secondo questo formato:\n");
										 printf("gg/mm/aaaa oo:mm:ss\n");
										 decine=(int)valore[0]-48;
										 unita=(int)valore[1]-48;
										 license.gio_r=unita+(decine*10);
										 decine=(int)valore[3]-48;
										 unita=(int)valore[4]-48;
										 license.mese_r=unita+(decine*10);
										 migliaia=(int)valore[6]-48;
										 centinaia=(int)valore[7]-48;
										 decine=(int)valore[8]-48;
										 unita=(int)valore[9]-48;
										 license.anno_r=unita+(decine*10)+(centinaia*100)+(migliaia*1000);
										 decine=(int)valore[11]-48;
										 unita=(int)valore[12]-48;
										 license.ora_r=unita+(decine*10);
										 decine=(int)valore[14]-48;
										 unita=(int)valore[15]-48;
										 license.min_r=unita+(decine*10);
										 decine=(int)valore[17]-48;
										 unita=(int)valore[18]-48;
										 license.sec_r=unita+(decine*10);
										 printf("\n***Data registrazione: %d/%d/%d %d:%d:%d***\n",license.gio_r,license.mese_r,license.anno_r,license.ora_r,license.min_r,license.sec_r);
									  }
	  if(strcmp(comando,"ora_s")==0)  {
										 printf("\nInserire la data scadenza secondo questo formato:\n");
										 printf("gg/mm/aaaa oo:mm:ss\n");
										 decine=(int)valore[0]-48;
										 unita=(int)valore[1]-48;
										 license.gio_s=unita+(decine*10);
										 decine=(int)valore[3]-48;
										 unita=(int)valore[4]-48;
										 license.mese_s=unita+(decine*10);
										 migliaia=(int)valore[6]-48;
										 centinaia=(int)valore[7]-48;
										 decine=(int)valore[8]-48;
										 unita=(int)valore[9]-48;
										 license.anno_s=unita+(decine*10)+(centinaia*100)+(migliaia*1000);
										 decine=(int)valore[11]-48;
										 unita=(int)valore[12]-48;
										 license.ora_s=unita+(decine*10);
										 decine=(int)valore[14]-48;
										 unita=(int)valore[15]-48;
										 license.min_s=unita+(decine*10);
										 decine=(int)valore[17]-48;
										 unita=(int)valore[18]-48;
										 license.sec_s=unita+(decine*10);
										 printf("\n***Data scadenza: %d/%d/%d %d:%d:%d***\n",license.gio_s,license.mese_s,license.anno_s,license.ora_s,license.min_s,license.sec_s);
									  }
	  if(strcmp(comando,"hash")==0) {
									  printf("\n Guida all'utilizzo: \n");
									  printf("\n Prima di poterla usare fare un view.license.1\n");
									  hash_license_funzione(license.codice_x,license.controllo_x,license.nome_x,license.cogn_x,license.soc_x,license.mail_x,license.reg_x,license.num_domanda_x,license.domanda_x,license.version);
									  for(i=0;i<20;i++) license.sha1_x[i]=sha1_fun2[i];
									  for(i=0;i<16;i++) license.md5_x[i]=md5_fun2[i];
									  printf("\nMD5: ");//stampa l'MD5
									  for (i=0;i<16;i++) printf ("%02x", license.md5_x[i]);
									  printf("\nSHA-1: ");//stampa dello SHA-1
									  for (i=0;i<20;i++) printf ("%02x", license.sha1_x[i]);
									  printf("\n");
									}	
}
//procedura per la generazione della matrice su tutti i file contemporaneamente
if(strcmp(struttura,"matrice")==0) {    //attenzione, la matrice viene genrata uguale sempre per tutti i file. in questa versione on è generabile in modo diverso
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
//**********************************************************************************************************************************************************
//**************************************************************************FINE WRITE**********************************************************************
//**********************************************************************************************************************************************************


//**********************************************************************************************************************************************************
//*****************************************************************************VIEWF*************************************************************************
//**********************************************************************************************************************************************************
if(strcmp(struttura,"viewf")==0)
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
		  	if ((cfPtr=fopen("irr.dat","rb"))==NULL) printf("Errore L006\n");
		  	else {
		  			fread(&pathW,sizeof(struct pathWData),1,cfPtr);
		  			fclose(cfPtr);
		  	}
		  	printf("\n***In memoria sul file irr.dat***");
		  	printf("\nIn memoria su struttura per irr.dat");
		  	printf("\nCodice_controlloic: ");
		  	for(i=0;i<30;i++) printf("%d",pathW.codice_controlloic_pathW[i]);
		  	printf("\nCont Licenza: %d\n",pathW.cont_licenza);
		  	printf("Percorso: %s\n",pathW.path_pathW);
			printf("\nMD5: ");//stampa l'MD5
			for (i=0;i<16;i++) printf ("%02x", pathW.md5_pathW[i]);
			printf("\nSHA-1: ");//stampa dello SHA-1
			for (i=0;i<20;i++) printf ("%02x", pathW.sha1_pathW[i]);
			printf("\n");
	  }

	  if(strcmp(comando,"lic")==0)
	  {
			if ((cfPtr=fopen("lic.dat","rb"))==NULL) printf("Errore L007\n");
			else {
					fread(&activate,sizeof(struct activate_licData),1,cfPtr);
					fclose(cfPtr);
			}
			printf("\n***In memoria sul file per lic.dat***");
			printf("\nCodice: ");
			for(i=0;i<11;i++) printf("%d",activate.codice_dat[i]);
			printf("\nControllo: %d\n",activate.controllo_dat); 
			printf("Codice_controlloic: ");
			for(i=0;i<30;i++) printf("%d",activate.codice_controlloic_a[i]);
			printf("\nReg: %s\n",activate.reg_a);
			printf("Inutile: %d\n",activate.inutile_a);
			printf("Inutile2: %f\n",activate.inutile2_a);
			printf("Nome pc originale: ");
			for(i=0;i<20;i++) printf("%d ",activate.pcname_a[i]); 
			printf("\nControllo_registrazione: %d",activate.controllo_registrazione_a);
			printf("\nCodice_a (licenza): %d %d %d %d %d %d %d\n",activate.codice_a0,activate.codice_a1,activate.codice_a2,activate.codice_a3,activate.codice_a4,activate.codice_a5,activate.codice_a6);
			printf("Data registrazione: %d/%d/%d %d:%d:%d\n",activate.gio_r,activate.mese_r,activate.anno_r,activate.ora_r,activate.min_r,activate.sec_r);
			printf("Data scadenza: %d/%d/%d %d:%d:%d\n",activate.gio_s,activate.mese_s,activate.anno_s,activate.ora_s,activate.min_s,activate.sec_s);
			printf("Tipolic: %d\n",activate.tipolic);
			printf("Versione: %s\n",activate.version);
			printf("\nMD5: ");//stampa l'MD5
			for (i=0;i<16;i++) printf ("%02x", activate.md5_dat[i]);
			printf("\nSHA-1: ");//stampa dello SHA-1
			for (i=0;i<20;i++) printf ("%02x", activate.sha1_dat[i]);
			printf("\n");
	  }  

	  if(strcmp(comando,"license")==0)
	  {
			if ((cfPtr=fopen("license.lic","rb"))==NULL) printf("Errore L008\n");
			else {
					fread(&license,sizeof(struct licenseData),1,cfPtr);
					fclose(cfPtr);
			}

			printf("\n***In memoria sul file license.lic***");
			printf("\nCodice: ");
			for(i=0;i<11;i++) printf("%d",license.codice_x[i]);
			printf("\nControllo: %d\n",license.controllo_x);
			printf("Nome e cognome: %s %s\n",license.nome_x,license.cogn_x);
			printf("Societa': %s\n",license.soc_x);
			printf("E-Mail: %s\n",license.mail_x);
			printf("Reg: %s\n",license.reg_x);
			printf("Inutile: %d\n",license.inutile_x);
			printf("Inutile2: %f\n",license.inutile2_x);
			printf("Num domanda: %d\n",license.num_domanda_x);
			printf("Domanda: %s\n",license.domanda_x);
			printf("Data registrazione: %d/%d/%d %d:%d:%d\n",license.gio_r,license.mese_r,license.anno_r,license.ora_r,license.min_r,license.sec_r);
			printf("Data scadenza: %d/%d/%d %d:%d:%d\n",license.gio_s,license.mese_s,license.anno_s,license.ora_s,license.min_s,license.sec_s);
			printf("Tipolic: %d\n",license.tipolic);
			printf("Versione: %s\n",license.version);
			printf("\nMD5: ");//stampa l'MD5
			for (i=0;i<16;i++) printf ("%02x", license.md5_x[i]);
			printf("\nSHA-1: ");//stampa dello SHA-1
			for (i=0;i<20;i++) printf ("%02x", license.sha1_x[i]);
			printf("\n");
	  }

	  if(strcmp(comando,"ks")==0)
	  {                                                                                 
			if ((cfPtr=fopen("ks.dat","rb"))==NULL) printf("Errore L009\n");
			else {
					fread(&write,sizeof(struct writeData),1,cfPtr);
					fclose(cfPtr);
			}

			printf("\n***In memoria sul file ks.dat***");
			printf("\nCodice: ");
			for(i=0;i<11;i++) printf("%d",write.codice[i]);
			printf("\nControllo: %d\n",write.controllo);
			printf("Codice_controlloic: ");
			for(i=0;i<30;i++) printf("%d",write.codice_controlloic[i]);
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
			printf("\nMD5: ");//stampa l'MD5
			for (i=0;i<16;i++) printf ("%02x", write.md5[i]);
			printf("\nSHA-1: ");//stampa dello SHA-1
			for (i=0;i<20;i++) printf ("%02x", write.sha1[i]);
			printf("\n");

	  }

	  if(strcmp(comando,"rek")==0)
	  {                                                                                 
			if ((cfPtr=fopen("rek.dll","rb"))==NULL) printf("Errore L010\n");
			else {
  						fread(&writepc,sizeof(struct writepcData),1,cfPtr);
  						fclose(cfPtr);
			}

			printf("\n***In memoria sul file rek.dll***");
			printf("\nCodice_controlloic: ");
			for(i=0;i<30;i++) printf("%d",writepc.codice_controlloic_w[i]);
			printf("\nNome pc originale: %s\n",writepc.nomepc_w);
			printf("MD5: ");
			for (i=0;i<16;i++) printf ("%02x", writepc.md5_w[i]);
			printf("\nSHA-1: ");
			for (i=0;i<20;i++) printf ("%02x", writepc.sha1_w[i]); 
	  }
}
//**********************************************************************************************************************************************************
//*************************************************************************FINE VIEWF************************************************************************
//**********************************************************************************************************************************************************





//**********************************************************************************************************************************************************
//*****************************************************************************VIEW*************************************************************************
//**********************************************************************************************************************************************************
if(strcmp(struttura,"view")==0)
  { 
	  if(strcmp(comando,"irr")==0)
	  {
		  	printf("\n***In memoria su struttura per irr.dat***");
			printf("\nCodice_controlloic: ");
		  	for(i=0;i<30;i++) printf("%d",pathW.codice_controlloic_pathW[i]);
		  	printf("\nCont Licenza: %d\n",pathW.cont_licenza);
		  	printf("Percorso: %s\n",pathW.path_pathW);
			printf("\nMD5: ");//stampa l'MD5
			for (i=0;i<16;i++) printf ("%02x", pathW.md5_pathW[i]);
			printf("\nSHA-1: ");//stampa dello SHA-1
			for (i=0;i<20;i++) printf ("%02x", pathW.sha1_pathW[i]);
			printf("\n");
	  }

	  if(strcmp(comando,"lic")==0)
	  {
		  	printf("\n***In memoria su struttura per lic.dat***");
			printf("\nCodice: ");
			for(i=0;i<11;i++) printf("%d",activate.codice_dat[i]);
			printf("\nControllo: %d\n",activate.controllo_dat); 
			printf("Codice_controlloic: ");
			for(i=0;i<30;i++) printf("%d",activate.codice_controlloic_a[i]);
			printf("\nReg: %s\n",activate.reg_a);
			printf("Inutile: %d\n",activate.inutile_a);
			printf("Inutile2: %f\n",activate.inutile2_a);
			printf("Nome pc originale: ");
			for(i=0;i<20;i++) printf("%d ",activate.pcname_a[i]); 
			printf("\nControllo_registrazione: %d",activate.controllo_registrazione_a);
			printf("\nCodice_a (licenza): %d %d %d %d %d %d %d\n",activate.codice_a0,activate.codice_a1,activate.codice_a2,activate.codice_a3,activate.codice_a4,activate.codice_a5,activate.codice_a6);
			printf("Data registrazione: %d/%d/%d %d:%d:%d\n",activate.gio_r,activate.mese_r,activate.anno_r,activate.ora_r,activate.min_r,activate.sec_r);
			printf("Data scadenza: %d/%d/%d %d:%d:%d\n",activate.gio_s,activate.mese_s,activate.anno_s,activate.ora_s,activate.min_s,activate.sec_s);
			printf("Tipolic: %d\n",activate.tipolic);
			printf("Versione: %s\n",activate.version);
			printf("\nMD5: ");//stampa l'MD5
			for (i=0;i<16;i++) printf ("%02x", activate.md5_dat[i]);
			printf("\nSHA-1: ");//stampa dello SHA-1
			for (i=0;i<20;i++) printf ("%02x", activate.sha1_dat[i]);
			printf("\n");
	  }  

	  if(strcmp(comando,"license")==0)
	  {
			printf("\n***In memoria su struttura per license.lic***");
			printf("\nCodice: ");
			for(i=0;i<11;i++) printf("%d",license.codice_x[i]);
			printf("\nControllo: %d\n",license.controllo_x);
			printf("Nome e cognome: %s %s\n",license.nome_x,license.cogn_x);
			printf("Societa': %s\n",license.soc_x);
			printf("E-Mail: %s\n",license.mail_x);
			printf("Reg: %s\n",license.reg_x);
			printf("Inutile: %d\n",license.inutile_x);
			printf("Inutile2: %f\n",license.inutile2_x);
			printf("Num domanda: %d\n",license.num_domanda_x);
			printf("Domanda: %s\n",license.domanda_x);
			printf("Data registrazione: %d/%d/%d %d:%d:%d\n",license.gio_r,license.mese_r,license.anno_r,license.ora_r,license.min_r,license.sec_r);
			printf("Data scadenza: %d/%d/%d %d:%d:%d\n",license.gio_s,license.mese_s,license.anno_s,license.ora_s,license.min_s,license.sec_s);
			printf("Tipolic: %d\n",license.tipolic);
			printf("Versione: %s\n",license.version);
			printf("\nMD5: ");//stampa l'MD5
			for (i=0;i<16;i++) printf ("%02x", license.md5_x[i]);
			printf("\nSHA-1: ");//stampa dello SHA-1
			for (i=0;i<20;i++) printf ("%02x", license.sha1_x[i]);
			printf("\n");
	  }

	  if(strcmp(comando,"ks")==0)
	  {                                                                                 
			printf("\n***In memoria su struttura per ks.dat***");
			printf("\nCodice: ");
			for(i=0;i<11;i++) printf("%d",write.codice[i]);
			printf("\nControllo: %d\n",write.controllo);
			printf("Codice_controlloic: ");
			for(i=0;i<30;i++) printf("%d",write.codice_controlloic[i]);
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
			printf("\nMD5: ");//stampa l'MD5
			for (i=0;i<16;i++) printf ("%02x", write.md5[i]);
			printf("\nSHA-1: ");//stampa dello SHA-1
			for (i=0;i<20;i++) printf ("%02x", write.sha1[i]);
			printf("\n");
	  }

	  if(strcmp(comando,"rek")==0)
	  {                                                                                 
			printf("\n***In memoria su struttura per rek.dll***");
			printf("\nCodice_controlloic: ");
			for(i=0;i<30;i++) printf("%d",writepc.codice_controlloic_w[i]);
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
//***************************************************************************SIMULATE***********************************************************************
//**********************************************************************************************************************************************************
if(strcmp(struttura,"simulate")==0)
{ 
	  if(strcmp(comando,"registrazione")==0){
										 now(gio,mese,anno,gios,ora,min,sec); //leggo data
										 printf("\Perche' funzioni aprire e chiudere LightWall almeno una volta\n");
										 printf("Inserire nel campo valore del comando appena eseguito la data di scadenza\n");
										 strcpy(write.reg,"jhfiusq");
										 write.controllo_registrazione=32;
										 strcpy(activate.reg_a,"1234667");
										 activate.controllo_registrazione_a=32;
										 strcpy(activate.version,"2.0.1");
										 printf("\nInserire la data scadenza secondo questo formato:\n");
										 printf("gg/mm/aaaa oo:mm:ss\n\n");
										 activate.anno_r=anno;
										 activate.mese_r=mese;
										 activate.gio_r=gio;
										 activate.ora_r=ora;
										 activate.min_r=min;
										 activate.sec_r=sec;
										 decine=(int)valore[0]-48;
										 unita=(int)valore[1]-48;
										 activate.gio_s=unita+(decine*10);
										 decine=(int)valore[3]-48;
										 unita=(int)valore[4]-48;
										 activate.mese_s=unita+(decine*10);
										 migliaia=(int)valore[6]-48;
										 centinaia=(int)valore[7]-48;
										 decine=(int)valore[8]-48;
										 unita=(int)valore[9]-48;
										 activate.anno_s=unita+(decine*10)+(centinaia*100)+(migliaia*1000);
										 decine=(int)valore[11]-48;
										 unita=(int)valore[12]-48;
										 activate.ora_s=unita+(decine*10);
										 decine=(int)valore[14]-48;
										 unita=(int)valore[15]-48;
										 activate.min_s=unita+(decine*10);
										 decine=(int)valore[17]-48;
										 unita=(int)valore[18]-48;
										 activate.sec_s=unita+(decine*10);
										 activate.tipolic=activate.anno_s-activate.anno_r;
										 printf("\n***Data scadenza: %d/%d/%d %d:%d:%d***\n",activate.gio_s,activate.mese_s,activate.anno_s,activate.ora_s,activate.min_s,activate.sec_s);
										 printf("Tipo licenza: %d\n",activate.tipolic);
										 if ((cfPtr=fopen("ks.dat","rb+"))==NULL) printf("Errore L013");  //apro file
										 else {
			                        				fseek(cfPtr,0,SEEK_SET); 
			                        				fwrite(&write,sizeof(struct writeData),1,cfPtr); //scrivo sul file i valori impostati prima come record
			                        				fclose(cfPtr);                   //chiudo file
									     }   
									
										 if ((cfPtr=fopen("lic.dat","rb+"))==NULL) printf("Errore L015");  //apro file
										 else {
			                        				fseek(cfPtr,0,SEEK_SET); 
			                        				fwrite(&activate,sizeof(struct activate_licData),1,cfPtr); //scrivo sul file i valori impostati prima come record
			                        				fclose(cfPtr);                   //chiudo file
										 }  
	  }

	  if(strcmp(comando,"complete")==0){
										 printf("\nDopo questo comando eseguire save.all.1 per salvare\n\n");
										 now(gio,mese,anno,gios,ora,min,sec); //leggo data
										 printf("***Avvio procedura guidata di registrazione***\n\n");
										 printf("Codice utente: ");
										 char codice_utente[11];
										 scanf("%s",codice_utente);
										 for(i=0;i<11;i++) {
															write.codice[i]=(int)codice_utente[i]-48;
															activate.codice_dat[i]=write.codice[i];
														   }
										 controllo_test=10-(((write.codice[0]*9)+(write.codice[1]*8)+(write.codice[2]*7)+(write.codice[3]*6)+(write.codice[4]*5)+(write.codice[5]*4)+(write.codice[6]*3)+(write.codice[7]*2))%10);
										 write.controllo=10-(((controllo_test*9)+(write.codice[8]*8)+(write.codice[9]*7)+(write.codice[10]*6)+(write.codice[0]*5)+(write.codice[1]*4)+(write.codice[2]*3)+(write.codice[5]*2))%10);
										 activate.controllo_dat=write.controllo;
										 write.mixer1=1;
										 write.mixer2=4;
										 write.mixer3=8;
										 write.mixer4=5;
										 write.mixer5=1;
										 write.mixer6=7;
										 write.mixer7=0;
										 write.mixer8=2; 
										 write.mixer9=10;
										 printf("Codice controlloic: ");
										 char controlloic[30];
										 scanf("%s",controlloic);
										 for(i=0;i<30;i++) {
															write.codice_controlloic[i]=(int)controlloic[i]-48;
															activate.codice_controlloic_a[i]=write.codice_controlloic[i];
															pathW.codice_controlloic_pathW[i]=write.codice_controlloic[i];
															writepc.codice_controlloic_w[i]=write.codice_controlloic[i];
														   }
										 printf("\nInutile: \n");
										 printf("Scelgi '1' per 12344 o '0' per 12343\n");
										 int selezione=1;
										 scanf("%d",&selezione);
										 if(selezione==1) write.inutile=12344;
										 if(selezione==0) write.inutile=12343;
										 printf("\n %d \n",write.inutile);
										 printf("\nInutile2: \n");
										 printf("Scelgi '1' per -546.451405 o '0' per -546.421405\n");
										 scanf("%d",&selezione);
										 if(selezione==1) write.inutile2=-546.451405;
										 if(selezione==0) write.inutile2=-546.421405;
										 printf("\n %f \n",write.inutile2);
										 printf("\nReg: ");
										 printf("\nScegli '1' per 'registrato' o '0' per 'non registrato'\n");
										 scanf("%d",&selezione);
										 if(selezione==1) strcpy(write.reg,"jhfiusq");
										 if(selezione==0) strcpy(write.reg,"jhfiusw");
										 printf("\n %s \n",write.reg);
										 printf("\nReg lic.dat: ");
										 printf("\nScegli '1' per 'registrato' o '0' per 'non registrato'\n");
										 scanf("%d",&selezione);
										 if(selezione==1) strcpy(activate.reg_a,"1234667");
										 if(selezione==0) strcpy(activate.reg_a,"1234567");
										 printf("\n %s \n",activate.reg_a);
										 printf("\nControllo_registrazione: \n");
										 printf("Inserire 22 (non registrato) o 32 (registrato)");
										 scanf("%d",&selezione);
										 activate.controllo_registrazione_a=selezione;
										 write.controllo_registrazione=selezione;

										 strcpy(write.space,"12");
										 getchar();

										 printf("\nCodice licenza ax: (7 caratteri)\n");
										 char codice_a[7];
										 gets(codice_a);
										 //mettere il codice che su vuole, tanto poi LCL modifica creando quello giusto perchè poi funzioni tutto
										 activate.codice_a2=(int)codice_a[2]-48;   
										 activate.codice_a4=(int)codice_a[4]-48; 
										 activate.codice_a3=(int)codice_a[3]-48; 
										 activate.codice_a5=write.codice[5];     //questa è la versione di windows
										 activate.codice_a6=write.codice[6];     //anche qui
										 activate.codice_a0=(((rand() % 10)*3)/(activate.codice_a2+activate.codice_a3-1))%9;
										 activate.codice_a1=8-(((activate.codice_a0*7)+(activate.codice_a2*6)+(activate.codice_a3*5)+(activate.codice_a4*4)+(activate.codice_a5*3)+(activate.codice_a6*2))%8);
										 printf("\n***Codice_licenza: %d %d %d %d %d %d %d***\n",activate.codice_a0,activate.codice_a1,activate.codice_a2,activate.codice_a3,activate.codice_a4,activate.codice_a5,activate.codice_a6);

										 //resetto dati nome pc
										 for(i=0;i<20;i++) {
																write.pcname[i]=(int)0;
																activate.pcname_a[i]=(int)0;
																writepc.nomepc_w[i]=(int)0;
																pcname[i]=(int)0;
															}
										 printf("\nInserisci il nome del pc: ");
										 gets(pcname);
										 if(strcmp(pcname,"auto")==0) {
																		 strcpy(writepc.nomepc_w,nome_pc);
																		 for(i=0;i<20;i++){
																							write.pcname[i]=(int)nome_pc[i];
																							activate.pcname_a[i]=write.pcname[i];
																						  }
																	   }
										 else
										 {
										  strcpy(writepc.nomepc_w,pcname);
										  for(i=0;i<20;i++){
															 write.pcname[i]=(int)pcname[i];
															 activate.pcname_a[i]=write.pcname[i];
														   }
										  strcpy(nome_pc,pcname);
										 }
										 printf("\nNomepc salvato: %s\n",nome_pc);


										 printf("\nCont_licenza: \nInserisci da 0->3 in base al numero di errori");
										 scanf("%d",&selezione);
										 pathW.cont_licenza=selezione;
										 getchar();
										 printf("\nVersione licenza: ");
										 scanf("%s",activate.version);
										 getchar();
										 printf("\nInserire la data scadenza secondo questo formato:\n");
										 printf("gg/mm/aaaa oo:mm:ss\n\n");
										 char datazza[19];
										 gets(datazza);
										 activate.anno_r=anno;
										 activate.mese_r=mese;
										 activate.gio_r=gio;
										 activate.ora_r=ora;
										 activate.min_r=min;
										 activate.sec_r=sec;
										 decine=(int)(datazza[0]-48);
										 unita=(int)(datazza[1]-48);
										 printf("\n %s   %c %c \n",datazza,datazza[0],datazza[1]);
										 activate.gio_s=unita+(decine*10);
										 decine=(int)datazza[3]-48;
										 unita=(int)datazza[4]-48;
										 activate.mese_s=unita+(decine*10);
										 migliaia=(int)datazza[6]-48;
										 centinaia=(int)datazza[7]-48;
										 decine=(int)datazza[8]-48;
										 unita=(int)datazza[9]-48;
										 activate.anno_s=unita+(decine*10)+(centinaia*100)+(migliaia*1000);
										 decine=(int)datazza[11]-48;
										 unita=(int)datazza[12]-48;
										 activate.ora_s=unita+(decine*10);
										 decine=(int)datazza[14]-48;
										 unita=(int)datazza[15]-48;
										 activate.min_s=unita+(decine*10);
										 decine=(int)datazza[17]-48;
										 unita=(int)datazza[18]-48;
										 activate.sec_s=unita+(decine*10);
										 activate.tipolic=activate.anno_s-activate.anno_r;
										 printf("\n***Data scadenza: %d/%d/%d %d:%d:%d***\n",activate.gio_s,activate.mese_s,activate.anno_s,activate.ora_s,activate.min_s,activate.sec_s);

										 //resetto variabili con percorso
										 for(i=0;i<100;i++) {
																percorso[i]=(int)0;
																pathW.path_pathW[i]=(int)0;
																write.path_codificato[i]=(int)0;
															}
										 printf("\nInserisci il percorso: ");
										 gets(percorso);
										 if(strcmp(percorso,"auto")==0) {										
																			strcpy(pathW.path_pathW,directory);
																			for(i=0;i<100;i++) write.path_codificato[i]=(int)directory[i];
																		}
										 else
										 {
											strcpy(pathW.path_pathW,percorso);
											for(i=0;i<100;i++) write.path_codificato[i]=(int)percorso[i];
											strcpy(directory,percorso);
										 }
										 printf("\nPercorso salvato:\n%s\n",directory);


										 matrix_funzione(matrix2,i,write.codice,writepc.nomepc_w,activate.codice_a0,activate.codice_a1,activate.codice_a2,activate.codice_a3,activate.codice_a4,activate.codice_a5,activate.codice_a6,activate.controllo_a);  //questa è quella che viene scritta sui file alla prima generazione!!
										 for(i=0;i<10;i++) for(j=0;j<10;j++)
										 {
											writepc.matrice_w[i][j]=matrix2[i][j];
											pathW.matrice_pathW[i][j]=matrix2[i][j];
											write.matrice[i][j]=matrix2[i][j];
										 }

										 hash_rex_dll_funzione(pathW.path_pathW,writepc.nomepc_w,write.codice,write.controllo,write.codice_controlloic);//funziona per calcolare hash e scriverlo su rek.dll
										 for(i=0;i<20;i++) writepc.sha1_w[i]=sha1_fun[i];
										 for(i=0;i<16;i++) writepc.md5_w[i]=md5_fun[i];
										 for(i=0;i<20;i++) write.sha1[i]=sha1_fun[i];
										 for(i=0;i<16;i++) write.md5[i]=md5_fun[i];
										 for(i=0;i<20;i++) activate.sha1_dat[i]=sha1_fun[i];
										 for(i=0;i<16;i++) activate.md5_dat[i]=md5_fun[i];
										 for(i=0;i<20;i++) pathW.sha1_pathW[i]=sha1_fun[i];
										 for(i=0;i<16;i++) pathW.md5_pathW[i]=md5_fun[i];


									   }
}
//**********************************************************************************************************************************************************
//************************************************************************FINE SIMULATE*********************************************************************
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
				for(i=0;i<11;i++) write.codice[i]=0;        //imposto valore di fabbrica 
				for(i=0;i<30;i++) write.codice_controlloic[i]=0;        //imposto valore di fabbrica 
				for (i=0;i<16;i++) write.md5[i]=md5_fun[i];
				for (i=0;i<20;i++) write.sha1[i]=sha1_fun[i];
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
				for(i=0;i<20;i++) write.pcname[i]=0;      //imposto valore di fabbrica (ho scelto una volre a caso che in ascii è lo spazio      
				for(i=0;i<100;i++) write.path_codificato[i]=0;   //imposto valore di fabbrica (ho scelto una volre a caso che in ascii è l'uguale  
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
				for(i=0;i<30;i++) writepc.codice_controlloic_w[i]=0;        //imposto valore di fabbrica 
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
					for(i=0;i<11;i++) activate.codice_dat[i]=0;        //imposto valore di fabbrica 
					activate.controllo_dat=0;    
					for(i=0;i<30;i++) activate.codice_controlloic_a[i]=0;        //imposto valore di fabbrica 
					activate.codice_a0=0;
					activate.codice_a1=0;
					activate.codice_a2=0;
					activate.codice_a3=0; 
					activate.codice_a4=0;
					activate.codice_a5=0;
					activate.codice_a6=0;
					activate.tipolic=0;;
					activate.anno_s=0;
					activate.gio_r=0;
					activate.mese_r=0;
					activate.anno_r=0;
					activate.ora_r=0;
					activate.min_r=0;
					activate.sec_r=0;
					strcpy(activate.reg_a,"1234567");  //cioè non registrato     
					activate.controllo_a=0;                         //imposto valore di fabbrica, perchè se tutti num sono 0/7=0 con resto t, ma devo fare 7-7=0=controllo, quindi 0 è il valore inziale
					activate.inutile_a=12344;                       //imposto valore di fabbrica
					activate.inutile2_a=-546.451405;                //imposto valore di fabbrica
					activate.controllo_registrazione_a=22;           //imposto valore di fabbrica
					for(i=0;i<20;i++) activate.pcname_a[i]=0;      //imposto valore di fabbrica (ho scelto una volre a caso che in ascii è lo spazio      
					fseek(cfPtr,0,SEEK_SET); 
					fwrite(&activate,sizeof(struct activate_licData),1,cfPtr); //scrivo sul file i valori impostati prima come record
					fclose(cfPtr);                   //chiudo file
					printf("**************************************************************************\n");
					printf("*Ripristino informazioni a dati di fabbrica lic.dat avvenuto con successo*\n");
					printf("**************************************************************************\n");
		}   
	}


	if(strcmp(comando,"all")==0)
	{
		//resetto il file ks.dat
		printf("\n***Comando eseguito***\n");
		if ((cfPtr=fopen("ks.dat","rb+"))==NULL) printf("Errore L011\n");  //apro file in scrittura
		else {
				for(i=0;i<11;i++) write.codice[i]=0;        //imposto valore di fabbrica 
				for(i=0;i<30;i++) write.codice_controlloic[i]=0;        //imposto valore di fabbrica 
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
				for(i=0;i<20;i++) write.pcname[i]=0;      //imposto valore di fabbrica (ho scelto una volre a caso che in ascii è lo spazio      
				for(i=0;i<100;i++) write.path_codificato[i]=0;   //imposto valore di fabbrica (ho scelto una volre a caso che in ascii è l'uguale  
				for(z=0;z<10;z++) for(y=0;y<10;y++) write.matrice[z][y]=0; //resetto matrice
				fseek(cfPtr,0,SEEK_SET); 
				fwrite(&write,sizeof(struct writeData),1,cfPtr); //scrivo sul file i valori impostati prima come record
				fclose(cfPtr);                   //chiudo file
				printf("**************************************************************************\n");
				printf("*Ripristino informazioni a dati di fabbrica ks.dat avvenuto con successo**\n");
				printf("**************************************************************************\n");
			}        
		if ((cfPtr=fopen("rek.dll","rb+"))==NULL) printf("\n");       //apro file in scrittura
		else {                                                //imposto valore di fabbrica
				strcpy(writepc.nomepc_w,"XX-123456789012");                            //imposto valore di fabbrica
				for(i=0;i<30;i++) writepc.codice_controlloic_w[i]=0;        //imposto valore di fabbrica 
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
		if ((cfPtr=fopen("lic.dat","rb+"))==NULL) printf("Errore L012\n");  //apro file in scrittura
		else {
					for(i=0;i<11;i++) activate.codice_dat[i]=0;        //imposto valore di fabbrica 
					activate.controllo_dat=0;    
					for(i=0;i<30;i++) activate.codice_controlloic_a[i]=0;        //imposto valore di fabbrica 
					activate.codice_a0=0;
					activate.codice_a1=0;
					activate.codice_a2=0;
					activate.codice_a3=0; 
					activate.codice_a4=0;
					activate.codice_a5=0;
					activate.codice_a6=0;
					activate.tipolic=0;;
					activate.gio_s=0;
					activate.mese_s=0;
					activate.anno_s=0;
					activate.ora_s=0;
					activate.min_s=0;
					activate.sec_s=0;
					activate.gio_r=0;
					activate.mese_r=0;
					activate.anno_r=0;
					activate.ora_r=0;
					activate.min_r=0;
					activate.sec_r=0;
					strcpy(activate.reg_a,"1234567");  //cioè non registrato     
					activate.controllo_a=0;                         //imposto valore di fabbrica, perchè se tutti num sono 0/7=0 con resto t, ma devo fare 7-7=0=controllo, quindi 0 è il valore inziale
					activate.inutile_a=12344;                       //imposto valore di fabbrica
					activate.inutile2_a=-546.451405;                //imposto valore di fabbrica
					activate.controllo_registrazione_a=22;           //imposto valore di fabbrica
					for(i=0;i<20;i++) activate.pcname_a[i]=0;      //imposto valore di fabbrica (ho scelto una volre a caso che in ascii è lo spazio      
					fseek(cfPtr,0,SEEK_SET); 
					fwrite(&activate,sizeof(struct activate_licData),1,cfPtr); //scrivo sul file i valori impostati prima come record
					fclose(cfPtr);                   //chiudo file
					printf("**************************************************************************\n");
					printf("*Ripristino informazioni a dati di fabbrica lic.dat avvenuto con successo*\n");
					printf("**************************************************************************\n");
		}   
	}
}
//**********************************************************************************************************************************************************
//************************************************************************FINE RESTORE**********************************************************************
//**********************************************************************************************************************************************************






//**********************************************************************************************************************************************************
//***************************************************************************GENERATE***********************************************************************
//**********************************************************************************************************************************************************
if(strcmp(struttura,"generate")==0)
{  
   int codice[11];
   char string[11];
   int risposta[14];
   int i,tipolic,variabile,variabile2;
   printf("\nScegli il tipo di licenza\n");
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
}
//**********************************************************************************************************************************************************
//************************************************************************FINE GENERATE*********************************************************************
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
	  if(strcmp(comando,"all")==0){
									printf("\n***Comando eseguito***\n");
									if ((cfPtr=fopen("ks.dat","rb+"))==NULL) printf("Errore L013");  //apro file
									else {
			                        		fseek(cfPtr,0,SEEK_SET); 
			                        		fwrite(&write,sizeof(struct writeData),1,cfPtr); //scrivo sul file i valori impostati prima come record
			                        		fclose(cfPtr);                   //chiudo file
									     }   
									if ((cfPtr=fopen("rek.dll","rb+"))==NULL) printf("Errore L014");  //apro file
									else {
			                        		fseek(cfPtr,0,SEEK_SET); 
			                        		fwrite(&writepc,sizeof(struct writepcData),1,cfPtr); //scrivo sul file i valori impostati prima come record
			                        		fclose(cfPtr);                   //chiudo file
									     }   
									if ((cfPtr=fopen("lic.dat","rb+"))==NULL) printf("Errore L015");  //apro file
									else {
			                        		fseek(cfPtr,0,SEEK_SET); 
			                        		fwrite(&activate,sizeof(struct activate_licData),1,cfPtr); //scrivo sul file i valori impostati prima come record
			                        		fclose(cfPtr);                   //chiudo file
									     }   
									if ((cfPtr=fopen("license.lic","rb+"))==NULL) printf("Errore L016");  //apro file
									else {
			                        		fseek(cfPtr,0,SEEK_SET); 
			                        		fwrite(&license,sizeof(struct licenseData),1,cfPtr); //scrivo sul file i valori impostati prima come record
			                        		fclose(cfPtr);                   //chiudo file
									     }   
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
/*
printf("\n\n***************************************************\n\n");
for(z=0;z<10;z++){
			for(y=0;y<10;y++) printf("%d\t",matrix2[z][y]);
			printf("\n\n");
}*/
}