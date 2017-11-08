%gameloop predicate
gameLoop(Board, Counter, Player1, Player2) :-

	Counter < 25 
	->
	(
	clearScreen,
	printBoard(Board),
	get_code(_),
	Counter1 is Counter + 1,
	write('Current turn: '),
	write(Counter1), nl,
	checkTurn(Counter1, Player1, Player2, CurrPlayer),
	printPlayer(CurrPlayer),
	askPlay(Board, CurrPlayer),
	gameLoop(Board, Counter1, Player1, Player2)
	);
	
	(
	write('game finished.')
	).
	
%fresh game start
startGame :-
	freshBoard(X),
	createPlayer(white, 10, 2, Player1),
	createPlayer(black, 10, 2, Player2),
	gameLoop(X, 0, Player1, Player2).
	
%creates a player
createPlayer(Name, Pieces, HengePieces, PlayerInfo) :- 
	PlayerInfo = [Name, Pieces, HengePieces].
	
%prints player info
printPlayer(Player) :-
	nth1(1, Player, PlayerName),
	(
		PlayerName == 'white' -> write('White player info: ');
		PlayerName == 'black' -> write('Black player info: ')
	),
	nth1(2, Player, PlayerPieces),
	nth1(3, Player, PlayerHengePieces),
	write(PlayerPieces),
	write(' normal pieces, '),
	write(PlayerHengePieces),
	write(' henge pieces.'), nl.
	
%asks the user for a play
askPlay(BoardIn, CurrPlayer) :-
	nth1(1, CurrPlayer, PlayerName),
	write('Make a play, '), write(PlayerName), write(' player.'), nl,
	
	write('Which type of piece do you want to play? (1 for Normal, 2 for Henge)'), nl,
	
	repeat,
	read(PieceType),
	(
		PieceType =:= 1 -> (write('Selected normal piece'), nl);
		PieceType =:= 2 -> (write('Selected henge piece'), nl)
	),
	!,
	
	repeat,
	write('Select Row: '),
	read(Row),
	get_code(_),
	write('Select Column: '),
	read(Col),
	get_code(_),
	checkBoardBounds(Row, Col),
	!,
	
	getPiece(BoardIn, Row, Col, Val),
	printPieceInfo(Val).
	
%checks who's turn it is, printing it
checkTurn(Counter, Player1, Player2, CurrPlayer) :-
	TurnAux is Counter mod 2,
	(
		TurnAux =:= 0 -> (CurrPlayer = Player1, write('White pieces turn.'), nl);
		TurnAux =:= 1 -> (CurrPlayer = Player2, write('Black pieces turn.'), nl)
	).
		
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

%teste
teste :-
	midGameBoard(Board),
	printBoard(Board),
	write('Select Row: '),
	read(Row),
	get_code(_),
	write('Select Column: '),
	read(Col),
	get_code(_),
	getPiece(Board, Row, Col, Val),
	printPieceInfo(Val).