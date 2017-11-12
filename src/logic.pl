%finish condition
gameLoop(_, 26, _, _) :- mainMenu, !.

gameLoop(_, _, [_, 0, _, _], [_, _, _, _]) :- gameOverMenu('Black', 'Out of normal pieces.').

gameLoop(_, _, [_, _, _, _], [_, 0, _, _]) :- gameOverMenu('White', 'Out of normal pieces.').

%first round henge placing
gameLoop(Board, -1, Player1, Player2) :-

	clearScreen,
	printBoard(Board),
	write('White player has to place the last henge piece available'), nl,
	
	repeat,
	write('Select Row: '),
	read(Row),
	get_code(_),
	write('Select Column: '),
	read(Col),
	get_code(_),
	checkBoard(Board, Row, Col, Player1, Return),
	write(Return), nl,
	!,
	
	setPiece(Board, Row, Col, 3, BoardOut),
	gameLoop(BoardOut, 0, Player1, Player2).

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
	
	repeat,
	askPlay(Board, CurrPlayer, BoardOut, CurrPlayerOut),
	!,
	
	updateBoard(BoardOut, CurrPlayer, BoardOut2),
	
	nth1(1, CurrPlayer, CurrPlayerName),
	gameLoopDecider(CurrPlayerName, BoardOut2, Counter1, CurrPlayerOut, Player1, Player2).

%game loop auxiliary
gameLoopDecider('white', BoardOut, Counter1, CurrPlayerOut, _, Player2) :- gameLoop(BoardOut, Counter1, CurrPlayerOut, Player2).
gameLoopDecider('black', BoardOut, Counter1, CurrPlayerOut, Player1, _) :- gameLoop(BoardOut, Counter1, Player1, CurrPlayerOut).
	
%fresh game start
startGame :-
	freshBoard(X),
	createPlayer(white, 10, 2, Player1, human),
	createPlayer(black, 10, 2, Player2, human),
	gameLoop(X, -1, Player1, Player2).
	
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
	checkBoard(BoardIn, Row, Col, CurrPlayer, Return),
	write('Return = '), write(Return), nl,
	!,
	
	selectPiece(PlayerName, PieceType, PieceToPlace),
	
	setPiece(BoardIn, Row, Col, PieceToPlace, BoardOut),
	removePieceFromPlayer(CurrPlayer, PieceType, CurrPlayerOut).
	
readPieceType(1) :- write('Selected normal piece'), nl.
readPieceType(2) :- write('Selected henge piece'), nl.
readPieceType(_) :- write('Wrong piece type, please try again!'), nl, !, fail.
	
%checks board
checkBoard(Board, Row, Col, CurrPlayer, Return) :-
	checkBoardBounds(Row, Col), !,
	checkBoardSpot(Board, Row, Col), !,
	checkBoardSurroundings(Board, Row, Col, CurrPlayer, Return).
	
checkBoardSpot(Board, Row, Col) :-
	getPiece(Board, Row, Col, 0).

checkBoardSpot(_, _, _)	:- write('That coordinate is already occupied by a piece, try again!'), nl, !, fail.
	
checkBoardSurroundings(Board, 1, 1, CurrPlayer, Return) :- checkBoardTopLeft(Board, 1, 1, CurrPlayer, Return).
checkBoardSurroundings(Board, 5, 1, CurrPlayer, Return) :- checkBoardBotLeft(Board, 5, 1, CurrPlayer, Return).
checkBoardSurroundings(Board, 1, 5, CurrPlayer, Return) :- checkBoardTopRight(Board, 1, 5, CurrPlayer, Return).
checkBoardSurroundings(Board, 5, 5, CurrPlayer, Return) :- checkBoardBotRight(Board, 5, 5, CurrPlayer, Return).
checkBoardSurroundings(Board, 1, Col, CurrPlayer, Return) :- checkBoardTop(Board, 1, Col, CurrPlayer, Return).
checkBoardSurroundings(Board, 5, Col, CurrPlayer, Return) :- checkBoardBot(Board, 5, Col, CurrPlayer, Return).
checkBoardSurroundings(Board, Row, 5, CurrPlayer, Return) :- checkBoardRight(Board, Row, 5, CurrPlayer, Return).
checkBoardSurroundings(Board, Row, 1, CurrPlayer, Return) :- checkBoardLeft(Board, Row, 1, CurrPlayer, Return).
checkBoardSurroundings(Board, Row, Col, CurrPlayer, Return) :- checkBoardMiddle(Board, Row, Col, CurrPlayer, Return).

