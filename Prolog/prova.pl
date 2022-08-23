replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):- I > -1, NI is I-1, replace(T, NI, X, R), !.
replace(L, _, _, L).

trasforma(est,Lista,ListaModificata):-
    nth0(X, Lista, 0), %trovo lo 0
    Des is X+1, %prendo la posizione in c'e' il numero che voglio spostare
    nth0(X,Lista,Elem1), %prendo il valore di 0
    nth0(Des,Lista,Elem2), %prendo il valore dell'elemento a destra di 0
    replace(Lista,Des,Elem1,L2),
    replace(L2,X,Elem2,ListaModificata).

%nth0(X, [1,0,3], 0), trovo la posizione di zero
%Des is X+1, trovo la posizione dell'elemento a destra di 0 
%nth0(X,[1,0,3],Elem1), %prendo il valore di 0
%nth0(Des,[1,0,3],Elem2), prendo il valore dell'elemento a destra di 0
%replace(Elem2,Elem,[1,0,3],NuovaLista). li rimpiazzo
%devo fare secondo replace