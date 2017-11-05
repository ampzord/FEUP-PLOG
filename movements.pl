%towerMovement(ColumnOrigin,LineOrigin,Destinations) :- 


%horizontalMovement(ColumnOrigin,LineOrigin,)


checkDestination(Board,Piece,ColumnOrigin,LineOrigin,ColumnDest,LineDest,ListofPossibilities) :- ((Piece == 'Q' ; Piece == 'q') -> write('1111'), checkQueenMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,ListofPossibilities)
																			;
																			(Piece == 'H' ; Piece == 'h') -> checkHorseMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,ListofPossibilities)
																			;
																			(Piece == 'T' ; Piece == 't') -> checkTowerMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,ListofPossibilities)
																			;
																			(Piece == 'T' ; Piece == 't') -> checkHorseMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,ListofPossibilities)).

checkQueenMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,ListofPossibilities) :- write('2222'),horizontalMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,L1).
																							%moreMovements....

horizontalMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,ListPossibilities) :- charToInt(ColumnOrigin,ColOr), charToInt(ColumnDest,ColDes), 
																			( ColOr < ColDes -> getHorizontalPossibilities(Board,ColOr,LineOrigin,ColDes,LineDest,1,L1)
																			;
																			getHorizontalPossibilities(Board,ColOr,LineOrigin,ColDes,LineDest,-1,L1)).

getHorizontalPossibilities(Board,ColDes,LineOrigin,ColDes,LineDest,Inc,L1) :- write('end').
getHorizontalPossibilities(Board,ColOr,LineOrigin,ColDes,LineDest,Inc,L1) :- ColWitInc is ColOr+Inc, getPiece(Board,LineOrigin/ColWitInc,Piece), write(Piece),
															( Piece == ' ' -> 
																getHorizontalPossibilities(Board,ColOr+Inc,LineOrigin,ColDes,LineDest,Inc,append([ColOr+Inc,LineOrigin],L1,L1))).
