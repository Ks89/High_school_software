program tris3d_1_0;
uses crt,graph;

var
   gate:array[1..3,1..3,1..3] of integer;
   a,b,c,i,partita,torneo,score1,score2,x:integer;
   name1,name2:string;
   gd,gm:word;
   w:real;
   pos:char;
   win,nameuguali:boolean;

procedure casuale;
begin
     randomize;
     for x:=1 to 255 do i:=Random(100);
end;

procedure punteggi;
begin
     textcolor(yellow);
     write(name1);
     textcolor(white);
     writeln(' : ',score1);
     writeln;
     textcolor(yellow);
     write(name2);
     textcolor(white);
     writeln(' : ',score2);
     textcolor(lightred);
     writeln;
     writeln('Premi un pulsante per continuare');
     readln;
end;

procedure grafica;
begin
     detectgraph(gd,gm);
     initgraph(gd,gm,'');
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
     str:='TRIS3D 1.0';
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
     str:='Ogni giocatore deve scegliere la cella inserendo la lettera corrispondente';
     gotoxy((80-length(str)) div 2,wherey);
     delay(500);
     writeln(str);
     writeln;
     textcolor(yellow);
     str:='Per imparare a giocare aprire il file .pdf o .doc nella cartella d''installazione';
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


procedure svuota;
begin
   for a:=1 to 3 do for b:=1 to 3 do for c:=1 to 3 do gate[a,b,c]:=0;
end;

{---------------------------------------------------------------------------------------------------------------}
{----------------------------------------------ks89 e aljosha89-------------------------------------------------}
{---------------------------------------------------------------------------------------------------------------}
{-----------------------------------------------INIZIO BEGIN----------------------------------------------------}
{---------------------------------------------------------------------------------------------------------------}
{-------------------------------------------------2006-07-------------------------------------------------------}
{---------------------------------------------------------------------------------------------------------------}

procedure gate1;
begin
     {stampa il titolo}
     setcolor(lightgreen);
     settextstyle(GothicFont,Horizdir,8);
     outtextxy(300,100,'Tris 3D');

     setcolor(lightmagenta);
     settextstyle(gothicfont,horizdir,8);
     outtextxy(800,100,'1.0');

     setcolor(lightblue);
     settextstyle(gothicfont,horizdir,4);
     outtextxy(300,200,'Personal edition');

{-----------------------------------disegna la griglia--------------------------------}
     {-------QUADRANTE1--------}
     setcolor(white);
     rectangle(100,100,150,150);
     rectangle(150,100,200,150);
     rectangle(200,100,250,150);

     rectangle(100,150,150,200);
     rectangle(150,150,200,200);
     rectangle(200,150,250,200);

     rectangle(100,200,150,250);
     rectangle(150,200,200,250);
     rectangle(200,200,250,250);

     settextstyle(gothicfont,horizdir,1);
     outtextxy(102,102,'a');
     outtextxy(152,102,'b');
     outtextxy(202,102,'c');
     outtextxy(102,152,'d');
     outtextxy(152,152,'e');
     outtextxy(202,152,'f');
     outtextxy(102,202,'g');
     outtextxy(152,202,'h');
     outtextxy(202,202,'i');

     {-------QUADRANTE2--------}
     setcolor(white);
     rectangle(100,300,150,350);
     rectangle(150,300,200,350);
     rectangle(200,300,250,350);

     rectangle(100,350,150,400);
     rectangle(150,350,200,400);
     rectangle(200,350,250,400);

     rectangle(100,400,150,450);
     rectangle(150,400,200,450);
     rectangle(200,400,250,450);

     settextstyle(gothicfont,horizdir,1);
     outtextxy(102,302,'j');
     outtextxy(152,302,'k');
     outtextxy(202,302,'l');
     outtextxy(102,352,'m');
     outtextxy(152,352,'n');
     outtextxy(202,352,'o');
     outtextxy(102,402,'p');
     outtextxy(152,402,'q');
     outtextxy(202,402,'r');

     {-------QUADRANTE3--------}
     setcolor(white);
     rectangle(100,500,150,550);
     rectangle(150,500,200,550);
     rectangle(200,500,250,550);

     rectangle(100,550,150,600);
     rectangle(150,550,200,600);
     rectangle(200,550,250,600);

     rectangle(100,600,150,650);
     rectangle(150,600,200,650);
     rectangle(200,600,250,650);

     settextstyle(gothicfont,horizdir,1);
     outtextxy(102,502,'s');
     outtextxy(152,502,'t');
     outtextxy(202,502,'u');
     outtextxy(102,552,'v');
     outtextxy(152,552,'w');
     outtextxy(202,552,'x');
     outtextxy(102,602,'y');
     outtextxy(152,602,'z');
     outtextxy(202,602,'0');
end;




begin
     grafica;
     gate1;
     score1:=0;
     score2:=0;
     clrscr;
     casuale;
     win:=false;
     svuota;
     centra;

{impostazione torneo}
repeat
     clrscr;
     textcolor(lightgreen);
     writeln('Impostazioni torneo');
     writeln;
     textcolor(yellow);
     write('Quante partite vuoi fare? [min 2] : ');
     textcolor(lightmagenta);
     readln(partita);
     if partita<2 then begin
                            writeln('Numero di partite inferiore a 2!');
                            partita:=0;
                       end;
