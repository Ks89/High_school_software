#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <string.h>

//.....:::::::Source by KS89 :::::::.....    

//versione beta, working progress!!!!

struct Elemento{
       int posizione;
       char dato[15]; //uso 15 elem per far si che si possano mettere numeri cosi' 0324-83456 oppure  3404567890. I fissi con -. I cellulari NO
       char cognome[35]; //uso vettori lunghi per stare sicuro che ci stiano tutti i nomi e cognomi
       char nome[35];
       struct Elemento *successivo;
}; //mettere i ; importante!!!

struct saveData{
		int posiziones; //fa oltre che da ordinatore nella lista anche da acctNum per scrivere nei file ad access sequenziale
		char datos[15];
		char cognomes[35];
		char nomes[35];
}; 

typedef struct Elemento Elemento;
typedef Elemento *PuntElem;


void insert(PuntElem*sPtr,char value[],char utente[],char nome_persona[]);  //fa inserimento degli elementi 
PuntElem delet(PuntElem*sPtr,char *value,char *utente);   
int isEmpty(PuntElem sPtr);   
void printList(PuntElem currentPtr);   
void instructions(void);      
void trova_elemento(PuntElem*sPtr,char cogn_cercare[],char nome_cercare[]);
void numerazione(PuntElem sPtr); //numera gli elementi dall'1 a n
char upcase(char stringhetta); //fa diventare lettere minuscola all'inizio di ogni parola maiuscole
PuntElem find_element(PuntElem*sPtr,char cercare[]); //per la ricerca di un numero telefonico
void elimina_elemento(PuntElem*sPtr,int eliminaz_elemento); //elimina un elemento, cioè se metto 5 mi elimina il numero e nome che si trova in posizione 5, si collega nel modo giusto la lista, dopo avviene il riordinamento dei numeri degli elementi e stampa tutto
PuntElem modifica_elemento(PuntElem *sPtr,int num_elem,char value[],char utente[],char nome_persona[]);