checkBoardMiddle(Board, Row, Col, CurrPlayer, Return) :-
	nth1(1, CurrPlayer, PlayerName),
	selectPiece(PlayerName, 1, CurrPlayerPiece),
	
	Row > 1, Row < 5,
	Col > 1, Col < 5,
	
	ColRight is Col + 1,
	ColLeft is Col - 1,
	RowUp is Row + 1,
	RowDown is Row - 1, !,
	
	getPiece(Board, RowUp, Col, UpperPiece),
	getPiece(Board, RowDown, Col, BottomPiece),
	getPiece(Board, Row, ColLeft, LeftPiece),
	getPiece(Board, Row, ColRight, RightPiece),
	checkSurroundingPiecesMid(CurrPlayerPiece, UpperPiece, BottomPiece, LeftPiece, RightPiece, Return).
	
checkBoardLeft(Board, Row, 1, CurrPlayer, Return) :-
	nth1(1, CurrPlayer, PlayerName),
	selectPiece(PlayerName, 1, CurrPlayerPiece),
	
	RowUp is Row + 1,
	RowDown is Row - 1, !,
	
	getPiece(Board, RowUp, 1, UpperPiece),
	getPiece(Board, RowDown, 1, BottomPiece),
	getPiece(Board, Row, 2, RightPiece),
	checkSurroundingPiecesSides(CurrPlayerPiece, UpperPiece, BottomPiece, RightPiece, Return).
	
checkBoardRight(Board, Row, 5, CurrPlayer, Return) :-
	nth1(1, CurrPlayer, PlayerName),
	selectPiece(PlayerName, 1, CurrPlayerPiece),
	
	RowUp is Row + 1,
	RowDown is Row - 1, !,
	
	getPiece(Board, RowUp, 5, UpperPiece),
	getPiece(Board, RowDown, 5, BottomPiece),
	getPiece(Board, Row, 4, LeftPiece),
	checkSurroundingPiecesSides(CurrPlayerPiece, UpperPiece, BottomPiece, LeftPiece, Return).
	
checkBoardTop(Board, 1, Col, CurrPlayer, Return) :-
	nth1(1, CurrPlayer, PlayerName),
	selectPiece(PlayerName, 1, CurrPlayerPiece),
	
	ColLeft is Col - 1,
	ColRight is Col + 1,
	
	getPiece(Board, 1, ColLeft, LeftPiece),
	getPiece(Board, 1, ColRight, RightPiece),
	getPiece(Board, 2, Col, BottomPiece),
	checkSurroundingPiecesSides(CurrPlayerPiece, LeftPiece, RightPiece, BottomPiece, Return).
	
checkBoardBot(Board, 5, Col, CurrPlayer, Return) :-
	nth1(1, CurrPlayer, PlayerName),
	selectPiece(PlayerName, 1, CurrPlayerPiece),
	
	ColLeft is Col - 1,
	ColRight is Col + 1,
	
	getPiece(Board, 1, ColLeft, LeftPiece),
	getPiece(Board, 1, ColRight, RightPiece),
	getPiece(Board, 4, Col, TopPiece),
	checkSurroundingPiecesSides(CurrPlayerPiece, LeftPiece, RightPiece, TopPiece, Return).
	
checkBoardTopLeft(Board, 1, 1, CurrPlayer, Return) :-
	nth1(1, CurrPlayer, PlayerName),
	selectPiece(PlayerName, 1, CurrPlayerPiece),
	
	getPiece(Board, 1, 2, RightPiece),
	getPiece(Board, 2, 1, BottomPiece),
	checkSurroundingPiecesCorner(CurrPlayerPiece, RightPiece, BottomPiece, Return).
	
checkBoardTopRight(Board, 1, 5, CurrPlayer, Return) :-
	nth1(1, CurrPlayer, PlayerName),
	selectPiece(PlayerName, 1, CurrPlayerPiece),
	
	getPiece(Board, 1, 4, LeftPiece),
	getPiece(Board, 2, 5, BottomPiece),
	checkSurroundingPiecesCorner(CurrPlayerPiece, LeftPiece, BottomPiece, Return).
	
checkBoardBotLeft(Board, 5, 1, CurrPlayer, Return) :-
	nth1(1, CurrPlayer, PlayerName),
	selectPiece(PlayerName, 1, CurrPlayerPiece),
	
	getPiece(Board, 5, 2, RightPiece),
	getPiece(Board, 4, 1, UpperPiece),
	checkSurroundingPiecesCorner(CurrPlayerPiece, RightPiece, UpperPiece, Return).
	
checkBoardBotRight(Board, 5, 5, CurrPlayer, Return) :-
	nth1(1, CurrPlayer, PlayerName),
	selectPiece(PlayerName, 1, CurrPlayerPiece),
	
	getPiece(Board, 5, 4, LeftPiece),
	getPiece(Board, 4, 5, UpperPiece),
	checkSurroundingPiecesCorner(CurrPlayerPiece, LeftPiece, UpperPiece, Return).
	