until partita>=2;
     writeln;
     textcolor(lightred);
     writeln('Premi un tasto per contiuare');
     readln;
     clrscr;




     repeat
     nameuguali:=false;
                          textcolor(yellow);
                          write('Giocatore 1! Inserisci il tuo nome : ');
                          textcolor(lightmagenta);
                          readln(name1);
                          writeln;
                          textcolor(yellow);
                          write('Giocatore 2! Inserisci il tuo nome : ');
                          textcolor(lightmagenta);
                          readln(name2);
                          textcolor(yellow);
                          writeln;

     if name1=name2 then begin
                              nameuguali:=true;
                              clrscr;
                              textcolor(cyan);
                              writeln('Errore, nomi uguali');
                              delay(1000);
                              clrscr;
                         end;
    until nameuguali=false;
    torneo:=0;
repeat
      torneo:=torneo+1;
repeat

     i:=i+1;
     w:=i mod 2;

     if w=0 then begin
                          clrscr;
                          textcolor(yellow);
                          write(name1,'! Scegli la posizione : ');
                          textcolor(lightmagenta);
                          readln(pos);
                          textcolor(white);
                          if (pos='a') or (pos='A') then begin if gate[1,1,3]=1 then begin
                                                              gate[1,1,3]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[1,1,3]=0 then gate[1,1,3]:=1;
                                                         if gate[1,1,3]=2 then i:=i-1;
                                                         end;
                          if (pos='b') or (pos='B') then begin
                                                         if gate[1,2,3]=1 then begin
                                                              gate[1,2,3]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[1,2,3]=0 then gate[1,2,3]:=1;
                                                         if gate[1,2,3]=2 then i:=i-1;
                                                         end;
                          if (pos='c') or (pos='C') then begin if gate[1,3,3]=1 then begin
                                                              gate[1,3,3]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[1,3,3]=0 then gate[1,3,3]:=1;
                                                         if gate[1,3,3]=2 then i:=i-1;
                                                         end;
                          if (pos='d') or (pos='D') then begin if gate[1,1,2]=1 then begin
                                                              gate[1,1,2]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[1,1,2]=0 then gate[1,1,2]:=1;
                                                         if gate[1,1,2]=2 then i:=i-1;
                                                         end;
                          if (pos='e') or (pos='E') then begin if gate[1,2,2]=1 then begin
                                                              gate[1,2,2]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[1,2,2]=0 then gate[1,2,2]:=1;
                                                         if gate[1,2,2]=2 then i:=i-1;
                                                         end;
                          if (pos='f') or (pos='F') then begin if gate[1,3,2]=1 then begin
                                                              gate[1,3,2]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[1,3,2]=0 then gate[1,3,2]:=1;
                                                         if gate[1,3,2]=2 then i:=i-1;
                                                         end;
                          if (pos='g') or (pos='G') then begin if gate[1,1,1]=1 then begin
                                                              gate[1,1,1]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[1,1,1]=0 then gate[1,1,1]:=1;
                                                         if gate[1,1,1]=2 then i:=i-1;
                                                         end;
                          if (pos='h') or (pos='H') then begin if gate[1,2,1]=1 then begin
                                                              gate[1,2,1]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[1,2,1]=0 then gate[1,2,1]:=1;
                                                         if gate[1,2,1]=2 then i:=i-1;
                                                         end;
                          if (pos='i') or (pos='I') then begin if gate[1,3,1]=1 then begin
                                                              gate[1,3,1]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[1,3,1]=0 then gate[1,3,1]:=1;
                                                         if gate[1,3,1]=2 then i:=i-1;
                                                         end;
                          if (pos='j') or (pos='J') then begin if gate[2,1,3]=1 then begin
                                                              gate[2,1,3]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[2,1,3]=0 then gate[2,1,3]:=1;
                                                         if gate[2,1,3]=2 then i:=i-1;
                                                         end;
                          if (pos='k') or (pos='K') then begin
                                                         if gate[2,2,3]=1 then begin
                                                              gate[2,2,3]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[2,2,3]=0 then gate[2,2,3]:=1;
                                                         if gate[2,2,3]=2 then i:=i-1;
                                                         end;
                          if (pos='l') or (pos='L') then begin if gate[2,3,3]=1 then begin
                                                              gate[2,3,3]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[2,3,3]=0 then gate[2,3,3]:=1;
                                                         if gate[2,3,3]=2 then i:=i-1;
                                                         end;
                          if (pos='m') or (pos='M') then begin if gate[2,1,2]=1 then begin
                                                              gate[2,1,2]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[2,1,2]=0 then gate[2,1,2]:=1;
                                                         if gate[2,1,2]=2 then i:=i-1;
                                                         end;
                          if (pos='n') or (pos='N') then begin if gate[2,2,2]=1 then begin
                                                              gate[2,2,2]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[2,2,2]=0 then gate[2,2,2]:=1;
                                                         if gate[2,2,2]=2 then i:=i-1;
                                                         end;
                          if (pos='o') or (pos='O') then begin if gate[2,3,2]=1 then begin
                                                              gate[2,3,2]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[2,3,2]=0 then gate[2,3,2]:=1;
                                                         if gate[2,3,2]=2 then i:=i-1;
                                                         end;
                          if (pos='p') or (pos='P') then begin if gate[2,1,1]=1 then begin
                                                              gate[2,1,1]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[2,1,1]=0 then gate[2,1,1]:=1;
                                                         if gate[2,1,1]=2 then i:=i-1;
                                                         end;
                          if (pos='q') or (pos='Q') then begin if gate[2,2,1]=1 then begin
                                                              gate[2,2,1]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[2,2,1]=0 then gate[2,2,1]:=1;
                                                         if gate[2,2,1]=2 then i:=i-1;
                                                         end;
                          if (pos='r') or (pos='R') then begin if gate[2,3,1]=1 then begin
                                                              gate[2,3,1]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[2,3,1]=0 then gate[2,3,1]:=1;
                                                         if gate[2,3,1]=2 then i:=i-1;
                                                         end;
                          if (pos='s') or (pos='S') then begin if gate[3,1,3]=1 then begin
                                                              gate[3,1,3]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[3,1,3]=0 then gate[3,1,3]:=1;
                                                         if gate[3,1,3]=2 then i:=i-1;
                                                         end;
                          if (pos='t') or (pos='T') then begin
                                                         if gate[3,2,3]=1 then begin
                                                              gate[3,2,3]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[3,2,3]=0 then gate[3,2,3]:=1;
                                                         if gate[3,2,3]=2 then i:=i-1;
                                                         end;
                          if (pos='u') or (pos='U') then begin if gate[3,3,3]=1 then begin
                                                              gate[3,3,3]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[3,3,3]=0 then gate[3,3,3]:=1;
                                                         if gate[3,3,3]=2 then i:=i-1;
                                                         end;
                          if (pos='v') or (pos='V') then begin if gate[3,1,2]=1 then begin
                                                              gate[3,1,2]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[3,1,2]=0 then gate[3,1,2]:=1;
                                                         if gate[3,1,2]=2 then i:=i-1;
                                                         end;
                          if (pos='w') or (pos='W') then begin if gate[3,2,2]=1 then begin
                                                              gate[3,2,2]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[3,2,2]=0 then gate[3,2,2]:=1;
                                                         if gate[3,2,2]=2 then i:=i-1;
                                                         end;
                          if (pos='x') or (pos='X') then begin if gate[3,3,2]=1 then begin
                                                              gate[3,3,2]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[3,3,2]=0 then gate[3,3,2]:=1;
                                                         if gate[3,3,2]=2 then i:=i-1;
                                                         end;
                          if (pos='y') or (pos='Y') then begin if gate[3,1,1]=1 then begin
                                                              gate[3,1,1]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[3,1,1]=0 then gate[3,1,1]:=1;
                                                         if gate[3,1,1]=2 then i:=i-1;
                                                         end;
                          if (pos='z') or (pos='Z') then begin if gate[3,2,1]=1 then begin
                                                              gate[3,2,1]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[3,2,1]=0 then gate[3,2,1]:=1;
                                                         if gate[3,2,1]=2 then i:=i-1;
                                                         end;
                          if (pos='0') then begin if gate[3,3,1]=1 then begin
                                                              gate[3,3,1]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[3,3,1]=0 then gate[3,3,1]:=1;
                                                         if gate[3,3,1]=2 then i:=i-1;
                                                         end;
                          clrscr;
                          end;

     if w<>0 then begin
                          clrscr;
                          textcolor(yellow);
                          write(name2,'! Scegli la posizione : ');
                          textcolor(lightmagenta);
                          readln(pos);
                          textcolor(white);
                          if (pos='a') or (pos='A') then begin if gate[1,1,3]=2 then begin
                                                              gate[1,1,3]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[1,1,3]=0 then gate[1,1,3]:=2;
                                                         if gate[1,1,3]=1 then i:=i-1;
                                                         end;
                          if (pos='b') or (pos='B') then begin
                                                         if gate[1,2,3]=2 then begin
                                                              gate[1,2,3]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[1,2,3]=0 then gate[1,2,3]:=2;
                                                         if gate[1,2,3]=1 then i:=i-1;
                                                         end;
                          if (pos='c') or (pos='C') then begin if gate[1,3,3]=2 then begin
                                                              gate[1,3,3]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[1,3,3]=0 then gate[1,3,3]:=2;
                                                         if gate[1,3,3]=1 then i:=i-1;
                                                         end;
                          if (pos='d') or (pos='D') then begin if gate[1,1,2]=2 then begin
                                                              gate[1,1,2]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[1,1,2]=0 then gate[1,1,2]:=2;
                                                         if gate[1,1,2]=1 then i:=i-1;
                                                         end;
                          if (pos='e') or (pos='E') then begin if gate[1,2,2]=2 then begin
                                                              gate[1,2,2]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[1,2,2]=0 then gate[1,2,2]:=2;
                                                         if gate[1,2,2]=1 then i:=i-1;
                                                         end;
                          if (pos='f') or (pos='F') then begin if gate[1,3,2]=2 then begin
                                                              gate[1,3,2]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[1,3,2]=0 then gate[1,3,2]:=2;
                                                         if gate[1,3,2]=1 then i:=i-1;
                                                         end;
                          if (pos='g') or (pos='G') then begin if gate[1,1,1]=2 then begin
                                                              gate[1,1,1]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[1,1,1]=0 then gate[1,1,1]:=2;
                                                         if gate[1,1,1]=1 then i:=i-1;
                                                         end;
                          if (pos='h') or (pos='H') then begin if gate[1,2,1]=2 then begin
                                                              gate[1,2,1]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[1,2,1]=0 then gate[1,2,1]:=2;
                                                         if gate[1,2,1]=1 then i:=i-1;
                                                         end;
                          if (pos='i') or (pos='I') then begin if gate[1,3,1]=2 then begin
                                                              gate[1,3,1]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[1,3,1]=0 then gate[1,3,1]:=2;
                                                         if gate[1,3,1]=1 then i:=i-1;
                                                         end;
                          if (pos='j') or (pos='J') then begin if gate[2,1,3]=2 then begin
                                                              gate[2,1,3]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[2,1,3]=0 then gate[2,1,3]:=2;
                                                         if gate[2,1,3]=1 then i:=i-1;
                                                         end;
                          if (pos='k') or (pos='K') then begin
                                                         if gate[2,2,3]=2 then begin
                                                              gate[2,2,3]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[2,2,3]=0 then gate[2,2,3]:=2;
                                                         if gate[2,2,3]=1 then i:=i-1;
                                                         end;
                          if (pos='l') or (pos='L') then begin if gate[2,3,3]=2 then begin
                                                              gate[2,3,3]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[2,3,3]=0 then gate[2,3,3]:=2;
                                                         if gate[2,3,3]=1 then i:=i-1;
                                                         end;
                          if (pos='m') or (pos='M') then begin if gate[2,1,2]=2 then begin
                                                              gate[2,1,2]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[2,1,2]=0 then gate[2,1,2]:=2;
                                                         if gate[2,1,2]=1 then i:=i-1;
                                                         end;
                          if (pos='n') or (pos='N') then begin if gate[2,2,2]=2 then begin
                                                              gate[2,2,2]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[2,2,2]=0 then gate[2,2,2]:=2;
                                                         if gate[2,2,2]=1 then i:=i-1;
                                                         end;
                          if (pos='o') or (pos='O') then begin if gate[2,3,2]=2 then begin
                                                              gate[2,3,2]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[2,3,2]=0 then gate[2,3,2]:=2;
                                                         if gate[2,3,2]=1 then i:=i-1;
                                                         end;
                          if (pos='p') or (pos='P') then begin if gate[2,1,1]=2 then begin
                                                              gate[2,1,1]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[2,1,1]=0 then gate[2,1,1]:=2;
                                                         if gate[2,1,1]=1 then i:=i-1;
                                                         end;
                          if (pos='q') or (pos='Q') then begin if gate[2,2,1]=2 then begin
                                                              gate[2,2,1]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[2,2,1]=0 then gate[2,2,1]:=2;
                                                         if gate[2,2,1]=1 then i:=i-1;
                                                         end;
                          if (pos='r') or (pos='R') then begin if gate[2,3,1]=2 then begin
                                                              gate[2,3,1]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[2,3,1]=0 then gate[2,3,1]:=2;
                                                         if gate[2,3,1]=1 then i:=i-1;
                                                         end;
                          if (pos='s') or (pos='S') then begin if gate[3,1,3]=2 then begin
                                                              gate[3,1,3]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[3,1,3]=0 then gate[3,1,3]:=2;
                                                         if gate[3,1,3]=1 then i:=i-1;
                                                         end;
                          if (pos='t') or (pos='T') then begin
                                                         if gate[3,2,3]=2 then begin
                                                              gate[3,2,3]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[3,2,3]=0 then gate[3,2,3]:=2;
                                                         if gate[3,2,3]=1 then i:=i-1;
                                                         end;
                          if (pos='u') or (pos='U') then begin if gate[3,3,3]=2 then begin
                                                              gate[3,3,3]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[3,3,3]=0 then gate[3,3,3]:=2;
                                                         if gate[3,3,3]=1 then i:=i-1;
                                                         end;
                          if (pos='v') or (pos='V') then begin if gate[3,1,2]=2 then begin
                                                              gate[3,1,2]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[3,1,2]=0 then gate[3,1,2]:=2;
                                                         if gate[3,1,2]=1 then i:=i-1;
                                                         end;
                          if (pos='w') or (pos='W') then begin if gate[3,2,2]=2 then begin
                                                              gate[3,2,2]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[3,2,2]=0 then gate[3,2,2]:=2;
                                                         if gate[3,2,2]=1 then i:=i-1;
                                                         end;
                          if (pos='x') or (pos='X') then begin if gate[3,3,2]=2 then begin
                                                              gate[3,3,2]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[3,3,2]=0 then gate[3,3,2]:=2;
                                                         if gate[3,3,2]=1 then i:=i-1;
                                                         end;
                          if (pos='y') or (pos='Y') then begin if gate[3,1,1]=2 then begin
                                                              gate[3,1,1]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[3,1,1]=0 then gate[3,1,1]:=2;
                                                         if gate[3,1,1]=1 then i:=i-1;
                                                         end;
                          if (pos='z') or (pos='Z') then begin if gate[3,2,1]=2 then begin
                                                              gate[3,2,1]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[3,2,1]=0 then gate[3,2,1]:=2;
                                                         if gate[3,2,1]=1 then i:=i-1;
                                                         end;
                          if (pos='0') then begin if gate[3,3,1]=2 then begin
                                                              gate[3,3,1]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[3,3,1]=0 then gate[3,3,1]:=2;
                                                         if gate[3,3,1]=1 then i:=i-1;
                                                         end;
                          clrscr;
                          end;

