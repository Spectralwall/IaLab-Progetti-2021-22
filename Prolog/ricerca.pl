%questo file è dedicato alla scrittura dei metodi di ricerca con ueristica nello spazio degli stati

%di seguito viene presentato il primo metodo informato 
%ovvero il numero di tessere che ha posizione diversa Ovvero La distanza di Hamming
hamming_distance([],[],0).%caso base

hamming_distance([Head1|Tail1],[Head2|Tail2], Res) :- %caso in cui due numeri siano uguali
    hamming_distance(Tail1,Tail2,Dist),
    Head1 == Head2,
    !,
    Res is Dist+1.

hamming_distance([Head1|Tail1],[Head2|Tail2], Res) :- % caso in cui due numeri siano diversi
    hamming_distance(Tail1,Tail2,Dist),s
    Head1 \== Head2,
    !,
    Res is Dist+0.

%funzione che dato un punto nella lista ritorna le cordinatenella matrice
listToMatrix(X,Riga,Colonna):- 
    Riga is X // 3,
    Colonna is X mod 3.

%Ora scriveremo la distanza di manhattan 
%Calcolero la distanza per ogni numero e poi le sommero insieme cosi lo stato avrà un somma totale
distanza_manhattan(S, SFinale, Distanza) :-
    aggregate_all(
        sum(Tot),
                (     
                    nth0(PosizioneListIniziale, S, Numero), 
                    listToMatrix(PosizioneListIniziale, RigaList, ColonnaList),
                    nth0(PosizioneListFinale, SFinale, Numero), 
                    listToMatrix(PosizioneListFinale, RigaListFinale, ColonnaListFinale),
                    Tot is abs(RigaList - RigaListFinale) + abs(ColonnaList - ColonnaListFinale)
                ), 
        Distanza).



%Varinate con distanza di manhattan tra due liste