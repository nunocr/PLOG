:-use_module(library(lists)).
:-use_module(library(clpfd)).
:-include('database').


calculateSemesterHours(ProfID, HoursFirstSemester, HoursSecondSemester) :-
	professor(ProfID, ProfName, _ProfArea, ProfTypeID, ProfDistributionPreference),
	tipoProfessor(ProfTypeID, _, Hours),
	TotalHours is Hours * 2,
	HoursFirstSemester is (100 - ProfDistributionPreference)/100 * TotalHours,
	HoursSecondSemester is ProfDistributionPreference/100 * TotalHours,
	write('Professor '), write(ProfName), write(' is giving '), 
	write(HoursFirstSemester), write(' weekly hours in the 1st semester, and '), 
	write(HoursSecondSemester), write(' weekly hours in the 2nd semester.'), nl.
	
getAllProfsFromScientificArea(ScientificAreaID, List) :-
	setof([ProfID, ProfName, ProfScientificAreaID, ProfTypeID, ProfPreference], (professor(ProfID, ProfName, ProfScientificAreaID, ProfTypeID, ProfPreference), ProfScientificAreaID #= ScientificAreaID), List).
	
getAllClassesFromScientificArea(ScientificAreaID, List) :-
	setof([ClassID, ClassName, ClassScientificAreaID, ClassSemester, ClassPracticalHours, ClassTheoricalHours], (unidadeCurricular(ClassID, ClassName, ClassScientificAreaID, ClassSemester, ClassPracticalHours, ClassTheoricalHours), ClassScientificAreaID #= ScientificAreaID), List).
	
getAllFirstSemesterClasses(List) :-
	setof([ClassID, ClassName, ClassScientificAreaID, ClassSemester, ClassPracticalHours, ClassTheoricalHours], (unidadeCurricular(ClassID, ClassName, ClassScientificAreaID, ClassSemester, ClassPracticalHours, ClassTheoricalHours), ClassSemester #= 1), List).

getAllProfs(List) :-
	setof([A, B, C, D, E], professor(A, B, C, D, E), List).	
	
getAllProfsPossibleClasses([]).
getAllProfsPossibleClasses([[ProfID, ProfName, ProfScientificAreaID, _, _]|T]) :-
	calculateSemesterHours(ProfID, _HoursFirstSemester, _HoursSecondSemester),
	getAllClassesFromScientificArea(ProfScientificAreaID, ClassesList),
	write('Professor '), write(ProfName), write(' can teach '), write(ClassesList), nl, nl,
	getAllProfsPossibleClasses(T).
	
teste :-
	getAllProfs(List),
	getAllProfsPossibleClassesWithSemesterRestrictions(List),
	write(List), nl.