textcolor(cyan);
{giocatore1}
{QUADRANTE1}
if gate[1,1,3]=1 then if gate[1,2,3]=1 then if gate[1,3,3]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,125,225,125);
                                                            score1:=score1+1;
                                                            end;
if gate[1,1,2]=1 then if gate[1,2,2]=1 then if gate[1,3,2]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,175,225,175);
                                                            score1:=score1+1;
                                                            end;
if gate[1,1,1]=1 then if gate[1,2,1]=1 then if gate[1,3,1]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,225,225,225);
                                                            score1:=score1+1;
                                                            end;

if gate[1,1,3]=1 then if gate[1,1,2]=1 then if gate[1,1,1]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,125,125,225);
                                                             score1:=score1+1;
                                                            end;
if gate[1,2,3]=1 then if gate[1,2,2]=1 then if gate[1,2,1]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(175,125,175,225);
                                                             score1:=score1+1;
                                                            end;
if gate[1,3,3]=1 then if gate[1,3,2]=1 then if gate[1,3,1]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(225,125,225,225);
                                                             score1:=score1+1;
                                                            end;

if gate[1,1,3]=1 then if gate[1,2,2]=1 then if gate[1,3,1]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,125,225,225);
                                                             score1:=score1+1;
                                                            end;
if gate[1,3,3]=1 then if gate[1,2,2]=1 then if gate[1,1,1]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(225,125,125,225);
                                                            score1:=score1+1;
                                                            end;
{QUADRANTE2}
if gate[2,1,3]=1 then if gate[2,2,3]=1 then if gate[2,3,3]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,325,225,325);
                                                            score1:=score1+1;
                                                            end;
