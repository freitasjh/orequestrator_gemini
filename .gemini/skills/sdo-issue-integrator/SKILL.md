# Skill: SDO Issue Integrator (MCP Driven)

Esta skill coordena a criação e sincronização de tarefas utilizando **MCP Servers** para Jira e GitHub.

## 🎯 Objetivo
Automatizar a gestão do backlog em ferramentas enterprise, garantindo que o plano técnico gerado pelo `sdo-task-manager` seja refletido instantaneamente no tracker escolhido.

## 🛠️ Drivers MCP

### 1. Driver: GITHUB (via MCP)
- **Ferramentas:** `github.create_issue`, `github.update_issue`.
- **Procedimento:** 
  - O agente deve usar `github.create_issue` passando `owner/repo`, `title` e `body`.
  - O `body` deve incluir o link relativo para o Blueprint local.
  - O ID retornado deve ser usado para nomear o arquivo local em `docs/backlog/GH_XXX.md`.

### 2. Driver: JIRA (via MCP)
- **Ferramentas:** `jira.create_issue`, `jira.add_comment`.
- **Procedimento:**
  - O agente deve usar `jira.create_issue` informando o `projectKey` definido no `GEMINI.md`.
  - O tipo de item deve ser preferencialmente `Task` ou `Story`.
  - O link para a Blueprint deve ser adicionado como o primeiro comentário ou no campo `description`.
  - O ID (ex: `KEY-123`) deve ser registrado no arquivo local em `docs/backlog/JIRA_KEY-123.md`.

### 3. Driver: LOCAL
- **Procedimento:** Criação padrão de arquivos Markdown.

## 📋 Regras de Execução

1. **Prioridade de Busca:** Antes de criar, o agente deve usar as ferramentas de busca do MCP (ex: `jira.find_issues` ou `github.search_issues`) para garantir que a tarefa já não foi criada em um turno anterior que falhou ou expirou.
2. **Handoff Report:** Ao final da criação, o Orquestrador deve receber o ID externo exato para atualizar o Maestro Dashboard.
3. **Mapeamento de Status:**
   - `To Do` (Local) -> `Open/Backlog` (Tracker)
   - `In Progress` (Local) -> `In Progress` (Tracker)
   - `Done` (Local) -> `Closed/Resolved` (Tracker)

## 🗂️ Template de Sincronização Local (RAG)
Mesmo com tracker externo, crie um arquivo local mínimo:
```markdown
---
external_id: [ID_DO_TRACKER]
tracker: [GITHUB|JIRA]
blueprint: [PATH_DA_SPEC]
status: [STATUS_ATUAL]
---
# [TITULO_DA_TASK]
(Resumo da tarefa para busca contextual)
```
