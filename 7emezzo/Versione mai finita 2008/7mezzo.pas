program sette_e_mezzo_1_0;
uses crt,graph;
var
   mazzo:array[0..39] of real;
   i,pos,soldi1,soldi2,puntata1,puntata2:integer;
   carta1,carta2:real;
   totale1,totale2,totalex:real;
   scelta:string;
   errore,stop1,stop2,fine1,fine2:boolean;
   gd,gm:word;


procedure grafica;
begin
     detectgraph(gd,gm);
     initgraph(gd,gm,'');
end;

begin
   clrscr;
   grafica;

   puntata1:=0;
   puntata2:=0;
   totale2:=0;
   totale1:=0;

   {stampa il titolo}
   setcolor(lightgreen);
   settextstyle(GothicFont,Horizdir,8);
   outtextxy(300,100,'7 e mezzo');

   setcolor(lightmagenta);
   settextstyle(gothicfont,horizdir,8);
   outtextxy(800,100,'B1');

   setcolor(lightblue);
   settextstyle(gothicfont,horizdir,4);
   outtextxy(300,200,'Beta version');


   carta1:=0;
   carta2:=0;
   soldi1:=1000;
   soldi2:=1000;

   for i:=0 to 9 do mazzo[i]:=i+1;
   for i:=10 to 19 do mazzo[i]:=i-9;
   for i:=20 to 29 do mazzo[i]:=i-19;
   for i:=30 to 39 do mazzo[i]:=i-29;

   mazzo[7]:=0.5;
   mazzo[8]:=0.5;
   mazzo[9]:=0.5;

   mazzo[17]:=0.5;
   mazzo[18]:=0.5;
   mazzo[19]:=0.5;

   mazzo[27]:=0.5;
   mazzo[28]:=0.5;
   mazzo[29]:=0.5;

   mazzo[37]:=0.5;
   mazzo[38]:=0.5;
   mazzo[39]:=0.5;

   for i:=0 to 39 do write(' ',mazzo[i]:1:1,' ');
   readln;
   errore:=false;
   randomize;
repeat
repeat
repeat
   clrscr;
   writeln('Giocatore1');
   pos:=random(40);
   if mazzo[pos]<>0 then begin
                         carta1:=mazzo[pos];
                         mazzo[pos]:=0;
                         writeln(carta1:2:0);
                         if (pos<=9) then writeln('Picche');
                         if (pos<=19) and (pos>9) then writeln('Fiori');
                         if (pos<=29) and (pos>19) then writeln('Cuori');
                         if (pos<=39) and (pos>29) then writeln('Quadri');
                         errore:=false;
                         end
   else errore:=true;

   writeln('Quanto vuoi puntare?');
   readln(puntata1);
   if puntata1>soldi1 then writeln('Errore')
   else writeln('Puntata eseguita correttamente');

until errore=false;

   writeln;
   writeln;
   errore:=false;
   totale1:=totale1+carta1;
repeat
   writeln('Giocatore2');
   pos:=random(40);
   if mazzo[pos]<>0 then begin
                         carta2:=mazzo[pos];
                         mazzo[pos]:=0;
                         writeln(carta2:2:0);
                         if (pos<=9) then writeln('Picche');
                         if (pos<=19) and (pos>9) then writeln('Fiori');
                         if (pos<=29) and (pos>19) then writeln('Cuori');
                         if (pos<=39) and (pos>29) then writeln('Quadri');
                         errore:=false;
                         end
   else errore:=true;

   writeln('Quanto vuoi puntare?');
   readln(puntata1);
   if puntata1>soldi1 then writeln('Errore')
   else writeln('Puntata eseguita correttamente');

