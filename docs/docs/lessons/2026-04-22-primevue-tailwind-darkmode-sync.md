---
tags: [fe/ui, type/lesson, status/stable]
related_notes: [docs/product/PROJECT_CONFIG.md, docs/specs/BLUEPRINT_FRONTEND_DESIGN_SYSTEM.md]
date: 2026-04-22
---

# Sincronização de Tema com PrimeVue 4 e Tailwind

## 📝 Contexto
Implementação do sistema de temas (Dark Mode) utilizando PrimeVue 4 e Tailwind CSS no frontend Vue 3.

## ❌ Problema / Desafio
A integração entre PrimeVue e Tailwind exige uma configuração precisa do seletor de modo escuro para evitar inconsistências visuais onde componentes de uma biblioteca não respeitam o estado da outra. Além disso, a transição abrupta de tema prejudica a experiência do usuário.

## ✅ Solução Adotada
1.  **Configuração do Seletor:** Utilização do `darkModeSelector` (ex: '.app-dark') em ambas as bibliotecas para garantir sincronia total.
2.  **View Transitions API:** Implementação do toggle de tema utilizando a View Transitions API, proporcionando uma transição suave e moderna com baixo esforço de código.

## ⚖️ Impacto e Trade-offs
- **Pró:** Experiência de usuário (UX) superior e consistência visual garantida entre componentes PrimeVue e classes utilitárias Tailwind.
- **Contra:** Dependência de navegadores modernos para suporte total à View Transitions API (com fallback automático para transição instantânea).
