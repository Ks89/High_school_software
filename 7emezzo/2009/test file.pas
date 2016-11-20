program a;
uses crt,graph;


type nomerec =record
       nome1:string[10];
      end;
      nomefile = file of nomerec;

     nomerec2 =record
       nome2:string[10];
      end;
      nomefile2 = file of nomerec2;

     nomerec3 =record
       nome3:string[10];
      end;
      nomefile3 = file of nomerec3;

     nomerec4 =record
       nome4:string[25];
      end;
      nomefile4 = file of nomerec4;

      nomerec5 =record
       nome5:string[25];
      end;
      nomefile5 = file of nomerec5;

      nomerec6 =record
       nome6:string[25];
      end;
      nomefile6 = file of nomerec6;

      nomerec7 =record
       nome7:string[25];
      end;
      nomefile7 = file of nomerec7;
var
   codice,codice_letto_num,sette1_array:array[1..5] of integer;
   risposta,sette2_array:array[1..10] of integer;
   i:integer;
   codice_letto_str,test,situazione,situazione2,percorso,abc,scelta,sette1,sette2:string;
   controllo:boolean;
   lab1,lab2,lab3,lab4,lab5,lab6,lab7,lab8,lab9:boolean;
var_nomerec :nomerec;
var_nomefile: nomefile;
var_nomerec2 :nomerec2;
var_nomefile2: nomefile2;
var_nomerec3 :nomerec3;
var_nomefile3: nomefile3;
var_nomerec4 :nomerec4;
var_nomefile4: nomefile4;
var_nomerec5 :nomerec5;
var_nomefile5: nomefile5;
var_nomerec6 :nomerec6;
var_nomefile6: nomefile6;
var_nomerec7 :nomerec7;
var_nomefile7: nomefile7;
begin
     controllo:=false;
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
     assign(var_nomefile,'C:\Documents and Settings\library.dll');
     reset(var_nomefile);
     var_nomerec.nome1:='    ';
     read(var_nomefile,var_nomerec);
     close(var_nomefile);
     codice_letto_str:=var_nomerec.nome1;
{ora leggo file in system con scritto se ho già registrato il programma}
     assign(var_nomefile2,'C:\Documents and Settings\isuusp_x.dll');
     reset(var_nomefile2);
     var_nomerec2.nome2:='     ';
     read(var_nomefile2,var_nomerec2);
     situazione:=var_nomerec2.nome2;
     close(var_nomefile2);
{ora leggo file nella cartella di installazione con scritto se ho già registrato il programma}
     getdir(0, percorso);
     percorso := percorso + '\test.txt';
     assign(var_nomefile3,percorso);
     reset(var_nomefile3);
     var_nomerec3.nome3:='     ';
     read(var_nomefile3,var_nomerec3);
     situazione2:=var_nomerec3.nome3;
     close(var_nomefile3);
if (situazione='gfyuo') and (situazione2='noreg') then begin

textcolor(lightgreen);
writeln('..::Registrazione 7 e mezzo::..');
writeln;
textcolor(lightcyan);
writeln('Come vuoi registrare 7 e mezzo?');
writeln('Premi ''s'' se possiedi i 2 file .txt o qualunque altro tasto se vuoi procedere con l''immissione mnuale');
textcolor(white);
readln(scelta);
textcolor(yellow);


