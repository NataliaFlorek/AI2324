lubi(jan, pawel).
lubi(pawel, krzysztof).
lubi(pawel, jan).
lubi(jan, bartek).
lubi(bartek, jan).
lubi(ala, jan).
lubi(jan, ala).
kocha(ala, jan, kobieta).
kocha(jan, ala, mezczyzna).


przyjazn(X, Y) :-
    lubi(X,Y),
    lubi(Y,X).

niby_przyjazn(X, Y) :-
    lubi(X,Y);
    lubi(Y,X).

nieprzyjazn(X,Y) :-
    \+lubi(X,Y),
    \+lubi(Y,X).

loves(X,Y) :-
    kocha(X,Y, mezczyzna),
    kocha(Y,X, kobieta);
    kocha(X,Y, kobieta),
    kocha(Y,X, mezczyzna).
    
true_love(X,Y) :-
    przyjazn(X,Y),
    kocha(X,Y, mezczyzna),
    kocha(Y,X, kobieta);
    przyjazn(X,Y),
    kocha(X,Y, kobieta),
    kocha(Y,X, mezczyzna).
    
