---
tags: [be/arch, eng/sec, type/lesson, status/stable]
related_notes: [docs/product/ARCHITECTURE.md]
date: 2026-04-25
---

# SQL Wildcard Injection e Validação de Unicidade

## 📝 Contexto
Segurança em buscas e integridade de dados globais.

## ❌ Problema / Desafio
Vulnerabilidade a 'SQL Wildcard Injection' em filtros LIKE e necessidade de retornos amigáveis para violações de unicidade.

## ✅ Solução Adotada
1.  **Sanitização de Wildcards:** Escapar caracteres `%` e `_` em inputs de busca antes de passar para o banco.
2.  **Validação Dupla:** Garantir unicidade no banco (Unique Constraint) e validar na camada de serviço para retornar `409 Conflict` com mensagem i18n.

## ⚖️ Impacto e Trade-offs
- **Pró:** Proteção contra ataques de negação de serviço via banco e melhor UX em erros de validação.
- **Contra:** Pequeno overhead de processamento de strings no backend.
