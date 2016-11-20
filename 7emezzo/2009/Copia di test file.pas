program a;
uses crt,graph;
type nomerec =record
       nome1:string[10];
      end;
      nomefile = file of nomerec;



var
   codice,codice_letto_num:array[1..5] of integer;
   risposta:array[1..10] of integer;
   i:integer;
   code1,code2,code3,code4,code5,codice_letto_str,codice_stringa,aaa:string;
   lab1,lab2,lab3,lab4,lab5,lab6,lab7,lab8,lab9:boolean;
var_nomerec :nomerec;
var_nomefile: nomefile;
begin
     lab1:=false;
     lab2:=false;
     lab3:=false;
     lab4:=false;
     lab5:=false;
     lab6:=false;
     lab7:=false;
     lab8:=false;
     lab9:=false;

     clrscr;
{leggo il file, se è la prima volta che avvio nel file c'è '00000', quindi in questo caso genero il codice a caso}
     assign(var_nomefile,'C:\library.dll');
     reset(var_nomefile);
     var_nomerec.nome1:='    ';
     read(var_nomefile,var_nomerec);
     close(var_nomefile);
     codice_letto_str:=var_nomerec.nome1;


if codice_letto_str='00000' then begin
                    randomize;
                    codice[1]:=random(8);
                    codice[2]:=random(8);
                    codice[3]:=random(8);
                    codice[4]:=random(8);
                    codice[5]:=random(8);
                    textcolor(lightgreen);
                    writeln('..::Registrazione 7 e mezzo::..');
                    writeln;
                    textcolor(lightcyan);
                    writeln('Per procedere e'' necessario inserire il codice di risposta');
                    writeln('Invia una mail a ks89 il tuo codice utente e riceverai quello di risposta');
                    writeln;
                    writeln;
                    textcolor(yellow);
                    write('Il tuo codice utente appena generato e'':  ');
                    textcolor(lightmagenta);
                    for i:=1 to 5 do write(codice[i],' ');
                    textcolor(yellow);

                    writeln;
                    writeln('Inserisci il codice di risposta numero per numero');
                    textcolor(white);
                    read(risposta[1]);
                    read(risposta[2]);
                    read(risposta[3]);
                    read(risposta[4]);
                    read(risposta[5]);
                    read(risposta[6]);
                    read(risposta[7]);
                    read(risposta[8]);
                    read(risposta[9]);
                    read(risposta[10]);


                    if (codice[1]=risposta[3]) then lab1:=true;
                    if (codice[2]=risposta[7]) then lab2:=true;
                    if (codice[3]=risposta[10]-2) then lab3:=true;
                    if (codice[4]=risposta[2]-codice[1]-codice[2]) then lab4:=true;
                    if (risposta[1]=0) then lab5:=true;
                    if (risposta[4]=codice[5]+2) then lab6:=true;
                    if (risposta[6]=8) then lab7:=true;
                    if (risposta[8]=0) then lab8:=true;
                    if (risposta[9]=codice[3]+codice[4]-1) then lab9:=true;

                    textcolor(lightcyan);
                    writeln;
                    if lab1=lab2=lab3=lab4=lab5=lab6=lab7=lab8=lab9=true then writeln('Codice corretto, avvio programma!');
                    readln;
               end



else begin

reset(var_nomefile);
var_nomerec.nome1:='    ';
read(var_nomefile,var_nomerec);
close(var_nomefile);
codice_letto_str:=var_nomerec.nome1;
val(codice_letto_str[1],codice_letto_num[1]);
val(codice_letto_str[2],codice_letto_num[2]);
val(codice_letto_str[3],codice_letto_num[3]);
val(codice_letto_str[4],codice_letto_num[4]);
val(codice_letto_str[5],codice_letto_num[5]);


textcolor(lightgreen);
writeln('..::Registrazione 7 e mezzo::..');
writeln;
textcolor(lightcyan);
writeln('Per procedere e'' necessario inserire il codice di risposta');
writeln('Invia una mail a ks89 il tuo codice utente e riceverai quello di risposta');
writeln;
writeln;
textcolor(yellow);
write('Il tuo codice utente e'':  ');
textcolor(lightmagenta);
write(codice_letto_str);
textcolor(yellow);
writeln;
writeln('Inserisci il codice di risposta numero per numero');
textcolor(white);


     read(risposta[1]);
     read(risposta[2]);
     read(risposta[3]);
     read(risposta[4]);
     read(risposta[5]);
     read(risposta[6]);
     read(risposta[7]);
     read(risposta[8]);
     read(risposta[9]);
     read(risposta[10]);


     if (codice_letto_num[1]=risposta[3]) then lab1:=true;
     if (codice_letto_num[2]=risposta[7]) then lab2:=true;
     if (codice_letto_num[3]=risposta[10]-2) then lab3:=true;
     if (codice_letto_num[4]=risposta[2]-codice_letto_num[1]-codice_letto_num[2]) then lab4:=true;
     if (risposta[1]=0) then lab5:=true;
     if (risposta[4]=codice_letto_num[5]+2) then lab6:=true;
     if (risposta[6]=8) then lab7:=true;
     if (risposta[8]=0) then lab8:=true;
     if (risposta[9]=codice_letto_num[3]+codice_letto_num[4]-1) then lab9:=true;


     textcolor(lightcyan);
     writeln;
     if lab1=lab2=lab3=lab4=lab5=lab6=lab7=lab8=lab9=true then writeln('Codice corretto, avvio programma!');

     readln;
end;
      readln;
end.

