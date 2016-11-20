program tris_1_0;
uses crt,graph;

var
   gate:array[1..3,1..3] of integer;
   a,b,i:integer;
   name1,name2:string;
   gd,gm:word;
   c:real;
   pos:char;
   win,nameuguali:boolean;

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
     str:='TRIS 1.0 Personal Edition';
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
     str:='Vince chi posiziona tre simboli uguali il fila';
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
   for a:=1 to 3 do for b:=1 to 3 do gate[a,b]:=0;
end;

{---------------------------------------------------------------------------------------------------------------}
{----------------------------------------------ks89 e aljosha89-------------------------------------------------}
{---------------------------------------------------------------------------------------------------------------}
{-----------------------------------------------INIZIO BEGIN----------------------------------------------------}
{---------------------------------------------------------------------------------------------------------------}
{-------------------------------------------------2006-07-------------------------------------------------------}
{---------------------------------------------------------------------------------------------------------------}


begin
     grafica;


     {stampa il titolo}
     setcolor(lightgreen);
     settextstyle(GothicFont,Horizdir,8);
     outtextxy(300,100,'Tris');

     setcolor(lightmagenta);
     settextstyle(gothicfont,horizdir,8);
     outtextxy(600,100,'1.0');

     setcolor(lightblue);
     settextstyle(gothicfont,horizdir,4);
     outtextxy(300,200,'Personal edition');

     {disegna la griglia}
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


     clrscr;
     i:=1;
     win:=false;
     svuota;
     centra;

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


repeat

     i:=i+1;
     c:=i mod 2;

     if c=0 then begin
                          writeln;
                          textcolor(yellow);
                          write(name1,'! Scegli la posizione : ');
                          textcolor(lightmagenta);
                          readln(pos);
                          textcolor(white);
                          if (pos='a') or (pos='A') then begin if gate[1,1]=1 then begin
                                                              gate[1,1]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[1,1]=0 then gate[1,1]:=1;
                                                         if gate[1,1]=2 then i:=i-1;
                                                         end;
                          if (pos='b') or (pos='B') then begin
                                                         if gate[1,2]=1 then begin
                                                              gate[1,2]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[1,2]=0 then gate[1,2]:=1;
                                                         if gate[1,2]=2 then i:=i-1;
                                                         end;
                          if (pos='c') or (pos='C') then begin if gate[1,3]=1 then begin
                                                              gate[1,3]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[1,3]=0 then gate[1,3]:=1;
                                                         if gate[1,3]=2 then i:=i-1;
                                                         end;
                          if (pos='d') or (pos='D') then begin if gate[2,1]=1 then begin
                                                              gate[2,1]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[2,1]=0 then gate[2,1]:=1;
                                                         if gate[2,1]=2 then i:=i-1;
                                                         end;
                          if (pos='e') or (pos='E') then begin if gate[2,2]=1 then begin
                                                              gate[2,2]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[2,2]=0 then gate[2,2]:=1;
                                                         if gate[2,2]=2 then i:=i-1;
                                                         end;
                          if (pos='f') or (pos='F') then begin if gate[2,3]=1 then begin
                                                              gate[2,3]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[2,3]=0 then gate[2,3]:=1;
                                                         if gate[2,3]=2 then i:=i-1;
                                                         end;
                          if (pos='g') or (pos='G') then begin if gate[3,1]=1 then begin
                                                              gate[3,1]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[3,1]=0 then gate[3,1]:=1;
                                                         if gate[3,1]=2 then i:=i-1;
                                                         end;
                          if (pos='h') or (pos='H') then begin if gate[3,2]=1 then begin
                                                              gate[3,2]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[3,2]=0 then gate[3,2]:=1;
                                                         if gate[3,2]=2 then i:=i-1;
                                                         end;
                          if (pos='i') or (pos='I') then begin if gate[3,3]=1 then begin
                                                              gate[3,3]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[3,3]=0 then gate[3,3]:=1;
                                                         if gate[3,3]=2 then i:=i-1;
                                                         end;
                          clrscr;
                          end;

     if c<>0 then begin
                          writeln;
                          textcolor(yellow);
                          write(name2,'! Scegli la posizione : ');
                          textcolor(lightmagenta);
                          readln(pos);
                          textcolor(white);
                          if (pos='a') or (pos='A') then begin if gate[1,1]=2 then begin
                                                              gate[1,1]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[1,1]=0 then gate[1,1]:=2;
                                                         if gate[1,1]=1 then i:=i-1;
                                                         end;
                          if (pos='b') or (pos='B') then begin
                                                         if gate[1,2]=2 then begin
                                                              gate[1,2]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[1,2]=0 then gate[1,2]:=2;
                                                         if gate[1,2]=1 then i:=i-1;
                                                         end;
                          if (pos='c') or (pos='C') then begin if gate[1,3]=2 then begin
                                                              gate[1,3]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[1,3]=0 then gate[1,3]:=2;
                                                         if gate[1,3]=1 then i:=i-1;
                                                         end;
                          if (pos='d') or (pos='D') then begin if gate[2,1]=2 then begin
                                                              gate[2,1]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[2,1]=0 then gate[2,1]:=2;
                                                         if gate[2,1]=1 then i:=i-1;
                                                         end;
                          if (pos='e') or (pos='E') then begin if gate[2,2]=2 then begin
                                                              gate[2,2]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[2,2]=0 then gate[2,2]:=2;
                                                         if gate[2,2]=1 then i:=i-1;
                                                         end;
                          if (pos='f') or (pos='F') then begin if gate[2,3]=2 then begin
                                                              gate[2,3]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[2,3]=0 then gate[2,3]:=2;
                                                         if gate[2,3]=1 then i:=i-1;
                                                         end;
                          if (pos='g') or (pos='G') then begin if gate[3,1]=2 then begin
                                                              gate[3,1]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[3,1]=0 then gate[3,1]:=2;
                                                         if gate[3,1]=1 then i:=i-1;
                                                         end;
                          if (pos='h') or (pos='H') then begin if gate[3,2]=2 then begin
                                                              gate[3,2]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[3,2]=0 then gate[3,2]:=2;
                                                         if gate[3,2]=1 then i:=i-1;
                                                         end;
                          if (pos='i') or (pos='I') then begin if gate[3,3]=2 then begin
                                                              gate[3,3]:=0;
                                                              writeln('Errore di sovrapposizione');
                                                              i:=i-1;
                                                              end;
                                                         if gate[3,3]=0 then gate[3,3]:=2;
                                                         if gate[3,3]=1 then i:=i-1;
                                                         end;
                          clrscr;
                          end;

