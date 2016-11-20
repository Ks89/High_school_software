program forza_quattro_1_0;
uses crt,graph;
var
   gate:array[1..6,1..7] of integer;
   i,riga,col,cc1,cc2,a,b,player,c1,c2,giro,x:integer;
   win1,win2:boolean;
   gd,gm:word;
   name1,name2:string;
   p:pointer;

procedure grafica;
begin
     detectgraph(gd,gm);
     initgraph(gd,gm,'');
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
     str:='Anno 2007 (c)KS89';
     gotoxy((80-length(str)) div 2,wherey);
     writeln(str);
     delay(1000);
     clrscr;

     textcolor(lightred);
     writeln('Avvio in corso');
     delay(500);
     clrscr;
     textcolor(lightcyan);
     str:='Forza4 1.0';
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
     str:='Ogni giocatore deve posizionare delle pedine sulle colonne';
     gotoxy((80-length(str)) div 2,wherey);
     delay(500);
     writeln(str);
     writeln;
     textcolor(yellow);
     str:='Vince chi posiziona 4 simboli uguali';
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
repeat
     clrscr;
     textcolor(lightgreen);
     writeln('Impostazioni torneo');
     writeln;
     textcolor(yellow);
     write('Quante partite vuoi fare? [min 2] : ');
     textcolor(lightmagenta);
     readln(giro);
     if giro<2 then begin
                         writeln('Numero di partite inferiore a 2!');
                         giro:=0;
                         clrscr;
                       end;
until giro>=2;
     writeln;
     textcolor(lightred);
     writeln('Premi un tasto per contiuare');
     readln;
     clrscr;

end;

procedure gate1;
begin
     {stampa il titolo}
     setcolor(lightgreen);
     settextstyle(GothicFont,Horizdir,8);
     outtextxy(300,100,'Forza4');

     setcolor(lightmagenta);
     settextstyle(gothicfont,horizdir,8);
     outtextxy(800,100,'1.0');

     setcolor(lightblue);
     settextstyle(gothicfont,horizdir,4);
     outtextxy(300,200,'Express version');

{-----------------------------------disegna la griglia--------------------------------}

     setcolor(white);
     setfillstyle(solidfill,white);
     bar(100,340,380,580);

     setfillstyle(solidfill,black);
     {questi danno problemi}
     fillellipse(120,400,19,19);
     fillellipse(160,400,19,19);
     fillellipse(200,400,19,19);
     fillellipse(240,400,19,19);
     fillellipse(280,400,19,19);
     fillellipse(320,400,19,19);
     fillellipse(360,400,19,19);
     {questi non danno problemi}
     fillellipse(120,440,19,19);
     fillellipse(160,440,19,19);
     fillellipse(200,440,19,19);
     fillellipse(240,440,19,19);
     fillellipse(280,440,19,19);
     fillellipse(320,440,19,19);
     fillellipse(360,440,19,19);
     fillellipse(120,480,19,19);
     fillellipse(160,480,19,19);
     fillellipse(200,480,19,19);
     fillellipse(240,480,19,19);
     fillellipse(280,480,19,19);
     fillellipse(320,480,19,19);
     fillellipse(360,480,19,19);
     fillellipse(120,520,19,19);
     fillellipse(160,520,19,19);
     fillellipse(200,520,19,19);
     fillellipse(240,520,19,19);
     fillellipse(280,520,19,19);
     fillellipse(320,520,19,19);
     fillellipse(360,520,19,19);
     fillellipse(120,560,19,19);
     fillellipse(160,560,19,19);
     fillellipse(200,560,19,19);
     fillellipse(240,560,19,19);
     fillellipse(280,560,19,19);
     fillellipse(320,560,19,19);
     fillellipse(360,560,19,19);

     setcolor(cyan);
     setfillstyle(solidfill,cyan);
     bar(100,300,380,340);

     setcolor(black);
     setfillstyle(solidfill,black);
     fillellipse(120,320,18,18);
     fillellipse(160,320,18,18);
     fillellipse(200,320,18,18);
     fillellipse(240,320,18,18);
     fillellipse(280,320,18,18);
     fillellipse(320,320,18,18);
     fillellipse(360,320,18,18);
end;