if gate[2,1,2]=1 then if gate[2,2,2]=1 then if gate[2,3,2]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,375,225,375);
                                                            score1:=score1+1;
                                                            end;
if gate[2,1,1]=1 then if gate[2,2,1]=1 then if gate[2,3,1]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,325,225,425);
                                                            score1:=score1+1;
                                                            end;

if gate[2,1,3]=1 then if gate[2,1,2]=1 then if gate[2,1,1]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,325,125,425);
                                                            score1:=score1+1;
                                                            end;
if gate[2,2,3]=1 then if gate[2,2,2]=1 then if gate[2,2,1]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(175,325,175,425);
                                                            score1:=score1+1;
                                                            end;
if gate[2,3,3]=1 then if gate[2,3,2]=1 then if gate[2,3,1]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(225,325,225,425);
                                                            score1:=score1+1;
                                                            end;

if gate[2,1,3]=1 then if gate[2,2,2]=1 then if gate[2,3,2]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,325,225,425);
                                                            score1:=score1+1;
                                                            end;
if gate[2,3,3]=1 then if gate[2,2,2]=1 then if gate[2,1,1]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(225,325,125,425);
                                                            score1:=score1+1;
                                                            end;
{QUADRANTE3}
if gate[3,1,3]=1 then if gate[3,2,3]=1 then if gate[3,3,3]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,325,225,325);
                                                            score1:=score1+1;
                                                            end;
