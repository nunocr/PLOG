:-use_module(library(lists)).
:-use_module(library(clpfd)).
:-include('database').


calculateFirstSemesterHours(ProfID, HoursFirstSemester) :-
	professor(ProfID, ProfName, _ProfArea, ProfTypeID, ProfDistributionPreference),
	tipoProfessor(ProfTypeID, _, Hours),
	TotalHours is Hours * 2,
	HoursFirstSemester is (100 - ProfDistributionPreference) * TotalHours.
	%HoursSecondSemester is ProfDistributionPreference * TotalHours.

calculateSecondSemesterHours(ProfID, HoursSecondSemester) :-
	professor(ProfID, ProfName, _ProfArea, ProfTypeID, ProfDistributionPreference),
	tipoProfessor(ProfTypeID, _, Hours),
	TotalHours is Hours * 2,
	HoursSecondSemester is ProfDistributionPreference * TotalHours.

getProfsList(List) :-
	setof([A, B, C, D, E], professor(A, B, C, D, E), List).

getClassesList(List) :-
	setof([A, B, C, D, E], unidadeCurricular(A, B, C, D, E), List).

getClassesList2(List) :-
	setof([A, B, C, D, E], unidadeCurricular2(A, B, C, D, E), List).

getProfPossibleClasses1(List) :-
	findall([_, _], unidadeCurricular(_A, _B, _C, _D, _E), List).

getProfPossibleClasses2(List) :-
	findall([_, _], unidadeCurricular2(_A, _B, _C, _D, _E), List).

printPossibleClasses(Rows, Rows, []).
printPossibleClasses(CurrID, MaxID, [H|T]) :-
	getProfPossibleClasses1(H),
	NextID is CurrID + 1,
	printPossibleClasses(NextID, MaxID, T).

printPossibleClasses2(Rows, Rows, []).
printPossibleClasses2(CurrID, MaxID, [H|T]) :-
	getProfPossibleClasses2(H),
	NextID is CurrID + 1,
	printPossibleClasses2(NextID, MaxID, T).

getTotalClassHours(ClassID, PracticalHours, TheoricalHours) :-
	unidadeCurricular(ClassID, _, _, _, PracticalHoursList, TheoricalHoursList),
	sumlist(PracticalHoursList, TotalPracticalHours),
	sumlist(TheoricalHoursList, TotalTheoricalHours).

getMinPracticalClassTime(ClassID, MinTime) :-
	unidadeCurricular(ClassID, _, _, _, PracticalHoursList, _),
	min_list(PracticalHoursList, MinTime).

getMinTheoricalClassTime(ClassID, MinTime) :-
	unidadeCurricular(ClassID, _, _, _, _, TheoricalHoursList),
	min_list(TheoricalHoursList, MinTime).


%%%%%%%%%%% - Restriction Theorical

% [Pratical, Theoretical]

