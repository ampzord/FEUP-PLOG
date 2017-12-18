:- use_module(library(lists)).
:- use_module(library(clpfd)).

:- include('utils.pl').
:- include('database.pl').


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

/*
uma unidade curricular(UC) tem horas teoricas (HT) e horas praticas (HP), (HP > HT).
UCs tem areas cientificas


Aulas teoricas atribuidas -> profs da area científica
Aulas praticas atribuidas -> profs da area cientifica (preferencialmente)

Profs -> tem areas cientificas
Profs -> catedraticos, auxiliares e associados (tipo) 7h, 8h e 9h , respectivamente (media entre os 2 semestres) ( a diferença da carga horaria entre os 2 semestres e indicado na pref do Prof)

Variaveis a variar :

numero de UCs
horas a leccionar
numero Profs

MUDA-SE NA BASE DE DADOS EZ
*/

servicoDocente(N_UnidadesCurriculares, N_Professores) :-
	clearScreen,
	nl, write('----- Distribuicao de Servico Docente -----'), nl, nl.

	%criar listas

	%impor dominios
