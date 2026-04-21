---
name: sdo-task-manager
description: Gerencia a decomposição de Blueprints técnicos (Fase 2) em micro-tarefas granulares (Fase 3 e 4) seguindo o pipeline SDO. Esta skill garante que cada issue contenha detalhes técnicos, arquivos afetados e critérios de verificação para o time de construção (Fase 5).
---

# SDO Task Manager (Micro-Tasking Framework)

## Visão Geral
Esta skill transforma uma especificação robusta em um plano de ação executável. O objetivo é reduzir a carga cognitiva dos especialistas (Backend/Frontend), fornecendo um roteiro passo-a-passo onde cada tarefa pode ser concluída em 3 a 5 turnos.

## Workflow de Planejamento (Fase 3 e 4)

### 1. Decomposição Técnica (Micro-Tasking)
Ao ler um `BLUEPRINT_XXX.md`, a skill orienta a quebra em:
- **Tasks de Infra/Schema:** Migrations, DDLs, Configurações.
- **Tasks de Backend (Domain/Logic):** Records, Services, Use Cases, Unit Tests.
- **Tasks de Backend (API/Controller):** Endpoints, DTOs, Integração.
- **Tasks de Frontend (Base/UI):** Componentes (Atoms/Molecules), Styles.
- **Tasks de Frontend (State/Logic):** Pinia/Stores, Services, API Client.
- **Tasks de Integração Final:** Wiring, QA, Validação de BDD.

### 2. Geração de Issues
Utilize o template em `assets/templates/ISSUE_TEMPLATE.md` para criar os arquivos em `docs/backlog/ISSUE_XXX.md`.
- **Naming Convention:** `ISSUE_[ID]_[SNAKE_CASE_NAME].md`.
- **Board Management:** Adicione a issue ao arquivo `docs/backlog/BOARD.md` no status correspondente.

### 3. Dashboard de Planejamento
Toda criação de backlog deve encerrar com um resumo de planejamento:
- **Total de Tasks:** [Quantidade]
- **Sequência de Implementação:** [Ordem recomendada]
- **Complexidade Estimada:** [Baixa | Média | Alta]

## Diretrizes de Escrita de Tasks
- **Atomicidade:** Uma task deve fazer apenas uma coisa (ex: "Criar Migration e Model", "Implementar Endpoint de Cadastro").
- **Instruções Técnicas:** Liste explicitamente as classes/arquivos que serão criados ou modificados.
- **Verificabilidade:** Cada task DEVE ter uma seção de "Comando de Validação" (ex: `npm run test`, `mvn test`).

## Recursos Bundled

### assets/templates/
- `ISSUE_TEMPLATE.md`: Template robusto para tarefas técnicas.

### references/
- `task-splitting-patterns.md`: Padrões de como quebrar funcionalidades complexas.
