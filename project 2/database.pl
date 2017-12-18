%areaCientifica(id,nome).
areaCientifica(1, 'Ciencias da Comunicacao').
areaCientifica(2, 'Astronomia').
areaCientifica(3, 'Arqueologia').
areaCientifica(4, 'Literacia de Numeracia').
areaCientifica(5, 'Servicos Domesticos').
areaCientifica(6, 'Desporto').
areaCientifica(7, 'Jornalismo').
areaCientifica(8, 'Fisica Avancada').
areaCientifica(9, 'Meio ambiente').
areaCientifica(10, 'Inteligencia artifical').
areaCientifica(11, 'Computacao Baixo Nivel').
areaCientifica(12, 'Fisica Nuclear').

%professor(id, nome, idareaCientifica, tipoProfessor, preferenciaHorario[varia entre 0 e 100, 0 -> mais carregado no 1º semestre, 50 -> even, 100 -> mais carregado no 2º semestre])
professor(1, 'Anabela', 1, catedratico, 50).
professor(2, 'Josefina', 2, associado, 0).
professor(3, 'Bonifacio', 3, auxiliar, 100).
professor(4, 'Gertrudes', 5, catedratico, 50).
professor(5, 'Tony Stark', 12, auxiliar, 100).
professor(6, 'Ricardo', 9, associado, 0).
professor(7, 'Henrique', 10, associado, 50).
professor(8, 'Jorge', 7, catedratico, 100).
professor(9, 'Souto', 11, associado, 50).
professor(10, 'Trump', 9, auxiliar, 0)

%unidadeCurricular(id, nome, horasTeoricas, horasPraticas, idAreaCientifica, idProfessorAssociado)
unidadeCurricular(1, 'Relacoes Publicas', [3], [4, 4, 2], 1, 1).
unidadeCurricular(2, 'Cosmologia', [2], [4, 4], 2, 2).
unidadeCurricular(3, 'Gatologia', [2], [2,2,2], 5, 4).
unidadeCurricular(4, 'Astronomia Estelar', [4], [3,3,3], 2, 2).
unidadeCurricular(5, 'Metodos Numericos', [1], [2,2], 4, 1).
unidadeCurricular(6, 'Laboratorio de fisica', [0], [3,3,3], 8, 2).
unidadeCurricular(7, 'Probabilidades e Estatistica', [3], [2,2,2], 4, 1).
unidadeCurricular(8, 'Fisica Termica', [1], [3,3,3], 8, 5).
unidadeCurricular(9, 'Microbiologia', [2], [3,3], 9, 6).
unidadeCurricular(10, 'Fisiologia Animal I', [3], [1,1,1], 9, 4).
unidadeCurricular(11, 'Fisiologia Vegetal', [1], [3,3], 9, 4).
unidadeCurricular(12, 'Logica computacional', [2], [3,3,3], 10, 7).
unidadeCurricular(13, 'Metodos de apoio a decisao', [3], [2,2], 10, 7).
unidadeCurricular(14, 'Basquetebol', [0], [3,3,3,3], 6, 7).
unidadeCurricular(15, 'Jornais e Revistas', [2], [2,2,2,2], 7, 8).
unidadeCurricular(16, 'Laboratorio de Computadores', [1,1], [3,3,3,3], 11, 9).
unidadeCurricular(17, 'Microprocessadores', [2,2], [2,2,2], 11, 9).
unidadeCurricular(18, 'Desenho e Análise de Algoritmos', [2], [1,1,1], 10, 7).
unidadeCurricular(19, 'Compiladores', [3], [2,2,2,2], 11, 9).
unidadeCurricular(20, 'Ordenacao Territorial', [2], [2,2,2,2], 9, 10).

%tipoProfessor(tipo, cargaHoraria)
tipoProfessor(catedratico, 7).
tipoProfessor(associado, 8).
tipoProfessor(auxiliar, 9).
