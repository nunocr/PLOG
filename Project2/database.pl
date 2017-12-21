%professor(id, nome, areaCientifica, tipoProfessor, preferenciaHorario[varia entre 0 e 100, 0 -> mais carregado no 1º semestre, 50 -> even, 100 -> mais carregado no 2º semestre])
professor(1, 'Anabela', 1, 1, 60).
professor(2, 'Josefina', 2, 2, 0).
professor(3, 'Bonifacio', 3, 3, 100).
professor(4, 'Gertrudes', 4, 1, 50).
professor(5, 'Tony Stark', 7, 3, 100).
professor(6, 'Ricardo', 8, 2, 50).
professor(7, 'Henrique', 9, 2, 50).
professor(8, 'Jorge', 9, 2, 50).
professor(9, 'Barbosa', 9, 2, 50).
professor(10, 'Cardoso', 9, 2, 50).
professor(11, 'Mourisco', 8, 2, 50).
professor(12, 'Joao Ratao', 7, 3, 100).
professor(13, 'Anita', 4, 1, 50).
professor(14, 'Joao Jardim', 3, 3, 100).
professor(15, 'Sereno', 2, 2, 0).
professor(16, 'Rita', 1, 1, 60).

%areaCientifica(id,nome).
areaCientifica(1, 'Ciencias da Comunicacao').
areaCientifica(2, 'Astronomia').
areaCientifica(3, 'Literacia de Numeracia').
areaCientifica(4, 'Servicos Domesticos').
areaCientifica(5, 'Desporto').
areaCientifica(6, 'Jornalismo').
areaCientifica(7, 'Fisica Avancada').
areaCientifica(8, 'Meio ambiente').
areaCientifica(9, 'Inteligencia artifical').

%Unidade Curricular
%UC(id, nome, AreaCientifica, semestre, horasPraticas, horasTeoricas)
unidadeCurricular(1, 'Relacoes Publicas'			, 1, 6, 4).
unidadeCurricular(2, 'Cosmologia'					, 2, 6, 2).
unidadeCurricular(3, 'Gatologia'					, 3, 4, 3).
%unidadeCurricular(4, 'Metodos Numericos'			, 7, 6, 4).
%unidadeCurricular(5, 'Laboratorio de fisica'		, 7, 6, 3).
%unidadeCurricular(6, 'Probabilidades e Estatistica'	, 4, 4, 1).
%unidadeCurricular(7, 'Microbiologia'				, 8, 9, 6).

unidadeCurricular2(1, 'Fisica Termica'				, 7, 8, 6).
unidadeCurricular2(2, 'Fisiologia Animal I'			, 8, 6, 4).
%unidadeCurricular2(3, 'Fisiologia Vegetal'			, 8, 8, 4).
%unidadeCurricular2(5, 'Metodos de apoio a decisao'	, 4, 6, 2).
%unidadeCurricular2(6, 'Basquetebol'					, 5, 8, 2).
%unidadeCurricular2(7, 'Jornais e Revistas'			, 6, 3, 1).
%unidadeCurricular2(8, 'Astronomia Estelar'			, 2, 9, 4).

%tipoProfessor(ID, tipo, cargaHoraria)
tipoProfessor(1, 'catedratico', 7).
tipoProfessor(2, 'associado', 8).
tipoProfessor(3, 'auxiliar', 9).

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
