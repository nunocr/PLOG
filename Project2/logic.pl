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
	
restrictClassArea(SolutionMatrix, CurrRow, CurrCol, CurrRowSolution, CurrClass) :-
	nth1(CurrRow, SolutionMatrix, CurrRowSolution),
	restrictClassArea1(CurrRowSolution, CurrRow, CurrCol, CurrClass).
	
restrictClassArea1(SolutionRow, CurrRow, CurrCol, CurrClass) :-
	nth1(CurrCol, SolutionRow, CurrClass),
	restrictClassArea2(CurrClass, CurrRow, CurrCol).
	
restrictClassArea2(CurrClass, CurrRow, CurrCol) :-
	professor(CurrRow, _, ProfArea, _, _),
	unidadeCurricular(CurrCol, _, ClassArea, _, _, _),
	nth1(1, CurrClass, Practical),
	nth1(2, CurrClass, Theorical),
	ProfArea \= ClassArea, 
	Theorical = 0.
	
restrictClassArea2(_, _, _).
	
teste :-
	getProfsList(L),
	length(L, Rows),
	getClassesList(L1),
	length(L1, Columns),
	Rows1 is Rows + 1,
	printPossibleClasses(1, Rows1, L2),
	restrictClassArea(L2, 1, 2, Teste, Teste1),
	%write(Teste), nl,
	%write(Teste1), nl,
	write(L2).