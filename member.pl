blackPieces :- ['Q','T','B','H'].
charToInt('A',Num) :- Num is 1.

member :- read(ColumnOrigin), member(ColumnOrigin,blackPieces).