int main()
{
		FILE *cfPtr;
	struct saveData save = {0,"","",""};


    PuntElem startPtr=NULL;
    PuntElem eliminato=NULL;
    PuntElem elem_trovato=NULL; 
	PuntElem elem_modificato=NULL;
    PuntElem currentPtr=NULL;

    int num=0,eliminaz_num=0;
    int choice,number_element=0;
    char item[15],cercare[15];
	char cogn_cercare[35],nome_cercare[35]; 
    char stringa[35],stringa2[35]; //uno il nome e l'altro il cognome
    int numeri=1;
    int indice;
	int i,cont;
    
    //creo il file rubrica, se c'è già lo svuota
	if ((cfPtr=fopen("rubrica.dat","w"))==NULL) printf("Errore file inaccessibile o inesistente\n");
	else {
			fclose(cfPtr);
	}

    instructions();
    printf(">> ");
    scanf("%d",&choice);
    while(choice!=9){
      switch(choice){
            case 1:
                 printf("Inserisci un numero telefonico (tutto su una riga): ");
                 getchar();
                 gets(item);
                 printf("\nInserisci un cognome: ");
                 gets(stringa);
                 //semplicissimo metodo per far si che la lettera iniziale di ogni nome sia maiuscola. Richiama la funzione upcase che controlla anche che la lettera da upcaseare sia minuscola
                 indice=0;
                 stringa[0]=upcase(stringa[0]);
                 while(stringa[indice]!='\0'){
                      if ((stringa[indice]==32) && (stringa[indice+1]!='\0')) stringa[indice+1]=upcase(stringa[indice+1]);
                      indice++;
                 }
                 
                 printf("\nInserisci un nome: ");
                 gets(stringa2);
                 //uguale sopra, fa l'upcase
                 indice=0;
                 stringa2[0]=upcase(stringa2[0]);
                 while(stringa2[indice]!='\0'){
                      if ((stringa2[indice]==32) && (stringa2[indice+1]!='\0')) stringa2[indice+1]=upcase(stringa2[indice+1]);
                      indice++;
                 }
                 
                 insert(&startPtr,item,stringa,stringa2);
                 numerazione(startPtr);
                 printList(startPtr);
                 break;
			case 2:
			     printf("Inserisci il numero elemento da modificare: ");
                 scanf("%d",&number_element);
				 printf("\nInserisci il nuovo numero telefonico: ");
                 getchar();
                 gets(item);
				 printf("\nInserisci il nuovo cognome: ");
			     gets(stringa);
                 indice=0;
                 stringa[0]=upcase(stringa[0]);
                 while(stringa[indice]!='\0'){
                      if ((stringa[indice]==32) && (stringa[indice+1]!='\0')) stringa[indice+1]=upcase(stringa[indice+1]);
                      indice++;
                 }
                 
                 printf("\nInserisci il nuovo nome: ");
                 gets(stringa2);
                 //uguale sopra, fa l'upcase
                 indice=0;
                 stringa2[0]=upcase(stringa2[0]);
                 while(stringa2[indice]!='\0'){
                      if ((stringa2[indice]==32) && (stringa2[indice+1]!='\0')) stringa2[indice+1]=upcase(stringa2[indice+1]);
                      indice++;
                 }

			     elem_modificato=modifica_elemento(&startPtr,number_element,item,stringa,stringa2);

                 numerazione(startPtr);
                 printList(startPtr);
                 break;
            case 3:
                 if(!isEmpty(startPtr)){
                           printf("Inserisci numero da cancellare: ");
                           getchar();
                           gets(item);
                           eliminato = delet(&startPtr,item,stringa);
                 	      if (eliminato != NULL)
	                          {
		                      printf("\nEliminato il numero %s\n\n", eliminato->dato);
                        	}
                             numerazione(startPtr);
                             printList(startPtr);
                  }
                  else printf("La lista e' vuota.\n\n");
                  break;
             case 4:
                  printf("Inserisci il numero dell'elemento da eliminare: ");
                  scanf("%d",&eliminaz_num);
                  elimina_elemento(&startPtr,eliminaz_num);
                  numerazione(startPtr);
                  printList(startPtr);
                  break;
             case 5:
                  printf("Inserisci il numero di telefono da cercare: ");
                  scanf("%s",cercare);
                  elem_trovato=find_element(&startPtr,cercare);       
				  if (elem_trovato==NULL)("\nNumero %s non trovato.\n",cercare);
				  else printf("\n\n>> Trovato= %d : %s %s -> %s\n",elem_trovato->posizione,elem_trovato->cognome,elem_trovato->nome,elem_trovato->dato);
                  numerazione(startPtr);
                  printList(startPtr);
                  break;         
			 case 6:
				  printf("Benvenuto nella ricerca in base al nome e/o al cognome\n");
				  printf("Se non vuoi cercare con uno dei parametri inserisci +\n\n");
		 	 	  printf("Inserisci il cognome: ");
				  scanf("%s",cogn_cercare);
				  indice=0;
                  cogn_cercare[0]=upcase(cogn_cercare[0]);
                  while(cogn_cercare[indice]!='\0'){
                      if ((cogn_cercare[indice]==32) && (cogn_cercare[indice+1]!='\0')) cogn_cercare[indice+1]=upcase(cogn_cercare[indice+1]);
                      indice++;
                  }

				  printf("Inserisci il nome: ");
				  scanf("%s",nome_cercare);
				  indice=0;
                  nome_cercare[0]=upcase(nome_cercare[0]);
                  while(nome_cercare[indice]!='\0'){
                      if ((nome_cercare[indice]==32) && (nome_cercare[indice+1]!='\0')) nome_cercare[indice+1]=upcase(nome_cercare[indice+1]);
                      indice++;
                  }

				  trova_elemento(&startPtr,cogn_cercare,nome_cercare);
				  break;
			 case 7:
					currentPtr=startPtr;
					i=0;
					cont=1;
					while((currentPtr!=NULL) && (cont<=4))
					{
						printf("\n%d %s\n",currentPtr->posizione,currentPtr->successivo);
					 save.posiziones = currentPtr->posizione; 
					 for(i=0;i<15;i++) save.datos[i]=currentPtr->dato[i]; 
					 for(i=0;i<35;i++) save.cognomes[i]=currentPtr->cognome[i]; 
					 for(i=0;i<35;i++) save.nomes[i]=currentPtr->nome[i];

					printf("\n%d _ %s _ %s _ %s\n",save.posiziones,save.datos,save.cognomes,save.nomes);

					 if ((cfPtr=fopen("rubrica.dat","rb+"))==NULL) printf("Errore file inaccessibile o inesistente\n");
					else {
						if(currentPtr->successivo!=NULL){
						 fseek(cfPtr,(save.posiziones - 1)*sizeof(struct saveData),SEEK_SET);
						 fwrite(&save,sizeof(struct saveData),1,cfPtr); 
						 fclose(cfPtr); 
						}
						cont++;
					     }
					currentPtr=currentPtr->successivo; //scansiono tutta la lista fino alla fine
					}
				  break;
			 case 8:
				  if ((cfPtr=fopen("rubrica.dat","rb"))==NULL) printf("Errore x002\n");     
				  else {
					  //questo blocco calcola la lunghezza della lista vedendo cosa c'è nell'ultimo elemento nel campo "posizione"
					  i=1;
					  cont=0;
					  currentPtr=startPtr;
					  while(currentPtr!=NULL && cont!=i) {
												currentPtr=currentPtr->successivo;
												i++;
												if (currentPtr->successivo==NULL) cont=currentPtr->posizione;
					                          }
					 cont=0;

						while(cont<i){
							fread(&save,sizeof(struct saveData),1,cfPtr);
							printf("\n%d _ %s _ %s _ %s\n",save.posiziones,save.datos,save.cognomes,save.nomes);
							cont++;
						}
						fclose(cfPtr);

					  }

				  break;
             default:
                  printf("Scelta non valida.\n\n");
                  instructions();
                  break;
       }//chiudo lo switch
       printf(">> ");
       scanf("%d",&choice);
       }//chiude il while
       
       printf("Fine dell'esecuzione.\n");
       return 0;
}         


