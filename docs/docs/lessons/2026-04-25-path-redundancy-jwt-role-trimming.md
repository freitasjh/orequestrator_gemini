---
tags: [be/arch, eng/sec, type/lesson, status/stable]
related_notes: [docs/product/ARCHITECTURE.md]
date: 2026-04-25
---

# Redundância de @Path e Trimming de Roles em JWT

## 📝 Contexto
Ajustes finos em roteamento JAX-RS e autorização baseada em tokens.

## ❌ Problema / Desafio
URLs imprevistas geradas por redundância de anotações e falhas de autorização silenciosas devido a espaços em branco em roles vindas do banco.

## ✅ Solução Adotada
1.  **Revisão de @Path:** Eliminar redundâncias entre a classe Controller e seus métodos.
2.  **Sanitização de Roles:** Aplicar `trim()` obrigatoriamente ao processar strings de roles para a claim 'groups' do JWT.

## ⚖️ Impacto e Trade-offs
- **Pró:** Roteamento previsível e sistema de autorização robusto.
- **Contra:** Requer atenção aos detalhes durante a implementação de novos controllers.
