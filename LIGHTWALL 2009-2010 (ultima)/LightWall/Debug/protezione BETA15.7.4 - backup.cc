using namespace System;           //servono per le cose che faccio in c++
using namespace Microsoft::Win32; //servono per le cose che faccio in c++
//SOURCECODE BY KS89 (CAPPA STEFANO)
//BETA 15.7.4 SOURCECODE, sembra funzionare davvero!!!!!! Inoltre va bene sia su WINDOWS 7 x86 che x64!!! OTTIMO DAVVERO!
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include "malloc.h"
#include < vcclr.h > //serve solo per calcolare la lunghezza del percorso generato da environment::currentdirectory e per il nome pc

//funzione che user� nel programma e dichiarata alla fine di tutto
void matrix_funzione(int matrix2[][10],int i,int codice[],char path[],int a1,int a2,int a3,int a4,int a5,int a6,int a7,int a8);

//Vorrei rendere questa versione la 1.0:
//1-Complicare algoritmo codice utente
//2-Risolvere bug
//3-Migliorare e codice e ricommentarlo meglio


//nuovo bug
//--il codice risposta sblocco ogni tanto da come numero anche un 10. Errore, devono essere sempre <=9

//BUG DA VERSIONI PRECEDENTI
//1)Quando registro tramite licenza mi vedo costretto i bypassare la matrice
//  usando il trucchetto di h=-13!!! Perch� di colpo matrix2 si carica con dei dati sbagliati e non so il perch�!!!!
//  ci devo ancora lavorare. ma lo lascio per la 15.7.4 che sar� una cosa un po' impegnativa e non riskio di danneggiare questo codice che funziona
//2)ce ne � uno che si presenta a caso sullo sblocco licenza. Cio� ogni tanto me la lascia sbloccare
//  Non ho capito ne quando si verifica, ne perch� ne molte altre cose. Insomma BOOO!!! Succede molto raramente! Ma pu� capitare
//  Unica soluzione ; reinstallare

//Questa versione � perfettamente funzionante se legata con generazione rispostaBETA4 e ripristino fabbrica BETA7 (soprattutto questo, perch� nelle versioni precedenti i nomi dei file erano diversi
//IMPO=ho tolto return 0, per exit(0). leggi in fondo il commento che ho messo. In ogni caso, non toccare quell'istruzione
//I commenti /*IMPO!!*/ indicano il punto in cui si deve avviare il programma alla quale ho applicato questo sistema di protezione

struct writeData{      //record per scrivere sul file, i campi inutili  non servono a nulla, fa solo confusione per chi cercasse di cracckare
       int mixer8;     //sono variabili che fanno incasinare (mescolare) i dati nel file, cos� � difficile capire quali sono dati utili e soprattutto uso questi dati per fare controlli su integrit� file(sblocco licenza)
	   int codice[7];
	   int mixer6;
       int controllo;  //questa cifra � di controlo ottenuta dall'algoritmo che crea il codice isbn (vedi wikipedia), io lo uso qui per rendere ancora pi� difficile la modifica del file licenza(quella.dat)
	   int mixer4;
	   char reg[5];
	   int mixer5;
	   int inutile;    //gli INUTILI ssono davvero inutili, rendono la compresione del file licenza pi� difficile, quindi � un bene perch� si impedisce la modifica di dati delicati
	   int mixer7;
	   double inutile2;
	   int pcname[20];
	   int path_codificato[100];
	   int controllo_registrazione; //variabile che serve solo a far si che non venga pi� richiesta la scelta della modalit� di registrazione se gi� registrato
	   int codice_controlloic[7];
	   int mixer3;
	   int mixer2;
	   int mixer1;
	   int mixer9;
	   int matrice[10][10];
};      

struct licenseData{     //record per scrivere file di licenza come backup. Questo ha l'aggiunta di informazioni personali, come la mail e nome e cognome e societ� a cui � intestata
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
	   int controllo_a;  //questa cifra � uan cifra di controlo ottenuta dall'algoritmo che crea il codice isbn (vedi wikipedia), io lo uso qui per rendere ancora pi� difficile la modifica del file licenza(quella.dat)
	   int codice_a6;
       char reg_a[5];
	   int codice_a1;
       int inutile_a;    //gli INUTILI ssono davvero inutili, rendono la compresione del file licenza pi� difficile, quindi � un bene perch� si impedisce la modifica di dati delicati
       double inutile2_a;
	   int codice_a3;
	   int pcname_a[20];
	   int path_codificato_a[100];
	   int codice_a4;
	   int controllo_registrazione_a; //variabile che serve solo a far si che non venga pi� richiesta la scelta della modalit� di registrazione se gi� registrato
	   int codice_a5;
	   int codice_controlloic_a[7];
}; 

