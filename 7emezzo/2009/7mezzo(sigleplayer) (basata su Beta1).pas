program sette_e_mezzo_1_0;
uses crt,graph;
var
   mazzo:array[1..40] of real;
   carte1:array[1..15] of integer;
   carte2:array[1..15] of integer;

   pesca1:array[0..10] of char;
   pesca2:array[0..99] of char;
   pesca3:array[0..20] of char;

   p1,p2:real;
   gd,gm:word;
   name1,name2,pesca,ok:string;
   i,giro1,giro2,l,m,partite,soldi1,soldi2,soldi,x:integer;
   q,ax:integer; {variabili per far pescare a CPU}
   bugx001,player1ok,player2ok:boolean;

procedure grafica;
begin
     detectgraph(gd,gm);
     initgraph(gd,gm,'');
end;


procedure start_grafica;
begin

   grafica;

   {stampa il titolo}
   setcolor(lightgreen);
   settextstyle(GothicFont,Horizdir,8);
   outtextxy(300,100,'7 e mezzo');

   setcolor(lightmagenta);
   settextstyle(gothicfont,horizdir,8);
   outtextxy(1000,100,'B1');

   setcolor(lightblue);
   settextstyle(gothicfont,horizdir,4);
   outtextxy(300,200,'Beta version');

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
     str:='Anno 2008 (c)KS89';
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
     str:='7 e mezzo 1.0 Beta1';
     gotoxy((80-length(str)) div 2,wherey);
     writeln(str);
     textcolor(yellow);
     delay(1900);
     clrscr;

     textcolor(lightgreen);
     str:='Regole';
     gotoxy((80-length(str)) div 2,wherey);
     delay(500);
     writeln(str);
     writeln;
     writeln;
     textcolor(yellow);
     str:='Le figure valgono 0.5, i numeri il loro valore nominale';
     gotoxy((80-length(str)) div 2,wherey);
     delay(500);
     writeln(str);
     writeln;
     textcolor(yellow);
     str:='Vince chi si avvicina e non supera il valore: 7,5';
     gotoxy((80-length(str)) div 2,wherey);
     delay(500);
     writeln(str);
     writeln;
     textcolor(lightred);
     writeln('Premi un tasto per continuare');
     textcolor(lightmagenta);
     readln;
     textcolor(yellow);
     clrscr;
end;

procedure opzioni_partenza;
begin
repeat
   clrscr;
   textcolor(yellow);
   write('Giocatore 1 inserisci il tuo nome: ');
   textcolor(lightmagenta);
   readln(name1);
   writeln;
   writeln;
   writeln;
   writeln;
   textcolor(yellow);
   write('Giocatore 2 inserisci il tuo nome: ');
   textcolor(lightgreen);
   name2:='CPU';
   writeln;
   writeln;
   writeln;
   writeln;
   textcolor(lightmagenta);
   write(name1,' ');
   textcolor(yellow);
   write('e ');
   textcolor(lightgreen);
   write(name2,' ');
   textcolor(yellow);
   write('quante partite volete fare?: ');
   textcolor(white);
   readln(partite);
   clrscr;

   textcolor(lightmagenta);
   write(name1,' ');
   textcolor(yellow);
   write('e ');
   textcolor(lightgreen);
   write(name2,' ');
   textcolor(yellow);
   write('quanti soldi volete?: ');
   textcolor(white);
   readln(soldi);
   clrscr;

   textcolor(lightmagenta);
   write(name1,' ');
   textcolor(yellow);
   write('e ');
   textcolor(lightgreen);
   write(name2,' ');
   textcolor(yellow);
   write('avete a disposizione: ');
   textcolor(white);
   writeln(soldi,' euro');
   clrscr;
   textcolor(lightred);
   write('I dati inseriti sono corretti? Premi ');
   textcolor(white);
   write('s ');
   textcolor(lightred);
   write('per cofermare: ');
   textcolor(white);
   readln(ok);
until (ok='s') or (ok='S');
clrscr;
end;



procedure assegnaz1;
begin

