---
tags: [be/infra, type/lesson, status/stable]
related_notes: [docs/product/PROJECT_CONFIG.md]
date: 2026-04-23
---

# Quarkus Dev Services e Virtual Threads no Java 21

## 📝 Contexto
Otimização do ambiente de desenvolvimento e performance de execução no backend Quarkus.

## ❌ Problema / Desafio
Complexidade na configuração de bancos de dados locais para desenvolvimento/testes e necessidade de alta escalabilidade sem a complexidade do modelo reativo.

## ✅ Solução Adotada
1.  **Quarkus Dev Services:** Uso extensivo do Dev Services para provisionamento automático de PostgreSQL via Testcontainers (Zero-Config).
2.  **Virtual Threads:** Aproveitamento da ativação inteligente de Virtual Threads pelo Quarkus no Java 21, eliminando a necessidade de gerenciamento manual de pools de threads complexos.

## ⚖️ Impacto e Trade-offs
- **Pró:** Setup de desenvolvimento instantâneo e escalabilidade massiva com modelo de programação imperativo simples.
- **Contra:** Requer Docker instalado no ambiente de desenvolvimento para o Dev Services.
