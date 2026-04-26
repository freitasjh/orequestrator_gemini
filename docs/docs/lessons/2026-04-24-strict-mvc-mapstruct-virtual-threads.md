---
tags: [be/arch, type/lesson, status/stable]
related_notes: [docs/product/ARCHITECTURE.md]
date: 2026-04-24
---

# Strict MVC, MapStruct e Virtual Threads

## 📝 Contexto
Refinamento da arquitetura backend para desacoplamento e performance.

## ❌ Problema / Desafio
Vazamento de entidades JPA para a camada de API e escolha entre modelos de concorrência.

## ✅ Solução Adotada
1.  **MapStruct:** Uso obrigatório para conversão entre Entidades e DTOs (Records), garantindo desacoplamento total.
2.  **Virtual Threads vs Reativo:** Identificado que a combinação de Virtual Threads com Hibernate ORM clássico é o "sweet spot" para este projeto, evitando a complexidade do modelo reativo puro.

## ⚖️ Impacto e Trade-offs
- **Pró:** Arquitetura limpa e escalável com modelo de programação familiar.
- **Contra:** Aumento do boilerplate inicial devido à necessidade de definições de Mappers.
