/* Bibliotecas */
:- use_module(library(lists)).
:- use_module(library(clpfd)).

:- include('utils.pl').
:- include('small_base_de_dados.pl').

/* ------------------------------------------------------------------ Getters ------------------------------------------------------------------ */

% Lista com todos os professores
getListaDeProfessores(ListaDeProfs):-
	findall([ID, Nome, AreaCientifica, TipoProfessor, PreferenciaHoraria], professor(ID, Nome, AreaCientifica, TipoProfessor, PreferenciaHoraria), ListaDeProfs).

% Lista com todas as UCs - Semestre 1
getListaDeUCs_Semestre1(ListaDeUCs_Semestre1):-
	findall([ID, Nome, AreaCientifica, HorasPraticas, HorasTeoricas], unidadeCurricular(ID, Nome, AreaCientifica, HorasPraticas, HorasTeoricas), ListaDeUCs_Semestre1).

% Lista com todas as UCs - Semestre 2
getListaDeUCs_Semestre2(ListaDeUCs_Semestre2):-
	findall([ID, Nome, AreaCientifica, HorasPraticas, HorasTeoricas], unidadeCurricular2(ID, Nome, AreaCientifica, HorasPraticas, HorasTeoricas), ListaDeUCs_Semestre2).

%Cria por cada unidadeCurricular - Semestre 1 uma lista com 2 variaveis nao instanciadas [Horas Praticas, Horas Teoricas]
getProfessorListaDeTodasUCs_Semestre1(ListaDeHorasPra_HorasTeo):-
	findall([_,_], unidadeCurricular(_, _, _, _, _), ListaDeHorasPra_HorasTeo).

%Cria por cada unidadeCurricular - Semestre 2 uma lista com 2 variaveis nao instanciadas [Horas Praticas, Horas Teoricas]
getProfessorListaDeTodasUCs_Semestre2(ListaDeHorasPra_HorasTeo):-
	findall([_,_], unidadeCurricular2(_, _, _, _, _), ListaDeHorasPra_HorasTeo).

/* ------------------------------------------------------------------ Getters ------------------------------------------------------------------ */

/* ------------------------------------------------------------------ Restrições ------------------------------------------------------------------ */

restrictProfessorCargaTotal([], [], _).
restrictProfessorCargaTotal([Head_Sem1 | Tail_Sem1], [Head_Sem2 | Tail_Sem2], ID) :-
	tipoProfessor(ID_TipoProf,_, Carga),
	professor(ID,_,_, ID_TipoProf,_),
	CargaTotal is Carga * 2,
	Head_Sem1 + Head_Sem2 #= CargaTotal,
	NewID is ID + 1,
	restrictProfessorCargaTotal(Tail_Sem1, Tail_Sem2, NewID).

% ------------ Semestre 1 ------------ %

restrictUCHoras_Semestre1([],_,_).
restrictUCHoras_Semestre1([Head | Tail], CurrLinha, CurrColuna):-
	unidadeCurricular(CurrLinha,_, AreaCientifica, HorasPraticas, HorasTeoricas),
	restrictUCHoras1_Semestre1(Head, CurrLinha, CurrColuna, ContadorTeorica, ContadorPratica),
	ContadorPratica #= HorasPraticas,
	ContadorTeorica #= HorasTeoricas,
	NewLinha is CurrLinha + 1,
	restrictUCHoras_Semestre1(Tail, NewLinha, CurrColuna).

restrictUCHoras1_Semestre1([],_,_,0,0).
restrictUCHoras1_Semestre1([[Pratica,Teorica] | List], CurrLinha, CurrColuna, NewContadorTeorica, NewContadorPratica):-
	NewColuna is CurrColuna + 1,
	restrictUCHoras1_Semestre1(List, CurrLinha, NewColuna, ContadorTeorica2, ContadorPratica2),
	NewContadorPratica #= ContadorPratica2 + Pratica,
	NewContadorTeorica #= ContadorTeorica2 + Teorica.

