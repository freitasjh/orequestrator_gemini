---
tags: [be/arch, type/lesson, status/stable]
related_notes: [docs/product/ARCHITECTURE.md]
date: 2026-04-25
---

# Consistência de Estado e Reload de Entidades

## 📝 Contexto
Garantia de integridade em fluxos síncronos com efeitos colaterais no banco de dados.

## ❌ Problema / Desafio
Discrepâncias entre o corpo da resposta da API e o estado real do banco após orquestrações complexas (ex: provisionamento que altera campos da entidade original).

## ✅ Solução Adotada
1.  **Entity Reload:** Realizar obrigatoriamente o `findById` (ou `entityManager.refresh`) da entidade principal antes de mapeá-la para o DTO de retorno.

## ⚖️ Impacto e Trade-offs
- **Pró:** Respostas de API 100% confiáveis e sincronizadas com o banco.
- **Contra:** Uma consulta adicional ao banco de dados por requisição de escrita.
