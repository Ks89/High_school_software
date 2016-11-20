program Ship_battle_10;
uses crt;

var
   gate1:array[1..10,1..10] of integer;
   m,nave1,up,max,a,b,c,e,i1:integer;
   d:char;
   sovrap,ssp,uscita:boolean;

procedure stampa_griglia;
{stampa la griglia fatta senza procedura grafica}
begin
   for a:=1 to 10 do for b:=1 to 10 do begin
                                            write(gate1[a,b],' ');
                                            if b=10 then writeln;
                                       end;
   writeln;
end;



procedure svuota;
begin
   c:=a;
   e:=b;
   for c:=1 to 10 do for e:=1 to 10 do gate1[c,e]:=0;
   for c:=1 to 10 do for e:=1 to 10 do if gate1[c,e]<>0 then gate1[c,e]:=0;
end;

{---------------------------------------------------------------------------------------------------------------}
{----------------------------------------------ks89 e aljosha89-------------------------------------------------}
{---------------------------------------------------------------------------------------------------------------}
{-----------------------------------------------INIZIO BEGIN----------------------------------------------------}
{---------------------------------------------------------------------------------------------------------------}
{-------------------------------------------------2006-07-------------------------------------------------------}
{---------------------------------------------------------------------------------------------------------------}


begin
   sovrap:=false;
   uscita:=false;
   ssp:=false;
   m:=0;
   clrscr;
   nave1:=1;
   for a:=1 to 10 do for b:=1 to 10 do gate1[a,b]:=0; {svuota tutta la griglia}

   repeat
         clrscr;

