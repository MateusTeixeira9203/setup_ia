# Roteiro de Programação — para quem dirige, não para quem decora

> Roteiro de estudo baseado em livros canônicos, montado para um perfil específico:
> alguém com base de engenharia de software que **executa ideias, pensa produto e
> dirige a construção** — mas não vive escrevendo código. O objetivo não é virar
> programador de teclado. É ter **julgamento técnico de sênior**: saber ler o que a
> máquina (ou a IA) escreve, julgar se está bom, escolher entre caminhos, e não ser
> enganado — especialmente onde dá processo (segurança e dado de paciente).

## Como usar este roteiro

Três regras pra não desperdiçar tempo:

1. **Não leia de capa a capa.** Leia pra responder uma pergunta que você tem agora.
   Livro técnico é referência, não romance. Pegue o capítulo que resolve o teu problema da semana.
2. **Aplique no mesmo dia, no projeto real.** Leu sobre RLS? Vá olhar a RLS do Odonto.IA.
   Conhecimento que não vira decisão evapora em 48h.
3. **Use a IA como professor socrático, não como atalho.** Para cada conceito, pergunte
   *"por quê?"* e *"qual o trade-off?"*. A regra do setup é discutir antes de implementar —
   transforme cada feature numa aula.

**Ordem sugerida:** Camadas 1, 6 e 7 primeiro (te dão retorno imediato como diretor).
Camada 5 (segurança) é **obrigatória antes de escalar** com dado de paciente. As demais,
conforme a necessidade bate.

---

## Camada 0 — Como a máquina pensa (refresh rápido)

Você já viu isso na faculdade. Não reestude — só tenha à mão se uma intuição falhar.

| Livro | Autor | Pra quê |
|---|---|---|
| **Code: The Hidden Language of Computer Hardware and Software** | Charles Petzold | A explicação mais bonita já escrita de "como um monte de interruptor vira software". Lê-se como narrativa. Folheie os capítulos que te interessam. |

> **Sincero:** muita coisa de faculdade (autômatos, teoria de compiladores) você **não vai usar** dirigindo um SaaS. Você estava certo. Mas estrutura de dados básica, "como a web funciona" e custo de operação (por que uma query ruim derruba o app) **importam** — porque é com isso que você julga se uma solução é boa ou gambiarra.

---

## Camada 1 — O ofício pragmático (o coração para o teu papel)

Estes dois são os mais importantes da lista pra você. Não são sobre sintaxe — são sobre **como pensar a construção de software**.

| Livro | Autor | Pra quê |
|---|---|---|
| **The Pragmatic Programmer** (20th Anniversary Ed.) | Andrew Hunt & David Thomas | A bíblia do bom senso de engenharia. DRY, "tracer bullets" (fatias finas ponta-a-ponta, exatamente como a gente constrói com IA), não programar por coincidência. Curto, denso, mudou carreira de muita gente. **Comece por aqui.** |
| **A Philosophy of Software Design** | John Ousterhout | A melhor coisa já escrita sobre **complexidade** — o inimigo real de todo software. "Módulos profundos", por que abstração rasa é pior que nenhuma. Te dá vocabulário pra dizer *por que* um código está ruim, não só sentir. |

**O que você deve conseguir fazer depois:** olhar uma solução que o Claude propôs e dizer
"isso é complexidade desnecessária, dá pra fazer mais simples" — com argumento, não só vibe.
(É literalmente o que a skill `ponytail` do teu setup faz. Estes livros são a teoria por trás.)

---

## Camada 2 — A linguagem que você usa de verdade (JS / TS)

Não pra escrever do zero — pra **ler com fluência** o que a IA escreve e saber quando está estranho.

| Recurso | Autor | Pra quê |
|---|---|---|
| **Eloquent JavaScript** (grátis, online) | Marijn Haverbeke | A melhor introdução séria a JS. Leia 1–10. `eloquentjavascript.net`. |
| **You Don't Know JS Yet** (grátis, GitHub) | Kyle Simpson | Quando quiser entender *de verdade* closures, `this`, async/await — as coisas que confundem todo mundo. Referência, não leitura linear. |
| **javascript.info** (grátis) | Ilya Kantor | A melhor referência prática da web. Use como dicionário. |
| **TypeScript Handbook** (grátis, oficial) | Microsoft | Teu stack é TS. Entenda *tipos como contrato* — é o que te protege de metade dos bugs. |

**O que você deve conseguir fazer depois:** ler uma função do Odonto.IA e narrar o que ela faz,
e perceber "esse `any` aqui está burlando o type system — perigoso".

---

## Camada 3 — Ler, cheirar e melhorar código

| Livro | Autor | Pra quê |
|---|---|---|
| **Refactoring** (2ª ed. — **em JavaScript!**) | Martin Fowler | Catálogo de "code smells" e como consertar. A 2ª edição usa JS, encaixa no teu stack. Te ensina a **nomear** o que está errado num código. |
| **Clean Code** | Robert C. Martin | Influente, ótimo em nomes e funções pequenas. **Sincero:** parte do conselho é datado/controverso (funções minúsculas demais, mockar tudo). Leia os capítulos 2–3 (nomes, funções) e use o Ousterhout (Camada 1) como contraponto. Não trate como dogma. |

---

## Camada 4 — Backend, dados e o que sustenta um SaaS

