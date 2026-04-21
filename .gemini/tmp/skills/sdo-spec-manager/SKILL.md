---
name: sdo-spec-manager
description: Gerencia a criação e manutenção de especificações técnicas seguindo o pipeline SDO (Software Development Orchestrator). Use sempre que iniciar a Fase 2 (Especificação) de uma task para gerar o arquivo docs/specs/SPEC_XXX.md com o padrão de arquitetura do projeto (Clean Architecture, Java/Spring, Vue 3).
---

# SDO Spec Manager

## Visão Geral

Esta skill automatiza a criação de especificações técnicas detalhadas, garantindo que todos os documentos sigam o padrão rigoroso do projeto. Ela serve como a base para o desenvolvimento (Fase 5), fornecendo contratos claros de API, esquemas de banco de dados e requisitos de UI.

## Workflow de Especificação

### 1. Coleta de Contexto
Antes de gerar a spec, certifique-se de ter:
- O número da issue (ex: 007).
- Descrição clara do problema ou funcionalidade.
- Verificação de precedentes no código atual (Fase 1).

### 2. Geração da Spec
Utilize o template em `assets/templates/SPEC_TEMPLATE.md` para criar o arquivo em `docs/specs/SPEC_XXX_NOME_DA_TASK.md`.
- **Naming Convention:** `SPEC_[ID]_[SNAKE_CASE_NAME].md`.
- **Preenchimento:** Siga rigorosamente as seções de Backend (Records/DTOs), Frontend (Composition API/TS) e Banco de Dados (UUID v7/Flyway).

### 3. Validação de Consistência
A skill orienta a validação contra:
- `docs/product/ARCHITECTURE.md`: Padrões de código e design.
- `docs/product/SYSTEM_SPECIFICATION.md`: Regras de negócio globais.

## Diretrizes de Escrita

- **Backend:** Defina contratos usando Java Records. Sempre use `BigDecimal` para valores monetários.
- **Frontend:** Descreva componentes baseados em Atomic Design e use TypeScript puro.
- **Segurança:** Identifique chaves de idempotência e regras de isolamento de dados (Multi-tenancy).

## Recursos Bundled

### assets/templates/
- `SPEC_TEMPLATE.md`: O padrão ouro para especificações do projeto.

### references/
- `spec-guidelines.md`: Dicas e exemplos de como preencher cada seção da spec.
