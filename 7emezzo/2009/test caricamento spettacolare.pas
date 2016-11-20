program a;
uses crt,graph;
var
i,z:integer;
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
readln;
end.
