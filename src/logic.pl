gameLoop(Board, Counter) :-

	Counter < 25 
	->
	(
	printBoard,
	get_code(_),
	Counter1 is Counter + 1,
	write('Current turn: '),
	write(Counter1), nl,
	gameLoop(X1, Counter1)
	);
	
	(
	write('game finished.')
	).
	
startGame :-
	freshBoard(X),
	gameLoop(X, 0).
	
teste :-
	midGameBoard(Board),
	printBoard(Board),
	write('Select Row: '),
	read(Row),
	get_code(_),
	write('Select Column: '),
	read(Col),
	get_code(_),
	getBoardPiece(Board, Row, Col, Val),
	printBoardPieceInfo(Val).
	
getBoardPiece(Board, Row, Col, Val) :-  
	nth1(Row, Board, ARow), 
	nth1(Col, ARow, Val).
	
printBoardPieceInfo(Val) :-
	(
		Val =:= 0 -> write('That tile is empty.');
		Val =:= 1 -> write('That tile is occupied by a Black piece.');
		Val =:= 2 -> write('That tile is occupied by a White piece.');
		Val =:= 3 -> write('That tile is occupied by a Henge piece.')
	).