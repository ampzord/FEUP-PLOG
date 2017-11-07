
startProgram :- 	
					nl, write('---------------------------------'), nl,
					write('    Welcome to Massacre Chess    '), nl,
					write('---------------------------------'), nl, nl,
					menuCycle.

startMenu :-

	write('Choose an option:'), nl,
	write('1 - Player vs Player'), nl,
	write('2 - Player vs Computer'), nl,
	write('3 - Computer vs Computer'), nl, 
	write('4 - Leave Program'), nl, nl,
	read(MenuOption),
	(
		MenuOption == 1 -> write('player vs player'), nl;
		MenuOption == 2 -> write('player vs computer'), nl;
		MenuOption == 3 -> write('computer vs computer'), nl;
		MenuOption == 4 -> write('Exiting Program...'), nl;

		startMenu
	).

menuCycle :- repeat, 
		 		startMenu,
			 !,