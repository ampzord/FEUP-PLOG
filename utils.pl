/*boardWithPieces([
['Q','T','t','T','B','T','b','B'],
['T','H','t','h','T','h','b','Q'],
['q','h','H','B','h','q','T','Q'],
['q','B','B','q','b','Q','H','Q'],
['h','h','T','t','h','B','h','B'],
['B','H','t','t','b','Q','T','b'],
['t','q','H','b','q','q','H','Q'],
['H','b','Q','H','q','t','t','b']
]).*/

emptyBoard([
[' ',' ',' ',' ',' ',' ',' ',' '],
[' ',' ',' ',' ',' ',' ',' ',' '],
[' ',' ',' ',' ',' ',' ',' ',' '],
[' ',' ',' ',' ',' ',' ',' ',' '],
[' ',' ',' ',' ',' ',' ',' ',' '],
[' ',' ',' ',' ',' ',' ',' ',' '],
[' ',' ',' ',' ',' ',' ',' ',' '],
[' ',' ',' ',' ',' ',' ',' ',' ']
]).

boardWithPieces([
['Q','T','t','T','B','T','b','B'],
['T','H','t','h','T','h','b','Q'],
['q','h','h',' ',' ','q','T','Q'],
[' ','B',' ','H',' ','Q','H','Q'],
['h',' ',' ',' ','h','B','h','B'],
['b',' ',' ','t','b','Q','T','b'],
['t','q',' ',' ','q','q','H','Q'],
['H','b','t',' ','q','t','t','b']
]).

boardHalfMade([
['Q',' ',' ',' ',' ',' ','b','B'],
[' ',' ','t','h','T','h','b','Q'],
[' ','h',' ','B','h','q','T','Q'],
[' ','B','B','q','b','Q','H','Q'],
['h','h','T','t','h','B','h','B'],
['B','H','t','t','b','Q','T','b'],
['t','q','H','b','q','q','H','Q'],
['H','b','Q','H','q','t','t','b']
]).

%isNotSpace(Cha) :- Cha \= ' '.
isSpace(Cha) :- Cha == ' '.
isQueen(Cha) :- Cha == 'Q' ; Cha == 'q'.
isTower(Cha) :- Cha == 'T' ; Cha == 't'.
isHorse(Cha) :- Cha == 'H' ; Cha == 'h'.
isBishop(Cha) :- Cha == 'B' ; Cha == 'b'.

isDigit(X) :- number(X), X >= 1, X =< 8, ! ;fail.

charToInt('A',Num) :- Num is 1.
charToInt('B',Num) :- Num is 2.
charToInt('C',Num) :- Num is 3.
charToInt('D',Num) :- Num is 4.
charToInt('E',Num) :- Num is 5.
charToInt('F',Num) :- Num is 6.
charToInt('G',Num) :- Num is 7.
charToInt('H',Num) :- Num is 8.

swapPieceOnLine(Array,LineNum,Piece,NewArray) :-
swapPieceOnLineAux(Array,LineNum,1,Piece,NewArray).

swapPieceOnLineAux([],_,_,_,[]).

swapPieceOnLineAux([_|T1],LineNum,LineNum,Piece,[Piece|T2]):-
NextLine is LineNum + 1,
swapPieceOnLineAux(T1,LineNum,NextLine,Piece,T2).

swapPieceOnLineAux([H1|T1],LineNum,CurrLine,Piece,[H1|T2]):-
NextLine is CurrLine + 1,
swapPieceOnLineAux(T1,LineNum,NextLine,Piece,T2).
