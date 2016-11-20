program Ship_battle_10;
uses crt;
var
   gate1:array[1..10,1..10] of integer;
   m,nave1,up,max,a,b,i1:integer;
   d:char;


begin
   m:=0;
   clrscr;
   nave1:=1;
   for a:=1 to 10 do for b:=1 to 10 do gate1[a,b]:=0; {svuota tutta la griglia}

   repeat
         clrscr;       {posiziona navi}
         if nave1=1 then begin
                          writeln('Posiziona la portaerei');
                          max:=4;
                          end;

         if nave1=2 then begin
                          writeln('Posiziona la nave da battaglia');
                          max:=3;
                          end;

         if nave1=3 then begin
                          writeln('Posiziona il sottomarino');
                          max:=2;
                          end;

         if nave1=4 then begin
                          writeln('Posiziona la nave da 3');
                          max:=2;
                          end;

         if nave1=5 then begin
                          writeln('Posiziona la nave piccola da 2');
                          max:=1;
                          end;
        {chiede punto di partenza della nave}
         i1:=0;    {serve a inzializzare il conteggio delle celle col numero 1, per poi vedere se la nave esce dalla griglia}
         writeln('riga');
         readln(a);
         writeln('colonna');
         readln(b);
         gate1[a,b]:=1;
         {direzione della nave sulla gliglia : up,down,sx,dx}
         d:='1';
         writeln('Scegli la posizione');
         readln(d);
         case d of
            'u': begin
                      for up:=1 to max do begin
                                               gate1[a-up,b]:=1;                       {dpvrebbe essere giusto, però frse ho emsso che la nave da 5 ne ha solo 4 all'inzio del programma, devo ricontrollare}
                                               if gate1[a-up,b]=1 then i1:=i1+1;
                                               if a-up<0 then i1:=i1-1;
                                          end;
                 end;
            'g': begin
                      for up:=1 to max do begin
                                               gate1[a+up,b]:=1;
                                               if gate1[a+up,b]=1 then i1:=i1+1;
                                               if a+up<0 then i1:=i1-1;
                                          end;
                 end;
            's': begin
                      for up:=1 to max do begin
                                               gate1[a,b-up]:=1;
                                               if gate1[a,b-up]=1 then i1:=i1+1;
                                               if b-up<0 then i1:=i1-1;
                                          end;
                 end;
            'd': begin
                      for up:=1 to max do begin
                                               gate1[a,b+up]:=1;
                                               if gate1[a,b+up]=1 then i1:=i1+1;
                                               if b+up<0 then i1:=i1-1;
                                          end;
                 end;
         else begin
                   writeln('Errore!! Riposiziona la nave');
                   nave1:=nave1-1;
                   delay(500);
                   clrscr;
              end;
         end;

         {controlla che il numero di 1 nella griglia, dell'ultima nave posizionata sia quello giusto, se al termine del repeat quando riescegue richiede la stessa nave}


         if nave1=1 then begin
                              if i1<>4 then begin
                                                 nave1:=0;
                                                 readln;
                                                 writeln('i1 ',i1);
                                                 readln;
                                            end;
                         end;
         if nave1=2 then begin
                              if i1<>3 then begin
                                                 nave1:=1;
                                                 readln;
                                                 writeln('i1 ',i1);
                                                 readln;
                                            end;
                         end;
         if nave1=3 then begin
                              if i1<>2 then begin
                                                 nave1:=2;
                                                 readln;
                                                 writeln('i1 ',i1);
                                                 readln;
                                            end;
                         end;
         if nave1=4 then begin
                              if i1<>2 then begin
                                                 nave1:=3;
                                                 readln;
                                                 writeln('i1 ',i1);
                                                 readln;
                                            end;
                         end;
         if nave1=5 then begin
                              if i1<>1 then begin
                                                 nave1:=4;
                                                 readln;
                                                 writeln('i1 ',i1);
                                                 readln;
                                            end;
                         end;

         nave1:=nave1+1;

   until nave1=6;



   {è solo un test, non serve}

   for a:=1 to 10 do for b:=1 to 10 do begin
                                     if gate1[a,b]=1 then m:=m+1;
                                     end;
   readln;
   writeln('m',m); {perfetto, il metodo funziona, ora bisogna controllare che le navi ci stiano e non si sovrappongano nel posto ni cui dico di metterle}
   readln;

   for a:=1 to 10 do for b:=1 to 10 do begin
                                            write(gate1[a,b],' ');
                                            if b=10 then writeln;
                                       end;
   readln;

end.


