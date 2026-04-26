# 🧪 Fase 7: Quality Gate e Validação de QA

## Objetivo
Validar funcionalmente a entrega através de testes de integração e E2E.

## Passo a Passo
1.  **QA Testing:** Invoque `@qa-engineer` para realizar rodadas de testes de integração e testes E2E conforme definido na SPEC.
2.  **Validação de Critérios:** O QA deve validar se TODOS os critérios de aceite da Fase 2 foram atendidos.
3.  **Gate:** O hook `quality-gate.sh` deve ser disparado.

## 🛑 BLOCKER
- Falhas de integração forçam o retorno imediato à Fase 5.

## Próximo Passo
Após o "PASS" do QA, avance:
`bash scripts/change-phase.sh 8 <NOME_DA_ISSUE>`