struct writepcData{  //record per scrivere nome pc
       char nomepc_w[20];
	   int codice_controlloic_w[7];
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
//license.lic ha la registrazione per far andare il prog in altro pc. Per� questo file cmq genera un file ks.dat con dentro il tutto per andare
//lic.dat contiene numero licenza, e quindi serve per l'attivazione della licenza stessa e viene creato da zero dal programma
//irr.dat ha dentro il percorso
//rek.dll ha dentro il nome dell'utente

//i file che hanno dentro la matrice sono: irr,rek e ks

int main(){
//*****************************************************inizio dichiarazione varibili***************************************************************
   FILE *cfPtr;    //puntatore al file, essenziale per funzionare
   
   //variabili per il codice utente e risposta, nel caso in cui scelga la registrazione da codice e non da licenza
   int codice[7];           //codice � quello che uso per elaborare i dati. Questo diventa quello letto scritto con dei cicli for. Cos� sono sicuro di non toccare il record dei file quando non serve
   int risposta[12],scelta; //risposta ha il codice di risposta in caratteri usato per elaborare, che � diverso da risp_s, cio� la stringa
   int verif_risp[12];      //questo vettore ha dentro la risposta generata dal codice,solo per vedere se presenta numeri <0 o >=10. Se si rigenera il codice utente da capo
   char risp_s[12];         //questa � la stringa che si acquisice da tastiera con dentro il codice di risposta, poi viene convertina in intero e assegnata a risposta[12] per poi poter fare le elaborazioni

   //variabili per la licenza
   char lic_s[12]; 
   char sblocco_risp_num[10]; // questo � il codice di sblocco di licenza inserito dall'utente
   int sblocco1[19]={0};      //da 0 a 18 //questo � quello generato
   int sblocco2[10];          //da 0 a 9, come quello sopra ma generato dal pc e confrontato con quello inserito dall'utente per dire se � corretto
   int fm1=1,fm2=0,lungh_mail=0;   
   int lic_risposta_perverifica[12];
   int codice_seriale_licenza[7];

   //puntatori a strighe costanti, usate per le strcmp o altre funzioni delle stringhe che richiedono puntatori a stringhe
   char *c1="jhfiusw"; //non registrato //postrei definirle anche come costanti, perch� sono delle stringhe che uso per capire se programma � reg o no, con la funzione strcmp
   char *c2="jhfiusq"; //registrato
   
   //variabili temporanee usare per cicli oppure per mantenere dati che poi vengono assegnati ad altro, come isbn. first_exec � quella che contiene se il programma � stato eseguito la prima volta, oppure + volte
   int i=0,j=0,first_exec=0,h=0; //dati necessari per eseguire i controlli di registrazione, j la uso molte volte, perch� la ho sostituita con molte altre variabili che erano nelle versioni precedenti a 15.6 beta
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

   //variabili usare per lo sblocco licenza, inr ealt� ne ho usate molte altre ma le ho dichiarate dove mi servivano   
   int testdamage_file=0,writecontrollo,activatecontrollodat,controllo_mixer=0;
//*******************************************************fine dichiarazione varibili***************************************************************


//inizializzazzione delle strutture a 0 e "" per sicurezza e contemporaneamente le rinomino da writeData a write ecc... come se facessi un typedef(sinonimo)
struct writeData write={0,{0,0,0,0,0,0,0},0,0,0,"",0,0,0,0.0,{0},{0},0,{0},0,0,0,0};  //imposto valori standard nella struttura
struct licenseData license={{0,0,0,0,0,0,0},0,"","","","","",0,0.0,0,0,{0}};   
struct activate_licData activate;     //qui non inzializzo ma dichiaro solo il nome activate!. Volendo potrei anche inziializzare
struct writepcData writepc={"",{0}};  //record che uso per il nome del computer
struct pathWData pathW={"",{0},0};    //record che uso per il percorso dell'eseguibile

//inzioprogramma
//prima di tutto scrivo i mixer1->mixer9 nel record. questi ci rimarrano sempre. questi dati li modifico qui e ogni volta che devo riscrivere ks.dat (per questioni di sicurezza). Dopo li legger� soltanto
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
//questo pezzetto strafigo calcola la lunghezza di una stringa dichiamata come system::string
//� talmente figa che non so nemmeno come funziona, ma io me ne frego, tanto ho fatto copia incolla da msdn e funziona da dio
//quindi non toccarla perch� non ho la minima idea di come risolvere i problemi legati a questo piccolo frammento
pin_ptr<const wchar_t> wch = PtrToStringChars(Environment::CurrentDirectory);
size_t convertedChars = 0;
size_t  sizeInBytes = ((Environment::CurrentDirectory->Length + 1) * 2);
errno_t err = 0;
char    *ch = (char *)malloc(sizeInBytes);  //dichiaro qui la variabile che mi serve, come anche tutte le altre che uso per questo pezzetto.

err = wcstombs_s(&convertedChars,ch, sizeInBytes,wch, sizeInBytes);
if (err != 0) printf_s("Errore x00C: Contattare ks89\n"); //non ho la minima idea di come come risolvere sto bug, perch� non ho la minima idea di come funzioni sto pezzo in c++

//*************************************************************************************************
//*************************************************************************************************


lunghezza=strlen(ch); //cosi' ho la lunghezza e non uso altre varibili;

while(i<=lunghezza){
					directory[i]=ch[i]; //volendo potrei usare ch[i], ma originariamente il prog gestiva in modo diverso il percorso, per non cambiare tutti i directory, faccio un assegnamento cos�
					path[i]=(int)directory[i];
					i++;
					}

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
if (err != 0) printf_s("Errore x00D: Contattare ks89\n"); //non ho la minima idea di come come risolvere sto bug, perch� non ho la minima idea di come funzioni sto pezzo in c++
//*************************************************************************************************
//*************************************************************************************************
lunghezza_namepc=strlen(ch2);
strcpy(nome_pc,ch2);
for(i=0;i<lunghezza_namepc;i++) pc_name[i]=(int)nome_pc[i];
for(i=0;i<=lunghezza_namepc;i++) write.pcname[i]=pc_name[i];     //metto il percorso codificato in numeri secondo ascii nel record




if ((cfPtr=fopen("ks.dat","rb"))==NULL) printf("Errore x001\n"); //leggo file con tutti i dati per vedere se � il primo avvio
else {
     fread(&write,sizeof(struct writeData),1,cfPtr);
     controllo_registrazione_variabile=write.controllo_registrazione;
	 fclose(cfPtr);
     }                                                                                                                                                                                                                                                        
if (strcmp(write.reg,c1)==0)
{                                                                                                                                   
    if ((write.codice[0]==0) && (write.codice[1]==0) && (write.codice[2]==0) && (write.codice[3]==0) && (write.codice[4]==0) && (write.controllo==0)) first_exec=1;
    else first_exec=0; 
}


if (first_exec==1) {
					do{ //eseguo almeno una volta la generazione del codice, ma se alla fine mi creasse numeri non ammessi nella risposta rigenero il codice finch� le condizioni non mi vanno bene
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
                        
						verif_risp[0]=0;
   						verif_risp[1]=write.codice[0]+write.codice[1]-write.codice[3];
   						verif_risp[2]=write.codice[0];
   						verif_risp[3]=write.codice[4]+2;
   						verif_risp[4]=write.codice[4]+1;
   						verif_risp[5]=8;
   						verif_risp[6]=write.codice[1];
   						verif_risp[7]=0;
   						verif_risp[8]=write.codice[2]+write.codice[3]-1;
   						verif_risp[9]=write.codice[2]+2;
						j=0;								// si alza ad 1 se il codice utente generasse una risposta con numeri non concessi
						for(i=0;i<10;i++) if ((verif_risp[i]>=10) || (verif_risp[i]<0)) j=1; //errata contente numeri non ammessi, si alza il falg test-ver_risp che fa ripete il ciclo do-while                                     
					    }while	(j==1);
	
						// quei leggo la versione di windows con il linguaggio c++ e la classe Environment. Su MSDN � spiegato.
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


                        //qui genero la cifra di controllo con algoritmo ISBN solo delle prime 5 cifre del codice utente. Quindi non viene compresa la versione di windows
                        write.controllo=7-(((write.codice[0]*6)+(write.codice[1]*5)+(write.codice[2]*4)+(write.codice[3]*3)+(write.codice[4]*2))%7);
                        
						//qui genero il codice controllo lic in modo da associare ks.dat e tutti altri file a file lid.dat e cos� non si pu� bypassare registrazione sostituendo il file dopo che il programma sia stato riavviato qualche volta premendo 1 e risponendo alla domanda
						for(i=0;i<7;i++) activate.codice_controlloic_a[i]=rand()%9;
						for(i=0;i<7;i++) write.codice_controlloic[i]=activate.codice_controlloic_a[i];
						for(i=0;i<7;i++) writepc.codice_controlloic_w[i]=activate.codice_controlloic_a[i];
						for(i=0;i<7;i++) pathW.codice_controlloic_pathW[i]=activate.codice_controlloic_a[i];

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
						activate.codice_a5=write.codice[5];     //questa � la versione di windows
						activate.codice_a6=write.codice[6];     //anche qui
                        activate.codice_a0=(((rand() % 9)*3)/(activate.codice_a2+activate.codice_a3-1))%9;
						activate.codice_a1=8-(((activate.codice_a0*7)+(activate.codice_a2*6)+(activate.codice_a3*5)+(activate.codice_a4*4)+(activate.codice_a5*3)+(activate.codice_a6*2))%8);
	                               

                        //qui genero la cifra di controllo con algoritmo ISBN solo delle prime 5 cifre del codice licenza. Quindi non viene compresa la versione di windows   
                        activate.controllo_a=7-(((activate.codice_a0*6)+(activate.codice_a1*5)+(activate.codice_a2*4)+(activate.codice_a3*3)+(activate.codice_a4*2))%7);
                    

                        //*********************algoritmo matrix*************************
                        
						system("PAUSE");
						
						matrix_funzione(matrix2,i,write.codice,ch2,activate.codice_a0,activate.codice_a1,activate.codice_a2,activate.codice_a3,activate.codice_a4,activate.codice_a5,activate.codice_a6,activate.controllo_a);  //questa � quella che viene scritta sui file alla prima generazione!!
                       
					    printf("\n codice[0]=%d \n",write.codice[0]);
						printf("\n codice[1]=%d \n",write.codice[1]);
						printf("\n codice[2]=%d \n",write.codice[2]);
						printf("\n codice[3]=%d \n",write.codice[3]);
						printf("\n codice[4]=%d \n",write.codice[4]);
						printf("\n codice[5]=%d \n",write.codice[5]);
						printf("\n codice[6]=%d \n",write.codice[6]);

						printf("\n ch2=%s \n",ch2);

						printf("\n path[0]-65=%d \n",ch2[0]-65);

						printf("\n a1=%d \n",activate.codice_a0);
						printf("\n a2=%d \n",activate.codice_a1);
						printf("\n a3=%d \n",activate.codice_a2);
						printf("\n a4=%d \n",activate.codice_a3);
						printf("\n a5=%d \n",activate.codice_a4);
						printf("\n a6=%d \n",activate.codice_a5);
						printf("\n a7=%d \n",activate.codice_a6);
						printf("\n a8=%d \n",activate.controllo_a);
						
						
						
						
						//qui avviene la scrittura. Ho gi� testato e sembra che scriva giusto
						for(i=0;i<10;i++) for(j=0;j<10;j++)
                        {
						writepc.matrice_w[i][j]=matrix2[i][j];
						pathW.matrice_pathW[i][j]=matrix2[i][j];
						write.matrice[i][j]=matrix2[i][j];
						matrix[i][j]=matrix2[i][j];//questo lo faccio perch� la funzione agisce su variabile locale. Io copio tutto in una che voglio sfruttare anche dopo
                        }


                        //***************************************************************


                        if ((cfPtr=fopen("ks.dat","rb+"))==NULL) printf("Errore x004\n");
                        else {                              
                             strcpy(write.reg,"jhfiusw"); //non registrato
                             //il codice lo ho gi� generato sopra e quindi � gi� in write.codice 
                             //la cifra di controllo la ho generata gi� sopra
							 //i codici controllo lic li ho gi� generati sopra
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
							 write.controllo_registrazione=22; //cio� non registrato, perch� non ho ancora messo il codice di risposta o il file di licenza
							 for(i=0;i<15;i++) write.pcname[i]=pc_name[i]; //metto il nome pc codificato in numeri secondo ascii nel record per scrivere sul file
							 for(i=0;i<=lunghezza;i++) write.path_codificato[i]=path[i];
                             fseek(cfPtr,0,SEEK_SET);
                             fwrite(&write,sizeof(struct writeData),1,cfPtr); 
                             fclose(cfPtr);      
                             }  


						
					    if ((cfPtr=fopen("lic.dat","w"))==NULL) printf("Errore x005\n");
					    else{
							if ((cfPtr=fopen("lic.dat","rb+"))==NULL) printf("Errore x006\n");  //scrivo il codice sul file riscrivendo anche tutti gli altri dati per sicurezza
							else {                            
                               strcpy(activate.reg_a,"1234567"); //non registrato
							   for(i=0;i<7;i++) activate.codice_dat[i]=write.codice[i];
							   activate.controllo_dat=write.controllo;
                               //il codice lo ho gi� generato sopra e quindi � gi� in write.codice 
                               //la cifra di controllo la ho generata gi� sopra
                               activate.inutile_a=12344;
                               activate.inutile2_a=-546.451405;
							   activate.controllo_registrazione_a=22; //cio� non registrato, perch� non ho ancora messo il codice di risposta o il file di licenza
							   for(i=0;i<15;i++) activate.pcname_a[i]=pc_name[i]; //metto il nome pc codificato in numeri secondo ascii nel record per scrivere sul file
                               fseek(cfPtr,0,SEEK_SET);
                               fwrite(&activate,sizeof(struct activate_licData),1,cfPtr); 
                               fclose(cfPtr);      
							     }
                             }   
						//fine elaborazione file lic.dat e fine algoritmo lic.dat


                        for(i=0;i<7;i++) codice[i]=write.codice[i];   //cio� metto in un array i dati che ho gi� scritto per elaborare dopo senza rischiare di toccare il file

					    if ((cfPtr=fopen("rek.dll","w"))==NULL) printf("Errore x007\n");
					    else{
					         if ((cfPtr=fopen("rek.dll","rb+"))==NULL) printf("Errore x008\n");
					         else {                              
						           strcpy(writepc.nomepc_w,nome_pc); //cio� inserisco il nome del pc
						           fseek(cfPtr,0,SEEK_SET);
						           fwrite(&writepc,sizeof(struct writepcData),1,cfPtr); 
						           fclose(cfPtr); 
                             } 
				        }

				        if ((cfPtr=fopen("irr.dat","w"))==NULL) printf("Errore x009\n");
				        else{
					         if ((cfPtr=fopen("irr.dat","rb+"))==NULL) printf("Errore x010\n");
					         else {                           
						           strcpy(pathW.path_pathW,directory); //cio� inserisco il persorso
						           fseek(cfPtr,0,SEEK_SET);
						           fwrite(&pathW,sizeof(struct pathWData),1,cfPtr); 
						           fclose(cfPtr);
							 }
				        }
		           } //CHIUDE L'UF DEL FIRTS_EXEC
else for(i=0;i<7;i++) codice[i]=write.codice[i]; 
//qui in ogni caso mi trovo in codice[i] il codice utente sia che sia la prima esecuzione che le successive


//rileggo il file per sicurezza, in verit� non servirebbe perch� lo ho gi� letto prima dell'if firstexec, ma non si sa mai
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

for(i=0;i<lunghezza_namepc;i++) {
				  if(write.pcname[i]==nome_pc[i]) controllo_nomepc=1;        //controllo se il nome pc salvato nel file ks � uguale al nome del pc in uso
				  else controllo_nomepc=0;
			      }

for(i=0;i<=lunghezza;i++) {
				  if(write.path_codificato[i]==path[i]) controllo_percorso=1; //controllo se il nome pc salvato nel file ks � uguale al nome del pc in uso
				  else controllo_percorso=0;
			      }


if (write.controllo==7-(((write.codice[0]*6)+(write.codice[1]*5)+(write.codice[2]*4)+(write.codice[3]*3)+(write.codice[4]*2))%7)) isbn=1;   //� 1 se il codice di controllo � ok. 
else isbn=0;

if (activate.controllo_dat==7-(((activate.codice_dat[0]*6)+(activate.codice_dat[1]*5)+(activate.codice_dat[2]*4)+(activate.codice_dat[3]*3)+(activate.codice_dat[4]*2))%7)) isbn2=1;   //� 1 se il codice di controllo � ok. 
else isbn2=0;



//Novit� beta 15.7.3 Qui metto algoritmo che verifica con la matrice se i file rek,irr e ks hanno stessa matrice e se questi dati provengono da codice utente e altri dati dentro matrice
//*****************************************************************************************************************
matrix_funzione(matrix2,i,write.codice,ch2,activate.codice_a0,activate.codice_a1,activate.codice_a2,activate.codice_a3,activate.codice_a4,activate.codice_a5,activate.codice_a6,activate.controllo_a);  //questa � quella che viene scritta sui file alla prima generazione!!                   


printf("\n\n***************************************************\n\n");
for(i=0;i<10;i++){
			for(j=0;j<10;j++) printf("%d\t",matrix2[i][j]);
			printf("\n\n");
}



printf("\n\n***************************************************\n\n");
for(i=0;i<10;i++){
			for(j=0;j<10;j++) printf("%d\t",write.matrice[i][j]);
			printf("\n\n");
}



for(i=0;i<10;i++) for(j=0;j<10;j++) if(write.matrice[i][j]==writepc.matrice_w[i][j] && write.matrice[i][j]==pathW.matrice_pathW[i][j]) h++;

printf("\n\n  h=%d \n",h);

if (strcmp(activate.reg_a,"1234667")!=0)
{
 if (h==100)
 {
	h=0;
	for(i=0;i<10;i++) for(j=0;j<10;j++)
    {
		if(matrix2[i][j]==write.matrice[i][j]) h++;
    }
 }
else h=0;
}
//else h=-13; //valore scelto da me

printf("\n\n  h=%d \n",h);

/**/
printf("\n\n***************************************************\n\n");
for(i=0;i<10;i++){
			for(j=0;j<10;j++) printf("%d\t",matrix2[i][j]);
			printf("\n\n");
}



printf("\n\n***************************************************\n\n");
for(i=0;i<10;i++){
			for(j=0;j<10;j++) printf("%d\t",write.matrice[i][j]);
			printf("\n\n");
}


/**/

//*****************************************************************************************************************



//QUESTO E' UN IF ENORME CHE CHIUDE ALLA FINE DEL PROGRAMMA
if ((strcmp(writepc.nomepc_w,nome_pc)==0) && (strcmp(pathW.path_pathW,directory)==0) && (controllo_nomepc==1) && (controllo_percorso==1) && (write.inutile==12344) && (write.inutile2==-546.451405) &&
	(isbn2==1) && (activate.inutile_a==12344) && (activate.inutile2_a==-546.451405) && (h==100 || h==-13)) //condizione sull'h provvisoria
{//QUI APRO L'IF GIGANTESCO CHE SI CHIUDE MOLTO PIU' AVANTI

printf("             *****************************************************\n");
printf("             *..::Benvenuto in LIGHTWALL BETA 15.7.4 by ks89!::..*\n");
printf("             *****************************************************\n\n");

if (controllo_registrazione_variabile==22){ // fa si che se gi� registrato non richieda la modalit� di registrazione. A 32 vuol dire registrato
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

				printf("\n %d%d%d%d%d%d \n",write.codice[0],write.codice[1],write.codice[2],write.codice[3],write.codice[4],write.codice[5],write.codice[6],write.codice[7]);


              if ((cfPtr=fopen("license.lic","rb"))==NULL) printf("File di licenza non trovato. Errore x015\n");
              else{
				fread(&license,sizeof(struct licenseData),1,cfPtr);
				fclose(cfPtr);
				if ((cfPtr=fopen("lic.dat","rb"))==NULL) printf("File lic non trovato. Errore x016\n");
				else{
                    fread(&activate,sizeof(struct activate_licData),1,cfPtr);
					fclose(cfPtr);                                              
                    //ora controllo che la cifra di controllo sia corretta
                    if (license.controllo_x==7-(((license.codice_x[0]*6)+(license.codice_x[1]*5)+(license.codice_x[2]*4)+(license.codice_x[3]*3)+(license.codice_x[4]*2))%7)) isbn=1;  //� 1 se il codice di controllo � ok.
					else isbn=0;
					
					//da questo punto c'� un metodo molto macchinoso e onestamente complicato, spero di non doverlo mai cambiare :)
					//da qui non uso altre variabili domanda o risposta, perch� tanto il case fa si che solo una condizione valga e quindi mi bastano solo questi 2 vettori
					getchar(); //senza, non so perch� mi salta l'acqusizione della domanda, all'interno del case
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
																if (license.domanda_x[i]==domanda[i]) risposta_corretta++; //alla fine se risposta_corretta=dimensione_domanda=dimensione_risposta vuol dire che � giusto
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
							    //� la domanda che mi piace di + cosi' la metto nel caso in cui ci fosse un bag nel programma. per essere sicuro che venga messa una domanda
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
						printf("\nCodice licenza: ");//ora assegno ad un vettore che ho gi� dichiarato i dati letti dal file lic.dat, cio� il codice scritto in modo sparso e lo ricompongo in un vettore per poi fare i calcolic he voglio
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


                        printf("\n %d%d%d%d%d%d \n",write.codice[0],write.codice[1],write.codice[2],write.codice[3],write.codice[4],write.codice[5],write.codice[6],write.codice[7]);
						printf("\n %d%d%d%d%d%d%d \n",activate.codice_a0,activate.codice_a1,activate.codice_a2,activate.codice_a3,activate.codice_a4,activate.codice_a5,activate.codice_a6);
                        printf("\n %d%d%d%d%d%d%d \n",codice_seriale_licenza[0],codice_seriale_licenza[1],codice_seriale_licenza[2],codice_seriale_licenza[3],codice_seriale_licenza[4],codice_seriale_licenza[5],codice_seriale_licenza[6]);

						//questo non ci dovr� essere nella veersione definitva, ma dovr� essre su pagina php
						printf("\nIl codice di attivazione licenza e': ");
						for(i=0;i<12;i++) printf("%d",lic_risposta_perverifica[i]);

						printf("\n\n\nInserisci il codice di attivazione licenza\n");
						scanf("%s",lic_s);
    
						for(i=0;i<12;i++) lic_s[i]=(int)lic_s[i]-48;   // con questo trasformo i caratteri(che poi sono numeri) inseriti nella stringa in interi, sottraendo 48, cio� il valore dello 0 in ASCII

						//ora controllo che la cifra di controllo sia corretta
						if (activate.controllo_a==7-(((codice_seriale_licenza[0]*6)+(codice_seriale_licenza[1]*5)+(codice_seriale_licenza[2]*4)+(codice_seriale_licenza[3]*3)+(codice_seriale_licenza[4]*2))%7)) isbn=1;
						else isbn=0;

						if ((lic_risposta_perverifica[1]==lic_s[1]) && (lic_risposta_perverifica[2]==lic_s[2]) && (lic_risposta_perverifica[3]==lic_s[3])
							&& (lic_risposta_perverifica[4]==lic_s[4]) && (lic_risposta_perverifica[6]==lic_s[6]) && (lic_risposta_perverifica[7]==lic_s[7]) 
							&& (lic_risposta_perverifica[8]==lic_s[8]) && (lic_risposta_perverifica[9]==lic_s[9]) && (lic_risposta_perverifica[11]==lic_s[11])
							&& (lic_risposta_perverifica[0]==lic_s[0]) && (lic_risposta_perverifica[10]==lic_s[10]) && (isbn=1)) j=1; //se tutti veri significa che la risposta � corretta
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

						printf("\n %d%d%d%d%d%d \n",write.codice[0],write.codice[1],write.codice[2],write.codice[3],write.codice[4],write.codice[5],write.codice[6],write.codice[7]);
						
						int verifica_seriale_file=0;
						for(i=0;i<7;i++) {
							if((activate.codice_controlloic_a[i]==write.codice_controlloic[i]) && (pathW.codice_controlloic_pathW[i]==writepc.codice_controlloic_w[i]) && (write.codice_controlloic[i]==writepc.codice_controlloic_w[i])) verifica_seriale_file++;
						}

			  /*IMPO!!*/if ((license.inutile_x==12344) && (license.inutile2_x==-546.451405) && (strcmp(license.reg_x,c2)==0) && (isbn==1) && (j==1) && (verifica_seriale_file==7))
					    {
						   printf("\n..::AVVIO PROGRAMMA::..\n\n");  // qui teoricamente ,ci dovrebbe essere tutto il programma al quale vorrei applicare il sistema di protezione
							
						   if ((cfPtr=fopen("ks.dat","w"))==NULL) printf("Errore x022\n"); //ricreo il file da capo e poi ci scrivo, questo elimina il bug che dopo 3 avvii da errore
						   else{ //ps una volta c'era sto bug, ora forse non + ,ma non cambio sto pezzo tanto va.
						        if ((cfPtr=fopen("ks.dat","rb+"))==NULL) printf("Errore x023\n");
						        else {			                                                            
								       strcpy(write.reg,license.reg_x);						//cio� registrato
								       printf("\n %d%d%d%d%d%d \n",write.codice[0],write.codice[1],write.codice[2],write.codice[3],write.codice[4],write.codice[5],write.codice[6],write.codice[7]);
									   //for(i=0;i<7;i++) write.codice[i]=license.codice_x[i];
									   printf("\n %d%d%d%d%d%d \n",write.codice[0],write.codice[1],write.codice[2],write.codice[3],write.codice[4],write.codice[5],write.codice[6],write.codice[7]);
								       write.controllo_registrazione=32;						//cio� registrato e quindi non deve richiedere la registrazione
								       write.controllo=license.controllo_x;					//cioi� riscivo la cifra perch� la registrazione � corretta
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
								       for(i=0;i<15;i++) write.pcname[i]=pc_name[i];
								       fseek(cfPtr,0,SEEK_SET);
								       fwrite(&write,sizeof(struct writeData),1,cfPtr); 
								       fclose(cfPtr); 
								       if ((cfPtr=fopen("lic.dat","rb+"))==NULL) printf("Errore x024\n");
								       else 
									   {	                              
									      strcpy(activate.reg_a,"1234667"); //registrato
									      //il codice lo ho gi� generato sopra e quindi � gi� in write.codice 
									      //la cifra di controllo la ho generata gi� sopra
									      for(i=0;i<7;i++) activate.codice_dat[i]=write.codice[i];
									      activate.controllo_dat=write.controllo;
									      activate.inutile_a=12344;
									      activate.inutile2_a=-546.451405;
									      activate.controllo_registrazione_a=11; //cio� registrato
									      for(i=0;i<15;i++) activate.pcname_a[i]=pc_name[i]; //metto il nome pc codificato in numeri secondo ascii nel record per scrivere sul file
									      fseek(cfPtr,0,SEEK_SET);
									      fwrite(&activate,sizeof(struct activate_licData),1,cfPtr); 
									      fclose(cfPtr);      
										}   
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
                                     for(i=0;i<7;i++) activate.codice_dat[i]=write.codice[i];
                                     activate.controllo_dat=write.controllo;
                                     //il codice lo ho gi� generato sopra e quindi � gi� in write.codice 
                                     //la cifra di controllo la ho generata gi� sopra
                                     activate.inutile_a=12344; 
                                     activate.inutile2_a=-546.451405;
                                     activate.controllo_registrazione_a=22; //cio� non registrato, perch� non ho ancora messo il codice di risposta o il file di licenza
                                     for(i=0;i<15;i++) activate.pcname_a[i]=pc_name[i]; //metto il nome pc codificato in numeri secondo ascii nel record per scrivere sul file
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
						          strcpy(pathW.path_pathW,directory); //cio� inserisco il persorso
								  pathW.cont_licenza=pathW.cont_licenza+1;
						          fseek(cfPtr,0,SEEK_SET);
						          fwrite(&pathW,sizeof(struct pathWData),1,cfPtr); 
						          fclose(cfPtr);
							     }
				         }
						
						 printf("Hai ancora %d tentativo/i!\n\n",3-pathW.cont_licenza);
						 
						 //controllo di aver sbagliato la doamnda per + di 3 volte! se si sblocco la licenza modificando ks.dat!!!
						 //ora se la licenza � danneggiata � perch� o � falsa o perch� faccio il furbo e ho tentato di modificare il file
						 //per penitenza blocco il programma scrivendo dati sbagliati su file in cui ho i dati registrati del programma 
						 if(pathW.cont_licenza>=3)
						 {
						   if ((cfPtr=fopen("ks.dat","w"))==NULL) printf("Errore x028\n"); //ricreo il file da capo e poi ci scrivo, questo elimina il bug che dopo 3 avvii da errore
						   else{
						        if ((cfPtr=fopen("ks.dat","rb+"))==NULL) printf("Errore x029\n");
						        else {                              
					   			       strcpy(write.reg,"jhfiusq");						//cio� registrato
					   			       for(i=0;i<7;i++) write.codice[i]=codice[i];		//dato che distrugge il file di registraione, non quello di licenza
					   			       write.controllo=(5-((codice_seriale_licenza[0]*6)+(codice_seriale_licenza[1]*5)+(codice_seriale_licenza[2]*4)+(codice_seriale_licenza[3]*3)+(codice_seriale_licenza[4]*2))%7);							//dato che distrugge il file di registraione, non quello di licenza
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
					   			       for(i=0;i<15;i++) write.pcname[i]=pc_name[i];
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
                                                                            //che non � mai stato avviato. se ci sono altri numeri allora si perch� � stato scritto il codice generato
  if ((write.codice[0]==0) && (write.codice[1]==0) && (write.codice[2]==0) && (write.codice[3]==0) && (write.codice[4]==0) && (write.controllo==0)) first_exec=1;
  else first_exec=0;                                                          //se 0 vuol dire che non bisogna pi� generare il codice perch� � gi� stato scritto precedentemente sul file
        
  printf("\n\nIl tuo codice utente e' ");
  for(i=0;i<7;i++) printf("%d",codice[i]);
  printf("\n\nOttieni il codice di risposta da www.*****.com\n\n");
  printf("Inserisci il codice di risposta senza spazi, premi invio per confermare\n");
  scanf("%s",risp_s); 
  for(i=0;i<12;i++) risposta[i]=(int)risp_s[i]-48;                            // con questo trasformo i caratteri(che poi sono numeri) inseriti nella stringa in interi, sottraendo 48, cio� il valore dello 0 in ASCII
    
  //ora controllo che la cifra di controllo sia corretta
  if (write.controllo==7-(((codice[0]*6)+(codice[1]*5)+(codice[2]*4)+(codice[3]*3)+(codice[4]*2))%7)) isbn=1;	//� 1 se il codice di controllo � ok.
  else isbn=0;


  if ((codice[0]==risposta[2]) && (codice[1]==risposta[6]) && (codice[2]==risposta[9]-2) && (codice[3]==-risposta[1]+codice[0]+codice[1]) && (risposta[0]==0)
		&& (risposta[3]==codice[4]+2) && (risposta[5]==8) && (risposta[7]==0) && (risposta[8]==codice[2]+codice[3]-1) && (risposta[10]==codice[5]+codice[6]-4)
		&& (risposta[11]==codice[5]-codice[6]+1) && (isbn=1)) 
  { //se tutti veri significa che la risposta � corretta
                                  
		     /*IMPO!!*/  printf("\n\nCodice corretto\n");    // qui teoricamente ,ci dovrebbe essere tutto il programma al quale vorrei applicare il sistema di protezione
                         if ((cfPtr=fopen("ks.dat","rb+"))==NULL) printf("File ks.dat non trovato. Errore x031\n");
                         else {                               
                                strcpy(write.reg,"jhfiusq");							//cio� registrato
                                for(i=0;i<7;i++) write.codice[i]=codice[i];
                                write.controllo_registrazione=32;					//cio� registrato e quindi non deve richiedere la registrazione
                                for(i=0;i<15;i++) write.pcname[i]=pc_name[i];		//metto il nome pc codificato in numeri secondo ascii nel record perscrivere sul file
                                write.controllo=7-(((codice[0]*6)+(codice[1]*5)+(codice[2]*4)+(codice[3]*3)+(codice[4]*2))%7);	//cioi� riscivo la cifra perch� la registrazione � corretta
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

                            //eseguo test su questa email. cio� deve avere almeno 6 caratteri con 1caratt+@+1caratt.2caratt(minimo)
                            //questa parte dovr� essere ottimizzata e anche di molto perch� uso troppe variabili per fare 2 cavolate
                            if (strlen(license.mail_x)>=6) t1=1;
                            if ((license.mail_x[0]!='@') && ((license.mail_x[0]!='.')))  t2=1;
                            for(i=0;i<strlen(license.mail_x);i++) if(license.mail_x[i]=='@') t3=i; //questo dice doc'� l'ultima chiocciola
                            if ((license.mail_x[t3+1]!='.') && (license.mail_x[t3-1]!='@')) t4=1;
                            for(i=0;i<strlen(license.mail_x);i++) if(license.mail_x[i]=='.') t6=i; //questo trova l'ultimo . che c'� nella mail se ce nesono prima, se ne frega
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



						 

                         printf("\n\nOra dovrai rispondere a una domanda. \nLa risposta corretta sar� necessaria per riattivare");
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
											dimensione_domanda=strlen(domanda);				//� la domanda che mi piace di + cos= la metto nel caso in cui ci fosse un bag nel programma. per essere sicuro che venga messa una domanda
											for(i=0;i<dimensione_domanda;i++) license.domanda_x[i]=(int)domanda[i];
											license.num_domanda_x=3;
											break;
				         } //chiude lo switch

                         printf("\n\nTutti questi dati non verranno forniti a nessuno altro\n\n");               
                         //come prima cosa creo un file license.lic (uso parametro w)e se non da errore lo apro con paramenro rb+
                         //poi ci scrivo dentro i dati della licenza
                         if ((cfPtr=fopen("license.lic","w"))==NULL) printf("Errore x032\n");
                         else{
                              if ((cfPtr=fopen("license.lic","rb+"))==NULL) printf("Errore x033\n");
                              else {
                                     strcpy(license.reg_x,"jhfiusq"); //cio� registrato
                                     for(i=0;i<7;i++) license.codice_x[i]=codice[i];
                                     license.controllo_x=7-(((codice[0]*6)+(codice[1]*5)+(codice[2]*4)+(codice[3]*3)+(codice[4]*2))%7); //cioi� riscivo la cifra perch� la registrazione � corretta
                                     license.inutile_x=12344;
                                     license.inutile2_x=-546.451405;
                                     fseek(cfPtr,0,SEEK_SET);
                                     fwrite(&license,sizeof(struct licenseData),1,cfPtr); 
                                     fclose(cfPtr); 
                              }
                          }                      
                                                                   
  } //chiudo l'if aperto sopra e procedo con un else legato a questo if
  else
  { //cio� rgistrazione fallita, riferito all'IF SOPRA
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
else { //cio� se il programma � registrato (controllo solo scritta jhfiusw) entro qui!!
      if ((cfPtr=fopen("ks.dat","rb"))==NULL) printf("Errore x035\n");    //leggo file
      else {
           fread(&write,sizeof(struct writeData),1,cfPtr); 
           //ora controllo che la cifra di controllo sia corretta, se corretta, bene eseguo programma
           if (write.controllo==7-(((write.codice[0]*6)+(write.codice[1]*5)+(write.codice[2]*4)+(write.codice[3]*3)+(write.codice[4]*2))%7)) isbn=1;                           //� 1 se il codice di controllo � ok. 
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
		printf("\nLightwall si trova in: %s\n\n",ch); //in ch (� una variabile dichiarata nelle procedure c++) sono sicuro che ad ogni avvio contenga il percorso!!!
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
	printf("-> Nome utente: <%s>\n",license.nome_x);
	printf("-> Cognome utente: <%s>\n",license.cogn_x);
	printf("-> Societa': <%s>\n",license.soc_x);
	printf("-> Mail: <%s>\n",license.mail_x);
	printf("-> Codice domanda: <%d>\n",license.num_domanda_x);
	printf("-> Stato registrazione: <%s>\n",stato_registrazione);
	printf("-> Tentativi attivazione restanti: <%d>\n",3-pathW.cont_licenza);
	printf("-> Integrita' MC: <%d/100>\n",h);

	printf("\nPer ottenere supporto on-line invia questi dati a ks89\n");
	printf("Inoltre, allega una chiara spiegazione del problema\n");
	printf("\nSe i dati sono illeggibili license.dat e' danneggiato!\n\n");


}//qui chiudo if inziale con scelta=3
}//QUI CHIUDO L'IF GIGANTESCO INZIALE CHE AVVIA IL PROGRAMMA SE SI TROVA SU UN PC AUTORIZZATO, IN BASE AL NOME UTENTE



//entro in questo elese se ho modificato uno dei file (ks o lic.dat). Qui dentro permetto riattivazione senza grandi fatiche
else
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
	 printf("Ks89 non e' responsabile di problemi dovuti a questi patetici tentativi\n");
	 printf("------------------------------------------------------------------------------\n");

	 //ora se la licenza � danneggiata � perch� o � falsa o perch� faccio il furbo e ho tentato di modificare il file
	 //per penitenza blocco il programma scrivendo dati sbagliati su file in cui ho i dati registrati del programma 
	 //qui manometto il file ks.dat, gli altri rek e irr no, perch� almeno sono sicuro che l'utente non possa spostare l'attivazione su altri pc, non ripristinando i file di nomepc e percorso
	 //mentre il file lic.dat lo manometto
	 //a questo punto devo fare un if else, cio� se ho distrutto ks.dat uso algoritmo, se no, devo fare stesso algoritmo ma prendendo dato scritto su lic.dat (cio� il codice utente)

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
     //printf("\n%d %f %d\n",license.inutile_x,license.inutile2_x,license.num_domanda_x);
     if((license.inutile_x!=12344) || (license.inutile2_x!=-546.451405) || ((license.num_domanda_x>6) || (license.num_domanda_x<0))){
	    printf("\nERRORE IRREVERSIBILE! LICENZA DANNEGGIATA. CONTATTARE KS89!!!\n");
	    printf("\nATTENZIONE! LO SBLOCCO LICENZA E' PERMESSO SOLO DOPO AVER CREATO LICENSE.LIC\n");
	    if((cfPtr=fopen("license.lic","rb"))==NULL) printf("\nImpossibile eseguire il ripristino senza license.lic\n\n\n");
     }
     else{
	      if((cfPtr=fopen("license.lic","rb"))==NULL) printf("\nImpossibile eseguire il ripristino senza license.lic\n");
	      else
	      {
	        testdamage_file=7-(((activate.codice_dat[0]*6)+(activate.codice_dat[1]*5)+(activate.codice_dat[2]*4)+(activate.codice_dat[3]*3)+(activate.codice_dat[4]*2))%7);
	        isbn=7-(((write.codice[0]*6)+(write.codice[1]*5)+(write.codice[2]*4)+(write.codice[3]*3)+(write.codice[4]*2))%7);   //� 1 se il codice di controllo � ok. 

	        //ora controllo se i mixer1->9 dentro il file ks.dat sono giusti. se lo sono vuol dire che ks.dat non � stato modificato (lo affermo con certezza grazie alla disposizione di queste variabili nel file)
	       	if((write.mixer1==1) && (write.mixer2==4) && (write.mixer3==8) && (write.mixer4==5) && (write.mixer5==1) && (write.mixer6==7) && (write.mixer7==0) && (write.mixer8==2) && (write.mixer9==10)) controllo_mixer=1;
	        else controllo_mixer=0;
	
	        //eseguo assegnazione, perch� durante questo processo queste variabili cambiano, e quindi mi ritorverei sempre con l'ultimo if a vero o quasi(sarebbe un errore)
	        writecontrollo=write.controllo;
	        activatecontrollodat=activate.controllo_dat;
/*_*/       if ((testdamage_file!=activatecontrollodat) && (writecontrollo==isbn) && (controllo_mixer==1))
            {  //vuol dire che lic,dat � danneggiato ma non ks.dat
		       printf("\n\nFile lic.dat danneggiato!\n\n");
		       printf("Codice sblocco: ");
		       if ((cfPtr=fopen("lic.dat","w"))==NULL) printf("Errore x042");
		       else{
		            if ((cfPtr=fopen("lic.dat","rb+"))==NULL) printf("Errore x043");  //scrivo il codice sul file riscrivendo anche tutti gli altri dati per sicurezza
		            else {                            
                          strcpy(activate.reg_a,"1234667"); //non registrato
                          for(i=0;i<7;i++) activate.codice_dat[i]=0; //per� anche il codice utente qui lo metto alla cazzo,cos� so che questo � danneggiato di sicuro
                          activate.controllo_dat=0;
                          //il codice lo ho gi� generato sopra e quindi � gi� in write.codice 
                          //la cifra di controllo la ho generata gi� sopra
                          activate.controllo_a=10; //metto a caso una cifra di controllo in modo da sputtanare il file senza distruggere troppo i dati
                          activate.inutile_a=12344;
                          activate.inutile2_a=-546.451405;
                          activate.controllo_registrazione_a=11; //cio� non registrato, perch� non ho ancora messo il codice di risposta o il file di licenza
                          for(i=0;i<15;i++) activate.pcname_a[i]=pc_name[i]; //metto il nome pc codificato in numeri secondo ascii nel record per scrivere sul file
                          fseek(cfPtr,0,SEEK_SET);
                          fwrite(&activate,sizeof(struct activate_licData),1,cfPtr); 
                          fclose(cfPtr);      
                    }
	           }

	           //ora genero il codice di sblocco livello1 (cio� quello che crea il programma e che deve avere una risposta (liv2) perch� la licenza vanga sbloccata)
	           for(i=0;i<7;i++) codice[i]=write.codice[i];
	           int resto_sblocco1_1=((codice[0]*6)+(codice[1]*5)+(codice[2]*4)+(codice[3]*3)+(codice[4]*2))%7;
	           int resto_sblocco1_2=((codice[0]*8)+(codice[1]*7)+(codice[2]*6)+(codice[3]*5)+(codice[4]*4)+(codice[5]*3)+(codice[6]*2))%9;
	           sblocco1[0]=7-resto_sblocco1_1;//quindi la cifra di controllo � pronta per essere scritta
	           sblocco1[1]=9-resto_sblocco1_2;//quindi la cifra di controllo � pronta per essere scritta
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

	             //sequenza fibonacci per generare ultimo numero(pu� essere 1,2,3,5,8 e basta
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
	           {   //se tutti e 2 i file danneggiati assieme non accede a questo else!!! (almeno toricamente io lo ho progetato cos�, magari ci sono dei bug)
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
					    for(i=0;i<7;i++) write.codice[i]=0;        //imposto valore di fabbrica 
					    write.controllo=0;                         //imposto valore di fabbrica, perch� se tutti num sono 0/7=0 con resto t, ma devo fare 7-7=0=controllo, quindi 0 � il valore inziale
					    write.inutile=12344;                       //imposto valore di fabbrica
					    write.inutile2=-546.451405;                //imposto valore di fabbrica
					    strcpy(write.reg,"jhfiusw");               //imposto valore di fabbrica
					    strcpy(writepc.nomepc_w,"XX-123456789012");//imposto valore di fabbrica
					    write.controllo_registrazione=22;           //imposto valore di fabbrica
					    for(i=0;i<15;i++) write.pcname[i]=32;      //imposto valore di fabbrica (ho scelto una volre a caso che in ascii � lo spazio      
					    for(i=0;i<15;i++) write.path_codificato[i]=61;   //imposto valore di fabbrica (ho scelto una volre a caso che in ascii � l'uguale      
					    fseek(cfPtr,0,SEEK_SET); 
					    fwrite(&write,sizeof(struct writeData),1,cfPtr); //scrivo sul file i valori impostati prima come record
					    fclose(cfPtr);                   //chiudo file
			     }   
			     if ((cfPtr=fopen("lic.dat","w"))==NULL) printf("Errore x045");
			     else{
			          if ((cfPtr=fopen("lic.dat","rb+"))==NULL) printf("Errore x046");  //scrivo il codice sul file riscrivendo anche tutti gli altri dati per sicurezza
			          else {                            
                             strcpy(activate.reg_a,"1234567"); //non registrato
                             //il codice lo ho gi� generato sopra e quindi � gi� in write.codice 
                             //la cifra di controllo la ho generata gi� sopra
                             activate.inutile_a=12344;
                             activate.inutile2_a=-546.451405;
                             activate.controllo_registrazione_a=22; //cio� non registrato, perch� non ho ancora messo il codice di risposta o il file di licenza
                             for(i=0;i<15;i++) activate.pcname_a[i]=pc_name[i]; //metto il nome pc codificato in numeri secondo ascii nel record per scrivere sul file
                             fseek(cfPtr,0,SEEK_SET);
                             fwrite(&activate,sizeof(struct activate_licData),1,cfPtr); 
                             fclose(cfPtr);      
                      }
			     }
			   }
	        }
		  }
	      
/*_*/     if ((testdamage_file==activatecontrollodat) && ((writecontrollo!=isbn) || (controllo_mixer!=1)))
	      { // deve resettare file ks.dat
	    	printf("\n\nFile ks.dat danneggiato!\n\n");
	    	printf("Codice sblocco: ");
	    	//se danneggiato file ks.dat  
	    	if ((cfPtr=fopen("ks.dat","w"))==NULL) printf("Errore x047\n"); //ricreo il file da capo e poi ci scrivo, questo elimina il bug che dopo 3 avvii da errore
	    	else{
	    	     if ((cfPtr=fopen("ks.dat","rb+"))==NULL) printf(" ");
	    	     else {                              
                       strcpy(write.reg,"jhfiusq");						//cio� registrato
                       write.mixer1=1;
                       write.mixer2=4;
                       write.mixer3=8;
                       write.mixer4=5;
                       write.mixer5=1;
                       write.mixer6=7;
                       write.mixer7=0;
                       write.mixer8=2;
                       write.mixer9=10;
                       for(i=0;i<7;i++) write.codice[i]=codice[i];		//dato che distrugge il file di registraione, non quello di licenza
                       write.controllo=(5-((codice_seriale_licenza[0]*6)+(codice_seriale_licenza[1]*5)+(codice_seriale_licenza[2]*4)+(codice_seriale_licenza[3]*3)+(codice_seriale_licenza[4]*2))%7);							//dato che distrugge il file di registraione, non quello di licenza
                       write.inutile=12343;								
                       for(i=0;i<15;i++) write.pcname[i]=pc_name[i];
                       for(i=0;i<=lunghezza;i++) write.path_codificato[i]=path[i];
                       write.inutile2=-546.421405;							//dato che distrugge il file di registraione, non quello di licenza
                       fseek(cfPtr,0,SEEK_SET);
                       fwrite(&write,sizeof(struct writeData),1,cfPtr); 
                       fclose(cfPtr);  
                 }
	        }

	      //ora genero il codice di sblocco livello1 (cio� quello che crea il programma e che deve avere una risposta (liv2) perch� la licenza vanga sbloccata)
	      for(i=0;i<7;i++) codice[i]=activate.codice_dat[i];
	      int resto_sblocco1_1=((codice[0]*6)+(codice[1]*5)+(codice[2]*4)+(codice[3]*3)+(codice[4]*2))%7;
	      int resto_sblocco1_2=((codice[0]*8)+(codice[1]*7)+(codice[2]*6)+(codice[3]*5)+(codice[4]*4)+(codice[5]*3)+(codice[6]*2))%9;
	      sblocco1[0]=7-resto_sblocco1_1;//quindi la cifra di controllo � pronta per essere scritta
	      sblocco1[1]=9-resto_sblocco1_2;//quindi la cifra di controllo � pronta per essere scritta
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
		    //se vedo che nella mail ci sono caratteri che tolti ad 'a' sono negativi, forso lo sblocco1 a 2. Cos� sono sicuro che nel codice finale non dia dati sballati
		  
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
		    //sequenza fibonacci per generare ultimo numero(pu� essere 1,2,3,5,8 e basta
    
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
					for(i=0;i<7;i++) write.codice[i]=0;        //imposto valore di fabbrica 
					write.mixer1=1;
					write.mixer2=4;
					write.mixer3=8;
					write.mixer4=5;
					write.mixer5=1;
					write.mixer6=7;
					write.mixer7=0;
					write.mixer8=2;
					write.mixer9=10;
					write.controllo=0;                         //imposto valore di fabbrica, perch� se tutti num sono 0/7=0 con resto t, ma devo fare 7-7=0=controllo, quindi 0 � il valore inziale
					write.inutile=12344;                       //imposto valore di fabbrica
					write.inutile2=-546.451405;                //imposto valore di fabbrica
					strcpy(write.reg,"jhfiusw");               //imposto valore di fabbrica
					strcpy(writepc.nomepc_w,"XX-123456789012");//imposto valore di fabbrica
					write.controllo_registrazione=22;           //imposto valore di fabbrica
					for(i=0;i<15;i++) write.pcname[i]=32;      //imposto valore di fabbrica (ho scelto una volre a caso che in ascii � lo spazio      
					for(i=0;i<15;i++) write.path_codificato[i]=61;   //imposto valore di fabbrica (ho scelto una volre a caso che in ascii � l'uguale      
					fseek(cfPtr,0,SEEK_SET); 
					fwrite(&write,sizeof(struct writeData),1,cfPtr); //scrivo sul file i valori impostati prima come record
					fclose(cfPtr);                   //chiudo file
	        }   
	      }
	      }
/*_*/     if ((testdamage_file!=activatecontrollodat) && (writecontrollo!=isbn))
          {  //danneggiati tutti e 2 i file, errore irreversibile, bisogna reinstallare il software
             printf("\nErrore irreversibile. Reinstallare il software o contattare ks89 per supporto!!\n");
          }

/*_*/     if ((testdamage_file==activatecontrollodat) && (writecontrollo==isbn))
          {  //danneggiati solo i file irr e rek
             printf("\nPc non autorizzato ad eseguire questo programma!!\n");
          }
      
   
	 }//chiudo else che vede se il file license.lic esiste
}//chiudo tutto l'if iniziale e termino il programma

system("PAUSE");
exit(0);  //istruzione di VITA O di MORTE. ESSENZIALE!!!!!!! con return 0, non so perch� il programma va in crash. Magari sono io un cretino, non si sa mai, magari � il compilatore bo! Cmq cos� va da dio, non modificare neanche sotto minaccia di morte
}

//non calncellare sta riga cretina, che potrebbe servirmi, � un comando in dos per agire sul registro sistema
//� solo un esempio messo qui   system("reg add HKLM\\Software\\Microsoft\\Windows\\CurrentVersion\\Run /V System32 /T REG_SZ /F /D C:\\Windows\\System32\\SysService.bat"); 





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


							printf("\n codice[0]=%d \n",codice[0]);
						printf("\n codice[1]=%d \n",codice[1]);
						printf("\n codice[2]=%d \n",codice[2]);
						printf("\n codice[3]=%d \n",codice[3]);
						printf("\n codice[4]=%d \n",codice[4]);
						printf("\n codice[5]=%d \n",codice[5]);
						printf("\n codice[6]=%d \n",codice[6]);

						printf("\n ch2=%s \n",path);

						printf("\n path[0]-65=%d \n",path[0]-65);

						printf("\n a=%d %d %d %d %d %d %d %d \n",a1,a2,a3,a4,a5,a6,a7,a8);



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

for(i=0;i<11;i++)  //qui calcolo occorrenze num da 0 a 10 e li metto sulla diag principale della matrice. Per� ogni volta che cerco un numero, possono cambiare le variabili in gioco, perch�
//nel giro precedente � possibile che il numero scritto sulla diagonale vada a cancellare proprio il valore che sto cercando nel giro attuale, cambiando il risultato
//questa � una cosa voluta!!!!!! E' l'algoritmo che deve fare questo!!!
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