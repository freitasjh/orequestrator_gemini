# Configuração do Projeto (Bootstrap)

## 🛠 1. Stack Tecnológica
- **Orquestração:** Gemini CLI
- **Cérebro Digital:** Obsidian MCP Server (Node.js 20+, TypeScript 5+)
- **Automação:** Bash 5.0+, Python 3.11+ (Memory Tools)
- **Infra/DevOps:** Docker, Git (Conventional Commits)
- **Base de Conhecimento:** Markdown (Obsidian Vault)

## 🏗 2. Arquitetura Desejada
- **Padrão:** Pipeline SDD (Process-Oriented / FSM)
- **Princípios:** Spec-First, Multi-Agent System (MAS), Zero Trust Enforcement
- **Estratégia de Dados:** File-based Knowledge (Markdown), SQLite para RAG local

## 🧪 3. Estratégia de Testes
- **Níveis Exigidos:** Testes de Integração de Hooks, Unitários para MCP Tools
- **Stack:** Jest (Node.js), ShellSpec (Bash), PyTest (Python)
- **Cobertura Mínima:** 80% nos scripts de automação e ferramentas críticas

## 🔗 4. Hooks de Automação e Validação
- **Pre-Spec Hook:** bash scripts/hooks/pre-spec.sh
- **Post-Construction Hook:** bash scripts/hooks/post-construction.sh
- **Quality Gate Hook:** bash scripts/hooks/quality-gate.sh
- **FSM Enforcer:** bash scripts/hooks/fsm-enforcer.sh

---
*Status: [Bootstrap Concluído]*
