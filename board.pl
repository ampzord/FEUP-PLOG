/*white queen - wq */
/*black queen - bq */
/*white horse - wh */
/*black horse - bh */
/*white bishop - wb */
/*black bishop - bb */
/*white tower - wt */
/*black tower - bt */

board([
['  ','  ','  ','  ','  ','  ','  ','  '],
['  ','  ','  ','  ','  ','  ','  ','  '],
['  ','  ','  ','  ','  ','  ','  ','  '],
['  ','  ','  ','  ','  ','  ','  ','  '],
['  ','  ','  ','  ','  ','  ','  ','  '],
['  ','  ','  ','  ',bb,'  ','  ','  '],
['  ','  ','  ','  ','  ','  ','  ','  '],
['  ','  ',bh,'  ','  ','  ','  ','  ']
]).

%listaBrancas([r,c,b,t]).
%listaPretas([rr,cc,bb,tt]).

printBoard(Board):-write('  1  2  3  4  5  6  7  8  '), nl, printField(Board, 1), write('  A  B  C  D  E  F  G  H '), nl, nl, !.

printField(_,9).
printField(Board,Line):-write(Line), 
						printLine(Board,Line,1), 
						write(' '), write(Line), 
						nl, 
						LineAux is Line + 1, 
						printField(Board,LineAux).

printLine(_,_,9).
printLine(Board,Line,Column):- write(' '), 
								getPiece(Board,Line/Column,Piece), 
								write(Piece), 
								ColumnAux is Column + 1, 
								printLine(Board, Line,ColumnAux).

getPiece(Board,Line/Column,Piece):-elementInPosition(Line,Board,L,1), 
									elementInPosition(Column,L,Piece,1).

elementInPosition(Position,[X|_],X,Position).
elementInPosition(Position,[_|L],Piece,Cont) :- Cont1 is Cont+1, elementInPosition(Position,L,Piece,Cont1).


jogar(Xi-Yi/Xf-Yf,Board):-write(Xi).

/*jogadaValida
jogadaValida(Xi-Yi/Xf-Yf,Board):-dentroCampo(Xi-Yi/Xf-Yf,Board),verificarCor(Xi-Yi/Xf-Yf),verificarPiece(Xi-Yi/Xf-Yf).

verificarCor(Xi-Yi/Xf-Yf):-eBranca(Xi-Yi),verificarAtacarPreta().
verificarCor(Xi-Yi/Xf-Yf):-ePreta(Xi-Yi),verificarAtacarBranca().

verificarPiece(Xi-Yi/Xf-Yf) :- retornarPiece(Xi-Yi,Piece), podeAtacar(Xi-Yi,Piece,Xf-Yf).