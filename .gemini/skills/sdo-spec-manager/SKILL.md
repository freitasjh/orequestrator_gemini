---
name: sdo-spec-manager
description: Gerencia o ciclo de vida de especificações robustas (Enterprise Grade) seguindo o framework SDD do Orchestrator. Esta skill coordena a criação de Blueprints Técnicos que incluem BDD, Modelagem de Dados, Segurança e Observabilidade, adaptando-se a qualquer stack definida no projeto.
---

# SDO Robust Spec Manager

## Visão Geral
Esta skill transforma a Fase 2 (Especificação) em um processo de engenharia rigoroso. Uma SPEC não é um documento estático, mas um contrato vivo que guia do desenvolvimento à validação final.

## Workflow de Engenharia de Especificação

### 1. Elaboração do Blueprint (Draft)
O Orquestrador gera a versão inicial da SPEC focando em:
- **Funcional:** User Stories em formato BDD.
- **Técnico:** Contratos de interface e modelos de dados.

### 2. Ciclo de Auditoria (Audit Loop)
Antes de apresentar ao usuário, o Orquestrador deve simular (ou invocar) revisões internas:
- **Audit Architect:** A estrutura de dados respeita a `ARCHITECTURE.md`?
- **Audit Security:** Há riscos de IDOR ou Injeção? Como é o isolamento de dados?
- **Audit Quality:** Os critérios de aceite são testáveis e cobrem edge cases?

### 3. Dashboard de Robustez
Toda Spec deve vir acompanhada de um dashboard que avalia a densidade técnica:
- **Cobertura BDD:** [Alta | Média | Baixa]
- **Densidade de Dados:** [Esquema definido | Pendente]
- **Resiliência:** [Matriz de erros definida | Pendente]

## Seções Mandatórias da SPEC Robusta
1. **User Stories & BDD Scenarios:** Comportamento esperado.
2. **Data & Persistence Architecture:** Constraints e políticas de integridade.
3. **API & Integration Contracts:** Assinaturas e status codes.
4. **Error Handling Matrix:** Mapeamento de exceções.
5. **Security & Observability Baselines:** Permissões e Logs.

## Diretrizes de Escrita
- **Agnosticismo de Stack:** Use termos técnicos universais (ex: "Idempotência", "Isolamento") e exemplifique na linguagem do `PROJECT_CONFIG.md`.
- **Nível de Detalhe:** Se um desenvolvedor júnior ler a SPEC, ele deve saber *exatamente* o que construir sem fazer perguntas.