restrictUCArea_Semestre1([], _, _, [], 0).
restrictUCArea_Semestre1([Head | Tail], CurrLinha, CurrColuna, [Head_Carga | Tail_Cargas], ContadorForaDaArea) :-
	restrictUCArea1_Semestre1(Head, CurrLinha, CurrColuna, ValorForaDaArea),
	append(Head, Horas),
	NextRow is CurrLinha + 1,
	restrictUCArea_Semestre1(Tail, NextRow, CurrColuna, Tail_Cargas, NewContadorForaDaArea),
	sum(Horas, #=, Head_Carga),
	ContadorForaDaArea #= NewContadorForaDaArea + ValorForaDaArea.

restrictUCArea1_Semestre1([], _, _, 0).
restrictUCArea1_Semestre1([Head | Tail], CurrLinha, CurrColuna, ContadorForaDaArea) :-
	restrictUCArea2_Semestre1(Head, CurrLinha, CurrColuna, ValorForaDaArea),
	NextCol is CurrColuna + 1,
	restrictUCArea1_Semestre1(Tail, CurrLinha, NextCol, NewContadorForaDaArea),
	ContadorForaDaArea #= NewContadorForaDaArea + ValorForaDaArea.

restrictUCArea2_Semestre1([Pratica,Teorica], CurrLinha, CurrColuna, Pratica):-
	professor(CurrLinha, _, Prof_AreaCientifica, _, _),
	unidadeCurricular(CurrColuna, _, UC_AreaCientifica, _, _),
	Prof_AreaCientifica \= UC_AreaCientifica,
	Teorica #= 0. %Se o professor nao é da mesma area cientifica nunca pode dar teorica.

restrictUCArea2_Semestre1(_, _, _, 0).

% ------------ Semestre 2 ------------ %

restrictUCHoras_Semestre2([],_,_).
restrictUCHoras_Semestre2([Head | Tail],CurrLinha,CurrColuna):-
	unidadeCurricular2(CurrLinha,_, AreaCientifica, HorasPraticas, HorasTeoricas),
	restrictUCHoras1_Semestre2(Head, CurrLinha, CurrColuna, ContadorTeorica, ContadorPratica),
	ContadorPratica #= HorasPraticas,
	ContadorTeorica #= HorasTeoricas,
	NewLinha is CurrLinha + 1,
	restrictUCHoras_Semestre2(Tail, NewLinha, CurrColuna).

restrictUCHoras1_Semestre2([],_,_,0,0).
restrictUCHoras1_Semestre2([[Pratica,Teorica] | List], CurrLinha, CurrColuna, NewContadorTeorica, NewContadorPratica):-
	NewColuna is CurrColuna + 1,
	restrictUCHoras1_Semestre2(List, CurrLinha, NewColuna, ContadorTeorica2, ContadorPratica2),
	NewContadorPratica #= ContadorPratica2 + Pratica,
	NewContadorTeorica #= ContadorTeorica2 + Teorica.

restrictUCArea_Semestre2([], _, _, [], 0).
restrictUCArea_Semestre2([Head | Tail], CurrLinha, CurrColuna, [Head_Carga | Tail_Cargas], ContadorForaDaArea) :-
	restrictUCArea1_Semestre2(Head, CurrLinha, CurrColuna, ValorForaDaArea),
	append(Head,Horas),
	NextRow is CurrLinha + 1,
	restrictUCArea_Semestre2(Tail, NextRow, CurrColuna, Tail_Cargas, NewContadorForaDaArea),
	sum(Horas, #=, Head_Carga),
	ContadorForaDaArea #= NewContadorForaDaArea + ValorForaDaArea.

restrictUCArea1_Semestre2([], _, _, 0).
restrictUCArea1_Semestre2([Head | Tail], CurrLinha, CurrColuna, ContadorForaDaArea) :-
	restrictUCArea2_Semestre1(Head, CurrLinha, CurrColuna, ValorForaDaArea),
	NextCol is CurrColuna + 1,
	restrictUCArea1_Semestre2(Tail, CurrLinha, NextCol, NewContadorForaDaArea),
	ContadorForaDaArea #= NewContadorForaDaArea + ValorForaDaArea.

restrictUCArea2_Semestre2([Pratica,Teorica], CurrLinha, CurrColuna, Pratica):-
	professor(CurrLinha, _, Prof_AreaCientifica, _, _),
	unidadeCurricular(CurrColuna, _, UC_AreaCientifica, _, _),
	Prof_AreaCientifica \= UC_AreaCientifica,
	Teorica #= 0. %Se o professor nao é da mesma area cientifica nunca pode dar teorica.

restrictUCArea2_Semestre2(_, _, _, 0).


/* ------------------------------------------------------------------ Restrições ------------------------------------------------------------------ */


% Por cada UC que existe cria uma lista de [HP,HT] variaveis nao instancias que simbolizam as horas que um professor
% vai dar aulas à respectiva UC.
matrizSolucao_Semestre1(Linha, Linha, []).
matrizSolucao_Semestre1(CurrLinha, MaxLinha, [Head | Tail]):-
	getProfessorListaDeTodasUCs_Semestre1(Head),
	NewLinha is CurrLinha + 1,
	matrizSolucao_Semestre1(NewLinha, MaxLinha, Tail).

matrizSolucao_Semestre2(Linha, Linha, []).
matrizSolucao_Semestre2(CurrLinha, MaxLinha, [Head | Tail]):-
	getProfessorListaDeTodasUCs_Semestre2(Head),
	NewLinha is CurrLinha + 1,
	matrizSolucao_Semestre2(NewLinha, MaxLinha, Tail).

getHorasPref_Semestre1(ProfID, HoursFirstSemester) :-
	professor(ProfID, ProfName, _ProfArea, ProfTypeID, ProfDistributionPreference),
	tipoProfessor(ProfTypeID, _, Hours),
	TotalHours is Hours * 2,
	HoursFirstSemester is (100 - ProfDistributionPreference) * TotalHours.

getHorasPref_Semestre2(ProfID, HoursSecondSemester) :-
	professor(ProfID, ProfName, _ProfArea, ProfTypeID, ProfDistributionPreference),
	tipoProfessor(ProfTypeID, _, Hours),
	TotalHours is Hours * 2,
	HoursSecondSemester is ProfDistributionPreference * TotalHours.

createProfessorPrefHorasIdeais(ID_Prof, [[HorasSemestre_1, HorasSemestre_2] | Tail]) :-
	getHorasPref_Semestre1(ID_Prof, HorasSemestre_1),
	getHorasPref_Semestre2(ID_Prof, HorasSemestre_2),
	NewID_Prof is ID_Prof + 1,
	createProfessorPrefHorasIdeais(NewID_Prof, Tail).

createProfessorPrefHorasIdeais(_, []).

appendHoras2Semestres([], [], []).
appendHoras2Semestres([Head_Horas_Semestre1 | Tail_HorasSemestre1], [Head_Horas_Semestre2 | Tail_HorasSemestre2], [[NewHours1, NewHours2]| NewList]) :-
	NewHours1 #= 100 * Head_Horas_Semestre1,
	NewHours2 #= 100 * Head_Horas_Semestre2,
	appendHoras2Semestres(Tail_HorasSemestre1, Tail_HorasSemestre2, NewList).


countHorasDiff([],[], 0).
countHorasDiff([Head_HorasAtuaisProfs | Tail_HorasAtuaisProfs], [Head_HorasIdeais | Tail_HorasIdeais], Soma) :-
	countHorasDiff(Tail_HorasAtuaisProfs, Tail_HorasIdeais, NewSoma),
	Soma #= NewSoma + abs(Head_HorasAtuaisProfs - Head_HorasIdeais).

showSolucao([], _, _).
showSolucao([Head | Tail], ProfAtual, 1) :-
	professor(ProfAtual, NomeProf, AreaProf, TipoProf, _),
	areaCientifica(AreaProf, _),
	tipoProfessor(TipoProf, _, _),
	write(NomeProf), nl,
	aulasPrimeiroSemestre(Head, 1), nl,
	NextProf is ProfAtual + 1,
	showSolucao(Tail, NextProf, 1).

showSolucao([Head | Tail], ProfAtual, 2) :-
	professor(ProfAtual, NomeProf, AreaProf, TipoProf, _),
	areaCientifica(AreaProf, _),
	tipoProfessor(TipoProf, _, _),
	write(NomeProf), nl,
	aulasSegundoSemestre(Head, 1), nl,
	NextProf is ProfAtual + 1,
	showSolucao(Tail, NextProf, 2).
	
aulasPrimeiroSemestre([], _).
aulasPrimeiroSemestre([[HorasPraticas, HorasTeoricas]|Tail], UCAtual) :-
	unidadeCurricular(UCAtual, NomeUC, _, _, _),
	write('        '), write(NomeUC),  write(': '), 
	write(' Horas praticas: '), write(HorasPraticas), write(' | '), write(' Horas teoricas: '), write(HorasTeoricas),  nl,
	NextClass is UCAtual + 1,
	aulasPrimeiroSemestre(Tail, NextClass).
	
aulasSegundoSemestre([], _).
aulasSegundoSemestre([[HorasPraticas,HorasTeoricas]|Tail], UCAtual) :-
	unidadeCurricular2(UCAtual, NomeUC, _, _, _),
	write('        '), write(NomeUC),  write(': '), 
	write(' Horas praticas: '), write(HorasPraticas), write(' | '), write(' Horas teoricas: '), write(HorasTeoricas),  nl,
	NextClass is UCAtual + 1,
	aulasSegundoSemestre(Tail, NextClass).

servicoDocente :-
	clrScrn,
	title,
	%Buscar informação à base de dados
	getListaDeProfessores(ListaDeProfs),

	length(ListaDeProfs, Linha),
	MaxLinhas is Linha + 1,

	matrizSolucao_Semestre1(1, MaxLinhas, MatrizSol_Semestre1),
	matrizSolucao_Semestre2(1, MaxLinhas, MatrizSol_Semestre2),

	transpose(MatrizSol_Semestre1, MatrizSolTransposta_Sem1),
	transpose(MatrizSol_Semestre2, MatrizSolTransposta_Sem2),

	% Flatten Semestre 1
	append(MatrizSolTransposta_Sem1, MatrizSolTransposta1_Sem1),
	append(MatrizSolTransposta1_Sem1, MatrizSolTransposta12_Sem1),

	% Flatten Semestre 2
	append(MatrizSolTransposta_Sem2, MatrizSolTransposta2_Sem2),
	append(MatrizSolTransposta2_Sem2,MatrizSolTransposta22_Sem2),

	% Flatten Semestre 1 + Semestre 2
	append(MatrizSolTransposta12_Sem1, MatrizSolTransposta22_Sem2, MatrizSolFlatten),


	%Aplicar dominio aos 2 Semestres - Professor auxiliar pode dar até 9 horas.
	domain(MatrizSolFlatten, 0, 9),

	%Aplicar Restrições
	restrictUCHoras_Semestre1(MatrizSolTransposta_Sem1, 1, 1),
	restrictUCHoras_Semestre2(MatrizSolTransposta_Sem2, 1, 1),

	restrictUCArea_Semestre1(MatrizSol_Semestre1, 1, 1, HorasProfessores_Semestre1, Contador_ForaDaAreaCientifica_Semestre1),
	restrictUCArea_Semestre2(MatrizSol_Semestre2, 1, 1, HorasProfessores_Semestre2, Contador_ForaDaAreaCientifica_Semestre2),

	restrictProfessorCargaTotal(HorasProfessores_Semestre1, HorasProfessores_Semestre2, 1),
	

	appendHoras2Semestres(HorasProfessores_Semestre1, HorasProfessores_Semestre2, HorasProfs_2_SemestresAux),
	createProfessorPrefHorasIdeais(1, HorasIdeaisAux),

	% Flatten
	append(HorasProfs_2_SemestresAux, HorasProfs2Semestres), 
	append(HorasIdeaisAux, HorasIdeais), 

	countHorasDiff(HorasProfs2Semestres, HorasIdeais, ValorMinimo),

	ValorParaMinimizar #= ValorMinimo + Contador_ForaDaAreaCientifica_Semestre1*100 + Contador_ForaDaAreaCientifica_Semestre2*100,
	statistics(walltime, _),
	labeling([time_out(30000, _), minimize(ValorParaMinimizar)], MatrizSolFlatten),
	statistics(walltime, [_ | [TempoExecucao]]),

	write('Primeiro Semestre'), nl,
	write('================='), nl,nl,
	showSolucao(MatrizSol_Semestre1, 1, 1), nl,
	
	write('Segundo Semestre'), nl,
	write('================'), nl,nl,
	showSolucao(MatrizSol_Semestre2, 1, 2),
	
	write('Tempo execucao: '), write(TempoExecucao), write(' milisegundos.').

