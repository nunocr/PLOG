:-use_module(library(lists)).
:-use_module(library(clpfd)).
:-include('database').


restrictTeacher(IdProf, NomeProf, AreaCientifica, TipoProf, PreferenciaHorario):-
  professor(IdProf, NomeProf, AreaCientifica, TipoProf, PreferenciaHorario),
  tipoProfessor(TipoProf, CargaHoraria),
  areaCientifica(IdArea, AreaCientifica),
  unidadeCurricular(IdUni, NomeUni, HorasT, HorasP, IdArea, IdProf),
  CargaSemanal in 0..CargaHoraria,
  HorasProfT in 0..HorasT,
  HorasProfP in 0..HorasP.
