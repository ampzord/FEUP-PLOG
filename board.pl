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



startGame(Board) :- gameCycle(Board,1,Value).

gameCycle(Board,Player,Value) :- 
	repeat,
	printBoard(Board),
	\+gameOver(Board,Winner),
	%gameOverByMoves(Board,Player,Winner),
	getPiecesThroughBoardLine(Board,1,Value),
	write('Value: '), write(Value), nl,
	%Value == 1,
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
	gameCycle(RetRetBoard,NextPlayer,Value),
	!.

gameCycle(Board,Player,Value) :- 
	Value \= 1, write('GAME ENDED BITCHES'), nl.

gameOverByMoves(Board,Player,Winner):-
	getPiecesThroughBoardLine(Board,1,Value),
	Value \= 1,
	write('Game ended because player cant kill the enemy'), nl.

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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

%NEW YEAR NEW PREDICATES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

getPiecesThroughBoardLine(_,9,_).


getPiecesThroughBoardLine(Board,Line,Value):- 
	getPiecesAuxThroughCol(Board,Line,1,Value),
	Value == 1,
	LineAux is Line + 1, 
	getPiecesThroughBoardLine(Board,LineAux,Value).

%NAO SEI COMO ISTO AKI FUNCIONA DA SEM E COM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%getPiecesThroughBoardLine(Board,Line,Value):- 
	%Value == 1.

getPiecesAuxThroughCol(_,_,9,_).

getPiecesAuxThroughCol(Board,Line,Column,Value):-
	intToChar(Column,ColumnChar),  
	getPiece(Board,Line/Column,Piece),
	%write('Line: '), write(Line), nl,
	%write('Column: '), write(Column), nl, 
	%write('Peca: '), write(Piece), nl,
	%write('Before getAllPossibilities'), nl,
	getAllPossibilities(Board,Line,ColumnChar,Piece,PossiblePlays),
	%write('After getAllPossibilitiesssssss'), nl,
	isAValidPlay(Board,PossiblePlays,Value),
	Value == 1, 
	ColumnAux is Column + 1, 	
	getPiecesAuxThroughCol(Board, Line,ColumnAux,Value).

getPiecesAuxThroughCol(Board,Line,Column,Value):-
	Value == 1.


%%%%%%above is all gucci

getAllPossibilities(Board,LineOrigin,ColumnOrigin,Piece,PossiblePlays):-
	(
		isBlackHorse(Piece) -> ( 
									checkHorseMovement(Board,ColumnOrigin,LineOrigin,1,1,Poss),
									write('Possibilities of Horse: '), write(Poss), nl,
									append(Poss,[],PossiblePlays)
								);
		isSpace(Piece);
		isWhiteQueen(Piece)				
	).

isAValidPlay(_,[],_):-
	write('Empty list case.'), nl.

isAValidPlay(Board,[Head|Tail],Value):-
	write('List inside isAValidPlay : '), nl,
	write('Head :'), write(Head), nl,
	write('Tail :'), write(Tail), nl,
	nth1(2,Head,LineObtained),
	write('LineObtained: '), write(LineObtained), nl,
	nth1(1,Head,ColumnObtained),
	write('ColumnObtained: '), write(ColumnObtained), nl,
	getPiece(Board,LineObtained/ColumnObtained,Piece),
	write('Peca dentro de isAValidPlay: '), write(Piece), nl,
	(
		isEnemyPiece(Piece) -> ( write('Dentro do isEnemyPiece if.'), nl, Value is 1)
	),
	isAValidPlay(Board,Tail,Value).
	




%old code before refactoring
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


/*
doesntExistValidPlay(_,[],Answer).
	%Answer is 0.

doesntExistValidPlay(Board,[Head|Tail],Answer) :-
	%check a  getpiece da cabeca, se for != space -> gucci
	nth1(2,Head,LineObtained),
	nth1(1,Head,ColumnObtained),
	getPiece(Board,LineObtained/ColumnObtained,Piece),
	isSpace(Piece),

	%isWhiteQueen(Piece),
	%!,
	doesntExistValidPlay(Board,Tail,Answer).

doesntExistValidPlay(Board,Board,[Head|Tail],Answer):-
	getPiece(Board,LineObtained/ColumnObtained,Piece),
	isEnemyPiece(Piece),
	Answer is 1,
	write('Found enemy piece I can kill.'), nl.

getBoardPieces(_,9).

getBoardPieces(Board,Line):-
	%write('Inside getBoardPieces, Line :'), write(Line), nl,
	auxLine(Board,Line,1), 
	LineAux is Line+1, 
	getBoardPieces(Board,LineAux).


auxLine(_,_,9).

auxLine(Board,Line,Column):-  
	intToChar(Column,ColumnChar),
	getPiece(Board,Line/Column,Piece),
	nl, write('Peca: '), write(Piece), nl,
	checkAllPossibilities(Board,ColumnChar,Line,Piece,OldList,NewList), !,
	write('NewList: '), write(NewList), nl,
	\+doesntExistValidPlay(Board,NewList),
	ColumnAux is Column + 1, 
	auxLine(Board, Line,ColumnAux).

checkAllPossibilities(Board,ColumnOrigin,LineOrigin, Piece, OldList, NewList):-
	(
		isBlackHorse(Piece) -> 
						  (
						  	%already checks all movements with one call
						    checkHorseMovement(Board,ColumnOrigin,LineOrigin,'A',1,Possf8),
						    append(OldList,Possf8,NewList)
						  );
		isSpace(Piece) -> (write('entrei no espaco'), nl);
		isWhiteQueen(Piece) -> (
								write('do nothing from now, found white queen on board.'), nl
								)

	).
*/




















