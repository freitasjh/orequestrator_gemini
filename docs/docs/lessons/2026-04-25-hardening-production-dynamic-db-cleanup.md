---
tags: [eng/sec, be/infra, type/lesson, status/stable]
related_notes: [docs/product/ARCHITECTURE.md]
date: 2026-04-25
---

# Hardening de Produção e Limpeza Dinâmica de Banco

## 📝 Contexto
Segurança em ambiente de produção e integridade de testes de integração.

## ❌ Problema / Desafio
Vazamento de credenciais locais para produção e riscos de injeção em DDLs dinâmicos durante testes.

## ✅ Solução Adotada
1.  **Proibição de Fallbacks:** Configuração do Quarkus para falhar se credenciais de produção não forem fornecidas via variáveis de ambiente (sem fallback para `application.properties`).
2.  **Sanitização de DDL:** Uso de funções de escape nativas (ex: `quote_ident` no Postgres) ao realizar limpezas dinâmicas de banco em testes.

## ⚖️ Impacto e Trade-offs
- **Pró:** Ambiente de produção mais seguro e testes de integração confiáveis.
- **Contra:** Setup de ambiente de produção exige configuração obrigatória de segredos.
