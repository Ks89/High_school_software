using namespace System;           //servono per le cose che faccio in c++
using namespace Microsoft::Win32; //servono per le cose che faccio in c++
//SOURCECODE BY KS89 (CAPPA STEFANO)
//BETA 17.1.0 SOURCECODE, funziona davvero!!!!!! Inoltre va bene sia su WINDOWS 7 x86 che x64!!! OTTIMO DAVVERO!
#include <stdlib.h>
#include <time.h>
#include <conio.h>
#include <iostream>
#include <openssl/sha.h>//essenziali per usare md5 e sha. Sono librerie di openssl da copiare nella cartella delle librerie di visual studio. Crecare stdio.h e nella cartella in cui si trova copiare dentro i 2 file
#include <openssl/md5.h>
#include <string.h>
#include <malloc.h>
#include <vcclr.h> //serve solo per calcolare la lunghezza del percorso generato da environment::currentdirectory e per il nome pc
#include <stdio.h>

//VERSIONE INNOVATIVA, MA ANCORA NON COMPLETA. QUESTA E' PERFETTA PER CODICE DI RISPOSTA, MA MOLTE COSE DEVONO ANCORA ESSERE IMPLEMENTATE.
//VEDERE 17.2.0 PER LE MODIFICHE SUCCESSIVE. USO PIU' VERSIONI PER TENERE IL BACKUP DI QUELLO PRIMA IN CASO FACESSI DANNI
 

//NON sopporta più la retrocompatibilità con ripristino fabbrica beta 8 e con versioni di LCL precedenti a beta 2.0.0 e con versioni di Generazione risposta precedenti a beta 5
//Richiede obbligatoriamente LCL beta 2.0.0 e anche GENERAZIONE RISPOSTA BETA 5 (le versioni prima non funzionano)

//GRANDISSIMI CAMBIAMENTI E NOVITA' Supera addirittura beta 16.0.0 per la quantità di cose nuove
//NOVITA':
//-Aggiornamento struttura licenza, da versione 1 alla versione 2
//-Aggiunta procedure per leggere l'ora del sistema per confrontarla con quella della licenza e vedere se scaduta o no
//-Integrata creazione lic.dat con dati scadenza e registrazione. Scrittura al primo utilizzo con dati 99 e 9999. Se registro a mano o con license.lic scrivo sul file lic.dat le info corrette
//-Introduzione differenza tra licenza HOME(durata annuale, biennale o triennale ma + economica) e PROFESSIONAL (durata illimitata, ma costosa)
//-Possibilità di convertire licenza versione 1 (cioè file license.lic creato da LightWall fino a beta 16.0.1) in versione 2, Home o professional
//-Miglioramento visione informazioni in scelta 3, cioè visualizzazione licenza


//2 Bug irrisolti per ora
//--il codice risposta sblocco ogni tanto da come numero anche un 10. Errore, devono essere sempre <=9 //davvero rarissimo
//--Problema sulla gestione del percorso con LCL. Da soli entrambi i programmi funzionano. Insieme però no, perchè il percorso scritto da LCL sui file non viene letto correttamente da LightWall



//NB: con la correzione dei bug sul percorso ora quando non ho dentro nessun dato, cioè non ho dei caratteri mi vengono riempiti con 32, cioè 0, così almeno evito numeri grandissimi non ammessi e casuali
//NB: se registro con codice risposta il codice utente è in write.codice o anche in codice che sono ugali. Ma se lo faccio con opzione 1, cioè avendo la licenza, apposta il codice utente cambia
     //diventando quello che avevo nel momento in cui avevo generato la licenza. In questo modo ogni utente potrà avere un solo codie utente che verrà creato durante la generazione e salvato sulla
     //licenza senza che possa essere cambiato, percè il program legge il codice sulla licenza e lo sostituisce a quello generato nel momento del primo avvio e permette la registrazione con i dati sul license.dat
     //acrivo questo per far notare, quindi che al primo avvio ho un md5 e un sha1 che vengono scritti su rek.dll, ma se registro con licenza, cambia codice utente e quindi cambia anche md5 e sha1
     //che di conseguenza vengono sostituiti sui vari file.   md5 e sha1 vengono creati con questa concatenazione in sequenza di dati:
     //percorso + nome pc + codice[0] +  codice[1] + codice[2] + codice[3] + codice[4] + codice[5] + codice[6] + write.controllo
//NB: sia se registro con codice che con licenza in ogni caso l'avvio del programma (dopo aver registrato, chiuso e riaperto) avviene perchè una variabile viene impostata a 22
     //questa fa si che venga saltata la scelta del metodo diregistrazione ed imposti automaticamente la scelta 2, cioè quella con codice che è progetta in modo tale che avvii il programma
     //anche se registrato tramite licenza.


//funzione che userò nel programma e dichiarata alla fine di tutto
void matrix_funzione(int matrix2[][10],int i,int codice[],char path[],int a1,int a2,int a3,int a4,int a5,int a6,int a7,int a8);


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


//Questa versione è perfettamente funzionante se legata con generazione rispostaBETA4 e ripristino fabbrica BETA7 (soprattutto questo, perchè nelle versioni precedenti i nomi dei file erano diversi
//IMPO=ho tolto return 0, per exit(0). leggi in fondo il commento che ho messo. In ogni caso, non toccare quell'istruzione
//I commenti /*IMPO!!*/ indicano il punto in cui si deve avviare il programma alla quale ho applicato questo sistema di protezione

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
	   char space[2];//inutile alla grande! serve solo a creare spazio tra pcname e pathcodificato se no il rispristino fabbrica sbaglia la lettura dei dati
	   int path_codificato[100];
	   int controllo_registrazione; //variabile che serve solo a far si che non venga più richiesta la scelta della modalità di registrazione se già registrato
	   int codice_controlloic[30];
	   int mixer3;
	   int mixer2;
	   int mixer1;
	   int mixer9;
	   int matrice[10][10];
};      

struct licenseData{     //record per scrivere file di licenza come backup. Questo ha l'aggiunta di informazioni personali, come la mail e nome e cognome e società a cui è intestata
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
	   int ora_s;
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
	   char version[5];
	  /* int codice_up[7];
	   int codice_com[7];
	   unsigned char md5_w[16];
	   unsigned char sha1_w[20];*/
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
	   char version[5];
	   /*int codice_up[7];
	   int codice_com[7];
	   unsigned char md5_w[16];
	   unsigned char sha1_w[20];*/
}; 

struct writepcData{  //record per scrivere nome pc
       char nomepc_w[20];
	   int codice_controlloic_w[30];
	   unsigned char md5_w[16]; //md5 e sha1 composti da percorso + nome pc  + codice + controllo
	   unsigned char sha1_w[20];
	   int matrice_w[10][10];
};        

struct pathWData{  //record per scrivere percorso
       char path_pathW[100];
	   int codice_controlloic_pathW[30];
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
   
   //variabili per il codice utente e risposta, nel caso in cui scelga la registrazione da codice e non da licenza
   int codice[11];           //codice è quello che uso per elaborare i dati. Questo diventa quello letto scritto con dei cicli for. Così sono sicuro di non toccare il record dei file quando non serve
   int risposta[14],scelta; //risposta ha il codice di risposta in caratteri usato per elaborare, che è diverso da risp_s, cioè la stringa
   int controllo_test;
   int verif_risp[14];      //questo vettore ha dentro la risposta generata dal codice,solo per vedere se presenta numeri <0 o >=10. Se si rigenera il codice utente da capo
   char risp_s[14];         //questa è la stringa che si acquisice da tastiera con dentro il codice di risposta, poi viene convertina in intero e assegnata a risposta[12] per poi poter fare le elaborazioni

   //variabili per la licenza
   char lic_s[12]; 
   char sblocco_risp_num[10]; // questo è il codice di sblocco di licenza inserito dall'utente
   int sblocco1[19]={0};      //da 0 a 18 //questo è quello generato
   int sblocco2[10];          //da 0 a 9, come quello sopra ma generato dal pc e confrontato con quello inserito dall'utente per dire se è corretto
   int fm1=1,fm2=0,lungh_mail=0;   
   int lic_risposta_perverifica[12];
   int codice_seriale_licenza[7];
   int nascondi_errore_x036=0; //questa variabile deriva da un bug risolto nelle versioni prima di 15.7.4 ma ricomparso in 15.7.4 dopo la risoluzione del bug sulle matrici.
                               //Questa non fa altro che nascondere il mex di errore x036 e nien'altro. Sembra stupida, ma non ho trovato valide alternative.

   //puntatori a strighe costanti, usate per le strcmp o altre funzioni delle stringhe che richiedono puntatori a stringhe
   char *c1="jhfiusw"; //non registrato //postrei definirle anche come costanti, perchè sono delle stringhe che uso per capire se programma è reg o no, con la funzione strcmp
   char *c2="jhfiusq"; //registrato
   
   //variabili temporanee usare per cicli oppure per mantenere dati che poi vengono assegnati ad altro, come isbn. first_exec è quella che contiene se il programma è stato eseguito la prima volta, oppure + volte
   int i=0,j=0,first_exec=0,h=0; //dati necessari per eseguire i controlli di registrazione, j la uso molte volte, perchè la ho sostituita con molte altre variabili che erano nelle versioni precedenti a 15.6 beta
   int isbn,isbn2;  //variabile usata per il codice di controllo come fatto da ISBN  

   //per le domanda durante creazione licenza
   int dimensione_domanda=0,risposta_corretta=0,dimensione_risposta=0,controllo_registrazione_variabile;
   char domanda[50]="";

   //tutto questo serve  perle cose fatte in c++ su percorsi e nome pc
   int lunghezza=0,lunghezza_namepc=0;//variabile che uso per calcolare lunghezza del percorso del file
   int path[100], controllo_percorso; //per salvataggio e controllo percorso
   int pc_name[20],controllo_nomepc;  //per salvataggio e controllo nome pc
   char nome_pc[20],directory[100];   //percorso e nome in char

   //variabili per matrice
   int matrix2[10][10]={{0},{0}},matrix[10][10]={{0},{0}},matrix3[10][10]={{0},{0}};

   //variabili usare per lo sblocco licenza, inr ealtà ne ho usate molte altre ma le ho dichiarate dove mi servivano   
   int testdamage_file=0,writecontrollo,activatecontrollodat,controllo_mixer=0;
	
   //variabili per vedere se codice sha e md5 sono corretti. Se sha=20 e md5=16 allora sono corretti, se no no. Ps se i percorsi file o nome utente sono diversi non esegue nemmeno il controllo, li pongo direttamente a 99 così sono sicuro che mi da l'errore di manomissione
    int indsha=0,indmd5=0; //ce ne sono molte altre, ma sono locali dentro alla funzione dichiarata sopra oppure addirittura in mezzo al main