procedure gate2;
begin

     getmem(p, imagesize(100,300,140,340));
     getimage(100,300,140,340,p^);
     putimage(100,340,p^,normalput);
     setcolor(black);
     setfillstyle(solidfill,black);
     fillellipse(120,320,18,18);


     getmem(p, imagesize(140,300,180,340));
     getimage(140,300,180,340,p^);
     putimage(140,340,p^,normalput);
     setcolor(black);
     setfillstyle(solidfill,black);
     fillellipse(160,320,18,18);


     getmem(p, imagesize(180,300,220,340));
     getimage(180,300,220,340,p^);
     putimage(180,340,p^,normalput);
     setcolor(black);
     setfillstyle(solidfill,black);
     fillellipse(200,320,18,18);


     getmem(p, imagesize(220,300,260,340));
     getimage(220,300,260,340,p^);
     putimage(220,340,p^,normalput);
     setcolor(black);
     setfillstyle(solidfill,black);
     fillellipse(240,320,18,18);


     getmem(p, imagesize(260,300,300,340));
     getimage(260,300,300,340,p^);
     putimage(260,340,p^,normalput);
     setcolor(black);
     setfillstyle(solidfill,black);
     fillellipse(280,320,18,18);


     getmem(p, imagesize(300,300,340,340));
     getimage(300,300,340,340,p^);
     putimage(300,340,p^,normalput);
     setcolor(black);
     setfillstyle(solidfill,black);
     fillellipse(320,320,18,18);

     getmem(p, imagesize(340,300,380,340));
     getimage(340,300,380,340,p^);
     putimage(340,340,p^,normalput);
     setcolor(black);
     setfillstyle(solidfill,black);
     fillellipse(360,320,18,18);

     setcolor(black);
     setfillstyle(solidfill,black);
     bar(100,300,380,340);


     setcolor(white);
     setfillstyle(solidfill,white);
     bar(100,600,380,640);
     setcolor(black);
     setfillstyle(solidfill,black);
     fillellipse(120,620,18,18);
     fillellipse(160,620,18,18);
     fillellipse(200,620,18,18);
     fillellipse(240,620,18,18);
     fillellipse(280,620,18,18);
     fillellipse(320,620,18,18);
     fillellipse(360,620,18,18);


     getmem(p, imagesize(100,600,380,640));
     getimage(100,600,380,640,p^);
     putimage(100,340,p^,normalput);

     setcolor(black);
     setfillstyle(solidfill,black);
     bar(100,600,380,640);


     settextstyle(gothicfont,horizdir,1);
     setcolor(yellow);
     outtextxy(118,302,'1');
     outtextxy(158,302,'2');
     outtextxy(198,302,'3');
     outtextxy(238,302,'4');
     outtextxy(278,302,'5');
     outtextxy(318,302,'6');
     outtextxy(358,302,'7');
end;


begin
     x:=0;
     grafica;
     gate1;
     gate2;
     centra;
     textcolor(yellow);
     clrscr;
     cc1:=0;
     cc2:=0;
     for a:=1 to 6 do for b:=1 to 7 do gate[a,b]:=0;
     win1:=false;
     win2:=false;
     i:=1;
     player:=0;
     clrscr;
repeat
      textcolor(yellow);
      write('Giocatore 1 scegli il tuo nome :');
      textcolor(lightmagenta);
      readln(name1);
      writeln;
      textcolor(yellow);
      write('Giocatore 2 scegli il tuo nome :');
      textcolor(lightmagenta);
      readln(name2);
      if name1=name2 then begin
                               clrscr;
                               textcolor(cyan);
                               writeln('Errore, nomi uguali');
                               clrscr;
                          end;
until name1<>name2;
      writeln;
      textcolor(lightred);
      writeln('Premi un tasto per continuare');
      readln;
      textcolor(yellow);
repeat
      x:=x+1;
repeat
      i:=i+1;
      player:=i mod 2;
      if player=0 then begin
                       repeat
                             clrscr;
                             writeln(name1,' scegli la colonna');
                             readln(c1);
                       until c1<=7;
                       end;
      if player<>0 then begin
                       repeat
                             clrscr;
                             writeln(name2,' scegli la colonna');
                             readln(c2);
                       until c1<=7;
                       end;

{posizione nella griglia, per giocatore1}
if player=0 then begin
      for cc1:=1 to 7 do begin
      if c1=cc1 then begin
                        if gate[1,cc1]=0 then begin
                           if gate [2,cc1]=0 then begin
                              if gate [3,cc1]=0 then begin
                                 if gate [4,cc1]=0 then begin
                                    if gate [5,cc1]=0 then begin
                                       if gate [6,cc1]=0 then gate[6,cc1]:=1
                                       else gate[5,cc1]:=1;
                                                         end
                                    else gate[4,cc1]:=1;
                                                         end
                                 else gate[3,cc1]:=1;
                                                      end
                              else gate[2,cc1]:=1;
                                                   end
                           else gate[1,cc1]:=1;
                                                end
                        else begin
                                  writeln;
                                  textcolor(lightgreen);
                                  writeln('Errore, La colonna ',chr(138),' gi',chr(133),' occupata');
                                  i:=i-1;
                                  textcolor(yellow);
                                  delay(700);
                                  clrscr;
                              end;

                                            end;


                            end;
