:- use_module(library(lists)).
:- consult(utils).
:- consult(movements).
:- consult(menu).
:- consult(bot).
:- use_module(library(random)).

% Project Explanation
% Distribuição de Serviço Docente

/*
	Seguem-se as descrições dos problemas. As abordagens devem permitir problemas com diferentes dimensões.
São valorizadas experiências com dimensões elevadas.
Deve ser possível visualizar a solução em modo de texto, de uma forma que facilite a sua validação.

	Um departamento de uma instituição de ensino superior depara-se anualmente com a questão da distribuição do serviço docente pelos professores.
Num ano letivo, cada unidade curricular (UC) a cargo do departamento tem HT horas teóricas e HP horas teórico-práticas semanais para lecionar (tipicamente, HP>HT).
As UCs pertencem a áreas científicas, bem como os professores.
As aulas teóricas têm que ser atribuídas a docentes da respectiva área científica, e as aulas práticas também o devem ser, preferencialmente.
Os professores estão distribuídos entre catedráticos, associados e auxiliares, e devem ter uma carga horária aproximada de 7, 8 e 9h semanais,
respetivamente, na média dos dois semestres.
A diferença permitida de carga horária entre os dois semestres é indicada como preferência do professor,
pois há professores que preferem ter uma média semanal estável,
enquanto que outros podem preferir dar aulas de forma mais concentrada num dos semestres.
Modele este problema como um problema de otimização e resolva-o usando PLR,
de forma a que seja possível resolver problemas desta classe com diferentes parâmetros, isto é, fazendo variar o número de UCs, horas a lecionar,
professores de cada tipo e áreas científicas, bem como as preferências dos professores.
*/

startProgram :-
	repeat,
		clearScreen,
		readStartMenu(Option).

% Ask user which option to take 1-2
readStartMenu(Option) :-
	nl, write('----- Teaching Service Distribution -----'), nl, nl.
	write('1 -> Start'), nl,
	write('2 -> Exit'), nl,
	write('> '), read(Option),
	Option >= 1, Option =< 2.
