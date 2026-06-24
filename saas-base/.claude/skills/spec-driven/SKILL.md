---
name: spec-driven
description: >
  Escreve o contrato técnico de uma feature ANTES do código: TypeScript interfaces,
  props de componente, API contracts (route/body/response/erros), schema de banco,
  schemas Zod, e invariantes. Salva em plans/ como fonte da verdade — a implementação
  segue a spec, não improvisa. Use quando começar qualquer feature não-trivial:
  "spec para X", "vamos especificar", "escreve a spec", "spec antes de codar",
  "define o contrato", "spec first". NÃO usar para bug fixes óbvios, edições
  pontuais, ou quando o plano já tem os contratos definidos.
cpe:
  source: cpe-personal
  integrated_at: 2026-06-24
  adaptation: Atlas-authored — stack Next.js/React/Supabase/Zod/shadcn
---

# Spec-Driven

Produz o contrato técnico completo de uma feature antes de qualquer código.
A spec é a **fonte da verdade**: a implementação segue a spec; se precisar
desviar, atualiza a spec *primeiro*.

## Quando ativar

Ativar em: "spec para X", "vamos especificar", "escreve a spec antes de codar",
"define o contrato", "spec first", início de qualquer feature com > 1 arquivo
envolvido.

**Não ativar em:** bug fix com causa óbvia, edit pontual, refactor de < 50 linhas,
ou quando o handoff já documenta os contratos.

---

## Processo

### 1. Contexto (leia antes de perguntar)

Verifique o que já existe:
- Último handoff em `plans/` — qual é o plano e o que já foi decidido?
- `CLAUDE.md` / `CLAUDE.rules.md` — constraints do projeto
- `package.json` — stack real (Next.js versão, libs de auth, etc.)
- Schema existente — `supabase/migrations/` ou `prisma/schema.prisma`
- Tipos existentes — `types/`, `lib/`, `src/types/`

Quanto mais contexto você leu, menos perguntas precisa fazer.

### 2. Perguntas (máximo 3, só se crítico)

Pergunte APENAS o que bloqueia a spec e não é inferível do contexto:
- Quem é o ator? (usuário autenticado, admin, público?)
- Qual o limite de escopo? (o que esta spec NÃO cobre?)
- Há constraint de schema que ainda não está no código?

Se tiver `AskUserQuestion` disponível, use. Senão, pergunte em texto plano.
**Não manufacture perguntas** — se é inferível, infira e declare o que assumiu.

### 3. Gerar a spec

Produza o arquivo completo. Siga a estrutura abaixo.

### 4. Salvar em plans/

Nome do arquivo: `plans/YYYY-MM-DD-{feature-slug}-spec.md`

Escreva o arquivo com `Write`. Informe o caminho completo ao usuário.

### 5. Declarar congelamento

Após salvar, diga:

> **Spec salva.** A implementação segue este contrato.
> Para qualquer desvio durante o código: atualize a spec primeiro, depois implemente.

---

## Estrutura da spec

