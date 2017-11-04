%towerMovement(ColumnOrigin,LineOrigin,Destinations) :- 


%horizontalMovement(ColumnOrigin,LineOrigin,)


checkDestination(Board,Piece,ColumnOrigin,LineOrigin,ColumnDest,LineDest) :- ((Piece == 'Q' ; Piece == 'q') -> write(Piece), checkQueenMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest)
																			;
																			(Piece == 'H' ; Piece == 'h') -> checkHorseMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest)
																			;
																			(Piece == 'T' ; Piece == 't') -> checkTowerMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest)
																			;
																			(Piece == 'T' ; Piece == 't') -> checkHorseMovement(Board,ColumnOrigin,LineOrigin,ColumnDest,LineDest)).