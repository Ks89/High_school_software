       program generaz_codice;
uses crt;
var
   codice:array[1..5] of integer;
   risposta:array[1..10] of integer;
   i:integer;
begin
     clrscr;
     writeln('Inserisci il codice utente');
     read(codice[1]);
     read(codice[2]);
     read(codice[3]);
     read(codice[4]);
     read(codice[5]);

     writeln('Generazione codice di risposta');
     risposta[1]:=0;
     risposta[2]:=codice[1]+codice[2]+codice[4];
     risposta[3]:=codice[1];
     risposta[4]:=codice[5]+2;
     risposta[5]:=codice[5]+1;
     risposta[6]:=8;
     risposta[7]:=codice[2];
     risposta[8]:=0;
     risposta[9]:=codice[3]+codice[4]-1;
     risposta[10]:=codice[3]+2;

     readln;

     for i:=1 to 10 do write(risposta[i],'_');
     readln;

     end.
