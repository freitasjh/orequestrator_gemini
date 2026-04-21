# Guia de Migração do Framework SDO (Agent Portability)

Este documento orienta como portar a inteligência, o rigor e os processos do **SDO (Software Development Orchestrator)** para outras plataformas de IA e Agentes (Devin, Claude Code, Copilot, Cursor, etc.).

---

## 🏗️ O Core Portável (Agnóstico de Plataforma)

A robustez do SDO reside nos artefatos e processos, não apenas no Gemini CLI. Para migrar, você deve garantir a presença dos seguintes componentes:

1.  **State Machine:** O arquivo `.gemini/STATE.json` deve ser mantido como a fonte da verdade sobre em qual fase o projeto está.
2.  **Governança:** O arquivo `GEMINI.md` (ou similar) deve ser injetado como o **System Prompt** primário do novo agente.
3.  **Harness Scripts:** Os scripts em `scripts/hooks/*.sh` devem ser executados pelo novo agente (manualmente ou via automação de CI).
4.  **RAG Server:** O script `scripts/tools/mcp_memory_server.py` pode ser executado como um servidor MCP em qualquer plataforma compatível com o protocolo (Claude Desktop, etc.).

---

## 🎯 Migração por Plataforma

### 1. Claude Code (Anthropic CLI)
- **Como migrar:** Ao iniciar o Claude Code, aponte para o `GEMINI.md` como guia.
- **Instrução de Sistema:** *"Você é um Software Development Orchestrator. Leia o GEMINI.md e respeite as fases do STATE.json. Antes de editar qualquer arquivo, você DEVE rodar scripts/hooks/fsm-enforcer.sh."*

### 2. Devin (Cognition AI)
- **Como migrar:** Forneça acesso ao repositório completo.
- **Comando Inicial:** *"Analise o README.md e o GEMINI.md. Sua missão é completar a ISSUE_XXX seguindo rigorosamente as fases do pipeline SDO. Não pule a fase de Blueprinting (Fase 2)."*
- **Aproveitamento:** O Devin é excelente para rodar o `post-construction.sh` (Self-Healing) de forma autônoma.

### 3. Cursor / Windsurf / IDE Agents
- **Como migrar:** Copie o conteúdo do `GEMINI.md` para o arquivo de regras da IDE (ex: `.cursorrules`).
- **Configuração:** Mantenha os hooks de pré-commit do Git apontando para os nossos scripts de validação (`fsm-enforcer.sh`) para garantir o rigor mesmo se o agente da IDE tentar "pular etapas".

### 4. GitHub Copilot (Instructions)
- **Como migrar:** Crie o arquivo `.github/copilot-instructions.md`.
- **Conteúdo:** Copie as seções de **"Pipeline de Desenvolvimento"** e **"Mandato de Postura"** do `GEMINI.md`.

---

## 🔄 Adaptação de Hooks (Substituição de AfterTool/BeforeTool)

Se a plataforma de destino não suportar hooks nativos de intercepção de ferramentas, use a estratégia de **Wrapper de Comandos**:

1.  **Wrap de Edição:** Instrua o agente a sempre rodar `bash scripts/hooks/fsm-enforcer.sh <file_path>` antes de sugerir uma edição.
2.  **Wrap de Validação:** Instrua o agente a sempre rodar `bash scripts/hooks/post-construction.sh` após salvar um arquivo.

---

## 📊 Matriz de Compatibilidade SDO

| Recurso | Portável? | Método de Migração |
| :--- | :--- | :--- |
| **FSM (Fases)** | Sim | Mantendo `STATE.json` e scripts Bash. |
| **Blueprinting** | Sim | Mantendo as Skills (SKILL.md) como prompt. |
| **Hooks de Bloqueio** | Parcial | Exige suporte a Git Hooks ou Prompting rigoroso. |
| **RAG (MCP)** | Sim | O servidor Python é compatível com qualquer host MCP. |
| **Auto-Cura** | Sim | O agente deve ser instruído a ler a saída do script de teste. |

---
*Mantenha os Blueprints (docs/specs/) e o Board (docs/backlog/) sempre atualizados. Eles são o mapa que qualquer agente de elite saberá ler.*
