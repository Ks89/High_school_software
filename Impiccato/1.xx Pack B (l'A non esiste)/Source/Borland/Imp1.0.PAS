program impiccato_1_0;
uses crt;
var
w,a:string;
vett:array[0..24] of char;
l,c,k,t,e,i:integer;
lett:char;
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

     textcolor(LightCyan);
     str:='IMPICCATO VERSION 1.0';
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
     writeln('Benvenuto nel gioco dell impiccato!!');
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
     writeln('Hai a disposizione al massimo 5 tentativi per indovinare la parola');
     writeln('Puoi commettere al massimo 5 errori');
     writeln;
     writeln('Premi invio per continuare');
     readln;
     clrscr;
     for i:=0 to c-1 do vett[i]:='_';
end;


procedure variabili;
begin
     writeln;
     writeln;
     t:=5;
     clrscr;
end;


procedure impiccato;
begin
{controllo e operazione di impiccaggione}
   repeat
     writeln('La parola è : ');
     writeln;
     writeln;
     writeln;
     gotoxy((80-c) div 2,wherey); {comando per centrare la parola coi trattini}
     for i:=0 to c-1 do begin
                       write(vett[i],' ');
                       delay(200);
                     end;
{controllo e o i della parola errore}
     if e=1 then lett:='e'
     else lett:='i';
     writeln;
     writeln;
     i:=0;
     trovato:=false;
     writeln;
     writeln;
     writeln('Hai a disposizione ancora ',t,' tentativi');
     writeln;
     writeln('Hai commesso ',e,' error',lett);
     writeln;
     writeln('Inserisci una lettera che ipotizzi che sia contenuta nella parola segreta oppure l intera soluzione');
     readln(w);
     clrscr;
     writeln('La lettera inserita Š : ',w);
     writeln;
     if w=a then begin
{questo sistema serve per confronfate 2 stringhe e vedere se sono uguali PAG 159 manuale Tramontana pascal}
                                                                         l:=c;
                                                                trovato:=true;
                                                                     end
     else begin
         if length(w)=1 then begin
                        for k:=0 to c do begin
                                      if upcase(w[1])=upcase(a[k]) then begin
                                                vett[k - 1]:=upcase(a[k]);
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
     clrscr;
     centra;
     benvenuto;
     parola;
     stampa_info;
     variabili;
     impiccato;

     writeln('Esito del gioco');
     writeln;
     writeln('Tentativi rimanenti : ',t);
     writeln('Errori commessi : ',e);
     writeln;
     writeln;
     writeln('La parola era : ',a);
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
readln;
end.
