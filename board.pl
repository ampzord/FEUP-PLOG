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
checkValidPlay(Board,Player,ColumnOrigin,LineOrigin,ColumnDest,LineDest),
movePiece(Board, ColumnOrigin, LineOrigin, ColumnDest, LineDest, RetBoard),
!,
write('fixe').


checkValidPlay(Board,Player,ColumnOrigin,LineOrigin,ColumnDest,LineDest) :- 
checkDestinationPiece(Board,Player,ColumnDest,LineDest), 
checkOwnPiece(Board,Player,ColumnOrigin,LineOrigin,Piece),
checkDestination(Board,Piece,ColumnOrigin,LineOrigin,ColumnDest,LineDest,Poss),
charToInt(ColumnDest,Col), member([Col,LineDest],Poss).

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

movePiece([Line|Rest], ColumnOrigin, LineOrigin, ColumnDest, LineDest, RetBoard) :-
swapLine(Line,ColumnOrigin, LineOrigin, ColumnDest, LineDest, RetBoard) 


