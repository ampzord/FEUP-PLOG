/*white queen - q */
/*black queen - Q */
/*white horse - h */
/*black horse - H */
/*white bishop - b */
/*black bishop - B */
/*white tower - t */
/*black tower - T */

board([
['  ','  ','  ','  ','  ','  ','  ','  '],
['  ','  ','  ','  ','  ','  ','  ','  '],
['  ','  ','  ','  ','  ','  ','  ','  '],
['  ','  ','  ','  ','  ','  ','  ','  '],
['  ','  ','  ','  ','  ','  ','  ','  '],
['  ','  ','  ','  ','  ','  ','  ','  '],
['  ','  ','  ','  ','  ','  ','  ','  '],
['  ','  ','  ','  ','  ','  ','  ','  ']
]).

boardWithPieces([
['Q','T','t','T','B','T','b','B'],
['T','H','t','h','T','h','b','Q'],
['q','h','H','B','h','q','T','Q'],
['q','B','B','q','b','Q','H','Q'],
['h','h','T','t','h','B','h','B'],
['B','H','t','t','b','Q','T','b'],
['t','q','H','b','q','q','H','Q'],
['H','b','Q','H','q','t','t','b']
]).

blackPieces(['Q','T','B','H']).
whitePieces(['q','t','b','h']).

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


% ---MAL!---
% ---MAL!---


isDigit(X) :-
    number(X),
    X >= 1,
    X =< 8,
    !
    ;
    fail.

checkValidInputs(ColumnOrigin,ColumnDest) :- ColumnOrigin >= get_code('A'), ColumnOrigin =< get_code('H'), ColumnDest >= get_code('A'), ColumnDest =< get_code('H'),
												!
												;
												write('fodeu!'),
												fail.

startGame(Board) :- gameCycle(Board,1).

gameCycle(Board,Player) :- repeat,
							write('Player '),  write(Player), write(' choose a piece'), nl,
      						write('Column = '), read(ColumnOrigin), nl,
      						write('Line = '), read(LineOrigin), isDigit(LineOrigin), nl,
      						write('Choose the destination'), nl,
      						write('Column = '), read(ColumnDest), nl,
      						write('Line = '), read(LineDest), isDigit(LineDest), nl,
      						checkValidInputs(ColumnOrigin,ColumnDest),
      						!,
      						write('sucess').
    						
    						%, checkValidPlay(Board,Player,ColumnOrigin,LineOrigin,ColumnDest,LineDest).




%checkValidPlay(Board,Player,ColumnOrigin,LineOrigin,ColumnDest,LineDest) :- checkOwnPiece(Board,Player,ColumnOrigin,LineOrigin)

%checkOwnPiece(Board,Player,ColumnOrigin,LineOrigin) :- (Player == 1, getPiece(Board,LineOrigin/ColumnOrigin,Piece), member(Piece,blackPieces))



%, checkValidPlay(player,ColumnOrigin,LineOrigin,ColumnDest,LineDest).

%movePiece(player, oldBoard, iniRow, iniCol, endRow, endCol, newBoard) :- 
% ---MAL!---



%jogar(Xi-Yi/Xf-Yf,Board):-write(Xi).

%jogadaValida
%jogadaValida(Xi-Yi/Xf-Yf,Board):-dentroCampo(Xi-Yi/Xf-Yf,Board),verificarCor(Xi-Yi/Xf-Yf),verificarPiece(Xi-Yi/Xf-Yf).

%verificarCor(Xi-Yi/Xf-Yf):-eBranca(Xi-Yi),verificarAtacarPreta().
%verificarCor(Xi-Yi/Xf-Yf):-ePreta(Xi-Yi),verificarAtacarBranca().

%verificarPiece(Xi-Yi/Xf-Yf) :- retornarPiece(Xi-Yi,Piece), podeAtacar(Xi-Yi,Piece,Xf-Yf).