if gate[3,1,2]=1 then if gate[3,2,2]=1 then if gate[3,3,2]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,375,225,375);
                                                            score1:=score1+1;
                                                            end;
if gate[3,1,1]=1 then if gate[3,2,1]=1 then if gate[3,3,1]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,325,225,425);
                                                            score1:=score1+1;
                                                            end;

if gate[3,1,3]=1 then if gate[3,1,2]=1 then if gate[3,1,1]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,325,125,425);
                                                            score1:=score1+1;
                                                            end;
if gate[3,2,3]=1 then if gate[3,2,2]=1 then if gate[3,2,1]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(175,325,175,425);
                                                            score1:=score1+1;
                                                            end;
if gate[3,3,3]=1 then if gate[3,3,2]=1 then if gate[3,3,1]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(225,325,225,425);
                                                            score1:=score1+1;
                                                            end;

if gate[3,1,3]=1 then if gate[3,2,2]=1 then if gate[3,3,2]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,325,225,425);
                                                            score1:=score1+1;
                                                            end;
if gate[3,3,3]=1 then if gate[3,2,2]=1 then if gate[3,1,1]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(225,325,125,425);
                                                            score1:=score1+1;
                                                            end;
{OBLIQUE con le 3D}
if gate[1,1,3]=1 then if gate[2,2,2]=1 then if gate[3,3,1]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,125,225,625);
                                                            score1:=score1+3;
                                                            end;

if gate[1,3,3]=1 then if gate[2,2,2]=1 then if gate[3,1,1]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(225,125,125,625);
                                                            score1:=score1+3;
                                                            end;
if gate[1,1,1]=1 then if gate[2,2,2]=1 then if gate[3,3,3]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,225,225,525);
                                                            score1:=score1+3;
                                                            end;
if gate[1,3,1]=1 then if gate[2,2,2]=1 then if gate[3,1,3]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(225,275,125,525);
                                                            score1:=score1+3;
                                                            end;
{RIGHE CON LE 3D}
if gate[1,1,3]=1 then if gate[2,2,3]=1 then if gate[3,3,3]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,125,225,525);
                                                            score1:=score1+2;
                                                            end;

if gate[1,1,2]=1 then if gate[2,2,2]=1 then if gate[3,3,2]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,175,225,575);
                                                            score1:=score1+2;
                                                            end;
if gate[1,1,1]=1 then if gate[2,2,1]=1 then if gate[3,3,1]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,225,225,625);
                                                            score1:=score1+2;
                                                            end;

if gate[1,3,3]=1 then if gate[2,2,3]=1 then if gate[3,1,3]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(225,125,125,525);
                                                            score1:=score1+2;
                                                            end;

if gate[1,3,2]=1 then if gate[2,2,2]=1 then if gate[3,1,2]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(225,225,175,575);
                                                            score1:=score1+2;
                                                            end;
