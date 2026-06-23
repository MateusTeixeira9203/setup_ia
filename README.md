# setup_ia

Setup pessoal de desenvolvimento com Claude Code + roteiro de estudo. Enxuto,
reutilizável, sem peso morto. Montado por Mateus Teixeira.

## Conteúdo

### [`saas-base/`](./saas-base) — setup geral para qualquer SaaS
24 skills + 9 agentes + 2 MCPs + regras, prontos pra instalar em qualquer projeto
TypeScript (Next.js / React / Supabase / Tailwind / Zod / LLMs).

- **Disciplina:** ponytail (anti-inchaço), karpathy-guidelines, intent-driven-development
- **Padrões do stack:** next-app-router, react-patterns, supabase-patterns, tailwind-shadcn, zod-validation, ai-integration, error-handling, saas-patterns
- **Design anti-genérico:** design-review (caça AI slop), impeccable-design-polish, design-brief, tokens, gsap
- **Qualidade:** qa-web (Playwright), database-migrations, deployment, docker, github-ops
- **Debate (anti-bajulação):** agentes thinking-partner e business-strategist
- **Continuidade:** ritual de sessão (`session-start` / `handoff`) com pasta `plans/`
- **MCPs:** context7 (docs live) + playwright

Instalação: `cd saas-base && .\install.ps1 -Target "C:\caminho\do\projeto"`

### [`roteiro-programacao/`](./roteiro-programacao) — roteiro de estudo
Roteiro em 9 camadas baseado em livros canônicos, para quem **dirige e pensa
produto** em vez de codar à mão. Inclui tracker de progresso.

## Filosofia
Nasceu pra substituir um setup anterior que inchou e parou de funcionar. A regra
aqui é o oposto: só o que comprovadamente agrega, sem telemetria, sem CLI externo,
sem peso morto. Debater em vez de bajular. Discutir antes de implementar.

## Créditos
ponytail (MIT, DietrichGebert) · gstack (MIT, garrytan — substância destilada) ·
ECC (MIT, affaan-m) · open-design (Apache-2.0, nexu-io) · impeccable (pbakaus) ·
padrões de stack e personas autorados por Mateus Teixeira.
