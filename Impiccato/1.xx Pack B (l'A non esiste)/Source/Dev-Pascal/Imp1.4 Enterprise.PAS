program impiccato_1_4;
uses crt;
var
giocatore,w,a:string;
vett:array[0..24] of char;
temp,settaggio,help,punti1,punti2,max,contatore,vocali,let_a,let_e,let_i,let_o,let_u,l,c,k,t,e,i,player,giri:integer;
lett,aiuto,rigiocare:char;
trovato:boolean;

procedure sound1;
begin
     sound(262);
     delay(500);
     sound(294);
     delay(500);
     sound(330);
     delay(500);
     nosound;
end;


procedure sound2;
begin
     sound(392);
     delay(500);
     sound(440);
     delay(500);
     sound(494);
     delay(500);
     nosound;
end;


procedure centra;
var
z:integer;
str:string;
begin
     textbackground(black);
     textcolor(Lightred);
     clrscr;
     str:='KS 89 production';
     gotoxy((80-length(str)) div 2,wherey);
     writeln(str);
     writeln;
     delay(1500);

     textcolor(Lightmagenta);
     str:='Anno 2006-2007 (c)KS89';
     gotoxy((80-length(str)) div 2,wherey);
     writeln(str);
     delay(1500);
     clrscr;

     writeln('Loading');
     for z:=1 to 50 do begin
                            textcolor(z);
                            write((chr(219)));
                            delay(10);
                        end;
     sound(200);
     delay(500);
     nosound;

     clrscr;
     textcolor(lightred);
     writeln('Avvio in corso');
     delay(500);
     clrscr;
     textcolor(LightCyan);
     str:='IMPICCATO VERSION 1.4 Enterprise';
     gotoxy((80-length(str)) div 2,wherey);
     writeln(str);
     textcolor(yellow);
     delay(1900);
     clrscr;
end;


procedure classifica;
begin
     textcolor(yellow);
     if punti2>punti1 then begin
                                writeln('1',chr(041),' -- Giocatore 2 -- ',punti2);
                                writeln('2',chr(041),' -- Giocatore 1 -- ',punti1);
                           end
     else begin
               writeln('1',chr(041),' -- Giocatore 1 -- ',punti1);
               writeln('2',chr(041),' -- Giocatore 2 -- ',punti2);
          end;
     writeln;
end;

procedure risultato_corretto;
var
str:string;
begin
     textcolor(Lightred);
     str:='Hai vinto!!!';
     gotoxy((80-length(str)) div 2,wherey);
     writeln(str);
end;


procedure risultato_errato;
var
str:string;
begin
     textcolor(Lightred);
     str:='Hai perso!!!!';
     gotoxy((80-length(str)) div 2,wherey);
     writeln(str);
     delay(1500);
     textcolor(Lightmagenta);
     str:='Non sai nemmeno giocare ad impiccato !!!!';
     gotoxy((80-length(str)) div 2,wherey);
     writeln(str);
     textcolor(yellow);
end;

procedure benvenuto;
begin
     {Benvenuto nel gioco}
     writeln;
     writeln('Benvenuto nel gioco dell',chr(039),'impiccato!!');
     writeln;
     writeln('Premi invio per continuare');
     readln;
 repeat
     clrscr;
     writeln('Regole');
     writeln;
     textcolor(lightgreen);
     writeln('Inizia sempre il secondo giocatore');
     writeln('Il secondo inserisce la parola e il primo la deve indovinare');
     writeln('Dopo i ruoli si invertono');
     writeln('Ad ogni partita viene aggiornata la classifica dei punteggi');
     writeln;
     textcolor(lightcyan);
     writeln('Impostazioni torneo');
     writeln;
     textcolor(yellow);
     writeln('Quante partite desideri fare nel tuo torneo? Inserisci solo numeri pari');
     readln(settaggio);
     temp:=settaggio mod 2;
 until temp=0;
     writeln;
     textcolor(lightred);
     writeln('Premi un tasto per inziare a giocare');
     readln;
     clrscr;
end;


procedure parola;
begin
     {Per il giocatore 1 o 2}
     player:=giri mod 2;
           if player=0 then begin
                           giocatore:='Giocatore 1';
                           writeln(giocatore);
                            end
           else begin
               giocatore:='Giocatore 2';
               writeln(giocatore);
                end;
     {Parola}
     repeat
           writeln;
           writeln('Inserisci la parola da indovinare');
           readln(a);
           clrscr;
           c:=length(a);
     until (c<=25) and (c>2);
end;


procedure stampa_info;
begin
     clrscr;
     {serve per la versione 1.1 ovvero in base alla c cambian errori max}
      if c<=10 then max:=4;
      if (c<=20) and (c>=11) then max:=5;
      if (c<=25) and (c>=21) then max:=6;
     t:=max;
     if giocatore='Giocatore 1' then writeln('Giocatore 2');
     if giocatore='Giocatore 2' then writeln('Giocatore 1');
     writeln;
     writeln('Hai a disposizione al massimo ',max,' tentativi per indovinare la parola');
     writeln;
     writeln('Puoi commettere al massimo ',max,' errori');
     writeln;
     writeln('Premi invio per continuare');
     readln;
     clrscr;
     for i:=0 to c-1 do vett[i]:='_';
end;


procedure impiccato;
var
controllo:boolean;
begin
{controllo e operazione di impiccagione}
controllo:=false;
let_a:=0;
let_e:=0;
let_i:=0;
let_o:=0;
let_u:=0;
repeat
     {----AIUTO----}
     {serve per l'aiuto sulle vocali}
     for k:=0 to c do begin
                           if a[k]='a' then let_a:=1;
                           if a[k]='e' then let_e:=1;
                           if a[k]='i' then let_i:=1;
                           if a[k]='o' then let_o:=1;
                           if a[k]='u' then let_u:=1;
                       end;
      vocali:=let_a+let_e+let_i+let_o+let_u;
      contatore:=contatore+1;  {serve per contare in che giro ci si trova per stampare l'aiuto solo se è il primo giro}
      if controllo=false then begin  {serve per chiedere l'aiuto solo al primo giro, dopo no}
         clrscr;
         writeln('Per visualizzare l',chr(039),'aiuto premi dalla testiera la lettera S per non visualizzarla INVIO');
         readln(aiuto);
         clrscr;
         if (aiuto='s') or (aiuto='S') then begin
               help:=2;
               if vocali=1 then begin
               writeln('Aiuto : C',chr(039),chr(138),' un solo tipo di vocale');
               delay(1000);
               clrscr;
                                end;
               if vocali<>1 then begin
                   writeln('Aiuto : Ci sono ',vocali,' tipi di vocali diverse');
                   delay(1000);
                   clrscr;

                                 end;
                                            end;
                              end;
      writeln('La parola ',chr(138),' : ');
      writeln;
      writeln;
      writeln;
      controllo:=true;
      writeln;
      writeln;
      {comando per centrare la parola coi trattini}
      gotoxy((80-c) div 2,wherey);
      for i:=0 to c-1 do begin
                         write(vett[i],' ');
                         delay(200);
                         end;
      {controllo e o i della parola errore}
      if e=1 then lett:='e'
      else lett:='i';

      i:=0;
      writeln;
      writeln;
      trovato:=false;
      writeln;
      writeln;
      writeln('Hai a disposizione ancora ',t,' tentativi');
      writeln;
      writeln('Hai commesso ',e,' error',lett);
      writeln;
      writeln('Inserisci una lettera che ipotizzi che sia contenuta nella parola segreta oppure l',chr(039),'intera soluzione');
      readln(w);
      clrscr;
      writeln('La lettera inserita ',chr(138),' : ',w);
      writeln;

      {per i codici, però non va}
      {if w='111' then begin
                                  writeln('Esito del gioco');
                                  writeln;
                                  writeln('Tentativi rimanenti : 5');
                                  writeln('Errori commessi : 0');
                                  writeln;
                                  writeln;
                                  writeln('La parola era : ',upcase(a));
                                  writeln;
                                  if giocatore='Giocatore 1' then punti1:=punti1+200;
                                  if giocatore='Giocatore 2' then punti2:=punti2-10;
                                  writeln;
                                  writeln(giocatore);
                                  writeln('Hai ottenuto 20 punti');
                              end;}


      {l è il contarore delle lettere giuste, se =c, quindi tutta una parola hai vinto}
      {cebra nella stringa quello messo, tipo: pippo  metto:  pippo mi da giusto perchè sono uguali.}
      {questo sistema serve per confronfate 2 stringhe e vedere se sono uguali PAG 159 manuale Tramontana pascal}

      if (length(w)=length(a)) and (pos(upcase(w),upcase(a))<>0) then begin
                                                                 l:=c;
                                                                 trovato:=true;
                                                                      end
      else begin
           if length(w)=1 then begin
                for k:=0 to c do begin
                     if upcase(w[1])=upcase(a[k]) then begin
                                         vett[k-1]:=upcase(a[k]);
                                         trovato:=true;
                                         l:=l+1;
                                                        end;
                                  end;
                                end
            else trovato:=false;
           end;
           if trovato=false then begin
                                      e:=e+1;
                                      t:=t-1;
                                   end;
           clrscr;
until (t=0) or (l=c);
end;

begin
     giri:=0;
     clrscr;
     centra;
     benvenuto;
repeat
     t:=max;
     e:=0;
     l:=0;
     textcolor(yellow);
     clrscr;
     parola;
     stampa_info;

     writeln;
     writeln;
     clrscr;

     impiccato;

     writeln('Esito del gioco');
     writeln;
     writeln('Tentativi rimanenti : ',t);
     writeln('Errori commessi : ',e);
     writeln;
     writeln;
     writeln('La parola era : ',upcase(a));
     writeln;
     player:=giri mod 2;
     {stampamento punteggio}
     if player<>0 then begin
                      writeln('Giocatore 1');
                      punti1:=punti1+(20-t-(e*2)-help);
                      writeln('Hai ottenuto ',punti1,' punti');
                      end;
     if player=0 then begin
                      writeln('Giocatore 2');
                      punti2:=punti2+(20-t-(e*2)-help);
                      writeln('Hai ottenuto ',punti2,' punti');
                      end;
     writeln;
     writeln;
     if (t>0) and (l=c) then begin
                                  risultato_corretto;
                                  sound1;
                             end
     else begin
               risultato_errato;
               sound2;
          end;

     writeln('Classifica torneo');
     classifica; {procedura per stampare ogni volta la classifica}
     writeln('Vuoi uscire?');
     readln(rigiocare);
     giri:=giri+1;
until (rigiocare='s') or (rigiocare='S') or (giri=settaggio);
      clrscr;
      textcolor(lightcyan);
      writeln('Classifica finale');
      writeln;
      textcolor(lightmagenta);
      classifica;
      readln;
end.


