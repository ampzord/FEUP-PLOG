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

isDigit(X) :- number(X), X >= 1, X =< 8, ! ;fail.

charToInt('A',Num) :- Num is 1.
charToInt('B',Num) :- Num is 2.
charToInt('C',Num) :- Num is 3.
charToInt('D',Num) :- Num is 4.
charToInt('E',Num) :- Num is 5.
charToInt('F',Num) :- Num is 6.
charToInt('G',Num) :- Num is 7.
charToInt('H',Num) :- Num is 8.