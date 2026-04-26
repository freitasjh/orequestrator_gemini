---
tags: [be/arch, type/lesson, status/stable]
related_notes: [docs/knowledge/backend-stack-deep-dive/index.md]
date: 2026-04-24
---

# Diretrizes da Stack Backend (Quarkus, Java 21)

## 📝 Contexto
Definição de padrões de desenvolvimento para os serviços de backend.

## ❌ Problema / Desafio
Maximizar o throughput e a observabilidade do sistema utilizando as capacidades mais recentes da JVM e do Quarkus.

## ✅ Solução Adotada
1.  **Virtual Threads:** Uso nativo para processamento concorrente eficiente.
2.  **Hibernate Panache Repository:** Padronização do acesso a dados.
3.  **OpenTelemetry:** Integração nativa para rastreamento distribuído e métricas.

## ⚖️ Impacto e Trade-offs
- **Pró:** Sistema altamente escalável com baixo consumo de memória e excelente visibilidade operacional.
- **Contra:** Necessidade de monitorar o comportamento das Virtual Threads em cenários de pinning.
