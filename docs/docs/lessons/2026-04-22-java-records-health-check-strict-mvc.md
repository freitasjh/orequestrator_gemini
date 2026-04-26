---
tags: [be/arch, type/lesson, status/stable]
related_notes: [docs/product/ARCHITECTURE.md]
date: 2026-04-22
---

# Java Records, Health Checks Stateless e Strict MVC

## 📝 Contexto
Definição de padrões base para o desenvolvimento backend com Java 21 e Quarkus.

## ❌ Problema / Desafio
Redução de boilerplate em DTOs, garantia de resiliência em endpoints de monitoramento e prevenção de vazamento de detalhes de infraestrutura para a API pública.

## ✅ Solução Adotada
1.  **Java Records:** Adoção de Records para DTOs, eliminando a necessidade de Lombok para transporte de dados simples.
2.  **Stateless Health Checks:** Implementação de endpoints de Health Check públicos totalmente stateless para evitar exaustão de recursos e ataques de negação de serviço (DoS).
3.  **Strict MVC:** Aplicação do padrão Strict MVC para garantir que metadados de infraestrutura e entidades JPA não vazem para a camada de apresentação (API).

## ⚖️ Impacto e Trade-offs
- **Pró:** Código mais limpo, seguro e performático. Facilita a manutenção e evolução da API.
- **Contra:** Exige maior rigor na criação de Mappers (MapStruct) para converter Entidades em Records.
