%professor(Id, Name, ScientificArea, ProfessorType, Preference[0 -> prefs all classes on 1st semester, 50 -> even, 100 -> prefs all classes on 2nd semester]).
professor(1, 'Nuno', 1, 1, 60).
professor(2, 'Sergio', 1, 2, 0).
professor(3, 'Andre', 2, 3, 100).
professor(4, 'Pedro', 2, 1, 50).

%scientificArea(id, name).
scientificArea(1, 'Computer Science').
scientificArea(2, 'Biology').

%Class(id, nome, AreaCientifica, horasPraticas, horasTeoricas).
firstSemesterClass(1, 'Introduction to Programming'	, 1, 10, 4).
firstSemesterClass(2, 'Wild Life I'					, 2, 10, 7).

secondSemesterClass(1, 'Computation Theory'	, 1, 10, 4).
secondSemesterClass(2, 'Pre-historic Life'	, 2, 10, 7).

%professorType(ID, Type, Hours).
professorType(1, 'Full Professor', 7).
professorType(2, 'Associate Professor', 8).
professorType(3, 'Auxiliar Professor', 9).
