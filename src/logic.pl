%finish condition
gameLoop(_, 26, _, _) :- mainMenu, !.

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
	checkBoard(Board, Row, Col, Player1),
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
	checkBoard(BoardIn, Row, Col, CurrPlayer),
	!,
	
	selectPiece(PlayerName, PieceType, PieceToPlace),
	
	setPiece(BoardIn, Row, Col, PieceToPlace, BoardOut),
	removePieceFromPlayer(CurrPlayer, PieceType, CurrPlayerOut).
	
readPieceType(1) :- write('Selected normal piece'), nl.
readPieceType(2) :- write('Selected henge piece'), nl.
readPieceType(_) :- write('Wrong piece type, please try again!'), nl, !, fail.
	
%checks board
checkBoard(Board, Row, Col, CurrPlayer) :-
	checkBoardBounds(Row, Col), !,
	checkBoardSpot(Board, Row, Col), !,
	checkBoardSurroundings(Board, Row, Col, CurrPlayer).
	
checkBoardSpot(Board, Row, Col) :-
	getPiece(Board, Row, Col, 0).

checkBoardSpot(_, _, _)	:- write('That coordinate is already occupied by a piece, try again!'), nl, !, fail.
	
checkBoardSurroundings(Board, 1, 1, CurrPlayer) :- checkBoardTopLeft(Board, 1, 1, CurrPlayer).
checkBoardSurroundings(Board, 5, 1, CurrPlayer) :- checkBoardBotLeft(Board, 5, 1, CurrPlayer).
checkBoardSurroundings(Board, 1, 5, CurrPlayer) :- checkBoardTopRight(Board, 1, 5, CurrPlayer).
checkBoardSurroundings(Board, 5, 5, CurrPlayer) :- checkBoardBotRight(Board, 5, 5, CurrPlayer).
checkBoardSurroundings(Board, 1, Col, CurrPlayer) :- checkBoardTop(Board, 1, Col, CurrPlayer).
checkBoardSurroundings(Board, 5, Col, CurrPlayer) :- checkBoardBot(Board, 5, Col, CurrPlayer).
checkBoardSurroundings(Board, Row, 5, CurrPlayer) :- checkBoardRight(Board, Row, 5, CurrPlayer).
checkBoardSurroundings(Board, Row, 1, CurrPlayer) :- checkBoardLeft(Board, Row, 1, CurrPlayer).
checkBoardSurroundings(Board, Row, Col, CurrPlayer) :- checkBoardMiddle(Board, Row, Col, CurrPlayer).


checkBoardMiddle(Board, Row, Col, CurrPlayer) :-
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
	checkSurroundingPiecesMid(CurrPlayerPiece, UpperPiece, BottomPiece, LeftPiece, RightPiece).
	
checkBoardLeft(Board, Row, 1, CurrPlayer) :-
	nth1(1, CurrPlayer, PlayerName),
	selectPiece(PlayerName, 1, CurrPlayerPiece),
	
	RowUp is Row + 1,
	RowDown is Row - 1, !,
	
	getPiece(Board, RowUp, 1, UpperPiece),
	getPiece(Board, RowDown, 1, BottomPiece),
	getPiece(Board, Row, 2, RightPiece),
	checkSurroundingPiecesSides(CurrPlayerPiece, UpperPiece, BottomPiece, RightPiece).
	
checkBoardRight(Board, Row, 5, CurrPlayer) :-
	nth1(1, CurrPlayer, PlayerName),
	selectPiece(PlayerName, 1, CurrPlayerPiece),
	
	RowUp is Row + 1,
	RowDown is Row - 1, !,
	
	getPiece(Board, RowUp, 1, UpperPiece),
	getPiece(Board, RowDown, 1, BottomPiece),
	getPiece(Board, Row, 5, LeftPiece),
	checkSurroundingPiecesSides(CurrPlayerPiece, UpperPiece, BottomPiece, LeftPiece).
	
checkBoardTop(Board, 1, Col, CurrPlayer) :-
	nth1(1, CurrPlayer, PlayerName),
	selectPiece(PlayerName, 1, CurrPlayerPiece),
	
	ColLeft is Col - 1,
	ColRight is Col + 1,
	
	getPiece(Board, 1, ColLeft, LeftPiece),
	getPiece(Board, 1, ColRight, RightPiece),
	getPiece(Board, 2, Col, BottomPiece),
	checkSurroundingPiecesSides(CurrPlayerPiece, LeftPiece, RightPiece, BottomPiece).
	
checkBoardBot(Board, 5, Col, CurrPlayer) :-
	nth1(1, CurrPlayer, PlayerName),
	selectPiece(PlayerName, 1, CurrPlayerPiece),
	
	ColLeft is Col - 1,
	ColRight is Col + 1,
	
	getPiece(Board, 1, ColLeft, LeftPiece),
	getPiece(Board, 1, ColRight, RightPiece),
	getPiece(Board, 4, Col, TopPiece),
	checkSurroundingPiecesSides(CurrPlayerPiece, LeftPiece, RightPiece, TopPiece).
	
