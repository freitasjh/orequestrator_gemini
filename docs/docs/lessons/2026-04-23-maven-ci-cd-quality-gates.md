---
tags: [eng/ci-cd, type/lesson, status/stable]
related_notes: [docs/product/PROJECT_CONFIG.md, pom.xml]
date: 2026-04-23
---

# Quality Gates e Automação de CI com Maven

## 📝 Contexto
Estabelecimento de padrões de qualidade e automação de build para o projeto.

## ❌ Problema / Desafio
Garantir que o código siga padrões de estilo, mantenha cobertura de testes adequada e não acumule débito técnico desde o primeiro dia.

## ✅ Solução Adotada
1.  **Maven Verify:** Configuração do pipeline de CI para executar `mvn verify`, integrando testes unitários e de integração.
2.  **Checkstyle:** Implementação do Google Style via Checkstyle para padronização de código.
3.  **JaCoCo:** Configuração de gates de cobertura de código com exclusões estratégicas (ex: DTOs, Mappers) para focar no que realmente importa.

## ⚖️ Impacto e Trade-offs
- **Pró:** Feedback rápido sobre a qualidade do código e prevenção de regressões.
- **Contra:** Aumento no tempo de build do CI, mitigado pelo uso de cache e paralelização.
