//SOURCECODE BY KS89 (CAPPA STEFANO)
//BETA 1.0.1 SOURCECODE
#include <stdlib.h>
#include <time.h>
#include <openssl/sha.h>//essenziali per usare md5 e sha. Sono librerie di openssl da copiare nella cartella delle librerie di visual studio. Crecare stdio.h e nella cartella in cui si trova copiare dentro i 2 file
#include <openssl/md5.h>
#include <string.h>
#include <stdio.h>

//Permette di vedere o modificare la data di scadenza della licenza acquistando il codice di attivazione.
//Questo programma è fornito nel setup insieme a LIGHTWALL


//NOVITA'
//-Aggiunto blocco nel caso in ciu tentassi di fare upgrade con licenza scaduta
//-Miglioramenti vari di compatibilità
//-IL PROGRAMMA CAMBIA NOME IN LICENSE MANAGER e non più license managment
//-Sostituiti tutti i rand() % 9 con rand()%10, perchè il primo da solo da 0 a 8, mentre quello dopo da anche il 9


//PS: non attivare l'integrità MC sulla licenza! Per motivi di sicurezza è emglio che l'utente, una volta registrato il programma (che quindi può ancora ccedere a LicenseManager) non sia a conoscenza di info così delicate
      //in realtà sarebbe meglio disattivare anche altre cose x sicurezza. Appena registrato, il porgramma legge i dati e ne nascondi alcuni. MA per ora va bene cosìì, al max in futuro

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
	   unsigned char md5[16]; //md5 e sha1 composti da percorso + nome pc  + codice + controllo + codice controlloic
	   unsigned char sha1[20];
	   int matrice[10][10];

};      