if giro1=1 then begin
            for i:=1 to 7 do if carte1[giro1]=i then p1:=p1+i;       {giro1 indica qual'è l'ultima cifra inserita nell'array da controllare}
            for i:=11 to 17 do if carte1[giro1]=i then p1:=p1+i-10;
            for i:=21 to 27 do if carte1[giro1]=i then p1:=p1+i-20;
            for i:=31 to 37 do if carte1[giro1]=i then p1:=p1+i-30;

            for i:=8 to 10 do if carte1[giro1]=i then p1:=p1+0.5;       {questo serve per assegnare gli 0.5}
            for i:=18 to 20 do if carte1[giro1]=i then p1:=p1+0.5;
            for i:=28 to 30 do if carte1[giro1]=i then p1:=p1+0.5;
            for i:=38 to 40 do if carte1[giro1]=i then p1:=p1+0.5;
                 end;

if giro1=2 then begin
            for i:=1 to 7 do if carte1[giro1]=i then p1:=p1+i;
            for i:=11 to 17 do if carte1[giro1]=i then p1:=p1+i-10;
            for i:=21 to 27 do if carte1[giro1]=i then p1:=p1+i-20;
            for i:=31 to 37 do if carte1[giro1]=i then p1:=p1+i-30;

            for i:=8 to 10 do if carte1[giro1]=i then p1:=p1+0.5;
            for i:=18 to 20 do if carte1[giro1]=i then p1:=p1+0.5;
            for i:=28 to 30 do if carte1[giro1]=i then p1:=p1+0.5;
            for i:=38 to 40 do if carte1[giro1]=i then p1:=p1+0.5;
                 end;

if giro1=3 then begin
            for i:=1 to 7 do if carte1[giro1]=i then p1:=p1+i;
            for i:=11 to 17 do if carte1[giro1]=i then p1:=p1+i-10;
            for i:=21 to 27 do if carte1[giro1]=i then p1:=p1+i-20;
            for i:=31 to 37 do if carte1[giro1]=i then p1:=p1+i-30;

            for i:=8 to 10 do if carte1[giro1]=i then p1:=p1+0.5;
            for i:=18 to 20 do if carte1[giro1]=i then p1:=p1+0.5;
            for i:=28 to 30 do if carte1[giro1]=i then p1:=p1+0.5;
            for i:=38 to 40 do if carte1[giro1]=i then p1:=p1+0.5;
                 end;

if giro1=4 then begin
            for i:=1 to 7 do if carte1[giro1]=i then p1:=p1+i;
            for i:=11 to 17 do if carte1[giro1]=i then p1:=p1+i-10;
            for i:=21 to 27 do if carte1[giro1]=i then p1:=p1+i-20;
            for i:=31 to 37 do if carte1[giro1]=i then p1:=p1+i-30;

            for i:=8 to 10 do if carte1[giro1]=i then p1:=p1+0.5;
            for i:=18 to 20 do if carte1[giro1]=i then p1:=p1+0.5;
            for i:=28 to 30 do if carte1[giro1]=i then p1:=p1+0.5;
            for i:=38 to 40 do if carte1[giro1]=i then p1:=p1+0.5;
                 end;

if giro1=5 then begin
            for i:=1 to 7 do if carte1[giro1]=i then p1:=p1+i;
            for i:=11 to 17 do if carte1[giro1]=i then p1:=p1+i-10;
            for i:=21 to 27 do if carte1[giro1]=i then p1:=p1+i-20;
            for i:=31 to 37 do if carte1[giro1]=i then p1:=p1+i-30;

            for i:=8 to 10 do if carte1[giro1]=i then p1:=p1+0.5;
            for i:=18 to 20 do if carte1[giro1]=i then p1:=p1+0.5;
            for i:=28 to 30 do if carte1[giro1]=i then p1:=p1+0.5;
            for i:=38 to 40 do if carte1[giro1]=i then p1:=p1+0.5;
                 end;

if giro1=6 then begin
            for i:=1 to 7 do if carte1[giro1]=i then p1:=p1+i;
            for i:=11 to 17 do if carte1[giro1]=i then p1:=p1+i-10;
            for i:=21 to 27 do if carte1[giro1]=i then p1:=p1+i-20;
            for i:=31 to 37 do if carte1[giro1]=i then p1:=p1+i-30;

            for i:=8 to 10 do if carte1[giro1]=i then p1:=p1+0.5;
            for i:=18 to 20 do if carte1[giro1]=i then p1:=p1+0.5;
            for i:=28 to 30 do if carte1[giro1]=i then p1:=p1+0.5;
            for i:=38 to 40 do if carte1[giro1]=i then p1:=p1+0.5;
                 end;

if giro1=7 then begin
            for i:=1 to 7 do if carte1[giro1]=i then p1:=p1+i;
            for i:=11 to 17 do if carte1[giro1]=i then p1:=p1+i-10;
            for i:=21 to 27 do if carte1[giro1]=i then p1:=p1+i-20;
            for i:=31 to 37 do if carte1[giro1]=i then p1:=p1+i-30;

            for i:=8 to 10 do if carte1[giro1]=i then p1:=p1+0.5;
            for i:=18 to 20 do if carte1[giro1]=i then p1:=p1+0.5;
            for i:=28 to 30 do if carte1[giro1]=i then p1:=p1+0.5;
            for i:=38 to 40 do if carte1[giro1]=i then p1:=p1+0.5;
                 end;

if giro1=8 then begin
            for i:=1 to 7 do if carte1[giro1]=i then p1:=p1+i;
            for i:=11 to 17 do if carte1[giro1]=i then p1:=p1+i-10;
            for i:=21 to 27 do if carte1[giro1]=i then p1:=p1+i-20;
            for i:=31 to 37 do if carte1[giro1]=i then p1:=p1+i-30;

            for i:=8 to 10 do if carte1[giro1]=i then p1:=p1+0.5;
            for i:=18 to 20 do if carte1[giro1]=i then p1:=p1+0.5;
            for i:=28 to 30 do if carte1[giro1]=i then p1:=p1+0.5;
            for i:=38 to 40 do if carte1[giro1]=i then p1:=p1+0.5;
                 end;

if giro1=9 then begin
            for i:=1 to 7 do if carte1[giro1]=i then p1:=p1+i;
            for i:=11 to 17 do if carte1[giro1]=i then p1:=p1+i-10;
            for i:=21 to 27 do if carte1[giro1]=i then p1:=p1+i-20;
            for i:=31 to 37 do if carte1[giro1]=i then p1:=p1+i-30;

            for i:=8 to 10 do if carte1[giro1]=i then p1:=p1+0.5;
            for i:=18 to 20 do if carte1[giro1]=i then p1:=p1+0.5;
            for i:=28 to 30 do if carte1[giro1]=i then p1:=p1+0.5;
            for i:=38 to 40 do if carte1[giro1]=i then p1:=p1+0.5;
                 end;

if giro1=10 then begin
            for i:=1 to 7 do if carte1[giro1]=i then p1:=p1+i;
            for i:=11 to 17 do if carte1[giro1]=i then p1:=p1+i-10;
            for i:=21 to 27 do if carte1[giro1]=i then p1:=p1+i-20;
            for i:=31 to 37 do if carte1[giro1]=i then p1:=p1+i-30;

            for i:=8 to 10 do if carte1[giro1]=i then p1:=p1+0.5;
            for i:=18 to 20 do if carte1[giro1]=i then p1:=p1+0.5;
            for i:=28 to 30 do if carte1[giro1]=i then p1:=p1+0.5;
            for i:=38 to 40 do if carte1[giro1]=i then p1:=p1+0.5;
                 end;

if giro1=11 then begin
            for i:=1 to 7 do if carte1[giro1]=i then p1:=p1+i;
            for i:=11 to 17 do if carte1[giro1]=i then p1:=p1+i-10;
            for i:=21 to 27 do if carte1[giro1]=i then p1:=p1+i-20;
            for i:=31 to 37 do if carte1[giro1]=i then p1:=p1+i-30;

            for i:=8 to 10 do if carte1[giro1]=i then p1:=p1+0.5;
            for i:=18 to 20 do if carte1[giro1]=i then p1:=p1+0.5;
            for i:=28 to 30 do if carte1[giro1]=i then p1:=p1+0.5;
            for i:=38 to 40 do if carte1[giro1]=i then p1:=p1+0.5;
                 end;

if giro1=12 then begin
            for i:=1 to 7 do if carte1[giro1]=i then p1:=p1+i;
            for i:=11 to 17 do if carte1[giro1]=i then p1:=p1+i-10;
            for i:=21 to 27 do if carte1[giro1]=i then p1:=p1+i-20;
            for i:=31 to 37 do if carte1[giro1]=i then p1:=p1+i-30;

            for i:=8 to 10 do if carte1[giro1]=i then p1:=p1+0.5;
            for i:=18 to 20 do if carte1[giro1]=i then p1:=p1+0.5;
            for i:=28 to 30 do if carte1[giro1]=i then p1:=p1+0.5;
            for i:=38 to 40 do if carte1[giro1]=i then p1:=p1+0.5;
                 end;

if giro1=13 then begin
            for i:=1 to 7 do if carte1[giro1]=i then p1:=p1+i;
            for i:=11 to 17 do if carte1[giro1]=i then p1:=p1+i-10;
            for i:=21 to 27 do if carte1[giro1]=i then p1:=p1+i-20;
            for i:=31 to 37 do if carte1[giro1]=i then p1:=p1+i-30;

            for i:=8 to 10 do if carte1[giro1]=i then p1:=p1+0.5;
            for i:=18 to 20 do if carte1[giro1]=i then p1:=p1+0.5;
            for i:=28 to 30 do if carte1[giro1]=i then p1:=p1+0.5;
            for i:=38 to 40 do if carte1[giro1]=i then p1:=p1+0.5;
                 end;
     writeln;
     textcolor(lightmagenta);
     write(name1);
     textcolor(yellow);
     writeln(' ',p1:1:1);
end;



procedure assegnaz2;
begin

if giro2=1 then begin
            for i:=1 to 7 do if carte2[giro2]=i then p2:=p2+i;       {giro2 indica qual'è l'ultima cifra inserita nell'array da controllare}
            for i:=11 to 17 do if carte2[giro2]=i then p2:=p2+i-10;
            for i:=21 to 27 do if carte2[giro2]=i then p2:=p2+i-20;
            for i:=31 to 37 do if carte2[giro2]=i then p2:=p2+i-30;

            for i:=8 to 10 do if carte2[giro2]=i then p2:=p2+0.5;       {questo serve per assegnare gli 0.5}
            for i:=18 to 20 do if carte2[giro2]=i then p2:=p2+0.5;
            for i:=28 to 30 do if carte2[giro2]=i then p2:=p2+0.5;
            for i:=38 to 40 do if carte2[giro2]=i then p2:=p2+0.5;
                 end;

if giro2=2 then begin
            for i:=1 to 7 do if carte2[giro2]=i then p2:=p2+i;
            for i:=11 to 17 do if carte2[giro2]=i then p2:=p2+i-10;
            for i:=21 to 27 do if carte2[giro2]=i then p2:=p2+i-20;
            for i:=31 to 37 do if carte2[giro2]=i then p2:=p2+i-30;

            for i:=8 to 10 do if carte2[giro2]=i then p2:=p2+0.5;
            for i:=18 to 20 do if carte2[giro2]=i then p2:=p2+0.5;
            for i:=28 to 30 do if carte2[giro2]=i then p2:=p2+0.5;
            for i:=38 to 40 do if carte2[giro2]=i then p2:=p2+0.5;
                 end;

if giro2=3 then begin
            for i:=1 to 7 do if carte2[giro2]=i then p2:=p2+i;
            for i:=11 to 17 do if carte2[giro2]=i then p2:=p2+i-10;
            for i:=21 to 27 do if carte2[giro2]=i then p2:=p2+i-20;
            for i:=31 to 37 do if carte2[giro2]=i then p2:=p2+i-30;

            for i:=8 to 10 do if carte2[giro2]=i then p2:=p2+0.5;
            for i:=18 to 20 do if carte2[giro2]=i then p2:=p2+0.5;
            for i:=28 to 30 do if carte2[giro2]=i then p2:=p2+0.5;
            for i:=38 to 40 do if carte2[giro2]=i then p2:=p2+0.5;
                 end;

if giro2=4 then begin
            for i:=1 to 7 do if carte2[giro2]=i then p2:=p2+i;
            for i:=11 to 17 do if carte2[giro2]=i then p2:=p2+i-10;
            for i:=21 to 27 do if carte2[giro2]=i then p2:=p2+i-20;
            for i:=31 to 37 do if carte2[giro2]=i then p2:=p2+i-30;

            for i:=8 to 10 do if carte2[giro2]=i then p2:=p2+0.5;
            for i:=18 to 20 do if carte2[giro2]=i then p2:=p2+0.5;
            for i:=28 to 30 do if carte2[giro2]=i then p2:=p2+0.5;
            for i:=38 to 40 do if carte2[giro2]=i then p2:=p2+0.5;
                 end;

if giro2=5 then begin
            for i:=1 to 7 do if carte2[giro2]=i then p2:=p2+i;
            for i:=11 to 17 do if carte2[giro2]=i then p2:=p2+i-10;
            for i:=21 to 27 do if carte2[giro2]=i then p2:=p2+i-20;
            for i:=31 to 37 do if carte2[giro2]=i then p2:=p2+i-30;

            for i:=8 to 10 do if carte2[giro2]=i then p2:=p2+0.5;
            for i:=18 to 20 do if carte2[giro2]=i then p2:=p2+0.5;
            for i:=28 to 30 do if carte2[giro2]=i then p2:=p2+0.5;
            for i:=38 to 40 do if carte2[giro2]=i then p2:=p2+0.5;
                 end;

if giro2=6 then begin
            for i:=1 to 7 do if carte2[giro2]=i then p2:=p2+i;
            for i:=11 to 17 do if carte2[giro2]=i then p2:=p2+i-10;
            for i:=21 to 27 do if carte2[giro2]=i then p2:=p2+i-20;
            for i:=31 to 37 do if carte2[giro2]=i then p2:=p2+i-30;

            for i:=8 to 10 do if carte2[giro2]=i then p2:=p2+0.5;
            for i:=18 to 20 do if carte2[giro2]=i then p2:=p2+0.5;
            for i:=28 to 30 do if carte2[giro2]=i then p2:=p2+0.5;
            for i:=38 to 40 do if carte2[giro2]=i then p2:=p2+0.5;
                 end;

if giro2=7 then begin
            for i:=1 to 7 do if carte2[giro2]=i then p2:=p2+i;
            for i:=11 to 17 do if carte2[giro2]=i then p2:=p2+i-10;
            for i:=21 to 27 do if carte2[giro2]=i then p2:=p2+i-20;
            for i:=31 to 37 do if carte2[giro2]=i then p2:=p2+i-30;

            for i:=8 to 10 do if carte2[giro2]=i then p2:=p2+0.5;
            for i:=18 to 20 do if carte2[giro2]=i then p2:=p2+0.5;
            for i:=28 to 30 do if carte2[giro2]=i then p2:=p2+0.5;
            for i:=38 to 40 do if carte2[giro2]=i then p2:=p2+0.5;
                 end;

if giro2=8 then begin
            for i:=1 to 7 do if carte2[giro2]=i then p2:=p2+i;
            for i:=11 to 17 do if carte2[giro2]=i then p2:=p2+i-10;
            for i:=21 to 27 do if carte2[giro2]=i then p2:=p2+i-20;
            for i:=31 to 37 do if carte2[giro2]=i then p2:=p2+i-30;

            for i:=8 to 10 do if carte2[giro2]=i then p2:=p2+0.5;
            for i:=18 to 20 do if carte2[giro2]=i then p2:=p2+0.5;
            for i:=28 to 30 do if carte2[giro2]=i then p2:=p2+0.5;
            for i:=38 to 40 do if carte2[giro2]=i then p2:=p2+0.5;
                 end;

if giro2=9 then begin
            for i:=1 to 7 do if carte2[giro2]=i then p2:=p2+i;
            for i:=11 to 17 do if carte2[giro2]=i then p2:=p2+i-10;
            for i:=21 to 27 do if carte2[giro2]=i then p2:=p2+i-20;
            for i:=31 to 37 do if carte2[giro2]=i then p2:=p2+i-30;

            for i:=8 to 10 do if carte2[giro2]=i then p2:=p2+0.5;
            for i:=18 to 20 do if carte2[giro2]=i then p2:=p2+0.5;
            for i:=28 to 30 do if carte2[giro2]=i then p2:=p2+0.5;
            for i:=38 to 40 do if carte2[giro2]=i then p2:=p2+0.5;
                 end;

if giro2=10 then begin
            for i:=1 to 7 do if carte2[giro2]=i then p2:=p2+i;
            for i:=11 to 17 do if carte2[giro2]=i then p2:=p2+i-10;
            for i:=21 to 27 do if carte2[giro2]=i then p2:=p2+i-20;
            for i:=31 to 37 do if carte2[giro2]=i then p2:=p2+i-30;

            for i:=8 to 10 do if carte2[giro2]=i then p2:=p2+0.5;
            for i:=18 to 20 do if carte2[giro2]=i then p2:=p2+0.5;
            for i:=28 to 30 do if carte2[giro2]=i then p2:=p2+0.5;
            for i:=38 to 40 do if carte2[giro2]=i then p2:=p2+0.5;
                 end;

if giro2=11 then begin
            for i:=1 to 7 do if carte2[giro2]=i then p2:=p2+i;
            for i:=11 to 17 do if carte2[giro2]=i then p2:=p2+i-10;
            for i:=21 to 27 do if carte2[giro2]=i then p2:=p2+i-20;
            for i:=31 to 37 do if carte2[giro2]=i then p2:=p2+i-30;

            for i:=8 to 10 do if carte2[giro2]=i then p2:=p2+0.5;
            for i:=18 to 20 do if carte2[giro2]=i then p2:=p2+0.5;
            for i:=28 to 30 do if carte2[giro2]=i then p2:=p2+0.5;
            for i:=38 to 40 do if carte2[giro2]=i then p2:=p2+0.5;
                 end;

if giro2=12 then begin
            for i:=1 to 7 do if carte2[giro2]=i then p2:=p2+i;
            for i:=11 to 17 do if carte2[giro2]=i then p2:=p2+i-10;
            for i:=21 to 27 do if carte2[giro2]=i then p2:=p2+i-20;
            for i:=31 to 37 do if carte2[giro2]=i then p2:=p2+i-30;

            for i:=8 to 10 do if carte2[giro2]=i then p2:=p2+0.5;
            for i:=18 to 20 do if carte2[giro2]=i then p2:=p2+0.5;
            for i:=28 to 30 do if carte2[giro2]=i then p2:=p2+0.5;
            for i:=38 to 40 do if carte2[giro2]=i then p2:=p2+0.5;
                 end;

if giro2=13 then begin
            for i:=1 to 7 do if carte2[giro2]=i then p2:=p2+i;
            for i:=11 to 17 do if carte2[giro2]=i then p2:=p2+i-10;
            for i:=21 to 27 do if carte2[giro2]=i then p2:=p2+i-20;
            for i:=31 to 37 do if carte2[giro2]=i then p2:=p2+i-30;

            for i:=8 to 10 do if carte2[giro2]=i then p2:=p2+0.5;
            for i:=18 to 20 do if carte2[giro2]=i then p2:=p2+0.5;
            for i:=28 to 30 do if carte2[giro2]=i then p2:=p2+0.5;
            for i:=38 to 40 do if carte2[giro2]=i then p2:=p2+0.5;
                 end;

     writeln;
     textcolor(lightgreen);
     write(name2);
     textcolor(yellow);
     writeln(' ',p2:1:1);

end;

procedure controllo_bug1;
{------------------------------------------sistema rilevamento bug x001, cioè carte doppie nel mazzo----------------------------------------}
begin
for l:=1 to 15 do begin
                  for m:=1 to 15 do if (carte1[l]=carte2[m]) and (carte1[l]<>0) and (carte2[m]<>0) then begin
                                                                   writeln('Rilevato bug: Errore "x001". Comunicare il problema a Ks89');
                                                                   bugx001:=true;
                                                                                                        end;
                  end;
{--------------------------------------------------------------------------------------------------------------------------------------------}
end;




begin
   clrscr;
   delay(1000);
   start_grafica;
   centra;
   p1:=0;
   P2:=0;
   bugx001:=false;

   textcolor(yellow);

   for i:=1 to 10 do mazzo[i]:=i;
   for i:=10 to 19 do mazzo[i]:=i-10;
   for i:=20 to 29 do mazzo[i]:=i-20;
   for i:=30 to 39 do mazzo[i]:=i-30;

   mazzo[8]:=0.5;
   mazzo[9]:=0.5;
   mazzo[10]:=0.5;

   mazzo[18]:=0.5;
   mazzo[19]:=0.5;
   mazzo[20]:=0.5;

   mazzo[28]:=0.5;
   mazzo[29]:=0.5;
   mazzo[30]:=0.5;

   mazzo[38]:=0.5;
   mazzo[39]:=0.5;
   mazzo[40]:=0.5;

   for i:=1 to 15 do carte1[i]:=0;
   for i:=1 to 15 do carte2[i]:=0;

   randomize;

   opzioni_partenza;

   textcolor(yellow);
   x:=0;

repeat          {questo repeat è quello che fa terminare il gioco se ho fatto tot partite quante sono quelle scelte per il torneo}

    player1ok:=false;
    player2ok:=false;
    p1:=0;           {resetto il valore delle carte ogni turno}
    p2:=0;

repeat
	carte1[1]:=random(39)+1;
	carte2[1]:=random(39)+1;
	writeln(carte1[1]);
	writeln(carte2[1]);
until carte1[1]<>carte2[1];

giro1:=1;
giro2:=1;
assegnaz1;
assegnaz2;

repeat

if player1ok=false then begin     {questo mi assicura che ogni partita il giocatore 1 dopo aver giocato non possa più pescare altre carte, per sicurezza}
                                                          {questo sembra inutile ma mi permette di togliere uno strano bug che non saprei come eliminare se no}
writeln;
textcolor(lightmagenta);
write(name1,' ');
textcolor(yellow);
write('vuoi pescare una carta? ');
textcolor(white);
write('s ');
textcolor(yellow);
write('per confermare: ');
textcolor(lightmagenta);
readln(pesca);
textcolor(yellow);

if pesca='S' then pesca:='s';

if (pesca='s') and (giro1=1) then begin
                  pesca:='';
                  repeat
                        carte1[2]:=random(39)+1;
                  until carte1[2]<>carte1[1];
                  giro1:=2;
                  assegnaz1;
                  end;



if (pesca='s') and (giro1=2) then begin
                  pesca:='';
                  repeat
                        carte1[3]:=random(39)+1;
                  until (carte1[3]<>carte1[2]) and (carte1[3]<>carte1[1]);
                  giro1:=3;
                  assegnaz1;
                  end;


if (pesca='s') and (giro1=3) then begin
                  pesca:='';
                  repeat
                        carte1[4]:=random(39)+1;
                  until (carte1[4]<>carte1[1]) and (carte1[4]<>carte1[2]) and (carte1[4]<>carte1[3]);
                  giro1:=4;
                  assegnaz1;
                  end;


if (pesca='s') and (giro1=4) then begin
                  pesca:='';
                  repeat
                        carte1[5]:=random(39)+1;
                  until (carte1[5]<>carte1[1]) and (carte1[5]<>carte1[2]) and (carte1[5]<>carte1[3]) and (carte1[5]<>carte1[4]);
                  giro1:=5;
                  assegnaz1;
                  end;

if (pesca='s') and (giro1=5) then begin
                  pesca:='';
                  repeat
                        carte1[6]:=random(39)+1;
                  until (carte1[6]<>carte1[1]) and (carte1[6]<>carte1[2]) and (carte1[6]<>carte1[3]) and (carte1[6]<>carte1[4]) and (carte1[6]<>carte1[5]);
                  giro1:=6;
                  assegnaz1;
                  end;

if (pesca='s') and (giro1=6) then begin
                  pesca:='';
                  repeat
                        carte1[7]:=random(39)+1;
                  until (carte1[7]<>carte1[1]) and (carte1[7]<>carte1[2]) and (carte1[7]<>carte1[3]) and (carte1[7]<>carte1[4]) and (carte1[7]<>carte1[5]) and (carte1[7]<>carte1[6]);
                  giro1:=7;
                  assegnaz1;
                  end;


if (pesca='s') and (giro1=7) then begin
                  pesca:='';
                  repeat
                        carte1[8]:=random(39)+1;
                  until (carte1[8]<>carte1[1]) and (carte1[8]<>carte1[2]) and (carte1[8]<>carte1[3]) and (carte1[8]<>carte1[4]) and (carte1[8]<>carte1[5]) and (carte1[8]<>carte1[6]) and (carte1[8]<>carte1[7]);
                  giro1:=8;
                  assegnaz1;
                  end;


if (pesca='s') and (giro1=8) then begin
                  pesca:='';
                  repeat
                        carte1[9]:=random(39)+1;
                  until (carte1[9]<>carte1[1]) and (carte1[9]<>carte1[2]) and (carte1[9]<>carte1[3]) and (carte1[9]<>carte1[4]) and (carte1[9]<>carte1[5]) and (carte1[9]<>carte1[6]) and (carte1[9]<>carte1[7]) and (carte1[9]<>carte1[8]);
                  giro1:=9;
                  assegnaz1;
                  end;

if (pesca='s') and (giro1=9) then begin
                  pesca:='';
                  repeat
                        carte1[10]:=random(39)+1;
                  until (carte1[10]<>carte1[1]) and (carte1[10]<>carte1[2]) and (carte1[10]<>carte1[3]) and (carte1[10]<>carte1[4]) and (carte1[10]<>carte1[5]) and (carte1[10]<>carte1[6]) and (carte1[10]<>carte1[7]) and (carte1[10]<>carte1[8]) and (carte1[10]<>carte1[9]);
                  giro1:=10;
                  assegnaz1;
                  end;

if (pesca='s') and (giro1=10) then begin
                  pesca:='';
                  repeat
                        carte1[11]:=random(39)+1;
                  until (carte1[11]<>carte1[1]) and (carte1[11]<>carte1[2]) and (carte1[11]<>carte1[3]) and (carte1[11]<>carte1[4]) and (carte1[11]<>carte1[5]) and (carte1[11]<>carte1[6]) and (carte1[11]<>carte1[7]) and (carte1[11]<>carte1[8]) and (carte1[11]<>carte1[9]) and (carte1[11]<>carte1[10]);
                  giro1:=11;
                  assegnaz1;
                  end;


if (pesca='s') and (giro1=11) then begin
                  pesca:='';
                  repeat
                        carte1[12]:=random(39)+1;
                  until (carte1[12]<>carte1[1]) and (carte1[12]<>carte1[2]) and (carte1[13]<>carte1[3]) and (carte1[13]<>carte1[4]) and (carte1[13]<>carte1[5]) and (carte1[13]<>carte1[6]) and (carte1[12]<>carte1[7]) and (carte1[12]<>carte1[8]) and (carte1[12]<>carte1[9]) and (carte1[12]<>carte1[10]) and (carte1[12]<>carte1[11]);
                  giro1:=12;
                  assegnaz1;
                  end;

if (pesca='s') and (giro1=12) then begin
                  pesca:='';
                  repeat
                        carte1[13]:=random(39)+1;
                  until (carte1[13]<>carte1[1]) and (carte1[13]<>carte1[2]) and (carte1[13]<>carte1[3]) and (carte1[13]<>carte1[4]) and (carte1[13]<>carte1[5]) and (carte1[13]<>carte1[6]) and (carte1[13]<>carte1[7]) and (carte1[13]<>carte1[8]) and (carte1[13]<>carte1[9]) and (carte1[13]<>carte1[10]) and (carte1[13]<>carte1[11]) and (carte1[13]<>carte1[12]);
                  giro1:=13;
                  assegnaz1;
                  end;
                  end; {questo end chiude l'if che ho messo subito all'inizio del repeat}
until (p1=7.5) or (p1>7.5) or (pesca='n');

player1ok:=true;               {dato che pleayer1 ormai ha finito il suo turno metto questa variabile a true, e solo se è false il giocatore può giocare}

writeln;
writeln('carte pescate da player1');
writeln;                                                                                                                                                {sta frase fa un po' cagare}
for i:=1 to 15 do write(' ',carte1[i]);

writeln;

textcolor(cyan);
writeln('----------------------------------------');
writeln;
writeln;
                              {qui inzia CPU, però per ora faccio controllo su p1, cosa che poi non dovrà esserci, perchè gioc2 non può sapere quello
                              che ho totalizzato io. Quindi il controllo sarà fatto solo sulla somma delle carte visibili}


repeat

if player2ok=false then begin

{------------------------Metodo pesca automatica del PC, basandosi su p1, difficolta' HARD---------------------}

if (p1=7) and (p2<7) then pesca:='s';                {in questo caso pesco sempre, tanto non ho nullada per perdere. Impo togliere sta condizione appena non si fa if su p2, ma su somma carte scoperte}

if (p1=7) and (p2<6) then begin
                           for q:=0 to 9 do pesca1[q]:='s';     {prob pescare 80%}
                           for q:=8 to 9 do pesca1[q]:='_';
                           pesca:=pesca1[random(9)];
                      end;

if (((p1=6.5) or (p1=6)) and (p2<5.5)) then begin                     {prob pescare 90%}
                           for q:=0 to 9 do pesca1[q]:='s';
                           pesca1[9]:='_';
                           pesca:=pesca1[random(9)];
                                      end;

if p1<=5.5 then begin
                     if p2<5 then begin
                                       for q:=0 to 9 do pesca1[q]:='s';      {prob pescare 90%}
                                       pesca1[9]:='_';
                                       pesca:=pesca1[random(9)];
                                  end;

                     if p2=5 then begin
                                       for q:=0 to 99 do pesca2[q]:='s';      {prob pescare circa 55%}
                                       for q:=55 to 99 do pesca2[q]:='_';
                                       pesca:=pesca2[random(9)];
                                  end;

                     if p2=5.5 then begin
                                       for q:=0 to 9 do pesca1[q]:='s';      {prob pescare 40%}
                                       for q:=4 to 9 do pesca1[q]:='_';
                                       pesca:=pesca1[random(9)];
                                  end;

                     if p2=6 then begin
                                       for q:=0 to 9 do pesca1[q]:='s';      {prob pescare 20%}
                                       for q:=0 to 7 do pesca1[q]:='_';
                                       pesca:=pesca1[random(9)];
                                  end;

                     if p2=6.5 then begin
                                       for q:=0 to 9 do pesca1[q]:='s';      {prob pescare 10%}
                                       for q:=0 to 8 do pesca1[q]:='_';
                                       pesca:=pesca1[random(9)];
                                  end;

                     if p2=7 then pesca:='n';


                     if p2=7.5 then pesca:='n';
                end;

if (p2=6) and (p1<>7.5) then begin
                  if p1<=5 then pesca:='s';
                  if p1=5.5 then begin
                                      ax:=random(2);
                                      if ax=0 then pesca:='s';
                                      if ax<>0 then pesca:='n';
                                 end;
                  if p1=6  then pesca:='n';
                  if p1=6.5 then pesca:='s';
                  if p1=7 then pesca:='s';
                  if p1=7.5 then pesca:='n';
             end;

if (p2=6.5) or (p2=7) or (p2=7.5) or (p1>7.5) then pesca:='n';

if p1=7.5 then pesca:='n';

if (p2>p1) then pesca:='n';


{----------------------------------------------------------------------------------}


if pesca='S' then pesca:='s';

if (pesca='s') and (giro2=1) then begin
                  pesca:='';
                  repeat
                        carte2[2]:=random(39)+1;
                  until (carte2[2]<>carte2[1]) and (carte2[2]<>carte1[1]) and (carte2[2]<>carte1[2]);
                  giro2:=2;
                  assegnaz2;
                  end;



if (pesca='s') and (giro2=2) then begin
                  pesca:='';
                  repeat
                        carte2[3]:=random(39)+1;
                  until (carte2[3]<>carte2[1]) and (carte2[3]<>carte2[2]) and (carte2[3]<>carte1[1]) and (carte2[3]<>carte1[2]) and (carte2[3]<>carte1[3]);
                  giro2:=3;
                  assegnaz2;
                  end;


if (pesca='s') and (giro2=3) then begin
                  pesca:='';
                  repeat
                        carte2[4]:=random(39)+1;
                  until (carte2[4]<>carte2[1]) and (carte2[4]<>carte2[2]) and (carte2[4]<>carte2[3]) and (carte2[4]<>carte1[1]) and (carte2[4]<>carte1[2]) and (carte2[4]<>carte1[3]) and (carte2[4]<>carte1[4]);
                  giro2:=4;
                  assegnaz2;
                  end;


if (pesca='s') and (giro2=4) then begin
                  pesca:='';
                  repeat
                        carte2[5]:=random(39)+1;
                  until (carte2[5]<>carte2[1]) and (carte2[5]<>carte2[2]) and (carte2[5]<>carte2[3]) and (carte2[5]<>carte2[4]) and (carte2[5]<>carte1[1]) and (carte2[5]<>carte1[2]) and (carte2[5]<>carte1[3]) and (carte2[5]<>carte1[4]) and (carte2[5]<>carte1[5]);
                  giro2:=5;
                  assegnaz2;
                  end;

if (pesca='s') and (giro2=5) then begin
                  pesca:='';
                  repeat
                        carte2[6]:=random(39)+1;
                  until (carte2[6]<>carte2[1]) and (carte2[6]<>carte2[2]) and (carte2[6]<>carte2[3]) and (carte2[6]<>carte2[4]) and (carte2[6]<>carte2[5]) and (carte2[6]<>carte1[1]) and (carte2[6]<>carte1[2]) and (carte2[6]<>carte1[3]) and (carte2[6]<>carte1[4]) and (carte2[6]<>carte1[5]) and (carte2[6]<>carte1[6]);
                  giro2:=6;
                  assegnaz2;
                  end;

if (pesca='s') and (giro2=6) then begin
                  pesca:='';
                  repeat
                        carte2[7]:=random(39)+1;
                  until (carte2[7]<>carte2[1]) and (carte2[7]<>carte2[2]) and (carte2[7]<>carte2[3]) and (carte2[7]<>carte2[4]) and (carte2[7]<>carte2[5]) and (carte2[7]<>carte2[6]) and (carte2[7]<>carte1[1]) and (carte2[7]<>carte1[2]) and (carte2[7]<>carte1[3]) and (carte2[7]<>carte1[4]) and (carte2[7]<>carte1[5]) and (carte2[7]<>carte1[6]) and (carte2[7]<>carte1[7]);
                  giro2:=7;
                  assegnaz2;
                  end;


if (pesca='s') and (giro2=7) then begin
                  pesca:='';
                  repeat
                        carte2[8]:=random(39)+1;
                  until (carte2[8]<>carte2[1]) and (carte2[8]<>carte2[2]) and (carte2[8]<>carte2[3]) and (carte2[8]<>carte2[4]) and (carte2[8]<>carte2[5]) and (carte2[8]<>carte2[6]) and (carte2[8]<>carte2[7]) and (carte2[8]<>carte1[1]) and (carte2[8]<>carte1[2]) and (carte2[8]<>carte1[3]) and (carte2[8]<>carte1[4]) and (carte2[8]<>carte1[5]) and (carte2[8]<>carte1[6]) and (carte2[8]<>carte1[7]) and (carte2[8]<>carte1[8]);
                  giro2:=8;
                  assegnaz2;
                  end;


if (pesca='s') and (giro2=8) then begin
                  pesca:='';
                  repeat
                        carte2[9]:=random(39)+1;
                  until (carte2[9]<>carte2[1]) and (carte2[9]<>carte2[2]) and (carte2[9]<>carte2[3]) and (carte2[9]<>carte2[4]) and (carte2[9]<>carte2[5]) and (carte2[9]<>carte2[6]) and (carte2[9]<>carte2[7]) and (carte2[9]<>carte2[8]) and (carte2[9]<>carte1[1]) and (carte2[9]<>carte1[2]) and (carte2[9]<>carte1[3]) and (carte2[9]<>carte1[4]) and (carte2[9]<>carte1[5]) and (carte2[9]<>carte1[6]) and (carte2[9]<>carte1[7]) and (carte2[9]<>carte1[8]) and (carte2[9]<>carte1[9]);
                  giro2:=9;
                  assegnaz2;
                  end;

if (pesca='s') and (giro2=9) then begin
                  pesca:='';
                  repeat
                        carte2[10]:=random(39)+1;
                  until (carte2[10]<>carte2[1]) and (carte2[10]<>carte2[2]) and (carte2[10]<>carte2[3]) and (carte2[10]<>carte2[4]) and (carte2[10]<>carte2[5]) and (carte2[10]<>carte2[6]) and (carte2[10]<>carte2[7]) and (carte2[10]<>carte2[8]) and (carte2[10]<>carte2[9]) and (carte2[10]<>carte1[1]) and (carte2[10]<>carte1[2]) and (carte2[10]<>carte1[3]) and (carte2[10]<>carte1[4]) and (carte2[10]<>carte1[5]) and (carte2[10]<>carte1[6]) and (carte2[10]<>carte1[7]) and (carte2[10]<>carte1[8]) and (carte2[10]<>carte1[9]) and (carte2[10]<>carte1[10]);
                  giro2:=10;
                  assegnaz2;
                  end;

if (pesca='s') and (giro2=10) then begin
                  pesca:='';
                  repeat
                        carte2[11]:=random(39)+1;
                  until (carte2[11]<>carte2[1]) and (carte2[11]<>carte2[2]) and (carte2[11]<>carte2[3]) and (carte2[11]<>carte2[4]) and (carte2[11]<>carte2[5]) and (carte2[11]<>carte2[6]) and (carte2[11]<>carte2[7]) and (carte2[11]<>carte2[8]) and (carte2[11]<>carte2[9]) and (carte2[11]<>carte2[10]) and (carte2[11]<>carte1[1]) and (carte2[11]<>carte1[2]) and (carte2[11]<>carte1[3]) and (carte2[11]<>carte1[4]) and (carte2[11]<>carte1[5]) and (carte2[11]<>carte1[6]) and (carte2[11]<>carte1[7]) and (carte2[11]<>carte1[8]) and (carte2[11]<>carte1[9]) and (carte2[11]<>carte1[10]) and (carte2[11]<>carte1[11]);
                  giro2:=11;
                  assegnaz2;
                  end;


if (pesca='s') and (giro2=11) then begin
                  pesca:='';
                  repeat
                        carte2[12]:=random(39)+1;
                  until (carte2[12]<>carte2[1]) and (carte2[12]<>carte2[2]) and (carte2[13]<>carte2[3]) and (carte2[13]<>carte2[4]) and (carte2[13]<>carte2[5]) and (carte2[13]<>carte2[6]) and (carte2[12]<>carte2[7]) and (carte2[12]<>carte2[8]) and (carte2[12]<>carte2[9]) and (carte2[12]<>carte2[10]) and (carte2[12]<>carte2[11]) and (carte2[12]<>carte1[1]) and (carte2[12]<>carte1[2]) and (carte2[12]<>carte1[3]) and (carte2[12]<>carte1[4]) and (carte2[12]<>carte1[5]) and (carte2[12]<>carte1[6]) and (carte2[12]<>carte1[7]) and (carte2[12]<>carte1[8]) and (carte2[12]<>carte1[9]) and (carte2[12]<>carte1[10]) and (carte2[12]<>carte1[11]) and (carte2[12]<>carte1[12]);
                  giro2:=12;
                  assegnaz2;
                  end;

if (pesca='s') and (giro2=12) then begin
                  pesca:='';
                  repeat
                        carte2[13]:=random(39)+1;
                  until (carte2[13]<>carte2[1]) and (carte2[13]<>carte2[2]) and (carte2[13]<>carte2[3]) and (carte2[13]<>carte2[4]) and (carte2[13]<>carte2[5]) and (carte2[13]<>carte2[6]) and (carte2[13]<>carte2[7]) and (carte2[13]<>carte2[8]) and (carte2[13]<>carte2[9]) and (carte2[13]<>carte2[10]) and (carte2[13]<>carte2[11]) and (carte2[13]<>carte2[12]) and (carte2[13]<>carte1[1]) and (carte2[13]<>carte1[2]) and (carte2[13]<>carte1[3]) and (carte2[13]<>carte1[4]) and (carte2[13]<>carte1[5]) and (carte2[13]<>carte1[6]) and (carte2[13]<>carte1[7]) and (carte2[13]<>carte1[8]) and (carte2[13]<>carte1[9]) and (carte2[13]<>carte1[10]) and (carte2[13]<>carte1[11]) and (carte2[13]<>carte1[12]) and (carte2[13]<>carte1[13]);
                  giro2:=13;
                  assegnaz2;
                  end;
                  end;
until (p2=7.5) or (p2>7.5) or (pesca='n');

player2ok:=true;

writeln;
writeln('carte pescate da player2');
writeln;
for i:=1 to 15 do write(' ',carte2[i]);


writeln;

controllo_bug1;

if bugx001=true then writeln(' A causa del bug x001 è necessario riavvire 7 e mezzo');



if (p1>p2) and (p1<=7.5) then begin
                   textcolor(lightmagenta);
                   writeln;
                   write(name1);
                   textcolor(yellow);
                   write('hai vinto! ');
                   textcolor(lightgreen);
                   write(name2,' ');
                   textcolor(yellow);
                   writeln('è stato superato!');
              end;


if (p2>p1) and (p2>7.5) then begin
                   textcolor(lightmagenta);
                   writeln;
                   write(name1);
                   textcolor(yellow);
                   write('hai vinto! ');
                   textcolor(lightgreen);
                   write(name2,' ');
                   textcolor(yellow);
                   writeln('ha sballato!');
              end;



if (p2>p1) and (p2<=7.5) then begin
                   textcolor(lightgreen);
                   writeln;
                   write(name2);
                   textcolor(yellow);
                   write('hai vinto! ');
                   textcolor(lightmagenta);
                   write(name1,' ');
                   textcolor(yellow);
                   writeln('è stato superato!');
              end;


if (p1>p2) and (p1>7.5) then begin
                   textcolor(lightgreen);
                   writeln;
                   write(name2);
                   textcolor(yellow);
                   write('hai vinto! ');
                   textcolor(lightmagenta);
                   write(name1,' ');
                   textcolor(yellow);
                   writeln('ha sballato!');
              end;

if (p1>7.5) and (p2>7.5) then begin
                              textcolor(yellow);
                              writeln;
                              writeln('Avete perso entrambi!');
                              writeln('Nessuna variazione del vostro budget!');
                              end;

if p1=p2 then begin
                   textcolor(yellow);
                   writeln;
                   write('Pareggio!');
              end;
x:=x+1;
readln;
clrscr;
until (x=partite);

readln;
end.

