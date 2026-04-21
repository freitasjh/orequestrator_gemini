# Diretrizes para Preenchimento de Especificações (SDO-SDD)

Este documento orienta como preencher cada seção da `SPEC_TEMPLATE.md` e como gerenciar o ciclo de vida da tarefa usando SDD.

## 1. Dashboard de Status (Mandatório)
Toda interação que resulte na criação ou modificação de uma Spec deve encerrar com o seguinte dashboard no chat:

> ### 📊 Dashboard de Status SDO
> - **Issue:** #XXX
> - **Progresso:** `[●●○○○] 40% (Specifying)`
> - **Decisões Chave:**
>   1. [Decisão 1 + Racional]
>   2. [Decisão 2 + Racional]
> - **Top 2 Riscos:** [O que pode dar errado]
> - **Próximo Passo:** [Ex: Avançar para Planejamento]

## 2. Gestão de Dependências e Riscos
- **Depende de:** Liste explicitamente o ID de outras Specs ou Issues que precisam ser finalizadas antes desta.
- **Bloqueios:** Identifique se há falta de clareza em alguma regra de negócio global ou se há limitações técnicas conhecidas.

## 3. Arquitetura e Design Técnico (Rigor SDO)

### 3.1 Backend (Clean Architecture)
- **Records:** Use Java Records para garantir imutabilidade nos DTOs.
- **UUID v7:** Uso obrigatório para novas entidades para facilitar ordenação temporal e segurança.
- **BigDecimal:** Regra de Ouro: Nunca use `double` para dinheiro.

### 3.2 Frontend (Vue 3 / TS)
- **Composition API:** Use `<script setup>` e TypeScript puro.
- **Componentização:** Siga o Atomic Design para garantir reutilização.

## 4. Ciclo de Feedback (Options)
Ao final de cada etapa da Fase 2, apresente ao usuário as opções:
- **[PROCEED]:** Se a Spec estiver 100% clara.
- **[MODIFY]:** Se houver necessidade de ajustes finos.
- **[REGENERATE]:** Se a abordagem arquitetural estiver errada.
- **[EXPLAIN]:** Para detalhar decisões técnicas.