if gate[1,3,1]=1 then if gate[2,2,1]=1 then if gate[3,1,1]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(225,275,225,575);
                                                            score1:=score1+2;
                                                            end;

{COLONNE CON LE 3D}
if gate[1,1,3]=1 then if gate[2,1,2]=1 then if gate[3,1,1]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,125,125,625);
                                                            score1:=score1+2;
                                                            end;

if gate[1,2,3]=1 then if gate[2,2,2]=1 then if gate[3,2,1]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(175,125,175,625);
                                                             score1:=score1+2;
                                                            end;
if gate[1,3,3]=1 then if gate[2,3,2]=1 then if gate[3,3,1]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(225,125,225,625);
                                                            score1:=score1+2;
                                                            end;
if gate[1,1,1]=1 then if gate[2,1,2]=1 then if gate[3,1,3]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,225,125,525);
                                                            score1:=score1+2;
                                                            end;

if gate[1,2,1]=1 then if gate[2,2,2]=1 then if gate[3,2,3]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(175,225,175,525);
                                                            score1:=score1+2;
                                                            end;
if gate[1,3,1]=1 then if gate[2,3,2]=1 then if gate[3,3,3]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(225,225,225,525);
                                                            score1:=score1+2;
                                                            end;




{giocatore2}
{QUADRANTE1}
if gate[1,1,3]=2 then if gate[1,2,3]=2 then if gate[1,3,3]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,125,225,125);
                                                            score2:=score2+1;
                                                            end;
if gate[1,1,2]=2 then if gate[1,2,2]=2 then if gate[1,3,2]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,175,225,175);
                                                            score2:=score2+1;
                                                            end;
if gate[1,1,1]=2 then if gate[1,2,1]=2 then if gate[1,3,1]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,225,225,225);
                                                            score2:=score2+1;
                                                            end;

if gate[1,1,3]=2 then if gate[1,1,2]=2 then if gate[1,1,1]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,125,125,225);
                                                            score2:=score2+1;
                                                            end;
if gate[1,2,3]=2 then if gate[1,2,2]=2 then if gate[1,2,1]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(175,125,175,225);
                                                            score2:=score2+1;
                                                            end;
if gate[1,3,3]=2 then if gate[1,3,2]=2 then if gate[1,3,1]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(225,125,225,225);
                                                            score2:=score2+1;
                                                            end;

if gate[1,1,3]=2 then if gate[1,2,2]=2 then if gate[1,3,1]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,125,225,225);
                                                            score2:=score2+1;
                                                            end;
if gate[1,3,3]=2 then if gate[1,2,2]=2 then if gate[1,1,1]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(225,125,125,225);
                                                            score2:=score2+1;
                                                            end;
{QUADRANTE2}
if gate[2,1,3]=2 then if gate[2,2,3]=2 then if gate[2,3,3]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,325,225,325);
                                                            score2:=score2+1;
                                                            end;
if gate[2,1,2]=2 then if gate[2,2,2]=2 then if gate[2,3,2]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,375,225,375);
                                                            score2:=score2+1;
                                                            end;
if gate[2,1,1]=2 then if gate[2,2,1]=2 then if gate[2,3,1]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,325,225,425);
                                                            score2:=score2+1;
                                                            end;

if gate[2,1,3]=2 then if gate[2,1,2]=2 then if gate[2,1,1]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,325,125,425);
                                                            score2:=score2+1;
                                                            end;
if gate[2,2,3]=2 then if gate[2,2,2]=2 then if gate[2,2,1]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(175,325,175,425);
                                                            score2:=score2+1;
                                                            end;
if gate[2,3,3]=2 then if gate[2,3,2]=2 then if gate[2,3,1]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(225,325,225,425);
                                                            score2:=score2+1;
                                                            end;

if gate[2,1,3]=2 then if gate[2,2,2]=2 then if gate[2,3,2]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,325,225,425);
                                                            score2:=score2+1;
                                                            end;
if gate[2,3,3]=2 then if gate[2,2,2]=2 then if gate[2,1,1]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(225,325,125,425);
                                                            score2:=score2+1;
                                                            end;
{QUADRANTE3}
if gate[3,1,3]=2 then if gate[3,2,3]=2 then if gate[3,3,3]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,325,225,325);
                                                            score2:=score2+1;
                                                            end;
if gate[3,1,2]=2 then if gate[3,2,2]=2 then if gate[3,3,2]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,375,225,375);
                                                             score2:=score2+1;
                                                            end;
if gate[3,1,1]=2 then if gate[3,2,1]=2 then if gate[3,3,1]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,325,225,425);
                                                            score2:=score2+1;
                                                            end;

if gate[3,1,3]=2 then if gate[3,1,2]=2 then if gate[3,1,1]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,325,125,425);
                                                            score2:=score2+1;
                                                            end;
if gate[3,2,3]=2 then if gate[3,2,2]=2 then if gate[3,2,1]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(175,325,175,425);
                                                            score2:=score2+1;
                                                            end;
if gate[3,3,3]=2 then if gate[3,3,2]=2 then if gate[3,3,1]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(225,325,225,425);
                                                            score2:=score2+1;
                                                            end;

if gate[3,1,3]=2 then if gate[3,2,2]=2 then if gate[3,3,2]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,325,225,425);
                                                            score2:=score2+1;
                                                            end;
