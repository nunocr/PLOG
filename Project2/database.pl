%professor(id, nome, areaCientifica, tipoProfessor, preferenciaHorario[varia entre 0 e 100, 0 -> mais carregado no 1º semestre, 50 -> even, 100 -> mais carregado no 2º semestre])
professor(1, 'Anabela', 101, 301, 60).
professor(2, 'Josefina', 102, 302, 0).
professor(3, 'Bonifacio', 104, 303, 100).
professor(4, 'Gertrudes', 108, 301, 50).
professor(5, 'Tony Stark', 116, 303, 100).
professor(6, 'Ricardo', 117, 302, 50).
professor(7, 'Henrique', 118, 302, 50).
professor(8, 'Jorge', 118, 302, 50).

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
%UC(id, nome, AreaCientifica, semestre, horasPraticas, horasTeoricas)
unidadeCurricular(201, 'Relacoes Publicas', 101, 1, 20, 5).
unidadeCurricular(202, 'Cosmologia', 102, 1, 30, 5).
unidadeCurricular(203, 'Gatologia', 104, 1, 15, 5).
unidadeCurricular(204, 'Astronomia Estelar', 102, 2, 10, 5).
unidadeCurricular(205, 'Metodos Numericos', 116, 1, 5, 5).
unidadeCurricular(206, 'Laboratorio de fisica', 116, 1, 20, 4).
unidadeCurricular(207, 'Probabilidades e Estatistica', 108, 1, 5, 5).
unidadeCurricular(208, 'Fisica Termica', 116, 2, 10, 5).
unidadeCurricular(209, 'Microbiologia', 117, 1, 20, 10).
unidadeCurricular(210, 'Fisiologia Animal I', 117, 2, 20, 10).
unidadeCurricular(211, 'Fisiologia Vegetal', 117, 2, 20, 10).
unidadeCurricular(212, 'Logica computacional', 118, 2, 15, 5).
unidadeCurricular(213, 'Metodos de apoio a decisao', 108, 2, 5, 5).
unidadeCurricular(214, 'Basquetebol', 109, 2, 20, 5).
unidadeCurricular(215, 'Jornais e Revistas', 110, 2, 5, 5).

%tipoProfessor(ID, tipo, cargaHoraria)
tipoProfessor(301, 'catedratico', 7).
tipoProfessor(302, 'associado', 8).
tipoProfessor(303, 'auxiliar', 9).

%Lista de lista de cenas e tal
%Linhas = Professores
%Colunas = UCs
%Cada professor tem uma lista de todas as UCs da base de dados.
%Se o professor nao lecciona essa UC, os seus parametros de Horas Teoricas e Praticas sera 0s
%A soma dos elementos de uma coluna sera o total das praticas/teoricas, para cada semestre

%ProfsUcsBoard([[0, 0, 0, 0, 0],
%		           [0, 0, 0, 0, 0],
%		           [0, 0, 0, 0, 0],
%		           [0, 0, 0, 0, 0],
%		           [0, 0, 0, 0, 0]]).
%