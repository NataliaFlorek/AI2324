osoba(alicja).
osoba(ola).
osoba(maciej).
osoba(marek).
osoba(ala).
osoba(weronika).
osoba(dawid).
osoba(witold).
osoba(olgierd).
osoba(irys).
mezczyzna(maciej).
mezczyzna(marek).
mezczyzna(dawid).
mezczyzna(witold).
mezczyzna(olgierd).
rodzic(irys, alicja).
rodzic(olgierd, alicja).
rodzic(witold, maciej).
rodzic(maciej, marek).
rodzic(alicja, marek).
rodzic(alicja, ola).
rodzic(maciej, ola).
rodzic(maciej, dawid).
rodzic(alicja,dawid).
rodzic(marek, ala).
rodzic(dawid, weronika).

kobieta(X):-
  osoba(X),
  \+mezczyzna(X).

ojciec(X,Y):-
  mezczyzna(X),
  rodzic(X, Y).

matka(X,Y):-
  kobieta(X),
  rodzic(X, Y).

corka(X,Y):-
  kobieta(Y),
  rodzic(X, Y).

brat_rodzony(X,Y):-
  mezczyzna(X),
  ojciec(A, Y),
  ojciec(A, X),
  matka(M, Y),
  matka(M, X).

brat_przyrodni(X, Y):-
  mezczyzna(X),
  \+brat_rodzony(X,Y).

kuzyn(X, Y):-
  rodzic(A, X),
  rodzic(B, Y),
  brat_rodzony(A,B).

dziadek_od_strony_ojca(X, Y):-
  mezczyzna(X),
  rodzic(X, Z),
  ojciec(Z, Y).

dziadek_od_strony_matki(X, Y):-
  mezczyzna(X),
  rodzic(X, Z),
  matka(Z, Y).

dziadek(X, Y):-
  mezczyzna(X),
  rodzic(X, Z),
  rodzic(Z,Y).

babcia(X, Y):-
  kobieta(X),
  rodzic(X, Z),
  rodzic(Z,Y).

wnuczka(X, Y):-
  kobieta(Y),
  babcia(X, Y);
  kobieta(Y),
  dziadek(X, Y).

przodek_do2pokolenia_wstecz(X, Y):-
  dziadek(X, Y);
  babcia(X, Y).

przodek_do3pokolenia_wstecz(X, Y):-
  rodzic(X, Z),
  dziadek(Z, Y);
  rodzic(X, Z),
  babcia(Z, Y).
