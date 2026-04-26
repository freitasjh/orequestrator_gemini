# 🔄 Fase 4: Criação de Tasks e Backlog (Sync)

## Objetivo
Sincronizar o planejamento com o rastreador de tarefas (Issue Tracker).

## Passo a Passo
1.  **Geração de Issues:** Utilize a skill `sdo-issue-integrator` para criar as tarefas no tracker configurado (`ISSUE_TRACKER`).
2.  **Validação de Produto:** Invoque `@product-strategy-specialist` para revisar as issues criadas, garantindo que atendem aos requisitos de negócio.

## 🛑 BLOCKER
- A fase só termina com o "OK" explícito do Product Specialist.

## Próximo Passo
Com o backlog pronto, avance para a construção:
`bash scripts/change-phase.sh 5 <NOME_DA_ISSUE>`
