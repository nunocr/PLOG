%professor(Id, Name, ScientificArea, ProfessorType, Preference[0 -> prefs all classes on 1st semester, 50 -> even, 100 -> prefs all classes on 2nd semester]).
professor(1, 'Nuno'		, 1, 1, 60).
professor(2, 'Sergio'	, 1, 2, 25).
professor(3, 'Andre'	, 2, 3, 100).
professor(4, 'Pedro'	, 2, 1, 50).
professor(5, 'Joao'		, 3, 2, 40).
professor(6, 'Maria'	, 3, 3, 75).
professor(7, 'Paula'	, 4, 3, 50).

%scientificArea(id, name).
scientificArea(1, 'Computer Science').
scientificArea(2, 'Biology').
scientificArea(3, 'Medicine').
scientificArea(4, 'Physics').

%Class(id, nome, AreaCientifica, horasPraticas, horasTeoricas).
firstSemesterClass(1, 'Introduction to Programming'	, 1, 6, 2).
firstSemesterClass(2, 'Wild Life I'					, 2, 10, 4).
firstSemesterClass(3, 'Blood and Circulation'		, 3, 6, 2).
firstSemesterClass(4, 'Movement I'					, 4, 10, 4).

secondSemesterClass(1, 'Computation Theory'		, 1, 14, 6).
secondSemesterClass(2, 'Pre-historic Life'		, 2, 10, 4).
secondSemesterClass(3, 'Anatomy'				, 3, 16, 6).
secondSemesterClass(4, 'Electic Systems I'		, 4, 10, 4).

%professorType(ID, Type, Hours).
professorType(1, 'Full Professor', 7).
professorType(2, 'Associate Professor', 8).
professorType(3, 'Auxiliar Professor', 9).
