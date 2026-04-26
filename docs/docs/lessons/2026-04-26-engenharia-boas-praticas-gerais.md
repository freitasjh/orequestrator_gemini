---
tags: [eng/best-practices, type/lesson, status/stable]
related_notes: [docs/product/PROJECT_CONFIG.md]
date: 2026-04-26
---

# Boas Práticas Gerais de Engenharia e Qualidade

## 📝 Contexto
Definição de diretrizes transversais para garantir a sustentabilidade e a qualidade do software a longo prazo.

## ❌ Problema / Desafio
Acúmulo de débito técnico, regressões frequentes e inconsistência na validação de dados recebidos de fontes externas.

## ✅ Solução Adotada
1.  **Sistematização de Regras:** Converter lições aprendidas em regras automatizadas (Linter, ArchUnit, CI/CD) sempre que possível.
2.  **Auto-Cleanup:** Remover regras textuais após sua automação para reduzir ruído.
3.  **Validação de Inputs:** Nunca confiar em dados do cliente; validar na camada mais externa.
4.  **Testes de Regressão:** Todo bug corrigido deve ser acompanhado de um teste automatizado que previna seu retorno.

## ⚖️ Impacto e Trade-offs
- **Pró:** Sistema mais robusto, previsível e com menor custo de manutenção futura.
- **Contra:** Exige maior investimento de tempo inicial em automação e escrita de testes.
