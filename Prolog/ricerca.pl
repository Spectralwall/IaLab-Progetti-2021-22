:- load_files('dominio.pl').
:- load_files('regole.pl').

%questo file è dedicato alla scrittura dei metodi di ricerca con ueristica nello spazio degli stati

%di seguito viene presentato il primo metodo informato 
%ovvero il numero di tessere che ha posizione diversa Ovvero La distanza di Hamming
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

%funzione che dato un punto nella lista ritorna le cordinatenella matrice
listToMatrix(X,Riga,Colonna):- 
    Riga is X // 3,
    Colonna is X mod 3.

%Ora scriveremo la distanza di manhattan 
%Calcolero la distanza per ogni numero e poi le sommero insieme cosi lo stato avrà un somma totale
distanza_manhattan(ListaS,ListaSF,[],0).
distanza_manhattan(ListaS,ListaSF,[HeadS|TailS],Distanza) :- %lista iniziale, lista goal, lista iniziale ,nome variabile risultato
    nth0(X,ListaS,HeadS),
    nth0(Y,ListaSF,HeadS),
    listToMatrix(X,RigaS,ColonnaS),
    listToMatrix(Y,RigaSF,ColonnaSF),
    Man is abs(RigaS - RigaSF) + abs(ColonnaS - ColonnaSF),
    distanza_manhattan(ListaS,ListaSF,TailS,Res),
    Distanza is Res + Man,
    !.

%dato uno stato e una direzione applicabile viene calcolato il costo della di quello stato dove applicando lo sposstamento e calcolando manhattan
wrapper_manhattan(ListaS,ListaSF,Direzione,Distanza):-
    trasforma(Direzione,ListaS,ListaSNew),
    distanza_manhattan(ListaSNew,ListaSF,ListaSNew,Val),
    Distanza is Val.

% cosa ceh deve avere A*
% Una lista di nodi già visitati;
% Una coda a priorità contentente i nodi da visitare.
% Nel corso dell’esecuzione, ad ogni nodo vengono associati più valori: gScore, hScore, fScore. In termini matematici, 
%   dato il nodo corrente n, il nodo di partenza p e il nodo soluzione s, si deifiniscono i valori:
%   La funzione g calcola il costo effettivo del percorso che separa i nodi p (partenza) e n (attuale).
%   La funzione h calcola una stima del costo del percorso tra i nodi s (soluzione) e n (attuale).
%   La funzione f e la somma di quelli di g e h
% 

%Da qua iniziano i metodi per la ricerca della soluzione in modo informato
cerca_soluzione(ListaAzioni):- %metodo per la ricerca della soluzione
    statoInzialeMini(S), %prendo stato iniziale.
    stattoFinale(SFinale), %prendo stato finale
    aStar(S,SFinale,ListaAzioni,[],[],0).%Stato iniziale, Stato finale, Lista di azioni compiute, lista nodi visitati, lista nodi da visitare, costo passi fatti

aStar(S,_,ListaAzioni,_,_,_):-
    stattoFinale(S),
    !,
    write(ListaAzioni).

aStar(S,SFinale,ListaAzioni,Visitati,Visitare,Costo):-
    %findall trova tutti i punti di backtracking di trovo mosse
    %trovo mosse esplora il confine e segna (lo stato di partenza, l'azione da eseguire, il costo dato dall'euristica e il costo di movimenti)
    findall(VisitareAggiornato, trovoMosse(S,SFinale,Visitare,Costo,VisitareAggiornato), Result),
    
    %devo poi filtrare dai nodi trovati quelli gia visitati

    %trovo lo stato da visitare dalla lista della frontiera, sommando a ogni distanza il numero di passi a cui siamo
    trovaMinimo(Result,Min),
    !,

    %aumento il numero di passi
    CostoAggiornato is Costo+1,

    %cancello l'elemento dai nodi da visitare / dalla frontiera
    delete(Result,Min,VisitareAggiornato),

    %e lo aggiungo hai nodi visitati
    %append(Visitati,Min,VisitatiAggiornato),

    %prendiamo i dari per il nuovo stato
    nth0(0,Min,Stato),
    nth0(1,Min,Az),

    %trasformazione di stato 
    %trasforma(Stato,Az,NuovoStato),

    %segno l'azione
    %append(ListaAzioni,Az,ListaAzioniAggiorn),

    %richiamo a star sul sul prossimo stato
    aStar(Stato,SFinale,[ListaAzioni|Az],[Visitati|Min],VisitareAggiornato,CostoAggiornato).
    
%funzione interna che aggiunge alla lista visitabili i nodi al confine
trovoMosse(S,SFinale,Visitare,NumeroPassi,Risultato):-
    applicabile(Az,S),%vedo quali sono le mosse possibili
    trasforma(Az,S,Snuova),%trasformo lo stato
    distanza_manhattan(Snuova,SFinale,Snuova,Val),%calcolo la distanza di manhattan 
    append(Visitare,[Snuova,Az,Val,NumeroPassi],Risultato).%inserisco nella lista di quelli da esplorare

%funzione interna per calcolare il minimo di una lista
trovaMinimo([Min], Min).%caso indutivo per prendere il minimo

trovaMinimo([Head, Head2 | Tail], M) :-%prendo i primi due elementi delle lista
    %Prendo i costi delle distanze dall'obbiettivo
    nth0(2, Head, Costo),
    nth0(2, Head2, Costo2),
    %prendo i costi dei passi
    nth0(3,Head,Pass),
    nth0(3,Head2,Pass2),
    %Calcolo A* sommando il numero di passi con la distanza dall'obbiettivo
    %Se il primo elemento ha un A* minore lo confronto con il resto delle lista
    Costo+Pass =< Costo2+Pass2,
    trovaMinimo([Head | Tail], M).

trovaMinimo([Head, Head2 | Tail], M) :-%prendo i primi due elementi delle lista
    %Prendo i costi delle distanze dall'obbiettivo
    nth0(2, Head, Costo),
    nth0(2, Head2, Costo2),
    %prendo i costi dei passi
    nth0(3,Head,Pass),
    nth0(3,Head2,Pass2),
    %Calcolo A* sommando il numero di passi con la distanza dall'obbiettivo
    %Se il primo elemento ha un A* minore lo confronto con il resto delle lista
    Costo+Pass > Costo2+Pass2,%se il costo del secondo elemento è minore lo confronto con il resto della lista
    trovaMinimo([Head2 | Tail], M).

%funzione di supporto per filtrare da liste
are_identical(X, Y) :-
    X == Y.

filterList(A, In, Out) :-
    exclude(are_identical(A), In, Out).

%esempio utilizzo
%filterList(A, [A, B, A, C, D, A], Out).
%Out = [B, C, D].
%[[[1, 2, 3, 4, 0, 6, 7|...], nord, 4, 0], [[1, 2, 3, 4, 5, 6|...], est, 0, 4], [[1, 2, 3, 4, 5|...], ovest, 4, 1]]
%[[[1, 2, 3, 4, 5, 6|...], est, 0, 4], [[1, 2, 3, 4, 5|...], ovest, 4, 1]]