:- use_module(library(lists)).
:- consult(utils).
:- consult(movements).
:- consult(menu).

start :- boardAmp(X), startGame(X).

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
\+gameOver(Board,Winner),
\+getBoardPieces(Board,1),
write('Player '),  write(Player), write(' choose a piece'), nl,
write('Column = '), read(ColumnOrigin), nl,
write('Line = '), read(LineOrigin), isDigit(LineOrigin), nl,
write('Choose the destination'), nl,
write('Column = '), read(ColumnDest), nl,
write('Line = '), read(LineDest), isDigit(LineDest),
checkValidPlay(Board,Player,ColumnOrigin,LineOrigin,ColumnDest,LineDest),

charToInt(ColumnOrigin,ColOrigin),
write('Original Column:'), write(ColumnOrigin), write(' / Original Line:'), write(LineOrigin),nl,
getPiece(Board,LineOrigin/ColOrigin,PieceOrigin), write('Piece: '), write(PieceOrigin), nl,
write('Destination Column:'), write(ColumnDest), write(' / Destination Line:'), write(LineDest),nl,
movePiece(Board, ColumnOrigin, LineOrigin,' ', RetBoard),
movePiece(RetBoard,ColumnDest,LineDest,PieceOrigin,RetRetBoard),
(
	Player == 1 -> NextPlayer is 2;
	NextPlayer is 1
),
gameCycle(RetRetBoard,NextPlayer),
!.
%write('fixe').


%gameCycle(Board,Player) :-
 %       gameOver(Board,Winner),
  %      write('Player '), write(Winner), write(' won!'), nl.


checkValidPlay(Board,Player,ColumnOrigin,LineOrigin,ColumnDest,LineDest) :- 
checkDestinationPiece(Board,Player,ColumnDest,LineDest),
checkOwnPiece(Board,Player,ColumnOrigin,LineOrigin,Piece),
checkDestination(Board,Piece,ColumnOrigin,LineOrigin,ColumnDest,LineDest,Poss), !,
charToInt(ColumnDest,Col), member([Col,LineDest],Poss). % write('poss:'), write(Poss), 

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

movePiece(Board, Column, Line, Piece, RetBoard) :- 
charToInt(Column,Col),
swapFirstPiece(Board,1,Col,Line,Piece, RetBoard).

swapFirstPiece([],_,_,_,_,[]).

swapFirstPiece([Board|Rest],Line,Col,Line,PieceToReplace,[L|RetBoard]) :-
NextLine is Line+1,
swapPieceOnLine(Board,Col,PieceToReplace,L), 
swapFirstPiece(Rest,NextLine,Col,Line,PieceToReplace,RetBoard).

swapFirstPiece([Board|Rest],CurrLine,Col,Line,PieceToReplace,[Board|RetBoard]) :- 
NextLine is CurrLine+1,
swapFirstPiece(Rest,NextLine,Col,Line,PieceToReplace,RetBoard).

%added by amp
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gameOver(Board,Winner):-
		\+checkIfBlackPlayerHasPieces(Board), write('winner is 2, pecas pekenas'), Winner is 2, abort.

gameOver(Board,Winner):-
		\+checkIfWhitePlayerHasPieces(Board), write('winner is 1, pecas grandes'), Winner is 1, abort.



checkIfBlackPlayerHasPieces(Board):-
				pieceExistsOnBoard('Q', Board); 
				pieceExistsOnBoard('H', Board); 
				pieceExistsOnBoard('B', Board); 
				pieceExistsOnBoard('T', Board).


checkIfWhitePlayerHasPieces(Board):-
				pieceExistsOnBoard('q', Board);
				pieceExistsOnBoard('h', Board); 
				pieceExistsOnBoard('b', Board);
				pieceExistsOnBoard('t', Board).

pieceExistsOnBoard(P,[L|_]):-
	member(P,L).

pieceExistsOnBoard(P, [_|T]):-
	pieceExistsOnBoard(P,T).


verifyExistsValidPlays([]).
verifyExistsValidPlays(Board, [Head|Tail]) :-
	%check a  getpiece da cabeca, se for != space -> gucci
	nth1(2,Head,LineObtained),
	nth1(1,Head,ColumnObtained),
	getPiece(Board,LineObtained/ColumnObtained,Piece),
	isSpace(Piece), %retorna true \+isSPace
	!,
	verifyExistsValidPlays(Board,Tail).
	
%verifyExistsValidPlays(Board, [Head|Tail]):-
%	getPiece(Board,LineObtained/ColumnObtained,Piece),
%	isSpace(Piece).



getBoardPieces(_,9).

getBoardPieces(Board,Line):- 
	auxLine(Board,Line,1), 
	LineAux is Line+1, 
	getBoardPieces(Board,LineAux).

auxLine(_,_,9).

auxLine(Board,Line,Column):-  
	getPiece(Board,Line/Column,Piece),
	write('Peca: '), write(Piece), nl,
	checkAllPossibilities(Board,Column,Line,Piece,OldList,NewList),
	write('Nova Lista: '), nl, write(NewList),
	verifyExistsValidPlays(Board,NewList),
	ColumnAux is Column+1, 
	auxLine(Board, Line,ColumnAux).