if gate[3,3,3]=2 then if gate[3,2,2]=2 then if gate[3,1,1]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(225,325,125,425);
                                                            score2:=score2+1;
                                                            end;
{OBLIQUE con le 3D}
if gate[1,1,3]=2 then if gate[2,2,2]=2 then if gate[3,3,1]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,125,225,625);
                                                            score2:=score2+3;
                                                            end;

if gate[1,3,3]=2 then if gate[2,2,2]=2 then if gate[3,1,1]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(225,125,125,625);
                                                            score2:=score2+3;
                                                            end;
if gate[1,1,1]=2 then if gate[2,2,2]=2 then if gate[3,3,3]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,225,225,525);
                                                            score2:=score2+3;
                                                            end;
if gate[1,3,1]=2 then if gate[2,2,2]=2 then if gate[3,1,3]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(225,275,125,525);
                                                            score2:=score2+3;
                                                            end;
{RIGHE CON LE 3D}
if gate[1,1,3]=2 then if gate[2,2,3]=2 then if gate[3,3,3]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,125,225,525);
                                                            score2:=score2+2;
                                                            end;

if gate[1,1,2]=2 then if gate[2,2,2]=2 then if gate[3,3,2]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,175,225,575);
                                                            score2:=score2+2;
                                                            end;
if gate[1,1,1]=2 then if gate[2,2,1]=2 then if gate[3,3,1]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,225,225,625);
                                                            score2:=score2+2;
                                                            end;

if gate[1,3,3]=2 then if gate[2,2,3]=2 then if gate[3,1,3]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(225,125,125,525);
                                                            score2:=score2+2;
                                                            end;

if gate[1,3,2]=2 then if gate[2,2,2]=2 then if gate[3,1,2]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(225,225,175,575);
                                                            score2:=score2+2;
                                                            end;
if gate[1,3,1]=2 then if gate[2,2,1]=2 then if gate[3,1,1]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(225,275,225,575);
                                                            score2:=score2+2;
                                                            end;

{COLONNE CON LE 3D}
if gate[1,1,3]=2 then if gate[2,1,2]=2 then if gate[3,1,1]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,125,125,625);
                                                            score2:=score2+2;
                                                            end;

if gate[1,2,3]=2 then if gate[2,2,2]=2 then if gate[3,2,1]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(175,125,175,625);
                                                            score2:=score2+2;
                                                            end;
if gate[1,3,3]=2 then if gate[2,3,2]=2 then if gate[3,3,1]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(225,125,225,625);
                                                            score2:=score2+2;
                                                            end;
if gate[1,1,1]=2 then if gate[2,1,2]=2 then if gate[3,1,3]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,225,125,525);
                                                            score2:=score2+2;
                                                            end;

if gate[1,2,1]=2 then if gate[2,2,2]=2 then if gate[3,2,3]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(175,225,175,525);
                                                            score2:=score2+2;
                                                            end;
if gate[1,3,1]=2 then if gate[2,3,2]=2 then if gate[3,3,3]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(225,225,225,525);
                                                            score2:=score2+2;
                                                            end;




textcolor(white);
setcolor(white);

{disegna lo schema}
{per quadrante 1}
if gate[1,1,3]=1 then begin
                    setcolor(lightred);
                    circle(125,125,20);
                    end;
if gate[1,2,3]=1 then begin
                    setcolor(lightred);
                    circle(175,125,20);
                    end;
if gate[1,3,3]=1 then begin
                    setcolor(lightred);
                    circle(225,125,20);
                    end;
if gate[1,1,2]=1 then begin
                    setcolor(lightred);
                    circle(125,175,20);
                    end;
if gate[1,2,2]=1 then begin
                    setcolor(lightred);
                    circle(175,175,20);
                    end;
if gate[1,3,2]=1 then begin
                    setcolor(lightred);
                    circle(225,175,20);
                    end;
if gate[1,1,1]=1 then begin
                    setcolor(lightred);
                    circle(125,225,20);
                    end;
if gate[1,2,1]=1 then begin
                    setcolor(lightred);
                    circle(175,225,20);
                    end;
if gate[1,3,1]=1 then begin
                    setcolor(lightred);
                    circle(225,225,20);
                    end;

{per quadrante 2}
if gate[2,1,3]=1 then begin
                    setcolor(lightred);
                    circle(125,325,20);
                    end;
if gate[2,2,3]=1 then begin
                    setcolor(lightred);
                    circle(175,325,20);
                    end;
if gate[2,3,3]=1 then begin
                    setcolor(lightred);
                    circle(225,325,20);
                    end;
if gate[2,1,2]=1 then begin
                    setcolor(lightred);
                    circle(125,375,20);
                    end;
if gate[2,2,2]=1 then begin
                    setcolor(lightred);
                    circle(175,375,20);
                    end;
if gate[2,3,2]=1 then begin
                    setcolor(lightred);
                    circle(225,375,20);
                    end;
if gate[2,1,1]=1 then begin
                    setcolor(lightred);
                    circle(125,425,20);
                    end;
if gate[2,2,1]=1 then begin
                    setcolor(lightred);
                    circle(175,425,20);
                    end;
if gate[2,3,1]=1 then begin
                    setcolor(lightred);
                    circle(225,425,20);
                    end;

{per quadrante 3}
if gate[3,1,3]=1 then begin
                    setcolor(lightred);
                    circle(125,525,20);
                    end;
if gate[3,2,3]=1 then begin
                    setcolor(lightred);
                    circle(175,525,20);
                    end;
if gate[3,3,3]=1 then begin
                    setcolor(lightred);
                    circle(225,525,20);
                    end;
