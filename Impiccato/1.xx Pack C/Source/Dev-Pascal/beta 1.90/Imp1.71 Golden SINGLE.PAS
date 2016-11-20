program impiccato_1_61_Premium_Single;
uses crt;
var
uno,due,tre,quattro,cinque,sei,name,w,a:string;
vett:array[0..24] of char;
inserite,settaggio,help,punteggio,max,contatore,let,l,c,k,t,e,i,giri:integer;
max_1,max_2,max_3,temp,win,lose,azzurro:integer;
diff,lett,aiuto,rigiocare:char;
trovato,color1,color2,color3,utilizzo1,utilizzo2,utilizzo3:boolean;
vinte,perse:array[0..50] of char;

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


procedure statistiche;
begin
{GIOCATORE 1}
rigiocare:='_';
perse[lose]:=chr(219);
vinte[win]:=chr(219);
textcolor(white);
writeln;
writeln('Per visulizzare le statistiche del torneo premi s');
textcolor(lightmagenta);
readln(rigiocare); {la sfrutto come una variabile nuova tanto dopo l'until è inutilizzata}
if (rigiocare='s') or (rigiocare='S') then begin
      textcolor(lightgreen);
      writeln;
      writeln('Vinte : Verde');
      textcolor(lightred);
      writeln('Perse : Rosso');
      textcolor(white);
      writeln('Punteggio : Bianco');
      writeln;
      textcolor(Lightcyan);
      write('Giocatore : ');
      textcolor(lightmagenta);
      write(name);
      textcolor(yellow);
      textcolor(lightgreen);
      writeln;
      writeln;
      {stampa le vinte}
      for l:=0 to win-1 do write(vinte[win]);
      {stampa le perse}
      textcolor(lightred);
      for t:=0 to lose-1 do write(perse[lose]);
      writeln;
      writeln;
      {stampa un grafico approssimarivo dei punti}
      textcolor(white);
      for azzurro:=0 to punteggio do write(chr(219));
                                           end;

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
     str:='Anno 2007 (c)KS89';
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
     str:='IMPICCATO VERSION 1.71 Golden Single';
     gotoxy((80-length(str)) div 2,wherey);
     writeln(str);
     textcolor(yellow);
     delay(1900);
     clrscr;
end;


procedure classifica;
begin
     textcolor(white);
     writeln;
     writeln('Statistiche torneo');
     writeln;
     textcolor(yellow);
     write('1',chr(041),'  ');
     textcolor(lightmagenta);
     write(name,' ');
     textcolor(lightgreen);
     write('    ',punteggio);
     textcolor(yellow);
     write(' punti');
     writeln;
     writeln;
     textcolor(lightred);
     writeln('Vuoi uscire?');
     readln(rigiocare);
     giri:=giri+1;
     writeln;
end;


procedure risultato_corretto;
var
str:string;
begin
     textcolor(lightgreen);
     str:='Hai vinto!!!';
     win:=win+1;
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
     lose:=lose+1;
     str:='Non sai nemmeno giocare ad impiccato !!!!';
     gotoxy((80-length(str)) div 2,wherey);
     writeln(str);
     textcolor(yellow);
end;

procedure benvenuto;
begin
repeat
 repeat
     {Benvenuto nel gioco}
     writeln('Inserisci il tuo nome');
     textcolor(lightmagenta);
     readln(name);
     textcolor(lightred);
     writeln;
     writeln('Premi invio per continuare');
     readln;
     clrscr;
     textcolor(yellow);
     writeln('Regole');
     writeln;
     textcolor(lightgreen);
     writeln('Il computer genera una parola casuale contenuta nel dizionario');
     writeln('Il tuo scopo ',chr(138),' quello di indovinarla');
     writeln;
     textcolor(lightcyan);
     writeln('Impostazioni gioco');
     writeln;
     textcolor(yellow);
     writeln('Quante partite desideri fare?');
     textcolor(lightmagenta);
     readln(settaggio);
     writeln;
     textcolor(yellow);
     writeln('Seleziona la difficoltà del torneo');
     writeln;
     textcolor(lightgreen);
     writeln('Premi e per Easy');
     textcolor(lightcyan);
     writeln('Premi m per Medium');
     textcolor(lightred);
     writeln('Premi h per Hard');
     textcolor(lightmagenta);
     writeln;
     readln(diff);
     case diff of
                 'e': begin
                      max_1:=6;
                      max_2:=7;
                      max_3:=8;
                      end;
                 'm': begin
                      max_1:=5;
                      max_2:=6;
                      max_3:=8;
                      end;
                 'h': begin
                      max_1:=4;
                      max_2:=5;
                      max_3:=6;
                      end;
     else writeln('Errore');
     clrscr;
     textcolor(yellow);
     end;
 until (diff='e') or (diff='m') or (diff='h');
     textcolor(yellow);
until temp=0;
     writeln;
     textcolor(lightred);
     writeln('Premi un tasto per inziare a giocare');
     readln;
     clrscr;
end;


function estraiparola(min:integer; max:integer): String;
var
t:text;
c:char;
s,percorso:string;
i,molt:longint;
casuale:real;
begin
     clrscr;
     repeat
           getdir(0, percorso);
           percorso := percorso + '\it.dic';
           assign(t,percorso);
           reset(t);
           s:='';
           randomize;
           molt := 3670000;
           casuale:=random * molt;
           for i:=0 to trunc(casuale) do
                   read(t,c);
                   c:='_';
                   repeat
                         read(t,c);
                          until c = chr(10);
                           repeat
                              read(t,c);
                                 if c <> chr(10) then
                                           s:=s+c;
     until c = chr(10);
     close(t);
     until (length(s) > min) and (length(s) < max);
     estraiparola := s;
end;


procedure parola;
begin

     {Per il giocatore}
     repeat
          writeln(name);
     {Parola}
           a := estraiparola(3,100);
           clrscr;
           c:=length(a);
     until (c<=25) and (c>2);
end;


procedure stampa_info;
begin
     clrscr;
     {serve per la versione 1.1 ovvero in base alla c cambian errori max modificato tutto per la 1.5}
      if c<=10 then max:=max_1;
      if (c<=20) and (c>=11) then max:=max_2;
      if (c<=25) and (c>=21) then max:=max_3;
     t:=max;
     textcolor(lightmagenta);
     writeln(name);
     writeln;
     textcolor(lightcyan);
     writeln('Hai a disposizione al massimo ',max,' tentativi per indovinare la parola');
     writeln;
     textcolor(lightgreen);
     writeln('Puoi commettere al massimo ',max,' errori');
     writeln;
     textcolor(lightred);
     writeln('Premi invio per continuare');
     readln;
     clrscr;
     for i:=0 to c-1 do vett[i]:='_';
end;


procedure impiccato;
var
controllo:boolean;
aiuto1,aiuto2,aiuto3:char;
begin
{controllo e operazione di impiccagione}
controllo:=false;
let:=0;
repeat
      textcolor(yellow);
     {----AIUTO----}
     {serve per l'aiuto sulle vocali}
     for k:=0 to c do begin
                           if a[k]='a' then let:=let+1;
                           if a[k]='e' then let:=let+1;
                           if a[k]='i' then let:=let+1;
                           if a[k]='o' then let:=let+1;
                           if a[k]='u' then let:=let+1;
                       end;
      contatore:=contatore+1;  {serve per contare in che giro ci si trova per stampare l'aiuto solo se è il primo giro}
      if controllo=false then begin  {serve per chiedere l'aiuto solo al primo giro, dopo no}
         clrscr;
         writeln('Per visualizzare l',chr(039),'aiuto premi S per non visualizzarlo INVIO');
         textcolor(lightmagenta);
         readln(aiuto);
         textcolor(yellow);
         clrscr;
         if (aiuto='s') or (aiuto='S') then begin
               help:=2;
               if let=1 then begin
               writeln('Aiuto : C',chr(039),chr(138),' solo una vocale');
               delay(1400);
               clrscr;
                                end;
               if let<>1 then begin
                   writeln('Aiuto : Ci sono ',let,' vocali nella parola');
                   delay(1400);
                   clrscr;

                                 end;
                                            end;
                              end;
      textcolor(yellow);
      writeln('La parola ',chr(138),' : ');
      writeln;
      writeln;
      writeln;
      controllo:=true;
      writeln;
      writeln;
      {comando per centrare la parola coi trattini}
      textcolor(white);
      gotoxy((80-(c*2)) div 2,wherey);
      for i:=0 to c-1 do begin
                         write(vett[i],' ');
                         delay(200);
                         end;
      {controllo e o i della parola errore}
      if e=1 then lett:='e'
      else lett:='i';
      textcolor(yellow);

      i:=0;
      writeln;
      writeln;
      trovato:=false;
      {aiuti al variare dei punti}
      writeln;
      {aiuto 1 : aumenta di 5 punti}
 {aiuto per il giocatore 1}
if color1=true then begin
      textcolor(lightred);
      writeln('A1 : Incremento di 5 punti - Premi s per utilizzarlo');
      writeln('Effetto : Incremento di 5 punti');
                        end;
     if (punteggio>=20) and (utilizzo1=true) then begin
     textcolor(yellow);
      writeln('A1 : Incremento di 5 punti - Premi s per utilizzarlo');
      writeln('Effetto : Incremento di 5 punti');
      readln(aiuto1);
      if (aiuto1='s') or (aiuto1='S') then begin
                                                punteggio:=punteggio+5;
                                                utilizzo1:=false;
                                                color1:=true;
                                                aiuto1:='_';
                                           end;
                                                 end;
      writeln;

      {aiuto 2 : aumenta di 1 i t e e}
if color2=true then begin
      textcolor(lightred);
      writeln('A2 : 2 tentativi in pi',chr(151),' - Premi s per utilizzarlo');
      writeln('Effetto : Perdita di 5 punti');
                        end;
    if (punteggio>=55) and (utilizzo2=true) then begin
      textcolor(yellow);
      writeln('A2 : 2 tentativi in pi',chr(151),' - Premi s per utilizzarlo');
      writeln('Effetto : Perdita di 5 punti');
      readln(aiuto2);
      if (aiuto2='s') or (aiuto2='S') then begin
                                               punteggio:=punteggio-5;
                                                t:=t+2;
                                                e:=e-2;
                                                utilizzo2:=false;
                                                color2:=true;
                                                aiuto2:='_';
                                           end;
                                                 end;


       writeln;

      {aiuto 3 : vittoria automatica}
  if color3=true then begin
      textcolor(lightred);
      writeln('A3 : Vittoria automatica');
      writeln('Effetto : Perdita di 20 punti');
                        end;
    if (punteggio>=125) and (utilizzo3=true) then begin
      textcolor(yellow);
      writeln('A3 : Vittoria automatica');
      writeln('Effetto : Perdita di 20 punti');
      readln(aiuto3);
      if (aiuto3='s') or (aiuto3='S') then begin
                                                punteggio:=punteggio-20;
                                                textcolor(white);
                                                writeln('La soluzione : ',a);
                                                textcolor(yellow);
                                                utilizzo3:=false;
                                                color3:=true;
                                                aiuto3:='_';
                                           end;
                                                 end;


      writeln;
      writeln;
      writeln;
      textcolor(lightcyan);
      writeln('Hai a disposizione ancora ',t,' tentativi');
      textcolor(lightgreen);
      writeln;
      writeln('Hai commesso ',e,' error',lett);
      textcolor(yellow);
      writeln;
      writeln('Inserisci una lettera oppure l',chr(039),'intera soluzione');
      textcolor(lightmagenta);
      readln(w);
      writeln;


      {l è il contarore delle lettere giuste, se =c, quindi tutta una parola hai vinto}
      {cebra nella stringa quello messo, tipo: pippo  metto:  pippo mi da giusto perchè sono uguali.}
      {questo sistema serve per confronfate 2 stringhe e vedere se sono uguali PAG 159 manuale Tramontana pascal}

      
      if w='ks891' then begin      {sono l'1}
                            textcolor(yellow);
                            writeln('La parola ',chr(138),' ',upcase(a));
                            t:=t+1;
                            e:=e-1;
                            punteggio:=punteggio+20;
                            delay(1000);
                            end;




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
                    inserite:=inserite+1;
                    {se la lettere è sbagluata stampa le lettere sbagliate, ovvero quelle già messe ma sbagliate}
                    if inserite=1 then  begin
                    textcolor(lightgreen);
                      uno:=w;
                      writeln('Le ultime lettere inserite sono : ',uno);
                                       end;
                    if inserite=2 then  begin
                      textcolor(lightgreen);
                      due:=w;
                      writeln('Le ultime lettere inserite sono : ',uno,' , ',due);
                                       end;
                    if inserite=3 then  begin
                      textcolor(lightgreen);
                      tre:=w;
                      writeln('Le ultime lettere inserite sono : ',uno,' , ',due,' , ',tre);
                                       end;
                    if inserite=4 then  begin
                      textcolor(lightgreen);
                      quattro:=w;
                      writeln('Le ultime lettere inserite sono : ',uno,' , ',due,' , ',tre,' , ',quattro);
                                       end;
                    if inserite=5 then  begin
                      textcolor(lightgreen);
                      cinque:=w;
                      writeln('Le ultime lettere inserite sono : ',uno,' , ',due,' , ',tre,' , ',quattro,' , ',cinque);
                                       end;
                    if inserite=6 then  begin
                      textcolor(lightgreen);
                      sei:=w;
                      writeln('Le ultime lettere inserite sono : ',uno,' , ',due,' , ',tre,' , ',quattro,' , ',cinque,' , ',sei);
                                       end;
                                 end;
           writeln;
           writeln;
           textcolor(lightred);
           writeln('Premi invio per continuare');
           readln;
           clrscr;
           textcolor(yellow);
until (t=0) or (l=c);
end;


begin
     utilizzo1:=true;
     utilizzo2:=true;
     utilizzo3:=true;
     color1:=false;
     color2:=false;
     color3:=false;
     win:=0;
     lose:=0;
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
     textcolor(lightmagenta);
     writeln('Esito del gioco');
     writeln;
     textcolor(lightcyan);
     writeln('Tentativi rimanenti : ',t);
     textcolor(lightgreen);
     writeln('Errori commessi : ',e);
     writeln;
     writeln;
     textcolor(white);
     writeln('La parola era : ',upcase(a));
     writeln;
     writeln;
     {stampamento punteggio}
     textcolor(lightmagenta);
     writeln(name);
     writeln;
     punteggio:=punteggio+(20-t-(e*2)-help);
     textcolor(yellow);
     write('Hai ottenuto ');
     textcolor(lightgreen);
     write(punteggio);
     textcolor(yellow);
     write(' punti');
     writeln;
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

      classifica;
      uno:='';
     due:='';
     tre:='';
     quattro:='';
     cinque:='';
     sei:='';
     inserite:=0;
until (rigiocare='s') or (rigiocare='S') or (giri=settaggio);
      clrscr;
      textcolor(lightcyan);
      writeln;
      writeln('Classifica finale');
      writeln;
      textcolor(yellow);
      write('1',chr(041),'  ');
      textcolor(lightmagenta);
      write(name,' ');
      textcolor(lightgreen);
      write('    ',punteggio);
      textcolor(yellow);
      write(' punti');
      writeln;
      textcolor(lightmagenta);
      statistiche;
      settaggio:=0;
      readln;
      clrscr;
      textcolor(yellow);
      writeln('Prodotto da Cappa Stefano');
      writeln;
      textcolor(lightgreen);
      writeln('www.ks-89.com');
      writeln;
      textcolor(lightred);
      writeln('22-01-2007');
      readln;

end.


