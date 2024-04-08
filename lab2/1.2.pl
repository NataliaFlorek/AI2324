relacja(jan, ania).
relacja(jan, marek).
relacja(zosia, ania).
relacja(zosia, marek).
relacja(ola, zosia).
relacja(tomek, jan).
relacja(ania, julia).
relacja(marek, wiktoria).
relacja(michal, marek).
relacja(michal, ela).
relacja(ola, krzysztof).
relacja(karol, michal).
relacja(karol, ania).


%A
rodzenstwo(X, Y) :- %rodzenstwo(zosia, jan)
    relacja(X, Z),
    relacja(X, Q),
    relacja(Y, Z),
    relacja(Y, Q),
    X \= Y.

%B
wnuki(X, Y) :- %wnuki(tomek, ola)
    relacja(Z, Q),
    relacja(V, Q),
    relacja(X, Z),
    relacja(Y, V),
    X \= Y.
  
%C
dziadkowie(X, Y) :- %dziadkowie(julia, wiktoria)
    relacja(Q, X),
    relacja(V, Y),
    relacja(M, Q),
    relacja(M, V),
    X \= Y.

%D
przybranyrodzic(X, Y) :- %przybranyrodzic(michal, ania)
    relacja(M, Y),
    relacja(M, Q),
    relacja(X, Q),
    X \= M.
  
%E
przybranerodzenstwo(X, Y) :- %przybranerodzenstwo(michal, zosia)
    relacja(X, E),
    relacja(X, Q),
    relacja(Y, Q),
    relacja(Y, A),
    X \= Y,
    A \= E.

%F
szwagier(X, Y) :- %szwagier(krzysztof, jan)
    relacja(Y, M),
    relacja(Z, M),
    relacja(O, Z),
    relacja(O, X).

%G
to_skomplikowane(X, Y) :- %to_skomplikowane(zosia, karol)
	  relacja(X, A),
    relacja(X, M),
    relacja(Q, M),
    relacja(Y, Q),
    relacja(Y, A).


    
   
