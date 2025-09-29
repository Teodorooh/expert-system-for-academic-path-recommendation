% =========================================================
%  SISTEMA ESPECIALISTA – Recomendacao de Trilha Acadêmica
%  [BASE DE CONHECIMENTO]
% =========================================================
%
%  Contém:
%   • trilha/2
%   • pergunta_u/4  (unipolares)
%   • pergunta_b/4  (bipolares, sempre no texto "X ou Y")
%

% ---------- TRILHAS (id, descricao) ----------
trilha(ciencia_de_dados,        'Analise e interpretacao de dados.').
trilha(inteligencia_artificial, 'Modelos e algoritmos inteligentes.').
trilha(desenvolvimento_web,     'Criacao de sites e sistemas web.').
trilha(seguranca_da_informacao, 'Protecao de dados e sistemas.').
trilha(redes_e_infraestrutura,  'Gerencia de redes, servidores e automacao.').

% ---------- PERGUNTAS (4 unipolares + 6 bipolares) ----------

% Unipolares: se Nota >= Limiar, +1 ponto p/ TrilhaAlvo
% pergunta_u(ID, Texto, TrilhaAlvo, Limiar).
pergunta_u(1,  'Quanta afinidade voce tem com matematica e estatistica? (1..5)',
            ciencia_de_dados, 4).
pergunta_u(2,  'Quanto voce se interessa por criar algoritmos inteligentes? (1..5)',
            inteligencia_artificial, 4).
pergunta_u(3,  'Quanto voce curte criar interfaces e pensar em UX/UI? (1..5)',
            desenvolvimento_web, 4).
pergunta_u(4,  'Quanto voce gosta de administrar redes/servidores? (1..5)',
            redes_e_infraestrutura, 4).

% Bipolares (TEXTO "X ou Y"): 1/2 puxam X; 4/5 puxam Y; 3 é neutro
% pergunta_b(ID, Texto, TrilhaAlta(Y), TrilhaBaixa(X)).
pergunta_b(5,  'O que te prende mais: "Mr. Robot" (seguranca) ou "A Rede Social" (web)? (1..5)',
            desenvolvimento_web, seguranca_da_informacao).
pergunta_b(6,  'Voce curte mais desafios Kaggle (dados) ou pentest/CTF (seguranca)? (1..5)',
            seguranca_da_informacao, ciencia_de_dados).
pergunta_b(7,  'Prefere automatizar servidores (redes) ou modelar dados (dados)? (1..5)',
            ciencia_de_dados, redes_e_infraestrutura).
pergunta_b(8,  'Acha mais legal robo autonomo/IA (IA) ou pesquisa de UX (web)? (1..5)',
            desenvolvimento_web, inteligencia_artificial).
pergunta_b(9,  'Prefere estatistica/modelagem (dados) ou treinar modelos (IA)? (1..5)',
            inteligencia_artificial, ciencia_de_dados).
pergunta_b(10, 'Prefere cloud/DevOps (redes) ou hardening/investigacao (seguranca)? (1..5)',
            seguranca_da_informacao, redes_e_infraestrutura).
