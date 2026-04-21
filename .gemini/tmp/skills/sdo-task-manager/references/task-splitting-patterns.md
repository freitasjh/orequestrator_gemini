# Padrões de Decomposição de Tarefas (SDO Task-Splitting)

Como transformar um Blueprint em micro-tasks que garantam o fluxo contínuo do pipeline.

## 1. Princípio da Independência (FIRST)
- **Fast:** Devem rodar rápido.
- **Independent:** Minimize dependências entre tasks paralelas.
- **Repeatable:** O resultado deve ser o mesmo em cada rodada.
- **Small:** Foque em 3-5 turnos de modificação de código por task.
- **Testable:** Cada task deve vir com seu teste.

## 2. Padrões de Quebra Recomendados

### Padrão A: Vertical Slice (Fatia Vertical)
- Quebre por funcionalidade. Se o Blueprint tem "Cadastro" e "Edição", crie uma trilha de tasks para Cadastro e outra para Edição.

### Padrão B: Camadas (Layered)
1. **Infra & Domain:** Migrations + Classes de Entidade + Business Logic.
2. **Application & API:** Services + Controllers + DTOs.
3. **UI Base:** Componentes de View (Visuais).
4. **UI Integration:** Stores (Pinia/Redux) + API Clients + Wiring final.

## 3. Gestão do BOARD.md
- Sempre que criar uma `ISSUE_XXX.md`, atualize o `BOARD.md`.
- Use a coluna `Todo` para novas tasks.
- Mova para `Doing` apenas quando o especialista iniciar a Fase 5.

## 4. O Checkpoint (Fase 4 para 5)
- O Orquestrador deve validar se a sequência de tasks faz sentido.
- **Exemplo de Erro:** Pedir para o especialista criar a Controller antes da Entidade de Banco estar definida.
