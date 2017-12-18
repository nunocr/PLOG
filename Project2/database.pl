%professor(id, nome, areaCientifica, tipoProfessor, preferenciaHorario[varia entre 0 e 100, 0 -> mais carregado no 1º semestre, 50 -> even, 100 -> mais carregado no 2º semestre])
professor(1, 'Anabela', 'Ciencias da Comunicacao', catedratico, 50).
professor(2, 'Josefina', 'Astronomia', associado, 0).
professor(3, 'Bonifacio', 'Arqueologia', auxiliar, 100).
professor(4, 'Gertrudes', 'Servicos Domesticos', catedratico, 50).
professor(5, 'Tony Stark', 'Fisica Nuclear', auxiliar, 100).
professor(6, 'Ricardo', 'Meio Ambiente', associado, 50).
professor(7, 'Henrique', 'Inteligencia artifical', associado, 50).
professor(7, 'Jorge', 'Inteligencia artifical', associado, 50).
 
%areaCientifica(id,nome).
areaCientifica(1, 'Ciencias da Comunicacao').
areaCientifica(2, 'Astronomia').
areaCientifica(4, 'Literacia de Numeracia').
areaCientifica(8, 'Servicos Domesticos').
areaCientifica(9, 'Desporto').
areaCientifica(10, 'Jornalismo').
areaCientifica(16, 'Fisica Avancada').
areaCientifica(17, 'Meio ambiente').
areaCientifica(18, 'Inteligencia artifical').
 
%unidadeCurricular(id, nome, horasTeoricas, horasPraticas, idAreaCientifica, idProfessorAssociado)
unidadeCurricular(1, 'Relacoes Publicas', [3], [4, 4, 2], 1, 1).
unidadeCurricular(2, 'Cosmologia', [2], [4, 4], 2, 2).
unidadeCurricular(3, 'Gatologia', [2], [2,2,2], 8, 4).
unidadeCurricular(4, 'Astronomia Estelar', [4], [3,3,3], 2, 2).
unidadeCurricular(5, 'Metodos Numericos', [1], [2,2], 4, 1).
unidadeCurricular(6, 'Laboratorio de fisica', [0], [3,3,3], 16, 2).
unidadeCurricular(7, 'Probabilidades e Estatistica', [3], [2,2,2], 4, 1).
unidadeCurricular(8, 'Fisica Termica', [1], [3,3,3], 16, 5).
unidadeCurricular(9, 'Microbiologia', [2], [3,3], 17, 6).
unidadeCurricular(10, 'Fisiologia Animal I', [3], [1,1,1], 17, 4).
unidadeCurricular(11, 'Fisiologia Vegetal', [1], [3,3], 17, 4).
unidadeCurricular(12, 'Logica computacional', [2], [3,3,3], 18, 7).
unidadeCurricular(13, 'Metodos de apoio a decisao', [3], [2,2], 18, 7).
unidadeCurricular(14, 'Basquetebol', [0], [3,3,3,3], 18, 7).
unidadeCurricular(15, 'Jornais e Revistas', [2], [2,2,2,2], 10, 7).
 
%tipoProfessor(tipo, cargaHoraria)
tipoProfessor(catedratico, 7).
tipoProfessor(associado, 8).
tipoProfessor(auxiliar, 9).