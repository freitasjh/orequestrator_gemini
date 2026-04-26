---
tags: [eng/arch, fe/ux, type/lesson, status/stable]
related_notes: [docs/product/SYSTEM_SPECIFICATION.md]
date: 2026-04-24
---

# UX Diferenciada: Backoffice vs Control Panel

## 📝 Contexto
Design de interfaces para diferentes perfis de usuários do sistema Atlas.

## ❌ Problema / Desafio
Interfaces genéricas que não atendem nem à eficiência necessária para o staff interno (Backoffice) nem à simplicidade/autonomia desejada pelos clientes (Control Panel).

## ✅ Solução Adotada
1.  **Backoffice:** Foco em densidade de informação, atalhos de teclado e eficiência operacional.
2.  **Control Panel:** Foco em clareza, onboarding e entrega de valor imediato.
3.  **RBAC Granular:** Implementação de controle de acesso baseado em permissões específicas em vez de papéis hierárquicos rígidos.

## ⚖️ Impacto e Trade-offs
- **Pró:** Maior satisfação do usuário final e redução de erros operacionais.
- **Contra:** Maior esforço inicial de design e implementação de permissões granulares.