if gate[3,1,2]=1 then begin
                    setcolor(lightred);
                    circle(125,575,20);
                    end;
if gate[3,2,2]=1 then begin
                    setcolor(lightred);
                    circle(175,575,20);
                    end;
if gate[3,3,2]=1 then begin
                    setcolor(lightred);
                    circle(225,575,20);
                    end;
if gate[3,1,1]=1 then begin
                    setcolor(lightred);
                    circle(125,625,20);
                    end;
if gate[3,2,1]=1 then begin
                    setcolor(lightred);
                    circle(175,625,20);
                    end;
if gate[3,3,1]=1 then begin
                    setcolor(lightred);
                    circle(225,625,20);
                    end;

{disegna lo schema per giocatore2}
{per quadrante 1}
if gate[1,1,3]=2 then begin
                    setcolor(lightgreen);
                    line(112,112,137,137);
                    line(137,112,113,137);
                    end;
if gate[1,2,3]=2 then begin
                    setcolor(lightgreen);
                    line(162,112,187,137);
                    line(187,112,163,137);
                    end;
if gate[1,3,3]=2 then begin
                    setcolor(lightgreen);
                    line(212,112,237,137);
                    line(237,112,212,137);
                    end;
if gate[1,1,2]=2 then begin
                    setcolor(lightgreen);
                    line(112,162,137,187);
                    line(137,162,113,187);
                    end;
if gate[1,2,2]=2 then begin
                    setcolor(lightgreen);
                    line(162,162,187,187);
                    line(187,162,163,187);
                    end;
if gate[1,3,2]=2 then begin
                    setcolor(lightgreen);
                    line(212,162,237,187);
                    line(237,162,212,187);
                    end;
if gate[1,1,1]=2 then begin
                    setcolor(lightgreen);
                    line(112,212,137,237);
                    line(137,212,113,237);
                    end;
if gate[1,2,1]=2 then begin
                    setcolor(lightgreen);
                    line(162,212,187,237);
                    line(187,212,163,237);
                    end;
if gate[1,3,1]=2 then begin
                    setcolor(lightgreen);
                    line(212,212,237,237);
                    line(237,212,212,237);
                    end;

{per quadrante 2}
if gate[2,1,3]=2 then begin
                    setcolor(lightgreen);
                    line(112,312,137,337);
                    line(137,312,113,337);
                    end;
if gate[2,2,3]=2 then begin
                    setcolor(lightgreen);
                    line(162,312,187,337);
                    line(187,312,163,337);
                    end;
if gate[2,3,3]=2 then begin
                    setcolor(lightgreen);
                    line(212,312,237,337);
                    line(237,312,212,337);
                    end;
if gate[2,1,2]=2 then begin
                    setcolor(lightgreen);
                    line(112,362,137,387);
                    line(137,362,113,387);
                    end;
if gate[2,2,2]=2 then begin
                    setcolor(lightgreen);
                    line(162,362,187,387);
                    line(187,362,163,387);
                    end;
if gate[2,3,2]=2 then begin
                    setcolor(lightgreen);
                    line(212,362,237,387);
                    line(237,362,212,387);
                    end;
if gate[2,1,1]=2 then begin
                    setcolor(lightgreen);
                    line(112,412,137,437);
                    line(137,412,113,437);
                    end;
if gate[2,2,1]=2 then begin
                    setcolor(lightgreen);
                    line(162,412,187,437);
                    line(187,412,163,437);
                    end;
if gate[2,3,1]=2 then begin
                    setcolor(lightgreen);
                    line(212,412,237,437);
                    line(237,412,212,437);
                    end;

{per quadrante 3}
if gate[3,1,3]=2 then begin
                    setcolor(lightgreen);
                    line(112,512,137,537);
                    line(137,512,113,537);
                    end;
if gate[3,2,3]=2 then begin
                    setcolor(lightgreen);
                    line(162,512,187,537);
                    line(187,512,163,537);
                    end;
if gate[3,3,3]=2 then begin
                    setcolor(lightgreen);
                    line(212,512,237,537);
                    line(237,512,212,537);
                    end;
if gate[3,1,2]=2 then begin
                    setcolor(lightgreen);
                    line(112,562,137,587);
                    line(137,562,113,587);
                    end;
if gate[3,2,2]=2 then begin
                    setcolor(lightgreen);
                    line(162,562,187,587);
                    line(187,562,163,587);
                    end;
if gate[3,3,2]=2 then begin
                    setcolor(lightgreen);
                    line(212,562,237,587);
                    line(237,562,212,587);
                    end;
if gate[3,1,1]=2 then begin
                    setcolor(lightgreen);
                    line(112,612,137,637);
                    line(137,612,113,637);
                    end;
if gate[3,2,1]=2 then begin
                    setcolor(lightgreen);
                    line(162,612,187,637);
                    line(187,612,163,637);
                    end;
if gate[3,3,1]=2 then begin
                    setcolor(lightgreen);
                    line(212,612,237,637);
                    line(237,612,212,637);
                    end;



until (i=28) or (win=true);
readln;
clrscr;
svuota;
cleardevice;
gate1;
punteggi;
clrscr;
casuale;
win:=false;
until torneo=partita;
textcolor(yellow);
if score1>score2 then writeln(name1,' Hai vinto!!');
if score1<score2 then writeln(name2,' Hai vinto!!');
if score1=score2 then writeln('Pareggio!!');

readln;
closegraph;


end.


