%professor(id, nome, areaCientifica, tipoProfessor, preferenciaHorario[varia entre 0 e 100, 0 -> mais carregado no 1º semestre, 50 -> even, 100 -> mais carregado no 2º semestre])
professor(1, 'Anabela', 'Ciencias da Comunicacao', catedratico, 50).
professor(2, 'Josefina', 'Astronomia', associado, 0).
professor(3, 'Bonifacio', 'Arqueologia', auxiliar, 100).
professor(4, 'Gertrudes', 'Servicos Domesticos', catedratico, 50).
professor(5, 'Tony Stark', 'Fisica Nuclear', auxiliar, 100).
professor(6, 'Ricardo', 'Meio Ambiente', associado, 50).
professor(7, 'Henrique', 'Inteligencia artifical', associado, 50).
professor(8, 'Jorge', 'Inteligencia artifical', associado, 50).

%areaCientifica(id,nome).
areaCientifica(101, 'Ciencias da Comunicacao').
areaCientifica(102, 'Astronomia').
areaCientifica(104, 'Literacia de Numeracia').
areaCientifica(108, 'Servicos Domesticos').
areaCientifica(109, 'Desporto').
areaCientifica(110, 'Jornalismo').
areaCientifica(116, 'Fisica Avancada').
areaCientifica(117, 'Meio ambiente').
areaCientifica(118, 'Inteligencia artifical').

%Unidade Curricular
%UC(id, nome, AreaCientifica, Praticas 1º Semestre, Teoricas 1º Semestre, Praticas 2º Semestre, Teoricas 2º Semestre)
unidadeCurricular(201, 'Relacoes Publicas', 101, 20, 5, 20, 5).
unidadeCurricular(202, 'Cosmologia', 102, 30, 5, 30, 5).
unidadeCurricular(203, 'Gatologia', 104, 15, 5, 15, 5).
unidadeCurricular(204, 'Astronomia Estelar', 102, 10, 5, 10, 5).
unidadeCurricular(205, 'Metodos Numericos', 116, 5, 5, 5, 5).
unidadeCurricular(206, 'Laboratorio de fisica', 116, 20, 4, 20, 4).
unidadeCurricular(207, 'Probabilidades e Estatistica', 108, 5, 5, 5, 5).
unidadeCurricular(208, 'Fisica Termica', 116, 10, 5, 10, 5).
unidadeCurricular(209, 'Microbiologia', 117, 20, 10, 20, 10).
unidadeCurricular(210, 'Fisiologia Animal I', 117, 20, 10, 20, 10).
unidadeCurricular(211, 'Fisiologia Vegetal', 117, 20, 10, 20, 10).
unidadeCurricular(212, 'Logica computacional', 118, 15, 5, 15, 5).
unidadeCurricular(213, 'Metodos de apoio a decisao', 108, 5, 5, 5, 5).
unidadeCurricular(214, 'Basquetebol', 109, 20, 5, 20, 5).
unidadeCurricular(215, 'Jornais e Revistas', 110, 5, 5, 5, 5).

%tipoProfessor(tipo, cargaHoraria)
tipoProfessor(catedratico, 7).
tipoProfessor(associado, 8).
tipoProfessor(auxiliar, 9).

%Lista de lista de cenas e tal
%Linhas = Professores
%Colunas = UCs
%Cada professor tem uma lista de todas as UCs da base de dados.
%Se o professor nao lecciona essa UC, os seus parametros de Horas Teoricas e Praticas sera 0s
%A soma dos elementos de uma coluna sera o total das praticas/teoricas, para cada semestre

ProfsUcsBoard([[0, 0, 0, 0, 0],
		           [0, 0, 0, 0, 0],
		           [0, 0, 0, 0, 0],
		           [0, 0, 0, 0, 0],
		           [0, 0, 0, 0, 0]]).
