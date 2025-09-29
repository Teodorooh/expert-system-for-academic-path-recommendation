# Expert System for Academic Path Recommendation

A Prolog expert system to help technology students choose a specialization path.

📌 O que este projeto faz

* Faz 10 perguntas ao usuário (4 unipolares + 6 bipolares).  
* Converte respostas 1..5 em pontos por trilha.  
* Monta um ranking e exibe justificativas (quais perguntas pontuaram).  

🧠 Padrão das perguntas

* Unipolares (ID 1..4)  
  * pergunta_u(ID, Texto, TrilhaAlvo, Limiar).  
  Regra: se Nota ≥ Limiar ⇒ +1 ponto para TrilhaAlvo.

* Bipolares (ID 5..10) – texto sempre no formato "X ou Y".  
   * pergunta_b(ID, Texto, TrilhaAlta(Y), TrilhaBaixa(X)).

* Pontuação:  
   1 ⇒ +2 para X (TrilhaBaixa)  
   2 ⇒ +1 para X  
   3 ⇒ 0  
   4 ⇒ +1 para Y (TrilhaAlta)  
   5 ⇒ +2 para Y  

🎯 Trilhas suportadas

* ciencia_de_dados  
* inteligencia_artificial  
* desenvolvimento_web  
* seguranca_da_informacao  
* redes_e_infraestrutura  

📁 Estrutura de pastas

.  
├── base_conhecimento.pl          # trilhas + perguntas (unipolares/bipolares)  
├── motor_inferencia.pl           # regras de pontuação + ranking  
├── interface_usuario.pl          # fluxo, I/O e exibição  
├── testes/  
│   ├── perfil_teste_1_web.pl  
│   ├── perfil_teste_2_seguranca.pl  
│   └── perfil_teste_3_ia_vs_dados_empate.pl  
└── README.md  

▶️ Como rodar (SWISH – online)

1. Abra https://swish.swi-prolog.org
2. Cole o conteúdo dos 3 arquivos em uma única aba “Program” (no SWISH é mais simples).
3. Execute: ?- iniciar.
4. Responda com números 1..5. Ao final, veja o ranking e as justificativas.

Obs. SWISH: ele bloqueia include/consult para documentos públicos (/p/...). Por isso, junte tudo em um arquivo para rodar online.

💻 Como rodar (SWI-Prolog – local)

* Requisitos: SWI-Prolog 8+ (https://www.swi-prolog.org/)

* No terminal, na raiz do projeto:  
  * ?- ['base_conhecimento.pl','motor_inferencia.pl','interface_usuario.pl'].
?- iniciar.

* Para rodar um perfil de teste:  
  * ?- consult('testes/perfil_teste_1_web.pl'),
   executar_teste(perfil_teste_1_web, R).

🧪 Perfis de teste

* testes/perfil_teste_1_web.pl → favorece desenvolvimento_web  
* testes/perfil_teste_2_seguranca.pl → favorece seguranca_da_informacao  
* testes/perfil_teste_3_ia_vs_dados_empate.pl → empate entre IA e Dados  

🛠️ Como editar / estender

* Adicionar/editar perguntas  
   * Unipolar: edite/adicione pergunta_u/4 em base_conhecimento.pl.  
    Bipolar: edite/adicione pergunta_b/4 (texto “X ou Y”).  
      Importante: em pergunta_b(ID, Texto, TrilhaAlta(Y), TrilhaBaixa(X)),  
      Y (segunda opção) pontua em 4/5 e X (primeira) em 1/2.  

* Ajustar pesos  
    * Unipolares valem +1 (veja findall(ID-1, ...) em motor_inferencia.pl).  
  Bipolares usam score_bipolar_alta/baixa (edite para 3/1/0 etc., se quiser).  
  
* Desempate  
  * Atualmente, recomenda/2 mantém todas as trilhas com pontuação máxima.  
  Alternativas: preferir mais contribuições, priorizar unipolares, etc.  

* Depurar rápido (sem perguntar nada)  
     * ?- assertz(resposta_nota(1,5)), assertz(resposta_nota(2,4)), ...  
  ?- calcula_ranking(R), exibe_resultado(R).  

✅ Checklist de entrega

* 3 arquivos separados (base, motor, interface)  
* 10 perguntas (4 uni + 6 bi) documentadas  
* Entrada 1..5 com validação  
* Ranking + justificativas (ID-Pontos e texto)  
* Perfis de teste em testes/  
* README com instruções SWISH e local  

📄 Licença

MIT.  
