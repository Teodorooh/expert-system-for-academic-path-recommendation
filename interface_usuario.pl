% =========================================================
%  SISTEMA ESPECIALISTA – Recomendacao de Trilha Acadêmica
%  [INTERFACE / FLUXO E I/O]
% =========================================================
%
%  Contém:
%   • iniciar/0 (ponto de entrada)
%   • cabecalho/0
%   • faz_perguntas/0, pergunta_guardada/2, pergunta_1a5/3
%   • exibe_resultado/1, exibe_contribuicoes/1, get_texto_pergunta/2
%   • executar_teste/2 (modo teste)
%

:- dynamic resposta_nota/2.   % fato dinâmico onde guardamos (ID, Nota 1..5)

% ---------- CABEÇALHO ----------
cabecalho :-
    writeln('=============================================='),
    writeln('  Sistema de Recomendacao de Trilhas (Prolog) '),
    writeln('=============================================='),
    writeln('Voce respondera 10 perguntas (4 unipolares + 6 bipolares).'),
    writeln('Escala: 1..5'),
    writeln('  Unipolar: nota >= limiar => +1 para a trilha alvo.'),
    writeln('  Bipolar ("X ou Y"): 1=+2 X | 2=+1 X | 3=0 | 4=+1 Y | 5=+2 Y.'),
    writeln('Digite apenas numeros inteiros de 1 a 5 e pressione Enter.'),
    writeln('==============================================').

% ---------- PONTO DE ENTRADA ----------
iniciar :-
    limpar_respostas,
    cabecalho,
    faz_perguntas,
    calcula_ranking(Ranking),
    exibe_resultado(Ranking).

% ---------- Utilitário ----------
limpar_respostas :- retractall(resposta_nota(_, _)).

% ---------- Coleta de respostas ----------
faz_perguntas :-
    forall(pergunta_u(ID, Texto, _, _), pergunta_guardada(ID, Texto)),
    forall(pergunta_b(ID, Texto, _, _),  pergunta_guardada(ID, Texto)).

% Se já existir resposta para o ID (perfil de teste), não pergunta
pergunta_guardada(ID, Texto) :-
    (   resposta_nota(ID, _) -> true
    ;   pergunta_1a5(ID, Texto, Nota),
        assertz(resposta_nota(ID, Nota))
    ).

% Entrada robusta para SWISH (usa read/1)
pergunta_1a5(ID, Texto, Nota) :-
    format('(~w) ~w~n> ', [ID, Texto]),
    read(N),
    (   integer(N), between(1,5,N)
    ->  Nota = N
    ;   writeln('Resposta invalida. Digite um inteiro de 1 a 5.'),
        pergunta_1a5(ID, Texto, Nota)
    ).

% ---------- EXIBIÇÃO DO RESULTADO ----------
exibe_resultado([]) :-
    writeln('Nenhuma trilha encontrada (verifique a base).').
exibe_resultado(Ranking) :-
    writeln('\n=== Ranking ==='),
    forall(member((P, T, Justif), Ranking), (
        trilha(T, Desc),
        format('~w pts - ~w~n', [P, T]),
        format('    ~w~n', [Desc]),
        ( Justif = [] ->
            writeln('    Contribuicoes: (nenhuma)')
        ;   writeln('    Contribuicoes (ID-Pontos):'),
            exibe_contribuicoes(Justif)
        ),
        nl
    )),
    recomenda(Ranking, Melhores),
    writeln('=== SUGESTAO PRINCIPAL ==='),
    format('~w~n', [Melhores]).

% Lista legível das justificativas: "(ID) Texto -> +Pontos"
exibe_contribuicoes([]).
exibe_contribuicoes([ID-S|R]) :-
    get_texto_pergunta(ID, Texto),
    format('      - (~w) ~w  -> +~w~n', [ID, Texto, S]),
    exibe_contribuicoes(R).

% Recupera o texto da pergunta pelo ID (procura nas duas tabelas)
get_texto_pergunta(ID, Texto) :- pergunta_u(ID, Texto, _, _), !.
get_texto_pergunta(ID, Texto) :- pergunta_b(ID, Texto, _, _), !.
get_texto_pergunta(_, '(texto nao encontrado)').

% ---------- MODO TESTE ----------
% Dica: para depurar sem perguntar nada, faça:
%   ?- assertz(resposta_nota(1,5)), assertz(resposta_nota(2,4)), ...
%   ?- calcula_ranking(R), exibe_resultado(R).
executar_teste(NomePerfil, Ranking) :-
    format('Executando teste ~w...~n', [NomePerfil]),
    calcula_ranking(Ranking),
    exibe_resultado(Ranking).
