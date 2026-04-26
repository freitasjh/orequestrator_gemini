# Software Development Orchestrator (SDO) - Framework Robusto

Este repositório contém o **SDO (Software Development Orchestrator)**, um framework de engenharia agentica de elite operado via Gemini CLI. Ele transforma o LLM em um **Maestro** de processos rígidos, garantindo integridade arquitetural, qualidade inegociável e segurança através do método **Spec-Driven Development (SDD)**.

---

## 🎼 O Maestro da Engenharia

Diferente de assistentes convencionais, o Orquestrador atua como um **Maestro**. Sua função primária não é apenas escrever código, mas coordenar especialistas (sub-agentes), gerenciar o estado do projeto e garantir que nenhuma etapa do ciclo de vida seja negligenciada.

### 🚀 Comando Central: `/maestro`
O comando **`/maestro`** é a bússola do projeto. Ele lê o estado atual (`.gemini/STATE.json`), identifica os objetivos da fase ativa e fornece os passos detalhados para o progresso, resolvendo bloqueadores antes de avançar.

---

## 🚀 A Tríade de Robustez SDO

Nosso sistema opera sobre três pilares fundamentais:

1.  **Harness (Validação Ativa):** Um sistema de **Hooks Natos** (`fsm-enforcer`, `pre-spec`, `post-construction`, `quality-gate`) que bloqueiam ações fora de fase e validam o código automaticamente (Self-Healing).
2.  **SDD (Spec-Driven Intent):** Foco total no **Blueprint** técnico antes da codificação. Nenhuma linha de código é escrita sem um contrato BDD (Behavior-Driven Development), modelagem de dados e análise de segurança prévia.
3.  **Context (Cérebro Digital):** Um sistema de memória externa via **Obsidian MCP Server**. O Orquestrador utiliza a pasta `docs/` como um cérebro (Single Source of Truth), permitindo que lições aprendidas e decisões arquiteturais (ADRs) evoluam de forma estruturada.

---

## 🛠️ Pipeline de Desenvolvimento (Fases SDD)

O fluxo é controlado por uma **Máquina de Estados Finita (FSM)**:

*   **Fase 0 (Bootstrap):** Configuração de stack e análise de arquitetura em `PROJECT_CONFIG.md`.
*   **Fase 1 (Contexto):** Descoberta e análise de precedentes no Obsidian (Skill: `sdo-context-manager`).
*   **Fase 2 (Blueprint):** Elaboração da especificação robusta (Skill: `sdo-spec-manager`).
*   **Fase 3/4 (Tasking):** Decomposição técnica e gestão de issues (Skill: `sdo-task-manager`).
*   **Fase 5 (Construção):** Implementação com loop de **Auto-Cura** e testes rigorosos.
*   **Fase 6/7 (Quality Gate):** Revisão por pares (sub-agentes) e auditoria de segurança.
*   **Fase 8 (Consolidação):** Ingestão de aprendizado (Zettelkasten) e limpeza do workspace.

---

## 🧠 Inteligência Modificada (Agent Skills)

O Maestro utiliza capacidades especializadas para tarefas complexas:

*   **`sdo-context-manager`**: Gerencia a busca semântica e a poda de contexto técnico.
*   **`sdo-spec-manager`**: Gera Blueprints técnicos (Enterprise Grade) com BDD/Gherkin.
*   **`sdo-task-manager`**: Realiza a quebra granular de tarefas e gestão de blockers.
*   **`sdo-knowledge-researcher`**: Especialista em pesquisa técnica e expansão da base de conhecimento.
*   **`sdo-issue-integrator`**: Sincroniza o estado das tarefas entre o board local e provedores externos.

---

## 🔌 Infraestrutura de Hooks (Automáticos)

Os hooks garantem que as regras de governança sejam respeitadas:

| Hook | Função |
| :--- | :--- |
| `fsm-enforcer.sh` | Bloqueia modificações de código fora da fase de construção. |
| `pre-spec.sh` | Valida se a stack e requisitos básicos estão definidos. |
| `post-construction.sh`| Executa a bateria de testes e linting após cada alteração. |
| `quality-gate.sh` | Impede o fechamento de tarefas com pendências de qualidade. |

---

## 🧠 Obsidian as a Brain (RAG via MCP)

O projeto utiliza um servidor MCP em `scripts/tools/obsidian-mcp/`. Ele permite que o agente trate a documentação Markdown como sua memória de longo prazo:
-   **SSoT:** Tudo o que o Maestro sabe está em `docs/`.
-   **Aprendizado:** Lições aprendidas são registradas em `docs/lessons/` para consulta futura.
-   **ADRs:** Decisões críticas são imortalizadas como registros arquiteturais.

---

## ⌨️ Comandos do Sistema

*   **`/maestro`**: Dashboard de progresso e guia da fase atual.
*   **`/analyze-project`**: Mapeia stack e arquitetura de código legado.
*   **`/learn`**: Ativa o pesquisador para investigar temas técnicos e salvar no Obsidian.
*   **`/security-audit`**: Executa scan de segurança e revisão de vulnerabilidades.
*   **`/ship`**: Finaliza a tarefa com Conventional Commits e validação final.