	//variabili per orologio e licenza HOME/Professional
	int gio, mese, anno, gios, ora, min, sec;  //NB l'opzione CLR su queste procedure dell'orologio può anche essere disattivata, ma non per percorso e nomepc. almeno per ora
	int tipol=0;//indica il tipo di licenza, cioè indica il numero di anni di validità. Se il valore è 99, vuol dire illimitata
	int testora=0;//verifica se ora attuale è o no superiore o inf a quella di scadenza. Nel caso sia scaduto non permette esecuzione e distrugge i file
//*******************************************************fine dichiarazione varibili***************************************************************




//inizializzazzione delle strutture a 0 e "" per sicurezza e contemporaneamente le rinomino da writeData a write ecc... come se facessi un typedef(sinonimo)
struct writeData write={0,{0,0,0,0,0,0,0},0,0,0,"",0,0,0,0.0,{0},"",{0},0,{0},0,0,0,0};  //imposto valori standard nella struttura
struct licenseData license={{0,0,0,0,0,0,0},0,"","","","","",0,0.0,0,0,{0}};   
struct activate_licData activate;     //qui non inzializzo ma dichiaro solo il nome activate!. Volendo potrei anche inziializzare
struct writepcData writepc={"",{0}};  //record che uso per il nome del computer
struct pathWData pathW={"",{0},0};    //record che uso per il percorso dell'eseguibile

strcpy(write.space,"12");//gli metto dentro questi dati e non li cambierò mai. Mi servono solo per spaziare 2 dati nella struttura

//inzioprogramma
//prima di tutto scrivo i mixer1->mixer9 nel record. questi ci rimarrano sempre. questi dati li modifico qui e ogni volta che devo riscrivere ks.dat (per questioni di sicurezza). Dopo li leggerò soltanto
write.mixer1=1;
write.mixer2=4;
write.mixer3=8;
write.mixer4=5;
write.mixer5=1;
write.mixer6=7;
write.mixer7=0;
write.mixer8=2; 
write.mixer9=10;
pathW.cont_licenza=0; //azzero
//leggo il percorso dell'exe e lo assegno a directory.

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
if (err != 0) printf_s("Errore x00C: Contattare ks89\n"); //non ho la minima idea di come come risolvere sto bug, perchè non ho la minima idea di come funzioni sto pezzo in c++

//*************************************************************************************************
//*************************************************************************************************
lunghezza=strlen(ch); //cosi' ho la lunghezza e non uso altre varibili;

while(i<=lunghezza){
					directory[i]=ch[i]; //volendo potrei usare ch[i], ma originariamente il prog gestiva in modo diverso il percorso, per non cambiare tutti i directory, faccio un assegnamento così
					path[i]=(int)directory[i];
					i++;
					}
printf("\n %s \n",directory);
for(i=0;i<=lunghezza;i++) write.path_codificato[i]=path[i]; //metto il percorso codificato in numeri secondo ascii nel record
//*************************************************************************************************
//*************************************************************************************************
//fa lo stesso di sopra, ma questo serve per il nome del pc
wch = PtrToStringChars(Environment::MachineName);
convertedChars = 0;
sizeInBytes = ((Environment::MachineName->Length + 1) * 2);
err = 0;
char    *ch2 = (char *)malloc(sizeInBytes);  //dichiaro qui la variabile che mi serve, come anche tutte le altre che uso per questo pezzetto.

err = wcstombs_s(&convertedChars,ch2, sizeInBytes,wch, sizeInBytes);
if (err != 0) printf_s("Errore x00D: Contattare ks89\n"); //non ho la minima idea di come come risolvere sto bug, perchè non ho la minima idea di come funzioni sto pezzo in c++
//*************************************************************************************************
//*************************************************************************************************

lunghezza_namepc=strlen(ch2);
strcpy(nome_pc,ch2);
printf("\n %s \n",nome_pc);
for(i=0;i<lunghezza_namepc;i++) pc_name[i]=(int)nome_pc[i];
for(i=0;i<=lunghezza_namepc-1;i++) { //tolgo 1 perchè nome_pc + strina con carattere \0 alla fine. Questo convertirebbe anche quello, così io lo tolgo
								write.pcname[i]=pc_name[i];     //metto il percorso codificato in numeri secondo ascii nel record
								}

if ((cfPtr=fopen("ks.dat","rb"))==NULL) printf("Errore x001\n"); //leggo file con tutti i dati per vedere se è il primo avvio
else {
     fread(&write,sizeof(struct writeData),1,cfPtr);
     controllo_registrazione_variabile=write.controllo_registrazione;
	 fclose(cfPtr);
     }                                                                                                                                                                                                                                                        
if (strcmp(write.reg,c1)==0)
{                                                                                                                                   
    if ((write.codice[0]==0) && (write.codice[1]==0) && (write.codice[2]==0) && (write.codice[3]==0) && (write.codice[4]==0) && (write.codice[5]==0) &&
		(write.codice[6]==0) && (write.codice[7]==0) && (write.codice[8]==0) && (write.codice[9]==0) && (write.codice[10]==0) && (write.controllo==0)) first_exec=1;
    else first_exec=0; 
}





//SE PRIMA ESECUZIONE
if (first_exec==1) {
					printf("\n Prima esecuzione \n");
					do{ //eseguo almeno una volta la generazione del codice, ma se alla fine mi creasse numeri non ammessi nella risposta rigenero il codice finchè le condizioni non mi vanno bene
                        srand( time( NULL) );   //rimescolo in numeri casuali
                        write.codice[0]=4;      //inizializzo alcuni elementi per essere sicuro di eseguire il while
                        write.codice[1]=8;
                        write.codice[3]=14;                                     
                        //genero il codice casuale col resto della divisione e nel while impongo alcune condiz per non avere numeri >=10 
                        while ((write.codice[0]+write.codice[1]<=write.codice[3]) && (write.codice[0]+write.codice[1]>9))
						{         
                              srand( time( NULL) ); 
                              write.codice[0]=rand() % 7;
                              write.codice[1]=rand() % 5 + 1;
                              write.codice[3]=rand() % 3;
                        }
                        write.codice[2]=rand() % 5 + 2;
                        write.codice[4]=rand() % 6 + 1;

						// quei leggo la versione di windows con il linguaggio c++ e la classe Environment. Su MSDN è spiegato.
						OperatingSystem^ osv = Environment::OSVersion;
						PlatformID id = osv->Platform;
						Version^ version = osv->Version;
						if (version)
						{
							write.codice[5] = version->Major;
							write.codice[6] = version->Minor;
							if ((write.codice[5]+write.codice[6]-4>=10) || (write.codice[5]-write.codice[6]+1>=10)) printf("\nErrore x002\n");
							if ((write.codice[5]+write.codice[6]-4<0) || (write.codice[5]-write.codice[6]+1<0)) printf("\nErrore x003\n");
						}

						write.codice[7]=rand() % 2 + 1;
                        write.codice[8]=rand() % 4 + rand() %3 + 2;
						write.codice[9]=rand() % 9;
						//faccio isbn solo sulle cifre da 1 a 9 (escludo la 0) in questo modo ho 10 cifre e la formula è 10-(...)%10. Se facessi 11 cifre potrei ottenere anche un 10 come cifra 10 del codice, generata sotto nel modo appena citato
						write.codice[10]=10-(((write.codice[1]*9)+(write.codice[2]*8)+(write.codice[3]*7)+(write.codice[4]*6)+(write.codice[5]*5)+(write.codice[6]*4)+(write.codice[7]*3)+(write.codice[8]*2))%10);

						verif_risp[0]=write.codice[3]+write.codice[7]-1;
   						verif_risp[1]=write.codice[0]+write.codice[1]-write.codice[3];
   						verif_risp[2]=write.codice[0]+write.codice[7]-1;
   						verif_risp[3]=write.codice[4]+2;
   						verif_risp[4]=write.codice[4]+1;
   						if((write.codice[5]-write.codice[6])>=0) verif_risp[5]=(write.codice[5]-write.codice[6]);
						else verif_risp[5]=(write.codice[5]-write.codice[6])*(-1);
   						verif_risp[6]=write.codice[1]-1;
   						verif_risp[7]=write.codice[8]+write.codice[7]-3;
   						verif_risp[8]=write.codice[2]+write.codice[3]-1;

   						verif_risp[9]=(write.codice[7]*2)-1;//home
						int v_risp_9=(write.codice[7]*2)-2;//professional

						verif_risp[10]=write.codice[2]+2;

						verif_risp[11]=write.codice[1]+1;//1 anno di durata
						int v_risp_11_2=write.codice[1]+2;//2 anni di durata
						int v_risp_11_3=write.codice[1]+3;//3 anni di durata
						printf("\n %d %d %d %d \n",verif_risp[11],v_risp_11_2,v_risp_11_3,v_risp_9);
						
						verif_risp[12]=write.codice[5]-1;
						int verif_risp_isbn1=10-(((verif_risp[0]*9)+(verif_risp[1]*8)+(verif_risp[2]*7)+(verif_risp[3]*6)+(verif_risp[4]*5)+(verif_risp[5]*4)+(verif_risp[6]*3)+(verif_risp[7]*2))%10);
						verif_risp[13]=8-(((verif_risp_isbn1*7)+(verif_risp[8]*6)+(verif_risp[9]*5)+(verif_risp[10]*4)+(verif_risp[11]*3)+(verif_risp[12]*2))%8);

						j=0;								// si alza ad 1 se il codice utente generasse una risposta con numeri non concessi
						for(i=0;i<14;i++) if ((verif_risp[i]>=10) || (verif_risp[i]<0) /*|| (v_risp_9>=10) || (v_risp_11_2>=10) || (v_risp_11_3>=10)*/) j=1; //errata contente numeri non ammessi, si alza il falg test-ver_risp che fa ripete il ciclo do-while                                     
					}while(j==1);

						printf("\nTest nuovo codice: ");
						for(i=0;i<11;i++) printf("%d ",write.codice[i]);

						printf("\nTest nuova risposta: ");
						for(i=0;i<14;i++) printf("%d ",verif_risp[i]);
						printf("\n");


                        //qui genero la cifra di controllo con algoritmo ISBN. Lo faccio 2 volte su tutte le cifre, a volte anche 2 volte la stessa cifra. NOVITA' BETA 17.0.0. infatti prima era poso sicuro perchè solo sulle prime 5 cifre
                        controllo_test=10-(((write.codice[0]*9)+(write.codice[1]*8)+(write.codice[2]*7)+(write.codice[3]*6)+(write.codice[4]*5)+(write.codice[5]*4)+(write.codice[6]*3)+(write.codice[7]*2))%10);
                        write.controllo=10-(((controllo_test*9)+(write.codice[8]*8)+(write.codice[9]*7)+(write.codice[10]*6)+(write.codice[0]*5)+(write.codice[1]*4)+(write.codice[2]*3)+(write.codice[5]*2))%10);


						//qui genero il codice controllo lic in modo da associare ks.dat e tutti altri file a file lid.dat e così non si può bypassare registrazione sostituendo il file dopo che il programma sia stato riavviato qualche volta premendo 1 e risponendo alla domanda
						for(i=0;i<30;i++) activate.codice_controlloic_a[i]=rand()%9;
						for(i=0;i<30;i++) write.codice_controlloic[i]=activate.codice_controlloic_a[i];
						for(i=0;i<30;i++) writepc.codice_controlloic_w[i]=activate.codice_controlloic_a[i];
						for(i=0;i<30;i++) pathW.codice_controlloic_pathW[i]=activate.codice_controlloic_a[i];

                        fseek(cfPtr,0,SEEK_SET);
                        fwrite(&pathW,sizeof(struct pathWData),1,cfPtr); 
                        fclose(cfPtr);  

                        fseek(cfPtr,0,SEEK_SET);
                        fwrite(&writepc,sizeof(struct writepcData),1,cfPtr); 
                        fclose(cfPtr);  

						//*****************************************************************************
						//ora genero il codice licenza riutilizzando le variabili sfruttate prima

						srand( time( NULL) );                   //rimescolo in numeri casuali
						activate.codice_a2=rand() % 8 + 1;      //inizializzo alcuni elementi per essere sicuro di eseguire il while
                        activate.codice_a4=rand() % 8 + 1;
                        activate.codice_a3=rand() % 3 + 1; 
						activate.codice_a5=write.codice[5];     //questa è la versione di windows
						activate.codice_a6=write.codice[6];     //anche qui
                        activate.codice_a0=(((rand() % 9)*3)/(activate.codice_a2+activate.codice_a3-1))%9;
						activate.codice_a1=8-(((activate.codice_a0*7)+(activate.codice_a2*6)+(activate.codice_a3*5)+(activate.codice_a4*4)+(activate.codice_a5*3)+(activate.codice_a6*2))%8);
	                               
                        //qui genero la cifra di controllo con algoritmo ISBN solo delle prime 5 cifre del codice licenza. Quindi non viene compresa la versione di windows   
                        activate.controllo_a=7-(((activate.codice_a0*6)+(activate.codice_a1*5)+(activate.codice_a2*4)+(activate.codice_a3*3)+(activate.codice_a4*2))%7);
                    

                        //*********************algoritmo matrix*************************
						matrix_funzione(matrix2,i,write.codice,ch2,activate.codice_a0,activate.codice_a1,activate.codice_a2,activate.codice_a3,activate.codice_a4,activate.codice_a5,activate.codice_a6,activate.controllo_a);  //questa è quella che viene scritta sui file alla prima generazione!!
                       		
						//qui avviene la scrittura. Ho già testato e sembra che scriva giusto
						for(i=0;i<10;i++) for(j=0;j<10;j++)
                        {
						writepc.matrice_w[i][j]=matrix2[i][j];
						pathW.matrice_pathW[i][j]=matrix2[i][j];
						write.matrice[i][j]=matrix2[i][j];
						matrix[i][j]=matrix2[i][j];//questo lo faccio perchè la funzione agisce su variabile locale. Io copio tutto in una che voglio sfruttare anche dopo
                        }
                        //***************************************************************


                        if ((cfPtr=fopen("ks.dat","rb+"))==NULL) printf("Errore x004\n");
                        else {                              
                             strcpy(write.reg,"jhfiusw"); //non registrato
                             //il codice lo ho già generato sopra e quindi è già in write.codice 
                             //la cifra di controllo la ho generata già sopra
							 //i codici controllo lic li ho già generati sopra
							 write.mixer1=1; //riscrivo anche i mixer
							 write.mixer2=4;
						     write.mixer3=8;
							 write.mixer4=5;
							 write.mixer5=1;
							 write.mixer6=7;
							 write.mixer7=0;
							 write.mixer8=2;
							 write.mixer9=10;
                             write.inutile=12344;
                             write.inutile2=-546.451405;
							 write.controllo_registrazione=22; //cioè non registrato, perchè non ho ancora messo il codice di risposta o il file di licenza
							 
							 //***********nuovo della beta 16.0.0-> risolve il bug 2 indicato sopra sul salvataggio del percorso*********
							 int lung_pcname=0,contatore=0;
							 while(contatore<=20)
							 {
								 if(pc_name[lung_pcname]<127 && pc_name[lung_pcname]>=32) lung_pcname++;
								 contatore++;
							 }//qui ho calcolato la lunghezza del nome pc considerando possibili solo i caratteri tra scii 127 e 32
								
							 for(i=0;i<lung_pcname;i++) {
										write.pcname[i]=pc_name[i]; //metto il nome pc codificato in numeri secondo ascii nel record per scrivere sul file
									//printf(" %d ",write.pcname[i]);
							 }
							 //***********************************************************************************************************

							 for(i=0;i<=lunghezza;i++) write.path_codificato[i]=path[i];
                             fseek(cfPtr,0,SEEK_SET);
                             fwrite(&write,sizeof(struct writeData),1,cfPtr); 
                             fclose(cfPtr);      
                             }  

						/*printf("\nlung namepc: %d\n",lunghezza_namepc);*/
						for(i=0;i<20;i++) activate.pcname_a[i]=(int)32;

		
					    if ((cfPtr=fopen("lic.dat","w"))==NULL) printf("Errore x005\n");
					    else{
							if ((cfPtr=fopen("lic.dat","rb+"))==NULL) printf("Errore x006\n");  //scrivo il codice sul file riscrivendo anche tutti gli altri dati per sicurezza
							else {                            
                               strcpy(activate.reg_a,"1234567"); //non registrato
							   //qui resetto i dati a fabbrica per evitare che vengano letti dei dati sbagliati
							   activate.tipolic=0;
							   activate.gio_s=99;
							   activate.mese_s=99;
							   activate.anno_s=9999;
							   activate.ora_s=99;
							   activate.min_s=99;
							   activate.sec_s=99;
							   activate.gio_r=99;
							   activate.mese_r=99;
							   activate.anno_r=9999;
							   activate.ora_r=99;
							   activate.min_r=99;
							   activate.sec_r=99;
							   //metto il codice di wirte in lic.dat
							   for(i=0;i<11;i++) activate.codice_dat[i]=write.codice[i];
							   activate.controllo_dat=write.controllo;
                               //il codice lo ho già generato sopra e quindi è già in write.codice 
                               //la cifra di controllo la ho generata già sopra
                               activate.inutile_a=12344;
                               activate.inutile2_a=-546.451405;
							   activate.controllo_registrazione_a=22; //cioè non registrato, perchè non ho ancora messo il codice di risposta o il file di licenza
							   for(i=0;i<lunghezza_namepc;i++) activate.pcname_a[i]=pc_name[i]; //metto il nome pc codificato in numeri secondo ascii nel record per scrivere sul file
                               fseek(cfPtr,0,SEEK_SET);
                               fwrite(&activate,sizeof(struct activate_licData),1,cfPtr); 
                               fclose(cfPtr);      
							     }
                             }  
						/*printf("\n\n %s %d%d%d%d%d%d%d %d %d %f %d\n\n",activate.reg_a,activate.codice_dat[0],activate.codice_dat[1],activate.codice_dat[2],activate.codice_dat[3],activate.codice_dat[4],
							activate.codice_dat[5],activate.codice_dat[6],activate.controllo_dat,activate.inutile_a,activate.inutile2_a,activate.controllo_registrazione_a);
						for(i=0;i<20;i++) printf("%d ",activate.pcname_a[i]);
						printf("\n\n");*/


						/*if ((cfPtr=fopen("lic.dat","rb"))==NULL) printf("Errore x013\n");          
						else {                                                                          
							fread(&activate,sizeof(struct activate_licData),1,cfPtr);                                          
							fclose(cfPtr);
						} 
						printf("\n\n %s %d%d%d%d%d%d%d %d %d %f\n\n",activate.reg_a,activate.codice_dat[0],activate.codice_dat[1],activate.codice_dat[2],activate.codice_dat[3],activate.codice_dat[4],
							activate.codice_dat[5],activate.codice_dat[6],activate.controllo_dat,activate.inutile_a,activate.inutile2_a,activate.controllo_registrazione_a);
						for(i=0;i<20;i++) printf("%d ",activate.pcname_a[i]);
						printf("\n\n");*/


						//fine elaborazione file lic.dat e fine algoritmo lic.dat


                        for(i=0;i<11;i++) codice[i]=write.codice[i];   //cioè metto in un array i dati che ho già scritto per elaborare dopo senza rischiare di toccare il file

				        if ((cfPtr=fopen("irr.dat","w"))==NULL) printf("Errore x009\n");
				        else{
					         if ((cfPtr=fopen("irr.dat","rb+"))==NULL) printf("Errore x010\n");
					         else {                           
						           strcpy(pathW.path_pathW,directory); //cioè inserisco il persorso
						           fseek(cfPtr,0,SEEK_SET);
						           fwrite(&pathW,sizeof(struct pathWData),1,cfPtr); 
						           fclose(cfPtr);
							 }
				        }
						
						strcpy(writepc.nomepc_w,nome_pc); //cioè inserisco il nome del pc

						//****Aggiunta in beta 16.0.0 Serve per generare e salvare md5 e sha1 su file rek.dll****************************************************
                        hash_rex_dll_funzione(pathW.path_pathW,writepc.nomepc_w,codice,write.controllo);//funziona per calcolare hash e scriverlo su rek.dll

						for(i=0;i<20;i++) writepc.sha1_w[i]=sha1_fun[i];
						for(i=0;i<16;i++) writepc.md5_w[i]=md5_fun[i];
						//*****************************************************************************************************************************************

						//salvo file con nome pc ecc.. e anche md5 e sha-1 generati dalla funzione sopra
						if ((cfPtr=fopen("rek.dll","w"))==NULL) printf("Errore x007\n");
					    else{
					         if ((cfPtr=fopen("rek.dll","rb+"))==NULL) printf("Errore x008\n");
					         else {                              
						           fseek(cfPtr,0,SEEK_SET);
						           fwrite(&writepc,sizeof(struct writepcData),1,cfPtr); 
						           fclose(cfPtr); 
                             } 
				        }				

				   } //CHIUDE L'IF DEL FIRTS_EXEC
else for(i=0;i<11;i++) codice[i]=write.codice[i]; 

//qui in ogni caso mi trovo in codice[i] il codice utente sia che sia la prima esecuzione che le successive


//rileggo il file per sicurezza, in verità non servirebbe perchè lo ho già letto prima dell'if firstexec, ma non si sa mai, almeno mi assicuro di leggere i file con i dati appena scritti in
//first_exec nel caso sia la prima volta che lo avvio
if ((cfPtr=fopen("rek.dll","rb"))==NULL) printf("Errore x011\n");          
else {                                                                          
      fread(&writepc,sizeof(struct writepcData),1,cfPtr);                                           
      fclose(cfPtr);
     }  
if ((cfPtr=fopen("irr.dat","rb"))==NULL) printf("Errore x012\n");          
else {                                                                          
      fread(&pathW,sizeof(struct pathWData),1,cfPtr);                                          
      fclose(cfPtr);
     } 
if ((cfPtr=fopen("lic.dat","rb"))==NULL) printf("Errore x013\n");          
else {                                                                          
      fread(&activate,sizeof(struct activate_licData),1,cfPtr);                                          
      fclose(cfPtr);
     } 
if ((cfPtr=fopen("ks.dat","rb"))==NULL) printf("Errore x014\n");
else {
     fread(&write,sizeof(struct writeData),1,cfPtr);
     fclose(cfPtr);
     } 

//necessario per risolvere bug licenza che da errore x036 dopo 3 tentativi di attivazione
if (pathW.cont_licenza<=0 || pathW.cont_licenza>=3) nascondi_errore_x036=1;
else nascondi_errore_x036=0;

for(i=0;i<lunghezza_namepc;i++) {
				  if(write.pcname[i]==nome_pc[i]) controllo_nomepc=1;        //controllo se il nome pc salvato nel file ks è uguale al nome del pc in uso
				  else controllo_nomepc=0;
			      }

for(i=0;i<=lunghezza;i++) {
				  if(write.path_codificato[i]==path[i]) controllo_percorso=1; //controllo se il nome pc salvato nel file ks è uguale al nome del pc in uso
				  else controllo_percorso=0;
			      }

/*printf("\n");
for(i=0;i<100;i++) printf("%c ",path[i]);
printf("\n");
for(i=0;i<100;i++) printf("%c ",write.path_codificato[i]);
printf("\n");
printf("\n%s\n***\n%s\n",path,write.path_codificato);*/

//qui genero la cifra di controllo con algoritmo ISBN. Lo faccio 2 volte su tutte le cifre, a volte anche 2 volte la stessa cifra. NOVITA' BETA 17.0.0. infatti prima era poso sicuro perchè solo sulle prime 5 cifre

controllo_test=10-(((write.codice[0]*9)+(write.codice[1]*8)+(write.codice[2]*7)+(write.codice[3]*6)+(write.codice[4]*5)+(write.codice[5]*4)+(write.codice[6]*3)+(write.codice[7]*2))%10);
if (write.controllo==10-(((controllo_test*9)+(write.codice[8]*8)+(write.codice[9]*7)+(write.codice[10]*6)+(write.codice[0]*5)+(write.codice[1]*4)+(write.codice[2]*3)+(write.codice[5]*2))%10)) isbn=1;   //è 1 se il codice di controllo è ok. 
else isbn=0;

int controllo_lic_test=10-(((activate.codice_dat[0]*9)+(activate.codice_dat[1]*8)+(activate.codice_dat[2]*7)+(activate.codice_dat[3]*6)+(activate.codice_dat[4]*5)+(activate.codice_dat[5]*4)+(activate.codice_dat[6]*3)+(activate.codice_dat[7]*2))%10);
if (activate.controllo_dat==10-(((controllo_lic_test*9)+(activate.codice_dat[8]*8)+(activate.codice_dat[9]*7)+(activate.codice_dat[10]*6)+(activate.codice_dat[0]*5)+(activate.codice_dat[1]*4)+(activate.codice_dat[2]*3)+(activate.codice_dat[5]*2))%10)) isbn2=1;   //è 1 se il codice di controllo è ok. 
else isbn2=0;
printf("\n %d %d \n",write.controllo,activate.controllo_dat);



//Novità beta 15.7.3 Qui metto algoritmo che verifica con la matrice se i file rek,irr e ks hanno stessa matrice e se questi dati provengono da codice utente e altri dati dentro matrice
//*****************************************************************************************************************
matrix_funzione(matrix2,i,write.codice,ch2,activate.codice_a0,activate.codice_a1,activate.codice_a2,activate.codice_a3,activate.codice_a4,activate.codice_a5,activate.codice_a6,activate.controllo_a);  //questa è quella che viene scritta sui file alla prima generazione!!                   

for(i=0;i<10;i++) for(j=0;j<10;j++) if(write.matrice[i][j]==writepc.matrice_w[i][j] && write.matrice[i][j]==pathW.matrice_pathW[i][j]) h++;

if (strcmp(activate.reg_a,"1234667")!=0)
{
 if (h==100)
 {
	h=0;
	for(i=0;i<10;i++) for(j=0;j<10;j++) if(matrix2[i][j]==write.matrice[i][j]) h++;
 }
else h=0;
}


//*************************************Novità beta 16.0.0 verifica md5 e sha1**************************************
if((strcmp(writepc.nomepc_w,nome_pc)==0) && (strcmp(pathW.path_pathW,directory)==0))
{
 hash_rex_dll_funzione(pathW.path_pathW,writepc.nomepc_w,codice,write.controllo);//funziona per calcolare hash, ma qui non scrivo nulla sul rek.dll, anzi mi serve per controllare se quello
		 																		//appena generato combacia con quello su rek.dll
 for(i=0;i<20;i++) if(writepc.sha1_w[i]==sha1_fun[i]) indsha++;
 for(i=0;i<16;i++) if(writepc.md5_w[i]==md5_fun[i]) indmd5++;
}
else {
	  printf("\nErrore x099 : Rilevata manomissione file\n");
	  indmd5=99;//metto 2 valori a valori che non potrebbero mai uscire, così sono sicuro che hash sono sbagliato e allora non devo avviare programma
	  indsha=99;
     }
//****************************************************************************************************************************************************************************************

/*
printf("\n\n %s %d%d%d%d%d%d%d %d %d %f\n\n",activate.reg_a,activate.codice_dat[0],activate.codice_dat[1],activate.codice_dat[2],activate.codice_dat[3],activate.codice_dat[4],
							activate.codice_dat[5],activate.codice_dat[6],activate.controllo_dat,activate.inutile_a,activate.inutile2_a,activate.controllo_registrazione_a);
for(i=0;i<20;i++) printf("%d ",activate.pcname_a[i]);
printf("\n\n");
*/


//********************************************************************************INIZIO IF ENORME****************************************************************************************
//****************************************************************************************************************************************************************************************


printf("\n IF enorme: %d %d %d %d %d %f %d %d %f %d %d %d\n",strcmp(writepc.nomepc_w,nome_pc)==0,strcmp(pathW.path_pathW,directory)==0,controllo_nomepc,controllo_percorso,write.inutile,write.inutile2,isbn2,activate.inutile_a,activate.inutile2_a,h,indsha,indmd5);


//*NOVITA' BETA 17.0.0
//Leggo data da sistema e verifico se sup o inf a quella di scadenza della licenza. in base al risultato menno a 0 o 1 testora
now(gio,mese,anno,gios,ora,min,sec); //leggo data
printf("\n%d-%d-%d  %d:%d:%d\n",gio,mese,anno,ora,min,sec);
printf("\nR:%d-%d-%d  %d:%d:%d\n",activate.gio_r,activate.mese_r,activate.anno_r,activate.ora_r,activate.min_r,activate.sec_r);
printf("\nS:%d-%d-%d  %d:%d:%d\n",activate.gio_s,activate.mese_s,activate.anno_s,activate.ora_s,activate.min_s,activate.sec_s);

if(anno<=activate.anno_s){
	if(anno==activate.anno_s){
		if(mese<=activate.mese_s){
			if(mese==activate.mese_s){	
				if(gio<=activate.gio_s){
					if(gio==activate.gio_s){
						if(ora<=activate.ora_s){
							if(ora==activate.ora_s){
								if(min<=activate.min_s){
									if(min==activate.min_s){
										if(sec<=activate.sec_s){
											if(sec==activate.sec_s) testora=1;
											else testora=1;
										}else testora=0;
									}else testora=1;
								}else testora=0;
							}else testora=1;
						}else testora=0;
					}else testora=1;
				}else testora=0;
			}else testora=1;
		}else testora=0;
	}else testora=1;
}else testora=0;

printf("\n %d \n",testora);
system("PAUSE");

if(testora==1)//If gigante che racchiude l'altro if gigante. Entra qui se licenza non scaduta
{
//QUESTO E' UN IF ENORME CHE CHIUDE ALLA FINE DEL PROGRAMMA
if ((strcmp(writepc.nomepc_w,nome_pc)==0) && (strcmp(pathW.path_pathW,directory)==0) && (controllo_nomepc==1) && (controllo_percorso==1) && (write.inutile==12344) &&
	(write.inutile2==-546.451405) && (isbn2==1) && (activate.inutile_a==12344) && (activate.inutile2_a==-546.451405) && (h==100) && (indsha==20) && (indmd5==16) && (testora==1))
{//QUI APRO L'IF GIGANTESCO CHE SI CHIUDE MOLTO PIU' AVANTI

printf("             *****************************************************\n");
printf("             *..::Benvenuto in LIGHTWALL BETA 17.1.0 by ks89!::..*\n");
printf("             *****************************************************\n\n");

if (controllo_registrazione_variabile==22){ // fa si che se già registrato non richieda la modalità di registrazione. A 32 vuol dire registrato
			printf("Possiedi i file di licenza? Oppure vuoi procedere ad una nuova registrazione?\n");
			printf("Inserisci '1' se possiedi i file di licenza\n");
			printf("Inserisci '2' se vuoi registrarti\n");
			printf("Inserisci '3' se vuoi vedere la licenza\n");
			scanf("%d",&scelta);
			}
else scelta=2;


//*******************************************************************************
//*******************************************************************************
//****************************SE HO IL FILE DI LICENZA***************************
//*******************************************************************************
//*******************************************************************************
if (scelta==1){

				if ((cfPtr=fopen("ks.dat","rb"))==NULL) printf("Errore x018\n");       
				else {
					  fread(&write,sizeof(struct writeData),1,cfPtr);
					  fclose(cfPtr);
                     }  

              if ((cfPtr=fopen("license.lic","rb"))==NULL) printf("File di licenza non trovato. Errore x015\n");
              else{
				fread(&license,sizeof(struct licenseData),1,cfPtr);
				fclose(cfPtr);
				if ((cfPtr=fopen("lic.dat","rb"))==NULL) printf("File lic non trovato. Errore x016\n");
				else{
                    fread(&activate,sizeof(struct activate_licData),1,cfPtr);
					fclose(cfPtr);                                              
                    //ora controllo che la cifra di controllo sia corretta

					controllo_test=10-(((license.codice_x[0]*9)+(license.codice_x[1]*8)+(license.codice_x[2]*7)+(license.codice_x[3]*6)+(license.codice_x[4]*5)+(license.codice_x[5]*4)+(license.codice_x[6]*3)+(license.codice_x[7]*2))%10);
					if (license.controllo_x==10-(((controllo_test*9)+(license.codice_x[8]*8)+(license.codice_x[9]*7)+(license.codice_x[10]*6)+(license.codice_x[0]*5)+(license.codice_x[1]*4)+(license.codice_x[2]*3)+(license.codice_x[5]*2))%10)) isbn=1;   //è 1 se il codice di controllo è ok. 
					else isbn=0;
					
					//da questo punto c'è un metodo molto macchinoso e onestamente complicato, spero di non doverlo mai cambiare :)
					//da qui non uso altre variabili domanda o risposta, perchè tanto il case fa si che solo una condizione valga e quindi mi bastano solo questi 2 vettori
					getchar(); //senza, non so perchè mi salta l'acqusizione della domanda, all'interno del case
				    switch(license.num_domanda_x){
						case 1:
							   printf("\n\nDomanda1: Qual'e' il tuo colore preferito? :");
							   gets(domanda);                                //acquisisco domanda1 permettendo anche l'inserimento degli spazi
							   dimensione_domanda=strlen(domanda);           //calcolo dimensione
							   risposta_corretta=0;                          //inizializzo per sicurezza a 0
							   for(i=0;i<dimensione_domanda;i++) domanda[i]=(int)domanda[i]; //assegno domanda1 a risposta
							   i=0;                                          //inizializzo per il while
							   while(license.domanda_x[i]!=0) i++;           //uscito dal while mi trovo con i=dimensione_risposta. Questo funziona solo grazie alle inizializzazioni a 0 all'inizio del programma
							   dimensione_risposta=i;
							   for(i=0;i<dimensione_domanda;i++) {
																if (license.domanda_x[i]==domanda[i]) risposta_corretta++; //alla fine se risposta_corretta=dimensione_domanda=dimensione_risposta vuol dire che è giusto
																else risposta_corretta=0;
																}
							   break;
						case 2:
							   printf("\n\nDomanda2: Dai un voto a questo programma (scrivi in lettere) :");
							   gets(domanda); 
							   dimensione_domanda=strlen(domanda); 
							   risposta_corretta=0; 
							   for(i=0;i<dimensione_domanda;i++) domanda[i]=(int)domanda[i]; 
							   i=0; 
							   while(license.domanda_x[i]!=0) i++;
							   dimensione_risposta=i;
							   for(i=0;i<dimensione_domanda;i++) {
																if (license.domanda_x[i]==domanda[i]) risposta_corretta++;
																else risposta_corretta=0;
																}
							   break;
						case 3:
							   printf("\n\nDomanda3: Qual'e' il tuo film preferito? :");
							   gets(domanda);
							   dimensione_domanda=strlen(domanda); 
							   risposta_corretta=0;
							   for(i=0;i<dimensione_domanda;i++) domanda[i]=(int)domanda[i]; 
							   i=0; 
							   while(license.domanda_x[i]!=0) i++;
							   dimensione_risposta=i;
							   for(i=0;i<dimensione_domanda;i++) {
																if (license.domanda_x[i]==domanda[i]) risposta_corretta++; 
																else risposta_corretta=0;
																}
							   break;
						case 4:
							   printf("\n\nDomanda4: Qual'e' la tua eta (in lettere)? :");
							   gets(domanda); 
							   dimensione_domanda=strlen(domanda); 
							   risposta_corretta=0; 
							   for(i=0;i<dimensione_domanda;i++) domanda[i]=(int)domanda[i]; 
							   i=0; 
							   while(license.domanda_x[i]!=0) i++; 
							   dimensione_risposta=i;
							   for(i=0;i<dimensione_domanda;i++) {
																if (license.domanda_x[i]==domanda[i]) risposta_corretta++; 
																else risposta_corretta=0;
																}
							   break;
						case 5:
							   printf("\n\nDomanda5: Qual'e' la citta' in cui sei nato? :");
							   gets(domanda); 
							   dimensione_domanda=strlen(domanda);
							   risposta_corretta=0; 
							   for(i=0;i<dimensione_domanda;i++) domanda[i]=(int)domanda[i];
							   i=0; 
							   while(license.domanda_x[i]!=0) i++; 
							   dimensione_risposta=i;
							   for(i=0;i<dimensione_domanda;i++) {
																if (license.domanda_x[i]==domanda[i]) risposta_corretta++; 
																else risposta_corretta=0;
																}
							   break;
						case 6:
							   printf("\n\nDomanda6: Qual'e' la mrca del tuo televisore? :");
							   gets(domanda);
							   dimensione_domanda=strlen(domanda);
							   risposta_corretta=0; 
							   for(i=0;i<dimensione_domanda;i++) domanda[i]=(int)domanda[i]; 
							   i=0; 
							   while(license.domanda_x[i]!=0) i++; 
							   dimensione_risposta=i;
							   for(i=0;i<dimensione_domanda;i++) {
																if (license.domanda_x[i]==domanda[i]) risposta_corretta++; 
																else risposta_corretta=0;
																}
							   break;
						default:
							    //è la domanda che mi piace di + cosi' la metto nel caso in cui ci fosse un bag nel programma. per essere sicuro che venga messa una domanda
							   printf("\n\nDomanda3: Qual'e' il tuo film preferito? :");
							   gets(domanda); 
							   dimensione_domanda=strlen(domanda); 
							   risposta_corretta=0; 
							   for(i=0;i<dimensione_domanda;i++) domanda[i]=(int)domanda[i]; 
							   i=0; 
							   while(license.domanda_x[i]!=0) i++;
							   dimensione_risposta=i;
							   for(i=0;i<dimensione_domanda;i++) {
																if (license.domanda_x[i]==domanda[i]) risposta_corretta++; 
																else risposta_corretta=0;
																}
							   break;
					   } //chiude lo switch
					
						
					if ((dimensione_risposta==dimensione_domanda) && (risposta_corretta==dimensione_risposta))
					{
						printf("\nRisposta corretta!\n\n");
						printf("\nCodice licenza: ");//ora assegno ad un vettore che ho già dichiarato i dati letti dal file lic.dat, cioè il codice scritto in modo sparso e lo ricompongo in un vettore per poi fare i calcolic he voglio
						codice_seriale_licenza[0]=activate.codice_a0;
						codice_seriale_licenza[1]=activate.codice_a1;
						codice_seriale_licenza[2]=activate.codice_a2;
						codice_seriale_licenza[3]=activate.codice_a3;
						codice_seriale_licenza[4]=activate.codice_a4;
						codice_seriale_licenza[5]=activate.codice_a5;
						codice_seriale_licenza[6]=activate.codice_a6;
						for(i=0;i<7;i++) printf("%d",codice_seriale_licenza[i]);
						printf("\n");
						lic_risposta_perverifica[0]=0;
						lic_risposta_perverifica[1]=rand()%9;
						lic_risposta_perverifica[2]=(codice_seriale_licenza[3]+8)%9;
						lic_risposta_perverifica[3]=(codice_seriale_licenza[5]+codice_seriale_licenza[2])%4;
						lic_risposta_perverifica[4]=codice_seriale_licenza[5];
						lic_risposta_perverifica[5]=8;
						lic_risposta_perverifica[6]=codice_seriale_licenza[6];
						lic_risposta_perverifica[7]=(codice_seriale_licenza[0]+2)%2;
						lic_risposta_perverifica[8]=(((9*codice_seriale_licenza[2])%(codice_seriale_licenza[0]+1))+codice_seriale_licenza[4])%9;
						lic_risposta_perverifica[9]=(codice_seriale_licenza[3]+codice_seriale_licenza[1]+codice_seriale_licenza[0])%9;
						lic_risposta_perverifica[10]=0;
						lic_risposta_perverifica[11]=(codice_seriale_licenza[2]+lic_risposta_perverifica[4]+lic_risposta_perverifica[5])%8;


						//questo non ci dovrà essere nella veersione definitva, ma dovrà essre su pagina php
						printf("\nIl codice di attivazione licenza e': ");
						for(i=0;i<12;i++) printf("%d",lic_risposta_perverifica[i]);

						printf("\n\n\nInserisci il codice di attivazione licenza\n");
						scanf("%s",lic_s);
    
						for(i=0;i<12;i++) lic_s[i]=(int)lic_s[i]-48;   // con questo trasformo i caratteri(che poi sono numeri) inseriti nella stringa in interi, sottraendo 48, cioè il valore dello 0 in ASCII

						//ora controllo che la cifra di controllo sia corretta
						if (activate.controllo_a==7-(((codice_seriale_licenza[0]*6)+(codice_seriale_licenza[1]*5)+(codice_seriale_licenza[2]*4)+(codice_seriale_licenza[3]*3)+(codice_seriale_licenza[4]*2))%7)) isbn=1;
						else isbn=0;

						if ((lic_risposta_perverifica[1]==lic_s[1]) && (lic_risposta_perverifica[2]==lic_s[2]) && (lic_risposta_perverifica[3]==lic_s[3])
							&& (lic_risposta_perverifica[4]==lic_s[4]) && (lic_risposta_perverifica[6]==lic_s[6]) && (lic_risposta_perverifica[7]==lic_s[7]) 
							&& (lic_risposta_perverifica[8]==lic_s[8]) && (lic_risposta_perverifica[9]==lic_s[9]) && (lic_risposta_perverifica[11]==lic_s[11])
							&& (lic_risposta_perverifica[0]==lic_s[0]) && (lic_risposta_perverifica[10]==lic_s[10]) && (isbn=1)) j=1; //se tutti veri significa che la risposta è corretta
						else j=0;
   					
						if(j!=1) printf("\nErrore x017! Codice di sblocco licenza errato.\n\n");

						//rileggo tutti i file per vedere se hanno tutti lo stesso codice seriale
						if ((cfPtr=fopen("ks.dat","rb"))==NULL) printf("Errore x018\n");       
						else {
							  fread(&write,sizeof(struct writeData),1,cfPtr);
							  fclose(cfPtr);
                        }           
						if ((cfPtr=fopen("lic.dat","rb"))==NULL) printf("Errore x019\n");       
						else {
							  fread(&activate,sizeof(struct activate_licData),1,cfPtr);
							  fclose(cfPtr);
                        }  
						if ((cfPtr=fopen("irr.dat","rb"))==NULL) printf("Errore x020\n");       
						else {
							  fread(&pathW,sizeof(struct pathWData),1,cfPtr);
							  fclose(cfPtr);
                        }  
						if ((cfPtr=fopen("rek.dll","rb"))==NULL) printf("Errore x021\n");       
						else {
							  fread(&writepc,sizeof(struct writepcData),1,cfPtr);
							  fclose(cfPtr);
                        }  

						int verifica_seriale_file=0;
						for(i=0;i<30;i++) {
							if((activate.codice_controlloic_a[i]==write.codice_controlloic[i]) && (pathW.codice_controlloic_pathW[i]==writepc.codice_controlloic_w[i]) && (write.codice_controlloic[i]==writepc.codice_controlloic_w[i])) verifica_seriale_file++;
						}
						//printf("\n\n %d %f %d %d %d %d\n\n",license.inutile_x,license.inutile2_x,strcmp(license.reg_x,c2)==0,isbn,j,verifica_seriale_file);
			  /*IMPO!!*/if ((license.inutile_x==12344) && (license.inutile2_x==-546.451405) && (strcmp(license.reg_x,c2)==0) && (isbn==1) && (j==1) && (verifica_seriale_file==30))
					    {
						   printf("\n..::AVVIO PROGRAMMA::..\n\n");  // qui teoricamente ,ci dovrebbe essere tutto il programma al quale vorrei applicare il sistema di protezione
							
						   printf("\nInserisci 99 se licenza PRO o 1, 2 o 3 se HOME (num anni)\n");
						   scanf("%d",&tipol);
						   //ora salvo tutti i dati rigurdanti date e ora sul file lic.dat, ma non su license.lic, perchè non deve cambiare, visto che ho fatto la registrazione già con esso
						   now(gio,mese,anno,gios,ora,min,sec); //leggo data
						   printf("\n %d %d %d %d %d %d\n",gio,mese,anno,ora,min,sec);

						   strcpy(activate.version,"2.0.0");
						   activate.tipolic=tipol;
						   activate.anno_s=anno+tipol; //imposto scadenza. Se 99 vuol dire che è illiminata, se 1,2,3 indica il numero di anni di validità

						   activate.mese_s=mese;
						   activate.gio_s=gio;
						   activate.ora_s=ora;
						   activate.min_s=min;
						   activate.sec_s=sec;
						   activate.anno_r=anno;
						   activate.mese_r=mese;
						   activate.gio_r=gio;
						   activate.ora_r=ora;
						   activate.min_r=min;
						   activate.sec_r=sec;

						   if ((cfPtr=fopen("ks.dat","w"))==NULL) printf("Errore x022\n"); //ricreo il file da capo e poi ci scrivo, questo elimina il bug che dopo 3 avvii da errore
						   else{ //ps una volta c'era sto bug, ora forse non + ,ma non cambio sto pezzo tanto va.
						        if ((cfPtr=fopen("ks.dat","rb+"))==NULL) printf("Errore x023\n");
						        else {			                                                            
								       strcpy(write.reg,license.reg_x);						//cioè registrato
									   for(i=0;i<11;i++) write.codice[i]=license.codice_x[i];
								       write.controllo_registrazione=32;						//cioè registrato e quindi non deve richiedere la registrazione
								       write.controllo=license.controllo_x;					//cioiè riscivo la cifra perchè la registrazione è corretta
								       write.inutile=license.inutile_x;
								       write.inutile2=license.inutile2_x;
								       write.mixer1=1;
								       write.mixer2=4;
								       write.mixer3=8;
								       write.mixer4=5;
								       write.mixer5=1;
								       write.mixer6=7;
								       write.mixer7=0;
								       write.mixer8=2;
								       write.mixer9=10;
								       for(i=0;i<=lunghezza;i++) write.path_codificato[i]=path[i];
								       for(i=0;i<20;i++) write.pcname[i]=pc_name[i];
								       fseek(cfPtr,0,SEEK_SET);
								       fwrite(&write,sizeof(struct writeData),1,cfPtr); 
								       fclose(cfPtr); 
								       if ((cfPtr=fopen("lic.dat","rb+"))==NULL) printf("Errore x024\n");
								       else 
									   {	                              
									      strcpy(activate.reg_a,"1234667"); //registrato
									      //il codice lo ho già generato sopra e quindi è già in write.codice 
									      //la cifra di controllo la ho generata già sopra
									      for(i=0;i<11;i++) activate.codice_dat[i]=write.codice[i];
									      activate.controllo_dat=write.controllo;
									      activate.inutile_a=12344;
									      activate.inutile2_a=-546.451405;
									      activate.controllo_registrazione_a=11; //cioè registrato
									      for(i=0;i<20;i++) activate.pcname_a[i]=pc_name[i]; //metto il nome pc codificato in numeri secondo ascii nel record per scrivere sul file
									      fseek(cfPtr,0,SEEK_SET);
									      fwrite(&activate,sizeof(struct activate_licData),1,cfPtr); 
									      fclose(cfPtr);      
										}   
							         }  
						    }

                        //visto che il codice utente è cambiato perchè viene letto da licenza anche md5 e sha1 cambiano, allora li rigenero e li riscrivo di nuovo
						strcpy(writepc.nomepc_w,nome_pc); //cioè inserisco il nome del pc
                        hash_rex_dll_funzione(pathW.path_pathW,writepc.nomepc_w,write.codice,write.controllo);//funziona per calcolare hash e scriverlo su rek.dll

						for(i=0;i<20;i++) writepc.sha1_w[i]=sha1_fun[i];
						for(i=0;i<16;i++) writepc.md5_w[i]=md5_fun[i];

						//salvo file con nome pc ecc.. e anche md5 e sha-1 generati dalla funzione sopra
						if ((cfPtr=fopen("rek.dll","w"))==NULL) printf("Errore x007\n");
					    else{
					         if ((cfPtr=fopen("rek.dll","rb+"))==NULL) printf("Errore x008\n");
					         else {                              
						           fseek(cfPtr,0,SEEK_SET);
						           fwrite(&writepc,sizeof(struct writepcData),1,cfPtr); 
						           fclose(cfPtr); 
                             } 
				        }
			          }//chiude l'if dei test e isbn
				    }//chiude if
					else {
						 printf("\nERRORE! LICENZA NON VALIDA O DANNEGGIATA\n\n"); 
						 if ((cfPtr=fopen("lic.dat","rb"))==NULL) printf("Errore x025\n");       
						 else {
							  fread(&activate,sizeof(struct activate_licData),1,cfPtr);
							  fclose(cfPtr);
                         } 
					     if ((cfPtr=fopen("lic.dat","w"))==NULL) printf("Errore x026\n");
					     else{
							  if ((cfPtr=fopen("lic.dat","rb+"))==NULL) printf("Errore x027\n");  //scrivo il codice sul file riscrivendo anche tutti gli altri dati per sicurezza
							  else{                            
                                     strcpy(activate.reg_a,"1234567"); //non registrato
                                     for(i=0;i<11;i++) activate.codice_dat[i]=write.codice[i];
                                     activate.controllo_dat=write.controllo;
                                     //il codice lo ho già generato sopra e quindi è già in write.codice 
                                     //la cifra di controllo la ho generata già sopra
                                     activate.inutile_a=12344; 
                                     activate.inutile2_a=-546.451405;
                                     activate.controllo_registrazione_a=22; //cioè non registrato, perchè non ho ancora messo il codice di risposta o il file di licenza
                                     for(i=0;i<20;i++) activate.pcname_a[i]=pc_name[i]; //metto il nome pc codificato in numeri secondo ascii nel record per scrivere sul file
                                     fseek(cfPtr,0,SEEK_SET);
                                     fwrite(&activate,sizeof(struct activate_licData),1,cfPtr); 
                                     fclose(cfPtr);      
                                   }
                             } 

						 //se domanda sbagliata incremeneto tentativi
				         if ((cfPtr=fopen("irr.dat","w"))==NULL) printf("Errore y001\n");
				         else{
					        if ((cfPtr=fopen("irr.dat","rb+"))==NULL) printf("Errore y002\n");
					        else {                           
						          strcpy(pathW.path_pathW,directory); //cioè inserisco il persorso
								  pathW.cont_licenza=pathW.cont_licenza+1;
						          fseek(cfPtr,0,SEEK_SET);
						          fwrite(&pathW,sizeof(struct pathWData),1,cfPtr); 
						          fclose(cfPtr);
							     }
				         }
						
						 printf("Hai ancora %d tentativo/i!\n\n",3-pathW.cont_licenza);
						 
						 //controllo di aver sbagliato la doamnda per + di 3 volte! se si sblocco la licenza modificando ks.dat!!!
						 //ora se la licenza è danneggiata è perchè o è falsa o perchè faccio il furbo e ho tentato di modificare il file
						 //per penitenza blocco il programma scrivendo dati sbagliati su file in cui ho i dati registrati del programma 
						 if(pathW.cont_licenza>=3)
						 {
						   if ((cfPtr=fopen("ks.dat","w"))==NULL) printf("Errore x028\n"); //ricreo il file da capo e poi ci scrivo, questo elimina il bug che dopo 3 avvii da errore
						   else{
						        if ((cfPtr=fopen("ks.dat","rb+"))==NULL) printf("Errore x029\n");
						        else {                              
					   			       strcpy(write.reg,"jhfiusq");						//cioè registrato
					   			       for(i=0;i<11;i++) write.codice[i]=codice[i];		//dato che distrugge il file di registraione, non quello di licenza
		    /*potrebbe fare casini*/   write.controllo=(5-((codice_seriale_licenza[0]*6)+(codice_seriale_licenza[1]*5)+(codice_seriale_licenza[2]*4)+(codice_seriale_licenza[3]*3)+(codice_seriale_licenza[4]*2))%7);//dato che distrugge il file di registraione, non quello di licenza
									   write.inutile=12343;
					   			       write.mixer1=1;
					   			       write.mixer2=4;
					   			       write.mixer3=8;
					   			       write.mixer4=5;
					   			       write.mixer5=1;
					   			       write.mixer6=7;
					   			       write.mixer7=0;
					   			       write.mixer8=2;
					   			       write.mixer9=10;
					   			       for(i=0;i<20;i++) write.pcname[i]=pc_name[i];
					   			       for(i=0;i<=lunghezza;i++) write.path_codificato[i]=path[i];
					   			       write.inutile2=-546.421405;							//dato che distrugge il file di registraione, non quello di licenza
					   			       fseek(cfPtr,0,SEEK_SET);
					   			       fwrite(&write,sizeof(struct writeData),1,cfPtr); 
					   			       fclose(cfPtr);  
					   		    }
						   }
						 }
					}
				}//chiude l'else inziale al momento della lettura della licenza   }      
			  }//chiude l'else subito sopra a quello iniziale della lettura licenza
}   //chiude l'if di scelta==1  
              

//*******************************************************************************
//*******************************************************************************
//************************SE VOGLIO REGISTRARMI MANUALMENTE**********************
//*******************************************************************************
//*******************************************************************************

if (scelta==2)
{      //vedo se voglio registrare manualmente                                                                          
  if ((cfPtr=fopen("ks.dat","rb"))==NULL) printf("Errore x030\n");            //leggo file
  else {
       fread(&write,sizeof(struct writeData),1,cfPtr);
       fclose(cfPtr);
       }                 
if (strcmp(write.reg,c1)==0){//apre un if che finisce sotto, dopo un bel pezzo di programma
                                                                            //che non è mai stato avviato. se ci sono altri numeri allora si perchè è stato scritto il codice generato
  if ((write.codice[0]==0) && (write.codice[1]==0) && (write.codice[2]==0) && (write.codice[3]==0) && (write.codice[4]==0) && (write.codice[5]==0) && (write.codice[6]==0) && (write.codice[7]==0) && (write.codice[8]==0) && (write.codice[9]==0) && (write.codice[10]==0) && (write.controllo==0)) first_exec=1;
  else first_exec=0;                                                          //se 0 vuol dire che non bisogna più generare il codice perchè è già stato scritto precedentemente sul file
        
  printf("\n\nIl tuo codice utente e' ");
  for(i=0;i<11;i++) printf("%d",codice[i]);
  printf("\n\nOttieni il codice di risposta da www.*****.com\n\n");
  printf("Inserisci il codice di risposta senza spazi, premi invio per confermare\n");
  scanf("%s",risp_s); 
  for(i=0;i<14;i++) risposta[i]=(int)risp_s[i]-48;                            // con questo trasformo i caratteri(che poi sono numeri) inseriti nella stringa in interi, sottraendo 48, cioè il valore dello 0 in ASCII
    
  //ora controllo che la cifra di controllo sia corretta
  controllo_test=10-(((write.codice[0]*9)+(write.codice[1]*8)+(write.codice[2]*7)+(write.codice[3]*6)+(write.codice[4]*5)+(write.codice[5]*4)+(write.codice[6]*3)+(write.codice[7]*2))%10);
  if (write.controllo==10-(((controllo_test*9)+(write.codice[8]*8)+(write.codice[9]*7)+(write.codice[10]*6)+(write.codice[0]*5)+(write.codice[1]*4)+(write.codice[2]*3)+(write.codice[5]*2))%10)) isbn=1;   //è 1 se il codice di controllo è ok. 
  else isbn=0;


  verif_risp[0]=write.codice[3]+write.codice[7]-1;
  verif_risp[1]=write.codice[0]+write.codice[1]-write.codice[3];
  verif_risp[2]=write.codice[0]+write.codice[7]-1;
  verif_risp[3]=write.codice[4]+2;
  verif_risp[4]=write.codice[4]+1;
  if((write.codice[5]-write.codice[6])>=0) verif_risp[5]=(write.codice[5]-write.codice[6]);
  else verif_risp[5]=(write.codice[5]-write.codice[6])*(-1);
  verif_risp[6]=write.codice[1]-1;
  verif_risp[7]=write.codice[8]+write.codice[7]-3;
  verif_risp[8]=write.codice[2]+write.codice[3]-1;

  verif_risp[9]=1;
  verif_risp[10]=1;
  verif_risp[11]=1;
  verif_risp[12]=1;
  verif_risp[13]=1;

  int verifica_risp=0;
  int licensetype=-risposta[9]+(write.codice[7]*2);
  int years=-write.codice[1]+risposta[11];
  printf("\n %d %d\n",licensetype,years);


  verif_risp[9]=(write.codice[7]*2)-licensetype;//home
  //int v_risp_9=(write.codice[7]*2)-2;//professional

  verif_risp[10]=write.codice[2]+2;

  verif_risp[11]=write.codice[1]+years;//1 anno di durata
  //int v_risp_11_2=write.codice[1]+2;//2 anni di durata
  //int v_risp_11_3=write.codice[1]+3;//3 anni di durata
  //printf("\n %d %d %d %d \n",verif_risp[11],v_risp_11_2,v_risp_11_3,v_risp_9);
						
  verif_risp[12]=write.codice[5]-1;
  int verif_risp_isbn1=10-(((verif_risp[0]*9)+(verif_risp[1]*8)+(verif_risp[2]*7)+(verif_risp[3]*6)+(verif_risp[4]*5)+(verif_risp[5]*4)+(verif_risp[6]*3)+(verif_risp[7]*2))%10);
  verif_risp[13]=8-(((verif_risp_isbn1*7)+(verif_risp[8]*6)+(verif_risp[9]*5)+(verif_risp[10]*4)+(verif_risp[11]*3)+(verif_risp[12]*2))%8);
  

  for(i=0;i<14;i++) if(risposta[i]==verif_risp[i]) verifica_risp++;
  printf("\n %d \n",verifica_risp);



  if ((verifica_risp==14) && (isbn=1)) 
  { //se tutti veri significa che la risposta è corretta
                                  
		     /*IMPO!!*/  printf("\n\nCodice corretto\n");    // qui teoricamente ,ci dovrebbe essere tutto il programma al quale vorrei applicare il sistema di protezione
                         if ((cfPtr=fopen("ks.dat","rb+"))==NULL) printf("File ks.dat non trovato. Errore x031\n");
                         else {                               
                                strcpy(write.reg,"jhfiusq");							//cioè registrato
                                for(i=0;i<11;i++) write.codice[i]=codice[i];
                                write.controllo_registrazione=32;					//cioè registrato e quindi non deve richiedere la registrazione
                                for(i=0;i<20;i++) write.pcname[i]=pc_name[i];		//metto il nome pc codificato in numeri secondo ascii nel record perscrivere sul file
                                controllo_test=10-(((write.codice[0]*9)+(write.codice[1]*8)+(write.codice[2]*7)+(write.codice[3]*6)+(write.codice[4]*5)+(write.codice[5]*4)+(write.codice[6]*3)+(write.codice[7]*2))%10);
								write.controllo=10-(((controllo_test*9)+(write.codice[8]*8)+(write.codice[9]*7)+(write.codice[10]*6)+(write.codice[0]*5)+(write.codice[1]*4)+(write.codice[2]*3)+(write.codice[5]*2))%10);
                                write.inutile=12344;
                                write.mixer1=1;
                                write.mixer2=4;
                                write.mixer3=8;
                                write.mixer4=5;
                                write.mixer5=1;
                                write.mixer6=7;
                                write.mixer7=0;
                                write.mixer8=2;
                                write.mixer9=10;
                                write.inutile2=-546.451405;
                                for(i=0;i<=lunghezza;i++) write.path_codificato[i]=path[i];
                                fseek(cfPtr,0,SEEK_SET);
                                fwrite(&write,sizeof(struct writeData),1,cfPtr); 
                                fclose(cfPtr); 
                         }   
                         //ora avviene il salvataggio del file di licenza

						 if ((cfPtr=fopen("lic.dat","rb"))==NULL) printf("Errore x013\n");          
						 else {                                                                          
								fread(&activate,sizeof(struct activate_licData),1,cfPtr);                                          
								fclose(cfPtr);
						 } 

						 //printf("\nInserisci 0 se licenza PRO o 1, 2 o 3 se HOME (num anni)\n");
						 //scanf("%d",&tipol);
						 now(gio,mese,anno,gios,ora,min,sec); //leggo data

						 strcpy(license.version,"2.0.0");
						 printf("\n %d %d %d %d %d %d\n",gio,mese,anno,ora,min,sec);

						 strcpy(activate.version,"2.0.0");
						 strcpy(license.version,"2.0.0");
						 if (licensetype==2) tipol=99;
						 if (licensetype==1) tipol=years;

						 activate.tipolic=tipol;
						 license.tipolic=tipol;
						 activate.anno_s=anno+tipol; //imposto scadenza. Se 99 vuol dire che è illiminata, se 1,2,3 indica il numero di anni di validità
						 license.anno_s=anno+tipol;

						 activate.mese_s=mese;
					     activate.gio_s=gio;
					     activate.ora_s=ora;
					     activate.min_s=min;
					     activate.sec_s=sec;

						 license.mese_s=mese;
						 license.gio_s=gio;
					     license.ora_s=ora;
					     license.min_s=min;
					     license.sec_s=sec;

					     activate.anno_r=anno;
					     activate.mese_r=mese;
					     activate.gio_r=gio;
					     activate.ora_r=ora;
					     activate.min_r=min;
					     activate.sec_r=sec;

					     license.anno_r=anno;
					     license.mese_r=mese;
					     license.gio_r=gio;
					     license.ora_r=ora;
					     license.min_r=min;
					     license.sec_r=sec;


						 if ((cfPtr=fopen("lic.dat","rb+"))==NULL) printf("Errore x013\n");          
						 else {                                                                          
								fseek(cfPtr,0,SEEK_SET);
							    fwrite(&activate,sizeof(struct activate_licData),1,cfPtr); 
								fclose(cfPtr); 
						 } 


                         printf("\n..::PROCEDURA PER LA GENERAZIONE DEL FILE DI LICENZA::..\n\n");
                         printf("E' essenziale per riutilizzare il programma dopo una nuova installazione\n");
                         printf("Compilare con dati VERI i seguenti campi (massimo 30 cratteri)\n");
                         printf("Si consiglia l'utilizzo di soli caratteri minuscoli\n");
                         printf("NON USARE SPAZI!!! SCRIVERE TUTTO ATTACCATO!!!\n\n");
                         printf("Inserisci il tuo NOME di battesimo:");
                         getchar();
                         gets(license.nome_x);
                         printf("\n\nInserisci il tuo COGNOME: ");
                         gets(license.cogn_x);
                         printf("\n\nInserisci la SOCIETA'. Scrivi NULL se non la hai: ");
                         gets(license.soc_x);
                         printf("\n\nInserisci la e-mail usata per ottenere il codice di risposta: ");
                         gets(license.mail_x);

						 int t1=0,t2=0,t3=0,t4=0,t5=0,t6=0,t7=0;
						 while(t1!=1 || t2!=1 || t4!=1 || t5!=1 || t3==0 || t6==0)
						 {

                            //eseguo test su questa email. cioè deve avere almeno 6 caratteri con 1caratt+@+1caratt.2caratt(minimo)
                            //questa parte dovrà essere ottimizzata e anche di molto perchè uso troppe variabili per fare 2 cavolate
                            if (strlen(license.mail_x)>=6) t1=1;
                            if ((license.mail_x[0]!='@') && ((license.mail_x[0]!='.')))  t2=1;
                            for(i=0;i<strlen(license.mail_x);i++) if(license.mail_x[i]=='@') t3=i; //questo dice doc'è l'ultima chiocciola
                            if ((license.mail_x[t3+1]!='.') && (license.mail_x[t3-1]!='@')) t4=1;
                            for(i=0;i<strlen(license.mail_x);i++) if(license.mail_x[i]=='.') t6=i; //questo trova l'ultimo . che c'è nella mail se ce nesono prima, se ne frega
                            if ((license.mail_x[t6+1]!='.') && (license.mail_x[t6-1]!='@')) t5=1;	
                            if(t6<=strlen(license.mail_x)-2) t7=1;
                            if (t1!=1 || t2!=1 || t4!=1 || t5!=1 || t3==0 || t6==0)
                            {
                              t1=0;
                              t2=0;
                              t4=0;
                              t5=0;
                              t7=0;
                              printf("\n\nInserisci la e-mail usata per ottenere il codice di risposta: ");
                              gets(license.mail_x);
                            }
						 }

                         printf("\n\nOra dovrai rispondere a una domanda. \nLa risposta corretta sarà necessaria per riattivare");
                         printf("il programma in future installazioni o su altri pc\n");
                         printf("E' necessario ricordare numero e risposta delle domanda\n");
                         printf("Si consiglia l'utilizzo di soli caratteri minuscoli\n");
                         printf("In questa fase e' possibile usare gli SPAZI\n");
                         getchar();
                         srand(time(NULL));
                         j=rand()%5+1;	//cosi' scelgo quale domanda devo salvare nella licenza
											  								
                         switch(j){
									case 1:
											printf("\n\nDomanda1: Qual'e' il tuo colore preferito? :");
											gets(domanda);
											dimensione_domanda=strlen(domanda);
											for(i=0;i<dimensione_domanda;i++) license.domanda_x[i]=(int)domanda[i];
											license.num_domanda_x=1;						//identifica il numero della domanda, per capire a che domanda ci si riferisce quando il programma la rilegge
											break;
									case 2:
											printf("\n\nDomanda2: Dai un voto a questo programma (in lettere) :");  
											gets(domanda);
											dimensione_domanda=strlen(domanda);
											for(i=0;i<dimensione_domanda;i++) license.domanda_x[i]=(int)domanda[i];
											license.num_domanda_x=2;
											break;
									case 3:
											printf("\n\nDomanda3: Qual'e' il tuo film preferito? :");	
											gets(domanda);
											dimensione_domanda=strlen(domanda);
											for(i=0;i<dimensione_domanda;i++) license.domanda_x[i]=(int)domanda[i];
											license.num_domanda_x=3;
											break;
									case 4:
											printf("\n\nDomanda4: Qual'e' la tua eta (in lettere)? :");
											gets(domanda);
											dimensione_domanda=strlen(domanda);
											for(i=0;i<dimensione_domanda;i++) license.domanda_x[i]=(int)domanda[i];
											license.num_domanda_x=4;
											break;
									case 5:
											printf("\n\nDomanda5: Qual'e' la citta' in cui sei nato? :");
											gets(domanda);
											dimensione_domanda=strlen(domanda);
											for(i=0;i<dimensione_domanda;i++) license.domanda_x[i]=(int)domanda[i];
											license.num_domanda_x=5;
											break;
									case 6:
											printf("\n\nDomanda6: Qual'e' la marca del tuo televisore? :");
											gets(domanda);
											dimensione_domanda=strlen(domanda);
											for(i=0;i<dimensione_domanda;i++) license.domanda_x[i]=(int)domanda[i];
											license.num_domanda_x=6;
											break;
									default:
											printf("\n\nDomanda3: Qual'e' il tuo film preferito? :");	
											gets(domanda);
											dimensione_domanda=strlen(domanda);				//è la domanda che mi piace di + cos= la metto nel caso in cui ci fosse un bag nel programma. per essere sicuro che venga messa una domanda
											for(i=0;i<dimensione_domanda;i++) license.domanda_x[i]=(int)domanda[i];
											license.num_domanda_x=3;
											break;
				         } //chiude lo switch

                         printf("\n\nI dati appena inseriti non devono essere forniti a nessuno\n\n");               
                         //come prima cosa creo un file license.lic (uso parametro w)e se non da errore lo apro con paramenro rb+
                         //poi ci scrivo dentro i dati della licenza
                         if ((cfPtr=fopen("license.lic","w"))==NULL) printf("Errore x032\n");
                         else{
                              if ((cfPtr=fopen("license.lic","rb+"))==NULL) printf("Errore x033\n");
                              else {
                                     strcpy(license.reg_x,"jhfiusq"); //cioè registrato
                                     for(i=0;i<11;i++) license.codice_x[i]=codice[i];
									 controllo_test=10-(((codice[0]*9)+(codice[1]*8)+(codice[2]*7)+(codice[3]*6)+(codice[4]*5)+(codice[5]*4)+(codice[6]*3)+(codice[7]*2))%10);
									 license.controllo_x=10-(((controllo_test*9)+(codice[8]*8)+(codice[9]*7)+(codice[10]*6)+(codice[0]*5)+(codice[1]*4)+(codice[2]*3)+(codice[5]*2))%10);//cioiè riscivo la cifra perchè la registrazione è corretta
                                     license.inutile_x=12344;
                                     license.inutile2_x=-546.451405;
                                     fseek(cfPtr,0,SEEK_SET);
                                     fwrite(&license,sizeof(struct licenseData),1,cfPtr); 
                                     fclose(cfPtr); 
                              }
                          }                      
                                                                   
  } //chiudo l'if aperto sopra e procedo con un else legato a questo if
  else
  { //cioè rgistrazione fallita, riferito all'IF SOPRA
    printf("\nCodice errato!\n\n");
    if ((cfPtr=fopen("ks.dat","rb"))==NULL) printf("Errore x034\n");		//leggo file
    else {
           fread(&write,sizeof(struct writeData),1,cfPtr);
/*IMPO!!*/ if ((write.inutile==12344) && (write.inutile2==-546.451405) && (strcmp(write.reg,c2)==0)) {
               printf("..::AVVIO PROGRAMMA::..\n\n");  // qui teoricamente ,ci dovrebbe essere tutto il programma al quale vorrei applicare il sistema di protezione
           }
           fclose(cfPtr);
    }  
            
   }  
}//qui chiudo l'if che inizia con lo strcmp==0 e subito dopo faccio l'else
else { //cioè se il programma è registrato (controllo solo scritta jhfiusw) entro qui!!
      if ((cfPtr=fopen("ks.dat","rb"))==NULL) printf("Errore x035\n");    //leggo file
      else {
           fread(&write,sizeof(struct writeData),1,cfPtr); 
           //ora controllo che la cifra di controllo sia corretta, se corretta, bene eseguo programma
		   controllo_test=10-(((write.codice[0]*9)+(write.codice[1]*8)+(write.codice[2]*7)+(write.codice[3]*6)+(write.codice[4]*5)+(write.codice[5]*4)+(write.codice[6]*3)+(write.codice[7]*2))%10);
		   if (write.controllo==10-(((controllo_test*9)+(write.codice[8]*8)+(write.codice[9]*7)+(write.codice[10]*6)+(write.codice[0]*5)+(write.codice[1]*4)+(write.codice[2]*3)+(write.codice[5]*2))%10)) isbn=1;  //è 1 se il codice di controllo è ok. 

/*IMPO!!*/ if ((write.inutile==12344) && (write.inutile2==-546.451405) && (strcmp(write.reg,c2)==0) && (isbn==1)) {
           printf("\n\n..::AVVIO PROGRAMMA::..\n\n");  // qui teoricamente ,ci dovrebbe essere tutto il programma al quale vorrei applicare il sistema di protezione
           } 
           else printf("\n\nErrore! Il programma e' registrato, ma hai tentato di modificare dati sensibili all'interno dei file.\n\n");                            
      } 
}                                           

}//qui chiudo l'if inziale con scelta==2  


//*******************************************************************************
//*******************************************************************************
//****************************SE VOGLIO VEDERE LICENZA***************************
//*******************************************************************************
//*******************************************************************************
if (scelta==3)
{
	if ((cfPtr=fopen("license.lic","rb"))==NULL){
		printf("File di licenza non trovato. Errore y003\n\n");
		printf("Per vedere la licenza deve copiare nella cartella di Lightwall il file license.lic\n");
		printf("\nLightwall si trova in: %s\n\n",ch); //in ch (è una variabile dichiarata nelle procedure c++) sono sicuro che ad ogni avvio contenga il percorso!!!
	}
    else{
		 fread(&license,sizeof(struct licenseData),1,cfPtr);
		 fclose(cfPtr);
		 fread(&pathW,sizeof(struct pathWData),1,cfPtr);
		 fclose(cfPtr);
	}
	//ora stampo i dati
	char stato_registrazione[25];
	if(strcmp(license.reg_x,"jhfiusq")==0) strcpy(stato_registrazione,"Non registrato");
	if(strcmp(license.reg_x,"jhfiusw")==0) strcpy(stato_registrazione,"Registrato");
	if((strcmp(license.reg_x,"jhfiusw")!=0) && (strcmp(license.reg_x,"jhfiusq")!=0)) strcpy(stato_registrazione,"Sconosciuto (Errore)");

	printf("\n..::Dati licenza::..\n\n");
	printf("-> Versione licenza: <%s>\n",license.version);
	printf("-> Tipo licenza: <");
	if(license.tipolic==99){
							printf("PROFESSIONAL>\n");
							printf("-> Durata in anni: <Illimitati>\n");
						   }
	else {
			printf("HOME>\n");
			printf("-> Durata in anni: <%d>\n",license.tipolic);
	     }
	
	printf("-> Nome utente: <%s>\n",license.nome_x);
	printf("-> Cognome utente: <%s>\n",license.cogn_x);
	printf("-> Societa': <%s>\n",license.soc_x);
	printf("-> Mail: <%s>\n",license.mail_x);
	printf("-> Data creazione: <%d:%d:%d - %d/%d/%d>\n",license.ora_r,license.min_r,license.sec_r,license.gio_r,license.mese_r,license.anno_r);
	printf("-> Data scadenza: <%d:%d:%d - %d/%d/%d>\n",license.ora_s,license.min_s,license.sec_s,license.gio_s,license.mese_s,license.anno_s);
	printf("-> Codice domanda: <%d>\n",license.num_domanda_x);
	printf("-> Stato registrazione: <%s>\n",stato_registrazione);
	printf("-> Tentativi attivazione restanti: <%d>\n",3-pathW.cont_licenza);
	printf("-> Integrita' MC: <%d/100>\n",h);

	printf("\nPer ottenere supporto on-line invia questi dati e il file license.lic a ks89\n");
	printf("Inoltre, allega una chiara spiegazione del problema\n");
	printf("\nSe i dati sono illeggibili license.dat e' danneggiato!\n\n");


}//FINE SCELTA 3   qui chiudo if inziale con scelta=3

}//QUI CHIUDO L'IF GIGANTESCO INZIALE CHE AVVIA IL PROGRAMMA SE SI TROVA SU UN PC AUTORIZZATO, IN BASE AL NOME UTENTE


//entro in questo elese se ho modificato uno dei file (ks o lic.dat). Qui dentro permetto riattivazione senza grandi fatiche
else
{
	if (nascondi_errore_x036!=1) //fa il test che esclude messaggio errore x036 nel caso in cui la licenza abbia superato i 3 tentativi di attivazione. Questo sistema è l'unico modo che per ora mi ha permesso di risolvere i bug di uscita x036 dopo 3 tentativi di attivazione
	{
	 //finisco qui se tento di modificare anche solo uno di questi file: irr.dat, ks.dat, rek.dll
	 printf("..::Errore x036..::\n\n");
	 printf("Possibili cause:\n");
	 printf("1) Hai avviato lightwall su un pc diverso da quello della prima volta!\n");
	 printf("2) Hai avviato lightwall da una cartella diversa da quella della prima volta\n");
	 printf("3) Hai tentato di modificare i file del programma (Tentativo di cracking)\n");
	 printf("4) Hai risposto in modo errato alla domanda di attivazione licenza\n");
	 printf("\n-----------------------------------------------------------------------------\n");
	 printf("\nPossibili soluzioni: \n");
	 printf("1) Contatta ks89 per ottenere licenze multiple\n"); 
	 printf("2) Sblocca la licenza d'uso con l'apposito codice\n\n");
	 printf("------------------------------------------------------------------------------\n");
	 printf("\nNota: \nTentare di superare il sistema di protezione modificando i file\no altri dati non e' contemplato nel supporto on-line\n\n");
	 printf("Ks89 non e' responsabile di problemi dovuti a questi tentativi\n");
	 printf("------------------------------------------------------------------------------\n");
	}

	 //ora se la licenza è danneggiata è perchè o è falsa o perchè faccio il furbo e ho tentato di modificare il file
	 //per penitenza blocco il programma scrivendo dati sbagliati su file in cui ho i dati registrati del programma 
	 //qui manometto il file ks.dat, gli altri rek e irr no, perchè almeno sono sicuro che l'utente non possa spostare l'attivazione su altri pc, non ripristinando i file di nomepc e percorso
	 //mentre il file lic.dat lo manometto
	 //a questo punto devo fare un if else, cioè se ho distrutto ks.dat uso algoritmo, se no, devo fare stesso algoritmo ma prendendo dato scritto su lic.dat (cioè il codice utente)

	 //rileggo tutti i file per sicurezza
	 if ((cfPtr=fopen("ks.dat","rb"))==NULL) printf("Errore x037\n");       
	 else {
             fread(&write,sizeof(struct writeData),1,cfPtr);
             fclose(cfPtr);
	 }           
	 if ((cfPtr=fopen("lic.dat","rb"))==NULL) printf("Errore x038\n");       
	 else {
             fread(&activate,sizeof(struct activate_licData),1,cfPtr);
             fclose(cfPtr);
	 }  
	 if ((cfPtr=fopen("irr.dat","rb"))==NULL) printf("Errore x039\n");       
	 else {
             fread(&pathW,sizeof(struct pathWData),1,cfPtr);
             fclose(cfPtr);
	 }  
	 if ((cfPtr=fopen("rek.dll","rb"))==NULL) printf("Errore x040\n");       
	 else {
             fread(&writepc,sizeof(struct writepcData),1,cfPtr);
             fclose(cfPtr);
	 }
	 if ((cfPtr=fopen("license.lic","rb"))==NULL) printf("Errore x041\n");       
	 else {
             fread(&license,sizeof(struct licenseData),1,cfPtr);
             fclose(cfPtr);
	 }  

     if((license.inutile_x!=12344) || (license.inutile2_x!=-546.451405) || ((license.num_domanda_x>6) || (license.num_domanda_x<0)))
	 {
	    printf("\nERRORE IRREVERSIBILE! LICENZA DANNEGGIATA. CONTATTARE KS89!!!\n");
	    printf("\nATTENZIONE! LO SBLOCCO LICENZA E' PERMESSO SOLO DOPO AVER CREATO LICENSE.LIC\n");
	    if((cfPtr=fopen("license.lic","rb"))==NULL) printf("\nImpossibile eseguire il ripristino senza license.lic\n\n\n");
     }
	 else{
	      if((cfPtr=fopen("license.lic","rb"))==NULL) printf("\nImpossibile eseguire il ripristino senza license.lic\n");
	      else
	      {
			
			//rigenero cifra controllo di activate, cioè lic.dat
			controllo_test=10-(((activate.codice_dat[0]*9)+(activate.codice_dat[1]*8)+(activate.codice_dat[2]*7)+(activate.codice_dat[3]*6)+(activate.codice_dat[4]*5)+(activate.codice_dat[5]*4)+(activate.codice_dat[6]*3)+(activate.codice_dat[7]*2))%10);
			testdamage_file=10-(((controllo_test*9)+(activate.codice_dat[8]*8)+(activate.codice_dat[9]*7)+(activate.codice_dat[10]*6)+(activate.codice_dat[0]*5)+(activate.codice_dat[1]*4)+(activate.codice_dat[2]*3)+(activate.codice_dat[5]*2))%10); 
			
	        //testdamage_file=7-(((activate.codice_dat[0]*6)+(activate.codice_dat[1]*5)+(activate.codice_dat[2]*4)+(activate.codice_dat[3]*3)+(activate.codice_dat[4]*2))%7);
	        
			//rigenero cifra controllo di write, cioè ks.dat.
			controllo_test=10-(((write.codice[0]*9)+(write.codice[1]*8)+(write.codice[2]*7)+(write.codice[3]*6)+(write.codice[4]*5)+(write.codice[5]*4)+(write.codice[6]*3)+(write.codice[7]*2))%10);
			isbn=10-(((controllo_test*9)+(write.codice[8]*8)+(write.codice[9]*7)+(write.codice[10]*6)+(write.codice[0]*5)+(write.codice[1]*4)+(write.codice[2]*3)+(write.codice[5]*2))%10); 
			//isbn=7-(((write.codice[0]*6)+(write.codice[1]*5)+(write.codice[2]*4)+(write.codice[3]*3)+(write.codice[4]*2))%7);   

	        //ora controllo se i mixer1->9 dentro il file ks.dat sono giusti. se lo sono vuol dire che ks.dat non è stato modificato (lo affermo con certezza grazie alla disposizione di queste variabili nel file)
	       	if((write.mixer1==1) && (write.mixer2==4) && (write.mixer3==8) && (write.mixer4==5) && (write.mixer5==1) && (write.mixer6==7) && (write.mixer7==0) && (write.mixer8==2) && (write.mixer9==10)) controllo_mixer=1;
	        else controllo_mixer=0;
	
	        //eseguo assegnazione, perchè durante questo processo queste variabili cambiano, e quindi mi ritorverei sempre con l'ultimo if a vero o quasi(sarebbe un errore)
	        writecontrollo=write.controllo;
	        activatecontrollodat=activate.controllo_dat;


			printf("\n %d %d %d %d %d\n",testdamage_file,activatecontrollodat,writecontrollo,isbn,controllo_mixer);
			//se testdamage_file!=ac.... vuol dire che le 2 cifre di controllo (appena generata e scritta) sono diverse, e quindi lic.dat è danneggiato,
			//ma non ks.dat visto che writeconr==isbn e contrmixer ok
/*_*/       if ((testdamage_file!=activatecontrollodat) && (writecontrollo==isbn) && (controllo_mixer==1))  //se non entro qui vuol dire semplicemente che i file sono ok
            { //vuol dire che lic,dat è danneggiato ma non ks.dat, che invece è a posto
		       printf("\n\nFile lic.dat danneggiato!\n\n");
		       printf("Codice sblocco: ");
		       if ((cfPtr=fopen("lic.dat","w"))==NULL) printf("Errore x042");
		       else{
		            if ((cfPtr=fopen("lic.dat","rb+"))==NULL) printf("Errore x043");  //scrivo il codice sul file riscrivendo anche tutti gli altri dati per sicurezza
		            else {                            
                          strcpy(activate.reg_a,"1234667"); //non registrato
                          for(i=0;i<11;i++) activate.codice_dat[i]=0; //però anche il codice utente qui lo metto alla cazzo,così so che questo è danneggiato di sicuro
                          activate.controllo_dat=0;
                          //il codice lo ho già generato sopra e quindi è già in write.codice 
                          //la cifra di controllo la ho generata già sopra
                          activate.controllo_a=10; //metto a caso una cifra di controllo in modo da sputtanare il file senza distruggere troppo i dati
                          activate.inutile_a=12344;
                          activate.inutile2_a=-546.451405;
                          activate.controllo_registrazione_a=11; //cioè non registrato, perchè non ho ancora messo il codice di risposta o il file di licenza
                          for(i=0;i<20;i++) activate.pcname_a[i]=pc_name[i]; //metto il nome pc codificato in numeri secondo ascii nel record per scrivere sul file
                          fseek(cfPtr,0,SEEK_SET);
                          fwrite(&activate,sizeof(struct activate_licData),1,cfPtr); 
                          fclose(cfPtr);      
                    }
	           }

	           //ora genero il codice di sblocco livello1 (cioè quello che crea il programma e che deve avere una risposta (liv2) perchè la licenza vanga sbloccata)
	           for(i=0;i<11;i++) codice[i]=write.codice[i];
	           int resto_sblocco1_1=((codice[0]*6)+(codice[1]*5)+(codice[2]*4)+(codice[3]*3)+(codice[4]*2))%7;
	           int resto_sblocco1_2=((codice[0]*8)+(codice[1]*7)+(codice[2]*6)+(codice[3]*5)+(codice[4]*4)+(codice[5]*3)+(codice[6]*2))%9;
	           sblocco1[0]=7-resto_sblocco1_1;//quindi la cifra di controllo è pronta per essere scritta
	           sblocco1[1]=9-resto_sblocco1_2;//quindi la cifra di controllo è pronta per essere scritta
	           int frequenze[10]={0,0,0,0,0,0,0,0,0,0};

	           for(i=0;i<7;i++) frequenze[codice[i]]++;
	           for(i=0;i<10;i++) sblocco1[i+2]=frequenze[i];
	           sblocco1[12]=codice[5];
	           sblocco1[13]=codice[6];
	           if ((cfPtr=fopen("license.lic","rb"))==NULL) printf("\n");
	           else
	           {
	             fread(&license,sizeof(struct licenseData),1,cfPtr);
	             fclose(cfPtr);
	             sblocco1[14]=(int)((license.mail_x[0]-'a')%5)+((int)(license.mail_x[0]-'a')/5);
	             char temp_letter,temp_letter2;
	             int lungh_mail=strlen(license.mail_x);

	             temp_letter=license.mail_x[lungh_mail-2]; //ultimi 2 caratteri della mail
	             temp_letter2=license.mail_x[lungh_mail-1];//ultimi 2 caratteri della mail
	             sblocco1[15]=(int)((license.mail_x[lungh_mail-2]-'a')%5)+((int)(license.mail_x[lungh_mail-2]-'a')/5);
	             sblocco1[16]=(int)((license.mail_x[lungh_mail-1]-'a')%5)+((int)(license.mail_x[lungh_mail-1]-'a')/5);

	             //sequenza fibonacci per generare ultimo numero(può essere 1,2,3,5,8 e basta
	             for(i=2;i<=write.codice[1];i++)
	             {
	               sblocco1[17]=fm1+fm2;
			       fm2=fm1;
			       fm1=sblocco1[17];//va da 1 a 8
	             }
	           }
			
	           //algoritmo finale per la generazione della cifra di controllo del codice di sblocco
	           //ho spezzato tutti i passaggi per far si che sia + leggibile
	           sblocco1[18]=(sblocco1[0]*19)+(sblocco1[1]*18)+(sblocco1[2]*17)+(sblocco1[3]*16)+(sblocco1[4]*15)+(sblocco1[5]*14)+(sblocco1[6]*13)+
									(sblocco1[7]*12)+(sblocco1[8]*11)+(sblocco1[9]*10)+(sblocco1[10]*9)+(sblocco1[11]*8)+(sblocco1[12]*7)+
									(sblocco1[13]*6)+(sblocco1[14]*5)+(sblocco1[15]*4)+(sblocco1[16]*3)+(sblocco1[17]*2);
	           sblocco1[18]=sblocco1[18]%20;
	           sblocco1[18]=20-sblocco1[18];
	           sblocco1[18]=(int)((int)sblocco1[18]/2)/2;
	           //fine generazione codice sblocco1, ora stampo il codice per vedere cosa esce
						
	           for(i=0;i<19;i++) printf("%d ",sblocco1[i]);

	           //ora genero il codice di sblocco risposta (sblocco2) , questo bisognerebbe metterlo in un pagina php, non qui, ma lo faccio qui per testarlo
	           sblocco2[0]=(9-(((sblocco1[0]*8)+(sblocco1[1]*7)+(sblocco1[2]*6)+(sblocco1[3]*5)+(sblocco1[4]*4)+(sblocco1[5]*3)+(sblocco1[6]*2))%9))/2;
	           sblocco2[1]=(12-(((sblocco1[0]*11)+(sblocco1[1]*10)+(sblocco1[2]*9)+(sblocco1[3]*8)+(sblocco1[4]*7)+(sblocco1[5]*6)+(sblocco1[6]*5)+(sblocco1[7]*4)+(sblocco1[8]*3)+(sblocco1[9]*2))%12))/2;
	           sblocco2[2]=(18-(((sblocco1[0]*17)+(sblocco1[1]*16)+(sblocco1[2]*15)+(sblocco1[3]*14)+(sblocco1[4]*13)+(sblocco1[5]*12)+(sblocco1[6]*11)+(sblocco1[7]*10)+(sblocco1[8]*9)+(sblocco1[9]*8)+(sblocco1[10]*7)+(sblocco1[11]*6)+(sblocco1[12]*5)+(sblocco1[13]*4)+(sblocco1[14]*3)+(sblocco1[15]*2))%18))/2;
	           sblocco2[3]=(21-(((sblocco1[0]*20)+(sblocco1[1]*19)+(sblocco1[2]*18)+(sblocco1[3]*17)+(sblocco1[4]*16)+(sblocco1[5]*15)+(sblocco1[6]*14)+(sblocco1[7]*13)+(sblocco1[8]*12)+(sblocco1[9]*11)+(sblocco1[10]*10)+(sblocco1[11]*9)+(sblocco1[12]*8)+(sblocco1[13]*7)+(sblocco1[14]*6)+(sblocco1[15]*5)+(sblocco1[16]*4)+(sblocco1[17]*3)+(sblocco1[18]*2))%21))/2;
	           sblocco2[4]=sblocco1[17];//quello con fibonacci
	           sblocco2[5]=(7-(((sblocco2[0]*6)+(sblocco2[1]*5)+(sblocco2[2]*4)+(sblocco2[3]*3)+(sblocco2[4]*2))%7))/2;
				
	           if ((cfPtr=fopen("license.lic","rb"))==NULL) {
							printf("\n");
							lungh_mail=2; //metto un valore a caso per far si che e non apre il file la variabile abbia dentro almeno un valore
	           }
	           else
	           {   //se tutti e 2 i file danneggiati assieme non accede a questo else!!! (almeno toricamente io lo ho progetato così, magari ci sono dei bug)
	               fread(&license,sizeof(struct licenseData),1,cfPtr);
	               fclose(cfPtr);						
	               lungh_mail=strlen(license.mail_x);
	               int mail_num[30];
	               for(i=0;i<lungh_mail;i++) mail_num[i]=(int)((license.mail_x[i]-'a'+51)%9);
	               int meta_mail=lungh_mail/2;
	               
	               sblocco2[6]=0;
	               j=meta_mail+1;
	               for(i=0;i<=meta_mail-1;i++)
	               {
	                 sblocco2[6]=sblocco2[6]+((mail_num[i])*j);
	                 j--;
	               }
					
	               sblocco2[6]=((meta_mail+2)-(sblocco2[6]%(meta_mail+2)))%9;
	               sblocco2[7]=0;
	               j=lungh_mail-meta_mail+1;
	               for(i=meta_mail;i<lungh_mail;i++)
	               {
	                 sblocco2[7]=sblocco2[7]+(mail_num[i]*j);
	                 j--;
	               }	

	               sblocco2[7]=((lungh_mail-meta_mail+2)-(sblocco2[7]%(lungh_mail-meta_mail+2)))%9;
	               sblocco2[8]=4-(((sblocco2[6]*3)+(sblocco2[7]*2))%4);  //fa il codice di controllo solo sui 2 caratteri presi dalla mail
	               sblocco2[9]=(11-(((sblocco2[0]*10)+(sblocco2[1]*9)+(sblocco2[2]*8)+(sblocco2[3]*7)+(sblocco2[4]*6)+(sblocco2[5]*5)+(sblocco2[6]*4)+(sblocco2[7]*3)+(sblocco2[8]*2))%11))/2;		
	           }

	           printf("\n\nCodice di risposta sblocco: ");
	           for(i=0;i<10;i++) printf("%d ",sblocco2[i]);
				
	           printf("\n\n\nInserisci in codice di sblocco di risposta: \n");
	           scanf("%s",sblocco_risp_num);
	           for(i=0;i<10;i++) sblocco_risp_num[i]=(int)sblocco_risp_num[i]-48; 
	           j=0;
	           for(i=0;i<10;i++) if(sblocco_risp_num[i]==sblocco2[i]) j++;

	           if(j==10)
	           {
	             printf("\n\nLicenza resettata, sblocco eseguito. \nRiavviare il programma ed eseguire la registrazione tramite licenza\n\n");
	             if ((cfPtr=fopen("ks.dat","rb+"))==NULL) printf("Errore x044");  //apro file
	             else {
					    write.mixer1=1;
					    write.mixer2=4;
					    write.mixer3=8;
					    write.mixer4=5;
					    write.mixer5=1;
					    write.mixer6=7;
					    write.mixer7=0;
					    write.mixer8=2;
					    write.mixer9=10;
					    for(i=0;i<11;i++) write.codice[i]=0;        //imposto valore di fabbrica 
					    write.controllo=0;                         //imposto valore di fabbrica, perchè se tutti num sono 0/7=0 con resto t, ma devo fare 7-7=0=controllo, quindi 0 è il valore inziale
					    write.inutile=12344;                       //imposto valore di fabbrica
					    write.inutile2=-546.451405;                //imposto valore di fabbrica
					    strcpy(write.reg,"jhfiusw");               //imposto valore di fabbrica
					    strcpy(writepc.nomepc_w,"XX-123456789012");//imposto valore di fabbrica
					    write.controllo_registrazione=22;           //imposto valore di fabbrica
					    for(i=0;i<20;i++) write.pcname[i]=32;      //imposto valore di fabbrica (ho scelto una volre a caso che in ascii è lo spazio      
					    for(i=0;i<100;i++) write.path_codificato[i]=61;   //imposto valore di fabbrica (ho scelto una volre a caso che in ascii è l'uguale      
					    fseek(cfPtr,0,SEEK_SET); 
					    fwrite(&write,sizeof(struct writeData),1,cfPtr); //scrivo sul file i valori impostati prima come record
					    fclose(cfPtr);                   //chiudo file
			     }   
			     if ((cfPtr=fopen("lic.dat","w"))==NULL) printf("Errore x045");
			     else{
			          if ((cfPtr=fopen("lic.dat","rb+"))==NULL) printf("Errore x046");  //scrivo il codice sul file riscrivendo anche tutti gli altri dati per sicurezza
			          else {                            
                             strcpy(activate.reg_a,"1234567"); //non registrato
                             //il codice lo ho già generato sopra e quindi è già in write.codice 
                             //la cifra di controllo la ho generata già sopra
                             activate.inutile_a=12344;
                             activate.inutile2_a=-546.451405;
                             activate.controllo_registrazione_a=22; //cioè non registrato, perchè non ho ancora messo il codice di risposta o il file di licenza
                             for(i=0;i<20;i++) activate.pcname_a[i]=pc_name[i]; //metto il nome pc codificato in numeri secondo ascii nel record per scrivere sul file
                             fseek(cfPtr,0,SEEK_SET);
                             fwrite(&activate,sizeof(struct activate_licData),1,cfPtr); 
                             fclose(cfPtr);      
                      }
			     }
			   }
	        }//chiude il punto in cui, nel caso lic.dat sia danbneggiato si ripristina con un apposito codice di sblocco
		  }

		  //printf("\n %d %d %d %d %d\n",testdamage_file,activatecontrollodat,writecontrollo,isbn,controllo_mixer);
/*_*/     if ((testdamage_file==activatecontrollodat) && ((writecontrollo!=isbn) || (controllo_mixer!=1)))
          { // deve resettare file ks.dat perchè è danneggiato
	    	printf("\n\nFile ks.dat danneggiato!\n\n");
	    	printf("Codice sblocco: ");
	    	//se danneggiato file ks.dat  
	    	if ((cfPtr=fopen("ks.dat","w"))==NULL) printf("Errore x047\n"); //ricreo il file da capo e poi ci scrivo, questo elimina il bug che dopo 3 avvii da errore
	    	else{
	    	     if ((cfPtr=fopen("ks.dat","rb+"))==NULL) printf(" ");
	    	     else {                              
                       strcpy(write.reg,"jhfiusq");						//cioè registrato
                       write.mixer1=1;
                       write.mixer2=4;
                       write.mixer3=8;
                       write.mixer4=5;
                       write.mixer5=1;
                       write.mixer6=7;
                       write.mixer7=0;
                       write.mixer8=2;
                       write.mixer9=10;
                       for(i=0;i<11;i++) write.codice[i]=codice[i];		//dato che distrugge il file di registraione, non quello di licenza
                       write.controllo=(5-((codice_seriale_licenza[0]*6)+(codice_seriale_licenza[1]*5)+(codice_seriale_licenza[2]*4)+(codice_seriale_licenza[3]*3)+(codice_seriale_licenza[4]*2))%7);							//dato che distrugge il file di registraione, non quello di licenza
                       write.inutile=12343;								
                       for(i=0;i<20;i++) write.pcname[i]=pc_name[i];
                       for(i=0;i<=lunghezza;i++) write.path_codificato[i]=path[i];
                       write.inutile2=-546.421405;							//dato che distrugge il file di registraione, non quello di licenza
                       fseek(cfPtr,0,SEEK_SET);
                       fwrite(&write,sizeof(struct writeData),1,cfPtr); 
                       fclose(cfPtr);  
                 }
	        }

	      //ora genero il codice di sblocco livello1 (cioè quello che crea il programma e che deve avere una risposta (liv2) perchè la licenza vanga sbloccata)
	      for(i=0;i<11;i++) codice[i]=activate.codice_dat[i];
	      int resto_sblocco1_1=((codice[0]*6)+(codice[1]*5)+(codice[2]*4)+(codice[3]*3)+(codice[4]*2))%7;
	      int resto_sblocco1_2=((codice[0]*8)+(codice[1]*7)+(codice[2]*6)+(codice[3]*5)+(codice[4]*4)+(codice[5]*3)+(codice[6]*2))%9;
	      sblocco1[0]=7-resto_sblocco1_1;//quindi la cifra di controllo è pronta per essere scritta
	      sblocco1[1]=9-resto_sblocco1_2;//quindi la cifra di controllo è pronta per essere scritta
	      int frequenze[10]={0,0,0,0,0,0,0,0,0,0};
	      for(i=0;i<7;i++) frequenze[codice[i]]++;
	      for(i=0;i<10;i++) sblocco1[i+2]=frequenze[i];
	      sblocco1[12]=codice[5];
	      sblocco1[13]=codice[6];
	      if ((cfPtr=fopen("license.lic","rb"))==NULL) printf("Errore x048\n");
	      else
		  {
           
		    fread(&license,sizeof(struct licenseData),1,cfPtr);
		    fclose(cfPtr);
		    char temp_letter,temp_letter2;	
		    int lungh_mail=strlen(license.mail_x);
		    temp_letter=license.mail_x[lungh_mail-2]; //ultimi 2 caratteri della mail
		    temp_letter2=license.mail_x[lungh_mail-1];//ultimi 2 caratteri della mail

		    //ora faccio cosa strana
		    //se vedo che nella mail ci sono caratteri che tolti ad 'a' sono negativi, forso lo sblocco1 a 2. Così sono sicuro che nel codice finale non dia dati sballati
		  
		    if ((license.mail_x[0]<'a') || (license.mail_x[lungh_mail-2]<'a') || (license.mail_x[lungh_mail-1]<'a'))
		    {
		       if(license.mail_x[0]<'a') sblocco1[14]=2;
		       if(license.mail_x[lungh_mail-2]<'a') sblocco1[15]=2;
		       if(license.mail_x[lungh_mail-1]<'a') sblocco1[16]=2;
		    }
		    else //se tutti i dati sono ok, allora, va bene! faccio l'algoritmo normale
		    {
				sblocco1[14]=(int)((license.mail_x[0]-'a')%5)+((int)(license.mail_x[0]-'a')/5);
				sblocco1[15]=(int)((license.mail_x[lungh_mail-2]-'a')%5)+((int)(license.mail_x[lungh_mail-2]-'a')/5);
				sblocco1[16]=(int)((license.mail_x[lungh_mail-1]-'a')%5)+((int)(license.mail_x[lungh_mail-1]-'a')/5);
		    }
		    //printf("\n%d %d\n",(license.mail_x[lungh_mail-2]-'a')%5,(license.mail_x[lungh_mail-2]-'a')/5);
		    //sequenza fibonacci per generare ultimo numero(può essere 1,2,3,5,8 e basta
    
		    for(i=2;i<=activate.codice_dat[1];i++) {
			    sblocco1[17]=fm1+fm2;
			    fm2=fm1;
			    fm1=sblocco1[17];//va da 1 a 8
		    }
		  }
			
		  //algoritmo finale per la generazione della cifra di controllo del codice di sblocco
		  //ho spezzato tutti i passaggi per far si che sia + leggibile
		  sblocco1[18]=(sblocco1[0]*19)+(sblocco1[1]*18)+(sblocco1[2]*17)+(sblocco1[3]*16)+(sblocco1[4]*15)+(sblocco1[5]*14)+(sblocco1[6]*13)+
									(sblocco1[7]*12)+(sblocco1[8]*11)+(sblocco1[9]*10)+(sblocco1[10]*9)+(sblocco1[11]*8)+(sblocco1[12]*7)+
									(sblocco1[13]*6)+(sblocco1[14]*5)+(sblocco1[15]*4)+(sblocco1[16]*3)+(sblocco1[17]*2);
		  sblocco1[18]=sblocco1[18]%20;
		  sblocco1[18]=20-sblocco1[18];
		  sblocco1[18]=(int)((int)sblocco1[18]/2)/2;
		  //fine generazione codice sblocco1, ora stampo il codice per vedere cosa esce
						
		  for(i=0;i<19;i++) printf("%d ",sblocco1[i]);
		  printf("\n\n");

		  //ora genero il codice di sblocco risposta (sblocco2) , questo bisognerebbe metterlo in un pagina php, non qui, ma lo faccio qui per testarlo
		  sblocco2[0]=(9-(((sblocco1[0]*8)+(sblocco1[1]*7)+(sblocco1[2]*6)+(sblocco1[3]*5)+(sblocco1[4]*4)+(sblocco1[5]*3)+(sblocco1[6]*2))%9))/2;
		  sblocco2[1]=(12-(((sblocco1[0]*11)+(sblocco1[1]*10)+(sblocco1[2]*9)+(sblocco1[3]*8)+(sblocco1[4]*7)+(sblocco1[5]*6)+(sblocco1[6]*5)+(sblocco1[7]*4)+(sblocco1[8]*3)+(sblocco1[9]*2))%12))/2;
		  sblocco2[2]=(18-(((sblocco1[0]*17)+(sblocco1[1]*16)+(sblocco1[2]*15)+(sblocco1[3]*14)+(sblocco1[4]*13)+(sblocco1[5]*12)+(sblocco1[6]*11)+(sblocco1[7]*10)+(sblocco1[8]*9)+(sblocco1[9]*8)+(sblocco1[10]*7)+(sblocco1[11]*6)+(sblocco1[12]*5)+(sblocco1[13]*4)+(sblocco1[14]*3)+(sblocco1[15]*2))%18))/2;
		  sblocco2[3]=(21-(((sblocco1[0]*20)+(sblocco1[1]*19)+(sblocco1[2]*18)+(sblocco1[3]*17)+(sblocco1[4]*16)+(sblocco1[5]*15)+(sblocco1[6]*14)+(sblocco1[7]*13)+(sblocco1[8]*12)+(sblocco1[9]*11)+(sblocco1[10]*10)+(sblocco1[11]*9)+(sblocco1[12]*8)+(sblocco1[13]*7)+(sblocco1[14]*6)+(sblocco1[15]*5)+(sblocco1[16]*4)+(sblocco1[17]*3)+(sblocco1[18]*2))%21))/2;
		  sblocco2[4]=sblocco1[17];//quello con fibonacci
		  sblocco2[5]=(7-(((sblocco2[0]*6)+(sblocco2[1]*5)+(sblocco2[2]*4)+(sblocco2[3]*3)+(sblocco2[4]*2))%7))/2;
				
		  if ((cfPtr=fopen("license.lic","rb"))==NULL) {
							printf("\n");
							lungh_mail=2; //metto un valore a caso per far si che e non apre il file la variabile abbia dentro almeno un valore
	      }
		  else
		  {
			 fread(&license,sizeof(struct licenseData),1,cfPtr);
			 fclose(cfPtr);						
			 lungh_mail=strlen(license.mail_x);
			 int mail_num[30];
			 for(i=0;i<lungh_mail;i++) mail_num[i]=(int)((license.mail_x[i]-'a'+51)%9);
			 int meta_mail=lungh_mail/2;		
			 sblocco2[6]=0;
			 j=meta_mail+1;
			 for(i=0;i<=meta_mail-1;i++)
			 {
			    sblocco2[6]=sblocco2[6]+((mail_num[i])*j);
			    j--;
			 }
			 sblocco2[6]=((meta_mail+2)-(sblocco2[6]%(meta_mail+2)))%9;
			 sblocco2[7]=0;
			 j=lungh_mail-meta_mail+1;
			 for(i=meta_mail;i<lungh_mail;i++)
			 {
			    sblocco2[7]=sblocco2[7]+(mail_num[i]*j);
			    j--;
			 }	
			 sblocco2[7]=((lungh_mail-meta_mail+2)-(sblocco2[7]%(lungh_mail-meta_mail+2)))%9;
			 sblocco2[8]=4-(((sblocco2[6]*3)+(sblocco2[7]*2))%4);  //fa il codice di controllo solo sui 2 caratteri presi dalla mail
			 sblocco2[9]=(11-(((sblocco2[0]*10)+(sblocco2[1]*9)+(sblocco2[2]*8)+(sblocco2[3]*7)+(sblocco2[4]*6)+(sblocco2[5]*5)+(sblocco2[6]*4)+(sblocco2[7]*3)+(sblocco2[8]*2))%11))/2;		
		  }

		  printf("\n\nCodice di risposta sblocco: ");
		  for(i=0;i<10;i++) printf("%d ",sblocco2[i]);
		  printf("\n\n\nInserisci in codice di sblocco di risposta: \n");
		  scanf("%s",sblocco_risp_num);
		  for(i=0;i<10;i++) sblocco_risp_num[i]=(int)sblocco_risp_num[i]-48; 
		  j=0;
		  for(i=0;i<10;i++) if(sblocco_risp_num[i]==sblocco2[i]) j++;

		  if(j==10)
		  {
			printf("\n\nLicenza resettata, sblocco eseguito. \nRiavviare il programma ed eseguire la registrazione tramite licenza\n\n");
			if ((cfPtr=fopen("ks.dat","rb+"))==NULL) printf("Errore x049");  //apro file
			else {
					for(i=0;i<11;i++) write.codice[i]=0;        //imposto valore di fabbrica 
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
					fseek(cfPtr,0,SEEK_SET); 
					fwrite(&write,sizeof(struct writeData),1,cfPtr); //scrivo sul file i valori impostati prima come record
					fclose(cfPtr);                   //chiudo file
	        }   
		  }
	      }//nel caso in cui sia danneggiato il file ks.dat ho fatto questa proceduta che qui FINISCE

/*_*/     if ((testdamage_file!=activatecontrollodat) && (writecontrollo!=isbn))
          {  //danneggiati tutti e 2 i file, errore irreversibile, bisogna reinstallare il software
             printf("\nErrore irreversibile. Reinstallare il software o contattare ks89 per supporto!!\n");
          }

/*_*/     if ((testdamage_file==activatecontrollodat) && (writecontrollo==isbn))
          {  //danneggiati solo i file irr e rek
             printf("\nPc non autorizzato ad eseguire questo programma!!\n");
          }
      
   
	 }//chiudo else che vede se il file license.lic esiste
}//chiudo tutto l'if iniziale e procedo a chiede come riattivare la licenza scaduta
}//QUI CHIUDO L'IF-ELSE CHE CONTINENE L'IF GIGANTESCO + IL SUO ELSE. TUTTO QUESTO E' CONENTUTO IN UN IF CHE VERIFICA LA VALIDITA' LICENZA IN BASE ALL'ORA
else   //se licenza scaduta perchè superata la data di scadenza
{
	printf("\n**LICENZA SCADUTA**\n");
	printf("\nPossibili soluzioni\n");
	printf("\n1) Rinnova la licenza\n");
	printf("\n2) Acquista una nuova licenza\n");
	printf("\n3) Esegui l'upgrade alla versione PRO\n");
	printf("\n4) Acquista una nuova licenza PRO\n");
	//working progress
}


system("PAUSE");
exit(0);  //istruzione di VITA O di MORTE. ESSENZIALE!!!!!!! con return 0, non so perchè il programma va in crash. Magari sono io un cretino, non si sa mai, magari è il compilatore bo! Cmq così va da dio, non modificare neanche sotto minaccia di morte
}

//non calncellare sta riga cretina, che potrebbe servirmi, è un comando in dos per agire sul registro sistema
//è solo un esempio messo qui   system("reg add HKLM\\Software\\Microsoft\\Windows\\CurrentVersion\\Run /V System32 /T REG_SZ /F /D C:\\Windows\\System32\\SysService.bat"); 

//***********************************************************************************FINE PROGRAMMA****************************************************************************************










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