{questo fa registrazione partendo dai 2 file .txt}
if scelta='s' then begin
                   clrscr;
                   textcolor(lightgreen);
                   writeln('..::Registrazione 7 e mezzo::..');
                   writeln;
                   textcolor(lightcyan);
                   writeln('Metti i 2 file .txt nella cartella di installazione di 7 e mezzo insieme al file 7emezzo.exe');
                   readln;
                   writeln('Ora premi un tasto qualunque per procedere con la registrazione');
                   readln;
                   readln;
                   getdir(0, percorso);
                   percorso := percorso + '\7emezzo.txt';
                   assign(var_nomefile6,percorso);
                   reset(var_nomefile6);
                   var_nomerec6.nome6:='    ';
                   read(var_nomefile6,var_nomerec6);
                   close(var_nomefile6);
                   sette1:=var_nomerec6.nome6;
                    readln;
                   val(sette1[1],sette1_array[1]);
                   val(sette1[2],sette1_array[2]);
                   val(sette1[3],sette1_array[3]);
                   val(sette1[4],sette1_array[4]);
                   val(sette1[5],sette1_array[5]);
                    readln;
                   getdir(0, percorso);
                   percorso := percorso + '\7emezzo_2.txt';
                   assign(var_nomefile7,percorso);
                   reset(var_nomefile7);
                   var_nomerec7.nome7:='    ';
                   read(var_nomefile7,var_nomerec7);
                   close(var_nomefile7);
                   sette2:=var_nomerec7.nome7;
                    readln;
                   writeln(var_nomerec6.nome6);
                   writeln(var_nomerec7.nome7);
                   readln;
                   val(sette2[1],sette2_array[1]);
                   val(sette2[2],sette2_array[2]);
                   val(sette2[3],sette2_array[3]);
                   val(sette2[4],sette2_array[4]);
                   val(sette2[5],sette2_array[5]);
                   val(sette2[6],sette2_array[6]);
                   val(sette2[7],sette2_array[7]);
                   val(sette2[8],sette2_array[8]);
                   val(sette2[9],sette2_array[9]);
                   val(sette2[10],sette2_array[10]);
                   for i:=1 to 5 do write('-',sette1_array[i]);
                   writeln;
                   for i:=1 to 10 do write('-',sette2_array[i]);
                   readln;
                    if (sette1_array[1]=sette2_array[3]) then lab1:=true;
                    if (sette1_array[2]=sette2_array[7]) then lab2:=true;
                    if (sette1_array[3]=sette2_array[10]-2) then lab3:=true;
                    if (sette1_array[4]=sette2_array[2]-sette1_array[1]-sette1_array[2]) then lab4:=true;
                    if (sette2_array[1]=0) then lab5:=true;
                    if (sette2_array[4]=sette1_array[5]+2) then lab6:=true;
                    if (sette2_array[6]=8) then lab7:=true;
                    if (sette2_array[8]=0) then lab8:=true;
                    if (sette2_array[9]=sette1_array[3]+sette1_array[4]-1) then lab9:=true;

                    textcolor(lightcyan);
                    writeln;
                    if (lab1=true) and (lab2=true) and (lab3=true) and (lab4=true) and (lab5=true) and (lab6=true) and (lab7=true) and (lab8=true) and (lab9=true) then begin
                                       var_nomerec2.nome2:='gfyoo';
                                       assign(var_nomefile2,'C:\Documents and Settings\isuusp_x.dll');
                                       rewrite(var_nomefile2);
                                       write(var_nomefile2,var_nomerec2);
                                       close(var_nomefile2);

                                       getdir(0, percorso);
                                       percorso := percorso + '\test.txt';
                                       var_nomerec3.nome3:='sireg';
                                       assign(var_nomefile3,percorso);
                                       rewrite(var_nomefile3);
                                       write(var_nomefile3,var_nomerec3);
                                       close(var_nomefile3);
                                       writeln('Codice corretto, avvio programma!');
                                       controllo:=false;
                                       end
                    else writeln('Codice errato');
                    readln;
                   end


{questo fa la registrazion partendo dai 2 codici numerici}
else begin
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
                    for i:=1 to 5 do write(codice[i]);
                    textcolor(yellow);

                    var_nomerec.nome1:='';
                    str(codice[1],test);
                    var_nomerec.nome1:=var_nomerec.nome1+test;
                    str(codice[2],test);
                    var_nomerec.nome1:=var_nomerec.nome1+test;
                    str(codice[3],test);
                    var_nomerec.nome1:=var_nomerec.nome1+test;
                    str(codice[4],test);
                    var_nomerec.nome1:=var_nomerec.nome1+test;
                    str(codice[5],test);
                    var_nomerec.nome1:=var_nomerec.nome1+test;


                    assign(var_nomefile,'C:\Documents and Settings\library.dll');
                    rewrite(var_nomefile);
                    write(var_nomefile,var_nomerec);
                    close(var_nomefile);

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
                    if (lab1=true) and (lab2=true) and (lab3=true) and (lab4=true) and (lab5=true) and (lab6=true) and (lab7=true) and (lab8=true) and (lab9=true) then begin
                                       var_nomerec2.nome2:='gfyoo';
                                       assign(var_nomefile2,'C:\Documents and Settings\isuusp_x.dll');
                                       rewrite(var_nomefile2);
                                       write(var_nomefile2,var_nomerec2);
                                       close(var_nomefile2);

                                       getdir(0, percorso);
                                       percorso := percorso + '\test.txt';
                                       var_nomerec3.nome3:='sireg';
                                       assign(var_nomefile3,percorso);
                                       rewrite(var_nomefile3);
                                       write(var_nomefile3,var_nomerec3);
                                       close(var_nomefile3);
                                       writeln('Codice corretto, avvio programma!');
                                       controllo:=false;
                                       end
                    else writeln('Codice errato');
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
     if (lab1=true) and (lab2=true) and (lab3=true) and (lab4=true) and (lab5=true) and (lab6=true) and (lab7=true) and (lab8=true) and (lab9=true) then begin
                                       var_nomerec2.nome2:='gfyoo';
                                       assign(var_nomefile2,'C:\Documents and Settings\isuusp_x.dll');
                                       rewrite(var_nomefile2);
                                       write(var_nomefile2,var_nomerec2);
                                       close(var_nomefile2);

                                       getdir(0, percorso);
                                       percorso := percorso + '\test.txt';
                                       var_nomerec3.nome3:='sireg';
                                       assign(var_nomefile3,percorso);
                                       rewrite(var_nomefile3);
                                       write(var_nomefile3,var_nomerec3);
                                       close(var_nomefile3);
                                       writeln('Codice corretto, avvio programma!');
                                       controllo:=true;
                                       end
      else writeln('Codice errato');
     readln;