restrictClassArea([], _, _, [], 0).
restrictClassArea([H|T], CurrRow, CurrCol, [Carga | Cargas], OutOfAreaCount) :-
	restrictClassArea1(H, CurrRow, CurrCol, OutOfAreaValue),
	append(H,Hours),
	NextRow is CurrRow + 1,
	restrictClassArea(T, NextRow, CurrCol, Cargas, NewOutOfAreaCount),
	sum(Hours, #=, Carga),
	OutOfAreaCount #= NewOutOfAreaCount + OutOfAreaValue.

restrictClassArea1([], _, _, 0).
restrictClassArea1([H|T], CurrRow, CurrCol, OutOfAreaCount) :-
	restrictClassArea2(H, CurrRow, CurrCol, OutOfAreaValue),
	NextCol is CurrCol + 1,
	restrictClassArea1(T, CurrRow, NextCol, NewOutOfAreaCount),
	OutOfAreaCount #= NewOutOfAreaCount + OutOfAreaValue.

restrictClassArea2([H,T], CurrRow, CurrCol, H) :-
	%write('CurrRow: '), write(CurrRow), nl,
	%write('CurrCol: '), write(CurrCol), nl,
	professor(CurrRow, _, ProfArea, _, _),
	unidadeCurricular(CurrCol, _, ClassArea, _, _),
	ProfArea \= ClassArea,
	T #= 0.
restrictClassArea2(_, _, _, 0).
	%H #> 0 #/\ T #> 0.

restrictClassHours([],_,_).
restrictClassHours([H|T],CurrRow,CurrCol):-
	unidadeCurricular(CurrRow, _, ClassArea, HP, HT),

	restrictClassHours1(H,CurrRow,CurrCol,TheoCounter,PracCounter),
	PracCounter #= HP,
	TheoCounter #= HT,

	NextRow is CurrRow + 1,
	restrictClassHours(T,NextRow,CurrCol).

%[Prof1,Prof2]
restrictClassHours1([],_,_,0,0).
restrictClassHours1([[P,T]|List],CurrRow,CurrCol,NewTheoCounter,NewPracCounter):-
	NextCol is CurrCol + 1,
	restrictClassHours1(List,CurrRow,NextCol,TheoCounter2,PracCounter2),
	NewPracCounter #= PracCounter2 + P,
	NewTheoCounter #= TheoCounter2 + T.



%-------------------------------------------------------------------2º semester

restrictClassAreaSemester2([], _, _,[], 0).
restrictClassAreaSemester2([H|T], CurrRow, CurrCol, [Carga | Cargas], OutOfAreaCount) :-
	restrictClassArea1Semester2(H, CurrRow, CurrCol, OutOfAreaValue),
	append(H,Hours),
	NextRow is CurrRow + 1,
	restrictClassAreaSemester2(T, NextRow, CurrCol, Cargas, NewOutOfAreaCount),
	sum(Hours, #=, Carga),
	OutOfAreaCount #= NewOutOfAreaCount + OutOfAreaValue.


restrictClassArea1Semester2([], _, _, 0).
restrictClassArea1Semester2([H|T], CurrRow, CurrCol, OutOfAreaCount) :-
	restrictClassArea2Semester2(H, CurrRow, CurrCol, OutOfAreaValue),
	NextCol is CurrCol + 1,
	restrictClassArea1Semester2(T, CurrRow, NextCol, NewOutOfAreaCount),
	OutOfAreaCount #= NewOutOfAreaCount + OutOfAreaValue.


restrictClassArea2Semester2([H,T], CurrRow, CurrCol, H) :-
	%write('CurrRow: '), write(CurrRow), nl,
	%write('CurrCol: '), write(CurrCol), nl,
	professor(CurrRow, _, ProfArea, _, _),
	unidadeCurricular2(CurrCol, _, ClassArea, _, _),
	ProfArea \= ClassArea,
	T #= 0.
restrictClassArea2Semester2(_, _, _, 0).
	%H #> 0 #/\ T #> 0.

restrictClassHoursSemester2([],_,_).
restrictClassHoursSemester2([H|T],CurrRow,CurrCol):-
	unidadeCurricular2(CurrRow, _, _, HP, HT),

	restrictClassHours1Semester2(H,CurrRow,CurrCol,TheoCounter,PracCounter),
	PracCounter #= HP,
	TheoCounter #= HT,

	NextRow is CurrRow + 1,
	restrictClassHoursSemester2(T,NextRow,CurrCol).

%[Prof1,Prof2]
restrictClassHours1Semester2([],_,_,0,0).
restrictClassHours1Semester2([[P,T]|List],CurrRow,CurrCol,NewTheoCounter,NewPracCounter):-
	NextCol is CurrCol + 1,
	restrictClassHours1Semester2(List,CurrRow,NextCol,TheoCounter2,PracCounter2),
	NewPracCounter #= PracCounter2 + P,
	NewTheoCounter #= TheoCounter2 + T.
	
restrictScheduleBurden([], [], _).
restrictScheduleBurden([Sem1H | Sem1T], [Sem2H | Sem2T], Number) :-
	professor(Number, _, _, Type, _),
	tipoProfessor(Type, _, Carga),
	NewCarga is Carga * 2,
	Sem1H + Sem2H #= NewCarga,
	NewNumber is Number + 1,
	restrictScheduleBurden(Sem1T, Sem2T, NewNumber).


%%%%%%%%%%% - END Restriction Theorical

makeIdealHoursList(ProfID, [[HoursFirstSemester, HoursSecondSemester]|T]) :-
	calculateFirstSemesterHours(ProfID, HoursFirstSemester),
	calculateSecondSemesterHours(ProfID, HoursSecondSemester),
	NewID is ProfID + 1,
	makeIdealHoursList(NewID, T).
makeIdealHoursList(_, []).

appendHours([], [], []).
appendHours([H|T], [C|S], [[A, B]|L]) :-
	A #= 100 * H,
	B #= 100 * C,
	appendHours(T, S, L).

countValueHoursDiff([],[], 0).
countValueHoursDiff([Hg | Tg], [Hi | Ti], Sum) :-
	countValueHoursDiff(Tg, Ti, NewSum),
	Sum #= NewSum + abs(Hg - Hi).

teste :-
	getProfsList(Lprofs),
	length(Lprofs, Rows),
	getClassesList(Luc1),
	getClassesList2(Luc2),
	Rows1 is Rows + 1,
	printPossibleClasses(1, Rows1, Sem1),
	printPossibleClasses2(1, Rows1, Sem2),

	transpose(Sem1, Ucs1),
	transpose(Sem2, Ucs2),


	append(Ucs1,TesteLabel1),
	append(TesteLabel1,TesteLabel12),
	append(Ucs2,TesteLabel2),
	append(TesteLabel2,TesteLabel22),
	append(TesteLabel12, TesteLabel22, TesteLabel),
	domain(TesteLabel,0,9),
	%nth1(1,TesteLabel2,Elem),

	%trace,
	restrictClassHours(Ucs1, 1, 1),
	restrictClassHoursSemester2(Ucs2, 1, 1),
	%fd_set(Elem,Set),
	%fdset_to_list(Set,X),
	%write(X),nl,
	%trace,
	restrictClassArea(Sem1, 1, 1, ProfsHours1, OutOfAreaCount1),
	restrictClassAreaSemester2(Sem2, 1, 1, ProfsHours2, OutOfAreaCount2),
	%write(ProfHours1), nl,
	%write(ProfHours2), nl,
	%trace,
	write(OutOfAreaCount1), nl,
	write(OutOfAreaCount2), nl,
	restrictScheduleBurden(ProfsHours1, ProfsHours2, 1),
	appendHours(ProfsHours1, ProfsHours2, GroupedHours),
	makeIdealHoursList(1, IdealHours),
	append(GroupedHours, GPH),
	append(IdealHours, IH),
	countValueHoursDiff(GPH, IH, ValueMin),
	ValueToMinimize #= ValueMin + OutOfAreaCount1*100 + OutOfAreaCount2*100,
	%write(L2),nl,
	labeling([time_out(8000, _), minimize(ValueToMinimize)],TesteLabel),
	%write(ProfsHours1), nl,
	%write(ProfsHours2), nl,
	%write(GroupedHours), nl, nl, nl,
	write(Sem1), nl,
	write(Sem2),nl.