checkBoardTopLeft(Board, 1, 1, CurrPlayer) :-
	nth1(1, CurrPlayer, PlayerName),
	selectPiece(PlayerName, 1, CurrPlayerPiece),
	
	getPiece(Board, 1, 2, RightPiece),
	getPiece(Board, 2, 1, BottomPiece),
	%write(RightPiece), write(' - '), write(BottomPiece),
	%readSymbol(RightPiece, X),
	%readSymbol(BottomPiece, Y),
	%write(RightPiece), write(' - '), write(X),
	%write(BottomPiece), write(' - '), write(Y),
	%get_code(_),
	checkSurroundingPiecesCorner(CurrPlayerPiece, RightPiece, BottomPiece).
	
checkBoardTopRight(Board, 1, 5, CurrPlayer) :-
	nth1(1, CurrPlayer, PlayerName),
	selectPiece(PlayerName, 1, CurrPlayerPiece),
	
	getPiece(Board, 1, 4, LeftPiece),
	getPiece(Board, 2, 4, BottomPiece),
	checkSurroundingPiecesCorner(CurrPlayerPiece, LeftPiece, BottomPiece).
	
checkBoardBotLeft(Board, 5, 1, CurrPlayer) :-
	nth1(1, CurrPlayer, PlayerName),
	selectPiece(PlayerName, 1, CurrPlayerPiece),
	
	getPiece(Board, 5, 2, RightPiece),
	getPiece(Board, 4, 1, UpperPiece),
	checkSurroundingPiecesCorner(CurrPlayerPiece, RightPiece, UpperPiece).
	
checkBoardBotRight(Board, 5, 5, CurrPlayer) :-
	nth1(1, CurrPlayer, PlayerName),
	selectPiece(PlayerName, 1, CurrPlayerPiece),
	
	getPiece(Board, 5, 4, LeftPiece),
	getPiece(Board, 4, 5, UpperPiece),
	checkSurroundingPiecesCorner(CurrPlayerPiece, LeftPiece, UpperPiece).
	
checkSurroundingPiecesMid(1, 2, 2, 2, 2) :- write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesMid(1, 3, 2, 2, 2) :- write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesMid(1, 2, 3, 2, 2) :- write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesMid(1, 2, 2, 3, 2) :- write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesMid(1, 2, 2, 2, 3) :- write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesMid(1, 3, 3, 2, 2) :- write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesMid(1, 3, 2, 3, 2) :- write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesMid(1, 3, 2, 2, 3) :- write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesMid(1, 3, 3, 3, 2) :- write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesMid(1, 3, 3, 2, 3) :- write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesMid(1, 3, 3, 3, 3) :- write('That coordinate is surrounded by henge pieces!'), nl, !, fail.
checkSurroundingPiecesMid(1, _, _, _, _) :- write('Successful black play!'), nl.
checkSurroundingPiecesMid(2, 1, 1, 1, 1) :- write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesMid(2, 3, 1, 1, 1) :- write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesMid(2, 1, 3, 1, 1) :- write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesMid(2, 1, 1, 3, 1) :- write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesMid(2, 1, 1, 1, 3) :- write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesMid(2, 3, 3, 1, 1) :- write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesMid(2, 3, 1, 3, 1) :- write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesMid(2, 3, 1, 1, 3) :- write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesMid(2, 3, 3, 3, 1) :- write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesMid(2, 3, 3, 1, 3) :- write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesMid(2, 3, 3, 3, 3) :- write('That coordinate is surrounded by henge pieces!'), nl, !, fail.
checkSurroundingPiecesMid(2, _, _, _, _) :- write('Successful white play!'), nl.
checkSurroundingPiecesMid(3, _, _, _, _) :- write('Successfully placed henge piece!'), nl.

checkSurroundingPiecesSides(1, 2, 2, 2) :- write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesSides(1, 3, 2, 2) :- write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesSides(1, 2, 3, 2) :- write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesSides(1, 2, 2, 3) :- write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesSides(1, 3, 3, 2) :- write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesSides(1, 3, 2, 3) :- write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesSides(1, 3, 3, 3) :- write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesSides(1, _, _, _) :- write('Successful black play!'), nl.
checkSurroundingPiecesSides(2, 1, 1, 1) :- write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesSides(2, 3, 1, 1) :- write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesSides(2, 1, 3, 1) :- write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesSides(2, 1, 1, 3) :- write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesSides(2, 3, 3, 1) :- write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesSides(2, 3, 1, 3) :- write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesSides(2, 3, 3, 3) :- write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesSides(2, _, _, _) :- write('Successful white play!'), nl.
checkSurroundingPiecesSides(3, _, _, _) :- write('Successfully placed henge piece!'), nl.

checkSurroundingPiecesCorner(1, 2, 2) :- write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesCorner(1, 3, 2) :- write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesCorner(1, 2, 3) :- write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesCorner(1, 3, 3) :- write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesCorner(1, _, _) :- write('Successful black play!'), nl.
checkSurroundingPiecesCorner(2, 1, 1) :- write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesCorner(2, 3, 1) :- write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesCorner(2, 1, 3) :- write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesCorner(2, 3, 3) :- write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesCorner(2, _, _) :- write('Successful white play!'), nl.
checkSurroundingPiecesCorner(3, _, _) :- write('Successfully placed henge piece!'), nl.
	
getOpponentName('white', 'black').
getOpponentName('black', 'white').	
	
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
	freshBoard(Board),
	printBoard(Board),
	createPlayer(white, 10, 2, Player1, human),
	%createPlayer(black, 10, 2, Player2, human),
	checkBoardTopLeft(Board, 1, 1, Player1).