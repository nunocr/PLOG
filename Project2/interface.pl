%%%%%%%%%%%
%INTERFACE%
%%%%%%%%%%%

clearScreen :- write('\33\[2J').

mainMenuScreen :-
clearScreen,
write('||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||'), nl,
write('||                      Schedule Distribution                   ||'), nl,
write('||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||'), nl,
write('||                                                              ||'), nl,
write('||                                                              ||'), nl,
write('||                        1. Get Schedule                       ||'), nl,
write('||                        2. Set Parameters                     ||'), nl,
write('||                        3. About                              ||'), nl,
write('||                        4. Exit                               ||'), nl,
write('||                                                              ||'), nl,
write('||                                                              ||'), nl,
write('||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||'), nl.

mainMenu :-
clearScreen,
mainMenuScreen,
read(Option),
(
	Option =:= 1 -> getSchedule;
	Option =:= 2 -> setParameters;
	Option =:= 3 -> about;
	Option =:= 4;

	mainMenu
).

aboutScreen :-
clearScreen,
write('||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||'), nl,
write('||                      Schedule Distribution                     ||'), nl,
write('||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||'), nl,
write('||                                                                ||'), nl,
write('||                            About                               ||'), nl,
write('||                                                                ||'), nl,
write('||  A little something to organize teacher schedules, developed   ||'), nl,
write('||            in the Logic Programming classes @ FEUP.            ||'), nl,
write('||                                                                ||'), nl,
write('||                      1. Back to Main Menu                      ||'), nl,
write('||                                                                ||'), nl,
write('||                                                                ||'), nl,
write('||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||'), nl.

aboutMenu :-
clearScreen,
aboutScreen,
read(Option),
(
	Option =:= 1 -> mainMenu;

	aboutMenu
).
