:-use_module(library(lists)).
:-use_module(library(clpfd)).
:-include('database').


calculateSemesterHours(ProfID, HoursFirstSemester, HoursSecondSemester) :-
	professor(ProfID, ProfName, _ProfArea, ProfTypeID, ProfDistributionPreference),
	tipoProfessor(ProfTypeID, _, Hours),
	TotalHours is Hours * 2,
	HoursFirstSemester is (100 - ProfDistributionPreference)/100 * TotalHours,
	HoursSecondSemester is ProfDistributionPreference/100 * TotalHours.
	
getProfsList(List) :-
	setof([A, B, C, D, E], professor(A, B, C, D, E), List).
	
getClassesList(List) :-
	setof([A, B, C, D, E, F], unidadeCurricular(A, B, C, D, E, F), List).

getProfPossibleClasses(List) :-
	findall([_, _], unidadeCurricular(_A, _B, _C, _D, _E, _F), List).

printPossibleClasses(Rows, Rows, []).
printPossibleClasses(CurrID, MaxID, [H|T]) :-
	getProfPossibleClasses(H),
	%write(CurrID), write('     '), write(H), nl,
	NextID is CurrID + 1,
	printPossibleClasses(NextID, MaxID, T).
	
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
		
restrictClassArea([], _, _, []).
restrictClassArea([H|T], CurrRow, CurrCol, [C|S]) :-
	restrictClassArea1(H, CurrRow, CurrCol, C),
	NextRow is CurrRow + 1,
	write(C), nl,
	restrictClassArea(T, NextRow, CurrCol, S).

restrictClassArea1([], _, _, []).
restrictClassArea1([H|T], CurrRow, CurrCol, [C|S]) :-
	%write('Editing: '), write(H), nl,
	%write('List Tail: '), write(T), nl,
	restrictClassArea2(H, CurrRow, CurrCol, C),
	NextCol is CurrCol + 1,
	restrictClassArea1(T, CurrRow, NextCol, S).

restrictClassArea2([], _, _, []).
restrictClassArea2([H|T], CurrRow, CurrCol, [C,S]) :-
	professor(CurrRow, _, ProfArea, _, _),
	unidadeCurricular(CurrCol, _, ClassArea, _, _, _),
	%write('ProfArea: '), write(ProfArea), nl,
	%write('ClassArea: '), write(ClassArea), nl,
	ProfArea \== ClassArea, 
	C = H,
	S = 0.
	
restrictClassArea2([Practical|Theorical], CurrRow, CurrCol, [C|S]) :-
	professor(CurrRow, _, ProfArea, _, _),
	unidadeCurricular(CurrCol, _, ClassArea, _, _, _),
	ProfArea == ClassArea,
	C = Practical,
	S = Theorical.
	
teste :-
	getProfsList(L),
	length(L, Rows),
	getClassesList(L1),
	length(L1, Columns),
	Rows1 is Rows + 1,
	printPossibleClasses(1, Rows1, L2),
	restrictClassArea(L2, 1, 1, Teste).
	%write(Teste), nl,
	%write(L2), nl.