textcolor(cyan);
if gate[1,1]=1 then if gate[1,2]=1 then if gate[1,3]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,125,225,125);
                                                            end;
if gate[2,1]=1 then if gate[2,2]=1 then if gate[2,3]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,175,225,175);
                                                            end;
if gate[3,1]=1 then if gate[3,2]=1 then if gate[3,3]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,225,225,225);
                                                            end;

if gate[1,1]=1 then if gate[2,1]=1 then if gate[3,1]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,125,125,225);
                                                            end;
if gate[1,2]=1 then if gate[2,2]=1 then if gate[3,2]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(175,125,175,225);
                                                            end;
if gate[1,3]=1 then if gate[2,3]=1 then if gate[3,3]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(225,125,225,225);
                                                            end;

if gate[1,1]=1 then if gate[2,2]=1 then if gate[3,3]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(125,125,225,225);
                                                            end;
if gate[3,1]=1 then if gate[2,2]=1 then if gate[3,1]=1 then begin
                                                            textcolor(lightmagenta);
                                                            write(name1);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(225,125,125,225);
                                                            end;


if gate[1,1]=2 then if gate[1,2]=2 then if gate[1,3]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(225,125,125,225);
                                                            end;
if gate[2,1]=2 then if gate[2,2]=2 then if gate[2,3]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(225,125,125,225);
                                                            end;
if gate[3,1]=2 then if gate[3,2]=2 then if gate[3,3]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(225,125,125,225);
                                                            end;

if gate[1,1]=2 then if gate[2,1]=2 then if gate[3,1]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(225,125,125,225);
                                                            end;
if gate[1,2]=2 then if gate[2,2]=2 then if gate[3,2]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(225,125,125,225);
                                                            end;
if gate[1,3]=2 then if gate[2,3]=2 then if gate[3,3]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(225,125,125,225);
                                                            end;

if gate[1,1]=2 then if gate[2,2]=2 then if gate[3,3]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(225,125,125,225);
                                                            end;
if gate[3,1]=2 then if gate[2,2]=2 then if gate[3,1]=2 then begin
                                                            textcolor(lightmagenta);
                                                            write(name2);
                                                            textcolor(lightgreen);
                                                            write(' : Hai vinto!!!');
                                                            win:=true;
                                                            setcolor(white);
                                                            line(225,125,125,225);
                                                            end;

textcolor(white);
setcolor(white);

{disegna lo schema}
if gate[1,1]=1 then begin
                    setcolor(lightred);
                    circle(125,125,20);
                    end;
if gate[1,2]=1 then begin
                    setcolor(lightred);
                    circle(175,125,20);
                    end;
if gate[1,3]=1 then begin
                    setcolor(lightred);
                    circle(225,125,20);
                    end;
if gate[2,1]=1 then begin
                    setcolor(lightred);
                    circle(125,175,20);
                    end;
if gate[2,2]=1 then begin
                    setcolor(lightred);
                    circle(175,175,20);
                    end;
if gate[2,3]=1 then begin
                    setcolor(lightred);
                    circle(225,175,20);
                    end;
if gate[3,1]=1 then begin
                    setcolor(lightred);
                    circle(125,225,20);
                    end;
if gate[3,2]=1 then begin
                    setcolor(lightred);
                    circle(175,225,20);
                    end;
if gate[3,3]=1 then begin
                    setcolor(lightred);
                    circle(225,225,20);
                    end;

if gate[1,1]=2 then begin
                    setcolor(green);
                    line(112,112,137,137);
                    line(137,112,113,137);
                    end;

if gate[1,2]=2 then begin
                    setcolor(green);
                    line(162,112,187,137);
                    line(187,112,163,137);
                    end;

if gate[1,3]=2 then begin
                    setcolor(green);
                    line(212,112,237,137);
                    line(237,112,212,137);
                    end;

if gate[2,1]=2 then begin
                    setcolor(green);
                    line(112,162,137,187);
                    line(137,162,113,187);
                    end;

if gate[2,2]=2 then begin
                    setcolor(green);
                    line(162,162,187,187);
                    line(187,162,163,187);
                    end;

if gate[2,3]=2 then begin
                    setcolor(green);
                    line(212,162,237,187);
                    line(237,162,212,187);
                    end;

if gate[3,1]=2 then begin
                    setcolor(green);
                    line(112,212,137,237);
                    line(137,212,113,237);
                    end;

if gate[3,2]=2 then begin
                    setcolor(green);
                    line(162,212,187,237);
                    line(187,212,163,237);
                    end;

if gate[3,3]=2 then begin
                    setcolor(green);
                    line(212,212,237,237);
                    line(237,212,212,237);
                    end;

until (i=10) or (win=true);
readln;
closegraph;


end.