| Livro | Autor | Pra quê |
|---|---|---|
| **Designing Data-Intensive Applications** | Martin Kleppmann | **O** livro de backend moderno. Confiabilidade, consistência, o que acontece quando dá errado. Denso, mas é o que separa quem entende um sistema de quem só liga peças. Leia conforme escala (não precisa de tudo no dia 1). |
| **SQL Antipatterns** | Bill Karwin | Os erros que todo mundo comete modelando banco — e você usa Supabase (Postgres). Curto e prático. Te salva de decisões de schema que doem depois. |
| **The Twelve-Factor App** (grátis, online) | Adam Wiggins (Heroku) | Manifesto de como um SaaS moderno deve ser configurado (env vars, processos, deploy). Lê em uma tarde. |

---

## Camada 5 — Segurança (OBRIGATÓRIA — você guarda dado de paciente)

Esta camada não é opcional pra você. Dado de saúde + LGPD = responsabilidade **sua**, não da IA.

| Recurso | Autor | Pra quê |
|---|---|---|
| **OWASP Top 10** (grátis, `owasp.org`) | OWASP | As 10 falhas que derrubam 90% das aplicações web. Leitura mínima inegociável. Teu setup tem o agente `security-reviewer` — mas você precisa entender o que ele aponta. |
| **Web Application Security** | Andrew Hoffman (O'Reilly) | Introdução acessível e moderna a segurança web. Comece por aqui. |
| **The Web Application Hacker's Handbook** | Stuttard & Pinto | A referência profunda (pensa como atacante). Pra quando quiser ir fundo. Não é leitura inicial. |
| **LGPD** — texto da lei + guias da ANPD (grátis) | ANPD (Brasil) | Você precisa saber: o que é dado sensível, consentimento, e o que a lei exige de quem guarda prontuário. |

**Conceitos que você TEM que dominar antes de escalar:** autenticação vs autorização,
**RLS no Supabase** (a regra que impede a clínica A de ver paciente da clínica B),
o que é uma chave secreta / variável de ambiente e por que **nunca** vai pro frontend ou pro git.

---

## Camada 6 — Design e UX que não tem cara de IA

Teu setup já caça "AI slop" (`design-review`, `impeccable-design-polish`). Estes livros são o porquê.

| Livro | Autor | Pra quê |
|---|---|---|
| **Don't Make Me Think** | Steve Krug | O clássico de usabilidade. Curto, divertido, muda como você olha qualquer tela. "Os usuários escaneiam, não leem." É a base do `design-review` do teu setup. |
| **Refactoring UI** | Adam Wathan & Steve Schoger | Design prático **para quem não é designer**. Hierarquia, espaçamento, cor — regras concretas que fazem uma UI parecer profissional em vez de template. Perfeito pro teu perfil. |

---

## Camada 7 — Produto e como dirigir (a tua zona de força)

Aqui é onde você já é bom. Estes livros afiam o que você faz naturalmente e te dão framework.

| Livro | Autor | Pra quê |
|---|---|---|
| **Inspired** | Marty Cagan | Como produtos de verdade são descobertos e construídos. Você é o "executor de ideias" — este é o teu manual. Separa produto que vende de feature que ninguém usa. |
| **Shape Up** (grátis, online — Basecamp) | Ryan Singer | Como definir escopo e cortar trabalho em apetite fixo, sem virar projeto eterno. Anti-inchaço de produto (combina com a filosofia do teu setup). `basecamp.com/shapeup`. |
| **The Mythical Man-Month** | Fred Brooks | Por que "adicionar gente atrasa projeto atrasado" e outras verdades duras de gestão de software. Velho, ainda certo. |

---

## Camada 8 — Extras valiosos (conforme a fome bater)

| Livro | Autor | Pra quê |
|---|---|---|
| **Grokking Algorithms** | Aditya Bhargava | Algoritmos de forma visual e leve. Se a faculdade te traumatizou com isso, este reconcilia. |
| **Learning Domain-Driven Design** | Vlad Khononov | Como modelar o domínio do problema (ex.: "consulta", "ficha", "orçamento" no Odonto) em código que faz sentido. Versão acessível do DDD clássico. |
| **Working Effectively with Legacy Code** | Michael Feathers | Pra quando o Odonto.IA crescer e você precisar mexer em código antigo sem quebrar tudo. |
| **The DevOps Handbook** / **The Phoenix Project** | Gene Kim et al. | Como software chega em produção de forma saudável. O segundo é um romance — lê-se fácil. |

---

## Mapa de prioridade (se for ler só 5)

1. **The Pragmatic Programmer** — o jeito de pensar.
2. **Don't Make Me Think** — retorno imediato em qualquer tela que você fizer.
3. **OWASP Top 10** + RLS do Supabase — não-negociável pra dado de paciente.
4. **A Philosophy of Software Design** — pra julgar complexidade.
5. **Inspired** — pra liderar o produto, que é o teu forte.

---

## Recursos gratuitos de referência rápida
- **MDN Web Docs** (`developer.mozilla.org`) — a enciclopédia da web.
- **roadmap.sh** — mapas visuais de carreira (frontend, backend, etc.). Bom pra ter visão do território.
- **javascript.info** e **eloquentjavascript.net** — já citados, valem o link de novo.

---

> *Mantido como parte do setup de desenvolvimento. Atualize conforme você lê — marque o
> que terminou, anote o que cada livro te fez mudar no Odonto.IA. O roteiro é vivo.*
