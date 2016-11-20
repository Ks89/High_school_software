program sette_e_mezzo_1_0;
uses crt,graph;
var
   mazzo:array[1..40] of real;
   carte1:array[1..15] of integer;
   carte2:array[1..15] of integer;
   mano1:array[1..15] of real;
   mano2:array[1..15] of real;
   stato1:array[1..15] of string;
   stato2:array[1..15] of string;
   torneo1:array[0..80] of string;
   torneo2:array[0..80] of string;
   p1,p2,c1,c2,temp1,temp2:real;
   name1,name2,pesca,pescaX,ok,girare1,girare2,str:string;
   i,giro1,giro2,l,m,partite,x,lungh1,lungh2,c,r,giro_carta1,giro_carta2,axx,player:integer;
   cont:integer;
   bugx001,bugx002,player1ok,player2ok,coperta1,coperta2,bugx003_1,bugx003_2:boolean;
   bugx004_2,bugx004_1,bugx005_1,bugx005_2:boolean;





procedure loading;
var
i:integer;
begin
clrscr;
     writeln;
     writeln;
     writeln;
     textcolor(lightgreen);
     gotoxy((80-7) div 2,wherey+5);
     writeln('Loading');


    {fa fare cambio colori alla prima riga}
     textcolor(10);
     gotoxy((80-11) div 2,4);
     write(chr(219),chr(219),chr(219),chr(219),chr(219),' ');

     delay(18);

     textcolor(2);
     gotoxy((80-11) div 2,wherey);
     write(chr(219),chr(219),chr(219),chr(219),chr(219),' ');

     delay(18);

    textcolor(10);
     writeln(chr(219),chr(219),chr(219),chr(219),chr(219));

     delay(100);

     textcolor(0);
     gotoxy((80-11) div 2,wherey-1);
     write(chr(219),chr(219),chr(219),chr(219),chr(219),' ');

     delay(18);

    textcolor(2);
     writeln(chr(219),chr(219),chr(219),chr(219),chr(219));

 {da qui inzia il cambio colore della colonna a destra}

     delay(18);
     {metto a verde tutta la tacca alta della colonna destra}
     textcolor(10);
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));

     delay(18);
     {metto tutta la prima riga a nero}
     textcolor(0);
     gotoxy((80-11) div 2,4);
     writeln(chr(219),chr(219),chr(219),chr(219),chr(219),' ',chr(219),chr(219),chr(219),chr(219),chr(219));


     delay(18);
     {metto a verde scuro tutta la tacca alta della colonna destra}
     textcolor(2);
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));

     delay(18);
     {metto a verde chiaro tutta la tacca bassa della colonna destra}
     textcolor(10);
     gotoxy((80-13) div 2,wherey+1);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));

     delay(18);
     {metto a nero tutta la tacca alta della colonna destra}
     textcolor(0);
     gotoxy((80-13) div 2,wherey-9);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));

     delay(18);
     {metto a verde scuro tutta la tacca bassa della colonna destra}
     textcolor(2);
     gotoxy((80-13) div 2,wherey+1);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));

     delay(18);
     {ora faccio la riga bassa, metto a verde la seconda barra da sx}
     textcolor(10);
     gotoxy((80-11) div 2,wherey);
     write('      ',chr(219),chr(219),chr(219),chr(219),chr(219));

     delay(18);
     {metto a nero tutta la tacca bassa della colonna destra}
     textcolor(0);
     gotoxy((80-13) div 2,wherey-4);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));

     delay(18);
     {ora faccio la riga bassa, metto a verde scuro la seconda barra da sx}
     textcolor(2);
     gotoxy((80-11) div 2,wherey);
     writeln('      ',chr(219),chr(219),chr(219),chr(219),chr(219));

     delay(18);
     {ora faccio la riga bassa, metto a verde la prima barra da sx}
     textcolor(10);
     gotoxy((80-11) div 2,wherey-1);
     write(chr(219),chr(219),chr(219),chr(219),chr(219),' ');
     textcolor(2);
     writeln(chr(219),chr(219),chr(219),chr(219),chr(219));

     delay(18);
     {ora faccio la riga bassa, metto a nero la seconda barra da sx}
     textcolor(10);
     gotoxy((80-11) div 2,wherey-1);
     write(chr(219),chr(219),chr(219),chr(219),chr(219),' ');
     textcolor(0);
     writeln(chr(219),chr(219),chr(219),chr(219),chr(219));

     delay(18);
     {ora faccio la riga bassa, metto a verde scuro la prima barra da sx}
     textcolor(2);
     gotoxy((80-11) div 2,wherey-1);
     write(chr(219),chr(219),chr(219),chr(219),chr(219),' ');

     delay(18);
     {metto a verde tutta la tacca bassa della colonna sinistra}
     textcolor(10);
     gotoxy((80-13) div 2,wherey-4);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');

     delay(18);
     {metto a verde tutta la tacca bassa della colonna sinistra}
     textcolor(10);
     gotoxy((80-13) div 2,wherey-4);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');


     delay(18);
     {ora faccio la riga bassa, metto a nero la prima barra da sx}
     textcolor(0);
     gotoxy((80-11) div 2,wherey);
     write(chr(219),chr(219),chr(219),chr(219),chr(219),' ');

     delay(18);
     {metto a verde scuro tutta la tacca bassa della colonna sinistra}
     textcolor(2);
     gotoxy((80-13) div 2,wherey-4);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219));

     delay(18);
     {metto a verde tutta la tacca alta della colonna sinistra}
     textcolor(10);
     gotoxy((80-13) div 2,wherey-9);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219));

     delay(18);
     {metto a nero tutta la tacca bassa della colonna sinistra}
     textcolor(0);
     gotoxy((80-13) div 2,wherey+1);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219));

     delay(18);
     {metto a verde scuro tutta la tacca alta della colonna sinistra}
     textcolor(2);
     gotoxy((80-13) div 2,wherey-9);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219));

     delay(18);





     {verde la prima barra in alto a sinistra}
     textcolor(10);
     gotoxy((80-11) div 2,4);
     write(chr(219),chr(219),chr(219),chr(219),chr(219),' ');

     delay(18);
     {metto a nero tutta la tacca alta della colonna sinistra}
     textcolor(0);
     gotoxy((80-13) div 2,wherey+1);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219));

     delay(18);

     {metto a verde scuro la prima tacca in alto a sx}
     textcolor(2);
     gotoxy((80-11) div 2,4);
     write(chr(219),chr(219),chr(219),chr(219),chr(219),' ');

     delay(18);

    textcolor(10);
     writeln(chr(219),chr(219),chr(219),chr(219),chr(219));

     delay(100);

     textcolor(0);
     gotoxy((80-11) div 2,wherey-1);
     write(chr(219),chr(219),chr(219),chr(219),chr(219),' ');

     delay(18);

    textcolor(2);
     writeln(chr(219),chr(219),chr(219),chr(219),chr(219));

 {da qui inzia il cambio colore della colonna a destra}

     delay(18);
     {metto a verde tutta la tacca alta della colonna destra}
     textcolor(10);
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));

     delay(18);
     {metto tutta la prima riga a nero}
     textcolor(0);
     gotoxy((80-11) div 2,4);
     writeln(chr(219),chr(219),chr(219),chr(219),chr(219),' ',chr(219),chr(219),chr(219),chr(219),chr(219));


     delay(18);
     {metto a verde scuro tutta la tacca alta della colonna destra}
     textcolor(2);
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));

     delay(18);
     {metto a verde chiaro tutta la tacca bassa della colonna destra}
     textcolor(10);
     gotoxy((80-13) div 2,wherey+1);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));

     delay(18);
     {metto a nero tutta la tacca alta della colonna destra}
     textcolor(0);
     gotoxy((80-13) div 2,wherey-9);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));

     delay(18);
     {metto a verde scuro tutta la tacca bassa della colonna destra}
     textcolor(2);
     gotoxy((80-13) div 2,wherey+1);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));

     delay(18);
     {ora faccio la riga bassa, metto a verde la seconda barra da sx}
     textcolor(10);
     gotoxy((80-11) div 2,wherey);
     write('      ',chr(219),chr(219),chr(219),chr(219),chr(219));

     delay(18);
     {metto a nero tutta la tacca bassa della colonna destra}
     textcolor(0);
     gotoxy((80-13) div 2,wherey-4);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));

     delay(18);
     {ora faccio la riga bassa, metto a verde scuro la seconda barra da sx}
     textcolor(2);
     gotoxy((80-11) div 2,wherey);
     writeln('      ',chr(219),chr(219),chr(219),chr(219),chr(219));

     delay(18);
     {ora faccio la riga bassa, metto a verde la prima barra da sx}
     textcolor(10);
     gotoxy((80-11) div 2,wherey-1);
     write(chr(219),chr(219),chr(219),chr(219),chr(219),' ');
     textcolor(2);
     writeln(chr(219),chr(219),chr(219),chr(219),chr(219));

     delay(18);
     {ora faccio la riga bassa, metto a nero la seconda barra da sx}
     textcolor(10);
     gotoxy((80-11) div 2,wherey-1);
     write(chr(219),chr(219),chr(219),chr(219),chr(219),' ');
     textcolor(0);
     writeln(chr(219),chr(219),chr(219),chr(219),chr(219));

     delay(18);
     {ora faccio la riga bassa, metto a verde scuro la prima barra da sx}
     textcolor(2);
     gotoxy((80-11) div 2,wherey-1);
     write(chr(219),chr(219),chr(219),chr(219),chr(219),' ');

     delay(18);
     {metto a verde tutta la tacca bassa della colonna sinistra}
     textcolor(10);
     gotoxy((80-13) div 2,wherey-4);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');

     delay(18);
     {metto a verde tutta la tacca bassa della colonna sinistra}
     textcolor(10);
     gotoxy((80-13) div 2,wherey-4);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');


     delay(18);
     {ora faccio la riga bassa, metto a nero la prima barra da sx}
     textcolor(0);
     gotoxy((80-11) div 2,wherey);
     write(chr(219),chr(219),chr(219),chr(219),chr(219),' ');

     delay(18);
     {metto a verde scuso tutta la tacca bassa della colonna sinistra}
     textcolor(2);
     gotoxy((80-13) div 2,wherey-4);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219));

     delay(18);
     {metto a verde chiaro tutta la tacca alta della colonna sinistra}
     textcolor(10);
     gotoxy((80-13) div 2,wherey-9);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219));

     delay(18);
     {metto a nero tutta la tacca bassa della colonna sinistra}
     textcolor(0);
     gotoxy((80-13) div 2,wherey+1);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219));

     delay(18);
     {metto a verde scuro tutta la tacca alta della colonna sinistra}
     textcolor(2);
     gotoxy((80-13) div 2,wherey-9);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219));



     {verde la prima barra in alto a sinistra}
     textcolor(10);
     gotoxy((80-11) div 2,4);
     write(chr(219),chr(219),chr(219),chr(219),chr(219),' ');

     delay(18);
     {metto a nero tutta la tacca alta della colonna sinistra}
     textcolor(0);
     gotoxy((80-13) div 2,wherey+1);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219));

     delay(18);

     {metto a verde scuro la prima tacca in alto a sx}
     textcolor(2);
     gotoxy((80-11) div 2,4);
     write(chr(219),chr(219),chr(219),chr(219),chr(219),' ');

     delay(18);

    textcolor(10);
     writeln(chr(219),chr(219),chr(219),chr(219),chr(219));

     delay(100);

     textcolor(0);
     gotoxy((80-11) div 2,wherey-1);
     write(chr(219),chr(219),chr(219),chr(219),chr(219),' ');

     delay(18);

    textcolor(2);
     writeln(chr(219),chr(219),chr(219),chr(219),chr(219));

 {da qui inzia il cambio colore della colonna a destra}

     delay(18);
     {metto a verde tutta la tacca alta della colonna destra}
     textcolor(10);
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));

     delay(18);
     {metto tutta la prima riga a nero}
     textcolor(0);
     gotoxy((80-11) div 2,4);
     writeln(chr(219),chr(219),chr(219),chr(219),chr(219),' ',chr(219),chr(219),chr(219),chr(219),chr(219));


     delay(18);
     {metto a verde scuro tutta la tacca alta della colonna destra}
     textcolor(2);
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));

     delay(18);
     {metto a verde chiaro tutta la tacca bassa della colonna destra}
     textcolor(10);
     gotoxy((80-13) div 2,wherey+1);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));

     delay(18);
     {metto a nero tutta la tacca alta della colonna destra}
     textcolor(0);
     gotoxy((80-13) div 2,wherey-9);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));

     delay(18);
     {metto a verde scuro tutta la tacca bassa della colonna destra}
     textcolor(2);
     gotoxy((80-13) div 2,wherey+1);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));

     delay(18);
     {ora faccio la riga bassa, metto a verde la seconda barra da sx}
     textcolor(10);
     gotoxy((80-11) div 2,wherey);
     write('      ',chr(219),chr(219),chr(219),chr(219),chr(219));

     delay(18);
     {metto a nero tutta la tacca bassa della colonna destra}
     textcolor(0);
     gotoxy((80-13) div 2,wherey-4);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));

     delay(18);
     {ora faccio la riga bassa, metto a verde scuro la seconda barra da sx}
     textcolor(2);
     gotoxy((80-11) div 2,wherey);
     writeln('      ',chr(219),chr(219),chr(219),chr(219),chr(219));

     delay(18);
     {ora faccio la riga bassa, metto a verde la prima barra da sx}
     textcolor(10);
     gotoxy((80-11) div 2,wherey-1);
     write(chr(219),chr(219),chr(219),chr(219),chr(219),' ');
     textcolor(2);
     writeln(chr(219),chr(219),chr(219),chr(219),chr(219));

     delay(18);
     {ora faccio la riga bassa, metto a nero la seconda barra da sx}
     textcolor(10);
     gotoxy((80-11) div 2,wherey-1);
     write(chr(219),chr(219),chr(219),chr(219),chr(219),' ');
     textcolor(0);
     writeln(chr(219),chr(219),chr(219),chr(219),chr(219));

     delay(18);
     {ora faccio la riga bassa, metto a verde scuro la prima barra da sx}
     textcolor(2);
     gotoxy((80-11) div 2,wherey-1);
     write(chr(219),chr(219),chr(219),chr(219),chr(219),' ');

     delay(18);
     {metto a verde tutta la tacca bassa della colonna sinistra}
     textcolor(10);
     gotoxy((80-13) div 2,wherey-4);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');

     delay(18);
     {metto a verde tutta la tacca bassa della colonna sinistra}
     textcolor(10);
     gotoxy((80-13) div 2,wherey-4);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');


     delay(18);
     {ora faccio la riga bassa, metto a nero la prima barra da sx}
     textcolor(0);
     gotoxy((80-11) div 2,wherey);
     write(chr(219),chr(219),chr(219),chr(219),chr(219),' ');

     delay(18);
     {metto a verde scuso tutta la tacca bassa della colonna sinistra}
     textcolor(2);
     gotoxy((80-13) div 2,wherey-4);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219));

     delay(18);
     {metto a verde chiaro tutta la tacca alta della colonna sinistra}
     textcolor(10);
     gotoxy((80-13) div 2,wherey-9);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219));

     delay(18);
     {metto a nero tutta la tacca bassa della colonna sinistra}
     textcolor(0);
     gotoxy((80-13) div 2,wherey+1);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219));

     delay(18);
     {metto a verde scuro tutta la tacca alta della colonna sinistra}
     textcolor(2);
     gotoxy((80-13) div 2,wherey-9);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219));




     {verde la prima barra in alto a sinistra}
     textcolor(10);
     gotoxy((80-11) div 2,4);
     write(chr(219),chr(219),chr(219),chr(219),chr(219),' ');

     delay(18);
     {metto a nero tutta la tacca alta della colonna sinistra}
     textcolor(0);
     gotoxy((80-13) div 2,wherey+1);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219));

     delay(18);

     {metto a verde scuro la prima tacca in alto a sx}
     textcolor(2);
     gotoxy((80-11) div 2,4);
     write(chr(219),chr(219),chr(219),chr(219),chr(219),' ');

     delay(18);

    textcolor(10);
     writeln(chr(219),chr(219),chr(219),chr(219),chr(219));

     delay(100);

     textcolor(0);
     gotoxy((80-11) div 2,wherey-1);
     write(chr(219),chr(219),chr(219),chr(219),chr(219),' ');

     delay(18);

    textcolor(2);
     writeln(chr(219),chr(219),chr(219),chr(219),chr(219));

 {da qui inzia il cambio colore della colonna a destra}

     delay(18);
     {metto a verde tutta la tacca alta della colonna destra}
     textcolor(10);
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));

     delay(18);
     {metto tutta la prima riga a nero}
     textcolor(0);
     gotoxy((80-11) div 2,4);
     writeln(chr(219),chr(219),chr(219),chr(219),chr(219),' ',chr(219),chr(219),chr(219),chr(219),chr(219));


     delay(18);
     {metto a verde scuro tutta la tacca alta della colonna destra}
     textcolor(2);
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));

     delay(18);
     {metto a verde chiaro tutta la tacca bassa della colonna destra}
     textcolor(10);
     gotoxy((80-13) div 2,wherey+1);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));

     delay(18);
     {metto a nero tutta la tacca alta della colonna destra}
     textcolor(0);
     gotoxy((80-13) div 2,wherey-9);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));

     delay(18);
     {metto a verde scuro tutta la tacca bassa della colonna destra}
     textcolor(2);
     gotoxy((80-13) div 2,wherey+1);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));

     delay(18);
     {ora faccio la riga bassa, metto a verde la seconda barra da sx}
     textcolor(10);
     gotoxy((80-11) div 2,wherey);
     write('      ',chr(219),chr(219),chr(219),chr(219),chr(219));

     delay(18);
     {metto a nero tutta la tacca bassa della colonna destra}
     textcolor(0);
     gotoxy((80-13) div 2,wherey-4);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));
     gotoxy((80-13) div 2,wherey);
     writeln('            ',chr(219));

     delay(18);
     {ora faccio la riga bassa, metto a verde scuro la seconda barra da sx}
     textcolor(2);
     gotoxy((80-11) div 2,wherey);
     writeln('      ',chr(219),chr(219),chr(219),chr(219),chr(219));

     delay(18);
     {ora faccio la riga bassa, metto a verde la prima barra da sx}
     textcolor(10);
     gotoxy((80-11) div 2,wherey-1);
     write(chr(219),chr(219),chr(219),chr(219),chr(219),' ');
     textcolor(2);
     writeln(chr(219),chr(219),chr(219),chr(219),chr(219));

     delay(18);
     {ora faccio la riga bassa, metto a nero la seconda barra da sx}
     textcolor(10);
     gotoxy((80-11) div 2,wherey-1);
     write(chr(219),chr(219),chr(219),chr(219),chr(219),' ');
     textcolor(0);
     writeln(chr(219),chr(219),chr(219),chr(219),chr(219));

     delay(18);
     {ora faccio la riga bassa, metto a verde scuro la prima barra da sx}
     textcolor(2);
     gotoxy((80-11) div 2,wherey-1);
     write(chr(219),chr(219),chr(219),chr(219),chr(219),' ');

     delay(18);
     {metto a verde tutta la tacca bassa della colonna sinistra}
     textcolor(10);
     gotoxy((80-13) div 2,wherey-4);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');

     delay(18);
     {metto a verde tutta la tacca bassa della colonna sinistra}
     textcolor(10);
     gotoxy((80-13) div 2,wherey-4);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');


     delay(18);
     {ora faccio la riga bassa, metto a nero la prima barra da sx}
     textcolor(0);
     gotoxy((80-11) div 2,wherey);
     write(chr(219),chr(219),chr(219),chr(219),chr(219),' ');

     delay(18);
     {metto a verde scuso tutta la tacca bassa della colonna sinistra}
     textcolor(2);
     gotoxy((80-13) div 2,wherey-4);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219));

     delay(18);
     {metto a verde chiaro tutta la tacca alta della colonna sinistra}
     textcolor(10);
     gotoxy((80-13) div 2,wherey-9);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219));

     delay(18);
     {metto a nero tutta la tacca bassa della colonna sinistra}
     textcolor(0);
     gotoxy((80-13) div 2,wherey+1);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219));

     delay(18);
     {metto a verde scuro tutta la tacca alta della colonna sinistra}
     textcolor(2);
     gotoxy((80-13) div 2,wherey-9);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219),'            ');
     gotoxy((80-13) div 2,wherey);
     writeln(chr(219));

  clrscr;

  for i:=1 to 4 do begin
     if (i mod 2)=0 then textcolor(lightgreen)
     else textcolor(black);
     gotoxy((80-7) div 2,9);
     writeln('Loading');
     delay(500);
     end;

     clrscr;
  gotoxy((80-22)div 2,9);
   writeln('Caricamento completato');
   delay(555);
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
     delay(800);

     textcolor(Lightmagenta);
     str:='Anno 2008 (c)KS89';
     gotoxy((80-length(str)) div 2,wherey);
     writeln(str);
     delay(800);
     clrscr;

     loading;    {apre la procedure loading, col caricamento bellissimo in stile Decoder MySky}

     clrscr;
     textcolor(lightred);
     writeln('Avvio in corso');
     delay(300);
     clrscr;
     textcolor(lightcyan);
     str:='7 e mezzo 1.0 Beta6';
     gotoxy((80-length(str)) div 2,wherey);
     writeln(str);
     textcolor(yellow);
     delay(1000);
     clrscr;

     textcolor(lightgreen);
     str:='Regole';
     gotoxy((80-length(str)) div 2,wherey);
     delay(200);
     writeln(str);
     writeln;
     writeln;
     textcolor(yellow);
     str:='Le figure valgono 0.5, i numeri il loro valore nominale';
     gotoxy((80-length(str)) div 2,wherey);
     delay(50);
     writeln(str);
     writeln;
     textcolor(yellow);
     str:='Vince chi si avvicina e non supera il valore: 7,5';
     gotoxy((80-length(str)) div 2,wherey);
     delay(50);
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
   readln(name2);
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
   textcolor(lightred);

   if partite>50 then begin
                      writeln('Attenzione! E'' possibile fare al massimo 50 partite');
                      readln;
                      end;

   clrscr;
   textcolor(lightred);
   write('I dati inseriti sono corretti? Premi ');
   textcolor(white);
   write('s ');
   textcolor(lightred);
   write('per cofermare: ');
   textcolor(white);
   readln(ok);
