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

hamming_distance([],[],0).
hamming_distance([Head1|Tail1],[Head2|Tail2], Res) :-
    hamming_distance(Tail1,Tail2,Dist),
    Head1 == Head2,
    !,
    Res is Dist+1.

hamming_distance([Head1|Tail1],[Head2|Tail2], Res) :-
    hamming_distance(Tail1,Tail2,Dist),
    Head1 \== Head2,
    !,
    Res is Dist+0.

%funzione che dato un punto nella lista ritorna le cordinatenella matrice
listToMatrix(X,Riga,Colonna):- 
    Riga is X // 3,
    Colonna is X mod 3.

%Ora scriveremo la distanza di manhattan 
%Calcolero la distanza per ogni numero e poi le sommero insieme cosi lo stato avrà un somma totale
distanza_manhattan(ListaS,ListaSF,[],0).
distanza_manhattan(ListaS,ListaSF,[HeadS|TailS],Distanza) :-
    nth0(X,ListaS,HeadS),
    nth0(Y,ListaSF,HeadS),
    listToMatrix(X,RigaS,ColonnaS),
    listToMatrix(Y,RigaSF,ColonnaSF),
    Man is abs(RigaS - RigaSF) + abs(ColonnaS - ColonnaSF),
    distanza_manhattan(ListaS,ListaSF,TailS,Res),
    Distanza is Res + Man,
    !.

%Da qua iniziano i metodi per la ricerca della soluzione in modo informato
cerca_soluzione(ListaAzioni):- %metodo per la ricerca della soluzione
    statoIniziale(SIniziale), %prendo stato iniziale.
    stattoFinale(SFinale), %prendo stato finale
    aStar(SIniziale,SFinale,ListaAzioni,[],[],0).%Stato iniziale, Stato finale, Lista di azioni compiute, lista nodi visitati, lista nodi da visitare, costo passi fatti

aStar(SIniziale,SFinale,ListaAzioni,Visitati,Visitare,Costo):-
    trovoMosse(SIniziale,SFinale,Visitare,[]),%cerco i nuov stati al confine 

    

trovoMosse(SIniziale,SFinale,Visitare,Risultato):-%funzione interna che aggiunge alla lista visitabili i nodi al confine
    applicabile(Az,SIniziale),%vedo quali sono le mosse possibili
    wrapper_manhattan(SIniziale,SFinale,Az,Distanza),%calcolo il costo dalla nodo possibile allo stato finale.
    append(Visitare,[SIniziale,Az,Distanza],Risultato).