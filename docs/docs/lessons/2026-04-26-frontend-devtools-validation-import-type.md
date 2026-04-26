---
tags: [fe/arch, fe/dev, type/lesson, status/stable]
related_notes: [docs/product/PROJECT_CONFIG.md]
date: 2026-04-26
---

# Validação via DevTools e Import Type no Frontend

## 📝 Contexto
Melhores práticas de desenvolvimento e depuração no ecossistema Vue 3 / Vite.

## ❌ Problema / Desafio
Dificuldade em rastrear estados reativos complexos e erros de resolução de módulos em tempo de compilação/execução.

## ✅ Solução Adotada
1.  **Uso Intensivo de DevTools:** Validação constante do estado via Console e aba Network.
2.  **Template Agnóstico:** Remoção de dependências de negócio de componentes de layout (App Shell).
3.  **Import Type:** Uso obrigatório de `import type` para interfaces TypeScript para evitar inclusão de código desnecessário no bundle e erros de resolução circular.

## ⚖️ Impacto e Trade-offs
- **Pró:** Bundle mais leve, depuração mais rápida e arquitetura de componentes mais limpa.
- **Contra:** Exige disciplina no uso correto das sintaxes do TypeScript.
