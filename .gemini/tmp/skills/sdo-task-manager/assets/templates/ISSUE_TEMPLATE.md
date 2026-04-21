# ISSUE_XXX: [NOME_DA_TASK]

## 1. Descrição Técnica
- **Blueprint Original:** `BLUEPRINT_XXX.md`
- **Responsável Sugerido:** [@backend-specialist | @frontend-specialist]
- **Objetivo:** [Descreva o que deve ser feito nesta micro-task específica]

## 2. Arquivos Afetados & Mudanças Sugeridas
- [ ] `src/main/.../File.java`: [Descrição da mudança]
- [ ] `src/main/.../Migration.sql`: [Definição do DDL]
- [ ] `src/ui/.../Component.vue`: [Ajuste de UI]

## 3. Contratos & Tipos (Contexto Direto)
*Copie aqui as interfaces/records relevantes do Blueprint para facilitar a vida do especialista.*
```[Linguagem]
// Ex: public record UserRequest(UUID id, String name) {}
```

## 4. Estratégia de Teste & Validação
- **Teste Unitário:** [Nome da classe de teste e cenários a cobrir]
- **Comando de Execução:** `[Comando para rodar apenas estes testes]`
- **Critério de Sucesso:** [O que deve acontecer para a task ser considerada "Done"]

## 5. Dependências de Código
- Esta task depende de: [Outra ISSUE_XXX que já deve estar pronta]

---
*Instruções para o Especialista:*
1. Implemente a lógica seguindo os padrões da `ARCHITECTURE.md`.
2. O hook `post-construction.sh` validará seu código automaticamente ao salvar.
3. Se houver erro de compilação/teste, corrija antes de pedir revisão.