end;


{posizione nella griglia, per giocatore1}
if player<>0 then begin
      for cc2:=1 to 7 do begin
      if c2=cc2 then begin
                        if gate[1,cc2]=0 then begin
                           if gate [2,cc2]=0 then begin
                              if gate [3,cc2]=0 then begin
                                 if gate [4,cc2]=0 then begin
                                    if gate [5,cc2]=0 then begin
                                       if gate [6,cc2]=0 then gate[6,cc2]:=2
                                       else gate[5,cc2]:=2;
                                                         end
                                    else gate[4,cc2]:=2;
                                                         end
                                 else gate[3,cc2]:=2;
                                                      end
                              else gate[2,cc2]:=2;
                                                   end
                           else gate[1,cc2]:=2;
                                                end
                        else begin
                                  writeln;
                                  textcolor(lightgreen);
                                  writeln('Errore, La colonna ',chr(138),' gi',chr(133),' occupata');
                                  i:=i-1;
                                  textcolor(yellow);
                                  delay(700);
                                  clrscr;
                              end;

                                            end;

                            end;
end;
{-----------------------------Giocatore1-------------------------}


{controlla 4 sulle colonne}         {ste istruzioni sono INUTILI, ma dato che è un miracolo che va le lascio, per evitare di far cagate}
if (gate[1,1]=1) and (gate[2,1]=1) and (gate[3,1]=1) and (gate[4,1]=1) then win1:=true;

if (gate[3,1]=1) and (gate[4,1]=1) and (gate[5,1]=1) and (gate[6,1]=1) then win1:=true;

if (gate[2,1]=1) and (gate[3,1]=1) and (gate[4,1]=1) and (gate[5,1]=1) then win1:=true;

if (gate[1,2]=1) and (gate[2,2]=1) and (gate[3,2]=1) and (gate[4,2]=1) then win1:=true;
if (gate[3,2]=1) and (gate[4,2]=1) and (gate[5,2]=1) and (gate[6,2]=1) then win1:=true;
if (gate[2,2]=1) and (gate[3,2]=1) and (gate[4,2]=1) and (gate[5,2]=1) then win1:=true;

if (gate[1,3]=1) and (gate[2,3]=1) and (gate[3,3]=1) and (gate[4,3]=1) then win1:=true;
if (gate[3,3]=1) and (gate[4,3]=1) and (gate[5,3]=1) and (gate[6,3]=1) then win1:=true;
if (gate[2,3]=1) and (gate[3,3]=1) and (gate[4,3]=1) and (gate[5,3]=1) then win1:=true;

if (gate[1,4]=1) and (gate[2,4]=1) and (gate[3,4]=1) and (gate[4,4]=1) then win1:=true;
if (gate[3,4]=1) and (gate[4,4]=1) and (gate[5,4]=1) and (gate[6,4]=1) then win1:=true;
if (gate[2,4]=1) and (gate[3,4]=1) and (gate[4,4]=1) and (gate[5,4]=1) then win1:=true;

if (gate[1,5]=1) and (gate[2,5]=1) and (gate[3,5]=1) and (gate[4,5]=1) then win1:=true;
if (gate[3,5]=1) and (gate[4,5]=1) and (gate[5,5]=1) and (gate[6,5]=1) then win1:=true;
if (gate[2,5]=1) and (gate[3,5]=1) and (gate[4,5]=1) and (gate[5,5]=1) then win1:=true;

if (gate[1,6]=1) and (gate[2,6]=1) and (gate[3,6]=1) and (gate[4,6]=1) then win1:=true;
if (gate[3,6]=1) and (gate[4,6]=1) and (gate[5,6]=1) and (gate[6,6]=1) then win1:=true;
if (gate[2,6]=1) and (gate[3,6]=1) and (gate[4,6]=1) and (gate[5,6]=1) then win1:=true;

