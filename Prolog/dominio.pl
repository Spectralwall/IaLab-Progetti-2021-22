%file dedicato alla descrizione del dominio del gioc del 9 (anche detto gioco dell'8) e del 15 

%stato iniziale del gioco del 9 
statoIniziale([ 7,1,6,
                8,0,3,
                2,5,4]).%stato generato da un sito online

stattoFinale([  1,2,3,
                4,5,6,
                7,8,0]).%stato goal ovvero che tutti i numeri siano ordinati

statoInzialeMini([1,2,3,
                  4,5,6,
                  7,0,8]).

statoInzialeMini2([0,2,3,
                  4,1,6,
                  7,5,8]).

%[1,2,3,4,5,6,7,0,8]
%[4,8,5,7,6,2,1,3,0]
%[1,2,3,4,5,6,7,8,0]