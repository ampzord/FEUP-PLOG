%professor(id, nome, areaCientifica, tipoProfessor, preferenciaHorario) 0 - 1o semestre; 100 - segundo

%areaCientifica(id,nome).

%UC(id, nome, AreaCientifica, horasPraticas, horasTeoricas)

%tipoProfessor(ID, tipo, cargaHoraria)

professor(1, 'Anabela', 1, 1, 50).
professor(2, 'Josefina', 1, 2, 0).

areaCientifica(1, 'Ciencias da Comunicacao').

unidadeCurricular(1, 'Relacoes Publicas'			, 1, 10, 5).
unidadeCurricular2(1, 'Fisica Termica'				, 1, 5, 10).

tipoProfessor(1, 'catedratico', 7).
tipoProfessor(2, 'associado', 8).
tipoProfessor(3, 'auxiliar', 9).