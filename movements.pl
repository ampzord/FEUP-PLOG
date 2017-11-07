checkDestination(Board,Piece,ColumnOrigin,LineOrigin,ColumnDest,LineDest,Poss) :- 
														(isQueen(Piece) -> checkQueenMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,HPoss,VPoss,OPoss)
														;
														isHorse(Piece) -> checkHorseMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,Poss)
														;
														isTower(Piece) -> checkTowerMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,Poss)
														;
														isBishop(Piece) -> checkBishopMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,Poss)).

checkQueenMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,HPoss,VPoss,OPoss) :- horizontalMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,HPoss), 
																				print_list(HPoss),
																				verticalMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,VPoss), 
																				print_list(VPoss),
																				obliqueMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,OPoss),
																				print_list(OPoss).

obliqueMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,OPoss) :- charToInt(ColumnOrigin,ColOr), charToInt(ColumnDest,ColDes),
																			( ColOr < ColDes, LineOrigin < LineDest -> getObliquePossibilities(Board,ColOr,LineOrigin,ColDes,LineDest,1,OPoss)
																			;
																			getObliquePossibilities(Board,ColOr,LineOrigin,ColDes,LineDest,-1,OPoss)).

oneMoreObl(Board,ColWitInc,LineWithInc,ColDes,LineDest,Inc,[[ColWitInc,LineWithInc]|OPoss]).

getObliquePossibilities(Board,ColOr,LineOrigin,ColDes,LineDest,Inc,[[ColWitInc,LineWithInc]|OPoss]) :- LineWithInc is LineOrigin+Inc, ColWitInc is ColOr+Inc,
																									getPiece(Board,LineWithInc/ColWitInc,Piece),
																									(isSpace(Piece) -> getObliquePossibilities(Board,ColWitInc,LineWithInc,ColDes,LineDest,Inc,OPoss)
																									;
																									oneMoreObl(Board,ColWitInc,LineWithInc,ColDes,LineDest,Inc,OPoss)).

getObliquePossibilities(Board,ColWitInc,LineWithInc,ColDes,LineDest,Inc,[]).																									


verticalMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,VPoss) :- charToInt(ColumnOrigin,ColOr), charToInt(ColumnDest,ColDes),
																			(LineOrigin < LineDest -> getVerticalPossibilities(Board,ColOr,LineOrigin,ColDes,LineDest,1,VPoss)
																			;
																			getVerticalPossibilities(Board,ColOr,LineOrigin,ColDes,LineDest,-1,VPoss)).

oneMoreVer(Board,ColOr,LineWithInc,ColDes,LineDest,Inc,[[ColOr,LineWithInc]|VPoss]).

getVerticalPossibilities(Board,ColOr,LineOrigin,ColDes,LineDest,Inc,[[ColOr,LineWithInc]|VPoss]) :- LineWithInc is LineOrigin+Inc,
																getPiece(Board,LineWithInc/ColOr,Piece),
																(isSpace(Piece) ->
																getVerticalPossibilities(Board,ColOr,LineWithInc,ColDes,LineDest,Inc,VPoss)
																;
																oneMoreVer(Board,ColOr,LineWithInc,ColDes,LineDest,Inc,VPoss)).

getVerticalPossibilities(Board,ColOr,LineWithInc,ColDes,LineDest,Inc,[]).
																							

horizontalMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,Poss) :- charToInt(ColumnOrigin,ColOr), charToInt(ColumnDest,ColDes), 
														( ColOr < ColDes -> getHorizontalPossibilities(Board,ColOr,LineOrigin,ColDes,LineDest,1,Poss)
														;
														getHorizontalPossibilities(Board,ColOr,LineOrigin,ColDes,LineDest,-1,Poss)).


oneMoreHor(Board,ColWitInc,LineOrigin,ColDes,LineDest,Inc,[[ColWitInc,LineOrigin]|Poss]).

getHorizontalPossibilities(Board,ColOr,LineOrigin,ColDes,LineDest,Inc,[[ColWitInc,LineOrigin]|Poss]) :- ColWitInc is ColOr+Inc, 
					getPiece(Board,LineOrigin/ColWitInc,Piece),
					(isSpace(Piece) ->
					getHorizontalPossibilities(Board,ColWitInc,LineOrigin,ColDes,LineDest,Inc,Poss)
					;
					oneMoreHor(Board,ColWitInc,LineOrigin,ColDes,LineDest,Inc,Poss)).

getHorizontalPossibilities(Board,ColOr,LineOrigin,ColDes,LineDest,Inc,[]).