void instructions(void)
{
     printf("Inserisci la tua scelta:\n"
            "    1 per inserire un elemento nella lista.\n"
			"    2 per modificare un elemento della lista.\n"
            "    3 per eliminare un numero dalla lista.\n"
            "    4 per eliminare un elemento(numero) della lista.\n"
            "    5 per trovare un nome da un numero telefonico.\n"
			"    6 per trovare un numero da cognome e nome.\n"
			"    7 per salvare la rubrica su un file.\n"
			"    8 per leggere la ribrica dal file.\n"
            "    9 per terminare il programma.\n");
}







//funzione fatta tutta da me che modifica un elemento della lista specificandone il numero elemento (cioè il numero da 1 a n che identifica l'elemento ordinato nella rubrica)
PuntElem modifica_elemento(PuntElem *sPtr,int num_elem,char value[],char utente[],char nome_persona[])
{
   PuntElem currentPtr;
   PuntElem precedentePtr=*sPtr;
   if (isEmpty(*sPtr)) printf("\n");
   else{
   
        if (num_elem==1){
                         strcpy((*sPtr)->dato,value);
					     strcpy((*sPtr)->cognome,utente);
						 strcpy((*sPtr)->nome,nome_persona);
						 currentPtr=*sPtr;
						 return currentPtr;
                         }
                             
        else {
             currentPtr=(*sPtr)->successivo;
		     if ((*sPtr)->successivo==NULL) printf("\nErrore elemento inesistente\n");
		     else{
				  while((currentPtr!=NULL) && (num_elem!=currentPtr->posizione) && (currentPtr->successivo!=NULL))  
				  {
				    currentPtr=currentPtr->successivo;
			        precedentePtr=precedentePtr->successivo;
                  }
		          if (currentPtr->posizione==num_elem) {
														strcpy(currentPtr->dato,value);
														strcpy(currentPtr->cognome,utente);
														strcpy(currentPtr->nome,nome_persona);
														return currentPtr;
														  } 
		          else  printf("\nErrore elemento inesistente\n");
		         }
		      }
        }//chiude l'else iniziale
}


