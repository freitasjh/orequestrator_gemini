# 🏗️ Fase 5: Construção (The Build)

## Objetivo
Implementar o código seguindo as especificações e o plano de tarefas.

## Passo a Passo
1.  **Execução:** Invoque `@backend-specialist` ou `@frontend-specialist` conforme a necessidade da micro-tarefa atual.
2.  **Self-Healing:** Hooks automáticos (`post-construction.sh`) devem ser executados para validar o código salvo.
3.  **Checkpoint:** Se atingir o limite de turnos, gere um `HANDOFF_STATE.md` detalhado e invoque um novo agente para continuar.

## 🛑 BLOCKER
- Não avance se houver falhas de linter ou testes unitários básicos.

## Próximo Passo
Após concluir a implementação de todas as micro-tarefas da issue, avance:
`bash scripts/change-phase.sh 6 <NOME_DA_ISSUE>`
