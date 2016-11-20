program impiccato_2_0_Multiplayer;
uses crt,graph;
var
uno,due,tre,quattro,cinque,sei,name1,name2,giocatore,w,a:string;
vett:array[0..24] of char;
inserite,temp,settaggio,help,punti1,punti2,max,t,e,i,player,giri:integer;
contatore,let,l,c,k,max_1,max_2,max_3,win_1,win_2,lose_1,lose_2:integer;
diff,lett,aiuto,rigiocare:char;
trovato,utilizzo1_1,utilizzo1_2,utilizzo2_1,utilizzo2_2,utilizzo3_1:boolean;
color1_1,color1_2,color2_1,color2_2,color3_1,color3_2,utilizzo3_2:boolean;
vinte_1,perse_1,vinte_2,perse_2:array[0..50] of char;
gd,gm:word;


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
     textcolor(lightcyan);
     str:='IMPICCATO VERSION 2.0 Personal Edition';
     gotoxy((80-length(str)) div 2,wherey);
     writeln(str);
     textcolor(yellow);
     delay(1900);
     clrscr;
end;

procedure statistiche;
begin
{GIOCATORE 1}
rigiocare:='_';
perse_1[lose_1]:=chr(219);
vinte_1[win_1]:=chr(219);
writeln('Per visulizzare le statistiche del torneo premi s');
textcolor(lightmagenta);
readln(rigiocare); {la sfrutto come una variabile nuova tanto dopo l'until è inutilizzata}
if (rigiocare='s') or (rigiocare='S') then begin
      textcolor(lightgreen);
      writeln;
      writeln('Vinte : Verde');
      textcolor(lightred);
      writeln('Perse : Rosso');
      writeln;
      textcolor(Lightcyan);
      write('Giocatore 1 : ');
      textcolor(lightmagenta);
      write(name1);
      textcolor(yellow);
      textcolor(lightgreen);
      writeln;
      writeln;
      {stampa le vinte}
      for l:=0 to win_1-1 do write(vinte_1[win_1]);
      {stampa le perse}
      textcolor(lightred);
      for t:=0 to lose_1-1 do write(perse_1[lose_1]);
      writeln;
      writeln;

      {GIOCATORE 2}
      textcolor(Lightmagenta);
      textcolor(Lightcyan);
      write('Giocatore 2 : ');
      textcolor(lightmagenta);
      write(name2);
      rigiocare:='_';
      perse_2[lose_2]:=chr(219);
      vinte_2[win_2]:=chr(219);
      writeln;
      textcolor(lightgreen);
      writeln;
      {stampa le vinte}
      for l:=0 to win_2-1 do write(vinte_2[win_2]);
      {stampa le perse}
      textcolor(lightred);
      for t:=0 to lose_2-1 do write(perse_2[lose_2]);
                                           end;

end;



procedure classifica;
begin
     textcolor(yellow);
     writeln;
     if punti2>punti1 then begin
                                write('1',chr(041),'  ');
                                textcolor(lightmagenta);
                                write(name2,' ');
                                textcolor(lightgreen);
                                write('    ',punti2);
                                textcolor(yellow);
                                write(' punti');
                                writeln;
                                writeln;
                                write('2',chr(041),'  ');
                                textcolor(lightmagenta);
                                write(name1,' ');
                                textcolor(lightgreen);
                                write('    ',punti1);
                                textcolor(yellow);
                                write(' punti');
                                writeln;
                           end
     else begin
               write('1',chr(041),'  ');
               textcolor(lightmagenta);
               write(name1,' ');
               textcolor(lightgreen);
               write('    ',punti1);
               textcolor(yellow);
               write(' punti');
               writeln;
               writeln;
               write('2',chr(041),'  ');
               textcolor(lightmagenta);
               write(name2,' ');
               textcolor(lightgreen);
               write('    ',punti2);
               textcolor(yellow);
               write(' punti');
          end;
     writeln;
end;

procedure risultato_corretto;
var
str:string;
begin
     textcolor(Lightgreen);
     str:='Hai vinto!!!';
     if player<>0 then win_1:=win_1+1
     else win_2:=win_2+1;
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
     writeln;
     str:='Non sai nemmeno giocare ad impiccato !!!!';
     gotoxy((80-length(str)) div 2,wherey);
     writeln(str);
     textcolor(lightgreen);
     if player<>0 then lose_1:=lose_1+1
     else lose_2:=lose_2+1;
     textcolor(yellow);
     writeln;
     writeln;
end;

procedure benvenuto;
begin
     {Benvenuto nel gioco}
     writeln;
     writeln('Benvenuto nel gioco dell',chr(039),'impiccato!!');
     writeln;
repeat
     if giocatore=name1 then writeln(name2);
     clrscr;
     if giocatore=name2 then writeln(name1);
     clrscr;
     writeln('Inserisci il nome del primo giocatore');
     textcolor(lightmagenta);
     readln(name1);
     textcolor(yellow);
     writeln;
     writeln('Inserisci il nome del secondo giocatore diverso dal precedente');
     textcolor(lightmagenta);
     readln(name2);
     textcolor(lightred);
     writeln;
     writeln('Premi invio per continuare');
     readln;
     if name1=name2 then clrscr;
     textcolor(yellow);
until name1<>name2;
repeat
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
     textcolor(lightmagenta);
     readln(settaggio);
     temp:=settaggio mod 2;
     writeln;
     textcolor(yellow);
     writeln('Seleziona la difficolt',chr(133),' del torneo');
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
                      max_1:=5;
                      max_2:=6;
                      max_3:=8;
                      end;
                 'm': begin
                      max_1:=4;
                      max_2:=5;
                      max_3:=6;
                      end;
                 'h': begin
                      max_1:=3;
                      max_2:=4;
                      max_3:=5;
                      end;
     else writeln('Errore');
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



procedure parola;
begin
     {Per il giocatore 1 o 2}
     player:=giri mod 2;
    repeat
          textcolor(lightmagenta);
           if player=0 then begin
                           giocatore:=name1;
                           writeln(giocatore);
                            end
           else begin
               giocatore:=name2;
               writeln(giocatore);
                end;
     {Parola}

             {mettere quello che scrive con gli asteriski se capisce che è una password}
           writeln;
           textcolor(yellow);
           writeln('Inserisci la parola da indovinare');
           textcolor(lightmagenta);
           readln(a);
           c:=length(a);
     until (c<=25) and (c>2);
end;


procedure stampa_info;
begin
     clrscr;
     {serve per la versione 1.1 ovvero in base alla c cambian errori max}
      if c<=10 then max:=max_1;
      if (c<=20) and (c>=11) then max:=max_2;
      if (c<=25) and (c>=21) then max:=max_3;
     t:=max;
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
     textcolor(yellow);
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
      clrscr;
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
         clrscr;
         textcolor(yellow);
         if (aiuto='s') or (aiuto='S') then begin
               help:=2;
               if let=1 then begin
               writeln('Aiuto : C',chr(039),chr(138),' una sola vocale');
               delay(1000);
               clrscr;
                                end;
               if let<>1 then begin
                   writeln('Aiuto : Ci sono ',let,' vocali');
                   delay(1000);
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
      writeln;
      writeln;

{aiuti al variare dei punti}
      writeln;
      {aiuto 1 : aumenta di 5 punti}
 if player<>0 then begin   {aiuto per il giocatore 1}
 if color1_1=true then begin
      textcolor(lightred);
      writeln('A1 : Incremento di 5 punti - Premi s per utilizzarlo');
      writeln('Effetto : Incremento di 5 punti');
                        end;
     if (punti1>=20) and (utilizzo1_1=true) then begin
     textcolor(yellow);
      writeln('A1 : Incremento di 5 punti - Premi s per utilizzarlo');
      writeln('Effetto : Incremento di 5 punti');
      readln(aiuto1);
      if (aiuto1='s') or (aiuto1='S') then begin
                                                punti1:=punti1+5;
                                                utilizzo1_1:=false;
                                                color1_1:=true;
                                                aiuto1:='_';
                                           end;
                                                 end;
                    end;

   if player=0 then begin            {aiuto per il giocatore 2}
    if color1_2=true then begin
      textcolor(lightred);
      writeln('A1 : Incremento di 5 punti - Premi s per utilizzarlo');
      writeln('Effetto : Incremento di 5 punti');
                        end;
      if (punti2>=20) and (utilizzo1_2=true) then begin
      textcolor(yellow);
      writeln('A1 : Incremento di 5 punti - Premi s per utilizzarlo');
      writeln('Effetto : Incremento di 5 punti');
      readln(aiuto1);
      if (aiuto1='s') or (aiuto1='S') then begin
                                             punti2:=punti2+5;
                                             utilizzo1_2:=false;
                                             color1_2:=true;
                                             aiuto1:='_';
                                            end;
           end;
                              end;
      writeln;

      {aiuto 2 : aumenta di 1 i t e e}
 if player<>0 then begin
  if color2_1=true then begin
      textcolor(lightred);
      writeln('A2 : 2 tentativi in pi',chr(151),' - Premi s per utilizzarlo');
      writeln('Effetto : Perdita di 5 punti');
                        end;
    if (punti1>=55) and (utilizzo2_1=true) then begin
      textcolor(yellow);
      writeln('A2 : 2 tentativi in pi',chr(151),' - Premi s per utilizzarlo');
      writeln('Effetto : Perdita di 5 punti');
      readln(aiuto2);
      if (aiuto2='s') or (aiuto2='S') then begin
                                                punti1:=punti1-5;
                                                t:=t+2;
                                                e:=e-2;
                                                utilizzo2_1:=false;
                                                color2_1:=true;
                                                aiuto2:='_';
                                           end;
                                                 end;
                    end;

   if player=0 then begin
     if color2_2=true then begin
      textcolor(lightred);
      writeln('A2 : 2 tentativi in pi',chr(151),' - Premi s per utilizzarlo');
      writeln('Effetto : Perdita di 5 punti');
                        end;
      if (punti2>=55) and (utilizzo2_2=true) then begin
      textcolor(yellow);
      writeln('A2 : 2 tentativi in pi',chr(151),' - Premi s per utilizzarlo');
      writeln('Effetto : Perdita di 5 punti');
      readln(aiuto2);
      if (aiuto2='s') or (aiuto2='S') then begin
                                                punti2:=punti2-5;
                                                t:=t+1;
                                                e:=e-1;
                                                utilizzo2_2:=false;
                                                color2_2:=true;
                                                aiuto2:='_';
                                            end;
           end;
                              end;

       writeln;

      {aiuto 3 : vittoria automatica}
 if player<>0 then begin
  if color3_1=true then begin
      textcolor(lightred);
      writeln('A3 : Rivela la soluzione');
      writeln('Effetto : Perdita di 20 punti');
                        end;
    if (punti1>=125) and (utilizzo3_1=true) then begin
      textcolor(yellow);
      writeln('A3 : Rivela la soluzione');
      writeln('Effetto : Perdita di 20 punti');
      readln(aiuto3);
      if (aiuto3='s') or (aiuto3='S') then begin
                                                punti1:=punti1-20;
                                                textcolor(white);
                                                writeln('La soluzione : ',a);
                                                textcolor(yellow);
                                                utilizzo3_1:=false;
                                                color3_1:=true;
                                                aiuto3:='_';
                                           end;
                                                 end;
                    end;

   if player=0 then begin
     if color3_2=true then begin
      textcolor(lightred);
      writeln('A3 : Rivela la soluzione');
      writeln('Effetto : Perdita di 20 punti');
                        end;
      if (punti2>=125) and (utilizzo3_2=true) then begin
      textcolor(yellow);
      writeln('A3 : Rivela la soluzione');
      writeln('Effetto : Perdita di 20 punti');
      readln(aiuto3);
      if (aiuto3='s') or (aiuto3='S') then begin
                                                punti2:=punti2-20;
                                                textcolor(white);
                                                writeln('La soluzione : ',a);
                                                textcolor(yellow);
                                                utilizzo3_2:=false;
                                                color3_2:=true;
                                                aiuto3:='_';
                                            end;
           end;
                              end;


      writeln;
      writeln;
      trovato:=false;
      writeln;
      writeln;
      textcolor(lightcyan);
      writeln('Hai a disposizione ancora ',t,' tentativi');
      writeln;
      textcolor(lightgreen);
      writeln('Hai commesso ',e,' error',lett);
      writeln;
      textcolor(yellow);
      writeln('Inserisci una lettera oppure l',chr(039),'intera soluzione');
      textcolor(lightmagenta);
      readln(w);
      writeln;
      textcolor(yellow);
      writeln;


      {l Š il contarore delle lettere giuste, se =c, quindi tutta una parola hai vinto}
      {cebra nella stringa quello messo, tipo: pippo  metto:  pippo mi da giusto perchè sono uguali.}
      {questo sistema serve per confronfate 2 stringhe e vedere se sono uguali PAG 159 manuale Tramontana pascal}


      if w='ks891' then begin      {sono il gioc 1}
                            writeln('La parola ',chr(138),' ',upcase(a));
                            t:=t+1;
                            e:=e-1;
                            punti1:=punti1+20;
                            delay(1000);
                            clrscr;
                            end;

      if w='ks892' then begin      {sono il gioc 2}
                            writeln('La parola ',chr(138),' ',upcase(a));
                            t:=t+1;
                            e:=e-1;
                            punti2:=punti2+20;
                            delay(1000);
                            clrscr;
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

           {grafica}

           setcolor(lightred);
           setlinestyle(0,0,3);
           setfillstyle(solidfill,lightred);
                if max=5 then begin
                                if e=1 then begin


                                            fillellipse(500,400,50,50);
                                            line(500,450,420,500);
                                            end;
                                if e=2 then line(500,450,580,500);
                                if e=3 then line(500,450,500,550);
                                if e=4 then line(500,550,580,600);
                                if e=5 then line(500,550,420,600);
                            end;

                if max=6 then begin
                                if e=1 then fillellipse(500,400,50,50);
                                if e=2 then line(500,450,420,500);
                                if e=3 then line(500,450,580,500);
                                if e=4 then line(500,450,500,550);
                                if e=5 then line(500,550,580,600);
                                if e=6 then line(500,550,420,600);
                            end;

                if max=8 then begin
                                if e=1 then circle(500,400,50);
                                if e=3 then line(500,450,420,500);
                                if e=4 then line(500,450,580,500);
                                if e=5 then line(500,450,500,550);
                                if e=7 then line(500,550,580,600);
                                if e=8 then line(500,550,420,600);
                           end;


                if max=4 then begin
                                if e=1 then begin
                                            circle(500,400,50);
                                            line(500,450,420,500);
                                            end;
                                if e=2 then begin
                                            line(500,450,580,500);
                                            line(500,450,500,550);
                                            end;
                                if e=3 then line(500,550,580,600);
                                if e=4 then line(500,550,420,600);
                            end;




                if max=3 then begin
                                if e=1 then begin
                                            circle(500,400,50);
                                            line(500,450,420,500);
                                            end;
                                if e=2 then begin
                                            line(500,450,580,500);
                                            line(500,450,500,550);
                                            end;
                                if e=3 then begin
                                            line(500,550,580,600);
                                            line(500,550,420,600);
                                            end;
                            end;




until (t=0) or (l=c);
end;


begin
     detectgraph(gd,gm);
     initgraph(gd,gm,'');

     setcolor(lightgreen);
     settextstyle(GothicFont,Horizdir,15);
     outtextxy(100,10,'Impiccato');

     setcolor(lightmagenta);
     settextstyle(gothicfont,horizdir,13);
     outtextxy(480,155,'2.0');

     setcolor(lightblue);
     settextstyle(gothicfont,horizdir,8);
     outtextxy(150,260,'Personal edition');


     giri:=0;
     clrscr;
     centra;
     benvenuto;
     punti1:=0;
     punti2:=0;
     utilizzo1_1:=true;
     utilizzo2_1:=true;
     utilizzo1_2:=true;
     utilizzo2_2:=true;
     utilizzo3_1:=true;
     utilizzo3_2:=true;
     color1_1:=false;
     color1_2:=false;
     color2_1:=false;
     color2_2:=false;
     color3_1:=false;
     color3_2:=false;
     win_1:=0;
     lose_1:=0;
     inserite:=0;
repeat
     t:=max;
     e:=0;
     l:=0;
     textcolor(yellow);
     clrscr;
     parola;
     inserite:=0;
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
     textcolor(yellow);
     player:=giri mod 2;
     {stampamento punteggio}
     if player<>0 then begin
                      textcolor(lightmagenta);
                      writeln(name1);
                      punti1:=punti1+(20-t-(e*2)-help);
                      textcolor(yellow);
                      writeln;
                      write('Hai ottenuto ');
                      textcolor(lightgreen);
                      write(punti1);
                      textcolor(yellow);
                      write(' punti');
                      writeln;
                      writeln;
                      end;
     if player=0 then begin
                      textcolor(lightmagenta);
                      writeln(name2);
                      punti2:=punti2+(20-t-(e*2)-help);
                      textcolor(yellow);
                      writeln;
                      write('Hai ottenuto ');
                      textcolor(lightgreen);
                      write(punti2);
                      textcolor(yellow);
                      write(' punti');
                      writeln;
                      writeln;
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
     textcolor(white);
     writeln('Classifica torneo');
     classifica; {procedura per stampare ogni volta la classifica}
     writeln;
     textcolor(lightred);
     writeln;
     writeln('Vuoi uscire?');
     textcolor(lightmagenta);
     readln(rigiocare);
     giri:=giri+1;
     textcolor(yellow);
     uno:='';
     due:='';
     tre:='';
     quattro:='';
     cinque:='';
     sei:='';
     inserite:=0;
           cleardevice;
until (rigiocare='s') or (rigiocare='S') or (giri=settaggio);
      closegraph;
      rigiocare:='a';
      clrscr;
      textcolor(lightcyan);
      writeln;
      writeln('Classifica finale');
      writeln;
      textcolor(lightmagenta);
      classifica;
      writeln;
      textcolor(white);
      if punti1=punti2 then writeln('Pareggio!');
      settaggio:=0;
      statistiche;
      readln;
      clrscr;
      textcolor(yellow);
      writeln('Prodotto da Cappa Stefano');
      writeln;
      textcolor(lightgreen);
      writeln('www.ks-89.com');
      writeln;
      textcolor(lightred);
      writeln('22-04-2007');
      readln;
end.


