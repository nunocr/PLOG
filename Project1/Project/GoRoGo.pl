board([[s, s, s, s, s],
       [s, s, s, s, s],
       [s, s, s, s, s],
       [s, s, s, s, s],
       [s, s, s, s, s]]).

boardsetup([[s, s, x, x, s, s, x, x, s, s],
       [x, x, x, x, x, x, x, x, x, x],
       [x, x, s, s, x, x, s, s, x, x],
       [s, s, s, s, s, s, s, s, s, s],
       [s, s, s, s, s, s, s, s, s, s],
       [o, o, s, s, o, o, s, s, o, o],
       [o, o, o, o, o, o, o, o, o, o],
       [s, s, o, o, s, s, o, o, s, s]]).

display_board([L1|Ls], N) :-
         write(N),
         N1 is N+1,
         final_display_line(L1), nl,
         display_board(Ls, N1).
        display_board([], _) :- nl.


final_display_line(L1) :- write('|'), display_line(L1).
display_line([E|Es]) :-
          translate(E, V),
          write(V),
          write('|'),
          display_line(Es).
          display_line([]).

printboard :- board(X), write(' |0|1|2|3|4|'), nl, display_board(X, 0).
printboardsetup :- boardsetup(X), write(' |0|1|2|3|4|5|6|7|8|9|'), nl, display_board(X, 0).

translate(s, '_').
translate(w, '|').
translate(t, '-').
translate(b, ' ').

translate(x, 'X').
translate(o, 'O').
translate(h, 'H').

translate(1, '1').
translate(2, '2').
translate(3, '3').
translate(4, '4').
translate(5, '5').
translate(6, '6').
translate(7, '7').
translate(8, '8').
translate(9, '9').
translate(0, '0').

translate(X, X).