{controlla 4 sulle colonne}
for col:=1 to 6 do begin
                      if gate[1,col]=1 then if gate[2,col]=1 then if gate[3,col]=1 then if gate[4,col]=1 then win1:=true;
                      if gate[3,col]=1 then if gate[4,col]=1 then if gate[5,col]=1 then if gate[6,col]=1 then win1:=true;
                      if gate[2,col]=1 then if gate[3,col]=1 then if gate[4,col]=1 then if gate[5,col]=1 then win1:=true;
                   end;
{conotrlla 4 sulle righe}
for riga:=1 to 6 do begin
                      if gate[riga,1]=1 then if gate[riga,2]=1 then if gate[riga,3]=1 then if gate[riga,4]=1 then win1:=true;
                      if gate[riga,2]=1 then if gate[riga,3]=1 then if gate[riga,4]=1 then if gate[riga,5]=1 then win1:=true;
                      if gate[riga,3]=1 then if gate[riga,4]=1 then if gate[riga,5]=1 then if gate[riga,6]=1 then win1:=true;
                      if gate[riga,4]=1 then if gate[riga,5]=1 then if gate[riga,6]=1 then if gate[riga,7]=1 then win1:=true;
                    end;
{controlla 4 sulle diagonali}
if gate[3,1]=1 then if gate[4,2]=1 then if gate[5,3]=1 then if gate[6,4]=1 then win1:=true; {1}

if gate[2,1]=1 then if gate[3,2]=1 then if gate[4,3]=1 then if gate[5,4]=1 then win1:=true; {2a}
if gate[3,2]=1 then if gate[4,3]=1 then if gate[5,4]=1 then if gate[6,5]=1 then win1:=true; {2b}

if gate[1,1]=1 then if gate[2,2]=1 then if gate[3,3]=1 then if gate[4,4]=1 then win1:=true; {3a}
if gate[2,2]=1 then if gate[3,3]=1 then if gate[4,4]=1 then if gate[5,5]=1 then win1:=true; {3b}
if gate[3,3]=1 then if gate[4,4]=1 then if gate[5,5]=1 then if gate[6,6]=1 then win1:=true; {3c}

if gate[1,2]=1 then if gate[2,3]=1 then if gate[3,4]=1 then if gate[4,5]=1 then win1:=true; {4a}
if gate[2,3]=1 then if gate[3,4]=1 then if gate[4,5]=1 then if gate[5,6]=1 then win1:=true; {4b}
if gate[3,4]=1 then if gate[4,5]=1 then if gate[5,6]=1 then if gate[6,7]=1 then win1:=true; {4c}

if gate[1,3]=1 then if gate[2,4]=1 then if gate[3,5]=1 then if gate[4,6]=1 then win1:=true; {5a}
if gate[2,4]=1 then if gate[3,5]=1 then if gate[4,6]=1 then if gate[5,7]=1 then win1:=true; {5b}

if gate[1,4]=1 then if gate[2,5]=1 then if gate[3,6]=1 then if gate[4,7]=1 then win1:=true; {6}