until ((ok='s') or (ok='S')) and (partite<50);
clrscr;
end;



procedure assegnaz1;
begin

if (giro1<14) and (giro1>0) then begin
            for i:=1 to 7 do if carte1[giro1]=i then begin
                                                     temp1:=i;
                                                     p1:=p1+i;       {giro1 indica qual'è l'ultima cifra inserita nell'array da controllare}
                                                     end;
            for i:=11 to 17 do if carte1[giro1]=i then begin
                                                     temp1:=i-10;
                                                     p1:=p1+i-10;
                                                     end;
            for i:=21 to 27 do if carte1[giro1]=i then begin
                                                     temp1:=i-20;
                                                     p1:=p1+i-20;
                                                     end;
            for i:=31 to 37 do if carte1[giro1]=i then begin
                                                     temp1:=i-30;
                                                     p1:=p1+i-30;
                                                     end;
            for i:=8 to 10 do if carte1[giro1]=i then begin
                                                     temp1:=0.5;
                                                     p1:=p1+0.5;
                                                     end;                  {questo serve per assegnare gli 0.5}
            for i:=18 to 20 do if carte1[giro1]=i then begin
                                                     temp1:=0.5;
                                                     p1:=p1+0.5;
                                                     end;
            for i:=28 to 30 do if carte1[giro1]=i then begin
                                                     temp1:=0.5;
                                                     p1:=p1+0.5;
                                                     end;
            for i:=38 to 40 do if carte1[giro1]=i then begin
                                                     temp1:=0.5;
                                                     p1:=p1+0.5;
                                                     end;
                 end;

end;



procedure assegnazc1;      {questa fa l'assegnazione nel caso in cui volessi una carta coperta e usa una variabile diversa, non p1, ma c1 (coperta 1)}
begin

if (giro1<14) and (giro1>0) then begin
            for i:=1 to 7 do if carte1[giro1]=i then begin
                                                     temp1:=i;
                                                     c1:=c1+i;       {giro1 indica qual'è l'ultima cifra inserita nell'array da controllare}
                                                     end;
            for i:=11 to 17 do if carte1[giro1]=i then begin
                                                     temp1:=i-10;
                                                     c1:=c1+i-10;
                                                     end;
            for i:=21 to 27 do if carte1[giro1]=i then begin
                                                     temp1:=i-20;
                                                     c1:=c1+i-20;
                                                     end;
            for i:=31 to 37 do if carte1[giro1]=i then begin
                                                     temp1:=i-30;
                                                     c1:=c1+i-30;
                                                     end;
            for i:=8 to 10 do if carte1[giro1]=i then begin
                                                     temp1:=0.5;
                                                     c1:=c1+0.5;
                                                     end;                  {questo serve per assegnare gli 0.5}
            for i:=18 to 20 do if carte1[giro1]=i then begin
                                                     temp1:=0.5;
                                                     c1:=c1+0.5;
                                                     end;
            for i:=28 to 30 do if carte1[giro1]=i then begin
                                                     temp1:=0.5;
                                                     c1:=c1+0.5;
                                                     end;
            for i:=38 to 40 do if carte1[giro1]=i then begin
                                                     temp1:=0.5;
                                                     c1:=c1+0.5;
                                                     end;
                 end;

end;





procedure assegnaz2;
begin

if (giro2<14) and (giro2>0) then begin
            for i:=1 to 7 do if carte2[giro2]=i then begin
                                                     temp2:=i;
                                                     p2:=p2+i;       {giro2 indica qual'è l'ultima cifra inserita nell'array da controllare}
                                                     end;
            for i:=11 to 17 do if carte2[giro2]=i then begin
                                                     temp2:=i-10;
                                                     p2:=p2+i-10;
                                                     end;
            for i:=21 to 27 do if carte2[giro2]=i then begin
                                                     temp2:=i-20;
                                                     p2:=p2+i-20;
                                                     end;
            for i:=31 to 37 do if carte2[giro2]=i then begin
                                                     temp2:=i-30;
                                                     p2:=p2+i-30;
                                                     end;
            for i:=8 to 10 do if carte2[giro2]=i then begin
                                                     temp2:=0.5;
                                                     p2:=p2+0.5;
                                                     end;                  {questo serve per assegnare gli 0.5}
            for i:=18 to 20 do if carte2[giro2]=i then begin
                                                     temp2:=0.5;
                                                     p2:=p2+0.5;
                                                     end;
            for i:=28 to 30 do if carte2[giro2]=i then begin
                                                     temp2:=0.5;
                                                     p2:=p2+0.5;
                                                     end;
            for i:=38 to 40 do if carte2[giro2]=i then begin
                                                     temp2:=0.5;
                                                     p2:=p2+0.5;
                                                     end;
                 end;


end;


procedure assegnazc2;
begin

if (giro2<14) and (giro2>0) then begin
            for i:=1 to 7 do if carte2[giro2]=i then begin
                                                     temp2:=i;
                                                     c2:=c2+i;       {giro2 indica qual'è l'ultima cifra inserita nell'array da controllare}
                                                     end;
            for i:=11 to 17 do if carte2[giro2]=i then begin
                                                     temp2:=i-10;
                                                     c2:=c2+i-10;
                                                     end;
            for i:=21 to 27 do if carte2[giro2]=i then begin
                                                     temp2:=i-20;
                                                     c2:=c2+i-20;
                                                     end;
            for i:=31 to 37 do if carte2[giro2]=i then begin
                                                     temp2:=i-30;
                                                     c2:=c2+i-30;
                                                     end;
            for i:=8 to 10 do if carte2[giro2]=i then begin
                                                     temp2:=0.5;
                                                     c2:=c2+0.5;
                                                     end;                  {questo serve per assegnare gli 0.5}
            for i:=18 to 20 do if carte2[giro2]=i then begin
                                                     temp2:=0.5;
                                                     c2:=c2+0.5;
                                                     end;
            for i:=28 to 30 do if carte2[giro2]=i then begin
                                                     temp2:=0.5;
                                                     c2:=c2+0.5;
                                                     end;
            for i:=38 to 40 do if carte2[giro2]=i then begin
                                                     temp2:=0.5;
                                                     c2:=c2+0.5;
                                                     end;

                                     end;

end;


procedure caricaS1;
begin
     stato1[giro1+1]:='s';
end;

procedure caricaC1;
begin
     stato1[giro1+1]:='c';
end;

procedure caricaS2;
begin
     stato2[giro2+1]:='s';
end;


procedure caricaC2;
begin
     stato2[giro2+1]:='c';
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





procedure controllo_bug2;
{------------------------------------------sistema rilevamento bug x002, cioè più di 13 carte pescate da un giocatore------------------------}
begin
if (carte1[14]<>0) or (carte1[15]<>0) then begin
                                       writeln('Rilevato bug su player1: Errore "x002". Comunicare il problema a Ks89');
                                       bugx002:=true;
                                       end
 else bugx002:=false;



if (carte2[14]<>0) or (carte2[15]<>0) then begin
                                       writeln('Rilevato bug su player2: Errore "x002". Comunicare il problema a Ks89');
                                       bugx002:=true;
                                       end
 else bugx002:=false;
{--------------------------------------------------------------------------------------------------------------------------------------------}
end;




procedure controllo_bug3;
{------------------------------------------sistema rilevamento bug x003, cioè i giocatori partono già con carte in mano------------------------}
begin
for i:=0 to 15 do begin
                 if mano1[i]<>0 then begin
                                       writeln('Rilevato bug su player1: Errore "x003". Comunicare il problema a Ks89');
                                       bugx003_1:=true;
                                       end
                  else bugx003_1:=false;
                  end;

for i:=0 to 15 do begin
                 if mano2[i]<>0 then begin
                                       writeln('Rilevato bug su player2: Errore "x003". Comunicare il problema a Ks89');
                                       bugx003_2:=true;
                                       end
                  else bugx003_2:=false;
                  end;
{--------------------------------------------------------------------------------------------------------------------------------------------}
end;



procedure controllo_bug4;
{------------------------------------------sistema rilevamento bug x004, cioè che ci sia al max una sola carta coperta------------------------}
begin
c:=0;
for i:=0 to 15 do if stato1[i]='c' then c:=c+1;
    if c>1 then begin
                     writeln('Rilevato bug su player1: Errore "x004". Comunicare il problema a Ks89');
                     bugx004_1:=true;
                end
       else bugx004_1:=false;


c:=0;
for i:=0 to 15 do if stato1[i]='c' then c:=c+1;
    if c>1 then begin
                     writeln('Rilevato bug su player1: Errore "x004". Comunicare il problema a Ks89');
                     bugx004_2:=true;
                end
       else bugx004_2:=false;
{--------------------------------------------------------------------------------------------------------------------------------------------}
end;



procedure controllo_bug5;
{----------------sistema rilevamento bug x005, cioè se 'c' e 's' in mano[i] sono pari al num di carte effettivamente in mano------------------}
begin
c:=0;
r:=0;
for i:=0 to 15 do if (stato1[i]='c') or (stato1[i]='s') then c:=c+1;
for i:=0 to 15 do if mano1[i]<>0 then r:=r+1;
    if c<>r then begin
                     writeln('Rilevato bug su player1: Errore "x005". Comunicare il problema a Ks89');
                     bugx005_1:=true;
                end
       else bugx005_1:=false;

c:=0;
r:=0;
for i:=0 to 15 do if (stato2[i]='c') or (stato2[i]='s') then c:=c+1;
for i:=0 to 15 do if mano2[i]<>0 then r:=r+1;
    if c<>r then begin
                     writeln('Rilevato bug su player2: Errore "x005". Comunicare il problema a Ks89');
                     bugx005_2:=true;
                end
       else bugx005_2:=false;
{--------------------------------------------------------------------------------------------------------------------------------------------}
end;


procedure controllo_bug6_e_risoluzione1;
{----------------sistema rilevamento bug x006, e correzione atuomatica. VERAMNETE MOLTO IMPORTANTE; ANZI ESSENZIALE PER GIOCARE--------------}
begin
cont:=0;
   for i:=1 to 15 do if stato1[i]='c' then cont:=cont+1;
   i:=1;
   if cont>1 then begin
                       repeat
                             if stato1[i]='c' then begin
                                                        stato1[i]:='s';
                                                        cont:=10;
                                                    end;
                       i:=i+1;
                       until cont=10;
                  end;
{--------------------------------------------------------------------------------------------------------------------------------------------}
end;




procedure controllo_bug6_e_risoluzione2;
{----------------sistema rilevamento bug x006, e correzione atuomatica. VERAMNETE MOLTO IMPORTANTE; ANZI ESSENZIALE PER GIOCARE--------------}
begin
cont:=0;
   for i:=1 to 15 do if stato2[i]='c' then cont:=cont+1;
   i:=1;
   if cont>1 then begin
                       repeat
                             if stato2[i]='c' then begin
                                                        stato2[i]:='s';
                                                        cont:=10;
                                                    end;
                       i:=i+1;
                       until cont=10;
                 end;
{--------------------------------------------------------------------------------------------------------------------------------------------}
end;


begin
   clrscr;
   delay(1000);

   centra;
   p1:=0;
   P2:=0;
   bugx001:=false;
   bugx002:=false;
   bugx003_1:=false;
   bugx003_2:=false;
   bugx004_1:=false;
   bugx004_2:=false;
   bugx005_1:=false;
   bugx005_2:=false;
   axx:=0;
   coperta1:=true;  {perchè la prima carta è sempre coperta}
   coperta2:=true;
   lungh1:=0;
   lungh2:=0;
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

   for i:=1 to 15 do carte1[i]:=0;  {svuoto carray delle carte che ho in mano (nel loro vero valore e non nella posizione del mazzo}
   for i:=1 to 15 do carte2[i]:=0;
   for i:=1 to 15 do stato1[i]:=''; {svuoto l'array che tiene in memoria quali carte sono coperte e quali scoperte della mano}
   for i:=1 to 15 do stato2[i]:='';
   for i:=1 to 80 do torneo1[i]:='';
   for i:=1 to 80 do torneo2[i]:='';

   randomize;

   opzioni_partenza;

   textcolor(yellow);
   x:=0;

repeat          {questo repeat è quello che fa terminare il gioco se ho fatto tot partite quante sono quelle scelte per il torneo}

    player1ok:=false;
    player2ok:=false;
    p1:=0;           {resetto il valore delle carte ogni turno}
    p2:=0;
    c1:=0;
    c2:=0;
    coperta1:=true;  {perchè la prima carta è sempre coperta}
    coperta2:=true;

   for i:=1 to 15 do mano1[i]:=0;
   for i:=1 to 15 do mano2[i]:=0;


   controllo_bug3;

   if (bugx003_1=true) or (bugx003_2=true) then writeln(' A causa del bug x003 è necessario riavvire 7 e mezzo');

repeat
	carte1[1]:=random(39)+1;
	carte2[1]:=random(39)+1;
until carte1[1]<>carte2[1];

giro1:=1;
giro2:=1;
assegnaz1;
assegnaz2;

mano1[1]:=temp1;
mano2[1]:=temp2;

stato1[1]:='c';  {la prima carta data ad ogni giocatore è sempre coperta, quindi metto in stato una 'c'}
stato2[1]:='c';

for i:=2 to 15 do stato1[i]:='';
for i:=2 to 15 do stato2[i]:='';


clrscr;
player:=x mod 2;


{-------------------------------------------------------------------------------------------------------}
{-------------------------------------------------------------------------------------------------------}
{-----------------------------------Prima player 1 e poi il 2-------------------------------------------}
{-------------------------------------------------------------------------------------------------------}
{-------------------------------------------------------------------------------------------------------}
if player=0 then begin


repeat
textcolor(12);
str:='Giocatore 1, Ora tocca a te! Premi un tasto per iniziare';
gotoxy((80-length(str)) div 2,10);  {posiziona al centro nella 10 riga}
writeln(str);
delay(300);
clrscr;
textcolor(14);
str:='Giocatore 1, Ora tocca a te! Premi un tasto per iniziare';
gotoxy((80-length(str)) div 2,10);
writeln(str);
delay(300);
clrscr;
textcolor(10);
str:='Giocatore 1, Ora tocca a te! Premi un tasto per iniziare';
gotoxy((80-length(str)) div 2,10);
writeln(str);
delay(300);
clrscr;
until keypressed;

textcolor(lightmagenta);
str:='Giocatore 1! Premi un tasto per iniziare';
gotoxy((80-length(str)) div 2,10);
writeln(str);
readln;
textcolor(yellow);



repeat

{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}
{PLAYER 1 PLAYER 1 PLAYER 1 PLAYER 1 PLAYER 1 PLAYER 1 PLAYER 1 PLAYER 1 PLAYER 1 PLAYER 1 PLAYER 1 PLAYER 1 PLAYER 1}
{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}


if player1ok=false then begin     {questo mi assicura che ogni partita il giocatore 1 dopo aver giocato non possa più pescare altre carte, per sicurezza}
                                                          {questo sembra inutile ma mi permette di togliere uno strano bug che non saprei come eliminare se no}

clrscr;

textcolor(white);
lungh2:=length(name2);
for i:=1 to lungh2+17 do write(chr(219));
writeln(chr(219));
write(chr(219));
textcolor(lightgreen);
write(' Giocatore 2 : ',name2,' ');
textcolor(white);
write(chr(219));
if length(name1)>length(name2) then for i:=1 to length(name1)-length(name2) do write(' ');
write('   Carte pescate: ');
textcolor(cyan);
writeln('?');
textcolor(white);
for i:=1 to lungh2+17 do write(chr(219));
writeln(chr(219));
writeln;




textcolor(white);
lungh1:=length(name1);
for i:=1 to lungh1+17 do write(chr(219));
writeln(chr(219));
write(chr(219));
textcolor(lightmagenta);
write(' Giocatore 1 : ',name1,' ');
textcolor(white);
write(chr(219));
if length(name2)>length(name1) then for i:=1 to length(name2)-length(name1) do write(' ');
write('   Carte pescate: ');
textcolor(cyan);

for i:=1 to 15 do begin
                          textcolor(lightred);
                          if stato1[i]='c' then textcolor(cyan)
                             else textcolor(lightred);
                          if mano1[i]<>0 then write(' ',mano1[i]:1:1);
                          textcolor(lightred);
                     end;


textcolor(white);
writeln;
for i:=1 to lungh1+17 do write(chr(219));
writeln(chr(219));
writeln;



writeln;
textcolor(lightmagenta);
write(name1,' ');
textcolor(yellow);
write('vuoi pescare una carta? Premi ');
textcolor(white);
write('"s" ');
textcolor(yellow);
write('per confermare: ');
textcolor(lightmagenta);
readln(pescaX);
textcolor(yellow);
if pescaX='S' then pescaX:='s';
if pescaX='s' then begin
 if (coperta1=false) then pesca:='c'
   else pesca:='s';


  if (pesca='s') and (giro1=1) then begin
                  caricaS1;
                  pesca:='';
                  repeat
                        carte1[2]:=random(39)+1;
                  until (carte1[2]<>carte1[1]) and (carte1[2]<>carte2[1]);
                  giro1:=2;
                  assegnaz1;
                  end;


  if (pesca='s') and (giro1=2) then begin
                  caricaS1;
                  pesca:='';
                  repeat
                        carte1[3]:=random(39)+1;
                  until (carte1[3]<>carte1[1]) and (carte1[3]<>carte1[2]) and (carte1[3]<>carte2[1]);
                  giro1:=3;
                  assegnaz1;
                  end;


  if (pesca='s') and (giro1=3) then begin
                  caricaS1;
                  pesca:='';
                  repeat
                        carte1[4]:=random(39)+1;
                  until (carte1[4]<>carte1[1]) and (carte1[4]<>carte1[2]) and (carte1[4]<>carte1[3]) and (carte1[4]<>carte2[1]);
                  giro1:=4;
                  assegnaz1;
                  end;


  if (pesca='s') and (giro1=4) then begin
                  caricaS1;
                  pesca:='';
                  repeat
                        carte1[5]:=random(39)+1;
                  until (carte1[5]<>carte1[1]) and (carte1[5]<>carte1[2]) and (carte1[5]<>carte1[3]) and (carte1[5]<>carte1[4]) and (carte1[5]<>carte2[1]);
                  giro1:=5;
                  assegnaz1;
                  end;

  if (pesca='s') and (giro1=5) then begin
                 caricaS1;
                  pesca:='';
                  repeat
                        carte1[6]:=random(39)+1;
                  until (carte1[6]<>carte1[1]) and (carte1[6]<>carte1[2]) and (carte1[6]<>carte1[3]) and (carte1[6]<>carte1[4]) and (carte1[6]<>carte1[5]) and (carte1[6]<>carte2[1]);
                  giro1:=6;
                  assegnaz1;
                  end;

  if (pesca='s') and (giro1=6) then begin
                caricaS1;
                  pesca:='';
                  repeat
                        carte1[7]:=random(39)+1;
                  until (carte1[7]<>carte1[1]) and (carte1[7]<>carte1[2]) and (carte1[7]<>carte1[3]) and (carte1[7]<>carte1[4]) and (carte1[7]<>carte1[5]) and (carte1[7]<>carte1[6]) and (carte1[7]<>carte2[1]);
                  giro1:=7;
                  assegnaz1;
                  end;


  if (pesca='s') and (giro1=7) then begin
                     caricaS1;
                  pesca:='';
                  repeat
                        carte1[8]:=random(39)+1;
                  until (carte1[8]<>carte1[1]) and (carte1[8]<>carte1[2]) and (carte1[8]<>carte1[3]) and (carte1[8]<>carte1[4]) and (carte1[8]<>carte1[5]) and (carte1[8]<>carte1[6]) and (carte1[8]<>carte1[7]) and (carte1[8]<>carte2[1]);
                  giro1:=8;
                  assegnaz1;
                  end;


  if (pesca='s') and (giro1=8) then begin
                       caricaS1;
                  pesca:='';
                  repeat
                        carte1[9]:=random(39)+1;
                  until (carte1[9]<>carte1[1]) and (carte1[9]<>carte1[2]) and (carte1[9]<>carte1[3]) and (carte1[9]<>carte1[4]) and (carte1[9]<>carte1[5]) and (carte1[9]<>carte1[6]) and (carte1[9]<>carte1[7]) and (carte1[9]<>carte1[8]) and (carte1[9]<>carte2[1]);
                  giro1:=9;
                  assegnaz1;
                  end;

   if (pesca='s') and (giro1=9) then begin
                       caricaS1;
                  pesca:='';
                  repeat
                        carte1[10]:=random(39)+1;
                  until (carte1[10]<>carte1[1]) and (carte1[10]<>carte1[2]) and (carte1[10]<>carte1[3]) and (carte1[10]<>carte1[4]) and (carte1[10]<>carte1[5]) and (carte1[10]<>carte1[6]) and (carte1[10]<>carte1[7]) and (carte1[10]<>carte1[8]) and (carte1[10]<>carte1[9]) and (carte1[10]<>carte2[1]);
                  giro1:=10;
                  assegnaz1;
                  end;

  if (pesca='s') and (giro1=10) then begin
                     caricaS1;
                  pesca:='';
                  repeat
                        carte1[11]:=random(39)+1;
                  until (carte1[11]<>carte1[1]) and (carte1[11]<>carte1[2]) and (carte1[11]<>carte1[3]) and (carte1[11]<>carte1[4]) and (carte1[11]<>carte1[5]) and (carte1[11]<>carte1[6]) and (carte1[11]<>carte1[7]) and (carte1[11]<>carte1[8]) and (carte1[11]<>carte1[9]) and (carte1[11]<>carte1[10]) and (carte1[11]<>carte2[1]);
                  giro1:=11;
                  assegnaz1;
                  end;


  if (pesca='s') and (giro1=11) then begin
                            caricaS1;
                  pesca:='';
                  repeat
                        carte1[12]:=random(39)+1;
                  until (carte1[12]<>carte1[1]) and (carte1[12]<>carte1[2]) and (carte1[13]<>carte1[3]) and (carte1[13]<>carte1[4]) and (carte1[13]<>carte1[5]) and (carte1[13]<>carte1[6]) and (carte1[12]<>carte1[7]) and (carte1[12]<>carte1[8]) and (carte1[12]<>carte1[9]) and (carte1[12]<>carte1[10]) and (carte1[12]<>carte1[11]) and (carte1[12]<>carte2[1]);
                  giro1:=12;
                  assegnaz1;
                  end;

  if (pesca='s') and (giro1=12) then begin
                  caricaS1;
                  pesca:='';
                  repeat
                        carte1[13]:=random(39)+1;
                  until (carte1[13]<>carte1[1]) and (carte1[13]<>carte1[2]) and (carte1[13]<>carte1[3]) and (carte1[13]<>carte1[4]) and (carte1[13]<>carte1[5]) and (carte1[13]<>carte1[6]) and (carte1[13]<>carte1[7]) and (carte1[13]<>carte1[8]) and (carte1[13]<>carte1[9]) and (carte1[13]<>carte1[10]) and (carte1[13]<>carte1[11]) and (carte1[13]<>carte1[12]) and (carte1[13]<>carte2[1]);
                  giro1:=13;
                  assegnaz1;
                  end;

             end;


  {carte coperte}
  if (pesca='c') and (giro1=1) then begin
                  caricac1;
                  pesca:='';
                  repeat
                        carte1[2]:=random(39)+1;
                  until (carte1[2]<>carte1[1]) and (carte1[2]<>carte2[1]);
                  giro1:=2;
                  assegnazc1;
                  end;



  if (pesca='c') and (giro1=2) then begin
                  caricac1;
                  pesca:='';
                  repeat
                        carte1[3]:=random(39)+1;
                  until (carte1[3]<>carte1[2]) and (carte1[3]<>carte1[1]) and (carte1[3]<>carte2[1]);
                  giro1:=3;
                  assegnazc1;
                  end;


  if (pesca='c') and (giro1=3) then begin
                  caricac1;
                  pesca:='';
                  repeat
                        carte1[4]:=random(39)+1;
                  until (carte1[4]<>carte1[1]) and (carte1[4]<>carte1[2]) and (carte1[4]<>carte1[3]) and (carte1[4]<>carte2[1]);
                  giro1:=4;
                  assegnazc1;
                  end;


  if (pesca='c') and (giro1=4) then begin
                  caricac1;
                  pesca:='';
                  repeat
                        carte1[5]:=random(39)+1;
                  until (carte1[5]<>carte1[1]) and (carte1[5]<>carte1[2]) and (carte1[5]<>carte1[3]) and (carte1[5]<>carte1[4]) and (carte1[5]<>carte2[1]);
                  giro1:=5;
                  assegnazc1;
                  end;

  if (pesca='c') and (giro1=5) then begin
                  caricac1;
                  pesca:='';
                  repeat
                        carte1[6]:=random(39)+1;
                  until (carte1[6]<>carte1[1]) and (carte1[6]<>carte1[2]) and (carte1[6]<>carte1[3]) and (carte1[6]<>carte1[4]) and (carte1[6]<>carte1[5]) and (carte1[6]<>carte2[1]);
                  giro1:=6;
                  assegnazc1;
                  end;

  if (pesca='c') and (giro1=6) then begin
                  caricac1;
                  pesca:='';
                  repeat
                        carte1[7]:=random(39)+1;
                  until (carte1[7]<>carte1[1]) and (carte1[7]<>carte1[2]) and (carte1[7]<>carte1[3]) and (carte1[7]<>carte1[4]) and (carte1[7]<>carte1[5]) and (carte1[7]<>carte1[6]) and (carte1[7]<>carte2[1]);
                  giro1:=7;
                  assegnaz1;
                  end;


  if (pesca='c') and (giro1=7) then begin
                  caricac1;
                  pesca:='';
                  repeat
                        carte1[8]:=random(39)+1;
                  until (carte1[8]<>carte1[1]) and (carte1[8]<>carte1[2]) and (carte1[8]<>carte1[3]) and (carte1[8]<>carte1[4]) and (carte1[8]<>carte1[5]) and (carte1[8]<>carte1[6]) and (carte1[8]<>carte1[7]) and (carte1[8]<>carte2[1]);
                  giro1:=8;
                  assegnazc1;
                  end;


  if (pesca='c') and (giro1=8) then begin
                  caricac1;
                  pesca:='';
                  repeat
                        carte1[9]:=random(39)+1;
                  until (carte1[9]<>carte1[1]) and (carte1[9]<>carte1[2]) and (carte1[9]<>carte1[3]) and (carte1[9]<>carte1[4]) and (carte1[9]<>carte1[5]) and (carte1[9]<>carte1[6]) and (carte1[9]<>carte1[7]) and (carte1[9]<>carte1[8]) and (carte1[9]<>carte2[1]);
                  giro1:=9;
                  assegnazc1;
                  end;

  if (pesca='c') and (giro1=9) then begin
                  caricac1;
                  pesca:='';
                  repeat
                        carte1[10]:=random(39)+1;
                  until (carte1[10]<>carte1[1]) and (carte1[10]<>carte1[2]) and (carte1[10]<>carte1[3]) and (carte1[10]<>carte1[4]) and (carte1[10]<>carte1[5]) and (carte1[10]<>carte1[6]) and (carte1[10]<>carte1[7]) and (carte1[10]<>carte1[8]) and (carte1[10]<>carte1[9]) and (carte1[10]<>carte2[1]);
                  giro1:=10;
                  assegnazc1;
                  end;

  if (pesca='c') and (giro1=10) then begin
                 caricac1;
                  pesca:='';
                  repeat
                        carte1[11]:=random(39)+1;
                  until (carte1[11]<>carte1[1]) and (carte1[11]<>carte1[2]) and (carte1[11]<>carte1[3]) and (carte1[11]<>carte1[4]) and (carte1[11]<>carte1[5]) and (carte1[11]<>carte1[6]) and (carte1[11]<>carte1[7]) and (carte1[11]<>carte1[8]) and (carte1[11]<>carte1[9]) and (carte1[11]<>carte1[10]) and (carte1[11]<>carte2[1]);
                  giro1:=11;
                  assegnazc1;
                  end;


  if (pesca='c') and (giro1=11) then begin
                  caricac1;
                  pesca:='';
                  repeat
                        carte1[12]:=random(39)+1;
                  until (carte1[12]<>carte1[1]) and (carte1[12]<>carte1[2]) and (carte1[13]<>carte1[3]) and (carte1[13]<>carte1[4]) and (carte1[13]<>carte1[5]) and (carte1[13]<>carte1[6]) and (carte1[12]<>carte1[7]) and (carte1[12]<>carte1[8]) and (carte1[12]<>carte1[9]) and (carte1[12]<>carte1[10]) and (carte1[12]<>carte1[11]) and (carte1[12]<>carte2[1]);
                  giro1:=12;
                  assegnazc1;
                  end;

  if (pesca='c') and (giro1=12) then begin
                  caricac1;
                  pesca:='';
                  repeat
                        carte1[13]:=random(39)+1;
                  until (carte1[13]<>carte1[1]) and (carte1[13]<>carte1[2]) and (carte1[13]<>carte1[3]) and (carte1[13]<>carte1[4]) and (carte1[13]<>carte1[5]) and (carte1[13]<>carte1[6]) and (carte1[13]<>carte1[7]) and (carte1[13]<>carte1[8]) and (carte1[13]<>carte1[9]) and (carte1[13]<>carte1[10]) and (carte1[13]<>carte1[11]) and (carte1[13]<>carte1[12]) and (carte1[13]<>carte2[1]);
                  giro1:=13;
                  assegnazc1;
                  end;
 if pesca ='c' then coperta1:=true;
                  end; {questo end chiude l'if che ho messo subito all'inizio del repeat}



   if pesca='s' then stato1[giro1]:='s';

   if pesca='c' then stato1[giro1]:='c';

   writeln;


if (p1+c1<7.5) and (pescaX='s') then begin
   textcolor(lightmagenta);
   write(name1,' ');
   textcolor(yellow);
   write('vuoi girare la carta coperta [s]?');
   textcolor(white);
   readln(girare1);
   if (girare1='s') or (girare1='S') then begin
                                             for i:=1 to 15 do if stato1[i]='c' then stato1[i]:='s';
                                             coperta1:=false;
                                        end;
                                     end;
   textcolor(yellow);
   writeln;
   writeln;

   for i:=giro1 to 15 do if carte1[i]<>0 then mano1[i]:=temp1;
   for i:=1 to 15 do if mano1[i]<>0 then write(' ',mano1[i]:1:1);

   controllo_bug6_e_risoluzione1;  {molto importante, senza questa si crea un difetto che crea anche il bug delle carte coperte multiple}

until (p1+c1=7.5) or (p1+c1>7.5) or (pescaX='n');

player1ok:=true;               {dato che pleayer1 ormai ha finito il suo turno metto questa variabile a true, e solo se è false il giocatore può giocare}


{---------------------------------------------------------------------------------------------------------------------------------------------}
{---------------------------------------------------------------------------------------------------------------------------------------------}
{------------------------------Questo fa lo stesso di sopra con una aggiunta sotto per rigirare carte-----------------------------------------}
{---------------------------------------------------------------------------------------------------------------------------------------------}
{---------------------------------------------------------------------------------------------------------------------------------------------}


clrscr;

textcolor(white);
lungh2:=length(name2);
for i:=1 to lungh2+17 do write(chr(219));
writeln(chr(219));
write(chr(219));
textcolor(lightgreen);
write(' Giocatore 2 : ',name2,' ');
textcolor(white);
write(chr(219));
if length(name1)>length(name2) then for i:=1 to length(name1)-length(name2) do write(' ');
write('   Carte pescate: ');
textcolor(cyan);
writeln('?');
textcolor(white);
for i:=1 to lungh2+17 do write(chr(219));
writeln(chr(219));
writeln;




textcolor(white);
lungh1:=length(name1);
for i:=1 to lungh1+17 do write(chr(219));
writeln(chr(219));
write(chr(219));
textcolor(lightmagenta);
write(' Giocatore 1 : ',name1,' ');
textcolor(white);
write(chr(219));
if length(name2)>length(name1) then for i:=1 to length(name2)-length(name1) do write(' ');
write('   Carte pescate: ');
textcolor(cyan);

for i:=1 to 15 do begin
                          textcolor(lightred);
                          if stato1[i]='c' then textcolor(cyan)
                             else textcolor(lightred);
                          if mano1[i]<>0 then write(' ',mano1[i]:1:1);
                          textcolor(lightred);
                     end;


textcolor(white);
writeln;
for i:=1 to lungh1+17 do write(chr(219));
writeln(chr(219));
writeln;

if p1+c1>=7.5 then pescaX:='n';


{IMPORTANTE!!!! Questo ciclo permette di gigare una carta se non se ne hanno coperte, in modo che il gicoatore dopo ne veda sempre una col "?"}
for i:=1 to 15 do if (stato1[i]='c') and (pescaX='n') then axx:=axx+1;
                                                    if axx=0 then begin
                                                                 repeat
                                                                   textcolor(lightred);
                                                                   writeln;
                                                                   write('Devi girare una carta! Quale?: ');
                                                                   textcolor(white);
                                                                   readln(giro_carta1);
                                                                   textcolor(yellow);
                                                                 until (giro_carta1>0) and (giro_carta1<14);
                                                                   stato1[giro_carta1]:='c'
                                                                   end;

 axx:=0;

{---------------------------------------------------------------------------------------------------------------------------------------------}
{---------------------------------------------------------------------------------------------------------------------------------------------}
{---------------------------------------------------------------------------------------------------------------------------------------------}
{---------------------------------------------------------------------------------------------------------------------------------------------}




{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}
{questo riscrive la stessa schermata che faceva all'inizio del repeat. Ma serve perchè se no non verrebbe refreshata}
{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}

clrscr;
textcolor(white);
lungh2:=length(name2);
for i:=1 to lungh2+17 do write(chr(219));
writeln(chr(219));
write(chr(219));
textcolor(lightgreen);
write(' Giocatore 2 : ',name2,' ');
textcolor(white);
write(chr(219));
if length(name1)>length(name2) then for i:=1 to length(name1)-length(name2) do write(' ');
write('   Carte pescate: ');
textcolor(cyan);
writeln('?');
textcolor(white);
for i:=1 to lungh2+17 do write(chr(219));
writeln(chr(219));
writeln;



textcolor(white);
lungh1:=length(name1);
for i:=1 to lungh1+17 do write(chr(219));
writeln(chr(219));
write(chr(219));
textcolor(lightmagenta);
write(' Giocatore 1 : ',name1,' ');
textcolor(white);
write(chr(219));
if length(name2)>length(name1) then for i:=1 to length(name2)-length(name1) do write(' ');
write('   Carte pescate: ');
textcolor(cyan);

for i:=1 to 15 do begin
                          textcolor(lightred);
                          if stato1[i]='c' then textcolor(cyan)
                             else textcolor(lightred);
                          if mano1[i]<>0 then write(' ',mano1[i]:1:1);
                          textcolor(lightred);
                     end;


textcolor(white);
writeln;
for i:=1 to lungh1+17 do write(chr(219));
writeln(chr(219));
writeln;
textcolor(yellow);
write('Hai totalizzato: ');
textcolor(white);
writeln(p1+c1:1:1);

readln;
{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}




{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}
{PLAYER 2 PLAYER 2 PLAYER 2 PLAYER 2 PLAYER 2 PLAYER 2 PLAYER 2 PLAYER 2 PLAYER 2 PLAYER 2 PLAYER 2 PLAYER 2 PLAYER 2}
{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}

clrscr;
repeat
textcolor(12);
str:='Giocatore 2, Ora tocca a te! Premi un tasto per iniziare';
gotoxy((80-length(str)) div 2,10);
writeln(str);
delay(300);
clrscr;
textcolor(14);
str:='Giocatore 2, Ora tocca a te! Premi un tasto per iniziare';
gotoxy((80-length(str)) div 2,10);
writeln(str);
delay(300);
clrscr;
textcolor(10);
str:='Giocatore 2, Ora tocca a te! Premi un tasto per iniziare';
gotoxy((80-length(str)) div 2,10);
writeln(str);
delay(300);
clrscr;
until keypressed;

textcolor(lightmagenta);
str:='Giocatore 2! Premi un tasto per iniziare';
gotoxy((80-length(str)) div 2,10);
writeln(str);
readln;
textcolor(yellow);

repeat

if (player2ok=false) then begin

clrscr;
textcolor(white);
lungh1:=length(name1);
for i:=1 to lungh1+17 do write(chr(219));
writeln(chr(219));
write(chr(219));
textcolor(lightmagenta);
write(' Giocatore 1 : ',name1,' ');
textcolor(white);
write(chr(219));
if length(name2)>length(name1) then for i:=1 to length(name2)-length(name1) do write(' ');
write('   Carte pescate: ');
textcolor(cyan);
for i:=1 to 15 do begin
                          textcolor(lightred);
                          if stato1[i]='c' then textcolor(cyan)
                             else textcolor(lightred);
                          if (mano1[i]<>0) and (stato1[i]<>'c') then write(' ',mano1[i]:1:1);
                          if stato1[i]='c' then begin
                                                     textcolor(cyan);
                                                     write(' ?');
                                                end;
                          textcolor(lightred);
                     end;


writeln;
textcolor(white);
for i:=1 to lungh1+17 do write(chr(219));
writeln(chr(219));
writeln;




textcolor(white);
lungh2:=length(name2);
for i:=1 to lungh2+17 do write(chr(219));
writeln(chr(219));
write(chr(219));
textcolor(lightgreen);
write(' Giocatore 2 : ',name2,' ');
textcolor(white);
write(chr(219));
if length(name1)>length(name2) then for i:=1 to length(name1)-length(name2) do write(' ');
write('   Carte pescate: ');
textcolor(cyan);

for i:=1 to 15 do begin
                          textcolor(lightred);
                          if stato2[i]='c' then textcolor(cyan)
                             else textcolor(lightred);
                          if mano2[i]<>0 then write(' ',mano2[i]:1:1);
                          textcolor(lightred);
                     end;


textcolor(white);
writeln;
for i:=1 to lungh2+17 do write(chr(219));
writeln(chr(219));
writeln;
textcolor(yellow);

writeln;
textcolor(lightgreen);
write(name2,' ');
textcolor(yellow);
write('vuoi pescare una carta? Premi ');
textcolor(white);
write('"s" ');
textcolor(yellow);
write('per confermare: ');
textcolor(lightmagenta);
readln(pescaX);
textcolor(yellow);

if pescaX='S' then pescaX:='s';
if pescaX='s' then begin
 if (coperta2=false) then pesca:='c'
   else pesca:='s';


  if (pesca='s') and (giro2=1) then begin
                  caricaS2;
                  pesca:='';
                  repeat
                        carte2[2]:=random(39)+1;
                  until (carte2[2]<>carte2[1]) and (carte2[2]<>carte1[1]) and (carte2[2]<>carte1[2]) and (carte2[2]<>carte1[3]) and (carte2[2]<>carte1[4]) and (carte2[2]<>carte1[5]) and (carte2[2]<>carte1[6]) and (carte2[2]<>carte1[7]) and (carte2[2]<>carte1[8]) and (carte2[2]<>carte1[9]) and (carte2[2]<>carte1[10]) and (carte2[2]<>carte1[11]) and (carte2[2]<>carte1[12]) and (carte2[2]<>carte1[13]);
                  giro2:=2;
                  assegnaz2;
                  end;



  if (pesca='s') and (giro2=2) then begin
                  caricaS2;
                  pesca:='';
                  repeat
                        carte2[3]:=random(39)+1;
                  until (carte2[3]<>carte2[1]) and (carte2[3]<>carte2[2]) and (carte2[3]<>carte1[1]) and (carte2[3]<>carte1[2]) and (carte2[3]<>carte1[3]) and (carte2[3]<>carte1[4]) and (carte2[3]<>carte1[5]) and (carte2[3]<>carte1[6]) and (carte2[3]<>carte1[7]) and (carte2[3]<>carte1[8]) and (carte2[3]<>carte1[9]) and (carte2[3]<>carte1[10]) and (carte2[3]<>carte1[11]) and (carte2[3]<>carte1[12]) and (carte2[3]<>carte1[13]);
                  giro2:=3;
                  assegnaz2;
                  end;


  if (pesca='s') and (giro2=3) then begin
                  caricaS2;
                  pesca:='';
                  repeat
                        carte2[4]:=random(39)+1;
                  until (carte2[4]<>carte2[1]) and (carte2[4]<>carte2[2]) and (carte2[4]<>carte2[3]) and (carte2[4]<>carte1[1]) and (carte2[4]<>carte1[2]) and (carte2[4]<>carte1[3]) and (carte2[4]<>carte1[4]) and (carte2[4]<>carte1[5]) and (carte2[4]<>carte1[6]) and (carte2[4]<>carte1[7]) and (carte2[4]<>carte1[8]) and (carte2[4]<>carte1[9]) and (carte2[4]<>carte1[10]) and (carte2[4]<>carte1[11]) and (carte2[4]<>carte1[12]) and (carte2[4]<>carte1[13]);
                  giro2:=4;
                  assegnaz2;
                  end;


  if (pesca='s') and (giro2=4) then begin
                  caricaS2;
                  pesca:='';
                  repeat
                        carte2[5]:=random(39)+1;
                  until (carte2[5]<>carte2[1]) and (carte2[5]<>carte2[2]) and (carte2[5]<>carte2[3]) and (carte2[5]<>carte2[4]) and (carte2[5]<>carte1[1]) and (carte2[5]<>carte1[2]) and (carte2[5]<>carte1[3]) and (carte2[5]<>carte1[4]) and (carte2[5]<>carte1[5]) and (carte2[5]<>carte1[6]) and (carte2[5]<>carte1[7]) and (carte2[5]<>carte1[8]) and (carte2[5]<>carte1[9]) and (carte2[5]<>carte1[10]) and (carte2[5]<>carte1[11]) and (carte2[5]<>carte1[12]) and (carte2[5]<>carte1[13]);
                  giro2:=5;
                  assegnaz2;
                  end;

  if (pesca='s') and (giro2=5) then begin
                  caricaS2;
                  pesca:='';
                  repeat
                        carte2[6]:=random(39)+1;
                  until (carte2[6]<>carte2[1]) and (carte2[6]<>carte2[2]) and (carte2[6]<>carte2[3]) and (carte2[6]<>carte2[4]) and (carte2[6]<>carte2[5]) and (carte2[6]<>carte1[1]) and (carte2[6]<>carte1[2]) and (carte2[6]<>carte1[3]) and (carte2[6]<>carte1[4]) and (carte2[6]<>carte1[5]) and (carte2[6]<>carte1[6]) and (carte2[6]<>carte1[7]) and (carte2[6]<>carte1[8]) and (carte2[6]<>carte1[9]) and (carte2[6]<>carte1[10]) and (carte2[6]<>carte1[11]) and (carte2[6]<>carte1[12]) and (carte2[6]<>carte1[13]);
                  giro2:=6;
                  assegnaz2;
                  end;

  if (pesca='s') and (giro2=6) then begin
                  caricaS2;
                  pesca:='';
                  repeat
                        carte2[7]:=random(39)+1;
                  until (carte2[7]<>carte2[1]) and (carte2[7]<>carte2[2]) and (carte2[7]<>carte2[3]) and (carte2[7]<>carte2[4]) and (carte2[7]<>carte2[5]) and (carte2[7]<>carte2[6]) and (carte2[7]<>carte1[1]) and (carte2[7]<>carte1[2]) and (carte2[7]<>carte1[3]) and (carte2[7]<>carte1[4]) and (carte2[7]<>carte1[5]) and (carte2[7]<>carte1[6]) and (carte2[7]<>carte1[7]) and (carte2[7]<>carte1[8]) and (carte2[7]<>carte1[9]) and (carte2[7]<>carte1[10]) and (carte2[7]<>carte1[11]) and (carte2[7]<>carte1[12]) and (carte2[7]<>carte1[13]);
                  giro2:=7;
                  assegnaz2;
                  end;


  if (pesca='s') and (giro2=7) then begin
                  caricaS2;
                  pesca:='';
                  repeat
                        carte2[8]:=random(39)+1;
                  until (carte2[8]<>carte2[1]) and (carte2[8]<>carte2[2]) and (carte2[8]<>carte2[3]) and (carte2[8]<>carte2[4]) and (carte2[8]<>carte2[5]) and (carte2[8]<>carte2[6]) and (carte2[8]<>carte2[7]) and (carte2[8]<>carte1[1]) and (carte2[8]<>carte1[2]) and (carte2[8]<>carte1[3]) and (carte2[8]<>carte1[4]) and (carte2[8]<>carte1[5]) and (carte2[8]<>carte1[6]) and (carte2[8]<>carte1[7]) and (carte2[8]<>carte1[8]) and (carte2[8]<>carte1[9]) and (carte2[8]<>carte1[10]) and (carte2[8]<>carte1[11]) and (carte2[8]<>carte1[12]) and (carte2[8]<>carte1[13]);
                  giro2:=8;
                  assegnaz2;
                  end;


  if (pesca='s') and (giro2=8) then begin
                  caricaS2;
                  pesca:='';
                  repeat
                        carte2[9]:=random(39)+1;
                  until (carte2[9]<>carte2[1]) and (carte2[9]<>carte2[2]) and (carte2[9]<>carte2[3]) and (carte2[9]<>carte2[4]) and (carte2[9]<>carte2[5]) and (carte2[9]<>carte2[6]) and (carte2[9]<>carte2[7]) and (carte2[9]<>carte2[8]) and (carte2[9]<>carte1[1]) and (carte2[9]<>carte1[2]) and (carte2[9]<>carte1[3]) and (carte2[9]<>carte1[4]) and (carte2[9]<>carte1[5]) and (carte2[9]<>carte1[6]) and (carte2[9]<>carte1[7]) and (carte2[9]<>carte1[8]) and (carte2[9]<>carte1[9]) and (carte2[9]<>carte1[10]) and (carte2[9]<>carte1[11]) and (carte2[9]<>carte1[12]) and (carte2[9]<>carte1[13]);
                  giro2:=9;
                  assegnaz2;
                  end;

  if (pesca='s') and (giro2=9) then begin
                  caricaS2;
                  pesca:='';
                  repeat
                        carte2[10]:=random(39)+1;
                  until (carte2[10]<>carte2[1]) and (carte2[10]<>carte2[2]) and (carte2[10]<>carte2[3]) and (carte2[10]<>carte2[4]) and (carte2[10]<>carte2[5]) and (carte2[10]<>carte2[6]) and (carte2[10]<>carte2[7]) and (carte2[10]<>carte2[8]) and (carte2[10]<>carte2[9]) and (carte2[10]<>carte1[1]) and (carte2[10]<>carte1[2]) and (carte2[10]<>carte1[3]) and (carte2[10]<>carte1[4]) and (carte2[10]<>carte1[5]) and (carte2[10]<>carte1[6]) and (carte2[10]<>carte1[7]) and (carte2[10]<>carte1[8]) and (carte2[10]<>carte1[9]) and (carte2[10]<>carte1[10]) and (carte2[10]<>carte1[11]) and (carte2[10]<>carte1[12]) and (carte2[10]<>carte1[13]);
                  giro2:=10;
                  assegnaz2;
                  end;

  if (pesca='s') and (giro2=10) then begin
                  caricaS2;
                  pesca:='';
                  repeat
                        carte2[11]:=random(39)+1;
                  until (carte2[11]<>carte2[1]) and (carte2[11]<>carte2[2]) and (carte2[11]<>carte2[3]) and (carte2[11]<>carte2[4]) and (carte2[11]<>carte2[5]) and (carte2[11]<>carte2[6]) and (carte2[11]<>carte2[7]) and (carte2[11]<>carte2[8]) and (carte2[11]<>carte2[9]) and (carte2[11]<>carte2[10]) and (carte2[11]<>carte1[1]) and (carte2[11]<>carte1[2]) and (carte2[11]<>carte1[3]) and (carte2[11]<>carte1[4]) and (carte2[11]<>carte1[5]) and (carte2[11]<>carte1[6]) and (carte2[11]<>carte1[7]) and (carte2[11]<>carte1[8]) and (carte2[11]<>carte1[9]) and (carte2[11]<>carte1[10]) and (carte2[11]<>carte1[11]) and (carte2[11]<>carte1[12]) and (carte2[11]<>carte1[13]);
                  giro2:=11;
                  assegnaz2;
                  end;


  if (pesca='s') and (giro2=11) then begin
                  caricaS2;
                  pesca:='';
                  repeat
                        carte2[12]:=random(39)+1;
                  until (carte2[12]<>carte2[1]) and (carte2[12]<>carte2[2]) and (carte2[13]<>carte2[3]) and (carte2[13]<>carte2[4]) and (carte2[13]<>carte2[5]) and (carte2[13]<>carte2[6]) and (carte2[12]<>carte2[7]) and (carte2[12]<>carte2[8]) and (carte2[12]<>carte2[9]) and (carte2[12]<>carte2[10]) and (carte2[12]<>carte2[11]) and (carte2[12]<>carte1[1]) and (carte2[12]<>carte1[2]) and (carte2[12]<>carte1[3]) and (carte2[12]<>carte1[4]) and (carte2[12]<>carte1[5]) and (carte2[12]<>carte1[6]) and (carte2[12]<>carte1[7]) and (carte2[12]<>carte1[8]) and (carte2[12]<>carte1[9]) and (carte2[12]<>carte1[10]) and (carte2[12]<>carte1[11]) and (carte2[12]<>carte1[12]) and (carte2[12]<>carte1[13]);
                  giro2:=12;
                  assegnaz2;
                  end;

  if (pesca='s') and (giro2=12) then begin
                  caricaS2;
                  pesca:='';
                  repeat
                        carte2[13]:=random(39)+1;
                  until (carte2[13]<>carte2[1]) and (carte2[13]<>carte2[2]) and (carte2[13]<>carte2[3]) and (carte2[13]<>carte2[4]) and (carte2[13]<>carte2[5]) and (carte2[13]<>carte2[6]) and (carte2[13]<>carte2[7]) and (carte2[13]<>carte2[8]) and (carte2[13]<>carte2[9]) and (carte2[13]<>carte2[10]) and (carte2[13]<>carte2[11]) and (carte2[13]<>carte2[12]) and (carte2[13]<>carte1[1]) and (carte2[13]<>carte1[2]) and (carte2[13]<>carte1[3]) and (carte2[13]<>carte1[4]) and (carte2[13]<>carte1[5]) and (carte2[13]<>carte1[6]) and (carte2[13]<>carte1[7]) and (carte2[13]<>carte1[8]) and (carte2[13]<>carte1[9]) and (carte2[13]<>carte1[10]) and (carte2[13]<>carte1[11]) and (carte2[13]<>carte1[12]) and (carte2[13]<>carte1[13]);
                  giro2:=13;
                  assegnaz2;
                  end;
             end;


  {carte coperte}
   if (pesca='c') and (giro2=1) then begin
                  caricaC2;
                  pesca:='';
                  repeat
                        carte2[2]:=random(39)+1;
                  until (carte2[2]<>carte2[1]) and (carte2[2]<>carte1[1]) and (carte2[2]<>carte1[2]) and (carte2[2]<>carte1[3]) and (carte2[2]<>carte1[4]) and (carte2[2]<>carte1[5]) and (carte2[2]<>carte1[6]) and (carte2[2]<>carte1[7]) and (carte2[2]<>carte1[8]) and (carte2[2]<>carte1[9]) and (carte2[2]<>carte1[10]) and (carte2[2]<>carte1[11]) and (carte2[2]<>carte1[12]) and (carte2[2]<>carte1[13]);
                  giro2:=2;
                  assegnazc2;
                  end;



  if (pesca='c') and (giro2=2) then begin
                  caricaC2;
                  pesca:='';
                  repeat
                        carte2[3]:=random(39)+1;
                  until (carte2[3]<>carte2[1]) and (carte2[3]<>carte2[2]) and (carte2[3]<>carte1[1]) and (carte2[3]<>carte1[2]) and (carte2[3]<>carte1[3]) and (carte2[3]<>carte1[4]) and (carte2[3]<>carte1[5]) and (carte2[3]<>carte1[6]) and (carte2[3]<>carte1[7]) and (carte2[3]<>carte1[8]) and (carte2[3]<>carte1[9]) and (carte2[3]<>carte1[10]) and (carte2[3]<>carte1[11]) and (carte2[3]<>carte1[12]) and (carte2[3]<>carte1[13]);
                  giro2:=3;
                  assegnazc2;
                  end;


  if (pesca='c') and (giro2=3) then begin
                  caricaC2;
                  pesca:='';
                  repeat
                        carte2[4]:=random(39)+1;
                  until (carte2[4]<>carte2[1]) and (carte2[4]<>carte2[2]) and (carte2[4]<>carte2[3]) and (carte2[4]<>carte1[1]) and (carte2[4]<>carte1[2]) and (carte2[4]<>carte1[3]) and (carte2[4]<>carte1[4]) and (carte2[4]<>carte1[5]) and (carte2[4]<>carte1[6]) and (carte2[4]<>carte1[7]) and (carte2[4]<>carte1[8]) and (carte2[4]<>carte1[9]) and (carte2[4]<>carte1[10]) and (carte2[4]<>carte1[11]) and (carte2[4]<>carte1[12]) and (carte2[4]<>carte1[13]);
                  giro2:=4;
                  assegnazc2;
                  end;


  if (pesca='c') and (giro2=4) then begin
                  caricaC2;
                  pesca:='';
                  repeat
                        carte2[5]:=random(39)+1;
                  until (carte2[5]<>carte2[1]) and (carte2[5]<>carte2[2]) and (carte2[5]<>carte2[3]) and (carte2[5]<>carte2[4]) and (carte2[5]<>carte1[1]) and (carte2[5]<>carte1[2]) and (carte2[5]<>carte1[3]) and (carte2[5]<>carte1[4]) and (carte2[5]<>carte1[5]) and (carte2[5]<>carte1[6]) and (carte2[5]<>carte1[7]) and (carte2[5]<>carte1[8]) and (carte2[5]<>carte1[9]) and (carte2[5]<>carte1[10]) and (carte2[5]<>carte1[11]) and (carte2[5]<>carte1[12]) and (carte2[5]<>carte1[13]);
                  giro2:=5;
                  assegnazc2;
                  end;

  if (pesca='c') and (giro2=5) then begin
                  caricaC2;
                  pesca:='';
                  repeat
                        carte2[6]:=random(39)+1;
                  until (carte2[6]<>carte2[1]) and (carte2[6]<>carte2[2]) and (carte2[6]<>carte2[3]) and (carte2[6]<>carte2[4]) and (carte2[6]<>carte2[5]) and (carte2[6]<>carte1[1]) and (carte2[6]<>carte1[2]) and (carte2[6]<>carte1[3]) and (carte2[6]<>carte1[4]) and (carte2[6]<>carte1[5]) and (carte2[6]<>carte1[6]) and (carte2[6]<>carte1[7]) and (carte2[6]<>carte1[8]) and (carte2[6]<>carte1[9]) and (carte2[6]<>carte1[10]) and (carte2[6]<>carte1[11]) and (carte2[6]<>carte1[12]) and (carte2[6]<>carte1[13]);
                  giro2:=6;
                  assegnazc2;
                  end;

  if (pesca='c') and (giro2=6) then begin
                  caricaC2;
                  pesca:='';
                  repeat
                        carte2[7]:=random(39)+1;
                  until (carte2[7]<>carte2[1]) and (carte2[7]<>carte2[2]) and (carte2[7]<>carte2[3]) and (carte2[7]<>carte2[4]) and (carte2[7]<>carte2[5]) and (carte2[7]<>carte2[6]) and (carte2[7]<>carte1[1]) and (carte2[7]<>carte1[2]) and (carte2[7]<>carte1[3]) and (carte2[7]<>carte1[4]) and (carte2[7]<>carte1[5]) and (carte2[7]<>carte1[6]) and (carte2[7]<>carte1[7]) and (carte2[7]<>carte1[8]) and (carte2[7]<>carte1[9]) and (carte2[7]<>carte1[10]) and (carte2[7]<>carte1[11]) and (carte2[7]<>carte1[12]) and (carte2[7]<>carte1[13]);
                  giro2:=7;
                  assegnazc2;
                  end;


  if (pesca='c') and (giro2=7) then begin
                  caricaC2;
                  pesca:='';
                  repeat
                        carte2[8]:=random(39)+1;
                  until (carte2[8]<>carte2[1]) and (carte2[8]<>carte2[2]) and (carte2[8]<>carte2[3]) and (carte2[8]<>carte2[4]) and (carte2[8]<>carte2[5]) and (carte2[8]<>carte2[6]) and (carte2[8]<>carte2[7]) and (carte2[8]<>carte1[1]) and (carte2[8]<>carte1[2]) and (carte2[8]<>carte1[3]) and (carte2[8]<>carte1[4]) and (carte2[8]<>carte1[5]) and (carte2[8]<>carte1[6]) and (carte2[8]<>carte1[7]) and (carte2[8]<>carte1[8]) and (carte2[8]<>carte1[9]) and (carte2[8]<>carte1[10]) and (carte2[8]<>carte1[11]) and (carte2[8]<>carte1[12]) and (carte2[8]<>carte1[13]);
                  giro2:=8;
                  assegnazc2;
                  end;


  if (pesca='c') and (giro2=8) then begin
                  caricaC2;
                  pesca:='';
                  repeat
                        carte2[9]:=random(39)+1;
                  until (carte2[9]<>carte2[1]) and (carte2[9]<>carte2[2]) and (carte2[9]<>carte2[3]) and (carte2[9]<>carte2[4]) and (carte2[9]<>carte2[5]) and (carte2[9]<>carte2[6]) and (carte2[9]<>carte2[7]) and (carte2[9]<>carte2[8]) and (carte2[9]<>carte1[1]) and (carte2[9]<>carte1[2]) and (carte2[9]<>carte1[3]) and (carte2[9]<>carte1[4]) and (carte2[9]<>carte1[5]) and (carte2[9]<>carte1[6]) and (carte2[9]<>carte1[7]) and (carte2[9]<>carte1[8]) and (carte2[9]<>carte1[9]) and (carte2[9]<>carte1[10]) and (carte2[9]<>carte1[11]) and (carte2[9]<>carte1[12]) and (carte2[9]<>carte1[13]);
                  giro2:=9;
                  assegnazc2;
                  end;

  if (pesca='c') and (giro2=9) then begin
                  caricaC2;
                  pesca:='';
                  repeat
                        carte2[10]:=random(39)+1;
                  until (carte2[10]<>carte2[1]) and (carte2[10]<>carte2[2]) and (carte2[10]<>carte2[3]) and (carte2[10]<>carte2[4]) and (carte2[10]<>carte2[5]) and (carte2[10]<>carte2[6]) and (carte2[10]<>carte2[7]) and (carte2[10]<>carte2[8]) and (carte2[10]<>carte2[9]) and (carte2[10]<>carte1[1]) and (carte2[10]<>carte1[2]) and (carte2[10]<>carte1[3]) and (carte2[10]<>carte1[4]) and (carte2[10]<>carte1[5]) and (carte2[10]<>carte1[6]) and (carte2[10]<>carte1[7]) and (carte2[10]<>carte1[8]) and (carte2[10]<>carte1[9]) and (carte2[10]<>carte1[10]) and (carte2[10]<>carte1[11]) and (carte2[10]<>carte1[12]) and (carte2[10]<>carte1[13]);
                  giro2:=10;
                  assegnazc2;
                  end;

  if (pesca='c') and (giro2=10) then begin
                  caricaC2;
                  pesca:='';
                  repeat
                        carte2[11]:=random(39)+1;
                  until (carte2[11]<>carte2[1]) and (carte2[11]<>carte2[2]) and (carte2[11]<>carte2[3]) and (carte2[11]<>carte2[4]) and (carte2[11]<>carte2[5]) and (carte2[11]<>carte2[6]) and (carte2[11]<>carte2[7]) and (carte2[11]<>carte2[8]) and (carte2[11]<>carte2[9]) and (carte2[11]<>carte2[10]) and (carte2[11]<>carte1[1]) and (carte2[11]<>carte1[2]) and (carte2[11]<>carte1[3]) and (carte2[11]<>carte1[4]) and (carte2[11]<>carte1[5]) and (carte2[11]<>carte1[6]) and (carte2[11]<>carte1[7]) and (carte2[11]<>carte1[8]) and (carte2[11]<>carte1[9]) and (carte2[11]<>carte1[10]) and (carte2[11]<>carte1[11]) and (carte2[11]<>carte1[12]) and (carte2[11]<>carte1[13]);
                  giro2:=11;
                  assegnazc2;
                  end;

  if (pesca='c') and (giro2=11) then begin
                  caricaC2;
                  pesca:='';
                  repeat
                        carte2[12]:=random(39)+1;
                  until (carte2[12]<>carte2[1]) and (carte2[12]<>carte2[2]) and (carte2[13]<>carte2[3]) and (carte2[13]<>carte2[4]) and (carte2[13]<>carte2[5]) and (carte2[13]<>carte2[6]) and (carte2[12]<>carte2[7]) and (carte2[12]<>carte2[8]) and (carte2[12]<>carte2[9]) and (carte2[12]<>carte2[10]) and (carte2[12]<>carte2[11]) and (carte2[12]<>carte1[1]) and (carte2[12]<>carte1[2]) and (carte2[12]<>carte1[3]) and (carte2[12]<>carte1[4]) and (carte2[12]<>carte1[5]) and (carte2[12]<>carte1[6]) and (carte2[12]<>carte1[7]) and (carte2[12]<>carte1[8]) and (carte2[12]<>carte1[9]) and (carte2[12]<>carte1[10]) and (carte2[12]<>carte1[11]) and (carte2[12]<>carte1[12]) and (carte2[12]<>carte1[13]);
                  giro2:=12;
                  assegnazc2;
                  end;

  if (pesca='c') and (giro2=12) then begin
                  caricaC2;
                  pesca:='';
                  repeat
                        carte2[13]:=random(39)+1;
                  until (carte2[13]<>carte2[1]) and (carte2[13]<>carte2[2]) and (carte2[13]<>carte2[3]) and (carte2[13]<>carte2[4]) and (carte2[13]<>carte2[5]) and (carte2[13]<>carte2[6]) and (carte2[13]<>carte2[7]) and (carte2[13]<>carte2[8]) and (carte2[13]<>carte2[9]) and (carte2[13]<>carte2[10]) and (carte2[13]<>carte2[11]) and (carte2[13]<>carte2[12]) and (carte2[13]<>carte1[1]) and (carte2[13]<>carte1[2]) and (carte2[13]<>carte1[3]) and (carte2[13]<>carte1[4]) and (carte2[13]<>carte1[5]) and (carte2[13]<>carte1[6]) and (carte2[13]<>carte1[7]) and (carte2[13]<>carte1[8]) and (carte2[13]<>carte1[9]) and (carte2[13]<>carte1[10]) and (carte2[13]<>carte1[11]) and (carte2[13]<>carte1[12]) and (carte2[13]<>carte1[13]);
                  giro2:=13;
                  assegnazc2;
                  end;

 if pesca ='c' then coperta2:=true;
                  end; {questo end chiude l'if che ho messo subito all'inizio del repeat}


   if pesca='s' then stato2[giro2]:='s';

   if pesca='c' then stato2[giro2]:='c';
    writeln;
if (p2+c2<7.5) and (pescaX='s') then begin
   textcolor(lightgreen);
   write(name2,' ');
   textcolor(yellow);
   write('vuoi girare la carta coperta [s]?');
   textcolor(white);
   readln(girare2);
   if (girare2='s') or (girare2='S') then begin
                                             for i:=1 to 15 do if stato2[i]='c' then stato2[i]:='s';
                                             coperta2:=false;
                                        end;
                                     end;
   textcolor(yellow);
   writeln;
   writeln;

   for i:=giro2 to 15 do if carte2[i]<>0 then mano2[i]:=temp2;
   for i:=1 to 15 do if mano2[i]<>0 then write(' ',mano2[i]:1:1);

   controllo_bug6_e_risoluzione2    {molto importante, senza questa si crea un difetto che crea anche il bug delle carte coperte multiple}



until (p2+c2=7.5) or (p2+c2>7.5) or (pescaX='n');



{---------------------------------------------------------------------------------------------------------------------------------------------}
{---------------------------------------------------------------------------------------------------------------------------------------------}
{------------------------------Questo fa lo stesso di sopra con una aggiunta sotto per rigirare carte-----------------------------------------}
{---------------------------------------------------------------------------------------------------------------------------------------------}
{---------------------------------------------------------------------------------------------------------------------------------------------}

clrscr;
textcolor(white);
lungh1:=length(name1);
for i:=1 to lungh1+17 do write(chr(219));
writeln(chr(219));
write(chr(219));
textcolor(lightmagenta);
write(' Giocatore 1 : ',name1,' ');
textcolor(white);
write(chr(219));
if length(name2)>length(name1) then for i:=1 to length(name2)-length(name1) do write(' ');
write('   Carte pescate: ');
textcolor(cyan);
for i:=1 to 15 do begin
                          textcolor(lightred);
                          if stato1[i]='c' then textcolor(cyan)
                             else textcolor(lightred);
                          if (mano1[i]<>0) and (stato1[i]<>'c') then write(' ',mano1[i]:1:1);
                          if stato1[i]='c' then begin
                                                     textcolor(cyan);
                                                     write(' ?');
                                                end;
                          textcolor(lightred);
                     end;


writeln;
textcolor(white);
for i:=1 to lungh1+17 do write(chr(219));
writeln(chr(219));
writeln;




textcolor(white);
lungh2:=length(name2);
for i:=1 to lungh2+17 do write(chr(219));
writeln(chr(219));
write(chr(219));
textcolor(lightgreen);
write(' Giocatore 2 : ',name2,' ');
textcolor(white);
write(chr(219));
if length(name1)>length(name2) then for i:=1 to length(name1)-length(name2) do write(' ');
write('   Carte pescate: ');
textcolor(cyan);

for i:=1 to 15 do begin
                          textcolor(lightred);
                          if stato2[i]='c' then textcolor(cyan)
                             else textcolor(lightred);
                          if mano2[i]<>0 then write(' ',mano2[i]:1:1);
                          textcolor(lightred);
                     end;


textcolor(white);
writeln;
for i:=1 to lungh2+17 do write(chr(219));
writeln(chr(219));
writeln;


if p2+c2>=7.5 then pescaX:='n';


{IMPORTANTE!!!! Questo ciclo permette di gigare una carta se non se ne hanno coperte, in modo che il gicoatore dopo ne veda sempre una col "?"}
for i:=1 to 15 do if (stato2[i]='c') and (pescaX='n') then axx:=axx+1;
                                                    if axx=0 then begin
                                                                 repeat
                                                                   textcolor(lightred);
                                                                   writeln;
                                                                   write('Devi girare una carta! Quale?: ');
                                                                   textcolor(white);
                                                                   readln(giro_carta2);
                                                                   textcolor(yellow);
                                                                 until (giro_carta2>0) and (giro_carta2<14);
                                                                   stato2[giro_carta2]:='c'
                                                                   end;

 axx:=0;
{---------------------------------------------------------------------------------------------------------------------------------------------}
{---------------------------------------------------------------------------------------------------------------------------------------------}
{---------------------------------------------------------------------------------------------------------------------------------------------}
{---------------------------------------------------------------------------------------------------------------------------------------------}





{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}
{questo riscrive la stessa schermata che faceva all'inizio del repeat. Ma serve perchè se no non verrebbe refreshata}
{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}
clrscr;
textcolor(white);
lungh1:=length(name1);
for i:=1 to lungh1+17 do write(chr(219));
writeln(chr(219));
write(chr(219));
textcolor(lightmagenta);
write(' Giocatore 1 : ',name1,' ');
textcolor(white);
write(chr(219));
if length(name2)>length(name1) then for i:=1 to length(name2)-length(name1) do write(' ');
write('   Carte pescate: ');
textcolor(cyan);
for i:=1 to 15 do begin
                          textcolor(lightred);
                          if stato1[i]='c' then textcolor(cyan)
                             else textcolor(lightred);
                          if (mano1[i]<>0) and (stato1[i]<>'c') then write(' ',mano1[i]:1:1);
                          if stato1[i]='c' then begin
                                                     textcolor(cyan);
                                                     write(' ?');
                                                end;
                          textcolor(lightred);
                     end;


writeln;
textcolor(white);
for i:=1 to lungh1+17 do write(chr(219));
writeln(chr(219));
writeln;




textcolor(white);
lungh2:=length(name2);
for i:=1 to lungh2+17 do write(chr(219));
writeln(chr(219));
write(chr(219));
textcolor(lightgreen);
write(' Giocatore 2 : ',name2,' ');
textcolor(white);
write(chr(219));
if length(name1)>length(name2) then for i:=1 to length(name1)-length(name2) do write(' ');
write('   Carte pescate: ');
textcolor(cyan);

for i:=1 to 15 do begin
                          textcolor(lightred);
                          if stato2[i]='c' then textcolor(cyan)
                             else textcolor(lightred);
                          if mano2[i]<>0 then write(' ',mano2[i]:1:1);
                          textcolor(lightred);
                     end;


textcolor(white);
writeln;
for i:=1 to lungh2+17 do write(chr(219));
writeln(chr(219));
writeln;
textcolor(yellow);

writeln;
textcolor(yellow);
write('Hai totalizzato: ');
textcolor(white);
writeln(p2+c2:1:1);

readln;
{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}



player2ok:=true;

end; {fine player 1 e poi il 2}

















{-------------------------------------------------------------------------------------------------------}
{-------------------------------------------------------------------------------------------------------}
{-----------------------------------Prima player 2 e poi il 1-------------------------------------------}
{-------------------------------------------------------------------------------------------------------}
{-------------------------------------------------------------------------------------------------------}
if player<>0 then begin

{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}
{PLAYER 2 PLAYER 2 PLAYER 2 PLAYER 2 PLAYER 2 PLAYER 2 PLAYER 2 PLAYER 2 PLAYER 2 PLAYER 2 PLAYER 2 PLAYER 2 PLAYER 2}
{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}

clrscr;

repeat
textcolor(12);
str:='Giocatore 2, Ora tocca a te! Premi un tasto per iniziare';
gotoxy((80-length(str)) div 2,10);
writeln(str);
delay(300);
clrscr;
textcolor(14);
str:='Giocatore 2, Ora tocca a te! Premi un tasto per iniziare';
gotoxy((80-length(str)) div 2,10);
writeln(str);
delay(300);
clrscr;
textcolor(10);
str:='Giocatore 2, Ora tocca a te! Premi un tasto per iniziare';
gotoxy((80-length(str)) div 2,10);
writeln(str);
delay(300);
clrscr;
until keypressed;

textcolor(lightmagenta);
str:='Giocatore 2! Premi un tasto per iniziare';
gotoxy((80-length(str)) div 2,10);
writeln(str);
readln;
textcolor(yellow);

repeat

if (player2ok=false) then begin

clrscr;
textcolor(white);
lungh1:=length(name1);
for i:=1 to lungh1+17 do write(chr(219));
writeln(chr(219));
write(chr(219));
textcolor(lightmagenta);
write(' Giocatore 1 : ',name1,' ');
textcolor(white);
write(chr(219));
if length(name2)>length(name1) then for i:=1 to length(name2)-length(name1) do write(' ');
write('   Carte pescate: ');
textcolor(cyan);
for i:=1 to 15 do begin
                          textcolor(lightred);
                          if stato1[i]='c' then textcolor(cyan)
                             else textcolor(lightred);
                          if (mano1[i]<>0) and (stato1[i]<>'c') then write(' ',mano1[i]:1:1);
                          if stato1[i]='c' then begin
                                                     textcolor(cyan);
                                                     write(' ?');
                                                end;
                          textcolor(lightred);
                     end;


writeln;
textcolor(white);
for i:=1 to lungh1+17 do write(chr(219));
writeln(chr(219));
writeln;




textcolor(white);
lungh2:=length(name2);
for i:=1 to lungh2+17 do write(chr(219));
writeln(chr(219));
write(chr(219));
textcolor(lightgreen);
write(' Giocatore 2 : ',name2,' ');
textcolor(white);
write(chr(219));
if length(name1)>length(name2) then for i:=1 to length(name1)-length(name2) do write(' ');
write('   Carte pescate: ');
textcolor(cyan);

for i:=1 to 15 do begin
                          textcolor(lightred);
                          if stato2[i]='c' then textcolor(cyan)
                             else textcolor(lightred);
                          if mano2[i]<>0 then write(' ',mano2[i]:1:1);
                          textcolor(lightred);
                     end;


textcolor(white);
writeln;
for i:=1 to lungh2+17 do write(chr(219));
writeln(chr(219));
writeln;
textcolor(yellow);

writeln;
textcolor(lightgreen);
write(name2,' ');
textcolor(yellow);
write('vuoi pescare una carta? Premi ');
textcolor(white);
write('"s" ');
textcolor(yellow);
write('per confermare: ');
textcolor(lightmagenta);
readln(pescaX);
textcolor(yellow);

if pescaX='S' then pescaX:='s';
if pescaX='s' then begin
 if (coperta2=false) then pesca:='c'
   else pesca:='s';


  if (pesca='s') and (giro2=1) then begin
                  caricaS2;
                  pesca:='';
                  repeat
                        carte2[2]:=random(39)+1;
                  until (carte2[2]<>carte2[1]) and (carte2[2]<>carte1[1]) and (carte2[2]<>carte1[2]) and (carte2[2]<>carte1[3]) and (carte2[2]<>carte1[4]) and (carte2[2]<>carte1[5]) and (carte2[2]<>carte1[6]) and (carte2[2]<>carte1[7]) and (carte2[2]<>carte1[8]) and (carte2[2]<>carte1[9]) and (carte2[2]<>carte1[10]) and (carte2[2]<>carte1[11]) and (carte2[2]<>carte1[12]) and (carte2[2]<>carte1[13]);
                  giro2:=2;
                  assegnaz2;
                  end;



  if (pesca='s') and (giro2=2) then begin
                  caricaS2;
                  pesca:='';
                  repeat
                        carte2[3]:=random(39)+1;
                  until (carte2[3]<>carte2[1]) and (carte2[3]<>carte2[2]) and (carte2[3]<>carte1[1]) and (carte2[3]<>carte1[2]) and (carte2[3]<>carte1[3]) and (carte2[3]<>carte1[4]) and (carte2[3]<>carte1[5]) and (carte2[3]<>carte1[6]) and (carte2[3]<>carte1[7]) and (carte2[3]<>carte1[8]) and (carte2[3]<>carte1[9]) and (carte2[3]<>carte1[10]) and (carte2[3]<>carte1[11]) and (carte2[3]<>carte1[12]) and (carte2[3]<>carte1[13]);
                  giro2:=3;
                  assegnaz2;
                  end;


  if (pesca='s') and (giro2=3) then begin
                  caricaS2;
                  pesca:='';
                  repeat
                        carte2[4]:=random(39)+1;
                  until (carte2[4]<>carte2[1]) and (carte2[4]<>carte2[2]) and (carte2[4]<>carte2[3]) and (carte2[4]<>carte1[1]) and (carte2[4]<>carte1[2]) and (carte2[4]<>carte1[3]) and (carte2[4]<>carte1[4]) and (carte2[4]<>carte1[5]) and (carte2[4]<>carte1[6]) and (carte2[4]<>carte1[7]) and (carte2[4]<>carte1[8]) and (carte2[4]<>carte1[9]) and (carte2[4]<>carte1[10]) and (carte2[4]<>carte1[11]) and (carte2[4]<>carte1[12]) and (carte2[4]<>carte1[13]);
                  giro2:=4;
                  assegnaz2;
                  end;


  if (pesca='s') and (giro2=4) then begin
                  caricaS2;
                  pesca:='';
                  repeat
                        carte2[5]:=random(39)+1;
                  until (carte2[5]<>carte2[1]) and (carte2[5]<>carte2[2]) and (carte2[5]<>carte2[3]) and (carte2[5]<>carte2[4]) and (carte2[5]<>carte1[1]) and (carte2[5]<>carte1[2]) and (carte2[5]<>carte1[3]) and (carte2[5]<>carte1[4]) and (carte2[5]<>carte1[5]) and (carte2[5]<>carte1[6]) and (carte2[5]<>carte1[7]) and (carte2[5]<>carte1[8]) and (carte2[5]<>carte1[9]) and (carte2[5]<>carte1[10]) and (carte2[5]<>carte1[11]) and (carte2[5]<>carte1[12]) and (carte2[5]<>carte1[13]);
                  giro2:=5;
                  assegnaz2;
                  end;

  if (pesca='s') and (giro2=5) then begin
                  caricaS2;
                  pesca:='';
                  repeat
                        carte2[6]:=random(39)+1;
                  until (carte2[6]<>carte2[1]) and (carte2[6]<>carte2[2]) and (carte2[6]<>carte2[3]) and (carte2[6]<>carte2[4]) and (carte2[6]<>carte2[5]) and (carte2[6]<>carte1[1]) and (carte2[6]<>carte1[2]) and (carte2[6]<>carte1[3]) and (carte2[6]<>carte1[4]) and (carte2[6]<>carte1[5]) and (carte2[6]<>carte1[6]) and (carte2[6]<>carte1[7]) and (carte2[6]<>carte1[8]) and (carte2[6]<>carte1[9]) and (carte2[6]<>carte1[10]) and (carte2[6]<>carte1[11]) and (carte2[6]<>carte1[12]) and (carte2[6]<>carte1[13]);
                  giro2:=6;
                  assegnaz2;
                  end;

  if (pesca='s') and (giro2=6) then begin
                  caricaS2;
                  pesca:='';
                  repeat
                        carte2[7]:=random(39)+1;
                  until (carte2[7]<>carte2[1]) and (carte2[7]<>carte2[2]) and (carte2[7]<>carte2[3]) and (carte2[7]<>carte2[4]) and (carte2[7]<>carte2[5]) and (carte2[7]<>carte2[6]) and (carte2[7]<>carte1[1]) and (carte2[7]<>carte1[2]) and (carte2[7]<>carte1[3]) and (carte2[7]<>carte1[4]) and (carte2[7]<>carte1[5]) and (carte2[7]<>carte1[6]) and (carte2[7]<>carte1[7]) and (carte2[7]<>carte1[8]) and (carte2[7]<>carte1[9]) and (carte2[7]<>carte1[10]) and (carte2[7]<>carte1[11]) and (carte2[7]<>carte1[12]) and (carte2[7]<>carte1[13]);
                  giro2:=7;
                  assegnaz2;
                  end;


  if (pesca='s') and (giro2=7) then begin
                  caricaS2;
                  pesca:='';
                  repeat
                        carte2[8]:=random(39)+1;
                  until (carte2[8]<>carte2[1]) and (carte2[8]<>carte2[2]) and (carte2[8]<>carte2[3]) and (carte2[8]<>carte2[4]) and (carte2[8]<>carte2[5]) and (carte2[8]<>carte2[6]) and (carte2[8]<>carte2[7]) and (carte2[8]<>carte1[1]) and (carte2[8]<>carte1[2]) and (carte2[8]<>carte1[3]) and (carte2[8]<>carte1[4]) and (carte2[8]<>carte1[5]) and (carte2[8]<>carte1[6]) and (carte2[8]<>carte1[7]) and (carte2[8]<>carte1[8]) and (carte2[8]<>carte1[9]) and (carte2[8]<>carte1[10]) and (carte2[8]<>carte1[11]) and (carte2[8]<>carte1[12]) and (carte2[8]<>carte1[13]);
                  giro2:=8;
                  assegnaz2;
                  end;


  if (pesca='s') and (giro2=8) then begin
                  caricaS2;
                  pesca:='';
                  repeat
                        carte2[9]:=random(39)+1;
                  until (carte2[9]<>carte2[1]) and (carte2[9]<>carte2[2]) and (carte2[9]<>carte2[3]) and (carte2[9]<>carte2[4]) and (carte2[9]<>carte2[5]) and (carte2[9]<>carte2[6]) and (carte2[9]<>carte2[7]) and (carte2[9]<>carte2[8]) and (carte2[9]<>carte1[1]) and (carte2[9]<>carte1[2]) and (carte2[9]<>carte1[3]) and (carte2[9]<>carte1[4]) and (carte2[9]<>carte1[5]) and (carte2[9]<>carte1[6]) and (carte2[9]<>carte1[7]) and (carte2[9]<>carte1[8]) and (carte2[9]<>carte1[9]) and (carte2[9]<>carte1[10]) and (carte2[9]<>carte1[11]) and (carte2[9]<>carte1[12]) and (carte2[9]<>carte1[13]);
                  giro2:=9;
                  assegnaz2;
                  end;

  if (pesca='s') and (giro2=9) then begin
                  caricaS2;
                  pesca:='';
                  repeat
                        carte2[10]:=random(39)+1;
                  until (carte2[10]<>carte2[1]) and (carte2[10]<>carte2[2]) and (carte2[10]<>carte2[3]) and (carte2[10]<>carte2[4]) and (carte2[10]<>carte2[5]) and (carte2[10]<>carte2[6]) and (carte2[10]<>carte2[7]) and (carte2[10]<>carte2[8]) and (carte2[10]<>carte2[9]) and (carte2[10]<>carte1[1]) and (carte2[10]<>carte1[2]) and (carte2[10]<>carte1[3]) and (carte2[10]<>carte1[4]) and (carte2[10]<>carte1[5]) and (carte2[10]<>carte1[6]) and (carte2[10]<>carte1[7]) and (carte2[10]<>carte1[8]) and (carte2[10]<>carte1[9]) and (carte2[10]<>carte1[10]) and (carte2[10]<>carte1[11]) and (carte2[10]<>carte1[12]) and (carte2[10]<>carte1[13]);
                  giro2:=10;
                  assegnaz2;
                  end;

  if (pesca='s') and (giro2=10) then begin
                  caricaS2;
                  pesca:='';
                  repeat
                        carte2[11]:=random(39)+1;
                  until (carte2[11]<>carte2[1]) and (carte2[11]<>carte2[2]) and (carte2[11]<>carte2[3]) and (carte2[11]<>carte2[4]) and (carte2[11]<>carte2[5]) and (carte2[11]<>carte2[6]) and (carte2[11]<>carte2[7]) and (carte2[11]<>carte2[8]) and (carte2[11]<>carte2[9]) and (carte2[11]<>carte2[10]) and (carte2[11]<>carte1[1]) and (carte2[11]<>carte1[2]) and (carte2[11]<>carte1[3]) and (carte2[11]<>carte1[4]) and (carte2[11]<>carte1[5]) and (carte2[11]<>carte1[6]) and (carte2[11]<>carte1[7]) and (carte2[11]<>carte1[8]) and (carte2[11]<>carte1[9]) and (carte2[11]<>carte1[10]) and (carte2[11]<>carte1[11]) and (carte2[11]<>carte1[12]) and (carte2[11]<>carte1[13]);
                  giro2:=11;
                  assegnaz2;
                  end;


  if (pesca='s') and (giro2=11) then begin
                  caricaS2;
                  pesca:='';
                  repeat
                        carte2[12]:=random(39)+1;
                  until (carte2[12]<>carte2[1]) and (carte2[12]<>carte2[2]) and (carte2[13]<>carte2[3]) and (carte2[13]<>carte2[4]) and (carte2[13]<>carte2[5]) and (carte2[13]<>carte2[6]) and (carte2[12]<>carte2[7]) and (carte2[12]<>carte2[8]) and (carte2[12]<>carte2[9]) and (carte2[12]<>carte2[10]) and (carte2[12]<>carte2[11]) and (carte2[12]<>carte1[1]) and (carte2[12]<>carte1[2]) and (carte2[12]<>carte1[3]) and (carte2[12]<>carte1[4]) and (carte2[12]<>carte1[5]) and (carte2[12]<>carte1[6]) and (carte2[12]<>carte1[7]) and (carte2[12]<>carte1[8]) and (carte2[12]<>carte1[9]) and (carte2[12]<>carte1[10]) and (carte2[12]<>carte1[11]) and (carte2[12]<>carte1[12]) and (carte2[12]<>carte1[13]);
                  giro2:=12;
                  assegnaz2;
                  end;

  if (pesca='s') and (giro2=12) then begin
                  caricaS2;
                  pesca:='';
                  repeat
                        carte2[13]:=random(39)+1;
                  until (carte2[13]<>carte2[1]) and (carte2[13]<>carte2[2]) and (carte2[13]<>carte2[3]) and (carte2[13]<>carte2[4]) and (carte2[13]<>carte2[5]) and (carte2[13]<>carte2[6]) and (carte2[13]<>carte2[7]) and (carte2[13]<>carte2[8]) and (carte2[13]<>carte2[9]) and (carte2[13]<>carte2[10]) and (carte2[13]<>carte2[11]) and (carte2[13]<>carte2[12]) and (carte2[13]<>carte1[1]) and (carte2[13]<>carte1[2]) and (carte2[13]<>carte1[3]) and (carte2[13]<>carte1[4]) and (carte2[13]<>carte1[5]) and (carte2[13]<>carte1[6]) and (carte2[13]<>carte1[7]) and (carte2[13]<>carte1[8]) and (carte2[13]<>carte1[9]) and (carte2[13]<>carte1[10]) and (carte2[13]<>carte1[11]) and (carte2[13]<>carte1[12]) and (carte2[13]<>carte1[13]);
                  giro2:=13;
                  assegnaz2;
                  end;
             end;


  {carte coperte}
   if (pesca='c') and (giro2=1) then begin
                  caricaC2;
                  pesca:='';
                  repeat
                        carte2[2]:=random(39)+1;
                  until (carte2[2]<>carte2[1]) and (carte2[2]<>carte1[1]) and (carte2[2]<>carte1[2]) and (carte2[2]<>carte1[3]) and (carte2[2]<>carte1[4]) and (carte2[2]<>carte1[5]) and (carte2[2]<>carte1[6]) and (carte2[2]<>carte1[7]) and (carte2[2]<>carte1[8]) and (carte2[2]<>carte1[9]) and (carte2[2]<>carte1[10]) and (carte2[2]<>carte1[11]) and (carte2[2]<>carte1[12]) and (carte2[2]<>carte1[13]);
                  giro2:=2;
                  assegnazc2;
                  end;



  if (pesca='c') and (giro2=2) then begin
                  caricaC2;
                  pesca:='';
                  repeat
                        carte2[3]:=random(39)+1;
                  until (carte2[3]<>carte2[1]) and (carte2[3]<>carte2[2]) and (carte2[3]<>carte1[1]) and (carte2[3]<>carte1[2]) and (carte2[3]<>carte1[3]) and (carte2[3]<>carte1[4]) and (carte2[3]<>carte1[5]) and (carte2[3]<>carte1[6]) and (carte2[3]<>carte1[7]) and (carte2[3]<>carte1[8]) and (carte2[3]<>carte1[9]) and (carte2[3]<>carte1[10]) and (carte2[3]<>carte1[11]) and (carte2[3]<>carte1[12]) and (carte2[3]<>carte1[13]);
                  giro2:=3;
                  assegnazc2;
                  end;


  if (pesca='c') and (giro2=3) then begin
                  caricaC2;
                  pesca:='';
                  repeat
                        carte2[4]:=random(39)+1;
                  until (carte2[4]<>carte2[1]) and (carte2[4]<>carte2[2]) and (carte2[4]<>carte2[3]) and (carte2[4]<>carte1[1]) and (carte2[4]<>carte1[2]) and (carte2[4]<>carte1[3]) and (carte2[4]<>carte1[4]) and (carte2[4]<>carte1[5]) and (carte2[4]<>carte1[6]) and (carte2[4]<>carte1[7]) and (carte2[4]<>carte1[8]) and (carte2[4]<>carte1[9]) and (carte2[4]<>carte1[10]) and (carte2[4]<>carte1[11]) and (carte2[4]<>carte1[12]) and (carte2[4]<>carte1[13]);
                  giro2:=4;
                  assegnazc2;
                  end;


  if (pesca='c') and (giro2=4) then begin
                  caricaC2;
                  pesca:='';
                  repeat
                        carte2[5]:=random(39)+1;
                  until (carte2[5]<>carte2[1]) and (carte2[5]<>carte2[2]) and (carte2[5]<>carte2[3]) and (carte2[5]<>carte2[4]) and (carte2[5]<>carte1[1]) and (carte2[5]<>carte1[2]) and (carte2[5]<>carte1[3]) and (carte2[5]<>carte1[4]) and (carte2[5]<>carte1[5]) and (carte2[5]<>carte1[6]) and (carte2[5]<>carte1[7]) and (carte2[5]<>carte1[8]) and (carte2[5]<>carte1[9]) and (carte2[5]<>carte1[10]) and (carte2[5]<>carte1[11]) and (carte2[5]<>carte1[12]) and (carte2[5]<>carte1[13]);
                  giro2:=5;
                  assegnazc2;
                  end;

  if (pesca='c') and (giro2=5) then begin
                  caricaC2;
                  pesca:='';
                  repeat
                        carte2[6]:=random(39)+1;
                  until (carte2[6]<>carte2[1]) and (carte2[6]<>carte2[2]) and (carte2[6]<>carte2[3]) and (carte2[6]<>carte2[4]) and (carte2[6]<>carte2[5]) and (carte2[6]<>carte1[1]) and (carte2[6]<>carte1[2]) and (carte2[6]<>carte1[3]) and (carte2[6]<>carte1[4]) and (carte2[6]<>carte1[5]) and (carte2[6]<>carte1[6]) and (carte2[6]<>carte1[7]) and (carte2[6]<>carte1[8]) and (carte2[6]<>carte1[9]) and (carte2[6]<>carte1[10]) and (carte2[6]<>carte1[11]) and (carte2[6]<>carte1[12]) and (carte2[6]<>carte1[13]);
                  giro2:=6;
                  assegnazc2;
                  end;

  if (pesca='c') and (giro2=6) then begin
                  caricaC2;
                  pesca:='';
                  repeat
                        carte2[7]:=random(39)+1;
                  until (carte2[7]<>carte2[1]) and (carte2[7]<>carte2[2]) and (carte2[7]<>carte2[3]) and (carte2[7]<>carte2[4]) and (carte2[7]<>carte2[5]) and (carte2[7]<>carte2[6]) and (carte2[7]<>carte1[1]) and (carte2[7]<>carte1[2]) and (carte2[7]<>carte1[3]) and (carte2[7]<>carte1[4]) and (carte2[7]<>carte1[5]) and (carte2[7]<>carte1[6]) and (carte2[7]<>carte1[7]) and (carte2[7]<>carte1[8]) and (carte2[7]<>carte1[9]) and (carte2[7]<>carte1[10]) and (carte2[7]<>carte1[11]) and (carte2[7]<>carte1[12]) and (carte2[7]<>carte1[13]);
                  giro2:=7;
                  assegnazc2;
                  end;


  if (pesca='c') and (giro2=7) then begin
                  caricaC2;
                  pesca:='';
                  repeat
                        carte2[8]:=random(39)+1;
                  until (carte2[8]<>carte2[1]) and (carte2[8]<>carte2[2]) and (carte2[8]<>carte2[3]) and (carte2[8]<>carte2[4]) and (carte2[8]<>carte2[5]) and (carte2[8]<>carte2[6]) and (carte2[8]<>carte2[7]) and (carte2[8]<>carte1[1]) and (carte2[8]<>carte1[2]) and (carte2[8]<>carte1[3]) and (carte2[8]<>carte1[4]) and (carte2[8]<>carte1[5]) and (carte2[8]<>carte1[6]) and (carte2[8]<>carte1[7]) and (carte2[8]<>carte1[8]) and (carte2[8]<>carte1[9]) and (carte2[8]<>carte1[10]) and (carte2[8]<>carte1[11]) and (carte2[8]<>carte1[12]) and (carte2[8]<>carte1[13]);
                  giro2:=8;
                  assegnazc2;
                  end;


  if (pesca='c') and (giro2=8) then begin
                  caricaC2;
                  pesca:='';
                  repeat
                        carte2[9]:=random(39)+1;
                  until (carte2[9]<>carte2[1]) and (carte2[9]<>carte2[2]) and (carte2[9]<>carte2[3]) and (carte2[9]<>carte2[4]) and (carte2[9]<>carte2[5]) and (carte2[9]<>carte2[6]) and (carte2[9]<>carte2[7]) and (carte2[9]<>carte2[8]) and (carte2[9]<>carte1[1]) and (carte2[9]<>carte1[2]) and (carte2[9]<>carte1[3]) and (carte2[9]<>carte1[4]) and (carte2[9]<>carte1[5]) and (carte2[9]<>carte1[6]) and (carte2[9]<>carte1[7]) and (carte2[9]<>carte1[8]) and (carte2[9]<>carte1[9]) and (carte2[9]<>carte1[10]) and (carte2[9]<>carte1[11]) and (carte2[9]<>carte1[12]) and (carte2[9]<>carte1[13]);
                  giro2:=9;
                  assegnazc2;
                  end;

  if (pesca='c') and (giro2=9) then begin
                  caricaC2;
                  pesca:='';
                  repeat
                        carte2[10]:=random(39)+1;
                  until (carte2[10]<>carte2[1]) and (carte2[10]<>carte2[2]) and (carte2[10]<>carte2[3]) and (carte2[10]<>carte2[4]) and (carte2[10]<>carte2[5]) and (carte2[10]<>carte2[6]) and (carte2[10]<>carte2[7]) and (carte2[10]<>carte2[8]) and (carte2[10]<>carte2[9]) and (carte2[10]<>carte1[1]) and (carte2[10]<>carte1[2]) and (carte2[10]<>carte1[3]) and (carte2[10]<>carte1[4]) and (carte2[10]<>carte1[5]) and (carte2[10]<>carte1[6]) and (carte2[10]<>carte1[7]) and (carte2[10]<>carte1[8]) and (carte2[10]<>carte1[9]) and (carte2[10]<>carte1[10]) and (carte2[10]<>carte1[11]) and (carte2[10]<>carte1[12]) and (carte2[10]<>carte1[13]);
                  giro2:=10;
                  assegnazc2;
                  end;

  if (pesca='c') and (giro2=10) then begin
                  caricaC2;
                  pesca:='';
                  repeat
                        carte2[11]:=random(39)+1;
                  until (carte2[11]<>carte2[1]) and (carte2[11]<>carte2[2]) and (carte2[11]<>carte2[3]) and (carte2[11]<>carte2[4]) and (carte2[11]<>carte2[5]) and (carte2[11]<>carte2[6]) and (carte2[11]<>carte2[7]) and (carte2[11]<>carte2[8]) and (carte2[11]<>carte2[9]) and (carte2[11]<>carte2[10]) and (carte2[11]<>carte1[1]) and (carte2[11]<>carte1[2]) and (carte2[11]<>carte1[3]) and (carte2[11]<>carte1[4]) and (carte2[11]<>carte1[5]) and (carte2[11]<>carte1[6]) and (carte2[11]<>carte1[7]) and (carte2[11]<>carte1[8]) and (carte2[11]<>carte1[9]) and (carte2[11]<>carte1[10]) and (carte2[11]<>carte1[11]) and (carte2[11]<>carte1[12]) and (carte2[11]<>carte1[13]);
                  giro2:=11;
                  assegnazc2;
                  end;

  if (pesca='c') and (giro2=11) then begin
                  caricaC2;
                  pesca:='';
                  repeat
                        carte2[12]:=random(39)+1;
                  until (carte2[12]<>carte2[1]) and (carte2[12]<>carte2[2]) and (carte2[13]<>carte2[3]) and (carte2[13]<>carte2[4]) and (carte2[13]<>carte2[5]) and (carte2[13]<>carte2[6]) and (carte2[12]<>carte2[7]) and (carte2[12]<>carte2[8]) and (carte2[12]<>carte2[9]) and (carte2[12]<>carte2[10]) and (carte2[12]<>carte2[11]) and (carte2[12]<>carte1[1]) and (carte2[12]<>carte1[2]) and (carte2[12]<>carte1[3]) and (carte2[12]<>carte1[4]) and (carte2[12]<>carte1[5]) and (carte2[12]<>carte1[6]) and (carte2[12]<>carte1[7]) and (carte2[12]<>carte1[8]) and (carte2[12]<>carte1[9]) and (carte2[12]<>carte1[10]) and (carte2[12]<>carte1[11]) and (carte2[12]<>carte1[12]) and (carte2[12]<>carte1[13]);
                  giro2:=12;
                  assegnazc2;
                  end;

  if (pesca='c') and (giro2=12) then begin
                  caricaC2;
                  pesca:='';
                  repeat
                        carte2[13]:=random(39)+1;
                  until (carte2[13]<>carte2[1]) and (carte2[13]<>carte2[2]) and (carte2[13]<>carte2[3]) and (carte2[13]<>carte2[4]) and (carte2[13]<>carte2[5]) and (carte2[13]<>carte2[6]) and (carte2[13]<>carte2[7]) and (carte2[13]<>carte2[8]) and (carte2[13]<>carte2[9]) and (carte2[13]<>carte2[10]) and (carte2[13]<>carte2[11]) and (carte2[13]<>carte2[12]) and (carte2[13]<>carte1[1]) and (carte2[13]<>carte1[2]) and (carte2[13]<>carte1[3]) and (carte2[13]<>carte1[4]) and (carte2[13]<>carte1[5]) and (carte2[13]<>carte1[6]) and (carte2[13]<>carte1[7]) and (carte2[13]<>carte1[8]) and (carte2[13]<>carte1[9]) and (carte2[13]<>carte1[10]) and (carte2[13]<>carte1[11]) and (carte2[13]<>carte1[12]) and (carte2[13]<>carte1[13]);
                  giro2:=13;
                  assegnazc2;
                  end;

 if pesca ='c' then coperta2:=true;
                  end; {questo end chiude l'if che ho messo subito all'inizio del repeat}


   if pesca='s' then stato2[giro2]:='s';

   if pesca='c' then stato2[giro2]:='c';
    writeln;
if (p2+c2<7.5) and (pescaX='s') then begin
   textcolor(lightgreen);
   write(name2,' ');
   textcolor(yellow);
   write('vuoi girare la carta coperta [s]?');
   textcolor(white);
   readln(girare2);
   if (girare2='s') or (girare2='S') then begin
                                             for i:=1 to 15 do if stato2[i]='c' then stato2[i]:='s';
                                             coperta2:=false;
                                        end;
                                     end;
   textcolor(yellow);
   writeln;
   writeln;

   for i:=giro2 to 15 do if carte2[i]<>0 then mano2[i]:=temp2;
   for i:=1 to 15 do if mano2[i]<>0 then write(' ',mano2[i]:1:1);

   controllo_bug6_e_risoluzione2    {molto importante, senza questa si crea un difetto che crea anche il bug delle carte coperte multiple}



until (p2+c2=7.5) or (p2+c2>7.5) or (pescaX='n');



{---------------------------------------------------------------------------------------------------------------------------------------------}
{---------------------------------------------------------------------------------------------------------------------------------------------}
{------------------------------Questo fa lo stesso di sopra con una aggiunta sotto per rigirare carte-----------------------------------------}
{---------------------------------------------------------------------------------------------------------------------------------------------}
{---------------------------------------------------------------------------------------------------------------------------------------------}

clrscr;
textcolor(white);
lungh1:=length(name1);
for i:=1 to lungh1+17 do write(chr(219));
writeln(chr(219));
write(chr(219));
textcolor(lightmagenta);
write(' Giocatore 1 : ',name1,' ');
textcolor(white);
write(chr(219));
if length(name2)>length(name1) then for i:=1 to length(name2)-length(name1) do write(' ');
write('   Carte pescate: ');
textcolor(cyan);
for i:=1 to 15 do begin
                          textcolor(lightred);
                          if stato1[i]='c' then textcolor(cyan)
                             else textcolor(lightred);
                          if (mano1[i]<>0) and (stato1[i]<>'c') then write(' ',mano1[i]:1:1);
                          if stato1[i]='c' then begin
                                                     textcolor(cyan);
                                                     write(' ?');
                                                end;
                          textcolor(lightred);
                     end;


writeln;
textcolor(white);
for i:=1 to lungh1+17 do write(chr(219));
writeln(chr(219));
writeln;




textcolor(white);
lungh2:=length(name2);
for i:=1 to lungh2+17 do write(chr(219));
writeln(chr(219));
write(chr(219));
textcolor(lightgreen);
write(' Giocatore 2 : ',name2,' ');
textcolor(white);
write(chr(219));
if length(name1)>length(name2) then for i:=1 to length(name1)-length(name2) do write(' ');
write('   Carte pescate: ');
textcolor(cyan);

for i:=1 to 15 do begin
                          textcolor(lightred);
                          if stato2[i]='c' then textcolor(cyan)
                             else textcolor(lightred);
                          if mano2[i]<>0 then write(' ',mano2[i]:1:1);
                          textcolor(lightred);
                     end;


textcolor(white);
writeln;
for i:=1 to lungh2+17 do write(chr(219));
writeln(chr(219));
writeln;


if p2+c2>=7.5 then pescaX:='n';


{IMPORTANTE!!!! Questo ciclo permette di gigare una carta se non se ne hanno coperte, in modo che il gicoatore dopo ne veda sempre una col "?"}
for i:=1 to 15 do if (stato2[i]='c') and (pescaX='n') then axx:=axx+1;
                                                    if axx=0 then begin
                                                                 repeat
                                                                   textcolor(lightred);
                                                                   writeln;
                                                                   write('Devi girare una carta! Quale?: ');
                                                                   textcolor(white);
                                                                   readln(giro_carta2);
                                                                   textcolor(yellow);
                                                                 until (giro_carta2>0) and (giro_carta2<14);
                                                                   stato2[giro_carta2]:='c'
                                                                   end;

 axx:=0;
{---------------------------------------------------------------------------------------------------------------------------------------------}
{---------------------------------------------------------------------------------------------------------------------------------------------}
{---------------------------------------------------------------------------------------------------------------------------------------------}
{---------------------------------------------------------------------------------------------------------------------------------------------}





{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}
{questo riscrive la stessa schermata che faceva all'inizio del repeat. Ma serve perchè se no non verrebbe refreshata}
{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}
clrscr;
textcolor(white);
lungh1:=length(name1);
for i:=1 to lungh1+17 do write(chr(219));
writeln(chr(219));
write(chr(219));
textcolor(lightmagenta);
write(' Giocatore 1 : ',name1,' ');
textcolor(white);
write(chr(219));
if length(name2)>length(name1) then for i:=1 to length(name2)-length(name1) do write(' ');
write('   Carte pescate: ');
textcolor(cyan);
for i:=1 to 15 do begin
                          textcolor(lightred);
                          if stato1[i]='c' then textcolor(cyan)
                             else textcolor(lightred);
                          if (mano1[i]<>0) and (stato1[i]<>'c') then write(' ',mano1[i]:1:1);
                          if stato1[i]='c' then begin
                                                     textcolor(cyan);
                                                     write(' ?');
                                                end;
                          textcolor(lightred);
                     end;


writeln;
textcolor(white);
for i:=1 to lungh1+17 do write(chr(219));
writeln(chr(219));
writeln;




textcolor(white);
lungh2:=length(name2);
for i:=1 to lungh2+17 do write(chr(219));
writeln(chr(219));
write(chr(219));
textcolor(lightgreen);
write(' Giocatore 2 : ',name2,' ');
textcolor(white);
write(chr(219));
if length(name1)>length(name2) then for i:=1 to length(name1)-length(name2) do write(' ');
write('   Carte pescate: ');
textcolor(cyan);

for i:=1 to 15 do begin
                          textcolor(lightred);
                          if stato2[i]='c' then textcolor(cyan)
                             else textcolor(lightred);
                          if mano2[i]<>0 then write(' ',mano2[i]:1:1);
                          textcolor(lightred);
                     end;


textcolor(white);
writeln;
for i:=1 to lungh2+17 do write(chr(219));
writeln(chr(219));
writeln;
textcolor(yellow);

writeln;
textcolor(yellow);
write('Hai totalizzato: ');
textcolor(white);
writeln(p2+c2:1:1);

readln;

{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}



player2ok:=true;



repeat
textcolor(12);
str:='Giocatore 1, Ora tocca a te! Premi un tasto per iniziare';
gotoxy((80-length(str)) div 2,10);  {posiziona al centro nella 10 riga}
writeln(str);
delay(300);
clrscr;
textcolor(14);
str:='Giocatore 1, Ora tocca a te! Premi un tasto per iniziare';
gotoxy((80-length(str)) div 2,10);
writeln(str);
delay(300);
clrscr;
textcolor(10);
str:='Giocatore 1, Ora tocca a te! Premi un tasto per iniziare';
gotoxy((80-length(str)) div 2,10);
writeln(str);
delay(300);
clrscr;
until keypressed;

textcolor(lightmagenta);
str:='Giocatore 1! Premi un tasto per iniziare';
gotoxy((80-length(str)) div 2,10);
writeln(str);
readln;
textcolor(yellow);

repeat

{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}
{PLAYER 1 PLAYER 1 PLAYER 1 PLAYER 1 PLAYER 1 PLAYER 1 PLAYER 1 PLAYER 1 PLAYER 1 PLAYER 1 PLAYER 1 PLAYER 1 PLAYER 1}
{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}


if player1ok=false then begin     {questo mi assicura che ogni partita il giocatore 1 dopo aver giocato non possa più pescare altre carte, per sicurezza}
                                                          {questo sembra inutile ma mi permette di togliere uno strano bug che non saprei come eliminare se no}

clrscr;

textcolor(white);
lungh2:=length(name2);
for i:=1 to lungh2+17 do write(chr(219));
writeln(chr(219));
write(chr(219));
textcolor(lightgreen);
write(' Giocatore 2 : ',name2,' ');
textcolor(white);
write(chr(219));
if length(name1)>length(name2) then for i:=1 to length(name1)-length(name2) do write(' ');
write('   Carte pescate: ');
textcolor(cyan);
writeln('?');
textcolor(white);
for i:=1 to lungh2+17 do write(chr(219));
writeln(chr(219));
writeln;




textcolor(white);
lungh1:=length(name1);
for i:=1 to lungh1+17 do write(chr(219));
writeln(chr(219));
write(chr(219));
textcolor(lightmagenta);
write(' Giocatore 1 : ',name1,' ');
textcolor(white);
write(chr(219));
if length(name2)>length(name1) then for i:=1 to length(name2)-length(name1) do write(' ');
write('   Carte pescate: ');
textcolor(cyan);

for i:=1 to 15 do begin
                          textcolor(lightred);
                          if stato1[i]='c' then textcolor(cyan)
                             else textcolor(lightred);
                          if mano1[i]<>0 then write(' ',mano1[i]:1:1);
                          textcolor(lightred);
                     end;


textcolor(white);
writeln;
for i:=1 to lungh1+17 do write(chr(219));
writeln(chr(219));
writeln;



writeln;
textcolor(lightmagenta);
write(name1,' ');
textcolor(yellow);
write('vuoi pescare una carta? Premi ');
textcolor(white);
write('"s" ');
textcolor(yellow);
write('per confermare: ');
textcolor(lightmagenta);
readln(pescaX);
textcolor(yellow);
if pescaX='S' then pescaX:='s';
if pescaX='s' then begin
 if (coperta1=false) then pesca:='c'
   else pesca:='s';


  if (pesca='s') and (giro1=1) then begin
                  caricaS1;
                  pesca:='';
                  repeat
                        carte1[2]:=random(39)+1;
                  until (carte1[2]<>carte1[1]) and (carte1[2]<>carte2[1]);
                  giro1:=2;
                  assegnaz1;
                  end;


  if (pesca='s') and (giro1=2) then begin
                  caricaS1;
                  pesca:='';
                  repeat
                        carte1[3]:=random(39)+1;
                  until (carte1[3]<>carte1[1]) and (carte1[3]<>carte1[2]) and (carte1[3]<>carte2[1]);
                  giro1:=3;
                  assegnaz1;
                  end;


  if (pesca='s') and (giro1=3) then begin
                  caricaS1;
                  pesca:='';
                  repeat
                        carte1[4]:=random(39)+1;
                  until (carte1[4]<>carte1[1]) and (carte1[4]<>carte1[2]) and (carte1[4]<>carte1[3]) and (carte1[4]<>carte2[1]);
                  giro1:=4;
                  assegnaz1;
                  end;


  if (pesca='s') and (giro1=4) then begin
                  caricaS1;
                  pesca:='';
                  repeat
                        carte1[5]:=random(39)+1;
                  until (carte1[5]<>carte1[1]) and (carte1[5]<>carte1[2]) and (carte1[5]<>carte1[3]) and (carte1[5]<>carte1[4]) and (carte1[5]<>carte2[1]);
                  giro1:=5;
                  assegnaz1;
                  end;

  if (pesca='s') and (giro1=5) then begin
                 caricaS1;
                  pesca:='';
                  repeat
                        carte1[6]:=random(39)+1;
                  until (carte1[6]<>carte1[1]) and (carte1[6]<>carte1[2]) and (carte1[6]<>carte1[3]) and (carte1[6]<>carte1[4]) and (carte1[6]<>carte1[5]) and (carte1[6]<>carte2[1]);
                  giro1:=6;
                  assegnaz1;
                  end;

  if (pesca='s') and (giro1=6) then begin
                caricaS1;
                  pesca:='';
                  repeat
                        carte1[7]:=random(39)+1;
                  until (carte1[7]<>carte1[1]) and (carte1[7]<>carte1[2]) and (carte1[7]<>carte1[3]) and (carte1[7]<>carte1[4]) and (carte1[7]<>carte1[5]) and (carte1[7]<>carte1[6]) and (carte1[7]<>carte2[1]);
                  giro1:=7;
                  assegnaz1;
                  end;


  if (pesca='s') and (giro1=7) then begin
                     caricaS1;
                  pesca:='';
                  repeat
                        carte1[8]:=random(39)+1;
                  until (carte1[8]<>carte1[1]) and (carte1[8]<>carte1[2]) and (carte1[8]<>carte1[3]) and (carte1[8]<>carte1[4]) and (carte1[8]<>carte1[5]) and (carte1[8]<>carte1[6]) and (carte1[8]<>carte1[7]) and (carte1[8]<>carte2[1]);
                  giro1:=8;
                  assegnaz1;
                  end;


  if (pesca='s') and (giro1=8) then begin
                       caricaS1;
                  pesca:='';
                  repeat
                        carte1[9]:=random(39)+1;
                  until (carte1[9]<>carte1[1]) and (carte1[9]<>carte1[2]) and (carte1[9]<>carte1[3]) and (carte1[9]<>carte1[4]) and (carte1[9]<>carte1[5]) and (carte1[9]<>carte1[6]) and (carte1[9]<>carte1[7]) and (carte1[9]<>carte1[8]) and (carte1[9]<>carte2[1]);
                  giro1:=9;
                  assegnaz1;
                  end;

   if (pesca='s') and (giro1=9) then begin
                       caricaS1;
                  pesca:='';
                  repeat
                        carte1[10]:=random(39)+1;
                  until (carte1[10]<>carte1[1]) and (carte1[10]<>carte1[2]) and (carte1[10]<>carte1[3]) and (carte1[10]<>carte1[4]) and (carte1[10]<>carte1[5]) and (carte1[10]<>carte1[6]) and (carte1[10]<>carte1[7]) and (carte1[10]<>carte1[8]) and (carte1[10]<>carte1[9]) and (carte1[10]<>carte2[1]);
                  giro1:=10;
                  assegnaz1;
                  end;

  if (pesca='s') and (giro1=10) then begin
                     caricaS1;
                  pesca:='';
                  repeat
                        carte1[11]:=random(39)+1;
                  until (carte1[11]<>carte1[1]) and (carte1[11]<>carte1[2]) and (carte1[11]<>carte1[3]) and (carte1[11]<>carte1[4]) and (carte1[11]<>carte1[5]) and (carte1[11]<>carte1[6]) and (carte1[11]<>carte1[7]) and (carte1[11]<>carte1[8]) and (carte1[11]<>carte1[9]) and (carte1[11]<>carte1[10]) and (carte1[11]<>carte2[1]);
                  giro1:=11;
                  assegnaz1;
                  end;


  if (pesca='s') and (giro1=11) then begin
                            caricaS1;
                  pesca:='';
                  repeat
                        carte1[12]:=random(39)+1;
                  until (carte1[12]<>carte1[1]) and (carte1[12]<>carte1[2]) and (carte1[13]<>carte1[3]) and (carte1[13]<>carte1[4]) and (carte1[13]<>carte1[5]) and (carte1[13]<>carte1[6]) and (carte1[12]<>carte1[7]) and (carte1[12]<>carte1[8]) and (carte1[12]<>carte1[9]) and (carte1[12]<>carte1[10]) and (carte1[12]<>carte1[11]) and (carte1[12]<>carte2[1]);
                  giro1:=12;
                  assegnaz1;
                  end;

  if (pesca='s') and (giro1=12) then begin
                  caricaS1;
                  pesca:='';
                  repeat
                        carte1[13]:=random(39)+1;
                  until (carte1[13]<>carte1[1]) and (carte1[13]<>carte1[2]) and (carte1[13]<>carte1[3]) and (carte1[13]<>carte1[4]) and (carte1[13]<>carte1[5]) and (carte1[13]<>carte1[6]) and (carte1[13]<>carte1[7]) and (carte1[13]<>carte1[8]) and (carte1[13]<>carte1[9]) and (carte1[13]<>carte1[10]) and (carte1[13]<>carte1[11]) and (carte1[13]<>carte1[12]) and (carte1[13]<>carte2[1]);
                  giro1:=13;
                  assegnaz1;
                  end;

             end;


  {carte coperte}
  if (pesca='c') and (giro1=1) then begin
                  caricac1;
                  pesca:='';
                  repeat
                        carte1[2]:=random(39)+1;
                  until (carte1[2]<>carte1[1]) and (carte1[2]<>carte2[1]);
                  giro1:=2;
                  assegnazc1;
                  end;



  if (pesca='c') and (giro1=2) then begin
                  caricac1;
                  pesca:='';
                  repeat
                        carte1[3]:=random(39)+1;
                  until (carte1[3]<>carte1[2]) and (carte1[3]<>carte1[1]) and (carte1[3]<>carte2[1]);
                  giro1:=3;
                  assegnazc1;
                  end;


  if (pesca='c') and (giro1=3) then begin
                  caricac1;
                  pesca:='';
                  repeat
                        carte1[4]:=random(39)+1;
                  until (carte1[4]<>carte1[1]) and (carte1[4]<>carte1[2]) and (carte1[4]<>carte1[3]) and (carte1[4]<>carte2[1]);
                  giro1:=4;
                  assegnazc1;
                  end;


  if (pesca='c') and (giro1=4) then begin
                  caricac1;
                  pesca:='';
                  repeat
                        carte1[5]:=random(39)+1;
                  until (carte1[5]<>carte1[1]) and (carte1[5]<>carte1[2]) and (carte1[5]<>carte1[3]) and (carte1[5]<>carte1[4]) and (carte1[5]<>carte2[1]);
                  giro1:=5;
                  assegnazc1;
                  end;

  if (pesca='c') and (giro1=5) then begin
                  caricac1;
                  pesca:='';
                  repeat
                        carte1[6]:=random(39)+1;
                  until (carte1[6]<>carte1[1]) and (carte1[6]<>carte1[2]) and (carte1[6]<>carte1[3]) and (carte1[6]<>carte1[4]) and (carte1[6]<>carte1[5]) and (carte1[6]<>carte2[1]);
                  giro1:=6;
                  assegnazc1;
                  end;

  if (pesca='c') and (giro1=6) then begin
                  caricac1;
                  pesca:='';
                  repeat
                        carte1[7]:=random(39)+1;
                  until (carte1[7]<>carte1[1]) and (carte1[7]<>carte1[2]) and (carte1[7]<>carte1[3]) and (carte1[7]<>carte1[4]) and (carte1[7]<>carte1[5]) and (carte1[7]<>carte1[6]) and (carte1[7]<>carte2[1]);
                  giro1:=7;
                  assegnaz1;
                  end;


  if (pesca='c') and (giro1=7) then begin
                  caricac1;
                  pesca:='';
                  repeat
                        carte1[8]:=random(39)+1;
                  until (carte1[8]<>carte1[1]) and (carte1[8]<>carte1[2]) and (carte1[8]<>carte1[3]) and (carte1[8]<>carte1[4]) and (carte1[8]<>carte1[5]) and (carte1[8]<>carte1[6]) and (carte1[8]<>carte1[7]) and (carte1[8]<>carte2[1]);
                  giro1:=8;
                  assegnazc1;
                  end;


  if (pesca='c') and (giro1=8) then begin
                  caricac1;
                  pesca:='';
                  repeat
                        carte1[9]:=random(39)+1;
                  until (carte1[9]<>carte1[1]) and (carte1[9]<>carte1[2]) and (carte1[9]<>carte1[3]) and (carte1[9]<>carte1[4]) and (carte1[9]<>carte1[5]) and (carte1[9]<>carte1[6]) and (carte1[9]<>carte1[7]) and (carte1[9]<>carte1[8]) and (carte1[9]<>carte2[1]);
                  giro1:=9;
                  assegnazc1;
                  end;

  if (pesca='c') and (giro1=9) then begin
                  caricac1;
                  pesca:='';
                  repeat
                        carte1[10]:=random(39)+1;
                  until (carte1[10]<>carte1[1]) and (carte1[10]<>carte1[2]) and (carte1[10]<>carte1[3]) and (carte1[10]<>carte1[4]) and (carte1[10]<>carte1[5]) and (carte1[10]<>carte1[6]) and (carte1[10]<>carte1[7]) and (carte1[10]<>carte1[8]) and (carte1[10]<>carte1[9]) and (carte1[10]<>carte2[1]);
                  giro1:=10;
                  assegnazc1;
                  end;

  if (pesca='c') and (giro1=10) then begin
                 caricac1;
                  pesca:='';
                  repeat
                        carte1[11]:=random(39)+1;
                  until (carte1[11]<>carte1[1]) and (carte1[11]<>carte1[2]) and (carte1[11]<>carte1[3]) and (carte1[11]<>carte1[4]) and (carte1[11]<>carte1[5]) and (carte1[11]<>carte1[6]) and (carte1[11]<>carte1[7]) and (carte1[11]<>carte1[8]) and (carte1[11]<>carte1[9]) and (carte1[11]<>carte1[10]) and (carte1[11]<>carte2[1]);
                  giro1:=11;
                  assegnazc1;
                  end;


  if (pesca='c') and (giro1=11) then begin
                  caricac1;
                  pesca:='';
                  repeat
                        carte1[12]:=random(39)+1;
                  until (carte1[12]<>carte1[1]) and (carte1[12]<>carte1[2]) and (carte1[13]<>carte1[3]) and (carte1[13]<>carte1[4]) and (carte1[13]<>carte1[5]) and (carte1[13]<>carte1[6]) and (carte1[12]<>carte1[7]) and (carte1[12]<>carte1[8]) and (carte1[12]<>carte1[9]) and (carte1[12]<>carte1[10]) and (carte1[12]<>carte1[11]) and (carte1[12]<>carte2[1]);
                  giro1:=12;
                  assegnazc1;
                  end;

  if (pesca='c') and (giro1=12) then begin
                  caricac1;
                  pesca:='';
                  repeat
                        carte1[13]:=random(39)+1;
                  until (carte1[13]<>carte1[1]) and (carte1[13]<>carte1[2]) and (carte1[13]<>carte1[3]) and (carte1[13]<>carte1[4]) and (carte1[13]<>carte1[5]) and (carte1[13]<>carte1[6]) and (carte1[13]<>carte1[7]) and (carte1[13]<>carte1[8]) and (carte1[13]<>carte1[9]) and (carte1[13]<>carte1[10]) and (carte1[13]<>carte1[11]) and (carte1[13]<>carte1[12]) and (carte1[13]<>carte2[1]);
                  giro1:=13;
                  assegnazc1;
                  end;
 if pesca ='c' then coperta1:=true;
                  end; {questo end chiude l'if che ho messo subito all'inizio del repeat}



   if pesca='s' then stato1[giro1]:='s';

   if pesca='c' then stato1[giro1]:='c';

   writeln;


if (p1+c1<7.5) and (pescaX='s') then begin
   textcolor(lightmagenta);
   write(name1,' ');
   textcolor(yellow);
   write('vuoi girare la carta coperta [s]?');
   textcolor(white);
   readln(girare1);
   if (girare1='s') or (girare1='S') then begin
                                             for i:=1 to 15 do if stato1[i]='c' then stato1[i]:='s';
                                             coperta1:=false;
                                        end;
                                     end;
   textcolor(yellow);
   writeln;
   writeln;

   for i:=giro1 to 15 do if carte1[i]<>0 then mano1[i]:=temp1;
   for i:=1 to 15 do if mano1[i]<>0 then write(' ',mano1[i]:1:1);

   controllo_bug6_e_risoluzione1;  {molto importante, senza questa si crea un difetto che crea anche il bug delle carte coperte multiple}

until (p1+c1=7.5) or (p1+c1>7.5) or (pescaX='n');

player1ok:=true;               {dato che pleayer1 ormai ha finito il suo turno metto questa variabile a true, e solo se è false il giocatore può giocare}


{---------------------------------------------------------------------------------------------------------------------------------------------}
{---------------------------------------------------------------------------------------------------------------------------------------------}
{------------------------------Questo fa lo stesso di sopra con una aggiunta sotto per rigirare carte-----------------------------------------}
{---------------------------------------------------------------------------------------------------------------------------------------------}
{---------------------------------------------------------------------------------------------------------------------------------------------}


clrscr;

textcolor(white);
lungh2:=length(name2);
for i:=1 to lungh2+17 do write(chr(219));
writeln(chr(219));
write(chr(219));
textcolor(lightgreen);
write(' Giocatore 2 : ',name2,' ');
textcolor(white);
write(chr(219));
if length(name1)>length(name2) then for i:=1 to length(name1)-length(name2) do write(' ');
write('   Carte pescate: ');
textcolor(cyan);
writeln('?');
textcolor(white);
for i:=1 to lungh2+17 do write(chr(219));
writeln(chr(219));
writeln;




textcolor(white);
lungh1:=length(name1);
for i:=1 to lungh1+17 do write(chr(219));
writeln(chr(219));
write(chr(219));
textcolor(lightmagenta);
write(' Giocatore 1 : ',name1,' ');
textcolor(white);
write(chr(219));
if length(name2)>length(name1) then for i:=1 to length(name2)-length(name1) do write(' ');
write('   Carte pescate: ');
textcolor(cyan);

for i:=1 to 15 do begin
                          textcolor(lightred);
                          if stato1[i]='c' then textcolor(cyan)
                             else textcolor(lightred);
                          if mano1[i]<>0 then write(' ',mano1[i]:1:1);
                          textcolor(lightred);
                     end;


textcolor(white);
writeln;
for i:=1 to lungh1+17 do write(chr(219));
writeln(chr(219));
writeln;

if p1+c1>=7.5 then pescaX:='n';


{IMPORTANTE!!!! Questo ciclo permette di gigare una carta se non se ne hanno coperte, in modo che il gicoatore dopo ne veda sempre una col "?"}
for i:=1 to 15 do if (stato1[i]='c') and (pescaX='n') then axx:=axx+1;
                                                    if axx=0 then begin
                                                                 repeat
                                                                   textcolor(lightred);
                                                                   writeln;
                                                                   write('Devi girare una carta! Quale?: ');
                                                                   textcolor(white);
                                                                   readln(giro_carta1);
                                                                   textcolor(yellow);
                                                                 until (giro_carta1>0) and (giro_carta1<14);
                                                                   stato1[giro_carta1]:='c'
                                                                   end;

 axx:=0;

{---------------------------------------------------------------------------------------------------------------------------------------------}
{---------------------------------------------------------------------------------------------------------------------------------------------}
{---------------------------------------------------------------------------------------------------------------------------------------------}
{---------------------------------------------------------------------------------------------------------------------------------------------}




{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}
{questo riscrive la stessa schermata che faceva all'inizio del repeat. Ma serve perchè se no non verrebbe refreshata}
{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}

clrscr;
textcolor(white);
lungh2:=length(name2);
for i:=1 to lungh2+17 do write(chr(219));
writeln(chr(219));
write(chr(219));
textcolor(lightgreen);
write(' Giocatore 2 : ',name2,' ');
textcolor(white);
write(chr(219));
if length(name1)>length(name2) then for i:=1 to length(name1)-length(name2) do write(' ');
write('   Carte pescate: ');
textcolor(cyan);
writeln('?');
textcolor(white);
for i:=1 to lungh2+17 do write(chr(219));
writeln(chr(219));
writeln;



textcolor(white);
lungh1:=length(name1);
for i:=1 to lungh1+17 do write(chr(219));
writeln(chr(219));
write(chr(219));
textcolor(lightmagenta);
write(' Giocatore 1 : ',name1,' ');
textcolor(white);
write(chr(219));
if length(name2)>length(name1) then for i:=1 to length(name2)-length(name1) do write(' ');
write('   Carte pescate: ');
textcolor(cyan);

for i:=1 to 15 do begin
                          textcolor(lightred);
                          if stato1[i]='c' then textcolor(cyan)
                             else textcolor(lightred);
                          if mano1[i]<>0 then write(' ',mano1[i]:1:1);
                          textcolor(lightred);
                     end;


textcolor(white);
writeln;
for i:=1 to lungh1+17 do write(chr(219));
writeln(chr(219));
writeln;
textcolor(yellow);
write('Hai totalizzato: ');
textcolor(white);
writeln(p1+c1:1:1);

readln;

{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}
{--------------------------------------------------------------------------------------------------------------------}


end;{chiude prima player 2 e poi 1}












writeln;
clrscr;

controllo_bug1;
controllo_bug2;
controllo_bug4;
controllo_bug5;

if bugx001=true then writeln(' A causa del bug x001 è necessario riavvire 7 e mezzo');
if bugx002=true then writeln(' A causa del bug x002 è necessario riavvire 7 e mezzo');
if (bugx004_1=true) or (bugx004_2=true) then writeln(' A causa del bug x004 è necessario riavvire 7 e mezzo');
if (bugx005_1=true) or (bugx005_2=true) then writeln(' A causa del bug x005 è necessario riavvire 7 e mezzo');

{nel caso in cui nessuno dei 2 sballi}
if (p1+c1>p2+c2) and (p1+c1<=7.5) then begin
                   textcolor(lightmagenta);
                   writeln;
                   write(name1);
                   textcolor(yellow);
                   write(' hai vinto! ');
                   textcolor(lightgreen);
                   write(name2,' ');
                   textcolor(yellow);
                   writeln('è stato superato!');
                   torneo1[x]:='w';
                   torneo2[x]:='l';
              end;



if (p2+c2>p1+c1) and (p2+c2<=7.5) then begin
                   textcolor(lightgreen);
                   writeln;
                   write(name2);
                   textcolor(yellow);
                   write(' hai vinto! ');
                   textcolor(lightmagenta);
                   write(name1,' ');
                   textcolor(yellow);
                   writeln('è stato superato!');
                   torneo2[x]:='w';
                   torneo1[x]:='l';
              end;
{-------------------------------------------}


if (p2+c2>7.5) and (p1+c1>7.5) then begin               {se entrambi sballano}            {se per caso tutti e 2 sballato al numero N, allora esce, che}
                                    textcolor(yellow);                                    { hanno sballato e dopo che hanno pareggiato}
                                    writeln;
                                    writeln('Avete perso entrambi!');
                                    torneo1[x]:='s';
                                    torneo2[x]:='s';
                                    end
  else begin            {se uno dei 2 non sballa}

            if (p2+c2>p1+c1) and (p2+c2>7.5) then begin
                   textcolor(lightmagenta);
                   writeln;
                   write(name1);
                   textcolor(yellow);
                   write(' hai vinto! ');
                   textcolor(lightgreen);
                   write(name2,' ');
                   textcolor(yellow);
                   writeln('ha sballato!');
                   torneo1[x]:='w';
                   torneo2[x]:='s';
                                                   end;

              if (p1+c1>p2+c2) and (p1+c1>7.5) then begin
                   textcolor(lightgreen);
                   writeln;
                   write(name2);
                   textcolor(yellow);
                   write(' hai vinto! ');
                   textcolor(lightmagenta);
                   write(name1,' ');
                   textcolor(yellow);
                   writeln('ha sballato!');
                   torneo2[x]:='w';
                   torneo1[x]:='s';
                                                  end;
              {---------------------------------------------}
          end;



if p1+c1=p2+c2 then begin        {in caso di pareggio, indipendentemente dallo sballo, perchè tanto le condiz di prima la indicano lo stesso}
                   textcolor(yellow);
                   writeln;
                   write('Pareggio!');
                   torneo1[x]:='p';
                   torneo2[x]:='p';
              end;
x:=x+1;
readln;
clrscr;

for i:=1 to 15 do carte1[i]:=0;     {tolgo dalle mani  dei giocatori le carte pescate, riazzerando l'array carte1 e carte2}
for i:=1 to 15 do carte2[i]:=0;

bugx001:=false;  {faccio questo per evitare che bux001o2 restino true. Se succedese il rilevamento bug diventerebbe un bug lui stesso, cosa un po' stupida}
bugx002:=false;

readln;


until (x=partite);

clrscr;
textcolor(white);
writeln;
writeln('..::Statistiche::..');
writeln;
textcolor(lightmagenta);
write(name1,', ');
textcolor(yellow);
write('questo è il tuo risultato');
writeln;
writeln;


for i:=0 to partite do begin
               if torneo1[i]='w' then textcolor(lightgreen);
               if torneo1[i]='l' then textcolor(lightred);
               if torneo1[i]='p' then textcolor(yellow);
               if torneo1[i]='s' then textcolor(lightblue);
               if torneo1[i]<>'' then write(chr(219));
               if torneo1[i]<>'' then write(chr(219));
               end;
               writeln;
for i:=0 to partite do begin
               if torneo1[i]='w' then textcolor(lightgreen);
               if torneo1[i]='l' then textcolor(lightred);
               if torneo1[i]='p' then textcolor(yellow);
               if torneo1[i]='s' then textcolor(lightblue);
               if torneo1[i]<>'' then write(chr(219));
               if torneo1[i]<>'' then write(chr(219));
               end;

writeln;
writeln;

textcolor(lightgreen);
write(name2,', ');
textcolor(yellow);
write('questo è il tuo risultato');
writeln;
writeln;

for i:=0 to partite do begin
               if torneo2[i]='w' then textcolor(lightgreen);
               if torneo2[i]='l' then textcolor(lightred);
               if torneo2[i]='p' then textcolor(yellow);
               if torneo2[i]='s' then textcolor(lightblue);
               if torneo1[i]<>'' then write(chr(219));
               if torneo1[i]<>'' then write(chr(219));
               end;
writeln;
for i:=0 to partite do begin
               if torneo2[i]='w' then textcolor(lightgreen);
               if torneo2[i]='l' then textcolor(lightred);
               if torneo2[i]='p' then textcolor(yellow);
               if torneo2[i]='s' then textcolor(lightblue);
               if torneo1[i]<>'' then write(chr(219));
               if torneo1[i]<>'' then write(chr(219));
               end;

writeln;
textcolor(white);
writeln;
writeln;
writeln('..::Legenda::..');
writeln;
writeln;
textcolor(lightgreen);
writeln;
writeln('Verde : Vittoria!');
textcolor(lightred);
writeln;
writeln('Rosso : Perdita!');
textcolor(yellow);
writeln;
writeln('Giallo : Pareggio!');
textcolor(lightblue);
writeln;
writeln('Blu : Sballato!');
readln;
end.

