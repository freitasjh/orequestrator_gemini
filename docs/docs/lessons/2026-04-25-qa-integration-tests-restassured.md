---
tags: [eng/qa, type/lesson, status/stable]
related_notes: [backend/UNIT_TEST_RULES.md]
date: 2026-04-25
---

# Testes de Integração Holísticos com RestAssured

## 📝 Contexto
Estratégia de testes automatizados para validar fatias técnicas completas.

## ❌ Problema / Desafio
Testes que validam apenas a persistência podem deixar passar erros em Mappers, filtros de segurança ou serialização JSON.

## ✅ Solução Adotada
1.  **Priorização de Fluxo via API:** Uso de RestAssured para disparar requisições reais contra o servidor Quarkus em testes de integração.
2.  **Validação de Ponta a Ponta:** Validar desde a segurança (JWT) até o corpo da resposta e o estado final no banco de dados em um único teste.

## ⚖️ Impacto e Trade-offs
- **Pró:** Alta confiança na funcionalidade completa da API.
- **Contra:** Testes ligeiramente mais lentos que testes unitários puros.