{controlla 4 sulle diagonali mell'altro senso}
if gate[4,1]=1 then if gate[3,2]=1 then if gate[2,3]=1 then if gate[1,4]=1 then win1:=true; {1}

if gate[5,1]=1 then if gate[4,2]=1 then if gate[3,3]=1 then if gate[2,4]=1 then win1:=true; {2a}
if gate[4,2]=1 then if gate[3,3]=1 then if gate[2,4]=1 then if gate[1,5]=1 then win1:=true; {2b}

if gate[6,1]=1 then if gate[5,2]=1 then if gate[4,3]=1 then if gate[3,4]=1 then win1:=true; {3a}
if gate[4,3]=1 then if gate[3,4]=1 then if gate[2,5]=1 then if gate[1,6]=1 then win1:=true; {3b}
if gate[5,2]=1 then if gate[4,3]=1 then if gate[3,4]=1 then if gate[2,5]=1 then win1:=true; {3c}

if gate[6,2]=1 then if gate[5,3]=1 then if gate[4,4]=1 then if gate[3,5]=1 then win1:=true; {4a}
if gate[4,4]=1 then if gate[3,5]=1 then if gate[2,6]=1 then if gate[1,7]=1 then win1:=true; {4b}
if gate[5,3]=1 then if gate[4,4]=1 then if gate[3,5]=1 then if gate[2,6]=1 then win1:=true; {4c}

if gate[5,4]=1 then if gate[4,5]=1 then if gate[3,6]=1 then if gate[2,7]=1 then win1:=true; {5a}
if gate[6,3]=1 then if gate[5,4]=1 then if gate[4,5]=1 then if gate[3,6]=1 then win1:=true; {5b}

if gate[6,4]=1 then if gate[5,5]=1 then if gate[4,6]=1 then if gate[3,7]=1 then win1:=true; {6}



{-----------------------------Giocatore2-------------------------}
{controlla 4 sulle colonne}
for col:=1 to 6 do begin
                      if gate[1,col]=2 then if gate[2,col]=2 then if gate[3,col]=2 then if gate[4,col]=2 then win2:=true;
                      if gate[3,col]=2 then if gate[4,col]=2 then if gate[5,col]=2 then if gate[6,col]=2 then win2:=true;
                      if gate[2,col]=2 then if gate[3,col]=2 then if gate[4,col]=2 then if gate[5,col]=2 then win2:=true;
                   end;
{conotrlla 4 sulle righe}
for riga:=1 to 6 do begin
                      if gate[riga,1]=2 then if gate[riga,2]=2 then if gate[riga,3]=2 then if gate[riga,4]=2 then win2:=true;
                      if gate[riga,2]=2 then if gate[riga,3]=2 then if gate[riga,4]=2 then if gate[riga,5]=2 then win2:=true;
                      if gate[riga,3]=2 then if gate[riga,4]=2 then if gate[riga,5]=2 then if gate[riga,6]=2 then win2:=true;
                      if gate[riga,4]=2 then if gate[riga,5]=2 then if gate[riga,6]=2 then if gate[riga,7]=2 then win2:=true;
                    end;
{controlla 4 sulle diagonali}
if gate[3,1]=2 then if gate[4,2]=2 then if gate[5,3]=2 then if gate[6,4]=2 then win2:=true;  {1}

if gate[2,1]=2 then if gate[3,2]=2 then if gate[4,3]=2 then if gate[5,4]=2 then win2:=true;  {2a}
if gate[3,2]=2 then if gate[4,3]=2 then if gate[5,4]=2 then if gate[6,5]=2 then win2:=true;  {2b}

if gate[1,1]=2 then if gate[2,2]=2 then if gate[3,3]=2 then if gate[4,4]=2 then win2:=true;  {3a}
if gate[2,2]=2 then if gate[3,3]=2 then if gate[4,4]=2 then if gate[5,5]=2 then win2:=true;  {3b}
if gate[3,3]=2 then if gate[4,4]=2 then if gate[5,5]=2 then if gate[6,6]=2 then win2:=true;  {3c}

if gate[1,2]=2 then if gate[2,3]=2 then if gate[3,4]=2 then if gate[4,5]=2 then win2:=true;  {4a}
if gate[2,3]=2 then if gate[3,4]=2 then if gate[4,5]=2 then if gate[5,6]=2 then win2:=true;  {4b}
if gate[3,4]=2 then if gate[4,5]=2 then if gate[5,6]=2 then if gate[6,7]=2 then win2:=true;  {4c}

if gate[1,3]=2 then if gate[2,4]=2 then if gate[3,5]=2 then if gate[4,6]=2 then win2:=true;  {5a}
if gate[2,4]=2 then if gate[3,5]=2 then if gate[4,6]=2 then if gate[5,7]=2 then win2:=true;  {5b}

if gate[1,4]=2 then if gate[2,5]=2 then if gate[3,6]=2 then if gate[4,7]=2 then win2:=true;  {6}


{controlla 4 sulle diagonali mell'altro senso}
if gate[4,1]=1 then if gate[3,2]=2 then if gate[2,3]=2 then if gate[1,4]=2 then win2:=true; {1}

if gate[5,1]=2 then if gate[4,2]=2 then if gate[3,3]=2 then if gate[2,4]=2 then win2:=true; {2a}
if gate[4,2]=2 then if gate[3,3]=2 then if gate[2,4]=2 then if gate[1,5]=2 then win2:=true; {2b}

if gate[6,1]=2 then if gate[5,2]=2 then if gate[4,3]=2 then if gate[3,4]=2 then win2:=true; {3a}
if gate[4,3]=2 then if gate[3,4]=2 then if gate[2,5]=2 then if gate[1,6]=2 then win2:=true; {3b}
if gate[5,2]=2 then if gate[4,3]=2 then if gate[3,4]=2 then if gate[2,5]=2 then win2:=true; {3c}

if gate[6,2]=2 then if gate[5,3]=2 then if gate[4,4]=2 then if gate[3,5]=2 then win2:=true; {4a}
if gate[4,4]=2 then if gate[3,5]=2 then if gate[2,6]=2 then if gate[1,7]=2 then win2:=true; {4b}
if gate[5,3]=2 then if gate[4,4]=2 then if gate[3,5]=2 then if gate[2,6]=2 then win2:=true; {4c}

if gate[5,4]=2 then if gate[4,5]=2 then if gate[3,6]=2 then if gate[2,7]=2 then win2:=true; {5a}
if gate[6,3]=2 then if gate[5,4]=2 then if gate[4,5]=2 then if gate[3,6]=2 then win2:=true; {5b}

if gate[6,4]=2 then if gate[5,5]=2 then if gate[4,6]=2 then if gate[3,7]=2 then win2:=true; {6}


if gate[1,1]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(120,320,18,18);
                    end;
if gate[1,2]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(160,320,18,18);
                    end;
if gate[1,3]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(200,320,18,18);
                    end;
if gate[1,4]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(240,320,18,18);
                    end;
if gate[1,5]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(280,320,18,18);
                    end;
if gate[1,6]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(320,320,18,18);
                    end;
if gate[1,7]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(360,280,18,18);
                    end;

if gate[2,1]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(120,400,18,18);
                    end;
if gate[2,2]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(160,400,18,18);
                    end;
if gate[2,3]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(200,400,18,18);
                    end;
if gate[2,4]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(240,400,18,18);
                    end;
if gate[2,5]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(280,400,18,18);
                    end;
if gate[2,6]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(320,400,18,18);
                    end;
if gate[2,7]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(360,400,18,18);
                    end;

if gate[3,1]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(120,440,18,18);
                    end;
if gate[3,2]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(160,440,18,18);
                    end;
if gate[3,3]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(200,440,18,18);
                    end;
if gate[3,4]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(240,440,18,18);
                    end;
if gate[3,5]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(280,440,18,18);
                    end;
if gate[3,6]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(320,440,18,18);
                    end;
if gate[3,7]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(360,440,18,18);
                    end;


if gate[4,1]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(120,480,18,18);
                    end;
if gate[4,2]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(160,480,18,18);
                    end;
if gate[4,3]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(200,480,18,18);
                    end;
if gate[4,4]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(240,480,18,18);
                    end;
if gate[4,5]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(280,480,18,18);
                    end;
if gate[4,6]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(320,480,18,18);
                    end;
if gate[4,7]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(360,480,18,18);
                    end;

if gate[5,1]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(120,520,18,18);
                    end;
if gate[5,2]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(160,520,18,18);
                    end;
if gate[5,3]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(200,520,18,18);
                    end;
if gate[5,4]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(240,520,18,18);
                    end;
if gate[5,5]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(280,520,18,18);
                    end;
if gate[5,6]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(320,520,18,18);
                    end;
if gate[5,7]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(360,520,18,18);
                    end;

if gate[6,1]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(120,560,18,18);
                    end;
if gate[6,2]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(160,560,18,18);
                    end;
if gate[6,3]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(200,560,18,18);
                    end;
if gate[6,4]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(240,560,18,18);
                    end;
if gate[6,5]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(280,560,18,18);
                    end;
if gate[6,6]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(320,560,18,18);
                    end;
if gate[6,7]=1 then begin
                    setcolor(lightred);
                    setfillstyle(solidfill,lightred);
                    fillellipse(360,560,18,18);
                    end;




if gate[1,1]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(120,320,18,18);
                    end;
if gate[1,2]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(160,320,18,18);
                    end;
if gate[1,3]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(200,320,18,18);
                    end;
if gate[1,4]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(240,320,18,18);
                    end;
if gate[1,5]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(280,320,18,18);
                    end;
if gate[1,6]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(320,320,18,18);
                    end;
if gate[1,7]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(360,320,18,18);
                    end;

if gate[2,1]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(120,400,18,18);
                    end;
if gate[2,2]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(160,400,18,18);
                    end;
if gate[2,3]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(200,400,18,18);
                    end;
if gate[2,4]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(240,400,18,18);
                    end;
if gate[2,5]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(280,400,18,18);
                    end;
if gate[2,6]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(320,400,18,18);
                    end;
if gate[2,7]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(360,400,18,18);
                    end;

if gate[3,1]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(120,440,18,18);
                    end;
if gate[3,2]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(160,440,18,18);
                    end;
if gate[3,3]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(200,440,18,18);
                    end;
if gate[3,4]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(240,440,18,18);
                    end;
if gate[3,5]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(280,440,18,18);
                    end;
if gate[3,6]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(320,440,18,18);
                    end;
if gate[3,7]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(360,440,18,18);
                    end;


if gate[4,1]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(120,480,18,18);
                    end;
if gate[4,2]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(160,480,18,18);
                    end;
if gate[4,3]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(200,480,18,18);
                    end;
if gate[4,4]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(240,480,18,18);
                    end;
if gate[4,5]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(280,480,18,18);
                    end;
if gate[4,6]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(320,480,18,18);
                    end;
if gate[4,7]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(360,480,18,18);
                    end;

if gate[5,1]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(120,520,18,18);
                    end;
if gate[5,2]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(160,520,18,18);
                    end;
if gate[5,3]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(200,520,18,18);
                    end;
if gate[5,4]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(240,520,18,18);
                    end;
if gate[5,5]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(280,520,18,18);
                    end;
if gate[5,6]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(320,520,18,18);
                    end;
if gate[5,7]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(360,520,18,18);
                    end;

if gate[6,1]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(120,560,18,18);
                    end;
if gate[6,2]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(160,560,18,18);
                    end;
if gate[6,3]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(200,560,18,18);
                    end;
if gate[6,4]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(240,560,18,18);
                    end;
if gate[6,5]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(280,560,18,18);
                    end;
if gate[6,6]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(320,560,18,18);
                    end;
if gate[6,7]=2 then begin
                    setcolor(yellow);
                    setfillstyle(solidfill,yellow);
                    fillellipse(360,560,18,18);
                    end;


{questi comandi copiano la file di gettoni + alta e la mettono nella cella giusta, e poi sovrappongono di nero quelle sbaglite. Sono stato costretto
a farlo, perchè senza non saprei come risolvere}
if gate[1,1]=1 then begin
                         getmem(p, imagesize(101,300,140,340));
                         getimage(101,300,140,340,p^);
                         putimage(100,340,p^,normalput);
                         setcolor(black);
                         setfillstyle(solidfill,black);
                         fillellipse(120,320,18,18);
                         setcolor(white);
                         setfillstyle(solidfill,white);
                         bar(100,340,140,380);
                         setfillstyle(solidfill,lightred);
                         fillellipse(120,360,20,20);
                    end;

if gate[1,2]=1 then begin
                         getmem(p, imagesize(141,300,180,340));
                         getimage(141,300,180,340,p^);
                         putimage(140,340,p^,normalput);
                         setcolor(black);
                         setfillstyle(solidfill,black);
                         fillellipse(160,320,18,18);
                         setcolor(white);
                         setfillstyle(solidfill,white);
                         bar(140,340,180,380);
                         setfillstyle(solidfill,lightred);
                         fillellipse(160,360,20,20);
                    end;
if gate[1,3]=1 then begin
                         getmem(p, imagesize(181,300,220,340));
                         getimage(181,300,220,340,p^);
                         putimage(180,340,p^,normalput);
                         setcolor(black);
                         setfillstyle(solidfill,black);
                         fillellipse(200,320,18,18);
                         setcolor(white);
                         setfillstyle(solidfill,white);
                         bar(180,340,220,380);
                         setfillstyle(solidfill,lightred);
                         fillellipse(200,360,20,20);
                    end;
if gate[1,4]=1 then begin
                         getmem(p, imagesize(221,300,260,340));
                         getimage(221,300,260,340,p^);
                         putimage(220,340,p^,normalput);
                         setcolor(black);
                         setfillstyle(solidfill,black);
                         fillellipse(240,320,18,18);
                         setcolor(white);
                         setfillstyle(solidfill,white);
                         bar(220,340,260,380);
                         setfillstyle(solidfill,lightred);
                         fillellipse(240,360,20,20);
                    end;
if gate[1,5]=1 then begin
                         getmem(p, imagesize(261,300,300,340));
                         getimage(261,300,300,340,p^);
                         putimage(260,340,p^,normalput);
                         setcolor(black);
                         setfillstyle(solidfill,black);
                         fillellipse(280,320,18,18);
                         setcolor(white);
                         setfillstyle(solidfill,white);
                         bar(260,340,300,380);
                         setfillstyle(solidfill,lightred);
                         fillellipse(280,360,20,20);
                    end;
if gate[1,6]=1 then begin
                         getmem(p, imagesize(301,300,340,340));
                         getimage(301,300,340,340,p^);
                         putimage(300,340,p^,normalput);
                         setcolor(black);
                         setfillstyle(solidfill,black);
                         fillellipse(320,320,18,18);
                         setcolor(white);
                         setfillstyle(solidfill,white);
                         bar(300,340,340,380);
                         setfillstyle(solidfill,lightred);
                         fillellipse(320,360,20,20);
                    end;
if gate[1,7]=1 then begin
                         getmem(p, imagesize(341,300,380,340));
                         getimage(341,300,380,340,p^);
                         putimage(340,340,p^,normalput);
                         getmem(p, imagesize(340,260,380,300));
                         getimage(340,260,380,300,p^);
                         setcolor(black);
                         setfillstyle(solidfill,black);
                         fillellipse(360,280,18,18);
                         setcolor(white);
                         setfillstyle(solidfill,white);
                         bar(340,340,380,380);
                         setfillstyle(solidfill,lightred);
                         fillellipse(360,360,20,20);
                    end;


if gate[1,1]=2 then begin
                         getmem(p, imagesize(101,300,140,340));
                         getimage(101,300,140,340,p^);
                         putimage(100,340,p^,normalput);
                         setcolor(black);
                         setfillstyle(solidfill,black);
                         fillellipse(120,320,18,18);
                         setcolor(white);
                         setfillstyle(solidfill,white);
                         bar(100,340,140,380);
                         setfillstyle(solidfill,yellow);
                         fillellipse(120,360,20,20);
                    end;

if gate[1,2]=2 then begin
                         getmem(p, imagesize(141,300,180,340));
                         getimage(141,300,180,340,p^);
                         putimage(140,340,p^,normalput);
                         setcolor(black);
                         setfillstyle(solidfill,black);
                         fillellipse(160,320,18,18);
                         setcolor(white);
                         setfillstyle(solidfill,white);
                         bar(140,340,180,380);
                         setfillstyle(solidfill,yellow);
                         fillellipse(160,360,20,20);
                    end;
if gate[1,3]=2 then begin
                         getmem(p, imagesize(181,300,220,340));
                         getimage(181,300,220,340,p^);
                         putimage(180,340,p^,normalput);
                         setcolor(black);
                         setfillstyle(solidfill,black);
                         fillellipse(200,320,18,18);
                         setcolor(white);
                         setfillstyle(solidfill,white);
                         bar(180,340,220,380);
                         setfillstyle(solidfill,yellow);
                         fillellipse(200,360,20,20);
                    end;
if gate[1,4]=2 then begin
                         getmem(p, imagesize(221,300,260,340));
                         getimage(221,300,260,340,p^);
                         putimage(220,340,p^,normalput);
                         setcolor(black);
                         setfillstyle(solidfill,black);
                         fillellipse(240,320,18,18);
                         setcolor(white);
                         setfillstyle(solidfill,white);
                         bar(220,340,260,380);
                         setfillstyle(solidfill,yellow);
                         fillellipse(240,360,20,20);
                    end;
if gate[1,5]=2 then begin
                         getmem(p, imagesize(261,300,300,340));
                         getimage(261,300,300,340,p^);
                         putimage(260,340,p^,normalput);
                         setcolor(black);
                         setfillstyle(solidfill,black);
                         fillellipse(280,320,18,18);
                         setcolor(white);
                         setfillstyle(solidfill,white);
                         bar(260,340,300,380);
                         setfillstyle(solidfill,yellow);
                         fillellipse(280,360,20,20);
                    end;
if gate[1,6]=2 then begin
                         getmem(p, imagesize(301,300,340,340));
                         getimage(301,300,340,340,p^);
                         putimage(300,340,p^,normalput);
                         setcolor(black);
                         setfillstyle(solidfill,black);
                         fillellipse(320,320,18,18);
                         setcolor(white);
                         setfillstyle(solidfill,white);
                         bar(300,340,340,380);
                         setfillstyle(solidfill,yellow);
                         fillellipse(320,360,20,20);
                    end;
if gate[1,7]=2 then begin
                         getmem(p, imagesize(341,300,380,340));
                         getimage(341,300,380,340,p^);
                         putimage(340,340,p^,normalput);
                         getmem(p, imagesize(340,260,380,300));
                         getimage(340,260,380,300,p^);
                         setcolor(black);
                         setfillstyle(solidfill,black);
                         fillellipse(360,280,18,18);
                         setcolor(white);
                         setfillstyle(solidfill,white);
                         bar(340,340,380,380);
                         setfillstyle(solidfill,yellow);
                         fillellipse(360,360,20,20);
                    end;


clrscr;
settextstyle(gothicfont,horizdir,1);
setcolor(yellow);
outtextxy(118,302,'1');
outtextxy(158,302,'2');
outtextxy(198,302,'3');
outtextxy(238,302,'4');
outtextxy(278,302,'5');
outtextxy(318,302,'6');
outtextxy(358,302,'7');
setcolor(white);

until (i=42) or (win1=true) or (win2=true);
cleardevice;
if win1=true then begin
                  textcolor(white);
                  write(name1);
                  textcolor(yellow);
                  writeln(' ha vinto');
                  end;
if win2=true then begin
                  textcolor(white);
                  write(name2);
                  textcolor(yellow);
                  writeln(' ha vinto');
                  end;
clrscr;
textcolor(lightcyan);
writeln('Turno ',x,' completato');
textcolor(yellow);
writeln;
writeln('Hai ancora ',giro-x,' per terminare il torneo');
writeln;
textcolor(lightred);
writeln('Premi un tasto per continuare');
readln;
textcolor(yellow);
win1:=false;
win2:=false;
cc1:=0;
cc2:=0;
for a:=1 to 6 do for b:=1 to 7 do gate[a,b]:=0;
win1:=false;
win2:=false;
i:=1;
player:=0;
clrscr;
gate1;
gate2;
until x=giro;
closegraph;
end.


