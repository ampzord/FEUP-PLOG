:- use_module(library(lists)).
:- consult(utils).
:- consult(movements).

start :- boardWithPieces(X), printBoard(X), startGame(X).

printBoard(Board):-write('  A B C D E F G H'), nl, printField(Board, 1), write('  A B C D E F G H'), nl, nl, !.

printField(_,9).
printField(Board,Line):-write(Line), 
						printLine(Board,Line,1), 
						write(' '), write(Line), 
						nl, 
						LineAux is Line + 1, 
						printField(Board,LineAux).

printLine(_,_,9).
printLine(Board,Line,Column):-  write(' '), 
								getPiece(Board,Line/Column,Piece), 
								write(Piece), 
								ColumnAux is Column + 1, 
								printLine(Board, Line,ColumnAux).

getPiece(Board,Line/Column,Piece):-elementInPosition(Line,Board,L,1), 
									elementInPosition(Column,L,Piece,1).

elementInPosition(Position,[X|_],X,Position).
elementInPosition(Position,[_|L],Piece,Cont) :- Cont1 is Cont+1, elementInPosition(Position,L,Piece,Cont1).


%checkValidInputs(ColumnOrigin,ColumnDest) :- ColumnOrigin >= get_code('A'), ColumnOrigin =< get_code('H'), ColumnDest >= get_code('A'), ColumnDest =< get_code('H'),
%												!
%												;
%												write('mal!'),
%												fail.

startGame(Board) :- gameCycle(Board,1).

gameCycle(Board,Player) :- repeat,
							write('Player '),  write(Player), write(' choose a piece'), nl,
      						write('Column = '), read(ColumnOrigin), nl,
      						write('Line = '), read(LineOrigin), isDigit(LineOrigin), nl,
      						write('Choose the destination'), nl,
      						write('Column = '), read(ColumnDest), nl,
      						write('Line = '), read(LineDest), isDigit(LineDest), nl,
      						checkValidPlay(Board,Player,ColumnOrigin,LineOrigin,ColumnDest,LineDest),
      						!,
      						write('end').



checkValidPlay(Board,Player,ColumnOrigin,LineOrigin,ColumnDest,LineDest) :- checkOwnPiece(Board,Player,ColumnOrigin,LineOrigin,Piece), checkDestination(Board,Piece,ColumnOrigin,LineOrigin,ColumnDest,LineDest,Poss), write('possibilities: '), write(Poss).

checkOwnPiece(Board,Player,ColumnOrigin,LineOrigin,Piece) :- (Player == 1 -> charToInt(ColumnOrigin,N), getPiece(Board,LineOrigin/N,Piece), member(Piece,['Q','T','B','H'])
														; 
														Player == 2 -> charToInt(ColumnOrigin,N), getPiece(Board,LineOrigin/N,Piece), member(Piece,['q','t','b','h'])).



%movePiece(player, oldBoard, iniRow, iniCol, endRow, endCol, newBoard) :- 
% ---MAL!---



%jogar(Xi-Yi/Xf-Yf,Board):-write(Xi).

%jogadaValida
%jogadaValida(Xi-Yi/Xf-Yf,Board):-dentroCampo(Xi-Yi/Xf-Yf,Board),verificarCor(Xi-Yi/Xf-Yf),verificarPiece(Xi-Yi/Xf-Yf).

%verificarCor(Xi-Yi/Xf-Yf):-eBranca(Xi-Yi),verificarAtacarPreta().
%verificarCor(Xi-Yi/Xf-Yf):-ePreta(Xi-Yi),verificarAtacarBranca().

%verificarPiece(Xi-Yi/Xf-Yf) :- retornarPiece(Xi-Yi,Piece), podeAtacar(Xi-Yi,Piece,Xf-Yf).