```markdown
# Spec: {Nome da Feature}

> **Status:** draft | agreed | implemented
> **Data:** YYYY-MM-DD
> **Plano de origem:** plans/{handoff-file}.md (se houver)

## Escopo

O que esta spec cobre (1–3 bullets).
O que ela NÃO cobre (1–3 bullets — previne scope creep).

## Assunções

- {O que foi inferido e não confirmado explicitamente}

## TypeScript — Interfaces & Types

\`\`\`typescript
// Tipos de domínio
export interface {Entity} {
  id: string
  // ...
}

// Props de componente
export interface {Component}Props {
  // ...
}

// Server Action / Route Handler payloads
export interface {Action}Input {
  // ...
}
export interface {Action}Result {
  // sucesso
}
// ou: type {Action}Result = { ok: true; data: X } | { ok: false; error: string }
\`\`\`

## Zod Schemas

\`\`\`typescript
// Validação de entrada (Server Actions, Route Handlers)
export const {entity}Schema = z.object({
  // ...
})
export type {Entity}Input = z.infer<typeof {entity}Schema>
\`\`\`

## API Contracts

### {METHOD} /api/{path}

| Campo     | Valor |
|-----------|-------|
| Auth      | required / public / admin-only |
| Rate limit | sim / não |

**Request body:**
\`\`\`typescript
{
  // campos + tipos
}
\`\`\`

**Response — sucesso (2xx):**
\`\`\`typescript
{
  // campos + tipos
}
\`\`\`

**Erros esperados:**
| Status | Condição |
|--------|----------|
| 400    | {condição de validação} |
| 401    | não autenticado |
| 403    | sem permissão |
| 404    | recurso não existe |
| 409    | conflito (ex: email já existe) |

> Usar mesma shape de erro em todos os endpoints:
> `{ error: string; code?: string }`

## Database

### Tabelas novas / alteradas

\`\`\`sql
-- {table_name}
create table {table_name} (
  id          uuid primary key default gen_random_uuid(),
  user_id     uuid references auth.users not null,
  -- ...
  created_at  timestamptz default now()
);

-- RLS
alter table {table_name} enable row level security;
create policy "users veem só os próprios" on {table_name}
  for select using (auth.uid() = user_id);
\`\`\`

### Índices

\`\`\`sql
create index on {table_name} ({coluna});
\`\`\`

## Componentes

### Árvore

\`\`\`
{PageComponent}           ← Server Component (busca dados)
  └─ {FeatureComponent}  ← Client Component (interação)
       ├─ {SubA}         ← apresentação
       └─ {SubB}         ← formulário / ação
\`\`\`

### Responsabilidades

| Componente | Server/Client | O que faz |
|------------|---------------|-----------|
| {Page}     | Server        | fetch + layout |
| {Feature}  | Client        | estado + ações |

## Invariantes

Regras que a implementação **nunca pode quebrar**:

- [ ] {Invariante 1 — ex: "usuário só acessa dados do próprio tenant"}
- [ ] {Invariante 2 — ex: "senha nunca trafega em plaintext"}
- [ ] {Invariante 3 — ex: "operação X é idempotente"}

## Gates de aceite

Condições verificáveis que definem "done" (alimenta o qa-web):

- [ ] {Gate 1 — ex: "POST /api/X com body válido retorna 201 + { id }"}
- [ ] {Gate 2 — ex: "POST com email duplicado retorna 409"}
- [ ] {Gate 3 — ex: "usuário não-autenticado recebe 401"}
- [ ] {Gate 4 — ex: "campo Y aceita no máximo 255 chars"}
```

---

## Regras de qualidade

**Não especificar o que é inferível do stack.** Se o projeto usa Supabase Auth,
não documente como auth funciona — só documente o que é específico desta feature.

**Tipos antes de implementação.** Os tipos TypeScript são o coração da spec —
são eles que a IA vai seguir ao escrever o código. Seja preciso.

**Sem tipos genéricos desnecessários.** `any`, `object`, `Record<string, any>`
são red flags na spec — se você não sabe o tipo, descubra agora, não depois.

**Invariantes são não-negociáveis.** Se durante a implementação surgir pressão
pra violar uma invariante ("só por enquanto"), atualize a spec e registre o trade-off.

**Gates de aceite são testáveis.** Cada gate deve ter um "como eu verifico isso"
óbvio — seja via `qa-web`, curl, ou Playwright. Se não é verificável, reescreva.

---

## Relação com o resto do setup

| Skill / Agente | Quando entra |
|----------------|-------------|
| `intent-driven-development` | **Antes** da spec — converte pedido vago em escopo |
| `spec-driven` (esta) | **Depois** do escopo — define os contratos técnicos |
| Implementação | **Depois** da spec — executa contra os contratos |
| `qa-web` | **Depois** da impl — verifica os gates de aceite |
| `handoff` | **Fim da sessão** — referencia a spec no handoff |