//fatta tutta da me, trova un elemento partendo dal nome e/o dal cognome
void trova_elemento(PuntElem*sPtr,char cogn_cercare[],char nome_cercare[])
{
      PuntElem currentPtr=*sPtr;
      int test;
      //questo sistema geniale(modestamente :) ) fa 2 cose

	  //prima cerca il cognome e il nome abbinati (cioè tutte le persone che hanno sia lo stesso nome che cognome)
	  if (strcmp(nome_cercare,"+")!=0 && strcmp(cogn_cercare,"+")!=0) //se voglio cercare sia nome che cognome non devo aver messo i +
	  { 
	     while (currentPtr!=NULL)
		 {
		    while (currentPtr!=NULL && (strcmp(currentPtr->cognome,cogn_cercare)!=0  || strcmp(currentPtr->nome,nome_cercare)!=0)) currentPtr=currentPtr->successivo;
		    if (currentPtr==NULL)("\nNon trovato.\n");//se no stampo
	        else printf("\n\n>> Trovato= %d : %s %s -> %s\n",currentPtr->posizione,currentPtr->cognome,currentPtr->nome,currentPtr->dato);
	        if(currentPtr!=NULL) currentPtr=currentPtr->successivo; //scorro ancora e ripeto tutto. Chiudei il while grosso appena si arriva alla fine della lista
		 }
	  }	

	  else//se no, voglio cercare o solo il nome o solo il cognome
	  { 
	     while(currentPtr!=NULL)
		 {
	        //scelgo che se inserisci + in un dei parametri avviene la ricerca solo in basi a quelli senza +.
	        //cosi' posso fare la ricerca solo sapendo il cognome oppure solo il nome
	        if (strcmp(cogn_cercare,"+")==0) while (currentPtr!=NULL && strcmp(currentPtr->nome,nome_cercare)!=0) currentPtr=currentPtr->successivo;
	        if (strcmp(nome_cercare,"+")==0) while (currentPtr!=NULL && strcmp(currentPtr->cognome,cogn_cercare)!=0) currentPtr=currentPtr->successivo;
	        if (currentPtr==NULL)("\nNon trovato.\n");
	        else printf("\n\n>> Trovato= %d : %s %s -> %s\n",currentPtr->posizione,currentPtr->cognome,currentPtr->nome,currentPtr->dato);
	        if(currentPtr!=NULL) currentPtr=currentPtr->successivo;
	     }
	  }	           
}


//fatta tutta da me, trova un elemento
PuntElem find_element(PuntElem*sPtr,char cercare[])
{
      PuntElem currentPtr=*sPtr;
      int test;
      //mi cerca un solo elemento perchè i numeri telefonici sono univoci (uno per persona, compreso il prefisso)
      if (isEmpty(*sPtr)) return NULL;
      while (currentPtr!=NULL && strcmp(currentPtr->dato,cercare)!=0) currentPtr=currentPtr->successivo;
	  return currentPtr;              
}




//fatta tutta da me, questa toglie l'elemento numero: "eliminaz_elemento" che voglio io, dalla lista
void elimina_elemento(PuntElem*sPtr,int eliminaz_elemento)
{
   PuntElem precedentePtr=*sPtr;
   PuntElem currentPtr;
   
   if (isEmpty(*sPtr)) printf("\n");
   else{
   
        if (eliminaz_elemento==1){
                             currentPtr=*sPtr;
                             *sPtr=(*sPtr)->successivo;
                             free(currentPtr);
                             }
                             
        else {
             currentPtr=(*sPtr)->successivo;
		   
		     if ((*sPtr)->successivo==NULL) printf("\nErrore elemento inesistente\n");
		     else{
				  while((currentPtr!=NULL) && (eliminaz_elemento!=currentPtr->posizione) && (currentPtr->successivo!=NULL))  //qeusta istruzione funziona anche se non trova l'elemento perchè basta una sola condizione che fa uscire dal ciclo
				  {
				    currentPtr=currentPtr->successivo;
			        precedentePtr=precedentePtr->successivo;
                  }
		          if (currentPtr->posizione==eliminaz_elemento) {
												precedentePtr->successivo=currentPtr->successivo;
											    free(currentPtr);
												printf("\nElemento rimosso correttamente\n");
														  } 
		          else  printf("\nErrore elemento inesistente\n");
		         }
		      }
        }//chiude l'else iniziale
}

   
//fatta tutta da me, fa l'upcase sul carattere iniziale di ogni parola in nome e cognome, per far si che l'ordine alfabetico sia corretto perchè caratt min>maius seconodo acsii
char upcase(char stringhetta)
{
    if((stringhetta>=97) && (stringhetta<=122)) stringhetta=stringhetta-32;    
    return stringhetta;
}   
 

