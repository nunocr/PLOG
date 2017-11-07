getValueByIndex(XCoord, YCoord, ValueOut) :-
	midGameBoard(X),
	nth1(XCoord, X, BoardRow),
	nth1(YCoord, BoardRow, ValueOut).
	
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
	freshBoard(X),
	printBoard(X).
	
getBoardPiece(Board, Row, Col, Val) :-  
	nth1(Row, Mat, ARow), 
	nth1(Col, ARow, Val).
	