# Diretrizes para Preenchimento de Especificações (SDO)

Este documento orienta como preencher cada seção da `SPEC_TEMPLATE.md` para garantir a máxima qualidade técnica.

## 1. Visão Geral
- Seja conciso. O objetivo é dar o contexto necessário para que qualquer desenvolvedor entenda o *porquê* da tarefa.
- Se for um bug fix, inclua os passos para reprodução ou o comportamento esperado vs. atual.

## 2. Requisitos de Negócio (Rules)
- Sempre verifique se a nova funcionalidade impacta o `SYSTEM_SPECIFICATION.md`. Se sim, a primeira micro-task deve ser atualizar esse documento global.
- Defina explicitamente se a transação exige idempotência (ex: lançamentos financeiros).

## 3. Arquitetura e Design Técnico

### 3.1 Backend
- **Records:** No Java 21, prefira `records` para DTOs e Requests.
- **BigDecimal:** NUNCA use `double` ou `float` para dinheiro. Use `BigDecimal` com escala 2 e arredondamento `HALF_EVEN`.
- **UUID v7:** É obrigatório para novas PKs para garantir ordenação temporal nativa no banco.

### 3.2 Frontend
- **Atomic Design:** Pense em componentes reutilizáveis.
- **Vanilla CSS:** Evite frameworks que adicionem classes excessivas no HTML. Prefira CSS puro ou CSS Modules.

## 4. Estratégia de Testes
- Foque nos **Edge Cases**. O que acontece se o saldo for zero? E se a API retornar erro?
- **Testcontainers:** Use para testar a integração com o banco real (PostgreSQL).

## 5. Critérios de Aceite
- Devem ser testáveis e claros. "O sistema deve ser rápido" não é um critério. "O tempo de resposta do endpoint X deve ser < 200ms" é um critério.
