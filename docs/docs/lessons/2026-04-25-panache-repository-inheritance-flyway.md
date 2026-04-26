---
tags: [be/arch, type/lesson, status/stable]
related_notes: [docs/product/ARCHITECTURE.md]
date: 2026-04-25
---

# Herança em Repositórios Panache e Sincronia Flyway

## 📝 Contexto
Melhores práticas no uso de Hibernate Panache e migrações de banco de dados.

## ❌ Problema / Desafio
Interferência na instrumentação de bytecode do Quarkus e erros de constraint em tempo de execução.

## ✅ Solução Adotada
1.  **Evitar Sobrescrita Desnecessária:** Não sobrescrever métodos base como `findByIdOptional` em Repositórios apenas para chamar o `super`, para não quebrar otimizações do Quarkus.
2.  **Sincronia JPA/Flyway:** Garantir que entidades JPA reflitam exatamente os scripts SQL (Flyway), especialmente constraints NOT NULL.

## ⚖️ Impacto e Trade-offs
- **Pró:** Inicialização mais rápida do Quarkus e redução de erros de persistência em produção.
- **Contra:** Exige atenção redobrada na manutenção manual de scripts SQL e Entidades.
