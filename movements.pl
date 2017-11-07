checkDestination(Board,Piece,ColumnOrigin,LineOrigin,ColumnDest,LineDest,Poss) :- 
(isQueen(Piece) -> checkQueenMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,HPoss,VPoss,OPoss), append(HPoss,VPoss,L1), append(OPoss,L1,Poss)
;
isHorse(Piece) -> checkHorseMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,Poss)
;
isTower(Piece) -> checkTowerMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,HPoss,VPoss), append(HPoss,VPoss,Poss), write(Poss), nl
;
isBishop(Piece) -> checkBishopMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,OPoss)).

checkTowerMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,HPoss,VPoss) :- 
horizontalMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,HPoss),
verticalMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,VPoss).

checkQueenMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,HPoss,VPoss,OPoss) :-
horizontalMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,HPoss),
verticalMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,VPoss),
obliqueMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,OPoss).

obliqueMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,OPoss) :-
charToInt(ColumnOrigin,ColOr), charToInt(ColumnDest,ColDes),
(
	ColOr < ColDes, LineOrigin < LineDest -> getObliquePossibilities(Board,ColOr,LineOrigin,ColDes,LineDest,1,OPoss);
	getObliquePossibilities(Board,ColOr,LineOrigin,ColDes,LineDest,-1,OPoss)
).

oneMoreObl(Board,ColWitInc,LineWithInc,ColDes,LineDest,Inc,[[ColWitInc,LineWithInc]|[]]).

getObliquePossibilities(Board,ColOr,LineOrigin,ColDes,LineDest,Inc,[[ColWitInc,LineWithInc]|OPoss]) :-
LineWithInc is LineOrigin+Inc,
ColWitInc is ColOr+Inc,
getPiece(Board,LineWithInc/ColWitInc,Piece),
(
	isSpace(Piece) -> getObliquePossibilities(Board,ColWitInc,LineWithInc,ColDes,LineDest,Inc,OPoss);
	oneMoreObl(Board,ColWitInc,LineWithInc,ColDes,LineDest,Inc,OPoss)
).

getObliquePossibilities(_,_,_,_,_,_,[]).																									

horizontalMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,Poss) :-
charToInt(ColumnOrigin,ColOr), charToInt(ColumnDest,ColDes), 
(
	ColOr < ColDes -> getHorizontalPossibilities(Board,ColOr,LineOrigin,ColDes,LineDest,1,Poss);
	getHorizontalPossibilities(Board,ColOr,LineOrigin,ColDes,LineDest,-1,Poss)
).


oneMoreHor(Board,ColWitInc,LineOrigin,ColDes,LineDest,Inc,[[ColWitInc,LineOrigin]|[]]).

getHorizontalPossibilities(Board,ColOr,LineOrigin,ColDes,LineDest,Inc,[[ColWitInc,LineOrigin]|Poss]) :- 
ColWitInc is ColOr+Inc, 
getPiece(Board,LineOrigin/ColWitInc,Piece),
(
	isSpace(Piece) -> getHorizontalPossibilities(Board,ColWitInc,LineOrigin,ColDes,LineDest,Inc,Poss);
	oneMoreHor(Board,ColWitInc,LineOrigin,ColDes,LineDest,Inc,Poss)
).

getHorizontalPossibilities(_,_,_,_,_,_,[]).


verticalMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,VPoss) :- 
charToInt(ColumnOrigin,ColOr), charToInt(ColumnDest,ColDes),
(LineOrigin < LineDest -> getVerticalPossibilities(Board,ColOr,LineOrigin,ColDes,LineDest,1,VPoss)
;
getVerticalPossibilities(Board,ColOr,LineOrigin,ColDes,LineDest,-1,VPoss)).

oneMoreVer(Board,ColOr,LineWithInc,ColDes,LineDest,Inc,[[ColOr,LineWithInc]|[]]).

getVerticalPossibilities(Board,ColOr,LineOrigin,ColDes,LineDest,Inc,[[ColOr,LineWithInc]|VPoss]) :- 
LineWithInc is LineOrigin+Inc,
getPiece(Board,LineWithInc/ColOr,Piece),
(
	isSpace(Piece) -> getVerticalPossibilities(Board,ColOr,LineWithInc,ColDes,LineDest,Inc,VPoss);
	oneMoreVer(Board,ColOr,LineWithInc,ColDes,LineDest,Inc,VPoss)
).

getVerticalPossibilities(_,_,_,_,_,_,[]).
