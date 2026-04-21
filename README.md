# Software Development Orchestrator (SDO) - Framework Robusto

Este repositório contém o **SDO (Software Development Orchestrator)**, um framework de engenharia agentica de elite operado via Gemini CLI. Ele transforma o LLM em um orquestrador de processos rígidos, garantindo arquitetura, qualidade e segurança através do método **Spec-Driven Development (SDD)**.

---

## 🚀 A Tríade de Robustez SDO

Nosso sistema opera sobre três pilares fundamentais que garantem a entrega de software profissional:

1.  **Harness (Validação Ativa):** Um sistema de **Hooks Natos** (`fsm-enforcer`, `pre-spec`, `post-construction`, `quality-gate`) que bloqueiam ações fora de fase e validam o código automaticamente (Self-Healing).
2.  **SDD (Spec-Driven Intent):** Foco total no **Blueprint** técnico antes da codificação. Nenhuma linha de código é escrita sem um contrato BDD (Behavior-Driven Development) e modelagem de dados prévia.
3.  **Context (Cérebro Digital):** Um sistema de memória externa via **Obsidian MCP Server** (TypeScript). O Orquestrador utiliza a pasta `docs/` como um cérebro auditável e legível por humanos, permitindo que lições aprendidas e regras de negócio evoluam de forma estruturada.

---

## 🛠️ Pipeline de Desenvolvimento (Fases SDD)

O fluxo é controlado por uma **Máquina de Estados Finita (FSM)** em `.gemini/STATE.json`:

*   **Fase 0 (Bootstrap):** Configuração de stack agnóstica em `PROJECT_CONFIG.md`.
*   **Fase 1 (Contexto):** Busca de conhecimento e análise de precedentes via Obsidian (Skill: `sdo-context-manager`).
*   **Fase 2 (Blueprint):** Elaboração da especificação robusta (Skill: `sdo-spec-manager`).
*   **Fase 3/4 (Tasking):** Decomposição em micro-tarefas granulares (Skill: `sdo-task-manager`).
*   **Fase 5 (Construção):** Implementação e testes com loop de **Auto-Cura** (Self-Healing).
*   **Fase 6/7 (Quality Gate):** Auditoria técnica e segurança por agentes revisores.
*   **Fase 8 (Consolidação):** Ingestão de aprendizado no **Obsidian Vault** e limpeza.

---

## 🧠 Inteligência Modificada (Agent Skills)

O Orquestrador utiliza capacidades especializadas (Skills) instaladas localmente:

*   **`sdo-spec-manager`**: Gera Blueprints técnicos robustos com Gherkin/BDD.
*   **`sdo-task-manager`**: Quebra Blueprints em tarefas técnicas atômicas.
*   **`sdo-context-manager`**: Gerencia a busca de conhecimento no Obsidian e a poda de contexto (Token Pruning).

---

## 🔌 Infraestrutura de Hooks (Automáticos)

Os hooks são disparados nativamente pelo Gemini CLI para garantir a integridade:

| Hook | Quando Dispara | Função |
| :--- | :--- | :--- |
| `fsm-enforcer.sh` | BeforeTool (`write_file`) | Bloqueia edição de código fora da Fase 5. |
| `pre-spec.sh` | BeforeAgent | Garante que o Bootstrap/Stack está definido. |
| `post-construction.sh`| AfterTool (`edit`) | Roda testes/lint e força correção imediata se falhar. |
| `quality-gate.sh` | BeforeTool (`ship`) | Verifica se há reprovações pendentes no Board. |

---

## 🧠 Obsidian as a Brain (RAG via MCP)

O projeto utiliza um servidor MCP TypeScript em `scripts/tools/obsidian-mcp/`. Ele permite que o agente trate a documentação Markdown como seu cérebro:
-   **`search_notes(query)`**: Busca padrões e decisões passadas diretamente nas notas Markdown.
-   **`read_note(path)`**: Lê especificações técnicas e lições aprendidas.
-   **`update_note(path, content)`**: Grava novos aprendizados no arquivo `LESSONS_LEARNED.md`.

---

## ⌨️ Comandos Customizados

*   `/analyze-project`: Mapeia stack e arquitetura de código existente.
*   `/security-audit`: Varredura completa por vulnerabilidades.
*   `/ship`: Finalização com Conventional Commits e Push.
*   `/skills reload`: Recarrega as habilidades do Orquestrador.

---
*Este framework é agnóstico de linguagem e pode ser adaptado para Java, Python, Node, Vue, React, etc.*
