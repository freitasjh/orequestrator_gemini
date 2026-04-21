# Arquitetura do Sistema - Orquestrador Gemini

## 1. Visão Geral da Arquitetura
O sistema é um framework de orquestração de desenvolvimento orientado a processos (Pipeline SDD). A execução é regida por uma Máquina de Estados Finita (FSM) que controla rigorosamente a transição entre as fases de descoberta, especificação, planejamento e construção.

## 2. Decisões Técnicas (ADR Context)
- **Single Source of Truth:** A pasta `docs/` é o Vault do Obsidian e a fonte única de verdade para regras de negócio e arquitetura.
- **Enforcement Automático:** O acesso ao sistema de arquivos é mediado por hooks que verificam o estado da FSM em `.gemini/STATE.json`.
- **Inteligência Desacoplada:** Agentes e Skills são modulares, permitindo a substituição de LLMs ou ferramentas sem impactar o fluxo de trabalho.

## 3. Padrões de Código e Qualidade
### 3.1 Automação (Bash/Python)
- Scripts de hook devem ser idempotentes e retornar erro não-zero em falhas.
- Utilização de logs claros para facilitar a depuração via CLI.

### 3.2 Ferramentas (Node.js/TypeScript)
- Uso de ESM (ECMAScript Modules).
- Protocolo MCP (Model Context Protocol) para extensibilidade de ferramentas.

## 4. Estratégia de Testes
O foco está na validação dos "Quality Gates". Testes de integração garantem que a FSM bloqueie ações ilegais e que as ferramentas MCP respondam corretamente via STDIO.

## 5. Cérebro Digital
O Obsidian MCP Server permite que a IA interaja com a documentação de forma estruturada, mantendo o histórico de decisões e lições aprendidas em um formato legível por humanos e navegável via grafo.
