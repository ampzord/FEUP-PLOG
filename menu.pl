

startProgram() :- 	write('---------------------------------'), nl,
					write('    Welcome to Massacre Chess    '), nl,
					write('---------------------------------'), nl,
					startMenu().


%I have to test this later.

startMenu() :- repeat,
			   write('Choose an option:'), nl,
			   write('1 - Player vs Player'), nl,
			   write('2 - Player vs Computer'), nl,
			   write('3 - Computer vs Computer'), nl,
			   read(menuOption),
			   isDigitInMenu(menuOption),
			   !,
			   goToGame(menuOption),

isDigitInMenu(X) :- number(X), X >= 1, X =< 3, ! ; fail.
