:-use_module(library(lists)).
:-use_module(library(clpfd)).
:-include('databaseSmall').

%getProfsList(-List) -> Gets a list of all professors.
getProfsList(List) :-
	setof([A, B, C, D, E], professor(A, B, C, D, E), List).
	
%getProfPossibleFirstSemesterClasses(-List) -> Creates a solution list for the first semester classes. Used to create a solution matrix.
getProfPossibleFirstSemesterClasses(List) :-
	findall([_, _], firstSemesterClass(_A, _B, _C, _D, _E), List).

%getProfPossibleSecondSemesterClasses(-List) -> Creates a solution list for the second semester classes. Used to create a solution matrix.
getProfPossibleSecondSemesterClasses(List) :-
	findall([_, _], secondSemesterClass(_A, _B, _C, _D, _E), List).

%createFirstSemesterSolutionMatrix(+CurrID, +MaxID, -List) -> Creates the solution matrix, calling the function getProfPossibleFirstSemesterClasses() for each professor.
createFirstSemesterSolutionMatrix(Rows, Rows, []).
createFirstSemesterSolutionMatrix(CurrID, MaxID, [H|T]) :-
	getProfPossibleFirstSemesterClasses(H),
	NextID is CurrID + 1,
	createFirstSemesterSolutionMatrix(NextID, MaxID, T).

%createFirstSemesterSolutionMatrix(+CurrID, +MaxID, -List) -> Creates the solution matrix, calling the function getProfPossibleSecondSemesterClasses() for each professor.
createSecondSemesterSolutionMatrix(Rows, Rows, []).
createSecondSemesterSolutionMatrix(CurrID, MaxID, [H|T]) :-
	getProfPossibleSecondSemesterClasses(H),
	NextID is CurrID + 1,
	createSecondSemesterSolutionMatrix(NextID, MaxID, T).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIRST SEMESTER RESTRICTIONS %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%restrictClassAreaFirstSemester(+SolutionMatrix, +CurrProf, +CurrClass, -ProfHours, -HoursOutOfAreaCounter) -> Restricts the professor's scheduling on the first semester classes, 
