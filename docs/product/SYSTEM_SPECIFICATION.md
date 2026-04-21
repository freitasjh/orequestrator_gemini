# Especificação do Sistema - Controle Financeiro Pessoal

Este documento descreve as funcionalidades, regras de negócio e visão geral do sistema para orientar o desenvolvimento.

## 1. Objetivo do Produto
Fornecer uma plataforma robusta, segura e auditável para controle de finanças pessoais, focada em precisão bancária e facilidade de uso.

## 2. Requisitos de Negócio (Precisão e Auditoria)

### 2.1 Gestão de Saldos
- O saldo do usuário não é um campo direto; ele deve ser calculado dinamicamente a partir da soma de todas as transações (Créditos - Débitos).
- **Auditabilidade:** Nenhuma transação financeira pode ser apagada ou editada após ser processada; novos lançamentos de estorno devem ser feitos para correções.

### 2.2 Gestão de Categorias e Orçamentos
- Criação de categorias personalizadas por usuário.
- Definição de limites de gastos mensais por categoria com alertas de estouro.

### 2.3 Idempotência em Transações
- Toda operação de escrita financeira deve suportar uma chave de idempotência para evitar duplicidade de lançamentos.

## 3. Requisitos Técnicos Mandatórios

### 3.1 Precisão Monetária
- Uso obrigatório de `BigDecimal` (escala 2) no Backend e `Number` com tratamentos precisos no Frontend. Proibido o uso de tipos de ponto flutuante (float/double) para valores monetários.

### 3.2 Isolamento de Dados (Multi-tenancy)
- Cada usuário deve ter seus dados rigorosamente isolados via `user_id` em todas as tabelas e consultas.

## 4. Estratégia de Desenvolvimento (Pipeline SDD)
O desenvolvimento segue rigorosamente o pipeline definido no `GEMINI.md`:
1.  **Context Analysis**
2.  **Detailed Specification** (Geração de PRDs e Aprovação Humana)
3.  **Detailed Planning** (Aprovação Humana)
4.  **Construction** (Backend e Frontend Specialist)
5.  **Quality Gate** (Code Reviewer e Security Engineer)
6.  **Final Validation** (Orchestrator)

## 5. Critérios de Aceite Gerais
- Código 100% tipado.
- Cobertura de testes unitários em lógica de domínio e cálculos.
- Aprovação pelo Quality Gate (Zero erros críticos apontados).
- Documentação atualizada (ARCHITECTURE.md, ADRs, etc.).