{posiziona navi}
         stampa_griglia;
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
{serve a inzializzare il conteggio delle celle col numero 1, per poi vedere se la nave esce dalla griglia}
         i1:=0;
         writeln('riga');
         readln(a);
         writeln('colonna');
         readln(b);

         
         if (nave1=1) and (gate1[a,b]<>0) then begin
                                                   clrscr;
                                                   writeln('Errore : Sovrapposizione di navi');
                                                   nave1:=1;
                                                   ssp:=true;   {Sovrapposizione Starter Point, ovvero la cordinata in cui do l'inzio della nave}
                                                   svuota;
                                              end;

         if (nave1=2) and (gate1[a,b]<>0) then begin
                                                   clrscr;
                                                   writeln('Errore : Sovrapposizione di navi');
                                                   nave1:=1;
                                                   ssp:=true;
                                                   svuota;
                                              end;

         if (nave1=3) and (gate1[a,b]<>0) then begin
                                                   clrscr;
                                                   writeln('Errore : Sovrapposizione di navi');
                                                   nave1:=1;
                                                   ssp:=true;
                                                   svuota;
                                              end;

         if (nave1=4) and (gate1[a,b]<>0) then begin
                                                   clrscr;
                                                   writeln('Errore : Sovrapposizione di navi');
                                                   nave1:=1;
                                                   ssp:=true;
                                                   svuota;
                                              end;

         if (nave1=5) and (gate1[a,b]<>0) then begin
                                                   clrscr;
                                                   writeln('Errore : Sovrapposizione di navi');
                                                   nave1:=1;
                                                   ssp:=true;
                                                   svuota;
                                              end;

         if nave1=1 then gate1[a,b]:=1;
         if nave1=2 then gate1[a,b]:=2;
         if nave1=3 then gate1[a,b]:=3;
         if nave1=4 then gate1[a,b]:=4;
         if nave1=5 then gate1[a,b]:=5;


{direzione della nave sulla gliglia : up,down,sx,dx}
         d:='1';

if ssp=false then begin   {se è vero significa che c'è una SSP e quindi non fa nulla di questo e va al giro dopo subito}

         writeln('Scegli la posizione');
         readln(d);
         case d of
            'u': begin
                      for up:=1 to max do begin
                                                if nave1=1 then gate1[a-up,b]:=1;
                                                if nave1=2 then begin
                                                                     if gate1[a-up,b]=0 then gate1[a-up,b]:=2
                                                                     else begin
                                                                               writeln('Errore : sovrapposizione di navi');
                                                                               sovrap:=true;
                                                                               nave1:=1;
                                                                               svuota;
                                                                          end;
                                                                 end;

                                                if nave1=3 then begin
                                                                     if gate1[a-up,b]=0 then gate1[a-up,b]:=3
                                                                     else begin
                                                                               writeln('Errore : sovrapposizione di navi');
                                                                               nave1:=1;
                                                                               sovrap:=true;
                                                                               svuota;
                                                                          end;
                                                                 end;

                                                if nave1=4 then begin
                                                                     if gate1[a-up,b]=0 then gate1[a-up,b]:=4
                                                                     else begin
                                                                               writeln('Errore : sovrapposizione di navi');
                                                                               nave1:=1;
                                                                               sovrap:=true;
                                                                               svuota;
                                                                          end;
                                                                 end;

                                                if nave1=5 then begin
                                                                     if gate1[a-up,b]=0 then gate1[a-up,b]:=5
                                                                     else begin
                                                                               writeln('Errore : sovrapposizione di navi');
                                                                               nave1:=1;
                                                                               sovrap:=true;
                                                                               svuota;
                                                                          end;
                                                                 end;

                                                if gate1[a-up,b]=1 then i1:=i1+1;
                                                if gate1[a-up,b]=2 then i1:=i1+1;
                                                if gate1[a-up,b]=3 then i1:=i1+1;
                                                if gate1[a-up,b]=4 then i1:=i1+1;
                                                if gate1[a-up,b]=5 then i1:=i1+1;

                                                if a-up<0 then i1:=i1-1;
                                          end;
                 if sovrap=true then svuota;
                 end;

            'g': begin
                      for up:=1 to max do begin
                                                if nave1=1 then gate1[a+up,b]:=1;
                                                if nave1=2 then begin
                                                                     if gate1[a+up,b]=0 then gate1[a+up,b]:=2
                                                                     else begin
                                                                               writeln('Errore : sovrapposizione di navi');
                                                                               nave1:=1;
                                                                               sovrap:=true;
                                                                               svuota;
                                                                          end;
                                                                 end;

                                                if nave1=3 then begin
                                                                     if gate1[a+up,b]=0 then gate1[a+up,b]:=3
                                                                     else begin
                                                                               writeln('Errore : sovrapposizione di navi');
                                                                               nave1:=1;
                                                                               sovrap:=true;
                                                                               svuota;
                                                                          end;
                                                                 end;

                                                if nave1=4 then begin
                                                                     if gate1[a+up,b]=0 then gate1[a+up,b]:=4
                                                                     else begin
                                                                               writeln('Errore : sovrapposizione di navi');
                                                                               nave1:=1;
                                                                               sovrap:=true;
                                                                               svuota;
                                                                          end;
                                                                 end;

                                                if nave1=5 then begin
                                                                     if gate1[a+up,b]=0 then gate1[a+up,b]:=5
                                                                     else begin
                                                                               writeln('Errore : sovrapposizione di navi');
                                                                               nave1:=1;
                                                                               sovrap:=true;
                                                                               svuota;
                                                                          end;
                                                                 end;

                                                if gate1[a+up,b]=1 then i1:=i1+1;
                                                if gate1[a+up,b]=2 then i1:=i1+1;
                                                if gate1[a+up,b]=3 then i1:=i1+1;
                                                if gate1[a+up,b]=4 then i1:=i1+1;
                                                if gate1[a+up,b]=5 then i1:=i1+1;

                                                if a+up<0 then i1:=i1-1;
                                          end;
                 if sovrap=true then svuota;
                 end;

            's': begin
                      for up:=1 to max do begin
                                                if nave1=1 then gate1[a,b-up]:=1;
                                                if nave1=2 then begin
                                                                     if gate1[a,b-up]=0 then gate1[a,b-up]:=2
                                                                     else begin
                                                                               writeln('Errore : sovrapposizione di navi');
                                                                               nave1:=1;
                                                                               sovrap:=true;
                                                                               svuota;
                                                                          end;
                                                                 end;

                                                if nave1=3 then begin
                                                                     if gate1[a,b-up]=0 then gate1[a,b-up]:=3
                                                                     else begin
                                                                               writeln('Errore : sovrapposizione di navi');
                                                                               nave1:=1;
                                                                               sovrap:=true;
                                                                               svuota;
                                                                          end;
                                                                 end;

                                                if nave1=4 then begin
                                                                     if gate1[a,b-up]=0 then gate1[a,b-up]:=4
                                                                     else begin
                                                                               writeln('Errore : sovrapposizione di navi');
                                                                               nave1:=1;
                                                                               sovrap:=true;
                                                                               svuota;
                                                                          end;
                                                                 end;

                                                if nave1=5 then begin
                                                                     if gate1[a,b-up]=0 then gate1[a,b-up]:=5
                                                                     else begin
                                                                               writeln('Errore : sovrapposizione di navi');
                                                                               nave1:=1;
                                                                               sovrap:=true;
                                                                               svuota;
                                                                          end;
                                                                 end;

                                                if gate1[a,b-up]=1 then i1:=i1+1;
                                                if gate1[a,b-up]=2 then i1:=i1+1;
                                                if gate1[a,b-up]=3 then i1:=i1+1;
                                                if gate1[a,b-up]=4 then i1:=i1+1;
                                                if gate1[a,b-up]=5 then i1:=i1+1;

                                                if b-up<0 then i1:=i1-1;
                                          end;
                 if sovrap=true then svuota;
                 end;

            'd': begin
                      for up:=1 to max do begin
                                                if nave1=1 then gate1[a,b+up]:=1;
                                                if nave1=2 then begin
                                                                     if gate1[a,b+up]=0 then gate1[a,b+up]:=2
                                                                     else begin
                                                                               writeln('Errore : sovrapposizione di navi');
                                                                               nave1:=1;
                                                                               svuota;
                                                                               sovrap:=true;
                                                                          end;
                                                                 end;

                                                if nave1=3 then begin
                                                                     if gate1[a,b+up]=0 then gate1[a,b+up]:=3
                                                                     else begin
                                                                               writeln('Errore : sovrapposizione di navi');
                                                                               nave1:=1;
                                                                               sovrap:=true;
                                                                               svuota;
                                                                          end;
                                                                 end;

                                                if nave1=4 then begin
                                                                     if gate1[a,b+up]=0 then gate1[a,b+up]:=4
                                                                     else begin
                                                                               nave1:=1;
                                                                               writeln('Errore : sovrapposizione di navi');
                                                                               svuota;
                                                                               sovrap:=true;
                                                                          end;
                                                                 end;

                                                if nave1=5 then begin
                                                                     if gate1[a,b+up]=0 then gate1[a,b+up]:=5
                                                                     else begin
                                                                               writeln('Errore : sovrapposizione di navi');
                                                                               nave1:=1;
                                                                               svuota;
                                                                               sovrap:=true;
                                                                          end;
                                                                 end;

                                                if gate1[a,b+up]=1 then i1:=i1+1;
                                                if gate1[a,b+up]=2 then i1:=i1+1;
                                                if gate1[a,b+up]=3 then i1:=i1+1;
                                                if gate1[a,b+up]=4 then i1:=i1+1;
                                                if gate1[a,b+up]=5 then i1:=i1+1;

                                                if b+up<0 then i1:=i1-1;
                                          end;
                 if sovrap=true then svuota;
                 end;

         else begin
                   writeln('Errore!! Riposiziona la nave');
                   nave1:=nave1-1;
                   delay(500);
                   clrscr;
              end;
         end;

{controlla che il numero di 1 nella griglia, dell'ultima nave posizionata sia quello giusto, se no, al termine del repeat richiede la stessa nave}


         if nave1=1 then begin
                              if i1<>4 then begin
                                                 nave1:=0;
                                                 writeln('i1 ',i1);
                                                 uscita:=true;
                                                 for up:=1 to max do begin
                                                                     case d of
                                                                              'u': gate1[a-up,b]:=0;
                                                                              'g': gate1[a+up,b]:=0;
                                                                              's': gate1[a,b-up]:=0;
                                                                              'd': gate1[a,b+up]:=0;
                                                                              end;
                                                                      end;

                                                 readln;
                                            end;
                         end;
         if nave1=2 then begin
                              if i1<>3 then begin
                                                 nave1:=1;
                                                 writeln('i1 ',i1);
                                                 uscita:=true;
                                                 for up:=1 to max do begin
                                                                     case d of
                                                                              'u': gate1[a-up,b]:=0;
                                                                              'g': gate1[a+up,b]:=0;
                                                                              's': gate1[a,b-up]:=0;
                                                                              'd': gate1[a,b+up]:=0;
                                                                              end;
                                                                      end;
                                                 readln;
                                            end;
                         end;
         if nave1=3 then begin
                              if i1<>2 then begin
                                                 nave1:=2;
                                                 writeln('i1 ',i1);
                                                 uscita:=true;
                                                 for up:=1 to max do begin
                                                                     case d of
                                                                              'u': gate1[a-up,b]:=0;
                                                                              'g': gate1[a+up,b]:=0;
                                                                              's': gate1[a,b-up]:=0;
                                                                              'd': gate1[a,b+up]:=0;
                                                                              end;
                                                                     end;
                                                 readln;
                                            end;
                         end;
         if nave1=4 then begin
                              if i1<>2 then begin
                                                 nave1:=3;
                                                 writeln('i1 ',i1);
                                                 uscita:=true;
                                                 for up:=1 to max do begin
                                                                     case d of
                                                                              'u': gate1[a-up,b]:=0;
                                                                              'g': gate1[a+up,b]:=0;
                                                                              's': gate1[a,b-up]:=0;
                                                                              'd': gate1[a,b+up]:=0;
                                                                              end;
                                                                     end;
                                                 readln;
                                            end;
                         end;
         if nave1=5 then begin
                              if i1<>1 then begin
                                                 nave1:=4;
                                                 writeln('i1 ',i1);
                                                 uscita:=true;
                                                 for up:=1 to max do begin
                                                                     case d of
                                                                              'u': gate1[a-up,b]:=0;
                                                                              'g': gate1[a+up,b]:=0;
                                                                              's': gate1[a,b-up]:=0;
                                                                              'd': gate1[a,b+up]:=0;
                                                                              end;
                                                                     end;
                                                 readln;
                                            end;
                         end;

         nave1:=nave1+1;

end;


{questo serve per cancellare in caso si SSP, dato che la parte all'inizio non riesce a fare la cancellazione totale}
if ssp=true then begin;
                       svuota;
                 end;

    ssp:=false;      {è sempre per SPP}

if uscita=true then gate1[a,b]:=0;

   uscita:=false;
   until nave1=6;



   {è solo un test, non serve}

   for a:=1 to 10 do for b:=1 to 10 do begin
                                     if (gate1[a,b]=1) or (gate1[a,b]=2) or (gate1[a,b]=3) or (gate1[a,b]=4) or (gate1[a,b]=5) then m:=m+1;
                                     end;
   readln;
   writeln('m',m); {il valore stampato deve essere SEMPRE 17, se no, il gioco nno va. è solo un test, ma è una cosa molto molto importante}
   readln;

   stampa_griglia;

   readln;

end.