until errore=false;
stop1:=false;
stop2:=false;
repeat
   writeln;
   writeln('Giocatore1 vuoi una carta coperta [c] o scoperta [s]?');
   readln(scelta);

   errore:=false;
   if scelta='c' then begin
                       repeat
                         pos:=random(40);
                         if mazzo[pos]<>0 then begin
                         carta1:=mazzo[pos];
                         mazzo[pos]:=0;
                         writeln(carta1:2:1);
                         if (pos<=9) then writeln('Picche');
                         if (pos<=19) and (pos>9) then writeln('Fiori');
                         if (pos<=29) and (pos>19) then writeln('Cuori');
                         if (pos<=39) and (pos>29) then writeln('Quadri');
                         errore:=false;
                                                end
   else errore:=true;
                        until errore=false;
                      end;

   errore:=false;
   if scelta='s' then begin
     repeat
                      pos:=random(40);
                      if mazzo[pos]<>0 then begin
                         carta1:=mazzo[pos];
                         mazzo[pos]:=0;
                         writeln(carta1:2:1);
                         if (pos<=9) then writeln('Picche');
                         if (pos<=19) and (pos>9) then writeln('Fiori');
                         if (pos<=29) and (pos>19) then writeln('Cuori');
                         if (pos<=39) and (pos>29) then writeln('Quadri');
                         errore:=false;
                                            end
                       else errore:=true;
     until errore=false;
                      end;

   if (scelta<>'c') and (scelta<>'s') then begin
                                           stop1:=true;
                                           fine1:=true;
                                           totale1:=totale1-carta1;
                                           end;


   if totale1>=7.5 then fine1:=true;

   if totale1>7.5 then soldi1:=soldi1-puntata1;

   writeln(totale1:2:1);

until (totale1>=7.5) or (stop1=true);

repeat
   writeln;
   writeln('Giocatore2 vuoi una carta coperta [c] o scoperta [s]?');
   readln(scelta);
   writeln(totale2:2:1);
   errore:=false;
   if scelta='c' then begin
     repeat
                      pos:=random(40);
                      if mazzo[pos]<>0 then begin
                         carta2:=mazzo[pos];
                         mazzo[pos]:=0;
                         writeln(carta2:2:0);
                         if (pos<=9) then writeln('Picche');
                         if (pos<=19) and (pos>9) then writeln('Fiori');
                         if (pos<=29) and (pos>19) then writeln('Cuori');
                         if (pos<=39) and (pos>29) then writeln('Quadri');
                         errore:=false;
                                            end
                       else errore:=true;
     until errore=false;
                      end;

   errore:=false;
   if scelta='s' then begin
     repeat
                      pos:=random(40);
                      if mazzo[pos]<>0 then begin
                         carta2:=mazzo[pos];
                         mazzo[pos]:=0;
                         writeln(carta2:2:0);
                         if (pos<=9) then writeln('Picche');
                         if (pos<=19) and (pos>9) then writeln('Fiori');
                         if (pos<=29) and (pos>19) then writeln('Cuori');
                         if (pos<=39) and (pos>29) then writeln('Quadri');
                         errore:=false;
                                            end
                       else errore:=true;
     until errore=false;
                      end;
   writeln(totalex:2:1);
   if (scelta<>'c') and (scelta<>'s') then begin
                                           stop2:=true;
                                           fine2:=true;
                                           totalex:=totalex-carta2;
                                              writeln(totalex:2:1);
                                           end;

   writeln(totalex:2:1);
   totalex:=totalex+carta2;
   writeln(totalex:2:1);
   if totalex>=7.5 then fine2:=true;

   if totalex>7.5 then soldi2:=soldi2-puntata2;

   writeln('tot giocatore 2',totalex:2:1);
   writeln;
   writeln;
   writeln(fine1);
   writeln(fine2);
   writeln(totale1:2:1);
   writeln(totalex:2:1);

   delay(700);

until (totalex>=7.5) or (stop2=true);

until (fine1=true) and (fine2=true);

if (totale1>totalex) and (totale1<=7.5) then begin
                                             soldi1:=soldi1+(puntata1*2);
                                             soldi2:=soldi2-puntata2;
                                             end;
if (totalex>=totale1) and (totalex<=7.5) then begin
                                              soldi2:=soldi2+(puntata2*2);
                                              soldi2:=soldi2-puntata2;
                                              end;

   writeln('Giocatore 1 hai : ',soldi1);
   writeln('Giocatore 2 hai : ',soldi2);

   readln;

   carta1:=0;
   carta2:=0;
   totalex:=0;
   totale1:=0;
   puntata1:=0;
   puntata2:=0;

until (soldi1<=0) or (soldi2<=0);


   readln;
   closegraph;
end.

