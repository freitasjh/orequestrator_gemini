---
tags: [be/infra, be/arch, type/lesson, status/stable]
related_notes: [docs/specs/BLUEPRINT_ISSUE_030_TENANT_PROVISIONING.md]
date: 2026-04-25
---

# Multi-tenancy: DDL e Transações no Postgres

## 📝 Contexto
Implementação de isolamento físico (Database-per-Tenant) no PostgreSQL.

## ❌ Problema / Desafio
Comandos DDL como `CREATE DATABASE` não podem ser executados dentro de blocos transacionais no Postgres, causando falhas ao tentar provisionar novos tenants durante o fluxo de cadastro.

## ✅ Solução Adotada
1.  **TransactionHandler:** Uso de um gerenciador para orquestrar a persistência da entidade e o provisionamento de infra.
2.  **Conexão Limpa:** Garantir que o comando DDL ocorra em um contexto de conexão com `autoCommit=true`, fora da transação principal.

## ⚖️ Impacto e Trade-offs
- **Pró:** Provisionamento robusto e automatizado de infraestrutura multi-tenant.
- **Contra:** Risco de inconsistência se a persistência falhar após a criação do banco (exige lógica de compensação/cleanup).
