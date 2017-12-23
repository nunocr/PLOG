%professor(Id, Name, ScientificArea, ProfessorType, Preference[0 -> prefs all classes on 1st semester, 50 -> even, 100 -> prefs all classes on 2nd semester]).
professor(1, 'Nuno'			, 1, 1, 60).
professor(2, 'Sergio'		, 1, 2, 25).
professor(3, 'Andre'		, 2, 3, 100).
professor(4, 'Pedro'		, 2, 1, 50).
professor(5, 'Joao'			, 3, 2, 40).
professor(6, 'Maria'		, 3, 3, 75).
professor(7, 'Paula'		, 4, 3, 50).
professor(8, 'Antonio'		, 1, 1, 35).
professor(9, 'Alberto'		, 4, 2, 85).
professor(10, 'Joana'		, 3, 3, 50).
professor(11, 'Alexandre'	, 5, 2, 100).
professor(12, 'Carla'		, 2, 2, 0).
professor(13, 'Joaquim'		, 4, 3, 50).
professor(14, 'Ana'			, 5, 3, 45).

%scientificArea(id, name).
scientificArea(1, 'Computer Science').
scientificArea(2, 'Biology').
scientificArea(3, 'Medicine').
scientificArea(4, 'Physics').
scientificArea(5, 'Sports').

%Class(id, nome, AreaCientifica, horasPraticas, horasTeoricas).
firstSemesterClass(1, 'Introduction to Programming'	, 1, 6, 2).
firstSemesterClass(2, 'Wild Life I'					, 2, 10, 4).
firstSemesterClass(3, 'Blood and Circulation'		, 3, 6, 2).
firstSemesterClass(4, 'Movement I'					, 4, 10, 4).
firstSemesterClass(5, 'Introduction to Metabolism'	, 5, 12, 8).
firstSemesterClass(6, 'Fluids and Mass I'			, 4, 6, 6).
firstSemesterClass(7, 'Digestive System'			, 3, 8, 4).
firstSemesterClass(8, 'Computer Architecture'		, 1, 6, 4).

secondSemesterClass(1, 'Computation Theory'		, 1, 14, 6).
secondSemesterClass(2, 'Pre-historic Life'		, 2, 10, 4).
secondSemesterClass(3, 'Anatomy'				, 3, 14, 6).
secondSemesterClass(4, 'Electic Systems I'		, 4, 10, 4).
secondSemesterClass(5, 'Basketball'				, 5, 14, 2).
secondSemesterClass(6, 'Quantum Physics I'		, 4, 8, 8).
secondSemesterClass(7, 'Plants and Evolution'	, 2, 10, 4).
secondSemesterClass(8, 'Logic Programming'		, 1, 12, 6).

%professorType(ID, Type, Hours).
professorType(1, 'Full Professor', 7).
professorType(2, 'Associate Professor', 8).
professorType(3, 'Auxiliar Professor', 9).
