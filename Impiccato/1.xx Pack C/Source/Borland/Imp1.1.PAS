program impiccato_1_1;
uses crt;
var
w,a:string;
vett:array[0..24] of char;
max,contatore,vocali,z,l,c,punti,k,t,e,i:integer;
lett,aiuto:char;
controllo,trovato:boolean;

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
     str:='IMPICCATO VERSION 1.1';
     gotoxy((80-length(str)) div 2,wherey);
     writeln(str);
     textcolor(yellow);
     delay(1900);
     clrscr;
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
     clrscr;
     writeln('Il primo giocatore deve inserire una parola');
     writeln('il secondo deve scoprirla introducendo una lettera alla volta');
     clrscr;
end;


procedure parola;
begin
     {Parola}
     repeat
           writeln('Inserisci la parola da indovinare');
           readln(a);
           clrscr;
           c:=length(a);
     until (c<=25) and (c>2);
end;


procedure stampa_info;
begin
     clrscr;
     writeln;

     {serve per la versione 1.1 ovvero in base alla c cambian errori max}
      if c<=10 then max:=4;
      if (c<=20) and (c>=11) then max:=5;
      if (c<=25) and (c>=21) then max:=6;
      t:=max;

     writeln('Hai a disposizione al massimo ',max,' tentativi per indovinare la parola');
     writeln('Puoi commettere al massimo ',max,' errori');
     writeln;
     writeln('Premi invio per continuare');
     readln;
     clrscr;
     for i:=0 to c-1 do vett[i]:='_';
end;


procedure impiccato;
begin
{controllo e operazione di impiccaggione}
controllo:=false;
vocali:=0;
repeat
     {----AIUTO----}
     {serve per l'aiuto sulle vocali}
     for k:=0 to c do begin
                           if a[k]='a' then vocali:=vocali+1;
                           if a[k]='e' then vocali:=vocali+1;
                           if a[k]='i' then vocali:=vocali+1;
                           if a[k]='o' then vocali:=vocali+1;
                           if a[k]='u' then vocali:=vocali+1;
                       end;
      contatore:=contatore+1;  {serve per contare in che giro ci si trova per stampare l'aiuto solo se è il primo giro}
      if controllo=false then begin  {serve per chiedere l'aiuto solo al primo giro, dopo no}
         clrscr;
         writeln('Per visualizzare l',chr(039),'aiuto premi S per non visualizzarlo un alto pulsante');
         readln(aiuto);
         clrscr;
         if (aiuto='s') or (aiuto='S') then begin
               if vocali=1 then begin
               writeln('Aiuto : C',chr(039),chr(138),' una sola vocale');
               delay(1000);
               clrscr;
                                end;
               if vocali<>1 then begin
                   writeln('Aiuto : Ci sono ',vocali,' vocali nella parola');
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
      writeln('Inserisci una lettera oppure l',chr(039),'intera soluzione');
      readln(w);
      clrscr;
      writeln('La lettera inserita ',chr(138),' : ',w);
      writeln;

{l è il contarore delle lettere giuste, se =c, quindi tutta una parola hai vinto}
{cebra nella stringa quello messo, tipo: pippo  metto:  pippo mi da giusto perchè sono uguali.}
{questo sistema serve per confronfate 2 stringhe e vedere se sono uguali PAG 159 manuale Tramontana pascal}

      if w=a then begin
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
           {mettere end}
until (t=0) or (l=c);
end;

begin
     clrscr;
     centra;
     benvenuto;
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
     writeln('La parola era : ',a);
     writeln;
     punti:=10-t-(e*2);
     writeln;
     writeln('Hai ottenuto ',punti,' punti');
     if (t>0) and (l=c) then begin
                                  risultato_corretto;
                                  sound1;
                             end
     else begin
               risultato_errato;
               sound2;
          end;
readln;
end.
