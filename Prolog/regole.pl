%file dedicato alla definzione di regole del dominio del gioco del 9 e del 15

%applicabile(AZ,S) l'azione AZ 'e applicabile allo staso S ?
%descriviamo l'applicabilita di una trasformazione 
applicabile(nord,Lista):-
    nth0(X, Lista, 0),
    X>2.

applicabile(sud,Lista):-
    nth0(X, Lista, 0),
    X<6.

applicabile(est,Lista):-
    nth0(X, Lista, 0),
    X\=2,
    X\=5,
    X\=8.

applicabile(ovest,Lista):-
    nth0(X, Lista, 0),
    X\=0,
    X\=3,
    X\=6.

%trasforma(AZ,S,S_nuovo) l'azione Az applicata allos stato S porta in S_nuovo
%desctiviamo il cambiamento di stato
trasforma(est,Lista,ListaModificata):-
    nth0(X, Lista, 0), %trovo lo 0
    Destra is X+1, %prendo la posizione cui in c'e' il numero che voglio spostare
    nth0(X,Lista,Elem1), %prendo il valore di 0
    nth0(Destra,Lista,Elem2), %prendo il valore dell'elemento a destra di 0
    replace(Lista,Destra,Elem1,L2), %scambio
    replace(L2,X,Elem2,ListaModificata), %scambio
    !.

trasforma(ovest,Lista,ListaModificata):-
    nth0(X, Lista, 0), %trovo lo 0
    Sinistra is X-1, %prendo la posizione cui in c'e' il numero che voglio spostare
    nth0(X,Lista,Elem1), %prendo il valore di 0
    nth0(Sinistra,Lista,Elem2), %prendo il valore dell'elemento a sinistra di 0
    replace(Lista,Sinistra,Elem1,L2), %scambio
    replace(L2,X,Elem2,ListaModificata), %scambio
    !.


trasforma(sud,Lista,ListaModificata):-
    nth0(X, Lista, 0), %trovo lo 0
    Giu is X+3, %prendo la posizione in cui c'e' il numero che voglio spostare
    nth0(X,Lista,Elem1), %prendo il valore di 0
    nth0(Giu,Lista,Elem2), %prendo il valore dell'elemento a sotto 0
    replace(Lista,Giu,Elem1,L2), %scambio
    replace(L2,X,Elem2,ListaModificata), %scambio
    !.

trasforma(nord,Lista,ListaModificata):-
    nth0(X, Lista, 0), %trovo lo 0
    Su is X-3, %prendo la posizione in cui c'e' il numero che voglio spostare
    nth0(X,Lista,Elem1), %prendo il valore di 0
    nth0(Su,Lista,Elem2), %prendo il valore dell'elemento a sopra  0
    replace(Lista,Su,Elem1,L2), %scambio
    replace(L2,X,Elem2,ListaModificata), %scambio
    !.

%funzioni di supporto 
replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):- I > -1, NI is I-1, replace(T, NI, X, R), !.
replace(L, _, _, L).

    