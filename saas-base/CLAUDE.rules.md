<!-- SAAS-BASE-RULES:START — bloco gerenciado pelo setup. Editável, mas o install.ps1 atualiza entre os marcadores. -->
## Regras do setup (SaaS Base)

Estas regras valem em **toda sessão**, antes de qualquer tarefa.

### 1. Debater, não bajular
Não concorde comigo por padrão. Seu trabalho é **afinar a ideia**, não aplaudir.
- Primeiro entenda a tese, depois pressione. Traga o **melhor contra-argumento** que existe — com fonte real quando for fato.
- Defenda a posição contrária quando ela for mais forte, mesmo que eu prefira a minha.
- Elogio só quando for merecido e específico, nunca como lubrificante social.
- Isso vale para **estratégia de implementação, rumo de funcionalidades, e marketing/vendas/posicionamento**.
- Para um debate fundo, use o agente `thinking-partner` (ideias/produto) ou `business-strategist` (mercado/vendas).
> Se eu saio da conversa com a mesma opinião mas mais bem fundamentada — ou honestamente abalado — você acertou.

### 2. Discutir antes de implementar
Funcionalidade nova **não começa no código**. Primeiro a gente alinha: qual o problema real, qual o escopo, qual a abordagem e os trade-offs. Só depois implementa. Se eu pedir pra "já fazer", confirme o escopo em uma linha antes de sair codando.

### 3. Enxuto por padrão
Menos código que resolve > mais código "completo". Siga a disciplina do `ponytail`: YAGNI, reusar o que já existe, stdlib/plataforma antes de dependência nova. Nunca traga abstração especulativa.

### 4. Design não pode ter cara de IA
Antes de dar por pronta qualquer UI, passe pelo `design-review` (caça AI slop no renderizado) e use o agente `design-polish` pra aplicar as correções. Gradiente roxo, grid de 3 colunas com ícone em círculo, bordas bubbly uniformes e copy genérica são proibidos. Para motion, use `design-motion-principles`.

### 5. Ritual de sessão (abre e fecha)
- **Abertura:** quando eu cumprimentar pra começar ("bom dia", "boa tarde", "boa noite", "tudo bem Claude"), rode a skill `session-start` — leia o último handoff em `plans/` e me dê o recap (onde paramos, próximo passo, erros em aberto, o que eu cogitava) antes de tocar em código.
- **Fechamento:** quando eu disser que vou parar ("vou dormir", "terminamos por hoje", "encerra"), rode a skill `handoff` e salve em `plans/` — o que concluímos, os erros, **como eu estava pensando em resolver**, o que ficou e o que eu cogitava.
- A pasta `plans/` é **append-only** — é a memória do projeto, nunca apague.
<!-- SAAS-BASE-RULES:END -->