%																											   returning his hours spent teaching (can't teach more hours than what he signed for).
%																											   Also returns a counter used for efficiency, because it's preferred that practical classes are taught by a same area professor.
%																											   So, the less hours taught out of the area, better the found solution.
restrictClassAreaFirstSemester([], _, _, [], 0).
restrictClassAreaFirstSemester([H|T], CurrRow, CurrCol, [Carga | Cargas], OutOfAreaCount) :-
	restrictClassAreaFirstSemester1(H, CurrRow, CurrCol, OutOfAreaValue),
	append(H,Hours),
	NextRow is CurrRow + 1,
	restrictClassAreaFirstSemester(T, NextRow, CurrCol, Cargas, NewOutOfAreaCount),
	sum(Hours, #=, Carga),
	OutOfAreaCount #= NewOutOfAreaCount + OutOfAreaValue.

restrictClassAreaFirstSemester1([], _, _, 0).
restrictClassAreaFirstSemester1([H|T], CurrRow, CurrCol, OutOfAreaCount) :-
	restrictClassAreaFirstSemester2(H, CurrRow, CurrCol, OutOfAreaValue),
	NextCol is CurrCol + 1,
	restrictClassAreaFirstSemester1(T, CurrRow, NextCol, NewOutOfAreaCount),
	OutOfAreaCount #= NewOutOfAreaCount + OutOfAreaValue.

restrictClassAreaFirstSemester2([H,T], CurrRow, CurrCol, H) :-
	professor(CurrRow, _, ProfArea, _, _),
	firstSemesterClass(CurrCol, _, ClassArea, _, _),
	ProfArea \= ClassArea,
	T #= 0. %if a prof is not of the area, cant teach theorical classes.
restrictClassAreaFirstSemester2(_, _, _, 0).

%restrictClassHoursFirstSemester(+SolutionMatrix, +CurrClass, +CurrProf) -> Restricts the hours of a class, so all given hours put together doesn't pass the class' limit.
restrictClassHoursFirstSemester([],_,_).
restrictClassHoursFirstSemester([H|T],CurrRow,CurrCol):-
	firstSemesterClass(CurrRow, _, _, HP, HT),
	restrictClassHoursFirstSemester1(H,CurrRow,CurrCol,TheoCounter,PracCounter),
	PracCounter #= HP,
	TheoCounter #= HT,
	NextRow is CurrRow + 1,
	restrictClassHoursFirstSemester(T,NextRow,CurrCol).

restrictClassHoursFirstSemester1([],_,_,0,0).
restrictClassHoursFirstSemester1([[P,T]|List],CurrRow,CurrCol,NewTheoCounter,NewPracCounter):-
	NextCol is CurrCol + 1,
	restrictClassHoursFirstSemester1(List,CurrRow,NextCol,TheoCounter2,PracCounter2),
	NewPracCounter #= PracCounter2 + P,
	NewTheoCounter #= TheoCounter2 + T.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECOND SEMESTER RESTRICTIONS %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%restrictClassAreaSecondSemester(+SolutionMatrix, +CurrProf, +CurrClass, -ProfHours, -HoursOutOfAreaCounter) -> Restricts the professor's scheduling on the second semester classes, 
%																											    returning his hours spent teaching (can't teach more hours than what he signed for).
%																											    Also returns a counter used for efficiency, because it's preferred that practical classes are taught by a same area professor.
%																											    So, the less hours taught out of the area, better the found solution.
restrictClassAreaSecondSemester([], _, _,[], 0).
restrictClassAreaSecondSemester([H|T], CurrRow, CurrCol, [Carga | Cargas], OutOfAreaCount) :-
	restrictClassAreaSecondSemester1(H, CurrRow, CurrCol, OutOfAreaValue),
	append(H,Hours),
	NextRow is CurrRow + 1,
	restrictClassAreaSecondSemester(T, NextRow, CurrCol, Cargas, NewOutOfAreaCount),
	sum(Hours, #=, Carga),
	OutOfAreaCount #= NewOutOfAreaCount + OutOfAreaValue.

restrictClassAreaSecondSemester1([], _, _, 0).
restrictClassAreaSecondSemester1([H|T], CurrRow, CurrCol, OutOfAreaCount) :-
	restrictClassAreaSecondSemester2(H, CurrRow, CurrCol, OutOfAreaValue),
	NextCol is CurrCol + 1,
	restrictClassAreaSecondSemester1(T, CurrRow, NextCol, NewOutOfAreaCount),
	OutOfAreaCount #= NewOutOfAreaCount + OutOfAreaValue.

restrictClassAreaSecondSemester2([H,T], CurrRow, CurrCol, H) :-
	professor(CurrRow, _, ProfArea, _, _),
	secondSemesterClass(CurrCol, _, ClassArea, _, _),
	ProfArea \= ClassArea,
	T #= 0.
restrictClassAreaSecondSemester2(_, _, _, 0).

%restrictClassHoursSecondSemester(+SolutionMatrix, +CurrClass, +CurrProf) -> Restricts the hours of a class, so all given hours put together doesn't pass the class' limit.
restrictClassHoursSecondSemester([],_,_).
restrictClassHoursSecondSemester([H|T],CurrRow,CurrCol):-
	secondSemesterClass(CurrRow, _, _, HP, HT),

	restrictClassHoursSecondSemester1(H,CurrRow,CurrCol,TheoCounter,PracCounter),
	PracCounter #= HP,
	TheoCounter #= HT,

	NextRow is CurrRow + 1,
	restrictClassHoursSecondSemester(T,NextRow,CurrCol).

restrictClassHoursSecondSemester1([],_,_,0,0).
restrictClassHoursSecondSemester1([[P,T]|List],CurrRow,CurrCol,NewTheoCounter,NewPracCounter):-
	NextCol is CurrCol + 1,
	restrictClassHoursSecondSemester1(List,CurrRow,NextCol,TheoCounter2,PracCounter2),
	NewPracCounter #= PracCounter2 + P,
	NewTheoCounter #= TheoCounter2 + T.
	
restrictScheduleBurden([], [], _).
restrictScheduleBurden([Sem1H | Sem1T], [Sem2H | Sem2T], Number) :-
	professor(Number, _, _, Type, _),
	professorType(Type, _, Carga),
	NewCarga is Carga * 2,
	Sem1H + Sem2H #= NewCarga,
	NewNumber is Number + 1,
	restrictScheduleBurden(Sem1T, Sem2T, NewNumber).

%%%%%%%%%%%%%%%%%
% OPTIMIZATIONS %
%%%%%%%%%%%%%%%%%

%calculateFirstSemesterHours(+ProfID, -HoursFirstSemester) -> Calculates the hours wanted by a professor with the given ID. Used to increase efficiency and provides a more accurate solution.
calculateFirstSemesterHours(ProfID, HoursFirstSemester) :-
	professor(ProfID, _, _ProfArea, ProfTypeID, ProfDistributionPreference),
	professorType(ProfTypeID, _, Hours),
	TotalHours is Hours * 2,
	HoursFirstSemester is (100 - ProfDistributionPreference) * TotalHours.

%calculateSecondSemesterHours(+ProfID, -HoursSecondSemester) -> Calculates the hours wanted by a professor with the given ID. Used to increase efficiency and provides a more accurate solution.
calculateSecondSemesterHours(ProfID, HoursSecondSemester) :-
	professor(ProfID, _, _ProfArea, ProfTypeID, ProfDistributionPreference),
	professorType(ProfTypeID, _, Hours),
	TotalHours is Hours * 2,
	HoursSecondSemester is ProfDistributionPreference * TotalHours.

%makeIdealHoursList(+ProfID, -IdealHoursList) -> Gets the preferred schedule for professors. Used to compare to current solution to find a better solution.
makeIdealHoursList(ProfID, [[HoursFirstSemester, HoursSecondSemester]|T]) :-
	calculateFirstSemesterHours(ProfID, HoursFirstSemester),
	calculateSecondSemesterHours(ProfID, HoursSecondSemester),
	NewID is ProfID + 1,
	makeIdealHoursList(NewID, T).
makeIdealHoursList(_, []).

%appendHours(+FirstSemesterHours, +SecondSemesterHours, -GroupedHours) -> Groups current solution professor hours, to compare to a list of ideal hours, in order to find a better solution.
%																		  Everything is multiplied by 100 to avoid decimals.
appendHours([], [], []).
appendHours([H|T], [C|S], [[A, B]|L]) :-
	A #= 100 * H,
	B #= 100 * C,
	appendHours(T, S, L).

%countValueHoursDiff(+CurrentHours, +IdealHours, -EfficiencyValue) -> Subtracts the current solution hours to the ideal one, so it gives the current efficiency value. The lower this value, the better the solution.
countValueHoursDiff([],[], 0).
countValueHoursDiff([Hg | Tg], [Hi | Ti], Sum) :-
	countValueHoursDiff(Tg, Ti, NewSum),
	Sum #= NewSum + abs(Hg - Hi).

%%%%%%%%%%%%%%%%%%
% PRINT SOLUTION %
%%%%%%%%%%%%%%%%%%

printSolution([], _, _).
printSolution([H|T], CurrProf, 1) :-
	professor(CurrProf, ProfName, ProfArea, ProfType, _),
	scientificArea(ProfArea, AreaName),
	professorType(ProfType, TypeName, _),
	write('Professor '), write(ProfName), write(', a '), write(TypeName), write(' which area is '), write(AreaName), write(' will be teaching:'), nl,
	printFirstSemesterClasses(H, 1), nl,
	NextProf is CurrProf + 1,
	printSolution(T, NextProf, 1).
printSolution([H|T], CurrProf, 2) :-
	professor(CurrProf, ProfName, ProfArea, ProfType, _),
	scientificArea(ProfArea, AreaName),
	professorType(ProfType, TypeName, _),
	write('Professor '), write(ProfName), write(', a '), write(TypeName), write(' which area is '), write(AreaName), write(' will be teaching:'), nl,
	printSecondSemesterClasses(H, 1), nl,
	NextProf is CurrProf + 1,
	printSolution(T, NextProf, 2).
	
printFirstSemesterClasses([], _).
printFirstSemesterClasses([[Practical,Theorical]|T], CurrClass) :-
	firstSemesterClass(CurrClass, ClassName, ClassArea, _, _),
	scientificArea(ClassArea, AreaName),
	write('        '), write(ClassName), write(' ('), write(AreaName), write(' area)'), write(': '), 
	write(Practical), write(' hours of practical classes and '), write(Theorical), write(' hours of theorical classes.'), nl,
	NextClass is CurrClass + 1,
	printFirstSemesterClasses(T, NextClass).
	
printSecondSemesterClasses([], _).
printSecondSemesterClasses([[Practical,Theorical]|T], CurrClass) :-
	secondSemesterClass(CurrClass, ClassName, ClassArea, _, _),
	scientificArea(ClassArea, AreaName),
	write('        '), write(ClassName), write(' ('), write(AreaName), write(' area)'), write(': '), 
	write(Practical), write(' hours of practical classes and '), write(Theorical), write(' hours of theorical classes.'), nl,
	NextClass is CurrClass + 1,
	printSecondSemesterClasses(T, NextClass).

%%%%%%%%%%%
% PROGRAM %
%%%%%%%%%%%

schedule :-
	getProfsList(Lprofs),
	length(Lprofs, Rows),
	Rows1 is Rows + 1,
	createFirstSemesterSolutionMatrix(1, Rows1, Sem1),
	createSecondSemesterSolutionMatrix(1, Rows1, Sem2),
	%Solution matrix done, each row is a professor and each column is a class.
	
	transpose(Sem1, Ucs1),
	transpose(Sem2, Ucs2),
	append(Ucs1,TesteLabel1),
	append(TesteLabel1,TesteLabel12),
	append(Ucs2,TesteLabel2),
	append(TesteLabel2,TesteLabel22),
	append(TesteLabel12, TesteLabel22, TesteLabel),
	%Flattens the transposed solution, so each row is a class and each column is a professor.
	
	%starts restrictions
	domain(TesteLabel,0,9),
	restrictClassHoursFirstSemester(Ucs1, 1, 1),
	restrictClassHoursSecondSemester(Ucs2, 1, 1),
	restrictClassAreaFirstSemester(Sem1, 1, 1, ProfsHours1, OutOfAreaCount1),
	restrictClassAreaSecondSemester(Sem2, 1, 1, ProfsHours2, OutOfAreaCount2),
	restrictScheduleBurden(ProfsHours1, ProfsHours2, 1),
	%finishes restrictions
	
	%starts optimization
	appendHours(ProfsHours1, ProfsHours2, GroupedHours),
	makeIdealHoursList(1, IdealHours),
	append(GroupedHours, GPH),
	append(IdealHours, IH),
	countValueHoursDiff(GPH, IH, ValueMin),
	ValueToMinimize #= ValueMin + OutOfAreaCount1*100 + OutOfAreaCount2*100, %each value is multiplied by 100 to match the value of ValueMin
	%finishes optimization
	
	statistics(walltime, _),
	labeling([time_out(10000, _), minimize(ValueToMinimize)],TesteLabel),
	statistics(walltime, [_ | [ExecutionTime]]),
	
	write('Readable Solution: '), nl,
	write('Scheduling for 1st semester'), nl,
	write('---------------------------'), nl,
	printSolution(Sem1, 1, 1), nl,
	
	write('Scheduling for 2nd semester'), nl,
	write('---------------------------'), nl,
	printSolution(Sem2, 1, 2), nl,
	
	write('Solution Matrix: '), nl,
	write('First Semester: '), nl,
	write(Sem1), nl, nl,
	write('Second Semester: '), nl,
	write(Sem2), nl, nl,
	
	write('Execution time: '), write(ExecutionTime), write(' milliseconds.').
