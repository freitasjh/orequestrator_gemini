---
tags: [eng/arch, type/lesson, status/stable]
related_notes: [docs/product/ARCHITECTURE.md]
date: 2026-04-24
---

# Modular Monolith First, gRPC e GraphQL

## 📝 Contexto
Estratégia de evolução da arquitetura de sistemas.

## ❌ Problema / Desafio
Evitar a complexidade prematura de microserviços enquanto se prepara para escalabilidade futura.

## ✅ Solução Adotada
1.  **Modular Monolith First:** Abordagem pragmática para reduzir carga cognitiva e custos operacionais iniciais.
2.  **gRPC:** Escolha para comunicações internas eficientes entre módulos.
3.  **GraphQL (BFF):** Uso como agregador para frontends, otimizando as requisições da UI.

## ⚖️ Impacto e Trade-offs
- **Pró:** Desenvolvimento ágil no início com caminho claro para extração de serviços se necessário.
- **Contra:** Exige disciplina rigorosa nos limites dos módulos dentro do monólito.
