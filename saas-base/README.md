# SaaS Base — setup geral do Claude Code

Setup **enxuto e reutilizável** pra desenvolver qualquer SaaS (stack TypeScript:
Next.js / React / Supabase / Tailwind / Zod / LLMs). Nasceu pra substituir o Atlas,
que inchou e parou de funcionar. Aqui a regra é o oposto: **só o que comprovadamente
agrega, sem telemetria, sem CLI externo, sem peso morto.**

## O que tem

### 🧠 Disciplina (anti-inchaço)
- **ponytail** + **ponytail-review** — escreve o mínimo de código que funciona; review que só caça over-engineering. (MIT, DietrichGebert/ponytail)
- **karpathy-guidelines** — evita os erros clássicos de LLM ao codar.
- **intent-driven-development** — transforma pedido vago em critérios de aceite verificáveis.

### 🧩 Padrões do stack (docs do seu próprio jeito de fazer)
`next-app-router` · `react-patterns` · `supabase-patterns` · `tailwind-shadcn` ·
`zod-validation` · `ai-integration` · `error-handling` · `saas-patterns`
> Autorados originalmente no Atlas, casam 100% com o stack. Combinam com o **Context7 MCP** (docs oficiais sempre atuais).

### 🎨 Design (anti-genérico — não pode ter cara de IA)
- **design-review** — audita a UI renderizada e caça **AI slop** (gradiente roxo, grid de 3 colunas, bordas bubbly, copy genérica). *Destilado do gstack, sem telemetria.*
- **impeccable-design-polish** — passada final que remove cara de IA.
- **design-brief** · **design-system-tokens** · **gsap-core** — direção visual, tokens e animação.

### 🧪 Qualidade
- **qa-web** — testa o app rodando como usuário, acha bugs e corrige (loop triagem→fix→re-verifica). *Adaptado do gstack p/ Playwright MCP.*
- **database-migrations** · **deployment-patterns** · **docker-patterns** · **github-ops**

### 🗣️ Debate + continuidade
- **Regras fixas** (em `CLAUDE.md`, carregadas toda sessão): debater em vez de bajular; discutir feature nova antes de implementar; enxuto por padrão; design sem cara de IA; toda sessão termina com handoff.
- **Ritual de sessão:** cumprimentar ("bom dia", "boa tarde", "boa noite", "tudo bem Claude") aciona a skill **session-start** → lê o último handoff e retoma de onde paramos. Dizer "vou dormir"/"terminamos por hoje" aciona a skill **handoff**.
- **handoff** — fecha a sessão salvando em `plans/`: o que concluímos, os erros, **como eu pensei em resolver**, o que ficou e o que eu estava cogitando. `plans/` é append-only = memória do projeto.

### 🤖 Agentes (subagents)
`typescript-reviewer` · `security-reviewer` · `planner` · `architect`
`ui-architect` · `ux-reviewer` · `design-polish`
**`thinking-partner`** (debate de ideias/produto, anti-bajulação, Opus) ·
**`business-strategist`** (mercado/vendas/posicionamento com fontes reais, Opus)

### 🔌 MCPs (`.mcp.json`)
- **context7** — docs oficiais e atuais das libs (mata alucinação de API velha; crítico no stack de ponta).
- **playwright** — browser real pra `qa-web` e `design-review`.
- *Supabase e PostHog ficam no seu setup global do Claude — não são tocados aqui.*

## Instalar num projeto

```powershell
.\install.ps1 -Target "C:\caminho\do\projeto"
```

Copia `.claude/skills` + `.claude/agents` e faz merge dos MCPs no `.mcp.json` do
projeto. Reinicie o Claude Code no projeto pra carregar.

## O que NÃO entrou (de propósito)
- **gstack cru** — produto fechado com telemetria + CLI próprio (GBrain). Só extraímos a substância limpa (`design-review`, `qa-web`).
- **x1xhlol/system-prompts** — referência GPL-3.0, não instalável; estudo só.
- **claude-code-best** — fork inteiro do Claude Code, fora do escopo.
- **Reviewers multi-linguagem** (Go/Rust/Java/Kotlin) — stack é 100% TypeScript.
- **Stripe MCP** — não usado.

## Créditos
ponytail (MIT) · gstack (MIT, garrytan) · ECC (MIT, affaan-m) · open-design (Apache-2.0, nexu-io) ·
impeccable (pbakaus) · padrões de stack autorados por Mateus Teixeira (Atlas).
