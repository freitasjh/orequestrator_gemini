# 📜 Project Constitution & Global Rules

Este arquivo define as regras obrigatórias e a visão de mundo para qualquer IA operando neste repositório. O descumprimento destas diretrizes resultará em inconsistência técnica e rejeição de tarefas.

---

## 🏛️ Arquitetura e Visão Técnica
Todo código gerado deve respeitar as definições contidas em `docs/product/ARCHITECTURE.md`.
- **Single Source of Truth:** O arquivo `docs/product/SYSTEM_SPECIFICATION.md` contém as regras de negócio permanentes.
- **Simplicidade:** Se uma tarefa for simples, não force processos complexos. O bom senso arquitetural deve prevalecer.
- **Modularidade:** Manter a separação clara entre camadas e responsabilidades.

---

## 🛠️ Regras de Desenvolvimento e Qualidade (DoD)

### 1. Práticas de Código
- **Idiomatismo:** Seguir rigorosamente as convenções da linguagem e stack definida em `docs/product/PROJECT_CONFIG.md`.
- **I18n:** Proibido strings hardcoded. Utilizar o sistema de tradução do projeto.
- **Documentação:** Comentar o "porquê" (decisões técnicas), não o "o quê" (autoexplicativo).

### 2. Garantia de Qualidade
- **Testes:** Toda funcionalidade ou correção deve ser acompanhada de testes unitários ou de integração.
- **Segurança:** Seguir práticas OWASP. Nunca expor segredos ou dados sensíveis.
- **Performance:** Evitar loops desnecessários e consultas ineficientes ao banco de dados.

---

## 🔄 Gerenciamento de Contexto e Memória

- **Checkpoint Protocol:** Ao atingir o limite de turnos, o agente DEVE gerar um `HANDOFF_STATE.md` detalhado.
- **Aprendizado:** Consultar sempre `docs/LESSONS_LEARNED.md` antes de iniciar uma tarefa para evitar erros recorrentes.
- **RAG System:** Priorizar o uso de ferramentas de busca semântica (`search_memory`) para contextos históricos.

---

## 🚫 Restrições Críticas (The "Never" List)

1. **NUNCA** altere arquivos de configuração global sem autorização explícita.
2. **NUNCA** ignore falhas de linter ou testes. O "Self-Healing Loop" deve ser respeitado.
3. **NUNCA** proponha soluções que violem a segurança ou a privacidade do usuário.
4. **NUNCA** delete documentação histórica sem mover para arquivos de arquivo/histórico.

---

## 📂 Governança de Arquivos e Integração

| Diretório | Finalidade |
| :--- | :--- |
| `docs/product/` | Configurações, Arquitetura e Regras de Negócio Globais. |
| `docs/specs/` | Especificações detalhadas de funcionalidades (Blueprints). |
| `docs/backlog/` | Gestão de tarefas e board de progresso. |
| `docs/adr/` | Architectural Decision Records (Decisões Críticas). |

---

## 🔗 Integração de Tasks (Issue Tracker via MCP)

Este projeto utiliza **MCP Servers** para integração com trackers externos. O agente deve possuir as ferramentas necessárias (ex: `github_create_issue`, `jira_create_issue`) ativas em seu contexto.

- **ISSUE_TRACKER**: [`GITHUB` | `JIRA` | `LOCAL`] (Padrão: `LOCAL`).
- **JIRA_PROJECT_KEY**: [Ex: `SDE`, `OPUS`].
- **GITHUB_REPO**: [Ex: `owner/repo`].

### Regras de Sincronização MCP:
1. **LOCAL**: Persistência em `docs/backlog/ISSUE_XXX.md`.
2. **GITHUB**: Utilizar ferramentas MCP do servidor `github` para criar e listar issues.
3. **JIRA**: Utilizar ferramentas MCP do servidor `jira` para criar tickets e transicionar estados.
4. **Referência Cruzada**: O ID externo (ex: `OPUS-123` ou `#42`) deve ser gravado no metadado da cópia local em `docs/backlog/` para manter o RAG eficiente.

---

## 💬 Postura e Comunicação
- **Profissionalismo:** Tom técnico, direto e sem excesso de cordialidade.
- **Transparência:** Sempre informe a estratégia antes de executar mudanças significativas.
- **Maestro Dashboard:** Ao atuar como orquestrador, mantenha o usuário informado sobre o progresso e a fase atual do workflow.
