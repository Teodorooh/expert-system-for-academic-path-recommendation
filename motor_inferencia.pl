% =========================================================
%  SISTEMA ESPECIALISTA – Recomendacao de Trilha Acadêmica
%  [MOTOR DE INFERENCIA]
% =========================================================
%
%  Contém:
%   • score_bipolar_alta/2, score_bipolar_baixa/2
%   • calcula_pontuacao/3
%   • calcula_ranking/1, recomenda/2
%   • utilitário: sum_scores/2
%

% ---------- Regras de pontuacao das bipolares ----------
%  ALTA = lado Y (segundo termo do texto "X ou Y")
%  BAIXA = lado X (primeiro termo do texto "X ou Y")
score_bipolar_alta(Nota, S)  :- (Nota =:= 5 -> S = 2 ; Nota =:= 4 -> S = 1 ; S = 0).
score_bipolar_baixa(Nota, S) :- (Nota =:= 1 -> S = 2 ; Nota =:= 2 -> S = 1 ; S = 0).

% Soma a segunda componente de uma lista de pares ID-Score
% Ex.: [5-2, 8-1, 9-0] -> 3
sum_scores([], 0).
sum_scores([_-S|R], Total) :- sum_scores(R, T), Total is T + S.

% ---------- Calcula pontuacao de UMA trilha ----------
%  Entrada : Trilha (atom)
%  Saídas  : Pontos (int), Justif (lista de pares ID-Score)
calcula_pontuacao(Trilha, Pontos, Justif) :-
    trilha(Trilha, _),

    % 1) Unipolares (Nota >= Limiar => +1)
    findall(ID-1,
        ( pergunta_u(ID, _, Trilha, Limiar),
          resposta_nota(ID, Nota),
          Nota >= Limiar ),
        JUni),

    % 2a) Bipolares (lado ALTO – Y) → 4..5
    findall(ID-S,
        ( pergunta_b(ID, _, Trilha, _),
          resposta_nota(ID, Nota),
          score_bipolar_alta(Nota, S),
          S > 0 ),
        JBiAlta),

    % 2b) Bipolares (lado BAIXO – X) → 1..2
    findall(ID-S,
        ( pergunta_b(ID, _, _, Trilha),
          resposta_nota(ID, Nota),
          score_bipolar_baixa(Nota, S),
          S > 0 ),
        JBiBaixa),

    % Junta justificativas em uma lista só: [ID-Score, ...]
    append(JUni, JBiAlta, T1),
    append(T1, JBiBaixa, Justif),

    % Soma das pontuações finais
    sum_scores(Justif, Pontos).

% ---------- Monta o RANKING (ordem decrescente por pontos) ----------
% Saída: [(Pontos, Trilha, Justif), ...] (maior → menor)
calcula_ranking(RankingDesc) :-
    findall(P-T-J, calcula_pontuacao(T, P, J), L),  % P é chave de ordenação
    keysort(L, LOrd),                               % ordena por P asc
    reverse(LOrd, Inv),                             % inverte para desc
    maplist(tripla, Inv, RankingDesc).

% Estética: P-T-J -> (P, T, J)
tripla(P-T-J, (P, T, J)).

% ---------- Seleciona as trilhas TOP (resolve empate) ----------
recomenda(Ranking, Melhores) :-
    Ranking = [(Max, _, _) | _],
    findall(T, member((Max, T, _), Ranking), Melhores).
