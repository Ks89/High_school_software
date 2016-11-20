program generaz_codice;
uses crt;
var
   codice:array[1..5] of integer;
   risposta:array[1..10] of integer;
   i:integer;
   lab1,lab2,lab3,lab4,lab5,lab6,lab7,lab8,lab9:boolean;
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
     randomize;
     codice[1]:=random(8);
     codice[2]:=random(8);
     codice[3]:=random(8);
     codice[4]:=random(8);
     codice[5]:=random(8);
     writeln('Il tuo codice utente e''');
     for i:=1 to 5 do write(codice[i],'_');
     writeln('Comunica questo codice a Ks89');
     writeln;
     writeln('Inserisci il codice di risposta numero per numero');
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


     if (codice[1]=risposta[3]) then lab1:=true;;
     if (codice[2]=risposta[7]) then lab2:=true;;
     if (codice[3]=risposta[10]-2) then lab3:=true;;
     if (codice[4]=risposta[2]-codice[1]-codice[2]) then lab4:=true;;
     if (risposta[1]=0) then lab5:=true;;
     if (risposta[4]=codice[5]+2) then lab6:=true;;
     if (risposta[6]=8) then lab7:=true;;
     if (risposta[8]=0) then lab8:=true;;
     if (risposta[9]=codice[3]+codice[4]-1) then lab9:=true;;


     if lab1=lab2=lab3=lab4=lab5=lab6=lab7=lab8=lab9=true then writeln('Codice corretto, avvio programma');
      readln;
      readln;
     end.