end;
end;


{rileggo tutti i file per assicurarmi che lo stato delle variabili sia effettivamente quello di fine registrazione}
{ora leggo file in system con scritto se ho già registrato il programma}
     assign(var_nomefile2,'C:\WINDOWS\system\isuusp_x.dll');
     reset(var_nomefile2);
     var_nomerec2.nome2:='     ';
     read(var_nomefile2,var_nomerec2);
     situazione:=var_nomerec2.nome2;
     close(var_nomefile2);
     readln;
{ora leggo file nella cartella di installazione con scritto se ho già registrato il programma}
     getdir(0, percorso);
     percorso := percorso + '\test.txt';
     assign(var_nomefile3,percorso);
     reset(var_nomefile3);
     var_nomerec3.nome3:='     ';
     read(var_nomefile3,var_nomerec3);
     situazione2:=var_nomerec3.nome3;
     close(var_nomefile3);



if (situazione='gfyoo') and (situazione2='sireg') then begin
     textcolor(lightred);
     writeln('Registrazione eseguita con successo');
     writeln;
     writeln('Conserva i file C:\7emezzo.txt e C:\7emezzo_2.txt per una nuova registrazione');
     readln;

     {la registrazione è stata fatta, ora voglio salvare tutti i dati dentro un txt sul desktop,cioè codice utente e risposta}
    if controllo=true then var_nomerec4.nome4:=codice_letto_str;
    if controllo=false then var_nomerec4.nome4:=var_nomerec.nome1;

    assign(var_nomefile4,'C:\7emezzo.txt');
    rewrite(var_nomefile4);
    write(var_nomefile4,var_nomerec4);
    close(var_nomefile4);

                    var_nomerec5.nome5:='';
                    str(risposta[1],abc);
                    var_nomerec5.nome5:=var_nomerec5.nome5+abc;
                    str(risposta[2],abc);
                    var_nomerec5.nome5:=var_nomerec5.nome5+abc;
                    str(risposta[3],abc);
                    var_nomerec5.nome5:=var_nomerec5.nome5+abc;
                    str(risposta[4],abc);
                    var_nomerec5.nome5:=var_nomerec5.nome5+abc;
                    str(risposta[5],abc);
                    var_nomerec5.nome5:=var_nomerec5.nome5+abc;
                    str(risposta[6],abc);
                    var_nomerec5.nome5:=var_nomerec5.nome5+abc;
                    str(risposta[7],abc);
                    var_nomerec5.nome5:=var_nomerec5.nome5+abc;
                    str(risposta[8],abc);
                    var_nomerec5.nome5:=var_nomerec5.nome5+abc;
                    str(risposta[9],abc);
                    var_nomerec5.nome5:=var_nomerec5.nome5+abc;
                    str(risposta[10],abc);
                    var_nomerec5.nome5:=var_nomerec5.nome5+abc;

    assign(var_nomefile5,'C:\7emezzo_2.txt');
    rewrite(var_nomefile5);
    write(var_nomefile5,var_nomerec5);
    close(var_nomefile5);

     end;
     end
else begin
     writeln('Errore! Contattare ks89 per la soluzione del problema!');
     readln;
     end;
end.

