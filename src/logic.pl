%finish condition
gameLoop(_, 26, _, _) :- mainMenu, !.

%gameloop predicate
gameLoop(Board, Counter, Player1, Player2) :-

	clearScreen,
	printBoard(Board),
	
	write('Press ENTER to continue.'), nl,
	get_code(_),
	
	Counter1 is Counter + 1,
	write('Current turn: '),
	write(Counter1), nl,
	checkTurn(Counter1, Player1, Player2, CurrPlayer),
	printPlayer(CurrPlayer),
	askPlay(Board, CurrPlayer, BoardOut, CurrPlayerOut),
	
	nth1(1, CurrPlayer, CurrPlayerName),
	gameLoopDecider(CurrPlayerName, BoardOut, Counter1, CurrPlayerOut, Player1, Player2).

%game loop auxiliary
gameLoopDecider('white', BoardOut, Counter1, CurrPlayerOut, _, Player2) :- gameLoop(BoardOut, Counter1, CurrPlayerOut, Player2).
gameLoopDecider('black', BoardOut, Counter1, CurrPlayerOut, Player1, _) :- gameLoop(BoardOut, Counter1, Player1, CurrPlayerOut).
	
%fresh game start
startGame :-
	freshBoard(X),
	createPlayer(white, 10, 2, Player1, human),
	createPlayer(black, 10, 2, Player2, human),
	gameLoop(X, 0, Player1, Player2).
	
%creates a player
createPlayer(Name, Pieces, HengePieces, PlayerInfo, PlayerType) :- 
	PlayerInfo = [Name, Pieces, HengePieces, PlayerType].
	
%prints player info
printPlayer(Player) :-
	nth1(1, Player, PlayerName),
	printPlayerAux(PlayerName),
	nth1(2, Player, PlayerPieces),
	nth1(3, Player, PlayerHengePieces),
	write(PlayerPieces),
	write(' normal pieces, '),
	write(PlayerHengePieces),
	write(' henge pieces.'), nl.

%player print auxiliary
printPlayerAux('white') :- write('White player info: ').
printPlayerAux('black') :- write('Black player info: ').
	
%asks the user for a play
askPlay(BoardIn, CurrPlayer, BoardOut, CurrPlayerOut) :-
	nth1(1, CurrPlayer, PlayerName),
	write('Make a play, '), write(PlayerName), write(' player.'), nl,
	
	write('Which type of piece do you want to play? (1 for Normal, 2 for Henge)'), nl,
	
	repeat,
	read(PieceType),
	readPieceType(PieceType),
	!,
	
	repeat,
	write('Select Row: '),
	read(Row),
	get_code(_),
	write('Select Column: '),
	read(Col),
	get_code(_),
	checkBoard(BoardIn, Row, Col),
	!,
	
	selectPiece(PlayerName, PieceType, PieceToPlace),
	
	
	setPiece(BoardIn, Row, Col, PieceToPlace, BoardOut),
	removePieceFromPlayer(CurrPlayer, PieceType, CurrPlayerOut).
	
readPieceType(1) :- write('Selected normal piece'), nl.
readPieceType(2) :- write('Selected henge piece'), nl.
readPieceType(_) :- write('Wrong piece type, please try again!'), nl, !, fail.
	
	
%checks board
checkBoard(Board, Row, Col) :-
	checkBoardBounds(Row, Col),
	checkBoardSpot(Board, Row, Col).
	
checkBoardSpot(Board, Row, Col) :-
	getPiece(Board, Row, Col, 0).
	
	
%selects which piece to play
selectPiece('white', 1, 2).
selectPiece('black', 1, 1).
selectPiece(_, 2, 3).

%removes a piece from player, base case
removePieceFromPlayer([_, 0, 0, _, _], _, _) :- write('you lose.').

%removes normal piece from player
removePieceFromPlayer(Player, 1, PlayerOut) :- removeNormalPieceFromPlayer(Player, PlayerOut).

%removes henge piece from player
removePieceFromPlayer(Player, 2, PlayerOut) :- removeHengePieceFromPlayer(Player, PlayerOut).

removeNormalPieceFromPlayer(Player, PlayerOut) :-
	nth1(2, Player, NormalAmount),
	NewNormalAmount is NormalAmount - 1,
	updatePlayer(Player, 2, NewNormalAmount, PlayerOut).
	
removeHengePieceFromPlayer(Player, PlayerOut) :-
	nth1(3, Player, HengeAmount),
	NewHengeAmount is HengeAmount - 1,
	updatePlayer(Player, 3, NewHengeAmount, PlayerOut).

%updates a value in player list, base case
updatePlayer([_|T], 1, NewValue, [NewValue|T]).

%updates a value in player list, recursive case
updatePlayer([H|T], Index, NewValue, [H|R]) :-
	Index > 1,
	Index1 is Index - 1,
	updatePlayer(T, Index1, NewValue, R).
	
%checks who's turn it is, printing it
checkTurn(Counter, Player1, Player2, CurrPlayer) :-
	TurnAux is Counter mod 2,
	checkTurnAux(TurnAux, Player1, Player2, CurrPlayer).
	
checkTurnAux(0, Player1, _, CurrPlayer) :- CurrPlayer = Player1, write('White pieces turn.'), nl.
checkTurnAux(1, _, Player2, CurrPlayer) :- CurrPlayer = Player2, write('Black pieces turn.'), nl.
		
%checks if a coordinate is within board bounds
checkBoardBounds(Row, Col) :-
	checkNumberBounds(Row),
	checkNumberBounds(Col).

%checks if a number is between 1 and 5
checkNumberBounds(Number) :- Number > 0, Number =< 5.

%gets a piece from the board, given coordinates	
getPiece(Board, Row, Col, Val) :-  
	nth1(Row, Board, ARow), 
	nth1(Col, ARow, Val).

%prints the info about which piece was asked for	
printPieceInfo(Val) :-
	(
		Val =:= 0 -> write('That tile is empty.');
		Val =:= 1 -> write('That tile is occupied by a Black piece.');
		Val =:= 2 -> write('That tile is occupied by a White piece.');
		Val =:= 3 -> write('That tile is occupied by a Henge piece.')
	).

%setPiece
setPiece([L|Ls], 1, Y, Value, [R|Ls]) :- setPieceAux(L, Y, Value, R).

setPiece([L|Ls], X, Y, Value, [L|Rs]) :-
	X > 1,
	X1 is X - 1,
	setPiece(Ls, X1, Y, Value, Rs).
	
setPieceAux([_|Cs], 1, Value, [Value|Cs]).

setPieceAux([C|Cs], Y, Value, [C|Rs]) :-
	Y > 1,
	Y1 is Y - 1,
	setPieceAux(Cs, Y1, Value, Rs).

%teste
teste :-
	freshBoard(Board),
	printBoard(Board),
	write('Select Row: '),
	read(Row),
	get_code(_),
	write('Select Column: '),
	read(Col),
	get_code(_),
	setPiece(Board, Row, Col, 1, NewBoard),
	printBoard(NewBoard).