struct licenseData{     //record per scrivere file di licenza come backup. Questo ha l'aggiunta di informazioni personali, come la mail e nome e cognome e società a cui è intestata
       char version[5];//NON CAMBIARE ASSOLUTAMENTE QUESTO DATO. DOVRA' ESSERE SEMPRE DI 5, SI DEVE CHIAMARE VERSION, DEVE ESSERE CHAR E DEVE ESSERE SEMPRE IL PRIMO ELEMENTO DELLA STRUCT, perchè serve per far riconoscere a versioni future la versione della licenza e permetterne l'accettazione e conversione 
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
	   unsigned char md5_x[16];
	   unsigned char sha1_x[20];
	   int codice_up[7];

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
	   /*int codice_up[7];*/

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
//ks.dat = ha la registrazione corrente per far andare il programma, gli md5 e sha1
//license.lic ha la registrazione per far andare il prog in altro pc. Però questo file cmq genera un file ks.dat con dentro il tutto per andare, gli md5 e sha1(dati dalla funzione2, quella + complicata)
//lic.dat contiene numero licenza, e quindi serve per l'attivazione della licenza stessa e viene creato da zero dal programma, gli md5 e sha1
//irr.dat ha dentro il percorso, gli md5 e sha1
//rek.dll ha dentro il nome dell'utente, gli md5 e sha1
//i file che hanno dentro la matrice sono: irr,rek e ks

int main(){
//*****************************************************inizio dichiarazione varibili***************************************************************
   FILE *cfPtr;    //puntatore al file, essenziale per funzionare
   
   //variabili per il codice utente e risposta, nel caso in cui scelga la registrazione da codice e non da licenza
   int scelta; //risposta ha il codice di risposta in caratteri usato per elaborare, che è diverso da risp_s, cioè la stringa

   //variabili per la licenza
   char lic_s[12]; 
   int lic_risposta_perverifica[12];
   int codice_seriale_licenza[7];
   
   //variabili temporanee usare per cicli oppure per mantenere dati che poi vengono assegnati ad altro, come isbn. first_exec è quella che contiene se il programma è stato eseguito la prima volta, oppure + volte
   int i=0,j=0;
   int isbn;  //variabile usata per il codice di controllo come fatto da ISBN  
  
	//variabili per orologio e licenza HOME/Professional
	int gio, mese, anno, gios, ora, min, sec;  //NB l'opzione CLR su queste procedure dell'orologio può anche essere disattivata, ma non per percorso e nomepc. almeno per ora
	int tipol=0;//indica il tipo di licenza, cioè indica il numero di anni di validità. Se il valore è 99, vuol dire illimitata
	int testora=0;//indica se licenza scaduta o no
//*******************************************************fine dichiarazione varibili***************************************************************

//inizializzazzione delle strutture a 0 e "" per sicurezza e contemporaneamente le rinomino da writeData a write ecc... come se facessi un typedef(sinonimo)
struct writeData write={0,{0,0,0,0,0,0,0,0,0,0,0},0,0,0,"",0,0,0,0.0,{0},"",{0},0,{0},0,0,0,0};  //imposto valori standard nella struttura
struct licenseData license={"",{0,0,0,0,0,0,0,0,0,0,0},0,"","","","","",0,0.0,0,{0},0,0,0,0,0,0,0,0,0,0,0,0,0,{0},{0}}; 
struct activate_licData activate;     //qui non inzializzo ma dichiaro solo il nome activate!. Volendo potrei anche inziializzare
struct pathWData pathW={"",{0},0};    //record che uso per il percorso dell'eseguibile

//leggo tutti e 3 i file di cui ho bisogno
if ((cfPtr=fopen("license.lic","rb"))==NULL){
		printf("File di licenza non trovato. Errore lm001\n\n");
}
else{
		 fread(&license,sizeof(struct licenseData),1,cfPtr);
		 fclose(cfPtr);
}
if ((cfPtr=fopen("lic.dat","rb"))==NULL){
		printf("File lic non trovato. Errore lm002\n\n");
}
else{
		 fread(&activate,sizeof(struct activate_licData),1,cfPtr);
		 fclose(cfPtr);
}

if ((cfPtr=fopen("ks.dat","rb"))==NULL){
		printf("File ks non trovato. Errore lm003\n\n");
}
else{
		fread(&write,sizeof(struct writeData),1,cfPtr);
		fclose(cfPtr);
}

now(gio,mese,anno,gios,ora,min,sec); //leggo data
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
//se testora=0 licenza scaduta, se no ancora valida. Lo faccio perchè l'upgrade (scelta2) è permesso solo per licenze ancora valide e non scadute



printf("            **********************************************************\n");
printf("            *..::Benvenuto in LICENSE MANAGER BETA 1.0.1 by ks89!::..*\n");
printf("            **********************************************************\n\n");
printf("Scegliere l'opzione desiderata\n");
printf("Inserisci '1' se vuoi vedere la licenza\n");
printf("Inserisci '2' se vuoi l'UPGRADE della licenza\n");
printf("\n\nQueste opzioni non sono disponibili in LIGHTWALL.exe dopo la registrazione\n");
printf("\nAttenzione. Se la licenza e' scaduta non e' consentito l'UPGRADE\n");
scanf("%d",&scelta);


//*******************************************************************************
//*******************************************************************************
//****************************SE VOGLIO VEDERE LICENZA***************************
//*******************************************************************************
//*******************************************************************************
if (scelta==1)
{
	if ((cfPtr=fopen("license.lic","rb"))==NULL){
		printf("File di licenza non trovato. Errore lm004\n\n");
	}
    else{
		 fread(&license,sizeof(struct licenseData),1,cfPtr);
		 fclose(cfPtr);
		 fread(&pathW,sizeof(struct pathWData),1,cfPtr);
		 fclose(cfPtr);
	}
	//ora stampo i dati
	char stato_registrazione[25];
	if(strcmp(write.reg,"jhfiusw")==0) strcpy(stato_registrazione,"Non registrato");
	if(strcmp(write.reg,"jhfiusq")==0) strcpy(stato_registrazione,"Registrato");
	if((strcmp(write.reg,"jhfiusw")!=0) && (strcmp(write.reg,"jhfiusq")!=0)) strcpy(stato_registrazione,"Sconosciuto (Errore)");

	printf("\n..::Dati licenza::..\n\n");
	printf("-> Versione licenza: <%s>\n",license.version);
	printf("-> Tipo licenza: <");
	if(license.tipolic==99){
							printf("PROFESSIONAL>\n");
							printf("-> Durata in anni: <Illimitati>\n");
						   }
	else {
			printf("HOME>\n");
			printf("-> Durata in anni: <%d>\n",license.anno_s-license.anno_r);
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
	printf("-> Integrita' MC: <NON DIPONIBILE>\n");

	printf("\nIntegrita' MC non diponibile in LM per motivi di sicurezza\n");
	printf("\nPer ottenere supporto on-line invia questi dati e il file license.lic a ks89\n");
	printf("Inoltre, allega una chiara spiegazione del problema\n");
	printf("\nSe i dati sono illeggibili license.lic e' danneggiato!\n\n");


}//FINE SCELTA 1   qui chiudo if inziale con scelta=3



//*******************************************************************************
//*******************************************************************************
//*****************************SE VOGLIO FARE UPGRADE****************************
//*******************************************************************************
//*******************************************************************************
if (scelta==2)
{
 if(testora==1)//cioè entro qui solo se licenza ancora valida, se non valida, l'upgrade non è permesso, ma solo il rinnovo da LightWall, che ovviamente costa di +, perchè non ci hai pensato prima a fare l'upgrade e pagare meno
 {
	if(license.tipolic==99) printf("\nLa licenza in uso e' PROFESSIONAL e non vi sono UPGRADE possibili\n");
	else
	{//se è permesso fare l'upgrade entro qui, cioè solo se la licenza è home
		//leggo il seriale della licenza
		codice_seriale_licenza[0]=activate.codice_a0;
		codice_seriale_licenza[1]=activate.codice_a1;
		codice_seriale_licenza[2]=activate.codice_a2;
		codice_seriale_licenza[3]=activate.codice_a3;
		codice_seriale_licenza[4]=activate.codice_a4;
		codice_seriale_licenza[5]=activate.codice_a5;
		codice_seriale_licenza[6]=activate.codice_a6;
		printf("\n");
		if((activate.codice_a5==write.codice[5]) && (activate.codice_a6==write.codice[6]) && (activate.codice_a1==8-(((activate.codice_a0*7)+(activate.codice_a2*6)+(activate.codice_a3*5)+(activate.codice_a4*4)+(activate.codice_a5*3)+(activate.codice_a6*2))%8))
			&& (activate.controllo_a==7-(((activate.codice_a0*6)+(activate.codice_a1*5)+(activate.codice_a2*4)+(activate.codice_a3*3)+(activate.codice_a4*2))%7))) isbn=1;     //questa è la versione di windows
		else isbn=0;
		if(isbn!=1) printf("\nErrore lm005! Licenza non valida\n");
		else
		{//se entro qui vuol dire che la licenza ha un codice corretto e posso stampare il codice seriale della licenza
			//stampo a schermo il seriale della licenza
			printf("\Codice seriale licenza: ");
			for(i=0;i<7;i++) printf("%d ",codice_seriale_licenza[i]);

			int upgrade=0;
			printf("\nChe UPGRADE vuoi fare?\nInserisci un numero da 1 a 3 per aumentare il numero di anni di validita'\nInserisci 0 per l'UPGRADE alla versione PRO\n\n");
			scanf("%d",&upgrade);

			lic_risposta_perverifica[0]=(codice_seriale_licenza[3]+12)%9;
			lic_risposta_perverifica[1]=rand()%10;
			lic_risposta_perverifica[2]=(codice_seriale_licenza[1]+6)%9;
			lic_risposta_perverifica[3]=(codice_seriale_licenza[4]+codice_seriale_licenza[5])%8;
			lic_risposta_perverifica[4]=(codice_seriale_licenza[2]+12)%6+upgrade;
			lic_risposta_perverifica[5]=rand()%10;
			lic_risposta_perverifica[6]=codice_seriale_licenza[6]%3+upgrade;
			lic_risposta_perverifica[7]=(codice_seriale_licenza[0]+5)%9;
			lic_risposta_perverifica[8]=(((9*codice_seriale_licenza[5])%(codice_seriale_licenza[2]+1))+codice_seriale_licenza[0])%9;
			lic_risposta_perverifica[9]=(codice_seriale_licenza[3]+codice_seriale_licenza[0]+codice_seriale_licenza[6])%9;
			lic_risposta_perverifica[10]=(write.controllo+upgrade)%9;
			lic_risposta_perverifica[11]=(codice_seriale_licenza[4]+lic_risposta_perverifica[1]+lic_risposta_perverifica[5]+activate.controllo_a)%9;

			printf("\nCodice di UPGRADE generato: ");//questo non ci dovrà essere nella versione definitiva
			for(i=0;i<12;i++) printf("%d ",lic_risposta_perverifica[i]);

			printf("\n\n\nInserisci il codice di UPGRADE\n");
			scanf("%s",lic_s);
			for(i=0;i<12;i++) lic_s[i]=(int)lic_s[i]-48;   // con questo trasformo i caratteri(che poi sono numeri) inseriti nella stringa in interi, sottraendo 48, cioè il valore dello 0 in ASCII

			if ((lic_risposta_perverifica[1]==lic_s[1]) && (lic_risposta_perverifica[2]==lic_s[2]) && (lic_risposta_perverifica[3]==lic_s[3])
							&& (lic_risposta_perverifica[4]==lic_s[4]) && (lic_risposta_perverifica[6]==lic_s[6]) && (lic_risposta_perverifica[7]==lic_s[7]) 
							&& (lic_risposta_perverifica[8]==lic_s[8]) && (lic_risposta_perverifica[9]==lic_s[9]) && (lic_risposta_perverifica[11]==lic_s[11])
							&& (lic_risposta_perverifica[0]==lic_s[0]) && (lic_risposta_perverifica[10]==lic_s[10]) && (isbn=1)) j=1; //se tutti veri significa che la risposta è corretta
			else j=0;
   					
			if(j!=1) printf("\nErrore lm006! Codice di UPGRADE licenza errato.\n\n");
			else
			{
				printf("\nCodice di UPGRADE licenza corretto!\n");
				//ora devo ricavare la cifra upgrade dal codice lic_s, cioè quello che ho inserito
				upgrade=lic_risposta_perverifica[4]-(codice_seriale_licenza[2]+12)%6;
				if((upgrade==lic_risposta_perverifica[6]-codice_seriale_licenza[6]%3) && (lic_risposta_perverifica[10]==(write.controllo+upgrade)%9)) upgrade=lic_risposta_perverifica[4]-(codice_seriale_licenza[2]+12)%6;
				else upgrade=8; //valore casuale che mi assicura che non avvenga l'upgrade

				if(upgrade==8) printf("\nErrore lm007! UPGRADE non permesso\n");
				else
				{	//questo fa si che se voglio fare upgrade, la licenza scadrà l'anno in cui ho registrato la licenza la prima volta +1(2 o 3)
					//quindi una lienz home avrà durata massima 3 anni. Anche facendo l'upgrade la durata sarà sovrascritta, ma sempre 3 anni. QUINDI deve essere rinnovata perchè scaduta
					//Se ho una lic di un anno e sta per scadere, posso passare sia alla 2 o 3 anni, ma se ho la 2 anni e passo alla 1 anno c'è il rischio di far bloccare il programm aper licenza scaduta se non tengo d'occhio le date
					//questo sistema è ancora primitivo, creato per beta 17.3.0 in futuro vorrei fare questo:
					//L'upgrade è permesso solo su licenza attive. Costa meno del rinnovo, per questo conviene sempre fare l'upgrade e non il rinnovo
					//Con l'upgrade si reimposta la data di registrazione della licenza e di conseguenza con la durata scelta anche quella di scadenza
					//Questo risulterebbe come un vero e proprio rinnovo di licenza, ma essendo stato fatto durante il periodo di vlidità ha un costo minore e quindi più conveniente
					if(upgrade==0) {
									license.tipolic=99; 
									license.anno_s=license.anno_r+99;
								   }
					if(upgrade==1) license.anno_s=license.anno_r+1;
					if(upgrade==2) license.anno_s=license.anno_r+2;
					if(upgrade==3) license.anno_s=license.anno_r+3;

					strcpy(activate.version,license.version);
					activate.tipolic=license.tipolic;
					activate.anno_s=license.anno_s; //imposto scadenza. Se 99 vuol dire che è illiminata, se 1,2,3 indica il numero di anni di validità

                 if ((cfPtr=fopen("license.lic","rb+"))==NULL) printf("Errore lm008\n");
                 else {
                          fseek(cfPtr,0,SEEK_SET);
                          fwrite(&license,sizeof(struct licenseData),1,cfPtr); 
                          fclose(cfPtr); 
                      }
				 if ((cfPtr=fopen("lic.dat","rb+"))==NULL) printf("Errore z009\n");
                 else {
                          fseek(cfPtr,0,SEEK_SET);
						  fwrite(&activate,sizeof(struct activate_licData),1,cfPtr); 
                          fclose(cfPtr); 
                      }
				}
			}
		}
	}
 }
 else printf("\nL'UPGRADE non e' permesso con la licenza scaduta\n");
}//FINE SCELTA 2   qui chiudo if inziale con scelta=4
printf("\n");
system("PAUSE");
exit(0);  //istruzione di VITA O di MORTE. ESSENZIALE!!!!!!! con return 0, non so perchè il programma va in crash. Magari sono io un cretino, non si sa mai, magari è il compilatore bo! Cmq così va da dio, non modificare neanche sotto minaccia di morte
}