void insert(PuntElem*sPtr,char value[],char utente[],char nome_persona[])
{
     PuntElem newPtr=NULL;
     PuntElem precedentePtr=NULL;
     PuntElem currentPtr=NULL;
     int j=0;
     
     newPtr = (PuntElem)malloc( sizeof(Elemento) ); //alloco la memoria e creo un nuovo puntatore
     
     if(newPtr!=NULL){  //se tutto è andato bene nell'allocazione eseguo queste oprazioni, se no vuol dire che non c'è memoria e do errore
     for(j=0;j<15;j++) newPtr->dato[j]=value[j];  //questo crea un nuovo valore (perchè metto valore(acquisito da main) con un nuovo numero
     for(j=0;j<35;j++) newPtr->cognome[j]=utente[j];
     for(j=0;j<35;j++) newPtr->nome[j]=nome_persona[j];     
     newPtr->successivo=NULL; //qui metto il puntatore del nuovo valore a NULL, perchè non punta a niente
        //ora scansione la lista per vedere dove inserire il nuovo elemento
     precedentePtr=NULL;
     currentPtr=*sPtr;      
     
     while(currentPtr!=NULL && utente[0] > currentPtr->cognome[0]){  //controllo una sola lettere per semplificare tutto, in relatà dovrei confrontare tutto il cognome per pire l'ordine alfabetico
              precedentePtr=currentPtr;
              currentPtr=currentPtr->successivo;
              }
        if(precedentePtr==NULL){
                   newPtr->successivo=*sPtr;
                   *sPtr=newPtr;
              //     newPtr->numero=cycle;
                  // printf("\n\n%d %d\n\n",newPtr->numero,cycle);
                   }
        else{
             precedentePtr->successivo=newPtr;
             newPtr->successivo=currentPtr;
             }
       }
       else printf("%d non inserito. Memoria non disponibile.\n",value);
}
    


int isEmpty(PuntElem sPtr)
{
    return sPtr==NULL;
}


//questa funzione è un  mix di mie idee, di quelle del prof e del libro di c mescolate. L'eliminazione in mezzo è del prof. Quella alla fine è mia e senza l'uso di strcmp
PuntElem delet(PuntElem*sPtr,char *value,char *utente)
{
	
     PuntElem currentPtr;
     PuntElem tempPtr;
     int h=0;
     int lunghezza=strlen(value);
     int lunghezza2=strlen((*sPtr)->dato);
     int lunghezza3=0;
     int cont=0;
     int ok=0;

	if (isEmpty(*sPtr)) return NULL;
	// deve togliere il blocco dalla lista
	// e restituirne l'indirizzo

    PuntElem pele=(*sPtr);
	PuntElem precedentePtr = NULL;
	//vedo se le 2 stringhe sono uguali (metodo alternativo a strcmp)
	for(h=0;h<lunghezza;h++) if ((*sPtr)->dato[h]==value[h]) cont++;
    if ((cont==lunghezza) && (cont==lunghezza2)) ok=1; //se uguali da 1 e quindi so che voglio eliminare il rimo elemento
    else ok=0;

	if(ok==1){ //vedo se il carettere che voglio eliminare è quello nel primo elemento (cioè il campo dato del primo elemento della lista)
             tempPtr=*sPtr; //metto *sPtr e tempPtr che puntano tutti al primo elemento
             *sPtr=(*sPtr)->successivo; //faccio puntare *sPtr all'elemento successivo alla lista
			 pele=tempPtr;
           //free(tempPtr); //elimino tempPtr, cosi' elimino il primo membro
     }

	else{//se no vado a veder quale altro elemento eliminare, che non sia il primo della lista
	
		// cerca stringa
		while (pele != NULL  && strcmp(pele->dato, value) != 0)
		{
			precedentePtr = pele;
			pele = pele->successivo;
		}
		// finito il ciclo potrei non aver trovato la stringa
		if (pele == NULL) return NULL;
	
		// il  blocco è puntato da pele
		// precedente punta il blocco prima
		if (precedentePtr != NULL) // elimino l'ultimo blocco rimasto ?
		{
			// no (ce ne sono altri)
			precedentePtr->successivo = pele->successivo;
		}
	
	}
		return pele;
}


void numerazione(PuntElem sPtr)
{
 int numeri=1;
 PuntElem cicloPtr;    
 cicloPtr=sPtr;
 if(cicloPtr==NULL) printf("\n");
 else {
      while(cicloPtr!=NULL){
      cicloPtr->posizione=numeri;
      cicloPtr=cicloPtr->successivo;
      numeri++;
      }
      }
}


void printList(PuntElem currentPtr)
{
     if(currentPtr==NULL) printf("Lista vuota.\n\n");
     else {
           printf("\n\nLa lista e':\n");
           while(currentPtr!=NULL){ //facilissimo, stampa i dati della lusta scorrendola tutta
               printf(">> %d : %s %s -> %s\n\n",currentPtr->posizione,currentPtr->cognome,currentPtr->nome,currentPtr->dato);
               currentPtr=currentPtr->successivo;
           }
		   printf(">> ..::Fine rubrica::..\n\n");
          }
}