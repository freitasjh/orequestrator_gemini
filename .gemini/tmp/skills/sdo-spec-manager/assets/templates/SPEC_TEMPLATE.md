# SPEC_XXX: [NOME_DA_TASK]

## 1. Visão Geral
- **Issue:** #[Número]
- **Objetivo:** [Breve descrição do objetivo da tarefa]
- **Contexto:** [Por que estamos fazendo isso? Quais problemas resolvemos?]

## 2. Requisitos de Negócio (Rules)
*Referência: `docs/product/SYSTEM_SPECIFICATION.md`*

- [ ] [Regra de negócio 1]
- [ ] [Regra de negócio 2]
- [ ] [Idempotência exigida?]

## 3. Arquitetura e Design Técnico
*Referência: `docs/product/ARCHITECTURE.md`*

### 3.1 Backend (Java 21 / Spring Boot)
- **Bounded Context:** [Nome do Módulo]
- **Contratos (DTOs/Records):**
  ```java
  public record FeatureRequest(UUID id, BigDecimal value, String description) {}
  ```
- **Persistência (Database Schema):**
  - **Tabela:** `nome_tabela`
  - **Campos:** [Listar campos, tipos e constraints (UUID v7, NOT NULL, etc.)]
- **Serviços/Use Cases:** [Descrever lógica principal]

### 3.2 Frontend (Vue 3 / TypeScript)
- **Estrutura de Componentes:** [Atomic Design: atoms, molecules, organisms]
- **State Management:** [Local state ou Pinia]
- **TypeScript interfaces:**
  ```typescript
  interface FeatureUI {
      id: string;
      value: number;
      description: string;
  }
  ```
- **UI/UX:** [Descrever fluxo de interação e feedback visual]

## 4. Estratégia de Testes
- **Backend:** [Unitários para Domínio, Integração com Testcontainers para Repository]
- **Frontend:** [Unitários para Componentes, Testes de Integração para Composable]
- **Cenários Críticos:**
  - [Cenário 1]
  - [Cenário 2]

## 5. Critérios de Aceite (Definition of Done)
- [ ] Código 100% tipado (TS) e sem Warnings (Java).
- [ ] Testes unitários com cobertura em lógica de cálculo.
- [ ] Migration Flyway criada (se aplicável).
- [ ] Documentação de API atualizada.
- [ ] Quality Gate aprovado.

---
*Assinado: Software Development Orchestrator*
