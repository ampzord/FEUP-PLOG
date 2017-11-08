:- use_module(library(lists)).
:- consult(utils).
:- consult(movements).

start :- boardWithPieces(X), startGame(X).

printBoard(Board):- 
write('  | A | B | C | D | E | F | G | H |'), nl,
write('                                      '), nl,
printField(Board, 1), 
write('-------------------------------------'), nl,
write('                                     '), nl,
write('  | A | B | C | D | E | F | G | H |'), nl, nl, !.

printField(_,9).

printField(Board,Line):- 
write('-------------------------------------'), nl,
write(Line), 
printLine(Board,Line,1), 
write(' | '), write(Line), 
nl, 
LineAux is Line + 1, 
printField(Board,LineAux).

printLine(_,_,9).
printLine(Board,Line,Column):-  
write(' | '), 
getPiece(Board,Line/Column,Piece), 
write(Piece), 
ColumnAux is Column + 1, 
printLine(Board, Line,ColumnAux).

getPiece(Board,Line/Column,Piece):- 
elementInPosition(Line,Board,L,1), 
elementInPosition(Column,L,Piece,1).

elementInPosition(Position,[X|_],X,Position).
elementInPosition(Position,[_|L],Piece,Cont) :- 
Cont1 is Cont+1, 
elementInPosition(Position,L,Piece,Cont1).



startGame(Board) :- gameCycle(Board,1).

gameCycle(Board,Player) :- repeat,
printBoard(Board),
write('Player '),  write(Player), write(' choose a piece'), nl,
write('Column = '), read(ColumnOrigin), nl,
write('Line = '), read(LineOrigin), isDigit(LineOrigin), nl,
write('Choose the destination'), nl,
write('Column = '), read(ColumnDest), nl,
write('Line = '), read(LineDest), isDigit(LineDest), nl,
checkValidPlay(Board,Player,ColumnOrigin,LineOrigin,ColumnDest,LineDest), !,
movePiece(Board, ColumnOrigin, LineOrigin, ColumnDest, LineDest, RetBoard),
(
	Player == 1 -> NextPlayer is 2;
	NextPlayer is 1
),
gameCycle(RetBoard,NextPlayer),
!,
write('fixe').


checkValidPlay(Board,Player,ColumnOrigin,LineOrigin,ColumnDest,LineDest) :- 
checkDestinationPiece(Board,Player,ColumnDest,LineDest), 
checkOwnPiece(Board,Player,ColumnOrigin,LineOrigin,Piece),
checkDestination(Board,Piece,ColumnOrigin,LineOrigin,ColumnDest,LineDest,Poss),
charToInt(ColumnDest,Col), write('poss:'), write(Poss), nl, member([Col,LineDest],Poss).

checkOwnPiece(Board,Player,ColumnOrigin,LineOrigin,Piece) :- 
(
	Player == 1 -> charToInt(ColumnOrigin,N), getPiece(Board,LineOrigin/N,Piece), member(Piece,['Q','T','B','H']); 
	Player == 2 -> charToInt(ColumnOrigin,N), getPiece(Board,LineOrigin/N,Piece), member(Piece,['q','t','b','h'])
).

checkDestinationPiece(Board,Player,ColumnDest,LineDest) :-
(
	Player == 2 -> charToInt(ColumnDest,N), getPiece(Board,LineDest/N,Piece), member(Piece,['Q','T','B','H']); 
	Player == 1 -> charToInt(ColumnDest,N), getPiece(Board,LineDest/N,Piece), member(Piece,['q','t','b','h'])
).

movePiece(Board, ColumnOrigin, LineOrigin, ColumnDest, LineDest, RetBoard) :- 
getPiece(Board,LineOrigin/ColumnOrigin,Piece), 
swapFirstPiece(Board,1,ColumnOrigin,LineOrigin,' ',RetBoard).

swapFirstPiece([],_,_,_,_,[]).

swapFirstPiece([Board|Rest],ColumnOrigin,ColumnOrigin,LineOrigin,PieceToReplace,[L|RetBoard]) :-
NextColumn is CurrColumn+1,
swapPieceOnLine(Board,LineOrigin,' ',L),
swapFirstPiece(Rest,NextColumn,ColumnOrigin,LineOrigin,PieceToReplace,RetBoard).

swapFirstPiece([Board|Rest],CurrColumn,ColumnOrigin,LineOrigin,PieceToReplace,[Board|RetBoard]) :- 
NextColumn is CurrColumn+1,
swapFirstPiece(Rest,NextColumn,ColumnOrigin,LineOrigin,PieceToReplace,RetBoard).