getOpponentName('white', 'black').
getOpponentName('black', 'white').	
	
%selects which piece to play
selectPiece('white', 1, 2).
selectPiece('black', 1, 1).
selectPiece(_, 2, 3).
selectOppNormalPiece('white', 1).
selectOppNormalPiece('black', 2).

checkForEating(Board, Piece, Row, Col, BoardOut) :- Row =:= 1, Col =:= 1, checkForEatingTopLeft(Board, Piece, Row, Col, BoardOut).
checkForEating(Board, Piece, Row, Col, BoardOut) :- Row =:= 1, Col =:= 5, checkForEatingTopRight(Board, Piece, Row, Col, BoardOut).
checkForEating(Board, Piece, Row, Col, BoardOut) :- Row =:= 5, Col =:= 1, checkForEatingBotLeft(Board, Piece, Row, Col, BoardOut).
checkForEating(Board, Piece, Row, Col, BoardOut) :- Row =:= 5, Col =:= 5, checkForEatingBotRight(Board, Piece, Row, Col, BoardOut).
checkForEating(Board, Piece, Row, Col, BoardOut) :- Row =:= 1, checkForEatingTop(Board, Piece, Row, Col, BoardOut).
checkForEating(Board, Piece, Row, Col, BoardOut) :- Row =:= 5, checkForEatingBot(Board, Piece, Row, Col, BoardOut).
checkForEating(Board, Piece, Row, Col, BoardOut) :- Col =:= 1, checkForEatingLeft(Board, Piece, Row, Col, BoardOut).
checkForEating(Board, Piece, Row, Col, BoardOut) :- Col =:= 5, checkForEatingRight(Board, Piece, Row, Col, BoardOut).
checkForEating(Board, Piece, Row, Col, BoardOut) :- checkForEatingMiddle(Board, Piece, Row, Col, BoardOut).
	
checkForEatingTop(Board, Piece, Row, Col, BoardOut) :-
	ColLeft is Col - 1,
	ColRight is Col + 1,
	RowBot is Row + 1, !,
	
	getPiece(Board, Row, ColLeft, LeftPiece),
	getPiece(Board, Row, ColRight, RightPiece),
	getPiece(Board, RowBot, Col, BottomPiece),
	checkEatingPiecesSides(Board, Row, Col, Piece, LeftPiece, RightPiece, BottomPiece, BoardOut).
	
checkForEatingBot(Board, Piece, Row, Col, BoardOut) :-
	ColLeft is Col - 1,
	ColRight is Col + 1,
	RowUp is Row - 1, !,
	
	getPiece(Board, Row, ColLeft, LeftPiece),
	getPiece(Board, Row, ColRight, RightPiece),
	getPiece(Board, RowUp, Col, TopPiece),
	checkEatingPiecesSides(Board, Row, Col, Piece, LeftPiece, RightPiece, TopPiece, BoardOut).
	
checkForEatingLeft(Board, Piece, Row, Col, BoardOut) :-
	RowUp is Row + 1,
	RowDown is Row - 1,
	ColRight is Col + 1, !,
	
	getPiece(Board, RowUp, Col, UpperPiece),
	getPiece(Board, RowDown, Col, BottomPiece),
	getPiece(Board, Row, ColRight, RightPiece),
	checkEatingPiecesSides(Board, Row, Col, Piece, UpperPiece, BottomPiece, RightPiece, BoardOut).
	
checkForEatingRight(Board, Piece, Row, Col, BoardOut) :-
	RowUp is Row + 1,
	RowDown is Row - 1,
	ColLeft is Col - 1, !,
	
	getPiece(Board, RowUp, Col, UpperPiece),
	getPiece(Board, RowDown, Col, BottomPiece),
	getPiece(Board, Row, ColLeft, LeftPiece),
	checkEatingPiecesSides(Board, Row, Col, Piece, UpperPiece, BottomPiece, LeftPiece, BoardOut).

checkForEatingTopLeft(Board, Piece, Row, Col, BoardOut) :-
	ColRight is Col + 1,
	RowBot is Row + 1, !,

	getPiece(Board, Row, ColRight, RightPiece),
	getPiece(Board, RowBot, Col, BottomPiece),
	checkEatingPiecesCorner(Board, Row, Col, Piece, RightPiece, BottomPiece, BoardOut).
	
checkForEatingTopRight(Board, Piece, Row, Col, BoardOut) :-
	ColLeft is Col - 1,
	RowBot is Row + 1, !,

	getPiece(Board, Row, ColLeft, LeftPiece),
	getPiece(Board, RowBot, Col, BottomPiece),
	checkEatingPiecesCorner(Board, Row, Col, Piece, LeftPiece, BottomPiece, BoardOut).
	
