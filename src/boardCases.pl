checkSurroundingPiecesMid(1, 2, 2, 2, 2, Return) :- Return is 0, write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesMid(1, 3, 2, 2, 2, Return) :- Return is 0, write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesMid(1, 2, 3, 2, 2, Return) :- Return is 0, write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesMid(1, 2, 2, 3, 2, Return) :- Return is 0, write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesMid(1, 2, 2, 2, 3, Return) :- Return is 0, write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesMid(1, 3, 3, 2, 2, Return) :- Return is 0, write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesMid(1, 3, 2, 3, 2, Return) :- Return is 0, write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesMid(1, 3, 2, 2, 3, Return) :- Return is 0, write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesMid(1, 2, 3, 2, 3, Return) :- Return is 0, write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesMid(1, 2, 2, 3, 3, Return) :- Return is 0, write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesMid(1, 2, 3, 3, 2, Return) :- Return is 0, write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesMid(1, 3, 3, 3, 2, Return) :- Return is 0, write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesMid(1, 3, 3, 2, 3, Return) :- Return is 0, write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesMid(1, 3, 2, 3, 3, Return) :- Return is 0, write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesMid(1, 2, 3, 3, 3, Return) :- Return is 0, write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesMid(1, 3, 3, 3, 3, Return) :- Return is 0, write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesMid(1, _, _, _, _, Return) :- Return is 1, write('Successful black play!'), nl.
checkSurroundingPiecesMid(2, 1, 1, 1, 1, Return) :- Return is 0, write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesMid(2, 3, 1, 1, 1, Return) :- Return is 0, write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesMid(2, 1, 3, 1, 1, Return) :- Return is 0, write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesMid(2, 1, 1, 3, 1, Return) :- Return is 0, write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesMid(2, 1, 1, 1, 3, Return) :- Return is 0, write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesMid(2, 3, 3, 1, 1, Return) :- Return is 0, write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesMid(2, 3, 1, 3, 1, Return) :- Return is 0, write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesMid(2, 3, 1, 1, 3, Return) :- Return is 0, write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesMid(2, 1, 3, 1, 3, Return) :- Return is 0, write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesMid(2, 1, 1, 3, 3, Return) :- Return is 0, write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesMid(2, 1, 3, 3, 1, Return) :- Return is 0, write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesMid(2, 3, 3, 3, 1, Return) :- Return is 0, write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesMid(2, 3, 3, 1, 3, Return) :- Return is 0, write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesMid(2, 1, 3, 3, 3, Return) :- Return is 0, write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesMid(2, 3, 1, 3, 3, Return) :- Return is 0, write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesMid(2, 3, 3, 3, 3, Return) :- Return is 0, write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesMid(2, _, _, _, _, Return) :- Return is 1, write('Successful white play!'), nl.
checkSurroundingPiecesMid(3, _, _, _, _, Return) :- Return is 1, write('Successfully placed henge piece!'), nl.


checkSurroundingPiecesSides(1, 2, 2, 2, Return) :- Return is 0, write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesSides(1, 3, 2, 2, Return) :- Return is 0, write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesSides(1, 2, 3, 2, Return) :- Return is 0, write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesSides(1, 2, 2, 3, Return) :- Return is 0, write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesSides(1, 3, 3, 2, Return) :- Return is 0, write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesSides(1, 3, 2, 3, Return) :- Return is 0, write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesSides(1, 2, 3, 3, Return) :- Return is 0, write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesSides(1, 3, 3, 3, Return) :- Return is 0, write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesSides(1, _, _, _, Return) :- Return is 1, write('Successful black play!'), nl.
checkSurroundingPiecesSides(2, 1, 1, 1, Return) :- Return is 0, write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesSides(2, 3, 1, 1, Return) :- Return is 0, write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesSides(2, 1, 3, 1, Return) :- Return is 0, write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesSides(2, 1, 1, 3, Return) :- Return is 0, write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesSides(2, 3, 3, 1, Return) :- Return is 0, write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesSides(2, 3, 1, 3, Return) :- Return is 0, write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesSides(2, 1, 3, 3, Return) :- Return is 0, write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesSides(2, 3, 3, 3, Return) :- Return is 0, write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesSides(2, _, _, _, Return) :- Return is 1, write('Successful white play!'), nl.
checkSurroundingPiecesSides(3, _, _, _, Return) :- Return is 1, write('Successfully placed henge piece!'), nl.


checkSurroundingPiecesCorner(1, 2, 2, Return) :- Return is 0, write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesCorner(1, 3, 2, Return) :- Return is 0, write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesCorner(1, 2, 3, Return) :- Return is 0, write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesCorner(1, 3, 3, Return) :- Return is 0, write('That coordinate is surrounded by white pieces!'), nl, !, fail.
checkSurroundingPiecesCorner(1, _, _, Return) :- Return is 1, write('Successful black play!'), nl.
checkSurroundingPiecesCorner(2, 1, 1, Return) :- Return is 0, write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesCorner(2, 3, 1, Return) :- Return is 0, write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesCorner(2, 1, 3, Return) :- Return is 0, write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesCorner(2, 3, 3, Return) :- Return is 0, write('That coordinate is surrounded by black pieces!'), nl, !, fail.
checkSurroundingPiecesCorner(2, _, _, Return) :- Return is 1, write('Successful white play!'), nl.
checkSurroundingPiecesCorner(3, _, _, Return) :- Return is 1, write('Successfully placed henge piece!'), nl.