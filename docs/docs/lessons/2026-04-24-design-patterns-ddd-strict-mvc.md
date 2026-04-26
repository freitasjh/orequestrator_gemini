---
tags: [be/arch, type/lesson, status/stable]
related_notes: [docs/knowledge/design-patterns-and-ddd/index.md]
date: 2026-04-24
---

# Design Patterns e DDD no Strict MVC

## 📝 Contexto
Aplicação de padrões táticos de Domain-Driven Design no projeto Atlas.

## ❌ Problema / Desafio
Complexidade crescente na lógica de negócio e necessidade de isolar o domínio de detalhes de persistência.

## ✅ Solução Adotada
1.  **Padrão Repository:** Uso do Hibernate Panache com Repositories para abstrair a persistência.
2.  **Agregados e Value Objects:** Identificação e implementação consistente de Agregados para garantir a integridade dos dados.
3.  **Strict MVC:** Reforço do isolamento entre Controller, Service e Repository.

## ⚖️ Impacto e Trade-offs
- **Pró:** Código mais testável, expressivo e alinhado com a linguagem ubíqua do negócio.
- **Contra:** Curva de aprendizado inicial para desenvolvedores não familiarizados com DDD.
