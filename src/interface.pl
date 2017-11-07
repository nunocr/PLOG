%%%%%%%%%%%
%INTERFACE%
%%%%%%%%%%%

clearScreen :- write('\33\[2J').

mainMenuScreen :- 
clearScreen,
write('||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||'), nl,
write('||                          Go-Ro-Go                            ||'), nl,
write('||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||'), nl,
write('||                                                              ||'), nl,
write('||                                                              ||'), nl,
write('||                        1. Play                               ||'), nl,
write('||                        2. How To Play                        ||'), nl,
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
	Option =:= 1 -> playMenu;
	Option =:= 2 -> clearScreen, write('how to play menu'), nl;
	Option =:= 3 -> clearScreen, write('about menu'), nl;
	Option =:= 4;
	
	mainMenu
).

playMenuScreen :-
clearScreen,
write('||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||'), nl,
write('||                          Go-Ro-Go                            ||'), nl,
write('||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||'), nl,
write('||                                                              ||'), nl,
write('||                        Select Mode                           ||'), nl,
write('||                                                              ||'), nl,
write('||                    1. Human vs Human                         ||'), nl,
write('||                    2. Human vs Computer                      ||'), nl,
write('||                    3. Computer vs Computer                   ||'), nl,
write('||                    4. Back to Main Menu                      ||'), nl,
write('||                                                              ||'), nl,
write('||                                                              ||'), nl,
write('||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||'), nl.

playMenu :-
clearScreen,
playMenuScreen,
read(Option),
(
	Option =:= 1 -> printBoard; %mudar para startGame
	Option =:= 2 -> botDifficultyMenu;
	Option =:= 3 -> botDifficultyMenu;
	Option =:= 4 -> mainMenu;
	
	playMenu
).

botDifficultyScreen :-
clearScreen,
write('||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||'), nl,
write('||                          Go-Ro-Go                            ||'), nl,
write('||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||'), nl,
write('||                                                              ||'), nl,
write('||                     Select Difficulty                        ||'), nl,
write('||                                                              ||'), nl,
write('||                    1. Easy                                   ||'), nl,
write('||                    2. Hard                                   ||'), nl,
write('||                    3. Difficulty Info                        ||'), nl,
write('||                    4. Back to Mode Menu                      ||'), nl,
write('||                                                              ||'), nl,
write('||                                                              ||'), nl,
write('||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||'), nl.

botDifficultyMenu :-
clearScreen,
botDifficultyScreen,
read(Option),
(
	Option =:= 1 -> clearScreen, write('EZ PZ'), nl;
	Option =:= 2 -> clearScreen, write('DONEZO'), nl;
	Option =:= 3 -> difficultyMenu;
	Option =:= 4 -> playMenu;
	
	botDifficultyMenu
).

difficultyScreen :-
clearScreen,
write('||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||'), nl,
write('||                          Go-Ro-Go                              ||'), nl,
write('||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||'), nl,
write('||                                                                ||'), nl,
write('||                        Difficulty Info                         ||'), nl,
write('||                                                                ||'), nl,
write('||  You can assign two different difficulties to the computer:    ||'), nl,
write('||                                                                ||'), nl,
write('||  Easy: All plays made by the computer are random valid ones.   ||'), nl,
write('||  Hard: PC uses a greedy algorithm for the best available play. ||'), nl,
write('||                                                                ||'), nl,
write('||                  1. Back to Difficulty Selection               ||'), nl,
write('||                                                                ||'), nl,
write('||                                                                ||'), nl,
write('||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||'), nl.

difficultyMenu :-
clearScreen,
difficultyScreen,
read(Option),
(
	Option =:= 1 -> botDifficultyMenu;
	
	difficultyMenu
).