---
tags: [fe/arch, type/lesson, status/stable]
related_notes: [docs/knowledge/frontend-stack-deep-dive/index.md]
date: 2026-04-24
---

# Diretrizes da Stack Frontend (Vue 3, Composition API)

## 📝 Contexto
Definição de padrões de desenvolvimento para a interface do usuário.

## ❌ Problema / Desafio
Garantir performance, manutenibilidade e conformidade com as métricas modernas de web (Core Web Vitals).

## ✅ Solução Adotada
1.  **Vue 3 Composition API:** Uso obrigatório para melhor organização de lógica e reuso.
2.  **Clean Architecture no Frontend:** Separação clara entre componentes de UI, stores (Pinia) e serviços de API.
3.  **Métricas 2025 (INP):** Foco na métrica Interaction to Next Paint (INP) para garantir responsividade.

## ⚖️ Impacto e Trade-offs
- **Pró:** Aplicação frontend extremamente rápida, modular e fácil de testar.
- **Contra:** Exige disciplina rigorosa na separação de responsabilidades nos componentes.
