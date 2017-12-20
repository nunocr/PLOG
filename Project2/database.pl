%professor(id, nome, areaCientifica, tipoProfessor, preferenciaHorario[varia entre 0 e 100, 0 -> mais carregado no 1º semestre, 50 -> even, 100 -> mais carregado no 2º semestre])
professor(1, 'Anabela', 1, 1, 60).
professor(2, 'Josefina', 2, 2, 0).
professor(3, 'Bonifacio', 3, 3, 100).
professor(4, 'Gertrudes', 4, 1, 50).
professor(5, 'Tony Stark', 7, 3, 100).
professor(6, 'Ricardo', 8, 2, 50).
professor(7, 'Henrique', 9, 2, 50).
professor(8, 'Jorge', 9, 2, 50).

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
unidadeCurricular(1, 'Relacoes Publicas', 1, 1, [2, 2, 2], [2, 2]).
unidadeCurricular(2, 'Cosmologia', 2, 1, [3, 3], [2]).
unidadeCurricular(3, 'Gatologia', 3, 1, [2, 2], [3]).
unidadeCurricular(4, 'Astronomia Estelar', 2, 2, [3, 3, 3], [2, 2]).
unidadeCurricular(5, 'Metodos Numericos', 7, 1, [4, 2], [2, 2]).
unidadeCurricular(6, 'Laboratorio de fisica', 7, 1, [2, 2, 2], [3]).
unidadeCurricular(7, 'Probabilidades e Estatistica', 4, 1, [2, 2], [1]).
unidadeCurricular(8, 'Fisica Termica', 7, 2, [2, 2, 2, 2], [3, 3]).
unidadeCurricular(9, 'Microbiologia', 8, 1, [3, 3, 3], [4, 2]).
unidadeCurricular(10, 'Fisiologia Animal I', 8, 2, [2, 2, 2], [2, 2]).
unidadeCurricular(11, 'Fisiologia Vegetal', 8, 2, [4, 4], [2, 2]).
unidadeCurricular(12, 'Logica computacional', 9, 2, [3, 3, 3], [2, 2]).
unidadeCurricular(13, 'Metodos de apoio a decisao', 4, 2, [2, 2, 2], [1, 1]).
unidadeCurricular(14, 'Basquetebol', 5, 2, [4, 4], [2]).
unidadeCurricular(15, 'Jornais e Revistas', 6, 2, [1, 1, 1], [1]).

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