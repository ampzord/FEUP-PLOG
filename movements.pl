%towerMovement(ColumnOrigin,LineOrigin,Destinations) :- 


%horizontalMovement(ColumnOrigin,LineOrigin,)


checkDestination(Board,Piece,ColumnOrigin,LineOrigin,ColumnDest,LineDest,ListofPossibilities) :- ((Piece == 'Q' ; Piece == 'q') -> checkQueenMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,ListofPossibilities)
																			;
																			(Piece == 'H' ; Piece == 'h') -> checkHorseMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,ListofPossibilities)
																			;
																			(Piece == 'T' ; Piece == 't') -> checkTowerMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,ListofPossibilities)
																			;
																			(Piece == 'T' ; Piece == 't') -> checkHorseMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,ListofPossibilities)).

checkQueenMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,ListofPossibilities) :- horizontalMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,ListofPossibilities).
																							

horizontalMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest,ListofPossibilities) :- charToInt(ColumnOrigin,ColOr), charToInt(ColumnDest,ColDes), 
																			( ColOr < ColDes -> getHorizontalPossibilities(Board,ColOr,LineOrigin,ColDes,LineDest,1,ListofPossibilities)
																			;
																			getHorizontalPossibilities(Board,ColOr,LineOrigin,ColDes,LineDest,-1,ListofPossibilities)).

getHorizontalPossibilities(Board,ColDes,LineOrigin,ColDes,LineDest,Inc,ListofPossibilities) :- write('l1: '), print_list(ListofPossibilities).
getHorizontalPossibilities(Board,ColOr,LineOrigin,ColDes,LineDest,Inc,ListofPossibilities) :- 
					ColWitInc is ColOr+Inc, 
					getPiece(Board,LineOrigin/ColWitInc,Piece), write('l1: '), print_list(ListofPossibilities).
					( Piece == ' ' -> 
					getHorizontalPossibilities(Board,ColOr+Inc,LineOrigin,ColDes,LineDest,Inc,append([ColOr+Inc,LineOrigin],ListofPossibilities,ListofPossibilities))).