checkForEatingBotLeft(Board, Piece, Row, Col, BoardOut) :-
	ColRight is Col + 1,
	RowUp is Row - 1, !,

	getPiece(Board, Row, ColRight, RightPiece),
	getPiece(Board, RowUp, Col, UpperPiece),
	checkEatingPiecesCorner(Board, Row, Col, Piece, RightPiece, UpperPiece, BoardOut).
	
checkForEatingBotRight(Board, Piece, Row, Col, BoardOut) :-
	ColLeft is Col - 1,
	RowUp is Row - 1, !,

	getPiece(Board, Row, ColLeft, LeftPiece),
	getPiece(Board, RowUp, Col, UpperPiece),
	checkEatingPiecesCorner(Board, Row, Col, Piece, LeftPiece, UpperPiece, BoardOut).
	
checkForEatingMiddle(Board, Piece, Row, Col, BoardOut) :-
	Row > 1, Row < 5,
	Col > 1, Col < 5,
	
	ColRight is Col + 1,
	ColLeft is Col - 1,
	RowUp is Row + 1,
	RowDown is Row - 1, !,
	
	getPiece(Board, RowUp, Col, UpperPiece),
	getPiece(Board, RowDown, Col, BottomPiece),
	getPiece(Board, Row, ColLeft, LeftPiece),
	getPiece(Board, Row, ColRight, RightPiece),
	checkEatingPiecesMiddle(Board, Row, Col, Piece, UpperPiece, BottomPiece, LeftPiece, RightPiece, BoardOut).
	
updateBoard(BoardIn, CurrPlayer, BoardOut) :-
	updateRow(BoardIn, CurrPlayer, BoardOut1, 1),
	updateRow(BoardOut1, CurrPlayer, BoardOut2, 2),
	updateRow(BoardOut2, CurrPlayer, BoardOut3, 3),
	updateRow(BoardOut3, CurrPlayer, BoardOut4, 4),
	updateRow(BoardOut4, CurrPlayer, BoardOut, 5).
	
updateRow(BoardIn, CurrPlayer, BoardOut, Row) :-
	nth1(1, CurrPlayer, PlayerName),
	selectOppNormalPiece(PlayerName, OppPiece),
	checkForEating(BoardIn, OppPiece, Row, 1, BoardOut1),
	checkForEating(BoardOut1, OppPiece, Row, 2, BoardOut2),
	checkForEating(BoardOut2, OppPiece, Row, 3, BoardOut3),
	checkForEating(BoardOut3, OppPiece, Row, 4, BoardOut4),
	checkForEating(BoardOut4, OppPiece, Row, 5, BoardOut).

%removes a piece from player, base case
%removePieceFromPlayer([_, 0, _, _, _], _, _) :- mainMenu.

%removes normal piece from player
removePieceFromPlayer(Player, 1, PlayerOut) :- removeNormalPieceFromPlayer(Player, PlayerOut).

%removes henge piece from player
removePieceFromPlayer(Player, 2, PlayerOut) :- removeHengePieceFromPlayer(Player, PlayerOut).

removeNormalPieceFromPlayer(Player, PlayerOut) :-
	nth1(2, Player, NormalAmount),
	NewNormalAmount is NormalAmount - 1,
	updatePlayer(Player, 2, NewNormalAmount, PlayerOut).
	
removeHengePieceFromPlayer([_, _, 0, _], _) :- write('No henge pieces available!'), nl, !, fail.
	
removeHengePieceFromPlayer(Player, PlayerOut) :-
	nth1(3, Player, HengeAmount),
	NewHengeAmount is HengeAmount - 1,
	updatePlayer(Player, 3, NewHengeAmount, PlayerOut).
	
removePieceFromBoard(Board, Row, Col, BoardOut) :- 
	setPiece(Board, Row, Col, 0, BoardOut).

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
checkNumberBounds(_) :- write('That coordinate is out of bounds, try again!'), nl, !, fail.

%gets a piece from the board, given coordinates	
getPiece(Board, Row, Col, Val) :-  
	nth1(Row, Board, ARow), 
	nth1(Col, ARow, Val).

%prints the info about which piece was asked for	
printPieceInfo(0) :- write('That tile is empty.').
printPieceInfo(1) :- write('That tile is occupied by a Black piece.').
printPieceInfo(2) :- write('That tile is occupied by a White piece.').
printPieceInfo(3) :- write('That tile is occupied by a Henge piece.').
printPieceInfo(_) :- write('Error'), nl, !, fail.

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
	testBoard(Board),
	printBoard(Board),
	get_code(_),
	checkForEating(Board, 1, 3, 3, BoardOut),
	write(Board), nl,
	write(BoardOut), nl,
	printBoard(BoardOut).