checkAllPossibilities(Board,ColumnOrigin,LineOrigin, Piece, OldList, NewList):-
	(
		isQueen(Piece) -> 
							(
							%top left corner
							checkQueenMovement(Board,ColumnOrigin,LineOrigin,'A',1,HPoss1,VPoss1,OPoss1), !, append(HPoss1,VPoss1,L1), append(OPoss1,L1,Poss1),
							%top middle corner
						  	checkQueenMovement(Board,ColumnOrigin,LineOrigin,ColumnOrigin,1,HPoss2,VPoss2,OPoss2), !, append(HPoss2,VPoss2,L2), append(OPoss2,L2,Poss2),
						  	%top right corner
						  	checkQueenMovement(Board,ColumnOrigin,LineOrigin,'H',1,HPoss3,VPoss3,OPoss3), !, append(HPoss3,VPoss3,L3), append(OPoss3,L3,Poss3),
						  	%middle left corner
						  	checkQueenMovement(Board,ColumnOrigin,LineOrigin,'A',LineOrigin,HPoss4,VPoss4,OPoss4), !, append(HPoss4,VPoss4,L4), append(OPoss4,L4,Poss4),
						  	%middle right corner
						  	checkQueenMovement(Board,ColumnOrigin,LineOrigin,'H',LineOrigin,HPoss5,VPoss5,OPoss5), !, append(HPoss5,VPoss5,L5), append(OPoss5,L5,Poss5),
						  	%bottom left corner
						  	checkQueenMovement(Board,ColumnOrigin,LineOrigin,'A',8,HPoss,VPoss,OPoss), !, append(HPoss6,VPoss6,L6), append(OPoss6,L6,Poss6),
						  	%bottom middle corner
						  	checkQueenMovement(Board,ColumnOrigin,LineOrigin,ColumnOrigin,8,HPoss,VPoss,OPoss), !, append(HPoss7,VPoss7,L7), append(OPoss7,L7,Poss7),
						  	%bottom right corner
						  	checkQueenMovement(Board,ColumnOrigin,LineOrigin,'H',8,HPoss,VPoss,OPoss), !, append(HPoss8,VPoss8,L8), append(OPoss8,L8,Poss8),

						  	append(Poss1,Poss2,Possf1),
						  	append(Possf1,Poss3,Possf2),
						  	append(Possf2,Poss4,Possf3),
						  	append(Possf3,Poss5,Possf4),
						  	append(Possf4,Poss6,Possf5),
						  	append(Possf5,Poss7,Possf6),
						  	append(Possf6,Poss8,Possf7),
						  	append(OldList,Possf7,NewList)
						  );
		isBlackHorse(Piece) -> 
						  (
						  	%already checks all movements with one call
						    checkHorseMovement(Board,ColumnOrigin,LineOrigin,'A',1,Possf8),
						    append(OldList,Possf8,NewList)
						  );

		isBlackTower(Piece) ->
						  (
						  	write('Inside isBlackTower :'), write(Piece), nl,
						  	%upper vertical movement
						  	checkTowerMovement(Board,ColumnOrigin,LineOrigin,ColumnOrigin,1,HPoss9,VPoss9), write('HEUHEUHEU first checkTowerMovement'), nl, append(HPoss9,VPoss9,Possf9),
						  	write('After first checkTowerMovement'), nl,
						  	%left horizontal movement
						  	checkTowerMovement(Board,ColumnOrigin,LineOrigin,'A',LineOrigin,HPoss10,VPoss10), append(HPoss10,VPoss10,Possf10),
						  	%right horizontal movement
						  	checkTowerMovement(Board,ColumnOrigin,LineOrigin,'H',LineOrigin,HPoss11,VPoss11), append(HPoss11,VPoss11,Possf11),
						  	%bottom vertical movement
						  	checkTowerMovement(Board,ColumnOrigin,LineOrigin,ColumnOrigin,8,HPoss12,VPoss12), append(HPoss12,VPoss12,Possf12),

						  	append(Possf9,Possf10,Possf13),
						  	append(Possf13,Possf11,Possf14),
						  	append(Possf14,Possf12,Possf13),
						  	write('Possf13: '), write(Possf13), nl,
						  	append(OldList,Possf13,NewList),

						  	write('NewList'), write(NewList), nl
						  );

		isBlackBishop(Piece) ->
		                  (
		                  	%top left corner
		                  	checkBishopMovement(Board,ColumnOrigin,LineOrigin,'A',1,Possf15),
		                  	%top right corner
		                  	checkBishopMovement(Board,ColumnOrigin,LineOrigin,'H',1,Possf16),
		                  	%bottom left corner
		                  	checkBishopMovement(Board,ColumnOrigin,LineOrigin,'A',8,Possf17),
		                  	%bottom right corner
		                  	checkBishopMovement(Board,ColumnOrigin,LineOrigin,'H',8,Possf18),

		                  	append(Possf15,Possf16,Passf20),
		                  	append(Possf17,Possf20,Passf21),
		                  	append(Possf18,Possf21,Passf22),
		                  	append(OldList,Passf22,NewList)
		                  )

	).

	



