%professor(id, nome, areaCientifica, tipoProfessor, preferenciaHorario[varia entre 0 e 100, 0 -> mais carregado no 1º semestre, 50 -> even, 100 -> mais carregado no 2º semestre])
professor(1, 'Anabela', 'Ciencias da Comunicacao', catedratico, 50).
professor(2, 'Josefina', 'Astronomia', associado, 0).
professor(3, 'Bonifacio', 'Arqueologia', auxiliar, 100).
professor(4, 'Gertrudes', 'Servicos Domesticos', catedratico, 50).
professor(5, 'Tony Stark', 'Fisica Nuclear', auxiliar, 100).

%areaCientifica(id,nome).
areaCientifica(1, 'Ciencias da Comunicacao').
areaCientifica(2, 'Astronomia').
areaCientifica(3, 'Aprendizagem de linguas').
areaCientifica(4, 'Literacia de Numeracia').
areaCientifica(5, 'Horticultura').
areaCientifica(6, 'Produção agrícola e animal').
areaCientifica(7, 'Belas-Artes').
areaCientifica(8, 'Servicos Domesticos').
areaCientifica(9, 'Desporto').
areaCientifica(10, 'Jornalismo').
areaCientifica(11, 'Segurança alimentar e saude publica').
areaCientifica(12, 'Ciencias sociais e comportamentais sem definicao precisa').
areaCientifica(13, 'Materiais').
areaCientifica(14, 'Marketing e publicidade').
areaCientifica(15, 'Secretariado e trabalho administrativo').
areaCientifica(16, 'Fisica Avancada').

%unidadeCurricular(id, nome, horasTeoricas, horasPraticas, idAreaCientifica, idProfessorAssociado)
unidadeCurricular(1, 'Relacoes Publicas', [3], [4, 4, 2], 1, 1).
unidadeCurricular(2, 'Cosmologia', [2], [4, 4], 2, 2).
unidadeCurricular(3, 'Gatologia', [2], [2,2,2], 8, 4).
unidadeCurricular(4, 'Astronomia Estelar', [4], [3,3,3], 2, 2).
unidadeCurricular(5, 'Metodos Numericos', [1], [2,2], 4, 1).
unidadeCurricular(6, 'Laboratorio de fisica', [0], [3,3,3], 16, 2).
unidadeCurricular(7, 'Probabilidades e Estatistica', [3], [2,2,2], 4, 1).
unidadeCurricular(8, 'Fisica Termica', [1], [3,3,3], 16, 5).

unidadeCurricular(9, 'Gatologia', [2], [2,2,2], 8, 4).
unidadeCurricular(10, 'Gatologia', [2], [2,2,2], 8, 4).
unidadeCurricular(11, 'Gatologia', [2], [2,2,2], 8, 4).
unidadeCurricular(12, 'Gatologia', [2], [2,2,2], 8, 4).
unidadeCurricular(13, 'Gatologia', [2], [2,2,2], 8, 4).

%tipoProfessor(tipo, cargaHoraria)
tipoProfessor(catedratico, 7).
tipoProfessor(associado, 8).
tipoProfessor(auxiliar, 9).