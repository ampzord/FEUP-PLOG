/*white queen - wq */
/*black queen - bq */
/*white horse - wh */
/*black horse - bh */
/*white bishop - wb */
/*black bishop - bb */
/*white tower - wt */
/*black tower - bt */

campo([
[wq,bt,wt,bt,bb,bt,wb,bb],
[bt,bh,wt,wh,bt,wh,wb,bq],
[wq,wh,bh,bb,wh,wq,bt,bq],
[wq,bb,bb,wq,wb,bq,bh,bq],
[wh,wh,bt,wt,wh,bb,wh,bb],
[bb,bh,wt,wt,wb,bq,bt,wb],
[wt,wq,bh,wb,wq,wq,bh,bq],
[bh,wb,bq,bh,wq,wt,wt,wb]
]).

listaBrancas([r,c,b,t]).
listaPretas([rr,cc,bb,tt]).

/*----impressao do campo de jogo*/

/*imprimirTabuleiro(lista correspondente ao campo)*/
imprimirTabuleiro(Campo):-write('  1  2  3  4  5  6  7  8  '), nl, imprimirCampo(Campo, 1), write('  A  B  C  D  E  F  G  H '), nl, nl, !.

imprimirCampo(_,9).
imprimirCampo(Campo,Linha):-write(Linha), imprimirLinha(Campo,Linha,1), write(' '), write(Linha), nl, LinhaAux is Linha + 1, imprimirCampo(Campo,LinhaAux).

imprimirLinha(_,_,9).
imprimirLinha(Campo,Linha,Coluna):-write(' '), obterPeca(Campo,Linha/Coluna,Peca), write(Peca), ColunaAux is Coluna + 1, imprimirLinha(Campo, Linha,ColunaAux).

obterPeca(Campo,Linha/Coluna,Peca):-elementoNaPosicao(Linha,Campo,L,1), elementoNaPosicao(Coluna,L,Peca,1).

elementoNaPosicao(Posicao,[X|_],X,Posicao).
elementoNaPosicao(Posicao,[_|L],Peca,Cont) :- Cont1 is Cont+1, elementoNaPosicao(Posicao,L,Peca,Cont1).




























jogar(Xi-Yi/Xf-Yf,Campo):-write(Xi).

/*jogadaValida
jogadaValida(Xi-Yi/Xf-Yf,Campo):-dentroCampo(Xi-Yi/Xf-Yf,Campo),verificarCor(Xi-Yi/Xf-Yf),verificarPeca(Xi-Yi/Xf-Yf).

verificarCor(Xi-Yi/Xf-Yf):-eBranca(Xi-Yi),verificarAtacarPreta().
verificarCor(Xi-Yi/Xf-Yf):-ePreta(Xi-Yi),verificarAtacarBranca().

verificarPeca(Xi-Yi/Xf-Yf):-retornarPeca(Xi-Yi,Peca),podeAtacar(Xi-Yi,Peca,Xf-Yf).