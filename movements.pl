checkDestination(Board,Piece,ColumnOrigin,LineOrigin,ColumnDest,LineDest,Poss) :- 
														(isQueen(Piece) -> checkQueenMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,Poss)
														;
														isHorse(Piece) -> checkHorseMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,Poss)
														;
														isTower(Piece) -> checkTowerMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,Poss)
														;
														isBishop(Piece) -> checkBishopMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,Poss)).

checkQueenMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,Poss) :- horizontalMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,Poss),
																				verticalMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,Poss).


verticalMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,Poss) :- charToInt(ColumnOrigin,ColOr), charToInt(ColumnDest,ColDes),
																			(LineOrigin < LineDest -> 
																				getVerticalPossibilities(Board,ColOr,LineOrigin,ColDes,LineDest,1,Poss)
																			;
																			getVerticalPossibilities(Board,ColOr,LineOrigin,ColDes,LineDest,-1,Poss)).



																							

horizontalMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,Poss) :- charToInt(ColumnOrigin,ColOr), charToInt(ColumnDest,ColDes), 
														( ColOr < ColDes -> getHorizontalPossibilities(Board,ColOr,LineOrigin,ColDes,LineDest,1,Poss)
														;
														getHorizontalPossibilities(Board,ColOr,LineOrigin,ColDes,LineDest,-1,Poss)).


oneMore(Board,ColWitInc,LineOrigin,ColDes,LineDest,Inc,[[ColWitInc,LineOrigin]|Poss]).

getHorizontalPossibilities(Board,ColOr,LineOrigin,ColDes,LineDest,Inc,[[ColWitInc,LineOrigin]|Poss]) :- ColWitInc is ColOr+Inc, 
					getPiece(Board,LineOrigin/ColWitInc,Piece),
					(isSpace(Piece) ->
					getHorizontalPossibilities(Board,ColWitInc,LineOrigin,ColDes,LineDest,Inc,Poss)
					;
					write(ColWitInc), oneMore(Board,ColWitInc,LineOrigin,ColDes,LineDest,Inc,Poss)).

getHorizontalPossibilities(Board,ColOr,LineOrigin,ColDes,LineDest,Inc,[]).
